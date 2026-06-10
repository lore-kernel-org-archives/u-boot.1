Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12E0CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 00:44:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9D738486D;
	Wed, 10 Jun 2026 02:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="aDfryxWr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5196D848A2; Wed, 10 Jun 2026 02:44:02 +0200 (CEST)
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE63C847B0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 02:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1781052238; x=1781311438;
 bh=eHZeluyJkO0odsl0qGOfAHtMVOUsakYrk3CAUNPEkvc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=aDfryxWrWYnsoYMWeP0PmOUdOjsoUkZnefJde7Se82lHUrtckl/JmfJUC9llg17Ne
 qqxkXfO7NxO21gyOcVQa6tHXXzhQXtFsIlXemJB7rlapS7kBzY5r++gvLS8YR+mQEs
 AQ8b96BQVWIzvGcRfcjniV5F7dYu5/J2LdogZAaja4M9B1v3E1KrRfXt+clM/wXq8U
 A0INGz+S8XulE79NML5CCySCe+PEY+q6qDmzmpInlsueZe0yv8DyaRGpkCXcwR+wJq
 znlwu6282gqptcnbJ9vuVh5QxHfrVshwtL4gVz5DTQ8neVi+OMscuplCw5DdDrQb8+
 1r/DteD1WfQBA==
Date: Wed, 10 Jun 2026 00:43:53 +0000
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
Subject: Re: [PATCH v2 4/8] binman: Add QCDT support
Message-ID: <mFBeep4TItLmAzHEARn8dSSTsKEDywCH4tWLz1ExMQY93_zF4kTZCAZZOzrAPLRLFAkaiqS8R9QB5GkbDUqLU1phHrwlRrZdeVKgm7WiZDo=@samcday.com>
In-Reply-To: <CAFLszTiwjGTY89dLVL0gm4oYwHadG7w_dWjEjOsKEBcEKf4Kwg@mail.gmail.com>
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
 <20260608-android-binman-v2-4-b8203682507f@samcday.com>
 <CAFLszTiwjGTY89dLVL0gm4oYwHadG7w_dWjEjOsKEBcEKf4Kwg@mail.gmail.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: dba82f38957ec60ab3be006c9a6f3363a458838f
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
> > binman: Add QCDT support
> >
> > This vendor-specific format is used by many bootloaders on older qcom
> > SoCs, such as msm8916. It's a container for N FDTs. Each one is
> > contained in a record that includes metadata about the platform/variant
> > it targets. The previous bootloader picks the 'right' record based on
> > this metadata.
> >
> > This initial impl targets a streamlined v2 path, with no support for
> > different versions or multiple qcom,msm-id/qcom,board-id tuples. If/whe=
n
> > that's needed it will be implemented in a follow-up.
> >
> > Signed-off-by: Sam Day <me@samcday.com>
> >
> > tools/binman/etype/android_boot.py           |  30 +++++
> >  tools/binman/etype/qcdt.py                   | 160 +++++++++++++++++++=
++++++++
> >  tools/binman/ftest.py                        |  22 ++++
> >  tools/binman/test/vendor/qcdt.dts            |  20 ++++
> >  tools/binman/test/vendor/qcdt_bad_msm_id.dts |  17 +++
> >  5 files changed, 249 insertions(+)
>
> Your comment says "A legacy QCDT abootimg, the kind msm8916 bootloaders e=
xpect"
>
> Please can you spell out the acronym...

I'd love to, but I think nobody can actually do that. There's not
really any canonical impl or reference point for this stuff. I believe the
reason everyone calls it "QCDT" is because that's the magic identifier in
the header.

Maybe it means "QualComm Device(tree) Table"? Or perhaps it means
"Qualcomm/CodeAurora Device Trees"? We may never truly know :)

> I would also prefer qcom_xxx
> for the etype name where xxx is whatever this means, since presumably
> this is Qualcomm-specific.

Given the acronym doesn't have a canonical definition, and the limited
references to it use the "QCDT" moniker directly, I opted to keep it as-is
for v3, since `qcom_cdt` is confusing and would be a unique reference that
exists only in U-Boot. Or would you prefer qcom_qcdt?

>
> > diff --git a/tools/binman/etype/qcdt.py b/tools/binman/etype/qcdt.py
> > @@ -0,0 +1,160 @@
> > +from binman.entry import Entry
> > +from binman.etype.section import Entry_section
> > +from dtoc import fdt_util
>
> The _align_up()/_pad() helpers at the top are duplicated from
> android_boot.py in patch 1, and will be again in dtbh.py in patch 6.
> Please factor them into a shared helper module (or stick them on
> Entry_section).

I opted for the latter. v3 introduces a new patch to put these
shared helpers in Entry_section.

