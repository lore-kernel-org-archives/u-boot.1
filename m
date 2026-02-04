Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BD4EA794A
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 23:36:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3119383015;
	Thu,  5 Feb 2026 00:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B29aJSmo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 003C4838FA; Thu,  5 Feb 2026 00:35:57 +0100 (CET)
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45B758063E
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 00:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc43.google.com with SMTP id
 006d021491bc7-662f5c5507cso284697eaf.3
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 15:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770248154; x=1770852954; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H4MrFUMVhKPt8mm5bZaA0VFVI3DCbsr1XNhQtOqu78A=;
 b=B29aJSmoowwV0LHLfi+EsKon4H1vIWvAH4ropt0dWFiD9uZQrX1h5prsPT4XuWWhUg
 VgDbl4xPMMnW1l+PksKKzX8wHmSJ4lDh8Wv8GjrinmvtoqsNBrPjOXnkaQZBRTLPkoX+
 4Aldf8bxEifk+agHU8n6Oi4nEP6tu+x/8elR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770248154; x=1770852954;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=H4MrFUMVhKPt8mm5bZaA0VFVI3DCbsr1XNhQtOqu78A=;
 b=rg80DQbaXUaDz3avv2Mw8IlTtCh7TBfnPTbuGVU5MqDgaMOn+6sYobjSrDpqWFmHmt
 YZxXgD+qDZPu6NWwnewb+JNBZK8dNoGAygg5AUL6GvfdnNiuInr5KmwZ/ac4bTnNaXyH
 UITVlpuu1vuEqynA9PdmulUbO00N8GesQcJKB1Jnykv41uNna2Wy2dnYbLKU+3f3wiNV
 75dXXkh+lp3za5CbzUeBthTXWM6vQ0en1fEfN4s1LW7+zm05hXLdr/vICcVAWXp2jc6+
 Hojjh6brm0FXIBHFNeT2wG9GgJhwS2OtrE3CRN81PN5M28eNWL5j0QRyoYi+08GH+J1O
 xVfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYanxMEzHLqvv7hEk3pUbqFIkWxvD1KNyp4DSiYwPsHbMcXBAZ1Vfe5FuCFvyYtbY9b3/zvsU=@lists.denx.de
X-Gm-Message-State: AOJu0Ywlrwq5Ke7wVHTq6LJiuUXv3fmsKP0RbnBmwb2jNU8W+VQIJMHw
 fF+IiBgC9CIVbLOJ7UWuCNV5SJ//ewOR7YN5uXVx230uS6Az5JpStuezp2kbnKwLWm8=
X-Gm-Gg: AZuq6aIWMPRure9xUO+YOIrjlyVmMEaxRGUqWCUhYVhOYBI0vk0XkmT+fWjeUFtvhDE
 mmVTY8u38TkTjIAOIAF4HEZJMHQ0e3J5m2E8QWA9v7n2qJKME3iJikS7J5N3W0bDg2wlhkei4HB
 4zfgY6JxNhF/p3Tsbt5Tao9shRfePg3NFUmnAlrgMjktEvAglliwv5sJRxqxZDkBw0REU2gxRxV
 CZRLm2BBlnbEColVJca09cqQJ9Jj07ijJbpvn2n7amENYzPVbu/V049NT6U0iuaPO0HrZTB5ogd
 Jt0AHKpsJitx2qWdZ46hdUQjhhbPZ5aFGcxUTg0D/OVsJm2J59LMqqIdont4m6dFO7mTcIQRX6r
 YbUaWB5vlLMRV33vHKPaVPZN76nEz+72Mv5HGVX9Pwm7G5OA/Chv+BmEA6Or7nCCr6MA+rhpnS2
 2PIjTD1ZgzrqifvUsdywmzAS+JPOblFNnoeVHSHgmXuIso3ikUuSaEivVAaycxINI7T66mDRm53
 XqG+NZmkEFCnPV3vOY5E/k8PDTy8wq0xKwudf0=
X-Received: by 2002:a05:6820:1ca0:b0:65d:1697:e6cc with SMTP id
 006d021491bc7-66a2342d4e9mr2172723eaf.60.1770248153867; 
 Wed, 04 Feb 2026 15:35:53 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66a35a94a3asm1949892eaf.14.2026.02.04.15.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 15:35:53 -0800 (PST)
