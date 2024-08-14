Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67EEC52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3146889B4;
	Wed, 14 Aug 2024 12:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="vhI7aO5U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B106889D1; Wed, 14 Aug 2024 12:14:21 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92481889BA
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeErJmP/OCGmJKyteismmmY0eEGDdC9/pC8AOXzec4dTqNi1cKozZ1x5ntFZAnrAmacWDh/u7e1BdXznxw8ShFh2fy2NCoIJIfBcSyW7501Y6VqV79q4b7PWKanNz1tdVuc9hyUMYw9Z0HsSq9YQDw5A4MICrFS3uANzxhnShYO3TsmR0x5Ee/oXdjcsF8iqLHXPgoeBnNM34Hzk87dnHgwesasbei2dFaVE1BStxPFD5AkvuAsRAPeX8smrmn1wv6Ga2igpQNRfzVxpNYFDQNsZwWlRabn0LWtY44DssrYuyWw8Xwjpon+jjsVk/2wVUsdJJipGHdXZmz2MqplS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tubk1Ci5jHqIf1YylfCyhNeXr4poF8EcHbkUCS8a6vM=;
 b=YaAkHuQPzLg16CB4DbevV7O0YHcCEGuOS9xDdZI3PM0y5uvEiIvXN6IsW7ShbrIn3EAy0keTFBr1hS8NYnif3bwLf+B2y/2+YUd/Qqksx6pRzqTwV4MQAXDc0UunyaV1UasOwwUCK+Ygm9mOI2mkQRVQVnGb4kCnf+M3UcKhA7spEMalQ5sEQR0MrFdJ2XLnVEdno3Q2zZfLlPzLN03W4ANpi9o0lWehmfQUlcsI03KRdcR62HdxBuUQK1e5JZryVmliKrd3kqCotRW5/T9982DiZfqd6gXd0JVjuXf+NEREu+Dvox7Arof2983x9iPkCGDizhD8yAICEQj3/gWOPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tubk1Ci5jHqIf1YylfCyhNeXr4poF8EcHbkUCS8a6vM=;
 b=vhI7aO5UIHGlEHvsbmffiJmM2w7t0z0rch0pNVrSG5LuELFf64x12FOz4WIdzplq1KsKoPiix4m2FJAfC25crP+X1HihsFedMrmUJW9KA+BIz+d4Rbf192GLblwuQ5ff/F2V9ML9c2IxaevLh9++snnCLBQSFQpWnN0RsSlBr2puiGhwpKpj1cLUVyP0/R+9pXSJmMMV4UyAiTNUeAxP39bUA8IXSLrOQL0LOMcNJt9A1yigwAFjJIEkrRiC7/289xjDPAPmixL7G9xTDCxSdC7ypS7YrBJFI4gttrGYKJAIjqpgpwJQuXg2C0EbwICP+tkZBKVdBIfhp80aop7U7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VE1PR08MB5709.eurprd08.prod.outlook.com (2603:10a6:800:1a7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 10:14:17 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:14:17 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de
Cc: Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v2 2/2] spi: soft_spi: Parse cs-gpios only if
 num-chipselects is not <0>
