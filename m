Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C7BC5479A
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 10:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53FC688A8E;
	Wed, 28 Aug 2024 12:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YcWSi3wb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBAC388A8B; Wed, 28 Aug 2024 12:01:25 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BACD2885D1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 12:01:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2f3f68dd44bso74227681fa.3
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724839283; x=1725444083; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mQOhh71WuZ+5hyiDxX7eCVjEUqNBrrKXrrQZJbZWQ2Q=;
 b=YcWSi3wboeyTKAElGr/TjlTlg8ufd++fHO55XVIGGTf3hBcTnjiEtBOuDhxyFtoWng
 1GvlxsNH3bFmKSsIYsfV9sEUSQDYFqlEUBHvZSRpZtl3JtQTlGltDE4GFZp1Z5aO0xAS
 19Nw3jT1f6n4Iy9X+g/x+FFTx9jougO/QbZ+wH92v1ilA1uoFFS8D0m5cWll3E+Lc4W6
 VJoBc5cLWS2n+6iOR4qVEUSzxptG0eZDGSCP1fixQo7crN3xlAqxbq60wyPfIz7XLzzI
 5mnmvq0Eq+WL6yLAVoZWUgcITSwoGJxFY98t/X4WbNqs5x63a7D8Bx0VUlCuscJeo9h8
 dd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724839283; x=1725444083;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mQOhh71WuZ+5hyiDxX7eCVjEUqNBrrKXrrQZJbZWQ2Q=;
 b=atG3qho7hODTEV47ZBAsNxUPuNISt0ru7N+dVO/tUODbfvRSVA8mmlfJ4diez13UWe
 BNAzYXvhWytbI0eObRl1YrYSpX8hI2lL/cdm9gxhYtRziRYOn2VZSNGXRBXXyQppKt7J
 uu1lIsPSrQkp5i+kPFNtCutDxpc7smcnOdQT7/GsmL39MWKluzz7VA0yf5atGPzOIkqF
 FQRYKUab0i2sjXqF6W8XKQLQfiIvD6WViUhtc8IHANHPodhS0wWuqLHDByiyydu76PJP
 KktTDQvLt/ESfegSrWKws5LLKq7wsma6vRKs49zHUcvdT/11Yh2TGczSDx7jAn7rLzgL
 p04g==
X-Gm-Message-State: AOJu0Yzb4c+nxLeSCUO0Nd21Gks+LOVBZBtUANbBvNTK/HwdJozPMpzT
 aG9NRYsTXRKrpL0c9goDlM0J4CStmni9dsgxdtEhL+M5xVYQAJa0HlxT2thYjQMBynielmtY8UV
 L+PylJU6Myeasf9q9RucVM2IrhYE=
X-Google-Smtp-Source: AGHT+IHJlHp6FZl72PhIe8t16esIvT2WUzIn+n7KdQzr4RPzFF9lDtWK5AbH9D7XPPKufgRYsHnhRYbrSMNaVMRpWFU=
X-Received: by 2002:a2e:be28:0:b0:2ec:6639:120a with SMTP id
 38308e7fff4ca-2f55b640396mr11219551fa.10.1724839282155; Wed, 28 Aug 2024
 03:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240826191143.426387-1-sjg@chromium.org>
In-Reply-To: <20240826191143.426387-1-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 28 Aug 2024 11:01:10 +0100
Message-ID: <CALeDE9PWV-c0cCagHaUwAvTdryX5g47286toBAd-xezczisTKg@mail.gmail.com>
Subject: Re: [PATCH 00/15] binman: More patches to support VBE
To: Simon Glass <sjg@chromium.org>
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

On Mon, 26 Aug 2024 at 20:11, Simon Glass <sjg@chromium.org> wrote:
>
> This series provides a number of patches to make VBE easier to
> implement, particularly with the new OF_UPSTREAM option.

How? They mostly look unrelated to VBE.

>
> Simon Glass (15):
>   binman: Fix up test coverage for mkeficapsule
>   binman: Correct the comment for fdtgrep
>   binman: Tidy up comments for Entry.GetEntryArgsOrProps()
>   binman: Tidy up comments and pylint warnings in fit
>   binman: Avoid setting the image_pos attribute directly
>   binman: Update fdt-list-dir to use the provided directory
>   binman: fit: Avoid assuming that a FIT member is a section
>   binman: fit: Set the image_pos attributes only once
>   binman: fit: Refine handling of devicetrees for OF_UPSTREAM
>   binman: Adjust naming for reading symbols
>   binman: Add minor improvements to symbol-writing
>   binman: Provide a way to set the symbol base address
>   binman: Unwind the end-at-4gb special-case a little
>   binman: Allow image_pos to be None when writing symbols
>   binman: Make a start on an iMX8 test
>
>  tools/binman/binman.rst                       |  19 ++-
>  tools/binman/btool/fdtgrep.py                 |   3 +-
>  tools/binman/elf.py                           |  14 +-
>  tools/binman/elf_test.py                      |   4 +-
>  tools/binman/entry.py                         |  25 ++-
>  tools/binman/etype/atf_fip.py                 |   2 +-
>  tools/binman/etype/blob_phase.py              |   5 +
>  tools/binman/etype/cbfs.py                    |   2 +-
>  tools/binman/etype/efi_capsule.py             |   2 +
>  tools/binman/etype/fit.py                     | 116 ++++++++-----
>  tools/binman/etype/nxp_imx8mimage.py          |   3 +-
>  tools/binman/etype/section.py                 |  31 ++--
>  tools/binman/ftest.py                         | 152 +++++++++++++++---
>  tools/binman/image.py                         |  21 ++-
>  tools/binman/image_test.py                    |   8 +-
>  tools/binman/test/336_symbols_base.dts        |  23 +++
>  tools/binman/test/337_symbols_base_expand.dts |  24 +++
>  tools/binman/test/338_symbols_comp.dts        |  26 +++
>  tools/binman/test/339_nxp_imx8.dts            |  17 ++
>  19 files changed, 386 insertions(+), 111 deletions(-)
>  create mode 100644 tools/binman/test/336_symbols_base.dts
>  create mode 100644 tools/binman/test/337_symbols_base_expand.dts
>  create mode 100644 tools/binman/test/338_symbols_comp.dts
>  create mode 100644 tools/binman/test/339_nxp_imx8.dts
>
> --
> 2.34.1
>
