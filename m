Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DA4CC6B3D
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 09:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FF14839DF;
	Thu,  2 Apr 2026 11:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b+1x4emI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 974FF83CF5; Thu,  2 Apr 2026 11:22:00 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28BF380212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 11:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-79ea87af213so26972717b3.0
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 02:21:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775121716; cv=none;
 d=google.com; s=arc-20240605;
 b=W3z49/Uc/OsL6j8j9oN3pGKqk3y7UFDvJxeBpqr3Ho49XNUzJSWegC+Vxc3wdBHIRG
 tQ/uslTSrsf4wdJw5UHQeDVxNHz+vuEXw758ve8A5COyLwlkKAddBS2gRFBDWM2uAgCp
 jHHA9GOB9+XH0TFwUrUxqyUaYTFeTDODF2LLXxYGzfDb7dkRhZaUBI/8HHtWhwJsRetk
 GoWPpvA9wXhXbFDFLe7XcYQubsQtKNbWRsPho369DJE2vjQmomtHu7c/Pt4hTd0IZlQv
 1x4mH7bLIluMLL92cyf+HDq8LZVVCV84cNyX5J+cFpyd6I+j+IoTiLx+Zm9pMG/Q1AzI
 r7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gJd4K7iwc8qMg8xbHsaBYPPE2P25zr9EcXX0QXgcCOg=;
 fh=reNont7UWUvVo7w8Q8E0JSzyBrFAaXhFI89XZCyYCVU=;
 b=cjX3A2oGjf1XLMydZvF0o76Yrw4/KQJtMweQbw3v1jdgl4iMV2byItNWa5ICzfPau+
 TutQE+G5p/EIHJqptPPOEH2F3PrVH1nrSxBUk9/rO79rLKvPviGhbY3yNHdP66KBtQ8p
 lose1j6pMJuRNX+Y9baDr6BJqr0Es4GgtbYMGUPoQke3FmRmBDgsBjvX0HLV41oqs6wl
 tsXIj+aOKXKi4ZaMam0gp35kdaWsW2qts4+yZmiqWzfbKnWHdLr1sydWN9jDB88CYjpz
 hemOV1TcGS1+9tOa3thqAW7EWu73iTjTm+8QCmL2qcuL+/AFYv5SmoLxxqyt4fw5MO0L
 G2Yg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775121716; x=1775726516; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gJd4K7iwc8qMg8xbHsaBYPPE2P25zr9EcXX0QXgcCOg=;
 b=b+1x4emIdTNHbZ3fLqzdwwaTduHS0h4Y/HDyk+FgJ2axt3UyysjhQrbB9RhwrCiGKI
 dH87TnwVTcgSW2+BZ3nKtExW+2VtrVJZ+DDITlOVHSwwYa9eS5P78vlKZzuAOY6noGQs
 qMkFGaDby+JrFW2QiiR7oinA1BvIgbpNNV2AacvkD6XS1hE2TTUX6ACTT53i723m3qzE
 6Rsxxl0LVe0Mbut5DLucjtCvTdihG8dj7eygsNpsR+z86EnGS5KlgUWyQAuh8sHa8jE8
 x8u8HMsEUiX0dwQTl6bQOLiMBrqVRR+EzB7v3tAZG5NHFK3v9/45oKcroknJ2g7S0VVb
 DtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775121716; x=1775726516;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJd4K7iwc8qMg8xbHsaBYPPE2P25zr9EcXX0QXgcCOg=;
 b=DO3yTqOxD5Yjs3JL8PuglOdwTrH2QjQ7Ddq0ejA7/Xv5CA6izzpnKSDpEqqoyYUdld
 4katpEV951PWryGOR6pKC8g8eJEyInlrQsGMCHx60tVIXr1TwtMk8FzSaW2CRCt+aJy2
 f20VG7cIgW1ny/FychzUXUb7yS81GKoUNXscFmxwjM4bcM17UByQ2RrqOEWzVTzEuvs2
 +LtcwmegKussBWDSq7KODeVLAg6ex0FcT8RQIiE4uGeHwJ4EVUQaOmM6YMZkbusdmogM
 9QUAWVRLIUf8ay8xt/9oyaKhqYisS/63xms1UsU1bPRzzKS4otS8OUf6R4fVKwxXAmye
 FaBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWb7+oZlaaYFWs03E6q+OZPw/Be5+Ejm6W9DlT4tGXloLfIs8ApjGeCbtoJs/NHfvaDkNvueU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8rktiYWLudSisMt9iawK0NrByOoGF/isGJn4QtfLoXeC2+ItD
 UbrVEbU2+xdyp4TjGFCv8bWv/B09OkQqQqy9mJUDOxDyDaz8L7vesGIhZzNjaQGDk/QwqTSz6as
 w3rseOCvsRSwqc7EnbQWvZzu1PMvgdaSMvewr5RmecCNbWMCQdp7VFCw=
