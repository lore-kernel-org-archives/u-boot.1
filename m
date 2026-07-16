Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2995AC44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 06:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5BA084BA1;
	Thu, 16 Jul 2026 08:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GKlu2hOH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CFF/Tqlg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6131C84D86; Thu, 16 Jul 2026 08:35:39 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 994E684A0A
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 08:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=badhrinath.s@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G3wX5d1610244
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JgBmY3WYQEfMAUQmFe7apv/MM03RksdHmv6jaJer/Rw=; b=GKlu2hOH59Doo3FN
 UUsjiy0ouqx0yYmOP6ljFjhNjcE+q1xFTQ4EyWForJiz2Mo7EmRGiK//EW8TblrV
 jCOAKIomlYcsu8EMYYnZsIUHknC3KYt8gS1mOfqRQTp3CF7tkDG5qKgg8g+C5qgp
 sKmLDA56Dk1rEabDnhOYpoXDuQGUiZvqvH2TVa/Y2nw668LWgHRwczlRxhegK0Ts
 o840h/ZkksM8AqROuMR1vbD9Eyks1FKXs+DhkyqxIZUFyXKSTvWVZVFBZFrXY10T
 zWGxm544Ie0XhnfOMY1D0OkXnHU88iXRdV2hJ1Ja/CU25wwD+omfyj8APR0k9ngv
 y1Y35Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feayfkjkw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:35:34 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-381250979d5so3707020a91.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 23:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784183734; x=1784788534; darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JgBmY3WYQEfMAUQmFe7apv/MM03RksdHmv6jaJer/Rw=;
 b=CFF/Tqlg7QyC1P6QNMFYDMIXrxAG6nl7/PzsdA1RHTWSc++TVmzMaskUCdveRjMyCc
 0C9SdLzDVyFqzM+LzzA2AyUQ5NwOSmNZTmQpHeIupRo5XMfmK11e1YJJHZgdlGULNLch
 mlJ59B4eJEdTloE9hncVN9jr1v90vt0X/uR62hGq/xr0/0rNP76zhPVig1Ojhj0qmpqr
 tVNWE9T/t1GFQccDxhVcGYAxVZzd/MdUK2EcLlwaePAzoKFR4axMHsn8BsCAr2h/I6uW
 UbUUYpbIiO9rIpJUedFyGbr31+2coOcHeW48qYxklkm7OHl2jOic3VOdJrHhPMPCtZk9
 pvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784183734; x=1784788534;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JgBmY3WYQEfMAUQmFe7apv/MM03RksdHmv6jaJer/Rw=;
 b=VDmPLjjQOS/Vx4rJGPBHKWUag0MziIJvyO2RJBNinnEat03gXhkQGzwbijiov2HcDP
 Dc2mnwT4C0wMw4gYRl7Jj3RRzuqJG5IJcAnNZTWlJIgCeI6z4P0CB2kVz4tkQ0GD6BjT
 +an+lZNGU2o/nXIkU96oECLjn8mQAYWlvgFijbwUejAsnY5/WpFZtnQbFWkFP+lxmRpG
 2sSgX63xZm95qqgkT2N5Y+1M2whkTOgNrey1QOwqHRYCi7F3+yzoTY18erSTu19TtjMe
 njhXX7hL8PqxVXi8rjnjL9AyTZRkbC6tpcDc83+wa44NeGFNy8vkoK0xtPo9NiTxxN+3
 2JdA==
X-Forwarded-Encrypted: i=1;
 AHgh+RruBzbiwebL394C39fXRZ+9caWZY6G5n5yg9GlyoclSLa73REwYw0fPu2OOK2EeH+OGWxHgYxI=@lists.denx.de
X-Gm-Message-State: AOJu0Yzddkqc7zN54uKTDgfCZKEkyIWjc/AzB4/lT2Vj+4UY+e72old9
 f900zHjTeEZ1zW3LvBww9CLIkrdWOA7E53EKc0VoxWCKICpa2LJbeyXmoWQ2N4naraJCjmGRUM5
 UmBqsA1pYSD/UIghl0vYDvAo7TpSLLO6ZpzBYtpie1Q0AUCRBCnkF65zm
