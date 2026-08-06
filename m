Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26729C5AC82
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 23:45:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4F2D4091D;
	Thu,  6 Aug 2026 23:45:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G7wFTtXOvINF; Thu,  6 Aug 2026 23:45:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D0C1440956
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786059914;
	bh=YI4gfeE7kCjACPrQ7wsYtVrkjFbTZnsCShCWwyU+QIQ=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=TRldOqSdKu1IO6Ec6MG2Ft4dUOlj4lM4wpFJ/J4xBOcjicUaKIWonu2ljj/l3vxPi
	 zBKGtyB+HUKEMYDWd5rk2W8p0At6WC2CEzTpfFwLJ9+Vyc+k2eFsAsp1mh8mXmNRWN
	 hARKNRxRW38xlIMF29mj4pYeaA2rKVI4q4vXJ8oOX2xJNEjs+YGZfg7J94Mnlg46gJ
	 N6XeXlczKxtj8QM9LfJfXpvYiMHlDhU2Y7yhKIFlOj1ndwAtMDEwuj9L3sf8EW5sPP
	 0u6t2PGbZUo05n0u3ENM/NQ/uvsugJZojpqiQezBRLL6/Ky0Lp3jfa5HKNQsQ5zyVZ
	 1a1wjCZm06UMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0C1440956;
	Thu,  6 Aug 2026 23:45:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 22DBF23F
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 068AC60869
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:45:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1s8U4aWcP8Rn for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 23:45:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9DF6B60868
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9DF6B60868
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9DF6B60868
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:45:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxf+Q+wdNpxIAxo5HdjWlz7hm8XFg3fUSCfqEWS/oCFfh2Bd3Jhkjw5eaDxALv0WcP7jXiWqEnm27LZ54U9hlMVxQK4HqTqElQtzHcewI1NEPZPOph03n4c2RmM4y8m2IB+KwmxWCEgk6PVKbndhH1RJqaQa9IW2Fuf67J3PBIFN/Fy1vQ0Q8TB2a5EndPj/T/DlpBT00LUJr5ynuS5+8bwQbN8fjaYQT3WBX7q8Cwn2tGsE3AfaKhNoB3lXxnEa+aIJTQ/z27RwxuwZPEL/Yq2NCrTMoZctgz4GnrOJpePqx3NCzpSeNwxOzgjDatP6NbbjYYRpXPKxIyzlRErsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YI4gfeE7kCjACPrQ7wsYtVrkjFbTZnsCShCWwyU+QIQ=;
 b=ZSPaCB/0ttdr9WQOGxPXU+Kd9NcQc1xYq3dV30adCBYXNtMZcumRRsxvFnnkckYbuCGBSpB7Paq+juDmBjtVwLIutfUUrKxyN7g5vUKogXTD0CzHoHynr/JoAWCE5kTeqIb9PdIkKPQtABXha9Xmmgo93GdntntaObexYNuuIIBGBHn1+0QME/B82mwDuq93lb1i1OSeBdCX490u0Iif3LIv6CZsWEgbwzpv8rQ9Qe6zHHMmFw8HC3tKHPRjriODow2749Ew3gI676aVPoPHYcVAIfrxO3vxMFzSG+exmMLv19RWGksLItMPowLNngji8RMz3mztSDTVA/TYkDPoAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DU0PR08MB9228.eurprd08.prod.outlook.com (2603:10a6:10:41b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 23:44:58 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 23:44:58 +0000
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 15/16] an7583: fix system controller mdio nodes
Date: Fri,  7 Aug 2026 02:44:31 +0300
Message-ID: <20260806234432.4098414-16-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC42.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2fa) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DU0PR08MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: 03afb149-e580-4d01-cdbb-08def414b973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|52116014|366016|23010399003|921020|22082099003|18002099003|38350700014|6133799003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: is+drlYC8kdr9WmWPSgWVjvSntxyjcB68Ak1y59LieqsMHk6fNnHqLCLRpXC7vYv/AEaMDlmXSmv9ebMsnVHzGKei7ra68AMaZDmWz6ZbDNdfcVvkHirmSWX+JPPcPFRb3+fu1u4M29/Gz8VXY7+hJ6DPAVA9OuzQ0MhWHZPmn6EzygQdsIDHqikcnygGz6+Lf0x6/2qhOwyYl3WUypNQrzsPPeuvUmGgNKlcDvC02W8j1NDNzq9OEV+JJIlbgR7JiGFX7FgSS+FEgcs1SlbxGBBIBSmS68TPu2TSqbwh6d/bPisRFa31N7V4CcfKXc8bgfLyO7GC7HLxh86842AhzZchz3hzAqA7eGt+tZbQdjmE2laZs7CZoNPifO+2cH0anqtvVbi3+6AQXMnXeNYkVaGW7HMRfyuxMutEQtvsXeSfD73+vicxlJuRmX8uRjCqG/Sw2gT1CJFq9JDoYUhpcHiU6MSYUTX1rrL6ld6MK4gcjzMRNM8AySAYCGJhbOhwVLrsRM0Zllfctu2EplP+32mcNhw3PmKnOxuSnT8XJN4MxOq6o3eeIoKO0Ys0Xrg5IJZSxmd+Z2DrNKbRkhHJxNbdN9//pvxHGM3RjmVxj276di5ZMnIXJhcIHAljSq45icqL/DURnTPjEvmOypZfjajuqCzmQaXnqbySFVNCGXSMVUXgYuqWt0/l3NAgIFrQxQFqydF0j2dBDUpmeIY6njVSVVkHQth/U6hrzWM/xffKumlk6KmL3ET8cqkUA7/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(23010399003)(921020)(22082099003)(18002099003)(38350700014)(6133799003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?191vpfmc0saSTPAVqqboJx8O1lmoo3pAegtSToXLTBKVcyvYxpO/43iqW6Ye?=
 =?us-ascii?Q?eTUOOA/Es50DxzJzYwape1K6x6fgCZPYpd5L43i0xynlY6rTA5RyVHNyDkrd?=
 =?us-ascii?Q?6sK2XvogVj/ys2IuQM80IPFki3gntFGtHR79OZ9s/zn0+ONpyUmL7INdOkx6?=
 =?us-ascii?Q?kqrNYBLRaG+CHqyt/BpNw9fxuUt7F5p+ocpK8dg1QvuXUmOjIgfywt8J4ZWt?=
 =?us-ascii?Q?/ZySuhvEsFHllts6/DIom+kJCaCjVDwo5eDxFvoyDguPUUHdHpUiZrO7BokC?=
 =?us-ascii?Q?NpYl4GUayhn7/WCORV2LfzHHhpm0MAkQ9pRMt2z8CRNUZoa9jujz9ltia+++?=
 =?us-ascii?Q?HE1/Uo02ALqokeNRjuRC+6rKh2Flj5T33Cor0Ib5qc9HEYcU26Lbe/o/JkB8?=
 =?us-ascii?Q?fkm3AvCI3aQ1daocRYkKymqGKSUkceRUnMQuHapbLbL+sRSya+qh4VirL91b?=
 =?us-ascii?Q?cgF5Co8rHSfQ3gjxJ3v3lAmOud/Jx7LK7ElloppevriyD66QcVeLtoZOOKpu?=
 =?us-ascii?Q?Tilot/ezH6bstlbBjLVXqj9/r6fODMCuQWQnANI5CivgAsjjbojr/YSmhdDh?=
 =?us-ascii?Q?0X7XN5xyRrzgRlLcqYt3dVUKfu1AN3G7gJMTqWeM7m+NjYvyzcJiLurAK7ZC?=
 =?us-ascii?Q?FbBOVraNP3ddNuKhMPtxjzN8awzHlVqVoTr8+THo/sG4TvTPCC/eR/RsHvuB?=
 =?us-ascii?Q?yStlvdiQ6lFiy4flueIy9aPHVuL9QF1bLlYIVi980xA4SikuWjoGnrYmz5FO?=
 =?us-ascii?Q?P88VEeEvi6ZS+Kor/drSMknMI8974Vt3Q/8nc4e+8k2j+XnzNs99+7tzX5L3?=
 =?us-ascii?Q?Z+Z2t7S3n4xCxv59oBLHhHUpx/1wEyVrsc1Zxnte1XW+VmS3QnFds8ayVAiv?=
 =?us-ascii?Q?Op7+D5I5wySQOO/t8MXzw/bR4kRwBelryoMAniHeYwPRaq8WRiSVlB/9FR9h?=
 =?us-ascii?Q?xduLBtZrnJNrx2egjP+4rU42AvedVF0GyU3O9ulz3bilFaIn3YMlfJDs5+wW?=
 =?us-ascii?Q?N6CMY8UqcjNoxHZrM07Z4dqjZZB3NPkeiMskm3Y+JF2DfqyI5XPMyb02Ggml?=
 =?us-ascii?Q?2kRv5lEN2mLLhEiQV8RdNS7qO7Oo+eBHHfAgLax1rkh9z/lk0zPvuSmT5/Az?=
 =?us-ascii?Q?Z83Bg4CTkL+ejrREKxqd4+fcpOdifOsst7wq4ZDfSOLLSRQmUh1buEYcjNAt?=
 =?us-ascii?Q?qsHO6FhMKnGKLRxXUSW8mCIfgPf5qeWFaEuUYA+eeP3kcs/wyv5Q7wKAzy0K?=
 =?us-ascii?Q?iExaZlGyT9che6WX5dOvFUp+K2OJiXR4BI5NYLbSFINFX3wO6jEKVmjVt5cc?=
 =?us-ascii?Q?Fqa4GfvaYNvgI3u10xI28F7PNFzh9L27DRLMr7v9tk4BdCUzh4Tc5EQZiOaT?=
 =?us-ascii?Q?HAJNO1lWtaTOrF1LZOZ75tWmtRNVUzSmi0HvjOloDnW7DkfhtA9XwQ/2eKHh?=
 =?us-ascii?Q?Morimc1o5R2HGNpKbrm2SwZL0lvGCrWkVP6E4n4m+0xjdrypKJqXgiW90TM3?=
 =?us-ascii?Q?vqCwA5DzFXcr+AjvlWu/faMY2cqJB9G7kMIh2X80ykHbvQBunywq6qLUoyCo?=
 =?us-ascii?Q?KHT4SavVog0cwlqQ+JuKYc5dikOxgHYV6UGVTaPlVLMgbaD9UIokl6YiqvfQ?=
 =?us-ascii?Q?oXk3lE0bNUa4JN086gIBsELFaSesT5MSMUElIOHvdWTUa8cF9+OsZI7RYN8w?=
 =?us-ascii?Q?kLbSmd2hd71toYrcsIbcwW9t/hmTND4uz/Gxtyq6makeowMkpSBcUcWnO6Qu?=
 =?us-ascii?Q?y6n9T8mNxlAab7BcxxIMhRjP/t+aY6E=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 03afb149-e580-4d01-cdbb-08def414b973
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 23:44:58.2500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHefw1mhhm3abDRyJkSDscl1M6KjDoG63Rn7B9Bh9OMQ7FyBiEAPcY4Z7VKP8AtVM1psZI+z5fvmrrXVjb30L+8M/uZBYiCJBKPwlRdq2FA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9228
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YI4gfeE7kCjACPrQ7wsYtVrkjFbTZnsCShCWwyU+QIQ=;
 b=45vGbqMLSZwnFDJJwPmS8NSXiSke2WtY6uNq5H2UnPJgJxO3/vJ1srmGxPs1fPtcKsiRmjGLwwIj5uTs66wUnmt12Q/zOg/Ada5EYkNhtXbxGx7VsARA4LenbhtNwmHtI2mVJmClXruGClnuvTTV2kRT7DhB1SxcfZS6QmEseTy91a7OOfnVi5QqgAiYu4PDnH/+J3P7AguxW9FgMsSa8Le73A+DXfqThx8nK0KV5NpQ0dS3A4AhiH6fEfZe32OfANwgxL3zAE+Qb/vhnIqmV9lwcy5dVI/dadYMjUl6ClWXY6Am3R47ITX2JgsI6TgINQ/dJzvb0Vn7wV25MEJCmQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=iopsys.eu
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=45vGbqML
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Mikhail Kshevetskiy via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The properties 'reg' and 'clocks' should exist for the proper driver initialization.
This patch adds missed properties and renames a bit mdio bus nodes.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/dts/an7583.dtsi | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/an7583.dtsi b/arch/arm/dts/an7583.dtsi
index c8f445b2c41..cbb2a96a1aa 100644
--- a/arch/arm/dts/an7583.dtsi
+++ b/arch/arm/dts/an7583.dtsi
@@ -260,18 +260,20 @@
 				#reset-cells = <1>;
 			};
 
-			mdio_0: mdio-0 {
+			mdio_0: mdio-bus@c8 {
 				compatible = "airoha,an7583-mdio";
-				resets = <&scuclk AN7583_MDIO0>;
+				reg = <0xc8>;
 
-				airoha,bus-id = <0>;
+				clocks = <&scuclk AN7583_CLK_MDIO0>;
+				resets = <&scuclk AN7583_MDIO0>;
 			};
 
-			mdio_1: mdio-1 {
+			mdio_1: mdio-bus@cc {
 				compatible = "airoha,an7583-mdio";
-				resets = <&scuclk AN7583_MDIO1>;
+				reg = <0xcc>;
 
-				airoha,bus-id = <1>;
+				clocks = <&scuclk AN7583_CLK_MDIO1>;
+				resets = <&scuclk AN7583_MDIO1>;
 			};
 		};
 
-- 
2.53.0

