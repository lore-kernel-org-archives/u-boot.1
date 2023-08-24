Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709DFC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 13:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E330A86430;
	Thu, 24 Aug 2023 15:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nm0Ll/X4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3E3286433; Thu, 24 Aug 2023 15:30:23 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B028642B
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 15:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fee87dd251so46762375e9.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 06:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692883821; x=1693488621;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mfzEakQ4TiP6pmwnxnXX1Ia1ZDZBBNZB18PcZfkvudA=;
 b=nm0Ll/X4Q0NJz4VgoBz8GW9NXTtJuj+CUEC70TQBFPDl+HFEBUNUBdUge/+mp0Cb5c
 N0epAH07eS+eJ7a0OyHrtYYLraPyb9jZsTnsdl4sc5pP817w8bI24lHwNOZLfdq5gQrN
 Ut/ck8j03Gc7VskJsM3L2NhE3Aqu7pDU38INO9Tv/NvoOTxX59gOdyWN630xUrm6lXlA
 /IqpDCd5+HN2rZb1uz0lY+JCqT2ssEOr15Dmg0bnPQvtkZsu89nbknv/OHte2aFVm29w
 EmSG653OUvvtnkgvb7PF9ESb1D7U1r5ueiKbllVT5rmFyzwHIMRXYEBP79JfCzq7ENT8
 bJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692883821; x=1693488621;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mfzEakQ4TiP6pmwnxnXX1Ia1ZDZBBNZB18PcZfkvudA=;
 b=Tz5QPFOHBNe3pb7yAKB8BXjoUmQMvJ9XVKEZ06rVHTVa98lNrHj4FrkmvpZJ7gNm8i
 OjpMey7hmehz+euLV94tDo1T2ERjU61VFa+jen9gysWek39VL2zTgyOz0Io1R82KUFcr
 i2Op8atyy+coBbHFYEKPlf4wQxseMGCwkjIpwqn2tXD+95VtBSJ5eZoRIdIudt9UclIu
 cAqW+rnfrDYI+R89rnnuSxGsvZmcYq6Q2Kg7y/V2d6HgapLHZgVr4TnLZ8jVUksdct5i
 +dKINoFxqc0yFHVpi3jzqlQLz/UjTQfzyoYNS34G0gTm8gxmj8AlVFkl/7Og1yAXXKDG
 8Ezg==
X-Gm-Message-State: AOJu0YxTAHprbufyVh/kIimnTGel/bXagMpZMePDtvwmM8k+0Zev/iCh
 q6p8rlOYQFuCbVTTTg0flkw=
X-Google-Smtp-Source: AGHT+IFl1q+x425czgU+2CV9SWkpHHi/CwOTq+IOmFdd0jgY6BUI83I6pf6ZEADZGUEnzBiNviHV9g==
X-Received: by 2002:a7b:cc87:0:b0:3fe:2140:f504 with SMTP id
 p7-20020a7bcc87000000b003fe2140f504mr12390426wma.20.1692883820621; 
 Thu, 24 Aug 2023 06:30:20 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a1c7505000000b003fee8502999sm2650514wmc.18.2023.08.24.06.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 06:30:20 -0700 (PDT)
Date: Thu, 24 Aug 2023 15:30:18 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] mmc: tegra: get default-tap and default-trim from
 device tree
Message-ID: <ZOdbaul2TQ4CwndZ@orome>
References: <20230819153501.77245-1-clamor95@gmail.com>
 <20230819153501.77245-2-clamor95@gmail.com>
 <ZOXnfY5hKrhSpOlY@orome>
 <E8D9B66C-E23C-4359-928F-D510C8D4AF22@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6trSTmE4GvfO0tqA"
Content-Disposition: inline
In-Reply-To: <E8D9B66C-E23C-4359-928F-D510C8D4AF22@gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
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


