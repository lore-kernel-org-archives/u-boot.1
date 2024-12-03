Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6093CE77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 217BE89696;
	Wed,  4 Dec 2024 00:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Rkvu+xnb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B95C089689; Wed,  4 Dec 2024 00:06:06 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::728])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94F3D8931C
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lko6owg9slt279nLl4mMvbigkAl9K4s3c+uy4RMm7OOc8Q2Sydd0mnbYOQUW2mY94iVt/IOX36uc6JvhG610svLIsc2K2PJ+49bBmM5Do6pDimxUuq9CCUwZ9wKZFREdnQ4j80pQUBZRxGdWYOMw7xOOak8Wn3synKL79EfJtl7GeRmLl8o035DXUQJrnmGFGpVQnmljg/J3WaagoUxfwq+VPQdyw1Vy+fPsb1+GPuUb/8MBWw3pl7tWp5Pkoi4RqY8SX0KS6Pr7h2Jg1KrZTJJ3cH+pQdXdthUKgjjVptWIy4i1ggGirSRqLW0kq8gAFbPmDmfwWUzHKbVEvqrKlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LZEUbGM1RT6wzMASDIKeCdWBcltU46/hMqIVkx95/s=;
 b=f5Cl5TDJGVyoiBzDc6qX3NZo7/qnJM0E+0ySYeS9IgswQLACfmq1e2U7jYEPewX89A2cxgtXNS+73RQ+QPt1FvgUXcbRLHf2FcQ9Atj8GB5H4jAUIKjZ9N2iarwqVFuVpII4VgZ7/epIR5JrprHwNsqvrnA0PlcvMRwaaFKtGow4iswKC7FQ3HGzn5JdwX8jg9E39ogqUtibjYrNKo+s8ySb8Tc1Rt0MW1bvEAQdJD9iQd12Geq+ZSAvvTANsjlD5/NISw4oGswvnXlImt6S9yYEiEeLg9whj8urd2pFMCIFyTaEAWSc48IE+ppCoxS2Oo/nwBTBQQ+8aeL2XO+uog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LZEUbGM1RT6wzMASDIKeCdWBcltU46/hMqIVkx95/s=;
 b=Rkvu+xnbARRIPVEEMqOAzcrS1Nv82P5RwUjcSzPpCKTxX2qe7ilcxD7/PY8n7phUrEKVJtP4cnI8VP2q91JIiGW8kb22DEwfMdKRtkSAyBHYZw0sz6xtYO0Tv5eGJhWxg5VJCVPccpP7Vw/nMSuZKXiu932bh9QJOJuxiIGY+dGN3NWiR0lAlyIWdOuuQqFNqCDbVgGVOD9cpJSpoWTg1/6ZxbxnWfdd3tea1CSRoJmMH/nAMmGGi98VoQSjNVE3ySQeaz1ML1Yfry3XAvpy+elgDphw8odMYW1EW7+twvI/bD3AlELSGAv+3tlNwxkO3Gcd9jdBZwzT8kIfw94VTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6066.eurprd08.prod.outlook.com (2603:10a6:20b:2d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 23:06:03 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 23:06:03 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND v4 3/3] cmd: mtd: add nand_read_test command support
