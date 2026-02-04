Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEAEEA794A
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 23:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8237839A8;
	Thu,  5 Feb 2026 00:04:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e3hoduOx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59CD0839DF; Thu,  5 Feb 2026 00:04:24 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B23B183015
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 00:04:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-45f0b597eb4so197668b6e.2
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 15:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770246260; x=1770851060; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vHRGdMueeNIFncrnj3EHZ5re2UzuebDV5PqUnRswLqI=;
 b=e3hoduOxYSNgfrPlDfgRp+hMtGh8hJeeuZ7oKlAiElH7i3n6Pf0izND3bdRHv7xjCG
 ry5/LK2R54F09c1RaDSX7dpFsDfeyDHalR4W7HrouIUk+PPA3HOSrjtXQSdGmlfOendG
 4a+mdodzZVSaW0/nsHKyw7EVhhsGFyQogZmOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770246260; x=1770851060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vHRGdMueeNIFncrnj3EHZ5re2UzuebDV5PqUnRswLqI=;
 b=R/xNRq8kssviFLHSL5e8rtUHhFqLTbEtXXiidFZJiJC2+/ww4tGL2KvlvZHfEJx9RT
 CfXrgyASqPqws6QtJDIuqi6rxhD6J7svmd83YnpZaUafPEBbEw3yf7Saej+jaH56JGa/
 rI28YdkQEdBfl6XzPe6xxeLHP+FQ2AiDgtmtz478b4Rjcflmxx4AhEC22Y7RLNjW1rsu
 g7wqKdjN7lCGojklSrsa1iMNLvOotDusLT/KF8m/ZM0/V/gKrG7kdkD03NOnrWzHu7Pl
 A7W2qxHTOlLWQe9ocfRRIBCZ3QzDEXFWiTzURZEuTTBoqxFdh4wqtub3aUJ/22YdlpuZ
 bC/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvXW/sd12T2pkUCAouViHfBNrU8V7BRj+ntvgDuhLdhQ6y4BZvfe4IJdeJ8nvm/bANoALzVfQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0PlqNU54F5EiUADaEnrMRm6LN9TTVoH1VblUcAP0gU7EOkX1J
 XfQDcOm0qMwE1BWccBKFzP5NIcuVazBsf65pdf7gmI+vOnAnBhuoAdDt+HejPcOO+8k=
X-Gm-Gg: AZuq6aK41Skhl/mCOaFfb6AXC/2XA0FXRoAIvIEvsVpStQU3l6AHMJ2+q3poCgHZTsY
 OMHwOfwZYvZVPxrNGF0/bvzgA8TGm8eUbM0JvOc5v9Lqd7n0k2EAcwATIuXth0zpy4wvmtNJkgC
 VERnsZA106bCI85U47v2GpwTfFaJUiq7y+TXwhqhqfmUt//dXtI6evBaRV3b/2vxzVvhXIaaf7O
 YzOIrY3xrhB3xdM8uQsUO9JsFerKVxfweh8OAznKBHHetMIEbiPa5EagqoxDP98TGzlTXQOgkKJ
 f6BJV7X1WzWxBTuqQ7tPrlX79WRE57bvQTSQGMhM2OZLw4YVOAq95epmuZS9wxeiMcfo36lCIPF
 VptjKNgWdNOQJBnn7+v2MZdivBKdrOB0ceb01+DdVohj/r7M8ECnhA/ipYBIgUa3WBkxRgiVZtD
 D1Vnejpsi1SdDDH31LSQphIEKGEO7DZa4Mt2R71eQdtHH5UY5tz8HVhRBHYnm7Rg+6ileow9ASq
 ekZPrKNmjrtfuro9C8i33kqeo3oe7re8JaK2Aw=
X-Received: by 2002:a05:6808:4f61:b0:45f:42d6:3014 with SMTP id
 5614622812f47-462d58e3960mr2826493b6e.26.1770246260339; 
 Wed, 04 Feb 2026 15:04:20 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417ded9sm2643665fac.1.2026.02.04.15.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 15:04:19 -0800 (PST)
Date: Wed, 4 Feb 2026 17:04:16 -0600
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
Message-ID: <20260204230416.GG2603314@bill-the-cat>
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
 <aYO3HOmFFVAkjfKD@orbyte.nwl.cc>
 <20260204212010.GD2603314@bill-the-cat>
 <aYO5r8Na5-fRYHgA@orbyte.nwl.cc>
 <20260204213139.GE2603314@bill-the-cat>
 <aYO8vDPa522pttDV@orbyte.nwl.cc>
 <20260204215016.GF2603314@bill-the-cat>
 <aYPPkg0rQTQr0g2Y@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FIkJ4I0bO/FpNwTA"
Content-Disposition: inline
In-Reply-To: <aYPPkg0rQTQr0g2Y@orbyte.nwl.cc>
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


