Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29960C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 05:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECD4684C7D;
	Thu,  2 Jul 2026 07:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="wJqIjpKs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9054384CAA; Thu,  2 Jul 2026 07:58:23 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE0B384C9A
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 07:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QR/3haSHUlSzRFtolKgKtjGGs0BGIhDGXHnzFB+zfZ/rPL6NPqLz9vyj0gEZ77aopWNdWswKrperimlk2isu7OilwkGIMLV25iN4q3TEkNhoJhWWNIb96dV9dxmOyuHxZsUeEQoKkgeOGsXRS2PvlLKLxzhCC/hDTTortmrvrf2nvUKQ+tQjnagmk+LprvZDNcwsvDyd/2iQo8eorWwBUWEoRc7nKcfT55+UHJTNmaun45c+MHwxuZYrCgrDYyZiPbgtcIhNqbjJJMcwfM+Rv8DdGKRBPqC0v/bAHS38lgUPL0XjY6JJHENla91LQgKREbuO4NWW8n7LZGJkcbiZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVsrZlXirc3xoKGxRjJnCBDk4R8HxBBgsf1AfwFTvxw=;
 b=LqkVgk25i/fGKrDtK1qwn8fWuxjQTByp/9JAx0HM8R44EwVLLhxebjHZzBlS7+kf1KDsVIYUvs4T6Mf/O8yAS/3lebHWdarGGaVD0wNaCtmC/pnFmHVBYPFW0+UFCk8dxKemb5xtzygtIePnYhQdkI3Ml973uz6txuFAUy25GXTp8cVeMi4XaayMsKNBlZqK0t/Bmi9VvEyzDT9RTIbuaI1Xq+Aq4qXpLWdvWHD/XFNi8TdY+lPpSz2cqwyCrs6fQaz60k34hmEK7bC263GetGcUrmZiRDK3mjecVsXDg/vLYyWaDV/HZBTlY3T0cGvZcJE2205cmxa7y8Y/Gp/sEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVsrZlXirc3xoKGxRjJnCBDk4R8HxBBgsf1AfwFTvxw=;
 b=wJqIjpKsbjzp8XXae64WRdimK7y2jefLTHCiOnFS31qWpPiI5mYHLjhHlGWH2qXHgoGV5CxDNxAHjxmU3+7aftqNBvDWxSy5TR8nHLUro+oDKWP/cfyeMyUZQL/KOQ5pf5YSPMxrWn9/9gyZ8o20xAyGrkAv1jMH54AH7C0wBmb1HHhzXOsZSVqR8gjNuA5ohoi1rL8f9Cbj4ewLt5nCIysIQcVyDw/3fXXbqSlmshgAPOm7iRutc24AtIXiUJDB6Y6+Lnf2PMsS37hZjRi+BIToZbrPLVrcaJykohZVil3LLfqSqnoiBQX/N18lmPFIhzNkk8fdBeNT8RmlpnqTSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB10433.eurprd08.prod.outlook.com (2603:10a6:10:52f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 05:58:18 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 05:58:18 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v14 09/18] board: renesas: gen5-cm33: Convert to common
 field_{get, prep}() helpers
