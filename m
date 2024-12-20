Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5749DE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 16:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5977E80352;
	Fri, 20 Dec 2024 17:29:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eiSHfcNb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C92980381; Fri, 20 Dec 2024 17:29:41 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9521A80326
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 17:29:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b6e9317a2aso261223885a.0
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 08:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734712177; x=1735316977; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pUGT5Iexhr5PHBjF2XRDZkiZi33ak5t4uOI/q8JSXac=;
 b=eiSHfcNbGxaNuoql669yV0/IxetRZt1jTt7XGKrKC3keuwjzC+au61DbeVplDQzDBG
 xycdWf2wB+mRxpSb1RVNEGs3nnAjaj/fOSKblSW+KMxUJbml1C4vauRfs2Zr2+r8Figo
 +r05HzydAbuy4hdrWYKEpayVx9jDuZjIvfEf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734712177; x=1735316977;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pUGT5Iexhr5PHBjF2XRDZkiZi33ak5t4uOI/q8JSXac=;
 b=VzUOZv5dt4zCxoOU3gkZymFr88S29C4fCGqohw4iFmMgcAVNjrGte2ClwWElic+ps4
 8F0nraCUGebytmckyrn6Ih8JGS+68FEe5qWy3Vx6ui5GJUp2B2B4vkyP5lfTtvt+AcXX
 f2IaLvo9jau2f6iPBHhr8o4M4ddOcLoZLgpK0SSJKE01QC4z9ZYuKEbAfqQmZLYvhGYx
 QqxJEwrddtH2kBQt68e5DvOhbUrZunF+32TfbAe2SvCehcZ8JKJPMnIFqj8gNvZ0Ugvx
 +mZk7J9tVz2Tk6RM9TQX2Fn53qxTB6HGLRkBjYfyQsGVgZ412stJKHurfTRj98GYvnIk
 NYdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqYnFvB4mFxQ1r7CTE+iWE2xArpmf3Y/qmBAm/M8ucQ6+K8nkp4sAgrhIl+MoTrYx6mHytSQM=@lists.denx.de
X-Gm-Message-State: AOJu0YzfFz/NFFhj2/R4lO5+cenJBcXL5wLSu3WXqowog1Zs5WuCWiaR
 BeE0IMnxG/2KwEp4W6cHviEn7tXkAvtUSNOpXyt7OBKLcVVdt1ILoaIoHPdWv1g=
X-Gm-Gg: ASbGncuKmkzgpwWsKHxEeSbm95sKwOITYNlYWU3eVjZ2+50GRFWJJ8y1t5pf2uLg6R3
 fRz4EZjiNY4YoZ2qrGRHuNSA0yhkYvOwb11q4di4GEEutHFy4jFM5RPTKykGSM0fA6xJXFrpkfv
 EQHSSmNxUg4zXJDfswoEffh1Yw3BQzBpiIWQLgIrXbWJfUhZPIAxFWUPDhFKvQsZGn4t91l/nro
 Ogi8mL2i/6wqFu8XhnWSuUqwusssmKpUAtfx7Tm5uW6yCPmSqG/7uTg
X-Google-Smtp-Source: AGHT+IFDccjUpTqZfsAaNCqz7Gl4bqOQ8AfnvYQqhLDD8jCH8HeSBIxuLy4T6Q+wWi1mNaiE7E/bDw==
X-Received: by 2002:a05:6214:482:b0:6d8:e7c9:ffa0 with SMTP id
 6a1803df08f44-6dd155cde22mr150748346d6.19.1734712177352; 
 Fri, 20 Dec 2024 08:29:37 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb4bcsm18344586d6.86.2024.12.20.08.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 08:29:36 -0800 (PST)
Date: Fri, 20 Dec 2024 10:29:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 00/12] rockchip: rk3399: Migrate to use TPL on bob and
 kevin
Message-ID: <20241220162933.GG1505244@bill-the-cat>
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <CAFLszTg=UkyZc7qUmgNSv06Sm8vXgS62mHMczH9wudFX1jqHdA@mail.gmail.com>
 <2631e34e-2fd0-45f4-aa4b-0e7405808301@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RxDfZAczOA6vApJz"
Content-Disposition: inline
In-Reply-To: <2631e34e-2fd0-45f4-aa4b-0e7405808301@kwiboo.se>
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


