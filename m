Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1175CE7AB9
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0850188D1C;
	Fri,  6 Sep 2024 09:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bbeNiZWd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FED788D13; Fri,  6 Sep 2024 09:08:53 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3658F88D09
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONYbYmw500RfjG3mtRczhyYlB18GWf/ozug8btXnjrq2wIUhg9DpWI2l7RH93EBkDCCYFNxb2mBXhqvCFACGKtmDGYlVJJrRW3x2pCL0T2SeTXeXAFqBm+NWdNiu8A437tM7CoZL0JcejGFTs1BGEaZ2KCUHXU5viawL1Pc/KjwhTFMw5FqfgpAP8d5W2Rd0Aaicx2qLUHKQX0W46GUCngx2YgdMTfPN3sR+DaS7f8YPCjIKQ1tW4Do9au7iXviu4iMHI7cfR/Ee1jlMgFP/7lbJ3T8rZVYKd3JoIinUuDt3NqNsKcgsN64bZ+08PL5NuqnCj9MHkaNg01djnVquGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjPPOAkBuM0klSWyrFyGETCn3RHcEWe/cWTTh5FKMt8=;
 b=Cn1cAfIQXKPZgyYS/ST+ROdv75MjoUomNc3qvfcmMzPAnhxgiWRfTt7hfPpg3eYrhIS+MVD2MUCPOzjs6UPtR7V4sxjwOPNklnvQwDK3Om248oInk1ZlWAGz3HxCG9t74CHg9dB78VudKE/Xze1eJp9dROd4WWKyw3INvqLB30uwktZ0rTd6g5P0XKck1wiuYI36E9rt5iLOJLXGUtPH2kxvdgRoptM9ylo96OUDsYkCkL7VvFAF6ys0/lyEnrAoEQ8eNzKhBwRmmTGftlP8dNgRFFzdnZgLLRxVUeMX3xtw5WeFxEM41p1dYEbKf6RlyAmnI7auqh3jkON1Qd3ILw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjPPOAkBuM0klSWyrFyGETCn3RHcEWe/cWTTh5FKMt8=;
 b=bbeNiZWd4fv4IA2Vz1ig3wbrG/H8CTlPpJ6A5dbYdhU15Ojf/RJ19N2RjBbfoom4vGHiGNC6lSxYaEBpn0i6Jyr6eG8voyK7IMdWLXFECt2WZbfrRzddCOGy4dynRI11hA5dGIC+hoHpGRDncWTTvdWnDvmDKKiiDW2kWagwuX4=
Received: from SA0PR11CA0153.namprd11.prod.outlook.com (2603:10b6:806:1bb::8)
 by PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 07:08:47 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:1bb:cafe::9f) by SA0PR11CA0153.outlook.office365.com
 (2603:10b6:806:1bb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Fri, 6 Sep 2024 07:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 07:08:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 02:08:45 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 6 Sep 2024 02:08:43 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH v2 2/2] arm64: zynqmp: Remove overlays and add new dtb entries
 for ZynqMP
