Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3769CD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59637846A4;
	Fri, 15 May 2026 15:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WlfaU/bw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VL0ALSV3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DCBB846A7; Fri, 15 May 2026 15:17:44 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBCE984694
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FBHMiX3219669
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 13:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PxDGmHIAnDvqpn0xhG2TRRONUidUEJaZOJCcTScfVtE=; b=WlfaU/bwFtWIU88W
 hEpougB7LQ1maXQvi3P+r0NV//tITLAMzK1O3JzGyiNqa3En33UwF17CbFWGyUAU
 tAn56BWZ2gKxhwGPr6WvHrDYqrHuPOtfdIKE/feY3Y97ekZPIsos4/OYk8lUeGPZ
 P67D9KsLMjI6bCX2AQCwbErYPpVj4c2gQJmJ1ZUg2oiIlWxkgHS9jc5DulqZV6xw
 eMlwLo4ZSYycRk5sWQ3qknwFTzoKbTc5xD9uyQlzP7Tkb0WrjZHHF28ftoenQM28
 RfHeBB1TDpsGJ2rbxVqI6iWgPBPxC1iC6mXBGBTWYUpbmeJquC8Yc/K2dVN3CDE0
 4Pzzgw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s3bxw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 13:17:40 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-365fc4636bbso18755983a91.2
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778851059; x=1779455859; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PxDGmHIAnDvqpn0xhG2TRRONUidUEJaZOJCcTScfVtE=;
 b=VL0ALSV36i9WoY7QPWufJuk+RoPSASRrhIo88YrzZvZEeOJQ3M4eC/3vsd8EWAqmoO
 D0brCPoK2BMOl8dB6y/tlaLdowa1Y+Qjq7RyhH0uROn7wzA0L06SPe6KULNl4WzN5atG
 eLBLEAm07R5SMVGZ5vIOjgdaAABxjeIUOUrQ/eNw8sDMjnjrEvbN4Kc7wveQoGfh6YJq
 fK+u6o2p2/wc75YU63bZL7ye/N7tIK3gKB+VB3Yn3xucnGlUqJ9Jp0hE+H9OJSCRllQ2
 rE8LiwpAuuFD2nqA1NEqnQh8nk0/S+dR/nUVnLW1r0OH/iFamE3rJrBJeFx6sR8Wr/PW
 jL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778851059; x=1779455859;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PxDGmHIAnDvqpn0xhG2TRRONUidUEJaZOJCcTScfVtE=;
 b=iCOYavxVhhORVDsYAzokSkce2xFVYXq1rWJnpRqkRFZyo2QQkHjzrYrnSFPo3pJLGg
 GOjclJyrCSepM6exoUngGMntOTtwtYtylTkzAvi3NiKz7u340LgWyPGMyGSlzpzuoB5D
 +A1U6ZutBBTDyy3Is/kwTya16xgX+FWNTerfCOWhcUpLi4lwuVymvI5lQgjWrH64d+A1
 ujCOJ/L/FQpRINXw7hUy94a6vrJw9eX0ZHITIoJI90xq6a71odwGPHC+IR+8Gg5+E4wC
 k54xzG9ycGFMF1HfM/RjNHq304rUdjh9/ZCgEvoF9jK2Kwnaggc9VvkwjK2aIetlinDP
 neZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lYaIEQ8JRNBUOJ6dYehGpH8grQzmhVqSPaK9TzjcrvZkQsG6KLR3WX8rwNDpNaZ2xDw12sB0=@lists.denx.de
X-Gm-Message-State: AOJu0YzKmEVJR9bL1Qg3rMgHA9ia9Y1ZV7EnKQ6Z/kOvp/rAzo7PVKR5
 otS94hUXk/+coKqu9W9+xe7NN3MF5FipFBu4gz3kNKV0HagCme37A1sD6TPYQeBnXj2RgLZEOc+
 NoWE4DSBakLjhXkiwmhufpVX/zdXbQgLmTcGIylOgVg2Kta/hz9/KVL3w
