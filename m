Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305B4EA8126
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 15:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41E9683E13;
	Tue, 10 Feb 2026 16:15:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zq9qGSJb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91D8A83E62; Tue, 10 Feb 2026 16:15:49 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49A8D83E36
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 16:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-8c59bce68a1so67401385a.0
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 07:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770736546; x=1771341346; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWlGKgWE8Px0wNLimjwI+UmnS1GaRZpB1woQmoMQsxw=;
 b=Zq9qGSJb+AKFnMtef5Rwf8H5xoUSgHHCfDRxe6i14jGcrEFAAAMDnswOttFlXn09NF
 9stNgX8ckF7rDM7blr5pQORqraRhnmV5DwW0eXL/kIdEnWdrayr+SCeumFFTT3cI8QXm
 zOhe9xE/uOKBtambWUrSvpf1ijKoIhUy75ix6DMlECwt7ylOAPUPvqMNXG7TweWX3H1b
 E9W5b+yKA3LOFMOsw5zSAdtKZoKhxeWyTloFsRPRVI2t+GYe5kxLgJoY12/zWCUButth
 xSaU6p3VPbiys44cDK1+Ol5z+KsmUDN+c11IXfGCvFLaFtplCKKsbLg77gmyC2V3+AIf
 J+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770736546; x=1771341346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nWlGKgWE8Px0wNLimjwI+UmnS1GaRZpB1woQmoMQsxw=;
 b=OIe9wZOx8vrC2+8IYKjBwKqjYk3tOfl5m/USpE2J4s03ZxMZBqkL9Q7dtjQc8VxqvJ
 UKBhAf2kvuG4f1YpHoOaOp3Bo3cV/koS7T/edFTeSGxyC0C+GaY3rFUUa4c8lw8b9X2T
 Eh7SJa+amBk+nJsb+2U49JMhxAbdDjXEieaIwyxxmMd6mPShelhuvZ3ZtmcN+7wY1SKS
 WfZfv5t2CGAegeI24kXN6orZU/k5/FXHr2XnV1E3Kmnl6QQJ2Qj1qqy2BxgE8SesTI5v
 +/cDa+peuDGp0PkzZQHtvnvxUpeVH3+FYI2T5HepSWs3ZD7DN50gCUIcBuflFOSAbj/r
 Zf8g==
X-Gm-Message-State: AOJu0YyXw0861e2VLGgrrU7QK6zOFT36fYZqWO+J5KZzCL+3qEX8owNQ
 nbAkrNQIwbYRrWb1imkGv+J3ov9TbLgzzw0XG9lAW79Ui7aFLxMLXYXPMS32vw==
X-Gm-Gg: AZuq6aLThjjIA4SgnTJn9EyGRKNRZWWvbq1OFK+yl7+677Z5VjSpK0XdbCcjT0+/rkl
 Jg56uvi9hcdNS1qpGsTbl3f41w9AU0kMAZgsLmQzJEpx6OQY5Zs59D5Pv8kyn5c3J7ktCrTQJWF
 TgCp+Vw6FnCT4ZC4h67nhKcNmD6d1B72Y4Ow0A7r3D30m7XgpVhnh946YM7e2je1O+Oxl+Yqzjo
 OHHy61qgcu15SA/EfZcS2ot7oZ5jYJLUMv2Yw3+CNeR4pabAlb99uCNWxkdTFitJaR9Rd2ay+gc
 ktAW2Ygng1E00gFpWvdaduLUMsAPja9eVgabTar2x9tE0eO7vnj0wkOmOLUfWo1bKNrJIiE0HyJ
 KG72DLBkTHowZlPkasri3LM+t1l+SAxG1L3Z5z1sKuHkoc54OibN3DdZo3ZrE+DHXqD1al8SMzY
 SgjAlkTvM+ePWa6PZPMhwXeGl6N2VcLclKtIUF5veQJcbPsL6i5UdUub/rsGzNwc3ZmgC5x1SIL
 LyBRP7ZpbM=
