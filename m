Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE10E67819
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D6948909F;
	Sun,  3 Nov 2024 01:30:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kcBveYWa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B03F58909F; Sun,  3 Nov 2024 01:30:30 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72732890F8
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:30:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20ca388d242so30702575ad.2
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730593826; x=1731198626; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z59fI9DStIyk4F7P0GDUNvKidgkEYmGg7mnFh/NVDJY=;
 b=kcBveYWaWTpmClhpUW02xIYQ0kDunpokTO+tLuS2AdBelC89/+UZe4V+ZrIvbe0KK1
 NBjn8KdHfHBrdN8TNHh2Ev789Lk4FmU0O3O9iEoGxy4/QWKb9SBPqEh+W+LW4oV/EghH
 Cu4vOjipGtEHzbNTfHEtk88irJHWc776yIrK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730593826; x=1731198626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z59fI9DStIyk4F7P0GDUNvKidgkEYmGg7mnFh/NVDJY=;
 b=QHq+1lQn16bMvMi+TPn5sNr4vJ1mdeHEUZ3PL7NAGY4/hpT0h3fe6r4sd7+/bIg/Lf
 720pwpHrhkqEMy5GhLV5yh29hataugas2HAQCo6AfoQpoJnqsFPLsi2chGze4sjMcNsG
 9urs/euwxNHJH82w2L+FDgYAP6ZoewfUyWCqXOKQAnCNEywza3GW4pASeb/GstJfw4t5
 8TtUegA0Tg2JUvSk2/QUCvY3TWJM5sp6CfFOh1cJ5eR561kmC2Or716dtTo6J/grXpRX
 0oYcsYy23vYvkbShSnOc6RAX6EEOTWxG51XcRjtc7QDOjSgFtg66lhv5/vs25vRM24Ce
 F84Q==
X-Gm-Message-State: AOJu0Yxopbn1OtynsPW+QqJQ/bplsLFZE0bqmspyoE/iA+NjyzQOfI42
 +3KTPaeD26Mfdju615DDfTz5yfSNO4PFxwdlrrwchoHWW8D4DGMoUYrQE6Xl8AdxYbX1hKjE5PB
 8cg==
X-Google-Smtp-Source: AGHT+IEAxiTQTJO9mTQQ7pntO+E3jEASvsDzNMalGptJwX/cn5tgBRKGiaVZNu3BHm2ubvLq5H2d6g==
X-Received: by 2002:a17:902:e884:b0:20b:3f70:2e05 with SMTP id
 d9443c01a7336-2111afd6c99mr116596585ad.41.1730593826348; 
 Sat, 02 Nov 2024 17:30:26 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211056edc65sm39133335ad.10.2024.11.02.17.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:30:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>
Subject: [PATCH v4 5/9] efi: Show the location of the bounce buffer when
 debugging
Date: Sat,  2 Nov 2024 18:28:22 -0600
Message-ID: <20241103002828.624931-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241103002828.624931-1-sjg@chromium.org>
References: <20241103002828.624931-1-sjg@chromium.org>
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
index a87006b3c0e..6f02c5ed5dd 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -209,6 +209,15 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
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

