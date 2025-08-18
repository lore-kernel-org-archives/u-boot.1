Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6F6CA0EC6
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E28982A53;
	Mon, 18 Aug 2025 12:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="lezA7TOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D87F80194; Mon, 18 Aug 2025 12:06:43 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22D0682103
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ds1TLctlODpTvxHEEU+DlQ8UyFiY9yLmOF1qBvps02aG/2wRoih2Es9v6Y9nUDGNce00n0GGLYEypMgnvxTxu6NyJSngVyDjiQpQ6SH8k+KqaXZt3lIcqhc8RdlERpYPkUIuFoeFr/Fg9Loy3PYFgLTEUQQc4FlfiHryd3EtYGAsaee8pKyUvuhuDMaUMcg1HDZT8RRNjJgApqvEKTfMEqljLrKzf9tbz/oMNJNtgV4hFVB+Q9FHjf5tRK4xd8620FRVR31O7K4lDn2q3z9+7ZVuFXJ8CY/yiX84HtoeGVVjW3hqKaR1YzFwGY52RA6EWy9SrMtj6bCOoN2+QHf7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ahv04bjmFzu1Ogy1HT9gFFIxUzvOHKT+vQPrO6ih+Fo=;
 b=FjwJ3I7kiumyg2aJP0Tz0F4lX487YR5gNAwVSl12m5wnGTNJfDWUKIa+LNMLR5io/SZAm69bT93jCI+6xbDqL6In+MwwM2xje2+6Y0m7mXYMMhyRt+xd4MVWuTadWN5i1ekHQnyLR0Gan+VO0fML+f5KZ2+S1EsjCbYsX1MFUsUW6B9mXSkh/j6gS0NMioFkoVBPsQGyywIYpPJincF1o1h7js7RKnQGKIW8eUQyA4sES+Zs0i7TfWUQ7AKQ51mA/BskH5ci3aXxO3vdYn8dR+klAOslNPafczYqOqqsQL+guASYGDAJcixkZyo/v5iCg7f1njNjZzlkhVN7lpSvVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ahv04bjmFzu1Ogy1HT9gFFIxUzvOHKT+vQPrO6ih+Fo=;
 b=lezA7TOvAfuK2vCdsOGqU7LGIPosS5LRffd4iY02g7haKjDIbrauwVIOkJEEYq2sXDUcHOm23G4a4Lpo5ImqCb+A5J8CcKCTHJhZMqk85EsIzUDi6trp+AvC9AZeKBT+dW0yWwKpNvFsPWQH8e1lmJdUqLStQ09IYLf4DGmlDUhABdOXyxJpC4E3HfAXbLYlb8w7r55qAkv478FYq1O6a6pUkhRXY5IsnpjN4UZZZz0mvYpOvlZ74foxOibC6JXQQgpVsTk2VX1XpMfuyXD57yKMxjsTYDXJ0PFx50aduTSAaTwdAsXz5YLuhd59cO0UOrYDbhDgZTk1UAriXobYjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9719.eurprd08.prod.outlook.com (2603:10a6:20b:615::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:06:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:06:37 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v6 09/21] mtd: spinand: Refactor ECC/OOB functions
