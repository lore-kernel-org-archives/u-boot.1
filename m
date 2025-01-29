Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E2EC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 14:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67F6980A0A;
	Wed, 29 Jan 2025 15:30:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ZaawaxYS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 776928096D; Wed, 29 Jan 2025 15:25:55 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 674B0809D4
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 15:25:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4xWB/8tCtOhllk6lHrZHIRpcjoFKPfQ3xeute1k61wvOJhGhTWUFknkOKmpxkBxQZq01Irke3jgBFpYxPkQwJ3FqDwheaVYeUzU0X1E6wlAvDp7uP2koxt5e7nOK1ZNBJG119QoBtdVmPa5f09el60VeVeoaDFnDouqvq0iVumEGjD9Og4TBaIOeFdar9mqskHCXH0ylgfojmZ0t3hDJBwfqA1xPs53WRGfu1+eKO6Smw2fFsSFDoHmD/edA7AdjbDfQOBG5pL6RMmtT2TD+GBZdpt4vGoIO7hVro36g0DFb6VbyI3OZcy1BaxUywS95da0oQ9Gqa7k5AsBtKRduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBL/DCJZoOodRwQlusL1VK1Q5AVSj6q6n2XQWWOzX8Q=;
 b=k17Ep6YEYfnQOu947RqInf6WO6miczmTlYchIH8ybMxHMuO0PsRg+MkZrPhuWymwOMYOYtye46TKZe43w3c5hTaJ5JT+EPh2ECTPJbPjMEdCknB8AdM+t9wM1S9bBpnUjOJEDeoOxppWTRwWsKuedBVRKYedl3KTfZZ/lirhC1uDKIlcXe1+kQnNnBe0q/sroy4H0/6smHOrWp+IMKpPbhCtsmdlrvteBy7vrI/57B6ZO2X6tVrKe2Lk2n435Ulej3194gh3CrmmttWePR68VnyXeC+aQ/HrVUEd6q8sDQSq0MDkepm62VTCN09pidvfufKa+XaY6hAjNuC8dMIXdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBL/DCJZoOodRwQlusL1VK1Q5AVSj6q6n2XQWWOzX8Q=;
 b=ZaawaxYSmywn8O1gVBRsU7yU3QSQyYUmcdcajDvriZAjRvDb1tyUUYI4FX4ZStYdG08kvliM5bAbYIqNzIOsyzqlVjlKZCtBuFaH3Sec73mo2hZX4tZC/JAh7HSFF6c/YS/oFFFDWDz07mJHPFf+DlZMCv0GT7wFcZneAndx7gVYzfrd2niCMET2nlRYFL2gaeeDNviNk9WI3CuHRSLqNr+jefvj5bUURfwNMWOUjeAAyygawIJrqvB3IP/Za09U5MDx3wp+k64I2vdCWgNIkfcLMfrZgSczTMz2HmSULcgNvyInIPnJGJXFjLN1DAPeMWl7qFODmVymD7NgJ0DOxw==
