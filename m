Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AD5C83F2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59F8988966;
	Thu, 29 Aug 2024 17:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O7hrPYlv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 635E288CE5; Thu, 29 Aug 2024 17:02:04 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A11988966
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:02:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7a802deea39so50900185a.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943721; x=1725548521; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RmG6ITq8iSDezZl0RCXkbLNgVSPP2EVIEIawwHjAKCk=;
 b=O7hrPYlvzGEUVg9TMSXO5ZHTWf1hDQPQQ6In5szMsJbSKEcfFdYSOV8ugsYwIXWLbl
 c809Gz9Id7nsskStii9hqQg1amto5tc6kCPWMpSbWdHY/M+yCEkh2AHQAdlxVLiut/Y9
 uLjGUrgCDmphyf3RheLaG3ys2PPPX4gba0YqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943721; x=1725548521;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RmG6ITq8iSDezZl0RCXkbLNgVSPP2EVIEIawwHjAKCk=;
 b=nbP00G7Lot0lu1m2lSUsTMNlx0y8zE6IyAvon7QwLTCkOz6H1v26eYPJO9+C+zmzev
 fIWAa6v2dNGDRYKpis4y5BL+oQaZYMTdrei3ETYz2r+ovC6WO4XMkcCzn47ugPGhXunn
 /CQ+9SUkZO1KLfebdZS0cUOfssSROv/694qWLsH1fQMyHqrTU2fWTMbFRuD7kOv2592f
 R0PkOs4rezhh3VQWPHCts/pixE5gnYV/IAHjGjukr3cDJ3lfO1sbg9yC/QZ9hn1hNG3m
 iF5JQ+Bsuscg3dBBY57YscZ6UMrJ5HKAYczTaxPrzYfCWptMIXmOj0RczFrEd+QmeA1p
 kLCQ==
X-Gm-Message-State: AOJu0YyS6JiC8ZRS0bJ4u6Te53yK+AiCn+gdB1KI5e5ffUz8c8rDMsku
 eSF6lLw1rEoi+xiqEFNexhd7ixDpy2dwlhz9W1nCvyHqoIZUQ+lwCNPPZj40A758t0lnzaIQYC9
 93BLWYbGwgv5wFB0mTWYOPkJiFf7ApvB/TAUCAo8tpOERphc=
X-Google-Smtp-Source: AGHT+IEpyN+2LIjkk3qotixEx161fVYhhDESGJl/F99jVhvWVRVNEHljOUL9FEuZ7VPnMfegiii4qR2kINe/c2V9Q84=
X-Received: by 2002:a05:6214:4589:b0:6b5:32de:bfe7 with SMTP id
 6a1803df08f44-6c33e616e2emr35603086d6.22.1724943720720; Thu, 29 Aug 2024
 08:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240826191143.426387-1-sjg@chromium.org>
 <CALeDE9PWV-c0cCagHaUwAvTdryX5g47286toBAd-xezczisTKg@mail.gmail.com>
In-Reply-To: <CALeDE9PWV-c0cCagHaUwAvTdryX5g47286toBAd-xezczisTKg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 09:01:49 -0600
Message-ID: <CAFLszThinApHkFiW2w26ihqBP2Jq2r7_sPmSaP4dHk4gzbsCzw@mail.gmail.com>
Subject: Re: [PATCH 00/15] binman: More patches to support VBE
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Rong Tao <rongtao@cestc.cn>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi Peter,

On Wed, 28 Aug 2024 at 04:01, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Mon, 26 Aug 2024 at 20:11, Simon Glass <sjg@chromium.org> wrote:
> >
> > This series provides a number of patches to make VBE easier to
> > implement, particularly with the new OF_UPSTREAM option.
>
> How? They mostly look unrelated to VBE.

- we need binman symbols which provide a disk offset, not an address
- we need to have a compressed section containing VPL, meaning that
there is no valid image-pos for things within that section
- we need to be able to locate the devicetree when OF_UPSTREAM is used

The iMX8 one is for Marek, as until that is fixed I cannot enable
code-coverage in Binman in CI, which I very-much want to do with VBE.

>
> >
> > Simon Glass (15):
> >   binman: Fix up test coverage for mkeficapsule
> >   binman: Correct the comment for fdtgrep
> >   binman: Tidy up comments for Entry.GetEntryArgsOrProps()
> >   binman: Tidy up comments and pylint warnings in fit
> >   binman: Avoid setting the image_pos attribute directly
> >   binman: Update fdt-list-dir to use the provided directory
> >   binman: fit: Avoid assuming that a FIT member is a section
> >   binman: fit: Set the image_pos attributes only once
> >   binman: fit: Refine handling of devicetrees for OF_UPSTREAM
> >   binman: Adjust naming for reading symbols
> >   binman: Add minor improvements to symbol-writing
> >   binman: Provide a way to set the symbol base address
> >   binman: Unwind the end-at-4gb special-case a little
> >   binman: Allow image_pos to be None when writing symbols
> >   binman: Make a start on an iMX8 test
> >
> >  tools/binman/binman.rst                       |  19 ++-
> >  tools/binman/btool/fdtgrep.py                 |   3 +-
> >  tools/binman/elf.py                           |  14 +-
> >  tools/binman/elf_test.py                      |   4 +-
> >  tools/binman/entry.py                         |  25 ++-
> >  tools/binman/etype/atf_fip.py                 |   2 +-
> >  tools/binman/etype/blob_phase.py              |   5 +
> >  tools/binman/etype/cbfs.py                    |   2 +-
> >  tools/binman/etype/efi_capsule.py             |   2 +
> >  tools/binman/etype/fit.py                     | 116 ++++++++-----
> >  tools/binman/etype/nxp_imx8mimage.py          |   3 +-
> >  tools/binman/etype/section.py                 |  31 ++--
> >  tools/binman/ftest.py                         | 152 +++++++++++++++---
> >  tools/binman/image.py                         |  21 ++-
> >  tools/binman/image_test.py                    |   8 +-
> >  tools/binman/test/336_symbols_base.dts        |  23 +++
> >  tools/binman/test/337_symbols_base_expand.dts |  24 +++
> >  tools/binman/test/338_symbols_comp.dts        |  26 +++
> >  tools/binman/test/339_nxp_imx8.dts            |  17 ++
> >  19 files changed, 386 insertions(+), 111 deletions(-)
> >  create mode 100644 tools/binman/test/336_symbols_base.dts
> >  create mode 100644 tools/binman/test/337_symbols_base_expand.dts
> >  create mode 100644 tools/binman/test/338_symbols_comp.dts
> >  create mode 100644 tools/binman/test/339_nxp_imx8.dts
> >
> > --
> > 2.34.1
> >

Regards,
SImon
