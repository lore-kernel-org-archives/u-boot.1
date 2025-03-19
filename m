Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABFDC35FF3
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:19:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 939BB81A04;
	Wed, 19 Mar 2025 04:19:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742354360;
	bh=LYZzPqTMu0FnmAiO6egO4CmwCHALZFPGf2X4GYZXFVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nomahLpubtRFes6PUi6gaRVDGfVXZrdZFjeNB+Ls8be5Gk4CaoaSkUbrpQxPNNR5/
	 fvLRx3BrJZlLnsOGdg7gcmqOF71P+/PZ8aYv045/BnO8kBJlFy8R40goAaWhOjyHbj
	 R5/xFziZDPrtiV9zc4pxNT+DQPe5H9OTf6PHvfmEJewf9cQLJjFsC9u7JfMT3KIC4B
	 7BzJmhDTfaX++sL/FL2CPFuuFRhvQEuRt2QeuhBgB40fJq3LTZ4+h3TeZ/i9AOQthu
	 aRVWsfjbVsqYwYqKhuxGsctTHBrrUMNgjN+2ov9qesL/+Ze+QJUftB89yYY9WxqlsY
	 LdFlYrREl2v+Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C27C81A0C; Wed, 19 Mar 2025 04:19:18 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20CE18129F
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:19:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="aQhMaghI"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 82D84101F63B7; Wed, 19 Mar 2025 04:19:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742354355; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=LYZzPqTMu0FnmAiO6egO4CmwCHALZFPGf2X4GYZXFVc=;
 b=aQhMaghIyeAvSOZqhEcsUEMjxZ3qr6SAXLzT3hp1ZPboEl26d9clgKKY7uJbCaEgg1Oi1U
 WCjerb6nC6Se1vBgN+IsiKkrLhYhiDKmWANBvvBz684L/oJ2yiZaEiun+yD7Vfd4E+WUji
 YjmU6HeQk9h7mL7GZyaD1bZzGLi2LNDZwauhuw9l8HN71K7CHNvzsZ/pKJ1NKkW0pTHmAm
 xeqrjcZhyAbKxPrQUCu2sZCkjPVmDowKfHVUcvOXSMRK13/dZg4kKBsNWyLaSYSuzBgFYp
 mBINsZETfmZVC9Kknhw58oU/EWSl06Ad7ONFuH+kjpGe4YmlKlThE0BMiyQn8g==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH 01/24] clk: Add clk_resolve_parent_clk()
Date: Wed, 19 Mar 2025 04:17:11 +0100
Message-ID: <20250319031852.233537-2-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319031852.233537-1-marex@denx.de>
References: <20250319031852.233537-1-marex@denx.de>
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
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
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