Date: Wed, 14 Aug 2024 14:14:02 +0400
Message-Id: <20240814101402.1346941-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814101402.1346941-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240814101402.1346941-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0065.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VE1PR08MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 8292d89e-3c41-47d5-e04f-08dcbc49dacd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ACKGSxt2uvvy398QKxuMZkuv/THu6PjOFYZ/sFDpmZZh8cdfSNB48TC2BSLJ?=
 =?us-ascii?Q?trHwaHDYm5noWxyw+/zniUUFeYfzttEZdbyCNmPPjLFdJ2R9MuOQbA305I/F?=
 =?us-ascii?Q?thNHM2+XBMfWh5Q3we9t6Bs9VmPFLguBfteuKbVKL5/7unfxPKVCdOOk8wn3?=
 =?us-ascii?Q?IYQ5Wb41cRg5OsxIaUAXNF0VSaFLBycN2bX/I6d3ymW706whIhdXaeEzozXO?=
 =?us-ascii?Q?ED+SrDq05VcbjWZsthtze2GF+Y84DBhuGqpeTtwydJHXxfJrj/CA2FpNsFqX?=
 =?us-ascii?Q?ZPLNbqFK44vhZ7If60dfT3tBWVhmS9EjFIFx070yG9rriBS70PRKjOXdzMCj?=
 =?us-ascii?Q?8ZEDXRwO1LRm3pZZxFlH+kVo/ePKGHQY6elDqVZq2pmg8QpXNZkjtVbDR7Rr?=
 =?us-ascii?Q?FrKYnOFp9CfrVRbAbmLThX8bFUQHzpLV8qbotuilc7GE0Fc8kRqKI3azjQzU?=
 =?us-ascii?Q?Rx55Q/WEfVfAkTikCNuRO3Un3kJwEsx64/99sX3nuLmmu8A3018769fGVCM8?=
 =?us-ascii?Q?cYT9VT+EB3q60RQ1ukt1PN7E7im0U5OOTi4tET7jUTcvVPujJfS4lTWJMICk?=
 =?us-ascii?Q?cequ01o0Jiqryy/HWAaBGaynp9xLxK4ShfAm4F2/c1UENwdo37bR/7LJlwXE?=
 =?us-ascii?Q?sMZaxRwGmKfG6IWyQi/9FtmjPlFwEBC9iXXO/bl9I/yMbXYnoXbFKur+c7yk?=
 =?us-ascii?Q?wNHoC5+zA+pCHfQ1wTA9mmav+Oh0KQZUGwu75XP4EgnOU6pf2duKiP7E5iN2?=
 =?us-ascii?Q?gTW/QaOaYGla7aqtVxg9Pf4URlz2z2EYtTi72ACyRecSk7w7jZQXxUoObSXj?=
 =?us-ascii?Q?u+UTu/DY8MPz+Uaiui7fbGWuxheE1G7Ynmjbic86fTdHC0PAMKneLAND+Y6d?=
 =?us-ascii?Q?rUccBYldPMq0ZD24Q+/7tpF2zgwuN4xCUKocDMUpPDJPOe+n1fF5lVdfU1eH?=
 =?us-ascii?Q?XHW8ssUq6psESJULRcaceKkylBPidptr2wQW6jPMoPZ14odxn6xC6Ho6oNo3?=
 =?us-ascii?Q?mH8Iyd0NnamTsn4kDK2b3eex4wPk/WZLC07wL7vY/AMNdJRLw6NDzV1YCI8p?=
 =?us-ascii?Q?4U7ybk/rLqb7GXqasHXMMhXKPpV4VIeDkVwKD9eWeqCdaxNOdvfiXhUR70Sl?=
 =?us-ascii?Q?jXrRaYQvxGBj/dfJI+ScLSyZuEGj8s7iE7WvUTVzpetBHXkWiT0YF8rpNyaS?=
 =?us-ascii?Q?OrziUK19yzSxeoVXfoEuGeLaHQDOspR5dJnwNouU+zOMPmla+Q0HSo/YyHMx?=
 =?us-ascii?Q?ibALco7ZAOaTP95q7B9tGbHNnENg3FlsvahU8emaaJmA17vMIx8wRWc1WeqO?=
 =?us-ascii?Q?VYA4taQnPOBRdYDj3oigE8JSUZpKanxWe5ChD05DtFCOzJ2njhI42aoNgh6y?=
 =?us-ascii?Q?n4FGeKJVDTg3ZxMJ5k3BDg8q7M7fLV1KFfpTmldEj8kBkSNtew=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3joeZ4QjxKptQupykGF8afNX+dF/dq3ctUAYn3dwBZubQ5ZczBRhHbSwBiPl?=
 =?us-ascii?Q?+JCUMcVdreqkFhjHLBtIz9chOiFUvIgvWDHwUVFzOsFDa2qn7xF433q5lLIX?=
 =?us-ascii?Q?j6YDfJBsewuFK2hFliA1xh6o8CFnbmkz9NJxZ1cxJjgd5RREZo8bDbeLkS1Z?=
 =?us-ascii?Q?ObVsGTplDia31dm3jvco8lQhnfcjscxw4yFjhl1FQX+0Vd4zHJeSi+s1uxmq?=
 =?us-ascii?Q?6bc3I9DOpJuiYqblDb4wjSiPG8ESqoersCa8BSumN31rkpcMxVk7b7zs98YC?=
 =?us-ascii?Q?8LxaCiU0IGl4kESrkpv2gidnswzKiKMgQ8OEhxrbfZYoNBKEXAKylLqURtK1?=
 =?us-ascii?Q?+h8PM6eJ7c+3StUfWlC/ZaPdGcrgt9K+GeE0vQrRBOBiZ/k4SM0WVa2QWzKY?=
 =?us-ascii?Q?LCI8SqLaD3hF1fe1vV/0wES0xfclqoVUDPX7r3OuNso5VgsSfuiUQ2E/He4x?=
 =?us-ascii?Q?Mn27ctietxxJqxIwr0plov19dDNO3UlLAzHj6hdGcgcD890scBCod5hu9V4A?=
 =?us-ascii?Q?1ZdFFmkoTZNYlcqfITfMXFWxR6dFho5hP5GTv6ow3oIGdReB8qgY3bDJgpz1?=
 =?us-ascii?Q?rV8s1qcjinPR1+ffgkQT2mDQE5EJxih8P4rnWdJxMOeRA5JM0XAdYfxWoA4f?=
 =?us-ascii?Q?AD7y0I8YkpEkwz0qvlEP2aWa2g3ZqdXK82yyaf38feuXxRBHzg+MjjudpNf4?=
 =?us-ascii?Q?F5xKxZjj2eMINM+i3vW5KIvjXxSZ9OjDPC5GozK3J5t/wXSJBjRUYlGauREg?=
 =?us-ascii?Q?/ftCC1lSu6aPv2KkBo2d56V0HS1IR7pNuzWjLWivNbfNZkLh/+kuPUnRghsw?=
 =?us-ascii?Q?AeKPk405A9nitxlYkBe8AlwCtQ5Dd4d81Zosv+/+QQoih2Q0qjFsre0E+WYo?=
 =?us-ascii?Q?YWw88PgvPLJyUbPONomkrWzFRhRqfYJhnIM3vBayNEH1TOFJX7BDuloIfWBV?=
 =?us-ascii?Q?TgwsfUiXHC87PJLX2O/nZdyCEuvm7uK1e2FcIX4Xu5OvYz00z3D0pRoMmnvj?=
 =?us-ascii?Q?P1klMpxdwlCwMRkkSoZpazximjjDl/JIs/vjUZbm3fjb4QnmFGDKaSq7747B?=
 =?us-ascii?Q?i1SZiafHctXkXcIp6HoI8XqOIyJy3Os/muj4WdKKNxt0gXM/XO/oS0HPBxFT?=
 =?us-ascii?Q?q1lU20eCJ1gRObcgEtiJkH9YE46IMJU+zZAIlX1Q0Zs6fEaSErgK772wDsWF?=
 =?us-ascii?Q?z+exlt/kPNPoZ2mtI/aYetEOFWO19yW+dcLTIhO/JxyDGp/7JQcUATry6N1O?=
 =?us-ascii?Q?///HTt+ohehUOZFR8lscSKyss/AAqsMBWGbwNFbPxce3LajGb5S0fsV8I95y?=
 =?us-ascii?Q?cS+QIc6AE4CxM1u0VTXbS69t+bl+znZXaZT/VI2WZR5R5cMmPHZHAZyFjKv3?=
 =?us-ascii?Q?WdPOSVI3QieYy9pYfKRAq+u093sqXtkAupPR14pLIC1EAEI5b2Bk4ejzo6JZ?=
 =?us-ascii?Q?+EL9EqX9uJ30ZddG+4/SFsu6qWErFIq+GczZiN9/wGDtBlFqqsdJQFt3JCVV?=
 =?us-ascii?Q?78Y71UKDmYvbu146VaE+aOj7kLO0qifDKRISi90GEzWGrvLj6RVMl2k2bDfq?=
 =?us-ascii?Q?cXY+cJQFLgRgpNTHo9nx25GiYwsph+cgACKHmFvYBeaMMAgOiXEIPx9KKfTA?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8292d89e-3c41-47d5-e04f-08dcbc49dacd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:14:17.1272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TtFV7QjEzabwtq5g61rYch39eYa9dx3vgZAY+EtZGRomF02B6Fr/MxUOD6fJUIP/D+g/glX0KVJ4VRPBlmY6S44hrSOjFfeAgjuhQWXgcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5709
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
index 04691d3a3ba..a8ec2f4f7b4 100644
--- a/drivers/spi/soft_spi.c
+++ b/drivers/spi/soft_spi.c
@@ -237,6 +237,18 @@ static int soft_spi_of_to_plat(struct udevice *dev)
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
@@ -249,7 +261,15 @@ static int soft_spi_probe(struct udevice *dev)
 
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
2.39.2

