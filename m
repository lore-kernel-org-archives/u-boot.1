Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A52ECD994
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 18:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AEC883B0B;
	Thu,  5 Feb 2026 19:02:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T44mm2mV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 109C683B5E; Thu,  5 Feb 2026 19:02:06 +0100 (CET)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24335838FA
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 19:02:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7cfdf0c8908so740283a34.0
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 10:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770314522; x=1770919322; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LiTEpR3+iuSzwviDIxKYpfn0VvvacnqCaHJrCrbuH0g=;
 b=T44mm2mVFsOUnNHIUKNxtS5Z8qBVGjgIgfxclkOaj7kJIsnlggJHmJWwgfmhO0Ld5k
 +aNi6+BXfZZ75KWW+DlrBjUzRPhvBS6O8CvlVTuJywyDKVrRmV5wjVil0+wJFH3Wt57i
 Ef+3adXyZ4AS6rMKiBcCjkhxYiSGdZm0Ri6hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770314522; x=1770919322;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LiTEpR3+iuSzwviDIxKYpfn0VvvacnqCaHJrCrbuH0g=;
 b=dDGsfc8SIz9vh+hFqHPOhJZo+P6NTv9MTHBNXNu7i70leO54uowpKlBIrw1eEnDpGq
 4Z22FLpvKqwDq+G4Krr9oTzUaZbL/Ai8ORcBL/8k/W7G7IvxMJoaohH3v/9lhp0abu7W
 9t2bjAe2VlmlE22A1bDxbXZAIHxOjzB6uRL0jjMqWnbANFBCx4+iq9stficPGthPlde7
 OpHSbkkhl+B0ExGDc2zYTrU8KOEFQ2i3ht5oTAKydCpSFmMowSVixEvrnub5Okbk0+xE
 iLSZQEu3TQFlEvBF9f4lhKfj4badXGg7pFtyUNrpM6LERQk0CEs2pAcJHcLlMkgE0Qnu
 Noyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV93/JFFpepJ63Py286IliukTQM56G1gQVQZxwxmAmGLp/gUidQRUeWTTZg+TH93sRldQjUt3g=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7Bv0GDI7uhzbm4oCqvMMRZU9z2Y4LXW99p8FhIh64Xmp7BzdU
 bvhR5KBrQL56kEVB24QfChdaEdt9qBQS9ZmDcqzB/GtTwBnmcLlzTWAEGuq04NqO8Yg=
X-Gm-Gg: AZuq6aLmtG+xvj3zdb7VWF65YTYEFBcfBgFusMDZLUEGFwsf3eJmDe9BeyTG4vrjtfV
 ORVMqoK8//U7ImHUASI4N7S8A47LhQwMpkbUtn7xeF72L/sNcD5Det9DbA0Hd3BfUc3sXSssyIR
 mEbOieU30BjKwaR/lzWbWm9oYEf3awS2dssNAFDGzGFjrdCjmChjHFLMpKa7Z6UQ5rPuHoj/4Ah
 QRHoknV3Qrw1IQ6XOcFgdCgz1CnrAh8CU4BWyy6uqFpMoTh7a1TiDKPPsoDDMD/WBA2CZqhqGHf
 TIyypZ0Mx9VkRcO90B6VAcpvfxjwZU/7kE+E28UZ66SIdjXNlVtHWUn4kD6XaKKX3LXZZi3cAaC
 uOuUkFNdvFC9o15MnrnDeiYDcuiHikGF5oblOhXheV8vVvqcjWzXwfsPti46Tu2ylFJhu7aFbLv
 vJqLQ0lDTsVV59Gj01PbJnroNMHnja7bhOBh5MSyoGR/+dhui7VnZtAVWLTmmf9aBA0iSG35cPU
 qkSRsJgKfwrf66iKJbF9QgsMTg39PWC7BukXjA=
X-Received: by 2002:a05:6830:7194:b0:7d1:90d6:3ee with SMTP id
 46e09a7af769-7d448977318mr5120500a34.8.1770314521439; 
 Thu, 05 Feb 2026 10:02:01 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d45bd28d81sm1193770a34.6.2026.02.05.10.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 10:02:00 -0800 (PST)
