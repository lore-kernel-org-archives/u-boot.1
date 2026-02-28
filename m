Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABD51048922
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 01:44:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F84F83EF9;
	Sat, 28 Feb 2026 02:44:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RK9zZ35P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28F9983F6D; Sat, 28 Feb 2026 02:44:13 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7928183F14
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 02:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6x8LpGJlJwaVdOlnYJHq/IJ9QN8eZrq5WZrggQe6ExMnpnC/WtDQft8jNoulqdRrt0670LSkrSNzYnVUFN+TzDd5pJRJFG5vBPVAN2k+ajqvq4s/m2B6XGRNhprgkNR3fUdfnh3geMiU9vX0NaoA06k2hwT/FMXEaplMr1kM7GKpmN2FXd80OdrFotZfxVy9uDCVGW8hvXSs0g+qAymbZbv4k4Pv+W18nSksk4CeEMXZeDJx9aq4MEAe6h5DrItOBBakrgZBJS3e/CCqwxK1mjo43oEO86rH+zOlEESzngoSp8zFbyPykuxOCtYutT8+sq74n6TR4H4GwEgStOw0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GRSHDqim7DM70j0dy6wC2FJlgnOyvhAMASA79ngpq4=;
 b=IzYtdX3I9j/21PmEWhLb0yYvKcN41O+VVTFeTGWxeWItylhLXqntdPUDOuTPh44hamtJFzc1QmgSr/7PmB5zGtHAB8KjbQQ4C467EtHaKf/V+U17Guieap8VGQj3DJHt+5EfDqJRxAq1bpbnumSqs9B8mrte+vEWmc6P0JIruY2jI/5MfQimTSRVpung1ooxfj+S+HjJXizn3SFn0tyAjSS9cdlGEfBfywOqSn6hJ3g4ztBytWXVTWRHoHU6U5rmf0m05TSZ+Q4NGlqYxXLAL3kyZpw8Dyn6GzUNM++pMJMjeCCnkHTGbgnpr46cG1RdHbgGRZyjhum2IkeRmpM5bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GRSHDqim7DM70j0dy6wC2FJlgnOyvhAMASA79ngpq4=;
 b=RK9zZ35PoFwxYTcIYtAlXkYx/EyfXwI9Cfr3WM9UAX5hjxIrTpSVV0ECdjRqHkzuAMg3IxDkUyp5aHkoqsHrK5xj+cSL4uziBqRYMdVsyMBQC6alrBxBfbIT5jTT1A8O4g3yMuhgijJOP1o1K92bpFN/DnOvctouDwqHslVQtzb5+DHSNDwQlzWcY5AA3a6uq7pdBNPjsCCOgTSkITLVD0NLQuikjhsXS+F3x3D1forYavrB1HJuGiS1xhxsXEZNnGHbRgyhhyPrOxS5RNeOtajKHVZoEl27RmQjUWXqSVMUSqb26C/iQrI8k1DgFlDT54hHFwPomEHdh6XTZ7WDug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by MI3PR04MB12440.eurprd04.prod.outlook.com (2603:10a6:290:75::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 01:44:08 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 01:44:08 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 28 Feb 2026 08:22:29 +0800
Subject: [PATCH v2 11/13] arm64: dts: freescale: Add i.MX952 EVK basic
 device tree
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-imx952-v1-11-0a360e7e8cb7@nxp.com>
References: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
In-Reply-To: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jacky Bai <ping.bai@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Jindong Yue <jindong.yue@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|MI3PR04MB12440:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b94ded-e507-4d7f-2c62-08de766adcc1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: UzCSGm9NkKmtD8WTzg3gZcXlR/Ruv02478gv4qmifYi6jrMj/1UJEWM6b8npE4+2QXELwk/3eK97CxfZhhG5+hec1Nv27+5cRYEb/kt4DEZMp0+Ph3G97OeJoXazgh82hBAm/Y4YwKWKPJH47iVWSSmx2xb5fuKsIDBJT+KGCK7XXmm6P4nEYULs9avJyez9l6EFWTVnf0RIwC+WMfAQKNnrT+QsgOLqwMheSedAa6nG68jEOfZ5Otu41WwoLDZKVazZMyFBI6QlpCsfQKgFwIn8CBAkAIGfRfd0BVAjVWz9nN7dK17J5VT/xOIgIPx1F5/NmuHcxok12wNam2HPZqnO1YLRRy9OJzLyNJXGbQDHzVX09eQg8VnzygxXLEoUL+KtbSF6uqjLhsu/7uXB0s23GZAEHgTKjNYVFsO2euPV97QyNyndYm0nwPPeOAzJ/8IXoTBAuK1wR2jL8rJ3VTH4+zFV7mgX1gWwc4GhNOKREuijaIb3kRItatqxFQIjRYyHGu45/+5NrdfTjNPKZ0xyd5dqPhSCQ+2w+bnQSIayb+eYuljbpRLPWQYAl2G1qnzbapUFMTuRIGtjCnUiy9T553OJR3FvQLr89N/k0wuuPGr12s0SC/Sngb/249bkF5Nka+eSkartQns8XAvpbNmC4Alyjdkf3lewXvup28hLfkDu31SGkXDNkL324BkQYOMhS/r2k8/0tU/krerFDhd1M3rRjzTFqt+9jDJhzcwFEw95znHiFdMZkjgSqgnUE/L538fmJeHYAHOv8/ZbfTAnJGfM0DCbMj+qq4w5xzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU8xSDM1bXBIVXZXNXFObG10TExDZEE0NUR2Y2szQ3l3RHNVQ3lGbEJsZENq?=
 =?utf-8?B?WlRnQ3k0MGhPSXUrTVdDeHU2VUZBYVdEQVhoUzhYemZYSU9zbEJLUzFOWnhP?=
 =?utf-8?B?THFyK25DdGRCM1Q1RGh3Q3VJbUowVlZ2YVhRM1ZGZkRkajc4dEJFbDF5N3Nl?=
 =?utf-8?B?MVRCTDBPTXRBWEV0M04zR1BiQlE1NEk3RzYvUzFGWFduRW5GM2xtdUc5cjlN?=
 =?utf-8?B?eTNPT3lvSTNwWSsyeUQrNGMzNmM0d2tXYjJlYTdMT3REUS9TQmZOaS94TW0v?=
 =?utf-8?B?NjB0QkxNY3JNOThkTE5RUVNBRSs1b1BMQ1dCRFhnb0xoZVQ5K3paRldRUzY0?=
 =?utf-8?B?TEx2YWFBYW1Rak93UFFpS2R0VkhKZDlFNk80NHR2V3hNakMyQXR3d25LdjB1?=
 =?utf-8?B?Y25BbXVQcC9WeWFaeGozY0hUZVdERlEyK1lxVDc2TnIzcDAyRVFnc2dEVGcw?=
 =?utf-8?B?R1RlMHRQWnFwMHBZSmk2WmthaDM1c3haemFCTzY5eHJPcm1udUhDS0ZUTGFL?=
 =?utf-8?B?cXZXeXVMY2t3SUptZ1g5VEgvRFBWTUJ4VG5BNXR6aHB5ZXlkQWVraVhad2hz?=
 =?utf-8?B?Q0psRDlvd053ajdJTE1NM3pua1d3eFo4TW15WExXSzQra0sxdU5SVHAveTU4?=
 =?utf-8?B?ejVHY0dtcyt5SkRacG1tZVROU3V5eEhEMVFoM1VCbXRPVjNFSURodDJ1YWl0?=
 =?utf-8?B?U0tjTEFtUTZtZWZMY21iSVF0Y1dQR3A3MjdFeDJCZ0NvQnNuTHIyNnlzV0FT?=
 =?utf-8?B?WjFyWkRJZExNRlU4R0JXSkIvQXdVenpzVTNkZmRwMmI0MFphS1VIKzkwb3Vu?=
 =?utf-8?B?YWJKdTdDdHgzdm9qQ2kwY05IMUpXazkreDcwQnlMSW1aUUdINUdXR3k2RzVO?=
 =?utf-8?B?NjhPL2xVR0VQMkxnbVg4SFpFOUM2TmhQWWJOclNRZyt4RmlmK2EwaFJPTkJa?=
 =?utf-8?B?Z0VkbW0wU2hJS0VleGt0aDlkc3MyN0pnb0tDZExqMDlhcFdyTWV3ZDVNQmVq?=
 =?utf-8?B?SDE4YlJOKzkzTTB5bnB1WGF1cU9ramJDcHAzVnpGQUVrOENValMrRTRPM2xi?=
 =?utf-8?B?cHRhaFR3ZzRLYXpoYkhJOUJPZVJ2NkZMQjdQZGtCcmF2NVgvTEUwR000dDdl?=
 =?utf-8?B?ZnpOU2p6blJOY3dDT21VSTd2TkJCa0l5dWt4MEVOUjNKcnJUUnBzQzJ0Njhi?=
 =?utf-8?B?UWZnNVRWWFJGVG50QUlVdFUzbVYxS1hKR0U0Y2lLdDh0RGVwV3NHcFdOZXk1?=
 =?utf-8?B?SThjaDhua3FGeGFqVFJoNUk3VDlMOG8yb3ZmQ1RyQno0bDFRR1JnYUxRRTlL?=
 =?utf-8?B?ZkJuRFF0TUhVM3R0QVhaem0wc0IrT3pyYTA0NEo4S2ErY3Q5bHUxTVZxbDJ0?=
 =?utf-8?B?cWQvNXEzK1dCNzR6Ti9jMXU0eUF4OU9STENIeWVYYkR3WXpaaTdzTVZUd2c2?=
 =?utf-8?B?UVRjMnRjSVVIQzZPcHdCWmtYYXNuRU4wYUtlbW95bnJVMTJoako2TUFOMnJo?=
 =?utf-8?B?bHBaSjBXczM0VmxpKzZ5Wmgwb3BOYlBaVVRlYk1wM2RvRi9WcmFzcGxMNno2?=
 =?utf-8?B?RnVOeFhDTjRNb3ZNRWVGcnY3ZFBGOTgzbGNMVStRSVkrM3k2RFowdDFaY1ds?=
 =?utf-8?B?N0Q3T0t4MmJnaFN3OFdLajdLTmx3Z3l2VVZib0hIcnVZZks3MElpSjJrZXYz?=
 =?utf-8?B?OUV1QytzQ2lMVU1BOGYwUFROUDhidzBoOHpVM1dQWFU0aURDcUl3NlZRWlc0?=
 =?utf-8?B?ajYyRVh1VUpGdXNhWHkzS1h1c2dPNkhRNGtLZkFXUDlwVFUxNzArNlBGRldE?=
 =?utf-8?B?TC9DOE1qbENqYlFZMm41NHEwUXQ2Z2o0enlQdmpBZDZyUXNwd0liNlMwbUY4?=
 =?utf-8?B?RTJicGZLa3Jqc25TUG5RYVNWejNxamQ2cXZ3YjJCS0hkTFBqYTRuN2hLR0xV?=
 =?utf-8?B?cUl2RG5kSkhDQlpMdnhjaTEyMWlDcjROcERlY0EvdjhsOUswVEh5Vm8vNmdh?=
 =?utf-8?B?NDlRRnc5RENKRXlSMThKQ0JFckhqVWpIZ3I2dmNZaEprVTlPenY5WGpDa3Vw?=
 =?utf-8?B?QUZxUE4vYlN6Z2tmUHFWZXBibkY2SWlSbzRxaGU5SHdPU3VJdkhtc3dBa0hx?=
 =?utf-8?B?dEpKbThlM0VRUUdnRllxR0lEQ3VUbWlDaDhKWnZLVkgyUVFoU1VoQThEU1hG?=
 =?utf-8?B?Q2luUkU0b2ZkbmJaUDJmbTZaMmRQL1JxNmFPdTFKcFA5TUt1emFnSG0zdDNn?=
 =?utf-8?B?NEo0YTZZRHQrMzdHUnEwVEVFR3piOWpJbDM3b3VBd3NRTjJVTG43OHdtVk1x?=
 =?utf-8?B?RG5uaXVpbWhkWVVsR1plSkIyUW1KTzRJUVB6YXUyMXJ4M1J6cldydz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b94ded-e507-4d7f-2c62-08de766adcc1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 01:44:07.7074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjiXmNS5fv/Pa+rzCZju/GT9YThn3u8S4Fl476Rugn+s4+Cy+uPMuUVBCZDqNDK09LoDmJkjew4x2bVhn0u+0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB12440
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

From: Peng Fan <peng.fan@nxp.com>

Add i.MX952 EVK basic device tree, with UART1, SDHC[1,2] supported.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>

[ upstream commit: a5aa8551d0046ec701e8962f83361165ccf640a4 ]

(cherry picked from commit bf18a0f083bdf73f806a3afb9b606b2cb0fcafb3)
---
 dts/upstream/src/arm64/freescale/imx952-evk.dts | 217 ++++++++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/dts/upstream/src/arm64/freescale/imx952-evk.dts b/dts/upstream/src/arm64/freescale/imx952-evk.dts
new file mode 100644
index 00000000000..2c753fcbae3
--- /dev/null
+++ b/dts/upstream/src/arm64/freescale/imx952-evk.dts
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 NXP
+ */
+
+/dts-v1/;
+
+#include "imx952.dtsi"
+
+/ {
+	model = "NXP i.MX952 EVK board";
+	compatible = "fsl,imx952-evk", "fsl,imx952";
+
+	aliases {
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		gpio4 = &gpio5;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		serial0 = &lpuart1;
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux_cma: linux,cma {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0 0x80000000 0 0x7f000000>;
+			size = <0 0x3c000000>;
+			linux,cma-default;
+			reusable;
+		};
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3_SW";
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "+V1.8_SW";
+	};
+
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "vref_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-name = "VDD_SD2_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		off-on-delay-us = <12000>;
+	};
+};
+
+&lpuart1 {
+	/* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	pinctrl-3 = <&pinctrl_usdhc1>;
+	bus-width = <8>;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-3 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&scmi_iomuxc {
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			IMX952_PAD_SD2_RESET_B__WAKEUPMIX_TOP_GPIO3_IO_7	0x31e
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			IMX952_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX		0x31e
+			IMX952_PAD_UART1_TXD__AONMIX_TOP_LPUART1_TX		0x31e
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			IMX952_PAD_SD1_CLK__WAKEUPMIX_TOP_USDHC1_CLK		0x158e
+			IMX952_PAD_SD1_CMD__WAKEUPMIX_TOP_USDHC1_CMD		0x138e
+			IMX952_PAD_SD1_DATA0__WAKEUPMIX_TOP_USDHC1_DATA0	0x138e
+			IMX952_PAD_SD1_DATA1__WAKEUPMIX_TOP_USDHC1_DATA1	0x138e
+			IMX952_PAD_SD1_DATA2__WAKEUPMIX_TOP_USDHC1_DATA2	0x138e
+			IMX952_PAD_SD1_DATA3__WAKEUPMIX_TOP_USDHC1_DATA3	0x138e
+			IMX952_PAD_SD1_DATA4__WAKEUPMIX_TOP_USDHC1_DATA4	0x138e
+			IMX952_PAD_SD1_DATA5__WAKEUPMIX_TOP_USDHC1_DATA5	0x138e
+			IMX952_PAD_SD1_DATA6__WAKEUPMIX_TOP_USDHC1_DATA6	0x138e
+			IMX952_PAD_SD1_DATA7__WAKEUPMIX_TOP_USDHC1_DATA7	0x138e
+			IMX952_PAD_SD1_STROBE__WAKEUPMIX_TOP_USDHC1_STROBE	0x158e
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			IMX952_PAD_SD1_CLK__WAKEUPMIX_TOP_USDHC1_CLK		0x158e
+			IMX952_PAD_SD1_CMD__WAKEUPMIX_TOP_USDHC1_CMD		0x138e
+			IMX952_PAD_SD1_DATA0__WAKEUPMIX_TOP_USDHC1_DATA0	0x138e
+			IMX952_PAD_SD1_DATA1__WAKEUPMIX_TOP_USDHC1_DATA1	0x138e
+			IMX952_PAD_SD1_DATA2__WAKEUPMIX_TOP_USDHC1_DATA2	0x138e
+			IMX952_PAD_SD1_DATA3__WAKEUPMIX_TOP_USDHC1_DATA3	0x138e
+			IMX952_PAD_SD1_DATA4__WAKEUPMIX_TOP_USDHC1_DATA4	0x138e
+			IMX952_PAD_SD1_DATA5__WAKEUPMIX_TOP_USDHC1_DATA5	0x138e
+			IMX952_PAD_SD1_DATA6__WAKEUPMIX_TOP_USDHC1_DATA6	0x138e
+			IMX952_PAD_SD1_DATA7__WAKEUPMIX_TOP_USDHC1_DATA7	0x138e
+			IMX952_PAD_SD1_STROBE__WAKEUPMIX_TOP_USDHC1_STROBE	0x158e
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			IMX952_PAD_SD1_CLK__WAKEUPMIX_TOP_USDHC1_CLK		0x15fe
+			IMX952_PAD_SD1_CMD__WAKEUPMIX_TOP_USDHC1_CMD		0x13fe
+			IMX952_PAD_SD1_DATA0__WAKEUPMIX_TOP_USDHC1_DATA0	0x13fe
+			IMX952_PAD_SD1_DATA1__WAKEUPMIX_TOP_USDHC1_DATA1	0x13fe
+			IMX952_PAD_SD1_DATA2__WAKEUPMIX_TOP_USDHC1_DATA2	0x13fe
+			IMX952_PAD_SD1_DATA3__WAKEUPMIX_TOP_USDHC1_DATA3	0x13fe
+			IMX952_PAD_SD1_DATA4__WAKEUPMIX_TOP_USDHC1_DATA4	0x13fe
+			IMX952_PAD_SD1_DATA5__WAKEUPMIX_TOP_USDHC1_DATA5	0x13fe
+			IMX952_PAD_SD1_DATA6__WAKEUPMIX_TOP_USDHC1_DATA6	0x13fe
+			IMX952_PAD_SD1_DATA7__WAKEUPMIX_TOP_USDHC1_DATA7	0x13fe
+			IMX952_PAD_SD1_STROBE__WAKEUPMIX_TOP_USDHC1_STROBE	0x15fe
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			IMX952_PAD_SD2_CLK__WAKEUPMIX_TOP_USDHC2_CLK		0x158e
+			IMX952_PAD_SD2_CMD__WAKEUPMIX_TOP_USDHC2_CMD		0x138e
+			IMX952_PAD_SD2_DATA0__WAKEUPMIX_TOP_USDHC2_DATA0	0x138e
+			IMX952_PAD_SD2_DATA1__WAKEUPMIX_TOP_USDHC2_DATA1	0x138e
+			IMX952_PAD_SD2_DATA2__WAKEUPMIX_TOP_USDHC2_DATA2	0x138e
+			IMX952_PAD_SD2_DATA3__WAKEUPMIX_TOP_USDHC2_DATA3	0x138e
+			IMX952_PAD_SD2_VSELECT__WAKEUPMIX_TOP_USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			IMX952_PAD_SD2_CLK__WAKEUPMIX_TOP_USDHC2_CLK		0x158e
+			IMX952_PAD_SD2_CMD__WAKEUPMIX_TOP_USDHC2_CMD		0x138e
+			IMX952_PAD_SD2_DATA0__WAKEUPMIX_TOP_USDHC2_DATA0	0x138e
+			IMX952_PAD_SD2_DATA1__WAKEUPMIX_TOP_USDHC2_DATA1	0x138e
+			IMX952_PAD_SD2_DATA2__WAKEUPMIX_TOP_USDHC2_DATA2	0x138e
+			IMX952_PAD_SD2_DATA3__WAKEUPMIX_TOP_USDHC2_DATA3	0x138e
+			IMX952_PAD_SD2_VSELECT__WAKEUPMIX_TOP_USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			IMX952_PAD_SD2_CLK__WAKEUPMIX_TOP_USDHC2_CLK		0x158e
+			IMX952_PAD_SD2_CMD__WAKEUPMIX_TOP_USDHC2_CMD		0x138e
+			IMX952_PAD_SD2_DATA0__WAKEUPMIX_TOP_USDHC2_DATA0	0x138e
+			IMX952_PAD_SD2_DATA1__WAKEUPMIX_TOP_USDHC2_DATA1	0x138e
+			IMX952_PAD_SD2_DATA2__WAKEUPMIX_TOP_USDHC2_DATA2	0x138e
+			IMX952_PAD_SD2_DATA3__WAKEUPMIX_TOP_USDHC2_DATA3	0x138e
+			IMX952_PAD_SD2_VSELECT__WAKEUPMIX_TOP_USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			IMX952_PAD_SD2_CD_B__WAKEUPMIX_TOP_GPIO3_IO_0		0x31e
+		>;
+	};
+};

-- 
2.43.0

