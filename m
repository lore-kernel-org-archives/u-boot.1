Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A89CAC582
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 06:34:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68C8082AE9;
	Mon,  8 Sep 2025 08:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="nXQeOk6J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20FBD82B20; Mon,  8 Sep 2025 08:34:29 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20714.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::714])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C36AC82A9E
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 08:34:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzrdUBFPXT2UzCvsods4GyIgvbRsHK5JkRY+4B2OK+sll4n987KEScCENk6x/uATT4ppqGUVrVcsVXIhC93wPdulgyv8U3DdFeIBRynpXTWCsBlzPunukca3HdqmkLudOUGZDqNLQnEd8/9h2hsjZCDbG2sSDLkW0mRcBf56Op7DKvjw/wmWt0dLKqisoGNsN336dgt3HYLale4N34wcYAeW2J6lVqczJfXQV4Wecv6fUNiytctII27A1KK9Ux5/tU9xAtD/dOT5Us/bbcHNYBVgbwa8VrOCCKXrUb/uFloqAPgPU9f4MW0vj3j080BECliEMSN6qB57t8sNicOs1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnNd3gFy1moH8BC5/sjptVvUWFj7Tbp4cYRI6/4swt4=;
 b=bjRw3D0QSE3BOqRk8W474gxaYUzoZedE204ZcvXSn0kYsr8oloazeOzEcp/ot9ijmLwnCyySBvoL8VMiI73xHQ+FoWHDflMhIpAqQfWtHR6Zh7zdwjDAeqy4upnrscB7crqTMWo0fFUCS8Vgg3feE382pYncdunDpiyofvgO/v0hM5jdayer/sKnU7JVUN8Y/HnmnHRjk0K2khg1jJtFnwopqnNCoGe5hKK1m0jVsq1n38ki0/APTapkfMmbnX2APPdWlR2m3tzbo1KgPfAEGUetLC4oP6UOB/sntMuzBim4aXPhdNnoT1cCxXWyTfZ1xt4IJBAu2kzHeqlDGNr7GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gmail.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnNd3gFy1moH8BC5/sjptVvUWFj7Tbp4cYRI6/4swt4=;
 b=nXQeOk6JuEbjEofkXpQRoCMAoRMn0vjIbmygdd6sfQ5YK4t4A0njiCFNMclJRi2xwAinf9Qc87JBRoSN4f1AIoviYG+ka4XdcqmMi8/VkGpItaNby9SuHfdk0JM5PA4g7Tpr0SHf8aj2AefdL7kkGVggKL+YAV83VYLstasdga7wfSdcX1lCsdEAPJJNm3rfmWsz//TWTQ7mHZMXvzoFA+hWXk3T0Yqgs9pKScrCQvoGceoI6zh1esD0JKo+JPVJ1B4fYVTBLdV2b8i0b2AJ0OXEIMTXgyA9K99arNIg+l/ytrX3olkjDUwjeylmIjW/mNXp85P0cOw4bgq1we/+Ow==
Received: from DU2PR04CA0182.eurprd04.prod.outlook.com (2603:10a6:10:28d::7)
 by VI0P195MB2649.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:253::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 06:34:18 +0000