Date: Thu, 5 Feb 2026 12:01:57 -0600
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
Message-ID: <20260205180157.GM2603314@bill-the-cat>
References: <20260204212010.GD2603314@bill-the-cat>
 <aYO5r8Na5-fRYHgA@orbyte.nwl.cc>
 <20260204213139.GE2603314@bill-the-cat>
 <aYO8vDPa522pttDV@orbyte.nwl.cc>
 <20260204215016.GF2603314@bill-the-cat>
 <aYPPkg0rQTQr0g2Y@orbyte.nwl.cc>
 <20260204230416.GG2603314@bill-the-cat>
 <aYPWcEcnrBOCLVxf@orbyte.nwl.cc>
 <20260204233550.GH2603314@bill-the-cat>
 <aYPa2_YU04etfIv9@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6XYiUg0X1vGyCmb6"
Content-Disposition: inline
In-Reply-To: <aYPa2_YU04etfIv9@orbyte.nwl.cc>
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


--6XYiUg0X1vGyCmb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 05, 2026 at 12:48:43AM +0100, Phil Sutter wrote:
> On Wed, Feb 04, 2026 at 05:35:50PM -0600, Tom Rini wrote:
> > On Thu, Feb 05, 2026 at 12:29:52AM +0100, Phil Sutter wrote:
> > > On Wed, Feb 04, 2026 at 05:04:16PM -0600, Tom Rini wrote:
> > > > On Thu, Feb 05, 2026 at 12:00:34AM +0100, Phil Sutter wrote:
> > > > > On Wed, Feb 04, 2026 at 03:50:16PM -0600, Tom Rini wrote:
> > > > > > On Wed, Feb 04, 2026 at 10:40:12PM +0100, Phil Sutter wrote:
> > > > > > > On Wed, Feb 04, 2026 at 03:31:39PM -0600, Tom Rini wrote:
> > > > > > > > On Wed, Feb 04, 2026 at 10:27:11PM +0100, Phil Sutter wrote:
> > > > > > > > > On Wed, Feb 04, 2026 at 03:20:10PM -0600, Tom Rini wrote:
> > > > > > > > > > On Wed, Feb 04, 2026 at 10:16:12PM +0100, Phil Sutter w=
rote:
> > > > > > > > > > > Hi,
> > > > > > > > > > >=20
> > > > > > > > > > > On Thu, Jan 15, 2026 at 04:19:32PM -0600, Tom Rini wr=
ote:
> > > > > > > > > > > > With commit 0535e46d55d7 ("scripts/dtc: Update to u=
pstream version
> > > > > > > > > > > > v1.7.2-35-g52f07dcca47c") it is now a fatal error t=
o U-Boot if our
> > > > > > > > > > > > device tree is not 8-byte aligned. In commit f613a6=
e15ef7 ("ARM: OMAP2+:
> > > > > > > > > > > > Pad SPL binary to 8-byte alignment before DTB") Bel=
eswar Padhi explains
> > > > > > > > > > > > that we must have ALIGN(x) statements inside of a s=
ection to ensure that
> > > > > > > > > > > > padding is included and not simply that the linker =
address counter is
> > > > > > > > > > > > incremented. To that end, this patch:
> > > > > > > > > > > > - Expands some linker sections to be more readable =
when adding a second
> > > > > > > > > > > >   statement to the section.
> > > > > > > > > > > > - Aligns the final section before _end (for U-Boot)=
 or
> > > > > > > > > > > >   _image_binary_end or __bss_end (for xPL phases) b=
y 8-bytes by adding
> > > > > > > > > > > >   '. =3D ALIGN(8);' to the final section before the=
 symbol.
> > > > > > > > > > > > - Ensure that we do have alignment by adding an ASS=
ERT so that when not
> > > > > > > > > > > >   aligned we fail to link (and explain why).
> > > > > > > > > > > > - Remove now-spurious  '. =3D ALIGN(x);' statements=
 that were intended to
> > > > > > > > > > > >   provide the above alignments.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > >=20
> > > > > > > > > > > For unclear reasons, this seems to break boot via xmo=
dem protocol on my
> > > > > > > > > > > Synology DS414. I found this commit via 'git bisect'.=
 The symptom is:
> > > > > > > > > > >=20
> > > > > > > > > > > | kwboot version 2026.04-rc1-00098-g6ad0cf8f83db
> > > > > > > > > > > | Detected kwbimage v1 with SPI boot signature
> > > > > > > > > > > | Patching image boot signature to UART
> > > > > > > > > > > | Aligning image header to Xmodem block size
> > > > > > > > > > > | Sending boot message. Please reboot the target...\
> > > > > > > > > > > | Sending boot image header (67584 bytes)...
> > > > > > > > > > > |   0 % [............................................=
=2E.........................]
> > > > > > > > > > > |  13 % [............................................=
=2E.........................]
> > > > > > > > > > > |  26 % [............................................=
=2E.........................]
> > > > > > > > > > > |  39 % [............................................=
=2E.........................]
> > > > > > > > > > > |  53 % [............................................=
=2E.........................]
> > > > > > > > > > > |  66 % [............................................=
=2E.........................]
> > > > > > > > > > > |  79 % [............................................=
=2E.........................]
> > > > > > > > > > > |  92 % [......................................      =
                          ]
> > > > > > > > > > > | Done
> > > > > > > > > > > | Missing DTB
> > > > > > > > > > > | spl_init() failed: -2
> > > > > > > > > > > | ### ERROR ### Please RESET the board ###
> > > > > > > > > > > |=20
> > > > > > > > > > > |=20
> > > > > > > > > > > | xmodem: Connection timed out
> > > > > > > > > > >=20
> > > > > > > > > > > Debug printf()s in fdtdec_prepare_fdt() show that fdt=
_check_header()
> > > > > > > > > > > returns -FDT_ERR_BADMAGIC.
> > > > > > > > > > >=20
> > > > > > > > > > > With HEAD at a8d982e1f1726 ("x86: cpu: Fix crash on F=
TRACE enabled
> > > > > > > > > > > builds"), reverting arch/arm/cpu/u-boot-spl.lds like =
so:
> > > > > > > > > > >=20
> > > > > > > > > > > | @@ -41,14 +41,21 @@ SECTIONS
> > > > > > > > > > > |                 __binman_sym_start =3D .;
> > > > > > > > > > > |                 KEEP(*(SORT(.binman_sym*)));
> > > > > > > > > > > |                 __binman_sym_end =3D .;
> > > > > > > > > > > | -               . =3D ALIGN(8);
> > > > > > > > > > > |         }
> > > > > > > > > > > | =20
> > > > > > > > > > > | +       . =3D ALIGN(4); /* critical! */
> > > > > > > > > > > |         __image_copy_end =3D .;
> > > > > > > > > > > | +       .rel.dyn : {
> > > > > > > > > > > | +               __rel_dyn_start =3D .;
> > > > > > > > > > > | +               *(.rel*)
> > > > > > > > > > > | +               __rel_dyn_end =3D .;
> > > > > > > > > > > | +       }
> > > > > > > > > > > | +
> > > > > > > > > > > | +       . =3D ALIGN(8);
> > > > > > > > > > > |         _image_binary_end =3D .;
> > > > > > > > > > > |         _end =3D .;
> > > > > > > > > > > | =20
> > > > > > > > > > > | -       .bss : {
> > > > > > > > > > > | +       .bss __rel_dyn_start (OVERLAY) : {
> > > > > > > > > > > |                 __bss_start =3D .;
> > > > > > > > > > > |                 *(.bss*)
> > > > > > > > > > > |                  . =3D ALIGN(8);
> > > > > > > > > > >=20
> > > > > > > > > > > The SPL image starts up again and continues loading t=
he real uboot
> > > > > > > > > > > image. Note that I have no idea what these changes ac=
tually do, so I
> > > > > > > > > > > need instructions if I should dig further.
> > > > > > > > > >=20
> > > > > > > > > > Does:
> > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/202601=
30183635.2612933-1-trini@konsulko.com/
> > > > > > > > > > fix it?
> > > > > > > > >=20
> > > > > > > > > Sadly not, same result.
> > > > > > > >=20
> > > > > > > > Ugh. What file, specifically, do you send via xmodem? And s=
o that maybe
> > > > > > > > I can more easily replicate the failure, are you using the =
kernel.org
> > > > > > > > gcc-14.2.0 toolchain or something else?
> > > > > > >=20
> > > > > > > I am building with a custom-built arm-openadk-linux-uclibceab=
i-gcc
> > > > > > > version 14.3.0. Basically what I run is:
> > > > > > >=20
> > > > > > > MYENV=3D'ARCH=3Darm CROSS_COMPILE=3D~/git/openadk-ds414/toolc=
hain_synology-ds414_uclibc-ng_softfp_eabi_arm/usr/bin/arm-openadk-linux-ucl=
ibceabi-'
> > > > > > >=20
> > > > > > > make $MYENV clean && \
> > > > > > > for f in $(ls u-boot*.kwb 2>/dev/null); do rm $f; done && \
> > > > > > > make $MYENV ds414_defconfig && \
> > > > > > > make $MYENV -j12 && \
> > > > > > > ./tools/kwboot -a -t -p -b u-boot-*spl.kwb /dev/ttyUSB0
> > > > > > >=20
> > > > > > > With current uboot, this should be u-boot-with-spl.kwb image.
> > > > > > >=20
> > > > > > > With said patch reverted (or the above changes applied), I pr=
oduce a
> > > > > > > working u-boot-with-spl.kwb which loads and boots linux from =
flash. So
> > > > > > > my toolchain is at least not totally broken. ;)
> > > > > >=20
> > > > > > Right, so, for background, the following threads might shed som=
e light
> > > > > > on things:
> > > > > > https://lore.kernel.org/u-boot/CAOMZO5DZNJ+=3DAP1spWCv7Ar6etf03=
H=3DDFVU=3DmXZcC7QFTGoh_Q@mail.gmail.com/
> > > > > > https://lore.kernel.org/u-boot/20260123161907.392211-1-festevam=
@gmail.com/
> > > > > >=20
> > > > > > And so to that end, can you please do:
> > > > > > hexdump -Cv u-boot-with-spl.kwb | grep 'd0 0d fe ed'
> > > > > > and let me know what that says? And the first line there should=
 match,
> > > > > > content-wise at least (but not quite file offset) spl/u-boot-sp=
l. I was
> > > > > > asking about your toolchain because with gcc-14.2.0 from kernel=
=2Eorg:
> > > > > > $ hexdump -Cv /tmp/ds414/spl/u-boot-spl | grep 'd0 0d fe ed'
> > > > > > 00002ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o.=
=2E.pG.......)..|
> > > > > > $ hexdump -Cv /tmp/ds414/u-boot-with-spl.kwb | grep 'd0 0d fe e=
d'
> > > > > > 00001ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o.=
=2E.pG.......)..|
> > > > >=20
> > > > > This is with HEAD at a8d982e1f17 + your "spl: Ensure final sectio=
n before BSS
> > > > > is non-empty" applied:
> > > > >=20
> > > > > % hexdump -Cv u-boot-with-spl.kwb | grep 'd0 0d fe ed' | head -n1
> > > > > 00001ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o...=
pG.......)..|
> > > > >=20
> > > > > % hexdump -Cv spl/u-boot-spl | grep 'd0 0d fe ed'
> > > > > 00002ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o...=
pG.......)..|
> > > > >=20
> > > > > > And while this should then *work* that's luck and not design. I=
f you can
> > > > > > confirm that instead 'd0 0d fe ed' is in the middle (and so 4 b=
yte but
> > > > > > not 8 byte aligned) it'll at least be the same symptom as befor=
e.
> > > > >=20
> > > > > Hmm. My dumps indicate correct 8B alignment, right? Switching ove=
r to a branch
> > > > > which has the problematic commit reverted and produced images wor=
k, I
> > > > > get exactly the same output from hexdump on those files, BTW. Doe=
s that
> > > > > mean we're on the wrong track and my problem is not wrong DTB ali=
gnment?
> > > >=20
> > > > So, I'm not sure. The error message is what shows up quickly from t=
rying
> > > > to find the device tree, and not finding it. In debugging the other
> > > > times, we did see mysterious shifts 4 bytes in either direction, but
> > > > never 8 bytes. I think you might need to start throwing some debug
> > > > prints around and seeing where the device tree *is* at run time in
> > > > relation to where it's expected to be.
> > >=20
> > > FDT_MAGIC sequence is found 12B before 'blob' as passed to
> > > fdtdec_prepare_fdt(). I searched in a range of (-128;127), it was the
> > > only offset which matched.
> >=20
> > So, our mysterious 4 shift is now 12. If you undo the patch I asked you
> > to test, is it now 4B before? I basically want to confirm that my newest
> > patch just changes when we hit this problem and doesn't solve it, only
> > changes the mystery shift. Oh, and can you please readelf -S the
> > spl/u-boot-spl for both with my patch and current master AND the one you
> > made work? Thanks again!
>=20
> Sorry for the mess, I did my FDT_MAGIC search with master branch, so not
> with your patch applied. Readelf prints:
>=20
> % readelf -S spl/u-boot-spl
> There are 20 section headers, starting at offset 0x127d54:
>=20
> Section Headers:
>   [Nr] Name              Type            Addr     Off    Size   ES Flg Lk=
 Inf Al
