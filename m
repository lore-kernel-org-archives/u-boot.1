Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31436C61CE3
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 12:28:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE7E6406A7;
	Mon, 24 Aug 2026 12:28:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i1cv-JdhJqv3; Mon, 24 Aug 2026 12:28:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787574532;
	bh=R+286cMZxF1/vVphRT0WZhk8eDaXL9dTu1pw7xaJn90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lVgzHxpupkQkmmmkIF8NDhSyd0+UZ+vd87P9CmH7Lm+M7Mpbmf40HCrtAgDcTEiBk
	 1l8UGtatm4v/LjGrIgLQEjbPV7Tt4c/tdjBqzKkeRQQClj0rXTCM4u/vAXMBmd5c1P
	 xYMtNlWMpravZmszbza4KO30wEoT7mZ2zUK2qRa656MWARXhFcK7GgFIyviIrLB9ul
	 1L1MEqCirO67SHd+IYVBvIn4BpTfwzMVdln75DqwxHYpVBrckm64w1iRmo/H3pqL8N
	 ZQTsyXJ2sQn8y73+TSpUgLwryVNQbMyD5qUqEqzzVwC1nvg6uCLKG/FPxdWJsgOOOi
	 48AJscmOkiv9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B93674069A;
	Mon, 24 Aug 2026 12:28:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7EA4F279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:28:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6479760667
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:28:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GKQKEcXgJIkK for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 12:28:50 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=kQbIXgw9
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 212C06063A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:28:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOQ+YB2BEOzQNHVG1NSuI33/ifwfyAGjUsGjTxaBd/EWj8iIrL/dZoS1tAtoftYxTijBrSuv3EIrDWl6R2+e44e94c9BC26PKd5pTNszcMczGDy8JWljhLJBLhftuQtr8n1UxghzNsLXV/82TMcFGyv7C0hZJjCjvETVLIo/yLig2/9QzgOMZdDrEJunT7V9GPgPpBRLvzqYYIzYFGWEe3g1EiK+KjmdKMImf5w2E9jBchteKA99eX0xtWeqv6+O6wQLm09550Hl9UBsBtaZjN9s324gIFuRr9RX86/DdlXWSKGllmc+avngijdA9BpuE6Q8xAp2t5tiAuco99IzLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+286cMZxF1/vVphRT0WZhk8eDaXL9dTu1pw7xaJn90=;
 b=pBUP+TL6d8jB/3edcp2l8LOlmMX8aRPFxkZueRjdPYW7N0z9U/F7YDxXrj2vXC1KVvUDNErgJo47EeUXbfohWl2LedIIpkZd55IVBUNttFlxzNJdmcCJFI1WXXaOJvj7AnNxs7hNa/i2ESiU8vtdF8wK1vyu5csEfgr7L4zRpmz+B1k2p7W27+kWe8/+tj6+oRjNlRoNOHTnn5O9EvsZiBrLfqs3++nl+UuLf94OgBk39W0ftTWdlJwlX0buH4o8bZUqRi9rMfAtFY1zWiEHcdhd+/nDQaRSUuY1GMTMPLSHj5bkExnvCJDR4FsRVtMZXBv5ohF9Lf/MP8jAQ3KwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+286cMZxF1/vVphRT0WZhk8eDaXL9dTu1pw7xaJn90=;
 b=kQbIXgw9IZ7rPWd5dUJqJaasKxXB60Ze+uQvMSBUym/xyYEmsSs/O4qSSk5X5zniCFxwfYlsu+RmqUdcjhyCgOv5CuOvN0WQQQuFBPlFmR8dzrWcLjDl+O1q10diThTsAG7h4jYedQXh0DHiunxQPjASUuaQeMCnu0zULrSeRrkkMkENxI6Ksqd++ka/xYjrC/n9ONQo8aGzV6wDZJ/Y6VB2A2o5OI7Y9j8AVBg6q9RqQi63lYnkvJ3nQCOgxdJbZ2q16WWfWkRfSoReO2Gt0RicI3uyFOjHxBlrx+lTBsb4xrewH5ujYprW9Xo5h9f6F0fI5lRa4bMFIrYwKCR7qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB9879.eurprd04.prod.outlook.com (2603:10a6:150:11c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 12:28:44 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 12:28:44 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Peng Fan <peng.fan@nxp.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/6] configs: layerscape qds: enable OF_LIBFDT_OVERLAY
