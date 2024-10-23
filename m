Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39049D2E016
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 06:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E484892E1;
	Wed, 23 Oct 2024 08:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Li8PXE3o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B52F890AE; Wed, 23 Oct 2024 08:09:46 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85AF8890AE
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 08:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eo9KbXRZr25FJLbdxEE7tLx34rXjy0ZFu9N5rYRXJXBeLUpzKVqt8249HVkiCtXH2W4f+c9Nr0TiRFJCTXQYsYwXU1SH05k2DDKG0jc2Ccgr9EeOT064NAQg8pSiBXp56CBCYYhxuxLlYmzXCHfP56sKfM+pgngx8u4s5VeRlva+hzqGO8SjA2IqM/TDsqSH11b6CvXv8bGJ3kYVSl54efAv53q3PVnkW6LiApCf4DVVjtGJ98F2FU15rbCASYwdxunqL6A3ZiKbOHCQnNQGOm414Dn1kmM56moDqe36OqV/RkK1cfM3krfZ6Y53DYhRsmBGFLfx0HmdXJsrkqC0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Z8FLYaz7ZiGhvJY5ASVYy17fT5UZrUW9ghdT7Tfyzk=;
 b=qoSiBod6Ml+qOwJu4fbRH2i7mXm9OsevkJiR2r1Qpg3ukCmxEHefC8N2Xwim4I+JoGF9P/vnEzqENEZ3/qZVdeqbVuJFSGYKY9FdRHxoHC7pIugiwi8hQrrLiRwlWioCO/gt+nxp1Yuq2Nqa1FfhIUfuZ2omUsS54AZ2RD/X63vVPcXL139gVkCiKSCkqmI7ldPdZghIQowJDAA9cTGCK0CdbOrn4D3XUupzwVWz3TlKlT9mb3kzAHKx5Yy20i/nCY/G5J+HCHm9J8NmTSEmSeCIQRAAHWMn5RqjDfjbDC8GcNewWplEogC3zlct+egDG32lxzBWYj1Fm08qrTmTQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Z8FLYaz7ZiGhvJY5ASVYy17fT5UZrUW9ghdT7Tfyzk=;
 b=Li8PXE3o0l2MePGdAAGBuE/1augLT7ZVy5HJ85NVGrfezkkAMuvH8z6gIvFiIzTyRnJKRodWcBoDIIQTCp/1jURLnfLuocHL74y6NrqC3jBKcVysFla8FXQhSvHN/syglCi4n8n3BM9ALLAlELaWZPovb4kH2i+4fztU3O4K0i4=
