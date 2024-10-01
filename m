Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854FCCE7D12
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 12:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4D51890EE;
	Tue,  1 Oct 2024 14:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lANcH4fM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9771F88E6C; Tue,  1 Oct 2024 14:04:36 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1716891A3
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVAPFomTiccOwlhOR4zhuQg5isnCE8j9oIb+fqP4+USkArxWS7zvB4BmxPKDHMypCygyeu3ACTqWK3IhDQ9wfOonn5ZfselW45ISZGwRTH5QMpmeJfKML8e1NmR3WawaCuszSeOHe3XdsaDWCBp8GeZnN7GFb+TQsuxPWywEvkpK9bjNzWvXtWqC6YtaDQeEDMNwIvmgG9B7fJhd3ilBUDev5EjHicGI15oz63eSAp9DS850mzImfQVZNy9RamoAZ0Hf8Rfz5hr6RhbIldPVLsGLZZ2YnIkWBYkr4ei4MMpLa30b87T2zeLC/zSeUatJm0oP3mYJSKPFNhXh9HEVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UzvZs/KsTte93p/TpTgUmam7u5hqYIXAtomnSM0WGc=;
 b=PzU2FRqWghZadqXu1ptb2xpWMBDQdETlLCYOjYKPciznsFe2IAqwJB8uq3X7qOSoWhg/j+VuFKKrXutdZHK3M/LYhDn5eySUOtW96Bks25CZd3gUzGlM4TOH7OKwSuzWIzCcnBiigRTi5njucR5ifRcWRMbYepKcQWxtUeqO7bYWIu1yH7ryDYIl8DVuFK5qhWfvT9Trl4B9xl7/pyCReW4X6mHi987frYdhjrZ+xfEAyzNw/sfwzRGyEa5iaYL515USQHWR2Gd74tUMkGEDFmPiWnxDBKS5aQHMenGh7vVnlyAnGCx0/HKCnrMqPxZ4jKpAgNjug4UuTvFxlji0Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UzvZs/KsTte93p/TpTgUmam7u5hqYIXAtomnSM0WGc=;
 b=lANcH4fMlpISsjy/U0PfYB2uUaLvaRFutqjrWJe+Bq2497pxe3kMd2uwN9zJ+mpDQ/PIm5T6lAPeHi+a3df0DtLrxs65WRWLvo23COupOgG5hn7r8HnWmgk3UYIhp1LqKS8i9E/YjA+MTMRx0i5DkwuaHE8TWmp9/bLeFzvnu4jD06uiWkQKHYU3r93NSZ84HXy/Yr14Rdqk7objJ2gVS/GkZkVWhdZl0bJIEmWMJvAyI8DzPxNQY+Hf4XOGRA2lNOi0xAsxGRQQJ/ERsspqAuMFerhGuwrogIhseyPiFGM61JqrLtTGEa2VFjN68NviiWPdtcKKFKec/GZXJRrPjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8533.eurprd04.prod.outlook.com (2603:10a6:10:2d4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 1 Oct
 2024 12:04:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Tue, 1 Oct 2024
 12:04:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com,
	Ye Li <ye.li@nxp.com>
Subject: [PATCH V2 3/5] mmc: fsl_esdhc_imx: Fix host_caps issue for non-DM
 driver
Date: Tue,  1 Oct 2024 21:07:55 +0800
Message-Id: <20241001130758.9810-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241001130758.9810-1-peng.fan@oss.nxp.com>
References: <20241001130758.9810-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: 9089a0e7-cd4f-4b95-148d-08dce211354d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mcvWC5Ns7cEvFCSSxjz8gLmc2HYydI6QhomDBctiEd82nzgaBU4GspGsQXox?=
 =?us-ascii?Q?yJv2hGimPT1oi94VOhG2DBmqoTOuS0AcmLbI7fw7BoXBqWCs72hmKKQRjJfW?=
 =?us-ascii?Q?T87U7lMJapJB+lnfUMY2qWW1j1zoNjsHv6h9eioGPrNIZVudmiwgmoHxvK13?=
 =?us-ascii?Q?Fiyti4Z7gqlVeqy7bYfJ8VXm2vbjd00i+9JHKW1kei6mTJO1IcxyaupC44p+?=
 =?us-ascii?Q?M+rLTa+Z54MdQwCbGZd8DYiRlYy2/20fvheJzq6pnSXgDqVOso7cE6P2FBMR?=
 =?us-ascii?Q?9SsKlGGjTB64HLb3VIyHASWqLvELXGJtcW+jC5ennylcYQaM0Z1hDlA6b7/T?=
 =?us-ascii?Q?zKZj/NkedVo6+j4HpgWFGtEuiUNhPSvVqpyLeoeRJtQ7/y2HFYNVRtr0wgq+?=
 =?us-ascii?Q?kKxR83aXYx0l6v1WEdoIcFVCOuHfh1j5bvGpRFvFDdCzc7E5uzGqok8zlUH+?=
 =?us-ascii?Q?X5+6ZhfgqURkHkSsOKRZUsf0XO2tc3FEi09Q648KdzQRw+W90LyFM434FVad?=
 =?us-ascii?Q?A4WXoCvA0v7J3iOUnKUGpomTAYpN2RvMxlLEeiFe2p6mea+wf60FSCNwaKyW?=
 =?us-ascii?Q?VT4gOsRFuyzLeu+sGGgBxWzEhP4F0LAs+XJI2oiTZSD47SsOnxVKBhJkc6Xz?=
 =?us-ascii?Q?TL4RW3KzvKns62D6VxnoY/vqV6pCC2MEp7JMixGEYku4PIDsyLUNnwRfvrZO?=
 =?us-ascii?Q?3jTlBxlKII+uxmzdWbclU2bAsKeikYkmDxpsZxXEnz+TedYzzyKGaP3ChVxF?=
 =?us-ascii?Q?K2jPJCSMdemFiXZnObRtoB7BsOnmDkX2yL1tk7zmatictMjpgJ8+9ungo/y9?=
 =?us-ascii?Q?d6FgpZ0KtqY3MqW7JVBvmCYt6FyWzzn7+rAcZvbjbVl4xKr6BWzPXqt0Jkpe?=
 =?us-ascii?Q?0rKBka1+Ru2GELDshTM+JZIK5OVdWOi+xayd+6/WxNAZnppx93BlQ6TyvIQM?=
 =?us-ascii?Q?nWWtw3C1bSOL3+6XLMDvExAM8m3RvNOVWX7BCjNg4dUVp9+W+rAcqg0njxyp?=
 =?us-ascii?Q?MXXS3ORyJeHqwsYIga8fdF2IAm102bCfr/4DVTxKMZhRkJ231MPNuK2voef/?=
 =?us-ascii?Q?pdD2h3vz9z4VBvKZ6H3LX9GMV+KwN9OYnwwjfIj5Rxb9kr+uoY8J82aT5PnT?=
 =?us-ascii?Q?oKJ343bFVoygwN/xaLarBnGx4nZCxUbgxBU1nr2greQImMNtBz3xBBQ+3ZpS?=
 =?us-ascii?Q?0niXEiKysStxuhdYVqvHQu/Dk0McVDRIV4YkVoG/siJdFD+561Q4y/XBDFZV?=
 =?us-ascii?Q?aYEOrKNHRe/7HUkoExA56QmXs91tJjH/gtpt8bk8TqHChxcWUKBIcclHfj3Z?=
 =?us-ascii?Q?7FMhfyb6LR72w+2KUXLLYKjA1dwRF063fY0/xADRku5MVA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2B49CYJ7APyL5rNuZ1m2pUMBGlAux1u/vWSm5gQjFLGjULzFvpk9kTUHcNnY?=
 =?us-ascii?Q?Il2mQyxdJC2LZsTXopzosgPmsm76aCm846Sy9JZBDvZzSnUeXA1LMTVr5WTW?=
 =?us-ascii?Q?1N8EddacdV/OcUpQ7xyLAZ2fz+7mrN0sU/9DS+J0GKNboQePt4LMIQEDLCFu?=
 =?us-ascii?Q?EM8lORITd4Sa0txHSawgFlFoS6spbdndI+8Y9mQFU0mlT1ck1v3bAvlXtyNW?=
 =?us-ascii?Q?tlN02AnYNXOL4HkAcUxZheuT+zGW8crzil5vlXdEe2owhs/nRV5PX+EpQo5P?=
 =?us-ascii?Q?/XGyRBohISjyoDGGWOkkB3kgNIZxBfbuCBdu9dR7VzF/Pe92djfjxFTvwSCv?=
 =?us-ascii?Q?urvd7uo4sWB3rJ2TJx715m2hZxigehT/Wp2hu4CGO6bkq5mos4s9tfEcEISE?=
 =?us-ascii?Q?aUsE+o8whYyWq7dnTLYTh9C2VOiEd869ob44CQw0xTBsGyJrLS8XT1ZslOcu?=
 =?us-ascii?Q?T24qeTCvLGvZ7wHTccnYRNnkEvzXfvuwTl+ahBGozwLas9topRI1lZ49Zf6J?=
 =?us-ascii?Q?thKIg7OVWgMkoUxMAU7U2rrOmy0GxMuxySYGJAxnh5ie2qMlHmaPGpjPTKbi?=
 =?us-ascii?Q?cS9PAXlv9SGDpHplKiAPE1WwMNR1vfeHZXV0ww29ID0zOC9xfeE7ZVyQ6443?=
 =?us-ascii?Q?shPa8KML0ZjNvzzx4fKmJx7uq3Ankple683tGBQNvVrCXiugCpmeDKn+snLE?=
 =?us-ascii?Q?Nvxe7ceLOA+guHBVFqonj4/OfT12L+1Cx1WhHUYO2z8IAr3HTYxmpCCr7nB/?=
 =?us-ascii?Q?4d5DHmkoMBZAjDx6K3ZkHpDNl/2gB86PyXp85hmi7bZFwf/G0ygfsaHVJVkA?=
 =?us-ascii?Q?qSE8I7+a1ot6n7K1p41E6W1OKsVrJKtQBTceAw1iq3BKyrGF8qkfeDl76PjF?=
 =?us-ascii?Q?PMpRvJtzXlF2oxpTHFsfcmSFlXDZoKIycEWN1nJc3tQXZVHQBJ47c3pDFvWW?=
 =?us-ascii?Q?9W6xGh6mrHVBMSpyVvf083Vws9nBS42hw0QhINefx6mcVSoK5mxc62pBZdDg?=
 =?us-ascii?Q?/WSOJoCwUlifQErBHNx433Ih2rVCrJMd7OF5eXGyxA+4RGYu0tyjH6g9eenI?=
 =?us-ascii?Q?g8C7QCwKYzgEap4bdlt2tDrAwCYXnhAzyD25FOdOQ9744rNvIFd6QqhMc/n7?=
 =?us-ascii?Q?EciL/eweb4ihNGcOeRSzNM7UzFcJReSIsT01eDKoN3OUEa6lgQ+y+K8+TWbk?=
 =?us-ascii?Q?aWIz+EkkZvzmhAoecrjVnN+KG+6zyJlDofXxY7PDyXliueSMT2iGZ7GhRXyI?=
 =?us-ascii?Q?Z+cT6J9n+W9w2MKE1JWBMm+v9v3fXQA2USxVBF9X+Ew0aBxw+O8J/2v7G2+t?=
 =?us-ascii?Q?rR3LtVU2l2ByqGDKSNc0TYdF8GLR1ljlniyb6bhfqUxUNVBi5OKLbQEGXGWr?=
 =?us-ascii?Q?Z7msOcaZEKFddT6SSBK3FNdSur09LQe5Q57yafkqdHHnEcFmXs0m7TXH/DAX?=
 =?us-ascii?Q?6lVXwqYzfd3GIj1LUvE8XN0vCKMQlwzFRmCs6flxQXT7xBkfei9dJ/cXx/ji?=
 =?us-ascii?Q?49YIQb0jz2Ph0PnbWr6bNCp1JqEMCBpPvQU7zh37aNzlp7pXWxgzPRMmdrX+?=
 =?us-ascii?Q?wvYS6HtAnXXIWhOvX8If5LDkKKrP1DQdM4QX8ofA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9089a0e7-cd4f-4b95-148d-08dce211354d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 12:04:31.9306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqPCq/lA269HohPUAS1RtT4G6UY8ayIcgA2yZ9g70JCuq1/88gZNEOLRTwkLM2REanOaxMYkiNMjcw47jBO+lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8533
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

From: Ye Li <ye.li@nxp.com>

The plat->cfg is wrongly memset to 0, so the host_caps value configured
in fsl_esdhc_initialize is reset. Remove the unnecessary memset since
plat is allocated via calloc.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 None

 drivers/mmc/fsl_esdhc_imx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index e61c5d544ea..a3defe952b2 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -1194,8 +1194,6 @@ static int fsl_esdhc_init(struct fsl_esdhc_priv *priv,
 
 	esdhc_write32(&regs->irqstaten, SDHCI_IRQ_EN_BITS);
 	cfg = &plat->cfg;
-	if (!CONFIG_IS_ENABLED(DM_MMC))
-		memset(cfg, '\0', sizeof(*cfg));
 
 	caps = esdhc_read32(&regs->hostcapblt);
 
-- 
2.35.3

