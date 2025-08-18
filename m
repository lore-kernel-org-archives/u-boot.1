Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD06CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 04:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A92C482FC7;
	Mon, 18 Aug 2025 06:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZCaPcLTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F1FA82FC7; Mon, 18 Aug 2025 06:48:30 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA0DD80EE5
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 06:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxqUdAT7hCqOqOgjtlN71f3+3BjkniR7NPl5H/4rmY8ctThB7M/sqt2gfqZt0u8uKCdzYsNUHu/1Nmv+Jq6f9zUFWdTGUDNtsM1B23/T/gSo4PJH9jQt90+Xyck91BSakVfdkIzKnxWHbpMsMTOwe5wulp28PJ8cc1rUKv8tWyKdLUKvG5rtmLs7jt9i2AcmDsM6B0FWdQwv84GmZgJqwBTg7x2nM/KidvfSFxuVuB7Jc08vZJQYu3F7RxvpkjF+pjdkypTQykUwMW6Cwtw54ghTTS0DYXyaf6L+mjZCJu61M4NEq4wDx+Z751UhHgwNMmUtXt70N6RB/aRvDP1LHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVQUBXxLPyZrEyMDl2DKRbT5Qxts5Da2jvSKtrrZN/o=;
 b=kQUDq9xBHdG+0pL5ulVFewqumxsebscj6sY/7qliFTHbureE49JouRcleq5Tr8JhrtrKCs53fLocZQB0ciZS/JiSC8KMWOm6Cq7a8kq2P+Wwy8+8u+GVAH/sYSR5SG0ry9pKocMkHSgsEigSRJrJGFtb67VNXF1lOXeIbGWVtXf9untvW2lzp+tgboaw9bvAd+PhhRB5XnvRaVeSUaExRK2V7QRmjIReUI3Vk4b6sbiQK41TB9UjdzS2bQJLKWFmvDu6rfCT58vvtmA4oFptsh7yeEpSr5C9BmgNgcToSm5kxcaI1sh4YjdLD5YkJmm4mddb4DpulbLYXBIw7g8KPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVQUBXxLPyZrEyMDl2DKRbT5Qxts5Da2jvSKtrrZN/o=;
 b=ZCaPcLTUA4gflEK5US3b8lbz6IOCB5Qf8zES4mne4/QkXzoiiYagXrIdVlVYEBLU5FT/vRBNh5YrNULyZZR+LaSFJ6T0h2HbcLKDDlqv0HosRNWH1Xq3AZUqOnm2ffhkhRuvGMcOfyL+vpAIkac3KcH3tD+SMD3KhIbknw4vnQs=
