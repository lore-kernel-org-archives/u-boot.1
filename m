Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E4FCAC5B9
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 401C783804;
	Tue, 30 Sep 2025 02:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="DsNZ5Jmk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EE048362A; Tue, 30 Sep 2025 02:21:55 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CEC1836B8
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICfuhjzPRW49UC46Trs4K+fG9va6jcfiw26gL1YiCTWSTLRTpnjyCZ6aL4jm8xZUWlsN1cL65oKM8c6eFIHcmP0fJofb8NfAsMJ5WoI0NJgFOJPvOHez977KlU/oCn+QuhLXB8QXr/TffNL6Z1PtNn1l6n8JIlH91ECQ6mZ1CvNqzW/UcLtQWeikMW9/pv9NqVxDVPQeygiKH2caFAOdklFHYrmwOOY0I5JT7Okzno6WJPYw/8KbEpLj3JvWSQoGk144AgSJOdPtW9hP3+Rv59zHajj9MWUAi4IIqvrx4qsb/R7uwh7Q0fYl1W8UtsiKeJk6eI/Dciq/UVbKrjYr3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GRaPgYgLw311/8D7jSI2lBsqvl6XU06Saq7ZvX1ouE=;
 b=Xg6+8NtXo+X4mYppIaqP311Nil297EoC4wxNKIxov+SMpapDF8cAvuQoUV1m8abcYL7HNpUAMwIXMJDkUBEEjxuCxlImL3CkGGHRI6VvCgsK86NNwRaPrxyaCPuA9dOp5tdnvfdUPbklcGQ3qrUKJUUQwUfmw+1z758fOHgC3lVSwOuNuYtyOy7AJQRUmUQUXsdynIREHQ51lemawpYALVZ+EIdIcBatm1NNme/KZXooZQhjcNmJ66C952vnwZjRjS6fGwrcWEyV/WcSDPvG/TsN81R66aQ/wQx6yVNAY+uJ8TFVHmEKB4E8vib4iaXAuyXoi6QEn8cy0QRurhZMXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GRaPgYgLw311/8D7jSI2lBsqvl6XU06Saq7ZvX1ouE=;
 b=DsNZ5JmkIfcdw5uKFC0vO/lgpRwY3/748BUumcIJBsZ8yo4KNqPTx315YIe/nZzGz49TJjSzwKbNdMsoCe0O1wEF4J/od3ilwMrMqOuL2P86o62WlBEwhsVimFVVOWmLQ01APkmhBWSAbHUlTZw+djT7bBTOuGw2qht3wZjYOFJ+ZqN93c/fh8QTWx/QQh4yjKkr5sAY+2JvDhsweZjPLve7lyakuQSbYAmiw36XmlsuOVWKctt+WuB97lPIxHggjbtTO0DM8+fwFYu0jboq5bwGvJEKBNql8/7VL9mUc/122T2RGRwkYpxS9tXH+6DYYATvMoRmb1AfkuM5g9AOVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9417.eurprd08.prod.outlook.com (2603:10a6:10:420::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 00:21:50 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 00:21:48 +0000
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
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v7 24/24] mtd: spinand: repeat reading in regular mode if
 continuous reading fails
