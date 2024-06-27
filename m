Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52812C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5C8388549;
	Thu, 27 Jun 2024 13:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="AFhzq8Gl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 282EF88549; Thu, 27 Jun 2024 13:22:45 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F77888511
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqwZTkxUFT3DzIhdFmsSftc9KapugY9VWzi32Q0gC3lqkZAz5b4loZiIu3p21EJKBXUBn5qpBay8E+j3wZZt4lcGDFS/DLSkK3CNudPsW2CVf6ObT0Fr3XAr5SY4trXTGmKcV5VhzLxeRKtTMfDj0/fkv5mW1awU3PTRJB8/F9kab5PGxP4eVAaRJMePqt6EH5bdu83iblpoLemfz3aT+wfbNTrC6oSXgZNE7x9NNFtSVIpiqhXrdAiMVWb+po5CKBhWOmWAUGWTZz663nkiJ2mO3Lsz+tjfN1NoQtOGpb8DchjkObVO1ptT5iuCpFm0SbHakeOX0EW+Ca3SAosBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYbuv/dJLr4BQuYztjRk5SSe8qBpn+9bmqRF8aH+Axs=;
 b=fZfvWPtEzniyFAbEMIaq+2s9VIvphBNXPLEwc0QOAwLDB3tF0wuIrYP0nP0j9GCLnuPsUPPG7Vn0FGKjGO5/qgYCqCL5Clmv+ZA4R+4qajqwrU0hb3s5ZT+7IgvwzA+iuHXm/kBgeaaav4lWmTuteDxHSGOX6w5fXZ49dh8XjhUt+4HsjTO650gdJICrkxx/xO2ZXZYF+MwRVvzDMRqTu95Y8MkrVhaUOiY4X01/2xNfgPA8lVTBNRIojRru+msKaeDlTo/thDsaxn6jhT4wxAdp4/+9Mgz21kDaUluvsBE7NEZ9O5jKmGp92IXO0OgqOGY/lqdK47QfJW2VWS/vmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYbuv/dJLr4BQuYztjRk5SSe8qBpn+9bmqRF8aH+Axs=;
 b=AFhzq8Gl6Bp5y7nO6Yq/fNg5J4Aj5vcDDen0hcTGRgvSzGXcXjeJoPgU+ctiJP/b/pPoBKcAQkF1l2o3GMLMxpz8VqBA9mheENCGJecGk3JlLyfRE8NAsWpUg0yna0HBrAVl5gn4BlhVAujGnpZDsO6z5GfoKM5khmL+dUTPVqB3eZkFlqd4aKY/OTtkoVpKFPXfh4MnN0xx24k7yQhx+8zEdUimimuSp69rrsyOYR4fijOTS3CgXeu3WVIFmv5e+7hH5H1KoyZmfEJbpp3bx/OtGznBXHvg68vreNiRXh2am1PMZSOe6alISdQOIQpwDSmPLPO4ao/8tKLvJ+7Qeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB7695.eurprd08.prod.outlook.com (2603:10a6:20b:520::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:22:40 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:22:40 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Fabio Estevam <festevam@denx.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 William Zhang <william.zhang@broadcom.com>, u-boot@lists.denx.de
Cc: Michael Polyntsov <michael.polyntsov@iopsys.eu>
Subject: [PATCH 2/2] spi: soft_spi: Parse cs-gpios only if num-chipselects is
 not <0>
Date: Thu, 27 Jun 2024 14:22:32 +0300
Message-ID: <20240627112232.99507-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627112232.99507-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240627112232.99507-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E42.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::4f) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 650de307-e1ac-427d-238f-08dc969b7478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VHmHTwsTcku4Rbfgs2lr7HNNZApFDsNU+5ub47vqtCMv30M1ufpxyYVU8b2d?=
 =?us-ascii?Q?mEYay9PI36eV7wTnLy3B6b4bLr8tIfRni0QuYTTY+vXWAk+XDU5TXnBlqB4v?=
 =?us-ascii?Q?I4bH8YIi27R9JjRFLmVbG9NI+c3NdwwnUG+mcAStUI4HNOBqlpNAQZMAztZR?=
 =?us-ascii?Q?FFao+OpXKb/cHFTYxcuFQvvFJg3kUm0phTzWfHsB9p4yogzDF2ut0ORKTbKg?=
 =?us-ascii?Q?4OqwZ/Cz2hN2qUfIyh9t/kcYDyxD4K9805pHSOEl3TMRsalsVv4sJxJcgMQH?=
 =?us-ascii?Q?kHEWcpB1AYiiVz4mxlkxx/FhETI39NVokidUPW4opJMb2o1ta6nRfljnDhM1?=
 =?us-ascii?Q?Q+88hn5iHuZ5DrGwm4LZVyySGLSbVnDKhfEHQNgORFKn8SGG9ygIXi+wj5Vy?=
 =?us-ascii?Q?iXU3ZqZhq3iZ5dNpPo8iFB0D8at1BYsCPkADfgVvtRgjqjX98y4wNdyZeUS5?=
 =?us-ascii?Q?qDNOg+cI6hF3+F13UcxUFgumEoF8vFy4TkHmqGFrogWK764is8GabJUuzs52?=
 =?us-ascii?Q?BN9/30rgCQY9NyAOt2SH5e4e72kFeCfl2F7W0twxTX9X7EfmHKbP0HEapqit?=
 =?us-ascii?Q?KqKB2oG1ADII1U8bI7pJftl1zbjgLfV0nsJHJRERN1avaR293l/R7kJSOx0E?=
 =?us-ascii?Q?Fq6aWFLcaOSe41g/uimaYXvUtrUTX19DB5qQsaqnWHCZuo/M7ChYD99qaE7+?=
 =?us-ascii?Q?6wLWZLP8DFE2yg8kt2j0WYsnQehzfIumsM92DIp/i8tWJyuoSUuIrrtPOFSK?=
 =?us-ascii?Q?LuYZrAxCfVIN0aSwSTp+JtVV6bpcLaDZbwWUoIZ7JdsZBSbuQ9rVhUzndy6Q?=
 =?us-ascii?Q?vpYvCQnJoqNwYVaNFxum3fOJT4elV9ydx1pkIaeWc6SLJnOmL4xfFYI32eGt?=
 =?us-ascii?Q?4fqZKkffYrr8Rpy8GSzBBCiVn/kaLqzlTz5mVcX3/bEr14qizvHLH8PPR25T?=
 =?us-ascii?Q?AXN8S+cR2QiTPHgYV7tgylB3gjRlXHpd5fZwaPbZ1aVUdeso30ANxQ9+Y2g+?=
 =?us-ascii?Q?8zJYVG0mfaZk5PDrsJNimq92R/Wrn86BUnEft1wryl3c7tEIbj9ZcpbWcwfH?=
 =?us-ascii?Q?0pCQRieX4ydxkUxMLlSsbcbD3OPERbd8NkAUWa9R0IMBg6AJgHWD3naoR5Tx?=
 =?us-ascii?Q?ntVHlHRD2cbbOSTqCGeRm6M/jwsYXijhRoDL7xe2N7AskTC39azFwdtRoNSF?=
 =?us-ascii?Q?M8XqFuH1qBsnLi0591Uz2WQuQEpRGYjrqf/8rbIFsnHbnk78BS4Q44wU00Ve?=
 =?us-ascii?Q?+3jEc9upHYXwAeWiO0h8Ci8mLO9XhpJycBZy3euCV5EwhP59sWgTZTXjKRXR?=
 =?us-ascii?Q?s58mGH47X6tNx46ElCl04uy5KsnPle4bmLL77mWXLBMU8B63Oync1jgmbuNO?=
 =?us-ascii?Q?Ub4CUqm+AV52uOSdV1lYRqoPQrQkyYHyfoRTPEGAWPJT4eaoTw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l2nNeGn40NAWkcg9u55kQ3/Gsvax0Vw7QYvprPuwKeRiM8H7kOriQqNdKrOX?=
 =?us-ascii?Q?Wxv5bs7587clbBSCdqnTqf0XOB5+WCIyDosmnIGkYeHv4SRAoo1LhmlBuxKc?=
 =?us-ascii?Q?Y+CGRwuF8tLDXW2BmmGvwgLMfU4JNgvQjGgT1IflMvgBzmHrumWg/Nm/o5w6?=
 =?us-ascii?Q?q2vnElXFHMVbCE76pySZgVZdZfYnxigYe1OCUcadkgRhczXLK4Pe9tvLXDoW?=
 =?us-ascii?Q?XKo/qu+hRWgCtTP3A1dXnUhbGmu9SeeCmQ1ZJLFG090VpmunMyebUpVwERgI?=
 =?us-ascii?Q?EOa+nDuYQtX7+0jRT897ZB5EJ4FcN+QxXGvWdAvXUTEgmytVC6eDO3wkMVJ0?=
 =?us-ascii?Q?qU+uEUns8J0YpnRzpkutn9yPiUNeaHHA7X8KMWgenl9uOU3AqNNE7M2DW6Zv?=
 =?us-ascii?Q?QDgznND6uIGrUdCi2vA8wdBbwrFvqWgDeBg5PQRI3pmKbj63d/1tM56eZZ6o?=
 =?us-ascii?Q?DlAxrXOX6YdM1CnOIHKDMCje9j6GdCqgnsjunXuW4WG5DdVkhxaWRVAEhDsR?=
 =?us-ascii?Q?eg1o9k+3ddMCqzVdMXmhSs0dZMiz65GMOG+X7JeD2rROSi+AisTqQ55BoG/H?=
 =?us-ascii?Q?N3bgHQvS5nlrX/U0yB71GLvnv4peOegGn9SQT3n15zHGv+94B4kFWtsHssIL?=
 =?us-ascii?Q?StK3zGTrSAUK6V6oy1F+RMj9uOVbR5QRYkCmEJ8ipOCygMeJCRSZaexJjVjh?=
 =?us-ascii?Q?oJL01VeQXZVnum8pkP4A8EjHYuAhgTiEpyX8c82hBvLn6lR3s586Y4VM5ufZ?=
 =?us-ascii?Q?onSuhXfEaUgELGlS7kYWc7noIcUFgZYZ6zidgUtQ/xehGUCQ00b23OKjZzS9?=
 =?us-ascii?Q?URfR5hkAZtZkU+CGTbggXi7QK64zhXkVFA46vjSv7cxI8j05btUWSGtiHwPs?=
 =?us-ascii?Q?GW6aWOykNi7TqMhbHu1PWtEv38nRSDsb6sBQERhTEZMSFZ69bCk0ymRHMzty?=
 =?us-ascii?Q?ABaNip4KT8CTrzVtHVuxjmfLFLVBdAc5Jrc7ohIcYtj4qvHKw0VjzWSFapyK?=
 =?us-ascii?Q?iAqeLR7IIxebpd1zUbVF2vW6kOfCp4Vuu88b9ZWeCQgdPxrCRKO9RR7MMM3S?=
 =?us-ascii?Q?s3VIZJ2apY9U3n+88X16qQLEBDuRgsNbyVgw8jmVMupb2CevucFa1SmQ/Ohe?=
 =?us-ascii?Q?YF2D1NyxoQFha6PYWhiYOpPiMo3SZeLG1o7TAwtD284cLHtPByyduZ4W4ThV?=
 =?us-ascii?Q?kdJ2HJ+C4aYonoOxaqqOPi+pCBt11hZwA4/VoRrjTkDrnTvh7eIjhY6Idh8p?=
 =?us-ascii?Q?q5MgaUvJDIKMKHqCTV/PUeGMhmBv8IFftNd0nt6RhlchZUg168/0n2dV4Qfi?=
 =?us-ascii?Q?/D6Xsjc9FPcf9z26YNz4LsQIZodRFFBRGlNf/PuCZLg33Cf1xaJvpdcSmdAK?=
 =?us-ascii?Q?DYQqrYd/mEETwfweDLfX0evgIBLk88BFu0rflbNL4+PJA1d/VIIbJArFyItJ?=
 =?us-ascii?Q?Di0+yyNr/VAt2/roslxtPuPoumQmQKQv6q/Ig8drlKvsY0jvVzRBMMYEqtyQ?=
 =?us-ascii?Q?KZY8VuU5B3D/co2PSAIceyapAFKoOmRo/b4yDCB52yHeU9GLmYhppZzSw6pR?=
 =?us-ascii?Q?B4Xk5xhyXBx9Xlm3qiZJkbygW894E4nLoxOzZzV1r5s5oa7Eg4cYdRx6vp6K?=
 =?us-ascii?Q?hTc/FbjWW5brgWcIKBtel6c=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 650de307-e1ac-427d-238f-08dc969b7478
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:22:39.9775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tm+9jHQvByGoHI8yMsZ2dZsEwJB1EpZbD5JuxaQ2Q9r8NgFbymx2ErSwAiaO/H7IrN3XbnBhf2h6h2mznVeFWExb9P9f/fRuwYdJPEoHQmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7695
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

