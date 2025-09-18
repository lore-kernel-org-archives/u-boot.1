Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FC8CAC59F
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 08:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 531A880B9B;
	Thu, 18 Sep 2025 10:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="QIhClHWC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B64C8309A; Thu, 18 Sep 2025 10:44:45 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3082680107
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 10:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A5D64101961; Thu, 18 Sep 2025 10:44:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1758185081; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=xXniPkk0IMpZ9e5S1EKW3C0FFeiETQSplJXQJ3Hyr1s=;
 b=QIhClHWC0V8/NH6r95PE6F1Ry96s8wZu3GWUJh5H5m17/KY+gsHV8c2QbE63xdk+awg6Ex
 J41LDJpJ2yNOI9j+2wcbPhzdUNIo26bsUqCsRZIr95FBr4Pevai8iQpWt1N7AMXihe++nO
 Zn/Nh4LqEnFW3rrd51s2R1RKtOK3fbIC8oEEGQAzIGGhLJvq6GgAR/pr+d73RjbdYxrTsR
 K7P4i+O22v35UnA1BccjGsUy2tX8nxKagYqf1WLWhkqDE76Jspn/w5VpolVhjUWfUmBL9I
 66xu97ktP7XjVjn65ZQKHmcHaYK6StjXU0NlZZ4YBiaXuifkX+18gHBS/OL0Qw==
From: Lukasz Majewski <lukma@nabladev.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stephen Warren <swarren@nvidia.com>, Lukasz Majewski <lukma@nabladev.com>
Subject: [PATCH v2 1/2] timer: tegra: Bind watchdog driver when timer node is
 processed
Date: Thu, 18 Sep 2025 10:42:06 +0200
Message-Id: <20250918084207.3862049-1-lukma@nabladev.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The Tegra SoC is a bit special, as it doesn't have the separate IP block
to provide watchdog functionality.

Instead, timer IP block allows such functionality when properly configured.

This patch manually binds U-Boot's WDT driver (based on WDT_UCLASS).

Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
---

Changes for v2:
- Replace "Tegra T30" with just "Tegra" in comment as all Tegra
  SoCs are using the same programming paradign
- Update the commit message
---
 drivers/timer/tegra-timer.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/timer/tegra-timer.c b/drivers/timer/tegra-timer.c
index 3545424889d..0d78000a989 100644
--- a/drivers/timer/tegra-timer.c
+++ b/drivers/timer/tegra-timer.c
@@ -11,6 +11,8 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/tegra.h>
 
+#include <dm/lists.h>
+
 #define TEGRA_OSC_CLK_ENB_L_SET		(NV_PA_CLK_RST_BASE + 0x320)
 #define TEGRA_OSC_SET_CLK_ENB_TMR	BIT(5)
 
@@ -106,6 +108,21 @@ static int tegra_timer_probe(struct udevice *dev)
 	return 0;
 }
 
+static int tegra_timer_bind(struct udevice *dev)
+{
+	/*
+	 * In Tegra SoC the Watchdog is accomplished
+	 * by the timer IP block (timer5).
+	 */
+	if (CONFIG_IS_ENABLED(WDT_TEGRA))
+		return device_bind_driver_to_node(dev, "tegra_wdt",
+						  "tegra-wdt",
+						  dev_ofnode(dev),
+						  NULL);
+
+	return 0;
+}
+
 static const struct timer_ops tegra_timer_ops = {
 	.get_count = tegra_timer_get_count,
 };
@@ -124,6 +141,7 @@ U_BOOT_DRIVER(tegra_timer) = {
 	.id		= UCLASS_TIMER,
 	.of_match	= tegra_timer_ids,
 	.probe		= tegra_timer_probe,
+	.bind		= tegra_timer_bind,
 	.ops		= &tegra_timer_ops,
 	.flags		= DM_FLAG_PRE_RELOC,
 };
-- 
2.39.5

