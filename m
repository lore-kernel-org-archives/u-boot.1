Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CECCA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 12:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1C0B838F4;
	Thu, 14 Aug 2025 14:08:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="LRdqNY0g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D81BA8391B; Thu, 14 Aug 2025 14:08:46 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45B10838C7
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 14:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wql3a6RwU+1AzzJK5wu3SoHcFehfwWy1G9Bi7gGTGkg9dHnyDrcGKjAIZ+Q/zSnB5Q1tx9EW/17NQeVnnMId0MTeDOtnb91VF80UE9BJq+/pC16SkbEeedqx2GVd33OUFiZWHX/5UHgIJ/+JEzNbt9FAcx8bf8Uqzva8dDSdbtC5w3ofa4OLv04AvMmZzJFiNLfxALSIkOx+lEPqbPPCqtKcOpjX+e0xFFOu/yE4IIP4XcDlDgwycqnaj0cL60trjcdHHocmC1E7GuSJzQIpmBJuvYsBZzdTZrlu61fMoF0nP8T5so0/em3uEHdq/LK/2v+On5AgkniO0AlovszJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p86dMXT0rdrkHKWvH6mJG6PUEk6gwbShrI5ENEWW5Rg=;
 b=NKv13AoeHn3F9JIzlruEbvScYRn3dKdWDt48/b+cg6aRYV2jU2JYbVgkhBi9IQjiULEMtPYaatCSOFJtO9LRzaTi3bSEQ7HLNkyLEYJd15f7/JfXFPOSfeamNqTaMBKa8cgTomihF2IGfTcxrDeHKlMx/8rUTky6Fswc6oXXdOVBoyUnGMR1kfNIL0EicRQRvBDHm1q5YV0lDdkbUfmuLLKOdalWs0nE4K/zZ6jFutxKKcuIDKLwnkZeGm15CRoXQwllj5kekNYKyrmnNorS9Hsk+M5jThrMSehHWWB924FmRAr8tIExF0cxfE8ywINrmcFnITYZLKKDwELECU2LXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p86dMXT0rdrkHKWvH6mJG6PUEk6gwbShrI5ENEWW5Rg=;
 b=LRdqNY0g2FeN8dE98F1bg9BsLfzhx4rOKc3Yw57smyLdHeI5VBo4XdYsKtHKS+mAXln6Zk3/TNw6fHuFCAdlQbhtYT8fumkhF0b5xRi4VX0AE4G7M6sugQyMss+QTjQXYxMKamNnMmCIQNUt5WTXwcwHi7qnn590Bw3qUBO04gnLjBN2R0LDcha0jSZ/inGlj8Nsu/QOtkHnbAl7NkwRlnVwvVazZs8jBzSQA1lSvNEEqLaZvCxAPc8NilG7gzOooOPLqPf4BzgBnv2svpIGVW9l1xQNMrVFMErqrpvErd6og8JimHF0GaFIOVaU5h97C8BnELquKi29Q4rHYcaNrQ==
