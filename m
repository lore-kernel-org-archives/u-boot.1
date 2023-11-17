Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C13C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 08:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBFED86F67;
	Fri, 17 Nov 2023 09:35:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B155186F67; Fri, 17 Nov 2023 09:35:26 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id A907886F5C
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 09:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.04,206,1695654000"; 
 d="asc'?scan'208";a="187148836"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 17 Nov 2023 17:35:07 +0900
Received: from unknown (unknown [10.226.93.135])
 by relmlir6.idc.renesas.com (Postfix) with SMTP id B857E41B7CE0;
 Fri, 17 Nov 2023 17:35:04 +0900 (JST)
Date: Fri, 17 Nov 2023 08:35:01 +0000
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2] net: designware: Add bitbang feature for designware
 driver
Message-ID: <20231117083501.2fpnpdr3bejt6i6w@GBR-5CG2373LKG.adwin.renesas.com>
References: <20231117020453.1111505-1-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dwyeotoas7e2epcf"
Content-Disposition: inline
In-Reply-To: <20231117020453.1111505-1-JJLIU0@nuvoton.com>
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


--dwyeotoas7e2epcf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 10:04:53AM +0800, Jim Liu wrote:
> Add bb_miiphy_bus function for designware bitbang feature.
>=20
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> ---
> Changes for v2:
>    - add bitbang delay dts read
>    - modify printf to debug
> ---
>  drivers/net/designware.c | 105 +++++++++++++++++++++++++++++++++++++++
>  drivers/net/designware.h |   5 ++
>  2 files changed, 110 insertions(+)
>=20
> diff --git a/drivers/net/designware.c b/drivers/net/designware.c
> index a174344b3e..e86f96fc1a 100644
> --- a/drivers/net/designware.c
> +++ b/drivers/net/designware.c
> @@ -767,6 +767,31 @@ int designware_eth_probe(struct udevice *dev)
>  	priv->bus =3D miiphy_get_dev_by_name(dev->name);
>  	priv->dev =3D dev;
> =20
> +#if defined(CONFIG_BITBANGMII) && CONFIG_IS_ENABLED(DM_GPIO)
> +	if (dev_read_bool(dev, "snps,bitbang-mii")) {
> +		debug("\n%s: use bitbang mii..\n", dev->name);
> +		ret =3D gpio_request_by_name(dev, "snps,mdc-gpio", 0,
> +                                &priv->mdc_gpio, GPIOD_IS_OUT | GPIOD_IS=
_OUT_ACTIVE);
> +		if (ret) {
> +			printf("no mdc-gpio\n");
> +			return ret;
> +		}
> +		ret =3D gpio_request_by_name(dev, "snps,mdio-gpio", 0,
> +                                &priv->mdio_gpio, GPIOD_IS_OUT | GPIOD_I=
S_OUT_ACTIVE);
> +		if (ret) {
> +			printf("no mdio-gpio\n");
> +			return ret;
> +		}
> +
> +		priv->bb_delay =3D dev_read_u32_default(dev, "snps,bitbang-delay", 1);
> +
> +		bb_miiphy_buses[0].priv =3D priv;
> +		sprintf(bb_miiphy_buses[0].name, dev->name);

If designware_eth_probe() is called for multiple Ethernet interfaces
then only the last interface to be probed will have a working MDIO bus.

We should either support multiple buses here or raise an error if there
is an attempt to probe a second interface.

(I spotted the same issue in the ravb driver while extending it to
support a board with two Ethernet interfaces)

Thanks,
Paul

--dwyeotoas7e2epcf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZVclogAKCRDbaV4Vf/JG
vXJKAP9gwVAw3xYoEuqtFQmGbOKicfdEI/onK4LYpMGvyduxlgEAw8xx1ffdqmC5
Vi3bC7KUxNvLDzxaudycU+bG/UhdgQs=
=H/G9
-----END PGP SIGNATURE-----

--dwyeotoas7e2epcf--
