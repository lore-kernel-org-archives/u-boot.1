Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFFBC61DB6
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:45:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7556607DD;
	Mon, 24 Aug 2026 16:45:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7vZXykv1Dpc8; Mon, 24 Aug 2026 16:45:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589944;
	bh=4hx57D3GW6iEqnwUw3VkuBE8RUBXW3hvwK9s1Bs/7xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pH3gCYlwVbF/Ww6CSZtSmgKeC+yhSk8f6Y8J9sE4e+EE4MsHdso36b/amkP1x5iiN
	 /GMiNNJfA+qcCw8JiuYbU7MxEA1yxhwgvtD6y4v/J0mNGqbn6s/tADBKeSPTLP04PL
	 uS4v1mhia7CGAa6hLr0IJqoJ8SUYexAQzNlgAj47ntwxBwj29393GcOtNFR8prhvSN
	 lD/0+VtyhoYzew+YO5MlRzM+K2uD324t7yvFSXx6e1COj/aVJb9s7Q2nHitjAlA79w
	 Wy9icIiiFXkAEca93wm4ahUvpO2VdTGLyWiqjcKbt5n/PYd/DwBzTDCr32NWXERxDo
	 NjYc8MlqUDMZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3B9F607CF;
	Mon, 24 Aug 2026 16:45:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 234643AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1566980AE3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o8YSoE-pw0Dg for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:43:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=TwlWJl97
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 77CA680B2C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:42:59 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a18af264f9so749515a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787586178; x=1788190978;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4hx57D3GW6iEqnwUw3VkuBE8RUBXW3hvwK9s1Bs/7xI=;
 b=TwlWJl97v3TRHEmU7Ry4o6vvPKTshk3ZefCSdfUngF2AEOjqnTWE9Vva2sQ3slSMJ/
 wmS+W0DbddE2jABhv4fsyzaYfOWGG41xP0OdGi95VdFwDHcHlo/hYAE1Bhz3tMsAipO2
 yD52hdTE6D1WzOqkf0bk33gnXHOvP/aanVr48quTu6jP5imN6n5J2pYGS3ERJ8mDgNRh
 SSz7IkW7HCIaZrBA+8Jaq94xn8sYVlneTI3RhYjOe83hsq6WRAj7rBaCzEUpxDz4EAaz
 hWu2J8zhveCKHGWetJ1er9bNo3hKWx2MHPbQ1dwkL3SWQHR9oY09w80Ij6i010FsynMA
 k61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787586178; x=1788190978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4hx57D3GW6iEqnwUw3VkuBE8RUBXW3hvwK9s1Bs/7xI=;
 b=GynJ1PghwuJki1KN4GAjpSP/kc3oJwk3p9i/awKXbOPcTaN55YP760Pec/1njI/I/x
 pmYMLk6MNGqID3oFCeIx92D/X0aKAbr42YwHCkyVZTNk5SparvC6OQQpd39Lmhy+gmMp
 h/s3F4mP9coLJER+zGBFAzKYurFZE2Rn3AbcCDOqumAi/5VIBfZK2JVDFZ5Ji1oiiiGT
 J6n1s7Zru7Mi2XPL2XYUgGpv0oZ3ciVj5RBTw47v1Z1xkHU4pcvROSnclGG11kcnoFM8
 vaitP5JDzKb+niHBQSYHvQfK+mj9V2N7wEF+Rrw7rBZUfdgm7uDBOiZEeSOjlnB1Hv9a
 BMow==
X-Gm-Message-State: AFuF++nnqU5e5QKvvCzwNAXniyVruNbSG+gtca+m5eauNjdXDX8RuOkc
 lHYZwK41pTZU8fw0681h8WiFFhSDTStvpmDsezg9+QjxAc2j79wisd0m7vSe8W5x77unku94SiF
 PxK4J
