Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F6AC83030
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 04:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D63881D5D;
	Mon,  7 Jul 2025 06:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zg6Q/Hrc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B2EF83015; Mon,  7 Jul 2025 06:37:57 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBFB0810EB
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 06:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9osPSh60p5BnBO6Yeo2NK0i5l5RIy1lfNYgmxo2/zaexwcWBcr5T1hgbdeN+MMZli8ap+O6U4Iw3L0MFbc+KAtdKHaijOh6yormEs9AWBWmfmHyQDWxwxycE3BVYZeSKWm8U7CORxdRa85sRlpUsCfCrpvz959IFP4rESYX6MrBoxfMAf7BNXXkqlDQRDqTlodLm3nJmcOJ1IR3alKHK5qIaQmi2Hv1T7vbH/cvA0ByQMd8P5hK8otUOlrtXrNG/5jOLVT60U7XjjpT/LZR9MkxItpc2bJLy8FOvnHGZCCc/ACJUWSsyX+N7nnl8sxkPK5XBpvHDdFzCcxCWpyc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/GOZPXDCJhfInDBrmuA3AiavS6Wzlj15yt6HOB28oM=;
 b=e6s0F4gWQz885sZbCsW89lSj5Lfg25maO8lOsytJj0LLB15fyxszb/EH0GSaHuiaZLk5FKguh2vmZPE8EU68gELsPtEaAE8ISKthUuks4SME1vsjKSvoco0eO2wb1WaRF0NUFdVuc4j5OzFoxAhVHOz/AdVFVLTyAM4nMO6ZDyrWHbLRMxdalPDXcToT1HzyTcfWz02Uj9k7EFJlJvwpod0B40egk0jhfuIrNSIUHRbkC36ERxS/KjGZh6mxhCDLUGfwq9cZ9bhB2i+cnS/6nk24O74xzW+H2GdlDGgx7+oIYNJD2qwkdZ7PSr9Zhw8TQIrnwy6ldZGadAdi8/ehNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/GOZPXDCJhfInDBrmuA3AiavS6Wzlj15yt6HOB28oM=;
 b=zg6Q/HrcmKI51IDi9CpdfgiolMMlrd9DTLj1R6Dgit49+Aoeg899kYYGviEMD/1eu6XC2ZvEf8jGVY5YaPwA+9cXrDzdj6CTzvzWlFrgyVMgyjm+IFj/ndo7Py7PiABMj3WAHbmuqUpyHh1NZ7FKY/03HKdSQfbqaU8WIDbQD90=
