Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A4FC53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:44:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 212F84057A;
	Mon, 27 Jul 2026 08:44:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nCIxdURmI-gY; Mon, 27 Jul 2026 08:44:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED21540581
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785141841;
	bh=85YbRjCpTo3fqOT6iXKrWsM8aUNKYSgntARG+I+mWWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R8rwfMSyCSRw53O+tRz2cvF/Cs4nuRS1vVPn7HZO7h9VaiijU+OR2wx/Q2N1b8UG7
	 sG5K2WaxPeypYahGXtsRe1ii/yTHoQ7muW6PHwJXsxcmHjiVXK2wWJ9ocjCRYLj3Kh
	 UfxtTWdSC5MTwXaL2HuTKrXvgxmMUODQMukeh8zm0C/bgeyiGWkCMQZN4gPYV/Vpss
	 I1S/vhCigrKEhJPef58lodSZZmD9O0HzTKllawwqe22rJh7GW0LRNmF7MwyQl+EQ8e
	 +Bib/W/QHaAc1o7GJ/WOw3N54sBEWLTWlqvVDhiI2LvIbwKBZ0XafkUx1GQiP6UruR
	 N2QhoSA1hulug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED21540581;
	Mon, 27 Jul 2026 08:44:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CAF0490
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:43:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 12C5480BBD
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:43:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7S11uNUIo5Bz for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:43:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BC8D680AA9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BC8D680AA9
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BC8D680AA9
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:43:54 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso16520585e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 01:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785141832; x=1785746632;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=85YbRjCpTo3fqOT6iXKrWsM8aUNKYSgntARG+I+mWWs=;
 b=FoDFbzVNdCZUfYn5BFFlAhn9/d/c4miyhNY+U2xaZFkxbbxoigueqIuaFEyytiwVuG
 I1Jv3WanC+BtR87QMNLCyG6o6GfXS3dLaF/wIrBoLkb5zTDyLloB39yEmsBCPbie+Ccs
 wnmewLe/EfrWzD1N4YE0NZXc+9o31MvT2o584baxgWSfPQcW5RaS4JI/8s4pca4fKZ/K
 Tfd1ky+bO6uuwyyakGnUc3ax3QpjGThjGF/p0PQgSwU3fXXNJjROPNGPjwq3lIDp0VLR
 Lab1n/qGivVYSQgSnX4EqbokjmubLGMv7R2/lxFf7Y2FWrWi0TBY/gLjcqTG3SG/Wj2+
 aWaA==
X-Gm-Message-State: AOJu0Yy4LXekVbTEQJ3DVf5FaLv3sj4Y9kewjQjZZvl6Zx0x14eJuhCj
 rghmnaLYLtddP1o4ov+ONeHrdJBAJP0ro0Vl1lK+meNQ84RVkBr8wxn+Hna+CO+O7Ck=
X-Gm-Gg: AR+sD11jv5j+aPLdRUF18lBJV3nIufYn/BdgWmWegP+7eHszPgs8mK8xZsqc1FsO9qh
 wNirbGdjdlJiCbBgNpcz33AkmrHFpfPJNLhHovYJUGKOgfamaJdKHQvr6Gk+5EWen7gkYD+cvdW
 KydJa6Hdj2WloBxrb/CMInlFU+Mzgvw1ZQQ9WJwoKvZR2QJioJvp1eZw0nThLzniKVwQUdzdJ9Z
 eQZW2Ko0TmClMxQkiH8nkx99FvAnxu7h6xJS1GjRrc67eQz61O62Whre762o578Wzme8MmgVkU6
 ZxJB2UNOL2+FgZ8fOlfZ6IPsXVYhch9FZnH6YRZ6ip/Qd2yzGeuX6vR8Ijclm6fmgtqw/4uqTVF
 bD/3qrmLeC9rookUW4Vty2ocLV9P/5N5h6i7ZzgRc151xX9RKAGxM+t4anjKX1aYAeG+kFGvOz5
 8EZwboHtLXXF2avwy+rnGuIfyjYhNKGDFlPL2fZoXcsR8+LTHIFyi/tOfPDXP61qS0C9+0vn2Fg
 Rwhlnhn+CxeIymh98vC5H3T0c1lfYY1npDMYJlGG3w9pOvRwlvX5qt0ZppTycQ=