--6trSTmE4GvfO0tqA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 03:02:42PM +0300, Svyatoslav Ryhel wrote:
>=20
>=20
> 23 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80. 14:03:25 GMT+03:00, =
Thierry Reding <thierry.reding@gmail.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=B2(-=D0=BB=D0=B0):
> >On Sat, Aug 19, 2023 at 06:35:01PM +0300, Svyatoslav Ryhel wrote:
> >> Default-tap and default-trim values are used for eMMC setup
> >> mostly on T114+ devices. As for now, those values are hardcoded
> >> for T210 and ignored for all other Tegra generations. Fix this
> >> by passing tap and trim values from dts.
> >>=20
> >> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF701T
> >> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >> ---
> >>  arch/arm/include/asm/arch-tegra/tegra_mmc.h | 17 ++++----
> >>  drivers/mmc/tegra_mmc.c                     | 46 ++++++++++-----------
> >>  2 files changed, 30 insertions(+), 33 deletions(-)
> >>=20
> >> diff --git a/arch/arm/include/asm/arch-tegra/tegra_mmc.h b/arch/arm/in=
clude/asm/arch-tegra/tegra_mmc.h
> >> index d6a55764ba..750c7d809e 100644
> >> --- a/arch/arm/include/asm/arch-tegra/tegra_mmc.h
> >> +++ b/arch/arm/include/asm/arch-tegra/tegra_mmc.h
> >> @@ -128,21 +128,22 @@ struct tegra_mmc {
> >> =20
> >>  /* SDMMC1/3 settings from SDMMCx Initialization Sequence of TRM */
> >>  #define MEMCOMP_PADCTRL_VREF	7
> >> -#define AUTO_CAL_ENABLE		(1 << 29)
> >> -#define AUTO_CAL_ACTIVE		(1 << 31)
> >> -#define AUTO_CAL_START		(1 << 31)
> >> +#define AUTO_CAL_ENABLE		BIT(29)
> >> +#define AUTO_CAL_ACTIVE		BIT(31)
> >> +#define AUTO_CAL_START		BIT(31)
> >> +
> >>  #if defined(CONFIG_TEGRA210)
> >>  #define AUTO_CAL_PD_OFFSET	(0x7D << 8)
> >>  #define AUTO_CAL_PU_OFFSET	(0 << 0)
> >> -#define IO_TRIM_BYPASS_MASK	(1 << 2)
> >> -#define TRIM_VAL_SHIFT		24
> >> -#define TRIM_VAL_MASK		(0x1F << TRIM_VAL_SHIFT)
> >> -#define TAP_VAL_SHIFT		16
> >> -#define TAP_VAL_MASK		(0xFF << TAP_VAL_SHIFT)
> >>  #else
> >>  #define AUTO_CAL_PD_OFFSET	(0x70 << 8)
> >>  #define AUTO_CAL_PU_OFFSET	(0x62 << 0)
> >>  #endif
> >> =20
> >> +#define TRIM_VAL_SHIFT		24
> >> +#define TRIM_VAL_MASK		(0x1F << TRIM_VAL_SHIFT)
> >> +#define TAP_VAL_SHIFT		16
> >> +#define TAP_VAL_MASK		(0xFF << TAP_VAL_SHIFT)
> >> +
> >>  #endif	/* __ASSEMBLY__ */
> >>  #endif	/* __TEGRA_MMC_H_ */
> >> diff --git a/drivers/mmc/tegra_mmc.c b/drivers/mmc/tegra_mmc.c
> >> index f76fee3ea0..7627800261 100644
> >> --- a/drivers/mmc/tegra_mmc.c
> >> +++ b/drivers/mmc/tegra_mmc.c
> >> @@ -37,6 +37,9 @@ struct tegra_mmc_priv {
> >>  	unsigned int version;	/* SDHCI spec. version */
> >>  	unsigned int clock;	/* Current clock (MHz) */
> >>  	int mmc_id;		/* peripheral id */
> >> +
> >> +	u32 tap_value;
> >> +	u32 trim_value;
> >>  };
> >> =20
> >>  static void tegra_mmc_set_power(struct tegra_mmc_priv *priv,
> >> @@ -526,31 +529,6 @@ static void tegra_mmc_pad_init(struct tegra_mmc_p=
riv *priv)
> >>  		printf("%s: Warning: Autocal timed out!\n", __func__);
> >>  		/* TBD: Set CFG2TMC_SDMMC1_PAD_CAL_DRV* regs here */
> >>  	}
> >> -
> >> -#if defined(CONFIG_TEGRA210)
> >> -	u32 tap_value, trim_value;
> >> -
> >> -	/* Set tap/trim values for SDMMC1/3 @ <48MHz here */
> >> -	val =3D readl(&priv->reg->venspictl);	/* aka VENDOR_SYS_SW_CNTL */
> >> -	val &=3D IO_TRIM_BYPASS_MASK;
> >> -	if (id =3D=3D PERIPH_ID_SDMMC1) {
> >> -		tap_value =3D 4;			/* default */
> >> -		if (val)
> >> -			tap_value =3D 3;
> >> -		trim_value =3D 2;
> >> -	} else {				/* SDMMC3 */
> >> -		tap_value =3D 3;
> >> -		trim_value =3D 3;
> >> -	}
> >> -
> >> -	val =3D readl(&priv->reg->venclkctl);
> >> -	val &=3D ~TRIM_VAL_MASK;
> >> -	val |=3D (trim_value << TRIM_VAL_SHIFT);
> >> -	val &=3D ~TAP_VAL_MASK;
> >> -	val |=3D (tap_value << TAP_VAL_SHIFT);
> >> -	writel(val, &priv->reg->venclkctl);
> >> -	debug("%s: VENDOR_CLOCK_CNTRL =3D 0x%08X\n", __func__, val);
> >> -#endif	/* T210 */
> >>  #endif	/* T30/T210 */
> >>  }
> >> =20
> >> @@ -588,6 +566,21 @@ static void tegra_mmc_reset(struct tegra_mmc_priv=
 *priv, struct mmc *mmc)
