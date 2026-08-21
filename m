Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8C8C5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:15:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D82940DBA;
	Fri, 21 Aug 2026 13:15:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jMz-w6v3G5Rg; Fri, 21 Aug 2026 13:15:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318126;
	bh=Zu4myBCENGDa39S6adNwIcYjaDG/BKNJ9paH9K5+/3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bcmxxu7lf07WFwO10AthlbcbJtr/AQfh3wkqqRNh7ChO0Kk3FqwQGW8K0nX2CD81C
	 WzPsePnS03NJyCPECaPWd4N2LDcqG2TK96EjGo2KHj0usROtYMdNxs/FMYl+JRTiMS
	 rc+0VHYkPezRxrcUCcltTYToTCvxZBusvgWoR+Td1C3qrrBaf0eCi1i45C2OCNhHNQ
	 I0V3w3jewS2u1wnS2a5hKgXDuzWjN5KSQ7Px9fUKJcbJg+/q9xp64fK/v69CJz6Ycb
	 FVhTLhjgXMl5DCG5XXbEmsYs9mm8pI6TtU3h0/iwoReoa3S4S85UB6XbXIYETX8zAZ
	 tO0JhVivGq4Tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A41740D91;
	Fri, 21 Aug 2026 13:15:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2120A263
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 069B54090E
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HMcuP6pTxwye for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=CiLyQutz
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C8781407E5
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:30 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c15e62c695cso6683166b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302349; x=1787907149;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zu4myBCENGDa39S6adNwIcYjaDG/BKNJ9paH9K5+/3g=;
 b=CiLyQutzav6rRDaTyNV0h1lrAbjXhP3vmd/aclI7yZF8IQp78xSK1lZIqpfPaW9/a3
 WcczCC2yHlWtI0Gjr8lZGztcoozwj/gzO+K218SmKJvjhTj0/McFTkvX0p3f2Mc2z1vP
 a7Bwl3FNT8iTVpks0VqFR84Gv/3AcQ+RZwDB7q40cjbrr3adxIly55zRu7ZuA0ZQRD3S
 OWPaKPL9qNYZPf9cZ856Ohx26XkqBmZ/pJynZpY+sb3gipa4r6KXEuUbebVKz+eHLW7m
 F4x8sAIxoKPKHOfC7VRVUnmHthH/YU5rgBrORApgebv8e2VF/qI17/nMJC7p0f5WjCkF
 bIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302349; x=1787907149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zu4myBCENGDa39S6adNwIcYjaDG/BKNJ9paH9K5+/3g=;
 b=OG/OWetB7dvRHiHHtRqu/k0o28zKKmcQ0b2hBBjHQOnkaCoCHwA4wYPT7abFRPKOzj
 n6lnhfmggkWdb9C5xauEQLgby7pfcUM4lg9V6TeSPpCTNF4NshFClxTam6EhQExfFTig
 UyePixJA1lEswjeOVDwZhmfw69DfB6xfxvq6+QBlTcCf3A5CyVQzgqnqmV/PtfDfyDaX
 93DhxCiOF5OhzJSIMVtRrLr33Z7VQwHSdr7gdjCr5OKAMK8liIEhghKLieK4bBJaGGbJ
 Zlh92yOetNUvH4QtZrdk336YS3GGAWGo0PMoyC04YMLWp+OLGPQPKFeR+3z2hmFe2fI9
 omMw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpoqU+iudZkNEfKGtXeRlUErAOwqLhVaZJDoA9HMFLc7d9TerQJZ/ODdtEtGREgZFLc4ciJSP4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lwKwxTUFZA8vyuvrHJQwn/BfFLubQXDItmvLcJGHQsDIFLCewY
 UqHUmP4YzsQ5RkCk4vrj7vmhoXlf83f6dAocCXIexFlK2kC/SZ+IrKfYLI8qzWXDfLk=
X-Gm-Gg: AR+sD10eguqTu7wKRyHJrr/rdnEDIFBjiE1kZEFhGX1/xtWgrLwszuKz+HvzHlOqweu
 /txxJU9+1hBlyMDzmZEwwyyyaZYmuKta3WahHX4O/mppTnFZlSJdxLLqKxuw7pq3QNbt9rwZDkx
 XWteDxV5sXk0U/Tcp231/ccX/Lrm/39R1sHbK9afv9fcflbjWYyzZsWWzMo/I/rJHnyD+EVyx/k
 t+7Fjs+Mc6JgC+KdNUvB4a6USmz9ldgaWCl7cMA7gy7o3iqHkXUcQboZMOXXqTkA/fQjkvHgKUj
 7vm1F5+bi03WXc783iw02EKYqpvgsrN1koGgw1ydL91kakOic9+Lv52agSAyNNaNw8yeLsAy54d
 uvScW99EIvUIBM2MdyVahTCqU/f20RmfGcAySmJhURV5OnO5YOcJ5FbVm/oumzX/xFn8be2eFsz
 yy6fM7+IJPnEXKx1WSWOBeO0QMHbuDBx+7NIiZ4j4s4GJqQOcBOb0M8HZX8ottx6D5pRYlWMmV2
 eVn5PNuNH8/+4FM2q0iEM+VKwBcZCkX3Dw=
X-Received: by 2002:a17:907:1c26:b0:c21:8555:5f55 with SMTP id
 a640c23a62f3a-c246a65eda7mr256393666b.2.1787302348619; 
 Fri, 21 Aug 2026 01:52:28 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2458b09599sm353899266b.21.2026.08.21.01.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:28 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 69/87] usb: dwc3: bring back the samsung usb phy driver
Date: Fri, 21 Aug 2026 10:47:45 +0200
Message-ID: <20260821084829.2070426-70-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:40 +0000
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

