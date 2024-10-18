Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCC4D30011
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 15:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 123F388C3E;
	Fri, 18 Oct 2024 17:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JsE3wAbH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE13488E77; Fri, 18 Oct 2024 17:26:19 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D038889DA
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 17:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e2b549799eso1690698a91.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729265176; x=1729869976; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v9F8SGOIMiAYJlJeom4B7GCd441vm+ttmmxOtDYnzC8=;
 b=JsE3wAbHrnP7zrpFIvh0QEskhbBMCXNd3IkRWePK+0HOPrNcpmFX7X4kzRR7WOtEpc
 OY25gop4eytOp5Fwqd/AIlK0MhroTALc4S1qiu+dZZt/4bkB0y/+7OkYGM8qUcjtDwLY
 ZYhDxocpNjT6pTcLBeaj+WsEgqU/yFLdeTMJVIC3sWhhRjup+sIQSIAeKxOXH267nx6Y
 LHnUHx20JIoTDPNqhYnZWAxutPoEAH4dPIKg2PIwuCG1KCBn5rqH2uMqK/Zw7NxHVJSX
 VzCg/wqMbSbkMPPBxYM5hMHG9GKQRGtX9Ql7vAbbf8ecHhY+iOwihbMDKwvk1wlbgjcz
 Y8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729265176; x=1729869976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v9F8SGOIMiAYJlJeom4B7GCd441vm+ttmmxOtDYnzC8=;
 b=oHzloxi8Vt5SW4gH6bXtsLWbmotkwSG3rFGekkBXSLhUiJr1wr8YIa//YrkJslbb5b
 7XiLYhJFtREosHOzl749gQhrFtKXYly1QdjLxV6geEO1T1QsWUP7hUSoSyAEhzTvf5Ua
 FTHgXltzLpXqbLSJgWcJelJSmG55aS2vKZ6sJseqqLcgZI5t9v2eND8AXzlmB+Cz1Ayn
 y3C3UYpUwsJcycrYS/dRb7yehF7v/8izYFmdsvq3gVxKZi4v98vJ+TKNglAk+sxdGUUr
 mYcX7n7VuF5dwO9WyoixVEX2y0Y7I+d3sVNYOBYcyuP3iYnvugo1IKr6BRI7PwHfboKK
 4h4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVntY3fdUVU8bGOkyYJkQhapxXmqRXsB4KeL/et25KzXFPBtHO+zJwAR7zwmb3QjDxacQDkE1w=@lists.denx.de
X-Gm-Message-State: AOJu0YyXQw51a353kHoK5S1Hg0djPLxnGs48M0a31+HIE1DxbH5z5xip
 c59F4oY36I6E/X65/oZURtQK615xQ6nYtdHWTRldgo68zfctyjZOmCzVBOFhwA77Ye127VpRxiQ
 l1TyffIjhBNWNpED8Zr+IMd9AzpINnTk44LRb4Q==
X-Google-Smtp-Source: AGHT+IGziuvDp2ctPVnGQPoPv9VSSrKwFxS1OU1BL4qwm+y1AknbHS2MtFOZ8aCEwGswH78PvoedAHkCFRyI4JJCEBE=
X-Received: by 2002:a17:90a:ac06:b0:2e5:5e55:7f1b with SMTP id
 98e67ed59e1d1-2e5616c41f7mr3616613a91.4.1729265175818; Fri, 18 Oct 2024
 08:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
 <20241018142235.715571-2-ilias.apalodimas@linaro.org>
 <CAEfUkUJFWHz350pY2WQmm9=hex6VXH1HGzupp1W70rMFaH2SAg@mail.gmail.com>
 <CAC_iWjLLu9GEkst9BZPSUy-nemBvZVH9OySnaLmSZ4tOdDbRhQ@mail.gmail.com>
In-Reply-To: <CAC_iWjLLu9GEkst9BZPSUy-nemBvZVH9OySnaLmSZ4tOdDbRhQ@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 18 Oct 2024 11:26:05 -0400
Message-ID: <CAEfUkUKCGRR5PG8d-HcuEU09s=Bb7EUKc+E3tWRCGg=7qHz13g@mail.gmail.com>
Subject: Re: [PATCH 1/6] mbedtls: Enable TLS 1.2 support
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: jerome.forissier@linaro.org, xypron.glpk@gmx.de, 
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Wei Ming Chen <jj251510319013@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
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

Hi Ilias,

