Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4417FD1CDCF
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 04:16:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6317F84005;
	Thu,  4 Dec 2025 05:15:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="fHffQnjC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7892D83B24; Thu,  4 Dec 2025 05:15:02 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 599D783F82
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 05:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDZRtHLyZH/FXydu+bIq9eNOfYXFfQbWemjxVRR3uOPFkf3LfagfyKqymW/dKPZdL91p74gEa/5mbFrkNbbc/oFpKvMmq8RVN2a/PGtIMR4rwKwyBXTUofB6hj+zdL5ICCkDkudviczwfpfGfgw1llC2ldp0esA8a9iK1LjjHaKzcB9rM3hUNumqbEGvW2Dt/yipY6Xch9quHQCBK1WK17DA565u2pYrK0ZeZpLyBg+S4gqRS7Raax8ZXN3nfFqguvJz8Y8HatSta0k5mTOTt9CFrsEf0ibO10wuSbTZum8FyD9iD1Hd8Q47xv2xjJtQwwJVr1WjFE2gOTysLI6m3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3ZblTsovXaj2Q6zZrQ85KsmUlotxF2qh5a7zgsSnWA=;
 b=Z8Pjkzb1WpMN0W7jQkOJlb7K5s+RnbdYzOCAt5Rp2brucWJnBgy8A3KQC91p3nTWktOQ0ctT1MjBi3kxWJN2XhQUclzL+wQbFfU19gjrXUFXq50yU3qmKRbXa0Qt4ZnXTudWaF6h0AhJIL//6GjaWqhTWUwr0v6PRUjL64ERbFh4WXnHON5CySzuRYTN9OkMC0t5euwxYFbfZP45jnfbcmz3jYQSyP/Rr/5enMyF1EhgO3ODPIneRLA9jnKf4BLZe5J1tXwpqkvgXox6lZXsRVFMAzw3ZXD/GHqO9Pxd1p+i1BXIJY0Y48K5TaSQ5GIJYyv44IxvJQmXtvou4TEq3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3ZblTsovXaj2Q6zZrQ85KsmUlotxF2qh5a7zgsSnWA=;
 b=fHffQnjCeex2QwxKbtbKGkDjbkD6+eFAsYYPsJ00mAa6B1x2sAHVRrv1LcDJeZLCtFwz6tdypco9EMfVFEkNUqw7sYIr952AMXdbIXt/szJ6Ie+q7ycgyH6J0oynm+HrUiXZlWrrYeH+ujcIWYs2Gn5mcCSBYCwhZ6bLdT6NoODeSt5XReWMR8yirexhrqqUb5JSesdrCJUFoGkqK5mnmiU07ay5QVWaLLHOoSEKumETUIV/DYsZ0gEfioE+0zc7RSju5fqUv8qKhsmFzRE1wyFuOOuGJL/6SjE7m/PdEXGrk27v3/m9y7+c0JQHZpFCIkeZNXiirkkMyG8BzgMJyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10009.eurprd08.prod.outlook.com (2603:10a6:20b:64b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 04:14:59 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 04:14:59 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <ziyao@disroot.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Markus Gothe <markus.gothe@genexis.eu>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 11/19] airoha: add GDM1 sub-node into EN7523 ethernet
 controller node
