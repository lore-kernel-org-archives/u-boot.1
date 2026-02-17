Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F40BE6816B
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 11:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6F5783C61;
	Tue, 17 Feb 2026 12:31:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hyGVfiIo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68A3983C72; Tue, 17 Feb 2026 12:31:01 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FC9283C32
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 12:30:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GejthK4f2b9wknZFn7PrRHUs0KCSJhpp/waQfvHpWUNBTz7zdkdczLOPAEuQtOHKR0Vsa7OzXTlI0pJXXLDaTGflSjmpjVeOvh1tNq5taUX7SOQV4DozyJK+XSfIsaddmyEYu4puFPl8ZiN+UjPyPh2gIiGfI3RHvArubJ7hcgVV2PBVtYjrTBAsRPmGnuAQHQ/s9RCqBgW8RgPLI9B4vOW1Ufmlh1cJ2+5i7HHQLHLKcj7rz9dTwFu/O7EI3IfuNoMLhuh9Mvy9lYDGKYD0m+M3kTjhKK6CVtH0kmgImLGuE04SThtH47WGgBLDqTmoRBye1f7JQw43gfniLiobxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnEbBoBJtjgYovAaLbepRyG8VV4ficOMK42YEstghM0=;
 b=Jpu11tzhHoN4D3FTC9WC0JheZ+pv/2EO+TOqmY9vy8DiCjMYh0oXM8gmid5xZPZBQwFjF5AfkLdxwaMXqfyiH1lxhPTllNwKmit3bg7MjK30fMv+Q5oInAwaz+b48B2+DzTGk81epCsixFiZYFS3wvF24tNm3rCHMdJKl1Df3m6CjEUPE/A9E0V5syunCP/MKu+ZQAs+UP1500Z3tUwHh1bMzkjJzGWd4qSzjW+0rkguTOR4RzjL4zZrfcr4nFIo4s3D4QI4jcsRICzuS0WC92nUnFZPcamK6YYuuWvmOzy2SvRThEm+mCrmwmabmS9SRNnpB36JfsUO5KqjULk6cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnEbBoBJtjgYovAaLbepRyG8VV4ficOMK42YEstghM0=;
 b=hyGVfiIocSeFj1yGc180C/wNg8Pdq1/MBUSa0j3h0nNY1XJ+LGVHm21bbiOEhhWeT6f6I1xfRPMbXoruHta9Ydt0ZzwSmJRWf1Ub/ZMLaCJFfu0eCpfla2DBvU9DeEZ7fZt/4sPuPRFMV4VGa9Vzk1TdMKOID36AM2kDk5ltG6g=
Received: from CH2PR14CA0031.namprd14.prod.outlook.com (2603:10b6:610:56::11)
 by SA3PR10MB7096.namprd10.prod.outlook.com (2603:10b6:806:306::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 11:30:47 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::58) by CH2PR14CA0031.outlook.office365.com
 (2603:10b6:610:56::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 11:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 11:30:47 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 05:30:46 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 05:30:46 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 05:30:46 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.51.206] (may be
 forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61HBUgva3273085;
 Tue, 17 Feb 2026 05:30:43 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <jagan@amarulasolutions.com>, <trini@konsulko.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <boon.khai.ng@altera.com>, <a-dutta@ti.com>, <s-k6@ti.com>,
 <gehariprasath@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH] mtd: spinand: winbond: Fix oob_layout for W25N01JW