X-Gm-Gg: AR+sD13kn8Ud4EFo9jsomJQgWm0lVWyLw4tYFoBEFYAchCSLcrWqJOXrlvQghggIx+X
 CGPABIoXEQ3Emv4Pucrv4ZmIr3eQjtwqpbAuu02ZF3rkLXji+VFyLlwn8FstIGBhOEvRnzQyr8m
 VvBluKCobGHvDNrGwhghaTHMlsO+uQ6WFwGXHTXmB9W6NBrq1WY8lxeWIneUNtTO1MWjwV7+CIF
 3xiZbJ8Yy8NTrZ2iRhKBUG4cfgTQYZ3vJGtSbje/TqY7MOdRYgz4MEFidBAFgY9lUB0Lw/LPmE3
 r4hoqU12G1q2NEKRKZLqkhRJWSkfim6672pp7T20b4rjuq5K8QF3UPhvL6mtcsR4/GV5Up+CF2G
 tKUfREU81zXQJC8fV/XpHmvE0ovNZx9NMH/jBjjh3K+pHdB8YrkIbPtOidPAINdC9a+haff+wAI
 XarEIkE/WgNqfa5YZYDzm3+L7TdwuKv2Yaxf2mSs/1IbO+0KnNWDcJ5J3wT8XbiT0FccNEh0jKV
 ZdXbhlwSGyQ3AbPCccyag==
X-Received: by 2002:a05:6402:450d:b0:6a1:f95b:8cfa with SMTP id
 4fb4d7f45d1cf-6a42f1b47d8mr16482205a12.1.1787586177961; 
 Mon, 24 Aug 2026 08:42:57 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e19a05bsm13368763a12.17.2026.08.24.08.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:42:52 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v7 10/24] usb: dwc3: make the am62 glue build in u-boot
Date: Mon, 24 Aug 2026 17:41:19 +0200
Message-ID: <20260824154133.217744-11-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824154133.217744-1-anders.roxell@linaro.org>
References: <20260824154133.217744-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
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

Adapt the TI AM62 DWC3 glue to u-boot after the resync.

The restore commit deleted dwc3-am62.c, since it was not part of the
v3.19-rc1 import, and the resync brought back the kernel version. That
one has no dwc3_glue_ops, so add ti_am62_ops as static const the way
u-boot had it before.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/dwc3-am62.c | 424 ++++++-----------------------------
 1 file changed, 67 insertions(+), 357 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 9db8f3ca493d..8cb5796b6ad0 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -1,129 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * dwc3-am62.c - TI specific Glue layer for AM62 DWC3 USB Controller
- *
- * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com
+ * TI AM62 specific glue layer for DWC3
  */
 
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/mfd/syscon.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
-#include <linux/pm_runtime.h>
-#include <linux/clk.h>
-#include <linux/regmap.h>
-#include <linux/pinctrl/consumer.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <asm/io.h>
 
-#include "core.h"
+#include "dwc3-generic.h"
 
-/* USB WRAPPER register offsets */
-#define USBSS_PID			0x0
-#define USBSS_OVERCURRENT_CTRL		0x4
-#define USBSS_PHY_CONFIG		0x8
-#define USBSS_PHY_TEST			0xc
-#define USBSS_CORE_STAT			0x14
-#define USBSS_HOST_VBUS_CTRL		0x18
 #define USBSS_MODE_CONTROL		0x1c
-#define USBSS_WAKEUP_CONFIG		0x30
-#define USBSS_WAKEUP_STAT		0x34
-#define USBSS_OVERRIDE_CONFIG		0x38
-#define USBSS_IRQ_MISC_STATUS_RAW	0x430
-#define USBSS_IRQ_MISC_STATUS		0x434
-#define USBSS_IRQ_MISC_ENABLE_SET	0x438
-#define USBSS_IRQ_MISC_ENABLE_CLR	0x43c
-#define USBSS_IRQ_MISC_EOI		0x440
-#define USBSS_INTR_TEST			0x490
-#define USBSS_VBUS_FILTER		0x614
-#define USBSS_VBUS_STAT			0x618
-#define USBSS_DEBUG_CFG			0x708
-#define USBSS_DEBUG_DATA		0x70c
-#define USBSS_HOST_HUB_CTRL		0x714
-
-/* PHY CONFIG register bits */
+#define USBSS_PHY_CONFIG		0x8
 #define USBSS_PHY_VBUS_SEL_MASK		GENMASK(2, 1)
 #define USBSS_PHY_VBUS_SEL_SHIFT	1
-#define USBSS_PHY_LANE_REVERSE		BIT(0)
-
-/* CORE STAT register bits */
-#define USBSS_CORE_OPERATIONAL_MODE_MASK	GENMASK(13, 12)
-#define USBSS_CORE_OPERATIONAL_MODE_SHIFT	12
-
-/* MODE CONTROL register bits */
 #define USBSS_MODE_VALID	BIT(0)
