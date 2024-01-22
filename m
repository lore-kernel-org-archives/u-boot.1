Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374F0C47DD9
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 14:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71B93879CC;
	Mon, 22 Jan 2024 15:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fe3Q+6ct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E01F8785F; Mon, 22 Jan 2024 15:33:33 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19F59879CC
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 15:33:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A49A6CE2AE7;
 Mon, 22 Jan 2024 14:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47E71C43394;
 Mon, 22 Jan 2024 14:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705934006;
 bh=1YzYQhExN++o1qD/ja6qKuVld73DpcOs7n5d+jXjMYM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=fe3Q+6ctevTA/jhOZ0DMIWcvQwNjMzA7vsyMAixdDA8XJE/EkcWGU0MeEjTH27Obq
 yl7T4lxl1gMangxroJE++e+RW+8rfwbAIE/JerryZPC+BEN539N7JE8jGamgnkT+5G
 QLRpUxmEJtEfZKNZ6ymex7tT5reU6va8slLK0lpalElNIH5FE1TxKAMaD3McRst3HR
 Dgn4Kpqn0OdUZzVkmTswW0K74+aTMXCsiwgqpKLutag26MjJsQeWYROMJsL2alDHdb
 ojcVskn8JJNmcPaL33TKHdTpZ/iDPnmUUlbBfQ9c1MWqF4ys52pJomRMW5/H+s5hhz
 165HJa3vd6WOA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 30DA1C47DDB;
 Mon, 22 Jan 2024 14:33:26 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Mon, 22 Jan 2024 22:33:22 +0800
Subject: [PATCH v3 3/5] net: hifemac: register MDIO bus device for subnode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-net-v3-3-f1e80564725b@outlook.com>
References: <20240122-net-v3-0-f1e80564725b@outlook.com>
In-Reply-To: <20240122-net-v3-0-f1e80564725b@outlook.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705934004; l=1700;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=NCJcSa/cOcfklo9ByKOIk+8yiytHK/pmWUU7P4ZbEz8=;
 b=Oj5+nJsBVYJPcW5PcMmiSFeERAZ6Bk7+HKTzpww6PO+QT7bZzj0LhKNHNRSHV/MFB6B/Bm04b
 AXQeIJLlR7CCwA3DvN/GIIBkZ4V0fGVXW7vriIDQ5q22UGHCTHzmFiC
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

register internal MDIO bus device if it is a subnode.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/hifemac.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/hifemac.c b/drivers/net/hifemac.c
index 1088f3eca3..39c0233b62 100644
--- a/drivers/net/hifemac.c
+++ b/drivers/net/hifemac.c
@@ -15,6 +15,7 @@
 #include <wait_bit.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
+#include <dm/lists.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 
@@ -337,6 +338,8 @@ int hisi_femac_of_to_plat(struct udevice *dev)
 {
 	int ret, i;
 	struct hisi_femac_priv *priv = dev_get_priv(dev);
+	ofnode mdio_node;
+	bool mdio_registered = false;
 	static const char * const clk_strs[] = {
 		[CLK_MAC] = "mac",
 		[CLK_BUS] = "bus",
@@ -388,6 +391,31 @@ int hisi_femac_of_to_plat(struct udevice *dev)
 						     MAC_RESET_DELAY_PROPERTY,
 						     MAC_RESET_ASSERT_PERIOD);
 
+	/* Create MDIO bus */
+	ofnode_for_each_subnode(mdio_node, dev_ofnode(dev)) {
+		const char *subnode_name = ofnode_get_name(mdio_node);
+		struct udevice *mdiodev;
+
+		// Skip subnodes not starting with "mdio"
+		if (strncmp(subnode_name, "mdio", 4))
+			continue;
+
+		ret = device_bind_driver_to_node(dev, "hisi-femac-mdio",
+						 subnode_name, mdio_node, &mdiodev);
+		if (ret) {
+			dev_err(dev, "Failed to register MDIO bus device %d\n", ret);
+			return log_msg_ret("net", ret);
+		}
+
+		mdio_registered = true;
+		break;
+	}
+
+	if (!mdio_registered) {
+		dev_err(dev, "No MDIO subnode is found!\n");
+		return log_msg_ret("mdio", -ENODATA);
+	}
+
 	return 0;
 }
 

-- 
2.43.0

