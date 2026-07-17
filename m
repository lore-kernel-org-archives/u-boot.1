Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A4BC44514
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 08:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75A5484DAD;
	Fri, 17 Jul 2026 10:27:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Kde6kISM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1D7484DAA; Fri, 17 Jul 2026 10:27:01 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B75E984D68
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 10:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493bfe9f886so41714985e9.0
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 01:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784276818; x=1784881618; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ofdsPD3JvZKcUUya5Dg7Aw9sU3E9ZGHXyZRdDD7jUZ8=;
 b=Kde6kISMa5iT4uHDh2CWvN/wHGeCwXfWnCe0n/M5KrpPGnUz12iP+SxrqmKRs8etMD
 6SlXy8veLEgPTexp3yeAm0eusSLIHeU8JrPOv77BFf9IbjtKqNL8OVbbnD3sfYhVURrO
 3U/LbOQ+Z1IbmFVSDb5PRnX103Hi8Y9kpTc0x/tITAl/WEBfk2unVZ+WqwFS692fJoex
 mnVu066iRz4k271iTXOszYVTJbxym9fewOcxZ7HgISfopWMIy9L7aLMRKB3b6jX3HkVb
 s/wXKv96gzpmNiX1Rs7WVwm+HonJCJvJ1CQitfS6CvLuZeKikLYWz+/Z6fFB2QndrJEa
 w7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784276818; x=1784881618;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ofdsPD3JvZKcUUya5Dg7Aw9sU3E9ZGHXyZRdDD7jUZ8=;
 b=fScs4jRT2pC7YT/vUaVSVkyabxq1s7+tSU/CVJAmxKC5PUV/AZozH4LwpIj5PslZE9
 kVIYJ7F2b8TN0LB+/a8DpvuU/oruKW7BNskFNFuJCRXEwKsJiYe8ubc8JTnA1UUBNSFl
 8VkMAz42Aw2bgWTFu4nlmvMWMRlWzf44P8EWurCRJqi7c5v/OCjHdE9j4cgqZoQgtZrB
 Y11/e408X08gS9jO86iX0KEzfMN3MXwk7mak/p/ByduIfCNG5YpOkm51wZHgKyiv9jQn
 qkHTLMKfF+5yxqFGIyg2favAnkKMlvGKcuQcBcjuJDn1qIo4QQGB20z1D+ofUu8vpEip
 C99g==
X-Gm-Message-State: AOJu0YymWOW3t5StzHCGCb6JcB10EHdVAxNqw9mFFnzWFWpX7m1N01yp
 ZHQABd6XNdLtLM+Mq7vtSHckQqhtFTvOfIb0QQIXnywABtuJpvr9RsndFZaEFDsJjDo=
X-Gm-Gg: AfdE7cn770L3HziuR3AzUkGZ7EbpNCGEbWjkNWS4BLnY5e8V+o5npaJppbpYXlcSoyH
 xyZ+mu0qtEBoS9VDjTaNa4/RADkdq/Zbq7bPhtsu8vPk7GK1uKW7ujiz0/vbdgKBZr5eCuAqxFI
 kv31AHIBZl2rTi69Q+olLGLYNq05SH2XxaOMMhLymDyyw+iOa803Ui16BqYqdYolRDibge8bJOV
 7g04bFfkH5VsFsFFqQQmDjUy6iy1YO8KqgG8w/bYqhGjEoTZjg7aKnHIe0S0wj9QNejZm+hRJak
 JTMjXvFIS1C7PRYEeOi+/N2id3ynQrYiumEKgQt7ZTor6Mn/8+sQ+qxsBwXUOgUx41Sh9eOGM1A
 BGBolBp5CMp66B3RqkYpcDpHjI0RBXW/ttGPE0FzGyD7susYFUhFpLxbewKTuRgvg9QNjNdYCwq
 Edo5mHyAdGZg2+8pyo2tYv3pJVJMW+FPH28RU9PbH0J2LQwEhI7q502p5hnknO/qDcswybz1sAO
 6/tSbzZX8EYIrgeySdu+UmYaNogP/52V9EbbpJfoK+bpB3j/iH7hmWc61OYEmroPbeJDFI=
X-Received: by 2002:a05:600c:4585:b0:493:b87c:c87d with SMTP id
 5b1f17b1804b1-4954a3f3644mr16387815e9.11.1784276817865; 
 Fri, 17 Jul 2026 01:26:57 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549c9c940sm36693195e9.13.2026.07.17.01.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 01:26:56 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 17 Jul 2026 10:26:50 +0200
Subject: [PATCH] phy: phy-mtk-hdmi: add new driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-mt8188-add-hdmi-phy-driver-v1-1-4278457fe2cb@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQqDMAwA0F+RnA20grXsV4aHrolrBjpJnWyI/
 26nx3d5G2RW4Qy3agPlVbK8pwJbVxBTmJ6MQsXQmMaZzjocF2+9x0CEiUbBOf2QVFZWbLtgWsv
 sQnRQgll5kO+Z3/vL+fN4cVz+I+z7AUxjzZ1+AAAA
X-Change-ID: 20260716-mt8188-add-hdmi-phy-driver-57a051ee6ac6
To: u-boot@lists.denx.de
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
 Julien Stephan <jstephan@baylibre.com>
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

Add a new driver for the HDMI PHY. The driver supports MT8188 and MT8195
based SoCs. The driver is based on the corresponding kernel driver.

Signed-off-by: Pavlo Yadvychuk <pyadvychuk@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
This series adds the HDMI phy driver for MT8188 and MT8195 based SoC
such as Genio-510 and Genio-700 EVK.

The driver is added based on the corresponding kernel driver.

The full HDMI support will be added later, as a separate series to ease
review.

