Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7860CD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 18:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70AD6848D1;
	Fri, 12 Jun 2026 20:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="noHC75+O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86565848D8; Fri, 12 Jun 2026 20:33:47 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54B388063E
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 20:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-69165354c87so1680143a12.3
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781289225; cv=none;
 d=google.com; s=arc-20240605;
 b=BHvdO/iNFIsl6qO6NJQC1IiKjEliBDKCypBn25Z/htmVWLtLqzEARmvv98+8oO8C09
 HMLZOYR5mLWyR/yZ5F6XPZNrv2yzyGxa/p+8Pt8YRhhJwwjyAjSM8vJ40pQmgDc/5xf+
 75LlStgF+ZP0dguKQx5SDp6GkeCW3sMvg+xsSGqBkx0Jw+aR/LXiOd3W51eSB0ucQrrN
 Mj0fxuqR0ekz8a14H13fBBPliL/CR5KPEM7s/su/q1ksrXbQ5uoNz3IvyhcMvupnH4U4
 YFm8dny6OzxGBsH89WFtQGH0cXaiNB3oYL70ZyvsuYEe2nQGDg1awRFbWt9yfIuHqjm4
 qzow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IlEHZPOJFYfwUzcOlBVPPmqs7VpIZO9hPMFXnSpEX54=;
 fh=OxFdHNPn05EeiLeCvRrJu1kmtaT83kMZRcF0yCF/qbE=;
 b=Hr+QQ5IUnfkqrOTKv0wUc96/GBwgZY+iBSQY9tmwrJqwB403Lae81/MrBKgYG5hRzA
 V+AxZHikye45ZnXxf/+qPfnosctJVR0U/W3InM+1Auqq2H3b8v9+6bDAg6oSHei2I7ze
 2nEEodC/OnVolB+lij16LkCrR8ihHoN2G+Ur2L+Y5xyp8yXYBI6Vue2wpPCCsHhZ84QM
 udO44F5/QVevtJ+aLdn4hze2y95HFxD2sp3JVsPbZ+w0tCJVxKWs67j3jB/GR6O/nY5/
 nJpcOwDmcyTlDt+qaxh84NN2PiIzzwAHw5lYdUlp2Ah2JaLppkmgfBLbb9sf0jsSkZSB
 8ODQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781289225; x=1781894025; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IlEHZPOJFYfwUzcOlBVPPmqs7VpIZO9hPMFXnSpEX54=;
 b=noHC75+Ox2ig+qLc4keltg8V/p7T2AMvRP4/u1nIlGzLDe+Q7McSqE8zsTC+wn3PMU
 t2OEl7JPhZGNlgVNwvEn83vzKnzQcMcBZD/3gCmLVGcpNKIHxnmRNW7oQp5bLUvV5f8V
 2j/8g1Gfenb63ZM9fsxOmG+mMXBwOJJY4iw/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289225; x=1781894025;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IlEHZPOJFYfwUzcOlBVPPmqs7VpIZO9hPMFXnSpEX54=;
 b=pOZ2wV8EN/lxDt+U5OgwrEZ3l3cNBwTEFSjGTHZMasho0E7gl308HiA8DWk2B612aW
 nncygZ+tqDfGff8v2sf1xxJO7AiFbNTvHjCkfRbgwTazCPRI7eOajuFwdmbas6OnOUXd
 Qihizwzgj/SL1MaQjcb5+lp6VecyRfouoHsukIBvfibUa+hzxrkck78BfMyS8XCLUVRX
 h4TBH71ac+Vedvf5835uWJMXiPknQ5jUKQzXo6h8XnC7yUfLaZJSRpnfIQIutzj7Vqj5
 2d7J2asMT1NjcpAEWs5ZTwHjLM8Pw72E6ulfd1zWW27rnsdC9aNN23zhWAcXIpvimxA9
 w1Lg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8anoHE4VdXO2iRd74CSIRCMVjXSeZ9bwYdW+1HXy5tuAXF8hFzJEkHYHr/h7o0BfB+HpL2hHc=@lists.denx.de
