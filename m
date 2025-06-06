Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693BEC61CE7
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 20:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2260E82AE1;
	Fri,  6 Jun 2025 22:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="RNYUYGr4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E42982145; Fri,  6 Jun 2025 22:17:40 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C83882145
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 22:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zne0vujjzoChshP22sHXLzooWpCkXONuYtsibm7TwiaGiwfcMYziPovIVCQlV7CxLwoHQckSpeHZar+IZlwKh2f30P+kFhKR/E8w40KHnmD+wqCTp2t7TrfggvHDeV0jJPt81sjMlG9IXWEQaYrROOjg+lAM/dgDh022AdOMXp5fRvttSc9THEsrGmvT8pyHdnd4m3p2y1Tzdb/IR5KY1t2VXK5RdLeFqnSAJ4eroQA8MMFMiaxRyoNfz8SX1Ym8/hasvNgI60JbmxJyVS3lvEsc5IcsoHnslOzBPUTG5k0VFVG8fz0zOo8hNW4lmF8GD4C9WYbYAqrQmvvyCImoSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6e4YGeKhkPDIlj/j9zE2U2MjbXT9/EK0PEN5KDo9Hg=;
 b=FndIZlnhV45Wh4hhKgs2DBCBsktLOyG4m2ZJ6wxoyS/OL83DN2Jw+vhfKwcD8GmVTI2vN3uVZBUtQBKIAW1V3UuoQNurvI8w0iFO+GTfK/8Hs/nmaZ47RW6GMw4KC9u0pf4WIzKiV4XNagldJX4pN9GkWIz+25Wo+MfeABjkKtv+2ycV5hPCDdt5AofWacLA481bMwcMl9jWAf11DN8bPiJo8XEkFCwhPCmBIW+shMwLYxRTXAk+I4ADBkq8rvfeau2duD31JQRg/sqRhPYxGdF/X/7XGeq4zuftmDM8AOTXohhN2B/aJlhM7/lZHgmcxJux+Kg2zH52zw3TgOiWMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6e4YGeKhkPDIlj/j9zE2U2MjbXT9/EK0PEN5KDo9Hg=;
 b=RNYUYGr4F5/Ppo/viKpwqlPlGsM+3FjsfmNrTsKNB0QYP9Ivfzu+BGdoUb5XvPOZvDXV4PIsVmyE3EOU6enG/uSL4I7GBt3Q5aYAhglBX9E0IQYuQaLt1KyFa7/YDKpm+6EUjP42Ksx5FLbF3Y+2nOXCxjwhFXmTBxYVGlEzAxKnvwPNCTKCBapQAX+Gg2Eemp5HVFW3KhX70+QGYMP1sV/ObqH+lvb23giUg2oASdupsFCKwTWaT/eiYm7GdkJiQfK85fds0g5bmbFQ+2elEbDpvVG7VFxBuETt+bsJ6RUPscipMAbEzRz/sYsCsvykaQiVpSsGW6oBpYldSXMTnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 20:17:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 20:17:36 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 1/3] drivers/net/airoha_eth: add missing terminator for
 compatible devices list
Date: Fri,  6 Jun 2025 23:17:26 +0300
Message-ID: <20250606201728.462664-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250606201728.462664-1-mikhail.kshevetskiy@iopsys.eu>
References: <6843478d.050a0220.6e23a.5ec5@mx.google.com>
 <20250606201728.462664-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM7PR08MB5399:EE_
