Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609FDCFB43F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 13:05:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD728888EB;
	Mon,  7 Oct 2024 15:05:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e2FT0Lu2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71496889E1; Mon,  7 Oct 2024 15:05:54 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 250B7880F4
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 15:05:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a65GzJVsUkC/gtdcHqOwntijFudb6AF2aWzCqbWPRfWiv/hAmK4Igz/SGEtKRzR69Fu/wux6D19XcxNMd1yasoVqVe8ZzqSBwi/aBub9uZ3rYIM6mB87HoiEwzWquPCZq2w5it8QB/gGJzyYbJtW6nYflADbiccB7nO0hwzUjM0xM8GzHq8GHQzceLJkHovnNjaovde6Aw556iZBzeSGcj1BMBZQuzk1K8D9oNg/ib2DnNuX5qvu4RNIeVqlJHTMrlO3TWVqMvaN96d0t69TLLyPDwKUr0XUp68WKfl8qNn22C/XKOecmQh6FxjKmCKlvMsXPkuZCE2TVG2oofeEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xH8SEKknLT+OWeVKwn1Tc6k1eS0YjfXZBRoZBlACdQc=;
 b=u8BvuGxOpWHygFCAADCqU2kuahE1HtFR9cWUAiy3NmtVLGwh/6t2LqbUdrGNV+xEuQKwUkrkhDDK+3PIGvA+nRPFNWP5PT6IGO0z0r63OGHVj3yhaPNPf2CycusOyYUy/4wriZpvS3rCJ4syWC2bb+SA4q3duHxZVY1IZmCU4qYjRq2pTysDz4LGVB9l4lSstNJb9X2zl8u+x/Anq0oFLkXO4BjQcz+SheYeoLHHoif6hEfqIj7pD3F+M2j4V90a1E+r/H0eTthANX1iedmIY2aYLZPQXUbINQbqbptJRr9iSo9aze8FTrw4sk/smUWTE8YxskawAcy+mSbIQq58Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xH8SEKknLT+OWeVKwn1Tc6k1eS0YjfXZBRoZBlACdQc=;
 b=e2FT0Lu2k8JDgVVY8seAO7pfHxYGz3Ucp9sxMWkyxrUD5UEto5NZPiPq8ido93tHw4UoUTc4w3ZP8sta42VErqVh71mx9MU4Ez7K+8wC/ljfp47s8BjjKfCf4cC+PSNhHLgyItLYuvfRbw/pxPgDuPegGJ7cFA4s6Mu85zFjjwY=
Received: from CY5PR18CA0009.namprd18.prod.outlook.com (2603:10b6:930:5::24)
 by CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 13:05:35 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:5:cafe::7f) by CY5PR18CA0009.outlook.office365.com
 (2603:10b6:930:5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21 via Frontend
 Transport; Mon, 7 Oct 2024 13:05:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 13:05:34 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 08:05:30 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>
CC: AKASHI Takahiro <akashi.tkhro@gmail.com>, Andrew Davis <afd@ti.com>, Bryan
 Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, "Leon M. Busch-George"
 <leon@georgemail.eu>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Sean
 Anderson <sean.anderson@seco.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] binman: Add option for pointing to external description