Received: from AS4P192CA0019.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::8)
 by VI0P195MB2832.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:2bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Thu, 14 Aug
 2025 12:08:41 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::7f) by AS4P192CA0019.outlook.office365.com
 (2603:10a6:20b:5e1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 12:08:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 12:08:41 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 14 Aug
 2025 14:08:40 +0200
Received: from llp-moog.phytec.de (172.25.32.60) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 14 Aug
 2025 14:08:39 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Thu, 14 Aug 2025 14:05:41 +0200
Subject: [PATCH v2 2/2] doc: phytec: update imx8m docs for optee builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250814-imx8m-optee-enable-v2-2-c489d795ae07@phytec.de>
References: <20250814-imx8m-optee-enable-v2-0-c489d795ae07@phytec.de>
In-Reply-To: <20250814-imx8m-optee-enable-v2-0-c489d795ae07@phytec.de>
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, "Teresa
 Remmet" <t.remmet@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
 <j.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755173319; l=9969;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=dRdGCGL2P6HI8V3shmXdq87km/e9tL9YBfdaXc5pkHM=;
 b=YmpxBdYKoajhfaDLvTQj6rZzuOpFm5M1y83cKZfNiwBCX3VghF5j/2JWtp3LcOqEsyH0qGOxc
 LSFbd42C7IBAgRAe3UCMRAzSt6KJaO8M1g1vAJ4psIXJGoZBXmFZvE8
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.60]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000041:EE_|VI0P195MB2832:EE_
X-MS-Office365-Filtering-Correlation-Id: ae550fb6-9fb3-4962-1f81-08dddb2b4f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amhsdVFBK2xEVi9mUmlnb1REbURNYjYvRWxtcDAxTS9nK1pRbWJWNGV0ZDRl?=
 =?utf-8?B?QjJITFZpNmJyaFo1bHAwcEo3QWtFWllnc1hOT3RRNTBTS0FsVHMzSExoL1J0?=
 =?utf-8?B?Q2ZCWDV4Z1FMY2NKWFkrQXorWk55NG9odXpJQ0NXWXo5WWRCZTRXZy8rcXhE?=
 =?utf-8?B?YU9wL2c4R20wSFY0RVZFdElEcXNNazFXZDh3aThUWWlNVitwTWN0OXZnN3Ns?=
 =?utf-8?B?RHBiMmpHTld2SkgzcjcyVEw3V2E3S2RJMDg4UGdOWWFWVStNQkFNbm4xVUF6?=
 =?utf-8?B?VmFCZjlwK2R2TUNueDBRWEpRdjQ2NnRMekNITEZQbmw3TFR2VFF3ZnpEbzMy?=
 =?utf-8?B?dEtnNXkyZEdVeElLRmw5TlBjUExuZXZXYnhGOENXZytuSndINVN0NzAyNkZU?=
 =?utf-8?B?dEd1alg0QmRseGN4ODBQemhMSURKc3lhdDVocSs5UWFWdjhoU3NQZUppZ1Ay?=
 =?utf-8?B?WjU2SE5wOGZKc3ZXcWpOMC9SZ2djbUh5eitHNVhYMFhJWkJjY3FqTlZFMDdU?=
 =?utf-8?B?c0c5aVBMTVkrcU9zOWNOeWZxTlNZNGliVGpDTGVXNFU5emlMKzFqamdoVWdn?=
 =?utf-8?B?TDZBNzZ1N240UVZWOHpSYVNJYmNqaS9ZbWN0NXlST1pKVnE2eWFac2U0Njdq?=
 =?utf-8?B?cUxlQml4Y1lvSytST0hydkM4WHMzUXRrWEtuYzBvRTh5NmJBNE5zWVlhdXdQ?=
 =?utf-8?B?eGpLcEFzNzZHY0FWclU0b2FneWNmeW5tbmR4a1NyclA2eGRRY0o1R0xKdWwz?=
 =?utf-8?B?MUhtMHNOZFA4bVp6WmNGdEo0STNXNkM1L0ppTmFSWDZaclY3eGxNckVvcWhE?=
 =?utf-8?B?bEYycjkzQXlLd1dJbngxMkJPMkJFbVYrdFFwQXRQbXVEZlpvbC91VmZ1Vm53?=
 =?utf-8?B?Z0UwTE11dVFUV2JKVHFnWS9KdUhtYXlVQmtOVFhxWTdKajZqQVpHcURxMFN1?=
 =?utf-8?B?Um9weEFnTS9kR1NjVkZ3NHQwL2RsN05ESmgrVzVzdWEyTGxMVTZTMjFyMDNp?=
 =?utf-8?B?TW5UQ2RVZG9WL0x4RGVLQ1pyc0R3Ymw2bE40dWUrN0pXUjZWd2RNZlQ3Vlk3?=
 =?utf-8?B?RTRWeFV1Zk16Q05zUWlWMWxLNWpGNXVqdFZlR0hScFFLSFBrbWt2ZDBFbmhj?=
 =?utf-8?B?dkc1QVV4dU5ZYkw5d25qTGpGbUkzcjB0VllyV1FHMUg4Mi9pWnZaZHg4U3cr?=
 =?utf-8?B?emVBVlBPTThubmZ1dGtBU2pWWWI3a01nbVp5TnZDSjRSSzJMQS90S2Z1aElQ?=
 =?utf-8?B?aXR5elRoOTFoeGJhUGRwa0JUU0xlZW1RVUMrUkJqc0xEcGttWmdQeVVCdThD?=
 =?utf-8?B?NWFtWTY0THNOY1NXRi9zejE4ellJeGNjVjhERHNYSnFINVNsOFlQY2xqUlRD?=
 =?utf-8?B?cDM2R1ZZcDhIakQ3Vjl5c1RCejMwWFhGbFRDOVBIZVA1WVVCbCsrN0c2V3I0?=
 =?utf-8?B?ZlZVWGt0aU5ydkFuTzVYWlBjSTFvSElCUEhNQzF3M2toc2pEWWtYL0xwUTAy?=
 =?utf-8?B?UGFQR001a1ZZSkt5NlVNTGZLRnhqNHlQdDhLYU1SZU52V01OVU5QRmQ5dEJs?=
 =?utf-8?B?M1ZrbGtKUXl5T2FaamFYQXh0UXpEWkVGY1E4b3ZraW1jbldFTElPTHd5WFV2?=
 =?utf-8?B?ZHN6NmdsNkdScm9OS0xyWmNqa1pXUVRGeE1Ua3FrSGRVMDdOUnJhUnhsU1lj?=
 =?utf-8?B?Z2pDUk1oWjJzb3E4dzAvRjAzeG1ZVm9aek9qNlV2SzZjdFJHdTV6TEV1RnAr?=
 =?utf-8?B?WktsbFRNSHNsa1dyNkxEays1VlhqV3drcGJKQjdNRlpSMFNLWXRvelJxVHY1?=
 =?utf-8?B?Y21oUXFvSEVKMEpkVkxvSXR3TVR2cURHRis5V2ZtMjZYbkphZHYwdVJhcFQ0?=
 =?utf-8?B?TnJ5U1oxampIdGVuMVVxUHZqRnlqY1FYVnEwNWRhaFFMRDNwUlZiYkJHOFJS?=
 =?utf-8?B?NlBTeU1GS1Y2Zlcyc2N1dml6UXJlWGdLUXhOV2N5bWtzUGlwZUJoQWkwQlQ4?=
 =?utf-8?B?MzdwbDlHRGRFYmVLYmh0RGpGdWNCdXlEanlNcXJKc1VTQXRVZ21EZGg2YzEv?=
 =?utf-8?B?N2tnZHlEV0wvc0ZPS0dWaGhWWlNRVHE3V3hRZz09?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 12:08:41.4709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae550fb6-9fb3-4962-1f81-08dddb2b4f31
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB2832
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