Date: Mon, 24 Aug 2026 15:28:22 +0300
Message-Id: <20260824122825.95712-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824122825.95712-1-vladimir.oltean@nxp.com>
References: <20260824122825.95712-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::9) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GVXPR04MB9879:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb747dc-6663-450c-0400-08df01db3cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|376014|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: DXgrfKsbCONGnAM9kwacPaHRaDI2H8BILdR0gPzh10V36SdawFX3HljwkWTJXBs3SH79HuZTZhpJdqIVBuC4aHIUPZtoo6sjXNr7y3Vjp5sfoxXJnsviTvx22xOus+TOkgLi3AwZ0+1jg4Utd/h9S5o6FlWS7BqN9bxONE9glS5l6tfc7P6lfioRJ2dKE+alH0TU6eggjI6JyJICrMvpWMCmGXmOWpgirT0lJERDZG0lvVBMFsRUqhf/QRKC3qAOPRpVFG0Zh7mHEzAXCzoF5+4lngsmrN9t00KEyt+dAdnD5R1trdiZEIjhSmdZiISTrDCS2ojsBhwbw8fPZC/ArGtGE4SgD9z8fS5RYkHdIQra+AmGRBe9ArBSLOFgRFEX1jQOlSttngCS+RDn9699eu0MgmBFGmwFIKjYa8Fn7nmNslG/V2995qVy/7ep8+bBtAjIDFhFKMZG6tFSa2PUZ8SsZUYvLa0uwL5GhQUozpQi4MU/cXJH+be6f9WCbr4Sj/FNiZxphmsEVRRkfhPb+JE1aahnKbDKBOMmYD8zbdHQckRBIl6sSWH0nKG8+F8d2Aup7fYcB6wiUth2LVeeqwr1ldANCvbY3/9w5Q96jYQLkOyw1v53Eq4C21NlnuHK+uLMJxrBS994jEt6TLhLydHfcMK6+DlR/vw8lBqgUvs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yeHPMRLYYkr89aVXaAGHmhajGGDHbxH7C+6e4WUqVheGfXDD7f2RS5FDAI2W?=
 =?us-ascii?Q?iHdfA1oMBctNGZ4weOCi+abTSBgFaZabc2Y14xyqcrYAqU0JmWiXmN3iY4x1?=
 =?us-ascii?Q?3F3J2TUD7e4FitJ7v3dj+zBAMJ+OT/laRw+4YVZf5vBG8BcWkYd3UZVBs+Z6?=
 =?us-ascii?Q?Kbahqk1x/wTMZKjj1DmjLUISOt/vgKnGODPc77Hv2DkJwwy1FD9J0Upw7O26?=
 =?us-ascii?Q?5m3d+Hzc4OenRHT6CKb6FPfOzjx4pXc58UouPSjXkXBrHQtpdAJV7058bhjJ?=
 =?us-ascii?Q?5oo4+YP3kTgkZcAHGd87EjwuHwfwFJR3cdwp0DCqcKltDu+u4cusni+Tt8+s?=
 =?us-ascii?Q?UkXy1WKknWCRXO6dwXPXZybxt5QmuvfBsCxgJpHPa0RZs+WCiLxSv916XeNw?=
 =?us-ascii?Q?GMBdrK1xbBYnMRUY9v0FQB2J1stcq7IP3lz38KuT/nk+9pusg2ArdEqycOKi?=
 =?us-ascii?Q?YRhlviL82JrhvnjouAOi0ps7kN84l1q4mCYhZDVYlFU7NHPmrUCgAGCLLheN?=
 =?us-ascii?Q?vyr7F0gCMJUeYEToyewODAuZQVroPn2qg8f5Bz+yGzSkZqSu79nh2rNtoWgx?=
 =?us-ascii?Q?IoGECxBiaGxO7FJ6fAtikbVAV9D6CDokvrlP9SxHarme8h1AocodJO+nBrYT?=
 =?us-ascii?Q?c/PFf/SHpvALA8KolPtkf+2DYmbzOFEc3BSgH9pI/TZEKaHGi1QcIVBnj5q5?=
 =?us-ascii?Q?HwgRrz4Xv7u20IKsRl2/jdk/b212/Crb/CbKRhKdCMbUdwFO3rSditCR+pO/?=
 =?us-ascii?Q?ir1278ZAsVacc6vHwGVyf6RNGij+mcoG1vqNUrmv/SRSpVWf5TcompPHDxC6?=
 =?us-ascii?Q?q+RH6yfRelVHAszB977wgAnIkcLgM1wsoMSamA29mIpXzHbn3GXhFYjoV3X8?=
 =?us-ascii?Q?q5vfchq2yafFb4iE2HQBAF6P4BhUtqqwe7TmyobaVld42Ntb7/Rdpmprzn08?=
 =?us-ascii?Q?+MqG10PDN0yKpwIuCmPUFSNfBvRTAxdnCPQnX0I8PTzX0OqlygoVIthSyICp?=
 =?us-ascii?Q?BfF/5RxXlmMeaMHN1ezvvZbAfQAI1jHBwuFGU8AMfbbC5CwiuOs8PB9ZHAq6?=
 =?us-ascii?Q?Vru6uHyfUtHQq3SY7HYB9PZ6V4/iJo+TxRgGt6WR9k+vDe882qDKl9uBrWki?=
 =?us-ascii?Q?Yz1u+9A6qD8K02cb0L059vbi5pSztyf1A0Mhz81Lqb0oseIJtorJPASmteLU?=
 =?us-ascii?Q?ynD5pQi4z1ZuJVwP383tqyCo8+2Vj3OcBbixmRcEGp6uEmdQ3nj1PrviqtUV?=
 =?us-ascii?Q?0tYdd+cwVG7TXLv/9rDyG2MORDJPJwRJ8AO/THdtFX8oEPAHjIsT2/yIF/LX?=
 =?us-ascii?Q?P9SYRhqRr6la7OPN525B+C9Q5qghxIdC9hm4Ks2rRcGC/AV96RCLZr/yFG3Q?=
 =?us-ascii?Q?L2UbmgQpayDz5+hbMkZSLincDDoU8j6qlkcyOE2gTgfEHayw5oiCEnWozYsz?=
 =?us-ascii?Q?Lg+NzsqON9HP84THgAdEo2AK4VHikM0mxbEI5RjiVe3SY8oBaHDWQFp7dR0f?=
 =?us-ascii?Q?RCO/MZJ90TaVrcv5fRW6cgo4dS0VXZ9QA6jkj9Sw+12MB+Xm1WfWvCKbS8oP?=
 =?us-ascii?Q?gvRCHgXue81HDTz8wMMPTaDR2I43vkn2+pnNl8Pb7sP+ZfefMyG2i1uNHVot?=
 =?us-ascii?Q?fEAIK+MH/oHRdDvbRQEGr5L/IPgwChtmHaP17uNeLpoueXMRe3R3jjd/Ukx4?=
 =?us-ascii?Q?VXrnkDGo5AnkK8glsotGs9yM4B/opT+GnAt+Ih1ju+4O5YRw7RQQu+pfe6E7?=
 =?us-ascii?Q?U3dd9UUDrQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb747dc-6663-450c-0400-08df01db3cbf
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 12:28:43.9311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVhrWZkWCeCGTW1to4vvaY1LXbXGy3/ibZg2mwc979zaGoOeImcNdVMP3tERJWqDF08faL97TtXJkWlZG8/Khg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9879
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

