Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BC0CCF9FE
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 00:45:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95CCB83B56;
	Sat,  1 Nov 2025 01:45:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="dJj9IEpS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F4C983B72; Sat,  1 Nov 2025 01:45:18 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACBFA83B4F
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 01:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WByqfw/cNo08aokfyf3oZ0cCdcSgqIJEc9J1KSsC26kk6P1OIuBGc/y8xeQSRHgNBRiSxflBb4d3j1OPGBeAYBq96AOd13q5iirMVCl/bk9ofWJMfjGfAY+pnUANS6GggypiPcBCRkSGjPIK/LD3CORZ9AgbO+ecdz3sfbr82wJ8hcYxyH/DQS7tadW4rz3Q3yv1+Wmqt1erTx1ExGAew6NN6x+AbVvy1MDbjWw5iWA/ftcderuel8DBN3S7ZnID0I7iH5LxWpB/Xhg9xVzOZwn3aVz0nhBxUv3cqLBk46q3ZRwT5714bJvchVkRZB4PW25sf+2ce1frIHppGyI6kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbIDd5y0IEAttnmsNEEsB6tEZ6sWhNRUgkTEdtS0rv8=;
 b=MHb5SMVtMnL8zdbnQnmXbD7NOxn2HG/P/P/oj3m01z4hn6fr92dZLH3dEYTnRLklLH7BPTWVoO4W1xDwAQNI30RRCNRe0+MTfztLIw3V4c3g/rD2caBq752XBUMWqrb2peg4A4wdktFn9SahJCVwOeQ1BoemTWHVdsscd4aSbji2c8wgWlzXAr6t7LYMT/7+3nxCt4nlYiV8dxCO1kHSVftdGVVHTbtdS+MAMuaEb4QAod+pKPremO6/4JXeVnn7cB+bVaIY7qjhClNM9dPf+14bPhRiAcUmWb3E63W+5xEo6dyjwbGFQ3SWn8gB4BCFYepDjemRoXnXJ/i2FQP6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbIDd5y0IEAttnmsNEEsB6tEZ6sWhNRUgkTEdtS0rv8=;
 b=dJj9IEpSVMzFO59OZ8jlQQBbHSfbiS7rMi/8Kdt4f8cJTuQekzoIG+e21WQio2OOrwPa3fBjA5+Ye7h9JpN80CCV5JOUwTN1ebtsUUr56NpRcZLH4xkU102B0zh+3pyeMPDrmRYoDJBxnnHXAgBkcNsvqW2ony0Tl7oJUYCBno+SC7CnevXjwJiKrVQR95jbnd9vOavWsZfNBF4VqbrkN8HTttsvitI9oKCqozM3jFOm/0W8h9/vB+wAkuHcbKCfW8WEiRHnPl6NTlfSwbhVfocIsAzV7Hj2Vu5QH/ggV43O0lT2VGvh7ams0C60Hy0wNO3Nbh+g4ycQPO5ttESIIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9258.eurprd08.prod.outlook.com (2603:10a6:102:308::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:45:13 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 00:45:13 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 01/19] airoha/an7581: add CONFIG_TARGET_AN7581=y to the
 defconfig
