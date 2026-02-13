Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C64CEF48F0
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 08:52:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B89A83015;
	Fri, 13 Feb 2026 09:52:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="U4yNvapm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ktAtIgEl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75E2383AAB; Fri, 13 Feb 2026 09:52:08 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E8E780FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:52:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D44aGB1756557
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 08:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mQqcv4yKoQ/gyg3ncKMcPrxpfY9d/L8BAgLDryPKJmc=; b=U4yNvapmtjjvaSak
 lAe6sXtMLzBmxd8LHo0JJrEgkD3NkAfsyGTOny4r+jQ3eZ7vg7E8n/pBbDfKI/Fs
 p4kc5M37t3UR9vFd9p452ow6Ls2XqPPFcMlT5xK7nigtjDX85JBrlOnzbnRDDzWh
 aNoBptuoc803oHvCgn4WA2MV9sE4wa3Hdgq46EMIY6JVFB8gLu8A6oXeFLfXo3FT
 NVbH7YQKEKZQ6OINCBJstPYSkqrp/aDXscbvoyvAmwhD3xVS19gQ81KnmhfEzea3
 bqusqLEK5F7odw0m1WASezdYjjQOmDZzKMpC5+5mmaL9vSafuRWQvlHh3F/mzLrn
 ztE2NA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9mb12mgr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 08:52:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a784b2234dso31886685ad.1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 00:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770972723; x=1771577523; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mQqcv4yKoQ/gyg3ncKMcPrxpfY9d/L8BAgLDryPKJmc=;
 b=ktAtIgElIFGmpSvKIO82aaX0RoNtvCLRdrg+PRfH9F40OtLVkEBuDGvtxFYtf43w2/
 AQskXvBavWUjguqHei17pJgusfAohDuFvNjnAzn8IksDTf1cBIYxvEBmd9FXmcHm9ewf
 fz/S/dIAhKapfD4rYjLVvyBi8c3hJl46xaPv3HUwIHA8OVGFkwuNZ3XjAd7kyg05zOIt
 IxQmvyhN2634RfXyvCto5NhxkdW5MY1YbK8aqJO10kwoUhq6QsjMTMSYjDgci+XYasyr
 2hzJoKHBzy8qlIXVr9i192ThE7a/WvCZj+n/l8MMi6xFiEpU9oVfIvxXGktgK+BUvLXe
 wpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770972723; x=1771577523;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mQqcv4yKoQ/gyg3ncKMcPrxpfY9d/L8BAgLDryPKJmc=;
 b=m1zMJpJLnQmb0uG9YKsJSOWgbq0MBuPorMQR50ByNg4VeBFXilHo4WKOklDT5NHYsq
 v1FR/TkaUzktJoHBAN5kcrUMweLYaI8iRRwOP2+jXV3a9tCm1mYodt2JOoR1eckSpBAb
 bpwLIxvMLVxkm0sAYAjDAbtuGW0V/sRKpIkbUnjugX7aZ+NEbz3K21oTSX0g6tkG+HxT
 zyK4Uj2q6HHJ5iNI1WYlE0bhIfYWGQPwH9FDdjfjVBAp5tbHao5mZA5s6g9vLyDXayfL
 M+FCdz87cEPATuBd5aLxrHnUVbrs+GuJIv+ORIIXsoc5mh0MndVtUS8F9ArIfCN9EsaH
 xwLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcn6EbJ5OhIfv6nC0cR6MTiCZ7ZnMTfnHh4xm8kNe7kqhQNxC0HA/LGyFDRRrQR8dfTVwa/34=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8M4TRF3gOxeFMhGZZ08slB/lI7uG6bob6yZMl4FzZdW77wsKs
 Os00g/iRjv3qQoLWkXSk9Q8PVaMSm6Uq6aXtLNLji5KWdkMyZNzWbrLIJwLQGRNNdw8mhw/qvFf
 Zsi1B/oGixHKNESlQfBZh0kinchT4Jdp5p4lka0H0x/FNF5xYOpsZkVR4
X-Gm-Gg: AZuq6aJ7+uBRVj9f4cqjocJZOoR71oGXw1cJte2eVUv7dO+EcoEoXmyikLwHy/vTb58
 4tK1eQhPI7XkzaFj7Rhw8zVJaJxMB8u3lU7/4s+HXMl+EK+IzBvodk5YkFXBm9NCEbTxG1JkalK
 PNjEoJIVB6+BETM+/x/mRXFdCJeZtRf2QgBYWOStnMYxf4gU2V6rRR/kFgKNl7Xw28t0KPsFDU/
 PrSRcDayFeJg+e5lrmBMm3oVXU81HSCFshZIvqPHrZ6grJ80aPBtXNhI1RCsXujpo3ZgFQxBQ71
 5fkBOA9HH2XtJg6MNZZUgVKAzHUIqhv5k7kc9lIQ2ffOK0HHANRvGEn5aUBoHFRHlp2UiyEFQzV
 Y7drlgbIMqvlK9hpoieNInXOKmm5mRUHthKACphwESdpGuwiTi20j5w==