Date: Wed,  4 Dec 2024 02:05:51 +0300
Message-ID: <20241203230551.2677602-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203230551.2677602-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241203230551.2677602-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AEF.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::31d) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: 628f4e55-89d8-4b04-aca3-08dd13ef0f57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kjm/aqrXOU6e+s0N0GdtNt245GZwKwHh7tKjOYYVCVdyLCrx6PiODC4L5XDt?=
 =?us-ascii?Q?h6GJOqR2ACGZZ2XHehWC1pdN91gOyRnD/ACLkSLvLfy2vClqNJRuOSl6wG/w?=
 =?us-ascii?Q?GR/ftkHY+/5oWVTcbsW+fSh5diVcPg1reZmjrbPoo+YAFMcLZbXhp4C+rrZ3?=
 =?us-ascii?Q?WmLOB3Izt720enKdL0gMFV6pm8IjmOUxsUvMwk0ccNNW4EtWHJqtshfYlVpK?=
 =?us-ascii?Q?wP1g6HVIHA8XPs4v6iITszCxT2IXyzIcP0RB+9PQKvzf1an5dHDZdFa9y5LB?=
 =?us-ascii?Q?A1qCDF5DGtwhO2jbHzsUVMXhBWtC4xZ/Do8au3vxowqNR8IiqmOfMfWhcaUt?=
 =?us-ascii?Q?Hul0i1YK0k5S+qJFGKQDkyxdZfDW4jb4L9d4jUWg2T3ipm1FsiE2MrB7aMfL?=
 =?us-ascii?Q?TFOFvHbrfI5UEUfg4vhJs5S881eI5kYL3duw7CwbwzB/B+eAZJYvAb+Z1Zz8?=
 =?us-ascii?Q?IU/L7+x/j6Xyd5n3miqOTrRjFN9tLIrHOePPXyaEMEjMqOdfEJ4y/peT0AUI?=
 =?us-ascii?Q?83PYNLpsjyYjTdB5FW80wNceiEfdUvmTm+sMVWG4KJSOO4SD54pdCw8iSjZ2?=
 =?us-ascii?Q?nj9mrKM8kNBMBcdp8hvq5kMI8GNkqBvooc/xph950UfGf3RgfPuTRgfSpQQk?=
 =?us-ascii?Q?so8LQZZq+uyLPVwfWFbMU+6nLmXeRoCPMkgKAB9NHYcxMkXOEHFnpnRarY1c?=
 =?us-ascii?Q?bRWhOo3knhqiq6VDSgVVlTm91TvyGtU5qCo2IfGdfZjrk6tIzze/GmYa7t0w?=
 =?us-ascii?Q?T11rp0fHv6T6n08afO7frgFXxuDAMVOl1qr1+fW0caeCV2qrNzeI/YdS8K4y?=
 =?us-ascii?Q?DFyhaWCfWCjx0IDLaoPuDqHSG1v5hHybL2iPmNK/OmVzMikvl9EB4HnKnrM3?=
 =?us-ascii?Q?bLDZ2oxNB9/kELUy8h5Gi3vRHMGDirRfdjWWl60eVwY2IA33fBLQQF5/dT1C?=
 =?us-ascii?Q?Tlgcb1B1janu/PmsItPAvbJnrox062cn4U5KNpKxiwoUnWtvSIGMtBRtHQ2t?=
 =?us-ascii?Q?DcoItquc095ZIM2QiZbQ5z6PDHqar/c5d3PmBrNQH/05P/9MgAP4ud8jrASB?=
 =?us-ascii?Q?K24teEY7Di4U+I5xMNF9C3mlFE+8Wcm8M/q3XdkQru2NSEq/FlhAHoxviQ18?=
 =?us-ascii?Q?Y82ziClbKASZlxGBKccF0iQq8N8L7Z/b5vzC7y+q4wivH2QxK+qTk6LxNEVu?=
 =?us-ascii?Q?ifQWzO+3Hx5L9C7T8jQcGXCThM3jzjmvmiOaVma6sQMe/Chroge72d9xWmXi?=
 =?us-ascii?Q?B/P1WwHmd4F7/ufVrkFoplQX1XBZ+IsguIGH8baxmI3HUL0g6GCDiluzRY7m?=
 =?us-ascii?Q?NI0SgRqy9ikbOuXrwQzf3EScvneDJF9W4LEWVNoQqP3ScncWXfucJLMViS8S?=
 =?us-ascii?Q?ObmE2FI8dKHVl5nDThYLSA5LvYV6Mzy2YiwXWkT450YIXKfC7+Y/z1n5n3+P?=
 =?us-ascii?Q?YWW0Y26bDHI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T3O/7q1SJFPgQxCjRBji4c0m054VC7WdsR8QUBCh3lFKmaeGK85cl4/a55ve?=
 =?us-ascii?Q?EvJ0kLabhIgpoiLpA11VZgNpkweuzoCFDlBVgoRFmPgPaq8tZKvhYohcaHdt?=
 =?us-ascii?Q?RtXwyOcbA2SFnVxNW+W5F8XhTH/Rz/92UL/bid91UyROpf7Ac0FeVdcfmW9Z?=
 =?us-ascii?Q?lkdVr004s37teYDfR7YiQvyiw6rM88/5xZsiVK24CITpZZH67NBJChBmSSNK?=
 =?us-ascii?Q?6ExVqLgBYPgxYiPgvmQCtUy8lBlHdGgjmlLgxQcxJ8evfAcicKPHZYqpT8Ha?=
 =?us-ascii?Q?3zSMuth4dPoiJD6AfVhN8+Ckz53Z/Nk6m/iVEG2UHz0mMK4nVbYybHD0W9RT?=
 =?us-ascii?Q?xAUBneMr23ptdQ/8TcAWKfhXwGB44iCDRd7dcjF0QftQSx9tF7rzAYJNfVfc?=
 =?us-ascii?Q?ZQqkB0Yl6DnViTw7fRupqn0v8ACr0SKu2y8pZpHuXVxpLqEsZGhPZW+xpRWF?=
 =?us-ascii?Q?57J6fBG8+d0/tw9od2ukMpZJhXNt4rVuaDs3030fQ+khHfqtNYDYdRxlUr1N?=
 =?us-ascii?Q?SW8jw0gDjfJYlk3VWWiYBl1OExCHO4ARVgHIP/2upZ22DXULrTbLrG9nv09W?=
 =?us-ascii?Q?JKQY1j656iiy/D3itg8El6FDHNXP1ysziU5RoWYSQOhu+10fHlJkTmcfSO8O?=
 =?us-ascii?Q?yCL1U/iTIqfPHmdFEAVo9pGq5ONj0l53ba7hgoiyZH3e6KKBLOnDOBvTQazD?=
 =?us-ascii?Q?Yc1q9YSinTuaJb/TfyEs8mp2Neny/FIX6iRRcm60aTe/FZ2SxXaO0ja/n4Xf?=
 =?us-ascii?Q?eq5rimAd3e0XRN7Smooc/XHX22WhxDSKohxWSFSpbFHNpwRzql7AXyUufbMX?=
 =?us-ascii?Q?lXSNi67b6GQr09XES4RAa/enpchXWM/czzOHpQiclatZbE8zDahHXAwGUsqj?=
 =?us-ascii?Q?NdrliKntgkU2sV/xzyq+UI+TgyxC70AIK0t1uQJrA6VlxdzGee7WBJL6zFfm?=
 =?us-ascii?Q?jyBpvt6sNGFZSdIgX2DFsbzazY/LvMV0AqAF3LUOjOGihze0p7lsOluMm6FE?=
 =?us-ascii?Q?yyY9OIT/lZa6GMQEVUTq/Db95FminxvGgt18sJ9ZcZu5T+2zuNPsLSgHs635?=
 =?us-ascii?Q?GU3LPHZxq6SHQ0d5xoCHc3Mz2iCAVV8fo94o8iYumhi1BOqgjELMNVgfd+Sa?=
 =?us-ascii?Q?LjALvOOHvn0VDvriGSlMUFF/5Z07KrWjd7aYQhAQF+ux2OdobJ0If8ZnGe7U?=
 =?us-ascii?Q?9Vt8OrWtF+HO03V3WULhfpRC9WNmnH9XOEVnE6aqtXsndRt+wDfp02E6BQMv?=
 =?us-ascii?Q?qghIEy1Sv6Ekew+2BhvOxXl9GgYf3bufc1AA3pMU4kPVJhS0Sytq7eqC975Q?=
 =?us-ascii?Q?GUtTNZpzM0Sl34a3W2b1RLwF5sTnZPkO0TwdypXwmYcPbRZF59dFXwP9ong6?=
 =?us-ascii?Q?NUPVwgegL2chmE+EjCk5VGwXp4Ww1uK3B1nXoD8C8sJ04ZKmAJYpYiGL9pqf?=
 =?us-ascii?Q?iMSnPc7F7Ig2YaObipt9ihmjZT9xJHQ8Rvbw7G5W5WPsyBeonGFo7giHlX64?=
 =?us-ascii?Q?q0jVU3aoynGVl1hCLZxOZZxccDpi1bMDe31GiIaaug6AGI1nHIkJb43kYyNl?=
 =?us-ascii?Q?nVNn6mZXGQBPDANKsHYdOlzOb6MPz8T9ZPr1oaXmzdYXZJXb7FwKDQRZqiYg?=
 =?us-ascii?Q?pWXIkQ9G3BzbpKkVaqDsqis=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 628f4e55-89d8-4b04-aca3-08dd13ef0f57
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 23:06:03.3755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZwv61x3QXQcCViTVNY+yiZo+EqlgQ9YCf0ePtiakLV/BOdkifki1GnTBxqrfKTQzIMHg6ynyBSZgO5udIiwdfMijNk627IwiLvaLNclcVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6066
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

