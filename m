Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95782109E527
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 22:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2881C840D8;
	Wed, 25 Mar 2026 23:33:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mjHqPKi9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84C5B840D8; Wed, 25 Mar 2026 23:33:20 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F182840AE
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 23:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-8cfcb045909so55464885a.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774477997; x=1775082797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xBm+RWrDPpzQikmX4IFg40XlqgK9g/UKMlus6N+AVng=;
 b=mjHqPKi9zbm/C9gan0SexfdkNUPlWzkIm7Wwh3PeULyGrUaT/vPZtAJxoMCM738Sa4
 jUX/GDNEOyYi7J79uW6RqRU1TwhXq27f0NRkIQ230PeW2EmK40RHbTkNpjqDPj+V/et4
 xyGlQjZWHEM20G2D2KziqkpSX+SpW6+0siDU9I573DS3DWFJItc75REhLhpv4irAKSaE
 IM+fBMawKZC2/WQCu/UCw8qDnmtB+6E0vpga7SL99/PvXqIpI2nvbSDAOMGDq95/53at
 50RX7Yz2siUSkBoOWrnDk/ProKDUKskzjDEQgI7s3xHXpiWRUEbsDKybOPqxuhFa8Yw0
 URMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774477997; x=1775082797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xBm+RWrDPpzQikmX4IFg40XlqgK9g/UKMlus6N+AVng=;
 b=rid6Xo8QbajyWsuxniLbAIazVnIbfdrSfqezdULFMJTTTV5rVWmEsXlTZE5AXqaYlI
 Pt8XHXHN6icqhnQkVSQPgKzSeaAKhFxbymyUbuoQKjL68Jtwnl/o1vIveYhm0BlG2EnG
 Vmsf5lgF6LpkNSwgCRI9wRw6HpZXaNSTvh4KxxAhYGTptZYu/fdCTY3P68eZaPAl5Kss
 d/Yexa9NharkhEuOtQ3W6WccID6tZYIg9/Xhy1j93VFGRS3qh1xsxsswn/1hn6iPVEE+
 n7tew5MDGcF/c7MsPe8Ngn8m8Bxp1ttUXKJndt6ixgo72B3/BByAu1/zu3y+9+0NZCNM
 xyYg==
X-Gm-Message-State: AOJu0Yw1j2TwmFfP3CdTMkZOcLhCkTxHXAZuTNldnFL3YqVG0+eIttPz
 zP2QbX+5La/HB5W4uzMNs+VxQPnrTjg0Rql0Xxmyhp3HdQVBVoAY+yALpr+Sonbq
X-Gm-Gg: ATEYQzykDfj3T+UMJoIy88KP9nVnHKTrKj6HrOdvtA8VTnXyssSz1Qmww2m0UsZ8rRB
 EcDEKhtIxUjgqGJhfkqomx4GwUkS844nvwa6hg2SCAzyLU0pSW8uikpzQMFUC39OTtXkJoLfwBy
 7gJbsvX8J7XBg0MoxLXb+ulYTliMs6ZUkY1g5PGAyflDnrTjuvA0yDCA+20o05HYD3oHjy3eBtN
 sVzBRRKfcaPHQi9KcZvRs7J3ItxF2SHK/WPKxfYIhqfV08VVUAG2iSchNkrJvu+3YQjJDgz2ciT
 XcLoo5uc1Zvjj7p/2ykL5fx8yjXuKN+YpFeb4sZuCccQNyME6qKLJNjXwCGkyTEQm1f2902v2Wv
 wcMp1pV7UexHiWmpHGGJK3dOtnDNCO5F425ZsGhdx5CYXLknQPlWya/l2VNeZ0GrIUs3D0n05nz
 PzMqrpAckjTfpNOpFCQU20RQfLiiDucWhyOQwKnCNCupQW4GfujM58BLS/xfbgq5wk2ZdMfRXpl
 b/LeauQ46s=
X-Received: by 2002:a05:620a:4610:b0:8cf:d510:3b39 with SMTP id
 af79cd13be357-8d00104025fmr753404785a.40.1774477996604; 
 Wed, 25 Mar 2026 15:33:16 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-124-85.cpe.distributel.net.
 [173.206.124.85]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e39fc17sm101540185a.5.2026.03.25.15.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 15:33:16 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong.xu@riscstar.com>
Subject: [PATCH v3 12/16] spacemit: k1: add TLV EEPROM support in SPL
Date: Wed, 25 Mar 2026 18:32:28 -0400
Message-Id: <20260325223232.1553212-13-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260325223232.1553212-1-raymondmaoca@gmail.com>
References: <20260325223232.1553212-1-raymondmaoca@gmail.com>
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
Changes in v3:
- CONFIG_SPL_DM_RESET has already been enabled in patch 10.

 arch/riscv/dts/k1-spl.dts     |  28 +++++++++
 arch/riscv/dts/k1.dtsi        | 104 ++++++++++++++++++++++++++++++++++
 board/spacemit/k1/spl.c       | 104 +++++++++++++++++++++++++++++++++-
 board/spacemit/k1/tlv_codes.h |  22 +++++++
 configs/spacemit_k1_defconfig |  12 ++++
 5 files changed, 269 insertions(+), 1 deletion(-)
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
index cbbdcec73d1..5a96eded8bf 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -33,6 +33,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_RESET_SPACEMIT_K1=y
+CONFIG_SPL_RESET_SPACEMIT_K1=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_DEBUG_UART=y
@@ -50,8 +51,19 @@ CONFIG_CLK_CCF=y
 CONFIG_CLK_SPACEMIT=y
 CONFIG_CLK_SPACEMIT_K1=y
 CONFIG_SYS_MALLOC_F_LEN=0x5000
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_SPACEMIT_K1=y
+CONFIG_MISC=y
+CONFIG_I2C_EEPROM=y
+CONFIG_CMD_TLV_EEPROM=y
+CONFIG_LOG=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_LIB_RATIONAL=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_CLK=y
 CONFIG_SPL_CLK_CCF=y
+CONFIG_SPL_I2C=y
+CONFIG_SPL_MISC=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_I2C_EEPROM=y
+CONFIG_SPL_CMD_TLV_EEPROM=y
-- 
2.25.1

