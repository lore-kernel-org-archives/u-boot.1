Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D7DCCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 15:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2AAC83A56;
	Mon, 10 Nov 2025 16:25:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qnOPIXP0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60ED683A56; Mon, 10 Nov 2025 16:25:01 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EAF883A03
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 16:24:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RihGf3O8m92gt46g/HeJSI6G+WpIeMXZAYxstfRW1LWibUwZFz1Kt9TG+zI5Zd2uHTyJpiQ1P1eN/Ikjh1o4ikgtd+zxtqHZTPIaxycSsvpIq8RrkkruvW0/u461M/VB9s4YlR+X9JWCFQGMhmoZkTN3aLX/7otC2H8ulYHuzo+B2Utl9lJjIKY7KKjsHRKam/fE85Xebap3HF4WRClR+ksrhoLzRGidhS5r36wzwGEftgLol/Mh1S8LC7t1RhvYiraSGF5fEYCmUsPokW+qkPpkXSeGrzipVq7EtX5BYlAFlCAr0vnmFyXadudzM/R6gD+pjfk1LORucFdoqgOpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eXtGV5qk/vXZUJ0eJsX1KxLv+Ak85a9d5K6N+YiiM0=;
 b=VusM/WcqN+m3hht0yigpMmHSFCMD7ILQkeU/3+2L4/xvRjo+QHrqmaY5Pi05ieXq3tmKuX8rvuE7R6QAJ8vYQsIOwgXMx3dUlu278UgAHIuvJM2rInSALRTXtjUGw0X61Niqq7vE1cV2mCjAzJdKcfBUYCjWgCeVFNMNoX2RchbvkvihNX3PQ8pcd/1ksGvASXQbS/QMhwBnInvMqSJ71fhyda8rT8P9aN/vf3O11sMzwOkHgEhqy3ruXSVVT+f8LG6tkOIwak86Hm75lMNpie7J2AbXRdpTs+abkIfapp14VbN59ZZmQoSUxnq4aEdoIOpAYNxXSm+wrjxwAPsLtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eXtGV5qk/vXZUJ0eJsX1KxLv+Ak85a9d5K6N+YiiM0=;
 b=qnOPIXP00hzGOhqUwMU0llhvfYy0DxWsvdjltRvdF4rA9UQyd2qtN17f6lPOXjYCzFprEuqvk5vCglTfdK4qlMoSfaZyA2hTBKZCHpDPH5LTY/HxTkD437wtJEH5wO50xxahV6quK7KqH9LPvRhaDqWo2gtgTcTeAUPNIMCguW0=
Received: from SA0PR13CA0023.namprd13.prod.outlook.com (2603:10b6:806:130::28)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:24:46 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:130:cafe::b1) by SA0PR13CA0023.outlook.office365.com
 (2603:10b6:806:130::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Mon,
 10 Nov 2025 15:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:24:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 07:24:25 -0800
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 10 Nov 2025 07:24:25 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Casey Connolly <casey.connolly@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Naman Trivedi
 <naman.trivedimanojbhai@amd.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Prasad Kummari <prasad.kummari@amd.com>,
 "Sean Anderson" <seanga2@gmail.com>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH 2/2] clk: versal: Enable clock driver for Versal Gen 2
