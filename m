Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6F1D49776
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B342F896EB;
	Sun,  1 Dec 2024 16:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nmXJTX4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 858BE89729; Sun,  1 Dec 2024 16:28:38 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFF47896E2
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:28:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a790d6e782so14476955ab.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066911; x=1733671711; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LIJCXgp8Z96ZAtTXuge3Be8jxZciTsWJJ7T70uUax5E=;
 b=nmXJTX4ERiDdtRO7m/OaRADP0Xs0Hr1ZMYYquAxZGku2UBrPvN4msfmd+cujIWbvTi
 L3eMs3oSSSDHip7dIePavUa0v9CwO3OTV7JEgjnUn2dpnWSKfj6IyNRZAvdGjYeqrmVJ
 71KpY0oulXxEZn/JL8TyadkkztcRxIOk0uT1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066911; x=1733671711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LIJCXgp8Z96ZAtTXuge3Be8jxZciTsWJJ7T70uUax5E=;
 b=DaVhUvRxTUq3i5xpj8MimEJpg81UO783/ts1Bwc29Tfbby0VqIudpZvAXNR49M24Gw
 r4Xy1pqOg/a+Pkj2w7dbPTEljEyDFC/qq91plnKlMh1z1hhBgXaYfXBllDlyz+o/a5Tz
 5moT/K/IAaeRMTp/7dkkSnDpMghfNRLaMBu47JehTHWP3yjEECRsb7fCthKzCcsIjtzB
 5lk0/XVgH1lP7R/wEec8IvbZiE5ktsaqDJRxeqf9YvtCRlAqFtkqx4K+D/Ruz0A2kdoZ
 ++l/GcV9+C4KrzYGOrB5Dm1LFcMqcRI5Jg6yZ3UD/8mJZsv89UWLkmaBpBek8Oxy6ZbT
 smJA==
X-Gm-Message-State: AOJu0Yz4vduI4xy72/j4JzK1Eu6JeiTHviCTH4R99IlhgupBbvWF/kJY
 tOre4oK60t/SbA8IJA93fzn3aUSexe2SNaDXVZWeohb6gPN+dD7J91p6sssXyWPhOkM1JfW6LeE
 =
X-Gm-Gg: ASbGnctbx1mhEd4YENSwLIIuGzbBrF3WXgCbEQYM7z0AFVcMywiBgQ9ravvUhf6JISq
 olDBweRLcDwRGH5mTNLJg/nFXszMUR3L35aKcUTB9XJGIIGDhe+8JqJvekYfU8MQzcx9EQs72hj
 ttEOlXGe3Jk+tZZPH56MPgKatXXpJPM3mKldAbL+CjM9rBGhFkhdbbywe2chybYrinGemRL8siV
 3Vx9tJIkL+YL2Cfdn6YKp/OLtNPlMK/muHjgGq9UPuq
X-Google-Smtp-Source: AGHT+IH2kA9LUNPNOZBJUEQHWDDSKPoIppRExQAQexJcew/J+/QfkTc+msReWmprNwGkUMbdESq4zg==
X-Received: by 2002:a05:6e02:1c2c:b0:3a7:1c51:f83d with SMTP id
 e9e14a558f8ab-3a7c55d6900mr186977815ab.18.1733066911102; 
 Sun, 01 Dec 2024 07:28:31 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e230dcb33esm1690307173.57.2024.12.01.07.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:28:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Moritz Fischer <moritzf@google.com>
Subject: [PATCH v5 6/9] efi: Show the location of the bounce buffer when
 debugging
Date: Sun,  1 Dec 2024 08:28:08 -0700
Message-ID: <20241201152815.1668093-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152815.1668093-1-sjg@chromium.org>
References: <20241201152815.1668093-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago. It is
still needed and 24 boards (lx2160ardb_tfa_stmm,
lx2162aqds_tfa_SECURE_BOOT and the like) use it.

This feature uses EFI page allocation to create a 64MB buffer 'in space'
without any knowledge of where boards intend to load their images. This
may result in image corruption or other problems.

For example, if the feature is enabled on qemu_arm64 it puts the EFI
bounce buffer at 1045MB, with the kernel at 1028MB and the ramdisk at
1088MB. The kernel is probably smaller than 27MB but the buffer does
overlap the ramdisk.

The solution is probably to use BOUNCE_BUFFER instead, with the EFI
version being dropped. For now, show the address of the EFI bounce
buffer so people have a better chance to debug any problem.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
In response to questions on how to show this problem:

First, add CONFIG_EFI_LOADER_BOUNCE_BUFFER=y to
configs/qemu_arm64_defconfig and build

Then, to run:
qemu-system-aarch64 -machine virt -nographic -cpu cortex-a57 \
   -bios u-boot.bin

U-Boot 2024.10-00809-gae29e5f76e4a-dirty (Oct 11 2024 - 11:48:46 -0600)

DRAM:  128 MiB
Core:  51 devices, 14 uclasses, devicetree: board
Flash: 64 MiB
Loading Environment from Flash... *** Warning - bad CRC, using default environment

In:    serial,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
No USB controllers found
Net:   eth0: virtio-net#32

starting USB...
No USB controllers found
Hit any key to stop autoboot:  0
=> bootefi hello
Enabling coop memory
No EFI system partition
No EFI system partition
Failed to persist EFI variables
Missing TPMv2 device for EFI_TCG_PROTOCOL
Missing RNG device for EFI_RNG_PROTOCOL
Warning: EFI bounce buffer 000000004157f000-000000004557f000
Not loaded from disk
Booting /MemoryMapped(0x0,0x47763730,0x31b0)
EFI: Call: efi_load_image(false, efi_root, file_path, source_buffer, source_size, &handle)
EFI: 0 returned by efi_load_image(false, efi_root, file_path, source_buffer, source_size, &handle)
Hello, world!
Running on UEFI 2.10
Firmware vendor: Das U-Boot
Firmware revision: 20241000
Have device tree
Load options: <none>
File path: <none>
Boot device: /MemoryMapped(0x0,0x47763730,0x31b0)
=> print kernel_addr_r
kernel_addr_r=0x40400000
=> print ramdisk_addr_r
ramdisk_addr_r=0x44000000
=>

The EFI bounce buffer overlaps with the ramdisk.

Changes in v5:
- Drop the word 'warning'

Changes in v4:
- Reword the commit message since this feature is needed

 lib/efi_loader/efi_bootbin.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 7e7a6bf31aa..9a880251b47 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -208,6 +208,15 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
 		return -1;
 	}
 
+#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
+	/*
+	 * Add a warning about this buffer, since it may conflict with other
+	 * things
+	 */
+	log_debug("EFI bounce buffer %p-%p\n", efi_bounce_buffer,
+		  efi_bounce_buffer + EFI_LOADER_BOUNCE_BUFFER_SIZE);
+#endif
+
 	ret = efi_install_fdt(fdt);
 	if (ret != EFI_SUCCESS)
 		return ret;
-- 
2.43.0

