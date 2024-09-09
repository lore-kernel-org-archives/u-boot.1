Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA83ECE57E
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:25:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B27188E79;
	Tue, 10 Sep 2024 00:24:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="okL1zqQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA42A88E72; Tue, 10 Sep 2024 00:24:30 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20715.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::715])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C141288E6B
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3wrttQaGk20cEg+nXPcGzwpj6c4gRPUAm7WbNSBwDwk0lXjjisyC9lWkg/AwG7xqJjNwp6tR2GfLkiETC3sNdZDeIBKsQX/yX+6mg2ICOvPDJ5tt7yH/XWVlOjVnfkpJKPledSXGK2q6qZLKvLmiS9p6+pAR69Y3W6YJaXg1z5ObKWwhx3yb8izsjp/MYQ5tdsKmeae9ibFvyvTku7wpqIY4iF3SAlt5wmVjCOx6RU+zuXFjNYu1YYcgDK60ULxbM550mtgZ6eB0D5NrNKwRwgak/fVD/pnaPVRDTozP94jz2HAPtmlSObmJNDd0XXRgF7MyHXezwHGOuDHn09Djw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/6p9hFb4G9HBd9BBmwi2nVPzvtan2Glp8fZHCixB3k=;
 b=FfrtVmgxMf2UAzLDXsfuF2tRSauCYfhOwLmnv3by+vZ/FA7lhOW2KTgssy1wRJ05dpqJLQA/e6y47+Ix6UupDhJLxJi6bh2RKZKHiFVk0k6E+fNj2qjmEHasyOBfCzRXGRcGvt4hbE4oTa1bb2uHgRzE/5EoW1TRfXsF4J7owYTtUca2A/lv7QAUe2PHZUDIzW5nr+l3F87JIjYONF/9FxswYyr5RygNmhazrHdFcZg38UKR3VAQk3mxflrbEElkateUyCeur0T63/EOFawGfCCkaeDJoubnsUtC5wB6xTDmVv6WIRWDxnLtq3p5+apd/FHYA/sQWvkThCHDY8lu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/6p9hFb4G9HBd9BBmwi2nVPzvtan2Glp8fZHCixB3k=;
 b=okL1zqQgQimD1Uaps8StaKLLUox7reWC37BFWyES3mTRbZdlv6VBPJs8pb2HkqSBvLPzoBxwrzepTooS//ivBnGHTZPjE2mTuBGhDNArYp35n3ndVg7gbov3i3JD+YSYNE7kxRjM8bbhY1fWvscPC1B+1gYiShZExlp30nsdskiaUtJZGmWhUVgUH0/sTycL0KD3D8/G+Q0W03RlE5esOtXNfsnmRwYhdQLCeBRCMl3v82GsFzCeIQy+geubCEJxM4wHE2VVb3rDM7YpjszKc+JbilCoNxny574we0E6skTUGnSp23Wqz09jwB0WysIArxeVNKoPA0fMlD5uPWBkQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9935.eurprd08.prod.outlook.com (2603:10a6:10:401::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:24:21 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:24:21 +0000
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
Subject: [RESEND PATCH v4 08/10] mtd: spinand: more refactoring
Date: Tue, 10 Sep 2024 01:23:56 +0300
Message-ID: <20240909222401.2562898-9-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 671ec612-bd22-4d33-7950-08dcd11e26c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qBRH1Vg2BnRqzneXwmIuIhNOm1YEHoJgnQ7QdWxz9g0ivaKMVy7WXhbrn+vc?=
 =?us-ascii?Q?jSS8ZOkpVgHW6pJfVMwuK9XIqNe0InG3VigTlMZU7EqIjLbIARWTCrbvshXA?=
 =?us-ascii?Q?T+lbcL+Iydc1SWz1R+FKMHxnyWt3Z2s4LCsJtiiAqzIBfm4fE5FMTpKFWMc4?=
 =?us-ascii?Q?5GXe09g81c6iqJ8cqUpWI0P1E1uapupnFD/eTCV7KyAIC1psuLHxCpemnssm?=
 =?us-ascii?Q?9Ka0P+BaexbinCe2JLmZXAiBfewZfPs2flu/e7aaHSh8gw4ENoRtAAWnY4Os?=
 =?us-ascii?Q?IvPrSi1dvMxI8w8JTaVCoSXLuaSdHB2+bSoufqLHFCdYwa+ciErOrFKw9Ajd?=
 =?us-ascii?Q?2NhFvmpbwNwVUsCwm3p59adnh5EPKFOgWup4X7MB4NzQpen+8Vwa/1+FRe/e?=
 =?us-ascii?Q?eFIUS9Kohufo0QdIt3FYbL0qmvZToWK9wGGmNQxK2rv0ZNmrnyyhJShsBa9P?=
 =?us-ascii?Q?YcLSgnMh5brXVQ8fqay/DH9+j/sSd+1dynIrXigvvAHlg++gDOTIzF37P/44?=
 =?us-ascii?Q?hiH2aVHoHw3F4q9TlKjs7gVJlrpk5AH08BBiHN3OUS49CbKW9ddZ74a+mFsw?=
 =?us-ascii?Q?gpkxAGLRNlyXS/swZ10CkXpbDIyP8NYepdGm4Ckx2/UbWo7dN5t+tGQ9aBsz?=
 =?us-ascii?Q?eW7LnZJFNI9HcvAmMPpg6q9DVPB0RAJr6sWA84iVwkQiB219d/f7NpnbL+Ut?=
 =?us-ascii?Q?VaQPcQRzwZNug8a7iD0vhnYW3n4g5bUHMQu1+mHmiw6a6XoW7/1VLUKo4jSC?=
 =?us-ascii?Q?e+ApTvtoAOMYW/fFX3okc0c3w/VdpJeboFLt44vLtHmwCZ5GrJDjTRFq1ty+?=
 =?us-ascii?Q?+EjrRfursjB8AE26inxyM+3oJzPJjHtKJ36caSt1z0BCQnU4DPFbvizTDhsp?=
 =?us-ascii?Q?weAuoL1q4iKejNBFCJ0SdqIuA6fK6HhJW+sMs3TZS32u/Sn+ecN/XCj4Tu6j?=
 =?us-ascii?Q?PlXmpRKojyt+xjai2Ive11OvDVZAZuRnzcffR0bYGOV2o30aWFPQJGRjQJRb?=
 =?us-ascii?Q?ELtRlUTL+tKSJfluAlJFNm39KgYq7t8KKQnzRCGiXXz3vGR3vtzVR6fqs0RD?=
 =?us-ascii?Q?ADpepx15W/Mv6NSiaOBGm6mdSS0B3WJ4LK+jlDWsMS7K7P2fiUZBJBqkrkxJ?=
 =?us-ascii?Q?zJsvCwdis++gO7YYtJrZqllDigsptKUC2H4TOVcxT6JNnScTzV3ckUzTZ84p?=
 =?us-ascii?Q?sHl98NhztVADG2/PopYU6wXfkKA+eWl1vdbXotYiO6agzWbTY6ruKa8qtyR+?=
 =?us-ascii?Q?zHtfXe+kxyA4dqB6x5JcU5Hlp/+ZfsIxBSsxp0ZpKzuGKPFEo8Wb5wSlL758?=
 =?us-ascii?Q?pYNIR+OTWHl7mj4wxH0le7DSPkRG9xuxd7Vc7WbaG4DXH1F7Assu2bTV9BNw?=
 =?us-ascii?Q?QCmsv3XVawoOg0xExkEZnw9O3H3m0JTj7/qU02Oaujw8PrkcWYHC47yGA4PB?=
 =?us-ascii?Q?sJL0EEyFK+c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LYP5ezJwdj4lZRi6AEwX4OUkg/LPPLJF4bCFt9rXZxHQkPzYGoapDmLxcq4R?=
 =?us-ascii?Q?ovzWVKWjLmkXg7g8RMpH8saibQClIXji1/pS+R9fpDPOEeKsJJoGEiIKBJiJ?=
 =?us-ascii?Q?2irlHPB0Dp51tEN1fL6MBAZq6RMS8EX1mwBDdARUQJJDNxvnizfCzBRdgr3/?=
 =?us-ascii?Q?rj6uTldErWqxJ4uchRcjdSLxrVi15wJ9wm+dK7/w6mQCZehet9Z5+AkF3dK9?=
 =?us-ascii?Q?YdLYEhXCQWTZE9z9i++LcMEg5v7cByINhDoADMMd0iuUfzYEZl/qwgEu9x5G?=
 =?us-ascii?Q?GBKalfggpKcvqBMn9MvxpCnwQe/pKa1Q/gq0Vpgk60DnTBDOTp647DI77Ryl?=
 =?us-ascii?Q?w8XaCyP/IWHc7yovfmmZPasLmJtGSOf8QL8mFljOolP+bgwDF1avoz/AcKB1?=
 =?us-ascii?Q?8IafQ4qhkx+Vy/+Mph6qP5hKkenFd3no7LCzj1LhEszpqTDgo1CszwX2VaZW?=
 =?us-ascii?Q?ubbK0fi9usRZfkXVYBGpeM4ZF3dj1yjTVA5jLRby0f2cofjjMD0WHfFgFiaF?=
 =?us-ascii?Q?NoF5pbwv+zL/E9/nw87eHflaIk8n6NeAZf+ii7s6XsRyFdGKOMWbMcoegwad?=
 =?us-ascii?Q?vOiDDvF3nHmFlgmMME1uNiIhhRZcFAPlCxQE6/SMcOCxMau4CNMMYRKoholL?=
 =?us-ascii?Q?nMz498qbvJBeG/8xZBNMsOsoxdQhjyO9pjztFeyWepw1AUSD44eYKdCigRy8?=
 =?us-ascii?Q?gJapFs+5mN6VJRoEt662ZG2oSHoWrAvX5+T1J0ndwwXNHGsGPCMqLrKw4iSV?=
 =?us-ascii?Q?1uoJDOiWrIuXS7IB6QwotNXso3QRmh3FzAjcdzhVUG/Lpud3L5+93uMKh6WF?=
 =?us-ascii?Q?nXXon4I4s87WtzOspXarNoJHJoNX2P74OnnY/AMbYg+C8lXqqavPE7v4M8Up?=
 =?us-ascii?Q?iWSI5Ndnqx2DKsxq8Vb3zFamx/goUgXoziRhtv5EBnKAxAq1wJSb+wKKcEdh?=
 =?us-ascii?Q?/3ifEdfy2DAssHJ5itx2LuOpb3Qda1aiKzzZKpL0zd1V0lv4amDqF54T4gpR?=
 =?us-ascii?Q?hus6UD5Ln77biMwEsPwKB8pEWW2FxwnELvQjO1tWlIw2OqMbmxEobkDPWIfX?=
 =?us-ascii?Q?EKue6hEUeiXG3vERVqt+alJmI9jDr1Jdmmc15kIPF5larwwAM1Mf7Tx/LNOa?=
 =?us-ascii?Q?8muSUz3/tbZJw6pr3N4a7bIAsSgNR74MYlhR5JsiapGiY9TWOMyIknFwKcyt?=
 =?us-ascii?Q?jp2xLHrFnskKrhx1VnmhwoWOVn0itWdN4W5gWq/XzGiCBWIzbk5mN4osHvwr?=
 =?us-ascii?Q?1aARd4ZH9jpBcPmVmVtY/2aRsP9j9B0eRSVRcWFimlLnihOJvTUQRueLW/GT?=
 =?us-ascii?Q?XdxzaamF8bftZ9aj7ddghnCke29onTLwgJ/PzT9NgnxRWfPiJqjpWlw0lFXi?=
 =?us-ascii?Q?EckrSvtvJHCmoeKbyy1sl8aaVlNzrsz+BWiESnFl1rK0OMSHv75/oQZESXx1?=
 =?us-ascii?Q?tENc4U6mo2lsI4UihAbkzqbjNaYxSvy6JZYzqLTgKc0z1Ez7hP7Uz5OQrEjk?=
 =?us-ascii?Q?aLOaMVIwB7umPrYDjdotQ96sH0+BXWBYRODW2LkSaLUsexmMoTPawFym75l5?=
 =?us-ascii?Q?i098wvlQws3VizPM5b0/+QUOQ1ZJ3ZbiTr0M58qb3nbxO/4qAcZ6t0n+9YS5?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 671ec612-bd22-4d33-7950-08dcd11e26c1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:24:21.0527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8befdStkEWTFPbxF7lCjqS1Ya5fryqs7fwFsEovMcOhiZeJ1ClnzsbQjyllZOfTXuqkLQ8N2jKO8QevwRSS0G/sTbh6Qc9ByrBls9uqyod8=
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

