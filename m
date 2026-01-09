Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D00D232E7
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 07:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81AEC84314;
	Fri,  9 Jan 2026 08:15:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EHF/agqY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hCCKwd4t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A865584332; Fri,  9 Jan 2026 08:15:22 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F35928414B
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 08:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6094YlsZ2706968
 for <u-boot@lists.denx.de>; Fri, 9 Jan 2026 07:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6NU8glkI9ZtUP+qfBdSUOYwnJA30m4NIFJg52dxgk54=; b=EHF/agqYrLtCyZVT
 gl/2nSmW9/vNMq/tKKMPDE/uI+IhA/AwoWZG0OunxQYZ2sC/0Y3fOztjAUS3+0mM
 9Urhnv9SBnwohlHZzgoLedSQFR0k2kR2F0dRfIS11XmUiuP2uXIlauvP9rocavbK
 nJsWn2rqj7hI0sACGTArFUB6gqoWelitNLFba7bZTx/chcFr22jeaaGoqiOK7khV
 m5MZioARXylqaeo4wfyLnoGANu9tFQFDPDfEPK9/YoWTvqFVCY1V1Ey6dyiTc/jl
 VBiTG/nHygapMnTU8s8QKWWuhTdHG93zeS0yu/T8VNHsR4DcO7JW60vHPEKtiZh2
 UnedlQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj9hqumgx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 07:15:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2a31087af17so65043965ad.1
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 23:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767942916; x=1768547716; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6NU8glkI9ZtUP+qfBdSUOYwnJA30m4NIFJg52dxgk54=;
 b=hCCKwd4tCqv6K7FYJerp5DDj8oMvZA8BoPuL8QSw/ZLfKVvb0ZSo3GfWxvE6CH/Gmp
 GDQTg7DV0dzsRXtjai6mrMq8TPth3HEa5Lefz9L4cty43eZCPMfsTPwYNEZUuELtngsk
 N3+Vzpt9048aktwseBSh+UOTPdOlSCY5K8SzKqXiR+KyReeW5HZ+jbJgtTKHj8xGEflU
 /WQLY95i1jqJR1PqAu7oTS7F017JPr5bzuqJXDj9Bk5SLLLKex5MyYA2b64A0/ava6/b
 1ugVVJmMyyJbfAFy1HsNFjAg8yHre/ZZmmupTkMIPgV54m/yZ3siVE95t47JvvOEsb0Y
 Zb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767942916; x=1768547716;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6NU8glkI9ZtUP+qfBdSUOYwnJA30m4NIFJg52dxgk54=;
 b=lkJLRl338tDxbDtKqsa4AqjkIM+WuIzWFZ6r3fFzMiB+ycZ3VzQ7Oxp8zzXKe/hCEP
 6F0x+kdAiyYvnzV5PZrNrjf/kFB9umn3fh/Z7Lqd99hQYOYPi1tvPWXBqU6kQCUI308L
 yqAvBLCeW4mXtM4RiujDXAf3Sz/q0U+NxY1xYK4WuvnerDkFZhpuABk8+73gV45D1g5f
 jwE0YKCx1wjlHP63qgaJy67X7rCuxtURI2hfot08QvnmWCVqgFGYgPD9Jr1obhAYENMO
 n9BkTf6a95yjDLng74vruKLrKvg8TjTTXwJ6PmSbp9Kp1BKMSGQfBbztlRVogCG9SXKk
 3I8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpl3ep1H6Ygu3Ea+oKryfjJh6ecvuncvB9CtNQiZKbUuhgi7gAzAsTSSGzFm5HZZMCHDKG8fM=@lists.denx.de
X-Gm-Message-State: AOJu0YxPhzHX/cMa6Jm2Ahpk65/t4hWgFdUpp0cB0YhZBdD8Rewm6FDb
 f8DIVAM3ACGbrgFwgS+Zop2rJYJlVstbQWH0S6K4hCLF1nknDsf2XjBxvHNgGfPhu5fi6apFC/f
 8mNSRWkqSLrgBYp/4A33ocadlsAVrVaxWRYMQ3JddwQ6PpXRzEyZjHWJi
X-Gm-Gg: AY/fxX71jVyjBccNVx0y0xcsetYG2/POECZ9bV9untGZrHmtS6wspb5UsDX/L+I8D5z
 A542a/xRsPail7YW8VdtQKjU1yoVnd/TKkR35+nUHI7JD+WjMc7xSkIalAj5yBlTxRDWDgAmtKn
 eTBCM0kcVt9/CRR/Tm2Std3VE8wPKDG2YIsCJXc4bNoSlta42etTFVVBUVYxWDewFkzAGTdBWXO
 q4H1O/LNRyv58dzdisD2xk6dzoIF37V+/BC4rI5qT6GQ0xTRv9bCHmYAwqS4flvLF7TQjV/LEon
 1Z3IjgJyDDFR2vYpKDNyLMNynUXyyXgYCztr7MnZa+y8YjUPNDBvjuB74+T1oOTV0pYR46Uj6io
 GJyedfvvPHCLBUl3KIQE1vsJv2SpKwgGkUoUMZBPKSj7Cbb4=
X-Received: by 2002:a17:903:478d:b0:2a0:b438:fc15 with SMTP id
 d9443c01a7336-2a3ee468407mr85151685ad.11.1767942915863; 
 Thu, 08 Jan 2026 23:15:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCfAzkKdcaO+GzWd4ZqHcjsfHNtM9GxjODG//+hvMdKhjWqgLHfwbFGdBHHqUCfPGOZTk4SQ==
