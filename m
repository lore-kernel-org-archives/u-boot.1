Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C190BC54E58
	for <u-boot@archiver.kernel.org>; Sun, 10 Mar 2024 12:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51F5E87E29;
	Sun, 10 Mar 2024 13:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ChPRpuqL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C8C987E0A; Sun, 10 Mar 2024 06:58:46 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 394A587CF2
 for <u-boot@lists.denx.de>; Sun, 10 Mar 2024 06:58:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e5a50d91b4so2023985b3a.2
 for <u-boot@lists.denx.de>; Sat, 09 Mar 2024 21:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710050321; x=1710655121; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lrVbYAF3HAxcWzCjQkr2Zz9lOxcR5w9VAnBLZJPAAMQ=;
 b=ChPRpuqL6WfUXkMwwtWDoI1IqUBqlYABaf9IH3A32dKWLVI6TXIKpOk1zDPtxNo4k5
 tprxRlbJu7rEpWkLcQJK54666svP6eqYykSMRmO0xx9LoY5x0FUgRPtwGPhvV0Pfo3pB
 6B4XyS0zMOyeD4pH2PLrISUv1aprac82wsOLtg+8H9HTSaFjvrIYB7IzaMn+XiFSAg1t
 kEyR6Vrg0r2yXu4R3A16BnTEq47vOVpDXt7EqPo+exzlrdpvBzLqwpSDVfwvo2fCCmA9
 inY+5fTY0I1w1EmwXQcHwKftFNMDe0G9CMd3EB7Qec7BV02ojvKLpzRWmP8DeylqWNI3
 70cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710050321; x=1710655121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lrVbYAF3HAxcWzCjQkr2Zz9lOxcR5w9VAnBLZJPAAMQ=;
 b=EuUw69Xz2Da7Ed4EcpvRk90JhYxpjIWTb7ZTNQLhiBxySClC2X+y+4jM9WijzR+w3w
 r57o+lIhHd/1gApst7NUTYgt9pz0fZD3OzWNzaUcOL7TVF69E+N2EshzYsyEAUPlTzvQ
 dyKkna1v6cNZJyh5zadELXppQJwoT0E8u59n/HsIEugtsIpB5wxyqYi/4WK9O+VD6oqQ
 v2S7ojynaUYjtPBicmD1Rrew1Mua5pNHD596TmHYxG6HfO/517lge/gcuYvhqUPEi2L7
 flr4glb0eRE9SIt6iPLWqIqcxqrLqlkkl79ZGigFv+RQkYWbIzOsDJqc9y4TcifNNAJ0
 oriQ==
X-Gm-Message-State: AOJu0YzxkZaI+ua8JX/qSzO58XzJWWzH+hZ7lpSaVEpZRnoSEsA+kUrM
 fOBFdt1bNDNrJwHa8sf+wVcCeUvb7jQ7SaE7y2BOUjZR/SzyypELB/cVspRbLS3w9g==
X-Google-Smtp-Source: AGHT+IGXGAa9UdIQfwwNmbga2LnX1J7k973QHVjRAx5NVgJVIVGbcPiW6b0FNqQs17+cj2cDN+1FCA==
X-Received: by 2002:a05:6a00:114b:b0:6e5:ce7e:929f with SMTP id
 b11-20020a056a00114b00b006e5ce7e929fmr4461060pfm.7.1710050321484; 
 Sat, 09 Mar 2024 21:58:41 -0800 (PST)
Received: from localhost.localdomain ([117.135.91.249])
 by smtp.gmail.com with ESMTPSA id
 i15-20020aa787cf000000b006e508b6a13dsm2037522pfo.58.2024.03.09.21.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 21:58:41 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Baruch Siach <baruch@tkos.co.il>, Joe Hershberger <joe.hershberger@ni.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Nils Le Roux <gilbsgilbert@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] board: milkv_duo: Add init code for Milk-V Duo ethernet
Date: Sun, 10 Mar 2024 13:56:44 +0800
Message-ID: <20240310055816.11575-2-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240310055816.11575-1-seashell11234455@gmail.com>
References: <20240310055816.11575-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 10 Mar 2024 13:10:19 +0100
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

Initialize register in cv1800b ethernet phy to make it compatible with
generic phy driver

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>

---

 board/sophgo/milkv_duo/Makefile   |  3 +-
 board/sophgo/milkv_duo/board.c    |  4 ++
 board/sophgo/milkv_duo/ethernet.c | 79 +++++++++++++++++++++++++++++++
 board/sophgo/milkv_duo/ethernet.h | 11 +++++
 drivers/net/designware.c          |  1 +
 5 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 board/sophgo/milkv_duo/ethernet.c
 create mode 100644 board/sophgo/milkv_duo/ethernet.h

diff --git a/board/sophgo/milkv_duo/Makefile b/board/sophgo/milkv_duo/Makefile
index a087013f5c..d0525eba85 100644
--- a/board/sophgo/milkv_duo/Makefile
+++ b/board/sophgo/milkv_duo/Makefile
@@ -2,4 +2,5 @@
 #
 # Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
 
-obj-y := board.o
+obj-y += board.o
+obj-$(CONFIG_NET) += ethernet.o
diff --git a/board/sophgo/milkv_duo/board.c b/board/sophgo/milkv_duo/board.c
index eaa47be173..311576fe1c 100644
--- a/board/sophgo/milkv_duo/board.c
+++ b/board/sophgo/milkv_duo/board.c
@@ -3,7 +3,11 @@
  * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
  */
 
