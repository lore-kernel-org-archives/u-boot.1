Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E582CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 00:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 050178486D;
	Wed, 10 Jun 2026 02:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="chIteplh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DBA28486D; Wed, 10 Jun 2026 02:44:29 +0200 (CEST)
Received: from mail-4399.protonmail.ch (mail-4399.protonmail.ch [185.70.43.99])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E09F847B0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 02:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1781052265; x=1781311465;
 bh=ajAE4eNAqBGOK9tyXYQFq9A/hAABBTRAZtEgYtd8v7s=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=chIteplheBwqTLWGC+pxveGhG0aNjYKUeUUICC1g2FbasrT+XK6eZJim/syUlUFXf
 JadmNZ+D8OewwuClZOY2FY+AAOXbD+4uudyQ2TwcYoX40LdJjusn6Jiub2kz7oFA1Z
 IKGSboKT65as/E5V9fixJm8HXFwKO/MrFtjdCPvUpncvt2TjWdloqWW/07eHC0DPVf
 oOZbV84qHeGX8W5F9zekX4JUTrOf5gK8QQo1J8hgvD6AtIKFnAUNaeRqDfBUShCiiI
 LGYskAJ4ZoXWqNNg5nlpdfns3w1FwAyBejVZqSwmmXmPM+J+3Uo1js51ufSFYmY3c0
 WZ9PK9wXGqBnA==
Date: Wed, 10 Jun 2026 00:44:21 +0000
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
Subject: Re: [PATCH v2 6/8] binman: Add DTBH support
Message-ID: <x20gdihfxexR4cTJFGdi7lvNfA3uI_ecN52MVjDbXCnEXR2qPduyYIePPbLkkti4QssHeh6oqixx3gHaLGvZUbiM4wzKUIwMltj5lF80Rws=@samcday.com>
In-Reply-To: <CAFLszThNc+WNrezGQgGEv63_AG=vPHHCa-UWLKhduoVkiLgWog@mail.gmail.com>
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
 <20260608-android-binman-v2-6-b8203682507f@samcday.com>
 <CAFLszThNc+WNrezGQgGEv63_AG=vPHHCa-UWLKhduoVkiLgWog@mail.gmail.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 95443b62b17eb9bda1bb8efeb144ff6c0735d499
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

Greetings Simon,

On Monday, 8 June 2026 at 11:27 PM, Simon Glass <sjg@chromium.org> wrote:

> Hi Sam,
>
> On 2026-06-07T23:37:09, Sam Day via B4 Relay
> <devnull+me.samcday.com@kernel.org> wrote:
> > binman: Add DTBH support
> >
> > DTBH, used by Samsung S-BOOT bootloaders, is similar to QCDT. That is,
> > it's a multi-record container that carries vendor-specific magic values
> > to assist the previous bootloader in picking the appropriate FDT for th=
e
> > booting device.
> >
> > dtbTool-exynos was used as a reference for this implementation.
> >
> > Link: https://github.com/dsankouski/dtbtool-exynos
> > Signed-off-by: Sam Day <me@samcday.com>
> >
> > tools/binman/etype/android_boot.py               |  20 +++
> >  tools/binman/etype/dtbh.py                       | 173 +++++++++++++++=
++++++++
> >  tools/binman/ftest.py                            |  24 ++++
> >  tools/binman/test/vendor/dtbh.dts                |  29 ++++
> >  tools/binman/test/vendor/dtbh_bad_model_info.dts |  19 +++
> >  5 files changed, 265 insertions(+)
>
> > diff --git a/tools/binman/etype/dtbh.py b/tools/binman/etype/dtbh.py
> > new file mode 100644
> > index 00000000000..90769e5d016
> > --- /dev/null
> > +++ b/tools/binman/etype/dtbh.py
> > @@ -0,0 +1,173 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +# Entry-type module for Samsung Android DTBH tables
> > +
> > +import struct
> > +
> > +from binman.entry import Entry
> > +from binman.etype.section import Entry_section
> > +from dtoc import fdt_util
>
> A lot of duplication between this file and qcdt.py - _align_up(),
> _pad(), _DtbEntryName(), _GetPayloadSubnodes(), ReadEntries(),
> _GetPageSize(), _GetDtbData() are essentially identical. Perhaps you
> can factor the common bits into a helper or even a shared base class
> (something like Entry_vendor_dt_table), with the two etypes only
> carrying their format-specific bits.

Affirmative. v3 introduces a Entry_Android_vendor_dt_table base class to
reduce the duplication between QCDT and DTBH impls.

>
> > diff --git a/tools/binman/etype/dtbh.py b/tools/binman/etype/dtbh.py
> > @@ -0,0 +1,173 @@
> > +    def BuildSectionData(self, required):
> > +...
> > +        header_size =3D _align_up(12 + len(dtbs) * 32 + 4, page_size)
>
> What is the trailing '+ 4' for? Nothing gets written after the
> records, and the QCDT calculation uses just '12 + len(dtbs) * 24'. If
> it's meant to reserve a terminator cell, the code should emit it too;
> otherwise please drop it (or add a comment explaining the layout
> invariant from dtbTool-exynos).

