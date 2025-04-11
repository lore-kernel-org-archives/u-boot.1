Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9F3C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 08:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36C7483F72;
	Fri, 11 Apr 2025 10:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nXHIj1Ej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4172683F7D; Fri, 11 Apr 2025 10:13:21 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4417283F81
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 10:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pj9aS345g99fOuBvl8XgQ2UBR3oR4PKmzCDCPyGZijNJa5G2XQouZZOpJf91SIzhJeBjGEQb1OVntbNzLfmmTKKYS+gxwbzQ4WHcpVsZ7tSCLAkRHxgFsLinVFlWaoNTkEMsPHeCL0+0RY/ATagcOtJxJX4+XcsQGrckeEJeizQ6v/tFF3szVNDsiOlUNQYEIEQ5v8K1EA9wjUBDkq07GPMCeQh33Mviet/fnd5hF4DPJ7hAZEQbM+tWZY+ZdFt178sKk/oDRiDfOxxcalW6rCqL/BB3TcIBAGqC59zJTzCu06WaLvb4nol82mAMiZO3xCGhYNMBt+pdINcgCPaicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGTTSezS7+BM95uAlLt1QabFZIvf586pbLUvB/xL1rg=;
 b=F6BWwXzaQgYzndWEc0DUsSd/YzUzLt8dgDGeqRSEAwKR8qGgTCRGHHX91lpRQynEbofCpQk9XHVFqO6mmWtvwKoI2O/7nZrXjLeQ10y1+Yb+En36UJviahnT+sEFoYSOy9OdP0Zykq6MsBPUtw8PjtuFCVuHtmb1dCccc3d8wMSpC0go6f6Tn44PkoB6z2K+PjQTnj3xLtepaN1GWRbSBy6CuewHPB0I96nHlLMCxv+Rvzt3VWBM61zL8QSiWZbyOf8KuZsS5PU8FevwszeYUrwY/gpg4+EpB3tnH0disQADx41+AZYyhCxIMHYGEdwMz4PCvbkWj7mP8hMv5r8Klg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGTTSezS7+BM95uAlLt1QabFZIvf586pbLUvB/xL1rg=;
 b=nXHIj1Ej3eINrRAVNAzDFKYo9VILSKk9M9GXGM70dnvRnJt2YLuqtAiLxVjDEMy2k+YBd+ltk7O/8mKco9lNcIYmYK/908OpNrWAJukSnRcDSbhT77h1IGrhMGAf/e0ag2AdpH+D9y/TNMIazOdks28t5zbbHxbvNCEmWNzAKDAvcEAtBCoBovAIl0iBQd/yV5HvHeEFMdUXBauyNLjxm92uJtEeCoubChzutmo9ybH/TMUlJEZTUxRNeCK5n0Oz7Ei09s8Jtx1aS2YriP3v5XjK7pKk1HzutR/KKcHjvM6ua0ZGlm/sg3qRrr4BvyhR1rj3OvmQ3nhzXMg70/Fvfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7967.eurprd04.prod.outlook.com (2603:10a6:102:b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 08:13:15 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 08:13:15 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de, trini@konsulko.com, festevam@gmail.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, sbabic@denx.de,
 alpernebiyasak@gmail.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, viorel.suman@nxp.com, ye.li@nxp.com,
 ranjani.vaidyanathan@nxp.com, peng.fan@nxp.com, frank.li@nxp.com,
 ji.luo@nxp.com, jindong.yue@nxp.com, Anton.Gres@ifm.com
Subject: [PATCH v9 14/20] imx: Kconfig: IMX8_ROMAPI is not configured for
 i.MX95
Date: Fri, 11 Apr 2025 16:06:57 +0800
Message-ID: <20250411080707.602371-15-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411080707.602371-1-alice.guo@oss.nxp.com>
References: <20250411080707.602371-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fbae5b0-0c7f-4c01-6245-08dd78d0b59e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?izd7uk2tOzmFhZWsp3zblD6V0soy63NbPb9X/uf5JPGSA3yw+Y/9Ny/eD6YH?=
 =?us-ascii?Q?QFt69k7J9oaLES4YA6/z4rSxx1o5SA3XcJa6zphKCA8ZRKt9PRP6MZjATNXH?=
 =?us-ascii?Q?OySnNsONyCVnJOdQmH4d277sUdWlc9vcVTgGgg0LqZU5x9lTrBWbi6UoaWJi?=
 =?us-ascii?Q?NTKPXxsyqReVCdOUF+mXzMFETXt/D9blsZ5D/cZGPKU/ZKpOQFLJStA0LI5O?=
 =?us-ascii?Q?TNpnDPJIRJSYbid33ToBlgTdF+rbnxOJdSnYsbiTwm8OlHxG7okDHinh9BOJ?=
 =?us-ascii?Q?V5SgIRJ8mboUdeyUM/hdx6Wcspf/tbcGWMbD3Udsf1pfIp0034+kLmRvXJxf?=
 =?us-ascii?Q?wk2QQKv1i4ipCuanVO7ex+mkEgExjcKCZroQn34P+7DVuy3dUrx5ybn7G5MQ?=
 =?us-ascii?Q?9WBl1xrk8Kx+veNhfGGfGCW2de6UFkRupus3ab0KQCU6SLRlBEd6QTn3oS/1?=
 =?us-ascii?Q?Gc091mRlK4+NigkWPRBieUeiYjPhwD/0VY0MVmIlwNZWZ8yI2y+P//MX8Bed?=
 =?us-ascii?Q?ilgu/pyav1pdW1Doe+fS8xz42Qy/WJ+noNATzrsRsc8fxcXiPIEAI52ItNUx?=
 =?us-ascii?Q?5/7W3V3GWQcVHATQuP34V745HKjWluExEnmY4VECmApkKbLr6UcyCs60pUlz?=
 =?us-ascii?Q?cAB57xtzCEhqjZoHAqoj0j37IP2lXvZ1rk4cuvM8thB9SOlJF0SnT5PhvJaZ?=
 =?us-ascii?Q?DbzoVyRxaTgmACh9c9UhSytSjyQVH0a+m1qMU3INsAZ1Ze0Kii24cSWqE5rr?=
 =?us-ascii?Q?il+cJKJXfr1IA7/VMWs5kvr8iHtcBJ0dYDblsYpagEjlqxsFHovOr07llVth?=
 =?us-ascii?Q?y42IXI4D3BKLdRTZRaFBW1y5ttpDBtiOQkrRjSyrfFZwG4HdECNN/h2A7SSg?=
 =?us-ascii?Q?p03nh+6FF0GyCl7UqNWBga9RrZAun6HCOtX3Nmq3l9IK2eeKZWJGjflMF9jd?=
 =?us-ascii?Q?ph8NxGOKgMzBjfa/fu+Xg45H2pFHAnQiS9938Ubc5zCUTI3Dtc4H/5r3wtQn?=
 =?us-ascii?Q?ACamjm88vV4YWtwqShOXOHxPKPOo0l7W1yAIB0E7gkKRkiybuBxxaTbkcXIl?=
 =?us-ascii?Q?uDrCUI8Av/E6sSyx89OV+iUiZkBEGYTPBOxVFvaN2ga5/i5KVV636zHPJ9ki?=
 =?us-ascii?Q?mjiUyzM9+olDdhWrWF/75CmwDzQ5Jz/fZJufnIOoG0aBEWNg83+laI0NjYZS?=
 =?us-ascii?Q?GrlTB30PvIGGEJO1wAw3ibADhmRaXsZYNtkKqyTyHnuaUj40MkbEULBWvX1Z?=
 =?us-ascii?Q?nxbU55CapWGr/AEubPW5l+3N9op+oxkX2p+0yhX6QkwKEfoG1Vk+JVrvpmRR?=
 =?us-ascii?Q?5zJAvjoGWQdjr0e8eS29GNMUOY2Sh/RL/JXowq0cAwvnIhq34m07I9m1VJNT?=
 =?us-ascii?Q?5aGDEDlBFrZWLcsAhyAC5u3z9IUOjw13PfQ/HcuBNt3HIDAL81C+f1b80xUm?=
 =?us-ascii?Q?bPHXzmilXDvHtTZTPk4n92iyq3p3VB62YuX2ysbwqFOcu1/fYcKABA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2QL+1ogzWiCkASQIp/bVt+s7/Ui8SJ/1X5p+UfEyrwMvRTw0KuxgUD2y/fwz?=
 =?us-ascii?Q?kzQtnCInMGvvbJ7Pf+KWKWtM540QPqRy6DBhGE2ys5rEPBPq+/bB0jNulAaL?=
 =?us-ascii?Q?AUhtFGfHpT50290JOOvUzRd2vE4oZmzastVJc3w+nKIKNSUNX/Xm10Hv1dsL?=
 =?us-ascii?Q?KQzyswy+4JPufYV9cOOYWv8+TTC14YlN4g03SXaSiTvAKc2r5untKa65UTJh?=
 =?us-ascii?Q?ufql14rQ0z6dJBxBUnyFJvBIyH1bTVPrc/+YBsatzUm1sgkOZ391DPKNSS4/?=
 =?us-ascii?Q?dAEIvkhIgZKE/NrXmCEvTw/EyT51FT9B9bCDDX3aMQppFdpATTGSRUFTuqQz?=
 =?us-ascii?Q?UVzkgxjSHNe7yTj8nqpa8AC2WDcsuW7X3ElGCD/NrPM0yI18iGl5rXhEih0V?=
 =?us-ascii?Q?zjuQ821v8rY+7KImJfxYxJpVLsfUImf9WhCqeIYXZhISKzMBOzDze2cIerIu?=
 =?us-ascii?Q?5lGxVZGwklAbLnETAqX6ZB3EUl79CtsedykSo5SyxVuf6iift05+QKAMNAJ9?=
 =?us-ascii?Q?8Lo2hMKLNJvPNdQtZAdxI8QJelLybBT1vshzo4WJANoKHLOOxK64Puwjqh+g?=
 =?us-ascii?Q?gGKDut437HPGh4eAWCEiNgbzUyZdswyKUAncsu/bR5byViz6G2r2/+28knmm?=
 =?us-ascii?Q?LRPkxbdEY3JpyhHKvDIIdryUWY5SNU7S9m8h9V9BpalO6duDxTLZL+82tZS0?=
 =?us-ascii?Q?8oMM20KpwO4/A8niHrgfM83Bjxlj6tpiK38ON+pJ6ElQ/Irbwn8gkDZhk+f9?=
 =?us-ascii?Q?24TTpx/W+jIdpLV1q3mO/MgfRPmy3Iy4FrOFwo/3v62ysCODoDMPBUiyogla?=
 =?us-ascii?Q?Fzz+5JpxkaDXcSKnLHQ0xmVRCv4K6GkpAG10LqthYp3HVf4+9hKIa43lAI6G?=
 =?us-ascii?Q?7zyn6O0/tcGbrb0vKa6Mr2KakfK6XRaHUls/ff4QFRRksbQFVF4j+OksSDUl?=
 =?us-ascii?Q?RwvmDWg4zYCsXU5nFBErW4y/RoXvzxiXtosi+mppd5tfFN0qjmhI1kpZqAVo?=
 =?us-ascii?Q?vuppSQOnWGCdTlFWd3IymTkcDoKqO0+g84lzXf0nHRaM1rJn+ffbbMwG4s3V?=
 =?us-ascii?Q?0NzjfmFLGrHkOe+QJsiZIuP+NL30YdNQNckoUYynMq1qRNkYAcLAC02DddhQ?=
 =?us-ascii?Q?QdoXJ/HAsw2rdOv3nz9ISUxXRX7lvMqgL8OSKyrpAnrr0/jH+ywjtKiTq/kc?=
 =?us-ascii?Q?D9yeENG5nTADqPWwYASPPw3k2XKLopB5gPCNaQAQyI8hfgGzjmo0lSt78HHK?=
 =?us-ascii?Q?FTbQJ8Ekyxc4PSWpkj1bJFi3OIaCL00DqA2SOcsZFhdFrAncoZlQvZ6III+l?=
 =?us-ascii?Q?B1l4U6gH9wyKI5RzV7KCGE1ykA8/ueOq+G4gHNnvwGuS8kGiJO8EK3uxcKyk?=
 =?us-ascii?Q?/7Zyy9EfKDUc78UrN+kmktVM9vyFq+PB43Qm0qhhiNT2K6y64FFyDdMoSmUm?=
 =?us-ascii?Q?Hbjif+CGtJh9sUmDcKX+8p0v5BnSUyg/UU5lqsS6reRHH7pLnaTnTu/5+X1o?=
 =?us-ascii?Q?OLeyQvW4AkxTln087RAsYMOHPuNFb9UGUXaNKfKJs24dwxW7Rmiu5Pp30zue?=
 =?us-ascii?Q?quODX4Kxtm7Ld/yEL30LqsjoKGaUV3lLJFGUpX6G?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbae5b0-0c7f-4c01-6245-08dd78d0b59e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:13:15.6876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTrJLBiCBCBnQ1+mcpVzxqrTpOfdzdKiHz6+xqricnTU4kLv5f3azPAiu8N5jO9Wiqyji5D8x5lM3m+1ysLR6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7967
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

i.MX95 only supports low power boot, which means A55 is kicked by M33.
There is no ROM runs on A55 in such case so that deselect IMX8_ROMAPI
for i.MX95.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 134e42028c3..e4014226582 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -180,7 +180,7 @@ config DDRMC_VF610_CALIBRATION
 
 config IMX8_ROMAPI
 	def_bool y
-	depends on IMX8MN || IMX8MP || IMX8ULP || IMX9
+	depends on IMX8MN || IMX8MP || IMX8ULP || IMX91 || IMX93
 
 config SPL_IMX_ROMAPI_LOADADDR
 	hex "Default load address to load image through ROM API"
-- 
2.43.0

