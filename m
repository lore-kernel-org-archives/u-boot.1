Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FE3E9A037
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 19:06:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D0FD83AC5;
	Tue, 17 Feb 2026 20:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pMARQJI/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08D3383AC5; Tue, 17 Feb 2026 20:06:05 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D377083B99
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 20:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4639279c7a6so1410619b6e.1
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 11:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771355161; x=1771959961; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rSpE+vzjvdvdsl5rsaeMNmRzZ02lkPHCBuDSEDM3e/w=;
 b=pMARQJI/y/zpyAy124WC5f1FZzaiKhzmizAzHmhaMAP6BwQsf3Oz6BmZ6/kTTVw/oL
 S0X9u+clsfl/Yt9ovwk5rGPNRvA3VhKYFomRRJnAnJNiMnWFPJIfl1h9FWb89W2ZgiBN
 xmZOuyVuhWUwwr2Ul/MGkbHzkTMAigruw5Uv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771355161; x=1771959961;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rSpE+vzjvdvdsl5rsaeMNmRzZ02lkPHCBuDSEDM3e/w=;
 b=ZE0JVOiTJ+8B9RAkWAO5FwKu5lMW9SENalDL2lT+CTEMMNsRNITThEZ1aluBr3kgtY
 Vc98sSwv0nUdwfvffndvK+cfkk4kOfT33nVU7SqFBIR/lAoN4mBKxHc6DsQ1pRF2AS1g
 Zg/FxrRo+FEgFQRhtIyswX5d4wSwjZK4vEs8ClOZLoFxEVqbLLUXsRma2+zdKQoBMhs5
 eHWtc0uk7BJOPuufcvYOlUy9PqsuXezR9p+lD8ZNOV/NiVfIpCavVHERSmIfEIXcmdQW
 fur21p69cqgGV9wIveZADpU3syLZHxDbijHS5KmEGbyt4JH9qS9GqSntCmWnNZ+pfXk5
 +4jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUEExfJOf9M1RTrdgCfVRnB8ViLgk9ZRN6RgZSsTaOkhynZaQN348TN3IIRSOpyNpjw/JSOhs=@lists.denx.de
X-Gm-Message-State: AOJu0YzKMgfNnR9lIPAicpe73QUIJs5CuPYypgOjyrYWQsA9g0E8Ja1H
 z+a/7z+YinQeX3yhVa6VYPX4I7Bz+uAdTOdEP5kFta2puMuA75Ai2w2/oxTeUN24Buo=
X-Gm-Gg: AZuq6aJhnYV910i1nHgPfqscSmlONkNpAC7sWL0qNl6Rzd5OQLM05AUfAbUNqroMpOH
 ddrSxgpHBSSJdQ+NhfphDrPPfUyWIEa50pXd09Z/VtEzw3ujfGfMIONQnqJVVZA2Kv2Qqlyv9Z2
 CTD/KCMSNTqlsL1tvtaUrSyKSDZfsT1X3/Ov62NmVDIF4zOKSe/CyoWB2wvr2FCrSfTBX3MnN54
 ZB79ObyFDOF0d7qcXLnGPTtuy5Y7JHePoSZ8lxE7QtBvUpSLNyH2Ci4QivtPiw9IkHbt7XEu9u5
 IyRQ2uqYYtX/T+guOmglrZc2OLq+vpXgAc18ZDNCuW473BeP+l52bu4ZrRm9D5qDd3o/0kpRaUl
 dyXwYiV4W7KfimrYbtwdJPF498UL0F4SQMB6UUd5Tea4yS2qMxCt8VxJ5dZszzSGK5pFOtC5mA4
 B217+Vdn29XP3FgWc2l9OSZRnmz3o+44XHXzsuEp7GYwByZU7LufjVq0GD3WOYqqjygd7OBjfSg
 LxZwYspcqjvJQiJuU98jNQPt2YHy4nn4BSkj7Hc9bJieMfty4o=
X-Received: by 2002:a05:6808:4fe2:b0:45a:5584:9bf6 with SMTP id
 5614622812f47-463b404ac91mr4993242b6e.39.1771355161453; 
 Tue, 17 Feb 2026 11:06:01 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a733f033sm16804753a34.0.2026.02.17.11.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 11:06:00 -0800 (PST)
Date: Tue, 17 Feb 2026 13:05:54 -0600
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
Subject: Re: [RFC PATCH 11/20] test: boot: add image_loader unit tests
Message-ID: <20260217190554.GF2747538@bill-the-cat>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <05cc2003b7e0951a80b0078b3824d14466979b3d.1771275704.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uHK/dZZgUJTaKkAF"
Content-Disposition: inline
In-Reply-To: <05cc2003b7e0951a80b0078b3824d14466979b3d.1771275704.git.daniel@makrotopia.org>
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


--uHK/dZZgUJTaKkAF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 09:22:59PM +0000, Daniel Golle wrote:

> Add unit tests for the image_loader framework covering its core
> logic with a mock storage backend:
>=20
> - map() allocates, reads and records a region
> - map() returns cached pointer for already-mapped range
> - map() returns correct offset within a larger region
> - map() re-reads when extending a region to a larger size
> - map_to() reads to a specified address and records it
> - lookup() returns NULL for unmapped ranges
> - alloc_ptr advances with correct alignment
> - map() returns NULL when the translation table is full
> - cleanup() calls backend and resets state
> - map() with multiple disjoint regions
> - read beyond image size returns error
>=20
> Also fix IMAGE_LOADER_MAX_REGIONS Kconfig to depend on IMAGE_LOADER
> and default to 16 unconditionally (the previous 'default 0' fallback
> caused the regions array to be zero-sized when IMAGE_LOADER was
> enabled after initial defconfig generation).

Since this is introduced earlier in the series, it should just be done
correctly to start with. The bias in me wants to say the AI didn't catch
this and should have.

--=20
Tom

--uHK/dZZgUJTaKkAF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZS8DwAKCRAr4qD1Cr/k
CkZvAQCoq1ufYXvtNdDBP9ieeqzzVt2OLIu5Q0ceucOep69TWQEAvTFZwzOKvdQA
OjVj2fDH2sW20zKUIg3cI63Ao8IjQwg=
=donF
-----END PGP SIGNATURE-----

--uHK/dZZgUJTaKkAF--
