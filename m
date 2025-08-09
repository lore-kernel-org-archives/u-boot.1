Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D857BC87FDA
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:08:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81A8384809;
	Sat,  9 Aug 2025 03:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ripDDhj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79546846A8; Sat,  9 Aug 2025 03:07:14 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59D63847F9
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8/eiJlylOAeu3eIgUdIAXQaUdTebuVOcPYcUmCNsR2t6jQ43fZAndgPN5kSSHnhOWB22jZ5n74LTTi1g3fxb3HYA/RdOZibNdHP3DoPRWR2NSV3tpIe8us3Wm929lei3y00XBWajf8V6pjEaKTLJ/kzu1cVPja0Y3qXWury+lKKa0tF6lNqt0Wo8M/IfotmAL1h3R0k9NmcLqdS3+fnFmDPBXPeazd4ovMzdacV7LfVpr1NcOipeCK27yTBYNeibhRHV+B8swJNYlwdJ/90vNNph6SrhBdJx5mGeOLbSIO8CN6IT6gJ4cGrQnxFigaj+cDlAP8E9GhhMlOfhjoYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYUPuEA05ApeVtNSSc/Heo3dYghUJyy1TPeVBicIO3s=;
 b=wq0g3YNZrwpq5KWgKRoa2TGcqV+fxXVDqT2fbPKl3HqxqFZI/knTa0m+I7ZSKxXXIdGzZe/dQfl07JmlsEoNWXOg2e0zdxK3S3Vb0N9/KlzvWhBE4WZty+m8FpqN6TN2sis52tvXBJZaKistjWyB410wnfh+/Wht8g9w37/Dx+VIAlkb4GjA3Air+j01FZMQOjFAOmqPxIjqoIbtHfajl+RWYIQx/VgNr3cqBul1AEcEzejxMMuQt24IntemgnDz+OFnrt/06cG6NqC7AJn5jg6KT9G1iPrdOxUzt6O/2uoKmH+4PNiF6uKDCCHobl+cLyMd8c0qT8ai1I0ghkLZTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYUPuEA05ApeVtNSSc/Heo3dYghUJyy1TPeVBicIO3s=;
 b=ripDDhj0sQokL9zsCKmDsv6V1vDjGjXDZckrAiKQ9pwzrKhAYDo/sC6Sf2Xesz3V7+UDPhtUIKcAvNt1tT4CwGPrUvzhpbG5ym4aRJJp1YWckQqVO8gioTO07Nj1bDs4IVve+EA1R9S67eqnSj8cIM/1GdPzq/wVwm8snOS2CAfdGdu3hM+wZl8rjcROgfVq5HX2FhP9gHc9hyVRypVjoygBbVvQKTTz00RI3LURyG/nkEx9E1AHerCRBnUVWPw0iQjLroaNk9+3KcseAWhI/HO+CnmGE5KL8ocU4b09sspXdyxsa2/zBNowR6cyQRmppQ5JuyacIU0kxD2+oksWNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9582.eurprd08.prod.outlook.com (2603:10a6:10:44a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sat, 9 Aug
 2025 01:05:34 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:34 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 23/24] mtd: spinand: try a regular dirmap if creating a
 dirmap for continuous reading fails
