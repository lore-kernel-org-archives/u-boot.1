Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78116FD876F
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 13:42:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0677D8431C;
	Tue, 17 Mar 2026 14:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AJADazeR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E31608431E; Tue, 17 Mar 2026 14:42:19 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F23484314
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 14:42:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-40ea36b56b7so3816733fac.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773754936; x=1774359736; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rt9tPktSfeXyRpiivjJrlpoQ3cZ+meM1mF15/utM4gg=;
 b=AJADazeRYPG4/WcZ2AkZDqVhc4W0nN/F25cAegxZtZYz6qVbL5oHHz7IOYMAvC5LeG
 38XKHmViluw51+sF1SHbQ1rJDePqJrCyLpXEzEDned+QhJ/xsyNlS7QUG7iR9WKkB8vi
 wv+ZkhNT80asg4BPel4f/hkbnklvb/hwr2hXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773754936; x=1774359736;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rt9tPktSfeXyRpiivjJrlpoQ3cZ+meM1mF15/utM4gg=;
 b=iICry1UA2sGhP9v1l3T9AQlqbdsS4BiHbQrWGT+eny7ISyoJo9E1/vF3bcfDKo/eBH
 GV+rdgGPWXNwuHMmO+N07cNICmPuABmajPYzhOxQa1z35j+xGn+BOCj4ulI/e3GvY//i
 F1EzK+hQUVAyCokmHIgXzKSoy4khseqKU5yP99TBHmVbtjIhoNmtos7JhXyiXWvG7vqC
 NxxOZHRj80eGGPcQDmuZX5nX3J69OiDxcKsCu708FRRRNK/LFCyZ6VB+fnZZqkIch2Hm
 ePI/9kynEli6OsAY+TUDLBWmvCyLXTF/+V14CYOSnp/6WVCQMCNme1Lj9ogU1R9unkvj
 Zq6w==
X-Gm-Message-State: AOJu0YwLW/uflcp5jeHDETVlYogxeYPUjmN7nDaEaHIebMkHuyf7nFLn
 f/kV2Q0GeIJtNe0YTW7D/JyNDdvO4vkFRRHHgLS9Y90pHHXGzU8huMPyKn6JJ3Ltypibd0ky1jc
 QorfxdSU=
X-Gm-Gg: ATEYQzz7oWK0Td8FjYC2uuTnwFkYHw/ijthro5j2Ka5U708l7d+DbkyDQkSnTncc1tn
 h4GxzP9gGvvU7SkLcsod7SgHHGXjRo7BET3iVebUxWSvMHG+avzSx2kqgSReyULnxKXmNR39VRw
 sJfDq/ult/33nOtiXUjgrjMnJgyT+A35j6aMxCs0V/EA9W53xZ6OT7zlBjX2QmcoF30Jix1fUJI
 nMi+xNOXsw8+GO60XYbp6SHt+qs1XePuioq94wJ2MN4psX5Q/z7L8mY+bb6EzGagqV8tK0WGudS
 df5OI7yxs4a5bsNSG+8Vy4Sa4GwOxjXEgvhrIdAi7lLaDXDDXW2dOZLfxug6CzwvCN8G3yqIL14
 PU7HWGkuLwbRSdZI3NyrTbnlLLdpgKz93VEggKsgS35SStLHTznwsrujIllVGx1bUt+xUiE7fy8
 rIrXqpiRQjhsT3gxzhd/GTXCxSxKLH10g8968ASjXUOfaKm/d38OmYfmhyEtThiJAn2vLDIV4vG
 X0vjfHERyrYnre/Mms3I84wuRRlkZkJfNqWXtpsye9kIgnDN3VU5ajjNnE=
X-Received: by 2002:a05:6870:d147:b0:404:3569:5a45 with SMTP id
 586e51a60fabf-417b93f61b4mr10306808fac.40.1773754935993; 
 Tue, 17 Mar 2026 06:42:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e6c7885sm18257235fac.17.2026.03.17.06.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 06:42:15 -0700 (PDT)
Date: Tue, 17 Mar 2026 07:42:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] core: Rework REGMAP symbols implementation
Message-ID: <20260317134213.GS502704@bill-the-cat>
References: <20260317012419.4162359-1-trini@konsulko.com>
 <DH4U9SAX4CR6.36CGITXOROQTA@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ixzh24TlVUZsLuDQ"
