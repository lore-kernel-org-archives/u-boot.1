Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EF6CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 06:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01B938394E;
	Wed,  8 Oct 2025 08:58:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="CxK/50oH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 624FA83956; Wed,  8 Oct 2025 08:58:10 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1305D83942
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 08:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nU9aVnmNf3whHcHCR3324xvLxvewfM3GtuhxJu+NTwp8cYQHRoyS+HVAGKupMPSbvCy8+skrJ8+si0frjqAGvIQv0fYbW61qw93FIK7UfKaJ52cfKzxMqJNo0UYoNpueOrtR10wVdyxsbdoNgxFYksW/Qz1ypRhXGOx6fZOLd+y+tV7pFtgUbRzoPAjDnV5OEbERmcoPIWjg60Q72Zw6566lxe019ThNc6ujzjVUfBcTltav9V/MK4Csf0uwWGVaucXAMrcKZBsaOMBZtSGwfXQN6tPtGzprloVZXCGuqmJgSBx/K4B9QcLxPR2rwGt6Xce+mbRWvB2brpa9ecQNPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l8DEXzKmCjZL409i3BNWlE6ePVWvrVdeS5pLT3YPz8=;
 b=nXvl7M2BPOaqqiA4RWPtvoC5doDXX9YnEBjmlyvh8msp40+bmTCJoHqI9v81zGL1/TOxE8Em7cdJV2dSubPyBoSjQx0s3TznnBe2wFfuS4NqxGmUaMjtf/Efilg83zYbxRyD1sTgh7/I6N6/RtR8yRKXqGfp4U1A/hzlgg0rMUmtozkSzkCTx4NVkAUw/blmXcB1vb60bVaZT5h7Z1xx40XGUm765nfsh2dzQFiaT+1Lqei4XRD8FYPqFTFi6gaxWt+MXLWp27F7mpZZVl5DsMuYijdLAPmgZ8kt3rk3891zmDqmkoZ36wEwX4q3DINrRE3mjbOL/q+9h4zwDonvHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l8DEXzKmCjZL409i3BNWlE6ePVWvrVdeS5pLT3YPz8=;
 b=CxK/50oHuwkyd+ez6srzz3CkCUnnHoHoqRfsYxn68UkBvqqUfR7m0fy0KRx+8OAAhxBR/rSZAHCo3WsvdB4YcYkRWKkj2OC/ghwpPPsEtVGkujvKkAEgwLVEnDujX22A5vDCeCAEAsil8Mp/IBGKZvCZ2g0u3xZjEva3KqxlTxQjGavWj+nE8K2Y50cqmju/7Is8qTIQ5KGmmhqa1BveJmd6FYFpQbcxILNDmiRj232k/Vctpvh3nvufkoDR4/hYlKhTs5qHPR94VqTCeELtvUmNdvh1Rd3j/sgTFjMcIJkMvd7KVUVOF0POjl95xtDUjc5H8tKIPevyZkppxFVqRQ==
