Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7EDC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 16:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE2B880C77;
	Mon, 10 Feb 2025 17:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ov94eyn/";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="HRGWCciN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CBA880821; Mon, 10 Feb 2025 16:30:08 +0100 (CET)
Received: from a7-39.smtp-out.eu-west-1.amazonses.com
 (a7-39.smtp-out.eu-west-1.amazonses.com [54.240.7.39])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 380B3807D6
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 16:30:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=01020194f07b6209-3b8247dc-bfaa-460e-b2d3-9e3375b2609d-000000@amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=bc7lryepznv65m6r2ewkpoafjt4fiq42; d=collabora.com; t=1739201405;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=xQrRfeE6UTsXEBYGiFVF5fD8jiarNnVDqcr8COpxWiE=;
 b=ov94eyn/PNdYXU+Ii1Q4DmxydAvpd5w5Jh6Xp+eW6fh5lXHvVeYVh2Iig7jaztle
 amnyJMswMVEKYhkL4LyZojEHV680E4fxFk9TBlhaStKhgXJH+8gt24AaLj0usQpNTWa
 IVExSBaocWbzFF5xzxIpWntsCsZLO3+zZMHBcqna/oRh0y4BBxx4WeCQoi2CdwdyrKW
 iyfGcAzXuKOUEMZYXcde6f2yvUI6T2x8C9WTm4TjBuzAbsQioQkMY6MYcaGsEWvEtcc
 sSCcq/b0/+pG5m10aCfkF+1Ber6X8t+CVnoDjF17RmF0x8eCPFBbIobX/XCkcc0OGqc
 OwonBEwS0w==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1739201405;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
 bh=xQrRfeE6UTsXEBYGiFVF5fD8jiarNnVDqcr8COpxWiE=;
 b=HRGWCciNEZkRvM3oezKxrwifgsmiQmUnzcgaqPt0XJlIzxFoWXTN6yc7VFXFNOYA
 BAUDNA6DrY+9V6+EosAfT1fqb7fXtfGgL8g7skbhe2ZLm3olgZ6gcnBlgXoHtxcDACl
 FLcXQuyZpti2FsO4+usKKmIXb7j64a5co31YOvw0=
From: Arnaud Patard <arnaud.patard@collabora.com>
To: u-boot@lists.denx.de
Cc: Arnaud Patard <arnaud.patard@collabora.com>, 
 Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/6] include/configs/rk3399_common.h: define
 CFG_EXTRA_ENV_SETTINGS in XPL build
Date: Mon, 10 Feb 2025 15:30:05 +0000
Message-ID: <01020194f07b6209-3b8247dc-bfaa-460e-b2d3-9e3375b2609d-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210152947.3909357-1-arnaud.patard@collabora.com>
References: <20250210152947.3909357-1-arnaud.patard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2025.02.10-54.240.7.39
X-Mailman-Approved-At: Mon, 10 Feb 2025 17:47:57 +0100
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

To use SPL DFU, some environment variables are needed so define
CFG_EXTRA_ENV_SETTINGS for XPL builds.

Signed-off-by: Arnaud Patard <arnaud.patard@collabora.com>
---
 include/configs/rk3399_common.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/configs/rk3399_common.h b/include/configs/rk3399_common.h
index 76f40e7cd5f..e5f0206ba53 100644
--- a/include/configs/rk3399_common.h
+++ b/include/configs/rk3399_common.h
@@ -5,7 +5,7 @@
 
 #ifndef __CONFIG_RK3399_COMMON_H
 #define __CONFIG_RK3399_COMMON_H
-
+#include <linux/stringify.h>
 #include "rockchip-common.h"
 
 #define CFG_IRAM_BASE			0xff8c0000
@@ -13,7 +13,6 @@
 #define CFG_SYS_SDRAM_BASE		0
 #define SDRAM_MAX_SIZE			0xf8000000
 
-#ifndef CONFIG_XPL_BUILD
 
 #ifndef ROCKCHIP_DEVICE_SETTINGS
 #define ROCKCHIP_DEVICE_SETTINGS
@@ -31,6 +30,8 @@
 	"ramdisk_addr_r=0x12180000\0"	\
 	"kernel_comp_size=0x8000000\0"
 
+#ifndef CONFIG_XPL_BUILD
+
 #define CFG_EXTRA_ENV_SETTINGS		\
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
 	"partitions=" PARTS_DEFAULT	\
@@ -38,6 +39,19 @@
 	ROCKCHIP_DEVICE_SETTINGS	\
 	"boot_targets=" BOOT_TARGETS "\0"
 
+
+#else
+
+#define CFG_EXTRA_ENV_SETTINGS		\
+	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
+	ENV_MEM_LAYOUT_SETTINGS		\
+	ROCKCHIP_DEVICE_SETTINGS	\
+	"dfu_alt_info=ram ram0=ram ram " \
+		__stringify(CONFIG_SPL_LOAD_FIT_ADDRESS) " " \
+		__stringify(CONFIG_SYS_DFU_DATA_BUF_SIZE) "\0"	\
+	"dfu_alt_info_ram=u-boot.itb ram " \
+		__stringify(CONFIG_SPL_LOAD_FIT_ADDRESS) " " \
+		__stringify(CONFIG_SYS_DFU_DATA_BUF_SIZE)
 #endif /* CONFIG_XPL_BUILD */
 
 #endif /* __CONFIG_RK3399_COMMON_H */
-- 
2.39.5

