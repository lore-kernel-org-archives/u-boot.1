Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63078FF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 21:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D399848FB;
	Wed, 29 Apr 2026 23:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ZK9OoZBN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45B8884862; Wed, 29 Apr 2026 15:59:23 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9DCB84855
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 15:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43cfde3c3f3so12654528f8f.3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 06:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777471159; x=1778075959;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DC5dSp7y6c4PSah+jAZq1qwkFxPvWhgE6WBDv7qd/0s=;
 b=ZK9OoZBNCOPBAIIs4oNUAqN134qgLxtEe8BNbCODWvafIwitAuYbHItI0OwtOI5AIH
 WeoMjGGlLGEw9/mS0Yv1Vumx0KyL8Af6lmrRen77r+jRJBAMWDtbOzUvoPhmusm3+TGh
 +QZouVLw7AY8AzDQmApp56z1LhgP+ZSknbU9rh5e7NWL4FfzN7J3kerW0Ci8pEqADYPH
 0IQqOr4XLIOJ5seBHRER6/KzpK96X/Kd7KTDR3NcV3wJiF3E1KfBN4FJHtMUD3PzQsYU
 Bh6zF5CozDwVcd0w38T0p3yzs4DwwhZ1Ffz3Rus1Y+ST7FKeL1ffaMw7Lw0eFXPW2Yov
 2Rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471159; x=1778075959;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DC5dSp7y6c4PSah+jAZq1qwkFxPvWhgE6WBDv7qd/0s=;
 b=F7O/xwE9Qa2antLlW5tSVxpKOXlL3tqoKZkGXincU4zA5+mr+uWItDycuR/LJiWtHZ
 x8vAdfV+naA6DVYuq6LCvrQi/k+YLyybGPD8unX+wj+aQn+XdmIM6LTo2ThIu32roT/u
 6y9LB8ahTYtX0Wp8LmI7eR7PmgaLLZgUKKc7ML0Y+A9fc/nw117ArrqmuC6jZIYlheGr
 4fuAFZ6k9g3Nw6osfHEEhQNlam+ElOcG+ibWV4Bjb2Eai2/WuLONLBgL5paPBoqdShh9
 1PhQFh0/pfcyRghGQWcf0F1VYSsae5BHav6f6Zjfzk505gw9r+lamxpldGorAcqPfyvW
 cpGg==
X-Gm-Message-State: AOJu0Yx0XJFGIlfzNvbWmhSMi952JaxpEB/1jk2/6pGwLreY2LyN/Vrh
 qCv7/6PY9HFYz9jo5dAFjBuH4faitE+UQOr/5+izpUnXggki/lhT+JWFHqLbC+fdSiY=
X-Gm-Gg: AeBDiesPsRofL8u05m3QTOnjkssEQeM4+DrtkGDK0LRz3QA9b2qWL7svcaqBAWKieAI
 YV/cIgGpGLH2GueAGQMDoJgz6/ScVudAR9UK2xJ3phBkD/yJVkezqjJNPvNxJstOivxugaq0Ye5
 /9fXBBr/ZZcwvKxw34OleJ6pTIbOJiapLoiKu2v1W0yhFZ7uNCTo1eXLMWT3MnlD+LQL/WNTRr7
 pcNLMG+3hKAgQyiuHKSmD/nYMsbpR6ExuZw8IBKmlLw6B2Z7Vc8aSjPTQZaB47QKweRhoIMeR46
 gXArN7Us9uqZkIz+6yNYOHMP7FhsbHBOfDqOvrahBdZYPJEW0PlgkwKknHxNRd0GQExiet+P7Vj
 ZfbPCVrF68+hWEMrUmCENxVLFwuRNIflYdnYnmOVVN8Vf3PlhB9ZZBbvZ2TyqhQcRZMHGhWEn7/
 obJsMHeC+abqBxYM4VFHzuMxL1WZEAKZAXxFvKSrLBtXj7AJavYE//AhRcpvPe030xFOHqaoqA9
 mozNyHelSrHBiqkWs/SUREPkrv0RWG+tJmKiZwypKb0TueEFdQdJYvGbTtiknk2g07itVKt1ymi
 ovtFc+Qr5klfcAUY94o=
X-Received: by 2002:a05:6000:24c3:b0:43d:76d8:5794 with SMTP id
 ffacd0b85a97d-44649ba176fmr13813802f8f.36.1777471158926; 
 Wed, 29 Apr 2026 06:59:18 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7ca64ffsm6289675f8f.37.2026.04.29.06.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:59:18 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 29 Apr 2026 15:58:58 +0200