X-Received: by 2002:a05:600c:1d18:b0:493:c634:952 with SMTP id
 5b1f17b1804b1-496b56da571mr99884775e9.7.1785141832395; 
 Mon, 27 Jul 2026 01:43:52 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4ed6b76sm216330695e9.2.2026.07.27.01.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 01:43:52 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 27 Jul 2026 10:43:46 +0200
Subject: [PATCH v2 2/2] i2c: mtk_mt8195_i2c_ddc: add new driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mt8188-add-ddc-i2c-driver-v2-2-bf1c45fcd588@baylibre.com>
References: <20260727-mt8188-add-ddc-i2c-driver-v2-0-bf1c45fcd588@baylibre.com>
In-Reply-To: <20260727-mt8188-add-ddc-i2c-driver-v2-0-bf1c45fcd588@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Heiko Schocher <hs@nabladev.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785141832; x=1785746632;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=85YbRjCpTo3fqOT6iXKrWsM8aUNKYSgntARG+I+mWWs=;
 b=BPnK1qBm0P419Br0IuN37vuk1nkeE5P32sPHdyC2745B6R/BdLbPDbpDHn4YDIpNHn
 OhiWAU6dSFj8wnLUJxjCqgD6CQtlcYX05YJo1XDlioE//DPTZi2RKAVe91M1UXzmXcwI
 kbcV/aWvNBsx9wY0/bxfsLYu5ToSXMoH/RJqzIhNVOhnd7i5eLJ33rwoCI+DccUM3fyX
 ZBQi5pPWGEFtE0+wV2ntoa8ki47GTt1VD/ItVmSWlLp74yINPAAqf8qs+9laJQhtVB2p
 2BTjhemhHDxjqvIgXoDywH3OcvQbTL+2H1lrxPIA+TILG1qZnkOnNHPaJsDe9UeMYPrl
 6KtQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=BPnK1qBm
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

Add a new driver for HDMI DDC channel reading for MT8195 based SoCs.
The driver is based on the corresponding kernel driver.

Signed-off-by: Pavlo Yadvychuk <pyadvychuk@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Reviewed-by: Heiko Schocher <hs@nabladev.com>
---
 drivers/i2c/Kconfig              |  11 ++
 drivers/i2c/Makefile             |   1 +
 drivers/i2c/mtk_mt8195_i2c_ddc.c | 394 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 406 insertions(+)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index ab5af17858c..9c563655945 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -232,6 +232,17 @@ config SYS_I2C_DAVINCI
 	help
 	  Say yes here to add support for Davinci and Keystone I2C controller
 
+config SYS_I2C_DDC_MTK
+	bool "MediaTek HDMI DDC driver"
+	depends on DM_I2C
+	depends on CLK
+	help
+	  This selects the MediaTek Inter-Integrated Circuit (I2C) bus driver
+	  used for HDMI DDC communication. The driver supports MT8188 and
+	  MT8195 compatible SoCs.
+	  If you want to use the MediaTek DDC interface, say Y here.
+	  If unsure, say N.
+
 config SYS_I2C_DW
 	bool "Designware I2C Controller"
 	help
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index 2da649e97d3..8185753cd13 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_SYS_I2C_AT91) += at91_i2c.o
 obj-$(CONFIG_SYS_I2C_CADENCE) += i2c-cdns.o
 obj-$(CONFIG_SYS_I2C_CA) += i2c-cortina.o
 obj-$(CONFIG_SYS_I2C_DAVINCI) += davinci_i2c.o
+obj-$(CONFIG_SYS_I2C_DDC_MTK) += mtk_mt8195_i2c_ddc.o
 obj-$(CONFIG_SYS_I2C_DW) += designware_i2c.o
 obj-$(CONFIG_SYS_I2C_DW_PCI) += designware_i2c_pci.o
 obj-$(CONFIG_SYS_I2C_FSL) += fsl_i2c.o