> >> =20
> >>  	/* Make sure SDIO pads are set up */
> >>  	tegra_mmc_pad_init(priv);
> >> +
> >> +	if (priv->tap_value || priv->trim_value) {
> >
> >I think 0 is a valid value for both tap and trim, so you want to be able
> >to write that. I suggest getting rid of the conditional and always
> >writing these values and rely on defaults to make sure that a good value
> >is always programmed.
> >
> >Alternatively if you really only want to program these when they've been
> >specified, use an extra variable (or something like -1 as a default
> >value) to discriminate.
>=20
> I may propose a compromise. Do not set default value at all and when time=
 comes just check if tap or trim is not error.

Yes, that's essentially a variant of the second option and it should
work.

Thierry

--6trSTmE4GvfO0tqA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTnW2oACgkQ3SOs138+
s6GTfQ//bZZ9vq8iGkj/uKTFe6r3XQhgNwmN6RY5jkbdWFVJ2vRfBm0Hxpgne9KR
9J3kOVVa3ef3xvenKy9eRdBkUleRZ+N6Gg1zXluRmCHh+MHluh1NZyshQKeJ0IU2
ByeFAq/h2fGI9xK1FNrmOyWQjdFW1L7s7hEfjRD3YINOsPbxRNEtomI7494G4QrX
R+PAEattCyRYbHocbwVbgTwmZdBB4SAobkXEF3n583k8hkcr8aj1Ix1PwNUUOfRK
8fNqddXanj31lflbkHS4KVEUFQnZh8yoc7ggGXOmd9KBbBYBwV2KXO7mM8ByAHJF
07rJYyAtsmGN2TXTdlwoHqrvpDOf3gXnW2bEsizHwKICmLpllUlKoNZs7mKg1LWH
/Kcx83ZMJz7rwVRGTYwE0KEoTBC0J4nn9XcmK2iBsYAMsFk2irE1DV5esGz0rm0v
2lFvuAgE7rS+DlB5sM5zA3hb1u4dtktfcfIXkEdr/yiJx7sB3FSKFa+RruDI6Lmk
pFvw5DBeuRDKhgcBVL/1P7xr+qeMTO4QHlCPz1+jyE/fFo0rBfGaYJCnY23Qif3V
9CTzXc+H5BSwbIjt7V6JBFqIT4uo0hiV9/gR5Gbr+vL9Dz3cJoRTnZcXcfdhXPEF
UoQJF6pdXwF/TJnvel5TbnQfcxy5+cwp6dDWecDCGAQJAVwODr0=
=jQnN
-----END PGP SIGNATURE-----

--6trSTmE4GvfO0tqA--
