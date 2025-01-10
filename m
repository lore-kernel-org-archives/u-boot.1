Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5F2E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 15:44:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 208348036B;
	Fri, 10 Jan 2025 16:44:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VKCojNE3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77433805E9; Fri, 10 Jan 2025 16:44:40 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D06F6801F5
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:44:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b6eeff1fdfso181569185a.2
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 07:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736523876; x=1737128676; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MAjqd/Q3H1PVYgmlKUePsNqSnOZ5B8hYyKfsbpAaBnE=;
 b=VKCojNE3zNIw5rUG8mDULbGGrOpxAUhPRCQYbY5bxZGQDmFsnkvsAqV9kTKgHAE5RE
 2nBeFAuDZGxw9DjxJx2fXx9KbN22JtG7Upo3Q/bGCt+egcisD1YcTFYjPdsS0B0ka/WD
 y/XqqavXFFZhBR0WsNoJ3nG8NvFW6+rtvVjCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736523876; x=1737128676;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MAjqd/Q3H1PVYgmlKUePsNqSnOZ5B8hYyKfsbpAaBnE=;
 b=MRGuEyV6jJTPcXlP8il/tcljA1NrkfQ9DbnasG/Czb5z1J56hxvN19HLBAJs+jL+Hm
 Lu89asonvyJtviGluBreCfEYHUP96ZPp0yOVtCqdSy6LWm/n5xo2gbyxqEkd8ypEF3Lf
 +SLrvy6IVmcrTzzcgPBXy/Dqa9ywXeSstfWY60OWs42UvbTNd27t84mKsPLGhmsejWRv
 97Fb9ZJGM8rcfEk+eVQfBL14PooxFwsR+5ABFvdtJrWTBesOmcRsPzcbW8JCpcsRnJ6y
 yoxRx0XZGxucgP1B66gGK9TFQepYMjhHVmAtC57Ya9k+AjDyWlEPJ4Dfmz/d3QZ5rHTv
 au/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW64z2T4wgGJMGQR6pn31FBT56p5B9KXINzztnwCWBQWdWjzieswiWUzf3gv1Ku3XwpS7DVR8k=@lists.denx.de
X-Gm-Message-State: AOJu0Yxnt9Q/RqZen4qxwGAxEKEfaS5C98sCLikL/MYKvR9DLouUqQvl
 8tQWecBzMAh1J+pUDmEElSdX0Q6EcBaNLiRSshazW2BU9S5ZXQ8U1xJja/cmT7Y=
X-Gm-Gg: ASbGncvklyOgHa8VGQN/NBcm7+Xr/Y6pMEssOJ+08xuJyk85FkwqMgKxNb3FxentnLG
 DY3hoiqIAEo7zcgtpZFDPJfYv8BD+Q/PA9/+ls6ywFUHenjD8tsPU+/BtPycrVJ7hsOJEffBDzr
 nUjlJLv2/0AArhA7HsReT+My6xSqlSmF9+8wFHvTXwZ92vrgl1zzyU+pXzQSTrbhwwxG//NY8jN
 ubcxjLgcPiSxnm1mvKsLoke+aHseBq8maa4XfsrRpTFrZw6nfJVkaI=
X-Google-Smtp-Source: AGHT+IGKpgse72D5qtoYlamC4hLPHIE6FKea2ynle06blmZL4M4QQyCg3DxmTdhWTS1BRX7sgF4uTg==
X-Received: by 2002:a05:620a:25cd:b0:7b6:de65:9ee7 with SMTP id
 af79cd13be357-7bcd97ae12fmr1721267485a.43.1736523876616; 
 Fri, 10 Jan 2025 07:44:36 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad85f658sm10348546d6.5.2025.01.10.07.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 07:44:35 -0800 (PST)
Date: Fri, 10 Jan 2025 09:44:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 00/12] rockchip: rk3399: Migrate to use TPL on bob and
 kevin
