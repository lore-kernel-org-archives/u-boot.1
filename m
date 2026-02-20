Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E333C5AD69
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 19:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66D5683D8A;
	Fri, 20 Feb 2026 20:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C2DSwJA6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9D9F83A5E; Fri, 20 Feb 2026 20:34:05 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CC5883AC5
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 20:34:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-45effa36208so1478960b6e.1
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 11:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771616039; x=1772220839;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SZKwMIVh/6At2CQHqVmailSkOvwOUXBl9PUzMYgpDi0=;
 b=C2DSwJA6TyuHs4RHW1zjq6/zixb25YG48jyXbz4stBKHLf7kOZrDQ1W2++9WzgeZSc
 cHm0vRzS4dpPzYnLys/Lhmt3kTwn5nedTEKN6v4xgkZHpbIbxBXdCMb3KILR2OhlTnfr
 fybI6jTtBiWEYgf0dazY1U+jqcGEl6KUqsCuCDJQn5UgE/7AgArlnF5EVDCUia3/+2cC
 w7iF7y2shu2mXv7xs66BDtxXApMFr9LJaXSTJB7DY2iAf1aDr6fu9O2x5KubsvQMWRUd
 v9GJdz+TnPIBhHwmeRqnVxjLIzPGjEgkkCLIqtLOalwTXG1/UFE8XH+IV7GO8Ek5kwPp
 KfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771616039; x=1772220839;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SZKwMIVh/6At2CQHqVmailSkOvwOUXBl9PUzMYgpDi0=;
 b=BeEB22U12TbgyHLoMAxxCNpBt2jPyQ/EXhHcdfdmeHX6u9oSAE6UHSk8p4aMfuSBCh
 8/S5y4XwC+0sHl42RIQAfKV7XPySt9Os1Op3PqLzS8FGJyKx9nZi94E//YR72yLtRfxb
 ycvxzDJLSXAR2AXWeDtw6pPPHBcGrOpP+jhKahdr1TEOs2Tpt+Te++FnOQ+5nVQBtLVD
 JsuR3DfT7GIZHANIbjws2oMWo0FBzwHwe9bvXLJWzDpOSTwGCufPsjWpRa7qUxbLKTnZ
 u0xckttai8QDJWwi081PpZ4cfpxFVwbtybkFLICfWS4jLHP5ILqRFXdh4YAmCKcUt4/T
 Ggqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0G29Z9cM8opIkY1ByxS7XWFFRK/ksAx8EllXFd6kjx4bpofot9UsUZOuMh+oPf+eEd0f7Spo=@lists.denx.de
X-Gm-Message-State: AOJu0Yze8Xan2f7NdVs8/GT4qMSxJLs+UANN4U+6JmibqBYqrpBYP8vU
 KZB/DOb1C5Dswq0794jYbEKmy20c9ocLoY31CUfGyj8BjWPkbY82QmqkiQSmi/3QW060DQANSxf
 uv60v
X-Gm-Gg: AZuq6aIahM4uBnYksR8GsZDDzq2jbUhlOFItmbNHs4qG6DPp86oTao7nL7ApgJl5yvq
 JW0ZstsR67w9LXP1aiLEJYn3nMrfi2uQLGZb6rGay+TxAnqWUyH8+t9Au7Gu+WNQUpdqrTBJr3y
 B/K3GwlDMIH+jQcwRItvHv/ZQjwFWWGiCJwejz5x8kakKWEJ/cAZIjTmT7lruQcTATNOMKjHPpm
 J54t+P8j2gvU+/30PvPc+WZU6emEvhwqNxwjNgRc0F48P73kHao5B7az0rUD4ECVnCQTVy/M2HD
 scKbfT9WA2ZQm2RuEL9xiBK0aVPfpHNF+7JRvXP7EBwC7Zk3RFldRoCL5+P9A2lAlDONl3yOcSX
 bHnAlmpPjT5t9syKjeHmQag4smq5U7lH/MZI/KXkDlplybPpegel83wLNJRszBEPc/W0rOWeLRZ
 f9WpvlWiT6P9oS55jHj/Vr+PEsLhk=
X-Received: by 2002:a05:6808:1710:b0:45f:1b74:2192 with SMTP id
 5614622812f47-4644613618amr701993b6e.10.1771616039159; 
 Fri, 20 Feb 2026 11:33:59 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:339f:eabc:8753:3aa4])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a012dc7sm52370b6e.6.2026.02.20.11.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 11:33:58 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Feb 2026 13:33:05 -0600
Subject: [PATCH 3/4] power: pmic: mtk-pwrap: add MediaTek PMIC Wrapper driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-mtk-pmic-pwrap-support-v1-3-a345ea3b4294@baylibre.com>
References: <20260220-mtk-pmic-pwrap-support-v1-0-a345ea3b4294@baylibre.com>
In-Reply-To: <20260220-mtk-pmic-pwrap-support-v1-0-a345ea3b4294@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=26619;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=AeajN/uZvc7CSI/7H/PsOLc2Hae/vWW5NSv1yAFwGAw=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpmLcUZCE9qL8st/cS8Ss8UFWXBG/H+7qvKL8OG
 vvUD5em7cGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZi3FBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AR14H/jRW8hEszrEtFOtVz3xXz1YBD5PWGhx7yoQ/QDa
 +RJSykrF+7XcmqzOVa5fvZNE7L8QJT2pNDU3LK2NdXfpoFbwvEX4ZFt3kascicy2ozRljb6qnw+
 74ZozGpa7nKVfvDZJSLM8U2bmTkItys0fjx3VjQ+BXb1eSN/GhnlEOJ23tiktCrb2q6qoPZpn6B
 eEoFGkABkM8wtoDYnRKTYP1VVfQjXaCROfusxBvIuR7CdeLFnYyFEIj1Q8OBFdKkquo/jznIPV5
 CdSMwQ1W4fS0gkZI/NX3o3us1rwgCtf0iEZNiehzDQLz9M3XCzGArhSTw1QEumCOF/myMzOttDA
 NWCo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

