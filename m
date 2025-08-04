Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE475C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 22:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F7948407F;
	Tue,  5 Aug 2025 00:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="cBceXQKr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4818E840A9; Tue,  5 Aug 2025 00:11:54 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D25B8407F
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 00:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8AUdLFiUJx/x/PKK3LRakX0U6iQqXE02MZ083I2CnNqg+HMEXMozhWThLyEfoVml4tPw23z8zMqsOe7xrsc0ltGhx3PTMcNK8loCxHwcYr2GNbvvQrTyY7e1QNVJoaIVF6yBQF1BKY+J+B2gZtpbPTctrMSutT7I849qmTcoqcSUaY0WRCRv8y9ZPkimz9jBen1FQtne+2RoDWzgprjPMpHcglyIzCrnx4X+rTrackyPC6ZTt+kkiRjVwCtx0fx8shzIz30wezKIa3QUq87JqA6FQ7MYuWe3Xt9diwqcooIhfW14PU3iDV6/virQIOV4aC94FS5cHu8lYnCRCuw4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGvz5wg0oQsqHq31pmfGtZL3liCwN1f2e3tEYmXA/Fg=;
 b=l5v+ZBdimPJZ1TqIsHsZQKW4aQrc0OzCHb/IO/qRQuh9ORjfDhfJG270nMIYbdda9MZmdkhBaiKjY5NuOYT2lCw46IFCpTofYttbsdbl9rDY0Y0jkw1ISUOkp5zLH4z9cH+njzTxsw//C1yld6Ydk5Yx3xWPcby2cm7Bq04VlhHOaxSEEujHPylDOUzEEJlQJYKAZTFT+ZgvNlRShR42/sF2nA1HFj9FLEENkuKJHlRuq6VO770XP+YgtLGfb1upAfCV2EB3E4DRCbk2UtOiQIQuMD6JVaR2elifREsBLuFUcGF9klEnXXCRK8N3vOsncaVtyxIY55Wbs68nk8wHnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGvz5wg0oQsqHq31pmfGtZL3liCwN1f2e3tEYmXA/Fg=;
 b=cBceXQKr6b/rcP7SDWBOJs+HkReHsRgNgNUXjbxufcG6ioSHlU3uVK0bcmO5Zr6oggj+42ORNUtKs9qbzUt8j8sC0rW2clgi2P/LEGHdUhruHIQfVLK8kXiChJ+2UCT8emvz84J4MvAFwDaI4jRrhhagFx3AKXT8MAPKp/c4cDMsii5ItM/g4cWYWZCZLVjZngkDp8lpncNIsWMduD1dReirMhiQxwq8aG0QnxDoF6/dEAKDKFSUIYgEqKbTwUhR7DySiaTMnDVqBHsIySyoUCHMKCBZVqGSJWviGcqWSvvtKXzrtQLtld8lSS6F2d7VzeDbfmhszwp76OuCvKy1aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7771.eurprd08.prod.outlook.com (2603:10a6:10:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 22:11:47 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:11:47 +0000
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
Subject: [PATCH v2 13/22] drivers: mtd: spi-nand: Remove write_enable_op() in
 markbad()
Date: Tue,  5 Aug 2025 01:11:13 +0300
Message-ID: <20250804221122.1420516-14-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 1914e730-37bc-4648-7618-08ddd3a3e769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YjxDxgusBGu7RLVrtQGIThHq+M9y3ZiWBUn7EINChYN39U5KLYq5x4FE1OLV?=
 =?us-ascii?Q?PAC7JPVAJHT8kEanMqU3AVTWk41ItJc9iYubPxpHd5HFO11YoqrGdgvGeQh4?=
 =?us-ascii?Q?cIsfo2xXQMKOBi5GIt0lWjOztIXcl+OzADh1k5ui67sfLccFCviLRtdReb80?=
 =?us-ascii?Q?GXUN1Jvkjgj5QRphrA9rYSja3pjzAEAQhOw66hQf8asgypA1n7ZA/0jrdeC2?=
 =?us-ascii?Q?mpnA+qQuM5SKmeaMsAP1UdGFAxeqqOWcWRwSdZ20qogNBGX92yJWK+a33OXz?=
 =?us-ascii?Q?OUZTFgIEQo4tD3x/M7MVbU7VrQ6pdk0WxNABKgw9WF3wiQ38hSh1bZehLntm?=
 =?us-ascii?Q?cLMwguxW7jZfNOduKW7LKgEFBl1ElLkFT2Ca5z5K5UVcf3DsbsLLfaQTQZcZ?=
 =?us-ascii?Q?7FgCqnV1nOaDhumld7rxn7IrfQEJJrXJoTivC01wekHR9wbLoOXYoofxVrc8?=
 =?us-ascii?Q?kLtqp18U2X7adZeeX+G4SHoAZloqmQV/eWFPJCYx8xKVnxuVCCbSBKJti2Ww?=
 =?us-ascii?Q?LE1zwxOi3OZDReQuZ+6ruSAPIMQXhOHP/3S9vK9ArDI/PqQ8qToqdVn/0BnQ?=
 =?us-ascii?Q?R71CZ34oM/DFcYR/zaQe4GjMMdA2M//xIzdnlM1JWpRaBKcRR0wWzT8BYfOQ?=
 =?us-ascii?Q?GwJKSzd1AmYDHe5dIm2lii7oCfQmE9kpCjTl5OvVT+djmbD8h3AkAnm/Pwtl?=
 =?us-ascii?Q?DmoSa8Fj6aSzxLCCI4IKf2bQr/G9jN3DjHQi4l8DfBBue0nA+yrbLvYv8nnJ?=
 =?us-ascii?Q?JpDq6w6SGTIRDFUc9/RzD1QaXOhQ60cK8uBBpaQLQ6TpzaoPAqGHkRa5c/s2?=
 =?us-ascii?Q?b9hTwow5bf5zCu568Ms5uQj1ysCifyDWjNNxvX0m1KXoSnwQeQ7auUWkA1v+?=
 =?us-ascii?Q?OIkJUM6e9N3Bogv71rFeBcZ7wHJHELwr2Ew7i84oNWvcapgc6RWq+tGz3oeO?=
 =?us-ascii?Q?IZ8d752CmV8ELpikOoRsxwMVGv1mO2nnCSQdIfnJtJjcjKyaVsprCQhZqCtD?=
 =?us-ascii?Q?B3AXFtm5FUQC+/1iRxvRofEGzYBO2sS55XYdewV/SfAusiItC41DXkjfoMJe?=
 =?us-ascii?Q?uup4yprP5qsQiMjKv6FccTu4QAKfnxBr3k7QAoMzFskWWBLYoXD5NIarzCTg?=
 =?us-ascii?Q?m1V+PtP2+IPp22+4GQgOyz1c42JRBbXUCZRLKdIt1KUprip998gtOlM2GHx3?=
 =?us-ascii?Q?M9pXFlEYZ8oGBSTgkdqbjvfG0cO2yP81vgMmoxxISSuR3fugLOXIhPMoob1K?=
 =?us-ascii?Q?PZm1002DDT2a0RegBTV/90bjBdob5OJE5ptnr6HJL7EN0twAO798YD9UF61M?=
 =?us-ascii?Q?vlhaXMxsLfRmBHm1HIs6To9gldLiSauyL6sb5zd5UN7aHLnKCDto0ip4MjZa?=
 =?us-ascii?Q?yn4ERzEnSvxcWpQSzRd28YvteRqgOJSRVyBYyjRpxrjpkeTDqSorHkrp17Qp?=
 =?us-ascii?Q?2VOVELQAbNTnrr/AsRNUE40Q1VK1Ue/jZWQv37HR3fAst0SU9iO8HEZ2zDtA?=
 =?us-ascii?Q?3sScMyuUMrjPJy0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rDLOx6kXiuwNzgKI6I2I7e0LHFqKFJAedZYDEJHACX6ixvfsCrgvnVcBnbFN?=
 =?us-ascii?Q?EvADWoWZMRUtPfyph+FdtIn5CTIMd5U1vUA4s/XQn2IiIXgKuVwyi+aipa5B?=
 =?us-ascii?Q?l6h96ByBt8p6jnnnYktzMIY9KTqB5uEdhaanidKEoQJSZBr7Xi4uxh6BpYvw?=
 =?us-ascii?Q?KNkv/5pLwfXBGQCXa+nd9cxoiHmyTEPLvKYWl7qD3713BckUEQb+FVpEPcub?=
 =?us-ascii?Q?vm15ulEWkf7wyLtyyQeEg4QB/7/WzIe9HWrPMmzDJN6N9Lmt7wYIoM25iLFI?=
 =?us-ascii?Q?hW2vUsiH4s17yNYqTbdqzDMgn7Cqk2+nll6xYcrBu6kkKxdcGi3uN+i8QLo4?=
 =?us-ascii?Q?UIKgxbjZkYvChJYR0jq2b4/tQjvPC/wkI4OHDFteKw7Posfj74kkmRpK+Fhk?=
 =?us-ascii?Q?BU3q94PuvEupfUVkjTHnXLx2+2auJvUfQDt1PaYvqU7alXxPHNQAEcSFFP8q?=
 =?us-ascii?Q?6aM7ov41+OOHZk1HVUS00jPiJD0FlMlt8eeNc366K1wh3qQr1EyZF1y6Z15f?=
 =?us-ascii?Q?HcRLqUZMUEn4FpIyhjudDDp1a7sB09dna27/5Dy3mbR7E7HKjdOMWYpFnzg6?=
 =?us-ascii?Q?ar9RH0qAtkoSqoOC9HWAUU6FGc4ime3V1ajhOMwuHiEr2uwcnkwYatBshwew?=
 =?us-ascii?Q?2ot5oVFKThg3PITyrXRVDVJ8ROqwdUXrfkJ0c7d7d1a6Ls60G0UDEhSqUo6a?=
 =?us-ascii?Q?K9+IimmQ5oCOZsTk8lPS3xpXaJo5hVQdrDOPkCb9a+bnV50oNSMdbbWZHvSR?=
 =?us-ascii?Q?9JDfkJFoYnVICkaeIDqFRDCAqiS0KkcGnGhlJW6JgxNYl86FmYhL4QwK7cw5?=
 =?us-ascii?Q?sci0nKTPzaT99V7FMtPE8yp0g8nzVvvWlUTMCfTU8vEurLgU7GR6JUfSar+p?=
 =?us-ascii?Q?wOpU2GlbEDC6VSbuONa42+OTLkBtMP47bs6t/0DwM88xkte/pDoPZ5zJjuCi?=
 =?us-ascii?Q?eKUORPN0YrOp0XMpBy66/RhPiOMjWDU6tvmNi9lRhl/LZdykEeo7eudz4WwP?=
 =?us-ascii?Q?ng1G4mEkY8unx9JrE7KA4A92EfvX9Rn2CV1Yip5nVxdOqrPY2pZoE4S6xEKT?=
 =?us-ascii?Q?XKg0bU94seQDcMpoK38zLqRkJboYfIq0X9gc1oKrn7/OnUM7CPNCxfVG6mXr?=
 =?us-ascii?Q?oK0yV79KfpANs3YjZmIPJpZmTwJ/BgwmQ6KFzWRk1QtCBwKhHsMzI3X8a0vb?=
 =?us-ascii?Q?XTbbgztbGM+wQFlVUEL2KdO4fuLRolu/EuvGB+K+lyLTg9w6Bi7FGXA3aAjb?=
 =?us-ascii?Q?EeEnJ3gOQu94UhR6qg6wVwxv/V735wpc3MebLjKoXMKPlggrPl6rPboWrhHD?=
 =?us-ascii?Q?xj4lJcK+//40priGFktiHhAprTKAyOoH9J6LoyQ2eFN9pfrjStiD5JPDc4tl?=
 =?us-ascii?Q?9+X/+EhuYoQSa01e59c/U1H3F8lgEGuytDLJbvtFunB5DaeztzuWwdY8dIQY?=
 =?us-ascii?Q?iTMNbMy0I3kiH9NmmQMiY6o+ldf/ex0EKV8iN18W9wKLeAfQmXAaWboiq0X4?=
 =?us-ascii?Q?tA8krcnQ31CcfLIOpuzU21Fzo+gR02mKFg2nUFRSEk9Q+GrEHsPMVQMWtQZ/?=
 =?us-ascii?Q?34Ltt3Xor8ocza9xQbeOZZwVdyNHLBDCRYUllQfsIiys+Sax2fN4ZBdigC5U?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1914e730-37bc-4648-7618-08ddd3a3e769
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:11:47.4243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlNN/sax+Tsh2Z4siroRIM2KAAQXrgeNMwRkpVVeBpqAop2Ab8oarJ8v8rAClOmwYn+Igzl4QXcyuRh9W5RLTdxMwSWjkk6JYHTgO1hIABw=
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

We don't have to call spinand_write_enable_op() in spinand_markbad() as
it is called in spinand_write_page().

This is the port of linux commit c6858779f1f549442ec2fe2f69800d8e9cd904ce
(mtd: spinand: Remove write_enable_op() in markbad())

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 0cddf2dd742..9f150eb8585 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -783,10 +783,6 @@ static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	ret = spinand_write_enable_op(spinand);
-	if (ret)
-		return ret;
-
 	return spinand_write_page(spinand, &req);
 }
 
-- 
2.47.2

