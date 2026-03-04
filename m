Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D00EDEC04
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 04:22:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6A6A83F8F;
	Wed,  4 Mar 2026 05:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="m3u26oyU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1399A83F7D; Wed,  4 Mar 2026 04:25:31 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C17083E7F
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 04:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0+m7WGdNL8w3OQmAEm3wWR8ck/C4Ljy5n1TONUQBolFWvlPyMJcwsVrWNwOX8VxQA8fH1wj2Da4BaUVn/52PLxhB4i+U1vmLvCP7RIiyNPVW7/EtEuZuZID6D0D7jgFlELni+aEsemyS1ei2YsrrSaUY5Nl6J41oquYBaflczq8S745sbzL4gNw5cgp++J12XSx+Bbi3GVsSl0vwlTTFLIDxXpM0v0Iw1PtXLi79b/lgihcBbihnxAB3RWgn+N2YBNft+/7SbwT4zKbeSCSdbeKKWk6+p9IJGPtb4iX/cIVf6B3gyE3xalNvF7hSb2a0lUBckMl/L3xyMs+rp9SGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOUk/rmyyVMFjOJwrEvWGPyBPmjbaKPCKUdA7EgXD28=;
 b=JMTabrPpelOT9CKjwqj37YQtbS/LRQNPv7gGLPJ4eKke42LHCiCIzUMXTd3jNPcgsUEpyvhZZk0A8pZD10MSDO9JYvS3cynGfqXkU/csWHil4vVOMLO7e9ktljwovAXQJcQC0ys6NZUIKZE20EOQc2xm6U8MOcqqHcwSXXT400VbjMc49D9XzTEXCdzJqcmubq09WdqSC5jovUHAlivSsAdl+sHy8BYxfyHcbCupG2z2xkZ2LtYAt6LSTZiYZ+fPjt75jUY4Sh3xNDmf87frkfWfdHt1zRcgcuvYLBA3h0d1NbUbiQVFqP1jo1VbWGKW/jKTOTWokUPsVKiuiaZNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOUk/rmyyVMFjOJwrEvWGPyBPmjbaKPCKUdA7EgXD28=;
 b=m3u26oyUcQzSBjZPB827qCzBhw1WwHMb4kMe8tY+qE3pSegXNZ7VxB49n0n3/QD7bBASExQ71S7ZZ1BmxUc3IbbslXHPNfCUv9X5chVbDPjWdont8RWjW3JRdHk2epmU7o3H6eDouS7Mfgoks/27LcqXcjFB95+u8IJEXlFDaU/zkCdyQhoCuNFLg88MFadBU54YuxV9CtS1Gzl9H12JkX4UbcRHk9b6uAz9dzbQIQeup2YwpC0dY6ZEY/f59PbjNx5O3n50Yr1vF7o8Cu/0O5BWkLlOehRQjciV4lec1HYC/XUQF2X2c20oIHQ9v8uTphrYeJIBf6GXur7n2fBjjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH0PR03MB6605.namprd03.prod.outlook.com (2603:10b6:510:b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 03:25:25 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 03:25:25 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NAND
 dependencies
Date: Wed,  4 Mar 2026 11:24:40 +0800
Message-ID: <20260304032441.31558-2-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260304032441.31558-1-dinesh.maniyam@altera.com>
References: <20260304032441.31558-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0127.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::12) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH0PR03MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: de119899-858c-45c2-1685-08de799dacff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: DZlCvixbyBEs0PemGjvvjoS+P2WWYbj0Im3WuMPQlpSQHJ5PuWheajD9GoEq/XuzSnE0PK9Z0pppovfBCnclWKPid3lKb47uSsmc6BG0gaF+E4isQ6p4Hjcz6mP81EGWi7hB+joisMUKxcq/oGBFrrooazZHhnk0Xt0WceEAY4mtwpZMmX+B31w3g7BfgR4cRx3cNbJx595oPnY0R0DmXW9MVNvnk+1wW6PonVK8oXrnB47dpBtlJKU2yheBshbwkZoKJcgVT5D2hdoBPRoZrgNEDlvWorh5GW45ZPkDCI9x1HDmyzInO8x3MTD7z94UaTA2/uaA8t/xwYzUfe+qBAj+5VZS1g3Vj33+ISL59JiWI9oofEIJPqQNXMmhsJn9mI4VvW7/ORYPngAYSXoNFg3Ca512ypTkY8ut2Auq8dBU95OsOC79wOoHjtp2SBGs31c3+dBAocqvC+SZjh0cfUE9XnhqvNDiPKxC5eLGD/ffyQsyt4QJ3taRBC1ICjKk2Ga2q675SHyEBjURZQ67G3UBNgM461uODzwDZoif8agrjHmciDuI+O+pljOiqJ/+NAHaOUj6DNaK0fNE+dJ5f8nsIzuUASUImGHNj8XD5v1wG4VapxBAQekTkO7h2h8OrhbXPhdCeHSgiy/rvgJ/I7NZc00xZDYELsaXYPVSSYhNrHgXQcmd0Xq0MwE6VdlkXt2o/6JFSeJC4NhW33AH3Ax1DDNJzypgSIGMnRFH3Zw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LKpJDMNSVH1rzhWoGfB3vbEXyrUTnAp9zByUUpCFNLt09iXn35gBIRL+knvq?=
 =?us-ascii?Q?/mUC8ML6vx1s3vBDEK50TYUb1jdUdH1ZzxnECFN7gCm+pAIqgH1Y1mztAPo6?=
 =?us-ascii?Q?X6MTXU2ES4JzBGw2PdlY3xBTdCtHQFO3VT77uYbLrk1FC23L9cl/7P6A7pEc?=
 =?us-ascii?Q?FCbTdMSpetGSRZI3NeQoapI8mO2MPmMHhz3V8cbzMBOn0+0ePywtlUWdp2JG?=
 =?us-ascii?Q?0iOlgtCd8YAoSwVqWFMfSNqYZcsyQi3X+bXQtdUiDGZjLmeHoFf1BzDo+g/K?=
 =?us-ascii?Q?5bYNKepxZmlSgA4E9oDrdSUgYb2+nwOY/Bo3Hhq8sLP4WVLPUzNciS+mAiQu?=
 =?us-ascii?Q?AcjzQ4snKqjgc+8SQLQkJVrQjKrwnaNUpvQxtDFKV2jFPo+UQru/R8ksooTu?=
 =?us-ascii?Q?Ijxn0gBYiB4eOwr11bYwVNuwz/rRCTUA0Blo/DmlXn9puUkqMqeiE2ga4f9/?=
 =?us-ascii?Q?aXB4KHbI9HiQXkYXqid57I5mJM1zTJJC719KZAhX7HmcnhTRhprKK+hzsZqp?=
 =?us-ascii?Q?KFm5kZzFS8jqQo5CHBnP+U4BnUMumf9zc1Rd0oCcEVs0EIcgUZa/U3eV2FWq?=
 =?us-ascii?Q?DhFgvU7AV8MEDmiZoU/xQqOO0GjN/iMg/Ie97/6nSu/TKAJ5piu7C6l5pBZ0?=
 =?us-ascii?Q?fvmRDwAwpErRAQ5qeSF0lWV2pTNXRUhzMHekkGNWgEpONuxiMqpsFejmB3+U?=
 =?us-ascii?Q?tZ3T6c5Ee37vNa4lAQuHsD4jXsVI81vY+Qf1Q1dbFC00AcYc29nK8lvAREV4?=
 =?us-ascii?Q?EFY5cRcwnDp7x2VuNKllEFAzuBiJm0oDACBTfUVK5kmiKplMvgY+P+VWXN18?=
 =?us-ascii?Q?Nja0xSeRAX5MWHw5UASyrJtpv2G06lFHMOgzrk/jZMGvZbgz7gbK/zzBSfV0?=
 =?us-ascii?Q?tBwLWHm/iTGPnfCgojqAYBNsBSmmqklaeGHrx3VEdOs/Cq+9d092uwch9EFt?=
 =?us-ascii?Q?8KGqZGR1Fs+/HnELEkdOVO4LMMg+6gCiPjyE/Tz2tnwQMg5OquAUkflvTxvE?=
 =?us-ascii?Q?JhGSPCxGSEDTj32zXrdQ8NQM5hblSi93U95rVVeTgh5vAFNZQwuxfZaXjjTj?=
 =?us-ascii?Q?0IpsN/MBG8U1D7x0SsXteaPYHH8Ls2VyFbwsZOaQwWr6MtRMtpq8KEW7v7f8?=
 =?us-ascii?Q?GeH1i5fnjs4//WcTBjq7CTlGqO/MR5SfIPs37dBXQqDycFlQ3VF+b+4P7r8+?=
 =?us-ascii?Q?UVlMs/gSkSnMAkFhQHJIYBboxEORV90Vu/pzsv6l0UdDBkpOR1RVldVzIxoH?=
 =?us-ascii?Q?RFcw/XofeUzKqVvAyfhDliz+6KRjGKhJnOnS5/lbJxMkCOlvvVV1J6TMdyNG?=
 =?us-ascii?Q?+DKZjGmzyn3nwqyfjYOgEIQ5XcXSYKId/9b3Uqo4+Rh7FamRJGumNvsFsuim?=
 =?us-ascii?Q?JJSwJOdIV2aBW5yeXeeLMOnE5N5bJ0tpYE9ICz8tAeXHVbthMXE2AZnJP2Zm?=
 =?us-ascii?Q?6BmeC2/r2pUu1yd7lL7cub3XI7EBKN7tmxeDxGG0UYz21msvAH5siA9/8VaY?=
 =?us-ascii?Q?gBKBF1asyGPDxLsnqNRKN4WmDjZPH8xyHjBgkREM6US8tP1PTWoDb06lrFD0?=
 =?us-ascii?Q?gfFcUF90wnLjXmamTaRwiYdqMMnPhWvL0LqkGnWb6vSBhE9NFap9jtZzvFLB?=
 =?us-ascii?Q?ROc+lxnZPx61oRcJ9cER45OAD2fj9qeXZOeE4jPH1UrhcIhVGWz9Ho61pXhz?=
 =?us-ascii?Q?y5cGkye930eVQN7SD0VuN6TsH9Nb8cEad8Ezbf5eZgLGmGOSeq0sPCmUeQV7?=
 =?us-ascii?Q?YSHStBjuO4HPjVE5BwFC64pPhT5MULQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de119899-858c-45c2-1685-08de799dacff
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 03:25:25.5675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmf0wr3xWapJf7pix89deJxbHbr6JUimdZD7RZ+dPNZ9x33USyVe4Kfjzhyxc7Odcf75QhHs+p0kfyAh07XQoouEOFnETAQ70IRgOOPHYoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6605
X-Mailman-Approved-At: Wed, 04 Mar 2026 05:22:07 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Fix and align Kconfig dependencies for Cadence NAND in SPL.
Move SPL-specific selects to SPL_NAND_CADENCE and remove them from the
non-SPL NAND_CADENCE option. This avoids incorrect symbol selection and
keeps SPL Cadence NAND support self-contained.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/mtd/nand/raw/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 306175873fa..d3467876265 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -202,12 +202,6 @@ config NAND_CADENCE
 	depends on OF_CONTROL && DM_MTD && ARCH_SOCFPGA
 	select DEVRES
 	select SYS_NAND_SELF_INIT
