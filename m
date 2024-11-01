Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001B6E674BF
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 09:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 931AD89045;
	Fri,  1 Nov 2024 10:18:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iE3eSxZw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B3A8892F4; Fri,  1 Nov 2024 10:18:45 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BE78892E3
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 10:18:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzIp2qnWZpkQYPCIWs2X891N2VIcNkvTv2nHLF+HQ9Q6y7Ycodlp0d2h5rhKZmpAm1P/HiNCLG3VdxKIPE774qDCyTzKFT1ntw/E6dVb6ZDZoHgnPbG4LVKkq+zrQFiOeZZLwbCaDY5xw8Y68C1fpFAC3mY0jxCTUpUbnui9EYP7wty9VEILfG4mLOiLArM2JpSSZcqG7SYUN01176Qaj50uOgKsrRcj+62C7WembZkv2yQp/uyn+rDLJIOuYUMV9f8tH4gweD9efKM6UpRIWz/5vOGn//onFP4Nh8X1PYwBuLNlwIUdC7fBTULRtxYUey6h0aZcge7TUkSLISPWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnvxxswkMKyo9eM7egk5n24dj9FYL34SV/Ze3lgjHqI=;
 b=LyCMhvaUEjeMVVVerfHw8K6lPHh2DNDeSRkKnCKWnLmKYwbpxsii/OI6Gvo3oOuiIdKLgUbMcBObcDXhviisHnYp90S1Y28eKMqZUb79DgugSoNEOX8BNm3uaOqPQ/DDtxiffdFIpDZKfC3KChbWIs8peuPqHWjXa5YilzyOnIiJpDKvt4PSnRLtzSCq5rvRUrlR9AE8BMEDOOj3E8HOpM+2R4wYA/xDXL9xhy3qdM/u/B8YA1iEo7Co2S4qi8+3CyGlGVKJpE8sTThxxa2zXqWc6iom/D/yNSlzDLip+yw7+cSgan3fK5VfIJu1vaLKa5CpxaS3gcWJ96aRTW75gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnvxxswkMKyo9eM7egk5n24dj9FYL34SV/Ze3lgjHqI=;
 b=iE3eSxZw00hTbia/aKIVS7Q47zcz404ffx1uJyDQr6uwyglgtWaR4+aiJZqgmcJnivMZrW171m610hAGx7p3PGULwXl2SISSvUbwWNbhIHucGbc6euSh5p/Uu0JRY7qRYfnO7VG6ELUKbZX7shrCepYOQLuoGz5Qk76cVafM2nw=
Received: from BN9PR03CA0144.namprd03.prod.outlook.com (2603:10b6:408:fe::29)
 by CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 09:18:36 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::84) by BN9PR03CA0144.outlook.office365.com
 (2603:10b6:408:fe::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
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
 2024 04:18:23 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>, 
 <neal.frager@amd.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>, Peter Robinson
 <pbrobinson@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v2 6/7] arm64: zynqmp: Remove mkimage fit script