X-MS-Office365-Filtering-Correlation-Id: 810158fa-ede8-4186-a2e4-08dda5372d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+L7DKB+tJHSYEg4ZgS7Pn2fHggSjiArfLak1Zt10er4U71OiNUXL1rZvfeWh?=
 =?us-ascii?Q?jBvYlwg/VgzqGd+3H2ivFvkaYBIYRs/UMyrZd4FGPXeulITO8vo98d0nckH/?=
 =?us-ascii?Q?JSIiIHESf2bsUKe5wDPMj4uJ3bzqvsL5ERKEbGzkp3xnk9jlhtFvP+vZVYx/?=
 =?us-ascii?Q?1Bm4mfGMsswPmk/0tBIz+A8kgPCUc4i1KwJdF1x4l5mjB3ACtuG/b4TMdnHp?=
 =?us-ascii?Q?0XCiROGkpahRBZbSLH/seolxhIiWWh1RzVeJXZeDd5y45c/FtohOcLC2jnEx?=
 =?us-ascii?Q?2FNXqR3B7xTz6W090HY9DPT7MceXnJb3svpm6ErzN2s+onYH3dOI10aZqMwD?=
 =?us-ascii?Q?jxS13aOdg/wlbRlPei5u69biV7JDNn6J5H6OezXhhdk3qP8RqsOLdPREgD3q?=
 =?us-ascii?Q?pbIPjBi2mxF9sa5IOhayqVL456CkHWTt0gZLQwNS9VK30OtUzv1ivM8vN2mn?=
 =?us-ascii?Q?1Q7xA967Rou/4GLMXduL+WwsKjEtjPrk65F5bD+a67jknQO1yuWdTtaPHmHh?=
 =?us-ascii?Q?djmx4tFfUNyiWKC8CgxQj2d49BvN5/ujMgre/7cwdscd1YjlfY8dPhfR3lXf?=
 =?us-ascii?Q?cr4i75ICLF0Bw68AXV0ELx97I90HxlhL/+zZSSzw7c37rJXZ0z9lQ57Bs5JA?=
 =?us-ascii?Q?vG4dP0pxnulDtLn6oxehONAQhZndvYxZt+RkAN8DsWvzBIu9yr/bwqUpIRxf?=
 =?us-ascii?Q?wUckR1tYQJ29mYrC2mNKn5YUlBFZ28+QcNrzUUCeRdSa9qnJuYEsYY+nnsXQ?=
 =?us-ascii?Q?Koobet3YQCUgOVF7wiaW6MvTeFH4jDgIyeu9RsfzyJDohJim40kvNKTFwfNM?=
 =?us-ascii?Q?4ALVT9dZE4GoL15oqs85bEFR/i8yJQmzBsLLD50JA7x/veCJjWMTIODgo0Jg?=
 =?us-ascii?Q?0KRO/eiXfvWtkCHBArDMEZHMUFc8w7+/UdwRwwfKWGGmvoo1jKLRmtPGCjfv?=
 =?us-ascii?Q?rs0yiixvpBS6LaBvRNqK4mUI+B7IrUqjcLPXnvNTQOWXymvQ9WK9djJYo3bW?=
 =?us-ascii?Q?xb93++0tjPU4PJqldmutSHuJIijOMkKE5dUc4pgvX74YRFrjorieSyAKCwLk?=
 =?us-ascii?Q?51QxPe65TKibk/LYI/sAabVkscH5wMSkl/prADhdNoN80sQOFoB9huZl0MHM?=
 =?us-ascii?Q?fDRMqwacRT8k1m3wfbhOCerhx+spYXTj8zUByCo9KV1Zuf4wcdnJV7HyGHI5?=
 =?us-ascii?Q?oK9lnNX1TOaskiy6I5QYLf6tLitOe6kInyCQFrPDwJEC0LUSiMO6gbA5uUi/?=
 =?us-ascii?Q?rZOpMt14bNUQOPfPtckyuvxlyr3e+LOLLPMI9iVQB8MzVWJ/utrg+m6eZG5Z?=
 =?us-ascii?Q?l3XkxqqdQvzCSwS1m75do05zvEqcfqtkUyrIs1vOMC2/y8uSW2HpyfdybKvn?=
 =?us-ascii?Q?DYC0w/+q4Xw1ai8Dj2dOoalDlFf+l0PoKEs+FHrlWC/RsWgUehJJ9axfbdw6?=
 =?us-ascii?Q?tJbQR4wZggBYkUr7Mn+Ho9MinjbOkqZWIpXvRZ73QkL7LsnOy/WHsQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ATYkplFgOghiB6GRrJdIRNF6sQR7S4CfMBFrm54BL8nWR09h+8f3JYf5Dj7l?=
 =?us-ascii?Q?/AIXY6gme1aGa8BLnUZdsARu3u9YHF/RzGxaB+OPgJ8NjygSev/HgSbizDQz?=
 =?us-ascii?Q?qJY5fB1406g1WDQJo8Y8405xeNWRwokbfa3MBQfYE8WSF+jtyjv16+JCjzv/?=
 =?us-ascii?Q?8PeHJOI9JXHAbf+jRnj3pGPNAhHq9CU6DO7llDifOeRNA9yKDLL/YlaGyK4/?=
 =?us-ascii?Q?DMmgYELkvu976ED422//nxYlOPUVEeBBOKlbGyWBTdT4FL4bD2fNnxt3yDmm?=
 =?us-ascii?Q?9qlcAfe9Hqy6j91HWZidf19rIHvE8g9dLps/QWty232hUfvabHmPUK+o9C11?=
 =?us-ascii?Q?40hVGYsJwYqZKAg/QocNnFBiG2hjQSEdoCpB/aO8GTV8sd6dEc/Szl5tr273?=
 =?us-ascii?Q?XaNyYAkfP5VUkST3KSmvgBrGfj3glu5i+JTcYGw+hu25xwEnnOAb97rr74KT?=
 =?us-ascii?Q?qfIeNTdtvW/Hpz9VAed955IzpDo0bkXT4A1F2MBnaM/HPM5pA9M2pTdReT9S?=
 =?us-ascii?Q?I0r0DWV2RNaO8GBF6VEBNHt0ooPhP5ENuf1SsBxHvuBWarvXePPyJbQnsXhs?=
 =?us-ascii?Q?wY92do6yDb6WBTMRPcK5cW4PW4RmX4vV8fZEqm/IWpCU1aUNtPzn6XwBpcfB?=
 =?us-ascii?Q?pbYojqMPMRLWKqEF+wA+FACUJgmK1MSO+eoOVmBDD99MnnMC1kAUPUfD0ccS?=
 =?us-ascii?Q?d2dh3wVA2RNWFj4yvx5xKAkJ/SzlaS2K5aBf284PGrnCfiMyNkLbXrxwmyqm?=
 =?us-ascii?Q?kVbHfn9SBluIVL5x5NPq3/aS5adune0VvnWNuEkmw4zP1pB1Sg5cLxqvmzVr?=
 =?us-ascii?Q?cddfGNp1VjVVV3yRFaylUTclfO89YtgpzzkMqhbaK5xpqudhkK/GislB4zq7?=
 =?us-ascii?Q?1sI7vI28YjbYCVHXEvcPPpcsB7H0fDvNTFAHh7z3fovFQZEQaqT6a68e+rQL?=
 =?us-ascii?Q?YSAA7bc46QF/irx0F63XKTDVagHa393YdvC+4wJEloPZo8BKhZZmJteFksVX?=
 =?us-ascii?Q?CznVs6OJnrV9bLBAhyfbPFGIrhNouib524JVvlV7uqjKSwsi1c60n2VI4IIb?=
 =?us-ascii?Q?VBNwpDjTcQmQYABO8w3YqJiGA03Iy0/jT8CUFpgyagt/aw7uev0YPJZCnR7C?=
 =?us-ascii?Q?dvWVjoYUE95XMbfXdSnO9tQ1+WOhma1lK3NYMXziekIYBzkPwwXiHg8OGkPt?=
 =?us-ascii?Q?tBlZdMJOcin/4g+wSWnXhVOyakJJn+lhQxeURjHDqZe2wl7YJ1KRnOSE8kl+?=
 =?us-ascii?Q?BWu/Z/XtNCGoYTQBfkCjZBlrxQ80ulmv2PEJuQJH4+ivB7x5VEJisNe0iuwA?=
 =?us-ascii?Q?RxUJHF6Ra0PEoF4DBECWkypmz+d3vwfi4/Ztype9fFm47XBg2dNdb73Da8Uv?=
 =?us-ascii?Q?TnLKnfo3RN87bEX4FFmkrMqWb/dDbwFowUPFuW55miwsoo56Am0Z7AG0jfYw?=
 =?us-ascii?Q?h0zK9++eGvf2BJi0yRuAvVeXSfcgZVLShadUotXY8l5uP07FlxENuBA5ozyO?=
 =?us-ascii?Q?LHoXOWskFjajEHdPjnBPn+D10+Cjmrn/LWalDzkiUp6BJUeFcEbYuzxbgA9v?=
 =?us-ascii?Q?GMspdt3K0CjffBwjsLKm2gL+wjbEqg7K/c3ylgCFEMCSiu5/JfRu/oJ2l0if?=
 =?us-ascii?Q?kQQB1lulc9FoozOsSVUtbCo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 810158fa-ede8-4186-a2e4-08dda5372d52
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 20:17:36.2749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzVNV+WmP2yt3ZcViritWBfdNdlTJPH10L8a9Tg59MszMcSNgOmm8I7eCZZtJdZyhAOlaq9f3bU8l8wWnY+i8x2OQXicpLHxZqADL8lialM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5399
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

Compatible device list must have a terminator. If terminator is missed
the u-boot driver subsystem will access random data placed after the
list in the memory.

The issue can be observed with the "dm compat" command.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 7e35e1fd41d..2aa42b3d727 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -926,6 +926,7 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 
 static const struct udevice_id airoha_eth_ids[] = {
 	{ .compatible = "airoha,en7581-eth" },
+	{ }
 };
 
 static const struct eth_ops airoha_eth_ops = {
-- 
2.47.2

