Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DF9C4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 16:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BE2787BAE;
	Tue,  6 Feb 2024 17:36:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fink+IDx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A3BF87C93; Tue,  6 Feb 2024 17:36:17 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 032D586284
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 17:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d0a4e8444dso31109141fa.2
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 08:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707237374; x=1707842174; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lyEcYMm77yz2ObZKSAcI8uZFqgv889CIcuJCDnUVFtM=;
 b=fink+IDxHUbuvdOyro8Gz4NZmKAzfQbJJR2bBUJTl5fi2oG2wZUsieD+FEDweBiHJW
 1VBckpmsL77kp9tFf8OLULYoeQARn22wT7p2DzEKzDtVH9A52VDT8u/6eCfGdqNLuDEd
 REPOeJwNTdKk8ulwO/m86N+hBgun0i+wd5srsdHs8ZEXmIP5aBpkL2SNVt1HvInVizJE
 jxa9Wf5ncJ7Q+PIWJccyuKLLpIvPyk5daC7vA4MgZfZ2Z13b9V4OyXc09mBj+5twPZ7S
 uC8pfK6SjA/74Hr0/TrKM5GoXtulTRtvMOY/K+1KxpqJhd5Zyj1OGav4pe/LGuk29uBZ
 pVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707237374; x=1707842174;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lyEcYMm77yz2ObZKSAcI8uZFqgv889CIcuJCDnUVFtM=;
 b=jlkq1fwkXHW0TX9b7UW2D0c1v9P+9iccEMRMEJNjYGtmuE7Es4ipgKOp8hoxuKFFtT
 6Bb55x+FAbCUnDc5OV0T1FS0Kiin4U6jwq4CrNLyeIqQcjrS3rUco+tZXUQcKphbE65G
 48ASXXAmQTA133jI8iTB4I2u7sVaIs8DLJySFZe6d3+T/lh7470/+giHb+5uoyLUPG9G
 4i+rSa0CP8pcbLcg0o+4rP6vnorGtv2dC5zBvQzBVXTvZ7ShoH9qYkhKnc2Ig56nxE6Q
 m5qIWU/zC7OZDwzrU71L6Kc0Q2LB/dNWIs2dv0DFA7FXdyLliyJghccasrYPlxoVBMfu
 7WjQ==
X-Gm-Message-State: AOJu0YweK0kIW1YhrjRLBNTWpm1t99trK2ZlPx7vwEbz8VyyRkdNAjI0
 lGrkhe4+qsBXzNHpiayPL0+IepDrZc3JNSeDsiueN9yef/cY2Nbwbn7iTrp5uktEV0REQDb6S7w
 iC6/10Rps22ZexIEGoJ8IS42068nf6R0YfQBpEQ==
X-Google-Smtp-Source: AGHT+IEptZAEc+p+8UGx1ty+Hi8y8gyPLAPEQfinr9HL6v/QKV/Z2kNpqoN7RTuXntr/ePPCS2xGhCCnCwSZoOO1HQU=
X-Received: by 2002:a2e:9d02:0:b0:2d0:a8fe:4263 with SMTP id
 t2-20020a2e9d02000000b002d0a8fe4263mr2138727lji.25.1707237374198; Tue, 06 Feb
 2024 08:36:14 -0800 (PST)
MIME-Version: 1.0
References: <20231217003347.194657-1-marek.vasut+renesas@mailbox.org>
 <ZcJF2uGIMj-jxT3M@hera>
In-Reply-To: <ZcJF2uGIMj-jxT3M@hera>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 6 Feb 2024 18:35:37 +0200
Message-ID: <CAC_iWjL9CFoxRHXFbdraFYmd76yv0vkyCwEZoGuFAiw0XtdL9g@mail.gmail.com>
Subject: Re: [PATCH v2] arm: Add OVERLAY command to BSS section on ARM64
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
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

On Tue, 6 Feb 2024 at 16:44, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Marek,
>
> On Sun, Dec 17, 2023 at 01:33:39AM +0100, Marek Vasut wrote:
> > Avoid allocating and loading the BSS section.
> >
>
> Can we elaborate a bit more on why we need this? AFAICT there's no code
> loading those segments in memory and swapping them, so why do we need the
> OVERLAY? On top of that the ALLOC flag seems to be missing? The .bss
> section doesn't need to be loaded indeed, since we can memset it to 0, but
> it does need proper backing memory.
>
> another thing I noticed is the bss_start and end are defined as sections of
> their own and a bit of git history led me to 3ebd1cbc49f00050. But the
> linker script will emit absolute addresses only if the symbol is defined
> outside a section. IOW applying this makes the value expressed as a fixed
> offset from the base of the section and the bss_start/end sections go away
>
> --- a/arch/arm/cpu/armv8/u-boot.lds
> +++ b/arch/arm/cpu/armv8/u-boot.lds
> @@ -151,17 +151,11 @@ SECTIONS
>
>         . = ALIGN(8);
>
> -       .bss_start : {
> -               KEEP(*(.__bss_start));
> -       }
> -
>         .bss : {
> +               .bss_start = .;
>                 *(.bss*)
>                  . = ALIGN(8);
> -       }
> -
> -       .bss_end : {
> -               KEEP(*(.__bss_end));
> +               .bss_end = .;
>         }
>
>         /DISCARD/ : { *(.dynsym) }