On Fri, 18 Oct 2024 at 10:55, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond,
>
> On Fri, 18 Oct 2024 at 17:39, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Ilias,
> >
> > On Fri, 18 Oct 2024 at 10:22, Ilias Apalodimas <
> ilias.apalodimas@linaro.org> wrote:
> >>
> >> Since lwIP and mbedTLS have been merged we can tweak the config options
> >> and enable TLS1.2 support. Add RSA and ECDSA by default and enable
> >> enough block cipher modes of operation to be comatible with modern
> >> TLS requirements and webservers
> >>
> >> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> ---
> >>  lib/mbedtls/Kconfig              | 12 ++++++++
> >>  lib/mbedtls/Makefile             | 33 +++++++++++++++++++-
> >>  lib/mbedtls/mbedtls_def_config.h | 52 ++++++++++++++++++++++++++++++++
> >>  3 files changed, 96 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> >> index d71adc3648ad..f3e172633999 100644
> >> --- a/lib/mbedtls/Kconfig
> >> +++ b/lib/mbedtls/Kconfig
> >> @@ -430,4 +430,16 @@ endif # SPL
> >>
> >>  endif # MBEDTLS_LIB_X509
> >>
> >> +config MBEDTLS_LIB_TLS
> >> +       bool "MbedTLS TLS library"
> >> +       depends on RSA_PUBLIC_KEY_PARSER_MBEDTLS
> >> +       depends on X509_CERTIFICATE_PARSER_MBEDTLS
> >> +       depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> >> +       depends on ASN1_DECODER_MBEDTLS
> >> +       depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> >> +       depends on MBEDTLS_LIB_CRYPTO
> >> +       help
> >> +         Enable MbedTLS TLS library. If enabled HTTPs support will be
> enabled
> >> +         in wget
> >> +
> >>  endif # MBEDTLS_LIB
> >> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> >> index 83cb3c2fa705..845284799a11 100644
> >> --- a/lib/mbedtls/Makefile
> >> +++ b/lib/mbedtls/Makefile
> >> @@ -25,7 +25,19 @@ obj-$(CONFIG_MBEDTLS_LIB) += mbedtls_lib_crypto.o
> >>  mbedtls_lib_crypto-y := \
> >>         $(MBEDTLS_LIB_DIR)/platform_util.o \
> >>         $(MBEDTLS_LIB_DIR)/constant_time.o \
> >> -       $(MBEDTLS_LIB_DIR)/md.o
> >> +       $(MBEDTLS_LIB_DIR)/md.o \
> >> +       $(MBEDTLS_LIB_DIR)/entropy.o \
> >> +       $(MBEDTLS_LIB_DIR)/entropy_poll.o \
> >> +       $(MBEDTLS_LIB_DIR)/aes.o \
> >> +       $(MBEDTLS_LIB_DIR)/cipher.o \
> >> +       $(MBEDTLS_LIB_DIR)/cipher_wrap.o \
> >> +       $(MBEDTLS_LIB_DIR)/ecdh.o \
> >> +       $(MBEDTLS_LIB_DIR)/ecdsa.o \
> >> +       $(MBEDTLS_LIB_DIR)/ecp.o \
> >> +       $(MBEDTLS_LIB_DIR)/ecp_curves.o \
> >> +       $(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
> >> +       $(MBEDTLS_LIB_DIR)/gcm.o \
> >> +
> >
> > I think we should move these to mbedtls_lib_tls.o and add the U-Boot
> Kconfig
> > control if it exists.
> > Take ECDSA for example:
> > mbedtls_lib_tls-$(CONFIG_$(SPL_)ECDSA) += $(MBEDTLS_LIB_DIR)/ecdsa.o
>
> Fair enough, but ECDSA is the only one that exists atm. I can move
> that there, but I don't think we should create a Kconfig option per
> object file.
> Those are mbedTLS internals dependencies to enable TLS1.2.  Perhaps
> only ECDSA, AES and ECDH? OTOH the existing md5 doesn't follow that.
>
> I agree. We can move ECDSA and AES with Kconfig control and keep others
as-is at the moment.


> >
> >>
> >>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5_MBEDTLS) +=
> $(MBEDTLS_LIB_DIR)/md5.o
> >>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1_MBEDTLS) +=
> $(MBEDTLS_LIB_DIR)/sha1.o
> >>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \
> >> @@ -54,3 +66,22 @@
> mbedtls_lib_x509-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
> >>         $(MBEDTLS_LIB_DIR)/x509_crt.o
> >>  mbedtls_lib_x509-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += \
> >>         $(MBEDTLS_LIB_DIR)/pkcs7.o
> >> +
> >> +#mbedTLS TLS support
> >> +obj-$(CONFIG_MBEDTLS_LIB_TLS) += mbedtls_lib_tls.o
> >> +mbedtls_lib_tls-y := \
> >> +       $(MBEDTLS_LIB_DIR)/mps_reader.o \
> >> +       $(MBEDTLS_LIB_DIR)/mps_trace.o \
> >> +       $(MBEDTLS_LIB_DIR)/net_sockets.o \
> >> +       $(MBEDTLS_LIB_DIR)/pk_ecc.o \
> >> +       $(MBEDTLS_LIB_DIR)/ssl_cache.o \
> >> +       $(MBEDTLS_LIB_DIR)/ssl_ciphersuites.o \
> >> +       $(MBEDTLS_LIB_DIR)/ssl_client.o \
> >> +       $(MBEDTLS_LIB_DIR)/ssl_cookie.o \
> >> +       $(MBEDTLS_LIB_DIR)/ssl_debug_helpers_generated.o \
> >> +       $(MBEDTLS_LIB_DIR)/ssl_msg.o \
> >> +       $(MBEDTLS_LIB_DIR)/ssl_ticket.o \
> >> +       $(MBEDTLS_LIB_DIR)/ssl_tls.o \
> >> +       $(MBEDTLS_LIB_DIR)/ssl_tls12_client.o \
> >> +       $(MBEDTLS_LIB_DIR)/hmac_drbg.o \
> >> +       $(MBEDTLS_LIB_DIR)/ctr_drbg.o \
> >
> > Ditto, add the U-Boot Kconfig control if it exists.
>
> None of these don't make sense to be a U-Boot Kconfig. They are
> mbedTLS internal to enable TLS1.2 support.
>

I saw Jerome added CONFIG_NET and CONFIG_NET_LWIP in his LWIP series.
I think the net_sockets, ssl_# and ssl_tls12_# can be under this control.

[snip]

Regards,
Raymond
