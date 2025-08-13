Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862C3C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 23:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E8BF83906;
	Thu, 14 Aug 2025 01:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="2scpra90";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B78F83855; Thu, 14 Aug 2025 01:43:48 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DC07837E2
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 01:43:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZUHNpKxr040zlvXF7UaKGNdAe5rwngHsljtDhUFgiWa22J6kU7gzN5BmeCm5hG+d3v7ZPCWpkNThG+JX06uK5dMHcWmulUIiF+pT5VeutK0WPncg2YE8R1WZhg5ay5EEozz9/qCfsxp7U3lThpQWGFnPp126QXlt/zneBz6IuX0ShcV2LTzD48w4gJgLG3rv5k0A4yygCoHUpOfGN0lYWvTUqIjFsD+osXoJAWroMIQcpihRprUvwGtpDZFkPTF8zGpYzJx4loy7Y5Exmr2FHTKyppkK1hbMrij4fb/+RZ4RkJjAiVmfDpM/UDHccsyKAXiY9oey+JWwqWZf9/n7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZUm/fa/x6+fmOLxtcEFDsouenvz7TdWVvZcTmKDOus=;
 b=BLxyFso+lJNl1rn118c/dKNumbmCb+lBK1ooo80zwHAx6Gy0i3ZA27Fh0ynKtNpZQtemx6MOJQABU9nzqkiEXWZ9g4kkEcIdgwBVtiurk59ea48hV3xKHhNxaBFQdAnHJEsa63dEAdP0D+yA8Xc4ETy9GUWqYr6q8i8I5xLsXu3T2R2ddG5fvKEWuVJbaMP9djj3fUvCCtUe6DAoqcE7W2QaUq2TycpETzXdDEbrBPsJ3cTRS7WNLwDuOVNO+FzWW7QWY1dvh1YoOzNIlSch0/J9x7oLiOH2mplV2fVXtcEDWWXneXfrs6ktYl2oGzFWIoPK2/1A8n41eXOmXhcVHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZUm/fa/x6+fmOLxtcEFDsouenvz7TdWVvZcTmKDOus=;
 b=2scpra90af3vhgkh5CKsBfp33avE3Fg831Y6enb0k58dsClhRzwmB6LOKkXTryvaHgv98NyQhXINYhnBnfDzFHoCiBGz7euMqypCgE0dARkHKJbWhcVroISi05zWsv37rsXV0IboPtEyfUlAeY9Vv4c/l8T8sS0TK55fOnpQDI28CPnNaLnb3lnkXPsm1y7/AWRdxbbx7w+ZOmhwwHRz14jf4oWSSJMTAXyK9Tt/rUYtvuTZYTtGxWhXgl4z45rC7eikOgKdaLZg8k7f1rO8e/YGJrpOnj1FXwigXjaHSQ+A5iWaMNZTzkHaZJd/No0jZF1YBnM9kLRMnGxvHqsiMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11021.eurprd08.prod.outlook.com (2603:10a6:d10:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:43:44 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 23:43:44 +0000
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
Subject: [PATCH v5 16/21] mtd: spinand: Add read retry support
Date: Thu, 14 Aug 2025 02:43:09 +0300
Message-ID: <20250813234314.3945708-17-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 64d8f4eb-4a8c-4853-8aac-08dddac33dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IFfMgPQqHbLIRcEYNe7++8twJv/PAiZKLG8sBY1xO7Jc90vunxEqDFhIgKcX?=
 =?us-ascii?Q?kausx3W4XqMuDnISuGu3dP3A3e9yPwmsvrCMVGuZtm1ryfUQ+kfl6BiqFEjk?=
 =?us-ascii?Q?VBlmooU8gk7FL5myH1tqA/D69ftF/vcTNUYyCYCYGOOmV/pOlxMyCKUqMfef?=
 =?us-ascii?Q?b0Wb/Kpttgutlwv/x8S70B9fFTBGkR9hL7JTxB2BLDacAtmlXiax2VyyhHQj?=
 =?us-ascii?Q?NYc1QDKduPHmDpq56YzZnTPyIDi0e6CadkMBc2WJj/ZLMwLZEh3fGotaCpEP?=
 =?us-ascii?Q?zUvDCPTUdPPiV/ZXOkxzMnHcdQsyCqpw4YQyKvmcwcP05/Wva8cuABoFxvR/?=
 =?us-ascii?Q?Pg5sMeuMCE6nuIVrjT1LBwq9YlAwscjZOPE5VbNc4iFLFqP2fnliPbrNcGev?=
 =?us-ascii?Q?OUcWsvuk9eVFXslB1qQJMsea+6rnT15J8sMIv/7nT+lXSC90DBdgd8Xu7hvM?=
 =?us-ascii?Q?94XBNltK5A/5+C+Nr71COO+J2qjRinaTcLtsgyOYjuC+GCnOAxhyipOL857E?=
 =?us-ascii?Q?LHbsT/gwlFZRp3suN67qfY97VIHdF2hGleJYYMTUa1Cj7poIfBRzB7ZKPSw5?=
 =?us-ascii?Q?VLV8/j57ip+UIUZ1rC8qK37JfNaqqVdiyE1nMq4rSHV6QHxopj7rUch8bbLZ?=
 =?us-ascii?Q?p1xhgGr5t3dRC29WKE8L066+NuIkwp8mpVSiNA684soX3jljl2klUNlcpCl7?=
 =?us-ascii?Q?LKI0BBzSpCK7McuQUPK2mQOh9a7hMG1YyFx5RFawXYsxDT67KGCXsK6jCZzR?=
 =?us-ascii?Q?v9LzID+grZP5+pnOjfh2nEAt+PikXQJmLpE4elh/G/GRUDMnErsLcIKRK6+f?=
 =?us-ascii?Q?jRjP8TdnIEwzBz0VcVoaOVobrQmLQTZDEh+4s+mjvQ4FIE3FuNB89vl5HK3r?=
 =?us-ascii?Q?OQAbsguDCHT3H1uOvIVY5myxhfrI2AJZNhCyA+pk9ohCiO4QPSJeeDlDzPdZ?=
 =?us-ascii?Q?PewE2Yu1kLJ3/Whxdl6sRS4wSJkufrIPrkXJL/rJzD3pGby+TvSvzyT3sYR8?=
 =?us-ascii?Q?xdnVK+MR0T7XnEqQxmy3if/dmxnUXr98wiQRN+GAngKxfgb7phf1KjpuABWO?=
 =?us-ascii?Q?s3NlTk9sXSnSGKye4y1bse5UhHkobC9P7l6AeYFiL7F7IGuFK9bJb0IMq7wK?=
 =?us-ascii?Q?tGdxBnQsb/tWPds3r9QFazL6cw0HfygyEZnaNw/HRdXC1KUakm1gS3mRPlhI?=
 =?us-ascii?Q?dGyQ/T9hgod632bTR5gLf5tAcK3mJGX4ecAqnEAZCc62e0RsMcWhTqU3b8Tm?=
 =?us-ascii?Q?qrpckme9H488xq2E6qVsHiQDL2UmIEmpYKpBqOGTOlvAS2j72hJQLsQ6EjJV?=
 =?us-ascii?Q?iioNlSOdxyhMn4E6BQIca6BXrYzlUyLjYu88Z6U8haqFtFt4ELUgludt3ZVE?=
 =?us-ascii?Q?c8jjfdNUyUjNQCWI3HxY2WPoSBDa2UX69MXZL+YhGNiZCDpIqBriGcehaLK5?=
 =?us-ascii?Q?5kAMoEA2wkT2U/tjKF+DCYZaEhOriNXidw/TyiH09SA606S0yVZSEdI6F0y7?=
 =?us-ascii?Q?fuluVmmud2YHHGY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4z2k5v6mxQP0FRQ0poLyod/rYyFS3Jwe2tCyf+JlnFefiCT3mOJMsCCOHWrk?=
 =?us-ascii?Q?cGCTZtXwOchDOMfLpf6bChp3Jdw7Mbp5ShL4WqmkPvnXWWK2xTEnD1GUvOf4?=
 =?us-ascii?Q?9SAKcSbFxQp8ixLD9Qq6cZKp/Wq3V4HrRiOLBe4jeO2CCinxJ636DGsohC/t?=
 =?us-ascii?Q?Q2Os4Dx8D7S10KcjMKt98/ZpY7CRtqBZzxFErcqQ1G+81EU+GHVj2pgNE7Z8?=
 =?us-ascii?Q?XMUTaAxHAmPy/VZI/clHYmj0BYAetK4VTSwVhDF+75PrLqgFWxFDhLPFs/tK?=
 =?us-ascii?Q?7A72fcpROyPYwcDym0hpvbyI/2W0pTp6kOIifKREho8769HtGQYN994rK7/H?=
 =?us-ascii?Q?xs6ChLKGJ6W524KxylwGnLkBYZu0AAo7mrq4ZoPWJHosBAcb4z8wZ2DlRsdM?=
 =?us-ascii?Q?UthtWC9TeDkPXncWRZ1Elxy3g7uZR0CUj6vCLcqtsZ7Ge/+rsnf7VAzaDLwT?=
 =?us-ascii?Q?DkJG6/gvXxWWCTIT+vnYpqQcwk2KdppcVDWAJtqxx3YOFAfSivU/7bA23kV+?=
 =?us-ascii?Q?xkCafl8Blcsqd36mg65oM9WKKm8DH5AEnlGEM4iO/+FllzPQ+ERlO8TNwLQT?=
 =?us-ascii?Q?cGk71hJVcqAYBvEJGEZsqw0loZWSHMCXDxZxyq5cx/ZVO7iq1NVJTtP+XBbw?=
 =?us-ascii?Q?GV4DbsihcfXU0cTMXUkMXMx32tSe8BUsdGaQxKDjY5tDLIzSIJsxDwNgX5O+?=
 =?us-ascii?Q?2LGB/yT4SAEz3s1ztpPjJEskJSH0y7g6ZkVqBhT0BCDxy36YudsX2suovrEv?=
 =?us-ascii?Q?fYDBMWxTiSe3zoNpSnQrQ3onW6c7adjUPJidEUsLqwf6A3bW+JFrs1cd66YD?=
 =?us-ascii?Q?h9TqU5LxMBt4wcHgWyAaKzC4pakaNTM9h901kwnAf8TCWVGT+uGZlbA1XCel?=
 =?us-ascii?Q?26NlxWZSKg6cs/+zhLHzO3D6TAQhFqz5CW0T8UV9Qn0LXMqaJok4j23mlSWQ?=
 =?us-ascii?Q?IJieYvIRCMmTIZVNLS0CKq4pZsjk4AFx32keVWmwj4GULghDhtrwBfDHZbaw?=
 =?us-ascii?Q?26u8ZiduSQDI62HkFF5G6GwsNkZaBUY5yYcSLCKSH92kjZNKweKvb2Z6MpSY?=
 =?us-ascii?Q?xLQhswYqjfhdULCENH78PMeUYXYNvMkC4SgH82nJqIfMIUngoCKFpkmyk0Cd?=
 =?us-ascii?Q?uIc+osMlfiO9gTqgfHC+mDlKV90Be7wvurbI9bLQAUL8QsgrLkrQgABdmlFR?=
 =?us-ascii?Q?3zcAr+ZcVmN+JHsESKofggioV4nIGU1nV1f0rKW1qXs8iJdb8zH0CLXfzwNj?=
 =?us-ascii?Q?gYp0bEe/13QxL7XbIHsQgFhX8QHEoY6KvFezGzrjNuvLPaoOIEKkVUUVx4Fp?=
 =?us-ascii?Q?6cUwDRmI2SP9N9ppNozYaIPqSl3qMwzUejewlt6GjijIPyrzLyPIJNgwM30a?=
 =?us-ascii?Q?/pPuyeQ/KHxKF+DyGKpaE2IjZfxqrqoXJSDRIRW2VRWJlaw1XoCaTuuSVu5H?=
 =?us-ascii?Q?Xdl95c8cPuL3T93aKShVUPokLkXJvPMMMkbCeBEbRJgQKd+1iASsjTiUoy0w?=
 =?us-ascii?Q?Sl04++Opo4oB4oyCldNZYsVkniIJ/tomp9GPrW0B8gF4TjZWpglco3VmcLVi?=
 =?us-ascii?Q?BYiDXueq/36r9qySrEPizH3rR46/Z1X4faKqQWayYeJBcoDZsmefXqYvV8rW?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d8f4eb-4a8c-4853-8aac-08dddac33dc2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:43:44.7739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzOhdrPBiGDgEFCEsqFthX//Gx1bkKvJiATtNDXFaySmu4BKcrQmtlPGLvBLSeJrtPZu9rV+C8WJ2xGAXPm+OzSspK7fqLg2RNY7g46cKlM=
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

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

When the host ECC fails to correct the data error of NAND device,
there's a special read for data recovery method which can be setup
by the host for the next read. There are several retry levels that
can be attempted until the lost data is recovered or definitely
assumed lost.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

This is the port of linux commit f2cb43c98010 (mtd: spinand: Add read retry support)

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 35 +++++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h | 15 +++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index d4777ec7c8f..33d0c27f788 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -687,11 +687,15 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct mtd_ecc_stats old_stats;
 	struct nand_io_iter iter;
 	bool disable_ecc = false;
 	bool ecc_failed = false;
+	unsigned int retry_mode = 0;
 	int ret;
 
+	old_stats = mtd->ecc_stats;
+
 	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
 		disable_ecc = true;
 
@@ -704,18 +708,43 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
 		if (ret)
 			break;
 
+read_retry:
 		ret = spinand_read_page(spinand, &iter.req);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
-		if (ret == -EBADMSG)
+		if (ret == -EBADMSG && spinand->set_read_retry) {
+			if (spinand->read_retries && (++retry_mode <= spinand->read_retries)) {
+				ret = spinand->set_read_retry(spinand, retry_mode);
+				if (ret < 0) {
+					spinand->set_read_retry(spinand, 0);
+					return ret;
+				}
+
+				/* Reset ecc_stats; retry */
+				mtd->ecc_stats = old_stats;
+				goto read_retry;
+			} else {
+				/* No more retry modes; real failure */
+				ecc_failed = true;
+			}
+		} else if (ret == -EBADMSG) {
 			ecc_failed = true;
-		else
+		} else {
 			*max_bitflips = max_t(unsigned int, *max_bitflips, ret);
+		}
 
 		ret = 0;
 		ops->retlen += iter.req.datalen;
 		ops->oobretlen += iter.req.ooblen;
+
+		/* Reset to retry mode 0 */
+		if (retry_mode) {
+			retry_mode = 0;
+			ret = spinand->set_read_retry(spinand, retry_mode);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	if (ecc_failed && !ret)
@@ -1309,6 +1338,8 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
 		spinand->set_cont_read = table[i].set_cont_read;
+		spinand->read_retries = table[i].read_retries;
+		spinand->set_read_retry = table[i].set_read_retry;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.read_cache);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 2f8212e4037..44c616a4acf 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -337,6 +337,8 @@ struct spinand_ecc_info {
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
  * @set_cont_read: enable/disable continuous cached reads
+ * @read_retries: the number of read retry modes supported
+ * @set_read_retry: enable/disable read retry for data recovery
  *
  * Each SPI NAND manufacturer driver should have a spinand_info table
  * describing all the chips supported by the driver.
@@ -357,6 +359,9 @@ struct spinand_info {
 			     unsigned int target);
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
+	unsigned int read_retries;
+	int (*set_read_retry)(struct spinand_device *spinand,
+			     unsigned int read_retry);
 };
 
 #define SPINAND_ID(__method, ...)					\
@@ -385,6 +390,10 @@ struct spinand_info {
 #define SPINAND_CONT_READ(__set_cont_read)				\
 	.set_cont_read = __set_cont_read,
 
+#define SPINAND_READ_RETRY(__read_retries, __set_read_retry)		\
+	.read_retries = __read_retries,					\
+	.set_read_retry = __set_read_retry
+
 #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
 		     __flags, ...)					\
 	{								\
@@ -435,6 +444,8 @@ struct spinand_dirmap {
  *		actually relevant to enable this feature.
  * @set_cont_read: Enable/disable the continuous read feature
  * @priv: manufacturer private data
+ * @read_retries: the number of read retry modes supported
+ * @set_read_retry: Enable/disable the read retry feature
  * @last_wait_status: status of the last wait operation that will be used in case
  *		      ->get_status() is not populated by the spinand device.
  */
@@ -475,6 +486,10 @@ struct spinand_device {
 	bool cont_read_possible;
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
+
+	unsigned int read_retries;
+	int (*set_read_retry)(struct spinand_device *spinand,
+			     unsigned int retry_mode);
 };
 
 /**
-- 
2.50.1

