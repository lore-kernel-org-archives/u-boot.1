Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E681C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 04:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA0C587DC7;
	Mon, 24 Jun 2024 06:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ptm82UeR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CB45882A5; Mon, 24 Jun 2024 06:44:20 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3C3487923
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 06:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7066c799382so1329613b3a.3
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 21:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719204256; x=1719809056; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1Ka3f+cb17xAZASH2fi0lwreEWahTXEVfQPEFJJmQqc=;
 b=Ptm82UeRTDbBGALlxJIdXswAINMZxHJnf16EZQzVdpiU1TNkSrQ719K6aYqa3vcZuN
 khbquzjsB4QvRU+J2dVVXzxrugMz1lRLVy67pfLt8nQ1pIy3dPrQ+Se6NwIogmXsP6DT
 RtytlvgI0dzCnxObQRujwEFn+iqqL21hgTl0tWSNUqwNZSKjSEMJ5shOQsiK2cI/Z4uc
 gW1EVseELT4R0dj4G4A4T0PrAmURt2EPHfljteveipuInK4+8w9e3qliemAlzC3yOWfi
 fRWGIN99d9htDb0NDNVzZf6pXh2yqF16svdArBIL8NlkU3mNpOHXa5m0UGcPW1r3lAx9
 8qBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719204256; x=1719809056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Ka3f+cb17xAZASH2fi0lwreEWahTXEVfQPEFJJmQqc=;
 b=wGX3RoSL2nvYclFFZFjnDOSRPadhfBDrKP13A835x/+vpggCu82gMx1A5giofyvb1v
 eodSr6DE50DEmdr1jtCIBcq7sRvFrfOgIcQQZ9dT+lpOpxpQhNQHrIgfQTMPMfpMfTOl
 cpZWo9a5YBkhPYMRRWk6fuIWWKDVq9SjuMq7Mb71vWuHaOp6ajj5FpAGI6OksdcJq+tT
 S5ogE2dIqmXMiW1OnZIc1GR1c8EJblCuc+MhoX0sTF24/0O2Dyh1uxarSJdp9poNrDi7
 ZaWeh2qEPtYRiowjzt7jHiAcY/czBj5Nqp4q93ZKJ+a8ESpbbC5aTmtFWjQOHPPr3s/o
 SJaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+X7UPp/NBNuC2Hcl6HYOF7FuTL/gkeHyYyjP6/D/TM88NnfCeQxyArO1KPrCBdcuk3IGcVGym0oLrmu0Gna7+7Cu1Cw==
X-Gm-Message-State: AOJu0YzNqgSRdcbm+UMPMff/IRxi9nkX14m99D2lUq2rfe6DoLWM7rY0
 bGCfTHWlDIH9UyKlzVKyw8rJTRkVvU/M/v5kmbl4j3yP7TC/C2ZpBjX3uDuroRTB+FRLHTZKDwX
 gBr9bVTDuMfK8OKKqxSRB7N3/QnBGZFmUbdQDQQ==
X-Google-Smtp-Source: AGHT+IHxc6KGm4LF5R6r6fYXvwTq/xFLWP7fjgERF8lidnsAL4Btxs/YPFQRAyeJU97qStrzkH15yLRumh1vcj2ZPT0=
X-Received: by 2002:a05:6a20:60d5:b0:1b8:a2ca:3b6e with SMTP id
 adf61e73a8af0-1bcf7fd13b8mr3550497637.50.1719204255788; Sun, 23 Jun 2024
 21:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240623114838.14639-1-ilias.apalodimas@linaro.org>
 <20240623114838.14639-9-ilias.apalodimas@linaro.org>
 <CAFLszTjnNR4BSdya1210f7rvF4ujYV+WFYwd=+F3Y1-cbH5G-Q@mail.gmail.com>
In-Reply-To: <CAFLszTjnNR4BSdya1210f7rvF4ujYV+WFYwd=+F3Y1-cbH5G-Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 24 Jun 2024 07:43:39 +0300
Message-ID: <CAC_iWj+YNg3bZxpkZ=c9dK7b0=ZDu_6dHA9wBQznd3kUsEpcnw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] tpm: allow the user to select the compiled
 algorithms
To: Simon Glass <sjg@chromium.org>
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

On Mon, 24 Jun 2024 at 00:52, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Sun, 23 Jun 2024 at 05:49, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Simon reports that after enabling all algorithms on the TPM some boards
> > fail since they don't have enough storage to accommodate the ~5KB growth.
> >
> > The choice of hash algorithms is determined by the platform and the TPM
> > configuration. Failing to cap a PCR in a bank which the platform left
> > active is a security vulnerability. It might allow  unsealing of secrets
> > if an attacker can replay a good set of measurements into an unused bank.
> >
> > If MEASURED_BOOT or EFI_TCG2_PROTOCOL is enabled our Kconfig will enable
> > all supported hashing algorithms. We still want to allow users to add a
> > TPM and not enable measured boot via EFI or bootm though and at the same
> > time, control the compiled algorithms for size reasons.
> >
> > So let's add a function tpm2_allow_extend() which checks the TPM active
> > PCRs banks against the one U-Boot was compiled with. We only allow
> > extending PCRs if the algorithms selected during build match the TPM
> > configuration.
> >
> > It's worth noting that this is only added for TPM2.0, since TPM1.2 is
> > lacking a lot of code at the moment to read the available PCR banks.
> > We unconditionally enable SHA1 when a TPM is selected, which is the only
> > hashing algorithm v1.2 supports.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  boot/Kconfig     |  4 ++++
> >  include/tpm-v2.h | 59 +++++++++++++++++++++++++++++++++++-------------
> >  lib/Kconfig      |  6 ++---
> >  lib/tpm-v2.c     | 40 +++++++++++++++++++++++++++++---
> >  4 files changed, 87 insertions(+), 22 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Tested-by: Simon Glass <sjg@chromium.org>  # chromebook-link
>
> nits / thoughts for the future below

