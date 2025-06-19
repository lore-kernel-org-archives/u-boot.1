Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27D9C7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 23:55:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9226582D88;
	Fri, 20 Jun 2025 01:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="yqim2Mpq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3832782C55; Fri, 20 Jun 2025 01:55:05 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08C6582D21
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 01:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTJ40ZFaVURRGTskTO8LZm5FojIbc7ja3aLSzyPvjrv2cz35DIpKL1GGXUw7a0cm8V1z33ljDQ8ZoeYwFX5qpgFrGIBSji9OPHOmXBDNznf91h8FvClrx2T+6jBEIkN3L/EKBfVfk1RO0d+Atsg4bzaozgXFaCDzpTPAKQ8CxxTo+qfOVRoQ7j8Gg9dS4tqpWCyM4oN2yVTToyODNKeHkWlvJIgHBo4wr+6WHVWWPTL/J2TGNs+6mVCUGchFWfOIID4B2ZxqM0scKJgOly9BZZO7KVObfj3fG0TqMUlY55IDBsHMlxwFCL2ZMUehLeP7DyIfkJP36ctB/TMKZlbp6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lRai1AbTKpTO+d2Em867L0qwEVx4bO2PFxSxwtMw1o=;
 b=xBrVYa29K6ELy2qAT7oo/0qK3DepfJ9zwDCCemkV5POerZgxCNfzds2nBlUZMZdbguA5fhpqzM4634um0Wc7xzPYB8Nsge7XY/d2O3y2NaZ7QwyrpowpCR8k7yz9xevRDOK32R87Xau30JLGw8yCeUryUkyW8B3zTHll1BRCPxE59DH2tbNPY84MhPRUzpeodx5Tf3k0peLxejvy1tKSsjYeEvu4hNAotbD1LrVDMWHAAGqhZtByub35x8hGtZLvYlR06eSJuPcHkA8x0YklPgBrO+q9+j5oUutn4bkPYqDT1BIuNf63qhD3zDolC9YWRtZOUdJPkopF+OJ0E214Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lRai1AbTKpTO+d2Em867L0qwEVx4bO2PFxSxwtMw1o=;
 b=yqim2Mpq2wl/1CoPvhafR1Z+Rs96IritqzvQCeI/pQbv/+66MrLsSZJ1buYk8xKOAPOuG1/4gNo8bPYgXajjH1c4p2sds+05yGk0Hx6xmIolcuXkY2XVnCEtW0NH2aKX1KzXyr6aDPrk6AvzQC2ICDrlo2pcID54ldvlElCh/TF6Fx24NmUa1Z4uE0x9dDtsF2+PNrWjeOqbcKgKEijVe+r4N3JdSdQKjTjfpDEi0E545a/elh7Cct5ThCQx4aYF7ObRhHiLXogI3ZmQ3+hNhU78YCQvcbjx3+w91O90sXppQm0l38GH7YL9VkJvUpF5RSsXWUAlQ0NZn17PeuIA0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10560.eurprd08.prod.outlook.com (2603:10a6:800:20a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Thu, 19 Jun
 2025 23:54:59 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8835.023; Thu, 19 Jun 2025
 23:54:59 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 3/3] drivers/spi/airoha_snfi_spi: add dma support
