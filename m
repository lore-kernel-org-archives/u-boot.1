Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A691CCA476
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 08:19:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 071B28390D;
	Tue,  7 Oct 2025 10:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="0nEP6jZh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6537C838E7; Tue,  7 Oct 2025 10:18:25 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91281838F8
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 10:18:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C5718C9A4D; Tue,  7 Oct 2025 10:18:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1759825103; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=7mQf8m2R4UFg9KaChe/U8dumJYKce2h6weOHCNh/k7Y=;
 b=0nEP6jZhdQ8YbbdGEdg9S2OCLhfipSY0fkBSb6KwEPbz3vgQN4tyf1jzwoGDshTMHx7/rx
 dCJ0oRv2ffmGoZZLZ1U2FU2TaXaupO9s6GDXL1q1skV8KsE//v2VpU4OnNzrzmYsuQM1Gf
 L9jGUhtMr8HgY8kqMxxLwluB92fWP6fnkMGQ4FfttFE8RIwDSgEeb19PC09mTg4/NQ/xrM
 gQMMnBQJcHPsjbP788Hrfah1y0VdcGuWrgG0m4EAPwT5Q/vsdd5FHh007KDHTvAWN87Z91
 sv+BLj2XMrDoG8c/37l5pF/HWWqXqqZeyGnPCszKIt3PrdQmFtiIUNGj5+Fgww==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Eberhard Stoll <eberhard.stoll@kontron.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 09/13] imx: kontron-sl-mx8mm: Enable standard boot and disable
 legacy distro boot
Date: Tue,  7 Oct 2025 10:16:06 +0200
Message-ID: <20251007081640.61772-10-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007081640.61772-1-frieder@fris.de>
References: <20251007081640.61772-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The bootstd framework is the new way to support various bootflows
and media. Use it instead of legacy distro boot.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 configs/kontron-sl-mx8mm_defconfig |  3 ++-
 include/configs/kontron-sl-mx8mm.h | 12 ------------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/configs/kontron-sl-mx8mm_defconfig b/configs/kontron-sl-mx8mm_defconfig
index 1d0a6a83052..11ce881bc19 100644
--- a/configs/kontron-sl-mx8mm_defconfig
+++ b/configs/kontron-sl-mx8mm_defconfig
@@ -37,7 +37,7 @@ CONFIG_EFI_CAPSULE_FIRMWARE_FIT=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_SYS_CBSIZE=2048
@@ -99,6 +99,7 @@ CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_RTC=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_GETTIME=y
+CONFIG_CMD_SYSBOOT=y
 CONFIG_CMD_UUID=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
diff --git a/include/configs/kontron-sl-mx8mm.h b/include/configs/kontron-sl-mx8mm.h
index 72a28a6a413..318c39d673a 100644
--- a/include/configs/kontron-sl-mx8mm.h
+++ b/include/configs/kontron-sl-mx8mm.h
@@ -29,21 +29,9 @@
 	EFI_GUID(0xd488e45a, 0x4929, 0x4b55, 0x8c, 0x14, \
 		 0x86, 0xce, 0xa2, 0xcd, 0x66, 0x29)
 
-#define BOOT_TARGET_DEVICES(func) \
-	func(MMC, mmc, 1) \
-	func(MMC, mmc, 0) \
-	func(USB, usb, 0) \
-	func(PXE, pxe, na)
-#include <config_distro_bootcmd.h>
-/* Do not try to probe USB net adapters for net boot */
-#undef BOOTENV_RUN_NET_USB_START
-#define BOOTENV_RUN_NET_USB_START
-
 #ifdef CONFIG_XPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x930000
 #endif
 
-#define CFG_EXTRA_ENV_SETTINGS BOOTENV
-
 #endif /* __KONTRON_MX8MM_CONFIG_H */
-- 
2.51.0

