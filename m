Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08823E674BF
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 09:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DBD989287;
	Fri,  1 Nov 2024 10:18:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k0sxW7lM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73655892E6; Fri,  1 Nov 2024 10:18:43 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B5D0892C6
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 10:18:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gH1KCqnWSKh41o88g+jQzRSR8pzmP0SCnomKQVMn+ZUxcLLqd2JUpZmzU5xh7ERm1I8saOYO8OOlMwiEHuFHF8rkyopcrtc4vwaYvDXVwunbQYVJsgpRUUNP7gU5RQ1zLGyF7FS06CUGTMvrSd95BcI5q7fox5jzC1B5rkTyp4qBxvJNse72w1uHklaKfpCyVUXcrjyogSf0uuGfV3PZ2bbToOdWn6+B70BdXrCYrkWHrRLyeLuNgEkbMZsXfzfKC/mfd1QuTHwJ29WmLdhQyOSq1isUZVUjV9qWIb61Ok5ilJFjXqYkpvDgwIetlvpsk9kWtoL53zjgUssSRkXm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IYbReZP6DE4GIhU8RtYNRsC6BpsGHfu0WmToPx4SfM=;
 b=L5TC+EyXJO7KbJ5xlen3GoOmgDdf7Sqg0ETe4KabPqW0GbAVRML0u2WkJKqB/auK7q4v4bwv6k7zGo65OFeM1oWhD25+WJnG4NytJjJio8qaXgJSmTUXmSzASpGPdiAUCzw8aj/J/+o974MLcyYj3fWYVHjPUHycImS9kuVQnpZCTaRZvCB0DZRw4+NpYVtjn7VyvQjPrrKGzAKJocKl/TmA9+yguU1I/g1DECMqzlhIiVxKxVx71qKocC3+EAIwebYv1qHGTczSiT7UZ6qzXUmQIovYh+hVGs9ZyUPapCyAchH4uNfATVzULmK7zSYguAnIdo+1Ae66p8bB20Vl8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IYbReZP6DE4GIhU8RtYNRsC6BpsGHfu0WmToPx4SfM=;
 b=k0sxW7lMG23ySZnAG15RZ6iG8eJ93xUC631QRmhsZ05iuHH5gCb2JQM5rCSMYfo7F9ZaksfMWQSkXwcqMm754YenDjuMmWCQBqy0uax3d4dEpUxStHDRHzW3jCkvLuH9TzynurZFABiVDYYer0ZxYVAWfBSnG0sh/f/bOYCUjZA=
Received: from BN9PR03CA0139.namprd03.prod.outlook.com (2603:10b6:408:fe::24)
 by DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 09:18:36 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::47) by BN9PR03CA0139.outlook.office365.com
 (2603:10b6:408:fe::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22 via Frontend
 Transport; Fri, 1 Nov 2024 09:18:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 09:18:36 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 04:18:27 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>, 
 <neal.frager@amd.com>
CC: Marek Vasut <marex@denx.de>, Peter Robinson <pbrobinson@gmail.com>, "Bryan
 Brattlof" <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>, Sumit Garg
 <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 7/7] Makefile: Drop SPL_FIT_GENERATOR support
