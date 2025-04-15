Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EA5C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 18:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F86F82B32;
	Tue, 15 Apr 2025 20:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="m5YnSTY8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4KvU2pLw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F41F8209C; Tue, 15 Apr 2025 17:04:23 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E488081F54
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 17:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martin.kaistra@linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1744729460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uCqKRkaL4/7CnQZ2/QtrPMTwKqUdlEzULqV4B2dU3vY=;
 b=m5YnSTY8iit1Inva8vHeMXovP6JSQuym9JpM5ihqZbH/ObTLZvFQvWxmyFOhfw8ajC/HY5
 INDmaqLxTkAt5BWft1gYgjX+syYuAzmYAWEQCeMe5QJeoUUzd4RjckMnb8JyYRvu4cTGlP
 bfXjLLKm1RjC7T34Gz0ChH4+aMzv5UAEAQ0cA4f2ctChkmU3PGfzp6wFQIXUN1qlkZuPDw
 UX9P3lPsxG4WNgJy4NcX+m1HdmN32sYeMvhpGdOwIavz0o60AQAIU79OZalNXuX/H0ZNkZ
 gUR8GIc41K/0Y10SAuKmrD2s2uebnkb2FHdncvj1X66/L2c6pvme2DqOveAeBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1744729460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uCqKRkaL4/7CnQZ2/QtrPMTwKqUdlEzULqV4B2dU3vY=;
 b=4KvU2pLwmlZyDpfHbdXL+6EyIy/6yY5LFsZTUjG/7caAmWrIyqNCvhlLkGVYHLN1bJ/+5r
 hS/gSAqj2FE/DmDQ==
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com,
	rfried.dev@gmail.com,
	michal.simek@amd.com
Subject: [PATCH] net: gem: ignore tx_clk if MII is used
Date: Tue, 15 Apr 2025 17:04:00 +0200
Message-Id: <20250415150400.136723-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 15 Apr 2025 20:16:52 +0200
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

If the MII interface is used, the PHY is the clock master, thus don't
set the clock rate. On Zynq-7000, this will prevent the following
error:
  zynq_gem ethernet@e000b000: failed to set tx clock rate 25000000

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/zynq_gem.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index 461805ae53f..703e22479d2 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -567,12 +567,14 @@ static int zynq_gem_init(struct udevice *dev)
 	}
 #endif
 
-	ret = clk_get_rate(&priv->tx_clk);
-	if (ret != clk_rate) {
-		ret = clk_set_rate(&priv->tx_clk, clk_rate);
-		if (IS_ERR_VALUE(ret)) {
-			dev_err(dev, "failed to set tx clock rate %ld\n", clk_rate);
-			return ret;
+	if (priv->interface != PHY_INTERFACE_MODE_MII) {
+		ret = clk_get_rate(&priv->tx_clk);
+		if (ret != clk_rate) {
+			ret = clk_set_rate(&priv->tx_clk, clk_rate);
+			if (IS_ERR_VALUE(ret)) {
+				dev_err(dev, "failed to set tx clock rate %ld\n", clk_rate);
+				return ret;
+			}
 		}
 	}
 
-- 
2.39.5

