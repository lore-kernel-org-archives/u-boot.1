Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B20AC25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 10:33:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9A6388047;
	Wed, 22 May 2024 12:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O8sFS/oj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5D4888460; Wed, 22 May 2024 12:33:24 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6F6B87F70
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 12:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-51f2ebbd8a7so7808690e87.2
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 03:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716374002; x=1716978802; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EZ4ogfnnrB3AmC68jbD1WkTto6XGgL+ctwY1kpksFXM=;
 b=O8sFS/ojnNDbtNn6RgWfFKBCUXHaCOxxSfQdIqo3hz7E292YTDpbp10ABbCdIYEDnI
 pjkLQcGPECH6zsNij4Q0sbH67qpxw5ZthzF0L6yLeOszYJrpdztGe18cJuz20iVN4FAV
 //YVboPDwTnSfRJJ7jGezAQY4kD1+fZVqe/6ykEIHIjGaPTkeU3zARVlmQ9pM1NEScFs
 /YahEAJqz019No7xoHmZ3yV5MqHvIh/U9ji5kjnDK+ZLscgbSCmlM/7pcwm78//FMgZL
 GBAr2Oi+ivmirHXFoz8Es7+tsKLz19f5VyP0uWrzTTykkzuz5oh5Q2UgmIedacJ1uBk0
 T8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716374002; x=1716978802;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EZ4ogfnnrB3AmC68jbD1WkTto6XGgL+ctwY1kpksFXM=;
 b=j5+aEtIo8byedtixwmHNwxYR51CTyrV/x0KbANF7aend4m6Hukz32PSg2ekl9CeaC4
 2Or9kTkYhBoIzF2lDeSHkmct74oqFBokTjflbbS7VPw43h0FVaCK9zIfUarrLnCc14aC
 vrXigNAMFrheyuXAsDRPYUZHx084MuLispWUAKFIV7zeK+afkf7k0WYgjicwKp1g/tp1
 fG0snvL1C4oWFo6cecETq8J/tGNxfW2ghVT8EeyRTCPROtsLnfxkOtWi0hm5Y9odXiyG
 f1lPlwq9NKLWUkkiJ0NAVDE89tLbCSimrchzH4r8jMi+IMK20Cw7Bg6pv53d2UWILLX5
 13GQ==
X-Gm-Message-State: AOJu0YyrAVjoGIWwd5480NjCcCSs1xHqBDvEZxYALCAK9xCJqFgb3+So
 qjpj08EvrH/WOQ8kqqKXYMsxOHOSTN9qTGKo1k+MJHDvmOvlq2XkcG/jHizlwRiEHMacXo48lrf
 1KisPr1UheEipzMgh935d/orNQQA3mCjnMv1JSQ==
X-Google-Smtp-Source: AGHT+IGIXqXJkg8zqyG+utFoy5Q6gEqJo7lQykC+z59hv2iOLVIXS+j8G78xIdRO0o1KIvOgv44jKNZXB4OXc+yo1+o=
X-Received: by 2002:ac2:54a8:0:b0:51f:315c:75e0 with SMTP id
 2adb3069b0e04-526bf642e28mr902327e87.44.1716374001774; Wed, 22 May 2024
 03:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240521213842.3587607-1-tharvey@gateworks.com>
In-Reply-To: <20240521213842.3587607-1-tharvey@gateworks.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 22 May 2024 13:32:44 +0300
Message-ID: <CAC_iWjJOgBbT=HdYkAFsQLNoVeQybzQk33n+q2-DTf=h8f2K+w@mail.gmail.com>
Subject: Re: [PATCH 1/2 v4] tpm-v2: add support for mapping algorithm names to
 algos
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Eddie James <eajames@linux.ibm.com>
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

Hi Tim

Thanks for fixing this.

Can we replace tpm2_algorithm_to_mask() with hash_algo_list[i].hash_mask in
- lib/tpm-v2.c lines 80, 205 250
- lib/efi_loader/efi_tcg2.c line 420

With these changes
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


