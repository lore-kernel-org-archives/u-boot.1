Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F18FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 16:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2258C84106;
	Mon, 27 Apr 2026 18:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fL1P3RTq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jAvPwYEj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DE618416F; Mon, 27 Apr 2026 18:59:51 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFE0B8407D
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 18:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RDtg0i241408
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 16:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5PXmkjRtm1QVemN/rC8DLPegUaxCl+ZS8qI2KbBExsQ=; b=fL1P3RTqER0ralyI
 NmFfWN8npLGIRjLFCjXLm2hYnOz2bYkZy3oYWBBn4ARFurlphQ1oW1GnGyLLvKUj
 LI3TOSFBbJb7ygCNxjivbsru6buv0FFC6rN6vERJyvthbGFUPzR7A2f9YZcZ3GfJ
 glBMAnk590BGF/LDSkrtvqmvGpyQalAO7b+E3RFXrdq0p4QIqLyUZpJ4+H4bnuJU
 P/oJXcfq1Wtv9fq70mQ5a2nm8sj+r16Z9xTnTs3sFU+Tpq1QqWNjHuBcBBpPl5+9
 qhIDxT4DXh8SfGuSRS6pFGnAYNKjoHuFegwBNfe5hcrV4m+P++/tcmNQMHRS0/tX
 92Q+fg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt946rpux-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 16:59:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b465bf993cso107037065ad.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777309186; x=1777913986; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5PXmkjRtm1QVemN/rC8DLPegUaxCl+ZS8qI2KbBExsQ=;
 b=jAvPwYEjVi6ZSEeipW53N/S3HR0BoTNK9HMwmV7ahf+TvjkAyxwa4G5+aLPUYCuSoR
 fm+atbUOEu10TAT5bfcs99ZbXQXYjceR3n5Ih+rNBWFUXihCw8gRX/vTGFe6SAKTWwRL
 vdR21BagcfJVdMSq4pOc2yOnsYf1ar4LNdDfqih0xeM3MGvX9UcFMN2oRQ/nJhZHcBZw
 jSoOL7NE21m8QqjjM5Ss9SrW7d32i+MKm6sQHKNs6ePNVVlrRSUtMr1YPZkUF+wP63ap
 iyvcIljpO7hGVWX7+44VsbfG4x1Z2kf6J9u6CiGGDEh6khSQrwDBtPwi6AkZ6HtyZb70
 yXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777309186; x=1777913986;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5PXmkjRtm1QVemN/rC8DLPegUaxCl+ZS8qI2KbBExsQ=;
 b=p26lHJj2oJHrOv0CRL26k0htx+yTKLkT8i/RnNKSylTG5seSRVFpkyl6A30XIoOS1s
 6ynFvr9wOm4Gcl0lPHq/hTaQbGNs0zboe1zO9YsBLo88kOr0BdZ88m+IlpNoauhmeIRS
 eW0SkFFVsumx6HuFOmO1IvROpPg9mXrGbq9PPd6PhT2UlyZpwSFLMzMNYa3QEDG9Z2Yx
 7h49z6NmkIuaXckAeh6OTYDJPs2tFqH9y437fFfYp1y/rWb3u0tsXlZ45+WAaI4dSVL0
 YXqDcoXIhWdhKxterTRt6uc7T+OUmPvTosZAgTqe819f63u0zrmUalLJucElsyK6kL9n
 +nhQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+NasewdCN62kS2wSJMx16qkU19MZyyDIJ3A1OmrTHppN6aGi/LIE/dNVsLKvrtSFPB5ANfDaY=@lists.denx.de
X-Gm-Message-State: AOJu0Ywt9Xnsl8jFBPqmw1Re1LgNnCyDSLRy5pGRVXidPnOTBLxkHISg
 Kfiuy0glReg2uGBK0F7e/fgWwwyl6VX+8En7swe6QKtFdrzq3i4Ar63JoYU3AlE3/9j7VxaM8W1
 CJRNU3slahSe0YFZyJ6FgEisTIH05+Pzo/sNv5pFlt74rHn7GkcBisFYo
X-Gm-Gg: AeBDieuM/+sIUd8TqxiuG1YWj5s0qVA+tl1FMSXCLI7DLhEvEYd9Q3bdfJrikONoPda
 Uj622IHP6A/RI0Ld82d9M+g5GeyoYZbwu8DNjFMUwGT8QIazLNnyC87YOcwF7DAYoMRwYW4cJDD
 H+N7YES5guDh2zDEngZloo0C/KeLoLh1Ji3F9QXM8cdXliIiGJpFwR8g4GH00uaGJX0VnuALdAo
 OUm2ZjPIb/03XPdF51bPN7BMgK0O5577WfSlkot+jPw0HjUUC6poVWAFGRTgoqa3J9kaCmCia70
 1YsmygGOzNN22Fs2PZhoBlJeuFuJYJGtzkwva3+xogQ1AE4vP95Z5GHFOsyYNACiCVGeDhKQAqm
 /XXiyAvdXbAHCSH77W0ZuB0iKgqX7+n4QLNarvbs8gvcvYYEyle37WGsML6oUU3U3rbJU
