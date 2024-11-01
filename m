Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2C6E6F07D
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 18:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3147B89048;
	Fri,  1 Nov 2024 19:17:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="gnXZjGYB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D428902F; Fri,  1 Nov 2024 19:17:52 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB56C88A4C
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 19:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730485065; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mYDSRI6u3eeo7HQiNmE83QfRkD6LMrBl8p8p0RPyx5G27nUGfPX8A2ZL0T4yHrOn6sg4CTw8GYMxxsUMV7t1ZWqIckxb8/cqdPRJC5VJxvQJA9Stt1kB+CsE8UnrfL7lPhXn/Urqm6qfYUvTfHfR/FY2kxe4sMAniqu+PS0ppR4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1730485065;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=O2YZ87dcimYbkfj+whbZnp3aZEYrba9KFgGZ66MsAnk=; 
 b=irTi6NDiBwq43wHn6yy54lhIApP83+xTiTkXetcGaEtt+ISUo6Eeh3whI89aVfN8Mn2rpqEvXF7XCIKBuR6siYyqbR/B2x0zqP7dWu3Bn6Lxa8TatbEoyXAN0zdTi3OOozHY5BefDzH4BWPm5YPS0+LvEXMAYIrQ32XySEQLqrk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730485065; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=O2YZ87dcimYbkfj+whbZnp3aZEYrba9KFgGZ66MsAnk=;
 b=gnXZjGYBKKRhX6n0WmOrDOXQ3Qg5jZo2Xtw1hcEJ6KsXJsUvVFqx9loBY/E1l0Cs
 bf+EoPrcCCY6vA3dL3hotDVA6pNPlwmVOZgOXC0AXo4Dx4bb8zOwh1jF7zMeAXdk3YU
 E5uJW5m95gLKYqaJtePJMWT6XV1/CfgOihjjtVpI=
Received: by mx.zohomail.com with SMTPS id 173048506404849.696074475269825;
 Fri, 1 Nov 2024 11:17:44 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
 id D824810604B0; Fri, 01 Nov 2024 19:17:40 +0100 (CET)
Date: Fri, 1 Nov 2024 19:17:40 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: bigunclemax@gmail.com
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Wang Jie <dave.wang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 2/3] usb: tcpm: fusb302: add support for set_vbus()
 callback.
Message-ID: <mlcweqrj56o53wluowoz7n6fdn4xofx5gtmh6d2ufkpqq7xq34@7qfgnsw6j4ev>
References: <20241101103501.21432-1-bigunclemax@gmail.com>
 <20241101103501.21432-3-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="woheweqyax6u6fcz"
Content-Disposition: inline
In-Reply-To: <20241101103501.21432-3-bigunclemax@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/230.373.91
X-ZohoMailClient: External
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


--woheweqyax6u6fcz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/3] usb: tcpm: fusb302: add support for set_vbus()
 callback.
MIME-Version: 1.0

Hi,

