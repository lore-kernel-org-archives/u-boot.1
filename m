Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBB2ECE57E
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:24:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC60A889F8;
	Tue, 10 Sep 2024 00:24:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="u4JW+Lly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8629A88E59; Tue, 10 Sep 2024 00:24:26 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20711.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF15488E64
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuudetquP7PW3ALmHaPHpeuhByhBchg623o5ybSsDKJ24XBEGXf+Lybta0Ox3/n7ziaItpwc54EPE/IoERXDxSnwrd9KtJTTu6En2OP3FN3K1qdKDuuWBIVesKBln6rVWQ2hrDfAqaoZvqXvXYE4AtlzT2hdhcpgVgGWbYiNc9nHFG19fIqg4QvZN9FstsYOwey/t5py+MHu6TY0PMvZXTmTxqUQ6L6RRYE5acX40g3BfvtSxQmHV4A2sl5iTK385qelthXHVJofqA72xLbanOxNgsAb5qhUBB5yez9pyLbI6rFv0ETuEfGqUwoMg8u++g4uu4JDUPPKCwGXXKLiOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Whm5sgNFRFvN7odaDp55Iwpw2RT4l+3JBeJgI/Ct/8w=;
 b=VrhPdJhkTWUcEZAm44qRakyZxiuyPPdWF0Ibn40g8UujFOD3WXvIaABcL78gZ2pCpDwd+RbpVpwbuEUkXc0KqQkwjsPbT3MaZGQI6XosY0Fhf0IqSqTVPMZeiYNyxxenpSjrwTv9UPao7YBNy+xnkrWAnCUrDwNAvRntTC6emrf/N2solKgWC/9vY3JMEqRCfZkqgP4zjJME16WHfz1cRj9QFzZSCuipk27hX35wa2kEbf+UfpjOs8uUm0fdMe2duAuVi3hWuJbotbe8p0PQtuugrehM5vON6khiJqmBD87DqZa1Nuu52VD2dVcDkLsTK+mjyDL8ZRBBI728JLtolw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Whm5sgNFRFvN7odaDp55Iwpw2RT4l+3JBeJgI/Ct/8w=;
 b=u4JW+Llyj2imDXTU025LIyV77mCss+PWX/rGMcF1nSDgi4twvKiE1wxvUWYXcEUybSVbx49jaTeYisqk2KxhzDbb/tLjkUqOlXoFQrliruw+PvLk27FnJKGeM9KxvNHA1BWWyf8zikXRC4g185g1lz3y9ZXRwaO4xu5sbpinQLkulAS2lYgzZ9tr0WLRuuqbykIl7tvKL/MO9y+gA5PPTpie/5JafhQlnxWJMD8OGyMipsAKcUNcBstYLD3g+kz9RgkPTXpP4l0Co2o+MXkIy7biOeVu1r7FcG2tQQF5aucl6J3WrJ79GRNau8ScwKGX2/2qg6CoxKFgf0H2WADgLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9935.eurprd08.prod.outlook.com (2603:10a6:10:401::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:24:16 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:24:16 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 William Zhang <william.zhang@broadcom.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Chuanhong Guo <gch981213@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v4 05/10] mtd: spinand: more use of
 spinand_to_{something} helpers