Date: Sat,  9 Aug 2025 04:04:55 +0300
Message-ID: <20250809010457.3125925-24-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::29) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a6eda7-7f51-4416-d712-08ddd6e0d802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?weEXy64c92b9bwmzkula7FkPqf/MVrbv6JyXpuRHikQy6dRxTNMfmFDxnk3V?=
 =?us-ascii?Q?2T3/N6uhN06oA0vJdyd2H7aTr1X4VFllGKMnkrVycr2IhS/0fyNF06GzngZV?=
 =?us-ascii?Q?8xB+oDHV7ISxArH3cj8KRt5nkprBYTGP2dwRsvrKAM0bqlog8nZz3SbawQmB?=
 =?us-ascii?Q?LWntwT7yS4VhE33ffXfIGMtSqjsTi9/vbmw+5MIO+YcP09uclBQDUYYywkfM?=
 =?us-ascii?Q?W3Eid/g20/DhjUHtDyyccH134BQJ22BAM+Z2UY/S/bZaGM7MRDDsQdQP1YPN?=
 =?us-ascii?Q?kWwtxUEEPmqd+PDU3zgqhOAfQ+LrwNZaBdF85Z9NkR/JGeyQ3BhnGSEQ9Qua?=
 =?us-ascii?Q?OVY1Wvj0UdQYXLj6qrgJHOREJ4cwz7yAwkF7dWxsLKYtZH3dMPL2lt4zEiSf?=
 =?us-ascii?Q?ZfG8jrGODEyR3GhD+XOo8d4yCpgxCjnQTj+zyirqPttSxi48HzEw2Msdr74H?=
 =?us-ascii?Q?SbT7qaxXqUfZo0o2MQ/ewOE/Yq/4iAgxshvu25HlPOQ+IHQVYLINyrZC4nuG?=
 =?us-ascii?Q?CBENExeboLnELQDeXi9BYpm51SV65XxLudxKRjd1rWNQJXM1hU2vAKv20IIS?=
 =?us-ascii?Q?+ub0QX3vkEphvwEdhRon+DjXYBdFrs2OsvB0qfOp3ca7ByhaGBVw90yxTWDm?=
 =?us-ascii?Q?3iuYE2XTd3m1wG2NBi0J90Nv8m1oxXFslo+kQD8wF4ViqRkKYkmHLCnAAGOV?=
 =?us-ascii?Q?mbqiEULzD8YSYg1IjimWMlrQSFAKnBzK6b/8+gz3OQmuxJ7YNBzZTYS3Ud6N?=
 =?us-ascii?Q?BpsZdPsbHQk4GwV51GFVA8qkUMDuL7NEqA2ovY4sF0gLi24uKRBcAyXsy7ip?=
 =?us-ascii?Q?M3lO8S2bxwPtD/I/nrcD+8ldQF9/2Jr3Aa4sZH8eGUOD/+5p3pcjT8WC/O19?=
 =?us-ascii?Q?wFwQ3No1cMrjVJjooCJrE65Fm05SbalvZtB40lnNxyhglbIjls6LHYZ7Y2TV?=
 =?us-ascii?Q?mGJwuPgf01u8UehLVlivvq/RF9rUJ3d5tDFZyEgDWCrghJQUAfezAqNwy6gz?=
 =?us-ascii?Q?xvPgkH9VAYvsKh4jnLP4Tw/j6JPKig+xcKQ+da9+JNnIlGvWwUOPRxh7TCKL?=
 =?us-ascii?Q?kl9tKdnOfbhWf4rXCDT+9cveA/iFYdcA8JLj3bzZ3fIlllAiw/UvvMczvk21?=
 =?us-ascii?Q?hlYr2XvujEGgrqB3BBrFKcWrUsQAwiG19V/QoytRvUNHwelA54iK42XLxe4i?=
 =?us-ascii?Q?SHKPXYHNZSRZr5c7Jfn2xyL7g+gQCG21XmSSUlOeLUWGzxjqJD8ql/TM+vsN?=
 =?us-ascii?Q?E//DlFsyOM+a18HQkwPFqDwbmMKSrxfFI7Pdbuz6dJ5ULTcgDnnoeiKy516q?=
 =?us-ascii?Q?82hRlhNjKS2sADyzmIySVg+CoXxSXNoI7TQMDKehwJCv0YYBR6yKL3ODkQtw?=
 =?us-ascii?Q?kl+jw6KXdegmlujo2wuj0PKCfigLv0pamaSduLt+emnqpj7i3zAYK0i7w47y?=
 =?us-ascii?Q?cxZ4W3Zx2qC7gIUTqsQBKU3hcCRauMy5jf0R/kKXevotg2ALNmVpxRfPIBrA?=
 =?us-ascii?Q?zCnAgK6DxVSuIF8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zEm1FOT2mduB2CO8oqYxjq1DBmv5/CplYm4HDcgpjULzCbxT/ZolpkRFsM5R?=
 =?us-ascii?Q?g8fgH37LLQTPulfPW+vKS6kAFBL6mjFMeLVsUm59j0Fx6s8+Dn34tcbf0fHi?=
 =?us-ascii?Q?/sdMBnsZrMh3xgS1BXeZt7HBxiZkI2Z+E6U41d5mx0FFndD2zQ1+TioDYlbv?=
 =?us-ascii?Q?KoJfCXVH/6MAzrfWpdbh273LtkBYIdTPr7ul1bouWiqsG6S1m3IZN79wt53k?=
 =?us-ascii?Q?gkkNq+BJ9skkXPcayBzXlibbFDDKomxcv2ySnVFG9KQBh2V1LqhZA15hMzkM?=
 =?us-ascii?Q?CLwK+woOgGMOSATPvLd3cOEXpzczPbcz86fQGhjbJVG5dWqt4TiHsQR3SwrM?=
 =?us-ascii?Q?tzPkOt5eofMhZ2rl/TCKQ36eY1wfrT/jzi8QnRhONbqn6KF0RFrv3a8o+7Xi?=
 =?us-ascii?Q?tFuOwr2/WTXoIvQgawV9ab3PPaTC8ORhZYYfyfyaUhM1NK8yvHSu0vjxxqc2?=
 =?us-ascii?Q?In1XdmpvMjxHJSh1G1jcvPSn2rQZIPRStX6MZ3+H5vdPXQUZ0WlmsKma2spv?=
 =?us-ascii?Q?NRuCVTm5/uBkA226w6+Wlqqs1npzV9ALHlqUd/BYAzbx5L67xQfqmGU6eTBO?=
 =?us-ascii?Q?5Z2AD8ER0k5Yi6VSXi6ldM64Qa6kq2eyhOwYPImdrBZeC0NrEwTvI/fcUxZw?=
 =?us-ascii?Q?lJ8LOJ+0/YhZ9PGqvG3F5z9E+SN5DTfTz6FG8B8o4QGZRPeYpXGDQpm94tlu?=
 =?us-ascii?Q?wzJjtYq5zexuaHOsltaOHm9wOCAaEKXvzmKOe6ROgpxTu8yJQV8/HWnPb81A?=
 =?us-ascii?Q?5eQDn+6hmgyCz5V7LjWmf7wCTXv2ulJrcaXVv5d4o0sgvq99COyksvPAh3ow?=
 =?us-ascii?Q?99kXpSXxrGyKFkpZSFfvhwfhvnEtfoMfi91RJFUmZYo2lZ5H1KMDV2MQGtKt?=
 =?us-ascii?Q?FulMiITW6opCKlJFXPUhqvaJYQWe/ELTMEZtX/W3qoveRmNcp1HcF6nfkNtn?=
 =?us-ascii?Q?hIZBU075NeUAHHTSBv9zX9BadTknRmoE3LfJFq7JtJ6iCRFAKAknklZn6Vb1?=
 =?us-ascii?Q?03Js+6Ug1gdithOg6QYy9zLWj+DqgxAeTFJJ3m0sMnq2tiJbvkYwQDK+qRXT?=
 =?us-ascii?Q?j5sifitoDyHgO6ytxDzME6MLo2CS6VbK2l7yQjlGJhzDb8tXz4nAFKia+0qq?=
 =?us-ascii?Q?x8ytBdrTWY/V9t0wZLrRiczDd3r0e6NMGFTPmbjgyO6CFaBom0puao/NFaUY?=
 =?us-ascii?Q?RP5rYZv3O/SAGTh4HoISoU7w1G/nHDoUAfhT2pFGT2hrV++9W4DxJaWj2amO?=
 =?us-ascii?Q?nAFiNZkpgodUejTETmdUnAioqkX8gXziz31F0cyUp+MoeNTXUDchQxT8BVN0?=
 =?us-ascii?Q?ccc44F40ZV98rgdUMsJJxaemkD6Ort814aVfPqEK7f3dSGcwy4Zg4zZEtcrm?=
 =?us-ascii?Q?VZp06XMCinfx4jVzsSzelpyBHKhI7E2Ii5FuJhOQprGZ47rT5jkCDlaBETb8?=
 =?us-ascii?Q?8JcfxbQ530yyg/oNGXQYhx08hQlAHPuzjAvFY9MIn/NVMZW2Kp8JNsvuvuJn?=
 =?us-ascii?Q?K/NFj2Bxj/CYFsav4GoqwwqLEYa6NZvVN4EKV8CjS4WUsI+Vx05NdnS4tE5f?=
 =?us-ascii?Q?bUiDvQMZ40Wo+TxcjWMRM5tPrbNFSy4v5BR9Is+a27aCoFs+zVqYbZKak7Ec?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a6eda7-7f51-4416-d712-08ddd6e0d802
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:34.3033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wq7XLqCnLJben68vzRaj9GlQV7MmYnxBDuxks5B7+xIrXWIG2bR+v1yJgGO3tfNbXwPE2UcaARggSiQTcTfsV6Y8VGh5G690+gI+sYH+GaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9582
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

