Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE4DC87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 23:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0693583865;
	Thu, 14 Aug 2025 01:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="NmyG87HM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D1E983873; Thu, 14 Aug 2025 01:43:34 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 201DB8381D
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 01:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1u5Gj+QIVSSI17hC85VM8PPliZAc8qRS0bZA9+5WoZuMnJS+UDFqIZEVSQyKmK28E5SqL3t+8XrsMqSej2AnAS9jLSd4FXlcQ6OtjjooxVKWpBz4mORV5ImFCg69xzxacP4q0kPph6z126tFwr8oK9daasYKykdR2NKDRpE3fwoLbQtEiPRr8+vv3TBy1yTK7XFJ7DREO7Mq4VZ9EwaLvxP7kEDZEaXlq6hE2OoeX1hQaiYSStjro3N7L2KUHmVqWS5Ax1cWnLMUhQATN7hrdTGHcKH2DRlht4bvnRqrhczyQp+hbQndDkdYN4AyLUAC1LqNNuxGamjj72r11+FHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rD9jvpJjO0f2GmImSQaJIkkjnQxG4I7Rq8AICxZjflc=;
 b=mWzjRN0gVjzS3R6JgBwx92577HyL0vkTVg5KuaDE5aRolbxSiap0d0qk24G0jUR4H6FTJbKPuPjy6igrChxA+JQB9z2wA7qfTqBJ2PRvKRv3Qq0ZlJYRFV3ab0qyK2XGWK36tVOjT4ncWuekzpaV0kb1DUOH1PP/2wY+rwpwB0MWSMa9nvI33FlqkSbOSJKt1LXV1XCLkPlGx4lKc4N8T1bmM6lrY84trnE/Obqd0FLS/4+ezU5kbuRMIWcy0Bnqb+inaGGwOqo2KgJDMCi/9WoMgFIouwZ8CpY4uFB+9DE2LIIrZKAh73c0+3FBoOX+kpeEfo8lshOgH0SgTzdVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rD9jvpJjO0f2GmImSQaJIkkjnQxG4I7Rq8AICxZjflc=;
 b=NmyG87HM5VXCNRx59ZRnEcDl/cN62m/vtBzafyfzgmP3C1cFkV5YWzsoVwVesXNOKhf5FFqthtj/1sDjQ7jR/F55wRV3oZ32RB8dmW7KkYnerB2IuiRas/Pq9rzoHC/caov1r/KuWfznrIpZKHk30sZZN5dTQKEpXdEeuclJw1qJqNMdp2zJUzPQih5nSFo6fkd+y3+box2si+3BujSVzhM/owheorYDruqikFPZi0xcRa08es3LlGQcWMZRM+CP6YTYAVivTuGtSqco1DOmBYDEbJ9S7+BYrp7LcFW7D48ozPGkLYi63RotENzma7T9m5C/OEEv5UMOjyG4U1Uifw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11021.eurprd08.prod.outlook.com (2603:10a6:d10:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:43:31 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 23:43:31 +0000
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
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 06/21] mtd: spinand: Make use of spinand_to_[mtd/nand]()
 helpers
