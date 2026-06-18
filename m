Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED8ECD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 01:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FB4784908;
	Thu, 18 Jun 2026 03:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="G7JPTqRT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCA16849A4; Thu, 18 Jun 2026 03:16:27 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECA85847C3
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 03:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2lPYIRNLiIWHDA99b2hGjohajEh6ouu8QwoJo6AypsP8M3m4Gdjp5DyRWCDybUL74+whvNuaI+Y8t2aXdSSmnifhEn8ys9YoXj3MD38pCX1onU2UqqBofNdZMKuvT6KCeWuy/3OSzSMIMv/y5HcpnEiXtO2f6oIyUtL/Jb8AmzXyMTJXKwffhsAbomeYIJ8Jd6br+e0omxP9gahRCTdidGJXcqgDsNnriorb21j3csnXxNpNkXB/Qphx9vpq/y1qt2MyHhiIhlNblO8/OD0NSVpO2xQV+rhlNmxpUaQzC1R44dQ05VEfQhNhSuShEiCu8qEgYUoZrNVrFnpVWzcTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbkRY5Hpta65u2ROyBY+RGV/x+mmUQIYCYHRmFDaPy8=;
 b=m/ySdDCCdfihVZaykvUT2VCrgbBaKARMy0MHns9GtzL4/RgkHH+Loi7UYQN6JGQo26/FW/bu2ebtWZLFYzcPEqfyVqq42cIp0tbSHkFx32kfUM7sxEk7W9KSbyVrQ/nx8AXbw3dEZqr2TKaia6VnehEaaV/H3jhokPgw15oNqzUya8bmwVSov5v3y+tIGSv+VwbFQK+7YV6bAYHK2eMkW+PhBJvXkiPVIsPWmmlNTeSKVNG1ELhwUcdPPy/yVhA98Z8h1FtPvnHR2kzX1jCUpm86eP3Mh+IRQT+VY3JLNATcx+STWBIcU4ekPsmWuVUG9YlvgyrhAWaOm2IeGVVGrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbkRY5Hpta65u2ROyBY+RGV/x+mmUQIYCYHRmFDaPy8=;
 b=G7JPTqRT7WnEn1Cu3CG/6yZ0su5tlIqML4qtEW+OYASIEwZ27aH+JQRV/MItkKeLge229nqGg3Xtaj3QEsqvFLuiuvKC88/95MqL8psD6bq+NOlVK57nJK8X5l20XXdsuKD6cC3QOojC62DxnXrBYMWbsn6JTEEdtnjJNZSSGUVtHHS332enXclg9NnwOd7JbUmulabZP/XBRlqcHF9ARkrIh6z+Ehmn3mCvboFKacQ1jA8v4SFere3CyyzX+WxjvbwUoSf15VGTLaBeQBa3mE5eBYhwKFPMGq0NFgNa6oOjw2k2uFOypY9DgL45R+f3UY1+xrcxBp2Sb5ja43Im2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 01:16:24 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592%7]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 01:16:24 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com,
	u-boot@lists.denx.de,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com