X-Received: by 2002:a17:902:ef01:b0:2b0:6e6a:8504 with SMTP id
 d9443c01a7336-2b97a97ffcemr317255ad.27.1777309185950; 
 Mon, 27 Apr 2026 09:59:45 -0700 (PDT)
X-Received: by 2002:a17:902:ef01:b0:2b0:6e6a:8504 with SMTP id
 d9443c01a7336-2b97a97ffcemr316985ad.27.1777309185400; 
 Mon, 27 Apr 2026 09:59:45 -0700 (PDT)
Received: from [192.168.0.3] ([49.206.96.228])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab29398sm317918295ad.66.2026.04.27.09.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 09:59:44 -0700 (PDT)
Message-ID: <d62fa57d-d85e-4d25-9d3a-1d656c60491c@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 22:29:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qcom_defconfig: Switch Qualcomm fastboot flash from MMC
 to block
To: Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
References: <20260216-fb_block-v1-1-4e2d286bae76@oss.qualcomm.com>
 <aZgk1rZKhCW_7A2F@sumit-xelite>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <aZgk1rZKhCW_7A2F@sumit-xelite>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YcWNIQRf c=1 sm=1 tr=0 ts=69ef9603 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=mDd7tLh7uscPtaIqipyRMw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rn4jriIOuBEFGMEBRwIA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: b-Z-J4FCpHUxDOIrSyWvwCTFkvAWNVqz
X-Proofpoint-ORIG-GUID: b-Z-J4FCpHUxDOIrSyWvwCTFkvAWNVqz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE3OSBTYWx0ZWRfX1qvqDHNt9fHd
 8oznEIwOBBBbYlibsy4+N0eZ90rtJAqWquQa8FjzazOl2LVVV3G2A7cSatiW1Q7IcIzN+QpSUnp
 cO1HJI31Ykr171KYAfgYpdzl2u9RsyGYyVmaBbrIiztoxlHH7jc3JhAYhyP+9W1zVzkqhQPGPBN
 bg/TAhWWleig+z3aVnas0aknJRbVmU5SDD1QfHWmvoRS8ELz/8f8pg+Ui5Ga8mA2W/7AIP82LL+
 nNaFbPvNKnczqjwcEETn+chWMfWBgbBwb+inc/oX/VsNhWNgAWflVliXcsA5Gxhj3bzYJjDW60T
 4OcSjkVkZ+z56Uv4IN/mp/V+3YpXSPRfVCeXXqFqsJ5+GXjFmMbCMvJf76hoOswMrWU+nHXYsaU
 30kGfsXtGo4bpX2DzG+Ka0UkhsXZIBXVdXwzsn7C+Gtl5U+wec7J9VkGmkX6h9SseComaKnviPd
 rdCyC1+MyJVOpeWRpVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270179
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


On 2/20/2026 2:39 PM, Sumit Garg wrote:
> Hi Balaji,
>
> On Mon, Feb 16, 2026 at 09:45:49PM +0530, Balaji Selvanathan wrote:
>> Replace MMC-specific fastboot flash configuration with generic
>> block device support for Qualcomm platforms. This change switches
>> from MMC device 0 to SCSI interface with device ID 4, enabling
>> fastboot operations on UFS storage instead of eMMC.
> I don't think if it's right for qcom generic defconfig to hardcode
> fastboot flash device. Can you try to see rather if the fastboot flash
> device can be determined at runtime? As otherwise it might end up in
> target specific defconfig which we should avoid if we can.

Hi Sumit,

Implemented the runtime determination of fastboot device in : 
https://lore.kernel.org/u-boot/20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com/

However, I think we need to assign 
CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, so that if user doesnt provide 
device number in the fastboot commands, then we can use the device 
mentioned in CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID as default.

Thanks,

Balaji

>
> -Sumit
>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>>   configs/qcom_defconfig | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
>> index fe5880de1fd..2666adb0569 100644
>> --- a/configs/qcom_defconfig
>> +++ b/configs/qcom_defconfig
>> @@ -77,8 +77,9 @@ CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
>>   CONFIG_USB_FUNCTION_FASTBOOT=y
>>   CONFIG_FASTBOOT_BUF_ADDR=0x0
>>   CONFIG_FASTBOOT_FLASH=y
>> -CONFIG_FASTBOOT_FLASH_MMC_DEV=0
>> -CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
>> +CONFIG_FASTBOOT_FLASH_BLOCK=y
>> +CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="scsi"
>> +CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=4
>>   CONFIG_MSM_GPIO=y
>>   CONFIG_QCOM_PMIC_GPIO=y
>>   CONFIG_DM_I2C=y
>>
>> ---
>> base-commit: f9ffeec4bdcf1da655a0ffea482062adde78fee8
>> change-id: 20260216-fb_block-6193ec15ccf6
>>
>> Best regards,
>> -- 
>> Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>