Received: from DB1PEPF000509F2.eurprd02.prod.outlook.com
 (2603:10a6:10:28d:cafe::47) by DU2PR04CA0182.outlook.office365.com
 (2603:10a6:10:28d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 06:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509F2.mail.protection.outlook.com (10.167.242.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 06:34:17 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Mon, 8 Sep
 2025 08:34:16 +0200
Received: from llp-moog.phytec.de (172.25.32.60) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Mon, 8 Sep
 2025 08:34:16 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Mon, 8 Sep 2025 08:33:59 +0200
Subject: [PATCH v3 2/3] doc: phytec: update imx8m docs for optee builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-imx8m-optee-enable-v3-2-14bfe249b3c6@phytec.de>
References: <20250908-imx8m-optee-enable-v3-0-14bfe249b3c6@phytec.de>
In-Reply-To: <20250908-imx8m-optee-enable-v3-0-14bfe249b3c6@phytec.de>
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, "Teresa
 Remmet" <t.remmet@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
 <j.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757313256; l=5768;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=Ivp7/2nnvP0/ZQm6Or14n1nMPRBE96OBfK5kwQjBydA=;
 b=b2je1SIQBjg5TBKzjA8ljhtQmaJG1FuCWNyXNBbNd/rHo71ACgsHjkJbjx6VrPd724B8TxJZx
 495RRXVrpUlCK5UKI1jkrDFCPu7dHO/LPS6TsQyA0xMaHaKR2Cw+taj
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.60]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F2:EE_|VI0P195MB2649:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d4b4ec-0150-4c74-c4df-08ddeea1bcab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDN4MndWK2NBQmhnMGtSRG4vS3JhTTQ0d3R1R2JMZkt6SE0xMjZtY1dWMVV2?=
 =?utf-8?B?VlU1c0d2Z1daVlZqM1lSQmJ3M2NDaDlhRVZlaCtSU3g0WEkrbnVjSE5XSXFz?=
 =?utf-8?B?cmtRS05pYjhqUlJPOGo2SXpaRDA5eTQ3LzhNR2ZhdGNFQW1qMkl1R0tBMzl0?=
 =?utf-8?B?SzllYml3TFNkZTdtSytjOHhOaGlscjdkalUvV0ZzcWtBR3QrZUdCOEx2dnBE?=
 =?utf-8?B?VkxuUkI2U3ozaXhGN1UvV3FNYnpYanR2Q2hFVnZVRWxNM0x2Vk45N0Z0SmpK?=
 =?utf-8?B?UXJBYmt5Z0s0VkdETnkzZ2RxNlVqTjlwV1ZhK1NibmJxYXJLcU1kZzlGT1dy?=
 =?utf-8?B?SkMwMXl0N09nT25YK3V1R3MvVkVza1ZTNXhNZ05Ia2dTdGExZkhENEs4NnN0?=
 =?utf-8?B?VjJKaG84c0ZVTTBRV3N6cWl5MFZ5UHozYXFyTTgzQUtNNWpIMVVJV29PT25h?=
 =?utf-8?B?Wk1XRlhiTmUzRmVnVnlnVkRSTlRabFRLWndQMGp3MWlJU1hHaytxT3RBRnh2?=
 =?utf-8?B?ZzJ5OHlGQ2RBWGV4MHcwU2NlbzRkc25pRjE2dU0rVFpuNjkyNjVvU1d6cDRC?=
 =?utf-8?B?RjdrR2FMdnNxMFhPMHVMODdOQUg0ejdiK0RTUGZZMjBCVUg5K2EySVgydXBO?=
 =?utf-8?B?UU13QUgwbE81bHJFdWZjcktpTEFxM1ZTU3NXMXFsOUNoYUwzMElQSVhJRkxo?=
 =?utf-8?B?TTlXQlNTZHJ2cDJ5WkliVWRnOVhQWWFyRTR1SENvV3dBV3dTcjNCZTY3QzBF?=
 =?utf-8?B?TEJocXdkRVB3N3hMSjB1V1lJdHkxUGVHTzBDSmlQUU8xbkJpdklCaVBCTENM?=
 =?utf-8?B?L2lKc1NRQkpGOUF0OEJIc0R1QTBlRnZNOHJkcWVORmkya2xscmtwMW1QMW1Z?=
 =?utf-8?B?TkVvSjJwM2FrVzRwZVA2RzQ2eUlvSE9DWjJBQVpPcjgxRHA1Sm9rVWxiYURw?=
 =?utf-8?B?NisrVy8veXgyVFJwWnR5TGh5ZjRpcU1nWDZwbkRaRnJQS01LV3lPdlhuaHhG?=
 =?utf-8?B?UVR6OHlndWdpYU96R3M5SXlHVmdGTjUrVUR5U2xsSnZtMkZtWkdtbEEyOG82?=
 =?utf-8?B?ZmpVRVN0VlRhYWovSjF0MEo0L25IU0VxQS93akYzWHJZNXppS1VIeEJWZkhh?=
 =?utf-8?B?SlRiTlhQaWxWNlJsaThoRkNMeDRrK0cwVC9ESFF0eTB5TEtzMTVUd0Fsc1Ni?=
 =?utf-8?B?bmRVRVZHSm9uMnBENjYyREpRMDh1Ymkrb1ZzRXpaVWUyY0V3SDdGVExSM1hN?=
 =?utf-8?B?VFhaRG9DUTgzUzI2K1E4RmRld2FMQ3lKSnhjVEFQc0FOZ1FsOWYrclE5eUY0?=
 =?utf-8?B?dloydzlTYytiVkZNZHNWVFdkbVFXRys0WDZCZmZ2ZzdsdFV2OEFCdVRrT1RB?=
 =?utf-8?B?T1VDMVdVNzdFdDNSaC9PVnNQSDZ4M25RS0x4RmlNS29HbWI1ZFJtbFpGaTZ0?=
 =?utf-8?B?dGNoUVRaa2YxVnlTV2hBSlBmaFlkQ3pjamV2NWtrUDhKU2xQUU52UkoydDhq?=
 =?utf-8?B?MCtlUVNMS3RxQWlDZHhJUDBQZ3RkcHU3emFXVW9oVkMzemZHUzdQck1DUlha?=
 =?utf-8?B?YTQrZ2wrdk52WHpwU3JYN2lkWnFtOWlVaGJxNCsvRzIxZVY1NERoOGdiOUJn?=
 =?utf-8?B?RlhEYm1DQytJQ0N4SXpMd3dqWDhQbVFUUjZvU2MwWFIzRlBpRnBzNzZESlh0?=
 =?utf-8?B?SG1HN3daS2I0UDcyemZJcjJVQTdSLzN5T2hZSE1zbUJSeHFWMkVnbW1NdkVH?=
 =?utf-8?B?Si8vYm5IRkhldTI5WHlxWEpLditqOC85N2VpSzNuQ2Y1MU1GSHlGdXhic09p?=
 =?utf-8?B?RjlVNnFNM3BGY3lDTHVBeFJHaDlMTU1XL2F0dDlsU1pkdTJ5eE4xekFrZGVH?=
 =?utf-8?B?RGpEdEkvc3B4Wm5WWm44MFlnbGdBTlN4QTRlMWVubGtRZVpvTm8yVGVrZS9v?=
 =?utf-8?B?eDJ3S3VBT09MbVpMVFhrdGsrU3hKbHRodkxaVURLNkJBeE5uQ0xMNUhxNjAz?=
 =?utf-8?B?ZHBpRmhQOUF3PT0=?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 06:34:17.8307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d4b4ec-0150-4c74-c4df-08ddeea1bcab
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB2649
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

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 board/phytec/phycore_imx8mm/MAINTAINERS     |  1 -
 doc/board/phytec/imx8mm-optee-build.rsti    | 14 --------------
 doc/board/phytec/imx8mm-phygate-tauri-l.rst | 19 +++++++++++++------
 doc/board/phytec/phycore-imx8mm.rst         | 19 +++++++++++++------
 doc/board/phytec/phycore-imx8mp.rst         | 13 +++++--------
 5 files changed, 31 insertions(+), 35 deletions(-)

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
index 50be99126537a2dc5323bd49c1513b196182c5f3..e1385be25e1a862db7021e29cd5d0d3ba68cc01b 100644
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
@@ -23,13 +23,10 @@ Build the ARM Trusted firmware binary
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
 
@@ -39,7 +36,7 @@ Build the OP-TEE binary (optional)
      CROSS_COMPILE=aarch64-linux-gnu- \
      O=out/arm \
      PLATFORM=imx-mx8mp_phyboard_pollux \
-     CFG_TZDRAM_START=0x56000000
+     CFG_TZDRAM_START=0x7e000000
 
 Get the ddr firmware
 --------------------

-- 
2.43.0

