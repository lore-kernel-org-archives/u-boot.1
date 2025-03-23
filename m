Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98861C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A42B282120;
	Sun, 23 Mar 2025 17:02:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745745;
	bh=J3tzB5JzDFHzHAYqko7kZ/tJFdIiPQAxmdmxWYKe0UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sRx19l+AUPu3S8YNNEO/x3+EhA7OCL1HfmRIjlA2Kauhzql4ZgIXYf6jYMn0Ujxxu
	 9H63mq8JfowXIKReYYiSwU4ZD9WySDLBJG/6J1E139qtkp27zGio/I1ZpSTgVxGP80
	 Ccvu/u/UaKRKNcend1WzLYA+7DveesaL9PZZl1acahPIM0ivTU+VyLc+75s8gdS2rf
	 PAdw0FBxE65DoKRLT/V7AlB09yTqLwir+i720OMg0deuaPV6fUzD/qNexL/36YF39o
	 ALtyKu3vTcibbm2rFYb2hY3JjKsaGMWJ9McSNpCOg8wpDzJYATEy3ukgr8TmURkX73
	 2KfsjUovGl3iw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1840D820FE; Sun, 23 Mar 2025 17:02:22 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62B1F82786
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Oogz49t1"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0798610290241; Sun, 23 Mar 2025 17:02:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745736; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=J3tzB5JzDFHzHAYqko7kZ/tJFdIiPQAxmdmxWYKe0UI=;
 b=Oogz49t1jgjWrfZGo4YmUOcgZnfgmPT4MW90zI2toq+DmV4nxDzp4+3CRgG+I2kY4MNCkT
 +/Nm3FG+j5EjwGuXfduMynYkaEpWV/5d5su5B8JQisug7dGL+mk2d8cvUB4jF5WJ+BawLi
 1+j9oA3VRxlhz/vT/btF5+kXHb2+rxhAgg2z3xmgTb1MKs03uCCu6gASJh/HlXTH8VAHzh
 FipzS5JoPsMaM0E26fIltuXVENxLj+jpx9DD3OBCHZXbtjs4MiW6J0fXDWoLJJjRIEI9ar
 0t9NZjuqfWRAFVqivs9gyvlkLXV/kJZuJ0Ur0g4HojCFdLgsTsPtVT6H2xovjQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 24/24] clk: imx: Pass struct udevice into
 imx_clk_fixed_factor*()
Date: Sun, 23 Mar 2025 16:58:53 +0100
Message-ID: <20250323160107.145749-25-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250323160107.145749-1-marex@denx.de>
References: <20250323160107.145749-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Pass struct udevice * into imx_clk_fixed_factor*() functions, so the
clock core would have access to parent struct udevice *.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
---
V2: Rebase on u-boot/next with additional clock patches
---
 drivers/clk/imx/clk-imx6q.c     |  4 ++--
 drivers/clk/imx/clk-imx8mm.c    | 36 ++++++++++++++---------------
 drivers/clk/imx/clk-imx8mn.c    | 36 ++++++++++++++---------------
 drivers/clk/imx/clk-imx8mp.c    | 40 ++++++++++++++++-----------------
 drivers/clk/imx/clk-imx8mq.c    | 38 +++++++++++++++----------------
 drivers/clk/imx/clk-imx93.c     |  6 ++---
 drivers/clk/imx/clk-imxrt1020.c |  2 +-
 drivers/clk/imx/clk-imxrt1050.c |  2 +-
 drivers/clk/imx/clk-imxrt1170.c |  8 +++----
 drivers/clk/imx/clk.h           |  7 +++---
 10 files changed, 90 insertions(+), 89 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 5313db9e757..13239f2f64d 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -52,7 +52,7 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_pllv3(dev, IMX_PLLV3_USB, "pll3_usb_otg", "osc",
 			     base + 0x10, 0x3));
 	clk_dm(IMX6QDL_CLK_PLL3_60M,
-	       imx_clk_fixed_factor("pll3_60m",  "pll3_usb_otg",   1, 8));
+	       imx_clk_fixed_factor(dev, "pll3_60m",  "pll3_usb_otg",   1, 8));
 	clk_dm(IMX6QDL_CLK_PLL2_PFD0_352M,
 	       imx_clk_pfd("pll2_pfd0_352m", "pll2_bus", base + 0x100, 0));
 	clk_dm(IMX6QDL_CLK_PLL2_PFD2_396M,
@@ -159,7 +159,7 @@ static int imx6q_clk_probe(struct udevice *dev)
 
 	clk_dm(IMX6QDL_CLK_ENET, imx_clk_gate2(dev, "enet", "ipg", base + 0x6c, 10));
 	clk_dm(IMX6QDL_CLK_ENET_REF,
-	       imx_clk_fixed_factor("enet_ref", "pll6_enet", 1, 1));
+	       imx_clk_fixed_factor(dev, "enet_ref", "pll6_enet", 1, 1));
 
 	return 0;
 }
diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 05b864dd34b..b81db516a69 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -249,42 +249,42 @@ static int imx8mm_clk_probe(struct udevice *dev)
 
 	/* SYS PLL fixed output */
 	clk_dm(IMX8MM_SYS_PLL1_40M,
-	       imx_clk_fixed_factor("sys_pll1_40m", "sys_pll1_out", 1, 20));
+	       imx_clk_fixed_factor(dev, "sys_pll1_40m", "sys_pll1_out", 1, 20));
 	clk_dm(IMX8MM_SYS_PLL1_80M,
-	       imx_clk_fixed_factor("sys_pll1_80m", "sys_pll1_out", 1, 10));
+	       imx_clk_fixed_factor(dev, "sys_pll1_80m", "sys_pll1_out", 1, 10));
 	clk_dm(IMX8MM_SYS_PLL1_100M,
-	       imx_clk_fixed_factor("sys_pll1_100m", "sys_pll1_out", 1, 8));
+	       imx_clk_fixed_factor(dev, "sys_pll1_100m", "sys_pll1_out", 1, 8));
 	clk_dm(IMX8MM_SYS_PLL1_133M,
-	       imx_clk_fixed_factor("sys_pll1_133m", "sys_pll1_out", 1, 6));
+	       imx_clk_fixed_factor(dev, "sys_pll1_133m", "sys_pll1_out", 1, 6));
 	clk_dm(IMX8MM_SYS_PLL1_160M,
-	       imx_clk_fixed_factor("sys_pll1_160m", "sys_pll1_out", 1, 5));
+	       imx_clk_fixed_factor(dev, "sys_pll1_160m", "sys_pll1_out", 1, 5));
 	clk_dm(IMX8MM_SYS_PLL1_200M,
-	       imx_clk_fixed_factor("sys_pll1_200m", "sys_pll1_out", 1, 4));
+	       imx_clk_fixed_factor(dev, "sys_pll1_200m", "sys_pll1_out", 1, 4));
 	clk_dm(IMX8MM_SYS_PLL1_266M,
-	       imx_clk_fixed_factor("sys_pll1_266m", "sys_pll1_out", 1, 3));
+	       imx_clk_fixed_factor(dev, "sys_pll1_266m", "sys_pll1_out", 1, 3));
 	clk_dm(IMX8MM_SYS_PLL1_400M,
-	       imx_clk_fixed_factor("sys_pll1_400m", "sys_pll1_out", 1, 2));
+	       imx_clk_fixed_factor(dev, "sys_pll1_400m", "sys_pll1_out", 1, 2));
 	clk_dm(IMX8MM_SYS_PLL1_800M,
-	       imx_clk_fixed_factor("sys_pll1_800m", "sys_pll1_out", 1, 1));
+	       imx_clk_fixed_factor(dev, "sys_pll1_800m", "sys_pll1_out", 1, 1));
 
 	clk_dm(IMX8MM_SYS_PLL2_50M,
-	       imx_clk_fixed_factor("sys_pll2_50m", "sys_pll2_out", 1, 20));
+	       imx_clk_fixed_factor(dev, "sys_pll2_50m", "sys_pll2_out", 1, 20));
 	clk_dm(IMX8MM_SYS_PLL2_100M,
-	       imx_clk_fixed_factor("sys_pll2_100m", "sys_pll2_out", 1, 10));
+	       imx_clk_fixed_factor(dev, "sys_pll2_100m", "sys_pll2_out", 1, 10));
 	clk_dm(IMX8MM_SYS_PLL2_125M,
-	       imx_clk_fixed_factor("sys_pll2_125m", "sys_pll2_out", 1, 8));
+	       imx_clk_fixed_factor(dev, "sys_pll2_125m", "sys_pll2_out", 1, 8));
 	clk_dm(IMX8MM_SYS_PLL2_166M,
-	       imx_clk_fixed_factor("sys_pll2_166m", "sys_pll2_out", 1, 6));
+	       imx_clk_fixed_factor(dev, "sys_pll2_166m", "sys_pll2_out", 1, 6));
 	clk_dm(IMX8MM_SYS_PLL2_200M,
-	       imx_clk_fixed_factor("sys_pll2_200m", "sys_pll2_out", 1, 5));
+	       imx_clk_fixed_factor(dev, "sys_pll2_200m", "sys_pll2_out", 1, 5));
 	clk_dm(IMX8MM_SYS_PLL2_250M,
-	       imx_clk_fixed_factor("sys_pll2_250m", "sys_pll2_out", 1, 4));
+	       imx_clk_fixed_factor(dev, "sys_pll2_250m", "sys_pll2_out", 1, 4));
 	clk_dm(IMX8MM_SYS_PLL2_333M,
-	       imx_clk_fixed_factor("sys_pll2_333m", "sys_pll2_out", 1, 3));
+	       imx_clk_fixed_factor(dev, "sys_pll2_333m", "sys_pll2_out", 1, 3));
 	clk_dm(IMX8MM_SYS_PLL2_500M,
-	       imx_clk_fixed_factor("sys_pll2_500m", "sys_pll2_out", 1, 2));
+	       imx_clk_fixed_factor(dev, "sys_pll2_500m", "sys_pll2_out", 1, 2));
 	clk_dm(IMX8MM_SYS_PLL2_1000M,
-	       imx_clk_fixed_factor("sys_pll2_1000m", "sys_pll2_out", 1, 1));
+	       imx_clk_fixed_factor(dev, "sys_pll2_1000m", "sys_pll2_out", 1, 1));
 
 	base = dev_read_addr_ptr(dev);
 	if (!base)
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 540726f0c9c..be5b7933a8d 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -241,42 +241,42 @@ static int imx8mn_clk_probe(struct udevice *dev)
 
 	/* SYS PLL fixed output */
 	clk_dm(IMX8MN_SYS_PLL1_40M,
-	       imx_clk_fixed_factor("sys_pll1_40m", "sys_pll1_out", 1, 20));
+	       imx_clk_fixed_factor(dev, "sys_pll1_40m", "sys_pll1_out", 1, 20));
 	clk_dm(IMX8MN_SYS_PLL1_80M,
-	       imx_clk_fixed_factor("sys_pll1_80m", "sys_pll1_out", 1, 10));
+	       imx_clk_fixed_factor(dev, "sys_pll1_80m", "sys_pll1_out", 1, 10));
 	clk_dm(IMX8MN_SYS_PLL1_100M,
-	       imx_clk_fixed_factor("sys_pll1_100m", "sys_pll1_out", 1, 8));
+	       imx_clk_fixed_factor(dev, "sys_pll1_100m", "sys_pll1_out", 1, 8));
 	clk_dm(IMX8MN_SYS_PLL1_133M,
-	       imx_clk_fixed_factor("sys_pll1_133m", "sys_pll1_out", 1, 6));
+	       imx_clk_fixed_factor(dev, "sys_pll1_133m", "sys_pll1_out", 1, 6));
 	clk_dm(IMX8MN_SYS_PLL1_160M,
-	       imx_clk_fixed_factor("sys_pll1_160m", "sys_pll1_out", 1, 5));
+	       imx_clk_fixed_factor(dev, "sys_pll1_160m", "sys_pll1_out", 1, 5));
 	clk_dm(IMX8MN_SYS_PLL1_200M,
-	       imx_clk_fixed_factor("sys_pll1_200m", "sys_pll1_out", 1, 4));
+	       imx_clk_fixed_factor(dev, "sys_pll1_200m", "sys_pll1_out", 1, 4));
 	clk_dm(IMX8MN_SYS_PLL1_266M,
-	       imx_clk_fixed_factor("sys_pll1_266m", "sys_pll1_out", 1, 3));
+	       imx_clk_fixed_factor(dev, "sys_pll1_266m", "sys_pll1_out", 1, 3));
 	clk_dm(IMX8MN_SYS_PLL1_400M,
-	       imx_clk_fixed_factor("sys_pll1_400m", "sys_pll1_out", 1, 2));
+	       imx_clk_fixed_factor(dev, "sys_pll1_400m", "sys_pll1_out", 1, 2));
 	clk_dm(IMX8MN_SYS_PLL1_800M,
-	       imx_clk_fixed_factor("sys_pll1_800m", "sys_pll1_out", 1, 1));
+	       imx_clk_fixed_factor(dev, "sys_pll1_800m", "sys_pll1_out", 1, 1));
 
 	clk_dm(IMX8MN_SYS_PLL2_50M,
-	       imx_clk_fixed_factor("sys_pll2_50m", "sys_pll2_out", 1, 20));
+	       imx_clk_fixed_factor(dev, "sys_pll2_50m", "sys_pll2_out", 1, 20));
 	clk_dm(IMX8MN_SYS_PLL2_100M,
-	       imx_clk_fixed_factor("sys_pll2_100m", "sys_pll2_out", 1, 10));
+	       imx_clk_fixed_factor(dev, "sys_pll2_100m", "sys_pll2_out", 1, 10));
 	clk_dm(IMX8MN_SYS_PLL2_125M,
-	       imx_clk_fixed_factor("sys_pll2_125m", "sys_pll2_out", 1, 8));
+	       imx_clk_fixed_factor(dev, "sys_pll2_125m", "sys_pll2_out", 1, 8));
 	clk_dm(IMX8MN_SYS_PLL2_166M,
-	       imx_clk_fixed_factor("sys_pll2_166m", "sys_pll2_out", 1, 6));
+	       imx_clk_fixed_factor(dev, "sys_pll2_166m", "sys_pll2_out", 1, 6));
 	clk_dm(IMX8MN_SYS_PLL2_200M,
-	       imx_clk_fixed_factor("sys_pll2_200m", "sys_pll2_out", 1, 5));
+	       imx_clk_fixed_factor(dev, "sys_pll2_200m", "sys_pll2_out", 1, 5));
 	clk_dm(IMX8MN_SYS_PLL2_250M,
-	       imx_clk_fixed_factor("sys_pll2_250m", "sys_pll2_out", 1, 4));
+	       imx_clk_fixed_factor(dev, "sys_pll2_250m", "sys_pll2_out", 1, 4));
 	clk_dm(IMX8MN_SYS_PLL2_333M,
-	       imx_clk_fixed_factor("sys_pll2_333m", "sys_pll2_out", 1, 3));
+	       imx_clk_fixed_factor(dev, "sys_pll2_333m", "sys_pll2_out", 1, 3));
 	clk_dm(IMX8MN_SYS_PLL2_500M,
-	       imx_clk_fixed_factor("sys_pll2_500m", "sys_pll2_out", 1, 2));
+	       imx_clk_fixed_factor(dev, "sys_pll2_500m", "sys_pll2_out", 1, 2));
 	clk_dm(IMX8MN_SYS_PLL2_1000M,
-	       imx_clk_fixed_factor("sys_pll2_1000m", "sys_pll2_out", 1, 1));
+	       imx_clk_fixed_factor(dev, "sys_pll2_1000m", "sys_pll2_out", 1, 1));
 
 	ret = clk_get_by_name(dev, "osc_24m", &osc_24m_clk);
 	if (ret)
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index ed11d751af0..bad579f8d5e 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -228,25 +228,25 @@ static int imx8mp_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MP_SYS_PLL2_OUT, imx_clk_gate(dev, "sys_pll2_out", "sys_pll2_bypass", base + 0x104, 11));
 	clk_dm(IMX8MP_SYS_PLL3_OUT, imx_clk_gate(dev, "sys_pll3_out", "sys_pll3_bypass", base + 0x114, 11));
 
