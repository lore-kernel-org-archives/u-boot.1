Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B73CD98F2
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 18:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 805DE84119;
	Sun, 21 Jun 2026 20:18:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HFFy/aXJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BAFC84869; Sun, 21 Jun 2026 20:17:59 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A45984105
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 20:17:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-69764612e55so3277706a12.3
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 11:17:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782065876; cv=none;
 d=google.com; s=arc-20240605;
 b=BWnoVB8hpflmBmvAlXVuCTQNP782h81jkvy7ZpCCyhq5P7brk/GnHOsV30sjUToE/V
 FKAQ9g0iEURizdcSMIvzjFVS2NwvXWryzdOJbuUYpTZm3PJyZNJUWEgNoHj62g+JPEdJ
 DbPl5n2uN/qq3bVQFiEkfvdtWXpbLzWLVwmAgWm7W27xCEZRvt+yZV+YM3+yGXOdd4Lp
 cdYNj05cbN34wWee7Y6hzuqKgRAiyulUM5O704YKHemoGbppwV/B8CPLlA7tf0qcLzi5
 KV4D739OvIwhaNn+ffHQc7pQkvruyfIIGvLRCgTE1lRgcs1bX0fYMsLpG0w/YY1JSCg7
 F0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cbjQFmwhAeFUE8xPrGspM++kIbcBeGQTqC+rcqwbSQs=;
 fh=T2gsTWyhJ/JEA8HZ9q6S8I9r06x7Bla+FvlPy9O7BgQ=;
 b=ADJx5eFxny06tZQ/AebdhVCSGxPAzKcUA5Iapa6KaZB8DlmPb/qW5/OhVkKqXyBHZY
 3kl1qFVOb66kkF/AugDPkcM+y6dZDqBosaKK7gKEOVWcAGqYbMCqedv+kUq718RDJ10z
 I8jhygrwXMXtThppxv4RQid85HrvtWF0G01KMl9WA7Hi7f5i1xDsH4t2JM96gjLyAnpY
 w7q9QZHSBfqOxVPTzHIDZFedz/5yEypi/RpYBtlRdPnkT3eqTeidEITxNGgJsg73gSPY
 Ia57QZrrV+ndwMVMXYWt8zrFXdV2eSNIgzCZ9N59utufcTG1wPnHap/lKVqlJsoGdQny
 kQcg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782065876; x=1782670676; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cbjQFmwhAeFUE8xPrGspM++kIbcBeGQTqC+rcqwbSQs=;
 b=HFFy/aXJEztRkGVL8Fs26znDpC8pqSbVsEtvrZcICiU8VBEs1uzQArWrF56xDSCPSJ
 RRDacqOvqFgmiza3Zd3MH+72uTNy/i2+3Q6wlbVAl8xu7womXI8F4yNhFfGpi8JuSTgL
 a2q/970WwJrkPTzRC/8F4dorlOFaTMP166nb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782065876; x=1782670676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cbjQFmwhAeFUE8xPrGspM++kIbcBeGQTqC+rcqwbSQs=;
 b=aQ9B9EKA3GNkuaciiUxh2rvTJQTLCTlt7JKFogvCYFIMLjeLClgHW8Y+yU0acQbLKw
 DltkgavKcMDfSNOoPRLYxF4gtOpgz8YInwU1Wy6Yv9ZyhbMsSmCnsj5UCYFwz5ucWg9v
 Z+FwlPEf7+FchHaIdxE2pCetdxwH0oE7pRVyhqYMzxu+BWMVyeg+Mim8PFFfyTnusCw9
 r8srklHihpAd9fMLBXyYoFfeHJOSf/tX3n1LIF0gBxZYqaIbyYtncqHQHC5lEJt+uq/5
 wNRnDNkg1znPTsyb7oVJ+q5M/a4Ed35H//3H2YcP5c6pFSlrR+EPtxv4VpvveupXYcnq
 dLbg==
X-Gm-Message-State: AOJu0Ywox/N8pMSVnZS1HJJADt4TgJy6YLDl7++bGZprmt5OD3ugOXRy
 ADJkCvOXrG75ad1lVonc21dCiJs6zRysGzU8tLmJt2o0DsU1AJX85iVGUtTIgeujN/xuQHTRiqZ
 +ugFhWPlaamWewUJ79aAI4mWoIHHskHyc43zxUME1
X-Gm-Gg: AfdE7cnAprRYy2oc/ad33pIuUWkR9ZC8xDQZWtSiW7beEbio9+PuzqIq+QMUriJQjOF
 thAPVsUmYFiL12C7CkVbutf/zKCFvO3BU4RrGtkkDNx7RRLx1wtzFofdeo5ulIboC5fCiiqWqYp
 CSwRYVBbngWhYYz4Vuki6CoGFZksPjntQXG6sd9kQ5ukWQF+AxHhZenH5E3e9g9KcNIEUo51vgD
 1gFuFqxVQMVP69/vViM+WzJlmlv/BqYkj65Cuc3MX84MI7KaSyPRcOJgJFjdSI1ilHDLAiCFg==