Date: Mon, 10 Nov 2025 16:24:13 +0100
Message-ID: <e83c665408d1453a464dd02cd2a25bb0ed267131.1762788250.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <16bdee56fd75113c6d531bae7a8a34900b10280d.1762788250.git.michal.simek@amd.com>
References: <16bdee56fd75113c6d531bae7a8a34900b10280d.1762788250.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2598; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=OJhe86U1579yamWmC+mnziGa2SH7jTNd9dMOwTqF1Mg=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQKMc873O7S8/2pdPYdC6m2gkM7l+3103+68YT0dyuL+
 5ET/ph97ihlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJdHcyMky8Oz/p+gnGBt6l
 n6Z1SM9+JyIUkbP8lzyPY/dUa5GCpnKG36w/lCVVpMJ67NJsv/Fu2vHWVbIl8G7YsQNGjz/7f/U
 OZAQA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: e41b84ba-9fe3-4b74-fd32-08de206d47d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MMzQ9dh0Ney1BJUmfHDKVXD/EogygeE4Z9KI1wmX+WX4Jh/HqRM6YfQ0g+km?=
 =?us-ascii?Q?c9Qis3YuAmVCoccGBvmvuaQ3kK6/LHaQ5CYagVzYvifljM7xKHbE2loIhQXj?=
 =?us-ascii?Q?77RDGbaJGK3khwkTHVL/q1oBithu7cdqq1nE06ATxhCAKmC6qggsP9mlLWnS?=
 =?us-ascii?Q?VwaieLH/OCCq2cBgSm+v9Rnaur+RAJVNRqB7bl9efoy8HseD+kthhExlMag3?=
 =?us-ascii?Q?T+y+8yzmNOutrjT6SJlKAFqRzGhCAD7l+6phT40E6yK3Zap/lJ1jisFCBghD?=
 =?us-ascii?Q?rnGVhGywUQv8jOqEQlZLbyV3ymX2DKCfZVi9Q/W2FTNtk1ebQKhl1Ob3oQEB?=
 =?us-ascii?Q?B+o/EJQ8fprxbNpr3WNpIB4/Un2jaI8dAg9PqAw/MO42LDRKiwwOHRBpkFEq?=
 =?us-ascii?Q?aXaembUdov3iztGbEIUip8Nv9QN0bsuAOr75y47dnp2V1T4ApNBInAngNFma?=
 =?us-ascii?Q?7Y+M0IM/KC//VevOx4LHlAUab1to7YPm7BXa+uzJnwQB5ArlXF5wroVlVNur?=
 =?us-ascii?Q?qnsclkQJEcfPNRk85Z7y6y5ZJaY5aNVmud7tp+qMCu18DAyDW/4YtKWebb6k?=
 =?us-ascii?Q?UeYgYB/MBl2aYNQqKHPYeKhJVse5fGBkVnkFiSAMJ7LsWGiN2Z4ctzmHOkr+?=
 =?us-ascii?Q?Z27bXpMOMmHyAjhbF0xHVLQuoeg5JTVyTUKfo0ej8gt4TAb8sKNRSJ+3vCm5?=
 =?us-ascii?Q?2f9kpZM+U+NfvGmor8A+DRApsGEeTubon+9QLIJw9w0vi4qBaaPVrC6dirtf?=
 =?us-ascii?Q?XeWHSb+mItYYXAaxo52t2IyOpo23GJw9zVjuhi5S/3+cmnDzxXcJ3S9c+TZ7?=
 =?us-ascii?Q?vnWhZubtQC5FaE/S+ontH822ZWj2xZTdxZutvbZFTg2Rf0s9R91U5LHN7gBZ?=
 =?us-ascii?Q?HsZUteGw8gBdXpGTKnDwcuXJ6MFv9d13Ribhg7Zryj46fcul9Vusmj7lN/GY?=
 =?us-ascii?Q?9CDDTixQWAQIf/5iMIyjqkqAiSGUT2SXTp+5o2nEaORizJAqKX1odsavNkrh?=
 =?us-ascii?Q?7RLODEqe+wXD4J0nVHPhTkpnrbCUTCy8ehSsu12mUOVKgpBSvf9QER7OBAlT?=
 =?us-ascii?Q?gx6zrXOnojZkInvsHye3CKXhAOW+YiR0R6IHgDuTrrRpT9rnRbY77d7KFKd6?=
 =?us-ascii?Q?plmUCaho7TV/8AdLqMAIRnWnU0oEvFRIXPODn8kSwjTTnktGIO/JKPCF9ipf?=
 =?us-ascii?Q?JZc4dqKLAWU+HXOwk23fP62SD6DxTeSyh6aqOTUPhEVlOoCdEi8sjH8tERi5?=
 =?us-ascii?Q?XPDVJ5EfNAT1ja0WlbaQXElAokeU5ffretIEen5oVpzBWvBWPON71lxbwY58?=
 =?us-ascii?Q?JoFAjkV8FEbzI+2MleQWwYIq1Ztt3rWdPR1IaguX5oCEFj/6VQB4hReQFxDv?=
 =?us-ascii?Q?ux9RaxfDoym3kogGUC4a1Xhl0przHICRCIhkhzuIAcJ+MaKTqcHVdk3mMdyP?=
 =?us-ascii?Q?JzUY+fhw0lIu5Sq2yw+icNJUx3iuSLf07SgJdxquTZgTohyhIoS7OeJYPrwG?=
 =?us-ascii?Q?c0PRic5s3hUdFAHrQbs3h8f8H4lilGMfv2mxtFdQwERZSEB7FnizL6WebYIC?=
 =?us-ascii?Q?D8FhILFZj+7VoYWR7cw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:24:46.1448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e41b84ba-9fe3-4b74-fd32-08de206d47d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293
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

