Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72228C71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 18:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2808B82FAB;
	Fri, 13 Jun 2025 20:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kSXj6N+g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36BEB82EA3; Fri, 13 Jun 2025 20:10:28 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4016D82F35
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 20:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-451ebd3d149so16741385e9.2
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 11:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749838226; x=1750443026; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d1S8f2UxKaB6hnYE+VpXXcL4q4gMpoZRXz4T8RarZJI=;
 b=kSXj6N+gmPu+uwMke5VuR8IuaWGoYb4OxSYHh5uE81+0mDFd9/Kw8ifYjjrw0Q/SmG
 FZ1C8oytop+SiGYx30DKDrvow0rxSQRiD8WLyHlmadEB3zF48KdRsjLCclec75kh11T+
 VbBx0oNkZuiva/s/8jP2od/JSZJC3KyWoH5eTnBgmWLDmgu0eM/lBvkQYxoPIirYjSTE
 n9LNhijQVeQIsNSYIRDT+mXTZ+/5/2po+jcImsMLjIfACdTnPwLiSe7gDZJ8gdlWE1x7
 CSi1niMZR/tijGLLKmdiTuKHdeGxrKNS8TYQleXOPN/KrFeAj9l8/2I+yn31oU+dM6Qs
 MoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749838226; x=1750443026;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d1S8f2UxKaB6hnYE+VpXXcL4q4gMpoZRXz4T8RarZJI=;
 b=BNqQICY3pvHv+U7MtlGrVrhzbP60RX+b655bula703JhhBQp856/UGNoemOKsrGabN
 rjTqXXfMX04oeIOzPuxIx4pLgXwddqv1kTgRN4dmNVPL6HB7mFzrlBV59a4Zzetvg5Fr
 nBPd7Vlg8uyANlfGxlAB9FhQTXfM7c9hNe5s8IDTv6DEgqtCo5e7i+kp/ebkUup4PQWs
 BZNZdFxpKZzNXD74gGcdeoFwD5aGEZNuZiYVMvJip11RZE2CFruZgn2IxVxgOHN24oOg
 Ae1+ktLgNJyJwJd8gi1Jj9vbQ+W4j25+82ILCRi7B1NXSh8oz/6BWeUYggfGq5PyqQm1
 Ta8g==
X-Gm-Message-State: AOJu0Yyp9lxF9CrBbr7relgIhImkSuKDNO2PAG40GoqulLPId1edeXxr
 Ra8nSxZnzr4t1RdXihJGCLMZuDklI4m6m4Nps7pYwCQf9k5/JjWZqwkWxjn8VyNJlFA=
X-Gm-Gg: ASbGncsdpFzhyQ45hSdWLWy4tnWLMggwSLjzxkwcLGHV0Q1xHYYFISSHtXpxgimch2M
 WlQmXqjJ354KtmJx40sVTnnFCxI0QHHtpLPGi6m945ixqwYmyZd5RJyKfA/YvODuJw4XhoWMZyI
 tSmnEbpYOyFCX0zpR3xn98Z76qmJ88jtTVsgfHlneRRQH+s7RiBzivtN014heWqJ8YbSO5Y4oH5
 MOfjhdAeuS1lQH0ETszQw20fwVedpY4bpjv0WBhlGsIEDo9fVm2J0RqdSPnGma4IcJICWWzycb0
 4+t2RN0T58qSuobXiZxNCX4J/6o0l6rP4wy1pLR7PO4h/fiHzMGn5F48JSxprgZ1FKUh
X-Google-Smtp-Source: AGHT+IHObm3DF9xGohNg+b1H5Z9FwcS1PNJOdvDBgJqcWrfFHXuElX0LPikEMpFL7GHkQDe2JaeZWQ==
X-Received: by 2002:a05:600c:8509:b0:450:cf46:5510 with SMTP id
 5b1f17b1804b1-4533cb53b27mr5613625e9.29.1749838225605; 
 Fri, 13 Jun 2025 11:10:25 -0700 (PDT)
