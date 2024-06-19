Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD15AC27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 15:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39B258836D;
	Wed, 19 Jun 2024 17:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Cbnz6ben";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9549388415; Wed, 19 Jun 2024 17:22:14 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7717E87F19
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 17:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6f361af4cb6so2347596a34.3
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 08:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718810531; x=1719415331; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SBYxD23YVlx9ZSIs6RZoe0LXlZ2Aj0xCnCzIg1E6Ypg=;
 b=Cbnz6beny4NHz23l5RUqHFENCvRjGaMes4yrGxaG0xSGbtnmlRk4cJibJiMhBkWFaA
 Vcf4qepHGcsK/Iu2fDBJVedlowQyOH95p9KsZHll2qODFB/o6JAA+Hl31mK2VA+l+rSR
 h/YGq+SkMZ5SaVxoF4mKNsV1smo9NNO6FYQTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718810531; x=1719415331;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SBYxD23YVlx9ZSIs6RZoe0LXlZ2Aj0xCnCzIg1E6Ypg=;
 b=MCoFwevYo6BzlGODxM7tp9GFDlW4r/2zwuArEoyUnboVmT98GbNFYPSXdJDy0XDJCJ
 J6MrjjONe8qaGerTMvhAfWahyIO4RdGFWSbZ/4SC1Sq0IoBbv6+m0E6bSxE6h+uXIMPV
 1xFaj8aNrIOWozNnVoJbBAIK3529kiB70jXQDHb8BIwNfUWM24R02SBrQpIG0ruCFHzc
 Ya8EWRJ7OIKVCfF0Bu1YI63Gv92B4+uuiIhSa/Eo6Nj1ucd7RgRYF/46CRnYICK0cZZR
 rqmMe0yHtttYteTUJNufWBWHlFX2ggP9BKfAdZ2FmkgbKsgBVb04MfJdLyGmNOYz8eh7
 Mz0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYLJGMcY92TGzU4CT9Y2I2JuNsShyB4Ky0a8U9Tq1/okJmg72gx7V/SzcG8r78EVLoGebitSdf/L/OzlYBx0GzL5wpOg==
X-Gm-Message-State: AOJu0Yxk7ClVSCBfxKWTN61n7LbJLSkQhpgVqfVMXkqCnPuzPHbQAq4f
 XWJEpOp9jY3eHotJhiNxM8f6pTACZ6wckAhu9VeSFfXcrZOHYav6UJ0J6cbI0WBjUiZ9OsM0lCA
 Eo3yDBQ==
X-Google-Smtp-Source: AGHT+IGcxmnmMC1ezT584qxWe1yb/dmT1yKe0mh6NSHhzTr7o7+DJ3/3OHtk/M5ZEKWyVXYUKjYO0w==
X-Received: by 2002:a9d:67c8:0:b0:6f9:cf25:d6fe with SMTP id
 46e09a7af769-70076c0c109mr3082334a34.24.1718810531282; 
 Wed, 19 Jun 2024 08:22:11 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fb5afa9f62sm2218057a34.3.2024.06.19.08.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 08:22:10 -0700 (PDT)
Date: Wed, 19 Jun 2024 09:22:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Klaus Goger <klaus.goger@cherry.de>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] rockchip: puma-rk3399: increase Ethernet PHY timeout to
 30s
Message-ID: <20240619152208.GC68077@bill-the-cat>
References: <20240619-puma-eth-timeout-v1-1-db5c17153f82@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xTUfhyU67OMe3JwS"
Content-Disposition: inline
In-Reply-To: <20240619-puma-eth-timeout-v1-1-db5c17153f82@cherry.de>
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


--xTUfhyU67OMe3JwS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 11:55:52AM +0200, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> On Puma v2.1 with a KSZ9031, the Ethernet PHY often doesn't detect the
> link in the 4-second default timeout.
>=20
> After some boot-loop test for about a thousand boots, 70% were below
> 10s, 90% below 15s and 100% below 30s. Let's play it safe and make it
> 30s so that hopefully all links that should be detected are.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  include/configs/puma_rk3399.h | 3 +++
>  1 file changed, 3 insertions(+)

Please rebase on -next where this is now in Kconfig.

--=20
Tom

--xTUfhyU67OMe3JwS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZy96AACgkQFHw5/5Y0
tywtpQv/WDydYyMTe7UKZEFEr96rE0qC9aOPS7E+8kg+coIwQQuX7p8/QyEA5IvS
AmUoZ9iSnfyuS5cv0dWPjrd4FJrK0yAEaYFVC2WMadj2TN4gtVzD4DtFg4H/2wa+
ign+24sSvwp41uayIksEvpQacvHysmMLPOTsKRDbu5FMtHUaIKFjossUnVOirymf
FCqxyfHuqKj5nsmNJjlAIe+dLG7EIGWRtLFngd/Yo1wIWgJvEGYeDzfrkaUwofFJ
ChXvYS0IcLmw7Kket6gcAa4Z9c2VniTjZ/N9pDVbIpkkYC5nunaV989ZfVCdz9ua
O6pGH33OsBgY3G8O1iNr3cyWpiGC7aw87NfxFDUJ+h0EuRQcHBgbVr3doxDFm1PB
8kKq9aInX7QTwV6+kSlzKbT53Oxd6RNFDr59RyvEBR3/hFQs8kT35A8+ieIqcylW
kROZGWQM3L+veW5IymItCm7lF6qsuhTA0blZJ5mvGv5SSiaSbozP3pyNBKy4PB8H
CFqgehHB
=p8V7
-----END PGP SIGNATURE-----

--xTUfhyU67OMe3JwS--
