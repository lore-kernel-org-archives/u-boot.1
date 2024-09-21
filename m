Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC07DCF9C5B
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 17:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6513D889AE;
	Sat, 21 Sep 2024 19:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FADWK1jn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65BAD88A43; Sat, 21 Sep 2024 19:49:01 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 046308868E
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 19:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7ac83a98e5eso264506085a.0
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 10:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726940938; x=1727545738; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XuVnDqBS/QvCpJ99FedED9FNrzO0JtkBgXRmbPcfMxw=;
 b=FADWK1jnS5CjrBKvs+GpgnIE8BbBsXJBakNYcgmaalNsD1CxRD1NWy+lvMELxWmF9V
 1qfbgWfg0z6yXYNAnv6zwkzMJeecp4Pt9dnoqamX9EM6+U5JBrq1TPcbuvqMBf1jqYi0
 /kZNpIvUzDrJwXDHisAfoKd8ats2uhp59+kn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726940938; x=1727545738;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XuVnDqBS/QvCpJ99FedED9FNrzO0JtkBgXRmbPcfMxw=;
 b=SWl9ohh6b3/qHv/KBBnJS1wZVktQbn5e6tCTTJQhKInnyFK2lfeA98TwQPKbM+InH8
 p5NhHApaeCY+yLOV9sc+8nCLvgn9kNbitysEeg8ZB/jfxWETHvup6TNtIvOe2lALWhnS
 SchrehG53cmHQicxo2BCC6+l2clfYH4E2wgiEWMaKUDN8xMBm6tfhdJrtC1Ick9cx+gV
 +m2DTdNT3qFJo1HV7xVDknaQX1frH3xV1gmBd6h5c83ulsCdWN4DyaIoK2juamcinSoq
 uwY6c/Tmz7qxwnR+m9XxXQn/qvULP2JrL4jRyGeS0c6lZ3im4OYIpFaMyvmWO+Ltj4XJ
 571w==
X-Gm-Message-State: AOJu0Yzn7Ft2mF0aSjYpa952X4toihCYmtUROx4Pk+Be/ut2BbQ5jpsO
 P6fwEBlv15C4XgzjRJYknTkFScgkVsdoXsM8xrXuw97YwH4KGXel0RJ9uKyOlKY=
X-Google-Smtp-Source: AGHT+IGIWlYgoNJ0NkFURxS2e8irAlA7rRuade8CEnvqGogTAqkB8KFEJeNbO4p41TDsqjMc3DZuTg==
X-Received: by 2002:a05:620a:1a89:b0:7a9:aaef:305e with SMTP id
 af79cd13be357-7acb7d76e7cmr1256073985a.12.1726940937839; 
 Sat, 21 Sep 2024 10:48:57 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acb07ddd1dsm309736785a.25.2024.09.21.10.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2024 10:48:56 -0700 (PDT)
Date: Sat, 21 Sep 2024 11:48:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Thomas Perrot <thomas.perrot@bootlin.com>
Subject: Re: [MASTER] Pull request doc-2024-10-rc6
Message-ID: <20240921174853.GL4252@bill-the-cat>
References: <00131229-9bdd-45ba-b4a5-c674e1340eab@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YCfNKwAwo7s8x3fC"
Content-Disposition: inline
In-Reply-To: <00131229-9bdd-45ba-b4a5-c674e1340eab@gmx.de>
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


--YCfNKwAwo7s8x3fC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2024 at 11:35:19AM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 91a7927aa6679d1a3ea30ed9dfe17002d11bca=
c4:
>=20
>   dts: beagleboneai64: Add boothph in chipid node (2024-09-20 18:08:34
> -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/doc-2024-10-rc6
>=20
> for you to fetch changes up to 7803a66399381570dae5cea030b01b26cd5ca676:
>=20
>   doc: usage: cmd: ums: fix dependencies (2024-09-21 11:22:42 +0200)
>=20
> Gitlab CI showed not issues building the documentation:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/22388
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/904189/raw
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--YCfNKwAwo7s8x3fC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbvBv0ACgkQFHw5/5Y0
tyxQWwwAj+gKZIoyF/vvMiykCkr8qvfuq6G5c+cHiTdWnYLHC71rpn2E2B8dNrPQ
JmcKeJz7wdhCcJ3TIrcZ8NfBxGJIkntbR3kjYMTBWCLBhXCYWjKpTsKIkKMaJw3G
YQqwcujS7sT4nHKLgLmqvnDg8HYCWklhZtCfPnIxJBo1b5tvGSnjVwAIYXpif60j
KaBPop+sQ33bXxZUPfo+RiBW4Q05AM3cp3uHsseh2z2RBGHOnuseJcaV+Z+N7gDV
91dOvIud4ZljRAO/wRjjnU7Vuxo+KIGNO+FWXI8m0nTFEeqqbNWKd1+TO5koYyKw
5Syt3OdktUITWDpCuH54Du4JxjeAhHNJrNMqp3ZN+6SMCZq8LTDEilQGj5+tq4Dl
eDPmUGS41PVIZm1Lj6nW2eJxCMOHmuTsBRWH2he41nNprfxfbnSQcnc8UUgd2bus
EpodlVnPcL6Sy3SLIW0z3+ekRKPrNejiqPqQWhPk8tvJva4chJ9l1ykBSPhxG/x7
TSg3QZtx
=Qr1P
-----END PGP SIGNATURE-----

--YCfNKwAwo7s8x3fC--
