Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBCBFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 00:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A48084673;
	Mon,  4 May 2026 02:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="diFZ2W14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36A7484374; Mon,  4 May 2026 02:35:01 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49D9A84663
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 02:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pV2lWmsNXZnVCgdYV9kU9Pjv9oahPy8G0bd1GCNjqdl7iH+8EpxuI5ltUDtww7l/7UPfs0XI+T2cABwmVQI1m5mfrUEW2Qtu41hXz0yL8jMXDqc6Tmc63LT0fd93p0DoZmK9wbcMurcW+0Zu8s1nm1lOpAia1wkf9lYgOwmI3KD4NgdLdr/JcQsvuiSNtfU+tjam7wPM37L1xtmMqXeCf+7tf4kpkNi/RyixN6HLy/r+bALm0wCzl2Qb3EDfeBbN+WawPA7pIzwG2u63V4xl1yYAUnOom2ARNuvrdkCysLZmkMk18YgPxOxeBRYKyZzH4WFPh+ea6JYtJpL2i2k8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQ/p2VJ5wGw144PYwP700WD0CX8ySgrRbmsOHjcFJJw=;
 b=XZXjokH2cdGptVBM2GTHhQBfZ6Dz1XHba3O1hyf9aJgTIOTmGwHwbqi2UyRJA3+M1SAhBiH7E7e9GzucPBZPs/Ki8i2mM29/Flg4PSXDcKpHWHE4dVv+THT+HlhiXE+kUbpKCnWXHttsakTgV8cKyjjpymqphyMPuyyagumxs0CGOFvuYu8PaZ76igw8U6F/gDhbKHJl+TGRpTsS8YMJYsqEqe/p6PrmfidzYQ7Rxaeddm4+lgYlXPKsofMutb150xcu2kqGslnuo60kUXeTVTB3natt8rwAJX3DfB67Is3EPKYSLrsRFxpdAR7m5yPVxksr6E8nUQUTp85U5IEgqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ/p2VJ5wGw144PYwP700WD0CX8ySgrRbmsOHjcFJJw=;
 b=diFZ2W141S9JqrKgOmEJyxZQ8nowscaW2Vh4hLgTW/jtbAFNKs6Ti3R945YKjEYLsnX0vamX3pcmRQdfeJecLJQW4LpRV4V1//QcTqLTGbbt0mLWuLSwHBYPECTjNTadEpR2At/MOnPSVfMFyqHqHM4+ab+iBGkhkNN0pNRaV3NIWN+yPY0JCGVt2GT3ob/eQqvj0C8UjrNtB2ymw1auNhIDyHXUjeXcsWEUY6UR/TC75lG/Lbf94NkJP8661Ekkbv0o7RlXtxuJLkxGMjYhlWo0y7kytjqedwpUso5712k5uHzgkrJ2460ejKJzWeW7opsDUWOP9vR15U3XzWnaEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15) by DU0PR08MB8662.eurprd08.prod.outlook.com
 (2603:10a6:10:402::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 00:34:57 +0000
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681]) by VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681%6]) with mapi id 15.20.9846.025; Mon, 4 May 2026
 00:34:57 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anis Chali <chalianis1@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Crt Mori <cmo@melexis.com>, Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 8/9] configs: airoha: en7523: enable pinctrl/gpio support
