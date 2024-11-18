Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E856DD591AD
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 19:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10E6F88E1C;
	Mon, 18 Nov 2024 20:30:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sfXq71mm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB1F088E5C; Mon, 18 Nov 2024 20:30:15 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8810688DB6
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 20:30:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b152a923a3so243435685a.3
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 11:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731958212; x=1732563012; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gdYndpGoo9aAovtfTFPm82QP9eumH0E1KcABl40N5RE=;
 b=sfXq71mmtXJ+B4QCgwZFx6pHmjtaazr73+D0I7S5P51L1WweHVR1Mkt6d82FP0BgB6
 u3vtarsg+VMUzW7hd2fd6nRE2PNYeC4Rf9miFdlqcL3ns9TRiQFPZMC0cogT3aoJc4Sc
 rLAscRRxW355zR2yIxYvVuq3/jyJSndewxmY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731958212; x=1732563012;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gdYndpGoo9aAovtfTFPm82QP9eumH0E1KcABl40N5RE=;
 b=FcmyLgL1uMr+DQkW8J957YPmtD865g3Mb0gapM0MM51331hZAm5I2QxfJZAcXi1nvU
 hU1ZJyX5DIPF0KVThuQnEJGJYnIFcSS+ROaiHGrGvu5VOyc21eAHQ0LUI5ZnkOMgRZ3+
 vq+5UyYIDGObF/pRwW4pniWQDJ19/8PwVPDjL2uC0EMs3YYyOU8Mlv74jG+JGNJewOMJ
 BPvmDL1kfMdrIQfwqPpHjERI91cPZvTWEhVbYkHq6ySRQ/wutwdVm4Q8oDGTB7fey5YG
 vvJb6Lecb2AZmpl9k2ViYyPC2Rz82YwyxwlgpAeEjr7VScdWfQFwGG5s0hgZc20nPHgK
 82HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7mhbh52v+JmvbkCZhzhGES3m6hqO7CpaZUE/NxLvBj4QYQjFMqye1GnbrOveNNekvE8lr0Os=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1WWX+S2I6Nlw/7ntk+Qj3kzcDbxyHAkhq24SaH7cfP6Yvgz9q
 E8zCHtPgqvHWvm4cWRI+9WIiONIszjvKMivH2lOKc0KI9+7hI/nU7ebnZ9sT6CY=
X-Google-Smtp-Source: AGHT+IHIaLY8GLmw3Jg8sbI9Uenno3TU2vFKjp59T10+mQnnmWR7AB3Av70J/0FoWYGBIObt9anBjA==
X-Received: by 2002:a05:620a:2684:b0:7b1:4a0b:88a with SMTP id
 af79cd13be357-7b3622a564dmr1586166685a.4.1731958212271; 
 Mon, 18 Nov 2024 11:30:12 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b37a896398sm18455785a.83.2024.11.18.11.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 11:30:11 -0800 (PST)
Date: Mon, 18 Nov 2024 13:30:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Sean Anderson <seanga2@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Javier Fernandez Pastrana <javier.pastrana@linutronix.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] boot: extlinux: Fix unaligned buffer for reading
 data from file system
Message-ID: <20241118193008.GS3600562@bill-the-cat>
References: <cover.1730988601.git.namcao@linutronix.de>
 <1eb402380414c2b8f1b25d0c63d894efefce4ab9.1730988601.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CtKbqdqO6rPzbPIi"
Content-Disposition: inline
In-Reply-To: <1eb402380414c2b8f1b25d0c63d894efefce4ab9.1730988601.git.namcao@linutronix.de>
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


--CtKbqdqO6rPzbPIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2024 at 04:01:05PM +0100, Nam Cao wrote:

> extlinux_read_bootflow() allocates a buffer to read from file system
> without any alignment.
>=20
> But for some block devices which transfer data via DMA, ARCH_DMA_MINALIGN
> alignment is required. For example, due to misaligned buffer, the below
> boot failure is observed.
>=20
> =3D> boot
> CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
> CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
> CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
> CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
> ** Booting bootflow 'mmc@2194000.bootdev.part_1' with extlinux
> Ignoring unknown command: =EF=BF=BDD=EF=BF=BD=EF=BF=BD=EF=BF=BDD=EF=BF=BD=
=EF=BF=BD
> Boot failed (err=3D-14)
>=20
> Change the buffer alignment to ARCH_DMA_MINALIGN.
>=20
> Fixes: 31aefaf89a5b ("bootstd: Add an implementation of distro boot")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Tested-by: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>

Applied to u-boot/master, thanks!

--=20
Tom

--CtKbqdqO6rPzbPIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc7lb0ACgkQFHw5/5Y0
tyxnnwv9GhzhL0efrIpp8jSko/EOMsDIunvnb+nWlktFKIcr9vnY/UDkdzYXKueA
ybtMAhQPIxuxaOX3o9Hd/AysIjEUY0t7XD4SBpqsK5M/dZ4j8wq9dCeTHqCvrYqS
KGviimnNHuAGogkPgUHFecrDjUsQB7UT27Aies1iZSnoh5I228b9DfwIc3WU9XGb
Lv+UA20esDuYk0waYfBxZG34B1YM1oYW/+KINvB4AumdTo93C2P5SvdRj4gJmwbP
KkQ96/slRAet3zxeUsIgwtM1Ug0U+RlILCpGuJzYsi7sYGNiF+is6uMQvXPZaLiU
X1XjdqoRfwaSSoMmkfYsGMOMGJvSG3AqHwi/pI9n96ZKJW1fWYy+C7ef+CHZz+T4
3f48NcFTNGr8Gr+WkDH3vKWigKgrhhrhQbru+R9NKAm2BhD1pl1ly9Ku8wMebigk
LP8R0iyJPLjJMfrD/tTIAVroOIAVCD44SYp+spG7FbtgwJ4w6ejkDAD3EZ0AwMQO
sXJKIAdG
=T4hs
-----END PGP SIGNATURE-----

--CtKbqdqO6rPzbPIi--
