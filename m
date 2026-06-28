Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5ED1C43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 18:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE0B9848F3;
	Sun, 28 Jun 2026 20:58:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="AAhfikOx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5288C84869; Sun, 28 Jun 2026 20:58:09 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41055805D7
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 20:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3iXCOOmouT+m8919aUjCHGnoIhQ1czC3chUI0eF9k4fTPcDWyTKdRR43igQDbrkvq0pyV1tNGrJdnj/oeDE6tWMRR2/Wftiz/d2YfKIZxI1m+1DrzZo27bk8a9LSvezgikM7Alx75D2ZE7QJer8Xjm2pZ0WM8E0jFwf5cX0idH9vAiuDNZOQ2wVi58kXn2Fb9DgXBwgtrSqm6wuBNYbTO13uSkqcTrGnZvy5IGNc1kP5qsu4yTF6LtuNO0fSU34eq6JwwX417aIFxA0QO+GTlfxGt0Yr2vxrA3wGB8gEniDFZm8BvzP5CKVrdAlfRu+9ZMvfNTW4HD7GJaGe3FfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sy3Idfal0S+wZGiWP+/1cORuiLnY6vhGfhda2kG8Wys=;
 b=qmi/k5cAl/DPgxQlEQuVAI+8u+94FxLYGjjQGRxJoF5g8/nerS30Zu4ToZKKV63zOPbbAsrQ3lmV1Td5K2z3aph7Sn1yFVsnIJgf8JAleS3TWkILZ6AlHTWoVhvZvWXQ0lYfM9lN6W9ZI5bia6Pn/Zz7a4ls6AWaqkdOdYqqabP4ASlmsd/iZD2sGtFyyjAH9c96QFaxohWxCqueV7zxdwUlzKLe03JFHbw3L19Pfssh7lpDAyqanIN78a282c6gEa0MaaJ4b+sNrc0Y1N9cIh9DxeUjLlaQGTPfkED48IjbYYL8oFWgkukprL9Wm6t4Kw2BqmvkEco9zMpEULAFtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sy3Idfal0S+wZGiWP+/1cORuiLnY6vhGfhda2kG8Wys=;
 b=AAhfikOxKnMwIfHn6wtUEIbw21LrAGys/5sSRnRRdEATi+F4ruectePcE8vCcScnCp+G7agNKr71W9dIYUfbuto0fSpIDMwhQwzU2CO+YmrMH3l/nNe0trWLEHzCW9phsPndxxhbm0XaOV1RfeNBN4v61ywuYjhV7i2GzXEeD2p0XgEEuBo+rzZyY3lM1vmp8OL7oqtHk6nBPgt+RRwzEm2vWBbIj1HUpUb1RJteRAA5i/thOZyKCdmfZVBGAnJ+a3XJmh81ADi9oDwuSI79899X9glSM36Qg4eBcJjxgErwmhf8gAftOnhTsiktcVG9+1oyyB7gYR/9DdDMGVKJbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by PH7PR03MB7267.namprd03.prod.outlook.com (2603:10b6:510:24e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Sun, 28 Jun
 2026 18:58:02 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0159.018; Sun, 28 Jun 2026
 18:57:58 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, trini@konsulko.com, marex@denx.de,
 Jaehoon Chung <jh80.chung@samsung.com>, Tze Yee Ng <tze.yee.ng@altera.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH] Revert "mmc: sdhci-cadence: trigger tuning for SD HS mode on
 SD6HC (v6) PHY"
