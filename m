Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FA3C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 12:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A702487980;
	Wed, 27 Dec 2023 13:31:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ndht2MJS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B0C387991; Wed, 27 Dec 2023 13:31:32 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6453E877B1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 13:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BRCVIwx097543;
 Wed, 27 Dec 2023 06:31:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703680278;
 bh=EK75rhTT2Agh5P3og+EWV9QAqScxZGfo7cwooPjBc2k=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ndht2MJSeESHr9/QG1u6s0RMK1mbWQ2JWhkeUBxo9/kfeeZDKplcCLqVvIvkHATmW
 NGW7w/X27RP23kyYOWesHA5sICZVbX9SveNYmMMDskTNEbel2nr/Ftk5CDYv7AwCeq
 iwGQuVF87IrTI95Gu+sJc3X+38OVHXOaMQBXi/Fw=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BRCVIlK002206
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Dec 2023 06:31:18 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Dec 2023 06:31:17 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Dec 2023 06:31:17 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BRCVH5F024463;
 Wed, 27 Dec 2023 06:31:17 -0600
Date: Wed, 27 Dec 2023 06:31:17 -0600
From: Nishanth Menon <nm@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: Tom Rini <trini@konsulko.com>, UBoot Mailing List <u-boot@lists.denx.de>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Martyn
 Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 16/26] arm: dts: k3-am654: remove duplicate sdhci1 pinmux
 node
Message-ID: <20231227123117.3pkfpkvrsxvsdqxd@stubbed>
References: <20231221174412.210807-1-bb@ti.com>
 <20231221174412.210807-17-bb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231221174412.210807-17-bb@ti.com>
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

On 11:44-20231221, Bryan Brattlof wrote:
> With the Linux and U-Boot board dtb files unified, we now have a
> duplicate sdhci1 pinmux node. Remove it
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  arch/arm/dts/k3-am654-r5-base-board.dts | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
> index 856917bdfaa5d..c4096d1b754c4 100644
> --- a/arch/arm/dts/k3-am654-r5-base-board.dts
> +++ b/arch/arm/dts/k3-am654-r5-base-board.dts
> @@ -137,19 +137,6 @@
>  };
>  
>  &main_pmx0 {
> -	main_mmc1_pins_default: main_mmc1_pins_default {
> -		pinctrl-single,pins = <
> -			AM65X_IOPAD(0x02d4, PIN_INPUT_PULLDOWN, 0)	/* (C27) MMC1_CLK */
> -			AM65X_IOPAD(0x02d8, PIN_INPUT_PULLUP, 0)	/* (C28) MMC1_CMD */
> -			AM65X_IOPAD(0x02d0, PIN_INPUT_PULLUP, 0)	/* (D28) MMC1_DAT0 */
> -			AM65X_IOPAD(0x02cc, PIN_INPUT_PULLUP, 0)	/* (E27) MMC1_DAT1 */
> -			AM65X_IOPAD(0x02c8, PIN_INPUT_PULLUP, 0)	/* (D26) MMC1_DAT2 */
> -			AM65X_IOPAD(0x02c4, PIN_INPUT_PULLUP, 0)	/* (D27) MMC1_DAT3 */
> -			AM65X_IOPAD(0x02dc, PIN_INPUT_PULLUP, 0)	/* (B24) MMC1_SDCD */
> -			AM65X_IOPAD(0x02e0, PIN_INPUT, 0)		/* (C24) MMC1_SDWP */
> -		>;
> -	};
> -
>  	usb0_pins_default: usb0_pins_default {
>  		pinctrl-single,pins = <
>  			AM65X_IOPAD(0x02bc, PIN_OUTPUT, 0) /* (AD9) USB0_DRVVBUS */
> @@ -176,12 +163,17 @@
>  	/delete-property/ power-domains;
>  };
>  
> +/* MMC is probed to pull in firmware, so any clock
> + * or power-domain operation will fail as we do not
> + * have the firmware running at this point. Delete the
> + * power-domain properties to avoid making calls to
> + * SYSFW before it is loaded. Public ROM has already
> + * set it up for us anyway.
> + */

Same - please fix the comment style here as well.

>  &sdhci1 {
>  	clock-names = "clk_xin";
>  	clocks = <&clk_200mhz>;
> -	pinctrl-0 = <&main_mmc1_pins_default>;
>  	/delete-property/ power-domains;
> -	ti,driver-strength-ohm = <50>;
>  };
>  
>  &wkup_i2c0 {
> -- 
> 2.43.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
