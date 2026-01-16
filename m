Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2277ED4A5E4
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 01:42:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E06E8367F;
	Fri, 16 Jan 2026 02:42:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="MmDoRcy/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E95A4836A3; Fri, 16 Jan 2026 02:42:24 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 813B783623
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 02:42:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Haller@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5PUeL0JmGoshmEFoGbxn0OHQofEX07p25mKxRZW2J/pfCOCu5He17pPIWkjLnogWRb8qLSsoeREa5nmu1ojynIWKgCquy/On+k4XkoRxqxjPv5XmlY5GUn2WPJ6vKjN7gre+cwA2FLEJOKCNdYHUMePvyFLNyw9vR7zWzHAxXkcTC17Q+NqC4Y475C0Pep9Mwhu56UXM1TdOOhhT8IchLATaAR6rGP/O1VtXwAH92wQr8iqCl55XvGI7OI1nKB0QNUCYd9CmpIH+eXerymqDE8gyMEoiPXyVbrrkjvGDlsHfgGM+TvKl6uC46ZDNfs+tBPGMwARKHiKe72BPFdlsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsqYR0Z/c0J1fcqiPE8RW/Cew5Cbunx94XV9ARh6QIk=;
 b=c/HBKloSUwnp/5SFIr43+i1Wj08gOo9hlnuVsrdmJJEeQTxtJkkuc+MhDTItBtkl1AdznSx4N02IDlAC65ONoYDLBl/HE0pYh4OdMAq1S5RIXDMjF3G9gx3RcpAbs3CbuAbCuqdWiA8P6XPLOZCtl+rdTX1pdKKZ6xbnyUAcqnagKKPdUp98LeIoS/S+U9IDHdEQJPQBbE4qBfilOIE6zIYGXNjMqcdYLd6TljN4Juobqn9psVVAFKkWlsCn7+PAOxOWLPdSCoYTB8/VshlH+axAR7pL/nWypJiKTybf6LkmnzwgWYhzHPuOym1eNEjHUlPrFLhexGHsKXy1xr0A5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsqYR0Z/c0J1fcqiPE8RW/Cew5Cbunx94XV9ARh6QIk=;
 b=MmDoRcy/+6EBw0OSAGT0bJPz54KqwbuJiSKMlFLnWDBCQGbZNkDHij5tNiFIYS2+1isdKXBemKgsehLdFlE4P2uj0tdIc47wzixcJHo6SjzrIajs2YZT8RAB+3yV13O/rUUqNXrdaV9E4WFR934thiw5VkPzsuy/uJFcu7IJS+oG1Lq1smcP6pQxaffDIeSNb+49QVwiJ7yU6k+e3+dh6RD4QhRMMOaAC4Q0WlwErg0yIggT8H20HHYUHloJzo/isLPwKq0LFdDVaR8ALo8vFqOnyMB168N44cQBa9tNTuv7WPNMJgalQQ9X2mq6WygoTm8EvT8/t87xG/2gIc9htA==
Received: from AM0PR05CA0079.eurprd05.prod.outlook.com (2603:10a6:208:136::19)
 by PR3P195MB1070.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 01:42:19 +0000
