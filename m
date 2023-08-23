Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7787C3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 21:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1CEF864EF;
	Wed, 23 Aug 2023 23:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fy2ajGwC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04894864E5; Wed, 23 Aug 2023 23:11:13 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA19A864CB
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 23:11:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-34cb5c41777so9619345ab.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692825069; x=1693429869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hCXQVO3QCA/YEmNUqKMavVK91V12ZU3pLHQG2HWc3+k=;
 b=fy2ajGwClKw/ypoLrVUd3DXX+2hpq8+NYhtaMe5fNs2xUNwkXlgdVbsYThd1ZXjgkQ
 Hosxgj5JtM6E/3TG/V17jq0mrb3OI8PnTsDqVQ82pcvcvxrYR0O9WS00hXGFqaW3y9aY
 WkHxRIGoH5Jcp5FayIEyVu6Y+BfikwyU8r96A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692825069; x=1693429869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hCXQVO3QCA/YEmNUqKMavVK91V12ZU3pLHQG2HWc3+k=;
 b=OZF86qtCyf4dq/HvIvezh0Rif+QXqVFYO8SaLuUxSCS3223YEeB8WsrhS9cOAPZTtm
 nNG5koilJ64LXGRoDfy7qW67YIxj9p9gBxlApkk3F40QsVY33N0V4LGPx6RiWwIsFm03
 7dCOhzVpUCw7w66ZZIJST5M8e1T318oyVcuEhuq9pNJ8t1SdODqUkzZ1L0pbM8F8upmr
 PmyOiBmk6sbKYJEG1OwMv8b5EdBXs5mdi7bblXqWqh70kvq4ETkLM2qEYz6WLs24eoYr
 BoZG/trk9lhMZkuiOzYqCmV+ry/IZckFGj7XNk73Ckeqy0tVnmHzzgf2TOZvrm3C4Kxs
 08SA==
X-Gm-Message-State: AOJu0YxsSQC8cWtFhOc7+u4ZSyG/H2xVPgDL8HhuUSIUfx6QgK7oRxN5
 yw+i6YY63enJX4kKt2qT2mBDWITang2RhAmNvYY=
X-Google-Smtp-Source: AGHT+IHplUC2f1PlsRks2JTHsH0JC6mOP2FBbtiYENU/uZfOL0f/P6CzoENqsmSGYNTc7nkv0ym4AQ==
X-Received: by 2002:a05:6e02:1a0c:b0:34c:bc10:2573 with SMTP id
 s12-20020a056e021a0c00b0034cbc102573mr4214237ild.3.1692825069412; 
 Wed, 23 Aug 2023 14:11:09 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a02c9cf000000b0041627abe120sm3921075jap.160.2023.08.23.14.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 14:11:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 02/20] x86: coreboot: Enable standard boot
Date: Wed, 23 Aug 2023 15:10:19 -0600
Message-ID: <20230823211059.1235147-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823211059.1235147-1-sjg@chromium.org>
References: <20230823211059.1235147-1-sjg@chromium.org>
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
index a456547a25d..5623197f6be 100644
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
index aedad4c93c3..311ca6672cb 100644
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
index be5b0de5495..88437c27740 100644
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

