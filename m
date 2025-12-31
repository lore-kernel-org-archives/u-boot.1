Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A67EE57C8
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 01:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6460083FDE;
	Wed, 31 Dec 2025 02:43:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="oSzKCwuY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44FD283F69; Wed, 31 Dec 2025 02:43:51 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D552383FE6
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 02:43:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Haller@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NoNLNRrtkvNyhL9SlcmjQyXT4iGmcbCH3H6MONM45bjEZslAwxcBk//2ZRGNUANO0ek2A9l28n/jCNKkN7gzuM4Ht0BCx0KdPG0RKo4k1WR6FAPGhgLdprP5sxYbwY6Mu/ZqIEKLwUvBk8dHACJcfwpgOqLyURcDniGF4n4Fv8LcGhtwtXfYOchd5UQb5wEsmLVmMRaqKXrZ8xmRwVaCPJ0cRH2oGsF+VCLo+QWy6UUagW7qUsWGNj9vhcB5fOK57zwWLDolHHROz0947/51CqG7qq+LCM0SXMFHGKS7p+kQ/Dsx484WBaKLaZ3m+xovhGr9ZnLRVEmQEZ1b01nh6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17TPodblmUtkpwNDhD5TYbQf9yVvy7sEwNXvQCX5cGM=;
 b=ltZa7iI+appL12dc2TglMqc5bhugEvR9UrQPFucV73GgCt/GIwCxoLE2e/s10Ra3Um8znyUDZvdJM5WKIy4o4GJ/8P2GOY+bvbgz0nSRpW7hixY2hR0SHb+mKKlG39C6uw+dkpFX1wQZ6D7a1mlMp0CYw9Fe9Cwnf0vKiHhYakOUnGd9YT+8VlHGXXlOX60ngf3JkwXmAtrk4mdzqrpWqzWtUidgZQY5Iz5Xu+f81vXuJdjNdsRwt7CpbXHpfnNnDuHdvjQU7OaoCSu4KQAh6TM6XrDJ+MP6nIlZjH708idnHrJhqtXlAJER7hO5XLBxi6Ntuq3SlX0XNkEDjF3dZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17TPodblmUtkpwNDhD5TYbQf9yVvy7sEwNXvQCX5cGM=;
 b=oSzKCwuY1zriNXORLD1ntEZu1tIwVBMXzoCshRAKaa+hC0gdGOzSyyMqYHoW58nrga4+r+/8wuyf4pFeuARNofFb8G3aDA1VjjveEhZX1BJROpPnIh8eY8hFXTJamTiZh5OmsQThXyYwSaXQWM8+VBWw34i2c8g0RDGXaM8QMhOTd0LE8u+u+dcUqza6gUNUcTsk7KBPj3STeR66vn8UsnFYCa5o6hWigBDiD++mvV9NohD0wyzb/z1/a+2+EujhawDeNxOgXjuRcWyZuklwA1odvXJiDd3ToEbhrmb5X3xXPiT6ttu5XAEuszzdPIa9KCFSjT/j+UVUo/jVoIhSQw==
Received: from AS4PR10CA0018.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::12)
 by AM0P195MB0722.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:163::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 01:43:45 +0000
