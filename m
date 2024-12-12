Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AF7E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 08:13:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D50DF801B6;
	Thu, 12 Dec 2024 09:13:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tDMTtAVV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4934D801BA; Thu, 12 Dec 2024 09:13:00 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFEB7801B0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 09:12:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQ0fJ0dmwujddIOJ6b1vg2R51PQLPsmLW3nu8oHY4rg5DisdjBL5DrfpZfWWHQEPoNIb+wOPEwF9wAsYeEeE2DN5mQCmCp73BY/0o9KgWPAoLBB7uoaoNG3ikYnorLqxxBvOVN/sBqnIulAoa37Zkm/xEtQw6rpZEReWWcbG30yllZ+ZUzlxWmfDBOvs5A/VOE1ucwVk/wSKSUP8OLDDk1Ky1ekG2EseNjTa4caTKEfedwaSVbjGvUj+EXbG6lyfsdUoaey4qw2XTJ3U3Zcxu5Ms+6X1+NfpWwN+RZI2VL4BFrM5+8BCJQHw4NcCTFPer/95cyJRBkovDX1Tm7s9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNOmmoiiisaSoZ3oqoqM+7Np/mRkYi5Hy8pcsmHQRwU=;
 b=iobYVY3XYIey3mx4IN60cVQtrA+SsrdJ/a2kvVS4ve3yfMvxKp3dB6lpcyDElNxs5Z/ELr5TDaICsjCYN11jHPMcColu9Xu62ztWzB+cAoywsxo4SbY7DzDPaiuBX+CJn/wfnh8Is/DSOEtcA5xK9dI4rLFsb8rnUJBKnhK9SB2O5a5KZnvnalTm/Yn+P0urkVeuHAkYWszifkxh6/mdA3WDuWAZdCfSGYHIAWvuwjosz5ZJBU8R3kh9t8hAXE9fcjDLnsct9YIdeHUiqmIcL/6697N39PJ1HVZqzim3mFAEEdbD+jeFkowRCd2QGJHAaPnYVsX0Ao8atsSfdjyw+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNOmmoiiisaSoZ3oqoqM+7Np/mRkYi5Hy8pcsmHQRwU=;
 b=tDMTtAVV0jamoNg8XdXsX/R++/q3jbUMjzsOWegWEEGVGtkMGejzNJiZ9kja+Y6E38iMcktcevDsbppTIdixDqr0/nHRsMrci0RxYBFpU0z8Cnf9VzqS2CfwjjWfa+ex2YQbUPHIGZbexgHbXqlKRuUuPqTAJO1zX1vH1YSu+5M=
