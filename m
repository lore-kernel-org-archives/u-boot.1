Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F71D3C924
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 15:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 012528389A;
	Wed, 10 Dec 2025 16:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mvR9z0ak";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA79583A71; Wed, 10 Dec 2025 16:48:58 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 694CC83CAA
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 16:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0VDBoRjVmp2T7IKFqB7wsB0XmHkcldB7vPNl//aHS5O3MVhPPhlWIGzIYsfy4m5AghO31LpZ3F9EqWECK7kmfKCKmzdxbUmhvbsec5Zccy5dJ4fN7dUEGaf8a8rl4TgOeJkBHCDFnct/9zJyV9itj4shG2rjk/HXSnnhLBu6s3fqdLmvvdzv3X6lxBhpFtirA0j0RARSR1HvdFrP4KBRnYVM6FC68PdzImSPjtBlCexSrbzoOsSBOVdkRRfJhPO+1H+kAZTx3e7isqITXJnivcMbTEI1IUnZidPBkvN2RIlaI0RlQQ3dBvGnFr1sEYSCGh8qdQkVZS/CdJhKJ2FFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgOqjP5o2aA8ueTUiVpftIY3SNAL/HChobPqMiY0hkA=;
 b=vxdhAlEukxMspBbchOsqK4TvhMwVs2OgOtRd4GbOYVtVOG4AooDYjc8LkYUZWWT18wPB4bp3iMghH+pFMxP1Jztd5D0IkdoBdeoT8JmKdoA+OWgCVUeJQ1NP5BLKLw8TsV5OFkQJxXXtcNcM1umJNvMm4DlglZKBGvw07lVPhCctHUbp7Uz3XkUl6VB8L5efETNK02vBryG5kpbJuzL9+PpXinkxcppuZ0E8NBegtlFKCzFFzFuTce1woLjSoB3EbShj2ORMgRmRC/Re68F0xibrXbXG89ND53Vev4lF1+dLdsPQcrmvasnOMR9hqtXWFHdAWrwwUsE3mtWITbultQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgOqjP5o2aA8ueTUiVpftIY3SNAL/HChobPqMiY0hkA=;
 b=mvR9z0akpZJe82Ei4VTMV4r7W8Aw1x9UYe1OJBoxtiHWa5KD97Xg9j1aojeT4jVr5K1RaD3E374TguQ6yEUpHhfECKxeREjUrsMi3sDwtT4lx3TyxfIzn9ueK14i38rTKrBBhx26nw6CMXZ9duR/PQYM52e9DEHzVa60v6PtfJQ=
Received: from SA9PR13CA0174.namprd13.prod.outlook.com (2603:10b6:806:28::29)
 by CH3PR10MB6882.namprd10.prod.outlook.com (2603:10b6:610:14e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 15:48:51 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::15) by SA9PR13CA0174.outlook.office365.com
 (2603:10b6:806:28::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Wed,
 10 Dec 2025 15:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 15:48:49 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 09:48:46 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 09:48:46 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Dec 2025 09:48:45 -0600
Received: from uda0271468c.dhcp.ti.com (uda0271468c.dhcp.ti.com
 [128.247.75.68])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BAFmjrv3199756;
 Wed, 10 Dec 2025 09:48:45 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 3/6] board: ti: am62px: Add basic initialization for 32k
 crystal