Continuous reading may result in multiple flash pages reading in one
operation. Typically only one flash page has read/written (a little bit
more than 2-4 Kb), but continuous reading requires the spi controller
to read up to 512 Kb in one operation without toggling CS in beetween.

Roughly speaking spi controllers can be divided on 2 categories:
 * spi controllers without dirmap acceleration support
 * spi controllers with dirmap acceleration support

Usually, first of them have no issues with large reading support.
Second group often supports acceleration of single page only reading.
Thus enabling of continuous reading can break flash reading.

This patch tries to create dirmap for continuous reading first and
fallback to regular reading if spi controller refuses to create it.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 69dbdd60a6a..31926e37104 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1114,6 +1114,37 @@ static int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs)
 	return ret;
 }
 
+static struct spi_mem_dirmap_desc *spinand_create_rdesc_helper(
+					struct spinand_device *spinand,
+					struct spi_mem_dirmap_info *info)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct spi_mem_dirmap_desc *desc = NULL;
+
+	if (spinand->cont_read_possible) {
+		/*
+		 * spi controller may return an error if info->length is
+		 * too large
+		 */
+		info->length = nanddev_eraseblock_size(nand);
+		desc = spi_mem_dirmap_create(spinand->slave, info);
+	}
+
+	if (IS_ERR_OR_NULL(desc)) {
+		/*
+		 * continuous reading is not supported by flash or
+		 * its spi controller, use regular reading
+		 */
+		spinand->cont_read_possible = false;
+
+		info->length = nanddev_page_size(nand) +
+			       nanddev_per_page_oobsize(nand);
+		desc = spi_mem_dirmap_create(spinand->slave, info);
+	}
+
+	return desc;
+}
+
 static int spinand_create_dirmap(struct spinand_device *spinand,
 				 unsigned int plane)
 {
@@ -1132,10 +1163,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
-	if (spinand->cont_read_possible)
-		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
-	desc = spi_mem_dirmap_create(spinand->slave, &info);
+	desc = spinand_create_rdesc_helper(spinand, &info);
 	if (IS_ERR(desc)) {
 		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc);
 		return PTR_ERR(desc);
-- 
2.47.2

