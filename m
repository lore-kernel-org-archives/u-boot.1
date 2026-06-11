Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A3FCD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 14:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1DBD8484F;
	Thu, 11 Jun 2026 16:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KTD/tDxd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DD138407D; Thu, 11 Jun 2026 15:50:39 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECF8083FEC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 15:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7e71b2d527dso2455524a34.1
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 06:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781185835; x=1781790635; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UgHGq2Tiy+hF7hq514wIceIeXacyiq1KbCw2rJHCRIA=;
 b=KTD/tDxd3aCSZmsYiJ+GsK/30ATvSe5o9wbRNTCQpThEYf93jyYcuQ63oHoNC8XLq3
 gCiWDt1p/zP1VP6wHXlXMzGocpzZV9ibN43wCZdAXlzazMXfZSosq7L7/68UQ0p4zNtl
 uursndAiBA3B4m+Dl072LuSE9X+k+xn+rYfgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781185835; x=1781790635;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UgHGq2Tiy+hF7hq514wIceIeXacyiq1KbCw2rJHCRIA=;
 b=RB+cbRXv58KMVgUEKvFe2XJfVHdmlfUKfERUnV2UbuKKMDEfalBzGPJS9godzCTRyX
 Xv6UOkPYGva2DB1J+FRiY0C2G+lWibhy5xhSq6zGL1hBisFXBnpaEtl4AOTCP8HD58b4
 St+qxY2izFuhatu1ybUahMqELXyg9QysTPHGuJuxR4ghr0FzpTBlKCt4Ls8zAVWIgpvr
 1C4N6IqsIIeKtLe3XPRXnQoMwvBaa3yQWyVae8omYIZfOVGIlrpp9YJkSxfiFOOriVUf
 Xokv+4y2um/2g7x7AgpRtHKU6MTqooiKmWmLXArmRghSCs9rAdttwzRQTG5Rq2+Yn8Ca
 Z9Sg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2V57ro5FEHJT/2jMj+C8T1wt4SeZt4IoTPaWUd6SVxvrCTqIoiaY4kSnGpEl8E5J+dWQFtA8=@lists.denx.de
X-Gm-Message-State: AOJu0YxyfHBQtru/93TpirSxZS3uhWHp+tJ6VNUHjRY0GpP+PIRwsGi/
 lmyz1p0Rrojywbn/U2VP5uHdGshIKutC69B3UDcEEYFcExQ2IY+Ov+oZmzCNeb3r2tI=
X-Gm-Gg: Acq92OHjUj39C1B5GkZQXlQOmbeza/gd6f7APPMy3PdE0ev+14FJRgELNYTJMO4Q70X
 7Bpw5LNdAP3EP65j+kN5ABd2GlJ9Bqgaj2vSPb91C8PrJ3jd3YYe3a855vlWypDVkYrf7HOivnq
 PFIIzCiz28P7GjlhXEhaSwJKaCiP7pt4DT/Dja1tn34LqPRnZdKcPm4cwEVEBjOu1y6qUPhWUst
 yY7bTgxOtbLEYSyTbUZJtIPji4Qt4FwhlU0gE/Xr+RRX5qFqeN3rImpEbtaTrSAG84+djCIXRkQ
 3dvt4w0nHh/N5tRDKSZ7Xxu9YJuoBa31ZUG7G/PWSpURRonuI/fEkhozi2AVJDnCojvOFAswHnt
 NQkXCRrT5UQwrAlHZoqCOckFg7pcXYAElc/mE/RaNQVadxESDTzbEjIzBehMn5NpY6XEMKkn4aX
 cnHQ/vc6IRRcxpDWGWAXGbypAOWkWy5JW+OcnoQcDp1FND5yjd+S5TtvPvywDJZJ4naM7TY543P
 LsrwmhrsklAcuwbdtQm5Kn8PXL/yyKCt/HJyni1YYluirR/2p9nrHe41W8=
X-Received: by 2002:a05:6830:4c0e:b0:7dc:cdea:7d4 with SMTP id
 46e09a7af769-7e7734a4342mr2247350a34.11.1781185834651; 
 Thu, 11 Jun 2026 06:50:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e774ceddd3sm1308423a34.21.2026.06.11.06.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 06:50:34 -0700 (PDT)
Date: Thu, 11 Jun 2026 07:50:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: BMC-SW <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Lukasz Majewski <lukma@denx.de>,
 ChiaWei Wang <chiawei_wang@aspeedtech.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Peng Fan <peng.fan@nxp.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Brian Sune <briansune@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Hai Pham <hai.pham.ud@renesas.com>, David Lechner <dlechner@baylibre.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Janne Grunau <j@jannau.net>,
 Paul Kocialkowski <contact@paulk.fr>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>
Subject: Re: [PATCH v3 0/5] arm: aspeed: add initial AST2700 SoC support
Message-ID: <20260611135030.GA473203@bill-the-cat>
References: <20260526-ast2700_clk-v3-0-a4cd24c214d6@aspeedtech.com>
 <TY2PPF5CB9A1BE61846EEBD7BD6648BE188F21A2@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <20260610180324.GC382693@bill-the-cat>
 <TY2PPF5CB9A1BE64531124EC1A606FF63FEF21B2@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="figknNfL8PQIf3ty"
Content-Disposition: inline
In-Reply-To: <TY2PPF5CB9A1BE64531124EC1A606FF63FEF21B2@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 11 Jun 2026 16:53:49 +0200
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


--figknNfL8PQIf3ty
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 12:09:45AM +0000, Ryan Chen wrote:
> > Subject: Re: [PATCH v3 0/5] arm: aspeed: add initial AST2700 SoC support
> >=20
> > On Wed, Jun 10, 2026 at 02:17:53AM +0000, Ryan Chen wrote:
> > > Hello Tom,
> > > 	Will this AST2700 SoC patch series can been merged?
> >=20
> > I expect to take v3 in to the next branch somewhat soon, thanks for your
> > patience.
> >=20
> Thanks for the update. I appreciate your help and will wait for the v3 se=
ries
> to be taken into the next branch.


This currently fails to build in the next branch:
+drivers/spi/spi-aspeed-smc.c: In function 'ast2400_spi_segment_start':
+drivers/spi/spi-aspeed-smc.c:127:24: error: cast from pointer to integer o=
f different size [-Werror=3Dpointer-to-int-cast]
+  127 |                 return (u32)plat->ahb_base;
+      |

And many more, please look, thanks.

--=20
Tom

--figknNfL8PQIf3ty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaiq9IwAKCRAr4qD1Cr/k
CpFdAP4yZp5vqO6o0gvsYCiN5m2AUBq6W9E9wFqfMpqUvXxxcwEAogtq08V6TYdA
pkt56b9gW2VyIlfR54Z8xPgUEKRNFwg=
=ie7q
-----END PGP SIGNATURE-----

--figknNfL8PQIf3ty--
