Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823F7C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 04:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19EF08892B;
	Wed, 31 Jul 2024 06:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="iZ4CNHnn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15A7E871C7; Wed, 31 Jul 2024 06:11:46 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20726.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::726])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7317488780
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 06:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NckTiQPdoU0zZMNT400TbgOMQQSyCP7OgMTz1fhse9TGbhZvfLESeKKkQOV0zftf1KYJbz3mW0svcBbpKlkzIWAj7Ni+RfHN38qRtOgeRBP4TfqvO8CU3DcCiIJdPypu9D0/bysFuqCMLUkTmkS7JflaOnHcgWDs8jIrchxx9FAtMUr1Di8Rx5sg2JEZO04diiwB1FBd99DNCBV0a3iZNkRNAHCx+8ruEtu8epEBprhl01M5586OK/l0y50nPGa+rMPbvWOEHlfjy7LnKh2Q3m0m5Q2j3sVID10xHEAqSzvyFFiq6Rf2IVHxykqdCo8PLdflnBFolfvDDdgeVU3E3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tubk1Ci5jHqIf1YylfCyhNeXr4poF8EcHbkUCS8a6vM=;
 b=xmH+2vEKUt2XRBqyTQOFK4usT8e2hhxC21mUl0ljIVqBl6+pjSq43Fk/lyt+UhM2faLb7Oble3upKYUkpIPv3OC+0/oVUlz1Yp2txcFVFUHf3GvK5jssl0XG5gYaeIOENMqd+n0jKLTEpTeQcCnfOptbGXn3KKrWCeAvFSi68EgEGvUAVBkNu+sd/Y0pnmkWbZ1QchiJvSiABRuPVuOMRBaYehob37hHMBxQubK2D+GJ7iTtVOuCgWXB1MJM0WF0qA3MVkny2Devy9ktYEF9VYgopVBwUXAXG+1evKWEv8VPgQCOuWZMcALKD0MfzwapDrawR2YJngIqMsEBlcydhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tubk1Ci5jHqIf1YylfCyhNeXr4poF8EcHbkUCS8a6vM=;
 b=iZ4CNHnnqkI6wGNfQbiOvbJmN1QMJibfJlbKmMxHJPVcOx+KrpdvoZfB4MY8prjwZv48D7y4Q0+VYyt8UZ4q/eJgLeVx0lOx1AaCQvVezpTqcRBdTtBJ5uMXSokxKo64IokrLQsWpfeMAoSPleH4jX0JSvqxsm5hR43ARBu34rmZMpSlyCp+qTpnMTmcvZvbMIrR//3TPQ8F/a3h4VxiSE+LYKEdo77h37YOfqrzHuqeo4Qv6Bz25aFkmsTqQifumUio3u2b1PiaqlmSmALT7QjxoBEw3cRRNMnfTYO0fWtFzFQCoEov8++zTpp8DnU6nLXwXaomTJ58jjiAwkvDeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DB4PR08MB8125.eurprd08.prod.outlook.com (2603:10a6:10:384::19)
 by PAVPR08MB8967.eurprd08.prod.outlook.com (2603:10a6:102:326::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 04:11:42 +0000
Received: from DB4PR08MB8125.eurprd08.prod.outlook.com
 ([fe80::e9de:ca06:dae1:ef2f]) by DB4PR08MB8125.eurprd08.prod.outlook.com
 ([fe80::e9de:ca06:dae1:ef2f%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 04:11:42 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 William Zhang <william.zhang@broadcom.com>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Cc: Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 2/2] spi: soft_spi: Parse cs-gpios only if num-chipselects
 is not <0>
Date: Wed, 31 Jul 2024 08:11:29 +0400
Message-Id: <20240731041129.3839918-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 98782679-4366-428c-e5a5-08dcb116e216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pP3a/gw/jiTMmi5wZSnATR5nSLkfk8AejgVfSRTK5qvJFUgHPCZJ8+fqG2jI?=
 =?us-ascii?Q?EeNB+Ar/iJ+fIQH2rhwvhq/6dyIBI4qm/Eaydg8DM7v32PRaaWD98kkJcjSX?=
 =?us-ascii?Q?flEgaGWpN4VW6sJee1hJ0Ov/zBOo0QyIeii5mlKUnucA7G+hS7p9n+pHpdNz?=
 =?us-ascii?Q?5wwckbCHcR9RjAS/neoh6BRR+rGMnfN/z0zLtaa7BKt5Eqv1uViV1lyAI3d5?=
 =?us-ascii?Q?v7qAbt8xMAoz9lRCg2aWF79xv6nPG7j3r0Q9t/ogW16BBiFyhf6XCsR34YlD?=
 =?us-ascii?Q?YNMOOlaaOp5YjjzLdM3yXZ99zn0NrHo43UBZD8atweR6kqWhuaUXVY6WpRoP?=
 =?us-ascii?Q?FjYOiHG8fkn+jCOr4lgpoz2ggQJYnEXIOSraOMTnjfDfvivckNN7IMSZ4eUC?=
 =?us-ascii?Q?7ZN+FSnZtxT1uO6oIeO2HFC95iMsv66y0GmbLChZrCBomS96bL6ESZccYOMK?=
 =?us-ascii?Q?AIYXU9B9LvKWxvMFvC+J6OOpfXmwxR9vleq6F5fktCg1SQP/Nvk4z1Jj1Ne7?=
 =?us-ascii?Q?3X+CnLk0gqWKyXqIMQQaxcHV1Y71K24c7g7yJQ3FjV/3Fpm8n7DuOGsIiMEI?=
 =?us-ascii?Q?O963RvhqtNqJYKEP2GPgT1UyrY/YAnvyKfDZLuSgkHhDQth03zwBH7lIfyKp?=
 =?us-ascii?Q?plLCXA2wK/7B0Gt8QHxZ4/ZWRbCe0h8LAzgLV9cEV6OVnKOCMYyxWDy/lbVI?=
 =?us-ascii?Q?WchSzwU1HJSDFNO2NnuRTeiinU/3BeEI1EiDPMqo4zgfI3plcMTEjbLV3ztX?=
 =?us-ascii?Q?GxIf7T0a7In0xcJ0YkqF5AQJW2AHXvWhdgWNtQ3N4BEJcglnm6aIGxbgyuiK?=
 =?us-ascii?Q?tkeQeaAsFQ3cOLJRGL1fx9ZGENeOjo2iI9NBn1nfXr9bj++/0wIwam53VX+D?=
 =?us-ascii?Q?CWbfF6eMvbE9G8J6YcM4OJVEm3qmYpFZY8SVq8l43Yc/kQ0BG+8TwtLv0yeV?=
 =?us-ascii?Q?5ZiN/ZG7fUWSz5wgLYzXRn1PETjnDDd5vSRIua0NvwXYp5RKfgaB3OsMHzJM?=
 =?us-ascii?Q?oNE5twiVzs/uhgQwIvcAvITiRS1EgU1DOOzzYuwvk2clBwWwPow/OPsaUYPz?=
 =?us-ascii?Q?xFnlG7hgRuJilU3k3/YTSO4k8WnZi+snGBTdbhDB0ItBFVP7w9C4S77gi2t8?=
 =?us-ascii?Q?vSMMpIBgm4iTAuIcY1iwFbaxtgEjKKN/+/OxMNlEHrCJCu6AtnDQly6EkaFE?=
 =?us-ascii?Q?UhyH+T0cib837xeL6cZzUrvn2hGbqToefQp9o8au/y3S+mq+sia3f+JdFpX5?=
 =?us-ascii?Q?jpJ4vX29v6+8I+QUmqrcKgX3eHVRGYwdWx31H/lZHn0tUmdrwtS1ZptIS5eE?=
 =?us-ascii?Q?VxtRvqpmkK1+k68RY8W9Bf4qkl0VzMx+u3/H9gGsvwQIkkGdCjlXkK3G6h53?=
 =?us-ascii?Q?Z2KQ+9VPTWugiuUP/a964tEi0z9pnzjObaApIJ2xpF/WaPodEA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB4PR08MB8125.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?orm6NXK5LbCb64iIWfi7eAExUCROC6XFtVotepuQdYkV46qMqNIo1h/omiOf?=
 =?us-ascii?Q?1VtL5NrPNhBTukgwos4V5fL2vOgYTLgP6HdDNnGF/2xCCGhlg9JwftBmzgRu?=
 =?us-ascii?Q?+R1+SX97hOasJRM67cpwC/63J6zo8WLCzyUjmxpi5DYqD9UZDBEZS11+ACvJ?=
 =?us-ascii?Q?5a5RXF8MIQsdgrRXyo4ZFhnJKsI7VsBZ8lZiGpQUgSWmwivUpmXhtyUq1l2g?=
 =?us-ascii?Q?/oAdnh0fnaLvfch8aJYLEppUNFuhWFYbfNf20gmurZU9Bxz5MXtHNPKzOOmL?=
 =?us-ascii?Q?D2ckClTesQJrUBi300TL1ArJyJvgT4rhtFg2ZcOHys0/2SgZn7Trl4yM/GlJ?=
 =?us-ascii?Q?0e2qFyzenKo+AOURaBCyF6BDNx7I59JY9nF4h5C3ji0NmVcpMnXo7X+pcK86?=
 =?us-ascii?Q?5C3voXQ5BrfA1f83CYT99D13PHSyoH8nkeyrKQ7RMX5hnJnuchlYKo5hmD94?=
 =?us-ascii?Q?lX2mMkFE2sYj13y0exJ20N190/M/98iWbDXxLGEppTp4RYs5fHllkpSYxlVv?=
 =?us-ascii?Q?8wWl6k6ot/wwdZ5gUsQQY4nurukSkYYvTuCIjPNXSOcwnJz1oGsYZSQK0KAe?=
 =?us-ascii?Q?UfE5ALbcKjq/Vz0ehVJZ8ofP5SA1jborfcfeV+8UfXCF40NwMKxkNBR+H41E?=
 =?us-ascii?Q?2QGMG/ySKdZ3l8PgtBMN2ZXdXGyeziY60nnZ8DckLIL4nvueuYuKSUPwek3K?=
 =?us-ascii?Q?oDlWeTMZbW0Pi5cltbf3rBOHLO4Yw4gq7hpKM7j2CrUYrrZ2LeSwnH+h58ah?=
 =?us-ascii?Q?+YBx5JUM6OIwPlG71uQemsclBqIQxUfAZA2J9L6wMdZMwpecPQHPh5QyiRFm?=
 =?us-ascii?Q?r/hR1zaZL/xTl8uGwZiQqhd58UcHdWCwumf0x6p6ppD+PQmCHD2O9w72gRfx?=
 =?us-ascii?Q?s2fWCHimfuF9r6zpKic4fbtrAYSI68u0CBtjE1B5VbjPStrhdDoUoDiRU0o5?=
 =?us-ascii?Q?mYX2o9+DaxGdw/VJe7dcW9mTEaJ7u8n76Niy1TJN2vzWr9JxeE0yZKEb8wWx?=
 =?us-ascii?Q?LAwD872nNnJYaZu7a3mYO27AIoEu1A+2N2mF4ZoZSVL8wkPobRGZ8+pKhaA2?=
 =?us-ascii?Q?+0e1BeraozQdrFg7IbKw9AfBzuSAoH5inzHI71kwzUREdZSGzazcDaQi8AF3?=
 =?us-ascii?Q?Sxu8nGehfw8ykUvdRv5BUbRXE9RcIruG2oAQRIbgZaKGgwr2JMqsTXh3RmQ+?=
 =?us-ascii?Q?ypaoSa2kOrqbderrXKRfXN3veWQvenRydiY1D97+KMq8gYmh0X2NMLUjM9M/?=
 =?us-ascii?Q?pRgH/K0E6uMLycmGyeVtfDoCBkRVJu358UXq+dvWTkqRZE8UYThcJG7uWufN?=
 =?us-ascii?Q?ZOHX1GSk+jMc4qxcCXyHWBG4Kz2TOhWnxsNqtq3ax1tPrzxR1DzehTuXnkDE?=
 =?us-ascii?Q?4kPGpy/GrtvkQ0WUSLwO4HTk0AGSkoJ/lCdqWVo74WVD9dlQ/bYIUoHxRejj?=
 =?us-ascii?Q?jXiM3wf7QzC+kNJ+hfyOmUPmodh/9aWEiDwFhkgE7kf8DBuzy5ao0BXIDjo9?=
 =?us-ascii?Q?RMA6i7L6Fe2jZTQp4gFZqlxssr0LF/sY6RdhOL9uGzMKCkgDBGptXYK3J8O5?=
 =?us-ascii?Q?6W4QNJdoCgDnfmIb8BbQxzhjvefqEL6HGHrsnTc2cIwFdLQ4oIgFFHFy2O2h?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 98782679-4366-428c-e5a5-08dcb116e216
X-MS-Exchange-CrossTenant-AuthSource: DB4PR08MB8125.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 04:11:42.1775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +oF+ptGBJxFvUnhNzrqkmkheDlUQ45VjIlsyIzs0QBiqpj6QLvJQeGURL1Wi4rQkhW1sM6mg1DDfFb6uuHyaWX8zP+vZrpmFxD1lL9rZWCc=
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