Received: from DUZPR01CA0345.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::28) by AS2P195MB2364.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:641::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 14:25:49 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::35) by DUZPR01CA0345.outlook.office365.com
 (2603:10a6:10:4b8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Wed,
 29 Jan 2025 14:25:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028CFD.mail.protection.outlook.com (10.167.242.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 14:25:49 +0000
Received: from Diagnostix.phytec.de (172.25.0.14) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 15:25:47 +0100
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.14) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Wed, 29 Jan 2025 15:25:47 +0100
Received: from lws-schwan.phytec.de ([172.25.32.136])
 by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
 with ESMTP id 2025012915254741-49 ; Wed, 29 Jan 2025 15:25:47 +0100 
From: Martin Schwan <m.schwan@phytec.de>
Date: Wed, 29 Jan 2025 15:25:26 +0100
Subject: [PATCH 2/2] doc: Add description for bootmeth rauc
MIME-Version: 1.0
Message-ID: <20250129-wip-bootmeth-rauc-v1-2-6308e732f314@phytec.de>
References: <20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de>
In-Reply-To: <20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
X-Mailer: b4 0.14.2
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August
 17, 2016) at 29.01.2025 15:25:47,
 Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.01.2025 15:25:47, Serialize complete at 29.01.2025 15:25:47
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFD:EE_|AS2P195MB2364:EE_
X-MS-Office365-Filtering-Correlation-Id: e87aeb02-c819-4d1a-474b-08dd4070d3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGQ5TW1PY040eTc2bkd4MXJqVStvajUzdlJEcnZ0T0szSW05WVpRcEVxVTZJ?=
 =?utf-8?B?YnVqYk01WVJKTWpmRVNUR2MwcVRDbjU0YUwweWFtVXRiWFI1dWNjK1U2bzNW?=
 =?utf-8?B?eTNJUmI2VUtPNFFiQjNLd1dDaWlySHR3bTFEOC9DZVBKeGNUV0t5R0xwMkln?=
 =?utf-8?B?RE4zcHdkTTNBYzkxeWxYMzJmbXhnakhwMEhRTjFXajZ3TkhFVU41Y01LU3gy?=
 =?utf-8?B?RnNBc1ZNUjFWMDRDTlZNNVRrZkpCN1grTGhreTlqS016bkk4QXVDZjBqalNo?=
 =?utf-8?B?WEdlZkNROHlhQ01VRVFRbitCOXpjeTVkWUVzYjVKTUM2RU1pdjRTUVNiQ2gy?=
 =?utf-8?B?NHFlQU9nQ0NjSE9UODJad1IxR3FENVlnZWwrWG1GVWdSd0hWYzF2VVZZMWdT?=
 =?utf-8?B?elZWRWRXV3RwYTA0WW1WeXhTTEdyYy9JMHdzUTFuYVQ3NVJFRUlyWE1tbU43?=
 =?utf-8?B?bWcyRlRGeU5iVTZ0RXlvbkp6ZDFGa3hTNHF6L0ZCMTVvSXFCaUdRbjdhTnl1?=
 =?utf-8?B?bmRpVy9EUDhVSjVkQzdKa2hVTnV0MURLSGJLdjhOQUs2Mjl3Snd3MzNyVTNP?=
 =?utf-8?B?V1VEaG1BeTdIWnltVW1ESDlOWXNveXM4TFVaZVUwaTNUc0hobS9kT0c0YVRX?=
 =?utf-8?B?VEcvYU5DRmxDejRoUWxHZGkyQTZtQmhOTXVHYnhWMGxmWjJOUUNOYlNZcjZ5?=
 =?utf-8?B?VGk5bHRrejVCYVZLQnliaXR6bmI2OG80ZnNMS09nYjVpdGU5WWJGQk4vcE5I?=
 =?utf-8?B?YTB3MnFHMkJkNUI0aXhFc3pxVmY2Zko2cm0vSnRwd1Y2Y3ZSS1dnOVhVQ1NW?=
 =?utf-8?B?RytaOE85ajlabWZvVWl1ei96R3gwLzRIRFRuNXR5N0I0b2JERTFTTERnNkZt?=
 =?utf-8?B?U1JEdWtuczhEVStrQlFDZDJ6Q2lhbjVxUmZUbXZmc3FuOUhaZ2NDVjdLSlEw?=
 =?utf-8?B?WVZRaFU2a1o0Zy8zT0t3NFZSU25DNzFmeHlVWHVJQXNneXRaaFV0K3htaGln?=
 =?utf-8?B?dW9iZldEMlhlUFFVSnp3YUgrZnVmL1ZoV3FseXRBVEFLYm9KMi9kT0pRdmpm?=
 =?utf-8?B?N3dQMzFWU1hhd3VYY29jKzNydlUyOWxHdWFlNjdOMHE1NFBaY1JGUkh5UC9h?=
 =?utf-8?B?M1p6K3B5bG1kQ2xsWjZDVDFHSnpiKzZ6M3EyRDBNV3dPVkFtVUMxQ1UwSVpE?=
 =?utf-8?B?N25EcmdHNW9ZaDRnV0dybHVFUFBzTDB3cEE2Slk4bVU5b0JXcUdFdi9RMWd1?=
 =?utf-8?B?c3NYR1VROGNJT2RmOHc3SFo2N3NOV00zUEZsRXZFYUxlbE5vL2RwYWlWQm1v?=
 =?utf-8?B?TFhvY1NsbHl2Ky9qSjduUlNtRlo3dGxCenpNWldQUXM5OTN6bXR1c3NEc1Mx?=
 =?utf-8?B?S1ZGZ1dzck9IVUZ5RE12bXFjbFdzbjFVdCt4N3ErQTNHTXhRcGJUWDdja2lR?=
 =?utf-8?B?ektrTUN6TTZmeWRoU3V4dXVmb0pva0c3V3JHTGthSkk5c1pxa3NuLzVNTzQ0?=
 =?utf-8?B?QzJrZkdvMklIbUY3MlpTY1RBN3FRUDFVUUxPeXpaNS9EaGxSVE5jNGlQNFlT?=
 =?utf-8?B?aktweGtmZ205NVliT1l3aFRnbjN4dkhOQ01PeVZyTThWVkplQ29DUjBjYUlI?=
 =?utf-8?B?M0lZZjFsYjgxTU1YWCtrV0t4T0c1NDJub29TZE1oai8yT1Bkekl4V1dTRkRy?=
 =?utf-8?B?ZnlscGlZM1g1T3lxNExCWVRVVDd0VGUvWGJYMDVNQkx5SVd3ZkJpeExYekNJ?=
 =?utf-8?B?aHhKdW10TVN0TE9sNzR5MkhBRTZGOXFpcXRkVjVVQjdndVozMkFsSlp2dzla?=
 =?utf-8?B?K2lVeHcrTHBlaXlNS01IVHJrUGx0YVN4WHROR3A3akVRU2svRVhnc1J6bHQ5?=
 =?utf-8?B?YnhwcWxIeitJMU90MUV3SnNYVXVud21OdHpaM3hXMTM3SERER29kd1pCVWxS?=
 =?utf-8?B?d3IwOEJWbVJ1VmZoZ09pd0tOTm1MZTAyNzhQNHRFVFlrMFRXcVdWS2ZQWG1l?=
 =?utf-8?Q?TipxOjJf9+45+zMd8WZAAEH39CZWOw=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 14:25:49.2894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e87aeb02-c819-4d1a-474b-08dd4070d3fc
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P195MB2364
X-Mailman-Approved-At: Wed, 29 Jan 2025 15:30:27 +0100
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

