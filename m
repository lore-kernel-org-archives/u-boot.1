Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B54C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 19:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04D08805C3;
	Tue,  4 Mar 2025 20:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 242A480805; Tue,  4 Mar 2025 20:45:28 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 5561B800C1
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 20:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: kAD4WOrISbSO+jvYD15rBg==
X-CSE-MsgGUID: ZddFVLTqTHqL0MH4ZKdRIg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 05 Mar 2025 04:45:22 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.7])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7BD5D40869CF;
 Wed,  5 Mar 2025 04:45:19 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH] clk: rzg2l: Ignore disable for core clocks
Date: Tue,  4 Mar 2025 19:44:35 +0000
Message-ID: <20250304194441.90108-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
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

Following on from commit 9a699a0a0d62 ("clk: rzg2l: Ignore enable for
core clocks"), we also need to ignore attempts to disable core clocks to
avoid the need for conditionals around clk_disable_bulk() calls in
drivers which support both RZ/G2L and other Renesas SoCs.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 3c5340df8eed..7fce1f70d138 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -70,17 +70,12 @@ static int rzg2l_cpg_clk_set(struct clk *clk, bool enable)
 	dev_dbg(clk->dev, "%s %s clock %u\n", enable ? "enable" : "disable",
 		is_mod_clk(clk->id) ? "module" : "core", cpg_clk_id);
 
-	if (!is_mod_clk(clk->id)) {
-		/*
-		 * Non-module clocks are always on. Ignore attempts to enable
-		 * them and reject attempts to disable them.
-		 */
-		if (enable)
-			return 0;
-
-		dev_err(clk->dev, "ID %lu is not a module clock\n", clk->id);
-		return -EINVAL;
-	}
+	/*
+	 * Non-module clocks are always on. Ignore attempts to enable or disable
+	 * them.
+	 */
+	if (!is_mod_clk(clk->id))
+		return 0;
 
 	for (i = 0; i < data->info->num_mod_clks; i++) {
 		if (data->info->mod_clks[i].id == cpg_clk_id) {
-- 
2.43.0

