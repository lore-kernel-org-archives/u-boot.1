Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BE6CD98F3
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 04:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F1CC86C79;
	Wed, 11 Oct 2023 06:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Z/xXyEWt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F40986B6D; Wed, 11 Oct 2023 06:49:30 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0348E86BF2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 06:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1BC1B3F719; 
 Wed, 11 Oct 2023 04:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1696999716;
 bh=jFtBm+84JD7K1h8jDbUGtLX5ZaBRnb6u3xN8953P6eU=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=Z/xXyEWtccUEWA4Fic9fW8h3eGxbmb/pC3EjaTrsh8UlEzH/5gyTUWRYa0IDNTFNT
 gCIpgyVx+RYsQ4E4XizupQ7uGb8YkCeMUUKb+haio5x3OFOMxcXGEHNsUz5HyZzE5y
 UKoX40tsEJ9xUrRtbHRpTwq0btm0aD2/2+tQlUesOgnvsHHlzhUfAqZJoDZ7sqhEgN
 moBn4/K75WiOreQD7br+MQdXc3huXVde8HuM2ii+r+vBLuqGiwlpYCdIzOQdEisrM0
 aI7dG8zm2stOCiGXjZKS6HIcGx9cgincipUVSrHOQFbesOt68Kgh0fkaVWYYr5a7L0
 eAh+bz72Nlunw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Heiko Schocher <hs@denx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] i2c: designware_i2c: adjust timing calculation
Date: Wed, 11 Oct 2023 06:48:13 +0200
Message-Id: <20231011044813.122941-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

In SPL probing of the designware_i2c device on the StarFive VisionFive 2
board fails with

    dw_i2c: mode 0, ic_clk 1000000, speed 100000,
    period 10 rise 1 fall 1 tlow 5 thigh 4 spk 0
    dw_i2c: bad counts. hcnt = -4 lcnt = 4
    device_probe: i2c@12050000 failed to probe -22

When changing the offset for the high phase from 7 to 1 the device is
probed correctly.

Without this fix the memory size of the StarFive VisionFive 2 board cannot
be read from EEPROM.

Fixes: e71b6f6622d6 ("i2c: designware_i2c: Rewrite timing calculation")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/i2c/designware_i2c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/designware_i2c.c b/drivers/i2c/designware_i2c.c
index e54de42abc..55e582091c 100644
--- a/drivers/i2c/designware_i2c.c
+++ b/drivers/i2c/designware_i2c.c
@@ -155,10 +155,10 @@ static int dw_i2c_calc_timing(struct dw_i2c *priv, enum i2c_speed_mode mode,
 
 	/*
 	 * Back-solve for hcnt and lcnt according to the following equations:
-	 * SCL_High_time = [(HCNT + IC_*_SPKLEN + 7) * ic_clk] + SCL_Fall_time
+	 * SCL_High_time = [(HCNT + IC_*_SPKLEN + 1) * ic_clk] + SCL_Fall_time
 	 * SCL_Low_time = [(LCNT + 1) * ic_clk] - SCL_Fall_time + SCL_Rise_time
 	 */
-	hcnt = min_thigh_cnt - fall_cnt - 7 - spk_cnt;
+	hcnt = min_thigh_cnt - fall_cnt - 1 - spk_cnt;
 	lcnt = min_tlow_cnt - rise_cnt + fall_cnt - 1;
 
 	if (hcnt < 0 || lcnt < 0) {
@@ -170,13 +170,13 @@ static int dw_i2c_calc_timing(struct dw_i2c *priv, enum i2c_speed_mode mode,
 	 * Now add things back up to ensure the period is hit. If it is off,
 	 * split the difference and bias to lcnt for remainder
 	 */
-	tot = hcnt + lcnt + 7 + spk_cnt + rise_cnt + 1;
+	tot = hcnt + lcnt + 1 + spk_cnt + rise_cnt + 1;
 
 	if (tot < period_cnt) {
 		diff = (period_cnt - tot) / 2;
 		hcnt += diff;
 		lcnt += diff;
-		tot = hcnt + lcnt + 7 + spk_cnt + rise_cnt + 1;
+		tot = hcnt + lcnt + 1 + spk_cnt + rise_cnt + 1;
 		lcnt += period_cnt - tot;
 	}
 
-- 
2.40.1

