Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BC1C369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 20:02:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB746826B2;
	Mon, 14 Apr 2025 22:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="L1A+7g6r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 428D482102; Mon, 14 Apr 2025 22:01:56 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64A3582160
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 22:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=chTocPmnTGcYA4mHRkPV/g6VllAIU+MveK0QZSVx8Nc=; b=L1A+7g6r7RJ//ueooSLSGxA0xB
 jEtLd4Tu+fwu9hmjRrjQSO7DHhAx14KBOY9hz+zzEqMWjmvK5LLX3Q8sGzEu5g9M3dkU9bH0offyW
 y/8HPl6BRQkoC6NcWnq21BqF00hyglD3F2OslTWixeNa9hBEzTo41Rc9v+6DndiAtYWwCkhc24zew
 k5j/GiJPNTM5zINSRW78sMP5s0IDii6lbtrg5RKRw8vEYfNfUS49GPnpq9uM9zZXS7ZfCSJlLg1Id
 o3PvMLfRtFWE9+Pu1nePcM/oMySeqxhsA+Q6y5QNJ6OI0fbS/RqFiJqeeWGAny0gJuFQF6p20tIjr
 R4ZyBbUQ==;
Received: from i53875b95.versanet.de ([83.135.91.149]
 helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1u4Pzw-0001rf-E3; Mon, 14 Apr 2025 22:01:40 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
Subject: [PATCH v2 08/16] ram: rockchip: Add rk3576 ddr driver support
Date: Mon, 14 Apr 2025 22:01:03 +0200
Message-ID: <20250414200111.1357867-9-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250414200111.1357867-1-heiko@sntech.de>
References: <20250414200111.1357867-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add ddr driver for rk3576 to get the ram capacity.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/ram/rockchip/Makefile       |  1 +
 drivers/ram/rockchip/sdram_rk3576.c | 35 +++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 drivers/ram/rockchip/sdram_rk3576.c

diff --git a/drivers/ram/rockchip/Makefile b/drivers/ram/rockchip/Makefile
index f222cc99f1e..fd94aad0cd4 100644
--- a/drivers/ram/rockchip/Makefile
+++ b/drivers/ram/rockchip/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ROCKCHIP_RK3328) = sdram_rk3328.o sdram_pctl_px30.o sdram_phy_px30.
 obj-$(CONFIG_ROCKCHIP_RK3399) += sdram_rk3399.o
 obj-$(CONFIG_ROCKCHIP_RK3528) += sdram_rk3528.o
 obj-$(CONFIG_ROCKCHIP_RK3568) += sdram_rk3568.o
+obj-$(CONFIG_ROCKCHIP_RK3576) += sdram_rk3576.o
 obj-$(CONFIG_ROCKCHIP_RK3588) += sdram_rk3588.o
 obj-$(CONFIG_ROCKCHIP_RV1126) += sdram_rv1126.o sdram_pctl_px30.o
 obj-$(CONFIG_ROCKCHIP_SDRAM_COMMON) += sdram_common.o
diff --git a/drivers/ram/rockchip/sdram_rk3576.c b/drivers/ram/rockchip/sdram_rk3576.c
new file mode 100644
index 00000000000..5a66032ef8f
--- /dev/null
+++ b/drivers/ram/rockchip/sdram_rk3576.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2024 Rockchip Electronics Co., Ltd.
+ */
+
+#include <dm.h>
+#include <ram.h>
+#include <asm/arch-rockchip/sdram.h>
+
+#define PMU1GRF_BASE			0x26026000
+#define OS_REG2_REG			0x208
+
+static int rk3576_dmc_get_info(struct udevice *dev, struct ram_info *info)
+{
+	info->base = CFG_SYS_SDRAM_BASE;
+	info->size = rockchip_sdram_size(PMU1GRF_BASE + OS_REG2_REG);
+
+	return 0;
+}
+
+static struct ram_ops rk3576_dmc_ops = {
+	.get_info = rk3576_dmc_get_info,
+};
+
+static const struct udevice_id rk3576_dmc_ids[] = {
+	{ .compatible = "rockchip,rk3576-dmc" },
+	{ }
+};
+
+U_BOOT_DRIVER(rockchip_rk3576_dmc) = {
+	.name = "rockchip_rk3576_dmc",
+	.id = UCLASS_RAM,
+	.of_match = rk3576_dmc_ids,
+	.ops = &rk3576_dmc_ops,
+};
-- 
2.47.2

