Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88671D111A8
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 11:03:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B43E683B9B;
	Mon,  1 Dec 2025 12:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kWl3cPgo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA5A883BFE; Mon,  1 Dec 2025 12:02:14 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8067883B85
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 12:02:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3SNLrwFUkzfdNSgKu7ms8tfnc8m+6FpKOe+/rlh1nSSXojO4/3YfOWFQ62wx4eF/T2MjCq78rYMzL3d8eOkxFoxpdwlfSDjBcbEJYa9+vSaUGIXMyD1av/4nlc76Jo0nn0wCg4lNPAMYkzLuGbSCaULDY4/jegc61s38TdR7tPviQdWwCBX3+D6QZDYv6zOChc5bZzzYS38VsnQIieiIyi8cSWRFRP/HJI0iLGR9QlLDDqNPdfW2R7LNkBc78CrEHNpYwIe1DhiLgt04rzU9nE2zNUKp6lNSZZb38Mf48U3B2lgGt/lLus6nzliboFPPVTtuLV5uDUUtTlFs7Eiyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4Nrk6hEDt3fh+Co+JWta5r9UnhzEI1+KX4gp29Hj/g=;
 b=YMy10Vr+fqLya4INsxYcT1dQ2HTcFOGvrlM3DRqNgZB4lewZczngYfa4iobxzNBdYUwicXxU8v2BowcQxAPwYe1DJPdoXdeTbNhK6c4ONB7U6H7ovoKuYMNt7Rn9dGqS4VQcdmS0I17PCTZXLwzV+Zai2l5oXVbkBhrigRJHJvVKdoh6rt5vw7+JFdsrXSA0dJL7/mS1oXZUp/1Lpa7paO6IvV45jXYE3YCnWd1R1nTOn0ZUUKSMwe20HmUd6VXKWcz+66TrK3TOdbTncnrGT0q4FVM4wmdrM3HMlfhidd0DK0bUOaug1QznEXu8y2o8jDUwTFW30dsMz4RR3kaDtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4Nrk6hEDt3fh+Co+JWta5r9UnhzEI1+KX4gp29Hj/g=;
 b=kWl3cPgoVjz4AnVNX0l2/3bbfKk561Vq9pBacB+4ZD06S0vCxiEyLxp9r8YoRwTPip+P9+Y+8DbcviHCGmG6wSHG8W/aIGnfvXyqR7B+GxzHiyTdGaBGtWeGY+kf/80SEhJ44rvJCxoaE+vvllh6Yg9c+iBzubCynSfAkL/ItZ8=
Received: from CH0P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::8)
 by SJ0PR10MB6325.namprd10.prod.outlook.com (2603:10b6:a03:44a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Mon, 1 Dec
 2025 11:01:57 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::55) by CH0P221CA0027.outlook.office365.com
 (2603:10b6:610:11d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 11:01:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 11:01:56 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:55 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:55 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 05:01:55 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1B14qh306512;
 Mon, 1 Dec 2025 05:01:50 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <m-chawdhry@ti.com>,
 <c-vankar@ti.com>, <u-kumar1@ti.com>, <j-keerthy@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>, <jm@ti.com>,
 <anshuld@ti.com>, <s-vadapalli@ti.com>, <ahalaney@redhat.com>,
 <semen.protsenko@linaro.org>, <mkorpershoek@kernel.org>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v4 10/10] docs: board: ti: j784s4_evm: Add PCIe boot
 documentation
