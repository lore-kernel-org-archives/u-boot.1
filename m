Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD9BCF3185
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 20:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5406989251;
	Tue,  1 Oct 2024 22:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="H/mV0xXV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B20989221; Tue,  1 Oct 2024 22:45:02 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20C8E89265
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 22:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXGLMB6zru7VrOMZO+nAcoFFopu+Ba0gfpRtgNwgbTwL0FMhZT3li7BUnU0irYfk0nBGTtiT3Hi20SWpsjnTJm4RBrzSRnvdGErj1Cv8V+fW52J/ejP0XBlKmy4Dr5cP/eDqfI0YDp70QYxISPvy6wPCINEFvBvun7aNSweyKB4k48ex/1izQN5/XT1ty/0Ca4NfMJhSwBUqivP04sudZTLNQ7eHdX6dOVDQsrCDi+YPW/mj9S214jogGB42lgAIp41D0W0lmVen1H/KuTSYKw4uaYudA5mHjutcrLlRuaQC6iSwfpdAOIxdB2/0SWC0ODLn1PlzI/n2NM3upIVr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Whm5sgNFRFvN7odaDp55Iwpw2RT4l+3JBeJgI/Ct/8w=;
 b=CQYxi4UCytVI4WHeDzql3VMaGWzy6U2W92TctqkSu6RiSDnkDOLRjBCCQZDhTWYvLcJAyKy8Aib8y8ilxz0YZrpybotWN6gVUXXetWa7iCo/PFaH4oasMD/Ygi8m/o0gwq1JD7UFb+Uvnczm3HYz3Oqatc3EOgTPbm2YfLcDwhFs1X77rK08Kbp389m1dHQL1bFFHfQLW3rbblBje2QevfHaW+HTjOUFNxOm+4hR+R1Sdp7PmkjeiKEmTbXPwcMyIq9tyokiw9iD6QtmUyrQmd+RSEw3JLHCXgOHdeTwMoFvsB/u6wUz8CA9KWhq0QI6cbL2VAlpOxC7LqO2t+A4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Whm5sgNFRFvN7odaDp55Iwpw2RT4l+3JBeJgI/Ct/8w=;
 b=H/mV0xXVGHfl58qA+5mGz3R/rC7qA6OerA1nydDhmJD9XhiMy9hlCPV53x4qrMUC3u5jx0lxFHXfgOo2lbskp8G80VYzjeVq6gg6Ql2YOjzPzFetOZf5nEDW+Hq1cuxOY+D6rsS+fZHw+7tOtPLgJn8gPS7Hfd+IkfKWMJcHbgepb0OGMiFInA3j+t0bNe6IfFVig/douI+Jc/gCQA91YMDHQ5yxpICbsPjW8+HTHZTvhCAbCVEhE7B92ifLoRauP1JbQlKBELz9xpz2Xsh7os1c8vxigeycl0cgWyHOVWPhXrz80sFokqEIRCXZfQGvsX+lG2ZZiK+0ex/t8jRrrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7812.eurprd08.prod.outlook.com (2603:10a6:10:3b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 20:44:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 20:44:58 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 William Zhang <william.zhang@broadcom.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v4 05/10] mtd: spinand: more use of
 spinand_to_{something} helpers
