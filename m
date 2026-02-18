Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FCEE9A04B
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 13:35:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B35D283DC9;
	Wed, 18 Feb 2026 14:35:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Sx/9Tmsa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94EF183D2E; Wed, 18 Feb 2026 14:35:25 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C02BF83DDD
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 14:35:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7mFKnekkrAV1FEsZlsJ5Z8pcbY+mQ+n35zesI3p/uT/t68BeQ+p0skRRCf3WWlFFPohtf04mUSngxQrB2mhPS3PTq1HmgAItWZptMmHjHrT5oXdukeL2Ji64ey7imYhUu1gxlv1dpRtrrdnh3AiEgdGpI96TGWGEZV66y7zazdJdyLual5b0KJ+HEeP25aRs/S+GOe63m8qXIL51qpzY/XXVGdiY5rtsXgBYDeQPwRqq1fke4P8UY/FTFNDlr/GxxpF/zp5DDdRZ0IxRWsLOEYZBI78kU8WXER1/YesOXrAyvaOgJHBt0gJ+WTSG6rV20XmGJbUZ4MOOF2z7xgsUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOsFuz1uqqAHOGgj/WW50n/esW+oJ9JTj1nm3BqqAFc=;
 b=CNVyV07MBtbwfxtUdB3fqgIwJMcMYfy2nlFYXua8SRnQhpxcm9k/9QwRF++4JE1fQUpy/24oepkKTnSHaABkiqrWabY7WlDyY++BqHiUQasROV3c5/EYRDWKUMZeQzcBRmpSrztdiVI30HW0Wk7Lp2DI0uQrLskTy3hcGJH/b3tv/1wu+OJm6yROtsybBUzu9qgerXZZirmeosd7mD2ehSrfMijAO/h2wtfKyE8xrtr027/KrkXM1iE0OIVEMElk3msUJeq/sb3FNnz+THT9jK/fqCeUt9vJs6oHHHKYjplOWPudbZuXbTdWLXdqP/CWhbY0ri9+N/ZtjEeDB7ekMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOsFuz1uqqAHOGgj/WW50n/esW+oJ9JTj1nm3BqqAFc=;
 b=Sx/9Tmsa3BO5o1gkDgoUrgYL06AdBUziqBpWEfHfhrZpSs9W2kpJ1Z2ru0YpfAORtrCsdRHGKB2YRBmF0ZNO+EbGWVaiIYcK7JVJC5650b/7PJSnRbnP9GihAEAKsvLz97aLrfHiBem9MHbdlNVUZ/dinimZ0oNVz9OaMIKVZGysQ4o2dRtlvrD812bdlOIqxa6P1uLjIEdh9/7iiM4zsExyoWL4rv7ppLlYOE6HPOSrQwKwaLqoaBfp38HB3J9hgaGKFQtmJh1XT8WkzS9REUuVVVsqPvlsVLTEt294XOnZquGhClKQdrH1EsLZC9W0U3MjV5dVPIylKab/M2e6PQ==
Received: from AM8P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::28)
 by PAXP195MB1389.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:19b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 13:35:20 +0000