This patch implements read-only test of nand flash devices.

Test reads blocks of NAND flash in normal and raw modes and compares
results. The following statuses can be returned for a block:
 * non-ecc reading failed,
 * ecc reading failed,
 * block is bad,
 * bitflips is above maximum,
 * actual number of biflips above reported one,
 * bitflips reached it maximum value,
 * block is ok.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig |  16 +++++
 cmd/mtd.c   | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 213 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 778b6dca055..3c40be58d3e 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1482,6 +1482,22 @@ config CMD_MTD_NAND_WRITE_TEST
 
 	  WARNING: This test will destroy any data on blocks being tested.
 
+config CMD_MTD_NAND_READ_TEST
+	bool "mtd nand_read_test"
+	depends on CMD_MTD
+	help
+	  MTD nand_read_test command support.
+
+	  Reads blocks of NAND flash in normal and raw modes and compares results.
+	  The following statuses can be returned for a block:
+	    * non-ecc reading failed,
+	    * ecc reading failed,
+	    * block is bad,
+	    * bitflips is above maximum,
+	    * actual number of biflips above reported one,
+	    * bitflips reached it maximum value,
+	    * block is ok.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index bcff020bfd3..857da088843 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -940,6 +940,195 @@ out_put_mtd:
 }
 #endif
 