Date: Fri, 20 Jun 2025 02:54:48 +0300
Message-ID: <20250619235448.2414587-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250619235448.2414587-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250611151043.1259441-1-mikhail.kshevetskiy@iopsys.eu>
 <20250619235448.2414587-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB10560:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c1e375-1a4b-4c09-6cdd-08ddaf8cb320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v7YhCaZUGJJwnb/rrI1c13Aex55rhyNU/hbr0jMUpNUUC6S/YbxHn6jAQ4Su?=
 =?us-ascii?Q?QS3ZtTBst2XHWSCHrxHAvGkjSISem5W4j67YWmDSkIv9d33am7jU7NEHwjrL?=
 =?us-ascii?Q?fHHk4v8KK3D30kBbVAw6YqgT6DwVlA1YtDiv3faCFnmbaXyFCDB+A7zbs5mI?=
 =?us-ascii?Q?CGqCTd3pA9zNY/hsrfvGuPnNqqhuf9QYkpi7DIMhgrUJ4XqR/kDT6zmfFQij?=
 =?us-ascii?Q?sp3cWYert/Bqjo8ngJ2zdGQaTrv3GW+Z4KpbTeN8za7K90AwAyYM42uElGaG?=
 =?us-ascii?Q?A1veNGaEXV7XMH2Pxr5O4QVXt0j4mHIOK9VjvlDmaQcMlmn9IO909YayulUv?=
 =?us-ascii?Q?36+XBzt6fFvFxJ7OuXQI11cDygbPWjRuWxEQ2qDVrBIwMEyxzkyjLU7F4Kym?=
 =?us-ascii?Q?2HTewhWZP5GMRXoeyisuYuICcL63Z1IMBs6g+Ys0RsdpXJnKjQm/ZdovdQ3d?=
 =?us-ascii?Q?iAet8twiiddkSwhzr4JXRY3u0lQsiKe8Z8h3iKNm8XS+l1hzO5YvWZHOnXSZ?=
 =?us-ascii?Q?zhn9nr5YDSWz0f3Qju6LlE/3pvkn69Cl+QmcrleEJlCfIrzvBfmcTivxfS6k?=
 =?us-ascii?Q?F4XUf3vaw4JXQlP08CPKhE2L0x0ynudrxfoklgUeNR76rUyPQjW/IpyWTWjO?=
 =?us-ascii?Q?bUdqIpH8+NOW97dvXBZBrjxIXzbjuEgqwQzTUEP+Q5atVH4jJh69+eJ6q+IS?=
 =?us-ascii?Q?bhN7GRKYBHMPmzHWcjDh43c98qkf7rCVlEu5rFhvW6GVhakGunonETG3rkdl?=
 =?us-ascii?Q?ltIjHaB9/Gw01zuFCxFwoJeMfUaAly/JDkWeUS8m0T6NgnVMJ5QWf5kKx2Qq?=
 =?us-ascii?Q?QTgvA/pFIqHnZd40SZXETtFxsfdxGx+ipGhOX1DKXUnSDq20uvjbw6ZbCsnO?=
 =?us-ascii?Q?ZoM6llNZquYg4eOMqpVIYhDoXBd/gxTd3Vv3Tc2nqKHRCBfKwBaDeuMmRk74?=
 =?us-ascii?Q?tjBtFQpIOsfwqf3Yjg26v5Glh0AOQl774zvImqYzob12sj7LU9w7X8VJTbei?=
 =?us-ascii?Q?1laZwGibgYdq7IGI/uzIwdjJbBBcLK24gl11t0dKJr/W+owChYrG9Vk2VED3?=
 =?us-ascii?Q?yhd7nbb928DUKsoVQKx8iEeM+1q519aCs8hJhAlPD/3BtNYvUG3qZFcILyzw?=
 =?us-ascii?Q?sXhVUbddSAqSIwIblbkG4LffvflEsa+kiO5SAUa7H4cu3xobgSWTqEW2hnGh?=
 =?us-ascii?Q?aKSKYxAGqVfA0piguNDg1cdpCpkMQZvWKYDBjz8txBeuRtOs1BHtp6kBX6EF?=
 =?us-ascii?Q?575dNFHY7qcyFX5XlUFCybJ1duyQo8joqU+rmAXb/Q2Z13c2p7VV1KyX1osa?=
 =?us-ascii?Q?T6vqwz/UiXiVDOgb+2YqO86vKvKxnedDCPFBQVWLF7APohch9AhkeOBah21C?=
 =?us-ascii?Q?Qk/z/vFOG9gFwAEb0p9DsMaY0UzUq2gyn/BqmZSNGQpnXVos8vc3DAoNrEF6?=
 =?us-ascii?Q?lbPbMVUwIVjUOo572SD11juvETsDZppqQNjgLDHugQPnGuF40g0gGQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4B353bzmT51L+NyLDReD2I0bQSWDjia6ZmcrIkM7PJWHwh8bdyXSTUHvA3+h?=
 =?us-ascii?Q?Gj0oyy8dTiFejyuyuMqI7Iuw67nnZpnYcDDOQf+ZeTviTLARLtrUpWbNBZO8?=
 =?us-ascii?Q?dxPkMzEGBIzgIl6xtzikc7LdEQSmqoYVKcC72sVAPyJScbc+COdz6cdlrfMG?=
 =?us-ascii?Q?BQdGRCLshQYdYN2O/v2MKj20NqkC8ft81uZYNtwAFg/YIMMPQlrtg2FXE4B/?=
 =?us-ascii?Q?EpQtNS8hDbdsLE8r16n1h55rtLsDUjsTu9AfN0Eg8Uwne8+BuYQrwg2aCt8y?=
 =?us-ascii?Q?stL6w6r8VKsft36O3hXaUE07uQZtLyArTunpCfq4zFj8PM6On2owhNIYdFL0?=
 =?us-ascii?Q?lWELfRQrI2rfGp3GcbQQyS1kKMtx60gmNTSFEzoTJpoti7chQt7Z6uV97ORY?=
 =?us-ascii?Q?7nghftR4TDgrVFnJ44RiQ+1PU8PzJ/JDK/uCbU8vp3/7E2M3dPlmDhS2MJMw?=
 =?us-ascii?Q?/NH7xo7xADSuaE0UWWL5Ii0r6Ak7XGF5HPvPrkiPFwxKD0wreGHV4FKVr8Zz?=
 =?us-ascii?Q?8v7AF2vWOGvukOGGM9HdujULCjU/1dulAMYgtNsgXFEwgIFqg9fLi8HXBIAY?=
 =?us-ascii?Q?9jniLjLuRwkq/zoIARSRNm9NYsTJ40kQ6S9Z/+/PzonLh0iXjkD9YE2fmJMV?=
 =?us-ascii?Q?vETBxtW2ZwVZW4qGn8BtT+TDd2VD01bV38dE4+oXXPFmWz9ftQUn4dnujRWA?=
 =?us-ascii?Q?uE/KlZbcpNZt9z7BD5Nzcq6APkLLZTDLjKAuFOlC9Qr1wbHVwMF4U5SvLgaN?=
 =?us-ascii?Q?PaqCse4AVZJZ95bQzs5IrYPAGo7wd67+kEWSAt13ix0oBvkDKTaV/XqMkTm2?=
 =?us-ascii?Q?bZpNn5OqMHR4F7p6KJ+Q116fRupCyIuef4Gu4fQsCSiXrrNgry04vCCHKofR?=
 =?us-ascii?Q?jxhryPpKPxDlYmdNH8aMiBnY75Iju0ep6+pOGZ+PdaAvBW2SuW5VX3F8sxSg?=
 =?us-ascii?Q?EgrQlUS+M/VKcQzh+jya8RFUmoPSspAb0CjOYC72aTfg8dizboxZ3mxNJOLP?=
 =?us-ascii?Q?WncIX2/Ai76D3qqn+fC17JqBGOC8m66nhfe8WgYYyIq1bw6s5m+bm1Dz87rY?=
 =?us-ascii?Q?q7LHfm91adqL61CRJP5DpwQr7I/g6NGD2wzi+IVLrsRZU0W2f7nGJ9VdnTqW?=
 =?us-ascii?Q?RZUQmJNs1/2tHMT3UCVpg+xSoF4nXa7e6RB3oAxMgBdhA0mTjk/2jbxwaOz2?=
 =?us-ascii?Q?CB4GdzyOkocnep+8qHfF/ANvzbPQGY44kwunPKocx0GD0UjE1oZYK+Ho70C3?=
 =?us-ascii?Q?aW+Cjv+EZJkMkrqF9q7d66lntZCFEOd85SDwLQxEzu22X/7eSzvCkrMEyOF/?=
 =?us-ascii?Q?t69ZJUkQwA/PbddiLfV9flGiqMSXW2XkYwJsakAwGHmGh2WDDnHFHyCPDVtv?=
 =?us-ascii?Q?RoRx+DPGQ+QeVylQxJ64U+Iuu8GSaH+IKvkEr6OcrTXMlLAFXI33NuWOjMcu?=
 =?us-ascii?Q?XZKSGXgZ+Zwu8YS0QgDUWh+fFCoKjHijCYy1/NCf2mQUosV7uXZHLbWn+bw7?=
 =?us-ascii?Q?pnVfQLGWUvD0Z4rxuoQFSZCsErFnlB9PR/JqpbjMk1FLo7cWy2JtA60CRYCp?=
 =?us-ascii?Q?Z20A70J8nFnVg+nYdT9BVb4C9XJytCdlnxaSWjNT6FTeIlS7lq58J8WjvQba?=
 =?us-ascii?Q?XW67vRNyKio+VU/mvC8yQIo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c1e375-1a4b-4c09-6cdd-08ddaf8cb320
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 23:54:59.4424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmKM6OjJDzmK9EJqzLaBp8aV7QNDT+ZJHAuVAtulyUZm8qvihSU3ygYNc8IjK9Bdeo0g5nLRLvHDpculPYaHX9Bccb+EFqv0AoOIen8GIyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10560
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

