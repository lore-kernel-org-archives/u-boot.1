Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51406E74AE0
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 08:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA8E58423E;
	Wed, 24 Dec 2025 09:24:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Yh4euQmO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA32084230; Wed, 24 Dec 2025 09:24:57 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75FDD841D2
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 09:24:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXnYiYS0zWkUuIQItN0qwNKeoCITObxQIDPGaHqXtdcplUnI+Jkzs0dsNpCwLXLjEEpodP+FelBAPZyn6aT5iBqJhd/S9treR0PBCIAyN+mIxcV0gPlsPlCooKJAN2peXvjtvOkLP6a+GNAPMq4ptJ1ie897EVPrtcmYuswK0v/mDk7FLS2oDCSSoC2afWMxcyTPSL7YDfaDAGtabQCbLJDPXJind+29wQAw7KPsrseLjmH0kaIMB/AVqV48jJ/tcegHlah6YkEGz6Qy5XXfaxPiygitEuSnVYikNvd+7W8En0hbVDwBs2S4z6Q5Ux7W2ITj2oT99tvhIFRrxbAEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3ZblTsovXaj2Q6zZrQ85KsmUlotxF2qh5a7zgsSnWA=;
 b=hxnJ6i6QjCLcVcDjOYMeY3F8qpJc90AZcDq7ItXOQgxehyebsHu2KAaM4Rxc7+0oowxy5JG3XY/JQzgf2CFju04lkO7eIEt2l920AtbbYnJFaVETsXeoEWxpxOYFZ/vDX3WsfyDfT+qmfAYnpN9cz8tG5Jzl08RhJHBZyBJbssIffHw7TDCDsb0BzkSjmkRzjHBQmzloapFZ5icRr45IT0vs5AFr4cT1TgsTmI19hIPcXaG/65ar0SFVThnZrk9lvbCnGgYO/XYYHRubP+U2Njl0hsQe9l9pQ2H5ZR1Ru4JqgBc01EUEoVTwJ9eVCDgkh2stuuKsolyes1cNI2LJvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3ZblTsovXaj2Q6zZrQ85KsmUlotxF2qh5a7zgsSnWA=;
 b=Yh4euQmO8ewiQ/pIKIGB0c74ucN3Gwyq7thhA8kpXKamhIzsWD3iDdEY2qxBx/9SV7Mp+1fd7Cy1p2E3gZcPFAXPcQbJ44pw+7dug7ByaeuS3kLq+3llNMcX4rN+hc10gB4ObHlRHWuEw/G8MSMGS4VgW12FveVtS3fila9CbjyIdXYllS1rSkQ+KD8zW+wb7a0rWTFL3nAAssVQ3PHAEbb6so2Vk9Yl/E3ZysaKjZMttNS4G5epVv47S900IJ7/6abl4kkOl4UWsQW1d+ig3wxtnWxd8uy/5cuaibxgwQyfaoQ7e4Gh4wexsrKsbL9gsSwciH60dHIrxIRfafb5xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6562.eurprd08.prod.outlook.com (2603:10a6:20b:355::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 08:24:53 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 08:24:53 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND 11/19] airoha: add GDM1 sub-node into EN7523 ethernet
 controller node
