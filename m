Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E66C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A458E8210A;
	Sun, 23 Mar 2025 17:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745726;
	bh=9i8tpLu3yNY/HP+8J2pdogBB7bnw21GzFa25yhTtxOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vEwl9T4us+epUr9otB5h/lNbuPytdFhhtwDrsp0E85a1TeR81pwoZoADbGUs4r5LR
	 U7hUMncAUkuHfu6pseRl4EJ9II0jvXktdGBWx/uNKl6RoZrBIfBbT1cTozMT+8lONl
	 yrSvXQHtXGh+4TJqjJgp1XMw06GW/zZIKA94Y6mm5nYGOeCiJSyc0azz5JAUrsunPJ
	 RXQ4zNCNt1GxPH0YffY9KnTtX6Zdw8/BFhw94YQzMHl/S7qcvurQ86r48VxD5g97Jj
	 PZgcgHdVFT1wee05i+Ojp9v47ldTatPwLM18+SWDlkAV5HLi6s+C+jkNE4HKAF5PE2
	 rFpDyWbnd5y1Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4373481CFD; Sun, 23 Mar 2025 17:02:01 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F0DC81EDD
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="JtK/9GBc"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 287BA10290253; Sun, 23 Mar 2025 17:01:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745718; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=9i8tpLu3yNY/HP+8J2pdogBB7bnw21GzFa25yhTtxOM=;
 b=JtK/9GBcxiysQ6qAem5zzGH1Qx4fyU2X6bOrZUY1oDHrZtPX5p50Zw9SLMbN0tlTXbL4M2
 o/dnt0vk3irG3dTmKuPvjHn9UWblLG6M0jEA4J6RkvlD5GtMdsAhAf7MTtZeOhw7Qdt+7H
 MgTz2A6qokk/btmelxtIiFK/bZ/TlV+7UazN7Yxyr/EzHf+LIAX6OPmyPbrjLoFjMeN0MC
 MwaBwqB+esz8ll2pHMPZ+PiQdqLTDLDrj8nCU9ZPnKebn6tjOzm3o4zMrU4GWlbTnK4cYt
 6sRwBiJpQhkLKqdlwBueNi5Xa+6VKUpykqnzgvxk9NxemCb/fm0C/FfPJbElRQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 07/24] clk: clk-gate: Use struct udevice instead of struct
 device
Date: Sun, 23 Mar 2025 16:58:36 +0100
Message-ID: <20250323160107.145749-8-marex@denx.de>
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
struct device in clk-gate registration.

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
 drivers/clk/clk-gate.c       | 2 +-
 include/linux/clk-provider.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index bf1c6a93b46..cef98720b69 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -117,7 +117,7 @@ const struct clk_ops clk_gate_ops = {
 	.get_rate = clk_generic_get_rate,
 };
 
-struct clk *clk_register_gate(struct device *dev, const char *name,
+struct clk *clk_register_gate(struct udevice *dev, const char *name,
 			      const char *parent_name, unsigned long flags,
 			      void __iomem *reg, u8 bit_idx,
 			      u8 clk_gate_flags, spinlock_t *lock)
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index f27878ae6fa..e282be12897 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -105,7 +105,7 @@ struct clk_gate {
 #define CLK_GATE_HIWORD_MASK		BIT(1)
 
 extern const struct clk_ops clk_gate_ops;
-struct clk *clk_register_gate(struct device *dev, const char *name,
+struct clk *clk_register_gate(struct udevice *dev, const char *name,
 			      const char *parent_name, unsigned long flags,
 			      void __iomem *reg, u8 bit_idx,
 			      u8 clk_gate_flags, spinlock_t *lock);
-- 
2.47.2

