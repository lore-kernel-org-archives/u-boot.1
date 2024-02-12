Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7317C4829E
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 17:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D1B38751B;
	Mon, 12 Feb 2024 18:33:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GrU9qaij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF9CF80E9A; Mon, 12 Feb 2024 18:32:58 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2A9C8751B
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 18:32:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CHWsFM028844;
 Mon, 12 Feb 2024 11:32:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707759174;
 bh=5Vo2pGmaPFuhakW0ZJGTo82KUxm/Oz+6yv0wkoTJX6s=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=GrU9qaijej28D6Uydy2cvqwmF7DeppBDqfcXHEZ6e3aWzZyMrX5NaAd9CQT2aVh+o
 nveDUEKWG5rFl6lzKNe17VKCxYNMs5Nvs4MZagYzD7O2y/Mcm5DNE+/BiCktKLquHH
 DFT6zUZ2EF/g31knuRoZjyTiGyRGFjCboBPtY93E=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CHWsPC100660
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 12 Feb 2024 11:32:54 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 11:32:54 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 11:32:54 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CHWsSt074948;
 Mon, 12 Feb 2024 11:32:54 -0600
Date: Mon, 12 Feb 2024 11:32:54 -0600
From: Nishanth Menon <nm@ti.com>
To: Robert Nelson <robertcnelson@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/4] arm: mach-k3: am62: Add Debounce configuration
 register definitions
Message-ID: <20240212173254.vuwwc7xqefum3con@dallying>
References: <20240212155332.541949-1-nm@ti.com>
 <20240212155332.541949-4-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240212155332.541949-4-nm@ti.com>
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

On 09:53-20240212, Nishanth Menon wrote:
> Add the Debounce configuration registers that need to be configured one
> time for the platform for the entire SoC.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-k3/include/mach/am62_hardware.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mach-k3/include/mach/am62_hardware.h
> index 54380f36e161..06fcab01a5b7 100644
> --- a/arch/arm/mach-k3/include/mach/am62_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
> @@ -75,6 +75,9 @@
>  
>  #define CTRLMMR_MCU_RST_CTRL			(MCU_CTRL_MMR0_BASE + 0x18170)
>  
> +/* Debounce register configuration */
> +#define CTRLMMR_DBOUNCE_CFG(index)		(MCU_CTRL_MMR0_BASE + 4080 + (index * 4))

Grrr.. missed the fixup for 0x4080 here. will wait a couple of days for any other
review comments.


> +
>  #define ROM_EXTENDED_BOOT_DATA_INFO		0x43c3f1e0
>  
>  #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	0x43c30000
> -- 
> 2.43.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