X-Received: by 2002:a05:620a:7081:b0:8c3:7e51:94c6 with SMTP id
 af79cd13be357-8caf0f2c066mr1867346485a.60.1770736545720; 
 Tue, 10 Feb 2026 07:15:45 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953c057751sm101019286d6.43.2026.02.10.07.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 07:15:43 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong.xu@riscstar.com>
Subject: [PATCH v2 12/16] spacemit: k1: add TLV EEPROM support in SPL
Date: Tue, 10 Feb 2026 10:14:55 -0500
Message-Id: <20260210151459.2348758-13-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260210151459.2348758-1-raymondmaoca@gmail.com>
References: <20260210151459.2348758-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

And support for required components including clock, I2C controller,
and I2C EEPROM.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong.xu@riscstar.com>
---
 arch/riscv/dts/k1-spl.dts     |  28 +++++++++
 arch/riscv/dts/k1.dtsi        | 104 ++++++++++++++++++++++++++++++++++
 board/spacemit/k1/spl.c       | 104 +++++++++++++++++++++++++++++++++-
 board/spacemit/k1/tlv_codes.h |  22 +++++++
 configs/spacemit_k1_defconfig |  13 +++++
 5 files changed, 270 insertions(+), 1 deletion(-)
 create mode 100644 board/spacemit/k1/tlv_codes.h

diff --git a/arch/riscv/dts/k1-spl.dts b/arch/riscv/dts/k1-spl.dts
index a74eaaf6a8f..74e9957b83a 100644
--- a/arch/riscv/dts/k1-spl.dts
+++ b/arch/riscv/dts/k1-spl.dts
@@ -5,6 +5,7 @@
  */
 
 /dts-v1/;
+
 #include "k1.dtsi"
 #include "binman.dtsi"
 
@@ -64,6 +65,33 @@
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
index 20f1cb57462..682d2fb88e2 100644
--- a/arch/riscv/dts/k1.dtsi
+++ b/arch/riscv/dts/k1.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
+ * Copyright (C) 2025-2026 RISCstar Ltd.
  */
 
 #include <dt-bindings/clock/spacemit,k1-syscon.h>
@@ -576,6 +577,21 @@
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
@@ -608,6 +624,94 @@
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
index 78f26616347..182e833849d 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -3,10 +3,87 @@
  * Copyright (c) 2025-2026, RISCstar Ltd.
  */
 
+#include <asm/io.h>
+#include <clk.h>
+#include <clk-uclass.h>
+#include <configs/k1.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
+#include <i2c.h>
+#include <linux/delay.h>
 #include <log.h>
 #include <spl.h>
+#include <tlv_eeprom.h>
+
+#define MUX_MODE4		4
+#define EDGE_NONE		BIT(6)
+#define PULL_UP			(6 << 13)       /* bit[15:13] 110 */
+#define PAD_DS_MEDIUM		BIT(12)
+#define PAD_1V8_DS2		PAD_DS_MEDIUM
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
@@ -44,6 +121,7 @@ void serial_early_init(void)
 
 void board_init_f(ulong dummy)
 {
+	u8 i2c_buf[I2C_BUF_SIZE];
 	int ret;
 
 	ret = spl_early_init();
@@ -52,12 +130,36 @@ void board_init_f(ulong dummy)
 
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
index 00000000000..e40fbdcee6d
--- /dev/null
+++ b/board/spacemit/k1/tlv_codes.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025-2026 RISCstar Ltd.
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
diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index e64687e95ce..65e8143a0bd 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -34,6 +34,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_RESET_SPACEMIT_K1=y
+CONFIG_SPL_RESET_SPACEMIT_K1=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_DEBUG_UART=y
@@ -52,3 +53,15 @@ CONFIG_CLK=y
 CONFIG_CLK_SPACEMIT=y
 CONFIG_SPL_CLK=y
 CONFIG_SYS_MALLOC_F_LEN=0x5000
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

