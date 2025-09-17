Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE1DCAC5A0
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 16:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97A9C83692;
	Wed, 17 Sep 2025 18:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=de.bosch.com header.i=@de.bosch.com header.b="BtEs6UJQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C706836A3; Wed, 17 Sep 2025 18:00:26 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40EB183677
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 18:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=de.bosch.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mark.Jonas@de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrL5okBJURzCn74DcX50Doynh002ZRnH+KEAsvFvocVKthw218t1SNRwd4xhnovkYMv4OgFGeeES0xrVHLFowYSezSnsLcRCkzqUDaFaRxKxX2ESscb19WF10V5VXndvsLksS87SLBvONTF3XbuW+BBcOBtUKlFDh3TwOzyfhHLStlqfnA22oPEJESL+zUDPTJvH13gWCLKQVyyMpf+beFx/Enfrg9zv66HxJud6GODATrwB5lQK+j2er8N18rmNWR/1DBsOt2pe/7HXgbDroIiOqZFjzg8PX7osCLoB1NIop53qMFXN2oAXMdedqyHxt14/4g/rQ7L46EOv10tZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TM+SgGWSiCQ+cgCawJ/Y0QE/tmJHobSiYdLPhzxhlg=;
 b=lsMxESS6VchWWkNUEPYEyzZQ6Cpada/eg9CICB8Li8vMgkIVwBDMmQRI5a4hoz6yen2z/9YTJyKM936QFE6rX2ti7r0trxHluvnXBBdCHRgHRO3ZR+og+qMPn+GD36mILjoSUzpSPHID/vGvEyShhltGjugAuAYrz7cF9LsfqTvQOcWj7bBXCfjRFdmHuSfjFvo9/T1N/n6Im8+lAgJ1A2cz7dr9IwEu8T3EHGSZn0nOfX0j9FydC4zT5W8zOOCjkJ/ccAETx3sTQFUPJw03Ey/QGo2A3MEpRkNU/zHf3bhS2bwaV6Cd7DBHP3UcqgnoR512ZTWYg++MVuqyfNO53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TM+SgGWSiCQ+cgCawJ/Y0QE/tmJHobSiYdLPhzxhlg=;
 b=BtEs6UJQ7Y4Kw72TN3EqJWBgrFljs+9dujfZeXWcVW2VvopnolxOuoPyd/qTtLxQSnJiWiD14LJ/vXqrzdRObkI9x0lhPVyGsyjHU5qVaKlsUyxYLBwmJ3sPvbfYt6PLIskOAKDmTlsMmqoaBntQI1e2p0nH8LLkbDq7oMr7jrIdXn59jy82YbmH5NshetxLylGtHzL8yknzAQ0vLOPg5IzZZr4rVMtB8ltsqRXZQZYR7ndZvZVxCdWzd0mcATYc18IuUHl66SGDvFiUQcOC7W6sqsJCa93DqN+sbdLoYqczew6IT8VV5TVbmJ0F3UlQDqHrwWsk2l3A7QjdQtAr0g==
Received: from DB8PR09CA0036.eurprd09.prod.outlook.com (2603:10a6:10:a0::49)
 by PA1PR10MB8641.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 16:00:21 +0000
