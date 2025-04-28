Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88B3C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 13:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ED22829EF;
	Mon, 28 Apr 2025 15:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Mbx78hfA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F25482AC3; Mon, 28 Apr 2025 15:24:58 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCC1682AAA
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7213f5eaf8=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S9WhTh010761;
 Mon, 28 Apr 2025 15:24:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 vmvcWTo/bdapMmDCuJ60yI81JjdJgywqx0zV5nOh9QM=; b=Mbx78hfAD/pKfZnY
 m4DbLqFGf35s8ae9CNSrP8cFPJV8hGB7a4YbwL9TC20Eg2/lgqWbNLa2ZTpn1+/w
 mBlbKckPYw3sWaRdOlI3RagZxHdW340BYEe77sxxMe6w9jmGwd05PhcNyx/Fn2ka
 1yBNolVIr0N9vMZC6XvQX82ZqOT8hM3vGQU2wB8tvKLiQNZj2p92oTBqu6fuuEat
 EEF2TdXEM/7c8guEyFFcibwQydRKtAwOEBlPCPHdO0+3tv4o1Jp6t69fj3buU2Xy
 ZDMOv/U9m6QQ5+5Ofwy2NNU0+I5mUl1DO33C9cT8HKC3c9pubr/ucKG2iTzPFgVC
 uwklDg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 468pcg6qp9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Apr 2025 15:24:54 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 146154004C;
 Mon, 28 Apr 2025 15:24:11 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D20BEA7E604;
 Mon, 28 Apr 2025 15:23:58 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 15:23:58 +0200
Message-ID: <9d85d045-67b3-477e-9d97-303d92705de0@foss.st.com>
Date: Mon, 28 Apr 2025 15:23:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/22] arm: stm32mp: fix package IDs for stm32mp25
To: <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini <trini@konsulko.com>
References: <20250425131533.392747-1-patrice.chotard@foss.st.com>
 <20250425131533.392747-18-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250425131533.392747-18-patrice.chotard@foss.st.com>
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
> Fix package IDs for stm32mp25.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/mach-stm32mp/include/mach/sys_proto.h |  6 +++---
>  arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c    | 10 +++++-----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-stm32mp/include/mach/sys_proto.h b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
> index 0770f0a0cf6..bf1c39742c1 100644
> --- a/arch/arm/mach-stm32mp/include/mach/sys_proto.h
> +++ b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
> @@ -89,9 +89,9 @@ u32 get_cpu_package(void);
>  
>  /* package used for STM32MP25x */
>  #define STM32MP25_PKG_CUSTOM		0
> -#define STM32MP25_PKG_AL_TBGA361	3
> -#define STM32MP25_PKG_AK_TBGA424	4
> -#define STM32MP25_PKG_AI_TBGA436	5
> +#define STM32MP25_PKG_AL_VFBGA361	1
> +#define STM32MP25_PKG_AK_VFBGA424	3
> +#define STM32MP25_PKG_AI_TFBGA436	5
>  #define STM32MP25_PKG_UNKNOWN		7
>  
>  /* Get SOC name */
> diff --git a/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c b/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
> index ac229bdf7cc..12b43ea5cdf 100644
> --- a/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
> +++ b/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
> @@ -26,8 +26,8 @@
>  
>  /* Package = bit 0:2 of OTP122 => STM32MP25_PKG defines
>   * - 000: Custom package
> - * - 011: TFBGA361 => AL = 10x10, 361 balls pith 0.5mm
> - * - 100: TFBGA424 => AK = 14x14, 424 balls pith 0.5mm
> + * - 001: VFBGA361 => AL = 10x10, 361 balls pith 0.5mm
> + * - 011: VFBGA424 => AK = 14x14, 424 balls pith 0.5mm
>   * - 101: TFBGA436 => AI = 18x18, 436 balls pith 0.5mm
>   * - others: Reserved
>   */
> @@ -189,13 +189,13 @@ void get_soc_name(char name[SOC_NAME_SIZE])
>  		case STM32MP25_PKG_CUSTOM:
>  			package = "XX";
>  			break;
> -		case STM32MP25_PKG_AL_TBGA361:
> +		case STM32MP25_PKG_AL_VFBGA361:
>  			package = "AL";
>  			break;
> -		case STM32MP25_PKG_AK_TBGA424:
> +		case STM32MP25_PKG_AK_VFBGA424:
>  			package = "AK";
>  			break;
> -		case STM32MP25_PKG_AI_TBGA436:
> +		case STM32MP25_PKG_AI_TFBGA436:
>  			package = "AI";
>  			break;
>  		default:
Applied to u-boot-stm32/master

Thanks
Patrice
