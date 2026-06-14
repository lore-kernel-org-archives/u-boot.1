Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD4BCD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 16:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC98684105;
	Sun, 14 Jun 2026 18:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FwV/hEmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 762A98484C; Sun, 14 Jun 2026 18:20:04 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9E3683FEE
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 18:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-68acf0a15b3so3777680a12.1
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 09:20:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781454000; cv=none;
 d=google.com; s=arc-20240605;
 b=Aj8GUQjgqdKOipf7joSN0qu/qom+cwt9FxnJdd1dCmEBE1I+b1NunLGDqEAOyblIKc
 yHHdoXYeWlzlpcyK+Dp3G7scAzxuyC66VciIqFJT7h4n5i8uLgvCCY8+lMZJILA+T7y9
 PKd+xh9zXzDWs2AQZiEGYOC2RCzu1PGXUflfatis9R56Q0ujgeYtRIdBOh//3SGUGax9
 Z7mWJksXVF0pY0SAGgoLmza1Fz2cVLkzC6DQS9kwA+ByhLdot94SOTCF0CHqY2Xd8afz
 QOE15paVy1gnDKIXIIeQNcPDrl7qg+huKyj4Y6325lFknB8G9fTW7S9H5I+m1Rlr1tkE
 ruoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CXNKCd1TjZStnZCYZdf+6adusdw4fkD5OqX16tnyFkk=;
 fh=zR2buvS04tl8yfD/I/5YjPdhsEu7HKufx604qAmmYsI=;
 b=UC06D5wLXTUHcN6lhmfATpV6yukXADZqumP1uvEiUw/5DlTDNnM9L2HZ6W+h95ZQxl
 yu1V+HMAB4BrxuVnz3MvhBVdZUXxP+cQEk2WnuxPzKOcBUANwc/VTTXpvOKpHiFPKm3t
 7ZIJtVZzmSSvrkuA6/qIMBClBqNlO9ialJOR6m42zHU4N1EKY3RzN9YgtZVXm52UnKJD
 A1VVJyCM8AWKNHhLuvmCRygucGmh7OQumakDSASHap/xtBcyfj1Ty95+qARQ0d9GLSp9
 Y/g0bxDwjhkX6OWoNHXYh4DpXpTH4vxrBoNWuzNS5lHtmmZWVAmq8QukQzeYPEMpIONo
 Q4Eg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781454000; x=1782058800; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CXNKCd1TjZStnZCYZdf+6adusdw4fkD5OqX16tnyFkk=;
 b=FwV/hEmF47duVEyhG2ZenlB+cACoHYZqO4mVd9KxXEmtbS9/QabGVemY5BHDFgGRz/
 d85qnjPH9RGQ7dRUdAwsgCdcsvkWu3TanOmDx776xzFr4GzOxYkJYuXKX9Q2Lt+teT3U
 KnmJA+UjT26/D9QP7bFkdVVsXSU/MM2Ah7v88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781454000; x=1782058800;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXNKCd1TjZStnZCYZdf+6adusdw4fkD5OqX16tnyFkk=;
 b=Urt6s1IKu4isPBDK8GAer5k2JBy524pGUWlzo/ZkCS9Hz1mRmPhpGakoEmsWOVigMa
 pu/FOR+2DIg7mU6K1Aaz9OdAD/zdFqgDW1xzXw3Zlg77RPhwGog0XFUp3c+A8tJHf1xs
 z4/7zAyfvLqI9Rl2qK+a25DvpXCjxa0EySBtVYlXcFrrkMN4n+FSx2nsTi0bkevB5p0I
 9dWdXuTSgzQriDtCsAT6/bavY/7V53xcWRnUsZ/yMgB1V7DfWJcEr17pehLmYZ8xVbFI
 sMAOH2SaD1QkQfXMqVGLvtoAQie0QZkGJEzBUCEixQIhA8n1bc1zVBytVqUgOFxaBHxH
 y4Ig==
X-Gm-Message-State: AOJu0YzsksQyM7ChOdIcFljNcl9cxixsq2KPT8vV9vCu3rmPBCNnM1vn
 Z2LcCgy+oDs2K4A83vkD3qug493jJe2ISvA6FJWBWX5ygLe0qmbYMX08DqnHrm0uLjkreEEguy9
 zmI7axHNYKBlDcIk01as2tPPfwve7D3UCOCoX3r+q
X-Gm-Gg: Acq92OHDCBhzoWtnjqFdmIICwABy0FQsTFf0jXRPE21pI5OsLkLVbLqn8zLrEyU0qb3
 aQ5MyIDijMm7rbYgkmgVWadlOMVFOkrytPXW1z1k3gmMagaebOJ8CyYxDJVEV4OcOVPgtC23QMh
 sm+aU0TS6AORkyHJgwvXpaeMji5kNNZxxDbmJPl1NiCsOSTBCp8qAApLFpV1j4vN9VmWuYhApYP
 93JM/iXYcr7j0cnw4DJPd58udhI9260mCE3WED6M+IYwJganiAcoPLG6DjZiaYgN8RGfiXOlAdA
 EXoALHWxpE4wtNuL
X-Received: by 2002:a05:6402:40ce:b0:676:988e:8eb6 with SMTP id
 4fb4d7f45d1cf-69378a510femr4033608a12.26.1781454000385; Sun, 14 Jun 2026
 09:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
 <20260610-android-binman-v3-7-710298a38fcc@samcday.com>
