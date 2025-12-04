Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B64D206AA
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 14:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B37738406D;
	Thu,  4 Dec 2025 15:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VT5aBTD2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1E7A84073; Thu,  4 Dec 2025 15:25:11 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58F7D84068
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 15:25:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLHu4HtPAVwcMtFc5kzz1POMWxxYg9y/ZeAfYpc+0oHiYUCZdX18r35XuglGdkJkDIVYXEvOuH9JWJvn8A3iX9WeAB5LVqn7XpmmzflUkI8YWWXjlI6+X9B9D7/Szna4+aly98gKcrhkIziyx8DbA9SD+wPm+fQ1slPCItlGwjsZTsw9n5tfVPkh/l0uhc8XFRgqGLw1VJLYm/ro9ubE+j4Stv7IFFX1mdLa1xmZ7peFjbMunvvhGODmXOYWMo/JJ4tyx9crnEaSCqbqak3QWGyIbsVqlfWJwmUOlB06am0mEXOuLsvnwfvvKLvRl2gXgNb883Xjx7BKglooHmHe7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swKOSOBdmOQnG+3KgGBRZ8grSpnmpdBC0oi4NANSbSo=;
 b=GTB3MBGa7q8eTG2QrLY5WRDeBLk3oWzcbvX7fFhRbN3jtmMZDzBBYptMUfV0/j1/Zn0SfqvDByLzjh4sEyzBfpg9pWqz3AHkHw26TXADj15+yEVUVtdSe4+ivd9DUuMkuNdLuirXU9gscauWskLXLSVotAi15h9LOsTnDtQbsWOpT0DREfDK4DZKlRAw8e3rG9Y0QqjFNLScFP1cy+k3Qx08NBSPhdcVADrVJHyIj+fninkY7d2/CsyT71bssN2S/InxhoGzGpOOmguuWZ+gVKaOt0f398SH09ZOtcc2WyAx0N8WUwRMefgovkR55jvq6xTZZHz/jSCLK3x/goXEwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swKOSOBdmOQnG+3KgGBRZ8grSpnmpdBC0oi4NANSbSo=;
 b=VT5aBTD2C6Edo7arb7QDFSgkcpeC3ydHEdvA4sy2/TTZ92kg1hw0QvfHa2QDe/wnsXyz5zbMw48r75RGCM+eCdhDwI77UN5o5B7D94WbQ9xjt/NMB5pVmNyqCeFnu6mq02CNwTKqQlNsMg1+NBWxhfIMYBgZG0peJSvzV5lvjw8=
Received: from BLAPR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:36e::14)
 by MW4PR10MB6656.namprd10.prod.outlook.com (2603:10b6:303:227::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 14:25:01 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::d5) by BLAPR05CA0005.outlook.office365.com
 (2603:10b6:208:36e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.0 via Frontend Transport; Thu, 4
 Dec 2025 14:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Thu, 4 Dec 2025 14:25:00 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 08:24:58 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 08:24:57 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Dec 2025 08:24:57 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B4EOtDg1683549;
 Thu, 4 Dec 2025 08:24:55 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>
CC: <nm@ti.com>, <u-boot@lists.denx.de>, <mkorpershoek@kernel.org>,
 <n-francis@ti.com>, <anshuld@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH] doc: board: ti: Add J742S2 support
