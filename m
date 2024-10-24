Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7645AD0BB69
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 07:05:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8882B88E2B;
	Thu, 24 Oct 2024 09:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="vULRBFLr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6037088D97; Thu, 24 Oct 2024 09:04:37 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20715.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::715])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AFFD89327
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 09:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zbm3eZ1VQBvT++Dy8HT7OK0RFL8h5qatSDJS3yg7CHsTxKmWyiVgMgop/s+QzNDUA3uh6mI9jjXItnbANOS1WeooiTtjl5r0zaloGcp4FzybE7LBclOSg4k2EmgIAlahCo52yTnywm0FieRRSUB67RzibiWTKvWK9UpYIXh59Ut5DJR2cP1oKOBqLJQiQU0W3KVXUKcGNrRLkvuMXF9KvbeSGq94ml67gY/8iQoYOsCvCzQiLQaeaKOzNsXDWW+M8H2MxvfqqkMJvmYOKlgyyUIAWrIAn1789FZ9WsakL7fz6NlUbdj4juRoVLCI5uYDxCft1wF+RBjQuYfcv5a+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6RfsnegSfNJujEGAilUTNgEWES82IFSgxU5jap4kh4=;
 b=Fj9AV/a5nex9hMV/bAkK3ltozyVJBZQ/Z2+xBlXas81VojGuc/jzreyKD85QfecIhvBP8Z3rU3iykcM/jsfMXUVRltNRlRzHyCbID5ClAdFhTx/qyC7LEymiodxdoAYCezrTy3zkWw7fSyBoJ3JHQzWcq5ze2p5UMj8ARzLGj1yfzUm8JG9Vo4wIa03gDnNU1z9K67vI/y9jOCU6v6QMDfxho1X6b7s8aSQBBYRTn4z/9/W6vCMpxTmzb7+mhYljI4Pg8o/pT43xgXL9ZxnIv3mHQF2lAZa5PcM20+CEFmumH0Wk3iUFZCbotoz3Jy4UZJzmBIZi5uGbnbZpFThM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6RfsnegSfNJujEGAilUTNgEWES82IFSgxU5jap4kh4=;
 b=vULRBFLrx2tPbQpKLm36NRRv1x+30c8hGTKpgavioOkVo8MaczQfRxX2ZMDBsrIBIjeKUmL/28CuXEPZ9RVompZMha3Udvho4DLxtwA/nDm3UMNj0c899SzHgQtU6CmVU+/NpnFlq1Vq4khl3P239qyvDsR4vZWmqYd1KwQaj5E=