From: Michael Polyntsov <michael.polyntsov@iopsys.eu>

Some boards don't have chipselect lines for leds so cs-gpios is not
specified in the dts leading to probing error. Fix it by making
behavior similar to the one in Linux, parse num-chipselects and
if it is zero, ignore cs-gpios.

Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 doc/device-tree-bindings/spi/soft-spi.txt |  5 +++--
 drivers/spi/soft_spi.c                    | 22 +++++++++++++++++++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/doc/device-tree-bindings/spi/soft-spi.txt b/doc/device-tree-bindings/spi/soft-spi.txt
index bdf7e86befb..77b01b2fd9a 100644
--- a/doc/device-tree-bindings/spi/soft-spi.txt
+++ b/doc/device-tree-bindings/spi/soft-spi.txt
@@ -8,14 +8,15 @@ The soft SPI node requires the following properties:
 
 Mandatory properties:
 compatible: "spi-gpio"
-cs-gpios: GPIOs to use for SPI chip select (output)
+cs-gpios: GPIOs to use for SPI chip select (output), not required if num-chipselects = <0>
 sck-gpios: GPIO to use for SPI clock (output)
 And at least one of:
 mosi-gpios: GPIO to use for SPI MOSI line (output)
 miso-gpios: GPIO to use for SPI MISO line (input)
 
