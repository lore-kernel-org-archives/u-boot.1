Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7163ACAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 12:44:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98D8C833E9;
	Tue, 23 Sep 2025 14:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="i0NnbHU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95B4A83445; Tue, 23 Sep 2025 14:44:47 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B9FA800B6
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 14:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id B444622F7C;
 Tue, 23 Sep 2025 14:44:44 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2JhZmfuiLY_z; Tue, 23 Sep 2025 14:44:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1758631483; bh=R2E8U4nzinioDgO4cSBmnWQrtwTDs8ewJFxEYF9gUDw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=i0NnbHU0YXEPnhmdsii948HeM9/X2D86XpNbxgMC2/i3AAsR05u91gcMw235Oa4yL
 akgTmPhNm4EU5YUWxVpO2Sm1ryvsutHMhQeVJYzWG3cYM2dWt3bPz5V28pdoZOzxOD
 YwdhN8KBu9EYVlFO2fAxtySw2uO/R8PkIIBbzIxgddvUYqNDhfOsnrvcB0E1vcUvT3
 TZBV6zz28eGkXpnEamyjIEYZTENbAxb/tZSj7GGAv9CBxnO15GtJjKHYx0yyEU5z7G
 CxN2JdFa0ocgX+iaeJACs/f2lT/efbeVSMvieTQbKNxu6YsJjjiHeun4U/UIpZM6Hf
 ezP5ZHyDPQdpA==
Date: Tue, 23 Sep 2025 12:44:28 +0000
From: Yao Zi <ziyao@disroot.org>
To: Beiyan Yun <root@infi.wang>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH RESEND 4/4] doc: bindings: add Aquantia PHY node's
 "firmware-name" binding
Message-ID: <aNKWLNH0ZhqFckNl@pie>
References: <20250923071315.276114-1-root@infi.wang>
 <20250923071315.276114-5-root@infi.wang>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923071315.276114-5-root@infi.wang>
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

On Tue, Sep 23, 2025 at 03:13:01PM +0800, Beiyan Yun wrote:
> With the switch to generic firmware loader, "firmware-name" binding
> was introduced to define the firmware filename.
> Provide the document and usage examples.
> 
> Signed-off-by: Beiyan Yun <root@infi.wang>

IMO this patch should go before the driver change.

> ---
> 
>  doc/device-tree-bindings/net/aquantia-phy.txt | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/doc/device-tree-bindings/net/aquantia-phy.txt b/doc/device-tree-bindings/net/aquantia-phy.txt
> index 7dd3d45df12..1227c04d04f 100644
> --- a/doc/device-tree-bindings/net/aquantia-phy.txt
> +++ b/doc/device-tree-bindings/net/aquantia-phy.txt
> @@ -11,15 +11,45 @@ a custom firmware is needed for each integration of a PHY.
>  Several optional bindings are defined that allow these configuration points to
>  be driven by the PHY driver and reduce dependency on specific FW versions.
>  
> +Aquantia PHY's firmware is often provided by PHY-resident SPI flash; if absent
> +or outdated, U-Boot can upload firmware over MDIO during PHY initialization.
> +The driver uploads only when the PHY reports missing firmware or a fault.
> +
>  Optional properties:
>  mdi-reversal: 0 or 1 indicating that reversal must be disabled/enabled.
>                Firmware default is used if the property is missing.
>  smb-addr:     I2C/SMBus address to use, firmware default is used if the property
>                is missing.
> +firmware-name: String containing the filename of the PHY firmware to load
> +               (only when CONFIG_PHY_AQUANTIA_UPLOAD_FW is enabled).

This looks good to me, but I have a question: should we switch to the
upstream binding for aquantia phys? It's already documented as
marvell,aquantia.yaml, and we could avoid the burden of maintaining a
separate binding file.

The "firmware-name" property is already described in the upstream
marvell,aquantia.yaml, and it only misses the smb-addr property. The
only U-Boot boards making use of this property are fsl-sch-30841 and
fsl-sch-30842, thus such conversion shouldn't be a big job.

Best regards,
Yao Zi

>  Example node:
>  phy@00 {
>  	reg = <0x00>;
>  	mdi-reversal = <1>;
>  	smb-addr = <0x25>;
> +	firmware-name = "aqr-firmware.cld";
> +};
> +
> +Example using the generic firmware loader:
> +/	{
> +	chosen {
> +		/* Select default firmware loader instance */
> +		firmware-loader = &fs_loader0;
> +	};
> +
> +	fs_loader0: fs-loader@0 {
> +		bootph-all;
> +		compatible = "u-boot,fs-loader";
> +		/* Load from MMC0, partition 1 */
> +		phandlepart = <&mmc_0 1>;
> +	};
> +
> +	mdio {
> +		phy@0 {
> +			reg = <0>;
> +			/* Load this file via the selected fs-loader */
> +			firmware-name = "aqr-firmware.cld";
> +		};
> +	};
>  };
> -- 
> 2.47.3
> 
