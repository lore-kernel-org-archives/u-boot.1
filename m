Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E37C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 15:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D57483020;
	Wed, 30 Jul 2025 17:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="dHsDv0pk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8437801BE; Wed, 30 Jul 2025 17:42:36 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20726.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::726])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A595F82F30
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 17:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCs5ybDlRVIw0TkMosaMRNTN/NzIbkAttY9wOTlVdl6ipuqv1x2o3DI+dQ4EvF+CWQoF+mvtyWR4wAS4n8RuMUEfVILFK6iDiPUksKRaO2bvyLlB/IMiGK/LSU2n9p3hbqMD4SEiPVet7Yfw2ctAs+gtAvI8T3jjG6SAPi7WKRyxOTGDUtMXwc+x0XkgVco4ZJ8dJhtD3Mvwk7rzwVqX55NtY34fnnviVEuJEe4ac7TZpGY+QE/FC/5Ymj6TyFWgplABoukeQWcVoSg3xR6GClMsai767gEZtkdYP71TzQ7lvyq0zaqMggDWYKThw3CXUqHpb8rh6ZxIZyvKwhZ5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+qs/YYgCshXUXdHlTMaUTaAURIT/qqC2038PVk+lcM=;
 b=rrM/A96i2DvbLE3U1N/rrRhBVd9kKg2oUQsaiKwhpsgd173qqsZZ8s3fk17+wVInH+nneHoM82kBJLVQm+6B1wUf2ni9hz0dFo6de95jPwRcnksGzitJrdcgxTOIPE5zzU2EGUJM+1RxcxbKpJ7dVcj3V6VrNJOhp1iNobM46IeZ0kYQkhbCILZ2x+6zuRLhYFA83Trs4fqInNP3TRkwafm2vrj+EQfmJo2oqLDD5/kjvMcK7yJHNwf0Yp6YBYt1wyUhcAM92eiwobiKN+MdlQFXy+ZDiCDY9whwXuyVb7kUbsGhCUrytO5UFZ+A5Nh/aGGWkbPwQDe/yGLVCk3J9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+qs/YYgCshXUXdHlTMaUTaAURIT/qqC2038PVk+lcM=;
 b=dHsDv0pk6wu2mg1bQvIQk4ykKHtuWBWGspPGOYenVD+cNJiFa5unGkdIjN+zBWCrkQVFRMG5S+OjyusPPzfMFhqxcd48n2xLnJhtX7MCa5rvHBkrzgFDDkxq1lOm771UvylevTv4Nnxq9R+NpUyKOPdbDG3fh1P52L0x2vkkUnVb6mEswsxzoMlIY9njqgV11ssv4dz0OHLXewwCAZUF0PEjG9DlwvAXmlQ/BQnqi5tOmohi5rwXS+1m7XpZ3deoANqp0/srRvoUehr1EDHpmF4KjCwFRsUi164LvGgwH+Nn6XLhjktHtrJvEFKen13YboOEBdNn5E1WWc7WTvyrFA==
