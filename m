Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DF3CD4F54
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 22:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 562DE84704;
	Sat, 30 May 2026 00:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o/1S1j0t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4764D847C4; Sat, 30 May 2026 00:52:56 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A737846E6
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 00:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-69d60694c9bso5163762eaf.2
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 15:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780095173; x=1780699973; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bp8knvQ30/Lz/P0cz5J/Iw6+ejTFIiTAp5Rnypcgu2g=;
 b=o/1S1j0tnCYm45Ot9mar3ponIOclJewapusgLKiMx3zrLl51A7yx1ZFxrYZoxqV3gq
 tWnGqNIt6h/WiuOe1WyBCbgL/cv15472ReJyQgZXOjUCVOgYmLJV1G4UwA3sImv8jL7s
 52soolzUNqNuhG8BEywCuFx06aA6lLDcOib6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780095173; x=1780699973;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bp8knvQ30/Lz/P0cz5J/Iw6+ejTFIiTAp5Rnypcgu2g=;
 b=GgFas+rroWBFkjQyJDXEfQA8XQe/u12ou79SO9/y8tbwmxBsE8iMUA3bKglGymYFBf
 ATATNqRD6g+D0gdfnK9CGeVN3AoG36sKlaqRt6jnZaLQnV+VWxLTOs6x6rUj2vnaNB3Q
 Yvf6JxjsBNrKaJlRUI6AKyq/egdpl4JqNZummThwodbWV5Z1UUuB4pKpnzd/e9qG+GLC
 XsIS0jUOQO27Gd80vEk/pYodt5GgdqSEHMOc9w4Y4aQ+/OYGGcOC1JifoSirBVrjrTN6
 pkF13HwHiNxQHXJzxt/AxrWO28eqGPJw36c2VLVgdku2MWtGg5iXyOXbQwpCd0ZcAzsc
 EZIQ==
X-Gm-Message-State: AOJu0YzfoGvKp/Vtn9H8ZAnrdYxWPR3G/MbUXPx8UuDIl5ELLoCg7UoO
 P/9ID4tSisxN+vTFBt4yMjCYsjVQRqygS7NmIXUHuZiyGSBS7cxTFBrMgncqJsoe62DGWRN2dE8
 P59LgV/k=
X-Gm-Gg: Acq92OEmh49KLrsnDccacmiMgNLOZjW5ZdSayBcECjmnumFdyyH1sHEIeButY0VYjde
 pat7mP3qqIFd/JtZVB1NYHlZbCU7oyfWHdBEaln+8CyMsAO96M/l3xPAD/EFXFIA1tYTssFDA0J
 u9v3IVrpRdltbknSPAFjdXBxk/s9ZeqDeMf/KGOchoG0+DtS63YtNosYQwASpJMAOnM04INMmY+
 /WSl3ZUvHSZ+UvazLhQY30eNrJu8Y36GDg6rZXrDuhU6Qyv6iFCVR/QVjIUohhzSW4qkVAROUi9
 tftCLzWQEL/tYMfEDiGsl6sO56BUc+g5rWBebOEEPUkZruyO5AetFdORT2nb01XbuWHwN5C4/yz
 //7KkEmY7Q/txkTHDWUf/+IiY1BlOBYU2UD6Abnb/W05gRrXV8YnX5NVadyTaZy0+t+JQNE944G
 d1fGmhT9YciiwUtM6OIXR25zCyGMbNVQLOmDT7ZXvwzdbvrDpk32Ex+yo2uejeYa/Cuf/3EOAty
 8Vh/WkI7PLV/X5ee+Pt9ZXRyQFm91pbMnZhJ2Jve1aGDZXPJ6j2h0HJ
X-Received: by 2002:a05:6820:201c:b0:69d:cfb6:4f4a with SMTP id
 006d021491bc7-69e102ee286mr733307eaf.15.1780095172869; 
 Fri, 29 May 2026 15:52:52 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43c94081a1csm2088885fac.15.2026.05.29.15.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 15:52:52 -0700 (PDT)
Date: Fri, 29 May 2026 16:52:50 -0600
From: Tom Rini <trini@konsulko.com>
To: daniel.nehrkorn@esd.eu
Cc: u-boot@lists.denx.de, Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/1] Revert: "cmd: eeprom: Do not rewrite EEPROM I2C bus
 with DM I2C enabled"
Message-ID: <20260529225250.GE627328@bill-the-cat>
References: <20260526060041.3898125-1-daniel.nehrkorn@esd.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GU05Mlb9EwIMbbYz"
Content-Disposition: inline
In-Reply-To: <20260526060041.3898125-1-daniel.nehrkorn@esd.eu>
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


--GU05Mlb9EwIMbbYz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 08:00:41AM +0200, daniel.nehrkorn@esd.eu wrote:

> From: Daniel Nehrkorn <daniel.nehrkorn@esd.eu>
>=20
> We need the EEPROM bus configuration, if we have the env located in EEPRO=
M.
> Since there is no eeprom_execute_command() anymore, we have to configure
> it implicitly.
>=20
> This reverts commit e3c2042ae7d188e00e48d984e373a2de505d8b77.
>=20
> Signed-off-by: Daniel Nehrkorn <daniel.nehrkorn@esd.eu>
> ---
>  cmd/eeprom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/cmd/eeprom.c b/cmd/eeprom.c
> index cf89cfce3e4..ac7ed6f58bd 100644
> --- a/cmd/eeprom.c
> +++ b/cmd/eeprom.c
> @@ -151,7 +151,7 @@ static int eeprom_rw(unsigned dev_addr, unsigned offs=
et, uchar *buffer,
>  	int rcode =3D 0;
>  	uchar addr[3];
> =20
> -#if !CONFIG_IS_ENABLED(DM_I2C) && defined(CONFIG_SYS_I2C_EEPROM_BUS)
> +#if defined(CONFIG_SYS_I2C_EEPROM_BUS)
>  	eeprom_init(CONFIG_SYS_I2C_EEPROM_BUS);
>  #endif
> =20

So, this is reverting a 4 year old commit. You have a platform with
ENV_IS_IN_EEPROM which is admittedly not often tested. Perhaps we should
be calling eeprom_init in env/eeprom.c instead? Thanks!

--=20
Tom

--GU05Mlb9EwIMbbYz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahoYvwAKCRAr4qD1Cr/k
CqH4AP9EjnGi7Y04ctrQUVSNaMqC2xSLg4FIxV7GWK79n+8tKAEArpM1/UL7+Ja3
gJKWUCB76d8ipuf8liG/rgN/NfEb4Q4=
=qW9W
-----END PGP SIGNATURE-----

--GU05Mlb9EwIMbbYz--
