Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B534DF94CA7
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 19:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44CBE83936;
	Tue, 21 Apr 2026 21:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kDBiXaM3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15B0F841C8; Tue, 21 Apr 2026 17:47:58 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1EC383E76
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:47:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dca4debedaso3146861a34.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 08:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776786474; x=1777391274; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OO8dGxONVKTSUqDXiKFx29SZuNMKEmZDZT5n+2/xLo8=;
 b=kDBiXaM3ZAkAXmoR9JUlXyOmagIJR5fQDdEyMBLGmSc7jAqe60QNRFuVnTEUPk1p0O
 obKwIw2W761wb7oGtEOMHNMbBZlw5eZSMv4qEkGhQpDPHX0t7kpviB9VTQJGWfeLUjba
 0X3w6HPY6wNP/mPk1m5yKb14DWxwKE3qmFxXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776786474; x=1777391274;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OO8dGxONVKTSUqDXiKFx29SZuNMKEmZDZT5n+2/xLo8=;
 b=OTNmbuhot6K0yijcawTFBdTh4l51bVo50Uv6m0Fjaw5xXNoFAp/6Var3AiWEvEnRAb
 wqdIqMMdUwwEZXwSd7yEvPQxCrOS50WOau/kiGgZu47WE92eAwEvpxOCctlsN/I+Ba9u
 YOXV+BHHa8nRozH9ctIDztEfSKga+dxXvLHbnabKJQlAoMlE4Gj9ZTRE9Q+lS5iYZUuT
 iSPKPvcU/0Siua8X4vGkHBcOZ1FmIXQsxfa7pI0kIGzbR7Fp3wzOVzIaO5lVHcBRIaVk
 MKCwo8B/6XAldmBL5JHZ1k6GiqlALqMU5yYdqqIsJIhmjCOEa8J31X5Egp5xZWWhtSAX
 0rtA==
X-Gm-Message-State: AOJu0Yxu7NzclQuDeOr1mWp+xWI3JlT+1asMtSEaC/4KEiOXLTACc0lN
 H9Rg5Cmoc4yvfHdx3wTuYuvMifoG91VnOEDl2dJuq/YnjiW5tAfzIVby2vpKm9vnxnY=
X-Gm-Gg: AeBDiespc5GBY8P959h2M5O7izrzJyPBuMsoT1qt/9ojyrcn/CsD3uCqbNEfO+Kz68i
 P2IQwUPzp9stFzXuEI0KsHvp33TAqd7qYgt/p9206FSmUtbzz0HtC4JNBofwyRfwSXfZXkMixXI
 l00ci2JrEWrlZEL+/+LfDcUrwpfd/QtJ861gRdns+kLeNhLelxkwr/plMGdo3fzRHdhoFyhSVhQ
 KqPRh41Fw1IuOXvPdtZZjC2ODANA7RIpuyPaZc+6GsgbfwNKtJWIE5xoF17UExDpZa2OqpkSVb9
 s3mxM+cYJOAwE/zQ0Ef4Zs0qWmuQfh3JPS97mHDMOhRKuMlFDPRdh5iPFhMwBYEJYhRsLww0dRX
 379yN/T6paZmy2isrbhWJF8Pvi16Kmffsx8HZtlEhco40IOEd12aiMbm3Yr/N26ef5wJ6s5tjnW
 giwISotFV2EdmG3NLhQU/IpHZldVPw0eK78c9lT3qT1cjWI0ZdsMDVKc+6ezvG7ZS06fJnMYHHe
 deEk5gTI9dRA9UN2WJhVbUBGBxt7osHe28Qnya88EgtYllSoTCUaUZ38sceNg==
X-Received: by 2002:a05:6830:67cd:b0:7d9:d2b6:155c with SMTP id
 46e09a7af769-7dc94fa5f95mr11887642a34.2.1776786474511; 
 Tue, 21 Apr 2026 08:47:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dcdd3fb6b4sm1069665a34.7.2026.04.21.08.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 08:47:53 -0700 (PDT)
Date: Tue, 21 Apr 2026 09:47:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Udit Kumar <u-kumar1@ti.com>,
 Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Adam Ford <aford173@gmail.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Tim Harvey <tharvey@gateworks.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Pramod Kumar <pramod.kumar_1@nxp.com>,
 Gilles Talis <gilles.talis@gmail.com>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Stefan Roese <sr@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, Fabio Estevam <festevam@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Maarten Brock <Maarten.Brock@sttls.nl>,
 Kory Maincent <kory.maincent@bootlin.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Brian Sune <briansune@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Anshul Dalal <anshuld@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Andreas Dannenberg <dannenberg@ti.com>,
 Chintan Vankar <c-vankar@ti.com>, Martin Schwan <m.schwan@phytec.de>,
 Benjamin Hahn <B.Hahn@phytec.de>, David Lechner <dlechner@baylibre.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, Beiyan Yun <root@infi.wang>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Benjamin ROBIN <dev@benjarobin.fr>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Shantur Rathore <i@shantur.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 0/6] net: migrate NO_NET out of the networking stack choice
Message-ID: <20260421154746.GZ41863@bill-the-cat>
References: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u50q5P9j+i2geIXl"
Content-Disposition: inline
In-Reply-To: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 21 Apr 2026 21:14:52 +0200
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


--u50q5P9j+i2geIXl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 01:36:06PM +0200, Quentin Schulz wrote:

> This migrates the net options away from the main Kconfig to net/Kconfig,
> rename the current NET option to NET_LEGACY to really highlight what it
> is and hopefully encourage more people to use lwIP, add a new NET
> menuconfig (but keep NO_NET as an alias to NET=3Dn for now) which then
> allows us to replace all the "if legacy_stack || lwip_stack" checks with
> "if net_support" which is easier to read and maintain.
>=20
> The only doubt I have is wrt SYS_RX_ETH_BUFFER which seems to be needed
> for now even when no network is configured? Likely due to
> include/net-common.h with PKTBUFSRX?
>=20
> No change in behavior is intended. Only change in defconfig including
> other defconfigs where NO_NET=3Dy or NET is not set, in which case NO_NET
> is not set or NET=3Dy should be set in the top defconfig. Similar change
> required for config fragments. See commit log in patch adding NET
> menuconfig for details.
>=20
> This was tested based on 70fd0c3bb7c2 ("x86: there is no
> CONFIG_UBOOT_ROMSIZE_KB_12288"), from within the GitLab CI container
> trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026 and set up
> similarly as in "build all platforms in a single job" GitLab CI job.

Thanks for doing this. For the series:
Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--u50q5P9j+i2geIXl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaeecHwAKCRAr4qD1Cr/k
CuLKAQDOXJ5BC1apU2+XV5GE28juAOUX3sUnLJ55E0aR7zCRfAD+N1leTJBqLZLg
QCRf1eht8gl2qCesuMDdZgVgoFkqXgM=
=pxRx
-----END PGP SIGNATURE-----

--u50q5P9j+i2geIXl--
