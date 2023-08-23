Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9309EE49B0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 11:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0BAC864AD;
	Wed, 23 Aug 2023 13:03:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="opkAVOjp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38245864C4; Wed, 23 Aug 2023 13:03:30 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41BD5847C3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 13:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-99c4923195dso710510966b.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 04:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692788608; x=1693393408;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yYEYVyWKm0udFzduLufwlzOxFSAgPYfzhXT4i8rYwtw=;
 b=opkAVOjpuDOpre3HdXqATF9bEh+yHVVhFbO9KMyE2B9+GOTS+YszetJr0unghJtJsx
 dLEMwgIaGB4WruSt50ngyCqfOvoEw8xMljktjqJwd6fKQAb2vRhAfain7G/YXLxUgPZL
 70bepb4DEUOZiDMAgMMizZTukvDbjY2YCkwL6eHmuyVOUShFK7NYWnHX8R6X2CHufm+R
 TDHDAKY5xA03p9g4qv0u5K/tTQQhXVwLAp15BohL6mitmGtnU/PUTFGXDyv4pEih5P99
 5BvsFIcvQFzYnP3eY6UwbZIqrZkFis9jBRYThb2D0599hKtNUv2ldCznjYpa+QT+HGAu
 QMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692788608; x=1693393408;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yYEYVyWKm0udFzduLufwlzOxFSAgPYfzhXT4i8rYwtw=;
 b=lwaKyHYW1LIbQg6MUMqvZqQy6d9BVMKFqZXKVqw2XvATAHmGuRxSyln4jqcjWxudBL
 kGQUC4SyINaFoja65THcH/R65n2kkirmBzSUq4hEW2Mb53Sx/ahKdrNRUF1CnKiEmcf8
 EBmweGvhJrhuN8RVtXNAYqdF1+HtqfGnxI8UoBQdIxyU0PR6hTQbYtCi80WxuoLFMjOn
 MJDAHKYMMXeSxv6tzX6nQrrHtdehg2EO0IsKbSfSa/3zd0Kua78w6kK68cEfTxekYFTT
 FTcJdDvglI6DIA/pDXHWinewCId6kss0zrzycf4qigED7Oo4VYAtbZKd12iAPyfqizQF
 CRzw==
X-Gm-Message-State: AOJu0YwHB3Lry6j9imR8dBN2mjQyl4JCqI5jxSXTfRDoVBK5XnBjzHfm
 PzbsAivkkaJ6pajoc9XD0Ig=
X-Google-Smtp-Source: AGHT+IEZS+8pcq3YQ4fK36e+mS0PbsWO/YdVOpQq4zlFYiobHJPvbi8JHS1iPFpI5g2tkzC/xZfZmw==
X-Received: by 2002:a17:906:5dd8:b0:99b:cd46:844f with SMTP id
 p24-20020a1709065dd800b0099bcd46844fmr10205666ejv.58.1692788607523; 
 Wed, 23 Aug 2023 04:03:27 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 kf18-20020a17090776d200b0098748422178sm9590536ejc.56.2023.08.23.04.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 04:03:27 -0700 (PDT)
Date: Wed, 23 Aug 2023 13:03:25 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] mmc: tegra: get default-tap and default-trim from
 device tree
Message-ID: <ZOXnfY5hKrhSpOlY@orome>
References: <20230819153501.77245-1-clamor95@gmail.com>
 <20230819153501.77245-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HFEBA5r4SaqvOOR9"
Content-Disposition: inline
In-Reply-To: <20230819153501.77245-2-clamor95@gmail.com>
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