Received: from DU2PEPF0001E9BF.eurprd03.prod.outlook.com
 (2603:10a6:10:a0:cafe::86) by DB8PR09CA0036.outlook.office365.com
 (2603:10a6:10:a0::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 16:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DU2PEPF0001E9BF.mail.protection.outlook.com (10.167.8.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 16:00:21 +0000
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Wed, 17 Sep
 2025 18:00:05 +0200
Received: from GRB-C-0009M.ot.de.bosch.com (10.22.69.50) by smtp.app.bosch.com
 (10.124.11.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Wed, 17 Sep
 2025 18:00:04 +0200
From: <mark.jonas@de.bosch.com>
To: <u-boot@lists.denx.de>
CC: <festevam@gmail.com>, <emil.kronborg@protonmail.com>, Ricardo Simoes
 <ricardo.simoes@pt.bosch.com>, Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH] clk: imx6q: Add definition for missing PWM clocks
Date: Wed, 17 Sep 2025 17:59:32 +0200
Message-ID: <20250917155932.3096-1-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.22.69.50]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9BF:EE_|PA1PR10MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: ada49784-e7ee-493f-84e7-08ddf6034e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TBzCe+kwoAxipsqBK0+EgJiPOkV92cVH/+jA2zCDZaqaiueH/0P1/MWE8KwS?=
 =?us-ascii?Q?P+2C6c4Zac+xZrOIn/mLfk7ywVUfT865ZnXfPrdvpr97dlCCyLmcoQPhPTig?=
 =?us-ascii?Q?gCos0VVcqkwXWuq8xvov7m53Az3imkDnB0KkDu2mx8jjE6c/BWZJMfSut2zq?=
 =?us-ascii?Q?BO+XTYklgcqZyjka+XjzONgWI9n8umbCiNxYzkxh6JR1v7FeQpoetUCo81aL?=
 =?us-ascii?Q?0z09RcFaGqVSC++uKWGiau5e9tKUM3Ng53gJtMHovth7O4iovbDNOIXeprMJ?=
 =?us-ascii?Q?qnMPZ68cMYT0bpyHDcjLVoMlkR06AihCnqH7jWaM0xNh6NPTLss24f71jeUc?=
 =?us-ascii?Q?gL1kTbXqtK6r4zcLNi4uCdpqBTZgrHSbEBFw4kDgaxg6xeL7TSGC2oj04Wg4?=
 =?us-ascii?Q?5GsVETDtqO155KXqcuEAG44Xtc1e85xSc5x8e+ADJ85eZ8bctQmMRodMnCqk?=
 =?us-ascii?Q?j/sJAg+5rqwvoJt7LAvD07WsUYnblsRDPf52LznvD0lemMs2SzskmgO8fnK5?=
 =?us-ascii?Q?3ctdEGb+7fxlBiALAUx3bGQWHOwFNGvITsm3frwfiM7oig+rxfoliysRmRWc?=
 =?us-ascii?Q?yMK79kByvRxoeDnoM2+rib+4W5UeYkDXLh+KRxtdzUR1OELXUn+zkKJjQSZV?=
 =?us-ascii?Q?QoG5K8P0VJavBXEFoILc/fhfo+tMBG9IPqBQtQ5tta8Nmer0oUq2hDeQ0WWn?=
 =?us-ascii?Q?r1A8F7EPhJzZeBEowYF9jpHDPntbqrOjuBxh86AhsBNjMHaYXx7RqtoXmkQy?=
 =?us-ascii?Q?Qo9Xpa0HjqEuQ9O76xrIQvqgeQmgN91Z0R0hUUumVqqgIKfoHZ6nsxISvJ+3?=
 =?us-ascii?Q?HseVplNTR1lX0GSjFAqkzD/0TX3wOyetnEzN5zBTiUJXa0Gcy47mgo+Jv1/O?=
 =?us-ascii?Q?34XPtr+XGmJTznlXzNhU49tgBE3QJ3AjWlfbk2TpJ7QkbDBieWAg4kgS74Bc?=
 =?us-ascii?Q?5PWDoCOa5LXIgmMMBPvqM3qDBdtS7y3fIXSWzSVWZnI1ZbNtsjXV+TxOnZ5S?=
 =?us-ascii?Q?3BVrx+2/5jyzia6AY727QhA2NeQw0KHCh5+RNBSHUJ/rjg5ePaktw92HtDEo?=
 =?us-ascii?Q?7rKmBf0JQYSfgiYWlUfuwaLD2dpv6j8dcv4XVzx+ZCoffnpQx6V+lCQkB+Od?=
 =?us-ascii?Q?KoOzY58/0DXaJay/Vr5NXLf32NJ+2dQETXVUZENPASegThZ90t/lrb6DOgjG?=
 =?us-ascii?Q?gChHnwQbGp18ASz+zWwMXvRsAvfyIsDkw3+9jf5hV2K+JJ/MsGO1pSEKZzbn?=
 =?us-ascii?Q?w7lvuXuZGMOzXVU3jvPDOJmMVvDq8AXA6VrpFfB0+re5gm56J7FbyExQYYNW?=
 =?us-ascii?Q?tG4DejQASyAISblKAOCIKobFBCf7oYZ5ejFAHpTBK6E6gFllUOE7hFC4Yuac?=
 =?us-ascii?Q?jClzoi3CO4TYdYl3wGzV8veOz+YLRwh+mfbOBtdScMotOdBxe90Cf8GrC1YL?=
 =?us-ascii?Q?QBKRm2XNTCk1/YkhcCpLZEvufLUnL+CfOKgbhwlIzT8YW7JytuIaw7g5ApX8?=
 =?us-ascii?Q?MVwE6UY5b6wnVsg/HiuG1AXgHlupvzXD7tgP?=
X-Forefront-Antispam-Report: CIP:139.15.153.206; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:eop.bosch-org.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 16:00:21.4286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ada49784-e7ee-493f-84e7-08ddf6034e4a
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4; Ip=[139.15.153.206];
 Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8641
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

From: Ricardo Simoes <ricardo.simoes@pt.bosch.com>

Following the work done in commit 7f39ad5a, this commit adds definitions
for PWM2, PWM3, and PWM4 clocks. Allowing one to use these PWM modules
together with DM_CLK.

Note that the solution was verified only against PWM3.

Signed-off-by: Ricardo Simoes <ricardo.simoes@pt.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 drivers/clk/imx/clk-imx6q.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 13239f2f64d..b69355cefc7 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -156,6 +156,12 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_gate2(dev, "i2c3", "ipg_per", base + 0x70, 10));
 	clk_dm(IMX6QDL_CLK_PWM1,
 	       imx_clk_gate2(dev, "pwm1", "ipg_per", base + 0x78, 16));
+	clk_dm(IMX6QDL_CLK_PWM2,
+	       imx_clk_gate2(dev, "pwm2", "ipg_per", base + 0x78, 18));
+	clk_dm(IMX6QDL_CLK_PWM3,
+	       imx_clk_gate2(dev, "pwm3", "ipg_per", base + 0x78, 20));
+	clk_dm(IMX6QDL_CLK_PWM4,
+	       imx_clk_gate2(dev, "pwm4", "ipg_per", base + 0x78, 22));
 
 	clk_dm(IMX6QDL_CLK_ENET, imx_clk_gate2(dev, "enet", "ipg", base + 0x6c, 10));
 	clk_dm(IMX6QDL_CLK_ENET_REF,
-- 
2.34.1

