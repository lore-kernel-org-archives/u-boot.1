Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693FCC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 11:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2E9D846FD;
	Thu,  2 Jul 2026 13:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZDBfOVPz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFE31847C3; Thu,  2 Jul 2026 13:14:13 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A10E7843B6
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 13:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c126553552dso233588766b.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 04:14:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782990851; cv=none;
 d=google.com; s=arc-20260327;
 b=kKfOeTPQ7v29Gvp0mebCuGpk/b9wlqplo2TL/GA4tpEk20n0C0XneRbJtYoASwX6/7
 vzhpYGets5Y/DyFKqzOArwUV3pBvitmp5PTUI396XJUCE1aijCo8qHKV6tSTkRs2z6v9
 385c65m8F6Wi1Ly9vanqKlH/N1Mka+Is6xcp1ZDfyeNINLePQ1YtQMh76Sa+06Axcg0D
 L0l5lvSZwx0KWRk7S3/Xqfu39+gSz0cMry3acwmhr5VTcaG+WUyfYivGCkWe4CPeeCP7
 nM/tANHFEOF0WGgUZFggYjwfwPwP8nLVPWXrSXrCthhthe6PkRk8fn5cIcMJCuV7Se2B
 qfUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Kfz+SvqXYzxCWDi3E3x350mnu6RbO5ko2lXfrElhSK0=;
 fh=Xp5J/VfCD0qkvaCCCQEkAYzbOL7azc4qfGk27KxUsjo=;
 b=j5XeqbwgPi+0HK39t/vxgHKt/gZgGP/RlWZgXl4vObVonV+Moo8w+h31Kv0Jhpr+Ph
 J5h/XRNjf9KqSFkFCzTPgF3cv0EAR0UMbxHi/GAlqZPPhmsYqci+5T5YpWM8xmuQXPEr
 6tJcBX8Js+c1F4ysxECRZM7sBulHv7WvZ649KkdjNtpgZU7Xs8VSXVGlQ12tebqUKqyi
 wd5X/rWu4nClICFrgp+fWsz1g1n7PFgtOb36WPl5MBYgjUX3f5eHVL9xhYezXtj3gUE3
 bY1vsYVbINVtljtvvTWLuVng9THszBXRVLyE7/nHupc9sWTvFjkHCVG8j8tTO+lAzwic
 R3/Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782990851; x=1783595651; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kfz+SvqXYzxCWDi3E3x350mnu6RbO5ko2lXfrElhSK0=;
 b=ZDBfOVPz9QDBmTHaWLK75fFv2Xh918oLYpZhC7ueKevicGwZQc5drPFANq1U1Vee+i
 4r07etr62Shr3oKi9MxL3FFRVEfRU0ITaw+oxu2aJAFw3lYcemqMXtI6uwnHNfU8TI9c
 he7H9B8xYwu+4eYOJYKqBZErMp2pxutB9tTDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782990851; x=1783595651;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kfz+SvqXYzxCWDi3E3x350mnu6RbO5ko2lXfrElhSK0=;
 b=hqgaiqfXydQugnplhqQ313+yoC//uHrVU0D3e+47ABBw1YnSQEVASlGzXUfI6czrq0
 +BLqVP/o1UsT55rx8ax35QdCu1MeVcy+UZP515opl2EAXxYRq+H9QirK48EGpKB5yeKp
 1zyGg9OVWcMyeY9C4rtlthqzL1fVYhbt0v3A0fHVHH+5+BxCmCPGcgAZC0eRJ5u84NeA
 BYo53wQ6eJljzmzpKwBtuMX8XpvksB8DZAQCLvItcRBPFtaY9X7UfBWWZvHxXrQXUEek
 63lDpMxpAeYnZhPRk/8KzypY9t1p+gDOElLfW8nLQYrj9ApuvlldRHkr29lyWnbFydk9
 iRaQ==
X-Gm-Message-State: AOJu0Yw6V/+6mESj1xUZrurJAwzZmn45ovvmOvnEHey52N8XKe7KF8Cq
 c5V2qF3RUGatL9/X7Vhf2WfWKNVQ50y/quhY8Sybm5s9pVXhXjO0BQ0Kn/b+MsXK2erODnorGO+
 K/90ZfgTUFYRwbmV6CiuAmJD9+WGyFMAnWcvkodqYNwrVsaAYUbY8cUH3
X-Gm-Gg: AfdE7cm0llUqQJ4ulqkg7r4OTwVA44HBOe7eZs8rObquYOtlQUh2i/oAU/vXLnKm6zN
 erlEcdApSiUAOWs+S7mLaqjzlyWVQ6fICfts7zOuFiEWe3x8gm+vLH7ulgewEJ5yrRg7FFyOa1p
 EJ8/J+fTRLTL+HcxzoM4V2HpxxzKcqdKIC098ST/zNHqyIzm/fu3Y0TA1gjIwNS/fTkjE/KUq7c
 d0iwM1flY22NMyEz9d8sBPGsYU5XQFBPmPpV1hCleAldclQe9L45FiA5lN2Pgq84/DnNT3viA==