Date: Thu,  2 Jul 2026 08:57:35 +0300
Message-ID: <20260702055744.2164975-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBBPR08MB10433:EE_
X-MS-Office365-Filtering-Correlation-Id: 478260df-e607-4c5e-0831-08ded7fee9c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|23010399003|366016|921020|38350700014|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 7AbOjlq09/ZEXUNW/f3iDcIdM8TBl8RyHuaDWut5oj+5iwMjxePo1c56VVZNrZTRiMl/RLikhREbp9McHXhEKLO20vaSXCH/jMGpUvN+mtZW4VTPzWeM6hzmQyeFcN/7zOsXZqgJU9Nna6ilXGnFc9N6fWqxmoEph+0JNwMqvlW5gpdqQoe+dOHTY6iFPb4PvS51TpbDPm5VZzCl4rrM074FBSzTrnYdatbFvfgkJBZaEqG4Xu5b1z/l5S/lIwz6gXdXVucTFvuY8bIrSV28X3wE6Z9q+26BQV0BFsnrwwpQShSOFq7472DjCrmjWcpnLZFPLXL4UxYuEYjwr+UIcj9NTGU6Apr76AD8l0GL6/1GyesyWMz+whBXEFeHtfmZtfTfYpk7YiaysehwcWTVXIro1CB7tWVlUV4tasktI94SMKmuHGYX9Z9sFl2ppIsQrWkvj+W+wlwHEsEdPlNGed3KDMbL0NFcAfmTp43y2TZ3wJHI21SjxRY9WJjSweL7z3c3v32ZTs8OzM/yr73gMObb7KpvjtkHjzPB7xOiLFabHTcGVa5vRGzZ0BvaBtrkF61DqQymgm4KMsXEfIHrMeJWmbXMZhw33MwSX9jbHkkRC7Q4PfOraSWSNn0G2R55pF7kU+0gKWOrX+acDj7gFcn3Fo/Hn/TUxHkfLSMXQWKmys9EEkynXTQyyTo6GpNoJFz0cvfd3gE4isH7oa4bbmG9zyW8JP4m1O6RUn2lO4KrNMWHus+ty7r7iZ4T3RPk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(23010399003)(366016)(921020)(38350700014)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GkPuTpyrHKgIX62inPgeER/ZH3mgaIxzRxdPpOVrjzoxo+l3/YU3zPC76Wsp?=
 =?us-ascii?Q?cTC4G1vmUm5z4dKq4Q+o7zfLekstz4HTvKuvvLEooauhVCPQuHTU3yL7rh9t?=
 =?us-ascii?Q?nEzGttIh3Ts2SR81VgPP6ereYmw4sPvsjG/1t4BTaOaSIpssjTYRfEQGV0/3?=
 =?us-ascii?Q?ZvuWc+rvJM3bGQeKwegMhe+Z/s2HO6483i3aZZQoSAJFUS58+4kDxLZd7v9x?=
 =?us-ascii?Q?tGnKhW7wM3kAHr7I0CozaPFwYhqkBf/BdD5zc1e5HhNGbbh1rVNh/mN49paM?=
 =?us-ascii?Q?+60IRjdG+sCPhZxMdu18J/zfJpcsCI4gOZ5/MFXJRRffzwH0V6fF/I6CV0t4?=
 =?us-ascii?Q?ZF5uw+4cxMh3do1mDC9hEQqfmNIAUK1E3J+hYDT7cFyLoVYSFs3oyAyqidok?=
 =?us-ascii?Q?bNK7BtOdb4VsQdsV/2VBTvJ5nxqrw7iZeDff5mlWQoI2lTTX1SKNTOOVYR0j?=
 =?us-ascii?Q?h1wNeviY5dkyJBnr4cS5QA2gCbrmD5jX//npBk67GTw5fNJDBGfjY/Qkyfyz?=
 =?us-ascii?Q?R7OpXsIG7QITBHtwozQ3efrz728o1AV4H6IoQwALEUw8kMchQU9WH0cgAOou?=
 =?us-ascii?Q?2HTsI1Zi0ifLOEE0ysUuN0xVKXJYLgIg+/Tn3Qi3qjlISxlDtH3oMxBqdYIh?=
 =?us-ascii?Q?X+VSooRTgM0kcp9JkrMOb7SgMnqVQmkwErunE4uI7NyAxCR/DmJENrFcgzQ6?=
 =?us-ascii?Q?YawR2SrsgLK5LpKOF2wDL7Z3yxGoBLs1mGyaTLuvztO7Grwwywfs68za1L0R?=
 =?us-ascii?Q?y2f1jxXbuSf7Rg6YxcAFag2GerCGYZDdVVeWSgCZ1T5u3rjSxBY3XZ5lIWuA?=
 =?us-ascii?Q?V445kaGhJPTxxt48i8aU9I+BSdTI7QtENrwzNtdR3RcSpfLUDMFBSH95H5r8?=
 =?us-ascii?Q?zCFJP1qo/dVUXFdceyeVLcxVVOaotc3EwZFgPukxoIds4QRpNBY1i5/mIfDA?=
 =?us-ascii?Q?x+SPnWLq89aCLXOSoawULK3uzKhxjStsX1XYlL+8kz4NM5uk0utC+VjRLMwU?=
 =?us-ascii?Q?xTsxtveVEVPURbFQbZW8xss8K8h3F7MjY4JlBWi+piz77oqwsyn/2yTDwR0l?=
 =?us-ascii?Q?vnt2Wxjvb3dh1yI1Tu+LH/34OUtPgV4drvwMDJb97vXdHOM86zlxSAA/QIb6?=
 =?us-ascii?Q?Eyi31zjTKo0+AoktlKXRjwfLwg69AHwDIcsSOt6cY4MIKcYofNkAs3cu0Bo2?=
 =?us-ascii?Q?HH0Lq9UMptAcgmHTUJA4twSlWVRMC9spJDaBtoxKnawjZx2AqSD+KbDRb3gD?=
 =?us-ascii?Q?7N+XFsvj62bEXq4Ag7WiITpFsmoCc3iK/RfwLrDCS8jTpwtfavX8SlTfu7wn?=
 =?us-ascii?Q?uUUX7PjQXg0D4pGjQNoUFo7zpzAsD+ZRaKF+kETuFJAhrq/RXmi+a0BwnqPY?=
 =?us-ascii?Q?bOo/CWVQC4wnnxKtY3afev8OJNlJbu+74fHp6Btef8ZNkrzDs3nDU1BQVek2?=
 =?us-ascii?Q?iHMvmg4jLOPQK0LXfJhVk5j9eYjqQHeditZbyUsaCrZlEaHBXqVH2UBfOEi9?=
 =?us-ascii?Q?7Jgx4Mo8rpKBcwUbjgqDuyFKPXYy9nDb3XUVdfChwE8opw+5FRM2jP5cqxjS?=
 =?us-ascii?Q?vOqx+y0li/5pfVgkQYlnyGYe6IFfwiBog7j3xKmNUU/OIU/wmf3STb11qd2r?=
 =?us-ascii?Q?0f6Z92U8uHWYi1YyiqmPl46YyCK0JmwdrfTnnb5bvevujQR52HhmGGkIfH7c?=
 =?us-ascii?Q?zSClslR7uAPZf5uU4DExOFpt/CpLhWVR+Hxjlrymn8H+fQTgZpcJeO0fOUxy?=
 =?us-ascii?Q?AtsnKbUVAFucAU4lAKmujPScpGRyqog=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 478260df-e607-4c5e-0831-08ded7fee9c7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 05:58:18.0092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nCKtufGmLqs8pd7c0b5cQ5QHLiW1EDNvkJINeUiiqJBILB835y/WfpetkQxo5cCfHSP9+qp+MtPFjjqqWUjacwGGU9X0AM0XSSCAsZfDWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10433
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

Drop the driver-specific field_get() and field_prep() macros, in favor
of the globally available variants from <linux/bitfield.h>.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 board/renesas/common/gen5-cm33.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/renesas/common/gen5-cm33.c b/board/renesas/common/gen5-cm33.c
index f06df824019..b2f6087a943 100644
--- a/board/renesas/common/gen5-cm33.c
+++ b/board/renesas/common/gen5-cm33.c
@@ -21,9 +21,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
-
 #define PKC_PROT_LOCK				0xa5a5a500
 #define PKC_PROT_UNLOCK				0xa5a5a501
 
-- 
2.53.0