Subject: [PATCH v4 5/9] net: phy: air_phy_lib: Factorize BuckPBus register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-add-ethernet-support-for-genio-520-720-v4-5-be54e17239b7@baylibre.com>
References: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>, 
 Yao Zi <me@ziyao.cc>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, Beiyan Yun <root@infi.wang>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 fanyi zhang <fanyi.zhang@mediatek.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Tommy Shih <tommy.shih@airoha.com>, 
 Kevin-KW Huang <kevin-kw.huang@airoha.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 29 Apr 2026 23:15:47 +0200
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

In preparation of Airoha AN8801R PHY support, move the BuckPBus
register accessors and definitions, present in air_en8811h driver,
into the Airoha PHY shared code (air_phy_lib), so they will be usable
by the new driver without duplicating them.
Also, update air_en8811h driver to use the new function names.

Adapted from [1].

[1]: https://lore.kernel.org/all/20260326-add-airoha-an8801-support-v2-2-1a42d6b6050f@collabora.com/

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 MAINTAINERS                          |   2 +-
 drivers/net/phy/airoha/Kconfig       |   6 +
 drivers/net/phy/airoha/Makefile      |   1 +
 drivers/net/phy/airoha/air_en8811.c  | 304 ++++++++---------------------------
 drivers/net/phy/airoha/air_phy_lib.c | 216 +++++++++++++++++++++++++
 drivers/net/phy/airoha/air_phy_lib.h |  39 +++++
 6 files changed, 329 insertions(+), 239 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 105590ffad0..735ecc36210 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -61,7 +61,7 @@ F:	lib/acpi/
 AIROHA PHY
 M:	Tommy Shih <tommy.shih@airoha.com>
 S:	Maintained
-F:	drivers/net/phy/airoha/air_en8811.c
+F:	drivers/net/phy/airoha/
 
 ALIST
 M:	Simon Glass <sjg@chromium.org>
diff --git a/drivers/net/phy/airoha/Kconfig b/drivers/net/phy/airoha/Kconfig
index da8747939e3..5b109d5c6b4 100644
--- a/drivers/net/phy/airoha/Kconfig
+++ b/drivers/net/phy/airoha/Kconfig
@@ -7,6 +7,12 @@ config PHY_AIROHA_EN8811
 	depends on PHY_AIROHA
 	depends on SUPPORTS_FW_LOADER
 	select FW_LOADER
+	select PHY_AIROHA_PHYLIB
 	help
 	  AIROHA EN8811H supported.
 	  AIROHA AN8811HB supported.
+
+config PHY_AIROHA_PHYLIB
+	tristate
+	help
+	  Airoha Ethernet PHY common library
diff --git a/drivers/net/phy/airoha/Makefile b/drivers/net/phy/airoha/Makefile
index 84d23b19ab0..59051caecef 100644
--- a/drivers/net/phy/airoha/Makefile
+++ b/drivers/net/phy/airoha/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_PHY_AIROHA_EN8811) += air_en8811.o
+obj-$(CONFIG_PHY_AIROHA_PHYLIB) += air_phy_lib.o
diff --git a/drivers/net/phy/airoha/air_en8811.c b/drivers/net/phy/airoha/air_en8811.c
index 0b974472732..de7542eb079 100644
--- a/drivers/net/phy/airoha/air_en8811.c
+++ b/drivers/net/phy/airoha/air_en8811.c
@@ -24,6 +24,8 @@
 #include <dm/device_compat.h>
 #include <u-boot/crc.h>
 
+#include "air_phy_lib.h"
+
 /* MII Registers */
 #define AIR_AUX_CTRL_STATUS		0x1d
 #define AIR_AUX_CTRL_STATUS_SPEED_MASK	GENMASK(4, 2)
@@ -32,10 +34,6 @@
 #define AIR_AUX_CTRL_STATUS_SPEED_1000	0x8
 #define AIR_AUX_CTRL_STATUS_SPEED_2500	0xc
 
-#define AIR_EXT_PAGE_ACCESS		0x1f
-#define AIR_PHY_PAGE_STANDARD		0x0000
-#define AIR_PHY_PAGE_EXTENDED_4		0x0004
-
 #define AIR_PBUS_MODE_ADDR_HIGH		0x1c
 /* MII Registers Page 4 */
 #define AIR_BPBUS_MODE			0x10
@@ -309,166 +307,6 @@ static int air_pbus_reg_write(struct phy_device *phydev,
 	return ret;
 }
 
