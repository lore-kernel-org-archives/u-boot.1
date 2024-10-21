Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC97BD15D98
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 14:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21DC488E41;
	Mon, 21 Oct 2024 16:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vOLNPKlr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 128A188E91; Mon, 21 Oct 2024 16:03:50 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D402889EB
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 16:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20c6f492d2dso52197675ad.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729519426; x=1730124226; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NMXtodvsLTCooRdwYNDPf2hAIQ9UFz8FIshq67TjlXo=;
 b=vOLNPKlriTlGOpmQumFNX7wSdPDnU/JVW/SoNHDcihugFwl2VfXQVwxOfR7HFNxhu6
 HzVvLtjG2+OczwitYaOCveUY2gC2YiECABoQ5n6XGN9199RR1LaTYV1Lq/edw53W11Wq
 KMfrhjWdr3RmTAMBqUWklOLqr8JrWVWnZT1+S4+KE1VYihnWCzNVLSNQHkFo3b1+5/96
 /tWOynRDHch4JnVw4IOyBXkRy2/t4ELEvtwfS+NvXq6o9gZCMNBCcF6SgjlGdodCVr4E
 xvSNFMlVCz93xAcj1KAKxnbjJd1DpNmCv/Cf0uXc6ZUZTJFnGdeOXFVG5ZVL+QZcRdlr
 +i4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729519426; x=1730124226;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NMXtodvsLTCooRdwYNDPf2hAIQ9UFz8FIshq67TjlXo=;
 b=G854kPAGezio/hrAxGafnluI8WbcG9jeCARC7gUqIWGJ0aDAWhZtpTb0mwbG04Ai5b
 oWLsTe2vVIEVME0nte6wr28QbobgpL9avlU2dtdZyXTmICW/iU4It7EQ/vhpzBUWTIlN
 R5WpCo7grdxM80/fNN2cDUWKNh7+t+daVwuzYUxfi8+i1O6VaCgoKYCvF2GitHMw+s+Y
 6oBDxdbgLhh8n7QRztue6hSX5KdCT/pk4lnVftZjUdVjUvAu5UbLoDk42TEciKbT4Xp1
 qNvFrkudSrL965V0vCAs67i+DinFpdzoLUmdgOf7MdxOKXDcGkL8m1jMWBvnMk0WpxuQ
 fgbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrzXwAQTf229+FqToV7GSmLwXic5l9QRRFVPweAZ3r9OF2Grhc4p+lts8HxUQ1jRI5PPXR4mM=@lists.denx.de
X-Gm-Message-State: AOJu0YwGNnr+4nrb6nvI3MC8YQh2YE6U11tWw1xOmA71waEkDki0JuS5
 90KCZHTGcNmXgz+JyP50wYk3Ie2OWFA0FT8Wet9a+rfGQyCgILoSlrAeEv1huttiMjFnpM+QuOg
 sOTkp0vYyzb5OGduCYOGMNk2u3JVJQHRK9+PUDQ==
X-Google-Smtp-Source: AGHT+IHCp7t43khUy6FW7blOynmUQe8jokzFncENJzSKfFbxLSlOKksgjVJFlfCIL5K4Fzu+RxaUPHI/dvsI564DGgQ=
X-Received: by 2002:a17:90b:144:b0:2e0:a77e:82f7 with SMTP id
 98e67ed59e1d1-2e561a141bemr15064163a91.36.1729519425731; Mon, 21 Oct 2024
 07:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
 <20241018142235.715571-2-ilias.apalodimas@linaro.org>
 <CAEfUkUJFWHz350pY2WQmm9=hex6VXH1HGzupp1W70rMFaH2SAg@mail.gmail.com>
 <CAC_iWjLLu9GEkst9BZPSUy-nemBvZVH9OySnaLmSZ4tOdDbRhQ@mail.gmail.com>
 <CAEfUkUKCGRR5PG8d-HcuEU09s=Bb7EUKc+E3tWRCGg=7qHz13g@mail.gmail.com>
 <CAC_iWj+AUu7VoOsRmgdpdiRShZPiHoRXnZM_4iv8OSNWcF02Zg@mail.gmail.com>
In-Reply-To: <CAC_iWj+AUu7VoOsRmgdpdiRShZPiHoRXnZM_4iv8OSNWcF02Zg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 21 Oct 2024 10:03:35 -0400
Message-ID: <CAEfUkUKAoD8u5A9CG4r5=x7d52OtD7i8EZdCgPqdFCnVUFyesg@mail.gmail.com>
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

