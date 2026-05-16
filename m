Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB7ACD343F
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 01:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78EDB848D6;
	Sat, 16 May 2026 03:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="aJCnfp3U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02CE2848C6; Sat, 16 May 2026 03:01:19 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC63984713
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 03:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhqcavwhRZCL1LPPO+GC0mbdJiVdIalbV7rNh0s41mKSbG6vpJRea1kEdCXvkYKcIwXp+7mBMC3Rh3SMkLJo0w2JRvvygabCCoMT6QUVP+cD+Z/YnQJg8etEJG3SDoXl5J0EGG7mC8YecFzmxYj2AUg50sJH7CV9HWqQS144toeh1pW+AuPE9lBkVV/tJirJDYB9npO1YiCJveyHIcC3iJipTOSEzaXuP5EXjS9gsGlUjbWv+L8O4lO3ea5YLxBsbigLq9uy6S50+rnb5/v0DSJZNl86RJigcTnRCB41hN2Tn280Wd46VSZmp0HR0YZuuGAExJTznjli2ig+7w1icQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRTex6gCya5zwVDj1W7NgqE3j/uoQc9AuB7lnMPO6oM=;
 b=Uup+rqGRbVSmhMia9sPVZ2hkFf09iQzh3cDX8am6KZvug5KIvZgNwUifkGjx9vZ7dl9ygBzyfxRJ4FJD6IJGLP1dWMDYEPezsdfVPdoXbBo11xwSU5auOpVVuw0sfVATwpJpPNfwVm60HYggB6o9FSLkuO48QSZyb6eXa7Boy3XQ6O6Y67jp4v3dFN67I+6GXxjxgNR09cBJ/i7+GtFQZhlqSwU7Dngl0gjEcPpjo8b7gqOZecWbReBPH1dI4H+XHYN4hANS4j46Nn+omz8Hs7U5qx3/MvuQFypFNm4noGdCop1BP7oXkxMQ0Ls4C6aSuFtJIzuhHayJ0uzg+E++FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRTex6gCya5zwVDj1W7NgqE3j/uoQc9AuB7lnMPO6oM=;
 b=aJCnfp3UBToyvubEqmebALeXuYriHb0ID11XPFVZSe9BVJ8nM2hxoAeuFP1hm6GMX/GoxlcXP61AGgslsP9puVkl+TxZ81+FhG/O9CJX0MuxTqi7g2TQaF19ImQVkmI3p/ET32hQkTtEcJLy7HdMUR++iaXy9fojhPFSKnRm5oKPBERdJJSrnQt1PgZibVnt5D4gZOCPbdijNROjeuqWkAnWTRHgjoSMHzQNIn5BhFbibG6ABIJ5ilOwjYyi11ps1CV7KLZ3aHq+7G8yb9eEq7/dDy5ACsuZ01+urrU8TpQFAH4ZNs/Us7DUkQb6AYxmvMx1cRrzCAQ+6rHYe9f0nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS8PR08MB7917.eurprd08.prod.outlook.com (2603:10a6:20b:538::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Sat, 16 May
 2026 01:01:15 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0025.016; Sat, 16 May 2026
 01:01:15 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v7 12/12] arm: dts: en7523: add pinctrl/gpio support,
 drop legacy gpio support