Date: Tue, 30 Sep 2025 03:21:09 +0300
Message-ID: <20250930002109.3600886-25-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0317.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: 506498d7-b10f-47e4-02b0-08ddffb7586e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Veu9vNlGVDwJSynjNw9/ilw276SS5ieRUC71Rj60Bjq4nY9gBPYnPE0h88sU?=
 =?us-ascii?Q?IHlfRBSr4mAy2jlV09blnHuf6XaPQ4RgtPl5qu/HSpL+3M90TAKOTeVwRo4f?=
 =?us-ascii?Q?OMXTPF6FMwp33ZhrexB0adThDkBFOJriCuw/hfds2ZZQtLrU+Vi6YfX6PS+q?=
 =?us-ascii?Q?mhKoHy8BvTAupL9Wub+GXdzkLpGMr0orJmSnO5eopHUgmCx+8O9mAr+lhvA4?=
 =?us-ascii?Q?S5vkve1cK0Hp6cK5pULpQ22u1TdD4nrt54E9Qe2DFMYaSDqvv6OF6OdAD5Wy?=
 =?us-ascii?Q?IMbnxGv27lvO9B/8z1uWhAcGQiLPxF4Ga+rsEgockDcG8fbIG8ATVrZumLxB?=
 =?us-ascii?Q?5BJAyYhv3jPRjHY/NU2f5DEdggHqEa071wPE6uHwtavijSdmMXclkFnfGUaq?=
 =?us-ascii?Q?nVxCPczfrPxGC+eD0dNAl6PZWPchoyiCxqmf0irAgfbezQsX6kdw01sz6GhW?=
 =?us-ascii?Q?DskSLpfHNAY1rYccpyZiZ7ShkK3QvnVl+3PCaett60dDLvmEqJKDQ1GM0kMj?=
 =?us-ascii?Q?MkuIrd76O/+qd+pFsgxFXabmx0A9MJiJ7hhakhIf8tz5hhU3GIyNKxG00/G0?=
 =?us-ascii?Q?LwzQz8jvk6vGPgryloncWOoV9MFeATTZRb5f4aIBEZ2FhPRY2eeFOzrJIQ3w?=
 =?us-ascii?Q?IUKGam6JQy54LeCVxyOgB17ca/xdlQsUaVpc9yYKH33Wrlz4b2qR4+81BaVB?=
 =?us-ascii?Q?i3owksPFfSFGZqHf9MOeCJxDOBSZay5FFj9Jd0/rzQ+mIysR34laQnmyjWjE?=
 =?us-ascii?Q?puqt4YBxfx4Pa8bU3LWtvltWRCVvK/VD9JIqEHOWJ8vc+WaynVveyW32rMzV?=
 =?us-ascii?Q?dCrUJlDFASGBd8NOFF4cMVoekpp4u2cqnLAy9gYxy1ksjaNdqjsMN9C12imj?=
 =?us-ascii?Q?iczsEeSviaT39nRrv1w+zXz8qD3LzNOzHqjM7edYOWRnzEy0PrVsvUXJLG4t?=
 =?us-ascii?Q?ocU8MZbHvT6GFHDfjeOSTIne+jJX7ervwt7gJaSo9vD4JhhGK2HSVGqSdrKG?=
 =?us-ascii?Q?Tcr7EjIN1Gk9L9maun4uEV8kCMCGidsmvnZs1F7716tB7zy54TV6xKA5Pf+N?=
 =?us-ascii?Q?Za4ayj/QeJA31T9QIlEcCZye/7o2m941Ti3MR4wM3XeA9xLjhGr+pSeKJ3Ip?=
 =?us-ascii?Q?N8zkqNaUwQZS8v0gONo1YCqBPdaDtTJpnicJkfvRm4lvAU1mCLXS5Tb27Af4?=
 =?us-ascii?Q?YH88C9NnRW6Rs94EEgpvpDF6dKj2V6LAGghRJQlVeW/uQ4YAH2la0olWm8tE?=
 =?us-ascii?Q?ptbamMr7kiZGLD7mbPbG4PVVU4gCv3tvGZU4fZaPDk2k9fPUkbTQQ3xlNcnk?=
 =?us-ascii?Q?FwUiz02tJ/Ev7ovReXdV7xzQ5d+37ODvGkhu/igRhNIyExSZjHUaqG2+/i3v?=
 =?us-ascii?Q?tGgTUMTmjDi7/o339fawe2+gg00KzdNDFIJYSdCupTavYdI4FOp4Dlf10DIL?=
 =?us-ascii?Q?ulxH7frmlqCuB1UdKmjVaVZf9mCsAWZ8P7F57Z4GSq+FFu9fxuhpPVRdVGi9?=
 =?us-ascii?Q?r44Rz3MQSFMrECsYfXjlARG5w/wIHMPn7CDbeFXpUMSR+Law81vcv/hmkA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?usWlIiVv7nzrejavUof2zS9hplJZlVELz9HenVEZBN1J2efr+WVherWFcqrw?=
 =?us-ascii?Q?p+RDWb/DsHKf6eg0SZntPhdNkglPrmYQloxZUrvAwMQ2vHIs5wh70UAwhWzP?=
 =?us-ascii?Q?6tIGt3xGZ4wajUPe5SclJNwgQ54/I52lXSXsgeQKymEr9N/SBsnzsTK4ywY6?=
 =?us-ascii?Q?7QW8C5m3HlpgsT9VH9ioH6kYOlPSPDxj6WC9ZVXNkDmapXM05Kt3ee4MKtqu?=
 =?us-ascii?Q?Os2Ombv/hVpvbcIckAtcJmjmOFVFxcnMlvbEDyLqJD49muE+UF6SvT1wHCXE?=
 =?us-ascii?Q?LoIQnLNQk90nmB3ZnrslFmF5d3cD0MFupwh++36LeBn4ZDg+mqfoZB2L4alx?=
 =?us-ascii?Q?+zktVPSEdce18aqdqI/iTcad1hYMB9kMRMnaoVtLspwbIHltfJVCxNS/5wrq?=
 =?us-ascii?Q?RIfGlCzIpn046f6ZPf7p5wKYaxRdyMGw3vS25R2zEMNSCFwIgUZObT87miI1?=
 =?us-ascii?Q?q72LCzpeqLdm+nSQ2cHrfn//osnh0FfOduxpPV39HP42oicr+Kl9rT84KBUD?=
 =?us-ascii?Q?YY8enxbWOXA8T/4vU6UMddkUNiJRt2Q+ZELdnbmU2iL7dW2LgakE7/zCMssH?=
 =?us-ascii?Q?OAMQYFDesFWFmiO+oJXH8QHTr+7J1qRKQMUTDJYFyRKFbw1M9mmxigTekElC?=
 =?us-ascii?Q?sH98bmrDdraCLL14MdqEDpNCIePP1RPqhdK7dAguS/O1vKVuTXbMSuiZ2KCj?=
 =?us-ascii?Q?O6NhFjXX4BwnQhe1TJwa5hNHpSfX7r8xIScPuczn+PwN90717y2kLMj3tcc3?=
 =?us-ascii?Q?8uy8kaHRYo7FPiWOzrrfRInek2jVtKuVopw4HenXkXewVgQ8TyB4l0wlm7TH?=
 =?us-ascii?Q?xAe0Fa0ciE4puT0r9WIK6eK35CWmiB1eAVtIa8eYV3n1A0wida2DGaRMuyD7?=
 =?us-ascii?Q?+zVQ8orLDORvMVxgpzdGx944fgqtRB8dCAXoX2SCCCBPRgw/XDEmMl++eOoH?=
 =?us-ascii?Q?oTRNEbIMyQr16WD9bBPNUSudrXtL3yD5mb2P9fwYvBa0ixsQpD1CSZllGixJ?=
 =?us-ascii?Q?oxS8afmm+xMiSxxFfyvCROLci+wnZe63QwBnesAVX7mmUvyprJLLi29u33x0?=
 =?us-ascii?Q?e1qrY8uhQ0+55oFo9oONY41Ymbwz/LrsUH9clTxbFFdVppPukL5gTKqIIDBg?=
 =?us-ascii?Q?JTJ9ykPjoH5XKub7KTlMWITzcNd6iPoptwwmn1VWdrL82i/glStSufVatgox?=
 =?us-ascii?Q?e30EZurKO6Q5ZcGUjdJePPXeo7ICS+NMuQPM3HrKEskdYyu3XUOu0iPir/x5?=
 =?us-ascii?Q?vQRdn+uXxc4hoWSWRQAJkyc1qBrGu2gsz3UIvHU7glP5BzqLx+J6uvU043oo?=
 =?us-ascii?Q?VPfp6Z9URrcNmpAeGrNAr/EqdTVQCWxOG9C3phKpyIANlcz3IEpOvFVCKFHd?=
 =?us-ascii?Q?ew7V77zSOQjVPjhf7/CP5W7nuVBfZzuZyjeFysI7wAUao9ydLAEuIHi7Dcnb?=
 =?us-ascii?Q?47NTsKghH6eNhiYeiSO6bK4ltKipL7VoNrU6taKApT9kxlizuJUYk9zBUqgh?=
 =?us-ascii?Q?R6DNZK9M/X0lj/EyLtEwIUfEgKhuu+p/g801m/s6T8zan9bzrml34JeVnxfJ?=
 =?us-ascii?Q?FAGfhbKk+fbiL5zb8LM22fALtyAatL14bjX6N0HgzjZfMpX+TyP/5YF+DBBT?=
 =?us-ascii?Q?qZrOj2nJVayyQ0mwOTGhBsw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 506498d7-b10f-47e4-02b0-08ddffb7586e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:21:48.5685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJsfGGkbDit2lvVHcRkMdmkFYawmJx2tBON5hgggJPo+G2h1sORhP4wVg41blyk62LlqOVbw1uejBerz0Ib/jhZK9kkpp7SKHgcF6NhS4GI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9417
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