X-Gm-Gg: Acq92OFVvBwkLcCpM1QPF9kgOAsFzqRcc8RHMB7g3oE99rz8Tn+GxzM+ZdjFd7C7Jw0
 cmJ4w3p7/KgdkQHw94W1V1MyrLd8+1fGC1HXl7GIjMpVCpK0fRf3+BG+4ufJef0/4U2nlukfRmb
 E+7WB3hImFjdwRmhI14M51/vhPvTrHsNiHw7HhSCi4cfoHqH5e4w2ikvZFvXgEg42R0yTEDrCyr
 elzuXD54AYFC9OSodF0qTT6K6PZdkmmFGXs//dHg5gSaDAGuMTwy5iaCt0/SAvUoB06CLSmxVnM
 tmOyp/jaLoVY9s5vLcZmfoPs4pls0f6jkzjdDoAQMF6Yp4Kd1J34xLnbtDiFyN1if3uRPBOGUjG
 xhSzWyWMnTBq2ruFruRBHOe7bJf7BByzWGPbWntmi0HXaf8S3BDDxPA==
X-Received: by 2002:a17:90b:4ec8:b0:368:6a47:83f4 with SMTP id
 98e67ed59e1d1-369519af6demr4295831a91.6.1778851059071; 
 Fri, 15 May 2026 06:17:39 -0700 (PDT)
X-Received: by 2002:a17:90b:4ec8:b0:368:6a47:83f4 with SMTP id
 98e67ed59e1d1-369519af6demr4295766a91.6.1778851058498; 
 Fri, 15 May 2026 06:17:38 -0700 (PDT)
Received: from [10.152.202.155] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3695124601asm2791783a91.2.2026.05.15.06.17.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 06:17:38 -0700 (PDT)
Message-ID: <da733868-79d2-4425-acd1-f1a9ce83feba@oss.qualcomm.com>
Date: Fri, 15 May 2026 18:47:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tools: efivar: strip auth descriptor for authenticated
 variables
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com, u-boot@lists.denx.de
References: <20260514171649.3708107-1-aswin.murugan@oss.qualcomm.com>
 <CAC_iWj+bgFhPbxNH-BqU1fFD0j3wzBE_9FT_kfhZ-r48Ztb7pQ@mail.gmail.com>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <CAC_iWj+bgFhPbxNH-BqU1fFD0j3wzBE_9FT_kfhZ-r48Ztb7pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEzNSBTYWx0ZWRfX6v15qm6g0VlG
 TyzIwyrR6JwYFGDanBgCeJBLnvw48tK519R03XVjoQvsuVJDnDVy1V1jAR1uRqtFb4arL1VTtES
 tphFkaLaG2Z8Rfpm6FaM1iGzssoX9kiNtX6VO5LUB0eUYXxuO7umhjXe5tDM1eEhEqh1a+II3X2
 dZD6AUxs09l2BVYyvGj2Kt1IyLb8r4bb+dEQ6F+r6C+LU3TT9w40Be6SERd+6AzC5tynTWW+iL/
 9GiHlxJcwyHAA/SS89cEDnLoq2UicBR6CCdabtIZjIq3LGYIAgIfHqC8BvjqQUFDBN1CfZPDX+O
 3LyV84nVBGo/Xs6MR7SomGUwpeNfxHvQzNRg1YAE0KOWWUsBf7g3hvd18Vh+R63bnTu9Et/HVsD
 DYUhO4/eClAIMbMdaLo7qc3NpJtYSB8r80fbVQw9cCvpMczTJEfLAtnGm2HYsyNKYk6/AZiFwvt
 /9LKqHwg8KlhtOPPBMw==
X-Proofpoint-GUID: CUwl4mnyvZO61fxn_LuclfS6WRbDLsJU
X-Proofpoint-ORIG-GUID: CUwl4mnyvZO61fxn_LuclfS6WRbDLsJU
X-Authority-Analysis: v=2.4 cv=HJ7z0Itv c=1 sm=1 tr=0 ts=6a071cf4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KTSAc_bGXdCbCS0F4BsA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150135
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

This change has been verified locally with our setups on qcs615 & 
QCS9100 SOCs

Regards,
Aswin

