Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA951C43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 13:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE8FE849A9;
	Sun, 12 Jul 2026 15:09:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kX6YNEDq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 396D8849A9; Sun, 12 Jul 2026 15:09:08 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF7B284A3E
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 15:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPH725XxqBZAEGYnFwjH+slZ9ZyYad2zila6KY0zXvZqdWqI2I+VxwDQUGtMLQ3GjGmW7WpeoL3is8W36Pfv/+7wrvtPmWtMxQRyJKEBwEZmG93zuHWCgDk/aKQ0aUfBwdpOmsOPVxHAaszArqIIsTnIBVg7ia6tsE9EFZf1gmP3PUgUel7TEMkpY198bmt2IjzGJoBGig5nj6ov8wEkP+XkJrzKVElmJENSDX2cBmVMaFjCgd1CwAMMJJzbXsSbyedFdYwCDT7sbDj0t3JPxILHUNOFvSbijMD9c8RtqWv8CWZ6aAKKm6E2yYjecaI/LpFkQQbKdH9KQ8KM3mNJ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lp6XLhRxSRH/h7EEwjVCZtxRTt5bK4LS+DtWh+zMdlo=;
 b=m77Ka9FN3ydQjenkr23dYE4jusBx7V7RqRqspWr4FqRRSkEuz85wAZzZYyNVb+h1hwQDMJ1FYsjMnuzWl2HUs8XvUj26GlfWzOaVetaYTuBHhs9DJEtEJinJklgLUBrSYjpLwCcXABbkDCoxOaL3soq1dOoH5BCR8zUXgAKwCHP0tCJ3yAdRPrCW8UAMxb6DSfA518dMOwz/AxN55hGTCkUbavbPCmAf3m0kbr7di8riH+hkWCg6GiUkeCd1BxVL13LQeHyETbs34LVcaxM2UdmiK7/R5MRQxAQbtyzLlc16QXlTAFz/dOx21NNOxweSJqFj0x455YlfoOpLEIoIHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lp6XLhRxSRH/h7EEwjVCZtxRTt5bK4LS+DtWh+zMdlo=;
 b=kX6YNEDqvnv8dHOEGFfAD5s60xqLymk/65eXdJ2/VY8aP2hemR5uACRKz1hZzZg88Ywh4ieAN3tl9CvMVHJ8h1um9lOW32QWOI28Ac0AynM5qQSmlZlB7j1tkpT+hJb033pXZEj2hblVAl+d+g0w9ixnZMGTbLe+f6HwzXGyyZOxPy9faGz8CKuXV5tNnngQOlqAmbFBUEJ7BZCn8TQG5sv1hTbiLBgI+vtlFAxHS+FMOAipN4R3M8ifP6q1M2rArc5BJRtaGmj4sQUuOB5qRxsCflX2TI190zhtncLmfp8LNl+VBSh+nKQaWBYV7puF56/24Eu3rbbMdLM5UpNTrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GVXPR04MB10945.eurprd04.prod.outlook.com (2603:10a6:150:21e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Sun, 12 Jul
 2026 13:09:02 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.019; Sun, 12 Jul 2026
 13:09:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 12 Jul 2026 21:07:28 +0800
Subject: [PATCH 1/5] mmc: fix mmc_poll_for_busy() false timeout when card
 is ready
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-mmc-fix-v1-1-99a1136bbe54@nxp.com>
References: <20260712-mmc-fix-v1-0-99a1136bbe54@nxp.com>
In-Reply-To: <20260712-mmc-fix-v1-0-99a1136bbe54@nxp.com>
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
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GVXPR04MB10945:EE_
X-MS-Office365-Filtering-Correlation-Id: b4821481-e235-4d33-d60b-08dee016be9c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|1800799024|376014|366016|7416014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Vb1CPi/Mn+kXWSzx8V1Zz3PyEMRU0yMK6aliQMIYw3n5Gwwd9FdG1zm3996371rnkys+aT9cU2LZko8s5dOXkox60m84WhnWFuR85zOl8LL07HWmkgNNg1gYXgfPtQxJ0PMFjdwMfBq+4wyZZmwRaY2o5COBIosgnfuWUECA3aJlPKgwbxLE0lHhx0N7087XcOE7cE3vHdyOs3BhDxQBcpp1//AAXzbmUMKa8fUBf5LRZkiy9uAUw5+z0/9sbVVkDGIbZu4GBfneXNNFgjWKqv+1a2rKZLKXrDjZKQjWy2MoDmVSU/zbp0xSALBhAR25WBYQD1s3uiJh0KQ4w6nVbM4P4QACYTCknlmfm8Gxtdch5IkF8IsKfyhSFu3Gl4xKDE0aiPeljoRY/brCvEh1UvSGjI2GsJvogA7on084JHFD0EnxXQrdMD11y0zRETiDxHaM8xl4bJjW+DNgwo6D9qYm37jsASM0hEG2yCDOtl+KxriY8u7ULKkfuuRZWXYoJstP7ww3b5ptIbMKH56dsmdzUJImyoa7poP2E57p/QPfTrnJAX5ZUCgqUF5ejG37FDyhpvGsXgzH/8aOnx5M4KvFV7znILDoJGT/C3Sv0xhn0rD1tO4p/+XClKC3J/z5ahp1k1y+IsTkY0zkNv7dn5JyLcIe5PvuqRDZUgU40B0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(7416014)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a285U01PeTNpaHFta0JOemppMUhXb25SRHhwODNFZFJZUzBWL1kycnRmUCtm?=
 =?utf-8?B?TnM0Y2RnV3NCZkNFS0JZdnhCTHA4RDNFd01UU1QyVGd2V2I4Q1NGMUY0Mytw?=
 =?utf-8?B?R1BTZFhZeTlpRkdUTFUzTkJDM0VBR2xZd2pEVDg4VUNmVWRtNHNROTBaTHJn?=
 =?utf-8?B?R1RSWXNSbEdxLzBvQlhPa2NoVlJNRkpYdlZlaFhUUGJoM2syL2FzNE11enJs?=
 =?utf-8?B?b01zejY0YzMxcUcrNmNOTmVoUWorQlhsTzhwdllDMmFpVm1XRTdkTEhaeUlq?=
 =?utf-8?B?Si9GK2VBZWVUUDlWeTZ0U25NY1dlM2kyRG1WZHdCcGdNTmw1emJUN254cFFv?=
 =?utf-8?B?bWtUTjBGaDVsNWNVRUtZcWJocTVwcDN4YXhDZ0NiOWl3SE93Z21aclFzYmkw?=
 =?utf-8?B?MW9OaFlxN1dERFNmZ1N0RUJWZjJNbXM3OFkxb3RRcGRIaU44Ti92LzZlRUgx?=
 =?utf-8?B?RVd0U0ZSQnluUy9ZVjgwaDhtdHFrZkhaaHVXZG5IYzFTczFPQmpLMVducy85?=
 =?utf-8?B?bmxySkwvV2kvbFhqaHpuWWUwNUszemk5TWVqK1RTWG9xWUdzNTEwblZKNGlY?=
 =?utf-8?B?YXdoVUpha0dFMCtyVjEvV2tTVktmaXVLdzRSSFE5eXdxbWcvV1lIS013OWxu?=
 =?utf-8?B?Zjh5TXhJaVFOT1J1d0l1M1NPUncxc0V3UC9wL0hKWUl5S2s0bXJMU2RSL0lH?=
 =?utf-8?B?cGh6TG82YUVZWHI4MlB0cWVsTWlyMDNSWDZ1N1NmamRtQk1kOVpvSUVCUkcx?=
 =?utf-8?B?a09idTd2TFJPWlJTUW9PSEsvQ0dPeTBDdDE2a0tWZ0V3U1owbUxoTjloTlps?=
 =?utf-8?B?ZWxraSswSHIvV2tVYWJtcllmUHZvTVUxQXFScTVjc1hJRFpGeDJReE1RbENw?=
 =?utf-8?B?TFNDcmsyV0sxUFlWNUJjUFdCbXN4ZVIvMDJ2WHVDNkFWMmZya1RuM1V0UzhO?=
 =?utf-8?B?K0lpSGcxeUhpWkhpZFlrWTFzYSt3U0ZucHZqaGhGRFRmTjdaTng3NE5wRzRz?=
 =?utf-8?B?cUlDMkJNMzkwSEYxWHRkRjcyUG9kbUhNNU5kT1N4VU1RdDVCRU8zZzFxRk83?=
 =?utf-8?B?Z0F4QkwyYWhZcWMxcHJQREFHM2NrOUZ4Y3dEcnpFQmNjbVFySHZGWEJxajZ0?=
 =?utf-8?B?RGI1a0pBZGNIYW04VUhHVjN5eURIeTFkb1BYVW1nVFhkWUU1Y2tDTXVRb2cx?=
 =?utf-8?B?YnIxSmNYY3VTSnkrVnFzajRHYnBETEgrbXBoUkRweENQNW9xSFVycjVvOFcx?=
 =?utf-8?B?LzZ3U0gyc2Q5TXJpVFFhSHRkR2I4bE5qNjlNMmdjWVZwbzdUTjFnbzRwd1FY?=
 =?utf-8?B?MUZDbHlWUDF4RjRocDN0UFBTM0VOcWswdFc2WDJ0OHVkelBLdTBSbnJZSnVZ?=
 =?utf-8?B?cEZTNlZTcjdlbWgvNmVYZXBhQWQ1RXZqZGl5UTQvUFdram43VU5SU3MxampR?=
 =?utf-8?B?azZtVjNnL09IRHE4WlpyVE9sU3BYbDk0OE51aFNpbFR6RzFmdDlTNEhwSDZl?=
 =?utf-8?B?MGttdkF0SzNHeDlua0kxcjZWNkU1S01NbnlqbHN5ZjRnWE5UTGVtSGo2YkU0?=
 =?utf-8?B?TThhVlUzNEJKS3M1UzlkZ1V3UG9vaUNTTTZDQWRmZmRDcHJBbG1vcFNNalBI?=
 =?utf-8?B?eFFaNFU0NDdFNUdOTitYeWVYMVVnQXpPYjY4TEFZL2lNdnN6aTRUMGgwdi9C?=
 =?utf-8?B?ZUkxS0NtZXJoeWUyaDlFOGh4TnV2Tk1ySXBLTzlkRFpLb09JVEJYb1JwbTNa?=
 =?utf-8?B?ODl5Ykpwb1Y1THM0NXFZbmkzTVQ1Q3p6NUoyMjV5N0NubWdtUGZaVzdRcVpo?=
 =?utf-8?B?VEx2WURFSXJzNG55ellWcjRBZlNPckcrTG9jY1ovU1YzeHl6cXZmMEt5Y3d3?=
 =?utf-8?B?U3oyNUJENG9CWHlhRnc0K3BwYjcramliUXlTSUlTNkFJRjhyNXp5WWx5QXQ1?=
 =?utf-8?B?NFpFeVRYTmkwQjZ5dWNETWI1ZlZPRXUvT2hETWVoRTNsc2dsZFBuV1VnSjVi?=
 =?utf-8?B?UHhaWU1WczVFMG1sWlBuWlhEcFFSUEhmK2hLZjRaTFF5RUR5SWZ0QzNUSjUz?=
 =?utf-8?B?WXJyY3htR3BWRndxelhzZ0swRDVHZldHUThobktybzc1SXVvK3lRd2lTTnBR?=
 =?utf-8?B?eEtsMGw0NGMxa2VMaVNjQ2hhYzNCQUFXelZNbWtNTEVPZ292T3U0bWJVWFpM?=
 =?utf-8?B?VXpQcWt4d2ovTStTU0Q3d0xPWGhwQTk5WkVXRXRJSmkxSHpJNmJ3bElHZlBy?=
 =?utf-8?B?aXZQV0hybmp6d1NLUTBKT0RmeVY4dlZXMFRUb1lMQnYyellVRGFnUGdFd1ZY?=
 =?utf-8?B?bWFUSDBOcjFkdG0wbXQrRTJZUGdHdXNJdjVacFVSTlIvOWFRTnc4R3NkL0Zr?=
 =?utf-8?Q?w43Sai+w7aOcwBHjgpli06imkhfsWkK646Xu2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4821481-e235-4d33-d60b-08dee016be9c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2026 13:09:02.6189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7eJjCv0gFSRBQF89B/xnZu6uUU9TGLkNnxRT/obdKIT998HWgeJftuBgjrDyJ7NtzKBym07v7FnJPHxqYkWLGe5SddnJwP12VJkMjmC6aw0zzsGUfZI3Tug+/9UrJs6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10945
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

