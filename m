Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A663CD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE18A84946;
	Wed, 27 May 2026 03:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Y6em0SPj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ED998494D; Wed, 27 May 2026 03:20:52 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ED1884903
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 03:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FN8a3pSRjlBdvMiVHIcxctzOy6sgcUl4kKyq/CkvLyvXTqJgOSXr2Ak2HGUxCjDNvHpkVP5YbUIwXCNsDG+ORPcX4feb55AJiloWx8qsi/bb26Q+RCjxRbhEwk5kBgOIPDbp4yxMygrgl9zQROnHrnzz2z+odL7VAqxowoOrimnx7Ev2NYLSHER/4cITUv7uv15Eq81Wkox35vU/8JH4ddH3OQDLkzEFziNeNi4gNaPK29VAqfazGEBr8MYIcrsmZC9IZRY0R/Cg2/NSVpV4GWzcebEEU82vrh7XKRbf1EvC/+RikF9+QLMJmYvEr3EH3kyYe3I0SLeM2CqEto0NKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtNw/dEfXFruOH6rF7advkFySZW2yWuIzjyNfZqaR94=;
 b=GUTrCDy4ezdZ+NR2VxJhIejZEbv1l/GP4OvQ+GL2kEWK7nqwwHXgy+sAisAbJZ9HsZYXXvacOSAdyd6+H29hu5MX3bhwczo/AiQxrt80FXNgdmVN/xCncMnd0HgNhN5w70Tel6uFBoRRyJZj5iOTl4WuqtA1tjLdnMrZlfBWniMpg9S0PRi9eKa4aXpJmgnOizgSzdETccc72GbDGzoAOxF8z3cA/fK09/16aNvgP9okKo3NA0k72ZbRRTF36ZNEvms7B6YlvvMaNtwy3vhnm7TkwUMTVCc6Ajxs9kEVn5MTd0/dFVpr/WaaSLGS2y6+pwCeNwpMs6yylmubuPGcsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtNw/dEfXFruOH6rF7advkFySZW2yWuIzjyNfZqaR94=;
 b=Y6em0SPjGhjB8ZD/YoVjBFRnRW4lqEuYCwVUjZrwmsrur4URUVsFoZ+R0Rx1o1eLLjJZf2yk0zq4quoVabViRnyFppxqCWwmlXrMP/A3pNMGzol/uI3MrfN02qBs3aSJ2g95yrTyg4Kd/AoTdksWgti1eLDkJX7F6MXL2xgu7P9AgHKCgJzYTNYzvyfHgMJ6Ta3U/oii1h/X6RCHGAqlvwjOgXSSaCr3CEkoO7mDS+LEvBhMvkJHQkBTCyk1RkFgd6zGKKdtIAl+MdXI0AFGw4gpGkEfUK8lorRGFl4XQ0gXFh8OvrlkHJTnWBfbxaB8kPglHvBwkBs20TL98vlqRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS5PR04MB10057.eurprd04.prod.outlook.com (2603:10a6:20b:67d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 01:20:43 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Wed, 27 May 2026
 01:20:43 +0000
From: peng.fan@nxp.com
To: trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mtd: hbmc-am654: Use dev_remap_addr_index()
Date: Wed, 27 May 2026 10:37:26 +0800
Message-ID: <20260527023726.3121176-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::29) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS5PR04MB10057:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d9d8ed5-4bde-4ab6-d7b4-08debb8e2c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|19092799006|1800799024|366016|38350700014|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: YoI1DRVa2Z3x3SdZnzt5XIiRGcDMAy4kgX9eFa/WytouHVMxW+LVu1PpobagV7Aej4otZ8IYQM2r516Ueo/PDIduI23pegVX8JdustHafHsimjU5dZvZI6NMI0inkYbSWH2AtHZy30Kcj+4exSyKC6N85+MnTDUPanapOkgLTMe4ZXt1Mkbd1TOheL21DQwLudNWhUvR6srfhyf0d00xzHZHVQwAwO+P98BZ6jDWIU5hF/MY23ElmYidRbMbZ6eR5OPcQ4eTyDWOFIy9b52zxc5XFNF55vf6OTh6wHer7rDwTNE3E6zzEt3NouQS6nZrCMV1nBF+fkARe1bcF8VTbfHAsygqOFZCh534Gwd+qivRitfMz6jypci/2k4hp9DjlPZfNI+t86giSRZZNY4aRa/r8zSLIBiNiwxh8Hf19tiG5//2Yaq/Y5+f458gyYAHzUJEPTNZAkLMdyzPxd4lxL444MLFzCfaMxJtsDsJVbka+tPzpvmRkEFGaczOsSZRVp42bJoG5Mguh+5f2jmpu9yaXV6RpF0fw9PKROaTDltcbkLvY8mJQXjIiLpEQeSqHhsF6hSJ3JZpNnbcB7LK15ZwArbfobiRyD58oUvp/Q9Nn1j2QBafvcfdUHukbuJ4Kho4mJtnxR99XmA73dNX6v22OjuSW5gSlnGjAx5XcMsWkxHAfipIusJExZf7oq7a13K2Mk2h1obvCH6PBbH8powWJjO5TuZO10JA4nq33DM/VqgmN2EDYR1eKZX+zcLE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i3b0mx5tPdvx2f5N7w7xJ9yAn29iF/KKr/vVANMQR9V5cljtcYhEnt93UI+p?=
 =?us-ascii?Q?lp7pHKi/JLcxtqTx3p95Pn51EEFPoCCFF73XoAZzEEFi2UvWfsWJ21p9bv+X?=
 =?us-ascii?Q?x1amBzXXzpvr1WAZwZVap1EYsyAev94mjQQtd0/KNhhNn0Pxaidj4xXhTcfU?=
 =?us-ascii?Q?CpRJv4lnBhN6Fk5zacFhmA2lWYsLOMDLE+DA0rJBK+Z/kKCQSf4pcdWojW0K?=
 =?us-ascii?Q?+k7splXVkn9SQABgXO22g2JwJg/OPdNemsaCSkG/bdVRnmVYbARrh9r3Jkpt?=
 =?us-ascii?Q?0UnraljbkZ6A8YNQ+Lvfgwi6Rek/0lWKrqBEz4js3in6tCTQn8bgMy+e5VF7?=
 =?us-ascii?Q?TamJWVUEkgzPuXQgEgkVwOTtORuyEotYvTr7yO1bIPK8mf5gyzrirLxHv3qO?=
 =?us-ascii?Q?da8EN8oD2x8sVDqBGAjVe8Ms/z/lAfqmCpuLxOdqmjc3RfMSIfzuIWyKInVh?=
 =?us-ascii?Q?sPAvsx8QNVCxi9PoIS+rVFjbSv1GskqcQT1wSQUPvhF5yN2t9ESRA7NodnxI?=
 =?us-ascii?Q?VK8U/ORYvOPqZEwEs3WVnHLXPJcJhLXqa31IC5y4GQewFjSs0prJ8TXWa1CZ?=
 =?us-ascii?Q?2o7EzdZ8ZkvD56a3UKe7NJ23oecITVaiQUbcvDDisJhJs10R15fLfbEs/8Mk?=
 =?us-ascii?Q?i9ZBavr5ZdIvbHoCX0U340U/yH5UUgDUulAWgVJCd9ZB7fLcRpK0puRGlG5G?=
 =?us-ascii?Q?GZ8KXs0JTe4+gNfyRLtX7uga/IFeaqjxjKauFRReHOhWPq/6Mq4K5+vWegD9?=
 =?us-ascii?Q?7PMX85R3wUJAMzaBGq+EqwPZkYM5tICoerlHh6EuK5VzIC1LfqhBGIp5iC2T?=
 =?us-ascii?Q?pVwlsTPjpzptpTugXiHtbdUtrQXZP7Pc1gf71mvaILbAmeyuSprxU0P6n0vp?=
 =?us-ascii?Q?+WJfC5CuWToKbivdEN9UcMccaIlsriI8eHdg44aHEcbNaxmhUs3VZRy1wf7P?=
 =?us-ascii?Q?KHw3/7QfJ7WAr8OxAxzdhpEXr5sJpcsDr9ieG/sc9Fzi8fXAvxa5rDJ0CQu3?=
 =?us-ascii?Q?+tghMe2sxC55XJupLgIqj+A6D8HmCKugFOIbzRCDloCNHZgdriwHz03Xa8v8?=
 =?us-ascii?Q?/11BknTfmOUM8c6x+tSc+WcqLo1No9OOB2irjKiK0flJ7bWhWPeDCzgCqdia?=
 =?us-ascii?Q?W5Kq0waE5guNeeLRNsrFsCRtsjAL9qE0xqVl2Wt2wsAX3ksxTb6FyboTgX9+?=
 =?us-ascii?Q?6e29OsCK2ofsX64tsiTXF1Pdi5BxVrhn46XTkjsFMibUvhoSCDu97QuE7SU5?=
 =?us-ascii?Q?zohlpNeC0ciyH+MM3e+uFoOp8BhyjwYUXC17Fg92JJ8+IDwK1kGuEXKQbLy1?=
 =?us-ascii?Q?9Eff81TbUolYU4InaljCJBHoL1A/s6R1Yc/d8lIIYrc+iKeYvBMSR/pwIeWA?=
 =?us-ascii?Q?8HPYN9smCT91RWeTLLz/apypPq+Z8qDRMrPKBd0aRORXE2tfK9TkczJ2KMVZ?=
 =?us-ascii?Q?q08tJog/JygO9BuOCOpsD4xHWaEI3swxquhE8oCUZbU++7t6tyEubeFE+X2M?=
 =?us-ascii?Q?xSfkgXJJ7wXSOaLsxL4siVOyONhCjzRy7qHzbvI4HriJyTEe5rcjWlnDzu1V?=
 =?us-ascii?Q?KcCaB8R/2XipmKF7cGFgUTJ2NtdvmOzC9V3rX1d8CVgqFfUFn7XcKE1mC0aQ?=
 =?us-ascii?Q?M0obk91yAPKE4HZTgxoixEEh0YL14oNCHL7a77TkGoQLITAhdxDLGQQuDiAU?=
 =?us-ascii?Q?PYn71zwmJUYWl43fyWDOLlalJRWFsea1aO2cmvZDzQQ7ziwgnmZGoRYnrH+1?=
 =?us-ascii?Q?kmkPfCH7/Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9d8ed5-4bde-4ab6-d7b4-08debb8e2c49
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 01:20:43.8236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wJo7PI/bHFjikt3zPAsMU0JhL+XnZFk/BoaBD+Cx5L3Jszhe77FoyTYbLnexQAvuvkacE9aopI+LWrM1z4u6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10057
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

Use dev_remap_addr_index() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mtd/hbmc-am654.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/hbmc-am654.c b/drivers/mtd/hbmc-am654.c
index 98988a8e24d..1e71e91e0d1 100644
--- a/drivers/mtd/hbmc-am654.c
+++ b/drivers/mtd/hbmc-am654.c
@@ -71,7 +71,7 @@ static int am654_hbmc_probe(struct udevice *dev)
 	struct am654_hbmc_priv *priv = dev_get_priv(dev);
 	int ret;
 
-	priv->mmiobase = devfdt_remap_addr_index(dev, 1);
+	priv->mmiobase = dev_remap_addr_index(dev, 1);
 	if (dev_read_bool(dev, "mux-controls")) {
 		ret = am654_select_hbmc(dev);
 		if (ret) {
-- 
2.51.0