Message-ID: <20250110154433.GG3476@bill-the-cat>
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <CAFLszTg=UkyZc7qUmgNSv06Sm8vXgS62mHMczH9wudFX1jqHdA@mail.gmail.com>
 <2631e34e-2fd0-45f4-aa4b-0e7405808301@kwiboo.se>
 <20241220162933.GG1505244@bill-the-cat>
 <88fee4f7-944a-409f-9b9d-b2fa03ed904c@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OttbCKi7N6Yimwdl"
Content-Disposition: inline
In-Reply-To: <88fee4f7-944a-409f-9b9d-b2fa03ed904c@rock-chips.com>
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


--OttbCKi7N6Yimwdl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 03:09:33PM +0800, Kever Yang wrote:
> Hi Tom,
>=20
> On 2024/12/21 00:29, Tom Rini wrote:
> > On Fri, Dec 20, 2024 at 05:22:28PM +0100, Jonas Karlman wrote:
> > > Hi Simon,
> > >=20
> > > On 2024-12-13 04:09, Simon Glass wrote:
> > > > Hi Jonas,
> > > >=20
> > > > On Thu, 12 Dec 2024 at 16:57, Jonas Karlman <jonas@kwiboo.se> wrote:
> > > > > This is a continuation of an RFC [1] sent back in August.
> > > > >=20
> > > > > All Rockchip aarch64 boards, beside bob and kevin, use TPL to ini=
tialize
> > > > > DRAM and SPL to load FIT with U-Boot proper and TF-A.
> > > > >=20
> > > > > Bob and kevin currently does not use TPL and instead initialize D=
RAM
> > > > > in SPL and directly after tries to load a FIT with only U-Boot pr=
oper.
> > > > >=20
> > > > > This series migrate bob and kevin to also use TPL to uniform TPL/=
SPL use
> > > > > for all Rockchip aarch64 boards.
> > > > >=20
> > > > > Features and changes in this series:
> > > > > - Use of Rockchip aarch64 common bss and stack addresses
> > > > > - SHA256 checksum/signature check of FIT images in SPL
> > > > > - Use of dcache to speed up checksum check in SPL
> > > > > - SDMA use for eMMC access to speed up read/write in U-Boot proper
> > > > > - FIT location moved from 0x40000 to 0xE0000 in SPI flash
> > > > >=20
> > > > > Changes sinc RFC:
> > > > > - Include pinctrl props and enable regulators based on DT in SPL
> > > > > - Drop bob and kevin board specific code from common rk3399.c
> > > > >=20
> > > > > Please note that I do not have any bob or kevin so this has only =
been
> > > > > compile tested and the original RFC [1] was runtime tested by Sim=
on.
> > > > >=20
> > > > > [1] https://patchwork.ozlabs.org/patch/1967517/
> > > > >=20
> > > > > Jonas Karlman (12):
> > > > >    rockchip: rk3399: Fix TPL build of bob and kevin
> > > > >    rockchip: rk3399-gru: Use SYS_SPI_U_BOOT_OFFS value in offset =
prop
> > > > >    rockchip: rk3399-gru: Move SPI flash payload offset for bob an=
d kevin
> > > > >    rockchip: rk3399-gru: Fix include of TPL in u-boot.rom image
> > > > >    rockchip: rk3399-gru: Use TPL with common bss and stack addres=
ses
> > > > >    rockchip: rk3399-gru: Include binman generated FIT in u-boot.r=
om image
> > > > >    rockchip: rk3399: Drop common Kconfig options already implied
> > > > >    rockchip: rk3399-gru: Remove unused nodes from xPL control FDT
> > > > >    rockchip: rk3399-gru: Enable dcache and signature validation i=
n SPL
> > > > >    rockchip: rk3399-gru: Use SDMA mode to read from eMMC
> > > > >    rockchip: rk3399-gru: Include pinctrl and regulators in SPL
> > > > >    rockchip: rk3399: Drop unneeded bob and kevin board specific c=
ode
> > > > >=20
> > > > >   arch/arm/dts/rk3399-gru-u-boot.dtsi    | 29 +++++++++++++++++++=
+++++--
> > > > >   arch/arm/dts/rk3399-u-boot.dtsi        | 14 +++++++++++--
> > > > >   arch/arm/mach-rockchip/rk3399/Kconfig  | 12 -----------
> > > > >   arch/arm/mach-rockchip/rk3399/rk3399.c | 23 +-------------------
> > > > >   configs/chromebook_bob_defconfig       | 23 ++++++--------------
> > > > >   configs/chromebook_kevin_defconfig     | 23 ++++++--------------
> > > > >   6 files changed, 52 insertions(+), 72 deletions(-)
> > > > Thank you for doing this!
> > > >=20
> > > > I'm not sure if you have access to your own denx tree. If so, kevin
> > > > and bob are in the sjg lab. If not, you can sign up at sjg.u-boot.o=
rg
> > > > to get access to my tree.
> > > I do not have access to my own tree.
> > >=20
> > > > This series eems to work for me, except for the final commit, which
> > > > hangs with no output.
> > > Strange, guess we can just skip the last patch, should I send a v2
> > > without the last patch?
> > >=20
> > > I wonder if it is not setting io_vsel or the regulators that is causi=
ng
> > > an issue. Setting io_vsel is probably delayed until U-Boot proper
> > > instead of being set very early in SPL (due to no IO-domain driver in
> > > SPL), and enable of regulators may happen later in SPL with the last
> > > patch applied.
> > >=20
> > > There is also some code in board/google/gru/gru.c that mention a delay
> > > related to the regulators may be needed, however board_early_init_f()=
 is
