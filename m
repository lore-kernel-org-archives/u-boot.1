Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002EACF6BE2
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 02:35:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D11183C6E;
	Wed,  7 Jan 2026 03:35:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YdeNYwGo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C261C83D0B; Wed,  7 Jan 2026 03:35:31 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF03D83C4B
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 03:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-64d4d8b3ad7so2469615a12.2
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 18:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767753329; x=1768358129; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3tx5OfVEwlFnJbC9FTdO+QuLydA8s3mQhlYDgOTK3Vo=;
 b=YdeNYwGoWWJn0GUCdOfKpZ8baOUg2uT29CVmtIh0cgG0bRnwrcfvzWgRbx55bZ41zf
 Xqm4MVvK2i7HaVqYve5rcqw1QkTLfrGjVtIIjuU0SkK2xq4FENqbcP1hw5nptnrOs/m1
 hVF1c3WIQGG1YJUIzBlVLuBJBIUoETtgV7ETSAke1SlNfF6PdUvlkM6sWqjTuGWoLc8K
 3Lm6skHkEE6NDFgJR+jOz4tIqSWu0n9zcI4rng8HvCwm8hSOGK8EpZ3zNy0NKzMcYYlD
 a/flsenXodwuDpeFvM+4tlUfu65zIjemL1Jhxn96HquNEpPM4/lst3a69SpUHWHkcW0e
 9e2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767753329; x=1768358129;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tx5OfVEwlFnJbC9FTdO+QuLydA8s3mQhlYDgOTK3Vo=;
 b=sKL7fEc8hKmPhzTRxiL3gcnwGcfcvSZeDiV5Gg44VzOJa9ppGXmfYlUvro1ihtuLyo
 0ma7E4PENrSjQpl9R9AP766ZxSJOeqoDvQJL+uPGos2V3Q+1rHuL4pVX1KU293YjxL5i
 g5U/xrN8nI4TbLkrWhFvLYtvdjHsxkD9QnNqQjAKB+ucwAPWEfdYHV+FGEVNM4kjw+R1
 udMM025hKA1xDR7rUSaGb5IPtAH0eXU+rovz7fgSJnD4GaWT+30q1kmbnIBwuMGeWZ7a
 OqQ0o/+mZXOKSRaWJOUHHbRjSlR4X0Rqq4t4zw4hkdnM1GP0BGINzj7wZzazYOsTM+Q1
 EYdw==
X-Gm-Message-State: AOJu0YzpWo91a5iGKKhm4lvBwFrCZ1QWESF7ZoZddl8cR0P0Tu1416l4
 XmOvHPm7r/3Fe+xzS98WbdFDyBDIX0t7YGxNR9Bug/CHYg3s4Wg1qcjjoBAD4ihulmNP/A4vyVw
 3vFyEQ82y3mXsgi0b6vMubHBpA3qJIgk=
X-Gm-Gg: AY/fxX5VfipO9i46/O6EF6z0EeFljBp95VeZ+AOejEjACMTYIBDZM+uanbXRsWDw4PJ
 2fcP00iACl3nVCSqfHQwpj5VbALrZoF/TdIkYyc8/2aRojumajs8xJP3WUJs/hDo9xcw8tVjUsi
 QWDRkkv4c182ssnpMsfN26t2F1v6OFnO3Qmee6YTrbHNykLrVlj4YV9ecGQt8hb2jBLmPpNxfJ+
 X+AacxFYxd9N95/B8S6AJ9dVuHnN/OygjlMLgW8meISsDm8LgtPTj89J5EmcRwJ735rk4CCKjbm
 2uTwe78hLHQaHWMLHPkThoNqvnom9d/vcQEf965zzJUw757YIHWvkjFGYo4dBctbudVGzqg8iqJ
 6n0Igjo1I2t3MU1rIwjizTGIuRQlU/IucTSLl
X-Google-Smtp-Source: AGHT+IE7YuRNlX8q5DX5IhkCQgBIVTjDE6GlGk0uFI7fs8yt4XdxTi0OPgwyN5+mqFUC1DPLqUbNEeLGQunkL6h/O5U=
X-Received: by 2002:a05:6402:5253:b0:64b:420a:49f6 with SMTP id
 4fb4d7f45d1cf-65097e8c0b8mr893111a12.32.1767753328981; Tue, 06 Jan 2026
 18:35:28 -0800 (PST)
MIME-Version: 1.0
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107003131.3064800-10-simon.glass@canonical.com>
In-Reply-To: <20260107003131.3064800-10-simon.glass@canonical.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 7 Jan 2026 02:35:16 +0000
X-Gm-Features: AQt7F2p6Vdj0ZccoyR2gRyRasEaCoQmiOjy5KBdSh3gG8qoWgSz5vOeN67NpNm4
Message-ID: <CALeDE9OvOKBqHJDBZhzvwFRm-=kq5ZYOcAxaGoesZokPZ09sdg@mail.gmail.com>
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

As stated in the cover letter, this should be sent separately so it
can be assessed on it's own merit.

On Wed, 7 Jan 2026 at 00:33, Simon Glass <sjg@chromium.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> This work-around dates from 2019 and grub 2.04 which is quite old. New
> builds of grub don't have the problem and old boards presumably use an
> older U-Boot, so don't need this.

Just because something is quite old doesn't mean it's not still
needed, please describe the what the work around achieves, why it's
not needed any longer, the benefits of dropping the workaround, eg
does it slow boot process down?

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
> -
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