Received: from MN2PR12CA0028.namprd12.prod.outlook.com (2603:10b6:208:a8::41)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 04:48:24 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:a8:cafe::25) by MN2PR12CA0028.outlook.office365.com
 (2603:10b6:208:a8::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 04:48:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 04:48:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Aug
 2025 23:48:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Sun, 17 Aug
 2025 21:48:23 -0700
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 17 Aug 2025 23:48:21 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH] usb: dwc3: Add versal2 compatibility string to dwc3 glue ids
Date: Mon, 18 Aug 2025 10:18:15 +0530
Message-ID: <20250818044815.4052070-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: de73bb33-05e1-41e6-c134-08ddde127714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EjYISUFJmdItsCEIZI5xvuquyR/A4EQD0mC2R5j0V6qTqMTTP++AQYfkeF4I?=
 =?us-ascii?Q?Ii84lJ72q7v4fGcFkqqDmVVSyUokBaJycu5plV39i4RxbKEiVjdcw5r8By7k?=
 =?us-ascii?Q?8iHoGaYcRgtiVTbOATw36ZZuoSlNlBxHbzUR+x7xl/G9U9pCitEHd9EixFEm?=
 =?us-ascii?Q?mTPdJwofTN2hvFUFTBihrC6Dhz6fqeRB0XYlxI6nC247Qt3jq9KOxDY82lPZ?=
 =?us-ascii?Q?az9R6ZE6BFMQIYAi73xwu5Bc3AhF/55R1qNPaIe7f1zH5SXt3O+V2NxcyGlK?=
 =?us-ascii?Q?N3yiwGFazewenooGy3iNpRpRPcMOKGANBBJRDtbDSvCG3D6ega4U9VaaVUYv?=
 =?us-ascii?Q?RJVUVGc4OVxl4f3oWm1ZplO2pDXiuHnHNmXJbINehc7gFMJI/T2B1eiihe1W?=
 =?us-ascii?Q?ilJr3N7SkbACQIEB4EtXew/NilFpM7Jcx61N/ODnf0J9495kTXTeQwJtw1yB?=
 =?us-ascii?Q?Lxp8Oq/ZhmaPB+ITZbWoQQcme/nQiL0xn4cxobB4nev1jMFULC/dNKgd2/0r?=
 =?us-ascii?Q?qRp+uBfiB7eKyYsED4pjUlZwg8XQefPVdJYf7q4QGVQk7JesQEdUKgrbPdZ6?=
 =?us-ascii?Q?m+hoCeTS4mO1tDRO8xKgKisjZcaVkEQ94m6qFaOOIdYVpLMlVQQ0BSXGGX2g?=
 =?us-ascii?Q?uT8fVVACdMnqSAFPnBOQbSZVNFTws0VWrXBYlpm//zg2Vy6ZAs+eEYR9f5SU?=
 =?us-ascii?Q?W0iPEXvJci9LTa6DISQJsOpmKeEV859iQXjUNtEFLKU6T+xd+wqc9yhIuxev?=
 =?us-ascii?Q?bmE7G35MNKCb6eLxU0mmgqwpwKFW82Pt8j20Dg/wpm+ApI0y7Pcmv72xMuNF?=
 =?us-ascii?Q?1UvUCHw6+Hu2wbbhTqEVEFfvQyBn+9dNrlMOvUkSBRGXwOVki8g5xIwzcAcJ?=
 =?us-ascii?Q?ur+lKDDA822UV+JM7MYdGe+JZuwwzMyD2RhLq02fKWLxZ778Yr4W2BTkRvnF?=
 =?us-ascii?Q?cyksrSwR76kCS1MmnyoBaJoBhasvmi0dW8EaL5LzbotyHxKeT4NxZ/k8UUPw?=
 =?us-ascii?Q?FU9xxxo8DtGswToICp460k50X2CWzgRCBZd40vzFc1Q9KNf9p75fiuETn60F?=
 =?us-ascii?Q?qtlS5/olgjQHUL6ybcxS/RYXCzzgKRsjgb9r12HdZO5UejG0LN+xFZZECZGv?=
 =?us-ascii?Q?pnH9E5vhqy+oUa0e1pbsmzwW9xWQeEt7H2XFyvGcZRMIqz+wTM9SX7iBh12E?=
 =?us-ascii?Q?eych1bxgc5eckItK+U72nFqxlrOy7874qOmtFG+QcHmbRBHs8RD17OLCOVYZ?=
 =?us-ascii?Q?bXcS6y1wPI2m11W0ATTWMmX/+4vbLdYlQo/WoGbStHuea61B4Vg72Gkxuxi9?=
 =?us-ascii?Q?ANURIOrYPs7wBO8qdtuwDYbHA5zpy+5pBnPrAZhpliyyGHIjz6EqQfesEe5g?=
 =?us-ascii?Q?6BU7hDepLcI+LcAmuXA9VTZxqEN21uJ7uug43ms3RXUIEW2wVBfzVJQiOdLa?=
 =?us-ascii?Q?EO6iwuPJ8qwMxSuQggGjwpozgbxkTJ9Ig/0NASF1CzUxLyisnVDlXL4HzhuB?=
 =?us-ascii?Q?ZFhTEY0lUsWdH8K0ST3MfAZNrDwsWb+BTDuq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 04:48:24.4683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de73bb33-05e1-41e6-c134-08ddde127714
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
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

Add mmi usb controller support which uses dwc3 and hence its
compatible string needs to be added to dwc3 glue ids.
USB3 DRD IP is usb3.1 gen2 controller which support following
speed SSP (10-Gbps), SuperSpeed(5-Gbps), high-speed(480-Mbps),
full-speed(12-Mbps) and low-speed(1.5-Mbps) operation modes.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/usb/dwc3/dwc3-generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 3cda2b74b7e..538b6efe5c7 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -692,6 +692,7 @@ int dwc3_glue_remove(struct udevice *dev)
 static const struct udevice_id dwc3_glue_ids[] = {
 	{ .compatible = "xlnx,zynqmp-dwc3" },
 	{ .compatible = "xlnx,versal-dwc3" },
+	{ .compatible = "xlnx,versal2-mmi-dwc3" },
 	{ .compatible = "ti,keystone-dwc3"},
 	{ .compatible = "ti,dwc3", .data = (ulong)&ti_ops },
 	{ .compatible = "ti,am437x-dwc3", .data = (ulong)&ti_ops },
-- 
2.25.1

