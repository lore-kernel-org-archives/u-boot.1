Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FADC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 05:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FDCC84C86;
	Thu,  2 Jul 2026 07:58:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="DGjEIcov";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E97984C5F; Thu,  2 Jul 2026 07:58:10 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 445C284C5F
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 07:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDMH2EbER1syEW7rvbhM5PuUOZd01l7eBXZMcMdY4Rf5yaYDL9UdLmFksjfBKwWUl9612clvTHLf2QcDirJa0Wt0ZXDege8s6Gpxo8/gl7zr10+mPKk5BCTFs/70JMW5Af5Y7t8HcKnYPkJELlw6udPPXhA5wzSS/1u+d1jOEuGO6pgHlsuqBrDBO1pymvVdf90utA8bDu8mu0AGbRp+cC8pqPO+lWDR2lgCyrh6GweDfdTkFgdeCUbLAvNt1G76SEQvmSRa2vDHagc/D+cqzYjuhIBMLQFg/2gNkaGpaPkFWH0kx4aKPc7s3+YvxOu6wAzGg3I9VMYs/lEHdOhcoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxrhqF4ptlFQ7bUnDd3AKaOjOuHGsZZZDu+CWCzX/Mc=;
 b=fxa+KNGJGxHNvkLn2gJ6MqjkeqWkRqmLHk3cNcspEo4EYFi5Sh+vLS2oj9xI7ezLynjK5ryGgLsBogiL9ZpybIsNSPPhmZHjHXCe9WKTkIeDp0QplMX1Ug3oF8OCCdn282W+ounGmsT48Tbeuyvg6wnh6yx37zAnXq+EN8qAAeiTZpUKMSW+VlPt1qkF24zZwJzhaBacFMYoALOz8fudKL383BGyt5KEcP+A561AiXlGCaCUUaXwiQosERejXf0DPnc+HkPa9DJZYfptm0O3NwWVdKQDSUY1q4Abm0QcMIiTGNpQBjVE2O68eKWhGTFztgbnY8ikvz5md40uzQqjMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxrhqF4ptlFQ7bUnDd3AKaOjOuHGsZZZDu+CWCzX/Mc=;
 b=DGjEIcov5JVGS+7j2NA9gzIkS4KM/H3+x9OjxM33h9DQk0r526zogoPhzRHr3xNGxITiLsmLIQvQ+7DDaLmxEkfEm6CxE7h3U8guYSyce8C4zgOnM1qO6ejR4u6npInEJJWjsMgbmh+CPlUNy+lz9PTAAMjpNkIA0oVkkfSiuPbvL2uaCW6kJuP5SROqFSTtJEmBUAr470IL77RsQD0F45Oi0VyeBi0JA7VTfKkr3tCL9eTLCuNTRGoL++eCgKOUBXTucEPKuW/lWXoJScCcMexUhumP1WgDEHBcMuRmp/Ix7oE7bxsAiiNazZGeqd61gyasSSYjpApcUmEbzeEFSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB10433.eurprd08.prod.outlook.com (2603:10a6:10:52f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 05:58:05 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 05:58:05 +0000
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
Subject: [PATCH v14 04/18] watchdog: renesas_wwdt: Convert to common
 field_{get, prep}() helpers
Date: Thu,  2 Jul 2026 08:57:30 +0300
Message-ID: <20260702055744.2164975-5-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: f8bdff85-d56e-4234-df3b-08ded7fee23f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|23010399003|366016|921020|38350700014|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: B5k137NzZSvrtKNDo20eBy0LxPXtAPLzdV0t/d5TTENj8U++5S0M2CUruvL3Ct22OHbGVaGaYMqBJ+X2L3QU439TF1jJM2D1N/2T1cX+wEKasTG27VxUY/EMMBoFxYuMSucp6dNKxc0qBZu58kVK0eI9pWB0zFB384asKcPk0n/AfkcyTBN2wbPWBw9QC80lVzgIbs7LrVQmSkBb8GTbQImNnn6j2lgHxDPwtUMghlfmhFaA9UIafCGSmBMxaOrER6kluMzy8O3aIQyiNXS/pXJwKVmxJOo3UzFge+oc43Qp4eQpF2Yz59OtNi+lXZkw5QixotittqjtdNstwDwInHRCgk+UxFVKqoQxV4Owdc8tTTV4yhn3p7YZN/slSvW6VXP185nVrmSbhp5/X7Uw5Ctvp84H5+b9j+dwNhP9IrBRoid9rvK6prm6Jws+qQa9AzJWItr5cvCvkivtuCy1rTD0yMOWwKExf1nKzMeApjSkMzaQIvkfYXFj3TZzgWU74a6T4QBNyXxUU7tEiRujrJd52Y7QbRtMr3DlTbyFxRGpvP9SEZ/P1bcpkTbK6HUWU95hboDAbVALg9WEWEw0vLL21+6zH1fdnSlmxBx73zGZ1pvQhLNz/4uvO0D8e+t526jOYMIec4GRw3+rArwtGSEk+ZG/qzDwMu3p/+AFJ3Uhwm1ZjG6wWHMrqfwKqHv5EP/SxYxuyeTxmwJwijw3q7L/DQ8Ua0aLSxsTHMTfHcbsbMO7BPi3ie0Rz3BdQdX1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(23010399003)(366016)(921020)(38350700014)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WPRLZUTjTLz9tYFo1jo94UgHEGEt5DHNt2Sjb6FdsbSL7Qqty4f13ya3fy9M?=
 =?us-ascii?Q?sMdTn3ubTTWQIl0g+zwig/iXLQY1sZPAjqYavQoTsrn1PmI4Ll1dDU3M2XRD?=
 =?us-ascii?Q?nsk9Do5TNZIp2rgzLDeEBhRP6aAiir9Hm5I3WB63OyjqWxoRjcCLkxRvtHL8?=
 =?us-ascii?Q?DK5SZ60P8JlzB+XQX7L+p/iuryynY4Qfmaq8AQa/B0giCM+v8roiVupis8kt?=
 =?us-ascii?Q?kMgj0DIuz88GbOHGP2FrFkwu2zNmEEnx0YSlnj81Ef9zvB46sur4DNm4Q568?=
 =?us-ascii?Q?ZNftVfeHd8QlENDIf7pHETSfsudkakAY2eb6kXsvT/2hZbh2BLu+YSlNgftQ?=
 =?us-ascii?Q?NNMMYBxc45d0SBtyxbp9TWpfq5UtqLvgYWyh3HkY0ERC97sDLZxy3syuU1q8?=
 =?us-ascii?Q?dtttVCRCIcDsx1A1jdk30Af82e19NK8c/vPQnq5rp7E2sv6ysXa1RgrEhZGm?=
 =?us-ascii?Q?v0Fft2/6KBGpAmKip9Lj8jKUETr4FQz5LFpfFXAoi69WyZW0X960fV1aHZiM?=
 =?us-ascii?Q?IcigjzrnDz1IEolsW88HUQSf/yU7nsQKXr5sphpgkjea246iIyjMOj2xvwug?=
 =?us-ascii?Q?CTNoQn+y4fKyk93IuC5A1HMJrMnO0f3Z4FL3/5cRHWzf7Waqx94ZHpflzpbO?=
 =?us-ascii?Q?M3V/+w2OrLOAwllpPtHUoSfeMWxUP86G5BhPKFziYv/qPXgEmJeTj9l+YBtc?=
 =?us-ascii?Q?vMf1H5I8YLiUgTUXozxv+i7bbKoLZYuRT5ewNkWY9h/aGU4FIzH2r6Czwjgh?=
 =?us-ascii?Q?UBPxTpTIjxyvufgkjrOSJk2Vq0MTexoSDYVWBwgsaP+vxxTHac7VTGA4qysL?=
 =?us-ascii?Q?72E0UfJF5EsjO0h52wBOMAltk6hUFUcUB/44CsbvLAt81sr+pLF49udbZ0hq?=
 =?us-ascii?Q?PCbMUWoSqHdRzCdXSWG4RRccnEx+BowX03LNbc9IslZBkHxLOHCsDJGaV/2+?=
 =?us-ascii?Q?IOTyUBFTjU8BRUBMXkxhIS+9xhGxH9kik8oqmth/hKYiICFcyu78s7JHtZko?=
 =?us-ascii?Q?TDFs362lwnLsJSzAzEmv/taekJFT32Qsx3JjiF1xY7RVtS5BBcSsfYBUuShP?=
 =?us-ascii?Q?8D/Uqw+TiovwyEBPiKP6bmsgUFmt/N2w7RGA/rPrNhOYNamYywZMxJfkX90Z?=
 =?us-ascii?Q?CcKXhqTHQVUbMMTh0lnM5hvfP7Eg555o9t28M0GSIlEph+kb8Q1YC10Xy60V?=
 =?us-ascii?Q?cGJa+BGLncgY5KW7UzUFsT7t959Kel+ePODYEYRsZy2UWGGSvIhm1KhNdCe9?=
 =?us-ascii?Q?BvE6+At5mkEfCaf4ROb5PsWyM98XiZYRV2n3yZr203NZNVLGrHZCnCi9fkZB?=
 =?us-ascii?Q?mGY7C5jydwW4WslUP1wsg08mUOd1+r8+JC/ebVxY6nzjxuWtDb3l9yytp+PW?=
 =?us-ascii?Q?XgcRNzEwqv75zXNkYbsCrZ+0Z3tQgoIeqLZJJ8lGChR33KvTkoNKBtzuwO6C?=
 =?us-ascii?Q?7ZT2nWJqs0CXF+YOlnXntz4AjXVc66momYNAWlyccKlnGzRUHlQd+FUCpcSj?=
 =?us-ascii?Q?g1ORUd139Wa+G+dnjbKLTvKqgACGAxSu4aIHYToZ0kmJh4MeqbxNPBrn+Ht1?=
 =?us-ascii?Q?CCKSqep8oVkKb894vV7gN0MvqMvDg02d8BM4rtIUGSV0YuEyIr1JXptLYTb5?=
 =?us-ascii?Q?oLd9YNzk9ABVWHkYC/qcCxk9Q1E0xLRMdgxx0e3Y5aj+N7Z7bVRplNXJ44Yg?=
 =?us-ascii?Q?bFp4ftfVY7LAJFCsTMiXp+mgiElgqFCeGYI//+ivO2P1DTvjRIC9jfyCRxNM?=
 =?us-ascii?Q?BPfk9dsQRVV4I6nNkqAuIdbh2/Cstes=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bdff85-d56e-4234-df3b-08ded7fee23f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 05:58:05.3482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7VYpFgKVdcxoqU2ZapVjLpPt7zcV9TduDpkC4xJ+/8L4vvH6+BUb2/Radh7YvD+849xh+pQ80yvB0eGDJFpQCexo+G2OV2TqXsMJlzwuL8=
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
 drivers/watchdog/renesas_wwdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/watchdog/renesas_wwdt.c b/drivers/watchdog/renesas_wwdt.c
index f6f508c95c2..60f2ac466bf 100644
--- a/drivers/watchdog/renesas_wwdt.c
+++ b/drivers/watchdog/renesas_wwdt.c
@@ -13,8 +13,6 @@
 #include <syscon.h>
 #include <wdt.h>
 
-#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
-
 #define RSIP_CTL_CFG4		0xc0
 #define RSIP_CTL_CFG4_OPWDEN	BIT(3)
 #define RSIP_CTL_CFG4_OPWDVAC	BIT(5)
-- 
2.53.0