Date: Mon, 18 Aug 2025 13:06:01 +0300
Message-ID: <20250818100614.432931-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E2E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: 90abba68-bd71-40c7-b8d3-08ddde3eeb61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EofRvG4X5jx+KSmZPNXVPwMRsKi5BwWhKUeUrBNNsf1pWPmbOuTxJCUIIGsE?=
 =?us-ascii?Q?sV1u0glVJxleLCM4jcMoJ6OCLcDosV7C7H787zMEHP8efpQ76/sF8gXxv7dG?=
 =?us-ascii?Q?4QvTRXtDm2x9c+SB6+OJSOuhcFhtxaCgqt3/uxozIOiUNXm6WukVqEyWyaXV?=
 =?us-ascii?Q?yMDTqmQ0Nnl68aa2x+2NCKCdhFcGWfT9MdV6XW7n4CKXUDDP9sJrBbwbUlXK?=
 =?us-ascii?Q?WfVMmfTwFBee3GVAWmA2wZ5tuI/LFDUTlKKNrJ3eYJrcXB1it2sLhR8wScgY?=
 =?us-ascii?Q?TR7nuMhqkHKaEPLx4qpGWokVQH6fqozHbajRTiNwiyIZYl4iGEUp1GgcBE12?=
 =?us-ascii?Q?ur9J2v4vgejFwhlD6HCCJ6RyGckfyN/ogkaVv8seN4zAuhIzlRyJUIEUb//j?=
 =?us-ascii?Q?svyd3L3c7SnK/0cThiSqwHdPvNHOZVxs1lF86beonsyA5wy03NPAM36yg6TQ?=
 =?us-ascii?Q?0Qdi+x8AWAfuqTy+jk327pl5XZ2pROqT8In7bAGKvHz6mLknm6zz80JF+f7p?=
 =?us-ascii?Q?9SF4nAE1glltQoauDV66vFai2Kl8GHt6gHcX2lzebE2Fxg4ZHxWzTsnEPwYI?=
 =?us-ascii?Q?TGduISWINEYOADmSe/Y/sjULcXc750Ql/rnxFKCb49DVwGPK0aeXFR8V9PXJ?=
 =?us-ascii?Q?tRiAh69nuOgaQGQbEkTDbKv5/dIM1YU1jE5QGzaxqCQpF1uLLv9g8A01++oA?=
 =?us-ascii?Q?TiB5m8lOglg/m4os+RegvB7KuQuXO3rrbykQ0/g5fAQH7E0ZP2ojQy+owFRs?=
 =?us-ascii?Q?vC35RzaQ2MAmo7VAnDFuEO02q55itSsLUG2tEPEhn+MG+iItw+WLBR0yD9Rd?=
 =?us-ascii?Q?1W96c4E1u0zcIWHW2ybhRgfUEdsBI9aSoqhfSbBQkzojuklm8CkgSkmEEUuX?=
 =?us-ascii?Q?QVy2dKL2HtwgSUloheG4hiJmuC3anqQvoMY3f0V6CUXf43Ucb+RuX8RC3UBh?=
 =?us-ascii?Q?VQLQitk5vDLk3ji2vF9bMYM1+kWu3Q53QBD1AEeI34MCmp/aO8db8XHVparQ?=
 =?us-ascii?Q?GGfrpv0xUHkWTsPshzpJfNzZQJkrZaLbVzuk+PShM8lJ2xDEu/Pd9QbUjYLC?=
 =?us-ascii?Q?Y3M9a894clm6OuYhKXxuvOpdn0Jf/LH8IfD68bQ4HovFN/jRJdGlvd3toVpi?=
 =?us-ascii?Q?AcXCSGseKuCNe2fhRahlNJc7PCqx7m0VBYX+4cIL5Y5YAM8viM3ylz8WzMnb?=
 =?us-ascii?Q?xEw924WgmGl492zRVR1qrdWZRIiirBHZtWV/7EAsmNkxXYQp1ZdOghYx2sb8?=
 =?us-ascii?Q?JErh3CKadTMYzVIZkorvPxvibyw5DyK8G+Nnsfyj1JdKeaVyvNOxJ/f9hCev?=
 =?us-ascii?Q?yELmo4bGmvV5Nzuh2PmqJ3O11a5vcQ9+dRKZk1w2TlG8ebVOvWiGn81quT2A?=
 =?us-ascii?Q?RLFoeFslpQCxV2vaOyJ5sJkPlUQMgwxOG6bOZzzigB5bmIgRnB2+amAn4qf9?=
 =?us-ascii?Q?aKQRZWP/5pHym48kTj+wYjowkKJAeCDn7H2iL+KrTgrUXqSUUNgw4pBpQi99?=
 =?us-ascii?Q?oYRFDnnUoGvFs0E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zb5cJzp4gCDRlC5l169YaTNgppJ8u2QwtKFuij1MbQv13ou4Wv38XB7Vq5Fd?=
 =?us-ascii?Q?PqFm25PgyXdzC9iC3XEseSG18o/YO1pBt5w+4zk5J8z0qhWCDnelnA1W0wCD?=
 =?us-ascii?Q?kixNUQLXihXxXvfjhaKL0KejG3do0UC5DGUhiru0rxCgG9Cvs0tkoAdJe5jq?=
 =?us-ascii?Q?jYfW4NPd2PXNgFr3lLyi+NrzMWq9QPUO64sPg23IOP5Tmha2B/2QfcvlwY+N?=
 =?us-ascii?Q?GZzjLONQiyXJCk/7KSJHJ3gwE5GUHVojaLtHXmc2lkXu8OGwvWQljytm235Y?=
 =?us-ascii?Q?mVb+gcvzaAFTUMDLxj9bQ1VezmDVraX6uSvRL8YDuDZhVbZw4TzvpJsAKVbU?=
 =?us-ascii?Q?hq5Ei4DC2HfTg6nAUShNEytXDGtLAwHl8qHFcTBQbbYfgCvkf2KypsybuYYV?=
 =?us-ascii?Q?Qqpqk5Da9sFAxAAlxWUR+N3bMOAnIFKvXfrfi3hgJ8KE0gr0OqWxXvk1qS5m?=
 =?us-ascii?Q?Fe7mhlhuu1r0BYddHQBVWq4D3bSxuvEXwuQz0ivU3B00+QRs2jZDX9lVCoc/?=
 =?us-ascii?Q?rIKZiSjdNZpbXog9Lt1VPQfrLPhogecXEzswau7T06xruaChb7+wPx/3/g82?=
 =?us-ascii?Q?478IqDMdUtXl1tkgGa2B8LOVYkSgfOfX3QGfpqVsUMJOTYygaQiC8tI+8OpK?=
 =?us-ascii?Q?lBW2icDsBgHbkdfpRz0j8VZ7h3D4fWBN+JufD3lHnmTN1A81taalp8p0DNk+?=
 =?us-ascii?Q?UDg6kwH922tjWReWYwJR0/Vwzcxi89d9td0yJV+/5U3smIDwxO4yk1Vyqk/K?=
 =?us-ascii?Q?BVL3Mvm58UIDEHOTRXz4pJuO0CSk23esskVaWL5hwo+UMxJhkqz8I/tRQKsV?=
 =?us-ascii?Q?flT+aUvJo6CMZoblDrIdfdxe8mmm/F/+FBAEl+fJUqKYwk2Qj7+/50wCC3s6?=
 =?us-ascii?Q?EphStlvVVc/Gx3wXIEPjjb5bYEG5ZU+oBxixrAu4J5/PZ7YbyOsjkJRX7phj?=
 =?us-ascii?Q?WRIcWnKid4TFuZm/ToGt/DLfmCRr1TRnveN/Kp6WKKjuQ7rmt+oPIzwIvn1T?=
 =?us-ascii?Q?48VjKtn9TVKV3Dqsee+EpAd91vbXkFO8b53kLMbaGpy39YThsCnQJz71p/88?=
 =?us-ascii?Q?CyO5Iyn0QiOTlbUQBydVOAgnn5SaY9lfwu4vEuX3yRA8nMjbq4tIXbQE7KIm?=
 =?us-ascii?Q?FVIG0lBzfzLr63t5BDzl/gtX5inmkUMrqeZP8lF5Qz4L+Njaj2RLQ/fZAq+w?=
 =?us-ascii?Q?MNyd8qwbgFPYC6FWaasTMSbTCT/VOVR2QRDWYiGBd190UBlFzNAik/ZRQDtM?=
 =?us-ascii?Q?NFRKMWS+aeKSe20Z9M48uCjj5SQijExQdcA/rS4B0f4RHvAUiYCFejn5Al2Q?=
 =?us-ascii?Q?oEoXSXlyRXWv8w36Cmk0uRRze8XmQ/mkZe697W/cgl16RfjSNXXk+S95+HfC?=
 =?us-ascii?Q?emsYg3UKCllzDwMFB0y9JiHSTBSziQrPCT2lvCW0hrYwc9/HrM29wuJVPFQG?=
 =?us-ascii?Q?nUSzCihUUvea5ZRB9qtPtL2xIhHRf9L0nHm/9BumiypN/P9//jLKYjesuqEd?=
 =?us-ascii?Q?X+N2PIsfvZA+PgpXty0JRJb6tDefMAbHxrMteCT9vwtyzzQygQ6HGjWBOAY0?=
 =?us-ascii?Q?P7HHZ2IhcKeMkBG+reIB+mXqiYbmwH3RW9ub0/HWBSCktYvQo2J/C8QMzXiR?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 90abba68-bd71-40c7-b8d3-08ddde3eeb61
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:06:37.6926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRLLhm4IHvZkfU8KOucK1DBmKwRKzHyBfw45V/X+NjdbiKiRdU7JeSgsFVhZEfVuYeCu7FnehGqtirhtXx6jKjRG4iPB5STLcPbEm/kegtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9719
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

This aligns the code with Linux 6.10.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 115 +++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 60 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 9b48bcba496..ad699a0c6b1 100644
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
@@ -425,9 +478,8 @@ out:
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
@@ -457,35 +509,6 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
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
@@ -1086,30 +1109,6 @@ static int spinand_detect(struct spinand_device *spinand)
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
@@ -1199,10 +1198,6 @@ static int spinand_init(struct spinand_device *spinand)
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
2.50.1