--RxDfZAczOA6vApJz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 05:22:28PM +0100, Jonas Karlman wrote:
> Hi Simon,
>=20
> On 2024-12-13 04:09, Simon Glass wrote:
> > Hi Jonas,
> >=20
> > On Thu, 12 Dec 2024 at 16:57, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> This is a continuation of an RFC [1] sent back in August.
> >>
> >> All Rockchip aarch64 boards, beside bob and kevin, use TPL to initiali=
ze
> >> DRAM and SPL to load FIT with U-Boot proper and TF-A.
> >>
> >> Bob and kevin currently does not use TPL and instead initialize DRAM
> >> in SPL and directly after tries to load a FIT with only U-Boot proper.
> >>
> >> This series migrate bob and kevin to also use TPL to uniform TPL/SPL u=
se
> >> for all Rockchip aarch64 boards.
> >>
> >> Features and changes in this series:
> >> - Use of Rockchip aarch64 common bss and stack addresses
> >> - SHA256 checksum/signature check of FIT images in SPL
> >> - Use of dcache to speed up checksum check in SPL
> >> - SDMA use for eMMC access to speed up read/write in U-Boot proper
> >> - FIT location moved from 0x40000 to 0xE0000 in SPI flash
> >>
> >> Changes sinc RFC:
> >> - Include pinctrl props and enable regulators based on DT in SPL
> >> - Drop bob and kevin board specific code from common rk3399.c
> >>
> >> Please note that I do not have any bob or kevin so this has only been
> >> compile tested and the original RFC [1] was runtime tested by Simon.
> >>
> >> [1] https://patchwork.ozlabs.org/patch/1967517/
> >>
> >> Jonas Karlman (12):
> >>   rockchip: rk3399: Fix TPL build of bob and kevin
> >>   rockchip: rk3399-gru: Use SYS_SPI_U_BOOT_OFFS value in offset prop
> >>   rockchip: rk3399-gru: Move SPI flash payload offset for bob and kevin
> >>   rockchip: rk3399-gru: Fix include of TPL in u-boot.rom image
> >>   rockchip: rk3399-gru: Use TPL with common bss and stack addresses
> >>   rockchip: rk3399-gru: Include binman generated FIT in u-boot.rom ima=
ge
> >>   rockchip: rk3399: Drop common Kconfig options already implied
> >>   rockchip: rk3399-gru: Remove unused nodes from xPL control FDT
> >>   rockchip: rk3399-gru: Enable dcache and signature validation in SPL
> >>   rockchip: rk3399-gru: Use SDMA mode to read from eMMC
> >>   rockchip: rk3399-gru: Include pinctrl and regulators in SPL
> >>   rockchip: rk3399: Drop unneeded bob and kevin board specific code
> >>
> >>  arch/arm/dts/rk3399-gru-u-boot.dtsi    | 29 ++++++++++++++++++++++++--
> >>  arch/arm/dts/rk3399-u-boot.dtsi        | 14 +++++++++++--
> >>  arch/arm/mach-rockchip/rk3399/Kconfig  | 12 -----------
> >>  arch/arm/mach-rockchip/rk3399/rk3399.c | 23 +-------------------
> >>  configs/chromebook_bob_defconfig       | 23 ++++++--------------
> >>  configs/chromebook_kevin_defconfig     | 23 ++++++--------------
> >>  6 files changed, 52 insertions(+), 72 deletions(-)
> >=20
> > Thank you for doing this!
> >=20
> > I'm not sure if you have access to your own denx tree. If so, kevin
> > and bob are in the sjg lab. If not, you can sign up at sjg.u-boot.org
> > to get access to my tree.
>=20
> I do not have access to my own tree.
>=20
> >=20
> > This series eems to work for me, except for the final commit, which
> > hangs with no output.
>=20
> Strange, guess we can just skip the last patch, should I send a v2
> without the last patch?
>=20
> I wonder if it is not setting io_vsel or the regulators that is causing
> an issue. Setting io_vsel is probably delayed until U-Boot proper
> instead of being set very early in SPL (due to no IO-domain driver in
> SPL), and enable of regulators may happen later in SPL with the last
> patch applied.
>=20
> There is also some code in board/google/gru/gru.c that mention a delay
> related to the regulators may be needed, however board_early_init_f() is
> never called as following can be found in .config:
>=20
>   # CONFIG_BOARD_EARLY_INIT_F is not set
>=20
> Will you be able to test with just the rk_setreg(&grf->io_vsel, 1 << 0);
> and remove the spl_gpio_output/set_pull parts of the last patch before I
> send a v2?

If you send a v2, please include disabling TPL_BLOBLIST and then the
boards should boot in mainline as well as Simon's tree. Thanks!

--=20
Tom

--RxDfZAczOA6vApJz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdlm2YACgkQFHw5/5Y0
tyzp/wv/VjtAxfUUL1WyHAfwOOuI7GBlZ4rgDZSSiYeULG4HfPHDQw/Rl609qKTd
/DSlpqK748AiquFmXd3oaA9D7c0lfKCAPsXW0XLgd+kig6ru5PCoYrqLUTItxGTw
plN/xXW+xhp/I6Leh8ggfSnMQn0MRL3n5SYyEpRP/+EIKo9bnxtRb4Rv5jrqOZ9q
LuxC/nts4tUD2jyUm9lmHSkIyJOytBfkht/PKW5Dy3EuF61ND3E9K3ajtgA74HhW
9k2z+XohSNokVpO87lRb/0VNiQbRkIP1MuInHqaDxS/GOttN+fK9I0yvJH3ZDNsu
rlNdlbBHhqwJ8aRvZ0soTozKvZbHYtRqucjyjLcAcpvIyWmu6n2t4Rcw4y4jluQ1
5ltRSzoDOl5rkPn02/2kw7bGthRDgvxYgSdJMPNx46uYxO95EUmA6BLlkxWDBynF
qTnh9RxrI9ao9el/VyqNACwj/zFrK2pG/XDOywqmT+MvizdNN/jOpJbzL3tLEfjL
ywZyElVr
=xdxh
-----END PGP SIGNATURE-----

--RxDfZAczOA6vApJz--
