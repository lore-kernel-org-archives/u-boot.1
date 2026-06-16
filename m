Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE6FCD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 14:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBFEA848A2;
	Tue, 16 Jun 2026 16:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Kl4CUE84";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85259848A6; Tue, 16 Jun 2026 16:54:37 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F71084869
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 16:54:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-48650c78e09so1614719b6e.2
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781621674; x=1782226474; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JWyHtFFkdF//Y8g2G/cQtfu0Q3uIHo4g/jGZumWI59U=;
 b=Kl4CUE84D35AaoJ0IcVKP0HITUEAp7KSHkCENEG2tv9JcYf4bfI/Ofrxz7+GV6mAwV
 8545ZzDp2J0ZvFbvcCnI0xcrzBRkULtjh6KKadJo4YT1oBpI5ybB1Z1jy0jh37CoEX1i
 ZrOl8QdeLCJ7thnrEjwyutQ99j3wsONy8LHNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781621674; x=1782226474;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JWyHtFFkdF//Y8g2G/cQtfu0Q3uIHo4g/jGZumWI59U=;
 b=Tr685hBv+hIfQvWKxFLivZKT2Dpfd1d+WLyePr4YNJXN7bTLn37Q2x2ZxnywcoXrse
 0oIICh5GkuOFbYq7xotLVDgyImoAV8WmfcLma/2P8waQ1JgB7pIIFa78xiatKAJIC6Ph
 ZJ1RFmxpD47JMeOc52gpFl/QP8M4MVKTN1j7LmhHWdJtdV7TQahmP0amHOKlAkXAC4jb
 /p+78xnlUPHWj1Yr6lBGIbA7MIcKMfrTtoWV5tihL9fGPLEtgdug1ppl+rxS6siH+k3/
 I01ZM/HwZ/rFIYCCQ8SXYJldpBM43Ljx0pIzQpkE8wkVhSulRrwNnhqwbVyh3gj7dI2R
 cbZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+IqydlA+MDkASDYaVQK4SrotKywjIyGpkHfn0/7F4VDeq2Y2aGj2tmDbUMuJYOVZAEYuEnKQg=@lists.denx.de
X-Gm-Message-State: AOJu0YwhYFcGRy8VYy1u/3E9XXjQD3xmg6B+e7VUc3Yw5wD3HSAz6E0M
 qkg9rtiot1H3V9bz2aMyQr3og3SStMlxi0zj/BfRKWagPDJHtMHWjCdO9vARFVlhiWk=
X-Gm-Gg: Acq92OE7k+Fk49hHB5e1TclwXPcNE8aRDaFK9B+ImcJWBgFGeZbfmxkjApsgePXAsI3
 V+Vpjdo+O7CiU31ZWaQ5jiqMdqYWd/Xcer1nlJC/lYffzZVjhnL5rnEWMsEpHfhHZ7kO6OBjd2c
 rq5H6et/+dJW9oCwPNKgFBbE8nlfBscgOPWrIS5kyjv+mRrQcwnRn2q22sRhQ7bOy9deNRH882r
 hf+qLWpA/7sGaaWEAGVeMliq6/lnkHf3nr/vvxOi6KGowtFydA8guFVWrMOjbqLM7MuCE6Wx4EJ
 /UxWQyijRAHBQ1U9AOgRIEF5OUsQEZUULfCTxsNd+Df2CLqixPVnDjkVGj965laja8vZQ4VZAwv
 YtDMpfDqsBcMgvT/m92Ess86GuX1PYX4XU0ooiAKbQ82sJQS7kN/pF1/YOuqaI73s5r7OVcu/x1
 q1lXV5NLTempuvFM/ZEPP0Nlz6JVeyYybI4KL4QxuAMgcWQIxYUH798MlqdsAf+qOLK4I9vu2tk
 +MimNc9YpQthMiCk07y7RuCnldG2GNa+G4NNx2vq0HuIk9M7xI=
X-Received: by 2002:a05:6808:190d:b0:467:2a6e:adb6 with SMTP id
 5614622812f47-48942861330mr14785b6e.8.1781621673851; 
 Tue, 16 Jun 2026 07:54:33 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4875df83095sm4657221b6e.10.2026.06.16.07.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:54:33 -0700 (PDT)
Date: Tue, 16 Jun 2026 08:54:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH RESEND v3] net: airoha_eth: fix mt7531 mdio related
 initialization bug
Message-ID: <20260616145431.GI382693@bill-the-cat>
References: <20260616053845.2624481-1-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E6iEar463ST36acn"
Content-Disposition: inline
In-Reply-To: <20260616053845.2624481-1-mikhail.kshevetskiy@iopsys.eu>
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


--E6iEar463ST36acn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 08:38:45AM +0300, Mikhail Kshevetskiy wrote:
> Private data isn't ready during bind time. The call of dev_get_priv()
> function will return NULL. Thus we can't save mdio device pointer and
> use it later during probe.
>=20
> To solve an issue, we will move mt7531 mdio device binding to the probing
> function of 'airoha-eth' driver.
>=20
> All GDM ports (except of GDM1) are connected directly to their PHYs, so
> corresponding mdio bus will be automatically probed during PHY setup.
>=20
> GDM1 ports differ from other GDM ports. It connected to the airoha switch
> device. The mt7531 mdio bus is used to manage link state of airoha switch
> device ports (LAN ports 1-4 corresponds to PHYs 0x09-0x0C). Therefore,
> manual probing of mt7531 mdio bus is required to be able set/query states
> of corresponding LAN ports.
>=20
> Fixes: 96d9e7c46425 ("net: airoha: use mt7531 mdio for GDM1")
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

This is fixing something introduced for the upcoming release, Jerome do
you want to take it (or have feedback on it?) or should I? Thanks!