Add documentation for the bootmeth "rauc", which boots an A/B system
with RAUC from MMC.

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
---
 doc/develop/bootstd/index.rst    |  1 +
 doc/develop/bootstd/overview.rst |  1 +
 doc/develop/bootstd/rauc.rst     | 55 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
index 4c4e26ccdb707e55f88660395f23d7e7cda6b78d..ec74fc2fb9d7cccc48f3d16e781537190b5b6ced 100644
--- a/doc/develop/bootstd/index.rst
+++ b/doc/develop/bootstd/index.rst
@@ -12,5 +12,6 @@ Standard Boot
    qfw
    android
    cros
+   rauc
    script
    sandbox
diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index e3ce97cc4f5fad8fc6a5ce3f5ea76c7b93697b32..c046889b7fb25653969a65cd3c7b80589b833466 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -442,6 +442,7 @@ Bootmeth drivers are provided for booting from various media:
    - :doc:`extlinux / syslinux <extlinux>` boot from a storage device
    - :doc:`extlinux / syslinux <extlinux>` boot from a network (PXE)
    - :doc:`sandbox <sandbox>` used only for testing
+   - :doc:`RAUC distro <rauc>`: A/B system with RAUC from MMC
    - :doc:`U-Boot scripts <script>` from disk, network or SPI flash
    - :doc:`QFW <qfw>`: QEMU firmware interface
    - :doc:`VBE </develop/vbe>`: Verified Boot for Embedded
diff --git a/doc/develop/bootstd/rauc.rst b/doc/develop/bootstd/rauc.rst
new file mode 100644
index 0000000000000000000000000000000000000000..74ce24e8570d5cbcba7ec2066c20ef4fb5481455
--- /dev/null
+++ b/doc/develop/bootstd/rauc.rst
@@ -0,0 +1,55 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+RAUC Bootmeth
+=============
+
+This bootmeth provides a way to locate and run a A/B system with RAUC as its
+update client. The booted distro must supply a script on an MMC device
+containing the final boot instructions necessary.
+
+The boot script must be located in the partition provided by the slot
+configuration in the environment variable ``rauc_slots``. The bootmeth searches
+for "boot.scr.uimg" first, then "boot.scr" if not found.
+
+In addition, the RAUC binary and system configuration file must be present in
+the specified root filesystem.
+
+The settings for configuring the layout and partitions are done through the
+following variables:
+
+rauc_slots
+    If ``BOOT_ORDER`` is not set, this variable is used to set the default boot
+    order. It also specifies the order in which partition indexes are specified
+    in ``rauc_partitions``.
+
+rauc_partitions
+    This variable configures the boot and root partitions for each slot. The
+    content must be a list of pairs, with the following syntax: ``1,2 3,4``,
+    where 1 and 3 are the slots' boot partition and 2 and 4 the slots' root
+    partition.
+
+rauc_slot_default_tries
+    If slots have no variable ``BOOT_*_LEFT`` set, they are set with the value
+    of this variable.
+
+When the bootflow is booted, the bootmeth sets these environment variables:
+
+devtype
+    device type (e.g. "mmc")
+
+devnum
+    device number, corresponding to the device 'sequence' number
+    ``dev_seq(dev)``
+
+distro_bootpart
+    partition number on the device (numbered from 1)
+
+raucargs
+    kernel command line arguments needed for RAUC to detect the currently booted
+    slot
+
+The script file must be a FIT or a legacy uImage. It is loaded into memory and
+executed.
+
+The compatible string "u-boot,distro-rauc" is used for the driver. It is present
+if ``CONFIG_BOOTMETH_RAUC`` is enabled.

-- 
2.48.1