X-Received: by 2002:a05:6402:50d4:b0:695:d6fa:4de4 with SMTP id
 4fb4d7f45d1cf-696e521d910mr5859117a12.24.1782065876416; Sun, 21 Jun 2026
 11:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
 <20260608-android-binman-v2-4-b8203682507f@samcday.com>
 <CAFLszTiwjGTY89dLVL0gm4oYwHadG7w_dWjEjOsKEBcEKf4Kwg@mail.gmail.com>
 <mFBeep4TItLmAzHEARn8dSSTsKEDywCH4tWLz1ExMQY93_zF4kTZCAZZOzrAPLRLFAkaiqS8R9QB5GkbDUqLU1phHrwlRrZdeVKgm7WiZDo=@samcday.com>
In-Reply-To: <mFBeep4TItLmAzHEARn8dSSTsKEDywCH4tWLz1ExMQY93_zF4kTZCAZZOzrAPLRLFAkaiqS8R9QB5GkbDUqLU1phHrwlRrZdeVKgm7WiZDo=@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 21 Jun 2026 19:17:45 +0100
X-Gm-Features: AVVi8Ce-KEBA8S6h3N3_NlGIShaKu1KSSNTXwPl9DuqC3P0EuydcaLdh7WPEHSo
Message-ID: <CAFLszTiEiXjMc5YFMQMTHn+nsibzpkaOXo=9TVepWebiP56W6w@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] binman: Add QCDT support
To: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Bryan Brattlof <bb@ti.com>, Yannic Moog <y.moog@phytec.de>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Javier Tia <floss@jetm.me>,
 Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>
Content-Type: text/plain; charset="UTF-8"
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

Hi Sam,

On Wed, 10 Jun 2026 at 02:43, Sam Day <me@samcday.com> wrote:
>
> Greetings Simon,
>
> On Monday, 8 June 2026 at 11:27 PM, Simon Glass <sjg@chromium.org> wrote:
>
> > Hi Sam,
> >
> > On 2026-06-07T23:37:09, Sam Day via B4 Relay
> > <devnull+me.samcday.com@kernel.org> wrote:
> > > binman: Add QCDT support
> > >
> > > This vendor-specific format is used by many bootloaders on older qcom
> > > SoCs, such as msm8916. It's a container for N FDTs. Each one is
> > > contained in a record that includes metadata about the platform/variant
> > > it targets. The previous bootloader picks the 'right' record based on
> > > this metadata.
> > >
> > > This initial impl targets a streamlined v2 path, with no support for
> > > different versions or multiple qcom,msm-id/qcom,board-id tuples. If/when
> > > that's needed it will be implemented in a follow-up.
> > >
> > > Signed-off-by: Sam Day <me@samcday.com>
> > >
> > > tools/binman/etype/android_boot.py           |  30 +++++
> > >  tools/binman/etype/qcdt.py                   | 160 +++++++++++++++++++++++++++
> > >  tools/binman/ftest.py                        |  22 ++++
> > >  tools/binman/test/vendor/qcdt.dts            |  20 ++++
> > >  tools/binman/test/vendor/qcdt_bad_msm_id.dts |  17 +++
> > >  5 files changed, 249 insertions(+)
> >
> > Your comment says "A legacy QCDT abootimg, the kind msm8916 bootloaders expect"
> >
> > Please can you spell out the acronym...
>
> I'd love to, but I think nobody can actually do that. There's not
> really any canonical impl or reference point for this stuff. I believe the
> reason everyone calls it "QCDT" is because that's the magic identifier in
> the header.
>
> Maybe it means "QualComm Device(tree) Table"? Or perhaps it means
> "Qualcomm/CodeAurora Device Trees"? We may never truly know :)

Hilarious :-)

>
> > I would also prefer qcom_xxx
> > for the etype name where xxx is whatever this means, since presumably
> > this is Qualcomm-specific.
>
> Given the acronym doesn't have a canonical definition, and the limited
> references to it use the "QCDT" moniker directly, I opted to keep it as-is
> for v3, since `qcom_cdt` is confusing and would be a unique reference that
> exists only in U-Boot. Or would you prefer qcom_qcdt?

Let me look. Mostly it is about being unique...I quite like the idea
of a qcom_ prefix but it isn't very important.