OP-TEE configs are enabled by default, change the doc to no longer
declare OP-TEE as optional.
Further, phycore-imx8mm and imx8mm-phygate-tauri-l use different build
instructions, so dissolve the common file for building OP-TEE.
While at it, introduce style changes where export commands are no longer
used.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 board/phytec/phycore_imx8mm/MAINTAINERS     |  1 -
 doc/board/phytec/imx8mm-optee-build.rsti    | 14 ----------
 doc/board/phytec/imx8mm-phygate-tauri-l.rst | 42 ++++++++++++++++++----------
 doc/board/phytec/phycore-imx8mm.rst         | 43 +++++++++++++++++++----------
 doc/board/phytec/phycore-imx8mp.rst         | 41 ++++++++++++++-------------
 5 files changed, 79 insertions(+), 62 deletions(-)

diff --git a/board/phytec/phycore_imx8mm/MAINTAINERS b/board/phytec/phycore_imx8mm/MAINTAINERS
index 7631e1cb331b608335620d0db49104459f673d1d..58c5e2d0af9fe404a5995fecc96cdbaa5845f979 100644
--- a/board/phytec/phycore_imx8mm/MAINTAINERS
+++ b/board/phytec/phycore_imx8mm/MAINTAINERS
@@ -9,6 +9,5 @@ F:	configs/imx8mm-phygate-tauri-l_defconfig
 F:      configs/phycore-imx8mm_defconfig
 F:	doc/board/phytec/imx8mm-phygate-tauri-l.rst
 F:	doc/board/phytec/index.rst
-F:	doc/board/phytec/imx8mm-optee-build.rsti
 F:	doc/board/phytec/phycore_imx8mm.rst
 F:      include/configs/phycore_imx8mm.h
