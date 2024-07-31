Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690C2C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 09:21:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFE0F882BE;
	Wed, 31 Jul 2024 11:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="0ubhIN9N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 676C9882BE; Wed, 31 Jul 2024 11:21:34 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20708.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::708])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74A708897E
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 11:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+Ml1YVZ1HO4es9nCpKhIJOfGhSZxBALsvOSySqsQH3/ECb+doJKe9Epl290fg0ry8F8/yBd2dFwxLwSWhbvsxBr4mFUgB5YIY/UKCEqDU+B9kADYxJ4XpwHvQQdXe0+AYe0UZtAvdE450rsME1kfF4FVApX9Eh9L/N82vSDJvWkAYFYeyOUCb/+yTxqI13adbVvdtSEZjgVUG6ODrM/eQyYkfLlVOIRzbJbG3Q9ErKZpydDXL60xMTYNQXA/oWGb8sTu9Q6/s8u9dLDKk6ME66OD9tz53kDE9NPymmEluQLPEU/LVG5g122py5KTcflAjd0JhhNZXDvmJShfJ/3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDh9nmeaVX1B03YZeUmx1GHxUxxjZR20kqyfubesKzA=;
 b=SY/To7AKvwcaUO/ibOouWcgpWqLrya7T+V9H+eUD1Ldox7Zx1ClScC09u0XNd6UGaRm6Vfkw/GozNBvjEJ1xJwcnG6+4w4kQmUrorDZSM0Ty/ObTFfBzpdxx7k7dHKjUz0g+P940UA6+N5KEJ6oseIHeeeDBovZ/+5OoFp61ZrGwnjBh+c7A+whiD7VhG7oYq93bY4HROh3YltLHkmQ3gizgYzy0troFHZeGXzOtyQQpywQ6CZTP+pzMFY+S7aTrWldZIkfM7LSf155K70sN6uuiKOkl1oxd5+NZVQya5FYjn12J7opYrWEKOtVq3X8xkj/G6OxpOfdn1WwHquJriQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDh9nmeaVX1B03YZeUmx1GHxUxxjZR20kqyfubesKzA=;
 b=0ubhIN9Ncj0uhgaEnvVqyJ/VUnUD5eVYUL4ptYVbf0BKEwZA+nQrBATrj0LxHx5ZsM+dYDktob23hd1XhW37TbeUglRYs3a6sSmcMVUI5Wtg44xRZqjy6g2pGkxEC4DLzs0tLcL3c9306HXcuzb7Io3VksXOg1dD7ciGlijrxwUCYxfYYbZHm2pKI275fCQEOeBNxCEiscJM23aqXTATe2mI4ilGqhsGoaqLKkTahsn9AcQJlC1VqGIyQ9jinhELNht1/XZ+WpmOOYNtdNpHv71AAAU0fJ2uFjCiC4gLDwqUqNvfDTrQk/kYWvnkcMA4o0hVLvT7NU5Ru5o83HuIIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10180.eurprd08.prod.outlook.com (2603:10a6:20b:62d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 09:21:30 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 09:21:30 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 1/9] net/tcp: fix TCP options processing
