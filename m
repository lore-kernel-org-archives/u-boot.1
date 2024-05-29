Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B62C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 16:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8717886A4;
	Wed, 29 May 2024 18:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VXW99i2N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAEEC8860B; Wed, 29 May 2024 18:30:21 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 638728861A
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 18:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6ab9d00f727so11242586d6.1
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 09:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717000218; x=1717605018; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fe3RWtp6dsHvu7G141OVir56uvxZQ5bOovCsL14dwyo=;
 b=VXW99i2NsbkjuAeA/v+O4dl3PfRcrbApjmCE+09cz1bLmloR7uqAEmoOZWQL0w06Aj
 a8WJMrje7sgGNHj36GgSgEi6glfoVhPjM+orPK6m+VQDM2581c+5NIEorCeMsLImKEf2
 CIXB+fQ2jHoXJ8qjJ7U+eVzYHpSw7RIqnEy4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717000218; x=1717605018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fe3RWtp6dsHvu7G141OVir56uvxZQ5bOovCsL14dwyo=;
 b=rDCCmYvmZhveoxj4KQ5PZ/sT6Is8+mFUJKrSRK+e9T5zf+1WZRSJj5TSRL1uzriOSD
 /DYOlE/H2ZEmRPHOF0vyJvVgXbmCJ3VJ0mNzwPnaoIBIIC5zXjnwhg6IN9Ieire0wQNo
 cKTY9Q2i/ZiSxzuiIHJ9/mseZexTu4A0cUnWjwRF7grd25hfBGsUjRH+MXIBZy/TGg2s
 2kVmbBbBhOxqOMhGrymuWuP0DwPqbiY37NF0uCUzCapL7hYjLWpA/CeE5WIL6W9hi/5M
 ERFdO+sh/yiOH7G7L7cTCKbJUBx/GizESi4ScUSkcqKUNY95Mw+b9z9rPyRBP6qoYCyW
 vF9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXovUCP4p9jvzp77Cs9kq3XQPLBLgImjTYq74uJSXUSAt6FNFEsgUXIcpMTFC7IZW+SjBcZWkIcdLsyO2qJY1makkNPsg==
X-Gm-Message-State: AOJu0Yzxa3uYx3QIkY4SpSzZKl2wmQsPZU134F0NzHXZ3VqZEsRcAZfm
 KdE/ExHtDY3NHpY7huKf2x8X0HgvrGCdp6ZW+hcfdN1ZHlCvfHEE2DstzMeuXKpE6GLG/AZ36xW
 9LS81GJA5mnGEz3A+Gzb4CiQ+UZTOwn7pTcoS
X-Google-Smtp-Source: AGHT+IHlEyyGkFZ7HHlJLmoZl3kl+HL+dI8YhCBrrR+vmfYmLq3/egfTvplXTs+KJKAL21toBAQlTV+kApHGbFHl4do=
X-Received: by 2002:a05:6214:4a07:b0:6a0:b3cc:ee48 with SMTP id
 6a1803df08f44-6abc8cd1be4mr189349076d6.37.1717000218047; Wed, 29 May 2024
 09:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
 <20240529-b4-dynamic-uuid-v2-1-c26f31057bbe@linaro.org>
In-Reply-To: <20240529-b4-dynamic-uuid-v2-1-c26f31057bbe@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 May 2024 10:30:07 -0600
Message-ID: <CAFLszTj2Ea8_oFaewsZ8bjNe3T3T9dfYbvFJ6wsw88B1HqDG8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] lib: uuid: add UUID v5 support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 29 May 2024 18:32:00 +0200
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

Hi Caleb,

On Wed, 29 May 2024 at 08:49, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Add support for generate version 5 UUIDs, these are determistic and work

spelling

> by hashing a "namespace" UUID together with some unique data. One intended
> usecase is to allow for dynamically generate payload UUIDs for UEFI
> capsule updates, so that supported boards can have their own UUIDs
> without needing to hardcode them.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  include/uuid.h | 17 +++++++++++++++++
>  lib/Kconfig    |  8 ++++++++
>  lib/uuid.c     | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 62 insertions(+)
>