Received: from toyger.lan ([213.240.182.76]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e14fc98sm61511975e9.29.2025.06.13.11.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 11:10:24 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 13 Jun 2025 20:10:18 +0200
Subject: [PATCH v3 5/5] serial: msm-geni: implement firmware loading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-geni-load-fw-v3-5-be778b3b101b@linaro.org>
References: <20250613-geni-load-fw-v3-0-be778b3b101b@linaro.org>
In-Reply-To: <20250613-geni-load-fw-v3-0-be778b3b101b@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4895;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=aruKasiUGY9yf+ZpXSvHhb2LO8n/ScJfqCYKb9Cys6g=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoTGmIYbBSWky40un5PZy5BCYlm44lu0gldjEwI
 5NqFlCEz9WJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaExpiAAKCRAFgzErGV9k
 thNqEACjnU6ZMOBE9HymcNfgutdn7+s38oncdH3dBbwSoS+CkAVHk8F/hEkrfq3AvnwZ23RsKvy
 ALe7YV4JmoLuO7srsKp3d46Yc8T5Iim3kkZueczlYHoG9nKK6EkBbkitm38T212PEiIwYMYmc/o
 BjUbOAuGPz3owbU7EN6Ukiv+7fk5TaiJn3HHvXv8cJsbOAccM20yaMuWYzAG4BqVfWUZoC0f4Xs
 uwfZeoZTJoPBq6VzpEeV/IsHwU/OZ+09bCzfIt+sLYifBSaAucGgft3tuB+ghjNo5G8oQhaZmuw
 UXLWs683xEx/EySoTVx/de2ZAYKY1aS+m/fOCugsMQHE3AYDDrM7sdpmO5zN8JOLZT42+tLv0yW
 A2M1Ve74qbVIa6QzdnbQmcXBk7zWfVjZCuDaoXoeuYmmRZxlTXZjFK15SF6XVchpX/TJ3iqewmx
 go+Bi8fFjuO36ZuEk5dW/AAQhJQ0wiwfPxVpL3NkoLCkh9XjrBZN6Lfz1TCuE6UzC3XZMMjBkOZ
 9oGd6jMfiHmrmjQCAKc381M2vSx0Lfa39thd1nyB8H5zyvebkqMRFJt5AZQD2V7H9qcphDkJ55p
 eczA5MELjrWBtn/7yMckYoxzrt1/FutMpU5Lf7a5xwbzsHUwEYdFhw5ihUorPWQN63gFcdkfzYa
 45Ag7SekE9ToX2Q==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Teach the GENI UART driver to load firmware, similar to i2c.

This is primarily intended for non-debug UARTs, but since we don't
support using these as the console we abort probe for now.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/serial/serial_msm_geni.c | 68 ++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 38 deletions(-)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index 35e0029144be7948eb5ab0da5a2d1317a08fb0c5..ad8b183edf5763486c9bd30be1458a1b332c2fee 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -9,22 +9,23 @@
 
 #include <asm/io.h>
 #include <clk.h>
 #include <dm.h>
+#include <dm/device_compat.h>
 #include <errno.h>
 #include <linux/delay.h>
 #include <linux/time.h>
 #include <misc.h>
 #include <serial.h>
+#include <soc/qcom/qup-fw-load.h>
+#include <soc/qcom/geni-se.h>
 
 #define UART_OVERSAMPLING	32
 #define STALE_TIMEOUT	160
 
 /* Registers*/
 #define GENI_FORCE_DEFAULT_REG	0x20
 #define GENI_SER_M_CLK_CFG	0x48
-#define GENI_SER_S_CLK_CFG	0x4C
-#define SE_HW_PARAM_0	0xE24
 #define SE_GENI_STATUS	0x40
 #define SE_GENI_S_CMD0	0x630
 #define SE_GENI_S_CMD_CTRL_REG	0x634
 #define SE_GENI_S_IRQ_CLEAR	0x648
@@ -38,9 +39,8 @@
 #define SE_GENI_TX_FIFOn	0x700
 #define SE_GENI_RX_FIFOn	0x780
 #define SE_GENI_TX_FIFO_STATUS	0x800
 #define SE_GENI_RX_FIFO_STATUS	0x804
-#define SE_GENI_TX_WATERMARK_REG	0x80C
 #define SE_GENI_TX_PACKING_CFG0	0x260
 #define SE_GENI_TX_PACKING_CFG1	0x264
 #define SE_GENI_RX_PACKING_CFG0	0x284
 #define SE_GENI_RX_PACKING_CFG1	0x288
@@ -53,61 +53,26 @@
 #define SE_UART_TX_PARITY_CFG	0x2a4
 #define SE_UART_RX_TRANS_CFG	0x280
 #define SE_UART_RX_PARITY_CFG	0x2a8
 
-#define M_TX_FIFO_WATERMARK_EN	(BIT(30))
 #define DEF_TX_WM	2
 /* GENI_FORCE_DEFAULT_REG fields */
-#define FORCE_DEFAULT	(BIT(0))
-
-#define S_CMD_ABORT_EN	(BIT(5))
 
 #define UART_START_READ	0x1
 
-/* GENI_M_CMD_CTRL_REG */
-#define M_GENI_CMD_CANCEL	(BIT(2))
-#define M_GENI_CMD_ABORT	(BIT(1))
-#define M_GENI_DISABLE	(BIT(0))
-
-#define M_CMD_ABORT_EN	(BIT(5))
-#define M_CMD_DONE_EN	(BIT(0))
 #define M_CMD_DONE_DISABLE_MASK	(~M_CMD_DONE_EN)
 
-#define S_GENI_CMD_ABORT	(BIT(1))
-
-/* GENI_S_CMD0 fields */
-#define S_OPCODE_MSK	(GENMASK(31, 27))
-#define S_PARAMS_MSK	(GENMASK(26, 0))
-
-/* GENI_STATUS fields */
-#define M_GENI_CMD_ACTIVE	(BIT(0))
-#define S_GENI_CMD_ACTIVE	(BIT(12))
-#define M_CMD_DONE_EN	(BIT(0))
-#define S_CMD_DONE_EN	(BIT(0))
-
 #define M_OPCODE_SHIFT	27
 #define S_OPCODE_SHIFT	27
-#define M_TX_FIFO_WATERMARK_EN	(BIT(30))
 #define UART_START_TX	0x1
 #define UART_CTS_MASK	(BIT(1))
-#define M_SEC_IRQ_EN	(BIT(31))
 #define TX_FIFO_WC_MSK	(GENMASK(27, 0))
-#define RX_FIFO_WC_MSK	(GENMASK(24, 0))
-
-#define S_RX_FIFO_WATERMARK_EN	(BIT(26))
-#define S_RX_FIFO_LAST_EN	(BIT(27))
-#define M_RX_FIFO_WATERMARK_EN	(BIT(26))
-#define M_RX_FIFO_LAST_EN	(BIT(27))
 
 /* GENI_SER_M_CLK_CFG/GENI_SER_S_CLK_CFG */
-#define SER_CLK_EN	(BIT(0))
-#define CLK_DIV_MSK	(GENMASK(15, 4))
 #define CLK_DIV_SHFT	4
 
 /* SE_HW_PARAM_0 fields */
-#define TX_FIFO_WIDTH_MSK	(GENMASK(29, 24))
 #define TX_FIFO_WIDTH_SHFT	24
-#define TX_FIFO_DEPTH_MSK	(GENMASK(21, 16))
 #define TX_FIFO_DEPTH_SHFT	16
 
 /* GENI SE QUP Registers */
 #define QUP_HW_VER_REG		0x4
@@ -548,16 +513,42 @@ static inline void geni_serial_init(struct udevice *dev)
 static int msm_serial_probe(struct udevice *dev)
 {
 	struct msm_serial_data *priv = dev_get_priv(dev);
 	int ret;
+	u32 proto;
 	struct clk *clk;
 
 	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 	priv->se = clk;
 
+	/* Try enable clock */
 	ret = clk_enable(clk);
+
+	/* Check if firmware loading is needed (BT UART) */
+	proto = readl(priv->base + GENI_FW_REVISION_RO);
+	proto &= FW_REV_PROTOCOL_MSK;
+	proto >>= FW_REV_PROTOCOL_SHFT;
+
+	if (proto == GENI_SE_INVALID_PROTO) {
+		qcom_geni_load_firmware(priv->base, dev);
+		proto = readl(priv->base + GENI_FW_REVISION_RO);
+		proto &= FW_REV_PROTOCOL_MSK;
+		proto >>= FW_REV_PROTOCOL_SHFT;
+	}
+
+	if (proto != GENI_SE_UART) {
+		dev_err(dev, "Invalid proto %d\n", proto);
+		clk_disable(clk);
+		return -ENXIO;
+	}
+
+	/* Don't actually probe non-debug UARTs */
+	if (ofnode_device_is_compatible(dev_ofnode(dev), "qcom,geni-uart"))
+		return -ENOENT;
+
+	/* Now handle clock enable return value */
 	if (ret)
 		return ret;
 
 	ret = geni_set_oversampling(dev);
@@ -588,8 +579,9 @@ static int msm_serial_ofdata_to_platdata(struct udevice *dev)
 }
 
 static const struct udevice_id msm_serial_ids[] = {
 	{ .compatible = "qcom,geni-debug-uart" },
+	{ .compatible = "qcom,geni-uart" },
 	{ }
 };
 
 U_BOOT_DRIVER(serial_msm_geni) = {

-- 
2.49.0