Versal Gen 2 is using enhancement SMC format but in near future SCMI client
should be used. This patch is just bridging this gap till SCMI server is
fully tested.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig |  1 +
 drivers/clk/Kconfig                |  2 +-
 drivers/clk/clk_versal.c           | 20 ++++++++++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index caf4aefe898d..4f0c4ba5c967 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -75,6 +75,7 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_SCMI=y
+CONFIG_CLK_VERSAL=y
 CONFIG_DFU_RAM=y
 CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_FPGA_XILINX=y
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index b884a02bdeba..85cc472b4cb9 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -224,7 +224,7 @@ config CLK_VERSACLOCK
 
 config CLK_VERSAL
 	bool "Enable clock driver support for Versal"
-	depends on (ARCH_VERSAL || ARCH_VERSAL_NET)
+	depends on (ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2)
 	depends on ZYNQMP_FIRMWARE
 	help
 	  This clock driver adds support for clock realted settings for
diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
index 4a498e22f967..78a2410ca21c 100644
--- a/drivers/clk/clk_versal.c
+++ b/drivers/clk/clk_versal.c
@@ -136,6 +136,25 @@ static int versal_pm_query_legacy(struct versal_pm_query_data qdata,
 	return qdata.qid == PM_QID_CLOCK_GET_NAME ? 0 : ret;
 }
 
+static int versal_pm_query_enhanced(struct versal_pm_query_data qdata,
+				    u32 *ret_payload)
+{
+	int ret;
+
+	ret = smc_call_handler(PM_QUERY_DATA, qdata.qid, qdata.arg1, qdata.arg2,
+			       qdata.arg3, 0, 0, ret_payload);
+
+	if (qdata.qid == PM_QID_CLOCK_GET_NAME) {
+		ret_payload[0] = ret_payload[1];
+		ret_payload[1] = ret_payload[2];
+		ret_payload[2] = ret_payload[3];
+		ret_payload[3] = ret_payload[4];
+		ret_payload[4] = 0;
+	}
+
+	return ret;
+}
+
 static inline int versal_is_valid_clock(u32 clk_id)
 {
 	if (clk_id >= clock_max_idx)
@@ -794,6 +813,7 @@ static struct clk_ops versal_clk_ops = {
 
 static const struct udevice_id versal_clk_ids[] = {
 	{ .compatible = "xlnx,versal-clk", .data = (ulong)versal_pm_query_legacy },
+	{ .compatible = "xlnx,versal2-clk", .data = (ulong)versal_pm_query_enhanced },
 	{ }
 };
 
-- 
2.43.0

base-commit: f109829793900e57558d98ed22caf80c1a72b232