>
> > diff --git a/tools/binman/etype/qcdt.py b/tools/binman/etype/qcdt.py
> > @@ -0,0 +1,160 @@
> > +    def ReadEntries(self):
> > +        for node in self._node.subnodes:
> > +            if self.IsSpecialSubnode(node):
> > +                continue
> > +
> > +            payloads =3D self._GetPayloadSubnodes(node)
> > +            if len(payloads) > 1:
> > +                raise ValueError("Node '%s': must contain exactly one =
DTB "
> > +                                 "payload subnode" % node.path)
>
> Please use self.Raise() throughout - that's the binman convention and
> it adds the node path for you. The static/classmethod helpers should
> become plain methods so they can use self.Raise() too.

Ack, done in v3.

>
> > diff --git a/tools/binman/etype/qcdt.py b/tools/binman/etype/qcdt.py
> > @@ -0,0 +1,160 @@
> > +        dtb_offset =3D _align_up(12 + len(dtbs) * 24, page_size)
> > +        records =3D []
> > +        payloads =3D bytearray()
> > +        for msm_id, board_id, dtb in dtbs:
> > +            dtb_size =3D _align_up(len(dtb), page_size)
> > +            records.append((*msm_id, *board_id, dtb_offset, dtb_size))
> > +            payloads +=3D _pad(dtb, page_size)
> > +            dtb_offset +=3D dtb_size
> > +
> > +        qcdt =3D bytearray(struct.pack('<4sII', QCDT_MAGIC, QCDT_VERSI=
ON,
> > +                                     len(records)))
> > +        for platform_id, soc_rev, variant_id, subtype, offset, size in=
 records:
> > +            qcdt +=3D struct.pack('<IIIIII', platform_id, variant_id, =
subtype,
> > +                                soc_rev, offset, size)
>
> The 12 and 24 magic numbers should be struct.calcsize() of named
> header/record format strings, the way android_boot.py does for
> BOOT_IMAGE_HEADER_V0_SIZE. That also documents the layout.

Hm yeah, I got lazy here. v3 removes the magic values and formalizes
the format/size calculations like android_boot does.

>
> Also, unpacking msm-id as (platform_id, soc_rev) and board-id as
> (variant_id, subtype), then packing in the swapped order (platform_id,
> variant_id, subtype, soc_rev) is hard to read. Please build each
> record directly with the on-disk field order and add a comment
> referencing the LK/AOSP source for the QCDT v2 record layout.

Ack - this isn't very readable, I agree. Overhauled in v3.

>
> > diff --git a/tools/binman/etype/qcdt.py b/tools/binman/etype/qcdt.py
> > @@ -0,0 +1,160 @@
> > +    def BuildSectionData(self, required):
> > +        if not self._node.subnodes:
> > +            raise ValueError("Node '%s': Missing required DTB subnodes=
" %
> > +                             self._node.path)
>
> Redundant with the 'if not dtbs:' check further down (which correctly
> handles the case where the only subnodes are special). Please drop it.

Ack. v3 refactors this heavily and the redundant check is gone.

>
> > diff --git a/tools/binman/etype/qcdt.py b/tools/binman/etype/qcdt.py
> > @@ -0,0 +1,160 @@
> > +    def _GetPageSize(self):
> > +        if self._page_size is not None:
> > +            return self._page_size
> > +
> > +        return getattr(self.section, 'page_size', 2048)
>
> The docstring says "defaults to the parent android-boot page size",
> but in practice this picks it up from the vendor-dt section that
> _ReadVendorDtEntries() stamps with a page_size attribute. Please
> update the docstring - or better, but really you should look up the
> enclosing android-boot section directly rather than relying on an
> attribute being monkey-patched onto an intermediate generic section.

Indeed. v3 refactors this heavily to introduce a shared base class, which
prefers a locally set page-size, falling back to traversing the ancestry
to find an android-boot preference (and finally falling back to 2048).

>
> > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > @@ -5673,6 +5673,28 @@ fdt         fdtmap                Extract the de=
vicetree blob from the fdtmap
> > +    def testAndroidBootQcdt(self):
> > +        """Test that binman can produce a QCDT container"""
> > +        data, dtb_data, _map, _dtb =3D self._DoReadFileDtb(
> > +            'vendor/qcdt.dts', use_real_dtb=3DTrue)
>
> Only one record is covered. Since the whole point of QCDT is to hold
> multiple DTBs picked by msm-id/board-id, please add a test with at
> least two dtb-* records so the offset/size table-walking code is
> actually exercised.

Agree. Done in v3.

>
> > +    binman: Add QCDT support
> > +
> > +    This initial impl targets a streamlined v2 path, with no support f=
or
> > +    different versions or multiple qcom,msm-id/qcom,board-id tuples. I=
f/when
> > +    that's needed it will be implemented in a follow-up.
>
> How abouta Link: to the LK/AOSP reference for the QCDT v2 record format?

Good idea, done in v3.

Thanks Simon,
-Sam

>
> Regards,
> Simon
>
