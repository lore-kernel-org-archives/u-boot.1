Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7DCC44500
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 12:00:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7CCB84AB8;
	Fri,  3 Jul 2026 13:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="sRXj8eZq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1914884B59; Fri,  3 Jul 2026 13:58:21 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 424DD84ACF
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZO4Wyo+6+JxGubBHuDzZPitCseVtoCxWagn+O2AY5G9hC8EREcPwUx9Hj3l34/H5DuWa8WUB2+plxIuSdQp0E7j4JKsEKMEeygA1LNUjUj0tG+t0kpwcspsdT0BwtzWHX2XFW4Gid8duxcdF57Ay1saEBgP0ZTx/uhTywpqAn7J8fybtpoWdeZZBkNn+MBUhX+ZIBILDajajvKnAzGzTuCn4PO8pyIExYYfrcx6agnk3iPTZZ0VOptuofGI90CTYCAvlxeqV1vfeDMmBbXPG/YRLq6/HKh3nCUP61+5oi45B4iLgb1IrZ1YEYa+nS8ZWX4asuXADtP0Dl/d6RcupQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuN0P+W5dBObXIR75uFKXGCYqMbU4qsYQK2xPL+pjP8=;
 b=bWPolFrbLNhVoZPL6R6+lQ3Aa+p6b6oCZZlOFtiO3PxmLxrJNpGnNm7LtLhqTVlz7jh9AfvGVJEve91daGc7g5JbMu9Fw1un75bB2KOOgbghdSdQeP0qfqAzzX5cqBnlwSkdiELdlYvOeCPjclfjNGDQrkBkUY55WT9D6SE8PdH2Fy9kiROUalme1ct0oVyTnTMk82mYm8xezWnlDInEaQax4igpyWXlX3s4nMoOc8TBbVTKmNVWcm5OXa1IfUzO1kq8DKKHGoE0J6Pu3eLLsYiQhvDJMAdKBSKaAyu+cX1K8ikENstX2MUZB9Qgjx+600PuXmDDk0TgY1GyfUBunQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuN0P+W5dBObXIR75uFKXGCYqMbU4qsYQK2xPL+pjP8=;
 b=sRXj8eZqeAOtjrGJ2Sp2wIc1XCYuxMJtij0XBWMfb8kPp4oiX0hjkci481vFAN15j5oCGNvKUSc/aUgkgSU5KmziKHGhKVwWD4I+JrnfGkJd+nxHl2GxX6lZt5KEoRfzFFqq5judj3/CLwEoiIrHkuFlttKKS6ZovrnShBrG+qcnKjC4GiFtqNkkQzb869Cjl1XDX6Zbogy02q06sbvCJtOrVcEEjV9i1GGw1kgjq4IoPRioNvfYvRkux4oE9nWI/cmFrvyOqUyTe8xMhkQtIf9qvj2wU1gjPRZ0ytBDAL2YW+a/T+j6u17y4/hLx9Mn3SoKJ2N2BTFUf9MPJDEiKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB8172.eurprd08.prod.outlook.com (2603:10a6:150:7c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 11:57:50 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:57:50 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v15 24/24] arm: dts: en7523: add pinctrl/gpio support,
 drop legacy gpio support
