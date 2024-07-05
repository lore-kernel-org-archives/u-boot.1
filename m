Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912CAC30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 14:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E05C88961;
	Fri,  5 Jul 2024 16:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="CQXdnxHK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FD07889BC; Fri,  5 Jul 2024 16:25:40 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E402388961
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 16:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFAKWFjaBt7/wRZQTzvbPBMM6RQJz36fZZS1G6NBiZuL3FFDcsZkPIJn8ziZSUcSM6s5Q8ZW+t/g3N1el8plXtxc2vty4L9mz4ST6wWloOUobG244deTMfWvwQeJq43IVtWBnbQ8znN3SIMOcenr/okGrN7Uu637bC4CTvqwGnlrQLo17XjpxD/IkffigWG7ELSL5H2ZuuBphtGA6n+E3UoxaV8yn8ueXmF30BYgliUweJcZztah1iX8wX+d6M3e2sCVPN12Vkr5ImosCl66jkaiP9LP5Y6F1q0F5CWeS3EARzTsM1aLd7yQurHvRN2pL5qr5M56czZfSm2QLT30uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFQdhcnDi/LR8asqg0oC/YzxLOFsbOfjj9ES0h5JgVE=;
 b=gkmEfbZox/lMUuVLadiHgVOKAAqni3BTo6IKmkOZt/zMY6yRwFxjkl7cqrCxaZNiOS/hRrDO21dyug90K628XqkrNfFxj27X/d7Jx2wLjqxndAq3k2/FtB8AlTPD95J20C6otOwcFGWd+3Q6e2XpHFsT+KiBpfP7LWtHIRy4tHaPo0J/pkKO1k5TFKQUF1Q2Olw0RY+3P4ui12fcS+8HNnH6D/pvIhMfNbxOKhSyaZTT8hXgjbaUickZdhQpqCe5ioXlFeKm0SybGBwms674AFTf6HUqkQ5yJc0Ul45O/0KTZs6o4LG1n8ob6rCuS4sTicBerts/x6s1f4YdtZAXfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFQdhcnDi/LR8asqg0oC/YzxLOFsbOfjj9ES0h5JgVE=;
 b=CQXdnxHKYeqTn91wQ6QmBsEng9eIFWjvNQvv5uk9eTseqlPDy5Y70TLx4jaMPI9i+Nb2ixZFxksnA9zVb/9vTNHa2jCb0PHgcNoEOETFICmXZEdPv/IRQQkDfjBc4/DfWeYEalBr4UUqEXVeKCoCi3QIafaoP5VlTddr1jECatKSvFZ9glyUVi5fs0Pk1VOKmYp5AmRYDRQoPC3MQKsGNyi5d9ptLQq9GDq28Qn23zArnKebtbgJ1ULbNCM8ZWHQQ3v3nYSIN25ohRLfRsaV1OlxDODq+76TOUBYGbH93L5oRq+7zxWppne3RltZ01YX2vJ7h25U3QCInHxkJpB5dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9015.eurprd08.prod.outlook.com (2603:10a6:102:32f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 14:25:35 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 14:25:34 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Bruce Suen <bruce_suen@163.com>, Chuanhong Guo <gch981213@gmail.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 7/7] mtd: spinand: add Winbond W25N04KV flash support