Date: Mon, 7 Oct 2024 15:05:24 +0200
Message-ID: <fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Naq2odIf0LDA0TUu4Jj25FTvwkEw3Jmp2HTIX25W8k8=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnTmO1P6qnZKbC8/3NWQWbL3UaW08K2nVToH1+1YtSZGK
 9qiRP57RywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIo1yG+e4Moi3tTn12bycl
 7V/Fr6GpHrHJhmGu+OH1EUxyibyap2O8Yud9mbdQ6G45AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|CH2PR12MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbccd25-4354-468b-ff72-08dce6d0bb05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YbnSTqLcL2Mqj6oezL9zokJCTIeeKH8cRRXtEP+CTDlVP03yv3C5kSpjqf/w?=
 =?us-ascii?Q?18LBHRyNPeYDMK1x6U2D2wpqoEcNfeAnlSu65YUd9KvEL3IQ3VVpnr5A1Ccq?=
 =?us-ascii?Q?FBMx6Yw3+gqTqKc4TFl2Gj8IH9vEsoGHVRV8KG3PyxQqujEPMcuP3Aj1jDul?=
 =?us-ascii?Q?g4w5ub9d2kmPv4xNEO50rULQ5oG8iXb/Uzqp/Azw92Jfrxx6yCobo4JkbdvB?=
 =?us-ascii?Q?e+KiEXTFRTM8HFpgMKch9oQRR/TzSThgvQgpAcZVGHlrl+k0ZIX32wyK2mRk?=
 =?us-ascii?Q?H0vVA41CblVidZGYCemW2+F5X8ACK1PHRCe7qTkXgjEEudFP/vtP6kiGl1SY?=
 =?us-ascii?Q?Z97QBF99mJOZrjNymzAOK56BPqVPaVOnKaUDoJ+vRGFvNKTBKMWsrJvfzWBo?=
 =?us-ascii?Q?Ak1W3kKuTWb26rOltWIIBluJ86kR6sfBEqaAlwZ35/2m9ef8oQm4+gUZHhBJ?=
 =?us-ascii?Q?9Tz+4iMKAhvHXO0T23u9esvtai1bsi5u6hIvBNnG0w9y6kELbYaltgQLOvXS?=
 =?us-ascii?Q?0AFHih3wMb8LTb62xrXEWrptY6UwWVpZBa9D1BxGYm28V5desKIRtcxAnMyH?=
 =?us-ascii?Q?YskhHnjShu+ueJ6Y/Ub9LauVP+oDftnIh0typHjFJYhXSyRepqLI0alWaKnb?=
 =?us-ascii?Q?oWEYJRAv/yrZ6g3l6kZ97+2eb2KIK7zwKbL6vFPIyEaUQVJ1kCN7VvrFiLpV?=
 =?us-ascii?Q?IztLdmjVYcF1vfVVCuHykDQ/zIBJMtQKQedNiGFDfh1hWH9i7d1QKDzK8WVV?=
 =?us-ascii?Q?SwOdP25Y7CNixPoYL0dpQQYEufO64ekrG4mycWCkqbD8rCZkb9/w/qd4dtx6?=
 =?us-ascii?Q?Bd2H4zkhu9Ruz13ceAexiQ31Fqjvf3B85ZJ09JSZ4FxRGL/LmQWVUFlIi8II?=
 =?us-ascii?Q?+pFN+8iLJEMN3HD8fz0GW1mRsViuq4qWlIayOdbgcawiw/1Y40NDniiJsgFv?=
 =?us-ascii?Q?P3JKkNLVZvDVruzaStI6EauNCUtnzI1Ox4O8VruwmkacLl+StktT3remLYLl?=
 =?us-ascii?Q?TqiYwMxjavtESLAmoJSzVe5GfLgTddLjt6VUluVZBDZJWwcyMz8oVLcSOXbM?=
 =?us-ascii?Q?5y3MMzaoHWAa4Squu0Gd7Fp12DdPj+DqU+wGedXqDQFpkMoTyATKuNQC2SR6?=
 =?us-ascii?Q?3tWEUOkO4eWTw9BdwkiU4D5KWIWtvAxhRQhEf9O9RqDnQcr+/7JFhBnQYRTO?=
 =?us-ascii?Q?m9CRB5gcx7fSLKfjv1IxrfMIGeerEOFcBIVKaKmMfyK33ZtMqLoij2kX1KQf?=
 =?us-ascii?Q?VVq9D+gSzw4dlsu3wFT7W3xKUfXKNuI7hfWdt6pE8D9xxpPxbyEtc4MPih8l?=
 =?us-ascii?Q?i4nz+Vl+x/hak5sIvrGdhKBZVqUxadurf2RPMnaGgfWTKOrdYVfXsKvsuov+?=
 =?us-ascii?Q?RIy/PKNhpRlDfXtjgMC5AEasMJG7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 13:05:34.2898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbccd25-4354-468b-ff72-08dce6d0bb05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
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
Introduce BINMAN_EXTERNAL_DTB Kconfig symbol which allows separate DTB for
target from DTB for binman itself.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Makefile    |  2 +-
 lib/Kconfig | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index af24de4165e4..8043016ac279 100644
--- a/Makefile
+++ b/Makefile
@@ -1384,7 +1384,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		$(foreach f,$(BINMAN_TOOLPATHS),--toolpath $(f)) \
                 --toolpath $(objtree)/tools \
 		$(if $(BINMAN_VERBOSE),-v$(BINMAN_VERBOSE)) \
-		build -u -d u-boot.dtb -O . -m \
+		build -u -d $(CONFIG_BINMAN_EXTERNAL_DTB) -O . -m \
 		--allow-missing $(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
 		-I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
 		$(foreach f,$(of_list_dirs),-I $(f)) -a of-list=$(of_list) \
diff --git a/lib/Kconfig b/lib/Kconfig
index 1448b4ac2d64..491f265012b8 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -45,6 +45,16 @@ config BINMAN_FDT
 	  locate entries in the firmware image. See binman.h for the available
 	  functionality.
 
+config BINMAN_EXTERNAL_DTB
+	string "External binman description"
+	depends on BINMAN
+	default "u-boot.dtb"
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