Content-Disposition: inline
In-Reply-To: <DH4U9SAX4CR6.36CGITXOROQTA@ti.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--ixzh24TlVUZsLuDQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 11:51:23AM +0530, Anshul Dalal wrote:
> On Tue Mar 17, 2026 at 6:54 AM IST, Tom Rini wrote:
> > As exposed by "make randconfig", we have an issue with the dependencies
> > for REGMAP (and xPL variants). As this is a library function, it should
> > always be selected and not depended on by other functionality. This is
> > largely done correctly today, so just correct the few outliers.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >  arch/arm/mach-airoha/Kconfig       |  1 +
> >  arch/arm/mach-aspeed/Kconfig       |  1 +
> >  arch/powerpc/cpu/mpc83xx/Kconfig   |  1 +
> >  configs/imx8m_data_modul.config    |  1 -
> >  configs/imx95_evk.config           |  1 -
> >  configs/imx_dhsom.config           |  1 -
> >  configs/kontron-osm-s-mx8mp.config |  1 -
> >  configs/kontron-osm-s-mx93.config  |  1 -
> >  configs/renesas_rcar64.config      |  1 -
> >  drivers/clk/microchip/Kconfig      |  1 -
> >  drivers/core/Kconfig               | 19 +++++++++++--------
> >  drivers/misc/Kconfig               |  3 ++-
> >  drivers/mmc/Kconfig                |  3 ++-
> >  13 files changed, 18 insertions(+), 17 deletions(-)
> >
> > diff --git a/arch/arm/mach-airoha/Kconfig b/arch/arm/mach-airoha/Kconfig
> > index b9cd0a413e10..4b0374001d0c 100644
> > --- a/arch/arm/mach-airoha/Kconfig
> > +++ b/arch/arm/mach-airoha/Kconfig
> > @@ -10,6 +10,7 @@ config TARGET_EN7523
> >  	bool "Airoha EN7523 SoC"
> >  	select CPU_V7A
> >  	select ARMV7_SET_CORTEX_SMPEN
> > +	select REGMAP
> >  	help
> >  	  The Airoha EN7523 family (en7523/en7529/en7562) is an ARM-based
> >  	  SoCs with a dual-core CPU. It comes with Wi-Fi 5/6 support and
> > diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
> > index 9cf60378c118..c88b1e59366e 100644
> > --- a/arch/arm/mach-aspeed/Kconfig
> > +++ b/arch/arm/mach-aspeed/Kconfig
> > @@ -18,6 +18,7 @@ config ASPEED_AST2500
> >  	bool "Support Aspeed AST2500 SoC"
> >  	select CPU_ARM1176
> >  	select DM_RESET
> > +	select REGMAP
> >  	help
> >  	  The Aspeed AST2500 is a ARM-based SoC with arm1176 CPU.
> >  	  It is used as Board Management Controller on many server boards,
> > diff --git a/arch/powerpc/cpu/mpc83xx/Kconfig b/arch/powerpc/cpu/mpc83x=
x/Kconfig
> > index 8ac83420ee22..0dc72c874237 100644
> > --- a/arch/powerpc/cpu/mpc83xx/Kconfig
> > +++ b/arch/powerpc/cpu/mpc83xx/Kconfig
> > @@ -73,6 +73,7 @@ config TARGET_KMTEPR2
> >  config TARGET_GAZERBEAM
> >  	bool "Support gazerbeam"
> >  	select ARCH_MPC8308
> > +	select REGMAP
> >  	select SYS_FSL_ERRATUM_ESDHC111
> >  	imply ENV_IS_IN_FLASH
> >  	help
> > diff --git a/configs/imx8m_data_modul.config b/configs/imx8m_data_modul=
=2Econfig
> > index 4634a0972f09..18c7bb536fa0 100644
> > --- a/configs/imx8m_data_modul.config
> > +++ b/configs/imx8m_data_modul.config
> > @@ -149,7 +149,6 @@ CONFIG_PINCTRL=3Dy
> >  CONFIG_PINCTRL_IMX8M=3Dy
> >  CONFIG_POWER_DOMAIN=3Dy
> >  CONFIG_PROT_TCP_SACK=3Dy
> > -CONFIG_REGMAP=3Dy
> >  CONFIG_RGMII=3Dy
> >  CONFIG_RTC_M41T62=3Dy
> >  CONFIG_SF_DEFAULT_SPEED=3D50000000
> > diff --git a/configs/imx95_evk.config b/configs/imx95_evk.config
> > index 3db583cce597..e7832d86fe91 100644
> > --- a/configs/imx95_evk.config
> > +++ b/configs/imx95_evk.config
> > @@ -92,7 +92,6 @@ CONFIG_ETHPRIME=3D"eth0"
> >  CONFIG_NET_RANDOM_ETHADDR=3Dy
> >  CONFIG_SYS_RX_ETH_BUFFER=3D8
> >  CONFIG_SPL_DM=3Dy
> > -CONFIG_REGMAP=3Dy
> >  CONFIG_SYSCON=3Dy
> >  CONFIG_SPL_OF_TRANSLATE=3Dy
> >  CONFIG_CLK=3Dy
> > diff --git a/configs/imx_dhsom.config b/configs/imx_dhsom.config
> > index 4a3ddc7e90b7..a0d67c8a0688 100644
> > --- a/configs/imx_dhsom.config
> > +++ b/configs/imx_dhsom.config
> > @@ -28,7 +28,6 @@ CONFIG_ENV_SECT_SIZE_AUTO=3Dy
> >  CONFIG_ENV_REDUNDANT=3Dy
> >  CONFIG_ENV_RELOC_GD_ENV_ADDR=3Dy
> > =20
> > -CONFIG_REGMAP=3Dy
> >  CONFIG_SYSCON=3Dy
> > =20
> >  CONFIG_DM_GPIO=3Dy
> > diff --git a/configs/kontron-osm-s-mx8mp.config b/configs/kontron-osm-s=
-mx8mp.config
> > index a8881726e079..786fd3e7a6de 100644
> > --- a/configs/kontron-osm-s-mx8mp.config
> > +++ b/configs/kontron-osm-s-mx8mp.config
> > @@ -117,7 +117,6 @@ CONFIG_TFTP_TSIZE=3Dy
> >  CONFIG_NET_RANDOM_ETHADDR=3Dy
> >  CONFIG_SPL_DM=3Dy
> >  CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> > -CONFIG_REGMAP=3Dy
> >  CONFIG_SYSCON=3Dy
> >  CONFIG_BOOTCOUNT_LIMIT=3Dy
> >  CONFIG_BOOTCOUNT_ENV=3Dy
> > diff --git a/configs/kontron-osm-s-mx93.config b/configs/kontron-osm-s-=
mx93.config
> > index a6d316de3d87..c2d4de4efa8a 100644
> > --- a/configs/kontron-osm-s-mx93.config
> > +++ b/configs/kontron-osm-s-mx93.config
> > @@ -115,7 +115,6 @@ CONFIG_TFTP_TSIZE=3Dy
> >  CONFIG_NET_RANDOM_ETHADDR=3Dy
> >  CONFIG_SPL_DM=3Dy
> >  CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> > -CONFIG_REGMAP=3Dy
> >  CONFIG_SYSCON=3Dy
> >  CONFIG_ADC=3Dy
> >  CONFIG_ADC_IMX93=3Dy
> > diff --git a/configs/renesas_rcar64.config b/configs/renesas_rcar64.con=
fig
> > index c2cb88dc157f..da4b262fc6a5 100644
> > --- a/configs/renesas_rcar64.config
> > +++ b/configs/renesas_rcar64.config
> > @@ -6,7 +6,6 @@ CONFIG_CMD_TEMPERATURE=3Dy
> >  CONFIG_DM_THERMAL=3Dy
> >  CONFIG_PHY_ANEG_TIMEOUT=3D20000
> >  CONFIG_RCAR_GEN3_THERMAL=3Dy
> > -CONFIG_REGMAP=3Dy
> >  CONFIG_REMAKE_ELF=3Dy
> >  CONFIG_RENESAS_RPC_SPI=3Dy
> >  CONFIG_SUPPORT_RAW_INITRD=3Dy
> > diff --git a/drivers/clk/microchip/Kconfig b/drivers/clk/microchip/Kcon=
fig
> > index 62072e100b18..6ac7c9c56547 100644
> > --- a/drivers/clk/microchip/Kconfig
> > +++ b/drivers/clk/microchip/Kconfig
> > @@ -2,6 +2,5 @@ config CLK_MPFS
> >  	bool "Clock support for Microchip PolarFire SoC"
> >  	depends on CLK && CLK_CCF
> >  	depends on SYSCON
> > -	depends on REGMAP
> >  	help
> >  	  This enables support clock driver for Microchip PolarFire SoC platf=
orm.
> > diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
> > index c9253099e6ea..5419bf65b5d6 100644
> > --- a/drivers/core/Kconfig
> > +++ b/drivers/core/Kconfig
> > @@ -195,7 +195,7 @@ config DM_DMA
> >  	  the physical address space.
> > =20
> >  config REGMAP
> > -	bool "Support register maps"
> > +	bool
> >  	depends on DM
> >  	select DEVRES
> >  	help
> > @@ -206,7 +206,7 @@ config REGMAP
> >  	  direct memory access.
> > =20
> >  config SPL_REGMAP
> > -	bool "Support register maps in SPL"
> > +	bool
> >  	depends on SPL_DM
> >  	help
> >  	  Hardware peripherals tend to have one or more sets of registers
> > @@ -216,7 +216,7 @@ config SPL_REGMAP
> >  	  direct memory access.
> > =20
> >  config TPL_REGMAP
> > -	bool "Support register maps in TPL"
> > +	bool
> >  	depends on TPL_DM
> >  	help
> >  	  Hardware peripherals tend to have one or more sets of registers
> > @@ -226,7 +226,7 @@ config TPL_REGMAP
> >  	  direct memory access.
> > =20
> >  config VPL_REGMAP
> > -	bool "Support register maps in VPL"
> > +	bool
> >  	depends on VPL_DM
> >  	help
> >  	  Hardware peripherals tend to have one or more sets of registers
> > @@ -237,7 +237,7 @@ config VPL_REGMAP
> > =20
> >  config SYSCON
> >  	bool "Support system controllers"
> > -	depends on REGMAP
> > +	select REGMAP
> >  	help
> >  	  Many SoCs have a number of system controllers which are dealt with
> >  	  as a group by a single driver. Some common functionality is provided
> > @@ -246,7 +246,8 @@ config SYSCON
> > =20
> >  config SPL_SYSCON
> >  	bool "Support system controllers in SPL"
> > -	depends on SPL_REGMAP
> > +	depends on SPL_DM
> > +	select SPL_REGMAP
> >  	help
> >  	  Many SoCs have a number of system controllers which are dealt with
> >  	  as a group by a single driver. Some common functionality is provided
> > @@ -255,7 +256,8 @@ config SPL_SYSCON
> > =20
> >  config TPL_SYSCON
> >  	bool "Support system controllers in TPL"
> > -	depends on TPL_REGMAP
> > +	depends on TPL_DM
> > +	select TPL_REGMAP
> >  	help
> >  	  Many SoCs have a number of system controllers which are dealt with
> >  	  as a group by a single driver. Some common functionality is provided
> > @@ -264,7 +266,8 @@ config TPL_SYSCON
> > =20
> >  config VPL_SYSCON
> >  	bool "Support system controllers in VPL"
> > -	depends on VPL_REGMAP
> > +	depends on VPL_DM
> > +	select VPL_REGMAP
> >  	help
> >  	  Many SoCs have a number of system controllers which are dealt with
> >  	  as a group by a single driver. Some common functionality is provided
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index a0aa290480eb..798f1dbf26cf 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -350,7 +350,8 @@ config MXS_OCOTP
> > =20
> >  config NPCM_HOST
> >  	bool "Enable support espi or LPC for Host"
> > -	depends on REGMAP && SYSCON
> > +	depends on SYSCON
> > +	select REGMAP
> >  	help
> >  	  Enable NPCM BMC espi or LPC support for Host reading and writing.
> > =20
> > diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> > index 39caf2eff1b7..22bd3a972bdf 100644
> > --- a/drivers/mmc/Kconfig
> > +++ b/drivers/mmc/Kconfig
> > @@ -627,8 +627,9 @@ config MMC_SDHCI_AM654
> >  	depends on ARCH_K3
> >  	depends on MMC_SDHCI
> >  	depends on OF_CONTROL
> > -	depends on REGMAP
> >  	select MMC_SDHCI_IO_ACCESSORS
> > +	select REGMAP
> > +	select SPL_REGMAP if SPL_MMC
>=20
> With this there should be no need to explicitly set REGMAP configs like
> we do in most of K3 defconfigs for using MMC.

Correct.  A later resync will remove a lot of lines. The config
fragments however are always untouched and so are part of this patch for
completness.

--=20
Tom

--ixzh24TlVUZsLuDQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCablaNQAKCRAr4qD1Cr/k
CokoAPwK/GFbKk0Z9ckrQXxzBwj36ik3nV3SYkQsLPTk3AI1ogD/S76pCclUrzx1
QpM6AIkljrktGhgbpvQwfTLrraQTYAA=
=n6id
-----END PGP SIGNATURE-----

--ixzh24TlVUZsLuDQ--