Date: Thu,  4 Dec 2025 07:14:25 +0300
Message-ID: <20251204041433.3459826-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10009:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a8b209-b705-4246-85d8-08de32ebb049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gP2WXCgmMbNJYzEObFPFMepbu5rEbYiP0MZ7y3KDWE3qJjlE3SGoK777UK1W?=
 =?us-ascii?Q?ZCeW3oj+TSS5kO/2ISopwIqINPJq8EOqwiIq+k8ZNBjvDxcnesTU2Ty/3keg?=
 =?us-ascii?Q?D0KQls6boAxvNV2wRHgb8UYEgrx1vVqEqnIiGS7RZjm9sHTOrTi0wBPn5fry?=
 =?us-ascii?Q?0dWwNNS27TV+zeRi1UHAHMbFT/adeD5ZwL9AydorMuHp1D/PSyyt0417OOt3?=
 =?us-ascii?Q?HMy7YYrXtFfyFIH8aiUv2EOipnHOP0AqavwIHjJWcjwgji4clPvMUUpqreXe?=
 =?us-ascii?Q?4jDG6YULwNySGJZITWjf435B4l/2tLN1lJTYS+fTGNoERJ/HQm+3dD0cQNmD?=
 =?us-ascii?Q?Qz3nfxzs9zRgW7CQWbCq3s9oMQDZGiIaHF+E888N4FVHb+69MCDLAFttYki5?=
 =?us-ascii?Q?OsnIKIb/YL0GYGHNL5sgRiP+5fp2e71fmhklSqXJaqdpXSo4R5BYuP5eKgro?=
 =?us-ascii?Q?Q4AYWNSFWWtuQemQ0CqRV+WCJZdhZYGeJQCfag/s7DFUj3JuGSJ6yQcGMdqX?=
 =?us-ascii?Q?Gralx2Nz2DO2APl/gV8YjznSxNj1vOFDGq3NFj8+pgZMyICJJT6SfK3o5qau?=
 =?us-ascii?Q?26sav4JOvN6NV1cvhP+967+EKIm3D8LV6sI/GVLVXPsqwsoPHucXu0+p5j8F?=
 =?us-ascii?Q?I2SeBQ/ZqPQ81dhDFlH+GFLXLL27QY2DQnGzv0VnKYf7m0MliUFHOp+RTAiX?=
 =?us-ascii?Q?mR2NV5virtJTN6s+0BB8ckEcCXHp1oGUSJrIVUI4cqHvlu4V9uQTLtwqfpkD?=
 =?us-ascii?Q?UJUrS2Nt8qNbbRlUdiJ6v8XaddMy0fV/SWoxjuZ7mbKXtJM9yv8c88/RxlyY?=
 =?us-ascii?Q?NY8fxln/bKirxClsXJ67de9gN59OrPW3HQJiDWK0sWeGeDCeOvigO48bqp9o?=
 =?us-ascii?Q?EPLHteRYPJnWsmULAtQEiAeOU9JLRAHe3lOcGV1QruQu/Q2J6T/RfH35hzAa?=
 =?us-ascii?Q?TSLivoXODyGSNCKojB3erOGP/6S2JMxaU/h83RLl7WMRL0JjnMPnC1cQDbzd?=
 =?us-ascii?Q?gZCAJtXJ7JlS77Y/6VgKARQZs2tefM53GpgFmAj+0P6r4pZGlcEaOSj4rtxs?=
 =?us-ascii?Q?x8dzPSx5w8lJo6BmTTPBVeGkvx91nkMzJLtgtBstggriM1OvmncHdNzfv7ew?=
 =?us-ascii?Q?lWhppQxREloMT+Z9nMjLTJyvu8MlTpc0E90IAiw2C+30BPIXPDUWbxuPjr0V?=
 =?us-ascii?Q?nyaMqdAS90eGVjd42PP5Q+VtNYPspE3C8Iymd9gNjHdJICblDcysQQI64/3M?=
 =?us-ascii?Q?FaQCGuMbWkS+cP6S0fHXTIp8AwWtsgtyXcG+ZM0qdP+V7PiMo0c83Gn0uDp4?=
 =?us-ascii?Q?LXrs8tJg9mXoSNqmvO2U3Lp93+eZCSm3dlmiFlTa0e/8vmzKONO6kBds2LBL?=
 =?us-ascii?Q?4vvv1WGeC4Wf3E4TElkJis/wwy2Ls7bINyTPEXLCZRkDl5HlNve2Se/1jIB6?=
 =?us-ascii?Q?jqBV/sO5CPz0Rv9dFoQs8LjQ58/1+t3ZDH+UTN7oUlDgfXDdAgLyOj0PxBXF?=
 =?us-ascii?Q?MyUtwGJ4g1DSPiYCv7WoGR+evfYq9jwZIS6ct2BDW2nyVe4BMUNnL6yUBQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l28o4Iiix0vaLxEDZHALhWjc9vjyF8dToMEJyjtWgFehFZplo3OGMfcy6N57?=
 =?us-ascii?Q?dN+WxuCqn5NW19iSdzv4gpDVEVIUg+Hknfto2RucSh3CeqqHG2ZKfjSRlMV+?=
 =?us-ascii?Q?0so24QLIYgymx4Wr5Y7cXF110H21Cc/B61dKNKtbrhFto7TaQqZaVAsmGtjh?=
 =?us-ascii?Q?Y0+yUEX+bEso953NzEyCZZ9Bucl4HzsQcfC7s6rg4ZMSXVPPBD4JbmXvDL0V?=
 =?us-ascii?Q?W/l9rVJU0pZdTTxiyGHTkC9rD2z9viY68WFQLicbD9Aogk4z2RcANH2BBN4u?=
 =?us-ascii?Q?7MHMcRkEN3YhOZiaUGi8JPbSJgBHHC/AJbb517NYhorMazvu/wzW0sQ0gHYb?=
 =?us-ascii?Q?unAa79mKQH+0ywjVIhjZsbuUjFej+FX6jI5lTjWi05Ht1fALf1PEjX/JLgjN?=
 =?us-ascii?Q?YUAOMb/VM203aixa24G9IQ7NmjG8K8AsZ01YNmrYXHomQfRMfSoQ3g1g+vJs?=
 =?us-ascii?Q?ugY9xSQMPq093kDG2P62v8nWWP1jv/Dj74Jq6WYHKv/9Ktfq6xKZMVAAB++0?=
 =?us-ascii?Q?s88k2FZXt5R/ifpWGIgtTVe7bcDt8UsgZN3OTOZNXLk+V/kvAlCpIbX6e1oO?=
 =?us-ascii?Q?ntBBejiuWZiRuDMmQOhGTleOimu0QAZq+eGNPNj1/C1StFab41ym3YN0h4Q5?=
 =?us-ascii?Q?g2LpJMKbgYHbYhMYElJeuyHJk4/9CUkneE5Ra/LAMVQYJOXn7L1obD3ORzxv?=
 =?us-ascii?Q?PaLEtI00q4TsjX+O18iAyKpFm4odyWSby//APPVgYShxpbUBVEo5TldMvhJH?=
 =?us-ascii?Q?s5X1aeCUYU2uqkHJ0r7mCn6uoplbdbWDY7Anc6Erw/vxyi41vqQoKh4siCJa?=
 =?us-ascii?Q?gpzWilzYX+hEr6au9NmQsH8+zolQJzbQdazz8B7eisq9NaGGN8KgGfEEX6/x?=
 =?us-ascii?Q?Ylw1HZHsc5pDPVvtT995Ox+fbtBRngxpPCYBrNsKQEE8UTXWBfF8ixMzMQEt?=
 =?us-ascii?Q?iGOJoZEzeqOrdDzdfs1e3fP3omWrz3okV0oChMhnsqBUP1cxEQVfGOiGgDx+?=
 =?us-ascii?Q?pLNF0XNHN6snv2uXgxy5fQaPNW7V3QcZ0huPFIZUiPJOG6zbdtLmtP5uTfwP?=
 =?us-ascii?Q?ky9Kx4QTgzlYvuR1d+KZs1GdRiRnRY9p1dy72l0C7A1++EqxB5lF0epmrzk/?=
 =?us-ascii?Q?UHeD4TgGTH67Sz3QuyayiJfjcwPW95ZHDZZktr4qadz0MTbgEC4wslrSGNSu?=
 =?us-ascii?Q?tuTwS82UwttmMsy99yL+z/862Kt9LOcMoLi6ubdaPphilhexJwnFpii1pcw2?=
 =?us-ascii?Q?a8QI2cvKQE+tyYNnu4mPoXZFXqfDm2TMRDfh5ic9l1de2vhQGz2uI+7ma2g7?=
 =?us-ascii?Q?S3Vi42ErdO2rGX66J5CEk8T5JNVuMoJHTWQSxkkezYH+ls4/yftxHPUk/1v9?=
 =?us-ascii?Q?ItwlP9a1tr4OCz0aGviWcqBu8cdsKzX9F5f9xRP6nJH/R0i/uLQVubNoDefs?=
 =?us-ascii?Q?v86iYLStb7rST3fI3uErmDqLMebRyl4r1hSciFvGAE5WFlHeZtUTuI07I/+R?=
 =?us-ascii?Q?Xa89LAk9d+FawclRzhGCqMthCQo8oncCDl0I/onRMk+kP5DSVnQdE0LCOK4a?=
 =?us-ascii?Q?4+IcSDhevzS8bOg/u3/p0B4Eo7OBZ8tBerrurUROIUjDk//Yqe0uw+Jab5x7?=
 =?us-ascii?Q?hcDXLHI3f6p/vzczWL+vxq8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a8b209-b705-4246-85d8-08de32ebb049
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 04:14:59.1830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYv/6rZfUuwWGcO5wEHvhhR91ZTdTWcxkkMWp6MlupBXxHUVXfNcVngP9Ptntv9gEaKG0alFetc50gJ9cHgvjHmfbUxgETsHUmbU60Gz+4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10009
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