-	clk_dm(IMX8MP_SYS_PLL1_40M, imx_clk_fixed_factor("sys_pll1_40m", "sys_pll1_out", 1, 20));
-	clk_dm(IMX8MP_SYS_PLL1_80M, imx_clk_fixed_factor("sys_pll1_80m", "sys_pll1_out", 1, 10));
-	clk_dm(IMX8MP_SYS_PLL1_100M, imx_clk_fixed_factor("sys_pll1_100m", "sys_pll1_out", 1, 8));
-	clk_dm(IMX8MP_SYS_PLL1_133M, imx_clk_fixed_factor("sys_pll1_133m", "sys_pll1_out", 1, 6));
-	clk_dm(IMX8MP_SYS_PLL1_160M, imx_clk_fixed_factor("sys_pll1_160m", "sys_pll1_out", 1, 5));
-	clk_dm(IMX8MP_SYS_PLL1_200M, imx_clk_fixed_factor("sys_pll1_200m", "sys_pll1_out", 1, 4));
-	clk_dm(IMX8MP_SYS_PLL1_266M, imx_clk_fixed_factor("sys_pll1_266m", "sys_pll1_out", 1, 3));
-	clk_dm(IMX8MP_SYS_PLL1_400M, imx_clk_fixed_factor("sys_pll1_400m", "sys_pll1_out", 1, 2));
-	clk_dm(IMX8MP_SYS_PLL1_800M, imx_clk_fixed_factor("sys_pll1_800m", "sys_pll1_out", 1, 1));
-
-	clk_dm(IMX8MP_SYS_PLL2_50M, imx_clk_fixed_factor("sys_pll2_50m", "sys_pll2_out", 1, 20));
-	clk_dm(IMX8MP_SYS_PLL2_100M, imx_clk_fixed_factor("sys_pll2_100m", "sys_pll2_out", 1, 10));
-	clk_dm(IMX8MP_SYS_PLL2_125M, imx_clk_fixed_factor("sys_pll2_125m", "sys_pll2_out", 1, 8));
-	clk_dm(IMX8MP_SYS_PLL2_166M, imx_clk_fixed_factor("sys_pll2_166m", "sys_pll2_out", 1, 6));
-	clk_dm(IMX8MP_SYS_PLL2_200M, imx_clk_fixed_factor("sys_pll2_200m", "sys_pll2_out", 1, 5));
-	clk_dm(IMX8MP_SYS_PLL2_250M, imx_clk_fixed_factor("sys_pll2_250m", "sys_pll2_out", 1, 4));
-	clk_dm(IMX8MP_SYS_PLL2_333M, imx_clk_fixed_factor("sys_pll2_333m", "sys_pll2_out", 1, 3));
-	clk_dm(IMX8MP_SYS_PLL2_500M, imx_clk_fixed_factor("sys_pll2_500m", "sys_pll2_out", 1, 2));
-	clk_dm(IMX8MP_SYS_PLL2_1000M, imx_clk_fixed_factor("sys_pll2_1000m", "sys_pll2_out", 1, 1));
+	clk_dm(IMX8MP_SYS_PLL1_40M, imx_clk_fixed_factor(dev, "sys_pll1_40m", "sys_pll1_out", 1, 20));
+	clk_dm(IMX8MP_SYS_PLL1_80M, imx_clk_fixed_factor(dev, "sys_pll1_80m", "sys_pll1_out", 1, 10));
+	clk_dm(IMX8MP_SYS_PLL1_100M, imx_clk_fixed_factor(dev, "sys_pll1_100m", "sys_pll1_out", 1, 8));
+	clk_dm(IMX8MP_SYS_PLL1_133M, imx_clk_fixed_factor(dev, "sys_pll1_133m", "sys_pll1_out", 1, 6));
+	clk_dm(IMX8MP_SYS_PLL1_160M, imx_clk_fixed_factor(dev, "sys_pll1_160m", "sys_pll1_out", 1, 5));
+	clk_dm(IMX8MP_SYS_PLL1_200M, imx_clk_fixed_factor(dev, "sys_pll1_200m", "sys_pll1_out", 1, 4));
+	clk_dm(IMX8MP_SYS_PLL1_266M, imx_clk_fixed_factor(dev, "sys_pll1_266m", "sys_pll1_out", 1, 3));
+	clk_dm(IMX8MP_SYS_PLL1_400M, imx_clk_fixed_factor(dev, "sys_pll1_400m", "sys_pll1_out", 1, 2));
+	clk_dm(IMX8MP_SYS_PLL1_800M, imx_clk_fixed_factor(dev, "sys_pll1_800m", "sys_pll1_out", 1, 1));
+
+	clk_dm(IMX8MP_SYS_PLL2_50M, imx_clk_fixed_factor(dev, "sys_pll2_50m", "sys_pll2_out", 1, 20));
+	clk_dm(IMX8MP_SYS_PLL2_100M, imx_clk_fixed_factor(dev, "sys_pll2_100m", "sys_pll2_out", 1, 10));
+	clk_dm(IMX8MP_SYS_PLL2_125M, imx_clk_fixed_factor(dev, "sys_pll2_125m", "sys_pll2_out", 1, 8));
+	clk_dm(IMX8MP_SYS_PLL2_166M, imx_clk_fixed_factor(dev, "sys_pll2_166m", "sys_pll2_out", 1, 6));
+	clk_dm(IMX8MP_SYS_PLL2_200M, imx_clk_fixed_factor(dev, "sys_pll2_200m", "sys_pll2_out", 1, 5));
+	clk_dm(IMX8MP_SYS_PLL2_250M, imx_clk_fixed_factor(dev, "sys_pll2_250m", "sys_pll2_out", 1, 4));
+	clk_dm(IMX8MP_SYS_PLL2_333M, imx_clk_fixed_factor(dev, "sys_pll2_333m", "sys_pll2_out", 1, 3));
+	clk_dm(IMX8MP_SYS_PLL2_500M, imx_clk_fixed_factor(dev, "sys_pll2_500m", "sys_pll2_out", 1, 2));
+	clk_dm(IMX8MP_SYS_PLL2_1000M, imx_clk_fixed_factor(dev, "sys_pll2_1000m", "sys_pll2_out", 1, 1));
 
 	ret = clk_get_by_name(dev, "osc_24m", &osc_24m_clk);
 	if (ret)
