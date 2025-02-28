Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3CCC282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 13:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEDC48118A;
	Fri, 28 Feb 2025 14:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE6198118A; Fri, 28 Feb 2025 14:29:10 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 314BA8110C
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 14:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: oAo3u3h3RJy9hZN5JM3OJA==
X-CSE-MsgGUID: IaeBlSw3SEabVrd5fuc0eA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2025 22:28:59 +0900
Received: from [10.226.94.53] (unknown [10.226.94.53])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id AA93A4307494;
 Fri, 28 Feb 2025 22:28:55 +0900 (JST)
Message-ID: <b97cc5fc-b622-419c-a556-655de50a4312@bp.renesas.com>
Date: Fri, 28 Feb 2025 13:28:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/23] net: ravb: Allocate bb_miiphy using
 bb_miiphy_alloc() and fill in callbacks
Content-Language: en-GB
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Jim Liu
 <JJLIU0@nuvoton.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
 <20250222203511.195437-16-marek.vasut+renesas@mailbox.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20250222203511.195437-16-marek.vasut+renesas@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------o1TLtZCLuqc2AOaqOcUIP3en"
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------o1TLtZCLuqc2AOaqOcUIP3en
Content-Type: multipart/mixed; boundary="------------jTbwRB7UdYlUtBm86ekBB2l6";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Jim Liu
 <JJLIU0@nuvoton.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Message-ID: <b97cc5fc-b622-419c-a556-655de50a4312@bp.renesas.com>
Subject: Re: [PATCH v3 15/23] net: ravb: Allocate bb_miiphy using
 bb_miiphy_alloc() and fill in callbacks
References: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
 <20250222203511.195437-16-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250222203511.195437-16-marek.vasut+renesas@mailbox.org>

--------------jTbwRB7UdYlUtBm86ekBB2l6
Content-Type: multipart/mixed; boundary="------------Hxi2EZ9hXfHL7LXR3gip9OIa"

--------------Hxi2EZ9hXfHL7LXR3gip9OIa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 22/02/2025 20:33, Marek Vasut wrote:
> Allocate bb_miiphy using bb_miiphy_alloc() and fill in callbacks
> currently listed in bb_miiphy_buses[] array. This is a temporary
> duplication of assignment to avoid breakage, which will be removed
> in follow up patches. At this point, the bb_miiphy callbacks can
> reach these accessors by doing container_of() on struct mii_dev.
>=20
> Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Christian Marangi <ansuelsmth@gmail.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> Cc: Jim Liu <JJLIU0@nuvoton.com>
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: No change
> V3: Add RB from Paul
> ---
>  drivers/net/ravb.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
> index 381cf250ea2..0018b694ec1 100644
> --- a/drivers/net/ravb.c
> +++ b/drivers/net/ravb.c
> @@ -553,6 +553,7 @@ static int ravb_probe(struct udevice *dev)
>  {
>  	struct eth_pdata *pdata =3D dev_get_plat(dev);
>  	struct ravb_priv *eth =3D dev_get_priv(dev);
> +	struct bb_miiphy_bus *bb_miiphy;
>  	struct mii_dev *mdiodev;
>  	void __iomem *iobase;
>  	int ret;
> @@ -564,17 +565,29 @@ static int ravb_probe(struct udevice *dev)
>  	if (ret < 0)
>  		goto err_mdio_alloc;
> =20
> -	mdiodev =3D mdio_alloc();
> -	if (!mdiodev) {
> +	bb_miiphy =3D bb_miiphy_alloc();
> +	if (!bb_miiphy) {
>  		ret =3D -ENOMEM;
>  		goto err_mdio_alloc;
>  	}
> =20
> +	mdiodev =3D &bb_miiphy->mii;
> +
>  	mdiodev->read =3D bb_miiphy_read;
>  	mdiodev->write =3D bb_miiphy_write;
>  	bb_miiphy_buses[0].priv =3D eth;
>  	snprintf(mdiodev->name, sizeof(mdiodev->name), dev->name);
> =20
> +	/* Copy the bus accessors, name and private data */
> +	bb_miiphy->mdio_active =3D ravb_bb_mdio_active;
> +	bb_miiphy->mdio_tristate =3D ravb_bb_mdio_tristate;
> +	bb_miiphy->set_mdio =3D ravb_bb_set_mdio;
> +	bb_miiphy->get_mdio =3D ravb_bb_get_mdio;
> +	bb_miiphy->set_mdc =3D ravb_bb_set_mdc;
> +	bb_miiphy->delay =3D ravb_bb_delay;
> +	strlcpy(bb_miiphy->name, "ravb", MDIO_NAME_LEN);
> +	bb_miiphy->priv =3D eth;
> +
>  	ret =3D mdio_register(mdiodev);
>  	if (ret < 0)
>  		goto err_mdio_register;
> @@ -599,7 +612,7 @@ static int ravb_probe(struct udevice *dev)
>  err_mdio_reset:
>  	clk_release_bulk(&eth->clks);
>  err_mdio_register:
> -	mdio_free(mdiodev);
> +	bb_miiphy_free(bb_miiphy);
>  err_mdio_alloc:
>  	unmap_physmem(eth->iobase, MAP_NOCACHE);
>  	return ret;

Marek,

I've rebased my RZ/G2L Ethernet patches on top of this series and as
part of tidying things up I spotted an issue that I'd missed -
ravb_remove() still calls mdio_free(eth->bus). The error paths in the
probe functions have been converted but the remove functions were
missed. It should instead use something like:

    struct bb_miiphy_bus *bus =3D container_of(eth->bus, struct bb_miiphy=
_bus, mii);
    bb_miiphy_free(bus);

The same applies to the following two patches (sh_eth.c & designware.c). =


Thanks,

--=20
Paul Barker
--------------Hxi2EZ9hXfHL7LXR3gip9OIa
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------Hxi2EZ9hXfHL7LXR3gip9OIa--

--------------jTbwRB7UdYlUtBm86ekBB2l6--

--------------o1TLtZCLuqc2AOaqOcUIP3en
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZ8G6FgUDAAAAAAAKCRDbaV4Vf/JGvXHz
AQDLAJxVSTsw4O0ugMLVKoGhE9HVhwnF73ZF3UrzOKQgjgD5AUkYLQZDfh4GT7EOrr2WjZDXSY7C
1ih9HGkTJmScUAU=
=4NVd
-----END PGP SIGNATURE-----

--------------o1TLtZCLuqc2AOaqOcUIP3en--
