Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE5DD232F7
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 08:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53A6684121;
	Fri,  9 Jan 2026 09:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YI7tluuB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ceUD5ja6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A09CD84144; Fri,  9 Jan 2026 09:51:45 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAFB584119
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 09:51:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6098XR1S822867
 for <u-boot@lists.denx.de>; Fri, 9 Jan 2026 08:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e7wVnuaYZ3JRbGegQI/s91bb7fNZY9Lg4ISEpABbB50=; b=YI7tluuBVZBkqVo5
 x0P2byXpqulR+h5O1SNFpZYUZYKpGeQKFwgHVwPWp8+vy+JhDzABML8UhR0WS54B
 pw0dFf4lrccWlAN3pusKbckKgLkON3zdrXBZ5oAqJfOqFpjVfzyGT+4d6AqDjeTE
 XNy0qjl/vLhGgb/LxhldnggZdLeBOaGNHvAM4riDIdp9Ors+hGUppzXYxaiBfxxd
 PP4uopVTygDXe2r6CgtAHZyVvN+ROj1avYEr8EIceYVbakmHuZPy5yIAk0apTL33
 mrefSQYqPRDr2950T/adGs2oHXbBvQsJjBTQubnwKkUy4C0OOCPUz+/MH2j5ODMt
 EptkVA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjx94g215-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 08:51:37 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a08cbeb87eso49483305ad.3
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 00:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767948697; x=1768553497; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e7wVnuaYZ3JRbGegQI/s91bb7fNZY9Lg4ISEpABbB50=;
 b=ceUD5ja64rpFyPs4WvWEo17e99+E1rLLcBLQu9ADChJdtXkizblfguKhWx/astvvpw
 SFZjvHeDiG94Uvx8W539Rd9ruUDoWMxbkHRUMwmq5RDua5fTYM4Q+6CBIJtqbxexPAYw
 zJPpU/5RHn9tj2B6BJx7v7sIQhd/HCc9rZHjWTp8+eTGypt20Q0tdw3L9ZCbix9Wqn/u
 jY3mxmuxrHxoX1rSaF7bKx3mNoqtIo7lLbdW88j0quJ+mlZ6YvBbdsYH6hRGp5NY454/
 qrgddcgijXO07qlVNGb3qhdSEmFJy23lqBy1VJZW412dqAsFK2suAKGI2pxlPFipnYNd
 dUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767948697; x=1768553497;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e7wVnuaYZ3JRbGegQI/s91bb7fNZY9Lg4ISEpABbB50=;
 b=hL6NZONWPMvWPp2DRtXUVzRB9iCjpPi7rgWfjTLQO+6sSSaccOmLtnSIpM+CzhmEio
 CnUMyH2pUbaoDU8uv5MpI9kIYHkbEKuCFIY8wbaM8xTRYf7eiJ/7pQ9D5GlxZ9SO+mqa
 u7x3qjHc33OedauP2/+LsasKFgayyXXyoeAwsarCP7mmIW6FRr9BxNwKa3Jj1TNXSWHy
 1LSXLdZ1PtAwcx7x7QrZdD/H/6gDmuRc7dPDyC+il4ZqWW/7vskNWr9TY41mp8lfUz6v
 7CMTTRRUOXXGGKGjOgU2SNYAtol/gjd/vTlfDysbQetX1BzstuSMdgT407eiE5JspUx2
 vQbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdnKwXT00Dcq1zphyMbBsQkCNB9AQToakG2yQWC4/oFYSr4fHMdrNH9yr1eFsNznrExE4i37M=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1+lTiK/A1HqkBxK9L752BE6koxeRdwyjuf4vIQCxTP74pQj5u
 uSBYf7dAee54NPNWomzBKWToDLd7vVCzh2EroqeWZBPHJsp4J7EFpDN7tbfIuxAywNuQ4bYEuT+
 lQpP6RCwUFn9YR6vW0TyDBkmDZ1VKlKCkW0+tb9VaKraUBIUhlQ6bOtD0
X-Gm-Gg: AY/fxX4p1KHasCF3e4N3C28cNwfWdfP2ikfby9KxGAiJy0yn735lE7e47w3b3tip6R1
 lu1odtF+bQ+7Un5UuKPbSr7gX3rev69o31g7vC1e6n7ZIZV7WRKq2mNWaz2Nnf2Zeqr9vU7JDW5
 9SMfGanhETH9w17M84WEhl/Hca0lzVR4sDWUByKE0mEXzJp8/LHstq90E5EMU2aBx65ZDKbhPeJ
 4LEzvXtrikN5KiLisdGIBxCiPKPFms7gVjsnCd1MfpZqgMTmYKmtzDvIU57JS2X2ghXA4AgGrys
 Lz7QanH2JZHXI90TjHqQpygPOUTMoV3WDa8aKG+V6DNTo+cSDMECskHjyyo5FzmJZQy7wnlfETF
 TBCSNmq3aVfX4K3BswSJzQ/zMUGB+YEqn9e8CxGP6PRZENng=
