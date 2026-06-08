Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1ACCD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7478D8484F;
	Mon,  8 Jun 2026 15:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ftx6qRd1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFFD284869; Mon,  8 Jun 2026 15:27:16 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1FCF84825
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6913160c9ddso4720876a12.2
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 06:27:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780925234; cv=none;
 d=google.com; s=arc-20240605;
 b=E1RJWaZ7zFnrqvOjEF4FMCi+gJkPXV6+hoJaYpMd13o8U0amMUtRB9oOo2w+3Id7Lj
 0iR51qSG1ePg3Uad8EgxFg1l7DFiFDoZ5dRHwTNIiFCkarIzEzWmvNPE0jdsQVcGCFg0
 NTYwExxnHVwDjSvBXao1ChfhWRoGRQ6S/tcK/+PuxugcZxyB4qQCMHZ2Do4XFs/mGsdV
 FsUsBmpDLVWJaZvl7ZzEMvEelhyGg2iaSt5KRnu8ZWPe4b0dVOylQnqK2TPnEap1y3gr
 e/ikGXUsuALJIeAYBf0aPvBNT6Gr8zearq+Ov7QIkc/T+VHvFEl+NWHRtJmeUENMACXW
 9WsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=23CFCSKorPidvtaa3FljnkAmvqgfNjGlCPw09E7e2KQ=;
 fh=Odq9NGuM9IwpgVvl6kT7EijzuJ2AzFvZQNxDvfa4hmk=;
 b=T6jQ4Up5iEfSK9o4XY2/0HMPGioznkiUHWLQlXG/wcqQD/3/iWM2bz2DR1h7SFB+Kx
 y6VI5irD3xo57jo3k0SsYovFwbIw7r46+FSn6o8S8X401icHgjPvUDICmGwg9XC7WEA7
 VuwoScfaVwj/mQqFLO5A7KKW5rFUVxTlxKi97Ol2j3iVf+QT+QbenxGJf4w1ujAU6xUW
 NFZFtaiUZGLUJonaiyBkqUO4EWC0RRkepl2btVZLfhEg/h4vXQNX3okOXJlTQHRZt4hC
 du1BrebBLI0fZMhy3OW5Nn1D0GDx9b2xIgkdhspUmJ7IMkn0S6tLX7SdAHk5kLy7u7u5
 cvyA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780925234; x=1781530034; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=23CFCSKorPidvtaa3FljnkAmvqgfNjGlCPw09E7e2KQ=;
 b=Ftx6qRd1ZP9KTjdqSkEU6ZNjm++k2721Ew6SS5YZL9uVsJGRIYNLukOEpDg2B1zPa0
 f5fchSobVxCAZPT9zUlMwZT5ZN3kk58lU0cC0K4luJRW+4RJMaonWatRt+sb8Cq8pNIl
 MYtE91+6jTyP4X5FZ8uuk1nuYaJPpmRQ2xkiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780925234; x=1781530034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23CFCSKorPidvtaa3FljnkAmvqgfNjGlCPw09E7e2KQ=;
 b=TLvCCjFSn35lYo6+KwWJ2uKPgLR4w/y/9SxK422SaROrF3cUqWAw2npKTkTY5mHA0H
 QAJqQHY0aCOuemj6U5kF7j8zD/YYxg/Q98c6sjEebgSJMZxhKTZ+IVh5zW283mT5/t7o
 Kg1IiL85cd4Z5gaHe3lcp41mardZP8+lF05q1gcJiz6wj8gOlcQfr3IJ2+1ysBzhL/dy
 lkJXww6SR2MP4LcW0SIbdZdRFKmA/CjBsRZrQ+j7CUxVV9x1oxLYLGou50KU95g6Sd6P
 AGUCAf94UP2LF563S+18gaMa66TkEr8KrpW+pRtq/RmVK9swpKVks9u4pkBB41PnCPDS
 P3vQ==
