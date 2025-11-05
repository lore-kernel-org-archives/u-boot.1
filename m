Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A74CCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 15:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0E3983A32;
	Wed,  5 Nov 2025 16:20:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JUgFxit6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2917183A1B; Wed,  5 Nov 2025 16:20:25 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC5F983A83
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 16:20:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3c92328d0bcso3815305fac.2
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 07:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762356021; x=1762960821; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k0yoObyGuuYLhWy87FgMOX/ww4kCOySFAGcPQ4kx3S8=;
 b=JUgFxit62KVIp6KZ+mHUGvYanc2YcZCAkYkSmO9y6M90mDb5gTfpyjzOjehgXpgUg+
 kgtAObQiV9zHfV06VP3wudbWVAzhAsf8zLvQbAOHEWfx1/mIZhwMEi5N83g0Kz+4iPZu
 BvIo8ONyjhixHymXtz+iow6cNJyZKrTRXtcOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762356021; x=1762960821;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0yoObyGuuYLhWy87FgMOX/ww4kCOySFAGcPQ4kx3S8=;
 b=aHnCb6BNwI0ZHpM9y6XxwGUPhbzg7ZLN/pJ+cE9gu29G3srifFVeMqgiq9Nn9Ypdpa
 vo5p8dN/K2COlQny3PkzRsyhYMYpT3ojDTkmTym1nt3K3XMLOPLrtdZQXiEZt47xGtsI
 harkbKHhPVrl+NqINjhlVu1DRXcRiwQDeRzQg3JJzDHNMMHAyuruJVeP7RsETDC76Rd3
 Jgqp19mwDHD9SlOf2HSToUMfPF2VbFbnsxRrDSrdDu4ZmWUGuD+zGLe4tmp4se641mVr
 2U8b0D9VG/g7uHbBHYTUqMKeC2G1NoHAsz97q0end85pJsVhHGo6nXsReaU4dEooBHPE
 fyOg==
X-Gm-Message-State: AOJu0YzBmw90gT+m1pac9LstNljyFbQERkrNgFtQuQOIr5PEibKTARds
 xKW67bnxCWm8TTTg5c+t0lCAqf5Od/gxNHx1jOM9Tdoz6WXEQawXSL1HoUpMqZnP7T3/BsYImER
 /S04smX9EcQ==
X-Gm-Gg: ASbGncvduBJSwwgs1cVgj8vvzz5v1qLpFq89+y5aWmKOJA4E/RcjyIpZMGg5W8XL9tC
 tB3JVeSfXPwFsShkSjcJSmyJtMjebJfRfTe2eN0275OuWYj0iYcRowTXOg6TFxR6JL11kmHAuUv
 kY5vzBlh6Rym9/ok6f0p9c8SoDXwZhr+5/1boK8KjlHpebt9XlhEPXvja1sHdsu8G7onSCG+Y8i
 Xi1nVeTirq/JeqqcqL6kgN53eVtSb4vOd1cjxxlI/vF9AjLXV6ciT2FdiVYbuTvfODFZMJ/nHZN
 JVS1eduomZRwjDxPOkWXm4K+Nk9LkDi5ZYMilLAEjzKHcB9JqelNPKMx86d4Ixcu9E+oPQIp0ix
 pri+Fi199dhQ1zyihYOgjQ8Er3LLM7zBrUMLW/3gIHDE7ozSPLP14XN6LqwBB8okZZNSbHgu2g+
 OgPCOKQwMM08i2TIIxvy3I9fqZbJ8p8k3jnk75xEs=
X-Google-Smtp-Source: AGHT+IGt0Vz3LbuRBo/+XOlZG0txbTtITnw2MNPaCcitsfeMOvCj4Sh5N2B+FsVByl9HBKu/33cCQQ==
X-Received: by 2002:a05:6871:7583:b0:3d4:94ef:d05c with SMTP id
 586e51a60fabf-3e19a7e51c2mr1499387fac.21.1762356021484; 
 Wed, 05 Nov 2025 07:20:21 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e0f2eb63b1sm1552502fac.21.2025.11.05.07.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 07:20:20 -0800 (PST)
Date: Wed, 5 Nov 2025 09:20:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Heiko Schocher <hs@denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 0/3] reenable dm_gpio tests, add support for
 gpio-line-names lookup
Message-ID: <20251105152018.GO6688@bill-the-cat>
References: <20251104174458.3385564-1-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IgfSyINNbiZqduy0"
Content-Disposition: inline
In-Reply-To: <20251104174458.3385564-1-ravi@prevas.dk>
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


--IgfSyINNbiZqduy0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 06:44:55PM +0100, Rasmus Villemoes wrote:

> Hopefully third time's the charm.
>=20
> I merely wanted to add support (mostly for use by the 'gpio' shell
> command) for looking up a gpio via the gpio-line-names DT property. We
> already have a "gpio_request_by_line_name()", but cmd/gpio.c does a
> separate "lookup + request", so it felt more natural to teach the
> lookup machinery this as well. That ran into
> OF_CONTROL-but-not-OF_LIBFDT being a thing for SPL, so here's yet
> another attempt.
>=20
> Now, when trying to do my civic duty and add tests for this, I found
> that test/dm/gpio.c has been defunct for a couple of years, and
> reinstating it is not entirely trivial.
>=20
> After a couple of rounds CI is now happy with this:
> https://github.com/u-boot/u-boot/pull/828
>=20
> Rasmus Villemoes (3):
>   test: gpio: include in build, and fixup bitrot
>   gpio: search gpio-line-names property in dm_gpio_lookup_name
>   test: gpio: add test for gpio-line-names lookup
>=20
>  arch/sandbox/dts/test.dts  |  2 ++
>  drivers/gpio/Kconfig       | 16 ++++++++++++++++
>  drivers/gpio/gpio-uclass.c | 11 ++++++++++-
>  test/dm/Makefile           |  2 +-
>  test/dm/gpio.c             | 24 +++++++++++++++++++-----
>  5 files changed, 48 insertions(+), 7 deletions(-)

Thanks for doing your "civic duty" and fixing these up!

--=20
Tom

--IgfSyINNbiZqduy0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQtrMgAKCRAr4qD1Cr/k
Cug0AQCtiTMiTSfxnhxHnnXyjfs/TTyT4F1NgdNHwiU4R9k8wAD/WvqIHaNzfi5z
YRLO0pAIQrwL62RrdSJqoX1zSXZBpQs=
=WYYT
-----END PGP SIGNATURE-----

--IgfSyINNbiZqduy0--
