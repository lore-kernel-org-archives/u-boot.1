Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3EAEE49A5
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 23:16:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBE408649D;
	Wed, 23 Aug 2023 01:16:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RrJ2AmW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E05864A5; Wed, 23 Aug 2023 01:16:26 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 349008649B
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 01:16:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4fe15bfb1adso7586671e87.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 16:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692746183; x=1693350983;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sVmkc20vSi5TmrBLDoC6jMYFDwcKi9i+4suid53Wgug=;
 b=RrJ2AmW6JkieN7eKrI9vWtzWYJA+XbSg7O8fmYi4O5Xi36FAc9n29XxAEO8SotXI4o
 cSEijGPz/jLHlrdBtPbhTmhnM7p0jqYV1nmxg39LLaoQd4xFh8tYwGEHEnpJqW3MAeUf
 cl0jWA0VOBBVIdVx9/0AP+El1EVWf1V45yJr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692746183; x=1693350983;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sVmkc20vSi5TmrBLDoC6jMYFDwcKi9i+4suid53Wgug=;
 b=de5OcV6t3VwT7UrAKeQ+Yb8+/XGO/I9H2I46O3ug9zSpgIV9TVZncqhW+qt9NaZSCe
 x8SNer5fe4N2rCyuEvpIO5vo2P1uf20v4msi5Fkj34d7mne8LHim06dboPkjztNZYJ+T
 BzweLpfP30lK/xRqW9fZbuor8/PlBb7U1VEpQueVhY6BOya/G3gZRHTM6gVtwmfxr0aA
 JhZsQyQyNR33gezfAJSSb7xvImbNsNPGq1qLBqfvF7ODJ7W15rFQVjq1XZeNfconde8B
 V9Xhkz9gkCvJJSHv1FlsXDf1ek5+dgshvhBpDtoI7KzRmNMzG7Wd+a5a4O0QtQ3annwG
 RLfA==
X-Gm-Message-State: AOJu0YxqWRFQYlwbLo3D+XuEnRzUBV4dZuzI0IPN7vmBk1fbEAPD38OM
 0RyDWBzTbdutd0UF2n5ak7d3p13nQwbXrivA7iPbrA==
X-Google-Smtp-Source: AGHT+IFYCnNenkpwH1m2X9kpNaOhpE7JT8o2qzEMjrqodoPfZs34OWSsUbL0BoF9f3hyLiaA20O7YXnzOhKwpEBqMLw=
X-Received: by 2002:a19:7b12:0:b0:4f6:2b25:194e with SMTP id
 w18-20020a197b12000000b004f62b25194emr6215572lfc.58.1692746183109; Tue, 22
 Aug 2023 16:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-2-nm@ti.com>
In-Reply-To: <20230822184135.2328409-2-nm@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Aug 2023 17:16:11 -0600
Message-ID: <CAPnjgZ0p5YkgvYM_F0j97bvAoM1qieafyjFQ_neyUoDuNFyN2g@mail.gmail.com>
Subject: Re: [PATCH V4 1/8] env_default: Allow CONFIG_EXTRA_ENV_TEXT to
 override CFG_EXTRA_ENV_SETTINGS
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
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

Hi Nishanth,

On Tue, 22 Aug 2023 at 12:41, Nishanth Menon <nm@ti.com> wrote:
>
> CFG_EXTRA_ENV_SETTINGS is set in common board config files, This allows
> for majority of the settings to be set in a common manner. However, the
> minor variations between various board can be addressed by the board.env
> files. The board.env files are converted into CONFIG_EXTRA_ENV_TEXT.
>
> However, this creates a minor problem. For example:
> distro_bootcmd.h and used by ti_armv7_common.h uses it as:
>  #define BOOT_TARGET_DEVICES(func) \
>         func(MMC, mmc, 0) \
>         func(MMC, mmc, 1)

OK, but we should be using bootstd for new boards.

>
> Which in turn generates:
> boot_targets=mmc0 mmc1
>
> And this probably works fine for most boards, However when the
> boot_targets need to be reversed, the preferred behavior would have been
> to define it in board.env file as:
> boot_targets=mmc1 mmc0
>
> By changing the order of the inclusion, we allow for the
> CONFIG_EXTRA_ENV_TEXT to have a higher priority in the definition.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
>
> New patch
>
>  include/env_default.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/env_default.h b/include/env_default.h
> index b16c22d5a28c..714dfa9e845e 100644
> --- a/include/env_default.h
> +++ b/include/env_default.h
> @@ -112,12 +112,12 @@ const char default_environment[] = {
>  #ifdef CONFIG_MTDPARTS_DEFAULT
>         "mtdparts="     CONFIG_MTDPARTS_DEFAULT         "\0"
>  #endif
> +#ifdef CFG_EXTRA_ENV_SETTINGS
> +       CFG_EXTRA_ENV_SETTINGS
> +#endif
>  #ifdef CONFIG_EXTRA_ENV_TEXT
>         /* This is created in the Makefile */
>         CONFIG_EXTRA_ENV_TEXT
> -#endif
> -#ifdef CFG_EXTRA_ENV_SETTINGS
> -       CFG_EXTRA_ENV_SETTINGS
>  #endif

and text environment

>         "\0"
>  #else /* CONFIG_USE_DEFAULT_ENV_FILE */
> --
> 2.40.0
>

Regards,
SImon