Date: Sun, 28 Jun 2026 11:57:51 -0700
Message-ID: <20260628185752.1504-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::35) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|PH7PR03MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e416d9-6236-4a11-7d2f-08ded5472b81
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|55112099003|6133799003|10063799003|3023799007|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: EgQ4f/rbJfUCK7ZzYLs77N+HlF251om5LBHd9afZpXqCwcJDqooiJOmgG3W0TbTm31gYVicUfUJ9S1ezW+697IQLgbTintPuWUrpHs3K84LPP30wgo44b7qJ/FAJhYlz1N3mg6FqSNSp4/6RFnvVYTygOUeAb2d0I/ZjL4qbgZAIQr1BxnZsg61qKENTVwicsEQXNvv4E48apgV6XH5a0yM/PufagdPBlwkzoGLQQ4OOXbviJvbc5KWMdfnHdKJDyL/taxHvG5OCIDP+qGVsfBPmWZS8tDNZbtUN8D1y4dvKxcc+8yLbMci8WMywnIEbGgL3na+AEazTjBXs69ds8RrTdmSd7xUBKypdo7wyTK3HjVvFUspv6rfNM/6vP29la8xF8DEHOH+EdD1H6K5wlZKDhFHcHpC+gO6kJYkSn/sYvM1g6sRKdFRx0iqg0e4uKuBtMgrUue7nx261xTqllHA87E7KdsdyyLwaJb3gxcuPS6TbuxGRwCPbaK1EXurviQI3OgkjnphsEanaLuIIM/WcZv4eMMXfDx8zUu+8TUZMZevhx5jn4xEjQK8zjdgncwQx59jGVsNTPFRPmExgxsADt+yTPk0GJKQjhtiUr14yWL0clwfsczGvvn6BxALvM5qyGFD+dH4+se0PkcMYZl389GU7Ahob2IUh8K4LWMs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(55112099003)(6133799003)(10063799003)(3023799007)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmZwYnJxYkoxbDU0MC9FSnRIYUU0K0JqY2V4blhEb256TUNncmw0VHJjdkh6?=
 =?utf-8?B?ci81aWJja0NheFMzR2poN3M4TkJjdWZXbEQzYlpsS2lWbi8xTjRPSTAwSGdn?=
 =?utf-8?B?QlN1NWZRR1BEcm9OcDlWRFpzR2drdXUyMVBiVFRGT2xpYlpJeEUzSmo4ZEpS?=
 =?utf-8?B?NVlTSUNaZWw0aEswK1lPSFJNZThoY1Fkc1pyNURXZERpMks4MVc4dWFRc0xI?=
 =?utf-8?B?OXFab3FVRG5GZmJkUVZwNFJDMm10ZlNFcU5VVEdJZTliZmc1bFUrTllWRGJV?=
 =?utf-8?B?allJTElPd0xkNkdKcFIzMFhsam1qRXNQcTFFMS82YzE1ZjR6blRiUmFlZFlv?=
 =?utf-8?B?RThISXhMczQ5Z01ZZDRCMUV2Z1ZlWnpOOFZiTnRTbGp0VzVndnFpNWZrK2NF?=
 =?utf-8?B?STJsaE5lUGc1YU80aHdJZzNxTWowbTg0TEJtNFBuNTVwZGd5b1NuNjhVRldk?=
 =?utf-8?B?RVJmekNDODl0VWhJK2Nkc01JalhyS2RhcE9vUHo2QXVXQm5nRjh3QjlmREtK?=
 =?utf-8?B?YWsvOEdJM1h4SzVweTRCTjkrYkRFZG9lVEpqSkhYQ1F1U29abmtrcnl4cStr?=
 =?utf-8?B?ak80RFVlYjl0djJ5NklIYXhPbU55OHFZL0RmOVA2a085dDdYS25HN3FaaDd6?=
 =?utf-8?B?ME93NFJ2RWpBdmxkWUt1WDhNNDZYNWF4S2FPLzdYSjVpR2NDMFhhRzE3K2ZB?=
 =?utf-8?B?Vjdvdjl2eml4N3lCdWhSVC9rVWFVSGkzQmZyUG5oU3ZXbzBnSGJLY1UyNmR3?=
 =?utf-8?B?K3lmeVJsSW5ubnJJblQrNi9CUUZyL3U1NWJSall5dDFyWk5aUnhRTFhoZk5y?=
 =?utf-8?B?cXZKaG1xQ2lpOCtnNTduMWpFVkM3b0daUEtUbEd5eThtZnZzTkZZZFBhWlZZ?=
 =?utf-8?B?ZzdYODVpOVQrdXNmWkIvdXZyditvKzNzaC92MGJybXNnbEJUMWNVNTk4OXJM?=
 =?utf-8?B?MlNPKzNPOEdOeVpwK2M1QlF4UWgxT0lKVHRZT3FxM0tXbksrOFJzOWpJQVNR?=
 =?utf-8?B?aGovdjlYMFNtSE85TW5zcnZWejNhblVVc1NWNG4zUlEyeHIydTZMZjJHNW9l?=
 =?utf-8?B?dTBma1ZhQzBQcUZjbEFSTThBQ25lSE9SZ1ZwWHQwZXhnMXpFWXVEQkI5Wktl?=
 =?utf-8?B?d2Y0REFUVHdvTzdyL01abHlVOGVSRzBqMWJNbHRoZ3lPOW9Hbi9JN0NoOUtG?=
 =?utf-8?B?SnNReXQxU2hnV3VQS0hqWS8ya3o4OHRvUkhGS2VrTElJcU9oR1ROZjQ4bHBC?=
 =?utf-8?B?YkZzeGpJcmN0QlU2SzZKR0s2cENobG9mczUrbXIwQXJiWGp0UHU0UnVjNlQr?=
 =?utf-8?B?YXg2TzBkZ3pEUmNST2VBZGtRRWpxSUN3SCsyNU5VY2RQRE9jYkJqQVpmdHhv?=
 =?utf-8?B?TmZadkd1bzBQV1VTM1FjZzVjMzV4ZDgraVpkTHd2QW03anJqc0ttTkFkKyt0?=
 =?utf-8?B?S2liVXJpWGVVZlpZaUt3cWdvYXZQZ3A5ZGgzY1lJOWpId0ZnQUNxU0JHK3JT?=
 =?utf-8?B?Mkp4REFNUGEzdXdTdUtMalZqUVpMREJKcHRxdlFCUTZiZHJ3ZkZwa1RSS25y?=
 =?utf-8?B?Rk5SYTE1anRuNThETFpCaThQMWpmcmtwMjNWLy9BenJTYUZXNThlLzVwd3Vl?=
 =?utf-8?B?bm1KQmlJdTJyU1ZJa3BIbTlqZWNKT0R5MFA0Wi9wanlEY3VGYmhZY0F5RXRP?=
 =?utf-8?B?Sy83b0FJYU1oZU5YK0ZHdjZ3N21XWkpqbXk1U0xkZ0MvbWZvQ2tIMGNBaFJM?=
 =?utf-8?B?R01VTFM1VUQ5eXhHSXFYZDNTTFkwZTFZdm9ZN1J2amFIekxkRTFjV1QrTHgz?=
 =?utf-8?B?eU9UUTg5WklYMEUrd1BLTTV4NUs0dmcrNE5rN250c1RQejdNQ08xSk5vSmh3?=
 =?utf-8?B?MHROU0c5MUN1YXJJYUdoZjB4T2g5OG1nS1Z2TS9vWFdDTldyUmNNMXRFTWl1?=
 =?utf-8?B?Tk5VNURnRkVQdjdqSVBjcTRyM1ZPZ1E0TEF2bGk4aHZ5dDlHL0Z2UjJGYnI5?=
 =?utf-8?B?cGM3RTN4ZVlLa1AvVEtrWndHRzhvQUFJQ3F6WFpzb2c5WmZZZnA3SmVYQUFK?=
 =?utf-8?B?NWhWaHYrYkxWeDhoU0lEcVNQSURWVkxRbUgwdU9TcCtUS1JQZnZiWENQVkY4?=
 =?utf-8?B?ZWJiWXovZ09RckdNTFlTaXVncU95VUVWZmdSZUtPYWdaUGp5a2s5MkErVDBB?=
 =?utf-8?B?V0dlTXBpbnFLUU5MbzZURFJDL1BmZ20xNjVMTzVFTGZ1aFNNc0FEUVJTTHFP?=
 =?utf-8?B?WElHWnJLeUxYN21FcGFFZ3dZeEFsWitHQzVxeHN1cUw0QVQ3UURsdnhNRjhm?=
 =?utf-8?B?clBHR3o2UFlvdXdwcHZFcDFvd0JsQ2w0ZjVHSWt4V0VzUUZPS0YzVHI0aW1v?=
 =?utf-8?Q?Dkr5CgcfmcMdnjzc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e416d9-6236-4a11-7d2f-08ded5472b81
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 18:57:58.3935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VOQMC2O9IMi7Vo5gbnJ9GGqzXBvtbluRhDEX/PJk7WdzsVRNf0iI2sNrEOr+Jb+lhRu4FRFLcbs1/D9VeP/PJi/fahPUE2H077beeG157w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7267
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

