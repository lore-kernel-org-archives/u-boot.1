Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA11CAC583
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 14:06:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA85E831B4;
	Tue,  9 Sep 2025 16:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="c9wmWwx3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 611F18309E; Tue,  9 Sep 2025 16:06:23 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2F1C83106
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 16:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aE1e8DEwJUZvTzM9P34eIxcvQ5oj9jtsoUaHK/0hywWF57y06dhUpP2Ku7RMbk4AG+ehae6WQG/b5gDrVicYqO0glgvpor/EuotDf+QgWi6C+54/4ZGsExdIuLTwYnpzFFovkbWyB4DI/UOz4Y+15a3kVu5lR5khUhMdh9CPubJrW9SdJs2tOH/qEyLTDbOf/6uU05Np+gLgtMFn0S4E97h3c9W5YJ9eU0cu9Nv2geupz7b+thuad4LE2VfX/qWKNquG1raODINCYJtq1XnfH4TSLoPSBxD3yRkg/YyIgJ9UVo9pJp7ghCMBwnu+QEq67huDCFkO/BYbHWFLuYZYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+S76vkCVNSWJ+It9rdwJoJ16FKMw1ND1l6OpgT9F5I=;
 b=Y2EfD8AOET0jB2MXhpuXZ4mwbwjbG9XW2ay7qKKdMce2NieU2uRRutUQ0efbmHGQQXRjBphshyXAzbFZHCl6jBrgsWuwz9v/SW4KFTsDDF3rze1joDy+vYU3svt3yukyVJUNRWJTtPg0FJjN57pQZWXM23MbhxubCfho0rKWr7owsGnfecxO4szj8TFJ/+dKDvFfv6U4YspvsBl08Et5v7GsGAQi4qMtw9B9ORlJqwNGQbEj/l566yT/JSvJd+/PSFxIdqoNiJRfhlBhf3v5fs0bZXfpJ5m5WIfm6gDXmb9Ex7KNRGh29pgHePsz8b2uc+IHZgQqVZwj3g02dgLmeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+S76vkCVNSWJ+It9rdwJoJ16FKMw1ND1l6OpgT9F5I=;
 b=c9wmWwx3I2s8PgbAfxKTEHD2yLNDBPI6hffKnc4yNF5pGcqctC+9aa8S5Y53GOiUNHPQ8XiDMbJz7a2B5ylMpAnA1U0hjXUAekogoUdRpmAj2KQcZTOeSDCzY7IAG482UqFqoh9HLWnZRdTw9atBSPZEMo98ZXJUI1jPTT46v/rNBtPN3b1a/yAyLMctZSs4GCWLshcxfjMjHTq2ApV9ByEzlK8+dEB2Rm0zudTf5G2lW/5Uy56K3Koieo/QKNBmsgD2rqwvrMz1TzeSY2TyHfUxMmnby+6YlUkXVnFGcZa9vX0ChPHGFrdyFuiEEUc//BgVkQHkhFZEtRIiOMUYTA==
