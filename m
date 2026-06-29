Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B84C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 09:47:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3523984A48;
	Mon, 29 Jun 2026 11:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LnJc1J/o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71EE184A12; Mon, 29 Jun 2026 11:47:05 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3851984A17
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 11:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSn7bLFiKzeAZM3JYvIQU8dho7QYH9cs0A6+f67ohpUA8mwVsisZXLxZDLu2CiWkPlEjb4zGQT1cVthzXO/4T/oMJN/7VPSCJyKuNDYEu1N93q4748u9D6YaHeywUw5MXuWYk46R1tQUMon1sMgHX4goMq4Cx/eNI3bIvFvd8RZwpPylRgnmw+qob/YE0zCYQdzVRmlupGwJaTQdFaOeBAsFw8jfYfXiHKd4l5oLH8HNSh4N/3rLPTsWRcmAtteUyL9AGSIOlNMcDBNUDyvDLrWLfn7rS0qMJiuBc5lwk/sUO9atcCLHjz0mCJjsUGCVsOGO2XFRsTAW2/fVHlwOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zU4syVo26RtwqqZjS5vQMgXfiZeckd6gFN8Lrz5gSUs=;
 b=WIaepVV17Sxl/0fQWvJ0jsg0OnwSLS7I8JfKWOjldnufervafEvS/+ZwLnkB5gnA/bbHBfJVuC2KXHJiXmpzoB4wmDt6P+giE8FErUDXq+XeV86ejmTHTVfD/I6WSENuvigwUVjLI7ACX+LssI8neuwSMMm62tUjjLQcGt89HoB2HJbvJIlztXM9DGml+EpZC4qqDxWIy4XH7p7+qpXY4RxFwVklGqxQkvjinXQViLOjjHJlssbvPNWPWpqqKXXp2g8j4I+nUWtRMsjPqOwy/iIYY8wT1w+Md/Fhkj7dRik1/izHOI1YeR+Pu4/SSWqaTwqF12ccL+kiFGtdYBf70Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zU4syVo26RtwqqZjS5vQMgXfiZeckd6gFN8Lrz5gSUs=;
 b=LnJc1J/o1kWcX01AUE765VIjAhggAFUz8WfYN0LWwC24fgG1PsbrdrLCVgNqba4Iqod0sivLAShSByoKO+apqCbgD8EORapFrnRAgXklkfWwy5ixuO86VPdu6g9SBaL7JyOymYwHx7vjtTQ03P3PhsdzW37c8vOfFbB+OAU7aaU=
Received: from CYXPR03CA0003.namprd03.prod.outlook.com (2603:10b6:930:d0::21)
 by IA0PR12MB7651.namprd12.prod.outlook.com (2603:10b6:208:435::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:46:59 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:930:d0:cafe::87) by CYXPR03CA0003.outlook.office365.com
 (2603:10b6:930:d0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 09:46:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 09:46:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 04:46:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 04:46:57 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Mon, 29 Jun 2026 04:46:56 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, "Rob Herring (Arm)"
 <robh@kernel.org>, Rohit Visavalia <rohit.visavalia@amd.com>, "Shaikh
 Mohammed Suhan" <suhan.sm@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] arm64: xilinx: Add missing newline in kr260-revA
Date: Mon, 29 Jun 2026 11:46:35 +0200
Message-ID: <ab6f006ee87efb54ee17f24a12c9f31aafc2f2ae.1782726386.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782726386.git.michal.simek@amd.com>
References: <cover.1782726386.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=581; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=FQCYQLn8VL5Q2sJczga9VQDeYzCj9nxhhs9emfqCLHs=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ52f079/I2+2RRtwsX3i05+ftI2/y4PbXsshoOZ/46/
 dl66n20VEcpC4MYB4OsmCLLdCYdhzXfri0VWx6ZDzOHlQlkCAMXpwBMZJIVw3+n1JLc5DvR22fb
 bi6Qv+Cz+moZR+YjHd70o1YrjctmffZiZLjvvUSnuXbzMY1ecVajSeJ+K17+YnJZ17iiWejaTdO
 6z7wA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|IA0PR12MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c36b882-454f-4e53-c7f5-08ded5c35ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: qfqKoNsOZcrrZ4nNAHVOZIipShsRHjTzwgtsOu8rPj45ZRRY+puxwh4Cs+23p+MXSKQAjH+1du9eNGlDtFeI3D3opyiOe2DN1Rg6L7aOOot4bUMyGSoWkdm/4bC5SWO4sg9DITPevE9/OXL26cJgzkKYi6Laziiz14UYgUNFZply6htvZ5v/ab5hZgh30F7V6PaYi/pXoHsxGdzJVd7Au3ck60SmPz2Mj46afOXU9WVE2Upui29QxyX3b/UjxQ7LWWWT7IiHBOZpEML/9On3JCHDcuGRORNoeh+gAhN3GihafsrFHOWO2lsK03Pm+3yESBJX1yxqC58DoanwcVoMBeYi2SHQIkYCWmxEc0AEvsLImVAOEfWe1rcTdkJoCfEJqrQVHvx5ksGdmIXVBcatWUwB0C+qBILddTqkZiW7m5pmJIMFL3QzLiT+S1U4rOT1OIYbHuNHZUwLJRjXXdzPRUYz8IwgbG5n7YO7GLXxbPSmv8BLAxd/bKcEB92E/VWzdzJLysYHxaLQMRClQGdvOgMQe61pG2rSqRI20flnuKrrRjlPZfqsKtc2JwaFrRiGTp7YYH1UgpT/WVJHLjT0f4NqZSl+I8qD9uh13I6iZuLTSimQMDCzxgPlpKSQZGGtlXpxOPafuPBRAOBnOz2h0DJXTdBq71RyEygCyj3OQU+SgkruxdrvNI5fEcw54FJm/f4K1wm2xxerSl9KrutU1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mvlr+p8o0+2F1ZQRF6S0GTwX8qJLwEAKQZ/XP8azStuAofkWC3qS1LOjC4Q4Qld+cod9ifJL7If3pRWxaGk0JN9/zYfgP62DtUDw4bjWmruCqubUne6E/KfJnAztvEIKW0yCBtmB0wdDL3oZ6KNwAbYovaUd1sRN8ZUZhvteNBJdKb8Y4yYBWibKO2oOhxyrHB6Ar4fUjSGS754Mp6pee85oUa5xICP2rttmiaLqILJDZzyR2QAqOsiG1UUHfztTNq3g9DLVCqvOahcT+KNzIBgWrimWL0Ovj+hOplxukXqmm9IcHcWi7nxQ7nmt/1KNOGGSxgRMzH2VUZZMZ/iv1UdtdiHfrNFRtx9/ij28J6bIFtjjRQsHLfEnqmTnPb7hFvHj5I9jPZueFvbZCFZjBTJ8qIwTtpd+fj4C6UigU2kJkR7rxSlx+1wsJBGqu2dJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:46:58.6235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c36b882-454f-4e53-c7f5-08ded5c35ce4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651
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

Add missing newline available in Linux already.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
index 2bc28b7baf85..31b3c3582c27 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
@@ -66,6 +66,7 @@
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;
 	};
+
 	dpcon {
 		compatible = "dp-connector";
 		label = "P11";
-- 
2.43.0