>   [ 0]                   NULL            00000000 000000 000000 00      0=
   0  0
>   [ 1] .text             PROGBITS        40004030 001030 009c1e 00  AX  0=
   0 16
>   [ 2] .rodata           PROGBITS        4000dc50 00ac50 0016f9 00   A  0=
   0  4
>   [ 3] .data             PROGBITS        4000f360 00c360 0042e0 00  WA  0=
   0 32
>   [ 4] __u_boot_list     PROGBITS        40013640 010640 000594 00  WA  0=
   0  4
>   [ 5] .binman_sym_table NOBITS          40013bd4 010bd4 000004 00  WA  0=
   0  1
>   [ 6] .bss              NOBITS          40013be0 010bd4 000728 00  WA  0=
   0 32
>   [ 7] .ARM.attributes   ARM_ATTRIBUTES  00000000 010bd4 000029 00      0=
   0  1
>   [ 8] .comment          PROGBITS        00000000 010bfd 000012 01  MS  0=
   0  1
>   [ 9] .debug_line       PROGBITS        00000000 010c0f 02844f 00      0=
   0  1
>   [10] .debug_info       PROGBITS        00000000 03905e 076ced 00      0=
   0  1
>   [11] .debug_abbrev     PROGBITS        00000000 0afd4b 00f697 00      0=
   0  1
