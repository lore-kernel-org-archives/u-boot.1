Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2F5C83F29
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 06:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C20A8656B;
	Thu, 31 Aug 2023 08:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z9UJB0BH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC8F486568; Thu, 31 Aug 2023 08:59:19 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B0CB81FA8
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 08:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEpyv1VHgXtr+mG6uZu4yA3Lh6jzErBavebo9nYo1C7KR4OcWxAmEdCtPPZ/7PrseBMljOy4H9HhUTL5vb0PrTSS89LuhG1mU9f/+dN2pUMj2/MEBOTeWxG1WKlwakfShYETA5VwWuBBMXgUj//aAoohQcQIRr8ZNlDlNn0OF9bodYvD7jRR8wGzMhYGWeRU+O8/DSYAU7Fy3xLxz1vRZjCUPPEQtySneWfwXl2SgpoI9DRisp00DZhWgqx742TVQ1apOHpzmwXXSXYTiGGX5/eN5uo93vLofvp1hIWKkUd+0jHBC+aDOk8En+aAFBY4W/1Ztvfr06VfHOzDItNKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2TzIO/SqoFbQW52P9+C3ZwoVUUjxj1HirBK6oRUlmQ=;
 b=UIg0kBqxYWb49iaTCTlzuYjQp+G505LKYs2UyDaadm/cuomcaPDVdkKMRPfWUpJEDgoeO9aNAip/mjP8i+ktOOjodRonWZl2XtX9oBReZssVo1POkHAg1Fo9isYHu82re+rSBm3wdOihWTZTGII0bqUDNT5qg63OWTrWHuvCa7uEQpsKwGdxHFhUTr6+qa/xd0PPypv/Mmpnw3021FsAt06nSOhXCeyyLjQHzjgTnZxuh6pCMT7VxcToUD3WBQfZCnHZn3BTHGLhoqIZHmfnvjfAiObBm4/cjd1Uy4gSv3KbdZpjzuBaxTFAwOjYQsICkIdRYELtRvRYrKu3n3v/og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2TzIO/SqoFbQW52P9+C3ZwoVUUjxj1HirBK6oRUlmQ=;
 b=z9UJB0BHNLDi8ikl35QSnUEDLBlFyFLUUd1RPRx2/Nd/B2RZj0+lc7LaLGxvXpyvKEIfksEPteqiDH8liwOR6ZMD1LRoO1vMWVdmL0cecX+q7NLDDXAZoB9Th5W9Lm4/AZn6q4n30SBK+WA37JEQg4LOBslBZ4Hw8uqeqWfYmLE=
