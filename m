Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612EBD3C925
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 15:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D89B83A71;
	Wed, 10 Dec 2025 16:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KNLyjGJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A403383869; Wed, 10 Dec 2025 16:48:57 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8119F83AEF
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 16:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHeZlMTMk4WOcc5yPwuV+ZvIOkh8Hnr2rJ62Kn8AXek7MZH9WI8R6kkWzQ+ByCAmr0RD2aqDDrwTBQWvgUK1+U2t/rmaJpiqiuLoqop3wSKodM+DonZuSxR4yGHbXrUzVKtnl7RoqO2xpi2Gtisj8qPELLj/LtaKkr3BG17pffrHwINn+Ya7EjP+43uqJpM/8iJPJNrpdi3Nbk8LLQrl+jS5ffnTNAKs8GJ9YvPunagBLlWOzaMmg3vKvUN9x7MTQzQZvpd/qJ+spcQy7NX4d2sPQ1Pq2hzMZ7UQjG2Z42ite3E1N9VaAMxe6SoPAX0cxblmAoqDdCXRLmIixCJCpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/vUo+SMJ41+Y/yBFkGtxF2dQyl/kBpyEoGmMH9cP2c=;
 b=aWndW2ff8UckU9YdJ4O5GAYTvY+n+J7ZXdYd60Q4cj3rlmzXE3WRKg/AdrO4YXuO04cn/DFXlcXubZGvIlq/HKPQMyyXDdHN6cPVinyrsuas22fh+j8KqQ8b931Zse58O1A0Rs5E1oHwJcimH8QLZqpc6fprRqKykQRGsjjFzNrigGzLmiwiGMPilmj0SRX7/8qeviqMTKrqjkuRVJvEXEX2TqeMrOXHBNdGAHZHeSLYd8P4vxYCvx2RpC9UHheOXddnIK3WSMhjWHgl0FSpSFMqBf0R+NrHhi8CSxLQ+BFMnSrAxTgwRmZAmMYCs/otfeGia1HqVKjbmDBe+qxc3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/vUo+SMJ41+Y/yBFkGtxF2dQyl/kBpyEoGmMH9cP2c=;
 b=KNLyjGJ+xLHSVTbkJglYae+rtS9YlvfKAJgxf5mmPvMrvq5NS4rCNCUGtQ5lEV2nt3ORs3fyUMBFPtNIZd0eYj5/OlB3/EKwaZNuSgDHIbCOp67AUNHZaKTBk0bUv6DzqZKHNTN1KNegSfr/lEViVENBMR61c4hiVthKWuOmGTM=
Received: from MW4PR03CA0167.namprd03.prod.outlook.com (2603:10b6:303:8d::22)
 by SN4PR10MB5799.namprd10.prod.outlook.com (2603:10b6:806:208::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 15:48:51 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:8d:cafe::7d) by MW4PR03CA0167.outlook.office365.com
 (2603:10b6:303:8d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Wed,
 10 Dec 2025 15:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Wed, 10 Dec 2025 15:48:50 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 09:48:45 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 09:48:45 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Dec 2025 09:48:45 -0600
Received: from uda0271468c.dhcp.ti.com (uda0271468c.dhcp.ti.com
 [128.247.75.68])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BAFmjrt3199756;
 Wed, 10 Dec 2025 09:48:45 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 1/6] board: ti: am62x: Add basic initialization for 32k crystal
