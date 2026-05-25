Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95B7CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4981384859;
	Mon, 25 May 2026 17:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jjv//Xb7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CE10848EE; Mon, 25 May 2026 17:29:25 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C609846E1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-6312af106e3so7725460137.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:29:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779722962; cv=none;
 d=google.com; s=arc-20240605;
 b=EZtlX9VXdnCO0NAjxBD0LlYnEZE5KjMgLpLAzI1biMBtZAaBKtSW5pXpZZci69wT5H
 WZSWu/DV/B8CyHf9KbNNIjXpc9Wzn6sOtGRfx2mGgmc4M5rddRfu/QCz2/VVNU/BqVl3
 XxDjU/ZLoNWmJzOAnQacfIOE/Sjy+qwKvT/OQkhkQiGG69vMUlsjdrXncyZbFiRhqdmO
 8/x4/EAjGp4FYOMZl8a1Tt2q+iT/Qf8OXyEXNRHmdBoir88830PxWHBb3/rQ7apQlhrh
 LO0C1R+f8FxWBoQm6xUYdLKeBTSKjxsay/QKNN3gBfHdY0MArb53qT4DcuhEtfxoWc6v
 egOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Bwdv2+i0IYVqXuBgvuqEfUOhlxghA/GgVNCV5tvYOsY=;
 fh=0Daj12c5HDmW+2P9/5TC5lhZ0W6K8zyrH3npRbGcqVc=;
 b=ad3aximtzvI90sc7cyN1nW0nRd3BAX+Jnv/0eHnICp2n0Hcgcjap5aGMrfLQUFRuJo
 p1lxfl3CusVoxc24WOrXSf9jsTkXQbe1oibEiQorFEaV2Mb2oq5kVovN7cHx0TXogQr0
 qEikg1mEs7ZPjqKDR29KaAwUuIzOShek9pMRyV3vLkxOykwrno36uagW8k7NLewFy3Nk
 PMYUyNsto4WNg2LzezQ7YX56ZGr2oYOWpG3WFL9ArHJD4TJFRZDLpDj8TJxAAZVRLqjs
 mb8HQDOfgj2H0f1aRADkca5bPKEy3/cmPCfpdZfFaVXlXm3BvW4EKRlGj5PKBs4HlLjj
 lthQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779722962; x=1780327762; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bwdv2+i0IYVqXuBgvuqEfUOhlxghA/GgVNCV5tvYOsY=;
 b=Jjv//Xb7ZDMVF8SP6sR0YVrZbWr6pe+ky+PBliiTwLfkTKLieZpa6Jcyjh1NFgz+Xm
 S3Di9JhW5vkpD5JlfUjLh8DrETIhyOJfYEUmaYxLblOreTedsfydy4x38/bboSR7A0+Y
 wTN2OJLugalYpOkdll6soH82UKM5QQDnmou5AugOZAuOY4qxK4y1/82WZO4ZXsXh5V0C
 KpTQlttcCYh32RoDVViUPRfp73msW3hL2o5OmQsi1+IEkOQRpvN7k99GvHjw9pHXbCUI
 nDqMXRm2alO7RFOFJDyM5B9or6ACb8B+beLtqMdrci7fJ+M9Gw+T5Fgf643aoc/UNah4
 d1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722962; x=1780327762;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bwdv2+i0IYVqXuBgvuqEfUOhlxghA/GgVNCV5tvYOsY=;
 b=NMIZe/OLMg0yEs3dTa8N+z6SiBsuuq+6k4MEXboL5x18t0WSrWHjdxVAJf/Bq+n6mI
 0MMnyAlMPBa10ALByb6SwDRxZ8Z/mYfKg0OqgtbBFz4yspSvRy7FmSEiihl9qcoPg5tY
 B8o2vVYZme0znQlhdOZSRfT/6/0qi3Vu7AErkRpXdMxSJg0Ha7Kx19K2g6O8+jnNYedU
 AZKuxasVq3Ii/8vhcWWC0rL7z9+UrAuGGBUOKgvsOrn1Pj+FXNaYwA73vT8HApf0X0V5
 C1AoI8ThPe+h5pUVE5eTIZKDXCmUZz/zCC5GsuaWRpeGLWxwxYM84DB8KgI+v/bEvImJ
 letg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+chIjXmulTOLR274w0BeLoxuVgXswjCSBWijb7Gtljm5nHKZCwLuc41LnTZGx7H97fBQ/xhfg=@lists.denx.de