Date: Mon, 1 Dec 2025 16:31:03 +0530
Message-ID: <20251201110103.845413-11-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201110103.845413-1-h-salunke@ti.com>
References: <20251201110103.845413-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|SJ0PR10MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ff7dbc-3c2c-45bc-972d-08de30c90ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UK/53O408mQ5ZYukgEV9qsbALmvUtXqLKLP/+HLMrgSEQVw4nN4FuIEX6Wdz?=
 =?us-ascii?Q?9f1GH/3tHBVxDhhXIGhU9czz3LTB0UC/4Kj7ZoGRxdHVG0ZYf7e+WWCivXvJ?=
 =?us-ascii?Q?40cSVoG0ZrWyxsAPs8KV2xqkZ+EWzotft295aQc5rEcq/s3AVGXXZB7ubpB3?=
 =?us-ascii?Q?/Ne3LoIBBDy6cwJ3GeJfj9UHw6AD4j1cv6PEGpuB9oVnPi6tmaHm0tl8nDrk?=
 =?us-ascii?Q?xkZ3cX5fsCDY/F6lGa0n2Ecmwx+fmKeCxyoC45v1jAu4tYI9+mucGRTzY3LY?=
 =?us-ascii?Q?hQQuCpoopKeTX/rI7/hyYY0SeEjrrLAYWXIE8kDzWsqDq8vYvZE4WvPJvDtc?=
 =?us-ascii?Q?d/+5eGV2AtjJQNqh2VpDob8q44cVy0bvYAoF3EDR+vAkrQVuQDUw/pOtf2pd?=
 =?us-ascii?Q?OY69Uf5MUgXN7xNog2+7H5OTxPjVB6igmdzrD3kAWjiuWY+Uabu8sDu18TRQ?=
 =?us-ascii?Q?h95Fo3a1eFm8y2DFxXVA2MzozlFxk1GALvrG6+jLK6c3b0uGl9GaoQaolnbU?=
 =?us-ascii?Q?jt1FWTzsypcVx1xsIjDyCG7JCWAMm8aHGZAkFjLkSTHx6IbXZy34+aoytVdN?=
 =?us-ascii?Q?jua78AGhHOFzO7Gvz6O/juDOowAlhnGQhtRC9/8pEprFmzEw7Oqb5fqpFbJh?=
 =?us-ascii?Q?uHa7KRA+RrHlv7Y55H57o5iehgyQrPH3i7FosgjOKr6eRki5EXVzENdevUVw?=
 =?us-ascii?Q?sVm0v1jLkCrCEAgJrO3VMtcQu+8bRbxIydxrKsO+N6+iGA+nUQRqRusaoAYD?=
 =?us-ascii?Q?QvJKyYIqJgfnB9aP0J+Wh/6irclPTyPG2hiN788xxVKNRHO7nOy+mhaYbFvR?=
 =?us-ascii?Q?x8V52WL9xpxq+O7P8mvDLwYHA1kS6FoPEiBwYHPYy6eGYgdsZRzvCGArP1av?=
 =?us-ascii?Q?XBTA2GLz12hahl2KfqyrVwr9sqxqgGpRHyCVCFgDz5mu1K6Mzo8Tm8XEIB0O?=
 =?us-ascii?Q?V7mQUMJXWXMqFD44R3OXVDNz8CllSDqMrVboUhbj68IJlIw1tL0wuP7Her7q?=
 =?us-ascii?Q?ljTqYbaFTwAOKnirXCsVbfy1U4xNzIrMnEY9CGS6DYdbCRz+XpjoVJ+nT4Jm?=
 =?us-ascii?Q?lEY4/8VVjCMycHIxFFdamC/3TljfFJPS/SAUuBLqA3N9BVYs/A/N3Bnrr1Wo?=
 =?us-ascii?Q?eLjVVyz6hfqNe1cHH7UAQHxO+ynS6V0YQ4+7AX5nwYqrQ2JGvqdY5pZhioLE?=
 =?us-ascii?Q?lYcqCIgERmUo8eytRzaiBW5wKYaBw53fRT4llmDV73FAT5IS6YgQ5HRqnuD4?=
 =?us-ascii?Q?0iyhFZxEHYT2Hm0VCtqoOfeFRNn7lNLQ9JXhz/MZ1PLJjZ8isIMcpnlc6jf2?=
 =?us-ascii?Q?gnV4y4ysEiVT5jSzl/l/aWaXpn6mJ8uSmI425ojuFtvJzDrLKCJZrSY8Je1U?=
 =?us-ascii?Q?T9IErHycKGTMg0g68KX44ZCnVd0qJgCeG3c+LqS8TtoYfCzZzkLluvxt6uhJ?=
 =?us-ascii?Q?yVD/1vFCGhxamiHUvU7sZMKpLFPWGVage3mwyY7d0auKaMccqGVZM0nMyvpK?=
 =?us-ascii?Q?bYvYap2UVRO+5QFYs7eWFHrzi9w5dFbzv44Lt/6b1RkTaJiC1Q2i65NxwmJy?=
 =?us-ascii?Q?aiELaTO6q4LATLq/8NlCDf7l1n49hn+j4pMQNgix?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 11:01:56.2281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ff7dbc-3c2c-45bc-972d-08de30c90ae9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6325
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

Add PCIe boot documentation for J784S4-EVM including boot mode switch
settings, hardware setup requirements, endpoint configuration details
and step-by-step boot procedure.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 doc/board/ti/j784s4_evm.rst | 267 ++++++++++++++++++++++++++++++++++++
 1 file changed, 267 insertions(+)

diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index 22442874110..0c9dad122a7 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -280,6 +280,10 @@ http://www.ti.com/lit/zip/spruj52 under the `Boot Mode Pins` section.
      - 00000000
      - 01110000
 
