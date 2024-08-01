Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E9EC3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 08:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40913880A7;
	Thu,  1 Aug 2024 10:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JtgWC5bx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC4E487DDF; Thu,  1 Aug 2024 10:01:41 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C96C1880F9
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 10:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cd4EbxRyIsSDT1eNCQnaOQyaSP9R61qi/SEjLnPXbiV8EJxP7YvVzocKAZITUbEIh8bke4iloz5xIntOuoZcssKVQOj66TtxJQahwzSxO0rAE4aRMyWnE3uq8TubK1ZBdrDmhY8CN9/4XMpdIFoKiEZzpCJqE7Mg9X+balQv+eW8Kg9sbbYyYRLSBM/EMZEmeM6Qmj02O3j4xARSAIgiXRjUKRC6SDel0DYMOYcLy4PRPwPu9KdEf//4xTCiKp6+3dpjj5HryUtdXLHMSa7KEOrs4c//4BnYF0U1wnajRwzHyRK2W48K911zBYRD5H/hdOqFZZHtzZVkuVkbxhV/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJjGMEWyV96ddhvTqqw5J70w18h1K4ZJK07Ns8m7tNg=;
 b=MBODjG95pZNxGgLVLh6nuA9xtO/UCiQVHsJrJpKx57+tRFkM4JY9GdnxaUPrBX6gycnOEFgYzYWpq641zasZTY7FTx7GIxXQdVObypgFcQ6+/PjVi4Pp+As9n6uRMlvAsT4uBMDsQ2VnrQGHdUS4GbJdwA5AHA2Kg1eZPd/S533ctyUpRHamUisDohPDVcNl8uD3UOOv9BvP/sz+MCWKl46QpFt++pRkUsHmJeEtNBsCVtuO7LpIOOTSYlRf3PESGjx5WDEBOc2wu9m+s9A2K9mgf1p2VJA2AUYonaCpDmhuQ+V7qPcK2jXNTfPpWBSaBpxPHahWvkZqxQfDSJQKiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJjGMEWyV96ddhvTqqw5J70w18h1K4ZJK07Ns8m7tNg=;
 b=JtgWC5bxTA+Xs9/RQj4tDtvj397udN0zwjPxg3HU1ZFojM/DrEx21WtrZt7tB05mFNGo6AU6GiugdehuQr3LFaAb/g0UXhJK2osFDutfA3+02MxFOzp8J07NO+oPK+Wi8ehNGag5SXWN7oi6KkKA9i4cffSy5D3OcRx1nzvj3XA=
Received: from BL0PR0102CA0044.prod.exchangelabs.com (2603:10b6:208:25::21) by
 DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.20; Thu, 1 Aug 2024 08:01:36 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::bd) by BL0PR0102CA0044.outlook.office365.com
 (2603:10b6:208:25::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Thu, 1 Aug 2024 08:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 08:01:35 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 03:01:34 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] i2c: mux: Fix error path in i2c-arb-gpio
