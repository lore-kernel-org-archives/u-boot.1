Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E91F327B0
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 08:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDDB68433B;
	Tue, 21 Apr 2026 10:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="H5I21wIX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D29D8436C; Tue, 21 Apr 2026 10:21:55 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0768F8431E
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 10:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jrx2+krcY3pjJfiysYpjNVP3qlzK2TFVFytUdA01ixeQkE5KgLd+INPqCxt2haFnHQb9yIkVHUQW6a+5mqnrH3iiylvmu60Y2AAoXHxuhQvH1o5EaxlrF9LwQ/r+yXR48MHIdSHYlyGF8egjVCXo4sC+0BM5wfmWDtJWIoNpioPHhyBaAqTyCM1v1yjE3uCH/HVZotFi7WZHswggwJx8uP6TljLAMjH2yd7fe0lfNInBCUjWLa/lYl7mNY+wqAzDTlIj665B0mUU1I4siAO9r7Fn8ft27ax54ezzWq3DioWOlEu+tiHHHDE6nhsspAwqD0h4fNORKkM9Efib1fAV0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRj/jIZ6SzgIVAjjdbEqk2kUds1n57mWNfX96XDKHco=;
 b=WWXS+5mgk3ylTkz/FY6qwvkBNjjPo6ZY0yT9sdHfQD5Kv3NqePr8wIXBwt7ivB2vCDS5lNRtKr8B9dN2IC6wTW1xc4wcXQOFpcIRJpaNhOiEE9+1+D/pNrPmmzHBNGvXaU0c7QWHlpm3Xqom94BbOwhHsAWHT454KaL6jhQ/UqVB/tSRW0UGD7kiu3l5SkAwElUJ//OUgvYA9W8NtyXUHHUVTeFZw0XFtZg9JsmqzjlZh+MQx2AwGV+zetBTFU9bKX1YWg1LZcKxas7WtBv98JYkUttXSe4dI6JVctxg6nuc+IceplqB3InVN00UBmC2APoTJlF+Cnn36CTLMI9kxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRj/jIZ6SzgIVAjjdbEqk2kUds1n57mWNfX96XDKHco=;
 b=H5I21wIXPvFETAng+o2IE5g8gplHxsxUjr6DAXbm4kvixgpCatceoPGRwJG/e4962I8YvNZO/1bIeq58QhW7BJJ7RzD1u8g4Fy0HTTF34VVuzgstalwM8yKCdVg6dqyf+5FBg3i4n3C+8dk6tO1AK+KGQkYAnct9iyKUjUPG9qU=
