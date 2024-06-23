Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE3EC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 21:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C8CD88405;
	Sun, 23 Jun 2024 23:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XeTG0fRw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8111C88365; Sun, 23 Jun 2024 23:52:29 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6985C8823C
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 23:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6b5136965a7so16715716d6.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 14:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719179545; x=1719784345; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BucTsvsvb3t+EGwwmFCESNlAToGQTamjKbBCFtFdoHA=;
 b=XeTG0fRwc+HqDtiiV3cV5xdaQL4fAn2EwEZnSz06kCOOzeGHEvIo9Tk7KtJHAthCBc
 tul0q7zRxisKtugSUiejZUcF09PcUnNdLnRyTCYMXTCu4Xae4hSTrYbT3lZQyBqJT3Kv
 Mw6pvOt58GkOgLhk0wd81L+lx3+2bmlBRsQh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719179545; x=1719784345;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BucTsvsvb3t+EGwwmFCESNlAToGQTamjKbBCFtFdoHA=;
 b=c1WssKywJji1CTNGh0lSYCzpA/JNzZTqaPzzcbTNQdDAtrZ5Vo0kdPbIGgFBM2dhHN
 KUP2WqsnWZnMnHk+1O53T82gpthw5I6Gj3Q4vbezRJcCXekrUtR/ecsVRC6l4uQiRN83
 ryr6GDcE0TNb6RVdEg7MNE5n6OmBbNDyeI+v45ks4r8fJVxuTIesCUj8A0c1IrTlT2Th
 BQZfzITOPX6L5W/91WT7otHIOJmasvKDpUGjP11ZcHp5oEVHI/A/BA4daYhUzHz2MWPN
 Gl41q6tbVK01kUwW/hbZG4NoUbVslnSK0Ceu+5I9mJdu0Nj2eRw1xUKiQj29iWgGEbCj
 sDSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU89Tgy4vObAN015fpwVD1NZbx8slNeXSrMoYmFEJ/XFO8/Qh5VMP/s/mED+hI1Vl9w3p4e/80Cwj40cwR31k0YWf0UWg==
X-Gm-Message-State: AOJu0YyZomwxOkq0ypLuz9Pp2fYtWZbpduOIGZvMs55BD1QBmd3of5Ss
 gPyGQhnGscIMR5DVbEfaWCkteLKMn/sfS1m6VYwCZSYXt/XFpKhsHKzbG/oFcu1upg3oowE8WGr
 7NtnJu32wu49/Lr3Sc5MRB2fAUqISS3dFtKEh
X-Google-Smtp-Source: AGHT+IHr5mkI1twkE1nlPy9xxvgMGBk8nUDvi6C0xLf7bbTPWQAVLjTv70PS6BvVd2qp1K+E39mTuaC5B4vvFoRgTVY=
X-Received: by 2002:a05:6214:1d22:b0:6b5:46f1:6b03 with SMTP id
 6a1803df08f44-6b546f16d36mr20745466d6.57.1719179545256; Sun, 23 Jun 2024
 14:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240623114838.14639-1-ilias.apalodimas@linaro.org>
 <20240623114838.14639-9-ilias.apalodimas@linaro.org>
In-Reply-To: <20240623114838.14639-9-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 23 Jun 2024 15:52:14 -0600
Message-ID: <CAFLszTjnNR4BSdya1210f7rvF4ujYV+WFYwd=+F3Y1-cbH5G-Q@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] tpm: allow the user to select the compiled
 algorithms
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com, 
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Sean Anderson <sean.anderson@seco.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Michal Simek <michal.simek@amd.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
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

Hi Ilias,

On Sun, 23 Jun 2024 at 05:49, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Simon reports that after enabling all algorithms on the TPM some boards
> fail since they don't have enough storage to accommodate the ~5KB growth.
>
> The choice of hash algorithms is determined by the platform and the TPM
> configuration. Failing to cap a PCR in a bank which the platform left
> active is a security vulnerability. It might allow  unsealing of secrets
> if an attacker can replay a good set of measurements into an unused bank.
>
> If MEASURED_BOOT or EFI_TCG2_PROTOCOL is enabled our Kconfig will enable
> all supported hashing algorithms. We still want to allow users to add a
> TPM and not enable measured boot via EFI or bootm though and at the same
> time, control the compiled algorithms for size reasons.
>
> So let's add a function tpm2_allow_extend() which checks the TPM active
> PCRs banks against the one U-Boot was compiled with. We only allow
> extending PCRs if the algorithms selected during build match the TPM
> configuration.
>
> It's worth noting that this is only added for TPM2.0, since TPM1.2 is
> lacking a lot of code at the moment to read the available PCR banks.
> We unconditionally enable SHA1 when a TPM is selected, which is the only
> hashing algorithm v1.2 supports.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  boot/Kconfig     |  4 ++++
>  include/tpm-v2.h | 59 +++++++++++++++++++++++++++++++++++-------------
>  lib/Kconfig      |  6 ++---
>  lib/tpm-v2.c     | 40 +++++++++++++++++++++++++++++---
>  4 files changed, 87 insertions(+), 22 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org>  # chromebook-link

