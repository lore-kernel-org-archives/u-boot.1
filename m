Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DB5CCD184
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 06:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 996C483655;
	Fri, 17 Oct 2025 08:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LtukY2Ax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C391D83710; Fri, 17 Oct 2025 08:24:31 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C80F83631
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 08:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so14114925e9.1
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 23:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760682269; x=1761287069;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1AoV3bM07UBmzOmnEACJWzgYFTffhL6+/gksJ1vGAbo=;
 b=LtukY2Axran/XAGfxSOkQZ2oRWGsfrisGkmblMzEgP62sUmwEoT3A5Rf5P5MvPdRQF
 4uSWQWDV/ZX9HMx1uBJGugpOPFN3gtNdmnsZPNJ+JxycZkEli6MdVdCb6VF+drg/FZ2K
 62yCVNUhpHTgE3z7REwO2T5DAVFakdkK5LtYrL71SpuDvhtOW+IPabUDdkzkjpTz0XyM
 BrY79mXTyBOGF/LDVQLP34rZtfHvV/4MfGKNZ/YFkhSn9NbRr2ghkrTAooeFPO892ZtN
 4GFILr/zIyZi68MkCbNDo3fl21mv1z4xj3HYL36WGDE8/VucBJouvR406/VVSxlsrbH2
 9MRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760682269; x=1761287069;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1AoV3bM07UBmzOmnEACJWzgYFTffhL6+/gksJ1vGAbo=;
 b=ZTWR+0tH3oCtSpiH0piGhTBic3MOlEd11wAs4zZ7a91Z+Dmgxo/Q3C+WAzNfkgJXHg
 XoleOSuft/uBeHHyN8ChkAzuLId+FBzD5RwOoSN5qWUqLDWnQh9TRrYUEz0W3BkJTQCU
 0+Bud8QfmzousvyYBde0X7SjyYiYBIh8iROsqO2GC6nRV7+D1zE6S75woPr23zbJWlpW
 pcat4h1cJ3wfGiyUMJmxJP51XwxAq3I1sPsDyqYrRZI7NuhYA+pJBBzjrR/HVG7uhLfB
 rJsQSQADfN2iCuVFQOwM3rejSmLaryXrQ7wCZ52brw8aeX0fgbGttw2w1TXOCCwSFKVP
 oW0g==
X-Gm-Message-State: AOJu0YwWvx03SuGDvVv+aM3t4pvF3atuEv+lNcmgtoP4us5irLj8cTRV
 23wgOF7R8qNGMTF3uW1oW8jz9xJWcmiO8+ZZUHBCAnspgkbLx5FL/mYkNQqUZMxOxdY=
X-Gm-Gg: ASbGncspQh4ppcu2aLc6JFKRgn0ld7hjVouTysOPvU8YnbM2cuZcErujJoO8rpExIXV
 tnRLWCdhlqR16h0PD9Y8OL815gu/rDbQ85Oh3lMAKLL/sOgBln92L7uA8SkhW+6Z71LDrF+Qpwz
 /1E3yKzGDGXWnoehRjLzA6BQgd3U/rM4asROcZ0dxphOiKts76g+Xgl89GU5JMAiWuWh9sehlb3
 plJuO2sSxBVs4wbO3f5PXz0RBSS5XdwmM9yVVhcFd1yMd9YzF3DqfSTVClc7OZuRA+z2FGpv1IF
 Dv6O896gs0oEULUCB5lHalsZVihUQsvxEf2QmW0qJsHwdbElRWxyX085S/KCGVar4outuTtfmzU
 gUKnI5CTUtMuruszHeKZ//06dEqWCBhePX2U3S585nKjfHd3wUcam7TJXQiTTcmzhMvO/o1GV93
 3TuOKHJJs2awIABA==
X-Google-Smtp-Source: AGHT+IHwz4eYpd5Me4YfmCJ0tQp9+OkA9vuLMY68+ndG1HzpXxmHfCWaP315Nn/HnLggOb3GbnBAIQ==
X-Received: by 2002:a05:600c:1d9b:b0:465:a51d:d4 with SMTP id
 5b1f17b1804b1-471178784c2mr20217695e9.6.1760682268974; 
 Thu, 16 Oct 2025 23:24:28 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:4f9d:9005:7d78:d1f4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47114423862sm66061705e9.1.2025.10.16.23.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 23:24:28 -0700 (PDT)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Fri, 17 Oct 2025 08:24:23 +0200
Subject: [PATCH] board: am62x: Add support for reading eeprom data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-am62xeeprom-v1-1-31f83124189f@baylibre.com>
X-B4-Tracking: v=1; b=H4sIABbh8WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Mz3cRcM6OK1NSCovxcXRPDRENLI4Mki6QUIyWgjoKi1LTMCrBp0bG
 1tQBRyugCXQAAAA==
X-Change-ID: 20251016-am62xeeprom-41a1920b8bd2
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Wadim Egorov <w.egorov@phytec.de>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Santhosh Kumar K <s-k6@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Devarsh Thakkar <devarsht@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, Judith Mendez <jm@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
X-Mailer: b4 0.14.3
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

I2C EEPROM data contains the board name and its revision.
Add support for:
- Reading EEPROM data and store a copy at end of SRAM
- Updating env variable with relevant board info
- Printing board info during boot.

Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 arch/arm/mach-k3/am62x/Kconfig |  3 ++
 board/ti/am62x/evm.c           | 95 +++++++++++++++++++++++++++++++++++++++++-
 configs/am62x_evm_r5_defconfig |  1 +
 3 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/am62x/Kconfig b/arch/arm/mach-k3/am62x/Kconfig
