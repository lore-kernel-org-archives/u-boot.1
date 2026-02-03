Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D89E8305D
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 07:53:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 034DF83FFF;
	Tue,  3 Feb 2026 08:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rlZgEukN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 507FE84011; Tue,  3 Feb 2026 08:53:03 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78B5683FFA
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 08:53:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uv5bWoj3mmEziBf03S75XKKFYWVvJdwNqegll1Cp1uZBSt7IC54mWuGcrszmr2FywbmByFfHbZlHLScOO79kqgbqjLJZpjVzrJrzaURS0WliZt1+x6VR6xmhbRWfeaAsAQd4gA63CQ3m6OKQfAHTlZHWM2dVs8pM6QpMBulcmTXH/G7zwAnKZm2XgS+C4IyOm3IGRbwjj0I1xiYf+4icKIXbBlAqroLlwPI1iIJydko2UE7+DYBbOF3vOnNSTP9U5kE6wAJT+4u3La3K24VBS+MKbofahD20BfTIvba0s7dpy9yjSaljJkEXqAydfABcJfiDxjfoxk+YjZX1wySkNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NVGiRWGRE4to4TOlrOIGuOX9FunE+eqeXbE2zEVk90=;
 b=SBbkC++2/Nefqn/q53nZLh2mFnxbQuiPG6TDMEb+JhufNAeeWFY4gAx43NLJCclWGnfg9kIT5r3ULuWCbAGRdL4aVXYw6z5hjSSDK2O03+wIXDoFSijDrZQOicq7PfSaHHnjcq7zfcWmPqg8tGoTqkNzEFEmy8sgkCaUYdXTDbTTZVLozzmVFjHuk3/0ml4alhAseyK95nU/7tnnNauiPpWv4x0usFKHCensm4iLaQ4+S94QpM6v9eNXgav7HyaizzetoONMWHcrlfb0znZ/+RIstCGijjUcmx3gKTd1BwC4itXu+CQbTgEA+Be7zw5uU8sSQ2RYWAKT96GAF0wavA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NVGiRWGRE4to4TOlrOIGuOX9FunE+eqeXbE2zEVk90=;
 b=rlZgEukNxTaC5dTx823AMGiA5yuvN/rD/2zGlOve1dzBpEIXcYJmPv8hrFzQbTM35qA1sQ6DbFEHDapQcIVaxZsX8JCo+CKpepDbjTE6bT6tzymaVNheSQ4HI0gwgKjU8GWGu9r+ag40arBgEiA75KW/ndgEETCiWhh+Tk16Ugs=
Received: from SJ0PR13CA0079.namprd13.prod.outlook.com (2603:10b6:a03:2c4::24)
 by CH1PR12MB9718.namprd12.prod.outlook.com (2603:10b6:610:2b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 07:52:55 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::13) by SJ0PR13CA0079.outlook.office365.com
 (2603:10b6:a03:2c4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 07:52:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 07:52:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 01:52:51 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 01:52:51 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 01:52:50 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Anshul Dalal <anshuld@ti.com>, Fabio Estevam <festevam@gmail.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v2 2/3] xilinx: Enable GPIO delay driver on Kria platforms
