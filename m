Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1095CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 00:27:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0970D849AE;
	Tue, 26 May 2026 02:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="xBeEFVio";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9584E849A9; Tue, 26 May 2026 02:26:33 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F55C84996
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 02:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHWvBPABZCZjcyGj701HcdZHRywMWIZosPzSvOxZJpEX/xvolYR5LmZjk4kVImD1Lh/dCwhwjiiGUiRwet5i2cbXeMv0ZHwo3hEqUQEzR3WpOk3ppdKiEjNmsBEPs0FpFxkHKxyWXIOIRKHQAXGPrgoIuXRaKZOjD/iiAJrR+KaRFzU4DoSBbjaXQFr/P9FqdnjVFrJyiu2JEJW23/79u6IELJYx99qHjFrUcxO/AcUrwymjzvFpQuKnA00c1v2Cg2WxhAKDpq8ALJ5SfnNT4YKJbHnfQSZRDQmQPYh0RWRH/VNZB8XirYbrvIJVb1Ql+T0+hWw9tIifHvYuXwOcpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=653BAny0uqk0VBQm0VVkoZtKncAFX45svUdyJLVs1T8=;
 b=QFUFgMlyy8fL9XLo2yqXLTik4J+FSZhCV9oflSUQLF0B3cb9C0+1RvjXFnBE5i4QwgZTb90cz5zktDto1BvlaUPI70noRiO0gk5LUMsVDGBX5QWVQyC56M9vV+r2VZGEW20bNVTKDm076OsTopHr7KbyHvraFESDx/LzXdJv3gNmB/b8sPNJrP2El6lmZlAhrvOyiY630jj1ZkNMeLfCu7jempVouOkpv/Jr4jEesYjKzr0eCQLVg+0dj7yxRVcwlDBWltewVT3pySlADbOHiKYmRcvEMKjggxWLVQ5TLqcbBIED8i57Ccyo/A5E2u5SRgvx+siTAoZUNoKKqZAXdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=653BAny0uqk0VBQm0VVkoZtKncAFX45svUdyJLVs1T8=;
 b=xBeEFVioAi/Irfh20ZEVFNKVYMKsEYLcFLH9OEpU8hw+ZP5vAUCsEM5s4ARaMbwOR5EbkToyfcz8RldMZlJf88x3l2UQt9txDhu4rXInOYV+tIRapfp1a3u9u3quLurIfn81sXTQl56oZHHsUwRtnM7Ld27LIsW/w1890j1yLEMzmH97GNyotzhNPzcwYxGRE4GXQO99xs1thVculU3vYaRA35/FXd3KenZyQDKhDQHo5g3xcr2hasSgC4FREWOfrwO4AsbYpP84mteg9lP9wpj+IrV871tFlfVvO5IN+Ql1NUtFoYUxZxzh0clfyRmAm/K8sZUhTkJs4dEOmuh3ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB7682.eurprd08.prod.outlook.com (2603:10a6:150:61::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 00:26:26 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 00:26:26 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Anis Chali <chalianis1@gmail.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v10 12/12] arm: dts: en7523: add pinctrl/gpio support,
 drop legacy gpio support