Date: Fri, 6 Sep 2024 12:38:08 +0530
Message-ID: <20240906070808.1045991-3-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240906070808.1045991-1-prasad.kummari@amd.com>
References: <20240906070808.1045991-1-prasad.kummari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: prasad.kummari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|PH7PR12MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: 14529894-a8e7-484c-ca46-08dcce42c05c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mpgMZkgH0M8RzERt9BN0AHOyP61/PjrGSZVoJN6Y1OW/pq01xg7Ws2Nxot4M?=
 =?us-ascii?Q?PvZYrVprfwZe4jGMnixvOq2O0zuLQc3KFtHomkRiwdqBA2IEgbD4W18o1h7N?=
 =?us-ascii?Q?BJPBUaz1yuMgnaMuFNgIv2ozWIDL1eukQ/vGs9M+2tsvIlfegHWBz7l9zt9k?=
 =?us-ascii?Q?xNHuIYsDr9z7BKtkeNRbPzQ5DJgQmG+Kx9aarP/2H/qa7OfbWKn84r4DP1rE?=
 =?us-ascii?Q?YY4KHOHMC0wuCOYhHyhcNXEgbCLeFXob2yq4JNy9FKeiNF1bnSiaf97mdAre?=
 =?us-ascii?Q?wJs5zkjmH6m2iMzqPpObntr/ypQ8Bqq/27zQHCagqSt5TXaLm8PxXgySAnxo?=
 =?us-ascii?Q?WmlTtXYAI4gM0KVdHETpCxW9ITR1z3rUYTREW1bbNuCE5SLC0CIbSm4O0Mxk?=
 =?us-ascii?Q?SasDU0p8XWi1DLTCOgyejRs94H/eY2hufnA9JvrbKhGIazcQXashdmPkUhYv?=
 =?us-ascii?Q?E3oCdmGsG0XQqVcTc5bVcl/Tu5Vjs/BKUclse7iSKAJ5IOA3JwSxT5YeaUa9?=
 =?us-ascii?Q?0M1hP8+0ZEXZuZOKCGI1fzP5XswGMBDzNx0dI5DEUpFwgfMiQxfjAeI8+v7Y?=
 =?us-ascii?Q?/LwE4ofumF4+TAPwwQ+Se6nEBWXJnQw1HWb3AfFsdODTZ3v/7ta4/YhE2P2H?=
 =?us-ascii?Q?MBN0x8SPGN3Ox9gxwZgC/H9a5QBd6iFWXjwHpDxu4xzMBVBfC7mpSZZW74wK?=
 =?us-ascii?Q?b7EvkiMLGjWSyF4sLkMA6mbnW4CjkivbHA/TE9OZo7rvHnSdqh5fw3xx2F8y?=
 =?us-ascii?Q?9s1J8PrD+Hqq34LVyQAKDzdwiROwP6wbz40KOYhyvBDCtc4MJRaBfybQOUCp?=
 =?us-ascii?Q?JuTWFfqTJcPlqSZmkhxwIM0KUb2Dlj22ndDN+PdYt/PvJQuJgojioI/PmAMC?=
 =?us-ascii?Q?hSS8qvv7DdTb31YZ39UTaBjR4pFdTFfQjYULLxYC7tUbsD7rN4q7eOEUaRVl?=
 =?us-ascii?Q?82r1q4O6WvWnenC4f0f9RlCqGjWFOgD3g/QZOcBVJnv+KuRZFz7Z4MAPJ20m?=
 =?us-ascii?Q?Gfp83K9OASg46E0AQFKkARPVpn6BR4ZTkn2sU4VWqmkPU03OMNU7rHEPGlYF?=
 =?us-ascii?Q?7X7NkV9C1+hzITha8VLe/qd5OAA9yOGayguSc1rDo4MpgJyFnpl4I5PAdJ/g?=
 =?us-ascii?Q?9bTKqfIuuwIpNKQL4V7a9p7JV+q5GmD9WuPemANWN8Ps/fNX2JChzp7ZULXr?=
 =?us-ascii?Q?x2LLIsr9fm+5OHVSm62kICQXGHhNMRe3k/vHs4n64brMwgTBHotia8Az0AMp?=
 =?us-ascii?Q?ZNUzIWhhkhV+uTz8dv8vZ6nC12/oPTFGt2gHXvlCcDC4lWB7xVMp1QsNzloM?=
 =?us-ascii?Q?kL+Im8aEqGiWWfDgs4fydYWNVk+Bb6i4qoKRWYRRiJW7pbCngbZdbmHKYeTA?=
 =?us-ascii?Q?Z4dPXBU3D0SJ5Pmw0PQOBzlJOTDWyMOh/NCU0wHD+MSqPLSr60jpBlG5b7ZK?=
 =?us-ascii?Q?bSeBznjRlnhNDCIlke1bm4ckl9WD0Hyb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 07:08:46.9456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14529894-a8e7-484c-ca46-08dcce42c05c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934
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

