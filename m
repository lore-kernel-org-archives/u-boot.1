Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF43EA71B3
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04C7E83693;
	Mon, 20 Apr 2026 04:11:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gDLsMMoq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 129B283B99; Mon, 20 Apr 2026 04:11:35 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F9C882BF2
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82f8bf96b46so1131423b3a.2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:11:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776651091; cv=none;
 d=google.com; s=arc-20240605;
 b=HG2t0yCAtC83Im6JZ+fPfSbvbdi88gPe5GDm06OyzzpvIPWnrFKxm1Di6HQrRMkzT/
 iij/6L8T3vvmwNbSr2QzD2JhOTKTdD1pUJFCOm8jnz+H9Vf87zySbY71DM8yLA4oluW0
 3nxQU7+zVswL6h2QkS694/m0A8qgiictTgWJWvTFg5LHVF5d+H7ImDgj3BB0CDF4CSoE
 IawIELhNZaq8XBWACOPuIXnOqVIsVbiI0xA1usY6e5HtZ5D/pUVBKBiHcZE8cYXGWhD2
 F/Eukt54C0D4rkMFsnjzQ8UuqaYQMpe9h5vbfDQjn99hIwmD1TxH8aBw32emhDsC0sec
 JQ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0wYPS9DFm5o9ZCyvnzradFvzRbMQjgs4krov1Avtzu8=;
 fh=4tL75V6OhW3dS5bSDjPos9FuEPvGKHR3LgUMm10iD2A=;
 b=VedFWxVG8eRDIQsy4jB9J4As4Q/uV+uGVq9OuMLHbjBUxkYN7tkuL3SzD9jXanbFpC
 Mj/EMzeUx/FxzLRgwgPI2LflEive9PS180Mtq0WG88fDGxHUoP3VcdjOYvS1bECKL8so
 ++yB0UkV3Hh+7ihZ4a6+kVww7Lo1MfZ0S5cRWvKcvqofFF6f4ujMOu3CzqjdYL4rkv9k
 r7B1bv1NW6hfgTCcRiyi2FCAlhLxQfMbSYAkDhtjUkOyLv4nAc85OywlluD/KcH7/Gq6
 aUgmK5KlJ46ysZaDeByvYzwp13cMxBcOEwI5pRUSSLqLnVHMWlwPLwjXjb8dXNoDXqAw
 2x5g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776651091; x=1777255891; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0wYPS9DFm5o9ZCyvnzradFvzRbMQjgs4krov1Avtzu8=;
 b=gDLsMMoqOMnByNayrLqcLF+Ia9ri8ieexQAJdnpn7IaMZiACGgBC2SlnVtBLjZ0kLM
 ODn4oEB81OLGbf71ISOOpLjmJ/D48kBQUOauqTEhUvXxr2zkW8O0Q2IrbCSmXav1ExC2
 tng+iBQdLBTXhMK72upWhADIQFyxMibb0KTvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776651091; x=1777255891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0wYPS9DFm5o9ZCyvnzradFvzRbMQjgs4krov1Avtzu8=;
 b=GKrKF+6u1t6VBCPerKjCmMMt4xjmDiJxHuuwUROaLLUqDZQteSnCJP7zXmwSSJkFiy
 axjvgUuxdQjGQyELBIMSHV8Qc6kX3+5mBoarX57uNcQphV/CtzozGwqUODrhRTGN+sVm
 bD1FAxRzRb12uAkr0ShuGPGWrjvewPVrAotdNF8kD4A0qSWIbSYIojxFhBhuCsYVfk8R
 G9pJ30W9X6e99J3vnVew+KJQ3zm3IjGKb1W9Z2IAlNSmAhl1q8B2iSFsBQSWoejP/hOy
 C+Qw4XRG6u2H71RFhEITubXdctVL3Gy384avnqnaDx3ZMwgEqQNkyEvw601ZScIT1FC2
 ITAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3Z7m1Z9kiMj2Kaj8OlSGSwgOvhQ3OlVqk6IU+1H8Eib9W4EeOjw5GfdpqTPN0iqt8p6d1HZk=@lists.denx.de
X-Gm-Message-State: AOJu0YyRkCvd/IMGZfY8N4SLbaR5zTHKPfrkgN0v+17FSGCUHJ0r0San
 HWfBAVyytp1xrWm8GyoZEBGTAdNuT8pqRcml+hXNryNNBeUCf4AlQReL6Swtd4+hd+EOzVV1G+/
 PhWCrYh1/UoouFxgrOGjoKOPxC4K7CrduVpqerC3F