X-Received: by 2002:a17:903:478d:b0:2a0:b438:fc15 with SMTP id
 d9443c01a7336-2a3ee468407mr85151145ad.11.1767942914975; 
 Thu, 08 Jan 2026 23:15:14 -0800 (PST)
Received: from [10.151.41.119] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c48be5sm97387565ad.30.2026.01.08.23.15.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 23:15:14 -0800 (PST)
Message-ID: <adcc3f87-efb0-48b5-874a-3ed36315b108@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 12:45:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] env: scsi: Add support for partition type GUID
 based environment
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
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
 <aV970YfT3dkXmfxK@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <aV970YfT3dkXmfxK@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GN8F0+NK c=1 sm=1 tr=0 ts=6960ab05 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=iEqYgsLMo0GOV7DqD58A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: RMdfTOGDdt0S6otmXhZaSIq5Z34E0Qtj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA0OCBTYWx0ZWRfX1r/OeMm2wTcf
 8kaA9yrCpwNtT7QtOcsZoL8KiXXVm0xVfIpGGPRB3Z0vmdnfalUfWa5kI/X2y/G1vJw+FQDIOfW
 zNfHRO3p4xl6UCrqcXSXohIX75ucEOW00sAs3IBfHilvqk3lwS9/3Ag0epj1T2D9AZ4dUZdGpke
 9M6zfx0kgwIUhLSBfsoS9PXDMINL0aPgTYj7vgihbKsps8XQuR8dX3uaTKwkfLx+/taYv9U1Eq/
 0WOiYqOZDjZTPxcCtrZ6IPITE3KQDGF9aHanRRjxZ77LUs9A5jECIzKewo7V5JY769m+crcLt1V
 eL0Syzg6rL0b1fu7sguVifFTPFcdFdHHnNWy0RzlsugkdaEpS62EHjadIuR5r98DyhE9j+tTTN6
 qNr0LyHAHLjp8iItMuzgkUbSRd8wV0h0jK+VUAG/S0jtoc8tyVY2fPb2xrfphYe2GNDQVnu+QB7
 ggECeDP1QdSBcSQl5Hw==
X-Proofpoint-ORIG-GUID: RMdfTOGDdt0S6otmXhZaSIq5Z34E0Qtj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090048
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

Hi Varada,

On 1/8/2026 3:11 PM, Varadarajan Narayanan wrote:
> On Thu, Jan 08, 2026 at 12:19:46PM +0530, Balaji Selvanathan wrote:
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
>>   	help
>>   	  UUID of the SCSI partition that you want to store the environment in.
>>
>> +config SCSI_ENV_PART_TYPE_GUID
>> +	string "SCSI partition type GUID for saving environment"
>> +	depends on ENV_IS_IN_SCSI
> Should we add
>
> 	depends on ENV_IS_IN_SCSI && !SCSI_ENV_PART_UUID
>
> and similarly vice versa in SCSI_ENV_PART_UUID since the code seems to
> handle them as mutually exclusive...
>
> -Varada

Introduced a choice config (in this respin: 
https://lore.kernel.org/u-boot/20260109070912.4106466-4-balaji.selvanathan@oss.qualcomm.com/) 
as suggested by Tom Rini.

Regards,

Balaji

>
>> +	help
>> +	  Type GUID of the SCSI partition to store the environment in.
>> +	  Uses the first partition matching this type GUID.
>> +
>>   config ENV_USE_DEFAULT_ENV_TEXT_FILE
>>   	bool "Create default environment from file"
>>   	depends on !COMPILE_TEST
>> diff --git a/env/scsi.c b/env/scsi.c
>> index 207717e17b1..6182ae26679 100644
>> --- a/env/scsi.c
>> +++ b/env/scsi.c
>> @@ -35,8 +35,13 @@ static inline struct env_scsi_info *env_scsi_get_part(void)
>>   {
>>   	struct env_scsi_info *ep = &env_part;
>>
>> +#ifdef CONFIG_SCSI_ENV_PART_TYPE_GUID
>> +	if (scsi_get_blk_by_type_guid(CONFIG_SCSI_ENV_PART_TYPE_GUID, &ep->blk, &ep->part))
>> +		return NULL;
>> +#else
>>   	if (scsi_get_blk_by_uuid(CONFIG_SCSI_ENV_PART_UUID, &ep->blk, &ep->part))
>>   		return NULL;
>> +#endif
>>
>>   	ep->count = CONFIG_ENV_SIZE / ep->part.blksz;
>>
>> @@ -83,12 +88,20 @@ static int env_scsi_load(void)
>>   	int ret;
>>
>>   	if (!ep) {
>> +#ifdef CONFIG_SCSI_ENV_PART_TYPE_GUID
>> +		env_set_default(CONFIG_SCSI_ENV_PART_TYPE_GUID " partition not found", 0);
>> +#else
>>   		env_set_default(CONFIG_SCSI_ENV_PART_UUID " partition not found", 0);
>> +#endif
>>   		return -ENOENT;
>>   	}
>>
>>   	if (blk_dread(ep->blk, ep->part.start, ep->count, &envbuf) != ep->count) {
>> +#ifdef CONFIG_SCSI_ENV_PART_TYPE_GUID
>> +		env_set_default(CONFIG_SCSI_ENV_PART_TYPE_GUID " partition read failed", 0);
>> +#else
>>   		env_set_default(CONFIG_SCSI_ENV_PART_UUID " partition read failed", 0);
>> +#endif
>>   		return -EIO;
>>   	}
>>
>> --
>> 2.34.1
>>
