Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F63E674BF
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 09:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 589D289177;
	Fri,  1 Nov 2024 10:18:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FhwlpwqG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1AE488DF4; Fri,  1 Nov 2024 10:18:18 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DDE989045
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 10:18:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1XQZAvfoS0bNs4bM1ausHjO7bANMuk209kEMiI1NKW8fT933z+c9B6cFNl555g70VXGqZnL2RoC3gw4smcdLRXFQuGeLuHYzLoFB+lUsL5hXFBD3pW4mMByFPJ95Knl3Lnh/eeE0LLetabxdWbBBS6AtqDnJZIETFTZl7TnPTE4OsqOza2e7+XNDz+BCnIN5Nr6b+AjPFfZy8sU4DOhrzM6btjROdDS7vaEOuV+SxyWrcv4zf3T0A2itqhEEp6ACpHu77DErsuZfS8GbKj9ojL5APETLvdxa5XwUaoc8qd5E7cYm328KUMO9Xg1fGPx9nQGCDAk6nmnQyZA8j6EHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pFwDrvSMbwJF6MfrDTxiecZaBm2PhiyLh1CvesJtB0=;
 b=sieY1ZYpW38NweteEnhrSzo3qGtQwRbDYi82Zy0MRtZJeTN+soCO69VjyfoYMJvcz7R7TXdrCUH680DHcVljb6/3AWBWLJPTjelIo7JTbM11RQQ16cKpMIf6VXu6stNahABw29/St9EKKPEI2NsQqePQDww16SyZG2WfdJu2uFG2kCsE9BhI1m4G5dtMCk6MjUgLIKbqiAZzhG7kGYYLCRqNpX8LPTG8O66Jsxnh/8ztFnXYyWuAhC2XuDbeYD2Q1MpxulDgIXqYuFS1DUMeL40KGqDVrKLIsyv9u8D5VJhQtb3OAu4T13LB95LekLxaEowTen39+vMg07qnUZxMuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pFwDrvSMbwJF6MfrDTxiecZaBm2PhiyLh1CvesJtB0=;
 b=FhwlpwqGWTc1QIQwc1Mzzv4Z2zguRolij/iQRnRPJ6MMgPElPYnK6U71T/wghNqcMnJ8bY/WtVRpFWo7TbZ8K6QjRebbyqQdx4Re//3KeCjj6oBsuVETsCip4m6lpi731PSKPFhIh+4gO4iTBM78PYR3hNHZ2YR7SMEp6n87pOw=