Date: Sat,  1 Nov 2025 03:44:45 +0300
Message-ID: <20251101004503.2379529-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: de4aaa34-8d54-4569-6b97-08de18dfead5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?msZkcrROvKKD+hlksHXirodka0/weoWmdhZIE6Bnz1yA1f2XN0idh8EUWIe4?=
 =?us-ascii?Q?/Cu/o78qUGzj2iWK+3rNjT/maNTV6bopHAyHDTXkKO5vPUcaUz6Nyhs20TFO?=
 =?us-ascii?Q?ZqYhClrmmyH70qUcy+xRZvGmYTe7VWfrVJxDPboUvRYxO3JROZnTKARm2D2I?=
 =?us-ascii?Q?MTvCckTN7C9dwuz6MkibYPFF0b59YBwLuSWv4FfNpumevkocpbjQcQlKVlyJ?=
 =?us-ascii?Q?xRvhzfeom8N61d3nXCEdmle7USL7SiJ1WTtdOsTf0qoDjZnt4cQe6K6jcVPr?=
 =?us-ascii?Q?QqMAiathuWIUVdOwip3IWwI5f92uGq3aPpLlG8dub+WCF5vDk/Ey+8tBcGXu?=
 =?us-ascii?Q?IniLtyLcNI78AkQAjQoosJYYwSVWxiQnDYYVCXcY2uhoR1tDQD2QK/j81xON?=
 =?us-ascii?Q?r/JityovXVI3K5kv1xFaR6tCBIjhMcA9bcgEZlrOnaecyhgL4bnMscXHOWfN?=
 =?us-ascii?Q?o5zAUROxdjzMv5NB3jAb0bxn2jYDVlNkUxo2B1XMuMwXE9LSj3HbUStGmFu5?=
 =?us-ascii?Q?zBq/+KLCOvqEXzFV7bsOUL8HcMxiYUh9fI4n8NJbrkJTBKCWx0Uq7NgSeovi?=
 =?us-ascii?Q?1P2+TXTfqfGAKYbPtxTJ+Ib6h9evgcIERX4gg6BLKkyvx1vAuXShShnby/pH?=
 =?us-ascii?Q?CAMUHw5DL0FMj8XTcyaGVzWrxguL0Pu0xwM3E7tZHveFwr0hCDgTOsbRKEEQ?=
 =?us-ascii?Q?Isc1N2C4ujK4jikYpNejKmNBPdVljDv8mHSyAZPf/knXnGZAo4nD5NRyqTPO?=
 =?us-ascii?Q?hN72nVKOFeIr2EebO9hW6HPzcjeIb96u8cgiFWndriXxSmPg5cWPwfUxiBAx?=
 =?us-ascii?Q?djYqXViHWozLTsU0N2e1vttj0fEeMlUcWR0T6mjFLyPT558hdspm4Xl4mS1r?=
 =?us-ascii?Q?aFRYHdbKnwR0QrSkpxDIlRVsg0pZQ79N9SJUjZ1lUxvGdN+52rTDkwN9pECy?=
 =?us-ascii?Q?3vYJnjxzO8w4CCUlzCJMp9tWGtsAMV9S/0RcbRnjKCtMeuuE6Ff48MWxSiJp?=
 =?us-ascii?Q?zyAfVlDOcwzjnug0zAYp/Jtfe6+26wHaa7CMgomJLB8WnTri2xP+qxVNPJzN?=
 =?us-ascii?Q?iWRC9UD70ToYhiMLFbOG9uxuS472ABcP/ox7a0nU/TKkCpmUkH2wOc5+BAZv?=
 =?us-ascii?Q?PREem2kk9mHHrdJyI86s8fK+INn1V0miqvWSLfsS6HO7fWngz7qwrgUT5z7+?=
 =?us-ascii?Q?iOACWqIU/KMXjDIal6UK7o4+WxxnDwWbzURNApdF8fLo9ScmdeSs25YKUolA?=
 =?us-ascii?Q?O3djf6xFndDYVRqUcGI3pDKhGCJwUcXWfST7UyPfRkOZI5H1G9Bo0trJG2TO?=
 =?us-ascii?Q?m99Rk9YW4et1eMwQ9gme1yloDZ4xHlF7ZwBoub9MV9npxQ278Xu6hXK5vlUm?=
 =?us-ascii?Q?Jbk71upFn71bM48pMt7FclEqAM8Ofq1eHuIwRfRvLJfjCcocvoVsxZmeI5i+?=
 =?us-ascii?Q?kyoBG67tcuHmapM/IeTAlgghxAzmoWNt0O6tBtACwURgcQyHAbM7JKnYPI8s?=
 =?us-ascii?Q?anEdfPPC9Y+BE0eJ6u4gkWXCLZA/5mvxW4o/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zeMQNNuHeyjFnlASxH2QAODpkTG5pjHrnwcXu1lzMDhqqjEqtaN752gdMhO7?=
 =?us-ascii?Q?tESvFNV4l5jcir4jtCb7nWuDeMg0PHvcNPCStIDzOYqbWWDYQ6zLQToSm41d?=
 =?us-ascii?Q?+mBsBiznLNOUAjGMRajvqW0em8yfH1F6jMDCz+6np0pYYR3dRDjIKQiznXtb?=
 =?us-ascii?Q?zPQzg3Kgq5hv6a6NZcpsVNSrZMznnS6x02SGJXb9WkNInu16ip8jS9KTxf2i?=
 =?us-ascii?Q?XqGXLNxbzZdiod8qqAmUUjhzvaQguwqI1PwA1fGtxIdlAwzoB7/5KhoE6FxT?=
 =?us-ascii?Q?yQ2C65Iy8zyQW331DAoTNB98LG2EnxXlQLoko9HxdLVDkoSqzn7iUWPhnzj5?=
 =?us-ascii?Q?vURMWl9ZN3L0nQ2qA7TMDOT2w/IQ00jbTMQ4UiO9JPLY4FD3TYkGAlzijNbV?=
 =?us-ascii?Q?5Syz6qbQi3IlSyyeza1tic7E1nx0/Zz8phVtfwQga2AnuEvN3fGL0tESRRFx?=
 =?us-ascii?Q?6pCdjl0RDmoVZUwZbtvjkj4FJJ7AHYM7oyTjAoNUgCUwP2/vEn29rgMvtDlv?=
 =?us-ascii?Q?beyeBndZVk7ShKDl1bzVgbjXQ/37ZL0XlY/xBGGsoqHB/1TLm5XUxG+eqvi4?=
 =?us-ascii?Q?zr5QyHSxDUfVQPeq+JdzfBIkl1yy1fg63d0n8msS04paB9vvPOmtmGCmROCg?=
 =?us-ascii?Q?aWzb4idJk/ttWC3hv5nutlckaSfjFB2zwCFHUOd3fz1wa4rLLL1wHCOdIaV7?=
 =?us-ascii?Q?ZgBgLh5PLeHQ2phNJoWagBcawsHUR7NyZQtppO8B1GrhOD32rLbiuGh3afMY?=
 =?us-ascii?Q?Dnqhbf44o2x4nc+kGxkj52TuU7T4pGKn+UHpg5HiZYTpPEPVXOffU+VENmd0?=
 =?us-ascii?Q?Zeydtjcx0OPuY/NG752UPfOr9jhZ3qf34trRy2BkbqmWrvhvj/1ccTP7yTeq?=
 =?us-ascii?Q?s2i/t28klpyeiZYhjuO+qL9vrzPjPPUnrRlq/E9NixQ914u8iE09EM+ti4m4?=
 =?us-ascii?Q?o2L3Q85CCR3XMWEyD89oycZgdal8rGjbLicdrB8RozMH97dOioPHfm86+Y2N?=
 =?us-ascii?Q?knL/wemN9wpoyUhOpVHzQxaMuLcyZ0bO3nDuqIiW/uJqBEUW+EHEN9b64oVz?=
 =?us-ascii?Q?YM4T7lGjpMkfhzMA0FF1ko3E+FZCMri3++TgzdY8+YvErKp0Ryhta6/YtlxP?=
 =?us-ascii?Q?QiQvXDJGhwo/9lhImxDG8WSfU6d97GMPnX4ZHHnk+0rSxSTadDKz4dPU+Ee7?=
 =?us-ascii?Q?1scKWSlI3nHec1Dja6jYQCnp/Vgx0JskLiAX317ivclDvbD5M0xNHs6ZiIrb?=
 =?us-ascii?Q?G1OINKt1gBT8g9Xg7/S+f9wW/TdmY6uaFCI1/o82cHRuI7qo6C0Nax5C2gM9?=
 =?us-ascii?Q?MICbZJAjFMemhfXqcdeiaERNy2KD2THKxUoZbvOYkkyyxZqGUmZX1TLO+qZs?=
 =?us-ascii?Q?+9vERooEHJ/RCHVTb+EuUiqZ+mur3yYDWThCITPGd4XlFlY9kGkRqywGsDEA?=
 =?us-ascii?Q?WytD7BdJ4v5nyKzbXMyV3GBQAhEo1XUhq7dlN5+oY28Op+61O/1BTDLlMFVf?=
 =?us-ascii?Q?WXdacoh1iIFzvxBZUvz5+6W9X/Ht9ljXoL5x3N20hF9QrLrEtWwPkKe7G263?=
 =?us-ascii?Q?47hcg2bJUXDHjWisJ0CZBP5nzjh4drjBYa1lyusmL905OSAwCctzNZRJK/fa?=
 =?us-ascii?Q?rMTSEdCx4vBCYf5hVpABNww=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: de4aaa34-8d54-4569-6b97-08de18dfead5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:45:13.2399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yn7lkh8FtF/VQ0BPDYQl5qYT8IbG7BY3QRwQeVBZTRtlPqxHVY0oxMKViEDUBpRXoK6246eoiPMR0N/Gvgl3/2fqwkMr0fi5bFJVnwXOIC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9258
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

This is required because airoha/en7523 will be added with the following
patches. Without this line config for en7523 will be created instead of
an7581.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 configs/an7581_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index baa3fc3f5de..73af30cd693 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_AIROHA=y
+CONFIG_TARGET_AN7581=y
 CONFIG_TEXT_BASE=0x81E00000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_NR_DRAM_BANKS=1
-- 
2.51.0

