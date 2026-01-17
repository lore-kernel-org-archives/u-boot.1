Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF20DD4A5F4
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 13:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 841C383B22;
	Sun, 18 Jan 2026 14:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="emNGjAb4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31BB4833C6; Sat, 17 Jan 2026 20:11:02 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BADC382BF2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 20:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-5029aa94f28so22768511cf.1
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 11:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768677058; x=1769281858; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHGrkKvWNlM9mBewz7rSVXUSxtZb6j/qpDdMPCitkpM=;
 b=emNGjAb41lHLHym5E5vZEB0XewSbEPHPoEa0cOO1eXutZgNhaffj6PvlPAtvx777A4
 x3xbNyIWB9VMQQsvjWDL4/kmMnhxPm8yDqtRSbQJHgjllfiyTDUw8nyiT/imCsNWJiKx
 RWDVB3Luj//jO8eKsjTZ9u/oZtbWMqoglsXIGAGIiKmHh27/iNQw/pCFF7fDFgWgF+7Q
 8q5s4wzQVSCixcMT4GlDTra77gmJ/fUxfq9icScoT7VkI7bs/5O2r1cbIgUUcZOy/nHo
 7L2jX5R3BdI75bDpr0TDH4fQ/NbZFZWIAQQa4DT3PMG319jmB0uqCeu6e6L+wXXwtybH
 No0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768677058; x=1769281858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MHGrkKvWNlM9mBewz7rSVXUSxtZb6j/qpDdMPCitkpM=;
 b=G0w+OClKub/HfBV16hGfiFE4/28OXqwWhkD+2PTzVrvSkbRfv0cAh7F1xinhHk9jtr
 Wv/uqHkChlDkJrw9wF43InMkrF/kzViQ6Q40jD5dpB5cjq9MGTOl1XNfCY4XQHQcIqzb
 iM0O1Bh/KUpEfXmYNIcXSI9d0qLk7EnWGCykIWFYIzk+G91st+VECjvEXvwyLyJ2RIKB
 QXWbPEEEccYQ/fffjNeo0LY/dyKnIsCK+TORzwuWErECJUI0usQnK2EA97klpPUSLkuY
 qCjmpV8DFo2dJbEuZEQpZ1vpRltZvjK0rXw71JFLwE2r1NM/byYHOpoCsyhbs8Dxgy31
 aMCg==
X-Gm-Message-State: AOJu0Yx7EWXT40iwjiN2qoCjuTOtKwiLIjztT1p9sRTUXa75TmA/XF80
 9vaD6eyMkillAIFmkzePZi6aBQtxmAF8JTDaseuZb53bZx8cpt17eu7g2myJcg==
X-Gm-Gg: AY/fxX5FSRMEZJAVjA3UG66ZGqADVgePLIsgESLFViOFR8JHjc+W9/qcXgbJ2wFRr8G
 I87RT6iYKWAaWBO1wEZBjy0onlgILsI9NwxoNeLf95S+Xb3AHb251baY2X7jubwWtm4skFihPGU
 +uJOMWLM/D9J9trMUc22LO0wxiXr/Ccx/rrRF2+Op3niGHjmY+Yvc/BwsSYQsQXZvCA6YdgFqlC
 UkMmMi9nfj42Zy9yXB7GdceGLWIp/zYcVh/f9GEyo9SRvPKwMiZgx9uW4euePHiE02PXVCTO4iK
 tYH79k7Cu1XZ4d04+R9Q9IHbaBRePeGofD3N+wzuYaIOCk5vzEqtdSRzUvmDK2LjGzL1+/cAxj0
 srSdbJSABJVrzIfdyQY2X+5p5quG4T7F76UmhviXBBEpjoRzuySjnQud/FXT9KVKv109nB9jH08
 3GD30+YzqWMBcLMDU93LcqkjE9CKZUPa24u5u9hMv6+PJ3xHxC3ZcY/y+eZtFOP9XbDkel3ckil
 a9Cla3cJw==
X-Received: by 2002:ac8:5a55:0:b0:4f1:8412:46e2 with SMTP id
 d75a77b69052e-5019f8fa871mr167440871cf.29.1768677058193; 
 Sat, 17 Jan 2026 11:10:58 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1ef9347sm44340261cf.25.2026.01.17.11.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 11:10:57 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Conor Dooley <conor.dooley@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Yixun Lan <dlan@gentoo.org>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Aniket Limaye <a-limaye@ti.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Samuel Holland <samuel@sholland.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>
