Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15A7CA0EC6
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:09:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46BDC82D6C;
	Mon, 18 Aug 2025 12:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="le+8xdeW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 918BD82F03; Mon, 18 Aug 2025 12:06:57 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E194801DD
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNpELEqEdBupTJhoSLDkAcqqRJvfvtwLsnNQf7znDmhm3Z9djMq0NWsxg4MPl4sbLG4Omj9kUvC53AgsFC2aO95DN4Hj39RcNfiMCRKpVDTJieAUta4Ry/en95rbq0HlKUS3OUtoUIm1nkoskghwPrT9uooh6E874fIApHYDqRqryZu0V4fd7G7+KH+cu63sc9LCoVgW5IRwqN5CWySAsatRRCBt55qzfy7E5HIofLu9STFnpqSk6fk2jK1Uxyi/HUjsK5rWn0S57Zs8hQin0kdkLSt/gAYzb5EhfwbOK5CScWdJnNky0O5keOaQpKZb4/wj1OMkewiJRHE5zm6z3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVBlKe0Py2y8krwxJxm5xdyKQrCSScxqRmE9BM6fNI8=;
 b=S8g7wnbkAyolMwq+qXjBhRrn3fnQTR3CKQKMWNrtjnmGsgybIuSZBdQUgyJ18uy03QNefcsjsfGszQPA8EemjwfkrdALGhE6UB/i4xgzIu7JaoyJ7hrjUQ6W4SNc7E5pXcdwnsfCfCYEQNgyhQEE7Te8arklPLYuljj3cFxnUPauPcLkn2cOfAWOSid+N7CrJISHuy9Ex+Wk8k9FcgYzFq/idrKHeAHE7R3Ds+6ksuKAF9vVlnjGEDrhsfRdrVJcNZYHdfCMAgC52lAm+6C2lvVJ9w5cS4bHJacmMpjw5uDvevfUmAz4S5n7uNFohTn0JdB4wcGeLpW2+oihUo9luQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVBlKe0Py2y8krwxJxm5xdyKQrCSScxqRmE9BM6fNI8=;
 b=le+8xdeWZy8yohElcAhPEK+CTNEMRanX/EdkpKKUG+Zx2uCuXjNYP1xT5fI9kiaC4UpI8h8wdxWxzf9p2FS9RwfJIx8z3iML/6QSvNrtHX1BYZJw2/aRj9ZkcwSQi6dSYBVuH1w810TCF6O/pikGhFwpv1BpP49BeLiagWDTVd56aICbHHBfIBMd+n+bbnPLiIbeV80LkGDToeJR1/X5W9r3HOWxdAuj2Fc7zXYz30XhtWgPHuI7fas9++Rz9PFxVDbBHlUi1mVFU8LaLRDnmFBllEFvwZ9KO/6w55nn8PWfHR/9sYxJWVm2t+e4M/CySJG92i55gL73WQL4Ysulaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB9892.eurprd08.prod.outlook.com (2603:10a6:102:342::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:06:53 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:06:53 +0000
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
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Gabor Juhos <j4g8y7@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v6 19/21] mtd: spinand: propagate spinand_wait() errors from
 spinand_write_page()