X-Received: by 2002:a17:903:1a6b:b0:295:6c26:933b with SMTP id
 d9443c01a7336-2a3ee41d19cmr85345235ad.1.1767948697109; 
 Fri, 09 Jan 2026 00:51:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZGdqCBJhmiS3rre5ybdQ/6TVFZdWvBcbvvPr49Fxi8ROg4ivlyCwLduoMTB/BLvh3dC52lg==
X-Received: by 2002:a17:903:1a6b:b0:295:6c26:933b with SMTP id
 d9443c01a7336-2a3ee41d19cmr85344705ad.1.1767948696397; 
 Fri, 09 Jan 2026 00:51:36 -0800 (PST)
Received: from [10.151.41.119] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c5cefbsm97449515ad.43.2026.01.09.00.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 00:51:36 -0800 (PST)
Message-ID: <bb66d91b-667a-4c28-8acc-b64fa84fb7f6@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 14:21:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] env: scsi: Add support for partition type GUID
 based environment
To: Simon Glass <sjg@chromium.org>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, joe.hershberger@ni.com,
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de, ravi@prevas.dk,
 javier.tia@linaro.org, quic_varada@quicinc.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 ansuelsmth@gmail.com, mwalle@kernel.org, anshuld@ti.com,
 jan.kiszka@siemens.com, javierm@redhat.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com>
 <20260108064947.3237361-4-balaji.selvanathan@oss.qualcomm.com>
 <CAFLszTg6X8PeD4ZyY08WsTSs+qnRb_-jJjyupzSmi-jDzEhWUQ@mail.gmail.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <CAFLszTg6X8PeD4ZyY08WsTSs+qnRb_-jJjyupzSmi-jDzEhWUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RN2+3oi+ c=1 sm=1 tr=0 ts=6960c199 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=VqIB2j27SjXQJw6CrHMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: bjMSUeS6ZvNy_wTTFwHtnEe0o6lOSfE1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2MiBTYWx0ZWRfXxyCatWYZbBpB
 46l0tEVAReYkCNAsMRHM0ss5/L9rKyCgzqwgv7+xl5IpCL5kI0YPk1Y5qK03d5whyn2c98CQJ2G
 v+64Qdnfd35CypUW8LXQUHAgSxYqH9eBBXFuPQK+BxZI146wGyjyHi/cryISOq9ajWDFUvTAXZt
 W+g6hrQbdv8BU/IutZjcCVsNuSPqdSRRJStmAxs9ssYRlVAlI9IMbVM9f+B6jjauS2Q0EkgMWEU
 jmBozo/Wn19Q77bRwPq5xbtPfb52+3G2XPfuanZFL9+ooevquy3DCZH84C4bncrrAdvrmxVFUGt
 SrqYwMUdtkaRm4JoSGIw8q/8RP3euNbghyiwcEz5CdWn/4mtO2vUqi+8wc8rRJhhwtUSqe0Yrko
 +dT7mHzdAFqyj5nHTeIFkjeq/YbJR3dIZ1BafSpzVH47GPPdRljV0+LqN8K7sfivwW0ASzYfjH/
 543cQNy8o4rPQkzcJvA==
X-Proofpoint-ORIG-GUID: bjMSUeS6ZvNy_wTTFwHtnEe0o6lOSfE1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090062
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

Hi Simon,

