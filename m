Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0086CCD183
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 07:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4229183966;
	Thu,  9 Oct 2025 09:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="vYZzzEK2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0520839A9; Thu,  9 Oct 2025 09:06:43 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7465383948
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 09:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKicJM+Ca/fzdbSuS+kYXPCe+MkHXl81WXHxfVoCcNH/dUDxXu5sIId6k9kVkKjjT1/N9z0eXz85HPEuPvWuyouIouBxeVr/Ug55Tl/rRRcgu5PGVOSc+X6mGDJ6X5g47BtbUAw6dcchDxvhFYJboLWm6H1bRRanSspfdFiseMin3U0t4tAiRGWDfydTbGjlDVTZgYCDRHbjLatVy/0adlW5nVj+4+DMKadhZaE16u1V6IxcQ9LaR/o0iQe2tNTAe/2uIdLHXBcV05bWDVRYQdz8I1MJ6z3tNpQ9t9100I6CX1IWIn7buVzmJWlo35c1Ol0hWHNWYhbE3JIvnC8uDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6RIx/gkHTaCEp/YnUKs5Pxj4uDwydjKz0M4jfsbZVw=;
 b=qVNV8I2AuV22t8a0VxgRKW9orykciheLx6dEKOeYBxXYNVsefz8YxvzfSObYpnPAs9DKU5+sXEsk+acBnILIL7vSWL5P8FqChI4dA0YIpes1osBJ69uiwh4WEBILECH1UOtvicb3azBra99BGFLcrp7a/c/N41D6T3z1h4IO5F2YbuI+Wd7gHqsZuEm3D9g/2DZBpepnRJmjjmIYZ3Kv5q6NKhsE8+5ybcb6zd0K25rwe3S8+77pW9vJH6027anRzPkC1SOOGSjpx/IwqqiYU+nPZdXqM5lAwiwXeQXeqt34nylfUQTxtGGJP0fW17JIRFOwAD0BodQkaihmND/1wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6RIx/gkHTaCEp/YnUKs5Pxj4uDwydjKz0M4jfsbZVw=;
 b=vYZzzEK2nJGkMn63hqrJm798MWzpeDzmjidWFytXoQcfCuTiz6ZpF8q3xJx1BqUuMhgxShbt8p1TQZy+BEO9KyZvaSKFY1qXGMeeTEFHCPirlkc7EoMmQSSo+ydhhqrOuARnIhG9C84AzW+31PYGMVrVrUAN6qe27HLiE3oGpLHvbYBJmJEGMFYRT3hp9W96OQuPXgZgn2QRVgo9tiIBHM/Sn/M2kKx9IZNuvXOK8XpXwmLdHxoyAeAuGByeyvn/1clrmX1il1Mjv6/1zjEl7ZQ4sHgpQS/QIyukIjU4T20e61FWb03hDPV5FdznwyKaiFlL7ocTV0QYcZuqli41jQ==
