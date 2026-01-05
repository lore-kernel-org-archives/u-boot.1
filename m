Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B958C79F9D
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 15:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54DD783E16;
	Mon,  5 Jan 2026 16:18:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HfwvJAao";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2D9E839DE; Mon,  5 Jan 2026 16:18:24 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 860C3836D3
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 16:18:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3fe3cc80bc3so20526fac.0
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 07:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767626301; x=1768231101; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R5TcLAwe1wXQgrvLG1JeKGSRbDfB+q/vP9FaIvhHUkc=;
 b=HfwvJAaoaECf25DMPq9gybl837xLhkvBtf3STCPtYzO2tjU+fVBMWBVfY3EdJ1/1V4
 DKWaakB75Q/3S5gW+g6Xltlv6W10a/1VZ4xHGvXTplwgDmFN4QnUto4indfCmwYocVAl
 Q7a2ekZS63z52WCkDuDvvrpIuqWEawKt/kBOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767626301; x=1768231101;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R5TcLAwe1wXQgrvLG1JeKGSRbDfB+q/vP9FaIvhHUkc=;
 b=Wpc2sYcktRV5Z0HlY/YF/5wLXlCt0ejpSS7qauAJSN9sb1YMTuRl21MBz5pcuTtCGy
 KF1m1NdyDdNwPi1RsUwH2I4apsuRJRaRs6g3NZrGuv7as4kTtk2CjVvjfDay7PUtWfC6
 Y3mR8OULrrGyvxhUpvliYM1nkjmCPGMr+guZK6SthADGAJURvHBM0ieWDbdqZ/zBXsCr
 OTJ9mVWkaDK/NNDbGOCTqezrv/z85p4lzkjIjzkqehCD104tO8E5QNo1vrLqNN1TYBRS
 Pz622qZtwYq+JLctVVstm0bcP22X8eivpHa6L38iMPOrChIwYo7ExtSUvFg0bUX9KIJ8
 LWZQ==
X-Gm-Message-State: AOJu0YwpGAkDFXEaX1pxDQDPWswywpapl2ZsDnW+QtDw7PTH1LOEKaQb
 uZy/oeXcEiAvcjmIyQ+5GSIP/GuPuFGlimCLW2kkSFw7SY0z8OstkzBZuGB1TjhYKGg=
X-Gm-Gg: AY/fxX7WOMluZ8Dppc7TAL/yENrqrZJ58YzsxAKQt0vByPZS3qcWdpleP2alufPdIP9
 lnlC1ij/ousxQ54BiCEbg74c0xho2RO303NXHfoM/Uu7afC7Hzvto2ZgKjOoncfN5fwi+J8YMzm
 0lt2uaE1JfgO3LVBCHFXOm0oS4ty0rSKq9pSBw7j4XSkP1PiqV7agYc1ybJ6NNA93eZAvEVwEGf
 y7DQhU6DNdw9jhNUKeSHGVyejHX275d01P6LTV29FxfJ/DfGf8XS6vdMY87h4Aiubavdk4xlxsj
 3zPTk0mRsF6IqzJ4x5pRL5G1vYCMvqs7e1oWmwy6p/FptOP9uVcwBVUHImtFVdCa39CVb0XznTd
 xCn8dP1jCnbaYWD8w4mgcc4BhCtVcHYwxMkkd80DhwUK0QK5I5ibUmoG5lhzj3H4u/mQe0iu1gQ
 H+JKtU4aUOLbX51xagxk2qLr4LpCPh051Ci6K/YKMmZQ5hNQzNtRHmrP15iAQ2VGxcydwgOXPoo
 1VDvlx0rdzFs3SrnONrgyKl3xRLNevt88uQxY3AYd88AkY3Ww==
X-Google-Smtp-Source: AGHT+IEg9TmZLYEl8+s7ZnP55RGgbYeC2ZexF+phf/UGTBc8jQ9uJwp9Us/bJ8PPN8/kaOMC0WGAEA==
X-Received: by 2002:a05:6870:f112:b0:3e0:df48:d5df with SMTP id
 586e51a60fabf-3fda53d1f18mr25137014fac.34.1767626301125; 
 Mon, 05 Jan 2026 07:18:21 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa8d44fdsm29722532fac.3.2026.01.05.07.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 07:18:20 -0800 (PST)
Date: Mon, 5 Jan 2026 09:18:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@gmail.com>
Cc: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Yao Zi <me@ziyao.cc>, Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heiko Schocher <hs@nabladev.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Xuhui Lin <xuhui.lin@rock-chips.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Johan Jonker <jbx6244@gmail.com>, Dhruva Gole <d-gole@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Huan Zhou <me@per1cycle.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Finley Xiao <finley.xiao@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>
Subject: Re: [PATCH v2 1/3] spl: Make UFS available for SPL builds
Message-ID: <20260105151816.GM6124@bill-the-cat>
References: <20260105-rk3576-ufs-v2-0-caba979a0d6b@gmail.com>
 <20260105-rk3576-ufs-v2-1-caba979a0d6b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s1R33QbwoX81Y31b"
Content-Disposition: inline
In-Reply-To: <20260105-rk3576-ufs-v2-1-caba979a0d6b@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Mon, 05 Jan 2026 16:18:31 +0100
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


--s1R33QbwoX81Y31b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2026 at 07:05:36PM +0400, Alexey Charkov wrote:

> Add minimal infrastructure to build SPL images with support for UFS
> storage devices. This also pulls in SCSI support and charset functions,
> which are dependencies of the UFS code.
>=20
> With this, only a fixed offset is supported for loading the next image,
> which should be specified in CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR as the
> number of 4096-byte sectors into the UFS block device.
>=20
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
[snip]
> +config SPL_UFS_SUPPORT
> +	bool "Support loading from UFS"
> +	select SPL_LOAD_BLOCK
> +	help
> +	  Enable support for UFS in SPL. This allows
> +	  use of UFS devices such as hard drives and flash drivers for
> +	  loading U-Boot.
> +
> +config SPL_UFS_BOUNCE_BUF
> +	bool "Use a bounce buffer for UFS loading"
> +	depends on SPL_UFS_SUPPORT
> +	default y if ARCH_ROCKCHIP
> +	help
> +	  On some platforms the UFS host controller may be unable to load all
> +	  image segments directly to their required memory locations (e.g. due
> +	  to DMA constraints). This option enables an interim bounce buffer in
> +	  system RAM to let such platforms boot directly from UFS, at a cost of
> +	  an additional memory move while loading the image.

So, the full U-Boot rockchip UFS driver does not use the generic
BOUNCE_BUFFER mechanism. Is this because of memory constraints in SPL?
Second, can we not just re-use the generic bounce buffer code
(common/bouncebuf.c) ? Thanks.

--=20
Tom

--s1R33QbwoX81Y31b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVvWNAAKCRAr4qD1Cr/k
CuTOAP4y7muWIandoALM1G6x0W0dam0UBhrmMKsyvd2ayOP6qAD/fgNNEy+PV4xQ
KUr8v0gB7ph4+F2FN6nrrV9/9hlB0Q8=
=myl/
-----END PGP SIGNATURE-----

--s1R33QbwoX81Y31b--