diff --git a/doc/board/phytec/imx8mm-optee-build.rsti b/doc/board/phytec/imx8mm-optee-build.rsti
deleted file mode 100644
index c83de5cc7cf4a0229cbd89f4c7d2bfd8448cb735..0000000000000000000000000000000000000000
--- a/doc/board/phytec/imx8mm-optee-build.rsti
+++ /dev/null
@@ -1,14 +0,0 @@
-Build the OP-TEE binary (optional)
-----------------------------------
-
-.. code-block:: bash
-
-   $ git clone https://github.com/OP-TEE/optee_os.git
-   $ cd optee_os
-   $ make CFG_TEE_BENCHMARK=n \
-     CROSS_COMPILE=aarch64-linux-gnu- \
-     O=out/arm \
-     PLATFORM=imx-mx8mmevk \
-     CFG_TZDRAM_START=0x56000000 \
-     CFG_DDR_SIZE=0x80000000 \
-     CFG_UART_BASE=UART3_BASE
diff --git a/doc/board/phytec/imx8mm-phygate-tauri-l.rst b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
index 0d9e1024f8c5300e91a3a4c18b2babd5853a0824..4dd82cd9785fa585ed216664a25f593d4e723dbb 100644
--- a/doc/board/phytec/imx8mm-phygate-tauri-l.rst
+++ b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
@@ -9,7 +9,7 @@ Quick Start
 -----------
 
 - Build the ARM Trusted firmware binary
-- Build the OP-TEE binary (optional)
+- Build the OP-TEE binary
 - Get ddr firmware
 - Build U-Boot
 - Boot
@@ -21,23 +21,35 @@ Build the ARM Trusted firmware binary
 
    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
    $ cd trusted-firmware-a
-   $ export CROSS_COMPILE=aarch64-linux-gnu-
-   $ export IMX_BOOT_UART_BASE=0x30880000
-   $ # with optee
-   $ make PLAT=imx8mm BL32_BASE=0x56000000 SPD=opteed bl31
-   $ # without optee
-   $ make PLAT=imx8mm bl31
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          PLAT=imx8mm \
+          IMX_BOOT_UART_BASE=0x30880000 \
+          BL32_BASE=0xbe000000 \
+          SPD=opteed \
+          bl31
 
-.. include:: imx8mm-optee-build.rsti
+Build the OP-TEE binary
+-----------------------
+
+.. code-block:: bash
+
+   $ git clone https://github.com/OP-TEE/optee_os.git
+   $ cd optee_os
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          CFG_TEE_BENCHMARK=n \
+          O=out/arm \
+          PLATFORM=imx-mx8mm_phygate_tauri_l
 
 Get the ddr firmware
 --------------------
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.23.bin
-   $ chmod +x firmware-imx-8.23.bin
-   $ ./firmware-imx-8.23.bin
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+   $ chmod +x firmware-imx-8.28-994fa14.bin
+   $ ./firmware-imx-8.28-994fa14.bin
 
 Build U-Boot for SD card
 ------------------------
@@ -49,15 +61,17 @@ Copy binaries
 
    $ cp <TF-A dir>/build/imx8mm/release/bl31.bin .
    $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
-   $ cp firmware-imx-8.23/firmware/ddr/synopsys/lpddr4*.bin .
+   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr4*.bin .
 
 Build U-Boot
 ^^^^^^^^^^^^
 
 .. code-block:: bash
 
-   $ make imx8mm-phygate-tauri-l_defconfig
-   $ make flash.bin
+   $ make -j $(nproc)
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          imx8mm-phygate-tauri-l_defconfig \
+          flash.bin
 
 Flash SD card
 ^^^^^^^^^^^^^
diff --git a/doc/board/phytec/phycore-imx8mm.rst b/doc/board/phytec/phycore-imx8mm.rst
index 08f5949e02d8d2bfba71867d93c2b3ed8fdc67e2..d5edbc91474e95f677dd12e5fcc6c16092dea1cd 100644
--- a/doc/board/phytec/phycore-imx8mm.rst
+++ b/doc/board/phytec/phycore-imx8mm.rst
@@ -9,7 +9,7 @@ Quick Start
 -----------
 
 - Build the ARM Trusted firmware binary
-- Build the OP-TEE binary (optional)
+- Build the OP-TEE binary
 - Get ddr firmware
 - Build U-Boot
 - Boot
@@ -21,23 +21,35 @@ Build the ARM Trusted firmware binary
 
    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
    $ cd trusted-firmware-a
-   $ export CROSS_COMPILE=aarch64-linux-gnu-
-   $ export IMX_BOOT_UART_BASE=0x30880000
-   $ # with optee
-   $ make PLAT=imx8mm BL32_BASE=0x56000000 SPD=opteed bl31
-   $ # without optee
-   $ make PLAT=imx8mm bl31
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          PLAT=imx8mm \
+          IMX_BOOT_UART_BASE=0x30880000 \
+          BL32_BASE=0x7e000000 \
+          SPD=opteed \
+          bl31
 
