Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD00C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4E2982064;
	Sun, 23 Mar 2025 17:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745716;
	bh=ilL2tlpxvvjHwfGuF6tUH6gxP41enJoVazHaBfpvFjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vggmdVXA2fGaqSH4lmOINh0ShThCGL0A4AZx/xqh9gcFGjEYdJXm/xSyh2dyKDCCf
	 SlV9V3c+z/JJXzdASgGUoQt4OhVxuGUJwN7DQkMaKknB7I0C2lqgifokucb+ymK4DA
	 hGRhZR8BDK1Rz97XSx17V87o7y28hmqn9nppo2j0/k+Xcybm58nFrYcH7yzJklGPQc
	 cVT1zxzaMG5WaySxSxL16/qVPowBl+e8dmuf5xHMUv3yU0EKTEsFSL7kGR+ETsN5xT
	 jo46RkJrG5gm83ybtDScHmmVJhdPO15YyZnyKzPcBMy1nhC+x1mnLFJkq6zaBK1Sd9
	 1ESKhnbZ3yDEA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8E6681F71; Sun, 23 Mar 2025 17:01:55 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C030C81DD6
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="GUgqekGV"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 582ED102A4AFB; Sun, 23 Mar 2025 17:01:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745713; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=ilL2tlpxvvjHwfGuF6tUH6gxP41enJoVazHaBfpvFjE=;
 b=GUgqekGVTeKxJMnPfBaRQ50g5SFglOsY2AQRFEQMv56p0lR9J49rjaFoFbFTv7NaeJpjm2
 U8rcC0xFYD8aTQi4h2hjybjMPN0TJDA9D3/Xl7GxEJ9ANOOo7llYf420ekISUb5RweE+qn
 oujOQ+FuMuAV29pWTPLs/Dp3cozR5cerl8DS55Bmq2ZzhsodxYF+MjEbhqv7fP7Zk1NOKl
 sKlmGL56ZPlHtLvhqjqnjJGTavc9oB4JjxmZl7/pXnuONx30ohI5HEA5l9NdYe+nsB9jid
 jtnXPRuLMQqdXcgcF+JqkYM2tquyaNFXXpUQJUImhaimDLZGjaHcllB5VXgbSg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 01/24] clk: Add clk_resolve_parent_clk()
Date: Sun, 23 Mar 2025 16:58:30 +0100
Message-ID: <20250323160107.145749-2-marex@denx.de>
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

Add clk_resolve_parent_clk() to resolve parent clock udevice name
based on clock-names DT property. This is used in SoC clock drivers
to look up the clock name in clock tables, which matches a clock
name in DT clock-names property, and convert it into udevice name
which is used by U-Boot clock framework to look up parent clock in
e.g. clk_register() using uclass_get_device_by_name(UCLASS_CLK,
parent_name, &parent);

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
 drivers/clk/clk-uclass.c | 18 ++++++++++++++++++
 include/clk.h            |  9 +++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 353ae476068..90b70529a47 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -420,6 +420,24 @@ int clk_get_by_name_nodev(ofnode node, const char *name, struct clk *clk)
 	return clk_get_by_index_nodev(node, index, clk);
 }
 
+const char *
+clk_resolve_parent_clk(struct udevice *dev, const char *name)
+{
+	struct udevice *parent;
+	struct clk clk;
+	int ret;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, name, &parent);
+	if (!ret)
+		return name;
+
+	ret = clk_get_by_name(dev, name, &clk);
+	if (!clk.dev)
+		return name;
+
+	return clk.dev->name;
+}
+
 int clk_release_all(struct clk *clk, unsigned int count)
 {
 	unsigned int i;
diff --git a/include/clk.h b/include/clk.h
index 045e923a529..a6ef4e02692 100644
--- a/include/clk.h
+++ b/include/clk.h
@@ -350,6 +350,15 @@ static inline int clk_get_by_name_nodev_optional(ofnode node, const char *name,
 	return ret;
 }
 
+/**
+ * clk_resolve_parent_clk - Determine name of clock udevice based on clock-names
+ * @dev:	The client udevice.
+ * @name:	The name of the clock to look up.
+ *
+ * Return name of the clock udevice which represents clock with clock-names name.
+ */
+const char *clk_resolve_parent_clk(struct udevice *dev, const char *name);
+
 /**
  * enum clk_defaults_stage - What stage clk_set_defaults() is called at
  * @CLK_DEFAULTS_PRE: Called before probe. Setting of defaults for clocks owned
-- 
2.47.2

