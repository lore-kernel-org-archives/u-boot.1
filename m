Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A348EC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 13:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BDA88657A;
	Thu, 24 Aug 2023 15:29:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H0/ZM08Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A0288653D; Thu, 24 Aug 2023 15:29:27 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E29558653B
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 15:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-52683b68c2fso8496058a12.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 06:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692883764; x=1693488564;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D2r+BOb7255P8mHHzvJVb3XU8ybvvWYg5LAjNUTvPSw=;
 b=H0/ZM08ZbCC5v6Nhv3WGUyp48X90rRBhuHmMRXKZEiZnQDDNSOIsCSA8Z7IPeBdI56
 hhiPIGAoIi90/TmnZQDK3XWemM0F5I+oXQaMQ4/sgpcQo47NCtDBGx3PmLbI2kM3qW+a
 GJNEwmGmzEyg6j2dApwg4bP2w6a7zVgZeTQT20sWRQFovswQtKf3CrH05W4vCosVmH5Y
 4X7CwPKzzpgfXJnbFMjiK3EbqPNmA2ZK52CCeqvq5pOcxcginSdMeO+/0/pwH3BToNQK
 2LmmydxFyMZoeu9ZZ2VYcb/d9Swkbe7X5atLUrc8hc4ruDjB7+PAVGYjeNBt16ugNHp8
 3ajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692883764; x=1693488564;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D2r+BOb7255P8mHHzvJVb3XU8ybvvWYg5LAjNUTvPSw=;
 b=H8WK5rhKnSK/92NygCs3o19/7F8yxZ+MRU/6cZ236hjb8Yfh9c7sKeUm6K6RaW9juN
 AaDzroKAYXa9xU+NSN28N4ZSbBLmGbEPaiRJEDRbJV0jzJX4iaflbdqyDcRbLwgmcGNM
 awtcEpJoHZf/8aWJb4wvriZf2mJmLqyCsO4llphqwTXvuIhIBRt3ChQ5lmPSsnpY6iD8
 ewcqD6hsddJZbME/ei6LeQEpk/L8pYDJSzOWwUkyw4505y9bR4v/8YvNBwnRlp5i9Tro
 /yk/E3pSxx4/1ga3Cl18CuPOxYHpbyZxyND/nMKu0yB1BfUtVYOPqJ/vvK2qVq9/SOea
 PZxA==
X-Gm-Message-State: AOJu0YwOG9sv8umBw1JC7rT8sPVFRikYClg4kepLp20aAkuEtLFluwPr
 ML9JM1HKtCWPKgcodNtXd/LcHGIiEFg=
X-Google-Smtp-Source: AGHT+IG1TqduTZS0Zm772W3zT6Aj+fZv08wJqUB7WvB5ndpS1ZaACLEJnNQe4kKYispC60iQfMV6RQ==
X-Received: by 2002:a17:906:9d1:b0:99c:dc3e:f8e3 with SMTP id
 r17-20020a17090609d100b0099cdc3ef8e3mr11899846eje.28.1692883764229; 
 Thu, 24 Aug 2023 06:29:24 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a170906240e00b00982d0563b11sm11048449eja.197.2023.08.24.06.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 06:29:23 -0700 (PDT)
Date: Thu, 24 Aug 2023 15:29:22 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] mmc: tegra: get default-tap and default-trim from
 device tree
Message-ID: <ZOdbMq68QtVbrGVM@orome>
References: <20230819153501.77245-1-clamor95@gmail.com>
 <20230819153501.77245-2-clamor95@gmail.com>
 <ZOXnfY5hKrhSpOlY@orome>
 <B2FF6549-4F01-4010-968E-D790E72AE2EE@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HLWpqPx4XZYkemr3"
Content-Disposition: inline
In-Reply-To: <B2FF6549-4F01-4010-968E-D790E72AE2EE@gmail.com>
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


--HLWpqPx4XZYkemr3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 02:38:48PM +0300, Svyatoslav Ryhel wrote:
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
>=20
> Tegra 3 uses 0x0F on all my devices which is not 0.
>=20
> >Alternatively if you really only want to program these when they've been
> >specified, use an extra variable (or something like -1 as a default
> >value) to discriminate.
>=20
> Why 0 value cannot be used as "flag" to skip tap and trim setup if values=
 are not set? Using any value but 0 will cause additional comparation in co=
ndition and will definitely not improve readability.

If you use 0 as a flag it implies that you can never set 0 as a value
explicitly. So if some SoC or board ever needs to set that exact value
it can't.

Thierry

--HLWpqPx4XZYkemr3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTnWzIACgkQ3SOs138+
s6HxlxAAlr3Efg2yVMKNaVlfCwr8Hy4GmLEWVome8st6dJWaA8nO4TAMIMY4qdMq
T5QxhKu8Nxr5Tpyd3w0TMKIuBB+goih2c7Dy5rv9b6LlBwBhxwo//MyXtvwi/LHp
1nI/gLuBlYYwizFf6t44rKfP1ln+x1Z2vUv4hPfCkwd3nTShMwCg7jvFOBQtx4rJ
yqOb3uYAkvIhK1Dj1lw1n5cXqg1WCLTRVR8k/wr1MUJPfPJjtyzbH1drfww7NPzl
0yXmcY7NT9MIo/rpSLGNKxtXVyOcgFlq/lSD5lxvrxAZ5lySs0p5V/I0I1+RRrmF
0jLJK10UeZHLLjtY+TEfYzYcGxq5CJezW3AyZrlg+mtTBfek2gZbM6jIyLPdwBdn
cQcnGYQtuu1+muV5MADxXTxZ6klR55ASnHzClYE9IrOGw27gxbj9A1tlDuPJl7BX
Hz7Y81s00BXvrBX8HYDZyzBFm5o+lXsA3uj4UvSbDYXLewsA78gZfldGDboguG87
JIFL2jA4g2sVOqpiYMSLdiQHYAE5VViZGTCulq+Exof60wF1F8XdQr+e1RVj99XE
mjKWWmeGZVnkS0a9iziTUZyLFGrA+4st7oM6dj+hTULPMeqFB4FUZ2wya8JHFnpe
+TXftPOS0NerPqp3jXiwLwJ7/daNPvAQdPBfQKI/3ICgUiLHnjs=
=JKTQ
-----END PGP SIGNATURE-----

--HLWpqPx4XZYkemr3--
