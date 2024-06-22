Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39119C2BB85
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 16:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6FD88803E;
	Sat, 22 Jun 2024 18:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mjo97cOt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61E748818B; Sat, 22 Jun 2024 18:40:55 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA61D87A09
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 18:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7066c799382so362050b3a.3
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 09:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719074451; x=1719679251; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B+jNIEXVWCk/xU/QyFhozccBMMvBj5IgGBYr6X9AY+k=;
 b=mjo97cOtHVrD6+ZZZb/wO5v9tzVbms49WWiL8qhvzDEE+7GPFcTm9cwznL1FLFtXe0
 pJKwnyWthyP0McYMxTqD+dQmAVYyE1SOBwY+BOAIIX1HCyQpHnu36n++6xDPW2vwuFdO
 Zx1ClJ2FB4yWVEIlJEyOI8Qn7iBp6j/dhydIgExFL6sv1L44qcOb/IldvR7Iet6xtmMm
 ll2zNBkwB6H7U2s5VRFmLNQApeQo0HQx7UJVyfotBb5iJznwLh33Eis8xGG+yS2Aaf+2
 jjHR/FpPOzVzRAuW+qGzW5yduoL3aL47FTqmuWsG1EMSeqAaY5YTrqJLRzKAjht3zPF8
 AGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719074451; x=1719679251;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B+jNIEXVWCk/xU/QyFhozccBMMvBj5IgGBYr6X9AY+k=;
 b=YcP/8FFdfGuh+HV62/4hrP3MlP8RivdNzoHfu3a4IRdECMYN6yWo+Tp0GXNEOjUMFs
 9rbmAmdifuE+W/cjBYt8gSx0b8YbeAOEqQQj3ZVV9CT8e4ekFd4AIcLXCo4qeKBA/El1
 28ISb/1TMylYsX2y+VN8YXqpNO7wXsCh0HEg6N50qFzIWsW8kPbTAnSo/0/JuFNoo7A6
 hmf46Bv0ghR1N07DiUeUtTReLlTmOV5SLyDz4nFYriYEfnPi6IIlGfKY1XkDNcDryWi8
 9YVBPJpIu6Ce/Hp+KJF9T/RhrIqxEjxSvsDNhXvuToFQI2YXHeq3jmp5LmqgnZ3FdKVP
 t4oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIVz+wuCTBFGqeD8oVt3rdqOyj4HJpbUw8crkVJmJ9q0+axl5bHUt+iYY/1ds5K3xGWwgpzAgzZLv6kYNBYrOiQxjhog==
X-Gm-Message-State: AOJu0Yw4HqUSyPnsG6pZzLOfJ96OVujm1UQKsoQo8tmC2cLer+XjRgn5
 tR+3onh0IEa45lZzfvGMzo/TLl7e77IVwNsKa1lQ1zyIwJJi1FLRGKVrg1Vfs5eQ+zyuBi+twLO
 x6rHzRHIhkXUJVcE28wTGqK2aX+L+iavbJpAKuQ==
X-Google-Smtp-Source: AGHT+IEqDocm3ruqvWZ5eyoHbQtnuYKavYghtJDk3lsuuzq2Ip3rbG+f3Nq2rHLNlXnIu4xCBBqj1dek7wXsVQ5oCqY=
X-Received: by 2002:a05:6a20:a110:b0:1ba:e88c:c4e7 with SMTP id
 adf61e73a8af0-1bcf7edf2a8mr367313637.30.1719074450934; Sat, 22 Jun 2024
 09:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
 <20240622143601.187723-8-ilias.apalodimas@linaro.org>
 <b91ca754-3b04-4db0-917f-2362c53539e6@gmx.de>
In-Reply-To: <b91ca754-3b04-4db0-917f-2362c53539e6@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 22 Jun 2024 19:40:14 +0300
Message-ID: <CAC_iWj+MAiyOB9uCPZd6Xt-KytuDxY+FntHVs8nvQTMyG_vFpQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] tpm: allow the user to select the compiled algorithms
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Sean Anderson <sean.anderson@seco.com>, Michal Simek <michal.simek@amd.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de,
 sjg@chromium.org, trini@konsulko.com
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