Received: from AS9PR05CA0339.eurprd05.prod.outlook.com (2603:10a6:20b:490::7)
 by AS4P195MB2011.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:588::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 07:04:11 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:20b:490:cafe::97) by AS9PR05CA0339.outlook.office365.com
 (2603:10a6:20b:490::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Thu, 24 Oct 2024 07:04:11 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 07:04:11 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 24 Oct
 2024 09:04:10 +0200
Received: from lws-moog.phytec.de (172.25.32.62) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 24 Oct
 2024 09:04:10 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Thu, 24 Oct 2024 09:03:35 +0200
Subject: [PATCH RFC 1/6] arm: dts: imx8m: add fit optee node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241024-phytec_imx8m_optee-v1-1-fc6b78bf9a9b@phytec.de>
References: <20241024-phytec_imx8m_optee-v1-0-fc6b78bf9a9b@phytec.de>
In-Reply-To: <20241024-phytec_imx8m_optee-v1-0-fc6b78bf9a9b@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, "Simon
 Glass" <sjg@chromium.org>
CC: Tim Harvey <tharvey@gateworks.com>, Manuel Traut <manut@mecka.net>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.62]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B6:EE_|AS4P195MB2011:EE_
X-MS-Office365-Filtering-Correlation-Id: 28dfcbb4-cb8b-47fa-638a-08dcf3fa0ff3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGQ3RFFnZ29jZTZyWFpaMFZ6MGZPbVluTjVvVC9qaWVidXNEOVFhMFFPemZp?=
 =?utf-8?B?b1N4bG16b3NkeDlQcStHbHVxTkNIdXR0bEhwaFFFSXpnb0pNWllaZHp0Z1Aw?=
 =?utf-8?B?M1MyOFg5Y2RXa3p3aEFyTnlKcUh1KzZZT3MzeVFXNlpiVWl0UmdWb0JwUTNJ?=
 =?utf-8?B?elUvV1FZMHo3YTNXL3RPVFZuNjB0cDJicjVGUzBYVlEyS0g1YnpBYkdkbmJ4?=
 =?utf-8?B?NWp4SmhnZ3E4U3VINTJ2VnNJUXJaL1U1dDBtSjFvS3pUT0NZVjM1V0RZdVFp?=
 =?utf-8?B?YUZmczBiVnBSbUUzS2E4QU1HaGpsWEwzWjJBSTY3QU1pSGpoTk1iOHg1UXRQ?=
 =?utf-8?B?UXBiQ1JHNU1CZFZkKytCQjBPQy82NWttRVp0K1ROWlRZcDFxL1pETDRCcDBz?=
 =?utf-8?B?ZmVOZnNmcDhYV2RRWlJSSUpQcUhSV0txQ3FMRVdLMWRVeWYzQ2k3VWQrODN5?=
 =?utf-8?B?QkI3Sk1DOTRub3luYktiSUpaOWFUV0RXbEJ3RlFHcGR5djYxcTVUUGVwWitC?=
 =?utf-8?B?SEQxTnZ3QXBtQ2h6dlkrTHhZb1cyMnA0cVpZOEdVbktCdDA5SmxmeGdSZXll?=
 =?utf-8?B?T1gwSnZISVVFdXlzYVVMcjZFL1dJQWFrZlpleGFOZXFrRVFRc2hvVjhiRUZr?=
 =?utf-8?B?WFJCSktZL1h1alQyR28xeC9JSE9Od21RcXJwWVkxaDlNOFh2SGVrNEtpMFlz?=
 =?utf-8?B?ek5abFVYQ1A0MS9kVG5uSTg2RjF3UzdKYkEzTkhzcmxid3QxdUNGckN2MzJt?=
 =?utf-8?B?R0pKRzlpQjA4WkRtWkNZYnI2UkFXZEh0ZTBhamRJL2JLcGxza21adEphNVFM?=
 =?utf-8?B?OTVvbGFTckNrVTR0SkFyYkVKbkllWGc4OVYwK1VGVC9FZGN6S1llYjAxcWRo?=
 =?utf-8?B?bUorYmp3cTNYVEtYcm9obExhTVdRN2ZpSVZEelJoaHFaZ094YnZkV1JnVmRn?=
 =?utf-8?B?d01tK05KR2N3Z1RRUGw4aEIwNGEzK3lXYTVFcjB0RVArTDlsV2FTK1Nub3BJ?=
 =?utf-8?B?K2p3OFRlM2YzMWJMZ1FoNlRPMis5LzFtdHAyQlQzc1NHd1V3NkhoMDhzS0Vj?=
 =?utf-8?B?ZzN2NzVaTW43WDFjTWVuYW81OXo1TTFXV2NMV3pOb2xnSFhsZml3QkN4d3Uy?=
 =?utf-8?B?ZmFKbFh3R2s2dDM0amtjeFV2c0V0RjRmMUJCNUcyZlB6bnVqN29WcDlBZG0z?=
 =?utf-8?B?VFd4OFhnbWFrUFhDbUhZaEFjazlZVktTY3RKeUF3d2w4aHN5Vk1YKzBvVjRr?=
 =?utf-8?B?aVA2RlZVdXo3Z0pBZUdxQTJMUm1ub3FnTXVuaCs4VSttQXlORGFMUVFqSGVa?=
 =?utf-8?B?OXdrZjdhSlVsdFFwalltQ1UySUVoenZzTHUzbHFlR3cyTzRwam10anNtdXZ4?=
 =?utf-8?B?RnEvODdQUXduK0lhcFZwWDdvcTNkRGJTd1pVaWpwQ09wZWJzUWdESEtUbHI2?=
 =?utf-8?B?VTR1SkloSTBqS0QzVDM2WUpLZjM5Y09RN1ZCeWhuSTVNZlltT2prbnBXT3F5?=
 =?utf-8?B?VVFMNU55Wmd5TG9Wc1I0cEU0TkdrSEZYVm5jRlBGRjVyWVE4MUJ2bHlwRml3?=
 =?utf-8?B?YVJNeVM0cG1PV0x0eVRScDB6Vi9JU3hKaHZwZkV3TlJIR1RhTE92NmhzTXB4?=
 =?utf-8?B?T0JRUU96ejRVUVFpYVhmL2JINkRWL1NlSDg0SVdqWlV4Q3NGUDY1NitWK0pD?=
 =?utf-8?B?Qy9iVHZzdDBjWER2S3g0S2w1SzF5cWlScWxudzMvOWZiRlRJc2ZTajRQSk9T?=
 =?utf-8?B?clJpSFlldU4zZmY4T0orbUJaaEhkNWVxSDZhcFgxREVyNFA5VEFrNDRickRk?=
 =?utf-8?B?RU9RZHd0T2ZSRXR5S21keVpBd0Z2ZWtUd3FGVWJQTG5DVnhqN1hwbUI5bTFN?=
 =?utf-8?B?MjZYNmxFaExHVVdHWUw2OGRGSER0OTZydk54MnBIeDcxOVE9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:04:11.4437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28dfcbb4-cb8b-47fa-638a-08dcf3fa0ff3
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB2011
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

