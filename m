Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BD1CD8CA4
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 08:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A485A8405A;
	Tue,  9 Jun 2026 10:35:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="RHwbD1AX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8F998425F; Tue,  9 Jun 2026 10:35:00 +0200 (CEST)
Received: from mail-4399.protonmail.ch (mail-4399.protonmail.ch [185.70.43.99])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58487838BB
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 10:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780994097; x=1781253297;
 bh=w1HkVkBq8Kr7V8JHariLnSS20DAFE6YkWt3TNvwv9M0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=RHwbD1AXF83VrVbJF+8MiMzg7g2AQA0L5nYfUmwO2qg/vubgW9ay0oHTBORRwJwM3
 SkUr4FaMX6knXGVNLzO0t00gZKUQ0DylnYZE9XqWGzZDlMZZ8/nDV6iTRIkq8RbMWb
 R6eKTBVPLgUDMe25P4uOGCWzEZofT2leRyYxOqB6u41+UYpnDg2K1SW0LT/nxhyor5
 TriEUEeUFqLqdL9gWCWFhM3vNRHKlgV9uYmgSBn7a+xWuqVP3QFprAwSIo+SJBWUQK
 wkpv+vRAhgl3H6pspRG60A7upFDcgkVagoQAOf3r1LZBS5gBChyxXNgWWc7kZEKL2y
 MVZk6vA6KAX8A==
Date: Tue, 09 Jun 2026 08:34:54 +0000
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
Subject: Re: [PATCH v2 3/8] binman: android_boot: vendor-dt support
Message-ID: <OEBnAQ2eckkjE9xM8jLtN9MIDcdZkbIb-8dykrBw9PuiFeCKgRz_t4pV6LNfwc_VUo-jP3sXUcePuggI-xk_F5AJvaBMqV4noWfV51csGhE=@samcday.com>
In-Reply-To: <CAFLszTiA8nCAuaWv4CsfEBWNfOJo74XD=fzpfLV=Q=ku=3FrRA@mail.gmail.com>
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
 <20260608-android-binman-v2-3-b8203682507f@samcday.com>
 <CAFLszTiA8nCAuaWv4CsfEBWNfOJo74XD=fzpfLV=Q=ku=3FrRA@mail.gmail.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 165e33405a9b3fd43afeb8f14d0af7d1fb75fcb7
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

'Ello Simon,

On Monday, 8 June 2026 at 11:27 PM, Simon Glass <sjg@chromium.org> wrote:

