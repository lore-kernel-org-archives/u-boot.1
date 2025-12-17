Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0ECD65C43
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 12:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B59E83B30;
	Wed, 17 Dec 2025 13:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zpnuRp6+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6129A83B32; Wed, 17 Dec 2025 13:51:18 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F13083AA0
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 13:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBYQWN459+xGVgL7ovwX1UHR8klpX52yN6gLGeQKdpRw7dXgbwvilXIb+hqSpiO+YETUMosZvv3gtaHtg5UwAY+EOftbA2gt7PMilhifcQpnPtKw2HMcCe7UrCa+J7o8LWMACCAMqnl91/ozMTBzvmuaH0gNZkvhJeKjvNsmK4LsKqhkwpyZhfziroZOywv7PiEvy0ZI5EmdpjfZYZ/vBU5GtAwaz452SdAAX605JzKiX1l8vk5BVFbgSZjZCLCOQmgK8HAgPVR+B/zMJMdLV2gsXI+AT0QEMfZ7FxryU9DZnTIvYzbpBG50CWuUZQTizs6meSDDhSJKD1IOYrrHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vvq9qxK09+1ZB3EKSiIbck+EJMg06nyjEGEXY7gwVtY=;
 b=Q8a2QZqTFzX/O4f6oWy8k8FCL7B35UIHCsUm1U5HECUag3c1jXjRZWZt+OV4xo2B+v6mJ/k7mHQA3Y1w48TtJCTp6oMWyQK+ynsC1e+ozyjc95L3ATMEpK19GL0PYe9U8tkK/KvaAsRGHRoXXtEJrqXMrMrIMbaE9kZesUnOKfYUHMXTof567GOVQtE6Lkq3i+s6e8eCRKVpx1gcBeJDR1v9tVlMPCQFiPGqXizLmtTA1X2smpxpv+m8OI2us7mRCwXmeIbu+MhEJac7q4n85m7C9wZ4ILOVbphqHAg0u4bYPgWsFmUhiyGpNoePtXSGQFEVSvJ99KZog6SegOZUQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vvq9qxK09+1ZB3EKSiIbck+EJMg06nyjEGEXY7gwVtY=;
 b=zpnuRp6+PIsHAqpu334vG0aqIHsh52I9mgc524hjcDYW0szMFY7XzzfjiOVapt5uN7UuoCXg3hTTh3SBcdMpovPGV2SCWl8u8LB+J3Ad+j4ip73x9uM6kH/CtkAhCOxzNv0Q0sL6mPTH+xs5+SQdzNEWdcKHhCFI25Ffx9EmgfM=
