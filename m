Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBD3CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9C01842FD;
	Fri, 10 Oct 2025 13:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="qAsYkPw8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA3E18437E; Fri, 10 Oct 2025 13:59:08 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82F3F842FD
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2LpLKSfH8xLQ9PJLup6OcuKHaQQx7XEiEwBZsg1OpwOwwnnGvXYfSoD9a6IUEOmNB9VfJ5DSOi6ro5lQs0WpLi66Ul88hhaCc+JVEdDcxw6VWEBfHWKJQt0H5FdVlBAaw/rSPLTu1FNwrgA/gk34Z5vQiGxB9hAr7vscWeDX8IhyOeh/fZe6S3flGBgX1F+bv9CnPePP2Fav3X1q1X/OiGv1Xe5jNRDKZwy8lGemlO/tLnIDNEmGw8BvSDoBRFazaKvSN//BtbjxAZao5zGwLEt7tgvCqnSy1vmu74nKoCIr3HgRN2DFH4CTUJq1ZG5mez7oyhgdk0cTFO21KKF2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOY3FsMECbeRpUOWsiTmdMVoT3FSpNO6hNYp4hai4UY=;
 b=u/a5zmdwCabV0gNVcuPl4MkIzig8wlndWKKSSznfNUfLVGSGpKuMoyaBj6pcwlpdY5KRP15q0/FkFJMowCIEQp3EXxUO1aSnZEhUX1wf+mDghVVHJbg7ZuFEWHpyfIGlizLdun3ooX6p8Uop1/89KGJ4g63aaNfGtgwKicgu7wSIOxVNBmOEdMLBDnT3wksW4sIhjioG3XHf/lohwNvfpVbvweu8RASMswv5tm9xo3HSYoPOAeYpgtmRRr8rbKbgSa3RK24EpSvcMZZk5ASK94DJ+1Q9AncCudpY7DrM6MxsQjkqkF07HO7E67ccPoGkse3yEUgiC1Mjc1+gjqXqAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOY3FsMECbeRpUOWsiTmdMVoT3FSpNO6hNYp4hai4UY=;
 b=qAsYkPw8GBYLeUVz2/i5jqZRbYqdVjBXqmWHhbXperJejGyVn1mPt5nFExfHe61p/X7QUQKnwGFuoH2igyDTRwabuh3B2xre2Q2pY9Vx4Qngoke9wtjoT0dYX63AZHx9MDIIG7Z8ePxnBN0FUVDKFEljjo1TGHYU+nNu0mftl4qF4sPiTMg3rPtleFBjsuFCUaY1VuMiizhnExfcX+ArRbRJcoU90tE+7XsmycpbvfTFs2BNcnZHDBpvmLmhqPC6dFuDHlZyAR/pdzL+Kfh9/dwPj7TCl/VXluPmQzl9ou2drwCyVVAWiF/heVjd1CVHEdNxhWofO8tIis9oKRmoaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5586.eurprd08.prod.outlook.com (2603:10a6:20b:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:59:05 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:59:05 +0000
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
Subject: [PATCH RESEND v7 23/24] mtd: spinand: try a regular dirmap if
 creating a dirmap for continuous reading fails
Date: Fri, 10 Oct 2025 14:58:24 +0300
Message-ID: <20251010115825.1531775-24-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 0ab0f3d3-15a0-4f7f-a31f-08de07f46922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|1800799024|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e94uSBys2lhrUn0bxkz77r2VsnjG5ww3drGfWu6Rul5AUQ9uarudLObjpbUo?=
 =?us-ascii?Q?uegIDzv5R+yWmTLvCGtN/3n01gV6SSkOp89mEeSvi2rGrfeQ5qVvb0LvGOLw?=
 =?us-ascii?Q?+vuhmxgKg/MNN4gfzPZrZ0oRMWLrgaXVw7kVCE6vQSa6IIKWpvV3aL89o/N+?=
 =?us-ascii?Q?3G3WfS7k7GrgJu3OVpU9ImZqML6m5vuriRBIR7x0BtRzHN3V2zS+Ey7VpASR?=
 =?us-ascii?Q?1GhwglMape8+Mt9ftTtC2RFBsboKTYawxbRZtjTTzMpawJiUNuCjjN1v0TV8?=
 =?us-ascii?Q?GBA1U1m6mNMTWvFqyjFIiNr2BD8qF9n3n6DbfDNPm9oVtHYROaOFz5mNcqfV?=
 =?us-ascii?Q?wGR6xeoZ2iphJKP5Le26QJd4FDg0r1TQAZplkCTSY+8b1h7G6HLnSCQOvher?=
 =?us-ascii?Q?PA9u3i4KN+OEQy5oyDIo4PSuaMUguP9NQof06ZpQ75GYRz7mcruVUeF1n1HK?=
 =?us-ascii?Q?GqwWB17c4Pw1GDmGhSreNg+kzzufrK3kbWjEReDVxhgizm4dJpPX/fKtZXJ1?=
 =?us-ascii?Q?kdJD9utUS3fRefzzD5v7d8eq+sLbYn182LqAu+l2UTElFd+4b2rQmEgzR4H4?=
 =?us-ascii?Q?rb53CwSZzEYzmvYG+eipxW4oAVD/VahMTVU63cdMbxUGNZAVT18RuY7QJMTb?=
 =?us-ascii?Q?hU9DTaO0A/isy2QIVaCWRWCQB9yHTJb8AztOPkiaQAwUbQSDy6VEAcWNMpsW?=
 =?us-ascii?Q?BOVbQtSYmKqpMxNZazLZQtbEVQqrrd7adBt2AOsuoEoGWRtMeYrMWlNlfYoM?=
 =?us-ascii?Q?K2aXk6w0I7t03+0Gy+C6P3jVBwNHlty3gF9p+Hi5k9MjgNix+5xJLGG7qZ6c?=
 =?us-ascii?Q?zi3y8OH9Kw1xvl1ZrTF+Etq0SQwan9IK2nG4HIUWulxg3erp38AkIiv5of+X?=
 =?us-ascii?Q?SiUdd4Mrr2GdGWUWwfgjRVCFJILs6lfXO2+oV5E0JERz/yFpSbN0DVsK/SPd?=
 =?us-ascii?Q?OCDL+caedeDRyHAXyHboWYproEkAAksmelp134aJAhr0TF64unOI1+cnMjtR?=
 =?us-ascii?Q?S5wsnPXOpaZy6uC4o25N43rbW1D+ZGs0WQAKz5r2024eYj/e6J1etZd9Ffqm?=
 =?us-ascii?Q?14661FXIqx1TPBCeQ6KN23KosulhePBAMBjZhfUvWDunNJRe/QGGz0eFv2RD?=
 =?us-ascii?Q?uXgrbvXVQ5RIdi58yb8ZRvDV2AYpgEH3VyNu4D0qOgFO/NnYmquBiOjj6DWi?=
 =?us-ascii?Q?NTaNoQfdTYuS4fMOhKOOwpMFXCejvRDxnbqWTOqwbQ/zf4go6i3qGy/BeD7I?=
 =?us-ascii?Q?83jOZe+X732eA9zOaOKhS6TRqOe7/p2lF3KaNVLXJwjcgEcM3gQrzrQmJxxY?=
 =?us-ascii?Q?PRdP5s0tgNz9YQzaODHjks4hg2uCtZ9qtffoJVkzeLx66Gtat7Nz1taOQ3eI?=
 =?us-ascii?Q?GmNRzADwLfVyfl45ggjNkDTSVb9LL9WMl+ljXZVNA7UVpyNftvH52o+DudGB?=
 =?us-ascii?Q?G/i9eYqtuMXqKq9eGILaAozo0ie1yGkL2A64eRIkOQOQjlImZpkpDNueg49e?=
 =?us-ascii?Q?zBWpZe13gTSz1dedp4pFm23PDJVaHaT14WxBb72xWNqcpE5V3KuYRqlYKg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mx8+ZLQVIi30tIc7nP7PK1Ixn4eRV/xU7L9jo+6FUB9ypmZUmx76CshulTCI?=
 =?us-ascii?Q?VuMRdg35rDnrPXZEGPYeLV/sZ7rw+5gl6r9utLbS+RmFcAq9cFkrVDahiSNi?=
 =?us-ascii?Q?4+NjL7lEulNyJwptvrCCctsgbyJkMhn9TDgg23vR+m5r8l1AWAolJh7CPXvt?=
 =?us-ascii?Q?+TJgHsJXj1t0FZ1IvlSHXtCalZ4akLSPfjTAQsTtcctb6YT6CD1JKWZbqhOB?=
 =?us-ascii?Q?UbV51LhkmWK3nKHwD9dzyCeHGCEZJL1KCRqE7m5bBtMvTz4SAfq1rzMprjH9?=
 =?us-ascii?Q?BdHBEHDIzKJqL7IoQQZmQ/flHihUgaFjSlFsCt5REh91XOd3brFR26X3aKmF?=
 =?us-ascii?Q?TxKDRDJvlQHTF0vntg7SjQ6B2MKRavcuCKfJ6E4XDidIJZ1M8GsgxxiiIm/6?=
 =?us-ascii?Q?gpR3xrD/+XwR21FjSHqTdSNkBSEgMFbf9m37gktMouKzs1F9oCkfCX95anLK?=
 =?us-ascii?Q?SNPcLfsGg6Oz86K/OkIRJKOofcBN7H0OO9KALaHH4NFD71K64SBY+drOxrTz?=
 =?us-ascii?Q?WHFiXufK4499tSbLAX9bR4CBCXnTKHn0B+mq7lQ1Uk9MGoHicHp3Viv+1NKf?=
 =?us-ascii?Q?o98+81Ar00iuwjB8iXvOqBNmBZLf+DbHI2c73CR39UliF8rzshihKAOAyRgU?=
 =?us-ascii?Q?EHgdI2mcMLNMv9rh7YOtNAdSuD7adktbGfREwlEwXnNK9/GuZUocKLBeFJAd?=
 =?us-ascii?Q?h6PAWnR9kbwK+1QWT9oprAQvmcPQlszlUiw/2sDFgfQ3G2IoYLxgOHC4JvYt?=
 =?us-ascii?Q?Q/qaoamqZOj0yzVkZVirEDpj1fYO9AJTngTOgwIG7/IUR8UT5qZ7ofpX6t47?=
 =?us-ascii?Q?igs0iQM+SWmF4iyg3SSLyYhpfTYBIws0q9WjtsfKfmjdK0Lg4M6OVibfagb1?=
 =?us-ascii?Q?1Llv8RVIeFXfLjg0HRxLpD1cPW3UMoG60xyJIPX5GjoYWMvtX8MQsl8VY4Gx?=
 =?us-ascii?Q?HmtGi7rRAX/LWZUX0wUClGeHNb6n1BVF3+6YXxMfxdbUbOWjn7m1siHzcJwv?=
 =?us-ascii?Q?IDmsPFDntZn4Hw4UuxXS3JFyZGxfChdJ3/+lA4RxE66rgXfnPTKHxVvSG/Vy?=
 =?us-ascii?Q?1M0+YBxKzzezXjzJ7IEKXPqoWWswuESLJU6A058X8fDnblRdSu9OYmo6VgS/?=
 =?us-ascii?Q?OPcyfZJjqmZjQYi55jpcTidGh780Yc47oxXnrB2W0/2KiENot/8O84ZfDYa3?=
 =?us-ascii?Q?d35h51uxaDrLP9r6LG62U86PdiuoiSwAtyX4Ki6kJ2Y49Let5XufRNeZOP7Q?=
 =?us-ascii?Q?JiHTxUnUPejldSNnDNfD94Sr2tucsg+bKRn/4XuAQGB4kKHKaqVHwHfPMSSk?=
 =?us-ascii?Q?yty1Mz/cJu2dgU6/Lb6oUNCiT3fb4QMdktzBGZKQieAJW8PXp0WQFA6BWi+d?=
 =?us-ascii?Q?e45j+YNgERPs4okbAjhlxdraSk8RVquWXXjF0fH7gb1UyDHBDVZM7Na/4DbO?=
 =?us-ascii?Q?JWDZFBxEvcHgW3tVo+7OX07Uo0SPZgvqB6h6fkFW2at18M43vaL289l7DJ5q?=
 =?us-ascii?Q?JR+t+Vm3RSvs5Z1kit/c0UHVrBykqhryBQ68IxgHmepY9D3VzkyvvDU68YUX?=
 =?us-ascii?Q?1OPsjYozqDjJ+QAXr0AfslSOipHURXOZ8rkiCeJxllCT6YcpwRnP4ueUvuyG?=
 =?us-ascii?Q?dRInI4DpJihUjZ41JctdT40=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab0f3d3-15a0-4f7f-a31f-08de07f46922
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:59:05.2282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2lMbDv8JY1fcqeJTkkJUkXwlWwPOeLqa4Wjv6TZJRrTHjxQL2UT6u/8LR/CRidKTyT8kG+GdWjCyGSxSYVviZDffyYilFyUtl5FEDAwa4A=
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

Continuous reading may result in multiple flash pages reading in one
operation. Typically only one flash page has read/written (a little bit
more than 2-4 Kb), but continuous reading requires the spi controller
to read up to 512 Kb in one operation without toggling CS in beetween.

Roughly speaking spi controllers can be divided on 2 categories:
 * spi controllers without dirmap acceleration support
 * spi controllers with dirmap acceleration support

Firt of them will have issues with continuous reading if restriction on
the transfer length is implemented in the adjust_op_size() handler.
Second group often supports acceleration of single page only reading.
Thus enabling of continuous reading can break flash reading.

This patch tries to create dirmap for continuous reading first and
fallback to regular reading if spi controller refuses to create it.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 69dbdd60a6a..68a03ddee8b 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1114,6 +1114,37 @@ static int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs)
 	return ret;
 }
 
+static struct spi_mem_dirmap_desc *spinand_create_rdesc(
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
+	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc)) {
 		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc);
 		return PTR_ERR(desc);
-- 
2.51.0

