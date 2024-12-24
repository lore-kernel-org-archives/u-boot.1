Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE081E77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 07:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F4EA80711;
	Tue, 24 Dec 2024 08:08:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lLDlYmrR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D00280786; Tue, 24 Dec 2024 08:08:29 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF26280708
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 08:08:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e53aa843a24so2333287276.0
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 23:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735024105; x=1735628905; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oV7kps0egqWx9utKeFLwabpjTI0EIegCQ/doBSfmxrQ=;
 b=lLDlYmrROjLySTEnNzAZ5KN3KkOd3et87a/5YUNK9DsKpneT0QtgivKRdCxOsDHAbe
 +vBKYaTjWoVqmy0pxBKl0zvN1EHu3QBds7s6a/a9eHzkCAZ1luKzgO1kxNxdEuhJ2OBO
 zCuJhvPLcunnACvWflo2C6N7qH19fYf66XhflefPrDEwfCFoK8lKfQ2ucWXWl5xujkYK
 Ty6vnrNKEG4ty1eaG/aFs3vDUbflihDlDxtK/nB+8kEPxvmF49VELMF3L0v+5/DrNBBG
 Fi4Ic397inI7a7x/VyepqMV4qBLFrm4IyceUcjcwUyiqjUJTvI2yfFNu5MEnsWYwNdPu
 UmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735024105; x=1735628905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oV7kps0egqWx9utKeFLwabpjTI0EIegCQ/doBSfmxrQ=;
 b=Mfm9H1P2huARsBQNVQrCBWX6mh50uqU8/8PUwv1L0zGK8qVaafe6FPqj7a28cs23tQ
 3BRPw5QW5G8bwhG+aWFEjSiDJTD9cJIgXX7RXiLGw/m3iWbyGdhk873BmSOKMVE/kF1B
 j+fW9Mx1K3RDTFzJs/ABzI6akAhQaUTQ2Yx+6FEYaR6BAheaBj7ISeGspiqwEJoBnSH2
 UT4ck6eaGH0WVQxBEuVPuMLWP7If74eNhdxCa0g4dwbJa/YkK8V+Jx7CY7GGDcFCpBBn
 ego8b8QpHpW3b8XXNde+TlbIznt0gHZH/QrFfRJ2y6SXmuy7QLu9kZQuazqIWzmMklE1
 stJA==
X-Gm-Message-State: AOJu0Ywz+x7YkwQlp+XoypVUaSjif5goHfKTUcUWb68QzxCLgFlQ4POS
 U2F54uzSVJV7KYEh2hHoy0EiUMkMaIrQ+yY9DRQHZuOiYVXQteCRunFZmTiz+y8BztHS11GhstO
 cStLEgdSNO2kL+m9Z2WqkU2NI/lO/Q231lQNdKg==
X-Gm-Gg: ASbGnctG3LdDKDU7pPDgs3FUz2tiprWcmjRpv6kd2e07m8cRSf/hhyp4L6gWIlx9EVH
 QOuQjLu+asbWd4M+QkI7fDaB1byF8LbFqSnwgZw==
X-Google-Smtp-Source: AGHT+IHqZ6L+ii+Vvmfsuvltaf2DFPBqkulAyX74QXWk8aKviuxZQ4woD+DrddrblO+SaU2chQlniGF0YIjfdM83IQA=
X-Received: by 2002:a25:744f:0:b0:e53:7c95:2894 with SMTP id
 3f1490d57ef6-e537c952ae1mr14199410276.24.1735024105599; Mon, 23 Dec 2024
 23:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20241223144737.554992-1-raymond.mao@linaro.org>
 <20241223144737.554992-6-raymond.mao@linaro.org>
In-Reply-To: <20241223144737.554992-6-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 24 Dec 2024 09:07:49 +0200
Message-ID: <CAC_iWjKy-4-MEQVXt19hk-TRwD5DHRiBgd_Rpco_QAZQa86H9Q@mail.gmail.com>
Subject: Re: [PATCH 05/11] tpm: add flag in hash_algo_list and API to check if
 algorithm is supported
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tim Harvey <tharvey@gateworks.com>, 
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>, 
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

