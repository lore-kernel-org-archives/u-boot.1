Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF366C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 04:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F23588886;
	Wed, 31 Jul 2024 06:11:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="XuyvjKBX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C13A8641A; Wed, 31 Jul 2024 06:11:44 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20714.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::714])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BF1587BF4
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 06:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbWYNI44QuMSxBcljX32Syb5tuiUfauoNlIn2vIA9OQzvpsMXaCwV4raeb6waJqFJzBFZV1kaGAYSriK5oqXJK1Cmmo170RdnrBIixgIq1PnBq4Ct+TfyM1YsYbK9Owy8oUarsQlFOjwvJZLkiZf4sSRDgSl3/STePa6B/CzhX6xPWTIn25nZG6L/L3pYITO4Xenyhqf0C41jjLiPzdjs8aG0cflijNo/+51GWvw184zqPzMvY+dw1oaimcd/CrUQ6hqUU4IeUEY7ojQuR9+DhEi9qG6dmyTNu4eg3i6dyNZnxamVa3KCDTO0L1pk8b7xosZWs/2/AHLIUtbKHFl8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5G4w3w2vCQMDRqpiOZnZpO4dsDjtbEyUCfp31UvFGbM=;
 b=Qqln7WH1iZHA8m7DPdATkluu3r15jkNRPLH0R6ZwMDDQ+te77RKEpyMc5gwp1FvdzYldt87Bxp67BRbm/KKccqqgWO23H9LcX4u+KunQY6eZ1wyHS3rw5b8Fve3AopyE/lCBcgyAQjqUIgrgaOmLmzfbGDLoEmXC2GShTh1PAeFC945YmGAOwgqhVDnviVVJ6Bc8WQxKO1WMNo2xxjO4HITubMHbBInJOpf7vgd3FcwsNBZQG+PnEoz8hscvh7U7if/oc4Pks+8S4KFIt8TDQ929D036cYraCnquNx6NDEUpeGocIEcBe7mG5zbj3ukikBUqrxUDbzb+R36nBn7d+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5G4w3w2vCQMDRqpiOZnZpO4dsDjtbEyUCfp31UvFGbM=;
 b=XuyvjKBXhNYORguODJ7I33rEL+x3iN0oi6dz4Sb6y8k5vNu/fqMG/hmV4U5xddw/Pd/k3N+dKeIRctNarvaZLH1d7iQv6Kj11/zEk9v/nS7/1d/QPJ66OzzBEbbfzhXuhR6bdzRTaemv6SUCGgJFOC2KNBLVcW7czW9ZNUhJvzKHzf+/zeysEejnia+j9uicpPL5C47rRJYtaM7A6iWUFbkKLD+rJF00Nx0cYNSK7xf8WVV5v0ThdhCkFBaanXaG79G7bsJrVdUsDHwcYYrrlaRaeWXZM5gelOSqaPoJ0dfRiKIIrJHzIknnDNOhBWO8ipfX11ePEMh3rdct4ENppA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DB4PR08MB8125.eurprd08.prod.outlook.com (2603:10a6:10:384::19)
 by PAVPR08MB8967.eurprd08.prod.outlook.com (2603:10a6:102:326::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 04:11:41 +0000
Received: from DB4PR08MB8125.eurprd08.prod.outlook.com
 ([fe80::e9de:ca06:dae1:ef2f]) by DB4PR08MB8125.eurprd08.prod.outlook.com
 ([fe80::e9de:ca06:dae1:ef2f%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 04:11:41 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 William Zhang <william.zhang@broadcom.com>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 1/2] spi: soft_spi: fix miso gpio property name
Date: Wed, 31 Jul 2024 08:11:28 +0400
Message-Id: <20240731041129.3839918-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731041129.3839918-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731041129.3839918-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0093.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::33) To DB4PR08MB8125.eurprd08.prod.outlook.com
 (2603:10a6:10:384::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR08MB8125:EE_|PAVPR08MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f6beea-a9dd-4804-509b-08dcb116e140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hw8XXeJltcpG+s9aoGNv7358RuqHAbYq416+1avlRPHSzc101EkSi90LL3Px?=
 =?us-ascii?Q?vGZHAketBC2e3HkoD2WMgnKTe1kd+5RtbOdUWE9UjhqwE3Mntvm0F0h4wSgE?=
 =?us-ascii?Q?+Y4FQV4K68Lz14x+EV2QEouziOCaBcbUBNCEgfT0E3p+bs80/rliS7J12bJ2?=
 =?us-ascii?Q?QBhyTkiNx5EvJ+C2LJLEyZuJc4x5x5LryzFsfh8gL6QaLuJkc2NHJKvFkCSR?=
 =?us-ascii?Q?KQvrLfYuyIPEKTBEjsMf/To4QKVGFvEtofYgNg/EIXKrwLW/JZ4koJ5Xhg94?=
 =?us-ascii?Q?2EK8aYzwtWaET2IAlMzmDLILJoyCBVF4mlpxG70FhqeHDVbVIYGdKKH7ioCc?=
 =?us-ascii?Q?Y5kP3IMKpXRAGsMk30qEV5y7XQicl+HfCoqT4Y7ynMZ0kzlICDHTxSxRKhHq?=
 =?us-ascii?Q?Yujq5COdhLbe2ItM7qFjcUvvk5jgVELwl1JJ+lpgLtQy6pUKpn7zCIEwETrB?=
 =?us-ascii?Q?czT2JNUplPCytlFrZ+T2bOzXgv57/4WOOjGQr2CvGRcO68HEyNvUzfPbBBp6?=
 =?us-ascii?Q?0OLcdJ9+WPMY2KoX4KYBDq7wEvzkKtBzUvm4YxPw8dHIS5cxRF3ZOFVvWviu?=
 =?us-ascii?Q?r7b5jxSyIznzeOp5RCbuJlxXyrVxNzo59uOMYhbStKTFqDOKBv47T49MuPYw?=
 =?us-ascii?Q?BCzHaCjJCh/+VQbn+B2uDYtSap0vE49eoBcbPGjdZzr2D6a88usD9K9O/Jew?=
 =?us-ascii?Q?ojNYuxNkSYYOd5X4SNkY0MBJrTlfOxraMiCn8GG4Xi0SoPEJ4dQyqEEyKdt+?=
 =?us-ascii?Q?Brr5pKMG//EozhSuHEDIjMolv9E6262KBuNlO5HH6cX7NJf1Q2PZL1zM4Bvm?=
 =?us-ascii?Q?PUiL/XA3IWTytavv2EuVZbLAhzpQAqSMaG/CXLes0jvh5c3FGpVlBgenaFwd?=
 =?us-ascii?Q?aeWRKkEMfCrqRkQQ+2Vhx92IX9jHPrpteSclu76nkfe83dR/gw5v4Xpsoe/S?=
 =?us-ascii?Q?F8PLoBvLJrRSlWPojsVvz+4drZ7/Su24Rh4ekCI8MQgOMG4C0YFNWwVVwA2c?=
 =?us-ascii?Q?7QmnVCfArTvP3HIt6QTEa8bAi53H9lZ+FN+YuY+wSNqjhU24kqI7sQp51ZFR?=
 =?us-ascii?Q?xEfDWYuILW0OSqUQLrnR5H/5A9C/I67umkW2U51HKx70p7Me3TtfOWj7F3i9?=
 =?us-ascii?Q?kkDqANYK8Gx2xSIbJTlvE8K7kckRcNU5HYzjH9WGbOKdykg7l3x995Mlu6JI?=
 =?us-ascii?Q?zVQJ4zAjEtFo3szk8cV2vRKOeWwW4jnnx+Gke+x5A5i9LO0xfARIFs/0Ez6N?=
 =?us-ascii?Q?mv5bcT2S7I7xgTBt7XVnXQ5g2d8WVirrY2shbHf3NxO1J1eM+hwD0kfw5tpk?=
 =?us-ascii?Q?BKDdodYRt/xYxc7UixWO7+2iNjpGUJDb+Z8iLLK86OLd7FhqNnJmfAMrDJV2?=
 =?us-ascii?Q?PbRguCXGNOy7sWMvODSEeNK+Sxn2z24F4Jei/zGbGVmtj7iGLg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB4PR08MB8125.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HWeCZ07B5gqPsWdIItaDyLLq54zwU3tMdiNQNNqIl5jpClsQA24sZiGEyt2/?=
 =?us-ascii?Q?mnCM1jyQMZhxoypExWHGY0fU9UlDSESDg3DnZ25tfE65HxoJWAcbqGA5Knp5?=
 =?us-ascii?Q?OlFU4QJ9+1NBRAL35V4x/6RMvvRRUjeirNltu11Gde7SkqWk0ZQC0R6Y1v+X?=
 =?us-ascii?Q?g1HVrGiRkhrGi2LQO06p+FzWibjBQK6AnMJBl7vTRnv7H1CWoFBR8DPOo3Jl?=
 =?us-ascii?Q?wA6ESVv3fWay24wywK/2/DuD08NVn9Bsp/hgjUbobkH3iZe35D5UVPcNLKBJ?=
 =?us-ascii?Q?nudnDm6Tta4URyKpNKvjZTfJPJx0Q1op8K36r5vYHlYSRQ8LO2zUUJz/rg7D?=
 =?us-ascii?Q?hvtRbDCvJ5v206M4P5E2uVOctP+8nXqlwBnpFIpxu87AZT5pZt+C7qejxmNl?=
 =?us-ascii?Q?LJoDFVwieOFkqm2t6zD8AWjAuB4F2qcvScrTDNGqqDFqQVOyivMK9lEJv1T/?=
 =?us-ascii?Q?W9vO4OFCC+yv/4/GMO6MuLp/nPPU7252gAg9ffelyPD5+OJKHY1POBiqpBSF?=
 =?us-ascii?Q?sVVJCWHRspBdvjQqhTxwJKAjkYBqZMayGVzr9QdHa12t4FM5VL8em/woBkRy?=
 =?us-ascii?Q?tyBgQE2k8Q3VRMOcZ0ZosaKKDMcmJU0Jmw1S1Y/7JUhhlsNUWW1T4MbeMSqX?=
 =?us-ascii?Q?2hWfUzBHIjNzgO0oQJfi6C8hqpAujcJf8kpEv2/CeQq3nudDWE+bMy2SrYxg?=
 =?us-ascii?Q?Hch4jCz06USR7+Pcro354z85pTk7+8ka4I23ZMi0gKcHRbApDVUXgXSImaIx?=
 =?us-ascii?Q?knLa4nz3ugWCrELbBKrc4ytg+5tUXEAddy5o5KNb/gQnasg+8Alqpkapu+zT?=
 =?us-ascii?Q?dLHd2dyXda4SVsOwvYjonrICmvwU5cT9vh88reqevVn2mmXA10UspEMyA/Lq?=
 =?us-ascii?Q?tVvEbkJHAktX3Zluo5S6V8jsutMutlbivXDyBrriL3/+hX05JdBR4c0OzWwO?=
 =?us-ascii?Q?esumsU9ZM17/h+8Pdy4K9HBDkXgFP4iRii7Xu6SuGpX0GMisaFD9JE6Vuwrs?=
 =?us-ascii?Q?ugSr1fKA6jNks80GkLZjPmONdzi51kDhQG4EeDGncdKwFaGY/4mmQWFJIQHq?=
 =?us-ascii?Q?C8RPjs9Y7kYsZ4FJu/ojYdehn43K+Y/bWviYPDk6CazFuxQ3jPREtlu8W/gg?=
 =?us-ascii?Q?AzPAg9RsalJhygcsFOO+zF6pO79/i1Eovup1FEigo/yHcAUg8NHdqn+GFDtG?=
 =?us-ascii?Q?b7Iex6zgJVO81edA3X+c7O14bp/3tFZIZeyzFCJt5VFBdLY9Q3bA7vAxa1jk?=
 =?us-ascii?Q?P3nSxqWsfnqBL2FnjAx8yo9GFUTQyCFsAmQB9RI8H/EGCc7fW7eWDkIZXPUs?=
 =?us-ascii?Q?kvKWMaWhyReaIxr/D2npQBOzZRDblx9vv7MxTPRwVx5UES6CqbIU89ul62MN?=
 =?us-ascii?Q?72fA3JC9+9jGriJY0aGM5rxq1WTmN+7FEkv+nfcYhmqPr2rCaBy8D4HA6bht?=
 =?us-ascii?Q?uufqFn5KHZ0Gl9yzdJoajENsGJz3ImXD3hfilOCs04PMyAWaY/a7CgTnFSFz?=
 =?us-ascii?Q?V1wOk7IzxTY98atI3ylTqVXdl1mBwe26BHDqmwE41z1Txb0NpeOYuoPMXIsj?=
 =?us-ascii?Q?LLba+KhYec5/oz4wWvz25qXiYX0NjiDJAZ6EqzIKudfwXn0ZmJFqZi6eSOqH?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f6beea-a9dd-4804-509b-08dcb116e140
X-MS-Exchange-CrossTenant-AuthSource: DB4PR08MB8125.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 04:11:41.1556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADRGyPRN2sjDR8SKOMm0T1OrwbvjSmJTBl7UXkbVDJfLzLGkO+t664o2SXj2nqlpF5IcXqc9N4aK48k++hWubSpqctE22jwD6+Z0wlbkO2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8967
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

The patch fix a missprint introduced in commit 2e9fe73a883a ("spi: soft_spi:
Support the recommended soft spi properties").

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/soft_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/soft_spi.c b/drivers/spi/soft_spi.c
index 9bdb4a5bff9..04691d3a3ba 100644
--- a/drivers/spi/soft_spi.c
+++ b/drivers/spi/soft_spi.c
@@ -271,7 +271,7 @@ static int soft_spi_probe(struct udevice *dev)
 	ret = gpio_request_by_name(dev, "gpio-miso", 0, &plat->miso,
 				   GPIOD_IS_IN);
 	if (ret)
-		ret = gpio_request_by_name(dev, "gpio-miso", 0, &plat->miso,
+		ret = gpio_request_by_name(dev, "miso-gpios", 0, &plat->miso,
 					   GPIOD_IS_IN);
 	if (ret)
 		plat->flags |= SPI_MASTER_NO_RX;
-- 
2.39.2

