Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98416C678DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 00:28:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1176686BFF;
	Fri, 18 Aug 2023 02:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JcwOpJT/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9055286C1C; Fri, 18 Aug 2023 02:27:25 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D04CF86BFE
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-34bae9d9d54so1484145ab.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692318441; x=1692923241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=04glEvEMhfQpJXc1RxFdj110T/t0K2+5Yf+3jdeqzlo=;
 b=JcwOpJT/3b9hsj/bzG55T0bg61G9to8Rfh7hC62A6WOm95t7G+laHDB11mqSem39fb
 PzHkMItDIkCwfzK0JigdsfoadRH2nz9UJ44CeF6v83PeC7dExUpk4l8uoX1ImFeCBmAJ
 yCc/Obvig9147YdWAmSGH4Qj44glkjHppSOM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692318441; x=1692923241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=04glEvEMhfQpJXc1RxFdj110T/t0K2+5Yf+3jdeqzlo=;
 b=C+pSQh+W4GpCr4MOSKnHMzYie2wUErpHZFFjnHkAkOaNHVUvDGYJ3s5dpSlp2fUlJ5
 3ulsPPqLuDIxJH8lMweHr8prSbxKtm+cDoXFt79nn3MDUGRmTDc0I6SMXMszUBCGpU4C
 W+cV4VqJ+g+GnEKtrPLHjKajNP6RAraJqXgrRg5fqPKGUOhoZepIKYVt1oUceDXSIXRM
 M2K4kpwJ59e5KaV+bjagKnozf7ODQL9L3PaqdtWG2FgMSdE/fkygkFhOdOKKC+lOGB7S
 KyScRFbup0CNTXLenMKb5+Wly78loL48xPZEKgN0TgAEXhs1+0rc88EaPCktP/S6qqMB
 HMuw==
X-Gm-Message-State: AOJu0YzJJHeO6anx1SdwAtBt//AFp83Rz0V2OAe+STLTGIa+Z9/SuU9b
 q9mGwmsfpDB09Jm+HjnpJbeW3ziKwZJZc9xwhuA=
X-Google-Smtp-Source: AGHT+IG3O0QcECIKpzkUC36fRz+oi8ZPMt1yuhQ2WfpDWsb44zj6UlwpmraEiUXptZ3laNb4QvetgA==
X-Received: by 2002:a05:6e02:1be8:b0:349:77e2:1414 with SMTP id
 y8-20020a056e021be800b0034977e21414mr1546045ilv.32.1692318441324; 
 Thu, 17 Aug 2023 17:27:21 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a056e02054e00b0034bad471d1fsm190376ils.3.2023.08.17.17.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 17:27:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Coreboot ML <coreboot@coreboot.org>
Subject: [PATCH v2 09/20] x86: coreboot: Align options between coreboot and
 coreboot64
Date: Thu, 17 Aug 2023 18:26:48 -0600
Message-ID: <20230818002706.853550-10-sjg@chromium.org>
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

These two builds are similar but have some different options for not good
reason. Line them up to be as similar as possible.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Update the malloc size too

 configs/coreboot64_defconfig | 7 +++++++
 configs/coreboot_defconfig   | 9 ---------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 29b68d6929c7..2263554a47ce 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -1,5 +1,6 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0x1120000
+CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="coreboot"
@@ -18,6 +19,9 @@ CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
+CONFIG_LOG=y
+CONFIG_LOGF_LINE=y
+CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_LAST_STAGE_INIT=y
 CONFIG_SPL_NO_BSS_LIMIT=y
@@ -51,10 +55,13 @@ CONFIG_SYS_ATA_ALT_OFFSET=0
 CONFIG_ATAPI=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
+CONFIG_NVME_PCI=y
 # CONFIG_PCI_PNP is not set
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_SPL_ACPI=y
+CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
+CONFIG_SMBIOS_PARSER=y
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index 2961908f29cd..790b84a87bc7 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -25,23 +25,14 @@ CONFIG_LAST_STAGE_INIT=y
 CONFIG_PCI_INIT_R=y
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
-CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
-- 
2.42.0.rc1.204.g551eb34607-goog