Received: from DS7PR03CA0072.namprd03.prod.outlook.com (2603:10b6:5:3bb::17)
 by SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 12:51:11 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::9b) by DS7PR03CA0072.outlook.office365.com
 (2603:10b6:5:3bb::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Wed,
 17 Dec 2025 12:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 12:51:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 06:51:10 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 04:51:10 -0800
Received: from xirengwts09.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 17 Dec 2025 06:51:09 -0600
From: Neal Frager <neal.frager@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <fabio.caccamo@amd.com>, Neal Frager
 <neal.frager@amd.com>
Subject: [PATCH v1 1/1] arch/arm/mach-zynqmp: configure default BL32_LOAD_ADDR
Date: Wed, 17 Dec 2025 12:51:07 +0000
Message-ID: <20251217125107.1095397-1-neal.frager@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|SJ2PR12MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe3ad16-ad88-454b-505c-08de3d6af451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j2IpM1rCKLRIRZmxihS/cxdSuuh8jmOvP93DpIGxi3SahUb3ofBl7TXwkrx5?=
 =?us-ascii?Q?ylHv6ShbNx7+e5miJ4bYp+74GMRHElsLhIO4rukY8h5izoTDKfglyIpE/ns2?=
 =?us-ascii?Q?v5oxmC4YbDrFTtUdF+C2DN0ETAOxumUwK2tCZXL+5XYnaSLweYvD4WpXW2z2?=
 =?us-ascii?Q?QTdUYIZR4vGqKnmwylpwAyaRsRtqLj+EA5JzaMgFKo8g8BO7FQosyzFQAYnc?=
 =?us-ascii?Q?Mtpt4rnHN1N9+wygk6T1vfl/tKvGzkLPNIFYyFzuEdnmTk3Gm7duCjFKXcbc?=
 =?us-ascii?Q?CiSF8gPR9N9T1Cfc9CQMZqi5M5Wse/1PpDpAedA1hIinZYwdzBd7qZPJ9YBD?=
 =?us-ascii?Q?CsIX5pRDlI+9xzAPnLFBwLw/rFWLX7VMeonzE6/ysRYM4eGWXrfBtlRoNQ67?=
 =?us-ascii?Q?7937Irm0QL5AeEOzf9uBuAwjDu0zWsJ7K5SmYN2jzkhaLVBNwXCe0B7mo6Gp?=
 =?us-ascii?Q?GH/dFV8m7tY3E6nPsu4QiqzokWpRmFd+jrg0XTlzzUE0PKCQC4HZQjdQUpyU?=
 =?us-ascii?Q?rSSlSS7itIhbyMYRdLWkPuGbEWOv1n7QWzwozlTDq4aadiqFamT+Frqow9BU?=
 =?us-ascii?Q?VujrJxXZ5DnouXKj2LcCrvzoqirAJvfzbqlEPbkjbRyOQZlD12wwzL5rbYv8?=
 =?us-ascii?Q?+HM9ovfKK/eBXjj+II2c9jEhnhdMTI1zCWN0cgqzxyhcoolajBUbivgw9G3d?=
 =?us-ascii?Q?37ZP/8LvaJD28s8yo90wsUKA8Q8E8NIJjTGr2ZrKUIS0ELZTozzaFFA+qdi5?=
 =?us-ascii?Q?XYtdn6nysGLiTdDmxB39YkGNLVvhhMeyxQIYOY6sdgnTpc9y28Hw7zI9cQ4+?=
 =?us-ascii?Q?VfoEZVrzhwIsNA3Rc3qzYhaNEXJp21/fe81Yp8FvKEtr10/6pgrbu87ffU3K?=
 =?us-ascii?Q?vt7X9UZ5mpV5SpUy1Y7cK4PHbZyNNGFxJ+mEJ2kBaJMJ02kl/FO/a2o9gEmP?=
 =?us-ascii?Q?8CpfW8SBpdzx7daB8UJ4AETt5ScE78RpmuKqutGkU+7gxBKZ4cGcxZIkYh/3?=
 =?us-ascii?Q?8P7D5B5ja2/goJ+3DQRqFHd8ceJuYBwyEny58AjWdA8EkOglfYE/RFnYjPiV?=
 =?us-ascii?Q?NNZ84x0ouSjuGr4V47xjLMyqY4DttNO7nZU999DLFw6DdDV2ZgG0irN3KIxb?=
 =?us-ascii?Q?FE837almVayNRQGJL7a/kVJNOkUruollHEnEv/qmeWkwU8QnETT1ah6jbIp9?=
 =?us-ascii?Q?R4luGJ2WApaLrY69Kz5R5HUPqeSUUtMlTwIYGYnE16MWUevL0j2PJg+m+Me3?=
 =?us-ascii?Q?BUt2qxNeuSuvqJAmw1d1tZJHZAjnxm8oXB+kbMVCef2lWmPkF+tDH8i9i1rb?=
 =?us-ascii?Q?QIELaQtVLp010QUJ/57O7IXww9sCFOJ8fTZ/Eph1OzwubDKVW1w2keh3jBL8?=
 =?us-ascii?Q?xb09fdRbo4HK45RAhe9O4w+PxTRPq+o7tlV/Y+LVJDDx6GGESZ87AEZm8Kt+?=
 =?us-ascii?Q?Zt2Nf54mkS1faFgApYi836bzVflQxlnEXmezawVNiCC6JizTxBxApSjWzOuq?=
 =?us-ascii?Q?tfIGJAi0BKIvd8jxrHr/OIIxBPFi6eHo3SL0OPO1xQGhjlhxqCEZzn0CFTI4?=
 =?us-ascii?Q?T7Uv676mPCLplxV1LHo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 12:51:10.7201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe3ad16-ad88-454b-505c-08de3d6af451
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8690
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

The default entry point address for the optee-os tee.bin for the zynqmp
platform is 0x60000000. For this reason, set the default u-boot BL32_LOAD_ADDR
to match the default optee-os entry point address of 0x60000000.

Signed-off-by: Neal Frager <neal.frager@amd.com>
---
 arch/arm/mach-zynqmp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynqmp/Kconfig b/arch/arm/mach-zynqmp/Kconfig
index 151cfada436..8a4356bc060 100644
--- a/arch/arm/mach-zynqmp/Kconfig
+++ b/arch/arm/mach-zynqmp/Kconfig
@@ -138,7 +138,7 @@ config BL31_LOAD_ADDR
 
 config BL32_LOAD_ADDR
 	hex "Load address of BL32 image (mostly secure OS)"
-	default 0
+	default 0x60000000
 	help
 	  The load address for the BL32 image. This value is used to build the
 	  FIT image header that places BL32 in memory where it will run.
-- 
2.25.1

