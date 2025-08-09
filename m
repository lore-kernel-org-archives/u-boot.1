Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE2EC87FDA
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:08:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8DEA84812;
	Sat,  9 Aug 2025 03:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="zcRQucJq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B9A2847B4; Sat,  9 Aug 2025 03:07:11 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 206138479F
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lN1QWmiiGM4iM64NHEdS2pv+8eRCcsSDXiSIOnBhQvwn5e0HC0VvZ90d6zv5lCI02/1fBKtb7MeSs2l9WGSEYXkLBCZVkrCxPdycaNI1JcQZVzsr+ol1yuWUJJUiipZsn3K3LATHgg4I4q2k6MTdi8VmecFGn1ceyn+gWJhKstKrOI09IpnJRj1kgpN/ZUkwx62nEVcTukywcf0Gfu5Pd8ez5TQhArxFOX7Ln/hsyABhaYcRnpHQ10AtTyA9vxeMhVfBhmbS3DwELAj0WG7m3Etsbjkt8XkkxT62gEfFH9y9yOcdkaNfJKpe/X9adyrpir48FTPQ4OvmhpOHqTqv6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaaFSTDYWglp4MaW8paqMSiKVFvo9ZOjHatHZhhPcxo=;
 b=A7eRg62CHuCAkHuZB8HpZDixNHNsyk+FXbmhXxHd04kiARexZhu5H5vbr8FLvkDG4RpVLNJHtyqrGN6aSei4/cPRrrVsWQBB0AIyA2glJLFMbmcWJ/CdKnIUgbOB/AdTaQQZeRwJ8iBZDFwA9FrLvxhP2zmAUB1TmeTkbgGEKlxyDNw6izeX+eA5nr/DX62fcZEipGLmKJfI5An7OMFq98z9nWgivyhTEwGAlcemeETvrW+YzOkw3pOPDxYytn9UHdjLPhXPeQ0FvQfn24IsD8+imVV7rgjc2DuUNSSUVteJO9HCS/F+X3jkGxjG4AImCdG7xK4QsJ6OVnd6ViieDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaaFSTDYWglp4MaW8paqMSiKVFvo9ZOjHatHZhhPcxo=;
 b=zcRQucJqAIdOr9HdDJzjcZGRHB8aR4JawfniL1BMflvVWBkDS9vJ7zKHXkRmguHZfRebzJKDGwkIhhW7foszFf73lcDhLJmAF4uIoG2bdXUxeEZUQWyLArhlvcqJOMng2bRNBw0yN/QCbqULzZ8EVewgxXQ7DbfAkcH9kKjnoUn3wHVNNm8Jse+rANqSvUy2GI1QghgjUYMGTGhXK3uIDzUQYmjtr7fVcwWkaRPraBBg7xrJT2TCNU/sPzmaPtT1dPksLLggQtJxEisjmAjfIbcLKIrbn68lUTX0kPqeg+HLbjFjz4VGaCHyyeX6mQUXvIZfzKZtd0fS7vstPPvv0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9582.eurprd08.prod.outlook.com (2603:10a6:10:44a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sat, 9 Aug
 2025 01:05:30 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:30 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 20/24] mtd: spinand: Add a ->configure_chip() hook