X-Received: by 2002:a17:903:2c0c:b0:2a9:484c:ff17 with SMTP id
 d9443c01a7336-2ab505fd0b6mr14101435ad.54.1770972722841; 
 Fri, 13 Feb 2026 00:52:02 -0800 (PST)
X-Received: by 2002:a17:903:2c0c:b0:2a9:484c:ff17 with SMTP id
 d9443c01a7336-2ab505fd0b6mr14101075ad.54.1770972722275; 
 Fri, 13 Feb 2026 00:52:02 -0800 (PST)
Received: from [10.152.202.155] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab29965086sm77949005ad.51.2026.02.13.00.51.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 00:52:01 -0800 (PST)
Message-ID: <f9c18852-bbd7-4d60-88d5-39480dec78a0@oss.qualcomm.com>
Date: Fri, 13 Feb 2026 14:21:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] qcom_defconfig: Disable
 CONFIG_EFI_PSCI_RESET_RUNTIME
To: Casey Connolly <casey.connolly@linaro.org>, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, sajattack@postmarketos.org,
 marek.vasut+renesas@mailbox.org, quic_varada@quicinc.com,
 me@samcday.com, michal.simek@amd.com, sjg@chromium.org,
 j-humphreys@ti.com, paul.liu@linaro.org, raymondmaoca@gmail.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260114111624.2321852-1-aswin.murugan@oss.qualcomm.com>
 <20260114111624.2321852-3-aswin.murugan@oss.qualcomm.com>
 <299b5e24-ec98-4adc-aab0-495bb0cf144a@linaro.org>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <299b5e24-ec98-4adc-aab0-495bb0cf144a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA2OCBTYWx0ZWRfX5UebIoF0Ms7l
 COa94H7nzQLSYEBZMgEFl2nQV+Jxa15btnxjcMKM9jLGdGiF/UuAbMgABxjxTnNAVM0ImahJCwr
 uhjWQpfnyJHKmfyipXgnBXsgHQuaxHeNSROyS3MtGuCsIToczzEtZY32c5Oa5JzJrlDCTDNe7UM
 wVcnvRX/d47kUwMBVBoNWia/QP3EN7dstIA6QQ3wk5xBZpiL19V/9sDR6xDhclGsSBAf2n9p+D7
 6dcUXIlQOWvf3JhSv+0c8pkVhfcVPKSldjq+54cDf5Sg6UzBqO6ARaFKwKpcaPi74FQq5tUgG1+
 hGWk4+kJODRhNBxfBT1+k/Z3EhDvJGJ0NtRsHKxYbdU/VGIPqaFXrdcVtYLAU2U8Hll0/G6rQAc
 mTqvZ8pt03o9hGYv1bbO7kSl+tuN5dIJ2O+4pKgTrMUh1MiMqLtwSgW2jj9G3vNo7GLxsQdG2ua
 XdHcDdHbdXUh6M83hrg==
X-Proofpoint-ORIG-GUID: POXy3370fXV0FzQzUU5y2tj5ERu7KSBm
X-Authority-Analysis: v=2.4 cv=asC/yCZV c=1 sm=1 tr=0 ts=698ee633 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9iUq6VEK6GIGJoTCeBQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: POXy3370fXV0FzQzUU5y2tj5ERu7KSBm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130068
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


On 1/14/2026 7:42 PM, Casey Connolly wrote:
>
> On 14/01/2026 12:16, Aswin Murugan wrote:
>> Disable CONFIG_EFI_PSCI_RESET_RUNTIME in qcom_defconfig to let the kernel
>> manage reset modes and handle specialized reboot requests correctly.
> Please disable this in kconfig instead. Could you validate that this
> doesn't cause issues on an older platform like sdm845?
>
> Kind regards,>

Thanks for the feedback.
In v1 of this patch, Tom requested that the option be enabled by default 
in Kconfig so that existing behavior on other platforms would not be 
affected [1]. Based on that guidance, in v2 enabled the new config by 
default in Kconfig and explicitly disabled it for Qualcomm in 
|qcom_defconfig|.

Regarding validation on sdm845: I currently don’t have access to sdm845 
hardware, so I’m unable to test it directly. From the nature of the 
change, it shouldn’t impact older Qualcomm platforms, as the reset path 
is typically managed by the OS/bootloader independently.

I will address the remaining comments and respin the patch.

[1] https://lore.kernel.org/all/20260108143742.GT3416603@bill-the-cat

Thanks,
Aswin

>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>> ---
>>   configs/qcom_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
>> index a210f4dc5e6..0bd87b1f5a1 100644
>> --- a/configs/qcom_defconfig
>> +++ b/configs/qcom_defconfig
>> @@ -6,6 +6,7 @@ CONFIG_ARCH_SNAPDRAGON=y
>>   CONFIG_NR_DRAM_BANKS=24
>>   CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
>>   CONFIG_SYS_LOAD_ADDR=0xA0000000
>> +CONFIG_EFI_PSCI_RESET_RUNTIME=n
>>   CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>>   CONFIG_EFI_CAPSULE_ON_DISK=y
>>   CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
