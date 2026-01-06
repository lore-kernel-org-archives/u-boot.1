Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE7DCEFD0C
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 21:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09BAC83D9F;
	Tue,  6 Jan 2026 22:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="XQKxmtto";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3478D83C4B; Tue,  6 Jan 2026 22:55:15 +0100 (CET)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com
 [91.218.175.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1F2083885
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 22:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1767736511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+/z/up3Q0ySdmqIK8IW9H0QLR60Z75GAjnLeHy06hM=;
 b=XQKxmtto6bAp1XgZLrDJy0FODHwR9hPRd94iJ6SpXRUBThQLYzQvyytnSzSxnQ6ThBkR7r
 rlM2n3QoX+DJz+S3lxC7RHgcBk9xy2197MKU6NgP3g0QKBpPJEtZ580+mTnVeeQh0IoJIz
 blmLg7ImqN1nbfc21EQWkO9jzZ3d22Y=
From: Sean Anderson <sean.anderson@linux.dev>
To: Michal Simek <michal.simek@amd.com>,
	u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Frantisek Bohacek <rutherther@ditigal.xyz>,
 Sean Anderson <sean.anderson@seco.com>, Vinod Koul <vkoul@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 1/4] phy: zynqmp: Allow variation in refclk rate
Date: Tue,  6 Jan 2026 16:54:58 -0500
Message-Id: <20260106215501.727524-2-sean.anderson@linux.dev>
In-Reply-To: <20260106215501.727524-1-sean.anderson@linux.dev>
References: <20260106215501.727524-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

From: Sean Anderson <sean.anderson@seco.com>

Due to limited available frequency ratios, the reference clock rate may
not be exactly the same as the required rate. Allow a small (100 ppm)
deviation.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Link: https://lore.kernel.org/r/20230711194542.898230-1-sean.anderson@seco.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[ Linux commit 76009ee76e05e30e29aade02e788aebe9ce9ffd2 ]
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/phy/phy-zynqmp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-zynqmp.c b/drivers/phy/phy-zynqmp.c
index 9649e660220..7151402666b 100644
--- a/drivers/phy/phy-zynqmp.c
+++ b/drivers/phy/phy-zynqmp.c
@@ -725,7 +725,10 @@ static int xpsgtr_get_ref_clocks(struct udevice *dev)
 		}
 
 		for (i = 0 ; i < ARRAY_SIZE(ssc_lookup); i++) {
-			if (rate == ssc_lookup[i].refclk_rate) {
+			/* Allow an error of 100 ppm */
+			unsigned long error = ssc_lookup[i].refclk_rate / 10000;
+
+			if (abs(rate - ssc_lookup[i].refclk_rate) < error) {
 				gtr_dev->refclk_sscs[refclk] = &ssc_lookup[i];
 				dev_dbg(dev, "Found rate %d\n", i);
 				break;
-- 
2.35.1.1320.gc452695387.dirty

