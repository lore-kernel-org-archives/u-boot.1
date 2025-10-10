Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9821CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50E3C84286;
	Fri, 10 Oct 2025 13:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="U8xOaPGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC6DB8421E; Fri, 10 Oct 2025 13:58:58 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BED38421C
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VolGbmyiPORrj0H5O1YCK48PKh74JVmVhWQ/kRV3gft5rdEMKc/yMQZ5j/iEvzSKG3bxEcuS2u2g5O8oolaZOf2uKtA8Ft999Hh76KS+mmW5TJii5NZzaomaaQ1gdCdNQ+eSHwZGDDUs1uH8XTx8Zft4o4OEQ8BFQwYRwYKlU2bw1MiQn1w9w5bhiywKu4sQlFYiW8CqqJG5dxK/N9c6Px0Yi099nqO11gHKB1LzF9XgOXOkyAFwT5/k6OvhAos/Q4fWFoxJ0/U9UMu6QmrkUwzBTFfffdk/OYPjg3ApTU60CoxUbevzFJOJgJowvlsZ7RXrDgf5mjRRLcYJZZ/JDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTNIrZcz9nqK+/iGkLDq+uMwqO3B9+nw0JvZX/al3ec=;
 b=p3UPhBuH6pcwcf6rMErCSu1pAVDYoZ/n8vVq8puOqS91odyo7Vq9wfMmjtZrVHmsH7kdf7e2wmv4DCPa7lHFlf+Loc1e5NdzGkHxYsWrRU3ImzczzdFPGCXB36oDQzZ8um6o/fp7OaEBXgy0LPgJqrI/4/mSahvgc8InBArx+ftX1gT2uDCF5ARGIGp7e9gZ7t044IoTCjww10Gn8xnhqajxCwlqp3CQ5LoU+FcT5uvsOb11BRWl6BJfTsvGR7lqbO+ItA6RaF7K5Wb0HdmS7W6g++DfPIALSGdL47ZQIHksq9YccHsx0PjemzejSO0AV2uaYQim/WpQQrlp5oAgDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTNIrZcz9nqK+/iGkLDq+uMwqO3B9+nw0JvZX/al3ec=;
 b=U8xOaPGEgw6jkjq94Kx+KU/Yd21BGQtauyWpL+mUDrCQ9kyIzlJ32WwDd1tY3cGRORLOYx68qss8rS6acpm0RPf/affk9X1At7vghUySaaeN7ZJ5Y+OLRrD0ZWu9BCzrkDU5oyfCCB4XilZkS+Os9YnIjIfGGWdK6XiA9TA/EfevcfGJ27ICRuK9rMdYr92rIPaWO3G7si8+ty9z71uMGq2zhlvNSdQqO/hH3HXjFL4J7hMxYmF4s41NCxjaG/SncB97L/+MWQU1m4r6t7Uedzc8KaS1QnhrMENbWILfvtTkQWkWyIQS/sEc2aG4o4IKU7/hsGtBLI5ECeybOr7vGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5586.eurprd08.prod.outlook.com (2603:10a6:20b:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:58:55 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:58:55 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v7 16/24] mtd: spinand: Add read retry support
