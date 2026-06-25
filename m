Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5236BCDE000
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 17:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDC5A846F4;
	Thu, 25 Jun 2026 19:02:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="syTVxlIg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE7F784704; Thu, 25 Jun 2026 19:02:55 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 345168460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 19:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2yFOnS8zFaxwbdwSh69Qx4uJ070ZeF6bYHKVUA/Ax7Vfg6dntKtDZoYcPLVvGcdoYrB0bQu5ew+zfayR5i8kxH3JiLGSN9hce7F9oU00L5yREI6zyWEAHqGo+hS+w83BRXKhWcV0sABe9KyHwUqJypDX6U29xRtWDwnQRvVK8oA7vPeUmrFb+1QoTITfawq753NdUc+jtFUoAwJEXNb0QOdaHjJMK7fiKDMrdVvkqWp5yaz9ODxoe89SWNJDbrA9jzAnZg1Eow5zVra9+5yt57sXOUiluqLwW/yYxoofmMWonNtPHQuyAbEyQOEDoeV/nHQ2xrs2ssyQTgdKqGT8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SEFd9veboM4Uha0jtjC+wQaNWgfS9ocwQM74XddAhc=;
 b=e6J+JCo0iwjHDWeeLDON1TpPUvBq9Hvk97stOategy256XbjPAhRVZCaAWPK7GbO2S6+LHPzKtek4X2k6YZUO3AyJ0Lsgkx6cLFACCklBvSIpDpquf6YKY6X1/Wd80wFqxB1DGkI8nDR1PDNvxl2hPIwu3zNZXrh5QqUvyipKUWrAxAntzGP+OCiP/Myrf92nW2600NUB+OCboele2PSwyaTUaSd5GolnokIlegHYc0SVEx1hpk7smcxHx3/CZJuk0G/oFNSfxr8440IZ4FWg9mi+QgHWfvjq3NFW40dX9GX1uACxt7iJQ0QxjIr0+JJ+7K4eY130b0DYI5cpeGkHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SEFd9veboM4Uha0jtjC+wQaNWgfS9ocwQM74XddAhc=;
 b=syTVxlIgBMLK3G7AVNcaVv7yedALGFw4zCVtZX5Eg7PBuH2bkVaxnvFv2Ga96gVbJnxlV2fkl2yS/padtMCgkT6/PiLegNPEJTAxp0x6g/LU+8oUJFX+Gh/YS+YCD7bV/QrYzyjbgyG0kqTdMnvwXwps23DSmOgrhozC4YqkK5711dnsIgdd9xVNShm61VyLQHpfkUcvFprR71D1VDfbp67iKB6Cwy650nhLynHcvQ7d9aRJ9fJ3jGMN4MLyzMVATIL9zUm8ElXA+eS29optT6mFcOFvdGeRE91rAW4z1/M+9IYHK3dLdh1GOEjqy34e8a8ESb7n7BdRtTlerLiWCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by CO1PR03MB5811.namprd03.prod.outlook.com (2603:10b6:303:91::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 17:02:36 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 17:02:36 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>
Subject: [PATCH] mtd: rawnand: allow SYS_NAND_BLOCK_SIZE when SPL_NAND_CADENCE
 is set
Date: Fri, 26 Jun 2026 01:02:23 +0800
Message-Id: <20260625170223.2963-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0125.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::10) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|CO1PR03MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 0312b801-04b9-4f19-0c5f-08ded2db8e1e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|55112099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 0tBA3I/kFL2cjb0JLy+eNkHONGRakAUhq3eEnIz5/PI1vthBWSWVgJqRAJfuNkdDIJv5YA8qUWos0dSRLAKwa4bA+wto6Ag7jH8OV5YzUHLo9O1ZJUAQbGpgRYqL3bXDQdvKlbzIGbNJ9DEEfi0TF6MLNFpnjz4AyhdoFZmHOKIIh3cNHU4zSEHqQ2BaHk2XtPOCizGWPhV7JCq++FEBixQ9Apmo9ee8yAKKA/qLtrPXKWrHCrGdVSRwXeapMhJNxe2re5dsamrbeTDOYpxW8C6fBgcbLeoGNk9CAQvB4I1SbUIh79Xg+sO8Q+OloVIF/cFICFdybCiD0LZRihdQefgSHvD3uqLIZkqR6n1k++7F0lEbDTByr7X3PetibFFakV3draFdzsZ4SG8UeyP76no+nykgd/EUv8B2huLfCok6ZELo+ccH9QlNGwQhljIcgqYNNasE+TywcYdIKYVGpovEZTvwgN16wTYsjU09VbDvbpND72/lSYAIaH5FaNnJIvNdfoRQaEuwPZqvBayOPhDFhyE2a7QDIUyB/mwhAfadTENYl4LT22upvSZjXTWUQry9XRcce4+C6wroZtnb6w2wW278s9nomOuNzrNkXUbYM7pUCs7/FND/eFunYlqUTZOuzIHtb2ncBJy+i7E5oGmgbvC2knEosYREv9x1GRY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(55112099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eq/VOJqaO461uIWpwdQuYYl6DaQl4um/xRq+KYIHEddJYxJmlgfDMttO1NmC?=
 =?us-ascii?Q?J4p9Bjsfg+ZKLHGPHkhIyq6SKmu8RQfIg8xUFpU/1AalplY103+ERSI7G+yg?=
 =?us-ascii?Q?52pPA0JrxGyHnraJPHIYL187GIP7xbALv/4Zo3MufDbtXAy4M6z1557tGbHm?=
 =?us-ascii?Q?ZUZzKK4n97zLz5IEkYNLCPzY+yxGT0pGK/v+fJt9HruBgsn+n+KNClwYU5pH?=
 =?us-ascii?Q?qrKVb5x20SUYOQvLYbCZueZvjX17O54YjUdQwj/Efl+OpYe9QB4+MwQw4ug8?=
 =?us-ascii?Q?WC00qecikXY5bZ1fe1JpeAXNI1X4Ow2KLuHBhHwZj3wjECMe44vSr6dy1+sr?=
 =?us-ascii?Q?R1WQa3TKiIw3vhiOXV7PPnzq4d75z1urQBbOxW7KioUg8VhjWg8Zqp497CQH?=
 =?us-ascii?Q?S/wvZoBXwBjyN8wHYvLSJvHA000OiCw5FfmCKWAr6WD7ADYxq9ZUbyLJiKdX?=
 =?us-ascii?Q?pgwzLkC+f+QdCwzK14tTkY811B7evb7pmRmb7bvf5QCCKUU9loph/utWgl80?=
 =?us-ascii?Q?dX3LL2Nb7ak54u0HJGnMn5DMGXyGNjEht97rYM4tMgzJuW20JD4iSNa+jYb9?=
 =?us-ascii?Q?YCf8Im8izn5Exq0lmdg8nDQFTQUHSYN1tHjj0/TuTyaBBx8DUl9O8g0Riqtz?=
 =?us-ascii?Q?RUddqy0QUIW/VqKSxyC1KwSeOJcvm0bpgbqejlkU+PsmaQY8M0VdwuS7BO0K?=
 =?us-ascii?Q?CCEQoTreKxoMKoPhAHs1lPtg6/9517weOxGk7RjAGZ2Jq+LrNZmr1qsJ1YkB?=
 =?us-ascii?Q?HOHzok1T+9N2vYuVwnfpb4dW9HfsES15hpV1x+ns1sUhxorEU356ZMLxj1SQ?=
 =?us-ascii?Q?bv0EtubdC9TQS2GOYdtc+YjAFD4IuqRaFBW+E9FSyFLKNzwwTPoeREEKxoGz?=
 =?us-ascii?Q?PqeuUOWdaXY9wNr57A4waAcfgyIm4IuAYs5IJhird1O82T4w2BHw+YV8hAkQ?=
 =?us-ascii?Q?tHscldDbWsB7PO8DnubmyUYP5B6Da3FNHT/UfqNRT2ZANaCJ/9jkzFRB6Z7z?=
 =?us-ascii?Q?DohFkmAIjfqtUC7+Y4/nwTw/Gv0rvQ4uFLYhInHmXRZwYIhGh2oe+oiwtQcf?=
 =?us-ascii?Q?Xy+opXuuPWRU7McJ9XBLj4Scrtq/HKGbWU58dmh0EZcH4eWykA9p+wEkcXnS?=
 =?us-ascii?Q?h8X8YtsqL+XclytXtBluSjkFpKc7b4Apg5n5T4gGcKTgYcwytOuQnJBV7iGI?=
 =?us-ascii?Q?E0gQ1Lvu35Wqal8G3Qa7b2EcUfIthu4/8El3jQE/4WZVSaEYabvJt7tqTXxC?=
 =?us-ascii?Q?bXESmE2eqpqC+q+8MlNSuvDzJXYtB+57OzEFbG+GkC6SRIajxlmvO3vm/J9A?=
 =?us-ascii?Q?8LghDlrIzTbKL4hpenHQXKklwlaf2UMxZ/W4fSuUTWRTJ4WFO/3DfkWSCgDu?=
 =?us-ascii?Q?9TtGHaKd5aim4zquP28XzxoNqBEHlypNA7rB/6A5I7CgSj7gnJAPPt3nU6C+?=
 =?us-ascii?Q?A34x/27yDmovxqpZEwxveMgiblk1THXYVqkFChbp5klaja+HRbPVUEThbnxI?=
 =?us-ascii?Q?jlWUpTuiX5Rx4kG29lj3zxgtT1wa8H6TcHT9e6xMQtYj/GBgzNzVqL1YkQtw?=
 =?us-ascii?Q?rfCkYqlhECC0OonKRZDkkEHCAPs8JdRv+aUPivzGJsNl/qF2fMk0+5dDNn2O?=
 =?us-ascii?Q?at+eedOKu//ZzMpHud7WHqhZuQmhIk3YJvJU4sNzp8yayrRpm5ulBnJLW1Q0?=
 =?us-ascii?Q?liH+FIKDyPQ0xRxzC1xIzV+Ti03ehGXpuVgS1FWJ7aMGKd87f6W12/xBK9es?=
 =?us-ascii?Q?Bp/Rxitis/hno3nkcli/aIRtVWbAbOE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0312b801-04b9-4f19-0c5f-08ded2db8e1e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 17:02:36.0936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IpCMbK4g0tW1Dpfy9QwSs5uBBEFfCqSA9/qlp9MeD/Q1lQaUqcGWsgrkD4TbLNbAPmDvY3oKJ6MXUeWR4TYvTExdLrU5DpyqBYdqsFUsLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5811
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

drivers/mtd/nand/raw/cadence_spl.c, selected by SPL_NAND_CADENCE,
is a thin generic SPL helper on top of the nand_chip framework
rather than a Cadence-specific driver: nand_is_bad_block() uses
CONFIG_SYS_NAND_BLOCK_SIZE to compute block offsets for
chip->block_bad(), and nand_read_page() calls nand_read(). It
works with any full NAND driver that registers a chip.

SYS_NAND_BLOCK_SIZE currently excludes NAND_DENALI_DT boards on
the (correct) assumption that the full Denali driver auto-detects
geometry via ONFI at runtime. This precludes boards like SoCFPGA
Arria 10 SoCDK that pair NAND_DENALI_DT (full U-Boot) with
SPL_NAND_CADENCE (SPL loader) and need the eraseblock size
statically for the SPL helper.

Allow the symbol to also be visible when SPL_NAND_CADENCE is set.
Pure Denali boards (uniphier) keep the existing behaviour and
their .config is unchanged.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/mtd/nand/raw/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 261b9a51dd7..4850e0b2554 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -662,8 +662,9 @@ config SYS_NAND_BLOCK_SIZE
 	hex "NAND chip eraseblock size"
 	depends on ARCH_SUNXI || SPL_NAND_SUPPORT || TPL_NAND_SUPPORT || \
 		MVEBU_SPL_BOOT_DEVICE_NAND
-	depends on !NAND_MXS && !NAND_DENALI_DT && !NAND_LPC32XX_MLC && \
+	depends on !NAND_MXS && !NAND_LPC32XX_MLC && \
 		!NAND_FSL_IFC && !NAND_MT7621
+	depends on !NAND_DENALI_DT || SPL_NAND_CADENCE
 	help
 	  Number of data bytes in one eraseblock for the NAND chip on the
 	  board. This is the multiple of NAND_PAGE_SIZE and the number of
-- 
2.43.7