>
> >
> > > diff --git a/tools/binman/etype/qcdt.py b/tools/binman/etype/qcdt.py
> > > @@ -0,0 +1,160 @@
> > > +from binman.entry import Entry
> > > +from binman.etype.section import Entry_section
> > > +from dtoc import fdt_util
> >
> > The _align_up()/_pad() helpers at the top are duplicated from
> > android_boot.py in patch 1, and will be again in dtbh.py in patch 6.
> > Please factor them into a shared helper module (or stick them on
> > Entry_section).
>
> I opted for the latter. v3 introduces a new patch to put these
> shared helpers in Entry_section.
>
> >
> > > diff --git a/tools/binman/etype/qcdt.py b/tools/binman/etype/qcdt.py
> > > @@ -0,0 +1,160 @@
> > > +    def ReadEntries(self):
> > > +        for node in self._node.subnodes:
> > > +            if self.IsSpecialSubnode(node):
> > > +                continue
> > > +
> > > +            payloads = self._GetPayloadSubnodes(node)
> > > +            if len(payloads) > 1:
> > > +                raise ValueError("Node '%s': must contain exactly one DTB "
> > > +                                 "payload subnode" % node.path)
> >
> > Please use self.Raise() throughout - that's the binman convention and
> > it adds the node path for you. The static/classmethod helpers should
> > become plain methods so they can use self.Raise() too.
>
> Ack, done in v3.
>
> >
> > > diff --git a/tools/binman/etype/qcdt.py b/tools/binman/etype/qcdt.py
> > > @@ -0,0 +1,160 @@
> > > +        dtb_offset = _align_up(12 + len(dtbs) * 24, page_size)
> > > +        records = []
> > > +        payloads = bytearray()
> > > +        for msm_id, board_id, dtb in dtbs:
> > > +            dtb_size = _align_up(len(dtb), page_size)
> > > +            records.append((*msm_id, *board_id, dtb_offset, dtb_size))
> > > +            payloads += _pad(dtb, page_size)
> > > +            dtb_offset += dtb_size
> > > +
> > > +        qcdt = bytearray(struct.pack('<4sII', QCDT_MAGIC, QCDT_VERSION,
> > > +                                     len(records)))
> > > +        for platform_id, soc_rev, variant_id, subtype, offset, size in records:
> > > +            qcdt += struct.pack('<IIIIII', platform_id, variant_id, subtype,
> > > +                                soc_rev, offset, size)
> >
> > The 12 and 24 magic numbers should be struct.calcsize() of named
> > header/record format strings, the way android_boot.py does for
> > BOOT_IMAGE_HEADER_V0_SIZE. That also documents the layout.
>
> Hm yeah, I got lazy here. v3 removes the magic values and formalizes
> the format/size calculations like android_boot does.
>
> >
> > Also, unpacking msm-id as (platform_id, soc_rev) and board-id as
> > (variant_id, subtype), then packing in the swapped order (platform_id,
> > variant_id, subtype, soc_rev) is hard to read. Please build each
> > record directly with the on-disk field order and add a comment
> > referencing the LK/AOSP source for the QCDT v2 record layout.
>
> Ack - this isn't very readable, I agree. Overhauled in v3.
>
> >
> > > diff --git a/tools/binman/etype/qcdt.py b/tools/binman/etype/qcdt.py
> > > @@ -0,0 +1,160 @@
> > > +    def BuildSectionData(self, required):
> > > +        if not self._node.subnodes:
> > > +            raise ValueError("Node '%s': Missing required DTB subnodes" %
> > > +                             self._node.path)
> >
> > Redundant with the 'if not dtbs:' check further down (which correctly
> > handles the case where the only subnodes are special). Please drop it.
>
> Ack. v3 refactors this heavily and the redundant check is gone.
>
> >
> > > diff --git a/tools/binman/etype/qcdt.py b/tools/binman/etype/qcdt.py
> > > @@ -0,0 +1,160 @@
> > > +    def _GetPageSize(self):
> > > +        if self._page_size is not None:
> > > +            return self._page_size
> > > +
> > > +        return getattr(self.section, 'page_size', 2048)
> >
> > The docstring says "defaults to the parent android-boot page size",
> > but in practice this picks it up from the vendor-dt section that
> > _ReadVendorDtEntries() stamps with a page_size attribute. Please
> > update the docstring - or better, but really you should look up the
> > enclosing android-boot section directly rather than relying on an
> > attribute being monkey-patched onto an intermediate generic section.
>
> Indeed. v3 refactors this heavily to introduce a shared base class, which
> prefers a locally set page-size, falling back to traversing the ancestry
> to find an android-boot preference (and finally falling back to 2048).
>
> >
> > > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > > @@ -5673,6 +5673,28 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> > > +    def testAndroidBootQcdt(self):
> > > +        """Test that binman can produce a QCDT container"""
> > > +        data, dtb_data, _map, _dtb = self._DoReadFileDtb(
> > > +            'vendor/qcdt.dts', use_real_dtb=True)
> >
> > Only one record is covered. Since the whole point of QCDT is to hold
> > multiple DTBs picked by msm-id/board-id, please add a test with at
> > least two dtb-* records so the offset/size table-walking code is
> > actually exercised.
>
> Agree. Done in v3.
>
> >
> > > +    binman: Add QCDT support
> > > +
> > > +    This initial impl targets a streamlined v2 path, with no support for
> > > +    different versions or multiple qcom,msm-id/qcom,board-id tuples. If/when
> > > +    that's needed it will be implemented in a follow-up.
> >
> > How abouta Link: to the LK/AOSP reference for the QCDT v2 record format?
>
> Good idea, done in v3.
>

Regards,
Simon