index 81199ada3a1..f7ad52db7d8 100644
--- a/arch/arm/mach-k3/am62x/Kconfig
+++ b/arch/arm/mach-k3/am62x/Kconfig
@@ -14,6 +14,8 @@ config TARGET_AM625_A53_EVM
 	select ARM64
 	select BINMAN
 	select OF_SYSTEM_SETUP
+	imply TI_COMMON_CMD_OPTIONS
+	imply TI_I2C_BOARD_DETECT
 
 config TARGET_AM625_R5_EVM
 	bool "TI K3 based AM625 EVM running on R5"
@@ -25,6 +27,7 @@ config TARGET_AM625_R5_EVM
 	select K3_DDRSS
 	select BINMAN
 	imply SYS_K3_SPL_ATF
+	imply TI_I2C_BOARD_DETECT
 
 config TARGET_PHYCORE_AM62X_A53
 	bool "PHYTEC phyCORE-AM62x running on A53"
diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index d7b07a0d34d..fbd45608efa 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -22,8 +22,18 @@
 #include <dm/uclass.h>
 #include <asm/arch/k3-ddr.h>
 
+#include "../common/board_detect.h"
 #include "../common/fdt_ops.h"
 
+#include "../common/k3-ddr.h"
+
+#define board_is_am62x_skevm()  (board_ti_k3_is("AM62-SKEVM") || \
+				 board_ti_k3_is("AM62B-SKEVM"))
+#define board_is_am62b_p1_skevm() board_ti_k3_is("AM62B-SKEVM-P1")
+#define board_is_am62x_lp_skevm()  board_ti_k3_is("AM62-LP-SKEVM")
+#define board_is_am62x_sip_skevm()  board_ti_k3_is("AM62SIP-SKEVM")
+#define board_is_am62x_play()	board_ti_k3_is("BEAGLEPLAY-A0-")
+
 DECLARE_GLOBAL_DATA_PTR;
 
 #if CONFIG_IS_ENABLED(SPLASH_SCREEN)
@@ -74,9 +84,92 @@ struct efi_capsule_update_info update_info = {
 	.images = fw_images,
 };
 
-#ifdef CONFIG_BOARD_LATE_INIT
+#if CONFIG_IS_ENABLED(TI_I2C_BOARD_DETECT)
+int do_board_detect(void)
+{
+	int ret;
+
+	ret = ti_i2c_eeprom_am6_get_base(CONFIG_EEPROM_BUS_ADDRESS,
+					 CONFIG_EEPROM_CHIP_ADDRESS);
+	if (ret) {
+		printf("EEPROM not available at 0x%02x, trying to read at 0x%02x\n",
+		       CONFIG_EEPROM_CHIP_ADDRESS, CONFIG_EEPROM_CHIP_ADDRESS + 1);
+		ret = ti_i2c_eeprom_am6_get_base(CONFIG_EEPROM_BUS_ADDRESS,
+						 CONFIG_EEPROM_CHIP_ADDRESS + 1);
+		if (ret)
+			pr_err("Reading on-board EEPROM at 0x%02x failed %d\n",
+			       CONFIG_EEPROM_CHIP_ADDRESS + 1, ret);
+	}
+
+	return ret;
+}
+
+int checkboard(void)
+{
+	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
+
+	if (!do_board_detect())
+		printf("Board: %s rev %s\n", ep->name, ep->version);
+
+	return 0;
+}
+
+#if CONFIG_IS_ENABLED(BOARD_LATE_INIT)
+static void setup_board_eeprom_env(void)
+{
+	char *name = "am62x_skevm";
+
+	if (do_board_detect())
+		goto invalid_eeprom;
+
+	if (board_is_am62x_skevm())
+		name = "am62x_skevm";
+	else if (board_is_am62b_p1_skevm())
+		name = "am62b_p1_skevm";
+	else if (board_is_am62x_lp_skevm())
+		name = "am62x_lp_skevm";
+	else if (board_is_am62x_sip_skevm())
+		name = "am62x_sip_skevm";
+	else if (board_is_am62x_play())
+		name = "am62x_beagleplay";
+	else
+		printf("Unidentified board claims %s in eeprom header\n",
+		       board_ti_get_name());
+
+invalid_eeprom:
+	set_board_info_env_am6(name);
+}
+
+static void setup_serial(void)
+{
+	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
+	unsigned long board_serial;
+	char *endp;
+	char serial_string[17] = { 0 };
+
+	if (env_get("serial#"))
+		return;
+
+	board_serial = simple_strtoul(ep->serial, &endp, 16);
+	if (*endp != '\0') {
+		pr_err("Error: Can't set serial# to %s\n", ep->serial);
+		return;
+	}
+
+	snprintf(serial_string, sizeof(serial_string), "%016lx", board_serial);
+	env_set("serial#", serial_string);
+}
+#endif
+#endif
+
+#if CONFIG_IS_ENABLED(BOARD_LATE_INIT)
 int board_late_init(void)
 {
+	if (IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)) {
+		setup_board_eeprom_env();
+		setup_serial();
+	}
+
 	ti_set_fdt_env(NULL, NULL);
 	return 0;
 }
diff --git a/configs/am62x_evm_r5_defconfig b/configs/am62x_evm_r5_defconfig
index 18ffc991b25..d42bdf1f074 100644
--- a/configs/am62x_evm_r5_defconfig
+++ b/configs/am62x_evm_r5_defconfig
@@ -85,6 +85,7 @@ CONFIG_SPL_CLK_K3_PLL=y
 CONFIG_SPL_CLK_K3=y
 CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_DA8XX_GPIO=y
+CONFIG_DM_I2C=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_SPL_MISC=y

---
base-commit: 2ba64e303b2706e5c42a6bf982326d632342ca66
change-id: 20251016-am62xeeprom-41a1920b8bd2

Best regards,
-- 
Guillaume La Roque (TI.com) <glaroque@baylibre.com>

