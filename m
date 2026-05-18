Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4ACDCD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 23:53:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB37E84837;
	Tue, 19 May 2026 01:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="oj/+90Wo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D9948482F; Tue, 19 May 2026 01:51:49 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 989C3846E9
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 01:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pr4cs8ZyQeIkER0K02/kXOEk7foA7Jiw8kY+o6jYY3uK+n1rlmj6EzZGh0VOArKaw7SCxWl7tYbaQGj/6P+hVs0tXqbSBJ8fLSt5qWHujZxj9UVo+DGhIhaRBwPY4iCglIHrooqmUgDg0qS162I99fqDWkSplyelTQk/CZeiBkGnrqvmL2Qb7ErhgdliEizQ2oJ86XAL6Y6xSMQLGp4UDZ2Q1oxZdp86oS6rKSAKg+OkoUtGsBmkcv9evvevI6TjwWtJuZdML01hTJXVDO2BoSn7HZaVxpyv6NQCYNiX4RIBg8QnrqExJyOHphlU38HYmEXm6JDmsC0CND0zpI50GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRTex6gCya5zwVDj1W7NgqE3j/uoQc9AuB7lnMPO6oM=;
 b=Ot/nDl4cZeqPvaV1Ry8sqaq2rRyczLllhIeQPNeRPSeARCX3PlyyauKwGVrloFS+UxJM6NTzbSIYWA3HWso9magjDf03qrA2Bwb2yuymy7tnJTYjbqLV0q9uGbm1jvFLPtzVasLK193JrjXP64UVto7rD0d44R/Qwktsnw/VJ/pP5bEbtQ+Ms8fHT743F/WG0l0cl20vtjk+9yb94Ks7/w0DgyUkoMXcLV6ldmH6/3z7slcnkUJsXCwWxeMAcBved/6OZAIRDNvE2gQ747EjOKeoa5LIeEUPw6xcwTTa7d3/wQ9V2GGFV+QysA5QDMuDZ+bVnasfvKHToNG/MifxsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRTex6gCya5zwVDj1W7NgqE3j/uoQc9AuB7lnMPO6oM=;
 b=oj/+90Wohee+NgcQsWNiq0Ns49scyoXkHhrtGqnYlPZvataD5XeIsg5WK4QTWkiyY4pV7OJD/Znr81RS0r+HPZkWnkFM4no5MWANn15SsXtCzOBPNgubZYBRcBVeCyon/AXieE9ZxW92I59lnARSaWmO1VDmRtZ8a1aNDtB5wDPbV8TJQ8moMvdm+mJWF2FkqNTftziMF3dBIBikFg+a2Anusg8dtbQzXKhzavpOUT2xk2ToFlcgyb7inlJSCx76VhtXBiy2eVr0pZgDySwmW4lPOUBIb1QiTMFFXrpGl3yTJfNy5qny4W3bBFZvtLWkQufyQLANAC85ukjCQx2vCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PR3PR08MB5802.eurprd08.prod.outlook.com (2603:10a6:102:8a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 23:51:44 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 23:51:44 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Dan Carpenter <dan.carpenter@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anis Chali <chalianis1@gmail.com>, Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Richard Genoud <richard.genoud@bootlin.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v8 12/12] arm: dts: en7523: add pinctrl/gpio support,
 drop legacy gpio support