Received: from AM0PR07CA0003.eurprd07.prod.outlook.com (2603:10a6:208:ac::16)
 by AS4P195MB1525.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 14:06:12 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:208:ac:cafe::a4) by AM0PR07CA0003.outlook.office365.com
 (2603:10a6:208:ac::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 14:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 14:06:12 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 9 Sep
 2025 16:06:11 +0200
Received: from [192.168.2.142] (172.25.39.168) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 9 Sep
 2025 16:06:11 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Tue, 9 Sep 2025 16:05:40 +0200
Subject: [PATCH v4 2/3] doc: phytec: update imx8m docs for optee builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250909-imx8m-optee-enable-v4-2-6dfe494cc939@phytec.de>
References: <20250909-imx8m-optee-enable-v4-0-6dfe494cc939@phytec.de>
In-Reply-To: <20250909-imx8m-optee-enable-v4-0-6dfe494cc939@phytec.de>
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, "Teresa
 Remmet" <t.remmet@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
 <j.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757426770; l=6567;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=bPKStizB2/CRgOV/SeENkPmSqKw6/etI34KICh5xFi4=;
 b=quhvh6tFqZ9rL0YRyAEEyhyYkLLXTnj0aqf2RaEiqnWMlJwFfBZF0WWBc40M+1iGyK6mMD41S
 +Spret5jILqClxiNVM/OLNpKod1C4l5IYwcFB448gA4gNPFdYKtUOtA
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.39.168]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000193:EE_|AS4P195MB1525:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a944fa6-cdd6-4d62-3f7a-08ddefaa08b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnU3bXNMWkNSRnpyNmt6cnN3KzJXamJ2YlRVbEVxeG8xSjU5cDdIZGV1Ri9L?=
 =?utf-8?B?L1RKakQ0cXZDS3J1YzRkWG13OGRIaThzMHFuNjVvVU9vODdSbTFUNTB1OStp?=
 =?utf-8?B?VGRKdFNCUUEyN1dIdkY3d3ZXbzdSVC9aclZWRlNCTE5TRmlVMjhDOFBDVnVq?=
 =?utf-8?B?ZG1RbkFCTkdSdHhwZzBpcWhKeXVzcC9IYm9GY0h3QVNqYXhORW16WURDMTJz?=
 =?utf-8?B?b25Sc01oZHp6MmV2MW1IeVIzVHpaRFoxbHMwcVEraVdnRURzalk5djZFSTRL?=
 =?utf-8?B?ME1YZVRiVU9UZ25mUDZMV0oxSnRRdFh4TjN2U1RKZ25uOGxRK1ZtTHRDNlZv?=
 =?utf-8?B?M0l2MjQvblA0dDdMQ3Q2RnpCaExRRFRSdDRLWHBYaExicHo0R0RCOFY3VFp0?=
 =?utf-8?B?MkprNnVBNkpza0pTTmI0a0pDaFArbTM2VkpNTEF2MVFRUHFMVzBtTXI1TlUx?=
 =?utf-8?B?M0pqREZuRFQwQndmQnhjRmkzQlJqVDh2M3Q0YTZabHdPZ3d4M210TDlldExT?=
 =?utf-8?B?U0lqeHZCc2JsSU91VzNjME1aMmhRZ01EZm9GSFFXNTNwVDlxNTc3b0tZckR5?=
 =?utf-8?B?bFJLWTdLMmRUU3dSenRmT0t5QURpUXB3cEZBc3JwbE1XeEFvVStrWEUxU3R3?=
 =?utf-8?B?aTgzZ0laUGE2WWp1ZFpKRE5pYnZaVDBDemZZSGthMWtGVVBTM1NtL1Qrc1Nq?=
 =?utf-8?B?czhtcGsyNVlCYVdpVDdlUlhWZkpqV0Q1ektmbnc1STRYa1h2Y0J1Z2MrRXJF?=
 =?utf-8?B?NmJTdjdXUEpROUJTNnZ6aU1icCtRaDA0blpYakdqUWVpelN6akdmeHNFNzZa?=
 =?utf-8?B?dHpCM2VCMlVFM09DcnI0a2t2c1hNclg1SmljNHZpOEhONVlSempnUE5QZGFQ?=
 =?utf-8?B?cDJFd0x5dFBaeldVTlJ1UEtneTNOZHN0MzdNbDhGTVU5VFpkeTA1YldhKzFm?=
 =?utf-8?B?UDJtS0ptM2lvT3hlMm50THJqYUorYURmdjhrUWpDd1BGRVpLUndEZGMzWFhm?=
 =?utf-8?B?UWorK1JFMGhYWVh2THBsY2M5WmlYcWRYcVlDcXozNms0aE5veU9kNGxzY2FL?=
 =?utf-8?B?TkkreFdlRlJSMU0rTzA4aHRTMWpPRnRMeXdJSFJodElXUlJaSVFrdDJUKzdS?=
 =?utf-8?B?U0o5SU9yN1cxY2o2RVRFVHVKREV4ZVZoVjIwdTUvMFMvQmV5eW1XdlB6WGFQ?=
 =?utf-8?B?NVIxWHlxdHlmeUdMQ1hIdXoyKzJKWGRlSkVTR2ZjRUx1YW5ZcFZLY0N5Wjdv?=
 =?utf-8?B?QVNnclpIM0loVUtITUNWYWswVUNrU2ZvcFZMY0pka2dFWHp3MzNXWi9mZ1ZI?=
 =?utf-8?B?VUYxQW5ySmsrV3h3SzhyVkE5VDZ2L2JpMTZBb29KKzdUeHh5a0tZK1ZQTjZC?=
 =?utf-8?B?TTJKVDJsUngyTUpFdEVHUGp0enpXekhDNVM3WTJXUUNXYU1uS1M0ak95VnJV?=
 =?utf-8?B?VW5OUWNBZTlOTWNZeUExT1pLWnBMSzhkNm4wdExxWElDa2RaK3QrWVU3TG1O?=
 =?utf-8?B?aUtRaUwzLzUzRTZLTXdMNVREWXVVMmVwTjJjLzRZdVp4ejM5d0cwRFVwdzB6?=
 =?utf-8?B?YVBiajNhV2RuOEFxMUlqbERkT2lSRy9NbnNVUVBHbnd6MHFZelV6V09XNER6?=
 =?utf-8?B?WnJseUtoZXY4eGxVUjJBL0U1amxJeVlsdVNXeDQ1TWRQTjZPaHA0alpic3lV?=
 =?utf-8?B?WWltaFI5a0NzV2dzSWh0OWtvN2tDSHVHYzhGaE01eFlrL0YvbGVYWDVWalFI?=
 =?utf-8?B?SGJyL041eGlwM1JITktxZUFJeXpNMTdxNEdHR0NDYVE1OFVHaGZra1hxaVJv?=
 =?utf-8?B?TnZXMTc1SHFlS0ltdkxwbjdlb2wrM2JWSkJQMzRFWU1GakNBVWd6Z2ZMNm1m?=
 =?utf-8?B?dTYrNFhBS3F1ek4wRFZydXE4Ui9Kb3dFNklIQldBVGh1c0EyWEtFZHJVR05C?=
 =?utf-8?B?Z2JlWHhzdXliVEQvTk9hWFZVaFRoSWlNS1I5WTNJS0NvK29zcWNWeFZYdW9O?=
 =?utf-8?Q?eRqXnxexhmhAgOUKgW5C4rb3Lh6yb4=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 14:06:12.5480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a944fa6-cdd6-4d62-3f7a-08ddefaa08b3
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1525
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
declare OP-TEE as optional. Also remove CFG_TEE_BENCHMARK as it is no
longer present in optee_os.
Further, phycore-imx8mm and imx8mm-phygate-tauri-l use different build
instructions, so dissolve the common file for building OP-TEE.

