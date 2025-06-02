Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F102DC5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 11:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2AE982A46;
	Mon,  2 Jun 2025 13:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="tX1/h4H4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E0FE80050; Mon,  2 Jun 2025 13:32:44 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9015882A8B
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 13:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZoxP4SGziuWiWrOwPRGyf8Alm7FKlQknBCbI42esf5Fk9hQgrw/gMTaEWrNjMs1ckEt9UFnPQ0/n2v6DpeGW5xICWJGrsJ8ZSunyCep4b31jf5iWXfQ4u5oIR5ZN3UgYUNb+EKDBQT8JkFEFuEvEepO9j/hB4hY0EwAjqz7v3rA+XGen10lMxiravn+XirwypICaCNzAoXij7be+IfTbZFxc2P4u0pgxQ/td4UaQesCqKRHI2ddhQn/PdgAUFoWC3uatWrrxWGmPBoB5fKVIPy+dbwT6+xiTOB2akndUfwNDzRn+uB1AoQjjFKtQAehlvhb74TmaMpO/alVfqSe+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmgaSRaG0X03HTH8zLUSxGXeqRO0BHN71E5OvlVWM/M=;
 b=PppxFJROYMgluibOTIkDSR5fFgTh9w01v637HqvLqFr70IYelaHXG7xGYLRLcVNMHvTGWobT3jid8nKhrPieNpLMa02MWUpSgUwVYMD7idjbDyMNIkFbutWsxCtgbw+fDBiRu8v20qUqdbQKPtiu2lm8jQqSq6rRA5cURpq+Dv1kaG4Lib66A0274hqNCSQXrdlITpE3c1Urks6nAOG7eP4XMJmK62ldsPTvx74hZGmUmU43/YgyDl+gWThdo23UJ4kCit6a3miMZQFOVbY4IIBuNVJluWyzz9YbTCRimTO7Z+FroWj8a/rsCedLmGj4nqjoTI9pW/zNyb6A4rVYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmgaSRaG0X03HTH8zLUSxGXeqRO0BHN71E5OvlVWM/M=;
 b=tX1/h4H4HxVCsXcaHVHv3K6Wuo1o0CHKV0Ny9OrJDLgt6ItxrtrWAlyqL9AlSxVmmVffwhe4NEXkW2zaZ+GoHbtrezLz90JQAb+0SSNHws+jNCV2130zfus0tJUWWkjBomupRNUK1QlcA/1x8EGKqXgiA1u33igcwopxh0zzvnYzj+g8r+4xYuqOS7UEcNyUV98xXS2o/1xdrK7YWWlJOXmKNuevn4D7e3ujj3LSgnBSandzk9QCr7c9c0hUd1perreBnBL+5CB2MeAA0VHdbHNW+MUWetSqtAQwjIqlkrnogSxl4qWcW7wjcRuQ6vLMwvQ6115UCauK4OUCeVBxiA==
Received: from PR1P264CA0121.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cd::15)
 by PR3P195MB0816.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Mon, 2 Jun
 2025 11:32:07 +0000
