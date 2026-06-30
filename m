Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65D3C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 01:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B665684AE6;
	Tue, 30 Jun 2026 03:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="jvki5uAr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B01C784A6D; Tue, 30 Jun 2026 03:20:16 +0200 (CEST)
Received: from mail-dl1-x122a.google.com (mail-dl1-x122a.google.com
 [IPv6:2607:f8b0:4864:20::122a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F1EC84AE3
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 03:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-dl1-x122a.google.com with SMTP id
 a92af1059eb24-1390f75d8bbso8174755c88.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 18:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782782411; x=1783387211;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KZ1Ex6dNY6FoL1r07K3TLouQLU6iwQShxUL9P9ZOv2E=;
 b=jvki5uArOhetVivNFNwUKCkPQmEuKGBTPqAiSvdL55zHmcKInFxjCnXo8i3vZWxa6o
 ivV+X2/cWuDnaTVz5frpp9c/J57Sa3AOC8OXOzKYqxSb5KD8rbAihNSjnWsQ/LqYzjZg
 DEHGN2fe55fxtbWneY+nHAsoqi09weHxfeK5TDWsDqYh8Q3CtlIYJOtUDMcZ6+J+wQmX
 mtnV2H4rqwcTj1y6TMjAWjhoF8sx0HaXOgb//vttKsfYur4pu7qxau5OYvW8V7ToFqEQ
 hsJZQk366vb9hE87/r0DepwhWKXP4N/5TF5ZZMqG/+9PFmeqhgy1yXtN01wxOBmo9PDX
 JGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782782411; x=1783387211;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KZ1Ex6dNY6FoL1r07K3TLouQLU6iwQShxUL9P9ZOv2E=;
 b=VGE7WWKj2yqgTNE1zeG1YZ7ObZY0q403R/J4opoDBdCKyWXr6FtOlISiQCriCAh0Bj
 KtNtlmPipJ2d/o5z6Rh2MJE9sENYIn6tCrMiVI68KlrTcKyYeic+ryHvfD2O3wNzh4Bv
 aqQbo3sAnn7mZjeYcfIA+VB5I3/ZMFA3eIvrMGBLmF9Fjb8Z1GLciXBStD+L8f6gpJk7
 YjNfe2pN/mCTqRHvoVdUDVZFpIUs/JtDrwmUnOwWc0MwUs1twST/4r/s5JuvpKtJTDbh
 f0vHV26KTD1SdK4YQzU3trbWSkUZUaS8XdX8ul+yB+/FrLp0+q9rPhLnBigLCmYAXZav
 MpzQ==
X-Gm-Message-State: AOJu0Yza3VOslzoUPhKZR/eHS1H8Zi/25grA2lsO6NYbb+fslMsrh8Vw
 4zFUKScwvbp1G57XUza7Vv3ijFFrzQZfWP1A+O1ePpCTaKIZ6Avp82RUramXaprFcn4=
X-Gm-Gg: AfdE7clFYlHxFiLyKYuoB2yJ88QUU4srCiSdW3lai+gvn5c5vcIBJs5e2CaN3vQiHIY
 /TCivxO7RFq9DkPbLzwwHIy0qJIhAzLCEynvr7Yg81SM8rryiToKl5vu6uMO/MI0iINH7jjBYPk
 VHPp9jaWS2n3PXtVu3rJRNBbeKeuo2EwXhxeyjHi/IeWr29sfp4myPjR0reZd1Cwp9fijb8Bcq/
 VdEKtuYHjMsQnFvu67Vxttve1JmMBgmbuQ02OCpTrP+GRs6P42ZCih1Df2hH6m85ZRolTMTHrse
 yNT+iZJWjcAglHNMPRyd80ssnXOgZS5aLQ8veHIjSZY+Daj42RDue9ik8SCsUTi5Il956kXYzfK
 2i0rVPvodcxg1CWMhzMKWFU77cf4BCFhe4r1LKuwi1R94h3fb6p7vTbQ8eFD0jzOMWTmmPeb8Fd
 N6RnmqtDJAJUzZZT+2aIYaS1byLY0yyJxtH7HcogA10trblC0qVUq4q+Vko4O80u4QRLsS74lyu
 1TgGqbZyHBU9tRFobK3HmuFZP3/ZAW7gIBFT3uQ/XXEO2TzUE1cLVMojXJIsgAp
X-Received: by 2002:a05:7022:6ba9:b0:139:b63c:a0f2 with SMTP id
 a92af1059eb24-13b2a1c31e9mr986516c88.33.1782782411287; 
 Mon, 29 Jun 2026 18:20:11 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2a9b425asm2806974c88.0.2026.06.29.18.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 18:20:10 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 30 Jun 2026 09:19:10 +0800
Subject: [PATCH v5 09/14] spacemit: k1: add TLV EEPROM support in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-m1-v1-9-83f13347b3ba@riscstar.com>
References: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
In-Reply-To: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
To: u-boot@lists.denx.de, u-boot-spacemit@groups.io, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Henrik Grimler <henrik@grimler.se>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Guodong Xu <guodong@riscstar.com>, 
 Songsong Zhang <sszhang@vsit.ai>
X-Mailer: b4 0.15.2
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
Signed-off-by: Guodong Xu <guodong@riscstar.com>
Tested-by: Songsong Zhang <sszhang@vsit.ai>
---
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  9 +++
 board/spacemit/k1/spl.c                   | 93 ++++++++++++++++++++++++++++++-
 board/spacemit/k1/tlv_codes.h             | 22 ++++++++
 configs/spacemit_k1_defconfig             |  8 +++
 4 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index e140c07b834..231e98d206a 100644
--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -47,3 +47,12 @@
 &syscon_apbc {
 	bootph-pre-ram;
 };
+
+&i2c2 {
+	bootph-pre-ram;
+	resets = <&syscon_apbc RESET_TWSI2>;
+
+	eeprom@50 {
+		bootph-pre-ram;
+	};
+};
diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 78f26616347..e862548f980 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -3,10 +3,77 @@
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
@@ -44,6 +111,7 @@ void serial_early_init(void)
 
 void board_init_f(ulong dummy)
 {
+	u8 i2c_buf[I2C_BUF_SIZE] = { 0 };
 	int ret;
 
 	ret = spl_early_init();
@@ -54,10 +122,33 @@ void board_init_f(ulong dummy)
 
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
index 23019266103..ce0314686ab 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -31,8 +31,11 @@ CONFIG_SYS_PBSIZE=276
 CONFIG_SPL_MAX_SIZE=0x33000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_HUSH_PARSER=y
+CONFIG_CMD_TLV_EEPROM=y
+CONFIG_SPL_CMD_TLV_EEPROM=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SPL_REGMAP=y
@@ -41,6 +44,11 @@ CONFIG_SPL_CLK=y
 CONFIG_SPL_CLK_CCF=y
 CONFIG_CLK_SPACEMIT=y
 CONFIG_CLK_SPACEMIT_K1=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_SPACEMIT_K1=y
+CONFIG_MISC=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SPL_I2C_EEPROM=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_DEBUG_UART_NS16550=y

-- 
2.51.0

