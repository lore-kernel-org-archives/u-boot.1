Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95B2E66882
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9FF6893EB;
	Sat, 23 Nov 2024 22:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="d69fRSpK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C8EF893F6; Sat, 23 Nov 2024 22:46:50 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D93D89160
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 22:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 5FF6C4100E; 
 Sat, 23 Nov 2024 21:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732398403;
 bh=GdRyiFP1UjioHGxoQKGd8qxkiVYVx4ZXcohBnyv9ggo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=d69fRSpKmxbMyiaLtA9jvQ8tO1C0Kq9WAIUuTxhclIGsXYBxXYS/Nn5kwuFwFUE4R
 BLnv4LecjlRImd17sQzCtfgHrJG1hQc45c9/5bPdYA/uT8rOR1/j07FxXzBGKOj2RC
 1cVDdqGZ4ojfgoSRLr22Yhf7JEgCZpGHaRssGvWBswr2VbspfQKmEASpuvZc2Q0Lxo
 LXzcy5vVqhMWBLRIIcZjKK+7/8T0wFJ4/4J6g87SMBaBV0c5iDTsci/u4z/lBE7DE5
 zP+mVibTtmrEWdc5CqNmMpulOVvkrgTlfDbgFcEvFPaaH6qinn3sud1uBbm+LP/R0t
 dA9Vx46C7lvqQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 4/6] net: eth_bootdev_hunt() must not try to boot
Date: Sat, 23 Nov 2024 22:45:52 +0100
Message-ID: <20241123214554.305285-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
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

eth_bootdev_hunt() should not execute dhcp_run() as this itself would load
a file and boot it if autostart=yes.

Instead just check that there is a network device.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 net/eth_bootdev.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/net/eth_bootdev.c b/net/eth_bootdev.c
index 6ee54e3c790..b0fca6e8313 100644
--- a/net/eth_bootdev.c
+++ b/net/eth_bootdev.c
@@ -64,9 +64,23 @@ static int eth_bootdev_bind(struct udevice *dev)
 	return 0;
 }
 
+/**
+ * eth_bootdev_hunt() - probe all network devices
+ *
+ * Network devices can also come from USB, but that is a higher
+ * priority (BOOTDEVP_5_SCAN_SLOW) than network, so it should have been
+ * enumerated already. If something like 'bootflow scan dhcp' is used,
+ * then the user will need to run 'usb start' first.
+ *
+ * @info:	info structure describing this hunter
+ * @show:	true to show information from the hunter
+ *
+ * Return:	0 if device found, -EINVAL otherwise
+ */
 static int eth_bootdev_hunt(struct bootdev_hunter *info, bool show)
 {
 	int ret;
+	struct udevice *dev = NULL;
 
 	if (!test_eth_enabled())
 		return 0;
@@ -78,19 +92,11 @@ static int eth_bootdev_hunt(struct bootdev_hunter *info, bool show)
 			log_warning("Failed to init PCI (%dE)\n", ret);
 	}
 
-	/*
-	 * Ethernet devices can also come from USB, but that is a higher
-	 * priority (BOOTDEVP_5_SCAN_SLOW) than ethernet, so it should have been
-	 * enumerated already. If something like 'bootflow scan dhcp' is used
-	 * then the user will need to run 'usb start' first.
-	 */
-	if (IS_ENABLED(CONFIG_CMD_DHCP)) {
-		ret = dhcp_run(0, NULL, false);
-		if (ret)
-			return -EINVAL;
-	}
+	ret = -EINVAL;
+	uclass_foreach_dev_probe(UCLASS_ETH, dev)
+		ret = 0;
 
-	return 0;
+	return ret;
 }
 
 struct bootdev_ops eth_bootdev_ops = {
-- 
2.45.2

