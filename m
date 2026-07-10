Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3101BC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 08:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B36384119;
	Fri, 10 Jul 2026 10:09:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HFZOEVgt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78983843B6; Fri, 10 Jul 2026 10:09:23 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5EE283FF5
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 10:09:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJdfVkj9n0tYcQ6r7F0rc0qwBp+401pD9aHo62aU8zgpPi0j3oX0MhlGaiAg/yoJiBq2IonZM9sn1gGFIfuv9ZGiFoI1Oo3NTvxnjeUha67N04y2gNNiQxQJfXVrdbqbxAVzEdscmcwiWRyAL343hZ4F8ML0fg+vm5NPiwPcVW/BnLIBCjeEsYgNayiFncdi5FKLjs3sGvdzWHPIDo5VfEIwiiZPd3az0HmAS4YinABJR3qxpIVRnpcSXbQdAp1wSU1QdHqJaR1bjBA3hrie9atPC4YNHO4YzSsHE5GIKDW6eYnLyhngoeG2C1s1a/D4EX933ZOd5FQg3z0G0lRAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opFJCtfX+dpfi+TB/qEPQE/usbPvozNy1da0TvjKLWY=;
 b=FnothAqnoMchT11W/7qK4IvmF7utBZzJ+dCWzT0+lZnZ3WUIzHj5BWxsS4YgJjvWpRqljhNzkCIJMG99kQLCB8LBPe/fdPLKO4EzNNim4VQenmGIk4F6jPFzniQyUDomnUtaSVXbr5jFP8lSA6SYq67nkEQ/CZsP89GcZ6AUOzFuJD7wmytl85c0tLjUTkqKR+ewXfTv7dx6c7gTV6rOGNUqpLX9l8UrIu8uJMX1gftJECvIjXvXOxPa6cQ+Dt2UcygT3tE9H2d5N+VVg5S0GAilZrkn3/2gc+8E3vTetLr63GZHIUit8YqGUhGpCxdMCQmMecOuvsRxmQCJ0GZQCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opFJCtfX+dpfi+TB/qEPQE/usbPvozNy1da0TvjKLWY=;
 b=HFZOEVgtR3CbtiAYuDF++WVM4J8SdDnAbnVDTxuQU5gisRM/+oG6fbl5HyTiiKufrrI5g4Lh1OlvUUEgo0r83Co/Rj7RyxoqA+07RSQNRxinGy+AHlThcM+egG8B1KTtCNg+8TeS0iERaiJfBSLNdJs8V3O/hDHhpebWFxsHuc19iheDcoD9j8bi6pTKzqGD66ydpHYH+UmhU2jXYjSZ7kRhjEFAJDY/UudnzScLY65l9eCIOJWUw+iElx6D/t5m7aOXYiFpIRFxonu/9jJQwJXsWQfOEtnJK07tRg82RPYpXcKS1FGCFJvTQuh3odnUopvIy+/oV2IPmQYpE+k2PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by GV4PR04MB11290.eurprd04.prod.outlook.com (2603:10a6:150:28f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 08:09:16 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 08:09:16 +0000
From: alice.guo@oss.nxp.com
Date: Fri, 10 Jul 2026 16:12:34 +0800
Subject: [PATCH v1] net: phy: Add MaxLinear GPY215C Ethernet PHY driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-phy-v1-1-87f37559b2ed@nxp.com>
X-B4-Tracking: v=1; b=H4sIAHGpUGoC/yWMQQ5AMBQFryJvrUnbiIqriEXpx7dAWoSIuyuW8
 zJvLgTyTAFlcsHTzoHnKYJKE7SDnXoS7CJDS51Lo6RYhlPYwplMG9to4xDNxVPHx1epsCvU/xa
 2ZqR2fe+47wc/ukmAawAAAA==
X-Change-ID: 20260710-phy-a8d7427ab27d
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Cc: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Beiyan Yun <root@infi.wang>, 
 Johan Jonker <jbx6244@gmail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|GV4PR04MB11290:EE_
X-MS-Office365-Filtering-Correlation-Id: a52c338e-980c-4514-fd4d-08dede5a88ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|19092799006|23010399003|376014|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: sHcoJrSJ/HDkSGbRvM0QWLEMKf1p2KqRTtmAfOf22lHUHmkTeP5z5E2kaWO9+kKsNlahCTxom0fSW9aApVnGadlAKkXYUbRVAnYUSjlpYaV4pBKm1MKkUau5TbHNusSRYGReJsX5CXiMmeCHS5ityLKXEsYuJpldWUwnbUIGy3S+ZYsrXVsO2ie6hhPqtvdktzuNjhTSvUMVr+c4CX+3XTOLNmxmMt0YuZVBE3d7lCzOI+WddoC3LJ+uMkvOul8r3eU7YNcYp22QSyap7STY701pRAjsndSIUM/bk9lT1+px5Gcxmb/5b8LKEXR0/DfLnR3Nxo5XA3AtbiEVZPHYwkMtWuLnR+DzVkvyuJHxySRCy6Ljyx9mvKraaSa9HoKtLld0Y0naRwFZvz7H2xUdRlcRx1xOni2HIDqXjDYg2Yr6CKMnhsf5p2Jyy7OAgnHxnhrjUtv0rgohQcOG3nE4j58LpcA1sSqT6m6tX2ufeL2G92k8wY8cC/935xs/hGrMZxiFe3yfQ5s5EnXFInMEHy1hXy9U090uLJwO3Tx9rmx5CnGsWDqCaQUbe1Q2CQ4a4Gf+d+rGdrvJ0W9WClnHaeEVxe+a1X7u5EDrHOeKp+8DEEXAPcOkDXXifTl4vP5jd1aMIcOAePCqce1RY9O8CEFaXFPzBwbrr0DfvWuqmmE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(23010399003)(376014)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1FyVjFCSCt1ZWtFNGVyejV2dUxEVnZURC9lMWdBRi83bmkrRU9MZTFQOThF?=
 =?utf-8?B?ZGk3SnhyeHNyMlRWMlMrV28zaDVTbFgvNnhyWG9uS3dKSTVuenBoZmN5eDVU?=
 =?utf-8?B?ZEFya0lqVWRLL0VOaFJnSUNEZ21qVTdTcDg5UzVCQzVCMEdjUHRJemh6OEVR?=
 =?utf-8?B?Tm9CT2tEeXVTby9CZnVEa0NJcWh2WjN1emgya0lpTloyN0wrYll5YW11bHhS?=
 =?utf-8?B?Um9BYWl0QWlQR3VsRTNtT1pEYW0vZHcxdkxmOG5jY1BpN3lRM3h1MGJDanMw?=
 =?utf-8?B?RHR2bWVWclc5VDRCRW9hQ0c2TUxNZ0lKZkJ3Uzg4L3dwNXZOVEczYzdscFNU?=
 =?utf-8?B?cHk2K3FqWjlpbTJ2OWl0L2wzU0x4VGIybnlqMHdEdlB6UGNvTllRMVdwYkcw?=
 =?utf-8?B?WjJLV25iVFNqYVRXQWFsaGtrNExNUXhaaTFuTklja1JSVkxiQ001V2hraGo4?=
 =?utf-8?B?anl4cWlEd2ZBN0RCSzdGRU52Z0laL1oyZ1lpdDNNQm1mUzl4dngvY2xSOExk?=
 =?utf-8?B?bHZHM3QzalpNMDZ2SWhXSnNGMEJYT0swMUhpS00wRnowMis0TnhHRGdSMEx2?=
 =?utf-8?B?TkYvWStxdkhnUCtxODFpT05lUS96Z0hOajR3MWVCamxYUGNRc1ZzZFJZV0dV?=
 =?utf-8?B?S0RVdUtkSnB4WENMMVFITnpxQXY3VStTYzlaa2FIRjBaMkZkL2hCbWh6eGJQ?=
 =?utf-8?B?ZmtsRDFjU1NiTmpubXUvNTgrMWx6WTNrM0lXOCtlUnZuSzVWcjlsdEYvYUlR?=
 =?utf-8?B?U3lyRXltNXpVNEQ2MzR2a1hiOFB3VnRrZUdWUk15OHpEQk5WQ2FoSm1WbXhV?=
 =?utf-8?B?OE9zZ3hnV3QyU0ZxeUVLaFAvQmNFRmU5S2RmQXFCUlBra204OTJMQTBYSVRs?=
 =?utf-8?B?Vko5Y3k4T3hQT0xyK2NmMzhqZHNHenRNLytTeFVzUVliWXZnTlBTbHl3REhS?=
 =?utf-8?B?SlhFRDkzYnlzSjFCM0JSZlFCdXkwcE9YaTFKYXFLZFFvejk5U085T3BaNm9l?=
 =?utf-8?B?SWdVYlJOSWsvelJtMk1WbnhjV0l4TS9lSWFEQ1R1RnZDNE9kUlIzSk1KTVFV?=
 =?utf-8?B?OWI1aytCWXMvamZaR2c5S0RXN1FoSHVpa1IvYkoyUGgxNjBoUUNtKzlKRlRw?=
 =?utf-8?B?VTErajRjYjFiN0NpM3E1cHdWYko3QXhXNGc0WXRRdVFOOVluMjlHTzduL1RE?=
 =?utf-8?B?SWYzUDZ5Si9PV1pGUzFHMHM1RGJRTnc4WUIxTU1ua1ZSV3g5STlvR2F0WTQ3?=
 =?utf-8?B?MExHK1Y1UjBPTWora3FrODdCQzBHaFl2aklyVXlQcS82dXNTaGlRaktiY3lk?=
 =?utf-8?B?UjJKUDBTQWpQLzRlMmw1ME1QMTg0OURoaFYvaGdGdjYyNzZEbDVFTkpKZE96?=
 =?utf-8?B?eHVLV1hNeTMvWEg2U2dGOW16L2VaQitjQ3pVSzNSK3cxZnRpYytQMmswTGVu?=
 =?utf-8?B?QkdqRkZZSWpPN1QxWm5CaFNCWUhhRjhjdC9tMHhCMHFsSEhsTXpMajVGTThH?=
 =?utf-8?B?SCtFM0RlWXF3WEZIUjlpazJZeWVsMUZuYVgvMVJqdE5XQ3duWDMwTFVsT1cx?=
 =?utf-8?B?YlZqajZaSUpsNExvSUhKa1NDYitxVG5iaWdsZXZEUDRCcndBK3R2Q3MvaVkr?=
 =?utf-8?B?Y2VFajRKSUVtb3p0VkdrNTlVNi9JcTBrN2FZSW9sRk5mdEdFTkFFaXR0Mlp2?=
 =?utf-8?B?UlZhblVqWVk0UUFKLzBMTUt6OHUrRTZnWWxMeDQ4L0dRbmQybmZ1Q1VQN1hz?=
 =?utf-8?B?YzJNb3grWCsxMlY3VmJINWFrR0RKM2hsaDdaeWtuV0czOHpGbmNlZDBiOUMz?=
 =?utf-8?B?MTlTSEpEeWFJb1c1SU9aVVNKQVNhVlZlOXRrRXhwYzFGa2JkWTZEQk1XMUlD?=
 =?utf-8?B?MFRRM2Y5RWJad2tJVlR2dWxNbnVrU25Hek80Rkg3bEcvTUNLQVRwVFJjU0Q4?=
 =?utf-8?B?Zkx0VXNOc0JSaWNzTXQrWVpJT1JjV1lPSFp0NTE3cGRNMDRPOTlSL1hjZHN2?=
 =?utf-8?B?a3RSTkNsYzNLaWhGNkxQalMyeGlXbUcxYzJDNXVOVmpoRDdYcFJWQ2xSZlVu?=
 =?utf-8?B?MXRUR3I5Mmk2VW5sVjd4VHZhQXRPdjlqY2IvUDg5NW4xeEYwWHI0Z04rSTBn?=
 =?utf-8?B?c1l3bUhPTkVucjFBMm4xdFQxNU1kYnh6MUtmenhYa09vTVowZ3MwZDJ1ZjlP?=
 =?utf-8?B?eUphdmJhak9QdE1Pdk85NTZmT3pxdzJFRXRiM1g4SmZ2YnVVOEVHUC9VVmoz?=
 =?utf-8?B?MENQc3FibXIyeDV0di80ZlJmaHg4RjRkNGJTOWM5QVZjMjFVNEtDdksxOTlp?=
 =?utf-8?B?STR4amlTd1dsc0NlVDUwNEQzRUlGdysrc0pwenZtdlc3Q0ExVmFBcjV1dzJa?=
 =?utf-8?Q?tGU+JwDDhxdtue/hXyIbAvQE94pIupIe5SfxX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52c338e-980c-4514-fd4d-08dede5a88ae
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:09:16.7771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SDVCs7VBKSyYoDDX0V60qx4sefGX4uMCgU4Zgt56HqJVhA9ftjkbF4sRVeBYlWMQLw9I6ZHn/o+0NDGJDl8q21xUOnsOHk5NC15BHp3/48Zw5tkjC7wfq0XrjcvdNpr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11290
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

From: Alice Guo <alice.guo@nxp.com>

Add a driver for the MaxLinear GPY215C Ethernet PHY.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
CI: https://github.com/u-boot/u-boot/pull/1009/checks
---
 drivers/net/phy/Kconfig   |   6 +
 drivers/net/phy/Makefile  |   1 +
 drivers/net/phy/mxl_gpy.c | 342 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 349 insertions(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 3f7953d693c..f76636a897a 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -242,6 +242,12 @@ config PHY_MSCC
 	depends on !COMPILE_TEST
 	bool "Microsemi Corp Ethernet PHYs support"
 
+config PHY_MXL_GPY
+	bool "MaxLinear GPY215C PHY support"
+	help
+	  This adds support for the MaxLinear GPY215C Ethernet PHY,
+	  operating in SGMII with auto-negotiation.
+
 config PHY_NATSEMI
 	bool "National Semiconductor Ethernet PHYs support"
 
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 83520de7f1f..0e79c03df7e 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_PHY_MICREL_KSZ8XXX) += micrel_ksz8xxx.o
 obj-$(CONFIG_PHY_MICREL_KSZ90X1) += micrel_ksz90x1.o
 obj-$(CONFIG_PHY_MESON_GXL) += meson-gxl.o
 obj-$(CONFIG_PHY_MOTORCOMM) += motorcomm.o
+obj-$(CONFIG_PHY_MXL_GPY) += mxl_gpy.o
 obj-$(CONFIG_PHY_NATSEMI) += natsemi.o
 obj-$(CONFIG_PHY_NXP_C45_TJA11XX) += nxp-c45-tja11xx.o
 obj-$(CONFIG_PHY_NXP_TJA11XX) += nxp-tja11xx.o
diff --git a/drivers/net/phy/mxl_gpy.c b/drivers/net/phy/mxl_gpy.c
new file mode 100644
index 00000000000..7445ec5f051
--- /dev/null
+++ b/drivers/net/phy/mxl_gpy.c
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MaxLinear GPY215 2.5G Ethernet PHY driver for U-Boot
+ *
+ * Based on Ethernet Network Connection GPY215 (GPY215B1VI, GPY215C0VI) Data
+ * Sheet Revision 1.4
+ * Reference ID 617800
+ *
+ * Copyright 2026 NXP
+ */
+
+#include <phy.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+
+/* -----------------------------------------------------------------------
+ * Standard MDIO registers (Clause 22, Device 0)
+ * -----------------------------------------------------------------------
+ */
+#define GPY215_STD_CTRL			0x00
+#define   STD_CTRL_RST			BIT(15)	/* Self-clearing reset        */
+#define   STD_CTRL_LB			BIT(14)	/* Loopback                   */
+#define   STD_CTRL_SSL			BIT(13)	/* Speed select LSB           */
+#define   STD_CTRL_ANEN			BIT(12)	/* Auto-negotiation enable    */
+#define   STD_CTRL_PD			BIT(11)	/* Power down (SLEEP)         */
+#define   STD_CTRL_ANRS			BIT(9)	/* Restart auto-negotiation   */
+#define   STD_CTRL_DPLX			BIT(8)	/* Duplex (1=full)            */
+#define   STD_CTRL_SSM			BIT(6)	/* Speed select MSB           */
+
+#define GPY215_STD_STAT			0x01
+#define   STD_STAT_LS			BIT(2)	/* Link status (latching low) */
+#define   STD_STAT_ANEG_DONE		BIT(5)	/* Auto-neg complete          */
+
+#define GPY215_STD_PHYID1		0x02	/* OUI bits [3:18]  = 0x67C9  */
+#define GPY215_STD_PHYID2		0x03	/* OUI bits [19:24] + model + rev */
+
+/* PHY ID: OUI = 0x67C9 (bits 3:18) | 0xDC (bits 19:24)
+ * PHYID1 = 0x67C9, PHYID2 = 0xDCxx (model/rev in lower 10 bits)
+ */
+#define GPY215_PHY_ID1			0x67C9
+#define GPY215_PHY_ID2_MASK		0xFC00	/* OUI[19:24] only */
+#define GPY215_PHY_ID2_VAL		0xDC00
+
+/* -----------------------------------------------------------------------
+ * GPY-specific registers (Clause 22, Device 0)
+ * -----------------------------------------------------------------------
+ */
+#define GPY215_PHY_MIISTAT		0x18	/* Register 0.24              */
+#define   MIISTAT_LS			BIT(10)	/* TPI link status            */
+#define   MIISTAT_DPX			BIT(3)	/* Duplex (1=full)            */
+#define   MIISTAT_SPEED_MASK		GENMASK(2, 0)
+#define   MIISTAT_SPEED_10		0x0
+#define   MIISTAT_SPEED_100		0x1
+#define   MIISTAT_SPEED_1000		0x2
+#define   MIISTAT_SPEED_ANEG		0x3
+#define   MIISTAT_SPEED_2500		0x4
+
+#define GPY215_PHY_IMASK		0x19	/* Register 0.25              */
+#define   IMASK_LSTC			BIT(0)	/* Link state change          */
+#define   IMASK_LSPC			BIT(1)	/* Link speed change          */
+
+#define GPY215_PHY_ISTAT		0x1A	/* Register 0.26 (clr-on-rd) */
+#define   ISTAT_LSTC			BIT(0)
+#define   ISTAT_LSPC			BIT(1)
+
+/* -----------------------------------------------------------------------
+ * Vendor Specific 1 registers (MMD device 30)
+ * Accessed via Clause 45 or Clause 22 Extended indirect
+ * -----------------------------------------------------------------------
+ */
+#define GPY215_MMD_VSPEC1		30	/* MMD device address         */
+
+#define GPY215_VSPEC1_SGMII_CTRL	0x08	/* Register 30.8              */
+#define   SGMII_CTRL_RST		BIT(15)	/* SGMII reset (self-clear)   */
+#define   SGMII_CTRL_LB			BIT(14)	/* SGMII loopback             */
+#define   SGMII_CTRL_ANEN		BIT(12)	/* SGMII ANEG enable          */
+#define   SGMII_CTRL_PD			BIT(11)	/* SGMII power down           */
+#define   SGMII_CTRL_RXINV		BIT(10)	/* Invert RX0_M/RX0_P         */
+#define   SGMII_CTRL_EEE_CAP		BIT(7)	/* Advertise EEE in ANEG      */
+#define   SGMII_CTRL_FIXED2G5		BIT(5)	/* Force SGMII to 2.5G        */
+#define   SGMII_CTRL_ANMODE_MASK	GENMASK(1, 0)
+#define   SGMII_CTRL_ANMODE_1000BX	0x1	/* IEEE 1000Bx Clause 37      */
+#define   SGMII_CTRL_ANMODE_CIS_PHY	0x2	/* Cisco SGMII, PHY side      */
+#define   SGMII_CTRL_ANMODE_CIS_MAC	0x3	/* Cisco SGMII, MAC side      */
+/* Default reset value = 0x34DA:
+ *   ANEN=1, ANMODE=AN_CIS_PHY(2), FIXED2G5=0
+ */
+
+#define GPY215_VSPEC1_SGMII_STAT	0x09	/* Register 30.9 (read-only)  */
+#define   SGMII_STAT_ANOK		BIT(5)	/* ANEG completed             */
+#define   SGMII_STAT_RF			BIT(4)	/* Remote fault (latch high)  */
+#define   SGMII_STAT_ANAB		BIT(3)	/* ANEG ability (static)      */
+#define   SGMII_STAT_LS			BIT(2)	/* SGMII link up (latch low)  */
+#define   SGMII_STAT_DR_MASK		GENMASK(1, 0)
+#define   SGMII_STAT_DR_10		0x0
+#define   SGMII_STAT_DR_100		0x1
+#define   SGMII_STAT_DR_1G		0x2
+#define   SGMII_STAT_DR_2G5		0x3
+
+/* -----------------------------------------------------------------------
+ * Timing / retry constants
+ * -----------------------------------------------------------------------
+ */
+#define GPY215_RESET_TIMEOUT_MS		500
+#define GPY215_ANEG_TIMEOUT_MS		5000
+#define GPY215_POLL_INTERVAL_MS		10
+
+/**
+ * gpy215_probe - Verify PHY identity
+ */
+static int gpy215_probe(struct phy_device *phydev)
+{
+	int id1, id2;
+
+	id1 = phy_read(phydev, MDIO_DEVAD_NONE, GPY215_STD_PHYID1);
+	id2 = phy_read(phydev, MDIO_DEVAD_NONE, GPY215_STD_PHYID2);
+
+	if (id1 < 0 || id2 < 0) {
+		printf("GPY215: MDIO read failed (id1=%d id2=%d)\n", id1, id2);
+		return -EIO;
+	}
+
+	if (id1 != GPY215_PHY_ID1 ||
+	    (id2 & GPY215_PHY_ID2_MASK) != GPY215_PHY_ID2_VAL) {
+		printf("GPY215: unexpected PHY ID 0x%04X 0x%04X\n", id1, id2);
+		return -ENODEV;
+	}
+
+	debug("GPY215: detected (ID1=0x%04X ID2=0x%04X)\n", id1, id2);
+	return 0;
+}
+
+/**
+ * gpy215_config - Configure PHY for SGMII operation
+ *
+ * The GPY215 SGMII interface comes up automatically after reset with:
+ *   - SGMII ANEG enabled (Cisco SGMII, PHY side)
+ *   - PHY side SGMII speed tracks TPI link speed
+ */
+static int gpy215_config(struct phy_device *phydev)
+{
+	int val, timeout;
+
+	val = phy_read(phydev, MDIO_DEVAD_NONE, GPY215_STD_CTRL);
+	if (val < 0)
+		return val;
+
+	phy_write(phydev, MDIO_DEVAD_NONE, GPY215_STD_CTRL,
+		  val | STD_CTRL_RST);
+
+	/* Wait for self-clearing RST bit */
+	timeout = GPY215_RESET_TIMEOUT_MS / GPY215_POLL_INTERVAL_MS;
+	do {
+		mdelay(GPY215_POLL_INTERVAL_MS);
+		val = phy_read(phydev, MDIO_DEVAD_NONE, GPY215_STD_CTRL);
+		if (val < 0)
+			return val;
+	} while ((val & STD_CTRL_RST) && --timeout);
+
+	if (val & STD_CTRL_RST) {
+		printf("GPY215: reset timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	/* Clear stale interrupt status (read-to-clear) */
+	phy_read(phydev, MDIO_DEVAD_NONE, GPY215_PHY_ISTAT);
+
+	val = phy_read(phydev, MDIO_DEVAD_NONE, GPY215_STD_CTRL);
+	if (val < 0)
+		return val;
+
+	/* Enable ANEG, clear forced speed/duplex bits */
+	val |= STD_CTRL_ANEN;
+	val &= ~(STD_CTRL_SSL | STD_CTRL_SSM | STD_CTRL_PD);
+	phy_write(phydev, MDIO_DEVAD_NONE, GPY215_STD_CTRL, val);
+
+	phy_write(phydev, MDIO_DEVAD_NONE, GPY215_STD_CTRL,
+		  val | STD_CTRL_ANRS);
+
+	/* Configure SGMII (Cisco ANEG, PHY side, ANEG enabled) */
+	val = phy_read_mmd(phydev, GPY215_MMD_VSPEC1,
+			   GPY215_VSPEC1_SGMII_CTRL);
+	if (val < 0)
+		return val;
+
+	val &= ~SGMII_CTRL_PD;
+	val |= SGMII_CTRL_ANEN;
+	val &= ~SGMII_CTRL_ANMODE_MASK;
+	val |= SGMII_CTRL_ANMODE_CIS_PHY;
+	val &= ~SGMII_CTRL_FIXED2G5;
+	phy_write_mmd(phydev, GPY215_MMD_VSPEC1,
+		      GPY215_VSPEC1_SGMII_CTRL, val);
+
+	debug("GPY215: configured for SGMII (Cisco ANEG, PHY side)\n");
+	return 0;
+}
+
+/**
+ * gpy215_startup - Wait for link and report status
+ *
+ * Polls PHY_MIISTAT (TPI link) and VSPEC1_SGMII_STAT (SGMII link).
+ * Updates phydev->speed, phydev->duplex, phydev->link.
+ */
+static int gpy215_startup(struct phy_device *phydev)
+{
+	int miistat, sgmii_stat, val;
+	int timeout = GPY215_ANEG_TIMEOUT_MS / GPY215_POLL_INTERVAL_MS;
+	int speed_code;
+
+	debug("GPY215: waiting for link");
+
+	/* Poll TPI link status */
+	do {
+		mdelay(GPY215_POLL_INTERVAL_MS);
+		miistat = phy_read(phydev, MDIO_DEVAD_NONE,
+				   GPY215_PHY_MIISTAT);
+		if (miistat < 0)
+			return miistat;
+	} while (!(miistat & MIISTAT_LS) && --timeout);
+
+	if (!(miistat & MIISTAT_LS)) {
+		printf("GPY215: link down (TPI timeout)\n");
+		phydev->link = 0;
+		return 0;
+	}
+
+	do {
+		mdelay(GPY215_POLL_INTERVAL_MS);
+		val = phy_read(phydev, MDIO_DEVAD_NONE, GPY215_STD_STAT);
+		if (val < 0)
+			return val;
+	} while (!(val & STD_STAT_ANEG_DONE) && --timeout);
+
+	if (!(val & STD_STAT_ANEG_DONE)) {
+		printf("GPY215: auto-negotiation not complete\n");
+		phydev->link = 0;
+		return 0;
+	}
+
+	do {
+		mdelay(GPY215_POLL_INTERVAL_MS);
+		phy_read_mmd(phydev, GPY215_MMD_VSPEC1,
+			     GPY215_VSPEC1_SGMII_STAT);
+		sgmii_stat = phy_read_mmd(phydev, GPY215_MMD_VSPEC1,
+					  GPY215_VSPEC1_SGMII_STAT);
+		if (sgmii_stat < 0)
+			return sgmii_stat;
+	} while (((sgmii_stat & (SGMII_STAT_LS | SGMII_STAT_ANOK)) !=
+		  (SGMII_STAT_LS | SGMII_STAT_ANOK)) && --timeout);
+
+	if ((sgmii_stat & (SGMII_STAT_LS | SGMII_STAT_ANOK)) !=
+	    (SGMII_STAT_LS | SGMII_STAT_ANOK)) {
+		printf("GPY215: SGMII not ready (stat=0x%04X link=%d ANOK=%d RF=%d)\n",
+		       sgmii_stat,
+		       !!(sgmii_stat & SGMII_STAT_LS),
+		       !!(sgmii_stat & SGMII_STAT_ANOK),
+		       !!(sgmii_stat & SGMII_STAT_RF));
+		phydev->link = 0;
+		return 0;
+	}
+
+	/* Clear interrupt status */
+	phy_read(phydev, MDIO_DEVAD_NONE, GPY215_PHY_ISTAT);
+
+	miistat = phy_read(phydev, MDIO_DEVAD_NONE, GPY215_PHY_MIISTAT);
+	if (miistat < 0)
+		return miistat;
+
+	speed_code = miistat & MIISTAT_SPEED_MASK;
+	switch (speed_code) {
+	case MIISTAT_SPEED_10:
+		phydev->speed = SPEED_10;
+		break;
+	case MIISTAT_SPEED_100:
+		phydev->speed = SPEED_100;
+		break;
+	case MIISTAT_SPEED_1000:
+		phydev->speed = SPEED_1000;
+		break;
+	case MIISTAT_SPEED_2500:
+		phydev->speed = SPEED_2500;
+		break;
+	default:
+		printf("GPY215: speed not resolved (miistat=0x%04X)\n",
+		       miistat);
+		phydev->link = 0;
+		return 0;
+	}
+
+	phydev->duplex = (miistat & MIISTAT_DPX) ? DUPLEX_FULL : DUPLEX_HALF;
+	phydev->link   = 1;
+
+	debug("GPY215: TPI link up  %d Mbit/s %s-duplex\n",
+	      phydev->speed,
+	      phydev->duplex == DUPLEX_FULL ? "full" : "half");
+
+	debug("GPY215: SGMII status 0x%04X (link=%d ANOK=%d DR=%ld)\n",
+	      sgmii_stat,
+	      !!(sgmii_stat & SGMII_STAT_LS),
+	      !!(sgmii_stat & SGMII_STAT_ANOK),
+	      sgmii_stat & SGMII_STAT_DR_MASK);
+
+	return 0;
+}
+
+/**
+ * gpy215_shutdown - Power down SGMII and TPI
+ */
+static int gpy215_shutdown(struct phy_device *phydev)
+{
+	int val;
+
+	val = phy_read_mmd(phydev, GPY215_MMD_VSPEC1,
+			   GPY215_VSPEC1_SGMII_CTRL);
+	if (val >= 0)
+		phy_write_mmd(phydev, GPY215_MMD_VSPEC1,
+			      GPY215_VSPEC1_SGMII_CTRL,
+			      val | SGMII_CTRL_PD);
+
+	val = phy_read(phydev, MDIO_DEVAD_NONE, GPY215_STD_CTRL);
+	if (val >= 0)
+		phy_write(phydev, MDIO_DEVAD_NONE, GPY215_STD_CTRL,
+			  val | STD_CTRL_PD);
+
+	return 0;
+}
+
+U_BOOT_PHY_DRIVER(mxl_gpy215c) = {
+	.name		= "MaxLinear GPY215C",
+	/*
+	 * Match on OUI only. The 22-bit OUI spans PHYID1[15:0] and PHYID2[15:10].
+	 * Combined 22-bit PHY ID = (0x67C9 << 6) | (0xDC00 >> 10) = 0x19F277
+	 * U-Boot phy_id = (PHYID1 << 16) | PHYID2 with mask 0xFFFFFC00
+	 */
+	.uid		= (GPY215_PHY_ID1 << 16) | GPY215_PHY_ID2_VAL,
+	.mask		= 0xFFFFFC00,
+	.features	= PHY_GBIT_FEATURES,
+	.probe		= &gpy215_probe,
+	.config		= &gpy215_config,
+	.startup	= &gpy215_startup,
+	.shutdown	= &gpy215_shutdown,
+};

---
base-commit: a18265f1ccb7a272721ed4286ed3b5a6182ff424
change-id: 20260710-phy-a8d7427ab27d

Best regards,
--  
Alice Guo <alice.guo@nxp.com>

