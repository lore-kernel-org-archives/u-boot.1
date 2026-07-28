Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A89C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 15:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7007240946;
	Tue, 28 Jul 2026 15:02:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kk95rGMnACrw; Tue, 28 Jul 2026 15:02:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F98440A07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785250949;
	bh=OKVs3yNhNgi8ZlMHkBe1bd0bbiPxfn4qtmwXW41PVe0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HrRmOaCkq6eXQzXvRNBhfhC3n8MxsTtMsa44EcxubMA8owDyaEpt29DADM6Ge8925
	 iwa6OuUKmOUo9lFZ4dYktSWvJOeC/67G2fDWMP2oFBfpPI4hF20yOfWReP53DuQEWX
	 02D1AkeItNLWJR+filDTe6cRnNDrFXc9mS70eVbpyAsS2gv2N+JuGYgsbPGhKFkgs8
	 BjRvnEMMzTOpDHrjQ1z417Kj26vwjrbFa85X9Y/6/K1SIuFG7QAGj4XQhQLl798ziN
	 Vmi5LTSnfqOpeJI1v3xFXPAJY/TAGA2WgvySn63hbSoZaZZc/ABigxe48+DvAxPS5z
	 mwAmWWnESxzWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F98440A07;
	Tue, 28 Jul 2026 15:02:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D2A684BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:02:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B8A8340A11
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:02:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rCYBw6Jozx-q for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 15:02:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 04B79409F4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 04B79409F4
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 04B79409F4
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:02:24 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so2679063f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 08:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785250942; x=1785855742;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OKVs3yNhNgi8ZlMHkBe1bd0bbiPxfn4qtmwXW41PVe0=;
 b=EsKHmc4vu+d0XJBJvGiz6fP+AoiY28G4rkyGPgzpS3SBcKDTFdFeVySPgsy0y7mVcl
 aMS9baFPuMXJtRGjDX5OBlTQ8pRfU2/tGI/Wv/+2jny1revVY9kbZ7Dq3FeD47x5C/aX
 idLhrRsyPExEYzeU7YsRRrGemB458YtHqJncMP5WW1ospzo3J8bmm9EF2Qqc6InSlsAZ
 snl3uMJ0SniSSayO8QSYX8DGfcTvAU67TaepixG8g7ye6K1yM8dB+ipih8KwtWLKo/uN
 iZy6uRxvT7M75wR1oeKmpqw49GHVoPZr6YIQI5LDuB1F9jM+sv4YWUrlqfyR5O6gYj7z
 liyg==
X-Gm-Message-State: AOJu0YzIbDf6LJvNAkDECbk5rlD3t5bYAo/O2za2uvSmwki22W03JJlj
 pvyRWcfRVxJvb75l/JCJ6UTn4Kq/zSY7WC9LBSyK4qRQj3J2sVgQXhjldWt58Lt0JYY=
X-Gm-Gg: AR+sD12f03Ev9whLR0UEo/OYrOcSSTO6LHR2HZh6s1fkFOYBgIWeVB5gAz6O1nyG7H2
 LJ6I97ULYmjpWlWuVcCBRGAwFOzMSZUZriPbfc6RDlu3g3Ihz1TZgDiKo2HCIbELCl1D0adkhow
 aAF/66H/bjTSaEyPECiLqYyfav0ynlKmr30JqvQczP38wCAx3qvbpcK2Vm/BxpzOpGKhNYyKXYy
 KEkIhzkZuPsE0/hsdqIN9+GjRmp52Lmpak8Q1ipPULfPQqMb9652P/W9oG3DKM+lBVkXs2lG1c0
 cDTilbZF2QrLo7YiD7uzccVbtl8k7UtwUn5Iyn0CWHEA70f+jLoeKHtNt8S18ib531T2Y6Xty9p
 IGqH7EexXieKP9Cj+e5VoY/qHahtJzW5oxfe4+HubKjgiI+efxSrMNA9BdrE/h9DthXKrwA87LD
 8D+m7ibUB9tAF08Ve4v3NVzBWIPxEneAJbIq/Q3LsBtsEUlx9TAjWcGz0GFUHC8wOANzQ8oTihy
 jvQqLwZz/YTD60y4C9E9YDga0rSgBi9rOWurwHh0zHrzj6ZwuFjsL/eYeDO2dM=
X-Received: by 2002:a05:6000:25c6:b0:47f:8b23:195f with SMTP id
 ffacd0b85a97d-47fb1eb9dbbmr3126053f8f.46.1785250942101; 
 Tue, 28 Jul 2026 08:02:22 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm59775363f8f.34.2026.07.28.08.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:02:21 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Jul 2026 17:01:56 +0200
Subject: [PATCH v2] phy: phy-mtk-hdmi: add new driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-mt8188-add-hdmi-phy-driver-v2-1-8b2893b151ba@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NSwrCMBQAr1Ky9kkT2iS48h7SRT6v5on9kNRgK
 b27bcWty4FhZmEJI2Fil2JhETMlGvoNxKlgLpj+jkB+YyZKIUvFJXST5lqD8R6C7wjGMIOPlDF
 CrUxZc0RpnGRbYIzY0vuI35ovp5d9oJv24m4EStMQ5+Oe+e79RurfKHPgUAmlq1q1KJy9WjM/y
 UY8u6FjzbquH8SRC5bZAAAA
X-Change-ID: 20260716-mt8188-add-hdmi-phy-driver-57a051ee6ac6
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785250942; x=1785855742;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OKVs3yNhNgi8ZlMHkBe1bd0bbiPxfn4qtmwXW41PVe0=;
 b=jWE1K9c8yHtFS6K8b1243mhbXucwdpZaGEUbogj8O4QRAKRQjciIAU0ZaHVBjezcyz
 0ap/3EkQHlF+Lc1C40jRqcLJDUaNgYsjWFPoNrryKiKPyFVwEva/cqO0osyKMqOER4YA
 IZqdnLsrQBn750a2xvB1npqyRB/dvkEE4v4x1KGTeKc5sLj7gi9NZj33kNfw8UQuzboS
 VKFL3/kd+MzaFi4kLzeV1in50uTk7qbd2WL8mheP5MZ6z+2B+y2k33RfhP9CC0xIFk/Q
 WS/dBe1TqVCVNYUw5pwWwwLXLMeAVDKjLnQ3vN0oyiZVE/YOjoiisef3Fr+swRV8xtQn
 4BkA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jWE1K9c8
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a new driver for the HDMI PHY. The driver supports MT8188 and MT8195
based SoCs. The driver is based on the corresponding kernel driver
(Commit 7a4ce5a9b674 - phy: mediatek: phy-mtk-hdmi-mt8195: convert from
round_rate() to determine_rate()).