Date: Mon,  4 May 2026 03:34:20 +0300
Message-ID: <20260504003421.2545713-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504003421.2545713-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260504003421.2545713-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00023A03.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2aa) To VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB10029:EE_|DU0PR08MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d81c5e-b0a2-42f5-68fb-08dea974f7d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZmyoS5pGUYjDQqRAlfhtW0GMU9XZQMi8gUUzJcnZLK0FKski9rmdiuKWxMzgB0unyOTUK0VMBo+J5J63v6clMyf6Itv1C0QVJbyczmxQBmXBXoIYvIIb3X6Br64cBLLqfit5QwAkwKahz/Q95JGM0R+gb4rTYc7x9Mhr51v4ABb2F4jwvM+hEjtU4ipwaO39aBZ2JHXn3+q9+oCR5VRhf1epIJJ7swXodUD4GFk0cs05r2lMF+ZbmOajNw+d57+a9o7GRW9S+1AglOMUz6CZMYy/CBfg6gVvLk62hrjH0XmklgvqSdTc9xjXyya4CyMEUFwDGbB0i744ax1kSQmGbFijiZR1YnlG544XHGlkoOFLNlNhBGpzLSlJbxSw0OXOv3McMlKqKB7dUEqXljhF2OhaeLXT/cGauxX6C6ALb0wYtlBbNmc60C+C2kCF0plfzGb1doW8fRaYLSqX6ObyWsnfmXPR4OnHt0+UJ5R8H0K92xDLqDHwE7QVOAawXc1OqxaBF1YwQU2prYtnTAnIMlEo+ZMyLqa63GRqZl5Tc7IhMz6eNUIWjiU+7OZ7A18apHSScXcpDNy7vbtML1/ljHqZX02iczXgN88m34k2e0vCcXW8j5KnbmCxnT+O5ERJYsY7PkHmTXDm33RoYA9Fnblw1u5D68KigWBDZ+3E4g9oYC5WKUoIlKE+l1I/l8/+l+XmYKjAETXiCTZyDbD9NUb5pVGFUWX61Dp1NFM+eF/DT8Clnkt6CyWu6QJLBTz/2ea4pqtB7PtTQmej+ZiE3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB10029.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PxezsLKfVqUMa9phKyS0rKj25+QxGYGwDectgD+7yMfRTtY6yrG55UVUaMNw?=
 =?us-ascii?Q?MyQ9NQZw0l0Nu3F0NiqnsTpFh4wLHn6elhv4pIHn6qHd3RxvL2JgSnUNO8GM?=
 =?us-ascii?Q?7W1awRKRiVvUmbQgAoZyVbOLpkq03Gcg7yT89LpeqkWKgi1hs4j3DE1CBUmu?=
 =?us-ascii?Q?mGWQXqUWpetUfYvCMcOFIElbHevSunz4qNvZzsZpyfUPZWM4BSiQBoli/bRA?=
 =?us-ascii?Q?9F4LGIDDo+ZExJmQKhNNkHYOVFQb3WhXXHI2Mh3xp66KtaZItK5AXUPTD+Lz?=
 =?us-ascii?Q?1KxIfgsbS/RCPBUk2lhuURbqgxOc045sld1B/a2QNi0eswsSu3gUXa6yIVun?=
 =?us-ascii?Q?F7PI8HuzfMTAcyO3y1EmzJad/KEjbYOAPKMWav0GYMEwke5d1VCZWkqIRu5U?=
 =?us-ascii?Q?cqCThhW6mEZtlTrMQYI12CEFAEIUYooqt8O8SkKksF4gLY578N3QKpywwdoc?=
 =?us-ascii?Q?NQALRx1lUj8Cd9jSrvY9B7Ue8771vlPH17o5FPHTHlm7I9gfPzQPndy9fno3?=
 =?us-ascii?Q?ccYkBF1W/gWZQywLhfGQDK9U7kWZdp3KNjrmytTR5DgRYr4Xz1/vpp/GG8nz?=
 =?us-ascii?Q?xcb6UQK4hVluZFxjN8I2ysV8jC+jfRQ0QXLydNVHiHC+t6QaEwyQj61labus?=
 =?us-ascii?Q?v3XaqV11KO52HcUJpQtV7AJCOlbAACzhUBnEFP8O29vSMohgSS+EIwCjUn5r?=
 =?us-ascii?Q?+EAV0mwBXG68b6gyXTNfFOknVWP/4UsTqNCnguPhJBxFggykCgIntO9vL6DU?=
 =?us-ascii?Q?ChgECKSsRY404QhCvfvJQfwq89OR62Go5kKyv6wvjWUXdQcabN7tslWg84sF?=
 =?us-ascii?Q?r+uDVLPUr/CfvMCmBm6HZlzADQRONdCTXkkjFl4E2FPV5ba0XB9RPgpHInn4?=
 =?us-ascii?Q?vr1Kfl2U8SkRqgXunYFITEhMAiSutoRAa/6ui6B7BNBK82nULt91NjMoEoDK?=
 =?us-ascii?Q?zGjAWE2S+Zdtd0uyP/e/Ew6stOdZDYGFTPWzz4mAKggrnFBiKjsOsxl5q/M8?=
 =?us-ascii?Q?f//PZq12ArAtI1yCH1kkLjc91nlvXYrME5YlOh6qJeBWs+z6WxO/PyzOPXqb?=
 =?us-ascii?Q?HaJix3v4CZScNqjUuwNHhXP8bydM9JaW51cMT4+et4M1GWQIwbKihxkDifVb?=
 =?us-ascii?Q?PGPDHCEJAdw53Pl6vMs568CV5Jr3v03A4vUcKXR25EDZIA2pcf4rqoNEaFsl?=
 =?us-ascii?Q?7uO6byqfttl7Lfwo/p3Y17TLIDlHn5BRW7b80tA0MYLcmAfbPciggX32rEre?=
 =?us-ascii?Q?TdzZPFLj6b4uelNN6gxAQOOVzjNokSZ/Iig6T2g/WqRkO2119Bzzf0qb5dbO?=
 =?us-ascii?Q?sBacUQL2N1xOEXs+5d26X5iFEBgfyFSBzOTHfKH6wZQY92zcbx/QWK4AYy/9?=
 =?us-ascii?Q?VVFk+LQKw30i1qJ6kBXEX+7aJHKAq41liutKJPGjGw8+6PvL9vApqpI6HRCZ?=
 =?us-ascii?Q?F9wZPa/stKZWiuK4e2BMH+PcFOR+IxWr7pLJDHrhzZ2cdvJL+J0YOL4eijCZ?=
 =?us-ascii?Q?bxov2AP3oXCsiAqiKi1gefFCv9C7wTlUe/zrJv2JNLuxONdkTcO66nr44/y+?=
 =?us-ascii?Q?fF6Ef1jf5YjAPS7Q23/kXqG9PaZ5VlLciux5LqCxEbrv70+FS2WyPc0bNhi3?=
 =?us-ascii?Q?aH3aUt4lN6M9klRc3x2PobbMxDZoCEtG9dlx+tAe1aFGjvE0Ekq1V2taOOM4?=
 =?us-ascii?Q?lt9o6IWlvqqyl0aUnr6m/L/nm/tjmR7xZBS5YDCwThDf1zDAo13numS+Qs8B?=
 =?us-ascii?Q?kVxNJeMJt2AMKYcN7LRU1SwpiZRU28k=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d81c5e-b0a2-42f5-68fb-08dea974f7d0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB10029.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 00:34:57.4577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLjFbxWhfHn6W5S4I4KH5g7YDVSWh4F8/Ycu4h/MdaVwHtmD6xeVliHXtDN04FfboKoiQuD4WFAmjh3vmW2gP6WftG/3ojxGAiQ8B++r7fE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8662
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

This enables EN7523 pin controller and gpio driver.
Defconfig was minimized with 'make savedefconfig'.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 configs/en7523_evb_defconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/configs/en7523_evb_defconfig b/configs/en7523_evb_defconfig
index 381d5d05616..8b1f3c71e9b 100644
--- a/configs/en7523_evb_defconfig
+++ b/configs/en7523_evb_defconfig
@@ -42,7 +42,6 @@ CONFIG_ENV_MTD_DEV="spi-nand0"
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=8
-CONFIG_REGMAP=y
 CONFIG_CLK=y
 CONFIG_DMA=y
 CONFIG_LED=y
@@ -55,7 +54,7 @@ CONFIG_DM_MDIO=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
+CONFIG_PINCTRL_AIROHA_EN7523=y
 CONFIG_RAM=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
-- 
2.53.0