Date: Fri, 10 Oct 2025 14:58:17 +0300
Message-ID: <20251010115825.1531775-17-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d638aae-8d32-4213-ff4d-08de07f4637a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|1800799024|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vtHXH3z2AK0LT+BWsmEZ2jzJ5tqxgUlDn0QgRaGagH5oTLMiRpa522TrmUYh?=
 =?us-ascii?Q?+vXn2pcE23/biyTrEhXgqZm+ITd9NvFyQOrIv6PlRkVlFhhQJQERwXLTUYMw?=
 =?us-ascii?Q?x+a2rnh/Us2rgCpNbkny039GDnjClL5lNPy6HsDlzdULqeJppq3B+pYXPCUV?=
 =?us-ascii?Q?qWBod+3dTTxMw/T3LPcgYSVjYXTEh4ZA6JYaHWlwRXc7fFcDRGsKJ/xE0A9/?=
 =?us-ascii?Q?EKpuu9Z7IaChljj3sdzwDXlFJILneOvsWsI/xeuwz8xKwAjcrydXAme47zqf?=
 =?us-ascii?Q?MlU2GCvcDTpr2oxtt0rXtIz5v/HYa461UKjEuhjPVUatabLKQ/yH15/SJbsK?=
 =?us-ascii?Q?65E4hepT15p4LHoVf+kJLLc/eZAet3UBqNHJOmwSG13mqDkJ3iyoLrmMNQiy?=
 =?us-ascii?Q?SoIlt7Vyf3L2FGKazGGpFtTY7HbIe5p/9rQu8bC2xqe/pqT/w/ed5doblqsK?=
 =?us-ascii?Q?oXte6eIldwdnBLCn1NJPtL0Mw60BovyxuMb4qdZ3E+T3VlsMuDP4kyVNplnM?=
 =?us-ascii?Q?fKT9vB9uR3ty6fOVL1SCLuts4+ws4ngmb2avTCfiztQ+BSXtO7rwMcMIPMXs?=
 =?us-ascii?Q?nHQrsRb5nOpOFoZ7PFouxcyEiZ7GudAAqahdIxJzt5axM8SQJ0Ywuc9AuRYy?=
 =?us-ascii?Q?J/5wBcwwjmmdhU5Ej/LC13ofQNhCqaatK4uaHQa1hmGEZNP9J73WofhlWn26?=
 =?us-ascii?Q?b7Ib/Ob0PIts/0hEARHsE3aFl6j/dUjwG3ff7PbSjLwFvm9wgh6H5BPvTrR8?=
 =?us-ascii?Q?b7BUsw2Y5R3vVRiQ9R4uCNQ4B9d0qOgvU5sCks+XiwRIMHiJx8MqxF7nGZSS?=
 =?us-ascii?Q?FasKO8MkZ54XoVPagKYh9Xxz1UtZblXzp4niYDGzzrD2vh+r60dkHg3rUEDd?=
 =?us-ascii?Q?m2WQrF19M99wFUCsIF0KFWCcwocElZOF+tCQlO2ba0MatOgjt+PrDCM6xsij?=
 =?us-ascii?Q?i5J+JcHiU6Noc1Rb6FT926ciXxalLyoGOKm0otLN1DenKru2xM8Nje87eH1/?=
 =?us-ascii?Q?22Dvc/8YaQiOmWMMs7u7sr7Ja19f90E6lj7YNLPa4gvMV9xCGMkO9GXYk1vJ?=
 =?us-ascii?Q?LDE1WrLSQ5AE+xOv7fbMkAJrEFOzbDhtDtNXrC0Ampl9/zgsbVQakrVzpa6u?=
 =?us-ascii?Q?nW+1ydMiJ4rnyHppWXIv/TfCkvedVQr5iKOlfAnhfO8S8C98APkn0Dxoziak?=
 =?us-ascii?Q?0cliK/BKbv3c+MTJzGe5s2dOzEriiQFXpjCivDbUSiel7ILc1WnZ1A6qjNZB?=
 =?us-ascii?Q?ENL1YqVTmmHow6Ryo3BD3S2+F29vfd+ypTiBKvvjjIjpx6TX8+sa6uR/SzXX?=
 =?us-ascii?Q?/JpdJdgPb8w5A0etxGV/W4ppqVD66z8BN6ZNQJHx0D5YAwW0YM9roz7UPCrc?=
 =?us-ascii?Q?f6PRBPku7hZhyn4Iicnfk6wIR1On+1MuyJI9GL2L2tgpORrftYDeXB1S7OVd?=
 =?us-ascii?Q?dMBi72OP9vdPgfIWVmuN9dOgqJ3PqhavLs7f/JjgxgBzr5z1uJLXGjWMvbcG?=
 =?us-ascii?Q?7+ju1kgN84bZK6qoXTCvkFcWCE9KYoR9tzol2biuWRHMK74Mez+pEKzdLA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MVm5j5sN4ykZYQC8Wsmi4xh0HUL4cO4dpn6PG0iCNmMnATx9VbT3ucAFKlIq?=
 =?us-ascii?Q?xA0g1ah99AIx9EYAlN9lVc8PZfUybO9AY4bwyA+b4JgV8PBSl+P22pEhWIuW?=
 =?us-ascii?Q?FHh52QOOoCzacGfZAgZzHAOrXzQyy0mkmEgpBOAsbCAgahGp0EKdnCNa9zt4?=
 =?us-ascii?Q?JHQvAvprLc8xrI6OcOizHgpSiiRRX94UwWauTl3txKhry6jZHDc3KiLCZd5H?=
 =?us-ascii?Q?9INCM7O13xeiXpk4RDuHEG6TFxKa41mKXXs7ALjgFk5xxyvR/QZSjlcAnINb?=
 =?us-ascii?Q?hx6UGc0txV+kjEac067J/pVkkT5iL+22aKIyLn9Y/xCrKGEq0ly9FIkkE0M0?=
 =?us-ascii?Q?K2IFGnbfJ+Rhw3sSRpzAg3hmNM4iptUhWc1ROApk92oqsQ+0SRhyugT0PAKF?=
 =?us-ascii?Q?3D72FpF8KGenw/z0Ng662xd5L602ocAJV/y5KxXLuAMAiizqzpvy47o+advx?=
 =?us-ascii?Q?QbDjXShCUyaOVDllWstbQ/jGh3JKtmzxn5uPhIAxpavZLOH4bao12wlD1fOI?=
 =?us-ascii?Q?Ta4e9HyjuKpDDvyy4TQ1W+qOAT8U9mZRMJ+uhiEMYv9fa3krdvzQNMzy0+kt?=
 =?us-ascii?Q?9KtWu3gp+zaim+m5R/CmafCF2jIbgU1G6TieKl4gRp27VPYVMVTVIsJIvEml?=
 =?us-ascii?Q?Ug+HF+y9BITFwAR0yqj01QPtxWj/hsyT58btoSFrfPE4dHdzSr+n1J5XeLX5?=
 =?us-ascii?Q?sYI6PvQQk/fNjC2rYGYXg7e0l98HlCgMfK3SkEjZjcLnnDkFBwlitmHYeOAQ?=
 =?us-ascii?Q?R8lzN91gnRWuS0qUF9cHCqUKM7mp+Y9buLT/yykLXSO0kxbWhad6a9euYAXA?=
 =?us-ascii?Q?0YTijWcOJdr1tuCb+HWEE/+l4ZU5Gkv/EFfnTcROxijhvWYyAst0OKeGjaJe?=
 =?us-ascii?Q?j/t1f0ky+Cp7JPRznePwV6p364/ZMV5xOWFGLXx936kRxvvdshFQCduTPW92?=
 =?us-ascii?Q?T/13FWF4clAYYea7HWdQaAXjEJybfwt2iMLuGK6s9QDVJU+9uFH5wXy6v7j9?=
 =?us-ascii?Q?2d/s2IJLOhr20ww5GvpyOPUFy+WErIgltm5++hVbOZKaCrCuXUCLGWr5PHWC?=
 =?us-ascii?Q?qrJ/E6NyvreYPuE4rloeH9wamKqRvU8ZDOWHBo3u8EiyrdPO4PALiyMMJwvZ?=
 =?us-ascii?Q?N9xeXWIvOsYENF1KFJ1wjBZIsGdmROt/7Pe98XfPMP6hL6/pRPAFoFUxe8ac?=
 =?us-ascii?Q?ZoZvWI7RRV4mWJLu8b2TZOc9I0w+6Jc88+jygdbnhlrYMpABeOVpkvNu+Rh3?=
 =?us-ascii?Q?/yVVEm1MTqykNTG5j499Sgktg+GzLusSFrt8bOUEnLBlqI19QPuRY0nxTBd4?=
 =?us-ascii?Q?DhodS6otW3/265navaxV/gQjWNyhyoqBb98aNsw6XKvxgh7WEUkferJJYbut?=
 =?us-ascii?Q?3f6UYT8y0bAJMfKjgxPEjhfNOMU6WMK0T7vIlrlLukSEAMtMYriRs3qYi+IV?=
 =?us-ascii?Q?l/+b6fjI+gHpI1/zzxKeGBDC7N0vl1Kxv0rfDhEcOTl3S7FHXU6ylNLx69V8?=
 =?us-ascii?Q?aytIUt9SxIycGULndcZb84ZG+SQe/dmkZB/aNTF1e+QMKNRpO3Mn3gQeSo2t?=
 =?us-ascii?Q?PpN4djpNGQHq8lfbu0RaQ+4IoTxYFX27tpT3wWP3+TkPCHRTBUvvTnVSP1zC?=
 =?us-ascii?Q?HiUwikX5GdhZ8LoJadkLF2o=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d638aae-8d32-4213-ff4d-08de07f4637a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:58:55.7351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nUbbsEbqWeA6N4GBkSKl1xM+4UgDv6ZtIM/HUpavQsC1jMpO3RIAxu4qDf3kaUWlW7xGATnuIeHeCEygdVwXaGPp2+dknEkWZKTvKrabJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5586
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

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

