Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1692BC54798
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 04:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F07487D97;
	Sun, 25 Feb 2024 05:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lJ6Z0rL1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FC3087D91; Sun, 25 Feb 2024 05:48:59 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30C678718A
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 05:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41P4ms5K109587;
 Sat, 24 Feb 2024 22:48:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708836534;
 bh=xHu8q/7loPqPTjaEO0Jbr3agAQwRbCeyz9pu2R077vU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=lJ6Z0rL17Q2VTo3Ib1BJF20uSqThLWDDAdX2QR2V5Ruf2ssMNuHmPGOmXtb5ykPMr
 Pi0T5cUG4LcMj2/3232WQ4ffkMlA5Z5nQZkbTuMfUoWJ83pRBreHe91izceciDzeQ4
 mbOAOBOuU0q/AWpJWYY3xGpFzJIvRMBx5IznTHlI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41P4ms5Y125538
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 24 Feb 2024 22:48:54 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Feb 2024 22:48:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Feb 2024 22:48:54 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41P4mpEv028235;
 Sat, 24 Feb 2024 22:48:52 -0600
Message-ID: <d16c8e4c-f2c4-4e5d-9ec3-14eef9400e45@ti.com>
Date: Sun, 25 Feb 2024 10:18:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm: mach-k3: j721e: Enable OSPI boot
Content-Language: en-US
To: Jonathan Humphreys <j-humphreys@ti.com>, <trini@konsulko.com>,
 <vaishnav.a@ti.com>
CC: <u-boot@lists.denx.de>
References: <20240224002307.2284386-1-j-humphreys@ti.com>
 <20240224002307.2284386-3-j-humphreys@ti.com>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240224002307.2284386-3-j-humphreys@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Thanks For fixing this

On 2/24/2024 5:53 AM, Jonathan Humphreys wrote:
> Add boot ROM XSPI bootmode, and set to BOOT_DEVICE_SPI if detected.
>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>   arch/arm/mach-k3/include/mach/j721e_spl.h | 5 +++--
>   arch/arm/mach-k3/j721e_init.c             | 3 ++-
>   2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-k3/include/mach/j721e_spl.h b/arch/arm/mach-k3/include/mach/j721e_spl.h
> index ed3d7333bd..aaee653537 100644
> --- a/arch/arm/mach-k3/include/mach/j721e_spl.h
> +++ b/arch/arm/mach-k3/include/mach/j721e_spl.h
> @@ -24,8 +24,9 @@
>   #define BOOT_DEVICE_UFS			0x13
>   #define BOOT_DEVIE_GPMC			0x14
>   #define BOOT_DEVICE_PCIE		0x15
> -#define BOOT_DEVICE_MMC2_2		0x16
> -#define BOOT_DEVICE_RAM			0x17
> +#define BOOT_DEVICE_XSPI 		0x16
> +#define BOOT_DEVICE_RAM 		0x17
> +#define BOOT_DEVICE_MMC2_2 		0xFF /* Invalid value */
>   
>   /* Backup boot modes with MCU Only = 0 */
>   #define BACKUP_BOOT_DEVICE_RAM		0x0
> diff --git a/arch/arm/mach-k3/j721e_init.c b/arch/arm/mach-k3/j721e_init.c
> index c2976c4ea0..7ee9b75de4 100644
> --- a/arch/arm/mach-k3/j721e_init.c
> +++ b/arch/arm/mach-k3/j721e_init.c
> @@ -346,7 +346,8 @@ static u32 __get_primary_bootmedia(u32 main_devstat, u32 wkup_devstat)
>   	bootmode |= (main_devstat & MAIN_DEVSTAT_BOOT_MODE_B_MASK) <<
>   			BOOT_MODE_B_SHIFT;
>   
> -	if (bootmode == BOOT_DEVICE_OSPI || bootmode ==	BOOT_DEVICE_QSPI)
> +	if (bootmode == BOOT_DEVICE_OSPI || bootmode == BOOT_DEVICE_QSPI ||
> +	    bootmode == BOOT_DEVICE_XSPI)
>   		bootmode = BOOT_DEVICE_SPI;


Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   
>   	if (bootmode == BOOT_DEVICE_MMC2) {
