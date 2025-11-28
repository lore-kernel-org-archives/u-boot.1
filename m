Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2195BD116F1
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DFBA83B8F;
	Fri, 28 Nov 2025 17:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="RAUFAh8U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1E8483B9D; Fri, 28 Nov 2025 17:39:05 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD85583B86
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:39:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3SvxQHXNOaNU4lpvdRRzde+tnZne7awPMjTP/twG025sKry0/yjTEnh72wHRvLGdmI7+uXtpz/rBBN4dWNC9tVOs87S8kHU8bBE/a4hx5vmedpw9oIsGAxY10IQbeO5k7ylveJCDx6AA/F9rJnP+YrcqcTqB1zPqgCH74HCLlGk5PXjKGK8YkMcNAOtg6lnUyOA9KH4iTMsikkYXxSyqwpWrko3A8OmEUfYfL8+b5l05ZwRmQKQ2iFVN8qeJdiHCZqc8D/MVU8H7nrIwKuayxyPxNBvTsS6QwQbLCEKk4Iah8i0kwi6s8M8fMwiC+rf4tKubAOhrrBrD0yyRh3ZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGwKDfaQC51zomV6ZF1EkK8juod+AiltTEPxq4Nennc=;
 b=LVq6R/PRK8DLsQUGJQpla9W7fAR9mxcHaEfQHlPUh7hY5JMTvlg6twGuZwzIJ4LQPmDZdu6OQA2gwTtX8Jxi7SJcwiaomv1VDXgVBkE5PdliLbzWKx32pX8m+XFHyjga7v+ZMDxsFpvmvmxcxYqlGP1kfZriCeGbMdDUxjfpC+ZVylQ3j1gOPZNUXN05PrPkM5edawgqg86G+KrNkHAvx6PLeccjmqJGCDvec6eN7tEgKxk0dNXtp0g5dLdWlKAoWIaNQdcx6+sUj7owuc7Htcm+b86NGYxYQHuMim0Zj6Yp/57fu+m6GiYPA7Oe3KhA5qSz9VUiNhOXfGz8Lu/ZvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=mailbox.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGwKDfaQC51zomV6ZF1EkK8juod+AiltTEPxq4Nennc=;
 b=RAUFAh8UUqfwLd8Z8NIp6Mx0ip3a3sf3uzp3Q/BSq6zR87CZYbV6jG6Nyop06ud/PAjlOXFvJn7JCX+4mtkxMBW5PjpHIy03YINkMXTDUpm0w61oM2vxKJyA+/Xp/jULzKvIIyeQNbCz3yn+9wPbpQILWbS+TKFMqpsjMKu65OPK3yoPJ07iZRW7nOhX6wvgT1/llxYB/XVlmqw5uvl9nBWOIUHMiy0kElORCTU6HAkzW7RshRSZ5k8bq4PzT0THjv7WNOyrIyZIR/MqxhQUWxLYZcLz5Go7xGw5OZDLckqQTzHk7h590yjdqKF2GruzVmUJc0P64n+gepRynHXnQQ==
