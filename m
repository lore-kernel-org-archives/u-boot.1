Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87ED3C3DA5D
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 14:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DD0987E64;
	Sun, 21 Jul 2024 16:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BxHp9F4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FF3287B1A; Sun, 21 Jul 2024 16:19:15 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 105508789F
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 16:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3daf0e73976so330424b6e.1
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 07:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721571552; x=1722176352; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IpUN2SlZiBaGPauFxJZAx2vSqZAO+Yk2sa53uxfUgU8=;
 b=BxHp9F4Egtgcf1Bh95woH1qUz9rKtKx0VEYuMyJOjSG2gVrzWwynPTpOdxN3JNQqKa
 l6I+fa4Np9sdI1SocS34e+vUPFSTO8b0wDEwgQndkD7Wti6MBk37J9F96+5RAsY+hgi/
 V3Zv3kpUoNakV4neEvXIs/6scaQooyCLLDn+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721571552; x=1722176352;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IpUN2SlZiBaGPauFxJZAx2vSqZAO+Yk2sa53uxfUgU8=;
 b=WYJmyJ+5HYBG7y+ZgqYBeui+1tLALSMDOf6I6hRm2D5IRaPCNH3whFshauMvHhM/7W
 pFNTsheMGqU7ceIa+5Kw617nLeX4IMKNuKsxaAWSyTjS1S92ru9M4JbZZ4jTc9jnViG0
 5PANPkldkPaxcmGfUafcAy2KgooLhNMnGANm37F3byRNPpT2tASHvTzp5E1LlFrd0PVz
 TF6Z33x36nizxQCGSoJQAuvJuPSjTIjSG6f3gHnY0zs4CD41GN9iC0G02Oz5C/1KKKYN
 glFALOi+8oOvVPUi7fX2Hzwk1FcfeD6VqWRZu32XJU8mABMdBa8hofhh236BQY5gx9QR
 wYWA==
X-Gm-Message-State: AOJu0Yy9AvD2TgpZDoxOkCCvuYHU2rwXxRK+suY8g4dvWXcxsYKb2QVF
 FZOrCXDNenkPTXCW8RdZ/XVcuqcsVl0PfDJgBidcD9Ngc54pyX+RpU5XugezIEFkzjteElVhqLB
 CBvEyTA==
X-Google-Smtp-Source: AGHT+IF/YDSjtK/HZcpp95+faUZTNnWnyBAldNvu9AcTO5Ju3+6qsdfe6Tq/GHkF+WcmOXvt5/Ppvw==
X-Received: by 2002:a05:6808:1404:b0:3d5:61d9:fac6 with SMTP id
 5614622812f47-3dae5fd0d36mr7056153b6e.18.1721571551596; 
 Sun, 21 Jul 2024 07:19:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dae098fc80sm1108346b6e.28.2024.07.21.07.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 07:19:10 -0700 (PDT)
Date: Sun, 21 Jul 2024 08:19:04 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: "Cogent Embedded, Inc." <source@cogentembedded.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Adam Ford <aford173@gmail.com>, Akash Gajjar <gajjar04akash@gmail.com>,
 Alexandre Vicenzi <linux@alxd.me>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrew Davis <afd@ti.com>, Andy Yan <andy.yan@rock-chips.com>,
 Apurva Nandan <a-nandan@ti.com>,
 Banglang Huang <banglang.huang@foxmail.com>, Ben Schneider <ben@bens.haus>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, Bryan Brattlof <bb@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Dave Purdy <david.c.purdy@gmail.com>, David Bauer <mail@david-bauer.net>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Evgeni Dobrev <evgeni@studio-punkt.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Fabio Estevm <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jason Cooper <u-boot@lakedaemon.net>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Joseph Chen <chenjh@rock-chips.com>, Joshua Riek <jjriek@verizon.net>,
 Kever Yang <kever.yang@rock-chips.com>,
 Klaus Goger <klaus.goger@cherry.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levin Du <djw@t-chip.com.cn>, Loic Devulder <ldevulder@suse.com>,
 Luka Perkov <luka@openwrt.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michael Walle <michael@walle.cc>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nick Xie <nick@khadas.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Nishanth Menon <nm@ti.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
 Otavio Salvador <otavio@ossystems.com.br>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>,
 Robert Nelson <robertcnelson@gmail.com>, Sam Day <me@samcday.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sebastian Kropatsch <seb-dev@mail.de>,
 Siddarth Gore <gores@marvell.com>, Simon Glass <sjg@chromium.org>,
 Simon Guinot <simon.guinot@sequanux.org>,
 Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Teresa Remmet <t.remmet@phytec.de>, Tianling Shen <cnsztl@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>, Tim Lunn <tim@feathertop.org>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
 Tony Dinh <mibodhi@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Viacheslav Bocharov <adeep@lexina.in>,
 Vignesh Raghavendra <vigneshr@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Walter Schweizer <swwa@users.sourceforge.net>,
 Xiaobo Tian <peterwillcn@gmail.com>, u-boot-amlogic@groups.io,
 u-boot-qcom@groups.io
Subject: Re: [PATCH 1/1] Squashed 'dts/upstream/' changes from
 7e08733c96c8..20e0f0897ea2
Message-ID: <20240721141904.GH561963@bill-the-cat>
References: <20240718184912.2759784-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S/oT5j2Dh4t5WcKk"
Content-Disposition: inline
In-Reply-To: <20240718184912.2759784-1-trini@konsulko.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sun, 21 Jul 2024 16:19:42 +0200
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


--S/oT5j2Dh4t5WcKk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 12:49:12PM -0600, Tom Rini wrote:

> 20e0f0897ea2 Merge tag 'v6.10-dts-raw'
[snip]

I've now pushed the v6.10-dts sync to master.

--=20
Tom

--S/oT5j2Dh4t5WcKk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmadGNUACgkQFHw5/5Y0
tyxYhgv/fMYzcNsSy89VenYh/gy3MEfxZzqbMZnTNF1ajtjR2uv/5BCMeV0CLRzx
i46AQadVYA/otVzYt1Nnz9On5SKfTJmS5xZFeeyEk0u4b9Zk9CSUFIwa7GVhhyYO
72ySNWWBzXyLxNJ55uuY0fZm71crpAVcUT1fXWvjLvzUS+RW4ZJywiCUmeQKh2Zr
nTQfkSy/CvpdqfYcM/jB2/LkDDPKp0mHaUiDVRBwKLcOS7Sq6UupaGcXGJl/GsjP
KLV9/woVEy6+Adnem2yrlF41TGaToKEE6awR4V2ybYFqg+UGV8yb4UH/MHDOl0Hm
KdMqA7QgvHzzw03NINP/7CfFsMP8rB4eI+pS/Vx15j6ZlK9x/51+afSJ0GthbnuP
MnmPPgnhCpTPQ+BvdEvhu+WObHcmnj1aFgGZ8OgIPxVadIZCK7QQfkl/nneTKsUv
pJPh6JS8ne8sa2VPECQB7uSnlVGyznh/XB/Y2ptn3HpLBCXMNNd18cVWXRHmP08I
iTa/In50
=CfCG
-----END PGP SIGNATURE-----

--S/oT5j2Dh4t5WcKk--