Can you please mention the tests for this? I believe they are in your
last commit?

> diff --git a/include/uuid.h b/include/uuid.h
> index f5a941250f48..539affaa47b9 100644
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
> @@ -142,8 +143,24 @@ void gen_rand_uuid(unsigned char *uuid_bin);
>   * @param          - uuid output type: UUID - 0, GUID - 1
>   */
>  void gen_rand_uuid_str(char *uuid_str, int str_format);
>
> +#if IS_ENABLED(CONFIG_UUID_GEN_V5)
> +/**
> + * gen_uuid_v5() - generate UUID v5 from namespace and other seed data.
> + *
> + * @namespace:   pointer to UUID namespace salt
> + * @uuid:        pointer to allocated UUID output
> + * @...:         NULL terminated list of seed data as pairs of pointers
> + *               to data and their lengths
> + */
> +void gen_uuid_v5(const struct uuid *namespace, struct uuid *uuid, ...);
> +#else
> +static inline void gen_uuid_v5(const struct uuid *namespace, struct uuid *uuid, ...)
> +{
> +}
> +#endif
> +
>  /**
>   * uuid_str_to_le_bin() - Convert string UUID to little endian binary data.
>   * @uuid_str:  pointer to UUID string
>   * @uuid_bin:  pointer to allocated array for little endian output [16B]
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 189e6eb31aa1..2941532f25cf 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -80,8 +80,16 @@ config RANDOM_UUID
>         help
>           Enable the generation of partitions with random UUIDs if none
>           are provided.
>
> +config UUID_GEN_V5
> +       bool "Enable UUID version 5 generation"
> +       select LIB_UUID
> +       depends on SHA1
> +       help
> +         Enable the generation of version 5 UUIDs, these are determistic and
> +         generated from a namespace UUID, and a string (such as a board name).
> +
>  config SPL_LIB_UUID
>         depends on SPL
>         bool
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index dfa2320ba267..6ef006cca1da 100644
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
> @@ -368,8 +369,44 @@ void uuid_bin_to_str(const unsigned char *uuid_bin, char *uuid_str,
>                 }
>         }
>  }
>
> +#if IS_ENABLED(CONFIG_UUID_GEN_V5)
> +void gen_uuid_v5(const struct uuid *namespace, struct uuid *uuid, ...)

Is this in a header file somewhere? It needs a function comment there.

> +{
> +       sha1_context ctx;
> +       va_list args;
> +       const uint8_t *data;
> +       uint8_t hash[SHA1_SUM_LEN];
> +       uint32_t tmp;
> +
> +       sha1_starts(&ctx);
> +       /* Hash the namespace UUID as salt */
> +       sha1_update(&ctx, (unsigned char *)namespace, UUID_BIN_LEN);
> +       va_start(args, uuid);
> +
> +       while ((data = va_arg(args, const uint8_t *))) {
> +               size_t len = va_arg(args, size_t);
> +
> +               sha1_update(&ctx, data, len);
> +       }
> +
> +       va_end(args);
> +       sha1_finish(&ctx, hash);
> +
> +       /* Truncate the hash into output UUID, it is already big endian */
> +       memcpy(uuid, hash, sizeof(*uuid));
> +
> +       /* Configure variant/version bits */
> +       tmp = be32_to_cpu(uuid->time_hi_and_version);
> +       tmp = (tmp & ~UUID_VERSION_MASK) | (5 << UUID_VERSION_SHIFT);
> +       uuid->time_hi_and_version = cpu_to_be32(tmp);
> +
> +       uuid->clock_seq_hi_and_reserved &= UUID_VARIANT_MASK;
> +       uuid->clock_seq_hi_and_reserved |= UUID_VARIANT << UUID_VARIANT_SHIFT;
> +}
> +#endif
> +
>  #if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
>  void gen_rand_uuid(unsigned char *uuid_bin)
>  {
>         u32 ptr[4];
>
> --
> 2.45.0
>

Regards,
Simon