Date: Sat,  9 Aug 2025 04:04:52 +0300
Message-ID: <20250809010457.3125925-21-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::29) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: cb813c05-1d43-4223-e408-08ddd6e0d5b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y7tTqm00scEFRt4Ylga7t3foyKUPUj6vu+PqwQnj/6L4PW4a8XiURMKrwfeY?=
 =?us-ascii?Q?Y0fkSc8904QicC3QrVer1eJO6k43eN8E9ZSEje2F8OfanC0una/E0+pLuoub?=
 =?us-ascii?Q?/t4ZGLsMCR+cH4lpl/f90g6wjfsWYg1wYJ4u5+AkRkig8clOAkmoezZk+pOW?=
 =?us-ascii?Q?3FDbOLbVGYySXlQ70k5+q/wLXgiXAbimhpHKxZHxCdgV11CJOCVdQWL8iK3k?=
 =?us-ascii?Q?RyxFGuCaiFYgorC7QdHvCWemjSR0SbbGYYSbHeHcaNEhZXDUw2zFXtWprL23?=
 =?us-ascii?Q?V7rc40GMcvpr314aDfWwKrBposStV9w9yAcnJjNaaln+Q4S5KhRMzSxuvv/M?=
 =?us-ascii?Q?VPJ74yhmkCBwWx+gfsNkc9n0AnliIIbYyMXoGfNq37zrhApFWHFyjIXr+8WE?=
 =?us-ascii?Q?e7EWZHBbHlzDpqwQCuDTGlb2oyE2idc1sLMAp/kvfyFaq27Adu5n+BKDhq0O?=
 =?us-ascii?Q?mjTk6/XfwJ/4DvrPrJGd5+L4Vm3pcO5K+8uVF5D+Czs02v8z0eZWd/JwmoWB?=
 =?us-ascii?Q?1xFqxQeeEOjJtWCWAvAOfs2IYujsKj4wV8+QCOdUhktajPRPPnq5CvEB0pXl?=
 =?us-ascii?Q?2K5JTeUsHRGFN/P8ud05RrlXe50yyQAblMJwZJSevgWbn0hVXh2KlpbAJweK?=
 =?us-ascii?Q?RdVE8XVKenVoEbmj2OmAtO9adMBCLj6r8nvZToC8rzXClgZt9wKzSbAJ4dY7?=
 =?us-ascii?Q?tf2m/aaRepunCCUHwppN8QzqSPSAOIqaWlJfS0dY1H7pdxmoUdQO4frL62sD?=
 =?us-ascii?Q?X4NMdNJZtShw0sPqzpF9MtNdLEIjlcL0s9LnA72m/k6/ifQTw37rOXM4OoxC?=
 =?us-ascii?Q?SjwJMWqPHvBp4VJzw/4gpukvEYXrNHiKXYM/UGBw77BzVmdbmQS7KVah3qdI?=
 =?us-ascii?Q?QJouDjw5P7tQR76KTVKA7ymFDnnV7jm6W/WozJJLoVoVHdn/5YGRrMWGdWzD?=
 =?us-ascii?Q?jOtJhsdGQ+aKKqlkIBnRtje7mCVaOQp0SqjjaiQOXAjY7tICfbqFf0ASth1B?=
 =?us-ascii?Q?lOhbDcYdFTSExjkH5+9PpRBAN2f9jeM599k1TnF+KUgOox3rYiXIVk7L+gJy?=
 =?us-ascii?Q?fqAphJ5JJZBGB/jJogRcQLUZDiAG31uOKNF1Uw4c/dJszVcdLH9HkzbC8PuU?=
 =?us-ascii?Q?z+eTDU/4BbIGRxPMjBLuOXqVsNBX03jgoVgxOjVwY+KTURheO03sLnUw6Yv+?=
 =?us-ascii?Q?+PTLsTVUUMGmcIJt0xEPtPJYwtesfnii87v04e4hCV4NZP1k+Io3l9N+4z4N?=
 =?us-ascii?Q?orOgNQdD/rdB3EFzjvhvhCTv5jEVuiUUjeZlEGRnLjvmh3oKrQvxN4FKezhd?=
 =?us-ascii?Q?NmAz2q13dhOLEYDbiCTLklnBgB1TGF8cwTW3zPYhVeb1xKIHxPwmvaXHzONg?=
 =?us-ascii?Q?EY6U6YbJIVajIpbOxekHmT+goTDYhs71b2vtri6aXQzxFU/PSCdVaEKIxgon?=
 =?us-ascii?Q?e/Am5ImrUWNDJikOx7yZGASigySLndc7TAX+Jel+jzAn+Fvf0715Lktp8xDk?=
 =?us-ascii?Q?M+I9e00jYaVzasM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R0aAxVNyqYuJicrfW36FW8UK0NK3LAH98bShgiGV9/PLQy/zOx8mFzFYp95t?=
 =?us-ascii?Q?b2xZYFUptx/aRC/mHNjPj38PdQfUxZOcJziRLKDu70AuGuyD5XF6k/FkqG87?=
 =?us-ascii?Q?aQXVFTmNCu/iGA4Y5LOnYM840C+8SRjKHFg2PL90HZj0jC4l1+8PYUaBWvol?=
 =?us-ascii?Q?MU+ONCw1NA8TnsX5lT3RhtndMSfgS0+kF+mj1EVTEPwICH6KKxgvJyUsWQ8F?=
 =?us-ascii?Q?4QDjA8Zv7izfH0sGWUFCeBMgUFZedyxqqWzNcyX4nPLDOb0KUGbQUv5bv6tX?=
 =?us-ascii?Q?Ecop+RBvwOyTAtWeC8EMJl4cGrYC1Jc7p1OUvooWDLLHuvg00oLtUD0/tOC8?=
 =?us-ascii?Q?0sCvU0h/8qGSIjZpRUnRIB3gEQ/q5fD0ln0vQxq+UZw6K5ORSCi4qPEoquB8?=
 =?us-ascii?Q?MFm+0j2zGD64vQdbJvpAFj43p2a+YAH9+NuN9HQpXRXn0rL6ZwJZMjLp+Cyr?=
 =?us-ascii?Q?udRxZHlv7PgLbzlWb7VpN3GW8hMDHdHYb2AHGl17rDTsJ+Kl8aFiOJFLKeVr?=
 =?us-ascii?Q?Y2aSCMKZFQYFyKgwG1IT7Y+dL/wRkWpjq/ET6D8nxVImmqr6nFEd8yakCtEk?=
 =?us-ascii?Q?JG3OSVpuhiX1+aNguBqLXecI3qJwO64wGdPiLPIH+qnlDhgvp4xNAbl1O6DZ?=
 =?us-ascii?Q?6fBYaRvD8eVQEhFbn692nEFyjYiGI29CEbMd9gu5xBquD0klACq0Ok4z1y8C?=
 =?us-ascii?Q?+nI927nQjRpw+5TjyT7ToXUP5+ZIqW9bYPOqvtQ/XDJmBDJYBewPcjD/1rX3?=
 =?us-ascii?Q?iN5AYLMxANz2SM3YUGoHy54fd976BhjlZ/QH3aKM6Y8l0PwSV2GS1Jl2XQ9X?=
 =?us-ascii?Q?Uw/mR4B82RfyIVkSgosfKW7QvsFixdMpGU98hqqT7a67MKR8xWoy/gblTOHV?=
 =?us-ascii?Q?ftxEHtNfJxiDHRHbcf/8SEKCihtIRzIvDLgW0c1dNM1B6MumwmqS7U5woyHL?=
 =?us-ascii?Q?Zf+XBdAE686E20Pk/0AbjHq27NIOKP4qtzAwWzqzwEeuJMHN/dkcWzp4B99R?=
 =?us-ascii?Q?x3PehZClwTf5MrSh/fUjnjFLpnT+nfw2yr8EZWwUoLTj6dr8w8GeVvz4UPQ0?=
 =?us-ascii?Q?+bnwai4LL/WQ97UjWRMjzsqhbAZ0b2V+bKMMZ2aiAC+T9P+e00IQNqCJtYEs?=
 =?us-ascii?Q?KQwEKroASguxqaeGAazpKfA93M6jS7FVO8DAtXpti5As9+Kg6M6WsU5woxyN?=
 =?us-ascii?Q?uVqGicT8JDbrYHJds6pHKRciku4x2P/WnwiDVCLeRm2VTg/P/Zyij/irLVsa?=
 =?us-ascii?Q?w94SuQJq3ht8Z3BclOO7JZXVDwETNd7TTt5J0YvtJTCISOkcVvl1HoJG0zT7?=
 =?us-ascii?Q?iDw+rHCWcsbj9j4wYwK1tU5zcUUb6d98Leo9ZWwSmGrSDP2ZlmG7hTX+tKgu?=
 =?us-ascii?Q?raWWt/yOC8vLRIYsDnnBaRtgYGi98pwd3pGr+9sZYrvcUatyCwnVsqZgWSWy?=
 =?us-ascii?Q?Ghucwq7/CsCKChvF3pnkvyxTlPEMJCm6MItlXjtFvmT5Wtm+ZX0jprXc+690?=
 =?us-ascii?Q?xDBaADOQyR3l0B+Q/a2m7SAVd4LWovfCjFGaM2xwnymXMwImtqSg2O85jWBl?=
 =?us-ascii?Q?Zw6zpn0CHdmj6ObiwfaxFN2i9HT9iCtvUOmiMVg3U6SGqjW3q96AVeBUnNgO?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: cb813c05-1d43-4223-e408-08ddd6e0d5b7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:30.4454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KZQ9WeF3pCUwUxjqT/S5b9+NOY8YibwpUccFag1pt5Vgwd9RRC0/UWvbvdS7Is0AnzCLSgc8vnaSfQrcyZxJi4TszHE5QphAMNsWiWibYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9582
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

