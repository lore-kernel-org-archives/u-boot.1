Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F222CD343F
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 01:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B59A684893;
	Sat, 16 May 2026 03:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="m5slPKFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC6E78488A; Sat, 16 May 2026 03:00:52 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE61D84868
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 03:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlgKKHlk6Lp/4QOZWUe0VC6B6U3gZN/1641PcAOjMzy9f4mFv6f2O9o4Rn7ewDrhseNdjJPQ06dEOrbI6t9EzZjJYsUNS+NfYbSciMq2USfLpYzY89M6n0YvwFUDTNgijk1/nM2tsqoWDQcpS30nBgZUT4VR8P1TDwRRH9XtkQqgacRIaczgjr43tjt574p4MZwzWmIk5H/3X2QxOr+0nz4oHDYIGzMi45M79hgsHPQelB0Jg6q7SVPgU7hlerJcqc23PhI4PBk8lQR24+UwhdKFMFel78ZeT99kCTyDcf0zT5SkQc5f85r9f4Tk0+o2NxGfem4M2DU7CaGXmlj2+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQ8Ldl/ganmFv+oUmvcsQeXOt+3SVTZqXxHsrNRa0to=;
 b=Gshr1xj/5IEVj/8nnFErwJRcNWUwo143/lyey0Nl2dXcHDzm3mntpbu6ZI1V28NCH/vd53+Cplak+CN/RtpTG7Yy1a+ZU1YBH5QUHBBRemk0H0o9r+FgF62/9LHQjvcqFnUr6o68PPP2369K4lGezxCOd74TyhWW7SFf8KjRRMD4beipoVA97E4Rs3q39l06ImsvhKoEHqlesLW/oQ1/FV8Z9CQ6ctfHJCZmfSCDFu2mxO4IiwoTHYjfLgyMAK9udo2X//WUEYaK5t09Ej6+to5zyiB68eoQXjGPWIMpXqpVfiNIo87FpuqX1uhmLu8G222aIkJV1ZJnxIasplMNCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ8Ldl/ganmFv+oUmvcsQeXOt+3SVTZqXxHsrNRa0to=;
 b=m5slPKFfO37M53jZbcBxk/7QMdFhWv0UvSaZ5uS8ckcscfMrGuyIfbKZDXv15CBkSApG2PPp1+TVsZv9yJtidO4HOU7+tBY/tOX0+F5IlIwny7YSDThcpg+R4o80rva3znHesbQzihEwK+vbBANW6oDXx0nEWo4pIZ6jreMLUw4FnaiF2q8sD/eTn7zOpjJQWH84Huc+33XASROKRgalKvLY9i5GQAQO0TJGt+JSazpQj3IugZiyIHiElvjEAo1ft9ZZQ7e8EKA9Mkdmt6Lt4d/LdEjWOv+tLNYgvmmWD5lvvOscob/B7mNqJrSQpstepTZ1xnD75FyVgQRiZlAjFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS8PR08MB7917.eurprd08.prod.outlook.com (2603:10a6:20b:538::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Sat, 16 May
 2026 01:00:48 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0025.016; Sat, 16 May 2026
 01:00:48 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v7 01/12] bitops: import BITS_PER_TYPE() macro from linux
