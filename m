Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBE9C5475C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 09:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EE85889B3;
	Wed, 28 Aug 2024 11:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OuVop7Kv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7559388A2E; Wed, 28 Aug 2024 11:25:55 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F202E88714
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 11:25:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-201df0b2df4so52871055ad.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 02:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724837151; x=1725441951; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WUGaMCGIHG1tPIe0IZuobVR1aRKetAkSj8bREVuJu2g=;
 b=OuVop7Kvle3lL6hi9YT/TbhJpMCbcixJ5LF0h+z8ggWIlH/M9/MnmaUuMCFSYTm9tx
 QEXEh0TcPOaCZOpz5pSI+WjhIXGpEHP1THqSFWM/R3KrNuvrpQduZJq6TisQ6jbuPdwE
 l2x1Mjoeva2Evgtq7rAv4+ktoQyldgl+IMoZitnv+KyxffjGx2nNPj/R0z+pF+UlxOz1
 Adtxc028yw1ASnA2YJ/7xzWqHzYmkGawMI/iIJk8UXDlkP2VcWP4iFk/KmRkn73o7fp8
 4fo+P6v2s4rovlK6sb56SCbujdfmdFRshkIzyo7XbJujCAlHhFwuZ4x0Za/9jy07WiAl
 OC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724837151; x=1725441951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WUGaMCGIHG1tPIe0IZuobVR1aRKetAkSj8bREVuJu2g=;
 b=s/N5rE2okYQpd9dXYscJwIrv5RrKnUD1wFA+1Di0iTL1GbdZ4uo3q1E+Ih3dT8nvex
 xHJmF9O2uJoJa9WsviO60G4JSVsxmObSJsK+ecqatsJmbfROd8qFNFw/O9Ct4hx+3rfI
 AXX2yHaREfcztyEQyaZyhOao8mPX5kOfqyo0bruch1PJ51QxVoycs4JrCRLRk3NtxHBf
 DMWKVXYohFEuA7xGxXCZjyfBuvA9tkjEFHtKgakug8p4as8N7bc+aJEMvU/VO306JJKO
 PPiCKYh13ncqUA77BOFzN0S+vA/wdhvqOXxTi0D3LBLo52Tm+jkPuOmUi/psTOXvf1fw
 PhBw==
X-Gm-Message-State: AOJu0YxE7LIlx+S/wqOGZ3IEH35+71OzGI2p8kPzWNJUy+tX6dXB0Vxj
 vUXRXgvGksShPrCWPBYtrQKUZp3UjFQyFY2yVL/9+yODNX1BRxT4ZIqvc/27dncRTud+L0UaADA
 H+lP83nxEu70L8i/8t19TG50lQkrwOPDO3bbwtQ==
X-Google-Smtp-Source: AGHT+IH67IJye2Xjh2FkRUCfg99rMbvP4T/mihuxZp3O9jGF0RFFaM9FKJbTR3YozDGZCDRpWJA2ddnno3BW1IAirzw=
X-Received: by 2002:a17:902:fc45:b0:201:e646:4d8 with SMTP id
 d9443c01a7336-2039e495128mr194047265ad.26.1724837151178; Wed, 28 Aug 2024
 02:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-4-raymond.mao@linaro.org>
In-Reply-To: <20240816214436.1877263-4-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 28 Aug 2024 12:25:14 +0300
Message-ID: <CAC_iWj+-Wa=X8RxUpLGuDV+BAkt-4hBKNSvJWPPsXHF+jX-L0Q@mail.gmail.com>
Subject: Re: [PATCH v6 03/28] lib: Adapt digest header files to MbedTLS
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Anand Moon <linux.amoon@gmail.com>,
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

