Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8949CF6497
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 11:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60E2288E1A;
	Mon, 30 Sep 2024 13:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j2mVnT96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 232E788E19; Mon, 30 Sep 2024 13:05:43 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D6D28843A
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 13:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPKixI2eM1R6YPMpg/V+N23DahhvZOw8oz5HK1ttlln1rCvO+MsITAT/X0+0d/0qpyIF6NYLLIdjMrKBUSUkOxtJQ9EOC4N67nxtBdz3lcAD5TunC+a+W0xwVB12T8gAq2qtC23/f4YwI05Gfvb2m8wEIKKJ5QTjpc+BQ0M/ZOVH/rGCqJ7p+lCNOWHm10FOsXvHKd/anx+EfiUeY6ARRk+akL5isPJ61QGd3nTnrPFfNFzwTwTEMnyxqK0346fAeHgI5of3bHYXqarCiZj8gt8XjcSGtHodBw4UrP1/7bsii40Xyq5akqwqN+AqKJ1FtVSpR1bfNI7xiq2bIp8yuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIXYFtbNbNJ1D4b2dSwC3OgUFmNaXLVD332F23b/oRU=;
 b=au7r4FRgG6sY+pMJtuMf6KfjIrg8GLeu7u5NRb2csPd+MCQKEfquQ7wd5ULKU075H2PABFSBLseKtdgYRATkd+MccEZYf14RVtOEaN83dW2W5wfRle21wYEGrnB30EhKuWHE4hpTkhPtKqG7GbORxy4eGBAeglNdGWBGCOpCGfhgh5AiElnas9jZqSRoRbwEyS0KovEQmwhAzZUyuo5wP6TFGaKw/kCaJsKeoZX3je2GizikjbayIJSE6dMiVHulFfuT6kJIXdGFyTOQoNsm3aaL/MXOD7/JnEVJxe0A4GykIjv/cyGZLF+3K5H3bNAa6Ewrl0CVFIraGYRzjobHgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIXYFtbNbNJ1D4b2dSwC3OgUFmNaXLVD332F23b/oRU=;
 b=j2mVnT96EtmWQlbjqSaWnz3jE7FIkMsskMjsCiwDpSdqHORFQQGQcJsNdM/4Gt2yd53KRTndaDYgLpNmqPrY2VmvVi+O46eLKcSgaPApDq6vnB3AhzJhMSuz20ebvASu8+3sbmRakZJJOrzu7Jf/W+zykflxE2sEMvCt/trdc+Y=
Received: from BN8PR12CA0006.namprd12.prod.outlook.com (2603:10b6:408:60::19)
 by CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.23; Mon, 30 Sep
 2024 11:05:38 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:408:60:cafe::4d) by BN8PR12CA0006.outlook.office365.com
 (2603:10b6:408:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Mon, 30 Sep 2024 11:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 11:05:37 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 06:04:39 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 2/2] arm64: versal: Wire USB0 in distro boot
