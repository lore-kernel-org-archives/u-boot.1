Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637BCD75BCE
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 08:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5AEC89670;
	Thu, 21 Nov 2024 09:04:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="LC+0ITtL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88BD989677; Thu, 21 Nov 2024 09:04:53 +0100 (CET)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D9DE88E33
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 09:04:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 202411210804508e61e615525bc62ec8 for <u-boot@lists.denx.de>;
 Thu, 21 Nov 2024 09:04:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=IFP+qbLzxdJ59tdxCIjLVGDeQK/zZ2KZRyS/rHSaUBU=;
 b=LC+0ITtLr04HmVOSjpzNdN6/sNn308i3P7vZFtNsLZxynWSlCncdFPgUB7DvmiI0L308Yu
 gz6F0aZMKiddWlXHhrvQVZS2s6fmSVHvC/tfgULc+wGffu8914EmaJR0Yyd02+76EP7SPdyN
 M4D62D0S932KvS+Vafp6MPsnFhWRZGWqY7hZ82AQanJXDCGOgafYKs80M37hbNVG4U/fo3kN
 2FAz1thhVBkJwjFmvwlOJ9VRdglUVk+1avX28UVf60bpDUzBau03zyh2ebRc75f7e80ZOKb6
 fMoCj/ldlv1Kui4mDg4I55oH0ioEtEBTzy6Hs3EvioXTeHhfmz/d85gQ==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Stefan Roese <sr@denx.de>, Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] watchdog: rti: drop hack manipulating WDT clock rate
Date: Thu, 21 Nov 2024 09:03:25 +0100
Message-ID: <20241121080326.1913067-1-alexander.sverdlin@siemens.com>
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
seems to be more robust: it does compare RTIDWDCNTR vs RTIDWDPRLD.

Now the root cause of the original motivation to manipulate the clock rate
is said to be understood and fixed in Linux commit cae58516534e
("watchdog: rti_wdt: Set min_hw_heartbeat_ms to accommodate a safety margin")
which simultaneously removed the hack itself.

While is fix part of the mentioned patch is neither applicable nor requried
for the U-Boot driver just drop the hack setting WDT clock rate to 90% of
the real rate. This has a nice effect that the WDT timeout is now as
requested and not 10% shorter.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
---
Changelog:
v2: 2 typos pointed by Jan corrected

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

