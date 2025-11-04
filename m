Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678C2CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 12:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AB508391C;
	Tue,  4 Nov 2025 13:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="Xtiu0gtN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E08F98003E; Tue,  4 Nov 2025 13:56:15 +0100 (CET)
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0403A8390D
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 13:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7B217C9DCE; Tue,  4 Nov 2025 13:56:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1762260972; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=fQy2NQyclVfsZnCOoAo6jRRXHXfIUOPp0kr0rrAX20g=;
 b=Xtiu0gtN4KAMDXIycwlO+KZXu12HkG1Ypr9JK4Y+QG+QFzrBXGE3WAwDdxGKsSR81pjutt
 yGhHu4vDd1RrXOdbs1+aT9HUgja0n8vD6aSJm/WVX/j7S52vNT0mkDSfcjs8z1IJLa4Tvd
 Xv0as1Vd4rQ1PbL0m67tPyQh65+BxpcywWcKYl5GEXP59WGPG4qWNBLJh2O8ET+GJBe9WN
 ubj40LtC7hzD31tzc9zgi3ykiD24P2ZofVadgJvfswADSMllldRIPQ3IM4yFkyLAK+Uyo2
 18o4MpfFhzPSfEkntbUW92cV6VDflSnaWzzACWh2A5VK4zPNiwMBtSkcYR4NYg==
From: Frieder Schrempf <frieder@fris.de>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Eberhard Stoll <eberhard.stoll@kontron.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 4/4] imx: kontron-sl-mx8mm: Add support for reading HW UIDs
Date: Tue,  4 Nov 2025 13:54:28 +0100
Message-ID: <20251104125441.138131-5-frieder@fris.de>
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
 board/kontron/sl-mx8mm/Kconfig     |  2 ++
 board/kontron/sl-mx8mm/sl-mx8mm.c  | 32 ++++++++++++++++++++++++++++++
 configs/kontron-sl-mx8mm_defconfig |  1 +
 3 files changed, 35 insertions(+)

diff --git a/board/kontron/sl-mx8mm/Kconfig b/board/kontron/sl-mx8mm/Kconfig
index 1597bcf894d..0a5123d2979 100644
--- a/board/kontron/sl-mx8mm/Kconfig
+++ b/board/kontron/sl-mx8mm/Kconfig
@@ -9,4 +9,6 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "kontron-sl-mx8mm"
 
+source "board/kontron/common/Kconfig"
+
 endif
diff --git a/board/kontron/sl-mx8mm/sl-mx8mm.c b/board/kontron/sl-mx8mm/sl-mx8mm.c
index df92765cb2d..d24d5286e45 100644
--- a/board/kontron/sl-mx8mm/sl-mx8mm.c
+++ b/board/kontron/sl-mx8mm/sl-mx8mm.c
@@ -18,8 +18,37 @@
 #include <mmc.h>
 #include <net.h>
 
+#include "../common/hw-uid.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
+#if IS_ENABLED(CONFIG_KONTRON_HW_UID)
+
+struct uid_otp_loc uid_otp_locations[] = {
+	{
+		.addr = (u32 *)(OCOTP_BASE_ADDR + 0x7A0),
+		.len = 2,
+		.format = UID_OTP_FORMAT_DEC,
+		.desc = "BOARD"
+	},
+	{
+		.addr = (u32 *)(OCOTP_BASE_ADDR + 0x780),
+		.len = 2,
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
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 struct efi_fw_image fw_images[] = {
 	{
@@ -167,6 +196,9 @@ int board_late_init(void)
 		env_set("touch_rst_gpio", "87");
 	}
 
+	if (IS_ENABLED(CONFIG_KONTRON_HW_UID))
+		get_serial_number(uid_otp_locations, ARRAY_SIZE(uid_otp_locations));
+
 	if (is_usb_boot()) {
 		env_set("bootcmd", "fastboot 0");
 		env_set("bootdelay", "0");
diff --git a/configs/kontron-sl-mx8mm_defconfig b/configs/kontron-sl-mx8mm_defconfig
index 42346a305f9..ed60d3b9ce4 100644
--- a/configs/kontron-sl-mx8mm_defconfig
+++ b/configs/kontron-sl-mx8mm_defconfig
@@ -11,6 +11,7 @@ CONFIG_ENV_OFFSET=0x1E0000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_IMX_CONFIG="board/kontron/sl-mx8mm/imximage.cfg"
 CONFIG_DM_GPIO=y
+CONFIG_KONTRON_HW_UID=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-kontron-bl"
 CONFIG_TARGET_KONTRON_MX8MM=y
-- 
2.51.0

