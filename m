Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D7EE9A031
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 19:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F20AA83AC5;
	Tue, 17 Feb 2026 20:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jvoo6aRg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 946B683CB9; Tue, 17 Feb 2026 20:20:09 +0100 (CET)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69E4383981
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 20:20:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7d1959ba05cso2269399a34.2
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 11:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771356005; x=1771960805; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CASP9CsvmSzRZT6yNyLw48ETC1nkAwhS9oR8JdvYqdc=;
 b=Jvoo6aRg9wWyeKauSak62cGM//SM+bVy74dBa8Mp41Sx9RYC4uK8DwbbP2eK6T9Z/k
 9/8CbM1Leq69dvqTgMNbyvnYRKRsXDnvjglK3/IwtIZOd8zDpVqvLt2m6Cwq7UkQVw+x
 bnhPbME3vcfcWU4T8UoMd2N8O61puivaFPF8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771356005; x=1771960805;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CASP9CsvmSzRZT6yNyLw48ETC1nkAwhS9oR8JdvYqdc=;
 b=vnB4v7m9eqqzIgvhYhOK+aHV6wnq8Sr6dDo0hmtEj80J0D77FNdmRNr+1wuFo7gaSB
 ANjYzRGnVZtWW6ftD2ByitmiA62UrksybtZVTgHIndYtxfqILqrBmIfUaNPqg9fO8YUp
 FyL2hUuSDL5ih2B647TXTZuM8q55iuGqlcl69eQdaD3zHkaD0QtH4u6DtwkoINeHItUw
 ZojMntDilfOoVwtHfDMiR9GQnt2AzV1QXTlmrdELANFmaJkyOgHOvsP7CivA9kbaMMCe
 PPkx0lyaLF3ZSErfZg4/jmIuN4mVN226q9kROZ+vcZCVwS1CHp3qo9KTPJSFX5fSEAn5
 HhhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6Vy0ISZFgdfLBauoe1nXcSXkAJdpaidpCwj7IWaHdG3j/9phbgJHBCkxAmOOWv9u5I+m9+Xc=@lists.denx.de
X-Gm-Message-State: AOJu0YyuG/MdzrPo2z7r+l0Apoh+VwB9xEwkJmreUr7bwMsu/KquIoBU
 cuvv+QnRKW+h7bRnvhdEds5kJnU64efYSxgsYfuOsbnuFwQ9JA3hy6sx8Vs9pUkZRfc=
X-Gm-Gg: AZuq6aJ/tCj0Q5Y6mME65cSzclNUSlRybbY8Oc2koT5NRPC6tBOcvxQMVNqaWhR3pkg
 BUfGB7R8IWgP9/mHQB/LvbWjXdknXjxrXglAtVwQFyEj6rlZ02u5JsXyqvoPk/TO8+vWfRBFgQy
 r2VMKIY2S0lPXMupZV72yU8UNX5vdkeaFyE1IGWNohIKuB38v2lnPMKH+OUkAvBkHl7b36mwAb4
 WJdMsoMPgYq3zlJHCcPK9ZROLFofw0gstcj22bm4v65BkDRksoe+z3RhKo9a+FUQmeXhUWOBAAw
 y8OUT9VM/cqbVRHc0yyZMUCH/fVKe1h6PWkk0Cp4plS4swE1SImg3+PpZBbwVrh4LTfTBYWitZ9
 D8EXggmh/nBzeTkGW1AZjW45dKqiulVRc9N9hEotVEjnnS30aPurThdKg+qg+mRc46hQ6u231sS
 H3QfEmYSt8juA64mkPOjvIFMc8yi0949wpFORplyF0zTQeyu4NeL7brnsDbWgJbdhwD47g0t88b
 xwrTPz+lQN2Ohbomy4ByoHxCgnjus+51R5cDh/LxHzfFUg+pWKD36dbeZ7XCQ==