Reviewed-by: Teresa Remmet <t.remmet@phytec.de>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 board/phytec/phycore_imx8mm/MAINTAINERS     |  1 -
 doc/board/phytec/imx8mm-optee-build.rsti    | 14 --------------
 doc/board/phytec/imx8mm-phygate-tauri-l.rst | 19 +++++++++++++------
 doc/board/phytec/imx8mp-libra-fpsc.rst      |  1 -
 doc/board/phytec/phycore-imx8mm.rst         | 19 +++++++++++++------
 doc/board/phytec/phycore-imx8mp.rst         | 16 ++++++----------
 6 files changed, 32 insertions(+), 38 deletions(-)

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
index 0d9e1024f8c5300e91a3a4c18b2babd5853a0824..7efc9392361b4a867ce2bc18db11aacf31208800 100644
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
@@ -23,12 +23,19 @@ Build the ARM Trusted firmware binary
    $ cd trusted-firmware-a
    $ export CROSS_COMPILE=aarch64-linux-gnu-
    $ export IMX_BOOT_UART_BASE=0x30880000
-   $ # with optee
-   $ make PLAT=imx8mm BL32_BASE=0x56000000 SPD=opteed bl31
-   $ # without optee
-   $ make PLAT=imx8mm bl31
+   $ make PLAT=imx8mm BL32_BASE=0xbe000000 SPD=opteed bl31
 
-.. include:: imx8mm-optee-build.rsti
+Build the OP-TEE binary
+-----------------------
+
+.. code-block:: bash
+
+   $ git clone https://github.com/OP-TEE/optee_os.git
+   $ cd optee_os
+   $ make CFG_TEE_BENCHMARK=n \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          O=out/arm \
+          PLATFORM=imx-mx8mm_phygate_tauri_l
 
 Get the ddr firmware
 --------------------