Date: Wed, 31 Jul 2024 13:21:02 +0400
Message-Id: <20240731092110.4027134-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731092110.4027134-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731092110.4027134-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10180:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d64666-ab7c-4532-847d-08dcb1422997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SSWwOx0oDNJH4x06aW9u57xiQaXiHX6jIswyC1zidbJ+42FjqRS7yjfZrE24?=
 =?us-ascii?Q?HktPa/U1Z9ai+YXuo+3Iz1DM98/4jyHeeJIZNvXNcc2SH5veetgeGC5KX7i6?=
 =?us-ascii?Q?BvSY0J0kCOp7sIBy+NDuZAghVWkASCa5YVw4smtfGvAnGDqJBBAIzJ0o7/hn?=
 =?us-ascii?Q?gPAueeYCNbi03u59ePRGTcD20HA9PF9dIgs/SUET0cd0/OKI10ps3Jnlh5xl?=
 =?us-ascii?Q?vHavHu4+O5V9f/XEcjM1188u9yepQQzctJNrJpfaWiDa22npt16bGLqLDYWu?=
 =?us-ascii?Q?YRnbFTyzPyL6VjVO2zlBJex3MU8XSDR4nWys8XUrD0Kyjrr8iQ2bna+WIS9C?=
 =?us-ascii?Q?nj7WKwpdMCOoxzp78T3W3o8fT4k6Q1hrMlCjh1xRrfDkSkFpVIwvmyn+ObW9?=
 =?us-ascii?Q?AAwKKmE73g3v3cF+zlG0USAdggT9wEp/0kG9HUs+YcuH7EOTe2VJH3E85o5d?=
 =?us-ascii?Q?W8Q6aTSSla1jC7oYgMtDcBW+JhpRDpfRKQXS2zDoDkVOfbMOVD7TWyB+5RpQ?=
 =?us-ascii?Q?qlngyWTcVb5O0zRbkboMQpRvuf9OdVi339ze7mMlnuhS1C+w9Ioi81NppK1z?=
 =?us-ascii?Q?r7zMvF5MeYHIwxjUe7ORhImkW57mJCmtul+gYEOvc4aK/uZQTceA6jMWQ2CM?=
 =?us-ascii?Q?ZJzEEDKZ77/VKg3ZgWFjh7muBqHWDQPneTJDWbgEkNzgdDt7eoKRTMGra2Gz?=
 =?us-ascii?Q?at+i0I8mpz7NZdeGMwTDBQQzoMvQVu8fO/SFtgH6D5XvqAxK1CLpqvc+Oc/I?=
 =?us-ascii?Q?Cx2bLH3flH3yjHCeJCGbu44mHqdrQwDyGS3cf7oV4EVDy7p8uxVm0mmDVKeI?=
 =?us-ascii?Q?Jzb44k5N2TE8haeTXoSNiAsuDyUOav/fStUmmjLx+0+4CPKYFmGfgBWOrwGd?=
 =?us-ascii?Q?OxrSuRdzUH7BI1hqPN9Q1yV/3X80DDaTkWNvmGJD/ZQHYbvdDWsRtfZJjR2F?=
 =?us-ascii?Q?K5hy8/7454pPpKQmGD/KrkfeSiuSWSzz0ENsonw4jKpA11x/AQwq82AbpW7V?=
 =?us-ascii?Q?DVjGNxGOY0Mi1VC+1ioAL55GHPTMC03IUjBcstWjL5C/ZWnMkk3AfGFrSmkz?=
 =?us-ascii?Q?1trLHsV/j6j6T6u/QAnTtkTtD81wCVlsf9qVLQetL2Rq/oCvMQuwwRbKSPA4?=
 =?us-ascii?Q?YCKYjWJDW50K5lArmBpzhLSnps0JqROUmFgqOOzePxv2IHJ8r2RupD/fMKgM?=
 =?us-ascii?Q?bP4buspdecTASFySfnW/0GwreX5ZcbYbM35hVjym/wM4Bnpm45lqZrCzGN0B?=
 =?us-ascii?Q?VYuMeCjL+HIApAx/mDRZ6GM9kEZejzDeCgKSqgbarQicecaiXDorgnZlVhpF?=
 =?us-ascii?Q?9LvOx+pFsg64uDI6M7i8WT8EhIcx+MdcQKkE6mz01THMkZolcuAVtXpsdWkT?=
 =?us-ascii?Q?GJ2lem3mjP9ykGUCMQawmALsNftILk3IGu97oMi7tOcZiqNegYnVdkKDdT1t?=
 =?us-ascii?Q?+zLrNUnwcW8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WRVBAWZB3W4OWgLJZQ0ZSDPfIfyYPwGy0M1SeoAhxdU4TAKL6a0IqLDJ0oWA?=
 =?us-ascii?Q?eKj9vVparzXd1Ruw/TfGaV7dceFBgwQ/K+caA5vO8x/nbF2d5veRQUNea5a0?=
 =?us-ascii?Q?tlqbMc8r9z38Eo7bDKQ8yB48qKgBunu7Zg7NbYTweaKU010VvsGYFgIvJQ3H?=
 =?us-ascii?Q?wAEdx7qTibocYywnyWiHdrslQY879z8/ibKSOi/bIm2jMgiLiuCOGRkbxxX2?=
 =?us-ascii?Q?0iuf1zKPD3Y4XEOyEl9A1jLiYZqKpmfYFa/Xt3pUpl4JWBMYMklaxbIwwRLA?=
 =?us-ascii?Q?vhEa0t5yggPScgP4hI6t/+pYK7rFTVDFPpn5xV7rwWIcDFmcF9pPI4kAh2eK?=
 =?us-ascii?Q?lx6ox2zSXWbyyQmOmbYg58lX66gMwY8hOUyVTVwU4r3V9meC5sWshx7hadI5?=
 =?us-ascii?Q?ydcxytTeyGrw5slUIBsk2TvUdo19YJ4dNRjQGUMmb38/Sxu8r5P976UDOhXr?=
 =?us-ascii?Q?JaZy8A5aUGZl4ttZqhpF/Sar6J+bOq+jdypvzla3DR26tk6RpXefGvwYosDh?=
 =?us-ascii?Q?MYnqRgtXpuIuP0xKeHfDj7AVHF5he54UGbwRW4ZigHeZdBuwbxbZ6UyQ2/HQ?=
 =?us-ascii?Q?zW0kd6k98Ow6Ezq73DGWRHRjm3wS46EyEtL+xYdC47PbPHAMNhj0EwoYOT8x?=
 =?us-ascii?Q?a7/MZNhJvqiPWj1+8Rs3lJovQRYvHkvvY+EaohN0B5xW1aPfMXwWizrVSctp?=
 =?us-ascii?Q?CiaAjBY6euuIx320mhX1vIvNLIrlqDzBGQkwlEvVtPhVtB4yDK2M+Ad6bW0S?=
 =?us-ascii?Q?G3zTVvHRHdz4SS2UKXB0cKGcNEq6UT2iv3DUEQoyC0T9tkCpZqKGPV2GaRjP?=
 =?us-ascii?Q?VAYVB2A4PdjHi49mEmCXmUiXk/KeyvFmgx02qvCXwP2Fb+hNskvyyH/3yJN6?=
 =?us-ascii?Q?njTiukKL+SNna/rxanx/y03RCkek1tq82eMTsRu2KQXnIkqgVGtPhwYFhdfz?=
 =?us-ascii?Q?HOgXHlEKquABy7W761lBiQGvFbY85rkuD9MfYTyFlbEoHoejCu60YtLNgfBm?=
 =?us-ascii?Q?nEVZvWC4odLLg9rCM3Lbp8QjngjGGtHHzGfly02U36Ae5W2xv6r7yeVp3ir7?=
 =?us-ascii?Q?pBqqxpO8yfwh9Bs2DQj+MDxtRChLezlDnkFDiBbBYMa8N3aJ5RPpA1ko1Zj2?=
 =?us-ascii?Q?BZVK5ck6mN7U7b98rjtmbLi6b9Gr+VU5eSOLmsbbX3OZFb23sJ4iwjnvbtcU?=
 =?us-ascii?Q?831YZ50tnkuqxY6deog0QS8izM81Tv3InDURbkeVtWmXQAb2RZhYCZC2cdY/?=
 =?us-ascii?Q?hspINK4YSzMqNO6eLk8DHavYhx809ku4NKpS4irukS+L86EkeCQrXtYPdRul?=
 =?us-ascii?Q?2zbKK7U2cnVCbk+6y7PL57GPPTU8oUMSyoR9esO7GVMNNynJwwh9IPSbxcx7?=
 =?us-ascii?Q?CDM1dVKP0ijmMi1RqnN+3ob2+FYAj/jxjiClDHCl6u7+m+krSJCUzSZJyl0m?=
 =?us-ascii?Q?5TwmoGTAOklLigmwFgfa3zHl0DjxTiSbJBoGv3iVwoX8whwRNCwewchf2/En?=
 =?us-ascii?Q?mmnthN9TdP8uP16YBYvcrYwMJI0GHkLZL20OgENYCtuX4NiEE9Jt4sbBRQ9b?=
 =?us-ascii?Q?l0EfiffSkyou2eoW7f91ys4ycz1kmFHkDuWvkWhXa3PfNqAEUmiOch/YYHQP?=
 =?us-ascii?Q?8gwL8VTVN7Fpr/KRTDPHgE8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d64666-ab7c-4532-847d-08dcb1422997
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 09:21:30.5466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoElzcp22mqwJHsnYdpE2UENTHxLI8EDLzM4xpJ+OUEPaHpQ7f/na9GW198OVP5PWMxhfcXOVa75HjsPgk2rQAmat/Y5hyrEYU/9JDLFdqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10180
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

Current TCP code may miss an option if TCP_O_NOP option was used before
it for proper aligning.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 net/tcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index b0cc8a1fe3e..3e3118de450 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -475,7 +475,7 @@ void tcp_parse_options(uchar *o, int o_len)
 	 * NOPs are options with a zero length, and thus are special.
 	 * All other options have length fields.
 	 */
-	for (p = o; p < (o + o_len); p = p + p[1]) {
+	for (p = o; p < (o + o_len); ) {
 		if (!p[1])
 			return; /* Finished processing options */
 
@@ -490,12 +490,14 @@ void tcp_parse_options(uchar *o, int o_len)
 		case TCP_O_TS:
 			tsopt = (struct tcp_t_opt *)p;
 			rmt_timestamp = tsopt->t_snd;
-			return;
+			break;
 		}
 
 		/* Process optional NOPs */
 		if (p[0] == TCP_O_NOP)
 			p++;
+		else
+			p += p[1];
 	}
 }
 
-- 
2.39.2