Signed-off-by: Pavlo Yadvychuk <pyadvychuk@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
This series adds the HDMI phy driver for MT8188 and MT8195 based SoC
such as Genio-510 and Genio-700 EVK.

The driver is added based on the corresponding kernel driver (Commit
7a4ce5a9b674 - phy: mediatek: phy-mtk-hdmi-mt8195: convert from
round_rate() to determine_rate()) with a few minors adaptations for
u-boot:

 - The PLL is a clk_hw/clk_ops provider in Linux; here its prepare /
   unprepare / set_rate / determine_rate operations are exposed through
   the mtk_hdmi_phy_conf callbacks and driven directly from the PHY
   power/configure ops (no clk provider is registered).
 - The 5V output is a regulator in Linux; here it is a power_control()
   callback toggled from power_on()/power_off().
 - phy_configure() takes a pointer to an unsigned long link rate rather than a
   union phy_configure_opts.

The full HDMI support will be added later, as a separate series to ease
review.

Tested on Genio-700 EVK
---
Changes in v2:
- The initial version of this driver was polished from downstream proprietary code.
  As suggested by Mattijs, re-do it as a faithful port of the Linux driver
- Link to v1: https://patch.msgid.link/20260717-mt8188-add-hdmi-phy-driver-v1-1-4278457fe2cb@baylibre.com

To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Pavlo Yadvychuk <pyadvychuk@baylibre.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>
---
 drivers/phy/Kconfig               |  11 +
 drivers/phy/Makefile              |   1 +
 drivers/phy/phy-mtk-hdmi-mt8195.c | 489 ++++++++++++++++++++++++++++++++++++++
 drivers/phy/phy-mtk-hdmi-mt8195.h | 115 +++++++++
 drivers/phy/phy-mtk-hdmi.c        | 106 +++++++++
 drivers/phy/phy-mtk-hdmi.h        |  46 ++++
 drivers/phy/phy-mtk-io.h          |  46 ++++
 7 files changed, 814 insertions(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 89d84df96ae..ee5d380cff9 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -269,6 +269,17 @@ config PHY_EXYNOS_USBDRD
 	help
 	  Enable USB DRD PHY support for Exynos SoC series.
 
+config PHY_MTK_HDMI
+	bool "MediaTek HDMI-PHY Driver"
+	depends on PHY
+	depends on ARCH_MEDIATEK
+	depends on ARM64
+	depends on CLK
+	help
+	  Support for the HDMI TX PHY found on MediaTek SoCs such as the
+	  MT8188 and MT8195. The PHY provides the TMDS links and the pixel
+	  clock PLL to the HDMI TX controller.
+
 config PHY_MTK_TPHY
 	bool "MediaTek T-PHY Driver"
 	depends on PHY
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index e46c362878d..6ffb6ad80af 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_MT7620_USB_PHY) += mt7620-usb-phy.o
 obj-$(CONFIG_MT76X8_USB_PHY) += mt76x8-usb-phy.o
 obj-$(CONFIG_PHY_DA8XX_USB) += phy-da8xx-usb.o
 obj-$(CONFIG_PHY_EXYNOS_USBDRD) += phy-exynos-usbdrd.o
+obj-$(CONFIG_PHY_MTK_HDMI) += phy-mtk-hdmi.o phy-mtk-hdmi-mt8195.o
 obj-$(CONFIG_PHY_MTK_TPHY) += phy-mtk-tphy.o
 obj-$(CONFIG_PHY_MTK_UFS) += phy-mtk-ufs.o
 obj-$(CONFIG_PHY_MTK_XSPHY) += phy-mtk-xsphy.o
