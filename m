Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC1DF364A6
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 18:13:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EFEE84209;
	Thu,  9 Apr 2026 20:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fRjnDlJs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E44184099; Thu,  9 Apr 2026 18:33:49 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E027083CF5
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 18:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-47018d3416aso669181b6e.3
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 09:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775752425; x=1776357225; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iu0RxmOW3AfW0RO66QNbDTWWuDl7XjOiJ4aWJNZvUDU=;
 b=fRjnDlJs912ctQK/JMcFcblku3rbNuHL9cvXmIoe8dAIT4zOiuAXPqnLyOMUWZaVob
 kDoeHzn7+BrlvT/r9kS/OZA/UcVD9uSokBHwj736retN2nFSNaLwUuZrmG23M9wYMs+/
 bl6fkrGF9VyjqPZXWGObAEcRWkkFw95LBz7lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775752425; x=1776357225;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iu0RxmOW3AfW0RO66QNbDTWWuDl7XjOiJ4aWJNZvUDU=;
 b=hWFFO05YjHp7yejAmFuEPAnHsq9WDO0WtUd/lqKsdSO+ORezZfgrf42ycCmgi11KX6
 eKBM3BKbJqzqtWBqvc5PlwQyrFy4Xf1OxwNNK4v/iBF+16YvbRU2Vz5TsYvmBiC5I7vR
 OrHYK/07lsVfOUdNTIXq7nJK2Hl0bBHMyEzbXgFtNNPEjIRF0wk0iw7gDAA0FfabDQYo
 udRulUMWEK3fDsgwszCG+QxbMqbeX+Nw6pN63EZSobQujytE2Zj1HImUam17fUWHLBp2
 88eU1RSkkK6bks5kqsc+a+rNtCLykQ1xi1baRtQVVxK2uLDts4XzQqPO9Q0IpGBst6QR
 eHJA==
X-Gm-Message-State: AOJu0YyVEiEq0hnzyh5KSHCJDKL+zjhoDw/z/+1+HZc3PimikCr3AER1
 7EWGVHpwDzE/mYrs63g8rlu1tAjDj3zcVBXMvsAqXtPbmJ8rJ6Cs9mOIx60/fWVJJWAWsNa7vUP
 C5GTnExA=
X-Gm-Gg: AeBDievbldRml8YXLKPvX2Pb0kpJI2mwGFcozlBh6gd5BBh1RHzsLGN/aKPtNwxufo7
 xwbeHys/uJ7fIdAjNonJChOCvoSQzx3DqEN2kLf7vL1GImTpg0RU2We/wg36vlRuTLxP2MuzP7F
 /KWr8G8jCNz1EYqR0AF4ZATx+vm8RpPlLO4XkAAN3+VoD1TY8tcAPX+jQIJYHiMKH2sOgEL1YH/
 WYX1YAyvoGa7ENekb9fXITFvryHM1YozW5ec4LIw/RyTtMpq65+WAnnaW/XknW/t88mActb8lSs
 YTD9HaZ7O5TClMY9HdUnjE0Et9TDuKetX7uu6Z9cET2jfwKkBatvdXl8S/+WKplMdtAYV06CYvs
 QDJ1G2IqlO7uIOEy/9ruIq/ODGJEPE3cr6NKOxcAHFqY4VUuP/qh9Bk9c4a4v9Nr+BBz75fHuGU
 1QkuYjtXWMmSUvqS8qF53axhC4wVGHks8/bTXTwhN6QoRHUTR5lGETgUj5ORlczk6vHWo9YkzO+
 x3zSj3fNE0Gm9nCVGSEFFOrr8vUgstZF9Qk6xR0iYIWTn80DqM=
X-Received: by 2002:a05:6808:d4a:b0:45e:f443:dc3d with SMTP id
 5614622812f47-4772238f106mr2373995b6e.13.1775752425492; 
 Thu, 09 Apr 2026 09:33:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddb23b07sm95975fac.12.2026.04.09.09.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 09:33:44 -0700 (PDT)
Date: Thu, 9 Apr 2026 10:33:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Jorge Cisneros <jorge.cisneros@hpe.com>
Cc: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Jean-Marie Verdun <verdun@hpe.com>, Nick Hawkins <nick.hawkins@hpe.com>,
 Casey Connolly <casey.connolly@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tony Dinh <mibodhi@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Shmuel Leib Melamud <smelamud@redhat.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Chen-Yu Tsai <wens@kernel.org>,
 Justin Klaassen <justin@tidylabs.net>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yao Zi <me@ziyao.cc>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Philip Molloy <philip.molloy@analog.com>
Subject: Re: [PATCH 3/9] arm: dts: Add HPE GSC device tree
Message-ID: <20260409163341.GP41863@bill-the-cat>
References: <20260408-hpe-gsc-upstream-v1-0-2be1fb7cbbfc@hpe.com>
 <20260408-hpe-gsc-upstream-v1-3-2be1fb7cbbfc@hpe.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Pue1MnPQeprua7DV"
Content-Disposition: inline
In-Reply-To: <20260408-hpe-gsc-upstream-v1-3-2be1fb7cbbfc@hpe.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 09 Apr 2026 20:12:34 +0200
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


--Pue1MnPQeprua7DV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2026 at 07:24:15PM +0000, Jorge Cisneros wrote:

> Add device tree for the HPE GSC SoC including:
> - Dual Cortex-A35 cores with spin-table enable method
> - GICv3 interrupt controller
> - NS16550A compatible UART
> - GXP timer and SPI/I2C controllers (shared IP blocks)
> - Two Cadence GEM Ethernet MACs with SGMII PHYs
> - Synopsys DWC MSHC eMMC controller
> - GSC watchdog timer
> - Memory-mapped virtual EEPROM for VPD storage
> - Fixed clock definitions for peripheral buses
>=20
> Signed-off-by: Jorge Cisneros <jorge.cisneros@hpe.com>
> ---
>  arch/arm/dts/hpe-gsc.dts | 146 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 146 insertions(+)

What is the status of getting this supported in the upstream kernel?
I do see dts/upstream/src/arm/hpe/hpe-gxp.dtsi for example.  Thanks.

--=20
Tom

--Pue1MnPQeprua7DV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadfU5QAKCRAr4qD1Cr/k
Cj13AQDDiD+DjaolVT05r1mObir0N6y4EpdF3ryFBeFTnSUcKwD+PrHpk4vm/JBc
RidOBE+TzPBs0KGWH00/hQx0UBQnEQs=
=HJYw
-----END PGP SIGNATURE-----

--Pue1MnPQeprua7DV--