Date: Sat, 16 May 2026 04:00:35 +0300
Message-ID: <20260516010036.1034352-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516010036.1034352-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260516010036.1034352-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DBD3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6a5) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS8PR08MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f3762a-1679-452b-3810-08deb2e6a11d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|56012099003|921020|11063799003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: yKCZiVvArSxKvcTEX0M97Pcz+6eD3+95bfDy1Iop1HPkRKg+Tf4tLOcmfSthxVxy55fLoBdoD2nsqr7AcslrtDT8sw24ZY+idlQyhniVsxfjNUQuhAHg5y7Q3Wk9vxbnkg7PUGbucyzNJtQBf//3eTD6KDirMKvJEit5Zwn+Hk8c38MHP76X6bJsbgxV3wX07SBra9reGjFZOxBttUQogObMifFe4M32wa2d2+qVoMMMln/IUb5wBynroh1KPgUuanCajCUQMrIXF+mQ3PgTIda2RuD1HFL7lE9dyaYcZ+fMzQpLy5Z1GRfSofj0U1CGHtDd8DN4fCQdBeXJC2Ve7Cz1UiOdTq9UGGQXvdZVc4VlKt4ExPPV1RuNvPJPlIBqfmvt3o8NQZEZj+T9z2jStHy1o/Mce6RCca4XNyKf2ykme7O4wJtGolpIVy6hY4TFr0sK7damZwnL/lR4maMwwKPIB2nbzzA8rCEgYtNFGq0owiiw0zpmUkjxU8+6FgJmPBw7MY3oeTvDqabUjCkgyDr6/VT3xVMUCU18M4W3U+uxLz0C+M1xNZWpeqTs7xVEzWttxgbKyDBuY3o8LH4aGCa/4dt5sbYInY98dfGg99oBeDP5Kgxsb02x2jhJnWMZ5hR3JhMpI33qW6kgDzqxwDLuPvnP8AbWQfRREbjzQTsShR+bUjG89EUBqPbR6PNaBIMttGCt1JBY5Nk4E4tNii9/Het2KuxJEfr3PTXcN1HOr39YP72V7vnDGbv9lG3htw2PD4X4S38EGc3fvXA5YA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(56012099003)(921020)(11063799003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MF3G52ouK+9/7cJ6JHvqfLo6K+FuO0uNpyPN9zFdGD2qp+6gzf7H88lPtF+6?=
 =?us-ascii?Q?rRhd33dOwekrqIPXAgrht7FyhTtC9UtWP84FCCVKpRrl5yVd92M8aMKOruUc?=
 =?us-ascii?Q?LqRgQR5+gxIgRLGLam+fn31f0iMdpRozByuPOQwXKoQZ5AeLxMYbf/MueyxK?=
 =?us-ascii?Q?8sGc8nu1BR9jY9K5JWLzS0sQxZWB+PXvePmSlM5Aku3IOLfPOLbBU9IbuWEU?=
 =?us-ascii?Q?SPdNmyuOnM4+xD/dars1MfVcV3iSOFf9CvnVt1bn6OMmmpPz6AZ6hQLfSg0w?=
 =?us-ascii?Q?r3QJHuQjIT0C8/1mWS3V0d95yxi5rNoomhVI8F/32ijRDrWR3daFmOIQEQmg?=
 =?us-ascii?Q?+4Nc6TmGNuOcauf5iThSx25vwxVpju2OASuogPs4jBy66BJ1ANXaECwwN9sr?=
 =?us-ascii?Q?iV1laAQNOOlqFfja95dE4mp3hu6+CsAwI/OHh/NLoeXW7Tl1wyUEscMq4sEi?=
 =?us-ascii?Q?W73xw4G7Ykgyi/GLhg591l9N+tKdIW0xBrdzCm+YXxMFLqzoWtxz6WQlamy1?=
 =?us-ascii?Q?0J2p9Qq24PyTtRgFAy3q9CYNCWZA7IKKxt3kZTB7jstJ05OhW3iXB10ueG7K?=
 =?us-ascii?Q?wJ+bpkFWUfY7uAx2J5qsHXyth7qXdtt+E+K2g0+OOq8nUFDHZfTFTll3b700?=
 =?us-ascii?Q?+1tmOpOw1ClTuZmhA7GUug2OgBFOX5cx0X1Mldeq7nRj7cFrXvkA+ziG1u4U?=
 =?us-ascii?Q?9Xmrcef6VMG1IqSFgVNjnKluV3/umA+fCggyLMIe+ZkpTO3GMIHJyJ9O3An4?=
 =?us-ascii?Q?PCXV9lqcdyYQUiO2kExPoqZv/pEgt2DjlB0bgaAO6NI+m5zKhl6/Q8lYdn8w?=
 =?us-ascii?Q?QZlCRctFAATkZBfLc63etRz2QfqdeyBmlpQBFvJj0ZaMcBmsau8zsmSfbLol?=
 =?us-ascii?Q?PLZjyMv5bEVGKDoqSwT/h26glL4plwhsnyT6xxMw1kP7OgOaSTrevq7yifHI?=
 =?us-ascii?Q?tRib3oCB1o2hxqZ6Z2vrQOWhAph01OD9ShO5zkb/ejnrgbyetvrQr2AEm+0O?=
 =?us-ascii?Q?1fiprS/qb3DSiPpAwaT3QmJ0DPbReZTp504DC+INwf/YlysxNnCvKv+SD6Pr?=
 =?us-ascii?Q?WKkwaehLfbpu9xst0q2o+9l6bf3n1aEV3CKAyllzIZNpVKtOquPNffQeLfkO?=
 =?us-ascii?Q?zIco93cywmAsYzm8nDbjfJfWqMGlpmqK7hk7C1/HxTwn/GeP2YmfaVdoVyBi?=
 =?us-ascii?Q?u7ni/R7sMup73ai3cz+5R7bekIUV06wU4kYwlJHu012uYLy/kW5La0eWGcNT?=
 =?us-ascii?Q?g6e6JSIXvpMtF/PUp6VI3bOtUrsqhfjUiEXfHqgptwEyk55btD7PqJ4lm4mM?=
 =?us-ascii?Q?u/F0Vt17dnV8EqAhzdH2Xzcc3Cp2y+qk6eqmJTJ721f+CxS8zyfRwZpyH8RC?=
 =?us-ascii?Q?pK6zBQ36dxuWHo5UVAMX9LxAv4LlKhY9VKPczcfj/x1ULBINfw2+EcQ+Exid?=
 =?us-ascii?Q?L7UjlakFfF3QcdPoaTrhyME1el6po9WV80klVR+SzMGIm1abHxcRpt4oBdVJ?=
 =?us-ascii?Q?dJW2lXQnNQcGFHQRUou1EIFjRvZj8+EKRmZjTm56J7MqpcNdBpAHxXIv86lw?=
 =?us-ascii?Q?hzZxbSwlNMneyjM8zahXHDXQsnbwENdbOBz2f/Hzvr/o1bEGgpKlEOyunSHd?=
 =?us-ascii?Q?H+ag4y+dWsNrhFpiW4q1k1WkkQo9PoOXIhehbsGPxouDrupoQJ7V25F1jBIy?=
 =?us-ascii?Q?SQsIacC0piRFNJm55JnzfBu0AvEA26mIhMRz1ON+dURl+h5Z1y5NOpxiopxT?=
 =?us-ascii?Q?HZwFAPTX1RcTMdulz5P+Q2Ys2R1Exjo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f3762a-1679-452b-3810-08deb2e6a11d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 01:01:15.0019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uScDEAB7QG9Ls0I1w1tMc0lCjMaGIEZCSK1cO3iNOMv5ab+/xHz0vUD1rD0wguWkXPRvHPpiMXcT+rNvi/hgnloVRfcWDN3VwcZnZK9bIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7917
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

