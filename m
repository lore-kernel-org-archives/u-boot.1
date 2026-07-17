Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A23C4451B
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 14:05:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 859A084E42;
	Fri, 17 Jul 2026 16:05:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eYw9Q1sF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D37F484E46; Fri, 17 Jul 2026 16:05:25 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA41384E38
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 16:05:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69a50189d25so14095733a12.3
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 07:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784297123; cv=none;
 d=google.com; s=arc-20260327;
 b=JW4TYCCBLB21toStVX94w+NBPXCa4BQzYs5ofEWZ/vqPUL9E/Etr9/ylMMrXyOpFt6
 T/gVeYUFg7+alx2EVjEMviKyZ24u4itnbxJvOvrhXQqxs12RBpS7CQ5mL23L6iHqWjuL
 OFx0Wd7l2MJI2GZKpIdb+HuyhhFcV31te+i3DgOtFsvWTWB3cGmUEnOo0n9PcWofCQwV
 OFzQWru0CwL9p4AI1jdyWS8/5S8Z/OYei6m/KITwiInDjTEzeiqRCQC4IPFeD5PfIZIx
 iB4jQsMoRm7cl7V2BKRUqHjMRFQtoa/S3i2ioCYj0aZ5I4LUTQsN7yQTzn/ATVXwTooJ
 /3gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=266rNNRwQ744yO/nby4D/G596h1ZPGzD1hwIp9WJ7zU=;
 fh=0Ck3+wBFRCQTDYxxJt1JJTgrKvHtPWROriE/svkzgkg=;
 b=E4YbsCq/vtdZw0JIYZgk9BxlH373Eq4+mxI2Uozeozr+jZzO6dVGkcypAwIBWn25xZ
 m4b5bsrm4Sd4IcQeU1h+oaoPMokFEw8lWICzG+fKIL2w8t8FfQFtKKIjQepii2HBKuG8
 NjAat0uYmACaKFLjBffPXwAxudng+uMR9BmMRyI8SorJU3jxGh5e4ZBFzxwyTuvPjb2k
 mXWDGcls2wcV1LipRupJvyuHuKGo+FXfN9gmi+YhmDMX46kUdezC1FVC5/cln5f4gWqZ
 cxfH4ZY7K7pP/Ng30mvhUJXzwdfUczwVZqhOoMs9Pg38/x10PEoaNt7L+ZSIkOEDOIrz
 ioHQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784297123; x=1784901923; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=266rNNRwQ744yO/nby4D/G596h1ZPGzD1hwIp9WJ7zU=;
 b=eYw9Q1sFDotLRRts1ib3sFg4XOtaDsS0f2lS6aq3ezMg/7hTUPGQ/gEmdoAptEw4AJ
 3hzdBBNY2z8JkMFOXc67tWoWXFvhM+VuILM8QsU2IxDoYO4uLDrplhpMNXNh59wol41m
 eSZCAaoLppk+pXl4ApFfsDcUSIhI+mk2RrfE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784297123; x=1784901923;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=266rNNRwQ744yO/nby4D/G596h1ZPGzD1hwIp9WJ7zU=;
 b=rBLTuWCEe2K9cheSnu4jyIAFIbgITdAs9oYgvgBA5y0QZ19XsfrqaKDmNoo4HdeT1E
 IRmU6ejirFG5Vz7TIqVrc6tmwLLp0kTLsPYGbXH4VaK4yIGEqZLC2B/9LMI5K8qf2R+L
 XBprL5MUFPC/V3A72KQJ2Q7Gc530SAWPEWgzp7D2au/f9I3RwaQKc1fO/BIa6Aj5QWRU
 6hI3FZpden//LaY+82PqTdiKbTf0ENSB+tyhUar3/99ixUPNA2XdOf47HjkM3TDUUCxO
 nFJrwVG1QbDE+l8fYRFXJYjITbErtT5nK1kcwNvNFViptNRWiXJP66MEbq71elh3rOds
 NybA==
X-Gm-Message-State: AOJu0YzBtuiXQnEi9zbYU4GnVe3R6FM6JiFRBCE4GSWvd9nMWaAYiTrC
 SXHGZw2BByyVT6he6GmXl0sErJDtWqK+i/PxlFIm0ywwn/zmqlUw5KfZvY+zyT/hQMKSHVqSrtS
 n1m4GRcRyjqdKaFNcbCurH3mn3W3XJCxJkVWJKY7O
