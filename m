Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C566C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 09:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C60D9807C4;
	Fri, 21 Feb 2025 10:57:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wFCiKRf3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD17F806FE; Fri, 21 Feb 2025 10:57:50 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44BEF8007D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 10:57:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2PcJdqYnM0oglgkIQNu0cXDSh0kqbsJblR9GK4ivjCigIqyHjXQi6myA1reZgxRjkz8U2C2FuNMJGX9OU1t1sSPnA9UN3FsmEPIKem+KGYOG/1ZVXAgG1XZ8DJYUmNxtkYy4mRvLFe11W/ps9s+rbiybaHhAQNKGfctiTfUCLGAx6mIXPHb7xvHrLLBoBG8EGX4pj4F3AJW0NFuekVmyV31yFemp9UwD0wqAuI5FJP3bB69yq+9YU8i9mZBX5s0O1jEtYL5C8BSJzFiIj8dhoLtp4DfZ1Acy0K/NxLJcHNp5Q3u/RgQSuBWnnVdgw0qkPrHFHzuODFlP7brSIAeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwITRNH0CgMvmoTS47ojE9Xoijf8q16RcmQdLU6PFnM=;
 b=hxulZTOfFsytvrXiaf1AO4jdiC5oTJyFB9e/N70TtpNoumLuZrWS4oONGe5ANgyXwWm6x0lcon1D67ZyXhmtPgWBN1MfDmYMsB2KVccsiGPPA04V+lESIVkyg1uSUTlxWo+pFAYCQ39jIDQVypdVS6e4amIf7+csg6/etrx75b6JS/eYDNsU7iE2fgw1cLc7f6JGu1FwK4Wm6BU2nlauCHuyNAbXlhb3CNkEiE4RdddHqhYhVzcEsI67O5653dB7VmxELcs2Um2aFtCNNcpAZqHllpHmWC4s7BXftUuwrrT6W5VYPjInFl0JcfnjK54ezCjGoGx6g3abYDsyArp91g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwITRNH0CgMvmoTS47ojE9Xoijf8q16RcmQdLU6PFnM=;
 b=wFCiKRf31nNRVNF+UExUyoL/rDuTHg3hMyLCwFhwGxtBpkNtdir1rZ3hb9KBTLZ2CNPbfEl9GjjY9yc164Nz7iC0InYObHZryY721uPziZ4qQYEdD/VH8SNk4VC6LCbp8z+ZHo3CW3+y5sPISC5l6TeEyY4frv9TNGM7a2qRxKA=
