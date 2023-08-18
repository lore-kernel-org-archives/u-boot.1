Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC29AC678DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 00:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DD3386C09;
	Fri, 18 Aug 2023 02:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cEQf1MMp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A935686B7E; Fri, 18 Aug 2023 02:27:19 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D606586C06
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-34ac2e3064cso1353035ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692318435; x=1692923235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gn0rzQjV3ooaUKS2tiDI/lnvil2w7qFv9/n1bJkA7Ec=;
 b=cEQf1MMpRTcGbICY6+/DKqn0Q+E0aN9HxSbcHXXNAAk7T6fvRLsCERtcAE/ZftamTJ
 rPXaAE30M9ic7/NBaB1Edt16Q2kprGWOPcxoUJXDtS81BOUxhODddRrnfb+pI1AvNQfp
 rlpte8bpGjJJZwle44g3RUleDVGNChH9g5ToQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692318435; x=1692923235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gn0rzQjV3ooaUKS2tiDI/lnvil2w7qFv9/n1bJkA7Ec=;
 b=hdIrLfXtx0DA/or4PWYS1Vq+5ibUuFt5KkXZ23aKjzLaZlA8KnvwQVv1BQy5kuUZBa
 hawem9w8VRnWf6TRqmmDz+tpPoN3LTSEolf1/HTZXhbTBSuQ26Fmx5xEcFMFuvTqf9Qc
 ETJrWhmk1K5HHPOCNGzOP7pIKkopSs2O2eARcK44tfS+S151eg6Eu8EZAfWnaDxXIM3t
 Yfqyil4Gkhp43qx3QYtizxiqJRpEGvusWoP9D2EIGGtFJ3Bf0aSUFHUPC6rb7w8+9nXo
 OdsLUXm7DiZ/QpajIalrjKe9mCtt8pwwv//2HQHvQIcTl9M8Oarozd3gbhP+jzoiJNwV
 RQZw==
X-Gm-Message-State: AOJu0YyLAzYj/gAKWpowIBryacJUPBFMG5RirubwqrZ19wfw03kihsUp
 9lhFQ5WTQJwbq4Trh1GBDW85Dkzpd4iLwwm3qBo=
X-Google-Smtp-Source: AGHT+IGyCr1eEYpDv6xvf1AcZEqyG00kSfuLmlpsJXRU4rW8S3WkICfBPQxzR+T9g9hS/aAYUNVQ+g==
X-Received: by 2002:a05:6e02:931:b0:34b:f3b:77b5 with SMTP id
 o17-20020a056e02093100b0034b0f3b77b5mr946927ilt.30.1692318435521; 
 Thu, 17 Aug 2023 17:27:15 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a056e02054e00b0034bad471d1fsm190376ils.3.2023.08.17.17.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 17:27:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Coreboot ML <coreboot@coreboot.org>
Subject: [PATCH v2 02/20] x86: coreboot: Enable standard boot
Date: Thu, 17 Aug 2023 18:26:41 -0600
Message-ID: <20230818002706.853550-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230818002706.853550-1-sjg@chromium.org>
References: <20230818002706.853550-1-sjg@chromium.org>
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
---

(no changes since v1)

 configs/coreboot64_defconfig    | 14 ++------------
 configs/coreboot_defconfig      |  1 +
 doc/board/coreboot/coreboot.rst | 16 ++++++++++++++--
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index ded0e6f2422d..602465175d20 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -10,40 +10,30 @@ CONFIG_VENDOR_COREBOOT=y
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
 CONFIG_LAST_STAGE_INIT=y
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
index 56cc542df6c6..735cd6eb4c22 100644
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
index be5b0de5495e..88437c27740e 100644
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
+      -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000
+
+   qemu-system-x86_64 -m 2G -smp 4 -bios coreboot.rom \
+      -drive id=disk,file=$DISK,if=none \
+      -device ahci,id=ahci \
+      -device ide-hd,drive=disk,bus=ahci.0 \
 
-This has only been lightly tested.
 
 CBFS access
 -----------
-- 
2.42.0.rc1.204.g551eb34607-goog

