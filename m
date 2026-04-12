Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AA3F3ED7B
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 06:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 607BD839D5;
	Sun, 12 Apr 2026 08:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EJxd1fxm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B00FE840D8; Sun, 12 Apr 2026 08:44:56 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2144A8341A
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 08:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZ+jj1dRZ1GrYGjAuGby9uDu7AYbAjNkBMHvNeMf03I1avSs2QKwm34sjTE3IqIJoZySr0GpFe500hUeCxL3uHgUEYUrdcQ2RR0g8fOiOnYFIYa7CRNpEvZdbWHPtlaMv9rw41vI3UdhDfgwTjWhZxUwBl398RU9+U/406fxR3N5+zOonFO+O8ASyzv8/J+Pxj2WOKM1gMFI/sP559s6EeS+H+YJFIopbq9Z+VCt4ZSqUry40JKJvnqL8+9eJhBlRDG6w/NhQz7U4KraM+bqL+itvoRJPI5XOCmbFU28nI+giFWZlNULlQPy1fe+rLvmJIKe4qDgOS1l8dZWsJj9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qq/YumI1unDt4XkDAQ3K6ukUEbqhponu3zUKvzRQ7tA=;
 b=O+9bfQv7F45KBiYbmceEISlGWAkUdGmhLZlAxP6KO8/1xN9YXpriL1Dt/hY+bJ0a5kvZQ23Zd1I3q6ZjqPYYrlsh/eG4twvvea+83JyyPzzrxvUcCi16qPjL1gsXjoN0EC/16ljPdUmPQde2pWQ7i2hr8jk+8IAYS4wccyB/jtX2x0jrDO424DfHynoRE883c9hg6Aik2aH6pTuo77Nlli0nwe54o110SSvXL0nF3J2I0OMW524NgRdqzEKjjcJOA/Biq4GFeeYulblHcIQlSrKCsYhE/O2Ko+WWq7Xi4KAUe4DdY7w1PENtQpE6fXq6KehWT/1PrVkY/MxWC2QvSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq/YumI1unDt4XkDAQ3K6ukUEbqhponu3zUKvzRQ7tA=;
 b=EJxd1fxm2g4zR5hUunaFTbxqwL8rXHVtyHrbimi78WbtKEBz9fD6OPFKrdFUCXqsw/i/IF2IOkFrue9kzMrJtIUBN6hkdSbyQ9YAHs/JehA2J/6FKLgH7WelnJib+nRivx58fuuMWIsgJLEupOG2qXQ5zTdXsPK/P6EN2OEQvw8=
Received: from DM6PR03CA0020.namprd03.prod.outlook.com (2603:10b6:5:40::33) by
 IA6PR10MB997681.namprd10.prod.outlook.com (2603:10b6:208:5e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Sun, 12 Apr
 2026 06:44:51 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:40:cafe::af) by DM6PR03CA0020.outlook.office365.com
 (2603:10b6:5:40::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.46 via Frontend Transport; Sun,
 12 Apr 2026 06:44:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Sun, 12 Apr 2026 06:44:50 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 12 Apr
 2026 01:44:48 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 12 Apr
 2026 01:44:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 12 Apr 2026 01:44:48 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63C6ijdV2987206;
 Sun, 12 Apr 2026 01:44:46 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <mkorpershoek@kernel.org>, <u-kumar1@ti.com>,
 <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] doc: board: ti: j784s4_evm: Automate BAR address lookup for
 PCIe Boot
Date: Sun, 12 Apr 2026 12:16:17 +0530
Message-ID: <20260412064701.357997-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|IA6PR10MB997681:EE_
X-MS-Office365-Filtering-Correlation-Id: 45a80ca3-fba8-4f98-9e8a-08de985eff2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: UODWfTxT9gvpx6zUpJ687Ss+TOXs62yei3sReJy/5WeZ5O5jJ1mxKjymxZQpgd6w0W/c6Qetf+VPI00UIA3uLIzAKE93QgkT9EC5R4bH7yuWiLE4dS8l7nrY4ROSNWWq5yEOOE7CBn1GfFSTD7hAaQJ04qiX+6JWmOwBZdRiGQi4Fib/XdQkguRIQ2/44jcgauvwtZvwniLkHBZFqvcO6vpvx0m3HACDFmYekaqKlQVeUHEnGvgJtrAhi4P3z9Lfx3BP2ym8Br/LiYZJEOAoDxb6NwaFuiKnZcNPjkwPVU/1VjuQG4RX22GRM8wp6+N7P8ox0d5NgGo8TSt1a1TxIuM3IDmKvz+c0zQoknzpVHN+Q1iDVq7kvmhJkp2KFiXHRIgfH7cWInxB1vrz0sEhuoGa2d94jACafRIDelLemc4clDkOu+yqfspBiSDUdUGcwEjbH0LdY6YqmbXyVKeVm6NU+f9vVziDZEwU+xkIuH8a1MMKJSSK6oafpgc5s10oXU+5xzM8KPlHKi0uKGF9jvZt8Pp3LH9NB2GKIRniFxwy85jvDndYlXFsUaqbwKY8yjasAYXYa6ggte6DaEyRbgXqVeXPsmPH0P7XMGiW+imzY9n1vY3hSxpE6GW5hGSBl752dMQw2aHW/k40Sm15PXAbbedNGCfp5vKRX0qBHrdaOnfXYXiYzJCSci8WXYGCYvYry8SCYJnDdhOpN+mORg==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YzMcRaS1LP0Ads2x16hSSDfJiQ/oa/PI6m2c/GFl5s9Y3YST19qXv8RXY9PJo1UxL9ZPkO4PlNGD3L/M0eIwmzRUoqCQ6CbVaqVEa+PoTh2DDvg5xlpbKLSVx8oa9PtWDbxm706yQAxPX6xMyEnaIMAwjDiBw+j804ZQO230Tt87a+KE/JC+5SbzMLacvGbmuzhZTvNGDS36HpEwPylPx5gG6dyM4YHJVAFM908LYcnRs1ORFMwHRSrN6NSMiBUidOfTot5404srAkvqJuQL/hKa71++VF+JQuXurja7vcfZEHn6dx0Xl22+lKjpco/pbNEnUX1HytJk8Ayy8YOH3FBheK+gM0dX716DxbL9IAQanCrEigi0viKrPBXiQy1HDWw4CNzYjCHecoZomP6CRPmk1s4v7Rwuwb34FIzwqcdXygtmihrVHW8UNw8C9i0C
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 06:44:50.7717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a80ca3-fba8-4f98-9e8a-08de985eff2e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR10MB997681
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