--FIkJ4I0bO/FpNwTA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 05, 2026 at 12:00:34AM +0100, Phil Sutter wrote:
> On Wed, Feb 04, 2026 at 03:50:16PM -0600, Tom Rini wrote:
> > On Wed, Feb 04, 2026 at 10:40:12PM +0100, Phil Sutter wrote:
> > > On Wed, Feb 04, 2026 at 03:31:39PM -0600, Tom Rini wrote:
> > > > On Wed, Feb 04, 2026 at 10:27:11PM +0100, Phil Sutter wrote:
> > > > > On Wed, Feb 04, 2026 at 03:20:10PM -0600, Tom Rini wrote:
> > > > > > On Wed, Feb 04, 2026 at 10:16:12PM +0100, Phil Sutter wrote:
> > > > > > > Hi,
> > > > > > >=20
> > > > > > > On Thu, Jan 15, 2026 at 04:19:32PM -0600, Tom Rini wrote:
> > > > > > > > With commit 0535e46d55d7 ("scripts/dtc: Update to upstream =
version
> > > > > > > > v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot=
 if our
> > > > > > > > device tree is not 8-byte aligned. In commit f613a6e15ef7 (=
"ARM: OMAP2+:
> > > > > > > > Pad SPL binary to 8-byte alignment before DTB") Beleswar Pa=
dhi explains
> > > > > > > > that we must have ALIGN(x) statements inside of a section t=
o ensure that
> > > > > > > > padding is included and not simply that the linker address =
counter is
> > > > > > > > incremented. To that end, this patch:
> > > > > > > > - Expands some linker sections to be more readable when add=
ing a second
> > > > > > > >   statement to the section.
> > > > > > > > - Aligns the final section before _end (for U-Boot) or
> > > > > > > >   _image_binary_end or __bss_end (for xPL phases) by 8-byte=
s by adding
> > > > > > > >   '. =3D ALIGN(8);' to the final section before the symbol.
> > > > > > > > - Ensure that we do have alignment by adding an ASSERT so t=
hat when not
> > > > > > > >   aligned we fail to link (and explain why).
> > > > > > > > - Remove now-spurious  '. =3D ALIGN(x);' statements that we=
re intended to
> > > > > > > >   provide the above alignments.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > >=20
> > > > > > > For unclear reasons, this seems to break boot via xmodem prot=
ocol on my
> > > > > > > Synology DS414. I found this commit via 'git bisect'. The sym=
ptom is:
> > > > > > >=20
> > > > > > > | kwboot version 2026.04-rc1-00098-g6ad0cf8f83db
> > > > > > > | Detected kwbimage v1 with SPI boot signature
> > > > > > > | Patching image boot signature to UART
> > > > > > > | Aligning image header to Xmodem block size
> > > > > > > | Sending boot message. Please reboot the target...\
> > > > > > > | Sending boot image header (67584 bytes)...
> > > > > > > |   0 % [....................................................=
=2E.................]
> > > > > > > |  13 % [....................................................=
=2E.................]
> > > > > > > |  26 % [....................................................=
=2E.................]
> > > > > > > |  39 % [....................................................=
=2E.................]
> > > > > > > |  53 % [....................................................=
=2E.................]
> > > > > > > |  66 % [....................................................=
=2E.................]
> > > > > > > |  79 % [....................................................=
=2E.................]
> > > > > > > |  92 % [......................................              =
                  ]
> > > > > > > | Done
> > > > > > > | Missing DTB
> > > > > > > | spl_init() failed: -2
> > > > > > > | ### ERROR ### Please RESET the board ###
> > > > > > > |=20
> > > > > > > |=20
> > > > > > > | xmodem: Connection timed out
> > > > > > >=20
> > > > > > > Debug printf()s in fdtdec_prepare_fdt() show that fdt_check_h=
eader()
> > > > > > > returns -FDT_ERR_BADMAGIC.
> > > > > > >=20
> > > > > > > With HEAD at a8d982e1f1726 ("x86: cpu: Fix crash on FTRACE en=
abled
> > > > > > > builds"), reverting arch/arm/cpu/u-boot-spl.lds like so:
> > > > > > >=20
> > > > > > > | @@ -41,14 +41,21 @@ SECTIONS
> > > > > > > |                 __binman_sym_start =3D .;
> > > > > > > |                 KEEP(*(SORT(.binman_sym*)));
> > > > > > > |                 __binman_sym_end =3D .;
> > > > > > > | -               . =3D ALIGN(8);
> > > > > > > |         }
> > > > > > > | =20
> > > > > > > | +       . =3D ALIGN(4); /* critical! */
> > > > > > > |         __image_copy_end =3D .;
> > > > > > > | +       .rel.dyn : {
> > > > > > > | +               __rel_dyn_start =3D .;
> > > > > > > | +               *(.rel*)
> > > > > > > | +               __rel_dyn_end =3D .;
> > > > > > > | +       }
> > > > > > > | +
> > > > > > > | +       . =3D ALIGN(8);
> > > > > > > |         _image_binary_end =3D .;
> > > > > > > |         _end =3D .;
> > > > > > > | =20
> > > > > > > | -       .bss : {
> > > > > > > | +       .bss __rel_dyn_start (OVERLAY) : {
> > > > > > > |                 __bss_start =3D .;
> > > > > > > |                 *(.bss*)
> > > > > > > |                  . =3D ALIGN(8);
> > > > > > >=20
> > > > > > > The SPL image starts up again and continues loading the real =
uboot
> > > > > > > image. Note that I have no idea what these changes actually d=
o, so I
> > > > > > > need instructions if I should dig further.
> > > > > >=20
> > > > > > Does:
> > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20260130183635=
=2E2612933-1-trini@konsulko.com/
> > > > > > fix it?
> > > > >=20
> > > > > Sadly not, same result.
> > > >=20
> > > > Ugh. What file, specifically, do you send via xmodem? And so that m=
aybe
> > > > I can more easily replicate the failure, are you using the kernel.o=
rg
> > > > gcc-14.2.0 toolchain or something else?
> > >=20
> > > I am building with a custom-built arm-openadk-linux-uclibceabi-gcc
> > > version 14.3.0. Basically what I run is:
> > >=20
> > > MYENV=3D'ARCH=3Darm CROSS_COMPILE=3D~/git/openadk-ds414/toolchain_syn=
ology-ds414_uclibc-ng_softfp_eabi_arm/usr/bin/arm-openadk-linux-uclibceabi-'
> > >=20
> > > make $MYENV clean && \
> > > for f in $(ls u-boot*.kwb 2>/dev/null); do rm $f; done && \
> > > make $MYENV ds414_defconfig && \
> > > make $MYENV -j12 && \
> > > ./tools/kwboot -a -t -p -b u-boot-*spl.kwb /dev/ttyUSB0
> > >=20
> > > With current uboot, this should be u-boot-with-spl.kwb image.
> > >=20
> > > With said patch reverted (or the above changes applied), I produce a
> > > working u-boot-with-spl.kwb which loads and boots linux from flash. So
> > > my toolchain is at least not totally broken. ;)
> >=20
> > Right, so, for background, the following threads might shed some light
> > on things:
> > https://lore.kernel.org/u-boot/CAOMZO5DZNJ+=3DAP1spWCv7Ar6etf03H=3DDFVU=
=3DmXZcC7QFTGoh_Q@mail.gmail.com/
> > https://lore.kernel.org/u-boot/20260123161907.392211-1-festevam@gmail.c=
om/
> >=20
> > And so to that end, can you please do:
> > hexdump -Cv u-boot-with-spl.kwb | grep 'd0 0d fe ed'
> > and let me know what that says? And the first line there should match,
> > content-wise at least (but not quite file offset) spl/u-boot-spl. I was
> > asking about your toolchain because with gcc-14.2.0 from kernel.org:
> > $ hexdump -Cv /tmp/ds414/spl/u-boot-spl | grep 'd0 0d fe ed'
> > 00002ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o...pG....=
=2E..)..|
> > $ hexdump -Cv /tmp/ds414/u-boot-with-spl.kwb | grep 'd0 0d fe ed'
> > 00001ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o...pG....=
=2E..)..|
>=20
> This is with HEAD at a8d982e1f17 + your "spl: Ensure final section before=
 BSS
> is non-empty" applied:
>=20
> % hexdump -Cv u-boot-with-spl.kwb | grep 'd0 0d fe ed' | head -n1
> 00001ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o...pG......=
=2E)..|
>=20
> % hexdump -Cv spl/u-boot-spl | grep 'd0 0d fe ed'
> 00002ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o...pG......=
=2E)..|
>=20
> > And while this should then *work* that's luck and not design. If you can
> > confirm that instead 'd0 0d fe ed' is in the middle (and so 4 byte but
> > not 8 byte aligned) it'll at least be the same symptom as before.
>=20
> Hmm. My dumps indicate correct 8B alignment, right? Switching over to a b=
ranch
> which has the problematic commit reverted and produced images work, I
> get exactly the same output from hexdump on those files, BTW. Does that
> mean we're on the wrong track and my problem is not wrong DTB alignment?

So, I'm not sure. The error message is what shows up quickly from trying
to find the device tree, and not finding it. In debugging the other
times, we did see mysterious shifts 4 bytes in either direction, but
never 8 bytes. I think you might need to start throwing some debug
prints around and seeing where the device tree *is* at run time in
relation to where it's expected to be.

--=20
Tom

--FIkJ4I0bO/FpNwTA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYPQbAAKCRAr4qD1Cr/k
Cp9YAP9boVhj6B1dEi2ha3HpT6CC0qbFNzL4xmrvKLCQQDlhnwEAwjz/iinqmQG/
NsFpDLqgXttdwpwMe7ZM4w6NblkhfAc=
=Ge5l
-----END PGP SIGNATURE-----

--FIkJ4I0bO/FpNwTA--
