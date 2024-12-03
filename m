Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BDBE64A84
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 12:06:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDCC489647;
	Tue,  3 Dec 2024 13:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KZJzzbn9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 890698965F; Tue,  3 Dec 2024 13:06:54 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F9638958D
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 13:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5d0bdeb0419so4472425a12.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 04:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733227612; x=1733832412; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=07i6l01iKAlv1S78ul9DfHe0sLhEOQBazWlGXgWLfFE=;
 b=KZJzzbn9ZyCElYqDVSmBloonkVtdOacc8sejJoEsad3nlBgABDkrZR2vqRQow8zEo+
 IXPV/XaacVBDHs7+L7HZhFoKtwKr2sGl36KgUZxfSJJbPx2Hp06gtreT3ciFI6oVR0Ok
 qI7QkdgEAcfE8fTnL19cMqf565Vit2RjSKvyjNiE9jQyv/7FdwYO8CgGxKSx+2rNPa1K
 eNchf/CTZssLJ+bGa/a4TaCw87wuOH/HzqtpPaB9F/vNH1rBEwU8Nq49L80VE7uZ95zi
 tg1puhaIsqm9IW5mPYAuYBH3nzTP4CTQNVmILTm/goDijUqIrmLgXteO6d6zqZNArfD4
 vhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733227612; x=1733832412;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=07i6l01iKAlv1S78ul9DfHe0sLhEOQBazWlGXgWLfFE=;
 b=V/qGW3XkP4PIYDXckuJh/MbTkk9hNFNR5K/r8CBcPGT1n2rYBgMNmfPSM9uCzoOmbD
 wYuLVtvFWUD0af9v6fk8AvVm+wUnhkBsQhO5BFS9k0gl5QTvBXePJTXem8hTRW9k3Agi
 tjnpN3kWk1SMbzcjTl19RQ2BS/H5vo5FlV0ovhzkwiAgcOeDLA/oGYK3nTguLAPHWKzD
 Qf2hSPGfFoeJCEL0IlDD66zrjy+GhoLMpSA/zzpzL7pN4cs/3u1KTNm+Wz6BGEkXmyyJ
 1ijyUNOVz1Z97aQPakEC/f7LZNf7JMp5XkkcdRdcIoaNIH+uBGke8PnrZcPTYg9FNIdG
 ee+w==
X-Gm-Message-State: AOJu0Yz2/bbnP5OBhX4kf0PkWpoQcqmO25us9q8No389EoVGRBdscLOn
 nQytqceXtPRbPVJj+pQZes2ThgFnupK/uQagauFRpf1wcPsRSSf2D5sqVqBci8h7MJv/pyOx4Dd
 JeTGHUoKoU5jcynGKsgCaNmi1ckC5JkCPyvUahq2zAGPmF/8VJWo=
X-Gm-Gg: ASbGncs2FOBieCTs6C4iua5IRWLC2lS5uO8NuehGsR6WNmDSnRGjuMg55SCH3B/OrUJ
 H7O9faYwerXEO3tiiq75purAHw6WThYSz
X-Google-Smtp-Source: AGHT+IFLam1kqOpQke0OLKenRLGiu4GEAsH8nvAUEkcATNfPbRehNocIv2XkzMpvCvrw+4xXMAnMNdP0bXftlGxok4A=
X-Received: by 2002:a05:6402:42c8:b0:5d0:ceec:deec with SMTP id
 4fb4d7f45d1cf-5d10cb55abdmr1928185a12.13.1733227611617; Tue, 03 Dec 2024
 04:06:51 -0800 (PST)
MIME-Version: 1.0
References: <20241201152815.1668093-1-sjg@chromium.org>
 <20241201152815.1668093-7-sjg@chromium.org>
In-Reply-To: <20241201152815.1668093-7-sjg@chromium.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 3 Dec 2024 17:36:40 +0530
Message-ID: <CADg8p946omqMf9QAzwU_Aa6wbPFkfO3sUpAWebn1DraUoN7rUQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] efi: Show the location of the bounce buffer when
 debugging
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Moritz Fischer <moritzf@google.com>
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