Date: Fri,  5 Jul 2024 18:25:00 +0400
Message-Id: <20240705142500.2272803-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705142500.2272803-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240705142500.2272803-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: ad737310-2b84-453d-ff85-08dc9cfe5536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LNGHniaRl8ffg23iinBqGhgemZZZZpx/VeuCRRWVn6zWCx0HV7OeHlRGsE1O?=
 =?us-ascii?Q?94+bZEDEWsgW53Zp0Saf36/tI1BkGHPBT10b0Rp7n+3KlLvwKrXvSoU3Ee70?=
 =?us-ascii?Q?6fxDFjlbTHQLY49EG9err7AH1sa6VISq/xrLvKVh5kVdmlv+XXHo0SRxkIVh?=
 =?us-ascii?Q?1cRhijNyR3SnXNRcFqPRwA8qvfubJZBnCWjIqiveYn/1L5mQ4CEbU/IhLyD9?=
 =?us-ascii?Q?3XC6eK10P7uriKTjUe+feh4gZD/xMeK0ikZ9msqT239tVS14rZUwmXcMsV+m?=
 =?us-ascii?Q?hxTurWFE8MktjtxBeMDqPwRVnBe8biQGBlUCRB0Pt+JYLbc3rj3M8PUnHKYO?=
 =?us-ascii?Q?88laDgpeMhEcJewu+0QwfQqUe3lfr5HRsE4YDsPtoAYa/0GOecxJ+pkNmcMb?=
 =?us-ascii?Q?u6ZGMWViGA6628Y04y+ju7qEBLiB1y6mIhok+/BTk8zwFnYeEbpInXpnc3bZ?=
 =?us-ascii?Q?QLWTTG9wfj/OOZJtnv9j1o+RCXTXVIZLTROaOMXfMfJWIkpI3INe7/VP/IjO?=
 =?us-ascii?Q?u3CUgkJrFjT96n0UKgWKSSGoJGoVS0GAEv4m5+bi3ob/tCxZFTBgL4jvY8/f?=
 =?us-ascii?Q?dUhpmwnCeb+nneWz6kzxzauwHEgnhw2TAvSX0gJXwcfhLmCTginMZnTfI8q9?=
 =?us-ascii?Q?HfkEskb6YvBZeG9KbgvUQ7gkiXHSq3a4ylhCHT9YJqVsaY2Ev+8UebJHlJPO?=
 =?us-ascii?Q?a5sqwguY3No+lioDmyarMva3Ck5qXH8qgtC17S/OZa3B73exzfYE6ej/1QhN?=
 =?us-ascii?Q?B/3c72qTf0G0Z/Cd+xeMl78bkRCNI0+WFGmvOMvXUq1Ri2SO4Q+CtEbMfCAL?=
 =?us-ascii?Q?Tsggf7EOQQ3myb6zvd8wXjOxU7IcW2q78zv79TMvIdW6uMd9fWXOgMHe0UOR?=
 =?us-ascii?Q?QnT/ZKiy98zlAy5GHkj70Rlnp1gsWD/Dn/+aM8+d8nwSiySPZLY23726j52F?=
 =?us-ascii?Q?OwWMlafhfBgBipMfU1QejJ1aFC0b3W/yTfU11NmPujZOcAToa20ziFLrvyUV?=
 =?us-ascii?Q?pWWltlM5DCjEkPv1MqQCRI/eQlgZIec/P+jhpxWSGZQ7cgUb2eaYoUw6fY34?=
 =?us-ascii?Q?J5c539MNhbz4QlX571ybwWok0GOOM+uAQDDlLDHzejMGsBQkJ7sbRlgoYC0K?=
 =?us-ascii?Q?boo0744KcqolmApLliqTiGcKoRjSOHOs6YyhVTH9ZV7aYlW0RQNqTzNg+RLl?=
 =?us-ascii?Q?zSJIgyMV6+1zAcJ4HgrsmerCTr9hkHxZbJMaZpFk9p07yB+yyEJUiMJ1qWBG?=
 =?us-ascii?Q?/+qPZA3OgkuJFBmJWy9F1A/5ZOdXjehB5Mu1ub/5z2IT0K28hcx78XEh9Cb7?=
 =?us-ascii?Q?yCm7aXRCMDryne+RhqWGng8P1/MsqJ305XCmdpiRbcu/t5QJona7RK7RHLck?=
 =?us-ascii?Q?Jc7A5Tvv785LkvcJ+qT+d0EGOHBaTX0Kz8rirUQkfNplbAATLglcCzDiKQrr?=
 =?us-ascii?Q?Cg5ahTUSgZY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?trQxuAsMcSmJrqBu044eYgWZI86V6AMiD+aq6BfLNEiIbhtMrGIeTDzErBmW?=
 =?us-ascii?Q?EdXisp0TjrloSreCnCH/qYFmuSkEXKOobtC7fDo1SZJqKprLganjm6SauFQI?=
 =?us-ascii?Q?PirbWYjY2oVHn1WqZCGS7hKUFqO0tqbEABijiRVb4Y0GWeSkdYMeyS7VOUBq?=
 =?us-ascii?Q?e2TFDhfg8JPbsMLI3dhWDlyVfzFpEy2AADu1pqBxzVKOFkHKEIOaT44K2rJ9?=
 =?us-ascii?Q?uFrii5e1hRhuuQjR3AxVYhoTEa7/RIPO9QeZk+BIiQjpxgEJA80nuD5riWCf?=
 =?us-ascii?Q?JvO3DOkQ4RwRqv96pJFuhy36dZ3gvfejd9BDstoXb8wGGW4eu3hCfqyoJ+oq?=
 =?us-ascii?Q?KKaK4/cmcQeON09ODsXGxX8chr1sk2L+j5xHE0GZyDmTFTOSY8WqNmXsrBVZ?=
 =?us-ascii?Q?vZQ0FfQGkuO1qXyyZzrxDgvZNVmRvepZ0hKNtWwRu5WViPmPkhqlkKJLAgT4?=
 =?us-ascii?Q?ocTw51lz6kuJgKwDmVpBF8pPJFSUL9XkKwh4owBYl7fasaafk5HrhxwgV6LL?=
 =?us-ascii?Q?60OWkQzCH0+Tkz1iHXuvvXdIMUG6HZccdAfb/UYGEki5RKujb/MQhDlvF7LH?=
 =?us-ascii?Q?FWtLhlgTh78vHFUS304czQ6bbGmEtjuYMyfgKPeyLr44NT1zbkdYIUdNNsaO?=
 =?us-ascii?Q?KPkBvIooJblBlezgNvCNN0KQsc5JPSpMLxuYtQUSI9xyxtcmbKP3jTSZ5FJQ?=
 =?us-ascii?Q?TZnwi7PpUrqB/QjvC1vgKI+9F8VB1QeR/fvWck8W6P2buvlrVFKLzB4/Q5Kk?=
 =?us-ascii?Q?XH4YMrFl1Hj4MuuOpYb6rXrrxuwMDoz/Ur4RZYq8et99J3XCuTE4adaXG+0c?=
 =?us-ascii?Q?O+UzyCHiRuqHn9iHw6bpeAXT2ewobDIQokUbXdK4GqJF1NAv2pzJVo0iw/QU?=
 =?us-ascii?Q?aAUQVEMCu86vx3i5rpQtkM5WTkdJJUBttcBwI3vvF8ypeyt1QKRaqAftMBBz?=
 =?us-ascii?Q?mOe5ur1ODUcoBr++JgEksbvpUcWhP1ilTJMbZ4GJBmbuRGG9mgoUO0hWl1d8?=
 =?us-ascii?Q?bXcdfpmq7iN676dEvHTMG+TZN8QFbZhsOmzJCiI4OTB9Jgb5VS+4//ChsNpU?=
 =?us-ascii?Q?nBkb5H3zLa7crk18IiTd9KTKB83Q8eXJ51whLc3W1nRia8ikhiQHi26Wq+3u?=
 =?us-ascii?Q?9VV32Mc7yV2z6eyZJV9x4NoR8Cvdx0/8Extubm+e3H7rJUIELIUToWCuVj9T?=
 =?us-ascii?Q?yCBFFgbvkEhq8Mdd+Np3z7brfwehuWHK2+vCduTfNsDiD80JxGZR3a8PMWP2?=
 =?us-ascii?Q?ia33naV3vGTy1G6fJ+XtERCwT7D2LJiYbKUamgVzKMLMoKjnIkNk6pkn1T0p?=
 =?us-ascii?Q?dFN5b2EJjSksXMtHHxmQSPhkEg8mOQK7W+Lq3Rj192+GPzPJQ9DeJNvIWqUB?=
 =?us-ascii?Q?c1zFqsNbdu9MUSScaONvjc3byOboDjm7O7153aFWq/kanE7MyqUSKF29y7sv?=
 =?us-ascii?Q?kG4dHVKF41L+EKwOF5ZugArJX7/+elKaN8P20T6l+nZrZ/SK8f9bFkVuBgL+?=
 =?us-ascii?Q?f+2YABa0D+WrsEzdw/uvBYITomawNAlWIOEfH+3eRrHTyJ6LCJbQ1oDCHmh+?=
 =?us-ascii?Q?t+ZYZIP2IfOqVfxh4uo7RZlSKlGpjXkURQwHTKLMeollygw5JbZSZhZGGHLO?=
 =?us-ascii?Q?zOE1FqwfF6mfsQRlE1Rvw7c=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ad737310-2b84-453d-ff85-08dc9cfe5536
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 14:25:34.6886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkjpoKfr3pMgb9UdlsxjTxn2ckU18UXy8Nz0SOoLePfOhYEx+TmYDUJ6mEqEs/csmg08bmitrWHjqM2rix2bUFnILR0R/4kiqVHP9aY4lLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9015
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

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/winbond.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 5fe35e35ed5..f38ae95c570 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -172,6 +172,15 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W25N04KV",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x23),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
 };
 
 static int winbond_spinand_init(struct spinand_device *spinand)
-- 
2.39.2

