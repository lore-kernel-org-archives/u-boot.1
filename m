Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F52C61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 13:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65792875A1;
	Tue, 21 Nov 2023 14:35:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="k+yvWTdK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C59EE87253; Tue, 21 Nov 2023 14:35:18 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00DAC87253
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:35:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ALDZDxc039104;
 Tue, 21 Nov 2023 07:35:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700573713;
 bh=YgnknvyGAInsXxc2C287OeMFTHgqq5rYhTHr0NHSXOk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=k+yvWTdKlX4HLAXhutaaWoASk/4KK8KzTj6bZ+WEzz7wKiB/JfmLPU2PNlLPmfhkh
 CfyqH6KfYY6KPmQ9bpmOdkDP52bguYjFGBSvvNN7rb7xaJS7pUl3n1I5Pjirf6iWWH
 4coYj7u1gd/35tSpaxELRzHPy//Glx6RhD0QdS0g=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ALDZDCp070561
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 21 Nov 2023 07:35:13 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 Nov 2023 07:35:13 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 Nov 2023 07:35:13 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ALDZD5Q001193;
 Tue, 21 Nov 2023 07:35:13 -0600
Date: Tue, 21 Nov 2023 07:35:13 -0600
From: Nishanth Menon <nm@ti.com>
To: Reid Tonking <reidt@ti.com>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <p.yadav@ti.com>,
 <u-boot@lists.denx.de>, <u-kumar1@ti.com>
Subject: Re: [PATCH] arm: mach-k3: J721e: Add xSPI boot mode
Message-ID: <20231121133513.bkcztm5ffq74zc2m@anaerobic>
References: <20231120220927.3611197-1-reidt@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231120220927.3611197-1-reidt@ti.com>
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

On 16:09-20231120, Reid Tonking wrote:
> From: Vignesh Raghavendra <vigneshr@ti.com>
> 
> J7200 ROM supports booting from xSPI compliant flash. Detect if ROM
> booted from xSPI bootmode and map that to BOOT_DEVICE_SPI
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

1) Are'nt these shared with J721e? what is the impact there?
2) Did you mean Pratyush or Reid in Signed-off-by? since this falls in
the chain of handoff?

> ---
>  arch/arm/mach-k3/include/mach/j721e_spl.h | 3 ++-
>  arch/arm/mach-k3/j721e_init.c             | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/include/mach/j721e_spl.h b/arch/arm/mach-k3/include/mach/j721e_spl.h
> index ed3d7333bd..c51bc5ab8e 100644
> --- a/arch/arm/mach-k3/include/mach/j721e_spl.h
> +++ b/arch/arm/mach-k3/include/mach/j721e_spl.h
> @@ -24,8 +24,9 @@
>  #define BOOT_DEVICE_UFS			0x13
>  #define BOOT_DEVIE_GPMC			0x14
>  #define BOOT_DEVICE_PCIE		0x15
> -#define BOOT_DEVICE_MMC2_2		0x16
> +#define BOOT_DEVICE_XSPI		0x16
>  #define BOOT_DEVICE_RAM			0x17
> +#define BOOT_DEVICE_MMC2_2		0xFF /* Invalid value */
>  
>  /* Backup boot modes with MCU Only = 0 */
>  #define BACKUP_BOOT_DEVICE_RAM		0x0
> diff --git a/arch/arm/mach-k3/j721e_init.c b/arch/arm/mach-k3/j721e_init.c
> index 18814c39ec..7bd64107b2 100644
> --- a/arch/arm/mach-k3/j721e_init.c
> +++ b/arch/arm/mach-k3/j721e_init.c
> @@ -340,7 +340,8 @@ static u32 __get_primary_bootmedia(u32 main_devstat, u32 wkup_devstat)
>  	bootmode |= (main_devstat & MAIN_DEVSTAT_BOOT_MODE_B_MASK) <<
>  			BOOT_MODE_B_SHIFT;
>  
> -	if (bootmode == BOOT_DEVICE_OSPI || bootmode ==	BOOT_DEVICE_QSPI)
> +	if (bootmode == BOOT_DEVICE_OSPI || bootmode ==	BOOT_DEVICE_QSPI ||
> +	    bootmode == BOOT_DEVICE_XSPI)
>  		bootmode = BOOT_DEVICE_SPI;
>  
>  	if (bootmode == BOOT_DEVICE_MMC2) {
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
