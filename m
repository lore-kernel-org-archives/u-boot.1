Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503F4D7876B
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 14:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D31D189766;
	Thu, 21 Nov 2024 15:31:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="1fFbQRAZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A58DA88D90; Thu, 21 Nov 2024 15:31:32 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4F9E89776
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 15:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I3AYke+rrS6bosh99zxg+IPC3nuqOnyMQLtoM/Henig=; b=1fFbQRAZkD7FoYVD3fTze7ugFy
 GNljfI36QPX9Hrwk8qOdbJJaN3/+SA+3eUP/aty9e0auyOCueQm8nt1cGoKg/ugk5mViR8gdCsfP5
 mtdMFxYLhwMpvRTiARYAXOl0TfaVudtHjfEdmB3QLHpTr3rJkhJ9n4D/OPb9ly+IbL+8TW06T+sMG
 pPQWmbGxffq274/xd+Qr7PKAtvbb/d5wrhf2qqv+2JWTXnncSSG+WMWrab4YTUyGg/yCVAClsnnCM
 WJMdIlOBGVe50NZnKQXzDr7cc3WIzT0/CDrMnU8BSy9DilrDGLAeA8nvBAm3uGimczHW/Zj/Rq+hE
 amHWJqag==;
Received: from [185.156.123.69] (helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1tE8A5-0007f9-Rj; Thu, 21 Nov 2024 15:28:01 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
Subject: [PATCH 15/20] ram: rockchip: Add rk3576 ddr driver support
Date: Thu, 21 Nov 2024 15:27:26 +0100
Message-ID: <20241121142731.1202209-16-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121142731.1202209-1-heiko@sntech.de>
References: <20241121142731.1202209-1-heiko@sntech.de>
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
 drivers/ram/rockchip/sdram_rk3576.c | 65 +++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 drivers/ram/rockchip/sdram_rk3576.c

diff --git a/drivers/ram/rockchip/Makefile b/drivers/ram/rockchip/Makefile
index 36dc0500dab..442fe73deb6 100644
--- a/drivers/ram/rockchip/Makefile
+++ b/drivers/ram/rockchip/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_ROCKCHIP_RK3308) = sdram_rk3308.o
 obj-$(CONFIG_ROCKCHIP_RK3328) = sdram_rk3328.o sdram_pctl_px30.o sdram_phy_px30.o
 obj-$(CONFIG_ROCKCHIP_RK3399) += sdram_rk3399.o
 obj-$(CONFIG_ROCKCHIP_RK3568) += sdram_rk3568.o
+obj-$(CONFIG_ROCKCHIP_RK3576) += sdram_rk3576.o
 obj-$(CONFIG_ROCKCHIP_RK3588) += sdram_rk3588.o
 obj-$(CONFIG_ROCKCHIP_RV1126) += sdram_rv1126.o sdram_pctl_px30.o
 obj-$(CONFIG_ROCKCHIP_SDRAM_COMMON) += sdram_common.o
diff --git a/drivers/ram/rockchip/sdram_rk3576.c b/drivers/ram/rockchip/sdram_rk3576.c
new file mode 100644
index 00000000000..fa4187a5860
--- /dev/null
+++ b/drivers/ram/rockchip/sdram_rk3576.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2024 Rockchip Electronics Co., Ltd.
+ */
+
+#include <config.h>
+#include <dm.h>
+#include <ram.h>
+#include <syscon.h>
+#include <asm/arch-rockchip/clock.h>
+#include <asm/arch-rockchip/grf_rk3576.h>
+#include <asm/arch-rockchip/sdram.h>
+
+struct dram_info {
+	struct ram_info info;
+	struct rk3576_pmu1grf *pmugrf;
+};
+
+static int rk3576_dmc_probe(struct udevice *dev)
+{
+	struct dram_info *priv = dev_get_priv(dev);
+
+	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
+
+	/*
+	 * On a 16GB board the DDR ATAG reports:
+	 * start 0x40000000, size 0x400000000
+	 * While the size value from the pmugrf below reports
+	 * pmugrf->osreg2: 0x400000000
+	 * pmugrf->osreg4:  0x10000000
+	 * So it seems only osreg2 is responsible for the ram size.
+	 */
+	priv->info.base = CFG_SYS_SDRAM_BASE;
+	priv->info.size =
+		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg[2]);
+
+	return 0;
+}
+
+static int rk3576_dmc_get_info(struct udevice *dev, struct ram_info *info)
+{
+	struct dram_info *priv = dev_get_priv(dev);
+
+	*info = priv->info;
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
+U_BOOT_DRIVER(dmc_rk3576) = {
+	.name = "rockchip_rk3576_dmc",
+	.id = UCLASS_RAM,
+	.of_match = rk3576_dmc_ids,
+	.ops = &rk3576_dmc_ops,
+	.probe = rk3576_dmc_probe,
+	.priv_auto = sizeof(struct dram_info),
+};
-- 
2.45.2