-static int air_buckpbus_reg_write(struct phy_device *phydev,
-				  u32 pbus_address, u32 pbus_data)
-{
-	int ret, saved_page;
-
-	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
-	if (saved_page < 0)
-		return saved_page;
-
-	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_MODE,
-			AIR_BPBUS_MODE_ADDR_FIXED);
-	if (ret < 0)
-		goto restore_page;
-
-	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_HIGH,
-			upper_16_bits(pbus_address));
-	if (ret < 0)
-		goto restore_page;
-
-	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_LOW,
-			lower_16_bits(pbus_address));
-	if (ret < 0)
-		goto restore_page;
-
-	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_HIGH,
-			upper_16_bits(pbus_data));
-	if (ret < 0)
-		goto restore_page;
-
-	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_LOW,
-			lower_16_bits(pbus_data));
-	if (ret < 0)
-		goto restore_page;
-
-restore_page:
-	if (ret < 0)
-		dev_err(phydev->dev, "%s 0x%08x failed: %d\n", __func__,
-			pbus_address, ret);
-
-	return phy_restore_page(phydev, saved_page, ret);
-}
-
-static int air_buckpbus_reg_read(struct phy_device *phydev,
-				 u32 pbus_address, u32 *pbus_data)
-{
-	int pbus_data_low, pbus_data_high;
-	int ret = 0, saved_page;
-
-	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
-	if (saved_page < 0)
-		return saved_page;
-
-	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_MODE,
-			AIR_BPBUS_MODE_ADDR_FIXED);
-	if (ret < 0)
-		goto restore_page;
-
-	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_ADDR_HIGH,
-			upper_16_bits(pbus_address));
-	if (ret < 0)
-		goto restore_page;
-
-	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_ADDR_LOW,
-			lower_16_bits(pbus_address));
-	if (ret < 0)
-		goto restore_page;
-
-	pbus_data_high = phy_read(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_DATA_HIGH);
-	if (pbus_data_high < 0) {
-		ret = pbus_data_high;
-		goto restore_page;
-	}
-
-	pbus_data_low = phy_read(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_DATA_LOW);
-	if (pbus_data_low < 0) {
-		ret = pbus_data_low;
-		goto restore_page;
-	}
-
-	*pbus_data = pbus_data_low | (pbus_data_high << 16);
-
-restore_page:
-	if (ret < 0)
-		dev_err(phydev->dev, "%s 0x%08x failed: %d\n", __func__,
-			pbus_address, ret);
-
-	return phy_restore_page(phydev, saved_page, ret);
-}
-
-static int air_buckpbus_reg_modify(struct phy_device *phydev,
-				   u32 pbus_address, u32 mask, u32 set)
-{
-	int pbus_data_low, pbus_data_high;
-	u32 pbus_data_old, pbus_data_new;
-	int ret = 0, saved_page;
-
-	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
-	if (saved_page < 0)
-		return saved_page;
-
-	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_MODE,
-			AIR_BPBUS_MODE_ADDR_FIXED);
-	if (ret < 0)
-		goto restore_page;
-
-	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_ADDR_HIGH,
-			upper_16_bits(pbus_address));
-	if (ret < 0)
-		goto restore_page;
-
-	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_ADDR_LOW,
-			lower_16_bits(pbus_address));
-	if (ret < 0)
-		goto restore_page;
-
-	pbus_data_high = phy_read(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_DATA_HIGH);
-	if (pbus_data_high < 0) {
-		ret = pbus_data_high;
-		goto restore_page;
-	}
-
-	pbus_data_low = phy_read(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_DATA_LOW);
-	if (pbus_data_low < 0) {
-		ret = pbus_data_low;
-		goto restore_page;
-	}
-
-	pbus_data_old = pbus_data_low | (pbus_data_high << 16);
-	pbus_data_new = (pbus_data_old & ~mask) | set;
-	if (pbus_data_new == pbus_data_old)
-		goto restore_page;
-
-	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_HIGH,
-			upper_16_bits(pbus_address));
-	if (ret < 0)
-		goto restore_page;
-
-	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_LOW,
-			lower_16_bits(pbus_address));
-	if (ret < 0)
-		goto restore_page;
-
-	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_HIGH,
-			upper_16_bits(pbus_data_new));
-	if (ret < 0)
-		goto restore_page;
-
-	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_LOW,
-			lower_16_bits(pbus_data_new));
-	if (ret < 0)
-		goto restore_page;
-
-restore_page:
-	if (ret < 0)
-		dev_err(phydev->dev, "%s 0x%08x failed: %d\n", __func__,
-			pbus_address, ret);
-
-	return phy_restore_page(phydev, saved_page, ret);
-}
-
 static int air_write_buf(struct phy_device *phydev, unsigned long address,
 			 unsigned long array_size, const unsigned char *buffer)
 {
@@ -539,12 +377,12 @@ static int an8811hb_check_crc(struct phy_device *phydev,
 	u32 pbus_value;
 
 	/* Configure CRC */
-	ret = air_buckpbus_reg_modify(phydev, set1, AN8811HB_CRC_RD_EN,
-				      AN8811HB_CRC_RD_EN);
+	ret = air_phy_buckpbus_reg_modify(phydev, set1, AN8811HB_CRC_RD_EN,
+					  AN8811HB_CRC_RD_EN);
 	if (ret < 0)
 		return ret;
 
-	ret = air_buckpbus_reg_read(phydev, set1, &pbus_value);
+	ret = air_phy_buckpbus_reg_read(phydev, set1, &pbus_value);
 	if (ret < 0)
 		return ret;
 
@@ -553,14 +391,14 @@ static int an8811hb_check_crc(struct phy_device *phydev,
 	do {
 		mdelay(300);
 
-		ret = air_buckpbus_reg_read(phydev, mon2, &pbus_value);
+		ret = air_phy_buckpbus_reg_read(phydev, mon2, &pbus_value);
 		if (ret < 0)
 			return ret;
 
 		debug("%d: reg 0x%x val 0x%x!\n", __LINE__, mon2, pbus_value);
 
 		if (pbus_value & AN8811HB_CRC_ST) {
-			ret = air_buckpbus_reg_read(phydev, mon3, &pbus_value);
+			ret = air_phy_buckpbus_reg_read(phydev, mon3, &pbus_value);
 			if (ret < 0)
 				return ret;
 
@@ -584,11 +422,11 @@ static int an8811hb_check_crc(struct phy_device *phydev,
 		}
 	} while (--retry);
 
-	ret = air_buckpbus_reg_modify(phydev, set1, AN8811HB_CRC_RD_EN, 0);
+	ret = air_phy_buckpbus_reg_modify(phydev, set1, AN8811HB_CRC_RD_EN, 0);
 	if (ret < 0)
 		return ret;
 
-	ret = air_buckpbus_reg_read(phydev, set1, &pbus_value);
+	ret = air_phy_buckpbus_reg_read(phydev, set1, &pbus_value);
 	if (ret < 0)
 		return ret;
 
@@ -646,9 +484,9 @@ static int an8811hb_surge_protect_cfg(struct phy_device *phydev)
 		return ret;
 	}
 
-	ret = air_buckpbus_reg_modify(phydev, AIR_PHY_CONTROL,
-				      AIR_PHY_CONTROL_SURGE_5R,
-				      AIR_PHY_CONTROL_SURGE_5R);
+	ret = air_phy_buckpbus_reg_modify(phydev, AIR_PHY_CONTROL,
+					  AIR_PHY_CONTROL_SURGE_5R,
+					  AIR_PHY_CONTROL_SURGE_5R);
 	if (ret < 0)
 		return ret;
 
@@ -706,14 +544,14 @@ static int en8811h_load_firmware(struct phy_device *phydev)
 		goto en8811h_load_firmware_out;
 	}
 
-	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
-				     EN8811H_FW_CTRL_1_START);
+	ret = air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
+					 EN8811H_FW_CTRL_1_START);
 	if (ret < 0)
 		goto en8811h_load_firmware_out;
 
