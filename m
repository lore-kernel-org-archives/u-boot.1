Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D10C4451C
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 12:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B584E84E16;
	Fri, 17 Jul 2026 14:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Pw/BE/XV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9078784E1F; Fri, 17 Jul 2026 14:33:49 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38A3984E16
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 14:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so61955365e9.0
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 05:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784291627; x=1784896427; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=68Y2TJFuajYR6K096yjDN4i04kQv23f3m6rjbTCSPtI=;
 b=Pw/BE/XVyXivBJjWhZTe6fUVpkrjLTCsyyW+NOG25eqbQvxwkFh6onEajAOw0jsd03
 ae32gdBKDRr2AcZZyqbKlEzRjMxNuz26/BxXN9B5HDGJ6G6a7h/6DTnLGzbtg955bfOo
 NuO8W9Cg3lH/Jyc57BejBdtzQw5deI0dzQLY7bq1Eg9na0jZx6BNZJYxbJwnFzMbi096
 495xK+LIj0L4gvjBFVLLn1qbnEnWVR9miVlGKUXQE46vd+2+xKf/DdfgjAXXFAza2+YK
 pX7YFRWwzXTL9ppWT2XPAXfHopvcxaCwnsdxN6V+F4mO6ENb8EhUwLoPWR3xbzS5uBzJ
 hNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784291627; x=1784896427;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=68Y2TJFuajYR6K096yjDN4i04kQv23f3m6rjbTCSPtI=;
 b=EydUE5+k+y9HjxGKeh7PCMFdFd1QA51eNP/Xpcc7j1HOT0O0+xcx9KnRkyHqY0QHvm
 FyUhtA/5DjhcsYtLVgJwYPCg4LD/W8ZYNwvwV3H7owKSuzcRgNCD3lmmsv84MKudh5LB
 AH6U9rsqt4L/uYHSAqCnC2shJ8LCRN479Ywb+s2AZNe9dStPJSfwscd9wUYZj2icFdZM
 +ZWcK6dEAJE+enVg9sEUTf2oghyWTGy7mfcp2zK6ktomxREDn8Ll3g6puZqORg21HtKW
 Ed4U3gL1l4iU/SoTBNzm/vskfNu0E2rPoLk5GJFnA5+5XAiD+Hk88Z146uUeEN3AeSOE
 RvUA==
X-Gm-Message-State: AOJu0YxfDXyN0JlcmUF3IEDWZyVX1swuqReFVNqzd4H16w/7r7WTICot
 pp9PWptauXGn9oTLNntZpCq52nIwQYQSbXUNzbxzj1udzYdivlcH6IwLmjoKFw+diK4=
X-Gm-Gg: AfdE7ckwElx11v1qroZfDiOGHW9c+GVq1jYntZQBF5bdG4oOvYyDkBvvxg2K4rtxBmD
 d5oDTvaAUBm3HkK8HWrjx8G4f2J2Y6Q9T8YMqZSWaG4yKGV8Ap0xUrl0k9m4/LSDVcL6uMjZNIb
 KJ+xfOtPvtrlvpIN4ZQ3AkEnwbe89sG1dBOkE3eXaxO06xGJfGt/qaqchZC+gV98Ajk+iZIc/CS
 frQ4Y/Sx4w6fzm1XFxp/KjGA/wlC+mXgr2SNHHJ58jFhcU+kIkLSBSxNUCSd8KcKb0m+sPN9Xna
 ruWW542GdZMDK5S1l7eeQSheomoy4dQomPsL2is1tJG2odXmrXGn3hd/L6nxyCg0SsQgY4mjXWg
 /Pr18oiMMtoqc9c3eV5RLIEUxBR9xU1476l2HbC72PvqYrs7fQ27rjUGbWBMi1W/d6rYA3RP2Lk
 z32F/gWW37ZYa2+UYjGUjW3yB+wLYXIwfd6fQZjWSUizOhUn8O5s1b2cyrIJTnBVNp0w0LmtjrQ
 F6aVsf0yKQ4sp/0CBCC6DdVmeYRYsTv8EIpj0w6TxsBzrG+nPVaG/XVcWFN
X-Received: by 2002:a05:600c:1c1b:b0:495:4b24:1b64 with SMTP id
 5b1f17b1804b1-4954b241d02mr26432445e9.0.1784291626060; 
 Fri, 17 Jul 2026 05:33:46 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495499f3f99sm44199595e9.0.2026.07.17.05.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 05:33:45 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 17 Jul 2026 14:33:41 +0200
Subject: [PATCH 2/2] i2c: mtk_mt8195_i2c_ddc: add new driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-mt8188-add-ddc-i2c-driver-v1-2-e89ccd173567@baylibre.com>
References: <20260717-mt8188-add-ddc-i2c-driver-v1-0-e89ccd173567@baylibre.com>
In-Reply-To: <20260717-mt8188-add-ddc-i2c-driver-v1-0-e89ccd173567@baylibre.com>
To: u-boot@lists.denx.de
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

Add a new driver for HDMI DDC channel reading for MT8195 based SoCs.
The driver is based on the corresponding kernel driver.

Signed-off-by: Pavlo Yadvychuk <pyadvychuk@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/i2c/Kconfig              |  11 ++
 drivers/i2c/Makefile             |   1 +
 drivers/i2c/mtk_mt8195_i2c_ddc.c | 398 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 410 insertions(+)

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
index 00000000000..7b6e57929a9
--- /dev/null
+++ b/drivers/i2c/mtk_mt8195_i2c_ddc.c
@@ -0,0 +1,398 @@
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
+	unsigned int tmp;
+
+	tmp = readl(ddc->regs + reg) & ~mask;
+	tmp |= (val & mask);
+	writel(tmp, ddc->regs + reg);
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

