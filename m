Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D30C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 22:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 253CF8410A;
	Tue,  5 Aug 2025 00:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="pVPUi7OX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 538E584109; Tue,  5 Aug 2025 00:12:07 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C085840E0
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 00:12:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCtVOxD6/CnugRDFVnU7UmMa3D7BQnNCeFWIa4HpU0kxpdCgtsDQpUrR31Iy1ooh0rhzdz2txzef55zjhWKjYscpzeRhNwjveZEgZ5IGhQzmGxz39S1EHDFW1z86oX44FaKkqe2SIUTa6ad9aHMTAV20ursusl68fyVv58OWUgBJqi02387Di6E6TJAVbxlld3grG+RHI0G2YkG7wA+6iyX/vJaEruOxlN5WtQy1Y6cS1Lz4PUV/QhW31FnbZWPDOktol3q+993Wowqreplg5SHrSMRCXSSuMXA/kycoaziUnk1OtV+X2mFE7QUsuM+J8sWmBIXf1fgPEKtFg6/Kmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAUVV2us+PHu5utdyORwsp3hUmAJMtYChlwhD1s5Q0A=;
 b=b94/a3dipftiJ8M0ozXv1zYOpHfrmCHs7kO2BqvA28E7tLRp+xOcJFt5ZrX2YPqogEt3NHI/V8PHmzdZEoPiDmAf0n6dIBZR/vQ4d5uccAfyVkqsr+GwHB8dy+TgrBWbrhW+7zYss5ps4sKW8G09PK056l1f5ov0S6/vVcq2JgJGaNEBzIE77gTV56TaLNb7FP6L80ci6W1N/5tS2qtywEtlXtX5Ggdw0ptWAShdoSc3V3Sajb0+fQ2+w63SmdAS2Y50QzEYTJqmKCbwQD3af/UqjYFQIwCM4NR2sxLQRKx587C4KXvnL4kUXt7g4qxORjpVku+4SCQHz1/vMwN4Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAUVV2us+PHu5utdyORwsp3hUmAJMtYChlwhD1s5Q0A=;
 b=pVPUi7OX/fzA+e3IRDEjwADyqlCI3o1BsGreoCvDiO0Xeh87TyS0vmBG7RtTMj9Ty2tBj5IBcTDX0uRh/HYXG4GqZcXTdHkOd+6FOCIDcUb0uXD3PMzKfPIV1BJiVS8Nrb0705Klzn3zPbystO1kDQ33wqkxdzuPSoIEosN2Q/Utsjx6OrjGrJHNgKhG9/MsO0xzvHHP5Pg3AUUDwXFT1zQ+EPNv7jljr17+1fQHSop9Kqw4u5cs1Jq+TnFVsrHyAzKm/SBntFaeNt87aOxRmSy3sANbj7DOCWW+e4GngENPIS01HGigyj0Vdu0AodS+ohchE7lhYQcZOlGTgb63xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7771.eurprd08.prod.outlook.com (2603:10a6:10:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 22:11:51 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:11:51 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 16/22] drivers: mtd: spi-nand: Add read retry support