On Sat, 17 Aug 2024 at 00:46, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Adapt digest header files to support both original libs and MbedTLS
> by switching on/off MBEDTLS_LIB_CRYPTO.
> Introduce <alg>_LEGACY kconfig for legacy hash implementations.
>
> `IS_ENABLED` or `CONFIG_IS_ENABLED` is not applicable here, since
> including <linux/kconfig.h> causes undefined reference on schedule()
> with sandbox build, as <linux/kconfig.h> includes <generated/autoconf.h>
> which enables `CONFIG_HW_WATCHDOG` and `CONFIG_WATCHDOG` but no schedule()
> are defined in sandbox build,
> Thus we use `#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)` instead.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Initial patch.
> Changes in v3
> - Remove the changes that were done in previous clean-up patch set.
> Changes in v4
> - Introduce <alg>_LEGACY kconfig for legacy hash implementations.
> Changes in v5
> - Correct header file include directories.
> - Correct kconfig dependence.
> Changes in v6
> - Update commit message.
> - Rebased on next branch.
>
>  include/u-boot/md5.h    |  7 ++++
>  include/u-boot/sha1.h   | 21 +++++++++-
>  include/u-boot/sha256.h | 20 +++++++++
>  include/u-boot/sha512.h |  9 ++++
>  lib/Makefile            | 10 +++--
>  lib/mbedtls/Kconfig     | 91 +++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 153 insertions(+), 5 deletions(-)
>
> diff --git a/include/u-boot/md5.h b/include/u-boot/md5.h
> index c465925ea8d..69898fcbe49 100644
> --- a/include/u-boot/md5.h
> +++ b/include/u-boot/md5.h
> @@ -6,10 +6,16 @@
>  #ifndef _MD5_H
>  #define _MD5_H
>
> +#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +#include <mbedtls/md5.h>
> +#endif
>  #include "compiler.h"
>
>  #define MD5_SUM_LEN    16
>
> +#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +typedef mbedtls_md5_context MD5Context;
> +#else
>  typedef struct MD5Context {
>         __u32 buf[4];
>         __u32 bits[2];
> @@ -18,6 +24,7 @@ typedef struct MD5Context {
>                 __u32 in32[16];
>         };
>  } MD5Context;
> +#endif
>
>  void MD5Init(MD5Context *ctx);
>  void MD5Update(MD5Context *ctx, unsigned char const *buf, unsigned int len);
> diff --git a/include/u-boot/sha1.h b/include/u-boot/sha1.h
> index c1e9f67068d..ab88134fb98 100644
> --- a/include/u-boot/sha1.h
> +++ b/include/u-boot/sha1.h
> @@ -16,6 +16,21 @@
>
>  #include <linux/types.h>
>
> +#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +/*
> + * FIXME:
> + * MbedTLS define the members of "mbedtls_sha256_context" as private,
> + * but "state" needs to be access by arch/arm/cpu/armv8/sha1_ce_glue.
> + * MBEDTLS_ALLOW_PRIVATE_ACCESS needs to be enabled to allow the external
> + * access.
> + * Directly including <external/mbedtls/library/common.h> is not allowed,
> + * since this will include <malloc.h> and break the sandbox test.
> + */
> +#define MBEDTLS_ALLOW_PRIVATE_ACCESS

nit, this probably belongs on the mbedTLS config file, so you wont
have to define for all checksum algorithms

