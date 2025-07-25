Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D38C87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 17:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38659839D5;
	Fri, 25 Jul 2025 19:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VnV1D5/7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF7F839D6; Fri, 25 Jul 2025 19:12:07 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D2A4839CF
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 19:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PAXau1000784
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 17:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HygVCEj/p7BrJlzxgbf/8T29wQTRMD2yM9z2GJs0K5c=; b=VnV1D5/7kdbPasf3
 0i3WTWV7BUWxPMFsWZTUrptxlmg6Ya1c6Cu9+R/LguWb2UXtO73Je34XEOIg4y+i
 21/q0wzFhBuoykeRLTlUzsy9GvrwLWnwbxcQl7z4lL2zNRGpyJ02Wulp0uYozxrP
 JyyJU+jP9EeWl7nZ/ph6ZV8bX68MeQ4vqSpm2cWrPh0DvFmiTBec/aYiuD1X2eWd
 yK+Ra3fEtHsRIXVEwv1+Yj/K2vBO0reurJrVfMKluoEfNQ8MHw1XAgSsGRJz3Xxk
 qHbG5BYfI8Hili2zLg0QC7MoPQXzW8RuXifGrgBlemuIhm0DXICU1sU7HsP67LHX
 0rAxEw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48489713fv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 17:12:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-313ff01d2a6so2498722a91.3
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 10:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753463521; x=1754068321;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HygVCEj/p7BrJlzxgbf/8T29wQTRMD2yM9z2GJs0K5c=;
 b=eHNzw5rvfEshBV+maA0i0/NpHuGyGDW3FcKEnHiKfxLK0LpNZ/kI18jHIS5/lAAlyq
 7U1TFN0tk2++PcGTRucyAZQXJz6mYjxixrwGoLNdty2HwY/PaHvSfjVxaQN8MM4Y0m7S
 rHbnIYcvq/XBBZmwvT/alrsEiTwOUwPd0vjv13cAE5zu9eGRLl0N3XDcGW3gkfuiCd3V
 gvoCqcVshBCpGjNpjhVFcFACRzBRMvba2NJDyczo2Ppzi3vMBRs03fzfeRjOeF3E6bea
 eCRuaaLG+fzf32+MBMSdKkTUXsYyO0xHdYtNruThxwR5DvSoDcM7dlUISbMkESupvooJ
 6R0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg2NTSs8idqFL7DBZ4lm69nJPJpAB4wWjMD7YgQfHUtwt5BBYKYr28asyHvDPicGO2zr+F7eY=@lists.denx.de
X-Gm-Message-State: AOJu0YyeGtaRikhm8YVqUmYiWOhNK/+T/Nqjc4yLxlRTKPN05U0ngvIA
 C3BaRDjtG9qqwr8WqEzIY4yHBUb2uOlzZKwIaTuQXJAoywLgbXs8j68Z8JG1bCKgOA+RLkykmP4
 fRnVyY2gBqz246BdN061uWdD/nRydR0/tQKpIg4fK5VNnhXYMA52nDDJoSdwdKw2r
X-Gm-Gg: ASbGnctKfIkRwA7mMj2NHEdtACLkkyAjXOUWKTd3klTe17i9GlSz0atfvdw0ROPRORJ
 hlvHN/CkoUHyERQzJkC18Ew37C99/jdytMcT2zcPct1WJmTUDAQ+YOfh9r+SKv1t7nKEUiJqgTb
 dACebx3KB4qs7NMTdIIjcYYpqPv2YubIikyizkdDepuZgeAFO44BS017zBKT0dLRhE866im+EQV
 FJocXtTeuIVIRCBUXdUmOKS9v55n1qqhSCO181pMrpSsabMkoUDFC8SWnvYshVnOU5ELFDrNIEN
 CmIFVOPMd6pYMAIyfIQnBZJsmdngKfdf1lOgvHi7f/hXxHYx57Hr1kKeP8EJEdeGpdQ=
X-Received: by 2002:a17:90b:1f82:b0:313:d346:f347 with SMTP id
 98e67ed59e1d1-31e77a4595fmr3774512a91.35.1753463521436; 
 Fri, 25 Jul 2025 10:12:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGozs44DXor77IA6v7H5rH5VPJhwtaZoxQMZyX3urVLWwtu+Y8tazslCaLtGIkZjo5jaSgiQA==
