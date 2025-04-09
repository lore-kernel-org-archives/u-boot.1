Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5A4C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 13:23:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63691837FC;
	Wed,  9 Apr 2025 15:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n97nknPJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 316DD836C3; Wed,  9 Apr 2025 15:23:12 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E24583807
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 15:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac2ab99e16eso1282489866b.0
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 06:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744204988; x=1744809788; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VSrD3Vg0+nylwvSKE+OOBTpGnmyL4BjTnu/3jwEBgQU=;
 b=n97nknPJROR/af1fiklmuNWaYxkMOKQVhY9xP0zfpJY1FUgaI5vsR8LcfocifI8O1N
 LbjTVjqS57+iBLtUBwPYySBUGg0fyiTHKVBRAN/EgQD4PQadUDQxobmw5xf1wIDO/fW2
 jHwZqTvXGqM10jvz6wItrQbwz93WZUJaTPuDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744204988; x=1744809788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VSrD3Vg0+nylwvSKE+OOBTpGnmyL4BjTnu/3jwEBgQU=;
 b=R0OVEvj3nShz6YsMa9mAIDGHVizxdyQeucIdAa4Le92C6GiGgH46sW9k81JFuSc/HX
 f5co5FQDvgK1THNJyrn/y12zYkO7tW0cRmMHhTUoF5yfBKg3BM3U3kVCDZeGX+imVZzV
 Txrj6ONjPO8Vg0VshZPAmwQZC9KQJpCaI8DhPiIl6P0WqxZ1e6gNSNne1YAK2XPiDzsc
 uVs2Z9UWZVKkePM59/ClJUUz1fklTO+Na+tbJWhnRp+7FLgmQdJDGGGH32k7enz5ShNa
 vBlc+lP1eAy347NrW1ECKBp+FgmtzCYbXF/T8fG4DG1LTAN+iNexfZXQ+EGZG3LFAA1t
 QmZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGBAxuvtZYL3S4B43NsJjTsRkDPIS6td/0y/AIaHdg6xY1e8UDPVwxyOODCjcfvyghA/KvbBE=@lists.denx.de
X-Gm-Message-State: AOJu0YxQhxreX7v2LZaZs1k3ywaHMi1YgCaaJuyE/EXySTKQtAxsmRUA
 ZBgzDSieBpz4ydFkXXcHnxmVCW1CPisVkrojua/jB6BkkttPKobNvnQSGrrrZKl/OipivbwUFTc
 WaX2HL1ANU1sYvi2pzwJv53EG2s1GmLkYVVNo
X-Gm-Gg: ASbGncsCXIRxRdv0QqL6y6N4OUkg+ScqSO3sF9SgJqK6y7VQOy+TeEt4Y3yO5czToF1
 X/Fr7JNQtYbwgg3ZrwytJtimoytZ+KtNptSWlv5e0fuYm34ldkQ8PJmQvjRW1DZnmxLzmzcNFRI
 K4pjWDSRH3hKCH9IdlkIGM3Ic=
X-Google-Smtp-Source: AGHT+IFJMI1oNe9ERjGN+Vo9nymp+C3tOjipxIoE/CeGNm2OuHw4mh9wbyuC939DRBdDHXgOJV/VPnKa6b0z0nO0brI=
X-Received: by 2002:a17:907:3c93:b0:ac6:ef94:3d9a with SMTP id
 a640c23a62f3a-aca9b5b2f25mr395857566b.4.1744204988302; Wed, 09 Apr 2025
 06:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250407033744.4025-1-ziyao@disroot.org>
 <20250407033744.4025-3-ziyao@disroot.org>
 <765a4f82-d0c8-43a3-beb3-31e133fd4811@kwiboo.se> <Z_TtMpbhnBMi1Sb0@pie>
In-Reply-To: <Z_TtMpbhnBMi1Sb0@pie>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 9 Apr 2025 07:22:54 -0600
X-Gm-Features: ATxdqUHSdjcVEIGivHaVtoHrSyRm5MhbXhPpJ9jkkowfvky8MF-wHiPw00e5Jws
Message-ID: <CAFLszTi8odmNWxPkYAyx0JLjHfjEsaz+2FY25S6uOQw20EgaZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Provide __image_copy_{start_end} symbols in
 linkerscript
To: Yao Zi <ziyao@disroot.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>, 
 Trevor Woerner <twoerner@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marex@denx.de>, Paul Kocialkowski <contact@paulk.fr>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Lukas Funke <lukas.funke@weidmueller.com>, u-boot@lists.denx.de
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

Hi Yao,

On Tue, 8 Apr 2025 at 03:32, Yao Zi <ziyao@disroot.org> wrote:
>
> On Mon, Apr 07, 2025 at 01:10:32PM +0200, Jonas Karlman wrote:
> > Hi,
> >
> > On 2025-04-07 05:37, Yao Zi wrote:
> > > Binman looks for __image_copy_start to determine the base address of an
> > > entry if elf-base-sym isn't specified, which is missing in RISC-V port.
> > > This causes binman skips RISC-V SPL entries without filling addresses
> > > into its .binman_sym_table section.
> > >
> > > This patch defines __image_copy_start in linkerscript of both SPL and
> > > proper U-Boot to ensure binman_sym functions correctly with the default
> > > binman.dtsi. The paired symbol, __image_copy_end, is introduced as well
> > > for completeness.
> > >
> > > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > > ---
> > >  arch/riscv/cpu/u-boot-spl.lds | 2 ++
> > >  arch/riscv/cpu/u-boot.lds     | 3 +++
> > >  2 files changed, 5 insertions(+)
> > >
> > > diff --git a/arch/riscv/cpu/u-boot-spl.lds b/arch/riscv/cpu/u-boot-spl.lds
> > > index 907094620bd..18eb62c01c6 100644
> > > --- a/arch/riscv/cpu/u-boot-spl.lds
> > > +++ b/arch/riscv/cpu/u-boot-spl.lds
> > > @@ -16,6 +16,7 @@ ENTRY(_start)
> > >  SECTIONS
> > >  {
> > >     . = ALIGN(4);
> > > +   __image_copy_start = ADDR(.text);
> > >     .text : {
> > >             arch/riscv/cpu/start.o  (.text)
> > >             *(.text*)
> > > @@ -46,6 +47,7 @@ SECTIONS
> > >
> > >     _end = .;
> > >     _image_binary_end = .;
> > > +   _image_copy_end = .;
> >
> > This looks like a typo, should probably be with two _ ?
>
> Yes, thanks for catching this. I'll correct it and apply Simon's tag in
> v2. Simon, is it okay for you?

Yes.

Regards,
Simon
