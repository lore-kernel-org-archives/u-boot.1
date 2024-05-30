Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E14C25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 13:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB11E88709;
	Thu, 30 May 2024 15:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X8JCZ/Lq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E726988706; Thu, 30 May 2024 15:00:13 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C448886F0
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 15:00:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6ab9d4061fbso3904566d6.2
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717074010; x=1717678810; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rbzc0qdBwaN4/2yBjaLp61BLho73yyaWc+mTDsJ/1SU=;
 b=X8JCZ/LqSWdFrH33FK3kESYvWErqtfKcZVArBw0xwL0oFlgaEGBDl49qF0ufelAfTW
 tdG0Gsw4ZnSLxhbDtPuq14DjT3HHNh6anTwKiNoEqPSLTaG8NVzZIfsd/n/o9S014RD0
 Bx4CowAClopbC+sRkMvMZnQJOYUXBe9/8pHjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717074010; x=1717678810;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbzc0qdBwaN4/2yBjaLp61BLho73yyaWc+mTDsJ/1SU=;
 b=oDsV0QZesXiuREBsxtKZiblw5Qj2bBgmYM7Wt02Fw/nN3cdu35gPjHsswsS5RAWYgd
 K6HQi8UY0NfpG3xDKvGBFsRW5dmIswUs0eVLS5KV/Vw0IvaJX92khwizY3sUEyUfQbbp
 6QKyGSHXsnysDIbaAnevgu4PdNEbzSAoocQv3Pei/05KDLXUAO8l57pZprriEdcrhKQZ
 MIdcQywYt/Jtujms2yqYnlzp4S88Yn7dAo8Af4WGec2Hj77Em5oCalcur7Xqfq4ewEkW
 E2ffAjPFFKnJs+iFZWF71dV/Fs93RhW3XfPN6kJcDya83OMYH3KrHu2sh5mXLrVhq+BM
 tBfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeKgcR93JWTIbN7bbloqlXD8zocOLNb4p2d0YEWv/smrktTMFopNTng09DQd831u6bezs0L55CdNdK8eR/wXIl9XxbEw==
X-Gm-Message-State: AOJu0YzM49dm6ciNKxTIkr6aPNAC233b+rsSdKTrAKZriwZn7hkv+Vkr
 GeQQC6Kg1DNj6tuESIiYqtpAV80zYXjmPA5pcEe+YBTBGGXDiDffIF2/XePdPCY=
X-Google-Smtp-Source: AGHT+IHjv7NfEAZJuTLi9KnyVI4kfJhrJyESr/fycxfiPCsUu/JK8uekcJSdB1EyPuqB5DwhveRCpA==
X-Received: by 2002:a05:6214:2f07:b0:6ad:6cd7:72c6 with SMTP id
 6a1803df08f44-6ae0cb59d2bmr26006246d6.15.1717074008370; 
 Thu, 30 May 2024 06:00:08 -0700 (PDT)
Received: from bill-the-cat ([189.177.150.58])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ae2f182939sm1337126d6.2.2024.05.30.06.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 06:00:07 -0700 (PDT)
Date: Thu, 30 May 2024 07:00:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Heiko Stuebner <heiko.stuebner@cherry.de>,
 Klaus Goger <klaus.goger@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Subject: Re: [PATCH 2/3] migrate Theobroma Systems mail addresses to CHERRY
 Embedded Solutions
Message-ID: <20240530130002.GK3714513@bill-the-cat>
References: <20240524-tsd-to-cherry-v1-0-3002bed55f19@cherry.de>
 <20240524-tsd-to-cherry-v1-2-3002bed55f19@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mcLs7zOGhlacwikA"
Content-Disposition: inline
In-Reply-To: <20240524-tsd-to-cherry-v1-2-3002bed55f19@cherry.de>
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


--mcLs7zOGhlacwikA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 01:46:36PM +0200, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> See
> https://embedded.cherry.de/theobroma-systems-is-now-officially-part-of-ch=
erry-se/
>=20
> While the mail addresses on the theobroma-systems.com domain should be
> redirect to cherry.de, let's anticipate IT hiccups and avoid important
> mails not reaching us by swapping the domain name wherever appropriate
> for the newer one.
>=20
> Christoph Mueller isn't working at ~Theobroma~ CHERRY Embedded Solutions
> anymore, but I don't know his new mail address so mails destined to him
> will keep bouncing.
>=20
> Cc: Heiko Stuebner <heiko.stuebner@cherry.de> <heiko.stuebner@theobroma-s=
ystems.com>
> Cc: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
> Cc: Klaus Goger <klaus.goger@cherry.de>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Applied to u-boot/master, thanks!

--=20
Tom

--mcLs7zOGhlacwikA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZYeFIACgkQFHw5/5Y0
tywRkAv+LRrQhzb/tomCjd3XbATE0ygp+12j0K7wzhd7+H9VgSSlMagRsBkCNfJN
XYYhpGaY/UhLBOylAQd1H/z45rpg7UJohSEGJuQPOM2ktD2d3IAly3RKqm0TUdAY
H/nA7CmLGCpavm/OUVgJABUek8bZniRhX8OCAj9hHm0b7U54dQuluTijminyj/8Q
FsyKJIxxylV/80RfoiD1B01FmaAY3tKyHgdLQVDs4mZ88AuP2/92oLkg3MstDRLo
9nsI9fTARqLifajQEGGRMKp11pnsH6nXjhdR6B3QVe0awoeUFaQEXYuL3enh56Wl
mGUk1zgOUQ2tv5SIKOzI3XUpiPEMMQ/O2mhWKE6C8y6dRP/DqaWOffDfgizKAb+k
2BqTzbAvt+pUcJ7sWfdxbnQnK3AxBm9eW+qV9pj5Aum4EbkdLhCbXTjJyS7CBjUY
v+3U+VsldAXUIIyiStIA1PlEJasawp6KlZCfadSTE4K/ZFrUywVKCFD2x1+6TJ85
l8MTS5Wb
=E15H
-----END PGP SIGNATURE-----

--mcLs7zOGhlacwikA--