Received: from BN9PR03CA0274.namprd03.prod.outlook.com (2603:10b6:408:f5::9)
 by IA0PR10MB6915.namprd10.prod.outlook.com (2603:10b6:208:431::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 08:21:49 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:f5:cafe::a5) by BN9PR03CA0274.outlook.office365.com
 (2603:10b6:408:f5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 08:21:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.4 via Frontend Transport; Tue, 21 Apr 2026 08:21:49 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 03:21:49 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 03:21:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Apr 2026 03:21:48 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63L8LjBI157498;
 Tue, 21 Apr 2026 03:21:46 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <jh80.chung@samsung.com>, <peng.fan@nxp.com>
CC: <j-keerthy@ti.com>, <t-fujiwara1@ti.com>, <u-boot@lists.denx.de>,
 <u-kumar1@ti.com>, <gehariprasath@ti.com>, <n-francis@ti.com>
Subject: [PATCH v2] power: regulator: tps65941: Enable FPWM bits
Date: Tue, 21 Apr 2026 13:51:45 +0530
Message-ID: <20260421082145.824453-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|IA0PR10MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb07929-4a22-427a-4dad-08de9f7f0924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: eV9BJfmkNWMvp1pViv5c195zC+BEovfvwtl735tauC7Ng2fn4b3sHfjS3PBzfFKWjWfbc4Hxad7osC5nscKH16xnqvRIiDC6RGmtS56RZTIB7RpzNFrB5CU21anxKueoLtucp0keTESLY9+uGKRhy104S1nhFuNngBTABLTMldkMyZRO77glEzO4lZLovBAIn6s03N06+SI/QF/zdEZ+zt22QBpgLUbZjP3aCUitaF5I9OAeq0CjFXSJqvWAWNi/IaJk+Jbb+jj6lG17KrL0YqLTUO1VbOK9xWqPnwW2Tq44U9atYRRHXV1BIlbVKCqE7zz9Y/hOFzoBGi2ZmjD5UxIyBJL7lpHKToJWPpHizp361K/6zpFHEvIP0LlhF4dxu5khcNXN4WMsoFt9igCk9W1et2oPXoFusfU6TfbepZrP+R/oFRVyBiZlHQlJ8PNYuiG6TZknGIlD+f5oBueEVskj9L3kYzFxXC5i6ziIphd46/D+M9owtFKpakbszbP7WEIV9bQRr37UFIHlCGY7UCNybQkGSDY3yPRmH0kq/LSm+uRe8cdFLsw/0k11AINUzAecsushT2y9veLT58kxMhwLrQ7pWLJBfpVHgPTupjkLnp7XR7nRO3OAN6/+DQNcVpmoMsLZbOZUMrqVr9t/5Y9ot+AhU5DR2AdQbqPJB6jO3NGdaslQVPG0amImK2TKAgRK2CSqpikOh0MIPwWmHFYHT0B49SLGhxDSb2lnMKA=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m575CftD3OSEXrC9a4Kb6UfoHbOxuJ/9iiphc+nE6tK8B1jHKCSTTlo0oM1+x6H0Ht/a4/9Y9M2ht3Xa2AZlO9caxe8RFJYHNjelXMu7x1NHUWkF89IYRNRKScOs39DpczSKFHSBx9m5t916KZErwa4M927snRmHwETmncYrArZo5bxE9uLyX8mk2Oluh5Ag793yr0TZIpzBwpETP4X1PHtaMINVpaD0n+OI0pA8chiIM5OpXi2wWooGWQBoC9+pNEWLN/YDd8w8y3gJdtOup06FJVw+WYtQVLh4POk25O8TH0DOll+BEfz1C6HC85VVhnhBqzBoXdp8UK/t4tJAGsrV9MCwXINMrFO9tRpMvLnsDSeW7nu1Fyv2goqNZU9F5tUqYlOYQCdM53ef+AjhoSkZDxmECG7TAK70NzPea/VhQbqJGYT3Csoo/4ATz232
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 08:21:49.4994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb07929-4a22-427a-4dad-08de9f7f0924
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6915
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

Depending on the phase selection (single or multi), the FPWM bits
configured forces the regulator to operate in PWM mode. In case of
multi-phase selection, the FPWM_MP bits enforce the regulator to also
operate in multi-phase. This fixes correct multi-phase operation.

While at this, correct incorrect macro alignment as well.

Fixes: 065a452ae6a1 ("power: regulator: tps65941: add regulator support")
Link: https://www.ti.com/lit/ds/symlink/tps6594-q1.pdf
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Takuma Fujiwara <t-fujiwara1@ti.com>
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Changes since v1:
https://lore.kernel.org/u-boot/20260129072857.1437272-1-n-francis@ti.com/
- alignment correction
- used existing macros instead of 12, 123 etc.

Tested on J721S2-EVM (same as v1, no logical changes)

https://gist.github.com/nehamalcom/a74fb2a3b59421d0e04693c7d244fdb4

Before the patch, the kernel TPS6594 regulator driver would warn about
overcurrent on a buck, this was due to incorrect multi-phase configuration.
This patch resolves it.

 drivers/power/regulator/tps65941_regulator.c | 15 ++++++++++++---
 include/power/tps65941.h                     |  4 +++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/power/regulator/tps65941_regulator.c b/drivers/power/regulator/tps65941_regulator.c
index 2561d6f4c6c..209968b5718 100644
--- a/drivers/power/regulator/tps65941_regulator.c
+++ b/drivers/power/regulator/tps65941_regulator.c
@@ -63,13 +63,14 @@ static inline int tps65941_get_chip_id(struct udevice *dev)
 
 static int tps65941_buck_enable(struct udevice *dev, int op, bool *enable)
 {
-	int ret;
+	int ret, idx;
 	unsigned int adr;
 	struct dm_regulator_uclass_plat *uc_pdata;
 
 	uc_pdata = dev_get_uclass_plat(dev);
 	adr = uc_pdata->ctrl_reg;
 
+	idx = dev->driver_data;
 	ret = pmic_reg_read(dev->parent, adr);
 	if (ret < 0)
 		return ret;
@@ -84,10 +85,18 @@ static int tps65941_buck_enable(struct udevice *dev, int op, bool *enable)
 
 		return 0;
 	} else if (op == PMIC_OP_SET) {
-		if (*enable)
+		if (*enable) {
 			ret |= TPS65941_BUCK_MODE_MASK;
-		else
+			/* Enable FPWM */
+			ret |= TPS65941_BUCK_FPWM_MASK;
+			/* If Multiphase enable FPWM_MP */
+			if (idx == TPS65941_BUCK_ID_12 ||
+			    idx == TPS65941_BUCK_ID_123 ||
+			    idx == TPS65941_BUCK_ID_1234)
+				ret |= TPS65941_BUCK_FPWM_MP_MASK;
+		} else {
 			ret &= ~TPS65941_BUCK_MODE_MASK;
+		}
 		ret = pmic_reg_write(dev->parent, adr, ret);
 		if (ret)
 			return ret;
diff --git a/include/power/tps65941.h b/include/power/tps65941.h
index a026ec56958..78e48a15972 100644
--- a/include/power/tps65941.h
+++ b/include/power/tps65941.h
@@ -19,7 +19,9 @@
 #define TPS65941_BUCK_VOLT_MASK		0xFF
 #define TPS65941_BUCK_VOLT_MAX_HEX	0xFF
 #define TPS65941_BUCK_VOLT_MAX		3340000
-#define TPS65941_BUCK_MODE_MASK		0x1
+#define TPS65941_BUCK_MODE_MASK	0x1
+#define TPS65941_BUCK_FPWM_MASK	0x2
+#define TPS65941_BUCK_FPWM_MP_MASK	0x4
 
 #define TPS65941_LDO_VOLT_MASK		0x7E
 #define TPS65941_LDO_VOLT_MAX_HEX	0x3A
-- 
2.34.1

