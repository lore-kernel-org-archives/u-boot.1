Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1452CC44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 12:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B798F80EF6;
	Wed, 22 Jul 2026 12:16:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Lnqf069Vfug; Wed, 22 Jul 2026 12:16:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4FB9680EEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784722610;
	bh=ys20hx2xwTLwxEcc2ndUozKJP9kmRUtgLniatAfnC5Q=;
	h=To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=Z/fu+8XXnOzK34QeRgsrkBwAqO+n9DUy6pDqS7ULoopUvY3/XsY1f5omDmIQYod4i
	 xk49N1KB6OffdQBAJond7ANUoXb1LPjWVjjpMVzegsoTHUIP/j0MlUv/dGtLrdmQbf
	 lsIMX0oQUfuIIXCyQPI9kson3s9BLRAKv4O0X5HzAeszzKR2O7LF2WuqhptDzYsMCV
	 14C5C7uQhTK5cX1dO1JBIsBygMe3PPyj2UJOa/P23fhASEZRSKifpjhrchIgIYBmfP
	 xZf58kVqXQ0l+86zfb3wVDVwjI6dvdQLdDedD3iN4RwRZZW1vv1oArlMrvgbhbTfBC
	 HVoE+vbfFZvPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FB9680EEF;
	Wed, 22 Jul 2026 12:16:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 06AE1788
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:16:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ECF8340095
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:16:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RCzpbBlXJGX2 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 12:16:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 401924007A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 401924007A
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 401924007A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:16:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQC84gTf2WbGO7ggMNN7CRtNAvOqdDYgzey9O9CDHZlrMrETCHtORCSnut/j2WwH2ykqUtlUbqnEYZfwMND8ryCRTM9zq+oD+vYWaKxb5BT4rQHbVnPoNX9laG5IND+yVx6Q25W9duLqAQGm7jFtvXioaOv51g+LwX8PKDrM3tTUJ2JIGjjL/z9GnGBmNB+7gkJezTpXNnLHpNKs18s3KklF3lAce93wS7futyVkGDsuA10ytGdSU0dnZP5x3PRiSwOCblaEps3AIEEyig06TY2bUUpHYT6gY9d2fUWLFv4rAvU6lzWUzRxPtUhepINkL8mEx0l0phSPvMqr8AW/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ys20hx2xwTLwxEcc2ndUozKJP9kmRUtgLniatAfnC5Q=;
 b=xNUfoRVBBVoROtyop96syO/tSUXgCy04Ugby0i1i3BDNu2/Gs74azSjjTxOb6vi7kg3zxg55+EOuDry/DdPmPCnj0xqdzzFjM/8/63S2tkMsfNC0+63/kRQNWWX93crXaqptvP6reJwsZ9VZS8sJEg0I3T5rSIpvZi80RxNe3KCfv8/l4h9oX5kY59/VokgHlThFhrtnGYqzTgT1NqJBQWlcpOVQCOiyHN/CNaNOmOzhKzT3/5WHBPty4BKRgonorrFPulgMwYsWAOcI0Jzb12gl5umNBimGf95wTKS57ieYMpZpAFU3l1JqwnNwKpXwUYtVcz3O5i4d01SEKvxVyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from BN9PR03CA0894.namprd03.prod.outlook.com (2603:10b6:408:13c::29)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 12:16:44 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:13c:cafe::18) by BN9PR03CA0894.outlook.office365.com
 (2603:10b6:408:13c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Wed,
 22 Jul 2026 12:16:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 12:16:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 07:16:43 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 07:16:42 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 22 Jul 2026 07:16:41 -0500
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] xilinx: zynqmp: Setup BOARD_SIZE_LIMIT for mini
 configurations
