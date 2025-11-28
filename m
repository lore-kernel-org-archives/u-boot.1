Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBA5CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:28:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E11BF83B2C;
	Fri, 28 Nov 2025 17:28:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z9vynWoj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEC048457A; Fri, 28 Nov 2025 15:31:56 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D114584564
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 15:31:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-657509d761dso928573eaf.0
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 06:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764340308; x=1764945108; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/+/rt3J9PtNOlaRLlus8Duc0vrVUVCYLcLd1qgOfwjg=;
 b=Z9vynWojhhNaxPfBgoqnC2AbqGEErm1PyoLRQFKsYcgtvIc4iwUhJ5vbbmpuNFB0mm
 TZd2Asmzf0IR8lZEWK5TaxGTyBE/ZUqgSoYjIj3aiseI9MDvamx34W0NoUciOvKnNJFs
 6jDvjeHnlH3N+yz5sOGjl8qU7eyfXqLfBzXZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764340308; x=1764945108;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/+/rt3J9PtNOlaRLlus8Duc0vrVUVCYLcLd1qgOfwjg=;
 b=eBbhBBwJizNIrPZOCRH2MqKqDCAitTYAEJDnRxwZHSivB1HugNRY/RhudNjd9Ew3Xf
 QzhewAisQUxke/yPpUAtBWkf7dEvwHSzYWt6PQ3Tx7/ddngRrEfGxkNmFNaTyZ0ph+AK
 lfZ61rPOj7+DcT1AVeWS4aXWrNUGY9IBSSacpK5EsOK++BfXz1/TXjE8uh4d+pe3S5mN
 JvPEHRjEERa4ZvnNaU2u96g9CIvW/icOoWRzEHTGeg3v3EaIZSFSzg5+lpDx2o9gE1yH
 2Uwf8Qwy+MmxsZxWGu59GR4aYAVsUauGHMUQKn4w5tYxEu9HgKw+5xgYVS/h83KQkRN/
 TpsQ==
X-Gm-Message-State: AOJu0YyCDD1xBLA0ncoT0n8eWwO+ePPIycRbxU2G9ihzekbwItOl/UdX
 +qfK9B656d18SpEvqI9DZ5AVLFJ3TMFoorCqTB3R3Xan2lJ3GptFsSG4Ji6RvcxCJOg=
X-Gm-Gg: ASbGncugYbMYx8UbMrKVCaUn17tV+ztrUohNMGlUdoyEtnrH2IViU0xTpGIClFFlZCl
 ifrm65fRCEaCaBz7XbxZnvTsfC+UrYKrFOiKFFUZ6rRXgoPAMVCbdJ6jK1NHCZxYGQubv4/3V3s
 9j4MuDJhfXMcgWLqi3X49b6vji9zNo7ceoA2ryWrtQRrX84ImyjJAIRk4BlSX8W27To86urhWOT
 anjPn5kS0CZrSKsZ0uxgBrAGCwkc7CKNPmSOhizrZpxU4uZHUQRMtvlFiA29IejwMoW03VvYnw0
 cr1CreOTlrLhE5dcicTFfFTPWreFnbxw8D0AMSCRgtStOzl/nMUN/0qd9bwBXEOQalGCHuxr3h9
 rh2T96+HOm5M/bQLxT/SojoHK02W4ynz2oZYPJE2y90U+CHXouQkeWRhzipg+KIhOhy7RrWDBvR
 CQD2smGSL3F5DTdgPcIpDVey5jCwMQSJ3/1jMi+aOc7U5CzxiOefjw8mEPo+3J
X-Google-Smtp-Source: AGHT+IF0Pe64u8Ae76cs1P0DjyyaOC+pWgG83YjK7sbmzlek3EOTc1h3bjsulh7VX1JavIbSD7Hq5g==
X-Received: by 2002:a05:6808:19a3:b0:44d:a0ec:d9a5 with SMTP id
 5614622812f47-451159c872fmr11572221b6e.1.1764340308349; 
 Fri, 28 Nov 2025 06:31:48 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45317113578sm1274332b6e.22.2025.11.28.06.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 06:31:47 -0800 (PST)
