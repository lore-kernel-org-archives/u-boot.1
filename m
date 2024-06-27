Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A754C3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:21:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 875928857E;
	Thu, 27 Jun 2024 13:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="yvsznJzM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0B018852A; Thu, 27 Jun 2024 13:20:25 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::727])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA147885B5
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbG6thCKZwx8h40Hk2jHljesnkY5P/DSQ8fsDGuHKXvxVcI+1JQln2sP3RoAMhT6ZDDlrgtHV7tvAl9biIE5/SF76bETrzsvm/06VpsxMx6lFu07Fv1K8Sfzc0yvC96aVAJfOlSE0TgXEQgO9dNrCwCOU4GbQv9tMzPkGXReULFhB7UOTwjX1oTR2M4pC3UF6/xbjaInjgj1nXI/bDCjpWWx5b/XM3Yd1uV8Mp1xTEjsxsuhUQNiCce6YfCEWNASCu1UBUv/VmqAQPGLtBH33vQNdSqv8aEtgvhHTr0JpLtdt5XGbeZUoQi+KoaalV5n3xCjTpBXg9bOsTeXt4TlAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFLRipPIIa5rd7s0ZapIvOyp8CbKJNuM9UY9zwhLcbI=;
 b=RksErTi9OME5dJs77YM1oWIu2OUbzirk4wUN/Je9I9hJMRVTCiLqufVJF2po0EAMVZvl71lCMAfbjC5x/0KtTBh+nS6UP5AtlVVBQMlE6iDLOqWTI6UJ0Qu1SY2KNtVxKEK/Ya5AUE47Xm3g9xh/1UFJgE5tjTybs27OVKFiHt43cOa96hUYxRmwERhSfa8DZPAVv6jxYI7DLeLoW4pjaD98vKwKarf+6v5oKV2/ayUBhPWSRhpYEsnhTxckbPtMa/7vi/0T1ZGx35enbALVmzdMabJGADwv2hRy0Bq2NEVSDEJr5L9iPWvNmYpjN0AtHvixQazBaIlOxeFAxsL0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFLRipPIIa5rd7s0ZapIvOyp8CbKJNuM9UY9zwhLcbI=;
 b=yvsznJzMVJ/B35S0gex6UWt3Z87iNjaAtcUdVwjoEXrN7c1SBoHLh60NLTDJRWe74rl7Jr7fYW53BhHppSEb67IrrQ4ke6oBPF53UzPAKG/7FNfr7WqL2H2+/8YXw7P71zGoUKX9ClQ0sD/K8bJMzNe380qxXea6AlEVzNQ+TowGm3qrLjoXs5pl62gtImN2qbawKk0ULpmvp9COuLsD60mjYMvAEbfds/OpAkjO4F5hEi56Ie8u0Tg+51uk4Ek8MqmH4cPvqabqI5MbIuRqkDzRcR5WPWnzK5LB+cahxiS3FjJz/FvqwZr5uGCq9bRKOMGjGqCif7xnihOvxcsRxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB8970.eurprd08.prod.outlook.com (2603:10a6:20b:5b3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:20:22 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:20:22 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Chuanhong Guo <gch981213@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, u-boot@lists.denx.de
Subject: [PATCH 7/7] mtd: spinand: add Winbond W25N04KV flash support
Date: Thu, 27 Jun 2024 14:20:05 +0300
Message-ID: <20240627112005.99375-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627112005.99375-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240627112005.99375-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0000FA79.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:4:0:6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: bd83efbd-b20a-422a-31d7-08dc969b218b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nsmLWVNJ2csyAq4Sgeyjy42ii5veT6VDUzmzycDp3EOLahd2U8N6MOHr61Pd?=
 =?us-ascii?Q?agre0bcZKcF8IWQyUXaorAQe/iIH5tC+SiAynrBcKpYTQpEm4fU9kAbmT5QP?=
 =?us-ascii?Q?ok1nbAjTM/manSK9U/RTVfO68LizmJKcjNHap5ZbacNsloRGacxLuxxhikzI?=
 =?us-ascii?Q?UGfH3Vmct+I0pGxIYTC7ZagsGKBghrLu0QHGDjQqCAVy7BntwF+ZR/JmDB2m?=
 =?us-ascii?Q?1oPFV6wmOpWk4Y4pRC/yL1syVSfO6V4xF/Qw5+B5lNn2sxdaEYG1zMqN5+bf?=
 =?us-ascii?Q?m4iMHnO1JXSmRCtqeLNsrn79/Rz/uLb1k+BgPqGzQPku27p3XuhvwK1uJhtO?=
 =?us-ascii?Q?Zwbl+NPbzdfGbey66BaqnnslzlHWUuhdwuJFfhEoxunGf/6GylZ2Yullsffp?=
 =?us-ascii?Q?V3ZlNsIeW/EI+AWAcQFu/af7bfVEd5pLbLFMUbiwKVqdxm2MaPdvnLuSOc7q?=
 =?us-ascii?Q?rKVv5dhGQZW6xS/ICnFQojC0j54Y6zbN4yHvcm06gHEE+xf3fTyL8ZALMriY?=
 =?us-ascii?Q?QIlsr75H3d67zEM+jRWcO5Z5nGtGSJ+pALwjePw0ub71d8kR7rKlr3poCixU?=
 =?us-ascii?Q?9StISrbo+pfYsbX4/wKaTKcblmEVDU1J7fTzPxxPHoqORTwCWuKpfOY5CraO?=
 =?us-ascii?Q?7WVOj7fgikI7Gsv6kZE3YJGqJ7YxFW8Z2L2iB+ovIp1yvmkS+eHgvsJaiT5c?=
 =?us-ascii?Q?lQleR21s4ttkJ5PgQFSd/QQbxMtRIWTgfMoNkpg4uZ11w+dwyf5uXbhkg7tb?=
 =?us-ascii?Q?xoPIENM2txPzAwzSUR0PeVX2zTnjI8h3xp+aGn6B8CjScW57teJ1pMBI/6s1?=
 =?us-ascii?Q?/rtdBt0K0n/HsPsk4eT/OUc5QPF07IJmY+IZisTOa4XGlUST6g3sS5b9WMla?=
 =?us-ascii?Q?CDyMFbPr8vPvCRxXY51hf3CkH+4TgMHsViFd4xM2CZLA7Oc7lns8w6hTAwc3?=
 =?us-ascii?Q?r3yZYNAFLAXZPgZdSY7xBz83L5FDWOU3pDA9nfSTzkaunR6dCOs4WFFyhdzg?=
 =?us-ascii?Q?gKsgEoEwGCBWl8vhcIimFJIHGwIOOTzPV7bIwEkC35QlfSC4bBgYddawshwb?=
 =?us-ascii?Q?6ZwGSXM8PIukFpKVupHcJu9plhw5NTA+RYQh/GXVK1yTECGn/8gH2cyR3+cM?=
 =?us-ascii?Q?ypLgCtF+Rbv3pR1YeePVQ/cvAT+HoCofhwic4m7xDjgug7xrhKjjQLTCx+DF?=
 =?us-ascii?Q?43aIgZO7sJ+DcZzl0mVkrQm2jM7kIMc+2/x+hKxKJ1mWWJ7fcokaoPSU8j4R?=
 =?us-ascii?Q?blOtSoGMGFF0DOLUWQKZx6vgvDxPVrabiXlq+En1esGsRRos609g9HdX0naU?=
 =?us-ascii?Q?0Ui5bS2jJ/4eBicuw4YdYgLyYPMWBHLZm/0Be0kPCkscZ5r9+h+DNKQB6TF0?=
 =?us-ascii?Q?isdKJ91Ss3AvIp6+6WxGWgkkLIedwnV1MvzQ5iXs95zC69l7AQsn7F6VRven?=
 =?us-ascii?Q?KQpW3fF0Stc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NyKhh21oWaEXA98+P/mBLxDj2sTzqzSj5CfrhBieMCm2+O7hrdnvtojuY+25?=
 =?us-ascii?Q?POn+QniFp1y5PsRMGnBW2d18VJ3UGIJItphW5zypcq/8/m1doGLvUC+DYJYp?=
 =?us-ascii?Q?0kHgK9xQQNZ7/5b++oCuLnJXL36ZuoLIwwK1HxMSEJaH1YD0wN3QIQyFU8hB?=
 =?us-ascii?Q?6zcD21wUAhzfX+MeQutwA07PzdMLqix1ho88qtdCJ4LuPerE6by+2ms+ovPY?=
 =?us-ascii?Q?44lSmrJhrw0UgF7MNM8FFgquw9SDmAMXAcEmGORJ8q9azbhR3Q4rxtN+xo6r?=
 =?us-ascii?Q?oEwdezOZcT4bo0UFN+Doun8XtFydVE1cdgH6U3BWtAcukTEjB4lsXdnlSWLD?=
 =?us-ascii?Q?tjYSdtZOQpzcdmFj5ukFEHtVadBrSOwQXo+YvK3uE4qnMESfafAaYrj8gTLL?=
 =?us-ascii?Q?KovZChKqrV0V6sUfm7SQiyk0pK32+wYuaB4BvahZK0ZayWbkq7q4hPG4Qeep?=
 =?us-ascii?Q?7FeMPN0asZ+Ahbj5d+TNvzPXFk8zA0A5RpgO+svIdc/+d2tQMFTVsF1t4eLy?=
 =?us-ascii?Q?jx+6dP+Nwfsc+H8q59wcyyECoYuM9y5mKSVWWTaq3I2oRhc5B6swezh9Qkdj?=
 =?us-ascii?Q?/M+EXRMYRj2kLgeGHwnf6hxt3ZBuwEEVZUzaM7yYKes/uOM0uwpLK6NUTKhv?=
 =?us-ascii?Q?VAyY93RLKe9BKOQjZIq2dAeuhwnpknwtmkNOPz4qMI6SCqbMHKsWvGDmWXWz?=
 =?us-ascii?Q?MAjk8He0jZpRO/vw1kHE5Spjd2qY1fdoqetaUB+/jLxVghHt6FepNvO7a+Gz?=
 =?us-ascii?Q?vd3hNtRf7t0yjDS3grlRfS+MskcpNeUdyEEDiIm4yjFPdS/W+2Sgdni54t6w?=
 =?us-ascii?Q?MCxR/y8hRbuTkMJ0avdsNgjp7e68L9lMH2WUmLf7ts56PLYjvBOTp19iCwW7?=
 =?us-ascii?Q?KMo9jx4mkqTvJqTiOskSEkoT85UvGWqc/VQHNqnlwUqrI9+rakJ2heP7DPgl?=
 =?us-ascii?Q?S4j1xcdu+hHTRddNouuPFfZsFCgJ2QGe7LOG5lirWJmZLsLnmKCSiMP3A9uV?=
 =?us-ascii?Q?TZJtnHKY7+Nri+VgFgRux8lxl2L+E4CEMe3VkWCCvwefbhL8GJlwFpNTQX/T?=
 =?us-ascii?Q?d9pdBbnJLZD6PKDXpX9hQbrBC89PPtaposNvIvM4Xhz/spoqtxBCEgBUhgaz?=
 =?us-ascii?Q?DnDtnLvsSNoJ+aePxtePTSsggcczeoEQCg214guHdoqw4+VN3HtmxvhlHMbZ?=
 =?us-ascii?Q?2xjAfzFOMxHembBL5D2p/0oJY/fiyO1hKh163S9Sdx5n8YzD/7Natc0B8nIz?=
 =?us-ascii?Q?A0Zab87j8pUEdU1k9k6sQDCbGEasn4VcxQQbLqIQU1Hh10JHTs6VI8ZL6HGB?=
 =?us-ascii?Q?yAytQWPrYr5+SK7jR8GqdnI32HaZBx1j0RK/U9POZ23PRmSC1uwj4ScfNpVW?=
 =?us-ascii?Q?Qx4tmrK3Jgvebomv0xqgQXp6USxbYTR/w1xcKZnmt1G4h6Cy+d7Sf6FolAMF?=
 =?us-ascii?Q?b52JG2/EGsg/lMrMM4u5993Z2D3FMyN+No5xbbumXJ14V33DgcklkTJlWuAX?=
 =?us-ascii?Q?GVcKr9Hz91YC/YQDG9iW/3ruyaoOtVCa6mhpyiCFOB6RcC6ltF+bzmR76nyq?=
 =?us-ascii?Q?rQuK2EubraZWwIjQ9OcPbsab7IPCg0+Fr31NYac/5EnT9N5qAJK9d+MYso+Y?=
 =?us-ascii?Q?/UjJ45eaX6Yjv/hn9CACXo0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bd83efbd-b20a-422a-31d7-08dc969b218b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:20:20.8419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5oxM8dnxnp0h5dwBq2UoOtn+ikwjefsrFpfDp/Bg0jkYwGPpfo2BiUSCMGq107DRQKw0ET6ngDktIQJ0pwjqnFW5mEGNFze+furYU91KHXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8970
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
2.43.0

