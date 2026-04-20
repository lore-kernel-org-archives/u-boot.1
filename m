Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9358F588EE
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 16:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 295A18426E;
	Mon, 20 Apr 2026 18:17:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SIAh0uIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DD378425F; Mon, 20 Apr 2026 18:17:23 +0200 (CEST)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBA2D8426E
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 18:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-649278a69c5so2479956d50.3
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 09:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776701838; cv=none;
 d=google.com; s=arc-20240605;
 b=aiA+C62ukpZTO+CQg2U7Y8XZlk4rDTwjmVadO1MyVMCI6wWDWIEwR8YS9Z6XiUSPNB
 +Q9+rawLFRAqLoDzTHlpoNuz9OKUnrna9cHDEwLXSMrdgoZlBTIvFcNOtXeXJIqUlu7a
 DU4dGtgp/NC3cKPWrTfzE/k/qHpPC7/c2jSz/O64RNIS7l/qvlOEjoDTMlZRHKvg2q8X
 2Vc7EQdahwGBeWKFzeGdUMRDdFH4K4EcHOczYMcaWUKtxxvCTIINnbztIvBQfNjfLkpW
 pFY80SpxB5CF5rLCL3PaABA//sofCHTqDz1hupXtBZoqRGWVokfHSvyIPkcv0BWWSHJc
 psHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6MijSywokdCkNZvM6n8pi8nJqMySWTSMiKK0MD2DLoA=;
 fh=a36618USXTZJgAZd7LAVnacC96n0oeRyVvajmrPDgFI=;
 b=AYOFMrOxrgJQOGq/83BVm4/4p9A+e4bZ3ickO652LWT0Bb+NZJTWMgQfRNAprOYaji
 Wb7qf3UHvtTHmAV0QF8+GnW+Ee0QSRBW9MH/P85VVbLuJyKA3auwesGZkbAuRKYvwwfM
 Ic8qEPOnECyF+tUZOtH/47Qj+hmGRzdf9/1IaE2Y7UXER1iTRhwWpY99EXPqxGky/Ete
 RkxK7T3amKLmctZ7Pi5ibTobGCgj1QLGopEbtIu+WPsR/5Cas1IwjqFxEF5uW546fCGN
 MSDnqORLIGIF/Mo13QPgbL3j1S2g2U22X9i8BO/m1HVzlyFhAMl5741uK+C7koVDxqcc
 aeDw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776701838; x=1777306638; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6MijSywokdCkNZvM6n8pi8nJqMySWTSMiKK0MD2DLoA=;
 b=SIAh0uIVx03sRT0qw/YQsqvoH1ZDp6IBW3JlxqPXpoe7vOZgUA/G0SEgsgz3XMqAof
 bki/LLOhxHen6hoPVijNApSqqv3yazISIgKYECxKC0YMBw2rOfIyb6MwTDvopVYIgC2H
 4HZjF/rWjNQkP92K/zSnqyQsEvY25AVvzGiB0513Bd2I9XqdTylbum+STG0FAkwfwNXx
 0OTT+Ejo2IwDnjdDR+1qIkmfN1h2Uzghubdud0DM2qgI1plnJTl8uXMhmn7R+BsORBNO
 /YYd8+w4TbUWxk471t2/OXMIQZ+y7FqUsEJTvEKYDAU5/9EZIj8PulEzz/WFSgpcLxfQ
 jAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776701838; x=1777306638;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6MijSywokdCkNZvM6n8pi8nJqMySWTSMiKK0MD2DLoA=;
 b=oIOzA5qvpUz/tSsDidcvo0P1r8pD1X0uD+b6b+9FkqRtqCWflcFEwTpEGr1Oa+kF04
 +N5xzmpCnWsrj5dIjVhWQspw3nzycWY9jxNpT6cQ/C1As3bG5kikC6RIHBvmenry5izk
 fIBfeVojp/D1eyU0n0a6O6BEXtVaec0YaDXdcm/4ltTsV+qQtD4zkiSofElcAdxD/BtI
 eLL1oh9wigSik+w5CkO6xdzshezhQ5CNuICvF0X98YBw0xtFBXlJhppOOO5S4RQidk6T
 B/RXTojTm2WoHb1+tKwyRdR9Og5bOly8+MITV6phm/Sk54670Vc8IM5BnbBCNpfXkyKY
 QErQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9LzFTPlA2sqMiTu9vPONjL/4LHbLKBskeNU2sfXbDmwYRtjkPliPdH6qQnmq/OPO7r0Bm3l2k=@lists.denx.de
X-Gm-Message-State: AOJu0YyAlwbJ3TbYSsCxfnfOGAEPT475xyyfCohGNvyu/LhllyFoGBmo
 DibdkhogXDHmlBU6qvwsHOZS6ehiny8AOlFPmeGnt4XtcBSgaMFSUwwZ2WSbLhNPq8/fCjQML5o
 i/mgbLHMweYT4v510QC07LTeSdVBa3ic2AewSmaY=
X-Gm-Gg: AeBDietqYliXGf0fYbIaDvIh8Oo+xmsj0I8YrOjS+oiRiU7l/9pjzzXNmBZMbN57K7I
 VdiShJ35akpVddYS14gJTIGcv03rud/kgKvPXhMOyQRE1LoSkrfJXTpHRY4DISFoWdgTFsYZUS1
 XAsdCT/XpYiiybHbS36+BO3PsHf5gxVs9mSdjPYQsvpX2XhNkbfnSXXOoeVESHrOCHPoxaRoZVj
 cQj4hg3h8QDYSRexEs7FFKl4QKAI+RGxfxn4fvtmmo9JEL0vJ/19H1WOPGX5m2nMq8u4GUrcHHf
 b4HnMDC81oqboATFsSM=
