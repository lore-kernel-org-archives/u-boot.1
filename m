Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BEBD232E8
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 07:13:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8667A8414B;
	Fri,  9 Jan 2026 08:13:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MFplpdQj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bIcmRQzD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBEC684248; Fri,  9 Jan 2026 08:13:32 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5E8084144
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 08:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6094hcLm3166285
 for <u-boot@lists.denx.de>; Fri, 9 Jan 2026 07:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ycB0dYc9NLtJN/HAeSGash4HgoewyU/UvqJneLXsYh4=; b=MFplpdQjJeucE2Xb
 4RKE+yNq+7nFGJOluHJN1vaoQg4l3E26CUfVPaoKfHHrAN60dgpdQS491oYcCvm2
 j7LWxt7vekx8qWXgTnGtidzVL9hF1RMyX74MUZoAggCYi0mPl4nk/ROh9XTQ1KE9
 OSpOqmL2dd6mwiYjiGGf+mdhrikIWBaXYHIja9pCOkwMtiAfSjLBaDTqyzpuVAJh
 f87KKgZX47Xi1NGyf3vGGFSt7fzc2bc+eljw6B2jyfJVCmv1ozGv/tHLKFuwc4UR
 luFFquddcMWgMrKHaGVSbcuZUmb/W1RENDGNjfwMn6gmdH8NeP845Lm4RGUDcwLH
 pyIKBg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj8923wy2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 07:13:28 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7fc82eff4adso2615556b3a.1
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 23:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767942808; x=1768547608; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ycB0dYc9NLtJN/HAeSGash4HgoewyU/UvqJneLXsYh4=;
 b=bIcmRQzDIbvVDva/7poAvIEsoysrh7WrCPr8TTJmtt2bB+f3i1RNnAZV3ertfRTQYR
 wnzRGXnFyoWI6JU7a5NyY7EDSbPdsMeg6XiFLsrix028F5bguyPI6EwfhOO9Mtv2DUXz
 7FIg/hg4ehRx0XZCF3s2RbukVVVvIIRQmgNAnsFhs4os1Nxl933L3U4wmQdOHWie/r7+
 BIBF+B5pyQlyvAs3fuKLPlnQZdJSpPOUVk7QRPz5FZN4nMkJ43iyaLvcb/sgc7KWsUGj
 sPvNRrJ8qnBbxdAmGDN+7oeqNfzvib5x3HNjgvARzmK6JHv/OYpJIeaoXuDhkH13EKJm
 e1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767942808; x=1768547608;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ycB0dYc9NLtJN/HAeSGash4HgoewyU/UvqJneLXsYh4=;
 b=r65yHITMF6gYJxi8mhLtSJkLII9FRL084A5KAGZXfrvCcfGlquZ588+L688KFQf1wx
 JbSlQzUutJJwaJbWL8hz+MtJC+DCcdDju5I4Wtl4cwQrte2ldyHvdtNVKbiU/uYkmB5V
 KRCFKsnA/eUtirHwS58u+2JqPVBN0qiMOag/xH1D0B9aEXsE9Vebh7qxonxn+gGezd0P
 HXz2/r2YhcXAyLh+5QncHq0ejJbL2Vn4t6tZ3tU8OpbK3ok+dtu/fs6+HwCIa03CWhGD
 3IqMNCd0NTrlOnA6gM3xQXQoF9SndCrYNdA0nlhhkeftzV+Ta/ONJtVgO1P2P7u4nCbS
 2RZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZhXeGVMsgFhNb6aV1sZDkmLWnLpaPYEp/t5PSp8LxSIWcATOLAE9190SyuyHpRF0dLz5eAUY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4yV3Qfj9pf2AQJ8Y7Fj9+O7Ro8xH2nEwEiNDejl/r6BcF/m/j
 59GY+bzWu49WdchV6Cf/7W2Y37CYIO3jErzyFajGXMrAvtL46YIocGe0PlnlMBf7NdtobFmXbv6
 MG+ABvEC/cpYEE8QWAQtSSXQR7jbeylkzRyBxW33oNwkgTBdeHv0HMz/K
X-Gm-Gg: AY/fxX6ReVpcnDmStRbuuJhPaCJWH30/mZj4xzQqZx2qUE/aJOpqIpqbZfenhpy+ocV
 6KeNr2PVWeP/lcVYZNZ/ZSKOJxpl/NTtRwTKuQvozjbwaIFBaNuhC2u3LLcfqZDSYy70oNsTVu9
 Fjip3iZHPvj9jEUQK3PMgO/7pYILFJCtJPKFX5SRiKvbAnz6ZlLudmMUw3OJ4pyJOSJsQwYoTZ2
 NjbN59kv2KqWSx6Sqk2FdeCQDsFyC7Q9R/8i1MZWd2J5vwv/3nH7iSHgdrOsgLXxuTWxYcZx79p
 QIIfHZLijB5TkmVC2MS4jMA+68fgOjdm72tf4e5KFab9bBqw7x30MuNwVUoGl/R+69odOtb9xR1
 QAqNgUHG1+DT5pI//qWLitjBC2Z3RkUNuZhCh2YZiWtli9ME=
X-Received: by 2002:a05:6a00:1598:b0:81d:e9b1:b6d6 with SMTP id
 d2e1a72fcca58-81de9b1c52cmr1852320b3a.28.1767942807875; 
 Thu, 08 Jan 2026 23:13:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQScmm1JgKTzJWLHtP8rQesY9pckiUpxswlTQ2oAod4gprqmI1ZkkPtgMqqZD7YZAG/SBPIw==
X-Received: by 2002:a05:6a00:1598:b0:81d:e9b1:b6d6 with SMTP id
 d2e1a72fcca58-81de9b1c52cmr1852292b3a.28.1767942807428; 
 Thu, 08 Jan 2026 23:13:27 -0800 (PST)