On Wed, 22 May 2024 at 00:38, Tim Harvey <tharvey@gateworks.com> wrote:
>
> replace tpm2_supported_algorithms with an array of structures
> relating algorithm names, to TCG id's, digest length and mask values.
>
> While at it fix the tpm2_algorithm_to_mask to return the proper value.
>
> Fixes: 97707f12fdab ("tpm: Support boot measurements")
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Cc: Eddie James <eajames@linux.ibm.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> v4:
>  - new patch
> ---
>  include/tpm-v2.h          | 77 +++++++++++++++++++++++++++++++++++++--
>  lib/efi_loader/efi_tcg2.c |  4 +-
>  lib/tpm-v2.c              | 74 ++++++++++++++++++++++++++-----------
>  3 files changed, 128 insertions(+), 27 deletions(-)
>
> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> index 33dd103767c4..c9d5cb6d3e5a 100644
> --- a/include/tpm-v2.h
> +++ b/include/tpm-v2.h
> @@ -386,7 +386,54 @@ enum tpm2_algorithms {
>         TPM2_ALG_SM3_256        = 0x12,
>  };
>
> -extern const enum tpm2_algorithms tpm2_supported_algorithms[4];
> +/**
> + * struct digest_info - details of supported digests
> + *
> + * @hash_name:                 hash name
> + * @hash_alg:                  hash algorithm id
> + * @hash_mask:                 hash registry mask
> + * @hash_len:                  hash digest length
> + */
> +struct digest_info {
> +       const char *hash_name;
> +       u16 hash_alg;
> +       u32 hash_mask;
> +       u16 hash_len;
> +};
> +
> +/* Algorithm Registry */
> +#define TCG2_BOOT_HASH_ALG_SHA1    0x00000001
> +#define TCG2_BOOT_HASH_ALG_SHA256  0x00000002
> +#define TCG2_BOOT_HASH_ALG_SHA384  0x00000004
> +#define TCG2_BOOT_HASH_ALG_SHA512  0x00000008
> +#define TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
> +
> +static const struct digest_info hash_algo_list[] = {
> +       {
> +               "sha1",
> +               TPM2_ALG_SHA1,
> +               TCG2_BOOT_HASH_ALG_SHA1,
> +               TPM2_SHA1_DIGEST_SIZE,
> +       },
> +       {
> +               "sha256",
> +               TPM2_ALG_SHA256,
> +               TCG2_BOOT_HASH_ALG_SHA256,
> +               TPM2_SHA256_DIGEST_SIZE,
> +       },
> +       {
> +               "sha384",
> +               TPM2_ALG_SHA384,
> +               TCG2_BOOT_HASH_ALG_SHA384,
> +               TPM2_SHA384_DIGEST_SIZE,
> +       },
> +       {
> +               "sha512",
> +               TPM2_ALG_SHA512,
> +               TCG2_BOOT_HASH_ALG_SHA512,
> +               TPM2_SHA512_DIGEST_SIZE,
> +       },
> +};
>
>  static inline u16 tpm2_algorithm_to_len(enum tpm2_algorithms a)
>  {
> @@ -404,8 +451,6 @@ static inline u16 tpm2_algorithm_to_len(enum tpm2_algorithms a)
>         }
>  }
>
> -#define tpm2_algorithm_to_mask(a)      (1 << (a))
> -
>  /* NV index attributes */
>  enum tpm_index_attrs {
>         TPMA_NV_PPWRITE         = 1UL << 0,
> @@ -965,4 +1010,30 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
>   */
>  u32 tpm2_auto_start(struct udevice *dev);
>
> +/**
> + * tpm2_name_to_algorithm() - Return an algorithm id given a supported
> + *                           algorithm name
> + *
> + * @name: algorithm name
> + * Return: enum tpm2_algorithms or -EINVAL
> + */
> +enum tpm2_algorithms tpm2_name_to_algorithm(const char *name);
> +
> +/**
> + * tpm2_algorithm_name() - Return an algorithm name string for a
> + *                        supported algorithm id
> + *
> + * @algorithm_id: algorithm defined in enum tpm2_algorithms
> + * Return: algorithm name string or ""
> + */
> +const char *tpm2_algorithm_name(enum tpm2_algorithms);
> +
> +/**
> + * tpm2_algorithm_to_mask() - Get a TCG hash mask for algorithm
> + *
> + * @hash_alg: TCG defined algorithm
> + * Return: TCG hashing algorithm bitmaps (or 0 if algo not supported)
> + */
> +u32 tpm2_algorithm_to_mask(enum tpm2_algorithms);
> +
>  #endif /* __TPM_V2_H */
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index b07e0099c27e..cf5d8de018a7 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -414,8 +414,8 @@ static efi_status_t tcg2_hash_pe_image(void *efi, u64 efi_size,
>         }
>
>         digest_list->count = 0;
> -       for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); i++) {
> -               u16 hash_alg = tpm2_supported_algorithms[i];
> +       for (i = 0; i < ARRAY_SIZE(hash_algo_list); i++) {
> +               u16 hash_alg = hash_algo_list[i].hash_alg;
>
>                 if (!(active & tpm2_algorithm_to_mask(hash_alg)))
>                         continue;
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 68eaaa639f89..2fc680a8adf8 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -22,13 +22,6 @@
>
>  #include "tpm-utils.h"
>
> -const enum tpm2_algorithms tpm2_supported_algorithms[4] = {
> -       TPM2_ALG_SHA1,
> -       TPM2_ALG_SHA256,
> -       TPM2_ALG_SHA384,
> -       TPM2_ALG_SHA512,
> -};
> -
>  int tcg2_get_active_pcr_banks(struct udevice *dev, u32 *active_pcr_banks)
>  {
>         u32 supported = 0;
> @@ -82,14 +75,14 @@ int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
>                 return rc;
>
>         digest_list->count = 0;
> -       for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i) {
> +       for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
>                 u32 mask =
> -                       tpm2_algorithm_to_mask(tpm2_supported_algorithms[i]);
> +                       tpm2_algorithm_to_mask(hash_algo_list[i].hash_alg);
>
>                 if (!(active & mask))
>                         continue;
>
> -               switch (tpm2_supported_algorithms[i]) {
> +               switch (hash_algo_list[i].hash_alg) {
>                 case TPM2_ALG_SHA1:
>                         sha1_starts(&ctx);
>                         sha1_update(&ctx, input, length);
> @@ -116,12 +109,12 @@ int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
>                         break;
>                 default:
>                         printf("%s: unsupported algorithm %x\n", __func__,
> -                              tpm2_supported_algorithms[i]);
> +                              hash_algo_list[i].hash_alg);
>                         continue;
>                 }
>
>                 digest_list->digests[digest_list->count].hash_alg =
> -                       tpm2_supported_algorithms[i];
> +                       hash_algo_list[i].hash_alg;
>                 memcpy(&digest_list->digests[digest_list->count].digest, final,
>                        len);
>                 digest_list->count++;
> @@ -208,13 +201,13 @@ static int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
>                 return rc;
>
>         event_size = offsetof(struct tcg_efi_spec_id_event, digest_sizes);
> -       for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i) {
> -               mask = tpm2_algorithm_to_mask(tpm2_supported_algorithms[i]);
> +       for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
> +               mask = tpm2_algorithm_to_mask(hash_algo_list[i].hash_alg);
>
>                 if (!(active & mask))
>                         continue;
>
> -               switch (tpm2_supported_algorithms[i]) {
> +               switch (hash_algo_list[i].hash_alg) {
>                 case TPM2_ALG_SHA1:
>                 case TPM2_ALG_SHA256:
>                 case TPM2_ALG_SHA384:
> @@ -253,17 +246,17 @@ static int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
>         put_unaligned_le32(count, &ev->number_of_algorithms);
>
>         count = 0;
> -       for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i) {
> -               mask = tpm2_algorithm_to_mask(tpm2_supported_algorithms[i]);
> +       for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
> +               mask = tpm2_algorithm_to_mask(hash_algo_list[i].hash_alg);
>
>                 if (!(active & mask))
>                         continue;
>
> -               len = tpm2_algorithm_to_len(tpm2_supported_algorithms[i]);
> +               len = hash_algo_list[i].hash_len;
>                 if (!len)
>                         continue;
>
> -               put_unaligned_le16(tpm2_supported_algorithms[i],
> +               put_unaligned_le16(hash_algo_list[i].hash_alg,
>                                    &ev->digest_sizes[count].algorithm_id);
>                 put_unaligned_le16(len, &ev->digest_sizes[count].digest_size);
>                 count++;
> @@ -304,7 +297,7 @@ static int tcg2_replay_eventlog(struct tcg2_event_log *elog,
>                 pos = offsetof(struct tcg_pcr_event2, digests) +
>                         offsetof(struct tpml_digest_values, count);
>                 count = get_unaligned_le32(log + pos);
> -               if (count > ARRAY_SIZE(tpm2_supported_algorithms) ||
> +               if (count > ARRAY_SIZE(hash_algo_list) ||
>                     (digest_list->count && digest_list->count != count))
>                         return 0;
>
> @@ -407,7 +400,7 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
>                 return 0;
>
>         count = get_unaligned_le32(&event->number_of_algorithms);
> -       if (count > ARRAY_SIZE(tpm2_supported_algorithms))
> +       if (count > ARRAY_SIZE(hash_algo_list))
>                 return 0;
>
>         calc_size = offsetof(struct tcg_efi_spec_id_event, digest_sizes) +
> @@ -1110,7 +1103,7 @@ int tpm2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
>          * We only support 5 algorithms for now so check against that
>          * instead of TPM2_NUM_PCR_BANKS
>          */
> -       if (pcrs.count > ARRAY_SIZE(tpm2_supported_algorithms) ||
> +       if (pcrs.count > ARRAY_SIZE(hash_algo_list) ||
>             pcrs.count < 1) {
>                 printf("%s: too many pcrs: %u\n", __func__, pcrs.count);
>                 return -EMSGSIZE;
> @@ -1555,3 +1548,40 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
>
>         return 0;
>  }
> +
> +enum tpm2_algorithms tpm2_name_to_algorithm(const char *name)
> +{
> +       size_t i;
> +
> +       for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
> +               if (!strcasecmp(name, hash_algo_list[i].hash_name))
> +                       return hash_algo_list[i].hash_alg;
> +       }
> +       printf("%s: unsupported algorithm %s\n", __func__, name);
> +
> +       return -EINVAL;
> +}
> +
> +const char *tpm2_algorithm_name(enum tpm2_algorithms algo)
> +{
> +       size_t i;
> +
> +       for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
> +               if (hash_algo_list[i].hash_alg == algo)
> +                       return hash_algo_list[i].hash_name;
> +       }
> +
> +       return "";
> +}
> +
> +u32 tpm2_algorithm_to_mask(enum tpm2_algorithms algo)
> +{
> +       size_t i;
> +
> +       for (i = 0; i < ARRAY_SIZE(hash_algo_list); i++) {
> +               if (hash_algo_list[i].hash_alg == algo)
> +                       return hash_algo_list[i].hash_mask;
> +       }
> +
> +       return 0;
> +}
> --
> 2.25.1
>