@@ -313,7 +313,7 @@ static int imx8mp_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MP_CLK_WDOG, imx8m_clk_composite(dev, "wdog", imx8mp_wdog_sels, base + 0xb900));
 	clk_dm(IMX8MP_CLK_USDHC3, imx8m_clk_composite(dev, "usdhc3", imx8mp_usdhc3_sels, base + 0xbc80));
 
-	clk_dm(IMX8MP_CLK_DRAM_ALT_ROOT, imx_clk_fixed_factor("dram_alt_root", "dram_alt", 1, 4));
+	clk_dm(IMX8MP_CLK_DRAM_ALT_ROOT, imx_clk_fixed_factor(dev, "dram_alt_root", "dram_alt", 1, 4));
 	clk_dm(IMX8MP_CLK_DRAM_CORE, imx_clk_mux2_flags(dev, "dram_core_clk", base + 0x9800, 24, 1, imx8mp_dram_core_sels, ARRAY_SIZE(imx8mp_dram_core_sels), CLK_IS_CRITICAL));
 
 	clk_dm(IMX8MP_CLK_DRAM1_ROOT, imx_clk_gate4_flags(dev, "dram1_root_clk", "dram_core_clk", base + 0x4050, 0, CLK_IS_CRITICAL));
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 7632ffe72e7..fe6cba19758 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -275,42 +275,42 @@ static int imx8mq_clk_probe(struct udevice *dev)
 
 	/* SYS PLL fixed output */
 	clk_dm(IMX8MQ_SYS1_PLL_40M,
-	       imx_clk_fixed_factor("sys_pll1_40m", "sys_pll1_out", 1, 20));
+	       imx_clk_fixed_factor(dev, "sys_pll1_40m", "sys_pll1_out", 1, 20));
 	clk_dm(IMX8MQ_SYS1_PLL_80M,
-	       imx_clk_fixed_factor("sys_pll1_80m", "sys_pll1_out", 1, 10));
+	       imx_clk_fixed_factor(dev, "sys_pll1_80m", "sys_pll1_out", 1, 10));
 	clk_dm(IMX8MQ_SYS1_PLL_100M,
-	       imx_clk_fixed_factor("sys_pll1_100m", "sys_pll1_out", 1, 8));
+	       imx_clk_fixed_factor(dev, "sys_pll1_100m", "sys_pll1_out", 1, 8));
 	clk_dm(IMX8MQ_SYS1_PLL_133M,
-	       imx_clk_fixed_factor("sys_pll1_133m", "sys_pll1_out", 1, 6));
+	       imx_clk_fixed_factor(dev, "sys_pll1_133m", "sys_pll1_out", 1, 6));
 	clk_dm(IMX8MQ_SYS1_PLL_160M,
-	       imx_clk_fixed_factor("sys_pll1_160m", "sys_pll1_out", 1, 5));
+	       imx_clk_fixed_factor(dev, "sys_pll1_160m", "sys_pll1_out", 1, 5));
 	clk_dm(IMX8MQ_SYS1_PLL_200M,
-	       imx_clk_fixed_factor("sys_pll1_200m", "sys_pll1_out", 1, 4));
+	       imx_clk_fixed_factor(dev, "sys_pll1_200m", "sys_pll1_out", 1, 4));
 	clk_dm(IMX8MQ_SYS1_PLL_266M,
-	       imx_clk_fixed_factor("sys_pll1_266m", "sys_pll1_out", 1, 3));
+	       imx_clk_fixed_factor(dev, "sys_pll1_266m", "sys_pll1_out", 1, 3));
 	clk_dm(IMX8MQ_SYS1_PLL_400M,
-	       imx_clk_fixed_factor("sys_pll1_400m", "sys_pll1_out", 1, 2));
+	       imx_clk_fixed_factor(dev, "sys_pll1_400m", "sys_pll1_out", 1, 2));
 	clk_dm(IMX8MQ_SYS1_PLL_800M,
-	       imx_clk_fixed_factor("sys_pll1_800m", "sys_pll1_out", 1, 1));
+	       imx_clk_fixed_factor(dev, "sys_pll1_800m", "sys_pll1_out", 1, 1));
 
 	clk_dm(IMX8MQ_SYS2_PLL_50M,
-	       imx_clk_fixed_factor("sys_pll2_50m", "sys_pll2_out", 1, 20));
+	       imx_clk_fixed_factor(dev, "sys_pll2_50m", "sys_pll2_out", 1, 20));
 	clk_dm(IMX8MQ_SYS2_PLL_100M,
-	       imx_clk_fixed_factor("sys_pll2_100m", "sys_pll2_out", 1, 10));
+	       imx_clk_fixed_factor(dev, "sys_pll2_100m", "sys_pll2_out", 1, 10));
 	clk_dm(IMX8MQ_SYS2_PLL_125M,
-	       imx_clk_fixed_factor("sys_pll2_125m", "sys_pll2_out", 1, 8));
+	       imx_clk_fixed_factor(dev, "sys_pll2_125m", "sys_pll2_out", 1, 8));
 	clk_dm(IMX8MQ_SYS2_PLL_166M,
-	       imx_clk_fixed_factor("sys_pll2_166m", "sys_pll2_out", 1, 6));
+	       imx_clk_fixed_factor(dev, "sys_pll2_166m", "sys_pll2_out", 1, 6));
 	clk_dm(IMX8MQ_SYS2_PLL_200M,
-	       imx_clk_fixed_factor("sys_pll2_200m", "sys_pll2_out", 1, 5));
+	       imx_clk_fixed_factor(dev, "sys_pll2_200m", "sys_pll2_out", 1, 5));
 	clk_dm(IMX8MQ_SYS2_PLL_250M,
-	       imx_clk_fixed_factor("sys_pll2_250m", "sys_pll2_out", 1, 4));
+	       imx_clk_fixed_factor(dev, "sys_pll2_250m", "sys_pll2_out", 1, 4));
 	clk_dm(IMX8MQ_SYS2_PLL_333M,
-	       imx_clk_fixed_factor("sys_pll2_333m", "sys_pll2_out", 1, 3));
+	       imx_clk_fixed_factor(dev, "sys_pll2_333m", "sys_pll2_out", 1, 3));
 	clk_dm(IMX8MQ_SYS2_PLL_500M,
-	       imx_clk_fixed_factor("sys_pll2_500m", "sys_pll2_out", 1, 2));
+	       imx_clk_fixed_factor(dev, "sys_pll2_500m", "sys_pll2_out", 1, 2));
 	clk_dm(IMX8MQ_SYS2_PLL_1000M,
-	       imx_clk_fixed_factor("sys_pll2_1000m", "sys_pll2_out", 1, 1));
+	       imx_clk_fixed_factor(dev, "sys_pll2_1000m", "sys_pll2_out", 1, 1));
 
 	clk_dm(IMX8MQ_CLK_MON_AUDIO_PLL1_DIV,
 	       imx_clk_divider(dev, "audio_pll1_out_monitor", "audio_pll1_bypass", base + 0x78, 0, 3));