Received: from AM3PEPF0000A796.eurprd04.prod.outlook.com
 (2603:10a6:20b:21a:cafe::66) by AM8P191CA0023.outlook.office365.com
 (2603:10a6:20b:21a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 13:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AM3PEPF0000A796.mail.protection.outlook.com (10.167.16.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 13:35:20 +0000
Received: from lws-schwan.phytec.de (172.25.32.132) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 18 Feb
 2026 14:35:20 +0100
From: Martin Schwan <m.schwan@phytec.de>
Date: Wed, 18 Feb 2026 14:35:07 +0100
Subject: [PATCH v3] test: boot: Add test for bootmeth_rauc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260218-wip-bootmeth-rauc-tests-v3-1-64aeea6d1032@phytec.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNyw6CMBCF4VchXTumFy7Vle9hXBQ62C6kpK1VQ
 nh3C4kJG5b/SeabmQT0FgO5FjPxmGywbsghTgXpjBqeCFbnJpzyilFaw8eO0DoXXxgNePXuIGK
 IAZREXWlsm1LWJF+PHnv73eT7I7exITo/bY8SW9e/KQ/NxICB0Ioz1QhW8fI2milid9ZIVjPxv
 XM5dnh2qOxbLRohkaq9syzLD+fiY+oGAQAA
X-Change-ID: 20251006-wip-bootmeth-rauc-tests-a8ed5deb7486
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Andreas
 Pretzsch <apr@cn-eng.de>
X-Mailer: b4 0.14.3
X-Originating-IP: [172.25.32.132]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A796:EE_|PAXP195MB1389:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d83139-cb5a-4ca5-f3cd-08de6ef28fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkQvUzd6S1RGeUhUYVM5dUErbHJUTVplcHd1d0FRSDRYNkZFNEZqamNkZjNq?=
 =?utf-8?B?NXNDT2FOT0JXWFh4aDJteUhwRFl2WDkxVFdLZW1ybjhWRHo5Q3ZXQzFCZk5j?=
 =?utf-8?B?L3NHa1NUa1pNM1VnVjBaSWdDMlpJYnArSlhqQWxNMXNiVkw1b2Q2S0g2VTRh?=
 =?utf-8?B?U0RGOUZsU3QyaXBTeXhIeTBMb1VkcnhwUXgrYjhjNmw5djhMNmdFVmMrM085?=
 =?utf-8?B?QjFCbmtDZzc1L21xY3V2aE1lakF5aGtnakRyVVpBaHkrR3l0bkYwRFJUZ0hi?=
 =?utf-8?B?TUFraTNWNlhoS3FUVEJMVEtyQlJQMUdzR3QrSWZlb1ZkYURTeHVrOUI3bDg5?=
 =?utf-8?B?bzZDV04wTFJCVkJTTXB4Umwyb2NPT1gwaW1mYlkxcFI5eEhxbG9RTGpGVEFQ?=
 =?utf-8?B?ZXM3UlNiQ1cyelRmMkR5TS9SOXFhQVo0R2VqNFVyRWh2WDJ2MVltV1FneHlK?=
 =?utf-8?B?dGxqUjcvSE9PWHNTTjg5SjV4TjF1ZGRIbU5HaEZaMERPZWRWZjljbDkrWUdK?=
 =?utf-8?B?S3hWUHB3SFNyWXpUbCtjRURBbjBJWXJBOXViOHl6MGgreDVndE5tVlhyeXNo?=
 =?utf-8?B?b1ZpWnJMZ2RtNGx5UHpZaG5iVTIrdmZURC9DYW0rQmQrSWFsYm92NGhKbm1i?=
 =?utf-8?B?cHNJZnRwbGFBa0JnNnJmQm1mSUF6ZkhjMlVGSlpQYjdUYUhUZ3hIZjdEMDM0?=
 =?utf-8?B?UUZZa3BuZHhBUUxNTlR6YWJkSHNSclN5bjdkVXp1TnBRL1NTS2Zta0xoZVBh?=
 =?utf-8?B?YU16NW1CRTR3REY1YWhVQS9IZjFJNXJ2WXNhc1RNRGJKQU5CNzdMSHJJSGdB?=
 =?utf-8?B?MGRVTE00SDAwQjczam1rbG1RcDNiTzZLQ1padDNVOFo2Z0doYSt0VkR1NXFp?=
 =?utf-8?B?TGg0bzFmV2hFYXdWTDRnbWJaWEpBNXBvRGQ1ekdoWXhRWTUreXZVQk1vZ3R5?=
 =?utf-8?B?UW9TZ3ovU2xpSGFEd0grejJ4TmJ1ZENtcjYxTi9kOWNzQnhEdHBscDg0UkdS?=
 =?utf-8?B?bjAvcU9nNjRIS3AxK2Q3QnpDeWNydmd1QWxZTnF1bTZnaVJTMmR1cTNmcnNP?=
 =?utf-8?B?Q0x5QWROOWxWYnVDRXZSZFlndlltV2lOYlZNMksrM2ErZE5hK2pmRmxwSGR5?=
 =?utf-8?B?WFZueG51dzMzSHV3QlRETDNFNlJlRCs3UXlyaVQ0VzdBc0k0NDJscFRmQk9x?=
 =?utf-8?B?WHdDS2FEUUFvSis5a0JEUWs1THNEeU9mOVYxUm1wYjV3YmVQYjdFczRSbmh4?=
 =?utf-8?B?aVFHYVIvNHlwcWRiOXNxdHEvRDA5U01oSk41aEVkSzVXVVNvNnBDNVNtOVBC?=
 =?utf-8?B?WklHRy9DbHpqOTljcCs1QWIzVzV2b3B1UTMrREtmeHJDQjV0L0htTmcxMi9V?=
 =?utf-8?B?ZFhZZ0FZTWxLOWIwODRWZUpIckM2aENJMFphMjJMY2FjV01QTmlvUGo1b1NL?=
 =?utf-8?B?WWZjVEo5SGxJdkJaeGJTb05tNktUa2xVSXl6clpIWjRUK2Y4bkxzbmV0VUEx?=
 =?utf-8?B?d1lWSjJRNnFPRER4TEwzcWM5SkJ2cDJ5N2FXZDVqYnE5UmVudERBbGc0VklU?=
 =?utf-8?B?Sng2cnpGVDV3OC91NDJ0OXFOL2l2VWVIa212MkZJd0ljK1FhV2QrRjA3V2Fk?=
 =?utf-8?B?bmNSVnhZdEhXenl1TXhmSDgwdXc3RmFOOHNPekMzQ0hLMEVydWhDNWxzVGJs?=
 =?utf-8?B?ZUl5TFE0M3VlMkJyV3JjbnR4YjIxWmpGMzh2aElPYUdxb2pxZEs0TVN1bGln?=
 =?utf-8?B?Umk4R0tmZXJoOHM0WGROQVFOVzA2OXNQSlNSOWlzcmw3WDlpSnNYZEJjZ2xl?=
 =?utf-8?B?WUNFL1dxYjdmZjA3VXpXVUo0dXVlZXpCemZtZ3VranR5SlJMNXY0RFYyaThs?=
 =?utf-8?B?Y25FeThTQ2F2cVlmZTRKT21VUzVQNTFHWDBDZFhuUmV0NFR4Z0hGbG1xbnZ4?=
 =?utf-8?B?ZHBvdzZqQU1DaHpueWxXNXlQZU0vQW9MdWk5QVFLL2NlNUdaZUdGK0dpYnNt?=
 =?utf-8?B?Mm1YdklhNFhBN3ZkdHdWeE9EWS8vTDJDMTFpaHp4bWVoRFdPRkVoK1VwQlB2?=
 =?utf-8?B?SGsyVXZiZUpOeVNiK2hzNytNMmIrd2wycDd4QjJFM3R3ZzVoWUorMTBDWXFF?=
 =?utf-8?B?Y3V0QlRNd0NVenJOMEdkUjNSYkFYODRYOHFkUjVMZXZ5RERkd2hnc0xVZTVZ?=
 =?utf-8?B?OHFHUnpoNnNNNFM4dWFCek1mVnp3Z2RON0NGMTg1aGNHeUQwZ1NjYU40My9C?=
 =?utf-8?B?UHU2cmUzZFQrajdZUllBbVJKemRnPT0=?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IKP3TZbW+6ZIKHBv6kDxRu77Wxv16h1A9OYYtMBClqil+uXIljyt1pinq4S0wHQKJBll+UqddVeTNFu9Xm8ULS7sMWSMHPVsiivm/ruSUIATQqaWZ4Pr4pAupkpS978BoT4mC9oqlIWxo7P2KxbuGVHViPDbER1HTDnl/lz/zZPMpuPc2/5VKsjcNr/rHJO7+R1awuOQ1IEK9krleqgUfFMLI6OBHj4fw0e4xN8aUS+ApGpe0srFyhclgrNe4yoQlecPDJ0URdLTiDxoMW7slfD9m6NWb1DMMWlgX5w9iZK9LKfqPDHAYZsPbH3G4YdFmNXx/yVJhR3XvOKjLqu2RG3Vec/JgCCF2RaNSTs9vUnZHPuDlopu/B0aUHZLlirQm3i0oVqQ8Bxn5C/02m3u5dzLNt+cUDCNeRZHPppSsbdqlov3Z3lFkCefMKrHFZpj
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 13:35:20.7442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d83139-cb5a-4ca5-f3cd-08de6ef28fdb
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A796.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1389
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
Changes in v3:
- Use ext4 filesystem for rootfs instead of fat32
- Explicitly create an empty directory for the root filesystem, instead
  of passing "None". This fixes a usage error when calling "mcopy".
- Rebase onto current master
- Link to v2: https://lore.kernel.org/r/20251009-wip-bootmeth-rauc-tests-v2-1-08fbd3738e0a@phytec.de

Changes in v2:
- Use mk_fs() instead of calling fallocate/mkfs/mcopy individually for
  the boot and root partitions in mmc9.img
- Link to v1: https://lore.kernel.org/r/20251008-wip-bootmeth-rauc-tests-v1-1-3da21a731524@phytec.de
---
 arch/sandbox/dts/test.dts |  8 +++++++
 configs/sandbox_defconfig |  1 +
 test/boot/bootflow.c      | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py  | 47 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 113 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index b7402d7042a..b4b83590aca 100644
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
@@ -1272,6 +1273,13 @@
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
index 4ee7ffa8bc3..f1a464b681d 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -24,6 +24,7 @@ CONFIG_FIT=y
 CONFIG_FIT_CIPHER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTMETH_ANDROID=y
+CONFIG_BOOTMETH_RAUC=y
 CONFIG_UPL=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_MEASURED_BOOT=y
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index a56435d053f..6b5d4ad98d1 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -31,6 +31,7 @@ DECLARE_GLOBAL_DATA_PTR;
 
 extern U_BOOT_DRIVER(bootmeth_android);
 extern U_BOOT_DRIVER(bootmeth_cros);
+extern U_BOOT_DRIVER(bootmeth_rauc);
 extern U_BOOT_DRIVER(bootmeth_2script);
 
 /* Use this as the vendor for EFI to tell the app to exit boot services */
@@ -1392,6 +1393,62 @@ static int bootflow_efi(struct unit_test_state *uts)
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
index 6d535b5206d..0576dd42db0 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -548,6 +548,52 @@ def setup_efi_image(ubman):
     utils.run_and_log(ubman, f'rm -rf {mnt}')
     utils.run_and_log(ubman, f'rm -f {fsfile}')
 
+def setup_rauc_image(ubman):
+    """Create a 40MB disk image with an A/B RAUC system on it"""
+    mmc_dev = 9
+    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
+    mnt = ubman.config.persistent_data_dir
+
+    spec = 'type=c, size=8M, start=1M, bootable\n' \
+           'type=83, size=10M\n' \
+           'type=c, size=8M, bootable\n' \
+           'type=83, size=10M'
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
+    # Generate empty rootfs
+    rootdir = os.path.join(mnt, 'root')
+    utils.run_and_log(ubman, f'mkdir -p {rootdir}')
+
+    # Create boot filesystem image with boot script in it and copy to disk image
+    fsfile = f'rauc_boot.fat32.img'
+    fs_helper.mk_fs(ubman.config, 'fat32', 0x800000, fsfile.split('.')[0], bootdir)
+    utils.run_and_log(ubman, f'dd if={mnt}/{fsfile} of=mmc{mmc_dev}.img bs=1M seek=1 conv=notrunc')
+    utils.run_and_log(ubman, f'dd if={mnt}/{fsfile} of=mmc{mmc_dev}.img bs=1M seek=19 conv=notrunc')
+    utils.run_and_log(ubman, f'rm -f {scr_fname}')
+
+    # Create empty root filesystem image and copy to disk image
+    fsfile = f'rauc_root.ext4.img'
+    fs_helper.mk_fs(ubman.config, 'ext4', 0xa00000, fsfile.split('.')[0], rootdir)
+    utils.run_and_log(ubman, f'dd if={mnt}/{fsfile} of=mmc{mmc_dev}.img bs=1M seek=9 conv=notrunc')
+    utils.run_and_log(ubman, f'dd if={mnt}/{fsfile} of=mmc{mmc_dev}.img bs=1M seek=27 conv=notrunc')
+    utils.run_and_log(ubman, f'rm -f {fsfile}')
+
 @pytest.mark.buildconfigspec('cmd_bootflow')
 @pytest.mark.buildconfigspec('sandbox')
 def test_ut_dm_init_bootstd(ubman):
@@ -559,6 +605,7 @@ def test_ut_dm_init_bootstd(ubman):
     setup_cros_image(ubman)
     setup_android_image(ubman)
     setup_efi_image(ubman)
+    setup_rauc_image(ubman)
 
     # Restart so that the new mmc1.img is picked up
     ubman.restart_uboot()

---
base-commit: 8666b16015d4212facacc514e2eb626f3630dcf0
change-id: 20251006-wip-bootmeth-rauc-tests-a8ed5deb7486

Best regards,
-- 
Martin Schwan <m.schwan@phytec.de>

