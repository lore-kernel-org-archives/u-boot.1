Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48097C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 20:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0236886B2;
	Mon, 10 Jun 2024 22:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IfJyFNc9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CF55885A5; Mon, 10 Jun 2024 22:04:11 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A17A886A6
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 22:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3cabac56b38so2925822b6e.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 13:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718049846; x=1718654646; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PX7otZoLuaOwSNnRL/XxnmUN5VL7V75zKIC+yK9l9Vk=;
 b=IfJyFNc9U4NxNy8dDuRLAsytjNPWvqNh+pCrnch5J8iictLv/m34UTbQWOMNOeCaMA
 w7Npe5jGIG7J4tpRutYqiFl4G9JXRk0UzNnGlgrG956pJx/nVjeKlIkapnG3Q2Yt71W3
 OAnAOaUlaPwBuneJUiMBx3cy7W1GfK3oFjCWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718049846; x=1718654646;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PX7otZoLuaOwSNnRL/XxnmUN5VL7V75zKIC+yK9l9Vk=;
 b=snDXHCABG50XJPGwE06CHsDQhl77fJo4Z7BjhmTCSSX6sOCh6kq1SDDHDsROZXfhHT
 Bk5H9cARlI/jjW25qONKyWAUDgNRiwiq+Lo0coWbr+wJTEDz3eUxL4TiPuhGXiHhyCHS
 TOcBC9e3BvMNNpziyBvAt0Xy8QDu0yi6UbjHCBsdEwuruy6OAanCnnKltvQgojxgC2Dr
 v3i2LsvRZsupDu9o/z7YGrgbaw6qXrcyKDxJj9YlmOIcH2X7tpBbK8aOl0z/rWbq3HW8
 +XF4CxrfYHJE46f5mcaHNXG44I8EJZlQQ8SgK2EZrlsAfJaV8NBSFZf+a6JtwiNTq5C2
 iJcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtgQZCmFL8AHb9x18bdszEDpSa0rIqAo6SYqvcxRj8oBoHgMNwiG4pjX06qyteP2fGltb3449M4ThQabbm6eZzIdmw8w==
X-Gm-Message-State: AOJu0YyRfeWD54MyryxzdgMoJxJm+iyNyEFahYSSoDnyja2QywRXKwd5
 88rR9zKR2IBvVq3J6xCR+pvjKPhIVLpnyUJYcxvBPIxg7JIQONuvvgLr59mwM5A=
X-Google-Smtp-Source: AGHT+IF9WFX0vq82aF0dDBLoQGhLyhq9fk9YRdWazkRKru6czM2paPtLNSHBX/s4dvXnchmIUtZppw==
X-Received: by 2002:a05:6808:1b2a:b0:3d2:30ce:327c with SMTP id
 5614622812f47-3d230ce3594mr1821488b6e.10.1718049845964; 
 Mon, 10 Jun 2024 13:04:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d20b69f35csm1665134b6e.30.2024.06.10.13.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 13:04:05 -0700 (PDT)
Date: Mon, 10 Jun 2024 14:04:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: hs@denx.de, pro@denx.de, vasileios.amoiridis@cern.ch,
 quentin.schulz@cherry.de, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] drivers: bootcount: Add support for FAT filesystem
Message-ID: <20240610200403.GZ68077@bill-the-cat>
References: <20240610185116.353604-1-vassilisamir@gmail.com>
 <20240610185116.353604-2-vassilisamir@gmail.com>
 <20240610193747.GY68077@bill-the-cat>
 <20240610200325.GA364896@vamoiridPC>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q+kzAgOwJyzeG/EA"
Content-Disposition: inline
In-Reply-To: <20240610200325.GA364896@vamoiridPC>
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


--q+kzAgOwJyzeG/EA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 10:03:25PM +0200, Vasileios Amoiridis wrote:
> On Mon, Jun 10, 2024 at 01:37:47PM -0600, Tom Rini wrote:
> > On Mon, Jun 10, 2024 at 08:51:16PM +0200, Vasileios Amoiridis wrote:
> >=20
> > > Add support to save boot count variable in a file in a FAT filesystem.
> > >=20
> > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> >=20
> > Thanks for doing this.
> >=20
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> >=20
> > Would you be able to do a follow-up that converts doc/README.bootcount
> > to rST as say doc/api/bootcount.rst ?
> >=20
> > --=20
> > Tom
>=20
> Hi Tom,
>=20
> Yes I could do that. I will send a follow-up with the change that you pro=
pose.

Great, thanks!

--=20
Tom

--q+kzAgOwJyzeG/EA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZnXCwACgkQFHw5/5Y0
tywcQQwAhZxEbefee8wRTAdxpfXDVytJlSB3T+6WNSwX5NVs80AOuFEpvwta/cqR
wsNhZRiYEjnEF0JLbv2g2bIq8YaE7ror7WPsCOScgovAKuITt/V3LR4Mc1Z0LzcP
60YYHunGiGeT9VX5hvk89aGfNPaWPqS4kif1mwiWmxalgxZT6LcnvSH2O869P5YD
np5k4pcJTAneVa2RO+fqbRmL8jROybg+fyKivwqYv8giJKp8+9aG56wtv8UYoOw6
5G39bXucperaNuB6QSXTlvtNai5eMgnUAhrjV+h14H7Tvc+wzgb4TGBGddjTeday
22OhH0pbMU4eec4L7+CoTepZJ4H+BPl4Me5ItONfxt3P2wEEq9GqnTjmQ+D+vjNs
Ud7ZBppFUsuudaofDctbJVEHkAryoJkL3o+pz3uTIjwlP/4NaEBjyUl0zuPCdOgq
fFdyTIpD38/Y+07IaTjrPJCSCMauZJkjtuj7BHwqIbt4GdcBaSBC39CrLSkSXI5G
QUIUWcV2
=SvxL
-----END PGP SIGNATURE-----

--q+kzAgOwJyzeG/EA--