> Hi Sam,
>=20
> On 2026-06-07T23:37:09, Sam Day via B4 Relay
> <devnull+me.samcday.com@kernel.org> wrote:
> > binman: android_boot: vendor-dt support
> >
> > There's many Android bootloaders out there that expect non-standard
> > abootimgs. Samsung and Qualcomm, and likely many others. This quirk has
> > been codified in the widely used osm0sis fork/rewrite of mkbootimg.
> >
> > Presumably, these vendor-specific abootimgs were conceived before the v=
2
> > format was widely available or specified. The evidence for this is thei=
r
> > hijacking of the header_version field to specify the length of a payloa=
d
> > that follows the main abootimg.
> >
> > At least QCDT and DTBH (both of which will be implemented as binman
> > etypes in following commits) use this approach.
> >
> > Link: https://github.com/osm0sis/mkbootimg
> > Signed-off-by: Sam Day <me@samcday.com>
> >
> > tools/binman/etype/android_boot.py                 | 37 +++++++++++++++=
+++++--
> >  tools/binman/ftest.py                              | 11 ++++++-
> >  .../binman/test/vendor/android_boot_vendor_dt.dts  | 27 ++++++++++++++=
++
> >  3 files changed, 72 insertions(+), 3 deletions(-)
>=20
> > diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/an=
droid_boot.py
> > @@ -131,17 +136,26 @@ class Entry_android_boot(Entry_section):
> >                  self.Raise('page-size must fit the Android boot image =
header')
> >              if 'dtb' in self._entries:
> >                  self.Raise("Subnode 'dtb' requires header-version 2")
> > +            if self.vendor_dt_node and self.os_version:
> > +                self.Raise("os_version not allowed when vendor-dt is i=
n use")
>=20
> Two things. The message uses the Python attribute name; users see the
> DT property, so this should read 'os-version'. Second, the commit
> message doesn't explain why os-version becomes invalid in this mode -
> in the v0 header layout, dt_size (the field we hijack) and os_version
> are separate u32 fields, so there's no obvious conflict.

Good point. I double checked and there's no need to add / enforce this
invariant. I simply added it purely out of paranoia, since it's right next
to the header_version and possibly some bootloader somewhere interprets
the "vendor DT" size as 64 bit. But then again, probably not ;)

>=20
> If a downstream bootloader interprets os_version differently when
> dt_size is set, please document that - otherwise I'd drop the
> restriction. Either way, please add a test for the Raise().

mkbootimg-osm0sis doesn't enforce it, at any rate. So I've removed
the check from v3.

>=20
> > diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/an=
droid_boot.py
> > @@ -152,6 +166,15 @@ class Entry_android_boot(Entry_section):
> >              entry.SetPrefix(self._name_prefix)
> >              self._entries[node.name] =3D entry
> >
> > +    def _ReadVendorDtEntries(self, vendor_dt_node):
> > +        entry =3D Entry.Create(self, vendor_dt_node, etype=3D'section'=
,
> > +                             expanded=3Dself.GetImage().use_expanded,
> > +                             missing_etype=3Dself.GetImage().missing_e=
type)
> > +        entry.page_size =3D fdt_util.GetInt(self._node, 'page-size', 2=
048)
> > +        entry.ReadNode()
> > +        entry.SetPrefix(self._name_prefix)
> > +        self._entries[vendor_dt_node.name] =3D entry
>=20
> Forcing etype=3D'section' here works only because qcdt/dtbh later walks
> up via getattr(self.section, 'page_size', 2048). That coupling is
> invisible from this file. Please add a comment noting this attribute
> is consumed by child etypes (qcdt/dtbh in later patches) - otherwise
> it looks like dead code. A cleaner alternative would be for the child
> etype to look up the android-boot ancestor directly, so page-size
> doesn't need to be smuggled through an unrelated attribute.
>=20
> Also 'page-size' is re-read from self._node here, but ReadNode() has
> already cached it in self.page_size. Just use that.

I opted for the cleaner alternative you proposed. In v3 the qcdt/dtbh
etypes traverse their ancestors to find an explicit page-size, falling
back to the local prop, or 2048 otherwise.

>=20
> > diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/an=
droid_boot.py
> > @@ -246,7 +278,7 @@ class Entry_android_boot(Entry_section):
> >                               0, # second_offset
> >                               self._GetAddr(self.tags_offset, 'tags'),
> >                               self.page_size,
> > -                             self.header_version,
> > +                             len(vendor_dt),
>=20
> This conflates two distinct fields. For a plain v0 image the slot is
> header_version; for a vendor-dt image it's dt_size. The current code
> only produces the right bytes because both collapse to 0 when there is
> no vendor-dt. Please make it explicit:
>=20
>     dt_size =3D len(vendor_dt) if self.vendor_dt_node else self.header_ve=
rsion
>

I did actually code-golf it that way, but I agree it's too clever ;)
(And by clever I mean obnoxiously obtuse)

I've introduced an explicit `overloaded_header_version` in v3, and
included a comment about this special/weird behaviour.

> and add a comment that this slot is overloaded. As written, anyone
> adding a new v0 header_version in future will silently break vendor-dt
> builds.

Not sure I follow this part. _BuildV0SectionData is only ever called when
self.header_version =3D=3D 0.

>=20
> > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > @@ -5662,7 +5662,16 @@ fdt         fdtmap                Extract the de=
vicetree blob from the fdtmap
> >          self.assertEqual(U_BOOT_DTB_DATA,
> >                           data[0x1000:0x1000 + len(U_BOOT_DTB_DATA)])
> >
> > -        self.assertEqual(U_BOOT_DATA, data[0x800:0x800 + len(U_BOOT_DA=
TA)])
> > +    def testAndroidBootVendorDt(self):
>=20
> You're silently dropping a duplicated assertion left over from patch
> 1/8. That cleanup belongs in its own patch (or a fixup to 1/8), not
> buried in the vendor-dt commit.

Aye, oops. That's cleaned up properly in v3.

>=20
> > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > @@ -5662,7 +5662,16 @@ fdt         fdtmap                Extract the de=
vicetree blob from the fdtmap
> > +    def testAndroidBootVendorDt(self):
> > +        """Test that android-boot can embed an arbitrary vendor-dt sec=
tion"""
> > +        data =3D self._DoReadFile('vendor/android_boot_vendor_dt.dts')
> > +        header =3D struct.unpack_from('<8s10I16s512s32s', data, 0)
> > +        vendor_dt =3D b'howdy'
> > +        self.assertEqual(len(vendor_dt), header[9])
> > +        self.assertEqual(0, header[10])
> > +        self.assertEqual(self._AndroidBootId(U_BOOT_DATA, b'\0', b'',
> > +                                             vendor_dt), header[13])
> > +        self.assertEqual(vendor_dt, data[0x1800:0x1805])
>=20
> Coverage is thin. Please add tests for the two new Raise() paths
> ('vendor-dt' on v2, os-version with vendor-dt), and assert that
> vendor_dt is padded to page-size - slicing [0x1800:0x1805] only proves
> the first five bytes landed, not that the next 0x7fb bytes are zero or
> that the overall image length is right.

Ack - v3 will have 100% test coverage for all 3 newly introduced etypes.

Again, thanks for the very comprehensive review!

Kind regards,
-Sam

>=20
> Regards,
> Simon
> 