diff --git a/drivers/phy/phy-mtk-hdmi-mt8195.c b/drivers/phy/phy-mtk-hdmi-mt8195.c
new file mode 100644
index 00000000000..b6d8cde452a
--- /dev/null
+++ b/drivers/phy/phy-mtk-hdmi-mt8195.c
@@ -0,0 +1,489 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Copyright (c) 2026 BayLibre, SAS
+ */
+
+#include <dm/device_compat.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/log2.h>
+#include <linux/math64.h>
+#include <linux/types.h>
+#include <generic-phy.h>
+
+#include "phy-mtk-io.h"
+#include "phy-mtk-hdmi.h"
+#include "phy-mtk-hdmi-mt8195.h"
+
+/* linux/units.h is not available in U-Boot */
+#define MEGA 1000000UL
+#define GIGA 1000000000UL
+
+static void mtk_hdmi_ana_fifo_en(struct mtk_hdmi_phy *hdmi_phy)
+{
+	/* make data fifo writable for hdmi2.0 */
+	mtk_phy_set_bits(hdmi_phy->regs + HDMI_ANA_CTL, REG_ANA_HDMI20_FIFO_EN);
+}
+
+static void
+mtk_phy_tmds_clk_ratio(struct mtk_hdmi_phy *hdmi_phy, bool enable)
+{
+	void __iomem *regs = hdmi_phy->regs;
+
+	mtk_hdmi_ana_fifo_en(hdmi_phy);
+
+	/* HDMI 2.0 specification, 3.4Gbps <= TMDS Bit Rate <= 6G,
+	 * clock bit ratio 1:40, under 3.4Gbps, clock bit ratio 1:10
+	 */
+	if (enable)
+		mtk_phy_update_field(regs + HDMI20_CLK_CFG, REG_TXC_DIV, 3);
+	else
+		mtk_phy_clear_bits(regs + HDMI20_CLK_CFG, REG_TXC_DIV);
+}
+
+static void mtk_hdmi_pll_sel_src(struct mtk_hdmi_phy *hdmi_phy)
+{
+	void __iomem *regs = hdmi_phy->regs;
+
+	mtk_phy_clear_bits(regs + HDMI_CTL_3, REG_HDMITX_REF_XTAL_SEL);
+	mtk_phy_clear_bits(regs + HDMI_CTL_3, REG_HDMITX_REF_RESPLL_SEL);
+
+	/* DA_HDMITX21_REF_CK for TXPLL input source */
+	mtk_phy_clear_bits(regs + HDMI_1_CFG_10, RG_HDMITXPLL_REF_CK_SEL);
+}
+
+static void mtk_hdmi_pll_perf(struct mtk_hdmi_phy *hdmi_phy)
+{
+	void __iomem *regs = hdmi_phy->regs;
+
+	mtk_phy_set_bits(regs + HDMI_1_PLL_CFG_0, RG_HDMITXPLL_BP2);
+	mtk_phy_set_bits(regs + HDMI_1_PLL_CFG_2, RG_HDMITXPLL_BC);
+	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_2, RG_HDMITXPLL_IC, 0x1);
+	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_2, RG_HDMITXPLL_BR, 0x2);
+	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_2, RG_HDMITXPLL_IR, 0x2);
+	mtk_phy_set_bits(regs + HDMI_1_PLL_CFG_2, RG_HDMITXPLL_BP);
+	mtk_phy_clear_bits(regs + HDMI_1_PLL_CFG_0, RG_HDMITXPLL_IBAND_FIX_EN);
+	mtk_phy_clear_bits(regs + HDMI_1_PLL_CFG_1, RG_HDMITXPLL_RESERVE_BIT14);
+	mtk_phy_clear_bits(regs + HDMI_1_PLL_CFG_2, RG_HDMITXPLL_HIKVCO);
+	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_0, RG_HDMITXPLL_HREN, 0x1);
+	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_0, RG_HDMITXPLL_LVR_SEL, 0x1);
+	mtk_phy_set_bits(regs + HDMI_1_PLL_CFG_1, RG_HDMITXPLL_RESERVE_BIT12_11);
+	mtk_phy_set_bits(regs + HDMI_1_PLL_CFG_0, RG_HDMITXPLL_TCL_EN);
+}
+
+static int mtk_hdmi_pll_set_hw(struct mtk_hdmi_phy *hdmi_phy, u8 prediv,
+			       u8 fbkdiv_high,
+			       u32 fbkdiv_low,
+			       u8 fbkdiv_hs3, u8 posdiv1,
+			       u8 posdiv2, u8 txprediv,
+			       u8 txposdiv,
+			       u8 digital_div)
+{
+	u8 txposdiv_value;
+	u8 div3_ctrl_value;
+	u8 posdiv_vallue;
+	u8 div_ctrl_value;
+	u8 reserve_3_2_value;
+	u8 prediv_value;
+	u8 reserve13_value;
+	void __iomem *regs = hdmi_phy->regs;
+
+	mtk_hdmi_pll_sel_src(hdmi_phy);
+
+	mtk_hdmi_pll_perf(hdmi_phy);
+
+	mtk_phy_update_field(regs + HDMI_1_CFG_10, RG_HDMITX21_BIAS_PE_BG_VREF_SEL, 0x2);
+	mtk_phy_clear_bits(regs + HDMI_1_CFG_10, RG_HDMITX21_VREF_SEL);
+	mtk_phy_update_field(regs + HDMI_1_CFG_9, RG_HDMITX21_SLDO_VREF_SEL, 0x2);
+	mtk_phy_clear_bits(regs + HDMI_1_CFG_10, RG_HDMITX21_BIAS_PE_VREF_SELB);
+	mtk_phy_set_bits(regs + HDMI_1_CFG_3, RG_HDMITX21_SLDOLPF_EN);
+	mtk_phy_update_field(regs + HDMI_1_CFG_6, RG_HDMITX21_INTR_CAL, 0x11);
+	mtk_phy_set_bits(regs + HDMI_1_PLL_CFG_2, RG_HDMITXPLL_PWD);
+
+	/* TXPOSDIV */
+	txposdiv_value = ilog2(txposdiv);
+
+	mtk_phy_update_field(regs + HDMI_1_CFG_6, RG_HDMITX21_TX_POSDIV, txposdiv_value);
+	mtk_phy_set_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_TX_POSDIV_EN);
+	mtk_phy_clear_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_FRL_EN);
+
+	/* TXPREDIV */
+	switch (txprediv) {
+	case 2:
+		div3_ctrl_value = 0x0;
+		posdiv_vallue = 0x0;
+		break;
+	case 4:
+		div3_ctrl_value = 0x0;
+		posdiv_vallue = 0x1;
+		break;
+	case 6:
+		div3_ctrl_value = 0x1;
+		posdiv_vallue = 0x0;
+		break;
+	case 12:
+		div3_ctrl_value = 0x1;
+		posdiv_vallue = 0x1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_4, RG_HDMITXPLL_POSDIV_DIV3_CTRL, div3_ctrl_value);
+	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_4, RG_HDMITXPLL_POSDIV, posdiv_vallue);
+
+	/* POSDIV1 */
+	switch (posdiv1) {
+	case 5:
+		div_ctrl_value = 0x0;
+		break;
+	case 10:
+		div_ctrl_value = 0x1;
+		break;
+	case 12:
+		div_ctrl_value = 0x2;
+		break;
+	case 15:
+		div_ctrl_value = 0x3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_4, RG_HDMITXPLL_DIV_CTRL, div_ctrl_value);
+
+	/* DE add new setting */
+	mtk_phy_clear_bits(regs + HDMI_1_PLL_CFG_1, RG_HDMITXPLL_RESERVE_BIT14);
+
+	/* POSDIV2 */
+	switch (posdiv2) {
+	case 1:
+		reserve_3_2_value = 0x0;
+		break;
+	case 2:
+		reserve_3_2_value = 0x1;
+		break;
+	case 4:
+		reserve_3_2_value = 0x2;
+		break;
+	case 6:
+		reserve_3_2_value = 0x3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_1, RG_HDMITXPLL_RESERVE_BIT3_2, reserve_3_2_value);
+
+	/* DE add new setting */
+	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_1, RG_HDMITXPLL_RESERVE_BIT1_0, 0x2);
+
+	/* PREDIV */
+	prediv_value = ilog2(prediv);
+
+	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_4, RG_HDMITXPLL_PREDIV, prediv_value);
+
+	/* FBKDIV_HS3 */
+	reserve13_value = ilog2(fbkdiv_hs3);
+
+	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_1, RG_HDMITXPLL_RESERVE_BIT13, reserve13_value);
+
+	/* FBDIV */
+	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_4, RG_HDMITXPLL_FBKDIV_HIGH, fbkdiv_high);
+	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_3, RG_HDMITXPLL_FBKDIV_LOW, fbkdiv_low);
+
+	/* Digital DIVIDER */
+	mtk_phy_clear_bits(regs + HDMI_CTL_3, REG_PIXEL_CLOCK_SEL);
+
+	if (digital_div == 1) {
+		mtk_phy_clear_bits(regs + HDMI_CTL_3, REG_HDMITX_PIXEL_CLOCK);
+	} else {
+		mtk_phy_set_bits(regs + HDMI_CTL_3, REG_HDMITX_PIXEL_CLOCK);
+		mtk_phy_update_field(regs + HDMI_CTL_3, REG_HDMITXPLL_DIV, digital_div - 1);
+	}
+
+	return 0;
+}
+
+static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdmi_phy, unsigned long rate)
+{
+	u8 digital_div, txprediv, txposdiv, fbkdiv_high, posdiv1, posdiv2;
+	u64 tmds_clk, pixel_clk, da_hdmitx21_ref_ck, ns_hdmipll_ck, pcw;
+	u8 txpredivs[4] = { 2, 4, 6, 12 };
+	u32 fbkdiv_low;
+	int i;
+
+	pixel_clk = rate;
+	tmds_clk = pixel_clk;
+
+	if (tmds_clk < 25 * MEGA || tmds_clk > 594 * MEGA)
+		return -EINVAL;
+
+	if (tmds_clk >= 340 * MEGA)
+		hdmi_phy->tmds_over_340M = true;
+	else
+		hdmi_phy->tmds_over_340M = false;
+
+	/* in Hz */
+	da_hdmitx21_ref_ck = 26 * MEGA;
+
+	/*  TXPOSDIV stage treatment:
+	 *	0M  <  TMDS clk  < 54M		  /8
+	 *	54M <= TMDS clk  < 148.35M    /4
+	 *	148.35M <=TMDS clk < 296.7M   /2
+	 *	296.7 <=TMDS clk <= 594M	  /1
+	 */
+	if (tmds_clk < 54 * MEGA)
+		txposdiv = 8;
+	else if (tmds_clk >= 54 * MEGA && (tmds_clk * 100) < 14835 * MEGA)
+		txposdiv = 4;
+	else if ((tmds_clk * 100) >= 14835 * MEGA && (tmds_clk * 10) < 2967 * MEGA)
+		txposdiv = 2;
+	else if ((tmds_clk * 10) >= 2967 * MEGA && tmds_clk <= 594 * MEGA)
+		txposdiv = 1;
+	else
+		return -EINVAL;
+
+	/* calculate txprediv: can be 2, 4, 6, 12
+	 * ICO clk = 5*TMDS_CLK*TXPOSDIV*TXPREDIV
+	 * ICO clk constraint: 5G =< ICO clk <= 12G
+	 */
+	for (i = 0; i < ARRAY_SIZE(txpredivs); i++) {
+		ns_hdmipll_ck = 5 * tmds_clk * txposdiv * txpredivs[i];
+		if (ns_hdmipll_ck >= 5 * GIGA &&
+		    ns_hdmipll_ck <= 12 * GIGA)
+			break;
+	}
+	if (i == (ARRAY_SIZE(txpredivs) - 1) &&
+	    (ns_hdmipll_ck < 5 * GIGA || ns_hdmipll_ck > 12 * GIGA)) {
+		return -EINVAL;
+	}
+	if (i == ARRAY_SIZE(txpredivs))
+		return -EINVAL;
+
+	txprediv = txpredivs[i];
+
+	/* PCW calculation: FBKDIV
+	 * formula: pcw=(frequency_out*2^pcw_bit) / frequency_in / FBKDIV_HS3;
+	 * RG_HDMITXPLL_FBKDIV[32:0]:
+	 * [32,24] 9bit integer, [23,0]:24bit fraction
+	 */
+	pcw = div_u64(((u64)ns_hdmipll_ck) << PCW_DECIMAL_WIDTH,
+		      da_hdmitx21_ref_ck * PLL_FBKDIV_HS3);
+
+	if (pcw > GENMASK_ULL(32, 0))
+		return -EINVAL;
+
+	fbkdiv_high = FIELD_GET(GENMASK_ULL(63, 32), pcw);
+	fbkdiv_low = FIELD_GET(GENMASK(31, 0), pcw);
+
+	/* posdiv1:
+	 * posdiv1 stage treatment according to color_depth:
+	 * 24bit -> posdiv1 /10, 30bit -> posdiv1 /12.5,
+	 * 36bit -> posdiv1 /15, 48bit -> posdiv1 /10
+	 */
+	posdiv1 = 10;
+	posdiv2 = 1;
+
+	/* Digital clk divider, max /32 */
+	digital_div = div_u64(ns_hdmipll_ck, posdiv1 * posdiv2 * pixel_clk);
+	if (!(digital_div <= 32 && digital_div >= 1))
+		return -EINVAL;
+
+	return mtk_hdmi_pll_set_hw(hdmi_phy, PLL_PREDIV, fbkdiv_high, fbkdiv_low,
+			    PLL_FBKDIV_HS3, posdiv1, posdiv2, txprediv,
+			    txposdiv, digital_div);
+}
+
+static int mtk_hdmi_pll_drv_setting(struct mtk_hdmi_phy *hdmi_phy)
+{
+	void __iomem *regs = hdmi_phy->regs;
+	u8 data_channel_bias, clk_channel_bias;
+	u8 impedance, impedance_en;
+	u32 tmds_clk;
+	u32 pixel_clk = hdmi_phy->pll_rate;
+
+	tmds_clk = pixel_clk;
+
+	/* bias & impedance setting:
+	 * 3G < data rate <= 6G: enable impedance 100ohm,
+	 *      data channel bias 24mA, clock channel bias 20mA
+	 * pixel clk >= HD,  74.175MHZ <= pixel clk <= 300MHZ:
+	 *      enalbe impedance 100ohm
+	 *      data channel 20mA, clock channel 16mA
+	 * 27M =< pixel clk < 74.175: disable impedance
+	 *      data channel & clock channel bias 10mA
+	 */
+
+	/* 3G < data rate <= 6G, 300M < tmds rate <= 594M */
+	if (tmds_clk > 300 * MEGA && tmds_clk <= 594 * MEGA) {
+		data_channel_bias = 0x3c; /* 24mA */
+		clk_channel_bias = 0x34; /* 20mA */
+		impedance_en = 0xf;
+		impedance = 0x36; /* 100ohm */
+	} else if (((u64)pixel_clk * 1000) >= 74175 * MEGA && pixel_clk <= 300 * MEGA) {
+		data_channel_bias = 0x34; /* 20mA */
+		clk_channel_bias = 0x2c; /* 16mA */
+		impedance_en = 0xf;
+		impedance = 0x36; /* 100ohm */
+	} else if (pixel_clk >= 27 * MEGA && ((u64)pixel_clk * 1000) < 74175 * MEGA) {
+		data_channel_bias = 0x14; /* 10mA */
+		clk_channel_bias = 0x14; /* 10mA */
+		impedance_en = 0x0;
+		impedance = 0x0;
+	} else {
+		return -EINVAL;
+	}
+
+	/* bias */
+	mtk_phy_update_field(regs + HDMI_1_CFG_1, RG_HDMITX21_DRV_IBIAS_D0, data_channel_bias);
+	mtk_phy_update_field(regs + HDMI_1_CFG_1, RG_HDMITX21_DRV_IBIAS_D1, data_channel_bias);
+	mtk_phy_update_field(regs + HDMI_1_CFG_1, RG_HDMITX21_DRV_IBIAS_D2, data_channel_bias);
+	mtk_phy_update_field(regs + HDMI_1_CFG_0, RG_HDMITX21_DRV_IBIAS_CLK, clk_channel_bias);
+
+	/* impedance */
+	mtk_phy_update_field(regs + HDMI_1_CFG_0, RG_HDMITX21_DRV_IMP_EN, impedance_en);
+	mtk_phy_update_field(regs + HDMI_1_CFG_2, RG_HDMITX21_DRV_IMP_D0_EN1, impedance);
+	mtk_phy_update_field(regs + HDMI_1_CFG_2, RG_HDMITX21_DRV_IMP_D1_EN1, impedance);
+	mtk_phy_update_field(regs + HDMI_1_CFG_2, RG_HDMITX21_DRV_IMP_D2_EN1, impedance);
+	mtk_phy_update_field(regs + HDMI_1_CFG_2, RG_HDMITX21_DRV_IMP_CLK_EN1, impedance);
+
+	return 0;
+}
+
+static int mtk_hdmi_pll_prepare(struct mtk_hdmi_phy *hdmi_phy)
+{
+	void __iomem *regs = hdmi_phy->regs;
+
+	mtk_phy_set_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_TX_POSDIV_EN);
+
+	mtk_phy_set_bits(regs + HDMI_1_CFG_0, RG_HDMITX21_SER_EN);
+	mtk_phy_set_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_D0_DRV_OP_EN);
+	mtk_phy_set_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_D1_DRV_OP_EN);
+	mtk_phy_set_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_D2_DRV_OP_EN);
+	mtk_phy_set_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_CK_DRV_OP_EN);
+
+	mtk_phy_clear_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_FRL_D0_EN);
+	mtk_phy_clear_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_FRL_D1_EN);
+	mtk_phy_clear_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_FRL_D2_EN);
+	mtk_phy_clear_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_FRL_CK_EN);
+
+	mtk_hdmi_pll_drv_setting(hdmi_phy);
+
+	mtk_phy_clear_bits(regs + HDMI_1_CFG_10, RG_HDMITX21_BG_PWD);
+	mtk_phy_set_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_BIAS_EN);
+	mtk_phy_set_bits(regs + HDMI_1_CFG_3, RG_HDMITX21_CKLDO_EN);
+	mtk_phy_set_bits(regs + HDMI_1_CFG_3, RG_HDMITX21_SLDO_EN);
+
+	mtk_phy_set_bits(regs + HDMI_1_PLL_CFG_4, DA_HDMITXPLL_PWR_ON);
+	udelay(10);
+	mtk_phy_clear_bits(regs + HDMI_1_PLL_CFG_4, DA_HDMITXPLL_ISO_EN);
+	udelay(10);
+	mtk_phy_clear_bits(regs + HDMI_1_PLL_CFG_2, RG_HDMITXPLL_PWD);
+	udelay(50);
+	return 0;
+}
+
+static void mtk_hdmi_pll_unprepare(struct mtk_hdmi_phy *hdmi_phy)
+{
+	void __iomem *regs = hdmi_phy->regs;
+
+	mtk_phy_set_bits(regs + HDMI_1_CFG_10, RG_HDMITX21_BG_PWD);
+	mtk_phy_clear_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_BIAS_EN);
+	mtk_phy_clear_bits(regs + HDMI_1_CFG_3, RG_HDMITX21_CKLDO_EN);
+	mtk_phy_clear_bits(regs + HDMI_1_CFG_3, RG_HDMITX21_SLDO_EN);
+
+	mtk_phy_set_bits(regs + HDMI_1_PLL_CFG_2, RG_HDMITXPLL_PWD);
+	udelay(20);
+	mtk_phy_set_bits(regs + HDMI_1_PLL_CFG_4, DA_HDMITXPLL_ISO_EN);
+	udelay(20);
+	mtk_phy_clear_bits(regs + HDMI_1_PLL_CFG_4, DA_HDMITXPLL_PWR_ON);
+}
+
+static int mtk_hdmi_pll_set_rate(struct mtk_hdmi_phy *hdmi_phy,
+				 unsigned long rate)
+{
+	dev_dbg(hdmi_phy->dev, "%s: %lu Hz\n", __func__, rate);
+
+	return mtk_hdmi_pll_calc(hdmi_phy, rate);
+}
+
+static void mtk_hdmi_pll_determine_rate(struct mtk_hdmi_phy *hdmi_phy,
+					unsigned long rate)
+{
+	hdmi_phy->pll_rate = rate;
+}
+
+static void vtx_signal_en(struct mtk_hdmi_phy *hdmi_phy, bool on)
+{
+	void __iomem *regs = hdmi_phy->regs;
+
+	if (on)
+		mtk_phy_set_bits(regs + HDMI_1_CFG_0, RG_HDMITX21_DRV_EN);
+	else
+		mtk_phy_clear_bits(regs + HDMI_1_CFG_0, RG_HDMITX21_DRV_EN);
+}
+
+static void mtk_hdmi_phy_enable_tmds(struct mtk_hdmi_phy *hdmi_phy)
+{
+	vtx_signal_en(hdmi_phy, true);
+	udelay(150);
+}
+
+static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_phy *hdmi_phy)
+{
+	vtx_signal_en(hdmi_phy, false);
+}
+
+static int mtk_hdmi_phy_configure(struct phy *phy, void *opts)
+{
+	struct mtk_hdmi_phy *hdmi_phy = dev_get_priv(phy->dev);
+	unsigned long link_rate;
+	int ret;
+
+	if (!opts)
+		return -EINVAL;
+
+	link_rate = *(unsigned long *)opts;
+
+	/*
+	 * The kernel driver performs this through clk_set_rate() on the PLL
+	 * clock, which runs the determine_rate and set_rate clk_ops. U-Boot
+	 * does not register the PLL as a clock, so drive them directly.
+	 */
+	hdmi_phy->conf->pll_determine_rate(hdmi_phy, link_rate);
+
+	ret = hdmi_phy->conf->pll_set_rate(hdmi_phy, hdmi_phy->pll_rate);
+	if (ret)
+		return ret;
+
+	mtk_phy_tmds_clk_ratio(hdmi_phy, hdmi_phy->tmds_over_340M);
+
+	return ret;
+}
+
+/*
+ * The 5V output is modelled as a regulator in the Linux driver; U-Boot has no
+ * consumer for it, so it is exposed as a simple power_control() callback.
+ */
+static void mtk_hdmi_phy_power_control(struct mtk_hdmi_phy *hdmi_phy,
+				       bool enable)
+{
+	if (enable)
+		mtk_phy_set_bits(hdmi_phy->regs + HDMI_CTL_1, RG_HDMITX_PWR5V_O);
+	else
+		mtk_phy_clear_bits(hdmi_phy->regs + HDMI_CTL_1, RG_HDMITX_PWR5V_O);
+}
+
+const struct mtk_hdmi_phy_conf mtk_hdmi_phy_8195_conf = {
+	.pll_prepare = mtk_hdmi_pll_prepare,
+	.pll_unprepare = mtk_hdmi_pll_unprepare,
+	.pll_set_rate = mtk_hdmi_pll_set_rate,
+	.pll_determine_rate = mtk_hdmi_pll_determine_rate,
+	.hdmi_phy_enable_tmds = mtk_hdmi_phy_enable_tmds,
+	.hdmi_phy_disable_tmds = mtk_hdmi_phy_disable_tmds,
+	.hdmi_phy_configure = mtk_hdmi_phy_configure,
+	.power_control = mtk_hdmi_phy_power_control,
+};
diff --git a/drivers/phy/phy-mtk-hdmi-mt8195.h b/drivers/phy/phy-mtk-hdmi-mt8195.h
new file mode 100644
index 00000000000..6986f33caa3
--- /dev/null
+++ b/drivers/phy/phy-mtk-hdmi-mt8195.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Copyright (c) 2022 BayLibre, SAS
+ */
+
+#ifndef _MTK_HDMI_PHY_8195_H
+#define _MTK_HDMI_PHY_8195_H
+
+#include <linux/bitops.h>
+#include <linux/types.h>
+
+#define PCW_DECIMAL_WIDTH 24
+#define PLL_PREDIV 1
+#define PLL_FBKDIV_HS3 1
+
+#define HDMI20_CLK_CFG 0x70
+#define REG_TXC_DIV GENMASK(31, 30)
+
+#define HDMI_1_CFG_0 0x00
+#define RG_HDMITX21_DRV_IBIAS_CLK GENMASK(10, 5)
+#define RG_HDMITX21_DRV_IMP_EN GENMASK(23, 20)
+#define RG_HDMITX21_DRV_EN GENMASK(27, 24)
+#define RG_HDMITX21_SER_EN GENMASK(31, 28)
+
+#define HDMI_1_CFG_1 0x04
+#define RG_HDMITX21_DRV_IBIAS_D0 GENMASK(19, 14)
+#define RG_HDMITX21_DRV_IBIAS_D1 GENMASK(25, 20)
+#define RG_HDMITX21_DRV_IBIAS_D2 GENMASK(31, 26)
+
+#define HDMI_1_CFG_10 0x40
+#define RG_HDMITXPLL_REF_CK_SEL GENMASK(2, 1)
+#define RG_HDMITX21_VREF_SEL BIT(4)
+#define RG_HDMITX21_BIAS_PE_VREF_SELB BIT(10)
+#define RG_HDMITX21_BIAS_PE_BG_VREF_SEL GENMASK(16, 15)
+#define RG_HDMITX21_BG_PWD BIT(20)
+
+#define HDMI_1_CFG_2 0x08
+#define RG_HDMITX21_DRV_IMP_D0_EN1 GENMASK(13, 8)
+#define RG_HDMITX21_DRV_IMP_D1_EN1 GENMASK(19, 14)
+#define RG_HDMITX21_DRV_IMP_D2_EN1 GENMASK(25, 20)
+#define RG_HDMITX21_DRV_IMP_CLK_EN1 GENMASK(31, 26)
+
+#define HDMI_1_CFG_3 0x0c
+#define RG_HDMITX21_CKLDO_EN BIT(3)
+#define RG_HDMITX21_SLDOLPF_EN BIT(7)
+#define RG_HDMITX21_SLDO_EN GENMASK(11, 8)
+
+#define HDMI_1_CFG_6 0x18
+#define RG_HDMITX21_D2_DRV_OP_EN BIT(8)
+#define RG_HDMITX21_D1_DRV_OP_EN BIT(9)
+#define RG_HDMITX21_D0_DRV_OP_EN BIT(10)
+#define RG_HDMITX21_CK_DRV_OP_EN BIT(11)
+#define RG_HDMITX21_FRL_EN BIT(12)
+#define RG_HDMITX21_FRL_CK_EN BIT(13)
+#define RG_HDMITX21_FRL_D0_EN BIT(14)
+#define RG_HDMITX21_FRL_D1_EN BIT(15)
+#define RG_HDMITX21_FRL_D2_EN BIT(16)
+#define RG_HDMITX21_INTR_CAL GENMASK(22, 18)
+#define RG_HDMITX21_TX_POSDIV GENMASK(27, 26)
+#define RG_HDMITX21_TX_POSDIV_EN BIT(28)
+#define RG_HDMITX21_BIAS_EN BIT(29)
+
+#define HDMI_1_CFG_9 0x24
+#define RG_HDMITX21_SLDO_VREF_SEL GENMASK(5, 4)
+
+#define HDMI_1_PLL_CFG_0 0x44
+#define RG_HDMITXPLL_HREN GENMASK(13, 12)
+#define RG_HDMITXPLL_IBAND_FIX_EN BIT(24)
+#define RG_HDMITXPLL_LVR_SEL GENMASK(27, 26)
+#define RG_HDMITXPLL_BP2 BIT(30)
+#define RG_HDMITXPLL_TCL_EN BIT(31)
+
+#define HDMI_1_PLL_CFG_1 0x48
+#define RG_HDMITXPLL_RESERVE_BIT1_0 GENMASK(1, 0)
+#define RG_HDMITXPLL_RESERVE_BIT3_2 GENMASK(3, 2)
+#define RG_HDMITXPLL_RESERVE_BIT12_11 GENMASK(12, 11)
+#define RG_HDMITXPLL_RESERVE_BIT13 BIT(13)
+#define RG_HDMITXPLL_RESERVE_BIT14 BIT(14)
+
+#define HDMI_1_PLL_CFG_2 0x4c
+#define RG_HDMITXPLL_BC GENMASK(28, 27)
+#define RG_HDMITXPLL_IC GENMASK(26, 22)
+#define RG_HDMITXPLL_BR GENMASK(21, 19)
+#define RG_HDMITXPLL_IR GENMASK(18, 14)
+#define RG_HDMITXPLL_BP GENMASK(13, 10)
+#define RG_HDMITXPLL_HIKVCO BIT(29)
+#define RG_HDMITXPLL_PWD BIT(31)
+
+#define HDMI_1_PLL_CFG_3 0x50
+#define RG_HDMITXPLL_FBKDIV_LOW GENMASK(31, 0)
+
+#define HDMI_1_PLL_CFG_4 0x54
+#define DA_HDMITXPLL_ISO_EN BIT(1)
+#define DA_HDMITXPLL_PWR_ON BIT(2)
+#define RG_HDMITXPLL_POSDIV_DIV3_CTRL BIT(21)
+#define RG_HDMITXPLL_POSDIV GENMASK(23, 22)
+#define RG_HDMITXPLL_DIV_CTRL GENMASK(25, 24)
+#define RG_HDMITXPLL_PREDIV GENMASK(29, 28)
+#define RG_HDMITXPLL_FBKDIV_HIGH BIT(31)
+
+#define HDMI_ANA_CTL 0x7c
+#define REG_ANA_HDMI20_FIFO_EN BIT(16)
+
+#define HDMI_CTL_1 0xc4
+#define RG_HDMITX_PWR5V_O BIT(9)
+
+#define HDMI_CTL_3 0xcc
+#define REG_HDMITXPLL_DIV GENMASK(4, 0)
+#define REG_HDMITX_REF_XTAL_SEL BIT(7)
+#define REG_HDMITX_REF_RESPLL_SEL BIT(9)
+#define REG_PIXEL_CLOCK_SEL BIT(10)
+#define REG_HDMITX_PIXEL_CLOCK BIT(23)
+
+#endif /* MTK_HDMI_PHY_8195_H */
diff --git a/drivers/phy/phy-mtk-hdmi.c b/drivers/phy/phy-mtk-hdmi.c
new file mode 100644
index 00000000000..5be16fe3f43
--- /dev/null
+++ b/drivers/phy/phy-mtk-hdmi.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Copyright (c) 2026 BayLibre, SAS
+ * Author: Jie Qiu <jie.qiu@mediatek.com>
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+
+#include "phy-mtk-hdmi.h"
+
+static int mtk_hdmi_phy_power_on(struct phy *phy)
+{
+	struct mtk_hdmi_phy *hdmi_phy = dev_get_priv(phy->dev);
+	int ret;
+
+	/*
+	 * The 5V output is a regulator in the Linux driver, controlled by the
+	 * HDMI connector. U-Boot has no such consumer, so enable it here.
+	 */
+	if (hdmi_phy->conf->power_control)
+		hdmi_phy->conf->power_control(hdmi_phy, true);
+
+	/* Equivalent of clk_prepare_enable() on the kernel PLL clock. */
+	ret = hdmi_phy->conf->pll_prepare(hdmi_phy);
+	if (ret)
+		return ret;
+
+	hdmi_phy->conf->hdmi_phy_enable_tmds(hdmi_phy);
+
+	return 0;
+}
+
+static int mtk_hdmi_phy_power_off(struct phy *phy)
+{
+	struct mtk_hdmi_phy *hdmi_phy = dev_get_priv(phy->dev);
+
+	hdmi_phy->conf->hdmi_phy_disable_tmds(hdmi_phy);
+	hdmi_phy->conf->pll_unprepare(hdmi_phy);
+
+	if (hdmi_phy->conf->power_control)
+		hdmi_phy->conf->power_control(hdmi_phy, false);
+
+	return 0;
+}
+
+static int mtk_hdmi_phy_configure(struct phy *phy, void *opts)
+{
+	struct mtk_hdmi_phy *hdmi_phy = dev_get_priv(phy->dev);
+
+	if (hdmi_phy->conf->hdmi_phy_configure)
+		return hdmi_phy->conf->hdmi_phy_configure(phy, opts);
+
+	return 0;
+}
+
+static int mtk_hdmi_phy_probe(struct udevice *dev)
+{
+	struct mtk_hdmi_phy *hdmi_phy = dev_get_priv(dev);
+	int ret;
+
+	hdmi_phy->dev = dev;
+	hdmi_phy->conf =
+		(const struct mtk_hdmi_phy_conf *)dev_get_driver_data(dev);
+
+	hdmi_phy->regs = dev_read_addr_ptr(dev);
+	if (!hdmi_phy->regs)
+		return -EINVAL;
+
+	ret = clk_get_by_name(dev, "pll_ref", &hdmi_phy->pll_ref);
+	if (ret) {
+		dev_err(dev, "Failed to get PLL reference clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable(&hdmi_phy->pll_ref);
+	if (ret) {
+		dev_err(dev, "Failed to enable PLL reference clock: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct phy_ops mtk_hdmi_phy_ops = {
+	.power_on	= mtk_hdmi_phy_power_on,
+	.power_off	= mtk_hdmi_phy_power_off,
+	.configure	= mtk_hdmi_phy_configure,
+};
+
+static const struct udevice_id mtk_hdmi_phy_match[] = {
+	{ .compatible = "mediatek,mt8195-hdmi-phy",
+	  .data = (ulong)&mtk_hdmi_phy_8195_conf,
+	},
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(mtk_hdmi_phy) = {
+	.name		= "mtk-hdmi-phy",
+	.id		= UCLASS_PHY,
+	.of_match	= mtk_hdmi_phy_match,
+	.ops		= &mtk_hdmi_phy_ops,
+	.probe		= mtk_hdmi_phy_probe,
+	.priv_auto	= sizeof(struct mtk_hdmi_phy),
+};
diff --git a/drivers/phy/phy-mtk-hdmi.h b/drivers/phy/phy-mtk-hdmi.h
new file mode 100644
index 00000000000..f5ebf33b5b4
--- /dev/null
+++ b/drivers/phy/phy-mtk-hdmi.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Copyright (c) 2026 BayLibre, SAS
+ * Author: Chunhui Dai <chunhui.dai@mediatek.com>
+ */
+
+#ifndef _MTK_HDMI_PHY_H
+#define _MTK_HDMI_PHY_H
+
+#include <clk.h>
+#include <generic-phy.h>
+
+struct mtk_hdmi_phy;
+
+/*
+ * The Linux driver models the HDMI PLL as a clock provider (struct clk_hw /
+ * struct clk_ops) and the 5V output as a regulator. U-Boot has no consumer for
+ * either, so the PLL clk_ops are folded into the callbacks below (keeping the
+ * kernel prepare/unprepare/set_rate/determine_rate naming) and the 5V control
+ * is exposed as power_control(), driven directly from the PHY power ops.
+ */
+struct mtk_hdmi_phy_conf {
+	int (*pll_prepare)(struct mtk_hdmi_phy *hdmi_phy);
+	void (*pll_unprepare)(struct mtk_hdmi_phy *hdmi_phy);
+	int (*pll_set_rate)(struct mtk_hdmi_phy *hdmi_phy, unsigned long rate);
+	void (*pll_determine_rate)(struct mtk_hdmi_phy *hdmi_phy,
+				   unsigned long rate);
+	void (*hdmi_phy_enable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
+	void (*hdmi_phy_disable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
+	int (*hdmi_phy_configure)(struct phy *phy, void *opts);
+	void (*power_control)(struct mtk_hdmi_phy *hdmi_phy, bool enable);
+};
+
+struct mtk_hdmi_phy {
+	struct udevice *dev;
+	void __iomem *regs;
+	const struct mtk_hdmi_phy_conf *conf;
+	struct clk pll_ref;
+	unsigned long pll_rate;
+	bool tmds_over_340M;
+};
+
+extern const struct mtk_hdmi_phy_conf mtk_hdmi_phy_8195_conf;
+
+#endif /* _MTK_HDMI_PHY_H */
diff --git a/drivers/phy/phy-mtk-io.h b/drivers/phy/phy-mtk-io.h
new file mode 100644
index 00000000000..127cd705f17
--- /dev/null
+++ b/drivers/phy/phy-mtk-io.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021 MediaTek Inc.
+ *
+ * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
+ */
+
+#ifndef __PHY_MTK_H__
+#define __PHY_MTK_H__
+
+#include <asm/io.h>
+#include <linux/bitfield.h>
+
+static inline void mtk_phy_clear_bits(void __iomem *reg, u32 bits)
+{
+	u32 tmp = readl(reg);
+
+	tmp &= ~bits;
+	writel(tmp, reg);
+}
+
+static inline void mtk_phy_set_bits(void __iomem *reg, u32 bits)
+{
+	u32 tmp = readl(reg);
+
+	tmp |= bits;
+	writel(tmp, reg);
+}
+
+static inline void mtk_phy_update_bits(void __iomem *reg, u32 mask, u32 val)
+{
+	u32 tmp = readl(reg);
+
+	tmp &= ~mask;
+	tmp |= val & mask;
+	writel(tmp, reg);
+}
+
+/* field @mask shall be constant and continuous */
+#define mtk_phy_update_field(reg, mask, val) \
+({ \
+	BUILD_BUG_ON_MSG(!__builtin_constant_p(mask), "mask is not constant"); \
+	mtk_phy_update_bits(reg, mask, FIELD_PREP(mask, val)); \
+})
+
+#endif

---
base-commit: eab44c08cf01fefdec3d3ab919251e340444f116
change-id: 20260716-mt8188-add-hdmi-phy-driver-57a051ee6ac6

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

