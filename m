Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E1FC47DAF
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 11:44:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9130887C0B;
	Fri, 19 Jan 2024 12:44:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HckaXCbM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBDD187AEC; Fri, 19 Jan 2024 12:44:37 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05D0F87BB4
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 12:44:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 634A4CE222D;
 Fri, 19 Jan 2024 11:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2097C43390;
 Fri, 19 Jan 2024 11:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705664669;
 bh=1YzYQhExN++o1qD/ja6qKuVld73DpcOs7n5d+jXjMYM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=HckaXCbMSBKwmnl2iTEmN/09i26TIufG5LBiLSjnmF6Uq4xUymo9eyhuNOAXZtP08
 cw6yiMMjx1JMrYCPQaCt+aXaolSPzsUTN1mLciq8md3lS/qiG/yLrPRI5UD/GcDJgg
 E7nGfjubkUXTxdvQuUmloZTLBkl8apppEaqUHxtgjF9Wo38btHoCI4ZNyqqAb9kOc9
 lT2ityVLUDjZYhzOp5hLFHDoypcp8jDRb6lGfUJ6d80ImN3dWS4r1F5KykCvvNGSkB
 YnUhUFbSAM7odrABvWREg5rRj4kSkHoDp0sG1qUK1Rep+Ue3dpTaPxg9QYvIjwkmaA
 AoVWLYicW3iJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8C25CC47DD7;
 Fri, 19 Jan 2024 11:44:29 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 19 Jan 2024 19:44:30 +0800
Subject: [PATCH 3/3] net: hifemac: register MDIO bus device for subnode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240119-net-v1-3-d1feb8e16ac6@outlook.com>
References: <20240119-net-v1-0-d1feb8e16ac6@outlook.com>
In-Reply-To: <20240119-net-v1-0-d1feb8e16ac6@outlook.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705664668; l=1700;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=NCJcSa/cOcfklo9ByKOIk+8yiytHK/pmWUU7P4ZbEz8=;
 b=rND95nDtP/9KqbaXnMyNzdr5maqnmP/r5Ct482hfEGeJQBM1OCC6U8S7H0TN9KJjp2u+oiQ7c
 VUD2q2vTjSSBsjJvaWqFHCViM8mHbZgtlR4IW+XqJsGL2JciIfD6jUp
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