@@ -482,7 +482,7 @@ static int imx8mq_clk_probe(struct udevice *dev)
 			     base + 0x40a0, 0));
 
 	clk_dm(IMX8MQ_CLK_DRAM_ALT_ROOT,
-	       imx_clk_fixed_factor("dram_alt_root", "dram_alt", 1, 4));
+	       imx_clk_fixed_factor(dev, "dram_alt_root", "dram_alt", 1, 4));
 
 	return 0;
 }
diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 0caec91fd9a..c3112968c17 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -291,15 +291,15 @@ static int imx93_clk_probe(struct udevice *dev)
 	clk_dm(IMX93_CLK_SYS_PLL_PFD0,
 	       clk_register_fixed_rate(NULL, "sys_pll_pfd0", 1000000000));
 	clk_dm(IMX93_CLK_SYS_PLL_PFD0_DIV2,
-	       imx_clk_fixed_factor("sys_pll_pfd0_div2", "sys_pll_pfd0", 1, 2));
+	       imx_clk_fixed_factor(dev, "sys_pll_pfd0_div2", "sys_pll_pfd0", 1, 2));
 	clk_dm(IMX93_CLK_SYS_PLL_PFD1,
 	       clk_register_fixed_rate(NULL, "sys_pll_pfd1", 800000000));
 	clk_dm(IMX93_CLK_SYS_PLL_PFD1_DIV2,
-	       imx_clk_fixed_factor("sys_pll_pfd1_div2", "sys_pll_pfd1", 1, 2));
+	       imx_clk_fixed_factor(dev, "sys_pll_pfd1_div2", "sys_pll_pfd1", 1, 2));
 	clk_dm(IMX93_CLK_SYS_PLL_PFD2,
 	       clk_register_fixed_rate(NULL, "sys_pll_pfd2", 625000000));
 	clk_dm(IMX93_CLK_SYS_PLL_PFD2_DIV2,
-	       imx_clk_fixed_factor("sys_pll_pfd2_div2", "sys_pll_pfd2", 1, 2));
+	       imx_clk_fixed_factor(dev, "sys_pll_pfd2_div2", "sys_pll_pfd2", 1, 2));
 
 	anatop_base = (void *)ANATOP_BASE_ADDR;
 