-	ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
-				      EN8811H_FW_CTRL_2_LOADING,
-				      EN8811H_FW_CTRL_2_LOADING);
+	ret = air_phy_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
+					  EN8811H_FW_CTRL_2_LOADING,
+					  EN8811H_FW_CTRL_2_LOADING);
 	if (ret < 0)
 		goto en8811h_load_firmware_out;
 
@@ -727,13 +565,13 @@ static int en8811h_load_firmware(struct phy_device *phydev)
 	if (ret < 0)
 		goto en8811h_load_firmware_out;
 
-	ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
-				      EN8811H_FW_CTRL_2_LOADING, 0);
+	ret = air_phy_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
+					  EN8811H_FW_CTRL_2_LOADING, 0);
 	if (ret < 0)
 		goto en8811h_load_firmware_out;
 
-	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
-				     EN8811H_FW_CTRL_1_FINISH);
+	ret = air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
+					 EN8811H_FW_CTRL_1_FINISH);
 	if (ret < 0)
 		goto en8811h_load_firmware_out;
 
@@ -741,8 +579,8 @@ static int en8811h_load_firmware(struct phy_device *phydev)
 	if (ret < 0)
 		goto en8811h_load_firmware_out;
 
-	air_buckpbus_reg_read(phydev, EN8811H_FW_VERSION,
-			      &priv->firmware_version);
+	air_phy_buckpbus_reg_read(phydev, EN8811H_FW_VERSION,
+				  &priv->firmware_version);
 
 	dev_info(phydev->dev, "MD32 firmware version: %08x\n",
 		 priv->firmware_version);