+#ifdef CONFIG_CMD_MTD_NAND_READ_TEST
+enum nand_read_status {
+	NAND_READ_STATUS_UNKNOWN = 0,
+	NAND_READ_STATUS_NONECC_READ_FAIL,
+	NAND_READ_STATUS_ECC_READ_FAIL,
+	NAND_READ_STATUS_BAD_BLOCK,
+	NAND_READ_STATUS_BITFLIP_ABOVE_MAX,
+	NAND_READ_STATUS_BITFLIP_MISMATCH,
+	NAND_READ_STATUS_BITFLIP_MAX,
+	NAND_READ_STATUS_OK,
+};
+
+static enum nand_read_status nand_read_block_check(struct mtd_info *mtd,
+						   loff_t off, size_t blocksize)
+{
+	struct mtd_oob_ops	ops = {};
+	u_char			*buf;
+	int			i, d, ret, len, pos, cnt, max;
+
+	if (blocksize % mtd->writesize != 0) {
+		printf("\r  block at 0x%llx: bad block size\n", off);
+		return NAND_READ_STATUS_UNKNOWN;
+	}
+
+	buf = malloc_cache_aligned(2 * blocksize);
+	if (buf == NULL) {
+		printf("\r  block at 0x%llx: can't allocate memory\n", off);
+		return NAND_READ_STATUS_UNKNOWN;
+	}
+
+	ops.mode = MTD_OPS_RAW;
+	ops.len = blocksize;
+	ops.datbuf = buf;
+	ops.ooblen = 0;
+	ops.oobbuf = NULL;
+
+	if (mtd->_read_oob)
+		ret = mtd->_read_oob(mtd, off, &ops);
+	else
+		ret = mtd->_read(mtd, off, ops.len, &ops.retlen, ops.datbuf);
+
+	if (ret != 0) {
+		free(buf);
+		printf("\r  block at 0x%llx: non-ecc reading error %d\n",
+		       off, ret);
+		return NAND_READ_STATUS_NONECC_READ_FAIL;
+	}
+
+	ops.mode = MTD_OPS_AUTO_OOB;
+	ops.datbuf = buf + blocksize;
+
+	if (mtd->_read_oob)
+		ret = mtd->_read_oob(mtd, off, &ops);
+	else
+		ret = mtd->_read(mtd, off, ops.len, &ops.retlen, ops.datbuf);
+
+	if (ret == -EBADMSG) {
+		free(buf);
+		printf("\r  block at 0x%llx: bad block\n", off);
+		return NAND_READ_STATUS_BAD_BLOCK;
+	}
+
+	if (ret < 0) {
+		free(buf);
+		printf("\r  block at 0x%llx: ecc reading error %d\n", off, ret);
+		return NAND_READ_STATUS_ECC_READ_FAIL;
+	}
+
+	if (mtd->ecc_strength == 0) {
+		free(buf);
+		return NAND_READ_STATUS_OK;
+	}
+
+	if (ret > mtd->ecc_strength) {
+		free(buf);
+		printf("\r  block at 0x%llx: returned bit-flips value %d "
+		       "is above maximum value %d\n",
+		       off, ret, mtd->ecc_strength);
+		return NAND_READ_STATUS_BITFLIP_ABOVE_MAX;
+	}
+
+	max = 0;
+	pos = 0;
+	len = blocksize;
+	while (len > 0) {
+		cnt = 0;
+		for (i = 0; i < mtd->ecc_step_size; i++) {
+			d = buf[pos + i] ^ buf[blocksize + pos + i];
+			if (d == 0)
+				continue;
+
+			while (d > 0) {
+				d &= (d - 1);
+				cnt++;
+			}
+		}
+		if (cnt > max)
+			max = cnt;
+
+		len -= mtd->ecc_step_size;
+		pos += mtd->ecc_step_size;
+	}
+
+	free(buf);
+
+	if (max > ret) {
+		printf("\r  block at 0x%llx: bitflip mismatch, "
+		       "read %d but actual %d\n", off, ret, max);
+		return NAND_READ_STATUS_BITFLIP_MISMATCH;
+	}
+
+	if (ret == mtd->ecc_strength) {
+		printf("\r  block at 0x%llx: max bitflip reached, "
+		       "block is unreliable\n", off);
+		return NAND_READ_STATUS_BITFLIP_MAX;
+	}
+
+	return NAND_READ_STATUS_OK;
+}
+
+static int do_mtd_nand_read_test(struct cmd_tbl *cmdtp, int flag, int argc,
+				 char *const argv[])
+{
+	struct mtd_info		*mtd;
+	u64			off, blocks;
+	int			stat[NAND_READ_STATUS_OK + 1];
+	enum nand_read_status	ret;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	if (!mtd_can_have_bb(mtd)) {
+		printf("Only NAND-based devices can be checked\n");
+		goto out_put_mtd;
+	}
+
+	blocks = mtd->size;
+	do_div(blocks, mtd->erasesize);
+
+	printf("ECC strength:     %d\n",   mtd->ecc_strength);
+	printf("ECC step size:    %d\n",   mtd->ecc_step_size);
+	printf("Erase block size: 0x%x\n", mtd->erasesize);
+	printf("Total blocks:     %lld\n", blocks);
+
+	printf("\nworking...\n");
+	memset(stat, 0, sizeof(stat));
+	for (off = 0; off < mtd->size; off += mtd->erasesize) {
+		ret = nand_read_block_check(mtd, off, mtd->erasesize);
+		stat[ret]++;
+
+		switch (ret) {
+		case NAND_READ_STATUS_BAD_BLOCK:
+		case NAND_READ_STATUS_BITFLIP_MAX:
+			if (!mtd_block_isbad(mtd, off))
+				printf("\r  block at 0x%llx: should be marked "
+				       "as BAD\n", off);
+			break;
+
+		case NAND_READ_STATUS_OK:
+			if (mtd_block_isbad(mtd, off))
+				printf("\r  block at 0x%llx: marked as BAD, but "
+				       "probably is GOOD\n", off);
+			break;
+
+		default:
+			break;
+		}
+	}
+
+out_put_mtd:
+	put_mtd_device(mtd);
+	printf("\n");
+	printf("results:\n");
+	printf("  Good blocks:            %d\n", stat[NAND_READ_STATUS_OK]);
+	printf("  Physically bad blocks:  %d\n", stat[NAND_READ_STATUS_BAD_BLOCK]);
+	printf("  Unreliable blocks:      %d\n", stat[NAND_READ_STATUS_BITFLIP_MAX]);
+	printf("  Non checked blocks:     %d\n", stat[NAND_READ_STATUS_UNKNOWN]);
+	printf("  Failed to check blocks: %d\n", stat[NAND_READ_STATUS_NONECC_READ_FAIL] +
+						 stat[NAND_READ_STATUS_ECC_READ_FAIL]);
+	printf("  Suspictious blocks:     %d\n", stat[NAND_READ_STATUS_BITFLIP_ABOVE_MAX] +
+						 stat[NAND_READ_STATUS_BITFLIP_MISMATCH]);
+	return CMD_RET_SUCCESS;
+}
+#endif
+
 static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -1028,6 +1217,9 @@ U_BOOT_LONGHELP(mtd,
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
 	"mtd nand_write_test                   <name>        [<off> [<size>]]\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_READ_TEST)
+	"mtd nand_read_test                    <name>\n"
 #endif
 	"\n"
 	"With:\n"
@@ -1070,6 +1262,11 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 		U_BOOT_SUBCMD_MKENT_COMPLETE(nand_write_test, 4, 0,
 					     do_nand_write_test,
 					     mtd_name_complete),
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_READ_TEST)
+		U_BOOT_SUBCMD_MKENT_COMPLETE(nand_read_test, 2, 0,
+					     do_mtd_nand_read_test,
+					     mtd_name_complete),
 #endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.45.2