--HFEBA5r4SaqvOOR9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 06:35:01PM +0300, Svyatoslav Ryhel wrote:
> Default-tap and default-trim values are used for eMMC setup
> mostly on T114+ devices. As for now, those values are hardcoded
> for T210 and ignored for all other Tegra generations. Fix this
> by passing tap and trim values from dts.
>=20
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF701T
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/include/asm/arch-tegra/tegra_mmc.h | 17 ++++----
>  drivers/mmc/tegra_mmc.c                     | 46 ++++++++++-----------
>  2 files changed, 30 insertions(+), 33 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/arch-tegra/tegra_mmc.h b/arch/arm/inclu=
de/asm/arch-tegra/tegra_mmc.h
> index d6a55764ba..750c7d809e 100644
> --- a/arch/arm/include/asm/arch-tegra/tegra_mmc.h
> +++ b/arch/arm/include/asm/arch-tegra/tegra_mmc.h
> @@ -128,21 +128,22 @@ struct tegra_mmc {
> =20
>  /* SDMMC1/3 settings from SDMMCx Initialization Sequence of TRM */
>  #define MEMCOMP_PADCTRL_VREF	7
> -#define AUTO_CAL_ENABLE		(1 << 29)
> -#define AUTO_CAL_ACTIVE		(1 << 31)
> -#define AUTO_CAL_START		(1 << 31)
> +#define AUTO_CAL_ENABLE		BIT(29)
> +#define AUTO_CAL_ACTIVE		BIT(31)
> +#define AUTO_CAL_START		BIT(31)
> +
>  #if defined(CONFIG_TEGRA210)
>  #define AUTO_CAL_PD_OFFSET	(0x7D << 8)
>  #define AUTO_CAL_PU_OFFSET	(0 << 0)
> -#define IO_TRIM_BYPASS_MASK	(1 << 2)
> -#define TRIM_VAL_SHIFT		24
> -#define TRIM_VAL_MASK		(0x1F << TRIM_VAL_SHIFT)
> -#define TAP_VAL_SHIFT		16
> -#define TAP_VAL_MASK		(0xFF << TAP_VAL_SHIFT)
>  #else
>  #define AUTO_CAL_PD_OFFSET	(0x70 << 8)
>  #define AUTO_CAL_PU_OFFSET	(0x62 << 0)
>  #endif
> =20
> +#define TRIM_VAL_SHIFT		24
> +#define TRIM_VAL_MASK		(0x1F << TRIM_VAL_SHIFT)
> +#define TAP_VAL_SHIFT		16
> +#define TAP_VAL_MASK		(0xFF << TAP_VAL_SHIFT)
> +
>  #endif	/* __ASSEMBLY__ */
>  #endif	/* __TEGRA_MMC_H_ */
> diff --git a/drivers/mmc/tegra_mmc.c b/drivers/mmc/tegra_mmc.c
> index f76fee3ea0..7627800261 100644
> --- a/drivers/mmc/tegra_mmc.c
> +++ b/drivers/mmc/tegra_mmc.c
> @@ -37,6 +37,9 @@ struct tegra_mmc_priv {
>  	unsigned int version;	/* SDHCI spec. version */
>  	unsigned int clock;	/* Current clock (MHz) */
>  	int mmc_id;		/* peripheral id */
> +
> +	u32 tap_value;
> +	u32 trim_value;
>  };
> =20
>  static void tegra_mmc_set_power(struct tegra_mmc_priv *priv,
> @@ -526,31 +529,6 @@ static void tegra_mmc_pad_init(struct tegra_mmc_priv=
 *priv)
>  		printf("%s: Warning: Autocal timed out!\n", __func__);
>  		/* TBD: Set CFG2TMC_SDMMC1_PAD_CAL_DRV* regs here */
>  	}
> -
> -#if defined(CONFIG_TEGRA210)
> -	u32 tap_value, trim_value;
> -
> -	/* Set tap/trim values for SDMMC1/3 @ <48MHz here */
> -	val =3D readl(&priv->reg->venspictl);	/* aka VENDOR_SYS_SW_CNTL */
> -	val &=3D IO_TRIM_BYPASS_MASK;
> -	if (id =3D=3D PERIPH_ID_SDMMC1) {
> -		tap_value =3D 4;			/* default */
> -		if (val)
> -			tap_value =3D 3;
> -		trim_value =3D 2;
> -	} else {				/* SDMMC3 */
> -		tap_value =3D 3;
> -		trim_value =3D 3;
> -	}
> -
> -	val =3D readl(&priv->reg->venclkctl);
> -	val &=3D ~TRIM_VAL_MASK;
> -	val |=3D (trim_value << TRIM_VAL_SHIFT);
> -	val &=3D ~TAP_VAL_MASK;
> -	val |=3D (tap_value << TAP_VAL_SHIFT);
> -	writel(val, &priv->reg->venclkctl);
> -	debug("%s: VENDOR_CLOCK_CNTRL =3D 0x%08X\n", __func__, val);
> -#endif	/* T210 */
>  #endif	/* T30/T210 */
>  }
> =20
> @@ -588,6 +566,21 @@ static void tegra_mmc_reset(struct tegra_mmc_priv *p=
riv, struct mmc *mmc)
> =20
>  	/* Make sure SDIO pads are set up */
>  	tegra_mmc_pad_init(priv);
> +
> +	if (priv->tap_value || priv->trim_value) {

I think 0 is a valid value for both tap and trim, so you want to be able
to write that. I suggest getting rid of the conditional and always
writing these values and rely on defaults to make sure that a good value
is always programmed.

Alternatively if you really only want to program these when they've been
specified, use an extra variable (or something like -1 as a default
value) to discriminate.

The former is superior, in my opinion, because it also allows to avoid
to regression.

Thierry

> +		u32 val;
> +
> +		val =3D readl(&priv->reg->venclkctl);
> +
> +		val &=3D ~TRIM_VAL_MASK;
> +		val |=3D (priv->trim_value << TRIM_VAL_SHIFT);
> +
> +		val &=3D ~TAP_VAL_MASK;
> +		val |=3D (priv->tap_value << TAP_VAL_SHIFT);
> +
> +		writel(val, &priv->reg->venclkctl);
> +		debug("%s: VENDOR_CLOCK_CNTRL =3D 0x%08X\n", __func__, val);
> +	}
>  }
> =20
>  static int tegra_mmc_init(struct udevice *dev)
> @@ -742,6 +735,9 @@ static int tegra_mmc_probe(struct udevice *dev)
>  	if (dm_gpio_is_valid(&priv->pwr_gpio))
>  		dm_gpio_set_value(&priv->pwr_gpio, 1);
> =20
> +	priv->tap_value =3D dev_read_u32_default(dev, "nvidia,default-tap", 0);
> +	priv->trim_value =3D dev_read_u32_default(dev, "nvidia,default-trim", 0=
);
> +
>  	upriv->mmc =3D &plat->mmc;
> =20
>  	return tegra_mmc_init(dev);
> --=20
> 2.39.2
>=20