Tested on Genio-700 EVK
---
 drivers/phy/Kconfig               |  11 +
 drivers/phy/Makefile              |   1 +
 drivers/phy/phy-mtk-hdmi-mt8195.c | 889 ++++++++++++++++++++++++++++++++++++++
 drivers/phy/phy-mtk-hdmi.c        | 119 +++++
 drivers/phy/phy-mtk-hdmi.h        |  42 ++
 5 files changed, 1062 insertions(+)

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
index 00000000000..3422fb03d7c
--- /dev/null
+++ b/drivers/phy/phy-mtk-hdmi-mt8195.c
@@ -0,0 +1,889 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 MediaTek Inc.
+ * Copyright (c) 2026 BayLibre, SAS
+ */
+
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <linux/clk-provider.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <generic-phy.h>
+
+#include "phy-mtk-hdmi.h"
+
+#define DA_HDMITXPLL_ISO_EN BIT(1)
+#define DA_HDMITXPLL_ISO_EN_SHIFT (1)
+#define DA_HDMITXPLL_PWR_ON BIT(2)
+#define DA_HDMITXPLL_PWR_ON_SHIFT (2)
+
+#define HDMI20_CLK_CFG 0x70
+
+#define HDMI_1_CFG_0 0x00
+#define HDMI_1_CFG_1 0x04
+#define HDMI_1_CFG_10 0x40
+#define HDMI_1_CFG_2 0x08
+#define HDMI_1_CFG_21 0x84
+#define HDMI_1_CFG_22 0x88
+#define HDMI_1_CFG_3 0x0c
+#define HDMI_1_CFG_6 0x18
+#define HDMI_1_CFG_9 0x24
+#define HDMI_1_PLL_CFG_0 0x44
+#define HDMI_1_PLL_CFG_1 0x48
+#define HDMI_1_PLL_CFG_2 0x4c
+#define HDMI_1_PLL_CFG_3 0x50
+#define HDMI_1_PLL_CFG_4 0x54
+
+#define HDMI_ANA_CTL 0x7c
+
+#define HDMI_CTL_1 0xc4
+#define HDMI_CTL_3 0xcc
+
+#define RG_HDMITX_PWR5V_O BIT(9)
+#define RG_HDMITX_PWR5V_O_SHIFT (9)
+
+#define REG_ANA_HDMI20_FIFO_EN BIT(16)
+
+#define REG_HDMITXPLL_DIV GENMASK(4, 0)
+#define REG_HDMITXPLL_DIV_SHIFT (0)
+#define REG_HDMITX_PIXEL_CLOCK BIT(23)
+#define REG_HDMITX_PIXEL_CLOCK_SHIFT (23)
+#define REG_HDMITX_REF_RESPLL_SEL BIT(9)
+#define REG_HDMITX_REF_RESPLL_SEL_SHIFT (9)
+#define REG_HDMITX_REF_XTAL_SEL BIT(7)
+#define REG_HDMITX_REF_XTAL_SEL_SHIFT (7)
+
+#define REG_PIXEL_CLOCK_SEL BIT(10)
+#define REG_PIXEL_CLOCK_SEL_SHIFT (10)
+
+#define REG_TXC_DIV GENMASK(31, 30)
+#define REG_TXC_DIV_SHIFT (30)
+
+#define RG_HDMITX21_BG_PWD BIT(20)
+#define RG_HDMITX21_BG_PWD_SHIFT (20)
+
+#define RG_HDMITX21_BIAS_EN BIT(29)
+#define RG_HDMITX21_BIAS_EN_SHIFT (29)
+#define RG_HDMITX21_BIAS_PE_BG_VREF_SEL GENMASK(16, 15)
+#define RG_HDMITX21_BIAS_PE_BG_VREF_SEL_SHIFT (15)
+#define RG_HDMITX21_BIAS_PE_VREF_SELB GENMASK(10, 10)
+#define RG_HDMITX21_BIAS_PE_VREF_SELB_SHIFT (10)
+
+#define RG_HDMITX21_CKLDO_EN BIT(3)
+#define RG_HDMITX21_CKLDO_EN_SHIFT (3)
+
+#define RG_HDMITX21_CK_DRV_OP_EN BIT(11)
+#define RG_HDMITX21_CK_DRV_OP_EN_SHIFT (11)
+
+#define RG_HDMITX21_D0_DRV_OP_EN BIT(10)
+#define RG_HDMITX21_D0_DRV_OP_EN_SHIFT (10)
+
+#define RG_HDMITX21_D1_DRV_OP_EN BIT(9)
+#define RG_HDMITX21_D1_DRV_OP_EN_SHIFT (9)
+
+#define RG_HDMITX21_D2_DRV_OP_EN BIT(8)
+#define RG_HDMITX21_D2_DRV_OP_EN_SHIFT (8)
+
+#define RG_HDMITX21_DRV_EN GENMASK(27, 24)
+#define RG_HDMITX21_DRV_EN_SHIFT (24)
+#define RG_HDMITX21_DRV_IBIAS_CLK GENMASK(10, 5)
+#define RG_HDMITX21_DRV_IBIAS_CLK_SHIFT (5)
+#define RG_HDMITX21_DRV_IBIAS_D0 GENMASK(19, 14)
+#define RG_HDMITX21_DRV_IBIAS_D0_FFE1 GENMASK(21, 17)
+#define RG_HDMITX21_DRV_IBIAS_D0_FFE1_SHIFT (17)
+#define RG_HDMITX21_DRV_IBIAS_D0_FFE2 GENMASK(23, 20)
+#define RG_HDMITX21_DRV_IBIAS_D0_FFE2_SHIFT (20)
+#define RG_HDMITX21_DRV_IBIAS_D0_SHIFT (14)
+#define RG_HDMITX21_DRV_IBIAS_D1 GENMASK(25, 20)
+#define RG_HDMITX21_DRV_IBIAS_D1_FFE1 GENMASK(26, 22)
+#define RG_HDMITX21_DRV_IBIAS_D1_FFE1_SHIFT (22)
+#define RG_HDMITX21_DRV_IBIAS_D1_FFE2 GENMASK(27, 24)
+#define RG_HDMITX21_DRV_IBIAS_D1_FFE2_SHIFT (24)
+#define RG_HDMITX21_DRV_IBIAS_D1_SHIFT (20)
+#define RG_HDMITX21_DRV_IBIAS_D2 GENMASK(31, 26)
+#define RG_HDMITX21_DRV_IBIAS_D2_FFE1 GENMASK(31, 27)
+#define RG_HDMITX21_DRV_IBIAS_D2_FFE1_SHIFT (27)
+#define RG_HDMITX21_DRV_IBIAS_D2_FFE2 GENMASK(31, 28)
+#define RG_HDMITX21_DRV_IBIAS_D2_FFE2_SHIFT (28)
+#define RG_HDMITX21_DRV_IBIAS_D2_SHIFT (26)
+#define RG_HDMITX21_DRV_IMP_CLK_EN1 GENMASK(31, 26)
+#define RG_HDMITX21_DRV_IMP_CLK_EN1_SHIFT (26)
+#define RG_HDMITX21_DRV_IMP_D0_EN1 GENMASK(13, 8)
+#define RG_HDMITX21_DRV_IMP_D0_EN1_SHIFT (8)
+#define RG_HDMITX21_DRV_IMP_D1_EN1 GENMASK(19, 14)
+#define RG_HDMITX21_DRV_IMP_D1_EN1_SHIFT (14)
+#define RG_HDMITX21_DRV_IMP_D2_EN1 GENMASK(25, 20)
+#define RG_HDMITX21_DRV_IMP_D2_EN1_SHIFT (20)
+#define RG_HDMITX21_DRV_IMP_EN GENMASK(23, 20)
+#define RG_HDMITX21_DRV_IMP_EN_SHIFT (20)
+
+#define RG_HDMITX21_FRL_CK_EN BIT(13)
+#define RG_HDMITX21_FRL_CK_EN_SHIFT (13)
+#define RG_HDMITX21_FRL_D0_EN BIT(14)
+#define RG_HDMITX21_FRL_D0_EN_SHIFT (14)
+#define RG_HDMITX21_FRL_D1_EN BIT(15)
+#define RG_HDMITX21_FRL_D1_EN_SHIFT (15)
+#define RG_HDMITX21_FRL_D2_EN BIT(16)
+#define RG_HDMITX21_FRL_D2_EN_SHIFT (16)
+#define RG_HDMITX21_FRL_EN BIT(12)
+#define RG_HDMITX21_FRL_EN_SHIFT (12)
+
+#define RG_HDMITX21_INTR_CAL GENMASK(22, 18)
+#define RG_HDMITX21_INTR_CAL_READOUT GENMASK(22, 18)
+#define RG_HDMITX21_INTR_CAL_READOUT_SHIFT (18)
+#define RG_HDMITX21_INTR_CAL_SHIFT (18)
+
+#define RG_HDMITX21_SER_EN GENMASK(31, 28)
+#define RG_HDMITX21_SER_EN_SHIFT (28)
+
+#define RG_HDMITX21_SLDOLPF_EN BIT(7)
+#define RG_HDMITX21_SLDOLPF_EN_SHIFT (7)
+#define RG_HDMITX21_SLDO_EN GENMASK(11, 8)
+#define RG_HDMITX21_SLDO_EN_SHIFT (8)
+#define RG_HDMITX21_SLDO_VREF_SEL GENMASK(5, 4)
+#define RG_HDMITX21_SLDO_VREF_SEL_SHIFT (4)
+
+#define RG_HDMITX21_TX_POSDIV GENMASK(27, 26)
+#define RG_HDMITX21_TX_POSDIV_EN GENMASK(28, 28)
+#define RG_HDMITX21_TX_POSDIV_EN_SHIFT (28)
+#define RG_HDMITX21_TX_POSDIV_SHIFT (26)
+
+#define RG_HDMITX21_VREF_SEL BIT(4)
+#define RG_HDMITX21_VREF_SEL_SHIFT (4)
+
+#define RG_HDMITXPLL_BC GENMASK(28, 27)
+#define RG_HDMITXPLL_BC_SHIFT (27)
+#define RG_HDMITXPLL_BP GENMASK(13, 10)
+#define RG_HDMITXPLL_BP2 BIT(30)
+#define RG_HDMITXPLL_BP2_SHIFT (30)
+#define RG_HDMITXPLL_BP_SHIFT (10)
+#define RG_HDMITXPLL_BR GENMASK(21, 19)
+#define RG_HDMITXPLL_BR_SHIFT (19)
+#define RG_HDMITXPLL_DIV_CTRL GENMASK(25, 24)
+#define RG_HDMITXPLL_DIV_CTRL_SHIFT (24)
+#define RG_HDMITXPLL_FBKDIV_HIGH BIT(31)
+#define RG_HDMITXPLL_FBKDIV_HIGH_SHIFT (31)
+#define RG_HDMITXPLL_FBKDIV_LOW (0xffffffff)
+#define RG_HDMITXPLL_FBKDIV_LOW_SHIFT (0)
+#define RG_HDMITXPLL_HIKVCO GENMASK(29, 29)
+#define RG_HDMITXPLL_HIKVCO_SHIFT (29)
+#define RG_HDMITXPLL_HREN GENMASK(13, 12)
+#define RG_HDMITXPLL_HREN_SHIFT (12)
+#define RG_HDMITXPLL_IBAND_FIX_EN GENMASK(24, 24)
+#define RG_HDMITXPLL_IBAND_FIX_EN_SHIFT (24)
+#define RG_HDMITXPLL_IC GENMASK(26, 22)
+#define RG_HDMITXPLL_IC_SHIFT (22)
+#define RG_HDMITXPLL_IR GENMASK(18, 14)
+#define RG_HDMITXPLL_IR_SHIFT (14)
+#define RG_HDMITXPLL_LVR_SEL GENMASK(27, 26)
+#define RG_HDMITXPLL_LVR_SEL_SHIFT (26)
+#define RG_HDMITXPLL_POSDIV GENMASK(23, 22)
+#define RG_HDMITXPLL_POSDIV_DIV3_CTRL BIT(21)
+#define RG_HDMITXPLL_POSDIV_DIV3_CTRL_SHIFT (21)
+#define RG_HDMITXPLL_POSDIV_SHIFT (22)
+#define RG_HDMITXPLL_PREDIV GENMASK(29, 28)
+#define RG_HDMITXPLL_PREDIV_SHIFT (28)
+#define RG_HDMITXPLL_PWD BIT(31)
+#define RG_HDMITXPLL_PWD_SHIFT (31)
+#define RG_HDMITXPLL_REF_CK_SEL GENMASK(2, 1)
+#define RG_HDMITXPLL_REF_CK_SEL_SHIFT (1)
+#define RG_HDMITXPLL_RESERVE GENMASK(15, 0)
+#define RG_HDMITXPLL_RESERVE_BIT12_11 GENMASK(12, 11)
+#define RG_HDMITXPLL_RESERVE_BIT12_11_SHIFT (11)
+#define RG_HDMITXPLL_RESERVE_BIT13 BIT(13)
+#define RG_HDMITXPLL_RESERVE_BIT13_SHIFT (13)
+#define RG_HDMITXPLL_RESERVE_BIT14 BIT(14)
+#define RG_HDMITXPLL_RESERVE_BIT14_SHIFT (14)
+#define RG_HDMITXPLL_RESERVE_BIT1_0 GENMASK(1, 0)
+#define RG_HDMITXPLL_RESERVE_BIT1_0_SHIFT (0)
+#define RG_HDMITXPLL_RESERVE_BIT3_2 GENMASK(3, 2)
+#define RG_HDMITXPLL_RESERVE_BIT3_2_SHIFT (2)
+#define RG_HDMITXPLL_RESERVE_SHIFT (0)
+#define RG_HDMITXPLL_TCL_EN BIT(31)
+#define RG_HDMITXPLL_TCL_EN_SHIFT (31)
+
+#define RG_INTR_IMP_RG_MODE GENMASK(7, 3)
+#define RG_INTR_IMP_RG_MODE_SHIFT (3)
+
+static void mtk_hdmi_ana_fifo_en(struct mtk_hdmi_phy *hdmi_phy)
+{
+	/* make data fifo writable for hdmi2.0 */
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_ANA_CTL, REG_ANA_HDMI20_FIFO_EN,
+			  REG_ANA_HDMI20_FIFO_EN);
+}
+
+static void
+mtk_mt8195_phy_tmds_high_bit_clk_ratio(struct mtk_hdmi_phy *hdmi_phy,
+				       bool enable)
+{
+	mtk_hdmi_ana_fifo_en(hdmi_phy);
+
+	/* HDMI 2.0 specification, 3.4Gbps <= TMDS Bit Rate <= 6G,
+	 * clock bit ratio 1:40, under 3.4Gbps, clock bit ratio 1:10
+	 */
+	if (enable)
+		mtk_hdmi_phy_mask(hdmi_phy, HDMI20_CLK_CFG,
+				  0x2 << REG_TXC_DIV_SHIFT, REG_TXC_DIV);
+	else
+		mtk_hdmi_phy_mask(hdmi_phy, HDMI20_CLK_CFG, 0, REG_TXC_DIV);
+}
+
+static void mtk_hdmi_pll_select_source(struct mtk_hdmi_phy *hdmi_phy)
+{
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CTL_3, 0x0, REG_HDMITX_REF_XTAL_SEL);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CTL_3, 0x0, REG_HDMITX_REF_RESPLL_SEL);
+
+	/* DA_HDMITX21_REF_CK for TXPLL input source */
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_10, 0x0,
+			  RG_HDMITXPLL_REF_CK_SEL);
+}
+
+static int mtk_hdmi_pll_performance_setting(struct mtk_hdmi_phy *hdmi_phy)
+{
+	/* BP2 */
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_0,
+			  0x1 << RG_HDMITXPLL_BP2_SHIFT, RG_HDMITXPLL_BP2);
+
+	/* BC */
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_2,
+			  0x3 << RG_HDMITXPLL_BC_SHIFT, RG_HDMITXPLL_BC);
+
+	/* IC */
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_2,
+			  0x1 << RG_HDMITXPLL_IC_SHIFT, RG_HDMITXPLL_IC);
+
+	/* BR */
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_2,
+			  0x2 << RG_HDMITXPLL_BR_SHIFT, RG_HDMITXPLL_BR);
+
+	/* IR */
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_2,
+			  0x2 << RG_HDMITXPLL_IR_SHIFT, RG_HDMITXPLL_IR);
+
+	/* BP */
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_2,
+			  0xf << RG_HDMITXPLL_BP_SHIFT, RG_HDMITXPLL_BP);
+
+	/* IBAND_FIX_EN, RESERVE[14] */
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_0,
+			  0x0 << RG_HDMITXPLL_IBAND_FIX_EN_SHIFT,
+			  RG_HDMITXPLL_IBAND_FIX_EN);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_1,
+			  0x0 << RG_HDMITXPLL_RESERVE_BIT14_SHIFT,
+			  RG_HDMITXPLL_RESERVE_BIT14);
+
+	/* HIKVCO */
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_2,
+			  0x0 << RG_HDMITXPLL_HIKVCO_SHIFT,
+			  RG_HDMITXPLL_HIKVCO);
+
+	/* HREN */
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_0,
+			  0x1 << RG_HDMITXPLL_HREN_SHIFT, RG_HDMITXPLL_HREN);
+
+	/* LVR_SEL */
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_0,
+			  0x1 << RG_HDMITXPLL_LVR_SEL_SHIFT,
+			  RG_HDMITXPLL_LVR_SEL);
+
+	/* RG_HDMITXPLL_RESERVE[12:11] */
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_1,
+			  0x3 << RG_HDMITXPLL_RESERVE_BIT12_11_SHIFT,
+			  RG_HDMITXPLL_RESERVE_BIT12_11);
+
+	/* TCL_EN */
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_0,
+			  0x1 << RG_HDMITXPLL_TCL_EN_SHIFT,
+			  RG_HDMITXPLL_TCL_EN);
+
+	/* we should always read calibration impedance
+	 * from efuse, unless for debugging purposes.
+	 * This calibraion value is not board-dependent
+	 * so no SW adjustment required.
+	 */
+	if (hdmi_phy->conf->efuse_sw_mode) {
+		debug("efuse_sw_mode ENABLED!!!");
+		mtk_hdmi_phy_mask(hdmi_phy, HDMI_CTL_1,
+				  0x1f << RG_INTR_IMP_RG_MODE_SHIFT,
+				  RG_INTR_IMP_RG_MODE);
+	}
+
+	return 0;
+}
+
+static int mtk_hdmi_pll_set_hw(struct mtk_hdmi_phy *hdmi_phy,
+			       unsigned char prediv, unsigned char fbkdiv_high,
+			       unsigned long fbkdiv_low, unsigned char fbkdiv_hs3,
+			       unsigned char posdiv1, unsigned char posdiv2,
+			       unsigned char txprediv, unsigned char txposdiv,
+			       unsigned char digital_div)
+{
+	unsigned char txposdiv_value = 0;
+	unsigned char div3_ctrl_value = 0;
+	unsigned char posdiv_value = 0;
+	unsigned char div_ctrl_value = 0;
+	unsigned char reserve_3_2_value = 0;
+	unsigned char prediv_value = 0;
+	unsigned char reserve13_value = 0;
+
+	mtk_hdmi_pll_select_source(hdmi_phy);
+
+	mtk_hdmi_pll_performance_setting(hdmi_phy);
+
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_10,
+			  0x2 << RG_HDMITX21_BIAS_PE_BG_VREF_SEL_SHIFT,
+			  RG_HDMITX21_BIAS_PE_BG_VREF_SEL);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_10,
+			  0x0 << RG_HDMITX21_VREF_SEL_SHIFT,
+			  RG_HDMITX21_VREF_SEL);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_9,
+			  0x2 << RG_HDMITX21_SLDO_VREF_SEL_SHIFT,
+			  RG_HDMITX21_SLDO_VREF_SEL);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_10,
+			  0x0 << RG_HDMITX21_BIAS_PE_VREF_SELB_SHIFT,
+			  RG_HDMITX21_BIAS_PE_VREF_SELB);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_3,
+			  0x1 << RG_HDMITX21_SLDOLPF_EN_SHIFT,
+			  RG_HDMITX21_SLDOLPF_EN);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_6,
+			  0x11 << RG_HDMITX21_INTR_CAL_SHIFT,
+			  RG_HDMITX21_INTR_CAL);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_2,
+			  0x1 << RG_HDMITXPLL_PWD_SHIFT, RG_HDMITXPLL_PWD);
+
+	/* TXPOSDIV */
+	if (txposdiv == 1)
+		txposdiv_value = 0x0;
+	else if (txposdiv == 2)
+		txposdiv_value = 0x1;
+	else if (txposdiv == 4)
+		txposdiv_value = 0x2;
+	else if (txposdiv == 8)
+		txposdiv_value = 0x3;
+	else
+		return -EINVAL;
+
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_6,
+			  txposdiv_value << RG_HDMITX21_TX_POSDIV_SHIFT,
+			  RG_HDMITX21_TX_POSDIV);
+
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_6,
+			  0x1 << RG_HDMITX21_TX_POSDIV_EN_SHIFT,
+			  RG_HDMITX21_TX_POSDIV_EN);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_6,
+			  0x0 << RG_HDMITX21_FRL_EN_SHIFT, RG_HDMITX21_FRL_EN);
+
+	/* TXPREDIV */
+	if (txprediv == 2) {
+		div3_ctrl_value = 0x0;
+		posdiv_value = 0x0;
+	} else if (txprediv == 4) {
+		div3_ctrl_value = 0x0;
+		posdiv_value = 0x1;
+	} else if (txprediv == 6) {
+		div3_ctrl_value = 0x1;
+		posdiv_value = 0x0;
+	} else if (txprediv == 12) {
+		div3_ctrl_value = 0x1;
+		posdiv_value = 0x1;
+	} else {
+		return -EINVAL;
+	}
+
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_4,
+			  div3_ctrl_value
+				  << RG_HDMITXPLL_POSDIV_DIV3_CTRL_SHIFT,
+			  RG_HDMITXPLL_POSDIV_DIV3_CTRL);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_4,
+			  posdiv_value << RG_HDMITXPLL_POSDIV_SHIFT,
+			  RG_HDMITXPLL_POSDIV);
+
+	/* POSDIV1 */
+	if (posdiv1 == 5)
+		div_ctrl_value = 0x0;
+	else if (posdiv1 == 10)
+		div_ctrl_value = 0x1;
+	else if (posdiv1 == (125 / 10))
+		div_ctrl_value = 0x2;
+	else if (posdiv1 == 15)
+		div_ctrl_value = 0x3;
+	else
+		return -EINVAL;
+
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_4,
+			  div_ctrl_value << RG_HDMITXPLL_DIV_CTRL_SHIFT,
+			  RG_HDMITXPLL_DIV_CTRL);
+
+	/* DE add new setting */
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_1,
+			  0x0 << RG_HDMITXPLL_RESERVE_BIT14_SHIFT,
+			  RG_HDMITXPLL_RESERVE_BIT14);
+
+	/* POSDIV2 */
+	if (posdiv2 == 1)
+		reserve_3_2_value = 0x0;
+	else if (posdiv2 == 2)
+		reserve_3_2_value = 0x1;
+	else if (posdiv2 == 4)
+		reserve_3_2_value = 0x2;
+	else if (posdiv2 == 6)
+		reserve_3_2_value = 0x3;
+	else
+		return -EINVAL;
+
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_1,
+			  reserve_3_2_value
+				  << RG_HDMITXPLL_RESERVE_BIT3_2_SHIFT,
+			  RG_HDMITXPLL_RESERVE_BIT3_2);
+
+	/* DE add new setting */
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_1,
+			  0x2 << RG_HDMITXPLL_RESERVE_BIT1_0_SHIFT,
+			  RG_HDMITXPLL_RESERVE_BIT1_0);
+
+	/* PREDIV */
+	if (prediv == 1)
+		prediv_value = 0x0;
+	else if (prediv == 2)
+		prediv_value = 0x1;
+	else if (prediv == 4)
+		prediv_value = 0x2;
+	else
+		return -EINVAL;
+
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_4,
+			  prediv_value << RG_HDMITXPLL_PREDIV_SHIFT,
+			  RG_HDMITXPLL_PREDIV);
+
+	/* FBKDIV_HS3 */
+	if (fbkdiv_hs3 == 1)
+		reserve13_value = 0x0;
+	else if (fbkdiv_hs3 == 2)
+		reserve13_value = 0x1;
+	else
+		return -EINVAL;
+
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_1,
+			  reserve13_value << RG_HDMITXPLL_RESERVE_BIT13_SHIFT,
+			  RG_HDMITXPLL_RESERVE_BIT13);
+
+	/* FBDIV */
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_4,
+			  fbkdiv_high << RG_HDMITXPLL_FBKDIV_HIGH_SHIFT,
+			  RG_HDMITXPLL_FBKDIV_HIGH);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_3,
+			  fbkdiv_low << RG_HDMITXPLL_FBKDIV_LOW_SHIFT,
+			  RG_HDMITXPLL_FBKDIV_LOW);
+
+	/* Digital DIVIDER */
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CTL_3,
+			  0x0 << REG_PIXEL_CLOCK_SEL_SHIFT,
+			  REG_PIXEL_CLOCK_SEL);
+
+	if (digital_div == 1) {
+		mtk_hdmi_phy_mask(hdmi_phy, HDMI_CTL_3,
+				  0x0 << REG_HDMITX_PIXEL_CLOCK_SHIFT,
+				  REG_HDMITX_PIXEL_CLOCK);
+	} else {
+		mtk_hdmi_phy_mask(hdmi_phy, HDMI_CTL_3,
+				  0x1 << REG_HDMITX_PIXEL_CLOCK_SHIFT,
+				  REG_HDMITX_PIXEL_CLOCK);
+		mtk_hdmi_phy_mask(hdmi_phy, HDMI_CTL_3,
+				  (digital_div - 1) << REG_HDMITXPLL_DIV_SHIFT,
+				  REG_HDMITXPLL_DIV);
+	}
+
+	return 0;
+}
+
+#define PCW_DECIMAL_WIDTH 24
+
+static int mtk_hdmi_pll_calculate_params(struct mtk_hdmi_phy *hdmi_phy,
+					 unsigned long rate)
+{
+	int ret;
+	unsigned long long tmds_clk = 0;
+	unsigned long long pixel_clk = 0;
+	//pll input source frequency
+	unsigned long long da_hdmitx21_ref_ck = 0;
+	unsigned long long ns_hdmipll_ck = 0; //ICO output clk
+	//source clk for Display digital
+	unsigned long long ad_hdmipll_pixel_ck = 0;
+	unsigned char digital_div = 0;
+	unsigned long long pcw = 0; //FBDIV
+	unsigned char txprediv = 0;
+	unsigned char txposdiv = 0;
+	unsigned char fbkdiv_high = 0;
+	unsigned long fbkdiv_low = 0;
+	unsigned char posdiv1 = 0;
+	unsigned char posdiv2 = 0;
+	unsigned char prediv = 1; //prediv is always 1
+	unsigned char fbkdiv_hs3 = 1; //fbkdiv_hs3 is always 1
+	int i = 0;
+	unsigned char txpredivs[4] = { 2, 4, 6, 12 };
+
+	pixel_clk = rate;
+	tmds_clk = pixel_clk;
+
+	if (tmds_clk < 25000000 || tmds_clk > 594000000)
+		return -EINVAL;
+
+	if (tmds_clk >= 340000000)
+		hdmi_phy->is_over_340M = true;
+	else
+		hdmi_phy->is_over_340M = false;
+
+	da_hdmitx21_ref_ck = 26000000UL; //in HZ
+
+	/*  TXPOSDIV stage treatment:
+	 *	0M  <  TMDS clk  < 54M		  /8
+	 *	54M <= TMDS clk  < 148.35M    /4
+	 *	148.35M <=TMDS clk < 296.7M   /2
+	 *	296.7 <=TMDS clk <= 594M	  /1
+	 */
+	if (tmds_clk < 54000000UL)
+		txposdiv = 8;
+	else if (tmds_clk >= 54000000UL && tmds_clk < 148350000UL)
+		txposdiv = 4;
+	else if (tmds_clk >= 148350000UL && tmds_clk < 296700000UL)
+		txposdiv = 2;
+	else if (tmds_clk >= 296700000UL && tmds_clk <= 594000000UL)
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
+		if (ns_hdmipll_ck >= 5000000000UL &&
+		    ns_hdmipll_ck <= 12000000000UL)
+			break;
+	}
+	if (i == (ARRAY_SIZE(txpredivs) - 1) &&
+	    (ns_hdmipll_ck < 5000000000UL || ns_hdmipll_ck > 12000000000UL)) {
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
+	pcw = ns_hdmipll_ck;
+	pcw = pcw << PCW_DECIMAL_WIDTH;
+	pcw = pcw / da_hdmitx21_ref_ck;
+	pcw = pcw / fbkdiv_hs3;
+
+	if ((pcw / BIT(32)) > 1) {
+		return -EINVAL;
+	} else if ((pcw / BIT(32)) == 1) {
+		fbkdiv_high = 1;
+		fbkdiv_low = pcw % BIT(32);
+	} else {
+		fbkdiv_high = 0;
+		fbkdiv_low = pcw;
+	}
+
+	/* posdiv1:
+	 * posdiv1 stage treatment according to color_depth:
+	 * 24bit -> posdiv1 /10, 30bit -> posdiv1 /12.5,
+	 * 36bit -> posdiv1 /15, 48bit -> posdiv1 /10
+	 */
+	posdiv1 = 10; // div 10
+	posdiv2 = 1;
+	ad_hdmipll_pixel_ck = (ns_hdmipll_ck / 10) / 1;
+
+	/* Digital clk divider, max /32 */
+	digital_div = ad_hdmipll_pixel_ck / pixel_clk;
+	if (!(digital_div <= 32 && digital_div >= 1))
+		return -EINVAL;
+
+	ret = mtk_hdmi_pll_set_hw(hdmi_phy, prediv, fbkdiv_high, fbkdiv_low,
+				  fbkdiv_hs3, posdiv1, posdiv2, txprediv,
+				  txposdiv, digital_div);
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int mtk_hdmi_pll_drv_setting(struct mtk_hdmi_phy *hdmi_phy)
+{
+	unsigned char data_channel_bias, clk_channel_bias;
+	unsigned char data_channel_bias_1, data_channel_bias_2;
+	unsigned char impedance, impedance_en;
+	unsigned char calibration;
+	unsigned long tmds_clk;
+	unsigned long pixel_clk = hdmi_phy->pll_rate;
+
+	/* TODO: TMDS clk frequency equals to pixel_clk
+	 * only when using 8-bit RGB or YUV444.
+	 * We need to adjust tmds_clk frequency
+	 * according to color space and color depth.
+	 */
+	tmds_clk = pixel_clk;
+
+	/* bias & impedance setting:
+	 * 3G < data rate <= 6G: enable impedance 100ohm,
+	 *      data channel bias 24mA, clock channel bias 20mA
+	 * pixel clk >= HD,  74.175MHZ <= pixel clk <= 300MHZ:
+	 *      enable impedance 100ohm
+	 *      data channel 20mA, clock channel 16mA
+	 * 27M =< pixel clk < 74.175: disable impedance
+	 *      data channel & clock channel bias 10mA
+	 */
+
+	/* 3G < data rate <= 6G, 300M < tmds rate <= 594M */
+	if (tmds_clk > 300000000UL && tmds_clk <= 594000000UL) { /// HDMI2.1 4k60
+		data_channel_bias = 0x3c; //24mA
+		data_channel_bias_1 = 0x3c; //24mA
+		data_channel_bias_2 = 0x3c; //24mA
+		clk_channel_bias = 0x34; //20mA
+		impedance_en = 0xf;
+		impedance = 0x36; //100ohm
+	} else if (pixel_clk >= 74175000UL && pixel_clk <= 300000000UL) { /// HDMI1.4b 720~4k24
+		data_channel_bias = 0x1f; //
+		data_channel_bias_1 = 0x30; //
+		data_channel_bias_2 = 0x34; //
+		clk_channel_bias = 0x2c; //16mA
+		impedance_en = 0xf;
+		impedance = 0x36; //100ohm
+	} else if (pixel_clk >= 27000000UL && pixel_clk < 74175000UL) { /// 480
+		data_channel_bias = 0x18; //
+		data_channel_bias_1 = 0x18; //
+		data_channel_bias_2 = 0x18; //
+		clk_channel_bias = 0x14; //10mA
+		impedance_en = 0x0;
+		impedance = 0x0;
+	} else {
+		return -EINVAL;
+	}
+
+	/* bias */
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_1,
+			  data_channel_bias << RG_HDMITX21_DRV_IBIAS_D0_SHIFT,
+			  RG_HDMITX21_DRV_IBIAS_D0);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_1,
+			  data_channel_bias_1 << RG_HDMITX21_DRV_IBIAS_D1_SHIFT,
+			  RG_HDMITX21_DRV_IBIAS_D1);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_1,
+			  data_channel_bias_2 << RG_HDMITX21_DRV_IBIAS_D2_SHIFT,
+			  RG_HDMITX21_DRV_IBIAS_D2);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_0,
+			  clk_channel_bias << RG_HDMITX21_DRV_IBIAS_CLK_SHIFT,
+			  RG_HDMITX21_DRV_IBIAS_CLK);
+
+	/* impedance */
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_0,
+			  impedance_en << RG_HDMITX21_DRV_IMP_EN_SHIFT,
+			  RG_HDMITX21_DRV_IMP_EN);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_2,
+			  impedance << RG_HDMITX21_DRV_IMP_D0_EN1_SHIFT,
+			  RG_HDMITX21_DRV_IMP_D0_EN1);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_2,
+			  impedance << RG_HDMITX21_DRV_IMP_D1_EN1_SHIFT,
+			  RG_HDMITX21_DRV_IMP_D1_EN1);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_2,
+			  impedance << RG_HDMITX21_DRV_IMP_D2_EN1_SHIFT,
+			  RG_HDMITX21_DRV_IMP_D2_EN1);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_2,
+			  impedance << RG_HDMITX21_DRV_IMP_CLK_EN1_SHIFT,
+			  RG_HDMITX21_DRV_IMP_CLK_EN1);
+
+	/* calibration */
+	if (hdmi_phy->conf->efuse_sw_mode) {
+		/* default SW calibration setting suggested */
+		calibration = 0x11;
+		mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_6,
+				  calibration << RG_HDMITX21_INTR_CAL_SHIFT,
+				  RG_HDMITX21_INTR_CAL);
+	}
+
+	return 0;
+}
+
+static int mtk_hdmi_pll_prepare(struct mtk_hdmi_phy *hdmi_phy)
+{
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_6,
+			  0x1 << RG_HDMITX21_TX_POSDIV_EN_SHIFT,
+			  RG_HDMITX21_TX_POSDIV_EN);
+
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_0,
+			  0xf << RG_HDMITX21_SER_EN_SHIFT, RG_HDMITX21_SER_EN);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_6,
+			  0x1 << RG_HDMITX21_D0_DRV_OP_EN_SHIFT,
+			  RG_HDMITX21_D0_DRV_OP_EN);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_6,
+			  0x1 << RG_HDMITX21_D1_DRV_OP_EN_SHIFT,
+			  RG_HDMITX21_D1_DRV_OP_EN);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_6,
+			  0x1 << RG_HDMITX21_D2_DRV_OP_EN_SHIFT,
+			  RG_HDMITX21_D2_DRV_OP_EN);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_6,
+			  0x1 << RG_HDMITX21_CK_DRV_OP_EN_SHIFT,
+			  RG_HDMITX21_CK_DRV_OP_EN);
+
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_6,
+			  0x0 << RG_HDMITX21_FRL_D0_EN_SHIFT,
+			  RG_HDMITX21_FRL_D0_EN);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_6,
+			  0x0 << RG_HDMITX21_FRL_D1_EN_SHIFT,
+			  RG_HDMITX21_FRL_D1_EN);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_6,
+			  0x0 << RG_HDMITX21_FRL_D2_EN_SHIFT,
+			  RG_HDMITX21_FRL_D2_EN);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_6,
+			  0x0 << RG_HDMITX21_FRL_CK_EN_SHIFT,
+			  RG_HDMITX21_FRL_CK_EN);
+
+	mtk_hdmi_pll_drv_setting(hdmi_phy);
+
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_10,
+			  0x0 << RG_HDMITX21_BG_PWD_SHIFT, RG_HDMITX21_BG_PWD);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_6,
+			  0x1 << RG_HDMITX21_BIAS_EN_SHIFT,
+			  RG_HDMITX21_BIAS_EN);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_3,
+			  0x1 << RG_HDMITX21_CKLDO_EN_SHIFT,
+			  RG_HDMITX21_CKLDO_EN);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_3,
+			  0xf << RG_HDMITX21_SLDO_EN_SHIFT,
+			  RG_HDMITX21_SLDO_EN);
+
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_4,
+			  0x1 << DA_HDMITXPLL_PWR_ON_SHIFT,
+			  DA_HDMITXPLL_PWR_ON);
+	udelay(10);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_4,
+			  0x0 << DA_HDMITXPLL_ISO_EN_SHIFT,
+			  DA_HDMITXPLL_ISO_EN);
+	udelay(10);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_2,
+			  0x0 << RG_HDMITXPLL_PWD_SHIFT, RG_HDMITXPLL_PWD);
+	udelay(50);
+	return 0;
+}
+
+static void mtk_hdmi_pll_unprepare(struct mtk_hdmi_phy *hdmi_phy)
+{
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_10,
+			  0x1 << RG_HDMITX21_BG_PWD_SHIFT, RG_HDMITX21_BG_PWD);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_6,
+			  0x0 << RG_HDMITX21_BIAS_EN_SHIFT,
+			  RG_HDMITX21_BIAS_EN);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_3,
+			  0x0 << RG_HDMITX21_CKLDO_EN_SHIFT,
+			  RG_HDMITX21_CKLDO_EN);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_3,
+			  0x0 << RG_HDMITX21_SLDO_EN_SHIFT,
+			  RG_HDMITX21_SLDO_EN);
+
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_2,
+			  0x1 << RG_HDMITXPLL_PWD_SHIFT, RG_HDMITXPLL_PWD);
+	udelay(20);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_4,
+			  0x1 << DA_HDMITXPLL_ISO_EN_SHIFT,
+			  DA_HDMITXPLL_ISO_EN);
+	udelay(20);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_4,
+			  0x0 << DA_HDMITXPLL_PWR_ON_SHIFT,
+			  DA_HDMITXPLL_PWR_ON);
+}
+
+static int mtk_hdmi_pll_set_rate(struct mtk_hdmi_phy *hdmi_phy,
+				 unsigned long rate)
+{
+	int ret;
+
+	debug("%s: %lu Hz\n", __func__, rate);
+
+	ret = mtk_hdmi_pll_calculate_params(hdmi_phy, rate);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void mtk_hdmi_pll_round_rate(struct mtk_hdmi_phy *hdmi_phy,
+				    unsigned long rate)
+{
+	hdmi_phy->pll_rate = rate;
+}
+
+static void vtx_signal_en(struct mtk_hdmi_phy *hdmi_phy, bool on)
+{
+	if (on)
+		mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_0, RG_HDMITX21_DRV_EN,
+				  RG_HDMITX21_DRV_EN);
+	else
+		mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_CFG_0,
+				  0x0 << RG_HDMITX21_DRV_EN_SHIFT,
+				  RG_HDMITX21_DRV_EN);
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
+	link_rate = *(unsigned int *)opts;
+
+	if (hdmi_phy->conf->pll_round_rate)
+		hdmi_phy->conf->pll_round_rate(hdmi_phy, link_rate);
+
+	if (hdmi_phy->conf->pll_set_rate) {
+		ret = hdmi_phy->conf->pll_set_rate(hdmi_phy, hdmi_phy->pll_rate);
+		if (ret)
+			return ret;
+	}
+
+	mtk_mt8195_phy_tmds_high_bit_clk_ratio(hdmi_phy, hdmi_phy->is_over_340M);
+
+	return 0;
+}
+
+static void mtk_hdmi_power_control(struct mtk_hdmi_phy *hdmi_phy, bool enable)
+{
+	if (enable)
+		mtk_hdmi_phy_mask(hdmi_phy, HDMI_CTL_1,
+				  0x1 << RG_HDMITX_PWR5V_O_SHIFT, RG_HDMITX_PWR5V_O);
+	else
+		mtk_hdmi_phy_mask(hdmi_phy, HDMI_CTL_1,
+				  0x0 << RG_HDMITX_PWR5V_O_SHIFT, RG_HDMITX_PWR5V_O);
+}
+
+const struct mtk_hdmi_phy_conf mtk_hdmi_phy_8195_conf = {
+	.pll_enable = mtk_hdmi_pll_prepare,
+	.pll_disable = mtk_hdmi_pll_unprepare,
+	.pll_set_rate = mtk_hdmi_pll_set_rate,
+	.pll_round_rate = mtk_hdmi_pll_round_rate,
+	.hdmi_phy_enable_tmds = mtk_hdmi_phy_enable_tmds,
+	.hdmi_phy_disable_tmds = mtk_hdmi_phy_disable_tmds,
+	.hdmi_phy_configure = mtk_hdmi_phy_configure,
+	.efuse_sw_mode = false,
+	.power_control = mtk_hdmi_power_control,
+};
diff --git a/drivers/phy/phy-mtk-hdmi.c b/drivers/phy/phy-mtk-hdmi.c
new file mode 100644
index 00000000000..c6d2091fc34
--- /dev/null
+++ b/drivers/phy/phy-mtk-hdmi.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2016 MediaTek Inc.
+ * Copyright (c) 2026 BayLibre, SAS
+ * Author: Jie Qiu <jie.qiu@mediatek.com>
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <linux/clk-provider.h>
+
+#include "phy-mtk-hdmi.h"
+
+void mtk_hdmi_phy_mask(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
+		       u32 val, u32 mask)
+{
+	void __iomem *reg = hdmi_phy->regs + offset;
+	u32 tmp;
+
+	tmp = readl(reg);
+	tmp = (tmp & ~mask) | (val & mask);
+	writel(tmp, reg);
+}
+
+static int mtk_hdmi_phy_power_on(struct phy *phy)
+{
+	struct mtk_hdmi_phy *hdmi_phy = dev_get_priv(phy->dev);
+
+	if (hdmi_phy->conf && hdmi_phy->conf->power_control)
+		hdmi_phy->conf->power_control(hdmi_phy, true);
+
+	if (hdmi_phy->conf && hdmi_phy->conf->pll_enable)
+		hdmi_phy->conf->pll_enable(hdmi_phy);
+
+	if (hdmi_phy->conf && hdmi_phy->conf->hdmi_phy_enable_tmds)
+		hdmi_phy->conf->hdmi_phy_enable_tmds(hdmi_phy);
+
+	return 0;
+}
+
+static int mtk_hdmi_phy_power_off(struct phy *phy)
+{
+	struct mtk_hdmi_phy *hdmi_phy = dev_get_priv(phy->dev);
+
+	if (hdmi_phy->conf && hdmi_phy->conf->hdmi_phy_disable_tmds)
+		hdmi_phy->conf->hdmi_phy_disable_tmds(hdmi_phy);
+
+	if (hdmi_phy->conf && hdmi_phy->conf->pll_disable)
+		hdmi_phy->conf->pll_disable(hdmi_phy);
+
+	if (hdmi_phy->conf && hdmi_phy->conf->power_control)
+		hdmi_phy->conf->power_control(hdmi_phy, false);
+
+	return 0;
+}
+
+static int mtk_hdmi_phy_configure(struct phy *phy, void *opts)
+{
+	struct mtk_hdmi_phy *hdmi_phy = dev_get_priv(phy->dev);
+
+	if (hdmi_phy->conf && hdmi_phy->conf->hdmi_phy_configure)
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
+	hdmi_phy->conf = (void *)dev_get_driver_data(dev);
+
+	hdmi_phy->regs = dev_read_addr_ptr(dev);
+	if (!hdmi_phy->regs)
+		return -EINVAL;
+
+	/* reference clock gate */
+	ret = clk_get_by_name(dev, "pll_ref", &hdmi_phy->pll_ref);
+	if (ret) {
+		dev_err(dev, "Failed to get PLL reference clock: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = clk_enable(&hdmi_phy->pll_ref);
+	if (ret) {
+		dev_err(dev, "Failed to enable PLL reference clock: %d\n",
+			ret);
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
+static const struct udevice_id mtk_phy_hdmi_id_table[] = {
+	{
+		.compatible = "mediatek,mt8195-hdmi-phy",
+		.data = (ulong)&mtk_hdmi_phy_8195_conf,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_phy_hdmi) = {
+	.name		= "mtk-phy-hdmi",
+	.id		= UCLASS_PHY,
+	.of_match	= mtk_phy_hdmi_id_table,
+	.ops		= &mtk_hdmi_phy_ops,
+	.probe		= mtk_hdmi_phy_probe,
+	.priv_auto	= sizeof(struct mtk_hdmi_phy),
+};
diff --git a/drivers/phy/phy-mtk-hdmi.h b/drivers/phy/phy-mtk-hdmi.h
new file mode 100644
index 00000000000..ed48cdc4cc3
--- /dev/null
+++ b/drivers/phy/phy-mtk-hdmi.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 MediaTek Inc.
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
+struct mtk_hdmi_phy_conf {
+	bool efuse_sw_mode;
+	int (*pll_enable)(struct mtk_hdmi_phy *hdmi_phy);
+	void (*pll_disable)(struct mtk_hdmi_phy *hdmi_phy);
+	int (*pll_set_rate)(struct mtk_hdmi_phy *hdmi_phy, unsigned long rate);
+	void (*pll_round_rate)(struct mtk_hdmi_phy *hdmi_phy, unsigned long rate);
+	void (*hdmi_phy_enable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
+	void (*hdmi_phy_disable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
+	int (*hdmi_phy_configure)(struct phy *phy, void *opts);
+	void (*power_control)(struct mtk_hdmi_phy *hdmi_phy, bool enable);
+};
+
+struct mtk_hdmi_phy {
+	struct udevice *dev;
+	void __iomem *regs;
+	struct mtk_hdmi_phy_conf *conf;
+	struct clk pll_ref;
+	unsigned long pll_rate;
+	bool is_over_340M;
+};
+
+void mtk_hdmi_phy_mask(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
+		       u32 val, u32 mask);
+
+extern const struct mtk_hdmi_phy_conf mtk_hdmi_phy_8195_conf;
+
+#endif /* _MTK_HDMI_PHY_H */

---
base-commit: 36a39c0aa0b31fc1b1647f79f2e24dfe9aa21a4a
change-id: 20260716-mt8188-add-hdmi-phy-driver-57a051ee6ac6

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

