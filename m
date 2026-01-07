Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B34CCF6BE2
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 02:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D47A83CDC;
	Wed,  7 Jan 2026 03:42:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SZvmbU43";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C142083FF9; Wed,  7 Jan 2026 03:42:14 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB9F283C6E
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 03:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64b791b5584so2570129a12.0
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 18:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767753732; x=1768358532; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vwZ3NEFggx9tdlSkRM+f7GIF+t2/Y/eYGVCE+fZTLqc=;
 b=SZvmbU43jOTsrqkECqnYOUf9QVBwlFBcyucd5C3pi4S82+KyAqn/+euZPtHrkA2+ye
 vO/owAGv1cQxz1Y0060x0ceuiOl5YMKwNoMPJ/DOjF2FZgRgr8co3DkQSye0WKHtbNnY
 N1C77hYS/rgq/t0K+TEahzvKQC05d5Dp8crYLhGQt6xbgXWo+MSkl5TpiXmcVoenTbjU
 r7ga7CieaP04l0DeMx5/p/154EmdjT5MXdAG/xjpk7Z5lYuQ4fPKx2iFJsaJrPIzzDEu
 +BS8M4h/vrowLv+wsBq/nUOS1wQvBfZ8ifE5rbqooPOfwyAWDwrI6BtEVbn0sfJV85BD
 A6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767753732; x=1768358532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vwZ3NEFggx9tdlSkRM+f7GIF+t2/Y/eYGVCE+fZTLqc=;
 b=coy/qIbOt0PDtzoJJZwMQnTaC05rX5/ajEaw789v5XK3nYRrjG37glohUMAD9M6wzH
 B5ws2Vb5ZhrEc5Ru5xHWm2FRuyAQKDdNzdy1uikPoetwrbOy4oyexF0nQTXiokytc5ye
 7S+Vem0AObMEuNis8U7IV0xgnnyhzfP5VNpfKZkk7eyPFp8SHDdGaXdLK0FFRuZTL75g
 nuBrtwp9gF7QzLhMUniJgI3zzmegSqgXcvDnLAR0A/ATnSDL/NNcLnsFvS5vRIUEXNoc
 2QHJgHs8dYQUBjNR6a/aRaHtCA9au+BqEkHku15CIFFoD+CIydQnhXyCkPSZere+EtI8
 E1+g==
X-Gm-Message-State: AOJu0Yw4sqBjNWAxNgCuuSF1rsaZoKpVMxW6AKT+29lZG58TcRcNs7aD
 Im1V447t+Ac5z3d6Jnp/6yO/HMTLXxDF4anU18dyWOHRbHk0cLrkFv5yGY/60cDz84jeAGVb4uA
 12hyOBAGAtIzgpeqvZSuM+wVyY+Uajqg=
X-Gm-Gg: AY/fxX4IpP7dU/Ai9yrRDO4lm7FHMn6RKswdPuO7UtxrWjdxq33C4to511foPza8sKB
 3/wDsoco/jHFIWWJiZBm8o9y8U09SuvTe1SlOHe1+rmZbTDR+xeT8Pyu+p/Bhz1iTi/VQsnc7v7
 AvIy1iGl504XTOo/0Kn7yueVpCQ+pvzpxsuVYXKzSx0rIzKXvN8iXZJubvAPB2ko7lfbzh4OENa
 O/pTg3p3q3K+ROvUDoUtf9kOMy/lWkQULvn103yiEGhdPEuYN646N3+BJFqMlvVhF8bMF2EEKMB
 Hal7ufDZk+loFZrwo/rZmoUYhIPxr+xyS6jtk8+S/9MZ/texftmx1lHEni5G2UJe86tunqSgKsN
 k/62AgjGgfiiu3bR55QZsgI8ghM4B8bzMUfrg0RS3gQ0yvO8=
X-Google-Smtp-Source: AGHT+IHHvwXOkIvSp/CdITsbGKM47j1lsXDvLltaUxEBlkTXfDtNHvqe0RMVK+HrsK8enFyFIE94vBwx6/rImQb/CXI=
X-Received: by 2002:a05:6402:a247:20b0:64b:4460:c772 with SMTP id
 4fb4d7f45d1cf-65097e5d58dmr710375a12.19.1767753731940; Tue, 06 Jan 2026
 18:42:11 -0800 (PST)
