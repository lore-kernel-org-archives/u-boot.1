Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6A2C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 18:20:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7882D87797;
	Mon, 27 Nov 2023 19:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="en4sflX0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 098948761B; Mon, 27 Nov 2023 19:20:02 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A613387794
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:19:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5cfa3a1fb58so16813457b3.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 10:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701109198; x=1701713998; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZD2onwePBZ9qL5IBIZNz98KDiYgC5tAQOl27BdaCP4E=;
 b=en4sflX0p46otlbqJVtVFjmW/x4XzxdTNz0E3M0o60nBWzQCEEVrfnq33r8T0oPZSx
 bmEsO2QToLv//Fcb91PbTxaQI9j0jOzUperKzQOU7yGQ27/NXIoPzkCzSoWPwkfHagWx
 Bx+zcaYdKkKp75S4UNuaGKqQLrqK5b2Jg/PJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701109198; x=1701713998;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZD2onwePBZ9qL5IBIZNz98KDiYgC5tAQOl27BdaCP4E=;
 b=fhTqw136lOLLnIGDowTRiqnyyggIT3a10E9PBcwDYYmFpn4o+WP3bt3O0PGoLLhnev
 Y2sHRqqGyxIEW8ekyHVqSzXWkLTcnADsaUQENSSFr91y1QYoZtBn2/36xysaZUhn6dfj
 lzBSbYbtEMocHhukeTAtHsv1tplUEa+R69niL4+QhnWjTy01yRxjx9Jjrybw0s1fofUp
 /u7G75mR3SAu8y5U2ygriubLR4sxpoYw6+I6dWRUZNA0sgEUcUhNLsnMNg/Fd69nuz/b
 s/j+cRt5TKsj/IxA3gnRq0nchjaVz84YNFLQpXPM9wythjipJ+JAtbaM1bNlG7IK0Rgx
 9XDg==
X-Gm-Message-State: AOJu0YwOuXaxkT1LMScsTd0xxPTwtUuWUvyCLQS69PmHcGSaPOm/Y/j/
 9oEutqQKsR6wyl2H795yjERZpLE8J+Jsm/ew/aQEsg==
X-Google-Smtp-Source: AGHT+IHiCquihBZyR1DWNtirZgSmDh2540RwGepaawunz5zfVmbYt/4Cf8Fk9AGN5G2zXjbfcsW5Wg==
X-Received: by 2002:a0d:fc84:0:b0:5cb:e3a9:5e77 with SMTP id
 m126-20020a0dfc84000000b005cbe3a95e77mr13906320ywf.6.1701109198420; 
 Mon, 27 Nov 2023 10:19:58 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 k186-20020a8193c3000000b005b34d8b33ffsm3463126ywg.119.2023.11.27.10.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 10:19:57 -0800 (PST)
Date: Mon, 27 Nov 2023 13:19:55 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 goldsimon@gmx.de
Subject: Re: [PATHv11 17/43] net: sandbox: fix NULL pointer derefences
Message-ID: <20231127181955.GO2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-18-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vbzHFEOm1dVavyKt"
Content-Disposition: inline
In-Reply-To: <20231127125726.3735-18-maxim.uvarov@linaro.org>
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


--vbzHFEOm1dVavyKt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 06:57:00PM +0600, Maxim Uvarov wrote:
> Add additional checks for NULL pointers.
>=20
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  drivers/net/sandbox.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/sandbox.c b/drivers/net/sandbox.c
> index 13022addb6..75d32db3a9 100644
> --- a/drivers/net/sandbox.c
> +++ b/drivers/net/sandbox.c
> @@ -65,6 +65,9 @@ int sandbox_eth_arp_req_to_reply(struct udevice *dev, v=
oid *packet,
>  	struct ethernet_hdr *eth_recv;
>  	struct arp_hdr *arp_recv;
> =20
> +	if (!priv)
> +		return -EAGAIN;
> +
>  	if (ntohs(eth->et_protlen) !=3D PROT_ARP)
>  		return -EAGAIN;

This part seems fine.

> @@ -82,6 +85,8 @@ int sandbox_eth_arp_req_to_reply(struct udevice *dev, v=
oid *packet,
> =20
>  	/* Formulate a fake response */
>  	eth_recv =3D (void *)priv->recv_packet_buffer[priv->recv_packets];
> +	if (!eth_recv)
> +		return -EAGAIN;
>  	memcpy(eth_recv->et_dest, eth->et_src, ARP_HLEN);
>  	memcpy(eth_recv->et_src, priv->fake_host_hwaddr, ARP_HLEN);
>  	eth_recv->et_protlen =3D htons(PROT_ARP);

How do we get to this dereference, and is that not a bug in the caller?

--=20
Tom

--vbzHFEOm1dVavyKt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVk3csACgkQFHw5/5Y0
tyyGOQwAnRnhp4clOjhwc15e17UITEJ26FhvJy/dSnUtjvkVrlH5kVo1d/FaZbI5
D0KcKI8DD1zBsWunQSffEwRIikRFjeWMXiCZbFvpLRuBXIA/l1jnvXZ3bhjOfS5W
S3GvGPA3sV9ryeestTHtD3MiMmIbWBaTYsYsV2bs2qbASmDDUbRDbkefZtLGTAS1
pmemX38HlZyOFujSzTv2IYRGTV241Lg8VYLkyflLRdX+aDweHPQG8kHPXsjw2Adb
uUdFabzuBQIQWvDTVwO75pPPGGj+G4oBc6vGQObyaZF3tHBRrTr6vJRHPPhfJAtP
KJvqGDhnZ01PRbjFA9Jk4iC4STsHd3kx/SVFRYr0s7TKIapD7024sn0a8yyMm3h/
nbzQNu7cSaq9PQ49JZCuMVnK04snJNBFEXwsX76ZrRPkIImKIje936je9pQ+EsYD
DVeOObfVoFA4phGtNQPkQnlrChkFN8RzaUYBG7Yp7lysYa+l0tQBTYqGz7f4TCn7
E33+mp/C
=6Y1H
-----END PGP SIGNATURE-----

--vbzHFEOm1dVavyKt--
