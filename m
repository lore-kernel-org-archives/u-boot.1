Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DF8C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 17:42:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ED0C88611;
	Wed, 29 May 2024 19:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oCXt0vfQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1698A8861A; Wed, 29 May 2024 19:42:32 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6784388606
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 19:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-681bc7f50d0so181746a12.0
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 10:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717004548; x=1717609348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jPpxWjVwU/TiW9SBWr/JSQYBrQK3bfuCcs8VKXP4FQQ=;
 b=oCXt0vfQoq6mkDwUoJhptyoWfC5psHexpPpu5nCNN1bjRNzjCqgaY8ncm5hXHqhZoz
 3bXNvPf+67nsLu4zmwOy9QrsdZwSUGOOjUuyfq0Hc6Efw8KsNq4bYQfpJoKPTrziY1yc
 g/Y11/mXeew8hIwyxeB1NtfLSODKX2feVrriSbZnbGWke1RtlREA69WdeA2jZOFCNkOo
 ZF6KuZw/o81HGMat59Vs6Zz8MH9mScCjAi8mNLWJ/8fSMpAiAzcW6/RYSWi9jPm9WRWw
 3J3PVF/nkZAPRjeI2xo61PSjJ9iVMNY8G1ev7u+Og1KjrrXIBWtWkcVYPlHMrxiRoXyb
 pGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717004548; x=1717609348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jPpxWjVwU/TiW9SBWr/JSQYBrQK3bfuCcs8VKXP4FQQ=;
 b=P0mpJlVhlWXOoUbqt2P9wqAi4uLoZx2nyfhKa9aaDtgqxMxTaHhyHi481M8LOA1Ur+
 fCc/H83gEZkUulCa8Ik2sMzxxEXVUDuQdlbaKK707Zep0m2MzF1Oz6bn32mFgqbWQH02
 qfd+v81sDrrxo0Q4D8kKrvMPrO1CNl1NZdoRb6c0nqC6t3VoHNngNEzNg/9qlJ4yYIvv
 cGSca37Odi4qvmki+rEswzm+XAE1wkRd4H06gfnJOV1FveA5HGBTp+xv2oE1m1FwIcR+
 WvuVN1PMZtaSs49t//CQRhRw+lAOEGiNdSrJ6w2HVYBKtUZ8ahWGAWokMOp4vhIl84MB
 N3vQ==
X-Gm-Message-State: AOJu0YxYTCoQK5/VfLKTkWUTxa8I1Bv6QLe/HfjStL+y7gmaAxTI/QMp
 l7ZglQF3vGMwblxEStF5+JHZ/v/mgBrQZoygSBNoSg0C/gCr22v+mkBcsuKzE9nvP3wtrwmEgLb
 eXf3Rdzz16mUt7mYDC686YwWFIoYAk+mWNhUrqg==
X-Google-Smtp-Source: AGHT+IEgdoLXxi/Sd5g5kJFd37i0/Zl0U9GwYYp+l9RwyYwtusLGfRnEwWXWdpUSYjUp+0HCO35g174EyOYbM+gtj6s=
X-Received: by 2002:a17:90b:3c1:b0:2bd:b302:95d9 with SMTP id
 98e67ed59e1d1-2c02e8e1071mr4363041a91.0.1717004547768; Wed, 29 May 2024
 10:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-4-raymond.mao@linaro.org>
 <20240529165814.GQ2568172@bill-the-cat>
In-Reply-To: <20240529165814.GQ2568172@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 29 May 2024 13:42:16 -0400
Message-ID: <CAEfUkU+zKyaqc5tFy0rN3ofm3pRuckZX6PbD00VNtWQc5COZyA@mail.gmail.com>
Subject: Re: [PATCH v3 03/25] mbedtls: add mbedtls into the build system
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Stefan Bosch <stefan_b@posteo.net>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,

On Wed, 29 May 2024 at 12:58, Tom Rini <trini@konsulko.com> wrote:

> On Tue, May 28, 2024 at 07:09:14AM -0700, Raymond Mao wrote:
>
> > Port mbedtls with dummy libc header files.
> > Add mbedtls default config header file.
> > Optimize mbedtls default config by disabling unused features to
> > reduce the target size.
> > Add mbedtls kbuild makefile.
> > Add Kconfig and mbedtls config submenu.
> [snip]
> > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > new file mode 100644
> > index 00000000000..d6e77d56871
> > --- /dev/null
> > +++ b/lib/mbedtls/Kconfig
> > @@ -0,0 +1,25 @@
> > +menuconfig MBEDTLS_LIB
> > +     bool "Use mbedtls libraries"
> > +     select MBEDTLS_LIB_CRYPTO
> > +     select MBEDTLS_LIB_X509
> > +     help
> > +       Enable mbedtls libraries
> > +
> > +if MBEDTLS_LIB
> > +
> > +config MBEDTLS_LIB_CRYPTO
> > +     bool "Crypto library"
> > +     help
> > +       Enable mbedtls crypto library
> > +
> > +config MBEDTLS_LIB_X509
> > +     bool "X509 library"
> > +     help
> > +       Enable mbedtls X509 library
> > +
> > +config MBEDTLS_LIB_TLS
> > +     bool "TLS library"
> > +     help
> > +       Enable mbedtls TLS library
> > +
> > +endif # MBEDTLS_LIB
>
> We need much more granularity here, and to re-think some existing
> symbols too perhaps. What we should be able to do is pick mbedTLS or
> "legacy SW implementation" or "HW implementation" for the various
> algorithms, and that in turn can have some higher level grouping to it.
> This should then negate a bunch of the Makefile work you're doing as we
> won't have CONFIG_SHA256 enabled as we'll have CONFIG_MBEDTLS_LIB_SHA256
> or whatever enabled.
>

I think we should use CONFIG_MBEDTLS_LIB_[CRYPTO,X509,TLS] for high-level
grouping.
Underneath, the CONFIG_SHA[1,256,512] switches (and other crypto options)
can be
used as sub build options in both MbedTLS and "legacy libs".

Take hash as an example, if the users prefer to use MbedTLS other than
"legacy libs" for
hash operation, CONFIG_MBEDTLS_LIB_CRYPTO should be defined as the main
switch
(the users can still prefer to use "legacy libs" for X509 by
keeping  CONFIG_MBEDTLS_LIB_X509
disabled).
Then enable the algorithms they need (e.g. CONFIG_SHA256) - the algorithm
options works
for both MbedTLS and "legacy libs".

HW implementations with MbedTLS (aka, Alternative algorithms in MbedTLS) is
another
topic which is not covered in this patch set (It needs to migrate each
vendor's solution under
MbedTLS alternative algorithm).
Current patch set is focused on SW implementation with MbedTLS.

Regards,
Raymond
