Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD0AC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 13:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5981C82ACF;
	Mon, 28 Apr 2025 15:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="GUjWDtqc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBEBF82A65; Mon, 28 Apr 2025 15:24:44 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 322E482A8C
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7213f5eaf8=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S9MEp1012700;
 Mon, 28 Apr 2025 15:24:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 q2lvrHpGoPU/frwRUzOODzfYeI6eJXaQGOoYN1ST5/s=; b=GUjWDtqcJ0OduCPk
 oB0gLwK2pVX108shebRmPxrqGleWIA3lpQ9T/7Y/1JFTsWeEs3cjt88H8AMwwYDC
 KEUkTnC+k6lysQPxkSHSS41iv/oFogIENPPHCtR/8DTKxHJ+VhoPvHYQXSw1gtsS
 XL1HS4w8UiIHD1j3sxqwUMAkgY9zQKMkjMRVHZ+6TxjGJD1PkWgAry1tb+LyeURV
 CZfN/wZPYSO03XBh99fZF/HEaxcsfemRPekwTVp7AIeUoqvh3XtH0Dog9YNa0KkD
 rHLfeUWnTPSKkU8nPb2uqt/694TAleo1pbDxBdGeK0fY8fYfTYrwPp3pf6VsD30A
 AfP3uQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 468mwky7b6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Apr 2025 15:24:40 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4C33140045;
 Mon, 28 Apr 2025 15:24:06 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 97110A7AD21;
 Mon, 28 Apr 2025 15:23:54 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 15:23:54 +0200
Message-ID: <fe2b89bc-9a06-4c01-acf4-a4dfb0d0fdf9@foss.st.com>
Date: Mon, 28 Apr 2025 15:23:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/22] arm: stm32mp: implement new STM32MP25 revision
 ID system
To: <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini <trini@konsulko.com>
References: <20250425131533.392747-1-patrice.chotard@foss.st.com>
 <20250425131533.392747-17-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250425131533.392747-17-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_05,2025-04-24_02,2025-02-21_01
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



On 4/25/25 15:15, Patrice Chotard wrote:
> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> The STM32MP25 revision ID are now defined with the OTP102, this patch
> implements this new system.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Patrice CHOTARD <patrice.chotard@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/mach-stm32mp/include/mach/stm32.h    |  1 +
>  .../arm/mach-stm32mp/include/mach/sys_proto.h | 11 +++++++++-
>  arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c   | 21 ++++++++++++++-----
>  3 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
> index 156009f51e3..a9ac49bc5d2 100644
> --- a/arch/arm/mach-stm32mp/include/mach/stm32.h
> +++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
> @@ -212,6 +212,7 @@ enum forced_boot_mode {
>  #ifdef CONFIG_STM32MP25X
>  #define BSEC_OTP_SERIAL	5
>  #define BSEC_OTP_RPN	9
> +#define BSEC_OTP_REVID	102
>  #define BSEC_OTP_PKG	122
>  #define BSEC_OTP_BOARD	246
>  #define BSEC_OTP_MAC	247
> diff --git a/arch/arm/mach-stm32mp/include/mach/sys_proto.h b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
> index 2a65efc0a50..0770f0a0cf6 100644
> --- a/arch/arm/mach-stm32mp/include/mach/sys_proto.h
> +++ b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
> @@ -58,6 +58,7 @@ u32 get_cpu_type(void);
>  /* return CPU_DEV constants */
>  u32 get_cpu_dev(void);
>  
> +/* Silicon revision = REV_ID[15:0] of Device Version */
>  #define CPU_REV1	0x1000
>  #define CPU_REV1_1	0x1001
>  #define CPU_REV1_2	0x1003
> @@ -65,7 +66,15 @@ u32 get_cpu_dev(void);
>  #define CPU_REV2_1	0x2001
>  #define CPU_REV2_2	0x2003
>  
> -/* return Silicon revision = REV_ID[15:0] of Device Version */
> +/* OTP revision ID = 6 bits : 3 for Major / 3 for Minor */
> +#define OTP_REVID_1	0b001000
> +#define OTP_REVID_1_1	0b001001
> +#define OTP_REVID_1_2	0b001010
> +#define OTP_REVID_2	0b010000
> +#define OTP_REVID_2_1	0b010001
> +#define OTP_REVID_2_2	0b010010
> +
> +/* return SoC revision = Silicon revision (STM32MP1) or OTP revision ID (STM32MP2)*/
>  u32 get_cpu_rev(void);
>  
>  /* Get Package options from OTP */
> diff --git a/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c b/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
> index 7f896a0d65d..ac229bdf7cc 100644
> --- a/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
> +++ b/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
> @@ -15,8 +15,10 @@
>  #define SYSCFG_DEVICEID_OFFSET		0x6400
>  #define SYSCFG_DEVICEID_DEV_ID_MASK	GENMASK(11, 0)
>  #define SYSCFG_DEVICEID_DEV_ID_SHIFT	0
> -#define SYSCFG_DEVICEID_REV_ID_MASK	GENMASK(31, 16)
> -#define SYSCFG_DEVICEID_REV_ID_SHIFT	16
> +
> +/* Revision ID = OTP102[5:0] 6 bits : 3 for Major / 3 for Minor*/
> +#define REVID_SHIFT	0
> +#define REVID_MASK	GENMASK(5, 0)
>  
>  /* Device Part Number (RPN) = OTP9 */
>  #define RPN_SHIFT	0
> @@ -46,7 +48,7 @@ u32 get_cpu_dev(void)
>  
>  u32 get_cpu_rev(void)
>  {
> -	return (read_deviceid() & SYSCFG_DEVICEID_REV_ID_MASK) >> SYSCFG_DEVICEID_REV_ID_SHIFT;
> +	return get_otp(BSEC_OTP_REVID, REVID_SHIFT, REVID_MASK);
>  }
>  
>  /* Get Device Part Number (RPN) from OTP */
> @@ -164,12 +166,21 @@ void get_soc_name(char name[SOC_NAME_SIZE])
>  		}
>  		/* REVISION */
>  		switch (get_cpu_rev()) {
> -		case CPU_REV1:
> +		case OTP_REVID_1:
>  			cpu_r = "A";
>  			break;
> -		case CPU_REV2:
> +		case OTP_REVID_1_1:
> +			cpu_r = "Z";
> +			break;
> +		case OTP_REVID_2:
>  			cpu_r = "B";
>  			break;
> +		case OTP_REVID_2_1:
> +			cpu_r = "Y";
> +			break;
> +		case OTP_REVID_2_2:
> +			cpu_r = "X";
> +			break;
>  		default:
>  			break;
>  		}
Applied to u-boot-stm32/master

Thanks
Patrice
