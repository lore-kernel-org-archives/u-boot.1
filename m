Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982C0CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 08:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAD5B8405A;
	Tue,  9 Jun 2026 10:31:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="MHYpH3td";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A935841C2; Tue,  9 Jun 2026 10:31:02 +0200 (CEST)
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46C6B838BB
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 10:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780993859; x=1781253059;
 bh=yqt8Pt7YT4eCixhbd61M1FqrEA3+D9vKA78I7A+9El0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=MHYpH3tdkepM3ygd37RSquVa5MjZR1JuOWaauZCTItQuUlIvDt3TxIQ0y6jRnwwU9
 hVG18AV6VG5NE9+8LIG41ZAT84qxVS5LiZglmDsjqb32/Oj/DWAxkgjgVJwyzFHX6N
 qOxMAjeWNkQ7tKhkAxVOR3CfUBwCXEtvPYRBs/q/MdA292gKVOzBtM9l71yOjoM3oi
 SHV5JnDCUEATXCsO/X5rQrverUy97fLVAeA+eY7BV2kA8UlHCMFCRFfLIUlulaL2uu
 9waXrzuumJhp7ZeRd1iDDPPWKXp3tO96/1UDqtpIYS3Z574ukt2m4JU1FgXtGw+PJY
 4xObJj9T1/t+g==
Date: Tue, 09 Jun 2026 08:30:54 +0000
To: Simon Glass <sjg@chromium.org>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>,
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Javier Tia <floss@jetm.me>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>
Subject: Re: [PATCH v2 5/8] binman: android_boot: SEANDROIDENFORCE support
Message-ID: <GYJbTuIXLh_ITzIQPc6dJeuTu-YFrWUmgi6WLC2I2G0sQMpGol6yoA-wFPQTcJOul-dJKrrP2-IMduw6bZSpwYSj9-vADPoZ_uP548z2VYg=@samcday.com>
In-Reply-To: <CAFLszTgj+h==F9rjS38JzY=E9xVV-qzUEXXQmbEt9qi094reMQ@mail.gmail.com>
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
 <20260608-android-binman-v2-5-b8203682507f@samcday.com>
 <CAFLszTgj+h==F9rjS38JzY=E9xVV-qzUEXXQmbEt9qi094reMQ@mail.gmail.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 83d4a2252725a30ab246e4f6bddd238a9fc25788
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Ahoy Simon,

On Monday, 8 June 2026 at 11:27 PM, Simon Glass <sjg@chromium.org> wrote:

> Hi Sam,
>=20
> On 2026-06-07T23:37:09, Sam Day via B4 Relay
> <devnull+me.samcday.com@kernel.org> wrote:
> > binman: android_boot: SEANDROIDENFORCE support
> >
> > Some older MSM8916-era bootloaders want to see this string appended to
> > the abootimg, or they log an ugly warning to the screen.
> >
> > Signed-off-by: Sam Day <me@samcday.com>
> >
> > tools/binman/etype/android_boot.py                 | 11 +++++++++++
> >  tools/binman/ftest.py                              |  6 ++++++
> >  .../test/vendor/android_boot_seandroidenforce.dts  | 22 ++++++++++++++=
++++++++
> >  3 files changed, 39 insertions(+)
>=20
> > diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/an=
droid_boot.py
> > @@ -55,6 +57,7 @@ class Entry_android_boot(Entry_section):
> >          - os-version: Encoded Android OS version and patch level, defa=
ults to 0
> >          - boot-name: Android boot image board name
> >          - cmdline: Android boot command line
> > +        - append-seandroid-enforce: Append Samsung SEANDROIDENFORCE tr=
ailer,
>=20
> Calling this 'Samsung' is misleading given the commit message
> attributes it to MSM8916-era bootloaders - perhaps 'Append the
> SEANDROIDENFORCE trailer expected by some MSM8916/Samsung
> bootloaders'.
>=20
> > diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/an=
droid_boot.py
> > @@ -174,6 +180,9 @@ class Entry_android_boot(Entry_section):
> >                  self.Raise('page-size must fit the Android boot image =
header')
> >              if 'dtb' not in self._entries:
> >                  self.Raise("Missing required subnode 'dtb'")
> > +            if self.append_seandroid:
> > +                self.Raise("Property 'append-seandroid-enforce' requir=
es "
> > +                           "header-version 0")
>=20
> Just to check, is this a hard restriction of the format, or only a
> reflection of which bootloaders are known to want this trailer? If v2
> images can legitimately carry it too, it would be more flexible to
> allow it. If it really is invalid, please add a short note in the
> commit message saying why.
>=20
> > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > @@ -5673,6 +5673,12 @@ fdt         fdtmap                Extract the de=
vicetree blob from the fdtmap
> > +    def testAndroidBootSeAndroidEnforce(self):
> > +        """Test that binman appends SEANDROIDENFORCE"""
> > +        data =3D self._DoReadFile('vendor/android_boot_seandroidenforc=
e.dts')
> > +
> > +        self.assertEqual(b'SEANDROIDENFORCE', data[-16:])
>=20
> Please add a negative test for the v2 + append-seandroid-enforce
> combination, to lock in the Raise(). It would also be worth asserting
> the rest of the image (header, kernel page, ramdisk page) is intact,
> so a regression that truncates the body but leaves the trailer in
> place would still be caught.

I've since realized that this entire patch is unnecessary, and I've
dropped it from v3. Rather than codifying this, we can just take
advantage of the flexibility binman already offers through the
section etype, in conjunction with the text etype:

binman {
  android_boot { ... };
  text { text =3D "SEANDROIDENFORCE"; };
};

Quite awesome, really :)

Thanks,
-Sam

>=20
> Regards,
> Simon
> 