Subject: [PATCH 13/17] spacemit: k1: add TLV EEPROM support in SPL
Date: Sat, 17 Jan 2026 14:01:47 -0500
Message-Id: <20260117190231.977686-14-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260117190231.977686-1-raymondmaoca@gmail.com>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Jan 2026 14:47:30 +0100
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

From: Raymond Mao <raymond.mao@riscstar.com>

And support for required components including clock, I2C controller,
and I2C EEPROM.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 arch/riscv/dts/k1-spl.dts     |  28 +++++++++
 arch/riscv/dts/k1.dtsi        | 105 +++++++++++++++++++++++++++++++++-
 board/spacemit/k1/spl.c       | 101 +++++++++++++++++++++++++++++++-
 board/spacemit/k1/tlv_codes.h |  22 +++++++
 configs/k1_defconfig          |  14 +++++
 5 files changed, 268 insertions(+), 2 deletions(-)
 create mode 100644 board/spacemit/k1/tlv_codes.h

diff --git a/arch/riscv/dts/k1-spl.dts b/arch/riscv/dts/k1-spl.dts
index 1f6db740747..cd7875f3e35 100644
--- a/arch/riscv/dts/k1-spl.dts
+++ b/arch/riscv/dts/k1-spl.dts
@@ -5,6 +5,7 @@
  */
 
 /dts-v1/;
+
 #include "k1.dtsi"
 #include "binman.dtsi"
 
@@ -65,6 +66,33 @@
 		status = "okay";
 		bootph-pre-ram;
 	};
+
+	i2c@d4012000 {		/* i2c2 */
+		status = "okay";
+		bootph-pre-ram;
+		eeprom: eeprom {
+			compatible = "atmel,24c02";
+			reg = <0x50>;
+			status = "okay";
+			bootph-pre-ram;
+		};
+	};
+
+	i2c@d401d800 {		/* i2c8 */
+		status = "okay";
+		bootph-pre-ram;
+		pmic@41 {
+			compatible = "pmic";
+			reg = <0x41>;
+			status = "okay";
+			bootph-pre-ram;
+		};
+	};
+
+	reset-controller@d4050000 {
+		status = "okay";
+		bootph-pre-ram;
+	};
 };
 
 &uart0 {
diff --git a/arch/riscv/dts/k1.dtsi b/arch/riscv/dts/k1.dtsi
index 20f1cb57462..59f901f233a 100644
--- a/arch/riscv/dts/k1.dtsi
+++ b/arch/riscv/dts/k1.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
+ * Copyright (C) 2025-2026 RISCStar Ltd.
  */
 
 #include <dt-bindings/clock/spacemit,k1-syscon.h>
@@ -576,6 +576,21 @@
 			status = "disabled";
 		};
 
+		reset: reset-controller@d4050000 {
+			compatible = "spacemit,k1-reset";
+			reg = <0x0 0xd4050000 0x0 0x209c>,
+			    <0x0 0xd4282800 0x0 0x400>,
+			    <0x0 0xd4015000 0x0 0x1000>,
+			    <0x0 0xd4090000 0x0 0x1000>,
+			    <0x0 0xd4282c00 0x0 0x400>,
+			    <0x0 0xd8440000 0x0 0x98>,
+			    <0x0 0xc0000000 0x0 0x4280>,
+			    <0x0 0xf0610000 0x0 0x20>;
+			reg-names = "mpmu", "apmu", "apbc", "apbs", "ciu", "dciu", "ddrc", "apbc2";
+			#reset-cells = <1>;
+			status = "disabled";
+		};
+
 		syscon_mpmu: system-controller@d4050000 {
 			compatible = "spacemit,k1-syscon-mpmu";
 			reg = <0x0 0xd4050000 0x0 0x209c>;
@@ -608,6 +623,94 @@
 			#reset-cells = <1>;
 		};
 
