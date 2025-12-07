Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9038FD2CE17
	for <u-boot@archiver.kernel.org>; Sun,  7 Dec 2025 13:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA1B3839DF;
	Sun,  7 Dec 2025 14:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aJiK6MlM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AC8F839F1; Sun,  7 Dec 2025 14:22:44 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEA4583993
 for <u-boot@lists.denx.de>; Sun,  7 Dec 2025 14:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKc0Q5mlFp9rGLr+7dLWYDC+WrE3JzBlSQjLV9o0nY8dWkd3H0TGbFXkHoJ74nZE7VqGfIjT1S+xToJVcuuZmYRqyKYpt0I9WnSCmIwNRqz4BiDQnKIwUu3mt/ZUSiVkUUXBnemY48d3AXj7eFGsvB78ULaZ6tvS23Hxks49992ywfVlrYF63HRRQ115bZP0TNwbIO5pxk3EYF7iUAjbsnbZaD5H4cV2dPMNgJPIwv9xxp5opRN0PhT0lIPJdOn7e150LZ96V6tRuqn493NudMoiimqaNdaujS0f1Wxq9VQF1XpoPgdODEbFD7NZtf8ibFuFuiSycOeskCoGs4MIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bs9NzaKj4loqfb1YtbLK5moXRT6wK/3FLkjymaspANM=;
 b=jkOIgDPRYfnv2VPy2cvXs69CO/jT1OUuBI1CodTgT9ryfEbJ6p3Quz8KuuK/VdritS9dkCS3BcWe4JBmkV7s7WgYqA56i35I9dM8BxAo9t5mcrIOBnmv97xtyWjkPWoNHDWs8CsDW1o8IeqflEKx3+O1br7jyqNItONoa0zveV0W3yp6Txx5up4bMLaIeNMCsSJ2qbzx4A8K9Iyzt6dNvKqN005bzrgB9TeWoxEjt+ABGjQK8FLsLWdJOWyMqMPJ5pZN5cRGBzF3p0hnn4Hb3s+km5EDPFYx+RVl6q/Yig/Voiy6XrTqA5vYuxWTM9NMEmUbfiBxDaitQt5XLC5GAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bs9NzaKj4loqfb1YtbLK5moXRT6wK/3FLkjymaspANM=;
 b=aJiK6MlMphg5QM4zzCS3jl8+V1HXOI07NJYbCE6njUxM15uhczamTxFjZQSyaawko3pfsQfl5oXgEorAcChJY241M6jA6U2Z81qQ9ARjCxx7lEO2zKPoGrHSCJA7dWoI01Ffj/IoBhh46NPxwYYQGQvPE+V63iZlraV5NDWnm28=
Received: from SA1PR05CA0017.namprd05.prod.outlook.com (2603:10b6:806:2d2::20)
 by MN2PR10MB4224.namprd10.prod.outlook.com (2603:10b6:208:1d1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Sun, 7 Dec
 2025 13:22:38 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:2d2:cafe::1c) by SA1PR05CA0017.outlook.office365.com
 (2603:10b6:806:2d2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.5 via Frontend Transport; Sun, 7
 Dec 2025 13:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sun, 7 Dec 2025 13:22:37 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Dec
 2025 07:22:36 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Dec
 2025 07:22:36 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 7 Dec 2025 07:22:36 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B7DMXeR2083898;
 Sun, 7 Dec 2025 07:22:34 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>
CC: <nm@ti.com>, <u-boot@lists.denx.de>, <mkorpershoek@kernel.org>,
 <n-francis@ti.com>, <anshuld@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v3] doc: board: ti: Add J742S2 support
