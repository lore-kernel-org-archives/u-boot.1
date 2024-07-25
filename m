Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E372EC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 10:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EE398690D;
	Thu, 25 Jul 2024 12:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xjW/Krnj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDD5886DBD; Thu, 25 Jul 2024 12:14:26 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8321786463
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 12:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fc611a0f8cso5647395ad.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 03:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721902463; x=1722507263; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GiuDaqyFhOyqRw67GhtT9Ei9KRhNqEoeRlpM5a+6O5s=;
 b=xjW/KrnjLk8cEK5BL3TsM6M/Agl7poE1IjcIx7h2+KL963Zx1VyWUvVxpnbBIBQ84w
 WwwKcEw+qp5xJrSvJyS4RTeG6UtaPy1PmwCxG2kfwRe5a7P3kAamIQG3d9AlR0i+PPT/
 24DtBNRBAla6ss9yDclySEJCZMFv/C+mm5/d1J7E9VhnUo03CSfxbsxOo3HukCneg9vV
 cz3SynlFspE51cyaRJnye+DJZcB45h/5+nzonwbavHSFn7f6Q1wDAA49dwyUq30T4SOZ
 IuIBOVxTCy1ljrxKKL78m+JRHNKi+yA1lt7jrBq7vOCCWDHb6n/1igiR0W31XbAXH71w
 F9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721902463; x=1722507263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GiuDaqyFhOyqRw67GhtT9Ei9KRhNqEoeRlpM5a+6O5s=;
 b=SThJdhYmJH2k70Lp+7yHNf/iJYYLRwC/4hct3lrqfZV2EMf3ppiA0ucWq2iBDBQW1g
 iY0LLPJtlM0k1jUciLpoVPOcaEcMsoiHhjSx0/nU8z529GECBgIpgTQ8TzQEt/wHA0wi
 VSWIGax2I54uMdrISoB7vHfbA1pOnkCdh1HWg/ej5DwwZPspXwssyNTNyzJigOm8U5y4
 S6LnwDjs2pQJ20xY7cMBqSrbKUrL6A1JaZlz227Km+CEuKaHm22uqz2aL4+gC2GRw5rl
 GZvSnsC98xDcOYcnIU+BFPeNiro7e/4OK5DOVqvye7xrM7/R/xIGBW4HrECop0Qouj44
 k1OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJYU5nqTFKr+Ybfb6V8f6GqPm+f7pPkhJpN3RP1pmTvP8841K3JnSfE3TY9Jy/Yr9kR8e+BLql8/NxwN49bNedCNRyUA==
X-Gm-Message-State: AOJu0YyKgCAXy7zlU3Q4syDxSaDd0c/ZPUFDghR254h2j7DmUSkTOoY1
 wqMUXir/CYU5cgjLczf+pUUxevQvtFG6irSsmekqkl5D6m47msNiMchzMVI3gESiRXLk6ll/GT9
 loF2GJgFWHE2B+A9AFGGUBvUQf3OKHYpJ683agA==
X-Google-Smtp-Source: AGHT+IFQ093Etf3RBhtb2GdpV7XtYC6H3FXbrMK9eoczIaOW8QValq1Ksxc7guvZ4+yrXVo1VF1iyaloQ8xhCCRbOi8=
X-Received: by 2002:a17:902:da8e:b0:1fb:88a4:3783 with SMTP id
 d9443c01a7336-1fed92f35b4mr14474465ad.51.1721902462728; Thu, 25 Jul 2024
 03:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
 <20240719-b4-dynamic-uuid-v5-2-8a83de3fe3dc@linaro.org>
In-Reply-To: <20240719-b4-dynamic-uuid-v5-2-8a83de3fe3dc@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 25 Jul 2024 13:13:46 +0300
Message-ID: <CAC_iWjK1j0hG7jurTEPLKoYLPCL5JuUhRUoBwohUr=U93rb6dQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] lib: uuid: add UUID v5 support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
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

