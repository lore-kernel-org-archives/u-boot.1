Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C0BCEE35E
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 22:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E4AC88CF1;
	Thu, 10 Oct 2024 00:39:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JEDiPK3X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C640A88CF1; Thu, 10 Oct 2024 00:39:15 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B3D688C7E
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 00:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b10e800ba9so87332685a.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 15:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728513552; x=1729118352; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FROpe/wmKwpJC1w4ZvkaIf1nXSQXIrnfn8JcBeVbLV0=;
 b=JEDiPK3XCw4CzT1ef9aABkdZGfmUprR6uTdqPwjvlVahb9/6Agz6/huM6oh8awDMER
 oBm814LYimkzlEJafWDAhVdcHVvcUzfIio+Ccl9QbjrWmBnuKlODGtloraJ5vDjuy7dV
 MeTMTyL3M3p3gLKBtRfTToOthVbPw05Xp/B7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728513552; x=1729118352;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FROpe/wmKwpJC1w4ZvkaIf1nXSQXIrnfn8JcBeVbLV0=;
 b=COmGlxuNsINs8jNoCqWylSi0sSqqxti2+mlaHfXMqdiUUunTimtNROz55b7obHFX4G
 J1eBvu1QFqv+niR5KBYVOJ2BQTcuKBqanhOY2jwUQx30Q0ECPYyR4pd6HMl/H255fX7h
 srce5Uk09+enganja+TUIxVCaWZ6SBBi0J1kd6ZGfQ/PxUVY+TLwkINrwb36hNEz5vt2
 PF56PZ/jYrOSvYpiGdZER62uvNYUazP6fCCMkEXvrHlRcLue5QJLud5i5tAa30csTe5b
 cE0oK0T16+ooWyx5lwfrL4NEkiNnDobM4NC9CcUcPXdpIfVhIggo9iWzR6Rus13RhnDm
 MxYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbEIvCTiuvDoCf6faZk2zEOEyxlIBILTsSE+/ylY1W74qbry86mqLZ1VngH3cvxI4NKQVRKq8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw439cCFu41iMzXf8YQ/rS+b57cUIUrdnUNd0Sg1nEhDIB8QGbK
 lsz/Ezvfqcj5IG5j7ey9lji2McLqFGBE4gxiHkLtERar2EU6wApkjmyKxYXC2IE=
X-Google-Smtp-Source: AGHT+IHr2umgqgSWdc0IWs6CY9g4M2RbZ2p2bstql4d3vQuIup5SHJcdHZszofhJFtMPm6pf1ehSww==
X-Received: by 2002:a05:620a:2802:b0:7ac:9bdd:6e78 with SMTP id
 af79cd13be357-7b1124d215amr198205785a.14.1728513552138; 
 Wed, 09 Oct 2024 15:39:12 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b11495810esm344485a.89.2024.10.09.15.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 15:39:11 -0700 (PDT)
Date: Wed, 9 Oct 2024 16:39:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: Re: [PATCH 6/6] cmd: Add a command to show the memory map
Message-ID: <20241009223907.GN14210@bill-the-cat>
References: <20241009015020.25817-1-sjg@chromium.org>
 <20241009015020.25817-7-sjg@chromium.org>
 <CAC_iWjKh7_OKKMi9K6eMaiYUN-Nxf+ZQ0NuW9BYzK3u4F0Krcg@mail.gmail.com>
 <CAFLszTjBQaoF9g0nky5mAA429gzA8QvzjxHxooDaRo1=BB+stg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vCsAIzRbG4/genUH"
Content-Disposition: inline
In-Reply-To: <CAFLszTjBQaoF9g0nky5mAA429gzA8QvzjxHxooDaRo1=BB+stg@mail.gmail.com>
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


--vCsAIzRbG4/genUH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 03:14:25PM -0600, Simon Glass wrote:
> Hi Ilias,
>=20
> On Wed, 9 Oct 2024 at 04:41, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > We already have a mem info command, which is pretty useless. Can't we
> > reuse that ?
>=20
> I am not too keen on using that as 'info' is pretty vague. We could
> perhaps create a 'mem' command with 'info' as one subcommand and 'map'
> as another?

Are we talking about "meminfo" which literally only prints gd->ram_size?
If so, I don't think it's worth worrying about enhancing that.

--=20
Tom

--vCsAIzRbG4/genUH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcHBgcACgkQFHw5/5Y0
tyyo5wv/dvEdnzan3l+dm9Vs4oNJ66qltyjphDz6BZVZF3iZc+VQ89Ys22NesBlZ
EvtXd7qLiu5uuwhuP7P9O37NUBJV2pkm9VNlb3ErEjWhsmDsm6GrQUZJITBJ5uvN
iXjbYqmlDS+5/V2Sv8xdoVqQbJXHyokEEhWTL1nTIOtVQ5dK/uLZ77lLJwwXbm6+
vbXd9wTJ44CdYV55rlQ/gxnl7SaFSXnJKxfaO27UN2WdHaBzYN7npr2pKYZmax0L
TenXXpowEW2En/pFeAaF/c/ZVaq7O/872TP7+J4eQhNFZ/3oBY7doRArSpiBK1Nr
37nAMqLW1MKW3Gpit3h7nkGrCUFq0Fi4tYUESA5VRaNflqKwnIhdGo3u5unlmVC1
7+7iKHOO5WnA8DzTFHpeo+LV1TAoNGq5JtfZtcf4aaQt5d6QKq01Y9C9etTSC0jn
mGtAp4gir5s0oSAn45WboJKZZzX978XHjEfCJfGSlCsSgCUF0OkFeRXHpZhcZCIe
nxoCFpWC
=+SW/
-----END PGP SIGNATURE-----

--vCsAIzRbG4/genUH--
