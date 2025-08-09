Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F355CC87FDA
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:09:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BC8983D85;
	Sat,  9 Aug 2025 03:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="dl+gQyVw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5033C83D7A; Sat,  9 Aug 2025 03:09:11 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D85EE847CE
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIth+9CJKhedNdZES8braMyivdGKKHdVaMpbUY+TcKKH+zCaHN+/43fWnSFHfrkQtM/RlONgG0DZkLTtq+BxY3DpUCQgvVQd1S9tCbXngBvehsyGcGep22OdzRUGovxY1gSchDJUfLuEi22HkZlj8C7G6k3Yn6CJ5zvXaHnPWC+Pdp33pDNaYuh3dSlDUVNpiepZv2g+brmKNgO5pzt+JFUbNHujAbQ9B8n3Va+Vql5e2/VR8RnXI+ppv+jO9Jm6cY33Bl0cS3JJugxHnZkmR5V/PPWb3EkWUyjG9AXNqA1vh8T6TUlCDwHtGoLUVE5HCM5UavCbRgyXA8pGx4TPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0YawNVXPLtQQD6gPDeLXyp/CUK0yzS5JMjQfLyoVtE=;
 b=gbfS6YLJykYJF1S0DEQcPqgesSaTvVXW2zSoy8MYqAjZgV+db7oW8ZzRSDY2s/HtAr3BBSi0QWt8nUaJ1Ctx8T0T2D+oPPoO6ZnYrNGTeG9sisGCdRtVT+bb5L1/Jb01qpukW4+LXOe5L217hPMWrIF8DKCTOUgD1dTmvqoN96obPfntRvt8mq2RHh8VHCYMHgMj4cSMnNsucYVvl3yZXMVMabVoZQan4uD65UvlXYC9XQ8MM6/gygl+ZSczT3wWxCbja8k1Yjmz4g0Ze+L8FMHji64tAZ7zk4Kgyd64wpXBCpZ0RKt5MmnwOXjcuWUnb6/8ayYgZwTSDKZ0KP9gyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0YawNVXPLtQQD6gPDeLXyp/CUK0yzS5JMjQfLyoVtE=;
 b=dl+gQyVwc4BPZuEdb8gKgqzWxCX1PMkyx6oGW19GC4dYUH4wMnoMOWbOTV5aZHZIFSiNTyD4rXfhzfhedMqdNnt/xu9qswq/fAw4i41HQLIIytxew0nQZHPOmkW9P9/u+PtIwBJh2TMprjFZUp/sbbr5d8YCetjG880Z7rIcjhmaxM0VNl44eUHCOLlgCkC1KCfP+CasYNYdahsaNm62emzGtylM1OygPyLciXv0tDk/rtt/XB6Xmm9PUDfnGa1sU1RfwIiEtZUisOoL+Isxaain9MR2ZqLUX0b6Ei2UtOH8KTlITKTZSXEOsLeMGC/3XDu+EQRiNgWtsTQApFs6Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9582.eurprd08.prod.outlook.com (2603:10a6:10:44a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sat, 9 Aug
 2025 01:05:21 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:21 +0000
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
Subject: [PATCH v4 13/24] mtd: spinand: Remove write_enable_op() in markbad()
Date: Sat,  9 Aug 2025 04:04:45 +0300
Message-ID: <20250809010457.3125925-14-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 5f370a57-6812-4461-ca95-08ddd6e0d062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kR9MnJU6m8JPT36Z46PEbVchkBRQ7zPSVaV8OabLp8XYDbyBhVfPv63ZIQTZ?=
 =?us-ascii?Q?bjv3KhYxlRc8Nrg1I1ZCuqTiaWbzXD4/1zxLfSBr104sQ0qbx8nxB8mDgrm5?=
 =?us-ascii?Q?GB3OqmUPj2SWXmboSp1SouRm6wqx3pOK9mv8uxQ8PR4DQCjCwyNvLFRimU7q?=
 =?us-ascii?Q?w6i09lgQhxtLRcp9IxjkEkqw29dkmC59SRQgCSN4nc/Ah8aaoiXyDT/ERz67?=
 =?us-ascii?Q?sHW4AFkhyGGq1tYWUfwG+3CXVMuaeaPAjGyjVUbUl6MBeYEBdqmtsiyTZQeO?=
 =?us-ascii?Q?sAdamQMP/+DXcVPr0g7QdrOie7PqN7Ni5xr1KmSsKISgCWRKr6Ur+eJlfsa8?=
 =?us-ascii?Q?+v8AWkcbvtwkk7nqcyWVDKTWPdXlW65eo8xAw2ok0M5uCKDmWU7Otj6KgUGo?=
 =?us-ascii?Q?cENXswybC2WXzatp8LUgwgdeAOnHXdvBE3egKP2JBKOJR4IaRoN4HJq5UJ8u?=
 =?us-ascii?Q?/9vJygoDf0lqZVua1zhv5vHbOv1FfyRbg3YAY1st+h8eWzdQbIbpKLeCNqYV?=
 =?us-ascii?Q?K8SUfiwLn5xLwfYx50QnrqVzoMQcpJdQBXxe9U0nzm0mF34snYud/uobHNcN?=
 =?us-ascii?Q?D2LMrOZRTXTlsSKGU/F1AsFYuFUqlse2EzIET/E+i3bH8SlLWNtAVAm18J7q?=
 =?us-ascii?Q?HAU9ISF56SBEsG5QR5Feht95HEI3KLovqRjGuECl9FJUgA1MEaAZ3sA5r+fW?=
 =?us-ascii?Q?WgcGdiYC/9D3tp6C2ZYc/j5Ph5aKCS1X1UjKlw7ulB92kscI7ofR16qHT8aK?=
 =?us-ascii?Q?k8T97AJL6tUr0YZS84GnzXy/zIvk3HDIZO183T4JaaFpexpaqLtzop3d7Gdg?=
 =?us-ascii?Q?gxVhDBHuuWA/Dbxt/r0kdjARvffHQ46ILf4ggFL07x7PkSrreFopfYl8AZWB?=
 =?us-ascii?Q?omyIadY9IoJcZXpEVka1JaWNFruR/kiF7ReMqwoUh54eYiAHJhcvtQ3ZzoFo?=
 =?us-ascii?Q?zRxXOzQTP/OzSBbnXawkBv7aIVpek4IlJaVLb+vSiEMgqmUMJELPDDYJmtuF?=
 =?us-ascii?Q?jntYtOPkOAkCMmAplI1UNDi6tF3GCQBFGUDGM9eMMStfRprHmSiQ6ln2ydZ6?=
 =?us-ascii?Q?hI22TRSjxZ7TpR/YctrlMFCVPafSB2fIr/Px4D6ztwv5m0I0WkAQI1NWIJ7S?=
 =?us-ascii?Q?ivFPHYusYIP54ELiVmFmb9kgezi6AIXUODyx/8p/35x34UpEro09VjCbKRe8?=
 =?us-ascii?Q?+pOnG86CXeADQxYc8fq9YLkG1mglbr23rbOASPiK3n75kMUWlEpHm48L1AkE?=
 =?us-ascii?Q?jf6WVAW2S0go3Uet58bp/+8L8wEDiFnoS/I/3Conauz6IXy01eURJyWGxpMd?=
 =?us-ascii?Q?nbWtui3f2TkKdHU8cNAYGUsEcvDScggF4wSSn6hsUgw6azOBnbbNl6uaAMBv?=
 =?us-ascii?Q?2YaPqhegGH/HbKfqYVX9ukCgOWmkJhLvaQ837oq8ac1vh9bgN8/LDknTIghs?=
 =?us-ascii?Q?CeZ7PpZ4SarjdvrADL7FRtlzI7ZG1J8JvT+SoIcyEr6TW9iW0M8k6F2Hb+Ao?=
 =?us-ascii?Q?S6TExHK+mwvpkCg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B6kj9UOl4mRinVmilRkOW0HPARvF/4oIPtt3R74fwpIpeRk5W2r3IjA0Lx3X?=
 =?us-ascii?Q?nIKQBhoPjrzsN6V+yOVaNpoIzeo8Xd6rEYK8VD/7WXIFaTmmy9zl0QBrXuGd?=
 =?us-ascii?Q?xeZoMlTVEyq3qh+QmrqKJGJlVEFPOIFfA1CbV5Tf0m3CqdkJ8UJROewzfejZ?=
 =?us-ascii?Q?y4+/ZhebdMLhLJLdOkPs2McKOB9yJ++qqR0o4ion/KO78dNCYPcSYyKEi6yT?=
 =?us-ascii?Q?QUwG1e22bCqI5y1clGYAB95jyr00jpkTv8j6RY5KG6wufRyMJanJ4IiQdD8U?=
 =?us-ascii?Q?V2HaPZ1UVBsjIcQ2IFfjelhoE0kHkfygKpjLKFOPGcUijPoRi0v91wlA6kAO?=
 =?us-ascii?Q?2ge6ixAzEHsJUhizId5jzNOs+4Ni9Ox43F7/VSM1kAtJFvLrEZ7YNysqsjwJ?=
 =?us-ascii?Q?z9q4mD7KG7q7f936y71iSqB46Lj6A/jPVh8yyqA1RkStPLeoZ9mpixaysTmE?=
 =?us-ascii?Q?bcUNwbcwzr8jbwqSkbVsvzGo5kYRZQPD+79stS/fIzGiSOuTBvK9Do7vg5Nb?=
 =?us-ascii?Q?UkTZXOdA7YfP1+iIDV3Ff4Y1oKBIWYfawUT/V0oF5Qn2qbz2Q9KxpCjeKba2?=
 =?us-ascii?Q?cp6agHod2X4fBP+NTRnoVCNRL3/OuECtX+6mDQ7YcHu/5BhqU5WXRODGx8MG?=
 =?us-ascii?Q?p2UEwH7osjdyawZg7Hf9AO0CYsyUGIWn2n1wAz4Zjl2u7px+rQSY3+jKqjyE?=
 =?us-ascii?Q?7jD5BIXzKPSa6c5dq6aYumJ2YGXybICqnnM+A0WLjDdyevzL7fpx6qvhBlRt?=
 =?us-ascii?Q?AoH4o2FoCtKfdOyOZSOJ3XbG0h1g4YvZam3ymhYWxfjAveTNjLzu+UHSh+II?=
 =?us-ascii?Q?1fF69QohPyxEK+pncq2I1SQOMasN7Yo2JedDsPuGZQrma098MozcgkIjNLVy?=
 =?us-ascii?Q?XSIGkmre2mQf/HePiuqrni2zgDWhzk3EPr+pgEp6C6rC4Vaw/+yAmXfI6XTx?=
 =?us-ascii?Q?uSzPq+9tj8DGoSMEK0cBdH/SvriJ+e2eMBaP+FeB9AyDoIqCK578Qaku2jEU?=
 =?us-ascii?Q?clV0IIvTcCFX9RWbCcZcvFD0fu9ir0HhGVqAdor90FAWwN61nDiIfpX6pPkN?=
 =?us-ascii?Q?ds4E9uJTjjv8D1l3BoV0wkEjh2Torf/YLgycWloFK5zB6qWv6PocbwyA485J?=
 =?us-ascii?Q?crUoSSTm2mtYRj37uF2ahPoAS43FbLExR0s5+LIAA7qJIboMLokkhH/zbZn8?=
 =?us-ascii?Q?m+Xlzx9XxCY8TmRk4+5F9UbmXjpZiya5DenaqFPB+Iy/W5S3JVlxAJ/eLq6s?=
 =?us-ascii?Q?BCHGnOozI3vGgRal2pC1FBHeZcMEYrYwW0svglMMHbA4PKXFhxnLOTD4PoQa?=
 =?us-ascii?Q?7Y3hrNphKwyqmWCoXSQhnYLsEbHYRXKo/w/aaMAi69j8RMFO2esBUrOUe1Xl?=
 =?us-ascii?Q?tgD7qPjXqove62jSb33GnAADOKOJLHfdezgH9tQyN5UL1MgUvTbTORM8Q1Eq?=
 =?us-ascii?Q?ZtzhshNrgxR5rHLPex/XQfO7zsSTn4Do4vH63mso92+IspXrkWrA5eudlIkL?=
 =?us-ascii?Q?eumS/wgGtpqLU1EoHQBHQRJZ6mzzUneynqyLZtCsPRK3tlC13W5buKay++zn?=
 =?us-ascii?Q?bof+0eJuSd2HtvXQ4G1Rsf2a83gbAuWBQJns9S112Kvg/uTSWackNWDOAAsY?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f370a57-6812-4461-ca95-08ddd6e0d062
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:21.5063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YL07mmdYcxFw9+lPtzrxAWWtczcuMrAv3Mx0gFi+AVH2hh0N5YCujGy3EH/dSIJ1aPswd/Kd/Oroh6hFGpYcUANuBAsWrqdbi0qrMDaD7JA=
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

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