X-Gm-Message-State: AOJu0YxQZJoHB7a41gsNgsaqXno1cIhYR6Ks1SdfZU3QisHlzBD+sxxg
 VJJyrmPnTIwqBQIf1nJLv5F6cJYBIa2QXvFYre/JFKd8x1s3g/bAIRbKNrOXUx/C+85Ki1ABW/k
 HjNil5hteZqNcN8ogr/r80MPfWQqWL7fumgC7FQgS
X-Gm-Gg: Acq92OFetKISwE9C5sr0tpM/Emo5LPXRmfhAz4SujjtZsTvtUGWilijFK+ylgYqVPie
 e7YpaPOLi607BRqhDgi2F0p7DVZhOucPqxvyWVjrgSxzV6C1aTkSJ3+bn07E1jCgyVaaBnw/zjZ
 776WKAju4/P32s74zXIhNIBoD+TMZlynUwgt2Qc6NA+xfL/SKCEUXt+2E8bkCfBvB+AF1YznTXY
 O0gTgkJFethXMSGo/Tx2iqgQToE8xi5e9pKBNq5dCukU+AVzFgfilbPUohZ7ZkzdN+l2YUUkgDs
 mI67OHOkJxaZFK3J
X-Received: by 2002:a05:6402:3711:b0:691:ad29:ea20 with SMTP id
 4fb4d7f45d1cf-691ad29ec32mr3314419a12.14.1780925234243; Mon, 08 Jun 2026
 06:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
 <20260608-android-binman-v2-4-b8203682507f@samcday.com>
In-Reply-To: <20260608-android-binman-v2-4-b8203682507f@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 8 Jun 2026 07:27:01 -0600
X-Gm-Features: AVVi8CdbYi4EzcbKwA3Zf1sgPqUZ1sWU1RMc6EtAYqhD1mZQX8dy5x6H5hWkaqY
Message-ID: <CAFLszTiwjGTY89dLVL0gm4oYwHadG7w_dWjEjOsKEBcEKf4Kwg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] binman: Add QCDT support
To: me@samcday.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Javier Tia <floss@jetm.me>, Minkyu Kang <mk7.kang@samsung.com>, 
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

On 2026-06-07T23:37:09, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> binman: Add QCDT support
>
> This vendor-specific format is used by many bootloaders on older qcom
> SoCs, such as msm8916. It's a container for N FDTs. Each one is
> contained in a record that includes metadata about the platform/variant
> it targets. The previous bootloader picks the 'right' record based on
> this metadata.
>
> This initial impl targets a streamlined v2 path, with no support for
> different versions or multiple qcom,msm-id/qcom,board-id tuples. If/when
> that's needed it will be implemented in a follow-up.
>
> Signed-off-by: Sam Day <me@samcday.com>
>
> tools/binman/etype/android_boot.py           |  30 +++++
>  tools/binman/etype/qcdt.py                   | 160 +++++++++++++++++++++++++++
>  tools/binman/ftest.py                        |  22 ++++
>  tools/binman/test/vendor/qcdt.dts            |  20 ++++
>  tools/binman/test/vendor/qcdt_bad_msm_id.dts |  17 +++
>  5 files changed, 249 insertions(+)

Your comment says "A legacy QCDT abootimg, the kind msm8916 bootloaders expect"

Please can you spell out the acronym...I would also prefer qcom_xxx
for the etype name where xxx is whatever this means, since presumably
this is Qualcomm-specific.

> diff --git a/tools/binman/etype/qcdt.py b/tools/binman/etype/qcdt.py
> @@ -0,0 +1,160 @@
> +from binman.entry import Entry
> +from binman.etype.section import Entry_section
> +from dtoc import fdt_util

The _align_up()/_pad() helpers at the top are duplicated from
android_boot.py in patch 1, and will be again in dtbh.py in patch 6.
Please factor them into a shared helper module (or stick them on
Entry_section).