On Fri, 19 Jul 2024 at 15:43, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Add support for generating version 5 UUIDs, these are determistic and work
> by hashing a "namespace" UUID together with some unique data. One intended
> usecase is to allow for dynamically generate payload UUIDs for UEFI
> capsule updates, so that supported boards can have their own UUIDs
> without needing to hardcode them.
>
> In addition, move the common bit twiddling code from gen_ran_uuid into a
> separate function and rewrite it not to use clrsetbits (which is not
> available when building as part of host tools).
>
> Tests for this are added in an upcoming patch.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  include/uuid.h | 17 +++++++++++++++--
>  lib/Kconfig    |  1 +
>  lib/uuid.c     | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++-------
>  3 files changed, 67 insertions(+), 9 deletions(-)
>
> diff --git a/include/uuid.h b/include/uuid.h
> index f5a941250f48..1f4fa103b5e9 100644
> --- a/include/uuid.h
> +++ b/include/uuid.h
> @@ -10,8 +10,9 @@
>  #ifndef __UUID_H__
>  #define __UUID_H__
>
>  #include <linux/bitops.h>
> +#include <linux/kconfig.h>
>
>  /*
>   * UUID - Universally Unique IDentifier - 128 bits unique number.
>   *        There are 5 versions and one variant of UUID defined by RFC4122
> @@ -45,10 +46,10 @@
>   * where x is a hexadecimal character. Fields are separated by '-'s.
>   * When converting to a binary UUID, le means the field should be converted
>   * to little endian and be means it should be converted to big endian.
>   *
> - * UUID is also used as GUID (Globally Unique Identifier) with the same binary
> - * format but it differs in string format like below.
> + * UUID is also used as GUID (Globally Unique Identifier) with the same format
> + * but with some fields stored in little endian.
>   *
>   * GUID:
>   * 0        9    14   19   24
>   * xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
> @@ -142,8 +143,20 @@ void gen_rand_uuid(unsigned char *uuid_bin);
>   * @param          - uuid output type: UUID - 0, GUID - 1
>   */
>  void gen_rand_uuid_str(char *uuid_str, int str_format);
>
> +struct efi_guid;
> +
> +/**
> + * gen_v5_guid() - generate little endian v5 GUID from namespace and other seed data.
> + *
> + * @namespace:   pointer to UUID namespace salt
> + * @guid:        pointer to allocated GUID output
> + * @...:         NULL terminated list of seed data as pairs of pointers
> + *               to data and their lengths
> + */
> +void gen_v5_guid(const struct uuid *namespace, struct efi_guid *guid, ...);
> +
>  /**
>   * uuid_str_to_le_bin() - Convert string UUID to little endian binary data.
>   * @uuid_str:  pointer to UUID string
>   * @uuid_bin:  pointer to allocated array for little endian output [16B]
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 2059219a1207..5a48c016d2c5 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -72,8 +72,9 @@ config HAVE_PRIVATE_LIBGCC
>         bool
>
>  config LIB_UUID
>         bool
> +       select SHA1
>
>  config RANDOM_UUID
>         bool "GPT Random UUID generation"
>         select LIB_UUID
> diff --git a/lib/uuid.c b/lib/uuid.c
> index dfa2320ba267..7d0a8273d157 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -21,8 +21,9 @@
>  #include <part_efi.h>
>  #include <malloc.h>
>  #include <dm/uclass.h>
>  #include <rng.h>
> +#include <u-boot/sha1.h>
>
>  int uuid_str_valid(const char *uuid)
>  {
>         int i, valid;
> @@ -368,8 +369,57 @@ void uuid_bin_to_str(const unsigned char *uuid_bin, char *uuid_str,
>                 }
>         }
>  }
>
> +static void configure_uuid(struct uuid *uuid, unsigned char version)
> +{
> +       uint16_t tmp;
> +
> +       /* Configure variant/version bits */
> +       tmp = be16_to_cpu(uuid->time_hi_and_version);
> +       tmp = (tmp & ~UUID_VERSION_MASK) | (version << UUID_VERSION_SHIFT);
> +       uuid->time_hi_and_version = cpu_to_be16(tmp);
> +
> +       uuid->clock_seq_hi_and_reserved &= ~UUID_VARIANT_MASK;
> +       uuid->clock_seq_hi_and_reserved |= (UUID_VARIANT << UUID_VARIANT_SHIFT);
> +}
> +
> +void gen_v5_guid(const struct uuid *namespace, struct efi_guid *guid, ...)
> +{
> +       sha1_context ctx;
> +       va_list args;
> +       const uint8_t *data;
> +       uint32_t *tmp32;
> +       uint16_t *tmp16;
> +       uint8_t hash[SHA1_SUM_LEN];
> +
> +       sha1_starts(&ctx);
> +       /* Hash the namespace UUID as salt */
> +       sha1_update(&ctx, (unsigned char *)namespace, UUID_BIN_LEN);
> +       va_start(args, guid);
> +
> +       while ((data = va_arg(args, const uint8_t *))) {
> +               unsigned int len = va_arg(args, size_t);
> +               sha1_update(&ctx, data, len);
> +       }
> +
> +       va_end(args);
> +       sha1_finish(&ctx, hash);
> +
> +       /* Truncate the hash into output UUID, it is already big endian */
> +       memcpy(guid, hash, sizeof(*guid));
> +
> +       configure_uuid((struct uuid *)guid, 5);
> +
> +       /* Make little endian */
> +       tmp32 = (uint32_t *)&guid->b[0];
> +       *tmp32 = be32_to_cpu(*tmp32);
> +       tmp16 = (uint16_t *)&guid->b[4];
> +       *tmp16 = be16_to_cpu(*tmp16);
> +       tmp16 = (uint16_t *)&guid->b[6];
> +       *tmp16 = be16_to_cpu(*tmp16);

you need to explicitly convert those to LE, instead of relying to the
native cpu endianess here

cheers
/Ilias
> +}
> +
>  #if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
>  void gen_rand_uuid(unsigned char *uuid_bin)
>  {
>         u32 ptr[4];
> @@ -394,15 +444,9 @@ void gen_rand_uuid(unsigned char *uuid_bin)
>         /* Set all fields randomly */
>         for (i = 0; i < 4; i++)
>                 ptr[i] = rand();
>
> -       clrsetbits_be16(&uuid->time_hi_and_version,
> -                       UUID_VERSION_MASK,
> -                       UUID_VERSION << UUID_VERSION_SHIFT);
> -
> -       clrsetbits_8(&uuid->clock_seq_hi_and_reserved,
> -                    UUID_VARIANT_MASK,
> -                    UUID_VARIANT << UUID_VARIANT_SHIFT);
> +       configure_uuid(uuid, UUID_VERSION);
>
>         memcpy(uuid_bin, uuid, 16);
>  }
>
>
> --
> 2.45.2
>