On Sat, 22 Jun 2024 at 19:34, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 22.06.24 16:35, Ilias Apalodimas wrote:
> > Simon reports that after enabling all algorithms on the TPM some boards
> > fail since they don't have enough storage to accommodate the ~5KB growth.
> >
> > The choice of hash algorithms are determined by the platform and the TPM
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
> > PCRs banks against the one U-Boot was compiled with.
> > If all the active PCRs banks are not enabled refuse to extend a PCR but
> > otherwise leave the TPM functional.
>
> The paragraph above is bit hard to read. I guess you mean:
>
> We only allow extending PCRs using one of the algorithms selected in the
> configuration.

Yes

>
> >
> > It's worth noting that this is only added on TPM2.0, since TPM1.2 is
> > lacking a lot of code at the moment to read the available PCRs.
> > We unconditionally enable SHA1 when a TPM is selected, which is the only
> > hashing algorithm v1.2 supports.
>
> Why do we need SHA1 if we cannot access PCRs on a TPM1.2?

You can. On TPM1.2 we don't have the functions to check for the active
PCR banks. So I am unconditionally enabling SHA1, which is the only
hashing algo TPM1.2 supports.

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   boot/Kconfig     |  4 ++++
> >   include/tpm-v2.h | 59 +++++++++++++++++++++++++++++++++++-------------
> >   lib/Kconfig      |  6 ++---
> >   lib/tpm-v2.c     | 40 +++++++++++++++++++++++++++++---
> >   4 files changed, 87 insertions(+), 22 deletions(-)
> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index 6f3096c15a6f..b061891e109c 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
> >   config MEASURED_BOOT
> >       bool "Measure boot images and configuration when booting without EFI"
> >       depends on HASH && TPM_V2
> > +     select SHA1
> > +     select SHA256
> > +     select SHA384
> > +     select SHA512
> >       help
> >         This option enables measurement of the boot process when booting
> >         without UEFI . Measurement involves creating cryptographic hashes
> > diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> > index eac04d1c6831..fccb07fa4695 100644
> > --- a/include/tpm-v2.h
> > +++ b/include/tpm-v2.h
> > @@ -277,48 +277,40 @@ struct digest_info {
> >   #define TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
> >
> >   static const struct digest_info hash_algo_list[] = {
> > +#if IS_ENABLED(CONFIG_SHA1)
> >       {
> >               "sha1",
> >               TPM2_ALG_SHA1,
> >               TCG2_BOOT_HASH_ALG_SHA1,
> >               TPM2_SHA1_DIGEST_SIZE,
> >       },
> > +#endif
> > +#if IS_ENABLED(CONFIG_SHA256)
> >       {
> >               "sha256",
> >               TPM2_ALG_SHA256,
> >               TCG2_BOOT_HASH_ALG_SHA256,
> >               TPM2_SHA256_DIGEST_SIZE,
> >       },
> > +#endif
> > +#if IS_ENABLED(CONFIG_SHA384)
> >       {
> >               "sha384",
> >               TPM2_ALG_SHA384,
> >               TCG2_BOOT_HASH_ALG_SHA384,
> >               TPM2_SHA384_DIGEST_SIZE,
> >       },
> > +#endif
> > +#if IS_ENABLED(CONFIG_SHA512)
> >       {
> >               "sha512",
> >               TPM2_ALG_SHA512,
> >               TCG2_BOOT_HASH_ALG_SHA512,
> >               TPM2_SHA512_DIGEST_SIZE,
> >       },
> > +#endif
> >   };
> >
> > -static inline u16 tpm2_algorithm_to_len(enum tpm2_algorithms a)
> > -{
> > -     switch (a) {
> > -     case TPM2_ALG_SHA1:
> > -             return TPM2_SHA1_DIGEST_SIZE;
> > -     case TPM2_ALG_SHA256:
> > -             return TPM2_SHA256_DIGEST_SIZE;
> > -     case TPM2_ALG_SHA384:
> > -             return TPM2_SHA384_DIGEST_SIZE;
> > -     case TPM2_ALG_SHA512:
> > -             return TPM2_SHA512_DIGEST_SIZE;
> > -     default:
> > -             return 0;
> > -     }
> > -}
> > -
> >   /* NV index attributes */
> >   enum tpm_index_attrs {
> >       TPMA_NV_PPWRITE         = 1UL << 0,
> > @@ -711,6 +703,41 @@ enum tpm2_algorithms tpm2_name_to_algorithm(const char *name);
> >    */
> >   const char *tpm2_algorithm_name(enum tpm2_algorithms);
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
> > + * are cases where we need some functionality from the TPM -- e.g storage or RNG
> > + * but we don't want to support measurements.
> > + *
> > + * The choice of hash algorithms are determined by the platform and the TPM
> > + * configuration. Failing to cap a PCR in a bank which the platform left
> > + * active is a security vulnerability. It permits the unsealing of secrets
> > + * if an attacker can replay a good set of measurements into an unused bank.
> > + *
> > + * On top of that a previous stage bootloader (e.g TF-A), migh pass an eventlog
> > + * since it doesn't have a TPM driver, which U-Boot needs to replace. The algorit h
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
> >   /**
> >    * tpm2_is_active_pcr() - check the pcr_select. If at least one of the PCRs
> >    *                    supports the algorithm add it on the active ones
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 189e6eb31aa1..b3baa4b85b07 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -439,9 +439,6 @@ config TPM
> >       depends on DM
> >       imply DM_RNG
> >       select SHA1
> > -     select SHA256
> > -     select SHA384
> > -     select SHA512
> >       help
> >         This enables support for TPMs which can be used to provide security
> >         features for your board. The TPM can be connected via LPC or I2C
> > @@ -449,6 +446,9 @@ config TPM
> >         command to interactive the TPM. Driver model support is provided
> >         for the low-level TPM interface, but only one TPM is supported at
> >         a time by the TPM library.
> > +       For size reasons only SHA1 is selected which is supported on TPM1.2.
> > +       If you want a fully functional TPM enable all hashing algorithms.
> > +       If you enabled measured boot all hashing algorithms are selected.
> >
> >   config SPL_TPM
> >       bool "Trusted Platform Module (TPM) Support in SPL"
> > diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> > index 36aace03cf4e..59e6cbafafaa 100644
> > --- a/lib/tpm-v2.c
> > +++ b/lib/tpm-v2.c
> > @@ -196,6 +196,11 @@ u32 tpm2_pcr_extend(struct udevice *dev, u32 index, u32 algorithm,
> >
> >       if (!digest)
> >               return -EINVAL;
> > +
> > +     if (!tpm2_allow_extend(dev)) {
> > +             log_err("Cannot extend PCRs if all the TPM enabled algorithms are not supported\n");
> > +             return -EINVAL;
> > +     }
> >       /*
> >        * Fill the command structure starting from the first buffer:
> >        *     - the digest
> > @@ -409,11 +414,10 @@ int tpm2_get_pcr_info(struct udevice *dev, struct tpml_pcr_selection *pcrs)
> >
> >       pcrs->count = get_unaligned_be32(response);
> >       /*
> > -      * We only support 5 algorithms for now so check against that
> > +      * We only support 4 algorithms for now so check against that
> >        * instead of TPM2_NUM_PCR_BANKS
> >        */
> > -     if (pcrs->count > ARRAY_SIZE(hash_algo_list) ||
> > -         pcrs->count < 1) {
> > +     if (pcrs->count > 4 || pcrs->count < 1) {
> >               printf("%s: too many pcrs: %u\n", __func__, pcrs->count);
> >               return -EMSGSIZE;
> >       }
> > @@ -880,3 +884,33 @@ const char *tpm2_algorithm_name(enum tpm2_algorithms algo)
> >       return "";
> >   }
> >
> > +u16 tpm2_algorithm_to_len(enum tpm2_algorithms algo)
> > +{
> > +     size_t i;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
> > +             if (hash_algo_list[i].hash_alg == algo)
> > +                     return hash_algo_list[i].hash_len;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +bool tpm2_allow_extend(struct udevice *dev)
> > +{
> > +     struct tpml_pcr_selection pcrs;
> > +     size_t i;
> > +     int rc;
> > +
> > +     rc = tpm2_get_pcr_info(dev, &pcrs);
> > +     if (rc)
> > +             return false;
> > +
> > +     for (i = 0; i < pcrs.count; i++) {
> > +             if (tpm2_is_active_pcr(&pcrs.selection[i]) &&
> > +                 !tpm2_algorithm_to_len(pcrs.selection[i].hash))
> > +                     return false;
> > +     }
> > +
> > +     return true;
> > +}
>