Remove device tree overlay (DTBO) entries for the ZynqMP target
from the Makefile. Add new device tree binaries (DTBs) for the
zynqmp-sm-k24-revA and zynqmp-smk-k24-revA configurations.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
 arch/arm/dts/Makefile | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index c82fbeb1e1..9ed0c2487d 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -262,11 +262,6 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += \
 	zynqmp-m-a2197-02-revA.dtb		\
 	zynqmp-m-a2197-03-revA.dtb		\
 	zynqmp-p-a2197-00-revA.dtb		\
-	zynqmp-p-a2197-00-revA-x-prc-01-revA.dtbo	\
-	zynqmp-p-a2197-00-revA-x-prc-02-revA.dtbo	\
-	zynqmp-p-a2197-00-revA-x-prc-03-revA.dtbo	\
-	zynqmp-p-a2197-00-revA-x-prc-04-revA.dtbo	\
-	zynqmp-p-a2197-00-revA-x-prc-05-revA.dtbo	\
 	zynqmp-mini.dtb				\
 	zynqmp-mini-emmc0.dtb			\
 	zynqmp-mini-emmc1.dtb			\
@@ -281,22 +276,10 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += \
 	zynqmp-mini-qspi-x2-stacked.dtb		\
 	zynqmp-sc-revB.dtb			\
 	zynqmp-sc-revC.dtb			\
-	zynqmp-sc-vek280-revA.dtbo		\
-	zynqmp-sc-vek280-revB.dtbo		\
-	zynqmp-sc-vhk158-revA.dtbo		\
-	zynqmp-sc-vpk120-revB.dtbo		\
-	zynqmp-sc-vpk180-revA.dtbo		\
-	zynqmp-sc-vpk180-revB.dtbo		\
-	zynqmp-sc-vn-p-b2197-00-revA.dtbo	\
 	zynqmp-sm-k24-revA.dtb			\
 	zynqmp-smk-k24-revA.dtb			\
 	zynqmp-sm-k26-revA.dtb			\
 	zynqmp-smk-k26-revA.dtb			\
-	zynqmp-sck-kd-g-revA.dtbo		\
-	zynqmp-sck-kr-g-revA.dtbo		\
-	zynqmp-sck-kr-g-revB.dtbo		\
-	zynqmp-sck-kv-g-revA.dtbo		\
-	zynqmp-sck-kv-g-revB.dtbo		\
 	zynqmp-topic-miamimp-xilinx-xdp-v1r1.dtb	\
 	zynqmp-vpk120-revA.dtb			\
 	zynqmp-vp-x-a2785-00-revA.dtb		\
@@ -367,6 +350,8 @@ zynqmp-sm-k24-revA-sck-kd-g-revA-dtbs := zynqmp-sm-k24-revA.dtb zynqmp-sck-kd-g-
 zynqmp-smk-k24-revA-sck-kd-g-revA-dtbs := zynqmp-smk-k24-revA.dtb zynqmp-sck-kd-g-revA.dtbo
 zynqmp-sm-k24-revA-sck-kv-g-revB-dtbs := zynqmp-sm-k24-revA.dtb zynqmp-sck-kv-g-revB.dtbo
 zynqmp-smk-k24-revA-sck-kv-g-revB-dtbs := zynqmp-smk-k24-revA.dtb zynqmp-sck-kv-g-revB.dtbo
+zynqmp-sm-k24-revA-sck-kr-g-revB-dtbs := zynqmp-sm-k24-revA.dtb zynqmp-sck-kr-g-revB.dtbo
+zynqmp-smk-k24-revA-sck-kr-g-revB-dtbs := zynqmp-smk-k24-revA.dtb zynqmp-sck-kr-g-revB.dtbo
 
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA-sck-kv-g-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA-sck-kv-g-revB.dtb
@@ -380,6 +365,8 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k24-revA-sck-kd-g-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k24-revA-sck-kd-g-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k24-revA-sck-kv-g-revB.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k24-revA-sck-kv-g-revB.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k24-revA-sck-kr-g-revB.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k24-revA-sck-kr-g-revB.dtb
 
 dtb-$(CONFIG_ARCH_VERSAL) += \
 	versal-mini.dtb \
-- 
2.25.1

