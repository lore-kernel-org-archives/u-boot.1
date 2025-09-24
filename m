Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8B1CAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 04:21:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13671834D4;
	Wed, 24 Sep 2025 06:20:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="cYJfGMWa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D644833ED; Wed, 24 Sep 2025 06:20:53 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D954D80B9B
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 06:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2V0JYZm0cT7nPaX37N9G8YpO7g/u+OJfKv8eKzVmLYEAaCYlmbaQYwf9JKcVzfTUlAWatSvOaZt/zh+vtVg2M3uvQDzouva/F5aR4JzF+3ZBQmLgMAM+3SugxR7n/B9anEytTDB7jqSsdBIph6QEkWAtifUDq2tI5uYKGTPQiYjGq08SxoVJ6E0XeY6UB69kXSCoj3XqFQd7gbHGF3h34OnI8s4Vx/Viv9CJ8Zxxk0LKvAoH5LiCtsv+g4Px8eegrIJuD40fWXeEIPqH/5iKvh12qor3A1mFnDmaZIEG+pTH16ABlJRnl1hmsSstl4dNmbzpuTlpXbGGskO6zHdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drrSf4GG1G9/0lqfFC75sgWurUt43oAuwu+WPVeAhRA=;
 b=hpJUzTtAraeo3d+krHAzvZa8Ufl1lmGI9zHye1Wwerk9BA2Z8aPwqPaZj8JbyZnDKrys13Bx98JmqVvf1xyPmrZl4KgKzzuz/1x7nDUhS9hvUPZULvmo+jgnTjNdkEn2I56/45G8W7JkytEvkyw6PmJZX39MvL7rs1XCh9h/xp2MqUOutDRb+KXgoOK0YYUVqVnSxmZO67WAYlKYDdIrilb0A8e6wOKYoMQ+p83/V3X51u7M7DE1At1wSDr6Y1WkLaXipC/ufoliFAHMt0wdq21l983se9M7fNnxKDFYyf2B8gfX4OKFUqrq5yjrMTc+IS9yDbft+ngyTvfVoINTjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drrSf4GG1G9/0lqfFC75sgWurUt43oAuwu+WPVeAhRA=;
 b=cYJfGMWaMoVnIgUTamlN8agmOkEvSw7HZ/MrSwpsgCKLtGD++WRYIU7oRiDZkE9AYYBrPR5QzN2P7kFpkyhRnZElypYJbRxRu3rlyiGI3OVk3AVOmJ6c7tLiP4wWunOWAFu72yV7cyVtwfnhhWGlGzJl8bYI3T11vS4AOWzwdJe2ox143WrA+sgN2ygLI8V+t6W+kjMq0fBAarHx0AjZ/DujhvHyZHHy/be3s1Tnl83nfc9QbB5ECclcnVe+OS1WWEmeP8P2OT+enQnMRVhhM6hSYMxvpD/9O8+NF6jE6XPBemV0QWp2krVxkho95CgJ48P6Gvaqc2/F/Ebj8t21Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB7552.eurprd08.prod.outlook.com (2603:10a6:102:24f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 04:20:46 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 04:20:46 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v2 3/3] cmd: mtd: add nand_read_test command support