Received: from PH8P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::26)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Mon, 7 Jul
 2025 04:37:49 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::f6) by PH8P221CA0011.outlook.office365.com
 (2603:10b6:510:2d8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Mon,
 7 Jul 2025 04:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 04:37:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Jul
 2025 23:37:46 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 6 Jul 2025 23:37:45 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>, Prasad Kummari
 <prasad.kummari@amd.com>
Subject: [PATCH] xilinx: zynqmp: disable CONFIG_SPI_FLASH_BAR
Date: Mon, 7 Jul 2025 10:07:38 +0530
Message-ID: <20250707043738.795179-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2dbf23-d96c-47c5-1046-08ddbd1006b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2IfZdf1KUW+UBzDMdeycB26vldaNeSYKDpAkoalQCoQXCggHYD5IGLf6rtig?=
 =?us-ascii?Q?QvV5CMOS+gk57hCg13RRl2WOjTNwjwA1QV29zJAnF1U7hgbSSynv0J0Jgxs6?=
 =?us-ascii?Q?2vvM2CrNUz+kX2W8sWrBGn37OIgTvveiAMwcUWSKq3Ihsnnudiq37xdDLsyr?=
 =?us-ascii?Q?/vf61qYeTqrrkLEGKgkvq2ZMmb95Pio37iRp+ETgCgEg+zoA2NbgfF55aa1b?=
 =?us-ascii?Q?bC3kejS6QF+Gs83/gy4QXvI6Jk+ZEQ2pCLpAVV27PIMiYe8JAPSg4w1kheTC?=
 =?us-ascii?Q?cmX4U9Y30suOQsL5hKHAQvlhDssql5n1iZHOhMpOLfagCvAlzh7qUqBEDvrF?=
 =?us-ascii?Q?8avBbxQV/YwnqlglaNrJy4d3Ngt7WC+ybUuzrPP8VvxQaqpfA+6YayxciEd4?=
 =?us-ascii?Q?WluLY+RUavpltoFL4+XOYJkCN+Z6g2jYO9CRkd05jNnOSknB/fprkdiySXBa?=
 =?us-ascii?Q?k+5xu1XnlJvSuZQGscfBGMHQ2PjdyeDl5S7AScv0iHfUcIr7ZfTXWGa1njWD?=
 =?us-ascii?Q?rbyFxrlCS4vNmzrYaMMT/mi/4EGQY4Dl9eDDEyJ3A7ckJ2cI3FR4uhJdxdLk?=
 =?us-ascii?Q?5k4cEi2w/kIUBbyAWGeOW23SO389Tn67JR1wXSi9JteigWCW9yymETl3v/pP?=
 =?us-ascii?Q?T3IJlczMoRuma6TJY9UxL8c7U9tS06OTWBAHfOqZ2Xvd5PpYlg4oEoh+YZMU?=
 =?us-ascii?Q?ufDCXOyzVPGvsUAqnkGYgcvg/ryix3rNueImfBlAQmTGrnNnuuFMX4Re89AD?=
 =?us-ascii?Q?MOnvZhvuCIaH8KPV2sJS1QObvvWUkmqagzBusiqy52QRKDOginaDNzmTW7l4?=
 =?us-ascii?Q?xu7Xidu9mXjsfO0318Fpj5xyn4OxVJfs6x+YpcQBjR8RmaH8MJwnk4XBpatt?=
 =?us-ascii?Q?DILxh/8w8BOjOdTrNswhfCu/DFEmH6TY4+G1yEU0oMo+0ejuRQMfcSPLiYmo?=
 =?us-ascii?Q?r9G/LEGwZM0o516uk2LRFqQJY2Bsw+UPMSxqhj5mqKXwCecvAobCJyoto5ZJ?=
 =?us-ascii?Q?TNMDm42ovsgjvzQt6qt1rAcnldVoCfU6SRWOrej0VsmJl456j7XqVBql08D1?=
 =?us-ascii?Q?UGyb+cRi5Cbu8XI83zMPW7fdRYu/2bqn/OtITnUzun6jUzYZ2ggwI8tt0cvW?=
 =?us-ascii?Q?YDnyzZYsvOU2eD8W4Qb6a81yAuWjvtat4sTtktVF7Py596pI0kqu9PkfuswT?=
 =?us-ascii?Q?swwTTpO5ffxkNMzrDR96aU+oLOyXsSvsD5LZfAImL+aN9zh0UfdIZj0PTN/o?=
 =?us-ascii?Q?zEquzHu3lH4/apI+I7wY7023cqZH9iqiEk5HrNfw/quORzRqxM0PmrhBy9c1?=
 =?us-ascii?Q?vF3tzBWQ4ZcEwe/FD/80rMipx7Lydhpd5S8YFBe+dmR13TpPOC3aYhcHombF?=
 =?us-ascii?Q?+5y5SSY8gBipRBSrNq/H4TfCMrZagK3NKfhGqhv83a/fIqg5W/2Ha8gdw7Ky?=
 =?us-ascii?Q?5GDaGBndMdNox7ALXLz0LPbHJkWQxPwPK/sMoys2z00HrFPIpvq4QbA5vAfK?=
 =?us-ascii?Q?/e/hmBAxSsu51C7pHIjY7NjJJslEqeRd5HzE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 04:37:48.5672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2dbf23-d96c-47c5-1046-08ddbd1006b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428
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

Legacy SPI flash devices used a 24-bit (3-byte) addressing scheme,
limiting the addressable memory to 16 MB. To support larger densities
(256 Mbit and higher), extended addressing schemes, such as 32-bit
(4-byte) addressing, were introduced. If the flash density exceeds
16 MB and CONFIG_SPI_FLASH_BAR is disabled, the device will use a
4-byte addressing mode.

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_zynqmp_virt_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 7807f6240e3..3d6ffd87af1 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -163,7 +163,6 @@ CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_ARASAN=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
 CONFIG_SYS_NAND_MAX_CHIPS=2
-CONFIG_SPI_FLASH_BAR=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_ISSI=y
 CONFIG_SPI_FLASH_MACRONIX=y
-- 
2.34.1