X-Received: by 2002:a17:907:8b8e:b0:c12:abd3:38c3 with SMTP id
 a640c23a62f3a-c12abd33a2cmr235664666b.5.1782990851070; Thu, 02 Jul 2026
 04:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260630084112.13259-1-marex@nabladev.com>
In-Reply-To: <20260630084112.13259-1-marex@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 12:13:58 +0100
X-Gm-Features: AVVi8CdbFNVfkmNJzVZzFn0g-mO8DoY1lZ4QZo0bEv7xk_XV8d-Usg07_tdKc7A
Message-ID: <CAFLszTgCOOOxhgP3n7EXGK4eMWNmmiFyCtc6mKNGmCinRYZdDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] binman: imx8mimage: Generate FSPI header in binman
 instead of mkimage
To: marex@nabladev.com
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, Yannic Moog <y.moog@phytec.de>
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

On 2026-06-30T08:40:46, Marek Vasut <marex@nabladev.com> wrote:
> binman: imx8mimage: Generate FSPI header in binman instead of mkimage
>
> Stop depending on the current mkimage method of generating the FSPI
> header, instead generate the FSPI header within binman itself. This
> is more flexible, as the FSPI header properties can be configured
> from within the board-specific DT instead of being hard-coded in
> mkimage at build time.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> Acked-by: Peng Fan <peng.fan@nxp.com>
>
> tools/binman/etype/nxp_imx8mimage.py               | 97 ++++++++++++++++++++--
>  tools/binman/ftest.py                              | 23 ++---
>  tools/binman/test/vendor/nxp_imx8m_fspi.dts        |  1 -
>  .../nxp_imx8m_fspi_fail_columnadresswidth.dts      | 19 +++++
>  ...fail.dts => nxp_imx8m_fspi_fail_devicetype.dts} |  3 +-
>  .../vendor/nxp_imx8m_fspi_fail_flashpadtype.dts    | 19 +++++
>  .../nxp_imx8m_fspi_fail_readsampleclksrc.dts       | 19 +++++
>  .../vendor/nxp_imx8m_fspi_fail_serialclkfreq.dts   | 19 +++++
>  tools/binman/test/vendor/nxp_imx8m_fspi_pass.dts   |  1 -
>  9 files changed, 179 insertions(+), 22 deletions(-)

> diff --git a/tools/binman/etype/nxp_imx8mimage.py b/tools/binman/etype/nxp_imx8mimage.py
> @@ -25,8 +25,26 @@ class Entry_nxp_imx8mimage(Entry_mkimage):
> +        - nxp,fspi-columnadresswidth - FSPI column address width

This misspells 'address'. It becomes part of the binman DT binding and
will be hard to change later, so please can you rename it to
nxp,fspi-columnaddresswidth (and the matching variable)?

> diff --git a/tools/binman/etype/nxp_imx8mimage.py b/tools/binman/etype/nxp_imx8mimage.py
> @@ -37,9 +55,30 @@ class Entry_nxp_imx8mimage(Entry_mkimage):
> +        if not self.fspi_columnadresswidth in [ 0, 3, 12, 13 ]:
> +            raise ValueError('nxp,fspi-columnadresswidth can be 0, 3, 12, 13 only.')

Please use self.Raise() rather than raise ValueError, as with other
etypes - it adds the node path so the user can see which image is at
fault. Also 'not in' reads better than 'not x in':

    if self.fspi_columnadresswidth not in [0, 3, 12, 13]:
        self.Raise('nxp,fspi-columnadresswidth can be 0, 3, 12, 13 only')

Same for the other four checks.

> diff --git a/tools/binman/etype/nxp_imx8mimage.py b/tools/binman/etype/nxp_imx8mimage.py
> @@ -59,10 +98,52 @@ class Entry_nxp_imx8mimage(Entry_mkimage):
> +                # 0x80 ... lookupTable
> +                spidata += struct.pack('<I', 0x0818040b)
> +                spidata += struct.pack('<I', 0x24043008)

Just to check, this LUT is a single-pad fast-read sequence, so should
we mention the fixed read command? E.g. if a board uses quad pads,
what will happen.

> diff --git a/tools/binman/etype/nxp_imx8mimage.py b/tools/binman/etype/nxp_imx8mimage.py
> @@ -59,10 +98,52 @@ class Entry_nxp_imx8mimage(Entry_mkimage):
> +                # 0x88..0xfff ... Padding (end of FSPI block is 0x1bf, align to 4k)
> +                spidata += tools.get_bytes(0, 0x1000 - 0xa8)

At this point len(spidata) is 0x88, not 0xa8, so the header comes out
as 0xfe0 bytes and the mkimage output starts at 0xfe0 instead of 0x1000
- 0x20 bytes short. Please use the actual length so this cannot go
stale:

    spidata += tools.get_bytes(0, 0x1000 - len(spidata))

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -8101,17 +8101,18 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +        self._DoTestFile('vendor/nxp_imx8m_fspi.dts')
> +        self._DoTestFile('vendor/nxp_imx8m_fspi_pass.dts')

Since binman now generates the header itself, please can you check the
output data in the test, e.g. verify the tag at offset 0 and that the
mkimage data starts at 0x1000? That would have caught the padding
problem above. Also please use assertIn() on str(e.exception) for each
failure case, so the test confirms the expected error rather than any
ValueError.

Regards,
Simon
