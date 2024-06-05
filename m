Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9440CC25B78
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 02:14:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A64D388308;
	Wed,  5 Jun 2024 04:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jZQ57oTc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3852A882E0; Wed,  5 Jun 2024 04:13:47 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AFCF88260
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 04:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-62a2424ecb8so21012477b3.1
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 19:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717553624; x=1718158424; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yxsud4Nwz+dVJSpZJ6yymTm607rPQ8CHQ1YsHh46bLs=;
 b=jZQ57oTc2G1a+CB1rK82UN3kE0w1wzQSM6hj3iQah2o1863f4NaBKLyQh7pRK1tvEX
 w8MQQBYQhILLU3mYxp35h3Puzud+K0Czie7VnxwR7vAP3PKJ75Uoz2eD8effbltCkDsK
 LSmR9Rg/wYzeds1r2ts6iVxTvpTWck37pBCIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717553624; x=1718158424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yxsud4Nwz+dVJSpZJ6yymTm607rPQ8CHQ1YsHh46bLs=;
 b=evXGdgsgnbP80bO3hd3spJ7UcZTA8DCWTpElvq748j95jzry49uKVfIv7SS0EuXnjw
 Qv1pcbnD9u9aEjHL2WWt3rLnQ2iVfwtTrXpvDtV2ujACD8OE3nMKLbVW5rwbTlnN3Akm
 G43100ugVE1nx/NK54wjnJK9clW4e1llO77n+o+5ul2OmLjsTf0ViPttgcTX1ArHNV14
 CphmfRzEOGVy0Q34yEeQcJbLhm98lkx9Z5L9I8c1m5WLIgnSn5iXpfc6aELkdwmlCupD
 oDNgxw05zpmTr9ztet4jTmdLBSeRiz+chEDEhUq1HH97QrrMiDAxfW858Ohvw2giQpZJ
 peUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnkWO62WTMYg7V3CjvkNtFTYYgOAxIBOjendV1ficj4hMx3HCw37IztvmRarkv14GG39BIoanM1vcigDxKsIY32VkfIg==
X-Gm-Message-State: AOJu0YyJv3qbuvg+1z2vn+I5jGR/hT9jC1ZD94M/BrdS3YvesBES5AsH
 GWKOOVP1NOSBh8RK1wdkYDtpdfQampL8Cdcy/TYy259lxdhSE7POGJcfOJz8llLuHkPjw8k/+eu
 aSuB+S1pHJGXuEA/MmNbsmM8rc03lku0hgn0F
X-Google-Smtp-Source: AGHT+IE5mDs+yUnxgF+RXJl39bd7TMrYWSt8C6hoJ4XDjtJG+qR+j3iCWfr51LGuHrXRpio++aZLuDKI2EqPxfpPw0s=
X-Received: by 2002:a0d:d54e:0:b0:622:c8ef:ddb5 with SMTP id
 00721157ae682-62cbb4bb3c0mr12862697b3.8.1717553623653; Tue, 04 Jun 2024
 19:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <20240531-b4-dynamic-uuid-v3-1-ca4a4865db00@linaro.org>
In-Reply-To: <20240531-b4-dynamic-uuid-v3-1-ca4a4865db00@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Jun 2024 20:13:33 -0600
Message-ID: <CAFLszTj=yu5AGBDv7K7ir=_dCGzsZ1Zc3UXafxSDTM0wKZ=pNw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] lib: uuid: add UUID v5 support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, 
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

Hi Caleb,

On Fri, 31 May 2024 at 07:50, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Add support for generating version 5 UUIDs, these are determistic and work

spelling

> by hashing a "namespace" UUID together with some unique data. One intended
> usecase is to allow for dynamically generate payload UUIDs for UEFI
> capsule updates, so that supported boards can have their own UUIDs
> without needing to hardcode them.
>
> Tests for this are added in an upcoming patch.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  include/uuid.h | 17 +++++++++++++++++
>  lib/Kconfig    |  8 ++++++++
>  lib/uuid.c     | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 62 insertions(+)
>
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

Can you explain somewhere why the static inline is needed?

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

spelling

> +         generated from a namespace UUID, and a string (such as a board name).
> +
>  config SPL_LIB_UUID
>         depends on SPL
>         bool
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index dfa2320ba267..2df0523e717f 100644
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
> +               unsigned int len = va_arg(args, size_t);
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