changes:
 * Move spinand_check_ecc_status(), spinand_noecc_ooblayout_ecc(),
   spinand_noecc_ooblayout_free() and spinand_noecc_ooblayout close
   to each other.
 * some code formatting
 * remove comments not present in linux driver

This make code more close to linux-6.10 kernel driver

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 115 +++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 60 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 6ca8b7c80cc..548a7144ee3 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -222,6 +222,59 @@ static int spinand_ecc_enable(struct spinand_device *spinand,
 			       enable ? CFG_ECC_ENABLE : 0);
 }
 
+static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	if (spinand->eccinfo.get_status)
+		return spinand->eccinfo.get_status(spinand, status);
+
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_HAS_BITFLIPS:
+		/*
+		 * We have no way to know exactly how many bitflips have been
+		 * fixed, so let's return the maximum possible value so that
+		 * wear-leveling layers move the data immediately.
+		 */
+		return nand->eccreq.strength;
+
+	case STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
+				       struct mtd_oob_region *region)
+{
+	return -ERANGE;
+}
+
+static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	/* Reserve 2 bytes for the BBM. */
+	region->offset = 2;
+	region->length = 62;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
+	.ecc = spinand_noecc_ooblayout_ecc,
+	.rfree = spinand_noecc_ooblayout_free,
+};
+
 static int spinand_write_enable_op(struct spinand_device *spinand)
 {
 	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
@@ -413,9 +466,8 @@ out:
 static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
 			      u8 ndummy, u8 *buf)
 {
-	struct spi_mem_op op = SPINAND_READID_OP(naddr, ndummy,
-						 spinand->scratchbuf,
-						 SPINAND_MAX_ID_LEN);
+	struct spi_mem_op op = SPINAND_READID_OP(
+		naddr, ndummy, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
 	int ret;
 
 	ret = spi_mem_exec_op(spinand->slave, &op);
@@ -445,35 +497,6 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
 }
 
-static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
-{
-	struct nand_device *nand = spinand_to_nand(spinand);
-
-	if (spinand->eccinfo.get_status)
-		return spinand->eccinfo.get_status(spinand, status);
-
-	switch (status & STATUS_ECC_MASK) {
-	case STATUS_ECC_NO_BITFLIPS:
-		return 0;
-
-	case STATUS_ECC_HAS_BITFLIPS:
-		/*
-		 * We have no way to know exactly how many bitflips have been
-		 * fixed, so let's return the maximum possible value so that
-		 * wear-leveling layers move the data immediately.
-		 */
-		return nand->eccreq.strength;
-
-	case STATUS_ECC_UNCOR_ERROR:
-		return -EBADMSG;
-
-	default:
-		break;
-	}
-
-	return -EINVAL;
-}
-
 static int spinand_read_page(struct spinand_device *spinand,
 			     const struct nand_page_io_req *req,
 			     bool ecc_enabled)
@@ -1056,30 +1079,6 @@ static int spinand_detect(struct spinand_device *spinand)
 	return 0;
 }
 
-static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
-				       struct mtd_oob_region *region)
-{
-	return -ERANGE;
-}
-
-static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
-					struct mtd_oob_region *region)
-{
-	if (section)
-		return -ERANGE;
-
-	/* Reserve 2 bytes for the BBM. */
-	region->offset = 2;
-	region->length = 62;
-
-	return 0;
-}
-
-static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
-	.ecc = spinand_noecc_ooblayout_ecc,
-	.rfree = spinand_noecc_ooblayout_free,
-};
-
 static int spinand_init_flash(struct spinand_device *spinand)
 {
 	struct udevice *dev = spinand->slave->dev;
@@ -1169,10 +1168,6 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_manuf_cleanup;
 
-	/*
-	 * Right now, we don't support ECC, so let the whole oob
-	 * area is available for user.
-	 */
 	mtd->_read_oob = spinand_mtd_read;
 	mtd->_write_oob = spinand_mtd_write;
 	mtd->_block_isbad = spinand_mtd_block_isbad;
-- 
2.45.2

