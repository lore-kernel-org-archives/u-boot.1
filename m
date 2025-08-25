Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FB1CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 13:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD08483106;
	Mon, 25 Aug 2025 15:55:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="vPKtr6Ds";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DECC82FC7; Mon, 25 Aug 2025 15:55:42 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9773E82FC7
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:55:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E2366C994B; Mon, 25 Aug 2025 15:55:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1756130140; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=4VRZvoJChS6ToNaM9BHXfz/PmRQQWVY2vQDXJIK/r6A=;
 b=vPKtr6DsCMIRyqOYt2gBkhtESvXo8YyJXw7z9fbc2WGZ2acWXBmsTopVpVbFiu1gyP7uGr
 Usn9pSjJQ8ryi37p6jTYsEojDwqDl8/0qAoVZLJC1JiRVIGXPIUK3DqEH9/cVkgSOx/iut
 Ub3gg/SnvJJ9TQk2g0Jf5Q8GIU/Mqnrba1zTayzwAJ595F5tyhVVm3swuDhBnFd4Btdpgf
 XJNo1EDSp5W2HpY97PQxYpWu3D/RScINCPvlCF/9JjN92raIRoM2oCvze7NgJ4b6D5CDrg
 sZZG9d/N0iN1P0KZ/1ooFED15Il3oXoSbrmVRzjPIkzsPmvp2A5nMkg4BAnFaA==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Annette Kobou <annette.kobou@kontron.de>,
 Eberhard Stoll <eberhard.stoll@kontron.de>,
 Fabio Estevam <festevam@denx.de>, Marek Vasut <marex@denx.de>,
 Oualid Derouiche <oualid.derouiche@kontron.de>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 02/11] imx: kontron-sl-mx6ul: Enable standard boot and disable
 legacy distro boot
Date: Mon, 25 Aug 2025 15:54:26 +0200
Message-ID: <20250825135504.193004-3-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825135504.193004-1-frieder@fris.de>
References: <20250825135504.193004-1-frieder@fris.de>
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

Disable the legacy distro boot and use bootstd instead.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 configs/kontron-sl-mx6ul_defconfig |  3 ++-
 include/configs/kontron-sl-mx6ul.h | 12 ------------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/configs/kontron-sl-mx6ul_defconfig b/configs/kontron-sl-mx6ul_defconfig
index 9ee02259948..b04cd75a7d4 100644
--- a/configs/kontron-sl-mx6ul_defconfig
+++ b/configs/kontron-sl-mx6ul_defconfig
@@ -25,7 +25,7 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_FDT_FIXUP_PARTITIONS=y
 CONFIG_SYS_PBSIZE=532
@@ -50,6 +50,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
+CONFIG_CMD_SYSBOOT=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FS_UUID=y
 CONFIG_CMD_MTDPARTS=y
diff --git a/include/configs/kontron-sl-mx6ul.h b/include/configs/kontron-sl-mx6ul.h
index 015df01db4e..e2152eb05ed 100644
--- a/include/configs/kontron-sl-mx6ul.h
+++ b/include/configs/kontron-sl-mx6ul.h
@@ -24,22 +24,10 @@
 /* Board and environment settings */
 #define CFG_MXC_UART_BASE		UART4_BASE
 
-/* Boot order for distro boot */
-#define BOOT_TARGET_DEVICES(func) \
-	func(MMC, mmc, 1) \
-	func(MMC, mmc, 0) \
-	func(UBIFS, ubifs, 0, UBI, boot) \
-	func(USB, usb, 0) \
-	func(PXE, pxe, na) \
-	func(DHCP, dhcp, na)
-#include <config_distro_bootcmd.h>
-
 /* MMC Configs */
 #ifdef CONFIG_FSL_USDHC
 #define CFG_SYS_FSL_ESDHC_ADDR	USDHC1_BASE_ADDR
 #define CFG_SYS_FSL_USDHC_NUM	2
 #endif
 
-#define CFG_EXTRA_ENV_SETTINGS BOOTENV
-
 #endif /* __KONTRON_MX6UL_CONFIG_H */
-- 
2.50.1