Received: from DUZPR01CA0115.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::27) by GV1P195MB2529.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:1a5::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 07:06:36 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:4bc:cafe::fb) by DUZPR01CA0115.outlook.office365.com
 (2603:10a6:10:4bc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Thu, 9
 Oct 2025 07:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 07:06:35 +0000
Received: from lws-schwan.phytec.de (172.25.32.51) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 09:06:34 +0200
From: Martin Schwan <m.schwan@phytec.de>
Date: Thu, 9 Oct 2025 09:06:12 +0200
Subject: [PATCH v2] test: boot: Add test for bootmeth_rauc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251009-wip-bootmeth-rauc-tests-v2-1-08fbd3738e0a@phytec.de>
X-B4-Tracking: v=1; b=H4sIAONe52gC/3WNQQ6CMBBFr0Jm7RhaKBBX3MOwKO1oZyElbUUJ4
 e5WEpcu30v++xtECkwRLsUGgRaO7KcM8lSAcXq6E7LNDLKUSpRlgy+ecfQ+PSg5DPppMFFMEXV
 HVlka27prIK/nQDd+H+XrkNlxTD6sx9EivvbX7P42F4ECK6ul0G0llKz72a2JzNkSDPu+fwC5v
 fRKvgAAAA==
X-Change-ID: 20251006-wip-bootmeth-rauc-tests-a8ed5deb7486
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, "Andreas
 Pretzsch" <apr@cn-eng.de>, <upstream@lists.phytec.de>
X-Mailer: b4 0.14.3
X-Originating-IP: [172.25.32.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFE:EE_|GV1P195MB2529:EE_
X-MS-Office365-Filtering-Correlation-Id: 882a8133-e6af-4ac5-3899-08de07026258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGQ4YnJFUDRSbTVhOW9USURXWmRBeDlOWCtYK2NkS1N4cmR3WVV2ajluZU8v?=
 =?utf-8?B?NHJ4K2FKa05IT3pCWFJsb1F3elNjWWhKdkFLU0NqeFNsMGwvai83NGlHZUdx?=
 =?utf-8?B?aDNyajUyTWZXUm1SRGJPOXlNNVhXWjRvUDlaZ3QraFhVejhOTDc3YlNoU0E5?=
 =?utf-8?B?V3pDbTgvZzBwa3F2VFJxa1dESEMwcFZlejE2bXhGbUZHVjBaOHNXWHY5cTFB?=
 =?utf-8?B?OUFnd2FHS1JXRFljazhnMjB6VXg4dTFTN3FaYk1tU0xZS2pRdkdqNVlSUldV?=
 =?utf-8?B?Sk9ieXR0OFVRRmVOdkdrQmU3M05xWHY1SU4zTHUvZUJkeE9oNURmS1R3ajBG?=
 =?utf-8?B?MDNRRlFxNWxNTUxtZ3U0dDV1bHFNR3NLaVlRdUlRNHRNWGlEVFJ3amQybkpn?=
 =?utf-8?B?Wm5YU3g1VFFuczIvaGh4MTVtcDV5dWtXMXIwTE9nckFkMWw0dkNaTUpseUhM?=
 =?utf-8?B?L1FQUlI5czJxNTh3czdVVjN5L2lpckN1NFFGTTczbnlRVCt6MmFzMS8yUTRz?=
 =?utf-8?B?Tm9xaTVnTVZtbmdCZ09YN09aK1d5aGtrc3lQWUpOL2hWZm5QYll3bUZQY2hX?=
 =?utf-8?B?T0ZZaitSbllKZ0ZzZ3pobXRVdzkxSnM4ZUtWampIRnppWlFkSVd5UnMxL2E3?=
 =?utf-8?B?dmMyODJQR3kzdHNVd0pIRjVTS0ljbStSdGdWM2VqdjRXWm5ReEdBUDhaZEhU?=
 =?utf-8?B?Wm5hL3RWOTdGMnBhK1lmaWdzQzgrZGFvV1AvNWRUallESW1jM2J5RUtodzJa?=
 =?utf-8?B?VHZuMkp3d0tLYWY0NXpubUZYRVZNc1Nqc0N0QlR3bEJEaHVpZWQ5Y2w4cXVk?=
 =?utf-8?B?c255T096TWxBMnR0WmxTNk1ra0srTnhTdW1GMlRvZEhLQitIWlkzRVB4eGlG?=
 =?utf-8?B?d2ZHZjNiMDhiRFNXd1lPaDYvS0czZzY1bWFFOVVHYjR2ck13QUp0d1lWOW0x?=
 =?utf-8?B?cGxueWlVcmhBbWFVK2VKc3Q0R3F0aXIzMmpMYmFGTGxjdjFINkg5M0FHUEln?=
 =?utf-8?B?MzRVQ3dYUGhtNmlIeGcrSnFqSUk4S29ydTVBOGExV0JoVHBTeXNsQVQ0aGdG?=
 =?utf-8?B?Z0JJZ2RwVHJuTHE3Ty9ndHNhbXBRcHd1NldZdUdqYmp1UEJYWnhnbzZkZDI5?=
 =?utf-8?B?REhuUCtjNGVRQ0tJRitFMmJCVkdiWjlYeDJSeTM5a0laQWR3RWtvTXlTVnNH?=
 =?utf-8?B?eGdBMTJVdENUV09SdzdLR0JXZGJnOGFZeWR4SG1qb1ZhK0lHbFI3VW05Q0hi?=
 =?utf-8?B?dUR3Y25hbVdBcDJLZmplWUdaU0E1U3UvM0dmU29sdkpPbGhRSzM2eHVka2lG?=
 =?utf-8?B?dDFLU1ZnM1dXMXlYRFI0ZHBnYXdUaGc2VEdTNnYzcSsza2lMdHF6cGlGWXl2?=
 =?utf-8?B?OUNLcXhUU3NwVzBnZUxrTnZOdzhCUEFGeEZGK2ZUMk5IQVJIdCt0RTMwbUlQ?=
 =?utf-8?B?Kzk3MVVmcit0NXJ6ZnFPQmROVk02ZmQ3MEhLa3luN0hXQ1V6bitlRWJEMW9t?=
 =?utf-8?B?Q1NWWEIyZGN0YUplK21zd1ZWRzF0eUFpZGkvQUtlRFlxYkVEdUJLQ0VPM1I4?=
 =?utf-8?B?Sm5yalhYUGRxcE1iVHJvVmgxNWtxb1BnVXFJb1E2UTFYVG9vcGpvNmtUQ0Nn?=
 =?utf-8?B?UXEwVzVDU1gzTTNXc0NKc1dvenJBU3VZUnNpOHU4VnZCSVlVcEp5ekI5a1dQ?=
 =?utf-8?B?RjQxTGFNZjBxZDVZU0VtbnphcExkKys0ZUR2Q3VDd2lnaGd1L0JiSGNoZUNH?=
 =?utf-8?B?dnEvMTlINTFGcGtvUUdxd1N2UE9XZDQyd1BPVElXdDFSTWFZRmRWN29COTlP?=
 =?utf-8?B?TTlERUJzNGc3OW5xeGlUUm5rUW8yRG5XVWUwQkFOc3VYcVk2dk1rTGpiaGVB?=
 =?utf-8?B?Um1EbUs5Wk1mQm9VVVYwSnNKbkQxSDduUVlqMlJGYzRlREVENkh2Z1VTQmZs?=
 =?utf-8?B?TWRRSDY2cmwyUWtXNFZCKzRTNUY3YXJTdDJTZW9zUnZDQ3hVNlNxeFVCSXNx?=
 =?utf-8?B?WG5MdW9FV0NzZGhyU1RCU1lqK0tzeCt5ZFNzeGoyU1VvNk0rWEZwaHdFYWNO?=
 =?utf-8?B?MVJhR2RESWU3VWNHdCtKWGcrcW9xUEFYZWVienJIdG9HSUVoMm9mSDM1aDJJ?=
 =?utf-8?Q?r5M0=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 07:06:35.3757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 882a8133-e6af-4ac5-3899-08de07026258
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2529
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

Add a simple unit test for testing the RAUC bootmethod. Provide only the
very basic tests for now, running a scan and list, to verify correct
detection of the RAUC bootmethod. More advanced boot tests of this
bootmethod can be added in a separate patch.

This requires another mmc image (mmc9) to contain the following
partitions:

1. boot A: contains a dummy boot.scr
2. root A: contains an empty root filesystem
3. boot B: contains a dummy boot.scr
4. root B: contains an empty root filesystem

The bootmeth_rauc scans all four partitions for existence and expects a
boot script in each boot partition.

Also add BOOTMETH_RAUC as a dependency on sandbox so that we can test
this with:

$ ./test/py/test.py -B sandbox --build -k test_ut # build the mmc9.img
$ ./test/py/test.py -B sandbox --build -k bootflow_rauc

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
---
Changes in v2:
- Use mk_fs() instead of calling fallocate/mkfs/mcopy individually for
  the boot and root partitions in mmc9.img
- Link to v1: https://lore.kernel.org/r/20251008-wip-bootmeth-rauc-tests-v1-1-3da21a731524@phytec.de
---
 arch/sandbox/dts/test.dts |  8 +++++++
 configs/sandbox_defconfig |  1 +
 test/boot/bootflow.c      | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py  | 44 ++++++++++++++++++++++++++++++++++++
 4 files changed, 110 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index a2c739a2044..25d1a8299c6 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -46,6 +46,7 @@
 		mmc6 = "/mmc6";
 		mmc7 = "/mmc7";
 		mmc8 = "/mmc8";
+		mmc9 = "/mmc9";
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
@@ -1230,6 +1231,13 @@
 		filename = "mmc8.img";
 	};
 
+	/* This is used for RAUC boot tests */
+	mmc9 {
+		status = "disabled";
+		compatible = "sandbox,mmc";
+		filename = "mmc9.img";
+	};
+
 	pch {
 		compatible = "sandbox,pch";
 	};
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 23651ec764d..b7a5d81bb71 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -23,6 +23,7 @@ CONFIG_FIT_RSASSA_PSS=y
 CONFIG_FIT_CIPHER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTMETH_ANDROID=y
+CONFIG_BOOTMETH_RAUC=y
 CONFIG_UPL=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_MEASURED_BOOT=y
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 8de5a310add..d3d1d410a6d 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -31,6 +31,7 @@ DECLARE_GLOBAL_DATA_PTR;
 
 extern U_BOOT_DRIVER(bootmeth_android);
 extern U_BOOT_DRIVER(bootmeth_cros);
+extern U_BOOT_DRIVER(bootmeth_rauc);
 extern U_BOOT_DRIVER(bootmeth_2script);
 
 /* Use this as the vendor for EFI to tell the app to exit boot services */
@@ -1332,6 +1333,62 @@ static int bootflow_efi(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootflow_efi, UTF_CONSOLE);
 
+/* Test RAUC bootmeth */
+static int bootflow_rauc(struct unit_test_state *uts)
+{
+	const char *mmc_dev = "mmc9";
+	struct bootstd_priv *std;
+	struct udevice *bootstd;
+	static const char *order[] = {NULL, NULL};
+	const char **old_order;
+	ofnode root;
+	ofnode node;
+
+	order[0] = mmc_dev;
+
+	if (!CONFIG_IS_ENABLED(BOOTMETH_RAUC))
+		return -EAGAIN;
+
+	/* Enable the requested mmc node since we need a different bootflow */
+	root = oftree_root(oftree_default());
+	node = ofnode_find_subnode(root, mmc_dev);
+	ut_assert(ofnode_valid(node));
+	ut_assertok(lists_bind_fdt(gd->dm_root, node, NULL, NULL, false));
+
+	/* Enable the rauc bootmeth */
+	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
+	ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_rauc),
+				"rauc", 0, ofnode_null(), NULL));
+
+	/* Change the device and bootmeth order */
+	std = dev_get_priv(bootstd);
+	old_order = std->bootdev_order;
+	std->bootdev_order = order;
+
+	ut_assertok(bootmeth_set_order("rauc"));
+
+	/* Run scan and list */
+	ut_assertok(run_command("bootflow scan", 0));
+	ut_assert_console_end();
+
+	ut_assertok(run_command("bootflow list", 0));
+
+	ut_assert_nextlinen("Showing all");
+	ut_assert_nextlinen("Seq");
+	ut_assert_nextlinen("---");
+	ut_assert_nextlinen("  0  rauc         ready   mmc          0  mmc9.bootdev.whole      ");
+	ut_assert_nextlinen("---");
+	ut_assert_skip_to_line("(1 bootflow, 1 valid)");
+
+	ut_assert_console_end();
+
+	/* Restore the order used by the device tree */
+	std->bootdev_order = old_order;
+
+	return 0;
+}
+BOOTSTD_TEST(bootflow_rauc, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
+
 /* Check 'bootflow scan' provides a list of images */
 static int bootstd_images(struct unit_test_state *uts)
 {
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index cdf54adc600..9c74afc1001 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -547,6 +547,49 @@ def setup_efi_image(ubman):
     utils.run_and_log(ubman, f'rm -rf {mnt}')
     utils.run_and_log(ubman, f'rm -f {fsfile}')
 
+def setup_rauc_image(ubman):
+    """Create a 40MB disk image with an A/B RAUC system on it"""
+    mmc_dev = 9
+    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
+    mnt = ubman.config.persistent_data_dir
+
+    spec = 'type=c, size=8M, start=1M, bootable\n' \
+           'type=c, size=10M\n' \
+           'type=c, size=8M, bootable\n' \
+           'type=c, size=10M'
+
+    utils.run_and_log(ubman, f'qemu-img create {fname} 40M')
+    utils.run_and_log(ubman, ['sh', '-c', f'printf "{spec}" | sfdisk {fname}'])
+
+    # Generate boot script
+    script = '# dummy boot script'
+    bootdir = os.path.join(mnt, 'boot')
+    utils.run_and_log(ubman, f'mkdir -p {bootdir}')
+    cmd_fname = os.path.join(bootdir, 'boot.cmd')
+    scr_fname = os.path.join(bootdir, 'boot.scr')
+    with open(cmd_fname, 'w', encoding='ascii') as outf:
+        print(script, file=outf)
+
+    mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
+    utils.run_and_log(
+        ubman, f'{mkimage} -C none -A arm -T script -d {cmd_fname} {scr_fname}')
+    utils.run_and_log(ubman, f'rm -f {cmd_fname}')
+
+    # Create boot filesystem image with boot script in it and copy to disk image
+    fs = 'fat32'
+    fsfile = f'rauc_boot.{fs}.img'
+    fs_helper.mk_fs(ubman.config, fs, 0x800000, fsfile.split('.')[0], bootdir)
+    utils.run_and_log(ubman, f'dd if={mnt}/{fsfile} of=mmc{mmc_dev}.img bs=1M seek=1 conv=notrunc')
+    utils.run_and_log(ubman, f'dd if={mnt}/{fsfile} of=mmc{mmc_dev}.img bs=1M seek=19 conv=notrunc')
+    utils.run_and_log(ubman, f'rm -f {scr_fname}')
+
+    # Create empty root filesystem image and copy to disk image
+    fsfile = f'rauc_root.{fs}.img'
+    fs_helper.mk_fs(ubman.config, fs, 0xa00000, fsfile.split('.')[0])
+    utils.run_and_log(ubman, f'dd if={mnt}/{fsfile} of=mmc{mmc_dev}.img bs=1M seek=9 conv=notrunc')
+    utils.run_and_log(ubman, f'dd if={mnt}/{fsfile} of=mmc{mmc_dev}.img bs=1M seek=27 conv=notrunc')
+    utils.run_and_log(ubman, f'rm -f {fsfile}')
+
 @pytest.mark.buildconfigspec('cmd_bootflow')
 @pytest.mark.buildconfigspec('sandbox')
 def test_ut_dm_init_bootstd(ubman):
@@ -558,6 +601,7 @@ def test_ut_dm_init_bootstd(ubman):
     setup_cros_image(ubman)
     setup_android_image(ubman)
     setup_efi_image(ubman)
+    setup_rauc_image(ubman)
 
     # Restart so that the new mmc1.img is picked up
     ubman.restart_uboot()

---
base-commit: dc6c80056e21a27e28e1be62ac724302ef526841
change-id: 20251006-wip-bootmeth-rauc-tests-a8ed5deb7486

Best regards,
-- 
Martin Schwan <m.schwan@phytec.de>