X-Received: by 2002:a05:6830:3102:b0:7c7:63b6:89d3 with SMTP id
 46e09a7af769-7d4c4ac757fmr6640950a34.19.1771356004560; 
 Tue, 17 Feb 2026 11:20:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4d668434bsm8686186a34.9.2026.02.17.11.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 11:20:04 -0800 (PST)
Date: Tue, 17 Feb 2026 13:20:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Subject: Re: [RFC PATCH 00/20] boot: add OpenWrt boot method and on-demand
 FIT loading
Message-ID: <20260217192000.GH2747538@bill-the-cat>
References: <cover.1771275704.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SB1BsIuCmfnfQ3Vk"
Content-Disposition: inline
In-Reply-To: <cover.1771275704.git.daniel@makrotopia.org>
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


--SB1BsIuCmfnfQ3Vk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 09:21:14PM +0000, Daniel Golle wrote:

> Hi all,
>=20
> This RFC series adds a new boot method for OpenWrt's "uImage.FIT with
> embedded rootfs" firmware model, along with the underlying infrastructure
> to load FIT images on-demand directly from storage devices without copying
> them entirely to RAM first.
>=20
> I would like to discuss the design with U-Boot maintainers and fellow
> OpenWrt developers before submitting a formal patch series.
[snip]
>  boot/Kconfig                   |  88 +++++++
>  boot/Makefile                  |   8 +
>  boot/bootm.c                   |  62 ++++-
>  boot/bootmeth_openwrt.c        | 248 +++++++++++++++++++
>  boot/image-fit.c               |  96 ++++++++
>  boot/image-loader-blk.c        | 133 ++++++++++
>  boot/image-loader-mtd.c        | 103 ++++++++
>  boot/image-loader-ubi.c        | 112 +++++++++
>  boot/image-loader.c            | 163 +++++++++++++
>  boot/mtd_bootdev.c             | 150 ++++++++++++
>  boot/ubi_bootdev.c             | 180 ++++++++++++++
>  cmd/bootm.c                    | 148 +++++++++++-
>  cmd/mtd.c                      |  65 ++---
>  cmd/ubi.c                      |  33 ++-
>  doc/develop/bootm-storage.rst  | 210 ++++++++++++++++
>  doc/develop/index.rst          |   1 +
>  doc/usage/fit/index.rst        |   1 +
>  doc/usage/fit/storage-boot.rst | 201 +++++++++++++++
>  drivers/mtd/mtd-uclass.c       |  15 ++
>  drivers/mtd/mtdcore.c          |  45 ++++
>  drivers/mtd/mtdpart.c          |   2 +
>  include/bootm.h                |   2 +
>  include/image-loader.h         | 188 +++++++++++++++
>  include/image.h                |   4 +
>  include/linux/mtd/mtd.h        |  24 ++
>  include/ubi_uboot.h            |   2 +
>  test/boot/Makefile             |   2 +
>  test/boot/image_loader.c       | 429 +++++++++++++++++++++++++++++++++
>  test/cmd_ut.c                  |   2 +

This isn't enabled on any platforms, and not enabled on sandbox either
so the tests aren't run. Please do that for the next iteration as well.
Since you mentioned one of the Banana Pi boards, including that would be
helpful too. If you can also include support for the openwrt one (and
instructions on how to flash it, if
https://openwrt.org/toh/openwrt/one#uart_boot) isn't enough that would
be great since I have one of those at hand.

Finally, aside from the feedback I just gave about splitting the image
portion out, it seemed like a few other changes here could be considered
stand-alone bug fixes themselves. Posting them outside of a series helps
both for ease of review and ease of merging. Thanks.

--=20
Tom

--SB1BsIuCmfnfQ3Vk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZS/YAAKCRAr4qD1Cr/k
Ci5dAQDwAdsu5LF+ozVMHzjzUObUWUnWYQQpTS5RMutp8mmOAgEA4zw2p5v4A16D
JIrUD50Peh90KNPmAOtcEUCLhpR4rAY=
=j2Tz
-----END PGP SIGNATURE-----

--SB1BsIuCmfnfQ3Vk--
