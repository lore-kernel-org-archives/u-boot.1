Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644E7D6408A
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 21:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6C7489287;
	Fri,  8 Nov 2024 22:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="VSb2jM5k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1338D8929D; Fri,  8 Nov 2024 22:16:38 +0100 (CET)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BB598925A
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 22:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20241108211635df5fffc043a8940edf for <u-boot@lists.denx.de>;
 Fri, 08 Nov 2024 22:16:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=de5wYVvrzR5Prq6lPsQzd75KYBbbKcuS2ZFZuIpnowY=;
 b=VSb2jM5kqlHSpAu+sm470dB7JsRnVRm5492bIwuVp9hzI0FnHcDM5f9vaR7v1e7J7tt4fY
 qRwYnYgRELUb+SmbXrgZ6NxkVU/ADmr5FjlciNYYNp5oz5Q9pGUtQ8pTMqNX8Bb8bKGzlBGY
 ZVLkDHg0faUD8yJsDEduL+4JuSECwX9YFXg7zX27wXvrA+9tICILua8HjoDU9Ze7idN5ZKBu
 Tovrhcd82xWMDgOu+Sd0CuxDK+J/yxLW0Dm8FlemHk953uITvyy2UdJ7HSJckqTzn+l+nzWw
 dLiJ/ygPOLctHUxJyLCm3e+m0LzsrvI1HBaJ4/FXaUpRZgJXUqYXORWw==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Stefan Roese <sr@denx.de>, Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] watchdog: rti: support SPL (or re-start)
Date: Fri,  8 Nov 2024 22:15:03 +0100
Message-ID: <20241108211506.1348528-1-alexander.sverdlin@siemens.com>
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

If the RTI watchdog has been enabled in SPL, enabling it in U-Boot proper
fails because it can only be enabled once in HW and never stopped. This
however leads to a situation that wdt_cyclic() watchdog trigger is not
being started any longer and the WDT fires at some point.

Allow for WDT re-start by not bailing out if the [previously] configured
period matches the one to be configured.

Enabling in [A53] SPL has been tested on AM62x-based HW (where [A53] SPL is
responsible for loading R5 DM firmware and not this driver).

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/watchdog/rti_wdt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index 99168d0cad03..320c5ca19e0a 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -131,18 +131,19 @@ static int rti_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 	u32 timer_margin;
 	int ret;
 
-	if (readl(priv->regs + RTIDWDCTRL) == WDENABLE_KEY)
+	timer_margin = timeout_ms * priv->clk_hz / 1000;
+	timer_margin >>= WDT_PRELOAD_SHIFT;
+	if (timer_margin > WDT_PRELOAD_MAX)
+		timer_margin = WDT_PRELOAD_MAX;
+
+	if (readl(priv->regs + RTIDWDCTRL) == WDENABLE_KEY &&
+	    readl(priv->regs + RTIDWDPRLD) != timer_margin)
 		return -EBUSY;
 
 	ret = rti_wdt_load_fw(dev);
 	if (ret < 0)
 		return ret;
 
-	timer_margin = timeout_ms * priv->clk_hz / 1000;
-	timer_margin >>= WDT_PRELOAD_SHIFT;
-	if (timer_margin > WDT_PRELOAD_MAX)
-		timer_margin = WDT_PRELOAD_MAX;
-
 	writel(timer_margin, priv->regs + RTIDWDPRLD);
 	writel(RTIWWDRX_NMI, priv->regs + RTIWWDRXCTRL);
 	writel(RTIWWDSIZE_50P, priv->regs + RTIWWDSIZECTRL);
-- 
2.47.0