This patch speed up cache reading/writing/updating opearions.
It was tested on en7323/an7581 and some other Airoha chips.

Unlike the current design it does not use any knowledge of the spi-nand
page/oob size. Instead it will only use the information from the spi-mem
request. It will speed up
 * page reading/writing without oob
 * page reading/writing with oob
 * oob reading/writing (significant for UBI scanning)

The only know issue appears in a very specific conditions for en7523 family
chips only.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 526 ++++++++++++++++++++++++++++++++++
 1 file changed, 526 insertions(+)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 363590231e2..9f6434ef177 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -119,6 +119,7 @@
 #define SPI_NFI_AHB_DONE			BIT(6)
 
 #define REG_SPI_NFI_CMD				0x0020
+#define SPI_NFI_CMD_WRITE			BIT(7)
 
 #define REG_SPI_NFI_ADDR_NOB			0x0030
 #define SPI_NFI_ROW_ADDR_NOB			GENMASK(6, 4)
@@ -141,12 +142,17 @@
 #define SPI_NFI_CUS_SEC_SIZE_EN			BIT(16)
 
 #define REG_SPI_NFI_RD_CTL2			0x0510
+#define SPI_NFI_DATA_READ_CMD			GENMASK(7, 0)
+
 #define REG_SPI_NFI_RD_CTL3			0x0514
