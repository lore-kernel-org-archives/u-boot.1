Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D8AC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:47:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9161981184;
	Mon, 24 Aug 2026 16:47:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yl2i5iNjs0zK; Mon, 24 Aug 2026 16:47:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589938;
	bh=Zu4myBCENGDa39S6adNwIcYjaDG/BKNJ9paH9K5+/3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VM91p32ojVj5g5kdTVMrkVZ2lhqNVbaXIK5+Lxeg9ciSXLUgmUQ9NaVbzr9rvlbsg
	 f/wqnmwtVQqjk+bu4OgzxyDMe47orR+8i7KMMrjE+CF0NsYpBzQU3mq+vRSM0GhuFm
	 x8HeGx3kyfbhCRa+YpKoz4AhyBknSwcoZ8bZviiFI6yHklxkgHN29E5NhyiO+OZ1Ns
	 1dKBCiO4CZ+zjOZ3bVIGtUW/WX1OOPRMsOB8cewtWAkKp1a1H9xd40fD3I5O87kgFH
	 uXxluL29o8qu9CO73K17nt+CLPzskBFaPDx852V4ZDmSqn19ZEYkrYiKwW9DVCAxZr
	 FjM9Rmojz7tHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D05E480F4A;
	Mon, 24 Aug 2026 16:45:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D0647396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C251A60627
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:42:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Un42cHra5Ciy for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:42:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=N/9JXVOU
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF713605F0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:42:15 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c166ec26696so31882066b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787586134; x=1788190934;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zu4myBCENGDa39S6adNwIcYjaDG/BKNJ9paH9K5+/3g=;
 b=N/9JXVOUYBXgpgxjKihWPjXmJUCfbnG8Bq5RwgJa40dTZ6GpKiDgoMZDBiE97/9cWC
 j+FYvWxJnRuWHXIHA/j23Tvlarngeaq5H94CT145X6BycvfJLtWOv9sHsSYSGXgL2uBT
 Oq+AKjyiLI7jjcc0/SI6GFbKDw1+MTfhCjCaclPYxqJ9vvY05G/9p3iSgmy/VtFxstEu
 vfq99X3wM8GNn/kRu2muQ0lkp4XtX3TtOmFwT07OTtDbVlCby15hVp9ZZbBjAXFC5Ic8
 QWGfMlAOKw3TCHJvuW6ZJ3JpVR7AQh3aIpO2+X8xN/m2cgDC0kowBrViDboR/c4x5CE4
 xkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787586134; x=1788190934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zu4myBCENGDa39S6adNwIcYjaDG/BKNJ9paH9K5+/3g=;
 b=SrNhtF1NOuLA3PpOWR4QVGq6cD76OpHAoVI/XbmoueudN5AsK3OR6UKegXnTL6wadj
 RDl8ZKdeyjjDng9aczHtArGHRcvYM7WwKUcu2Cydt3Zl/eHPERoazNvqDUFnmffQBbU2
 ri15RfJJbzlEl0Ek8//JW0I6pz1KM5Gw0xuQ/wwnNdeyc15gsyJolYBA5XErIjfrRl51
 +Nzsllb9DMMePpvJCvEjfvjsaEVdT777lW+rZYM/AvDYIdYIJg0QdbVC6kg6Y/qcvVw6
 /O/JKBQHGlaP8xTzkZ4+mBiKIMObDnkHq7HTR/HjMNbxX8qJCeN7jwHszlYXkVFRDTJU
 gh7g==
X-Gm-Message-State: AFuF++k3kCV5R/OpryWxdQigovicG7FAnG5x4Wwon/hprg62ZtgmuMcH
 YpGeTy6bZ9ZbeqbLA/lp5B69EmeIde3MDH8RufTRCVxXHqOdQ9qLYzkH/kttg1lGQrYWSLSzyz+
 p0I6a
X-Gm-Gg: AR+sD12uF7xGXyOHPvNqcokU58zT2+d/m2aakOGoZiO59dPG6TvNS0vy+R9+QoAzgTS
 aBwZ32tY0UL1i2O2N49ICYuB0uHPTl+XXNoMUOp7Clep5Bg0VQrdUkzD5Rzw4uqqdRTXqZjnHZs
 fthRm79K3t9bdko/aRg8KEYMXTypRblMEgO10uIzC6bT6kXWHeLlYfvXz6wuuRq5/wWypfKYzst
 Lxu6PMhdeRAcHbRj9bRyntecNPsrMPiPOPKKq+x6C4TP3UF52QSBJKxAk9j1NFi81iJ5kzMiudn
 94RNN1U4d/oxzaVEY6+lcC0mUbf7ig4QKxv5RvCAbDLy6dZSz33ca1GOnm/8Oq9fYQ/hLs4jZ/i
 QAUAET8PFm5NBfA2fzICPbe9WNT6W/S7LCsXMB70XtkoUANNTXLPtMgTYSsq15Zz9CLHcq+GfXP
 fXDJjEEoRSICWWJfU37F+UwPAOJFSlvT9JymhWNWiGzxsfeUHxGvPHLMt6gV7dk0EPel0YE3kzs
 7pbwSyEg3bip30cYpV54w==
