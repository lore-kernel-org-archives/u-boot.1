Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EBCC83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:44:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 343E083868;
	Tue, 22 Jul 2025 13:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Hpx/9xuq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94E7583881; Tue, 22 Jul 2025 13:42:19 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43FAE83837
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8dMu2Q6q1MOnorzbLHkS+pyv93F59sIefs6NcKT+EkC6SB/ivOUqeOSFUbr3jAlV9BdJfYiqIq/zf/CAPRsVSxhrZlxmjni6xE1kwB0bdA9oEw5LNkJHf6i4cKnTrRXlFI9p72oiPXxqRHD8vRgUqScXqMVL8vyqNJP2AkRnZn9iep8OSN6uKNwxcF0/aBgpa23onts1+rhjuGapYZIA6TYshMWzrUYjroszvhSorYIWltJu3dQQQENFDxzkjy5qmvhKzpC9yCC9Hlj2X5OudKu5zy5M+HjwG8achZ/LbfgcSth4QL2rL+2hFXFsA7/1XBiLaoh4TFqtFUrcS4tsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAUVV2us+PHu5utdyORwsp3hUmAJMtYChlwhD1s5Q0A=;
 b=cTqc71aaM3joQWK58oUktjyGySD8F8EMUT7N9XxHhAHmMalbPvJJjHyhvRjxbK2lsvOOG1q9YIAUNwSmdUk/CiSNdOA4oHHEJTbZ0n3cYw8260MycifxYs+Wf/v5wnqZ1lSo3aCFciW85OiQUvVbLRqp9TdLy/yW9KGQlA4+Se9Oky6/GTjDOjVPJi0ZWq1+ORiHke9VtLWxBcNJCL5v61IV5rUPzw37e+bPd5Hn+sshfY0AU4mt4aKysEXIANH4xjS88PVTOI2l90gqd2GhqK/R0cr1aoFr/Rtk7OSwG7RsPwpd7w74FNtStG+vfl5Vw5vROaLEOfXHJ0tRIXj0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAUVV2us+PHu5utdyORwsp3hUmAJMtYChlwhD1s5Q0A=;
 b=Hpx/9xuqHIqexoL/tbd3EWJXm7JL9hoOPrOEOgUxB5WXC5bL6Jh18M6sUy8EQD/YR9YQo+TkFdUG04itbjecGkNjlErVKAQQW1GZX8dsBoaea29xw7+s24QhebwCajGhnh1TCS6hRP7pRNSB2gb/mfpePFV/ezHQBQHpfWl5ETtfImTcCmQIqb5vlCnEGxjDLvpt8Vr6N9WnH2gBwq4GcaL3/fpaXzL31ozH+RWSDlFM7CsOH3+JjrGMxoYC2cpa3J8DHekxQmAPWIyd2bhnEHqefR90Nd0nrtO3RFeSBW99ZMIklRLzK88O39eT9X3I5y9tADRp4kHcKSCCy0Xx3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9908.eurprd08.prod.outlook.com (2603:10a6:20b:562::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 11:42:13 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:42:13 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 16/19] mtd: spinand: Add read retry support