-
-/* WAKEUP CONFIG register bits */
-#define USBSS_WAKEUP_CFG_OVERCURRENT_EN	BIT(3)
-#define USBSS_WAKEUP_CFG_LINESTATE_EN	BIT(2)
-#define USBSS_WAKEUP_CFG_SESSVALID_EN	BIT(1)
-#define USBSS_WAKEUP_CFG_VBUSVALID_EN	BIT(0)
-
-#define USBSS_WAKEUP_CFG_ALL	(USBSS_WAKEUP_CFG_VBUSVALID_EN | \
-				 USBSS_WAKEUP_CFG_SESSVALID_EN | \
-				 USBSS_WAKEUP_CFG_LINESTATE_EN | \
-				 USBSS_WAKEUP_CFG_OVERCURRENT_EN)
-
-#define USBSS_WAKEUP_CFG_NONE	0
-
-/* WAKEUP STAT register bits */
-#define USBSS_WAKEUP_STAT_OVERCURRENT	BIT(4)
-#define USBSS_WAKEUP_STAT_LINESTATE	BIT(3)
-#define USBSS_WAKEUP_STAT_SESSVALID	BIT(2)
-#define USBSS_WAKEUP_STAT_VBUSVALID	BIT(1)
-#define USBSS_WAKEUP_STAT_CLR		BIT(0)
-
-/* IRQ_MISC_STATUS_RAW register bits */
-#define USBSS_IRQ_MISC_RAW_VBUSVALID	BIT(22)
-#define USBSS_IRQ_MISC_RAW_SESSVALID	BIT(20)
-
-/* IRQ_MISC_STATUS register bits */
-#define USBSS_IRQ_MISC_VBUSVALID	BIT(22)
-#define USBSS_IRQ_MISC_SESSVALID	BIT(20)
-
-/* IRQ_MISC_ENABLE_SET register bits */
-#define USBSS_IRQ_MISC_ENABLE_SET_VBUSVALID	BIT(22)
-#define USBSS_IRQ_MISC_ENABLE_SET_SESSVALID	BIT(20)
-
-/* IRQ_MISC_ENABLE_CLR register bits */
-#define USBSS_IRQ_MISC_ENABLE_CLR_VBUSVALID	BIT(22)
-#define USBSS_IRQ_MISC_ENABLE_CLR_SESSVALID	BIT(20)
-
-/* IRQ_MISC_EOI register bits */
-#define USBSS_IRQ_MISC_EOI_VECTOR	BIT(0)
-
-/* VBUS_STAT register bits */
-#define USBSS_VBUS_STAT_SESSVALID	BIT(2)
-#define USBSS_VBUS_STAT_VBUSVALID	BIT(0)
-
-/* USB_PHY_CTRL register bits in CTRL_MMR */
-#define PHY_CORE_VOLTAGE_MASK	BIT(31)
 #define PHY_PLL_REFCLK_MASK	GENMASK(3, 0)
