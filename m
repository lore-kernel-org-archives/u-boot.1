Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BF3E7DF0F
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 19:03:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33EE083E76;
	Mon,  2 Feb 2026 20:03:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ptzt3fIk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7201283E83; Mon,  2 Feb 2026 20:03:16 +0100 (CET)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35CF183E69
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 20:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-56641b5a471so4377824e0c.2
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 11:03:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770058993; cv=none;
 d=google.com; s=arc-20240605;
 b=egQQcIXM683sE+NiQH4JwYg2/2b0S8cBHjeVQoc8cvpyM5ucDAWfbzJAeVx0CNQprb
 zTI25krCkB75+NOsWJ646OYA7q3UnxzPqGk/+HcbAWonocpGSir/W6pb/20jvhcw94Af
 RFerNP6Skmx6kyLqZVlEtjKD0In6s4pDbBRFtTXry3j4DGJzWv/kdisoexCUp2MLsLZC
 b5jOoaK5K4KyRHLVIQsx7DWM2gy5aFRXgi6Q6Ni/she9nTq0DnD/IP/N6Si0Dmu7T2FX
 VZI+iSFir8hYTXXRrJi2d9gBUShAYS/vDArRjT1j/hvcx1VtHMmVwQB2ra111uyEP/dU
 dPxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kqSAjLyiY7v9pZ2k9phL3y0Jp0Q6l5EZ1xVcGlkdY60=;
 fh=v5r7wtvmu5ksc4UlsEeLTQ6wPVTb7MZwCU5YxQkFxKI=;
 b=Qq0QhVvtMHl8DvNP5eYJqocvJ2szkt31CDn7HhicJ9uahyuLvmYiL3WGe2R6IXFRy7
 wjEs22kBVUGTYa2JUPGGuQJH1hI8LhhmyS4oO4WPiRI5Y8+UTOgTL9UYBSFGlPy1naIt
 OYCXzEYOx00OcbD6QbIbnmWDZHdx0EKTP/biD3rdTYYYniHKE3XDkOjZNOlZEuxg0WAs
 ggQGk5ge3OlF2mLiUtYNLF7t9Hyhl6ROURRB46n6ssT+bOlNxHO9t4CHzFWGENWb1cc9
 HwoW6dZ1oPdEjmF4m11qfLbB8BrgjI1JJnfWiP66mcLmhue2Z3YkfNdOJF2TiJ4URV95
 T33w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770058993; x=1770663793; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kqSAjLyiY7v9pZ2k9phL3y0Jp0Q6l5EZ1xVcGlkdY60=;
 b=Ptzt3fIkKCzb0bakjMzG3zQT59m/9U9YpLQ8iwRpjp+PAhMIoXUvGim3JqayIDKirh
 h8PvQJ0GrgmFFq7eWCqwy2d/NUnq4wgEMpwXzzx5VXjJz0FEGq6zx4MQlKBHH7kbmiaE
 vHo1CSNz282maKOFQVHvmVm9hz658z0GKfPUQkqYSy/hGV+SloqXwv8PDA1API+XzxZp
 A3/uIlwe6fXWxOuRU/R+jleUa8jC8CSwqRE/nVzl8EPUj1tzVhB1h0+Kz/0yGsd9pTF5
 d0hmys4UgYA7B7ZYwjRLrFhY5XLYJHvRHQBO4zbKmmiijJjika58gwp/bXI/rhoCtVbN
 hBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770058993; x=1770663793;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kqSAjLyiY7v9pZ2k9phL3y0Jp0Q6l5EZ1xVcGlkdY60=;
 b=eokUQDpol6sPaUFPFXPDtuxisM033GASJVuRn2C1eG5CCB+BMee7BWK/VW19If4DA9
 bXydO5X4xSkAhY7eJLgvrBMzlE409C5uklHqzA1Jf+oScm44sS2z1SBkGUmCt74WuzcM
 N4o+9VgLIkJVqe7Fp8atUgfKBRnqFwyoC7M1Gn4Sp0W+8SNdI2FoAcfu1eo4J4FBzS/P
 XB1b4hKyM402YzybIgY7btcG4+0Oo7S3hTDup5KA6MuJl7FzSDiDT3QD8wAs59iEx4Kj
 MjNQcjMviumwEEP5ni6boiYuIcp9lMS9kwng9aegnSXTSvedUbWp2EL9Dp+fsuR/GrGc
 lEsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtxjoobm/eMmG+ssB7G0t7OSmwEFZNg7iEvDF0AXvdMhcPZm3QRu1KxofVGrgENHZGrAmDYD8=@lists.denx.de
X-Gm-Message-State: AOJu0YwtGKu96WXN5di+vbMwXTj3tZBd43Xdsp3B7gGD0IRrOUl9/Ti0
 ItTjGNrTM+Sylq+uS5+ktXcntXuX5Aledgp/2tvQWGPGtTlsHu6U/YthOS9O2DfT2pCRUBNOX7X
 93j4yJRpz7/EQh3g4uofRqn9L5iQTjMcTlBz7oLs=
X-Gm-Gg: AZuq6aKdENcRep2hiIFtVElX7VqlndDCfDeKtVEI9NF0/68SnO+c3C5LR5rPmQgHuwp
 Y+NhIqBw+DJ7dnkXoSuGIshokZ5M18dWigpztwLiwn+icW7bnlx0dU+Ph/VgQvDgRxJHjy4gBdq
 2ZJuCk9et3R2Zbmx8zfQq8ojnPKY7hA0eqCwx2lEJ7ffNjQRiSRKYuyWvfr97YA92tK/jLgSOSI
 6XdpZeL++z+I71sjWYxAhAqVOikFNTK8HS14E8Dg0g7Pi3FFwPpFTVyYZ21bgM+wt7KzFFO