Date: Fri, 1 Nov 2024 10:17:59 +0100
Message-ID: <cf438091e43c4c9d535a9cfa2886673aa42a4370.1730452668.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730452668.git.michal.simek@amd.com>
References: <cover.1730452668.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6758; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=0oLSnPQhIusP/iKj1116s3lB/UOSwTcW99zaFCw5bgE=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnSVOUf5Yw2P9k//sevahambVGLdV70quS4dOiG8TjPoW
 o6r+fFvHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiJd4M830nP7+ZnRPKm8c5
 of/ezRa/W1aSdxjm+2nueZsvffb2nhgvqW7Nhgpnbo8VAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 5448d19b-b4df-4668-9556-08dcfa562a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?arRWjffCsP8Cvy94Ji6rcq4/Fr/U17XYkv0piHgcYRnJH5VxOeu4cptfb9fV?=
 =?us-ascii?Q?WzfJt/30D7CtV8xB4FeBSBgf7FoCMNiywVlOzisFvGAPXQMF6GhofOhR0/Px?=
 =?us-ascii?Q?GQJMCK8Md1+4HsX3TAtTgSPudhKbnbquVyK/cZCUL8B1WcloVO7sktodttSg?=
 =?us-ascii?Q?E2DKYK4WiEmc4Z6sUQkthbLPt2FDUPx4TIrtB0j/gyKWJcDhxavTRoPnA0MK?=
 =?us-ascii?Q?cQk+ryvwX/7x+DniM/LuLcuLMLnVmYJz0+cjXJBOw/d3XJ5AVUB7a9SYa5bo?=
 =?us-ascii?Q?00JJTnYJj9pp8Ii4SbMGCwytsQ+Bz3C+LqOtk1vKxTusyiQfJ/T1TWgBHaGy?=
 =?us-ascii?Q?2fO4lFZAy+7k6PVEheCI8+BYM7S8KF1ku3Vdj8P3QFIuVEfcPUWj6yvce63F?=
 =?us-ascii?Q?EQjSEA3dwGJqHjF/hICncCyMb56fcZt5eS9bxT6Qu2bCl48qpa9qe2yDXZrj?=
 =?us-ascii?Q?l5Cf0aGkZqKvWO2uTHEdWC260rCu26PQsQXVe087cwwIrCXbdiqn6PeFuywW?=
 =?us-ascii?Q?iOyCc1QzH2CXiXh5RcAlzHrGFvOvnvbUbdVwvvF2I/jXqMjdevLzFLAEFf3K?=
 =?us-ascii?Q?8o+zAQ48RASUtsWo40nMCw1Gqy42HHmBEAOIuopiv8hpDIiFTiDYAVL0+HYu?=
 =?us-ascii?Q?dL2Kkr9BxzTqcV/HWJrN4IsGquZhdSCAMNXCQSvVhgn89GuDPpwBqOGVr/2+?=
 =?us-ascii?Q?BpJ/0Va5gt0gICtyUVDjfeWZmTgDTGz0qcJz2sxBhIhm04rYdZ0AFmC2q22F?=
 =?us-ascii?Q?Cd5/3fg6QPPjptM8SuLOKfFigxoKOPgzhJCyg0FsGQutBJe3JFSvPMYaC0fP?=
 =?us-ascii?Q?cZb74ilrH3YGtx/3yJ+7E1aEcLm5CRTYJUUP94aNfQaGx+TKQ5St6eh1k8Ji?=
 =?us-ascii?Q?icV+9mGpl8yvZAfnT8oGB1LrjPQeHcvT7b8s4EqeY3ZHCzmrHG34LXCL4XHo?=
 =?us-ascii?Q?xPDyuaNIg3xTAuR7xLKV9XzXi0JClelQ89UNoazUjlJHpEjRTi1MrzaP26me?=
 =?us-ascii?Q?vv+hDhFd6hlzU8cr2V5h/awJ3wszCaBUlmymVHyk/ZNLFOrBCS+pCZcO9kfl?=
 =?us-ascii?Q?5MSmcBZR9L5xTlCfNkKOThswK0pfPEXtMJunx28FXm5fPoF6TdFhw49fe+iL?=
 =?us-ascii?Q?y9kEFG5NnX2hDdLqDiDA0thX6SIOZVeeJJ5iU4Bs2gENhDqYMUvnxPN5ol2X?=
 =?us-ascii?Q?JCFQ3vKXGEwzSMX9wDrczI0FYQ7Ck6ns1a6R1EXFUGxYVnB1MWnq1YtPoOqK?=
 =?us-ascii?Q?lmpaurYT3NTTU/1LRFKBpmVJ86uECJ2f3jYb20rH5QeSyTvHDevYA5uAJXrM?=
 =?us-ascii?Q?ojWGRAiPPB5UArzsjN5n17be6KCr7mlCkLgIYGpAMifUk5Fkr7Q7lAQUr7pf?=
 =?us-ascii?Q?5Sm6m8KcOpX+muE/9rb9Gur6Tg6uL+I9Ua4hpiQOksphfDZumg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 09:18:36.1403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5448d19b-b4df-4668-9556-08dcfa562a37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547
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

Platform has been switched to binman that's why there is no need for this
script and also Kconfig symbols.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- new patch

 arch/arm/mach-zynqmp/mkimage_fit_atf.sh | 240 ------------------------
 boot/Kconfig                            |   1 -
 2 files changed, 241 deletions(-)
 delete mode 100755 arch/arm/mach-zynqmp/mkimage_fit_atf.sh

