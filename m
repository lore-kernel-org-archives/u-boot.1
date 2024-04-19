Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D410C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 00:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B10188860F;
	Fri, 19 Apr 2024 02:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CC6E885DE; Fri, 19 Apr 2024 02:34:00 +0200 (CEST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 646058862B
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 02:33:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ngompa13@gmail.com
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-516f2e0edb7so1932886e87.1
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 17:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713486837; x=1714091637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PhD14Fcqz09Aolmox4funyeAN+UtnsdTMtIVtk68AGk=;
 b=PeEU9SwJMbHFLMJJSBdom1514OQUE76l/uz4yzknTsZt2DVgwOujNdM5urdJE7JAj2
 H/TffAx/ffK3xqua+bGUEaVSMNhjkrBU8Ht0ZtpDb5sFLZU/JQPdNwOqY177LV7MP3Yv
 gIpxqvvcLvfoMzdV1uwbxPWbGninUWPoXq8VdifsIZKecdAK/TKKE6lQqVT7PVjzsnve
 D91Kx23OhRKNNwO5o2e90PLXSCMWZLWjsSxkIhsg2/u0oS6toEVa1t/fruRfmKVVS0x1
 e9rUl3CaJtY6O1xtik3ob869k80ClGCc5i1zITSnAyd4dt7tng+/p1yWDHw/GmgVHE8C
 7EGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3D08llU+b7zKX8XuT6WwleLDSyF4W9C3ljx+ISBOes13bpMjGk/tn3p+wrbYaqt4nwWqw8l1leEhrIQMeScDQwuRj5g==
X-Gm-Message-State: AOJu0YwE34anxiDBV/wcEE0Eg5ITRWOwny9Wj+cnvSe8Sv9qm8T3bQl5
 eCYZXI1sQ0av87QJ4DJxJw6Xand8ndko1gwTT7L6AztApluWgRUwuTKWcvfkklEh1g==
X-Google-Smtp-Source: AGHT+IFhNTSIJIUe4V9vWam4JZAgQ68shZt+Z3nl5HJSgFfEnxMqdqnxmuAD03Gmy24AapWqB956fQ==
X-Received: by 2002:ac2:5196:0:b0:518:b069:3b7d with SMTP id
 u22-20020ac25196000000b00518b0693b7dmr314026lfi.6.1713486837102; 
 Thu, 18 Apr 2024 17:33:57 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com.
 [209.85.218.53]) by smtp.gmail.com with ESMTPSA id
 s3-20020a056402164300b00562d908daf4sm1457029edx.84.2024.04.18.17.33.56
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 17:33:56 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-a524ecaf215so168482266b.2
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 17:33:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUk3F5HmD+Zls7aQaIhnGCX6aKbDCeWvLiYDNPCUh13ojMOZXohQxNdosseSDnIH2uCw0pPSB0Joownajn6jKSPOYuAtA==
X-Received: by 2002:a17:907:980e:b0:a52:2d35:5e28 with SMTP id
 ji14-20020a170907980e00b00a522d355e28mr410282ejc.57.1713486836344; Thu, 18
 Apr 2024 17:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240418-apple_config-v2-0-7e5c6b9a9db3@jannau.net>
 <20240418-apple_config-v2-4-7e5c6b9a9db3@jannau.net>
In-Reply-To: <20240418-apple_config-v2-4-7e5c6b9a9db3@jannau.net>
From: Neal Gompa <neal@gompa.dev>
Date: Thu, 18 Apr 2024 20:33:20 -0400
X-Gmail-Original-Message-ID: <CAEg-Je8q_nKO06X1uLLBmGzcHSRbiW6Th+KJdcv4QSQwVC_nNw@mail.gmail.com>
Message-ID: <CAEg-Je8q_nKO06X1uLLBmGzcHSRbiW6Th+KJdcv4QSQwVC_nNw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] arm: apple: Switch to standard boot
To: j@jannau.net
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Apr 18, 2024 at 3:00=E2=80=AFPM Janne Grunau via B4 Relay
<devnull+j.jannau.net@kernel.org> wrote:
>
> From: Janne Grunau <j@jannau.net>
>
> Use standard boot instead of the distro boot scripts. Use
> BOOTSTD_FULL instead of BOOTSTD_DEFAULTS for easier interactive use.
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  arch/arm/Kconfig        |  2 +-
>  include/configs/apple.h | 20 ++------------------
>  2 files changed, 3 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 01d6556c42..9b83b2e6f8 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1034,7 +1034,7 @@ config ARCH_APPLE
>         select USB
>         imply CMD_DM
>         imply CMD_GPT
> -       imply DISTRO_DEFAULTS
> +       imply BOOTSTD_FULL
>         imply OF_HAS_PRIOR_STAGE
>
>  config ARCH_OWL
> diff --git a/include/configs/apple.h b/include/configs/apple.h
> index a70440b3ad..1e08b11448 100644
> --- a/include/configs/apple.h
> +++ b/include/configs/apple.h
> @@ -9,26 +9,10 @@
>         "stdout=3Dvidconsole,serial\0" \
>         "stderr=3Dvidconsole,serial\0"
>
> -#if IS_ENABLED(CONFIG_CMD_NVME)
> -       #define BOOT_TARGET_NVME(func) func(NVME, nvme, 0)
> -#else
> -       #define BOOT_TARGET_NVME(func)
> -#endif
> -
> -#if IS_ENABLED(CONFIG_CMD_USB)
> -       #define BOOT_TARGET_USB(func) func(USB, usb, 0)
> -#else
> -       #define BOOT_TARGET_USB(func)
> -#endif
> -
> -#define BOOT_TARGET_DEVICES(func) \
> -       BOOT_TARGET_NVME(func) \
> -       BOOT_TARGET_USB(func)
> -
> -#include <config_distro_bootcmd.h>
> +#define BOOT_TARGETS   "nvme usb"
>
>  #define CFG_EXTRA_ENV_SETTINGS \
>         ENV_DEVICE_SETTINGS \
> -       BOOTENV
> +       "boot_targets=3D" BOOT_TARGETS "\0"
>
>  #endif
>
> --
> 2.44.0
>

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