X-Received: by 2002:a17:907:f497:b0:c16:604a:b2bd with SMTP id
 a640c23a62f3a-c246a61c431mr1527129266b.3.1787586133647; 
 Mon, 24 Aug 2026 08:42:13 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f58dfsm1278567866b.38.2026.08.24.08.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:42:12 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v7 06/24] usb: dwc3: bring back the samsung usb phy driver
Date: Mon, 24 Aug 2026 17:41:15 +0200
Message-ID: <20260824154133.217744-7-anders.roxell@linaro.org>
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

The restore commit at the start of this series deletes samsung_usb_phy.c,
because the file was not part of the original v3.19-rc1 import. It never
came from the kernel, it is u-boot code added later.

Nothing added it back, but CONFIG_USB_DWC3_PHY_SAMSUNG is still in
Kconfig and odroid-xu3_defconfig still selects it. exynos5-dt.c calls
exynos5_usb3_phy_init() from this file, so that board would lose its USB
3.0 phy setup.

Bring the file back unchanged and add it to the Makefile again.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/Makefile          |  1 +
 drivers/usb/dwc3/samsung_usb_phy.c | 77 ++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 drivers/usb/dwc3/samsung_usb_phy.c

diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index 63c7c6063002..a5775c4bea04 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_USB_DWC3_OMAP)		+= dwc3-omap.o
 obj-$(CONFIG_USB_DWC3_STI)		+= dwc3-generic-sti.o
 obj-$(CONFIG_USB_DWC3_UNIPHIER)		+= dwc3-uniphier.o
 obj-$(CONFIG_USB_DWC3_PHY_OMAP)		+= ti_usb_phy.o
+obj-$(CONFIG_USB_DWC3_PHY_SAMSUNG)	+= samsung_usb_phy.o
diff --git a/drivers/usb/dwc3/samsung_usb_phy.c b/drivers/usb/dwc3/samsung_usb_phy.c
new file mode 100644
index 000000000000..3563070cb85d
--- /dev/null
+++ b/drivers/usb/dwc3/samsung_usb_phy.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * samsung_usb_phy.c - DesignWare USB3 (DWC3) PHY handling file
+ *
+ * Copyright (C) 2015 Samsung Electronics
+ *
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ */
+
+#include <asm/io.h>
+#include <asm/arch/power.h>
+#include <asm/arch/xhci-exynos.h>
+#include <linux/delay.h>
+
+void exynos5_usb3_phy_init(struct exynos_usb3_phy *phy)
+{
+	u32 reg;
+
+	/* Reset USB 3.0 PHY */
+	writel(0x0, &phy->phy_reg0);
+
+	clrbits_le32(&phy->phy_param0,
+			/* Select PHY CLK source */
+			PHYPARAM0_REF_USE_PAD |
+			/* Set Loss-of-Signal Detector sensitivity */
+			PHYPARAM0_REF_LOSLEVEL_MASK);
+	setbits_le32(&phy->phy_param0, PHYPARAM0_REF_LOSLEVEL);
+
+	writel(0x0, &phy->phy_resume);
+
+	/*
+	 * Setting the Frame length Adj value[6:1] to default 0x20
+	 * See xHCI 1.0 spec, 5.2.4
+	 */
+	setbits_le32(&phy->link_system,
+			LINKSYSTEM_XHCI_VERSION_CONTROL |
+			LINKSYSTEM_FLADJ(0x20));
+
+	/* Set Tx De-Emphasis level */
+	clrbits_le32(&phy->phy_param1, PHYPARAM1_PCS_TXDEEMPH_MASK);
+	setbits_le32(&phy->phy_param1, PHYPARAM1_PCS_TXDEEMPH);
+
+	setbits_le32(&phy->phy_batchg, PHYBATCHG_UTMI_CLKSEL);
+
+	/* PHYTEST POWERDOWN Control */
+	clrbits_le32(&phy->phy_test,
+			PHYTEST_POWERDOWN_SSP |
+			PHYTEST_POWERDOWN_HSP);
+
+	/* UTMI Power Control */
+	writel(PHYUTMI_OTGDISABLE, &phy->phy_utmi);
+
+		/* Use core clock from main PLL */
+	reg = PHYCLKRST_REFCLKSEL_EXT_REFCLK |
+		/* Default 24Mhz crystal clock */
+		PHYCLKRST_FSEL(FSEL_CLKSEL_24M) |
+		PHYCLKRST_MPLL_MULTIPLIER_24MHZ_REF |
+		PHYCLKRST_SSC_REFCLKSEL(0) |
+		/* Force PortReset of PHY */
+		PHYCLKRST_PORTRESET |
+		/* Digital power supply in normal operating mode */
+		PHYCLKRST_RETENABLEN |
+		/* Enable ref clock for SS function */
+		PHYCLKRST_REF_SSP_EN |
+		/* Enable spread spectrum */
+		PHYCLKRST_SSC_EN |
+		/* Power down HS Bias and PLL blocks in suspend mode */
+		PHYCLKRST_COMMONONN;
+
+	writel(reg, &phy->phy_clk_rst);
+
+	/* giving time to Phy clock to settle before resetting */
+	udelay(10);
+
+	reg &= ~PHYCLKRST_PORTRESET;
+	writel(reg, &phy->phy_clk_rst);
+}
-- 
2.53.0