Date: Fri,  3 Jul 2026 14:56:27 +0300
Message-ID: <20260703115627.2317120-25-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb675c2-b9bc-4252-ffeb-08ded8fa4e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|52116014|23010399003|56012099006|11063799006|18002099003|22082099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info: Hznc/0n68XzsBsgZIq//SLNyUrydSiwDYprVCsE8zMsvh5qCF9Nk/XcSBSN2s24GkpUahurKJfCEwxeAvQKa9vaYZ9E7uj41hKJ+Z8UN2rRlT/fxIgNvgR7apFdjw8UFSfA2Ki1tcGpFnJhj3rDMdNJ8Dys+6izun532nEJMj0O2BwhQMQxn+9ioYTeVrTojDM0xc3+42mHR5fdxtsj7IsIFDmi63V5zZHp3/BYnY0IzODtSVYQRhOrWgeAwf7szcA51oU01sexbfHls7S9FWM6cDi7ImMZ0p2J1mDqBbavUUuH21vlJ8I/ZI2cn5Zg/Nwyo6fV/gXv9uR836UHDFsDqaHuzr3Nykohox+zlthGx/f7AUfltAg2WIJY2OuUr7kWHgC4iYIaRIyZ/5yTSNefc82WfJZB/J/gjKE3nettdcO0sfSFDggxJ0UbmBOhblp1DsNagxguvfsc9Ktyz7xpYxSC2mUJQgLuAALfgTmx3JlZfqpnZgW6ELh7iVvUZockq3y7SL+z+KEi7CBKb+Po9gnQUzF5HeNcNs8/G1VmGRv5yPyDBMhlv+duMTTnxB4b7gEa+scxvxg7E/3fNyNroEYrtIjBsO6/ZFOFQKd3Id2t72G4hT3fmEc9MLJRKGrEEZaaaX5bDsuWm04CIaWU7CrgTEP573WnpH9qcGFxQgXKIt0OUe79O+xHGA3DK/+vs2iG5p3NIdsQCbBO3lE8U1fkWaoQqUngQ9ylsW+sWQQkgK0yXcoetU+w0xk2a
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OSFYnH/v8nrJW7QERLq9D5Fk5Mz8zC7xsNGF2/07rcmgnemj8azpr04iwZVC?=
 =?us-ascii?Q?lHR5d6kUo/Dd7mjyTYzjLj6+Bq2Ckgs1kva5vzSq750QcSvJqhaCzz0zCscz?=
 =?us-ascii?Q?oWr0vwi3SLf+0sIPbjUNwVEBIISeMtMZbuA323uXq5Y54CO85++1uoKK4M6C?=
 =?us-ascii?Q?vrnUhuM/pX7Qh4e8xxP2bKk21IpQKt+PtTnUIKN60TeujWNLC/vgBJSn7TLr?=
 =?us-ascii?Q?F0TXGOyM0nwU4lFH8bsMgUHAjKrQJ5D4tUX/f8mLVpP7/5v0+IlOib/Ogje6?=
 =?us-ascii?Q?LCcZUPU1Urgc3yAGArFy/IKMrl3ySBK+QVKj25Xz0lwej4v1TpvyE72t6l5d?=
 =?us-ascii?Q?hSgsgIoOg94he2l3SMEZ1TshbqnIOAxlyjH14IYR0WIIUJtOsOWcUU2Q5eO6?=
 =?us-ascii?Q?XgS1xD9u3/ntSLjrVJ/RSydP5aJHEM73U82HJYOLsJmZL0Y+Du3/21lOBxoe?=
 =?us-ascii?Q?r1rp2TayWv7uOJNJukPk/R93HpTd03JshT2n5xK4ufxSpJNmp9CBawbkZ3xC?=
 =?us-ascii?Q?yeWMOU5689r3dnnApSrnY+rtQ3OwjD8z/OO/dnSyltdGoaJXggjOE5/rDO+g?=
 =?us-ascii?Q?EuKZR7lry831QK+dQgGNyx0gbTwtOpiZT6+c1EE51A03yaCDTohWF/NJS6hz?=
 =?us-ascii?Q?zQT75vEEflTekFYgUILgPDtXisaKUVVAI46zikwEJskxv1R/0e1urEfnVmnd?=
 =?us-ascii?Q?tY5zXLSecMq/jScu8GscEL9bPHckZylP441CrNMJydFeVpxdXu0wFYZAOM4K?=
 =?us-ascii?Q?HBWD9w+OTZrMV5j+gxHPB0kMZEe3R+J3ZQQMxvVYQnBCH+R2z2jvO2JDFhwy?=
 =?us-ascii?Q?E+AGR+LkjiYkhXKjDbAhmK6u7n9oTrlOT29WVG9/axg0nF7uyPHP63Q9mBIN?=
 =?us-ascii?Q?5CAok9UI4txgtZvhHLfAUETmtWJgdvVtBuzcg0bhsV54dENPtgU6HbMABr9V?=
 =?us-ascii?Q?vFILplim9AYRUJZ/5lVIKMuIKcwAoc8l25UAX4dOA0Je9/A7+E1bgF1vtDan?=
 =?us-ascii?Q?068t2Q1GSUJHyEOqz+0q4b6wTVaF+ybviNKmdFnbACw4i+y/xCouCtJb0Axu?=
 =?us-ascii?Q?6UZth0kXzbpcWSaxzKcKdbx1bg+S+f7xOpZI+P3uPFv4CHOiBRSsNeeeyu2v?=
 =?us-ascii?Q?0EwXspO4kK2FcQS9K9F+k2ILKXG68rIBcVwGN8xqY+yylpQP3tq8u04UGfwN?=
 =?us-ascii?Q?IGUJg9I7T2cJdr4/0qJBQx5+6tjOLA6+nS45nVqAaNpRZ4QE0dvNici5OxFv?=
 =?us-ascii?Q?yaCrwPz+WmrvlDoo5+aMqVmMWCPxi6R8WwiaIvGIVPYDJcFwnaSQXTBx3cEe?=
 =?us-ascii?Q?KAY520ZrSHUHRAefAJdswBMT4BRxBH1nNwF5YG6rwvOl6hTvX7PSw/KDYkhV?=
 =?us-ascii?Q?XsrsP+DYpAORRMhfA6cOx9lm4+WRX5I1P1+DD+rIpVVGZSkt/Rla9T2GFvO6?=
 =?us-ascii?Q?LBPcVBgDpA4imT+iqUakIyBhJV65hoqU1SYvCkhtinol5nGq4uzuCbW6vtSJ?=
 =?us-ascii?Q?JAT7DDUdf42yJUKHpXQmDtMDij6kTrL/nHp625UeJVmXyQMAIGKnGKIpZOMH?=
 =?us-ascii?Q?cDAIzKNV+Y10R8Zay4T7HJD0+EnQF1YwR0eXBIS1+Dazus2YPPhkVbrdOxI0?=
 =?us-ascii?Q?TFrHgHMD+emDYZKSdKmgC4aCjZXBgtR4IxWigGzShwM02E3sD/CrPuSGmAYR?=
 =?us-ascii?Q?xNPUN8VoGha5Kgi8Yimx6/QWupO4ywLEJe2BCd+vmCQ7QrGHKTf8ax0xZpC2?=
 =?us-ascii?Q?qDsJGpXdemuKnr8cmmrWQR8o4hFcSo8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb675c2-b9bc-4252-ffeb-08ded8fa4e24
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:57:49.9472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aViAWQIYyh5xneiTdsaHRkGAgUpX6JLYeBJUBQHaK+vP8WpTDmzZUwZc6uIfM+r0X/ButzYaW16zubzyRQfT18WBlts+WzEuye8diZyuwLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8172
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
index 62d1a724678..7866a3552e6 100644
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
+			gpio-ranges = <&en7523_pinctrl 0 12 30>;
+		};
+	};
+
 	eth: ethernet@1fb50000 {
 		compatible = "airoha,en7523-eth";
 		reg = <0x1fb50000 0x2600>,
-- 
2.53.0