This reverts commit b42c67188c14 ("mmc: sdhci-cadence: trigger tuning
for SD HS mode on SD6HC (v6) PHY").

The reverted patch added runtime DLL delay calibration for SD High
Speed mode on the Cadence SD6HC (v6) PHY, gated by the device tree
property "cdns,sd-hs-tuning". Reviewer feedback identified issues with
the implementation, but the patch was merged without those concerns
being adequately addressed or justified.

Reverting to realign the driver with the IP documentation and the SD
Physical Layer Specification, as the underlying issue requires a
different solution approach.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 drivers/mmc/sdhci-cadence.c  | 108 +----------------------------------
 drivers/mmc/sdhci-cadence.h  |   5 --
 drivers/mmc/sdhci-cadence6.c |  45 +--------------
 3 files changed, 2 insertions(+), 156 deletions(-)

diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
index a76f9e8d6bd..5bbc18dfa51 100644
--- a/drivers/mmc/sdhci-cadence.c
+++ b/drivers/mmc/sdhci-cadence.c
@@ -39,9 +39,6 @@ static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
 	{ "cdns,phy-dll-delay-strobe", SDHCI_CDNS_PHY_DLY_STROBE, },
 };
 
-static int __maybe_unused sdhci_cdns_execute_tuning(struct udevice *dev,
-						    unsigned int opcode);
-
 static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_plat *plat,
 				    u8 addr, u8 data)
 {
@@ -158,93 +155,8 @@ static void sdhci_cdns_set_control_reg(struct sdhci_host *host)
 		sdhci_cdns6_phy_adj(mmc->dev, plat, mmc->selected_mode);
 }
 
