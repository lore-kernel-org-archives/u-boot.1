Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DC8C35FF3
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FAE181A0C;
	Wed, 19 Mar 2025 04:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742354377;
	bh=aOMJ0nWXdukmOpqbsfPeQ6l1ebX+d5ZGYP1ZqATpV7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nSezayVVjoILgGamlRVN2hKBXMHoS0f4FBGP2c9CbL9wEww6ju266IUyeNYWZeYFe
	 c5a/WaFKATbpCoycsDbMgArPvBbu3NZWdcClADV+aWwhVTo3by+mWqDqZoL8bmQbgl
	 5CYPRg1o6q+kRPCZDzQF7RpfWn0IBAD8O9MINAl2ZE0CisKcP1VHhicmcuK5rsGfU0
	 +59N1wOlsKQTcane12GfwmRZIwZi3IT7Y9EWVXTm6UB2blsyKPiViAsp5lLAiTIZjN
	 J/FfacERVdBHjGJS9vmontMH990fEJKwNMM+q5LfcRUuMcZjMwZeUU5xmUZlJ8hS++
	 kUl9nre19v/VA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D37B781E25; Wed, 19 Mar 2025 04:19:30 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4A2F81026
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:19:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="aduvLuCn"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 76324101E91C3; Wed, 19 Mar 2025 04:19:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742354368; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=aOMJ0nWXdukmOpqbsfPeQ6l1ebX+d5ZGYP1ZqATpV7c=;
 b=aduvLuCnJ7yhQKCzHTlYHw6H2qJ5QS+aicEbR8dzVJm0mZny6P7oDBAEM2iOX/mAeEOO2W
 bc3HFvh8r6IxhPChFGWtNhg2ZoMg3k201J0bNK1MGwiPTyonS1PnrOg1VTkYo3JPP9pQCO
 XS6UTCm1hwOr0S13m1QNLdLyVISqpS+oogGA2pMOnvJTc/RjrdX2AcMhTifmDeIKXkZ/4p
 KQa1wbBPu8Xl5qAuX5Ji9wIsxU3VJbE4L/L3TS2CrZIF4yiWl/YwEqE2u5ZcyHt4uYcpzB
 jriXG5FUzl1B6FBi8tPibro/+mVQlp+tuxxhRAfmqNwllEPJ4h37sAP3P27yTg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH 13/24] clk: clk-composite: Use struct udevice instead of
 struct device
Date: Wed, 19 Mar 2025 04:17:23 +0100
Message-ID: <20250319031852.233537-14-marex@denx.de>
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

Use U-Boot specific struct udevice instead of Linux compatibility
struct device in clk-composite registration.

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
 drivers/clk/clk-composite.c  | 2 +-
 include/linux/clk-provider.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 199ca6eaa37..1191bdf87df 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -97,7 +97,7 @@ static int clk_composite_disable(struct clk *clk)
 		return 0;
 }
 
-struct clk *clk_register_composite(struct device *dev, const char *name,
+struct clk *clk_register_composite(struct udevice *dev, const char *name,
 				   const char * const *parent_names,
 				   int num_parents, struct clk *mux,
 				   const struct clk_ops *mux_ops,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index e282be12897..d44ead53079 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -223,7 +223,7 @@ struct clk_composite {
 
 #define to_clk_composite(_clk) container_of(_clk, struct clk_composite, clk)
 
-struct clk *clk_register_composite(struct device *dev, const char *name,
+struct clk *clk_register_composite(struct udevice *dev, const char *name,
 		const char * const *parent_names, int num_parents,
 		struct clk *mux_clk, const struct clk_ops *mux_ops,
 		struct clk *rate_clk, const struct clk_ops *rate_ops,
-- 
2.47.2

