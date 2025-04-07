Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62A1C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6CEF8318F;
	Tue,  8 Apr 2025 00:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="0UNeRxk5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30201831B4; Tue,  8 Apr 2025 00:48:52 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7833E8318F
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab18=W2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744066126; bh=+yLFkAwQA/Gh6Xc0o6NQuG+FJ1WtdtmUGVGo1KcfNu0=;
 b=0UNeRxk5jb7rDEhUXQPvIyKulxW3fUWzhJ5JKNI90F2MSYp/Ku+nH/ml3k5V8Q9AR0HO9FJF2
 AeWYi3eeyDedL1M7f57bMJuE2fX2wxnyjkbsjSLhQOKWOc4WwcUfeEe1n3u3mqFdg6dIuZk9Oqn
 NOKgS21N0UFs6O/PZFfuQRhN5XHnFI36QXuYIKb8ioQ6h2mLybjhrwQ5MmU4PyRUr+kC9h3izwk
 gw1NWqylxvxxp5tpLfvTpfsZvssgHN7/68N+hr0o0GqGM1Qs9zFIMLq4uOpbNW7LSIP+LnnAMO5
 k/9WwtodOgcGcZ417u4eiAz1T4Wj62OijU/bYr+7BLyw==
X-Forward-Email-ID: 67f4564b9fd75b9b96512893
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 15/30] ram: rockchip: Add basic support for RK3528
Date: Mon,  7 Apr 2025 22:46:48 +0000
Message-ID: <20250407224743.2423921-16-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407224743.2423921-1-jonas@kwiboo.se>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
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

Add support for reading DRAM size information from PMUGRF os_reg18 reg.

Compared to most Rockchip SoCs the RK3528 use os_reg18 for DRAM info,
instead of os_reg2.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 arch/arm/mach-rockchip/sdram.c      |  3 ++-
 drivers/ram/rockchip/Makefile       |  1 +
 drivers/ram/rockchip/sdram_rk3528.c | 33 +++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ram/rockchip/sdram_rk3528.c

diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index 0bdda77a7926..91a6606d461f 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -110,7 +110,8 @@ static int rockchip_dram_init_banksize(void)
 	u8 i, j;
 
 	if (!IS_ENABLED(CONFIG_ROCKCHIP_RK3588) &&
-	    !IS_ENABLED(CONFIG_ROCKCHIP_RK3568))
+	    !IS_ENABLED(CONFIG_ROCKCHIP_RK3568) &&
+	    !IS_ENABLED(CONFIG_ROCKCHIP_RK3528))
 		return -ENOTSUPP;
 
 	if (!IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL))
diff --git a/drivers/ram/rockchip/Makefile b/drivers/ram/rockchip/Makefile
index 36dc0500dab5..f222cc99f1e4 100644
--- a/drivers/ram/rockchip/Makefile
+++ b/drivers/ram/rockchip/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_ROCKCHIP_RK3288) = sdram_rk3288.o
 obj-$(CONFIG_ROCKCHIP_RK3308) = sdram_rk3308.o
 obj-$(CONFIG_ROCKCHIP_RK3328) = sdram_rk3328.o sdram_pctl_px30.o sdram_phy_px30.o
 obj-$(CONFIG_ROCKCHIP_RK3399) += sdram_rk3399.o
+obj-$(CONFIG_ROCKCHIP_RK3528) += sdram_rk3528.o
 obj-$(CONFIG_ROCKCHIP_RK3568) += sdram_rk3568.o
 obj-$(CONFIG_ROCKCHIP_RK3588) += sdram_rk3588.o
 obj-$(CONFIG_ROCKCHIP_RV1126) += sdram_rv1126.o sdram_pctl_px30.o
diff --git a/drivers/ram/rockchip/sdram_rk3528.c b/drivers/ram/rockchip/sdram_rk3528.c
new file mode 100644
index 000000000000..89d325bea667
--- /dev/null
+++ b/drivers/ram/rockchip/sdram_rk3528.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright Contributors to the U-Boot project.
+
+#include <dm.h>
+#include <ram.h>
+#include <asm/arch-rockchip/sdram.h>
+
+#define PMUGRF_BASE			0xff370000
+#define OS_REG18_REG			0x248
+
+static int rk3528_dmc_get_info(struct udevice *dev, struct ram_info *info)
+{
+	info->base = CFG_SYS_SDRAM_BASE;
+	info->size = rockchip_sdram_size(PMUGRF_BASE + OS_REG18_REG);
+
+	return 0;
+}
+
+static struct ram_ops rk3528_dmc_ops = {
+	.get_info = rk3528_dmc_get_info,
+};
+
+static const struct udevice_id rk3528_dmc_ids[] = {
+	{ .compatible = "rockchip,rk3528-dmc" },
+	{ }
+};
+
+U_BOOT_DRIVER(rockchip_rk3528_dmc) = {
+	.name = "rockchip_rk3528_dmc",
+	.id = UCLASS_RAM,
+	.of_match = rk3528_dmc_ids,
+	.ops = &rk3528_dmc_ops,
+};
-- 
2.49.0