-static __maybe_unused bool sdhci_cdns_sd_needs_tuning(struct mmc *mmc)
-{
-	struct sdhci_cdns_plat *plat = dev_get_plat(mmc->dev);
-
-	if (!IS_SD(mmc))
-		return false;
-
-	if (!dev_read_bool(mmc->dev, "cdns,sd-hs-tuning"))
-		return false;
-
-	/* Already tuned for this mode */
-	if (plat->tuned_mode == mmc->selected_mode)
-		return false;
-
-	switch (mmc->selected_mode) {
-	case SD_HS:
-		return mmc->bus_width == 4;
-	/* Add future modes here, e.g.:
-	 * case UHS_SDR50:
-	 *	return true;
-	 */
-	default:
-		return false;
-	}
-}
-
-static int sdhci_cdns_set_ios_post(struct sdhci_host *host)
-{
-	struct mmc *mmc = host->mmc;
-	struct sdhci_cdns_plat *plat = dev_get_plat(mmc->dev);
-	int ret __maybe_unused;
-	/*
-	 * The SD6HC soft PHY requires runtime DLL delay calibration
-	 * for SD High Speed mode. The default PHY_DLL_SLAVE_CTRL_REG
-	 * values (READ_DQS_CMD_DELAY and READ_DQS_DELAY = 0) do not
-	 * provide sufficient timing margin due to PVT and board trace
-	 * variations.
-	 *
-	 * Tuning is performed once per entry into SD_HS mode
-	 * (tracked by plat->tuned_mode state). The calibrated PHY delay
-	 * values remain valid while the card stays in SD_HS mode, and
-	 * leaving that tuned mode clears the state so re-entering SD_HS
-	 * triggers tuning again.
-	 *
-	 * This must be done in set_ios_post (not set_control_reg)
-	 * because the SDHCI controller must already be operating at
-	 * the target bus width, clock, and speed mode before CMD19
-	 * tuning commands can succeed.
-	 */
-
-	if (IS_ENABLED(CONFIG_MMC_SUPPORTS_TUNING)) {
-		if (SDHCI_GET_VERSION(host) >= SDHCI_SPEC_420 &&
-		    sdhci_cdns_sd_needs_tuning(mmc)) {
-			ret = sdhci_cdns_execute_tuning(mmc->dev,
-							MMC_CMD_SEND_TUNING_BLOCK);
-			if (ret) {
-				dev_err(mmc->dev,
-					"SD_HS tuning failed (ret=%d), using default PHY\n",
-					ret);
-				/* Restore default PHY settings and avoid retrying in this mode */
-				sdhci_cdns6_phy_adj(mmc->dev, plat,
-						    mmc->selected_mode);
-				plat->tuned_mode = mmc->selected_mode;
-				plat->tuned_dll_slave_ctrl = sdhci_cdns6_phy_get_dll_slave(plat);
-				return 0;
-			}
-			/*
-			 * Tuning succeeded. The tuned_mode is already set by
-			 * execute_tuning(), so the tuned value will be preserved
-			 * across subsequent PHY reconfigurations.
-			 */
-			dev_dbg(mmc->dev, "SD_HS tuning successful\n");
-		}
-
-		/* Reset when mode changes away from a tuned mode */
-		if (mmc->selected_mode != plat->tuned_mode) {
-			plat->tuned_mode = MMC_MODES_END;
-			plat->tuned_dll_slave_ctrl = 0;
-		}
-	}
-
-	return 0;
-}
-
 static const struct sdhci_ops sdhci_cdns_ops = {
 	.set_control_reg = sdhci_cdns_set_control_reg,
-	.set_ios_post = sdhci_cdns_set_ios_post,
 };
 
 static int sdhci_cdns_set_tune_val(struct sdhci_cdns_plat *plat,
@@ -292,7 +204,6 @@ static int __maybe_unused sdhci_cdns_execute_tuning(struct udevice *dev,
 	int cur_streak = 0;
 	int max_streak = 0;
 	int end_of_streak = 0;
-	int ret;
 	int i;
 
 	/*
@@ -318,24 +229,7 @@ static int __maybe_unused sdhci_cdns_execute_tuning(struct udevice *dev,
 		return -EIO;
 	}
 
-	ret = sdhci_cdns_set_tune_val(plat, end_of_streak - max_streak / 2);
-	if (ret)
-		return ret;
-
-	/*
-	 * Mark this mode as tuned. This is critical for both driver tuning
-	 * (SD_HS via set_ios_post) and framework tuning (UHS_SDR104, MMC_HS_200,
-	 * MMC_HS_400) so that subsequent PHY reconfigurations restore the
-	 * calibrated DLL value instead of overwriting with DT defaults.
-	 *
-	 * For HS400, tuning is performed while the controller is in HS200 mode
-	 * (mmc->selected_mode == MMC_HS_200 and mmc->hs400_tuning == true).
-	 * Record the tuned mode as MMC_HS_400 so the calibrated DLL value is
-	 * preserved across the HS200→HS400 transition.
-	 */
-	plat->tuned_mode = mmc->hs400_tuning ? MMC_HS_400 : mmc->selected_mode;
-
-	return 0;
+	return sdhci_cdns_set_tune_val(plat, end_of_streak - max_streak / 2);
 }
 
 static struct dm_mmc_ops sdhci_cdns_mmc_ops;
diff --git a/drivers/mmc/sdhci-cadence.h b/drivers/mmc/sdhci-cadence.h
index ea517491860..7101f00b75b 100644
--- a/drivers/mmc/sdhci-cadence.h
+++ b/drivers/mmc/sdhci-cadence.h
@@ -7,8 +7,6 @@
 #ifndef SDHCI_CADENCE_H_
 #define SDHCI_CADENCE_H_
 
-#include <mmc.h>
-
 /* HRS - Host Register Set (specific to Cadence) */
 /* PHY access port */
 #define SDHCI_CDNS_HRS04		0x10
@@ -62,13 +60,10 @@ struct sdhci_cdns_plat {
 	struct mmc_config cfg;
 	struct mmc mmc;
 	void __iomem *hrs_addr;
-	enum bus_mode tuned_mode;
-	u32 tuned_dll_slave_ctrl;
 };
 
 int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 mode);
 int sdhci_cdns6_phy_init(struct udevice *dev, struct sdhci_cdns_plat *plat);
 int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val);