X-Gm-Message-State: AOJu0YxzYAiyrV6Q3cFJM3veaI9luPeA9odWaQtWtAnKxVqwzdIl9N/d
 gvHUc0skoea6KTUpiokLcIGB8R7RXd2H9dxuJPtSaaEs/6UXzhcgL7n3r7rIf7EdWDyS5IoUeeN
 RxP8B0x9jBa8hpf4FDQguNStdQ5ZjZGpS4cOwegmm
X-Gm-Gg: Acq92OEl09l3gtzR8KkRtgKWRFA9j5A4n8ajLkuB1WLq+81GkoASpNib1e0wU1jqI0N
 BP4LbReDpoKkaAXEzgWsPERAGktGdsmUgmV6q0tBchBFZrXN95mA41x34wmeYH8Ums+10NUvdLk
 x9aBLEUQHBiDjzH5xtGr7yEmDn76WuZ5Q3tYX0dec6HhjcZ9VUhmep8/GyAnrGTf8h8F+qgazwq
 FtCDy9fqDqdgnT1xuTtWFdT0dsNKt2V5VYkffYtrUCvnM6Amd+pShLYUShs3wnwzARJUCAxjTAI
 PQ9X9A==
X-Received: by 2002:a05:6402:50d4:b0:68a:de40:26e4 with SMTP id
 4fb4d7f45d1cf-69378a5119cmr1959783a12.25.1781289224625; Fri, 12 Jun 2026
 11:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
 <20260601134310.2452454-3-philippe.reynes@softathome.com>
In-Reply-To: <20260601134310.2452454-3-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Jun 2026 12:33:32 -0600
X-Gm-Features: AVVi8CdtJMsm4G41xNUVqD4AwzXRHh0NxUjyJ1hB_PdjQhZAB56CdgDZizkpjug
Message-ID: <CAFLszTgBc-wkF6r2E8-ok-0MXZfG61i8-oUP_QCWYLXxq-FZXw@mail.gmail.com>
Subject: Re: [PATCH v8 02/15] mbedtls: enable support of ecc
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
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

Hi Philippe,

On 2026-06-01T13:42:58, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> mbedtls: enable support of ecc
>
> Prepares the support of ecdsa signature check
> using MbedTLS. It introduces the option ECDSA_MBEDTLS
> to enable (or not) the support of ecdsa in MbedTLS.
>
> So now, ecdsa is no longer supported by default in the lib TLS.
> To get it, the option ECDSA_MBEDTLS must be enabled.
>
> The option ECDSA_MBEDTLS only enables the ecdsa support
> in MbedTLS, it doesn't provide any API to use it for
> signature check. It will be done in another commit
> by adding the option ECDSA_VERIFY_MBEDTLS.
>
> Two internal options are also added BIGNUM_MBEDTLS
> and ECC_MBEDTLS. Those options are used to share code
> between different option and avoid duplication.
>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> [...]
>
> configs/sandbox_defconfig        |  1 +
>  lib/ecdsa/Kconfig                |  1 +
>  lib/mbedtls/Kconfig              | 17 +++++++++++++++++
>  lib/mbedtls/Makefile             | 17 ++++++++++-------
>  lib/mbedtls/mbedtls_def_config.h | 41 ++++++++++++++++++++++++++--------------
>  5 files changed, 56 insertions(+), 21 deletions(-)

I have some Kconfig nits mostly around SPL and this is v8 so I'm happy
for them to go in as a follow-up if that is easier.

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/lib/ecdsa/Kconfig b/lib/ecdsa/Kconfig
> @@ -1,6 +1,7 @@
>  config ECDSA
>       bool "Enable ECDSA support"
>       depends on DM
> +     select ASN1_DECODER

