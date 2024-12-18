Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DC1E77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 17:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4CB180274;
	Wed, 18 Dec 2024 18:36:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W+EejhDh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF182802B4; Wed, 18 Dec 2024 18:12:40 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A14E880241
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-ramamoorthy@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BIHCaPs107198;
 Wed, 18 Dec 2024 11:12:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734541957;
 bh=GWnbQEPx1Q0VXoZgZuaCHLjFgSvQKssc9MnFlagcU6o=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=W+EejhDhK6nhzv3qXD+3tIRXYKBFp0wZybGrlXS+tVNOUQ4iXsvh0tB+URZ1glreY
 ZvG1wv2hKLW15yAbBf2oSLOOQI3CepFtOwBTweAZtQ1kEylMHJuGj8Rfx+FyBXBoUf
 zsnJbz6iA4IuRl/nG48hPZRk8cw+Ke8cUFYz1Hg0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BIHCanI010549
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 18 Dec 2024 11:12:36 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 11:12:36 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 11:12:36 -0600
Received: from DMZ007XYY.dhcp.ti.com (dmz007xyy.dhcp.ti.com [128.247.29.8])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BIHCaRY112285;
 Wed, 18 Dec 2024 11:12:36 -0600
From: Shree Ramamoorthy <s-ramamoorthy@ti.com>
To: <u-boot@lists.denx.de>, <jh80.chung@samsung.com>, <trini@konsulko.com>
CC: <m-leonard@ti.com>, <praneeth@ti.com>
Subject: [PATCH v1 1/2] power: regulator: replace printf() with pr_err()
Date: Wed, 18 Dec 2024 11:12:35 -0600
Message-ID: <20241218171236.1022565-2-s-ramamoorthy@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218171236.1022565-1-s-ramamoorthy@ti.com>
References: <20241218171236.1022565-1-s-ramamoorthy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Wed, 18 Dec 2024 18:36:03 +0100
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

Replace printf() with pr_err() because pr_err() has a uniform print format
and takes into consideration the log levels supported.

Signed-off-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>
---
 drivers/power/regulator/tps65219_regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/regulator/tps65219_regulator.c b/drivers/power/regulator/tps65219_regulator.c
index b7124fed0245..4b0fb205909a 100644
--- a/drivers/power/regulator/tps65219_regulator.c
+++ b/drivers/power/regulator/tps65219_regulator.c
@@ -250,7 +250,7 @@ static int tps65219_ldo_probe(struct udevice *dev)
 	/* idx must be in 1..TPS65219_LDO_NUM */
 	idx = dev->driver_data;
 	if (idx < 1 || idx > TPS65219_LDO_NUM) {
-		printf("Wrong ID for regulator\n");
+		pr_err("Wrong ID for regulator\n");
 		return -EINVAL;
 	}
 
@@ -271,7 +271,7 @@ static int tps65219_buck_probe(struct udevice *dev)
 	/* idx must be in 1..TPS65219_BUCK_NUM */
 	idx = dev->driver_data;
 	if (idx < 1 || idx > TPS65219_BUCK_NUM) {
-		printf("Wrong ID for regulator\n");
+		pr_err("Wrong ID for regulator\n");
 		return -EINVAL;
 	}
 
-- 
2.34.1