This is required to make ethernet working after PCS support changes

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/dts/en7523-evb-u-boot.dtsi |  4 ++++
 arch/arm/dts/en7523-u-boot.dtsi     | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/dts/en7523-evb-u-boot.dtsi b/arch/arm/dts/en7523-evb-u-boot.dtsi
index c109d6794fb..d6ab621d590 100644
--- a/arch/arm/dts/en7523-evb-u-boot.dtsi
+++ b/arch/arm/dts/en7523-evb-u-boot.dtsi
@@ -9,3 +9,7 @@
 };
 
 #include "en7523-u-boot.dtsi"
+
+&gdm1 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/en7523-u-boot.dtsi b/arch/arm/dts/en7523-u-boot.dtsi
index f031f81515a..a403e684adc 100644
--- a/arch/arm/dts/en7523-u-boot.dtsi
+++ b/arch/arm/dts/en7523-u-boot.dtsi
@@ -37,6 +37,19 @@
 			 <&scu EN7523_HSI_MAC_RST>;
 		reset-names = "fe", "pdma", "qdma",
 			      "hsi0-mac", "hsi1-mac", "hsi-mac";
+
+		gdm1: ethernet@1 {
+			compatible = "airoha,eth-mac";
+			reg = <1>;
+			phy-mode = "internal";
+			status = "disabled";
+
+			fixed-link {
+				speed = <10000>;
+				full-duplex;
+				pause;
+			};
+		};
 	};
 
 	switch: switch@1fb58000 {
-- 
2.51.0