From: Julien Masson <jmasson@baylibre.com>

Add support for the PMIC wrapper (pwrap) IP block found on MediaTek
MT8365 and similar SoCs.

On these SoCs the PMIC is connected via SPI. The SPI controller is not
directly visible to the CPU, but only through the PMIC wrapper inside
the SoC.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Co-developed-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Co-developed-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 MAINTAINERS                    |   1 +
 drivers/power/pmic/Kconfig     |   8 +
 drivers/power/pmic/Makefile    |   1 +
 drivers/power/pmic/mtk-pwrap.c | 896 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 906 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 479d328f50d..fcc90ee7b80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -432,6 +432,7 @@ F:	drivers/net/phy/mediatek/
 F:	drivers/phy/phy-mtk-*
 F:	drivers/pinctrl/mediatek/
 F:	drivers/power/domain/mtk-power-domain.c
+F:	drivers/power/pmic/mtk-pwrap.c
 F:	drivers/power/regulator/mt*.c
 F:	drivers/pci/pcie_mediatek_gen3.c
 F:	drivers/pci/pcie_mediatek.c
diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index b1a5b1c2a1f..345b7c92263 100644
--- a/drivers/power/pmic/Kconfig
+++ b/drivers/power/pmic/Kconfig
@@ -433,6 +433,14 @@ config PMIC_RAA215300
 	  support and several voltage regulators. For now, this driver simply
 	  allows register access and will bind the sysreset driver
 	  (CONFIG_SYSRESET_RAA215300) if it is enabled.
+
+config DM_PMIC_MTK_PWRAP
+	bool "Enable driver for MediaTek PMIC Wrapper Support"
+	help
+	  Say yes here to add support for MediaTek PMIC Wrapper found
+	  on different MediaTek SoCs. The PMIC wrapper is a proprietary
+	  hardware to connect the PMIC.
+
 endif
 
 config PMIC_TPS65217
diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
index 6bebffb05a6..2cda5a892fd 100644
--- a/drivers/power/pmic/Makefile
+++ b/drivers/power/pmic/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_PMIC_TPS65941) += tps65941.o
 obj-$(CONFIG_PMIC_RAA215300) += raa215300.o
 obj-$(CONFIG_POWER_TPS65218) += pmic_tps65218.o
 obj-$(CONFIG_$(PHASE_)DM_PMIC_CPCAP) += cpcap.o
+obj-$(CONFIG_DM_PMIC_MTK_PWRAP) += mtk-pwrap.o
 
 ifeq ($(CONFIG_$(PHASE_)POWER_LEGACY),y)
 obj-$(CONFIG_POWER_LTC3676) += pmic_ltc3676.o
diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
new file mode 100644
index 00000000000..3e3a691d9e8
--- /dev/null
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -0,0 +1,896 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MT6357 regulator driver
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <linux/bitfield.h>
+#include <linux/err.h>
+#include <power/pmic.h>
+#include <power/mt6357.h>
+#include <power/mt6359.h>
+#include <time.h>
+
+static const struct pmic_child_info mt6357_pmic_children_info[] = {
+	{ .prefix = "buck", .driver = MT6357_REGULATOR_DRIVER },
+	{ .prefix = "ldo", .driver = MT6357_REGULATOR_DRIVER },
+	{ }
+};
+
+static const struct pmic_child_info mt6359_pmic_children_info[] = {
+	{ .prefix = "buck", .driver = MT6359_REGULATOR_DRIVER },
+	{ .prefix = "ldo", .driver = MT6359_REGULATOR_DRIVER },
+	{ }
+};
+
+/* macro for wrapper status */
+#define PWRAP_GET_WACS_RDATA		GENMASK(15, 0)
+#define PWRAP_GET_WACS_FSM		GENMASK(18, 16)
+#define PWRAP_GET_WACS_ARB_FSM		GENMASK(3, 1)
+#define PWRAP_STATE_SYNC_IDLE0		BIT(20)
+#define PWRAP_STATE_INIT_DONE0		BIT(21)
+#define PWRAP_STATE_INIT_DONE1		BIT(15)
+
+/* macro for WACS FSM */
+#define PWRAP_WACS_FSM_IDLE		0x00
+#define PWRAP_WACS_FSM_WFVLDCLR		0x06
+
+/* macro for device wrapper default value */
+#define PWRAP_DEW_READ_TEST_VAL		0x5aa5
+
+/* macro for manual command */
+#define PWRAP_MAN_CMD_SPI_WRITE		BIT(13)
+#define PWRAP_MAN_CMD_OP_CSH		(0x0 << 8)
+#define PWRAP_MAN_CMD_OP_CSL		(0x1 << 8)
+#define PWRAP_MAN_CMD_OP_OUTS		(0x8 << 8)
+
+/* macro for Watch Dog Timer Source */
+#define PWRAP_WDT_SRC_MASK_ALL		GENMASK(31, 0)
+
+/* Group of bits used for shown slave capability */
+#define PWRAP_SLV_CAP_SPI		BIT(0)
+#define PWRAP_SLV_CAP_DUALIO		BIT(1)
+#define HAS_CAP(_c, _x_val)		(((_c) & (_x_val)) == (_x_val))
+
+/* Group of bits used for shown pwrap capability */
+#define PWRAP_CAP_INT1_EN		BIT(3)
+#define PWRAP_CAP_WDT_SRC1		BIT(4)
+#define PWRAP_CAP_ARB			BIT(5)
+
+/* defines for slave device wrapper registers */
+enum dew_regs {
+	PWRAP_DEW_BASE,
+	PWRAP_DEW_DIO_EN,
+	PWRAP_DEW_READ_TEST,
+	PWRAP_DEW_WRITE_TEST,
+	PWRAP_DEW_CRC_EN,
+	PWRAP_DEW_CRC_VAL,
+	PWRAP_DEW_MON_GRP_SEL,
+	PWRAP_DEW_CIPHER_KEY_SEL,
+	PWRAP_DEW_CIPHER_IV_SEL,
+	PWRAP_DEW_CIPHER_RDY,
+	PWRAP_DEW_CIPHER_MODE,
+	PWRAP_DEW_CIPHER_SWRST,
+
+	/* MT6323 only regs */
+	PWRAP_DEW_CIPHER_EN,
+	PWRAP_DEW_RDDMY_NO,
+
+	/* MT6358 only regs */
+	PWRAP_SMT_CON1,
+	PWRAP_DRV_CON1,
+	PWRAP_FILTER_CON0,
+	PWRAP_GPIO_PULLEN0_CLR,
+	PWRAP_RG_SPI_CON0,
+	PWRAP_RG_SPI_RECORD0,
+	PWRAP_RG_SPI_CON2,
+	PWRAP_RG_SPI_CON3,
+	PWRAP_RG_SPI_CON4,
+	PWRAP_RG_SPI_CON5,
+	PWRAP_RG_SPI_CON6,
+	PWRAP_RG_SPI_CON7,
+	PWRAP_RG_SPI_CON8,
+	PWRAP_RG_SPI_CON13,
+	PWRAP_SPISLV_KEY,
+
+	/* MT6359 only regs */
+	PWRAP_DEW_CRC_SWRST,
+	PWRAP_DEW_RG_EN_RECORD,
+	PWRAP_DEW_RECORD_CMD0,
+	PWRAP_DEW_RECORD_CMD1,
+	PWRAP_DEW_RECORD_CMD2,
+	PWRAP_DEW_RECORD_CMD3,
+	PWRAP_DEW_RECORD_CMD4,
+	PWRAP_DEW_RECORD_CMD5,
+	PWRAP_DEW_RECORD_WDATA0,
+	PWRAP_DEW_RECORD_WDATA1,
+	PWRAP_DEW_RECORD_WDATA2,
+	PWRAP_DEW_RECORD_WDATA3,
+	PWRAP_DEW_RECORD_WDATA4,
+	PWRAP_DEW_RECORD_WDATA5,
+	PWRAP_DEW_RG_ADDR_TARGET,
+	PWRAP_DEW_RG_ADDR_MASK,
+	PWRAP_DEW_RG_WDATA_TARGET,
+	PWRAP_DEW_RG_WDATA_MASK,
+	PWRAP_DEW_RG_SPI_RECORD_CLR,
+	PWRAP_DEW_RG_CMD_ALERT_CLR,
+};
+
+static const u32 mt6357_regs[] = {
+	[PWRAP_DEW_DIO_EN] =		0x040A,
+	[PWRAP_DEW_READ_TEST] =		0x040C,
+	[PWRAP_DEW_WRITE_TEST] =	0x040E,
+	[PWRAP_DEW_CRC_EN] =		0x0412,
+	[PWRAP_DEW_CRC_VAL] =		0x0414,
+	[PWRAP_DEW_CIPHER_KEY_SEL] =	0x0418,
+	[PWRAP_DEW_CIPHER_IV_SEL] =	0x041A,
+	[PWRAP_DEW_CIPHER_RDY] =	0x041E,
+	[PWRAP_DEW_CIPHER_MODE] =	0x0420,
+	[PWRAP_DEW_CIPHER_SWRST] =	0x0422,
+	[PWRAP_DEW_CIPHER_EN] =		0x041C,
+	[PWRAP_DEW_RDDMY_NO] =		0x0424,
+};
+
+static const u32 mt6359_regs[] = {
+	[PWRAP_DEW_RG_EN_RECORD] =	0x040a,
+	[PWRAP_DEW_DIO_EN] =		0x040c,
+	[PWRAP_DEW_READ_TEST] =		0x040e,
+	[PWRAP_DEW_WRITE_TEST] =	0x0410,
+	[PWRAP_DEW_CRC_SWRST] =		0x0412,
+	[PWRAP_DEW_CRC_EN] =		0x0414,
+	[PWRAP_DEW_CRC_VAL] =		0x0416,
+	[PWRAP_DEW_CIPHER_KEY_SEL] =	0x0418,
+	[PWRAP_DEW_CIPHER_IV_SEL] =	0x041a,
+	[PWRAP_DEW_CIPHER_EN] =		0x041c,
+	[PWRAP_DEW_CIPHER_RDY] =	0x041e,
+	[PWRAP_DEW_CIPHER_MODE] =	0x0420,
+	[PWRAP_DEW_CIPHER_SWRST] =	0x0422,
+	[PWRAP_DEW_RDDMY_NO] =		0x0424,
+	[PWRAP_DEW_RECORD_CMD0] =	0x0428,
+	[PWRAP_DEW_RECORD_CMD1] =	0x042a,
+	[PWRAP_DEW_RECORD_CMD2] =	0x042c,
+	[PWRAP_DEW_RECORD_CMD3] =	0x042e,
+	[PWRAP_DEW_RECORD_CMD4] =	0x0430,
+	[PWRAP_DEW_RECORD_CMD5] =	0x0432,
+	[PWRAP_DEW_RECORD_WDATA0] =	0x0434,
+	[PWRAP_DEW_RECORD_WDATA1] =	0x0436,
+	[PWRAP_DEW_RECORD_WDATA2] =	0x0438,
+	[PWRAP_DEW_RECORD_WDATA3] =	0x043a,
+	[PWRAP_DEW_RECORD_WDATA4] =	0x043c,
+	[PWRAP_DEW_RECORD_WDATA5] =	0x043e,
+	[PWRAP_DEW_RG_ADDR_TARGET] =	0x0440,
+	[PWRAP_DEW_RG_ADDR_MASK] =	0x0442,
+	[PWRAP_DEW_RG_WDATA_TARGET] =	0x0444,
+	[PWRAP_DEW_RG_WDATA_MASK] =	0x0446,
+	[PWRAP_DEW_RG_SPI_RECORD_CLR] =	0x0448,
+	[PWRAP_DEW_RG_CMD_ALERT_CLR] =	0x0448,
+	[PWRAP_SPISLV_KEY] =		0x044a,
+};
+
+enum pwrap_regs {
+	PWRAP_MUX_SEL,
+	PWRAP_WRAP_EN,
+	PWRAP_DIO_EN,
+	PWRAP_SIDLY,
+	PWRAP_CSHEXT_WRITE,
+	PWRAP_CSHEXT_READ,
+	PWRAP_CSLEXT_START,
+	PWRAP_CSLEXT_END,
+	PWRAP_STAUPD_PRD,
+	PWRAP_STAUPD_GRPEN,
+	PWRAP_STAUPD_MAN_TRIG,
+	PWRAP_STAUPD_STA,
+	PWRAP_WRAP_STA,
+	PWRAP_HARB_INIT,
+	PWRAP_HARB_HPRIO,
+	PWRAP_HIPRIO_ARB_EN,
+	PWRAP_HARB_STA0,
+	PWRAP_HARB_STA1,
+	PWRAP_MAN_EN,
+	PWRAP_MAN_CMD,
+	PWRAP_MAN_RDATA,
+	PWRAP_MAN_VLDCLR,
+	PWRAP_WACS0_EN,
+	PWRAP_INIT_DONE0,
+	PWRAP_WACS0_CMD,
+	PWRAP_WACS0_RDATA,
+	PWRAP_WACS0_VLDCLR,
+	PWRAP_WACS1_EN,
+	PWRAP_INIT_DONE1,
+	PWRAP_WACS1_CMD,
+	PWRAP_WACS1_RDATA,
+	PWRAP_WACS1_VLDCLR,
+	PWRAP_WACS2_EN,
+	PWRAP_INIT_DONE2,
+	PWRAP_WACS2_CMD,
+	PWRAP_WACS2_RDATA,
+	PWRAP_WACS2_VLDCLR,
+	PWRAP_INT_EN,
+	PWRAP_INT_FLG_RAW,
+	PWRAP_INT_FLG,
+	PWRAP_INT_CLR,
+	PWRAP_SIG_ADR,
+	PWRAP_SIG_MODE,
+	PWRAP_SIG_VALUE,
+	PWRAP_SIG_ERRVAL,
+	PWRAP_CRC_EN,
+	PWRAP_TIMER_EN,
+	PWRAP_TIMER_STA,
+	PWRAP_WDT_UNIT,
+	PWRAP_WDT_SRC_EN,
+	PWRAP_WDT_FLG,
+	PWRAP_DEBUG_INT_SEL,
+	PWRAP_CIPHER_KEY_SEL,
+	PWRAP_CIPHER_IV_SEL,
+	PWRAP_CIPHER_RDY,
+	PWRAP_CIPHER_MODE,
+	PWRAP_CIPHER_SWRST,
+	PWRAP_DCM_EN,
+	PWRAP_DCM_DBC_PRD,
+	PWRAP_EINT_STA0_ADR,
+	PWRAP_EINT_STA1_ADR,
+	PWRAP_SWINF_2_WDATA_31_0,
+	PWRAP_SWINF_2_RDATA_31_0,
+
+	/* MT8390 only regs */
+	PWRAP_STAUPD_CTRL,
+
+	/* MT8365 only regs */
+	PWRAP_INT1_EN,
+	PWRAP_INT1_FLG,
+	PWRAP_INT1_CLR,
+	PWRAP_WDT_SRC_EN_1,
+};
+
+static int mt8188_regs[] = {
+	[PWRAP_INIT_DONE2] =            0x0,
+	[PWRAP_STAUPD_CTRL] =           0x4C,
+	[PWRAP_TIMER_EN] =              0x3E4,
+	[PWRAP_INT_EN] =                0x420,
+	[PWRAP_INT_FLG] =               0x428,
+	[PWRAP_INT_CLR] =               0x42C,
+	[PWRAP_INT1_EN] =               0x450,
+	[PWRAP_INT1_FLG] =              0x458,
+	[PWRAP_INT1_CLR] =              0x45C,
+	[PWRAP_WACS2_CMD] =             0x880,
+	[PWRAP_SWINF_2_WDATA_31_0] =    0x884,
+	[PWRAP_SWINF_2_RDATA_31_0] =    0x894,
+	[PWRAP_WACS2_VLDCLR] =          0x8A4,
+	[PWRAP_WACS2_RDATA] =           0x8A8,
+};
+
+static int mt8189_regs[] = {
+	[PWRAP_INIT_DONE2] =		0x0,
+	[PWRAP_TIMER_EN] =		0x3E4,
+	[PWRAP_INT_EN] =		0x450,
+	[PWRAP_WACS2_CMD] =		0x880,
+	[PWRAP_SWINF_2_WDATA_31_0] =	0x884,
+	[PWRAP_SWINF_2_RDATA_31_0] =	0x894,
+	[PWRAP_WACS2_VLDCLR] =		0x8A4,
+	[PWRAP_WACS2_RDATA] =		0x8A8,
+};
+
+static int mt8365_regs[] = {
+	[PWRAP_MUX_SEL] =		0x0,
+	[PWRAP_WRAP_EN] =		0x4,
+	[PWRAP_DIO_EN] =		0x8,
+	[PWRAP_CSHEXT_WRITE] =		0x24,
+	[PWRAP_CSHEXT_READ] =		0x28,
+	[PWRAP_STAUPD_PRD] =		0x3c,
+	[PWRAP_STAUPD_GRPEN] =		0x40,
+	[PWRAP_STAUPD_MAN_TRIG] =	0x58,
+	[PWRAP_STAUPD_STA] =		0x5c,
+	[PWRAP_WRAP_STA] =		0x60,
+	[PWRAP_HARB_INIT] =		0x64,
+	[PWRAP_HARB_HPRIO] =		0x68,
+	[PWRAP_HIPRIO_ARB_EN] =		0x6c,
+	[PWRAP_HARB_STA0] =		0x70,
+	[PWRAP_HARB_STA1] =		0x74,
+	[PWRAP_MAN_EN] =		0x7c,
+	[PWRAP_MAN_CMD] =		0x80,
+	[PWRAP_MAN_RDATA] =		0x84,
+	[PWRAP_MAN_VLDCLR] =		0x88,
+	[PWRAP_WACS0_EN] =		0x8c,
+	[PWRAP_INIT_DONE0] =		0x90,
+	[PWRAP_WACS0_CMD] =		0xc00,
+	[PWRAP_WACS0_RDATA] =		0xc04,
+	[PWRAP_WACS0_VLDCLR] =		0xc08,
+	[PWRAP_WACS1_EN] =		0x94,
+	[PWRAP_INIT_DONE1] =		0x98,
+	[PWRAP_WACS2_EN] =		0x9c,
+	[PWRAP_INIT_DONE2] =		0xa0,
+	[PWRAP_WACS2_CMD] =		0xc20,
+	[PWRAP_WACS2_RDATA] =		0xc24,
+	[PWRAP_WACS2_VLDCLR] =		0xc28,
+	[PWRAP_INT_EN] =		0xb4,
+	[PWRAP_INT_FLG_RAW] =		0xb8,
+	[PWRAP_INT_FLG] =		0xbc,
+	[PWRAP_INT_CLR] =		0xc0,
+	[PWRAP_SIG_ADR] =		0xd4,
+	[PWRAP_SIG_MODE] =		0xd8,
+	[PWRAP_SIG_VALUE] =		0xdc,
+	[PWRAP_SIG_ERRVAL] =		0xe0,
+	[PWRAP_CRC_EN] =		0xe4,
+	[PWRAP_TIMER_EN] =		0xe8,
+	[PWRAP_TIMER_STA] =		0xec,
+	[PWRAP_WDT_UNIT] =		0xf0,
+	[PWRAP_WDT_SRC_EN] =		0xf4,
+	[PWRAP_WDT_FLG] =		0xfc,
+	[PWRAP_DEBUG_INT_SEL] =		0x104,
+	[PWRAP_CIPHER_KEY_SEL] =	0x1c4,
+	[PWRAP_CIPHER_IV_SEL] =		0x1c8,
+	[PWRAP_CIPHER_RDY] =		0x1d0,
+	[PWRAP_CIPHER_MODE] =		0x1d4,
+	[PWRAP_CIPHER_SWRST] =		0x1d8,
+	[PWRAP_DCM_EN] =		0x1dc,
+	[PWRAP_DCM_DBC_PRD] =		0x1e0,
+	[PWRAP_EINT_STA0_ADR] =		0x44,
+	[PWRAP_EINT_STA1_ADR] =		0x48,
+	[PWRAP_INT1_EN] =		0xc4,
+	[PWRAP_INT1_FLG] =		0xcc,
+	[PWRAP_INT1_CLR] =		0xd0,
+	[PWRAP_WDT_SRC_EN_1] =		0xf8,
+};
+
+enum pwrap_type {
+	PWRAP_MT8188,
+	PWRAP_MT8189,
+	PWRAP_MT8365,
+};
+
+struct pwrap_slv_type {
+	const u32 *dew_regs;
+	u32 caps;
+};
+
+struct pmic_wrapper {
+	struct udevice *dev;
+	void __iomem *base;
+	const struct pmic_wrapper_type *master;
+	const struct pwrap_slv_type *slave;
+	struct clk *clk_spi;
+	struct clk *clk_wrap;
+	struct clk *clk_wrap_sys;
+	struct clk *clk_wrap_tmr;
+};
+
+struct pmic_wrapper_type {
+	int *regs;
+	enum pwrap_type type;
+	u32 arb_en_all;
+	u32 int_en_all;
+	u32 int1_en_all;
+	u32 spi_w;
+	u32 wdt_src;
+	/* Flags indicating the capability for the target pwrap */
+	u32 caps;
+};
+
+static u32 pwrap_readl(struct pmic_wrapper *wrp, enum pwrap_regs reg)
+{
+	return readl(wrp->base + wrp->master->regs[reg]);
+}
+
+static void pwrap_writel(struct pmic_wrapper *wrp, u32 val, enum pwrap_regs reg)
+{
+	writel(val, wrp->base + wrp->master->regs[reg]);
+}
+
+static u32 pwrap_get_fsm_state(struct pmic_wrapper *wrp)
+{
+	u32 val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
+
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
+		return FIELD_GET(PWRAP_GET_WACS_ARB_FSM, val);
+
+	return FIELD_GET(PWRAP_GET_WACS_FSM, val);
+}
+
+static bool pwrap_is_fsm_idle(struct pmic_wrapper *wrp)
+{
+	return pwrap_get_fsm_state(wrp) == PWRAP_WACS_FSM_IDLE;
+}
+
+static bool pwrap_is_fsm_vldclr(struct pmic_wrapper *wrp)
+{
+	return pwrap_get_fsm_state(wrp) == PWRAP_WACS_FSM_WFVLDCLR;
+}
+
+/*
+ * Timeout issue sometimes caused by the last read command
+ * failed because pmic wrap could not got the FSM_VLDCLR
+ * in time after finishing WACS2_CMD. It made state machine
+ * still on FSM_VLDCLR and timeout next time.
+ * Check the status of FSM and clear the vldclr to recovery the
+ * error.
+ */
+static inline void pwrap_leave_fsm_vldclr(struct pmic_wrapper *wrp)
+{
+	if (pwrap_is_fsm_vldclr(wrp))
+		pwrap_writel(wrp, 1, PWRAP_WACS2_VLDCLR);
+}
+
+static bool pwrap_is_sync_idle(struct pmic_wrapper *wrp)
+{
+	return FIELD_GET(PWRAP_STATE_SYNC_IDLE0, pwrap_readl(wrp, PWRAP_WACS2_RDATA));
+}
+
+static bool pwrap_is_fsm_idle_and_sync_idle(struct pmic_wrapper *wrp)
+{
+	u32 val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
+
+	return FIELD_GET(PWRAP_GET_WACS_FSM, val) == PWRAP_WACS_FSM_IDLE &&
+	       FIELD_GET(PWRAP_STATE_SYNC_IDLE0, val);
+}
+
+static int pwrap_wait_for_state(struct pmic_wrapper *wrp, bool (*fp)(struct pmic_wrapper *))
+{
+	unsigned long timeout;
+
+	timeout = timer_get_us() + 10000;
+
+	do {
+		if (time_after(timer_get_us(), timeout))
+			return fp(wrp) ? 0 : -ETIMEDOUT;
+
+		if (fp(wrp))
+			return 0;
+	} while (1);
+}
+
+/* pwrap_read16 in linux kernel */
+static int pwrap_read(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
+{
+	int ret;
+	u32 val;
+
+	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
+	if (ret) {
+		pwrap_leave_fsm_vldclr(wrp);
+		return ret;
+	}
+
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
+		val = adr;
+	else
+		val = (adr >> 1) << 16;
+
+	pwrap_writel(wrp, val, PWRAP_WACS2_CMD);
+
+	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_vldclr);
+	if (ret)
+		return ret;
+
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
+		val = pwrap_readl(wrp, PWRAP_SWINF_2_RDATA_31_0);
+	else
+		val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
+
+	*rdata = FIELD_GET(PWRAP_GET_WACS_RDATA, val);
+
+	pwrap_writel(wrp, 1, PWRAP_WACS2_VLDCLR);
+
+	return 0;
+}
+
+/* pwrap_write16 in linux kernel */
+static int pwrap_write(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
+{
+	int ret;
+
+	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
+	if (ret) {
+		pwrap_leave_fsm_vldclr(wrp);
+		return ret;
+	}
+
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB)) {
+		pwrap_writel(wrp, wdata, PWRAP_SWINF_2_WDATA_31_0);
+		pwrap_writel(wrp, BIT(29) | adr, PWRAP_WACS2_CMD);
+	} else {
+		pwrap_writel(wrp, BIT(31) | ((adr >> 1) << 16) | wdata, PWRAP_WACS2_CMD);
+	}
+
+	return 0;
+}
+
+static int pwrap_reset_spislave(struct pmic_wrapper *wrp)
+{
+	int ret, i;
+
+	pwrap_writel(wrp, 0, PWRAP_HIPRIO_ARB_EN);
+	pwrap_writel(wrp, 0, PWRAP_WRAP_EN);
+	pwrap_writel(wrp, 1, PWRAP_MUX_SEL);
+	pwrap_writel(wrp, 1, PWRAP_MAN_EN);
+	pwrap_writel(wrp, 0, PWRAP_DIO_EN);
+
+	pwrap_writel(wrp, wrp->master->spi_w | PWRAP_MAN_CMD_OP_CSL, PWRAP_MAN_CMD);
+	pwrap_writel(wrp, wrp->master->spi_w | PWRAP_MAN_CMD_OP_OUTS, PWRAP_MAN_CMD);
+	pwrap_writel(wrp, wrp->master->spi_w | PWRAP_MAN_CMD_OP_CSH, PWRAP_MAN_CMD);
+
+	for (i = 0; i < 4; i++)
+		pwrap_writel(wrp, wrp->master->spi_w | PWRAP_MAN_CMD_OP_OUTS,
+			     PWRAP_MAN_CMD);
+
+	ret = pwrap_wait_for_state(wrp, pwrap_is_sync_idle);
+	if (ret) {
+		dev_err(wrp->dev, "%s fail, ret=%d\n", __func__, ret);
+		return ret;
+	}
+
+	pwrap_writel(wrp, 0, PWRAP_MAN_EN);
+	pwrap_writel(wrp, 0, PWRAP_MUX_SEL);
+
+	return 0;
+}
+
+/*
+ * pwrap_init_sidly - configure serial input delay
+ *
+ * This configures the serial input delay. We can configure 0, 2, 4 or 6ns
+ * delay. Do a read test with all possible values and chose the best delay.
+ */
+static int pwrap_init_sidly(struct pmic_wrapper *wrp)
+{
+	u32 rdata;
+	u32 i;
+	u32 pass = 0;
+	signed char dly[16] = {
+		-1, 0, 1, 0, 2, -1, 1, 1, 3, -1, -1, -1, 3, -1, 2, 1
+	};
+
+	for (i = 0; i < 4; i++) {
+		pwrap_writel(wrp, i, PWRAP_SIDLY);
+		pwrap_read(wrp, wrp->slave->dew_regs[PWRAP_DEW_READ_TEST], &rdata);
+		if (rdata == PWRAP_DEW_READ_TEST_VAL) {
+			dev_dbg(wrp->dev, "[Read Test] pass, SIDLY=%x\n", i);
+			pass |= 1 << i;
+		}
+	}
+
+	if (dly[pass] < 0) {
+		dev_err(wrp->dev, "sidly pass range 0x%x not continuous\n", pass);
+		return -EIO;
+	}
+
+	pwrap_writel(wrp, dly[pass], PWRAP_SIDLY);
+
+	return 0;
+}
+
+static int pwrap_init_dual_io(struct pmic_wrapper *wrp)
+{
+	int ret;
+	u32 rdata;
+
+	/* Enable dual IO mode */
+	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_DIO_EN], 1);
+
+	/* Check IDLE & INIT_DONE in advance */
+	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle_and_sync_idle);
+	if (ret) {
+		dev_err(wrp->dev, "%s fail, ret=%d\n", __func__, ret);
+		return ret;
+	}
+
+	pwrap_writel(wrp, 1, PWRAP_DIO_EN);
+
+	/* Read Test */
+	pwrap_read(wrp, wrp->slave->dew_regs[PWRAP_DEW_READ_TEST], &rdata);
+	if (rdata != PWRAP_DEW_READ_TEST_VAL) {
+		dev_err(wrp->dev, "Read failed on DIO mode: 0x%04x!=0x%04x\n",
+			PWRAP_DEW_READ_TEST_VAL, rdata);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int pwrap_init(struct pmic_wrapper *wrp)
+{
+	int ret;
+
+	/* Reset SPI slave */
+	if (HAS_CAP(wrp->slave->caps, PWRAP_SLV_CAP_SPI)) {
+		ret = pwrap_reset_spislave(wrp);
+		if (ret)
+			return ret;
+	}
+
+	pwrap_writel(wrp, 1, PWRAP_WRAP_EN);
+
+	pwrap_writel(wrp, wrp->master->arb_en_all, PWRAP_HIPRIO_ARB_EN);
+
+	pwrap_writel(wrp, 1, PWRAP_WACS2_EN);
+
+	/* Setup serial input delay */
+	if (HAS_CAP(wrp->slave->caps, PWRAP_SLV_CAP_SPI)) {
+		ret = pwrap_init_sidly(wrp);
+		if (ret)
+			return ret;
+	}
+
+	/* Enable dual I/O mode */
+	if (HAS_CAP(wrp->slave->caps, PWRAP_SLV_CAP_DUALIO)) {
+		ret = pwrap_init_dual_io(wrp);
+		if (ret)
+			return ret;
+	}
+
+	pwrap_writel(wrp, 0x1, PWRAP_WACS0_EN);
+	pwrap_writel(wrp, 0x1, PWRAP_WACS1_EN);
+	pwrap_writel(wrp, 0x1, PWRAP_WACS2_EN);
+	pwrap_writel(wrp, 0x5, PWRAP_STAUPD_PRD);
+	pwrap_writel(wrp, 0xff, PWRAP_STAUPD_GRPEN);
+
+	/* Setup the init done registers */
+	pwrap_writel(wrp, 1, PWRAP_INIT_DONE2);
+	pwrap_writel(wrp, 1, PWRAP_INIT_DONE0);
+	pwrap_writel(wrp, 1, PWRAP_INIT_DONE1);
+
+	return 0;
+}
+
+static const struct pwrap_slv_type pmic_mt6357 = {
+	.dew_regs = mt6357_regs,
+	.caps = 0,
+};
+
+static const struct pwrap_slv_type pmic_mt6359 = {
+	.dew_regs = mt6359_regs,
+	.caps = PWRAP_SLV_CAP_DUALIO,
+};
+
+static const struct udevice_id mtk_pmic_ids[] = {
+	{ .compatible = "mediatek,mt6357", .data = (ulong)&pmic_mt6357 },
+	{ .compatible = "mediatek,mt6359", .data = (ulong)&pmic_mt6359 },
+	{ }
+};
+
+static int mtk_pwrap_find_slave(const struct pwrap_slv_type **slave, ofnode pmic_node)
+{
+	const struct udevice_id *of_match = mtk_pmic_ids;
+	const char *pmic_name;
+
+	pmic_name = ofnode_get_property(pmic_node, "compatible", NULL);
+	if (!pmic_name) {
+		log_err("%s: missing compatible property\n", __func__);
+		return -EINVAL;
+	}
+
+	while (of_match->compatible) {
+		if (!strcmp(of_match->compatible, pmic_name)) {
+			*slave = (struct pwrap_slv_type *)of_match->data;
+			return 0;
+		}
+		of_match++;
+	}
+
+	return -ENOENT;
+}
+
+static int mtk_pwrap_probe(struct udevice *dev)
+{
+	struct pmic_wrapper *wrp = dev_get_priv(dev);
+	ofnode pmic_node;
+	u32 mask_done;
+	int ret;
+
+	wrp->dev = dev;
+
+	wrp->base = dev_remap_addr(dev);
+	if (IS_ERR(wrp->base))
+		return PTR_ERR(wrp->base);
+
+	wrp->master = (void *)dev_get_driver_data(dev);
+
+	pmic_node = dev_read_first_subnode(dev);
+	if (!ofnode_valid(pmic_node)) {
+		dev_err(dev, "pmic subnode not found\n");
+		return -ENXIO;
+	}
+
+	ret = mtk_pwrap_find_slave(&wrp->slave, pmic_node);
+	if (ret) {
+		dev_err(dev, "pmic slave not found\n");
+		return -EINVAL;
+	}
+
+	wrp->clk_spi = devm_clk_get(dev, "spi");
+	if (IS_ERR(wrp->clk_spi))
+		return PTR_ERR(wrp->clk_spi);
+
+	wrp->clk_wrap = devm_clk_get(dev, "wrap");
+	if (IS_ERR(wrp->clk_wrap))
+		return PTR_ERR(wrp->clk_wrap);
+
+	wrp->clk_wrap_sys = devm_clk_get_optional(dev, "wrap_sys");
+	wrp->clk_wrap_tmr = devm_clk_get_optional(dev, "wrap_tmr");
+
+	ret = clk_enable(wrp->clk_spi);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(wrp->clk_wrap);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(wrp->clk_wrap_sys);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(wrp->clk_wrap_tmr);
+	if (ret)
+		return ret;
+
+	/*
+	 * The PMIC could already be initialized by the bootloader.
+	 * Skip initialization here in this case.
+	 */
+	if (!pwrap_readl(wrp, PWRAP_INIT_DONE2)) {
+		ret = pwrap_init(wrp);
+		if (ret) {
+			dev_err(dev, "init failed with %d\n", ret);
+			return ret;
+		}
+	}
+
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
+		mask_done = PWRAP_STATE_INIT_DONE1;
+	else
+		mask_done = PWRAP_STATE_INIT_DONE0;
+
+	if (!(pwrap_readl(wrp, PWRAP_WACS2_RDATA) & mask_done)) {
+		dev_dbg(dev, "initialization isn't finished\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * Since STAUPD was not used on mt8173 platform,
+	 * so STAUPD of WDT_SRC which should be turned off
+	 */
+	pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN);
+
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_WDT_SRC1))
+		pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN_1);
+
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
+		pwrap_writel(wrp, 0x3, PWRAP_TIMER_EN);
+	else
+		pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
+
+	pwrap_writel(wrp, wrp->master->int_en_all, PWRAP_INT_EN);
+
+	/*
+	 * We add INT1 interrupt to handle starvation and request exception
+	 * If we support it, we should enable it here.
+	 */
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_INT1_EN))
+		pwrap_writel(wrp, wrp->master->int1_en_all, PWRAP_INT1_EN);
+
+	return 0;
+}
+
+static int mtk_pwrap_bind(struct udevice *dev)
+{
+	ofnode pmic_node, regulators_node;
+	int children;
+	const struct pmic_child_info *pmic_children_info;
+	struct pmic_wrapper_type *pw_type = (void *)dev_get_driver_data(dev);
+
+	pmic_node = dev_read_first_subnode(dev);
+	if (!ofnode_valid(pmic_node)) {
+		dev_err(dev, "pmic subnode not found\n");
+		return -ENXIO;
+	}
+
+	switch (pw_type->type) {
+	case PWRAP_MT8365:
+		pmic_children_info = mt6357_pmic_children_info;
+		break;
+	case PWRAP_MT8188:
+	case PWRAP_MT8189:
+		pmic_children_info = mt6359_pmic_children_info;
+		break;
+	default:
+		dev_err(dev, "pwrap type %d not supported\n", pw_type->type);
+		return -ENXIO;
+	}
+
+	regulators_node = ofnode_find_subnode(pmic_node, "regulators");
+	if (ofnode_valid(regulators_node)) {
+		children = pmic_bind_children(dev, regulators_node, pmic_children_info);
+		if (!children)
+			dev_dbg(dev, "no children found\n");
+	} else {
+		dev_dbg(dev, "regulators subnode not found\n");
+	}
+
+	return 0;
+}
+
+static int mtk_pwrap_reg_count(struct udevice *dev)
+{
+	return 0x8000;
+}
+
+static int mtk_pwrap_read(struct udevice *dev, uint reg, uint8_t *buf, int len)
+{
+	struct pmic_wrapper *wrp = dev_get_priv(dev);
+
+	if ((len * sizeof(uint8_t)) > sizeof(u32))
+		return -EINVAL;
+
+	return pwrap_read(wrp, reg, (u32 *)buf);
+}
+
+static int mtk_pwrap_write(struct udevice *dev, uint reg, const uint8_t *buf, int len)
+{
+	struct pmic_wrapper *wrp = dev_get_priv(dev);
+
+	if ((len * sizeof(uint8_t)) > sizeof(u32))
+		return -EINVAL;
+
+	return pwrap_write(wrp, reg, *(u32 *)buf);
+}
+
+static struct dm_pmic_ops mtk_pwrap_ops = {
+	.reg_count = mtk_pwrap_reg_count,
+	.read = mtk_pwrap_read,
+	.write = mtk_pwrap_write,
+};
+
+static struct pmic_wrapper_type pwrap_mt8188 = {
+	.regs = mt8188_regs,
+	.type = PWRAP_MT8188,
+	.arb_en_all = 0x777f,
+	.int_en_all = 0x180000,
+	.int1_en_all = 0x0,
+	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
+	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
+	.caps = PWRAP_CAP_INT1_EN | PWRAP_CAP_ARB,
+};
+
+static struct pmic_wrapper_type pwrap_mt8189 = {
+	.regs = mt8189_regs,
+	.type = PWRAP_MT8189,
+	.arb_en_all = 0x777f,
+	.int_en_all = 0x180000,
+	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
+	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
+	.caps = PWRAP_CAP_ARB,
+};
+
+static const struct pmic_wrapper_type pwrap_mt8365 = {
+	.regs = mt8365_regs,
+	.type = PWRAP_MT8365,
+	.arb_en_all = 0x3ffff,
+	.int_en_all = 0x7f1fffff,
+	.int1_en_all = 0x0,
+	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
+	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
+	.caps = PWRAP_CAP_INT1_EN | PWRAP_CAP_WDT_SRC1,
+};
+
+static const struct udevice_id mtk_pwrap_ids[] = {
+	{ .compatible = "mediatek,mt8188-pwrap", .data = (ulong)&pwrap_mt8188 },
+	{ .compatible = "mediatek,mt8189-pwrap", .data = (ulong)&pwrap_mt8189 },
+	{ .compatible = "mediatek,mt8365-pwrap", .data = (ulong)&pwrap_mt8365 },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_pwrap) = {
+	.name	   = "mtk_pwrap",
+	.id	   = UCLASS_PMIC,
+	.of_match  = mtk_pwrap_ids,
+	.bind	   = mtk_pwrap_bind,
+	.probe	   = mtk_pwrap_probe,
+	.ops	   = &mtk_pwrap_ops,
+	.priv_auto = sizeof(struct pmic_wrapper),
+};

-- 
2.43.0

