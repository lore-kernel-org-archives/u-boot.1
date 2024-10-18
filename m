Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEC7D2127B
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 07:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B798989185;
	Fri, 18 Oct 2024 09:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A198F8910A; Fri, 18 Oct 2024 09:52:04 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 84842892A6
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 09:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.11,213,1725289200"; d="scan'208";a="222310674"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 18 Oct 2024 16:51:58 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.135])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id BD63F419C356;
 Fri, 18 Oct 2024 16:51:55 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH] mmc: renesas-sdhi: Add compatible string for rzg2l-sdhi
Date: Fri, 18 Oct 2024 08:51:48 +0100
Message-Id: <20241018075148.2783-1-paul.barker.ct@bp.renesas.com>
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

After the recent dts/upstream subtree merge, the sdhi compatible string
used in the device tree for RZ/G2L family SoCs is "renesas,rzg2l-sdhi"
not "renesas,rcar-gen3-sdhi". This broke the ability to access the eMMC
and SD card devices on RZ/G2L boards.

Fix this by adding the new compatible string to the sdhi driver.

Fixes: 136b7b6d2e98 ("Subtree merge tag 'v6.11-dts' of dts repo [1] into dts/upstream")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/mmc/renesas-sdhi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
index 23db2a75c444..916182cdadea 100644
--- a/drivers/mmc/renesas-sdhi.c
+++ b/drivers/mmc/renesas-sdhi.c
@@ -863,6 +863,7 @@ static const struct udevice_id renesas_sdhi_match[] = {
 	{ .compatible = "renesas,sdhi-r8a77970", .data = RENESAS_GEN3_QUIRKS },
 	{ .compatible = "renesas,sdhi-r8a77990", .data = RENESAS_GEN3_QUIRKS },
 	{ .compatible = "renesas,sdhi-r8a77995", .data = RENESAS_GEN3_QUIRKS },
+	{ .compatible = "renesas,rzg2l-sdhi", .data = RENESAS_GEN3_QUIRKS },
 	{ .compatible = "renesas,rcar-gen4-sdhi", .data = RENESAS_GEN3_QUIRKS },
 	{ /* sentinel */ }
 };
-- 
2.43.0