Date: Tue, 26 May 2026 03:25:34 +0300
Message-ID: <20260526002534.898340-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526002534.898340-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260526002534.898340-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0039.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::15) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 530046dd-da26-499c-e1ac-08debabd6c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|11063799006|18002099003|22082099003|56012099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: sOCCHiL6KWl6HzanbzziOREQpe5a3JHfKPPngxquIEFu6XJ0BZhPomHIzAMAM+Fuw0uHlflcOmGPSaYY3fp1aFlEr/VG1+GbpI21IBXJfTEPjMSN69vgR7GwbStqC/6byIEBSm6dYX642zsK/bn6xLMh/ncXf+9js+RVWGXOtFVlWT7W021hyg2KeuxovZBM3ZgopYi09EgxLXwQvfUJOMW1F08zdlsFU2/r12sC6wFHDwGOr9axOvUrCK1+WIMGvaEijrZa8SfygjV+YQyPkxObqUAQ2WkedwVHYtX6m7lofBIsi4NeHz280r0OxndNhsovlUNH0TMkf+N3phFAB6Pm4npxE/rdpvTIK9imVUCLq50XPRwEC/P3PG5bHLoWl5AE+oSg9IGqLrBVxLbJskuZcWblK7H73nvBmJ1rHb+pXSOLFsLyieJ1muLCs2nnZRlWow/MBF+zRq9oiiBwEpy9fFo9nz2MciKRzWiwqobrQRDgSWUG664mfZO02Rke80vqit4xsZOr7EA5zuobRAfrtme7zKuMBgyCkDSBjjMV8nFEZW8rqZgAU4iCal+ZpUSsAjeYviTB7qZ/bzGZoW8AKRl6tU/JWtTkem1J1Xbtxf3J3ce52DoMdf9ZHYgb9PdH9JE+uu2Hk2a1y9yLDlUehLsw1k8xblGM7Z9lXPuT7MKnBZOx5InESMfE7A0Y9IsOvq9RSZ336ae9nIls6tR4aFyi+LuksLHEakjyIHcyv1/7BGvUDIoAtXyNVoqprI6HtGJ9fIpKA6FgldmSug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(11063799006)(18002099003)(22082099003)(56012099003)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r8AWlmu9yaVyUDWfVZrQ5PwsSneqVAKe3yx2Wm7XQlUlSdDsqID725INl9Tk?=
 =?us-ascii?Q?puXYvnpR/PYUGw+KujS8oGsHRtBLI249zzFAhrNBwDLyPBsdMxIjDUWLflKV?=
 =?us-ascii?Q?YLnE+CqmK2A2C/wDUz/LRXL0GA5XBMokmd13K5xm/zQTMLhvO+TLGDlhgyVq?=
 =?us-ascii?Q?p96i36UKlIYC0Ps+XJqZZakthUXYQ5XMgXZTOqP15l3g6izxCD1uT65g31IL?=
 =?us-ascii?Q?Gh50ZcZv4GHA017ZbmFKPTokfqyfr+3W1dM1QgEMcr63ARHBkqJn80zaw8mF?=
 =?us-ascii?Q?K8ZwkUE31K1mjOaBp2zJl3sjcy9VwEamVAxlJV3wefH7OeoeSIQQJn+biicm?=
 =?us-ascii?Q?jWRFN4+98CvvIXsSOys/fLDG8+naCCIWKCJUV2SoQJx08uQPty+MqsMeQYRW?=
 =?us-ascii?Q?ghFUoewd6VCrvASvS7qF9uUrigT9zTM8LZUeb/Frf5nSkZ4VI5Hwa3Wm7CHv?=
 =?us-ascii?Q?I3/H6rGKhkfsyL8TpnA2zrADokXN/se0tJ6C7bw1/mqO9OmwTzkDb2LIkWH7?=
 =?us-ascii?Q?2JRmvb8mrq7rPdt3pM8P2RkJkw7u0tE7y8MMD7688RL7e5LzRZXdW1R7FE2O?=
 =?us-ascii?Q?xN7D1lOTcXTi/r7IZhRqJ4qWUrHj8YXObXHFz1NSdhtYJ95DlOfWbpbpYWYs?=
 =?us-ascii?Q?h7HiNJWY+8HKuq5OaYvZTiSwkN3Wi6QgWnue0fMnXUrRavVO7fohq+2f7tT1?=
 =?us-ascii?Q?I9vi+Y4s5c4YYJmvPkGM8CToH9vwkEZQfYBsWtwI0RdT/M08rop6m5/3I0Ua?=
 =?us-ascii?Q?wygRaCODsNM63jOjuH9Wt8LrJ/hZvgMKVgFUL3gGCOEUC03mM7Qkr4l/a5hX?=
 =?us-ascii?Q?ehjSxhbHc7HXNbhKzAOaQrZF5S+Hc2CUcBon9Fug/u++aB3U9CV3mKA0jCYw?=
 =?us-ascii?Q?V7b2mf+kjNrVrCwfdbZAzO7YeH63pl+McUAY580w+SeY8n3Woy/RgRY/WQCn?=
 =?us-ascii?Q?7VXW/cLP3uic3NQV19NBRCLir7mFFV2mc7hHHkcU3C5oVu894L1vdoyWtds4?=
 =?us-ascii?Q?ud0qEYijOnzp8KSgejC3VgttCwSwWiRb5R/BEPm1UlwAhsgL7MR/YwSkU2aL?=
 =?us-ascii?Q?E2RFe4ofAE47b0WAa2vOHsvOQzpo+hs1Wj0ZqPjMDleTPWs9xGAuPtyPT3sa?=
 =?us-ascii?Q?IngFZSSrAuOTkHiJHqDR95XdQXPieGn7RF+dQxhXXlxfIRlcTgeR7E8WmdEC?=
 =?us-ascii?Q?vwvU9Pb3o7RH3+Sys+LFtEQfS6omxx+wk+k6hHbRLC+TZxgNx9zKHojv4dKe?=
 =?us-ascii?Q?w9dM3rUx5ygpi5max3FqnOaJt6gDVkAaqal0AkRLmq1qk9UPJ4eBbHBfs56E?=
 =?us-ascii?Q?9RF8ubeik7Uje5e5aLw2K7wzwWATGZOUXrSU9jR/SHBiIPrTfSytDe83XoKz?=
 =?us-ascii?Q?c1AWr8xzPQqPA1eSi1MbCusAvTx2fAQchL5Al9QmLfEyoOj3nOsa/EUYa+aM?=
 =?us-ascii?Q?BljD+Po0QnZdf+0OpoolwzAQTryMCDQJ0lZT8ghUOw9dBsefZfqyyojh6g9v?=
 =?us-ascii?Q?wclYgikToXdmzHJe/fckJb1ZtojZNkhn6AG9ZIXCMemaPdRzJtHBIRnkaDWW?=
 =?us-ascii?Q?10RIEkILSJEapFed73GPqrXbJ9qyX/7bB/Mut5HzeiOXNRr4oghLVuLm+W9u?=
 =?us-ascii?Q?KsUn95O2jaS//SeG3f1/VF58oZoU88yLxyoz7UFxb2SIdepKelChRUoZmdT8?=
 =?us-ascii?Q?/d6CWJsse7SsCR7EVgSWW1gCOoaTwXpCZWZCSdNnYAWMdaVO2HgR3iiHPxRD?=
 =?us-ascii?Q?9+vfMQ+cqNQVkrLF9bDUpWAI208aPTg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 530046dd-da26-499c-e1ac-08debabd6c53
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 00:26:26.4173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pPIDs9a2WPqKCFNvX1Ud1aGhRq3z9dyk/+hcOy1PaZtTyhA4m9YhdM5ch3Y3+tuOtIKecLiYtdJ0Pru5ZwjyftFHMPAE7Ayr2ZtyXwLXhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7682
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

