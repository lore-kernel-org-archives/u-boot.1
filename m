Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B94CD4F39
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 11:01:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3706A845E3;
	Thu, 14 May 2026 13:01:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="osaOwtbi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DejY/pc4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DF808464D; Thu, 14 May 2026 13:01:20 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47C2483FF5
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 13:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64E9juQ12463964
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 11:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +u8W2LHyb0VWr/NPR4g5LzQVBpe8+9fsOqqWivY9ydc=; b=osaOwtbicHztvUBE
 fR+u2j6Z0dmZ3lMkyTuKdtIzeBDWJDVKoQGGG3r0wpEWWx9gr7pVTFYX3P2Ghx8L
 TS3okffHMTtf51yJGepmzs1VLIkowIYedRfj9cchyfVaC+bErcIvsoGdQCdGJluq
 Vc0uoKlQeIB2oFB8gM/xoTyucDvF9iqDPihMG9+LvWFt4Z9go+bK3OueDTv+RmZi
 vZxquAEg4Kf5fYRknzi5tzurpkaX1Hfv3n357phxiObJBR1gCJ7TAiZgb1MUs9CQ
 cALaJWRJhxibHXTCWUvPNfYulTxOU209zeFNtfuG5LXB+4tg7rmBYCm1D9h9d4Nh
 57KqHQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e58v8904c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 11:01:14 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3662668b825so1620256a91.3
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 04:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778756474; x=1779361274; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+u8W2LHyb0VWr/NPR4g5LzQVBpe8+9fsOqqWivY9ydc=;
 b=DejY/pc4n2EP7jep3szPWnIkDDkLGRcqB6yBVGsLxwXqDJO2Qc5yL0fGcKi6smI7AY
 +lPKkyt5tjlLS7p8V3JZV/K/DxCw174zFPHejdrJJ8U6yW1wDkF1Q386XxuiBpbHcuq2
 7lDhWF7depsZeYSHcN7ykwM/xyhaekBJJxOUq4e4it+PJX+nJXeQbmNjtCN9yiz2X85S
 A8itv5l/4SakpMWr8cuwpF2n+xuHc5JgJwucjXSvbtHIh9Sd7cfGvRTzIe2N/keUT8Qk
 QFeOrvq6B4vDCa4hPLCKerK48u4nRY2HIyTrLSYOhCZ6IFq3EURbWZpObK9VQNg6clzm
 miWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778756474; x=1779361274;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+u8W2LHyb0VWr/NPR4g5LzQVBpe8+9fsOqqWivY9ydc=;
 b=LYfQzq5nmDapa5ScQjRjzK1NgAr+Rw+7Pm/K6v4XtAhnlLYMCfcmjo8mhRMlBHGxi7
 929k8LQIC35/TvmSO3Nx7yyFi39dLioV1q1xcZGUBKPN6IOrK69S/kgmLmyzixP6Pe7B
 3HLLK5rYjTUeK8JuS+BrKUrLfR2GSQtj/s/e9VSdU8Mgy4ql99aeUmHPddDcRFgxJZ+H
 Xx+eZVi8WEDcxxNwMP6TBOCWCbKNMNvAKBA9OTTWdU6UxPk7ahQJ6j5sHVRx1LRVelyz
 479pG9tBL9K8eESZXjmckm1s+SGh/YR/rKWdrqO2o0xJEs9J5rExkwJTOuskQQ3q09kz
 A9NQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8CAtI9A8y7Ms5zgCD5kyz03eMVd3NAfOc/sxdusLUAVZS/Dx0alN5960Ft8kTtaeTMbT0aOKk=@lists.denx.de
X-Gm-Message-State: AOJu0YwqufFkp4+yrdphat6Z2LdFdcTOibE4ekl5joNWuTilqQoMfMAk
 YELNOt01FnID8XMkIOY2U3junFOsH0WYBXPsNvjT54EvjegqzutBe3kp/HgQpJawe/1UYxnCsU9
 tsntf9W3SbPOtJY1BIHL4fO+cJ2+yvrwRRsigrCmH2JUmltJTv5tBBYuc
