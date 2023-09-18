Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB13FC46CA1
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 03:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2107808E6;
	Mon, 18 Sep 2023 05:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="heiBvQX+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD4EA85DD2; Mon, 18 Sep 2023 05:47:39 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF8F6807BC
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 05:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6563fe128efso8319296d6.3
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 20:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695008856; x=1695613656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6qr6AkJJTIHEyrW+mA3QE3fh1kD21KHk60sfjmP9KgQ=;
 b=heiBvQX+fbtfb9t/dhKqGPb5aLziBJ7yedoDNkHLXvZN3l+/DbyyP0Z5ap/y2e/Hf1
 yfMxnN7SM5gFiJFFm6aD85jIoewGjcx3Xw6l47Ocd1RDzM2abA+KtP40pgYKzWb+WgP0
 TD1XV/wnoV5GeG7Wo/vbnXy/phQTr3avhSBeG7/oAAdtVniiXo4l+cgatssPPCM3C/y/
 1SGLcChL61K86odbAAytsivehLPK+Z2tW49wW3hbnx9dkItcVGu4QddGS//dXmH96869
 XT+VtVAwVUHRh67O9y3OUj/Rdb8jPEGCTiqVgrole6t1CNtgtXMe6Xnv0SXZO7MZXXh/
 KLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695008856; x=1695613656;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6qr6AkJJTIHEyrW+mA3QE3fh1kD21KHk60sfjmP9KgQ=;
 b=cvikXsJ+OHEUKSE3/P+oxp74YHwXU13q7Otr2hg5zJkOYym9XHa0nXmx4DSzM7kkbe
 57VYVw98w9N/wT+MyJn+3j9nGiDnvHQNlISZLzFj9jTgyYS8BAWEB97mIqzf1zEgO/nM
 a5JMXejgysi3AHujI5NBO1cM8z2X33hKTm0zoUAJSP4egTG7OrymPg1CUm3MpXiCIl9d
 sY4O0METkk/JOwGmIoHmlcY3o4+SrKAf81VCEssHREHhdMuIYdHNf/nOZ+v7lxAqe2fY
 vecOBBf4uPMPkkNwtnIVXvX7N9twR+N8X6wUGZASXdWUgWfH8lo1DadR7jgG9eimTpa9
 4epw==
X-Gm-Message-State: AOJu0YwqDwRTaECgMl9U3wcXOZ1go3H1cwFeDOLtJARUbHkKwwxgDh/k
 WGkTNnk6v3vQkBhDvBhXZXIt8N7ABhu0tQ==
X-Google-Smtp-Source: AGHT+IGWii13sQVq6ZaqKxADANRoOezrpiXJZSV1TmMNV6KVVXiDuawuK7ukVKcaQ+H+vEjZq6UDEg==
X-Received: by 2002:a0c:f6cd:0:b0:647:18a7:2e28 with SMTP id
 d13-20020a0cf6cd000000b0064718a72e28mr7201626qvo.61.1695008855858; 
 Sun, 17 Sep 2023 20:47:35 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab
 ([2600:4040:5799:6900:290:faff:fe04:4080])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a0ce191000000b0064f4d3bc78csm3098632qvl.61.2023.09.17.20.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 20:47:35 -0700 (PDT)
From: Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To: u-boot@lists.denx.de
Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Jesse Taube <Mr.Bossman075@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1] configs: imxrt1050-evk: enable distro bootcmd
Date: Sun, 17 Sep 2023 23:47:34 -0400
Message-Id: <20230918034734.322676-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Add support to boot from script.scr from mmc.

imxrt1050-evk was not able to boot from script.scr because we did not
include config_distro_bootcmd.h and set the device to mmc.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 configs/imxrt1050-evk_defconfig |  2 +-
 include/configs/imxrt1050-evk.h | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/configs/imxrt1050-evk_defconfig b/configs/imxrt1050-evk_defconfig
index cbf9469b24..35c0364e6b 100644
--- a/configs/imxrt1050-evk_defconfig
+++ b/configs/imxrt1050-evk_defconfig
@@ -25,7 +25,6 @@ CONFIG_HAVE_SYS_UBOOT_START=y
 CONFIG_SYS_UBOOT_START=0x800023FD
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
-# CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_SYS_CONSOLE_ENV_OVERWRITE=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_NO_BSS_LIMIT=y
@@ -40,6 +39,7 @@ CONFIG_SYS_PBSIZE=276
 # CONFIG_BOOTM_PLAN9 is not set
 # CONFIG_BOOTM_RTEMS is not set
 # CONFIG_BOOTM_VXWORKS is not set
+CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_MII is not set
 # CONFIG_SPL_DOS_PARTITION is not set
diff --git a/include/configs/imxrt1050-evk.h b/include/configs/imxrt1050-evk.h
index 2af2dde2ae..4b78d61d3f 100644
--- a/include/configs/imxrt1050-evk.h
+++ b/include/configs/imxrt1050-evk.h
@@ -19,10 +19,23 @@
 					 DMAMEM_SZ_ALL)
 
 #ifdef CONFIG_VIDEO
-#define CFG_EXTRA_ENV_SETTINGS \
+#define ENV_DEVICE_SETTINGS \
 		"stdin=serial\0" \
 		"stdout=serial,vidconsole\0" \
 		"stderr=serial,vidconsole\0"
 #endif
 
+/* Config distro_bootcmd */
+#ifndef CONFIG_SPL_BUILD
+#define BOOT_TARGET_DEVICES(func) \
+	func(MMC, mmc, 0)
+#include <config_distro_bootcmd.h>
+#endif
+
+#define CFG_EXTRA_ENV_SETTINGS \
+	ENV_DEVICE_SETTINGS \
+	BOOTENV \
+	"scriptaddr=" __stringify(PHYS_SDRAM) "\0" \
+	"kernel_addr_r" __stringify(PHYS_SDRAM) "\0"
+
 #endif /* __IMXRT1050_EVK_H */
-- 
2.40.1