Received: from CH2PR05CA0041.namprd05.prod.outlook.com (2603:10b6:610:38::18)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 06:09:35 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:38:cafe::b6) by CH2PR05CA0041.outlook.office365.com
 (2603:10b6:610:38::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 06:09:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.2 via Frontend Transport; Wed, 23 Oct 2024 06:09:34 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 01:09:29 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Srinivas Goud <srinivas.goud@amd.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Paul Alvin <alvin.paulp@amd.com>, "Prasad
 Kummari" <prasad.kummari@amd.com>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>, Vishal Patel
 <vishal.patel@amd.com>
Subject: [PATCH] arm64: zynqmp: Configure SoC RTC on SOM
Date: Wed, 23 Oct 2024 08:09:23 +0200
Message-ID: <9b684faeec85381b9b8fe796aaebc2ee79f17b8e.1729663761.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1541; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=LD8Lbia2FUBlQLYnXNzRt53LCYQSt2tpP1jx3atkghg=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnSJyWIOql9lmhgrDrfusr+/L1/k5nEr0V2rRP5kz+Xom
 7flXZ9mRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZiIrCbD/MDVO3bZBIUdiZmz
 7u4hiYQTh/gslzDMD5miUGv29F2edijTTt0gv5TEXc3RAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: ac75623c-fbe2-45be-cac1-08dcf3294455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WuKJgFymeoGAgajZr0TiSfrhu5kr6/BsUhAs8GwbOB0skax7IvdRqGD1plcB?=
 =?us-ascii?Q?QI4Wjgf0iRvEiGhWyuOrT1ZSj4HEX3xJtVZOA2c52hz0pAkCYq/ac9uZ5dO/?=
 =?us-ascii?Q?Pyn2buv6T/GHOKi+GVGkrGIoCD7uAuFNG5k35xMGrseqSAs1FGn4pkqCzgg1?=
 =?us-ascii?Q?LW3lRDIl1CtU9+niDpcs9S1WFHaOlBFLSyJa1vnU4YPAcc4pzaffEOS8Yhmt?=
 =?us-ascii?Q?KZSJY9kMSqDNdhhoIuZ5V8LRoD7wvWesSCmYgV8dceaAmsTIauCtSQOFEMbg?=
 =?us-ascii?Q?bP3/VVJ5f2077yM9xiA/KjwwUCxM+T+z8+WEcbG8J/sIZscgY1zde9beIVb+?=
 =?us-ascii?Q?3DHJXnFVqVG1Wjku6aa7OarQRLXFi3Y3oTxn/y1W4ckEMJR1plpb7cEge2x0?=
 =?us-ascii?Q?AbKnGH5colghrkIHehiE5GlnaB106Fio/Co3X50grxkXPcxAo1mn7MjJZa/m?=
 =?us-ascii?Q?ig5SuQMtr0nQqRG6HsTtNmZ4ZCrfTuDGqAFFXlrGyVZU2tvzxS46QNOeN9uW?=
 =?us-ascii?Q?qfuc6IfOwzEO4Me+6kN9MHiTv3oUMW41WSsTjsbOscfOkcgAsgbBZl69u/L1?=
 =?us-ascii?Q?yCw9/QCvjdzjIEAt8XDL9QsmWvHBVSjxfNJrBuvioUEoOtwDLDBhP0Rmpy4/?=
 =?us-ascii?Q?fRVs+jcFlx+gLmxa5mRvRWZJNzEWxxEWsacEVbNFjcMlWAbkNU7D69qVo9xP?=
 =?us-ascii?Q?vN3+GeRunWaeMVEy1jb5ozzkcbRAwcdiZ2a3Ous0LId5UiNSwKLI+i+ME9/v?=
 =?us-ascii?Q?P7eqQM73nRuEyHbKIbvHltcQmnEmm6bQaOUO161JvwgGDKRNzyWfK/y35MUG?=
 =?us-ascii?Q?x8KeKY60T5JzYh8vCjXV92SAdgwOShZXEXBS2VYMBJQxR9MkejVGWURPnG/w?=
 =?us-ascii?Q?jEm6gMkf+X7ioxOFsVTDRerbHI2nr0j+fuLfXtqDDWenrAUTn6dp7HhZi+Nq?=
 =?us-ascii?Q?Q6wm2wR+jucsPChQss5Lmnn1seVE5b0zz90nFqOFKy4McgS1zwDziohAaYyv?=
 =?us-ascii?Q?3J+KDhqWALwSRmoGv9L3oCWP/DWAl9vNNA1LaxxZgqkvO3LIMrj0U21CpMxj?=
 =?us-ascii?Q?mRNcHJKVokYVlKR+wUElhA3sOYM+F1VSRi0KiMLFaw6Nc9uQWNpL9YiX5+5F?=
 =?us-ascii?Q?yEew7s4tB8OEH+k7k7MmnxVwwjP4a7ZtI8qGnMcEobeojoG+yKOglSwBd45p?=
 =?us-ascii?Q?+8GPT8UDVZEg0GXOhXFiV+wg9gycseGtHy7ER1ZrZM0y1oXsosOX2D9D1mIG?=
 =?us-ascii?Q?n6gnLbCiZdyEndEQQqarpYvfi7XxbXvU1ELD7OtM9AQF/gJhz7oTJ2/cCtfo?=
 =?us-ascii?Q?XQmMkYX6e0teu09J9ngWEvYroo4g8LxAiSBtTcl3FTjt8FI09aFvjpFRqa77?=
 =?us-ascii?Q?rdUrSFjMrpxV2OmcgtzkbgBTCOASzL2NPdXSvVdzIXJ+u+vB5A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 06:09:34.4668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac75623c-fbe2-45be-cac1-08dcf3294455
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
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

Use RTC available in HW on Kria SOM without using emulation that's why
configure it properly and disable emulated one.
Power on reset value of RTC Calibration register without battery backup is
not matching with crystal frequency which leads to RTC time drift. That's
why write CALIB_WRITE register with crystal frequency (0x7FFF). There is
also an option to write zero so that Linux will set default value (0x7FFF)
in driver probe but calibration 0 is not permited by DT schema.

Co-developed-by: Srinivas Goud <srinivas.goud@amd.com>
Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sm-k26-revA.dts  | 1 +
 configs/xilinx_zynqmp_kria_defconfig | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/zynqmp-sm-k26-revA.dts b/arch/arm/dts/zynqmp-sm-k26-revA.dts
index 8056f6b176ed..8c43ade94053 100644
--- a/arch/arm/dts/zynqmp-sm-k26-revA.dts
+++ b/arch/arm/dts/zynqmp-sm-k26-revA.dts
@@ -387,6 +387,7 @@
 
 &rtc {
 	status = "okay";
+	calibration = <0x7fff>;
 };
 
 &lpd_dma_chan1 {
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index dd4df0b2da17..0dddf69c5d05 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -187,7 +187,6 @@ CONFIG_DM_PWM=y
 CONFIG_PWM_CADENCE_TTC=y
 CONFIG_RESET_ZYNQMP=y
 CONFIG_DM_RTC=y
-CONFIG_RTC_EMULATION=y
 CONFIG_RTC_ZYNQMP=y
 CONFIG_SCSI=y
 CONFIG_ARM_DCC=y
-- 
2.43.0

