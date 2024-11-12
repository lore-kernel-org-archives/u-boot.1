Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60B4D597B6
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 23:11:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12AE1894BF;
	Wed, 13 Nov 2024 00:11:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AScY/4fl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDFE788C0F; Wed, 13 Nov 2024 00:11:34 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE925894BF
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 00:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbd550b648so46985046d6.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731453091; x=1732057891; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6osKejeTojpTCTb5N9WYWdrmc7v02LmsmGlK00388fg=;
 b=AScY/4fl9G6uYRxGgKNnbBA3byDa8/ugzaH94MLa99bW8nMhhJdouz9GKhqHqNvhYn
 Vte7Ja4w8lnVes7ThfZLMRA5kl4K877/s7+y54pi0LxeMGC/mvyUO4AsgKqD56HZtbhE
 QZLO32RRjv/dXNf1+8LzR6IT4ZMT8lK9grqXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731453091; x=1732057891;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6osKejeTojpTCTb5N9WYWdrmc7v02LmsmGlK00388fg=;
 b=B9zHqJGSuKX0bJlB2o+H1KHJtk8Sg4FLAunf8bo1MuruAzXcTwf4o75Ye9GNemhr6j
 jdKntGAdcFYbD1FwPGhHS+kublkhle3GBonPIDDC5+NoVQ4W7oByVdsnnWuiLHSapg+Q
 ujl/oRrW7ZL8Mqq8lvKnUPxYkZg3VAGiGHrBWI7vAaZDaG0mxjukckJjVm3BXwWwodV0
 9ZXHV6Qt7MK9imyoJsipP+7JggwxqO7ZQGcKfTn3aRtrj70nJBc0QtRFMNgrBgLQk6MX
 bMsrv2TnjoFF4DectWpnOnmMQ/sBK7gFNapy4m5iKxnvBjGQL8WfxStjFj6POreY+7M3
 wRxA==
X-Gm-Message-State: AOJu0Yz1W1FIIC3kI+EzSxzIhePIr/XzYMYyyhDXs5xgDQ5HrjV0Y9ma
 CozVS/C1s9mdJmXcIEGk15KRUbz8MX4f9WbAYucgc4Uurtd7JWl5WdomtiQ5f8Y=
X-Google-Smtp-Source: AGHT+IEdmcX7oFn/xtGjj0cgaBPEKMDZy8LAP8Tc/TBMA9Jf6uRJe4kQ2FPqfdkWpJG08CSc8MS2WA==
X-Received: by 2002:a05:6214:5d8a:b0:6d3:6577:ab11 with SMTP id
 6a1803df08f44-6d39e1a5394mr277604256d6.30.1731453091617; 
 Tue, 12 Nov 2024 15:11:31 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d396631aeesm77161766d6.120.2024.11.12.15.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 15:11:30 -0800 (PST)
Date: Tue, 12 Nov 2024 17:11:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH 01/18] scripts: Add a script for building and booting QEMU
Message-ID: <20241112231127.GE3600562@bill-the-cat>
References: <20241112135911.630586-1-sjg@chromium.org>
 <20241112135911.630586-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dbyoobo02OlySp5X"
Content-Disposition: inline
In-Reply-To: <20241112135911.630586-2-sjg@chromium.org>
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


--dbyoobo02OlySp5X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 06:58:54AM -0700, Simon Glass wrote:

> It is handy to be able to quickly build and boot a QEMU image for a
> particular architecture and distro.
>=20
> Add a script for this purpose. It supports only arm and x86 at present.
> For distros it only supports Ubuntu. Both 32- and 64-bit builds are
> supported.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

I don't know that this is an appropriate thing to merge. It's missing
all of the other architectures and platforms we support via QEMU and run
in CI all of the time. I feel it would be better to document how to
"read" the combination of CI yaml files and u-boot-test-hooks to see the
common cases of "fire up QEMU with U-Boot" instead of adding yet another
tool to support.

--=20
Tom

--dbyoobo02OlySp5X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcz4J8ACgkQFHw5/5Y0
tyyjswwAp8sCOh+xhiSRSm09YJzhKDnqDm09shiHN+jzbWMWuCE9CaiyYKVf98Tm
CLvVIZ+yJbxClL7rbpVYNxpPra4xffZ6UvLiCjn8iGyobOL9z8hfq9FQXa4pYVWW
SjYolWsBSIaP59LolkDtuuVPK7Orp2FLQM7ymlWTRrdh5PJPbREE9FSuHPuZ4OLN
osnH/jZZ1g84Ri4xYCsOrw3VBK9qgl+yaW+DYjzyQfa6D821/CwTicOmIyaeHMZH
GtrV03pt95//u1SwDukq0ZbwMHHKX0SKE6lU6INAQDlLLu3n7vQJS/idrOb7d9++
exbVBsPvYEmJKzomE2ELCBy1t255k915GKbW7p3c6zRvc+t/KZ87nB4LEEeFjKRr
feK6M0MTcYiAdZIJK2IB9ZYbqFedT42J7zmkb377Vm4m9hrgP6jCbiMxtFfFRTOd
bhWwRAs9IilNegXwamWaTrKDsibrMQ7tHeNcWPmajVkZVgYBqCcJUNINsk4ieMoP
b3kRR95P
=mZiD
-----END PGP SIGNATURE-----

--dbyoobo02OlySp5X--