X-Gm-Gg: AfdE7clM1POFzCzvd6awoxULlCyG17jpH275czlLwarAzOjxMI10wDbMj7A0J4JHrSO
 XmT6dhuCchtJ/rOAOK644S40OC0nDyQcCp02Px0AjAqSwJK00ahQoIgytQK50MGrr7556MV3NJb
 stiCoGSKqApHVD8+XKevfDpQBEh4v1uzzBbdB+JsVKPLxHeTvHW1dm6aibg1owXlo5WQLc4t0VG
 6IM9pCut8Dw2ZCf8SrjOgKZSSP9vCiXwe7DKfkxoH9D9VBnsCcdcRCHc9syquxb0u/s/GsGlbdM
 k7NuJnYJIEKjku/YSN31CN4CHjrQ4D8/Zyr4iSCECYsR0aC0aXF3AFajpz+PNumEhOH/SiLo3Fa
 EssCaZ8rpIw2mu1MzdGWpEyw+bz6E+Os=
X-Received: by 2002:a17:90a:2ec4:b0:38d:adae:4866 with SMTP id
 98e67ed59e1d1-38dc7b3f843mr14589684a91.21.1784183733999; 
 Wed, 15 Jul 2026 23:35:33 -0700 (PDT)
X-Received: by 2002:a17:90a:2ec4:b0:38d:adae:4866 with SMTP id
 98e67ed59e1d1-38dc7b3f843mr14589659a91.21.1784183733527; 
 Wed, 15 Jul 2026 23:35:33 -0700 (PDT)
Received: from [10.152.205.146] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6a4866sm7751658eec.18.2026.07.15.23.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 23:35:25 -0700 (PDT)
Message-ID: <1d523357-554a-47ef-ab2b-b57d54a87961@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 12:05:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] configs: Add defconfig for ipq9650 RDP488
To: Casey Connolly <casey.connolly@linaro.org>, trini@konsulko.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, quic_varada@quicinc.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 adrian@mainlining.org, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20260610053655.2825589-1-badhrinath.s@oss.qualcomm.com>
 <20260610053655.2825589-5-badhrinath.s@oss.qualcomm.com>
 <a8c66666-ca2a-4b0c-bb25-cc0fad03cd9f@linaro.org>
Content-Language: en-US
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
In-Reply-To: <a8c66666-ca2a-4b0c-bb25-cc0fad03cd9f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: t6BxYNxq48AP_l_blobVY49yCmXy-1OH
X-Authority-Analysis: v=2.4 cv=WoMb99fv c=1 sm=1 tr=0 ts=6a587bb6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KlnjcT9MnwYKpkHRW_EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA2NiBTYWx0ZWRfX9y/hjEICYkg1
 r1XrJhxXTFyywXMMGneIYwVb/lgNf9uB6qu9GyE0g0h2WwvOq1vDl+nemF5hNQT0+ho8IZP7C6e
 H6LxYEDxGINBKedyKkf/LrmVlBjTry20uo61WQttY4ddny34BK83TKHDAXclSz2krA0Kdkkmby1
 HYX2L1qwBqocVjHLCXlXMw1n9roRM5eDGzEeqgkVjRWWCJ6ohYS//48xH2BVp4wEdDTDvMS0WIX
 ZEd83BbOeejIIHLFpTUihip9VDH5CrwfufMzAAb+HfCOn4Wrc1Q65fYMEm9ZzItF9nMCvr7NglJ
 54NSsdJDe/Ww4wUAN/eN6msKPRcn0drr3cEc//NiWPSec6VhWrZfoLyL4MxiXgwjWBTOERNW49B
 Z8Ak8+1DyM1fyWvEWNLabxaGorLqF3v3OqW6iBVbz9SU8KXlSUb3fNRKc3AuO0grp8kIFlKPNUY
 aqUdmsudDFg81qdEkSw==
X-Proofpoint-ORIG-GUID: t6BxYNxq48AP_l_blobVY49yCmXy-1OH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA2NiBTYWx0ZWRfX9iiNWUwY7hoJ
 5nWGTt2Ukbm9q63MCnTtsgVOfOcVg/RKaTl4pw35C7tMlvEaekn+FDyOO99LfwinTOBy+2A32Y9
 /C+ZN/d3TfYWmdQ7JfcUBxgwDOSeKOk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160066
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

Hi Casey,

