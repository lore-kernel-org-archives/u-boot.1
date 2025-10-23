Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659B4CCD193
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 22:41:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9593D8006D;
	Fri, 24 Oct 2025 00:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="W+0uZww6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="E8VrmNtA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1A20807C0; Fri, 24 Oct 2025 00:41:53 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6037F8003E
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 00:41:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ct1HM0lDzz9skc;
 Fri, 24 Oct 2025 00:41:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761259311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lJc07d/4O7oAiOAhSvT1BGHR/M5MMe/sYzABQuJYxgg=;
 b=W+0uZww6Izyh3yfG2HGxqu4jNwDlyxxyo9G/SmKFaDUywt+k+roaGggVZgMKBZfRuiJ33t
 3i76Hwo5HXutH1Jo4q1xfpXI0s6TmDryNa3FnfB9qc2C7Nmp56iMnDDCvS/fsRfi+NZUR3
 HjuzYOBA5bYwcZ3EFjyEmANvMgfjIkz59Nj/GvIFi1djWEN3zj2LnxwkCmjgkVn6XgNCdm
 cOCTQPSaU+eBFIW1c1xGc3kqNf8snSOPb+gNizAdT2cxC4seUbBIvkxFml/DShUeemMBGH
 ptstIg+qbirYnuFIIKUOD3Q4/0ucAu9CfbBchFDWmAWXmk7sGoY77GPZvlG4Gw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=E8VrmNtA;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761259309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lJc07d/4O7oAiOAhSvT1BGHR/M5MMe/sYzABQuJYxgg=;
 b=E8VrmNtAmND81LwBXoOf1HXwehUM7TAFRr6xxvMMIIFiViMHM9QIr3H/5hWqJYX8LiWFnD
 WIDlU+IwOoCwhvh19ZXoWqvqata0BVllH+qaYR2U6BnwIMflhtVIEs2idO/X5p651f8Nbs
 nOHEhKFZ15UiqlZI7mWlVTytTiWxrBsyMu9aJO9aNOqSgdOWW4LhhdkGCjTSVmhTXYawsm
 3F/V/H8gPYJ848A5HzXcL0sSJ6HYszYitOHt9F5ibFYKfBmHHGEJ7qQ6FypGdkQADFjMV9
 gmTvsL6VaF+Us5cdUxQWyzR+BNXQu9WlSXy7Q80ZGeOHc9NYtz3fVGf1gAkQLQ==
To: u-boot@lists.denx.de
Cc: Thanh Quan <thanh.quan.xn@renesas.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dominic Rath <rath@ibv-augsburg.net>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: phy: dp83869: Update STRAP_OPMODE bitmask
Date: Fri, 24 Oct 2025 00:41:27 +0200
Message-ID: <20251023224136.193007-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4edd16012a4dd2f86e9
X-MBO-RS-META: fpxshye4h1xetbwmpg697h58z54wf83i
X-Rspamd-Queue-Id: 4ct1HM0lDzz9skc
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

From: Thanh Quan <thanh.quan.xn@renesas.com>

According to the TI DP83869HM datasheet Revision D (June 2025), section
7.6.1.41 STRAP_STS Register, the STRAP_OPMODE bitmask is bit [11:9].
Fix this.

Fixes: f3e22eea815d ("net: phy: add TI DP83869HM ethernet driver")
Signed-off-by: Thanh Quan <thanh.quan.xn@renesas.com>
Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # Use FIELD_GET()
---
Cc: Dominic Rath <rath@ibv-augsburg.net>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Thanh Quan <thanh.quan.xn@renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/phy/dp83869.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index b6fb5adae1f..c60fbf26a03 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -5,6 +5,7 @@
  */
 
 #include <phy.h>
+#include <linux/bitfield.h>
 #include <linux/compat.h>
 #include <malloc.h>
 
@@ -64,7 +65,7 @@
 #define DP83869_RGMII_RX_CLK_DELAY_EN		BIT(0)
 
 /* STRAP_STS1 bits */
-#define DP83869_STRAP_OP_MODE_MASK		GENMASK(2, 0)
+#define DP83869_STRAP_OP_MODE_MASK		GENMASK(11, 9)
 #define DP83869_STRAP_STS1_RESERVED		BIT(11)
 #define DP83869_STRAP_MIRROR_ENABLED		BIT(12)
 
@@ -168,7 +169,7 @@ static int dp83869_set_strapped_mode(struct phy_device *phydev)
 	if (val < 0)
 		return val;
 
-	dp83869->mode = val & DP83869_STRAP_OP_MODE_MASK;
+	dp83869->mode = FIELD_GET(DP83869_STRAP_OP_MODE_MASK, val);
 
 	return 0;
 }
-- 
2.51.0

