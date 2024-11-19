Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD18D6C28C
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 19:37:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A77C1895B9;
	Tue, 19 Nov 2024 20:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83A68895BF; Tue, 19 Nov 2024 20:37:00 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 5D90F895A2
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 20:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: 27OA87beQc+60egYxq3YMw==
X-CSE-MsgGUID: iqH2kQ5RTTeR4U7HkndZeA==
X-IronPort-AV: E=Sophos;i="6.12,166,1728918000"; d="scan'208";a="225336858"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 20 Nov 2024 04:36:53 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.197])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0E019400752D;
 Wed, 20 Nov 2024 04:36:40 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2] clk: rzg2l: Ignore enable for core clocks
Date: Tue, 19 Nov 2024 19:36:26 +0000
Message-Id: <20241119193626.2756-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.5
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

In the RZ/G2L family, core clocks are always on and can't be disabled.
However, drivers which are shared with other SoCs may call clk_enable()
or clk_enable_bulk() for a clock referenced in the device tree which
happens to be a core clock on the RZ/G2L. To avoid the need for
conditionals in these drivers, simply ignore attempts to enable a core
clock.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Changes v1->v2:
  - Split out of series adding RZ/G2L Ethernet support [1]
  - Added Marek's Reviewed-by tag

[1]: https://lore.kernel.org/all/20241024152448.102-1-paul.barker.ct@bp.renesas.com/

 drivers/clk/renesas/rzg2l-cpg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index c8735d869cf9..3c5340df8eed 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -69,7 +69,15 @@ static int rzg2l_cpg_clk_set(struct clk *clk, bool enable)
 
 	dev_dbg(clk->dev, "%s %s clock %u\n", enable ? "enable" : "disable",
 		is_mod_clk(clk->id) ? "module" : "core", cpg_clk_id);
+
 	if (!is_mod_clk(clk->id)) {
+		/*
+		 * Non-module clocks are always on. Ignore attempts to enable
+		 * them and reject attempts to disable them.
+		 */
+		if (enable)
+			return 0;
+
 		dev_err(clk->dev, "ID %lu is not a module clock\n", clk->id);
 		return -EINVAL;
 	}
-- 
2.43.0

