Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C384C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 10:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 956908843F;
	Wed,  8 May 2024 12:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IlsweeJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 418178844B; Wed,  8 May 2024 12:30:53 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14E7B87E9D
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 12:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a599c55055dso1020509366b.0
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 03:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715164250; x=1715769050; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M6fLTTD7mh1DkxI4lszU4E4RiODn7oNmSN3gsQFDAOY=;
 b=IlsweeJvCwMiH0V13XUrVYrS2D8YTeDdmTIzJXmr9Ws6Ti3NMxsSRQ9zg58rmYDiMB
 M015oKlNGloiGe5YfVFKGZQNscXvD53sFyhWfgJ5h3HsV29oSBPQcVO+lwnlbYhy8k6F
 ysVqZ+ZDUYnF/DwRFcsca6gzEi+FoZZz/QafO1NE/D22SEapaJR3QqzZamgO00JMMyCT
 +FucRqP6d+MpWALHPzYy5CwEkQEp7ak3wVOIHk54W4xnaQH5RH8isNH/9FQfVfo/AdNx
 M+J45nW5bTRBo//D38cbCyy8AosSlNZWuq9yQz/ntpEOSIrjdw06ahVKDyPnEt6Sve+J
 4mNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715164250; x=1715769050;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M6fLTTD7mh1DkxI4lszU4E4RiODn7oNmSN3gsQFDAOY=;
 b=vHGOJ7zbjXfRSnO418mKb3PyBu1oMyS3Vz5Ln5c9DZ5AuVxhAqnJ6i/PEW/rDt7Ry+
 WtZQiK1wTkmy9x7w297uMymoc7Dy8qEV/KSFXqd8Q+EmLGSyE5HbdD0qRh/u/QmrG1xE
 QvO8fOq+PeyqNTO11yInJbOdVowBziN7eSb85+jnAiyK7gTlnwCk4zbcd2Tnd4yM0vL6
 XliTPeojNMqA5b7ciUOB9cxOS+Z+BB9bewLzdt9d4F3RWFpJeAjMCanZTIxWSc2Ca8G+
 bMPvzLLUAN2m4152ixXF2aGBv9O7/Wu48Sd94f0gjEjpt7/7uPXGhWlYMkXbE9l/0obX
 aJTg==
X-Gm-Message-State: AOJu0YynWR1f0+6s0S7Zs49VguJGk7fzRwwh/vJIolJgdGsWju3KHgwi
 V2rCWo1vKMCBXsuSgY3bIUr5/PoVcCALvjpLMYEl/ZUOXeDxcwQETczqPUX5jby3axXOIF1Rbos
 kLMV4/b9j3M7+l966raMnViRkntlKs1jJjGGwkw==
X-Google-Smtp-Source: AGHT+IGdnoRZ+5/GvJRy3Z6myRcM22vGshzXtmXWAAMqYCgPkkIYVWB7cTrkeF7Z/XstME85uLC1zKrdXaaYzFm3JBI=
X-Received: by 2002:a17:906:eb0b:b0:a59:cdf4:f938 with SMTP id
 a640c23a62f3a-a59fb95e0eemr125943766b.37.1715164250437; Wed, 08 May 2024
 03:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-8-raymond.mao@linaro.org>
In-Reply-To: <20240507175132.1456512-8-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 8 May 2024 13:30:14 +0300
Message-ID: <CAC_iWjJ50--SCCEq3srxD0+F_5_5s_okfghcsjJrA+WJ9ftWLg@mail.gmail.com>
Subject: Re: [PATCH v2 07/28] lib: Adapt digest header files to MbedTLS
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Andrew Davis <afd@ti.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilya Lukin <4.shket@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Bin Meng <bmeng@tinylab.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Tue, 7 May 2024 at 20:54, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Adapt digest header files to support both original libs and MbedTLS
> by switching on/off MBEDTLS_LIB_CRYPTO
>
> FIXME:
> `IS_ENABLED` or `CONFIG_IS_ENABLED` is not applicable here, since
> including <linux/kconfig.h> causes undefined reference on schedule()
> with sandbox build.
> As <linux/kconfig.h> includes <generated/autoconf.h> which enables
> `CONFIG_HW_WATCHDOG` and `CONFIG_WATCHDOG` but no schedule() are
> defined in sandbox build.
> `#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)` is a workaround.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Initial patch.
>
>  include/u-boot/md5.h    | 17 ++++++++++++-----
>  include/u-boot/sha1.h   | 21 ++++++++++++++++++++-
>  include/u-boot/sha256.h | 20 ++++++++++++++++++++
>  include/u-boot/sha512.h | 22 +++++++++++++++++++---
>  lib/Makefile            |  6 +++++-
>  5 files changed, 76 insertions(+), 10 deletions(-)
>
> diff --git a/include/u-boot/md5.h b/include/u-boot/md5.h
> index d61364c0ae3..3cfd33a8e56 100644
> --- a/include/u-boot/md5.h
> +++ b/include/u-boot/md5.h
> @@ -6,22 +6,29 @@
>  #ifndef _MD5_H
>  #define _MD5_H
>
> +#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +#include <external/mbedtls/include/mbedtls/md5.h>
> +#endif
>  #include "compiler.h"
>
>  #define MD5_SUM_LEN    16
>
> -struct MD5Context {
> +#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +typedef mbedtls_md5_context MD5Context;
> +#else
> +typedef struct MD5Context {
>         __u32 buf[4];
>         __u32 bits[2];
>         union {
>                 unsigned char in[64];
>                 __u32 in32[16];
>         };
> -};
> +} MD5Context;
> +#endif
>
> -void MD5Init(struct MD5Context *ctx);
> -void MD5Update(struct MD5Context *ctx, unsigned char const *buf, unsigned len);
> -void MD5Final(unsigned char digest[16], struct MD5Context *ctx);
> +void MD5Init(MD5Context *ctx);
> +void MD5Update(MD5Context *ctx, unsigned char const *buf, unsigned int len);
> +void MD5Final(unsigned char digest[16], MD5Context *ctx);
>
>  /*
>   * Calculate and store in 'output' the MD5 digest of 'len' bytes at
> diff --git a/include/u-boot/sha1.h b/include/u-boot/sha1.h
> index 09fee594d26..ee46fe947a0 100644
> --- a/include/u-boot/sha1.h
> +++ b/include/u-boot/sha1.h
> @@ -14,6 +14,21 @@
>  #ifndef _SHA1_H
>  #define _SHA1_H
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
> +
> +#include <external/mbedtls/include/mbedtls/sha1.h>
> +#endif
> +
>  #ifdef __cplusplus
>  extern "C" {
>  #endif
> @@ -24,6 +39,9 @@ extern "C" {
>
>  extern const uint8_t sha1_der_prefix[];
>
> +#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +typedef mbedtls_sha1_context sha1_context;
> +#else
>  /**
>   * \brief         SHA-1 context structure
>   */
> @@ -34,13 +52,14 @@ typedef struct
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
> index 9aa1251789a..e2b7fdd41c8 100644
> --- a/include/u-boot/sha256.h
> +++ b/include/u-boot/sha256.h
> @@ -1,6 +1,22 @@
>  #ifndef _SHA256_H
>  #define _SHA256_H
>
> +#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +/*
> + * FIXME:
> + * MbedTLS define the members of "mbedtls_sha256_context" as private,
> + * but "state" needs to be access by arch/arm/cpu/armv8/sha256_ce_glue.

