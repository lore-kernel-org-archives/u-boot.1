Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEAECD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 07:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D73A0883CF;
	Thu,  4 Apr 2024 09:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f5utB+Ca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E1A388393; Thu,  4 Apr 2024 09:51:19 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A50C88393
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 09:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 30A46CE2FAE;
 Thu,  4 Apr 2024 07:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB17C433C7;
 Thu,  4 Apr 2024 07:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712217074;
 bh=ZvrRCPjf9Yalaaq08nQ4/HXMnkfZyAuUr5Z6V9+fwNI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f5utB+CahTRevjElKIIxqzTqYvppnO6JBmIPUhWcA9VCMhoOw1AC/zCrsG6ZjV1+w
 6Nhg2QsySwiQk10iVKzPM+V33efcy01VS7cPNYy/XthyL5EwclXIybKTqFcitJgZX+
 iSR8LxnmTJq5gbQxywfu7xSl0nXKVgnpuVKxr63n3rO8hf8MOcAguSCx+JcRLUw5gD
 AV3p3+xLd+25vyf9ZN7oouX+xCTCXUyWl3ndZ+fK2cifc4ExeqZhwBdLPboo+T1EcI
 GMofXq7y4UIDbU6LXvaW4Ur1LLi48Xzm5A8vThjIt0gARmt8x9+jv1VYz6vIX6bdzF
 6bwSuftu9dX7Q==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v4 02/18] arm: mvebu: turris_omnia: Add header
 containing MCU command interface and use it
Date: Thu,  4 Apr 2024 09:50:51 +0200
Message-ID: <20240404075107.19636-3-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240404075107.19636-1-kabel@kernel.org>
References: <20240404075107.19636-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add header containing all MCU command definitions and use it in board
code and in MCU driver.

Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Stefan Roese <sr@denx.de>
---
 board/CZ.NIC/turris_omnia/turris_omnia.c |  81 +++-----
 drivers/gpio/turris_omnia_mcu.c          |  54 +----
 include/turris-omnia-mcu-interface.h     | 248 +++++++++++++++++++++++
 3 files changed, 272 insertions(+), 111 deletions(-)
 create mode 100644 include/turris-omnia-mcu-interface.h

diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index adeb69a205..6c2d7da528 100644
--- a/board/CZ.NIC/turris_omnia/turris_omnia.c
+++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
@@ -23,6 +23,7 @@
 #include <fdt_support.h>
 #include <hexdump.h>
 #include <time.h>
+#include <turris-omnia-mcu-interface.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <u-boot/crc.h>
@@ -59,46 +60,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #define A385_WD_RSTOUT_UNMASK		MVEBU_REGISTER(0x20704)
 #define   A385_WD_RSTOUT_UNMASK_GLOBAL	BIT(8)
 