Date: Tue, 3 Feb 2026 08:52:31 +0100
Message-ID: <aa3566571a124b0933cbe971a2db109f83157ae2.1770105146.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770105146.git.michal.simek@amd.com>
References: <cover.1770105146.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=713; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=L22CebZ94z/MFJ5Rrzj+oZFNkK9Dq8/mQ8q8g3j3Zw8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ2rnT+5XtwokvakW1VF0UbPizRb2X02xeStN5a90lbv
 H35e5ajHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRZYsZGW5J2qXrayk8KZ+Q
 HWb2YilvU4Ve3a6YOc4PRc5O5nkRHsLwV55/X3G+/JULi+z6pt9/4C+5cr9qsv/kBY8EV/5brNz
 nzgQA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|CH1PR12MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: e21b5e9c-fd6a-4b3c-4931-08de62f93d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W3DkZ/J0wuWLnVm16g7K9vaG6lk/LQ2SDVS2bBr2qim1Vfp+y11mSZhsk9tG?=
 =?us-ascii?Q?I6UdXVTYB1LvJj23JUjcmvR7Y0mOsmYY7adIrdgvHDdeHbsb43RwSX5Iw03q?=
 =?us-ascii?Q?6rsh7h4hg5hAT3TBjlCJvxbQ2IL9wve5T5PBxaoPg+fK5Itn/00TEK30041V?=
 =?us-ascii?Q?OyMGlh/kCs4A+cblpwsDigYZY/iPwAf6ingqDrsWyJ3fg4kKXAjK/7FlFoRW?=
 =?us-ascii?Q?skqsQTSlFb5BrEYksEd3AAA2T/jsjTwykkGm/2Xbbm6hnPHZ07cCrc1po12Y?=
 =?us-ascii?Q?BHaQ8UYE/2Zh/mNAJMpavl8+nIuno3+A326sr8A35e+HaFXfGeZ/+7SmYoxn?=
 =?us-ascii?Q?9JtbTjLApJRNPyW70rD3eggGSmLRvZbg4K6DZrXiZaqwBh/HqN6psmIs2S4j?=
 =?us-ascii?Q?GyLpTHox3Uv3levg0QK2kvvlbW40s4qF3EA03ezHV09xL8ceeTBZRMFfrECl?=
 =?us-ascii?Q?X7cV3L4v2+886NhqFRSDzTu0LCXxibJ4L8cDDlDkOPpszsibZRY5itSrXJ4i?=
 =?us-ascii?Q?pbFZn2AyM/JYrhblcVc3NhrekJxJF5ez74xTIKlt+ru6XZz8qtekQ9ybXshM?=
 =?us-ascii?Q?EUwE9hwAuRXpX6mefu3RwZi+Caqj7Od/1b3eIi24CEOt4omwbYggtqPvwzSv?=
 =?us-ascii?Q?C+2jejB+FlrPACoVcMQgBxFlaQ03MtU518hgHYS3/vk3CWzyUHtsmH6oI3lF?=
 =?us-ascii?Q?vBxAA2hxmPrZQvSDHReF0KgaAPiW/NGm9ia0MDvQKM487h85lbd/2cDU7V1Y?=
 =?us-ascii?Q?q1SacekAouQMmo387mcaU/isW5u7bjxTebIEVnwkFIZY8iG3X+xDBiwJyBt9?=
 =?us-ascii?Q?0imRlv2ncuJtyaqeyOHbRFkF9mF+q6e7YT7WnV2RdDiaUoTmr3Kgc8gL43BZ?=
 =?us-ascii?Q?27GUPUYMUF0IUIWq6qbdzOSDVzTrYIFMGKaSB/vtmkJT9+qP8wSyf/9JKRW+?=
 =?us-ascii?Q?G+Nm34nJPVrAkVta6sTThGJFETfGtJxeFiIIny56xVCAVAF2O/61ZU+rItiJ?=
 =?us-ascii?Q?B7aYJo5KQJ0ENw4Bmd7UCrxi3QiJX8xCmBBuTGMsBrp3fWD5Hg0+mceCG9hZ?=
 =?us-ascii?Q?U/k3Xtpf2YZq33osD1kQl6uyv8CGVRoryg5pvgsIwUMp5jHYld+5njMv78aQ?=
 =?us-ascii?Q?n7h0LfmIScUqOU9F59IGmf0LHd0K6Jl/+y8pWcoVrxmLdRzb9NsflJ2elbA9?=
 =?us-ascii?Q?v/rvM+jkPkk3aeNsCLcz0v/yJJqHpHapQZ+28GdEoMshaWfrSuPbKiKgNRYP?=
 =?us-ascii?Q?BPnwfVZpvMx2ICdknQzyqZZaB3AIvgEfzLb3XxDFEExEk0Cni8QlG67PoDuO?=
 =?us-ascii?Q?MQL9hh15whH5adZu8SfDOnKZ2rLU/FrE1l07VbPtwBHpqbc6Xi53ntJCrH1E?=
 =?us-ascii?Q?bEzc1bfPcE7KZsGGSZyRN50KyIQ2sPN6/1dnMu2LKM6GfPhGfQ1z8ygauDga?=
 =?us-ascii?Q?aswD663f5nEKdpLU3hfNM0ORm49r0jnUN7NkK8fjhH+cwjL/4pqiShhyTLnh?=
 =?us-ascii?Q?4zevCAAdpwBQmPwU73DzRGQb79spsAjr5iBZQjU+FpMEWSI+4FV/OEWPNT+7?=
 =?us-ascii?Q?YbKr/HCQH86mf2c7NJWHVovy5xwJEGvZS+wHo/DcJOskQMNs6gqrwIOO+n3H?=
 =?us-ascii?Q?h3lWKkkHqKBKPhlm8gxKGW+zx+6Tx4X7NGPI+u9tcmVddBuRJjSHTMZt1zuw?=
 =?us-ascii?Q?4QurZg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MvPEUfBUo3r8R1Nfwvusx9gs1va8FnA/oIpEDfGu4xHqeygHVEhR96zx95Lm9mwbJ5IbJcxfpRd2j5bIdXwfA38iH+BzYqtLd6mr2AFKmMYFoOu4qxtBnEazT+Gu08OhQNEjXX5myf3hkzo6RJiG5jPsip3ogiVAA+bMvF+VCsoh014JRHSYlWRjFfxqKUmzbwl5L9zot9tWknL/kodPPex2QpimElHeSRMBUes4A3tIw+LCfsoO8ybTu+Xy0s+vyWqORgalGxYODgKwYKL3oIzvaV34igfPnjYHLabJT/ofSGhET3v6PaSse9lo1LhpHLxjox+KX+FmoSaJujq6BrzSu4SkDPOFn4miHZyGp2BDxNv9ix4EgsAs1NbPepy+OaoyGHdl3+9dxnaSosnydq+PJDvaww6JE9CW9xpV15hYqF2Kw7nXw6/beEuw9Lqp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:52:55.0323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e21b5e9c-fd6a-4b3c-4931-08de62f93d7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9718
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

GPIO delay driver is necessary to use to extend delay times for USB hubs
available on the Kria platforms.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v1)

 configs/xilinx_zynqmp_kria_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 8ad05e371892..1e0728fa4f3f 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -136,6 +136,7 @@ CONFIG_XILINX_DPDMA=y
 CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_FPGA_XILINX=y
 CONFIG_FPGA_ZYNQMPPL=y
+CONFIG_GPIO_DELAY=y
 CONFIG_GPIO_HOG=y
 CONFIG_XILINX_GPIO=y
 CONFIG_DM_PCA953X=y
-- 
2.43.0