X-Gm-Gg: AeBDieuKaq9oNMfxg1GxcQTkLAtHJ+jY2OVy5ftLjS51mtGSfTFz5g+BqK4vwrTevfJ
 sEM3aoSYYYf8O1sV0M1NBIXLqkz9ZFmnD0a1jcQSOLyOr4VPg1S+PsXp3rEdR62QpFOGTPdfQXD
 W0Cd6e3USqiAQjbn53bgj9wp0CaRQsF4G4nGhE8UJBX6ZGqozR9we5IvyZ2Mpjc6S11ppV+gZM4
 QYGHYJ6rrC7jlYzznDoxr0p5DZ+wM0bQ5t0LXqlvRPBmMic0KSAk4NrAeHpNvwaZDnID/3yjYsj
 e/+ymEyUbhXiJN91pZew
X-Received: by 2002:a05:6a00:3492:b0:82f:1d38:f68d with SMTP id
 d2e1a72fcca58-82f8c8df5e1mr12859299b3a.34.1776651090814; Sun, 19 Apr 2026
 19:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
 <20260417130204.49896-2-philippe.reynes@softathome.com>
In-Reply-To: <20260417130204.49896-2-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:11:11 +1200
X-Gm-Features: AQROBzCPnCGoC_sH3AQDoUaiLSknkToL0QZRLjp6lMEQ6bVmqO3Qv7wR6uPDO8A
Message-ID: <CAFLszTgA+EohaEeyvfrQ_WxwabqkompK1S2MV9LvDYhhes9n4Q@mail.gmail.com>
Subject: Re: [PATCH v4 01/14] mbedtls: enable support of ecc
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

On 2026-04-17T13:02:04, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> mbedtls: enable support of ecc
>
> Enables the support of ecc in mbedtls.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> configs/sandbox_defconfig        |  1 +
>  lib/ecdsa/Kconfig                |  1 +
>  lib/mbedtls/Kconfig              | 14 ++++++++++++++
>  lib/mbedtls/Makefile             | 17 +++++++++--------
>  lib/mbedtls/mbedtls_def_config.h | 17 +++++++++++++++++
>  5 files changed, 42 insertions(+), 8 deletions(-)

> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> @@ -38,14 +38,20 @@ mbedtls_lib_crypto-$(CONFIG_$(PHASE_)HKDF_MBEDTLS) += \
> +mbedtls_lib_x509-y := $(MBEDTLS_LIB_DIR)/x509.o \
> +     $(MBEDTLS_LIB_DIR)/ecdsa.o \
> +     $(MBEDTLS_LIB_DIR)/ecp.o \
> +     $(MBEDTLS_LIB_DIR)/ecp_curves.o \
> +     $(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
> +     $(MBEDTLS_LIB_DIR)/pk_ecc.o

The ECC objects are unconditionally included in mbedtls_lib_x509-y,
increasing binary size for configurations needing X509 without ECDSA.
Please can you make these conditional on CONFIG_ECDSA_MBEDTLS,
following the RSA_PUBLIC_KEY_PARSER_MBEDTLS pattern?

> diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
> @@ -89,6 +89,23 @@
> +#if CONFIG_IS_ENABLED(ECDSA)
> +#define MBEDTLS_ECDSA_C
> +#define MBEDTLS_ECP_C
> +#define MBEDTLS_BIGNUM_C
> +#define MBEDTLS_ECP_DP_SECP192R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP224R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP256R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP384R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP521R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP192K1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP224K1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
> +#define MBEDTLS_ECP_DP_BP256R1_ENABLED
> +#define MBEDTLS_ECP_DP_BP384R1_ENABLED
> +#define MBEDTLS_ECP_DP_BP512R1_ENABLED
> +#endif

I suspect this should use CONFIG_IS_ENABLED(ECDSA_MBEDTLS) rather than
CONFIG_IS_ENABLED(ECDSA), for consistency with other mbedtls-specific
features in this file. Currently, enabling ECDSA with the legacy
crypto library would set these defines but not link the corresponding
code.

> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> @@ -247,6 +247,10 @@ config MBEDTLS_LIB_X509
> +config BIGNUM_MBEDTLS
> +     bool
> +     default n

You don't need 'default n' as 'n' is the default.

Regards,
Simon