Date: Fri, 1 Nov 2024 10:18:00 +0100
Message-ID: <22109373594b6a5d1110be9420ccd8fbb93a61d3.1730452668.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730452668.git.michal.simek@amd.com>
References: <cover.1730452668.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3867; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=SNi9suYxuFlTotnoAD0hbOcIGy4cTxLFKUsr9KFsdV4=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnSVOUf/T727rsmcwyb4qY7R/nbnmNUdvuunXTjIy9OVv
 8nRUSamI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAExk72KG+dnLPhkbL+h51LRl
 8dkDz22FT2qr/WSY7zjZ5dn++Bq9yBn7THb9mOZoYcImBQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb1104c-14ba-45da-6b8c-08dcfa562a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u6FMBoeyF0Fhje1fWdy98ZEVNyhnd3nCo9h7Ctky8hw/CSgE8Zzio8kUZ9Kh?=
 =?us-ascii?Q?Mmdmy2siUCeLPD6OlalkWkN0WjmOslyA/xfOgUWDVCKy9PPwTLPLX2jLu4hs?=
 =?us-ascii?Q?ysILEe1yfXTsCpaZPIIHecSy+vNVCXBUn637CDi2S0b5blriLSxGneQnA2Qh?=
 =?us-ascii?Q?Dht3K7otvb7s2IIHIyqs+RMLevjoQhmiScnXeDDPdcA0PTYpq8WizIeemecR?=
 =?us-ascii?Q?zOoVuH8as0QHQknC1H/Hlx65XfWhOeeV1ct4LBpX4gYzV8rOFLEz9M/vZcGM?=
 =?us-ascii?Q?b9wUbgcY9eDZ/FWqS2q04SI1pc2HkrXc+kitA+NhfYIGhsOUjbh83CiiBbUW?=
 =?us-ascii?Q?HHMs+XyhajtSeUcGkznVZ2nqCvBDwmk5vPmFC0eHltJ0aUJKmK5144z3LJhM?=
 =?us-ascii?Q?tBAUG2WYrD05eOfX9QPr9zWQWKGfCkg91TxGBnYzhqRirayk2+vWjXlx/xsn?=
 =?us-ascii?Q?rs7SsbWWHa4mTnk5DK3IeLDlsxlM1M/k2D62L804301pAdHBjBIBOJsIYdou?=
 =?us-ascii?Q?h3T00WBX8Q6S4f18oSepewQxeHEEoJ277ShNXw5MPzB3yi37sM/DpzGd6hbp?=
 =?us-ascii?Q?rEh61RGQucZbW/fvvPFfLHQ6IwO7Hg+P9dblkuf81ho4revYgOrVukxKQP0U?=
 =?us-ascii?Q?5rskRD7Qbl5nxaXNJ5/V5M2EoXqwKb6GukTuNFyWCHCfWQAc0qDERHdu9w8q?=
 =?us-ascii?Q?zuWVWBu70OHH4h4Jfa8eXhZ1ieEO7Wm8OjPb0nnax7ZjZYMNhDnz87+hy2Ny?=
 =?us-ascii?Q?CRc3Ixy+zYRbHKDChHLR1UN8I6yswvjOzl1nCcj3Tt+YbfWHCwRUE858Iva0?=
 =?us-ascii?Q?icPG8OzHjigXt5W72Jted9tAdb9l33n0hIM3RgnIcu2A7I54tBxQTKo8NXp1?=
 =?us-ascii?Q?GUVejiy7w3tzmU/uES//vuW6gGUYp8pzLlHPYA167VSd8kDBVTL2Swh8+t3j?=
 =?us-ascii?Q?IT8q8aQjks00aAaqgmDx57+NMa0VMUh9XVZfzVtA4PMcKIxfpmpBs5KEaddS?=
 =?us-ascii?Q?6dg4fsUBpmQ6DXMt3Fu51RBfpcTmdLy7w9qPYuqURKZkqdgMQPua/gzf6oi8?=
 =?us-ascii?Q?oAdkNWtV7zTJIbM1PCH5SX5ranw33E+P4GoRqfXtY/PG8OQvVrKAL3y0I4ke?=
 =?us-ascii?Q?ug4eFfX9uzAAbnCBaSXKEjqJxcT+YoEHzBv0LYGjEl4X1aVIwdLmDMbRFQys?=
 =?us-ascii?Q?D/CFkrcv1PA63EgUJjLv5JSGWtmgUEMOVTRMt8sMYrLP3awdxdWOuhqOYgHS?=
 =?us-ascii?Q?nUwTQYiC7qmX+voHzCkygh0VIjCZ7MQRlx60JjS3jBXxdVch4pfBAExxkyQJ?=
 =?us-ascii?Q?fMnsthXo+B3SDg2Tfh+PCXazNAM3gaANH98mTHM48EjsGQjqeVlUJHK5yo/g?=
 =?us-ascii?Q?fp/HjArXr7+qpKe93TqUGaM+SClAoblhbBay2l5MTlQpmqO6BQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 09:18:36.5153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb1104c-14ba-45da-6b8c-08dcfa562a6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646
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

From: Marek Vasut <marex@denx.de>