In-Reply-To: <20260610-android-binman-v3-7-710298a38fcc@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 10:19:48 -0600
X-Gm-Features: AVVi8CcUmMiomcM9kMjSFUXz0LFdjZfWdx-T073j-qPV5NwgpHtEbs05gaeeX8U
Message-ID: <CAFLszTjOJdaQG1o_vAUkzzjSaNtAeAmn=5SoZiZghfji3waVVg@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] binman: Add QCDT support
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
 Henrik Grimler <henrik@grimler.se>, 
 yan wang <yan.wang@softathome.com>, Marek Vasut <marex@nabladev.com>, 
 Denis Mukhin <dmukhin@ford.com>
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

On 2026-06-10T01:27:41, Sam Day via B4 Relay
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
> In the following commit, support for DTBH will also be introduced.
> Because QCDT and DTBH share a lot of common behaviour, this commit also
> introduces a Entry_Android_vendor_dt_table base class.
>
> This impl was based on the lk2nd/CAF LK dtbTool script.
>
> Link: https://github.com/msm8916-mainline/lk2nd/blob/main/lk2nd/scripts/dtbTool
> Signed-off-by: Sam Day <me@samcday.com>
>
> tools/binman/android_vendor_dt_table.py            | 104 +++++++++++++++++++++
>  tools/binman/etype/android_boot.py                 |  31 ++++++
>  tools/binman/etype/qcdt.py                         |  80 ++++++++++++++++
>  tools/binman/ftest.py                              |  96 +++++++++++++++++++
>  tools/binman/test/qcdt.dts                         |  36 +++++++
>  tools/binman/test/qcdt_bad_msm_id.dts              |  17 ++++
>  tools/binman/test/qcdt_invalid_pagesize.dts        |  12 +++
>  tools/binman/test/qcdt_missing_msm_id.dts          |  12 +++
>  tools/binman/test/qcdt_missing_payload.dts         |  14 +++
>  tools/binman/test/qcdt_missing_subnodes.dts        |  13 +++
>  tools/binman/test/qcdt_multiple_dtbs.dts           |  34 +++++++
>  tools/binman/test/qcdt_page_size_from_abootimg.dts |  33 +++++++
>  tools/binman/test/qcdt_zero_pagesize.dts           |  12 +++
>  13 files changed, 494 insertions(+)

> diff --git a/tools/binman/android_vendor_dt_table.py b/tools/binman/android_vendor_dt_table.py
> @@ -0,0 +1,104 @@
> +class Entry_Android_vendor_dt_table(Entry_section):
> +    """Base class for legacy Android vendor DT table entries"""

The capital A breaks the naming convention every other entry type
follows (Entry_section, Entry_android_boot).

I'm not 100% sure about the best way to do this base class - but let's
run with what you have and see how it goes. We can always tweak later,
e.g. if someone else does a similar thing.

> diff --git a/tools/binman/android_vendor_dt_table.py b/tools/binman/android_vendor_dt_table.py
> @@ -0,0 +1,104 @@
> +    def ReadEntries(self):
> +        for node in self._node.subnodes:
> +            if self.IsSpecialSubnode(node):
> +                continue
> +
> +            payloads = self._GetPayloadSubnodes(node)
> +            if len(payloads) > 1:
> +                self.Raise("subnode '%s': must contain exactly one DTB "
> +                           "payload subnode" % node.name)
> +            if not payloads:
> +                continue

The qcdt docstring advertises dtb-* subnodes, but nothing here
enforces the name - any non-special subnode is treated as a DTB
record. Either enforce the dtb- prefix so a typo produces a clear
error, or drop the implication from the docs.

Also, silently skipping a record node with no payload subnode means
the missing-payload error only surfaces later in _GetDtbData() -
raising at ReadEntries time would give a more obvious error location.

> diff --git a/tools/binman/etype/qcdt.py b/tools/binman/etype/qcdt.py
> @@ -0,0 +1,80 @@
> +    Properties / Entry arguments:
> +        - page-size: QCDT page size, defaults to 2048, unless there's a parent
> +          android-boot node with an explicit page-size
> +
> +    This entry uses the following subnodes:
> +        - dtb-*: DTB records, each containing qcom,msm-id, qcom,board-id and
> +          exactly one DTB payload entry

The docs do not mention that QCDT_VERSION is hardcoded to 2, nor do
they describe what qcom,msm-id and qcom,board-id actually mean
(platform_id/soc_rev and variant_id/hw_subtype). Since the etype
rejects malformed values with a specific cell-count error, users will
need this info to author a working DTS. Please flesh out the
docstring.

> diff --git a/tools/binman/etype/qcdt.py b/tools/binman/etype/qcdt.py
> @@ -0,0 +1,80 @@
> +    def BuildSectionData(self, required):
> +        page_size = self._GetPageSize()
> +        dtbs = self._ReadDtbRecords(required, self._ReadDtbRecord)
> +        if dtbs is None:
> +            return None
> +
> +        size = QCDT_HEADER_SIZE + len(dtbs) * QCDT_RECORD_SIZE
> +        dtb_offset = self.AlignUp(size, page_size)

Just to check - page_size falls back to 2048 when no explicit setting
and no parent android-boot is found. There is no validation that
page_size is at least QCDT_HEADER_SIZE + N*QCDT_RECORD_SIZE; if a
caller sets a tiny page-size and many DTBs, the first dtb_offset
overflows into the page allocated for the header. Worth a sanity
check, matching the V0/V2 header-size checks in android_boot.

Regards,
Simon
