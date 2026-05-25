Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D92ECD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 348C9846CA;
	Mon, 25 May 2026 04:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="PFrU6ar3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 899B48484C; Mon, 25 May 2026 04:46:27 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4C1E846CA
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 04:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OoClXLcwcWGN6HAMY7eeo19Y0YXcBf2EU8RTrfLBNqbEYK25sQ/E5uND4Y9Bki5G0qO11mgmfXDMQvfqRzHdMuP+BRr/wT8cgP/LU40LFYW4+UFO+/FNy5Xwwq+s4BNJ1o2CrWQETw8C5XNvJ5tZvdhdYPDto340hi/2G6gT/7OZAPJbUrf39ISHuOcfyIfU4yi2TotrUGR5Nwy3ouSclwOMovAeaG6I26i1lIRsZiv2qXkEd9RyoRxWMQVUoXQulw6HHTQw2r/oHMjI92Y1FMDlKQJj1ZRPKURmyUUayH2iPg+iNmDm+z44pMMq9gBX+V2KpdK5zX4JAYpI/HfFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24HHUFryRHVF0jr2gp9txh0nPeJ2AitxhoX5Tm78Q/0=;
 b=KiFovsb8a9NY0ocOR6zz3TN8ScNRciMnRKgprQcimeSNui5uoUFEnd3NQKxrHA90Bgy/SOMB4PKCCPf76Lm7tGL/e5w0iFtce86GgTWXXoAAYxeRA4bLa4nDkmbVnhKuKgPrOirJp69QmIzl17dpKjar3S2akPD4CjufFf8OC2SkwK0kA71nmVF/KNvJMlahZTDaBPgAYGJmzgFe6VCjKsX7O6J3f8rES2NSxKhXlDOE7MGw6FDA/lyufF2sn9SAtRowrAa+7CgLHge7xTMCNvZ0BFo/fZo1WKGLKhfXQMNXyfXZJlKSUfGr+JqQT5vHXC0b2VZXY3V45HoaTa9mRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24HHUFryRHVF0jr2gp9txh0nPeJ2AitxhoX5Tm78Q/0=;
 b=PFrU6ar3rYlYESpIpkMPImP/QbZxttdOP2dGTNRUZpHRbikCgsB7G1UocA18wQaY29WRVsv2XeK5VYVLTi3EnIXJHZpcgh+EvtHc5oanydQ9M1tkZm6eBXANou00t4DR14Ve6599HWB2zy33qADm23cEWl0E8dTW7oEFuWkC7NxY/FlsfZjsIQIxlTDXP70EUI2GVaG+dK3a5wrZOVzpAV0zZ0vedHMK4Yos+tOpAV35V2O6osknsh5Q2ro93BrWD7Bapz1YcjmyjEVnHDnlTYxKqqTg180rGqyAVsapahJMOaRpADfrPAaLuUqTAlXHBpy6x4C56fFT5oynotGggg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PAWPR04MB11707.eurprd04.prod.outlook.com (2603:10a6:102:509::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 02:46:24 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 02:46:24 +0000
From: peng.fan@nxp.com
To: stefan_b@posteo.net,
	hs@nabladev.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] i2c: nx: Add License