@@ -778,8 +616,8 @@ static int an8811hb_load_firmware(struct phy_device *phydev)
 	if (ret < 0)
 		goto an8811hb_load_firmware_out;
 
-	ret = air_buckpbus_reg_write(phydev, AIR_PHY_FW_CTRL_1,
-				     AIR_PHY_FW_CTRL_1_START);
+	ret = air_phy_buckpbus_reg_write(phydev, AIR_PHY_FW_CTRL_1,
+					 AIR_PHY_FW_CTRL_1_START);
 	if (ret < 0)
 		goto an8811hb_load_firmware_out;
 
@@ -803,8 +641,8 @@ static int an8811hb_load_firmware(struct phy_device *phydev)
 	if (ret < 0)
 		goto an8811hb_load_firmware_out;
 
-	ret = air_buckpbus_reg_write(phydev, AIR_PHY_FW_CTRL_1,
-				     AIR_PHY_FW_CTRL_1_FINISH);
+	ret = air_phy_buckpbus_reg_write(phydev, AIR_PHY_FW_CTRL_1,
+					 AIR_PHY_FW_CTRL_1_FINISH);
 	if (ret < 0)
 		goto an8811hb_load_firmware_out;
 
@@ -817,7 +655,7 @@ static int an8811hb_load_firmware(struct phy_device *phydev)
 	do {
 		mdelay(300);
 
-		ret = air_buckpbus_reg_read(phydev, AIR_PHY_FW_CTRL_1, &reg_val);
+		ret = air_phy_buckpbus_reg_read(phydev, AIR_PHY_FW_CTRL_1, &reg_val);
 		if (ret < 0)
 			goto an8811hb_load_firmware_out;
 
@@ -827,8 +665,8 @@ static int an8811hb_load_firmware(struct phy_device *phydev)
 		debug("%d: reg 0x%x val 0x%x!\n", __LINE__, AIR_PHY_FW_CTRL_1,
 		      reg_val);
 
-		ret = air_buckpbus_reg_write(phydev, AIR_PHY_FW_CTRL_1,
-					     AIR_PHY_FW_CTRL_1_FINISH);
+		ret = air_phy_buckpbus_reg_write(phydev, AIR_PHY_FW_CTRL_1,
+						 AIR_PHY_FW_CTRL_1_FINISH);
 		if (ret < 0)
 			goto an8811hb_load_firmware_out;
 
@@ -838,8 +676,8 @@ static int an8811hb_load_firmware(struct phy_device *phydev)
 	if (ret < 0)
 		goto an8811hb_load_firmware_out;
 
-	air_buckpbus_reg_read(phydev, AIR_PHY_MD32FW_VERSION,
-			      &priv->firmware_version);
+	air_phy_buckpbus_reg_read(phydev, AIR_PHY_MD32FW_VERSION,
+				  &priv->firmware_version);
 
 	debug("MD32 firmware version: %08x\n", priv->firmware_version);
 
@@ -858,17 +696,17 @@ int an8811hb_cko_cfg(struct phy_device *phydev)
 	int ret = 0;
 
 	if (!ofnode_read_bool(node, "airoha,phy-output-clock")) {
-		ret = air_buckpbus_reg_modify(phydev, AN8811HB_CLK_DRV,
-					      AN8811HB_CLK_DRV_CKO_MASK,
-					      AN8811HB_CLK_DRV_CKOPWD    |
-					      AN8811HB_CLK_DRV_CKO_LDPWD |
-					      AN8811HB_CLK_DRV_CKO_LPPWD);
+		ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_CLK_DRV,
+						  AN8811HB_CLK_DRV_CKO_MASK,
+						  AN8811HB_CLK_DRV_CKOPWD    |
+						  AN8811HB_CLK_DRV_CKO_LDPWD |
+						  AN8811HB_CLK_DRV_CKO_LPPWD);
 		if (ret < 0)
 			return ret;
 
 		debug("CKO Output mode - Disabled\n");
 	} else {
-		ret = air_buckpbus_reg_read(phydev, AN8811HB_HWTRAP2, &pbus_value);
+		ret = air_phy_buckpbus_reg_read(phydev, AN8811HB_HWTRAP2, &pbus_value);
 		if (ret < 0)
 			return ret;
 
@@ -887,13 +725,13 @@ static int en8811h_restart_mcu(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
-				     EN8811H_FW_CTRL_1_START);
+	ret = air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
+					 EN8811H_FW_CTRL_1_START);
 	if (ret < 0)
 		return ret;
 
