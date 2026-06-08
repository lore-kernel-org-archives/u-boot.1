Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E31FCD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 343828484F;
	Mon,  8 Jun 2026 15:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OsByfVoZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97DF98487C; Mon,  8 Jun 2026 15:27:40 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E861A84874
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-36ba285e98bso4189600a91.2
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 06:27:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780925255; cv=none;
 d=google.com; s=arc-20240605;
 b=VaAN3/lRGX1f0YcsXnoKmgenwdUZ+awXzhEc7XERkrowpPY7ogU4RqKqjqCESZmdv5
 2chyvtrITWHOCLKzdlqYGDRFQytmSQMnefvZC2+KWplusOJu2n6RmdUjnsdb8X/+lcOy
 t0KAxqh91BtxtdNrefEaU6I96AEjsLBUq5kb0Txx6VZPiYAYWmM3M8Ni/XNmOso2n50D
 Zb+5AhFrJhnD3tcOBTS+UJ1o8t7nMAdRK/25nHcYkzECrbhxiEaPakznElps6aSFnScD
 nRmqG1gms3Uf+mMo9LVgwbbRIQe1gy5EWi45cs8L3QGJmtt9e4J5E7I6wZ9kIQsMKuWk
 1/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=k3rQMlJPCrEiuBbNOg76nXX0GhlvzWFOcWjlNrxbCx8=;
 fh=Odq9NGuM9IwpgVvl6kT7EijzuJ2AzFvZQNxDvfa4hmk=;
 b=ASsWwFPfSBIh5t8gQw51vTraEt7IFxHQruVSZEPpMHPuH9JWM0bgjmN8BGtcz9TDdb
 v4kTZWN5SPp6oOhU7qFmmMyNCY1gzIV+8ac35pCNMrrKTzxqKeg2d7dLDi2Xg3FbHBq9
 TnlXoPHPGz+qkLl6JX4NcqcqBBTadkDuX1OYbarSZovZvNiwWota+Q6XjdFa0Jt7Mpt+
 6OJo2q8L1TCi3Rlzo+ZxSGKoVHDKtJrtRuESGvjK0WszCc8xWamuP7YRc29D4RWIFQt4
 cdDsOupQIJUWq8z8levObDxpE0y5sq6ADAfg1of+N0RKMcsjERkF1mT4aRGyYioyBc2M
 0fbw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780925255; x=1781530055; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k3rQMlJPCrEiuBbNOg76nXX0GhlvzWFOcWjlNrxbCx8=;
 b=OsByfVoZU3EMelQh4w64ElCn4KtUd2w2O8R19yDot2jNEzsnW4O6rOvPGWFlRwMMM6
 OzC7PIfPaJ6MMQ42mUcpOF2g/TAShRfgd9FoIFY9C2KNwfV8Xt97O9xaRvmt6b2kBVxx
 NoAc90lkn2EuyPtdy23sr0v4qq47F99kU+A3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780925255; x=1781530055;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k3rQMlJPCrEiuBbNOg76nXX0GhlvzWFOcWjlNrxbCx8=;
 b=nwQQkHQGZ6n/zl2022k/yvIIr4RxzuYtXZOnRJ21II87iHtfLG2hu1nkM1qhwg2Gr6
 u30QceResH354VSE5c96w+CpDVVXun7smRg5wB73gB1iVpUez6FpfxVFp/jRqGUGFNmc
 l2XnYS4BiSUJ672T7PY0CjrpcgST/4ZY1eG0lRiDrbsuVgnUxdk2sJxhBDXPsnXjH3q1
 sq04NOwe5hCOas/xC2yJCtOu4S565+13Y9gFFb1ChFJJXrjRnYWG/TtWBP8feQFrW25a
 gbOr6vWzeSxk0IjoPxU3SUcor9kraEofpy6VSGbvYPIA5mHWykpH8xQ06EhxH5GNZazn
 7JrA==
