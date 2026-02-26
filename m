Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A40CFC5913
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 09:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D27A483C54;
	Thu, 26 Feb 2026 10:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yO1kouFi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B3C383D1A; Thu, 26 Feb 2026 10:27:38 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DDFD83AA9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 10:27:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/Vo5Gbk8BG3QEI1K2hYv9Vsqf1mUh5c4JYO4wNvJh7giClW0j13JZKHugNfzs26kpFBIdnTATcIfYxQvuFn25eNKf8J9mjFIniFCOFY37oft2z9m1SU25v3CSzvy2xjRQ7iUmR+LyGO1G3FZx8hQpUeZOPzK4ryENVvRc81lKxTl+s34/OgdO6R3IFpfmshXflEyii+m0ZhCaCG2lfnatEMLHi7NKwaTNTwG8IZZfsA5P9KPnt/UZn2O2RzMlaeJgSIGCJEQjiw9f3tYJLfTlAgExZg+rZ2ZxotgLZTPI9udbglE/emppWrGQkvA7ppAhvYMHsttoQE3c256+PfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R923tQwskncAiJ8zfj2uIm31aaXbfvyiZ/B/MuQwilU=;
 b=w27pTyLC+kBq50fNAQzjS1FQdHQoyMYn4Gq7I3CI/ScNFbKGW0Xre+TksPS7Jc+ZclS/RtXAzhR/5eET0E7Mc/Q4SdQB4LGmnBdJiUbmstIrrBczQA/Y1Wk8qHZRPr+EMTvcAAIkRXmdXzPHgDvu3GJD2QsiXuS5cwgGatkFuZ7rRCSkyqZZyJnaAFL1Ekydn1gDMNB4+5aRYHsfeM1FCtG2LiCg614OoDFZnnUl/qRPppErIY0w9cdVCpiYAaNW0wQHh0CvQT5xjGQMs4pSKycR0OElCH+SF8TdUIBDmA4mV+hpZcJepyokrUsjEWJDmd3QqLzQE503QuNUXcYOlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R923tQwskncAiJ8zfj2uIm31aaXbfvyiZ/B/MuQwilU=;
 b=yO1kouFitL39TO/s1IaodnLvaZwBfdHPZFzDkCiEebBThU/Wt7vWsMcOiVhXumhv/ihPtHvJxYaJ0v5rUdF4WY7TiU0w7AvXorOwj0UpGbvAy2GOG6ZKZxQU4K8g8lRVzPWDrlQ3g1ZNjxluZXTxzBphAOCYBtUhe+VusuP9lAI=