Received: from AMS0EPF00000191.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::6a) by AS4PR10CA0018.outlook.office365.com
 (2603:10a6:20b:5d8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed,
 31 Dec 2025 01:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF00000191.mail.protection.outlook.com (10.167.16.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Wed, 31 Dec 2025 01:43:45 +0000
Received: from lws-haller-privat.phytec.de (172.25.39.212) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 31 Dec
 2025 02:43:42 +0100
From: Dominik Haller <d.haller@phytec.de>
To: Tom Rini <trini@konsulko.com>, Teresa Remmet <t.remmet@phytec.de>
CC: <upstream@lists.phytec.de>, Dominik Haller <d.haller@phytec.de>,
 <u-boot@lists.denx.de>
Subject: [PATCH 3/3] doc: board: phytec: Add phyCORE-AM68x/TDA4x
Date: Tue, 30 Dec 2025 17:42:52 -0800
Message-ID: <20251231014255.87648-3-d.haller@phytec.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251231014255.87648-1-d.haller@phytec.de>
References: <20251231014255.87648-1-d.haller@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.212]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000191:EE_|AM0P195MB0722:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c60c6b-6501-4740-a937-08de480e095e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VD+2DFomxaazsdrNIWmEUwg3oT8iHqqH6QEQOZOLH+1BXtOmQTTltItBBVDR?=
 =?us-ascii?Q?Qcj5deJfUMWlQNSHWuKVQLJ0tm4+QdOZSMkjDP/j2+Inuvbl63q2+FAYtZGz?=
 =?us-ascii?Q?khD8RgxpSfDrEMY9xOkTYQCYVtpJ1PIc3MbvHKvcArEvoKlwe4yuA7P+CHn8?=
 =?us-ascii?Q?EBSHUqf5tXzpEVGbKlO2zfMcW9vONDmDOLc0ugcZooxdlsuTf8bVUWSveaYe?=
 =?us-ascii?Q?T5x3Ua4pNAHLY88t/Gg7XULyLI6L2Co0GnFA+O1a8bCAxV9UKU0lPZdX/3nh?=
 =?us-ascii?Q?i4kldp0iZPaqmBo/Q7VY1SOuqBIJOqW+WQtzh6m+jQt1daE5TuF1vkxzxOHU?=
 =?us-ascii?Q?IzPZy1K0ObYxElD4K+mWacXwzxfmo41CcP8PVkKxgC28oxIytFaguD2AjF6b?=
 =?us-ascii?Q?Wa/Wl2P/9JMu81Ayx4GsCr/3Cb9ZjOKy185eAfPQm6v7gjdqs08n9BNL4pav?=
 =?us-ascii?Q?fNaQeFFv/P9zZng5Dhihn6bn0JP9N81XMR1T6kFXEEQ4RMG1zopGm0yBE/RL?=
 =?us-ascii?Q?cQsMfrrG0EmgTg62z2fb/QGIwTjLwiQ5/4Y932w/vlluzQjlBcZpun2Xskcz?=
 =?us-ascii?Q?CIG7x4YZsTiew5Dben3T/QEtLjSgw/BRtt8xkj0IEJJxfjulnQDlxS2mfpaN?=
 =?us-ascii?Q?6SAY1V5AMtOEjhm6wwZrwtLyLzX3LyeSwdHq4RwxB9azTLVsmLuj2Vh0yydY?=
 =?us-ascii?Q?s9NMw/KBx0JCHhBvixbWurqaFGKrgVFS20w+9l4B7fZJ5KWtnm/rOJAuEzUa?=
 =?us-ascii?Q?SOVyNhBcIffOqj31sIdppihA11eiDAlVCWphlFpynuqEc/c9wrsRxG5HHXrK?=
 =?us-ascii?Q?QFfXbDAVNf4s5XJb8wjFs61HdxBZ1mygMTy0K7Oa92Z8wd8qLR0iqM7601HP?=
 =?us-ascii?Q?iaXHkyvKmpLvqKAv+13JlDc/NheuQqnodPOjRQsdvpmYW+1UpnMSNIEEhmc1?=
 =?us-ascii?Q?7aOySgdvwKJyGg4HyB0g0INF1UBRZud1DZ7wqaKOE5DVnwJqYr/Y2wOx6rs4?=
 =?us-ascii?Q?x77Cvi4wSfqnk16e9SdC6vahFBnaEt6/dFhTIYz5P/wgSAJUQXSNNaCz53Xk?=
 =?us-ascii?Q?RLNKu56VNniwLx5zI8nGoogcB7jSlRXYMMdlGI0OLs0ozlPbvf5pqGQBXTlP?=
 =?us-ascii?Q?iKpLuhT/+7dVIQ4CS7yatKmu8HVXqrOKR+iRGyJTzLb4NzhfMbvauUKG7DHp?=
 =?us-ascii?Q?y9bI7x2Flm6yLJqmk/nIjt5fAKj0NZkmTO1gvkhvkezg2Nikc4x4lWmhfSg/?=
 =?us-ascii?Q?PQVqnmfgNFSkfFJPb8es0YlauXZ2vOZS5yK/dXvmLTZWUvWmFuMi3/W/JTHS?=
 =?us-ascii?Q?ezr6LA1962Hq/+Cz5qDCZ6qEAQCuhEDU4jfdgC/cHSYrifYoazC7bqwOYX4A?=
 =?us-ascii?Q?JhxoxPRHzoNCQrOyKMvNGxe+0iFizpB0xwyqh4eSmRSi7u86IN3w4tyj0PPQ?=
 =?us-ascii?Q?g/284VF7uBzk+3dMfZDudkCaqaND1+EVixKQ1Q/2F66Lvp62kuCp70ygHYb7?=
 =?us-ascii?Q?Hn6oZBMRv50kdWU63/wwy3VIYzdfawCEiuG1?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 01:43:45.6679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c60c6b-6501-4740-a937-08de480e095e
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P195MB0722
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

Add documentation for the PHYTEC phyCORE-AM68x/TDA4x (J721S2 family) SoM.

Signed-off-by: Dominik Haller <d.haller@phytec.de>
---
 doc/board/phytec/index.rst         |   1 +
 doc/board/phytec/phycore-am68x.rst | 166 +++++++++++++++++++++++++++++
 2 files changed, 167 insertions(+)
 create mode 100644 doc/board/phytec/phycore-am68x.rst

diff --git a/doc/board/phytec/index.rst b/doc/board/phytec/index.rst
index e24040a496e9..dd9edd792f40 100644
--- a/doc/board/phytec/index.rst
+++ b/doc/board/phytec/index.rst
@@ -12,5 +12,6 @@ PHYTEC
    phycore-am62x
    phycore-am62ax
    phycore-am64x
+   phycore-am68x
    phycore-imx8mm
    phycore-imx8mp
diff --git a/doc/board/phytec/phycore-am68x.rst b/doc/board/phytec/phycore-am68x.rst
new file mode 100644
index 000000000000..974dc53a30a8
--- /dev/null
+++ b/doc/board/phytec/phycore-am68x.rst
@@ -0,0 +1,166 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Dominik Haller <d.haller@phytec.de>
+
+phyCORE-AM68x/TDA4x
+===================
+
+The `phyCORE-AM68x/TDA4x <https://www.phytec.eu/en/produkte/system-on-modules/phycore-am68x-tda4x/>`_
+is a SoM (System on Module) populated with AM68x or TDA4x SoCs from TI's J721S2
+family. It can be used in combination with different carrier boards. This module
+can come with different sizes and models for DDR, eMMC, ETH-PHY, SPI NOR Flash
+and an optional SN65DSI83 DSI->LVDS transceiver using DSI0.
+
+A development Kit, called `phyBOARD-Izar <https://www.phytec.eu/en/produkte/development-kits/phyboard-izar/>`_
+is used as a carrier board reference design around the AM68x/TDA4x SoM.
+
+Quickstart
+----------
+
+* Download sources and TI firmware blobs
+* Build Trusted Firmware-A
+* Build OP-TEE
+* Build U-Boot for the R5
+* Build U-Boot for the A72
+* Create bootable uSD Card
+* Boot
+
+Sources
+-------
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_sources
+    :end-before: .. k3_rst_include_end_boot_sources
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares
+    :end-before: .. k3_rst_include_end_tifsstub
+
+Build procedure
+---------------
+
+Setup the environment variables:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_common_env_vars_desc
+    :end-before: .. k3_rst_include_end_common_env_vars_desc
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_board_env_vars_desc
+    :end-before: .. k3_rst_include_end_board_env_vars_desc
+
+Set the variables corresponding to this platform:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_common_env_vars_defn
+    :end-before: .. k3_rst_include_end_common_env_vars_defn
+.. code-block:: bash
+
+ $ export UBOOT_CFG_CORTEXR=phycore_am68x_r5_defconfig
+ $ export UBOOT_CFG_CORTEXA=phycore_am68x_a72_defconfig
+ $ export TFA_BOARD=generic
+ $ export TFA_EXTRA_ARGS="K3_USART=0x8"
+ $ export OPTEE_PLATFORM=k3-j784s4
+ $ export OPTEE_EXTRA_ARGS="CFG_CONSOLE_UART=0x8"
+
+1. Trusted Firmware-A:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_tfa
+    :end-before: .. k3_rst_include_end_build_steps_tfa
+
+2. OP-TEE:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_optee
+    :end-before: .. k3_rst_include_end_build_steps_optee
+
+3. U-Boot:
+
+* 3.1 R5:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_spl_r5
+    :end-before: .. k3_rst_include_end_build_steps_spl_r5
+
+* 3.2 A72:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_uboot
+    :end-before: .. k3_rst_include_end_build_steps_uboot
+
+uSD Card creation
+-----------------
+
+Use fdisk to partition the uSD card. The layout should look similar to:
+
+.. code-block:: bash
+
+ $ sudo fdisk -l /dev/mmcblk0
+ Disk /dev/mmcblk0: 15 GB, 15913189376 bytes, 31080448 sectors
+ 242816 cylinders, 4 heads, 32 sectors/track
+ Units: sectors of 1 * 512 = 512 bytes
+
+ Device       Boot StartCHS    EndCHS        StartLBA     EndLBA    Sectors  Size Id Type
+ /dev/mmcblk0p1 *  128,0,1     1023,3,32        16384     278527     262144  128M  c Win95 FAT32 (LBA)
+ /dev/mmcblk0p2    1023,3,32   1023,3,32       278528    1693883    1415356  691M 83 Linux
+
+
+Once partitioned, the boot partition has to be formatted with a FAT filesystem.
+Assuming the uSD card is `/dev/mmcblk0`:
+
+.. code-block:: bash
+
+ $ mkfs.vfat /dev/mmcblk0p1
+
+To boot from a micro SD card on a HSFS device simply copy the following
+artifacts to the FAT partition:
+
+* tiboot3.bin from R5 build
+* tispl.bin from Cortex-A build
+* u-boot.img from Cortex-A build
+
+Boot
+----
+
+Put the uSD card in the slot on the board and apply power. Check the serial
+console for output.
+
+Boot Modes
+----------
+
+The phyBOARD-Izar development kit supports booting from many different
+interfaces. By default, the development kit is set to boot from the micro-SD
+card. To change the boot device, DIP switches S8 and S7 can be used.
+Boot switches should be changed with power off.
+
+.. list-table:: Boot Modes
+   :widths: 16 16 16
+   :header-rows: 1
+
+   * - Switch Label
+     - SW8: 12345678
+     - SW7: 12345678
+
+   * - uSD
+     - 00000000
+     - 01000001
+
+   * - eMMC (FS/UDA)
+     - 00000000
+     - 10001011
+
+   * - eMMC (HW partitions)
+     - 00000010
+     - 10001011
+
+   * - OSPI0
+     - 00000010
+     - 00001100
+
+.. include:: k3-common.rst
+
+Further Information
+-------------------
+
+Please see :doc:`../ti/j721s2_evm` chapter for further J721S2 SoC family
+related documentation.
-- 
2.43.0