diff --git a/arch/arm/mach-zynqmp/mkimage_fit_atf.sh b/arch/arm/mach-zynqmp/mkimage_fit_atf.sh
deleted file mode 100755
index cdecb1c1d351..000000000000
--- a/arch/arm/mach-zynqmp/mkimage_fit_atf.sh
+++ /dev/null
@@ -1,240 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0+
-#
-# script to generate FIT image source for Xilinx ZynqMP boards with
-# ARM Trusted Firmware and multiple device trees (given on the command line)
-#
-# usage: $0 <dt_name> [<dt_name> [<dt_name] ...]
-
-BL33="u-boot-nodtb.bin"
-[ -z "$BL31" ] && BL31="bl31.bin"
-BL31_ELF="${BL31%.*}.elf"
-[ -f ${BL31_ELF} ] && ATF_LOAD_ADDR=`${CROSS_COMPILE}readelf -l "${BL31_ELF}" | \
-awk '/Entry point/ { print $3 }'`
-
-[ -z "$ATF_LOAD_ADDR" ] && ATF_LOAD_ADDR="0xfffea000"
-ATF_LOAD_ADDR_LOW=`printf 0x%x $((ATF_LOAD_ADDR & 0xffffffff))`
-ATF_LOAD_ADDR_HIGH=`printf 0x%x $((ATF_LOAD_ADDR >> 32))`
-
-[ -z "$BL32" ] && BL32="tee.bin"
-BL32_ELF="${BL32%.*}.elf"
-[ -f ${BL32_ELF} ] && TEE_LOAD_ADDR=`${CROSS_COMPILE}readelf -l "${BL32_ELF}" | \
-awk '/Entry point/ { print $3 }'`
-
-[ -z "$TEE_LOAD_ADDR" ] && TEE_LOAD_ADDR="0x60000000"
-TEE_LOAD_ADDR_LOW=`printf 0x%x $((TEE_LOAD_ADDR & 0xffffffff))`
-TEE_LOAD_ADDR_HIGH=`printf 0x%x $((TEE_LOAD_ADDR >> 32))`
-
-if [ -z "$BL33_LOAD_ADDR" ];then
-	BL33_LOAD_ADDR=`awk '/CONFIG_TEXT_BASE/ { print $3 }' include/generated/autoconf.h`
-fi
-BL33_LOAD_ADDR_LOW=`printf 0x%x $((BL33_LOAD_ADDR & 0xffffffff))`
-BL33_LOAD_ADDR_HIGH=`printf 0x%x $((BL33_LOAD_ADDR >> 32))`
-
-DTB_LOAD_ADDR=`awk '/CONFIG_XILINX_OF_BOARD_DTB_ADDR/ { print $3 }' include/generated/autoconf.h`
-if [ ! -z "$DTB_LOAD_ADDR" ]; then
-	DTB_LOAD_ADDR_LOW=`printf 0x%x $((DTB_LOAD_ADDR & 0xffffffff))`
-	DTB_LOAD_ADDR_HIGH=`printf 0x%x $((DTB_LOAD_ADDR >> 32))`
-	DTB_LOAD="load = <$DTB_LOAD_ADDR_HIGH $DTB_LOAD_ADDR_LOW>;"
-else
-	DTB_LOAD=""
-fi
-
-if [ -z "$*" ]; then
-	DT=arch/arm/dts/${DEVICE_TREE}.dtb
-else
-	DT=$*
-fi
-
-if [ ! -f $BL31 ]; then
-	echo "WARNING: BL31 file $BL31 NOT found, U-Boot will run in EL3" >&2
-	BL31=/dev/null
-fi
-
-cat << __HEADER_EOF
-// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-
-/dts-v1/;
-
-/ {
-	description = "Configuration for Xilinx ZynqMP SoC";
-
-	images {
-		uboot {
-			description = "U-Boot (64-bit)";
-			data = /incbin/("$BL33");
-			type = "firmware";
-			os = "u-boot";
-			arch = "arm64";
-			compression = "none";
-			load = <$BL33_LOAD_ADDR_HIGH $BL33_LOAD_ADDR_LOW>;
-			entry = <$BL33_LOAD_ADDR_HIGH $BL33_LOAD_ADDR_LOW>;
-			hash {
-				algo = "md5";
-			};
-		};
-__HEADER_EOF
-
-if [ -f $BL31 ]; then
-cat << __ATF
-		atf {
-			description = "Trusted Firmware-A";
-			data = /incbin/("$BL31");
-			type = "firmware";
-			os = "arm-trusted-firmware";
-			arch = "arm64";
-			compression = "none";
-			load = <$ATF_LOAD_ADDR_HIGH $ATF_LOAD_ADDR_LOW>;
-			entry = <$ATF_LOAD_ADDR_HIGH $ATF_LOAD_ADDR_LOW>;
-			hash {
-				algo = "md5";
-			};
-		};
-__ATF
-fi
-
-if [ -f $BL32 ]; then
-cat << __TEE
-		tee {
-			description = "TEE firmware";
-			data = /incbin/("$BL32");
-			type = "firmware";
-			os = "tee";
-			arch = "arm64";
-			compression = "none";
-			load = <$TEE_LOAD_ADDR_HIGH $TEE_LOAD_ADDR_LOW>;
-			entry = <$TEE_LOAD_ADDR_HIGH $TEE_LOAD_ADDR_LOW>;
-			hash {
-				algo = "md5";
-			};
-		};
-__TEE
-fi
-
-MULTI_DTB=`awk '/CONFIG_MULTI_DTB_FIT / { print $3 }' include/generated/autoconf.h`
-
-if [ 1"$MULTI_DTB" -eq 11 ]; then
-	cat << __FDT_IMAGE_EOF
-		fdt_1 {
-			description = "Multi DTB fit image";
-			data = /incbin/("fit-dtb.blob");
-			type = "flat_dt";
-			arch = "arm64";
-			compression = "none";
-			$DTB_LOAD
-			hash {
-				algo = "md5";
-			};
-		};
-	};
-	configurations {
-		default = "config_1";
-__FDT_IMAGE_EOF
-
-if [ ! -f $BL31 ]; then
-cat << __CONF_SECTION1_EOF
-		config_1 {
-			description = "Multi DTB without TF-A";
-			firmware = "uboot";
-			loadables = "fdt_1";
-		};
-__CONF_SECTION1_EOF
-else
-if [ -f $BL32 ]; then
-cat << __CONF_SECTION1_EOF
-		config_1 {
-			description = "Multi DTB with TF-A and TEE";
-			firmware = "atf";
-			loadables = "uboot", "tee", "fdt_1";
-		};
-__CONF_SECTION1_EOF
-else
-cat << __CONF_SECTION1_EOF
-		config_1 {
-			description = "Multi DTB with TF-A";
-			firmware = "atf";
-			loadables = "uboot", "fdt_1";
-		};
-__CONF_SECTION1_EOF
-fi
-fi
-
-cat << __ITS_EOF
-	};
-};
-__ITS_EOF
-
-else
-
-DEFAULT=1
-cnt=1
-for dtname in $DT
-do
-	cat << __FDT_IMAGE_EOF
-		fdt_$cnt {
-			description = "$(basename $dtname .dtb)";
-			data = /incbin/("$dtname");
-			type = "flat_dt";
-			arch = "arm64";
-			compression = "none";
-			$DTB_LOAD
-			hash {
-				algo = "md5";
-			};
-		};
-__FDT_IMAGE_EOF
-
-[ "x$(basename $dtname .dtb)" = "x${DEVICE_TREE}" ] && DEFAULT=$cnt
-
-cnt=$((cnt+1))
-done
-
-cat << __CONF_HEADER_EOF
-	};
-	configurations {
-		default = "config_$DEFAULT";
-
-__CONF_HEADER_EOF
-
-cnt=1
-for dtname in $DT
-do
-if [ ! -f $BL31 ]; then
-cat << __CONF_SECTION1_EOF
-		config_$cnt {
-			description = "$(basename $dtname .dtb)";
-			firmware = "uboot";
-			fdt = "fdt_$cnt";
-		};
-__CONF_SECTION1_EOF
-else
-if [ -f $BL32 ]; then
-cat << __CONF_SECTION1_EOF
-		config_$cnt {
-			description = "$(basename $dtname .dtb)";
-			firmware = "atf";
-			loadables = "uboot", "tee";
-			fdt = "fdt_$cnt";
-		};
-__CONF_SECTION1_EOF
-else
-cat << __CONF_SECTION1_EOF
-		config_$cnt {
-			description = "$(basename $dtname .dtb)";
-			firmware = "atf";
-			loadables = "uboot";
-			fdt = "fdt_$cnt";
-		};
-__CONF_SECTION1_EOF
-fi
-fi
-
-cnt=$((cnt+1))
-done
-
-cat << __ITS_EOF
-	};
-};
-__ITS_EOF
-
-fi
diff --git a/boot/Kconfig b/boot/Kconfig
index 7dd30a030e39..e1a79976da1c 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -291,7 +291,6 @@ config USE_SPL_FIT_GENERATOR
 config SPL_FIT_GENERATOR
 	string ".its file generator script for U-Boot FIT image"
 	depends on USE_SPL_FIT_GENERATOR
-	default "arch/arm/mach-zynqmp/mkimage_fit_atf.sh" if SPL_LOAD_FIT && ARCH_ZYNQMP
 	help
 	  Specifies a (platform specific) script file to generate the FIT
 	  source file used to build the U-Boot FIT image file. This gets
-- 
2.43.0