diff --git a/drivers/clk/imx/clk-imxrt1020.c b/drivers/clk/imx/clk-imxrt1020.c
index 775cc73b4db..c14afdaf236 100644
--- a/drivers/clk/imx/clk-imxrt1020.c
+++ b/drivers/clk/imx/clk-imxrt1020.c
@@ -57,7 +57,7 @@ static int imxrt1020_clk_probe(struct udevice *dev)
 				 CLK_SET_RATE_PARENT));
 
 	clk_dm(IMXRT1020_CLK_PLL3_80M,
-	       imx_clk_fixed_factor("pll3_80m",  "pll3_usb_otg",   1, 6));
+	       imx_clk_fixed_factor(dev, "pll3_80m",  "pll3_usb_otg",   1, 6));
 
 	clk_dm(IMXRT1020_CLK_PLL2_PFD0_352M,
 	       imx_clk_pfd("pll2_pfd0_352m", "pll2_sys", base + 0x100, 0));
diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
index c8ac3103dc9..ba5b48748ef 100644
--- a/drivers/clk/imx/clk-imxrt1050.c
+++ b/drivers/clk/imx/clk-imxrt1050.c
@@ -92,7 +92,7 @@ static int imxrt1050_clk_probe(struct udevice *dev)
 			       base + 0x170, 30, 2));
 
 	clk_dm(IMXRT1050_CLK_PLL3_80M,
-	       imx_clk_fixed_factor("pll3_80m",  "pll3_usb_otg",   1, 6));
+	       imx_clk_fixed_factor(dev, "pll3_80m",  "pll3_usb_otg",   1, 6));
 
 	clk_dm(IMXRT1050_CLK_PLL2_PFD0_352M,
 	       imx_clk_pfd("pll2_pfd0_352m", "pll2_sys", base + 0x100, 0));