Date: Wed, 4 Feb 2026 17:35:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Phil Sutter <phil@nwl.cc>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, Joel Stanley <joel@jms.id.au>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
Message-ID: <20260204233550.GH2603314@bill-the-cat>
References: <20260115222828.3931345-3-trini@konsulko.com>
 <aYO3HOmFFVAkjfKD@orbyte.nwl.cc>
 <20260204212010.GD2603314@bill-the-cat>
 <aYO5r8Na5-fRYHgA@orbyte.nwl.cc>
 <20260204213139.GE2603314@bill-the-cat>
 <aYO8vDPa522pttDV@orbyte.nwl.cc>
 <20260204215016.GF2603314@bill-the-cat>
 <aYPPkg0rQTQr0g2Y@orbyte.nwl.cc>
 <20260204230416.GG2603314@bill-the-cat>
 <aYPWcEcnrBOCLVxf@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8bdHyf1et6pRMdJg"
Content-Disposition: inline
In-Reply-To: <aYPWcEcnrBOCLVxf@orbyte.nwl.cc>
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


--8bdHyf1et6pRMdJg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 05, 2026 at 12:29:52AM +0100, Phil Sutter wrote:
> On Wed, Feb 04, 2026 at 05:04:16PM -0600, Tom Rini wrote:
> > On Thu, Feb 05, 2026 at 12:00:34AM +0100, Phil Sutter wrote:
> > > On Wed, Feb 04, 2026 at 03:50:16PM -0600, Tom Rini wrote:
> > > > On Wed, Feb 04, 2026 at 10:40:12PM +0100, Phil Sutter wrote:
> > > > > On Wed, Feb 04, 2026 at 03:31:39PM -0600, Tom Rini wrote:
> > > > > > On Wed, Feb 04, 2026 at 10:27:11PM +0100, Phil Sutter wrote:
> > > > > > > On Wed, Feb 04, 2026 at 03:20:10PM -0600, Tom Rini wrote:
> > > > > > > > On Wed, Feb 04, 2026 at 10:16:12PM +0100, Phil Sutter wrote:
> > > > > > > > > Hi,
> > > > > > > > >=20
> > > > > > > > > On Thu, Jan 15, 2026 at 04:19:32PM -0600, Tom Rini wrote:
> > > > > > > > > > With commit 0535e46d55d7 ("scripts/dtc: Update to upstr=
eam version
> > > > > > > > > > v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-=
Boot if our
> > > > > > > > > > device tree is not 8-byte aligned. In commit f613a6e15e=
f7 ("ARM: OMAP2+:
> > > > > > > > > > Pad SPL binary to 8-byte alignment before DTB") Beleswa=
r Padhi explains
> > > > > > > > > > that we must have ALIGN(x) statements inside of a secti=
on to ensure that
> > > > > > > > > > padding is included and not simply that the linker addr=
ess counter is
> > > > > > > > > > incremented. To that end, this patch:
> > > > > > > > > > - Expands some linker sections to be more readable when=
 adding a second
> > > > > > > > > >   statement to the section.
> > > > > > > > > > - Aligns the final section before _end (for U-Boot) or
> > > > > > > > > >   _image_binary_end or __bss_end (for xPL phases) by 8-=
bytes by adding
> > > > > > > > > >   '. =3D ALIGN(8);' to the final section before the sym=
bol.
> > > > > > > > > > - Ensure that we do have alignment by adding an ASSERT =
so that when not
> > > > > > > > > >   aligned we fail to link (and explain why).
> > > > > > > > > > - Remove now-spurious  '. =3D ALIGN(x);' statements tha=
t were intended to
> > > > > > > > > >   provide the above alignments.
> > > > > > > > > >=20
> > > > > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > > > >=20
> > > > > > > > > For unclear reasons, this seems to break boot via xmodem =
protocol on my
> > > > > > > > > Synology DS414. I found this commit via 'git bisect'. The=
 symptom is:
> > > > > > > > >=20
> > > > > > > > > | kwboot version 2026.04-rc1-00098-g6ad0cf8f83db
> > > > > > > > > | Detected kwbimage v1 with SPI boot signature
> > > > > > > > > | Patching image boot signature to UART
> > > > > > > > > | Aligning image header to Xmodem block size
> > > > > > > > > | Sending boot message. Please reboot the target...\
> > > > > > > > > | Sending boot image header (67584 bytes)...
> > > > > > > > > |   0 % [................................................=
=2E.....................]
> > > > > > > > > |  13 % [................................................=
=2E.....................]
> > > > > > > > > |  26 % [................................................=
=2E.....................]
> > > > > > > > > |  39 % [................................................=
=2E.....................]
> > > > > > > > > |  53 % [................................................=
=2E.....................]
> > > > > > > > > |  66 % [................................................=
=2E.....................]
> > > > > > > > > |  79 % [................................................=
=2E.....................]
> > > > > > > > > |  92 % [......................................          =
                      ]
> > > > > > > > > | Done
> > > > > > > > > | Missing DTB
> > > > > > > > > | spl_init() failed: -2
> > > > > > > > > | ### ERROR ### Please RESET the board ###
> > > > > > > > > |=20
> > > > > > > > > |=20
> > > > > > > > > | xmodem: Connection timed out
> > > > > > > > >=20
> > > > > > > > > Debug printf()s in fdtdec_prepare_fdt() show that fdt_che=
ck_header()
> > > > > > > > > returns -FDT_ERR_BADMAGIC.
> > > > > > > > >=20
> > > > > > > > > With HEAD at a8d982e1f1726 ("x86: cpu: Fix crash on FTRAC=
E enabled
> > > > > > > > > builds"), reverting arch/arm/cpu/u-boot-spl.lds like so:
> > > > > > > > >=20
> > > > > > > > > | @@ -41,14 +41,21 @@ SECTIONS
> > > > > > > > > |                 __binman_sym_start =3D .;
> > > > > > > > > |                 KEEP(*(SORT(.binman_sym*)));
> > > > > > > > > |                 __binman_sym_end =3D .;
> > > > > > > > > | -               . =3D ALIGN(8);
> > > > > > > > > |         }
> > > > > > > > > | =20
> > > > > > > > > | +       . =3D ALIGN(4); /* critical! */
> > > > > > > > > |         __image_copy_end =3D .;
> > > > > > > > > | +       .rel.dyn : {
> > > > > > > > > | +               __rel_dyn_start =3D .;
> > > > > > > > > | +               *(.rel*)
> > > > > > > > > | +               __rel_dyn_end =3D .;
> > > > > > > > > | +       }
> > > > > > > > > | +
> > > > > > > > > | +       . =3D ALIGN(8);
> > > > > > > > > |         _image_binary_end =3D .;
> > > > > > > > > |         _end =3D .;
> > > > > > > > > | =20
> > > > > > > > > | -       .bss : {
> > > > > > > > > | +       .bss __rel_dyn_start (OVERLAY) : {
> > > > > > > > > |                 __bss_start =3D .;
> > > > > > > > > |                 *(.bss*)
> > > > > > > > > |                  . =3D ALIGN(8);
> > > > > > > > >=20
> > > > > > > > > The SPL image starts up again and continues loading the r=
eal uboot
> > > > > > > > > image. Note that I have no idea what these changes actual=
ly do, so I
> > > > > > > > > need instructions if I should dig further.
> > > > > > > >=20
> > > > > > > > Does:
> > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/2026013018=
3635.2612933-1-trini@konsulko.com/
> > > > > > > > fix it?
> > > > > > >=20
> > > > > > > Sadly not, same result.
> > > > > >=20
> > > > > > Ugh. What file, specifically, do you send via xmodem? And so th=
at maybe
> > > > > > I can more easily replicate the failure, are you using the kern=
el.org
> > > > > > gcc-14.2.0 toolchain or something else?
> > > > >=20
> > > > > I am building with a custom-built arm-openadk-linux-uclibceabi-gcc
> > > > > version 14.3.0. Basically what I run is:
> > > > >=20
> > > > > MYENV=3D'ARCH=3Darm CROSS_COMPILE=3D~/git/openadk-ds414/toolchain=
_synology-ds414_uclibc-ng_softfp_eabi_arm/usr/bin/arm-openadk-linux-uclibce=
abi-'
> > > > >=20
> > > > > make $MYENV clean && \
> > > > > for f in $(ls u-boot*.kwb 2>/dev/null); do rm $f; done && \
> > > > > make $MYENV ds414_defconfig && \
> > > > > make $MYENV -j12 && \
> > > > > ./tools/kwboot -a -t -p -b u-boot-*spl.kwb /dev/ttyUSB0
> > > > >=20
> > > > > With current uboot, this should be u-boot-with-spl.kwb image.
> > > > >=20
> > > > > With said patch reverted (or the above changes applied), I produc=
e a
> > > > > working u-boot-with-spl.kwb which loads and boots linux from flas=
h. So
> > > > > my toolchain is at least not totally broken. ;)
> > > >=20
> > > > Right, so, for background, the following threads might shed some li=
ght
> > > > on things:
> > > > https://lore.kernel.org/u-boot/CAOMZO5DZNJ+=3DAP1spWCv7Ar6etf03H=3D=
DFVU=3DmXZcC7QFTGoh_Q@mail.gmail.com/
> > > > https://lore.kernel.org/u-boot/20260123161907.392211-1-festevam@gma=
il.com/
> > > >=20
> > > > And so to that end, can you please do:
> > > > hexdump -Cv u-boot-with-spl.kwb | grep 'd0 0d fe ed'
> > > > and let me know what that says? And the first line there should mat=
ch,
> > > > content-wise at least (but not quite file offset) spl/u-boot-spl. I=
 was
> > > > asking about your toolchain because with gcc-14.2.0 from kernel.org:
> > > > $ hexdump -Cv /tmp/ds414/spl/u-boot-spl | grep 'd0 0d fe ed'
> > > > 00002ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o...pG=
=2E......)..|
> > > > $ hexdump -Cv /tmp/ds414/u-boot-with-spl.kwb | grep 'd0 0d fe ed'
> > > > 00001ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o...pG=
=2E......)..|
> > >=20
> > > This is with HEAD at a8d982e1f17 + your "spl: Ensure final section be=
fore BSS
> > > is non-empty" applied:
> > >=20
> > > % hexdump -Cv u-boot-with-spl.kwb | grep 'd0 0d fe ed' | head -n1
> > > 00001ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o...pG..=
=2E....)..|
> > >=20
> > > % hexdump -Cv spl/u-boot-spl | grep 'd0 0d fe ed'
> > > 00002ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o...pG..=
=2E....)..|
> > >=20
> > > > And while this should then *work* that's luck and not design. If yo=
u can
> > > > confirm that instead 'd0 0d fe ed' is in the middle (and so 4 byte =
but
> > > > not 8 byte aligned) it'll at least be the same symptom as before.
> > >=20
> > > Hmm. My dumps indicate correct 8B alignment, right? Switching over to=
 a branch