The QorIQ Development System (QDS) boards are highly reconfigurable, and
it is desirable to be able to run 'fdt apply' from environment scripts
to apply various DTB overlays.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 configs/ls1012aqds_tfa_SECURE_BOOT_defconfig   | 1 +
 configs/ls1012aqds_tfa_defconfig               | 1 +
 configs/ls1021aqds_ddr4_nor_defconfig          | 1 +
 configs/ls1021aqds_ddr4_nor_lpuart_defconfig   | 1 +
 configs/ls1021aqds_nand_defconfig              | 1 +
 configs/ls1021aqds_nor_SECURE_BOOT_defconfig   | 1 +
 configs/ls1021aqds_nor_defconfig               | 1 +
 configs/ls1021aqds_nor_lpuart_defconfig        | 1 +
 configs/ls1021aqds_qspi_defconfig              | 1 +
 configs/ls1021aqds_sdcard_ifc_defconfig        | 1 +
 configs/ls1021aqds_sdcard_qspi_defconfig       | 1 +
 configs/ls1043aqds_tfa_SECURE_BOOT_defconfig   | 1 +
 configs/ls1043aqds_tfa_defconfig               | 1 +
 configs/ls1046aqds_tfa_SECURE_BOOT_defconfig   | 1 +
 configs/ls1046aqds_tfa_defconfig               | 1 +
 configs/ls1088aqds_tfa_defconfig               | 1 +
 configs/ls2080aqds_nand_defconfig              | 1 +
 configs/ls2080aqds_qspi_defconfig              | 1 +
 configs/ls2088aqds_tfa_defconfig               | 1 +
 configs/lx2160aqds_tfa_SECURE_BOOT_defconfig   | 1 +
 configs/lx2160aqds_tfa_defconfig               | 1 +
 configs/lx2162aqds_tfa_SECURE_BOOT_defconfig   | 1 +
 configs/lx2162aqds_tfa_defconfig               | 1 +
 configs/lx2162aqds_tfa_verified_boot_defconfig | 1 +
 24 files changed, 24 insertions(+)

