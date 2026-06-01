Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41ABBCD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 19:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBE788495C;
	Mon,  1 Jun 2026 21:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="BQd9xUrD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C42FB848E2; Mon,  1 Jun 2026 21:53:46 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDFFE8493E
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 21:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rt1Ti7nY6313lb7Vun1e+vy3gxkpBn3AEkF/a5hHxQOh/Zcya0m0Et3Y7NYXvfDFKV4LYWJ8FZ5otcxYw0SpgoumR2e9dBx38ni5iUx7ZJ56aLT2uH57FZQb/ruAk2aGazzwpJkwfkaW40KY5WLFQ37ndX3M8+odAYB7mK57VSGBDtyBrx3NpJQ8pNSflqAaTOiq4/dU5C1g/YkfoPXpR4OV2lNXXmliZRZ1RKPzA3crBGN5GwQ7JcOs+owxbFsiOLE780Yk+1dLsexsWSC3nlkFLWKX8G3BvxDDwgiU63QQdzWzeObg3TvQyL20hbaCLS7hFmHI2sAKN1awezsxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=653BAny0uqk0VBQm0VVkoZtKncAFX45svUdyJLVs1T8=;
 b=ZufEEJgCDWtCbqoUC+KqPlHTn7f4FbRh7dTzJxjiInDsfF8mJU9asLRI8Dh5gne6egU7x7yjdklc0+N8to6dm2zJFLwgd3B0ZIh+JSYuzb0J3qrYIJFKLk15/dg1M8H7IDUMI9hiKYSPfZRZTaIxY7asg0DnFI4xe2Ejo3IU55ydVW03spafiK1wb8vGmLOP8E1dwuumuPP0031pa/EMKccuF+o7uuVJVKyS/RYKIGTKNRBx9XA55V+RA+u+KWK5XB9Xf4a69rEORCtW3fzaLjvWLUtnFRpYldERv5KofeNnBl789Lo3cBBdc0vjwz7LPLEiVxkkxjG9R9bra0+5ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=653BAny0uqk0VBQm0VVkoZtKncAFX45svUdyJLVs1T8=;
 b=BQd9xUrDb29iZAosskfw5TnSsi9bUxppujeaxVwzzNqO21tryC82OwuIDUnzEfxUFsmNe2IeTuI+nNZVZAcjGfSNNqzo5EsHbMn855iVct8Yg3qvnwHvNdylmTD67wq4JI7MCJ6uo0yXOmJkL+jyJMsreYJpwEtm4abIN9EOogdOh+DQtKVL85BuFqzOqo9qTjtYbL1gWuTe1mANwsXDR6juliU7k7Ob9fNQSQpnPa44Z0iyShI2/P37OuM68LnMXNtrak6Vu1gpSg12i4kuzC21+8KKTNKbv2TWxwQWROa1jExsg1rY9f+ATzVotgais4JjT1ml+BLWJ2Xxu748Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBAPR08MB5653.eurprd08.prod.outlook.com (2603:10a6:10:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 19:53:43 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 19:53:43 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Anis Chali <chalianis1@gmail.com>,
 Yao Zi <me@ziyao.cc>, Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Crt Mori <cmo@melexis.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v11 12/12] arm: dts: en7523: add pinctrl/gpio support,
 drop legacy gpio support