Date: Fri, 28 Nov 2025 08:31:44 -0600
From: Tom Rini <trini@konsulko.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
 Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>,
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>,
 "Andrew F. Davis" <afd@ti.com>,
 Javier =?iso-8859-1?Q?Mart=EDnez?= Canillas <javier@dowhile0.org>,
 Felix Brack <fb@ltec.ch>, Heiko Schocher <hs@nabladev.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Adam Ford <aford173@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marcin Niestroj <m.niestroj@grinn-global.com>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 Thomas Weber <weber@corscience.de>, Enrico Leto <enrico.leto@siemens.com>,
 "Derald D. Woods" <woods.technical@gmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Niel Fourie <lusus@denx.de>, Parthiban Nallathambi <parthiban@linumiz.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Tomas Peterka <atheiste@seznam.cz>, Anurag Dutta <a-dutta@ti.com>,
 Fabio Estevam <festevam@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH 2/2] clk: ti: omap4-cm: Add Kconfig symbol
Message-ID: <20251128143144.GB2125796@bill-the-cat>
References: <20251128-topic-am33-clk-regmap-dep-v2026-01-v1-0-d722c79506b2@baylibre.com>
 <20251128-topic-am33-clk-regmap-dep-v2026-01-v1-2-d722c79506b2@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4UIV3QjgeduwORQ6"
Content-Disposition: inline
In-Reply-To: <20251128-topic-am33-clk-regmap-dep-v2026-01-v1-2-d722c79506b2@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Fri, 28 Nov 2025 17:28:20 +0100
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


--4UIV3QjgeduwORQ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 11:17:00AM +0100, Markus Schneider-Pargmann (TI.com=
) wrote:

> Add a Kconfig symbol for this stub driver to avoid clock dependencies on
> an architecture symbol. I added the new symbol to all defconfigs that
> would need it.
>=20
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
[snip]
>  49 files changed, 54 insertions(+), 2 deletions(-)
[snip]
> diff --git a/drivers/clk/ti/Kconfig b/drivers/clk/ti/Kconfig
> index 7b8da69712e4fa61c15f3fb0cbdc9f3fd8de31bb..9b6829793fa87c91db3aefac8=
ea9cea8180c2ad3 100644
> --- a/drivers/clk/ti/Kconfig
> +++ b/drivers/clk/ti/Kconfig
> @@ -10,6 +10,12 @@ config CLK_TI_OMAP2PLUS
>  	help
>  	  Common clock functions used in some TI clock drivers.
> =20
> +config CLK_TI_OMAP4_CM
> +	bool "TI OMAP4 clock manager driver"
> +	depends on CLK && ARCH_OMAP2PLUS
> +	help
> +	  This enables the OMAP4 clock manager (CM) stub driver.
> +
>  config CLK_TI_AM3_DPLL
>  	bool "TI AM33XX Digital Phase-Locked Loop (DPLL) clock drivers"
>  	depends on CLK && OF_CONTROL && ARCH_OMAP2PLUS
> diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
> index 329fae67889b11a9ef3c646b166243abcb956144..74e4329a3430d66c11a3c034f=
1938c0804f4c918 100644
> --- a/drivers/clk/ti/Makefile
> +++ b/drivers/clk/ti/Makefile
> @@ -3,14 +3,13 @@
>  # Copyright (C) 2020 Dario Binacchi <dariobin@libero.it>
>  #
> =20
> -obj-$(CONFIG_ARCH_OMAP2PLUS) +=3D omap4-cm.o
> -
>  obj-$(CONFIG_CLK_TI_AM3_DPLL) +=3D clk-am3-dpll.o clk-am3-dpll-x2.o
>  obj-$(CONFIG_CLK_TI_CTRL) +=3D clk-ctrl.o
>  obj-$(CONFIG_CLK_TI_DIVIDER) +=3D clk-divider.o
>  obj-$(CONFIG_CLK_TI_GATE) +=3D clk-gate.o
>  obj-$(CONFIG_CLK_TI_MUX) +=3D clk-mux.o
>  obj-$(CONFIG_CLK_TI_OMAP2PLUS) +=3D clk.o
> +obj-$(CONFIG_CLK_TI_OMAP4_CM) +=3D omap4-cm.o
>  obj-$(CONFIG_CLK_TI_SCI) +=3D clk-sci.o
>  obj-$(CONFIG_$(PHASE_)CLK_K3_PLL) +=3D clk-k3-pll.o
>  obj-$(CONFIG_$(PHASE_)CLK_K3) +=3D clk-k3.o

Given how the old logic worked, we should default y this new symbol I
think. Thanks.

--=20
Tom

--4UIV3QjgeduwORQ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSmyUAAKCRAr4qD1Cr/k
Co5MAP9uZD2AjoT4Tf6BYsSkHUpa32ztZkQslEuOvUT0/vrAbAEAtLYQM3JgeuSP
GNqfztwzqey/RnQ0wsCHlCyn/c0Ywgg=
=dcUu
-----END PGP SIGNATURE-----

--4UIV3QjgeduwORQ6--
