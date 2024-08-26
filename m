Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F4BC5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 15:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0E968891B;
	Mon, 26 Aug 2024 17:46:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fsFoIywh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A4588A35; Mon, 26 Aug 2024 17:46:45 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D60FD888F0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 17:46:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2d3b595c18dso3917761a91.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724687201; x=1725292001; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rp2flyQD+6GxX4DiRI5AxUhh4W8mcetuY4Cr6p+N9Jk=;
 b=fsFoIywhX2ryYK1Om9MNWmG7NtMWgpll49LFxcZyUGB8df4TDop4Kqh6XcrZUp5ruf
 WFapFjpUdqq2qpE+9Hn8U9JF+/GRK0V9MeuniAzH70TTrOGvkRab+px06klrNgTBMM7T
 Fkf11d83kid8x6y4muyna9FUPS+CLrgTIuQehZT9qrzKjeeqKQQ/K4YbWuyR4s8mhUeG
 aLzCGVBQxgI3q7WgQaCObJcBHcP35Fn0vowkxNuuj6zjsgwtd3hr7ZtUgje1B8y5AH2r
 D3W44gYdXqaSFWQHhdQisTwjRrqDopqBCACIojRcuEPriUmbEMY9szyl4ShzKmmaf1ZO
 s3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724687201; x=1725292001;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rp2flyQD+6GxX4DiRI5AxUhh4W8mcetuY4Cr6p+N9Jk=;
 b=Y7tEi4uG15+WljZCBPCzgPYUbKmzyHzPhZfGUpbdW2BZ+yvC/qYTkWfkfR/6l47CDa
 5uSwYQkDniRpeA0Lsr4Kxw8YBSgUHhOg84WseyFZdrNQxzZTt1RyNkwCKbbYNTaqdOY/
 E19WsXdRGST8bwk+s802EIS6vmJUNCdRokLRDL6dvRTpWO7oaSIntIKiIYl9WSLOoByS
 7D8uWFTaIIBJpaFpYvM04QEVQzEbZslllLV0yHWLSky4A5NfVdpI0FBt/MhqlLF6dFur
 sMlK5Wj4UwSh42eD+aLEPsg0r7TVLtTF6RyO0eOz+AW9ZRS8ifSMRjE39gXQxwvvhAMT
 5S4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUenuR8gJSYVsi1AJofXiKBQvh2a+Rt7y9hXjp+GXKQ/VdXjY9EPUGjuJUu7aqDEvmTwyeoiUY=@lists.denx.de
X-Gm-Message-State: AOJu0YzyR7JcQpVqtp4ffPcJK5QkfRbC0YUxS6PoI/RGVV6jlhTQZB2l
 Rch/FIQH1/qB5IHYhqcjbti2EdGckpFooTjQjDLBwML9l0NkcI9NJrpguFuNoQzetUfemOZCrpI
 X4VF/cOlpOlUloLTDV8daroklZO1Gkvs/YDWh8Q==
X-Google-Smtp-Source: AGHT+IGfYRCr3iPVx8aMG5p8C9nxUATAbqveDVVzQghzDdyTz8Eqtf2jCqlm1OkPhBHqzZmJIGzuwxMuOZoLKUWFNvQ=
X-Received: by 2002:a17:90b:3116:b0:2d3:c365:53b1 with SMTP id
 98e67ed59e1d1-2d824a4e1aamr94234a91.6.1724687201109; Mon, 26 Aug 2024
 08:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
 <20240809-b4-dynamic-uuid-v7-2-8c44ab1f06a5@linaro.org>
In-Reply-To: <20240809-b4-dynamic-uuid-v7-2-8c44ab1f06a5@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Aug 2024 18:46:04 +0300
Message-ID: <CAC_iWjK5By+CWYRtiR5tN8Uut7Hps+_mNtrctYLPr5qPbBJR8g@mail.gmail.com>
Subject: Re: [PATCH v7 02/11] lib: uuid: add UUID v5 support
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

On Fri, 9 Aug 2024 at 03:56, Caleb Connolly <caleb.connolly@linaro.org> wrote:
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
> index dfa2320ba267..24b5881600fd 100644
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
> +       *tmp32 = cpu_to_le32(be32_to_cpu(*tmp32));
> +       tmp16 = (uint16_t *)&guid->b[4];
> +       *tmp16 = cpu_to_le16(be16_to_cpu(*tmp16));
> +       tmp16 = (uint16_t *)&guid->b[6];
> +       *tmp16 = cpu_to_le16(be16_to_cpu(*tmp16));
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
> 2.46.0
>

The series doesn't apply over -next or -master. Can you rebase and
resend so I can run the CI?
Also, checkpatch reports some minor issues, make sure you address
those on the rebase


Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
