Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56EFF364AB
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 18:14:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53B9C8421A;
	Thu,  9 Apr 2026 20:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tEOlEoQ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15B1984099; Thu,  9 Apr 2026 18:34:12 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7CAA83CF5
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 18:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-415e568a7ecso411450fac.0
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 09:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775752448; x=1776357248; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PdrIZF8Q64iwZ6utWil5Nr8xqvULJXBOj3XZtHXf2e8=;
 b=tEOlEoQ3ea7PFpM0BER3kKXF0eQon5saWLr/mvmkAp6LnZpAYTtoSdTCzUFcizFYbS
 wQzRiOM3fK/HtXJ9dnHgi8FcimDiC+heFSt7vDEBJhJLjMgT35nS+aIEfW4L5OAabdiI
 vlHFwUXxSfnAS2/dGRyMzn23xnPTz5X/26JI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775752448; x=1776357248;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PdrIZF8Q64iwZ6utWil5Nr8xqvULJXBOj3XZtHXf2e8=;
 b=nCbn3gfUHMye4rOsv1HnoT62dM6YnyyHmIPDlsWWqgVU6N28bwn/Ijdux5DTtIz+/W
 yugWyV4ThhwK+l6leYR7Rg0XMr+IGK51xkcMw+72YR45PlWmKWac9OQD5omjN4LJfz6L
 b8wp0mPNA/LawtzdYaXEO56/kNcW72Bkg5JFYqB55eSSHVkOGLtwFXu8GLOdPrI88Hnz
 mdfxyAmJe8RaTnuvede+rp5rW+U4mqM4X3Z+VRVCCJPqHRYUfXgg5wi50v40R5vNFXxU
 ZmP27isnCElwl3uYRiQ1IB49zREyiOowY1foCxLXK4Ur6wkfcquQkf0zXlr9e1LEz7m6
 Vbyw==
X-Gm-Message-State: AOJu0Yx0Z0MU0h4SVx/cBEWrxoN4ZPBbu20rA9JpXeYIXWMBXu6rnLrH
 TSgPUFeZFNLrIjIs6upmY9Hq3yEK2Mex9TZ2hbx+47lV4uTgqRLYf6AWvInbEL/n0MU=
X-Gm-Gg: AeBDievfMwRcFvgzNLgozi1gxYzBzWa3xR+yhCiOncKPEmAGiqFJjB8ISIyeo3/t3oN
 mFVuMW2YWji8Z6QvoTYe7dRq8A8l9ejzJ4myWrTCIOZVHqOR7GLjbTYK2RkX/o2ThxDT/dHJCwq
 PIo9GRG8bMnrK6U7+R/W/+9QqyuuUX2L55RWI7ygOHQafWO5cl20u3US5BxvamUjlL0arjDBBPD
 XX9J8CjaUpqD9HAbHN3DIWmclIDi0TwG+KVTbEFPpOoIVG1cS40dPH7iGRORXFcmRDSYO7BPSBP
 7rGeOocUv61DcNVOXNKrDuPC5Pl5KHrLarvMFgo0rqWcv6fNLhoHzVJhsKC7IlRfLKeJb64vRNQ
 sb2XL/aJdZwsiWC/U4DBrDR+sf4fgQWxij5qftt2cTSufGIHSNvdPi4N+KmnNPEGAQ7B7dA1zsh
 6KqvFsPtk3hoXQ8fI5JYBUmF1Yz5EXGkqX11uyDQCOPDDi7ts8hk5lnrs/7pWqapwHSItgp8kC3
 9gFmoEQYJEBiSrx2DUqGq0gexmDb08Z3KVqFLizg5GbPpr7ILgg1KrHtSPVKA==
X-Received: by 2002:a05:6808:c1ee:b0:474:b050:bf5d with SMTP id
 5614622812f47-47724489c42mr1957220b6e.43.1775752448396; 
 Thu, 09 Apr 2026 09:34:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-476bb506178sm2570442b6e.10.2026.04.09.09.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 09:34:07 -0700 (PDT)
Date: Thu, 9 Apr 2026 10:34:04 -0600
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
Subject: Re: [PATCH 7/9] board: hpe: Add GSC board support
Message-ID: <20260409163404.GQ41863@bill-the-cat>
References: <20260408-hpe-gsc-upstream-v1-0-2be1fb7cbbfc@hpe.com>
 <20260408-hpe-gsc-upstream-v1-7-2be1fb7cbbfc@hpe.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="guJEybmWzvla/ba/"
Content-Disposition: inline
In-Reply-To: <20260408-hpe-gsc-upstream-v1-7-2be1fb7cbbfc@hpe.com>
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


--guJEybmWzvla/ba/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2026 at 07:24:19PM +0000, Jorge Cisneros wrote:

> Add board support for the HPE GSC (Gen Server Controller), the BMC
> SoC used in HPE Gen12 ProLiant and Synergy servers.
>=20
> Board files include:
> - gsc_board.c: Board init, DRAM sizing from Denali memory controller,
>   MAC address provisioning from memory-mapped EEPROM, and FDT fixups
>   for network configuration based on CPLD xregisters
> - common-phy.c: Shared Ethernet/DisplayPort PHY initialization with
>   configurable transmitter amplitude and de-emphasis
> - server_id.c: Custom command to read server identification from CPLD
> - gsc.env: Default SPI flash boot environment
> - gsc.h: Board configuration header with GICv3 and spin-table addresses
>=20
> Signed-off-by: Jorge Cisneros <jorge.cisneros@hpe.com>
[snip]
> +int board_init(void)
> +{
> +	return 0;
> +}

I think you can just disable CONFIG_BOARD_INIT in the defconfig instead.

--=20
Tom

--guJEybmWzvla/ba/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadfU/AAKCRAr4qD1Cr/k
Cm8iAP4xGmivRGJYgLdGq70Snnlj0m0YvvtHNmmmGgxS+sNBEAEAvZvJKlkiNbmd
GDbmzXNz8y2LxNa3mEMGeLxP6bP9hg0=
=LP17
-----END PGP SIGNATURE-----

--guJEybmWzvla/ba/--
