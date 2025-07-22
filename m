Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BB2C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:43:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9C8D8388B;
	Tue, 22 Jul 2025 13:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="CJmI16al";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73F61838A5; Tue, 22 Jul 2025 13:42:11 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87D8983870
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:42:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWw+yXPvyMnull8mxldUK/wmC2ABzHcOt7enMQuCESfoqfPGYEFUBZnu3Cg+Tpi+QQTDgUEw3+47W4gOVvu6NTrB1+3uv8VhtKj3vig42YDgqgCjgAU4EV5WfS+VWY+iLBpSc+xbLhYT6b4dEtvT11tEiXokFlKlM/CbGXUehBhHRZ7rDeypne+nPW0YkRdhHd1mW4dsAeAHSNBoH5QBkPD1tL1ZYlp8ats7PeMDJjlFzczJKO+q4nwrCupFO+qlPLYW+Iba/apJE5Dd55wsZYG4WXxt1YMazEmGzlZ0HfVPMbp/j744ygdSJTurqXlchy8fWHwgR7/Q4+Kakzh7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tGfctHi/nnd1bK0Dz6D7nIbiAf+kDS2XfH4Z8EcRcw=;
 b=r/WGlTGtMIIb10hVET2ur+bLhvs1IPuYhBAkm77130gfsvkp2PcOLaIzXoiQ5baoxpFCJvKeD0dObncW+qpUuMXIJRabebbSfLDiRis1ZvvYvWChGRD5xX8OGYOAUOohmvGJj+ouKPdjrfWA7OsG/3BZb3Yh0D0JpbGw3S+7y826ZOhvnTPMWjncFk+mep9hIPC7fqwkMuP3GBHO9J4CJj9gdwy2wLWW+Q6VMAMGgP+BRwzbRVyqczpDp8tixeVa605LldsT9CAI9+QG4EDRk24XjE0h9HrcUvR9II5xG2kw7b4SMtYUfrxLcrgb5T2L5suajkqDeb85MkQbQ7O+Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tGfctHi/nnd1bK0Dz6D7nIbiAf+kDS2XfH4Z8EcRcw=;
 b=CJmI16al0yhbkn7S8lz8lW/V1kEqEjmSUg+mZ2KNIPGOx8t+xGvzCJ4eD5wEmNpMkBqe6RDUnm7bq/trJbEyY2FIJMsMWe4JTnzT09DbQltBk7EMzjihSGpq7dWAznedaZfamY+o64wUpHFdoQeJ/ikI9KspCDaQt6eVJDP8y+nDFBI2+yLLtbRsty8xUCz9NSAiMvOaqqfAl4UcAz71AxkJAJhDg+hNuOf7ECzjdzkeLprHsUgM+E1yuJm1cNpw1cW1vPm8UHj9qfmax9Mdm2TqgUFXSTcjIAA2jeUBm0O2r0cbJJVhGZ+B6wWIzLrBDcBmw6Vb5npkxJRjjwRoaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9908.eurprd08.prod.outlook.com (2603:10a6:20b:562::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 11:42:07 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:42:07 +0000
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
Subject: [PATCH 11/19] mtd: spinand: set bitflip_threshold to 75% of ECC
 strength
Date: Tue, 22 Jul 2025 14:41:27 +0300
Message-ID: <20250722114135.768998-12-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 592a620c-9355-4870-c75f-08ddc914c8bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yvGVnw8RGjaiippL8ym1XxO8zDP/aPPDKF8iV6Jg+yHdDhkx6ryO78MVbZwD?=
 =?us-ascii?Q?Q6SvJj08g8w7OHeHzfQBM4G5GcdNXX4az1w/B7muMd08uQ7bR2JWwAFTkufK?=
 =?us-ascii?Q?JfAeRziS9UtGrxwCeWbLD6patfnlYLqTZP1/kQnsnH8MRHnV60kyr3QEVrv5?=
 =?us-ascii?Q?3AQlYKhcQ28tfeD7g05u8QVn4SLaEddEX81rbLb+ovWEmWtJRNr5tkcL51w5?=
 =?us-ascii?Q?e2vEnmRZO+AKHdYyqmyIyO0ljNnXyb7m+zKBbB0oGiPT1ctn7s9h1e9vjYi2?=
 =?us-ascii?Q?Cu9LRPMtPcdt5ubinI961VK4xYsxNEsMlrDkPvQnbE3VfdyFq6SrBdu7cuCF?=
 =?us-ascii?Q?7SXGvoijJP6uZMpnWd9IX7uOep/Jobk7vQkH006ZwHHCcW+POpGaa86/OmSY?=
 =?us-ascii?Q?Qdl05lw4tC11MVmtZ8VtuhdryNCxRFKAgmpPq+LW5cu0OfQyoTMA8AZGVHBq?=
 =?us-ascii?Q?QFir1NjpZK1LccgaI04cVjtNoPnBFy13pkX/YBVtZ4Ha2UNVVyXfvfELlcZZ?=
 =?us-ascii?Q?7KNQJ8RtZ4SPO3czBt4GDLObuXawvyOgy6cCJwsSc9lZZhJIwjSkLuNXjvVs?=
 =?us-ascii?Q?+anUYVPh7YINte/kVzGAKPiVE5f7DE827duD4pmP2ATeZ+TK5J0s9SPEY90g?=
 =?us-ascii?Q?p9qDZZyHH/H3LxIirsR/MT04bKCQMRqEZnhW/oEXqsJ372j92L5qR44nZCa1?=
 =?us-ascii?Q?fLy4nRrn0q4E/geeK5PFDbiSDdcXbrKB1UjnS5/UvMG7iDlQHEnF7H8GspUB?=
 =?us-ascii?Q?s/jrXs2sxwSaviUrJ/XzPwpcZicTof2lbA04t3eX4BqoCxCnjMltsCXu5Aat?=
 =?us-ascii?Q?H1NLvRfOO9ftXpVZrYsIVfyF5sT3geQ7BN36AsRBPR4wu39MMYgnD1gusJ84?=
 =?us-ascii?Q?9DO8vEwjc1swSg5sUG9u5ibAuQEFvrpw82RxAiHeE8WsTRxaWYgra/lehiK4?=
 =?us-ascii?Q?nZWj8luKI1gjjVl6nOKAGrgHjk0EpaDlkKkBfDSD22/junTazgdMGm43GkKz?=
 =?us-ascii?Q?GDl4sUAUWJpc6++ENVUPm9MvCUAWCeqP8auNwaUZ0JQs/K3fgYXK8Nz5oMWv?=
 =?us-ascii?Q?OWuj7HJEg2plCTXQLmKSN5Me0a7ZnpfMEG2XkA3kK4pE+qBevzZSVCr1oXUT?=
 =?us-ascii?Q?/0iP9hexZ1OdJpMVC2wXIVKVX9Nx5LlXa2CEXJs6jBn2m8bs56gu7Bz4o/Xb?=
 =?us-ascii?Q?ldPMk31IvvS/4SaNyuHEkwFAcLgtXvFttdRCIcu8bR2Id/1DLqpJ0CVY95Mk?=
 =?us-ascii?Q?jK4G8zYupGrS03R4XPtXqVuX+6+IgZ48OgFKnPbfjNsWx0pZO2NSkQNxn5wX?=
 =?us-ascii?Q?2VkUNq7PM90Tdje0nEaVkn8tUdCVBdyUC6yZZ41orQAb3pCw1LNKiKlGCV4d?=
 =?us-ascii?Q?F/4QLbqkeII9tmJJQgddjL0Sqhs0TUMmxweVtrt2XYIqhsM4sbj5HjAaEL+F?=
 =?us-ascii?Q?aKZqRBnrHzMjYorSul0evP3uRKlcleArlr9yHRdUGIQsDPNugTIE2r5lTuEI?=
 =?us-ascii?Q?0wn8b5/EVbb0pyA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U4YqF5uUY7JaHVg6eVYretBpUKPwA6b7IQ05IDuj1DTgzL7aBbA5FGuu9jbH?=
 =?us-ascii?Q?ZubpYuDULJ+zod530QLhcMnn2mcjot96lm0ohAKGM6RDs7a7t0tVevFT0Xt/?=
 =?us-ascii?Q?UxGuq26PuAW9OOw+ZJRXqgP6B2l9uvLi2w0UgxjNdmoi4/XIF86pNgXxF9qJ?=
 =?us-ascii?Q?z8PygBDZo/eRJMLwCsngdtPGmnSQ8pABe+JqsS9C6Z/B/TBA6Oy8kMdiwZDl?=
 =?us-ascii?Q?AGfCKNfL3zzJGt6T2ha01aAcPV5xP/Kw6YQULfT9gzfNYKgXt/LLFhDljw48?=
 =?us-ascii?Q?hpUbLisHvQ8TrXbpqlL8q7QOLcc7560UhaA/J4uVbAD6BZ6c2/MV8Q204LLI?=
 =?us-ascii?Q?gfR7X0bliBCP+xawrsQ5aBBUq9xN1fFmDGp9rnzfKvtROQkrHe7VpdwTnzG4?=
 =?us-ascii?Q?eXk5F2fEODgs18lxIVQUSE0fhIVEJGlJZwmmvvqf4YfZEA89ZZNr/ciu/i6m?=
 =?us-ascii?Q?s06ATCKQQ9c0yKSnyP1N5UxEj3tqS2tA6K3VAt6fbXSjxgZsXsTUWDydQOeb?=
 =?us-ascii?Q?okWBHntbtCchgQW81ezd+yoDteefHGIdjIyMoRP1zC7ZKQCdAMeiDnV41TZe?=
 =?us-ascii?Q?di+3a/TU97vfu5W6OlS3UYJ1c3a+k0DvVVZWk3JpzNZgYkyMPKZdS2dERGeH?=
 =?us-ascii?Q?RHSD6g5LLUogubcU+R50+Fkie5eEd0bUIBtAwjirBWp7fYpWlMt9geyNgZkB?=
 =?us-ascii?Q?nkAnVYvcEnRh06bVhfsi7+ajgW9HqX9hwRtRYsjSZF0vAJACnOKAoYC8UOjs?=
 =?us-ascii?Q?h6kML762cvXlsbx/3p7SExM8JqS4yCwu8ecbQw532XWaEqCmxWtm5UDuCpFv?=
 =?us-ascii?Q?jX8/F8XqG2fRIZiNVpQUfxUcyccxap+aJPov7UJOMB1CEX03mt3+Gi+SE+T/?=
 =?us-ascii?Q?KmUGFpwa6+UlqxfKOlGh694cjuC107tbUy0Gc/yulfROW6izDbCcrHX1zGP3?=
 =?us-ascii?Q?uXoSo08/Ub0tBkhWIHX3y+9eVl3OR/u5b9Yv2N1gfoqFtNa9Qm9dn3bH8HLh?=
 =?us-ascii?Q?mGVqTzFvZ2M0/Ykl1sWZ+6xUwC6uMxDSfl40L8Kuc2MwQPGYIwHXpzDd1Mnp?=
 =?us-ascii?Q?fnoGzVYNwKDg9kABYqI20Sg7CcLi96HyGMG12Y9SrCLzmYFM8Omq4DhrJWQQ?=
 =?us-ascii?Q?QJGU7AwZPWkJOKqynKf8SX9/OD00izQFW5OJ+YIepx7SAWt1lZuebJcWbsIC?=
 =?us-ascii?Q?W8yDSKU1JvVlRQfH1kkZ1v/TgIr8L3Ek42rdT8wy3saaQ6llReW3VZr9gCMY?=
 =?us-ascii?Q?fhlKAda/Rn6HxFgl1+3YGw+P3gE4A5e4+O/dciLCM91K7glQf/HKrW/eoR5W?=
 =?us-ascii?Q?2/VjABVS6Yi0kXCPbRUqWCE1K71/ibZ1xui7lkvXmhortogm2jsMaZgMRqee?=
 =?us-ascii?Q?nPFdMGfhf7ShEuBjS+Eygh+7mCVvKdKoY9zmdEMbf/m6u0yFXxqv55vJG25p?=
 =?us-ascii?Q?kQyzjt60ZJ/fLEr6QqMskK5Ia6mvDvfeq+w6KZMuqU9NUwlrAcUwXCr5jfT5?=
 =?us-ascii?Q?SxpjWq/N9P7bl1ivVQeHkz6E0HcMH0nV7rJE5doF4bRPYY3MWyKtEmjS1sv7?=
 =?us-ascii?Q?WdemAlWBBxRjH9mfSCLYCq9BVOC93tnAzS9EVmsPHrSFmRnm0knBKqP70sWu?=
 =?us-ascii?Q?n2ttNgnVyB7dQ4WzbqDnRmo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 592a620c-9355-4870-c75f-08ddc914c8bd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:42:06.3338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OUgo3Dhs2jTiaEP0wNEvn/GBkA3zfaqYq+i/hxuhLQzNUyUQLc+IpsRELodg0yfhWKDjzn2NpOU00Pym00ERzxqDJl+66D/kO840zQgplM=
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

Reporting an unclean read from SPI-NAND only when the maximum number
of correctable bitflip errors has been hit seems a bit late.
UBI LEB scrubbing, which depends on the lower MTD device reporting
correctable bitflips, then only kicks in when it's almost too late.

Set bitflip_threshold to 75% of the ECC strength, which is also the
default for raw NAND.

This is a port of linux commit 1824520e7477bedf76bd08c32261c755e6405cd9
(mtd: spinand: set bitflip_threshold to 75% of ECC strength)

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b4795927277..7ace61fd19f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1279,6 +1279,7 @@ static int spinand_init(struct spinand_device *spinand)
 	/* Propagate ECC information to mtd_info */
 	mtd->ecc_strength = nanddev_get_ecc_conf(nand)->strength;
 	mtd->ecc_step_size = nanddev_get_ecc_conf(nand)->step_size;
+	mtd->bitflip_threshold = DIV_ROUND_UP(mtd->ecc_strength * 3, 4);
 
 	ret = spinand_create_dirmaps(spinand);
 	if (ret) {
-- 
2.47.2

