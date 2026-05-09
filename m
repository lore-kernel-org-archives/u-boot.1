Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA85CD343F
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 11:14:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F66F84D31;
	Sat,  9 May 2026 13:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="3kKh/aXf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D823184D5E; Sat,  9 May 2026 13:12:39 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11D1884D24
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 13:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHn8nyLCsBDbph4obZDa4s1y9cEYl7H9MAm+cQpHvuhR8d2OBHJrv2Z0ScIR689ddZPbKE4jCeSLgLT76fwdH0VsjrSE1lr6pgzH5Fkjl9ay7Gz7GvniUeDMqfR1lXb6ZbwHhGRtyAYjiSw52vQF8TB0sOub6nkSeNceQS7WXcyokrTiSgEvLP/43OQNArm2PDtgDeJdiYlznv9nWTA+uL8HAxPE5RcCSyy3dDgsMtfz2pQtV4npU7Svu1UUvekIjrCjGA8v5XtNZLnvOxvuZopEtLvIu+mQi8HoqERvK81XIqGlz0Gyf+NdT8gh4op/SsCP6Nu1QO5sNzMequKdfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHlAMtD13yfobu/KvAXsNlz1ZLoTsv7t4pXRszc+J4I=;
 b=OR1F1dkjCw1pXJ0/5nnrH5k6h7pHyYjWanOfhIobFn06oU9x48GJVn2gjisD/apwajAuGjWaX8oQ8bBPsKfql3JNmtd/M4znsn+7iRhL3lsKd8Z7311RvgPvTIYu5lZjaBmlBg7OEE7awf9g1dy6w1+6oWE+BBgm1OVD5/48N3HetaVdml2Mq4yOmbJWavmjfXAo7cSRgH5pe22aUtBHYajLQbsHh2BiurF2c9FcE2giZ3PokkZ3g+Bb9qL1Ru7r68GYTKPy1Sy47rWI1Fpk/LN+5EFGxEjeLeOa+8KCMC2Zl0RqwQMeCAUd9EXGWrqSo5wt8IefSGgtxj1J/8wIrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHlAMtD13yfobu/KvAXsNlz1ZLoTsv7t4pXRszc+J4I=;
 b=3kKh/aXfvw/S8qzBb+37oz5PizuwyMMRrXKHlFjrfB+k7y13Ym1utKVIAnE+364aYCq42ppnlZkKT8syHEvTJJWFgUVMJ8PMQ8wz7eNwtIR/oAbWosX2N8qb3LRnG74SJPyYZtMMVORHZQYwyBTYKxn74NsIGhEPF1MJaXPmJ0m+42uUvfqUzaOAt9S0VGEDttSyC1Jx3qOGOq147PjEXZ76P3EsekzGb1SSBrP0bI7UeaQkPRyt3rXzW8OkAeodhS+DCiw6Z/RNQpQ9FsJ86+c67oVqMVYBQCfiD5oZsezaqUhGYLteS2cgDIrXO4GvAoU7durbj2vO9aC6wWvZqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8617.eurprd08.prod.outlook.com (2603:10a6:150:81::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 11:12:35 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 11:12:35 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 11/11] arm: dts: en7523: add pinctrl/gpio support,
 drop legacy gpio support