diff --git a/drivers/clk/imx/clk-imxrt1170.c b/drivers/clk/imx/clk-imxrt1170.c
index 043c400559e..3f55d0d0127 100644
--- a/drivers/clk/imx/clk-imxrt1170.c
+++ b/drivers/clk/imx/clk-imxrt1170.c
@@ -114,11 +114,11 @@ static int imxrt1170_clk_probe(struct udevice *dev)
 	base = (void *)ofnode_get_addr(ofnode_by_compatible(ofnode_null(), "fsl,imxrt-anatop"));
 
 	clk_dm(IMXRT1170_CLK_RCOSC_48M,
-	       imx_clk_fixed_factor("rcosc48M", "rcosc16M", 3, 1));
+	       imx_clk_fixed_factor(dev, "rcosc48M", "rcosc16M", 3, 1));
 	clk_dm(IMXRT1170_CLK_RCOSC_400M,
-	       imx_clk_fixed_factor("rcosc400M",  "rcosc16M", 25, 1));
+	       imx_clk_fixed_factor(dev, "rcosc400M",  "rcosc16M", 25, 1));
 	clk_dm(IMXRT1170_CLK_RCOSC_48M_DIV2,
-	       imx_clk_fixed_factor("rcosc48M_div2",  "rcosc48M", 1, 2));
+	       imx_clk_fixed_factor(dev, "rcosc48M_div2",  "rcosc48M", 1, 2));
 
 	clk_dm(IMXRT1170_CLK_PLL_ARM,
 	       imx_clk_pllv3(dev, IMX_PLLV3_SYS, "pll_arm", "osc",
@@ -149,7 +149,7 @@ static int imxrt1170_clk_probe(struct udevice *dev)
 	       imx_clk_pfd("pll2_pfd3", "pll2_sys", base + 0x270, 3));
 
 	clk_dm(IMXRT1170_CLK_PLL3_DIV2,
-	       imx_clk_fixed_factor("pll3_div2", "pll3_sys", 1, 2));
+	       imx_clk_fixed_factor(dev, "pll3_div2", "pll3_sys", 1, 2));
 
 	/* CCM clocks */
 	base = dev_read_addr_ptr(dev);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 32fa832f856..7d14dbc395f 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -131,10 +131,11 @@ static inline struct clk *imx_clk_gate4_flags(struct udevice *dev, const char *n
 			reg, shift, 0x3, 0, NULL);
 }
 
-static inline struct clk *imx_clk_fixed_factor(const char *name,
-		const char *parent, unsigned int mult, unsigned int div)
+static inline struct clk *
+imx_clk_fixed_factor(struct udevice *dev, const char *name, const char *parent,
+		     unsigned int mult, unsigned int div)
 {
-	return clk_register_fixed_factor(NULL, name, parent,
+	return clk_register_fixed_factor(dev, name, parent,
 			CLK_SET_RATE_PARENT, mult, div);
 }
 
-- 
2.47.2