Received: from BN9PR03CA0852.namprd03.prod.outlook.com (2603:10b6:408:13d::17)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 09:18:11 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:13d:cafe::ab) by BN9PR03CA0852.outlook.office365.com
 (2603:10b6:408:13d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Fri, 1 Nov 2024 09:18:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 09:18:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 04:18:04 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>, 
 <neal.frager@amd.com>
CC: AKASHI Takahiro <akashi.tkhro@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/7] binman: Add option for pointing to separate description
Date: Fri, 1 Nov 2024 10:17:54 +0100
Message-ID: <f1379d2587f9bf279a7a75c318aabbc1b35ee0c6.1730452668.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730452668.git.michal.simek@amd.com>
References: <cover.1730452668.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2340; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=lm7GeiXPmiiT+4zgzSoXeade59BOPMeWrn5H4PIQHrw=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnSVOYdtNrMGhM50e/U0rkSF/8RvlnNeq4/bCAu1iXTae
 oSuS7/YEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACbS7cUwv8A5ZNqRMxyOV3WU
 Vv6ct6OYuWRtAcP8AJEYqT05F9OXya62XPgrMfJr7qYpAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 059697ec-a966-49de-59c2-08dcfa561b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I95tUxFohHMZyIRY8WdnL1gqbHs8DOKtPQqnr1u2atOjthVwOy0QJp1CNXE6?=
 =?us-ascii?Q?3GsdUnz1sZPWGVXJR2LAqo54iJeQnLbYGuZkK/gDXRWneLZhJLS0P8IhtybW?=
 =?us-ascii?Q?Qx2wdY9Nyv0dQWpME10OzEwAEiK/uVJcZcCnsHD3LJB/IElq+qTIIPI7Q58e?=
 =?us-ascii?Q?KldFvhVPISNt1IUHC946/AOvpNXnW6KnWf58YevF/pfQPEKdTAZOpAKJfVkz?=
 =?us-ascii?Q?WNX4Uq9x/thJdV/l0WNP9S0F6ogdHTZnPL/qAV8HOW9cEVRIcS+eOwntb5TM?=
 =?us-ascii?Q?yxbUWCu6oOuRb8i9wvjOsWqJsQs9kR69tLfN2UX5DwZSuLWiJ4ZLGNahOUAG?=
 =?us-ascii?Q?mSaXu9KCl3uzRk2QZtedne+wcaSxvhM/A39Zke10k8sSU96sLRsVCXfXroKx?=
 =?us-ascii?Q?mUztTj/riG+7J9wKiWLPsMr4XgnVvAuehLwMFNrUBTdqJX4NxSlJ66xmLQsL?=
 =?us-ascii?Q?jF5YWsOsl31/S5ciEBk2xrOtfsEO/00jq0ONQGihzNY7ZHje5gN7T4PHIP3j?=
 =?us-ascii?Q?bDjIx+OdbaJsf9cWNFAzkwWanrp+yY0oSc9BnUueJbwYJCtuHIGo292pjkNM?=
 =?us-ascii?Q?IzsmsqYtSUhFBG4i26CCUmIraL+7Clnatq7YsEXd51Zpm3Z3o4koOyWbonsI?=
 =?us-ascii?Q?GWblB6KuA/SiCDdIDxiHfsmsmkfEymUM/TP/aG8+suyrzIINaHXonBDSNwhd?=
 =?us-ascii?Q?IY1l/JrS+kRuc/q1lOGJl4f/1pqqtafLQDuLrjnBJ/AyzlO4Y4aIrSgO6rHk?=
 =?us-ascii?Q?7HWMbfMb9VNg1OkQXSW6qQz4V5l4jf4Iz65vqig8bx821TqeU8WYANMS8C+j?=
 =?us-ascii?Q?VPEPp7hR+DPBqrgshTB2iko0o3stdabo4k2mwHCe+C9pTgM4BCMRxpEBj8UA?=
 =?us-ascii?Q?S4oNNMm+69eo0fOku1gyIXtHUUCZIJBZCYIZQac26BwCs5Vfa/V9nxRhLJ2M?=
 =?us-ascii?Q?EoQxzEj4kEZNxeH4ZT8y/IcdQSnXALr1nXb/N3yrml/fXl7o2UxwWJTJAHhG?=
 =?us-ascii?Q?lkSnR1nss+gitX6sJ9rPRumElWyFdnb4looe+eoeLVif2YiqHeSVu7S8iUep?=
 =?us-ascii?Q?j6qsaEgyHwYMD2KjZ6Pj1OqDsSl8SEAgUDITB1bQWZAIFToVTTgt2lcGbvnR?=
 =?us-ascii?Q?ut1OBxWI2CipK/5Dj5wPiF4e27K+Yxt9V79iEcHCppqS0UiLVKAVeHSYOTve?=
 =?us-ascii?Q?NXkfGjtu1fF+V0Wnwan2vZyylM6ZWtXy2iQCw1mYTq4dnDQQYiP0TbL8OcN0?=
 =?us-ascii?Q?Vb12SPP6sjUzfOrONOvgs6OHI8rE2LNO5awpOFCXvWJiE5QiSBudbk0Cx6Rn?=
 =?us-ascii?Q?nfP8XIUQuzoe/8G2sN7MQS8Cey8MIRB3bAeIy5wO51k3IPgXU1N1ULLTRm/E?=
 =?us-ascii?Q?hn7qJ0EviuBMxF4XrvnYmn5XX+MUXw28vHc05xLOZNPGZbrjpg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 09:18:11.0935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 059697ec-a966-49de-59c2-08dcfa561b47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316
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

Adding binman node with target images description can be unwanted feature
but as of today there is no way to disable it.
Also on size constrained systems it is not useful to add binman description
to DTB.
Introduce BINMAN_DTB Kconfig symbol which allows separate DTB for target
from DTB for binman itself.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Change subject, align commit message
- binman - rename variable
- Use relative path
- Use separate variable in makefile to also handle empty string and default
  to u-boot.dtb

 Makefile    | 11 ++++++++++-
 lib/Kconfig |  9 +++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7275a02f24ca..03337450f636 100644
--- a/Makefile
+++ b/Makefile
@@ -1392,12 +1392,21 @@ endif
 default_dt := $(if $(DEVICE_TREE),$(DEVICE_TREE),$(CONFIG_DEFAULT_DEVICE_TREE))
 endif
 
+binman_dtb := $(shell echo $(CONFIG_BINMAN_DTB))
+ifeq ($(strip $(binman_dtb)),)
+ifeq ($(CONFIG_OF_EMBED),y)
+binman_dtb = ./dts/dt.dtb
+else
+binman_dtb = ./u-boot.dtb
+endif
+endif
+
 quiet_cmd_binman = BINMAN  $@
 cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		$(foreach f,$(BINMAN_TOOLPATHS),--toolpath $(f)) \
                 --toolpath $(objtree)/tools \
 		$(if $(BINMAN_VERBOSE),-v$(BINMAN_VERBOSE)) \
-		build -u -d u-boot.dtb -O . -m \
+		build -u -d $(binman_dtb) -O . -m \
 		--allow-missing $(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
 		-I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
 		$(foreach f,$(of_list_dirs),-I $(f)) -a of-list=$(of_list) \
diff --git a/lib/Kconfig b/lib/Kconfig
index 56ffdfa18396..0b089814d149 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -45,6 +45,15 @@ config BINMAN_FDT
 	  locate entries in the firmware image. See binman.h for the available
 	  functionality.
 
+config BINMAN_DTB
+	string "binman DTB description"
+	depends on BINMAN
+	help
+	  This enables option to point to different DTB file with binman node which
+	  is outside of DTB used by the firmware. Use this option if information
+	  about generated images shouldn't be the part of target binary. Or on system
+	  with limited storage.
+
 config CC_OPTIMIZE_LIBS_FOR_SPEED
 	bool "Optimize libraries for speed"
 	help
-- 
2.43.0