Date: Wed, 24 Dec 2025 11:24:01 +0300
Message-ID: <20251224082409.1347373-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: df3966c1-0a3d-4996-6980-08de42c5e9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XR0iEOMDzoUq80qlDwpLK4TRZLlWG5rib/ZKAAQDbLPIcvAZT2Gs47cWLMHQ?=
 =?us-ascii?Q?6rFdJZWFuBbJ+uqrpBIO0LWhWaJsZKVCQTFq7huyoAK/squ3ydKS86Yh8cT/?=
 =?us-ascii?Q?eNst3e3C7Y+CF8cw91gYYB5al3kanFwGfD4wQ+pi/yBfBiE/tUOHKpeBpp3t?=
 =?us-ascii?Q?3lWTN9GW+PScw2Br6X1Vnes0Rjb0yfHLdlxdZ9GSNPfULq7R6RrZ8UdTu6qv?=
 =?us-ascii?Q?riJIWg6NHIDLQ3PLQm7nHpHyU/TGNnYFXiCWCZ+b403zLRMoMzsnk0Tu+q4l?=
 =?us-ascii?Q?e71bxDhOuKQ0s8NK5wFP3Z0Lh7x1i2M7nNGO4kIM0NseFMi04Ee1M7ctmasU?=
 =?us-ascii?Q?RNhfZCaoDwBD9Qa2tgEKaDzDeLBOfSz7pLtQ4lthCj9To6GEvSDU073dWTzX?=
 =?us-ascii?Q?9MqjLVAYeKg7yxEUyFfUFaH2P3ncHe/VOL7MqigEFRqmZon7ZQTuqW4yUogG?=
 =?us-ascii?Q?+nWEnNda9cyEcdBe+E/mEg3w09ERzhcCfJFRkQnh5f0Iho9ZOCsisXbdmjf9?=
 =?us-ascii?Q?GX6APF8lwwbp2tjeu2K44Ma6jGIXzu4WGE1+qJk5SJgNDGNQna6Qrbfjdhfu?=
 =?us-ascii?Q?Z0U8kR0J6mNMzpBQetYv+xhe4hmhqGR0FEO9EUeKT8A6fcUO+v5xeYoNkVHa?=
 =?us-ascii?Q?2Tl/lrAIGKWS2WTafyLvwN+wAAKFsecWvgc3o8fxlKs8YjjBOUu9gJFndn/k?=
 =?us-ascii?Q?YyN2DtApEXObGtH57wLkZZNIRHifpD8bC2zXHeC4JRSldtrMw9zlZfpibxJ0?=
 =?us-ascii?Q?t50twjVGzTnq8MrLWGgj19kHL7rG9FFjDOFnRQ7Aqr/9Z9uJFPwNOUIQsb5d?=
 =?us-ascii?Q?DP+IloITNqjJSH2Uz0sbswuVA0kDW8lsnBrt2yFDv69DhUORXVZlSDZ19WTX?=
 =?us-ascii?Q?BySPEyeDo5pZo2nU13NgBS1EnoeZjhm/moXSTquKE50o6kdNqSDrtPGN78yU?=
 =?us-ascii?Q?mJU1zQqNsnp3np2pG8NyAOffOHDywHTQQ+vDAbhgSPqWNYU0A5cMO9pnhURK?=
 =?us-ascii?Q?ekRJkf66VBSZghq2H8q/k/cnpMActcwJf7cMueuwT/PlDeQUfXInoHcQSe1o?=
 =?us-ascii?Q?689uSG5EsFQBIfU347wWiEhv+GDIETSLvZXmq2teUL6a8ZA2pV/Onujn8aRs?=
 =?us-ascii?Q?CBP+XJHDh89TqRWuJXDqVyYNysRuQ4Ppg+ffyzQuzOcC9Xk9ICu4RqPuldI9?=
 =?us-ascii?Q?yZyrsXMU9PZsTwcJnOIWTkUC+tfUIQKmFTa6CaW/srT28Qi1mucCMpp1jVZm?=
 =?us-ascii?Q?JZCZdY4FZdJ5mu8XV/OBHIbiqIdeukifADDDJQYPcaOAlFGBSP6Tegoaxpmx?=
 =?us-ascii?Q?eDbaxH/aVIIDQ8G/rYs9XXDAlT5EXLJCcxS4yhACeHFaCMIZgDWJjHSYmeLG?=
 =?us-ascii?Q?TnK7tI+aYOy1GsZlWEqDuMWrkRweRyGC3kw4rs2cgR6Jhv9cpyTBFqXCrj/q?=
 =?us-ascii?Q?v3ktP90F/X+IUfMJuGXLwLE16lGNg/kxJOb1DD88yaZxGbJzNlZb3qaIhgKM?=
 =?us-ascii?Q?0E8NyIfnV71ETXr1HFQWFgVi7oJ1OIgCcaPuW0KEsl1uAkdsqHJ9YU2CbQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fQwJLZGQ5OF75GEjAeB+FNKIsdMNCrLIoZaTPc+60MfABpUKH/bTrzgOXpmX?=
 =?us-ascii?Q?qpN7XB5jvSc7DCAucW4s2HWliaN49TzoSgzi5HKg7dHcDKwO2DvptXL16Yx7?=
 =?us-ascii?Q?JyBsOMJa8kdiqQVwyZ3OZA+40g/OF2z79ZZ/8UiH0ZW8hliuSQR9i5BundeS?=
 =?us-ascii?Q?xfkY6QV+tHXDjrX+5C3qxLcxvIyGQaXVJWk0WQ68FgGHv0jlv5Ddc6W9uffm?=
 =?us-ascii?Q?+AdypIMs7x9farEw78hjshiByrZ5mN6smGEzbE1novCxeKcs3JDpaIWpXi0n?=
 =?us-ascii?Q?+BfaJ/qivwm5TqrA5HBPvNBTS5TZP+uy1J/3cjk/NSs/KHhtj8qwqEJgk7bL?=
 =?us-ascii?Q?FgKXU0B/FOiE90deFzJSw7PjKp5BdML2fKwbzL+xXT+xcR69QDrsfF8JyIi5?=
 =?us-ascii?Q?V5FlnYHYGJyCkoKBEcGvoewdYceSWH0YIPKl3RGHPZCYF4klhEnqFHYJ6CAT?=
 =?us-ascii?Q?AF1n1R6Z9x3Tz11IU2fFxyzkIW4U/PKFmdw4dHau6OhdP/ubvGZMz9QNxcTq?=
 =?us-ascii?Q?pwWh4mGhMMJodb5yjDst7voug9UJ/VIVdTJGB182W1kIqtlKY8nqrpjyF4NA?=
 =?us-ascii?Q?Yu2qG1Adqowa4b39NITa/6CP39Z59lwTmTizJd8ZS2Mqt3WCbl0zMlQUKufc?=
 =?us-ascii?Q?1f/mDbo1uhQr2tQ+aw0aVCfDGqhntiy9hX/x2viz1L8BXxCCh8la6airSgLJ?=
 =?us-ascii?Q?0B6yw/YqCNWeFMjAIeU6K4ZsBA2X4/bDL4VLG+GyZy1xeOUJM3qn6hwV6kr5?=
 =?us-ascii?Q?kMbTDmuOexBiTyspQhkqycUyydPGiqdZGH1OPL/Cqs9OJj4KVcFKsQrStFzF?=
 =?us-ascii?Q?PVvI2xHN5Z1S/q7JCLzehLivNEGkMjnR+SJMDCNhfVVT6N+I03Wpxq7PPl/Y?=
 =?us-ascii?Q?xXUg3MXoQccjo06gSJmfEuxFSIh7nps7Z3X0X2nfyICTIt5Gg6uDoeDwNCHd?=
 =?us-ascii?Q?AxIxQuO9f2tn6vyOlU6vMgv/0DvhVbQrYBVQDkAw2lVeU/hvWnJCYdjIdTfk?=
 =?us-ascii?Q?C8Y/vpymbgLJCqqAdIjFh4urEvva8phwGWDDXVZPCVg1glB0CYDWYofZ0g1n?=
 =?us-ascii?Q?+QVVVPg6UlC1ymMfJDya2u94fijNMXF4H6aq3semlnhmnetq97bCdB+tf3sB?=
 =?us-ascii?Q?BIVIlZpKiZV6K1h1+RQZ09zmj8d2YDukSMExDjfqe1Yan+dvMSY5Q+Unf4HI?=
 =?us-ascii?Q?gSIAmWa6aKszU+l/o3sto9vya7bKw5mEhA35cgA8V1yunlmX0+epmNjr8C+Y?=
 =?us-ascii?Q?vPHj+6oKQjqU0W5iVc7vWuqJG4d7/2kjfhyv7s3KjGn6CtYaO/eb8poyVIpR?=
 =?us-ascii?Q?5CI7WJFZUbgAszLRjd+hpyJZZQU1dAMSijxNALNrV8LF+yVlez3TlqMZ46Qb?=
 =?us-ascii?Q?3Obf9B4GpVrBZR13yl8xDb8Lza1flHQKB2g1s5qFkegCBz2CJVS1kfw9nljf?=
 =?us-ascii?Q?1ydvJ7bKzTsf96xvnAWC0ivC9l9cJmrKhVh47j8/AD1lodvh6oDfsP26GPUu?=
 =?us-ascii?Q?w0uz/j/TIXEetC4XAANRT3zVQ18VE/zpgqamptxz8A6ALG5JzR92levKdExr?=
 =?us-ascii?Q?cjyphEq/jf6AE1B929vg1KcxhRIwzBzTv4c9tQkaVMIg8pL2yQo29NC+vbmj?=
 =?us-ascii?Q?pGIOt1q6UB8Gnwsk+F+trqzHDf/j4mzaJdsPqAFsgtMj070EkJhoqRvUCExX?=
 =?us-ascii?Q?Nu5xthGwfO+UB/q9bv5m980jPRYOCfonXLsCH8bMjWdRWI55h60hH8jVDnW0?=
 =?us-ascii?Q?KYf3zILBG8xAQcJKHuEkIrKURaeBVAY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: df3966c1-0a3d-4996-6980-08de42c5e9d8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 08:24:53.4624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyFBgTo9hayjLIltVKZsfSPZFORH1aOvw+6d7GqALvAjWF84OkWyWk87Q9xDct8nkoB4hoMBH32MTQdyrs7R6boImwJ0mheNoqRaUu9p4wA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6562
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