Add tee node in SoC u-boot device trees. Each board adds their specific
load and entry addresses for the op-tee image in the respective
board-u-boot.dtsi file.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm/dts/imx8mm-u-boot.dtsi | 15 ++++++++++++++-
 arch/arm/dts/imx8mn-u-boot.dtsi | 15 ++++++++++++++-
 arch/arm/dts/imx8mp-u-boot.dtsi | 15 ++++++++++++++-
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index d31bc822532..e7a6800b771 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -164,6 +164,19 @@
 					};
 #endif
 
+					tee: tee {
+						description = "OP-TEE";
+						type = "tee";
+						arch = "arm64";
+						compression = "none";
+						os = "tee";
+
+						tee-os {
+							filename = "tee.bin";
+							optional;
+						};
+					};
+
 					binman_fip: fip {
 						arch = "arm64";
 						compression = "none";
@@ -192,7 +205,7 @@
 						fdt = "fdt-SEQ";
 						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
-						loadables = "atf";
+						loadables = "atf", "tee";
 #endif
 					};
 				};
diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index 6875c6d44ff..bcb88f0a507 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -235,6 +235,19 @@
 					};
 #endif
 
+					tee: tee {
+						description = "OP-TEE";
+						type = "tee";
+						arch = "arm64";
+						compression = "none";
+						os = "tee";
+
+						tee-os {
+							filename = "tee.bin";
+							optional;
+						};
+					};
+
 					binman_fip: fip {
 						arch = "arm64";
 						compression = "none";
@@ -263,7 +276,7 @@
 						fdt = "fdt-SEQ";
 						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
-						loadables = "atf";
+						loadables = "atf", "tee";
 #endif
 					};
 				};
diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot.dtsi
index 56749ccacd2..7a9c616fb1a 100644
--- a/arch/arm/dts/imx8mp-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-u-boot.dtsi
@@ -185,6 +185,19 @@
 					};
 #endif
 
+					tee: tee {
+						description = "OP-TEE";
+						type = "tee";
+						arch = "arm64";
+						compression = "none";
+						os = "tee";
+
+						tee-os {
+							filename = "tee.bin";
+							optional;
+						};
+					};
+
 					@fdt-SEQ {
 						description = "NAME";
 						type = "flat_dt";
@@ -204,7 +217,7 @@
 						fdt = "fdt-SEQ";
 						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
-						loadables = "atf";
+						loadables = "atf", "tee";
 #endif
 					};
 				};

-- 
2.43.0