Received: from BN1PR13CA0022.namprd13.prod.outlook.com (2603:10b6:408:e2::27)
 by DM4PR12MB6616.namprd12.prod.outlook.com (2603:10b6:8:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.25; Thu, 26 Feb
 2026 09:27:30 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::82) by BN1PR13CA0022.outlook.office365.com
 (2603:10b6:408:e2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.0 via Frontend Transport; Thu,
 26 Feb 2026 09:27:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 09:27:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 26 Feb
 2026 03:27:29 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Feb
 2026 03:27:27 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Feb 2026 03:27:27 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Hrushikesh Salunke <h-salunke@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 "Simon Glass" <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>, Tien
 Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>, Ye Li
 <ye.li@nxp.com>
Subject: [PATCH] spl: Remake SPL elf from bin
Date: Thu, 26 Feb 2026 10:27:16 +0100
Message-ID: <da5461e758daf9c39c59b644e9abbe49e746229c.1772098034.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2546; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=+21M5cp8EHptdoKkdzHd8TPTyxxigK5ohXghGl8AO3w=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQuEPxqrnd2W1BOg9zlrEqOZ1M3GN5bGi0SaFkrEfzsy
 NtdfRu/d5SyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEFh1h+F8U/kOmt08z6/vi
 suW7amZEifh8EZwy/17ekssX9B568jAw/PeuKOR2+bwrR8hNKP7r85d7esuZVoZtcvoVGLHDIGj
 +ZU4A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|DM4PR12MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 25414aef-4d9d-4d10-38fe-08de75194354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: WDAPsnR72tolV7YJ7ps3YX0NC9f32WrFAA12Am2Ags93Yqj0C+Ybcmyts6AErg7NEV6+GSgrDw5VTXl5wFA4yQvWKNvVMBoNDc4Cwcd5k2jKELEMF6D4vbPqxpc4qF82mFA3XbsPNgU5WOruVHjBV3R8++Zg5tENq9yk6DKfk5k/xEXfjbZgPkfvCdF5l+BC3s0RJgjiQnMfDgDlYn2McgEsKXNbhlTyd32yiS1SMPExXl9wbAqHqOvtMKkN01kUkbojwkdVzXG1krs9j3v1GVmQySPstYjvvzgS1ljx2pjtE3TlpCeLZe6M7U/FBdVqtQ7cVcBmTwxYp870cIl7xp29t9wER/kcf7eRaGgR4VIfZm6qwxmR32ysg9BuZtTkzzuhAeot3/7JBsnajBp3X2RuWrnmdF2O2aoU088QXz4ajMW1jXWy3rDzEVHv+tmqT/EjYtRzsGz7pXsBLGjA7se/iTZXYUCO6JPb+Mvj7XfjUK+7hVuDVE/krvQHUSZiLTBZMpn/UvNyOngFDPGKxjPbqG7EPSlaQPObcNEjf1SKe7U25SusrKdEHQIzOKu+KgIQcgf0W1pJDgfGfxXk0X5pM7zrsiGl0B+LD/yViCUGeRmctoHLhSgZCAEBFF08WZcm5N6S4xp3nRv82TT0SnIXSwjeDYZGlb1+p2KlvFHa3YjZ+TigERcZ9lGQiFOrfVa+zlq/vg749pDWVUReFEPx169WrHnnw92E40TzNIgXw1qSS6oQVuQ8cuJn07TFVyXOOLjMAZ1FU9RV0KuOV7zf8mGYbDjQmonXmlTcrmj4xXquBeoyxsQiRe/ungqBZn9IpFQXSZxj5Jkp5svBZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SWkCFslfZDWDB2vWq1yFtH2AJnZW0uDrGNPlfv+JDynA98gRSeWaFIWjOsPtUcA+q+qNlh9xarbaSrCRdRITnkXVAlkh+90lFoJzIMDqq/JoolzPkBp412P9hmGpY8nK8RQYHPkeKSJbA3EG6BkuUFpeeicFQtMSFEQWHIPtxy0TTTS+nTpMopeja9RibONZ7sjZCfs43l2Rf/e/D9+ULyA0qHozo0c1EaHZJys1DOTm2z2TplEeaTAGJHDVpEeOkv4qhpQv3vAQqCOvK7F3Q2Xhrr4zsJt2zB/CBYi/VIBtk7V0CwEEiXv/EA/rGRlqJEwPNnL8qtBn5alEnaA9X4g3i48NCSIDwnd4bQT08qXEBORmad/qTGUvrsjBCuHCYRuZJo0iPQrEfDhx76wKavMDIL2zHmEk67HlPQAAhU4mqEPKNcpIaTvtE9+n1d/y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 09:27:29.6993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25414aef-4d9d-4d10-38fe-08de75194354
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6616
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

On Xilinx MB-V there is a need to use ELF file for SPL which is placed
in BRAM (Block RAM) because tools for placing code to bitstream requires to
use ELF. That's why introduce SPL_REMAKE_ELF similar to REMAKE_ELF option
as was originally done by commit f4dc714aaa2d ("arm64: Turn u-boot.bin back
into an ELF file after relocate-rela").

There is already generic and simple linker script (arch/u-boot-elf.lds)
which can be also used without any modification.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Makefile           | 10 ++++++++++
 common/spl/Kconfig |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/Makefile b/Makefile
index d5ae954f3133..4d83f844ac9b 100644
--- a/Makefile
+++ b/Makefile
@@ -1231,6 +1231,7 @@ ifneq ($(CONFIG_SPL_TARGET),)
 INPUTS-$(CONFIG_SPL) += $(CONFIG_SPL_TARGET:"%"=%)
 endif
 INPUTS-$(CONFIG_REMAKE_ELF) += u-boot.elf
+INPUTS-$(CONFIG_SPL_REMAKE_ELF) += spl/u-boot-spl.elf
 INPUTS-$(CONFIG_EFI_APP) += u-boot-app.efi
 INPUTS-$(CONFIG_EFI_STUB) += u-boot-payload.efi
 
@@ -2001,6 +2002,15 @@ u-boot.elf: u-boot.bin u-boot-elf.lds FORCE
 	$(Q)$(OBJCOPY) -I binary $(PLATFORM_ELFFLAGS) $< u-boot-elf.o
 	$(call if_changed,u-boot-elf)
 
+quiet_cmd_u-boot-spl-elf ?= LD      $@
+	cmd_u-boot-spl-elf ?= $(LD) spl/u-boot-spl-elf.o -o $@ \
+	$(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
+	-T u-boot-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_SPL_TEXT_BASE) \
+	-Ttext=$(CONFIG_SPL_TEXT_BASE)
+spl/u-boot-spl.elf: spl/u-boot-spl.bin u-boot-elf.lds
+	$(Q)$(OBJCOPY) -I binary $(PLATFORM_ELFFLAGS) $< spl/u-boot-spl-elf.o
+	$(call if_changed,u-boot-spl-elf)
+
 u-boot-elf.lds: arch/u-boot-elf.lds prepare FORCE
 	$(call if_changed_dep,cpp_lds)
 
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 996c9b8db4f8..0ee463d29705 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -707,6 +707,13 @@ config SPL_DRIVERS_MISC
 	  option to build the drivers in drivers/misc as part of an SPL
 	  build, for those that support building in SPL (not all drivers do).
 
+config SPL_REMAKE_ELF
+	bool "Recreate an ELF image from raw SPL binary"
+	help
+	  Enable this to recreate an ELF image (spl/u-boot-spl.elf) from the raw
+	  SPL binary (spl/u-boot-spl.bin), which may already have been statically
+	  relocated and may already have a device-tree appended to it.
+
 config SPL_ENV_SUPPORT
 	bool "Support an environment"
 	help
-- 
2.43.0

base-commit: 421159c60e64fe1ab123f0f997951670a2701a65
branch: debian-sent3