X-Gm-Message-State: AOJu0YwXp6axZFszwJ2mmlk4vhyp16OXN+a3sLoSPJwMWCWFBLG/57rW
 Gc/zE0+7EBERYAKlM4F59JwnUNLTcBsZKDssLo4VrAMS7adxLgapSHq7DS0pijs9c80eZfK5E/V
 RT1Wqnep9qf1Rz1mrgnbcV7b0t39XrL3MsgS7pTue
X-Gm-Gg: Acq92OEpm5psbKXXTXupeUsLXENtXiCo5/Y7JQSfNpBP0+hpWVpXj4+0Xn44Soea5ak
 GoozWqyGNO79gHsf/zkQFad6C777wy3FYgk4HZMB5wd58/hZ9/jvxZaZq1/9WJsI6B/PAHgtXfO
 gVaKPx9p3eJZkF3etiJX7piiK6PU+WRWmxD610jQ2SZ5y3ScTr3n3ZpK+Kd/KUsZC/mU4O5yr5M
 6e1Pz1NznhHLDLA/P5TyzJ+RlQsIvTRgeahIvf2gO7/7lnVhppg5BQ6TAK1jHvbs2EbhfBJZP4g
 v3P73etSwGTzoWJoadkBkzWuiVA=
X-Received: by 2002:a17:90b:3b49:b0:36d:6315:1de4 with SMTP id
 98e67ed59e1d1-370f096ab48mr16094278a91.17.1780925255041; Mon, 08 Jun 2026
 06:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
 <20260608-android-binman-v2-6-b8203682507f@samcday.com>
In-Reply-To: <20260608-android-binman-v2-6-b8203682507f@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 8 Jun 2026 07:27:09 -0600
X-Gm-Features: AVVi8CdMIc_-h8BXGYDkrOj1uhCK2F_M7IpH3wDq9NXCdG9HrfFVwIlEmxpRqxg
Message-ID: <CAFLszThNc+WNrezGQgGEv63_AG=vPHHCa-UWLKhduoVkiLgWog@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] binman: Add DTBH support
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
> binman: Add DTBH support
>
> DTBH, used by Samsung S-BOOT bootloaders, is similar to QCDT. That is,
> it's a multi-record container that carries vendor-specific magic values
> to assist the previous bootloader in picking the appropriate FDT for the
> booting device.
>
> dtbTool-exynos was used as a reference for this implementation.
>
> Link: https://github.com/dsankouski/dtbtool-exynos
> Signed-off-by: Sam Day <me@samcday.com>
>
> tools/binman/etype/android_boot.py               |  20 +++
>  tools/binman/etype/dtbh.py                       | 173 +++++++++++++++++++++++
>  tools/binman/ftest.py                            |  24 ++++
>  tools/binman/test/vendor/dtbh.dts                |  29 ++++
>  tools/binman/test/vendor/dtbh_bad_model_info.dts |  19 +++
>  5 files changed, 265 insertions(+)

> diff --git a/tools/binman/etype/dtbh.py b/tools/binman/etype/dtbh.py
> new file mode 100644
> index 00000000000..90769e5d016
> --- /dev/null
> +++ b/tools/binman/etype/dtbh.py
> @@ -0,0 +1,173 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +# Entry-type module for Samsung Android DTBH tables
> +
> +import struct
> +
> +from binman.entry import Entry
> +from binman.etype.section import Entry_section
> +from dtoc import fdt_util

A lot of duplication between this file and qcdt.py - _align_up(),
_pad(), _DtbEntryName(), _GetPayloadSubnodes(), ReadEntries(),
_GetPageSize(), _GetDtbData() are essentially identical. Perhaps you
can factor the common bits into a helper or even a shared base class
(something like Entry_vendor_dt_table), with the two etypes only
carrying their format-specific bits.

