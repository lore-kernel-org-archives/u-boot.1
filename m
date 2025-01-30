Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00694C02190
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 08:09:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23CC780B9B;
	Thu, 30 Jan 2025 09:08:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O66vKfzQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A370681F74; Thu, 30 Jan 2025 09:08:51 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9970580AE2
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 09:08:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFdCbmrPhLVf+8I1melNeVzEkFToUwN5bOUyTThj8b5Lt5EsMFGo+kvNnBAIBISqsVs+nvxsRNvBLzirNwnEeZa52QBxyYlsP+Xm8oSo6RvZdwCHnj6tNf5mPt9dhSmSsdT9FKke790r3u7PLOq50eoCmcaGpS4s/4+YKg331nQiN74Ub0Nd1lV33hbNap/89rPpagh0A9y8+DpS0IvuvysPUruXy/qjEe98x5/TnWiZEcvMuxYSaMTzcb3t/J1Ac2YPzXxk/hqudwCCMmFcCiq0vqv32KiHc932dxQ1SBpRc6srEO7JnLc1amvn2XeU/fYPrloYoW6Yi2pnFLM35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHUwsmESzwC9Mxz0WDQ9quLJUzSnW/WnI0cxuu9ekvQ=;
 b=rAlEptEAyHDBNDLwi4bPFFLNE8keTVdTZiUxZeVBj/GLI5nNuh87y0hL3wlqKTRhr2SZa1MTg5ZMiHEzfZWYVmPZ/medoPzZoEX31i0O8HxAyvzT7caA/iVqrRwnrGLozuqQ1sxW9mFa5omi/TnorKDBb8kgK//nM+iid+VtZMk7Yg7T0FstnWlFPr6qr5rAkzFHhxPCainmb7zNRFzEnodhTF74Wjb+y/4la8u9AoG94/nRYDDoiXM88+CcZPGDQIBEzd2xn+fVndiyEM2UVuxyN+RgiKT4wdkyMiPBsGDXpZuEKiadXy+r+nugEIQ3kHvLXpYcig2woRWweBFJdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHUwsmESzwC9Mxz0WDQ9quLJUzSnW/WnI0cxuu9ekvQ=;
 b=O66vKfzQU+g/xzLk6WJaY3m86+UL67AH9unQ0dE7assWfMoHup1PfYxq2UWrQSeBGi5WHxu0qcy/6RBpUbRAG7ghUSTMDSvjn9ODvu89nmKLfssOIfVQGlTSOKpm7rzzTuirJ7bbvoIGTs6Ad5HxGCA83FccajtpaYs61sFA96Y=
Received: from MN2PR06CA0009.namprd06.prod.outlook.com (2603:10b6:208:23d::14)
 by CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 08:08:45 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:23d:cafe::ce) by MN2PR06CA0009.outlook.office365.com
 (2603:10b6:208:23d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Thu,
 30 Jan 2025 08:08:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 08:08:44 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 02:08:41 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] arm64: zynqmp: Fix TEE loading address and add hash
