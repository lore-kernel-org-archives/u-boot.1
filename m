Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE85C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B50C584C17;
	Mon, 13 Jul 2026 15:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lPBK3AMS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3FB784C17; Mon, 13 Jul 2026 15:34:43 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CB8B84B93
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnZ/uOIbfcdT6w/LEhe/uxSj9s0o6YyHgbREwjUX+RLBc7oir2Lf0O9Ua3Tmvx+IXtFUco1js5ORiNOBjbGt1uu6iw4ZJg9dqbIeV/SJRIpDbYTNwByuKGNNUxM5FUyKkv8DSnYhY4t9W+xSV9om9odJZuQNRRAxhpam0YaI2WeNKtOGdYIzMPiq+m0c+wn0JXAECaW5qFAVu351zciket7Y/frhA/gMBH6rbcpjAh9NLUxXUAL/35GNKKmQsP0FXknd8mNJJzIXVu8bENmaau6/Jc0ZcIUfjT85Fqk6noAgZScoRAajkDC2hJ9f+R4bJG9gH/95YMJjJ4qWeJPUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lp6XLhRxSRH/h7EEwjVCZtxRTt5bK4LS+DtWh+zMdlo=;
 b=QFffWfm83A87PHuwjdVsImgIjs2z5B6+zCWY+pNB4N9jovhLZx0crIyDpoRmevGpIh6AiPkXuJdkCcBMzY6qicqry1b0DFTN5mpM/6hT2xtuCR3TfLst49eRUD4rMozlPFPJNceZjyL5srQoOzDcSzgoV4UZDeGxEtC7cz3vvzUVPNVnMzbe7/LtK7YExNux8wEvhTsGMtX7M3p/WCALaX65rKompXzrRkyV+E+MsHz4AhmhNuNlhLnWO1FLijDOjHQ6LvE73t7QJz+mHiCpdDU27owTdLL1wez1h0ep5YEuJ+QTP8x4Q7/x5eWnOjsBB1z9FUYW895a6ZlivGTNHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lp6XLhRxSRH/h7EEwjVCZtxRTt5bK4LS+DtWh+zMdlo=;
 b=lPBK3AMS6S80pWYaF7ZwNHDEbGXrKv76WfK+Y4MUxx26lh9t652DQLIlprQIzrSC4fjFM/7TVSG21W0Y0xV9o1CRTYHI9kzfDSYmK6hu4l3va8XUpjuZA0pAVL6f9wu+UVF3X+MLtsXnB4DFlvPoqCa4cqIMN+b88oh5kEab9CaxBgPYGJ8oUuFIn8IDZizz69bot84E9hzRFG9ZHyLAn/tDMAS5tGUnhoYZyJUiyaJx2Z9K1+oGMSjFEFeOZAANUwm3hK3uqIIg3qt1daXft/2S210jaGx9y5hxj6vJXdg40DJ9Pey4fDp6pbssB3ybQBkD5rTEPauUmchJGObcOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI2PR04MB10953.eurprd04.prod.outlook.com (2603:10a6:800:271::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 13:34:39 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 13:34:39 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 13 Jul 2026 21:32:52 +0800
Subject: [PATCH v2 1/5] mmc: fix mmc_poll_for_busy() false timeout when
 card is ready
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-mmc-fix-v2-1-b0ba3b4a8d97@nxp.com>
References: <20260713-mmc-fix-v2-0-b0ba3b4a8d97@nxp.com>
In-Reply-To: <20260713-mmc-fix-v2-0-b0ba3b4a8d97@nxp.com>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Eran Moshe <emoshe@gsitechnology.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>, 
 Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>, 
 Iulian Banaga <iulianeugen.banaga@mobileye.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI2PR04MB10953:EE_
X-MS-Office365-Filtering-Correlation-Id: b0070eae-0d6b-4868-c015-08dee0e37cd8
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|7416014|23010399003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: sL33agnXnBN/OgDA/4mOBd6Za+4uHPbdevXhvuOc2Rs0EoKhzN634VZe9UKNFU9jtA7YAHta0J5y2fKgK4WvbqHJ7iWwG62Iq5JLP7gmhOQlfHLIjHC2+ohTt7Fs/KGvq+t+0wqtO1Dtep3+Xc9vYhmxi9wLXcoMkp02CEBagrsMKoBapb0zyw/a/isokoqhNV2PvKOhlO6QxDx0JrS1aXezXlhukkjxXEWBZOJfAmESuKwJOAhX1YYcb1RyOXIc8/SuQLNeEc4RTUv0vHELb+kd/teMohDbRyqRYZwyNr8s6JXdC7ugh1K1ID5fX0G0iK23B/7BwkxinTDDF9qSJw6a562AWyGcQoCO5cNQJSHYQrDsKYwLTTY0xraYhTXc3gQXqQN+yMkVHU4a2m1KN5GQFkRUlBQ+kc6vYHT9iDoLVPiLqk3LqWcjZX9CYtyfCAdUtJIA/jzsyAoWJ9sJlZkozMa7LYkA4+KEpOMDHTG47pXi7bMu9ZriTEK387UsyuKgpQUeLeO7LICWoL7aL3cdP7/y5War2VqZfyI35nv+1qqiKqMIzm5mjJXY5E3IF8X9C2C/MJ498G1zzbeXufJofW6SNFUGKo8k/Tkkv5mYcuvzx+KI800OhugQcovpJrz3OAD6tL/KaadLPY866r71lMIaGdC/kvO6gfocD/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzNLQW1BVXhRN0pKQWJ0d0ptZGIxU09CcEFqRnlJajZqUXMwdWZwc0JSdlpF?=
 =?utf-8?B?Sk96TC9vZUZSbHpuYUk5T3k1NHpMUEZhcE8rVkxaNXVkUjhodUViTUd6Q3Q3?=
 =?utf-8?B?R1g1ck96b2FJMmswMkpFTW95bWVJRTZaTzJyMHA4R01XbWM0ckh1T1NqRVZD?=
 =?utf-8?B?NFYrOFdEVTdUM3IvME8xVlJvRTd4VlE1dUdKVkJzWllGMU83YXYveDU4Wjlw?=
 =?utf-8?B?MTBWKzhCcCt6TEJTMlFaOEQyVlcxMlRlTy9udm8veFpOTTNSbi9lckVBb2ZF?=
 =?utf-8?B?c29IK2R3eTVwb3MydmM0MytsRjlLTHhnQ2taQXRiOVNDWUJIU3IzT2NlUDk2?=
 =?utf-8?B?WVJ2V2VBZVhXekY5RUs0TStMVmRtVFBGTUl3NFRsK0kzL2F2a256RzZWaVJi?=
 =?utf-8?B?VTNQNk9nUW1hNmo2OVpLMUZBQWpVRE1zSkJMN1h2YTVlcnFaRHlGV2VHMko3?=
 =?utf-8?B?VFkzdmI5WWRNcURlMTZTS3VyUk12dGpwSU5ScEFYcG91NjNRbWczaFpiazVG?=
 =?utf-8?B?MDVRMkZlNTZ2SGNuM3M4bGFGcG8rcHRBOXVudkFjcnN4bkRzQjF6LzFralZD?=
 =?utf-8?B?SzNsL0tCSEs1WUZQTWdZZEdISmxYd0xJS2xaN1g2bHhha3VOb3E0a1h2Qm1l?=
 =?utf-8?B?VmkrZWxWeTVERThRWStiZUtNRWU4ZXJEMnplZTdMcFVETXJwYjBnaE9HbUxs?=
 =?utf-8?B?MjkvMTR1ZFVBc0t1MlZiSHU4L0ZiSFV1KzZscWxJbWNVRWljR2lUeGhxc2xC?=
 =?utf-8?B?dzBicTFLZ1lMK3JlTTc1TmtHazg4bGJQT3p1NEdxd3BGUU5CTURGZklwNGIz?=
 =?utf-8?B?b3F3SDBZMzBLQnlDWm5xS25lYnlsaXJ2TlhWcXplWFVCaXpHSVRoaDdPbGR4?=
 =?utf-8?B?RWM0REtoTGlNYWs2SkhxMXFuQlQ2b2Zzd2FGdzZSTnJuVytyU0FjZXlETTJh?=
 =?utf-8?B?Y05NOXVaOXlFOU50bHBGUUNiaFJqRmxYU3hCWXZjcyt6NFRHM3I3d0YxdWRE?=
 =?utf-8?B?OEE0MTBZNWZxRXJwNjRtRmt5ZzJVS3plcUErTVhjNXREZzkrOVpSUHErREdw?=
 =?utf-8?B?MlRkYjFRMEZmRXVjT2NFSG9SZWxseCt6SVBxeE1CS3kvS0ZyZGpyQlAxOGkr?=
 =?utf-8?B?Ukw2Z01nL2ZjOTFSbkJDQjc2NXJ5cnZKUnQzdXBzdTBueEtnMGZhSUlEejJm?=
 =?utf-8?B?NGFzNkZXaC8wTE10YU0zQXB0Y0g5VEsySTFiUVpDTWt1VjBtem1oR0ZlWFQy?=
 =?utf-8?B?KzM1QzVzN3EzL3h4MllLVEpTeHJLcExhWldVOTJ3OGlzeFZGM1hXNVRlbGMz?=
 =?utf-8?B?MGRmc1EwT003TDRCSi8xR3BEQ0hKMnZFRDN2UGg2MXhSSkc4a3R1TDhoc0xp?=
 =?utf-8?B?QmIrNEd4bEdOMDQ4UGw1UTRHUmp3dk9YQVpFa2NrM29FOVR4eG93VG44cEMy?=
 =?utf-8?B?NVJYY0Fpbkc5eHhEdFZjVTZSbXlJa3FtYUcyRFRHMkxGdVpSQ3lVQmNaZ21E?=
 =?utf-8?B?VWtMLzBiUmJyTG5nc3hudytpWEdsTmNyTytLOTN1dWU0NkQ2RnZ1a0JzZnA4?=
 =?utf-8?B?WnpmRFR4V2pMK0FYbTAzUU8wbHlQVmRodWJyVnJKYThxS1V4SkdhdDRkMUtr?=
 =?utf-8?B?Ym03Tm92anBkQkk5N2pYQnhaUmF1TVFqeWdGYXc4SVpIeWFoaUdqVE5mM2VG?=
 =?utf-8?B?L1hTbHhzRVZod05JVDJJVWI1YnY2aC9kRzUyLzFjZW1ZUk9Ua1JpMi8rUU54?=
 =?utf-8?B?VWlXenM4V2hHWllpWG16MXFNYnR4UmFJL0F3TDBtTlZOa1ZYTmQ2elc2VHhv?=
 =?utf-8?B?bTZkWVZuVlZzc3QvSXdMZnA2NkRnZUJRZXA5MDhCRDNDVzVwVkRlOTJ2QTJE?=
 =?utf-8?B?Q0Vyek9UTCtkSURydzNsSGNUa2oyRER6VGpLUEJPekZyWVhJVGZrY0VzdUdU?=
 =?utf-8?B?SHNHbUNLL2dja2VodjNrN3VwRmJVZnFucitqdWtNTUFWT1hNY2hmVjFZZ29z?=
 =?utf-8?B?VzJla2RpcGpMbDZ4OVVWbWNRT0UveklvRGJyTWhLb2lGQ3crSEViOXRZNElF?=
 =?utf-8?B?NWtBaDQxa1dBTXNFeElpWXFKU3lRcVVtbGhMcXpyUDE3NUYzNEU1R3RhNURz?=
 =?utf-8?B?RFFaWUFXa2hhRFlFeUJVeURtaTVFbUJ4elR3SnV5SXJmVUIwMHlkMkRmZk9Y?=
 =?utf-8?B?Y250UUdJLzRzc2dac3M5TDBVaUcveXpsOFo3VUVpeTFLcmtaOG5pcWk2Y3RU?=
 =?utf-8?B?ZmMvNnQrSVFkOVpIS2szMUFVcDhNMUg5cDM0a01WNXZYMHg3NERBdWc3QXdk?=
 =?utf-8?B?aWlMZUVpWjJQRFVRdGpURjIvWC9DT2tYbDJ4eWN0djl1cVM4UFpWa1FBaFht?=
 =?utf-8?Q?ajPcB1dbxsNDUqe3Hea8jlFh556jbC/6DZqcM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0070eae-0d6b-4868-c015-08dee0e37cd8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:34:39.1127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJ/X8XbVzyAxlWZLb6Eu13GcMWPo+QNqCqm+stq/g+nRfMw04fRggs/8svKhi6YS4Wv+JvWDDiYEBcUh1HXbOsx0jMIcgCtSBNWrQOluCpymOo/X3wKgTKTqpLpGQZhi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10953
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

From: Peng Fan <peng.fan@nxp.com>

mmc_poll_for_busy() returns a false -ETIMEDOUT if the card becomes
ready on the exact iteration where timeout_ms reaches 0. The card-ready
check breaks out of the loop, but then the post-loop check
"if (timeout_ms <= 0)" fires and returns -ETIMEDOUT despite the card
being ready.

Fix by returning 0 directly when the card is ready instead of breaking
out of the loop. The only exit from the loop is now the timeout path,
so the post-loop code unconditionally returns -ETIMEDOUT.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/mmc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 2e565560656..ef7defcde71 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -325,7 +325,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
 		if ((status & MMC_STATUS_RDY_FOR_DATA) &&
 		    (status & MMC_STATUS_CURR_STATE) !=
 		     MMC_STATE_PRG)
-			break;
+			return 0;
 
 		if (status & MMC_STATUS_MASK) {
 #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
@@ -340,14 +340,10 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
 		udelay(1000);
 	}
 
-	if (timeout_ms <= 0) {
 #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
-		log_err("Timeout waiting card ready\n");
+	log_err("Timeout waiting card ready\n");
 #endif
-		return -ETIMEDOUT;
-	}
-
-	return 0;
+	return -ETIMEDOUT;
 }
 
 int mmc_set_blocklen(struct mmc *mmc, int len)

-- 
2.51.0