Received: from SJ0PR13CA0158.namprd13.prod.outlook.com (2603:10b6:a03:2c7::13)
 by CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 09:57:42 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::a1) by SJ0PR13CA0158.outlook.office365.com
 (2603:10b6:a03:2c7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Fri,
 21 Feb 2025 09:57:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 09:57:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 03:57:40 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 03:57:39 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 21 Feb 2025 03:57:34 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>, <tudor.ambarus@linaro.org>, <j-humphreys@ti.com>, 
 <marex@denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <Takahiro.Kuwano@infineon.com>,
 <p-mantena@ti.com>, <git@amd.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [UBOOT PATCH] spi: spi-uclass: Fix reduced read speed when parallel
 config is enabled
Date: Fri, 21 Feb 2025 15:27:22 +0530
Message-ID: <20250221095722.1932812-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|CH2PR12MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ccf5d6-169c-4872-cdb0-08dd525e2ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ikN2R/PLb9c1uUk6iKeKU5QRRhnHVeq2B0erxii3O3eNidBqE7kcngOb5ZI+?=
 =?us-ascii?Q?4crSmDXfQWtJd1ylUP8Wen7fSYpiKJNrakwixBEd241yDEX1eey5AZGXrd0s?=
 =?us-ascii?Q?/6Szs+zi9j2xq6aV0Ii2yP4FJ3Qkz7O5HjFtTGt50PZlxeZaLHd5FJbaFd6z?=
 =?us-ascii?Q?zi8gru7g9700F9p0YF2OuGD3nB23xcISfDPT15Wgu/8boQt0nx6x5FofnhU9?=
 =?us-ascii?Q?KrOiRDR7aTcbUpNzM7L2ltY45sU2U0VUwrdQMekoJu5q7ksoLjpeNUxbsSv7?=
 =?us-ascii?Q?rkjq5NfvaJ/rwEARzE0SiviYZQuPRW+ueoRsqBJaj78dfZIGOcynT1uO8clo?=
 =?us-ascii?Q?MyUvyaVwr0llML7HlTKmYCKqGUpdtl1hG55RLtYLiteuU7EDS2fmMYBvAFR0?=
 =?us-ascii?Q?yce9/6WYgJCUXBfUeiY8hdY9c5Paf2u6DnH/SUy5j1BLbHHTvziFBZ+k9d81?=
 =?us-ascii?Q?JJdG50f854CEDi1bPb+vJT0YKMF58aiSnbLc3cK7H5zxKYnK3h8mT07dZP4V?=
 =?us-ascii?Q?MjZpT9eBpWclYyPirPeArlJzXQ0qkjs8o85XcKYC68P3cBhJiD0+Hgef3bJn?=
 =?us-ascii?Q?e+nROUp5qAiftFywso3f5FVXfCKQm8PjREjho2Ju9h3OWCNu4R7QDQOD5rPQ?=
 =?us-ascii?Q?MUwEbhUfsGoN7uWkUy4JetSuhDZnLmzXu/oMjUI3AtI90qQDjvSo65/rxmA5?=
 =?us-ascii?Q?siAc7ioEcNjbLge0GtxrlDEoBqXJAH0NaEc2p0bRrWidX1FO7AFuc+PD9r+Z?=
 =?us-ascii?Q?Hpy89MfI+4hrMPITxo3jL8VEmrgJhqJRAQIG9D52FYX4IMvL5mhBIp/4lA1q?=
 =?us-ascii?Q?Jl8qrSK1QPzStH/l9aKX9hr8K0A2Qm3IBHEX6gWRfRWBlXEGc5YIpvs6ZQzn?=
 =?us-ascii?Q?0jJxin2ziWM3+NJpAYpsXseo3YpPTV8hDlYu/yqiM2uz/3lasgte8riUNxU7?=
 =?us-ascii?Q?Rr2SmJ5j1Ql3Zb9rbNpRto509XGt46gwuXU7KHTiz1mMSGsaLDA/BZLTrnoR?=
 =?us-ascii?Q?3xOvVJV+QdPCvG7MaR0fszljUJlKGUchwH35lhverzDJlDYStL4T+hwxV+vg?=
 =?us-ascii?Q?J8TtDdDAJQ11t8IH98ncFq+jmyIWPD2YfC68lJrne+85quZJAE2u5wqBc4Ix?=
 =?us-ascii?Q?V5osTfKIr+6uFlQvexEUka59/rEoPq/97d3uxPnp5rRyK/UICL4sl0TIgwlt?=
 =?us-ascii?Q?nID6XU7TQAZ3OxiVH6pzLLzhrBK32uiYC6oRchRwwdCuZjjwq2wejTgX9TqE?=
 =?us-ascii?Q?pim+Bd2zPoFmO9xcR34mhSEboQCULT/muSWjhsavCMUF+7+rlc/urMrnqX0H?=
 =?us-ascii?Q?xSpuvvNLPEpmDiDL7v0PKQrDDlgzbLkqtSr/wHGDvsu5L3zpN334u6bYRRbZ?=
 =?us-ascii?Q?p9jwHFYZZaGDWpjGQQosAe15NaUxUgT1IdbW8mR+/HJMu6gm8kz89NqTEVIq?=
 =?us-ascii?Q?oGobc8pfOIKSdPlu5O+utQvLshcDw21Hp6L5U02iOTUkYPOhQCQmywfrqh3T?=
 =?us-ascii?Q?3f2IxZ+t0UodFys=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:57:42.3024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ccf5d6-169c-4872-cdb0-08dd525e2ef5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310
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

From: Prasad Kummari <prasad.kummari@amd.com>

When SPI_STACKED_PARALLEL is enabled, the chip selects properties
are read from the device tree using the reg property and stored in
the plat->cs[] array. However, the function dev_read_u32_array()
returns zero, causing the execution to enter the else block, print
an error message, and return. As a result, the spi-max-frequency
property is not read from the device tree, resulting in the use
of the default frequency SPI_DEFAULT_SPEED_HZ (100,000). This leads
to a lower spi->speed, reducing QSPI DMA read performance.

To address this issue, an additional condition has been added to
check the return value of reg. If it is nonzero, the function prints
an error message and returns. Otherwise, it proceeds to read the
spi-max-frequency property from the device tree.

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/spi/spi-uclass.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index d6049753740..a7783b6b6dd 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -523,8 +523,10 @@ int spi_slave_of_to_plat(struct udevice *dev, struct dm_spi_slave_plat *plat)
 	if (ret == -EOVERFLOW || ret == -FDT_ERR_BADLAYOUT) {
 		dev_read_u32(dev, "reg", &plat->cs[0]);
 	} else {
-		dev_err(dev, "has no valid 'reg' property (%d)\n", ret);
-		return ret;
+		if (ret) {
+			dev_err(dev, "has no valid 'reg' property (%d)\n", ret);
+			return ret;
+		}
 	}
 #else
 	plat->cs[0] = dev_read_u32_default(dev, "reg", -1);
-- 
2.25.1