Date: Sat, 16 May 2026 04:00:24 +0300
Message-ID: <20260516010036.1034352-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516010036.1034352-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260516010036.1034352-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DBD3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6a5) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS8PR08MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: d3cd062a-9168-4bbe-94e7-08deb2e69113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|56012099003|921020|11063799003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: d5zuRdIPcpZOj2+a34y5W1zU9xFDH5Ejsj54PC54+7b8HJFw8R/YuyEmNCHdovM5Gob+GwwVW0ao4RcCzeAhNUEUkPaa5QkZJTc9bUgCcwm2h3YeIru08LvlVXbz0O4/PG93KKcP/uoaVklKVxEem/FmH199Stef0EnGJVCtXhJ20J1jyvDoHEIAFBFxhg3wF+qkUZTQ55HrzMgHCE9onZMghsafAGGnUO0HNXjf8XcSQbfPLDYSfFVgAa2BC7m5XxWYy3ap1CSp+kLI5OvUCnpk7G8BnvpyRoAK2ouecn9wDJkzie4kXelgnr3gs/cf2yTlGbgcPOx3aSb51LVv/AeqzA0eHTU8SZx9sIUZONo9resE5r4MK9c5/65MbfJSFcLYlPWMwi6Lb8S3MjDEEZ3pexBd9HQucDiPdK4sFlYloPOHcrVf76IGGwSnsVuLSGPrVYT6ejwHHms/ndLMw8G86xp40H4wjMSvyJGf785o9VaOp0H8gOw1WYO665E/k7CI4+tEY90oa9pSfBMm2acfxr3/ThiCNLllw97MEJoCDIePhjaPnJt2wYu2bMtRBjtRF7m/gihdoJ/1ZusMUJz2QVW/d0alBexXgPCrwTEWxAVR8eRxR47m9i+w4HeGOnHipOB85wGurCmXLxYiXA6Dc70Gv0jYJ8H/vQoVqR2zFnpNTtBT6ulz0BqB0XKBAZ2gpGhO2dYdhXn30SxcDixwyBf4/DE4K0n+n9oPs3yudfWdxqAzd/nKN3UIs3YO5vOQUo2ad/iXYBuVZ92K/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(56012099003)(921020)(11063799003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jOVB7m7l/dQob4fA6DRFzQ0sxB4CoLPG44z5rfRmUmlSFdUyiatT5WoiSBMg?=
 =?us-ascii?Q?W/MqcFzeS/r3VX8W2OtiNoJTJIDFazNvgGn2bAWVZVkLS4XIHAvDW5EmN+8A?=
 =?us-ascii?Q?FzTKT0XL570DACOAq1V2DnQdp052/V3MpoHJyeyqKvxGs1op/Y8z39dD9qtb?=
 =?us-ascii?Q?K1pkeZPdCn6rNdkZFtIn4o/KHOBmXPDaF3icxxWWvXkzufzy7zEI03+snhDw?=
 =?us-ascii?Q?TP8a8OnIVy82juROMuaVqX2TuU5Q65lRjlOhRWGPb17JlmYS1QtLHZt4CpZU?=
 =?us-ascii?Q?kNpNIiTrWnhRVme4cICXxAdTIdDWFD+KioRaQ6rFxNhJEJSq+9AVlb7uVfEc?=
 =?us-ascii?Q?S88S7S5mFUpRWDnMsKW6zVUqWqnMTZepryFIx1fp/zxh9JVwd9psyjh5cx+0?=
 =?us-ascii?Q?tVlWiHGbD/6IszRahMRMNDHFAtRAX41k30OfdU3YDCEgonpsTNgjkaoB6sj9?=
 =?us-ascii?Q?l06k/SdilQ09T1KDpUJDWKutjT1OvuBVgSSTLpefqvA9hwKXgGhw+RuENNuT?=
 =?us-ascii?Q?2iBvYrYZtuyyopzDZssOJgPgae4GMoLf5syISTRFPbvVx31xDYKVGPk4Ukzm?=
 =?us-ascii?Q?BwSYULixwg9+0v86gf0c/9/y33zH9+zWfZyJ5WhqjTBuRUYJ7ce3QXOvD7Ss?=
 =?us-ascii?Q?LXQOPkbaTt3gwXwZIseZe0P+TqfJtZjzXE4l92Y8I1jvm+7ZrQ9msNlPA/S/?=
 =?us-ascii?Q?CQbcAXNYf//u27+e+AaXF+AT3MduYVlk0IJPJARDms6yHsFjm8boqDWqfLRB?=
 =?us-ascii?Q?WPXr8IKN7uIWjJ0aNPnEMek+hsUkWIWq7uQVa4ao5HGqv2wJH9x7XxuLgKKN?=
 =?us-ascii?Q?qen7688g8/01o/1Z9ax1adnkQir0WCjfzTMoAPt+PORGvTtb63RSc4JVDLzN?=
 =?us-ascii?Q?yN8zmPZRuQFXhdCE3MJd6CL33oGLwTmOO1/BjU9/JJIZhx6XvmG03GNh10B1?=
 =?us-ascii?Q?PjPI/GGzuYN1ZYNC9EeOCVxr/IwzNyG8ttpqqg1aT9hW4cS/3em2uN57m5ZA?=
 =?us-ascii?Q?BLc1TJOWyUBi6kiwpioGmcwY1MqMXs2kt32GjvOYbyPx5Ct78tGi4zz56HLg?=
 =?us-ascii?Q?8/jlTWHXda35+/SYk2cffD7NC1cwWJqm1EfQhR3JAW0Eb8h3UUwF8i/8D+9F?=
 =?us-ascii?Q?llbhADBPNyD0s2AyZGSUrfQVC1YvnTYyXoFvohzufzWEK57IFyH75wSWJfHc?=
 =?us-ascii?Q?bxmau6rakqRVmqcN9KkVDh4jkXo83i2EuAxOd/M5H7zeR4LjCzSmi7o1tLit?=
 =?us-ascii?Q?FmU++YZ/AqTRhBLJc0NposMlUpG4qkZQbbYKp62Q2KYcYtfAntpeV7bHZjQv?=
 =?us-ascii?Q?Jq+0DtKys3BofpaGHto2Sy2rb4ds5Rgiv+iPnOLN/q4TIYxqoVfj56Txlm58?=
 =?us-ascii?Q?7b9PmYjN4+TmN2OWpLn4UWhuwYqsM4YN13ZwJlmiCM/MpDEjAYpEIoWLgGgO?=
 =?us-ascii?Q?/SFCfwbe0IYGR0litGhkjoXjlQ5vlnYP44fCcGXZCdwpqqiJC1kAVwPat1v/?=
 =?us-ascii?Q?EEA9KCoI1w6e2by+9IaaYIRv12WGCihzVVbO9u5m4bv+ejbz1WF81CODHQ3B?=
 =?us-ascii?Q?v22iqWye9CFHwuW0PUbD7RJ2DJENLPHOgQJFBff7cjb2skAV5qqeMLAQQsq0?=
 =?us-ascii?Q?ceV0clexcVUKY4gPW4VJ9p+IAbpds2kTyI2yQ8aMNTvAsfM1S6XHAQwu04td?=
 =?us-ascii?Q?y+q3HBG2SRrPWO3TuXaVI8NAzl1VK1ktcV7mXKFRYbITy0m8AfBwr/NF32t/?=
 =?us-ascii?Q?p/lgVJPCDTwAqUzLEOdF6Rv8CqlXpeU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d3cd062a-9168-4bbe-94e7-08deb2e69113
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 01:00:48.1228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSLYOblOkwEusbjWn3DrSP2NOpXGCGztklnB++/xiyFGttyAKLkFbbzoV48CnnH2sDMY3IxGjCGRHmYLbrPwSVhuGFl3obrpwu4PCCJYoMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7917
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

This macro will be used by include/linux/bitfield.h header.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/bitops.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 29e0da48de8..52eea4f8380 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -15,6 +15,7 @@
 #define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
 #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #endif
 
-- 
2.53.0