X-Received: by 2002:a05:690e:4093:b0:654:c28:561 with SMTP id
 956f58d0204a3-6540c281b4cmr9710680d50.61.1776701838383; Mon, 20 Apr 2026
 09:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
 <20260417130204.49896-2-philippe.reynes@softathome.com>
In-Reply-To: <20260417130204.49896-2-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 20 Apr 2026 12:17:06 -0400
X-Gm-Features: AQROBzCjmicYFP_60YwAzi6IMvhTydRF5A-rDvmAaPt7V3xT1fA0BrpXlFPLXZc
Message-ID: <CAMDkj5yqsjsLZ+q-EQ8DCPw9bT+ySL-qhrgQMK5aV_wL=JOdug@mail.gmail.com>
Subject: Re: [PATCH v4 01/14] mbedtls: enable support of ecc
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

On Fri, Apr 17, 2026 at 9:02=E2=80=AFAM Philippe Reynes
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
>
> v4:
> - do not select ECDSA on some configs
> - remove duplicated MBEDTLS_ECP_DP_SECP256K1_ENABLED
> - change dependencies for ECDSA configs
>
>  configs/sandbox_defconfig        |  1 +
>  lib/ecdsa/Kconfig                |  1 +
>  lib/mbedtls/Kconfig              | 14 ++++++++++++++
>  lib/mbedtls/Makefile             | 17 +++++++++--------
>  lib/mbedtls/mbedtls_def_config.h | 17 +++++++++++++++++
>  5 files changed, 42 insertions(+), 8 deletions(-)
>
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index f26295103f1..15831dd7e04 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -391,6 +391,7 @@ CONFIG_PANIC_HANG=3Dy
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
> index 789721ee6cd..cfc47152fc5 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -247,6 +247,10 @@ config MBEDTLS_LIB_X509
>
>  if MBEDTLS_LIB_X509
>
> +config BIGNUM_MBEDTLS
> +       bool
> +       default n
> +
>  config ASN1_DECODER_MBEDTLS
>         bool "ASN1 decoder with MbedTLS certificate library"
>         depends on MBEDTLS_LIB_X509 && ASN1_DECODER
> @@ -264,6 +268,7 @@ config RSA_PUBLIC_KEY_PARSER_MBEDTLS
>         bool "RSA public key parser with MbedTLS certificate library"
>         depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
>         select ASN1_DECODER_MBEDTLS
> +       select BIGNUM_MBEDTLS
>         help
>           This option chooses MbedTLS certificate library for RSA public =
key
>           parser.
> @@ -292,6 +297,15 @@ config MSCODE_PARSER_MBEDTLS
>           This option chooses MbedTLS certificate library for MS authenti=
code
>           parser.
>
> +config ECDSA_MBEDTLS
> +       bool "Enable ECDSA support with MbedTLS certificate library"
> +       depends on MBEDTLS_LIB_X509 && ECDSA_VERIFY
> +       select ASN1_DECODER_MBEDTLS

select ASN1_DECODER_MBEDTLS if ASN1_DECODER
All _MBEDTLS switches should be under control of the main switches.

> +       select BIGNUM_MBEDTLS
> +       help
> +         This option enables support of ECDSA with the MbedTLS certifica=
te
> +         library.
> +
>  endif # MBEDTLS_LIB_X509
>
>  config MBEDTLS_LIB_TLS
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index c5b445bd85c..aa1ca6d196b 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -38,14 +38,20 @@ mbedtls_lib_crypto-$(CONFIG_$(PHASE_)HKDF_MBEDTLS) +=
=3D \
>
>  # MbedTLS X509 library
>  obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_X509) +=3D mbedtls_lib_x509.o
> -mbedtls_lib_x509-y :=3D $(MBEDTLS_LIB_DIR)/x509.o
> +mbedtls_lib_x509-y :=3D $(MBEDTLS_LIB_DIR)/x509.o \
> +       $(MBEDTLS_LIB_DIR)/ecdsa.o \
> +       $(MBEDTLS_LIB_DIR)/ecp.o \
> +       $(MBEDTLS_LIB_DIR)/ecp_curves.o \
> +       $(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
> +       $(MBEDTLS_LIB_DIR)/pk_ecc.o

To avoid increasing binary size and making the build dependency
broader than the feature being enabled, please use
'mbedtls_lib_x509-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS)' instead of
'mbedtls_lib_x509-y' when introducing the ecdsa/ecp/ecc objects.

Regards,
Raymond



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
> @@ -64,7 +70,6 @@ mbedtls_lib_tls-y :=3D \
>         $(MBEDTLS_LIB_DIR)/mps_reader.o \
>         $(MBEDTLS_LIB_DIR)/mps_trace.o \
>         $(MBEDTLS_LIB_DIR)/net_sockets.o \
> -       $(MBEDTLS_LIB_DIR)/pk_ecc.o \
>         $(MBEDTLS_LIB_DIR)/ssl_cache.o \
>         $(MBEDTLS_LIB_DIR)/ssl_ciphersuites.o \
>         $(MBEDTLS_LIB_DIR)/ssl_client.o \
> @@ -82,8 +87,4 @@ mbedtls_lib_tls-y :=3D \
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
> index dda3f4dd6e4..239215ecf85 100644
> --- a/lib/mbedtls/mbedtls_def_config.h
> +++ b/lib/mbedtls/mbedtls_def_config.h
> @@ -89,6 +89,23 @@
>  #define MBEDTLS_ASN1_WRITE_C
>  #endif
>
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
> +
>  #endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
>
>  #if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS)
> --
> 2.43.0
>