-	return air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
-				      EN8811H_FW_CTRL_1_FINISH);
+	return air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
+					  EN8811H_FW_CTRL_1_FINISH);
 }
 
 static int air_led_hw_control_set(struct phy_device *phydev, u8 index,
@@ -1091,10 +929,10 @@ static int en8811h_config(struct phy_device *phydev)
 		pbus_value &= ~EN8811H_POLARITY_TX_NORMAL;
 	else
 		pbus_value |=  EN8811H_POLARITY_TX_NORMAL;
-	ret = air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
-				      EN8811H_POLARITY_RX_REVERSE |
-				      EN8811H_POLARITY_TX_NORMAL,
-				      pbus_value);
+	ret = air_phy_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
+					  EN8811H_POLARITY_RX_REVERSE |
+					  EN8811H_POLARITY_TX_NORMAL,
+					  pbus_value);
 	if (ret < 0)
 		return ret;
 
@@ -1142,12 +980,12 @@ static int an8811hb_config(struct phy_device *phydev)
 		priv->mcu_needs_restart = true;
 	}
 
-	ret = air_buckpbus_reg_read(phydev, AN8811HB_PRO_ID, &pbus_value);
+	ret = air_phy_buckpbus_reg_read(phydev, AN8811HB_PRO_ID, &pbus_value);
 	if (ret < 0)
 		return ret;
 	priv->pro_id = (pbus_value & AN8811HB_PRO_ID_VERSION) + 1;
 
-	ret = air_buckpbus_reg_read(phydev, AN8811HB_HWTRAP2, &pbus_value);
+	ret = air_phy_buckpbus_reg_read(phydev, AN8811HB_HWTRAP2, &pbus_value);
 	if (ret < 0)
 		return ret;
 	priv->pkg_sel = (pbus_value & AN8811HB_HWTRAP2_PKG) >> 12;
@@ -1163,8 +1001,8 @@ static int an8811hb_config(struct phy_device *phydev)
 		pbus_value |= AN8811HB_RX_POLARITY_NORMAL;
 
 	debug("1 pbus_value 0x%x\n", pbus_value);
-	ret = air_buckpbus_reg_modify(phydev, AN8811HB_RX_POLARITY,
-				      AN8811HB_RX_POLARITY_NORMAL, pbus_value);
+	ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_RX_POLARITY,
+					  AN8811HB_RX_POLARITY_NORMAL, pbus_value);
 	if (ret < 0)
 		return ret;
 
@@ -1175,35 +1013,35 @@ static int an8811hb_config(struct phy_device *phydev)
 		pbus_value |= AN8811HB_TX_POLARITY_NORMAL;
 
 	debug("2 pbus_value 0x%x\n", pbus_value);
-	ret = air_buckpbus_reg_modify(phydev, AN8811HB_TX_POLARITY,
-				      AN8811HB_TX_POLARITY_NORMAL, pbus_value);
+	ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_TX_POLARITY,
+					  AN8811HB_TX_POLARITY_NORMAL, pbus_value);
 	if (ret < 0)
 		return ret;
 
 	/* Configure led gpio pins as output */
 	if (priv->pkg_sel) {
-		ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
-					      AN8811HB_GPIO_OUTPUT_MASK,
-					      AN8811HB_GPIO_OUTPUT_0115);
+		ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
+						  AN8811HB_GPIO_OUTPUT_MASK,
+						  AN8811HB_GPIO_OUTPUT_0115);
 		if (ret < 0)
 			return ret;
-		ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_SEL_1,
-					      AN8811HB_GPIO_SEL_1_0_MASK |
-					      AN8811HB_GPIO_SEL_1_1_MASK,
-					      AN8811HB_GPIO_SEL_1_0 |
-					      AN8811HB_GPIO_SEL_1_1);
+		ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_SEL_1,
+						  AN8811HB_GPIO_SEL_1_0_MASK |
+						  AN8811HB_GPIO_SEL_1_1_MASK,
+						  AN8811HB_GPIO_SEL_1_0 |
+						  AN8811HB_GPIO_SEL_1_1);
 		if (ret < 0)
 			return ret;
 
-		ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_SEL_2,
-					      AN8811HB_GPIO_SEL_2_15_MASK,
-					      AN8811HB_GPIO_SEL_2_15);
+		ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_SEL_2,
+						  AN8811HB_GPIO_SEL_2_15_MASK,
+						  AN8811HB_GPIO_SEL_2_15);
 		if (ret < 0)
 			return ret;
 	} else {
-		ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
-					      AN8811HB_GPIO_OUTPUT_345,
-					      AN8811HB_GPIO_OUTPUT_345);
+		ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
+						  AN8811HB_GPIO_OUTPUT_345,
+						  AN8811HB_GPIO_OUTPUT_345);
 		if (ret < 0)
 			return ret;
 	}
