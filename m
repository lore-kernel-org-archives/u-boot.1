Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9100DC4167D
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 20:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD0DC86F9F;
	Mon,  6 Nov 2023 21:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FB0986F9F; Mon,  6 Nov 2023 21:04:37 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id B81EF87091
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 21:04:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,282,1694703600"; 
 d="asc'?scan'208";a="185754859"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 07 Nov 2023 05:04:30 +0900
Received: from unknown (unknown [10.226.92.3])
 by relmlir5.idc.renesas.com (Postfix) with SMTP id C5AA6400A662;
 Tue,  7 Nov 2023 05:04:28 +0900 (JST)
Date: Mon, 6 Nov 2023 20:04:27 +0000
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] mmc: renesas-sdhi: Disable clock after tuning reset when
 possible
Message-ID: <20231106200427.lkp4hogh3xflwxh7@GBR-5CG2373LKG.adwin.renesas.com>
References: <20231105224304.103997-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mg2w2vs7vmtbpil7"
Content-Disposition: inline
In-Reply-To: <20231105224304.103997-1-marek.vasut+renesas@mailbox.org>
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


--mg2w2vs7vmtbpil7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 05, 2023 at 11:42:45PM +0100, Marek Vasut wrote:
> Currently the renesas_sdhi_reset_tuning() unconditionally leaves SDHI
> clock enabled after the tuning reset. This is not always necessary.
>=20
> After the driver performed tuning reset at the end of probe function,
> or in the unlikely case that tuning failed during regular operation,
> the SDHI clock can be disabled after the tuning reset. The following
> set_ios call would reconfigure the clock as needed.
>=20
> In case of regular set_ios call which requires a tuning reset, keep
> the clock enabled or disabled according to the mmc->clk_disable state.
>=20
> With this in place, the controllers which have not been accessed via
> block subsystem after boot are left in quiescent state. However, if an
> MMC device is used e.g. for environment storage, that controller would
> be accessed during the environment load and left active, including its
> clock which would still be generated. This is due to the design of the
> MMC subsystem, which does not deinit a controller after it was started
> once, the controller is only deinited in case of mmc rescan, or before
> OS boot.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Note: To address the part where MMC device has been inited once and
>       is never deinited until rescan or OS boot, it would likely be
>       necessary to implement something like runtime PM, possibly
>       based on the cyclic framework. Basically, keep track of when
>       the MMC was accessed last, and if certain time elapsed, deinit
>       the MMC. This could also be used to handle card detect polling
>       at the same time.
> ---
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/mmc/renesas-sdhi.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
> index 8cd501c5f7c..97aaf1e4ec3 100644
> --- a/drivers/mmc/renesas-sdhi.c
> +++ b/drivers/mmc/renesas-sdhi.c
> @@ -318,7 +318,7 @@ static unsigned int renesas_sdhi_init_tuning(struct t=
mio_sd_priv *priv)
>  		RENESAS_SDHI_SCC_DTCNTL_TAPNUM_MASK;
>  }
> =20
> -static void renesas_sdhi_reset_tuning(struct tmio_sd_priv *priv)
> +static void renesas_sdhi_reset_tuning(struct tmio_sd_priv *priv, bool cl=
k_disable)
>  {
>  	u32 reg;
> =20
> @@ -350,6 +350,12 @@ static void renesas_sdhi_reset_tuning(struct tmio_sd=
_priv *priv)
>  	reg =3D tmio_sd_readl(priv, RENESAS_SDHI_SCC_RVSCNTL);
>  	reg &=3D ~RENESAS_SDHI_SCC_RVSCNTL_RVSEN;
>  	tmio_sd_writel(priv, reg, RENESAS_SDHI_SCC_RVSCNTL);
> +
> +	if (clk_disable) {
> +		reg =3D tmio_sd_readl(priv, TMIO_SD_CLKCTL);
> +		reg &=3D ~TMIO_SD_CLKCTL_SCLKEN;
> +		tmio_sd_writel(priv, reg, TMIO_SD_CLKCTL);
> +	}
>  }
> =20
>  static int renesas_sdhi_hs400(struct udevice *dev)
> @@ -629,7 +635,7 @@ int renesas_sdhi_execute_tuning(struct udevice *dev, =
uint opcode)
>  out:
>  	if (ret < 0) {
>  		dev_warn(dev, "Tuning procedure failed\n");
> -		renesas_sdhi_reset_tuning(priv);
> +		renesas_sdhi_reset_tuning(priv, true);
>  	}
> =20
>  	return ret;
> @@ -668,7 +674,7 @@ static int renesas_sdhi_set_ios(struct udevice *dev)
>  	    (mmc->selected_mode !=3D UHS_SDR104) &&
>  	    (mmc->selected_mode !=3D MMC_HS_200) &&
>  	    (mmc->selected_mode !=3D MMC_HS_400)) {
> -		renesas_sdhi_reset_tuning(priv);
> +		renesas_sdhi_reset_tuning(priv, mmc->clk_disable);
>  	}
>  #endif
> =20
> @@ -1095,7 +1101,7 @@ static int renesas_sdhi_probe(struct udevice *dev)
>      CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) || \
>      CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)
>  	if (priv->caps & TMIO_SD_CAP_RCAR_UHS)
> -		renesas_sdhi_reset_tuning(priv);
> +		renesas_sdhi_reset_tuning(priv, true);
>  #endif
>  	return 0;

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Tested-by: Paul Barker <paul.barker.ct@bp.renesas.com>
  (on RZ/G2L SMARC EVK)

Thanks,
Paul

--mg2w2vs7vmtbpil7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZUlGvgAKCRDbaV4Vf/JG
vXNbAPsF8Lqn6O6vaPjCCt/Z6aRQiDp3F1QGdJimpxvsqNFiGQEA7OlXLKvwzcZ9
1uUP36N8Vy6Czynh0FG9peDiTf4Jtwk=
=c17M
-----END PGP SIGNATURE-----

--mg2w2vs7vmtbpil7--