Date: Thu, 14 Aug 2025 02:42:59 +0300
Message-ID: <20250813234314.3945708-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|FRZPR08MB11021:EE_
X-MS-Office365-Filtering-Correlation-Id: 60723f43-b0d5-4ce2-d8c7-08dddac33581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?67DWekn0tDSLyKptPQm5IpB5x/LZ6Xzbakj2iH8jAkPU0UE1TzgkYU6Gk0Ak?=
 =?us-ascii?Q?SFDLahBqJIwrEF9taogO0W7TWn5jAFRA6T4YGMNfRuc+CjZl1jqvL8fjgsGi?=
 =?us-ascii?Q?/7LSwE+f2mz6M5i82CDE3dPEDpq4HjrJWxR+XyFs2eAT7SiVGGokwouhT4m4?=
 =?us-ascii?Q?3VT4GrM+ZE3jXjgh9/N9HwwfpCeh2hx26dunYbY9iAEqfTUgEJTILFEDRA0k?=
 =?us-ascii?Q?AQf24IXcnpejJ9qjjfFrNIvdHgpNxPlHi4rbw/3B/qLUZGKGcPydOF26ewb6?=
 =?us-ascii?Q?EOKiFEDMH2WEib4DWsQ5I12gfsMQEd+a9eIMprmoCzqPY1D0udwcjdAbOaS5?=
 =?us-ascii?Q?G9io5Ncayf16EnRKVMqF9S/KNPH95Q+z70SW5eqzYP7yN/IqbLaZfxbdzAhh?=
 =?us-ascii?Q?sSCxYfUGo5f+9XFMosMNeJACwGVqTWWIXETNmgcbroCDAQLw7ipPU8lPp4Oy?=
 =?us-ascii?Q?OkeYv45HN9HMq7wBc/grruRbjmB/6i99+xfA8n6QD2QkR/85GuIgIEIYM1yQ?=
 =?us-ascii?Q?Wb/rw7KaDyNBXWxeyh20AW2lVjt87OL7wvkU3t3p2gPL7jaBjcrOA7rMEiDl?=
 =?us-ascii?Q?iiYipg6vQB0SWjiyU6Br0HZLzEK1wzCX3m7PVTrDJC2LNDIRsvwP3ZOZ9PF8?=
 =?us-ascii?Q?PdIYq4+IkxvZyhmi18fADfTt7Iq5AMhLruyeyRfbR2aYK5IkpSA6xNeSoTv8?=
 =?us-ascii?Q?/8a9EVCwc6tLcZzeLm+EcW2t4EcasPJ1PdX+iEjmklA0LOqSWl9LmRd0Uf2g?=
 =?us-ascii?Q?tKtOyfuFQhsoS9DTi+MPC1ehiIR9zWXiddqPKO0nsRPdKPcM99K8TBX+ta4T?=
 =?us-ascii?Q?TQE2t80XQ+g2vI/6DfwPOUC0fPj4pTJ8AXacsw69VCJ1hGvrpjiYQS7ZCare?=
 =?us-ascii?Q?VS3eYE4E3avWnD1AB0fyFYak2pcy181Q6FD1Ixs0Tvqx3SKQjTSNFTaUFTQn?=
 =?us-ascii?Q?6Q28cEVHDXmC11b7Nlrx5CYtUe6LwqdtjvFckWIBXSHrOgVy5vSf7CZL4T31?=
 =?us-ascii?Q?0VV79asQ4oqgZ3vxQScb1oLO+QIqJ0f4xPi2VwMmZ1b00JY3KBeR63hHRIpW?=
 =?us-ascii?Q?isTFzr0ISFAE4gzdRunsgJ6DFOq1bOv0d2VB0ZMng+uXwhOsMZeUsjQ4vYcv?=
 =?us-ascii?Q?ttIn5YwGVf8nTI6yrutCqGzLvCL4FQ/btRbv3hf1tndlpojFhQn4MatDdKCy?=
 =?us-ascii?Q?VvMoo/G7YNgymS6rUmGC/KSdZQ86sJ8KcUvXkRH8rBAAHrrDOf7QMvrpkeOn?=
 =?us-ascii?Q?5qeUP+66/q6zFR0Dg8P2rbMjp2tYmDyMoTDE1Tvxu4SN3sleNhz8/5VIIYoU?=
 =?us-ascii?Q?jPo7E4jH1MugIFnD/acanaKfr4hJ1fvos5t0b0Tz2/8/fBbZCGh8I+8JqBDX?=
 =?us-ascii?Q?ZpzPR+M4lofQ4mv3yuFSv++CIY+AYG99lN9IrpmWXSE3GlPPjVjHNUSQi/ZD?=
 =?us-ascii?Q?H4/fm3uaC3vFazEgsjR0KdzThBHLzfhNhKkGYW8MJ66fqx0DH1RKlcjFQUZ1?=
 =?us-ascii?Q?XFhYXjZRXWUnkYo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lXhn0wE8bB3TT741UWEd49vJ4CiHP9F8diLvahSCPqoyFNOgpi6D4q8RSUvQ?=
 =?us-ascii?Q?O0pigwK3Zgebe9Xju5jrIKGe+CpX2U8e6lx7NHNQZeazv0YfNWJ+SY3T9QGV?=
 =?us-ascii?Q?d+thQmiqm6DHQSQf86/qHN7l9t6N9tyl+v27G36+qMftM/w0VA2kDTT+DUAo?=
 =?us-ascii?Q?BfkE0lCECUGqo35yF/sFQVLUhaXobDyEekKUcyBCfVwvSDcf/mPXvXg4a04a?=
 =?us-ascii?Q?jqsrZLrhxYqegqoOSxlQE+pAqcaDcpuG2E+6zMx7d3Oi4VTqpUNxocDDiK5v?=
 =?us-ascii?Q?hh9r3axT5l0OPI+4aqGAf2wkTMZQHU5iGbqq0zyN6jyjvGtXnQFPythzgXA1?=
 =?us-ascii?Q?zXLFMbPMKYSll+g/5dYIdcTFv0SDXkCrYUxgzAIKUqw0wTE21//jdFYgX2mh?=
 =?us-ascii?Q?USJBI9uDtyF05uRJuuI/obDzPds/EYJXRfrohratvTgmqhZ4vSgoGSVivaPK?=
 =?us-ascii?Q?uof2GvIDB2eVTtklObK/3vyg52yF19F/qeW8sBAfgUdCqmmSuommTkiLuU+U?=
 =?us-ascii?Q?6UO3rYwywIPPlBLFAnyiTSHYXkVZWkFLkS9PTG0/kn/0oYavKAbve8qjBI6F?=
 =?us-ascii?Q?uVdFU/0X+aGOsqHLLL9CexzirYeNp0ce5UMU9ABx/5nS7NV1ehaG4pWrUULe?=
 =?us-ascii?Q?yv2URlghAoHNP+S5A6gkTl7KXxAuhOQ1i3/TQO1xq4Kwi3ucBDULHlO4ps02?=
 =?us-ascii?Q?spc58t9lqThIGMzTkPqjT7+i4A7uvTXhZfip5FecwzuyOgUKXP5hwcyLCU8l?=
 =?us-ascii?Q?J1YF2F7rLH2yREvENgW993vWLJO/n9YgCAKy+g66NlQRBg++LzSCDuHXlfh4?=
 =?us-ascii?Q?ei2gwgBx9TiNBup6x0vLWWpbepVHbjo+nhLwA0emSsoDTeRUdNM7f1jnYrJa?=
 =?us-ascii?Q?So0HkaM6hXBWQaPKwuZiJi3CaaJ+I2+WvlFZCVMwjMea1XYFKiHOy4+36TVt?=
 =?us-ascii?Q?BR7f1QCLpMxr/rMmIKMDfy8F2MMFn6Fqo8CZZDeBg8TJGK5zVDF0c4iNC5WQ?=
 =?us-ascii?Q?GLHKWB7WNP7PaAji5P5j5D3blkGTfVwqscak8EfrjhHskI5I2G33HokIqeGl?=
 =?us-ascii?Q?1MXw00GicQza8mr1FH+9/aiFQAyQamU+T9NfSuUQ9C8CcXte7b/czRmHd/Bu?=
 =?us-ascii?Q?EWTldcnM+usqDox0uxwvzouSxwF+h/5Hub8AP06TW54Pv7Qtb/4D1zhbFfKK?=
 =?us-ascii?Q?eCcq1mTGdj784bpXafK41JiANumaIdFzFT2ZAhbXAK3e6RnsCT2Yp5hscKfs?=
 =?us-ascii?Q?EnjpWcBiWFOgmNHz/rw0q368lSrC6BAwaOkTOPx+Qul84Aap8Lm6kr8wAxDG?=
 =?us-ascii?Q?k2IQe5aG7tdOZeFaWRJc+HpwGBAyQbgUAJuZwhGAIoqnOcHpYhx2ItsKGV9B?=
 =?us-ascii?Q?dmDUtYWBf8VSP7xl6tHU2xvMvA0qHWf1xGhZCLf75/GcdOBjOsY6/BR7N5zX?=
 =?us-ascii?Q?gvEc0h4CCYJDf8JDpZqTCTkT0Om64uIJcgGr9eRxoIdC1Mnnlap+Un3OwCqu?=
 =?us-ascii?Q?7iMeoWI//7WMDsJJtV4gHZz3GGoHyXK3XzpFftf2WV2xrP2kIH2MeaEQdyCj?=
 =?us-ascii?Q?Gcw/mhGsU5omrGOIn50JKpNslnZ3ZvPBv/TSFK8lerZO0s+L4gp0tbAkFYkV?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 60723f43-b0d5-4ce2-d8c7-08dddac33581
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:43:30.9137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOaRwO0EucPgQi/V9Z9k3560H/LH0sodj4SIeWKMPr8Doyxd+kyoxOgL31H7YbCuvXLM+TXoAYxFyf+okakxeFTjMtakjFBs/1yyzEy3xA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11021
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
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 3b612bec274..4e8d7444bd6 100644
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
2.50.1