Date: Wed, 10 Dec 2025 09:48:41 -0600
Message-ID: <20251210154845.3852231-4-vishalm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210154845.3852231-1-vishalm@ti.com>
References: <20251210154845.3852231-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|CH3PR10MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: d6afde89-77c0-4e9a-23dd-08de38039c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d+WxzZkoCI1UEXg/+D6McOgOnHFG5YVHeSWLv54uPAEdO8COXL5x6cbCAxkP?=
 =?us-ascii?Q?EvmBSgo5aKN0osaVtWcd5z+LxTTwej234N0J5lWE2PpbQ2NoMkitsHq/7+QR?=
 =?us-ascii?Q?czMe8rSvDvUI91PVZzJFH6Yu5Nj/jsR+JKZrdLVup9Aa50t4ndATuthaeAV6?=
 =?us-ascii?Q?UE6uj61EbtWGcMWR49CRjulbUkw6y8M+3EUzbp9r9llyz2hXEhu8fH1IV/Yp?=
 =?us-ascii?Q?UdWyat97aOU9ayQm13ZCeFaicqA6B/N4BsYZ0f2aZTRHLNkR37o3vzUTyqof?=
 =?us-ascii?Q?JjMr9Iqh4xHnqZrUmnXcncan/OmyITY5EvOt2FrC+bC355sq4gzIEHaRQ0XX?=
 =?us-ascii?Q?FIr87VQMrtwJhn13A997DYZWez3fCFb56BNJhE8X4wpLB7+21wAcPVMbU5gI?=
 =?us-ascii?Q?zBtdzzvZmAWrl3UETyNR6cLYe79npo+rwdOIIa9cJ6pQKv6+I07mLttDxriq?=
 =?us-ascii?Q?0nw9KLmNBBu2o3pZrb8d1NHMAykxNonVFIc9kACkR+ZqsM91jfEYRNv2q/E3?=
 =?us-ascii?Q?SpO6uEekhnEkt4VJje7641BY/mVNENPfpVNmQcBEl0l5J4Rp6pzoPjl6iT6q?=
 =?us-ascii?Q?4BpYQc8r6LUI+ZfJGMISuhieSiyKaxUxMJSAaCL2toO7U77beE/iF0PZKo6R?=
 =?us-ascii?Q?ZJnTxqXjXbdJWJdr9PV5UiLc2xovfPIIkPJwO2yDvGF5PUdWA07zTGTGqUL2?=
 =?us-ascii?Q?96sKK+C1tW2/NmA3bHrlku60avCQdRaceXhO3uDoHUItqbAXFudyv1+McfZj?=
 =?us-ascii?Q?WN4lsf7nJO6Xuket5Llb+D3S8CntCwFbksJocjklY5ql3oaSbZxlMYDS3SDP?=
 =?us-ascii?Q?nJMqaydse6APl6uK8QXUKeJ3PJKikw965ilLkqDACXWWwYuPuwKIn9SUEen5?=
 =?us-ascii?Q?Z2TLJjySqhJ8qALK/zwkr7VIZTNKhR7dtQgramUvsXVErfwTD5yieeyyawX0?=
 =?us-ascii?Q?QRzbn6Et+f0mR9lvWJa9f9kSQ9sXGjDjU7uehBGOt8revrkHq7r9D/zmhOdt?=
 =?us-ascii?Q?pgS5fBe0ORpmCwyhIGGfFVMGkbk9d/F2jelYJ3zLx17PFIPUKlXf4QQZPyf/?=
 =?us-ascii?Q?I6/JYPmsdqZwlxT4+vnMY6C+Is+Jo6oSep0s4M8j3J4JN+DwcFQVZC9NYP7S?=
 =?us-ascii?Q?5Bchyh2vFoQ8U95WJ95wpu7aCRWRMtqNKXTgFVw/z70U2OdkMk7UJ3yzifWi?=
 =?us-ascii?Q?Oo8+snjMyYFe8GjKjmuTHoXZHbDB75vohFntgVBUdLyvhCtru+DnNrU7rc1+?=
 =?us-ascii?Q?qE7Lq09isoGFBCWlmQJkNHoabTpBKspSSwVnekeVCgVT9Wnb3rCFCjqIim46?=
 =?us-ascii?Q?EdC3uVANG8PYlybubPo5qTuSLPqUcpnjAnBY2l5c3Um2A6mXfyzA9SQC5Gjl?=
 =?us-ascii?Q?w9KF01wpeTRakca3mISXDkEpJ9UxpsnTdWA7J4ch69h1mIvvpih7pAJa0PyX?=
 =?us-ascii?Q?S6Cq9lq133P46aiRMs+X2cqzQMF4N7Vk70E+3+wh9YhAxmnSU1ND/POFjRr7?=
 =?us-ascii?Q?5CbUqDOIby+qMsCBtBTt1+CL7obOMX3pOgTddL2v3iLP6Jnr8aJevfovnMq8?=
 =?us-ascii?Q?CvfNFb5Sgf51Avu9Euo=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 15:48:49.1962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6afde89-77c0-4e9a-23dd-08de38039c58
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6882
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

Do the basic configuration required for enabling the 32k crystal. If
external 32k source is not used, 32k rc-osc comes into play, which is
accurate to +-20%.

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
---
 board/ti/am62px/evm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
index 85c332b9339..7672d1eb272 100644
--- a/board/ti/am62px/evm.c
+++ b/board/ti/am62px/evm.c
@@ -43,11 +43,24 @@ struct efi_capsule_update_info update_info = {
 };
 
 #if IS_ENABLED(CONFIG_SPL_BUILD)
+#if IS_ENABLED(CONFIG_SPL_BOARD_INIT)
 void spl_board_init(void)
 {
+	u32 val;
+
+	/* We have 32k crystal, so lets enable it */
+	val = readl(MCU_CTRL_LFXOSC_CTRL);
+	val &= ~(MCU_CTRL_LFXOSC_32K_DISABLE_VAL);
+	writel(val, MCU_CTRL_LFXOSC_CTRL);
+	/* Add any TRIM needed for the crystal here.. */
+	/* Make sure to mux up to take the SoC 32k from the crystal */
+	writel(MCU_CTRL_DEVICE_CLKOUT_LFOSC_SELECT_VAL,
+	       MCU_CTRL_DEVICE_CLKOUT_32K_CTRL);
+
 	enable_caches();
 }
 #endif
+#endif
 
 #if defined(CONFIG_XPL_BUILD)
 void spl_perform_board_fixups(struct spl_image_info *spl_image)
-- 
2.34.1