diff --git a/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig
index b27ae910e37b..8a7547aea224 100644
--- a/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig
@@ -49,6 +49,7 @@ CONFIG_DEFAULT_SPI_BUS=1
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/ls1012aqds_tfa_defconfig b/configs/ls1012aqds_tfa_defconfig
index 5e116a82965a..9d5d88e75e9c 100644
--- a/configs/ls1012aqds_tfa_defconfig
+++ b/configs/ls1012aqds_tfa_defconfig
@@ -51,6 +51,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_BUS=0
diff --git a/configs/ls1021aqds_ddr4_nor_defconfig b/configs/ls1021aqds_ddr4_nor_defconfig
index 0b6d845ce4fb..795a802ec8cd 100644
--- a/configs/ls1021aqds_ddr4_nor_defconfig
+++ b/configs/ls1021aqds_ddr4_nor_defconfig
@@ -57,6 +57,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/ls1021aqds_ddr4_nor_lpuart_defconfig b/configs/ls1021aqds_ddr4_nor_lpuart_defconfig
index 7d26d5f871bb..7f4772bdc5bd 100644
--- a/configs/ls1021aqds_ddr4_nor_lpuart_defconfig
+++ b/configs/ls1021aqds_ddr4_nor_lpuart_defconfig
@@ -57,6 +57,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/ls1021aqds_nand_defconfig b/configs/ls1021aqds_nand_defconfig
index 2c43b842e1b8..7c2c1dd209bc 100644
--- a/configs/ls1021aqds_nand_defconfig
+++ b/configs/ls1021aqds_nand_defconfig
@@ -86,6 +86,7 @@ CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/ls1021aqds_nor_SECURE_BOOT_defconfig b/configs/ls1021aqds_nor_SECURE_BOOT_defconfig
index 48225533cba8..98fccccb1ed6 100644
--- a/configs/ls1021aqds_nor_SECURE_BOOT_defconfig
+++ b/configs/ls1021aqds_nor_SECURE_BOOT_defconfig
@@ -56,6 +56,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eTSEC1"
diff --git a/configs/ls1021aqds_nor_defconfig b/configs/ls1021aqds_nor_defconfig
index f8625451bfe7..2d31816b624f 100644
--- a/configs/ls1021aqds_nor_defconfig
+++ b/configs/ls1021aqds_nor_defconfig
@@ -57,6 +57,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/ls1021aqds_nor_lpuart_defconfig b/configs/ls1021aqds_nor_lpuart_defconfig
index d6c982c57147..f8b868326e4e 100644
--- a/configs/ls1021aqds_nor_lpuart_defconfig
+++ b/configs/ls1021aqds_nor_lpuart_defconfig
@@ -57,6 +57,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/ls1021aqds_qspi_defconfig b/configs/ls1021aqds_qspi_defconfig
index 4f056f085ff4..b1f1a926fa5a 100644
--- a/configs/ls1021aqds_qspi_defconfig
+++ b/configs/ls1021aqds_qspi_defconfig
@@ -54,6 +54,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/ls1021aqds_sdcard_ifc_defconfig b/configs/ls1021aqds_sdcard_ifc_defconfig
index e8def90f9cf0..2f9a038912e7 100644
--- a/configs/ls1021aqds_sdcard_ifc_defconfig
+++ b/configs/ls1021aqds_sdcard_ifc_defconfig
@@ -86,6 +86,7 @@ CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/ls1021aqds_sdcard_qspi_defconfig b/configs/ls1021aqds_sdcard_qspi_defconfig
index 85089ed4829f..b792018c2a96 100644
--- a/configs/ls1021aqds_sdcard_qspi_defconfig
+++ b/configs/ls1021aqds_sdcard_qspi_defconfig
@@ -83,6 +83,7 @@ CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
index 35c968136bd4..4957d7c0208f 100644
--- a/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
@@ -58,6 +58,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_MTDPARTS_DEFAULT="mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_AHCI=y
 CONFIG_SATA=y
