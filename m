Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED79D6D247
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 22:21:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB58289831;
	Wed, 27 Nov 2024 23:21:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="a9NK6LSM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFB3F89827; Wed, 27 Nov 2024 23:21:31 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 677B38980C
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 23:21:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa52bb7beceso13448566b.3
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 14:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1732746089; x=1733350889;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i1zzaj4fklDh4ku8feoWqKSp4fpNSSWYqQLfJJVGV90=;
 b=a9NK6LSMz3Y+MBrOqKwYZkr5GuRAOz4Q3OkXqZEHJ314oemVHnagj2csiQinZqY/pF
 CW3jX/xELkBsfWi/2YL2XGuUt7iAm5ekc1tj3fWpHUBQSTzddeZ2B04AQYy+t6xXr6+O
 cbEtc5hQBUFb17AzQigB9rOBKNkknVjIL824o82SFHk4YXdAthcHQd/BkgG5gHACa6rw
 g0qj8egxos8SiZZsbo4SOsVhbRYssfojO9WFGQKmgG10fNua/xQliqVwCTy3JDQbO7Ig
 womy3XGZLd4EaX18HZ3n5wdXafuGUISfR/DH5Jpj5ebr/9Gs9Zp2wgUQ2xGyJp2MUEVh
 OyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732746089; x=1733350889;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i1zzaj4fklDh4ku8feoWqKSp4fpNSSWYqQLfJJVGV90=;
 b=hI262ymUZLczyA6cWMfqHnMNY7ShfB0YYN0SrCuk3E7hd47eBAm5m76honPM9IC9g7
 NN2kZeNXl2aKGMiFfRTzk1T/eHB9RNz2Bh3d2Sg7WZ+yjLq9cMwTiRAF181L0kBivqR7
 MkXdXUrn4frgPRppUvTdAOxtYWAH7FbFkq5vmKiK/0oWrMb10zGjGQjvF8GJmqQE5TUN
 tAHOSowZKIyX+lNqVMSgPutzsV8PlODDJaQLTqxouNlpqly+lOfu2E0C48Qr+wGWOJzT
 nKjuFpmC4qEBFAro9/46XCB7gzpDjWbDUIAmUH/azajDew1tpx+KlNtGXylIyItaHRGG
 NILg==
X-Gm-Message-State: AOJu0YxLyKpCWifS65vqUP7jFurDxwC77owcOZQdln6CafYGhwB8trv1
 m/jQKrpTH66YPXIOv/s7ci4LL6xHq7aLSONsAYsKjHIV+ve2LSTnagdDf99VoNP2MX4RMAbvCbc
 UHrIAMsRhnFMUBHp9RTBV+gFQ2J+reO92SKoot3Q3hqOK612IY24=
X-Gm-Gg: ASbGncs0BCqYek9MEjnYmH/1eL1kjeYhRiYuJJ/ocqKMrzvFGXhI6qEUhQdFhKps2Np
 f+7fVOsA3UjgxjKd96shOVRGMcPPMbVs=
X-Google-Smtp-Source: AGHT+IHDECM4oGHwhb+Y5V5EIccTFjM1srg0XJlfXvVN+MBg8X1lrvboh/8se+3qNXe/38/l7OnFZSRiPdlaHKMO+Sg=
X-Received: by 2002:a17:906:32d7:b0:aa5:30a6:13d3 with SMTP id
 a640c23a62f3a-aa580f35501mr318281566b.27.1732746088653; Wed, 27 Nov 2024
 14:21:28 -0800 (PST)
MIME-Version: 1.0
References: <20240918130155.299353-1-lukasz.czechowski@thaumatec.com>
 <20240918130155.299353-2-lukasz.czechowski@thaumatec.com>
 <d63d53bd-3f63-430d-b0bc-2379b7bded81@rock-chips.com>