Date: Tue, 19 May 2026 02:51:15 +0300
Message-ID: <20260518235116.2664557-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518235116.2664557-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260518235116.2664557-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::6) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PR3PR08MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: ee17ce3b-8a55-4503-181f-08deb5386ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|18002099003|22082099003|56012099003|38350700014|921020|11063799003;
X-Microsoft-Antispam-Message-Info: TM768Qyx/RN7tTSt+Nqd4Ohs1tx13uOyU34WMO6X1ByxRpNiD3lzemouK0jA0nAaW8VhsTvh0drtB/b28lpvFn6a81PaZLB2JAmZDw+QMSS3GFkyXvOBOVj5Q31inTrUfsxIJluiA2i0+6nRSHU+CC7mjtMMEceNrmMLMFP7aeULaSFY9bBkJcRUS36kh9l4xZeMADAuwuVEvq7S8N6IgfEdVjJl2374irvSSzjqdsUn1hZUFbaz36IC/0VzbVAUkPJWzzU3DoENo20Kh4LvuUIRsQl38xgC4g75F7v8gOEbE7geY6QEXvb6XHAGS4uCWG0huuWm5cevVqZcDRcqtntZdhVoz2rZ6t0rCf2q0Nu/O6R/lofs876yOX9x4UZA9Zr99DqHG3Ov+3cymnfId0vpnYaaXWNxBGaTyByOSs0hx3hEJ8ZCYSqPfw99azE9rwqwMm+4HhNcmJ2TIh/9+xJvoX565bzSr8QKDZuPBUHnq95n/ifyz/yHM8OGlg8KHmEN2zk39hhcoSiUNfQJzHEPKDzO8NqNSv/9dXfKjsRhHLj/hDNIJKuBKj3vVlt/4rJqAqCveuF+fP2FqYPiUkOk4eD62X96LOx31PFKoHjRNZ8zzz6Iq+7GSlKlTIEkHl3AYVomauNRclTOqcsktoZyFuPzlgqgVjb91iKU656XdRebW4PJtXOXOvLdEvqG1xdwxG0xqjChyr7piwW48xE7zLm7uC4Cda/vx8tZlBiiRq/YfjAbt9kTyb5Vl8i3CeznPkmNNHndqiqsp//LKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(18002099003)(22082099003)(56012099003)(38350700014)(921020)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ak37kPF8K3R2ZBPFnqlsAv2HtO2QhbW806lRa4ztiECeGPbfEOkOXC/YJtT?=
 =?us-ascii?Q?0F/f05Uji1UYggIz1t350NiVfMYYnhwE9NlgtXClsiE1J6Vk9nnMj4EwGJ2t?=
 =?us-ascii?Q?kAaaz/e6bDZ6DeXrN9q8C+nc094IMzL1BTRbiJnCWWi+hyP4IiPJP7sQoD/U?=
 =?us-ascii?Q?2AcPULab554+TmRER6T7Kha1IgizJi+nTusbHaWkBEBnOGKfY5a/fZmYYeGa?=
 =?us-ascii?Q?fYVRlJUR0SVrk7DglhsFC22Ou6Mes1cMs0uohy122rcZwmwgT5DsLZncuZ8j?=
 =?us-ascii?Q?Vgtk8nEqjzeiXb+uRengnDwFsVJfoMYucokMLDqJJDsXDLmae4oGXKKTP2TB?=
 =?us-ascii?Q?MpdGQ0/dfEYBVGV//NXqs3WfSdh1K/uAMLm+D/+KS8qHoJYiDdM803yp4IIK?=
 =?us-ascii?Q?l6YyssT9Jf/fM9TqGXWnfRf2u4HN4H0W3xrfsTNB9W3AhJCMoWzSNT+Y7M0O?=
 =?us-ascii?Q?x+9LHW/EzdB07ZnYJe1NTG6y8HWfwHlnamu+0zo6m4O2DRo67IaqxfqNmsEx?=
 =?us-ascii?Q?pD9L9e1tyK9b8W372ZGKfCjjfJ6W8TOCVlflgh6nAOKqCmND5zNzaraa74Tx?=
 =?us-ascii?Q?B/ZXEVVl2tRJJo5Rudjpd+s03CsgVU941Qw3gRZB0xOJGYWEq0u32L2hk2oG?=
 =?us-ascii?Q?FRxshljJgbWXirQyd5osyBTHv/VQye2uKqJDeLyjtWSzT2JB+4drLkRA/cwr?=
 =?us-ascii?Q?7KYZ43zke2yB2dx1ReCY3eTpk+Ux22nqKUfW0xqgytAMFYGscFcyD4boQaDj?=
 =?us-ascii?Q?WYPsscHvAAe/aV5sG35IUb/H6OLP/xq6jsPhEwhlXdW3NzpnQ455Ii8suqft?=
 =?us-ascii?Q?zaQzaJ4kyl0Wzo4buCDCcWGMlaHCoaqMR64nRUb+hp2Ncjg4FmEQtH5HNQtx?=
 =?us-ascii?Q?KNuTvzOw3LqQ0dUK0kLbBHiV8KmOjXZ3llYWhwLw9pArfbXFXllkhgJtre+5?=
 =?us-ascii?Q?2b9YJVNKb3fPk9wdQvwAB7c98ywEaNFKs2zWS/aYm9Aufi4TuGifPZTozhHk?=
 =?us-ascii?Q?NS3/Ti3DU8vbPHVibw/VIvy8Zzy+p8PFC5T9lVuWJIJSxzzFLlSNpImKIN39?=
 =?us-ascii?Q?YCkPVLVlgcBX7kSjKdOzZe4691gPHhn3Bm0nLDu4nHfkVJ7EP8P7uqLZYhiT?=
 =?us-ascii?Q?l9hdt7UDDkU8snBCxyIegk3DZ9o5yF+l+SzNsgsTmbI7+DovnHRxLtAAnuO6?=
 =?us-ascii?Q?LM7TDixshig05G/RJzLFV2gaVvTF1JXUggaRdXzdJvnP1jd6FtlfSBdG9BeY?=
 =?us-ascii?Q?CIYgr8Y1GZn1K5kZ0OpL2oD3hJEDt4EA8a08Nd7iwP6KlRJ27vllERod84ik?=
 =?us-ascii?Q?fCgr1TmYFndalANH7Z65m9YOvNFXHr7eOe93q9ewzRvvad0n1coP/IUtx3pe?=
 =?us-ascii?Q?fJF4hkgmBeEOpNTj1XejA3iYAQyOPG2esctkRMJSIbprY9py87QEY9jZ4vEu?=
 =?us-ascii?Q?aVU2dKgkRgkZF5Mbff8uAVPGZn8k2kZpqUfazAxxq7R0iLIHnvoTZELAt0op?=
 =?us-ascii?Q?KQtoLgFXeetOuGnul1b6F+WzTkGPiXLlsJcCDgzBn1si8jdmpXR8ayNcA1Ar?=
 =?us-ascii?Q?ojD3V20gOzG7vMd2YM278hoEeuGWpHuQINHqfITNikp8yGQ1OKbyOyVAvy6j?=
 =?us-ascii?Q?YpQgo2h8bhzPSCwks5z12aNX3PQNfUisvI1xhcf6vAKZzWTl8oSK3EApxPsd?=
 =?us-ascii?Q?LUB8NUNo2v9IHOWeLmdReBLu6EB4YHyAXtnPNCJy2KzUf18HvGpKKOnvIh8F?=
 =?us-ascii?Q?XFuaQSCOJq0xgaPjzH1zWxBTLZWW9IA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ee17ce3b-8a55-4503-181f-08deb5386ab3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 23:51:44.7272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0l8cJjIFzSom4xw1eJR1C6aGJTj9NwNpoigCRN4FpNAtpWMdr460XVc7rW8G36pHVpStMwHMIk4+N9hGd0kTGW9loAnKM61P0FO/knLwHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5802
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