-u32 sdhci_cdns6_phy_get_dll_slave(struct sdhci_cdns_plat *plat);
 
 #endif
diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
index c8b42532e17..ca1086e2359 100644
--- a/drivers/mmc/sdhci-cadence6.c
+++ b/drivers/mmc/sdhci-cadence6.c
@@ -173,30 +173,6 @@ static void sdhci_cdns6_write_phy_reg(struct sdhci_cdns_plat *plat, u32 addr, u3
 	writel(val, plat->hrs_addr + SDHCI_CDNS_HRS05);
 }
 
-static bool sdhci_cdns6_mode_is_tuned(struct sdhci_cdns_plat *plat, u32 mode)
-{
-	/*
-	 * Check if the given mode has a valid tuned DLL value.
-	 * Only modes that support tuning (driver or framework) can have
-	 * valid tuned values. This prevents the initial state (tuned_mode=0)
-	 * from falsely matching MMC_LEGACY.
-	 */
-	if (plat->tuned_mode != mode)
-		return false;
-
-	switch (mode) {
-	case SD_HS:		/* Driver tuning via set_ios_post */
-	case UHS_SDR50:		/* Future driver tuning support */
-	case UHS_SDR104:	/* Framework tuning */
-	case MMC_HS_200:	/* Framework tuning */
-	case MMC_HS_400:	/* Framework tuning */
-	case MMC_HS_400_ES:	/* Framework tuning */
-		return true;
-	default:
-		return false;
-	}
-}
-
 static int sdhci_cdns6_reset_phy_dll(struct sdhci_cdns_plat *plat, bool reset)
 {
 	void __iomem *reg = plat->hrs_addr + SDHCI_CDNS_HRS09;
@@ -283,18 +259,7 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR, sdhci_cdns6_phy_cfgs[0].val);
 	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[1].val);
 	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_MASTER_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[4].val);
