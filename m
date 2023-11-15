Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9012CC072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 17:40:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F1498745B;
	Wed, 15 Nov 2023 18:40:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE1DE8718B; Wed, 15 Nov 2023 18:40:43 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 7D0F787278
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 18:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,305,1694703600"; d="scan'208";a="183039315"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 16 Nov 2023 02:40:40 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.122])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1628540342AD;
 Thu, 16 Nov 2023 02:40:37 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 1/5] clk: renesas: Confirm all clock & reset changes on RZ/G2L
Date: Wed, 15 Nov 2023 17:40:21 +0000
Message-Id: <20231115174025.12974-2-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231115174025.12974-1-paul.barker.ct@bp.renesas.com>
References: <20231115174025.12974-1-paul.barker.ct@bp.renesas.com>
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

When enabling/disabling a clock or reset signal, confirm that the change
has completed before returning from the function. A somewhat arbitrary
100ms timeout is defined to ensure that the system doesn't lock up in
the case of an error.

Since we need to dynamically determine if we're waiting for a 0 bit or a
1 bit, it's easier to use wait_for_bit_32() than readl_poll_timeout().

This change is needed for reliable initialization of the I2C driver
which is added in a following patch.

Fixes: 1918ff5c95be ("clk: renesas: Add RZ/G2L & RZ/G2LC CPG driver")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index e54508c35ce2..dba009997a81 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -23,10 +23,18 @@
 #include <linux/iopoll.h>
 #include <reset-uclass.h>
 #include <reset.h>
+#include <wait_bit.h>
 
 #include "rzg2l-cpg.h"
 
+/*
+ * Monitor registers for both clock and reset signals are offset by 0x180 from
+ * the corresponding control registers.
+ */
 #define CLK_MON_R(reg)		(0x180 + (reg))
+#define RST_MON_R(reg)		(0x180 + (reg))
+
+#define CPG_TIMEOUT_MSEC	100
 
 static ulong rzg2l_cpg_clk_get_rate_by_id(struct udevice *dev, unsigned int id);
 static ulong rzg2l_cpg_clk_get_rate_by_name(struct udevice *dev, const char *name);
@@ -83,9 +91,9 @@ static int rzg2l_cpg_clk_set(struct clk *clk, bool enable)
 		value |= BIT(mod_clk->bit);
 	writel(value, data->base + mod_clk->off);
 
-	if (enable && readl_poll_timeout(data->base + CLK_MON_R(mod_clk->off),
-					 value, (value & BIT(mod_clk->bit)),
-					 10)) {
+	if (enable && wait_for_bit_32(data->base + CLK_MON_R(mod_clk->off),
+				      BIT(mod_clk->bit), enable,
+				      CPG_TIMEOUT_MSEC, false)) {
 		dev_err(clk->dev, "Timeout\n");
 		return -ETIMEDOUT;
 	}
@@ -420,7 +428,8 @@ static int rzg2l_cpg_rst_set(struct reset_ctl *reset_ctl, bool asserted)
 		value |= BIT(rst->bit);
 	writel(value, data->base + rst->off);
 
-	return 0;
+	return wait_for_bit_32(data->base + RST_MON_R(rst->off), BIT(rst->bit),
+			       asserted, CPG_TIMEOUT_MSEC, false);
 }
 
 static int rzg2l_cpg_rst_assert(struct reset_ctl *reset_ctl)
-- 
2.39.2