Date: Wed, 24 Sep 2025 07:20:33 +0300
Message-ID: <20250924042033.1873771-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924042033.1873771-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250924042033.1873771-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: e71f3758-b539-4a9c-54b2-08ddfb21bc2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RUb1Awm1K8I81pZ978JNn8GTrbLUhlSTOlSDhqkg04c5PVFvf8SS7VBPwGMP?=
 =?us-ascii?Q?B0nu5ZF3fwKo9avVPHECdoZx3ec1vCxhXbpLxoKPCx5clZQA+jMdwOsZuq/b?=
 =?us-ascii?Q?MvYIgQsmj0zxGmezrADVtqBb9YTNrOP4KB1s2055rQlxCEc7wPxEVUCKqECy?=
 =?us-ascii?Q?sL8FFO/6naPB4ThiYnKpM6+WrCM9IeXtVqyEUoD5FbZ+nWjp3ll3PXqlXc9g?=
 =?us-ascii?Q?qxrAEjs6u9H/clS/IELDDpnDy6GoB1upWZsWA3WcQKI/dJoAdwIglpYCHW/3?=
 =?us-ascii?Q?f7DO1U/GEdWfFwnEm0nOXwQhHCQ/kvPBqUxaFqfAXcCL31Hj81HhWQ+hy7xP?=
 =?us-ascii?Q?1ChxB2ksJ0lSnmPw4tPvuhnQ1vNiZ38K4ZZqRaKuOVlGtNwoPuyHKCqc0t8B?=
 =?us-ascii?Q?Rawic2T6lappM7QPXMEa9AkoEjwKHKkkA+sSpf49m2TFD3UhweHIO1PLOtRe?=
 =?us-ascii?Q?Qb+mj6Dlr68jvL/q2zTXH4kpaneZX5qio/4AwXgLwTF2ugTCNWbr9d1XBVSV?=
 =?us-ascii?Q?g/g7N1blz427rr0v12VRVFxRDSwUrduV62y8CgWvd3kp+XmTAIBqeaOdV9hI?=
 =?us-ascii?Q?drkIh8NdHV7JNS/QajnWa0D0dX/sfTDME6K9ZrX3KFNavZRTxZaO7c3I1w3k?=
 =?us-ascii?Q?nyxFwfYpz6Bii1/fxBx5QUtOX3nfp5dBtr3UI26E1Ff2hPk/HEGw5/e+Lh44?=
 =?us-ascii?Q?RB0+9RljzXkv3chf2bP9kXPV9UXUQsPHuN2zCMizt3cGYShotC7uwjQiWYlR?=
 =?us-ascii?Q?iD72+ticksOMh4aCHODXe9HQBqldir0MJNtY2NtJ3iiUv6V3e0E8ettqIlzw?=
 =?us-ascii?Q?SIZiy5yKgDZCT+Bpl+lMFecbNjaKfKu5pxZHlAK/CIrBtRIOTICNFyATiwlR?=
 =?us-ascii?Q?EdD0A6Ina1MRm4yju46XhkQ+6yb1eEFcORpcBK2uSUrc40PPRljE+8J97OmP?=
 =?us-ascii?Q?yNT1A6xzPeIOFHNR7iSanqXewBx8t24hIYiCndAGyRVO2tKd/NsGhA5yvRsB?=
 =?us-ascii?Q?y/Qka77wrhEoc0lmXdK3jbeWjYyJbKHZlhf3ycWEhoOXBeBuxbqsSzZTaKa6?=
 =?us-ascii?Q?S5QkHpPOSdz1MWiLRh9JWlea9gdtFJlvWHcakwsSjt/DXqhWhELKievt7cAk?=
 =?us-ascii?Q?F3ApWEMnvm9LQSx+PMXF0EJyxv3t8GfsdgJR7akdfG3m1T7ieHdcPBIkGmVw?=
 =?us-ascii?Q?rXyKLgiX2JsUl+P+f+wmP4oGIhlQI1IpI/40jwFdDMboTD2JdwaaKIlLO30/?=
 =?us-ascii?Q?Z7RwKxYggiDlWKEc/ovj3qyeRqktsR4QxkixGs4+JBNs4flOeHq81OQyZQg+?=
 =?us-ascii?Q?B34dVqlYAYUhZ32J9sT/PGRPxabDbeoaT4N19YdNDWlCGwNYBY9s4Qnfk0mL?=
 =?us-ascii?Q?f9vTb/qF7pdUWTENqHdr34x4E5h/+KdaDpZiYrYSuPJz6qP7KFBR+HT2LK1U?=
 =?us-ascii?Q?/hlvS9REQ+XLvg+J4pKclS52EwVRJ04q/Fe8tRBvYQP0NzKiFOsCfi1SlZ8T?=
 =?us-ascii?Q?u9vHlKhWBlSeUK8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HKuWJTfZNaoXpHHhqJ5rk49UD+AKo10DSPCdXyhhipcjsLyPEEY4XuDWLB2N?=
 =?us-ascii?Q?v7NuNzk1m1GsTtq98Ddt8Ngt1Wq0v0pkwLN6Udyc1XB+XdEL87lWLFL3KbMZ?=
 =?us-ascii?Q?+j8HZi0AVVxVWAByVq4c1fqqx87XGvGKjva4IqEVLSnp/ZMnD+/qKf0sdTT/?=
 =?us-ascii?Q?E5YejuJPS4oTXsV2xj5FjIT/SXzTjxn0iq3lnW46EapC1F8IirlmPmUfACgA?=
 =?us-ascii?Q?jyVPQPFLABOfW36AmigLWGMIXadL9YZmMQ9GMs/j3V5CpYxj1Ah9FuZMh0ko?=
 =?us-ascii?Q?eMvNCxS3O+Fvc8bY5WqV7BofT6scd3TXviVl/kYSTEpe36lcRHejpoKzGEpe?=
 =?us-ascii?Q?ERa9EPKMn2ydGQ0qZB2TN8lVzNbDk4+zRHEhpHAcULukTmfhxNH4oz3aFFqa?=
 =?us-ascii?Q?CrHz+t7Y4bOzSI7sSdZtN0rJX+FiJc3EQlkYtPqxfDRWN2cZTGKT5a3bu+Bk?=
 =?us-ascii?Q?ks1M3cyu1D/jTcZncift72Ditvnb/1QXSScOg09xMJ6w52qk3dWwQgiTD8MT?=
 =?us-ascii?Q?9b6/lqMYMDhBRdv9Po2iUoY9xNKYKCskvz1VJmY7y4HsDrsxu95gUoCnWhP3?=
 =?us-ascii?Q?usC6fbwWF7r3Qz3emhskV7Rj0eJ4pxZyaqMXmXqB948Y5gL8jlzYpHQnRUzx?=
 =?us-ascii?Q?tDxza5EoQDIKk8+b3QOMfJr/NJWjybhyVJPLfSkG4RqCrx+Y4FkEMFldPygR?=
 =?us-ascii?Q?GaPgmdsDT3BmEXKamj0tLuMY0kKvrHX82aU57HCvgvJ/IFNbalq/k6Ww+3/4?=
 =?us-ascii?Q?V0B1peZ/xLNQ/KwqCbNZHStGZo560dQVjOjzhQn4XnDu8i041XLBVqQx9O0y?=
 =?us-ascii?Q?bhRP1QaNInb2T5e1bkV+3MnQ0byo4j8Z4v3cNFNYnr07TC5g2LsjszXdnBkH?=
 =?us-ascii?Q?JTyRz9spgP3+p7q1RWJlIwLGKln64qkGH7QnTf3YGMP//WMPjqaHzso659yR?=
 =?us-ascii?Q?ODAFTNt5Scye/Bzv6toGJP7hF2Z7t1smgttQo8buL5LwKy0tQmKjEeiD0+11?=
 =?us-ascii?Q?AuCbYPgx9UPvAcqmYJyP4kuvosyPUSK7iNMXCz3Ypk/cu4imomCHMkIG/wLh?=
 =?us-ascii?Q?VjtTRAyh2TVUvwmsfQqlIBG3V7X65AHRzNGY7aburJ7Qjmy1jv6Q49IYT2Mt?=
 =?us-ascii?Q?g1P7ec6KdjtADR9iBzloaLBmKCUm4Yj+OlynGECUPjliZITjXIC9gGT1Atue?=
 =?us-ascii?Q?xKlsIdrTdDcWuB3MzHSCsBIAJ6OOd3weivSWAurd+Lj1GJrVGDbhfTgDKpEq?=
 =?us-ascii?Q?CRLy4z/40fhujpOT08crR2QNEk/SK+vfTXs/iGWkPwuB1BoZ7bdgaGCqv8qo?=
 =?us-ascii?Q?/cn8fUKbmetpLCZakuOl9OsAQqMzW9afRcb4pG289EcRNmzZS+1F/R3RWQLR?=
 =?us-ascii?Q?cPCEMaxWxC4l0OjAW2CqTYmlihmbGismpxOkFSWzSQLpEYX6trAUdnjwtzSo?=
 =?us-ascii?Q?FWtwO4Iyj+Esn7yB/O197Ms7j0/k+nazzGyO/oUJSjkMAPpsVLUeEE2gLYcT?=
 =?us-ascii?Q?Qi7/KNxDtsm5Ae2IibIBAo0bQOThdbxIt77Ld0FTPSU8tDe+ZFY+pqmW34fw?=
 =?us-ascii?Q?F8Wy5ALDpSG7BXuFUCfalQI7dZlJokutDxD3juGpiIEraekYxsLclUgUmQk+?=
 =?us-ascii?Q?AdB4eQvKd6vQnjU2i13au/g=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e71f3758-b539-4a9c-54b2-08ddfb21bc2c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 04:20:46.7927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSHOFujNawVePlYrUShoITY3M+1zokLcReovQQ90ZLr5yMSk1uCViTm82k94qf+Roml5seK1X4pocuv1MeWTPCvITpVs9QlU/nDvjFXIe48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7552
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
 * bitflips above threshold,
 * block is ok.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig |  16 +++++
 cmd/mtd.c   | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 218 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index cd1a664f34f..21d6db57628 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1533,6 +1533,22 @@ config CMD_MTD_NAND_WRITE_TEST
 
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
index 4d69c7b4915..689d8d11655 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -951,6 +951,200 @@ out_put_mtd:
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
+	NAND_READ_STATUS_UNRELIABLE,
+	NAND_READ_STATUS_OK,
+};
+
+/* test_buf MUST be not smaller than 2 * blocksize bytes */
+static enum nand_read_status nand_read_block_check(struct mtd_info *mtd,
+						   loff_t off,
+						   size_t blocksize,
+						   u_char *test_buf)
+{
+	struct mtd_oob_ops ops = {
+		.mode   = MTD_OPS_RAW,
+		.len    = blocksize,
+		.datbuf = test_buf,
+	};
+	int i, d, ret, len, pos, cnt, max;
+
+	if (blocksize % mtd->writesize != 0) {
+		printf("\r  block at 0x%llx: bad block size\n", off);
+		return NAND_READ_STATUS_UNKNOWN;
+	}
+
+	ret = mtd->_read_oob(mtd, off, &ops);
+	if (ret < 0) {
+		printf("\r  block at 0x%llx: non-ecc reading error %d\n",
+		       off, ret);
+		return NAND_READ_STATUS_NONECC_READ_FAIL;
+	}
+
+	ops.mode = MTD_OPS_PLACE_OOB;
+	ops.datbuf = test_buf + blocksize;
+
+	ret = mtd->_read_oob(mtd, off, &ops);
+	if (ret == -EBADMSG) {
+		printf("\r  block at 0x%llx: bad block\n", off);
+		return NAND_READ_STATUS_BAD_BLOCK;
+	}
+
+	if (ret < 0) {
+		printf("\r  block at 0x%llx: ecc reading error %d\n", off, ret);
+		return NAND_READ_STATUS_ECC_READ_FAIL;
+	}
+
+	if (mtd->ecc_strength == 0)
+		return NAND_READ_STATUS_OK;
+
+	if (ret > mtd->ecc_strength) {
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
+			d = test_buf[pos + i] ^ test_buf[blocksize + pos + i];
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
+	if (ret >= mtd->bitflip_threshold) {
+		printf("\r  block at 0x%llx: bitflip threshold reached, "
+		       "block is unreliable\n", off);
+		return NAND_READ_STATUS_UNRELIABLE;
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
+	u_char			*buf;
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
+		goto test_error;
+	}
+
+	if (!mtd->_read_oob) {
+		printf("RAW reading is not supported\n");
+		goto test_error;
+	}
+
+	buf = malloc_cache_aligned(2 * mtd->erasesize);
+	if (!buf) {
+		printf("Can't allocate memory for the test\n");
+		goto test_error;
+	}
+
+	blocks = mtd->size;
+	do_div(blocks, mtd->erasesize);
+
+	printf("ECC strength:     %d\n",   mtd->ecc_strength);
+	printf("ECC theshold:     %d\n",   mtd->bitflip_threshold);
+	printf("ECC step size:    %d\n",   mtd->ecc_step_size);
+	printf("Erase block size: 0x%x\n", mtd->erasesize);
+	printf("Total blocks:     %lld\n", blocks);
+
+	printf("\nworking...\n");
+	memset(stat, 0, sizeof(stat));
+	for (off = 0; off < mtd->size; off += mtd->erasesize) {
+		ret = nand_read_block_check(mtd, off, mtd->erasesize, buf);
+		stat[ret]++;
+
+		switch (ret) {
+		case NAND_READ_STATUS_BAD_BLOCK:
+		case NAND_READ_STATUS_BITFLIP_MAX:
+		case NAND_READ_STATUS_UNRELIABLE:
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
+	free(buf);
+
+	put_mtd_device(mtd);
+	printf("\n");
+	printf("results:\n");
+	printf("  Good blocks:            %d\n", stat[NAND_READ_STATUS_OK]);
+	printf("  Physically bad blocks:  %d\n", stat[NAND_READ_STATUS_BAD_BLOCK]);
+	printf("  Unreliable blocks:      %d\n", stat[NAND_READ_STATUS_BITFLIP_MAX] +
+						 stat[NAND_READ_STATUS_UNRELIABLE]);
+	printf("  Non checked blocks:     %d\n", stat[NAND_READ_STATUS_UNKNOWN]);
+	printf("  Failed to check blocks: %d\n", stat[NAND_READ_STATUS_NONECC_READ_FAIL] +
+						 stat[NAND_READ_STATUS_ECC_READ_FAIL]);
+	printf("  Suspictious blocks:     %d\n", stat[NAND_READ_STATUS_BITFLIP_ABOVE_MAX] +
+						 stat[NAND_READ_STATUS_BITFLIP_MISMATCH]);
+	return CMD_RET_SUCCESS;
+
+test_error:
+	put_mtd_device(mtd);
+	return CMD_RET_FAILURE;
+}
+#endif
+
 static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -1039,6 +1233,9 @@ U_BOOT_LONGHELP(mtd,
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
 	"mtd nand_write_test                   <name>        [<off> [<size>]]\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_READ_TEST)
+	"mtd nand_read_test                    <name>\n"
 #endif
 	"\n"
 	"With:\n"
@@ -1081,6 +1278,11 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
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
2.51.0

