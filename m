Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B95CCD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 22:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C3EF846F1;
	Tue, 19 May 2026 00:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="aXzU70Uo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2BD3846A4; Tue, 19 May 2026 00:31:31 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA958465A
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 00:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2bd80b3aa13so17824675ad.0
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 15:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779143488; x=1779748288;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AtDZ/XjFmwOnyOj329YnfMR6lx0qE4ofAPI3Ye9ZJvY=;
 b=aXzU70UozgvufwSjjS/zIBoN5KFwp1xHx2Qon5zg766Rw9NbtniZHG+NAT1wF3k/+N
 WzsUy+eBAAr/EFJ9slfZMjuWY1BSX7wIKuLuP2EBkskwPcXjxLg3i7p44C6yucm63ePD
 RErv++dyA35U7czfQdXrDXB3ey683nZ+h4Pj3TYcZcU/JQsovyBnJneoVx0Y3tS+NvjQ
 STuLOusDXCOuMUD087zg8JJIe5EMhGgeyWKK/FjRHEnnGyaKh0c8hAJxniTGQCActpRM
 969nRRv+3+OdM2+gbi0Vj1K1/rm1wLNv7o0Pt7mBGdnLfui5gDaqEMFe8GN/jcHjVVWu
 ig5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779143488; x=1779748288;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AtDZ/XjFmwOnyOj329YnfMR6lx0qE4ofAPI3Ye9ZJvY=;
 b=pbpmbLumYaHpPOUQongwKGLwnvAQK/p/Z2n2u9vTPdBQtTMHhVNxdRe453HGLsqvbv
 Aew5GcO03LY9YY4Rv9xLwBvANUo02ZhW9lv1IlUAVA0IoLLCw7iVf745EDoMja0CjHB3
 PIl3fziDnigrrnBs659UZVOGseVvkv5i7WqhWK6dDnAvTTYDCEQKZf4M7qrYPNh8tgP2
 TbYGbZQweR1qmgmgTh/0bMsfng9oyjYcejvaUPmKPCiXUACCgRBybF2O1Gjahn72lJ5q
 zHOexu/unotD/jFNYjKU7wbQtPhrsBtlcl+AtXQ2dPE+75SNjHHiWpJOLxMgFv23SvZA
 K41g==
X-Gm-Message-State: AOJu0Yy5ARjnb/O5SiKY0/6cWygtXd/aKj9uHkfWgYnLe9jEXavRo7mz
 w+peFI/KHKkje7uggp/XAFrQj+envrNrleXm0gmb36hbyy/OvIoIUjrDUBISUxp6iv0=
X-Gm-Gg: Acq92OENs73UxtXLeLHx8mzvVMQRgV72I8WOe3ldsISPUwNkVOVSyVbsXAqvoHvsLGc
 028puazy7WVR2bEm5IAbHsy2kDEUIHgWsoT7X3cDezCUwiwlBGimzL+EWfiXmUZu1AWWtrCNiIL
 BSAQ0N3AjeBjtYTGiHH9QVaYHTBWCwaWEBxUUfn5yOMLU2/K/QOXczjz8jVvsKDbCJkvz5AsmMy
 iodNJ2K6BbEJNibORmWqCguzdzwcQrphuE7Sxe0zXbQFPlL0AW1fy5dxYmfIYijx+45ZfjoOS7F
 roxBuZeYIglp7M52ifnUcos47x+fpVYMytTppSUgvDnecuVgxpae6HApmB3DUTzXmfTxjJrWKm5
 ufnExgQ7WS76a63RP8P8rs2ELWUeqlgKKHqtAZ2g4Qmbn0jK44h5meZYNg2bMrVwa7WTEcrJY3s
 Ixn3NxcgO27FKzC80QHg/NVc91KVpTyP926vNt+paZYCCYfORKIdchRQ==
X-Received: by 2002:a17:902:cecf:b0:2bd:6327:b4f5 with SMTP id
 d9443c01a7336-2bd7e93580dmr184602805ad.40.1779143487976; 
 Mon, 18 May 2026 15:31:27 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4072])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5ef27sm206379265ad.8.2026.05.18.15.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 15:31:27 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 19 May 2026 06:26:27 -0400
Subject: [PATCH v4 09/14] spacemit: k1: add TLV EEPROM support in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-b4-k1-spl-bring-up-v4-9-3915a2a904c1@riscstar.com>
References: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
In-Reply-To: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
To: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Henrik Grimler <henrik@grimler.se>, 
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Justin Klaassen <justin@tidylabs.net>, Guodong Xu <guodong.xu@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Guodong Xu <guodong@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Tue, 19 May 2026 00:38:07 +0200
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

---
v4:
- DT: drop forked i2c/eeprom nodes; only bootph markers in overlay.
- Drop reset_early_init().
- spl_boot_device() -> BOOT_DEVICE_NOR; stub pmic_init/spl_board_init.
- Enable SPL_I2C/SPL_I2C_EEPROM/SPL_CMD_TLV_EEPROM.
---
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  9 +++
 board/spacemit/k1/spl.c                   | 93 ++++++++++++++++++++++++++++++-
 board/spacemit/k1/tlv_codes.h             | 22 ++++++++
 configs/spacemit_k1_defconfig             |  8 +++
 4 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index fbee8763a21..ac56bf512ad 100644
--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -64,3 +64,12 @@
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
2.43.0

