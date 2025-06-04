Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564EFC5B549
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 12:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7584A828BC;
	Wed,  4 Jun 2025 14:16:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ub2TTYW5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FF09803DF; Wed,  4 Jun 2025 14:16:47 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::717])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13F3D803DF
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 14:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufi7tEEZfxpMeWllAAfBjad/p76ZkSmAjQ8/efvgHADtGT5L247zxUA47lqUndBQfJAmJ1cpkR1D0mePj0cuSiCxbxYRfVKwZvv16m1FspDR+k59ypTn4q2Uc/uqXIttnlyXZ0Km8vWtb0wym5yesAiZQWEYQVAEEH0gZLwYB4OajXiiA+h9iJtwEDsZO62DHCK1E320XjU80cwpPQUaSHyqqZjSpTPZpwKO8G1qa3RHnLhKUMoKUlHKeRpOydPUe4gd9lwlGqvyir74xyJ5eo7bvQlfY9SVlDQ/Ps5gmb2+fT+ll+hjStHnDjZZ+7aN1tB1aBmyV1dKNftg3uFi1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmgaSRaG0X03HTH8zLUSxGXeqRO0BHN71E5OvlVWM/M=;
 b=kzmTCGScNb1rs2HEZyXHbS2I1+iHVsZcCITZYufzZcl0OCoPtEXTE++W2AErYr9qI9uKctRsaac++Z9/PkdLCce4XOI1V08j9kY1CyTuBygW8rjFB2W4d39JYNEF22sg3zXXBIPy+wRDDrn5mLYNjukJs45UigDKZ8j+xcA3KRECLg0eJ8qge0KF0WiXLGJly6m0LHHASx9CpvqD6vecS9ArsqFDb2WySb1hZdbE3IMEB3mis9wBF6RbzkC+sR32iHvYNs/HKUZd45rTsR3aGx+ZpogxhE06E+3296C8KJVYxfJsOnhZ3XYE34whYouI0e4tRozMuJT25PU8dgWrFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=chromium.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmgaSRaG0X03HTH8zLUSxGXeqRO0BHN71E5OvlVWM/M=;
 b=ub2TTYW5T9ITH/CPGupHl68zLwZlDLOhZB7xogNUM0lBN64+aDBL7AalKNVNMjiy17gEvHCsDsxewmpAOcq7XYPceGVztF2MpZQ/yUUqRxdDKj0bpXVsX9a6rtIadhHnbfDW5gvxM1xjoVf/FFS+xivO2qm6pD25730a6Pvys5BTy5eZsd5eKe3ruaqATXF2qTlUvd6yigoyJdIvskTddxOzNyn7bJna1+II87cnfB4Avm+F5IsttmozLw3uImlfFh6iGF+2nNe3ExpI9zs5T+SWAg3B8xdbUHl1Bt6ekubQ82ZvGI+v11egNwaiQ9OgO18GuNMn2jZseyzZiRSIXA==
Received: from PA7P264CA0182.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:376::16)
 by PAXP195MB1534.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:277::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 12:16:41 +0000