On Fri, Nov 01, 2024 at 01:34:51PM +0300, bigunclemax@gmail.com wrote:
> From: Maksim Kiselev <bigunclemax@gmail.com>
>=20
> Add support for VBUS supply regulator.
>=20
> When our type-c port acts as a host(SRC), this regulator
> used for control VBUS supply.
>=20
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---
>  drivers/usb/tcpm/fusb302.c | 44 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/tcpm/fusb302.c b/drivers/usb/tcpm/fusb302.c
> index ee283782792..2a258d6429b 100644
> --- a/drivers/usb/tcpm/fusb302.c
> +++ b/drivers/usb/tcpm/fusb302.c
> @@ -10,6 +10,7 @@
>  #include <asm/gpio.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> +#include <power/regulator.h>
>  #include <dm/device_compat.h>
>  #include <usb/tcpm.h>
>  #include "fusb302_reg.h"
> @@ -50,10 +51,13 @@ struct fusb302_chip {
> =20
>  	/* port status */
>  	bool vconn_on;
> +	bool vbus_on;
>  	bool vbus_present;
>  	enum typec_cc_polarity cc_polarity;
>  	enum typec_cc_status cc1;
>  	enum typec_cc_status cc2;
> +
> +	struct udevice *vbus;
>  };
> =20
>  static int fusb302_i2c_write(struct udevice *dev, u8 address, u8 data)
> @@ -506,7 +510,28 @@ done:
> =20
>  static int fusb302_set_vbus(struct udevice *dev, bool on, bool charge)
>  {
> -	return 0;
> +	struct fusb302_chip *chip =3D dev_get_priv(dev);
> +	int ret =3D 0;
> +
> +	if (chip->vbus_on =3D=3D on) {
> +		dev_dbg(dev, "vbus is already %s\n", on ? "On" : "Off");
> +	} else {
> +		if (CONFIG_IS_ENABLED(DM_REGULATOR) && chip->vbus) {

should be enough to check for chip->vbus, since the regulator
device should be NULL when DM_REGULATOR is disabled. If due to
some bug its not NULL regulator_set_enable would fail gracefully
with -ENOSYS, so that somebody can debug the problem.

> +			if (on)
> +				ret =3D regulator_set_enable(chip->vbus, true);
> +			else
> +				ret =3D regulator_set_enable(chip->vbus, false);

regulator_set_enable(chip->vbus, on);

> +			if (ret < 0) {
> +				dev_dbg(dev, "cannot %s vbus regulator, ret=3D%d\n",
> +					on ? "enable" : "disable", ret);

dev_err()?

> +				return ret;
> +			}
> +		}
> +		chip->vbus_on =3D on;
> +		dev_dbg(dev, "vbus :=3D %s\n", on ? "On" : "Off");
> +	}
> +
> +	return ret;

I suggest converting this to

int ret;

if (chip->vbus_on =3D=3D on) {
    dev_dbg(...);
    return 0;
}

=2E.. remaining code without extra indent ...

Otherwise LGTM.

-- Sebastian


>  }
> =20
>  static int fusb302_pd_tx_flush(struct udevice *dev)
> @@ -1293,6 +1318,22 @@ static int fusb302_get_connector_node(struct udevi=
ce *dev, ofnode *connector_nod
>  	return 0;
>  }
> =20
> +static int fusb302_probe(struct udevice *dev)
> +{
> +	struct fusb302_chip *chip =3D dev_get_priv(dev);
> +	int ret;
> +
> +	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
> +		ret =3D device_get_supply_regulator(dev, "vbus-supply", &chip->vbus);
> +		if (ret && ret !=3D -ENOENT) {
> +			dev_err(dev, "Failed to get vbus-supply regulator\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static struct dm_tcpm_ops fusb302_ops =3D {
>  	.get_connector_node =3D fusb302_get_connector_node,
>  	.init =3D fusb302_init,
> @@ -1320,4 +1361,5 @@ U_BOOT_DRIVER(fusb302) =3D {
>  	.of_match =3D fusb302_ids,
>  	.ops =3D &fusb302_ops,
>  	.priv_auto =3D sizeof(struct fusb302_chip),
> +	.probe =3D fusb302_probe,
>  };
> --=20
> 2.45.2
>=20

--woheweqyax6u6fcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmclG0QACgkQ2O7X88g7
+poUeRAAoDuweSDc1TRDaUem5B1sln5aCm+zA1oqqk7fiaxS0kOY1TTlhoQiOMOe
m2Eo2kNamU6w+2ov9bUUg84Ha6nJoCc13JnhYLRlrrMbIoeHDFlxs/SIpiqa6uEJ
B8XqKVyFYGwpp9dUk3oUyjGvO9H94eCOcCVjTrfduRibs3NtGt/EHyFFcpTmiJP2
Zu8F2N4ndewzcxU59M4dbnDP4xz5XUB97F/0EuHnp2ba1e9TtZD0a4kTg12iGqDA
5eMI1Mg9f80EaITeEKKctDkg+aj8Pv+R4LNWZV7NhGeVNPI32rTfy7bjnq6C5R4H
3OZaEoXviEs9dsLNEXsSNA/1q+59cV+lgH8VEEdJXsiq4SGtsNuOQTNH63PLamQ4
g+ORgpuDGkKr4hM47yTGOXtCx4St+gg7xXJ9JphG2vMt6ZOfj9jrOzywSRdG0CSv
Ipbq5URnbwmWZRrJZuWPcAgx2dP9iLB8Nt4fYAP6eMoBt5It5AtHN3ix/vW3Mipg
D9F6W1Hperrl+Mne5XAMbjpx69XePZdH59aUObqCvbaOSL0JZPr36+RTqhqkDKrG
QX/BVrdNfIQj3Ofrt6j+wB5Ok59B2hlq94xyo98qPsPITuoXMiKxPvo5wfooQ4Sd
Kk4wJ6OisHvyGYUStDjxeA+DuGPcxagK1dZssZtiu6jAFmZZCiU=
=jAeI
-----END PGP SIGNATURE-----

--woheweqyax6u6fcz--