diff --git a/doc/board/phytec/imx8mp-libra-fpsc.rst b/doc/board/phytec/imx8mp-libra-fpsc.rst
index 26752ac1882f99cf5ad22f8cbe0af77a6bd41d25..87b7a99ee710f7dd90fdcb7d62b9b451b895b8df 100644
--- a/doc/board/phytec/imx8mp-libra-fpsc.rst
+++ b/doc/board/phytec/imx8mp-libra-fpsc.rst
@@ -40,7 +40,6 @@ Build the OP-TEE binary
    $ cd optee_os
    $ make -j $(nproc) \
           CROSS_COMPILE=aarch64-linux-gnu- \
-          CFG_TEE_BENCHMARK=n \
           O=out/arm \
           PLATFORM=imx-mx8mp_libra_fpsc
 
diff --git a/doc/board/phytec/phycore-imx8mm.rst b/doc/board/phytec/phycore-imx8mm.rst
index 08f5949e02d8d2bfba71867d93c2b3ed8fdc67e2..ba6299a968ae9980d583b87b46dcccba5aa4a186 100644
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
@@ -23,12 +23,19 @@ Build the ARM Trusted firmware binary
    $ cd trusted-firmware-a
    $ export CROSS_COMPILE=aarch64-linux-gnu-
    $ export IMX_BOOT_UART_BASE=0x30880000
-   $ # with optee
-   $ make PLAT=imx8mm BL32_BASE=0x56000000 SPD=opteed bl31
-   $ # without optee
-   $ make PLAT=imx8mm bl31
+   $ make PLAT=imx8mm BL32_BASE=0x7e000000 SPD=opteed bl31
 
-.. include:: imx8mm-optee-build.rsti
+Build the OP-TEE binary
+-----------------------
+
+.. code-block:: bash
+
+   $ git clone https://github.com/OP-TEE/optee_os.git
+   $ cd optee_os
+   $ make CFG_TEE_BENCHMARK=n \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          O=out/arm \
+          PLATFORM=imx-mx8mm_phyboard_polis
 
 Get the ddr firmware
 --------------------
diff --git a/doc/board/phytec/phycore-imx8mp.rst b/doc/board/phytec/phycore-imx8mp.rst
index 50be99126537a2dc5323bd49c1513b196182c5f3..df087072062a0b8ca2179fecaead4fa3d0b9eff4 100644
--- a/doc/board/phytec/phycore-imx8mp.rst
+++ b/doc/board/phytec/phycore-imx8mp.rst
@@ -9,7 +9,7 @@ Quick Start
 -----------
 
 - Build the ARM Trusted firmware binary
-- Build the OP-TEE binary (optional)
+- Build the OP-TEE binary
 - Get ddr firmware
 - Build U-Boot
 - Boot
@@ -23,23 +23,19 @@ Build the ARM Trusted firmware binary
    $ cd trusted-firmware-a
    $ export CROSS_COMPILE=aarch64-linux-gnu-
    $ export IMX_BOOT_UART_BASE=0x30860000
-   $ # with optee
-   $ make PLAT=imx8mp SPD=opteed bl31
-   $ # without optee
-   $ make PLAT=imx8mp bl31
+   $ make PLAT=imx8mp BL32_BASE=0x7e000000 SPD=opteed bl31
 
-Build the OP-TEE binary (optional)
-----------------------------------
+Build the OP-TEE binary
+-----------------------
 
 .. code-block:: bash
 
    $ git clone https://github.com/OP-TEE/optee_os.git
    $ cd optee_os
-   $ make CFG_TEE_BENCHMARK=n \
-     CROSS_COMPILE=aarch64-linux-gnu- \
+   $ make CROSS_COMPILE=aarch64-linux-gnu- \
      O=out/arm \
      PLATFORM=imx-mx8mp_phyboard_pollux \
-     CFG_TZDRAM_START=0x56000000
+     CFG_TZDRAM_START=0x7e000000
 
 Get the ddr firmware
 --------------------

-- 
2.43.0