The SPL_FIT_GENERATOR is long superseded by binman, drop SPL_FIT_GENERATOR
support as there are no more users.

Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Rebase on the top of my series which do conversion to binman
- Taken from git with all tags

 Makefile                | 18 ------------------
 boot/Kconfig            | 14 --------------
 doc/usage/fit/howto.rst |  4 ----
 3 files changed, 36 deletions(-)

diff --git a/Makefile b/Makefile
index 03337450f636..6a86e3df2d53 100644
--- a/Makefile
+++ b/Makefile
@@ -1148,13 +1148,6 @@ ifeq ($(CONFIG_OF_EMBED)$(CONFIG_EFI_APP),y)
 	@echo >&2 "CONFIG_OF_SEPARATE for boards in mainline."
 	@echo >&2 "See doc/develop/devicetree/control.rst for more info."
 	@echo >&2 "===================================================="
-endif
-ifneq ($(CONFIG_SPL_FIT_GENERATOR),)
-	@echo >&2 "===================== WARNING ======================"
-	@echo >&2 "This board uses CONFIG_SPL_FIT_GENERATOR. Please migrate"
-	@echo >&2 "to binman instead, to avoid the proliferation of"
-	@echo >&2 "arch-specific scripts with no tests."
-	@echo >&2 "===================================================="
 endif
 	$(call deprecated,CONFIG_WDT,DM watchdog,v2019.10,\
 		$(CONFIG_WATCHDOG)$(CONFIG_HW_WATCHDOG))
@@ -1435,17 +1428,6 @@ OBJCOPYFLAGS_u-boot.ldr.srec := -I binary -O srec
 u-boot.ldr.hex u-boot.ldr.srec: u-boot.ldr FORCE
 	$(call if_changed,objcopy)
 
-# Boards with more complex image requirements can provide an .its source file
-# or a generator script
-# NOTE: Please do not use this. We are migrating away from Makefile rules to use
-# binman instead.
-ifneq ($(CONFIG_USE_SPL_FIT_GENERATOR),)
-U_BOOT_ITS := u-boot.its
-$(U_BOOT_ITS): $(U_BOOT_ITS_DEPS) FORCE
-	$(srctree)/$(CONFIG_SPL_FIT_GENERATOR) \
-	$(patsubst %,$(dt_dir)/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) > $@
-endif
-
 ifdef CONFIG_SPL_LOAD_FIT
 MKIMAGEFLAGS_u-boot.img = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
 	-a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
diff --git a/boot/Kconfig b/boot/Kconfig
index e1a79976da1c..af54a0660e3b 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -283,20 +283,6 @@ config SPL_FIT_IMAGE_POST_PROCESS
 	  injected into the FIT creation (i.e. the blobs would have been pre-
 	  processed before being added to the FIT image).
 
-config USE_SPL_FIT_GENERATOR
-	bool "Use a script to generate the .its script"
-	depends on SPL_FIT
-	default y if SPL_FIT && ARCH_ZYNQMP
-
-config SPL_FIT_GENERATOR
-	string ".its file generator script for U-Boot FIT image"
-	depends on USE_SPL_FIT_GENERATOR
-	help
-	  Specifies a (platform specific) script file to generate the FIT
-	  source file used to build the U-Boot FIT image file. This gets
-	  passed a list of supported device tree file stub names to
-	  include in the generated image.
-
 if VPL
 
 config VPL_FIT
diff --git a/doc/usage/fit/howto.rst b/doc/usage/fit/howto.rst
index 280eff724f6e..675c9aa5bb0f 100644
--- a/doc/usage/fit/howto.rst
+++ b/doc/usage/fit/howto.rst
@@ -57,10 +57,6 @@ own subnode under the /images node, which should then be referenced from one or
 multiple /configurations subnodes. The required images must be enumerated in
 the "loadables" property as a list of strings.
 
-CONFIG_SPL_FIT_GENERATOR can point to a script which generates this image source
-file during the build process. It gets passed a list of device tree files (taken
-from the CONFIG_OF_LIST symbol).
-
 The SPL also records to a DT all additional images (called loadables) which are
 loaded. The information about loadables locations is passed via the DT node with
 fit-images name.
-- 
2.43.0