Date: Thu, 4 Dec 2025 19:54:51 +0530
Message-ID: <20251204142451.834404-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|MW4PR10MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: d82b7376-9e95-45e9-4101-08de3340e886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?03vCqr1AenEPy0L+XePpeShvoxrX623bOt//HP4Jw43/8U8VvDF2UXJGVDW0?=
 =?us-ascii?Q?bp/gYXku5xHnz7b/allp6zy8BMmkBnNHlC7Nh/ziow/TAvjIIYerp+Na0Dv1?=
 =?us-ascii?Q?/faBFnWDljm9FC5WOWiLtcbB+kKM3WD7YSp0BgCIL8wU802Y/PevOa7alrS2?=
 =?us-ascii?Q?uDsteqi+LonjtIlhYJnCoaIv5x/a4b5tU+IVVxgkw4EGd6vjtAyU3D0ivkgs?=
 =?us-ascii?Q?gRHLuwHIMIuU9SK5/cltFq9rvbwfh3uCQkLlshJvU9VKmrIYzxyUt6Y8jyAV?=
 =?us-ascii?Q?namwd4KIJa7itZVetM4Ai0mrTlWk/oCnriUB4aM5L0PPmFUBP2H12SPJng1g?=
 =?us-ascii?Q?OEXMvtZAJCmBxXEOKIa+0rhgJJaB3orrCcqRrAv12et6HdyYL5lnDWju3O5s?=
 =?us-ascii?Q?nGw71uioGj0nr6LLyDUwDXj8NtIKoY64Hn7rSqylIXIos+N4d4Z+xQsLaHYn?=
 =?us-ascii?Q?jT/jkfZvcyOVUNf/IG5zWOtmhNn6SSIWvWp2qqkLsxe1pE+GNl3lC3yLJ0ZD?=
 =?us-ascii?Q?rimPaaIkAmZ4skM8lNWBV2z1hEN/+Dh0zM+MjvD01TyuZ1HTzzGrrn8w4z2x?=
 =?us-ascii?Q?j+zVA/RqIq47SPBqVla5J7BttaqFQRKGkYhrDvDkfbXhAEyvEdrGWaNTgQsi?=
 =?us-ascii?Q?mQ6KqJkg5aq9hzaCLtT+c2y2tfDDJd/ZC19AOPYCVOss/jBhdZ7aMtb6QGjz?=
 =?us-ascii?Q?Z85ZTfvcmub+SB1tZtx5OHFimQ+9W10dFB7hP6cAwpM7u2SZRr59B32aCbU7?=
 =?us-ascii?Q?k8y2E8XnBUZtjR3PzK468e1Ae9Uy2Hdb21xzEwAr86X+zYWoQNS7KZZRE9xw?=
 =?us-ascii?Q?SNNm/+ZynVDrPQf8/NP2LtqOmimKI3gJF7rX6BVLAGlUCGYZTNCXb7dlkR8x?=
 =?us-ascii?Q?UKZKeWqh6+1rEwX05ooXwxBRgD6aSpcJI7j7lJmBNvtH/NPvLJ4AONJeIqbZ?=
 =?us-ascii?Q?tak/bE3AHO7YeHYZ8XldyRibP3/xZijDzuGi8dQOlL/Z11mMsicgsyKhUHwJ?=
 =?us-ascii?Q?FqKCgKLyFqoeUZRET2QiXOSEoNXGpkbNaTGRBy7q8Z1mhUzrMDKulrxUbaX0?=
 =?us-ascii?Q?ln/SX/DjLaBmYeIYQuAZMASWenBZsKIyJDiWxcW0gSirVsyQsdhr20nCkYL0?=
 =?us-ascii?Q?EFESRpbI21Q2pivHe6DNTM384BP72cD2sUZNaOtOvIQZmfo6Mebp0Sb3Uh8D?=
 =?us-ascii?Q?PH6ZyJcM/Vl2sbF2u8d+1ozeM07+DLQleVpEa4nyn96AYnfqoUJYOH1htu+N?=
 =?us-ascii?Q?6//DGUF6GO1JnvILbEz9nM3YUglu3CsMqs41SLcpcQfNSHUA9xg5Xu+5H+0K?=
 =?us-ascii?Q?qTE1h6L9wBzBUFX79C7t9I9rJU51aGyiWbI1PPFSVclqxa9iaWiVyLgHPJ59?=
 =?us-ascii?Q?/+cNuvdfQQLLkas5Lgh3hrey0LcPyThRNjeblx75OWUE9aMvgENr72Pq9rz+?=
 =?us-ascii?Q?LisLEtHp7GP64HAiLu+O94PhKT6/cDoKzD4VhP2sWnKk9wNED+tkp0JyhKCT?=
 =?us-ascii?Q?mAV8Ef4icF76pFlPV+mmEDxiyoqmNfg2GsnMx20SBAZxDrK1ynM+j054x2kQ?=
 =?us-ascii?Q?9RsXK2zfbdLZZBEx51h4NnpMcqfVmsklHJluV3bk?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 14:25:00.2907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d82b7376-9e95-45e9-4101-08de3340e886
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6656
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

J742S2 SOC is derivative of J784S4, most of build infra of j784s4 is used
to build u-boot for J742S2 EVM board.

Add guide users on how to build for that board.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 doc/board/ti/j784s4_evm.rst | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index 22442874110..4162a42c075 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Apurva Nandan <a-nandan@ti.com>
 
-J784S4 and AM69 Platforms
-=========================
+J742S2, J784S4 and AM69 Platforms
+==================================
 
 Introduction
 ------------
@@ -37,6 +37,11 @@ Platform information:
 * https://www.ti.com/tool/J784S4XEVM
 * https://www.ti.com/tool/SK-AM69
 
+J742S2 is derivative of J784S24 SOC, More info can be found in
+
+* TRM : https://www.ti.com/lit/ug/spruje3/spruje3.pdf
+* Platform Information : https://www.ti.com/tool/J742S2XH01EVM
+
 Boot Flow
 ---------
 Below is the pictorial representation of boot flow:
@@ -99,6 +104,15 @@ Set the variables corresponding to this platform:
       export UBOOT_CFG_CORTEXR=am69_sk_r5_defconfig
       export UBOOT_CFG_CORTEXA=am69_sk_a72_defconfig
 
+.. note::
+
+   For J742S2-EVM, use the following U_BOOT_CFG instead:
+
+   .. prompt:: bash
+
+      export UBOOT_CFG_CORTEXR=j742s2_evm_r5_defconfig
+      export UBOOT_CFG_CORTEXA=j742s2_evm_a72_defconfig
+
 .. j784s4_evm_rst_include_start_build_steps
 
 1. Trusted Firmware-A
@@ -146,13 +160,19 @@ variant (GP, HS-FS, HS-SE) requires a different source for these files.
  - HS-FS
 
     * tiboot3-j784s4-hs-fs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
+    * tiboot3-j742s2-hs-fs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
     * tispl.bin, u-boot.img from :ref:`step 3.2 <j784s4_evm_rst_u_boot_a72>`
 
  - HS-SE
 
     * tiboot3-j784s4-hs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
+    * tiboot3-j742s2-hs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
     * tispl.bin, u-boot.img from :ref:`step 3.2 <j784s4_evm_rst_u_boot_a72>`
 
+.. note::
+
+   For J742S2, GP variant is not available.
+
 Image formats
 -------------
 
-- 
2.34.1