Received: from DU2P250CA0016.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::21)
 by GV1P195MB1974.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:99::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 15:42:28 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::d7) by DU2P250CA0016.outlook.office365.com
 (2603:10a6:10:231::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Wed,
 30 Jul 2025 15:42:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 15:42:28 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 30 Jul
 2025 17:42:25 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 30 Jul
 2025 17:42:25 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <ggiordano@phytec.com>, <bb@ti.com>, <d.schultz@phytec.de>,
 <nmorrisson@phytec.com>, <joe.hershberger@ni.com>
Subject: [PATCH 7/7] include: env: phytec: k3: Add deprecation warning to
 legacy boot flow
Date: Wed, 30 Jul 2025 17:42:17 +0200
Message-ID: <20250730154217.1116751-7-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250730154217.1116751-1-w.egorov@phytec.de>
References: <20250730154217.1116751-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|GV1P195MB1974:EE_
X-MS-Office365-Filtering-Correlation-Id: f57e77eb-bb18-41ee-f181-08ddcf7fb05c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Byq6WM5mgqLAxPiKbjAXWHXlW1Y55l5GDGiRl+Aonui6g0O+4K913sowNO0u?=
 =?us-ascii?Q?PXQR60yj5vlA8LxA2DXfuk+FgvPkaU6sHMIGzd/paTzERxBbTzgZEv3EmdeE?=
 =?us-ascii?Q?cgE2VOXP9GXE9ntuLpoWsdcFTba7etkj6eQaUGzAGps6PLDwYTBnLUC+mkGV?=
 =?us-ascii?Q?ry3gVEa/zcmZu0PaJ9M6AgtP/5gvISlHPKkwTjxz4Vr2GvQhqO1Ywduvb2S4?=
 =?us-ascii?Q?SZsWDS8peTetSLrM6AumLnW1JXDLk4ioBxqJ9+mPDVDpEXY3PfgvHWQLUIgD?=
 =?us-ascii?Q?DqnrlSgo3kX0rd9MBzNNEzv1GNKDwm6+Z69mn1vzR43llj6B195C5Y5O+09w?=
 =?us-ascii?Q?6B2TO/TC7gFMENb/h62fuB1kzf1kCosfv+EWaxr5XidsqB3b5oFfpbv1Dfd5?=
 =?us-ascii?Q?GsPBLGMFTMpbGCfYoRhGscoHCX20aLrUkIR1BuaSff05I5es/QHeBd9ZjCZO?=
 =?us-ascii?Q?rWTdilyKmOXnvmj/998Zru5c0g5Pn8YgwRDpPg1TtYjRFE5YjGMmNvGU2Whu?=
 =?us-ascii?Q?7bFy2HfbdbclRWFOwXPmHcNyqj21tHlwa08YzBudGNZlOVDYXMz8p5dBxBft?=
 =?us-ascii?Q?mv5uZlbVzxhH2Hf/cymMHCbcnN77pTyS7zbco3P9DxxVN3kzFG4qok83CXBh?=
 =?us-ascii?Q?StFylwvR0UUnC/ICtYE6AKZ4dXzMZ00ZgIixwu71+4JCLDm2wfBR/fKmV+j3?=
 =?us-ascii?Q?tt3mCn0OMaP2MZFfiGuzq6dE41t/JFJsu5GisDSSpfIn5YxOEOvSgF5Z4RBE?=
 =?us-ascii?Q?AdAMaKbgf13h1KliwWBavaQjtjbaHetxExbqVTsHQqRaNlITvQCz7kNPi/pM?=
 =?us-ascii?Q?VKs+hTzYGbVlGnGgcqSuQ2yOhDTASwjh5SXIKOT0LhvhNYlCmlggymNxSK3x?=
 =?us-ascii?Q?Ue3Fu3O6rvXMZRgGxvgeixkRxByKwOMUFg7g6YR1o9HA1U6iSFCvScUuLp5s?=
 =?us-ascii?Q?NL3we7bfC6dTwxelzDT7EsY5CnS7Ubl9Ssy7ghdVNsMRpsMugeU1G4czN1w8?=
 =?us-ascii?Q?23ZP+buo0njOUE/UdLtKUGfS22mcvgp55O3rJEZUx4XInzoqyg/RM9Y2HuON?=
 =?us-ascii?Q?IJ47OZy10EE6n08qMBCO1hOKubOwtgV5RgYn4YmVYofvuuxjwpWrInIjmp9J?=
 =?us-ascii?Q?OYPIorgkUpNP2dJPqmWP8v59nmKcQSVixAZh/zKYVSmb1pLyplSRCB8yLNVQ?=
 =?us-ascii?Q?X1/pxQqDGRnv8VZwdOPADuaL5a/wFkZnD8k10ASplmVy0XYTzfH+RvWmKHlG?=
 =?us-ascii?Q?KJejXp6bZqI9C/YKHcFV50sdKuq/rMZsImJ7EJ63e7yIb0UMIHi4aK6Dt1UO?=
 =?us-ascii?Q?rQdFIeOmXIKfz/nNRcc+uQ8Y4FuBBUw5TEGZTX8b2VboomS9TK28Rdon3E4T?=
 =?us-ascii?Q?BjlegG3xVFClBsTnjVvp53esiGGFodqmcVUQsGyJ0Jjz0vE98iRtyofHdYa2?=
 =?us-ascii?Q?uVOpTFaQ6ss0phZaD91THoJKY9MXc4IFggvM6aB72wMlJZhw3UeET6NOJ4Sm?=
 =?us-ascii?Q?8Uvjw61QVLOP8mjim+wL21nFo9VASzkpJ9/A?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 15:42:28.2432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f57e77eb-bb18-41ee-f181-08ddcf7fb05c
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1974
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

We switched towards standard boot with still keeping a fallback
using legacy boot command alive. Add a deprecation warning to
make it more clear that we will remove it in future versions.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 include/env/phytec/k3_mmc.env | 3 ++-
 include/env/phytec/k3_net.env | 3 ++-
 include/env/phytec/k3_spi.env | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/env/phytec/k3_mmc.env b/include/env/phytec/k3_mmc.env
index 3f67e312f65..95d0204b6da 100644
--- a/include/env/phytec/k3_mmc.env
+++ b/include/env/phytec/k3_mmc.env
@@ -14,7 +14,8 @@ mmcargs=setenv bootargs console=${console} earlycon=${earlycon}
 	${optargs}
 mmcloadimage=load mmc ${mmcdev}:${mmcpart} ${kernel_addr_r} Image
 mmcloadfdt=load mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
-mmcboot=if test ${doraucboot} = 1; then run raucinit; fi;
+mmcboot=echo DEPRECATION WARNING: mmcboot will be removed in future versions. Use standard boot instead.;
+	if test ${doraucboot} = 1; then run raucinit; fi;
 	run mmcargs;
 	mmc dev ${mmcdev};
 	mmc rescan;
diff --git a/include/env/phytec/k3_net.env b/include/env/phytec/k3_net.env
index 4d5c703cae9..669787928a2 100644
--- a/include/env/phytec/k3_net.env
+++ b/include/env/phytec/k3_net.env
@@ -12,7 +12,8 @@ netargs=setenv bootargs console=${console} root=/dev/nfs ip=dhcp rw
 	nfsroot=${serverip}:${nfsroot},vers=4,tcp ${optargs}
 netloadimage=${get_cmd} ${kernel_addr_r} ${serverip}:/Image
 netloadfdt=${get_cmd} ${fdt_addr_r} ${serverip}:/${fdtfile}
-netboot=run netargs;
+netboot=echo DEPRECATION WARNING: netboot will be removed in future versions. Use standard boot instead.;
+	run netargs;
 	setenv autoload no;
 	dhcp;
 	run netloadimage;
diff --git a/include/env/phytec/k3_spi.env b/include/env/phytec/k3_spi.env
index 8e9cfce3b4c..28fe69b4e57 100644
--- a/include/env/phytec/k3_spi.env
+++ b/include/env/phytec/k3_spi.env
@@ -10,7 +10,9 @@ spiargs=setenv bootargs console=${console} earlycon=${earlycon} ${optargs}
 spiloadimage=sf read ${kernel_addr_r} ${spi_image_addr} ${size_kern}
 spiloadfdt=sf read ${fdt_addr_r} ${spi_fdt_addr} ${size_fdt}
 spiloadramdisk=sf read ${ramdisk_addr_r} ${spi_ramdisk_addr} ${size_fs}
-spiboot=run spiargs;
+
+spiboot=echo DEPRECATION WARNING: spiboot will be removed in future versions. Use standard boot instead.;
+	run spiargs;
 	sf probe;
 	run spiloadimage;
 	run spiloadfdt;
-- 
2.48.1