Received: from AM8P190CA0009.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::14)
 by DB9P195MB2022.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:39f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 06:58:02 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:219:cafe::5f) by AM8P190CA0009.outlook.office365.com
 (2603:10a6:20b:219::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 06:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 06:58:02 +0000
Received: from lws-schwan.phytec.de (172.25.32.51) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 08:58:01 +0200
From: Martin Schwan <m.schwan@phytec.de>
Date: Wed, 8 Oct 2025 08:57:30 +0200
Subject: [PATCH] test: boot: Add test for bootmeth_rauc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251008-wip-bootmeth-rauc-tests-v1-1-3da21a731524@phytec.de>
X-B4-Tracking: v=1; b=H4sIAFkL5mgC/x3MSwqEMBBF0a1IjS2I4o/eSuMgmqfWQCOp+AFx7
 x16eAb3PqQIAqVP9lDAKSp+SyjyjMbFbjNYXDKVpqwLYxq+ZOfB+7giLhzsMXKERmXbwdUOQ1t
 1DaV6D5jk/p+//fv+AAnSXOBpAAAA
X-Change-ID: 20251006-wip-bootmeth-rauc-tests-a8ed5deb7486
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, "Andreas
 Pretzsch" <apr@cn-eng.de>, <upstream@lists.phytec.de>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.25.32.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A64:EE_|DB9P195MB2022:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dfaace5-ce8e-433d-eed3-08de063805f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHRURVlQVkFlSVlJWlVOcDQwRHliUWRoZTNHMDllQ2Q1RmJxMEc1RTA2eS9k?=
 =?utf-8?B?SjJOZ2F4dXFqNzhYOFFsOE84Mk9KTUFrRG9RSFNQWUY5dEplcGY4c1dhajRF?=
 =?utf-8?B?RGZMVzAwYnl0RWRhSnJtNEpEU0pFWjZEQ2FNaldyL3lZY0FyNnhOZldZTjJz?=
 =?utf-8?B?WTRFT0NMelFqL1JMTTRITVJnN0s2eG1QQ0prRDZDbHp6eVlmS3Rra2N1SWdK?=
 =?utf-8?B?NWh6MUJKSVRHQTltUVovcGJCcDhFZ284VU4xWGFZaVpDM2t6MlBXTEZKZUcx?=
 =?utf-8?B?L3pRKy91QzR6WDNockREQjdhSlcrNHlCVXNrTDMvZnFmQ1RITkJsR1ltZW5j?=
 =?utf-8?B?RjZKS3pxQmRsaTBleUlTbjBtdnNyamwyaENZU3pJTDFrZ1dMSGc4M1Z1ZW5o?=
 =?utf-8?B?YmlYWG54L08zcDZ3VGF3emd0UFMyVVlBd3RJS3pTNFVWaU1hRjJSY3FUOGIr?=
 =?utf-8?B?eElYeU1hYURmRUVITUJ4OWY4ejRBV1dFODJUcjJXVUlRS05OVzhCZk55YkFM?=
 =?utf-8?B?TzVMYzQwNHZKMVU5S2lXVjFpallyWWtOY3BpekdmdVlEUXN1VWlrRGFyblk1?=
 =?utf-8?B?Yk9ram1iMjQwTWRYM0lIUjA1TW9ZUTdNV0xKaTVSeGxzUmVoZDBFYzhiVTdL?=
 =?utf-8?B?dzdrejR2L2xnVHRnZW9jbkdNSGRGK3BIa1lWOHU5SDlmNDNuSG4yTzUyTzF1?=
 =?utf-8?B?ckNZaSt4VWs2eHYzdkZPOCtXMlFOb3A2U005cGpwRC9sTmpPb0tpdXZLanRx?=
 =?utf-8?B?VUdUSDdGMjdZN25KSmVRVWNJZmRGcG0vVjZyYnZ6Q2N6alFzT3ZxQmhqNkpy?=
 =?utf-8?B?QXRUTFlaMHl3dHlDdzVCRGdmd3U4S0lPb3IweGFtVEQ4SkFURllpcy9nVWlM?=
 =?utf-8?B?ZnhVOHZUeEVTYVVvaW9wK1pXRy94V21Ua2YwQWhSejJCQVBLYXQxS3I1TnRY?=
 =?utf-8?B?K3Z1T0pEbG1GcE4xdklZdmZxRm1RanI0UVd0TERTblBFOGhoTWZYZXF4QUYz?=
 =?utf-8?B?WUZlY0s1WEZGQ25ONFI2S00yc0VmZXdvYkVvcGpFZ3pWaGNLRVpTZHNCcndh?=
 =?utf-8?B?UHFLSUN4VVpPL1k3NWxQcHdOS0orTUFVRW4yK2JiYVhFVzVPL1k2RVpRVjha?=
 =?utf-8?B?cGYyQllwUWRZR01lcjg4QzMwdlRrald4SzZlU29mT1VTT1huREV4bmN3bVY4?=
 =?utf-8?B?YnhpR1daMDBoS0NYRWtudDRpbyt4ZFJlTHQ5L0ZzZER6MXJtVEN0NlBLOXlZ?=
 =?utf-8?B?MURubUxnL2hOWXVScFEveGE4cWZCNDZMT3VXc2RjNndudEtCTXdGS0VjWTRJ?=
 =?utf-8?B?VHlBSjRlNGs3cE1kc2ZXeE5TWTJRZmVDdkFVRVZ3eFhLV2lFUFM5am4zNWFB?=
 =?utf-8?B?Nm1FK1E3aCtSa3EzUU1wZHBzR29DckR1Q0s2SFVFVEpVWkpxOVdsTDhtL3dB?=
 =?utf-8?B?bTgzalNIWmhYUzRUODd4WnFHT2MwNEtsWjNpdFU5WHlWb3RTWDdINGVSSXg4?=
 =?utf-8?B?NTE3MkFqS2lzN1V0TnlTaEoyQXdSUFBoWDNhbWVhNmZZVnplSDR4dmsxSHFi?=
 =?utf-8?B?NEtCTHlWbTQ2T3JVVCtOVTNyZ21GeWpjeVFMd2llS1I2MVVrSmp4RnplSGI1?=
 =?utf-8?B?cU9pb1l2Z01YWE1LMzdiaXorNis1OEg1VzEzZThES3MzejBlV2o5NWhGT2Y4?=
 =?utf-8?B?Wng2NkdzaHFLTWtMcWVmYVZhOHdhclIzakZJWFZjbmt0aWErVjFaWW94V3Vu?=
 =?utf-8?B?K0tzSERWWGV6SzFNZy9jUjdtcGd6UXlGQVkrbUl4OFgvWWRoNERFTVU4TnNL?=
 =?utf-8?B?anAyVGJJbUYzZm5tOHVqcDNtL2txbU9QWU54bkxyNHRkWlhvMVQ4dVF0UC9C?=
 =?utf-8?B?QW05OEt3RGlhc3plZ25wQmpiMFVjTXdsdFpUZFRzWHphclcxYmRGRjJ1R01u?=
 =?utf-8?B?WW5Ya0FFOWNwVU45ZDFPQXlOK2FHanhONkxWYTV5SDBYdUNjbWFuR1dPUVZY?=
 =?utf-8?B?djRIN3EvNlBsS0x1WjR5VHpFaXdlaW1Wd0JhVy9JK2Fyd2Qxc3Z2U2wrcExM?=
 =?utf-8?B?czRyM1EwcHYxRkxRU3RzKzdobXNiT0xyOWxrQ2xYb0lRY1BvZjJ2NE10MEJZ?=
 =?utf-8?Q?HGgU=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 06:58:02.0374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfaace5-ce8e-433d-eed3-08de063805f0
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB2022
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
 arch/sandbox/dts/test.dts |  8 +++++++
 configs/sandbox_defconfig |  1 +
 test/boot/bootflow.c      | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py  | 45 +++++++++++++++++++++++++++++++++++++
 4 files changed, 111 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index a2c739a2044c728a96b5f4acbf439a42d7e12fb5..25d1a8299c6462295edbe7bdade167c96ac7e9bf 100644
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
index 23651ec764dbc2d83be62cc0d91216eebd91acc5..b7a5d81bb71d9dd58ba20c33049d1b4534ea21f3 100644
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
index 8de5a310add38798f3a52ea6cd796bdffdb16bd6..d3d1d410a6de349f880a4fb06cbc41804dc6a9a8 100644
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
index cdf54adc6008c21d67eec466c3245c75208a2ec9..2e6b050ec2bafc765d1f7bb0c94a553b51ea69c2 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -547,6 +547,50 @@ def setup_efi_image(ubman):
     utils.run_and_log(ubman, f'rm -rf {mnt}')
     utils.run_and_log(ubman, f'rm -f {fsfile}')
 
+def setup_rauc_image(ubman):
+    """Create a 40MB disk image with an A/B RAUC system on it"""
+    mmc_dev = 9
+    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
+    mnt = os.path.join(ubman.config.persistent_data_dir, 'scratch')
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
+
+    # Create boot filesystem image with boot script in it and copy to disk image
+    fsfile = 'rauc_boot.img'
+    utils.run_and_log(ubman, f'fallocate -l 8M {fsfile}')
+    utils.run_and_log(ubman, f'mkfs.vfat {fsfile}')
+    utils.run_and_log(ubman, ['sh', '-c', f'mcopy -vs -i {fsfile} {scr_fname} ::/'])
+    utils.run_and_log(ubman, f'dd if={fsfile} of=mmc{mmc_dev}.img bs=1M seek=1 conv=notrunc')
+    utils.run_and_log(ubman, f'dd if={fsfile} of=mmc{mmc_dev}.img bs=1M seek=19 conv=notrunc')
+    utils.run_and_log(ubman, f'rm -f {fsfile} {cmd_fname} {scr_fname}')
+
+    # Create empty root filesystem image and copy to disk image
+    fsfile = 'rauc_root.img'
+    utils.run_and_log(ubman, f'fallocate -l 10M {fsfile}')
+    utils.run_and_log(ubman, f'mkfs.vfat {fsfile}')
+    utils.run_and_log(ubman, f'dd if={fsfile} of=mmc{mmc_dev}.img bs=1M seek=9 conv=notrunc')
+    utils.run_and_log(ubman, f'dd if={fsfile} of=mmc{mmc_dev}.img bs=1M seek=27 conv=notrunc')
+    utils.run_and_log(ubman, f'rm -f {fsfile}')
+
 @pytest.mark.buildconfigspec('cmd_bootflow')
 @pytest.mark.buildconfigspec('sandbox')
 def test_ut_dm_init_bootstd(ubman):
@@ -558,6 +602,7 @@ def test_ut_dm_init_bootstd(ubman):
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