In-Reply-To: <d63d53bd-3f63-430d-b0bc-2379b7bded81@rock-chips.com>
From: =?UTF-8?Q?=C5=81ukasz_Czechowski?= <lukasz.czechowski@thaumatec.com>
Date: Wed, 27 Nov 2024 23:21:17 +0100
Message-ID: <CABd623t3-U+TF9VD0O2dtNZzpZPBM9LcOQ_a4mDpv6ierbLuCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] debug_uart: Replace debug functions with dummies
 if CONFIG_DEBUG_UART is not set
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 philipp.tomsich@vrull.eu, quentin.schulz@cherry.de
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

Hi Kever,

On 2024/11/27 03:42 Kever Yang <kever.yang@rock-chips.com> wrote:
>
> Hi Lukasz,
>
>      I got a new error base on patch [1], see full log here [2].

Looking at the file efi_stub.c that is used in the failing
configuration it looks to me
that some functions from debug_uart.h are used here for convenience
(i.e. printhex),
even though the DEBUG_UART is not used. This is contrary to my assumption that
DEBUG_UART_FUNCS macro should not be used if DEBUG UART is not available.
In order to apply the patch then, either the efi_stub code must be
updated to not
use debug functions or the assumption must be relaxed - I'm not yet
sure what shall be
the correct approach.

>
> +/binman/rom/intel-mrc (mrc.bin):
> +In file included from lib/efi/efi_stub.c:12:
> +include/debug_uart.h:205:9: error: stray '#' in program
> +  205 |         #warning "DEBUG_UART not defined!"
> +      |         ^
> +lib/efi/efi_stub.c:91:1: note: in expansion of macro 'DEBUG_UART_FUNCS'
> +   91 | DEBUG_UART_FUNCS
> +      | ^~~~~~~~~~~~~~~~
> +include/debug_uart.h:205:18: error: expected '=', ',', ';', 'asm' or
> '__attribute__' before string constant
> +      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
> +lib/efi/efi_stub.c:86:13: error: '_debug_uart_putc' defined but not
> used [-Werror=unused-function]
> +   86 | static void _debug_uart_putc(int ch)
> +      |             ^~~~~~~~~~~~~~~~
> +cc1: all warnings being treated as errors
> +make[3]: *** [scripts/Makefile.build:257: lib/efi/efi_stub.o] Error 1
>
>
> [1]https://patchwork.ozlabs.org/project/uboot/patch/20241108163612.1.Ib408a6723ba954c932968419678bd45b0767a470@changeid/
> [2] https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/jobs/958639
>
>
> Thanks,
> - Kever
> On 2024/9/18 21:01, Lukasz Czechowski wrote:
> > In case DEBUG UART is not used, define dummy macros replacing
> > the actual function implementations that will not be available.
> > This allows to compile code and avoid linker errors.
> > Because the DEBUG_UART_FUNCS macro should not be used if
> > DEBUG UART is not available, redefine it to generate compilation
> > warning.
> >
> > Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> > ---
> >   include/debug_uart.h | 16 ++++++++++++++++
> >   1 file changed, 16 insertions(+)
> >
> > diff --git a/include/debug_uart.h b/include/debug_uart.h
> > index 714b369e6fe..dc0f1aa4c98 100644
> > --- a/include/debug_uart.h
> > +++ b/include/debug_uart.h
> > @@ -128,6 +128,8 @@ void printdec(unsigned int value);
> >                       (1 << CONFIG_DEBUG_UART_SHIFT), \
> >               CONFIG_DEBUG_UART_SHIFT)
> >
> > +#ifdef CONFIG_DEBUG_UART
> > +
> >   /*
> >    * Now define some functions - this should be inserted into the serial driver
> >    */
> > @@ -197,4 +199,18 @@ void printdec(unsigned int value);
> >               _DEBUG_UART_ANNOUNCE \
> >       } \
> >
> > +#else
> > +
> > +#define DEBUG_UART_FUNCS \
> > +     #warning "DEBUG_UART not defined!"
> > +
> > +#define printch(ch) do{}while(0);
> > +#define printascii(str) do{}while(0);
> > +#define printhex2(value) do{}while(0);
> > +#define printhex4(value) do{}while(0);
> > +#define printhex8(value) do{}while(0);
> > +#define printdec(value) do{}while(0);
> > +
> > +#endif
> > +
> >   #endif

Best regards,
Lukasz