-Optional propertie:
+Optional properties:
 spi-delay-us: Number of microseconds of delay between each CS transition
+num-chipselects: Number of chipselect lines
 
 The GPIOs should be specified as required by the GPIO controller referenced.
 The first cell holds the phandle of the controller and the second cell
diff --git a/drivers/spi/soft_spi.c b/drivers/spi/soft_spi.c
index 3fe62818a44..2e80b7bb08e 100644
--- a/drivers/spi/soft_spi.c
+++ b/drivers/spi/soft_spi.c
@@ -238,6 +238,18 @@ static int soft_spi_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
+static int retrieve_num_chipselects(struct udevice *dev)
+{
+	int chipselects;
+	int ret;
+
+	ret = ofnode_read_u32(dev_ofnode(dev), "num-chipselects", &chipselects);
+	if (ret)
+		return ret;
+
+	return chipselects;
+}
+
 static int soft_spi_probe(struct udevice *dev)
 {
 	struct spi_slave *slave = dev_get_parent_priv(dev);
@@ -250,7 +262,15 @@ static int soft_spi_probe(struct udevice *dev)
 
 	ret = gpio_request_by_name(dev, "cs-gpios", 0, &plat->cs,
 				   GPIOD_IS_OUT | cs_flags);
-	if (ret)
+	/*
+	 * If num-chipselects is zero we're ignoring absence of cs-gpios. This
+	 * code relies on the fact that `gpio_request_by_name` call above
+	 * initiailizes plat->cs to correct value with invalid GPIO even when
+	 * there is no cs-gpios node in dts. All other functions which work
+	 * with plat->cs verify it via `dm_gpio_is_valid` before using it, so
+	 * such value doesn't cause any problems.
+	 */
+	if (ret && retrieve_num_chipselects(dev) != 0)
 		return -EINVAL;
 
 	ret = gpio_request_by_name(dev, "gpio-sck", 0, &plat->sclk,
-- 
2.43.0