-.. include:: imx8mm-optee-build.rsti
+Build the OP-TEE binary
+-----------------------
+
+.. code-block:: bash
+
+   $ git clone https://github.com/OP-TEE/optee_os.git
+   $ cd optee_os
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          CFG_TEE_BENCHMARK=n \
+          O=out/arm \
+          PLATFORM=imx-mx8mm_phyboard_polis
 
 Get the ddr firmware
 --------------------
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.19.bin
-   $ chmod +x firmware-imx-8.19.bin
-   $ ./firmware-imx-8.19.bin
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+   $ chmod +x firmware-imx-8.28-994fa14.bin
+   $ ./firmware-imx-8.28-994fa14.bin
 
 Build U-Boot for SD card
 ------------------------
@@ -48,15 +60,18 @@ Copy binaries
 .. code-block:: bash
 
    $ cp <TF-A dir>/build/imx8mm/release/bl31.bin .
-   $ cp firmware-imx-8.19/firmware/ddr/synopsys/lpddr4*.bin .
+   $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
+   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr4*.bin .
 
 Build U-Boot
 ^^^^^^^^^^^^
 
 .. code-block:: bash
 
-   $ make phycore-imx8mm_defconfig
-   $ make flash.bin
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          phycore-imx8mm_defconfig \
+          flash.bin
 
 Flash SD card
 ^^^^^^^^^^^^^
diff --git a/doc/board/phytec/phycore-imx8mp.rst b/doc/board/phytec/phycore-imx8mp.rst
index 50be99126537a2dc5323bd49c1513b196182c5f3..cea3a2835e69d6c6d3aa4c16698aebd09f73bf49 100644
--- a/doc/board/phytec/phycore-imx8mp.rst
+++ b/doc/board/phytec/phycore-imx8mp.rst
@@ -3,13 +3,13 @@
 phyCORE-i.MX 8M Plus
 ====================
 
-The phyCORE-i.MX 8M Plus with 2GB of main memory is supported.
+The phyCORE-i.MX 8M Plus with 1,2,4GB of main memory is supported.
 
 Quick Start
 -----------
 
 - Build the ARM Trusted firmware binary
-- Build the OP-TEE binary (optional)
+- Build the OP-TEE binary
 - Get ddr firmware
 - Build U-Boot
 - Boot
@@ -21,12 +21,13 @@ Build the ARM Trusted firmware binary
 
    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
    $ cd trusted-firmware-a
-   $ export CROSS_COMPILE=aarch64-linux-gnu-
-   $ export IMX_BOOT_UART_BASE=0x30860000
-   $ # with optee
-   $ make PLAT=imx8mp SPD=opteed bl31
-   $ # without optee
-   $ make PLAT=imx8mp bl31
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          PLAT=imx8mp \
+          IMX_BOOT_UART_BASE=0x30860000 \
+          BL32_BASE=0x7e000000 \
+          SPD=opteed \
+          bl31
 
 Build the OP-TEE binary (optional)
 ----------------------------------
@@ -35,20 +36,20 @@ Build the OP-TEE binary (optional)
 
    $ git clone https://github.com/OP-TEE/optee_os.git
    $ cd optee_os
-   $ make CFG_TEE_BENCHMARK=n \
-     CROSS_COMPILE=aarch64-linux-gnu- \
-     O=out/arm \
-     PLATFORM=imx-mx8mp_phyboard_pollux \
-     CFG_TZDRAM_START=0x56000000
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          CFG_TEE_BENCHMARK=n \
+          O=out/arm \
+          PLATFORM=imx-mx8mp_phyboard_pollux
 
 Get the ddr firmware
 --------------------
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.19.bin
-   $ chmod +x firmware-imx-8.19.bin
-   $ ./firmware-imx-8.19.bin
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+   $ chmod +x firmware-imx-8.28-994fa14.bin
+   $ ./firmware-imx-8.28-994fa14.bin
 
 Build U-Boot for SD card
 ------------------------
@@ -60,15 +61,17 @@ Copy binaries
 
    $ cp <TF-A dir>/build/imx8mp/release/bl31.bin .
    $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
-   $ cp firmware-imx-8.19/firmware/ddr/synopsys/lpddr4*.bin .
+   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr4*.bin .
 
 Build U-Boot
 ^^^^^^^^^^^^
 
 .. code-block:: bash
 
-   $ make phycore-imx8mp_defconfig
-   $ make flash.bin
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          phycore-imx8mp_defconfig \
+          flash.bin
 
 Flash SD card
 ^^^^^^^^^^^^^

-- 
2.43.0