+#define SPI_NFI_DATA_READ_ADDRESS		GENMASK(12, 0)
 
 #define REG_SPI_NFI_PG_CTL1			0x0524
 #define SPI_NFI_PG_LOAD_CMD			GENMASK(15, 8)
 
 #define REG_SPI_NFI_PG_CTL2			0x0528
+#define SPI_NFI_PG_LOAD_ADDR			GENMASK(12, 0)
+
 #define REG_SPI_NFI_NOR_PROG_ADDR		0x052c
 #define REG_SPI_NFI_NOR_RD_ADDR			0x0534
 
@@ -173,7 +179,9 @@
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE	0x03
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST	0x0b
 #define SPI_NAND_OP_READ_FROM_CACHE_DUAL	0x3b
+#define SPI_NAND_OP_READ_FROM_CACHE_DUALIO	0xbb
 #define SPI_NAND_OP_READ_FROM_CACHE_QUAD	0x6b
+#define SPI_NAND_OP_READ_FROM_CACHE_QUADIO	0xeb
 #define SPI_NAND_OP_WRITE_ENABLE		0x06
 #define SPI_NAND_OP_WRITE_DISABLE		0x04
 #define SPI_NAND_OP_PROGRAM_LOAD_SINGLE		0x02
@@ -189,6 +197,8 @@
 #define SPI_NAND_CACHE_SIZE			(SZ_4K + SZ_256)
 #define SPI_MAX_TRANSFER_SIZE			511
 