Received: from AM1PEPF000252E0.eurprd07.prod.outlook.com
 (2603:10a6:102:2cd:cafe::29) by PR1P264CA0121.outlook.office365.com
 (2603:10a6:102:2cd::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.21 via Frontend Transport; Mon,
 2 Jun 2025 11:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM1PEPF000252E0.mail.protection.outlook.com (10.167.16.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Mon, 2 Jun 2025 11:32:07 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 2 Jun
 2025 13:32:06 +0200
Received: from lws-schwan.phytec.de (172.25.32.67) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 2 Jun
 2025 13:32:05 +0200
From: Martin Schwan <m.schwan@phytec.de>
Date: Mon, 2 Jun 2025 13:31:35 +0200
Subject: [PATCH v2 2/2] doc: Add description for bootmeth rauc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250602-wip-bootmeth-rauc-v2-2-9d2384131486@phytec.de>
References: <20250602-wip-bootmeth-rauc-v2-0-9d2384131486@phytec.de>
In-Reply-To: <20250602-wip-bootmeth-rauc-v2-0-9d2384131486@phytec.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, Martin Schwan <m.schwan@phytec.de>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.25.32.67]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252E0:EE_|PR3P195MB0816:EE_
X-MS-Office365-Filtering-Correlation-Id: 95cfebf5-8c80-45ad-a50f-08dda1c91b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlZybFFJcC94ZFl6KzdrMU8yNW9McHFRcmNKbm5RV1FJZVlmeHgwWkVuS2ZP?=
 =?utf-8?B?a1BiTTRRRVVSTDlWek56aHZYUlphZXd1VVdYWTRXdTU3OWdKVTRwTEJtZWpt?=
 =?utf-8?B?ajhNdXpidmZwSHEwc1VFMVROUFNYNktWaWVndlBsRFFLRUphRktFNEw4T1dC?=
 =?utf-8?B?YWI0SnN4YUxBZHRFMG5EcjhmV3NOUkhESUJnMDRBenRGUE85TVBUcm1MNkNN?=
 =?utf-8?B?QzZuR3RWZVdiZ3ZlT0dhQk9iaG02YU9rUWJJUWlCVjB3YXNQUEp0aTU0dWRC?=
 =?utf-8?B?NXdNYVljaXJYTTloSmx3dHg1cVlMT3kvU0JMcW5JWWJPWkRxazJLb0hUY3JC?=
 =?utf-8?B?YTkyTHNtdFM1RDlCUEZCV2lsNVEwc2pGcld5VEQySlJ0aCtMUlVqRDVlYU8x?=
 =?utf-8?B?RVRFVlk1dGtYNFVxTDhBVjZTMXFEbEt1bThWekhZcnlCVXhlS2VVbURKbXRM?=
 =?utf-8?B?QURkYm9tVVg0S2d4ZWt5QWJTRFByY0JseEJVVzBKeUV0MTE0aEQwd1RWcnZy?=
 =?utf-8?B?a3RjVEZNdU5jVXBnYVN0RUh5NlZ6end1cm9lWHF1TlJ0b2x2czFSbEN4a0ZO?=
 =?utf-8?B?OExEdzJaMHp0NHZKU1pFOUd1OGV2cVM4NlFacWZvajhFTTNPdTRkRmlkTVV6?=
 =?utf-8?B?d1FlUFVYNXR5NlAwMGpiYkk1VlRNSy85U1dJVGFwUVZFcU9WYzMrNFlNaDNC?=
 =?utf-8?B?akxzN21sbkZZRDd6MTFwS3pCUE1Zd2JnYTJ2TmhJak4xU0Y2anJHdnJWR29r?=
 =?utf-8?B?aW54Y2ExQ2N3bWJDTVFtcm9DeUNYc2UxSHlRb3B4b29TMFd4d2s5QkVTVlZC?=
 =?utf-8?B?WnFJZHMvM1JHbjUxdVRaMU5XanVHMnJnZmZya3FhNnpucGJZNEVkR2tweWhK?=
 =?utf-8?B?b3pWL2JpRTg5TG5sY0I5SGtTMFZwUnVjTmUyMCszTVUyeXpnYU40alRFVUhw?=
 =?utf-8?B?ZFUxWU84U2o1Z0k5UWlsZ2lqU2NyVW52SHBtRXBRTFYyd3hDeThlRHZ1WGE1?=
 =?utf-8?B?R0UzQ2N0UWh5N1VPT3Fvb3N0eVQ2VERWMlBVV2J5Z3pqUHpIM3YyWmV3c1JO?=
 =?utf-8?B?dTdLTWxUbmR4djFRNWJGQW9NbWFLVHpPMXdFMEdnd09pQXVXd0FYcnpwcWRF?=
 =?utf-8?B?cHh0NnVvcHRIcEVJeDlSV2JIcXRubHhpU3JCZzJhVk9XMGpxODJFZW1FT0hi?=
 =?utf-8?B?dExEU2oxK2tqeEJNQXFaVDVRb3ozaG5rSEgvUmFZd25aNExYN2FMZGIwSmty?=
 =?utf-8?B?RDBaTmtYeUFIR3RVWkdSa0tmRUpzVzNlamdFQm52Z20rVmo2czVkaUFDZmtk?=
 =?utf-8?B?dGFSVllwYWloSk9YMVkwS3pjNHRSanR0NEk5QUxrRlNRdFU0Yzk4cUJIMy90?=
 =?utf-8?B?OE0vRms0b2xFREkvYjZudFN4SkQzblJFS1Jwa2ZDMkVWSEQwRklvQ045ei9U?=
 =?utf-8?B?cE8vakl5ZXpjN2tSSzkyVWpOR1Q4WFQ4MVB6YlRQNGFUa0xzWlJWcWtyUmk5?=
 =?utf-8?B?dlo2MHppUDlBUW84cnZJZE5TZDVXcmJraXNieG1DSHhYU3BvSGNSYWhCbHRX?=
 =?utf-8?B?L1RPeTBGNjhpL3NrSXVGMERlYzhIUTZZK2k5Y1FpdmN4WGR2Y0JkQThzczRk?=
 =?utf-8?B?TlEyRS9FSFdBMm4rYUlqaXdrdEtQZUE1eTdaQjZtZXFDK3M0azVmNHhKa2dp?=
 =?utf-8?B?eXVKWWo4KzRmYVJVcWJZMVdSZmc5QWp2R0ZsRW0xWk9PQjhLMElacTF4MHh1?=
 =?utf-8?B?cmJXU3lVZ3Yyb3lnZFk1WXh4dG9iQ0R6UWlwblFlSFJUS3FIMWdEckNiQ01U?=
 =?utf-8?B?dHVPN1lObjJ3Mlk4RFBDSmNuTVhnTG1zM3lFaGhkYWl1c0NnVDZuQmkzTU5L?=
 =?utf-8?B?eStlRHg1UXVqVTJlY0Q0U0plVDgrTHI4VTg0M080QWo4YU1DVGJFeCsrNDNG?=
 =?utf-8?B?cjBRRUVScHU1M2loNzVtOWNzbjVDUU53bjczMFV1UUNOakhMYlROSkxoSWpl?=
 =?utf-8?B?L1pZZWdJZ0Fudnc2SjlLQzdLRDFzbDcwaDkwRm5OOTVZOGVnbmRkdmU2MGZq?=
 =?utf-8?Q?8BIIxn?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 11:32:07.3233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cfebf5-8c80-45ad-a50f-08dda1c91b38
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252E0.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0816
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