>   [12] .debug_aranges    PROGBITS        00000000 0bf3e8 002430 00      0=
   0  8
>   [13] .debug_str        PROGBITS        00000000 0c1818 00d85c 01  MS  0=
   0  1
>   [14] .debug_loc        PROGBITS        00000000 0cf074 044a87 00      0=
   0  1
>   [15] .debug_ranges     PROGBITS        00000000 113b00 006578 00      0=
   0  8
>   [16] .debug_frame      PROGBITS        00000000 11a078 0069c0 00      0=
   0  4
>   [17] .symtab           SYMTAB          00000000 120a38 004d10 10     18=
 888  4
>   [18] .strtab           STRTAB          00000000 125748 002539 00      0=
   0  1
>   [19] .shstrtab         STRTAB          00000000 127c81 0000d3 00      0=
   0  1
>=20
> Next try with your patch applied on top of master:
>=20
> FDT_MAGIC is found at offset -8. Readelf:
>=20
> There are 19 section headers, starting at offset 0x127d34:
>=20
> Section Headers:
>   [Nr] Name              Type            Addr     Off    Size   ES Flg Lk=
 Inf Al
>   [ 0]                   NULL            00000000 000000 000000 00      0=
   0  0
>   [ 1] .text             PROGBITS        40004030 001030 009c1e 00  AX  0=
   0 16
