Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63167CD5BD0
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 11:16:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9C3F844CF;
	Tue, 26 May 2026 13:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mTkj9uIh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vh1/HqpK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A80C2846A5; Tue, 26 May 2026 13:16:15 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCD3980433
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 13:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q8Ig7S691624
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 11:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W2B198f7jydmusa9mLWfn5O52B+Wf3cGLMmV7jOJRa8=; b=mTkj9uIhdFYOdnqN
 uM7TrWHNyHlaMKfro7sgo/7RaOXXLJ15gifzK3X/EqAfx/bckkRu7FxiQ2d454Po
 7kGtrT1Zu1jFD/rMfFAkKK83If16A2vx9ouMqTTnzZr58OlApgfgC3YTZJGCR1Sv
 Bf6YpZs+HnefL1MazYjAlrdDUQYJjYxwOl371jacfyTaWFtAz+1ip05odFQ65nFp
 MAaw4XQ4vghDaF4LWvW9Pu2D4/wyltpz/inHqjkkZVbSufGl8NmgZ4f371YA0qPT
 i2weM/aDlMr5TeyLmQV2CmniwWCuptdY0aqWV7Nxf2H1II0YbOJkVlo8GDldpxCP
 FjV7sA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecpy2ktyg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 11:16:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2be9e0905a9so67164845ad.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 04:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779794170; x=1780398970; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W2B198f7jydmusa9mLWfn5O52B+Wf3cGLMmV7jOJRa8=;
 b=Vh1/HqpK9iSr+BYatm+hSANprGBSs3d4WufizyNWOrQsa6HcMRHVyFvLCLY8+cuESb
 xdjXDdwAPb6xjUehpxlg1g4ZhfmLDu7AGvkXYuSVNPQW+262e0JgPbJcEydW5wKTM2BN
 hAPAUJwlWfydhY48Sk3A80D/Qga2d8w5ddp7kQCdvz8EkWg9JFhPwnovJ4GUipRp256T
 d0mbdPZTdTMUkol/0bGPG0+8NATGt9G+lSCg1TLQEt0NLZf8RNOi0fO2PhAywZCB1M8p
 1i08XDwbSKMfCmj9EFj5XbkkM7oKVbS46ifDW8fGcY0LuGjPDrFCV/ExuPi57FAE+EI/
 MuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779794170; x=1780398970;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W2B198f7jydmusa9mLWfn5O52B+Wf3cGLMmV7jOJRa8=;
 b=OnG5wqbeEUGbkxH3lhoF4q+mHmk+7n8v7x+1mVBsQ6JEeHJVv7iORpeyBhdb9z9XHx
 eFpFQ/j045UWVp1Ht7XNBu5sDlnBKehcK8+41PsY2V+u5ZplrLaKDWRjI4I3NSZiQror
 jHKkjCcfl9MEqzRWsuUCf2L5CTgMqvYjB9TdGGb4W9dBuZ6LLlcASUTWa6ZytvxrdpW+
 napSPnBMqzKJHxgdeBJNunsYGiYMjtEKo84Wq3YgHTDDBtQSR994i8A1sE+V98m9eKt9
 J/KoTxrshQ53cDHdnIqt0Hk2IoHYd+OOB3IFwY1TWwUfbJUugLyOyO1s7A8jHrMGH3OE
 5AYQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cwrWIfUITuViH4BGKTCDFrADEyAlGkY/zgpE/+PZvJWajD6v+sU79KWsawB3+z2Y/TP2GiU0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6abiFn36psGWNKn8qW2OZDO+bzxUe49M7dts2eVQB883sgyMs
 Qj1ayntWkjBkpkog6r3R//7PS9wffHHTkBHYbqOmwyue0356cuOuKUmwK8qIJW6ddABQHK1RXoG
 V8hZjS9ymgZSdAaQma91YfBT1GuyTZsUycoyTYA7yNwipLH7siXsyWw5B
X-Gm-Gg: Acq92OGYEiLZBnKtXO2ityrGKphiESInGyB/G9+H74ZJ/+MlJsJQ1RlS/FptD65Uk7w
 6Ud8t5ZGJAAD5NB/WJiHCDt2dldcbjEhQWBqjrvQbpAAB5Pk9DVau+oECLe6o6Wc0Mmm7XhY985
 sG5IxrMHk3i6Rsicx8y9YSyWefLryGSgDLFaB/Xgi4r7nKbE3OwKgaym+Pci2vgJ5g37LhlyGM1
 SFBWCUYm3qI4UXnMk20S64eWfLg0Sk8Y7aANEdJxhORdOnQuiJB2CYlwS7Dnj78Ux4hh36ANHkQ
 DK/MpdkcsxRn67+OV3PmUpak5asjjJxH5O5hNwLSXg0wpbyMM5EPOgnwjk0gz5HiUETj+UoKHwP
 Xegm3JE180JKoVr/u+B8c7xo4kIz4ju+lB45Cj0Owogo5ezIEuyEjNVZEHRA=