Date: Tue,  1 Oct 2024 23:44:37 +0300
Message-ID: <20241001204444.917238-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001204444.917238-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241001204444.917238-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00011B5E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:16) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b081663-c641-4a9c-ed6b-08dce259ea0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kf/v7RAo0r8V+SfVF8gpajAzfJdxUgcg388zIwby4tD4pW1f9DBDuRnc90mJ?=
 =?us-ascii?Q?8M+GdL0eT2J94BkC7by5yWvjJo06utLctS38IHTIu+YZ3egcfGnjmTaPz0Lm?=
 =?us-ascii?Q?BFwzK20ms+zV2aUh/U9dpfP4yzt+EkCSUlMU7bV9GDBpfKOJzUQuZxWMdGyb?=
 =?us-ascii?Q?z5C5TIPg0HYoBKRMJs3MpkuR/B2F+IcEFYxkXI6F+BRo1qvQxMTfZkfwb4tJ?=
 =?us-ascii?Q?zsZRxctk6v9ovFUXbgAjuQXOiwjFGt2XXshXypS4aYhiDdckzb+l5juyw6tm?=
 =?us-ascii?Q?uGzaG1PW8JvE+9FX1zIINIdknm+Gr+7lfy7Q9ZBcNVZllinz27hIYjV/dHVS?=
 =?us-ascii?Q?dkWhEzdjnjhSlRccYgZkFGXwxPOK93TrIwtXQmKYXXDAz7TydTHhVjfpxPto?=
 =?us-ascii?Q?zdCzvUj7uB4aMdWQVzNu8AmMl26hhHD09Ubl6czZ/ZNPjpGT4YnetIk1HXaV?=
 =?us-ascii?Q?rgz+zBgRn+JYtK24JK1M/Wno7tl4gpcO/DUMSFyT/WjmLaJaEneAFRh6ASXv?=
 =?us-ascii?Q?H84mUJrAyYec8yVk0TtPoRqPqjwe8uaHuRxnAJZgqwLfRenLTd6Q0cAe/IMK?=
 =?us-ascii?Q?FrvoGn0lJiTqcTn7BcZsWemhYt/Q0nmmGC71h/N3NBzS/KzRhIIKlyt1vzKr?=
 =?us-ascii?Q?i3YqkoQ24kZocNUlWzZutLA8NDjtwzHZHzlZkHYuCunH7tLPuUMr0mppKwve?=
 =?us-ascii?Q?bXKK5a7JjDsffRScFvHie8doya1B5NrZTmun/FfZr7cOf1sohaeKVMwlkJsE?=
 =?us-ascii?Q?RoPN8zTXTofDZbitvXuZfdxIGbVarsfSpd/NGM/hu58LpvbvDWjnplVmj2Wx?=
 =?us-ascii?Q?CyjrIhU8QIT7DD2RnvZ1LKVz/LoqMTI4I+oQ4zqK9PVXKpM5RO9qJTxmh0Ds?=
 =?us-ascii?Q?1NJgBBqhDTGT3dcA00U0rqb+tS7bxeZxYxszrZtc+AZ4eRRoUOVDpbj/Yy4l?=
 =?us-ascii?Q?rqzMdC7Shtmtbjdbc7774uo5/jMV9yrdfb9E2YSGXQQjEcviFIBU7hvJiYHn?=
 =?us-ascii?Q?F1OF7Lz6wpBEhxuRIl5OLIoCk0Ih2fUqHnUKvuIZcRoOIwzxATaB39kWMb8w?=
 =?us-ascii?Q?gzKvJq+9lGj80Yl2zMsUKBgJThcWVPoZrXIknRw8CbSIxgEqfiZsdeVGuYl3?=
 =?us-ascii?Q?58AgoEx6tIs8f0KEE4JEBqTdjQJyKPEzKpVYMGj9ozK3G7WfiWrl1Qh4jTMY?=
 =?us-ascii?Q?85lGLoQGssm82ZzbrAa9sQB0MfpwvVcP+7pCrUu9dMxt2Zgd1ri0tCJlLtkp?=
 =?us-ascii?Q?Am+hCd6L0JS4iZ8/YhgJ6xGyFnJV3FwU7+Byz7Vnrn/43CWqaGapovbYrL+E?=
 =?us-ascii?Q?T53HEQYDI+FldBgjWaByq2okLXmRJVWD14or0WyXGNGsk81Ukf2P8oMvLg54?=
 =?us-ascii?Q?5mUW8yc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JY2q7xk2pJ1SW10qQcswYctLtDn2v5Pa6dfGCM9opLpttL3qFbnTNUf/D6Zi?=
 =?us-ascii?Q?JwkOiNpFzAjFO0XCBdw1Iti3sqE2gep/U4SV5c+u/LW+SN8G9Gvh2qiL8Ytp?=
 =?us-ascii?Q?I/LNlUQFFkpxew8ASEk7jEnRwittRUeG8U+yYgf8STjXnjxA3f2A961DCgYj?=
 =?us-ascii?Q?SPN9FjOsAdTapWntXBcMDWHzq7YPN6BjZEOyY5Ly+ff2+pCHTAEpiGrdBbMH?=
 =?us-ascii?Q?iVAmudFt+HA65gzIE8LFwVREH+/KdWJxBzyK1NuLvLAGYgrgwQlHqg4dMyxt?=
 =?us-ascii?Q?+ztAAjXhvzqauAXDLapCDVo3pA9Kp27EVMTC01VoAo/Hu60V/QdKq+UEsrsE?=
 =?us-ascii?Q?vbuq44fo9JNdSUKzcQwEP/ZjG3DUzaBJwNKuNkZW30+kUBXU+CMRD1ZcnYtR?=
 =?us-ascii?Q?iraxp/akp/flqvkal+GOaWtEGk6gjX+7UStlUl27SvVasike4YlM6Cmu2mra?=
 =?us-ascii?Q?/R0wpRjk9QWIDL/qvAncOLvAiuDyXK9MNLjv/KFsLgIAOq+ETRWwlPnKxC0w?=
 =?us-ascii?Q?K2mXe7Iz50h8nwtgjIHOnTOx3wEKk6Fuof0nn7gd5BNfHiTRkQfxF1K48HE0?=
 =?us-ascii?Q?bUHM3tBEii7PN5QzBwmzRNJX65gtCflsJeh9s0Sp85RKWfzGGmqK+bh1Psdj?=
 =?us-ascii?Q?1sooMrmGxEoLEExSlWp1k/cZQ5vTDbZrw8Uxby0ADUiu/gsUhhk73QHMh3fr?=
 =?us-ascii?Q?HuKzwCn+RbQTUFMHa9KnPUoc5CKsM8+V2pbzv6FPUGMETyb6iTw1quSmm9ZL?=
 =?us-ascii?Q?Z3QFi5oitW6VakKNg0eaXrMDrqz9nDYM3x3qyuulFUEPoVDqjxH+RmsXx7r7?=
 =?us-ascii?Q?thXjx0H/sd5svzTHNKTONQLafqZZ5y1sNoXQVP95BY38NfZtCInc0leci7UB?=
 =?us-ascii?Q?Kkyq75J9PojRN/Itvelc6qRwO6UJo3qhMpl9rBlpqu2UWyEUTXOLHaOURMBt?=
 =?us-ascii?Q?JI7qpUifdd/9ppVF/7Z0/9/Wi7XE3dS2MjX0KKjRnJJnMgJjyuCno3D9Ou9z?=
 =?us-ascii?Q?q+yzNCPYeVEIqIMoAwNnc4wAjBe0zz3Wkrj/mOfF5yVHwu4IoBmqEb3WngeV?=
 =?us-ascii?Q?dVYjAwsEn9GJuvcYkTzbC3sfbGWF1CXB2TUNXkGw3uo57CXwPTdsP+cuSdnW?=
 =?us-ascii?Q?lglekDcaPYg4spkGfh7H3cZw/eSNGfVYS8dE2vD7haEbEXbLzBQgRQUBhwHu?=
 =?us-ascii?Q?mwiWp9bQO/JPPt8vtNKwVEZ14uN6JtuGPt5VTNx+8lPs0vnp19yY4NMF3d3w?=
 =?us-ascii?Q?KXyNOzpm2XZhl8s/4FiDR3mcyMVORM7lKN1Cy2+q6KAzA2wn/aAPASlUdIyJ?=
 =?us-ascii?Q?w4mbC2ac5dQBcRfQGhUl8r9Wgliwbu+8sChF64YH+rq4+N4X313z0tUrNRbn?=
 =?us-ascii?Q?hPHWJm6Ihc2aIlGaljTbNTG9iaV6oXEvJX7l+ekHoXF8Y1N3CkzVn3pckoZT?=
 =?us-ascii?Q?C8tT9sNXG1+HOvw9EwPt9DK9G2uW4zYCLYSgSG/1x5SuDJWDpx7DUkzh9ZcX?=
 =?us-ascii?Q?/H/Fr4qj/YQ4FHUnYaFCseAU8qN8aLVs7uAIrN/0JZAcSkpdxGoDD8E4CQ6P?=
 =?us-ascii?Q?3YynYHnetTENW2/sd1TF3HWGaq5VCbxA3KXV1iQpnPRlGVdO56ADwl/ApG32?=
 =?us-ascii?Q?3VKq06+x315xat1zjbT7Sdc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b081663-c641-4a9c-ed6b-08dce259ea0d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 20:44:58.8087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYp/VW4VAzXOMb1HSuNUz7e1+FAAQXystLrGr252P1YfI17LEpFq7AjzvLWPw4dL5ipJq6t9VpNbD1lzgzVahHFkqaOcW31xatyjSLMDfa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7812
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

Use spinand_to_nand() and spinand_to_mtd() helpers instead of
nanddev_to_mtd() and direct access to spinand structure fields.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index a10605487f3..b58d9e00907 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -236,7 +236,7 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 				      const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct spi_mem_dirmap_desc *rdesc;
 	unsigned int nbytes = 0;
 	void *buf = NULL;
@@ -294,7 +294,7 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 				     const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct spi_mem_dirmap_desc *wdesc;
 	unsigned int nbytes, column = 0;
 	void *buf = spinand->databuf;
@@ -356,7 +356,7 @@ static int spinand_program_op(struct spinand_device *spinand,
 static int spinand_erase_op(struct spinand_device *spinand,
 			    const struct nand_pos *pos)
 {
-	struct nand_device *nand = &spinand->base;
+	struct nand_device *nand = spinand_to_nand(spinand);
 	unsigned int row = nanddev_pos_to_row(nand, pos);
 	struct spi_mem_op op = SPINAND_BLK_ERASE_OP(row);
 
-- 
2.45.2