> +
> +#include <mbedtls/sha1.h>
> +#endif
> +
>  #ifdef __cplusplus
>  extern "C" {
>  #endif
> @@ -26,6 +41,9 @@ extern "C" {
>
>  extern const uint8_t sha1_der_prefix[];
>
> +#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +typedef mbedtls_sha1_context sha1_context;
> +#else
>  /**
>   * \brief         SHA-1 context structure
>   */
> @@ -36,13 +54,14 @@ typedef struct
>      unsigned char buffer[64];  /*!< data block being processed */
>  }
>  sha1_context;
> +#endif
>
>  /**
>   * \brief         SHA-1 context setup
>   *
>   * \param ctx     SHA-1 context to be initialized
>   */
> -void sha1_starts( sha1_context *ctx );
> +void sha1_starts(sha1_context *ctx);
>
>  /**
>   * \brief         SHA-1 process buffer
> diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
> index a4fe176c0b4..b58d5b58d39 100644
> --- a/include/u-boot/sha256.h
> +++ b/include/u-boot/sha256.h
> @@ -3,6 +3,22 @@
>
>  #include <linux/types.h>
>
> +#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +/*
> + * FIXME:
> + * MbedTLS define the members of "mbedtls_sha256_context" as private,
> + * but "state" needs to be access by arch/arm/cpu/armv8/sha256_ce_glue.
> + * MBEDTLS_ALLOW_PRIVATE_ACCESS needs to be enabled to allow the external
> + * access.
> + * Directly including <external/mbedtls/library/common.h> is not allowed,
> + * since this will include <malloc.h> and break the sandbox test.
> + */
> +#define MBEDTLS_ALLOW_PRIVATE_ACCESS
> +
> +#include <mbedtls/sha256.h>
> +#endif
> +
> +#define SHA224_SUM_LEN 28
>  #define SHA256_SUM_LEN 32
>  #define SHA256_DER_LEN 19
>
> @@ -11,11 +27,15 @@ extern const uint8_t sha256_der_prefix[];
>  /* Reset watchdog each time we process this many bytes */
>  #define CHUNKSZ_SHA256 (64 * 1024)
>
> +#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +typedef mbedtls_sha256_context sha256_context;
> +#else
>  typedef struct {
>         uint32_t total[2];
>         uint32_t state[8];
>         uint8_t buffer[64];
>  } sha256_context;
> +#endif
>
>  void sha256_starts(sha256_context * ctx);
>  void sha256_update(sha256_context *ctx, const uint8_t *input, uint32_t length);
> diff --git a/include/u-boot/sha512.h b/include/u-boot/sha512.h
> index 83c2119cd26..7e10f590a1d 100644
> --- a/include/u-boot/sha512.h
> +++ b/include/u-boot/sha512.h
> @@ -3,6 +3,10 @@
>
>  #include <linux/types.h>
>
> +#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +#include <mbedtls/sha512.h>
> +#endif
> +
>  #define SHA384_SUM_LEN          48
>  #define SHA384_DER_LEN          19
>  #define SHA512_SUM_LEN          64
> @@ -12,11 +16,16 @@
>  #define CHUNKSZ_SHA384 (16 * 1024)
>  #define CHUNKSZ_SHA512 (16 * 1024)
>
> +#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +typedef mbedtls_sha512_context sha384_context;
> +typedef mbedtls_sha512_context sha512_context;
> +#else
>  typedef struct {
>         uint64_t state[SHA512_SUM_LEN / 8];
>         uint64_t count[2];
>         uint8_t buf[SHA512_BLOCK_SIZE];
>  } sha512_context;
> +#endif
>
>  extern const uint8_t sha512_der_prefix[];
>
> diff --git a/lib/Makefile b/lib/Makefile
> index e1ab8dfd503..617f5a55de0 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -71,14 +71,16 @@ obj-$(CONFIG_$(SPL_TPL_)CRC16) += crc16.o
>  obj-y += crypto/
>
>  obj-$(CONFIG_$(SPL_TPL_)ACPI) += acpi/
> -obj-$(CONFIG_$(SPL_)MD5) += md5.o
>  obj-$(CONFIG_ECDSA) += ecdsa/
>  obj-$(CONFIG_$(SPL_)RSA) += rsa/
>  obj-$(CONFIG_HASH) += hash-checksum.o
>  obj-$(CONFIG_BLAKE2) += blake2/blake2b.o
> -obj-$(CONFIG_$(SPL_)SHA1) += sha1.o
> -obj-$(CONFIG_$(SPL_)SHA256) += sha256.o
> -obj-$(CONFIG_$(SPL_)SHA512) += sha512.o
> +
> +obj-$(CONFIG_$(SPL_)MD5_LEGACY) += md5.o
> +obj-$(CONFIG_$(SPL_)SHA1_LEGACY) += sha1.o
> +obj-$(CONFIG_$(SPL_)SHA256_LEGACY) += sha256.o
> +obj-$(CONFIG_$(SPL_)SHA512_LEGACY) += sha512.o
> +
>  obj-$(CONFIG_CRYPT_PW) += crypt/
>  obj-$(CONFIG_$(SPL_)ASN1_DECODER) += asn1_decoder.o
>
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index 3e9057f1acf..efae2c4fd72 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -21,9 +21,100 @@ if LEGACY_CRYPTO
>
>  config LEGACY_CRYPTO_BASIC
>         bool "legacy basic crypto libraries"
> +       select MD5_LEGACY if MD5
> +       select SHA1_LEGACY if SHA1
> +       select SHA256_LEGACY if SHA256
> +       select SHA512_LEGACY if SHA512
> +       select SHA384_LEGACY if SHA384
> +       select SPL_MD5_LEGACY if SPL_MD5
> +       select SPL_SHA1_LEGACY if SPL_SHA1
> +       select SPL_SHA256_LEGACY if SPL_SHA256
> +       select SPL_SHA512_LEGACY if SPL_SHA512
> +       select SPL_SHA384_LEGACY if SPL_SHA384
>         help
>           Enable legacy basic crypto libraries.
>
> +if LEGACY_CRYPTO_BASIC
> +
> +config SHA1_LEGACY
> +       bool "Enable SHA1 support with legacy crypto library"
> +       depends on LEGACY_CRYPTO_BASIC && SHA1
> +       help
> +         This option enables support of hashing using SHA1 algorithm
> +         with legacy crypto library.
> +
> +config SHA256_LEGACY
> +       bool "Enable SHA256 support with legacy crypto library"
> +       depends on LEGACY_CRYPTO_BASIC && SHA256
> +       help
> +         This option enables support of hashing using SHA256 algorithm
> +         with legacy crypto library.
> +
> +config SHA512_LEGACY
> +       bool "Enable SHA512 support with legacy crypto library"
> +       depends on LEGACY_CRYPTO_BASIC && SHA512
> +       default y if TI_SECURE_DEVICE && FIT_SIGNATURE
> +       help
> +         This option enables support of hashing using SHA512 algorithm
> +         with legacy crypto library.
> +
> +config SHA384_LEGACY
> +       bool "Enable SHA384 support with legacy crypto library"
> +       depends on LEGACY_CRYPTO_BASIC && SHA384
> +       select SHA512_LEGACY
> +       help
> +         This option enables support of hashing using SHA384 algorithm
> +         with legacy crypto library.
> +
> +config MD5_LEGACY
> +       bool "Enable MD5 support with legacy crypto library"
> +       depends on LEGACY_CRYPTO_BASIC && MD5
> +       help
> +         This option enables support of hashing using MD5 algorithm
> +         with legacy crypto library.
> +
> +if SPL
> +
> +config SPL_SHA1_LEGACY
> +       bool "Enable SHA1 support in SPL with legacy crypto library"
> +       depends on LEGACY_CRYPTO_BASIC && SPL_SHA1
> +       help
> +         This option enables support of hashing using SHA1 algorithm
> +         with legacy crypto library.
> +
> +config SPL_SHA256_LEGACY
> +       bool "Enable SHA256 support in SPL with legacy crypto library"
> +       depends on LEGACY_CRYPTO_BASIC && SPL_SHA256
> +       help
> +         This option enables support of hashing using SHA256 algorithm
> +         with legacy crypto library.
> +
> +config SPL_SHA512_LEGACY
> +       bool "Enable SHA512 support in SPL with legacy crypto library"
> +       depends on LEGACY_CRYPTO_BASIC && SPL_SHA512
> +       help
> +         This option enables support of hashing using SHA512 algorithm
> +         with legacy crypto library.
> +
> +config SPL_SHA384_LEGACY
> +       bool "Enable SHA384 support in SPL with legacy crypto library"
> +       depends on LEGACY_CRYPTO_BASIC && SPL_SHA384
> +       select SPL_SHA512_LEGACY
> +       help
> +         This option enables support of hashing using SHA384 algorithm
> +         with legacy crypto library.
> +
> +config SPL_MD5_LEGACY
> +       bool "Enable MD5 support in SPL with legacy crypto library"
> +       depends on LEGACY_CRYPTO_BASIC && SPL_MD5
> +       help
> +         This option enables support of hashing using MD5 algorithm
> +         with legacy crypto library.
> +
> +endif # SPL
> +
> +endif # LEGACY_CRYPTO_BASIC
> +
>  config LEGACY_CRYPTO_CERT
>         bool "legacy certificate libraries"
>         help
> --
> 2.25.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