Continuous reading may result in multiple flash pages reading in one
operation. Unfortunately, not all spinand controllers support such
large reading. They will read less data. Unfortunately, the operation
can't be continued.

In this case:
 * disable continuous reading on this (not good enough) spi controller
 * repeat reading in regular mode.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 68a03ddee8b..0c435059546 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -427,8 +427,16 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		 * Dirmap accesses are allowed to toggle the CS.
 		 * Toggling the CS during a continuous read is forbidden.
 		 */
-		if (nbytes && req->continuous)
-			return -EIO;
+		if (nbytes && req->continuous) {
+			/*
+			 * Spi controller with broken support of continuous
+			 * reading was detected. Disable future use of
+			 * continuous reading and return -EAGAIN to retry
+			 * reading within regular mode.
+			 */
+			spinand->cont_read_possible = false;
+			return -EAGAIN;
+		}
 	}
 
 	if (req->datalen)
@@ -890,6 +898,7 @@ static bool spinand_use_cont_read(struct mtd_info *mtd, loff_t from,
 static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 			    struct mtd_oob_ops *ops)
 {
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	unsigned int max_bitflips = 0;
 	int ret;
 
@@ -897,10 +906,19 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	mutex_lock(&spinand->lock);
 #endif
 
-	if (spinand_use_cont_read(mtd, from, ops))
+	if (spinand_use_cont_read(mtd, from, ops)) {
 		ret = spinand_mtd_continuous_page_read(mtd, from, ops, &max_bitflips);
-	else
+		if (ret == -EAGAIN && !spinand->cont_read_possible) {
+			/*
+			 * Spi controller with broken support of continuous
+			 * reading was detected (see spinand_read_from_cache_op()),
+			 * repeat reading in regular mode.
+			 */
+			ret = spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
+		}
+	} else {
 		ret = spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
+	}
 
 #ifndef __UBOOT__
 	mutex_unlock(&spinand->lock);
-- 
2.51.0