This patch adds pinctrl/gpio dts nodes for airoha pinctrl driver.
It also removes legacy gpio nodes.

It should not be very dangerous, because:
 * No official EN7523 gpio support present in U-Boot
 * The same driver is planned for upstream linux/openwrt

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/en7523-u-boot.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/dts/en7523-u-boot.dtsi b/arch/arm/dts/en7523-u-boot.dtsi
index 62d1a724678..ca436b9ba2f 100644
--- a/arch/arm/dts/en7523-u-boot.dtsi
+++ b/arch/arm/dts/en7523-u-boot.dtsi
@@ -2,6 +2,9 @@
 
 #include <dt-bindings/reset/airoha,en7523-reset.h>
 
+/delete-node/ &gpio0;
+/delete-node/ &gpio1;
+
 / {
 	reserved-memory {
 		#address-cells = <1>;
@@ -22,6 +25,26 @@
 		#reset-cells = <1>;
 	};
 
+	system-controller@1fbf0200 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0x1fbf0200 0xc0>;
+
+		en7523_pinctrl: pinctrl {
+			compatible = "airoha,en7523-pinctrl";
+
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			gpio-ranges = <&en7523_pinctrl 0 12 28>;
+		};
+	};
+
 	eth: ethernet@1fb50000 {
 		compatible = "airoha,en7523-eth";
 		reg = <0x1fb50000 0x2600>,
-- 
2.53.0