> diff --git a/tools/binman/etype/qcdt.py b/tools/binman/etype/qcdt.py
> @@ -0,0 +1,160 @@
> +    def ReadEntries(self):
> +        for node in self._node.subnodes:
> +            if self.IsSpecialSubnode(node):
> +                continue
> +
> +            payloads = self._GetPayloadSubnodes(node)
> +            if len(payloads) > 1:
> +                raise ValueError("Node '%s': must contain exactly one DTB "
> +                                 "payload subnode" % node.path)

Please use self.Raise() throughout - that's the binman convention and
it adds the node path for you. The static/classmethod helpers should
become plain methods so they can use self.Raise() too.

> diff --git a/tools/binman/etype/qcdt.py b/tools/binman/etype/qcdt.py
> @@ -0,0 +1,160 @@
> +        dtb_offset = _align_up(12 + len(dtbs) * 24, page_size)
> +        records = []
> +        payloads = bytearray()
> +        for msm_id, board_id, dtb in dtbs:
> +            dtb_size = _align_up(len(dtb), page_size)
> +            records.append((*msm_id, *board_id, dtb_offset, dtb_size))
> +            payloads += _pad(dtb, page_size)
> +            dtb_offset += dtb_size
> +
> +        qcdt = bytearray(struct.pack('<4sII', QCDT_MAGIC, QCDT_VERSION,
> +                                     len(records)))
> +        for platform_id, soc_rev, variant_id, subtype, offset, size in records:
> +            qcdt += struct.pack('<IIIIII', platform_id, variant_id, subtype,
> +                                soc_rev, offset, size)

The 12 and 24 magic numbers should be struct.calcsize() of named
header/record format strings, the way android_boot.py does for
BOOT_IMAGE_HEADER_V0_SIZE. That also documents the layout.

Also, unpacking msm-id as (platform_id, soc_rev) and board-id as
(variant_id, subtype), then packing in the swapped order (platform_id,
variant_id, subtype, soc_rev) is hard to read. Please build each
record directly with the on-disk field order and add a comment
referencing the LK/AOSP source for the QCDT v2 record layout.

> diff --git a/tools/binman/etype/qcdt.py b/tools/binman/etype/qcdt.py
> @@ -0,0 +1,160 @@
> +    def BuildSectionData(self, required):
> +        if not self._node.subnodes:
> +            raise ValueError("Node '%s': Missing required DTB subnodes" %
> +                             self._node.path)

Redundant with the 'if not dtbs:' check further down (which correctly
handles the case where the only subnodes are special). Please drop it.

> diff --git a/tools/binman/etype/qcdt.py b/tools/binman/etype/qcdt.py
> @@ -0,0 +1,160 @@
> +    def _GetPageSize(self):
> +        if self._page_size is not None:
> +            return self._page_size
> +
> +        return getattr(self.section, 'page_size', 2048)

The docstring says "defaults to the parent android-boot page size",
but in practice this picks it up from the vendor-dt section that
_ReadVendorDtEntries() stamps with a page_size attribute. Please
update the docstring - or better, but really you should look up the
enclosing android-boot section directly rather than relying on an
attribute being monkey-patched onto an intermediate generic section.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5673,6 +5673,28 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testAndroidBootQcdt(self):
> +        """Test that binman can produce a QCDT container"""
> +        data, dtb_data, _map, _dtb = self._DoReadFileDtb(
> +            'vendor/qcdt.dts', use_real_dtb=True)

Only one record is covered. Since the whole point of QCDT is to hold
multiple DTBs picked by msm-id/board-id, please add a test with at
least two dtb-* records so the offset/size table-walking code is
actually exercised.

> +    binman: Add QCDT support
> +
> +    This initial impl targets a streamlined v2 path, with no support for
> +    different versions or multiple qcom,msm-id/qcom,board-id tuples. If/when
> +    that's needed it will be implemented in a follow-up.

How abouta Link: to the LK/AOSP reference for the QCDT v2 record format?

Regards,
Simon