Received: from [10.151.41.119] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81ec1b5f927sm31818b3a.46.2026.01.08.23.13.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 23:13:27 -0800 (PST)
Message-ID: <d2c00ae4-f8aa-442d-b36c-f99453a181e2@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 12:43:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] scsi: Add partition lookup by type GUID for SCSI
 devices
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
 <20260108064947.3237361-3-balaji.selvanathan@oss.qualcomm.com>
 <aV967ZD8Hdjed/ss@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <aV967ZD8Hdjed/ss@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=M45A6iws c=1 sm=1 tr=0 ts=6960aa98 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=USheUskOahBK9tPxJdEA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 5vx3Q1j9Zb7ht4qP79JB06hAs9ctgsMU
X-Proofpoint-GUID: 5vx3Q1j9Zb7ht4qP79JB06hAs9ctgsMU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA0OCBTYWx0ZWRfX2V/HfXEAyt+s
 1eUs/K9fiqZHUqbEzSw/W/MEN3Uzqsq4LUIbyfW9AwzWQ+5fCvfqJHzIFT7kAppXUxTRjo9l4t8
 6du8mdcxpOUqv0oYQK47EjugHogojXUTQnhTvPaZ6l91a9B3crIFL8iSEKmB4Ty7F7lOuyWOxl2
 qfM7t3kOGxguZkcO2j0qyw8oxJMAiTHkV5BGVk1gdLmR3wMe0SXUb9BmENqvgmb34whjEav54Ce
 7piZaf8cOJrAzK7y96WY1SrzRrhoWwyxZLKoc3bfe6IBkpwt6TKf/aSRs3xaLa9M1fzPQeqegjE
 W5eLw+gZNYjmtTKcjbi2DWIf1yR+qtgEaZ8poMcXV3Yegr8Rr8ElYPAPXxTIDczfzG1+Cn147qP
 Kacx0E7d+XDl1FQjMLGuiAIgrhiDvuiFbH/X+r67kAVCII4pdT7+tlbVyi6EmncPkF+m/kfwFPT
 fvejPZWX3WBs+QM73gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090048
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

On 1/8/2026 3:07 PM, Varadarajan Narayanan wrote:
> On Thu, Jan 08, 2026 at 12:19:45PM +0530, Balaji Selvanathan wrote:
>> Introduce scsi_get_blk_by_type_guid() function to enable SCSI
>> partition discovery using partition type GUID. This function scans
>> all available SCSI devices and searches for a partition matching the
>> specified type GUID.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>>   drivers/scsi/scsi-uclass.c | 28 ++++++++++++++++++++++++++++
>>   include/scsi.h             | 11 +++++++++++
>>   2 files changed, 39 insertions(+)
>>
>> diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
>> index 3eb6069649f..42a6b5233c2 100644
>> --- a/drivers/scsi/scsi-uclass.c
>> +++ b/drivers/scsi/scsi-uclass.c
>> @@ -53,6 +53,34 @@ int scsi_get_blk_by_uuid(const char *uuid,
>>   	return -1;
>>   }
>>
>> +int scsi_get_blk_by_type_guid(const char *type_guid,
>> +			      struct blk_desc **blk_desc_ptr,
>> +			      struct disk_partition *part_info_ptr)
>> +{
>> +	static int is_scsi_scanned;
>> +	struct blk_desc *blk;
>> +	int i, ret;
>> +
>> +	if (!is_scsi_scanned) {
>> +		scsi_scan(false /* no verbose */);
>> +		is_scsi_scanned = 1;
>> +	}
>> +
>> +	for (i = 0; i < blk_find_max_devnum(UCLASS_SCSI) + 1; i++) {
> 	max = blk_find_max_devnum(UCLASS_SCSI) + 1;
> 	for (i = 0; i < max; i++) {
>
> Else, i believe blk_find_max_devnum() will get invoked multiple times.
>
> -Varada

Thanks for the feedback. Addressed this.

Regards,

Balaji

>
>> +		ret = blk_get_desc(UCLASS_SCSI, i, &blk);
>> +		if (ret)
>> +			continue;
>> +
>> +		ret = part_get_info_by_type_guid(blk, type_guid, part_info_ptr);
>> +		if (ret > 0) {
>> +			*blk_desc_ptr = blk;
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	return -1;
>> +}
>> +
>>   int scsi_bus_reset(struct udevice *dev)
>>   {
>>   	struct scsi_ops *ops = scsi_get_ops(dev);
>> diff --git a/include/scsi.h b/include/scsi.h
>> index 8d6c5116419..e0b2f869057 100644
>> --- a/include/scsi.h
>> +++ b/include/scsi.h
>> @@ -361,6 +361,17 @@ int scsi_scan_dev(struct udevice *dev, bool verbose);
>>   int scsi_get_blk_by_uuid(const char *uuid, struct blk_desc **blk_desc_ptr,
>>   			 struct disk_partition *part_info_ptr);
>>
>> +
>> +/**
>> + * scsi_get_blk_by_type_guid() - Provides SCSI partition information by type GUID.
>> + *
>> + * @type_guid:		Type GUID of the partition for fetching its info
>> + * @blk_desc_ptr:	Provides the blk descriptor
>> + * @part_info_ptr:	Provides partition info
>> + */
>> +int scsi_get_blk_by_type_guid(const char *type_guid, struct blk_desc **blk_desc_ptr,
>> +			      struct disk_partition *part_info_ptr);
>> +
>>   #define SCSI_IDENTIFY					0xC0  /* not used */
>>
>>   /* Hardware errors  */
>> --
>> 2.34.1
>>