X-Gm-Gg: Acq92OFoUVSkYcopvdpQeVWMlqOi6FjdNsDOm1BLzP268WsHkdUhQtGltZJJ5MRzpdo
 HAu1BBwfhJLmwU0gTqSSxFrVZBAKMnCjy5HGqeqkoPruKyF+piyINb2JR+mlUNvQr2+zJxDwL1g
 RBXkAsukvAVlIddR+dPGD11NCktIwFnY5TtIiuNqzkqmuJcdFMkyAK8jAR3XErl1ciAV0e/ICtY
 hnLQf8iBptlWst+F7XDhzbpF85cGbuVXPagWAqCshPhoq+JZnFHEhcv2DyRs/OMkgeRENUeiu+n
 cbd1QHM+ycTzk7HiXlQ66KtfNQmn88keo6gRDudEaoz9or2aYSBm0NFyPXR5MG0VMB1N6NmBJZ7
 5XqTOafVNkLOPYC8PTm6rVLHwDrysF+hy71mYat9xay72iK905yi3dg==
X-Received: by 2002:a17:90b:524f:b0:366:469d:98ec with SMTP id
 98e67ed59e1d1-368f799454bmr6918086a91.13.1778756473365; 
 Thu, 14 May 2026 04:01:13 -0700 (PDT)
X-Received: by 2002:a17:90b:524f:b0:366:469d:98ec with SMTP id
 98e67ed59e1d1-368f799454bmr6918026a91.13.1778756472712; 
 Thu, 14 May 2026 04:01:12 -0700 (PDT)
Received: from [10.152.202.155] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3692f6c0b3dsm2765890a91.17.2026.05.14.04.01.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 04:01:12 -0700 (PDT)
Message-ID: <12a09e02-3093-47a6-850b-3be4e63b1ccb@oss.qualcomm.com>
Date: Thu, 14 May 2026 16:31:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] efi_loader: Remove authentication header in
 GetVariable()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com, michal.simek@amd.com,
 u-boot@lists.denx.de
References: <20260512194205.1905069-1-aswin.murugan@oss.qualcomm.com>
 <CAC_iWj+tD8eOKxem3m94BWX42GTLuCD7tqEW0GUdtsPLpLcYqw@mail.gmail.com>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <CAC_iWj+tD8eOKxem3m94BWX42GTLuCD7tqEW0GUdtsPLpLcYqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDExMCBTYWx0ZWRfXz6nc3lbpNYLR
 GjwuyFZ4DsRpggMT46Qn1iHMWXMkOe+J9AJc5AZ9YVgYuXemmaTZ8WmCPBH+VZtafvHAVycfZCg
 +EFa5KqiNnZkA+gF+aL9F6v1k8dKYVYW/vT5ruK+s5DXT6i6Ur68MVwn5NG/Rnm7L3ZV6FP95hT
 WtobxoUBTVdh2tPU9gDn0kB+SDvIjlW8oSV4zcmBvOOguQZNYtoFdbDUqdE7VCbhoQZJU1lI1Uk
 3X6I7GqXAY4hY4PgtpkKtXmR+soXlWu+hDfSnZ8TdG3XsE0v8I5N/jSz1lkoGDXx/55XOd3kinq
 iab3UpZ9/kPbNm5RLMGGS75V4R6n/7NbByCQKIC5h7/7QQDf2vXOW68G5gKhl/MgwRGoePZvzAc
 WVbkHG1d/oFrsUYOw/slXZvxYuE1H7jBgLMt1ZrvPt0vsa3gCh4ZzJx9ve3Aj0EY1e1OOrwZxs1
 D8swuulCJTnFLhTEceQ==
X-Proofpoint-GUID: DHnyiPpqWMx_SOs--larthRi2WAPTJUs
X-Authority-Analysis: v=2.4 cv=YZSNIQRf c=1 sm=1 tr=0 ts=6a05ab7a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=YfCOm-DyAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nWtspN7S-eFQwIbtepkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=zQLMK8awuJ6_Hvp-_9Ux:22
X-Proofpoint-ORIG-GUID: DHnyiPpqWMx_SOs--larthRi2WAPTJUs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140110
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

Hi Ilias,

We are attempting to pre-seed ubootefi.var created using the *efivar.py* 
tool for authenticated EFI variables.
Currently, efivar.py writes variables including the full authentication 
descriptor (timestamp + WIN_CERTIFICATE + payload) into ubootefi.var.

As per the CI tests shared, it stores the authenticated EFI variables 
using setenv
When authenticated variables are set via U‑Boot using setenv -e -at, the 
flow goes through SetVariable(), where the firmware:

  * parses and validates the authentication descriptor
  * removes the authentication header
  * stores only the variable payload


Due to this mismatch, variables created with efivar.py differ from those 
created via U‑Boot:

GetVariable() returns descriptor + payload instead of payload-only, this 
leads to inconsistent and non‑compliant variable behavior

Fix Proposed:

Strip the authentication descriptor within efivar.py during variable 
write, so that only the payload is stored in ubootefi.var, matching 
U‑Boot SetVariable() behavior. Please confirm if there are any concerns 
with this approach.

