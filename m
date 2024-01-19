Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA97DC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 11:44:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A837187BA2;
	Fri, 19 Jan 2024 12:44:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oQ8MRj2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 066BB87BB8; Fri, 19 Jan 2024 12:44:33 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ACCA87AEC
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 12:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 330C1B81B9F;
 Fri, 19 Jan 2024 11:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9010FC433C7;
 Fri, 19 Jan 2024 11:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705664669;
 bh=MRywOI5mMqqVDKrHwJcSWTqepGOtl1p18Ppgm5ATlB4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=oQ8MRj2XjEJed5purIZsnQv6wRQJFqTm86Y76I7KEj6cKPP9N+6gYrodllfCMkS3w
 Rm9AIHiI0UTruUn8w8aKGgde72VLTmmMB7nNvi8v9EdAwRvxqjETqrojYNdJmvFmMW
 VWxYcqOpl9WZrlMbGvCSHM+x6/SUfkpzKyjcussEG881JMD+FWG3uQ1/0ELbAY2sLI
 w1ofY9GQ6JVPI1dHAZ2rKNio5IKNFzlXA2Q4LGLlmV0rMuTkhwLSzTy63ARnCiqhkZ
 1XmkZf1v0toaB7+WoAcUWvtI9umz+Mk4H5mas1lfTgU/asbiKOvO1b/JQH2crKtO+D
 z81tumDkDP14Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 774B2C47DB7;
 Fri, 19 Jan 2024 11:44:29 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 19 Jan 2024 19:44:28 +0800
Subject: [PATCH 1/3] net: hifemac_mdio: use log_msg_ret() correctly, report
 error by dev_err()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240119-net-v1-1-d1feb8e16ac6@outlook.com>
References: <20240119-net-v1-0-d1feb8e16ac6@outlook.com>
In-Reply-To: <20240119-net-v1-0-d1feb8e16ac6@outlook.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705664668; l=1755;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=hQDPCsolPbXnTnIjMDCaSwJsmF0AaJNRipJEFZgsKnM=;
 b=0Y9NUVf/dnK7eyp9YaiKpwSHdehsbKfm3+9KpmUD5/xzRYTK627DmdtlcpgwVnUVYinUbwmIf
 EoY35LgcU9uCVd9KNRAxFp7XiBfbyhsQuLrI1EPvMWBRJQQ9j+8n7zr
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

The initial commit used log_msg_ret() wrongly. Fix that by moving error
report to a separate dev_err() call and shrink the first argument of
log_msg_ret() to no more than 4 chars.

Fixes: 6b5c8d98e204 ("net: add hifemac_mdio MDIO bus driver for HiSilicon platform")

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/hifemac_mdio.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hifemac_mdio.c b/drivers/net/hifemac_mdio.c
index 343c5f3a38..0b59d06091 100644
--- a/drivers/net/hifemac_mdio.c
+++ b/drivers/net/hifemac_mdio.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <clk.h>
 #include <miiphy.h>
+#include <dm/device_compat.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 
@@ -74,7 +75,8 @@ static int hisi_femac_mdio_of_to_plat(struct udevice *dev)
 	data->membase = dev_remap_addr(dev);
 	if (IS_ERR(data->membase)) {
 		ret = PTR_ERR(data->membase);
-		return log_msg_ret("Failed to remap base addr", ret);
+		dev_err(dev, "Failed to remap base addr %d\n", ret);
+		return log_msg_ret("mdio", ret);
 	}
 
 	// clk is optional
@@ -89,8 +91,10 @@ static int hisi_femac_mdio_probe(struct udevice *dev)
 	int ret;
 
 	ret = clk_prepare_enable(data->clk);
-	if (ret)
-		return log_msg_ret("Failed to enable clk", ret);
+	if (ret) {
+		dev_err(dev, "Failed to enable clock: %d\n", ret);
+		return log_msg_ret("clk", ret);
+	}
 
 	return 0;
 }
@@ -112,5 +116,6 @@ U_BOOT_DRIVER(hisi_femac_mdio_driver) = {
 	.of_to_plat = hisi_femac_mdio_of_to_plat,
 	.probe = hisi_femac_mdio_probe,
 	.ops = &hisi_femac_mdio_ops,
+	.plat_auto = sizeof(struct mdio_perdev_priv),
 	.priv_auto = sizeof(struct hisi_femac_mdio_data),
 };

-- 
2.43.0

