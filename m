Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B82CA0EFA
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 13:09:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C480F83145;
	Tue, 26 Aug 2025 15:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="Ozi/72YZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32E4F830B4; Tue, 26 Aug 2025 11:39:46 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27C6782FC7
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 11:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3ABFE101DF6; Tue, 26 Aug 2025 11:39:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1756201183; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=lI9N2nXRzkrkVbh2GIepAy0EQvj+RGxsjGQtpsr5CiQ=;
 b=Ozi/72YZhtcmvuV4B+OuvrekAr43kxKOVwlTrMnMYGCM8dnOt825llMMVBl/p+1hEsrTEk
 XzxGKKJGv7VYV3dapI8/UI/SeeU1P2OauqnKteiSle4G+mOBRiRt8CDYPXP4T8n2XHHOa2
 kUUHXXngA0WShsfE8XmU93VZZCxxloGL9C2oxu+8H5f2PF+RdB+b5ZYwiprzxivGYWstZV
 9oLhdRfILJ/u6S3QuGTJ2MM+d6hdn/Q2s6MbG0rIr+27WGH9lKK13ebtRAt6cOo7jifQPz
 b0Owc91DXWof0Z12z5hlPlqLAkUcqcydLnXOjCeIk3t+D3Tztzvz+T0zS6hJpQ==
From: Lukasz Majewski <lukma@nabladev.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@nabladev.com>
Subject: [PATCH 1/2] timer: tegra: Bind watchdog driver when timer node is
 processed
Date: Tue, 26 Aug 2025 11:39:35 +0200
Message-Id: <20250826093936.3521235-1-lukma@nabladev.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 26 Aug 2025 15:08:40 +0200
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

The Tegra30 SoC is a bit special, as it doesn't have the separate IP block
to provide watchdog functionality.

Instead, timer IP block allows such functionality when properly configured.

As in the tegra30.dtsi there is a timer node, which "covers" all timers,
with 'nvidia,tegra30-timer' compatibility it was necessary to manually
bind U-Boot's WDT driver (based on WDT_UCLASS).

Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
---
 drivers/timer/tegra-timer.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/timer/tegra-timer.c b/drivers/timer/tegra-timer.c
index 3545424889d..361539efa43 100644
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
+	 * In Tegra 30 SoC the Watchdog is accomplished
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