-
-/* USB PHY2 register offsets */
-#define	USB_PHY_PLL_REG12		0x130
-#define	USB_PHY_PLL_LDO_REF_EN		BIT(5)
-#define	USB_PHY_PLL_LDO_REF_EN_EN	BIT(4)
-
-#define DWC3_AM62_AUTOSUSPEND_DELAY	100
-
-#define USBSS_DEBUG_CFG_OFF		0x0
-#define USBSS_DEBUG_CFG_DISABLED	0x7
-
-struct dwc3_am62 {
-	struct device *dev;
-	void __iomem *usbss;
-	struct clk *usb2_refclk;
-	int rate_code;
-	struct regmap *syscon;
-	unsigned int offset;
-	unsigned int vbus_divider;
-	u32 wakeup_stat;
-	void __iomem *phy_regs;
-};
-
-static const int dwc3_ti_rate_table[] = {	/* in KHZ */
+static const int dwc3_ti_am62_rate_table[] = {	/* in KHZ */
 	9600,
 	10000,
 	12000,
@@ -139,277 +33,93 @@ static const int dwc3_ti_rate_table[] = {	/* in KHZ */
 	52000,
 };
 
-static inline u32 dwc3_ti_readl(struct dwc3_am62 *am62, u32 offset)
-{
-	return readl((am62->usbss) + offset);
-}
-
-static inline void dwc3_ti_writel(struct dwc3_am62 *am62, u32 offset, u32 value)
+static void dwc3_ti_am62_glue_configure(struct udevice *dev, int index,
+					enum usb_dr_mode mode)
 {
-	writel(value, (am62->usbss) + offset);
-}
-
-static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
-{
-	struct device *dev = am62->dev;
-	struct device_node *node = dev->of_node;
-	struct regmap *syscon;
-	int ret;
-
-	syscon = syscon_regmap_lookup_by_phandle_args(node, "ti,syscon-phy-pll-refclk",
-						      1, &am62->offset);
-	if (IS_ERR(syscon)) {
-		dev_err(dev, "unable to get ti,syscon-phy-pll-refclk regmap\n");
-		return PTR_ERR(syscon);
-	}
-
-	am62->syscon = syscon;
-
-	/* Core voltage. PHY_CORE_VOLTAGE bit Recommended to be 0 always */
-	ret = regmap_update_bits(am62->syscon, am62->offset, PHY_CORE_VOLTAGE_MASK, 0);
-	if (ret) {
-		dev_err(dev, "failed to set phy core voltage\n");
-		return ret;
-	}
-
-	ret = regmap_update_bits(am62->syscon, am62->offset, PHY_PLL_REFCLK_MASK, am62->rate_code);
-	if (ret) {
-		dev_err(dev, "failed to set phy pll reference clock rate\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static int dwc3_ti_init(struct dwc3_am62 *am62)
-{
-	int ret;
-	u32 reg;
-
-	/* Read the syscon property and set the rate code */
-	ret = phy_syscon_pll_refclk(am62);
-	if (ret)
-		return ret;
-
-	/* Workaround Errata i2409 */
-	if (am62->phy_regs) {
-		reg = readl(am62->phy_regs + USB_PHY_PLL_REG12);
-		reg |= USB_PHY_PLL_LDO_REF_EN | USB_PHY_PLL_LDO_REF_EN_EN;
-		writel(reg, am62->phy_regs + USB_PHY_PLL_REG12);
-	}
-
-	/* VBUS divider select */
-	reg = dwc3_ti_readl(am62, USBSS_PHY_CONFIG);
-	if (am62->vbus_divider)
-		reg |= 1 << USBSS_PHY_VBUS_SEL_SHIFT;
-
-	dwc3_ti_writel(am62, USBSS_PHY_CONFIG, reg);
-
-	clk_prepare_enable(am62->usb2_refclk);
-
-	/* Set mode valid bit to indicate role is valid */
-	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
-	reg |= USBSS_MODE_VALID;
-	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
-
-	return 0;
-}
-
-static int dwc3_ti_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = pdev->dev.of_node;
-	struct dwc3_am62 *am62;
+	struct clk usb2_refclk;
+	int rate_code, i, ret;
 	unsigned long rate;
-	int i, ret;
-
-	am62 = devm_kzalloc(dev, sizeof(*am62), GFP_KERNEL);
-	if (!am62)
-		return -ENOMEM;
-
-	am62->dev = dev;
-	platform_set_drvdata(pdev, am62);
+	u32 reg;
+	void *usbss;
+	bool vbus_divider;
+	struct regmap *syscon;
+	struct ofnode_phandle_args args;
 
-	am62->usbss = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(am62->usbss)) {
+	usbss = dev_remap_addr_index(dev, 0);
+	if (IS_ERR(usbss)) {
 		dev_err(dev, "can't map IOMEM resource\n");
-		return PTR_ERR(am62->usbss);
+		return;
 	}
 
-	am62->usb2_refclk = devm_clk_get(dev, "ref");
-	if (IS_ERR(am62->usb2_refclk)) {
+	ret = clk_get_by_name(dev, "ref", &usb2_refclk);
+	if (ret) {
 		dev_err(dev, "can't get usb2_refclk\n");
-		return PTR_ERR(am62->usb2_refclk);
+		return;
 	}
 
 	/* Calculate the rate code */
-	rate = clk_get_rate(am62->usb2_refclk);
-	rate /= 1000;	// To KHz
-	for (i = 0; i < ARRAY_SIZE(dwc3_ti_rate_table); i++) {
-		if (dwc3_ti_rate_table[i] == rate)
+	rate = clk_get_rate(&usb2_refclk);
+	rate /= 1000;	/* To KHz */
+	for (i = 0; i < ARRAY_SIZE(dwc3_ti_am62_rate_table); i++) {
+		if (dwc3_ti_am62_rate_table[i] == rate)
 			break;
 	}
 
-	if (i == ARRAY_SIZE(dwc3_ti_rate_table)) {
+	if (i == ARRAY_SIZE(dwc3_ti_am62_rate_table)) {
 		dev_err(dev, "unsupported usb2_refclk rate: %lu KHz\n", rate);
-		return -EINVAL;
+		return;
 	}
 
-	am62->rate_code = i;
+	rate_code = i;
 
-	am62->phy_regs = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(am62->phy_regs)) {
-		dev_err(dev, "can't map PHY IOMEM resource. Won't apply i2409 fix.\n");
-		am62->phy_regs = NULL;
+	/* Read the syscon property */
+	syscon = syscon_regmap_lookup_by_phandle(dev, "ti,syscon-phy-pll-refclk");
+	if (IS_ERR(syscon)) {
+		dev_err(dev, "unable to get ti,syscon-phy-pll-refclk regmap\n");
+		return;
 	}
 
-	am62->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
-
-	ret = dwc3_ti_init(am62);
+	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "ti,syscon-phy-pll-refclk", NULL, 1,
+					     0, &args);
 	if (ret)
-		return ret;
+		return;
 
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-	/*
-	 * Don't ignore its dependencies with its children
-	 */
-	pm_suspend_ignore_children(dev, false);
-	pm_runtime_get_noresume(dev);
-
-	ret = of_platform_populate(node, NULL, NULL, dev);
+	/* Program PHY PLL refclk by reading syscon property */
+	ret = regmap_update_bits(syscon, args.args[0], PHY_PLL_REFCLK_MASK, rate_code);
 	if (ret) {
-		dev_err(dev, "failed to create dwc3 core: %d\n", ret);
-		goto err_pm_disable;
-	}
-
-	/* Device has capability to wakeup system from sleep */
-	device_set_wakeup_capable(dev, true);
-	ret = device_wakeup_enable(dev);
-	if (ret)
-		dev_err(dev, "couldn't enable device as a wakeup source: %d\n", ret);
-
-	/* Setting up autosuspend */
-	pm_runtime_set_autosuspend_delay(dev, DWC3_AM62_AUTOSUSPEND_DELAY);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
-	return 0;
-
-err_pm_disable:
-	clk_disable_unprepare(am62->usb2_refclk);
-	pm_runtime_disable(dev);
-	pm_runtime_set_suspended(dev);
-	return ret;
-}
-
-static void dwc3_ti_remove(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct dwc3_am62 *am62 = platform_get_drvdata(pdev);
-	u32 reg;
-
-	pm_runtime_get_sync(dev);
-	device_init_wakeup(dev, false);
-	of_platform_depopulate(dev);
-
-	/* Clear mode valid bit */
-	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
-	reg &= ~USBSS_MODE_VALID;
-	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
-
-	pm_runtime_put_sync(dev);
-	pm_runtime_disable(dev);
-	pm_runtime_dont_use_autosuspend(dev);
-	pm_runtime_set_suspended(dev);
-}
-
-#ifdef CONFIG_PM
-static int dwc3_ti_suspend_common(struct device *dev)
-{
-	struct dwc3_am62 *am62 = dev_get_drvdata(dev);
-	u32 reg, current_prtcap_dir;
-
-	if (device_may_wakeup(dev)) {
-		reg = dwc3_ti_readl(am62, USBSS_CORE_STAT);
-		current_prtcap_dir = (reg & USBSS_CORE_OPERATIONAL_MODE_MASK)
-				     >> USBSS_CORE_OPERATIONAL_MODE_SHIFT;
-		/* Set wakeup config enable bits */
-		reg = dwc3_ti_readl(am62, USBSS_WAKEUP_CONFIG);
-		if (current_prtcap_dir == DWC3_GCTL_PRTCAP_HOST) {
-			reg = USBSS_WAKEUP_CFG_LINESTATE_EN | USBSS_WAKEUP_CFG_OVERCURRENT_EN;
-		} else {
-			reg = USBSS_WAKEUP_CFG_VBUSVALID_EN | USBSS_WAKEUP_CFG_SESSVALID_EN;
-			/*
-			 * Enable LINESTATE wake up only if connected to bus
-			 * and in U2/L3 state else it causes spurious wake-up.
-			 */
-		}
-		dwc3_ti_writel(am62, USBSS_WAKEUP_CONFIG, reg);
-		/* clear wakeup status so we know what caused the wake up */
-		dwc3_ti_writel(am62, USBSS_WAKEUP_STAT, USBSS_WAKEUP_STAT_CLR);
-	}
-
-	/* just to track if module resets on suspend */
-	dwc3_ti_writel(am62, USBSS_DEBUG_CFG, USBSS_DEBUG_CFG_DISABLED);
-
-	clk_disable_unprepare(am62->usb2_refclk);
-
-	return 0;
-}
-
-static int dwc3_ti_resume_common(struct device *dev)
-{
-	struct dwc3_am62 *am62 = dev_get_drvdata(dev);
-	u32 reg;
-
-	reg = dwc3_ti_readl(am62, USBSS_DEBUG_CFG);
-	if (reg != USBSS_DEBUG_CFG_DISABLED) {
-		/* lost power/context */
-		dwc3_ti_init(am62);
-	} else {
-		dwc3_ti_writel(am62, USBSS_DEBUG_CFG, USBSS_DEBUG_CFG_OFF);
-		clk_prepare_enable(am62->usb2_refclk);
+		dev_err(dev, "failed to set phy pll reference clock rate\n");
+		return;
 	}
 
-	if (device_may_wakeup(dev)) {
-		/* Clear wakeup config enable bits */
-		dwc3_ti_writel(am62, USBSS_WAKEUP_CONFIG, USBSS_WAKEUP_CFG_NONE);
-	}
+	/* VBUS divider select */
+	reg = readl(usbss + USBSS_PHY_CONFIG);
+	vbus_divider = dev_read_bool(dev, "ti,vbus-divider");
+	if (vbus_divider)
+		reg |= 1 << USBSS_PHY_VBUS_SEL_SHIFT;
 
-	reg = dwc3_ti_readl(am62, USBSS_WAKEUP_STAT);
-	am62->wakeup_stat = reg;
+	writel(reg, usbss + USBSS_PHY_CONFIG);
 
-	return 0;
+	/* Set mode valid */
+	reg = readl(usbss + USBSS_MODE_CONTROL);
+	reg |= USBSS_MODE_VALID;
+	writel(reg, usbss + USBSS_MODE_CONTROL);
 }
 
-static UNIVERSAL_DEV_PM_OPS(dwc3_ti_pm_ops, dwc3_ti_suspend_common,
-			    dwc3_ti_resume_common, NULL);
-
-#define DEV_PM_OPS	(&dwc3_ti_pm_ops)
-#else
-#define DEV_PM_OPS	NULL
-#endif /* CONFIG_PM */
-
-static const struct of_device_id dwc3_ti_of_match[] = {
-	{ .compatible = "ti,am62-usb"},
-	{},
+static const struct dwc3_glue_ops ti_am62_ops = {
+	.glue_configure = dwc3_ti_am62_glue_configure,
 };
-MODULE_DEVICE_TABLE(of, dwc3_ti_of_match);
 
-static struct platform_driver dwc3_ti_driver = {
-	.probe		= dwc3_ti_probe,
-	.remove		= dwc3_ti_remove,
-	.driver		= {
-		.name	= "dwc3-am62",
-		.pm	= DEV_PM_OPS,
-		.of_match_table = dwc3_ti_of_match,
-	},
+static const struct udevice_id dwc3_am62_match[] = {
+	{ .compatible = "ti,am62-usb", .data = (ulong)&ti_am62_ops },
+	{ /* sentinel */ }
 };
 
-module_platform_driver(dwc3_ti_driver);
-
-MODULE_ALIAS("platform:dwc3-am62");
-MODULE_AUTHOR("Aswath Govindraju <a-govindraju@ti.com>");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("DesignWare USB3 TI Glue Layer");
+U_BOOT_DRIVER(dwc3_am62_wrapper) = {
+	.name	= "dwc3-am62",
+	.id	= UCLASS_SIMPLE_BUS,
+	.of_match = dwc3_am62_match,
+	.bind = dwc3_glue_bind,
+	.probe = dwc3_glue_probe,
+	.remove = dwc3_glue_remove,
+	.plat_auto	= sizeof(struct dwc3_glue_data),
+};
-- 
2.53.0

