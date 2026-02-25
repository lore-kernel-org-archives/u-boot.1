Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893CFFD45F1
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 22:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93F7D83642;
	Wed, 25 Feb 2026 23:55:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f7lwLK/9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 340D083D8A; Wed, 25 Feb 2026 23:55:00 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28CC482A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 23:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4648447e29bso117483b6e.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772060097; x=1772664897; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IjFv8aoLBI5Us+hwMoD4lkRzzpd8uRsaJwZCDljte9A=;
 b=f7lwLK/9ZzLGZxMJunaA7UjjSpe1ILC/exlhPD31AGh3bz6f0+0rjTf+63kQ2qkbGO
 Ay0BIbOj5omvr14vDYI7EzPXN6my1BYMVY+5IxU/fy6u8hnW3rbjxurfqp58jQN70lyC
 ALPEDGRmbOlVMCja+1MHJ+oLp/Tv1naGshFgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772060097; x=1772664897;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IjFv8aoLBI5Us+hwMoD4lkRzzpd8uRsaJwZCDljte9A=;
 b=uzHgJaeNzCbwE8ewzZIIOh8R6oDwiqB0/lMhXg8hPTd+cNgidrWW5qZKFpNZEpKw4U
 OZnOyDGLYUsGbBaXKwJZAt5Q5qVoGgwBeFx4Sv4iij5WXxhoddCObzgDkb30xeTSrA5k
 B483BlUbK4VUPt4reZxPWyw0eyfv03oFMTfyOvEbxaXH1H00H3qgjHWIDNkYZn7xfFx7
 299weOfSjU51Dv0Q6JSihTwDud7yEqmaho6i5kq/6Z/MaxMJntv5VLvhg2DT+nPSBgMd
 UtGjaAgVC2ji0Kul60lboMKeWLwT4J1AObWnd8koVAFLUz1ocnNMiTlg8YTqu4o6Wqzl
 66RQ==
X-Gm-Message-State: AOJu0Yx/32Ic7J8NOH43ISrQMr489hk0pZcLQCEuNbFFE6cj6KS13U4y
 sxR5utg7hnjKmi31+xnuOJfnyBMPGcj2GeblhtVe/dJS7TT5oJWesUwif8M8DaVzISM=
X-Gm-Gg: ATEYQzx6Xu3mWbPT4xx5VWdvdP7fmv+Q5gsZ8r2ZmuZczMwVJQWpsNMUv0a8dtYa5MM
 J1atqvDLfe2GBrNxVspHxLMUcBreSD21Jiw9JNugFZBBi+l2l85fO2zoKSTpIRHgarZMSNqo0to
 0fA6vMMDL8BKv65iFYaaPJbbvmddGab/iDbjdkiM8twWFwmOwmrGBF3nqhnlzxBRh1J+XR9hqQA
 p9HAtC7tpK5alCGhHQmGy6OIybbPXxqZ16YfpWSPPcs2Apcjf15hFuIPxH76Zww8wWIE8ihqA8z
 XX76Vfo2SGW0jrqQPmCH0l6wFg1boaOm4sFky2p72XTCyEnZ1coZR76QLhgV99NQYY/5YvpBhds
 0MN2SwTQIWxHC8P8R9PJ1RV6662wpewHs+TzY3vWrHdMtLCuThcntl/t05LnNPtzwqD12lXRtQD
 FF4jGYEQ5gw0kwe3sQe8jb/z1WBSeCzNow18c6YH0QU+bOtz8G3wwrs2jHdM8QrqvBa+N9PTxmJ
 Rwt8Y2SQjV9MQ2GyXf7IJn2npdyx1u9Zftd7ki3uOmBaz1TXIwsOaHvy/zQqQ==
X-Received: by 2002:a05:6808:1b26:b0:450:d056:e0f0 with SMTP id
 5614622812f47-4649ee62aaamr1066344b6e.2.1772060096905; 
 Wed, 25 Feb 2026 14:54:56 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a1f6333sm9916297b6e.19.2026.02.25.14.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:54:56 -0800 (PST)
Date: Wed, 25 Feb 2026 16:54:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Alice Guo <alice.guo@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: Re: [PATCH 1/6] binman: test: Renumber duplicate test-file prefixes
Message-ID: <20260225225453.GZ1593142@bill-the-cat>
References: <20260225225040.2568118-1-sjg@chromium.org>
 <20260225225040.2568118-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2Y2o3y1KlF3FRC/6"
Content-Disposition: inline
In-Reply-To: <20260225225040.2568118-2-sjg@chromium.org>
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


--2Y2o3y1KlF3FRC/6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 03:50:30PM -0700, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> Quite a few test files reuse number prefixes that already exist in the
> test numbering. Test .dts files are supposed to start with unique
> numbers.
>=20
> Renumber conflicting files and update the references in ftest.py
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>

Since the numbering does not seem to matter, can we move forward with
some other scheme perhaps?

--=20
Tom

--2Y2o3y1KlF3FRC/6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ99ugAKCRAr4qD1Cr/k
ChPaAQDxDconj/Tdc3iKCO7mC7k3ln8KeEGQ8+FpeTP4PivOOQEAjWzh0ptZj3ym
SJPxHOInCOBd7yxhIUjLTfUDlat6oQY=
=4Wyf
-----END PGP SIGNATURE-----

--2Y2o3y1KlF3FRC/6--