>   [ 2] .rodata           PROGBITS        4000dc50 00ac50 0016f9 00   A  0=
   0  4
>   [ 3] .data             PROGBITS        4000f360 00c360 0042e0 00  WA  0=
   0 32
>   [ 4] __u_boot_list     PROGBITS        40013640 010640 000598 00  WA  0=
   0  4
>   [ 5] .bss              NOBITS          40013be0 010bd8 000728 00  WA  0=
   0 32
>   [ 6] .ARM.attributes   ARM_ATTRIBUTES  00000000 010bd8 000029 00      0=
   0  1
>   [ 7] .comment          PROGBITS        00000000 010c01 000012 01  MS  0=
   0  1
>   [ 8] .debug_line       PROGBITS        00000000 010c13 02844f 00      0=
   0  1
>   [ 9] .debug_info       PROGBITS        00000000 039062 076ced 00      0=
   0  1
>   [10] .debug_abbrev     PROGBITS        00000000 0afd4f 00f697 00      0=
   0  1
>   [11] .debug_aranges    PROGBITS        00000000 0bf3e8 002430 00      0=
   0  8
>   [12] .debug_str        PROGBITS        00000000 0c1818 00d85c 01  MS  0=
   0  1
>   [13] .debug_loc        PROGBITS        00000000 0cf074 044a87 00      0=
   0  1