When the J784S4-EVM is configured for PCIe Boot, the Bootloaders are to
be written to the address specified by particular BARs. The existing
documentation hard-codes the address corresponding to the BAR under the
assumption that the Root-Complex transferring the Bootloaders is also
a J784S4-EVM. The Root-Complex assigns addresses to the BARs depending
on the currently available set of free system addresses. Since the free
system addresses vary with the Root-Complex being used, instead of
hard-coding the BARs, automate the process of identifying the appropriate
BAR in the form of a command to be run by the user on the Root-Complex.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

This patch is based on commit
e2fa3e570f8 Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh
of the master branch of U-Boot.

Patch has been tested by running the following command to build the
documentation:
make htmldocs
followed by verifying that the update is reflected in the generated
documentation with proper formatting.

Regards,
Siddharth.

 doc/board/ti/j784s4_evm.rst | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index fb767bedbf6..f89def076c2 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -456,12 +456,12 @@ The following steps describe the process of booting J784S4-EVM over PCIe:
       0000:01:00.1 Non-VGA unclassified device: Texas Instruments Device 0100
       0000:01:00.2 Non-VGA unclassified device: Texas Instruments Device 0100
 
-4. Copy ``tiboot3.bin`` to the endpoint. Use ``lspci -vv`` to identify the BAR
-   address:
+4. Copy ``tiboot3.bin`` to BAR1 of Physical Function Zero of the endpoint:
 
    .. prompt:: bash
 
-      sudo ./pcie_boot_util 0x4007100000 tiboot3.bin
+      tiboot3_bar_address="0x$(lspci -D -nnvv | awk '/^[0-9a-fA-F]{4}:/ {bdf=$1; ram=($0 ~ /RAM memory/ || $0 ~ /Memory controller/)} ram && /Region [1]+:/ {print bdf, $0}' | cut -d ' ' -f 6)"
+      sudo ./pcie_boot_util ${tiboot3_bar_address} tiboot3.bin
 
    The sample program automatically writes the image start address to
    ``0x41CF3FE0`` and the magic word ``0xB17CEAD9`` to ``0x41CF3FE4``.
@@ -491,11 +491,12 @@ The following steps describe the process of booting J784S4-EVM over PCIe:
       (with appropriate DOMAIN:BUS:DEVICE.FUNCTION corresponding to the Endpoint) to enable
       the BAR.
 
-6. Copy ``tispl.bin`` to the new BAR address (use ``lspci -vv`` to find):
+6. Copy ``tispl.bin`` to BAR0 of Physical Function Zero of the endpoint:
 
    .. prompt:: bash
 
-      sudo ./pcie_boot_util 0x4000400000 tispl.bin
+      tispl_bar_address="0x$(lspci -D -nnvv | awk '/^[0-9a-fA-F]{4}:/ {bdf=$1; ram=($0 ~ /RAM memory/ || $0 ~ /Memory controller/)} ram && /Region [0]+:/ {print bdf, $0}' | head -n1 | cut -d ' ' -f 6)"
+      sudo ./pcie_boot_util ${tispl_bar_address} tispl.bin
 
 7. After ``tispl.bin`` is processed, the PCIe link will go down again. Remove
    and rescan the PCIe device:
@@ -505,11 +506,12 @@ The following steps describe the process of booting J784S4-EVM over PCIe:
       echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/remove
       echo 1 > /sys/bus/pci/devices/0000\:00\:00.0/rescan
 
-8. Copy ``u-boot.img``:
+8. Copy ``u-boot.img`` to BAR0 of Physical Function Zero of the endpoint:
 
    .. prompt:: bash
 
-      sudo ./pcie_boot_util 0x4000400000 u-boot.img
+      uboot_bar_address="0x$(lspci -D -nnvv | awk '/^[0-9a-fA-F]{4}:/ {bdf=$1; ram=($0 ~ /RAM memory/ || $0 ~ /Memory controller/)} ram && /Region [0]+:/ {print bdf, $0}' | head -n1 | cut -d ' ' -f 6)"
+      sudo ./pcie_boot_util ${uboot_bar_address} u-boot.img
 
 9. After ``u-boot.img`` is successfully loaded, the boot process is complete
    and endpoint should boot till U-Boot prompt.
-- 
2.51.1

