Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10FBC28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B12ED82836;
	Sun, 23 Mar 2025 17:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745737;
	bh=+QH2fkBTLln4jlXvlzysfZXwoQA6CkTe3FHkcRbUnoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FzVwVg0pOR/ZH4rhnJ1rentkMAwoROm0piW1ZNqds6OlIzcR/+br/9Wn9VyGdXwd4
	 7VLOQZzuCLBOnp9i/wBj344yd7QNGco0SgQRZINI3bU1g5buCqLu8K3F70hQZhKL9l
	 AkPYY041GFe0sjym1yNCNNK2RVo/FmTKzS4eugrzcP2lbr1Anz8xDR/S6pG/3vLOsM
	 XWHmerJr4YAZh46JJXosYl+amoZAA55Ss8fxqxPxd2tVk9dIwXqiHu4j5tXKngEJfB
	 2u2RmIB8jPF4Ywe1kAqgyuaO/erZJHpdhIXbJjkaAfcdXja/6G0PyQQdjfBAjab0BQ
	 sFQPIcFOHvOdQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C73382115; Sun, 23 Mar 2025 17:02:16 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75F2E81DAB
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Eckepyyg"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2464F102A4AFB; Sun, 23 Mar 2025 17:02:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745731; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=+QH2fkBTLln4jlXvlzysfZXwoQA6CkTe3FHkcRbUnoM=;
 b=Eckepyyg7A7dkpLKDKpaK9z9A1pg4sxRn1MqOXlqnMH0nmdCUhp7anM9t/fCUNQqYSZE+d
 8yAShF8wfoB8e9SokvcbBMmcaRqoj33k/1DFAAikzdLj723mlQusadfd7BwUtdts8w86Rp
 I7MHFAQ/8LRJb/cc0ZdGzbUFH0nXKVhYxgr2jJa+Ee2AsTNXrsHqYzFPmOgC8dwgfALSrx
 0atxDNoTPvTEhOTBSdWZgCWE8D+HOTNZsTvajk0yNaDHA/l2rNlWOwUkyI/MIaJlQ8QXIn
 wICMk1+fvdnHAZPWcgcxA09tXIYy4qjXK8tljmhGVKmHfv2OFOz3P9iSkFZ99w==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 19/24] clk: clk-divider: Use struct udevice instead of
 struct device
Date: Sun, 23 Mar 2025 16:58:48 +0100
Message-ID: <20250323160107.145749-20-marex@denx.de>
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

Use U-Boot specific struct udevice instead of Linux compatibility
struct device in clk-divider clock registration.

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
 drivers/clk/clk-divider.c    | 4 ++--
 include/linux/clk-provider.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index aa210e3d15f..3b4b3c4fa5f 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -183,7 +183,7 @@ const struct clk_ops clk_divider_ops = {
 	.set_rate = clk_divider_set_rate,
 };
 
-static struct clk *_register_divider(struct device *dev, const char *name,
+static struct clk *_register_divider(struct udevice *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table)
@@ -227,7 +227,7 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 	return clk;
 }
 
-struct clk *clk_register_divider(struct device *dev, const char *name,
+struct clk *clk_register_divider(struct udevice *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags)
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index d44ead53079..198f3ff0e42 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -237,7 +237,7 @@ struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div);
 
-struct clk *clk_register_divider(struct device *dev, const char *name,
+struct clk *clk_register_divider(struct udevice *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags);
-- 
2.47.2

