Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC52E7C6FA
	for <u-boot@archiver.kernel.org>; Sat, 31 Jan 2026 23:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0CC283C4B;
	Sun,  1 Feb 2026 00:39:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="lZMjg622";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FA5F83CF2; Sun,  1 Feb 2026 00:39:19 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF17283B86
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 00:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=19be=AF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1769902755; bh=qgKw7iB0vA/ab/EncjMEZEaVSLC4VEqo2ns7/hP6lLQ=;
 b=lZMjg622m/DksFxMY3idSmmf47VKLFR+fzoe8Y1dcXhkDWc7C4dK+HpiIsALPSqMD7YiZlgfE
 CRwgI0TP7SjC6FSQkRhX0yNdu1tCY84R4EnUq3Epkge+PxyrQzvf1aYM5KqlB4XR88dNyR/MdVQ
 dpQ1WhVjBumKuJp5k3jYuIdKYBgNYdgMU6tsDFvsfEWQy2vPf47T8KRXy2FfLarjQAveOLDR+Xj
 zWAZ4/Y6Mh9fjt/+xwDwClT/NEEdf6GRHO/ZVTNL6XbOH7xxLyXPbHxOHphwUALad7drz7w4ICu
 XeS8Q7jUqYeKLETI/3JzWjfbvT6DLheq1Pp8Yxwa3K+A==
X-Forward-Email-ID: 697e92a1de426c19931e056e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 04/12] ram: rockchip: Add basic support for RK3506
Date: Sat, 31 Jan 2026 23:38:15 +0000
Message-ID: <20260131233843.3419737-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260131233843.3419737-1-jonas@kwiboo.se>
References: <20260131233843.3419737-1-jonas@kwiboo.se>
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

Add support for reading DRAM size information from PMUGRF os_reg2 reg.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Aaron Griffith <aargri@gmail.com>
---
v2: Collect t-b tag
---
 drivers/ram/rockchip/Makefile       |  1 +
 drivers/ram/rockchip/sdram_rk3506.c | 33 +++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 drivers/ram/rockchip/sdram_rk3506.c

diff --git a/drivers/ram/rockchip/Makefile b/drivers/ram/rockchip/Makefile
index fd94aad0cd49..27921ae4921a 100644
--- a/drivers/ram/rockchip/Makefile
+++ b/drivers/ram/rockchip/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_ROCKCHIP_RK3288) = sdram_rk3288.o
 obj-$(CONFIG_ROCKCHIP_RK3308) = sdram_rk3308.o
 obj-$(CONFIG_ROCKCHIP_RK3328) = sdram_rk3328.o sdram_pctl_px30.o sdram_phy_px30.o
 obj-$(CONFIG_ROCKCHIP_RK3399) += sdram_rk3399.o
+obj-$(CONFIG_ROCKCHIP_RK3506) += sdram_rk3506.o
 obj-$(CONFIG_ROCKCHIP_RK3528) += sdram_rk3528.o
 obj-$(CONFIG_ROCKCHIP_RK3568) += sdram_rk3568.o
 obj-$(CONFIG_ROCKCHIP_RK3576) += sdram_rk3576.o
diff --git a/drivers/ram/rockchip/sdram_rk3506.c b/drivers/ram/rockchip/sdram_rk3506.c
new file mode 100644
index 000000000000..a8396ea88883
--- /dev/null
+++ b/drivers/ram/rockchip/sdram_rk3506.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright Contributors to the U-Boot project.
+
+#include <dm.h>
+#include <ram.h>
+#include <asm/arch-rockchip/sdram.h>
+
+#define PMUGRF_BASE			0xff910000
+#define OS_REG2_REG			0x208
+
+static int rk3506_dmc_get_info(struct udevice *dev, struct ram_info *info)
+{
+	info->base = CFG_SYS_SDRAM_BASE;
+	info->size = rockchip_sdram_size(PMUGRF_BASE + OS_REG2_REG);
+
+	return 0;
+}
+
+static struct ram_ops rk3506_dmc_ops = {
+	.get_info = rk3506_dmc_get_info,
+};
+
+static const struct udevice_id rk3506_dmc_ids[] = {
+	{ .compatible = "rockchip,rk3506-dmc" },
+	{ }
+};
+
+U_BOOT_DRIVER(rockchip_rk3506_dmc) = {
+	.name = "rockchip_rk3506_dmc",
+	.id = UCLASS_RAM,
+	.of_match = rk3506_dmc_ids,
+	.ops = &rk3506_dmc_ops,
+};
-- 
2.52.0

