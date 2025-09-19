Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE04CAC59A
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 06:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 996DB8329F;
	Fri, 19 Sep 2025 08:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="GI/d+BM4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAF3F81E13; Fri, 19 Sep 2025 08:59:09 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE36F82C84
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 08:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1TlHyqlm3AQS/GfvrGs8AJtsLMYeUqdfdz/fK8WPWY9dorVmg47GIFAJ3h4UX1kVcRVYie6Ao4NrKAxGOTpD0r3jV9gEGck5EXkW/VpD01j0OAJp3YR+OmaJzLMiuk8tORcHkytbpHwXczthihKGB1QgVAm5CicCJNOZgeGB2E6+Lq/KoKnsob12FmGhl1tE1vUTLZ34I9DwMQK2hgO+xnhxnwhgkujNTdMvBoHiEoyDeAqczqhRDPwkxpyEgOjwFowiyN10XDf+0wWrmrYPrMKn6SubB8TE4KJ9iytPqV2Yxuek25Gh2E+PGY4/H0iwWGGppY08Yl4cGI0y8tkYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYUP88IGOWZWr9ayD3bq8qZANhPa6nuAWyPkYhJ/fjE=;
 b=w075eUnJNCTTWLaqkzqleiUzsyyj0FQpIyq1UoybkWdEsFEr9eCqdL5uFo6T2d64u19M6iJDJXj6JxKaxoa1S6/suI+Bf7rmGvswLD1dNBrqoep+hI57KihATfkXlE550Fq/FLu9a2XkeCjPZh62AZDHldMEpJXRqibI1JwLwkmyjAGDLbETbi08ccSLTRg+c9ZHoH0cbmAzf/7pZVlRKxIk5a6e6QAeLaZ9U4a3PMrKEmLFPgaX+Exl2WP18tWhMJHBiqGVXV+U8ug3/9QKzHNLSmK7Xl52SSMPYCCxbGsXH+AJRjTWN42Hl4O2JP5Ha4KQFJOIcJYC/McP6Yd8pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYUP88IGOWZWr9ayD3bq8qZANhPa6nuAWyPkYhJ/fjE=;
 b=GI/d+BM4lDnUM7OYyhBMZSDPBcGC5yu8NrT1KGWoppXufWDE1sr39K1j0izAUv8SnOpFB4kElceigB3EmUeW4hyLWnw/d25lS2/kCJKlAnCDsL+6Rihc1cakMoVkXCN/KTupX81KUPn8PMNyfRa0Q3Mh/O4nqWjDX01XojsSBmrTBJzrpA+nYsBTQkJ+DN1K/++TDsIuEcmESMepHaGXzsQ8BvQTGLlXOiHjMfbpoQrWsRoQvQz3v0ya0CcDlNgaladfL62TNf+CFpp2qjTPdhPK6zQt1r2jGns91gfgez1XuVQQzafZbw24sxAJKnaXV4cWABZie/NjxUCx6JOGsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by VI2PR04MB10978.eurprd04.prod.outlook.com (2603:10a6:800:27e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 06:59:06 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 06:59:06 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de,
	festevam@gmail.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Subject: [PATCH] imx8ulp_evk: Fix ELE FW version print bug
Date: Fri, 19 Sep 2025 14:58:33 +0800
Message-Id: <20250919065834.1497068-2-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250919065834.1497068-1-ye.li@nxp.com>
References: <20250919065834.1497068-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|VI2PR04MB10978:EE_
X-MS-Office365-Filtering-Correlation-Id: 981be534-1911-4a98-e946-08ddf74a0664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|19092799006|42112799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DUyzbU3ysv1wXEbDryrA6jPW8rUHfft783B6e31e+lfOwOCz9Db6emLvmA6D?=
 =?us-ascii?Q?7V75xrsKwaggSpOwv4Pk3/cDwl+8pO2sVR3Rga9dZKigPTWjBEhBSmMa2DUp?=
 =?us-ascii?Q?HRhi28zHl0yjmqMEncbCkhQ2h6FtvljlVaMT01B9RVehH9fQSsHI3GJjyvrw?=
 =?us-ascii?Q?A1fqpMhf31dVQFGApZ2EzbDm35YMKI8fQU6jEEXphychnZFckSdAcQ9pY+bU?=
 =?us-ascii?Q?wm7YYMbkeMlbjwUMcVE6xbIy3/ZcuyrXWi4ywBym7nXO0/E1avjhSMfwUSek?=
 =?us-ascii?Q?8/8gmKdoh7nh4Ku8akEPMpxJiKcZZELbQV/mfDOT/1wqb+xtRvnyzxvRW3N4?=
 =?us-ascii?Q?03CEQ7VvcqwNbAlnVG7btp6GDTguifs3uZ99L/EhZBoq4Ih28RuzSTVIpLrc?=
 =?us-ascii?Q?pF5sZbsTHlPNR25TcTglSeyPZvTDc704QDy+rYDv6QBxkN1F/IgSbsO3v/f3?=
 =?us-ascii?Q?RBn2W5/ytlIPiplOaKXmAzrH+1pzfNYuYppAVDQM0Gf++Ydoov7Pu9hCxqeu?=
 =?us-ascii?Q?j67ZmZWox9GhIbmkRj/pSFyqvtmmT8NNqnZtm9YeG0oJjfU6eih4mGwcS6hb?=
 =?us-ascii?Q?NCq6+oxJlvGj9S1AFT10oaVyl5exZafkt2AoS68zvbjddgKY6iPIqQkwKCnh?=
 =?us-ascii?Q?iUVgsaPi2onj2kjbLRiM8UFd9zft6GfLVWymP0rhM5mN3xajDTwAsyomlVCh?=
 =?us-ascii?Q?f4604eXBIjBoDC9Iun5lIlMmM53S1QEBIeOHIYwkSA4wf2wEgYHmXBCvhFrV?=
 =?us-ascii?Q?NPgTZEPBTnOkyrUFiYhdvrIE4eKzFRAOPZH/97qn9kszMJNnu+T/5aCtnMX9?=
 =?us-ascii?Q?fAP0qmhe5UCmnGbfkwOKItShZUeUDjHwfRGv2hmvSJ9ism112uMtxtQVf31V?=
 =?us-ascii?Q?xpjeOg7TuI1QjzBj1BUOyMTTV007gy0u3F7bLdRuQgTwvxQael7vudylEm26?=
 =?us-ascii?Q?QFDUbjlWHjI/7pDPsMdeQlMNoRBq/rDxuLUsyE6739PWGBECPKVWMA+8t0ZN?=
 =?us-ascii?Q?tL0FH/Qy3I1gSKTE9+wYPMrFq3fMLoi8hTlPzZCqMqmRNjrrwA69EPE7Pp40?=
 =?us-ascii?Q?nQP0aUMzJJQNZWYjGL5dLbLijLRaO4wHJ/sf0LF3EcMViHnbl12ptJTiq1BO?=
 =?us-ascii?Q?cO6wXFFmjmNyxhYSviHpxNQX1khuAwBQL9OUGvaPMNloMlilKCT1ONjFW3AQ?=
 =?us-ascii?Q?CIJkKCSo+/SodQwDxzr1eiM31b2VZAb2b2AbKWxUI2wlDNh6YaoF0u/oIwwu?=
 =?us-ascii?Q?j8bP3Prhy2N3hOTmnP5ALJeJ/WWo0gV2Jwyf3M/YidgUHd6iPSG0vNT/8iNa?=
 =?us-ascii?Q?QHftDd7Iv51YI/j2TPflvaQQ8AO6AePFwFvEYZAaCi0gjN+HZPVhRLyD7S/S?=
 =?us-ascii?Q?e3jjUHo1lkcd25UhxvfsLJXCRFekGma66W3XjJ5ipCqfsRlR4o32Q1rjifUu?=
 =?us-ascii?Q?xhG7poK2n6UDS7XApbGZ/HHo/ovOmXLC4ojAHhw+1y+GgK7UeOyGCA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(42112799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pie5wpNWhGTPAfS7zNTr7ZE7Pctqq0ub78LI65V/8GD8PVUcRuczGannewDE?=
 =?us-ascii?Q?JVT4nuixyBz/EIy8/WU5YqdhQqr/ypI/kKyTQtfFp7mLlYnvviKrO6b2rLC6?=
 =?us-ascii?Q?cFV1xVFpdObzZWP9FwYMU01ohgtwfCM6vm3juRdUHwgxu6rRqKpjd1qL4UMB?=
 =?us-ascii?Q?joeiDKZhKcX9QaIrBDCh9hsHt8/mbFYJXiyZr98hskO2dxZTLXM1c9V+ExxV?=
 =?us-ascii?Q?+tuzm+f7uYSXvtbZL9YbGt09RTy+BoyleaxMek5OrNlc6Vwny7La6i5sSFVD?=
 =?us-ascii?Q?I3qR5vIPA490Bq9uAekyjJfewrFmaLrecr/Qzy/gLPIWPP7TC7ridmxbhJiE?=
 =?us-ascii?Q?Tu6yVjVEnA+IOWHUst3rmk8/cy0k1ScBBCPEz0bfp1VdYk4GuILgR6HGIt13?=
 =?us-ascii?Q?WxVztXlnqdSaV7JK30PRCNQBPjeUILZ7+In9xB66CLxezfk0KXTfx8/LHWjk?=
 =?us-ascii?Q?kWd5AN4FCvc3BIQWvGGgPEinl6xeiD8jdm7OP1ZH7T3i7YafOnRC8vlk3LM3?=
 =?us-ascii?Q?zyJfP/LnhPVzgCUzyAjlJ/quxaYXblEcowsceY4V1WZoNAmkLEK+5EJmJqsW?=
 =?us-ascii?Q?7nMnSmdAe7clEDe+4x6QCTce1JBaFifq2SC77QWTWchj8JUaa+Yv2IO3sJRo?=
 =?us-ascii?Q?BRNgh8VOHMmEDBKJAsDXI50PegGWtN2n5GG4KEHGLDK2q4x8H7yKaN+3m0jL?=
 =?us-ascii?Q?cRbKxbJvdTQ0bGUEqF9M3qBARhOk313neBoZ/ZnbSzaYS30eleGr2ATs8stf?=
 =?us-ascii?Q?DvYAYCJjSLl/s6wpBfk8VKtba/7ATKP/k+xiaVNdU5lWoFUfAazbA2+Wf7to?=
 =?us-ascii?Q?cm86r/tZoFVke2MfaPMhDC1OeoteKck65MImB7lH+0ld5+QlusXyuDi1yeN6?=
 =?us-ascii?Q?86rY/oN19sIY/YPeQbzs6Mxn+7AEYaKhTI7Epcp8haHqI60p+Tvnam7A9f3m?=
 =?us-ascii?Q?HSn1uQSY5foAMHGR7oI58vwWvfKkEeITtAoTuZ2NY1bRTYdZmoPkXxaYr/RJ?=
 =?us-ascii?Q?HwPyjoA7MA34Qu3rH/Mqn5Vjtg5KrvXwYYQF++3RmSHedVazri2P8YQQ8E+e?=
 =?us-ascii?Q?WAMgOYRtPTt9s+xGmN7+JNDfUu00aitSlEDw3n3n4VU1HTcVApARMAARntC9?=
 =?us-ascii?Q?VWoqhYZIt+LVoB5j6wc6/4HZBe744shCrJMuLX1DQ8w4zMyiBV7q7gPk2mFP?=
 =?us-ascii?Q?3xEYverzB9bGelB2y2zxr9mNW3Ea8Tk1ljQa2dwffSD+27Pds0tZ2gKA551l?=
 =?us-ascii?Q?d1Vi8tNV7N0VEgj1heu7mBiV13yspt88fTRyeNKTKdJwWPkaiNpTx7bqQ/dJ?=
 =?us-ascii?Q?W4cDz8VCsZ9KmTXtqx40ZJRbb2pKaPp9MyCydcOY6R2fwj9mmWLZH9Z0yaTC?=
 =?us-ascii?Q?B88hUKYSyA9AMmcIf3v0TVhqescDW6EMd2hT0s3RWCKR/47IIiTRVL/Pfkgf?=
 =?us-ascii?Q?VDQ+AWagnk6dV3E3nCRGRAc8wjIjGABoBgNuDYlnPFoptvNbYze1gXS3c65c?=
 =?us-ascii?Q?Xs418T7kQ40bHqrDnwwqNYBz1N0qOwdLyhRyV9FJPlVFuNA2FXAgzvKoZlvK?=
 =?us-ascii?Q?J6slzc0vhnPT/q2v/6I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981be534-1911-4a98-e946-08ddf74a0664
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 06:59:06.5818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1CM8z9GdMKrozLmV1egoEY2vIfnfMh2rx0zDPLetqmxzXTI99L7mzaZ6rZi0GNM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10978
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

According to latest ELE Get FW version API, the FW version word is defined
as below. The patch version only has 4 bits and minor version has 12 bits.
However, the codes use 8 bits for patch version and minor version. Add the
patch to fix the issue.

ELE firmware version
[31] - When set indicates a dirty build.
[30] - Reserved
[29:28] - Hotfix version.
[27] - When set, indicate that ELE FW is authenticated and operational.
[26:25] - Reserved
[24] - When set, indicate that an alternative FW is running.
[23:16] - Indicate the major version. This byte is checked against the
version set in the fuses to determine if the FW execution can be authorized
[15:4] - Indicate the minor version.
[3:0] - Indicate the patch version.

Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8ulp_evk/spl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/freescale/imx8ulp_evk/spl.c b/board/freescale/imx8ulp_evk/spl.c
index d123b21b722..fe637077928 100644
--- a/board/freescale/imx8ulp_evk/spl.c
+++ b/board/freescale/imx8ulp_evk/spl.c
@@ -69,8 +69,8 @@ void display_ele_fw_version(void)
 	} else {
 		printf("ELE firmware version %u.%u.%u-%x",
 		       (fw_version & (0x00ff0000)) >> 16,
-		       (fw_version & (0x0000ff00)) >> 8,
-		       (fw_version & (0x000000ff)), sha1);
+		       (fw_version & (0x0000fff0)) >> 4,
+		       (fw_version & (0x0000000f)), sha1);
 		((fw_version & (0x80000000)) >> 31) == 1 ? puts("-dirty\n") : puts("\n");
 	}
 }
-- 
2.37.1