X-Gm-Gg: AfdE7cksjlL9tkBBG8U47v/mVwKtdXSs7rox0jBp7x7NfYFJeIgzpUd1vbfOn3FjKvH
 0dQ3McTHOU/b2Y3/UjWF5H+AM0AJpdi9msSkVzeaDrwSpwGjymOLrMdh+unzsPcApgM29vdlHGb
 +/SyB0WIyBQ4vvy8XcWjZUA7UEuqVAdqrQU8UaPzBBn6DivhxvOCezoFgVwH32p8wu3R7f2r5ef
 VWUe9OWbWaHuOYsjfT5p1im3iET9W8mklwJvfDKSiB4veVb/8j0IYpCa11O
X-Received: by 2002:a05:6402:5055:b0:69d:4ed6:449a with SMTP id
 4fb4d7f45d1cf-69e6525a92fmr1049166a12.8.1784297122780; Fri, 17 Jul 2026
 07:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260715133716.10449-1-marex@nabladev.com>
In-Reply-To: <20260715133716.10449-1-marex@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jul 2026 08:05:09 -0600
X-Gm-Features: AUfX_mw7uCQEi1ZOD2KZ7IryYVfBos6CBd-t0IUniTvFNOkRwAzKKn11FdbgJDY
Message-ID: <CAFLszTgd-5XitS0XCDMVVboozbqmz_VhvyoU6=-NKJT6DZiuaw@mail.gmail.com>
Subject: Re: [PATCH] binman: nxp_imx8mcst: Handle FCFB header during SPI NOR
 boot
To: marex@nabladev.com
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
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

Hi Marek,

On 2026-07-15T13:37:04, Marek Vasut <marex@nabladev.com> wrote:
> binman: nxp_imx8mcst: Handle FCFB header during SPI NOR boot
>
> In case the image that is wrapped in the nxp_imx8mcst already contains
> an FCFB header which is mandatory for SPI NOR boot, then the IVT is at
> offset 0x1000 instead of offset 0x0, but the whole image including the
> FCFB header must be signed to prevent attacker from tampering with any
> of the headers. Add the FCFB handling.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
>
> tools/binman/etype/nxp_imx8mcst.py | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

> diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
> @@ -114,6 +115,13 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
> +        elif signtype == MAGIC_NXP_IMX_FCFB: # SPL/imx8mimage with FCFB
> +            # Sign the payload including FCFB and imx8mimage headers
> +            # (extra 0x1000 and 0x40 bytes before the payload)
> +            signbase -= 0x1040
> +            signsize = struct.unpack('<I', data[4120:4124])[0] - signbase

Please see below for test ideas.

Also, 4120 is quite obscure as a decimal literal. Since this branch is
the IVT one shifted by 0x1000, perhaps the two could be merged, e.g.:

    if signtype in (MAGIC_NXP_IMX_IVT, MAGIC_NXP_IMX_FCFB):
        off = 0x1000 if signtype == MAGIC_NXP_IMX_FCFB else 0
        signbase -= off + 0x40
        signsize = struct.unpack(
            '<I', data[off + 24:off + 28])[0] - signbase
        data = data[:signsize]

That makes it clear the value being read is the csf pointer at IVT
offset 24, same as the existing case. What do you think?

> diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
> @@ -114,6 +115,13 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
> +        elif signtype == MAGIC_NXP_IMX_FCFB: # SPL/imx8mimage with FCFB

Please can you also update the block comment above this code ("Parse
the input data and figure out what it is that is being signed") to
mention the FCFB case?

Here is my attempt at a test (it doesn't actually check the output though):

def testNxpImx8mCSTFcfb(self):
    """Test CST signing with an FCFB header (SPI NOR boot)

    When the payload is wrapped for SPI NOR boot it starts with an FCFB
    header, so the imx8mimage IVT sits at offset 0x1000 and the size word it
    carries is at offset 0x1018 (4120). Build a fake blob with the FCFB magic
    and that size word so the FCFB branch is exercised.
    """
    fcfb_data = struct.pack('<I', 0x42464346)
    fcfb_data += b'\x00' * (4120 - 4)
    fcfb_data += struct.pack('<I', 0)
    self._MakeInputFile('imx8m-ivt.bin', fcfb_data)
    with terminal.capture() as (_, stderr):
        self._DoTestFile('vendor/nxp_imx8_csf.dts',
force_missing_bintools='cst')
    err = stderr.getvalue()
    self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")

Regards,
Simon