+   * - PCIe
+     - 10001000
+     - 01010000
+
 For SW7 and SW11, the switch state in the "ON" position = 1.
 
 Boot Mode Pins for AM69-SK
@@ -311,6 +315,269 @@ section.
 
 For SW2, the switch state in the "ON" position = 1.
 
+PCIe Boot
+---------
+
+The J784S4 SoC supports booting over PCIe, allowing the device to function
+as a PCIe endpoint and receive boot loader images from a PCIe root complex.
+
+Hardware Setup
+^^^^^^^^^^^^^^
+
+To boot J784S4 via PCIe, the following hardware setup is required:
+
+1. Configure the boot mode switches on J784S4-EVM for PCIe boot:
+
+   .. code-block:: text
+
+      SW7:  01010000
+      SW11: 10001000
+
+2. Connect the J784S4-EVM (endpoint) to a PCIe root complex (e.g., x86 host)
+   using a PCIe cable. Both boards should be powered off before making the
+   connection.
+
+Endpoint Configuration
+^^^^^^^^^^^^^^^^^^^^^^
+
+The following configuration options are enabled by default in
+``j784s4_evm_r5_defconfig`` and ``j784s4_evm_a72_defconfig``:
+
+- ``CONFIG_SPL_PCI_DFU_BAR_SIZE``: Size of the PCIe BAR for DFU/boot image download
+- ``CONFIG_SPL_PCI_DFU_VENDOR_ID``: PCIe vendor ID advertised by the endpoint
+- ``CONFIG_SPL_PCI_DFU_DEVICE_ID``: PCIe device ID advertised by the endpoint
+- ``CONFIG_SPL_PCI_DFU_MAGIC_WORD``: Magic word written by root complex to signal image transfer completion
+- ``CONFIG_SPL_PCI_DFU_BOOT_PHASE``: Current boot phase indicator for root complex
+
+By default, PCIe root complex mode is enabled in the device tree. To enable
+endpoint mode, build the boot loaders with the device tree overlay
+``k3-j784s4-evm-pcie0-pcie1-ep.dtso``.
+
+PCIe Boot Procedure
+^^^^^^^^^^^^^^^^^^^
+
+The following steps describe how to boot J784S4 over PCIe:
+
+1. Compile the sample host program (provided below):
+
+   .. prompt:: bash
+
+      gcc -o pcie_boot_copy pcie_boot_copy.c
+
+2. Power on the J784S4-EVM (endpoint) after configuring boot mode switches.
+
+3. On the root complex, check PCIe enumeration:
+
+   .. prompt:: bash
+
+      lspci
+
+   The endpoint will appear as a RAM device or with multiple functions:
+
+   .. code-block:: text
+
+      0000:00:00.0 PCI bridge: Texas Instruments Device b012
+      0000:01:00.0 RAM memory: Texas Instruments Device b012
+      0000:01:00.1 Non-VGA unclassified device: Texas Instruments Device 0100
+      0000:01:00.2 Non-VGA unclassified device: Texas Instruments Device 0100
+
+4. Copy ``tiboot3.bin`` to the endpoint. Use ``lspci -vv`` to identify the BAR
+   address:
+
+   .. prompt:: bash
+
+      sudo ./pcie_boot_copy j784s4 0x4007100000 tiboot3.bin
+
+   The sample program automatically writes the image start address to
+   ``0x41CF3FE0`` and the magic word ``0xB17CEAD9`` to ``0x41CF3FE4``.
+
+5. After ``tiboot3.bin`` is processed, the PCIe link will go down briefly.
+   Remove the PCIe device and rescan the bus:
+
+   .. prompt:: bash
+
+      echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/remove
+      echo 1 > /sys/bus/pci/devices/0000\:00\:00.0/rescan
+      lspci
+
+   The enumeration will change:
+
+   .. code-block:: text
+
+      0000:00:00.0 PCI bridge: Texas Instruments Device b012
+      0000:01:00.0 RAM memory: Texas Instruments Device b010 (rev dc)
+
+6. Copy ``tispl.bin`` to the new BAR address (use ``lspci -vv`` to find):
+
+   .. prompt:: bash
+
+      sudo ./pcie_boot_copy j784s4 0x4000400000 tispl.bin
+
+7. After ``tispl.bin`` is processed, the PCIe link will go down again. Remove
+   and rescan the PCIe device:
+
+   .. prompt:: bash
+
+      echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/remove
+      echo 1 > /sys/bus/pci/devices/0000\:00\:00.0/rescan
+
+8. Copy ``u-boot.img``:
+
+   .. prompt:: bash
+
+      sudo ./pcie_boot_copy j784s4 0x4000400000 u-boot.img
+
+9. After ``u-boot.img`` is successfully loaded, the boot process is complete
+   and endpoint should boot till U-BOOT prompt.
+
+.. note::
+
+   During the boot process, "PCIe LINK DOWN" messages might appear in kernel
+   logs. This is expected as the endpoint resets and re-initializes the PCIe
+   link after processing each boot stage.
+
+Sample Host Program
+^^^^^^^^^^^^^^^^^^^
+
+The following C program can be used on the root complex to copy boot images
+to the J784S4 endpoint:
+
+.. code-block:: c
+
+   #include <stdio.h>
+   #include <stdlib.h>
+   #include <fcntl.h>
+   #include <sys/mman.h>
+   #include <unistd.h>
+   #include <string.h>
+
+   #define MAP_SIZE 0x10000000
+
+   int main(int argc, char *argv[])
+   {
+      char *bootfilename = NULL;
+      char *platform = NULL;
+      off_t bar1_address = 0;
+      int fd;
+      void *map_base;
+      int i = 0;
+      unsigned char *check;
+      int read_result;
+      long lSize;
+      int i;
+      FILE * fptr;
+      off_t load_addr, load_addr_offset, start_addr_offset;
+      unsigned int magic_word = 0;
+      int use_magic_word = 0;
+
+      if (argc != 4) {
+         printf("Usage: %s <platform> <bar_address> <binary_file>\n", argv[0]);
+         printf("  platform: am64x or j784s4\n");
+         return 0;
+      }
+
+      platform = argv[1];
+      bar1_address = strtoul(argv[2], NULL, 16);
+      bootfilename = argv[3];
+
+      printf("platform: %s\n", platform);
+      printf("bootfilename: %s\n", bootfilename);
+      printf("bar1_address: 0x%lx\n", bar1_address);
+
+      if(!strcmp(bootfilename,"tiboot3.bin"))
+      {
+         if(!strcmp(platform, "j784s4"))
+         {
+            load_addr = 0x41C00000;
+            load_addr_offset = 0x00;
+            start_addr_offset = 0xf3fe0;
+            magic_word = 0xB17CEAD9;
+            use_magic_word = 1;
+         }
+         else
+         {
+            printf("Unsupported platform: %s\n", platform);
+            return 0;
+         }
+      }
+      else
+      {
+         load_addr = 0x0;
+         load_addr_offset = 0x0;
+         start_addr_offset = MAP_SIZE - 0x4;
+      }
+
+      printf("load_addr: 0x%lx\n", load_addr);
+      printf("load_addr_offset: 0x%lx\n", load_addr_offset);
+      printf("start_addr_offset: 0x%lx\n", start_addr_offset);
+      if (use_magic_word)
+         printf("magic_word: 0x%x\n", magic_word);
+
+      printf("try to open /dev/mem.\n");
+      fd = open("/dev/mem", O_RDWR | O_SYNC);
+      if(fd == -1)
+      {
+         printf("failed to open /dev/mem.\n");
+         return -1;
+      }
+
+      map_base = mmap(0, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, bar1_address);
+      if(map_base == (void *)-1)
+      {
+         printf("can't mmap.\n");
+         return -1;
+      }
+      printf("mmap done\n");
+
+      fptr = fopen(bootfilename, "rb");
+      if (fptr == NULL) {
+         printf("can't read bootfile.\n");
+         return -1;
+      }
+
+      fseek(fptr, 0, SEEK_END);
+      lSize = ftell(fptr);
+      rewind(fptr);
+
+      printf("bootfile size = 0x%lx\n", lSize);
+
+      check = (unsigned char *)malloc(sizeof(char) * lSize);
+      if(check == NULL)
+      {
+         printf("malloc failed\n");
+         return -1;
+      }
+
+      read_result = fread(check, 1, lSize, fptr);
+      if(read_result != lSize)
+      {
+         printf("fread failed\n");
+         return -1;
+      }
+
+      for(i = 0; i < lSize; i++)
+      {
+         *((char *)(map_base) + load_addr_offset + i) = check[i];
+      }
+      printf("Image copy done.\n");
+
+      sleep(1);
+
+      *(unsigned int *)(map_base + start_addr_offset) = (unsigned int)(load_addr_offset + load_addr);
+
+      // Write magic word for J784S4 at R5 stage
+      if(use_magic_word)
+      {
+         *(unsigned int *)(map_base + start_addr_offset + 4) = magic_word;
+         printf("Magic word written.\n");
+      }
+
+      return 0;
+   }
+
+This program copies the boot image to the PCIe endpoint's memory region and
+writes the necessary control words to signal image transfer completion.
+
 Debugging U-Boot
 ----------------
 
-- 
2.34.1