-enum mcu_commands {
-	CMD_GET_STATUS_WORD	= 0x01,
-	CMD_GET_RESET		= 0x09,
-	CMD_GET_FW_VERSION_APP	= 0x0a,
-	CMD_WATCHDOG_STATE	= 0x0b,
-	CMD_GET_FW_VERSION_BOOT	= 0x0e,
-
-	/* available if STS_FEATURES_SUPPORTED bit set in status word */
-	CMD_GET_FEATURES	= 0x10,
-
-	/* available if EXT_CMD bit set in features */
-	CMD_EXT_CONTROL		= 0x12,
-};
-
-enum status_word_bits {
-	STS_MCU_TYPE_MASK	= GENMASK(1, 0),
-	STS_MCU_TYPE_STM32	= 0,
-	STS_MCU_TYPE_GD32	= 1,
-	STS_MCU_TYPE_MKL	= 2,
-	STS_MCU_TYPE_UNKN	= 3,
-	STS_FEATURES_SUPPORTED	= BIT(2),
-	CARD_DET_STSBIT		= 0x0010,
-	MSATA_IND_STSBIT	= 0x0020,
-};
-
-/* CMD_GET_FEATURES */
-enum features_e {
-	FEAT_PERIPH_MCU		= BIT(0),
-	FEAT_EXT_CMDS		= BIT(1),
-};
-
-/* CMD_EXT_CONTROL */
-enum ext_ctl_e {
-	EXT_CTL_nRES_LAN	= BIT(1),
-	EXT_CTL_nRES_PHY	= BIT(2),
-	EXT_CTL_nPERST0		= BIT(3),
-	EXT_CTL_nPERST1		= BIT(4),
-	EXT_CTL_nPERST2		= BIT(5),
-};
-
 /*
  * Those values and defines are taken from the Marvell U-Boot version
  * "u-boot-2013.01-2014_T3.0"
@@ -219,7 +180,7 @@ static bool disable_mcu_watchdog(void)
 
 	puts("Disabling MCU watchdog... ");
 
-	ret = omnia_mcu_write(CMD_WATCHDOG_STATE, "\x00", 1);
+	ret = omnia_mcu_write(CMD_SET_WATCHDOG_STATE, "\x00", 1);
 	if (ret) {
 		printf("omnia_mcu_write failed: %i\n", ret);
 		return false;
@@ -256,17 +217,17 @@ static bool omnia_detect_sata(const char *msata_slot)
 		return false;
 	}
 
-	if (!(stsword & CARD_DET_STSBIT)) {
+	if (!(stsword & STS_CARD_DET)) {
 		puts("none\n");
 		return false;
 	}
 
-	if (stsword & MSATA_IND_STSBIT)
+	if (stsword & STS_MSATA_IND)
 		puts("mSATA\n");
 	else
 		puts("MiniPCIe\n");
 
-	return stsword & MSATA_IND_STSBIT ? true : false;
+	return stsword & STS_MSATA_IND;
 }
 
 static bool omnia_detect_wwan_usb3(const char *wwan_slot)
@@ -393,18 +354,7 @@ static int omnia_get_ram_size_gb(void)
 
 static const char * const omnia_get_mcu_type(void)
 {
-	static const char * const mcu_types[] = {
-		[STS_MCU_TYPE_STM32] = "STM32",
-		[STS_MCU_TYPE_GD32]  = "GD32",
-		[STS_MCU_TYPE_MKL]   = "MKL",
-		[STS_MCU_TYPE_UNKN]  = "unknown",
-	};
-	static const char * const mcu_types_with_perip_resets[] = {
-		[STS_MCU_TYPE_STM32] = "STM32 (with peripheral resets)",
-		[STS_MCU_TYPE_GD32]  = "GD32 (with peripheral resets)",
-		[STS_MCU_TYPE_MKL]   = "MKL (with peripheral resets)",
-		[STS_MCU_TYPE_UNKN]  = "unknown (with peripheral resets)",
-	};
+	static char result[] = "xxxxxxx (with peripheral resets)";
 	u16 stsword, features;
 	int ret;
 
@@ -412,13 +362,28 @@ static const char * const omnia_get_mcu_type(void)
 	if (ret)
 		return "unknown";
 
+	switch (stsword & STS_MCU_TYPE_MASK) {
+	case STS_MCU_TYPE_STM32:
+		strcpy(result, "STM32");
+		break;
+	case STS_MCU_TYPE_GD32:
+		strcpy(result, "GD32");
+		break;
+	case STS_MCU_TYPE_MKL:
+		strcpy(result, "MKL");
+		break;
+	default:
+		strcpy(result, "unknown");
+		break;
+	}
+
 	if (stsword & STS_FEATURES_SUPPORTED) {
 		ret = omnia_mcu_read(CMD_GET_FEATURES, &features, sizeof(features));
 		if (ret == 0 && (features & FEAT_PERIPH_MCU))
-			return mcu_types_with_perip_resets[stsword & STS_MCU_TYPE_MASK];
+			strcat(result, " (with peripheral resets)");
 	}
 
-	return mcu_types[stsword & STS_MCU_TYPE_MASK];
+	return result;
 }
 
 static const char * const omnia_get_mcu_version(void)
diff --git a/drivers/gpio/turris_omnia_mcu.c b/drivers/gpio/turris_omnia_mcu.c
index 2d2bf2d1dd..da9a6efe6d 100644
--- a/drivers/gpio/turris_omnia_mcu.c
+++ b/drivers/gpio/turris_omnia_mcu.c
@@ -4,62 +4,10 @@
 #include <common.h>
 #include <dm.h>
 #include <i2c.h>
+#include <turris-omnia-mcu-interface.h>
 #include <asm/gpio.h>
 #include <linux/log2.h>
 
-enum commands_e {
-	CMD_GET_STATUS_WORD                 = 0x01,
-	CMD_GENERAL_CONTROL                 = 0x02,
-
-	/* available if STS_FEATURES_SUPPORTED bit set in status word */
-	CMD_GET_FEATURES                    = 0x10,
-
-	/* available if FEAT_EXT_CMDS bit is set in features */
-	CMD_GET_EXT_STATUS_DWORD            = 0x11,
-
-	/* available if FEAT_EXT_CMDS and FEAT_PERIPH_MCU bits are set in featurs */
-	CMD_EXT_CONTROL                     = 0x12,
-	CMD_GET_EXT_CONTROL_STATUS          = 0x13,
-};
-
-/* CMD_GET_STATUS_WORD */
-enum sts_word_e {
-	STS_MCU_TYPE_MASK                = GENMASK(1, 0),
-	STS_MCU_TYPE_STM32               = 0,
-	STS_MCU_TYPE_GD32                = 1,
-	STS_MCU_TYPE_MKL                 = 2,
-	STS_FEATURES_SUPPORTED           = BIT(2),
-	STS_USER_REGULATOR_NOT_SUPPORTED = BIT(3),
-	STS_CARD_DET                     = BIT(4),
-	STS_MSATA_IND                    = BIT(5),
-	STS_USB30_OVC                    = BIT(6),
-	STS_USB31_OVC                    = BIT(7),
-	STS_USB30_PWRON                  = BIT(8),
-	STS_USB31_PWRON                  = BIT(9),
-	STS_ENABLE_4V5                   = BIT(10),
-	STS_BUTTON_MODE                  = BIT(11),
-	STS_BUTTON_PRESSED               = BIT(12),
-	STS_BUTTON_COUNTER_MASK          = GENMASK(15, 13)
-};
-
-/* CMD_GENERAL_CONTROL */
-enum ctl_byte_e {
-	CTL_LIGHT_RST   = BIT(0),
-	CTL_HARD_RST    = BIT(1),
-	/*CTL_RESERVED    = BIT(2),*/
-	CTL_USB30_PWRON = BIT(3),
-	CTL_USB31_PWRON = BIT(4),
-	CTL_ENABLE_4V5  = BIT(5),
-	CTL_BUTTON_MODE = BIT(6),
-	CTL_BOOTLOADER  = BIT(7)
-};
-
-/* CMD_GET_FEATURES */
-enum features_e {
-	FEAT_PERIPH_MCU         = BIT(0),
-	FEAT_EXT_CMDS           = BIT(1),
-};
-
 struct turris_omnia_mcu_info {
 	u16 features;
 };