Date: Wed, 22 Jul 2026 14:16:37 +0200
Message-ID: <6d91337d971fa9e22f6f57371f8bc656ea6bb4a3.1784722595.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2868; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=L8EaZdHHaG0GQskaOawDQ5cwMJsABhgkE32TYP4X0qk=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQlbFl2aevZCLHrat1WnucFezYmXeDdv+jvh5+7bF5cm
 3e/5SKjbkcpC4MYB4OsmCLLdCYdhzXfri0VWx6ZDzOHlQlkCAMXpwBMxI+B4X/6XTWXzrvHBW+W
 LHnwa5VgT0lPM/Oq29P/v+G4/PSBlrMXI8PMpz8z9PxYs+SLe/mqmzwCBHIPTZiyrO9/huIBR4a
 rj/kA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: 76fdb563-beab-488c-7e2a-08dee7eb17af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: YJYQZ0MCJWaekpPfEWnJURSW6S6obkAj488x9zovQaSKi1PyYGbRWoE8M0AZ7U1FimgJDwE7iQUFKpFelEKHbY0pPZVoorxvKhNZDUb2Y8wUx0mFOIfPYfLfzSNQ2Pk68M29a8srceK9yS/OZTjaB7FxSGJHWhFNs433Y0m1tdFsD6/IWeiCGS3L85+Ly4ZbIz1cJZWLETbuXH6y0p2u2asGhGxnVhgHyKB7qTAQI4iZOAc2A7SOgzSJ4GNP0mc4RUbW5KfBDpCBRg3bZvODi5ZUOYYPfhxkPfELm3BAOcefu2dggFnP9J+YyhrQ9q1zpFTdmQEcqCDGJgNmW4NZrUGIXYOeoDxU9TVW7w13LXqjx1xNbaKMmjTCDL62ilrlHQs2ge60zqacIV4RU2IIw9da0coeWbv/hZS+/WeV6CnrX1oNYL5JTfR06lmNSI/5WaE2M6hMH7h2utjKDilyM4W8JJ+nJPMlSZxwb+u2HZv37MmJZVN596BV47Nxch+qaWh9aMhJOKwVwK/Do5R+79wKnH0ybAnBoA/MrfHDauh9GF5bNRb6gBmzEWRWcIMKoOi5T9J/ugh4Pe3p+KZVT+41kqleSmSjcMDKvXVETdRpJ/b6DlTZDSxC5r6+YvOUfbjohTTWzXXMasrV3rp7Nm3YsWpbg8fU5c1+niYVQzvp0a30ZSErjQ0XmIMoqsClP02J+KnEIbChbnbOtl8jRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NUM84n3sT5he2wWpJ1Fwdlj8NZjcl8Lpq1NBN09qixa4CX6RxmV4Eb/6BWksANEqPDVpQook4zrj6Y70chSkjW43wKQSqmkAyapG4xPl7dcCz2aQNZjygN/SrUFHLiaGjE75sDN//vBilvoVTS9AcLjo8lwX9FHh2Aae36rqj6SumeOXj0BiZRZc3khlDY3R91fVuFJ3PdOZXWvaebpeCZcqAH2gWFFixjD/xqoWbss5Yjv/c/swiSCY2nWuYMbaj4HJb7+g66N2mHL03Re7xS1OflhD2hz0d19s3TEUo1g6FqRzSCDoaOaK+F79GyNqXcX6+T10ypwqnqrwhJwKilsfAPXiFTHxGXjMVUvj4USnVyLYXeQdgQZvB7JG0DlXvTXROIxnoNVbI8yJ9matcvFWHx+EIckvxYV9lLC88+gRBXaSLoGmIqif7CPkibXn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 12:16:43.3468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fdb563-beab-488c-7e2a-08dee7eb17af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys20hx2xwTLwxEcc2ndUozKJP9kmRUtgLniatAfnC5Q=;
 b=bxxthS3Y0iMfwbU3H2/k2y/wL1LuaREFjJUL/J7Pw7fXXXfotycnwsqFN53YiyIBMvdQ8IyAE5fcZvC/L0XUcAvyLgIug7jAipMSN76MYiKnXlWag4x9SZleyVl0CeA0D8t2V6BspEIN4qdVi+L3wnBqxT78GaI+2h5uu9tTihA=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=bxxthS3Y
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Michal Simek via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Michal Simek <michal.simek@amd.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Setup BOARD_SIZE_LIMIT to 128KB (131072 bytes) for ZynqMP mini/qspi
configurations and enable CONFIG_SKIP_RELOCATE as there is no need
for relocation.

