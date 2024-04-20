Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F53C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 10:11:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF60A881F1;
	Sat, 20 Apr 2024 12:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DnGugkEK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B928788126; Sat, 20 Apr 2024 09:02:14 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DB0488113
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 09:02:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e9451d8b71so460315ad.0
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 00:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713596530; x=1714201330; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b4HMI7ogsDpqemN6nGDHwk7wgIpxBXEZwDDnPP1+5nA=;
 b=DnGugkEKP22ZVK6WZ1SAlzQM47Fc63BHniNKXqeaTbnfS2gg0z3NIf0Tuu7nJt/3EX
 3fJc41qm55btqfUqaFju898CE/Nf2TbNg9e7CG5bt+o/TC+WOoQeP+zpmcf0AzXzV2m0
 3xdfo72JvfWEu5zLjA74+9ZhsswrEvhcA1xREw5fTZI84yIxUGlVI0AkrhEETdDq1rjZ
 CA1B38+so2h6K0r81tmYoVC5uw/Yx1XKrZh7c3/bj60fZfG2wZSVYUopfiKvF0BNLnrz
 bp16zS5KlCqsHs9Zedgmu34hpyg0e6wDMSuJXxAWlnqbNpw0eLhwihljEFJZ29KXN7Y9
 VWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713596530; x=1714201330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b4HMI7ogsDpqemN6nGDHwk7wgIpxBXEZwDDnPP1+5nA=;
 b=lAULLejrqqZ18/7TYmxSlpGozMwGQEMg60ulAWEIWtP2vnlM28pA1T6FuKvTMTmTts
 0iIK3qL3Eb2aMcLHCanax8CUASC3bnlr4+PMrnc4NXBEmgjw6sQ1Ii8LzdTpIct7ZTL0
 mq8Elo8j/2tumZ0CyaAmtUwFDT7vJXVunN3qR8q7NhtCV6UQ9b7/H7Q/NxLglxQAjBx8
 HRTJe0dgUBL/Ge9WGJcI0oJqyPbYqigYpjW5ajKrEDjI3iJ2U2lzFPYdq2rB5Yz6lMB2
 UpB4y0F/jpGZuOsKKV/sohu5EPPdJMBhZHU5szaKlWBDm3A1eKBEDiELHgicyAyrBIYd
 8y5w==
X-Gm-Message-State: AOJu0YxWK8RJUWtlk8nATlXtREIwYyNh3gA6J9wW6uAipz5ZDgFldKJa
 DB3kNjY6GOBdrz0TtWd3wxbQVoxwju47xUtWj4wk/CGXIdbCzV8IGjLxxcp7hpA=
X-Google-Smtp-Source: AGHT+IHXtZ8ikFCclAdGX0S87ZwtN1X9ISUPF7NmwRKZaX9BKmh0V6F0LxFuDUoEe0HqHcuei8rnRg==
X-Received: by 2002:a17:902:d481:b0:1e0:b62c:460d with SMTP id
 c1-20020a170902d48100b001e0b62c460dmr6001184plg.38.1713596529632; 
 Sat, 20 Apr 2024 00:02:09 -0700 (PDT)
Received: from localhost.localdomain ([120.204.189.229])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a170902778900b001e51b690b7dsm4424137pll.295.2024.04.20.00.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Apr 2024 00:02:09 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>, Baruch Siach <baruch@tkos.co.il>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Jonas Karlman <jonas@kwiboo.se>, Nils Le Roux <gilbsgilbert@gmail.com>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/3] board: milkv_duo: Add init code for Milk-V Duo ethernet
Date: Sat, 20 Apr 2024 15:00:27 +0800
Message-ID: <20240420070149.8917-2-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240420070149.8917-1-seashell11234455@gmail.com>
References: <20240420070149.8917-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 20 Apr 2024 12:11:39 +0200
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
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>

---

(no changes since v1)

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
index 4c1642b29a..682045cea2 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -871,6 +871,7 @@ static const struct udevice_id designware_eth_ids[] = {
 	{ .compatible = "amlogic,meson6-dwmac" },
 	{ .compatible = "st,stm32-dwmac" },
 	{ .compatible = "snps,arc-dwmac-3.70a" },
+	{ .compatible = "sophgo,cv1800b-dwmac" },
 	{ }
 };
 
-- 
2.41.0