'be able to access.'

Isn't the MBEDTLS_ALLOW_PRIVATE_ACCESS considered deprecated?
I'd prefer if we fix this properly.

Thanks
/Ilias
> + * MBEDTLS_ALLOW_PRIVATE_ACCESS needs to be enabled to allow the external
> + * access.
> + * Directly including <external/mbedtls/library/common.h> is not allowed,
> + * since this will include <malloc.h> and break the sandbox test.
> + */
> +#define MBEDTLS_ALLOW_PRIVATE_ACCESS
> +
> +#include <external/mbedtls/include/mbedtls/sha256.h>
> +#endif
> +
> +#define SHA224_SUM_LEN 28
>  #define SHA256_SUM_LEN 32
>  #define SHA256_DER_LEN 19
>
> @@ -9,11 +25,15 @@ extern const uint8_t sha256_der_prefix[];
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
> index 516729d7750..a0c0de89d60 100644
> --- a/include/u-boot/sha512.h
> +++ b/include/u-boot/sha512.h
> @@ -1,6 +1,10 @@
>  #ifndef _SHA512_H
>  #define _SHA512_H
>
> +#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +#include <external/mbedtls/include/mbedtls/sha512.h>
> +#endif
> +
>  #define SHA384_SUM_LEN          48
>  #define SHA384_DER_LEN          19
>  #define SHA512_SUM_LEN          64
> @@ -10,11 +14,16 @@
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
> @@ -27,12 +36,19 @@ void sha512_csum_wd(const unsigned char *input, unsigned int ilen,
>
>  extern const uint8_t sha384_der_prefix[];
>
> +#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +void sha384_starts(sha512_context *ctx);
> +void
> +sha384_update(sha512_context *ctx, const uint8_t *input, uint32_t length);
> +void sha384_finish(sha512_context *ctx, uint8_t digest[SHA384_SUM_LEN]);
> +void sha384_csum_wd(const unsigned char *input, unsigned int length,
> +                   unsigned char *output, unsigned int chunk_sz);
> +#else
>  void sha384_starts(sha512_context * ctx);
>  void sha384_update(sha512_context *ctx, const uint8_t *input, uint32_t length);
>  void sha384_finish(sha512_context * ctx, uint8_t digest[SHA384_SUM_LEN]);
>
>  void sha384_csum_wd(const unsigned char *input, unsigned int ilen,
> -               unsigned char *output, unsigned int chunk_sz);
> -
> -
> +                   unsigned char *output, unsigned int chunk_sz);
> +#endif
>  #endif /* _SHA512_H */
> diff --git a/lib/Makefile b/lib/Makefile
> index a4600b09f49..3534b3301ae 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -69,14 +69,18 @@ obj-$(CONFIG_$(SPL_TPL_)CRC16) += crc16.o
>  obj-y += crypto/
>
>  obj-$(CONFIG_$(SPL_TPL_)ACPI) += acpi/
> -obj-$(CONFIG_$(SPL_)MD5) += md5.o
>  obj-$(CONFIG_ECDSA) += ecdsa/
>  obj-$(CONFIG_$(SPL_)RSA) += rsa/
>  obj-$(CONFIG_HASH) += hash-checksum.o
>  obj-$(CONFIG_BLAKE2) += blake2/blake2b.o
> +
> +ifneq ($(CONFIG_MBEDTLS_LIB_CRYPTO), y)
> +obj-$(CONFIG_$(SPL_)MD5) += md5.o
>  obj-$(CONFIG_$(SPL_)SHA1) += sha1.o
>  obj-$(CONFIG_$(SPL_)SHA256) += sha256.o
>  obj-$(CONFIG_$(SPL_)SHA512) += sha512.o
> +endif
> +
>  obj-$(CONFIG_CRYPT_PW) += crypt/
>  obj-$(CONFIG_$(SPL_)ASN1_DECODER) += asn1_decoder.o
>
> --
> 2.25.1
>