Date: Mon, 25 May 2026 12:03:03 +0800
Message-ID: <20260525040303.2367825-2-peng.fan@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525040303.2367825-1-peng.fan@nxp.com>
References: <20260525040303.2367825-1-peng.fan@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::17) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PAWPR04MB11707:EE_
X-MS-Office365-Filtering-Correlation-Id: 638a4d3c-d895-41e3-5322-08deba07cfa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|52116014|1800799024|22082099003|56012099003|18002099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: q1qgCW9fvy3UBznh9GayWEtnAgdz6ndroba9BQSjr8oCpdTYY9InvLPVrULhxo/dao4Jr+g0DwPhdyEkQ4ZgCAsuw8CqcGMdlGjwa1k9GpiV403Z8XlM/exl518LZf/Y6foZ9nhhViuYKduhFV8yeoKSDVsP65GcIlo16xz1pbKYNd5hOK4RY56UyP/92Em6DOFX08UpusC7rpCgPirLAyG5boh7/pDyj5eo8YUTfjXk0QRxZO35j/GuraizyspvmqYBkXXpDHts7/Glq5jwK0GWuaRHe/SM3Us6via0Q1tqQA++2WT7ROCT+b7Ec/Qvp4bXQiPcy4cCzEgoXuZOoLRx1zYTOo1+iJ7WpRZCbM4zUGervEpQTr31yzLObKVcjkOCjxS4aEbNRWrmyUA3KKWrZr3xACd1aZher9+xBOVbMG7yTw898J2Lf6+Xvf6wFU8VA1q86N+BLGlaHcKSnfomvakYie3XdAGWOTTbjPkRWf2L5p6ZWyMCaZDXjeK/uZjXozzIM9ettQjnwJTK9FVrTkDnsPT5QVqvVYvWmynm7pExcTdugdFBaGFg907EFGxsXOuWG68EOZYTwQlaFnzTxWgKdtXMGXDfxpuE17gv7M08pOzRgDOveD6aAtOggtMXBheny4nUrMMgC4MGUzsL60j73N0ZUdackqEr1nVdeioVCmhvqi0QYk5Gtb5uYUBdcoEUYIr1paUgbzWd+F6JxFv4PAguiZ2wfZ21yYfsAlisDeIoEKrybVFqV1dM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(22082099003)(56012099003)(18002099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E0te78DjyvfCUcZbbS7IsOad4vKnZ3clmeECA/HbjDakSLqwL8pkCUP2Rq1J?=
 =?us-ascii?Q?60r7RTKWwuBsLEK66eKGBAA9h8+2Y9sqv9CE+oxP3gNIqkxVeAG5zr5bmqoR?=
 =?us-ascii?Q?p/1+VqrQP0Ema3575TqwqvkRv19n2dsXTRJcf2BGAmHSjQcopm3rEpyPSZ9m?=
 =?us-ascii?Q?pxGafpo4qauGmlzlnzEsUyjzKmxpGOFlmDa6I7LFIGemYkbe3O7M+FmJ0Vdo?=
 =?us-ascii?Q?vZB8YHkdKMtCqQ5rU3TyCtiNA658S6gQ+1rIa6sGaC9YWwc/dhYLsMyOJQ6L?=
 =?us-ascii?Q?2RRydGFJ7VFnwSkjL+oXLpwSw2DCWcclenVzWPGUGvXbz5Q8B1Ry9gUFGvA6?=
 =?us-ascii?Q?rSX+pZbl0qsR8/cpm1PRW2axKq3ctTOhkM6iDZ798NiReZZyoI0idaOh5rKX?=
 =?us-ascii?Q?I1TXJ8xCQR7EzSoUAExjwidhB5pJcLATYHXzTsTEz7pGW43iFqQb/2sRXHqH?=
 =?us-ascii?Q?SPGeiEbLO16u+rDJ6uoxu9dwbt0/7Iea/WbpqGc6tBeKCNEH2mbbCwtEWXVc?=
 =?us-ascii?Q?utCC0OPcLSbcogKY9H2whaOaDum4Cz2xNPbw8fc9Do4+xoh5p0TPT/hx191i?=
 =?us-ascii?Q?NjQrKCFTiYq1C3jN4xQ4ozJFCmQwNwsEwGngTILOhEA+VEhTiD4j4RSZ0Pdi?=
 =?us-ascii?Q?TChDUe77YBDU8NPzqiHV9bRDebR/siYFVVxfbxPCeYj3rzE+udHqmzEJ/yRp?=
 =?us-ascii?Q?Kmy3u3Ov506NrsaLx0/ucadJ/WbJKgHPifQuBgQl3teWqiLn/qax2JiPtkGN?=
 =?us-ascii?Q?m0qJxbNlYtkSYs2q1etWRG+CkOAjbvHiq4D2Ty+irhzHUfQDuS05094tKYrR?=
 =?us-ascii?Q?CYBud4suU3P2sKvbSBgAicHI6w6+GQkHVjFyPSEIh6rTEm+alu/I//6zIBfC?=
 =?us-ascii?Q?qXMerUGGVkugkEWXJbaMLITBkqoriKraYctZ5kKItDePprGgHx7DxZQp3Pvn?=
 =?us-ascii?Q?0vdA7GL8GbyxOBdmZe2Y5bzv2cJfQWgqMIHVxz0ww2q+ES+MIX9POxp3UBDJ?=
 =?us-ascii?Q?5Ohua95LgvZvdnVyrWN//ZfNrMCaXOFgKemcTterpZ1v9IegflchijHK0Uhy?=
 =?us-ascii?Q?SWiG9Nb96OL+CNl8DMt2Qpq3q55ZEpvf6zxgZ0ZzufXwNACKSbmmIYqMQkz+?=
 =?us-ascii?Q?pkbAn9szYcVw1Ot/yS143vmDdPbM+fYRuqwoxOOgzYB8bq3AqCCkfQeqioyA?=
 =?us-ascii?Q?sMPI8gBxmrL+NjbIdRufDm2NbFyLuOsSW5zYuzI2L47IXuOdSwDe2xhdd4d4?=
 =?us-ascii?Q?vGEgqDdUC2TViQy6mKw47itNLVlRx4JzpsYB8Vn06YQzMIGQjP0O/zQNwci1?=
 =?us-ascii?Q?jtgVLBZZG9E4EHuAwBUu9W0heTDQlnMDU1cUez4sBH6FBHHu/L+hJhm26rqD?=
 =?us-ascii?Q?n8X73bjjffp8ppP3z0uUtB2OHxq9Wny12tS5UUbPMuK9J69eeTkrB/vomIFO?=
 =?us-ascii?Q?ole5JPs+ua6C+VYIk/K2BY/R7zIKxWKJ3LREpIYaItXIoHx97DfEiaDPUv9G?=
 =?us-ascii?Q?tRIxINXQQ7BDN/T8C5XZgrh71Pz3wb18I7d/APH0FOR9qk3wfUEnQxt2ol33?=
 =?us-ascii?Q?9suWA6sUmGYH7B9zUpn+Cq3mhEPVZgtBUpT0bmEfLAuTh71BJTN8hxZre1Ta?=
 =?us-ascii?Q?+hI34T/9x9DY9A/2C5TY9A38S6ak9VubWv67ts+36zKRlHpXtRlK6zNTya/5?=
 =?us-ascii?Q?TJaRBO+xZXnL8+20ZJOhgRDmPGkzWy7DcAWeGNbuZ9EPN4FqA9iV9H4wj1dB?=
 =?us-ascii?Q?jSng7KxQ6w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 638a4d3c-d895-41e3-5322-08deba07cfa4
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 02:46:24.6612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juhje4lG43jV/nuT3s2p0FbU+wlnq/4z23Npa+WVXrKAVx7V++WjlPDNXm8i5iZ3MfTXllis0a6lMuS4tECAMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11707
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

From: Peng Fan <peng.fan@nxp.com>

Add License information for nx_i2c driver.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/i2c/nx_i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/nx_i2c.c b/drivers/i2c/nx_i2c.c
index ab3f1cc30cf..5800e79ab70 100644
--- a/drivers/i2c/nx_i2c.c
+++ b/drivers/i2c/nx_i2c.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0+
+
 #include <errno.h>
 #include <dm.h>
 #include <i2c.h>
-- 
2.51.0