X-Gm-Message-State: AOJu0Yzc5o54EBrPc1whx2uOQgq5Ri+xvsDRkHFJEAOoHgyQjYvzJ2zD
 6vpe0eEvdRecJOa16RydP72PvjE5FNN+t9vpHWHKXJ2jhpvZHzO+NBkTms4+ZSqsXfnmONuWuYT
 khq9vR7KgvgEpYnpf+Kx6K3O0ZXPg3vc=
X-Gm-Gg: Acq92OFAuZVJURZMq8Nj8rMjlAD2ReBOVr6mdP0/ClkNBhISlJKe08Z3Win0q5nxRd+
 JcG7AcLHpVI3/oUicJrerwp66ZV5Haj+pHr45VRxKx6H7oflcZn2zI3qK720oELMElAKDeB2/dh
 LDNJ4t1CHTvMwHWZCZt5x3tAr9UBal2ihcrbgFu78XWH1w6MPy/09BbdE6JXVJBmibs4xYLtXnk
 eqmafClC7/BAbZ3I1O1bdNJQwQgIzw7hzR7QlS2SBrIQsqXL8kZHNG6OCJJSZCPIJxKBoLuj9Hs
 +avcfNy6
X-Received: by 2002:a05:6102:3ed2:b0:631:4580:6a46 with SMTP id
 ada2fe7eead31-67c7d975b3fmr7397510137.17.1779722961986; Mon, 25 May 2026
 08:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
 <20260525135241.88348-3-philippe.reynes@softathome.com>
In-Reply-To: <20260525135241.88348-3-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 25 May 2026 11:29:10 -0400
X-Gm-Features: AVHnY4JET2ri7lRJ1khg-HLW7W8YcKeWGxE7p6NwIIi2WAGW7nsRp5tN8z6FTQI
Message-ID: <CAMDkj5x-aFFkCm1rVNAPKD=goLmMwQ7KNZ5ieBZK8eZO9wAxUg@mail.gmail.com>
Subject: Re: [PATCH v6 02/15] mbedtls: enable support of ecc
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.denx.de
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

On Mon, May 25, 2026 at 9:52=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Enables the support of ecc in mbedtls.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - move ecdsa to MBEDTLS_LIB_X509
> - enhance depencendies
> v3:
> - do not use _MBEDTLS in mbedtls_def_config.h
> v4:
> - do not select ECDSA on some configs
> - remove duplicated MBEDTLS_ECP_DP_SECP256K1_ENABLED
> - change dependencies for ECDSA configs
> v5:
> - MBEDTLS_LIB_TLS depends en ECDSA_MBEDTLS
> - update some configs according to previous change
> - build of ecdsa is conditionned by ECDSA_MBEDTLS
> v6:
> - fix dependencies for ecdsa and ecc on mbedtls
> - ecdsa is no longer mandatory for tls
>
>  configs/sandbox_defconfig        |  1 +
>  lib/ecdsa/Kconfig                |  1 +
>  lib/mbedtls/Kconfig              | 17 +++++++++++++
>  lib/mbedtls/Makefile             | 17 +++++++------
>  lib/mbedtls/mbedtls_def_config.h | 41 +++++++++++++++++++++-----------
>  5 files changed, 56 insertions(+), 21 deletions(-)
>

Looks good to me. Thanks!
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>


> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index ba800f7d19d..03c35429bc6 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -381,6 +381,7 @@ CONFIG_PANIC_HANG=3Dy
>  CONFIG_CMD_DHRYSTONE=3Dy
>  CONFIG_MBEDTLS_LIB=3Dy
>  CONFIG_HKDF_MBEDTLS=3Dy
> +CONFIG_ECDSA_MBEDTLS=3Dy
>  CONFIG_ECDSA=3Dy
>  CONFIG_ECDSA_VERIFY=3Dy
>  CONFIG_RSASSA_PSS=3Dy
> diff --git a/lib/ecdsa/Kconfig b/lib/ecdsa/Kconfig
> index ca13b6bfa1f..dac8bcf23dd 100644
> --- a/lib/ecdsa/Kconfig
> +++ b/lib/ecdsa/Kconfig
> @@ -1,6 +1,7 @@
>  config ECDSA
>         bool "Enable ECDSA support"
>         depends on DM
> +       select ASN1_DECODER
>         help
>           This enables the ECDSA (elliptic curve signature) algorithm for=
 FIT