Regards,
Aswin

On 5/13/2026 11:54 AM, Ilias Apalodimas wrote:
> Hi Aswin,
>
> On Tue, 12 May 2026 at 22:42, Aswin Murugan
> <aswin.murugan@oss.qualcomm.com> wrote:
>> Currently, efi_get_variable_mem() returns the raw stored format for
>> authenticated variables, which includes the EFI_VARIABLE_AUTHENTICATION_2
>> descriptor . This causes image authentication failures when reading
>> secure boot variables as callers receive wrong data containing
>> authentication headers instead of the actual variable payload.
> What are 'the callers'? The EFI security related variables are usually
> read and consumed by the firmware itself during secure boot. I don't
> remember the code on top of my head, but i think we end up storing the
> auth info because it also contains timestamps etc.
>
>> The UEFI Specification Section 8.2.6(EFI_VARIABLE_AUTHENTICATION_2 descriptor)
>> explicitly states:
>> "The authentication descriptor is not part of the variable data and is
>> not returned by subsequent calls to GetVariable()."
> We can strip the headers during GetVariable, but you need more changes
> apart from the one here. The EFI secure boot tests fail with the
> change above [1].
>
>> This patch implements spec-compliant behavior by detecting variables with
>> the EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS attribute and
>> stripping the authentication descriptor before returning data to callers.
> [1] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/30086
>
> Regards
> /Ilias
>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Enhanced commit message with explicit UEFI spec reference
>> Link to v1: https://lore.kernel.org/u-boot/20250725123653.513252-1-aswin.murugan@oss.qualcomm.com/
>> ---
>>   lib/efi_loader/efi_var_mem.c | 44 +++++++++++++++++++++++++++++-------
>>   1 file changed, 36 insertions(+), 8 deletions(-)
>>
>> diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
>> index 8d5f99f4870..edf4522e51f 100644
>> --- a/lib/efi_loader/efi_var_mem.c
>> +++ b/lib/efi_loader/efi_var_mem.c
>> @@ -336,9 +336,10 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
>>                       u32 *attributes, efi_uintn_t *data_size, void *data,
>>                       u64 *timep, u32 mask)
>>   {
>> -       efi_uintn_t old_size;
>> +       efi_uintn_t old_size, var_data_size;
>>          struct efi_var_entry *var;
>>          u16 *pdata;
>> +       void *var_data;
>>
>>          if (!variable_name || !vendor || !data_size)
>>                  return EFI_INVALID_PARAMETER;
>> @@ -362,19 +363,46 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
>>          if (!u16_strcmp(variable_name, vtf))
>>                  return efi_var_collect_mem(data, data_size, EFI_VARIABLE_NON_VOLATILE);
>>
>> +       for (pdata = var->name; *pdata; ++pdata)
>> +               ;
>> +       ++pdata;
>> +
>> +       var_data = (void *)pdata;
>> +       var_data_size = var->length;
>> +
>> +       /* Handle EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS */
>> +       if (var->attr & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS) {
>> +               if (var_data_size > sizeof(struct efi_time)) {
>> +                       struct efi_time *timestamp;
>> +                       struct win_certificate_uefi_guid *cert;
>> +                       efi_uintn_t auth_size;
>> +
>> +                       timestamp = (struct efi_time *)var_data;
>> +                       cert = (struct win_certificate_uefi_guid *)(timestamp + 1);
>> +                       auth_size = sizeof(struct efi_time) + cert->hdr.dwLength;
>> +                       if (var_data_size > auth_size) {
>> +                               var_data = (u8 *)var_data + auth_size;
>> +                               var_data_size -= auth_size;
>> +                       }
>> +               }
>> +       }
>> +       /*
>> +        * EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS type is old & not
>> +        * expected for auth variables
>> +        */
>> +       else if (var->attr & EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS)
>> +               return EFI_INVALID_PARAMETER;
>> +
>>          old_size = *data_size;
>> -       *data_size = var->length;
>> -       if (old_size < var->length)
>> +       *data_size = var_data_size;
>> +
>> +       if (old_size < var_data_size)
>>                  return EFI_BUFFER_TOO_SMALL;
>>
>>          if (!data)
>>                  return EFI_INVALID_PARAMETER;
>>
>> -       for (pdata = var->name; *pdata; ++pdata)
>> -               ;
>> -       ++pdata;
>> -
>> -       efi_memcpy_runtime(data, pdata, var->length);
>> +       efi_memcpy_runtime(data, var_data, var_data_size);
>>
>>          return EFI_SUCCESS;
>>   }
>> --
>> 2.34.1
>>
