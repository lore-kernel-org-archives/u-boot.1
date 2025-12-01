Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48062D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 11:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C71CD83B0D;
	Mon,  1 Dec 2025 12:01:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ltsBv+m3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 643E083B23; Mon,  1 Dec 2025 12:01:27 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7B3B83AAC
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 12:01:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXXUlS4U4K+Pt9EaM9RueFnhVZQYecqYQEOzMxa2L5xYYFbFMIqx2vUzsiWnPq2KPU13JSM22lnddVNtomiqciTBZqZwV0oEPFh2xKWi1kcmQWHErynJaJ5ad0zzPXMdj8xoLXXRsL4LeBU349cjac7NpGGVkOjvjw8wj7ysDRJLGf0z4MkGYvGuD84NUaBS2CwW5YBkdEaa6pKOaAuK5dt0YswHItoj9ZePLniWqksEkYFNqr5bvr5J25UYBMtrSKTPfAB/vMhk2BUxsRHpEWgnaI7I/fHpjsKzRGs3C3SF4mwnhjmj4rIqNTl49EiJlEsBgOpQi87cl9nyUUe6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEjduVtwc5IbwSDtH/knqXc7tHOMOGqqzzpN0JIJ+zE=;
 b=ABzwcn2rkUD1/yn9cnLXgHeVY6gRs7YC3iB6zBaINhKTx0kHE7bF6PLFuZG2M1zfaJVj8S4V0rMAG5FWGsV4d9EMlDF4B1X7QAtaGegAM4iGzubIcNNuUtYa8k4n+gIaIRZWFLFxM+j2171Uw8mg6MH0GW5hssCjLslIGfAMsTkFGfXOyfQyAqSl4mQVvWryVgOh3wQOrFx5dkQeX7psM3ngWHPoJa38QH8sWjfBROb96fNQ9tARTaZ3biEfuXhvP8aQvenSTjU3GnJYyb+LFNM5MfsKZglImdBUZTsjRpd8mm2DJhYJpGyBqhCdQcaoZmmC+nLrjwKzj9KeiD/KUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEjduVtwc5IbwSDtH/knqXc7tHOMOGqqzzpN0JIJ+zE=;
 b=ltsBv+m3v79LgoPNTaWEcxGvTfFlGVdNkIQ6/xvS1L5SVDp/CO7XJA8xpWEIaOUnMSyaslt1ky3mX3O74RNKBpH0Ab5uT0bFQw7wKVo4BUtGN5r1vNvEjczpiASI/fh8daR48TE266KgKLJvIgKs+j9++bPaIt4I1QD66CV/gio=
Received: from DM6PR10CA0006.namprd10.prod.outlook.com (2603:10b6:5:60::19) by
 PH3PPFDB63D4CC3.namprd10.prod.outlook.com (2603:10b6:518:1::7cc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 11:01:21 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:60:cafe::51) by DM6PR10CA0006.outlook.office365.com
 (2603:10b6:5:60::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 11:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 11:01:20 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:19 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:18 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 05:01:18 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1B14qZ306512;
 Mon, 1 Dec 2025 05:01:13 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <m-chawdhry@ti.com>,
 <c-vankar@ti.com>, <u-kumar1@ti.com>, <j-keerthy@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>, <jm@ti.com>,
 <anshuld@ti.com>, <s-vadapalli@ti.com>, <ahalaney@redhat.com>,
 <semen.protsenko@linaro.org>, <mkorpershoek@kernel.org>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v4 02/10] phy: cadence: Add config to enable Cadence Torrent
 PHY at SPL stage