@@ -1373,16 +1211,6 @@ static int en8811h_probe(struct phy_device *phydev)
 	return 0;
 }
 
-static int air_phy_read_page(struct phy_device *phydev)
-{
-	return phy_read(phydev, MDIO_DEVAD_NONE, AIR_EXT_PAGE_ACCESS);
-}
-
-static int air_phy_write_page(struct phy_device *phydev, int page)
-{
-	return phy_write(phydev, MDIO_DEVAD_NONE, AIR_EXT_PAGE_ACCESS, page);
-}
-
 U_BOOT_PHY_DRIVER(en8811h) = {
 	.name = "Airoha EN8811H",
 	.uid = EN8811H_PHY_ID,
diff --git a/drivers/net/phy/airoha/air_phy_lib.c b/drivers/net/phy/airoha/air_phy_lib.c
new file mode 100644
index 00000000000..61c3bf82822
--- /dev/null
+++ b/drivers/net/phy/airoha/air_phy_lib.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Airoha Ethernet PHY common library
+ *
+ * Copyright (C) 2026 Airoha Technology Corp.
+ * Copyright (C) 2026 Collabora Ltd.
+ *                    Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
+ *
+ * Adapated from https://lore.kernel.org/all/20260326-add-airoha-an8801-support-v2-2-1a42d6b6050f@collabora.com/
+ */
+
+#include <dm/device_compat.h>
+#include <linux/compat.h>
+#include <phy.h>
+
+#include "air_phy_lib.h"
+
+#define AIR_EXT_PAGE_ACCESS	0x1f
+
+static int __air_buckpbus_reg_read(struct phy_device *phydev,
+				   u32 pbus_address, u32 *pbus_data)
+{
+	int pbus_data_low, pbus_data_high;
+	int ret;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_MODE,
+			AIR_BPBUS_MODE_ADDR_FIXED);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_ADDR_HIGH,
+			upper_16_bits(pbus_address));
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_ADDR_LOW,
+			lower_16_bits(pbus_address));
+	if (ret < 0)
+		return ret;
+
+	pbus_data_high = phy_read(phydev, MDIO_DEVAD_NONE,
+				  AIR_BPBUS_RD_DATA_HIGH);
+	if (pbus_data_high < 0)
+		return pbus_data_high;
+
+	pbus_data_low = phy_read(phydev, MDIO_DEVAD_NONE,
+				 AIR_BPBUS_RD_DATA_LOW);
+	if (pbus_data_low < 0)
+		return pbus_data_low;
+
+	*pbus_data = pbus_data_low | (pbus_data_high << 16);
+	return 0;
+}
+
+static int __air_buckpbus_reg_write(struct phy_device *phydev,
+				    u32 pbus_address, u32 pbus_data)
+{
+	int ret;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_MODE,
+			AIR_BPBUS_MODE_ADDR_FIXED);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_HIGH,
+			upper_16_bits(pbus_address));
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_LOW,
+			lower_16_bits(pbus_address));
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_HIGH,
+			upper_16_bits(pbus_data));
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_LOW,
+			lower_16_bits(pbus_data));
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int __air_buckpbus_reg_modify(struct phy_device *phydev,
+				     u32 pbus_address, u32 mask, u32 set)
+{
+	int pbus_data_low, pbus_data_high;
+	u32 pbus_data_old, pbus_data_new;
+	int ret;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_MODE,
+			AIR_BPBUS_MODE_ADDR_FIXED);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_ADDR_HIGH,
+			upper_16_bits(pbus_address));
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_ADDR_LOW,
+			lower_16_bits(pbus_address));
+	if (ret < 0)
+		return ret;
+
+	pbus_data_high = phy_read(phydev, MDIO_DEVAD_NONE,
+				  AIR_BPBUS_RD_DATA_HIGH);
+	if (pbus_data_high < 0)
+		return pbus_data_high;
+
+	pbus_data_low = phy_read(phydev, MDIO_DEVAD_NONE,
+				 AIR_BPBUS_RD_DATA_LOW);
+	if (pbus_data_low < 0)
+		return pbus_data_low;
+
+	pbus_data_old = pbus_data_low | (pbus_data_high << 16);
+	pbus_data_new = (pbus_data_old & ~mask) | set;
+	if (pbus_data_new == pbus_data_old)
+		return 0;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_HIGH,
+			upper_16_bits(pbus_address));
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_LOW,
+			lower_16_bits(pbus_address));
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_HIGH,
+			upper_16_bits(pbus_data_new));
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_LOW,
+			lower_16_bits(pbus_data_new));
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+int air_phy_buckpbus_reg_read(struct phy_device *phydev, u32 pbus_address,
+			      u32 *pbus_data)
+{
+	int saved_page;
+	int ret = 0;
+
+	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
+
+	if (saved_page >= 0) {
+		ret = __air_buckpbus_reg_read(phydev, pbus_address, pbus_data);
+		if (ret < 0)
+			dev_err(phydev->dev, "%s 0x%08x failed: %d\n", __func__,
+				pbus_address, ret);
+	}
+
+	return phy_restore_page(phydev, saved_page, ret);
+}
+
+int air_phy_buckpbus_reg_write(struct phy_device *phydev, u32 pbus_address,
+			       u32 pbus_data)
+{
+	int saved_page;
+	int ret = 0;
+
+	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
+
+	if (saved_page >= 0) {
+		ret = __air_buckpbus_reg_write(phydev, pbus_address,
+					       pbus_data);
+		if (ret < 0)
+			dev_err(phydev->dev, "%s 0x%08x failed: %d\n", __func__,
+				pbus_address, ret);
+	}
+
+	return phy_restore_page(phydev, saved_page, ret);
+}
+
+int air_phy_buckpbus_reg_modify(struct phy_device *phydev, u32 pbus_address,
+				u32 mask, u32 set)
+{
+	int saved_page;
+	int ret = 0;
+
+	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
+
+	if (saved_page >= 0) {
+		ret = __air_buckpbus_reg_modify(phydev, pbus_address, mask,
+						set);
+		if (ret < 0)
+			dev_err(phydev->dev, "%s 0x%08x failed: %d\n", __func__,
+				pbus_address, ret);
+	}
+
+	return phy_restore_page(phydev, saved_page, ret);
+}
+
+int air_phy_read_page(struct phy_device *phydev)
+{
+	return phy_read(phydev, MDIO_DEVAD_NONE, AIR_EXT_PAGE_ACCESS);
+}
+
+int air_phy_write_page(struct phy_device *phydev, int page)
+{
+	return phy_write(phydev, MDIO_DEVAD_NONE, AIR_EXT_PAGE_ACCESS, page);
+}
+
+MODULE_DESCRIPTION("Airoha PHY Library");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Louis-Alexis Eyraud");
diff --git a/drivers/net/phy/airoha/air_phy_lib.h b/drivers/net/phy/airoha/air_phy_lib.h
new file mode 100644
index 00000000000..845d2f7cfb4
--- /dev/null
+++ b/drivers/net/phy/airoha/air_phy_lib.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 Airoha Technology Corp.
+ * Copyright (C) 2026 Collabora Ltd.
+ *                    Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
+ */
+
+#ifndef __AIR_PHY_LIB_H
+#define __AIR_PHY_LIB_H
+
+#define AIR_EXT_PAGE_ACCESS	0x1f
+
+#define AIR_PHY_PAGE_STANDARD		0x0000
+#define AIR_PHY_PAGE_EXTENDED_1		0x0001
+#define AIR_PHY_PAGE_EXTENDED_4		0x0004
+
+/* MII Registers Page 4*/
+#define AIR_BPBUS_MODE			0x10
+#define   AIR_BPBUS_MODE_ADDR_FIXED	0x0000
+#define   AIR_BPBUS_MODE_ADDR_INCR	BIT(15)
+#define AIR_BPBUS_WR_ADDR_HIGH		0x11
+#define AIR_BPBUS_WR_ADDR_LOW		0x12
+#define AIR_BPBUS_WR_DATA_HIGH		0x13
+#define AIR_BPBUS_WR_DATA_LOW		0x14
+#define AIR_BPBUS_RD_ADDR_HIGH		0x15
+#define AIR_BPBUS_RD_ADDR_LOW		0x16
+#define AIR_BPBUS_RD_DATA_HIGH		0x17
+#define AIR_BPBUS_RD_DATA_LOW		0x18
+
+int air_phy_buckpbus_reg_modify(struct phy_device *phydev, u32 pbus_address,
+				u32 mask, u32 set);
+int air_phy_buckpbus_reg_read(struct phy_device *phydev, u32 pbus_address,
+			      u32 *pbus_data);
+int air_phy_buckpbus_reg_write(struct phy_device *phydev, u32 pbus_address,
+			       u32 pbus_data);
+int air_phy_read_page(struct phy_device *phydev);
+int air_phy_write_page(struct phy_device *phydev, int page);
+
+#endif /* __AIR_PHY_LIB_H */

-- 
2.52.0