On 6/30/2026 10:01 PM, Casey Connolly wrote:
>
>
> On 6/10/26 07:36, Badhrinath S wrote:
>> Add default configuration for the IPQ9650 RDP488 board with eMMC boot
>> support.
>
> Do we need individual defconfigs for every single IPQ board really? 
> One or two sure but at this point I think we ought to have a common 
> fragment that they include with the base stuff so we can keep things 
> in sync and differentiate the platform specific options.

The common IPQ configs have been moved to qcom_ipqdefconfig, 
while qcom_ipq9650_mmc_defconfig contains only board-specific options.

Link to v3 
https://lore.kernel.org/u-boot/20260716062318.4121929-1-badhrina@qti.qualcomm.com/

Thanks,

Badhrinath S

>
>>
>> Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - No changes
>>
>>   configs/qcom_ipq9650_mmc_defconfig | 57 ++++++++++++++++++++++++++++++
>>   1 file changed, 57 insertions(+)
>>   create mode 100644 configs/qcom_ipq9650_mmc_defconfig
>>
>> diff --git a/configs/qcom_ipq9650_mmc_defconfig 
>> b/configs/qcom_ipq9650_mmc_defconfig
>> new file mode 100644
>> index 000000000000..ce2488d72eb1
>> --- /dev/null
>> +++ b/configs/qcom_ipq9650_mmc_defconfig
>> @@ -0,0 +1,57 @@
>> +CONFIG_ARM=y
>> +CONFIG_SKIP_LOWLEVEL_INIT=y
>> +CONFIG_POSITION_INDEPENDENT=y
>> +CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
>> +CONFIG_ARCH_SNAPDRAGON=y
>> +CONFIG_TEXT_BASE=0x8a280000
>> +CONFIG_NR_DRAM_BANKS=24
>> +CONFIG_ENV_SIZE=0x40000
>> +CONFIG_ENV_OFFSET=0
>> +CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq9650-rdp488"
>> +CONFIG_SYS_LOAD_ADDR=0x90000000
>> +CONFIG_DEBUG_UART_BASE=0x1a98000
>> +CONFIG_DEBUG_UART_CLOCK=14745600
>> +CONFIG_DEBUG_UART=y
>> +CONFIG_REMAKE_ELF=y
>> +# CONFIG_EFI_LOADER is not set
>> +CONFIG_FIT=y
>> +CONFIG_FIT_VERBOSE=y
>> +# CONFIG_BOOTSTD is not set
>> +CONFIG_OF_BOARD_SETUP=y
>> +CONFIG_USE_PREBOOT=y
>> +CONFIG_SYS_PBSIZE=1024
>> +# CONFIG_DISPLAY_CPUINFO is not set
>> +CONFIG_DISPLAY_BOARDINFO_LATE=y
>> +CONFIG_HUSH_PARSER=y
>> +CONFIG_CMD_MMC=y
>> +CONFIG_CMD_PART=y
>> +CONFIG_OF_LIVE=y
>> +CONFIG_ENV_IS_IN_MMC=y
>> +CONFIG_CLK=y
>> +CONFIG_CLK_QCOM_IPQ9650=y
>> +CONFIG_MSM_GPIO=y
>> +# CONFIG_I2C is not set
>> +# CONFIG_INPUT is not set
>> +CONFIG_MISC=y
>> +CONFIG_QCOM_GENI=y
>> +CONFIG_MMC_SDHCI=y
>> +CONFIG_MMC_SDHCI_ADMA=y
>> +CONFIG_MMC_SDHCI_MSM=y
>> +CONFIG_MTD=y
>> +CONFIG_DM_MDIO=y
>> +CONFIG_DM_ETH_PHY=y
>> +CONFIG_DWC_ETH_QOS=y
>> +CONFIG_DWC_ETH_QOS_QCOM=y
>> +CONFIG_RGMII=y
>> +CONFIG_PHY=y
>> +CONFIG_PHY_QCOM_QMP_UFS=y
>> +CONFIG_PHY_QCOM_QUSB2=y
>> +CONFIG_PINCTRL=y
>> +CONFIG_PINCONF=y
>> +CONFIG_PINCTRL_QCOM_IPQ9650=y
>> +CONFIG_DEBUG_UART_MSM_GENI=y
>> +CONFIG_DEBUG_UART_ANNOUNCE=y
>> +CONFIG_MSM_SERIAL=y
>> +CONFIG_MSM_GENI_SERIAL=y
>> +CONFIG_SOC_QCOM=y
>> +CONFIG_SYS_MALLOC_LEN=0xC0000
>