On 1/8/2026 11:12 PM, Simon Glass wrote:
> Hi Balaji,
>
> On Wed, 7 Jan 2026 at 23:50, Balaji Selvanathan
> <balaji.selvanathan@oss.qualcomm.com> wrote:
>> Add support for locating SCSI environment partition using GPT type
>> GUID instead of unique UUID. This enables the saveenv command to
>> work with partitions identified by their type rather than unique
>> identifiers, providing flexibility for systems where partition
>> UUIDs may vary across devices but types remain constant.
>>
>> Introduce CONFIG_SCSI_ENV_PART_TYPE_GUID configuration option that
>> allows specifying a partition type GUID for environment storage.
>> When enabled, the environment subsystem uses the new type GUID
>> based lookup method via scsi_get_blk_by_type_guid() to find the
>> first matching partition.
>>
>> This change maintains backward compatibility with the existing
>> UUID-based approach.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>>   env/Kconfig |  7 +++++++
>>   env/scsi.c  | 13 +++++++++++++
>>   2 files changed, 20 insertions(+)
>>
>> diff --git a/env/Kconfig b/env/Kconfig
>> index b312f9b5324..97cb3d05daf 100644
>> --- a/env/Kconfig
>> +++ b/env/Kconfig
>> @@ -768,6 +768,13 @@ config SCSI_ENV_PART_UUID
>>          help
>>            UUID of the SCSI partition that you want to store the environment in.
>>
>> +config SCSI_ENV_PART_TYPE_GUID
>> +       string "SCSI partition type GUID for saving environment"
>> +       depends on ENV_IS_IN_SCSI
>> +       help
>> +         Type GUID of the SCSI partition to store the environment in.
>> +         Uses the first partition matching this type GUID.
>> +
>>   config ENV_USE_DEFAULT_ENV_TEXT_FILE
>>          bool "Create default environment from file"
>>          depends on !COMPILE_TEST
>> diff --git a/env/scsi.c b/env/scsi.c
>> index 207717e17b1..6182ae26679 100644
>> --- a/env/scsi.c
>> +++ b/env/scsi.c
>> @@ -35,8 +35,13 @@ static inline struct env_scsi_info *env_scsi_get_part(void)
>>   {
>>          struct env_scsi_info *ep = &env_part;
>>
>> +#ifdef CONFIG_SCSI_ENV_PART_TYPE_GUID
>> +       if (scsi_get_blk_by_type_guid(CONFIG_SCSI_ENV_PART_TYPE_GUID, &ep->blk, &ep->part))
> Can you use if IS_ENABLED(CONFIG_SCSI_ENV_PART_TYPE_GUID)
>
> (we try to avoid #ifdef)
Thanks for the feedback.

In this respin 
https://lore.kernel.org/u-boot/20260109070912.4106466-4-balaji.selvanathan@oss.qualcomm.com/, 
I've introduced a choice statement in env/Kconfig to ensure mutual 
exclusivity between CONFIG_SCSI_ENV_PART_UUID and 
CONFIG_SCSI_ENV_PART_TYPE_GUID.

Due to this choice-based configuration, only one of these string configs 
is defined at compile time. When I attempted to use `if 
(IS_ENABLED(...))` for the string concatenation cases, I encountered 
compilation errors because the compiler tries to evaluate both branches, 
but the undefined config macro causes an "undeclared identifier" error.

For example:

if (IS_ENABLED(CONFIG_SCSI_ENV_PART_USE_TYPE_GUID))
     env_set_default(CONFIG_SCSI_ENV_PART_TYPE_GUID " partition not 
found", 0);
else
     env_set_default(CONFIG_SCSI_ENV_PART_UUID " partition not found", 
0);  // Error: CONFIG_SCSI_ENV_PART_UUID undeclared

Given this constraint with mutually exclusive string configs, I've kept 
the #ifdef approach for these specific cases. I understand the 
preference for IS_ENABLED() for its compile-time checking benefits, but 
in this scenario with string concatenation, the preprocessor conditional 
appears to be necessary.

Would this approach be acceptable, or would you prefer an alternative 
solution?

Best regards,
Balaji
>
>> +               return NULL;
>> +#else
>>          if (scsi_get_blk_by_uuid(CONFIG_SCSI_ENV_PART_UUID, &ep->blk, &ep->part))
>>                  return NULL;
>> +#endif
>>
>>          ep->count = CONFIG_ENV_SIZE / ep->part.blksz;
>>
>> @@ -83,12 +88,20 @@ static int env_scsi_load(void)
>>          int ret;
>>
>>          if (!ep) {
>> +#ifdef CONFIG_SCSI_ENV_PART_TYPE_GUID
>> +               env_set_default(CONFIG_SCSI_ENV_PART_TYPE_GUID " partition not found", 0);
>> +#else
>>                  env_set_default(CONFIG_SCSI_ENV_PART_UUID " partition not found", 0);
>> +#endif
>>                  return -ENOENT;
>>          }
>>
>>          if (blk_dread(ep->blk, ep->part.start, ep->count, &envbuf) != ep->count) {
>> +#ifdef CONFIG_SCSI_ENV_PART_TYPE_GUID
>> +               env_set_default(CONFIG_SCSI_ENV_PART_TYPE_GUID " partition read failed", 0);
>> +#else
>>                  env_set_default(CONFIG_SCSI_ENV_PART_UUID " partition read failed", 0);
>> +#endif
>>                  return -EIO;
>>          }
>>
>> --
>> 2.34.1
>>
> Regards,
> Simon