X-Received: by 2002:a17:902:e74b:b0:2bd:9803:9304 with SMTP id
 d9443c01a7336-2beb06cae35mr193953985ad.39.1779794169879; 
 Tue, 26 May 2026 04:16:09 -0700 (PDT)
X-Received: by 2002:a17:902:e74b:b0:2bd:9803:9304 with SMTP id
 d9443c01a7336-2beb06cae35mr193953425ad.39.1779794169330; 
 Tue, 26 May 2026 04:16:09 -0700 (PDT)
Received: from [10.152.203.87] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56e090fsm132661015ad.34.2026.05.26.04.16.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 04:16:08 -0700 (PDT)
Message-ID: <7d37b9e8-3d2a-495b-8f82-4e050f246eb9@oss.qualcomm.com>
Date: Tue, 26 May 2026 16:46:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] board: qualcomm: Remove SCSI scan from default
 preboot environment
To: Sumit Garg <sumit.garg@kernel.org>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 lukma@denx.de, aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 david.wronek@mainlining.org, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, jorge.ramirez@oss.qualcomm.com,
 stephan.gerhold@linaro.org, quic_varada@quicinc.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260126155938.2717540-1-balaji.selvanathan@oss.qualcomm.com>
 <20260126155938.2717540-4-balaji.selvanathan@oss.qualcomm.com>
 <aXhoa9sfIhoMZWq0@sumit-xelite>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <aXhoa9sfIhoMZWq0@sumit-xelite>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kNq_9vExflI6RTa-O3DxjMu1gfahgE6I
X-Authority-Analysis: v=2.4 cv=ML5QXsZl c=1 sm=1 tr=0 ts=6a1580fa cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=lb_3VvnxRs7MilF6PRQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: kNq_9vExflI6RTa-O3DxjMu1gfahgE6I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5NyBTYWx0ZWRfX/wU1Yhk5c+/q
 b3Baj9OXJQf5G0lNKeOm+mXXWUyl05L5N1XlYeJ2KcL+irKsiJO5snfSMhzpL7MBtgfbQgFELQJ
 fG3/+35X05vPV/Zd2bML3WCdinp65v43cANcZ369ZnoZyD+aekuh4VoXdw6ciZCa7GF7D+fyvmk
 M7t+JcXAHmi2+l8Yw1YWPisCTfGL4TPqpSyKQiBZBIxj6o+25PJUkqBwnXB0jXtI/UXSFt/FkID
 t/gDm5kIjExvdeTYa/bCX2U+AMfCNM9rVgOqEtNIrBKK5NgjcY1v/InF3Iy47To2XVxaa98vxQU
 IGU1dFFhm2mUrE+XEY4OWQ9C5Cstwo8IuwxViotsPjs7Ki89Lvtndjd43iJ67UmPCgWC4vzNMFj
 zbbqlwwqfvUwvqO1OXRQFPinnil7tUZ+7tUyRmJNU4m3sMel3HLab30IyHm8cKoT+KCAUGm9rtD
 5wuQ9NB6VTvU8QF35hw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260097
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

Hi Sumit,

On 1/27/2026 12:55 PM, Sumit Garg wrote:
> On Mon, Jan 26, 2026 at 09:29:38PM +0530, Balaji Selvanathan wrote:
>> Remove "scsi scan" from the preboot command sequence in the default
>> Qualcomm board environment.
> This is the default environment configuration expected to work on all
> Qcom platforms, wouln't it break platforms supporting UFS boot?
Codes requiring UFS access usually calls scsi_scan. Hence, it is not 
needed in preboot.
>
>> The SCSI scan command fails on eMMC-based
>> boot configurations, causing unnecessary boot delays and potential
>> error messages during the preboot phase.
> Say if UFS isn't supported as the boot target then this SCSI scan should
> just bail out. Can you share the error messages and boot delays seen
> here?

We get following error messages in eMMC only platforms:

"Unknown command 'scsi' - try 'help'"

Regards,

Balaji

>
> -Sumit
>
>> This change improves boot reliability on platforms using eMMC storage
>> as the primary boot device.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>>   board/qualcomm/default.env | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/board/qualcomm/default.env b/board/qualcomm/default.env
>> index dbf6f4e7260..7cfa8e0ce2a 100644
>> --- a/board/qualcomm/default.env
>> +++ b/board/qualcomm/default.env
>> @@ -1,7 +1,7 @@
>>   stdin=serial,button-kbd
>>   stdout=serial,vidconsole
>>   stderr=serial,vidconsole
>> -preboot=scsi scan; usb start
>> +preboot=usb start
>>   fastboot=fastboot -l $fastboot_addr_r usb 0
>>   do_boot=bootefi bootmgr
>>   bootmenu_0=Boot first available device=run do_boot
>> -- 
>> 2.34.1
>>
