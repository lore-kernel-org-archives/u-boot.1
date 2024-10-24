Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B448CE8E96
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 16:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F4B188E63;
	Thu, 24 Oct 2024 18:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Zdmv4HHS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 088E188F45; Thu, 24 Oct 2024 18:54:50 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ABD388D47
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 18:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20c6f492d2dso11714275ad.0
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 09:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729788878; x=1730393678; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=03g8IvNAY9k1SyLl4vqWo/5ueUKxgryxZv4X9lfwpiQ=;
 b=Zdmv4HHSQEurAlfJYbqjnQnsMofFGvmjluAo0EKrMjOS92FEovfmGvhejUAu26d3iu
 C+IInEiaY7mT/PlmA/DCjJtPWtxsWxcuxhePYPfeIZGyt23b65vcSBMNd0MRNcv1yI55
 X2UGGJiM/+Pfvn1G9//RRdQBI7Rln1wxhULL6e1rb0H2J8vGrg9TL8dtA8NO2HI8Da4B
 YcK0USYVocl2X9tM9Dd5Y1FSchYmY9vQ1FVnRTGVg0P21aeU5XEef5IH+76hLHSnerNe
 6NYD2GcxMN3Doyq+BvuOwpsiDaM6nxWFoG/uXxHgeGrf3NUkFrccOKZ7Cdc73/pe0Jly
 G9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729788878; x=1730393678;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=03g8IvNAY9k1SyLl4vqWo/5ueUKxgryxZv4X9lfwpiQ=;
 b=gvkkTXSe/yMFVaQsHDf9SYnVFza7kF6rss8D0TRlkFMVipdKXEpCxsiXenbNBecKLW
 1V9ResTw2K573ruW/Vw/L2kClhaR/lg9Gfdh/VrkOwhThpGm83JEj75lUvt6Q06KLwLt
 wHmFSxfFPhW+hQE9aONzJ1OrrrPko4RpDdwqc8EgRSKfg+EIs5JPdIqheK4ImiePtnAD
 XiGYJktYlnE/eCps7tv/AS7izbP0UbxqdK8xFP8UwnrpvaswIGFn8HSPfqUFkqLR9Cdh
 tXlUuTORkl/RHk72Dtk0TKQEU1ML9QJSL15xfpctbOw+uLoABhciLs7GRVhIM/jBDSkS
 kTqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmr54bpoeVP3BHFfsOyXl0qekthITglWrjRdffV4vCICVpnsUbOlCaXdDFwZoj9uptDQa3Xno=@lists.denx.de
X-Gm-Message-State: AOJu0Yzjit9kP2rZx7jeEy/58I2ZrZXoshZg9qD5t85v/H2xf22iOuF2
 7ieAneYEO5K7XxWyhEcq2H2rx8BxyLZyFRcAC2ZKiGX5OOkGlVK1oHUpvaPElbHooAiJYHgdK5q
 CNFNnVLlzMuiS5b2HakC+LGqcAwEbvdbn9ZbYBw==
X-Google-Smtp-Source: AGHT+IGTEEpiGQVMQpYk4gH8fcz/GAikzzQfQebWeVxz1UMMUDGvLmnUd1H0hx18PlaUr5nAwgcFIrMG/7aRnT8sUlI=
X-Received: by 2002:a17:90a:ad91:b0:2e2:a2f0:e199 with SMTP id
 98e67ed59e1d1-2e76b5b6820mr7133906a91.8.1729788878255; Thu, 24 Oct 2024
 09:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
 <20241024112449.1362319-2-ilias.apalodimas@linaro.org>
 <CAEfUkUKxUC5gmqBaTDFyG=1p=7Eah=5HkysJP-zpXsHoLHwUYw@mail.gmail.com>
 <CAC_iWjJnoRU7h+182EU9hXZnwfOVf0G5wPALtg4PRvM_MgDFgw@mail.gmail.com>
In-Reply-To: <CAC_iWjJnoRU7h+182EU9hXZnwfOVf0G5wPALtg4PRvM_MgDFgw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 24 Oct 2024 12:54:25 -0400
Message-ID: <CAEfUkU+r9Nu6ZOjdDbuvUSSZXAzjc_WELDNNffwCYbQ4Yk7wmg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] mbedtls: Enable TLS 1.2 support
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: jerome.forissier@linaro.org, xypron.glpk@gmx.de, 
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
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

On Thu, 24 Oct 2024 at 10:44, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond
>
> On Thu, 24 Oct 2024 at 17:13, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Ilias,
> >
> > On Thu, 24 Oct 2024 at 07:25, Ilias Apalodimas <
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
> >>  lib/mbedtls/Makefile             | 31 +++++++++++++++++++
> >>  lib/mbedtls/mbedtls_def_config.h | 52 ++++++++++++++++++++++++++++++++
> >>  3 files changed, 95 insertions(+)
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
> >> index 83cb3c2fa705..ce0a61e40541 100644
> >> --- a/lib/mbedtls/Makefile
> >> +++ b/lib/mbedtls/Makefile
> >> @@ -26,6 +26,7 @@ mbedtls_lib_crypto-y := \
> >>         $(MBEDTLS_LIB_DIR)/platform_util.o \
> >>         $(MBEDTLS_LIB_DIR)/constant_time.o \
> >>         $(MBEDTLS_LIB_DIR)/md.o
> >> +
> >>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5_MBEDTLS) +=
> $(MBEDTLS_LIB_DIR)/md5.o
> >>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1_MBEDTLS) +=
> $(MBEDTLS_LIB_DIR)/sha1.o
> >>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \
> >> @@ -54,3 +55,33 @@
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
> >> diff --git a/lib/mbedtls/mbedtls_def_config.h
> b/lib/mbedtls/mbedtls_def_config.h
> >> index 1af911c2003f..ac8f0bbf2c0e 100644
> >> --- a/lib/mbedtls/mbedtls_def_config.h
> >> +++ b/lib/mbedtls/mbedtls_def_config.h
> >> @@ -87,4 +87,56 @@
> >>
> >>  #endif /* #if defined CONFIG_MBEDTLS_LIB_X509 */
> >>
> >> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS)
> >
> >
> > It would be better to use "#if defined CONFIG_MBEDTLS_LIB_TLS" here,
> > as in SPL build it implicitly expects a "CONFIG_SPL_MBEDTLS_LIB_TLS"
> > which we don't have.
> >
>
> We usually prefer CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS) regardless of an
> SPL flag or not.
>
> If the flag is never expected to be enabled in SPL build, that is OK.
Because in SPL, CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS) will be always false
without a CONFIG_SPL_MBEDTLS_LIB_TLS.

Regards,
Raymond