Date: Mon, 30 Sep 2024 13:03:53 +0200
Message-ID: <9715605c232ce38a36a200204c14208b9d76cd83.1727694230.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f148161ee489d19d708df1b4fa7477821e06bb55.1727694230.git.michal.simek@amd.com>
References: <f148161ee489d19d708df1b4fa7477821e06bb55.1727694230.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=shhiupLEeis6+VEFPUUp+HmF6PoJ1G8oxvUits0F4LM=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrRfrXNm/Z/vHL52mn/1D5H958OYT6fGexZvT8lqaDG04
 W9uOCzREcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACYS1MEwz3jtyUO9cqtUL76K
 yN1j9K9JyPH0RIa5oiwxKsujwwTbtr27uqrbbOYbC+VjAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f67c817-3817-43cc-731b-08dce13fd060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rFoseUO/a8zojZPdYs/Lh+zs0dcoksjdCEg2GkyozwCgoukLVxN7GAPEOiHq?=
 =?us-ascii?Q?axIGRIOY6iNLvUgeQ3YMXPsdkKN0ru93BurQknnOMMX3E2r5GqBHF9+uDsi0?=
 =?us-ascii?Q?JRl02CTqqAffnCYBSPic+0CjBYYYK1m9+Bh79ZPg8lA22NJhkdfo+Xlaxchf?=
 =?us-ascii?Q?efLUR5/HZxWsz4Y3oFMovyyXe0ZjraQVFktSyYD4EsZurTGtG6ggvVrOdRIv?=
 =?us-ascii?Q?SrtmcxSFKe1Fw4PgwPRN/SZKrtyHAYBcTdDvLykYYxNd7wPVsMwkYkhjvC/p?=
 =?us-ascii?Q?FaqlTVxMsM+3P2AcS/Mgj91U80eaDTWH0LBufE/mSr/oDIi0K07WpY8dR33A?=
 =?us-ascii?Q?FREogCbqN2EW0NVsg4jLrcuz8LtZNEKmXkIScyY4f+tNU+g6PIuNmqBZa2xc?=
 =?us-ascii?Q?YBaTFYtb+f2nVRcrLK+Ab2WX/Hg7D44LF36hOdtdTAiurlJ5ZbqXlkUsPYvq?=
 =?us-ascii?Q?VJnd2xcqHQ+g4psbnoTTbb9qEjAvndiiz2C6FLdYcziMEo1sqFmL3HQKLgXG?=
 =?us-ascii?Q?+5NsTV7AqrN5/ggkn+uGdLQPo8XQpOAV0DK3rQ8bqvDwfbydv6yM+JScW78W?=
 =?us-ascii?Q?Oa+HGegQ+eCPq2JtnIBDKi2DxcVcGCRW6LINKxeOd23TsL/xmtsUty4qiTJ/?=
 =?us-ascii?Q?g3bw8R9cFZKBxz15PClRiTLNO7Xau0yhSkIRTa4ZWJvAMfMGPEpJ2TbzAIDO?=
 =?us-ascii?Q?oYvOgYh9jiVnZCQVjj/JJnSy1YUzpTahdvA+Bf9d1qwQCdqN+msrOqRzxXWG?=
 =?us-ascii?Q?TnxiohDryyBYXBzLnA/gDJTXrQCyEETyq5dncvx4Nv3D0j4MAuP9jYn+gTtn?=
 =?us-ascii?Q?mZDYUqPMOMKDOexiGzFzAyg6W1xFVCIityvFQvdRO7X9D1FR4u6LlCJV7lDk?=
 =?us-ascii?Q?5YzbwdgjU7LPqdzH0p/7c3drC9NxT66vTWLTAFfJG6OrUs3mMBM9c2wG5Vol?=
 =?us-ascii?Q?2E5pDw8Yy68Uc3KykYqrd6Dd3bX5MHhaaAEcNSS+C4xA6AEOO/ebA93KLinm?=
 =?us-ascii?Q?eZGovQoXWtsp3qxDNk0KjF4makWIz1uG0t9uPTdXjPFBQP/jFrHvkqULnrAi?=
 =?us-ascii?Q?u1iGkPPWD5xTC+o5o3dujJ7jiuUoZ2Maocs+OndV06r3seHs3s2D8aZ1azqV?=
 =?us-ascii?Q?ePXq53C0MGsX6Kwqis4wNR85M+JXc96mehQ5aHZf+ilz5vq1+rHHrYBQFyK7?=
 =?us-ascii?Q?TUPKICY/c70MFawaPfZ/0KUQPzKx/D9L4bRwtFFImxg5w8gBwwD0yPq3yfIv?=
 =?us-ascii?Q?Khx2oLqm6RaRs3EG3U4hcSYbIRgXo4ZSNx3dyCWY0opsI6bildJVReTeZ0nN?=
 =?us-ascii?Q?ZJgUkxSP1dlcLHMTLu6YRMHyQb7M8s89fJNaV/0y+5BFKVX1pb6Xzf6z1zzl?=
 =?us-ascii?Q?ZA8Ll0nOAt94pdoxsHiGqo4VQ9vhlFZsjoxDys6Ua8eYdnoF/XlaILmseHiz?=
 =?us-ascii?Q?vAqGjcH+IJPVIH+Kqe+0RfMWmL+GMT4v?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 11:05:37.4157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f67c817-3817-43cc-731b-08dce13fd060
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279
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

For unknown reason USB host hasn't been described for distro boot that's
why wire it now.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 include/configs/xilinx_versal.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/configs/xilinx_versal.h b/include/configs/xilinx_versal.h
index 212dc9df2a2e..64f123424cf7 100644
--- a/include/configs/xilinx_versal.h
+++ b/include/configs/xilinx_versal.h
@@ -48,6 +48,12 @@
 # define BOOT_TARGET_DEVICES_MMC(func)
 #endif
 
+#if defined(CONFIG_USB_STORAGE)
+# define BOOT_TARGET_DEVICES_USB(func)	func(USB, usb, 0)
+#else
+# define BOOT_TARGET_DEVICES_USB(func)
+#endif
+
 #if defined(CONFIG_CMD_PXE) && defined(CONFIG_CMD_DHCP)
 # define BOOT_TARGET_DEVICES_PXE(func)	func(PXE, pxe, na)
 #else
@@ -118,6 +124,7 @@
 	BOOT_TARGET_DEVICES_XSPI(func) \
 	BOOT_TARGET_DEVICES_USB_DFU(func) \
 	BOOT_TARGET_DEVICES_USB_THOR(func) \
+	BOOT_TARGET_DEVICES_USB(func) \
 	BOOT_TARGET_DEVICES_PXE(func) \
 	BOOT_TARGET_DEVICES_DHCP(func)
 
-- 
2.43.0