This makes every ECDSA user carry the ASN1 decoder, including boards
using a hardware implementation (e.g. the stm32mp ROM-API driver) or
the libcrypto path, neither of which needs it. The requirement comes
from the MbedTLS implementation only, so please can you put it on the
MbedTLS side instead, e.g. have ECDSA_MBEDTLS select ASN1_DECODER
(alongside its existing dependency on ASN1_DECODER_MBEDTLS)? Also this
change is not mentioned in the commit message.

> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> @@ -301,6 +317,7 @@ config MBEDTLS_LIB_TLS
>       depends on MBEDTLS_LIB
> +     select ECC_MBEDTLS

Just to check, what happens to wget https when MBEDTLS_LIB_TLS is
enabled but ECDSA_MBEDTLS is not? With this patch the ECDSA cipher
suites and ECDSA certificate verification disappear from the TLS
build, and a large fraction of public servers (e.g. Let's Encrypt)
serve ECDSA certificates these days, so existing users may find https
silently stops working for many sites. I understand the goal of making
ECDSA optional for size reasons, but perhaps ECDSA_MBEDTLS should have
'default y if MBEDTLS_LIB_TLS', or the help text for MBEDTLS_LIB_TLS
should mention ECDSA_MBEDTLS is needed for ECDSA certificates. What do
you think?

> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> @@ -39,13 +39,21 @@ mbedtls_lib_crypto-$(CONFIG_$(PHASE_)HKDF_MBEDTLS) += \
> +mbedtls_lib_x509-$(CONFIG_$(PHASE_)BIGNUM_MBEDTLS) += \
> +     $(MBEDTLS_LIB_DIR)/bignum.o \
> +     $(MBEDTLS_LIB_DIR)/bignum_core.o
>  mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASN1_DECODER_MBEDTLS) += \
>       $(MBEDTLS_LIB_DIR)/asn1parse.o \
>       $(MBEDTLS_LIB_DIR)/asn1write.o \
>       $(MBEDTLS_LIB_DIR)/oid.o
>  mbedtls_lib_x509-$(CONFIG_$(PHASE_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += \
> -     $(MBEDTLS_LIB_DIR)/bignum.o \
> -     $(MBEDTLS_LIB_DIR)/bignum_core.o \

These rules use CONFIG_$(PHASE_) but BIGNUM_MBEDTLS and ECC_MBEDTLS
have no SPL_ variants in Kconfig. In an SPL build
CONFIG_$(PHASE_)BIGNUM_MBEDTLS expands to CONFIG_SPL_BIGNUM_MBEDTLS,
which does not exist, so bignum.o is no longer built for SPL even when
SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS is enabled - previously it came in
via the RSA-parser rule, which does have an SPL symbol. The same
applies to ecp.o and friends with SPL_MBEDTLS_LIB_TLS, which used to
get them unconditionally from mbedtls_lib_tls-y. No in-tree defconfig
enables these SPL options today, so it is latent, but please can you
either add hidden SPL_ variants selected from the SPL options, or use
CONFIG_$(XPL_) consistently with the proper-only symbols?

> diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
> @@ -122,7 +144,9 @@
>  /* ECDSA */
>  #if CONFIG_IS_ENABLED(ASN1_DECODER)
> +#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
>  #define MBEDTLS_ECDSA_C
> +#endif /* #if CONFIG_IS_ENABLED(ECDSA_MBEDTLS) */
>  #define MBEDTLS_ECP_C
>  #define MBEDTLS_ECDH_C
>  #endif

This define is redundant: the X509 section above already defines
MBEDTLS_ECDSA_C whenever ECDSA_MBEDTLS is enabled, and MBEDTLS_LIB_TLS
requires the X509 options, so this block can never add anything.
Please can you drop it? While here, maybe move
MBEDTLS_ECDSA_DETERMINISTIC inside the new ECDSA_MBEDTLS guard?

Regards,
Simon