X-Received: by 2002:a17:90b:1f82:b0:313:d346:f347 with SMTP id
 98e67ed59e1d1-31e77a4595fmr3774474a91.35.1753463520860; 
 Fri, 25 Jul 2025 10:12:00 -0700 (PDT)
Received: from [192.168.1.3] ([223.178.85.118])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e83508500sm121935a91.22.2025.07.25.10.11.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 10:12:00 -0700 (PDT)
Message-ID: <306cb986-34ed-4c17-94be-ded25800451f@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 22:41:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] efi_loader: Remove authentication header in efi
 variable data
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: ilias.apalodimas@linaro.org, trini@konsulko.com, kettenis@openbsd.org,
 u-boot@lists.denx.de
References: <20250725123653.513252-1-aswin.murugan@oss.qualcomm.com>
 <d387c730-9d9d-49b6-9775-da5e69023a87@gmx.de>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <d387c730-9d9d-49b6-9775-da5e69023a87@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9tEwlnQIMGXrywasBDaTJPRXrbe6LfCP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE0NyBTYWx0ZWRfX/pqc3nfi4yZS
 9sM4MNHVLpRiyPEYisUERaVlGlZ9vVFQJHgWw05hWPirLFJKeTPhPU26Z0zWMYtjZEgr7IvexG3
 BT/Enpz4L793LdapD8Z45GLzQbEYuEfvkF70Igbq7jdqz6Aku76sCnsLgnDYFRBvTGMmles6+44
 hkzCXT2x34ZLFkmRlSuRzubPixC6YSV8dcibotjY5o/lI+b+UIRIcErG9QgoJoARfVjGi+Q2P4V
 +9b75VcwXcuEbeaoZ46UMzdNHaWpOXbAqjo9BbMpGRC9LtJ9YfCbC67ZYZQ3HebRcdHWl2bwNxQ
 GLqldLF8n1dO7jvxvDFRn21KTws/OPuHAzh5FmsaQlO0QKEHMf/yvNIWMB/+BTt7vtaBHzLeXH9
 0UwEQd5y2DB50lvB9/w0psLrYzohCYvkVi58n5JsRku6CHkzN2IX8jmU+efNYiLBI20tPgQ2
X-Authority-Analysis: v=2.4 cv=VJjdn8PX c=1 sm=1 tr=0 ts=6883bae3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=4Z0N7fgVbAaKUD7rZNXfww==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=YfCOm-DyAAAA:8 a=EUspDBNiAAAA:8
 a=WZNsmSi8g9YvzsU7_bIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=zQLMK8awuJ6_Hvp-_9Ux:22
X-Proofpoint-ORIG-GUID: 9tEwlnQIMGXrywasBDaTJPRXrbe6LfCP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507250147
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


