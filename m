Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991CDCD4F21
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 02:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FF27846D3;
	Thu, 14 May 2026 04:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="GuiJfyNF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C64B684707; Thu, 14 May 2026 04:56:23 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2769846AD
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 04:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hguM2yvzb9lsczgHSmW61HMpA9zUIG1RdlRcMMkVT0P65OO/nn12D+dFRADe4qHFVy9NLrRwEqe/ejcg6BEnSFo2SCZRCgECqZbmDltV0HxlQF/CmKdfhTbc0IDY5UOgV2GYZs94l/HEkfPum24/2gJBasjp1MMMJaDQTWET50xihnSbL1elWNTR14IdD79fZbyJgWljQuxtLBh1FLlQTCJZJkD4leZK+o3TZh8JDw7Mv7tcaF28LFXRlnK/Yf7+5/Ay6l87Q9AjcOsSOPqwL6YPQ0779ZLvJuz5TRaIXKNiOCQk3RXjivjRX33wKb5TEATr7njE2UaOwQ8k7duEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsDn18XCLpG5ZCJ45HCpgDwbSKYr9KQIxmBhbhPayN0=;
 b=MoTaWF2xeMDIJzs3LHtpa98Qbw1xOuP5UaAjnovAHeLv2dxHdFgSgjF+vPKSEy/nMuBZw+nq41ow759LbrABcD0yaomxAe4FB4Cu8+QOMoqcAgyi5nW3mkP4gHyQWtciDaJsQkfYny3J5pT+xWUveDppuHrTsIOVU+JgWnp7gEjIzkhoKGKoFBpzMkg7kk/lju1/7NM0r2bK11D5Tv5hp9Spf4Wa58PIme8mLIGCPkItMKjSiO2FOZ2UayFU0RSY4feIrXgEDYnpeoFpDIoGlItr/npel2Py9qSEVt53e7baHYVH/YnZgPrejUKU13DOh0U8yI4VIOVutMPP6Ox9lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsDn18XCLpG5ZCJ45HCpgDwbSKYr9KQIxmBhbhPayN0=;
 b=GuiJfyNFaLnIRvrC8iVZ+4kX02N2HP//+aAVcVC8B+kH9T0VphGpByP+EjSEOl4fkKWtMBi/XnaUjs0oOOBVSYcEs63h9xAHdqPxXZSzu2zWgjhHx9RidShSCb3oX6ZtyJwXflmGVh0tOHKaCaKBHXSSZdgoGjcJWZhw0ixWI8Tzqq0m2Bt+1qDy/3sXJJtQzTygqHOLxFLD5dbVxSSWKPfc5cpd0KgQiDWlLawpH+0oEGYeLY/LhWe2GP1ucGty72z5Zd08uUSMp+oBolBWe3uW9jhnKoQQny19YpnBP+O2PpesdxkB0PsIrdTVcghiZh5GdJcI33qs7L0SbfzphQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PR3PR08MB5786.eurprd08.prod.outlook.com (2603:10a6:102:85::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 14 May
 2026 02:56:20 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 02:56:20 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anis Chali <chalianis1@gmail.com>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v6 12/12] arm: dts: en7523: add pinctrl/gpio support,
 drop legacy gpio support
