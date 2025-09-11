Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B852CAC583
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 04:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5952E831C2;
	Thu, 11 Sep 2025 06:38:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Cq+e64Wm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6865483236; Thu, 11 Sep 2025 06:38:42 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 393CD8319C
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 06:38:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58B4cbnE667902;
 Wed, 10 Sep 2025 23:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757565517;
 bh=4zdvT4zMI0khMyBi+gDfKwygVxd6NZrn+ztNug5omHw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Cq+e64WmCAEUyjbaMfN5esQOJSqbMn0p8gQ8N6mMX9MNWzFQY91CoJBE0T1unzIT8
 D0KqdFZd6AGcMLxqU3n91DtNx2Lj2IQRrAwGC8QEZ9tM1T3wgByWyLGU7L+7hkDsDF
 y7ODTfC2apSQ+h1ZoGf+cCSca1TnURPGamURLkBw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58B4cbGp800114
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 10 Sep 2025 23:38:37 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 23:38:37 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 23:38:37 -0500
Received: from [172.24.20.139] (lt5cd2489kgj.dhcp.ti.com [172.24.20.139])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58B4cXSA1256565;
 Wed, 10 Sep 2025 23:38:34 -0500
Message-ID: <9bb08b19-ca4a-40f2-afcf-92af0a71b51a@ti.com>
Date: Thu, 11 Sep 2025 10:08:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: mach-k3: Fix MMC macros
To: Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>, <u-kumar1@ti.com>
CC: Manorit Chawdhry <m-chawdhry@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Moteen Shah <m-shah@ti.com>, Andrew Davis <afd@ti.com>,
 <u-boot@lists.denx.de>
References: <20250910214514.1848847-1-jm@ti.com>
 <20250910214514.1848847-2-jm@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250910214514.1848847-2-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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


On 9/11/2025 3:15 AM, Judith Mendez wrote:
> For all K3 SoC's eMMC boot and MMCSD boot modes are supported. The macros
> however, mix MMC device with the two bootmodes. Decouple the two types
> of macros so that bootmodes can be identified with:
> - BOOT_DEVICE_MMCSD
> - BOOT_DEVICE_EMMC

Few devices already (kind of have this )

arch/arm/mach-k3/include/mach/j722s_spl.h

#define BOOT_DEVICE_MMC                 0x08
#define BOOT_DEVICE_EMMC                0x09

can we use in same way, BOOT_DEVICE_MMC  as SD instead of adding SD as 
postfix and

and add BOOT_DEVICE_EMMC, on devices where this is missing


> according to devstat parsed boot mode values and on-board devices can be
> identified with:
> - BOOT_DEVICE_MMC1
> - BOOT_DEVICE_MMC2
> - BOOT_DEVICE_MMC2_2

Why you need to change

#define for BOOT_DEVICE_MMC1 and and BOOT_DEVICE_MMC2



> according to arbitrary numbers mainly used to differentiate between eMMC
> and SD card.

Please check subject line, this is not a fix

> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>   arch/arm/mach-k3/am62ax/am62a7_init.c          |  4 ++--
>   arch/arm/mach-k3/am62ax/boot.c                 |  8 ++++----
>   arch/arm/mach-k3/am62px/am62p5_init.c          | 12 ++++++------
>   arch/arm/mach-k3/am62x/am625_init.c            |  4 ++--
>   arch/arm/mach-k3/am62x/boot.c                  |  8 ++++----
>   arch/arm/mach-k3/am64x/boot.c                  |  8 ++++----
>   arch/arm/mach-k3/am65x/am654_init.c            | 18 ++++++++++--------
>   arch/arm/mach-k3/include/mach/am62_hardware.h  |  8 ++++----
>   arch/arm/mach-k3/include/mach/am62_spl.h       | 10 +++++-----
>   arch/arm/mach-k3/include/mach/am62a_hardware.h |  8 ++++----
>   arch/arm/mach-k3/include/mach/am62a_spl.h      | 10 +++++-----
>   arch/arm/mach-k3/include/mach/am62p_hardware.h |  8 ++++----
>   arch/arm/mach-k3/include/mach/am62p_spl.h      | 10 +++++-----
>   arch/arm/mach-k3/include/mach/am64_hardware.h  |  4 ++--
>   arch/arm/mach-k3/include/mach/am64_spl.h       | 13 +++++++------
>   arch/arm/mach-k3/include/mach/am6_hardware.h   |  8 ++++----
>   arch/arm/mach-k3/include/mach/am6_spl.h        | 13 +++++++++----
>   arch/arm/mach-k3/include/mach/j721e_hardware.h |  6 +++---
>   arch/arm/mach-k3/include/mach/j721e_spl.h      | 14 ++++++++++----
>   .../arm/mach-k3/include/mach/j721s2_hardware.h |  6 +++---
>   arch/arm/mach-k3/include/mach/j721s2_spl.h     | 13 +++++++++----
>   arch/arm/mach-k3/include/mach/j722s_hardware.h |  8 ++++----
>   arch/arm/mach-k3/include/mach/j722s_spl.h      | 10 +++++-----
>   .../arm/mach-k3/include/mach/j784s4_hardware.h |  6 +++---
>   arch/arm/mach-k3/include/mach/j784s4_spl.h     | 13 +++++++++----
>   arch/arm/mach-k3/j721e/j721e_init.c            | 14 +++++++++-----
>   arch/arm/mach-k3/j721s2/j721s2_init.c          | 14 +++++++++-----
>   arch/arm/mach-k3/j722s/j722s_init.c            | 12 ++++++------
>   arch/arm/mach-k3/j784s4/j784s4_init.c          | 14 +++++++++-----
>   29 files changed, 160 insertions(+), 124 deletions(-)
>
> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
> index 00173e6836b..1fd466bbdfc 100644
> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
> @@ -225,8 +225,8 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>   		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
>   			return MMCSD_MODE_FS;
>   		return MMCSD_MODE_EMMCBOOT;
> [..]
>   
> +	if (bootmode == BOOT_DEVICE_EMMC)
> +		bootmode = BOOT_DEVICE_MMC1;
> +

Could you test once, eMMC on J784s4


>   	return bootmode;
>   }
>   