Received: from AMS0EPF000001A6.eurprd05.prod.outlook.com
 (2603:10a6:208:136:cafe::5a) by AM0PR05CA0079.outlook.office365.com
 (2603:10a6:208:136::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 01:42:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF000001A6.mail.protection.outlook.com (10.167.16.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 01:42:19 +0000
Received: from lws-haller-privat.attlocal.net (172.25.39.212) by
 Postix.phytec.de (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 16 Jan
 2026 02:42:17 +0100
From: Dominik Haller <d.haller@phytec.de>
To: Dominik Haller <d.haller@phytec.de>, Tom Rini <trini@konsulko.com>,
 "Teresa Remmet" <t.remmet@phytec.de>
CC: <upstream@lists.phytec.de>, Wadim Egorov <w.egorov@phytec.de>,
 <u-boot@lists.denx.de>
Subject: [PATCH v2 3/3] doc: board: phytec: Add phyCORE-AM68x/TDA4x
Date: Thu, 15 Jan 2026 17:41:13 -0800
Message-ID: <20260116014116.767555-3-d.haller@phytec.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116014116.767555-1-d.haller@phytec.de>
References: <20260116014116.767555-1-d.haller@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.212]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A6:EE_|PR3P195MB1070:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ff4c5a-3309-4766-7ad0-08de54a07ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w3kbA7C6LnUOA015Jy/rxZWiTbvwu8iuaXr51aKI+q8BKTXAjEKoDBXVgGVO?=
 =?us-ascii?Q?33Nji0cMAhV6qhNWOqumYHC8KyQwUaqGErtrKblpm8MSUIrnqC9E/TiVwjJi?=
 =?us-ascii?Q?GH46fPMKRco5parTZ3lrdV/JQSmo2rbjukIe+F14XLj+9/6JqTuL9LPLHqTx?=
 =?us-ascii?Q?0Doj+9LSb6ZPSZ3Hx7bzzQ5MLx5ynVCCjrdK8FCDHVtQxsskP0LtKsFlpwDw?=
 =?us-ascii?Q?trkO48q86xPAu/nO2nWa3m87NoAvYjHYsv/u57EDbuJNspKMHlhml1LMUwKH?=
 =?us-ascii?Q?tIF/BgafCWt48Q+A4kIZSTWhmKD97Uf761/zRm5gokYpl89qUNSYjfUkkwIm?=
 =?us-ascii?Q?sLqvWrMzZWMsIOAImhLl3INcNo8711OqC2KhmiGEAekQnG/BHMrdolrxiFn7?=
 =?us-ascii?Q?i9e16aGq1m5xvA0mwMGbCHccaNAHTR1yjri9ljFisv/aLDVvkUieHdDAIanC?=
 =?us-ascii?Q?afiDVQ1CE4DMPvOCjqB2J9AlZN0HHLsoYmLpUXpjutofivAEhm9BHz1OWAxy?=
 =?us-ascii?Q?zfq/vydBRkSL4vBdVl1SC+ZC986TaXevReEqkk0yQu1DLo0lWrv6BsB1XYS9?=
 =?us-ascii?Q?KzQ0/4ienvnmM8jH+wkG3WqtysMr8oZcCoFfGDIyJsWka1oIQJZmuqhERXwg?=
 =?us-ascii?Q?aiCC7x8o5Apcj7ytvO2jHQK65EOy0UChdjAE1IapDt3tMcsoodGi1WKpdYKE?=
 =?us-ascii?Q?AlIEX3zSg2y4IPWrCEV+3ZBHGc/djBUbc+UKPoCFvmFTaltRf97tfAjPClcC?=
 =?us-ascii?Q?vf0EJLlMr87lRLFDMRUun8M5kqNYiUagWsqx3MiI8br0Q9iL3fR0AI7vMGnO?=
 =?us-ascii?Q?EOFfkLi4KjtGngiVb9u64FTdTPjdm7AjegXlzt3luEAOzaF6Cse2WY0PCqh3?=
 =?us-ascii?Q?lWyNUQg6+elYgQAKHxrOWWA1s05jOZqBrSj5iEprIF518qN//dPOpRyk8Qgk?=
 =?us-ascii?Q?o/+hCPGZUbKnHrfHiwSKOSYPuHir9zO/z6MgJrgEfpKLSea9G+bgq7yTSQZy?=
 =?us-ascii?Q?Enp3XVscEhZvsL7PMp4n73uY3ZgIV2b79+2Lm8L+F6UkDDF/5vwaQQGvxXL4?=
 =?us-ascii?Q?638GPtc4cgrnYAQzUzbCrPZ+haIqfT2vS+CCgTrMh7kQ7wwfQ25CoeKToqie?=
 =?us-ascii?Q?OI3vcD3szNDDnBvxf0/PHuYe+ebs7GSPV05YsDfTZQgeOlvV2vUMSw2IatjI?=
 =?us-ascii?Q?fHZBdVlTHynlsaoSfnM3COKrgQpIA39ffP4NcCRJHFAsh1lBOn/fIEs5x7va?=
 =?us-ascii?Q?LGc40iyBwSZIqasLJHU5IwTYGmmv4a8C0H8w1laa0g0cBkhkQOQj87a+damZ?=
 =?us-ascii?Q?V4/D/fpQro+Vt1dmOPt/QKOVrwC7WJQMETf02vqkSxC2MEsKOCALW+ky1gCM?=
 =?us-ascii?Q?+PXp//se0Hq/svIJXQ0LNgdgiYl967f5sU6iEjN4Y70O5BweRDvq4F3zY8O0?=
 =?us-ascii?Q?NN5oBPeagdK2SH5Edk8w9Vgx8iuLltX827GaFoLu2aQvzXHWKROynybrE3Gy?=
 =?us-ascii?Q?4eDDDjbSmHkTsbCqgLSxY4zLdoBWEjbosGaVkPp+zFEWCdOkIJku6qwvejev?=
 =?us-ascii?Q?AWsOr4FgQvT2ny3kLB+Qgc5tkLkn1KRLtaM7OwHyXt7BVRoMa+z7/aFlRRx/?=
 =?us-ascii?Q?hfQMiIY5ZEjzrbyNHbVOdyoyvhpkIoqxI9WxMEUl0YkL+nw3uPIXgcJ09HPr?=
 =?us-ascii?Q?2o9TSQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 01:42:19.5408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ff4c5a-3309-4766-7ad0-08de54a07ca4
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB1070
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
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
---

Notes:
    Changes for v2:
    - Added Wadim's tag
    - Add doc file to maintainers file in board directory

 board/phytec/phycore_am68x/MAINTAINERS |   1 +
 doc/board/phytec/index.rst             |   1 +
 doc/board/phytec/phycore-am68x.rst     | 166 +++++++++++++++++++++++++
 3 files changed, 168 insertions(+)
 create mode 100644 doc/board/phytec/phycore-am68x.rst

diff --git a/board/phytec/phycore_am68x/MAINTAINERS b/board/phytec/phycore_am68x/MAINTAINERS
index 2b5ef10b0069..5e175fdb9efe 100644
--- a/board/phytec/phycore_am68x/MAINTAINERS
+++ b/board/phytec/phycore_am68x/MAINTAINERS
@@ -10,4 +10,5 @@ F:	arch/arm/dts/k3-am68-r5-phycore-som-4gb.dts
 F:	board/phytec/phycore_am68x/
 F:	configs/phycore_am68x_a72_defconfig
 F:	configs/phycore_am68x_r5_defconfig
+F:	doc/board/phytec/phycore-am68x.rst
 F:	include/configs/phycore_am68x.h
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