Apologies the patch above was wrong. The . in bss_start/end isn't
needed and I was missing a __ before the symbol definition.

The diff below though should produce the same binary without the
bss_start/end sections and the .bss section marked as ALLOC only

diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index fb6a30c922f7..8105cfd122af 100644
--- a/arch/arm/cpu/armv8/u-boot.lds
+++ b/arch/arm/cpu/armv8/u-boot.lds
@@ -151,17 +151,11 @@ SECTIONS

        . = ALIGN(8);

-       .bss_start : {
-               KEEP(*(.__bss_start));
-       }
-
        .bss : {
+               __bss_start = .;
                *(.bss*)
                 . = ALIGN(8);
-       }
-
-       .bss_end : {
-               KEEP(*(.__bss_end));
+               __bss_end = .;
        }

        /DISCARD/ : { *(.dynsym) }
diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
index 857879711c6a..59dfc53851a8 100644
--- a/arch/arm/lib/sections.c
+++ b/arch/arm/lib/sections.c
@@ -19,8 +19,8 @@
  * aliasing warnings.
  */

-char __bss_start[0] __section(".__bss_start");
-char __bss_end[0] __section(".__bss_end");
+//char __bss_start[0] __section(".__bss_start");
+//char __bss_end[0] __section(".__bss_end");
 char __image_copy_start[0] __section(".__image_copy_start");
 char __image_copy_end[0] __section(".__image_copy_end");
 char __rel_dyn_start[0] __section(".__rel_dyn_start");


>
>
> leads to this:
>
>  11 .bss          000090b0  0000000000102b00  0000000000102b00  00112aa0  2**7
>                   ALLOC
>
> P.S: I am playing around with rewriting the linker script and mapping
> u-boot with proper permissions at least for armv8. If this patch is neeeded
> *now* can someone explain why? Otherwise I'll clean it up once I test my
> patches enough
>
> Thanks
> /Ilias
>
> > $ aarch64-linux-gnu-objdump -Sh u-boot
> >
> > Before:
> >   10 .bss_start    00000000  00000000000f21d8  00000000000f21d8  001021d8  2**0
> >                    CONTENTS, ALLOC, LOAD, DATA
> >   11 .bss          000068f8  00000000000f2200  00000000000f2200  001021d8  2**6
> >                    ALLOC
> >   12 .bss_end      00000000  00000000000f8af8  00000000000f8af8  00108af8  2**0
> >                    CONTENTS, ALLOC, LOAD, DATA
> >
> > After:
> >   10 .bss_start    00000000  00000000000bf990  00000000000bf990  001021e0  2**0
> >                    CONTENTS
> >   11 .bss          000068e8  00000000000bf990  00000000000bf990  001021e0  2**4
> >                    CONTENTS
> >   12 .bss_end      00000000  00000000000c6278  00000000000c6278  00108ac8  2**0
> >                    CONTENTS
> >
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > ---
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> > V2: Replicate arch/arm/cpu/u-boot.lds BSS part verbatim
> > ---
> >  arch/arm/cpu/armv8/u-boot.lds | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
> > index fb6a30c922f..ebdc079552d 100644
> > --- a/arch/arm/cpu/armv8/u-boot.lds
> > +++ b/arch/arm/cpu/armv8/u-boot.lds
> > @@ -151,16 +151,18 @@ SECTIONS
> >
> >       . = ALIGN(8);
> >
> > -     .bss_start : {
> > +     .bss_start __rel_dyn_start (OVERLAY) : {
> >               KEEP(*(.__bss_start));
> > +             __bss_base = .;
> >       }
> >
> > -     .bss : {
> > +     .bss __bss_base (OVERLAY) : {
> >               *(.bss*)
> >                . = ALIGN(8);
> > +              __bss_limit = .;
> >       }
> >
> > -     .bss_end : {
> > +     .bss_end __bss_limit (OVERLAY) : {
> >               KEEP(*(.__bss_end));
> >       }
> >
> > --
> > 2.43.0
> >