-	select SPL_SYS_NAND_SELF_INIT
-	select SPL_NAND_BASE
-	select SPL_NAND_DRIVERS
-	select SPL_NAND_IDENT
-	select SPL_NAND_INIT
-	select SPL_NAND_ECC
 	imply CMD_NAND
 	help
 	  Enable the driver for NAND flash on platforms using a Cadence NAND
@@ -677,7 +671,7 @@ config SYS_NAND_PAGE_SIZE
 		SPL_NAND_SIMPLE || (NAND_MXC && SPL_NAND_SUPPORT) || \
 		MVEBU_SPL_BOOT_DEVICE_NAND || \
 		(NAND_ATMEL && SPL_NAND_SUPPORT) || \
-		SPL_GENERATE_ATMEL_PMECC_HEADER || NAND_SANDBOX || NAND_CADENCE
+		SPL_GENERATE_ATMEL_PMECC_HEADER || NAND_SANDBOX || SPL_NAND_CADENCE
 	help
 	  Number of data bytes in one page for the NAND chip on the
 	  board, not including the OOB area.
@@ -780,6 +774,12 @@ config SPL_NAND_AM33XX_BCH
 config SPL_NAND_CADENCE
 	bool "Support Cadence NAND controller for SPL"
 	depends on SPL_NAND_SUPPORT
+	select SPL_SYS_NAND_SELF_INIT
+	select SPL_NAND_BASE
+	select SPL_NAND_DRIVERS
+	select SPL_NAND_IDENT
+	select SPL_NAND_INIT
+	select SPL_NAND_ECC
 	help
 	  This is a small implementation of the Cadence NAND controller
 	  for use on SPL.
-- 
2.19.0