diff --git a/drivers/i2c/mtk_mt8195_i2c_ddc.c b/drivers/i2c/mtk_mt8195_i2c_ddc.c
new file mode 100644
index 00000000000..cbdac6fa5db
--- /dev/null
+++ b/drivers/i2c/mtk_mt8195_i2c_ddc.c
@@ -0,0 +1,394 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ * Copyright (c) 2026 BayLibre, SAS
+ *
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <edid.h>
+#include <i2c.h>
+#include <linux/delay.h>
+#include <time.h>
+
+#define DDC2_CLOCK 572 /* BIM=208M/(v*4) = 90Khz */
+#define DDC2_CLOCK_EDID 832 /* BIM=208M/(v*4) = 62.5Khz */
+
+#define SCDC_I2C_SLAVE_ADDRESS 0x54
+
+#define HDCP2X_DDCM_STATUS 0xC68
+
+#define SCDC_CTRL 0xC18
+
+#define CLEAR_FIFO 0x9
+
+#define CLOCK_SCL 0xA
+
+#define ENH_READ_NO_ACK 0x4
+
+#define DDC_CMD GENMASK(31, 28)
+#define DDC_CMD_SHIFT (28)
+#define DDC_CTRL 0xC10
+#define DDC_DATA_OUT GENMASK(23, 16)
+#define DDC_DATA_OUT_SHIFT (16)
+#define DDC_DELAY_CNT GENMASK(31, 16)
+#define DDC_DELAY_CNT_SHIFT (16)
+#define DDC_DIN_CNT_SHIFT (16)
+#define DDC_I2C_BUS_LOW BIT(11)
+#define DDC_I2C_IN_PROG BIT(13)
+#define DDC_I2C_NO_ACK BIT(10)
+#define DDC_OFFSET_SHIFT (8)
+#define DDC_SEGMENT GENMASK(15, 8)
+#define DDC_SEGMENT_SHIFT (8)
+
+#define HPD_DDC_CTRL 0xC08
+#define HPD_DDC_STATUS 0xC60
+
+#define SEQ_READ_NO_ACK 0x2
+#define SEQ_WRITE_REQ_ACK 0x7
+
+#define SI2C_CTRL 0xCAC
+#define SI2C_ADDR_READ (0xF4)
+#define SI2C_ADDR_SHIFT (16)
+#define SI2C_WDATA GENMASK(15, 8)
+#define SI2C_WDATA_SHIFT (8)
+#define SI2C_CONFIRM_READ BIT(2)
+#define SI2C_RD BIT(1)
+#define SI2C_WR BIT(0)
+
+#define HDCP2X_POL_CTRL 0xC54
+#define HDCP2X_DIS_POLL_EN BIT(16)
+
+struct mtk_hdmi_ddc {
+	struct udevice *udev;
+	struct clk clk;
+	void __iomem *regs;
+};
+
+enum sif_bit_t_hdmi {
+	SIF_8_BIT_HDMI, /* 8 bits data address */
+	SIF_16_BIT_HDMI, /* 16 bits data address */
+};
+
+static inline unsigned int mtk_ddc_read(struct mtk_hdmi_ddc *ddc,
+					unsigned int reg)
+{
+	return readl(ddc->regs + reg);
+}
+
+static inline void mtk_ddc_write(struct mtk_hdmi_ddc *ddc, unsigned int reg,
+				 unsigned int val)
+{
+	writel(val, ddc->regs + reg);
+}
+
+static inline void mtk_ddc_mask(struct mtk_hdmi_ddc *ddc, unsigned int reg,
+				unsigned int val, unsigned int mask)
+{
+	clrsetbits_32(ddc->regs + reg, mask, val);
+}
+
+static void mtk_ddc_disable_hdcp_polling(struct mtk_hdmi_ddc *ddc)
+{
+	mtk_ddc_mask(ddc, HDCP2X_POL_CTRL, HDCP2X_DIS_POLL_EN,
+		     HDCP2X_DIS_POLL_EN);
+}
+
+static void ddc_wr_one(struct mtk_hdmi_ddc *ddc, unsigned int addr_id,
+		       unsigned int offset_id, unsigned char wr_data)
+{
+	if (mtk_ddc_read(ddc, HDCP2X_DDCM_STATUS) & DDC_I2C_BUS_LOW) {
+		mtk_ddc_mask(ddc, DDC_CTRL, (CLOCK_SCL << DDC_CMD_SHIFT),
+			     DDC_CMD);
+		udelay(300);
+	}
+	mtk_ddc_mask(ddc, HPD_DDC_CTRL, DDC2_CLOCK << DDC_DELAY_CNT_SHIFT,
+		     DDC_DELAY_CNT);
+	mtk_ddc_write(ddc, SI2C_CTRL, SI2C_ADDR_READ << SI2C_ADDR_SHIFT);
+	mtk_ddc_mask(ddc, SI2C_CTRL, wr_data << SI2C_WDATA_SHIFT, SI2C_WDATA);
+	mtk_ddc_mask(ddc, SI2C_CTRL, SI2C_WR, SI2C_WR);
+
+	mtk_ddc_write(ddc, DDC_CTRL,
+		      (SEQ_WRITE_REQ_ACK << DDC_CMD_SHIFT) +
+		      (1 << DDC_DIN_CNT_SHIFT) +
+		      (offset_id << DDC_OFFSET_SHIFT) + (addr_id << 1));
+
+	udelay(1250);
+
+	if ((mtk_ddc_read(ddc, HDCP2X_DDCM_STATUS) &
+	     (DDC_I2C_NO_ACK | DDC_I2C_BUS_LOW))) {
+		if (mtk_ddc_read(ddc, HDCP2X_DDCM_STATUS) & DDC_I2C_BUS_LOW) {
+			mtk_ddc_mask(ddc, DDC_CTRL,
+				     (CLOCK_SCL << DDC_CMD_SHIFT), DDC_CMD);
+			udelay(300);
+		}
+	}
+}
+
+static unsigned int
+ddcm_read_hdmi(struct mtk_hdmi_ddc *ddc, unsigned int u4_clk_div,
+	       unsigned char uc_dev, unsigned int u4_addr,
+	       unsigned char *puc_value, unsigned int u4_count)
+{
+	unsigned int i, temp_length, loop_counter;
+	unsigned int uc_read_count = 0, uc_idx;
+	unsigned long ddc_start_time, ddc_end_time, ddc_timeout;
+
+	if (!puc_value || !u4_count || !u4_clk_div)
+		return 0;
+
+	if (mtk_ddc_read(ddc, HDCP2X_DDCM_STATUS) & DDC_I2C_BUS_LOW) {
+		mtk_ddc_mask(ddc, DDC_CTRL, (CLOCK_SCL << DDC_CMD_SHIFT),
+			     DDC_CMD);
+		udelay(300);
+	}
+
+	mtk_ddc_mask(ddc, DDC_CTRL, (CLEAR_FIFO << DDC_CMD_SHIFT), DDC_CMD);
+
+	if (u4_count >= 16) {
+		temp_length = 16;
+		loop_counter = u4_count / 16 + ((u4_count % 16 == 0) ? 0 : 1);
+	} else {
+		temp_length = u4_count;
+		loop_counter = 1;
+	}
+
+	if (uc_dev >= EDID_ADDR && u4_clk_div < DDC2_CLOCK_EDID)
+		u4_clk_div = DDC2_CLOCK_EDID;
+
+	mtk_ddc_mask(ddc, HPD_DDC_CTRL, u4_clk_div << DDC_DELAY_CNT_SHIFT,
+		     DDC_DELAY_CNT);
+
+	for (i = 0; i < loop_counter; i++) {
+		if (i == (loop_counter - 1) && i != 0 && u4_count % 16)
+			temp_length = u4_count % 16;
+
+		/* EDID_ADDR(0x50) + 1 .. 0x53 select an EDID segment */
+		if (uc_dev > EDID_ADDR && uc_dev <= 0x53) {
+			mtk_ddc_mask(ddc, SCDC_CTRL,
+				     (uc_dev - EDID_ADDR)
+				     << DDC_SEGMENT_SHIFT,
+				     DDC_SEGMENT);
+			mtk_ddc_write(ddc, DDC_CTRL,
+				      (ENH_READ_NO_ACK << DDC_CMD_SHIFT) +
+				      (temp_length << DDC_DIN_CNT_SHIFT) +
+				      ((u4_addr + i * temp_length)
+				       << DDC_OFFSET_SHIFT) +
+				      (EDID_ADDR << 1));
+		} else {
+			mtk_ddc_write(ddc, DDC_CTRL,
+				      (SEQ_READ_NO_ACK << DDC_CMD_SHIFT) +
+				      (temp_length << DDC_DIN_CNT_SHIFT) +
+				      ((u4_addr + i * 16)
+				       << DDC_OFFSET_SHIFT) + (uc_dev << 1));
+		}
+		udelay(5500);
+		ddc_start_time = get_timer(0);
+		/* timeout in ms: about 1 ms per byte plus some margin */
+		ddc_timeout = temp_length + 5;
+		ddc_end_time = ddc_start_time + ddc_timeout;
+		while (1) {
+			if ((mtk_ddc_read(ddc, HPD_DDC_STATUS) &
+			     DDC_I2C_IN_PROG) == 0)
+				break;
+
+			if (time_after(get_timer(0), ddc_end_time)) {
+				dev_err(ddc->udev, "DDC transfer timeout\n");
+				return 0;
+			}
+			udelay(1500);
+		}
+		if ((mtk_ddc_read(ddc, HDCP2X_DDCM_STATUS) &
+		     (DDC_I2C_NO_ACK | DDC_I2C_BUS_LOW))) {
+			if (mtk_ddc_read(ddc, HDCP2X_DDCM_STATUS) &
+			    DDC_I2C_BUS_LOW) {
+				mtk_ddc_mask(ddc, DDC_CTRL,
+					     (CLOCK_SCL << DDC_CMD_SHIFT),
+					     DDC_CMD);
+				udelay(300);
+			}
+			return 0;
+		}
+
+		/* get the DDC data from the FIFO */
+		for (uc_idx = 0; uc_idx < temp_length; uc_idx++) {
+			/* latch the FIFO output */
+			mtk_ddc_write(ddc, SI2C_CTRL,
+				      (SI2C_ADDR_READ << SI2C_ADDR_SHIFT) +
+				      SI2C_RD);
+
+			/* read FIFO output value from DDC_STATUS */
+			puc_value[i * 16 + uc_idx] =
+				(mtk_ddc_read(ddc, HPD_DDC_STATUS) &
+				 DDC_DATA_OUT) >> DDC_DATA_OUT_SHIFT;
+
+			/* increment FIFO read pointer, un-latch the FIFO */
+			mtk_ddc_write(ddc, SI2C_CTRL,
+				      (SI2C_ADDR_READ << SI2C_ADDR_SHIFT) +
+				      SI2C_CONFIRM_READ);
+			/*
+			 * if the hdmi block was reset while reading, the DDC
+			 * speed falls back below DDC2_CLOCK: abort
+			 */
+			if (((mtk_ddc_read(ddc, HPD_DDC_CTRL) >> 16) &
+			     0xFFFF) < DDC2_CLOCK)
+				return 0;
+
+			uc_read_count = i * 16 + uc_idx + 1;
+		}
+	}
+
+	return uc_read_count;
+}
+
+static unsigned int vddc_read(struct mtk_hdmi_ddc *ddc,
+			      unsigned int u4_clk_div, unsigned char uc_dev,
+			      unsigned int u4_addr,
+			      enum sif_bit_t_hdmi uc_addr_type,
+			      unsigned char *puc_value, unsigned int u4_count)
+{
+	unsigned int u4_read_count = 0;
+
+	if (!puc_value || !u4_count || !u4_clk_div)
+		return 0;
+	if (uc_addr_type > SIF_16_BIT_HDMI)
+		return 0;
+	if (uc_addr_type == SIF_8_BIT_HDMI && u4_addr > 255)
+		return 0;
+	if (uc_addr_type == SIF_16_BIT_HDMI && u4_addr > 65535)
+		return 0;
+
+	if (uc_addr_type == SIF_8_BIT_HDMI)
+		u4_read_count = 255 - u4_addr + 1;
+	else if (uc_addr_type == SIF_16_BIT_HDMI)
+		u4_read_count = 65535 - u4_addr + 1;
+
+	u4_read_count = min(u4_read_count, u4_count);
+
+	return ddcm_read_hdmi(ddc, u4_clk_div, uc_dev, u4_addr, puc_value,
+			      u4_read_count);
+}
+
+static int fg_ddc_data_read(struct mtk_hdmi_ddc *ddc, unsigned char b_dev,
+			    unsigned char b_data_addr,
+			    unsigned int b_data_count, unsigned char *pr_data)
+{
+	mtk_ddc_disable_hdcp_polling(ddc);
+	if (vddc_read(ddc, DDC2_CLOCK, b_dev, b_data_addr, SIF_8_BIT_HDMI,
+		      pr_data, b_data_count) != b_data_count)
+		return -EREMOTEIO;
+
+	return 0;
+}
+
+static int fg_ddc_data_write(struct mtk_hdmi_ddc *ddc, unsigned char b_dev,
+			     unsigned char b_data_addr,
+			     unsigned int b_data_count,
+			     unsigned char *pr_data)
+{
+	unsigned int i;
+
+	mtk_ddc_disable_hdcp_polling(ddc);
+	for (i = 0; i < b_data_count; i++)
+		ddc_wr_one(ddc, b_dev, b_data_addr + i, *(pr_data + i));
+
+	return 0;
+}
+
+static int mtk_hdmi_ddc_xfer(struct udevice *dev, struct i2c_msg *msgs, int num)
+{
+	struct mtk_hdmi_ddc *ddc = dev_get_priv(dev);
+	unsigned char offset = 0;
+	int ret;
+	int i;
+
+	if (!msgs)
+		return -EINVAL;
+
+	if (!ddc || !ddc->regs)
+		return -EINVAL;
+
+	for (i = 0; i < num; i++) {
+		struct i2c_msg *msg = &msgs[i];
+
+		if (!msg->buf || !msg->len)
+			return -EINVAL;
+
+		if (msg->flags & I2C_M_RD) {
+			/*
+			 * The underlying DDC hardware always issues a write
+			 * request that assigns the read offset as part of the
+			 * read operation, so use the offset value stored on
+			 * the previous write request.
+			 */
+			ret = fg_ddc_data_read(ddc, msg->addr, offset,
+					       msg->len, &msg->buf[0]);
+		} else {
+			ret = fg_ddc_data_write(ddc, msg->addr, msg->buf[0],
+						msg->len - 1, &msg->buf[1]);
+
+			/*
+			 * store the offset requested by the EDID/SCDC
+			 * framework for use by subsequent read requests
+			 */
+			if ((msg->addr == EDID_ADDR ||
+			     msg->addr == SCDC_I2C_SLAVE_ADDRESS) &&
+			    msg->len == 1)
+				offset = msg->buf[0];
+		}
+
+		if (ret) {
+			dev_err(dev, "ddc transfer failed: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int mtk_hdmi_ddc_probe(struct udevice *dev)
+{
+	struct mtk_hdmi_ddc *ddc = dev_get_priv(dev);
+	int ret;
+
+	ddc->udev = dev;
+	/* the ddc node sits below the hdmi node, which holds the registers */
+	ddc->regs = dev_read_addr_ptr(dev->parent);
+	if (!ddc->regs)
+		return -EINVAL;
+
+	ret = clk_get_by_index(dev, 0, &ddc->clk);
+	if (ret) {
+		dev_err(dev, "failed to get ddc clk: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable(&ddc->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable ddc clk: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dm_i2c_ops mtk_hdmi_ddc_ops = {
+	.xfer	= mtk_hdmi_ddc_xfer,
+};
+
+static const struct udevice_id mtk_hdmi_ddc_ids[] = {
+	{ .compatible = "mediatek,mt8195-hdmi-ddc", },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_i2c_ddc) = {
+	.name		= "mtk_i2c_ddc",
+	.id		= UCLASS_I2C,
+	.of_match	= mtk_hdmi_ddc_ids,
+	.probe		= mtk_hdmi_ddc_probe,
+	.priv_auto	= sizeof(struct mtk_hdmi_ddc),
+	.ops		= &mtk_hdmi_ddc_ops,
+};

-- 
2.54.0

