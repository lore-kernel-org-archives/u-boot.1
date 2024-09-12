Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43AEEE57F8
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 13:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1761E88FB9;
	Thu, 12 Sep 2024 15:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=motor-comm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F241A88F4B; Thu, 12 Sep 2024 14:02:43 +0200 (CEST)
Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com
 [115.124.28.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 528A188F96
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 14:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=motor-comm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Frank.Sae@motor-comm.com
Received: from ubuntu.localdomain(mailfrom:Frank.Sae@motor-comm.com
 fp:SMTPD_---.ZHPh8f2_1726142554) by smtp.aliyun-inc.com;
 Thu, 12 Sep 2024 20:02:37 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 trini@konsulko.com, Frank.Sae@motor-comm.com, ycliang@andestech.com,
 tekieli.lukasz@gmail.com, frattaroli.nicolas@gmail.com
Cc: yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
 xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com,
 jie.han@motor-comm.com
Subject: [PATCH v1 1/2] net: phy: motorcomm: Optimize phy speed mask to be
 compatible to YT8821
Date: Thu, 12 Sep 2024 05:02:24 -0700
Message-Id: <20240912120225.28884-2-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912120225.28884-1-Frank.Sae@motor-comm.com>
References: <20240912120225.28884-1-Frank.Sae@motor-comm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Sep 2024 15:11:43 +0200
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

YT8531 as Gigabit transceiver uses bit15:14(bit9 reserved default 0) as phy
speed mask, YT8821 as 2.5 Gigabit transceiver uses bit9 bit15:14 as phy
speed mask.

Be compatible to YT8821, reform phy speed mask and phy speed macro.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 drivers/net/phy/motorcomm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index a96430cec4..070de0645d 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -102,8 +102,10 @@
 #define YTPHY_SPECIFIC_STATUS_REG		0x11
 #define YTPHY_DUPLEX_MASK			BIT(13)
 #define YTPHY_DUPLEX_SHIFT			13
-#define YTPHY_SPEED_MODE_MASK			GENMASK(15, 14)
-#define YTPHY_SPEED_MODE_SHIFT			14
+#define YTPHY_SPEED_MASK			((0x3 << 14) | BIT(9))
+#define YTPHY_SPEED_10M				((0x0 << 14))
+#define YTPHY_SPEED_100M			((0x1 << 14))
+#define YTPHY_SPEED_1000M			((0x2 << 14))
 
 #define YT8531_EXTREG_SLEEP_CONTROL1_REG	0x27
 #define YT8531_ESC1R_SLEEP_SW			BIT(15)
@@ -295,15 +297,15 @@ static int yt8531_parse_status(struct phy_device *phydev)
 	if (val < 0)
 		return val;
 
-	speed_mode = (val & YTPHY_SPEED_MODE_MASK) >> YTPHY_SPEED_MODE_SHIFT;
+	speed_mode = (val & YTPHY_SPEED_MASK);
 	switch (speed_mode) {
-	case 2:
+	case YTPHY_SPEED_1000M:
 		speed = SPEED_1000;
 		break;
-	case 1:
+	case YTPHY_SPEED_100M:
 		speed = SPEED_100;
 		break;
-	default:
+	case YTPHY_SPEED_10M:
 		speed = SPEED_10;
 		break;
 	}
-- 
2.34.1