Received: from MN0P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::11)
 by MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Thu, 12 Dec
 2024 08:12:53 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:208:52e:cafe::d4) by MN0P220CA0021.outlook.office365.com
 (2603:10b6:208:52e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Thu,
 12 Dec 2024 08:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 08:12:52 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 02:12:49 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Naman Trivedi <naman.trivedimanojbhai@amd.com>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: add clock-output-names property in clock nodes
Date: Thu, 12 Dec 2024 09:12:41 +0100
Message-ID: <1080e31393c3e1b49735b77e7ddc14d570b83222.1733991159.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1921; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=KqNNljjqFctdz42vxpj70wGzrY0dKfoIDpmkF2cNT5s=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvSoWb/dTylOzisuCGj9dLIthasmWWfyux8Ln0TcnN+t8
 fe/ucSnjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRD/IMCyYW2SebLGpbWX1m
 vmvcHWWVz+YKpkDRb3ynZGubO/6bc0dJz61ZvvtApBoA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|MN0PR12MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: f4efea71-14e4-4eca-4fbc-08dd1a84c6ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uN/wr8duXo4mTZjqyx1PuUuSr13nsdqZJ/sw+ElreOyVqOyYUQIPqoERsBXd?=
 =?us-ascii?Q?ygqpp8JYpvk0LnBWXXzCfoWu1M6XMwsh+xCGACPYxv+XIma8h9iIRa3pYNTR?=
 =?us-ascii?Q?ZJOlY5DEpckdH2S3/20uD8KOLSz6TYrJrY0OzRFajKJAKpW3/9nZPzzOrVjm?=
 =?us-ascii?Q?AxugNGFAoxuVhVDkbdNgIClyF4KCG+TpX0zi+Rvrx2si2BWxa9cP+iPYZclz?=
 =?us-ascii?Q?bxORER63UKYTW0ZYQon115CfgHXzMjVsYWz41YZMf6HgVprbiJPgcbDBZdBe?=
 =?us-ascii?Q?0LRvV/3J5HaGDnLZNBFkNga4/Se5k3oZmRNTg1P/R3K+rHcsuXGvl9YMHvFU?=
 =?us-ascii?Q?+mSssEqd3h5bvQSVRIjHho1FL6vMnircnUbT4temRKx+uXzHf3Zh9r41P5DZ?=
 =?us-ascii?Q?enEMq/HaAIA4j2HyCDCOWH6xKL+IalFtcoIghJxnnbXp4bD7jCXV6j/JSj0r?=
 =?us-ascii?Q?oFtPa34dkorAFR70IiuMNL7FIygL9vnM/ChJR3GIMAoETTj1vnrtLnIux0zn?=
 =?us-ascii?Q?7O4K/WzeFD5Eys2GJMO0fGh7ssqHUhA7jEqIh+YzLLaNLeO0mv7FUZ1xCoE0?=
 =?us-ascii?Q?eSE1rTz1LUcRorjYQ/5R4kMaaEjEyK+YTFwjdRBrr+l8beYe2Dwl4jHzKItT?=
 =?us-ascii?Q?miTvrWSrcDkZHQFGJyp4tTe4bMC/PdaOtr48IHDK82JNAwqFDrBwJQTsDdrX?=
 =?us-ascii?Q?X1zCKjZnMpOPlmf9vPVac//oOBfn7vXJ+Ux3U14m1Y6DA3K7NvwG54T1aNY3?=
 =?us-ascii?Q?i2zHmRg/Mwa3F9VOMKTNzNixA/aw175rsccPqpjoxHnbNa1T18fK4sg7eqc0?=
 =?us-ascii?Q?rMZVoosvWvtWyuWs0Bd3fcfVpaTKgg14dbtikKowde4+ZQY/umFmw3anGyp1?=
 =?us-ascii?Q?m6zI7MpykeiXNvFmjEI5KLK05ubnuK3McT/8Tw25+NlPtg11zFlWBZPstHKS?=
 =?us-ascii?Q?bnzYg0NwjDk/Ocp1BpINVVAPwMGbAOVN2IGNfqFW9PQPXQdO547+XglB+gGP?=
 =?us-ascii?Q?aQ/8eC5SvR1NHEAqUOtW1OKzbcZwYJFeOA/jvPGc0STTLMHGmDMcwYtC+DBz?=
 =?us-ascii?Q?b4XZxbPH+gvtESqcALGWAAU5aRzMKVd6MHUjqCMQOA9/HODFMmZnFCEqt4Og?=
 =?us-ascii?Q?5Db+qlW2PmdjnEt/HFomATZO+eAy2hHPG06Obn1yrhBSuan/coSOU7DAsyat?=
 =?us-ascii?Q?KnU7/kPjR9vBbdoSpB/J4wQofcz297YhomE0go1f5CU87yWO7bTgkNs7hlYK?=
 =?us-ascii?Q?7Ft5fpLVcjsGoQ1CZBnXYNpG35JffGIltPJz30DDfeo4iDwxy/w6SqpANE0Z?=
 =?us-ascii?Q?CNHTtkCc2b2Rjfx82/lyJTGdpryTyyE0H98h6cCoIBPUA3QOn2ilhU1/XZgA?=
 =?us-ascii?Q?NXPhpmF5nC7MD4ditX8dWSiZ5tu7CKMktwXTqbrUxxzD5kk5tBoEa7HeMlEr?=
 =?us-ascii?Q?O2et11XhcIdP4w9UE9/bcKRrs883GMnV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 08:12:52.6883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4efea71-14e4-4eca-4fbc-08dd1a84c6ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078
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

From: Naman Trivedi <naman.trivedimanojbhai@amd.com>

Replace underscores with hyphens in the clock node names as per
dt-schema rule.

Also, add clock-output-names property to all clock nodes, so that the
resulting clock name do not change when clock node name is changed.

Signed-off-by: Naman Trivedi <naman.trivedimanojbhai@amd.com>
Acked-by: Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-clk-ccf.dtsi | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/zynqmp-clk-ccf.dtsi b/arch/arm/dts/zynqmp-clk-ccf.dtsi
index 60d1b1acf9a0..385fed8a852a 100644
--- a/arch/arm/dts/zynqmp-clk-ccf.dtsi
+++ b/arch/arm/dts/zynqmp-clk-ccf.dtsi
@@ -10,39 +10,44 @@
 
 #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
 / {
-	pss_ref_clk: pss_ref_clk {
+	pss_ref_clk: pss-ref-clk {
 		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <33333333>;
+		clock-output-names = "pss_ref_clk";
 	};
 
-	video_clk: video_clk {
+	video_clk: video-clk {
 		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
+		clock-output-names = "video_clk";
 	};
 
-	pss_alt_ref_clk: pss_alt_ref_clk {
+	pss_alt_ref_clk: pss-alt-ref-clk {
 		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <0>;
+		clock-output-names = "pss_alt_ref_clk";
 	};
 
-	gt_crx_ref_clk: gt_crx_ref_clk {
+	gt_crx_ref_clk: gt-crx-ref-clk {
 		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <108000000>;
+		clock-output-names = "gt_crx_ref_clk";
 	};
 
-	aux_ref_clk: aux_ref_clk {
+	aux_ref_clk: aux-ref-clk {
 		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
+		clock-output-names = "aux_ref_clk";
 	};
 };
 
-- 
2.43.0