Date: Tue,  5 Aug 2025 01:11:16 +0300
Message-ID: <20250804221122.1420516-17-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0144.eurprd05.prod.outlook.com
 (2603:10a6:7:28::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c849c66-30d9-474b-052d-08ddd3a3e999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yLdFTk8hAj2EHlNyRhQBlA8hIB2NUHwlVDw1BwzksS8C42nBvFvHwlMD2vMr?=
 =?us-ascii?Q?Ztw4+uCIsJrk1x+/hD7Dtb+gYvE419x8coIXbWFzogUelG/Ze/8v7oZuNz1q?=
 =?us-ascii?Q?smtMj+S4D2bDlCM4bZt1AW6Vs6SGd3Eo8NoA8LNxV+mx/Krk4+1JhL4ZAOgt?=
 =?us-ascii?Q?F3DnHfFDia6If1MUkkJV89lSumSi6sglH6YBv8+TnFs7CO+PS+Ow+1UP+iK1?=
 =?us-ascii?Q?grwQ91MwaQKMwNfmI1FS5ZBIn0/gpUD139NahuNJPxS4sckkJ2pX5rWU2lQ5?=
 =?us-ascii?Q?UnZbTmOpe/WbuUOy2Z4eKYWgz8ndbB3TTgPhawH/aLL2usTAyEIMZ2UA/Aut?=
 =?us-ascii?Q?lZMqAfEubxEyNz66zCKsnekR5HgeNsXL2dJ8KsUmJstbTDcMt+ID0u6s94md?=
 =?us-ascii?Q?mbXu4b6GYTF+AN2hckEEy9Z495doXLv5opMAfc+jhSaD+cvHpAF9C9JejLVw?=
 =?us-ascii?Q?FO9dohuu6L61z1J49joXbZTxXtZXa8Y43E4T/XMjSFA9na+6OGbeqzyMjZTU?=
 =?us-ascii?Q?ZnyBulLKkhThY+2jo7d0jPwqWvPId18MVP59XgI4FFsuzQKr+f4uIFziDOcR?=
 =?us-ascii?Q?/VFW96T7/aN1j8Ph1UPfrxHdqsyl26Hu+vlK+uKvdfJ4/8mGAJvOf2XQhEE7?=
 =?us-ascii?Q?JtZETgQubtIz73eGETynVQe3PshXL1ETs+31SLyYFfLr5UVGua2kyjy7hY55?=
 =?us-ascii?Q?25L41BGDhk0w9O7npM4if7ZWOruxFd6tBDNNFDKwoEhGKBZUjkSusGs7A/AH?=
 =?us-ascii?Q?s+Z0/y3H29R4/SLr+9bPlOHYs5SWAIDdsB9KB2cSAoFCZNrm8OVRgYvGe7HS?=
 =?us-ascii?Q?eNA5l4bakYYVsxBn9mJOXZznfMSlJY5L5XjUj2WAphLmMTU1FzOJc1xGl1sT?=
 =?us-ascii?Q?/zFhKeSGSKFLg8GASgOc6ZvlOt10gAC4r0vS6F0mssKKfmfv8s6vzmlMnkJt?=
 =?us-ascii?Q?lWdkav4IysB5onMTPIXU1ntG+y8FpCVu2iSpQwDMU1JA+7exEZwbLNnHHQOX?=
 =?us-ascii?Q?DB/0/5V0ZA+h7Etv3cB6wEzAqNuSqn73aotE0mUwBs6rcItDbbhZ+cYljoP8?=
 =?us-ascii?Q?4pt1cSjkkYlo3fDJMny5qhyMy3Q72Q5J8U8oMhdbxp+xdmEnZloAKYFvIjU1?=
 =?us-ascii?Q?Pdo0rCQ2EBCtSl2aSOfecnZjoV0+9vvSP1IbJMEJCkDz1An0MRGUY6zC/bMR?=
 =?us-ascii?Q?OHV9mApxi+0cLU3VA+YlPZZubI6ZwpnNrGdsmXTjQw+QTbw4EQmUEme01aa6?=
 =?us-ascii?Q?aVkHnDcC2IWzXRcr38OqpJP5j1BmvVTp7Yn0o9VqLws/XbHsc8QC6TGFqyvd?=
 =?us-ascii?Q?vtMp6FDJ56x/BDbSvMrmNN+wohp3+WqavO2LaN2HGyDBYDv5/rFRp1JOzVt0?=
 =?us-ascii?Q?bxV0chXckhKZH0I2h8j3dtwt31DdEOBsHkamxm9P5+HHOHF9hwwm8iCxCdZk?=
 =?us-ascii?Q?fSVq35TvCl0uOeWKD3a5+2nLShqQX+X5PtJthow0mNvyw6NGXo/MIchLOeQG?=
 =?us-ascii?Q?x0VlTc9wRJ3aC3M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/LaFgH+y+xC8DhE5NQmlJErvrulmQYTpJAXkDczBqHvqg4CNi6BZLp0aWE6v?=
 =?us-ascii?Q?gupRFrMM44vg3WGrYJMNfRqWOx67y8o2DiFuAwK0b6q/Y264dSpqX4P0kGzG?=
 =?us-ascii?Q?G/q3PsdsBYnqp1rlWxyIeFMDzErHkI+3Phub8G4vKuer6KvrMfkG/EYGORzR?=
 =?us-ascii?Q?8/+NDWV20v/7z0pu0b3a6qhMJJXgww/+C39WN5w68bLLMwAkGzjfgclORQF2?=
 =?us-ascii?Q?GaaeK287YwNzwMKyPW6npONBmPciBANpRZmbULQfjpfvw/TTO1+wxx4XsnKQ?=
 =?us-ascii?Q?uY1GlzKaRNmKjvzjKKVn7HKHP56RXq3yjCSiCAnzCBgaL1eIpi4PhBfM0ILY?=
 =?us-ascii?Q?sCNy2Z11dEsOKQo1s5r9v/H/iV1qutkkFfpHHMjHHlFJshP2ULgcGXBpkWNN?=
 =?us-ascii?Q?69MQDQMg6xrMWcKcneUfAVbdHZGcoP6+t9ixGogbcffYpZevVxHgVo/M6IUP?=
 =?us-ascii?Q?XqFr42xEfww49+9F0lRwU/mUAwRQioP6ZF42vCT/gGSraZl6VdjO4kGYme9B?=
 =?us-ascii?Q?g5/VpwQ9kQzOP4bnkFYaU85f6iShYCt2VE0xytg7P80jl/1oV5fVGu8V0byJ?=
 =?us-ascii?Q?/G5mda1/wrxPCegoNnIFEb1eFrF+KivzCOFCjEzDvOq1y+a1BSn309zjo5My?=
 =?us-ascii?Q?kOMSlkf8k2e3CKxLBtW2Ycy6dgA2qhI9tSx1ze30nyfCMEWouONpoHuePaCj?=
 =?us-ascii?Q?z840u6KuUT2TBr/X52iyEeBoo2xOzfU4EGJ6MWQ1jyrmIaucukS4Z5ml9sgs?=
 =?us-ascii?Q?6GT3nYidbwU9ux5QwZX89ETxyEY2O4l+TxWZ+ogJatABINxB0TJqYqlA9EI+?=
 =?us-ascii?Q?RFPDhZVEFZfhiUAdiKErVBWHKE5KmBcppMHKwDrbDtnzv/WGLEzlr2pxSGAA?=
 =?us-ascii?Q?u6SGZbP0BKfk0QyGO7pKhW/1JCz+kBJoSYpb5c6KY7APmuZ+VLkYx+3YDQd/?=
 =?us-ascii?Q?qmkFYrq8gjX7GdEECdNHZNoVSwzQGV3+GfSrAVnMu2dZe9LaooGN9eIEstCL?=
 =?us-ascii?Q?z6OjhwrkNoE6SbPFczb8a3hWglsn6Gkl9PYTD99RGrJgxNp/SuoDFD067Q29?=
 =?us-ascii?Q?xu2iXWH3Dy5kXWyFEdlCbxn/mwgnxBjh0gqdENgNstziWjYsjix6XdO7x+rg?=
 =?us-ascii?Q?9rt1RRaROaZS3MQrDG+wI+mVyjbMigeNpnUh2eZJPb/A5CHB79aeiUC5XN0q?=
 =?us-ascii?Q?GYh+yQrUs9A+Zw2XvYAmgpc2W0fVDmvK2tPyB7Gbjvzpy0fbz11T6WTj8wEA?=
 =?us-ascii?Q?oAE/c26ougpjnM5zwZDw2G5h/AJZ95uKK829F29U2zoE8+Ikb83wHJTc992j?=
 =?us-ascii?Q?fEiHi3pH0JEJSahZsPzqyrVT3ynuEspmrX3w7vwgqQeWp+3FXDxTpxOGPUP8?=
 =?us-ascii?Q?RArqvz+qOg3J4FYnDoozPr40hLKC9I63jfU166OQdoSMqT4QQ1iq06W3GfR3?=
 =?us-ascii?Q?xY5i0hOSY0NnhwHAt6I+dC1oxtPbm3n5zpaaK1mabE6Wut/ZeKpzrSU5AxiQ?=
 =?us-ascii?Q?enOM7clCcY4COx72qrYrlEwC76b/ea3TOd9b7Ft6NQdrJDnVNrv8dstVUje3?=
 =?us-ascii?Q?PAk5p2BGh3AqZ0MAc2h5GlZWMrDYh3nCjccQgME1o5KQXQCsOqhf73blVD2o?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c849c66-30d9-474b-052d-08ddd3a3e999
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:11:51.0469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsI+vp4YEn6lvZrUcKVeWfpFIM6JO6F+JTxECpXoaztBjjiLdcJBHO25X8oMeQYoUZIm2+xR4R4qF8WWa0DvbSFl7tV0/EBP5GXGT809cJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7771
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

When the host ECC fails to correct the data error of NAND device,
there's a special read for data recovery method which can be setup
by the host for the next read. There are several retry levels that
can be attempted until the lost data is recovered or definitely
assumed lost.

This is the port of linux commit a9d94a2a9e5a9a58487020e2f45584b3b663c8f5
(mtd: spinand: macronix: Add support for read retry)

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 35 +++++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h | 15 +++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index a52cc91dd3c..b3418624e3e 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -675,11 +675,15 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
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
 
@@ -692,18 +696,43 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
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
@@ -1297,6 +1326,8 @@ int spinand_match_and_init(struct spinand_device *spinand,
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
2.47.2

