Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D00D0EE3F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 21:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 202FA893ED;
	Fri, 11 Oct 2024 23:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f78X76Se";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E287D893EC; Fri, 11 Oct 2024 23:23:42 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F6F2893D2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 23:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a3a380fd55so9836225ab.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 14:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728681819; x=1729286619; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZndlKzjJc+3aRON+b/2qIzxfWSCekcEfs8HgQhxfnvM=;
 b=f78X76Se/fS7HJs1ULnmUmTVOMcrRQ407Yy6xyOXzilANbHw0hXpVoguCRJI/1VMGA
 2fgN9O9d7WR5iQwsBSSClGf4jms9uo721KvjkjtZsT5fWYwkCrQ3WJuqdvS6M4Nnllvo
 AioKbPB7tKmSpzbTNXOaYONdBVi5lqYBPWZDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728681819; x=1729286619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZndlKzjJc+3aRON+b/2qIzxfWSCekcEfs8HgQhxfnvM=;
 b=ZF6sXebqdKXqLAapFqjyF0nH41Oy3C8mlJYJ4kVE42UTelTAgKgaAMOEN2Bz/gwDxv
 MTE6lDW7/OgAwfegUBWb8DUPZGXrfL8hmPs6H1mV32ap+C9y9pii87LJhQQL8Ua//uE3
 iNL6XCDRCr4rhylvtFWWYys/Sdzyz+MMMOPSoXTo9G7iDFD9AkhYuNRn9QABD+Sa/xQl
 gVGkoSRPNxOem25BPdkOK/l2xG7JEG/jlRU+a7wOe34J1ghzG5+yhW9JNSgYpXagJo95
 odUcFi/gWo4TLlX8sw6Oll5VifMMgqPmAwREf4u3//Lj244XNak2324Ntibz6/Z+lDfr
 Yq8A==
X-Gm-Message-State: AOJu0Yw7Ug0vEKJqATIWrQ6tbTj9jC4lMBycG04ABC//4LhXklx45+84
 rluDzXZI4lynCfDJkJO/HE/F9rfOac0qPWff5WAeuMIE2oeb5Cpby3jZJx/iu4DL2AdvUC8/vhd
 21g==
X-Google-Smtp-Source: AGHT+IFuHfNs5C6cET8mWGgTmHZUzAQgRr0ET+V33U+tUHNo3YHRI8r5tfpVSf+uc3SNy6QcBXkRXQ==
X-Received: by 2002:a05:6e02:1a8e:b0:3a3:6045:f8bb with SMTP id
 e9e14a558f8ab-3a3bcdc0421mr5506975ab.10.1728681818984; 
 Fri, 11 Oct 2024 14:23:38 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbad9b13e5sm784789173.1.2024.10.11.14.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 14:23:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>
Subject: [PATCH v4 2/5] efi: Show the location of the bounce buffer when
 debugging
Date: Fri, 11 Oct 2024 15:21:23 -0600
Message-Id: <20241011212126.747741-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011212126.747741-1-sjg@chromium.org>
References: <20241011212126.747741-1-sjg@chromium.org>
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

Changes in v4:
- Reword the commit message since this feature is needed

 lib/efi_loader/efi_bootbin.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index a87006b3c0e..eefdd660cee 100644
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
+	log_debug("Warning: EFI bounce buffer %p-%p\n", efi_bounce_buffer,
+		  efi_bounce_buffer + EFI_LOADER_BOUNCE_BUFFER_SIZE);
+#endif
+
 	ret = efi_install_fdt(fdt);
 	if (ret != EFI_SUCCESS)
 		return ret;
-- 
2.34.1