Date: Tue, 22 Jul 2025 14:41:32 +0300
Message-ID: <20250722114135.768998-17-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9908:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4d0408-cda4-4849-6a9b-08ddc914cc76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RG8n1ziIoztkwa1hFz9ReXApqAyfUtQNbi4HaMYvEt62EipWNN0RJNFFBjCV?=
 =?us-ascii?Q?fJaOXRg2r6B/qkqD/0U6d3jvsV3UJtGqFVIHISLon+OmgvpcsYjPWCbBqM/Z?=
 =?us-ascii?Q?RXgdqBpMV/bpLTAius2iKpjtRzea/Nn8SXBxQsW2BiAyqt4vUoOVwi1mTT7S?=
 =?us-ascii?Q?tkyYHTcrDjvoNLh8bjrHdHLV/aZ++PCNew5ExYH0nSZG+1EiPdrmSu3jsGS6?=
 =?us-ascii?Q?ef6rE7F9T37T42CdBqdC/p+rygNQIBHOLsyrlHMcaKTq9EIJNJ1dZEUOXV3F?=
 =?us-ascii?Q?p+aCHRe3aUZ70Y89kF/QNTsCd349RIPMrKcBhYJwXslCurPEVYAaKLR4QDwk?=
 =?us-ascii?Q?7pNRe9lulF8nNUZ2KTFPbeQBgEvN6JQE9GGjS6SunK6FOz9mP5Hhk9FcUztz?=
 =?us-ascii?Q?d7t8WHEJXSCNf/X414jK7f8nwXNjss0+bDm2YtwnFVG2YUvW5FxfaBcmlxax?=
 =?us-ascii?Q?p8ndZ9A50sVqSdOw1Pi0oQvW1bUuxo9z3xJU7+qsu8zEMyH3vUtXD/iqI4Et?=
 =?us-ascii?Q?URF87M9DE8Afa6S0Rw1LByyH6G4Qu4PU38O7yC9FCGiV7euBZl1MtSot68J5?=
 =?us-ascii?Q?9uiZ11EEOXlbi2wNWQZUxnlRqrK4KlxGU5pwmKgPUqtZeC70p/jhhC0PdLd9?=
 =?us-ascii?Q?nQivbXHZKiEiQZHQBy9tFvqM9p4W5LyoclKwdXJ1w05SdOLZomd2lsYpwx5S?=
 =?us-ascii?Q?RIuwhWJqgnCrgyCZ3zrnZFJA508UuqB73oMUFgxrB4j19z8Lhp5ybQS/+1f3?=
 =?us-ascii?Q?HdQbdEShOTPG1PX29A4UowX6ORyWrDqR+S+phjmUuLd/1j0Y3pCWfrlirzyq?=
 =?us-ascii?Q?pHwLrFXQS2u+vTnPjpMkG2ucII6aCr7nq4g+vXR4BD6MartTnrYeXzznCqSN?=
 =?us-ascii?Q?S9WnStv7oARLq/oKWCk6cwkuxPHdtkJFGsSlr+kNZNspBBwB3B5Rdz8BoJ7b?=
 =?us-ascii?Q?/063yljmMKr6jJXo9/EfaOwbfw8MH2GEYu3k3esJsKsV0BZpr8mlOfj8iqEm?=
 =?us-ascii?Q?YOcWJV/o892STJVfgPY76SHaotxvzF7PLK1I4+ABeiOGPhFlGWPzc57cERiM?=
 =?us-ascii?Q?5FMxVBDo0N4aPC4oxyBnzaLOlWJlfxqxzQaJZk/B4LpDqOCJfXb4TqWwZ1c/?=
 =?us-ascii?Q?VgHG9wc0l/NgvVarJ5cq3U/TKgUmzvveDVBF3HFmbboDdSihe9SybHdyDaZk?=
 =?us-ascii?Q?57EFSy0hAgbNjcMzwvXCEjRyj+FAoLYMG3kxvYt68pCKjPKY7FmIrvkaOczw?=
 =?us-ascii?Q?0KfJbDoGAtP6wUPeIbXq9UeECsxReTbIoK5BmA8cjJxe6DFDYQDoka0otVjo?=
 =?us-ascii?Q?hbq728KL8wOMb4OM7rihd0r99QnTZwmU48YvFNzNu27MKFBt1gs89/GIPftf?=
 =?us-ascii?Q?e5U9Nwt0v3LpLo4vH3PKNU/dmDces56uRxDSXEdM6n7MmEQv+ouoIkY0T/aX?=
 =?us-ascii?Q?nztDj2vZCGym3GGVFs7cWxd+uGqjyvZQtXqrfqGK/l5i6K/62S+KODYPmam4?=
 =?us-ascii?Q?5VcDQcH9vPh/to0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kIFP5vcsZ2kLNosOIopEcbSluuRJ2ETjRiyAlrcQhGBVcwwrf0Q1IJctBv6y?=
 =?us-ascii?Q?3piJIjcFlzMMbsSRNpvYY527hF1t2+fG9GNw8PSowGV48h30w2J9JVye9VTV?=
 =?us-ascii?Q?jB/6ydc+dYtr/Coy2lvT88MJYPHMToXwxYBsXDNDR6fxzwiSWvnsFpkcrKZh?=
 =?us-ascii?Q?nxXVw/2C0AF0qQQBgs2mAqWlbneipDdtaTovuF93n3CovtbXvfjK43XyXSvN?=
 =?us-ascii?Q?ovlCu1tvKPxhf+/VIyfgqLEW/ZcZoDfA4Hkl4jrm2V9aXPFbccu3LckT3R4X?=
 =?us-ascii?Q?mcjxjkLLEZNvNvpS+7roRVSr9Ed6pmt5nlW+mbFN8lHZR6CqCPBvRimY/K4L?=
 =?us-ascii?Q?l2Hs5R9LARgYNgv0VfkkJH1a6uSWHN1aprsAIJeO9dHJrA91cPzz1En4V78w?=
 =?us-ascii?Q?eSbLSZOa0iBCbxnC3wGTUTBEb12CDyja0FVI/F8ILLVPYKUgGJVAi2diVkWY?=
 =?us-ascii?Q?eqMgLvVPZifQjFLKxFhtUcRoh5S45rltTTF2p2ff5odfIFbPF71tWDuHbFI7?=
 =?us-ascii?Q?BNXQ6UZso/kViOfiYwOsIzkZ3pJKXX6RY+xFQSt3vpjQrp/7pnYjJhwPqXm1?=
 =?us-ascii?Q?2LZVNUxggTeos32fLg8e17ObxKPxv/9pE1NVeJFwym/BiZYqT38ZKiKRXkW1?=
 =?us-ascii?Q?oRT5m1u4O10zVXvF13LQ3YaHFBXXqtLUCyk336YqmkOA3JwUol2nHBeoAUcp?=
 =?us-ascii?Q?m1iXtTKGuGDGEIsfWlxoBwgnNC/BV1vi6wihtxGOo3YFtb1m89RzIWq+ye6t?=
 =?us-ascii?Q?19T8nmwXQq6toPIUYWPGyK+uepp3wQ6wAMWTerb0tWZqT2jccN0jdR+jankW?=
 =?us-ascii?Q?jydIdhtG4vrkpIL43hvaKEvqZVYOkCRF8qCUJMFb3wwu6fwfE8+6LhNtI9pm?=
 =?us-ascii?Q?tBD8mMpa7lCqDojV6NgmKJzF047tFdiYwYSZjUnCC11Od8Cdy6OHcxIOb5kS?=
 =?us-ascii?Q?GpQ63kiugs2RQKu2Dqcs2P6wxh+8uD5HWEA+B+mUSMQ3G2KdIEyL/f6Vjd+V?=
 =?us-ascii?Q?dYpcsHFAZC/2OgqKuJbl4hcWa1MUrcXWN7ueMK0iH4SmtUkxjZlC3J5jzsVh?=
 =?us-ascii?Q?ROj9dYL3bqe9+al5pMfrJYlQ1xv5gQq2SO0ALozJjMv53njcXOw9zKcJNSur?=
 =?us-ascii?Q?xda3CjGDiLSPfaKqUS0dwZj1qA+gkLo1Wsy1cp4NEefsy38k1hw6a0nR1D7d?=
 =?us-ascii?Q?NQ4vxeTk9YTJ70ipM8iIdZrAxjKo7OH2wFwgH/FGHeSmYDTjhoKtsy+zx4xy?=
 =?us-ascii?Q?lwSxPctA6YAXl4VVvR1jxJuscyZZbpMLf+wFC/xhGWJxEJHJRxuI0nSdNQkx?=
 =?us-ascii?Q?LLQCGiLhg3U6Xx1ukMpk2YwlzlF3QpoHThyX7SAi4s/9cVVIMLrAYOWJKlge?=
 =?us-ascii?Q?f1ApNRaFRnGSOx5QWtW2ARNngfI0/i6cMnyoKoAZ1Y2bVoDcyDM7rQp9k1tg?=
 =?us-ascii?Q?3N/KRT+82q9mCETWeLr6HAzlp/+pR3PkdjblnMeRrbMhhyqHm0HIxQnAtr/o?=
 =?us-ascii?Q?iQ9Q2x5ndJ/FoGuvhVXop4/KKbW2ZXVO1oASr5rpU/YIlnWqp+smtGdYZNrg?=
 =?us-ascii?Q?jW23r7XwDpl3/a4JNk+Jwn6JDbtvTMrazCv/6uJeZ/oj6FFSz/98k5nWTuc7?=
 =?us-ascii?Q?hdwEV3E8FdVTMtarh8CDrwc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4d0408-cda4-4849-6a9b-08ddc914cc76
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:42:12.5562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZW8mwCfMOsu0nygZeJRSSVpau9A2auQbGAh1T+NkeoXPiv4OVpoa6XbW14B0zpYs95IlCohVqQMn0jxiwTElMi18Bb5ghaoNv/1mX4EvHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9908
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

