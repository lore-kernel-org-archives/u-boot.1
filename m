Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D42DC27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 21:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5CA5884A3;
	Wed, 19 Jun 2024 23:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4FF4884B8; Wed, 19 Jun 2024 23:13:44 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1507884A3
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 23:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1sK2cf-00EKlt-De;
 Wed, 19 Jun 2024 21:13:41 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Fabio Estevam <festevam@gmail.com>,
	u-boot@lists.denx.de
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] board: gateworks: venice: add print for GPY111 PHY name
Date: Wed, 19 Jun 2024 14:13:39 -0700
Message-Id: <20240619211339.2068298-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

Due to supply chain issues Venice boards use either a DP83867 or a
GPY111 RGMII PHY. We already print an identifier for the DP83867 so add
one for the GPY111 to better identify what PHY is on a board:

Example:
 Net:   GPY111 eth0: ethernet@30be0000 [PRIME]
 Net:   DP83867 eth0: ethernet@30be0000 [PRIME]

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 board/gateworks/venice/venice.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/gateworks/venice/venice.c b/board/gateworks/venice/venice.c
index 5b105d7659e4..3080ff20cb02 100644
--- a/board/gateworks/venice/venice.c
+++ b/board/gateworks/venice/venice.c
@@ -75,6 +75,9 @@ int board_phy_config(struct phy_device *phydev)
 		val |= 0xb << 8; /* LED2(Green;Link/Act): blink for TX/RX act */
 		phy_write(phydev, MDIO_DEVAD_NONE, 24, val);
 		break;
+	case 0xd565a401: /* MaxLinear GPY111 */
+		puts("GPY111 ");
+		break;
 	}
 
 	if (phydev->drv->config)
-- 
2.25.1