Received: from CWLP123CA0249.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19e::12)
 by AS4P195MB1599.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4bb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 16:39:01 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:400:19e:cafe::78) by CWLP123CA0249.outlook.office365.com
 (2603:10a6:400:19e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Fri,
 28 Nov 2025 16:39:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 28 Nov 2025 16:39:01 +0000
Received: from [192.168.2.141] (172.25.39.126) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 28 Nov
 2025 17:39:00 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Fri, 28 Nov 2025 17:38:43 +0100
Subject: [PATCH v2 3/6] phytec: set bootdevices and bootmeths in devicetree
 for imx8 boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251128-wip-bhahn-imx8_cleanup_env-v2-3-93ebfd1591c7@phytec.de>
References: <20251128-wip-bhahn-imx8_cleanup_env-v2-0-93ebfd1591c7@phytec.de>
In-Reply-To: <20251128-wip-bhahn-imx8_cleanup_env-v2-0-93ebfd1591c7@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>
CC: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>, "Peng
 Fan" <peng.fan@nxp.com>, Leonard Anderweit <l.anderweit@phytec.de>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Martin Schwan <m.schwan@phytec.de>, 
 Yannic Moog <y.moog@phytec.de>, Simon Glass <sjg@chromium.org>, Yunus Bas
 <y.bas@phytec.de>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764347939; l=3108;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=J3kK+ls8nP2nZrDx2+rNtt9FRtZue35P5z6jIrgErrQ=;
 b=quekXnAlOJ9yI6zRtijWC4hL7eEZk6oy3FZvz+bqKrxLzvU6EaoHsfH+L50xr2QrHKnE/9P26
 9JuDj7cMnvPC40FwlKlcMveGAWpp235FWFcwItKiUw6nqrTV3QPKFXi
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.39.126]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B0:EE_|AS4P195MB1599:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a158105-ae11-4bc1-5e03-08de2e9ca2a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0VLU0NTZTJXOHV0ZFFLMmh3VUgvVzNMUVJDMGMxSEVMdVJVUlhCK2drcEtj?=
 =?utf-8?B?b1VqM1FoWFhJMzdHMGx0eUZpQlVjWFg4MTErL2p4SVZOYXVPVEtZMHRJTzNa?=
 =?utf-8?B?bjJzRVgwc0pSdlJ6VHFqSzVQRXZmUUFLckVxZU1JTGZZLzZQenh3SDc1eUFV?=
 =?utf-8?B?eW1Qa2RaN3VnSEhkcWdPOTBQTWxEWS9aNWtmMU1WcGp2NDU3dFltZ3BjWmxO?=
 =?utf-8?B?VXY5bXQ1REtlMnpIKzRRekhDY2U3RGZUKzcyU293OXFOSDEvdXU0SkpVWE5i?=
 =?utf-8?B?YUxJSWFESmUzdmVFSzlRVmtCdFlaU0RtS3pVWnlaU0pSbHFMbnJpQjBkdzJU?=
 =?utf-8?B?d29Yc1lzRkZsa3V6UExHM01MWTUrQlZlNWZ2MW9tRUNkYlV2VnRMS01TUDIr?=
 =?utf-8?B?RkhsNUhjeitvcGhjVFVLQ3RjMDNTRkFUMlhhQU9xVWszNk9mT0cwci82S1I2?=
 =?utf-8?B?OXpHaVdQRWNia0dwelNEU2IvcFd2ZEl6YWliOFBwWVc5ZTA4YitKaDFDRDFp?=
 =?utf-8?B?WUloYjB3OTBwdUtIcS9yZEVuQlkvalZYaE0xQ1N0a3RWako1R3FyWVd1TjVs?=
 =?utf-8?B?MzNsNWxFUDNoZjlLUDl3QUZTbmlkallnRGU3QXcxRW9rbUh5SHZzZ0xrdXhE?=
 =?utf-8?B?ZUpNc3JpWUZ1d3owaEFmeGFnYmlSSUxBcTVtb2l5SlRmRWxIUkFuYisxMllF?=
 =?utf-8?B?L0FQTGhHUXhhczhveHY5MFlCMjZ3NldJb0FCRUVrMExuS0Y1VWljZnVkVDRX?=
 =?utf-8?B?Z0pGV0FJSngrNHdsTm9ZMEVzMTlOQVliTDJNdjJvdmFyUTBnaW9oZ1MrUmxl?=
 =?utf-8?B?OHgyNzdNUEhwYWpkalZXZ0pnRW1nbzMxTHJzamJXK1pDV2VGc0Qya251WHdo?=
 =?utf-8?B?cm1IOEQ0ekk1TC9vZVAwVVNqSE1QREJ6Y21Xc05zR0p5MTZPb0Q5S2J3Wk5i?=
 =?utf-8?B?UWZmOXdhOFAzSW1VcWdEU1YwU2VpVjZEcWkybjczK2s3SWRQWVJRRDE3TW9M?=
 =?utf-8?B?QkJmalM2WU1sWm1OQXNzS25kNkkwUC85cXlKdlhBN3BvUVFCVExZRkVHdHBp?=
 =?utf-8?B?Yk5TUXVSL3ZacEg4THgvSmozQnZlN25XTnJKTWNyNVRlOS9MVDZBQXFQOHJM?=
 =?utf-8?B?SzdTYWtRNjZPSG1qQzNtWTl1RkNHZlBYV3pZdEtKTG5SMVQ1dURyU3FDeXo1?=
 =?utf-8?B?OVNaS1duUHUwZWZXd3ZOdEkzaWtza2RZcldSNlRaWUR4emM3cjd4ejhCeklm?=
 =?utf-8?B?cmhFS0taUnFUQWlFMlFPOHI5Vm1HM2JaYTB4YkZxQVVkNHlaSllsdlZtaFFj?=
 =?utf-8?B?dU1EQWJMcWo5aCtUTTVPeGUycmtiaHY3WlZjaDA3YVRVVGJYQ2pVTk1nS2hU?=
 =?utf-8?B?WFF3MFQ3V3JReXl2Q1F5K0M1aDJIUmhIcVlIcjIyb2NUeW4vRk9aRmVUckpT?=
 =?utf-8?B?WkVaeU1JREpyRmlab1RnUXUvRUtGcFc2bm01cFpiay9NVzhQZUFWenZMc2pB?=
 =?utf-8?B?bVZBQUFQVHRiL0lEbHRIdUVEam1FVnZsRVZnZy93MjY2cVRodjI4R29yZ1JK?=
 =?utf-8?B?TXgyUHpnOUVNWXFvQmNqai9wRkM2TkFPYUNYRU5yK3NnYmRjVWhBc0Z4TGo0?=
 =?utf-8?B?bGo4N25kc2R3N2tWS0kyVDFtMEJOV3lFMmNvWWkyVmdCVlZ6dlJ3WDNRZUpk?=
 =?utf-8?B?Sk5rSGhDUmxJbnNQdnNUbE1MRjlZUS9xWER5Q3JCU2ljTU03MTlOd3FJb2pq?=
 =?utf-8?B?ajR1QUdZd1hhbEJiQkR0MGZyTllhUElHNTJ5U1lUc2tCcitENjR0M3BPZ2ZH?=
 =?utf-8?B?ZFVNUkZxUXhMUVM2T1k4bzBKYStRVS9IaXNVRllBZkRncFNZaVdMaFZMRDBw?=
 =?utf-8?B?ZXBscDRZZHVSSjlwemhhcDEvWjhkTCsyYThURXVSeUE3VjR6TWw1SDBzNmFt?=
 =?utf-8?B?NFJHak9IbzJvUVMzb1Y1NFhBMUJveUxFenFidENrUHBwTzBwMEpnNm9EUjY4?=
 =?utf-8?B?L3pLTXkzYzVJVG9iTTVXaVN4M0VFc0FmbjZ0MjNVNzBSTVZ2QUhIaEtMTnRL?=
 =?utf-8?B?TTFxRHhQZ09XWW1UaWpPQkw1cm8zSllyTTZKVlpETG9OeGtNSWk3ZjRqdW1w?=
 =?utf-8?Q?4hdk=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 16:39:01.1440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a158105-ae11-4bc1-5e03-08de2e9ca2a7
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1599
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

