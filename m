Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7938BC021A0
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 09:56:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCC2D80F67;
	Mon, 17 Feb 2025 10:55:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s1rtaYbE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF90A80F68; Mon, 17 Feb 2025 10:55:57 +0100 (CET)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11FD580F56
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 10:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-520b58510c7so176587e0c.0
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 01:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739786154; x=1740390954; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7luH8a0FD8+Bd+2il2hG0L4ntH73xAGp1DN5LqGnQKE=;
 b=s1rtaYbEuTOkZbF5vbn6TI5Cc8qq3639bJBq7DE0ZNcM3n5V1smX3QnqrxTXOvobVJ
 MQPfXsifgV8+9GRndTGl8Lm4FmJfcCNshciibsegWKNaj3Z5KLDqCDPYQ2cq9il0m4AY
 s8QlTrEn66aeKiQG86jHoErcez7Slt0bGYbg7yD+9NZt5InkyeXWsIxKUtgyrtbZbz4B
 /08YUN//6llQGZPVvDWgAnJlbUcODSwEfIPGC4qB4xol1P/is2Zt0+is6L7RjSNgMypf
 xbGf63Dbz2JS8L4KM+WJ8Tu0rBoPa/wLBzwyUOos0PTkHBX16w8ltGL0By502NIGdjN6
 KESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739786154; x=1740390954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7luH8a0FD8+Bd+2il2hG0L4ntH73xAGp1DN5LqGnQKE=;
 b=MUcc5Pn1kjU60f/NYNyJzunpMVF8EeKZo/dPNsSNRM4e08E6IJaL1KuMVhWtt7TVVM
 zM2EwKLNZtK+3WoesxIz2nA1ql7q+cjfIYXPq++p+8XnAqRN9JCAEUDDa57HskVCamv+
 blp47igFYfpfatj7wg6lfn6HrNJX9KhnDkVM7nAjOVK+A6hB3F6wEROgTJT6aE2W4eUG
 7StGW3SfuLdcPkDDes8AXmUGqVvIZbPKnWN3R6ucw1/Xxf0G1MwseEIPZsYuCltT85fB
 ZvIUCj6J6nWf434BAMpZRwrt9Nvyk5D825k4zb9Jrlj6RHx0ET06fslpOMn2g5DfStUS
 SoYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX4P+5vQmzYakb0kcu0F2CiOw84xmnIzrZXI/Y1VviGKbaQ1ZbGx6Mw8KbbmEAjSACTs6QMAU=@lists.denx.de
X-Gm-Message-State: AOJu0Yxj8Y0mu8DQIuvGSXts8X4HqxPCFhWaWrDRl4Bm87qPum0oJUgA
 imQNgC8sOOTTbx9wqpJSLVb5C8XgjpXVYjFc/iOqJXjFcals66kD6FxdgbhBvL+fEKR2BKvM7B8
 Akd0mGNOa+vnVTJ1sr+iNswuBI6+Eg76melQOBw==
X-Gm-Gg: ASbGncvtCETWSwYF67whEFDAWyZsLbmTy/E0LC29rwwHfOXwy5yMEu6t3kWMvZr9Xni
 S16tDRXpUZvFNy9D+Y6cDyGk+x7mOyvUGMwZyuq8I9tQlDUizjyUP2ZXQT31xo8ie8GNycz0VUQ
 ==
X-Google-Smtp-Source: AGHT+IFsxPJmAOFzpFVmHmofIAzxT1Wl0VGRM2ovHm85qiwGdAdD5stzp+W3eHeFdODX9b2Hn/mkh/HNi6ISk5lWjpg=
X-Received: by 2002:a05:6122:21ac:b0:516:240b:58ff with SMTP id
 71dfb90a1353d-5209daecd9cmr2991443e0c.5.1739786153866; Mon, 17 Feb 2025
 01:55:53 -0800 (PST)
MIME-Version: 1.0
References: <20250216111241.6846-1-heinrich.schuchardt@canonical.com>
 <20250216111241.6846-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250216111241.6846-3-heinrich.schuchardt@canonical.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 17 Feb 2025 15:25:43 +0530
X-Gm-Features: AWEUYZmI6eU787X2sF4bjR6isHmm4d4E8e8i9up02b7a2-qIMtikL0uls2ogHjw
Message-ID: <CADg8p955dW_tPw597XqRDp5SkxeQRY0L96nHn+uVUzanPX1R6g@mail.gmail.com>
Subject: Re: [PATCH 2/3] lmb: move lmb_map_update_notify() to EFI
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Liya Huang <1425075683@qq.com>, 
 Adriano Cordova <adrianox@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>,
 u-boot@lists.denx.de
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

