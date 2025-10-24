Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26A5CCF9EA
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 14:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73A26836D1;
	Fri, 24 Oct 2025 16:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I2YX5ATW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6987836EE; Fri, 24 Oct 2025 16:17:18 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D10383693
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 16:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b85so2120336f8f.3
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 07:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761315436; x=1761920236;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UQQgoQ1vwvHkr2SXRBLgGka8INVYYwTs+pZG+H0rC+I=;
 b=I2YX5ATWpI0s3OH/i/uNfUt2Phi171W5ANt/FEp2U5sWgPCavj4dpvfbrKz8m+4LET
 zMXgqYdwmI5jaDoLa5oveQNB84tnMc5zYuO3++JfVEXkfqzEYuT5JjvwFm1uzd+nGRin
 mVM11RWUzXcLzvvLB05UG/p+QBF/BRbIBoEiGzV/RwlpXgot2TM2xdCpYTLWSa+wLLbo
 7zPkCo+pyLLP0pRmdQgE5Gs+SDxAv9Tz1IXido4GpnoW15ysyxaWciRh4x3l6FJQgFDu
 5L9YoDpsQEYHIDOGFguZ18gJaWPM/jJ5WWJoUMUHYixy90/4LZzOvLYo7nm2lNbFcyiB
 qxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761315436; x=1761920236;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UQQgoQ1vwvHkr2SXRBLgGka8INVYYwTs+pZG+H0rC+I=;
 b=YVBZMx3fVZ/luAd4a+TfeFt2k5XKtJEASsxu0DZ3l0lksKbNY15uuRwQQWC6RegoiU
 WgFXEgwc6SQdoAL9v/7q1i9EGo1rhdhechZkTI8oUpuUQuK6JohN2id6dhO2puZs8zgH
 76T/+xQuxdC/TXDV7Wf1et9mOwDhuQYAXeGi4JmORoyZhcpqwN9UeCxNb4h9VCp2pzQf
 PrssXCWg9jjMNKD0o90qaPpEWxLFENTG5BYyEu+0H+z+5Z0iea37VO8qNU/Sum0j9Vyv
 0+dZkmIAwBmtUDOPOeAv7MsqOg7ju3VKPbLYqv9lYJoZUjK2fIHrSdLTKdVSL66yqeiA
 RPIA==
X-Gm-Message-State: AOJu0Yw2F54CERibdAH8lCX7Cjuxx0DDPjQ5uZGqZHOG0t7q85V67Q48
 yVmdPmOfdIWSZNN7HpyMI2LrZFsF84aUJhBVA7ahLyh4wwcP1l2i+mE2En1lHyAI4fA=
X-Gm-Gg: ASbGncvWAeIYdBQFSsOdDM4VtmWKMl5BDyNhswDp6sV9hU48IOd4SOV6VDZvl+VzLTi
 U/7bKA0V1C7ObIkVPATt5cqx2z+yPsMBZxc/q1NtCA2pSm06MCfb0MT91+OpHU4k4T/QmPLObnT
 PXlgAAIGPdr9pAfNJjd1Z/7s//XVQVBCZfcgnyLr3rc+bTt7TJh4N0JY/tc9awjDCOain1g3/sL
 DFQtkXFkDV4/4FcJCeTk7Sni6j3ylYs4omfflV3nqwBPGTKf40ZL8d73vXrgJQGDqYCCoP9G1qq
 hUmzLKn9JpCQuBr2jufc0ZoyveaUYdZV5Qq3guEHh4JZ9p9WEKNxNHoPcFqbFqo2aOfjsQ8Ep7n
 K8HVHIUStG8ckMtfhS7N7F8I4JlWZ59mRr8aFx1t2L9niZALrUvw+ZVtBBoZHrCVbvlfIXIl+H4
 lCUnTOrIBEXgNrVw==
X-Google-Smtp-Source: AGHT+IFvVGRI0eSm8e+gHTfLcbPXIwA1LcUywekLlQA+eo5CjmVRzXL5Nd42RMdQMl8v9T47/4d2uA==
X-Received: by 2002:a05:6000:2911:b0:3e7:46bf:f89d with SMTP id
 ffacd0b85a97d-42704db22camr23476333f8f.44.1761315435804; 
 Fri, 24 Oct 2025 07:17:15 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:a5c0:bdf6:3b95:6cfd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898ccc60sm9656065f8f.34.2025.10.24.07.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 07:17:15 -0700 (PDT)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Fri, 24 Oct 2025 16:17:13 +0200
Subject: [PATCH v2 2/4] board: am62x: Add support for reading eeprom data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-am62xeeprom-v2-2-0e372347e7d4@baylibre.com>
References: <20251024-am62xeeprom-v2-0-0e372347e7d4@baylibre.com>
In-Reply-To: <20251024-am62xeeprom-v2-0-0e372347e7d4@baylibre.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, 
 Bryan Brattlof <bb@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Garrett Giordano <ggiordano@phytec.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Neha Malcom Francis <n-francis@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Santhosh Kumar K <s-k6@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Devarsh Thakkar <devarsht@ti.com>, Prasanth Babu Mantena <p-mantena@ti.com>, 
 Judith Mendez <jm@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dhruva Gole <d-gole@ti.com>, Andrew Davis <afd@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Aashvij Shenai <a-shenai@ti.com>, Peng Fan <peng.fan@nxp.com>, 
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
- Printing board info during boot

Use the generic do_board_detect_am6() and setup_serial_am6()
functions to avoid code duplication across AM6x family boards.

Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 arch/arm/mach-k3/am62x/Kconfig |  3 +++
 board/ti/am62x/evm.c           | 54 +++++++++++++++++++++++++++++++++++++++++-
 configs/am62x_evm_r5_defconfig |  1 +
 3 files changed, 57 insertions(+), 1 deletion(-)

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
index c2c7a0216b9..591324ecc15 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -22,8 +22,16 @@
 #include <dm/uclass.h>
 #include <asm/arch/k3-ddr.h>
 
+#include "../common/board_detect.h"
 #include "../common/fdt_ops.h"
 
+#define board_is_am62x_skevm()  (board_ti_k3_is("AM62-SKEVM") || \
+				 board_ti_k3_is("AM62B-SKEVM"))
+#define board_is_am62b_p1_skevm() board_ti_k3_is("AM62B-SKEVM-P1")
+#define board_is_am62x_lp_skevm()  board_ti_k3_is("AM62-LP-SKEVM")
+#define board_is_am62x_sip_skevm()  board_ti_k3_is("AM62SIP-SKEVM")
+#define board_is_am62x_play()	board_ti_k3_is("BEAGLEPLAY-A0-")
+
 DECLARE_GLOBAL_DATA_PTR;
 
 #if CONFIG_IS_ENABLED(SPLASH_SCREEN)
@@ -74,9 +82,53 @@ struct efi_capsule_update_info update_info = {
 	.images = fw_images,
 };
 
-#ifdef CONFIG_BOARD_LATE_INIT
+#if CONFIG_IS_ENABLED(TI_I2C_BOARD_DETECT)
+int checkboard(void)
+{
+	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
+
+	if (!do_board_detect_am6())
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
+	if (do_board_detect_am6())
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
+#endif
+#endif
+
+#if CONFIG_IS_ENABLED(BOARD_LATE_INIT)
 int board_late_init(void)
 {
+	if (IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)) {
+		setup_board_eeprom_env();
+		setup_serial_am6();
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

-- 
2.34.1

