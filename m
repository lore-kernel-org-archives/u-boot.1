Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98517D358D1
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 07:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAB5483B85;
	Thu, 29 Jan 2026 08:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EjBpAsW8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28A2783B8F; Thu, 29 Jan 2026 08:29:10 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB8F183B72
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 08:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhZILDWVc20jQlzprJ0Tyfa2uYsxtjNYCPGjtnVLa8pR5FwZtMdDOmWw5ha6/OMkZIBhtrmctv6LKJZecCv6511Omlhlo4JKiO+DzKOhuH9GK8x9Xa60ExTgtcqpA9UNWJaCZaqfmToJRa3mcP7UfNu3CuXBklaTodcQzIyaplKNfC0TIiuAHkIprLAehPI5kbL1a6EBFNNkxBX9VZbY6xMbR81nfVlkUpj5lJBDCFj3pvLu88FxJLcjvcr32kcnPrGaBVUzXw9kaKrM+qDztHN7kUhn5PHof4aa/EaFOEYmACytiaEEa1++LPPG+UCRS2pRAd8CZq+/H02x8jmzIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nmxxz23b4rot5MS/SkHaBK6ierwoBgETPBukGtA2B+c=;
 b=imDC9AemcGsGPiyLwY5j7jY0Qd2/j/QigHQ+Mwk1RK4+4MphClCyiGUzYX15xV3e54PcQU0O6s4AhI6Cqqi/qCdnD1XAHQK5nwXgh2MOUPhBdMZYeWYHrkx8HIoQETNCF7GPEv8r9CfDAxligyk2nAsrob+Rloti2Z2tCxwBwJtePDdmgkItc8JmFl1NTZAP7wyKG6vay1uHYz08O+PmbWRSRD09G4gAacAl0ZkcoUrtjHz0VuTwsNW4c3tqATlB6hTmtmdT36Oaes2zzEVHfD89arUSYg0Olau6ftyTFfLPVrGc/4jH+CB3AH1tCz3FhefCZXPcGT3a359msIpH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nmxxz23b4rot5MS/SkHaBK6ierwoBgETPBukGtA2B+c=;
 b=EjBpAsW8h7rT2rhrqbqntumls+sLPhDwOOaEgghZ+1AX9/bC1ZyTpWmeEl5u3K19cvuFUHggyfgCMQiTDBbl6lbBm4nMvAanGKL0AS+jU8PYG+3s1Z8njstf/bRAfm2eS8tKC5WBb3joJEZZCPZZdZMykrDStahdIwGoW2t6Qt4=
