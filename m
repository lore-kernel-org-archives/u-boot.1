Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A32C5475B
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 07:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0787687F6F;
	Thu, 14 Mar 2024 08:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Mtlakzn3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16C6C87F71; Thu, 14 Mar 2024 08:59:41 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED52C87F43
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 08:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d2991e8c12so7479341fa.0
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 00:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710403178; x=1711007978; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mAsP+JappUm+HhH41V6jEdX+wnsE7RPqM6DnwWx+cSk=;
 b=Mtlakzn393ntDU6YKOw/R2Q5pXUAKoIDdMGf+RgZAJYOUTX0TWNtn648tmD52o15R2
 G1c7wOFuMpFpFt77bK3Vf72tnXkmzgqrOllxfxdaytr9ff68sl9M5qx8q/mjh1gocQZN
 CMO1j1WPpTCqUGTm2tRY4jAe36ZNzy3mLz3c0c8PnIdrJqToHbYwsdGrWDe/lKv0Dw8+
 w0b43Zdl5fxlZ6TyaNUqxtbqbawBoa/cXeh+UXJOo6nm4fIn1n6G2OTZTQ8yuEAYirBX
 lzCoO7qkWgoyUD131WLZ6zJAjCrvGvUax0tG0qFKc855dUfd/ydKVoumkvaWK3rOUzIL
 t9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710403178; x=1711007978;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mAsP+JappUm+HhH41V6jEdX+wnsE7RPqM6DnwWx+cSk=;
 b=Ak6c7DigbIjogSIBX+cq5sqPEG2hs3UjGM0QjnW4TITbi13TTt/CLAcKyfi8tU7LYm
 6SnBzHIKz5QCq0lL77YfyOYAJCi0Bx/InUOrSXEvpJJOoSAPmH66zegGm4hzZlklgyMo
 sVbanIxhH8weZNSMUMoEuUNq4LpNzt4rnCkz33V/iBc7+ucgF0CWg3oRv7RqL1gdH5dM
 FPYHwMwg2IjQwxw5SfNffdo5XWXbnzyyZE1T2IARhpNEhKv/RoQN+YNDVhSlRlIR0+BS
 jUAbBpCwidNTObpQGMmcFREQgs3NSZcjfGnBy1Euz/TokR8UIGx+khQNROfIrx9h9sKa
 jn3g==
X-Gm-Message-State: AOJu0YxXgoqCoKdL37oB5/u+nL/Uwuwta5P3wq/3vlDS972bbUizQKG5
 /j3xSopnmZzWO5cKJGtJl2gQJ46SeYN4XF+D9yZ730NiVXuP+U3cGJpIpBR32GhakyYTzbu5JcO
 3YM8v6N/eSGEAJhjjdT6qfbY+WH01OL6PluuNtQ==
X-Google-Smtp-Source: AGHT+IEMH9bt5gKlJByMJbiawu2bm84hMdUa6+K64CcCxSWP37gABjusSjEQcXOalo5q/rPj5SYZdeBmwUWQMUvw2lo=
X-Received: by 2002:a2e:9144:0:b0:2d4:535a:e7a with SMTP id
 q4-20020a2e9144000000b002d4535a0e7amr352059ljg.24.1710403177998; Thu, 14 Mar
 2024 00:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240313162324.2117909-1-ilias.apalodimas@linaro.org>
 <20240313162324.2117909-3-ilias.apalodimas@linaro.org>
 <e1fabe14-0c0e-45f3-9d5a-1452cb9b954e@linaro.org>
 <CAC_iWjKhM6Ono+C-t-3g=OSo=5wF8jAYzoZ-NUyNUt7MHTMy=w@mail.gmail.com>
 <2a58e815-acfa-4659-80f5-08d314497897@linaro.org>
In-Reply-To: <2a58e815-acfa-4659-80f5-08d314497897@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 14 Mar 2024 09:59:01 +0200
Message-ID: <CAC_iWj+BqMg_WUEkHXOgt_N7wuYXMqxg5rdkN=N2GsbtQHw8nQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] arm: clean up v7 and v8 linker scripts for
 bss_start/end
To: Richard Henderson <richard.henderson@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, cfsworks@gmail.com, 
 caleb.connolly@linaro.org, sumit.garg@linaro.org, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shiji Yang <yangshiji66@outlook.com>,
 Bin Meng <bmeng@tinylab.org>
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

Hi Richard,


On Thu, 14 Mar 2024 at 00:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 3/13/24 11:43, Ilias Apalodimas wrote:
> > Hi Richard,
> >
> > On Wed, 13 Mar 2024 at 22:19, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> On 3/13/24 06:23, Ilias Apalodimas wrote:
> >>> +++ b/arch/arm/cpu/armv8/u-boot-spl.lds
> >>> @@ -63,18 +63,11 @@ SECTIONS
> >>>
> >>>        _image_binary_end = .;
> >>>
> >>> -     .bss_start (NOLOAD) : {
> >>> -             . = ALIGN(8);
> >>> -             KEEP(*(.__bss_start));
> >>> -     } >.sdram
> >>> -
> >>> -     .bss (NOLOAD) : {
> >>> +     .bss : {
> >>> +             __bss_start = .;
> >>>                *(.bss*)
> >>> -              . = ALIGN(8);
> >>> -     } >.sdram
> >>> -
> >>> -     .bss_end (NOLOAD) : {
> >>> -             KEEP(*(.__bss_end));
> >>> +             . = ALIGN(8);
> >>> +             __bss_end = .;
> >>
> >> Still missing the alignment on .bss, previously in .bss_start.
> >
> > Since this is emitted in .sdram memory I can't define it as
> > .bss ALIGN(8) : {....} since the calculated memory will be outside the
> > sdram-defined region
> >
> > I could define it as
> > .bss : {
> >          . = ALIGN(8);
> >          __bss_start = .;
> >          ......
> > }
> >
> > But instead, I added an assert at the bottom which will break the
> > linking if the __bss_start is not 8byte aligned.
>
> I think it would be clearer to assert on __bss_start address rather than
> CONFIG_SPL_BSS_START_ADDR, if that's possible.  If not, then the constant will have to do.


Fair enough and it is possible. I can convert that assertion to
ASSERT(ADDR(.bss) % 8 == 0, ".bss must be 8-byte aligned");

Keep in mind that .bss, due to the linker aligning the section to the
strictest input section requirement will end up aligning that to 8b
regardless. IOW compiling with CONFIG_SPL_BSS_START_ADDR=0x1001, won't
break the linking since .bss will end up at 0x1008.

Testing the assertion with a section definition which looks like this
will trigger the assert.
        .bss 0x1001 : {
                __bss_start = .;
                *(.bss*)
                . = ALIGN(8);
                __bss_end = .;
        } >.sdram

I don't have a really strong opinion here. I think the assertion above
is ok. What we could also do is

        .bss  : {
                . = ALIGN(8);
                __bss_start = .;
                *(.bss*)
                . = ALIGN(8);
                __bss_end = .;
        } >.sdram

which would also fix the __bss_start alignment regardless of the .bss
output address.
For example with the linker entry below __bss_start will end up at 0x1008
        .bss  0x1001 : {
                . = ALIGN(8);
                __bss_start = .;
                *(.bss*)
                . = ALIGN(8);
                __bss_end = .;
        } >.sdram

As you already mentioned, the bss_end - bss_start % 8 == 0 can be
fixed by using memset. So since I plan to continue working on this to
get RO, RW^x etc mappings I think I'll just go for the assertion for
now -- but test the .bss address instead of the config option.

Anyone objects?

Thanks
/Ilias

>
>
> r~
