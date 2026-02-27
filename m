Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61831FD7F95
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 11:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABF3483F14;
	Fri, 27 Feb 2026 12:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AB0eJ1pB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B6BF83E81; Fri, 27 Feb 2026 12:57:45 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 647C283AA9
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 12:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IttBybhmw0wzuvaFYlqT5hyLRo7Wwrxt+t80HWo1NMnrpSwkQdNIGFzy7Z/MP/DDgb9JiEuMaPkWj3rlaZHCGE6Mnv74QYevvglyVwn7gHI9bcq9ErwbNOs28GG4WDM8hW2562umujCYTqcA/6+Ml0vQOe5/hbw1r3s9vjRJnOWZBlWm3VCdmYBRaN4WKX68nfgOUeI3hb1LBxDHxFtrxNqPHnxuniWu9hnawWdRCN2ifec4XChdh94eFdRwfWDkfmKlXwULJV1T079KplRtpHtZNWpxLS8oi8/joqC83vYlcvg6m0bidm8g8HXfkj+EmgTC4yjfNzcyEXAG8iOY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SLS7rgTjOfxpAVbKLEUV1VvXkR+P3ATs7UwkrXISHw=;
 b=dmfKK7AvprMDHY811x5lguEzkoYoGA6Qpn869TiGtcjbvNLcf5CLCk5DbRYA6nWUiYZDNrwdgekVkWkV0IS4SDfQQxwRx/mZ4YtToYEer6etN8Q1E1JSV19y35b77TrIlH3jprvdgsMzSpRkG1MGTnkMkMB643FpxfW5GCKB/Fsj/1asNpY29M1wjy5ndciNmMlmN/ob55KdzKQYNsyj+ZSMol61hqfarVWl85PvhN0NL61yXzD+w1n8hpHxzniCECBrI8cq/YjZToUIma7uKJ8K6H1fqXMQkPLBOGwIjTt8OknxezEXSHGccIMLjC4tVHJG4W2WRtSZo2PWocTBXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SLS7rgTjOfxpAVbKLEUV1VvXkR+P3ATs7UwkrXISHw=;
 b=AB0eJ1pBVAOu9dvKv9Wb4mxIEo8mYBAkG8cTNgTEKV2uAnz/GRcwo3H5fxdcr8f5YO7TlykY4CKWEhzS4I/dSbnj5euvEQKSRqaVVcBomsw2499jm86Xy+E4KADn3cPjuE2wfU+R0vuI0siMN4L6r6OMyt3nOFgama5FG2zxOBY=
Received: from BYAPR06CA0069.namprd06.prod.outlook.com (2603:10b6:a03:14b::46)
 by BN0PR10MB4838.namprd10.prod.outlook.com (2603:10b6:408:127::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Fri, 27 Feb
 2026 11:57:40 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::ad) by BYAPR06CA0069.outlook.office365.com
 (2603:10b6:a03:14b::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Fri,
 27 Feb 2026 11:57:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 11:57:38 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 05:57:37 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 05:57:36 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Feb 2026 05:57:36 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61RBvApb3689228;
 Fri, 27 Feb 2026 05:57:32 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <anshuld@ti.com>,
 <d-gole@ti.com>, <n-francis@ti.com>, <bb@ti.com>, <jm@ti.com>, <s-k6@ti.com>, 
 <afd@ti.com>, <u-kumar1@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <a-dutta@ti.com>, <neil.armstrong@linaro.org>, <semen.protsenko@linaro.org>,
 <peng.fan@nxp.com>, <george.mccollister@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 4/6] configs: am64x_evm_a53_defconfig: enable 64-bit
 addressing for PCIe
