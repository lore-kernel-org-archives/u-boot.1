Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DD0C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 08:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A859E88276;
	Tue, 30 Jul 2024 10:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kS42n1X8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51D8788276; Tue, 30 Jul 2024 10:04:05 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBFA388585
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 10:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-6e7e23b42c3so2541831a12.1
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 01:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722326641; x=1722931441; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ken60PYWbCNbajP+Jxd9E9SJ8j9OwJ/4GNFAP2YrzYE=;
 b=kS42n1X8Rl/c5uxadw8QiqEKEOt3uSgdnYLGa78YN3fUH5jb4NstJq4iMCycesfoVQ
 ChccDNzzjN+UrKhPBO2cbAhRUd8lS34JFEK/51r7bT4FA+43MGEPkUI7/3H0bMPdxC4U
 P4HkTrNHY+bojFHT/qCqG48Nt1GLNsNzxWsvzVwZKucgKqO2tDELfTPfBEXP3bExNYcU
 kZeGJl6AxJaf9cjwJbvHg5xIoIJ6mhkM9U2FLvuMrRaXYzVxN8B3hxf+KhCRKo7WFgGt
 BTDlD19syPk+w12Ups9s7ruVNG+edelQAEg+9wAGYFskl688Tiklwb0JSVeM+P0Tdg+8
 izKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722326641; x=1722931441;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ken60PYWbCNbajP+Jxd9E9SJ8j9OwJ/4GNFAP2YrzYE=;
 b=NeDEtFUZUvC37khbgNmZTRseMs05cpM2Rp1lrMDsWygkBKyCBXomlL/0WCeqidOTrF
 8A31LyyeaKn8/Ekn7d2sEmR2UBQvZMw+81sbh8zS+qemvxIIvda9P5FOBPt2LO04naRk
 Ru4kKim2/FqZqTQE5ubdWJU6JVVH76auer0r2V7wrOxl1bWiE6fGlwh0UfTGs06RQI2x
 bN9nyC8uPq7bGEdHEMvTOnoL45ONA6sWCKZfYNaNorQks69hCTJ1G3mFfS7DFU36xoEH
 VRkwlDUYr8ECUFcGACoV4YS1xL064/4f/au7tqpOsgmb/Kx4rK7lCXhpQzGWm55nv1gl
 k64g==
X-Gm-Message-State: AOJu0YyAsWmLY2y5EmCY/HsUSun7YnFiophqwXVg13eKIlux9SGd3Thl
 3p39QBFq6ZffQ/FqKtZFU/wv3J//Fl8s7tIUt7xhyTL4Q0NLB5ldd7oj7N8l1lEabSww+zIN4ii
 I6kgf4qTibdeg3pvGlAQLwHxy7tOuJvnTzoP7sQ==
X-Google-Smtp-Source: AGHT+IFIMaLSOLkzw3yeNSvS9gIOJnpV+5gogX8p8nVqcjioFKrF0RE15bnd3dvRhcXUn8TC9ePf8SB8WNTaJNj4MUc=
X-Received: by 2002:a05:6a20:7fa4:b0:1be:c3c1:7be8 with SMTP id
 adf61e73a8af0-1c4a12ccde2mr9918922637.26.1722326639539; Tue, 30 Jul 2024
 01:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-25-raymond.mao@linaro.org>
In-Reply-To: <20240702182325.2904421-25-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 30 Jul 2024 11:03:23 +0300
Message-ID: <CAC_iWjLfbb4OZOxxmY2VCOagWV2OBTghD=zJsN89u3QTvT4fuw@mail.gmail.com>
Subject: Re: [PATCH v4 24/29] lib/crypto: Adapt mscode_parser to MbedTLS
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Sergei Antonov <saproj@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng@tinylab.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

Hi Raymond,

On Tue, 2 Jul 2024 at 21:33, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Previous patch has introduced MbedTLS porting layer for mscode parser,
> here to adjust the header and makefiles accordingly.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Move the porting layer to MbedTLS dir.
> Changes in v3
> - Update commit message.
> Changes in v4
> - Control building legacy library via '_LEGACY' Kconfig.
> - Minor fix of the include directories.
>
>  include/crypto/mscode.h | 4 ++++
>  lib/crypto/Makefile     | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/crypto/mscode.h b/include/crypto/mscode.h
> index 551058b96e6..678e69001b9 100644
> --- a/include/crypto/mscode.h
> +++ b/include/crypto/mscode.h
> @@ -9,6 +9,10 @@
>  #ifndef __UBOOT__
>  #include <crypto/hash_info.h>
>  #endif
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
> +#include <mbedtls/asn1.h>
> +#include <mbedtls/oid.h>
> +#endif
>
>  struct pefile_context {
>  #ifndef __UBOOT__
> diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
> index 428dcba0a6b..9bbd8b48d77 100644
> --- a/lib/crypto/Makefile
> +++ b/lib/crypto/Makefile
> @@ -63,7 +63,7 @@ obj-$(CONFIG_$(SPL_)PKCS7_VERIFY) += pkcs7_verify.o
>  #
>  # Signed PE binary-wrapped key handling
>  #
> -obj-$(CONFIG_$(SPL_)MSCODE_PARSER) += mscode.o
> +obj-$(CONFIG_$(SPL_)MSCODE_PARSER_LEGACY) += mscode.o

The change it self is correct. But patches should be self contained as
much as possible without breaking the compilation or functionality.
IOW I think this should be in a different patch where the
MSCODE_PARSER_LEGACY is introduced.

Cheers
/Ilias
>
>  mscode-y := \
>         mscode_parser.o \
> --
> 2.25.1
>