Date: Mon, 18 Aug 2025 13:06:11 +0300
Message-ID: <20250818100614.432931-20-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB9892:EE_
X-MS-Office365-Filtering-Correlation-Id: c6617245-c872-4a0e-9d48-08ddde3ef484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hvT0zC+yC2t4sUumK3Xurp/RHA4FmKkgtB9VS6WYlKcs+83nroQV2lSeWNMO?=
 =?us-ascii?Q?7NLO91XCwypJ2Qd6794xUxpXbzDjzx1tzhZew4qHUL0OzP4iW4+lK+G9hf6A?=
 =?us-ascii?Q?LMGcPfvgCdiRPYfqVtjOLT8chlxqbnPhkR+RGn5ekxWtc5jxOVfX7HuzFLeg?=
 =?us-ascii?Q?BBzonh3r0HxM+PKO7lsiA4CUCOZGaVZ88JjJakwYv1gqxaCZasBgjWErPET6?=
 =?us-ascii?Q?/pGYknZl2BWRCUhU9O/F0AULICW755RPv6IyxoI59Jb5Z57+cWcCSEBqkzms?=
 =?us-ascii?Q?ACAn8TzzJAhohu//b0hSJ+hX+77asFcukjI3/b7CJC96lSZ0LDZvU3PqfQgc?=
 =?us-ascii?Q?Z5gqLylemJ318rHFru7AQvbL/i2MnAnEEeEbCzGD8Ku1tIBcJJMdKGw+kh8z?=
 =?us-ascii?Q?D1H9rP5k3ZCsDgr4i+UzlhUYNnEFsapTz/rBgAV1fkss1JHzkzG42gul3Mkp?=
 =?us-ascii?Q?lNMHefP7i7134BlDUQvYDY1TrKy7mKduTsq+1buMmQM4pvb2d1mhRBc07Zco?=
 =?us-ascii?Q?SMsogEubxNzU1DD1WXiy2SpmR7TO1f2QO7p3BJHXfiGfhLPOFdqwyIFXuws0?=
 =?us-ascii?Q?BMZhMdNOz+jLJCYNhrxlEVuqjA0J8iigy3b39VuKA+3LN7JDRsDigJpHSo8g?=
 =?us-ascii?Q?uoLlN2vI4KPw9/8o8pUn/XxtVkd0cQJbL958avBJP/xsNwCnwEptwUA2d0Dd?=
 =?us-ascii?Q?nZiIvWE1F6zWqE0ctrS+j7I3QtwCaNKkPfcay6FAHPDT1g3hh9GYculbY8Uu?=
 =?us-ascii?Q?jbTjJ9lgitcVbvUFGsoHXyh194f9KbltEHiNSzT97gDpWzzI4CgabqLnnliv?=
 =?us-ascii?Q?tw/RIwfsbHa5ntGAu4SPsvs0aziEGXKp6XJEFO1V4VUBpV7D7qxjdRaS5rfI?=
 =?us-ascii?Q?v+7uSDQKJU7dnaRDXuCkXXdYzmWRJMqBzhigb8mhQaj6mAbQz0jFWA1oV6C4?=
 =?us-ascii?Q?TRby7zXjcbeg07UieeFFUWLTm9AShYMJcvmO82AlwV7qFGrHMMN0rjnUE/b6?=
 =?us-ascii?Q?RKtuz+xdhxnXT2I8eLGgWaGxAA1S8yn+IL5Ifi/yI4zsbu+gfXdiAh0YvHua?=
 =?us-ascii?Q?DFTxmEHGOdpprwOtgwdIwsU5fnZS1i6zBI9JSAt8yC7xDBYzQzPh25bMmzrp?=
 =?us-ascii?Q?EroE6+lJ4tInyizOZBIHH9YGwnmzHGmSrOWL5JzBll5Gb47ZYLq8S2UPBkvF?=
 =?us-ascii?Q?v3F0BEm7t2FWjfoh9NPPPSkpAskRRgTuN9LHCr7OhcHgrNNSuf+qrzrw04y+?=
 =?us-ascii?Q?IXOauraT2dq+QKBNv490WyiiH8nYmlnrEDn8uGNpWIFEq2sw5nm9exv91xNG?=
 =?us-ascii?Q?NtinfmVW9/XRxSoieYPJU9/hNGTUg5OMrdugg+8bu7oCbCTN4HKxqQhyN7FH?=
 =?us-ascii?Q?BEDuvVeTj1rPgviMiSIQPI+b24HQVY5lsbOicvUwtskus3iTZxYTReymXswf?=
 =?us-ascii?Q?DpnpcRabchuvjdrkWon5OMqeqCN0CzmuhWCGnJ5rG1y7RR5Y0EJJKKVpqVlQ?=
 =?us-ascii?Q?t802YMiuuGHmpko=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DYyLhNxwWCYQKzMQh7wQPImMSErysNIUBpJ5QxRqy9aUeBTZjz2mQlkazZdq?=
 =?us-ascii?Q?56xBGOu3Pl6Q/BY25D8VeTvNxhfh1uW77p1qIKB9K2wY5SBppLou7sVUBgPl?=
 =?us-ascii?Q?GAeuGU4sJj5GMo4PYkBV3Ce4evI6nVNMIJ7qZGRdGKnyF9DV3qKPvxH3RnXs?=
 =?us-ascii?Q?piwWgXDDlsUuTfbCfJ6CDWJpj/fQZeXuUR8ei44pusYLFoBIQa0fFu1iu8J5?=
 =?us-ascii?Q?1bBp0HVFhMxUUTXfP7ajUn8Y3htEeMtSGp4woeQxilXUKgcJMv33dOLsZsZz?=
 =?us-ascii?Q?8Xkj2kgLCWi6JGSr+SgFSrqYf6ehbbjbwcWcp3GsBRCvRNmX7qxg/373XWq2?=
 =?us-ascii?Q?qxL7kvorp8zTNwHReaAY3iW7bibG+SKFQRtDvD80tcFsqJugqLWDgdUlfwLV?=
 =?us-ascii?Q?fkJ8oDHub/gjafvr11PZ2eu1zMtnEocM/5WT4MW11HhHa2FizW9yRmK0ccrJ?=
 =?us-ascii?Q?gnClj/RXfgmeCaJLoAx1QwelhYcZjvtQ9IaYEIHmMT0kfuUhUY231/7an+9k?=
 =?us-ascii?Q?ObtEv/bdIFf5L5LIvWUmGbrnTA+dRTTQGxkbGkmb4uQ9p+7WAeWZHeeD1NEt?=
 =?us-ascii?Q?QJuawZE2tQLZGvItxnSnRYDw+HSPEAKzHMImu7H3BmP9rPNdpEUx5sIi9FaY?=
 =?us-ascii?Q?cDXh6aGLdwqWtoXadTb+tBiO20/1eve5//8HumjTO/o0IUmdhrGYLTBXUW4h?=
 =?us-ascii?Q?MGhf1sbzn//eBeO/J8IjCq1l9LuOFKQjvl565K+SicZDyFjmA9k1TH/pt6vE?=
 =?us-ascii?Q?FvE8G+BMfUH7ZLGxiEi6hKon3ZRdEkjL4ucris2loEm7dbwujLb8bw/72zz0?=
 =?us-ascii?Q?ePV6Yl63Qmt3QjXvUwQ2idzxr5YtFxj9qqWL+nAuoqPo4y6w/kuVU3BAaSD2?=
 =?us-ascii?Q?V3Af5guzcAn1Lwzf1Os0efJhdYEgReyps/PtMxO9d1dhkDV/T7t030EoRrdb?=
 =?us-ascii?Q?pdDuN5xSMSD7HnVJSyXV2spKXi8iyEfhEI5G1DdG48l/qAu169EGPvABsdqV?=
 =?us-ascii?Q?2a0yBBN37egONm38U4PjkcPnUCX45EpZNF/BLzefo4l7c+yeUT3tSF5ss2zC?=
 =?us-ascii?Q?B9Dyn7DucKcZVZHnaU+4RROIuslGU6oIM30McHyvFn7CRU9MKLRFEa6G1rng?=
 =?us-ascii?Q?0LddX4+JOEygWNedIlgrx1TkeD75+djxpJAKRoMBCp1zOIEgVmIOa4hxuWIV?=
 =?us-ascii?Q?VzxRB0iRPxMYcZnycAWImH2rBXvcW0xfI09ldw14CEA6s7hEq4+x0Krrwoii?=
 =?us-ascii?Q?PDGRdmwXlDXGLJ3JdyP/24DHZHA790J2SR9DtUlTI/k+cSBHvdCTIIY3hplt?=
 =?us-ascii?Q?SCVSVZMJHciWlMKUAqmucW8mp/8tDVw5Pa3J1TtjAklkw4vnh+9Q6o2kGd7B?=
 =?us-ascii?Q?LNnAAQSvRjruniqHu8V8Ee1ugfDNS3jQX61NyHCqu/0WSc3qZqQccf0I9kX9?=
 =?us-ascii?Q?NwjJHP725nvEWqsRN39Z3GUTHhj91Yx3DCnly+Ys0dW1FrvCPKZgfMRLPk8L?=
 =?us-ascii?Q?ZoF85XRkcalURrcCpwX1FaLr2z2fgA9PrprbwbNE2OsZLnpJLRTMYIZz2CrQ?=
 =?us-ascii?Q?oG3vDenxUwz0Jk3UG89h81YGRlDnGP2JDMf0QOnnyCvyVhFQDfxgJt3T7t1u?=
 =?us-ascii?Q?KBU+xuWnyUHsp8OHjuCd/8U=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c6617245-c872-4a0e-9d48-08ddde3ef484
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:06:52.9922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvun8ATMwSC490TVb/AgjhiUijTWAsTbz0VadkdyqsR7TJiPVM51Ak1atBDWovjVj3wL7VgZXcGMYpmN02KmXMN2TuJGVUfHDp2s8ms5cj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9892
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

From: Gabor Juhos <j4g8y7@gmail.com>

Since commit 3d1f08b032dc ("mtd: spinand: Use the external ECC engine
logic") the spinand_write_page() function ignores the errors returned
by spinand_wait(). Change the code to propagate those up to the stack
as it was done before the offending change.

This is a port of linux commit
091d9e35b85b ("mtd: spinand: propagate spinand_wait() errors from spinand_write_page()")

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
---
 drivers/mtd/nand/spi/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index daf6efb87d8..3e21a06dd0f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -691,7 +691,10 @@ int spinand_write_page(struct spinand_device *spinand,
 			   SPINAND_WRITE_INITIAL_DELAY_US,
 			   SPINAND_WRITE_POLL_DELAY_US,
 			   &status);
-	if (!ret && (status & STATUS_PROG_FAILED))
+	if (ret)
+		return ret;
+
+	if (status & STATUS_PROG_FAILED)
 		return -EIO;
 
 	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
-- 
2.50.1