> > > never called as following can be found in .config:
> > >=20
> > >    # CONFIG_BOARD_EARLY_INIT_F is not set
> > >=20
> > > Will you be able to test with just the rk_setreg(&grf->io_vsel, 1 << =
0);
> > > and remove the spl_gpio_output/set_pull parts of the last patch befor=
e I
> > > send a v2?
> > If you send a v2, please include disabling TPL_BLOBLIST and then the
> > boards should boot in mainline as well as Simon's tree. Thanks!
> Do you mean add below code in configs/chromebook_bob_defconfig and
> configs/chromebook_kevin_defconfig will make this patch set available?
> =A0# CONFIG_TPL_BLOBLIST is not set
> If yes, then I can do that when apply the patches.

Yes, thanks!

--=20
Tom

--OttbCKi7N6Yimwdl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeBQFUACgkQFHw5/5Y0
tyxtkAv9G1LYTyfb4aN8aMgWJhl9Lo8zb0o4R4ZtIqfDIH3v2nSnbSy7YxDh+x5r
5Q9y3hro37q0cb8wxNWWZp2D8LHY2mo8m+AvTaa57WgJQPrG1qNAREVOxIqGrPPS
nRltbIB1KoS8qCRLjIPzVQsa0KTb0qs2IB4smDBHOR4FJ8umeW1NN9gTdiJEhakP
kf1Q1TBDZ5hUlgJNxVri/Vj/4Q+MAGMOAq1tPgMFZi34FR4mUoARlw4e0Hg+O8HW
vR1nOoRNFfHl0Y3ZMIyekJIPrdRWg8IOU0k+JJwvnD9xgFwbPxp+5haS+ZXjl+ij
LpruxIliN8GPGMv23WMvy7DMu3NmGj+IY7i2AXGHwo3NC7CsvjNyeal9l2huzaKT
XZ2SBNo+4rSlJd45BRvBXz35nuBFrcCpWViOQv0xRSg6QW6kH4r6IqAs/XsJQm/r
Nus5gHsWimBxTRhreNLEErzJF8FTSW4oOmIx0TKgBtjO7bQOFO1/4WxiyzlAj9sY
Ut5BWhuL
=YQMG
-----END PGP SIGNATURE-----

--OttbCKi7N6Yimwdl--
