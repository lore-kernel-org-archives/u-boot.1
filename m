Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DA9C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 10:04:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1392D83FB0;
	Fri, 11 Apr 2025 12:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a8UALfHo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C482383FB2; Fri, 11 Apr 2025 12:04:50 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88FA383FAF
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 12:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e6dd991a0e6so1416065276.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 03:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744365887; x=1744970687; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zrv4glQhwtt3PIAr7Snq8Hosj2XIWQ17rrEDlVwZ4uQ=;
 b=a8UALfHoCIOVcDnJfgNYl5FlCokuzsSsiVRZloesVLzV/3W3xz011HY2aYu9B0LnW9
 j/VeiPxAtxU6ZN88d2cZRTVvrf6f0NYv/5koEhfXeLXcV/maH8iUjU7qFlq4xMTOGqy2
 gMoxn5C6WKv0DD3BGz9q+2SO2tuzxGp1mY8W5YEaQ9NhbHJgBedc3dEP0wamDSIQO9L2
 LMCqMuQu0UvphtFVZ9aAdi8iVwHDiw6RtoBG6KoqtIR13wmLdbJZlTsgV/bODQbjbLNz
 RCDJGxqS/RgrO5BKPb9PiBDTou+lGkMa0dGBQ0Ss7iTTuBTOPCkMVf8j6ya3tY5+XBNq
 WYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744365887; x=1744970687;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zrv4glQhwtt3PIAr7Snq8Hosj2XIWQ17rrEDlVwZ4uQ=;
 b=qaQzitvougl7wgAU/ZFIqvRjvvbfP3EkTaQsLMHjxaLmrskKIvZEKavjfwc6pVSLG4
 LzfG6m6dRExQk74VjDy5pHazL7BZ/QACA+Tw8wjME7JOwQyUS8521uS4wcTvqj6eZOh5
 ymzpRaqopK9kgv00TZiOUglkratU+Is+obZOZN2Li3oC00pQATCTMdRfhNXb81x91wQf
 EAUIzeFb6MRveJ57dSXg91cdlgGpSV403W6tNBBWfAgAysc11zf5DW7Uyv2Wdd88B/Zf
 EQeDUpuJPPOUhZWk5Rczi+lHAP0K66YE1Sv6p/SvxpP5bdt5TAos1mLSzs1Y6ERlNqqV
 Kd/g==
X-Gm-Message-State: AOJu0YzuHlgnDRXJ0BVnMfSzZpsJd/raycuqEdcdW22/DQM2C+O1AOOa
 GHTSiShabMkshzIn3c8RZIjQ6VXkWbvtxnTQTEuISAwsnw5gmMLmx9NxiOuwz+6LEgbnN34gyMc
 F3OpkqRoIxwhUqJdek5pHUjxRYVDUKQPEqkXPtw==
X-Gm-Gg: ASbGnctysG+qC9Z/V5MXNVvNk9HT1RcURvOJ53CydXQCpFceBHmQYiJ3uDOzKN6hD1u
 vbvXJLuu8GBDXyaZQAb+SOxlYnjQdJd8L64ymc2QG80+9C9ownJKi1XcCUXti1QcK24iAl8IxSr
 SF52LuTh/Zmu+iSzf4wx4TzoY=
X-Google-Smtp-Source: AGHT+IGzqH7j9kU0gVYk6rd6bWzHfQGV9jnazN/T0JLko1idlDy6hY9byYO0tH0/5A0w0pOmzPp/J6T1Zxk27migwCc=
X-Received: by 2002:a05:6902:1b07:b0:e6d:f7ea:c722 with SMTP id
 3f1490d57ef6-e704de9c3eamr3540860276.17.1744365887174; Fri, 11 Apr 2025
 03:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250405204409.420738-1-sjg@chromium.org>
In-Reply-To: <20250405204409.420738-1-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Apr 2025 13:04:11 +0300
X-Gm-Features: ATxdqUH2wJiMgz54iXc77NHY7dZFrlHWuQ8i7VQz0NjhktbD2Jdc1OrLECk5Pog
Message-ID: <CAC_iWjJ07Z4PqZa9mXSnzp5TjsgXr3RL6FxSL2EV0oX7p8uN_g@mail.gmail.com>
Subject: Re: [PATCH] x86: efi_loader: Ensure the SMBIOS tables are sent via EFI
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Niklas Sombert <niklas.sombert@uni-duesseldorf.de>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Simon

On Sat, 5 Apr 2025 at 23:46, Simon Glass <sjg@chromium.org> wrote:
>
> The EFI-loader code has not been fully converted to use bloblist, so
> relies on the SMBIOS-table address being set in global_data.

Can you explain a bit more what this means? The SMBIOS tables for EFI
are supposed to be on EFI allocated memory

>
> Set this up in write_tables() so that the SMBIOS tables are actually
> available.
>
> Enable the command for x86 QEMU so that the SMBIOS tests actually run.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 83ce35d6ebb ("emulation: Use bloblist to hold tables")
> Reported-by: Niklas Sombert <niklas.sombert@uni-duesseldorf.de>
> ---
>
>  arch/x86/lib/tables.c            | 2 ++
>  board/emulation/qemu-x86/Kconfig | 1 +
>  lib/efi_loader/efi_smbios.c      | 1 +
>  3 files changed, 4 insertions(+)
>
> diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
> index ec52992209f..d7f183f95dc 100644
> --- a/arch/x86/lib/tables.c
> +++ b/arch/x86/lib/tables.c
> @@ -126,6 +126,8 @@ int write_tables(void)
>                         use_high = true;
>                         if (!gd->arch.table_start_high)
>                                 gd->arch.table_start_high = rom_addr;
> +                       if (table->tag == BLOBLISTT_SMBIOS_TABLES)
> +                               gd_set_smbios_start(rom_addr);
>                 }
>                 rom_table_end = table->write(rom_addr);
>                 if (!rom_table_end) {
> diff --git a/board/emulation/qemu-x86/Kconfig b/board/emulation/qemu-x86/Kconfig
> index b2a4e0891a4..c1564fba7cd 100644
> --- a/board/emulation/qemu-x86/Kconfig
> +++ b/board/emulation/qemu-x86/Kconfig
> @@ -23,5 +23,6 @@ config BOARD_SPECIFIC_OPTIONS # dummy
>         imply VIRTIO_PCI
>         imply VIRTIO_NET
>         imply VIRTIO_BLK
> +       imply CMD_SMBIOS
>
>  endif
> diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
> index 8d2ef6deb51..5275e966dfe 100644
> --- a/lib/efi_loader/efi_smbios.c
> +++ b/lib/efi_loader/efi_smbios.c
> @@ -35,6 +35,7 @@ efi_status_t efi_smbios_register(void)
>         void *buf;
>
>         addr = gd_smbios_start();
> +       printf("register %lx\n", addr);

I don't think this print is useful at all, why isn't the log_err()
right below enough?

>         if (!addr) {
>                 log_err("No SMBIOS tables to install\n");
>                 return EFI_NOT_FOUND;
> --
> 2.43.0
>

Thanks
/Ilias