--HFEBA5r4SaqvOOR9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTl530ACgkQ3SOs138+
s6EvrhAArat7MA5H4Tgt8GKcr6P478YgIsLxxlw8i3UMjofnIxQ8cW9N5e69BwYy
sRwrJ3Y8cIkjlQeltxm5vwsCQNemYhwJsTPsl/4cCdvYIvSnIc9Ps+HhF+EgNZiP
FUe6nIKwhf99SFmlKgq+Of3BGrXEcdhdweQ/5dpU2GHvlJsW4DX7g0TINdBebOBC
c2zvmvhYRm4lGoIkHWX2B3a+34IZe0PZa8G9qXWc+E3H5nSc+OFJXVtVuMJMF73H
QX8a+yriFpCFSg+s/zfwnYBf58fjeO7hm5v/hdNY0tvEhUWsN+QKUKlnCYatpRA8
fQ3hhcoaEQe9XmmIAfsWsOWXuUvf6KpKr9hzo8HLTEI+Eg5E1ezo1NEvaWz2rHIC
pLAgzb3gjF5y3QZRz07pB69LF/SvbjQz5GTPNTP8xnQSlLOoVSgVsNWHxcyUmhgQ
WS6f9p7K9gv9ee3tCQl1GD0L6Zf+AA0UD0hX88fl7lLBEb1pdcH5W6q6E1icE8FV
2yNAj4HdmIJar5cYmNYW6UJBiMOmVu714cljORO/7JswAGZtERiAEubbSXDPdpU8
xuFGHHu90ZXvgh7jV4r2C1lQqELJ2T9/GTkmObAoq63RtfK1g+N7JNICeabkdx/L
UOnssiGJ0nGreNMyFil41KEhFnQN0wEF7slLbujIeItlxdoxjNs=
=TNZQ
-----END PGP SIGNATURE-----

--HFEBA5r4SaqvOOR9--