+		i2c0: i2c@d4010800 {
+			compatible = "spacemit,k1-i2c";
+			reg = <0x0 0xd4010800 0x0 0x38>;
+			clocks = <&syscon_apbc CLK_TWSI0>;
+			resets = <&reset RESET_TWSI0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@d4011000 {
+			compatible = "spacemit,k1-i2c";
+			reg = <0x0 0xd4011000 0x0 0x38>;
+			clocks = <&syscon_apbc CLK_TWSI1>;
+			resets = <&reset RESET_TWSI1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@d4012000 {
+			compatible = "spacemit,k1-i2c";
+			reg = <0x0 0xd4012000 0x0 0x38>;
+			clocks = <&syscon_apbc CLK_TWSI2>;
+			resets = <&reset RESET_TWSI2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@d4014000 {
+			compatible = "spacemit,k1-i2c";
+			reg = <0x0 0xd4014000 0x0 0x38>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@d4012800 {
+			compatible = "spacemit,k1-i2c";
+			reg = <0x0 0xd4012800 0x0 0x38>;
+			clocks = <&syscon_apbc CLK_TWSI4>;
+			resets = <&reset RESET_TWSI4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@d4013800 {
+			compatible = "spacemit,k1-i2c";
+			reg = <0x0 0xd4013800 0x0 0x38>;
+			clocks = <&syscon_apbc CLK_TWSI5>;
+			resets = <&reset RESET_TWSI5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c6: i2c@d4018800 {
+			compatible = "spacemit,k1-i2c";
+			reg = <0x0 0xd4018800 0x0 0x38>;
+			clocks = <&syscon_apbc CLK_TWSI6>;
+			resets = <&reset RESET_TWSI6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c7: i2c@d401d000 {
+			compatible = "spacemit,k1-i2c";
+			reg = <0x0 0xd401d000 0x0 0x38>;
+			clocks = <&syscon_apbc CLK_TWSI7>;
+			resets = <&reset RESET_TWSI7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c8: i2c@d401d800 {
+			compatible = "spacemit,k1-i2c";
+			reg = <0x0 0xd401d800 0x0 0x38>;
+			clocks = <&syscon_apbc CLK_TWSI8>;
+			resets = <&reset RESET_TWSI8>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		plic: interrupt-controller@e0000000 {
 			compatible = "spacemit,k1-plic", "sifive,plic-1.0.0";
 			reg = <0x0 0xe0000000 0x0 0x4000000>;
diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 1c299810d39..6fe064bd430 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -3,9 +3,83 @@
  * Copyright (c) 2025-2026, RISCStar Ltd.
  */
 
+#include <asm/io.h>
+#include <clk.h>
+#include <clk-uclass.h>
+#include <configs/k1.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
+#include <dt-bindings/pinctrl/k1-pinctrl.h>
+#include <i2c.h>
+#include <linux/delay.h>
+#include <log.h>
 #include <spl.h>
+#include <tlv_eeprom.h>
+
+#define I2C_PIN_CONFIG(x)       ((x) | EDGE_NONE | PULL_UP | PAD_1V8_DS2)
+#define I2C_BUF_SIZE		64
+
+#define MFP_GPIO_84		0xd401e154
+#define MFP_GPIO_85		0xd401e158
+
+static void reset_early_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device(UCLASS_RESET, 0, &dev);
+	if (ret)
+		panic("Fail to detect reset controller.\n");
+}
+
+static void i2c_early_init(void)
+{
+	struct udevice *bus;
+
+	// eeprom: I2C2, pin group(GPIO_84, GPIO_85)
+	writel(I2C_PIN_CONFIG(MUX_MODE4), (void __iomem *)MFP_GPIO_84);
+	writel(I2C_PIN_CONFIG(MUX_MODE4), (void __iomem *)MFP_GPIO_85);
+	udelay(100);
+	uclass_first_device(UCLASS_I2C, &bus);
+	while (bus) {
+		uclass_next_device(&bus);
+		if (!bus)
+			break;
+	}
+}
+
+int read_product_name(char *name, int size)
+{
+	u8 eeprom_data[TLV_TOTAL_LEN_MAX], *p;
+	struct tlvinfo_header *tlv_hdr;
+	struct tlvinfo_tlv *tlv_entry;
+	int ret, i = 0;
+	u32 entry_size;
+
+	if (!name || size <= 0)
+		return -EINVAL;
+	ret = read_tlvinfo_tlv_eeprom(eeprom_data, &tlv_hdr,
+				      &tlv_entry, i);
+	if (ret)
+		return ret;
+	p = (u8 *)tlv_entry;
+	for (i = 0; i < tlv_hdr->totallen; ) {
+		if (tlv_entry->type == TLV_CODE_PRODUCT_NAME) {
+			if (tlv_entry->length < size)
+				size = tlv_entry->length;
+			memset(name, 0, size);
+			memcpy(name, &tlv_entry->value[0], size);
+			return 0;
+		}
+		if (tlv_entry->type == TLV_CODE_CRC_32)
+			return -ENOENT;
+		entry_size = tlv_entry->length + sizeof(struct tlvinfo_tlv);
+		i += entry_size;
+		p += entry_size;
+		tlv_entry = (struct tlvinfo_tlv *)p;
+	}
+	return -ENOENT;
+}
 
 static void clk_early_init(void)
 {
@@ -43,6 +117,7 @@ void serial_early_init(void)
 
 void board_init_f(ulong dummy)
 {
+	u8 i2c_buf[I2C_BUF_SIZE];
 	int ret;
 
 	ret = spl_early_init();
@@ -51,12 +126,36 @@ void board_init_f(ulong dummy)
 
 	riscv_cpu_setup();
 
+	reset_early_init();
 	clk_early_init();
 	serial_early_init();
+
 	preloader_console_init();
+
+	i2c_early_init();
+	ret = read_product_name(i2c_buf, I2C_BUF_SIZE);
+	if (ret)
+		log_info("Fail to detect board:%d\n", ret);
+	else
+		log_info("Get board name:%s\n", (char *)i2c_buf);
 }
 
 u32 spl_boot_device(void)
 {
-	return BOOT_DEVICE_NONE;
+	return BOOT_DEVICE_NOR;
+}
+
+void pmic_init(void)
+{
+	struct udevice *pmic_dev = NULL;
+	int ret;
+
+	ret = uclass_get_device(UCLASS_PMIC, 0, &pmic_dev);
+	if (ret)
+		panic("Fail to detect PMIC:%d\n", ret);
+}
+
+void spl_board_init(void)
+{
+	pmic_init();
 }
diff --git a/board/spacemit/k1/tlv_codes.h b/board/spacemit/k1/tlv_codes.h
new file mode 100644
index 00000000000..7d1808e1acf
--- /dev/null
+++ b/board/spacemit/k1/tlv_codes.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025-2026 RISCStar Ltd.
+ */
+
+#ifndef __TLV_CODES_H
+#define __TLV_CODES_H
+
+#define TLV_CODE_SDK_VERSION		0x40
+#define TLV_CODE_DDR_CSNUM		0x41
+#define TLV_CODE_DDR_TYPE		0x42
+#define TLV_CODE_DDR_DATARATE		0x43
+#define TLV_CODE_DDR_TX_ODT		0x44
+
+#define TLV_CODE_WIFI_MAC_ADDR		0x60
+#define TLV_CODE_BLUETOOTH_ADDR		0x61
+
+#define TLV_CODE_PMIC_TYPE		0x80
+#define TLV_CODE_EEPROM_I2C_INDEX	0x81
+#define TLV_CODE_EEPROM_PIN_GROUP	0x82
+
+#endif /* __TLV_CODES_H */
diff --git a/configs/k1_defconfig b/configs/k1_defconfig
index 9c4612bcd84..0d5c3932797 100644
--- a/configs/k1_defconfig
+++ b/configs/k1_defconfig
@@ -34,6 +34,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_RESET_SPACEMIT_K1=y
+CONFIG_SPL_RESET_SPACEMIT_K1=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_DEBUG_UART=y
@@ -52,3 +53,16 @@ CONFIG_CLK=y
 CONFIG_CLK_SPACEMIT=y
 CONFIG_SPL_CLK=y
 CONFIG_SYS_MALLOC_F_LEN=0x5000
+CONFIG_SPL_LOG_LEVEL=7
+CONFIG_SPL_DM_RESET=y
+CONFIG_DM_I2C=y
+CONFIG_SPL_I2C=y
+CONFIG_SYS_I2C_SPACEMIT_K1=y
+CONFIG_MISC=y
+CONFIG_SPL_MISC=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SPL_I2C_EEPROM=y
+CONFIG_CMD_TLV_EEPROM=y
+CONFIG_SPL_CMD_TLV_EEPROM=y
+CONFIG_LOG=y
-- 
2.25.1