On Sun, 1 Dec 2024 at 20:58, Simon Glass <sjg@chromium.org> wrote:
>
> The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago. It is
> still needed and 24 boards (lx2160ardb_tfa_stmm,
> lx2162aqds_tfa_SECURE_BOOT and the like) use it.
>
> This feature uses EFI page allocation to create a 64MB buffer 'in space'
> without any knowledge of where boards intend to load their images. This
> may result in image corruption or other problems.
>
> For example, if the feature is enabled on qemu_arm64 it puts the EFI
> bounce buffer at 1045MB, with the kernel at 1028MB and the ramdisk at
> 1088MB. The kernel is probably smaller than 27MB but the buffer does
> overlap the ramdisk.
>
> The solution is probably to use BOUNCE_BUFFER instead, with the EFI
> version being dropped. For now, show the address of the EFI bounce
> buffer so people have a better chance to debug any problem.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> In response to questions on how to show this problem:
>
> First, add CONFIG_EFI_LOADER_BOUNCE_BUFFER=y to
> configs/qemu_arm64_defconfig and build
>
> Then, to run:
> qemu-system-aarch64 -machine virt -nographic -cpu cortex-a57 \
>    -bios u-boot.bin
>
> U-Boot 2024.10-00809-gae29e5f76e4a-dirty (Oct 11 2024 - 11:48:46 -0600)
>
> DRAM:  128 MiB
> Core:  51 devices, 14 uclasses, devicetree: board
> Flash: 64 MiB
> Loading Environment from Flash... *** Warning - bad CRC, using default environment
>
> In:    serial,usbkbd
> Out:   serial,vidconsole
> Err:   serial,vidconsole
> No USB controllers found
> Net:   eth0: virtio-net#32
>
> starting USB...
> No USB controllers found
> Hit any key to stop autoboot:  0
> => bootefi hello
> Enabling coop memory
> No EFI system partition
> No EFI system partition
> Failed to persist EFI variables
> Missing TPMv2 device for EFI_TCG_PROTOCOL
> Missing RNG device for EFI_RNG_PROTOCOL
> Warning: EFI bounce buffer 000000004157f000-000000004557f000
> Not loaded from disk
> Booting /MemoryMapped(0x0,0x47763730,0x31b0)
> EFI: Call: efi_load_image(false, efi_root, file_path, source_buffer, source_size, &handle)
> EFI: 0 returned by efi_load_image(false, efi_root, file_path, source_buffer, source_size, &handle)
> Hello, world!
> Running on UEFI 2.10
> Firmware vendor: Das U-Boot
> Firmware revision: 20241000
> Have device tree
> Load options: <none>
> File path: <none>
> Boot device: /MemoryMapped(0x0,0x47763730,0x31b0)
> => print kernel_addr_r
> kernel_addr_r=0x40400000
> => print ramdisk_addr_r
> ramdisk_addr_r=0x44000000
> =>
>
> The EFI bounce buffer overlaps with the ramdisk.

Why can't we "allocate" sane values for the env variables in question,
similar to what is being done for the apple and qcom boards -- you can
refer to arch/arm/mach-apple/board.c:board_late_init(). We won't be
facing these issues then. Eventually, there can be a common, platform
agnostic function to initialise these values. So, just as a PoC, I
added this code to the qemu-arm.c, and no longer observe any overlaps.

diff --git a/board/emulation/qemu-arm/qemu-arm.c
b/board/emulation/qemu-arm/qemu-arm.c
index 6095cb02b23..bad787f7a65 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -109,6 +109,9 @@ int board_init(void)

 int board_late_init(void)
 {
+
+       u32 status = 0;
+
        /*
         * Make sure virtio bus is enumerated so that peripherals
         * on the virtio bus can be discovered by their drivers
@@ -119,6 +122,14 @@ int board_late_init(void)
        if (CONFIG_IS_ENABLED(USB_KEYBOARD))
                usb_init();

+       status |= env_set_hex("loadaddr", lmb_alloc(SZ_2M, SZ_2M));
+       status |= env_set_hex("fdt_addr_r", lmb_alloc(SZ_2M, SZ_2M));
+       status |= env_set_hex("kernel_addr_r", lmb_alloc(SZ_2M, SZ_2M));
+       status |= env_set_hex("ramdisk_addr_r", lmb_alloc(SZ_8M, SZ_2M));
+
+       if (status)
+               log_warning("late_init: Failed to set run time variables\n");
+
        return 0;
 }


U-Boot 2025.01-rc3-00042-gacab6e78aca7-dirty (Dec 03 2024 - 17:17:42 +0530)

DRAM:  512 MiB
EFI bounce buffer 000000005957f000-000000005d57f000
Core:  51 devices, 14 uclasses, devicetree: board
Flash: 64 MiB
Loading Environment from Flash... *** Warning - bad CRC, using default
environment

In:    serial,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
No USB controllers found
Net:   eth0: virtio-net#31

starting USB...
No USB controllers found
Hit any key to stop autoboot:  0

=> bdinfo

...

lmb_dump_all:
 memory.count = 0x1
 memory[0]    [0x40000000-0x5fffffff], 0x20000000 bytes, flags: none
 reserved.count = 0x3
 reserved[0]    [0x58600000-0x593fffff], 0xe00000 bytes, flags: none
 reserved[1]    [0x5957c000-0x5d57efff], 0x4003000 bytes, flags:
no-notify, no-overwrite
 reserved[2]    [0x5d57fde0-0x5fffffff], 0x2a80220 bytes, flags: no-overwrite

...

=> printenv kernel_addr_r
kernel_addr_r=58e00000
=> printenv ramdisk_addr_r
ramdisk_addr_r=58600000
=> printenv fdt_addr_r
fdt_addr_r=59000000
=> printenv loadaddr
loadaddr=59200000

-sughosh

>
> Changes in v5:
> - Drop the word 'warning'
>
> Changes in v4:
> - Reword the commit message since this feature is needed
>
>  lib/efi_loader/efi_bootbin.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index 7e7a6bf31aa..9a880251b47 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -208,6 +208,15 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
>                 return -1;
>         }
>
> +#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> +       /*
> +        * Add a warning about this buffer, since it may conflict with other
> +        * things
> +        */
> +       log_debug("EFI bounce buffer %p-%p\n", efi_bounce_buffer,
> +                 efi_bounce_buffer + EFI_LOADER_BOUNCE_BUFFER_SIZE);
> +#endif
> +
>         ret = efi_install_fdt(fdt);
>         if (ret != EFI_SUCCESS)
>                 return ret;
> --
> 2.43.0
>