+#include "ethernet.h"
+
 int board_init(void)
 {
+	if (IS_ENABLED(CONFIG_NET))
+		cv1800b_ephy_init();
 	return 0;
 }
diff --git a/board/sophgo/milkv_duo/ethernet.c b/board/sophgo/milkv_duo/ethernet.c
new file mode 100644
index 0000000000..e997ce1037
--- /dev/null
+++ b/board/sophgo/milkv_duo/ethernet.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ */
+
+#include <linux/io.h>
+#include <linux/bitops.h>
+#include <linux/mii.h>
+
+#define REG_EPHY_TOP_WRAP (u32 *)0x03009800
+#define REG_EPHY_BASE     (u32 *)0x03009000
+
+#define REG_EPHY_CTL         REG_EPHY_TOP_WRAP
+#define REG_EPHY_APB_RW_SEL  REG_EPHY_TOP_WRAP + 1
+
+/* Page 0 register */
+#define REG_PHY_ID1          REG_EPHY_BASE + MII_PHYSID1
+#define REG_PHY_ID2          REG_EPHY_BASE + MII_PHYSID2
+#define REG_PHY_PAGE_SEL     REG_EPHY_BASE + 0x1f
+
+/* Page 5 register */
+#define REG_PD_EN_CTL        REG_EPHY_BASE + 0x10
+
+/* REG_EPHY_CTL */
+#define REG_EPHY_SHUTDOWN    BIT(0)
+#define REG_EPHY_ANA_RST_N   BIT(1)
+#define REG_EPHY_DIG_RST_N   BIT(2)
+#define REG_EPHY_MAIN_RST_N  BIT(3)
+
+/* REG_PD_EN_CTL */
+#define REG_EN_ETH_TXRT          BIT(0)
+#define REG_EN_ETH_CLK100M       BIT(1)
+#define REG_EN_ETH_CLK125M       BIT(2)
+#define REG_EN_ETH_PLL_LCKDET    BIT(3)
+#define REG_EN_ETH_RXADC         BIT(4)
+#define REG_EN_ETH_RXPGA         BIT(5)
+#define REG_EN_ETH_RXRT          BIT(6)
+#define REG_EN_ETH_TXCROSSOVER   BIT(7)
+#define REG_PD_ETH_PLL           BIT(8)
+#define REG_PD_ETH_TXDAC         BIT(9)
+#define REG_PD_ETH_TXDACBST      BIT(10)
+#define REG_PD_ETH_TXECHO        BIT(11)
+#define REG_PD_ETH_TXDRV_NMOS    BIT(12)
+#define REG_PD_ETH_TXLDO         BIT(13)
+
+void cv1800b_ephy_init(void)
+{
+	u32 reg;
+	u32 phy_id = 1;
+
+	/* enable direct memory access for phy register */
+	writel(1, REG_EPHY_APB_RW_SEL);
+
+	reg = readl(REG_EPHY_CTL);
+	reg &= ~REG_EPHY_SHUTDOWN;
+	reg |= REG_EPHY_ANA_RST_N | REG_EPHY_DIG_RST_N | REG_EPHY_MAIN_RST_N;
+	writel(reg, REG_EPHY_CTL);
+
+	/* switch to page 5 */
+	writel(5 << 8, REG_PHY_PAGE_SEL);
+	reg = readl(REG_PD_EN_CTL);
+	reg &= ~(REG_PD_ETH_TXLDO | REG_PD_ETH_TXDRV_NMOS | REG_PD_ETH_TXDAC | REG_PD_ETH_PLL);
+	reg |= REG_EN_ETH_TXRT | REG_EN_ETH_CLK100M | REG_EN_ETH_CLK125M
+		| REG_EN_ETH_PLL_LCKDET | REG_EN_ETH_RXADC | REG_EN_ETH_RXPGA | REG_EN_ETH_RXRT;
+	writel(reg, REG_PD_EN_CTL);
+
+	/* switch to page 0 */
+	writel(0 << 8, REG_PHY_PAGE_SEL);
+	/*
+	 * As the phy_id in the cv1800b PHY register is initialized to 0, it
+	 * is necessary to manually initialize the phy_id to an arbitrary
+	 * value so that it could corresponds to the generic PHY driver.
+	 */
+	writel(phy_id >> 16, REG_PHY_ID1);
+	writel(phy_id & 0xffff, REG_PHY_ID2);
+
+	/* switch to MDIO control */
+	writel(0, REG_EPHY_APB_RW_SEL);
+}
diff --git a/board/sophgo/milkv_duo/ethernet.h b/board/sophgo/milkv_duo/ethernet.h
new file mode 100644
index 0000000000..7b21f1b0f6
--- /dev/null
+++ b/board/sophgo/milkv_duo/ethernet.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ */
+
+#ifndef __CV1800B_ETHERNET_H
+#define __CV1800B_ETHERNET_H
+
+void cv1800b_ephy_init(void);
+
+#endif
diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index c222197b11..e4e173f9fd 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -861,6 +861,7 @@ static const struct udevice_id designware_eth_ids[] = {
 	{ .compatible = "amlogic,meson6-dwmac" },
 	{ .compatible = "st,stm32-dwmac" },
 	{ .compatible = "snps,arc-dwmac-3.70a" },
+	{ .compatible = "sophgo,cv1800b-ethernet" },
 	{ }
 };
 
-- 
2.41.0

