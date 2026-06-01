Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC679CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 18:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D5A3848A2;
	Mon,  1 Jun 2026 20:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O9ySPFih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EC3F848B0; Mon,  1 Jun 2026 20:22:48 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 581C8848A1
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 20:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-6c36543e834so834498137.1
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 11:22:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780338165; cv=none;
 d=google.com; s=arc-20240605;
 b=aF8ygiFzlmffdFQCqLdWaxr8KKWPrTia94q65UvBigwL/IUP2hZQTxlj7+slsQVCbZ
 J7URpSQk8NqPV7/jJXNgBZNQPGEnMrjn1s+l/l+bF6GBL9KO42miwP/HyyK3HqoE7Zk6
 ftjO00ocv71aKC4I7sLKC8Wnk45z7HpzeW4J2wdR7Rsb7jlK6LQl1L/xNpOnRxMllEvX
 xI20FQroJnkZt5eQaup7jsTBwePtuW5lB786rR6qkgnoIvNb5zdX316fw2bAEI8j4cnJ
 YmAtxi1GaCbZ7GJlGcCY3MsKz+KB9/+ZxkLz2unjM0mzpORZ1BaxDgCxavRVARD+2UVo
 BqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=knQcjEUIwrqNBx6C1oUYh/lp9ryyt3xcLyF30QUCPU8=;
 fh=MN/7c3uzLY1KocmXgUZF8yxp4FAHv4qwacrZr2T15CI=;
 b=VE2NArmKUd7jRmb7gohnRQSCqv2UnpbBvjrx24L8D0eocLtv09v3rCIEwGnsGFcEhm
 c6/9exsaRoLCQAQmmp825H9s/ZKp0KqPtf9xiZVsRd98JlkXBzBaoLd812gFAUsvw01j
 dHYWwmlDdK/PAt9zTS3x5tWVxV7qSHjRoSqmLfYt2n2Yof/ee9mIX8FKt3Czt/mBv2P1
 7q4Au9+XW4iZPiq5LDrJ3rDpsLlPmIfJZz3JB772mjISkWYhmi8PkJx9s2yg0p+anijJ
 CQarJVKOFC38puVmVgL3NpsI4GZQuROTU7/rmvNNb1JIQ9ulkX0pubiH2YkuWQ2aBTgk
 l1/Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780338165; x=1780942965; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=knQcjEUIwrqNBx6C1oUYh/lp9ryyt3xcLyF30QUCPU8=;
 b=O9ySPFihYYosplcALimzGnyYkDmXuEvOjVpLYD0qGFHYXVleYiaqptXxakFnmz8P2G
 pWn49UA9MEV8AqRWv2GQqBmqHHp88D8wPJHGbcAgoz/cEpWFOZnNb02tKFxWC6RAnoYU
 O4Nw+QIcdxSp0Wt8s7GdYhXA27UkH4tVaV8ltTZimyovzXtc1TEtNkgIAvz8TXy0eh5V
 V/+rsOYXdFLLpB6OnRWZdWaGhcYnOW28KN6RLuNgiyceEt6qv8dWWIrhHXo+MpB4gLKF
 zP3sGRO/W061NYIFbaIW6oxklERgFSnJkLlQeQGC2ZP+Tl+21uwyFtESWtenOylQtf1i
 fgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780338165; x=1780942965;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=knQcjEUIwrqNBx6C1oUYh/lp9ryyt3xcLyF30QUCPU8=;
 b=IJEot619sD47O20xaf2vj7RUN2raEIyYhxIQfzST1+NW7e/r71ilNxF6W86+TM3Ha2
 lNFCuhY5yYZSeNoJner13S2IAB3Xf5uHsuRq3QNkuHKICUKrkZSyArf/E6JXntSv2JlE
 /1WoztgBTFxxsXNEiFFvvPCPxQ2taPGcsM/QLuYAJrLi6ZIco13JR/hnzqA7/ePjNtby
 fJlj6pZXlH6QRZJCpLC0M2loULwQ9/tg1pKJ59WxGT33JRsIN7R0supamoEfAZ6brBca
 HOIISDWzDqzO8PtA0T1qTTx2GfOTDdK/p9v7jgYfHzaq3GqLWhzGtVMTjPk84J+widlV
 v+sQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ua0sg/PYVtQpH8Cx/nFVqD0y2OjIDEriz1m2LJ7vKwFPtfs6Inf8BLzYI4iFN+yxQoPhI30s=@lists.denx.de
X-Gm-Message-State: AOJu0YzjnfvLwIjRMObWPH0q1xCn8CO2fhBSAjsH6OV25XWWBNd96YAt
 VfzHOA5BgQx4w5It99BhunumDqHscc+0s0qIa/eF1Xp2G+Fnf3xNuC4b8HdRshimYEQcJFEY2xW
 YlXXSugPXQd1Za9S7FWCqNn5ETFGMLTg=
X-Gm-Gg: Acq92OGDhFSoJ4o//Z9RyieNx5VZ32erfN1WL78tAmNdoSOPzkuABJ+JZpaepniFk8E
 geOiw1AWH1K+mcMWtWT14ZGDu3S5smAhEz/auuQGTJA8zas2/CRaT8ldojnDnW9Bi9BQ4COFAe2
 DFFWhTwQSX6O12IPi0PfUqSY6NAf7Ch+kG/8qe5jar/nGdqqVGcRnaoA7xgk8zUMyi5kHV8PI2R
 8QeeTygEqnl46Sf1pqSt16kliusvwADwtDx1smGfiM98lZ468cgQEgk3MdEhzpKtgzhnxeFhlze
 48/6KrVW0elVKCTW2ytOJI16pxRC
X-Received: by 2002:a05:6102:2aca:b0:650:94b2:3839 with SMTP id
 ada2fe7eead31-6c68cd8b50fmr5125008137.7.1780338165058; Mon, 01 Jun 2026
 11:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
 <20260601134310.2452454-3-philippe.reynes@softathome.com>
In-Reply-To: <20260601134310.2452454-3-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 1 Jun 2026 14:22:34 -0400
X-Gm-Features: AVHnY4KdVNKPHwK3GIjYZmhYOioonJA-lCVitHf497-OvgGNOFNTATFmOl8E520
Message-ID: <CAMDkj5xj3Oq7KGOagUsr5Q+xpk+aEZ0T7uyrDZueWX3JvJj-vg@mail.gmail.com>
Subject: Re: [PATCH v8 02/15] mbedtls: enable support of ecc
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

On Mon, Jun 1, 2026 at 9:43=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
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
> v7:
> - no change
> v8:
> - enhance the commit message
> - use /* */ instead of //
>
>  configs/sandbox_defconfig        |  1 +
>  lib/ecdsa/Kconfig                |  1 +
>  lib/mbedtls/Kconfig              | 17 +++++++++++++
>  lib/mbedtls/Makefile             | 17 +++++++------
>  lib/mbedtls/mbedtls_def_config.h | 41 +++++++++++++++++++++-----------
>  5 files changed, 56 insertions(+), 21 deletions(-)
>

Thanks!
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
> index dda3f4dd6e4..d55f31acfda 100644
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
> +#endif /* #if CONFIG_IS_ENABLED(ECDSA_MBEDTLS) */
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
> +#endif /* #if CONFIG_IS_ENABLED(ECDSA_MBEDTLS) */
>
>  #endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS) */
>
> --
> 2.43.0
>