Date: Sat,  9 May 2026 14:11:57 +0300
Message-ID: <20260509111157.4039434-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0004.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::9) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef945e1-f94e-4238-af26-08deadbbdfab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3NL4BEfdWraMkZ3sPlf7mrrFugWx0Pw60f2T3ARSPWbrstgvPvgVvQga3Nv9+c3DEtDpj10jH8Ju9XUMRvmzfVFwtpHlvKWJ3s0bAWI4Wg7tJddHMPPOzgV3GnJu1Th6SQX7YHbtCVZLThddDAhfI0pFBaYghti8rNYUZ/D8KfVXZ0bEeVmZhZgKdpnbI1bQ7S+b02Rv+Ol82PkdYFDYtYaWYrV+Hl5Yo0C4ezZYgXgz9he5dRoUavKsTWlfSujr+GF9wBQFt+1EAfltQyL+Rc+MpLVDcPe1zBjZ3XIrgMqqH/xSNUBhFrLM9cT/u20NQHpDX2Kl01Cb+WHkSYXswAD0wv0HaUEI8AEOodnfBxJNyV+WfvfoHb9vNYJxRcjQ24GtVMeHPS5oEt7OzOfhhEaaNj/FN8TkRcqzRKDBkB2qWD2TkG1p0RHwzBmCjweEMe7Ji45mGlFmOnvc0At/eg/lI+qfHZfOL00jygd1seLmnwExUJ/sHieMN5hBPX00zZ+e0i600gtp52uv2+3ghR2lD+kEaF+jswRwW3YCGHKAQQ0VleZuSZSC17U+Kr2UISVh7ZbQyWAOUnku5kyj3IPs0JxBoCFUCAi8U79f1TyewaHJAS+VdPH4vxE8LM2I93thwANXZET5zqpddscSzivfCeMmxLjOmtNNOOJAyTk3U7p3LHYxOC6u+SWQdpqgrFEm4txvDKl9Kb1Q4gO97hp9rPqkt5coYRCfePU2alophXVBZIcrD+2f9UY/YiS+uWfKB8uFiiS834RbAeHD9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HpzHAJwEhfrCvAXb5WZITLFvLGG0mX9hgIOCOLepv10w37XhwHhUX6bHdExk?=
 =?us-ascii?Q?xXzuP/H71ijkvnMCYW3a/PIEELSugorMDDmHSsbrjllyKOrU1MBoVLwpu0r3?=
 =?us-ascii?Q?CTSxus0NceHyHyec5oCNhmb/LiZEHAOdd4E8M1X8eWyRdfo+tOn+XJhgw1Ct?=
 =?us-ascii?Q?eCi4zYnCLgQkcTRJ1M0/HGWY3QutwtgAv+hbEVX/AVl85NSQNqVB0QSxer1C?=
 =?us-ascii?Q?GKwmlrnVJzlqnJL2sOdJmtEXR+lgUhsHJ5cB6lCxdTisGJC6BYG7CqCLmgNM?=
 =?us-ascii?Q?7KTZh/9tKxHHMw8ncphgCQPQytgJB0y7aFmFJ6467To4puVbfiXwyDIT0uZn?=
 =?us-ascii?Q?l2cTdWjpDOWcnlsC0stnqo17HIp2LOgy3oGHNlfoQhG4RaYnz7aHcpUT13Lm?=
 =?us-ascii?Q?WB3B6utuQOdplGi1MWZJa/KbmB0xhu/e3jSgreUndv+PF2WXTxj8CBrRdzIQ?=
 =?us-ascii?Q?7U+cF/xBCZlaUzKd/7KGZHvC650dMzfyOxS5HxyTwyjQavWU1UauXwrR3r1/?=
 =?us-ascii?Q?kD31H83tVFs5GZ2FT2OGKAQopwxm2A618+efRIt6UMYfNXWenwNEtnc20saB?=
 =?us-ascii?Q?LoYIaeMXxetlk/RyOFK97XcfhgsKeWEvcIznFBAhVE8mWlg0VpQ24Ymzgwwi?=
 =?us-ascii?Q?OB3sxlwGUc3HdIuDf4s7s3SZz320OK8RcO0FKwsAU0Cbcy0zBwJRKpMrz63m?=
 =?us-ascii?Q?sXzXoEV24kKvsEppbsBi7w5YQOL0Fiz6hlgIx9cayZJT2IpXyrJk6JFsiNiI?=
 =?us-ascii?Q?vbvqXjgC+qcdSSnEsanzFkdYOg5SXxEL3kzCypAzA91r5mPFWBK9brl5vTnY?=
 =?us-ascii?Q?MMt7m4+pYkx7puA3Y8w+JUh1y3o8/DfagS/C+8Dib1OIL03TKLOEit/+dYL8?=
 =?us-ascii?Q?fTZiCS4xERJP4kctZ/cgscN778YtI4lBbUB/8+b2Wsxk1/ONBIVUWvLHvj+/?=
 =?us-ascii?Q?A8uyvwslA7YDkWAcjHZcTu3C3TNvH465FSE+ljFFpo++qis/Yt3dcjNWAjxo?=
 =?us-ascii?Q?83PVVJxXINm83Ag+3RT5OFL8LvhV22N6cJXOks0hyexXhni8GXCDTo/34mb/?=
 =?us-ascii?Q?3ftPDGApsOZAs+xLVm6j2FWp5loIRXypqdN09e2BEJ+idDb99s2z4l5uGk4k?=
 =?us-ascii?Q?J4ULoCd5haGyARFR8wFKxFcLmVXRSK+Rql9xTNHa2578DLmGnwhPlEhJWTCU?=
 =?us-ascii?Q?XYpHfDrNfiHEUXleLPnpCgIzpPzJgRA/4D0TM9PfdKYc0C5YVErwZPPpPZJo?=
 =?us-ascii?Q?790VbYW13UPqC+XBFf6gVwFCozQVnt8McuO/g7SNbC3jEf4rWRJaLZxS3C93?=
 =?us-ascii?Q?DfjKGrtlGh8Okbd7iRKvryYcu73NShofEhM5dkPf8XI2Wx+uPFyMST51Cin7?=
 =?us-ascii?Q?0vOk6w79Yz4jvV+gIJ26ROPNd21Ie9TUhyyROjVKUXNAgDn9Yps724bjTpV2?=
 =?us-ascii?Q?nmxel6AdMZFr1g5/RG1ZkM0rCL1B4Eky21vlFUSpp6pnImUJqLmkaafHnzJX?=
 =?us-ascii?Q?cjgflieoUpZA+wqbsj62RES9TSMATllh40rOPYPhtL48jtv3kQi3YX1WGxqX?=
 =?us-ascii?Q?hJCA+xYcqHe9zdJ2WrSy4um+2of8iCeeZ5dxMCSuTuYIHqQLGeDqbrNIEzKL?=
 =?us-ascii?Q?bLd+nOypKH7Mb2HpAke5Y2HhIr6tFvuXUiop7d5iC3wWV1zxyrVE6ttncUZa?=
 =?us-ascii?Q?AkDDbwy825tSt0JM+l+VdTYJRbrKYTYML4XTqlir05AaHjRE1tU4JmimGrfN?=
 =?us-ascii?Q?OD4J4TNb3lu1U72y5Xd5mnjLy+4CHoU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef945e1-f94e-4238-af26-08deadbbdfab
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 11:12:35.7925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBV7ddTxn6bYOMXQSY4DWT2zcEQtR3rEnoZF4Hbiu56fIQQwFv5bpcNCigcalRqnc4Os78tC4pI8If31J8IN9/b75HltFODVD5XhATvAGp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8617
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
---
 arch/arm/dts/en7523-u-boot.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/dts/en7523-u-boot.dtsi b/arch/arm/dts/en7523-u-boot.dtsi
index 62d1a724678..c8287dd22f0 100644
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
@@ -22,6 +25,24 @@
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
+		};
+	};
+
 	eth: ethernet@1fb50000 {
 		compatible = "airoha,en7523-eth";
 		reg = <0x1fb50000 0x2600>,
-- 
2.53.0