dtbTool-exynos refers to it as an "end of table marker". v3 introduces
named constants with comments to de-mystify this spooky behaviour.

>
> > diff --git a/tools/binman/etype/dtbh.py b/tools/binman/etype/dtbh.py
> > @@ -0,0 +1,173 @@
> > +    @staticmethod
> > +    def _GetDtbRootU32(node, data, propname):
> > +        import libfdt
> > +
> > +        try:
> > +            fdt =3D libfdt.Fdt(data)
> > +            root =3D fdt.path_offset('/')
> > +            prop =3D fdt.getprop(root, propname)
> > +        except libfdt.FdtException as exc:
> > +            raise ValueError("Node '%s': Missing required DTB root pro=
perty "
> > +                             ''%s'' % (node.path, propname)) from exc
>
> Please move 'import libfdt' to module-level imports - that's the
> convention in binman. Also, catching FdtException to report 'Missing
> required DTB root property' will mis-report any other libfdt failure
> (e.g. a malformed FDT). Validate the FDT once up front and only wrap
> the getprop() call, so genuine parse failures surface with their real
> cause.

Fair. Discussed further, below.

>
> > diff --git a/tools/binman/etype/dtbh.py b/tools/binman/etype/dtbh.py
> > @@ -0,0 +1,173 @@
> > +DTBH_MAGIC =3D b'DTBH'
> > +DTBH_VERSION =3D 2
> > +DTBH_PLATFORM_CODE_DEF =3D 0x50a6
> > +DTBH_SUBTYPE_CODE_DEF =3D 0x217584da
> > +DTBH_SPACE =3D 0x20
>
> DTBH_SPACE is unexplained. Please add a comment describing what this
> field means in the DTBH record layout (and why 0x20 is the right
> constant), or make it a documented property like 'platform' and
> 'subtype' if it varies in the wild.

It's just a magic 0x20 referred to as a "space delimiter" in dtbTool-exynos=
.
Added a comment to that effect in v3.

>
> > diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/an=
droid_boot.py
> > @@ -141,6 +141,26 @@ class Entry_android_boot(Entry_section):
> > +        A legacy DTBH abootimg, the kind some Samsung bootloaders expe=
ct:
> > +
> > +        android-boot {
> > +            header-version =3D <0>;
> > +...
>
> The QCDT example added in patch 4 does not set header-version
> explicitly, while this one does. Please make them consistent.

Fixed in v3.

>
> > diff --git a/tools/binman/test/vendor/dtbh.dts b/tools/binman/test/vend=
or/dtbh.dts
> > @@ -0,0 +1,29 @@
> > +     model_info-chip =3D <7870>;
> > +     model_info-hw_rev =3D <6>;
> > +     model_info-hw_rev_end =3D <6>;
>
> These properties end up at the root of the test DTB, which is what
> 'u-boot-dtb' embeds, so _GetDtbRootU32() picks them back out of the
> payload. That works but is subtle - a one-line comment at the top of
> the test DTS noting that the test relies on the binman test DTB being
> its own DTBH payload would save the next person a few minutes.
>

It's subtle indeed, and also quite confusing. There's no need
for these values to leak into the control FDT, I was just following the
prior art too closely. v3 opts to pluck these values from the dtbh {} node
rather than hunting for them in the root of the DTB.

The end result is that QCDT and DTBH can share even more code, since they'r=
e
both hunting for these record-level values in the same place and same way.

> > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > @@ -5701,6 +5701,30 @@ fdt         fdtmap                Extract the de=
vicetree blob from the fdtmap
> > +    def testAndroidBootDtbh(self):
> > +        """Test that binman can produce a DTBH container"""
> > +        data, dtb_data, _map, _dtb =3D self._DoReadFileDtb(
> > +            'vendor/dtbh.dts', use_real_dtb=3DTrue)
> > +
> > +        dtb_size =3D tools.align(len(dtb_data), 0x800)
> > +
> > +        self.assertEqual(b'DTBH', data[:4])
> > +        self.assertEqual((2, 1), struct.unpack_from('<II', data, 4))
> > +        self.assertEqual((7870, 0x50a6, 0x217584da, 6, 6, 0x800,
> > +                          dtb_size, 0x20),
> > +                         struct.unpack_from('<8I', data, 12))
>
> Please also add a test exercising non-default 'platform', 'subtype'
> and 'page-size', and one with more than one dtb-* subnode - at the
> moment only the single-record default-everything path is covered,
> which leaves the multi-record offset arithmetic untested.

Done and done.

Thanks again Simon,
-Sam

>
> Regards,
> Simon
>