Date: Mon, 1 Dec 2025 16:30:55 +0530
Message-ID: <20251201110103.845413-3-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201110103.845413-1-h-salunke@ti.com>
References: <20251201110103.845413-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|PH3PPFDB63D4CC3:EE_
X-MS-Office365-Filtering-Correlation-Id: 166dc127-9e20-41c8-f634-08de30c8f576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0SYcTvcabDc4b5STvq7cLhl1BfgNPb495HHWyGEDxi3/HfNZdj6NuUkvhvFN?=
 =?us-ascii?Q?pU8M1zrPkAQoTSXIFiert5CQIK+DuIfwdnK1tfvFGdEruSM16dAyoHX3UrXp?=
 =?us-ascii?Q?OLou/3hotFqq9NGNDWROxrlK834Pjpc6chwFDipmahWl8KIPtajhwG04qXiz?=
 =?us-ascii?Q?7y5jQgA2QS34CABYTC3dmGHdnj25E+We0a1vV3dUsk1V6aI8PvM8wGvnWCVi?=
 =?us-ascii?Q?Z6Bl9lQ5saRfyvyDUxqe+qkCpt8EDF7+4q30vmSgzdXhGxke5BrKm6BcuiuK?=
 =?us-ascii?Q?G5/jstUX8YZ66dmTS5rqS03xI/73o4J5J1LUQD3zuwlurddrljkdBp00aBXI?=
 =?us-ascii?Q?DQISs00vx5jc+6JByw4Gno77BdkgtF0IrIvbbDpyJBwWg8XStUM2Rr5QZpgD?=
 =?us-ascii?Q?on/7yvZ8Ks5llBjCG4scbMdsDFO3+fEsebi2ho4R8d7myDypG8qTyGUa836B?=
 =?us-ascii?Q?f10S7jxqDefkjALjHBU5U1cDWAIYFamZuUX/JcFHlI1mDxKuJP9kIINe2+eV?=
 =?us-ascii?Q?v3CL9BP+TYhGjFHzckK1wADrsFyt6LMoAP28pRvqV1FKdAlPcz79JBhVCvcu?=
 =?us-ascii?Q?UWzKJi4TaGgJnGcAhEwHXBO+mWqXa53jRILRWNleuavlhvruzsPyZjdDxP4P?=
 =?us-ascii?Q?JsBq6k/Ol4R1oYouII7i/i6+pF8xzMP28BKfkgkxfR6i5WgFgWVTsrM97hBK?=
 =?us-ascii?Q?5JYdYn9/SYICyOfkc6E0HQFQrAFFlQmpxtG2nadB36DZAOUiM17BHOdV03Eo?=
 =?us-ascii?Q?g3uhixSUTWjFLh/uyq/jcWdXh4PHEriuh+mvXfC4m2usx560lUj6cLGgmeP9?=
 =?us-ascii?Q?3r4ZuYMp+nL++lQLENcPBI1b4Lqu72puE6Ahk/7oPRuTSWsetqvoohb35oq5?=
 =?us-ascii?Q?IXMSf0knK0sQTxJyi99CQHi5lG/G3kLVU6st7YMW8LaZz4bkMMztgO5ZbkvD?=
 =?us-ascii?Q?X5MirIDqWRumERPy+zHSOlsU//B90asBuIKMbXtVIAvU2nJpFJu04LQffqNz?=
 =?us-ascii?Q?fzxdnjpiLV/G83KP9wga6RgPOtivP7b89Vy4+M5dLKi4Pzv+DkdFOo3+UcZL?=
 =?us-ascii?Q?RiBsTT7hKDIcZUYyNLBxNSJ2+Gikkx7SmgQlGPsUMTCv9ewDzmi/W7unSRqj?=
 =?us-ascii?Q?Zr303SAUEw2r7DOrREVw+VPidN3PnrtWvOa4kjyIWo1JaKgTAM4Gt0BXNOPD?=
 =?us-ascii?Q?A5yetXo9FBGykZPdO4QRMFyFHrxrHkRV4cRsCywATJ94Y8oOie8vt2OEmb5I?=
 =?us-ascii?Q?wyPLACITbpaLjlfYvM0GGSOQkGi8ZY8HYWV54E2yKeERaXPP7DYojVuEpd/E?=
 =?us-ascii?Q?bg7iFpApCsMsodnBvvNIbc4UD5SaEKGsppynoa16WqBeQ3zCDsvnrJ7CUYV+?=
 =?us-ascii?Q?/j+kjohk+29mp69wU2qWblm0596fugZwxZVZJQTCilY6PSNQCXFwKkPbwC/L?=
 =?us-ascii?Q?+MC3GLHM67BEcBKz0kfVuGYn+bCE63T94gS/S7XA+QioDezPQirPklQ6aPhc?=
 =?us-ascii?Q?iplToTR7283LFruXK/5ClHNDDr6B31P/2eTFr75fmm8yU4ifFKfffAeY1qst?=
 =?us-ascii?Q?00q2XaPAJpxVqIuKg5KvAu4qXXbL7wBpmuRPfSyR?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 11:01:20.2200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 166dc127-9e20-41c8-f634-08de30c8f576
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFDB63D4CC3
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

Add SPL_PHY_CADENCE_TORRENT configuration option to enable the Cadence
Torrent PHY driver in SPL stage. This is required for PCIe boot support
where SERDES configuration must be done early in the boot sequence
before loading bootloader image over PCIe.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 drivers/phy/cadence/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
index 549ddbf5046..8c0ab80fbbc 100644
--- a/drivers/phy/cadence/Kconfig
+++ b/drivers/phy/cadence/Kconfig
@@ -9,3 +9,10 @@ config PHY_CADENCE_TORRENT
 	depends on DM_RESET
 	help
 	  Enable this to support the Cadence Torrent PHY driver
+
+config SPL_PHY_CADENCE_TORRENT
+	bool "Cadence Torrent PHY Driver"
+	depends on SPL_DM_RESET
+	help
+	  Enable this to support the Cadence Torrent PHY driver at SPL
+	  stage.
-- 
2.34.1