Date: Tue, 10 Sep 2024 01:23:53 +0300
Message-ID: <20240909222401.2562898-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909222401.2562898-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240909222401.2562898-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: 7609a545-8d8e-4f60-8274-08dcd11e2417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z9Rn1lRzEEbOchqG3eKIjfOwwhZyPinFyVFvQFS+2e6zoV2Hr/l8bcDUZPNX?=
 =?us-ascii?Q?lbTawBzI0S1txEJuyJXb87aBdKtc8Ql71BkV6ra3A5SnyCBfg6q/3DHCOpU6?=
 =?us-ascii?Q?pQxfzRKsFUJ1gEQFNfm2PRrn8azgoeDxycxJvzreLVP9X7p4lF++hI2ZN32s?=
 =?us-ascii?Q?bwN7FSqEVTB2DPzdrbVMY++m8oaK4MRW3KciqsW0NQi+mkYnoqdn5sgnmMTI?=
 =?us-ascii?Q?ZsZdXAjWVKBmuG0eEDBRJ2RwH3SjaTW0Esz1w0vJGk2FAyJ2MDk5LoIGUe3e?=
 =?us-ascii?Q?YENgZ4kllmFKnScpQQ7LzNS41hlLW0XhQgKYAC3PX9xMv1CKauvhydGOYaky?=
 =?us-ascii?Q?zSz3fQiYL4+sGHBXKlWvlSBsDqpUt7wHhzTsGfc3QjAKS7GGNpRdHIaIfDvk?=
 =?us-ascii?Q?6IyMoU7LevfOcN02oZUYkkTFkrmMtBxkgFwpDkSO2k6o6gFjLjlWUgQWJ/sI?=
 =?us-ascii?Q?yUyJkc1bxvupYzVHvyWmksUgB1UmrISvnNctkuk68SRE/DWP697ERG4ATG9J?=
 =?us-ascii?Q?ZALNg8Hu4dAtUDnb45m4RVCC38AFssesimYuoHdW1LI+OD/QREvfQVGAbV3w?=
 =?us-ascii?Q?RLd90uoHY76IFrcVVMOr9bTpFnhyCDOPddS2MK/WwsnuRuqqmjbdn6WwMFs0?=
 =?us-ascii?Q?rtRyLgQv+hOe6qeWH018nNRkulYwUr84EK+u2p4R090uLDNFHQhzNEKhOYbc?=
 =?us-ascii?Q?9nDKKkaVZfiwbcemkN8c9ZD9uNos+EiWsFWITKm1FrRrNubBb2hYWYOFmASi?=
 =?us-ascii?Q?4D3uqNEIbTQ5ORyxnjWtPdbdWhIBUCL/WkBbpGDHri+3VNATZwLf+CNQTLA2?=
 =?us-ascii?Q?a8hQHBT1Ve8nrnHS1mHcIJJ+QiHV4x5VUt/j7WDYL4Dk+PKaN5B2iQRZeNpb?=
 =?us-ascii?Q?knDy435YiFD68BFlGCCKW3WzXD+50wSwGmSBgcmFoqP/WKoQBlskcnWYFWsQ?=
 =?us-ascii?Q?YJ9+Q0L7HwOD2RLMmy2vc0GQPJU4/a97GHdJ02iXdeBWVnfUzFBfsyOEmdQw?=
 =?us-ascii?Q?pHrOvXqvn+7mLl6Wz2CZzULp1W2WnH4mBJ7xYQLdMjID1qWX3ixygJo3e25F?=
 =?us-ascii?Q?YTyAqoT8BviXj+dhj2pJc27M9nljD4G/LScW+b0Q6IqGn0LoG26a55t9JHge?=
 =?us-ascii?Q?9dyWhubxhmK7CQySNYNbEYD0OHOI9nZhH9j89jzhAM7QcoMhh7PmzPksgNEl?=
 =?us-ascii?Q?BzseoJz8BJ5ePguo49u1QF7w6wix8Ugyzyd37/Suwm2rbw6zzWtVsWirXA2k?=
 =?us-ascii?Q?RcK0W9XgApiHGwA2EqDURB3l2U40dnPC3fVGi5KB8YH1QS/vmx/xFqbZotKn?=
 =?us-ascii?Q?I1SN4MK7JmvQikpzCBhp6ssl18y3cPXgx+A7oZ/T9Dz9/JGpV7sYraxWSWto?=
 =?us-ascii?Q?OWSwzKm8c/UpSapLlbXLDpGIVg9ccXM016RC808DM7/QTG9ce3kC/7S0KyuO?=
 =?us-ascii?Q?i1wn3pJ8+a0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Iwnb1KOGH46B/IpJqP1xWIreKt9NF5QEuRVfZmbAw9PL5+SMEIo9vR0lftO3?=
 =?us-ascii?Q?S0WLcq3FmhgmCSNSEuMIpkkaa+/H7++UxOn7opQ3b5tEKR2X1NUvSjmeuEKE?=
 =?us-ascii?Q?9rxGJKqU2cbSPk7GHelGxbOaT6XJwI7nN3CuhVbtqoUgBYJffbRYphCO7BJk?=
 =?us-ascii?Q?A7n/9VknZbSKG+48uzqzSNEbj63LRIFGJxMoUx9GAxzJXus+jpxp9PQbsOJ8?=
 =?us-ascii?Q?Tq7PDdTf6MuzJQ/QloJl7W8Z8sz3QJO4qrTXlBDPT9tqfRQWzU+DAPW44n7H?=
 =?us-ascii?Q?FqC3KLebaKIkYYMomCsTwgyWgIxcSqpivL+3NrUTb9eX3noZbU9y/LgfIi0o?=
 =?us-ascii?Q?nX9C9P9C5fi01szFW9soJRaqDU3qsELGuv4m3aBARHyX+t5+nfzTmxMtV9bd?=
 =?us-ascii?Q?66Q6CFMsFYoVo7axvBp7uObNpDABM9HmEJQIkLGAhxGncUxmzPWotq90TQRr?=
 =?us-ascii?Q?hWJga6fXtB2SPMvwOsSxmC8PmQs66wk+RlB/pwoIN8RNN2os+4liI/5iXjYH?=
 =?us-ascii?Q?zz5Ws+QRHUprC1dcfCB4njScnfEZnxY9dgkCJZVkRwMBfUmmgcy5UohY2cEU?=
 =?us-ascii?Q?DC68Ld68xGOBPuyqURdvIF65adQ+8BYN4vIG+ck10m9AI/zZi7IAVLsHCSA3?=
 =?us-ascii?Q?TkBKfCPZx2BRWdVtXbna9cwGvpnEqmQqtSK8l6a6y8dvyllxUieGCyC6vO7i?=
 =?us-ascii?Q?j/AIyt3L221q9lCVPE3rrwTvOpRIsSOsgxBhLKyw9ae5tsy3aOfRpUF34Q3l?=
 =?us-ascii?Q?dKTNfUmWFiKBoywlyUbAwR4eNnjYZvB1tp7wQobzJKNPEjp+ai7Y5119g8Hk?=
 =?us-ascii?Q?LbRHVIQiguq8zdzm0QlMHCHI3Kk+EBt+JrmQjDsgUcjocWFW+5qkwSeJKaUx?=
 =?us-ascii?Q?elrU4v1vICv61Mwb7IW+VBZ62wWdR4mjnmT62+8CkWgZh0obX1kRepBwUS7Z?=
 =?us-ascii?Q?rSFChOoyVbKxCHOJVFGhpLmRdpLYIqFfH7GO4w7vS0L6Bq0GK8anXzJVAcGp?=
 =?us-ascii?Q?jZhgdNVRIyJO3sVgymOINjg3BdcyJ64Z0DEEw1H4EiBkfVQui+EuSNBd2GuA?=
 =?us-ascii?Q?8wM8PpfOIzs6RChWSL/4FUny/xwl20rfNF6AwoUtr5LPQtkI9AN4Pv0WDdYt?=
 =?us-ascii?Q?OJwfiuZO+FdO5FNFTcdpwOtZk32OVc55XB1b/TQqFKcMZK9nmohLVyTHaLPx?=
 =?us-ascii?Q?lourcY4W+/Sqzcl8B3Z451KJMAZbWugCvqWpgM74p3aV0lYIdW/ia57c01XR?=
 =?us-ascii?Q?tK8wUeGv+UoRjADkzjQiuml4iFhdRbsyIkL07RiHvcZlvC8+DnXKL7oE/nb9?=
 =?us-ascii?Q?S3F/5ylowZXbugU5SgdYl31yIDNQaZRjmfxaGPZ2GISSwUppCQNPZVWNSlHh?=
 =?us-ascii?Q?3PRSkr3Ib8fUwUTG2Sk1g/DOk30d+riWvvNwooWyQbbKm1Cv0VJOMQggoZ9z?=
 =?us-ascii?Q?Fn2E/zK6WabbB8oTbTotMo62Usq2n9n2kTm2R144AOsE8QRfS5RH7xP/IwIN?=
 =?us-ascii?Q?N/nXWuTKAg/vTcxGlSX3tIn1fv6tnm/EUXCoz9E2f8mBINiBxU/W6euZ43R+?=
 =?us-ascii?Q?tes0GvogNGtsZast8UKZp7MruWiEuRbIEV0cgE5t2DwwA3PB1eVqyx4nlKE2?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7609a545-8d8e-4f60-8274-08dcd11e2417
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:24:16.5736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8s7qRoFDXFbNvQSCZk6uQ5k4zXL3r9RUR8zR7f0TE/Fl//SsfWwdhmBFBXSrlHOCa0dWG0FgRgzLqxPxXf0lWBn+m0/BjIgQcnV0xBGj9i8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9935
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

