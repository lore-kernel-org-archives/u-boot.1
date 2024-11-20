Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5F2D743E8
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 22:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6530D8914F;
	Wed, 20 Nov 2024 23:25:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="JkM8fEp1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 301AC891F5; Wed, 20 Nov 2024 23:25:39 +0100 (CET)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 168CA88F3C
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 23:25:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20241120222536bc2fa7fb6fea82e809 for <u-boot@lists.denx.de>;
 Wed, 20 Nov 2024 23:25:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=rU2kW3sWlqVDT5YdkLvTulVrz2BgHZNu2HkaxqBP11o=;
 b=JkM8fEp1e8LSOaqtI5xkmU4Dimv0Xx9dWRL/OdmDWMVjtqCIppdtH0cs72ESTyyWo6NG6U
 4WupxOjCdZOyD0lwnhuWDLzz6M4PQHpf5ClztmGCaW121gAnoudCv4yHORwM5opm05+E/uxq
 d0WJ2KTwb2TomKniJ1Zus3Ar4+5Fa6U3jaWxlEOTbFwurLbaSXsDEXSH1+mI1LdJVmeCDpxl
 4BrgLDui5RaCL/bVlbQrQufICs+VxrQWw/XXi6gtzsSzghHgKb8MYBXvVuMD5TtIhy0YUkZc
 L6jnTFETZQ/E1J0eqN5PRcLfcH6UTBM3aKpvcbM/q2xd+A+wEEwZ2gsA==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Stefan Roese <sr@denx.de>, Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] watchdog: rti: drop hack manipulating WDT clock rate
Date: Wed, 20 Nov 2024 23:24:10 +0100
Message-ID: <20241120222412.1873381-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

The hack itself seems to be copied from Linux rti_wdt.c, but the WDT reset
principle is different in U-Boot. While Linux relies on correct frequencies
and timers and doesn't check the actual WDT counter value U-Boot driver
seems to be more rubust: it does compare RTIDWDCNTR vs RTIDWDPRLD.

Now the root cause of the original motivation to manipulate the clock rate
is said to be understood and fixed in Linux commit cae58516534e
("watchdog: rti_wdt: Set min_hw_heartbeat_ms to accommodate a safety margin")
which simultaneously removed the hack itself.

While is fix part of the mentioned patch is neither applicable nor requied
for the U-Boot driver just drop the hack setting WDT clock rate to 90% of
the real rate. This has a nice effect that the WDT timeout is now as
requested and not 10% shorter.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/watchdog/rti_wdt.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index 99168d0cad03..f806e24e53da 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -186,14 +186,6 @@ static int rti_wdt_probe(struct udevice *dev)
 
 	priv->clk_hz = clk_get_rate(&clk);
 
-	/*
-	 * If watchdog is running at 32k clock, it is not accurate.
-	 * Adjust frequency down in this case so that it does not expire
-	 * earlier than expected.
-	 */
-	if (priv->clk_hz < 32768)
-		priv->clk_hz = priv->clk_hz * 9 / 10;
-
 	return 0;
 }
 
-- 
2.47.0