When the host ECC fails to correct the data error of NAND device,
there's a special read for data recovery method which can be setup
by the host for the next read. There are several retry levels that
can be attempted until the lost data is recovered or definitely
assumed lost.

This is the port of linux commit
f2cb43c98010 (mtd: spinand: Add read retry support)

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 35 +++++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h | 15 +++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index d4777ec7c8f..33d0c27f788 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -687,11 +687,15 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct mtd_ecc_stats old_stats;
 	struct nand_io_iter iter;
 	bool disable_ecc = false;
 	bool ecc_failed = false;
+	unsigned int retry_mode = 0;
 	int ret;
 
+	old_stats = mtd->ecc_stats;
+
 	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
 		disable_ecc = true;
 
@@ -704,18 +708,43 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
 		if (ret)
 			break;
 
+read_retry:
 		ret = spinand_read_page(spinand, &iter.req);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
-		if (ret == -EBADMSG)
+		if (ret == -EBADMSG && spinand->set_read_retry) {
+			if (spinand->read_retries && (++retry_mode <= spinand->read_retries)) {
+				ret = spinand->set_read_retry(spinand, retry_mode);
+				if (ret < 0) {
+					spinand->set_read_retry(spinand, 0);
+					return ret;
+				}
+
+				/* Reset ecc_stats; retry */
+				mtd->ecc_stats = old_stats;
+				goto read_retry;
+			} else {
+				/* No more retry modes; real failure */
+				ecc_failed = true;
+			}
+		} else if (ret == -EBADMSG) {
 			ecc_failed = true;
-		else
+		} else {
 			*max_bitflips = max_t(unsigned int, *max_bitflips, ret);
+		}
 
 		ret = 0;
 		ops->retlen += iter.req.datalen;
 		ops->oobretlen += iter.req.ooblen;
