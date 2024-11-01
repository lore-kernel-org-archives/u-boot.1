Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF5CE6F068
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 18:32:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89A508902F;
	Fri,  1 Nov 2024 19:31:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="hKyR4yVK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D7278902F; Fri,  1 Nov 2024 19:31:58 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0511288EC6
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 19:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730485911; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gX18FUM9/or/VQluAy7s/YAlu8H8O/xuxRNG43ysC+70VIqtqjxQfcMtd2aZ8w1/S8knfZHuT2RYiebPVAql0NDAkjeti3MTMyJzCW7xPwiiv2dXinoYDOj+RKD688cb+NCOc5wlDYUwlNnMQc69LuQqRl/xcKs8KSDPV1ds6t8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1730485911;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=f4c5e5wLxOrWavapYQR5I8JniU9jeOt98/PEOsB0AnQ=; 
 b=OAlaOi5+i17FrDVWR/Dg6cvvFUdzg31cgGxyx6hbTncBy+f7qShPSETy7pMJkVlJLb06IS/YkjfJ9tijgp3Kd6qZfdvs402jX5rucGmDcgXcp8rV0bZlYo1w7/hBAMdEUxiOvpRQf2WCS1HFxOvySqW+XlF9SSYHcv8fA9C1gM4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730485911; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=f4c5e5wLxOrWavapYQR5I8JniU9jeOt98/PEOsB0AnQ=;
 b=hKyR4yVKa01B0jKKj4ufOfdy27Z0w9GQYYL2aKsbtjCU8OOR4K8Q6+psLlcJ5C+X
 XDXuoRxU/M+bgI+gXhh6H54YtMAlPgyGPMEpLOkZN1b/TFSCqqb8wTmzq43K7v62c+w
 7/TpAYNAmUhZsGTkT9OwLhhjTQf4i7nN4ibXH3nk=
Received: by mx.zohomail.com with SMTPS id 1730485908899129.13041906750675;
 Fri, 1 Nov 2024 11:31:48 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
 id D64B210604B0; Fri, 01 Nov 2024 19:31:45 +0100 (CET)
Date: Fri, 1 Nov 2024 19:31:45 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: bigunclemax@gmail.com
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Wang Jie <dave.wang@rock-chips.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 3/3] usb: tcpm: fix toggling in host (SRC) mode
Message-ID: <r2umutw5zvze6xyvxe43bcd3dly6ckhvd3anjp3ucbmymnla26@6phsgsuabhwq>
References: <20241101103501.21432-1-bigunclemax@gmail.com>
 <20241101103501.21432-4-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4w2t52l3nl5lx54k"
Content-Disposition: inline
In-Reply-To: <20241101103501.21432-4-bigunclemax@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/230.385.11
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


--4w2t52l3nl5lx54k
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 3/3] usb: tcpm: fix toggling in host (SRC) mode
MIME-Version: 1.0

Hi,

On Fri, Nov 01, 2024 at 01:34:52PM +0300, bigunclemax@gmail.com wrote:
> From: Maksim Kiselev <bigunclemax@gmail.com>
>=20
> PU\PD resistors on CC lines must be configured before running the TCPM
> state machine.
>=20
> Also, when the Type-C port acts as a host (SRC), the VBUS sould be enabled
> only after the toggling has been completed. And we have to wait for
> the corresponding IRQ to finish the toggling process. But this doesn't
> happen because we exit from tcpm_poll_event() if VBUS !=3D OK.
>=20
> So, Let's check for VBUS state only when the port acts as a host (SRC)
> to solve this problem.
>=20
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---

I will look into this patch next week and give it a try on the Rock
5B. As a first feedback the commit message seems to confuse data and
power roles. SRC (source) and SNK (sink) are for the power direction
while "host" and "device" are used for the data direction. With
USB-PD these are independent from each other. You seem to have the
old USB model in mind where e.g. a USB keyboard ("device") gets
power from the PC ("host"). But USB-PD allows setups like a USB-C
hub ("device") having its own power-supply and providing a laptop
("host") with power.

Greetings,

-- Sebastian

>  drivers/usb/tcpm/tcpm.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
> index 0aee57cb2f4..c9f8dbdc795 100644
> --- a/drivers/usb/tcpm/tcpm.c
> +++ b/drivers/usb/tcpm/tcpm.c
> @@ -2122,6 +2122,12 @@ static void tcpm_init(struct udevice *dev)
>  	else
>  		port->vbus_vsafe0v =3D true;
> =20
> +	if (port->self_powered)
> +		tcpm_set_cc(dev, TYPEC_CC_OPEN);
> +	else
> +		tcpm_set_cc(dev, tcpm_default_state(port) =3D=3D SNK_UNATTACHED ?
> +				TYPEC_CC_RD : tcpm_rp_cc(port));
> +
>  	tcpm_set_state(dev, tcpm_default_state(port), 0);
> =20
>  	if (drvops->get_cc(dev, &cc1, &cc2) =3D=3D 0)
> @@ -2234,7 +2240,7 @@ static void tcpm_poll_event(struct udevice *dev)
>  	const struct dm_tcpm_ops *drvops =3D dev_get_driver_ops(dev);
>  	struct tcpm_port *port =3D dev_get_uclass_plat(dev);
> =20
> -	if (!drvops->get_vbus(dev))
> +	if (!drvops->get_vbus(dev) && (tcpm_default_state(port) =3D=3D SNK_UNAT=
TACHED))
>  		return;
> =20
>  	while (port->poll_event_cnt < TCPM_POLL_EVENT_TIME_OUT) {
> --=20
> 2.45.2
>=20

--4w2t52l3nl5lx54k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmclHocACgkQ2O7X88g7
+ppkHA//U7HX+giEIEbNEeSV/LXB56llFr3XM5RlDDr3VCcDrf+uoPWjV0rMlKX6
Y5XFaEpbQNckA6yIK5wNDBSqrzS9Xgi1wDp1JIh/u8Z/QMirpa+I0u8kFM/xWI0l
3bu7i8dV0W7U9l8EImvydOFwOOQQjQ8qp1leSuShXwJTVsYw31GlXk/RNODJoCd4
fwyQhktQDh/WPfy1TVtT0pUuvU/HKWleR+Xw9WnjvBf5ePIlAmfvZ3Lkk0mF2nPv
vyK1DoYp3Ss78QdIAVyWR+ZJts1yMqxpOA4ZBCiA+aPeEhHH9e56KGzF30kDI0tN
q1bCOk1xp6U8/S4uZK9ZnzrxCCKh8W1+RbeBR1q4kupNeurK1qAdakelhBsPNaso
avRf1k93BXAqDsDFeQApj/v2aIeMEgERz11ZgKcUuiuemBY+z+7ODBOEa5ucfLKY
mJp2zaDkibGc48bvSDDWH6uKeZCjNLS623ZKcnJMp7mB4PswaIpZ7czlzzg2FZvg
4OgeMUGymvUYaBSkKUHnOa8OIBNau+mxPpw93ncT61exoJlTBqjFVzHCQT/3SsNa
ti0yz5OfEOQfM8xsVDWTyMpzbxV5SvJnjtsR32rFiJw6BkwAEJ7pLmL/VefKRJlj
/fyPj9usOIs6Yhhp01vteNdOnb9EUyEVZhkX0s/Vwh3WwJpFxmM=
=b34w
-----END PGP SIGNATURE-----

--4w2t52l3nl5lx54k--