On Mon, 23 Dec 2024 at 16:48, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Add a bool var into hash_algo_list to indicate whether the algorithm
> is supported or not and move the IS_ENABLED to only cover this var.
> So that we can have the name, hash, mask and size no matter the
> digest kconfigs are enabled or not.
>
> In before, tpm2_algorithm_to_len() and tcg2_algorithm_to_mask() are used to
> identify an unsupported algorithm when they return 0.
> It is not the case now when hash_algo_list always provides algorithm size
> and mask, thus a new API is introduced to check if an algorithm is
> supported by U-Boot.
>
> Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  include/tpm-v2.h | 37 +++++++++++++++++++++++++++++--------
>  lib/tpm-v2.c     | 14 +++++++++++++-
>  lib/tpm_tcg2.c   | 17 +++++++++--------
>  3 files changed, 51 insertions(+), 17 deletions(-)
>
> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> index 87b2c614ad..c49eadda26 100644
> --- a/include/tpm-v2.h
> +++ b/include/tpm-v2.h
> @@ -268,6 +268,7 @@ struct digest_info {
>         u16 hash_alg;
>         u32 hash_mask;
>         u16 hash_len;
> +       bool supported;
>  };
>
>  /* Algorithm Registry */
> @@ -278,38 +279,50 @@ struct digest_info {
>  #define TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
>
>  static const struct digest_info hash_algo_list[] = {
> -#if IS_ENABLED(CONFIG_SHA1)
>         {
>                 "sha1",
>                 TPM2_ALG_SHA1,
>                 TCG2_BOOT_HASH_ALG_SHA1,
>                 TPM2_SHA1_DIGEST_SIZE,
> -       },
> +#if IS_ENABLED(CONFIG_SHA1)
> +               true,
> +#else
> +               false,
>  #endif
> -#if IS_ENABLED(CONFIG_SHA256)
> +       },
>         {
>                 "sha256",
>                 TPM2_ALG_SHA256,
>                 TCG2_BOOT_HASH_ALG_SHA256,
>                 TPM2_SHA256_DIGEST_SIZE,
> -       },
> +#if IS_ENABLED(CONFIG_SHA256)
> +               true,
> +#else
> +               false,
>  #endif
> -#if IS_ENABLED(CONFIG_SHA384)
> +       },
>         {
>                 "sha384",
>                 TPM2_ALG_SHA384,
>                 TCG2_BOOT_HASH_ALG_SHA384,
>                 TPM2_SHA384_DIGEST_SIZE,
> -       },
> +#if IS_ENABLED(CONFIG_SHA384)
> +               true,
> +#else
> +               false,
>  #endif
> -#if IS_ENABLED(CONFIG_SHA512)
> +       },
>         {
>                 "sha512",
>                 TPM2_ALG_SHA512,
>                 TCG2_BOOT_HASH_ALG_SHA512,
>                 TPM2_SHA512_DIGEST_SIZE,
> -       },
> +#if IS_ENABLED(CONFIG_SHA512)
> +               true,
> +#else
> +               false,
>  #endif
> +       },
>  };
>
>  /* NV index attributes */
> @@ -704,6 +717,14 @@ enum tpm2_algorithms tpm2_name_to_algorithm(const char *name);
>   */
>  const char *tpm2_algorithm_name(enum tpm2_algorithms);
>
> +/**
> + * tpm2_algorithm_supported() -  Check if the algorithm supported by U-Boot
> + *
> + * @algorithm_id: algorithm defined in enum tpm2_algorithms
> + * Return: true if supported, otherwise false
> + */
> +bool tpm2_algorithm_supported(enum tpm2_algorithms algo);
> +
>  /**
>   * tpm2_algorithm_to_len() - Return an algorithm length for supported algorithm id
>   *
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 0edb0aa90c..96c164f2a5 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -884,6 +884,18 @@ const char *tpm2_algorithm_name(enum tpm2_algorithms algo)
>         return "";
>  }
>
> +bool tpm2_algorithm_supported(enum tpm2_algorithms algo)
> +{
> +       size_t i;
> +
> +       for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
> +               if (hash_algo_list[i].hash_alg == algo)
> +                       return hash_algo_list[i].supported;
> +       }
> +
> +       return false;
> +}
> +
>  u16 tpm2_algorithm_to_len(enum tpm2_algorithms algo)
>  {
>         size_t i;
> @@ -908,7 +920,7 @@ bool tpm2_check_active_banks(struct udevice *dev)
>
>         for (i = 0; i < pcrs.count; i++) {
>                 if (tpm2_is_active_bank(&pcrs.selection[i]) &&
> -                   !tpm2_algorithm_to_len(pcrs.selection[i].hash))
> +                   !tpm2_algorithm_supported(pcrs.selection[i].hash))
>                         return false;
>         }
>
> diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> index 16f41cbfd1..4682f7664f 100644
> --- a/lib/tpm_tcg2.c
> +++ b/lib/tpm_tcg2.c
> @@ -37,16 +37,17 @@ int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32 *active_bank
>                 return ret;
>
>         for (i = 0; i < pcrs.count; i++) {
> -               u32 hash_mask = tcg2_algorithm_to_mask(pcrs.selection[i].hash);
> +               struct tpms_pcr_selection *sel = &pcrs.selection[i];
> +               u32 hash_mask = tcg2_algorithm_to_mask(sel->hash);
>
> -               if (hash_mask) {
> +               if (tpm2_algorithm_supported(sel->hash))
>                         *supported_bank |= hash_mask;
> -                       if (tpm2_is_active_bank(&pcrs.selection[i]))
> -                               *active_bank |= hash_mask;
> -               } else {
> -                       printf("%s: unknown algorithm %x\n", __func__,
> -                              pcrs.selection[i].hash);
> -               }
> +               else
> +                       log_warning("%s: unknown algorithm %x\n", __func__,
> +                                   sel->hash);
> +
> +               if (tpm2_is_active_bank(sel))
> +                       *active_bank |= hash_mask;
>         }
>
>         *bank_num = pcrs.count;
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