MIME-Version: 1.0
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107003131.3064800-10-simon.glass@canonical.com>
In-Reply-To: <20260107003131.3064800-10-simon.glass@canonical.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 7 Jan 2026 02:42:00 +0000
X-Gm-Features: AQt7F2r3yQvtB5MEeMp2TP0cthj4N5Wtt5rYt__NFiznXv8BZrFBAiqdJGmixW4
Message-ID: <CALeDE9O-jkytOaioLBKr_vui0Q7TSAZGmTkNY6ssJ4EkZD_OtA@mail.gmail.com>
Subject: Re: [PATCH 09/10] efi: Drop EFI_GRUB_ARM32_WORKAROUND
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <simon.glass@canonical.com>, Adriano Cordova <adrianox@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymondmaoca@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Yao Zi <me@ziyao.cc>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
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

On Wed, 7 Jan 2026 at 00:33, Simon Glass <sjg@chromium.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> This work-around dates from 2019 and grub 2.04 which is quite old. New
> builds of grub don't have the problem and old boards presumably use an
> older U-Boot, so don't need this.
>
> Drop it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> ---
>
>  configs/mt7623n_bpir2_defconfig |  1 -
>  lib/efi_loader/Kconfig          | 10 ----------
>  lib/efi_loader/efi_boottime.c   | 26 --------------------------
>  3 files changed, 37 deletions(-)
>
> diff --git a/configs/mt7623n_bpir2_defconfig b/configs/mt7623n_bpir2_defconfig
> index 404380558f2..d75168a72ed 100644
> --- a/configs/mt7623n_bpir2_defconfig
> +++ b/configs/mt7623n_bpir2_defconfig
> @@ -13,7 +13,6 @@ CONFIG_DEFAULT_DEVICE_TREE="mt7623n-bananapi-bpi-r2"
>  CONFIG_TARGET_MT7623=y
>  CONFIG_SYS_BOOTM_LEN=0x4000000
>  CONFIG_SYS_LOAD_ADDR=0x84000000
> -# CONFIG_EFI_GRUB_ARM32_WORKAROUND is not set
>  CONFIG_FIT=y
>  CONFIG_FIT_VERBOSE=y
>  CONFIG_DISTRO_DEFAULTS=y
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 13e44be1d06..5585c841c27 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -505,16 +505,6 @@ config EFI_LOADER_BOUNCE_BUFFER
>           hardware we can create a bounce buffer so that payloads don't have to
>           worry about platform details.
>
> -config EFI_GRUB_ARM32_WORKAROUND
> -       bool "Workaround for GRUB on 32bit ARM"
> -       default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
> -       default y
> -       depends on ARM && !ARM64
> -       help
> -         GRUB prior to version 2.04 requires U-Boot to disable caches. This
> -         workaround currently is also needed on systems with caches that
> -         cannot be managed via CP15.

This also states that it's needed for systems that can't be managed by
CP15, what systems are they, how are those platforms addressed?

>  config EFI_ESRT
>         bool "Enable the UEFI ESRT generation"
>         depends on EFI_CAPSULE_FIRMWARE_MANAGEMENT
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index 0bc66ee61a8..c31ee53cde6 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -2139,29 +2139,6 @@ error:
>         return EFI_EXIT(ret);
>  }
>
> -/**
> - * efi_exit_caches() - fix up caches for EFI payloads if necessary
> - */
> -static void efi_exit_caches(void)
> -{
> -#if defined(CONFIG_EFI_GRUB_ARM32_WORKAROUND)
> -       /*
> -        * Boooting Linux via GRUB prior to version 2.04 fails on 32bit ARM if
> -        * caches are enabled.
> -        *
> -        * TODO:
> -        * According to the UEFI spec caches that can be managed via CP15
> -        * operations should be enabled. Caches requiring platform information
> -        * to manage should be disabled. This should not happen in
> -        * ExitBootServices() but before invoking any UEFI binary is invoked.
> -        *
> -        * We want to keep the current workaround while GRUB prior to version
> -        * 2.04 is still in use.
> -        */
> -       cleanup_before_linux();
> -#endif
> -}
> -
>  /**
>   * efi_exit_boot_services() - stop all boot services
>   * @image_handle: handle of the loaded image
> @@ -2245,9 +2222,6 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
>         /* Patch out unsupported runtime function */
>         efi_runtime_detach();
>
> -       /* Fix up caches for EFI payloads if necessary */
> -       efi_exit_caches();
> -
>         /* Disable boot time services */
>         systab.con_in_handle = NULL;
>         systab.con_in = NULL;
> --
> 2.43.0
>
