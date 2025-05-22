Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B3FC54756
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 07:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AC9482FC8;
	Thu, 22 May 2025 09:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YuCpE5hx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0FA282FCA; Thu, 22 May 2025 09:50:06 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED55E82F67
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 09:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54M7o2X01740422;
 Thu, 22 May 2025 02:50:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747900202;
 bh=WegBvcDKQbKpxfWszriLl8w6SHk+dpz6SU7WUvCwnEk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=YuCpE5hxg0ECViCsaghHCJsR3Z+dmV8LZkrRZp97znzgm8Ja7X0p0eRR2SwcFjFHU
 DQWHV15Qx56DValg8igDIE38c+t0cI7rDgsqxGkxKjuexCrgtSsRF5OE/W/ykJ8nTZ
 yZNH+oA7s370Q+/EEp5pOW1Du5zCGW0wg3x/caTE=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54M7o2u53330480
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 22 May 2025 02:50:02 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 May 2025 02:50:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 May 2025 02:50:01 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54M7nwk3458631;
 Thu, 22 May 2025 02:49:59 -0500
Message-ID: <43445d60-2bf0-4e6b-9957-54778d7b3727@ti.com>
Date: Thu, 22 May 2025 13:19:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm: mach-k3: {am6/j7}*_hardware.h: Expose MCU R5
 proc and device ids
To: Beleswar Padhi <b-padhi@ti.com>, <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <m-shah@ti.com>, <u-boot@lists.denx.de>
References: <20250522071828.285462-1-b-padhi@ti.com>
 <20250522071828.285462-2-b-padhi@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250522071828.285462-2-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Beleswar