For configurations running from OCM (xilinx_zynqmp_mini_defconfig and
xilinx_zynqmp_mini_qspi_defconfig), move TEXT_BASE from 0xFFFC0000 to
0xFFFE0000. The initial 128KB of OCM (0xFFFC0000-0xFFFDFFFF) is used
for data buffer.

Memory layout in OCM (256KB total):
- 0xFFFC0000 - 0xFFFDFFFF: Data buffer (128KB)
- 0xFFFE0000 - 0xFFFFFFFF: U-Boot code + stack (128KB)
  - TEXT_BASE at 0xFFFE0000 (code grows up)
  - EARLY SP at 0xFFFE0000 (stack grows down)

EARLY SP is released when new stack location is calculated before U-Boot
prompt that's why no conflict with Data buffer location.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_zynqmp_mini_defconfig      | 5 ++++-
 configs/xilinx_zynqmp_mini_qspi_defconfig | 6 ++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/configs/xilinx_zynqmp_mini_defconfig b/configs/xilinx_zynqmp_mini_defconfig
index 20e2ae0f0030..8b1d8cc0439d 100644
--- a/configs/xilinx_zynqmp_mini_defconfig
+++ b/configs/xilinx_zynqmp_mini_defconfig
@@ -2,7 +2,7 @@ CONFIG_ARM=y
 CONFIG_SYS_CONFIG_NAME="xilinx_zynqmp_mini"
 CONFIG_SYS_ICACHE_OFF=y
 CONFIG_ARCH_ZYNQMP=y
-CONFIG_TEXT_BASE=0xFFFC0000
+CONFIG_TEXT_BASE=0xFFFE0000
 CONFIG_SYS_MALLOC_LEN=0x1a00
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xfffe0000
@@ -14,7 +14,10 @@ CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
+CONFIG_SKIP_RELOCATE=y
 CONFIG_REMAKE_ELF=y
+CONFIG_HAS_BOARD_SIZE_LIMIT=y
+CONFIG_BOARD_SIZE_LIMIT=131072
 # CONFIG_LEGACY_IMAGE_FORMAT is not set
 # CONFIG_AUTOBOOT is not set
 CONFIG_SYS_CBSIZE=1024
diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
index 03366a3b05a4..9457dd0a6723 100644
--- a/configs/xilinx_zynqmp_mini_qspi_defconfig
+++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
@@ -2,7 +2,7 @@ CONFIG_ARM=y
 CONFIG_SYS_CONFIG_NAME="xilinx_zynqmp_mini"
 CONFIG_SYS_ICACHE_OFF=y
 CONFIG_ARCH_ZYNQMP=y
-CONFIG_TEXT_BASE=0xFFFC0000
+CONFIG_TEXT_BASE=0xFFFE0000
 CONFIG_SYS_MALLOC_LEN=0x1b00
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
@@ -19,8 +19,10 @@ CONFIG_XILINX_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 CONFIG_ZYNQMP_NO_DDR=y
 # CONFIG_PSCI_RESET is not set
-# CONFIG_EXPERT is not set
+CONFIG_SKIP_RELOCATE=y
 CONFIG_REMAKE_ELF=y
+CONFIG_HAS_BOARD_SIZE_LIMIT=y
+CONFIG_BOARD_SIZE_LIMIT=131072
 # CONFIG_LEGACY_IMAGE_FORMAT is not set
 # CONFIG_AUTOBOOT is not set
 # CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
---
base-commit: 5da0b87566c20b6f429f05cad027027f4b1edc3c
branch: debian-sent3

-- 
2.43.0

