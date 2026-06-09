Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA396CD8CB2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 18:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E397A84869;
	Tue,  9 Jun 2026 20:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eBkkf2lf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4D57848D7; Tue,  9 Jun 2026 20:10:28 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFE0F84704
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 20:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URN6viF0xrZ/t7f8vSVXZ1grZRR8YdLNzl2xvVXxDf6IQ14rg2vM77NVLpZfIcFv61rsDNtFuEcqmB4uqDSpnfAiLRE8JUEF3jU55/HnlOc3DQnSkSDCQxYqV65wblAzkShZgLmK17yilwgYrEfmI5s8T+x31BxZsQw0gVyG57LUwyhBSqjKw3Mm3N4ATgTva3deb5l5FDYCmweM0JWKyJxjBVU67VpbL+IfOYOlSKD1X5RFbgB/MrJvTW3PyOjaf54qzH/hhfp+/GZNcWJGtnPNQ2psTc2q4qMuwTPPlJTttrA49QLqw054V4HXC7VoFqqfbDlJOWwHutG7tsC/Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2b5IQxkBDMNwVblmpS+5yOpYp9wB9IJ7pslSVgL8rg0=;
 b=XFAcRUDl9knO4nbiXPCV60041wpX+I2s1nIHppABAa/IuUpDRBvbh8TVHFYtCMDXtMGvewtnomE0yc+eBrMpwHxul5mZAPD6KfskVzqYaYn8Y9aK/1O9woj2AKgx6nmu/UkSNm/Y9lZwDhGSmivLVv1x4NZeqQQxAxQt2Yk3mVf5FB17mbRGfpDw7mxCkIDaCJy10SVFxsXv32l4zDUS4aYgm7O3QipjZNckCJphtr7kgbwBehCEhDVgkL4+ZpycCmbC6TDqI8+XWZ0hZZqBrG20pAc1ntJSXHf4J2sxoti1XyZtmWcJQ9YjZPnrFpODywvMgvl0nN1zom9GYGecRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2b5IQxkBDMNwVblmpS+5yOpYp9wB9IJ7pslSVgL8rg0=;
 b=eBkkf2lf2O2d3hlNzXTZGqjaWu1xl97B5tC1DSLhZQLW/og57tX1m8wJaqvhIZiy7WOZo8dl2JfSM3+IYPRIG8ImM5adZxmFb96SYWwQNM31NJ7Xv1aGzdCukHq8NZ27Xzk5afAbykiIOwLvXyMFV1DC0AwVuBtx/wakMW2eZJY=