Date: Thu, 1 Aug 2024 10:01:30 +0200
Message-ID: <b526d573c09b940d7bb234f3e96c47753844c949.1722499288.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1856; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Jr3D5hOXvCZ95v6pSy3so2Me4aZ3Lnsmc7khL80ueXA=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrTVDne2MNf4q1+oStzIYssjoXiicW/gqqsXXLpOHZCsu
 2B8SehIRwwLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZhIej/DVOF/VfF9q+Oyl9q3
 KVfcXlhlfiCGYX7K/YO8q99eXVBhyL2rbb+emO4xQ2kA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|DM4PR12MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a781459-1eee-43a1-4970-08dcb2002a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SsL2isiRzSh+zmnzeJghkgAMak3syvLxWQ5AsZfSs0w9zaF0WdTKWa82i36J?=
 =?us-ascii?Q?1iNfB+so9Vc3h9kcikTd6TdvZDQVu7xm5P0lRcLO9EUSPGPcyugrG2x9KnWL?=
 =?us-ascii?Q?dN8duPYbGHRmAO1fPS1b/KgnC86eza2KOTvv6iYNfG6LnKNdPv4OQZg1lLRy?=
 =?us-ascii?Q?guC67Cx699msZFueAAFDMgLrYgfpYBu9pCJIMy//mTVIdRNXe3i0xWVeX6Ip?=
 =?us-ascii?Q?OnY1kQHjOn4OuuALhK1I/5O42/Y0sSihvRbNuzkmlVoHQFqqfI+BOzAk5vpA?=
 =?us-ascii?Q?JmHu/TWxHXG9TmzdIIcCX2fCEGaV5TnGjeIHq6SFcKSedq6EsRTA7DBcypcq?=
 =?us-ascii?Q?kO1+wXeTSRJKL5NvDmpC67ROI0PbSqkbxvFMMDPqRTZeoMF2L8n2eq30AC1V?=
 =?us-ascii?Q?Yp8Ny+0OjFyBsmRbighupKXGWZWuYRPLiqnlyLWsF27wsxJiYiwh2b4jWkcv?=
 =?us-ascii?Q?4JcWPagsStxrfBRAH7HUOsZjoXj/M5DFhlycNIHqAeYkZgfKQ5kpBUSTCKU+?=
 =?us-ascii?Q?OTzqQgqghR3VFAGJI2xwG+pwqbivlVl990ypIPFZgE2hEGeNVpFezYV3V/Dx?=
 =?us-ascii?Q?bgK5VWeZFiJ0vLp1QV6ovz0ELBedEMVE9G9D6HHSR1Gj/5wUwipCggRzx/eG?=
 =?us-ascii?Q?b/Uai4oo6SXtirayEnGksQYvBkpu6L31xGIoTO3bL0T4xMtSUwWbBRe4yTDx?=
 =?us-ascii?Q?Du7prbHIh/pMs17ZxePeZoxm7pz1rD0V5VGtUNfVAvxDgX7fL9e2gFR1o/BV?=
 =?us-ascii?Q?ANnh9MKirsBUepAJnEKHxVujDTUyeCyVGeEKrCFdqC5ST8P1nS7iMv85bPT3?=
 =?us-ascii?Q?qkE6AWumWLxbXTILt+nvEAVyqVdvdXWzfNyO1BoOLcaui8hLQMHBJynfLi+2?=
 =?us-ascii?Q?l7HrmmtYHBqSV1baHIB/HepNXUSWR/gVbKD+ObGGFeb5E4h9OBBx2fxSG1s9?=
 =?us-ascii?Q?b3q9KZ6d6Qqq481fesFymPJP/eoQ2N/qwNOR0OP7m4V+Q7u7vvQXoStbe5Z9?=
 =?us-ascii?Q?N7r5/bprgAsvF2+3MwxvH032pYujOvlK8HI1zGWQ/bqVUYGtpxSebvDGSKvG?=
 =?us-ascii?Q?cKU92+5EYX4Y4TfZqjfuu+wBUf8V0Z4q1YeDBnDurXwb8OUQdUbUo1nD06Wh?=
 =?us-ascii?Q?YyPWFR0fPc0vFdsdHqeFqT2fQZUehEfV7ZTQbaIAy6fJpoiCdfF+utcKS0Vl?=
 =?us-ascii?Q?pK1OJKpI19n36SG9tnFSi5IXTJh4b3nHujIC4K2a9x0cCs4+93x2wmmhkr0x?=
 =?us-ascii?Q?YLN8f/vir+/sMB68Zf8xNj6Dk17BeR5beW2S+jOmTxNL2UJnZiCAKtnvixOl?=
 =?us-ascii?Q?FvTE/SlqTcOkyV6u98AfJRh8yaRw4sBGncvtpusTR/89eaq8V6ApG2DiDfUw?=
 =?us-ascii?Q?NWWZztbrAT2qz5+r5HmD+tjbJUtKErRX5FOWF6vG9HFMQ0g6GUDE1u1Zy3F9?=
 =?us-ascii?Q?VyAf686zDoJTLPs14aJPf46MchkP3B9y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 08:01:35.9774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a781459-1eee-43a1-4970-08dcb2002a5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5938
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

There is no reason to use goto and just call return. Better is to call
return directly which is done for some if/else parts.

Also make no sense to setup ret to -ETIMEDOUT and then to 0.
Return timeout directly.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/i2c/muxes/i2c-arb-gpio-challenge.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
index a83d7cb0829d..3d2ce0ca705d 100644
--- a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
+++ b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
@@ -54,7 +54,7 @@ int i2c_arbitrator_select(struct udevice *mux, struct udevice *bus,
 		/* Indicate that we want to claim the bus */
 		ret = dm_gpio_set_value(&priv->ap_claim, 1);
 		if (ret)
-			goto err;
+			return ret;
 		udelay(priv->slew_delay_us);
 
 		/* Wait for the EC to release it */
@@ -62,7 +62,7 @@ int i2c_arbitrator_select(struct udevice *mux, struct udevice *bus,
 		while (get_timer(start_retry) < priv->wait_retry_ms) {
 			ret = dm_gpio_get_value(&priv->ec_claim);
 			if (ret < 0) {
-				goto err;
+				return ret;
 			} else if (!ret) {
 				/* We got it, so return */
 				return 0;
@@ -75,17 +75,14 @@ int i2c_arbitrator_select(struct udevice *mux, struct udevice *bus,
 		/* It didn't release, so give up, wait, and try again */
 		ret = dm_gpio_set_value(&priv->ap_claim, 0);
 		if (ret)
-			goto err;
+			return ret;
 
 		mdelay(priv->wait_retry_ms);
 	} while (get_timer(start) < priv->wait_free_ms);
 
 	/* Give up, release our claim */
 	printf("I2C: Could not claim bus, timeout %lu\n", get_timer(start));
-	ret = -ETIMEDOUT;
-	ret = 0;
-err:
-	return ret;
+	return -ETIMEDOUT;
 }
 
 static int i2c_arbitrator_probe(struct udevice *dev)
-- 
2.43.0