Date: Tue, 17 Feb 2026 17:00:42 +0530
Message-ID: <20260217113042.277239-1-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|SA3PR10MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: d96fe020-0c38-4e18-89ca-08de6e17fed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?apve49lyUbC0Kv50KIqZocBq9Kzv7V+FROlMkmJng5kUuR3GMPCMiw76hFs8?=
 =?us-ascii?Q?wnFwKzqk35s7d6vDvRcr3RiGcoR4fptdhIZ3oqtPLGyMi6bs12kRXBlPjclM?=
 =?us-ascii?Q?jkjPhE1H47GR84zidCs8tEgsn2vK4OoYNlVPgBWi8mZk/K6IAS4PfpGn57B0?=
 =?us-ascii?Q?4jCQHCndL64Zw3XScObdY5QlxreU1GNJUI1HhN1HQUz96HM9UtPxFKw5HgQN?=
 =?us-ascii?Q?L0f6vgcqV/xlTsSEOLeDqh4j+Kospj4c8b+QSCmEK9wWgZJQrArr9jzSX8dm?=
 =?us-ascii?Q?pxBXdrFDnwkCOs9EyjEsdJqNuKPEmX+WETVC3rH0nGDi3m4tW5fSFZ8fEoK0?=
 =?us-ascii?Q?yapKo0UPiN+EH1QkWsvwdZk7VGxXn5ykPjYAYh0YPs9L8YIY0XyudoTe+xwT?=
 =?us-ascii?Q?UyRBuafxqUiPG8c5QY7c0juofpJJ1cFwP/D0nDLzRAaq05PCzMuoHNHnQohl?=
 =?us-ascii?Q?O3whvLCje74zsyb5SzColh/yyAmg2pQTL+wJo2m655UHvyju6C7Rk+KGHSpZ?=
 =?us-ascii?Q?4Oy25bRdLWl5/beaZV7/IdS7/bLXXZjWdvH+WfV/DURmewJRLuPCfUqb0dn7?=
 =?us-ascii?Q?zJl/DHD04aNJgyd8+GUqFczfNRfqRtptc+KdMB7m3NVClc74/KG24riCK/wd?=
 =?us-ascii?Q?FqnKWbDLbFQQ9PfCPKFrY9+0fc9l4wc5U0g9TkuPFhF/q+nNZFB3g4Pr/kdu?=
 =?us-ascii?Q?Nxkw4bCYhxc/uCva7O3BY0/rSMMVWV59lYM1CtOdOBE1na/EvhkP+rKqFhde?=
 =?us-ascii?Q?LF+lkTvG9qyhB+Zx9TQUYxGuU9ZG0Yvf59d9bCbN0DqiXt7Lcy5bNZvBo3SE?=
 =?us-ascii?Q?MNYgGenBFWsnrsxhfrnOCliUp44GeUsnLK6UGxCz5Cp3bL5FJNIly2Ij0g7C?=
 =?us-ascii?Q?IS3FBNSXe80hu8hUBwxHrLJSQJr6Qx3eFIO1rYE2s5Vd5D5Z+0MsVOIRKz+m?=
 =?us-ascii?Q?0sIL68XODoMk4vgcmeQ+dxqZUrYM9iNaPLvZW/b3DDMqnxGjTsHq2D9WgFoa?=
 =?us-ascii?Q?hlqZTiXehN0rshXOGpx8m7b7wXHvkQviNOJUKk5KOkH4lTc0y3oi6vMnFwI/?=
 =?us-ascii?Q?4HpyPUiZXWS04NcAfb+Rs8QDHKHRvmIINqinzBWWeOey8E6xMk1+7wrlAMOm?=
 =?us-ascii?Q?DLD5A6z/hQN14Nzi/CjPv2l3ufoLEhKwUGtcA2uO8cnra2qxU/d0tl6y6iJ5?=
 =?us-ascii?Q?nju8FlKjXWDbOfVaNMXTcpcNSBD0ZQh8+wwc0pR5VL/d4fGyXeOJCCcueLqJ?=
 =?us-ascii?Q?Bd541vd8CMddsMV0wfowFeqJgF5F2RqAa3NgYFayNh9XPxjBEjAJ8+Qs40pN?=
 =?us-ascii?Q?h9teT/O4SnoQqr5ZqLd3ja3bzvcmncVVcMk/BiMioMfg4GDJ8xKFrSPAGxvi?=
 =?us-ascii?Q?4Iv9og1Ih/KYdTbkAuAoSHS8m79svfC9gokpSKXf2LX7bZcRpk83ZWzPS+w5?=
 =?us-ascii?Q?ozkh/ad5Jiha84bNoYqwPCRsuHcHx7Ysa+Tu21txnjTYV6Rr4Te+XaZzZG/c?=
 =?us-ascii?Q?sZRKJQX36yTARK6KIIeRqZPMsHyMJtke93058G1Pb0fpuAWs2AmQXGHcnA/i?=
 =?us-ascii?Q?Vy3IxWz1m9AQFeCC6figyvSn78DQAeVs+cdByNcBvGS4ALp7hMupyrCeYl8v?=
 =?us-ascii?Q?66VyISK8pTCC93dv3PDF9+YoN203QOrjPT+pBV10jajuxs9tKIft2/FnQ9l8?=
 =?us-ascii?Q?zW9lDQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7U7zIs4x9lM2/5HSEbiC+Jj3mZM8X5TrH9ZP+aHChvyVNa0Ix+E576kqfOS12XGHqUfiXf2yjvRN+31LMmpMUSPQKIt6aXbpiZiWvgkRaGaZ5ridIBuV92bLp2V0/nPQ0Y4tUy3LV1+puMh2HzsR/h3iJwpfu1mQWvtxA7Lwfy/a3uha+GSIxZNoEwl9R5ddyz28/w1T2yA6LbBnjvWmlyPAv8GQgEIJf6KoDZi9Pbp4NJbE0Zo5Pn89cKnG0vd+BcmjJm7JMf/TA8TuvLCeJFNNDA6k5oxxKBYTnE5er73nMPKX2I6II21ljT9jh9li3DyvwP4vPUZu/yq8Q3d+LD3xJ8CQQ4Y4s4A2M55EUBhVSGSPNOhyyc29ogUQY83lKCQNq5DWkQnptu2xj8exRev0GNJCgFbsqzfxdyHnYaYPfKdb8cLXKhvD1nC2mfQS
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 11:30:47.0663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d96fe020-0c38-4e18-89ca-08de6e17fed1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7096
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