On 22/05/25 12:48, Beleswar Padhi wrote:
> Currently the MCU R5 processor ids and device ids are only defined for
> R5 SPL Stage. Expose these ids always so that A72 SPL can utilize this
> information to shutdown MCU R5 Core 1 when booted in Split mode.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>  arch/arm/mach-k3/include/mach/am62_hardware.h   | 4 ++--
>  arch/arm/mach-k3/include/mach/am62a_hardware.h  | 4 ++--
>  arch/arm/mach-k3/include/mach/am62p_hardware.h  | 4 ++--
>  arch/arm/mach-k3/include/mach/am64_hardware.h   | 9 +++++----
>  arch/arm/mach-k3/include/mach/am6_hardware.h    | 9 +++++----
>  arch/arm/mach-k3/include/mach/j721e_hardware.h  | 9 +++++----
>  arch/arm/mach-k3/include/mach/j721s2_hardware.h | 9 +++++----
>  arch/arm/mach-k3/include/mach/j722s_hardware.h  | 4 ++--
>  arch/arm/mach-k3/include/mach/j784s4_hardware.h | 9 +++++----
>  9 files changed, 33 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mach-k3/include/mach/am62_hardware.h
> index bcbc4821c82..d44342d43d4 100644
> --- a/arch/arm/mach-k3/include/mach/am62_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
> @@ -158,8 +158,8 @@ static inline int k3_has_gpu(void)
>  
>  static const u32 put_device_ids[] = {};
>  
> -static const u32 put_core_ids[] = {};
> -
>  #endif
>  
> +static const u32 put_core_ids[] = {};
> +
>  #endif /* __ASM_ARCH_AM62_HARDWARE_H */
> diff --git a/arch/arm/mach-k3/include/mach/am62a_hardware.h b/arch/arm/mach-k3/include/mach/am62a_hardware.h
> index cd61abe0185..f3fd736f31b 100644
> --- a/arch/arm/mach-k3/include/mach/am62a_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/am62a_hardware.h
> @@ -90,8 +90,8 @@
>  
>  static const u32 put_device_ids[] = {};
>  
> -static const u32 put_core_ids[] = {};
> -
>  #endif
>  
> +static const u32 put_core_ids[] = {};
> +
>  #endif /* __ASM_ARCH_AM62A_HARDWARE_H */
> diff --git a/arch/arm/mach-k3/include/mach/am62p_hardware.h b/arch/arm/mach-k3/include/mach/am62p_hardware.h
> index 95af5c5c547..a310b52b45d 100644
> --- a/arch/arm/mach-k3/include/mach/am62p_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/am62p_hardware.h
> @@ -141,8 +141,8 @@ static inline int k3_get_a53_max_frequency(void)
>  
>  static const u32 put_device_ids[] = {};
>  
> -static const u32 put_core_ids[] = {};
> -
>  #endif
>  
> +static const u32 put_core_ids[] = {};
> +
>  #endif /* __ASM_ARCH_AM62P_HARDWARE_H */
> diff --git a/arch/arm/mach-k3/include/mach/am64_hardware.h b/arch/arm/mach-k3/include/mach/am64_hardware.h
> index 44df887d5df..105b42986de 100644
> --- a/arch/arm/mach-k3/include/mach/am64_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/am64_hardware.h
> @@ -50,19 +50,20 @@
>  
>  #define AM64X_DEV_RTI8			127
>  #define AM64X_DEV_RTI9			128
> -#define AM64X_DEV_R5FSS0_CORE0		121
> -#define AM64X_DEV_R5FSS0_CORE1		122
>  
>  static const u32 put_device_ids[] = {
>  	AM64X_DEV_RTI9,
>  	AM64X_DEV_RTI8,
>  };
>  
> +#endif
> +
> +#define AM64X_DEV_R5FSS0_CORE0		121
> +#define AM64X_DEV_R5FSS0_CORE1		122
> +
>  static const u32 put_core_ids[] = {
>  	AM64X_DEV_R5FSS0_CORE1,
>  	AM64X_DEV_R5FSS0_CORE0, /* Handle CPU0 after CPU1 */
>  };
>  
> -#endif
> -
>  #endif /* __ASM_ARCH_DRA8_HARDWARE_H */
> diff --git a/arch/arm/mach-k3/include/mach/am6_hardware.h b/arch/arm/mach-k3/include/mach/am6_hardware.h
> index 9913964c46b..8169584a372 100644
> --- a/arch/arm/mach-k3/include/mach/am6_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/am6_hardware.h
> @@ -43,19 +43,20 @@
>  
>  #define AM6_DEV_MCU_RTI0			134
>  #define AM6_DEV_MCU_RTI1			135
> -#define AM6_DEV_MCU_ARMSS0_CPU0			159
> -#define AM6_DEV_MCU_ARMSS0_CPU1			245
>  
>  static const u32 put_device_ids[] = {
>  	AM6_DEV_MCU_RTI0,
>  	AM6_DEV_MCU_RTI1,
>  };
>  
> +#endif
> +
> +#define AM6_DEV_MCU_ARMSS0_CPU0			159
> +#define AM6_DEV_MCU_ARMSS0_CPU1			245
> +
>  static const u32 put_core_ids[] = {
>  	AM6_DEV_MCU_ARMSS0_CPU1,
>  	AM6_DEV_MCU_ARMSS0_CPU0,	/* Handle CPU0 after CPU1 */
>  };
>  
> -#endif
> -
>  #endif /* __ASM_ARCH_AM6_HARDWARE_H */
> diff --git a/arch/arm/mach-k3/include/mach/j721e_hardware.h b/arch/arm/mach-k3/include/mach/j721e_hardware.h
> index 2b5ec771e18..5bef309af0a 100644
> --- a/arch/arm/mach-k3/include/mach/j721e_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/j721e_hardware.h
> @@ -41,19 +41,20 @@
>  
>  #define J721E_DEV_MCU_RTI0			262
>  #define J721E_DEV_MCU_RTI1			263
> -#define J721E_DEV_MCU_ARMSS0_CPU0		250
> -#define J721E_DEV_MCU_ARMSS0_CPU1		251
>  
>  static const u32 put_device_ids[] = {
>  	J721E_DEV_MCU_RTI0,
>  	J721E_DEV_MCU_RTI1,
>  };
>  
> +#endif
> +
> +#define J721E_DEV_MCU_ARMSS0_CPU0		250
> +#define J721E_DEV_MCU_ARMSS0_CPU1		251
> +
>  static const u32 put_core_ids[] = {
>  	J721E_DEV_MCU_ARMSS0_CPU1,
>  	J721E_DEV_MCU_ARMSS0_CPU0,	/* Handle CPU0 after CPU1 */
>  };
>  
> -#endif
> -
>  #endif /* __ASM_ARCH_J721E_HARDWARE_H */
> diff --git a/arch/arm/mach-k3/include/mach/j721s2_hardware.h b/arch/arm/mach-k3/include/mach/j721s2_hardware.h
> index 8daea82a77e..82f076a45e0 100644
> --- a/arch/arm/mach-k3/include/mach/j721s2_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/j721s2_hardware.h
> @@ -41,19 +41,20 @@
>  
>  #define J721S2_DEV_MCU_RTI0			295
>  #define J721S2_DEV_MCU_RTI1			296
> -#define J721S2_DEV_MCU_ARMSS0_CPU0		284
> -#define J721S2_DEV_MCU_ARMSS0_CPU1		285
>  
>  static const u32 put_device_ids[] = {
>  	J721S2_DEV_MCU_RTI0,
>  	J721S2_DEV_MCU_RTI1,
>  };
>  
> +#endif
> +
> +#define J721S2_DEV_MCU_ARMSS0_CPU0		284
> +#define J721S2_DEV_MCU_ARMSS0_CPU1		285
> +
>  static const u32 put_core_ids[] = {
>  	J721S2_DEV_MCU_ARMSS0_CPU1,
>  	J721S2_DEV_MCU_ARMSS0_CPU0,	/* Handle CPU0 after CPU1 */
>  };
>  
> -#endif
> -
>  #endif /* __ASM_ARCH_J721S2_HARDWARE_H */
> diff --git a/arch/arm/mach-k3/include/mach/j722s_hardware.h b/arch/arm/mach-k3/include/mach/j722s_hardware.h
> index 8d0bec22068..0c695134c28 100644
> --- a/arch/arm/mach-k3/include/mach/j722s_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/j722s_hardware.h
> @@ -76,8 +76,8 @@
>  
>  static const u32 put_device_ids[] = {};
>  
> -static const u32 put_core_ids[] = {};
> -
>  #endif
>  
> +static const u32 put_core_ids[] = {};
> +
>  #endif /* __ASM_ARCH_J722S_HARDWARE_H */
> diff --git a/arch/arm/mach-k3/include/mach/j784s4_hardware.h b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
> index 0ffe238cdae..29a894baed3 100644
> --- a/arch/arm/mach-k3/include/mach/j784s4_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
> @@ -41,19 +41,20 @@
>  
>  #define J784S4_DEV_MCU_RTI0			367
>  #define J784S4_DEV_MCU_RTI1			368
> -#define J784S4_DEV_MCU_ARMSS0_CPU0		346
> -#define J784S4_DEV_MCU_ARMSS0_CPU1		347
>  
>  static const u32 put_device_ids[] = {
>  	J784S4_DEV_MCU_RTI0,
>  	J784S4_DEV_MCU_RTI1,
>  };
>  
> +#endif
> +
> +#define J784S4_DEV_MCU_ARMSS0_CPU0		346
> +#define J784S4_DEV_MCU_ARMSS0_CPU1		347
> +
>  static const u32 put_core_ids[] = {
>  	J784S4_DEV_MCU_ARMSS0_CPU1,
>  	J784S4_DEV_MCU_ARMSS0_CPU0,     /* Handle CPU0 after CPU1 */
>  };
>  
> -#endif
> -
>  #endif /* __ASM_ARCH_J784S4_HARDWARE_H */

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