There is already a manufacturer hook, which is manufacturer specific but
not chip specific. We no longer have access to the actual NAND identity
at this stage so let's add a per-chip configuration hook to align the
chip configuration (if any) with the core's setting.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 16 ++++++++++++++--
 include/linux/mtd/spinand.h |  7 +++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 3e21a06dd0f..25e7a38a874 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1251,8 +1251,19 @@ static int spinand_id_detect(struct spinand_device *spinand)
 
 static int spinand_manufacturer_init(struct spinand_device *spinand)
 {
-	if (spinand->manufacturer->ops->init)
-		return spinand->manufacturer->ops->init(spinand);
+	int ret;
+
+	if (spinand->manufacturer->ops->init) {
+		ret = spinand->manufacturer->ops->init(spinand);
+		if (ret)
+			return ret;
+	}
+
+	if (spinand->configure_chip) {
+		ret = spinand->configure_chip(spinand);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -1363,6 +1374,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->flags = table[i].flags;
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
+		spinand->configure_chip = table[i].configure_chip;
 		spinand->set_cont_read = table[i].set_cont_read;
 		spinand->fact_otp = &table[i].fact_otp;
 		spinand->user_otp = &table[i].user_otp;
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index adfb5f3ffbc..94f324741e0 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -398,6 +398,7 @@ struct spinand_user_otp {
  * @op_variants.update_cache: variants of the update-cache operation
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
+ * @configure_chip: Align the chip configuration with the core settings
  * @set_cont_read: enable/disable continuous cached reads
  * @fact_otp: SPI NAND factory OTP info.
  * @user_otp: SPI NAND user OTP info.
@@ -421,6 +422,7 @@ struct spinand_info {
 	} op_variants;
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
+	int (*configure_chip)(struct spinand_device *spinand);
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
 	struct spinand_fact_otp fact_otp;
@@ -453,6 +455,9 @@ struct spinand_info {
 #define SPINAND_SELECT_TARGET(__func)					\
 	.select_target = __func,
 
+#define SPINAND_CONFIGURE_CHIP(__configure_chip)			\
+	.configure_chip = __configure_chip
+
 #define SPINAND_CONT_READ(__set_cont_read)				\
 	.set_cont_read = __set_cont_read,
 
@@ -521,6 +526,7 @@ struct spinand_dirmap {
  *		passed in spi_mem_op be DMA-able, so we can't based the bufs on
  *		the stack
  * @manufacturer: SPI NAND manufacturer information
+ * @configure_chip: Align the chip configuration with the core settings
  * @cont_read_possible: Field filled by the core once the whole system
  *		configuration is known to tell whether continuous reads are
  *		suitable to use or not in general with this chip/configuration.
@@ -569,6 +575,7 @@ struct spinand_device {
 
 	u8 last_wait_status;
 
+	int (*configure_chip)(struct spinand_device *spinand);
 	bool cont_read_possible;
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
-- 
2.47.2