nits / thoughts for the future below
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 6f3096c15a6f..b061891e109c 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
>  config MEASURED_BOOT
>         bool "Measure boot images and configuration when booting without EFI"
>         depends on HASH && TPM_V2
> +       select SHA1
> +       select SHA256
> +       select SHA384
> +       select SHA512
>         help
>           This option enables measurement of the boot process when booting
>           without UEFI . Measurement involves creating cryptographic hashes
> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> index aedf2c0f4f5c..4fd19c52fd70 100644
> --- a/include/tpm-v2.h
> +++ b/include/tpm-v2.h
> @@ -278,48 +278,40 @@ struct digest_info {
>  #define TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
>
>  static const struct digest_info hash_algo_list[] = {
> +#if IS_ENABLED(CONFIG_SHA1)
>         {
>                 "sha1",
>                 TPM2_ALG_SHA1,
>                 TCG2_BOOT_HASH_ALG_SHA1,
>                 TPM2_SHA1_DIGEST_SIZE,
>         },
> +#endif
> +#if IS_ENABLED(CONFIG_SHA256)
>         {
>                 "sha256",
>                 TPM2_ALG_SHA256,
>                 TCG2_BOOT_HASH_ALG_SHA256,
>                 TPM2_SHA256_DIGEST_SIZE,
>         },
> +#endif
> +#if IS_ENABLED(CONFIG_SHA384)
>         {
>                 "sha384",
>                 TPM2_ALG_SHA384,
>                 TCG2_BOOT_HASH_ALG_SHA384,
>                 TPM2_SHA384_DIGEST_SIZE,
>         },
> +#endif
> +#if IS_ENABLED(CONFIG_SHA512)
>         {
>                 "sha512",

This is a duplicate of common/hash.c (we can worry about all this later)

>                 TPM2_ALG_SHA512,
>                 TCG2_BOOT_HASH_ALG_SHA512,
>                 TPM2_SHA512_DIGEST_SIZE,

so is this

>         },
> +#endif
>  };
>
> -static inline u16 tpm2_algorithm_to_len(enum tpm2_algorithms a)
> -{
> -       switch (a) {
> -       case TPM2_ALG_SHA1:
> -               return TPM2_SHA1_DIGEST_SIZE;
> -       case TPM2_ALG_SHA256:
> -               return TPM2_SHA256_DIGEST_SIZE;
> -       case TPM2_ALG_SHA384:
> -               return TPM2_SHA384_DIGEST_SIZE;
> -       case TPM2_ALG_SHA512:
> -               return TPM2_SHA512_DIGEST_SIZE;
> -       default:
> -               return 0;
> -       }
> -}
> -
>  /* NV index attributes */
>  enum tpm_index_attrs {
>         TPMA_NV_PPWRITE         = 1UL << 0,
> @@ -712,6 +704,41 @@ enum tpm2_algorithms tpm2_name_to_algorithm(const char *name);
>   */
>  const char *tpm2_algorithm_name(enum tpm2_algorithms);
>
> +/**
> + * tpm2_algorithm_to_len() - Return an algorithm length for supported algorithm id
> + *
> + * @algorithm_id: algorithm defined in enum tpm2_algorithms
> + * Return: len or 0 if not supported
> + */
> +u16 tpm2_algorithm_to_len(enum tpm2_algorithms algo);
> +
> +/*
> + * When measured boot is enabled via EFI or bootX commands all the algorithms
> + * above are selected by our Kconfigs. Due to U-Boots nature of being small there

U-Boot's

> + * are cases where we need some functionality from the TPM -- e.g storage or RNG
> + * but we don't want to support measurements.
> + *
> + * The choice of hash algorithms are determined by the platform and the TPM
> + * configuration. Failing to cap a PCR in a bank which the platform left
> + * active is a security vulnerability. It permits the unsealing of secrets
> + * if an attacker can replay a good set of measurements into an unused bank.
> + *
> + * On top of that a previous stage bootloader (e.g TF-A), migh pass an eventlog

might

> + * since it doesn't have a TPM driver, which U-Boot needs to replace. The algorit h

algorithm

> + * choice is a compile time option in that case and we need to make sure we conform.
> + *
> + * Add a variable here that sums the supported algorithms U-Boot was compiled
> + * with so we can refuse to do measurements if we don't support all of them
> + */
> +
> +/**
> + * tpm2_allow_extend() - Check if extending PCRs is allowed and safe
> + *
> + * @dev: TPM device
> + * Return: true if allowed
> + */
> +bool tpm2_allow_extend(struct udevice *dev);
> +
>  /**
>   * tpm2_is_active_pcr() - check the pcr_select. If at least one of the PCRs
>   *                       supports the algorithm add it on the active ones
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 189e6eb31aa1..b3baa4b85b07 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -439,9 +439,6 @@ config TPM
>         depends on DM
>         imply DM_RNG
>         select SHA1
> -       select SHA256
> -       select SHA384
> -       select SHA512
>         help
>           This enables support for TPMs which can be used to provide security
>           features for your board. The TPM can be connected via LPC or I2C
> @@ -449,6 +446,9 @@ config TPM
>           command to interactive the TPM. Driver model support is provided
>           for the low-level TPM interface, but only one TPM is supported at
>           a time by the TPM library.
> +         For size reasons only SHA1 is selected which is supported on TPM1.2.
> +         If you want a fully functional TPM enable all hashing algorithms.
> +         If you enabled measured boot all hashing algorithms are selected.
>
>  config SPL_TPM
>         bool "Trusted Platform Module (TPM) Support in SPL"
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 36aace03cf4e..59e6cbafafaa 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -196,6 +196,11 @@ u32 tpm2_pcr_extend(struct udevice *dev, u32 index, u32 algorithm,
>
>         if (!digest)
>                 return -EINVAL;
> +
> +       if (!tpm2_allow_extend(dev)) {
> +               log_err("Cannot extend PCRs if all the TPM enabled algorithms are not supported\n");
> +               return -EINVAL;
> +       }
>         /*
>          * Fill the command structure starting from the first buffer:
>          *     - the digest
> @@ -409,11 +414,10 @@ int tpm2_get_pcr_info(struct udevice *dev, struct tpml_pcr_selection *pcrs)
>
>         pcrs->count = get_unaligned_be32(response);
>         /*
> -        * We only support 5 algorithms for now so check against that
> +        * We only support 4 algorithms for now so check against that
>          * instead of TPM2_NUM_PCR_BANKS
>          */
> -       if (pcrs->count > ARRAY_SIZE(hash_algo_list) ||
> -           pcrs->count < 1) {
> +       if (pcrs->count > 4 || pcrs->count < 1) {
>                 printf("%s: too many pcrs: %u\n", __func__, pcrs->count);
>                 return -EMSGSIZE;
>         }
> @@ -880,3 +884,33 @@ const char *tpm2_algorithm_name(enum tpm2_algorithms algo)
>         return "";
>  }
>
> +u16 tpm2_algorithm_to_len(enum tpm2_algorithms algo)

nit: return uint? There is no need to mask the register here

> +{
> +       size_t i;
> +
> +       for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
> +               if (hash_algo_list[i].hash_alg == algo)
> +                       return hash_algo_list[i].hash_len;
> +       }
> +
> +       return 0;
> +}

At some point we could have a HASH_ALGOT variable in hash.h which
encodes the hash algorithm, then some of this will be common

> +
> +bool tpm2_allow_extend(struct udevice *dev)
> +{
> +       struct tpml_pcr_selection pcrs;
> +       size_t i;
> +       int rc;
> +
> +       rc = tpm2_get_pcr_info(dev, &pcrs);
> +       if (rc)
> +               return false;
> +
> +       for (i = 0; i < pcrs.count; i++) {
> +               if (tpm2_is_active_pcr(&pcrs.selection[i]) &&
> +                   !tpm2_algorithm_to_len(pcrs.selection[i].hash))
> +                       return false;
> +       }
> +
> +       return true;
> +}
> --
> 2.45.2
>

REgards,
Simon