+
+		/* Reset to retry mode 0 */
+		if (retry_mode) {
+			retry_mode = 0;
+			ret = spinand->set_read_retry(spinand, retry_mode);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	if (ecc_failed && !ret)
@@ -1309,6 +1338,8 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
 		spinand->set_cont_read = table[i].set_cont_read;
+		spinand->read_retries = table[i].read_retries;
+		spinand->set_read_retry = table[i].set_read_retry;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.read_cache);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 2f8212e4037..44c616a4acf 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -337,6 +337,8 @@ struct spinand_ecc_info {
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
  * @set_cont_read: enable/disable continuous cached reads
+ * @read_retries: the number of read retry modes supported
+ * @set_read_retry: enable/disable read retry for data recovery
  *
  * Each SPI NAND manufacturer driver should have a spinand_info table
  * describing all the chips supported by the driver.
@@ -357,6 +359,9 @@ struct spinand_info {
 			     unsigned int target);
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
+	unsigned int read_retries;
+	int (*set_read_retry)(struct spinand_device *spinand,
+			     unsigned int read_retry);
 };
 
 #define SPINAND_ID(__method, ...)					\
@@ -385,6 +390,10 @@ struct spinand_info {
 #define SPINAND_CONT_READ(__set_cont_read)				\
 	.set_cont_read = __set_cont_read,
 
+#define SPINAND_READ_RETRY(__read_retries, __set_read_retry)		\
+	.read_retries = __read_retries,					\
+	.set_read_retry = __set_read_retry
+
 #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
 		     __flags, ...)					\
 	{								\
@@ -435,6 +444,8 @@ struct spinand_dirmap {
  *		actually relevant to enable this feature.
  * @set_cont_read: Enable/disable the continuous read feature
  * @priv: manufacturer private data
+ * @read_retries: the number of read retry modes supported
+ * @set_read_retry: Enable/disable the read retry feature
  * @last_wait_status: status of the last wait operation that will be used in case
  *		      ->get_status() is not populated by the spinand device.
  */
@@ -475,6 +486,10 @@ struct spinand_device {
 	bool cont_read_possible;
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
+
+	unsigned int read_retries;
+	int (*set_read_retry)(struct spinand_device *spinand,
+			     unsigned int retry_mode);
 };
 
 /**
-- 
2.51.0