>           image verification in U-Boot. The ECDSA algorithm is implemente=
d
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index 789721ee6cd..e019f17d6bd 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -247,6 +247,12 @@ config MBEDTLS_LIB_X509
>
>  if MBEDTLS_LIB_X509
>
> +config BIGNUM_MBEDTLS
> +       bool
> +
> +config ECC_MBEDTLS
> +       bool
> +
>  config ASN1_DECODER_MBEDTLS
>         bool "ASN1 decoder with MbedTLS certificate library"
>         depends on MBEDTLS_LIB_X509 && ASN1_DECODER
> @@ -264,6 +270,7 @@ config RSA_PUBLIC_KEY_PARSER_MBEDTLS
>         bool "RSA public key parser with MbedTLS certificate library"
>         depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
>         select ASN1_DECODER_MBEDTLS
> +       select BIGNUM_MBEDTLS
>         help
>           This option chooses MbedTLS certificate library for RSA public =
key
>           parser.
> @@ -292,6 +299,15 @@ config MSCODE_PARSER_MBEDTLS
>           This option chooses MbedTLS certificate library for MS authenti=
code
>           parser.
>
> +config ECDSA_MBEDTLS
> +       bool "Enable ECDSA support with MbedTLS certificate library"
> +       depends on MBEDTLS_LIB_X509 && ASN1_DECODER_MBEDTLS
> +       select BIGNUM_MBEDTLS
> +       select ECC_MBEDTLS
> +       help
> +         This option enables support of ECDSA with the MbedTLS certifica=
te
> +         library.
> +
>  endif # MBEDTLS_LIB_X509
>
>  config MBEDTLS_LIB_TLS
> @@ -301,6 +317,7 @@ config MBEDTLS_LIB_TLS
>         depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
>         depends on ASN1_DECODER_MBEDTLS
>         depends on MBEDTLS_LIB
> +       select ECC_MBEDTLS
>         help
>           Enable MbedTLS TLS library. Required for HTTPs support
>           in wget
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index c5b445bd85c..0c86c90d15a 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -39,13 +39,21 @@ mbedtls_lib_crypto-$(CONFIG_$(PHASE_)HKDF_MBEDTLS) +=
=3D \
>  # MbedTLS X509 library
>  obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_X509) +=3D mbedtls_lib_x509.o
>  mbedtls_lib_x509-y :=3D $(MBEDTLS_LIB_DIR)/x509.o
> +mbedtls_lib_x509-$(CONFIG_$(PHASE_)ECC_MBEDTLS) +=3D \
> +       $(MBEDTLS_LIB_DIR)/ecp.o \
> +       $(MBEDTLS_LIB_DIR)/ecp_curves.o \
> +       $(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
> +       $(MBEDTLS_LIB_DIR)/pk_ecc.o
> +mbedtls_lib_x509-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS) +=3D \
> +       $(MBEDTLS_LIB_DIR)/ecdsa.o
> +mbedtls_lib_x509-$(CONFIG_$(PHASE_)BIGNUM_MBEDTLS) +=3D \
> +       $(MBEDTLS_LIB_DIR)/bignum.o \
> +       $(MBEDTLS_LIB_DIR)/bignum_core.o
>  mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASN1_DECODER_MBEDTLS) +=3D \
>         $(MBEDTLS_LIB_DIR)/asn1parse.o \
>         $(MBEDTLS_LIB_DIR)/asn1write.o \
>         $(MBEDTLS_LIB_DIR)/oid.o
>  mbedtls_lib_x509-$(CONFIG_$(PHASE_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) +=3D \
> -       $(MBEDTLS_LIB_DIR)/bignum.o \
> -       $(MBEDTLS_LIB_DIR)/bignum_core.o \
>         $(MBEDTLS_LIB_DIR)/rsa.o \
>         $(MBEDTLS_LIB_DIR)/rsa_alt_helpers.o
>  mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) +=3D \
> @@ -64,7 +72,6 @@ mbedtls_lib_tls-y :=3D \
>         $(MBEDTLS_LIB_DIR)/mps_reader.o \
>         $(MBEDTLS_LIB_DIR)/mps_trace.o \
>         $(MBEDTLS_LIB_DIR)/net_sockets.o \
> -       $(MBEDTLS_LIB_DIR)/pk_ecc.o \
>         $(MBEDTLS_LIB_DIR)/ssl_cache.o \
>         $(MBEDTLS_LIB_DIR)/ssl_ciphersuites.o \
>         $(MBEDTLS_LIB_DIR)/ssl_client.o \
> @@ -82,8 +89,4 @@ mbedtls_lib_tls-y :=3D \
>         $(MBEDTLS_LIB_DIR)/cipher.o \
>         $(MBEDTLS_LIB_DIR)/cipher_wrap.o \
>         $(MBEDTLS_LIB_DIR)/ecdh.o \
> -       $(MBEDTLS_LIB_DIR)/ecdsa.o \
> -       $(MBEDTLS_LIB_DIR)/ecp.o \
> -       $(MBEDTLS_LIB_DIR)/ecp_curves.o \
> -       $(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
>         $(MBEDTLS_LIB_DIR)/gcm.o \
> diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_c=
onfig.h
> index dda3f4dd6e4..92e68e5d726 100644
> --- a/lib/mbedtls/mbedtls_def_config.h
> +++ b/lib/mbedtls/mbedtls_def_config.h
> @@ -62,6 +62,25 @@
>
>  #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
>
> +#if CONFIG_IS_ENABLED(BIGNUM_MBEDTLS)
> +#define MBEDTLS_BIGNUM_C
> +#endif
> +
> +#if CONFIG_IS_ENABLED(ECC_MBEDTLS)
> +#define MBEDTLS_ECP_C
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
>  #if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
>  #define MBEDTLS_X509_USE_C
>  #define MBEDTLS_X509_CRT_PARSE_C
> @@ -74,7 +93,6 @@
>  #endif
>
>  #if CONFIG_IS_ENABLED(RSA_PUBLIC_KEY_PARSER)
> -#define MBEDTLS_BIGNUM_C
>  #define MBEDTLS_RSA_C
>  #define MBEDTLS_PKCS1_V15
>  #endif
> @@ -89,6 +107,10 @@
>  #define MBEDTLS_ASN1_WRITE_C
>  #endif
>
> +#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
> +#define MBEDTLS_ECDSA_C
> +#endif
> +
>  #endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
>
>  #if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS)
> @@ -122,7 +144,9 @@
>
>  /* ECDSA */
>  #if CONFIG_IS_ENABLED(ASN1_DECODER)
> +#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
>  #define MBEDTLS_ECDSA_C
> +#endif // #if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
>  #define MBEDTLS_ECP_C
>  #define MBEDTLS_ECDH_C
>  #endif
> @@ -130,24 +154,13 @@
>  #define MBEDTLS_HMAC_DRBG_C
>
>  #define MBEDTLS_CAN_ECDH
> +#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
>  #define MBEDTLS_PK_CAN_ECDSA_SIGN
>  #if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
>  #define MBEDTLS_KEY_EXCHANGE_ECDH_ECDSA_ENABLED
>  #define MBEDTLS_KEY_EXCHANGE_ECDHE_ECDSA_ENABLED
>  #endif
> -
> -#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
> -#define MBEDTLS_ECP_DP_SECP192R1_ENABLED
> -#define MBEDTLS_ECP_DP_SECP224R1_ENABLED
> -#define MBEDTLS_ECP_DP_SECP256R1_ENABLED
> -#define MBEDTLS_ECP_DP_SECP384R1_ENABLED
> -#define MBEDTLS_ECP_DP_SECP521R1_ENABLED
> -#define MBEDTLS_ECP_DP_SECP192K1_ENABLED
> -#define MBEDTLS_ECP_DP_SECP224K1_ENABLED
> -#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
> -#define MBEDTLS_ECP_DP_BP256R1_ENABLED
> -#define MBEDTLS_ECP_DP_BP384R1_ENABLED
> -#define MBEDTLS_ECP_DP_BP512R1_ENABLED
> +#endif // #if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
>
>  #endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS) */
>
> --
> 2.43.0
>
