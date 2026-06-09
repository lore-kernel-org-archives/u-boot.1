Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB5ECD8C85
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 06:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96895838BB;
	Tue,  9 Jun 2026 08:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="oMUrb1tD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7743839A8; Tue,  9 Jun 2026 08:20:40 +0200 (CEST)
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch
 [109.224.244.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 576D7807C4
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 08:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780986037; x=1781245237;
 bh=UeEofdONSUOlDKZRhwzNEOTJaHQKesFvpeuGd/XBTtE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=oMUrb1tDEqcFHr/V5OKB1gSw6Ce25k0iep7qUXxyD026zuEF+rs/RcAgLRxlBqhGX
 QuTWilkjxXF8vixm5mdVx6iuStW7igwmHsUd760lhUI8NnzpagF/2VLl5zhs2bkjMg
 TninIhrX853VTHXxnR0AlPEi/3zW4g6XvaA92IDCCGuKR8M8SRRYvdfgw144IfUv/F
 d3+5SdyonmAPl13U8XzCkYcVVIKBxgyinM83qW1lDLVAJWdpcg7/Ug4KokfvXSiSvI
 OXmhEdMld0erNqaZH0DZlAuSPozhceFs13f6jqvshPVcA2Bi2sVh57Ae8TARh8ghks
 dvukvFPD7ecuQ==
Date: Tue, 09 Jun 2026 06:20:31 +0000
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
Subject: Re: [PATCH v2 1/8] binman: Android boot image support
Message-ID: <jyKa6pVYveQ4p_bPFRjTZZYE1_2BzhtpTq2JOWxf_Kg9M11SW11LLzQtJy54OqGkfO3z8KanForRXUJt6vTgtr71L6jI-ZATQmUmE3zVDT4=@samcday.com>
In-Reply-To: <CAFLszThpB_C7fdqJC=CRx3qm+jjvykHJgSKvz+s_xbngCCXSxQ@mail.gmail.com>
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
 <20260608-android-binman-v2-1-b8203682507f@samcday.com>
 <CAFLszThpB_C7fdqJC=CRx3qm+jjvykHJgSKvz+s_xbngCCXSxQ@mail.gmail.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 1377f4cb9b002cdd530dee12396e0cede9404557
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

Hello Simon,

On Monday, 8 June 2026 at 11:25 PM, Simon Glass <sjg@chromium.org> wrote:

> Hi Sam,
>=20
> On 2026-06-07T23:37:09, Sam Day via B4 Relay
> <devnull+me.samcday.com@kernel.org> wrote:
> > binman: Android boot image support
> >
> > Introduce initial support for Android boot images (abootimgs). This
> > initial stab supports both v0 and v2 headers. The AOSP implementation
> > was used as a reference.
> >
> > Since we're targeting U-Boot use cases here, a couple of things were
> > omitted from this impl, namely 'second' and recovery_dtbo support.
> >
> > Link: https://android.googlesource.com/platform/system/tools/mkbootimg/
> > Signed-off-by: Sam Day <me@samcday.com>
> >
> > tools/binman/etype/android_boot.py           | 313 ++++++++++++++++++++=
+++++++
> >  tools/binman/ftest.py                        |  66 ++++++
> >  tools/binman/test/vendor/android_boot_v0.dts |  29 +++
> >  tools/binman/test/vendor/android_boot_v2.dts |  46 ++++
> >  4 files changed, 454 insertions(+)
>=20
> > diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/an=
droid_boot.py
> > @@ -0,0 +1,313 @@
> > +    @staticmethod
> > +    def _CheckFit(name, data, size):
> > +        if len(data) > size:
> > +            raise ValueError('%s is %d bytes, maximum is %d' %
> > +                             (name, len(data), size))
> > +
> > +        return data + b'\0' * (size - len(data))
>=20
> Please raise via self.Raise() so the user gets the node path. A bare
> ValueError makes it hard to track down which entry overflowed when
> several android-boot images are present.

Ack, done in v3.

>=20
> > diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/an=
droid_boot.py
> > @@ -0,0 +1,313 @@
> > +    def _GetEntryData(self, name, required):
> > +        entry =3D self._entries.get(name)
> > +        data =3D entry.GetData(required)
> > +        if data is None and not required:
> > +            return None
> > +
> > +        return data
> > +
> > +    def _GetOptionalEntryData(self, name, required, default=3Db''):
> > +        entry =3D self._entries.get(name)
> > +        if not entry:
> > +            return default
> > +
> > +        data =3D entry.GetData(required)
> > +        if data is None and not required:
> > +            return None
> > +
> > +        return data
>=20
> These two are almost identical and the names don't distinguish them,
> i.e. _GetEntryData() will AttributeError if the name isn't present,
> while _GetOptionalEntryData() returns the default. Please fold them
> into one with a default=3DNone parameter: None means required, anything
> else means optional (function comment). Also, the 'if data is None and
> not required' branch in _GetEntryData() does nothing - both arms
> return data.

Good catch, collapsed and simplified _GetEntryData() in v3.

>=20
> > diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/an=
droid_boot.py
> > @@ -0,0 +1,313 @@
> > +    def ReadNode(self):
> > +        super().ReadNode()
> > +        self.header_version =3D fdt_util.GetInt(self._node, 'header-ve=
rsion', 0)
>=20
> ...
> > +        if self.header_version not in (0, 2):
> > +            self.Raise('Only Android boot image header versions 0 and =
2 are '
> > +                       'supported')
>=20
> Please call this out in the commit message - AOSP defines v0..v4 and
> readers will wonder why v1/v3/v4 are missing. Something like "v1, v3,
> v4 are not implemented as no use case has come up yet" would help.

Noted, added the explicit callout in v3.

>=20
> > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > @@ -5598,6 +5598,72 @@ fdt         fdtmap                Extract the de=
vicetree blob from the fdtmap
> > +        self.assertEqual(U_BOOT_DATA, data[0x800:0x800 + len(U_BOOT_DA=
TA)])
> > +        self.assertEqual(U_BOOT_DTB_DATA,
> > +                         data[0x1000:0x1000 + len(U_BOOT_DTB_DATA)])
> > +
> > +        self.assertEqual(U_BOOT_DATA, data[0x800:0x800 + len(U_BOOT_DA=
TA)])
>=20
> Last assertion duplicates the first - please drop it.

Apologies, this was junk I didn't properly catch in the zillionth rebasing
session. It was already cleaned up in a subsequent commit. v3 will clean it
up properly.

>=20
> > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > @@ -5598,6 +5598,72 @@ fdt         fdtmap                Extract the de=
vicetree blob from the fdtmap
> > +    def testAndroidBootV0(self):
> > +        """Test that binman can produce a plain legacy Android boot im=
age"""
> > +        data =3D self._DoReadFile('vendor/android_boot_v0.dts')
>=20
> Missing coverage for several error paths - U haven't run this but
> there is Raise() for unsupported header_version, non-power-of-two
> page-size, etc. Binman aims for full branch coverage - please add
> tests for these, and verify 'binman test -T' still shows 100% coverage
> for your etype

As discussed in IRC, I agree this is very reasonable... I didn't appreciate
just how far the proposed code was from that 100% goal, though ;)

v3 introduces a much more comprehensive suite that hits 100% coverage.

>=20
> > diff --git a/tools/binman/test/vendor/android_boot_v2.dts b/tools/binma=
n/test/vendor/android_boot_v2.dts
> > @@ -0,0 +1,46 @@
> > +                     kernel-offset =3D <0x00008000>;
> > +                     ramdisk-offset =3D <0x01000000>;
> > +                     second-offset =3D <0x00f00000>;
> > +                     tags-offset =3D <0x00000100>;
>=20
> 'second-offset' is silently ignored - the etype doesn't parse it and
> the commit message says 'second' support is dropped. Do you need it?

Nope, another vestige of a previous iteration that I didn't clean up
properly in the rebasing, sorry about that! Removed in v3.

>=20
> > diff --git a/tools/binman/test/vendor/android_boot_v0.dts b/tools/binma=
n/test/vendor/android_boot_v0.dts
> > @@ -0,0 +1,29 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +/dts-v1/;
>=20
> Why a new 'vendor/' subdirectory? The contents here are plain Android
> boot images, not anything vendor-specific. I'd suggest 'android/' (or
> leaving them in test/ alongside other etype .dts files), which also
> leaves a clearer naming pattern for QCDT/DTBH later.

Fair call - I've yanked everything up to the top level in v3.

>=20
> > diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/an=
droid_boot.py
> > @@ -0,0 +1,313 @@
> > +    Example::
> > +        A v2 abootimg with control FDT placed in the DTB section:
> > +
> > +        android-boot {
>=20
> ...
> > +        A v0 abootimg with embedded control FDT (v0 doesn't support DT=
Bs) and
> > +        an empty ramdisk (some bootloaders insist on a ramdisk being p=
resent):
> > +        android-boot {
>=20
> These render as one big code block in the auto-generated docs, with
> the v0 description folded into the literal. Please split into two
> 'Example::' blocks, with a blank line between the v0 prose and its
> 'android-boot {'.

Ack, fixed in v3.

>=20
> Regards,
> Simon
>=20

Thanks for the thorough review Simon, much appreciated.

Cheers,
-Sam