On Sun, 16 Feb 2025 at 16:42, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> When building with qemu_arm64_defconfig with CONFIG_CC_OPTIMIZE_FOR_DEBUG=y
> and CONFIG_EFI_LOADER an error undefined reference to efi_add_memory_map_pg
> occurs.

"and CONFIG_EFI_LOADER disabled".

>
> Move the EFI dependent part of lmb_map_update_notify() to the EFI
> sub-system.

Can this be rebased on the pmem patch series [1]. The pmem patches
make certain changes to the name of the function being tweaked here,
so it will be better if this patch series is rebased on top of the
pmem patch series. Thanks.

-sughosh

[1] - https://lore.kernel.org/u-boot/20250203105912.196654-1-sughosh.ganu@linaro.org/T/#mf8100ad07f82b781d14102b39948b36ec8edea0a
>
> Reported-by: Liya Huang <1425075683@qq.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Acked-by: Liya Huang <1425075683@qq.com>
> ---
>  include/efi_loader.h        | 15 +++++++++++++++
>  lib/efi_loader/efi_memory.c | 27 +++++++++++++++++++++++++++
>  lib/lmb.c                   | 31 +++----------------------------
>  3 files changed, 45 insertions(+), 28 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index dcae6a731a0..db3d20fd753 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -1263,6 +1263,21 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
>   */
>  void efi_add_known_memory(void);
>
> +/**
> + * efi_map_update_notify() - notify EFI of memory map changes
> + *
> + * @addr:      start of memory area
> + * @size:      size of memory area
> + * @op:                type of change
> + * Return:     0 if change could be processed
> + */
> +#ifdef CONFIG_EFI_LOADER
> +int efi_map_update_notify(phys_addr_t addr, phys_size_t size,
> +                         enum lmb_map_op op);
> +#else
> +#define efi_map_update_notify(addr, size, op) (0)
> +#endif
> +
>  /**
>   * efi_load_option_dp_join() - join device-paths for load option
>   *
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 1212772471e..11d092dc289 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -865,3 +865,30 @@ int efi_memory_init(void)
>
>         return 0;
>  }
> +
> +int efi_map_update_notify(phys_addr_t addr, phys_size_t size,
> +                         enum lmb_map_op op)
> +{
> +       u64 efi_addr;
> +       u64 pages;
> +       efi_status_t status;
> +
> +       efi_addr = (uintptr_t)map_sysmem(addr, 0);
> +       pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
> +       efi_addr &= ~EFI_PAGE_MASK;
> +
> +       status = efi_add_memory_map_pg(efi_addr, pages,
> +                                      op == LMB_MAP_OP_RESERVE ?
> +                                      EFI_BOOT_SERVICES_DATA :
> +                                      EFI_CONVENTIONAL_MEMORY,
> +                                      false);
> +       if (status != EFI_SUCCESS) {
> +               log_err("LMB Map notify failure %lu\n",
> +                       status & ~EFI_ERROR_MASK);
> +               return -1;
> +       }
> +       unmap_sysmem((void *)(uintptr_t)efi_addr);
> +
> +       return 0;
> +}
> +
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 7534a231c99..93fc1bea07c 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -426,37 +426,12 @@ long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size)
>
>  static struct lmb lmb;
>
> -static bool lmb_should_notify(u32 flags)
> -{
> -       return !lmb.test && !(flags & LMB_NONOTIFY) &&
> -               CONFIG_IS_ENABLED(EFI_LOADER);
> -}
> -
>  static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size,
>                                  enum lmb_map_op op, u32 flags)
>  {
> -       u64 efi_addr;
> -       u64 pages;
> -       efi_status_t status;
> -
> -       if (!lmb_should_notify(flags))
> -               return 0;
> -
> -       efi_addr = (uintptr_t)map_sysmem(addr, 0);
> -       pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
> -       efi_addr &= ~EFI_PAGE_MASK;
> -
> -       status = efi_add_memory_map_pg(efi_addr, pages,
> -                                      op == LMB_MAP_OP_RESERVE ?
> -                                      EFI_BOOT_SERVICES_DATA :
> -                                      EFI_CONVENTIONAL_MEMORY,
> -                                      false);
> -       if (status != EFI_SUCCESS) {
> -               log_err("%s: LMB Map notify failure %lu\n", __func__,
> -                       status & ~EFI_ERROR_MASK);
> -               return -1;
> -       }
> -       unmap_sysmem((void *)(uintptr_t)efi_addr);
> +       if (CONFIG_IS_ENABLED(EFI_LOADER) &&
> +           !lmb.test && !(flags & LMB_NONOTIFY))
> +               return efi_map_update_notify(addr, size, op);
>
>         return 0;
>  }
> --
> 2.47.1
>