> diff --git a/tools/binman/etype/dtbh.py b/tools/binman/etype/dtbh.py
> @@ -0,0 +1,173 @@
> +    def BuildSectionData(self, required):
> +...
> +        header_size = _align_up(12 + len(dtbs) * 32 + 4, page_size)

What is the trailing '+ 4' for? Nothing gets written after the
records, and the QCDT calculation uses just '12 + len(dtbs) * 24'. If
it's meant to reserve a terminator cell, the code should emit it too;
otherwise please drop it (or add a comment explaining the layout
invariant from dtbTool-exynos).

> diff --git a/tools/binman/etype/dtbh.py b/tools/binman/etype/dtbh.py
> @@ -0,0 +1,173 @@
> +    @staticmethod
> +    def _GetDtbRootU32(node, data, propname):
> +        import libfdt
> +
> +        try:
> +            fdt = libfdt.Fdt(data)
> +            root = fdt.path_offset('/')
> +            prop = fdt.getprop(root, propname)
> +        except libfdt.FdtException as exc:
> +            raise ValueError("Node '%s': Missing required DTB root property "
> +                             ''%s'' % (node.path, propname)) from exc

Please move 'import libfdt' to module-level imports - that's the
convention in binman. Also, catching FdtException to report 'Missing
required DTB root property' will mis-report any other libfdt failure
(e.g. a malformed FDT). Validate the FDT once up front and only wrap
the getprop() call, so genuine parse failures surface with their real
cause.

> diff --git a/tools/binman/etype/dtbh.py b/tools/binman/etype/dtbh.py
> @@ -0,0 +1,173 @@
> +DTBH_MAGIC = b'DTBH'
> +DTBH_VERSION = 2
> +DTBH_PLATFORM_CODE_DEF = 0x50a6
> +DTBH_SUBTYPE_CODE_DEF = 0x217584da
> +DTBH_SPACE = 0x20

DTBH_SPACE is unexplained. Please add a comment describing what this
field means in the DTBH record layout (and why 0x20 is the right
constant), or make it a documented property like 'platform' and
'subtype' if it varies in the wild.

> diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
> @@ -141,6 +141,26 @@ class Entry_android_boot(Entry_section):
> +        A legacy DTBH abootimg, the kind some Samsung bootloaders expect:
> +
> +        android-boot {
> +            header-version = <0>;
> +...

The QCDT example added in patch 4 does not set header-version
explicitly, while this one does. Please make them consistent.

> diff --git a/tools/binman/test/vendor/dtbh.dts b/tools/binman/test/vendor/dtbh.dts
> @@ -0,0 +1,29 @@
> +     model_info-chip = <7870>;
> +     model_info-hw_rev = <6>;
> +     model_info-hw_rev_end = <6>;

These properties end up at the root of the test DTB, which is what
'u-boot-dtb' embeds, so _GetDtbRootU32() picks them back out of the
payload. That works but is subtle - a one-line comment at the top of
the test DTS noting that the test relies on the binman test DTB being
its own DTBH payload would save the next person a few minutes.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5701,6 +5701,30 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testAndroidBootDtbh(self):
> +        """Test that binman can produce a DTBH container"""
> +        data, dtb_data, _map, _dtb = self._DoReadFileDtb(
> +            'vendor/dtbh.dts', use_real_dtb=True)
> +
> +        dtb_size = tools.align(len(dtb_data), 0x800)
> +
> +        self.assertEqual(b'DTBH', data[:4])
> +        self.assertEqual((2, 1), struct.unpack_from('<II', data, 4))
> +        self.assertEqual((7870, 0x50a6, 0x217584da, 6, 6, 0x800,
> +                          dtb_size, 0x20),
> +                         struct.unpack_from('<8I', data, 12))

Please also add a test exercising non-default 'platform', 'subtype'
and 'page-size', and one with more than one dtb-* subnode - at the
moment only the single-record default-everything path is covered,
which leaves the multi-record offset arithmetic untested.

Regards,
Simon