From: Santhosh Kumar K <s-k6@ti.com>

Fix the W25N01JW's oob_layout according to the datasheet [1]

[1] https://www.winbond.com/hq/product/code-storage-flash-memory/qspinand-flash/?__locale=en&partNo=W25N01JW

Fixes: 2cbdd3e4491b ("mtd: spinand: Sync core code and device support with Linux 6.17-rc1")
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 drivers/mtd/nand/spi/winbond.c | 37 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index a89aaec516b..2786d91f19b 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -171,6 +171,36 @@ static int w25n02kv_ooblayout_free(struct mtd_info *mtd, int section,
 	return 0;
 }
 
+static int w25n01jw_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = (16 * section) + 12;
+	region->length = 4;
+
+	return 0;
+}
+
+static int w25n01jw_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = (16 * section);
+	region->length = 12;
+
+	/* Extract BBM */
+	if (!section) {
+		region->offset += 2;
+		region->length -= 2;
+	}
+
+	return 0;
+}
+
 static const struct mtd_ooblayout_ops w25n01kv_ooblayout = {
 	.ecc = w25n01kv_ooblayout_ecc,
 	.rfree = w25n02kv_ooblayout_free,
@@ -181,6 +211,11 @@ static const struct mtd_ooblayout_ops w25n02kv_ooblayout = {
 	.rfree = w25n02kv_ooblayout_free,
 };
 
+static const struct mtd_ooblayout_ops w25n01jw_ooblayout = {
+	.ecc = w25n01jw_ooblayout_ecc,
+	.rfree = w25n01jw_ooblayout_free,
+};
+
 static int w35n01jw_ooblayout_ecc(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *region)
 {
@@ -399,7 +434,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
+		     SPINAND_ECCINFO(&w25n01jw_ooblayout, NULL),
 		     SPINAND_CONFIGURE_CHIP(w25n0xjw_hs_cfg)),
 	SPINAND_INFO("W25N01KV", /* 3.3V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xae, 0x21),
-- 
2.34.1