On Mon, 21 Oct 2024 at 06:32, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond,
>
> On Fri, 18 Oct 2024 at 18:26, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Ilias,
> >
> > On Fri, 18 Oct 2024 at 10:55, Ilias Apalodimas <
> ilias.apalodimas@linaro.org> wrote:
> >>
> >> Hi Raymond,
> >>
> >> On Fri, 18 Oct 2024 at 17:39, Raymond Mao <raymond.mao@linaro.org>
> wrote:
> >> >
> >> > Hi Ilias,
> >> >
> >> > On Fri, 18 Oct 2024 at 10:22, Ilias Apalodimas <
> ilias.apalodimas@linaro.org> wrote:
> >> >>
> >> >> Since lwIP and mbedTLS have been merged we can tweak the config
> options
> >> >> and enable TLS1.2 support. Add RSA and ECDSA by default and enable
> >> >> enough block cipher modes of operation to be comatible with modern
> >> >> TLS requirements and webservers
> >> >>
> >> >> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> >> ---
> >> >>  lib/mbedtls/Kconfig              | 12 ++++++++
> >> >>  lib/mbedtls/Makefile             | 33 +++++++++++++++++++-
> >> >>  lib/mbedtls/mbedtls_def_config.h | 52
> ++++++++++++++++++++++++++++++++
> >> >>  3 files changed, 96 insertions(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> >> >> index d71adc3648ad..f3e172633999 100644
> >> >> --- a/lib/mbedtls/Kconfig
> >> >> +++ b/lib/mbedtls/Kconfig
> >> >> @@ -430,4 +430,16 @@ endif # SPL
> >> >>
> >> >>  endif # MBEDTLS_LIB_X509
> >> >>
> >> >> +config MBEDTLS_LIB_TLS
> >> >> +       bool "MbedTLS TLS library"
> >> >> +       depends on RSA_PUBLIC_KEY_PARSER_MBEDTLS
> >> >> +       depends on X509_CERTIFICATE_PARSER_MBEDTLS
> >> >> +       depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> >> >> +       depends on ASN1_DECODER_MBEDTLS
> >> >> +       depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> >> >> +       depends on MBEDTLS_LIB_CRYPTO
> >> >> +       help
> >> >> +         Enable MbedTLS TLS library. If enabled HTTPs support will
> be enabled
> >> >> +         in wget
> >> >> +
> >> >>  endif # MBEDTLS_LIB
> >> >> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> >> >> index 83cb3c2fa705..845284799a11 100644
> >> >> --- a/lib/mbedtls/Makefile
> >> >> +++ b/lib/mbedtls/Makefile
> >> >> @@ -25,7 +25,19 @@ obj-$(CONFIG_MBEDTLS_LIB) += mbedtls_lib_crypto.o
> >> >>  mbedtls_lib_crypto-y := \
> >> >>         $(MBEDTLS_LIB_DIR)/platform_util.o \
> >> >>         $(MBEDTLS_LIB_DIR)/constant_time.o \
> >> >> -       $(MBEDTLS_LIB_DIR)/md.o
> >> >> +       $(MBEDTLS_LIB_DIR)/md.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/entropy.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/entropy_poll.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/aes.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/cipher.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/cipher_wrap.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/ecdh.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/ecdsa.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/ecp.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/ecp_curves.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/gcm.o \
> >> >> +
> >> >
> >> > I think we should move these to mbedtls_lib_tls.o and add the U-Boot
> Kconfig
> >> > control if it exists.
> >> > Take ECDSA for example:
> >> > mbedtls_lib_tls-$(CONFIG_$(SPL_)ECDSA) += $(MBEDTLS_LIB_DIR)/ecdsa.o
> >>
> >> Fair enough, but ECDSA is the only one that exists atm. I can move
> >> that there, but I don't think we should create a Kconfig option per
> >> object file.
> >> Those are mbedTLS internals dependencies to enable TLS1.2.  Perhaps
> >> only ECDSA, AES and ECDH? OTOH the existing md5 doesn't follow that.
> >>
> > I agree. We can move ECDSA and AES with Kconfig control and keep others
> as-is at the moment.
>
> Ok I had a closer look at this. ECDSA and AES currently have Kconfig
> options for the legacy crypto libs. As a result, we need to define
> mbedtls variants etc which is ok.
> We only have one board using AES atm and sandbox using ECDSA. Since I
> want efi https for 2025.01, we can move the new .o files under
> CONFIG_MBEDTLS_LIB_TLS and then send a patch on top cleaning up the
> Kconfigs for all crypto which is a bit messy atm.
>
> Are you ok with this?
>
> Yes, I agree. We can do this after all related patches are merged.


> >
> >>
> >> >
> >> >>
> >> >>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5_MBEDTLS) +=
> $(MBEDTLS_LIB_DIR)/md5.o
> >> >>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1_MBEDTLS) +=
> $(MBEDTLS_LIB_DIR)/sha1.o
> >> >>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \
> >> >> @@ -54,3 +66,22 @@
> mbedtls_lib_x509-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
> >> >>         $(MBEDTLS_LIB_DIR)/x509_crt.o
> >> >>  mbedtls_lib_x509-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += \
> >> >>         $(MBEDTLS_LIB_DIR)/pkcs7.o
> >> >> +
> >> >> +#mbedTLS TLS support
> >> >> +obj-$(CONFIG_MBEDTLS_LIB_TLS) += mbedtls_lib_tls.o
> >> >> +mbedtls_lib_tls-y := \
> >> >> +       $(MBEDTLS_LIB_DIR)/mps_reader.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/mps_trace.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/net_sockets.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/pk_ecc.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/ssl_cache.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/ssl_ciphersuites.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/ssl_client.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/ssl_cookie.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/ssl_debug_helpers_generated.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/ssl_msg.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/ssl_ticket.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/ssl_tls.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/ssl_tls12_client.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/hmac_drbg.o \
> >> >> +       $(MBEDTLS_LIB_DIR)/ctr_drbg.o \
> >> >
> >> > Ditto, add the U-Boot Kconfig control if it exists.
> >>
> >> None of these don't make sense to be a U-Boot Kconfig. They are
> >> mbedTLS internal to enable TLS1.2 support.
> >
> >
> > I saw Jerome added CONFIG_NET and CONFIG_NET_LWIP in his LWIP series.
> > I think the net_sockets, ssl_# and ssl_tls12_# can be under this control.
>
> I would prefer having TLS as a separate Kconfig option. We might need
> to use it without wget and binding mbedTLS to lwIP doesn't make that
> much sense. It does *currently* because that's the only code that uses
> it
>
> That is fine. Thanks.

Regards,
Raymond