X-Gm-Gg: AeBDies4XeeMJ+Kqwe+wFd3TOyJ7nBc6mbXg9q6GF5WGDK96j0JnBrQCYHuI1OTNKkz
 q9x6g5Oeq39du1zJYlrU8eqWfj6EIZ+agG0vo9/Po2uVl/9k1vUSABDRERNRAm+3LzABDHhDX9b
 VKAg6k7nqkyZ93GaMVEyjYqqTchN/uFhhTuVHy0MmvWZe0yfCDLFS9oX95Ds3buFkwya+Hi7Y19
 3/1qkSq/in07QSsy7oIJDIW7BL2hHG12ZGWiUNsXnF3UiYQV5xmXvW7W8XnRcmK3Ok3f5X9jmu6
 ZOM8ic8ofLOnUaJOAuxim9nZjcA8uWVOcu2BnF+66/zTn6LnpOF4XJex7U/H0hM/da27fVTZIWI
 xmbmqNc4F4/MGO/D0x9mEe7l/+QZIWj2fozNLo5ePP0OrGLpaCyWw62Z8zmSPZYG0uHTQFdzksW
 sEJNJTrAepUz2btkDiExOhNwuUnFv6Z4EYPCj79CBF2+sOP20oj0y2Bz8oTWm54yqtlV9vNoPK3
 OP6Ce9txLVxe52lJnY0AUOiq8J3y2Za1+qQR0qpAQNdcRSB6DoKG9947lbU6ABMmoIVRNCiJBuQ
 vxTxmzrT0Rt1YEd1IKscIRA6zvufpmFJ057nvJ5zod4R
X-Received: by 2002:a53:d015:0:b0:63f:b6c0:23f8 with SMTP id
 956f58d0204a3-6503d8ad49amr1026435d50.33.1775121716030; Thu, 02 Apr 2026
 02:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260402001410.3736815-1-rs@ti.com>
 <20260402001410.3736815-7-rs@ti.com>
In-Reply-To: <20260402001410.3736815-7-rs@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Apr 2026 12:21:19 +0300
X-Gm-Features: AQROBzDagyJ3VYrmDmxKEyu8jJfOaHVi2KOTQjyx1A54cY-P7nccXsGupGnrlBs
Message-ID: <CAC_iWj+VbbyyJS57DBMwbkCK2LoZi2WXu4pS11hRL+jzXXPpwA@mail.gmail.com>
Subject: Re: [PATCH 6/6] memory: reserve from start_addr_sp to relocaddr
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, u-boot@lists.denx.de
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

On Thu, 2 Apr 2026 at 03:14, <rs@ti.com> wrote:
>
> From: Randolph Sapp <rs@ti.com>
>
> Reserve the memory from gd->start_addr_sp - CONFIG_STACK_SIZE to
> gd->relocaddr instead of gd->ram_top. This allows platform specific
> relocation addresses to work without unnecessarily painting over a large
> range.

This hangs when trying to boot with UEFI on QEMU aarch64.
With the qemu_arm64_lwip_defconfig and this command line

qemu-system-aarch64 -m 8192 -smp 2 -nographic -cpu cortex-a57 \
    -machine virt,secure=off \
    -bios u-boot.bin \
    -device virtio-rng-pci \
    -drive id=os,if=none,file=my.iso \
    -device virtio-blk-device,drive=os \
    -object memory-backend-ram,id=ram0,size=4G \
    -object memory-backend-ram,id=ram1,size=4G \
    -numa node,memdev=ram0 \
    -numa node,memdev=ram1

It also hangs when trying to initialize the EFI subsystem in general,
e.g 'efidebug memmap', probably because some EFI code is relocated on
the region you exlcuded.

Thanks
/Ilias

>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---
>  lib/efi_loader/efi_memory.c | 4 ++--
>  lib/lmb.c                   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index f07cc39b157..57691d15758 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -915,8 +915,8 @@ static void add_u_boot_and_runtime(void)
>         /* Add U-Boot */
>         uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
>                        uboot_stack_size) & ~EFI_PAGE_MASK;
> -       uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
> -                      uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
> +       uboot_pages = ((gd->relocaddr - uboot_start) + EFI_PAGE_MASK) >>
> +                     EFI_PAGE_SHIFT;
>         efi_update_memory_map(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
>                               false, false);
>  #if defined(__aarch64__)
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 542bb11dcf5..0df8157db7f 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -540,7 +540,7 @@ static void lmb_reserve_uboot_region(void)
>         ulong pram = 0;
>
>         rsv_start = gd->start_addr_sp - CONFIG_STACK_SIZE;
> -       end = gd->ram_top;
> +       end = gd->relocaddr;
>
>         /*
>          * Reserve memory from aligned address below the bottom of U-Boot stack
> --
> 2.53.0
>
