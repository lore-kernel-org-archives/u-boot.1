Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D53CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 12:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D1E1835FE;
	Tue,  4 Nov 2025 13:56:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="rnfIJhIR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 304D88391B; Tue,  4 Nov 2025 13:56:14 +0100 (CET)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0C4C835FE
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 13:56:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2098EC9DCF; Tue,  4 Nov 2025 13:56:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1762260971; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=F+XjkujLZ0agSjYSnmRfFttY2aXtL9YGRvEjBwYWX7A=;
 b=rnfIJhIRrjoje0dVyBs7x58ZngZeiS1AjBes7RUOe/QRe99vVRkv/YoXaZl3WTJnxffHzH
 rT658OoeDT71EuZaps7yzfgmtL86f10kR4BTbMxnN5lKCHZeScfgxP6Z7ijJ8jNynZUcLL
 7XKtPGp85cbXhYJvCs1iQEMAoZPEAUDsAFxS2d1QP/G3n6RjO1jAydZ8sMrUNSRfFP7mqZ
 JMcky2SfLU5r+CRYlhmqkZHLTHbLR15vX3I93iVplrLVQieL/xMkvnlTfjzsTTWFscJxV8
 Dfro6aWINU0vrEo7Nv9LHOt3QMooKxMhPbpNTiS6K/e8NUOD65tyUAiNlV1WlQ==
From: Frieder Schrempf <frieder@fris.de>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Annette Kobou <annette.kobou@kontron.de>,
 Eberhard Stoll <eberhard.stoll@kontron.de>,
 Oualid Derouiche <oualid.derouiche@kontron.de>
Subject: [PATCH 3/4] imx: kontron-sl-mx6ul: Add support for reading HW UIDs
Date: Tue,  4 Nov 2025 13:54:27 +0100
Message-ID: <20251104125441.138131-4-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104125441.138131-1-frieder@fris.de>
References: <20251104125441.138131-1-frieder@fris.de>
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

The factory provides a CPU UID in the OTPs and the SoM module
and the carrier board might provide additional UIDs in the GP
registers of the OTPs. Load these values in the following order
and create a serial number string:

* Board UID (GP2)
* SoM UID (GP1)
* CPU UID (UNIQUE_ID)

The string is stored in the "serial#" env variable and
exported to Linux. Further this prints the used UID to the
console which looks like this

  ID:    0042152331 (Board)

or:

  ID:    0030124840 (SoM)

or:

  ID:    4696668CD9516886 (CPU)

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 board/kontron/sl-mx6ul/Kconfig     |  2 ++
 board/kontron/sl-mx6ul/sl-mx6ul.c  | 32 ++++++++++++++++++++++++++++++
 configs/kontron-sl-mx6ul_defconfig |  1 +
 3 files changed, 35 insertions(+)

diff --git a/board/kontron/sl-mx6ul/Kconfig b/board/kontron/sl-mx6ul/Kconfig
index 7a4ffbed289..a6d3fa49778 100644
--- a/board/kontron/sl-mx6ul/Kconfig
+++ b/board/kontron/sl-mx6ul/Kconfig
@@ -9,4 +9,6 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "kontron-sl-mx6ul"
 
+source "board/kontron/common/Kconfig"
+
 endif
diff --git a/board/kontron/sl-mx6ul/sl-mx6ul.c b/board/kontron/sl-mx6ul/sl-mx6ul.c
index 65f9b75c1a0..9dda8822ef9 100644
--- a/board/kontron/sl-mx6ul/sl-mx6ul.c
+++ b/board/kontron/sl-mx6ul/sl-mx6ul.c
@@ -14,8 +14,37 @@
 
 #include "sl-mx6ul-common.h"
 
+#include "../common/hw-uid.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
+#if IS_ENABLED(CONFIG_KONTRON_HW_UID)
+
+struct uid_otp_loc uid_otp_locations[] = {
+	{
+		.addr = (u32 *)(OCOTP_BASE_ADDR + 0x670),
+		.len = 1,
+		.format = UID_OTP_FORMAT_DEC,
+		.desc = "BOARD"
+	},
+	{
+		.addr = (u32 *)(OCOTP_BASE_ADDR + 0x660),
+		.len = 1,
+		.format = UID_OTP_FORMAT_DEC,
+		.desc = "SOM"
+	},
+#if IS_ENABLED(CONFIG_KONTRON_HW_UID_USE_SOC_FALLBACK)
+	{
+		.addr = (u32 *)(OCOTP_BASE_ADDR + 0x410),
+		.len = 2,
+		.format = UID_OTP_FORMAT_HEX,
+		.desc = "SOC"
+	}
+#endif
+};
+
+#endif /* CONFIG_KONTRON_HW_UID */
+
 int dram_init(void)
 {
 	gd->ram_size = imx_ddr_size();
@@ -91,6 +120,9 @@ int board_init(void)
 
 int board_late_init(void)
 {
+	if (IS_ENABLED(CONFIG_KONTRON_HW_UID))
+		get_serial_number(uid_otp_locations, ARRAY_SIZE(uid_otp_locations));
+
 	if (is_boot_from_usb()) {
 		env_set("bootdelay", "0");
 		env_set("bootcmd", "fastboot 0");
diff --git a/configs/kontron-sl-mx6ul_defconfig b/configs/kontron-sl-mx6ul_defconfig
index 9f7003bf54c..c6d450419cc 100644
--- a/configs/kontron-sl-mx6ul_defconfig
+++ b/configs/kontron-sl-mx6ul_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_SECT_SIZE=0x4000
 CONFIG_MX6UL=y
 CONFIG_TARGET_KONTRON_MX6UL=y
 CONFIG_DM_GPIO=y
+CONFIG_KONTRON_HW_UID=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ul-kontron-bl"
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
-- 
2.51.0