On 5/15/2026 4:02 PM, Ilias Apalodimas wrote:
> Hi Ashwin,
>
> On Thu, 14 May 2026 at 20:17, Aswin Murugan
> <aswin.murugan@oss.qualcomm.com> wrote:
>> efivar.py currently stores authenticated variables including the
>> EFI_VARIABLE_AUTHENTICATION_2 descriptor (timestamp + WIN_CERTIFICATE)
>> along with the payload.
>>
>> When variables are set via U-Boot, SetVariable() validates and strips
>> this authentication descriptor before persisting the variable data,
>> resulting in only the payload being stored and returned by GetVariable().
>>
>> This mismatch causes efivar.py-generated stores to differ from U-Boot
>> runtime behavior and leads to incorrect GetVariable() results.
>>
>> Update efivar.py to strip the authentication descriptor and store only
>> the payload for authenticated variables, ensuring consistency with
>> U-Boot behavior and compliance with UEFI expectations.
> The approach is fine, but when I use the tool now to create signatures
> and enable secure boot I am getting
> => bootefi bootmgr
> Getting signature database(db) failed"
>
> Have you tried a built that worked locally?
>
> Thanks
> /Ilias
>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>> ---
>> Changes in v3:
>> - Previously stripped the authentication descriptor at GetVariable(),
>>    now moved to strip it in efivar.py during variable pre-seeding/set.
>> Link to v2: https://lore.kernel.org/u-boot/20260512194205.1905069-1-aswin.murugan@oss.qualcomm.com/
>>
>> Changes in v2:
>> - Enhanced commit message with explicit UEFI spec reference
>> Link to v1: https://lore.kernel.org/u-boot/20250725123653.513252-1-aswin.murugan@oss.qualcomm.com/
>> ---
>>   tools/efivar.py | 50 ++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 49 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/efivar.py b/tools/efivar.py
>> index 67729fa8505..d248cd868ba 100755
>> --- a/tools/efivar.py
>> +++ b/tools/efivar.py
>> @@ -79,6 +79,50 @@ class EfiVariable:
>>   def calc_crc32(buf):
>>       return zlib.crc32(buf) & 0xffffffff
>>
>> +def strip_auth_descriptor(data, attrs):
>> +    """
>> +    Strip the EFI auth descriptor from authenticated variable data.
>> +
>> +    This is used during efivar.py-based pre-seeding of ubootefi.var to
>> +    match U-Boot SetVariable() behavior, where the authentication header
>> +    is consumed during validation and only the payload is stored.
>> +
>> +    For variables with EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS:
>> +    - Input format: [EFI_VARIABLE_AUTHENTICATION_2 | payload]
>> +    - Stored format: [payload only]
>> +
>> +    Auth header size calculation (aligned with U-Boot efi_variable_authenticate()):
>> +        auth_size = sizeof(EFI_TIME) + WIN_CERTIFICATE.dwLength
>> +
>> +    Only the payload portion is retained after stripping the header.
>> +    """
>> +    if not (attrs & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS):
>> +        return data
>> +    if not data:
>> +        return data
>> +
>> +    efi = EfiStruct()
>> +    if len(data) < efi.var_time_size:
>> +        return data
>> +
>> +    offset = efi.var_time_size
>> +    if len(data) < offset + efi.var_win_cert_size:
>> +        return data
>> +
>> +    try:
>> +        cert_hdr = struct.unpack_from(efi.var_win_cert_fmt, data, offset)
>> +        dwLength = cert_hdr[0]
>> +    except struct.error:
>> +        return data
>> +
>> +    auth_size = efi.var_time_size + dwLength
>> +    if auth_size <= 0 or auth_size > len(data):
>> +        return data
>> +
>> +    if len(data) <= auth_size:
>> +        return b''
>> +    return data[auth_size:]
>> +
>>   class EfiVariableStore:
>>       def __init__(self, infile):
>>           self.infile = infile
>> @@ -172,8 +216,12 @@ class EfiVariableStore:
>>                   break
>>               offs = loffs
>>
>> +        if data and (attrs & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS):
>> +            data = strip_auth_descriptor(data, attrs)
>> +            size = len(data) if data else 0
>> +
>>           tsec = int(time.time()) if attrs & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS else 0
>> -        nd = name.encode('utf_16_le') + b"\x00\x00" + data
>> +        nd = name.encode('utf_16_le') + b"\x00\x00" + (data if data else b'')
>>           # U-Boot variable format requires the name + data blob to be 8-byte aligned
>>           pad = ((len(nd) + 7) & ~7) - len(nd)
>>           nd += bytes([0] * pad)
>> --
>> 2.34.1
>>
