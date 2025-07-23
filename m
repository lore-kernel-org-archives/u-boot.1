Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B6DC83F1A
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 09:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ECB182E34;
	Wed, 23 Jul 2025 11:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A3Q/04/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0365982D21; Wed, 23 Jul 2025 11:07:12 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0D3483429
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 11:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2/rexdac+wVDcRQUGbB/w4R/dtyeNJnCoXtSJcBwgs82JlQ61ImPkl8RhGYoyM3Vwsry6wJPSO9/fOmWsUKD9Xq5Zbr79R9Nzhjga7RvGzrQH/ZY88GOzDHnA9lhcwQKlkBfR1Vxd8xagGSoZhLfU4JULmO8j8fymmn9Lqdbn6betrE26g/MO3dyjjB1HhYZ/wZkBmSh4VYmvOgfH6ud8ftUrK9HDU4PxT1gjXYiykVBTS1jD9Jva3TtP7ddmAmu8i3MjuuH6H0J/NeKL/DXl3hCKQPdAYTWDTgbzwfk03mhHX/1NObl5xmgnIHMLcC704zyRbRfZ9yBT6qBGBblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rep1gSyEWK67i6//r0KXq3lPa1axRrDSg1MreeVi6yI=;
 b=DdPVKRRLm7gRrSodSg11+zi+oHnSRF1VSAa8+PjUv/y7SmJuuPiRrF0M6xEixaK/DfU+NKn3UnAuIdmQfadsR8tggFB77QcFwaJpTRElo5suTQ32+NRpDft0XQeI/y7GGx+3Z9UAAgg1rO9CEpMr5F3ng+ySzAJzM4uBj97f9Lld4xb7gEpS02Ptj6iio74FwnGfIRuLs4lOU9tEFd95bHsvasYrjUSNd0E9yHRmXiQ1StlxA8URI7wf8lkSzhnw79gJ2eAy3hBqVhdG7KLxHx51IdXRBJd9Q1gvxl5qIPCpvx9M+iAwmaNwLyeq2t3GflmfFnkIEHym3J5DGwBh3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rep1gSyEWK67i6//r0KXq3lPa1axRrDSg1MreeVi6yI=;
 b=A3Q/04/WvLD8ojxd9nYHODjgpccwa3zyKMn7IvpH1B0C6OcdM0iD6Ko6D1zGaD64ak2K3INC3msRdryUJ9zoCnEXZIBVVaa/7aKy8NWlKsScW6HLelytPrKXLA4WJqNfBQUivCPWdHDy3hBvydpI/IKPDIX8qf1A1yDaQ6s62GU=
Received: from CH0PR04CA0045.namprd04.prod.outlook.com (2603:10b6:610:77::20)
 by IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 09:07:06 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:610:77:cafe::67) by CH0PR04CA0045.outlook.office365.com
 (2603:10b6:610:77::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Wed,
 23 Jul 2025 09:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 09:07:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 04:06:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 04:06:57 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 23 Jul 2025 04:06:57 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] serial: uartlite: Add support for OF_PLATDATA
