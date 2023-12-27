Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778B1C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 12:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFE1387980;
	Wed, 27 Dec 2023 13:30:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EBoqTRB/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A62BE8798A; Wed, 27 Dec 2023 13:30:26 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A4D8877B1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 13:30:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BRCUHVN126817;
 Wed, 27 Dec 2023 06:30:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703680218;
 bh=Tb6+BIMeZ5BVuakJGEyoKWUc+YbdM3FFOqhSx7cqyQI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=EBoqTRB/+2gfOPxiZFlKFpG1At96FbWwjyjIavW8oLiy+HKfvgCzuX8cpzSJVUqLz
 kjaKKkbQ7TR57qSGHqyY1oHwf3AgCLOvXUWOof883OdgC6o2wNtO4g7NxYQzXteuHD
 zDrlQHJlUJ4K4fP0N7sQ5Su5blBEis4VUUgHTjd4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BRCUHlv076688
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Dec 2023 06:30:17 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Dec 2023 06:30:17 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Dec 2023 06:30:17 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BRCUH3h023172;
 Wed, 27 Dec 2023 06:30:17 -0600
Date: Wed, 27 Dec 2023 06:30:17 -0600
From: Nishanth Menon <nm@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: Tom Rini <trini@konsulko.com>, UBoot Mailing List <u-boot@lists.denx.de>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Martyn
 Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 15/26] arm: dts: k3-am654: remove duplicate sdhci0 pinmux
 node
Message-ID: <20231227123017.5hi54xzkvo56yrjt@extended>
References: <20231221174412.210807-1-bb@ti.com>
 <20231221174412.210807-16-bb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231221174412.210807-16-bb@ti.com>
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
> With the Linux and U-Boot board dtb files unified, we now have
> a duplicate sdhci0 pinmux node. Remove it
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  arch/arm/dts/k3-am654-r5-base-board.dts | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
> index 66953eb5581ae..856917bdfaa5d 100644
> --- a/arch/arm/dts/k3-am654-r5-base-board.dts
> +++ b/arch/arm/dts/k3-am654-r5-base-board.dts
> @@ -137,22 +137,6 @@
>  };
>  
>  &main_pmx0 {
> -	main_mmc0_pins_default: main_mmc0_pins_default {
> -		pinctrl-single,pins = <
> -			AM65X_IOPAD(0x01a8, PIN_INPUT_PULLDOWN, 0)	/* (B25) MMC0_CLK */
> -			AM65X_IOPAD(0x01aC, PIN_INPUT_PULLUP, 0)	/* (B27) MMC0_CMD */
> -			AM65X_IOPAD(0x01a4, PIN_INPUT_PULLUP, 0)	/* (A26) MMC0_DAT0 */
> -			AM65X_IOPAD(0x01a0, PIN_INPUT_PULLUP, 0)	/* (E25) MMC0_DAT1 */
> -			AM65X_IOPAD(0x019c, PIN_INPUT_PULLUP, 0)	/* (C26) MMC0_DAT2 */
> -			AM65X_IOPAD(0x0198, PIN_INPUT_PULLUP, 0)	/* (A25) MMC0_DAT3 */
> -			AM65X_IOPAD(0x0194, PIN_INPUT_PULLUP, 0)	/* (E24) MMC0_DAT4 */
> -			AM65X_IOPAD(0x0190, PIN_INPUT_PULLUP, 0)	/* (A24) MMC0_DAT5 */
> -			AM65X_IOPAD(0x018c, PIN_INPUT_PULLUP, 0)	/* (B26) MMC0_DAT6 */
> -			AM65X_IOPAD(0x0188, PIN_INPUT_PULLUP, 0)	/* (D25) MMC0_DAT7 */
> -			AM65X_IOPAD(0x01b0, PIN_INPUT, 0)		/* (C25) MMC0_DS */
> -		>;
> -	};
> -
>  	main_mmc1_pins_default: main_mmc1_pins_default {
>  		pinctrl-single,pins = <
>  			AM65X_IOPAD(0x02d4, PIN_INPUT_PULLDOWN, 0)	/* (C27) MMC1_CLK */
> @@ -179,12 +163,17 @@
>  	pinctrl-0 = <&wkup_vtt_pins_default>;
>  };
>  
> +/* MMC is probed to pull in firmware, so any clock
> + * or power-domain operation will fail as we do not
> + * have the firmware running at this point. Delete the
> + * power-domain properties to avoid making calls to
> + * SYSFW before it is loaded. Public ROM has already
> + * set it up for us anyway.
> + */

Please fix your comment style here:

/*
 * blah blah
 */
>  &sdhci0 {
>  	clock-names = "clk_xin";
>  	clocks = <&clk_200mhz>;
> -	pinctrl-0 = <&main_mmc0_pins_default>;
>  	/delete-property/ power-domains;
> -	ti,driver-strength-ohm = <50>;
>  };
>  
>  &sdhci1 {
> -- 
> 2.43.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