> ---
> Changes v2:
>  * small refactoring
>=20
> Changes v3:
>  * Move mt7531 mdio bus initialization function before it's first usage.
>  * Probe mt7531 mdio bus for GDM1 port, but not for other GDM port.
>  * Add an explanation why mt7531 mdio bus must be probed for GDM1 only
> ---
>  drivers/net/airoha_eth.c | 78 ++++++++++++++++++++++++----------------
>  1 file changed, 48 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
> index 84ee9b2ad76..e5d39b95cc5 100644
> --- a/drivers/net/airoha_eth.c
> +++ b/drivers/net/airoha_eth.c
> @@ -845,11 +845,45 @@ static int airoha_alloc_gdm_port(struct udevice *de=
v, ofnode node)
>  					    (ulong)eth, node, &gdm_dev);
>  }
> =20
> +static struct udevice *airoha_switch_mdio_init(struct udevice *dev)
> +{
> +	struct airoha_eth_soc_data *data =3D (void *)dev_get_driver_data(dev);
> +	ofnode switch_node, mdio_node;
> +	struct udevice *mdio_dev;
> +	int ret;
> +
> +	if (!CONFIG_IS_ENABLED(MDIO_MT7531_MMIO))
> +		return NULL;
> +
> +	switch_node =3D ofnode_by_compatible(ofnode_null(),
> +					   data->switch_compatible);
> +	if (!ofnode_valid(switch_node)) {
> +		debug("Warning: missing airoha switch node\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	mdio_node =3D ofnode_find_subnode(switch_node, "mdio");
> +	if (!ofnode_valid(mdio_node)) {
> +		debug("Warning: missing airoha switch mdio subnode\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	ret =3D device_bind_driver_to_node(dev, "mt7531-mdio-mmio", "mt7531-mdi=
o",
> +					 mdio_node, &mdio_dev);
> +	if (ret) {
> +		debug("Warning: failed to bind airoha switch mdio\n");
> +		return ERR_PTR(ret);
> +	}
> +
> +	return mdio_dev;
> +}
> +
>  static int airoha_eth_probe(struct udevice *dev)
>  {
>  	struct airoha_eth_soc_data *data =3D (void *)dev_get_driver_data(dev);
>  	struct airoha_eth *eth =3D dev_get_priv(dev);
>  	struct regmap *scu_regmap;
> +	struct udevice *mdio_dev;
>  	ofnode node;
>  	int i, ret;
> =20
> @@ -908,10 +942,10 @@ static int airoha_eth_probe(struct udevice *dev)
>  	if (ret)
>  		return ret;
> =20
> -	if (eth->switch_mdio_dev) {
> -		if (!device_probe(eth->switch_mdio_dev))
> -			debug("Warning: failed to probe airoha switch mdio\n");
> -	}
> +	/* Airoha switch mdio PHYs maybe used by several GDM devices */
> +	mdio_dev =3D airoha_switch_mdio_init(dev);
> +	if (!IS_ERR_OR_NULL(mdio_dev))
> +		eth->switch_mdio_dev =3D mdio_dev;
> =20
>  	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
>  		if (!ofnode_device_is_compatible(node, "airoha,eth-mac"))
> @@ -957,6 +991,16 @@ static int airoha_eth_port_probe(struct udevice *dev)
>  #else
>  		return -EINVAL;
>  #endif
> +	} else {
> +		/*
> +		 * GDM1 device connected to airoha switch. Probe airoha switch
> +		 * mdio to be able set/query states of corresponding LAN ports.
> +		 */
> +		ret =3D device_probe(eth->switch_mdio_dev);
> +		if (ret) {
> +			debug("Warning: failed to probe airoha switch mdio\n");
> +			eth->switch_mdio_dev =3D NULL;
> +		}
>  	}
> =20
>  	return 0;
> @@ -1202,38 +1246,12 @@ static int arht_eth_write_hwaddr(struct udevice *=
dev)
> =20
>  static int airoha_eth_bind(struct udevice *dev)
>  {
> -	struct airoha_eth_soc_data *data =3D (void *)dev_get_driver_data(dev);
> -	struct airoha_eth *eth =3D dev_get_priv(dev);
> -	ofnode switch_node, mdio_node;
> -	int ret;
> -
>  	/*
>  	 * Force Probe as we set the Main ETH driver as misc
>  	 * to register multiple eth port for each GDM
>  	 */
>  	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
> =20
> -	if (!CONFIG_IS_ENABLED(MDIO_MT7531_MMIO))
> -		return 0;
> -
> -	switch_node =3D ofnode_by_compatible(ofnode_null(),
> -					   data->switch_compatible);
> -	if (!ofnode_valid(switch_node)) {
> -		debug("Warning: missing switch node\n");
> -		return 0;
> -	}
> -
> -	mdio_node =3D ofnode_find_subnode(switch_node, "mdio");
> -	if (!ofnode_valid(mdio_node)) {
> -		debug("Warning: missing mdio node\n");
> -		return 0;
> -	}
> -
> -	ret =3D device_bind_driver_to_node(dev, "mt7531-mdio-mmio", "mt7531-mdi=
o",
> -					 mdio_node, &eth->switch_mdio_dev);
> -	if (ret)
> -		debug("Warning: failed to bind mdio controller\n");
> -
>  	return 0;
>  }
> =20
> --=20
> 2.53.0
>=20

--=20
Tom

--E6iEar463ST36acn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajFjowAKCRAr4qD1Cr/k
CnssAP0RegQn8G+/zfLDCZZGeuo2gbJjkBIneohEeE5AgqOtVwEApO18pf8RfO/G
Lv9QHSabN9Nt9bHWrtv7NR0uwPXVFQk=
=AX3O
-----END PGP SIGNATURE-----

--E6iEar463ST36acn--