Subject: [PATCH] arm: dts: imx943-evk: Add label for gpio expander devices
Date: Thu, 18 Jun 2026 09:19:36 +0800
Message-Id: <20260618011936.2871866-1-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::10) To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|PAXPR04MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 94347541-383f-4024-0491-08deccd73692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: /0cqObLHgWe1up++WKRNDRXrykBwSDu02wLd3NSZvgQew4zJaMiu98FCMIt4GYjBZkWaej+GKp061riTXFu6uWEJdn01UJ26UrY477+RxNYSzKnGPfaUoHIeLUB+yiub3Lv/Ja1pl/aZxfPQRr1rbsnMtNA6kzpHupgrs0tGKEHQYJHM4iPKi4/458F6Hoiw4mjEyXRyWIw3Q/vTrcstp8j6P9AheIiRh6jYvpPUFSXTxoEN/iWQaqBG04R5f4kcGgEvyHh5DazfZ0Yv+Sea9czmh+AjG6BnxvLO7j7/ZbXbWCJs1NdTD2GqW0RQ0W2qKtmLbfqWo8ASuxi1FL6MpPzMMFUj0EoCyEAmc6dxS86Wq87rlUM9rYdVMR0+lw6NBnEsiGchzqXdf6ZCgxYt6NwMv2NkkFSJuZsTzMQR7bdWPrTeQhtakzfX3B4Ct+HAlMa2gRCFQzy4UmhSISuUmWzegcOzC1ZOum9af+IrmOZCWo+MrkFEd+lk9lz524/7X/wIUV/QtiaVLj8S0etlDVwAMcZO8x7BNZffNXUxG/QDopvC1DGKjuD+3OYGzq18WIilYaE8a2IKWtQ9GnwpW5inpc+eXGBL77sMCQTRIqhj7EfSe15RFKBpbLba3OJV56Q55F1olnBs+8qJgCsPTDtBRRWCNaXvCMYo2esD4C5Bsgbs2brhmgrVDq4+a6/I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5121.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(23010399003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v/y0ZbaiofD83p1U5I4B6DoVepSfNqMm1UppiwNMdrUx5mmVjT9cbNMYS1Tk?=
 =?us-ascii?Q?SYdvHHGjZ0OX+91eX77xFPlqeai5ANvi0GOZHU+V+R5H7N97qDdfcfURadea?=
 =?us-ascii?Q?541meOguYiUlXqQvzVp42LYBC0N/HbsC46jARNgGSF7QPJmY1kdxOIkauExL?=
 =?us-ascii?Q?NzLC/PiHzmdAnPPOH/5WBZorGuUqSLgiMhuXRGDiOt3fdtWKkXz4WDuKT/Po?=
 =?us-ascii?Q?EGK8YxVvn1VUOLOSW7oW6le1yywIkDcc9/ER0Qucs4i0S0g70hIhZ0oOCS1m?=
 =?us-ascii?Q?LdiE6UQtZ/kLEJXTJy7FitbLg81K9F0WpkIRoSJ5B5THATX5rAWVXJeFai2f?=
 =?us-ascii?Q?Ou2MOA2N80Re/dN0piaxggY0kiADfXDRwftR6f+NNSgVyBkRl0EIdu/5N2v6?=
 =?us-ascii?Q?Ia8w7E/AUzdI8GDcHBH3AQcLmFPeF1QMYVOlFGp/zAml1tId1O1ajH8HpaE1?=
 =?us-ascii?Q?ZFgpo92I3/asUxVL8BLG7UbrTfLo1irNm1HdJQW3pd1sjfKdNoWRRR7WvFgt?=
 =?us-ascii?Q?JeD+Imt4LKjH1Wp44tjW1OKh5jmBqmMhJnn7NybP1ryAyDmTla0HTTAC3xP3?=
 =?us-ascii?Q?4l4z3e0uUzsBmdjFkrU3q00pGQfUPvpLlWq6fs8zpVnavfHKmsx1vs7osjzD?=
 =?us-ascii?Q?a6CbmT4Ri7021Aynlf+wG9yT0QbTDovEUdaYUxMEoxZxgSBXD6e/DdH8h/9d?=
 =?us-ascii?Q?7KGvUxmot3JEo4G0C/znVeMCTV7zD24dxTmsWe0OzfWXcgpCUppkO0hS1Z+H?=
 =?us-ascii?Q?fSxXsyDa4nWRnp38TWJODA1BitY8LpPd+8CUDJ6aSPYM3IvpOtd1iLOuQH+4?=
 =?us-ascii?Q?zPvhV4OsNEHYG9LPzNeUugE2ox12odqasDmHq/HjGJJpeqI38fsH+fczUR6o?=
 =?us-ascii?Q?715w0IkJSfDB+Us4un+vkx2AjaKkv3nO0cCpJkEF45zKS2xE8BEd2Hq9kCck?=
 =?us-ascii?Q?Dyojel28xtf3buFLqxFMS2hTLTlXSv8ZCDXyDRsl7MVMGHLzdr0SZ3KtjUcP?=
 =?us-ascii?Q?7l3O4HN4CKBMhnpu56aVhQMVwBnFdDFMULxRXeLRPQW+mnmz9vC9B7nHMN4i?=
 =?us-ascii?Q?ZIHS60I5KkMfYFrEBS66Rienkn/uyQPRgnZmkZi9jzGsKDUVUble8O+f2QZe?=
 =?us-ascii?Q?QCCoIGmHS84KgPyVvgn+d4yGbLzMqgRltiWzx3tdCaWSR6pk2v5NkOjUfDsM?=
 =?us-ascii?Q?NoWNKy0aOSkmD2t18GPMsgzgCHzA3/f1MXivxEaedySEbbFI4uMFkiaEHFPM?=
 =?us-ascii?Q?qBm7ut8puPVoPcZXBYzUgZw55P+emceDytRLvUWy8oEq0pujh15FISwMdBGI?=
 =?us-ascii?Q?COf68m8frwhLNWTD/cSOFymBmEJN7GfGOao+gYZ9zEbQ/NVRiU0JXWHsZwdY?=
 =?us-ascii?Q?OENUxjcBoD04TRgg2IdhS5V2nD3QXu6q/864PMM2AX0n/U9eAcQOCzrRRXHk?=
 =?us-ascii?Q?S6l9tdkN653pklstge/V/A9qo35mEBwuh75Ax+HF1bi1X5fJskIYfbePCMAY?=
 =?us-ascii?Q?0A2HrmR8KbD/0Q2B2OrUNWtTkScjIkjUYTbjLMHQEXpzexYRYeSBt3jzdRfW?=
 =?us-ascii?Q?Z7Tz7Y2GyhA7fCWS12V/xB1YS6j1ScIcX8T+9+jCZX7dEtWW8W8Ec1KTudW/?=
 =?us-ascii?Q?21iO7V2N8ZDzXe7a8GS0+VV2sn/VqZBtep1XFn3f5r1ZyRUz+JbopX+e571Y?=
 =?us-ascii?Q?L30w3Ot+lTiZo9qrPHQRR65Id89a8FJGd/qok/ftTH9O+/h/j240OCR6ttGw?=
 =?us-ascii?Q?gDVoOpF9JAzMOvRjAm9d1sBRYBLjzQU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94347541-383f-4024-0491-08deccd73692
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 01:16:24.0244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Phlx5rglZkNn/fFviWkblU7jzImNEVmONCLrXun7YHkOLZXoS/o8jkrlkdpuyLUz4yqWkVMOTSJ8E6hQV1iTliHeeJg3fv2sSOHhVL7dm+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174
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

From: Ye Li <ye.li@nxp.com>

Because the i2c address of some gpio expander devices are same, so
in dts they have same node name which lead to same gpio device name.
Users can't get the GPIO through GPIO API or GPIO command.
Add the label to each gpio expander node, hence give unique name.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/dts/imx943-evk-u-boot.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
index 3b3619d2232..635a3042fdd 100644
--- a/arch/arm/dts/imx943-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -272,3 +272,31 @@
 &pinctrl_usdhc2_gpio {
 	bootph-pre-ram;
 };
+
+&pcal6416_i2c3_u46 {
+	label = "u46";
+};
+
+&pcal6416_i2c3_u171 {
+	label = "u171";
+};
+
+&pcal6416_i2c3_u48 {
+	label = "u48";
+};
+
+&pcal6408_i2c3_u172 {
+	label = "u172";
+};
+
+&pcal6416_i2c6_u50 {
+	label = "u50";
+};
+
+&pcal6408_i2c6_u170 {
+	label = "u170";
+};
+
+&pcal6416_i2c6_u44 {
+	label = "u44";
+};
-- 
2.34.1