Date: Mon,  1 Jun 2026 22:53:11 +0300
Message-ID: <20260601195311.2390473-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601195311.2390473-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260601195311.2390473-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0025.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::35) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBAPR08MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 1732c697-fe07-4839-8a36-08dec0177bea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 2C9W2bCRwWiS5UBdEv/DmqkFwhgOxmVLHpF+X4AkAptsj7Qqg/6CJucinz9s1FK6HfzBYKuBMN6FAX339/mqy13+vMS4RBJz/rBoEl/10fdjhhiPAnOojRq9C6YxmW5hoMhyM6W3dPPOFzCwA9Rxv07NCcItkjcs2p1wMeQSRtvxyAF7FfkHA1dcEjEdvyMmAHslVuI8OilCGW5kk00n/tUQeEOuiGnjsBp7Z7bbRRM4tGRenIc+7DwxIYVfB1yDSNmok13UH7qCu3G1dsU96rWxdiZEbCs+qOArFoM3bmARrz+pKDYpxJ7uBD72gqclnad5YNPSVIpOmGPwL9A+opXkLkHuzkTDoXbll7HbI2a1BZ7t+wNQNFNKZ7PCIJ0XUQTSYkCDp+JX/hvBOA+7skl7NIE8Y+ayRKo3QD04VhUmfr3KA4Orrt5VJdV0p2rgKAhupRGXh8SOPm6TudMJO6j+DT7WcPBSDX+bpttdSuBtFuodOMT0RNrBSZfL+jpwHwMzWRhcKmrlDift2wLleW+NmmLUGKqvvXAXdJOBAMZB2z6w+uJ4Ciijfb78wOuXf8+5kr8yVvvuQ6ri4blcmPFRfPzpk95o6uODkWAQMjR70A5Luqn9w4LFtSBXRGOlJSt0SGQpH7sG1jUyhaL759SY+DjJmyT2MPQz001ur4uT2HM9laEWvUYz+xipzE8eoV1Q6W/McrN5i2hSpwxX4c3p2i0CuD7HikgWnfDJ9Gfd0yCRGy03u0Ad/DrbBYTTxmnX3Y+xixGs/ppHT/PFLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014)(921020)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AdPlbxDCLMslx3xbPF3ZTYZ2v76psvk8Y6TT1MSOJN1tTJxtdOPQIZW8fiN2?=
 =?us-ascii?Q?gSjwrE5mAUKuXi/mIFIkI9Un/dTNMQrJ2nQ1SKFshDvO5LbDA2LRzsLTF62C?=
 =?us-ascii?Q?I0dqv5ECh1heo92mbwp2sihk8U7VeTopZ1IggtX5eVSrgHdOiu70NhuGxmxi?=
 =?us-ascii?Q?h8IBEdv9ZETOLheteE6M4bSgyMs3bqgpc//k+mjEgwTplmf9MASG9nHwyaS4?=
 =?us-ascii?Q?DJCm4owvPkluX9Bx6kgFdMNk7W1tZAFm+7/fIY2DuXNELAfW+vP8QlBJMDDA?=
 =?us-ascii?Q?/mBLTUsB2CA1P90jdQ6AyKjQ/U1O1Sf7twCFT6bikZtNckCF9yPqSh3zrtdk?=
 =?us-ascii?Q?zbzCC/PzJJ6YbNkCg0r663tPYcJCPr237I05n0IHsIsiUV7pqNZT9Hr6xaBF?=
 =?us-ascii?Q?w2HMbFjfUOK17Ogu1s+5d/lRJVv3ktTOTwTN8sJiashr6tnmjvIbUsqY6zKF?=
 =?us-ascii?Q?dL5ZI6wqWPpmx4g9Qy4AQZ8h2Yml04bW5Bhmht+RKyeYrxYt9ntxUFQHaNao?=
 =?us-ascii?Q?k66MhXvwvkroxCoxM/hAMkb0bYMAsrJ4bfewqJU1KO4YqgW+8wLcZVBDjekP?=
 =?us-ascii?Q?2O8FKuzXp0+hJ9rxJSeg2roANbOg0Csuyo2uzFF6m3dr3zfMdkaYJ3Njd/dH?=
 =?us-ascii?Q?yCi+pG2x+atxe22F5nVowURyR/jLgow7ijWYh1U6q8ThC1O8qyZz6SOq6sM8?=
 =?us-ascii?Q?2EYk3KqzbDmSw4t4CfJAug/GwiQF1ucXRVdCAQyaJz8Q3S/aKGyfOxvsyFj9?=
 =?us-ascii?Q?rJ19jLvpjV+cZw2RNgygq9cXcjbAmvOG2wHO7vHu1jcfQBgnKLRzmW96t4/I?=
 =?us-ascii?Q?kWnUa6Vya6nXd53BXgaPfj1Ol/NPfMm0b8+9iUJfKAI5gMj1gWQv3jf3X8fl?=
 =?us-ascii?Q?JlDCEzUdsUfV12LDMPw8/mWeK+79suzT8foDUFxttWVqNsaFN5TadRq/c14f?=
 =?us-ascii?Q?YAAmQlNCplqMS3WBLvUmKqlimlwYFnQbXunLTe5+7iuFLWOxLPyHuaErdsLp?=
 =?us-ascii?Q?NMmtecR01ujGF9vVrjm/cyGz+tsVdkds8RlZ7x78yBfUORAIVdqMAYZbx/0F?=
 =?us-ascii?Q?sSrMwwYa0lyPVZuy1L1ZuvJf+++yzs2p5AhwsKSTpvFW8KHuUGKzUxpm1HyC?=
 =?us-ascii?Q?EXZ+P6BmL7Wi4CTTw3P6C8y7TPiTonVDQlzorb5K/gKk6j7/D6iLhq/ViBWs?=
 =?us-ascii?Q?vlh9MpuBnFrgtHSrxIKdljW8DZiknotbD9SWDmBMK5oLF3EbZy3DubOTIV/z?=
 =?us-ascii?Q?ytFr8i4HBIrvcZLJ1EeshuYy2BBKAGr3Isqf23l3Lo6bb+Zfz9isoMVrOWn5?=
 =?us-ascii?Q?EO1aTrF4EbsQo7YYj2qtyAzaa+3vkgmj+UyRvPcjTrnTCjEzKr8lla1xDNlx?=
 =?us-ascii?Q?V3jXKBZBRwPMUro4hpOjSWoTrrWsoCUw3IozRqUAvQ9sTDkPfE1cY2ttDNal?=
 =?us-ascii?Q?YopZ2HESNAQs7FpJIx9kvaPRSNCrEanxus2cHthjn/r5ye+fzllmf21FxJZn?=
 =?us-ascii?Q?KEeyL8wQxZoSny4Uj2GHiv7GCj6UqaxBPlCgFab9BJ7yQRcNsvd/UoMiWh9u?=
 =?us-ascii?Q?oX/NRDDSq4iQVxxqS8cq2MD9zzzvH6Mx3lpS035SIJXx5sfmgHprmtB7PJCg?=
 =?us-ascii?Q?KhA9OT9tJ1XWJfc2tKVR+lUy5biNSSXR9EwKYvDxYd7vYbhqrr/+J+H+hT+j?=
 =?us-ascii?Q?IA001rvbKSGo/xMP7jlhQE9L4FozaStj2Go5GfkhlCURkWZYM0crkgis2Qh9?=
 =?us-ascii?Q?pnCFcvr3SvYKx4U70syeNBdzi/t4DIY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1732c697-fe07-4839-8a36-08dec0177bea
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 19:53:43.0683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2uV7P1l1FPE4sxXVatM5UG3Q9ub8xsFISSpiEEAMSVgEf2rNBX3QDxhvQaiZYuJoMuOuzRxugVvrSW+TPu98iaz14KWev1coLsgNnXWF8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5653
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