Received: from DB5PEPF00014B93.eurprd02.prod.outlook.com
 (2603:10a6:102:376:cafe::ed) by PA7P264CA0182.outlook.office365.com
 (2603:10a6:102:376::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Wed,
 4 Jun 2025 12:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B93.mail.protection.outlook.com (10.167.8.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 12:16:41 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 4 Jun
 2025 14:16:39 +0200
Received: from lws-schwan.phytec.de (172.25.32.87) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 4 Jun
 2025 14:16:39 +0200
From: Martin Schwan <m.schwan@phytec.de>
Date: Wed, 4 Jun 2025 14:15:30 +0200
Subject: [PATCH v3 2/2] doc: Add description for bootmeth rauc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250604-wip-bootmeth-rauc-v3-2-f9fad913c57e@phytec.de>
References: <20250604-wip-bootmeth-rauc-v3-0-f9fad913c57e@phytec.de>
In-Reply-To: <20250604-wip-bootmeth-rauc-v3-0-f9fad913c57e@phytec.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, Wadim Egorov <w.egorov@phytec.de>, Martin Schwan
 <m.schwan@phytec.de>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.25.32.87]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B93:EE_|PAXP195MB1534:EE_
X-MS-Office365-Filtering-Correlation-Id: a8aaed84-ae95-463e-2859-08dda361aa17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmgrT0RTQTNaRGFibndkaHpOOVc2eXNnMnFGTnMrbmxHU0pkelFPWkFCNnVv?=
 =?utf-8?B?KzQvUE1zMStQYjE5TXA3dFJQQnhWMitFSEpIR3gwUFl2QWx6aEJZVGlJbVZN?=
 =?utf-8?B?ZmVyZW5OVWRvSW9yWjNpOW9LOENtMFJ6bUYxMzU5SGFvOWNraFhTMFE2K0VX?=
 =?utf-8?B?dTdmSDBVTWVQYXlxWnM0YW1qbThCM0kvcnJYWVUzcFlVQXRCZjhBNzdWOWRI?=
 =?utf-8?B?WUxQbTlYZjYwSnJtOU1LVkVyTlRqcmg5RXJTR0FzRmZ1Uzdja0RwN01DeEpp?=
 =?utf-8?B?c0xYdVJia3BldUFPbzByMWxqV0p0akhsbHRtWHl3MEpPVWZRVGZOd0RVUlNh?=
 =?utf-8?B?MUxZR3ZhOGZMaEw4d2ZUY1hlb0RZbFJISUlWWFVXUzZqdGZKWkhZSkpmUkFm?=
 =?utf-8?B?VWxpZE0rMmExQlJncFJWQlJWRFFES09PUjh2OVlmWlNDT0VLNThyQmsxM2pq?=
 =?utf-8?B?Wm5GRDE2aTBBeTN3K3RNR1hIMXpYMm4xOE14OUtLOGVvd2xKMDNsbytSM0d6?=
 =?utf-8?B?VDFLRDVYS1dSNWxxeUo2RlVhY08zRlg1WVZ5VC9CVU9zdkVFeXA0Q0NHSE9M?=
 =?utf-8?B?ZldvcHhYcnhMc2ZSaUJnKzVsWVZVSG1Dc3U2YzdoMUJFNlorZmpVMnp4UjFz?=
 =?utf-8?B?ajVZS1BRUytFeW1makd1QmRBZGhKZGw2ZVYyd0xLdEx5cnh6bWd5dWZxZjY4?=
 =?utf-8?B?SGR6a1p6MW85N2dWNTFUaUp1TWFsZWhBTXVSU3lQd3IreFhBNzIvWm1vdkx3?=
 =?utf-8?B?bTZzWGNYdUVWY0R3RlplMmhvd29XdDdLWUZRVWkwU3VaZ041TXlXOVNsMlRI?=
 =?utf-8?B?OHF6OHQrZk40VThLNmU0QTBrbkxFMTgyMUk4QisxQ21ob2lkK3FydkhQamZB?=
 =?utf-8?B?K1o3dWluM1U1NmNPVU5VNGMvRU56a1pJNU1LR3Baajh2VmRuWHRHa3Y1UUZZ?=
 =?utf-8?B?Z0VKQ1hTa1MvZG55cHordHU3YnVxVUJ2dXhaMUlnNEE4dllieHF2SVBxVEI2?=
 =?utf-8?B?T3NDbTA3SVZLaHpVL0VEbmR2QU52Q3dUYUd3TkZRRFVUaWNHUDBMV2FPZGx3?=
 =?utf-8?B?bklpcVFuTjBaUVlPVnNUa2R3RnZoUmlESmRuM24xRWpDRzlYUXpCcEIyb1ox?=
 =?utf-8?B?eW13TDhna21VZXAzVU80a0JSN0lRR082WENrTi81d1QwbFY1dUYwT1ZqdUhl?=
 =?utf-8?B?eUhsd2VRTlJSV3ZWbTRXYUZHbUtYS2RHanY2K2dSZSt4ODJzMlFsLzFNN09i?=
 =?utf-8?B?bXpvdWw5TjU5eEsrajZoYVZXUXFzWlNjeTJ5STh6ZXk3VDQvMHNUOUZyQ1Yx?=
 =?utf-8?B?TEEvcS8rNjlwWGpQV3RYc0ZKdm9pa09YSWkxbVN1b2ljL1hBdEV3QVEweEx3?=
 =?utf-8?B?aEpSV3p0Y3JqU1JleE03SXJQc2JUdXpZekFSYmRGUCtpdkIrb2Jra0U0ZjhU?=
 =?utf-8?B?VmRnTmFoZ2Q1SFAxMFVjeExaMFFKRUhaazZZYmRXR2FvNUFhMHVBWlhrUmZ0?=
 =?utf-8?B?VEd1NUF0WE0wUWR1YVZpVSsvelFuUWw3c3FLQVNuQ2JHb0ZTdHlEaTVXQzNZ?=
 =?utf-8?B?QWt1SklBVkZ3WEtHeExsQzk0bjE0aWI0SUEzRkVVU2FtSFMvaTltRnExS2U3?=
 =?utf-8?B?VFE3Q1JvY045dURPeVZreTRSVzl0N051TC9GQTZVU3VIUjhrOEl2aDBZayt0?=
 =?utf-8?B?ekEzQXV0Yy9ndDV6R0hjOHEzUkhZWEVQRmc4bWthOXBKREc2eTRtZTV3bksx?=
 =?utf-8?B?dXRQZVpEVExkTER2aUlFaGo0U1oybUR3RytydU42Q1lhQ2V4d2c2WTlKK2Fo?=
 =?utf-8?B?NUhoZ0pxVm9HaklRY3NsUHZNREdxZ3NSZloyTGs0a3lIM0ErcWpxVFNudzQ3?=
 =?utf-8?B?ditrMk5vYnpMRm12S2FFV1Q1MTdBWlRVYU4yeVdrdE9zSXdsRUIrUktNdVRV?=
 =?utf-8?B?THAzWDk1STlhM3BNTnFCN0lIM3Z1Wk5Ya3lpT1dmVk44WEVwWEt1cGZDdHRN?=
 =?utf-8?B?OUpINUxnc1ZFOXFia01WbWgyTWszS3hMZDkzL2U5azl6OGtFeitpclpxQ1Ft?=
 =?utf-8?Q?KkWcQM?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:16:41.6571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8aaed84-ae95-463e-2859-08dda361aa17
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B93.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1534
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
 doc/develop/bootstd/rauc.rst     | 56 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

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
index 9fe5630ab16c2dd62ee18f6fc98bdf6373486ab5..0a237359575579c7d6df7b4ef900bdc4204ea48d 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -443,6 +443,7 @@ Bootmeth drivers are provided for booting from various media:
    - :doc:`extlinux / syslinux <extlinux>` boot from a storage device
    - :doc:`extlinux / syslinux <extlinux>` boot from a network (PXE)
    - :doc:`sandbox <sandbox>` used only for testing
+   - :doc:`RAUC distro <rauc>`: A/B system with RAUC from MMC
    - :doc:`U-Boot scripts <script>` from disk, network or SPI flash
    - :doc:`QFW <qfw>`: QEMU firmware interface
    - :doc:`VBE </develop/vbe>`: Verified Boot for Embedded
diff --git a/doc/develop/bootstd/rauc.rst b/doc/develop/bootstd/rauc.rst
new file mode 100644
index 0000000000000000000000000000000000000000..b2661d18da46a745d4fc6eb65e45d1202f2e2a21
--- /dev/null
+++ b/doc/develop/bootstd/rauc.rst
@@ -0,0 +1,56 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+RAUC Bootmeth
+=============
+
+This bootmeth provides a way to locate and run an A/B system with RAUC as its
+update client. The booted distro must supply a script on an MMC device
+containing the final boot instructions necessary.
+
+This bootmeth assumes a symmetric A/B partition layout, with a separate boot
+partition containing the kernel image and another partition for the root
+filesystem each. The partition numbers must be specified with
+``CONFIG_BOOTMETH_RAUC_PARTITIONS``. The content must be a list of pairs, with
+the following syntax: ``1,2 3,4``, where 1 and 3 are the slots' boot partition
+and 2 and 4 the slots' root partition.
+
+Each pair of boot and rootfs partition form a "slot". The default order in which
+available slots are tried is set through ``CONFIG_BOOTMETH_RAUC_BOOT_ORDER``,
+with the left one tried first.
+
+The default number of boot tries of each slot is set by
+``CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES``.
+
+In case no valid slot can be found and/or all slots have zero tries left, the
+boot order and slot tries are reset to their default values, if
+``CONFIG_BOOTMETH_RAUC_RESET_ALL_ZERO_TRIES`` is enabled. This prevents a system
+from locking up in the bootloader and tries booting again after a specified
+number of tries.
+
+The boot script must be located in each boot partition. The bootmeth searches
+for "boot.scr.uimg" first, then "boot.scr" if not found.
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
+    partition number of the boot partition on the device (numbered from 1)
+
+distro_rootpart
+    partition number of the rootfs partition on the device (numbered from 1)
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
2.49.0