>   [14] .debug_ranges     PROGBITS        00000000 113b00 006578 00      0=
   0  8
>   [15] .debug_frame      PROGBITS        00000000 11a078 0069c0 00      0=
   0  4
>   [16] .symtab           SYMTAB          00000000 120a38 004d00 10     17=
 887  4
>   [17] .strtab           STRTAB          00000000 125738 002539 00      0=
   0  1
>   [18] .shstrtab         STRTAB          00000000 127c71 0000c1 00      0=
   0  1
>=20
> Finally, with problematic patches reverted:
>=20
> FDT_MAGIC is found at offset 0 (obviously). Readelf:
>=20
> There are 19 section headers, starting at offset 0x1284a0:
>=20
> Section Headers:
>   [Nr] Name              Type            Addr     Off    Size   ES Flg Lk=
 Inf Al
>   [ 0]                   NULL            00000000 000000 000000 00      0=
   0  0
>   [ 1] .text             PROGBITS        40004030 001030 009c1e 00  AX  0=
   0 16
>   [ 2] .rodata           PROGBITS        4000dc50 00ac50 0016f9 00   A  0=
   0  4
>   [ 3] .data             PROGBITS        4000f360 00c360 0042e0 00  WA  0=
   0 32
>   [ 4] __u_boot_list     PROGBITS        40013640 010640 000594 00  WA  0=
   0  4
>   [ 5] .bss              PROGBITS        40013bd4 010bd4 000734 00   W  0=
   0  4
>   [ 6] .ARM.attributes   ARM_ATTRIBUTES  00000000 011308 000029 00      0=
   0  1
>   [ 7] .comment          PROGBITS        00000000 011331 000012 01  MS  0=
   0  1
>   [ 8] .debug_line       PROGBITS        00000000 011343 02844f 00      0=
   0  1
>   [ 9] .debug_info       PROGBITS        00000000 039792 076ced 00      0=
   0  1
>   [10] .debug_abbrev     PROGBITS        00000000 0b047f 00f697 00      0=
   0  1
>   [11] .debug_aranges    PROGBITS        00000000 0bfb18 002430 00      0=
   0  8
>   [12] .debug_str        PROGBITS        00000000 0c1f48 00d85c 01  MS  0=
   0  1
>   [13] .debug_loc        PROGBITS        00000000 0cf7a4 044a87 00      0=
   0  1
>   [14] .debug_ranges     PROGBITS        00000000 114230 006578 00      0=
   0  8
>   [15] .debug_frame      PROGBITS        00000000 11a7a8 0069c0 00      0=
   0  4
>   [16] .symtab           SYMTAB          00000000 121168 004d20 10     17=
 887  4
>   [17] .strtab           STRTAB          00000000 125e88 002557 00      0=
   0  1
>   [18] .shstrtab         STRTAB          00000000 1283df 0000c1 00      0=
   0  1
>=20
> HTH, Phil

It's confusing, but it does help, thanks again. I'll be cc'ing you and
Brian on a patch that supersedes the one I asked you to try. I finally
see where the discrepency comes from, and I'm doing to builds now to
check the old behavior first before I run off and fix this for the
needed new behavior.


--=20
Tom

--6XYiUg0X1vGyCmb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYTbEgAKCRAr4qD1Cr/k
CukGAP9aonYsVVDED12NY2V/y/0ZAVg9iReJz2lPjTL/8mdZJgEAsXkSnbUAaCUy
aJpbrBVsKxcjNqsCWErXmrpEBnHrbgI=
=gzKy
-----END PGP SIGNATURE-----

--6XYiUg0X1vGyCmb6--
