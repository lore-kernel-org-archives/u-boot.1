Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DD9CE79AC
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E16E186C22;
	Wed, 20 Sep 2023 05:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N9h1REFZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78AF186BFB; Wed, 20 Sep 2023 05:00:37 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 295AE86BFC
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34fd889f69aso11932795ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178834; x=1695783634; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHup9jP3tu+shoDLQ/PUFF8kx4ovElDQdbAnWR55bVU=;
 b=N9h1REFZLq7SBMuFhdIGk6ul362WryNSF/w561qxQ/lZ389mT4hjKIKcYkKh4terz2
 CGrx8Hhh+JeEyr00YoVvIWIVj/GWtB7f4r0106eMZ1tKTLw43HV0cSo/FhkUGFbwxJI7
 vUZJXZi8XR14hNWPsLl6UQEd/dkQd770LCdcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178834; x=1695783634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XHup9jP3tu+shoDLQ/PUFF8kx4ovElDQdbAnWR55bVU=;
 b=PxmfQDkyZi/QxL3aMIrbsoWAX9ojm47lNZEtoSvrtj3L1+6cNYG5C5BOMOu7cNjrYj
 9qYVqvuvJInhsOyhggfIfEVbdXdP1Em6CWBiSIdjUohfpH9ih6DGyOnAtMCLr/zekkHy
 V3/IVoxvr7vHFhAf45/9HbTP4YHYw5I3rgbsUOQTCYjviSFzmZxHv9MlVWRS0oGUDk0t
 2h/N0EggrRXq4o46NA9RzBJ0rUUHu9VK0eY2KCVY/W13ziL17FhRJbnZLAYNVQLEMc7L
 OKjBNwa/bUd6y7EANMnlRK/hyp+8RNi5HzEB5qz/y/HihiekEL41m7HvsHIBxUemBcp2
 e9rQ==
X-Gm-Message-State: AOJu0YzyBOCaaLKwC6CwswCc4A434EJrZWIisRvNbGqxbblGpzrN2cPR
 myJtbsSfqif0NP6rqK7159Z31b4XDAFauZSyAiI=
X-Google-Smtp-Source: AGHT+IGVh/SMCeK2j7C+b0FrSEB2HDfZ7/t/MoAYEXkGJ5jvIOZl+4JQwSBGa9QVwwPhNt5gF+6o1Q==
X-Received: by 2002:a05:6e02:1d0f:b0:345:d58d:9ae5 with SMTP id
 i15-20020a056e021d0f00b00345d58d9ae5mr2156927ila.7.1695178833803; 
 Tue, 19 Sep 2023 20:00:33 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s5-20020a92d905000000b0034feb68437fsm1835423iln.24.2023.09.19.20.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 20:00:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 02/20] x86: coreboot: Enable standard boot
Date: Tue, 19 Sep 2023 21:00:03 -0600
Message-ID: <20230920030027.1385833-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920030027.1385833-1-sjg@chromium.org>
References: <20230920030027.1385833-1-sjg@chromium.org>
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

Enable bootstd options and provide instructions on how to boot a linux
distro using coreboot.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

Changes in v5:
- Use 'lzma' instead of 'LZMA'

 configs/coreboot64_defconfig    | 14 ++------------
 configs/coreboot_defconfig      |  1 +
 doc/board/coreboot/coreboot.rst | 16 ++++++++++++++--
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index a456547a25d4..5623197f6be2 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -10,39 +10,29 @@ CONFIG_VENDOR_COREBOOT=y
 CONFIG_TARGET_COREBOOT=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_SYS_MONITOR_BASE=0x01120000
 CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_NO_BSS_LIMIT=y
-CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_IDE=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_PART=y
 CONFIG_CMD_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_DHCP=y
 CONFIG_BOOTP_BOOTFILESIZE=y
-CONFIG_CMD_PING=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_SOUND=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 # CONFIG_SPL_MAC_PARTITION is not set
 # CONFIG_SPL_DOS_PARTITION is not set
-CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index aedad4c93c30..311ca6672cbd 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -10,6 +10,7 @@ CONFIG_TARGET_COREBOOT=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_SYS_MONITOR_BASE=0x01110000
 CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
diff --git a/doc/board/coreboot/coreboot.rst b/doc/board/coreboot/coreboot.rst
index be5b0de5495e..3ef563b71dc9 100644
--- a/doc/board/coreboot/coreboot.rst
+++ b/doc/board/coreboot/coreboot.rst
@@ -67,9 +67,21 @@ To use 4GB of memory, typically necessary for booting Linux distros, add
 In addition to the 32-bit 'coreboot' build there is a 'coreboot64' build. This
 produces an image which can be booted from coreboot (32-bit). Internally it
 works by using a 32-bit SPL binary to switch to 64-bit for running U-Boot. It
-can be useful for running UEFI applications, for example.
+can be useful for running UEFI applications, for example with the coreboot
+build in `$CBDIR`::
+
+   DISK=ubuntu-23.04-desktop-amd64.iso
+   CBDIR=~/coreboot/build
+
+   cp $CBDIR/coreboot.rom.in coreboot.rom
+   cbfstool coreboot.rom add-flat-binary -f u-boot-x86-with-spl.bin \
+      -n fallback/payload -c lzma -l 0x1110000 -e 0x1110000
+
+   qemu-system-x86_64 -m 2G -smp 4 -bios coreboot.rom \
+      -drive id=disk,file=$DISK,if=none \
+      -device ahci,id=ahci \
+      -device ide-hd,drive=disk,bus=ahci.0 \
 
-This has only been lightly tested.
 
 CBFS access
 -----------
-- 
2.42.0.459.ge4e396fd5e-goog