Received: from SA1P222CA0041.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::15)
 by SJ1PR10MB6004.namprd10.prod.outlook.com (2603:10b6:a03:45d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Tue, 9 Jun 2026
 18:10:23 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:2d0:cafe::95) by SA1P222CA0041.outlook.office365.com
 (2603:10b6:806:2d0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 18:10:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 18:10:22 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 9 Jun
 2026 13:10:21 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 9 Jun
 2026 13:10:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 9 Jun 2026 13:10:21 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 659IAKI61612515;
 Tue, 9 Jun 2026 13:10:20 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <b-liu@ti.com>,
 <afd@ti.com>, <anshuld@ti.com>
Subject: [PATCH 3/4] arm: mack-k3: Kconfig: Add DM firmware reserved memory
 configs
Date: Tue, 9 Jun 2026 23:40:05 +0530
Message-ID: <20260609181006.460401-4-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609181006.460401-1-p-bhagat@ti.com>
References: <20260609181006.460401-1-p-bhagat@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|SJ1PR10MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: cee0019c-c84f-4c48-1185-08dec6525fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lq5QsKmGl+ysLL5/7tO69vI/vr9Q5QM3kn96uGG8V+dAVp53VHL+Po5Bs8by7+BLpLeUWQ+QtlkJc/kSAm3pdXNmY7bHwvxQMUeB1BIgvV+F53voL4Zf5wM3/7cOKUN19ngbeSpPnuwPvswsvs8qTHVdJ8yyuqkuEdPAmMWeCr+793ZYFGIW3wiGiyHBM/4IPWvvHbOcIZ6kc+LRy5yWqZVb/CuCzt7ErQQRe4Rrc86pLY1lv8eAh/GYbxhCs7Ls3LXZ5yDekK82+1sPbfQZCHi2bLFfWiWz4Fh51pTtRUTdl+sOtPcDg0RQRo1267hetgymIc/8JwhAY3M1d1sGZ6dyPe1TXa/IupW+sYLxCTN9aLg2co89M6GuNb7qgZnrJWvMQno8WFHSH0xqMRTka65MtK7j3lnnWKZLvOUXhVDw/HFrAfPh1HloRDW7WWtnvCC+fu5n2OyxPGMwDf/2I35lMZy3X0moVpifof341FYBdRHmye/59i3NOT1XjC5j20XlMBwl7hKvULL95qadNTzp1mku560bh/CqetDpCaqkrBloG5+feSAi2Yk+qa4yQDtmkDITGz+c+hcZPcsdXmHEkLrf50sd5NqjCotfRTVL4qHGZCUCZ7zxOrMvPmOndI2fFGnjbi54/7JfP5TGKBTAboz1H8fB4mjR9HRZoJkt+NIIhLxUGnCBRRdZ7BbtO6BwhveNmqt0fK5zkI8m8T62snEOb92wz8wjbAQiDg0=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ze06fzzb8/RksLNtS46/eVsJ9YCH3+hdyvasCf/2oZHlVHkyIGQPykk2EuiOtN2gy+pWfhu08AQFypYeJeEdpINWcScC0OzfckRjMC2Q/R5iOoJSnLNp8xZ05GPpHqlWSlhHGF2ZelODD/3iKw4TV7nT4E4ohubCnLNGOWnlAdElHrBvglm4VjxWKb8OznBe7b21bMt0oey9xXL8tXvzorw9YZTqhF+MGP2vVD/s9Od1jxqdT22FIixuy93og9PQBi28ebwbtOJeFU7pfXhoGzGvsJ0oCcj9VoiZFX0x5ZUfK9MmixzBY+lX50HvvPbWgTuMgSB+NF+ls4hMpUV9ZCuc4B5AjgjkQlcBmj4Gflj6CpZ/hRikqcvoXzRgEE+DONoRbViQq9dQlMN4zqZR/Bb8c5ubG/C5R0I6PXodzy7hsgJYj/JRMA8UwYnWQ7tZ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 18:10:22.6468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cee0019c-c84f-4c48-1185-08dec6525fa1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6004
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

Add Kconfig options for DM firmware reserved memory for AM62a SOC:
- K3_DM_FW_RESERVED_ADDR: DM firmware load address (default 0x9c900000)
- K3_DM_FW_RESERVED_SIZE: DM firmware reserved size (default 0x1f00000)

These configs will be used to fixup the kernel device tree's reserved
memory node for DM as the current reserved carveout is insufficient to
accommodate the binary.

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 arch/arm/mach-k3/Kconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index a32ed3a9683..ad16de9c7bf 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -165,6 +165,22 @@ config K3_DM_FW
 	  bootloader, it makes RM and PM services not being available
 	  during R5 SPL execution time.
 
+config K3_DM_FW_RESERVED_ADDR
+	hex "Start address of DM firmware reserved memory region"
+	depends on SOC_K3_AM62A7
+	default 0x9c900000
+	help
+	  Start address of the DDR region reserved for DM firmware at runtime.
+	  Used only to fixup the kernel device-tree reserved-memory node.
+
+config K3_DM_FW_RESERVED_SIZE
+	hex "Reserved memory size for DM firmware"
+	depends on SOC_K3_AM62A7
+	default 0x1f00000
+	help
+	  The runtime memory size reserved for DM firmware. This is the total
+	  DDR span needed for the DM firmware binary.
+
 config K3_X509_SWRV
 	int "SWRV for X509 certificate used for boot images"
 	default 1
-- 
2.34.1

