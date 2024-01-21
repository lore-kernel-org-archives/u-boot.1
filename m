Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1759C47DB7
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 21:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02F46878E2;
	Sun, 21 Jan 2024 22:02:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NLw+WluO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5BB787930; Sun, 21 Jan 2024 22:02:15 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6B6B878E2
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 22:02:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id BCB4DCE2539;
 Sun, 21 Jan 2024 21:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 070A2C43394;
 Sun, 21 Jan 2024 21:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705870931;
 bh=1YzYQhExN++o1qD/ja6qKuVld73DpcOs7n5d+jXjMYM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=NLw+WluO64XzRV96SXs2f038KoMN3L+QcJXRNyfSbWVFg5mU4oeiZ5Vp/g30ptK/C
 LKmnEQrZ3gG36vOlYg2kxzCJCeEyCGm8n6WnsQhQycsjXh7+rt9fC6Q17x6FEzTaYq
 k6M7UGgI/Bn60Qybe/DUT6bKM5XRH8tg6i1/Ave/QXDw+K5zfy5rjVXlb+LBOnGlRY
 oIeLms9dx0y6eYGTTQkjc2/aGkICXDeDiRFWO7UVMqGc9cbOdkRImg3f9NJby+xok5
 9tLXt/SW94T4zpglFJRQtsErHLIHjxEGK8vMBIJCzMbAFvDkqtgeXb35Qc5tH/zPQO
 u85xo/CtF/ZhA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E0C65C47DD9;
 Sun, 21 Jan 2024 21:02:10 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Mon, 22 Jan 2024 05:02:06 +0800
Subject: [PATCH v2 3/4] net: hifemac: register MDIO bus device for subnode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-net-v2-3-78a368896f62@outlook.com>
References: <20240122-net-v2-0-78a368896f62@outlook.com>
In-Reply-To: <20240122-net-v2-0-78a368896f62@outlook.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705870930; l=1700;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=NCJcSa/cOcfklo9ByKOIk+8yiytHK/pmWUU7P4ZbEz8=;
 b=zP/278dnFb6/4BqS7ogZuRVjMH7w5DlOS4kf5J87ETf1OeLtyLnOH991uWxA3J8efKj6ozc1b
 12d+6QdWG3rBhx3ifuHhwVrAaqDAH5POq4K1NANam6foQELiTUhvh17
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