Date: Sun, 7 Dec 2025 18:52:30 +0530
Message-ID: <20251207132230.868264-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|MN2PR10MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ae9b6b-08cb-4a21-b6c5-08de3593b083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lxPZs46LP6+j9MuaSRGK7/oVb91bE/4I35ZpeOSIJVZ8t9whZt5XgeXVyDX5?=
 =?us-ascii?Q?K/9qSngpkn5Kx8fQyPXYBAgKKiw4BG6Tp6Ed8kWxGzj708wfKaunUqLOUF2k?=
 =?us-ascii?Q?j6GGrwu5cNOOzwwW9rkuM/xqt12hiPyJfNIWhHRy5j+82lHox4X0FMl3xQ8Y?=
 =?us-ascii?Q?deHxOzrRUpj4/WjuFOxLlmfFPn7WoyCAjzBQunHF0mEJ0jPHwqqROlxFrQlt?=
 =?us-ascii?Q?QZiT6tJl0uuwLwEgs/NH+9LznJMuhYmZn6Z5N7FM1Y7xp/8DfGqPWcu5ZdW/?=
 =?us-ascii?Q?fug+LMw4bhRiyip9yLHM3mj7getCeVB9rwfsRtlq8KoMgBsFLlMSSKYkRnvj?=
 =?us-ascii?Q?nndLoYYDr2q74ctHYTAaTR+Obw+U0jvh7/3eqi50n6oAaK44fnDJ6R2smQ4m?=
 =?us-ascii?Q?NoMIcQhOOC2xZc4LCFP6UN1txiNRitRCMUUpCzU7tzMdai+iGp74mQ7Au6FT?=
 =?us-ascii?Q?XLAg+Tmk6WzfRsnqyom5ywAmleRUEmGpHck39dnI6TSP7cERyX3kNL418CPB?=
 =?us-ascii?Q?o67ma2EUIMA/rgTD1ONgGr97RPSULGIe1hy29ki0p1+OXpOmT77Krzlf1KGo?=
 =?us-ascii?Q?as2UtIuTT0q52jHu3IX2gG2JPdqF3NZCxaGjl+awFSM8qCgAZHrce4sxX5Ks?=
 =?us-ascii?Q?XKGSRRRhNhSFtvAnjNkgjJWSwJIGS7OG8IFEoidZu8waaVMSNTo1kzFRwnMp?=
 =?us-ascii?Q?OCPbr8SpPIYJoIYlvjpAvkyINht+/taQlxhFs7We68xLQQyJ22Mgmc5KP1gK?=
 =?us-ascii?Q?awAYYizvCx6UTPD60HbbhiNXhdpvVhSuMOfTFq7CNULBuvvddf6VHPwu3DF8?=
 =?us-ascii?Q?xbUvNrHXr52sIRkZoXDkg+vp85ZRorETJa6B6QRHMNsevtSS4YiyDRT3cVk/?=
 =?us-ascii?Q?Wd5eI2PpSctrZ0YiVn7d2ZS9OPUrIA244XRaMzI1dgiEIl2DX4b94BzrBpFs?=
 =?us-ascii?Q?egixWycPC/5uhnOx5GwyxqjYZkweKhFckq/1TKUQ+ciyCOi3Mr4GID6qr38H?=
 =?us-ascii?Q?HUe9irbmI+DIDpQ9c9jFYaxRylF9LvGfimyqiM+ZJKexvklJH/Wke9ZRcG6x?=
 =?us-ascii?Q?hT8Wo2Bj+b3eAK/p9mvDDtF64vdnfYBpyDyU1TEcyWdd95C04tTI/vKO9JAC?=
 =?us-ascii?Q?IEQrVcaSc7rD8xhUWuLRcZHaW1dqByhieNQgbAsmr+hTthCc0+K698P6HE/t?=
 =?us-ascii?Q?rFy9S4hXTYJTo4WSE+mjv0bzjc4QROjs/zqoWBoFBFSdnF198G3FAcF5aTtr?=
 =?us-ascii?Q?YYTahIXq1c6Cfw1TdmC2DNPX/+dt9svwzy3lWuLWnOpWNyzY0LXWJcjIDH1c?=
 =?us-ascii?Q?7c+s2R7NmE1l1UTdg3mQlvNi+SdLNyHJ85dXbeOA4uh31Pvr1QcFRJoNTIdc?=
 =?us-ascii?Q?hR3mSVrjEjKoEfzTdcMFzJTdIakIXVqYEudcVs7pYYEDRTbX+hZvqhkn3Jaz?=
 =?us-ascii?Q?VIXIDrRsQF5AUDylxjegSVn23HOScPlRnot8BBiHp0XWcis3+kNnpM+1fAuU?=
 =?us-ascii?Q?N/9Gd+NiEbkW3RRNOWS9/xD966+ee9SJ9EwL?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2025 13:22:37.0413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ae9b6b-08cb-4a21-b6c5-08de3593b083
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4224
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
Test logs
https://gist.github.com/uditkumarti/28d9d698f7f74cbb9da76047ce1ce60f

Changelog:
Chnages in v3:
- Moved defconfig into AM69 block
- Moved GP information note just after GP Images

Changes in v2:
- Removed extra =

Patch link
v2: https://lore.kernel.org/all/20251205043602.845730-1-u-kumar1@ti.com/
v1: https://lore.kernel.org/all/20251204142451.834404-1-u-kumar1@ti.com/

 doc/board/ti/j784s4_evm.rst | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index 22442874110..d858dc7cdbb 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Apurva Nandan <a-nandan@ti.com>
 
-J784S4 and AM69 Platforms
-=========================
+J742S2, J784S4 and AM69 Platforms
+=================================
 
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
@@ -99,6 +104,13 @@ Set the variables corresponding to this platform:
       export UBOOT_CFG_CORTEXR=am69_sk_r5_defconfig
       export UBOOT_CFG_CORTEXA=am69_sk_a72_defconfig
 
+   For J742S2-EVM, use the following U_BOOT_CFG instead:
+
+   .. prompt:: bash
+
+      export UBOOT_CFG_CORTEXR=j742s2_evm_r5_defconfig
+      export UBOOT_CFG_CORTEXA=j742s2_evm_a72_defconfig
+
 .. j784s4_evm_rst_include_start_build_steps
 
 1. Trusted Firmware-A
@@ -143,14 +155,21 @@ variant (GP, HS-FS, HS-SE) requires a different source for these files.
     * tiboot3-j784s4-gp-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
     * tispl.bin_unsigned, u-boot.img_unsigned from :ref:`step 3.2 <j784s4_evm_rst_u_boot_a72>`
 
+  .. note::
+
+    For J742S2, GP variant is not available.
+
+
  - HS-FS
 
     * tiboot3-j784s4-hs-fs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
+    * tiboot3-j742s2-hs-fs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
     * tispl.bin, u-boot.img from :ref:`step 3.2 <j784s4_evm_rst_u_boot_a72>`
 
  - HS-SE
 
     * tiboot3-j784s4-hs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
+    * tiboot3-j742s2-hs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
     * tispl.bin, u-boot.img from :ref:`step 3.2 <j784s4_evm_rst_u_boot_a72>`
 
 Image formats
-- 
2.34.1