Date: Wed, 23 Jul 2025 11:06:47 +0200
Message-ID: <b494dbad529e919d33977b8ea6e6dbcd14e78907.1753261604.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8d32af596f80a2220d9f5d7fb98476e6d2b5f303.1753261604.git.michal.simek@amd.com>
References: <8d32af596f80a2220d9f5d7fb98476e6d2b5f303.1753261604.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2436; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=40aTw82QG5xc2XUxTKqgVJ95/B8G5TvHuTN08ys3Ufw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ0LNPuMuPyf3xow8te/RS3Fe99WY6mHf1yyWDD8e7bZ
 2yfvF2Y2FHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQAT+fCLkeGWudQZOwXjo8kN
 6zOaD367evpa1LkHzxUk/DZ9cU78zVvE8D9y8vY/hwwfFglwOHyS0DKYZqF2ZLpMTELtqqzo3Vu
 OMLMDAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|IA0PR12MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 5082238f-0e1c-4579-52b8-08ddc9c84c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eDNzGGUQsCymh47uO561wcedVcmi+nAWUBVhIRnrD3ebCFIC1HwZXCdNQXVP?=
 =?us-ascii?Q?IUt762Bq2dgzin6yZeLYzZLyrOJ641MR1MTE3HnsbDC9U6WZTWCIEjKiSyt7?=
 =?us-ascii?Q?iUI8TWZMGakHCExIRjk9aa68CviVHH4f7BkJFPkSSQNFS26qst58NGfASeES?=
 =?us-ascii?Q?I9/6E3vk8J29zEsCHhBdbLraRJABqBoXh7oToLRbA1BpNvVUbqjcqQ/I0Fdi?=
 =?us-ascii?Q?wcU9sQBhcV2/EcOD0zjaPspLYLUrXU9K4xfEj6TLUcBh413DkIGGhEWRt1Wl?=
 =?us-ascii?Q?9NmY4vpu/c6INdelqMMKuxgglNfL6KrPYyP1551OAiZoJQDrpuhcY/rDHh/S?=
 =?us-ascii?Q?5LpV0CCi0e0xcLe+BYkFZKyBKZBLky8edisXRcve2S6biwftOKQhOhXeWZXG?=
 =?us-ascii?Q?W/v/ad6UzpaokplYlQDuqxVwNmjSxvjyKctHk77Ed5Htf0T/PfqZcaJDgNUZ?=
 =?us-ascii?Q?93KKiVwNQdPlsy0SaE3DwNlfLK++f3uASbrwOuHT0jktB9Xh12lETYlfzrMQ?=
 =?us-ascii?Q?T47Ha5ygmqCeUtIrrGn19jlJoGbaSX0Wot5/Is9SHWeXE5FkR4XL5PSTBoWS?=
 =?us-ascii?Q?40L/HIjHQFJPn6wqO4k9AT/0HBNKGdvillRMzF6dCVCQU5YUvBHDd4jP0eUN?=
 =?us-ascii?Q?TLpr6VO5Y6XeRKA++OFSrRnTBuVsV9/elRj5umcMdLjVCBm5s15UajD/oak0?=
 =?us-ascii?Q?MLtfXAYoGq273uo/BY3oyz3I3/tkHMtAxLslvEnhjq5rFvyFPHUUHYAU+Wpm?=
 =?us-ascii?Q?OPirFOvbyLGy4Eu3ih8vP4U3t/Vdt1GU3BhVZyyfzmpYeDuxomvP44L0uhNi?=
 =?us-ascii?Q?j58LTTaBnIF2MLlomOfUp5yqaCzbFETJwSXPwRavq/1S8JsawjbtnU9ymrdX?=
 =?us-ascii?Q?QwPWg9jp3X/+Nv8eqrx4lJAtKQk9kirRHb7W5qytTjJY7MeMp3zkiLzjA9WN?=
 =?us-ascii?Q?4WnU47uFt7WyfqeaRe7ymu5sUkORFv1IRZrvcaQZMwlfTig3a7pCmR7nPNET?=
 =?us-ascii?Q?XPLlRhRdnTLKhQYGVzntDNSBse5f80Np4b0uEaeItHzfPg6uZkQJbfLpDJvg?=
 =?us-ascii?Q?8AQSp8QiHwr4NmknJ3RAJB4Z2J6eQTrE1soWIpeF06mUcq2al791Y1z82Fji?=
 =?us-ascii?Q?QRYITINu2RPqGGOQ5NVIlZ05ngbVUjQKWH62eivfU/EM/HUnbhq0P3/u3IQM?=
 =?us-ascii?Q?4qWp8VdlliU0LBeY30tKqUT29gSHkqfdFVkdPICGYMBVARRwebbnWRbsUgeT?=
 =?us-ascii?Q?ksxFhZgkYM04cnbNKldv05ZYZiDBXtw2H47G9yk+b0DPamubGOpH8FGxc36I?=
 =?us-ascii?Q?4ixS5aCvbfw8ga1k6XVeEvktI+cQGRchP5ppCw+tK5qCZZdbFYoK9M2XHU0q?=
 =?us-ascii?Q?vnRZI7h0hLXz489uBFaLgOn1KP5EXADSZt1Xk+LQ6HOIDERmsf2MSLp+9V3r?=
 =?us-ascii?Q?v38/r2Igm/YwW4NdvPAGVu5CBWeqxfU/REMcuaRtIuKvm3P/cHnpANZlQC5j?=
 =?us-ascii?Q?f3+DPeO4Dtlw0L+Yt9dsLA9OKbmpblayGaTr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 09:07:06.3686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5082238f-0e1c-4579-52b8-08ddc9c84c22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7675
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

