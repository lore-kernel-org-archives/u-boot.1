Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA7A1098792
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 14:40:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42ED0840A9;
	Fri, 20 Mar 2026 15:38:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YJamTW0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A175883E36; Fri, 20 Mar 2026 15:16:31 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8247083CEA
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 15:16:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-467161c4b7aso1041472b6e.1
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 07:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774016187; x=1774620987; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QxbNTc5mMplZcbavtjSP4anFLtC2CdhNaxgJc1xM9+w=;
 b=YJamTW0+MklrP2nyHRj4pxWZDRpaSg29K2h7oGV5uTblo/v5AoaO+a24V4IoJz1w0/
 zr7sb4YMXTV5MNWspE0T5vLtmXggLIf4Ci+Pfksi9OyUQSC2kWPIF9Bc0asWtNnqNoyR
 bzSOAYvWyBXN28E6/EJ7DZWOwbEr79y13jS5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774016187; x=1774620987;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QxbNTc5mMplZcbavtjSP4anFLtC2CdhNaxgJc1xM9+w=;
 b=O+X8igpv1XhPYGQog9/3rm8MOa45BhdEdqpVjB8qTCtf+qfOTiJfKb4gebGCgO6rbU
 NvokPEFM0+gVhOy9X/yyLvYXnlTPocydkI7EIYw3m8JEGVCn93YMCOrVWI0i7DIMoK/r
 SHAcFeHy9tNuuMC17ZAjdakP3QDfIhwgmSzRP9aPgOBdxvthm2WQ1yL9Hpp2BazQEBQC
 wwx8MLa9nBK6IfBfJRDQrfj4lyE9YtNjrFK/N7ylNgxYrhelQYt/dC2wBYVDxFgHf8G+
 bFOqSmv+WopstxXs2+GoSQT6Q3XAoi7COOH4of6u4bDoH6i+pZkPIHO3/fGuetO59G+O
 1Ntw==
X-Gm-Message-State: AOJu0YxCVnDXrpkPvVoLfeMuq44GfUvVFzbfRiWORdJQqlWlX42fXgAo
 1mPZOIjo5L409kDfiG63D1JRwkU01bd+tSPIc6E8PYruFYSeW1rH7c4piFnJWaMbAcU=
X-Gm-Gg: ATEYQzzmqFt5TfwdSyYahwv43wjNcpS3bCu3NqFBKuohjTfNwlGGKVblQXPNQVSgPEC
 9+Ru5LVpP3EhD58YdXtamcUeNDqOQYzTodzjnV+1PM/Oea3aiWHWJwzXlJwBS8z2WsWof9AWtFQ
 xJba4j0+BM0x4bYRbV6Gc9LPr0nBc9Zc6W16dddjZx0CsJm/QaGYLrfFU5wudnmWVcIQJOo0M3o
 /WerOux5zzLx+AgJiFMrLLVPmpt/UCJmEpexONt39PshJ71ACgZ9uJB8+EV2spOWl0CPi3iSDdu
 9UIzvmInd/P78xIRCnEOSfWf7lQmNJ6LUnrHWsT7ARKCAZMb2VI+jp7D7j0/QS7kJnVQ9oq37Iz
 516ypvUDe66/Lz96whuEXU5WBJDUSyniDS1k7Y4qcz5bW1xGjgFgGo7OPhbWt08WiaDW/Mq9Q6a
 yjaTDifPAUwLuH3Ag6yau6vGiBYbHkdU9VilJYzyvUASSghVcg6z8QH5pOMWMF+/iV5EGrlE7OB
 4b86c8mZi7K/ZPz7/2IExkxHtfrc5/vqT6imZU9AA+YXIVZ
X-Received: by 2002:a05:6808:c2c6:b0:467:155f:8c2b with SMTP id
 5614622812f47-467e7466b1cmr1550366b6e.50.1774016187112; 
 Fri, 20 Mar 2026 07:16:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-467e7ecb7f7sm1249887b6e.9.2026.03.20.07.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 07:16:26 -0700 (PDT)
Date: Fri, 20 Mar 2026 08:16:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Brian Sune <briansune@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Fabio Estevam <festevam@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 George McCollister <george.mccollister@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Jim Liu <JJLIU0@nuvoton.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Ryder Lee <ryder.lee@mediatek.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Stanley Chu <yschu@nuvoton.com>, Stefan Bosch <stefan_b@posteo.net>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [RFC PATCH 00/15] RFC: dm: Add uclass adjunct support
Message-ID: <20260320141622.GA502704@bill-the-cat>
References: <20260319213551.267031-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u5rqQoDzcUdFGC5I"
Content-Disposition: inline
In-Reply-To: <20260319213551.267031-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Fri, 20 Mar 2026 15:38:51 +0100
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


--u5rqQoDzcUdFGC5I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 03:35:30PM -0600, Simon Glass wrote:

[snip]
> Note that a couple of linker-list fixes are included so that sandbox
> will start up correctly. It still does not pass all tests though, due to
> various bugs surfaced by this series. If we go ahead, we will need at
> least one precursor series to resolve these pre-existing problems.

I assume that the first two, linker-list, patches pass CI on their own.
Since we hit those issues as part of lwIP development, can you please
just post them on their own so they can be merged soon? Thanks.

--=20
Tom

--u5rqQoDzcUdFGC5I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCab1WsgAKCRAr4qD1Cr/k
Ch15AP9JZcysi5wJoK6V6ZELU4ESfvge/SjSkIkvtHswEisj6QD/RZtewGlxDdIx
AIuq0ZiQxA5PmF5kPw51k61YJvNaLg0=
=gvbX
-----END PGP SIGNATURE-----

--u5rqQoDzcUdFGC5I--
