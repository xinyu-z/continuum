##Dec21 vowel continuum: /ɪ/- /ɛ/

#reading in the recordings
vowelI= Read from file: "pit.wav"
vowelE= Read from file: "pet.wav"

#resampling
selectObject: vowelI 
vowel_resI = Resample... 10000 50 ;male voice
Scale peak... 0.99

selectObject:  vowelE
vowel_resE = Resample... 10000 50 ;male voice
Scale peak... 0.99

#defining continuum endpoints in Hz
#/ɛ/ values:
f1E = 616
f2E = 1860
f3E = 2730

#/ɪ/ values:
f1I = 400
f2I = 2000
f3I = 2650

#calculate distance between endpoints:
dif_f1 = f1E - f1I
dif_f2 = f2E - f2I
dif_f3 = f3E - f3I

#taking formant frequencies from the vowel ɛ
selectObject: vowelE
vowel_lpc = To LPC (autocorrelation): 10, 0.025, 0.005, 50
#reverse filtering to get the source:
selectObject: vowelE
plus vowel_lpc
Filter (inverse)
Rename... vowel_sourceE

#refilter loop:
for i from 1 to 10
#get formants of the original vowel
selectObject: vowelE
formant_id = To Formant (burg): 0, 5, 5000, 0.015, 50
selectObject: formant_id
#defining values for each step
Formula (frequencies): "if row=1 then self-((dif_f1/9)*(i-1)) else self fi"
Formula (frequencies): "if row=2 then self-((dif_f2/9)*(i-1)) else self fi"
Formula (frequencies): "if row=3 then self-((dif_f3/9)*(i-1)) else self fi"

#combine source and filter
selectObject: "Sound vowel_sourceE"
plus formant_id
Filter
selectObject: "Sound vowel_sourceE_filt"
Rename... token'i'
Resample... 44000 50
endfor