Received: from PH0PR07CA0094.namprd07.prod.outlook.com (2603:10b6:510:4::9) by
 MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 06:59:13 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::50) by PH0PR07CA0094.outlook.office365.com
 (2603:10b6:510:4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36 via Frontend
 Transport; Thu, 31 Aug 2023 06:59:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 06:59:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 01:59:10 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
Subject: [PATCH v5 2/2] xilinx: board: Add support to pick bootscr address
 from DT
Date: Thu, 31 Aug 2023 08:59:06 +0200
Message-ID: <fac7020b31e1f150b021d666f0d588579ea671ad.1693465140.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <23be3838502efef61803c90ef6e8b32bbd6ede41.1693465140.git.michal.simek@amd.com>
References: <23be3838502efef61803c90ef6e8b32bbd6ede41.1693465140.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2216; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=fcIdf5/Cn4qQ9nHMyBAyghIKEozWsBD5bvVqs2sEbaA=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpQPVhazCzSm3fm+aZ37YzW3YyGHU7+kp67yDgtn3ljZy
 /l/7fbfHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiPw0Z5mnP//z5pkVCzYwz
 ttGim6P8ny79dJphfrzfi0cZEtN2J57krre/z3a2aGGvBAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac8e4a9-48b6-4173-a3ff-08dba9efc7e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9BrcT6KgYz4UrrC7kL83x0dDproLhxAan6U3k+NCs1SrScUQh99UYBcE7hXu8J0jpwETo4X2zzxOVTUwVD03xWJ2nfEzQ8pUlhr66HAibbsCQj0YYPie5i2xZaEe7NLJSr0Fdt5QMdtClTnP3lmQfezHZU3bBShEEdi2mmTwV/sLqdeXP7+QxIhUIKm+EH6L3Bqg063WOHfkJneM+0efAmhmBtNuBwWV/xe4+JXlNLZySrsuGXRPXkZGMSihDAOTl79ZwYALZ+maaj983wIFQoAZZ0qLESh5vjuOXTllWDo54ZAHys4hSm05i39J4SNtrBoMz9gmeehLkLTvDyzMBZ+S9vpa1/jpNzykASieK4ah9teDUbWcmT8EVZK7TL2OSWeQ9T6djevJtHOMptAMqTZXMOxX6i4uXXnXqunFZ1uHurtUaZvt8mwhTNu2jwql0+dTijj8djeHdfKlv3BPDbmrw7qOo5B4Ne2O81OlqrW/36GKKZ51DTVwpJIxYA4Y7tn8Mm4/h9Uj/vyH345+iBHav0eIs5cfX3M4zIRjg8ATkTED8sqBwX6FZXtIfaEX3C1ciKC1yGNRpIJVbPWvC6eb6+0lB7i1/bAyoveg+lh9g42uWkG4rWLcGo7k84CJu97EC2Mc9P1MYmeYHlPV3aHIeYhaWHl368lbGkic8JxcRVhHT5ep12sOl83rjgxR9CR/OU0Ad2zjR3uJzwb6w0/p8e5wgNY6wPokcA0IIXMPk61zspu0o5FNuONE1G9blyU+DVkDlbq1ZBzbAF92edBB8Pd8TZPu6O6E2ZAkVY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(36756003)(40460700003)(40480700001)(83380400001)(8676002)(86362001)(44832011)(41300700001)(8936002)(4326008)(5660300002)(6666004)(26005)(2616005)(426003)(16526019)(336012)(36860700001)(47076005)(478600001)(110136005)(81166007)(2906002)(82740400003)(966005)(356005)(70586007)(70206006)(316002)(36900700001)(139555002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 06:59:11.8294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac8e4a9-48b6-4173-a3ff-08dba9efc7e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173
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

From: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>

The bootscript is expected at a default address specific to each
platform.
When high speed memory like Programmable Logic Double Data Rate RAM
(PL DDR RAM) or Higher Bandwidth Memory RAM (HBM) is used the boot.scr
may be loaded at a different offset. The offset needs to be set through
setenv. Due to the default values in some cases the boot.scr is falling
in between the kernel partition.

The bootscript address or the bootscript offset is fetched directly from
the DT and updated in the environment making it easier for automated
flows.

Signed-off-by: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v3)

Changes in v3:
- Rename get_bootscript_address() to ofnode_read_bootscript_address()
  and move it to common location
- Fix alignments

Changes in v2:
- s/bootscr-offset-from-ram-start/bootscr-ram-offset/
- Aligned with https://github.com/devicetree-org/dt-schema/pull/105

 board/xilinx/common/board.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 906d5e3c2d7c..b3fb6acc25a3 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -414,9 +414,25 @@ int board_late_init_xilinx(void)
 
 	if (!IS_ENABLED(CONFIG_MICROBLAZE)) {
 		ulong scriptaddr;
-
-		scriptaddr = env_get_hex("scriptaddr", 0);
-		ret |= env_set_hex("scriptaddr", gd->ram_base + scriptaddr);
+		u64 bootscr_address;
+		u64 bootscr_offset;
+
+		/* Fetch bootscr_address/bootscr_offset from DT and update */
+		if (!ofnode_read_bootscript_address(&bootscr_address,
+						    &bootscr_offset)) {
+			if (bootscr_offset)
+				ret |= env_set_hex("scriptaddr",
+						   gd->ram_base +
+						   bootscr_offset);
+			else
+				ret |= env_set_hex("scriptaddr",
+						   bootscr_address);
+		} else {
+			/* Update scriptaddr(bootscr offset) from env */
+			scriptaddr = env_get_hex("scriptaddr", 0);
+			ret |= env_set_hex("scriptaddr",
+					   gd->ram_base + scriptaddr);
+		}
 	}
 
 	if (IS_ENABLED(CONFIG_ARCH_ZYNQ) || IS_ENABLED(CONFIG_MICROBLAZE))
-- 
2.36.1