Date: Fri, 27 Feb 2026 17:28:32 +0530
Message-ID: <20260227115841.333073-5-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260227115841.333073-1-s-vadapalli@ti.com>
References: <20260227115841.333073-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|BN0PR10MB4838:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae3d0d2-72e8-4915-9389-08de75f76758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|34020700016|921020; 
X-Microsoft-Antispam-Message-Info: vQbhqCo9Ta1eRdwhRw2ADGjj+2pPICPhOS1a5aOT/NIT5PWCNftCOBPWzSD/ORJIbVb7qdKKWiau9RyhnYIfZh41Pizh4B5WwRsXfcSNw91CMlnkVITNiqO0aO5U29FfoEUwu0qhZsqFa1dCQNHOnOoh5A9XNr98C7VGDzGv2GK2K/f8FELx+9f2vWFUpckz2E0pMGhyKxn71A+kdOdw9ltGN49UKlccYxfCnnJQbxz+2ZQD5/TD2phQk4nXExRhv+Tmcpixpihhh781p9fr2ce3yUnU3uvOiE2U5e1w3/xKuu+QIoAU5Gg60m2YJxxZ8Pj+dlEpuQFIcCBbSXEytSLDQEy7iqnF1SSB0EepG5gqhD30uT+ODtMs0CBElnR978JAK/uHwF7UXZYbKSG6smss0vsETo2ObBHDh1YIdZFvEqhlJw9oaaFGrLWbOnJ2CFuR9YJUQ5zXc+DCrEUB+f2sTZJCOCaUU6JEjdqihQSAEjHmXVl8bSe5xA13f3WSrJotztLZdczuTd/JTrWl7TTCQfP9tMwdymMcPTnRWYL5phiiXu61nO9/4VZAHZXhf6BdpZrs2yezzaW2CQ1p8XkQmPqtFdxvqxMWR1+zTZLyJyPv66dM/N7jiMT26YsrsbyjlWdJs0sE3LHQuGelehZpX3hiCOvJJ2sMZLmNafaczwH2o5j17wQK1m/N/8VVXCQM2aYGhuUHnhef23OEOfoNyMBf2z5LhXKeCdlxSriAuBDW6Hlw0S9t08NFto1oFviEr3S6LrYqvCR0yL8cupP/F0l2sDFbyXENthPoa41yAekEFylVJs1Sm2nt8V4240b+oo3v0WadPMK5VDG6kpeAuaVCaX0aEwxixaJ9Gwc=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(34020700016)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cZIHSn675jdhsSNxqjyTFtlWtqx27AOimfCeGmK1+Ztob36AG/GlXTFdBm3+i4gjBKlDdyTYv7S8AUj2ZRPGQG1hDWrezYJYEoyD0jvEnVPDjxCdUCvl4DOkTR1l6yoU15kxKqRoinEpenho7zLFG7/472ObC03Pzt5INgfLnDnfnVVQd8VSPs5++t8ko4YqRYk2QKw0UUjats4slzqqZFyQ8kvm5hTWz8uhZ8TY73/0HqcGPYOuKDRKQIdXMKi2Xh482C8SSoug0DVJGBC8bWaxbc2RdXovaU/NDWBpcz+Vr2E415oL3cjTwOK81lG1XJLs3nTEJigA50wziqBtuQhWCz1UXrPWIIIPBxFQYlHOzC4caVVIrEJtvtvDoTNcUn0Nb7wqCAzWLtO860tNFgr7nuCwKftFn2EXFr0XWTOL3Nw3gtq2e41rjgmHMs7q
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 11:57:38.3156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae3d0d2-72e8-4915-9389-08de75f76758
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4838
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

The PCIe0 instance of PCIe on the AM64x SoC uses the 4 GB Address Window
starting from 0x6_0000_0000 to map System Addresses to PCIe Bus Addresses.
Hence, enable CONFIG_SYS_PCI_64BIT.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 configs/am64x_evm_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index e576012b3f6..3a35df830e3 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -31,6 +31,7 @@ CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
+CONFIG_SYS_PCI_64BIT=y
 CONFIG_PCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_BOOTSTD_FULL=y
-- 
2.51.1

