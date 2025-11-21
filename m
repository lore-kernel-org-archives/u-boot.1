Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F85DCFA468
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 08:20:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2332A8051F;
	Fri, 21 Nov 2025 09:20:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="mMMoZzYK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7F238051F; Fri, 21 Nov 2025 09:20:06 +0100 (CET)
Received: from mx-relay49-hz3.antispameurope.com
 (mx-relay49-hz3.antispameurope.com [94.100.134.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5723802C1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:20:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0413995d28=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate49-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=ddYQLhPLKZDQKYsUqB+8f0TM3kl2maKqLs8jyc6PrNU=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763713203;
 b=P/O3EsJnvcyvNNQYMHu4OBBojW2uthpXtrQryjuSXqH+6OG/03Px83A/6Lf6scoXemDZdETA
 r+bI4SXyGr6ipe8sk/rmfnpGqGjK69GKs3Tgsr2RiDjyRtRTwwSbESniB17px8RH0pLHkVYWhgs
 YM3h8zKgINbAkoaOVOQpWAoBfcA192yKvFCgQ2tPPhn/6aJ5c/Pa5bCYyCUQZRjmwK4KOrb8cQ3
 Ceti590JtPHSQiblaW2FR3nR4zfuA2eEieS5EdvYyv+rjOrmls6xyEcufswgOupLV4FNh3BL4KN
 gvIdCUqmyAzycEZkXKKxOAXP6Lo3nk63iH4b3zr5+8SNw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763713203;
 b=SxCpPCpzY8zESlIOXixpF7OmuX4gm3eC56IUl6aMyDBVFCQ0Ow5wj9VKd/AKns+7EeL4fIuK
 WPO7JZVRZnKn2S+HLhyN+8NAizko5I7I197/nP5J/XokAqzohF/EscLYflr5Wg7XrPQML3LtAYD
 2gG/QLvTTWCAtFYUAfsj3FicX3x6y130IOyoZbYo3B4AitQVO4WwSO8ta3g2fGcrE19o/3g58Xg
 /WZUzKJynukNqglaBEzTI347DO6ZrBm1ltVoFOPz3NvXrdsGN8nJS9lSwypAZDQLVurVfFal7MJ
 x0Mt60jG/NzteNSsVMgnPODqTDnn5/wZbOiyVs9E22kTg==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay49-hz3.antispameurope.com; Fri, 21 Nov 2025 09:20:03 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 82D875A0E0D;
 Fri, 21 Nov 2025 09:19:49 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH 1/2] net: phy: micrel_ksz90x1: disable asymmetric pause for
 KSZ9031
Date: Fri, 21 Nov 2025 09:18:06 +0100
Message-ID: <20251121081810.73852-2-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121081810.73852-1-Max.Merchel@ew.tq-group.com>
References: <20251121081810.73852-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay49-hz3.antispameurope.com with 4dCSnL0gFLz3ybgM
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 0fe361ff3a0e5b9f53b6bdf65a03e119
X-cloud-security: scantime:1.857
DKIM-Signature: a=rsa-sha256;
 bh=ddYQLhPLKZDQKYsUqB+8f0TM3kl2maKqLs8jyc6PrNU=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763713203; v=1;
 b=mMMoZzYKm4dWAgBnszpHa3ohuv4VfitaYHFKDYODPUiXameH1DOufWK4jixJh9liebjz16TV
 aJIJFRmNuA11HrCj/nhWOe4/WqsgCGWio+TAax9z+HVtNedBFFLG0dRJxGqonxGmXgf7aYss+lT
 ZQiLo87gkT0VODJCGzH437sLp4OJ3s267CD8d11I8FAWasWId7449FubeV4dQMb/DClSDYLzMTt
 cezhpDlIvcWn2mJkLdW3kFBvyorKdzKW4yYd2kIhuirPqpY/kQnYw6FDBidm2/rBQXero4bZrJg
 b4GBRxGD3+wvXov/EDB3eRmpM0lz7el1bQ++jaeHExr/Q==
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

Disable the support due to chip errata and call genphy_config_aneg
instead of genphy_config. For a complete describtion look at the
errata sheets: DS80000691D or DS80000692D.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 drivers/net/phy/micrel_ksz90x1.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz90x1.c
index a02dbe900b8..bc42506c65e 100644
--- a/drivers/net/phy/micrel_ksz90x1.c
+++ b/drivers/net/phy/micrel_ksz90x1.c
@@ -336,6 +336,7 @@ static int ksz9031_phy_extwrite(struct phy_device *phydev, int addr,
 
 static int ksz9031_config(struct phy_device *phydev)
 {
+	unsigned int features = phydev->drv->features;
 	int ret;
 
 	ret = ksz9031_of_config(phydev);
@@ -371,7 +372,22 @@ static int ksz9031_config(struct phy_device *phydev)
 		return 0;
 	}
 
-	return genphy_config(phydev);
+	/* Silicon Errata Sheet (DS80000691D or DS80000692D):
+	 * Whenever the device's Asymmetric Pause capability is set to 1,
+	 * link-up may fail after a link-up to link-down transition.
+	 *
+	 * Workaround:
+	 * Do not enable the Asymmetric Pause capability bit.
+	 */
+	features &= ~ADVERTISE_PAUSE_ASYM;
+	/* update feature support and forward to advertised features */
+	phydev->supported = features;
+	phydev->advertising = phydev->supported;
+
+	/* genphy_restart_aneg called from genphy_config_aneg */
+	return genphy_config_aneg(phydev);
+
+	return 0;
 }
 
 U_BOOT_PHY_DRIVER(ksz9031) = {
-- 
2.43.0

