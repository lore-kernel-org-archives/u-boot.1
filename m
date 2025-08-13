Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A247C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 23:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4770838AE;
	Thu, 14 Aug 2025 01:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="vnoPShdV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18E658388C; Thu, 14 Aug 2025 01:43:38 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EDBC8383F
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 01:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/h+YyJJz2o2Sv7kv9Kf/azdIC6EXah4sO9r1vF+PE5fJTYsIgGY/2N/PV1dWDlRMz9nmmosC0gwprzQ+dKUbnEQsdRFWexM4Frkal0+DvL9Nxq1zZ0GAxsPH21PnZezP49DjO/8jrCYAkUUQHyUij6t384FPPo95YVquYDF+Xt2warW8CUcTIJZd8zImhwME9QfB+P/QBE9rdRUA/5s6LF1cRJvLu3/M0Apvq9XlieLdMJcW+APDUKN5LcysZl2nSJJYStw3Yov6miUt/PxNXjhRepeUb4Yr9Xmaap1/mtOIk9WMsZFsSOI+GM0GSwWvvfYmDcx0Vc2wBUMih9O3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ahv04bjmFzu1Ogy1HT9gFFIxUzvOHKT+vQPrO6ih+Fo=;
 b=J5dbIqsRLQG4vPjmmh4c1NWf6bor2PrQZYNjQZC88aBqV9lHF9t6qO7LK3onENIVsz6NDybHjHXIWca1QNsZk3Ic5qofKxx/tzWQ+ZEnrhY1W6AEO/rmOAMDEZAPa5DzL23AOMuQSi/CgWdpJ9A1prnVIcg/Gig1v1tjbYQ4un862F53Dj0sb2g77tOVkV9OBcS1RkAsN/wlfhcZOunznZJwqnLtt3ta95cNteTPAcPnXxvd4ovEp7KeOLTjPNSAkaOPZVAU82aoFVeuucVEgfW+sbYBRNwp23bluviD8FbBd4Mta3lKYxr//deWq5KSB/gUM+Uu2ypQlRH9mB5pHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ahv04bjmFzu1Ogy1HT9gFFIxUzvOHKT+vQPrO6ih+Fo=;
 b=vnoPShdV3lVxut7t1mzD8M4EuoP12zTAj1zc5/52O8qFuxXIoHuCZPDkwiKvG/n3Csd7H9smBfWIGLls0M6GZZGYBv3Ez7+8GwtBGIYDrDw0b+labGcdD00EOsU+sU2DbySlWJ/0hPXlIgCOg8Mreeln+mJoB7UzZVh+tEjFJzps02Of54E7yHNZY96Id2+qFcBZlQLLBLPtsA2R/dpzkP+czm4I6fML/ZlbXA6NUYgwU6OjXvdTGAdnqccSvf+rnG2AjuLCauye2BTfsYfTt82jvdYiybEnc0WMyF9iu/qUlUmY635oWmopaePLjpEtfk33XciZEy5wlLEnVQuCuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11021.eurprd08.prod.outlook.com (2603:10a6:d10:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:43:34 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 23:43:34 +0000
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
Subject: [PATCH v5 09/21] mtd: spinand: Refactor ECC/OOB functions
Date: Thu, 14 Aug 2025 02:43:02 +0300
Message-ID: <20250813234314.3945708-10-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 699d1f61-5318-4551-83db-08dddac337a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n3V/WAfJblmk+aDnEE6Dl8T95M3Q4fCBW1LCc1IfroeraO3ej2JvhIkaPP6c?=
 =?us-ascii?Q?RqWdMmwc+qI5J6Bc8STWmjZxlcUmMdALwW3/k8kFgz4jgz6gOdeOw72iCc3H?=
 =?us-ascii?Q?dYWPkTFa1mKP5/npNeHVdtMDGthFNb/jFqTswDxdLZ15AR2A7x/ee/oQYBdH?=
 =?us-ascii?Q?QnZM+Phw0d1/Y88lgHPqJiGZn99ogWGiyX04Uya8qMb33UPDeEASQA5+PBqa?=
 =?us-ascii?Q?Oee/CmQAs2DQ3Shy5C+txMD0elEm2hVCi9/zqvCp68cBbi/bPMShmnUF3SIa?=
 =?us-ascii?Q?LWViykObVwLj/oe/1dEhICAEqrqdSdAq0QDlZ8akIrl0Ska7zqE+lsup0h/h?=
 =?us-ascii?Q?CvdSchYZzo9kbJU1AURcJpUqdyXL0b9krBV7H1vPY7amM0sgKyrQwTngldtk?=
 =?us-ascii?Q?zmWf9E2tDQGL3E+ew8ncRkUg8CwbDDYcqKQpBiedgW9YAGffX2CI8XDOsnUL?=
 =?us-ascii?Q?QHxVfeh95HfMhoRFnj8njZU7yPqFU/tQ2TBWhZy5OgpbaYJAOCPEyyWW74dg?=
 =?us-ascii?Q?XoI48HhWiwWqjzPN0bosS374t4iaud0tootEnQhNyaLrtWJ+YYuli7FD5mYh?=
 =?us-ascii?Q?G1MwIV9hiPzZ1PWS7jFqx7I6+RJwOA8nsOsqET1ojmA2esWSEQvsqLAbj2Ow?=
 =?us-ascii?Q?onemcqyx+rJECfd2Ii18XJ+4P7qsrUAXPNtg9fCZcS3Zz6ltJi3gmUixw/JC?=
 =?us-ascii?Q?iSUP/24xOB1Ep3T3iXrT5vd/l7uDm7WmjuRZgaEHyp9PQb5Z1uE4TClj/d35?=
 =?us-ascii?Q?4hJtus5xqluXpcZtE0WdQGISnljeCDXh3T2XsuIXdLA3nagaVqA7fJe1Y1HN?=
 =?us-ascii?Q?j+HunX3Dl//GWYc7QjLY8bk+CnOavlcWmmBBgmq0qW/ZpOFqCWhmyn9Lx4I9?=
 =?us-ascii?Q?XBWJnIxs5gWS+VoBOrvR3Yy2qBUTAmb7gppv8b4k9fUaENad4I1An8EJXlYq?=
 =?us-ascii?Q?mDgd18FRxBTdgJ8h6xFiR28RbdB1Ji40aOIlr8y9b5fXW0X/fe+DNVeFxkCk?=
 =?us-ascii?Q?CGJNO9GHbjIq/wZu3ojigeC7bFE0MUVyF72TpUguRMayH/LLlu+BEhjMNbjG?=
 =?us-ascii?Q?KtPH/OYEWii6CEKVLmOTTcIswztzmQF13KRJOWV+Rh4g7xkW2XhXVZjMSmUI?=
 =?us-ascii?Q?TSa4aliT4rJ59rfoY5WwtIivVz4Ki7uc9vfAqglitXgPwBsGPHY0mtm45gXC?=
 =?us-ascii?Q?jT8DH2O9NtgnUwxZ+aDWywVCCHMXD0oeYBk7lPfuCtVHgykAbQABhNWA67G7?=
 =?us-ascii?Q?K4BUxpwmLrIOOO2xfobHCWzo2KMkW0TXotfPSUpw2jaLfGUs5xURXAsApa+J?=
 =?us-ascii?Q?acPTX58AMBmrJ8Dm+7laAewJfP1SQlQL7Zarx5M4zEbsY2x6BgFDKrAwnEwO?=
 =?us-ascii?Q?hISNYfN+GyI26GfIwmLHwKBoZ1Jfa4qSfbRMlSQATUQW88/hYul24eLyRXKR?=
 =?us-ascii?Q?bpvLMmjuwYmdOQMcFfxxNbiInNqKlzujm5I6C327XiePPtXA1B2y3mkmkxhg?=
 =?us-ascii?Q?rKzrfUyZwBwkVbs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UGMDqjUer+fW/vocj1sICY3UVZo0zIkiTxSmD/beP1bNAS2ig6qsIL3/vqv3?=
 =?us-ascii?Q?kQoGvYiHFLKMZ5ibqiKWK7ototuMM3SV+Icgs3lJSu8gv3Mk5m9ed4UKxpGE?=
 =?us-ascii?Q?zpBt+7s5QhotrHqadDx+zH8CvLKUJBoP5GNCLpPY/t8E75BT5zBjsDnj4fRB?=
 =?us-ascii?Q?TD7ZyqXA00Cmq31fmY/t5Udbovn2ja1WUmuvbJb7FQzS6vBqTLHd7bHm3wy9?=
 =?us-ascii?Q?4CNs9c44Ni9ZORp83+PQ3HVRUVdxydxWsan69dsmTEJiQCYYIKZVUkrqcEln?=
 =?us-ascii?Q?xYtaR8b6Xot7BFRLrGpOL7yECbb61LRq6kjQs18O8YN/xLd4X8GGuCki5S4I?=
 =?us-ascii?Q?tou7nfdOf5LZLxEa9FpBmu0C80ZKfBCoYN+tHXAAn9u84cDQmRQ2Gi3eajRt?=
 =?us-ascii?Q?2B8lxOh9oeIUM39Bwy5Xnseqs86PPuM8ZKoG7qS7DpdK45rEljkv387JZ0tW?=
 =?us-ascii?Q?1zoE8h8seJr0oTRWitY4o4WSxS3wLGTj3UZWWT871dOT81xEFpebEI1Ly5xE?=
 =?us-ascii?Q?p8wnwHCTQM8qmBVoNLNqdPoo0oPBxL0QomG8mfbQLi6xkHunt6lCv+/SCy0Y?=
 =?us-ascii?Q?yftGzCTh5QJgZCj8tMR6ioc0zpNRpjKEa0eyRmyKeUN6pKgZH9FqXCnlcHaP?=
 =?us-ascii?Q?PYGqj+NPT6s02BzuQ5V0qeaw3fipJ1Jh4mNNTNu6iyEHs8pDJCPkcB9CLFNf?=
 =?us-ascii?Q?xCze7WTWHI2W/GQJy4GXWZ4Zdx6Mdq3BarXu4ai3SYBmro9ENI0l1tU+2A1Q?=
 =?us-ascii?Q?bjYokMbRozU29w1g8/j8CDW0Szw/Qj0HF/8jXBXQtr7jeOFAErkISU3oVgSO?=
 =?us-ascii?Q?nykoaPa4rjXbRmOjoGvkOJrO5QmCW3p3BaDOHUYqot7rsOtuJpYBzeKDsUxD?=
 =?us-ascii?Q?gHa/SebXv2Ora0nxCxrC0DISV1TA9owEhrnr2guJLfOf2BG5d8rll7LtvBP+?=
 =?us-ascii?Q?XvOef+w8Pbm8S4ETxgWO0FAfv0fjCYojtdviefeNXH/DalcTTXgNL9ZuwWcR?=
 =?us-ascii?Q?O9+1/seU301t/7Ib9rVGSCkNSpFCZM3kU1CXEDw/Z2dlsDqIt9OrI2YMvVrH?=
 =?us-ascii?Q?OrediNQZfXuTpoylajR/7i7KX2EtU+mU28ykaI+EeBwbjjvaqX0jjXV9VmNo?=
 =?us-ascii?Q?vIujMnQVUh7cvwm02ppxHasdvsvjO0bh/by8JGUzH5zqz0JvCloejwyZuRSW?=
 =?us-ascii?Q?v5qTX9d0lrobTuUxxZzyCjUlnq+Zc35ZVRpR8rdyHcknULvVGnXI1micAmai?=
 =?us-ascii?Q?LyuABxIMsPsUcASVRHZ7c/7TqgPUUjn9bOrCZNlYiGflOggK0WmVPx5Uc+XH?=
 =?us-ascii?Q?GPcS48zvoHNDHDDTOFVVnj1XxMbL2W1INdFYWG0L++J454Js9dlnPnDiFZJj?=
 =?us-ascii?Q?tDA0G1mW1vkU0XvgSDi8SzsdXfIiaH2Yyb2wHJYkl9o3i1nlq3tHNVYkLF/B?=
 =?us-ascii?Q?/Gmalni79bP+8FAcz3c35+ZvFW9HW5+eSAlQHSvNxjcRyykTjDlmEViaUrT/?=
 =?us-ascii?Q?o3wgSsI19M2czFPi/yOaklz5pShyq+H3k4SSF4bBZDfsGzSFtDi6nqCeRdGb?=
 =?us-ascii?Q?dKFVk266DTu5N6IPfFUKhM3cbJYCjroJxPlK90weCiF0SVK9Q1vUU5QEp4ih?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 699d1f61-5318-4551-83db-08dddac337a3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:43:34.5128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdnLKsUNGzGKBQ1MjbraeqE1UgfKoSqb+DvOSCQmNl8BPRpjMtdGcXWmwFltEEGjDvukDAFS6jrPi/I7XsnvRNtW3ndAGeN0xssmDgTxLVA=
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

