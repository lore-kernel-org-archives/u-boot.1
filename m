Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FA8EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 12:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4E8E864BC;
	Tue, 22 Aug 2023 14:10:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nn1q5T+Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 855D9864FE; Tue, 22 Aug 2023 14:10:57 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D75A864D9
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 14:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31aec0a1a8bso1863462f8f.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692706254; x=1693311054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9Fve/QyA1+TAbnzF6MV6r20Gp6S4M4kis/TvEXMctM=;
 b=Nn1q5T+QXU0Z7Ur3VPWUIywLHQpNNxNi1/WTka6kxpaSVbs+druyHYivvVPzit78xi
 A42bQLQ746+NmXxpDf8z4spXo6dTfwvAdMtIsybfugxcin7EBgN9Upu4i6kKTld69hgz
 1JGCovIB2BuHFF10Trbiee7QNDrRvJ17APhr+84/Nn65W53fo8SfY3Tr9whc4rIySymP
 rpfcZsl4RgdXuW6ECb7DndhL0jbBWeqUEQeeEMIYB20Fe73/toXiCGb8UCmb2baOQNwI
 wSXMH+qjVERt6TDxNWl879Pqe8pLyDJjdkKm1zwtY24tHZvILM6I99Y1oGIHV1iXSDdx
 yTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692706254; x=1693311054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O9Fve/QyA1+TAbnzF6MV6r20Gp6S4M4kis/TvEXMctM=;
 b=HbrPa6cY52t7c7dTpnsNFeVSdZ6dcMWbXU7EJETn3/Vwz1mBrQvKqO851gzXzbht+H
 hPcrgOCrjiJadY616ZXWUYclRILjl0dIcyjW8LcdzWXDoR2a+HYDsLKiMO0Dq/fH2Rob
 uGvku4HoxR/ldP+3Kg7UayCwicCmw3mgrP4bbuOBzYtogxnOofeE9AS1deYYvt3sQZsN
 WLJqtFzNSQVNgZGD0kiZ8p0rpU5gMDRiuC08GNpf2ZOwUMmACcvNYyFUk51HyAaCkIjz
 qAvft2Ejb90LpweBOBBQYOD8FLnGAbIg4jnSAFVUxycQzdCqst871TYi15xiM9dVRCIC
 glEg==
X-Gm-Message-State: AOJu0YwZZX3Wcf3vJFjAK6t797IzpUKGMilUXXGE/vwx0R/h0xJi+4n9
 Nr+CR9hlQGrPgRIUWQVJy6Oy9DHeVTI=
X-Google-Smtp-Source: AGHT+IGR57lRHs3/nz4nZ0RSKvYU3I6C2y7dZnTygFM+9SQ+m5wQPB64qHxA7XYXRmPpYfuBK92PUw==
X-Received: by 2002:adf:e645:0:b0:316:f9f1:bb0f with SMTP id
 b5-20020adfe645000000b00316f9f1bb0fmr9231151wrn.34.1692706253939; 
 Tue, 22 Aug 2023 05:10:53 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 a2-20020adffac2000000b0031753073abcsm15704611wrs.36.2023.08.22.05.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 05:10:53 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.denx.de
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH v2 7/7] x86: qemu: Enable ramfb by default
Date: Tue, 22 Aug 2023 15:10:25 +0300
Message-Id: <20230822121026.1007105-8-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
References: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
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

Now that we have everything in place to support ramfb, let's wire it up
by default in the x86 QEMU targets. That way, we can use ramfb graphical
console instead of the default by passing -vga none -device ramfb to the
QEMU command line.

Also increase SYS_MALLOC_F_LEN for QEMU x86_64 to be the same as its SPL
counterpart, because we're running out of alloc space in pre-reloc stage
with ramfb enabled.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
This also suffers from the same issue with distros as the Bochs display
driver [1], where it results in a hang after GRUB menu selection before
the kernel can display anything. Couldn't reproduce on arm*/riscv*.

But just having it enabled doesn't seem to cause problems unless you run
QEMU with -device ramfb, so this (unlike the Bochs video driver) can
actually be co-enabled with VIDEO_VESA.

[1] https://lore.kernel.org/u-boot/20230724145210.304917-4-sjg@chromium.org/

Changes in v2:
- Add patch "x86: qemu: Enable ramfb by default"

 arch/x86/cpu/qemu/Kconfig           |  4 +++
 board/emulation/qemu-x86/qemu-x86.c | 47 +++++++++++++++++++++++++++++
 configs/qemu-x86_64_defconfig       |  4 +--
 configs/qemu-x86_defconfig          |  1 -
 4 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/arch/x86/cpu/qemu/Kconfig b/arch/x86/cpu/qemu/Kconfig
index f8f2f6473088..e0a57ac2d687 100644
--- a/arch/x86/cpu/qemu/Kconfig
+++ b/arch/x86/cpu/qemu/Kconfig
@@ -13,6 +13,10 @@ config QEMU
 	imply USB
 	imply USB_EHCI_HCD
 	imply VIDEO_VESA
+	imply VIDEO_RAMFB
+	imply BOARD_EARLY_INIT_F
+	imply BOARD_EARLY_INIT_R
+	imply CMD_QFW
 
 if QEMU
 
diff --git a/board/emulation/qemu-x86/qemu-x86.c b/board/emulation/qemu-x86/qemu-x86.c
index e69de29bb2d1..3a8a580cc591 100644
--- a/board/emulation/qemu-x86/qemu-x86.c
+++ b/board/emulation/qemu-x86/qemu-x86.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <common.h>
+#include <dm.h>
+#include <init.h>
+#include <log.h>
+#include <qfw.h>
+
+int board_early_init_f(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	/*
+	 * Make sure we enumerate the QEMU Firmware device to bind ramfb
+	 * so video_reserve() can reserve memory for it.
+	 */
+	if (IS_ENABLED(CONFIG_QFW)) {
+		ret = qfw_get_dev(&dev);
+		if (ret) {
+			log_err("Failed to get QEMU FW device: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+int board_early_init_r(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	/*
+	 * Make sure we enumerate the QEMU Firmware device to find ramfb
+	 * before console_init.
+	 */
+	if (IS_ENABLED(CONFIG_QFW)) {
+		ret = qfw_get_dev(&dev);
+		if (ret) {
+			log_err("Failed to get QEMU FW device: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index c6f30674a8fc..c9ad6eebd35c 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -1,13 +1,12 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0x1110000
-CONFIG_SYS_MALLOC_F_LEN=0x1000
+CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x40000
 CONFIG_MAX_CPUS=2
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="qemu-x86_i440fx"
 CONFIG_SPL_TEXT_BASE=0xfffd8000
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
 CONFIG_DEBUG_UART_BASE=0x3f8
 CONFIG_DEBUG_UART_CLOCK=1843200
 CONFIG_X86_RUN_64BIT=y
@@ -59,7 +58,6 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
-CONFIG_CMD_QFW=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index 24682a5387df..8a2311720f02 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -37,7 +37,6 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
-CONFIG_CMD_QFW=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MAC_PARTITION=y
-- 
2.40.1