diff --git a/include/turris-omnia-mcu-interface.h b/include/turris-omnia-mcu-interface.h
new file mode 100644
index 0000000000..3c4638f732
--- /dev/null
+++ b/include/turris-omnia-mcu-interface.h
@@ -0,0 +1,248 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * CZ.NIC's Turris Omnia MCU I2C interface commands definitions
+ *
+ * 2023 by Marek Behún <kabel@kernel.org>
+ */
+
+#ifndef __TURRIS_OMNIA_MCU_INTERFACE_H
+#define __TURRIS_OMNIA_MCU_INTERFACE_H
+
+#include <linux/bitops.h>
+
+enum omnia_commands_e {
+	CMD_GET_STATUS_WORD		= 0x01, /* slave sends status word back */
+	CMD_GENERAL_CONTROL		= 0x02,
+	CMD_LED_MODE			= 0x03, /* default/user */
+	CMD_LED_STATE			= 0x04, /* LED on/off */
+	CMD_LED_COLOR			= 0x05, /* LED number + RED + GREEN + BLUE */
+	CMD_USER_VOLTAGE		= 0x06,
+	CMD_SET_BRIGHTNESS		= 0x07,
+	CMD_GET_BRIGHTNESS		= 0x08,
+	CMD_GET_RESET			= 0x09,
+	CMD_GET_FW_VERSION_APP		= 0x0A, /* 20B git hash number */
+	CMD_SET_WATCHDOG_STATE		= 0x0B, /* 0 - disable
+						 * 1 - enable / ping
+						 * after boot watchdog is started
+						 * with 2 minutes timeout
+						 */
+
+	/* CMD_WATCHDOG_STATUS		= 0x0C, not implemented anymore */
+
+	CMD_GET_WATCHDOG_STATE		= 0x0D,
+	CMD_GET_FW_VERSION_BOOT		= 0x0E, /* 20B git hash number */
+	CMD_GET_FW_CHECKSUM		= 0x0F, /* 4B length, 4B checksum */
+
+	/* available if FEATURES_SUPPORTED bit set in status word */
+	CMD_GET_FEATURES		= 0x10,
+
+	/* available if EXT_CMD bit set in features */
+	CMD_GET_EXT_STATUS_DWORD	= 0x11,
+	CMD_EXT_CONTROL			= 0x12,
+	CMD_GET_EXT_CONTROL_STATUS	= 0x13,
+
+	/* available if NEW_INT_API bit set in features */
+	CMD_GET_INT_AND_CLEAR		= 0x14,
+	CMD_GET_INT_MASK		= 0x15,
+	CMD_SET_INT_MASK		= 0x16,
+
+	/* available if FLASHING bit set in features */
+	CMD_FLASH			= 0x19,
+
+	/* available if WDT_PING bit set in features */
+	CMD_SET_WDT_TIMEOUT		= 0x20,
+	CMD_GET_WDT_TIMELEFT		= 0x21,
+
+	/* available if POWEROFF_WAKEUP bit set in features */
+	CMD_SET_WAKEUP			= 0x22,
+	CMD_GET_UPTIME_AND_WAKEUP	= 0x23,
+	CMD_POWER_OFF			= 0x24,
+
+	/* available if USB_OVC_PROT_SETTING bit set in features */
+	CMD_SET_USB_OVC_PROT		= 0x25,
+	CMD_GET_USB_OVC_PROT		= 0x26,
+
+	/* available if TRNG bit set in features */
+	CMD_TRNG_COLLECT_ENTROPY	= 0x28,
+
+	/* available if CRYPTO bit set in features */
+	CMD_CRYPTO_GET_PUBLIC_KEY	= 0x29,
+	CMD_CRYPTO_SIGN_MESSAGE		= 0x2A,
+	CMD_CRYPTO_COLLECT_SIGNATURE	= 0x2B,
+
+	/* available if BOARD_INFO it set in features */
+	CMD_BOARD_INFO_GET		= 0x2C,
+	CMD_BOARD_INFO_BURN		= 0x2D,
+
+	/* available only at address 0x2b (led-controller) */
+	/* available only if LED_GAMMA_CORRECTION bit set in features */
+	CMD_SET_GAMMA_CORRECTION	= 0x30,
+	CMD_GET_GAMMA_CORRECTION	= 0x31,
+
+	/* available only at address 0x2b (led-controller) */
+	/* available only if PER_LED_CORRECTION bit set in features */
+	/* available only if FROM_BIT_16_INVALID bit NOT set in features */
+	CMD_SET_LED_CORRECTIONS		= 0x32,
+	CMD_GET_LED_CORRECTIONS		= 0x33,
+};
+
+enum omnia_flashing_commands_e {
+	FLASH_CMD_UNLOCK		= 0x01,
+	FLASH_CMD_SIZE_AND_CSUM		= 0x02,
+	FLASH_CMD_PROGRAM		= 0x03,
+	FLASH_CMD_RESET			= 0x04,
+};
+
+enum omnia_sts_word_e {
+	STS_MCU_TYPE_MASK			= GENMASK(1, 0),
+	STS_MCU_TYPE_STM32			= 0 << 0,
+	STS_MCU_TYPE_GD32			= 1 << 0,
+	STS_MCU_TYPE_MKL			= 2 << 0,
+	STS_FEATURES_SUPPORTED			= BIT(2),
+	STS_USER_REGULATOR_NOT_SUPPORTED	= BIT(3),
+	STS_CARD_DET				= BIT(4),
+	STS_MSATA_IND				= BIT(5),
+	STS_USB30_OVC				= BIT(6),
+	STS_USB31_OVC				= BIT(7),
+	STS_USB30_PWRON				= BIT(8),
+	STS_USB31_PWRON				= BIT(9),
+	STS_ENABLE_4V5				= BIT(10),
+	STS_BUTTON_MODE				= BIT(11),
+	STS_BUTTON_PRESSED			= BIT(12),
+	STS_BUTTON_COUNTER_MASK			= GENMASK(15, 13)
+};
+
+enum omnia_ctl_byte_e {
+	CTL_LIGHT_RST		= BIT(0),
+	CTL_HARD_RST		= BIT(1),
+	/* BIT(2) is currently reserved */
+	CTL_USB30_PWRON		= BIT(3),
+	CTL_USB31_PWRON		= BIT(4),
+	CTL_ENABLE_4V5		= BIT(5),
+	CTL_BUTTON_MODE		= BIT(6),
+	CTL_BOOTLOADER		= BIT(7)
+};
+
+enum omnia_features_e {
+	FEAT_PERIPH_MCU			= BIT(0),
+	FEAT_EXT_CMDS			= BIT(1),
+	FEAT_WDT_PING			= BIT(2),
+	FEAT_LED_STATE_EXT_MASK		= GENMASK(4, 3),
+	FEAT_LED_STATE_EXT		= 1 << 3,
+	FEAT_LED_STATE_EXT_V32		= 2 << 3,
+	FEAT_LED_GAMMA_CORRECTION	= BIT(5),
+	FEAT_NEW_INT_API		= BIT(6),
+	FEAT_BOOTLOADER			= BIT(7),
+	FEAT_FLASHING			= BIT(8),
+	FEAT_NEW_MESSAGE_API		= BIT(9),
+	FEAT_BRIGHTNESS_INT		= BIT(10),
+	FEAT_POWEROFF_WAKEUP		= BIT(11),
+	FEAT_CAN_OLD_MESSAGE_API	= BIT(12),
+	FEAT_TRNG			= BIT(13),
+	FEAT_CRYPTO			= BIT(14),
+	FEAT_BOARD_INFO			= BIT(15),
+
+	/*
+	 * Orginally the features command replied only 16 bits. If more were
+	 * read, either the I2C transaction failed or 0xff bytes were sent.
+	 * Therefore to consider bits 16 - 31 valid, one bit (20) was reserved
+	 * to be zero.
+	 */
+
+	/* Bits 16 - 19 correspond to bits 0 - 3 of status word */
+	FEAT_MCU_TYPE_MASK		= GENMASK(17, 16),
+	FEAT_MCU_TYPE_STM32		= 0 << 16,
+	FEAT_MCU_TYPE_GD32		= 1 << 16,
+	FEAT_MCU_TYPE_MKL		= 2 << 16,
+	FEAT_FEATURES_SUPPORTED		= BIT(18),
+	FEAT_USER_REGULATOR_NOT_SUPPORTED = BIT(19),
+
+	/* must not be set */
+	FEAT_FROM_BIT_16_INVALID	= BIT(20),
+
+	FEAT_PER_LED_CORRECTION		= BIT(21),
+	FEAT_USB_OVC_PROT_SETTING	= BIT(22),
+};
+
+enum omnia_ext_sts_dword_e {
+	EXT_STS_SFP_nDET		= BIT(0),
+	EXT_STS_LED_STATES_MASK		= GENMASK(31, 12),
+	EXT_STS_WLAN0_MSATA_LED		= BIT(12),
+	EXT_STS_WLAN1_LED		= BIT(13),
+	EXT_STS_WLAN2_LED		= BIT(14),
+	EXT_STS_WPAN0_LED		= BIT(15),
+	EXT_STS_WPAN1_LED		= BIT(16),
+	EXT_STS_WPAN2_LED		= BIT(17),
+	EXT_STS_WAN_LED0		= BIT(18),
+	EXT_STS_WAN_LED1		= BIT(19),
+	EXT_STS_LAN0_LED0		= BIT(20),
+	EXT_STS_LAN0_LED1		= BIT(21),
+	EXT_STS_LAN1_LED0		= BIT(22),
+	EXT_STS_LAN1_LED1		= BIT(23),
+	EXT_STS_LAN2_LED0		= BIT(24),
+	EXT_STS_LAN2_LED1		= BIT(25),
+	EXT_STS_LAN3_LED0		= BIT(26),
+	EXT_STS_LAN3_LED1		= BIT(27),
+	EXT_STS_LAN4_LED0		= BIT(28),
+	EXT_STS_LAN4_LED1		= BIT(29),
+	EXT_STS_LAN5_LED0		= BIT(30),
+	EXT_STS_LAN5_LED1		= BIT(31),
+};
+
+enum omnia_ext_ctl_e {
+	EXT_CTL_nRES_MMC		= BIT(0),
+	EXT_CTL_nRES_LAN		= BIT(1),
+	EXT_CTL_nRES_PHY		= BIT(2),
+	EXT_CTL_nPERST0			= BIT(3),
+	EXT_CTL_nPERST1			= BIT(4),
+	EXT_CTL_nPERST2			= BIT(5),
+	EXT_CTL_PHY_SFP			= BIT(6),
+	EXT_CTL_PHY_SFP_AUTO		= BIT(7),
+	EXT_CTL_nVHV_CTRL		= BIT(8),
+};
+
+enum omnia_int_e {
+	INT_CARD_DET		= BIT(0),
+	INT_MSATA_IND		= BIT(1),
+	INT_USB30_OVC		= BIT(2),
+	INT_USB31_OVC		= BIT(3),
+	INT_BUTTON_PRESSED	= BIT(4),
+	INT_SFP_nDET		= BIT(5),
+	INT_BRIGHTNESS_CHANGED	= BIT(6),
+	INT_TRNG		= BIT(7),
+	INT_MESSAGE_SIGNED	= BIT(8),
+
+	INT_LED_STATES_MASK	= GENMASK(31, 12),
+	INT_WLAN0_MSATA_LED	= BIT(12),
+	INT_WLAN1_LED		= BIT(13),
+	INT_WLAN2_LED		= BIT(14),
+	INT_WPAN0_LED		= BIT(15),
+	INT_WPAN1_LED		= BIT(16),
+	INT_WPAN2_LED		= BIT(17),
+	INT_WAN_LED0		= BIT(18),
+	INT_WAN_LED1		= BIT(19),
+	INT_LAN0_LED0		= BIT(20),
+	INT_LAN0_LED1		= BIT(21),
+	INT_LAN1_LED0		= BIT(22),
+	INT_LAN1_LED1		= BIT(23),
+	INT_LAN2_LED0		= BIT(24),
+	INT_LAN2_LED1		= BIT(25),
+	INT_LAN3_LED0		= BIT(26),
+	INT_LAN3_LED1		= BIT(27),
+	INT_LAN4_LED0		= BIT(28),
+	INT_LAN4_LED1		= BIT(29),
+	INT_LAN5_LED0		= BIT(30),
+	INT_LAN5_LED1		= BIT(31),
+};
+
+enum omnia_cmd_poweroff_e {
+	CMD_POWER_OFF_POWERON_BUTTON	= BIT(0),
+	CMD_POWER_OFF_MAGIC		= 0xdead,
+};
+
+enum cmd_usb_ovc_prot_e {
+	CMD_xET_USB_OVC_PROT_PORT_MASK	= GENMASK(3, 0),
+	CMD_xET_USB_OVC_PROT_ENABLE	= BIT(4),
+};
+
+#endif /* __TURRIS_OMNIA_MCU_INTERFACE_H */
-- 
2.43.2