+#define NFI_CHECK_MAX_TIMES			1000000
+
 enum airoha_snand_mode {
 	SPI_MODE_AUTO,
 	SPI_MODE_MANUAL,
@@ -212,11 +222,19 @@ enum airoha_snand_rx_buswidth {
 	SPI_RX_BUSWIDTH_QUAD   = 0x0f,
 };
 
+enum airoha_snand_nfi_buswidth {
+	SPI_NFI_BUSWIDTH_SINGLE = 0,
+	SPI_NFI_BUSWIDTH_DUAL   = 1,
+	SPI_NFI_BUSWIDTH_QUAD   = 2,
+};
+
 struct airoha_snand_priv {
 	struct regmap *regmap_ctrl;
 	struct regmap *regmap_nfi;
 	struct clk *spi_clk;
 
+	int dma;
+
 	struct {
 		size_t page_size;
 		size_t sec_size;
@@ -567,6 +585,485 @@ static int airoha_snand_nfi_config(struct airoha_snand_priv *priv)
 				  SPI_NFI_CUS_SEC_SIZE, val);
 }
 
+static int airoha_snand_dma_on(struct airoha_snand_priv *priv)
+{
+	int err;
+
+	err = airoha_snand_set_mode(priv, SPI_MODE_DMA);
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_ctrl,
+			   REG_SPI_CTRL_READ_IDLE_EN, 1);
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_ctrl, REG_SPI_CTRL_DUMMY, 0);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int airoha_snand_dma_off(struct airoha_snand_priv *priv)
+{
+	int err;
+
+	err = airoha_snand_set_mode(priv, SPI_MODE_MANUAL);
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_ctrl, REG_SPI_CTRL_DUMMY, 0);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int airoha_snand_nfi_read_cache(struct airoha_snand_priv *priv,
+				       enum airoha_snand_nfi_buswidth buswidth,
+				       u32 opcode, u16 column, u32 len,
+				       dma_addr_t addr)
+{
+	int	i, err;
+	u32	val;
+
+	/* NFI init */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_INTR_EN,
+				 SPI_NFI_ALL_IRQ_EN, SPI_NFI_AHB_DONE_EN);
+	if (err)
+		return err;
+
+	/* NFI reset */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CON,
+			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+	if (err)
+		return err;
+
+	/*
+	 * NFI configure:
+	 *   - No AutoFMT (custom sector size (SECCUS) register will be used)
+	 *   - No SoC's hardware ECC (flash internal ECC will be used)
+	 *   - Use burst mode (faster, but requires 16 byte alignment for addresses)
+	 *   - Setup FSM operating process flow (NFI_CNFG_OP_READ)
+	 *   - Use DMA instead of PIO for data reading (NFI_CNFG_READ_EN is set)
+	 *   - Use AHB bus for DMA transfer
+	 */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 SPI_NFI_HW_ECC_EN |
+				 SPI_NFI_AUTO_FDM_EN |
+				 SPI_NFI_OPMODE,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 FIELD_PREP(SPI_NFI_OPMODE, 6));
+	if (err)
+		return err;
+
+	/* Configure NFI for reading */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CMD, 0);
+	if (err)
+		return err;
+
+	/*
+	 * Setup transfer length:
+	 *   - Enable custom sector size feature (NFI_SECCUS register)
+	 *   - Set custom sector size (NFI_SECCUS register)
+	 *   - Set number of sector will be read (NFI_CON register)
+	 *   - Set read data byte number (NFI_SNF_MISC_CTL2 register)
+	 *
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.read_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 *
+	 * We will use the following settings:
+	 *   NFI_CON.sector_number = 1,
+	 *   NFI_SECCUS.custom_sector_size = transfer_length,
+	 *   NFI_SNF_MISC_CTL2.read_data_byte_number = transfer_length
+	 */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
+	if (err)
+		return err;
+
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE |
+				 SPI_NFI_CUS_SEC_SIZE_EN,
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, len) |
+				 SPI_NFI_CUS_SEC_SIZE_EN);
+	if (err)
+		return err;
+
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL2,
+				 SPI_NFI_READ_DATA_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, len));
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_STRADDR, addr);
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_RD_CTL2,
+			   FIELD_PREP(SPI_NFI_DATA_READ_CMD, opcode));
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_RD_CTL3,
+			   FIELD_PREP(SPI_NFI_DATA_READ_ADDRESS, column));
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL,
+			   FIELD_PREP(SPI_NFI_DATA_READ_WR_MODE, buswidth));
+	if (err)
+		return err;
+
+	/* trigger DMA read operation */
+	err = regmap_clear_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+				SPI_NFI_RD_TRIG);
+	if (err)
+		return err;
+
+	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+			      SPI_NFI_RD_TRIG);
+	if (err)
+		return err;
+
+	/* is reading finished ? */
+	for (i = 0; i < NFI_CHECK_MAX_TIMES; i++) {
+		err = regmap_read(priv->regmap_nfi,
+				  REG_SPI_NFI_SNF_STA_CTL1, &val);
+		if (err)
+			return err;
+
+		if (val & SPI_NFI_READ_FROM_CACHE_DONE) {
+			err = regmap_set_bits(priv->regmap_nfi,
+					      REG_SPI_NFI_SNF_STA_CTL1,
+					      SPI_NFI_READ_FROM_CACHE_DONE);
+			if (err)
+				return err;
+
+			break;
+		}
+	}
+
+	if (i == NFI_CHECK_MAX_TIMES)
+		return -ETIMEDOUT;
+
+	/* is DMA transfer completed ? */
+	for (i = 0; i < NFI_CHECK_MAX_TIMES; i++) {
+		err = regmap_read(priv->regmap_nfi,
+				  REG_SPI_NFI_INTR, &val);
+		if (err)
+			return err;
+
+		if (val & SPI_NFI_AHB_DONE)
+			break;
+	}
+
+	if (i == NFI_CHECK_MAX_TIMES)
+		return -ETIMEDOUT;
+
+	udelay(1);
+
+	return 0;
+}
+
+static int airoha_snand_nfi_prog_cache(struct airoha_snand_priv *priv,
+				       enum airoha_snand_nfi_buswidth buswidth,
+				       u32 opcode, u16 column, u32 len,
+				       dma_addr_t addr)
+{
+	int	i, err;
+	u32	val;
+
+	/* NFI init */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_INTR_EN,
+				 SPI_NFI_ALL_IRQ_EN, SPI_NFI_AHB_DONE_EN);
+	if (err)
+		return err;
+
+	/* NFI reset */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CON,
+			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+	if (err)
+		return err;
+
+	/*
+	 * NFI configure:
+	 *   - No AutoFMT (custom sector size (SECCUS) register will be used)
+	 *   - No SoC's hardware ECC (flash internal ECC will be used)
+	 *   - Use burst mode (faster, but requires 16 byte alignment for addresses)
+	 *   - Setup FSM operating process flow (NFI_CNFG_OP_PRGM)
+	 *   - Use DMA instead of PIO for data writing (NFI_CNFG_READ_EN is cleared)
+	 *   - Use AHB bus for DMA transfer
+	 */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 SPI_NFI_HW_ECC_EN |
+				 SPI_NFI_AUTO_FDM_EN |
+				 SPI_NFI_OPMODE,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 FIELD_PREP(SPI_NFI_OPMODE, 3));
+	if (err)
+		return err;
+
+	/* Configure NFI for writing */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CMD,
+			   SPI_NFI_CMD_WRITE);
+	if (err)
+		return err;
+
+	/*
+	 * Setup transfer length:
+	 *   - Enable custom sector size feature (NFI_SECCUS register)
+	 *   - Set custom sector size (NFI_SECCUS register)
+	 *   - Set number of sector will be written (NFI_CON register)
+	 *   - Set write data byte number (NFI_SNF_MISC_CTL2 register)
+	 *
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.write_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 *
+	 * We will use the following settings:
+	 *   NFI_CON.sector_number = 1,
+	 *   NFI_SECCUS.custom_sector_size = transfer_length,
+	 *   NFI_SNF_MISC_CTL2.write_data_byte_number = transfer_length
+	 */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
+	if (err)
+		return err;
+
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE |
+				 SPI_NFI_CUS_SEC_SIZE_EN,
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, len) |
+				 SPI_NFI_CUS_SEC_SIZE_EN);
+	if (err)
+		return err;
+
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL2,
+				 SPI_NFI_PROG_LOAD_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, len));
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_STRADDR, addr);
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_PG_CTL1,
+			   FIELD_PREP(SPI_NFI_PG_LOAD_CMD, opcode));
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_PG_CTL2,
+			   FIELD_PREP(SPI_NFI_PG_LOAD_ADDR, column));
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL,
+			   FIELD_PREP(SPI_NFI_DATA_READ_WR_MODE, buswidth));
+	if (err)
+		return err;
+
+	/* trigger DMA writing operation */
+	err = regmap_clear_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+				SPI_NFI_WR_TRIG);
+	if (err)
+		return err;
+
+	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+			      SPI_NFI_WR_TRIG);
+	if (err)
+		return err;
+
+	udelay(1);
+
+	/* is DMA transfer completed ? */
+	for (i = 0; i < NFI_CHECK_MAX_TIMES; i++) {
+		err = regmap_read(priv->regmap_nfi,
+				  REG_SPI_NFI_INTR, &val);
+		if (err)
+			return err;
+
+		if (val & SPI_NFI_AHB_DONE)
+			break;
+	}
+
+	if (i == NFI_CHECK_MAX_TIMES)
+		return -ETIMEDOUT;
+
+	/* is cache writing finished ? */
+	for (i = 0; i < NFI_CHECK_MAX_TIMES; i++) {
+		err = regmap_read(priv->regmap_nfi,
+				  REG_SPI_NFI_SNF_STA_CTL1, &val);
+		if (err)
+			return err;
+
+		if (val & SPI_NFI_LOAD_TO_CACHE_DONE) {
+			err = regmap_set_bits(priv->regmap_nfi,
+					      REG_SPI_NFI_SNF_STA_CTL1,
+					      SPI_NFI_LOAD_TO_CACHE_DONE);
+			if (err)
+				return err;
+
+			break;
+		}
+	}
+
+	if (i == NFI_CHECK_MAX_TIMES)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int airoha_snand_read_cache_dma(struct airoha_snand_priv *priv,
+				       const struct spi_mem_op *op,
+				       char *dma_aligned_buf)
+{
+	int err;
+	u32 mask, opcode;
+	dma_addr_t addr;
+	enum airoha_snand_nfi_buswidth nfi_buswidth;
+
+	mask = ARCH_DMA_MINALIGN - 1;
+	if (((op->addr.val & mask) != 0) ||
+	    ((op->data.nbytes & mask) != 0) ||
+	    (((uintptr_t)dma_aligned_buf & mask) != 0)) {
+		/* Not properly aligned */
+		return -EOPNOTSUPP;
+	}
+
+	if (op->addr.nbytes != 2) {
+		/*
+		 * flashes like gigadevice GD5F4GQ4RC
+		 * and similar is not supported
+		 */
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * DUALIO and QUADIO opcodes are not supported by DMA,
+	 * replace them with supported opcodes. Figure out
+	 * required buswidth.
+	 */
+	switch (op->cmd.opcode) {
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE:
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST:
+		opcode = op->cmd.opcode;
+		nfi_buswidth = SPI_NFI_BUSWIDTH_SINGLE;
+		break;
+	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
+	case SPI_NAND_OP_READ_FROM_CACHE_DUALIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_DUAL;
+		nfi_buswidth = SPI_NFI_BUSWIDTH_DUAL;
+		break;
+	case SPI_NAND_OP_READ_FROM_CACHE_QUAD:
+	case SPI_NAND_OP_READ_FROM_CACHE_QUADIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_QUAD;
+		nfi_buswidth = SPI_NFI_BUSWIDTH_QUAD;
+		break;
+	default:
+		/* unknown opcode */
+		return -EOPNOTSUPP;
+	}
+
+	addr = dma_map_single(dma_aligned_buf, op->data.nbytes,
+			      DMA_FROM_DEVICE);
+
+	err = airoha_snand_dma_on(priv);
+	if (err)
+		return err;
+
+	err = airoha_snand_nfi_read_cache(priv, nfi_buswidth,
+					  opcode, op->addr.val,
+					  op->data.nbytes, addr);
+	if (err)
+		return err;
+
+	err = airoha_snand_dma_off(priv);
+	if (err)
+		return err;
+
+	dma_unmap_single(addr, op->data.nbytes, DMA_FROM_DEVICE);
+
+	return 0;
+}
+
+static int airoha_snand_write_cache_dma(struct airoha_snand_priv *priv,
+					const struct spi_mem_op *op,
+					const char *dma_aligned_buf)
+{
+	u32 mask;
+	int err;
+	dma_addr_t addr;
+	enum airoha_snand_nfi_buswidth nfi_buswidth;
+
+	mask = ARCH_DMA_MINALIGN - 1;
+	if (((op->addr.val & mask) != 0) ||
+	    ((op->data.nbytes & mask) != 0) ||
+	    (((uintptr_t)dma_aligned_buf & mask) != 0)) {
+		/* Not properly aligned */
+		return -EOPNOTSUPP;
+	}
+
+	if (op->addr.nbytes != 2) {
+		/*
+		 * flashes like gigadevice GD5F4GQ4RC
+		 * and similar is not supported
+		 */
+		return -EOPNOTSUPP;
+	}
+
+	switch (op->cmd.opcode) {
+	case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
+	case SPI_NAND_OP_PROGRAM_LOAD_RAMDOM_SINGLE:
+		nfi_buswidth = SPI_NFI_BUSWIDTH_SINGLE;
+		break;
+	case SPI_NAND_OP_PROGRAM_LOAD_QUAD:
+	case SPI_NAND_OP_PROGRAM_LOAD_RAMDON_QUAD:
+		nfi_buswidth = SPI_NFI_BUSWIDTH_QUAD;
+		break;
+	default:
+		/* unknown opcode */
+		return -EOPNOTSUPP;
+	}
+
+	addr = dma_map_single((void *)dma_aligned_buf, op->data.nbytes,
+			      DMA_TO_DEVICE);
+
+	err = airoha_snand_dma_on(priv);
+	if (err)
+		return err;
+
+	err = airoha_snand_nfi_prog_cache(priv, nfi_buswidth,
+					  op->cmd.opcode, op->addr.val,
+					  op->data.nbytes, addr);
+	if (err)
+		return err;
+
+	err = airoha_snand_dma_off(priv);
+	if (err)
+		return err;
+
+	dma_unmap_single(addr, op->data.nbytes, DMA_TO_DEVICE);
+
+	return 0;
+}
+
 static bool airoha_snand_supports_op(struct spi_slave *slave,
 				     const struct spi_mem_op *op)
 {
@@ -589,6 +1086,32 @@ static int airoha_snand_exec_op(struct spi_slave *slave,
 
 	priv = dev_get_priv(bus);
 
+	if (priv->dma) {
+		switch (op->cmd.opcode) {
+		case SPI_NAND_OP_READ_FROM_CACHE_SINGLE:
+		case SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST:
+		case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
+		case SPI_NAND_OP_READ_FROM_CACHE_DUALIO:
+		case SPI_NAND_OP_READ_FROM_CACHE_QUAD:
+		case SPI_NAND_OP_READ_FROM_CACHE_QUADIO:
+			err = airoha_snand_read_cache_dma(priv, op,
+							  op->data.buf.in);
+			break;
+		case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
+		case SPI_NAND_OP_PROGRAM_LOAD_RAMDOM_SINGLE:
+		case SPI_NAND_OP_PROGRAM_LOAD_QUAD:
+		case SPI_NAND_OP_PROGRAM_LOAD_RAMDON_QUAD:
+			err = airoha_snand_write_cache_dma(priv, op,
+							   op->data.buf.out);
+			break;
+		default:
+			err = -EOPNOTSUPP;
+		}
+
+		if (err != -EOPNOTSUPP)
+			return err;
+	}
+
 	op_len = op->cmd.nbytes;
 	addr_len = op->addr.nbytes;
 	dummy_len = op->dummy.nbytes;
@@ -679,6 +1202,9 @@ static int airoha_snand_probe(struct udevice *dev)
 	}
 	clk_enable(priv->spi_clk);
 
+	// force dma usage
+	priv->dma = 1;
+
 	return airoha_snand_nfi_init(priv);
 }
 
-- 
2.47.2