Received: from SJ0PR03CA0287.namprd03.prod.outlook.com (2603:10b6:a03:39e::22)
 by PH0PR10MB4455.namprd10.prod.outlook.com (2603:10b6:510:36::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 07:29:04 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::2d) by SJ0PR03CA0287.outlook.office365.com
 (2603:10b6:a03:39e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Thu,
 29 Jan 2026 07:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 07:29:03 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 01:29:01 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 01:29:01 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 01:29:01 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60T7SwDl3353114;
 Thu, 29 Jan 2026 01:28:59 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <jh80.chung@samsung.com>, <peng.fan@nxp.com>
CC: <j-keerthy@ti.com>, <t-fujiwara1@ti.com>, <u-boot@lists.denx.de>,
 <u-kumar1@ti.com>, <gehariprasath@ti.com>, <n-francis@ti.com>
Subject: [PATCH] power: regulator: tps65941: Enable FPWM bits
Date: Thu, 29 Jan 2026 12:58:57 +0530
Message-ID: <20260129072857.1437272-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|PH0PR10MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed1b232-ab64-40ae-519e-08de5f08140a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OETl1YunYR901xAfU0ZBbtJb74rEsvcUg6BU38oEA3hKF13zw0a6FdlOUTw0?=
 =?us-ascii?Q?1d3exEomUWVDVkXlqZTFSE4jIoFbqZOXKzLXTNm0OOvBtfA5mlfRh2+qaMAs?=
 =?us-ascii?Q?UTJLlEXu9TGWsxPMvOwkmNY8ukTYnJ59+uUD2+kNP2x3D1yPYdSvrQh8pp5B?=
 =?us-ascii?Q?eV5td4cMi6U9SAuXyRrzIVtQWQP6oCdY+awOx8YAhCFpprEigxM04Dn361+S?=
 =?us-ascii?Q?mAXEwFIwLaLaJ4E+aQdIug3IKlU9s7nxBuFEOIOqgdsqxclG9KFrdqbYJsN3?=
 =?us-ascii?Q?sb341zz9+mmaigDfiziAb78gIwys0KegBCqqq6Ao/qZi+uRyHsjmB4EDO7zu?=
 =?us-ascii?Q?f4guIiO5W2pkzuXYvnTPGs2UYfC1sF4nONoTJ6uUF+hWzZ1EtSjWRzcjB8CN?=
 =?us-ascii?Q?/58uwtOvYfWvt5AXyFiCKCha7IhQuyoP9KurtHm4WBGR+TQoI9JW7nK/0BL4?=
 =?us-ascii?Q?qUeoMFFPbNdDEIDlA3zYwGhZw/xl/PsxXGVW6XrsZJe1LMsN80A8zNT7Xuu8?=
 =?us-ascii?Q?7QzxCaUbUNzknleHwpv/xhTMWKiabhAST4MGPlObkso01fLwxfLRt+5L38va?=
 =?us-ascii?Q?pnFzoR7wmofrnweAkDBvDMR7VZzkN6fwCmDyZqkAKkZ1BBCWYV8W3LyF4lsJ?=
 =?us-ascii?Q?nSbcq21aoKasDZpUPVM9iSi0+Vh7+CBvskRqWaVex9vu+S3TZoI8GIjnunJK?=
 =?us-ascii?Q?ADaPqjdNVln/8HIw6ahzEB5DFPaNpF43lu3us3iv2pWijSdW4WQr+F68EcLf?=
 =?us-ascii?Q?B7Ssm/o0T3ocXQor6wSsQSrjQ4HE/q0mvfC2wNcOsYu7Jerf4abMZevyRoGN?=
 =?us-ascii?Q?hh9HtYJfNBpaMoE//SNiw24f9dxe1cib9YaqQd9YqFQJybL558ycWH42mIsN?=
 =?us-ascii?Q?DJJWfEmjoYY3PSAy78hpfIvqMFu545evQXjv/+kB1n6kUJRIw/gxJ9VSaaLW?=
 =?us-ascii?Q?r5tiOb+X1w9CNevFivXmtNpaVl+Ya4M+mL/ISbUvEVxPLZdjIDAVPwBswXtt?=
 =?us-ascii?Q?CNqyfNj8k0vpMWgF/JdJxGheqTDZ1+o+WbSOpklzKBVTi5xKhPy1aC75xRAU?=
 =?us-ascii?Q?MpjBByybvB6ILwI8sdmai8Lu+bAlCTxmFeFIuzTq+CvlPP/nRwQBGigs6Q36?=
 =?us-ascii?Q?7MpBn4ckgFQd70xAcl+1PkcjaD1tdNw3/kr4QXE8RwWHTP8jCP7ODEUNtZzy?=
 =?us-ascii?Q?cj38dQNih0NSn7afbtJ+FekqUc9t4MCjCjjndJq8m9ssq7W7+TFZZLkwuj83?=
 =?us-ascii?Q?9uDfoYmWybVqiOMTO6Zx19IpZwu6LLYbp5xphDn3Pjh4dcbsif6NOPptnNVR?=
 =?us-ascii?Q?a+Ri2YUGPLNSqOAcCgyOlflsMO4bbErOtp68krd8MMG+ZjWzPmFtPUd52YTX?=
 =?us-ascii?Q?ARUNllLnWIStmjJ+zHR7IrfqNqsVAOSvlyxKPrpoTLEI+xme5Sp1Fcsyk7bi?=
 =?us-ascii?Q?Jol3630ez2Y/3+6I7qlP5rrueX9v1yP6RDT18QJyBA1NRVAcMAMO7AvqPgKW?=
 =?us-ascii?Q?6v1/sBZt7n0o85l2h3HYU1VZIsZ56eJ7SEXpbnvF1gjetgp/yhsEY5HBPiOS?=
 =?us-ascii?Q?tyGKRjSifD0NJTzoF6axDMGMLSxG6Ugk+K4pUA7ib+XogsED56erv35WfiHd?=
 =?us-ascii?Q?wP9amzZXLurHCZ86cnRoACk=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 07:29:03.2494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed1b232-ab64-40ae-519e-08de5f08140a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4455
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

Fixes: 065a452ae6a1 ("power: regulator: tps65941: add regulator support")
Link: https://www.ti.com/lit/ds/symlink/tps6594-q1.pdf
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Takuma Fujiwara <t-fujiwara1@ti.com>
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Tested on J721S2-EVM

https://gist.github.com/nehamalcom/a74fb2a3b59421d0e04693c7d244fdb4

Before the patch, the kernel TPS6594 regulator driver would warn about
overcurrent on a buck, this was due to incorrect multi-phase configuration.
This patch resolves it.

 drivers/power/regulator/tps65941_regulator.c | 13 ++++++++++---
 include/power/tps65941.h                     |  2 ++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/power/regulator/tps65941_regulator.c b/drivers/power/regulator/tps65941_regulator.c
index 2561d6f4c6c..e0297302914 100644
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
@@ -84,10 +85,16 @@ static int tps65941_buck_enable(struct udevice *dev, int op, bool *enable)
 
 		return 0;
 	} else if (op == PMIC_OP_SET) {
-		if (*enable)
+		if (*enable) {
 			ret |= TPS65941_BUCK_MODE_MASK;
-		else
+			/* Enable FPWM */
+			ret |= TPS65941_BUCK_FPWM_MASK;
+			/* If Multiphase enable FPWM_MP */
+			if (idx == 12 || idx == 123 || idx == 1234)
+				ret |= TPS65941_BUCK_FPWM_MP_MASK;
+		} else {
 			ret &= ~TPS65941_BUCK_MODE_MASK;
+		}
 		ret = pmic_reg_write(dev->parent, adr, ret);
 		if (ret)
 			return ret;
diff --git a/include/power/tps65941.h b/include/power/tps65941.h
index a026ec56958..a8b1044b2f9 100644
--- a/include/power/tps65941.h
+++ b/include/power/tps65941.h
@@ -20,6 +20,8 @@
 #define TPS65941_BUCK_VOLT_MAX_HEX	0xFF
 #define TPS65941_BUCK_VOLT_MAX		3340000
 #define TPS65941_BUCK_MODE_MASK		0x1
+#define TPS65941_BUCK_FPWM_MASK		0x2
+#define TPS65941_BUCK_FPWM_MP_MASK	0x4
 
 #define TPS65941_LDO_VOLT_MASK		0x7E
 #define TPS65941_LDO_VOLT_MAX_HEX	0x3A
-- 
2.34.1