-	if (sdhci_cdns6_mode_is_tuned(plat, mode)) {
-		/*
-		 * Use previously saved tuned DLL slave control value.
-		 * Note: 0 is a valid tuned value (e.g., optimal tap at position 0),
-		 * so we check both mode match AND that it's a tunable mode.
-		 */
-		sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR,
-					  plat->tuned_dll_slave_ctrl);
-	} else {
-		sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR,
-					  sdhci_cdns6_phy_cfgs[2].val);
-	}
+	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[2].val);
 
 	/* Switch Off the DLL Reset */
 	ret = sdhci_cdns6_reset_phy_dll(plat, false);
@@ -353,9 +318,6 @@ int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val)
 
 	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, tmp);
 
-	/* Store tuned DLL slave control value which will be reapplied via set_ios(). */
-	plat->tuned_dll_slave_ctrl = tmp;
-
 	/* Switch Off the DLL Reset */
 	ret = sdhci_cdns6_reset_phy_dll(plat, false);
 	if (ret) {
@@ -365,8 +327,3 @@ int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val)
 
 	return 0;
 }
-
-u32 sdhci_cdns6_phy_get_dll_slave(struct sdhci_cdns_plat *plat)
-{
-	return sdhci_cdns6_read_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR);
-}
-- 
2.43.7

