Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611F9C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:30:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD72C839F3;
	Wed, 28 May 2025 10:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XdKXoGzd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1200783966; Wed, 28 May 2025 10:26:50 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25D8F83A1C
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-86cdb330b48so142478139f.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420802; x=1749025602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c6g/Yn7pXjN5nDbjWAg290Y3bL13aOpFZF/lmG0U1Mc=;
 b=XdKXoGzdDvgLK1V609lcVsBZQEi/dmhkSbG68Tcm+J9WuXlnd/DCcmHDotP7EE1YE8
 R/fDFPN92ncZVETTk5s4yLMZAiYjhqQ5vEZu0Ssotvfh4WoodXwmmEMub3J0lA3b3M4z
 ekZiNR/XiNnd5sYxbdLhSPPgZZgcjS63Y1JGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420802; x=1749025602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c6g/Yn7pXjN5nDbjWAg290Y3bL13aOpFZF/lmG0U1Mc=;
 b=oyXQDpPdBoet32JNJvuxg2+oQb94fIRliaiSz++Suxuwl/9hQ+6VzupBOBqjU/qnws
 FdatiLRvO1qKruN9bw4wil9DBgQISr23cDWXeCV31KqmVct4jc+MxkseFfl5vmy9otRj
 Qug/84OW/CBDi111ySm2lTSdWrKhhrRccwb2VGrdUT3MPi4Q/wg61gl2COuNn/7M6d9r
 iDCZDvFZDU08D3Bxb7bBwAtbTK2ab68evsaNKd+jTwYBq5S8YOgqnxFuwlTby+HqxeST
 iNW/ZXWZIiIm6MFDT8HD3QIR29WCsFhI+qGVxa84IQaJvZc6y2pNzI0chZ7TERx9lEva
 TlcQ==
X-Gm-Message-State: AOJu0YyxvVNDcvO9t98pcAYglv9AOwt0f6sIZzOrbU2D8rpsg1SIUjM1
 Z21iujdF8JEzM96p8nFZNjxuEDm97f6A+aW4LZ7judQ5MbZjY0R8FQ03VBxHgI59IJX7WMwoH5I
 2u5VwNkqD
X-Gm-Gg: ASbGnctuDX4ylfwPVCx0eWYp9ZfmFp/G9fRy509E34YuIo9/ktBBqeYDxfEL3LEpOlH
 ZWFXUuf98XWxjKINfdwiLU8fgjB2m4XQMWbQc7M4GmsFV70OLY2/NnDk3xXdwP4Qzsduo66PVfX
 G+jpsknTCNotItOoEjhIVd6dWhnKUqjqL4RQONLiVqPqv28yNnaxRssgeCRXspGB/xroTEpaESo
 iYJEHve/xU1IZOmNTkXlsN2r1b/9nNJIANIpYkxkG4ilKY1XMBUuJ34+TVpRukpqS9/ZbKwQf9j
 ljFwiaunm3Vmm66lL9d0F5+2F5N/NJ+j9K4CI4x/5kPoIwD1Ff4IRgxQHxelWrclPCKI/HTaYL8
 3DvK23998XC2n
X-Google-Smtp-Source: AGHT+IHw4YAli+WD2AbfOK6IBDhyvSqHKEbXTn3KOOeg15dCU/6cq5E94ApkEiULz/+gXjvAh9xOcw==
X-Received: by 2002:a05:6e02:8a:b0:3dc:8058:8e9d with SMTP id
 e9e14a558f8ab-3dd8b070d57mr11728425ab.20.1748420802337; 
 Wed, 28 May 2025 01:26:42 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:26:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 26/27] x86: efi: Enable bootstd
Date: Wed, 28 May 2025 02:24:52 -0600
Message-ID: <20250528082520.152391-27-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
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

Use bootstd for booting. Add the -p option since we may wish to boot
from an extlinux file even if a EFI partition is present.

Disable the bootz command since this is not applicable for x86 and
causes bootstd to attempt it anyway.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/efi-x86_app32_defconfig | 15 ++-------------
 configs/efi-x86_app64_defconfig | 14 ++------------
 2 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/configs/efi-x86_app32_defconfig b/configs/efi-x86_app32_defconfig
index 2a7d6c9916e..2848dac905b 100644
--- a/configs/efi-x86_app32_defconfig
+++ b/configs/efi-x86_app32_defconfig
@@ -10,28 +10,17 @@ CONFIG_DEBUG_UART=y
 CONFIG_TARGET_EFI_X86_APP32=y
 CONFIG_EFI_CLIENT=y
 CONFIG_FIT=y
-# CONFIG_BOOTSTD is not set
+CONFIG_BOOTSTD_FULL=y
 CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
+CONFIG_BOOTCOMMAND="bootflow scan -lbp"
 CONFIG_SYS_PBSIZE=532
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_HUSH_PARSER=y
-CONFIG_CMD_BOOTZ=y
-CONFIG_CMD_PART=y
-# CONFIG_CMD_SCSI is not set
 CONFIG_CMD_TIME=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
-CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
index e822dd24f00..f0dac46a552 100644
--- a/configs/efi-x86_app64_defconfig
+++ b/configs/efi-x86_app64_defconfig
@@ -12,28 +12,18 @@ CONFIG_TARGET_EFI_X86_APP64=y
 CONFIG_EFI_CLIENT=y
 CONFIG_EFI_APP_64BIT=y
 CONFIG_FIT=y
-# CONFIG_BOOTSTD is not set
+CONFIG_BOOTSTD_FULL=y
 CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
+CONFIG_BOOTCOMMAND="bootflow scan -lbp"
 CONFIG_SYS_PBSIZE=532
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
-CONFIG_HUSH_PARSER=y
-CONFIG_CMD_BOOTZ=y
-CONFIG_CMD_PART=y
 CONFIG_CMD_TIME=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
-CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
-- 
2.43.0

