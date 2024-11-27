Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B318D609A7
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 07:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5436089CDF;
	Wed, 27 Nov 2024 08:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="R0PSZaQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E3F189CDB; Wed, 27 Nov 2024 08:07:01 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05C1F89789
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 08:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E447F41026; 
 Wed, 27 Nov 2024 07:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732691206;
 bh=n2NDz1h1Ki2L4yClmszG9peszw3PLDqJE4/8HcpNG34=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=R0PSZaQnGq/kzIa9LQRfLx6yj52VI8Xn5GvULDti9xTEtambtbmKaLX1GxReC41y4
 cnAxUVXBV718whK6WriWb06vwFXTqj4faDNF1Ax13EfRtmOQMJE0K4Q6LNzqIiiZYS
 9p/e+lD9zzMM5KSeEHPULxr7vciZTGKjTsbjrWV/o4Qx2nAFywox6F1TedvAPn8mmn
 DMu2gyXMxDTr1vXvOHqcuryzzCIYR6/k05RD6lcb4SHfB4fzKbIrq1TyzOJBLUAQLc
 xtCRC0Xwjv34IH3O81L1aigeR7wuDSVEHmZpGD9WgzJ7ilVPIIAuqeUjSjcbwyYmk3
 bHKWhDwCaS+NQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 4/6] net: eth_bootdev_hunt() should not run DHCP
Date: Wed, 27 Nov 2024 08:06:29 +0100
Message-ID: <20241127070631.16412-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
References: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
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

Currently when booting dhcp_run() may be executed multiple times:
once in eth_bootdev_hunt() and once in the network booting bootmeth.

We need to call eth_bootdev_hunt() when setting up the EFI sub-system to
supply the simple network protocol. We don't need an IP address set up.

We can reduce the bootime by not executing dhcp_run() in
eth_bootdev_hunt().

Furthermore eth_bootdev_hunt() with autostart=yes leads on the legacy
network statck leads to downloading a file via TFTP and to booting the
downloaded file.

Instead of running dchp_run() just check that there is a network device
in eth_bootdev_hunt().

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	reword the commit message
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