diff --git a/configs/ls1043aqds_tfa_defconfig b/configs/ls1043aqds_tfa_defconfig
index 9e88f912a930..db8a4e299973 100644
--- a/configs/ls1043aqds_tfa_defconfig
+++ b/configs/ls1043aqds_tfa_defconfig
@@ -59,6 +59,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_MTDPARTS_DEFAULT="mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_ENV_IS_IN_MMC=y
diff --git a/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
index 6811191573f5..9717e85465eb 100644
--- a/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
@@ -59,6 +59,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_MTDPARTS_DEFAULT="mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:4m(nand_uboot),36m(nand_kernel),472m(nand_free);spi0.0:2m(uboot),14m(free)"
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_AHCI=y
 CONFIG_SATA=y
diff --git a/configs/ls1046aqds_tfa_defconfig b/configs/ls1046aqds_tfa_defconfig
index c5eafe1064d9..aaff575c6b18 100644
--- a/configs/ls1046aqds_tfa_defconfig
+++ b/configs/ls1046aqds_tfa_defconfig
@@ -60,6 +60,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_MTDPARTS_DEFAULT="mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:4m(nand_uboot),36m(nand_kernel),472m(nand_free);spi0.0:2m(uboot),14m(free)"
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_ENV_IS_IN_MMC=y
diff --git a/configs/ls1088aqds_tfa_defconfig b/configs/ls1088aqds_tfa_defconfig
index a6ca891c7a22..65521d4208c2 100644
--- a/configs/ls1088aqds_tfa_defconfig
+++ b/configs/ls1088aqds_tfa_defconfig
@@ -54,6 +54,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_OF_LIST="fsl-ls1088a-qds-21-x fsl-ls1088a-qds-29-x"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
diff --git a/configs/ls2080aqds_nand_defconfig b/configs/ls2080aqds_nand_defconfig
index de033b258664..d57dde171c8e 100644
--- a/configs/ls2080aqds_nand_defconfig
+++ b/configs/ls2080aqds_nand_defconfig
@@ -65,6 +65,7 @@ CONFIG_CMD_CACHE=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
diff --git a/configs/ls2080aqds_qspi_defconfig b/configs/ls2080aqds_qspi_defconfig
index 11056b01caf3..e49aa2343d6f 100644
--- a/configs/ls2080aqds_qspi_defconfig
+++ b/configs/ls2080aqds_qspi_defconfig
@@ -45,6 +45,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
diff --git a/configs/ls2088aqds_tfa_defconfig b/configs/ls2088aqds_tfa_defconfig
index 6b499c4dbfbc..e2e8c843dad9 100644
--- a/configs/ls2088aqds_tfa_defconfig
+++ b/configs/ls2088aqds_tfa_defconfig
@@ -49,6 +49,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_OF_LIST="fsl-ls2080a-qds-42-x"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
diff --git a/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig b/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig
index 5de9d50965e6..196b5203a929 100644
--- a/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig
@@ -51,6 +51,7 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_OF_LIST="fsl-lx2160a-qds-3-x-x fsl-lx2160a-qds-7-x-x fsl-lx2160a-qds-19-x-x fsl-lx2160a-qds-20-x-x fsl-lx2160a-qds-3-11-x  fsl-lx2160a-qds-7-11-x fsl-lx2160a-qds-7-11-x fsl-lx2160a-qds-19-11-x fsl-lx2160a-qds-20-11-x"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
diff --git a/configs/lx2160aqds_tfa_defconfig b/configs/lx2160aqds_tfa_defconfig
index eb9a603f559d..f5cbfbcbce79 100644
--- a/configs/lx2160aqds_tfa_defconfig
+++ b/configs/lx2160aqds_tfa_defconfig
@@ -55,6 +55,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_OF_LIST="fsl-lx2160a-qds-3-x-x fsl-lx2160a-qds-7-x-x fsl-lx2160a-qds-19-x-x fsl-lx2160a-qds-20-x-x fsl-lx2160a-qds-3-11-x  fsl-lx2160a-qds-7-11-x fsl-lx2160a-qds-7-11-x fsl-lx2160a-qds-19-11-x fsl-lx2160a-qds-20-11-x"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
diff --git a/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig b/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig
index ddc6a1502a1e..c8696505eede 100644
--- a/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig
@@ -53,6 +53,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_OF_LIST="fsl-lx2162a-qds-17-x fsl-lx2162a-qds-18-x fsl-lx2162a-qds-20-x"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
diff --git a/configs/lx2162aqds_tfa_defconfig b/configs/lx2162aqds_tfa_defconfig
index 00e1c276ff24..838935d859e4 100644
--- a/configs/lx2162aqds_tfa_defconfig
+++ b/configs/lx2162aqds_tfa_defconfig
@@ -57,6 +57,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_OF_LIST="fsl-lx2162a-qds-17-x fsl-lx2162a-qds-18-x fsl-lx2162a-qds-20-x"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
diff --git a/configs/lx2162aqds_tfa_verified_boot_defconfig b/configs/lx2162aqds_tfa_verified_boot_defconfig
index fd4f238ac9ef..80a6c4a63e24 100644
--- a/configs/lx2162aqds_tfa_verified_boot_defconfig
+++ b/configs/lx2162aqds_tfa_verified_boot_defconfig
@@ -58,6 +58,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_OF_LIST="fsl-lx2162a-qds-17-x fsl-lx2162a-qds-18-x fsl-lx2162a-qds-20-x"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
-- 
2.34.1