The first change is to list DM_DRIVER_ALIAS for compatible string to be
able to match the driver. Only xps one is listed because opb one is likely
unused for quite a long time.

The second change is to add dtplat structure to plat data and fill register
base in probe.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/serial/serial_xuartlite.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/serial_xuartlite.c b/drivers/serial/serial_xuartlite.c
index 00155aba5eb2..6bfd0e085e87 100644
--- a/drivers/serial/serial_xuartlite.c
+++ b/drivers/serial/serial_xuartlite.c
@@ -32,7 +32,11 @@ struct uartlite {
 };
 
 struct uartlite_plat {
+#if CONFIG_IS_ENABLED(OF_PLATDATA)
+	struct dtd_serial_uartlite dtplat;
+#else
 	struct uartlite *regs;
+#endif
 };
 
 struct uartlite_priv {
@@ -94,9 +98,16 @@ static int uartlite_serial_probe(struct udevice *dev)
 {
 	struct uartlite_plat *plat = dev_get_plat(dev);
 	struct uartlite_priv *priv = dev_get_priv(dev);
-	struct uartlite *regs = plat->regs;
+	struct uartlite *regs;
 	int ret;
 
+#if CONFIG_IS_ENABLED(OF_PLATDATA)
+	struct dtd_serial_uartlite *dtplat = &plat->dtplat;
+
+	regs = (struct uartlite *)dtplat->reg[0];
+#else
+	regs = plat->regs;
+#endif
 	priv->regs = regs;
 
 	uart_out32(&regs->control, 0);
@@ -112,6 +123,7 @@ static int uartlite_serial_probe(struct udevice *dev)
 	return 0;
 }
 
+#if !CONFIG_IS_ENABLED(OF_PLATDATA)
 static int uartlite_serial_of_to_plat(struct udevice *dev)
 {
 	struct uartlite_plat *plat = dev_get_plat(dev);
@@ -120,6 +132,7 @@ static int uartlite_serial_of_to_plat(struct udevice *dev)
 
 	return 0;
 }
+#endif
 
 static const struct dm_serial_ops uartlite_serial_ops = {
 	.putc = uartlite_serial_putc,
@@ -137,13 +150,17 @@ U_BOOT_DRIVER(serial_uartlite) = {
 	.name	= "serial_uartlite",
 	.id	= UCLASS_SERIAL,
 	.of_match = uartlite_serial_ids,
+#if !CONFIG_IS_ENABLED(OF_PLATDATA)
 	.of_to_plat = uartlite_serial_of_to_plat,
+#endif
 	.priv_auto	= sizeof(struct uartlite_priv),
 	.plat_auto	= sizeof(struct uartlite_plat),
 	.probe = uartlite_serial_probe,
 	.ops	= &uartlite_serial_ops,
 };
 
+DM_DRIVER_ALIAS(serial_uartlite, xlnx_xps_uartlite_1_00_a)
+
 #ifdef CONFIG_DEBUG_UART_UARTLITE
 
 #include <debug_uart.h>
-- 
2.43.0

base-commit: 877984a9b68bac862cca6f2d8885947a48e6fd50