Date: Thu, 14 May 2026 05:55:42 +0300
Message-ID: <20260514025542.398469-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514025542.398469-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260514025542.398469-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B7B.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::411) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PR3PR08MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 555678c3-0097-4279-6bf2-08deb1646038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|52116014|921020|38350700014|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: hx0sR0g5Ll6iPgVkRzATC0S60SCgtqF9xtFKdpDSaqRrLAk3JKtK1O7C7oGslKAE/ZkLGa5tYrsAOoyOsqU9X3aMH0R1DA5tf8WU+XDHYnmlPrZK5dB9h399hWlKc/1YXVGVCogCpixn8BfjyuU0wDlBh+Lqvzv0AHch0zc9GHZpKExXgt4FYIAG/83/BuXL3QP2ZfZjdNdhKOseQCn6jmUKjMYebGi7wHJbm+AHOKfj+UkJ4W0tU1qI2ms+lptfTtbiqqBSKNyDbfiIMKJvIgqSInzREXlxCp3Lw3TR+qMcp6+kSW/Gd4SUFOQ7ADSkn71aCs2Dbsi3Op8D16euTUubek+VzkZWY+GfNxJOIgQlkSq+ae9NFklKAegQs6Kevns4eIfqk8159WEuAmLzWP2X8akLzrigk5X830FYhULhmM+ngQ3uo+dfgtrLGkNSTZcNzY02ANUyXKi7iDb6d3Dbt1RKMjInzxt7IvtnQYsH6Y6wXiwcZ9teIgP+8pRNnallPEYAWRuZqESpDevcexUkPRWGN/QJXDgtztX7bVtInIg0+UgwDN86YXKAIyZMowyEkg2G6xMx9h48e1lWHhk7mwN/O7iSey+XEFLQiGHNoFk3cE6H1UPIY/x2M8c7X2nWhi/KuEC6KIkSfVDKI6tfZOhgvzVxthJ1wn03CVqOWtCmU9NXCosCgh99nzT8V0QlWGsE3khLBEgzwwXiZso1TJXtO3kZmh7smt0J4v2jubfQX4jOoPxQChrSk97qxUktZKcVxB/XGJ3vl9Ru/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(921020)(38350700014)(18002099003)(56012099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3J/XWukePjUM3E7fTx49HT3kZvda9kTcwXQ64DK/nw0rxPvfKRYEMePiVJcX?=
 =?us-ascii?Q?YbJXY3b6bTQlKksHgvIVrJzMCUDg3Wa07iuZT7AGjC4vzXxX9UrWOS4u4ocY?=
 =?us-ascii?Q?1kv7jzhqKYHVZpM46O9rR4R5fgRhuH0NPypzSWrsboW96v+48NG5i8Z5I/Wz?=
 =?us-ascii?Q?GRjwIXbL+GLa1ecJ1d2hFK3pl/rBFHStJvrHWo2FTnGMNRSZzS0OpU527dnT?=
 =?us-ascii?Q?Fqd/0L4OOjixFz8iwCz9cP21DW6SaVdbzzOhHSa+Pubw1CCYAXGYYyv6rvyl?=
 =?us-ascii?Q?X0zzxPAwHq445so0JPcUHNi+2GF2w7AOJmize29/7dAt5Xp7cZpdwHxv2uFc?=
 =?us-ascii?Q?bl9ULv6rpAGn+N4mGklLuDhjqlHA1daQbo6mhn5vRn8ZyNloC68knscDam2F?=
 =?us-ascii?Q?ckwlgeir4O5bArQWtGBkKX3N4UCrTNgaSC+cN+BIF8VlqeedEtb9/Ab4hLIi?=
 =?us-ascii?Q?MqybSyq5cbJVvnTuWFN1IqhJ5/2+hUB0kv8CfSN2udEL0+ExKzlyMsKma953?=
 =?us-ascii?Q?27GX6MxDctYgwgfZPqDCiQirSHe5vXjsyQmjTeLP3g8jJ6ochpcQUd3DYNCC?=
 =?us-ascii?Q?bK+v/xUestQ9IAJY2CChn8X3BJR9uO4xpk0Ev08mpAEQsPh6wwd7jdEzeWei?=
 =?us-ascii?Q?VKKpSM7KSM1C4y6JrMBpcEejL0GWiNTegtUjJCKbvDq+PctFwwz+jJERCbMH?=
 =?us-ascii?Q?KreZWbCgWBCC+nRSyxTt86l2PQmND1hASiqr9zWGczuQF0hMonyJ1hZxO3Qq?=
 =?us-ascii?Q?qOkIobC8YGKzHvUh++F4LTmB0C6ylYdH/9EPtr+5QzNOtQNBqejxsaDZGxZJ?=
 =?us-ascii?Q?ZElg8MTnGuJIfBsPagxSfXSr6Aj5ncs9Opdh70rWQBnH2hkIqywRBrrb2PcK?=
 =?us-ascii?Q?6S5WT+YBBMFTbKgrDAUSlZVwouCz+Y7hweg2UWOMEwB+cEb9Q4YJcihbkOz3?=
 =?us-ascii?Q?n7+GdAvZMK4zuv+yoJVRI64/t9N3BW8W8wgVeazEQSgRuId+sczQhqAM2yw5?=
 =?us-ascii?Q?vZ3OqGrm1ScycGlmHbjhtmw6F/yS+7BPdSrE+4nEzKL7ZuRRv4Yy3ZQsyMdP?=
 =?us-ascii?Q?vOe+bdk/BoYXiTMd8zALs1QVNC2tT5BL7jV32GAcU5evIZeVG09n5sVt97nJ?=
 =?us-ascii?Q?ZUtljhQzohaadt9SKmVerq/z/IjPT7p+LkQiG/AbIzyqZS8+S6PCVN5/Uqiz?=
 =?us-ascii?Q?+MX+ChyaDQ4EoqBw+cieampkropXbgHD9Qj/jdxGeQA3RqcoS6cqcEXc3a3+?=
 =?us-ascii?Q?e0CNyAkkBZyPDPqwuKo7YzgfIJuC3d84puUzWpDcB3iFTD/gvuk9JMZVYcir?=
 =?us-ascii?Q?E52G3fYonor03zHpGv+U+/iwfl1+RteYgRp9t9H9d/zSJgR2hRQmBT+ISkKc?=
 =?us-ascii?Q?mtg7QJL2JuWIB5SN98R2VKujKwZlBUuXq17thpnspflCAlSGNbJxNa4zpDfD?=
 =?us-ascii?Q?LjzC9qn15b4CsLz5OAQ2npT31+mPqFLJfnUqfQpLFy+0rx+/CCYMUi7AF1MO?=
 =?us-ascii?Q?VYI82MNSPTK9q3Ncqibo1Bf2sVOHayx5okd5p29rv6W+F9TuQI9d4qIXJKh6?=
 =?us-ascii?Q?a7pw7A/2sjpm/+/Tz+yklvrjupHzgKdJ6qKrNpJ0iAOHNNucupe2cdSfM+ki?=
 =?us-ascii?Q?5FljsYaIMCPNnAJfnrf69X32e5+IcpZV2Xf/F0HdVvWEsKBESIOG0DKyBJxX?=
 =?us-ascii?Q?AuEDej+XdSaGNSYg9UFwVoBhtxITnMCG5hHHphg90RP2o3Kfpj6tf+hFfzkH?=
 =?us-ascii?Q?BUDXW2zn1XM9nf3cn7YugeQjroNTkl8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 555678c3-0097-4279-6bf2-08deb1646038
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 02:56:20.3609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkzaTTRwkR5dO7dNfsni1B/ZT3mEuB/k27a75CIbP997MT5kNsP/DC9ZjsIKVrZYlILyRIowB5Mzj1SpsZQh65Ib10Th0Te1CSa4ARSvZzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5786
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
+		pinctrl: pinctrl {
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

