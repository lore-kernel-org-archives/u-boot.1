Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A63D1813A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 20:20:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5771289169;
	Mon, 14 Oct 2024 22:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m2Y65H2b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BF218916E; Mon, 14 Oct 2024 22:20:24 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7585D89166
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 22:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cbce8d830dso36765126d6.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 13:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728937221; x=1729542021; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XtNSay7FoVIf7XDp61iIUsNN3uzt8QsrUqhyAcfFR5Q=;
 b=m2Y65H2bapL+geZS7JsjL3TZZTOaAt3QFOzRwaVZSNsMBFsGHKUM7AI9FdZOIVxR9Q
 NwqMSEWdou7yOlLpvR1fetRv5Tqjf+zquLoVwXqx/5s2kxAnwAtXbsB94sHJPdLujFUC
 ZhfUji3vxx0RSQWDIwFLJkqCqjNuh6tWDjEE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728937221; x=1729542021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XtNSay7FoVIf7XDp61iIUsNN3uzt8QsrUqhyAcfFR5Q=;
 b=QBv+T4IIYpgyp1DImP/x+Sfxj0Hz2Xg3Tv6RGeiP0LNztCFPIpDjXDig6fPxqLkVDT
 1tHReVhkGQQ0XG9fnnuyUX8WuF6JNrC4TDFgvOorwE8LcncujQCaMnUsok0ktibSg2Qr
 LuMVs/H/D7ECH9EyYo61O/XOAwKkP3FQdl6hdsn2JKXkjGMoBhOYZfbsIgfCTxCNHv4L
 2CV+6+VHrppPvADqKUg4rY/5PgbM2VLVpkZotHqh6EAZJ5Tn9GI9Iul9l3edRR1a6fWf
 RQUnxjdr/OlpswTpxqw8NTzOFFE79j2cX4U0yYfjM85Mqn/0butDHqFflkL/AzpnRZdH
 0NQw==
X-Gm-Message-State: AOJu0YwtTmITmEYYZm3W0QyC316Gs3sk8Dmfz6iH1R2UsbyEyamUp6S3
 xQo0d+Q3Qec0cE0TsAiaQEm0eDUyXfoBzPN67hJpeoJHIbK5y6H137mP7z188omREYMFInCBqzZ
 bS/9w7l3OBlhAvNkfuNLAwRrcJ06wcJ0arRbK
X-Google-Smtp-Source: AGHT+IFcrdgu8iNJTSnxgJU4H1p4b/fzehwBNReAVVn+vzptzg7YY0l5Xy4k4Ja0T+hGbPoLPV5JlXslfL82DEyE2wU=
X-Received: by 2002:a05:6214:320b:b0:6cb:ec6a:7d52 with SMTP id
 6a1803df08f44-6cbf9d6121bmr129473056d6.31.1728937221277; Mon, 14 Oct 2024
 13:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20241011212126.747741-1-sjg@chromium.org>
 <20241011212126.747741-3-sjg@chromium.org>
 <A51D5AB2-A3A6-44E9-BE35-45B79081EB9E@gmx.de>
In-Reply-To: <A51D5AB2-A3A6-44E9-BE35-45B79081EB9E@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 14:20:09 -0600
Message-ID: <CAFLszTinmXQ-O5PKR2ZREeipYi4q-3fyYykBp5aMr0dAh_nV1g@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] efi: Show the location of the bounce buffer when
 debugging
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>
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

Hi Heinrich,

On Fri, 11 Oct 2024 at 16:02, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 11. Oktober 2024 23:21:23 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago. It is
> >still needed and 24 boards (lx2160ardb_tfa_stmm,
> >lx2162aqds_tfa_SECURE_BOOT and the like) use it.
> >
> >This feature uses EFI page allocation to create a 64MB buffer 'in space'
> >without any knowledge of where boards intend to load their images. This
> >may result in image corruption or other problems.
> >
> >For example, if the feature is enabled on qemu_arm64 it puts the EFI
> >bounce buffer at 1045MB, with the kernel at 1028MB and the ramdisk at
> >1088MB. The kernel is probably smaller than 27MB but the buffer does
> >overlap the ramdisk.
> >
> >The solution is probably to use BOUNCE_BUFFER instead, with the EFI
> >version being dropped. For now, show the address of the EFI bounce
> >buffer so people have a better chance to debug any problem.
> >
> >Signed-off-by: Simon Glass <sjg@chromium.org>
> >---
> >In response to questions on how to show this problem:
> >
> >First, add CONFIG_EFI_LOADER_BOUNCE_BUFFER=y to
> >configs/qemu_arm64_defconfig and build
> >
> >Then, to run:
> >qemu-system-aarch64 -machine virt -nographic -cpu cortex-a57 \
> >   -bios u-boot.bin
> >
> >U-Boot 2024.10-00809-gae29e5f76e4a-dirty (Oct 11 2024 - 11:48:46 -0600)
> >
> >DRAM:  128 MiB
> >Core:  51 devices, 14 uclasses, devicetree: board
> >Flash: 64 MiB
> >Loading Environment from Flash... *** Warning - bad CRC, using default environment
> >
> >In:    serial,usbkbd
> >Out:   serial,vidconsole
> >Err:   serial,vidconsole
> >No USB controllers found
> >Net:   eth0: virtio-net#32
> >
> >starting USB...
> >No USB controllers found
> >Hit any key to stop autoboot:  0
> >=> bootefi hello
> >Enabling coop memory
> >No EFI system partition
> >No EFI system partition
> >Failed to persist EFI variables
> >Missing TPMv2 device for EFI_TCG_PROTOCOL
> >Missing RNG device for EFI_RNG_PROTOCOL
> >Warning: EFI bounce buffer 000000004157f000-000000004557f000
> >Not loaded from disk
> >Booting /MemoryMapped(0x0,0x47763730,0x31b0)
> >EFI: Call: efi_load_image(false, efi_root, file_path, source_buffer, source_size, &handle)
> >EFI: 0 returned by efi_load_image(false, efi_root, file_path, source_buffer, source_size, &handle)
> >Hello, world!
> >Running on UEFI 2.10
> >Firmware vendor: Das U-Boot
> >Firmware revision: 20241000
> >Have device tree
> >Load options: <none>
> >File path: <none>
> >Boot device: /MemoryMapped(0x0,0x47763730,0x31b0)
> >=> print kernel_addr_r
> >kernel_addr_r=0x40400000
> >=> print ramdisk_addr_r
> >ramdisk_addr_r=0x44000000
> >=>
> >
> >The EFI bounce buffer overlaps with the ramdisk.
> >
> >Changes in v4:
> >- Reword the commit message since this feature is needed
> >
> > lib/efi_loader/efi_bootbin.c | 9 +++++++++
> > 1 file changed, 9 insertions(+)
> >
> >diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> >index a87006b3c0e..eefdd660cee 100644
> >--- a/lib/efi_loader/efi_bootbin.c
> >+++ b/lib/efi_loader/efi_bootbin.c
> >@@ -209,6 +209,15 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> >               return -1;
> >       }
> >
> >+#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> >+      /*
> >+       * Add a warning about this buffer, since it may conflict with other
> >+       * things
> >+       */
> >+      log_debug("Warning: EFI bounce buffer %p-%p\n", efi_bounce_buffer,
> >+                efi_bounce_buffer + EFI_LOADER_BOUNCE_BUFFER_SIZE);
> >+#endif
>
> Adding a debug message here is ok.
>
> But writing "warning" in a debug message which is just printing an address for a configuration selected item looks weird to me.

I added that because you said it needed to say it was a warning. I'll
remove it and try again.

Regards,
Simon