Date: Thu, 30 Jan 2025 09:08:29 +0100
Message-ID: <6fa4ddb4e51ab142b6239758d4cd745b0b9853d3.1738224505.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738224505.git.michal.simek@amd.com>
References: <cover.1738224505.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=YeVZ79zU8iiQ6ys/69RJ4yC/0t9G37FnXpMipKfq1ts=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTZxo3aNStvTL5l6R7FvOU/T+wkRbnKX+eNrNSqH13wS
 L3yJoKjI4aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzkwlGGuQIzhTdOfrhgp/ye
 SiZG9xobu/Pv1jPMWJ5eanFL74WmZeev54eX7LxWLpIDAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|CY8PR12MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a3e44f6-5503-4997-6ccd-08dd41055114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1p9Ao3S2bqpgPUzGWlisxD1vhcoI7CnfP/TRJ6TEQD2keuh2fe9Ln1+RmURj?=
 =?us-ascii?Q?1Wypj89gn92L6nxU6ujZMJSNkRiO7wrFmuKM8kazrUj4+qWe+MJtkXIGmep4?=
 =?us-ascii?Q?S6JXN9n1JURuykrM6aOfAO8MpH+ck+Z/ZSmW3OVz32zapA4Ir3OL6IrFvPB6?=
 =?us-ascii?Q?m3RvFv81NL41Fek62ETh7xH/VTlfbV6MwuFPHkFbfs2YmNM3VqnIv6JjNvrr?=
 =?us-ascii?Q?zZNTebxDYG1IzjBtVKt15FeOpf4tONnVd/jH38jKMpB1YrQ4/BcRafpxkUMY?=
 =?us-ascii?Q?XqssKMSBvQKiCaAoMBlcV+H89W0FaJxcyaQguIcrZg6AcgyGZ67YClBylAm6?=
 =?us-ascii?Q?y4KaD3aZvNEfTBceCQZdfomIGDFKf/SLSCwmOWaVCaqLrm7xY45V9oUxrYsV?=
 =?us-ascii?Q?hrYN5hFNxxtMON9atV+qiz9ls9pAdQMYJd6PPrs66870nkBG0sW9ENgqagrG?=
 =?us-ascii?Q?fctIThDUuOhL/5HxvS9mvNUDK1FBgMnuR2u9Wo/7HpiC860gkFqfJIV5QQnX?=
 =?us-ascii?Q?+KcdrFgHtLAtP/gnV8EkSmlycav0rwEt3Kfneecfrj7I+UCErowYF4LbxkdJ?=
 =?us-ascii?Q?++s2OrZkat5USHpzYkISLeNEG7lDOJuVm7YDnaQJ3NNCjL+TLbBxsE9M3VST?=
 =?us-ascii?Q?Gp+Zvq8DyqxSuIP6jmCmAWC9PMXR6W/KeuaLzIiOqomST5ek7r79yG4tHeiT?=
 =?us-ascii?Q?Dp07hGzv6Lj95XNvqKRSzmHsSFGrAYQDpLL44hLKO4nqRhns71WPHRDbgQ4d?=
 =?us-ascii?Q?k3gyjopbsHGTAGi12pbFDj/PQfZ2HQpO4UN+6VtlYh0liaVMkcjpLJWXZSWO?=
 =?us-ascii?Q?/hBlI5GxyruTyrJRQAjPFo+K6aBOPfaDq3vosEkGAKzZAxqAVQxZqFtBQZTj?=
 =?us-ascii?Q?C7c+SCGwUHwzcqW/3uWw7rV//QapF5biQzpJexngeNcdZgfNyq+x2B+qQ5dh?=
 =?us-ascii?Q?+oX5Y9aYF4tZK6Egdf2UgDUJsSe9uCLQHq2s5MxYyUAW9JnaV6Tnfe+kDwU5?=
 =?us-ascii?Q?pkwrDiu17M4lch0umcezcYRaymZfO799radgRHD7d7gUWPJ+PS96CCvgJlMb?=
 =?us-ascii?Q?rScaYZPCHpU1rXKoXwyTmY2viXGaw2SXFjsGhcg6HsrW2N9dzLR6gf22LEkU?=
 =?us-ascii?Q?BVJs8jZn2KyeC7Q1MnDzgyqvdfhvWRsry4ivqgazwMRp3wfP8G8oPNWdORW7?=
 =?us-ascii?Q?3jgtYfBQTE/TB598e7z7TILCg3DVOu2bVGsiUwKMZ98BmBsWXJzEaR9uYWM+?=
 =?us-ascii?Q?LUznFQrqbxVTrt1N30o4cuUkuuqemyOZDDZuExjzNLK9/+Zfd0zD/FMbdVXJ?=
 =?us-ascii?Q?Zt+a0JmQ1Murdx6g9YFS2VEPR21by2YZiMH9eF6whTO+Ef173bQSduscasOj?=
 =?us-ascii?Q?64RC42e2REzc6JWxLmPp4QJC2vAYp1fnfhcbSk+wHUs9w62AiEmG7+59nFSW?=
 =?us-ascii?Q?3yGTxSL+WZI8a3VwQNX5cV4h0wYzW2wrFI9CZPHxgr9kS4lFUDhvy4Lg9i/W?=
 =?us-ascii?Q?jHNf63A060Je2jw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 08:08:44.6632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3e44f6-5503-4997-6ccd-08dd41055114
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243
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

There is incorrect loading address listed for TEE.
CONFIG_BL32_LOAD_ADDR should be used.
Also there is missing hash for this entry which is present for other nodes.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-binman-som.dts |  7 +++++--
 arch/arm/dts/zynqmp-binman.dts     | 14 ++++++++++----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/zynqmp-binman-som.dts b/arch/arm/dts/zynqmp-binman-som.dts
index 3d9d8476c98e..e8b7084521c5 100644
--- a/arch/arm/dts/zynqmp-binman-som.dts
+++ b/arch/arm/dts/zynqmp-binman-som.dts
@@ -146,8 +146,11 @@
 						arch = "arm64";
 						compression = "none";
 						os = "tee";
-						load = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
-						entry = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
+						load = /bits/ 64 <CONFIG_BL32_LOAD_ADDR>;
+						entry = /bits/ 64 <CONFIG_BL32_LOAD_ADDR>;
+						hash {
+							algo = "md5";
+						};
 						tee-os {
 							optional;
 						};
diff --git a/arch/arm/dts/zynqmp-binman.dts b/arch/arm/dts/zynqmp-binman.dts
index 675f6bf51ebd..6d28a5bdae25 100644
--- a/arch/arm/dts/zynqmp-binman.dts
+++ b/arch/arm/dts/zynqmp-binman.dts
@@ -60,8 +60,11 @@
 						arch = "arm64";
 						compression = "none";
 						os = "tee";
-						load = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
-						entry = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
+						load = /bits/ 64 <CONFIG_BL32_LOAD_ADDR>;
+						entry = /bits/ 64 <CONFIG_BL32_LOAD_ADDR>;
+						hash {
+							algo = "md5";
+						};
 						tee-os {
 							optional;
 						};
@@ -134,8 +137,11 @@
 						arch = "arm64";
 						compression = "none";
 						os = "tee";
-						load = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
-						entry = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
+						load = /bits/ 64 <CONFIG_BL32_LOAD_ADDR>;
+						entry = /bits/ 64 <CONFIG_BL32_LOAD_ADDR>;
+						hash {
+							algo = "md5";
+						};
 						tee-os {
 							optional;
 						};
-- 
2.43.0

