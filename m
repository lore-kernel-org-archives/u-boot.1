Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A0EE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 10:42:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 874648036B;
	Tue,  7 Jan 2025 11:42:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ReJVJoue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F2368036D; Tue,  7 Jan 2025 11:42:10 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C00E801E8
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 11:42:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e398484b60bso19564572276.1
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 02:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736246525; x=1736851325; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h5hhLm2mIqZEyiHJjVSnJ+SELmUsaZiN1M2wO2xC1Sk=;
 b=ReJVJoueVLayMnzPAIhfRYShs1X0WWpKVXmgYhDypQsfUti6WypxWYEzpopM3U/Mow
 6IlfpW2h81t2wjcipIVSQN9+6Af/tu4UIXhKqFej6sUwQYv2ZSi+pENEMESVAnPQihuM
 lTyyCg7gAp/Z7lPKiM9HYcyXpoYQ4YwxYNHdQucECjKCZKZoJC1OT0YSLiC2p7ONdOxo
 8JjYISgJEnXfRvPGMLfD7w5j7YwYDr1+8X2BBb0/FWqvL+3i2gPi56a5Nx/rc96ytxKo
 HgFecTLTJyj6ObwZCXihD9mKa41iIh5+3Ywhy0uuCEpg4kOrwgSsu6ulKTPHUfoUJvpX
 64wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736246525; x=1736851325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h5hhLm2mIqZEyiHJjVSnJ+SELmUsaZiN1M2wO2xC1Sk=;
 b=qYFmQ5V4lkoS4oXW6kNeOw3/u5eJ2fKYo2LvmmVJ5mAEo1BmWsMNCD24yx+IHFdG4f
 CFZCksLvViHF3xwq/SZ8Emgc7TCAmHI/Zax9kiN9Wkqdfiy3hnOi5SELUCNSZi1V6IIF
 OxNXQ2DKcA8d/aZsm/UEOXDPvW8s/r9Ad0UxzMJOo+Eb/ZQVSgzXKb2THccbWK2N2o4W
 1JLuRh++Yv/8Neggbn8syBXIHApY0wcFoqF+59VBogqQpT9BngPWCuX4CME+u9gxkJ4B
 3MDt4ZgxZEzhOgERTEzC+KcUnPiMd/GWMaTn/02BwZvJtS7ImuzlBAHyjOX2LguuXVME
 nwhA==
X-Gm-Message-State: AOJu0Yyya4nDCNHB+Lvkeo29qhi/tqo72u7JoczcQnLYyUtz2L8aDmlH
 KP+YctqTirxgeA7dfKdxETnazFVYDZyOpl8ueKonzsXrI2FtM32L9H9a7otbSAXXWD+lBsjDMXM
 ucFphgJZxDfx3Kn1D7bNYdIqAn95W5qNT0gKurA==
X-Gm-Gg: ASbGnctQZFMmcGV1HXiGXytPGFfEI40Z9zIwnmQFWWRCPifSnk//yaxrpLMuJIUc4rl
 lmeP8eUvUW/kkS6QeDZ4i9lnXZz4nFKRD3uG3nA==
X-Google-Smtp-Source: AGHT+IE4KZh9c4id/NOWSG9tGekOp3U50Q1vhP7lhNs6l2PQ4i5a3uXpO11wKFPOr61zleP3ia/J+XsuNJw/2Hc/BOc=
X-Received: by 2002:a25:1f08:0:b0:e54:9eac:48d2 with SMTP id
 3f1490d57ef6-e549eac4b7bmr5461023276.10.1736246524794; Tue, 07 Jan 2025
 02:42:04 -0800 (PST)
MIME-Version: 1.0
References: <20241210160150.244773-1-ilias.apalodimas@linaro.org>
 <5b2795ee-9c6e-4b42-8657-841105c0981f@gmx.de>
In-Reply-To: <5b2795ee-9c6e-4b42-8657-841105c0981f@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 7 Jan 2025 12:41:29 +0200
X-Gm-Features: AbW1kvYyFw9fqsR6Vea2S1wU_wmkpT-EAxE7KdVsdTpPzPPNRJmmQcoHPkEvfjk
Message-ID: <CAC_iWjKo1HUkZyq0+pDjo0eZozKo8c8WbJpkWbgQ3Z=dFY+apA@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Fix section alignment on EFI binaries
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com
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

Hi Heinrich

On Fri, 3 Jan 2025 at 22:20, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10.12.24 17:01, Ilias Apalodimas wrote:
> > When creating EFI binaries, the alignment of the text section isn't
> > correctly factored in. As a result trying to load signed EFI binaries
> > throws an error with:
> >
> > efi_image_region_add() efi_image_region_add: new region already part of another
> > Image not authenticated
>
> You are reporting here two different problems here:
>
> * We create EFI binaries that sbsign does not want to sign and U-Boot
> does not accept for secure boot.
> * efi_image_region_add() creates a message that does not match the
> situation.
>
> Will you prepare a second patch for the latter?

I briefly tried to fix the second problem without success. Since it
doesn't cause any issues I just mentioned it on the commit message for
completeness. I'll try to figure out what causes it, but it's not on
my top prios.

>
> >
> > Running the binary through sbverify has a similar warning
> > sbverify ./lib/efi_loader/helloworld.efi
> > warning: gap in section table:
> >      .text   : 0x00001000 - 0x00001c00,
> >      .data   : 0x00002000 - 0x00002200,
> > gaps in the section table may result in different checksums
> > warning: data remaining[7680 vs 12720]: gaps between PE/COFF sections?
> > .....
> >
> > If we include the alignment in the text section, the signed binary boots
> > fine, and the relevant sbverify warning goes away
> > sbverify ./lib/efi_loader/helloworld.efi
> > warning: data remaining[8704 vs 12720]: gaps between PE/COFF sections?
> > .....
>
> Does EDK II complain?

I haven't tried any EDK2 apps, but the linker scripts differ between projects.

>
> >
> > We should look into the remaining warning at some point as well
> > regarding the gaps between PE/COFF sections.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   arch/arm/lib/elf_aarch64_efi.lds | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/lib/elf_aarch64_efi.lds b/arch/arm/lib/elf_aarch64_efi.lds
> > index 5dd98091698c..e382254a6cf5 100644
> > --- a/arch/arm/lib/elf_aarch64_efi.lds
> > +++ b/arch/arm/lib/elf_aarch64_efi.lds
> > @@ -32,9 +32,9 @@ SECTIONS
> >       .rela.plt : { *(.rela.plt) }
> >       .rela.got : { *(.rela.got) }
> >       .rela.data : { *(.rela.data) *(.rela.data*) }
> > +     . = ALIGN(4096);
>
> If we make this change, we should do so for all UEFI architectures!
>
> Only OUTPUT_FORMAT and OUTPUT_ARCH need to be architecture specific in
> the linker scripts. Can't we use an INCLUDE statement (cf.
> https://sourceware.org/binutils/docs/ld/File-Commands.html)?
>
> Of aarch64, arm, riscv32, riscv64 only the arm script differs heavily
> for no good reason. We should get rid of this exception.

Sure, but this is fixing sandbox for the CI testing on arm64 hosts. We
don't have any other native hosts apart from x86 and arm64.
Refactoring all the linker scripts for apps is a bigger task. Mind if
we take one step at a time?

Thanks
/Ilias
> Best regards
>
> Heinrich
>
> >       _etext = .;
> >       _text_size = . - _text;
> > -     . = ALIGN(4096);
> >       .data : {
> >               _data = .;
> >               *(.sdata)
>
