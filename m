Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8F5C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 14:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 179E6889A6;
	Fri,  5 Jul 2024 16:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="gAVADi91";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C1968899F; Fri,  5 Jul 2024 16:25:19 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::722])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4598788995
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 16:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nr4hJjVfMuKrWYt55tQSjof84c4M9FDvFlit7pcp6mPQ+dbyZTUqGUw6S/Z60CqXiwesmqMypHg9/+7ayIMKFj6AY5Mz0QE2L6pARBQYDChu9wYSO7TQem0beKwM872ID/iaqG0aP0xQdA8z844p+xvI0s4PbFkNhfzqeO/JDnIhBAE7KP+tH9utVWs3J419NlJwPHWiLG4ZSn0XoR+kHtU4sd/95D2J2aKVC6W5d0xBxLspwZAwyEJFo98iN2vlypNXKcSGNeXX+F5xbldxUgVYdCdYV6NMZz8zeh8Fap7azFKe9+CoNUeX6b6IAoLtsgEgHCVFyvNbuHQT2N+zig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPS+L6IwPPkLcE681qlaBYpwSUjIE5PDYY9KUVGYie4=;
 b=f8eQnhswc8EW5yV4bA2iilUuxUjwdgffSNNmM1GfmLclxeDB4jPf2N7krvGQbihf6mZZHoWHY/oTCVe2fbWDErUIuTVC7zHD62PoPyznzxrNoSv1D5jEQxHRlbMzbFaou3SbSU7JFuscBLyHs5eseSuLR21J+2VDGeL2bPZUvPtdZJiscHlj593NiZXY2chmEwxNxM2ArE9U189yY/Z77qcxbZDth/3w4Xl5lVtMRfLCaFV3ltooBjfm1kdvA3nS9vrIstxev/SseRF2gZGbCtdjui5y/fq2x7vim2m1wi+YPOd8eSnSJdsf4k82gw+gW1+p4xoy8oIgLu96dJY0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPS+L6IwPPkLcE681qlaBYpwSUjIE5PDYY9KUVGYie4=;
 b=gAVADi91R3A/T/1xnG96GjtPvPsqRsgTWtXH4qlcDRbOwMUev7Q37zYcZjToE+W3LSaqb++YhPTu+blDdrMpOrNja1tfLpiA0PpnmLoemEENHXPFqmLVNmXG+VZkijvkCkKQVGXVAfthEw7HWxbWMCJKcveGiKu7OwSjiySycVoDttVd63Jt2+2RoD7RhfvRm8Gpnl2PsGHViYZrdEAH5uSXBjHXFfxfWVfSotfcp2ZYaKXhC1XGUQeFfA3gryLDo74Mea5N/TErZZ4IDQieMxc6RXlV4AYlFbgloOh9HYduL5Nc8wkiiTgtg66+1NIy+JZx8ajEjEDqSthupa2O1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB5978.eurprd08.prod.outlook.com (2603:10a6:10:1f5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 14:25:15 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 14:25:15 +0000
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
Subject: [PATCH v2 1/7] mtd: spinand: Use the spi-mem dirmap API
Date: Fri,  5 Jul 2024 18:24:54 +0400
Message-Id: <20240705142500.2272803-2-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba58b59-8fd6-4260-23f5-08dc9cfe49d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|1800799024|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5NeJfgLThyEbEWflulghBLaCYlMtOSgUyJLcXWDv/FgZZpU1Tfo52WM61A0g?=
 =?us-ascii?Q?qTIN3de83KnEikUdQoGn9QXjEVJszHWRzZCGtdJLplNWMsDYJoa63gwZcYkF?=
 =?us-ascii?Q?iU8bADiNK18cm7wlcrCz4e9y4ZjnvZa1DzO8b5yRUFkknwmAagOkSFtnUynR?=
 =?us-ascii?Q?Tuxe8Jz+l9STXd1245Dp0fqasgEOe01wRWAe0lbKR8nzukNrYbDR+ilXZOjs?=
 =?us-ascii?Q?cB7AU9hO+Z/3w+KuvUpIU6BpnXTI1jCDmGcBnOfjkA50IJFXBPCnsdjUtcR7?=
 =?us-ascii?Q?J71fVk/faUKenwXi2+0RfkobZK+uIZwNSt8QRPFZyFMOBUoK1aZv+EuHgdCU?=
 =?us-ascii?Q?kDo5dMV4aNfXcvJFUQB5CxQYE4UAIy1ko+xTHtbnzgIh4/65GsqV45svdt98?=
 =?us-ascii?Q?vuRz6sTkVwis9dZu5kJC3EA890VfXXR8JNJihp5XSYAVvCClWb5zswRZ93Gg?=
 =?us-ascii?Q?5Ag85D14UNH7lKhja5qGRH/XS+aDFNRoKarMZZZms4XknxRKwouNFQ362Nob?=
 =?us-ascii?Q?V86Ubs5BIuhl4Uo2lNu/2piH0kp7tIW2SFq6XCdr/iVyQhGlLvoBLzSzgRSB?=
 =?us-ascii?Q?jGjG5zCEGqnpct324fgJ+ZMfWUJS2ZcLcJAWhYzxLwVIyACedJ4lJdOCFUGy?=
 =?us-ascii?Q?TiM2+5pon53loNLVUToX7PfX9vZYdfcOe9p3awcU08ZxZq5YMprgrBZOFu6n?=
 =?us-ascii?Q?JmMyTjXVdUSbNOWr++txa3ij7TSMS5Rj+tiTcc/q5Q2t68BbhHZT0phyFYmd?=
 =?us-ascii?Q?RuIEAk5K3/cQyhiOWazkiPdYnMRFzp2JHOf15at0sBqr5iXXe5Pf2N8M4rRm?=
 =?us-ascii?Q?J1Jf5quVlap95y9zTfskm9FzTZPHnm79Szb5SG3EWtVnD/RZUi8TKFm8xKn1?=
 =?us-ascii?Q?hGMSEGQDAiaj2xpD8sIgSbHXCs8CWaqcZ1CGj5vnf0pLJpfrI0QRk8M4XMNP?=
 =?us-ascii?Q?2+PqZHeUrPnsHSGGyUiroi8sYdfQOw6B11poeCshZJsh7YK6tqI6/ogsx9kh?=
 =?us-ascii?Q?qTt982U8p1T5KZ/1uwr6r0ZNCoXL33KmNGQyjxDmwY+SJdmbqbA4i7PyRxNE?=
 =?us-ascii?Q?ap4IUMuvOIP2p07sYGdJqB0Bi4C7BbXHnjP55pe7X7hgfdVGxWXfCvAFqu4u?=
 =?us-ascii?Q?3vnbqHKLzJCYbkQiZGRN3yyZz51h9jbj3tu5mG2Di/EHZv/NWpHi77zNJAH3?=
 =?us-ascii?Q?jW48yV1wwkt4WxWnTRDbWjRks3uF/QT5PWTOJ27s+xvjdorBTo7hzEJe6B3y?=
 =?us-ascii?Q?VxWRvAZJEZS6i5mVjHQY1sfy3bUIVLhRhuFkevIh2T7g80CmI6NMYsrpWAmX?=
 =?us-ascii?Q?mVzW5LU1EVFUDDvOEtDl32LzaQlPlqMLTs5CfuuFAeK2E2zXLOKglIKKuEM2?=
 =?us-ascii?Q?ilSGov7OPUt0j/OtmW+LvXxCNFdyX6QI1dzNvpIsfOEDai8VkZ+Rw9eyzH8D?=
 =?us-ascii?Q?j+zxJls5NVY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(1800799024)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MdAH3t+hY6p/Apc8qf1xo5Q7W6oGmq478rp2ga3uD32R2+2PajGHB1zfXtp5?=
 =?us-ascii?Q?JlvtjiEw+8yV9ryD0Z0mL6QA1bCQzpdk/TqAg5GqhDtB+4P0TfRw6QdGjS+X?=
 =?us-ascii?Q?LQCmbH73RR6lvyjoSiYzOv9spmnvzIDzksw14hy1CPSUMU/qWEqhsYvWfc+c?=
 =?us-ascii?Q?hggvLIAV3nXHs+RNl07TQ5rsJ6sYjAr1xlLkhf84I+POiSZKn3TTq2KrqdNc?=
 =?us-ascii?Q?6CHbMwDgTtLgICkXAAx4DmH4+h0yt9qksVtIddlxb89sUiQizzqoWVCeU56l?=
 =?us-ascii?Q?rv1BTL+oyikCJ8on0VfwrWFLWl9X4u60va3rBWCsft7mNuRA3ZUZs2y3Hb50?=
 =?us-ascii?Q?87lTdf4zOpBS29PawgaatFBYpuUFpAnRNJlYhcWS++bSqfL0zJBi/Ul3C18B?=
 =?us-ascii?Q?/zQFvr2cA2MbNSXztnQ2OmIVt5wQhVPnl/waj+MDCeSC4ta9fMwPUCxooxVF?=
 =?us-ascii?Q?1OBajDoF8KCY2J6cFEHHQtWdWpJctmdRPybiYksA7/Zyw4OEItEvbGmfCLGb?=
 =?us-ascii?Q?kKOQw+u307dyhqzB2yAeweqyC8Z70UssMjteKd3+W+UrHMVFierQxBAqyeej?=
 =?us-ascii?Q?CgpJpM5MfxVULmKx6eWdn9tNVBcGQmp0IjdZHiDxS7MvExycqaPqCU03vVVv?=
 =?us-ascii?Q?auWJlYfnPVaNkVDPiLMFmn5AKKI5BHOtw5SmPEog1w3gS0OeZ3SYcc3Vsziy?=
 =?us-ascii?Q?F/PGNW2BMb+G9sfLgdjMEty/qOHM5NvrzJvGMatI56WisuGf8/d4o7fiTiW4?=
 =?us-ascii?Q?uuqYiso8C94/weGObdFry9eH7rCSdmKapyM7Mk781meQPtsZEZ+3Ei4N7TTb?=
 =?us-ascii?Q?tfG/NsuFkEC0a3RSG9vnGwartN+wqWeTpW9QOpSKvVqd2kDQYmXsnmDHMHG6?=
 =?us-ascii?Q?lt69enymhFjmWkMzZkKJILoMh0ILC98VeW92+Wh3HG0+nOk72O3ZcZy4kwz3?=
 =?us-ascii?Q?g9K8+04gTvelE/DQKQ5f26XcI5ilg/X3KASj1exLLawFN2AdZVva7Oa1g7+I?=
 =?us-ascii?Q?3UyrRwc/jZ16hdC98aJ55OG8wQtWz8KFbyz3R2BDGVKXMQlz5SXnx9/mPoJ9?=
 =?us-ascii?Q?d3pykt42rcfIg3FmWkOxBoUaEqK/56rHSY4BRpBGkNWkxdZhjjEk2w/H4zj9?=
 =?us-ascii?Q?6LSidQXNQgyZo7+/PsIzoZWKNqkFivsVaQFORIWXAwVwfrroTL5yQbKOIm2L?=
 =?us-ascii?Q?qPncXw+t6TLo8hfQ9J6zV78qjJAfYmHgJ1kV7HLQL4kxP+T9PA68QeAdHdgU?=
 =?us-ascii?Q?MflvpwZvgcuEQ2EIr/k6ayf2IQ+WYSOeOENduDoQMEsYnmYQxmKNuY9IL4VC?=
 =?us-ascii?Q?8yyWV1rehip2uKBQEhPmoLIsVi/iDYO9RIEw/HQ1/ghXbIpx+jyBz+3bAmKW?=
 =?us-ascii?Q?YuyAJ+n86Aa3U5UfCDPvB/UJgsMzXEHRc8WXuVZciwqeQoguc2+c89uM3GzW?=
 =?us-ascii?Q?XQJg2HTns7AXd17LGul7ioxL1qVjg6HNNRYix4ayGzstF9O3I52KhkIIYC8a?=
 =?us-ascii?Q?JWGNxef3lU6PNFCRAPC0tzw4dIVzs1ebfi9in8Svlm0kefulXseVkj+NA1Rc?=
 =?us-ascii?Q?3PSOzq0pBcDLZ+TcSVDSUYLsBUR5Z4YJGVcaBD8JCTfRBiGJVpkY9PJWWjRC?=
 =?us-ascii?Q?pqKTklU/T3oG0UlZdpxDo7I=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba58b59-8fd6-4260-23f5-08dc9cfe49d6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 14:25:15.6055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9k3QISlS/5NOAx8SCep8kk4X4rCd4eWfr/ReitpQNMxoPWSMpoUjdMwzTgYmAS/ff/zbsM4FRYMat8jxkL1z6GWkOMyHr/RgzLVMYq5N+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5978
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

Make use of the spi-mem direct mapping API to let advanced controllers
optimize read/write operations when they support direct mapping.

This is a port of linux patch 981d1aa0697ce1393e00933f154d181e965703d0
created by Boris Brezillon <bbrezillon@kernel.org>.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 185 +++++++++++++++++-------------------
 include/linux/mtd/spinand.h |   7 ++
 2 files changed, 95 insertions(+), 97 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 62c28aa422d..adc67d7a40d 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -37,21 +37,6 @@
 /* SPI NAND index visible in MTD names */
 static int spi_nand_idx;
 
-static void spinand_cache_op_adjust_colum(struct spinand_device *spinand,
-					  const struct nand_page_io_req *req,
-					  u16 *column)
-{
-	struct nand_device *nand = spinand_to_nand(spinand);
-	unsigned int shift;
-
-	if (nand->memorg.planes_per_lun < 2)
-		return;
-
-	/* The plane number is passed in MSB just above the column address */
-	shift = fls(nand->memorg.pagesize);
-	*column |= req->pos.plane << shift;
-}
-
 static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 {
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(reg,
@@ -245,27 +230,21 @@ static int spinand_load_page_op(struct spinand_device *spinand,
 static int spinand_read_from_cache_op(struct spinand_device *spinand,
 				      const struct nand_page_io_req *req)
 {
-	struct spi_mem_op op = *spinand->op_templates.read_cache;
 	struct nand_device *nand = spinand_to_nand(spinand);
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
-	struct nand_page_io_req adjreq = *req;
+	struct spi_mem_dirmap_desc *rdesc;
 	unsigned int nbytes = 0;
 	void *buf = NULL;
 	u16 column = 0;
-	int ret;
+	ssize_t ret;
 
 	if (req->datalen) {
-		adjreq.datalen = nanddev_page_size(nand);
-		adjreq.dataoffs = 0;
-		adjreq.databuf.in = spinand->databuf;
 		buf = spinand->databuf;
-		nbytes = adjreq.datalen;
+		nbytes = nanddev_page_size(nand);
+		column = 0;
 	}
 
 	if (req->ooblen) {
-		adjreq.ooblen = nanddev_per_page_oobsize(nand);
-		adjreq.ooboffs = 0;
-		adjreq.oobbuf.in = spinand->oobbuf;
 		nbytes += nanddev_per_page_oobsize(nand);
 		if (!buf) {
 			buf = spinand->oobbuf;
@@ -273,28 +252,19 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		}
 	}
 
-	spinand_cache_op_adjust_colum(spinand, &adjreq, &column);
-	op.addr.val = column;
+	rdesc = spinand->dirmaps[req->pos.plane].rdesc;
 
-	/*
-	 * Some controllers are limited in term of max RX data size. In this
-	 * case, just repeat the READ_CACHE operation after updating the
-	 * column.
-	 */
 	while (nbytes) {
-		op.data.buf.in = buf;
-		op.data.nbytes = nbytes;
-		ret = spi_mem_adjust_op_size(spinand->slave, &op);
-		if (ret)
+		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
+		if (ret < 0)
 			return ret;
 
-		ret = spi_mem_exec_op(spinand->slave, &op);
-		if (ret)
-			return ret;
+		if (!ret || ret > nbytes)
+			return -EIO;
 
-		buf += op.data.nbytes;
-		nbytes -= op.data.nbytes;
-		op.addr.val += op.data.nbytes;
+		nbytes -= ret;
+		column += ret;
+		buf += ret;
 	}
 
 	if (req->datalen)
@@ -318,14 +288,12 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 static int spinand_write_to_cache_op(struct spinand_device *spinand,
 				     const struct nand_page_io_req *req)
 {
-	struct spi_mem_op op = *spinand->op_templates.write_cache;
 	struct nand_device *nand = spinand_to_nand(spinand);
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
-	struct nand_page_io_req adjreq = *req;
-	unsigned int nbytes = 0;
-	void *buf = NULL;
-	u16 column = 0;
-	int ret;
+	struct spi_mem_dirmap_desc *wdesc;
+	unsigned int nbytes, column = 0;
+	void *buf = spinand->databuf;
+	ssize_t ret;
 
 	/*
 	 * Looks like PROGRAM LOAD (AKA write cache) does not necessarily reset
@@ -334,19 +302,12 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	 * the data portion of the page, otherwise we might corrupt the BBM or
 	 * user data previously programmed in OOB area.
 	 */
-	memset(spinand->databuf, 0xff,
-	       nanddev_page_size(nand) +
-	       nanddev_per_page_oobsize(nand));
+	nbytes = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
+	memset(spinand->databuf, 0xff, nbytes);
 
-	if (req->datalen) {
+	if (req->datalen)
 		memcpy(spinand->databuf + req->dataoffs, req->databuf.out,
 		       req->datalen);
-		adjreq.dataoffs = 0;
-		adjreq.datalen = nanddev_page_size(nand);
-		adjreq.databuf.out = spinand->databuf;
-		nbytes = adjreq.datalen;
-		buf = spinand->databuf;
-	}
 
 	if (req->ooblen) {
 		if (req->mode == MTD_OPS_AUTO_OOB)
@@ -357,52 +318,21 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 		else
 			memcpy(spinand->oobbuf + req->ooboffs, req->oobbuf.out,
 			       req->ooblen);
-
-		adjreq.ooblen = nanddev_per_page_oobsize(nand);
-		adjreq.ooboffs = 0;
-		nbytes += nanddev_per_page_oobsize(nand);
-		if (!buf) {
-			buf = spinand->oobbuf;
-			column = nanddev_page_size(nand);
-		}
 	}
 
-	spinand_cache_op_adjust_colum(spinand, &adjreq, &column);
-
-	op = *spinand->op_templates.write_cache;
-	op.addr.val = column;
+	wdesc = spinand->dirmaps[req->pos.plane].wdesc;
 
-	/*
-	 * Some controllers are limited in term of max TX data size. In this
-	 * case, split the operation into one LOAD CACHE and one or more
-	 * LOAD RANDOM CACHE.
-	 */
 	while (nbytes) {
-		op.data.buf.out = buf;
-		op.data.nbytes = nbytes;
-
-		ret = spi_mem_adjust_op_size(spinand->slave, &op);
-		if (ret)
-			return ret;
-
-		ret = spi_mem_exec_op(spinand->slave, &op);
-		if (ret)
+		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
+		if (ret < 0)
 			return ret;
 
-		buf += op.data.nbytes;
-		nbytes -= op.data.nbytes;
-		op.addr.val += op.data.nbytes;
+		if (!ret || ret > nbytes)
+			return -EIO;
 
-		/*
-		 * We need to use the RANDOM LOAD CACHE operation if there's
-		 * more than one iteration, because the LOAD operation resets
-		 * the cache to 0xff.
-		 */
-		if (nbytes) {
-			column = op.addr.val;
-			op = *spinand->op_templates.update_cache;
-			op.addr.val = column;
-		}
+		nbytes -= ret;
+		column += ret;
+		buf += ret;
 	}
 
 	return 0;
@@ -815,6 +745,59 @@ static int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs)
 	return ret;
 }
 
+static int spinand_create_dirmap(struct spinand_device *spinand,
+				 unsigned int plane)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct spi_mem_dirmap_info info = {
+		.length = nanddev_page_size(nand) +
+			  nanddev_per_page_oobsize(nand),
+	};
+	struct spi_mem_dirmap_desc *desc;
+
+	/* The plane number is passed in MSB just above the column address */
+	info.offset = plane << fls(nand->memorg.pagesize);
+
+	info.op_tmpl = *spinand->op_templates.update_cache;
+	desc = spi_mem_dirmap_create(spinand->slave, &info);
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	spinand->dirmaps[plane].wdesc = desc;
+
+	info.op_tmpl = *spinand->op_templates.read_cache;
+	desc = spi_mem_dirmap_create(spinand->slave, &info);
+	if (IS_ERR(desc)) {
+		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc);
+		return PTR_ERR(desc);
+	}
+
+	spinand->dirmaps[plane].rdesc = desc;
+
+	return 0;
+}
+
+static int spinand_create_dirmaps(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	int i, ret;
+
+	spinand->dirmaps = devm_kzalloc(spinand->slave->dev,
+					sizeof(*spinand->dirmaps) *
+					nand->memorg.planes_per_lun,
+					GFP_KERNEL);
+	if (!spinand->dirmaps)
+		return -ENOMEM;
+
+	for (i = 0; i < nand->memorg.planes_per_lun; i++) {
+		ret = spinand_create_dirmap(spinand, i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct nand_ops spinand_ops = {
 	.erase = spinand_erase,
 	.markbad = spinand_markbad,
@@ -1112,6 +1095,14 @@ static int spinand_init(struct spinand_device *spinand)
 		goto err_free_bufs;
 	}
 
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(spinand->slave->dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_manuf_cleanup;
+	}
+
 	/* After power up, all blocks are locked, so unlock them here. */
 	for (i = 0; i < nand->memorg.ntargets; i++) {
 		ret = spinand_select_target(spinand, i);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 13b5a52f8b9..5934b7604cc 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -363,6 +363,11 @@ struct spinand_info {
 		__VA_ARGS__						\
 	}
 
+struct spinand_dirmap {
+	struct spi_mem_dirmap_desc *wdesc;
+	struct spi_mem_dirmap_desc *rdesc;
+};
+
 /**
  * struct spinand_device - SPI NAND device instance
  * @base: NAND device instance
@@ -406,6 +411,8 @@ struct spinand_device {
 		const struct spi_mem_op *update_cache;
 	} op_templates;
 
+	struct spinand_dirmap *dirmaps;
+
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
 	unsigned int cur_target;
-- 
2.39.2