Standardboot allows setting bootdevices and bootmeths in devicetree.
This is already implemented for imx8mp-libra board.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi  | 16 ++++++++++++++++
 arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi     | 16 ++++++++++++++++
 arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi | 20 ++++++++++++++++++++
 board/phytec/phycore_imx8mp/phycore_imx8mp.env      |  6 ------
 4 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi b/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
index 512dbc9ee86a..143ce6a6d77c 100644
--- a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
@@ -12,6 +12,22 @@
 		wdt = <&wdog1>;
 		bootph-pre-ram;
 	};
+
+	bootstd {
+		bootph-verify;
+		compatible = "u-boot,boot-std";
+
+		filename-prefixes = "/", "/boot/";
+		bootdev-order = "mmc2", "mmc1", "ethernet";
+
+		rauc {
+			compatible = "u-boot,distro-rauc";
+		};
+
+		script {
+			compatible = "u-boot,script";
+		};
+	};
 };
 
 &pinctrl_i2c1 {
diff --git a/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi b/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi
index f59f119374f7..26361780c01a 100644
--- a/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi
@@ -11,6 +11,22 @@
 		wdt = <&wdog1>;
 		bootph-pre-ram;
 	};
+
+	bootstd {
+		bootph-verify;
+		compatible = "u-boot,boot-std";
+
+		filename-prefixes = "/", "/boot/";
+		bootdev-order = "mmc2", "mmc1", "ethernet";
+
+		rauc {
+			compatible = "u-boot,distro-rauc";
+		};
+
+		script {
+			compatible = "u-boot,script";
+		};
+	};
 };
 
 &pinctrl_uart3 {
diff --git a/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi b/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
index b4efff27a70b..4804a204e922 100644
--- a/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
@@ -12,6 +12,26 @@
 		wdt = <&wdog1>;
 		bootph-pre-ram;
 	};
+
+	bootstd {
+		bootph-verify;
+		compatible = "u-boot,boot-std";
+
+		filename-prefixes = "/", "/boot/";
+		bootdev-order = "mmc2", "mmc1", "ethernet";
+
+		efi {
+			compatible = "u-boot,distro-efi";
+		};
+
+		rauc {
+			compatible = "u-boot,distro-rauc";
+		};
+
+		script {
+			compatible = "u-boot,script";
+		};
+	};
 };
 
 &reg_usdhc2_vmmc {
diff --git a/board/phytec/phycore_imx8mp/phycore_imx8mp.env b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
index 1ebd9f06a0c4..f825c7bc61ff 100644
--- a/board/phytec/phycore_imx8mp/phycore_imx8mp.env
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -3,12 +3,6 @@ bootcmd=
 		fastboot 0;
 	fi;
 	bootflow scan -lb;
-#ifdef CONFIG_BOOTMETH_RAUC
-bootmeths=rauc script efi
-#else
-bootmeths=script efi
-#endif
-boot_targets=mmc2 mmc1 usb ethernet
 boot_script_dhcp=net_boot_fit.scr.uimg
 console=ttymxc0,115200
 dofastboot=0

-- 
2.43.0