On 7/25/2025 6:56 PM, Heinrich Schuchardt wrote:
> On 25.07.25 14:36, Aswin Murugan wrote:
>> efi_get_variable_mem() returned auth header along with ESL data for
>> authenticated variables like PK, KEK, and DB. This caused issues in
>> later stages where the auth header was misinterpreted as ESL data,
>
> Which later stages are you relating to?
> In the current implementation of efi_signature_store()
> https://source.denx.de/u-boot/u-boot/-/blob/master/lib/efi_loader/efi_signature.c#L809,
> the db variable is retrieved using efi_get_var() and passed directly to
> efi_build_signature_store(). However, for authenticated variables, the 
> data
> returned by efi_get_var() includes the authentication header.
> efi_build_signature_store() expects the data pointer to begin at the start
> of the EFI Signature List, not the authentication header. This 
> mismatch leads
> to a parsing error, as the header is misinterpreted as part of the 
> signature
> list, resulting in an invalid signature list format.
>
> How can the error be reproduced?
> Created the ubootefi.var through tools/efivar.py and enabled 
> EFI_VARIABLES_PRESEED for secure boot,
> during image authentication, wrong siglist format error was observed.
>
>> leading to parsing failures, the efi_get_variable_mem() is expected
>> to return esl data alone.
>> Added a check to remove the auth header if the variable has the
>> EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS attribute. Now,
>> only the ESL data is returned from the function.
>
> Please, have a look at chapter 8.2.1 GetVariable in the UEFI spec.
>
> When the attribute EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS is set, 
> the Data buffer shall be interpreted as follows:
> // NOTE: “||” indicates concatenation.
> // Example: EFI_VARIABLE_AUTHENTICATION_3_TIMESTAMP_TYPE
> EFI_VARIABLE_AUTHENTICATION_3 || EFI_TIME || 
> EFI_VARIABLE_AUTHENTICATION_3_CERT_ID || Data
> // Example: EFI_VARIABLE_AUTHENTICATION_3_NONCE_TYPE
> EFI_VARIABLE_AUTHENTICATION_3 || EFI_VARIABLE_AUTHENTICATION_3_NONCE 
> || EFI_VARIABLE_AUTHENTICATION_3_CERT_ID || Data
>
> Isn't removing the authentication header violating the EFI specification?
> I belive that stripping the auth header during variable read might not 
> violate the spec.
>
> Is tests/test_efi_secboot/test_authvar.py still passing with your patch?
> Yes, it passed
>>
>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>> ---
>>   lib/efi_loader/efi_var_mem.c | 42 +++++++++++++++++++++++++++++-------
>>   1 file changed, 34 insertions(+), 8 deletions(-)
>>
>> diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
>> index 31180df9e3a..f73daf8bdc9 100644
>> --- a/lib/efi_loader/efi_var_mem.c
>> +++ b/lib/efi_loader/efi_var_mem.c
>> @@ -309,9 +309,12 @@ efi_get_variable_mem(const u16 *variable_name, 
>> const efi_guid_t *vendor,
>>                u32 *attributes, efi_uintn_t *data_size, void *data,
>>                u64 *timep, u32 mask)
>>   {
>> -    efi_uintn_t old_size;
>> +    efi_uintn_t old_size, var_data_size, auth_size;
>>       struct efi_var_entry *var;
>>       u16 *pdata;
>> +    void *var_data;
>> +    struct efi_time *timestamp;
>> +    struct win_certificate_uefi_guid *cert;
>
> Please, move variable definitions to the innermost code block where 
> they are used.
>
> Best regards
>
> Heinrich
>
>>         if (!variable_name || !vendor || !data_size)
>>           return EFI_INVALID_PARAMETER;
>> @@ -335,19 +338,42 @@ efi_get_variable_mem(const u16 *variable_name, 
>> const efi_guid_t *vendor,
>>       if (!u16_strcmp(variable_name, vtf))
>>           return efi_var_collect_mem(data, data_size, 
>> EFI_VARIABLE_NON_VOLATILE);
>>   +    for (pdata = var->name; *pdata; ++pdata)
>> +        ;
>> +    ++pdata;
>> +
>> +    var_data = (void *)pdata;
>> +    var_data_size = var->length;
>> +
>> +    /* Handle EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS */
>> +    if (var->attr & 
>> EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS) {
>> +        if (var_data_size > sizeof(struct efi_time)) {
>> +            timestamp = (struct efi_time *)var_data;
>> +            cert = (struct win_certificate_uefi_guid *)(timestamp + 1);
>> +            auth_size = sizeof(struct efi_time) + cert->hdr.dwLength;
>> +            if (var_data_size > auth_size) {
>> +                var_data = (u8 *)var_data + auth_size;
>> +                var_data_size -= auth_size;
>> +            }
>> +        }
>> +    }
>> +    /*
>> +     * EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS type is old & not
>> +     * expected for auth variables
>> +     */
>> +    else if (var->attr & EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS)
>> +        return EFI_INVALID_PARAMETER;
>> +
>>       old_size = *data_size;
>> -    *data_size = var->length;
>> -    if (old_size < var->length)
>> +    *data_size = var_data_size;
>> +
>> +    if (old_size < var_data_size)
>>           return EFI_BUFFER_TOO_SMALL;
>>         if (!data)
>>           return EFI_INVALID_PARAMETER;
>>   -    for (pdata = var->name; *pdata; ++pdata)
>> -        ;
>> -    ++pdata;
>> -
>> -    efi_memcpy_runtime(data, pdata, var->length);
>> +    efi_memcpy_runtime(data, var_data, var_data_size);
>>         return EFI_SUCCESS;
>>   }
>