> > > which has the problematic commit reverted and produced images work, I
> > > get exactly the same output from hexdump on those files, BTW. Does th=
at
> > > mean we're on the wrong track and my problem is not wrong DTB alignme=
nt?
> >=20
> > So, I'm not sure. The error message is what shows up quickly from trying
> > to find the device tree, and not finding it. In debugging the other
> > times, we did see mysterious shifts 4 bytes in either direction, but
> > never 8 bytes. I think you might need to start throwing some debug
> > prints around and seeing where the device tree *is* at run time in
> > relation to where it's expected to be.
>=20
> FDT_MAGIC sequence is found 12B before 'blob' as passed to
> fdtdec_prepare_fdt(). I searched in a range of (-128;127), it was the
> only offset which matched.

So, our mysterious 4 shift is now 12. If you undo the patch I asked you
to test, is it now 4B before? I basically want to confirm that my newest
patch just changes when we hit this problem and doesn't solve it, only
changes the mystery shift. Oh, and can you please readelf -S the
spl/u-boot-spl for both with my patch and current master AND the one you
made work? Thanks again!

>=20
> Cheers, Phil

--=20
Tom

--8bdHyf1et6pRMdJg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYPXzgAKCRAr4qD1Cr/k
Cts9AQD+IjR/W9yNLxBJew/96N0Y3nWjCQbA8Fxega1EpIbv3gD9Fc4Hok8tYnMF
Camr4oD86AnwsdNDV1ctmMaqo8q06gQ=
=Atfv
-----END PGP SIGNATURE-----

--8bdHyf1et6pRMdJg--