Date: Wed, 10 Dec 2025 09:48:39 -0600
Message-ID: <20251210154845.3852231-2-vishalm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210154845.3852231-1-vishalm@ti.com>
References: <20251210154845.3852231-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|SN4PR10MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c08e43-a06b-4f3a-18d1-08de38039d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N59bVVa+bxaxHVUBPIdL1dz2dzV8kOrgWga9ZzT+HdvjXgEPqBi3Yw37v2kM?=
 =?us-ascii?Q?gnGdYZH0nGgHNxhgw+xaEcWgnXeJRc+tgs0ZA75iRt0DyV9xJaL9u+C0PiHP?=
 =?us-ascii?Q?ZVIKQufrtGM0rPe6cOOvYxHYZWLHEmtjcVockEJwXdl2W+LA9x4f3mcYaVKv?=
 =?us-ascii?Q?nSI+/6kin/qWFsV5T5qy6EbZfHoRxIrDzpyOuVdYJ8ldfAOG12LVFg6Pw0ug?=
 =?us-ascii?Q?htwz8ljxc2r3R4aaCZA4b0KEbXzE/xasFZUamcbsI9QbsTlqjwzFCM40PrRe?=
 =?us-ascii?Q?Nu8hLuqKWumcQnDOiiPtZi3WQNuCxnGeqmTryq0zHN9BJHavC/zkdxE9DmhU?=
 =?us-ascii?Q?Vj+BgrWvsn6AJurCjyA5uSyCHuouR8LpmjKK5dzsRXHKxFkdWngj8sjN6SkE?=
 =?us-ascii?Q?DouNuXVzTF0ceNO4kc5oZLrYH6p38kipKC45eMQp28jNwUAppc4dPQbPVS/M?=
 =?us-ascii?Q?ECRiUxrGFvnFl4wLXAlO2qKGTLbvdvp5nhXAy32uuZO0Bhe/NmfeVRsLbVE2?=
 =?us-ascii?Q?9ltl3iaXKKIxXyGkwGOTeR6Qze8G5mvZhbOaMvRNI+C/B6AVtnBR0Qxo3BSx?=
 =?us-ascii?Q?iKuKLqj+G4CUpbQ+cTx2gOLK/a4B1DukrFFqsd9l2xAsJ8t1zT/BNmVG0qcl?=
 =?us-ascii?Q?Z6RiAED1ddSD1DDS3J6iijTjz05uJcbMustTOH6IlVPbb5+vA6RenRlNVbPf?=
 =?us-ascii?Q?QBhfKULVQpOYE/5nr+MrNmB5D9I7gSCv5ObaMnOvvvXCA7aMR5IFbykgwzu3?=
 =?us-ascii?Q?IiK+Q0KW0WHqiM6CXgisprWQNHtkUdAKCs5DFIsOY+dBnDoLLE86ZFHma+5W?=
 =?us-ascii?Q?39h7HbGuwucpX/2H2pACGhbY6Di9RHP16n4zqJNDlF1o9LLeamfAif0n6YcK?=
 =?us-ascii?Q?fMwDJK7hdNfegwIpMVhoOmb+k4uUQHGESe/S0EjuVeHgmh6rJYtZCLlmTeAC?=
 =?us-ascii?Q?1dZ9LubRhQQ0JMxGEg8GOmIey5Moln/c00kaOUdrVDuJv/M5TGntwYBZ+JNi?=
 =?us-ascii?Q?p16J3hPhb2m+0ayzsAlQ3DXHRSrCjlHUPTlYbddYqthlUH81jcIO95Muexrk?=
 =?us-ascii?Q?gg3RM5KvAZW9VDfZOQDOF099LpDQfT95ZYEzIeBv2YylbECHqGzGqs6PBMJL?=
 =?us-ascii?Q?F6mqy1Jnix/VgFiX65/NwCHshnigQiG0TBpbVYk2qzLCEvekuIVe09CnHlyv?=
 =?us-ascii?Q?NeBRfaqF2X+OdqRB0XLdWs0e3UwFD96LGIHNhaDgM3ZZiJtV2GmfnlSUZkbS?=
 =?us-ascii?Q?b2qS14mCjgRCUSJfG4n3M6hf8/yRUttEQS7f4ttuFiGQtkCsq7a4jYWVk5Jp?=
 =?us-ascii?Q?paMfweK55Dbsv4+3hGTFr4jOfffofmdPHVi9sLMmYaThQr42WL/+QRsJXWcf?=
 =?us-ascii?Q?FKQYV+j1rxuGJuqKN4wnYEi7BsooohDjT1bpLg1j6Xlyj8Aw71zKBpG3woeS?=
 =?us-ascii?Q?LZc2hGojsRD3FXKMJVHARBlhcKirUp/b39kEwDvyjlE43H/qfT25Q38cz1pb?=
 =?us-ascii?Q?k/U1nID3guh7mepeyq29scWsdSUzgLSF49vb8Ex8lkEsiDuvqGWjh6pUfRP3?=
 =?us-ascii?Q?/QCpUf0/+iqKjJFoGsA=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 15:48:50.7902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c08e43-a06b-4f3a-18d1-08de38039d56
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5799
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
 board/ti/am62x/evm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index e9eba57eba7..7a820cc8c07 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -137,13 +137,26 @@ int board_late_init(void)
 #endif
 
 #if defined(CONFIG_XPL_BUILD)
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
 	if (IS_ENABLED(CONFIG_SPL_SPLASH_SCREEN) && IS_ENABLED(CONFIG_SPL_BMP))
 		splash_display();
 
 }
+#endif
 
 void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
-- 
2.34.1

