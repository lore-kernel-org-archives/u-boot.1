Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4470FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 22:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5DEA846C1;
	Wed, 29 Apr 2026 00:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ImZkt/zk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F31C384664; Tue, 28 Apr 2026 20:04:52 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DC3984674
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+christian.dreher.nanoxplore.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F3DF0441D7;
 Tue, 28 Apr 2026 18:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7170C2BCB9;
 Tue, 28 Apr 2026 18:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777399486;
 bh=mrlGr/d8yy87uKVmydZvefXxDFcwk2ymAz8fKV2K0bw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=ImZkt/zk2eByNImLHBxftCqzf0E9leO3vl2FAmgtggKty+U7jEWDOvGGK79uxy542
 8GkcAWR0w1CNmhRgPH9KvgtQFtWWe99Hstrx6EQnPmVWxXAn+kLn3Vl4zooLY6e92T
 KJNkos8iVTgqu8sXIE8yskO+SmykifKpEAxDEyT74/z4oBYKTljj2BUG85RiTDDjsd
 /HbS9FxntURZlgyPJAUuYafnG1tM1kXzaF6MRY38AUUM1eFdqeezCdjbNfHeTcSkDq
 xwTxOWHP7yrHTITn8N3iii9WmPA+QO/HBMKNZF+b4C7G3bgKt2HfHQIIwwIGUc+HYh
 BbajxUVW3rumw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D0CC4FF885A;
 Tue, 28 Apr 2026 18:04:46 +0000 (UTC)
From: Christian DREHER via B4 Relay
 <devnull+christian.dreher.nanoxplore.com@kernel.org>
Date: Tue, 28 Apr 2026 20:04:08 +0200
Subject: [PATCH 4/4] net: macb: add gigabit implementation for fixed-link
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-net-macb-support-for-feature-lite-instances-v1-4-480e4cecac01@nanoxplore.com>
References: <20260428-net-macb-support-for-feature-lite-instances-v1-0-480e4cecac01@nanoxplore.com>
In-Reply-To: <20260428-net-macb-support-for-feature-lite-instances-v1-0-480e4cecac01@nanoxplore.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Christian DREHER <christian.dreher@nanoxplore.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777399485; l=2337;
 i=christian.dreher@nanoxplore.com; s=20260428; h=from:subject:message-id;
 bh=C5Nzv11Bwryz9D8hZGO5arZ3cYSEIEx4tJZcH1tjt9k=;
 b=jktcw76AUqrFYKKOIov1SKJ23gxal8xRE0YBkgG50FZIBR4mdRJZsK8jjIR2cQPFCWoh3Y3BN
 o5eaMDjjG9MDcqWV8tqYZEfo2cSU8lloghIB16pmZDz/Ik3W1TktCsG
X-Developer-Key: i=christian.dreher@nanoxplore.com; a=ed25519;
 pk=id7EcKmXLV2xNgNiCIcsPjkoMQHM/qxTYqEqMhidSAU=
X-Endpoint-Received: by B4 Relay for
 christian.dreher@nanoxplore.com/20260428 with auth_id=760
X-Original-From: Christian DREHER <christian.dreher@nanoxplore.com>
X-Mailman-Approved-At: Wed, 29 Apr 2026 00:48:15 +0200
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
Reply-To: christian.dreher@nanoxplore.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Christian DREHER <christian.dreher@nanoxplore.com>

A fixed gigabit link on a non-gigabit controller is only rejected
during PHY init (even though there is no PHY to init), because, on
device-tree parsing, the controller is not probed, and it is still
unknown whether it is gigabit-capable.

This code was only tested on emulator with a full-duplex RGMII
interface, but is expected to work in GMII or half-duplex as well.

Signed-off-by: Christian DREHER <christian.dreher@nanoxplore.com>
---
 drivers/net/macb.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/macb.c b/drivers/net/macb.c
index 5cc29ecb214..bea1dfed892 100644
--- a/drivers/net/macb.c
+++ b/drivers/net/macb.c
@@ -772,18 +772,40 @@ static int macb_phy_init(struct udevice *dev, const char *name)
 			lpa);
 	} else {
 		/* if macb port is a fixed link */
-		/* TODO : manage gigabit capable processors */
+		const char *human_readable_speed;
+
 		speed = macb->speed;
 		duplex = macb->duplex;
+		switch (speed) {
+		case 2:
+			human_readable_speed = "1000";
+			break;
+		case 1:
+			human_readable_speed = "100";
+			break;
+		case 0:
+			human_readable_speed = "10";
+			break;
+		default:
+			printf("%s: speed %d not supported\n", name, speed);
+			return -EINVAL;
+		}
 		printf("%s: link up, %sMbps %s-duplex\n",
 			name,
-			speed ? "100" : "10",
+			human_readable_speed,
 			duplex ? "full" : "half");
 	}
 
 	ncfgr = macb_readl(macb, NCFGR);
 	ncfgr &= ~(MACB_BIT(SPD) | MACB_BIT(FD) | GEM_BIT(GBE));
-	if (speed) {
+	if (speed == 2) {
+		if (!gem_is_gigabit_capable(macb)) {
+			printf("%s: is not gigabit Ethernet capable\n", name);
+			return -EINVAL;
+		}
+		ncfgr |= GEM_BIT(GBE);
+		ret = macb_linkspd_cb(dev, _1000BASET);
+	} else if (speed == 1) {
 		ncfgr |= MACB_BIT(SPD);
 		ret = macb_linkspd_cb(dev, _100BASET);
 	} else {
@@ -1329,7 +1351,9 @@ static int macb_eth_of_to_plat(struct udevice *dev)
 		macb->phy_addr = PHY_MAX_ADDR + 1;
 		macb->duplex = fdtdec_get_bool(blob, fl_node, "full-duplex");
 		speed_fdt = fdtdec_get_int(blob, fl_node, "speed", 0);
-		if (speed_fdt == 100) {
+		if (speed_fdt == 1000) {
+			macb->speed = 2;
+		} else if (speed_fdt == 100) {
 			macb->speed = 1;
 		} else if (speed_fdt == 10) {
 			macb->speed = 0;

-- 
2.47.3