I'll fix the spelling errors before merging

> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index 6f3096c15a6f..b061891e109c 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
> >  config MEASURED_BOOT
> >         bool "Measure boot images and configuration when booting without EFI"
> >         depends on HASH && TPM_V2
> > +       select SHA1
> > +       select SHA256
> > +       select SHA384
> > +       select SHA512
> >         help
> >           This option enables measurement of the boot process when booting
> >           without UEFI . Measurement involves creating cryptographic hashes
> > diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> > index aedf2c0f4f5c..4fd19c52fd70 100644
> > --- a/include/tpm-v2.h
> > +++ b/include/tpm-v2.h
> > @@ -278,48 +278,40 @@ struct digest_info {
> >  #define TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
> >
> >  static const struct digest_info hash_algo_list[] = {
> > +#if IS_ENABLED(CONFIG_SHA1)
> >         {
> >                 "sha1",
> >                 TPM2_ALG_SHA1,
> >                 TCG2_BOOT_HASH_ALG_SHA1,
> >                 TPM2_SHA1_DIGEST_SIZE,
> >         },
> > +#endif
> > +#if IS_ENABLED(CONFIG_SHA256)
> >         {
> >                 "sha256",
> >                 TPM2_ALG_SHA256,
> >                 TCG2_BOOT_HASH_ALG_SHA256,
> >                 TPM2_SHA256_DIGEST_SIZE,
> >         },
> > +#endif
> > +#if IS_ENABLED(CONFIG_SHA384)
> >         {
> >                 "sha384",
> >                 TPM2_ALG_SHA384,
> >                 TCG2_BOOT_HASH_ALG_SHA384,
> >                 TPM2_SHA384_DIGEST_SIZE,
> >         },
> > +#endif
> > +#if IS_ENABLED(CONFIG_SHA512)
> >         {
> >                 "sha512",
>
> This is a duplicate of common/hash.c (we can worry about all this later)

The name and length are. TPM2_ALG_SHAXXX is what the device returns
though when probed for available algorithms and since those values are
not maskable, TCG defined its masks .... TCG2_BOOT_HASH_ALG_SHA512
etc.
This is unfortunate but I can't immediately think of an elegant way to
combine those.

>
> >                 TPM2_ALG_SHA512,
> >                 TCG2_BOOT_HASH_ALG_SHA512,
> >                 TPM2_SHA512_DIGEST_SIZE,
>
> so is this
>
> >         },
> > +#endif
> >  };
> >
> > -static inline u16 tpm2_algorithm_to_len(enum tpm2_algorithms a)
> > -{
> > -       switch (a) {
> > -       case TPM2_ALG_SHA1:
> > -               return TPM2_SHA1_DIGEST_SIZE;
> > -       case TPM2_ALG_SHA256:
> > -               return TPM2_SHA256_DIGEST_SIZE;
> > -       case TPM2_ALG_SHA384:
> > -               return TPM2_SHA384_DIGEST_SIZE;
> > -       case TPM2_ALG_SHA512:
> > -               return TPM2_SHA512_DIGEST_SIZE;
> > -       default:
> > -               return 0;
> > -       }
> > -}
> > -
> >  /* NV index attributes */
> >  enum tpm_index_attrs {
> >         TPMA_NV_PPWRITE         = 1UL << 0,
> > @@ -712,6 +704,41 @@ enum tpm2_algorithms tpm2_name_to_algorithm(const char *name);
> >   */
> >  const char *tpm2_algorithm_name(enum tpm2_algorithms);
> >
> > +/**
> > + * tpm2_algorithm_to_len() - Return an algorithm length for supported algorithm id
> > + *
> > + * @algorithm_id: algorithm defined in enum tpm2_algorithms
> > + * Return: len or 0 if not supported
> > + */
> > +u16 tpm2_algorithm_to_len(enum tpm2_algorithms algo);
> > +
> > +/*
> > + * When measured boot is enabled via EFI or bootX commands all the algorithms
> > + * above are selected by our Kconfigs. Due to U-Boots nature of being small there
>
> U-Boot's
>
> > + * are cases where we need some functionality from the TPM -- e.g storage or RNG
> > + * but we don't want to support measurements.
> > + *
> > + * The choice of hash algorithms are determined by the platform and the TPM
> > + * configuration. Failing to cap a PCR in a bank which the platform left
> > + * active is a security vulnerability. It permits the unsealing of secrets
> > + * if an attacker can replay a good set of measurements into an unused bank.
> > + *
> > + * On top of that a previous stage bootloader (e.g TF-A), migh pass an eventlog
>
> might
>
> > + * since it doesn't have a TPM driver, which U-Boot needs to replace. The algorit h
>
> algorithm
>
> > + * choice is a compile time option in that case and we need to make sure we conform.
> > + *
> > + * Add a variable here that sums the supported algorithms U-Boot was compiled
> > + * with so we can refuse to do measurements if we don't support all of them
> > + */
> > +
> > +/**
> > + * tpm2_allow_extend() - Check if extending PCRs is allowed and safe
> > + *
> > + * @dev: TPM device
> > + * Return: true if allowed
> > + */
> > +bool tpm2_allow_extend(struct udevice *dev);
> > +
> >  /**
> >   * tpm2_is_active_pcr() - check the pcr_select. If at least one of the PCRs
> >   *                       supports the algorithm add it on the active ones
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 189e6eb31aa1..b3baa4b85b07 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -439,9 +439,6 @@ config TPM
> >         depends on DM
> >         imply DM_RNG
> >         select SHA1
> > -       select SHA256
> > -       select SHA384
> > -       select SHA512
> >         help
> >           This enables support for TPMs which can be used to provide security
> >           features for your board. The TPM can be connected via LPC or I2C
> > @@ -449,6 +446,9 @@ config TPM
> >           command to interactive the TPM. Driver model support is provided
> >           for the low-level TPM interface, but only one TPM is supported at
> >           a time by the TPM library.
> > +         For size reasons only SHA1 is selected which is supported on TPM1.2.
> > +         If you want a fully functional TPM enable all hashing algorithms.
> > +         If you enabled measured boot all hashing algorithms are selected.
> >
> >  config SPL_TPM
> >         bool "Trusted Platform Module (TPM) Support in SPL"
> > diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> > index 36aace03cf4e..59e6cbafafaa 100644
> > --- a/lib/tpm-v2.c
> > +++ b/lib/tpm-v2.c
> > @@ -196,6 +196,11 @@ u32 tpm2_pcr_extend(struct udevice *dev, u32 index, u32 algorithm,
> >
> >         if (!digest)
> >                 return -EINVAL;
> > +
> > +       if (!tpm2_allow_extend(dev)) {
> > +               log_err("Cannot extend PCRs if all the TPM enabled algorithms are not supported\n");
> > +               return -EINVAL;
> > +       }
> >         /*
> >          * Fill the command structure starting from the first buffer:
> >          *     - the digest
> > @@ -409,11 +414,10 @@ int tpm2_get_pcr_info(struct udevice *dev, struct tpml_pcr_selection *pcrs)
> >
> >         pcrs->count = get_unaligned_be32(response);
> >         /*
> > -        * We only support 5 algorithms for now so check against that
> > +        * We only support 4 algorithms for now so check against that
> >          * instead of TPM2_NUM_PCR_BANKS
> >          */
> > -       if (pcrs->count > ARRAY_SIZE(hash_algo_list) ||
> > -           pcrs->count < 1) {
> > +       if (pcrs->count > 4 || pcrs->count < 1) {
> >                 printf("%s: too many pcrs: %u\n", __func__, pcrs->count);
> >                 return -EMSGSIZE;
> >         }
> > @@ -880,3 +884,33 @@ const char *tpm2_algorithm_name(enum tpm2_algorithms algo)
> >         return "";
> >  }
> >
> > +u16 tpm2_algorithm_to_len(enum tpm2_algorithms algo)
>
> nit: return uint? There is no need to mask the register here
>
> > +{
> > +       size_t i;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
> > +               if (hash_algo_list[i].hash_alg == algo)
> > +                       return hash_algo_list[i].hash_len;
> > +       }
> > +
> > +       return 0;
> > +}
>
> At some point we could have a HASH_ALGOT variable in hash.h which
> encodes the hash algorithm, then some of this will be common

Yes, I was toying around with the idea of creating a mask with the
supported algorithms. We could even reuse the masking the TCG defines.
There's nothing special to this function tbh, so we can move it in
common/hash.c instead as well. But I'll pick this as-is for now and
plan for a wider refactoring of all the hashing support we have. There
are a lot of places we redefine those and we shouldn't.

Thanks
/Ilias

>
> > +
> > +bool tpm2_allow_extend(struct udevice *dev)
> > +{
> > +       struct tpml_pcr_selection pcrs;
> > +       size_t i;
> > +       int rc;
> > +
> > +       rc = tpm2_get_pcr_info(dev, &pcrs);
> > +       if (rc)
> > +               return false;
> > +
> > +       for (i = 0; i < pcrs.count; i++) {
> > +               if (tpm2_is_active_pcr(&pcrs.selection[i]) &&
> > +                   !tpm2_algorithm_to_len(pcrs.selection[i].hash))
> > +                       return false;
> > +       }
> > +
> > +       return true;
> > +}
> > --
> > 2.45.2
> >
>
> REgards,
> Simon