X-Received: by 2002:a05:6122:8603:b0:559:6960:be0d with SMTP id
 71dfb90a1353d-566a00a537emr3860388e0c.13.1770058992925; Mon, 02 Feb 2026
 11:03:12 -0800 (PST)
MIME-Version: 1.0
References: <20260202170307.217200-1-philippe.reynes@softathome.com>
 <20260202170307.217200-2-philippe.reynes@softathome.com>
In-Reply-To: <20260202170307.217200-2-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 2 Feb 2026 14:03:02 -0500
X-Gm-Features: AZwV_Qi2KqcBZi_KyTckBuUUcO4yIk75-yKNBaWEkxCiO6KeGaANOCpKG6nMkto
Message-ID: <CAMDkj5xOf8ULygSzOaz04FFay3HvJqnHT5rmo6cjr5XmusrPgQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] mbedtls: enable support of ecc
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Feb 2, 2026 at 12:05=E2=80=AFPM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Enables the support of ecc in mbedtls.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  lib/mbedtls/Kconfig              |  8 ++++++++
>  lib/mbedtls/Makefile             |  7 +++++++
>  lib/mbedtls/mbedtls_def_config.h | 18 ++++++++++++++++++
>  3 files changed, 33 insertions(+)
>
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index 789721ee6cd..90c007df850 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -157,6 +157,7 @@ config MBEDTLS_LIB_CRYPTO
>         select SHA256_MBEDTLS if SHA256
>         select SHA512_MBEDTLS if SHA512
>         select SHA384_MBEDTLS if SHA384
> +       select ECDSA_MBEDTLS if ECDSA
>         help
>           Enable MbedTLS native crypto libraries.
>           Mutually incompatible with MBEDTLS_LIB_HASHING_ALT.
> @@ -231,6 +232,13 @@ config HKDF_MBEDTLS
>           This option enables support of key derivation using HKDF algori=
thm
>           with MbedTLS crypto library.
>
> +config ECDSA_MBEDTLS
> +       bool "Enable ECDSA support with MbedTLS crypto library"
> +       depends on MBEDTLS_LIB_CRYPTO && ECDSA
> +       help
> +         This option enables support of ECDSA with the MbedTLS crypto
> +         library.
> +

ECDSA config should be under MBEDTLS_LIB_X509 instead og MBEDTLS_LIB_CRYPTO=
.

>  endif # MBEDTLS_LIB_CRYPTO
>
>  config MBEDTLS_LIB_X509
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index c5b445bd85c..54a893609cf 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -35,6 +35,11 @@ mbedtls_lib_crypto-$(CONFIG_$(PHASE_)SHA512_MBEDTLS) +=
=3D \
>         $(MBEDTLS_LIB_DIR)/sha512.o
>  mbedtls_lib_crypto-$(CONFIG_$(PHASE_)HKDF_MBEDTLS) +=3D \
>         $(MBEDTLS_LIB_DIR)/hkdf.o
> +mbedtls_lib_crypto-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS) +=3D \
> +       $(MBEDTLS_LIB_DIR)/ecdsa.o \
> +       $(MBEDTLS_LIB_DIR)/ecp.o \
> +       $(MBEDTLS_LIB_DIR)/ecp_curves.o \
> +       $(MBEDTLS_LIB_DIR)/ecp_curves_new.o

Currently these ecp*.o are imported by MBEDTLS_LIB_TLS, refactoring is
required to avoid duplications when multiple kconfigs are selected.

>
>  # MbedTLS X509 library
>  obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_X509) +=3D mbedtls_lib_x509.o
> @@ -52,6 +57,8 @@ mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KE=
Y_MBEDTLS) +=3D \
>         $(MBEDTLS_LIB_DIR)/pk.o \
>         $(MBEDTLS_LIB_DIR)/pk_wrap.o \
>         $(MBEDTLS_LIB_DIR)/pkparse.o
> +mbedtls_lib_x509-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS) +=3D \
> +       $(MBEDTLS_LIB_DIR)/pk_ecc.o

ditto.

>  mbedtls_lib_x509-$(CONFIG_$(PHASE_)X509_CERTIFICATE_PARSER_MBEDTLS) +=3D=
 \
>         $(MBEDTLS_LIB_DIR)/x509_crl.o \
>         $(MBEDTLS_LIB_DIR)/x509_crt.o
> diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_c=
onfig.h
> index dda3f4dd6e4..8f366c744a5 100644
> --- a/lib/mbedtls/mbedtls_def_config.h
> +++ b/lib/mbedtls/mbedtls_def_config.h
> @@ -60,6 +60,24 @@
>  #define MBEDTLS_HKDF_C
>  #endif
>
> +#if CONFIG_IS_ENABLED(ECDSA)
> +#define MBEDTLS_ECDSA_C
> +#define MBEDTLS_ECP_C
> +#define MBEDTLS_BIGNUM_C
> +#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
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
> +

Currently they are enabled by MBEDTLS_LIB_TLS, refactoring is required
to select ECDSA when MBEDTLS_LIB_TLS is on, to avoid duplicated
defining macros here.

Regards,
Raymond

>  #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
>
>  #if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
> --
> 2.43.0
>
