Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD40C52D6F
	for <u-boot@archiver.kernel.org>; Sat, 24 Aug 2024 09:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 102BB88C13;
	Sat, 24 Aug 2024 11:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="N3/z7/oj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B4B188BE4; Sat, 24 Aug 2024 11:27:31 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C59788966
 for <u-boot@lists.denx.de>; Sat, 24 Aug 2024 11:27:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOWPXeaD5rgjbxzgm8GSEejBITz15omkFI28bMulL5muAEdcaC4c4DAmbQQ6MxK4Eve4/okIWLoe1hXDwQCQaAeQddDq/XFca0rbXEAsx4RqXOoK1dgpoZz/4xELVz03162DrOZAYs9qyBGaahj5Ad1ifSR8GprkX5JOFDCiglQaB2ENQTxpclBHOlm8QjuwBDa2bq8zhCiBBa787RHOfsL3Gf42nNnKbCu38p7t1opEOIOAIWrakWOfO1eVjQSx6LZJlDE/BpeBITxfUw6emzoOBqs/2N2pnMgaxmzgW+6i+6ww0ncRiGZ5UkumB7RdaKlsmzr1/75i2y8SA+ysCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5LDNcV6ld1fkkvGz+Av9Zyvf4dlWpsdwbEWmCK0F2Y=;
 b=nd82ORrhh8Eu0+1NRU4ThLZKhQn71FIxAaSOO3We4MyN4FKPwOuEmG+WO+MktLyr8gxaPjqnpML8hZ2riayhkSc7UHmXmTAfgQkK7MEZDWkDolXVBQ9KRUhHXALkRnfzZcL0JaBEsg9uaUZD8Vaotrl4n0HFaj0qVcG/ZekB1Kx9HSTmL1epiOQSfs8xXuIU+03lvLSgbicoFxkss2VEOo+gAalfKvA7ENYQcEgjtcDzuRJevVRwqDSM1Qb9uNCoqxjlJJ6Q8XgbuowMiRkFeVfWfgM3e2IzBTg7BHFfJVJpb+tczejqh6SD7mzpjPYltPaR+g6Stla+SWNsZyrfbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5LDNcV6ld1fkkvGz+Av9Zyvf4dlWpsdwbEWmCK0F2Y=;
 b=N3/z7/oj2Ff1hjdbylKA7b9m+laS2j+8VHX6+UbdRQ3W002+ZaHCoo27WdpXmSt9K9bkwhmsOgYqj7sAOTMVHw41AG6Br2pIVgYVYxlYQndyzfGQyMj1vExPFBi50PP+1UJ90gOXA1tpgg6KCDXwVlGO2nVzPnO8mB3DrKJVLblPffXAzZau6m0POSg9Af0bm967p72u8YGtwCXPmb18tfHCeAEjJLTBOgUhwK1dTErU8UA4M1X0/a4xLY0mIOuPBekKFPxVyLFB4a3evxhydW8/4f0/ffpeuntX8fE35+TAfeppuCGzHjY7B7zYYtyoTZDfZCksOjQUYa/uauiKDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS4PR08MB7601.eurprd08.prod.outlook.com (2603:10a6:20b:4ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Sat, 24 Aug
 2024 09:27:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7918.011; Sat, 24 Aug 2024
 09:27:27 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v5 01/11] net/tcp: fix TCP options processing
Date: Sat, 24 Aug 2024 12:27:06 +0300
Message-ID: <20240824092716.1042696-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240824092716.1042696-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240824092716.1042696-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0011.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::7)
 To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS4PR08MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 4827e34a-f1ab-4a1a-6165-08dcc41ef80d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8CWHolRh+dh/QI5igRlYuKJ5iMZ/PwC4gIetMwpq/lQEpzR0FqS78nlokI1Z?=
 =?us-ascii?Q?0uNp4iGD2Au5aZD/hhQutXCsbCEfGpdnQc9vQ/141HB93oEDh38V6yZsUrvj?=
 =?us-ascii?Q?fbutXUc5pUc7ogw3octQVThcmclH9EGLHO9nsfbsumuQCyGcy8+oS4f/gw1O?=
 =?us-ascii?Q?e4QYDa7nnEWiGI7JSIAJEgU0TVnZmPkvE2+mn0MZPQkz0FDoTABdLJ9UqPV/?=
 =?us-ascii?Q?T0KPfEKltKU3/Um4ZEYVwSgBqZ8HRD/TbwNB3rQhoZWPs8TTOf+fRcYyZWKg?=
 =?us-ascii?Q?6lCizzw/VkhDcFXRuDB80EnLatxg6dC/42s3vZ70Mm1oxhJMVEd4rUuj6fE3?=
 =?us-ascii?Q?Rwn1nIUz0CYHoT38m5KtD3cVDNR60GM4XXsG5qJBEFqXmE9oYn6NUmad8puF?=
 =?us-ascii?Q?BJqk/oQisP3oeF0hKBp+vpuGx883EGVbpIOy5U0fneNTM9o48oJKxzahqTpo?=
 =?us-ascii?Q?7B229CB6NdfblggO9+tufGnt8/ucbuty/P82W5qLfjIgYlmHpOCfbI7WHYsS?=
 =?us-ascii?Q?Pw9rqNJjSy4cHI9gmhUeMlbKWM3ifXmudM/w6NQ8nIo0e2N1kmXOTGvC62ZJ?=
 =?us-ascii?Q?xYGdbiwndbLHjaIJNq/JL/lu8RpCrfd3mgOk/NpQYvGHy2A9Gl9idrfO5gXV?=
 =?us-ascii?Q?d6cBOiN2M5dpWLF51DkZoT1Ns42fzuCRGmCZBPq47i3BMzbXYMbcjosve3yL?=
 =?us-ascii?Q?5+1llD3ZGG9zT1Dknat1ignCo2uWWuKFqql0we1Mc+Y+a5AChGVc2L+geNpQ?=
 =?us-ascii?Q?oDGAuFg45x5uHKyBfKzOyK83IOkh6/lYp3iNZCWlC8l+XjF00e3JQnZnZ8Ux?=
 =?us-ascii?Q?Vcve6YUH9XqMEh9oHvCLGNSN5bRXEvTQO3bJe2sUUaB0p6kaxF550kHpZ1IC?=
 =?us-ascii?Q?fbZy3rgbgOFgtTrymo/U3T3+cePFH01cPWKsxiqSx2CYGskLLKS/Jja9RbJh?=
 =?us-ascii?Q?i4BBroi205Q8/QoEqpvBYpTZfRlg4RNQ4Ga6S5jo8crSbh/x36k+7MvyPe9l?=
 =?us-ascii?Q?pYbnlzft9EZqqSowutRd53qI3xFpVIcwrLKcd9SgPVfXsS4R4s6zyUTANLTm?=
 =?us-ascii?Q?334gNI+f1Xn0HcXEKfjfq/gz3ELHnjF9jD/kkyTXdw1ht3fZt/BrUbiGX4Ee?=
 =?us-ascii?Q?sgL7OeGhjEQ1yC7W5yAs9FHQLDeZicivr0aN+Wp9EPrN7t0WkpaeCdQGxyXk?=
 =?us-ascii?Q?7euOuXdKKp0bA5izDruUI/FePFmyY9fT0ritOx5whtIG31oVRtEYhlSqf6WN?=
 =?us-ascii?Q?BvM1hALseWr2LPG2sa8OiwqPYjXkE7uK9y9b3j+3T7xHq7Igr5ua8ouEnNjC?=
 =?us-ascii?Q?1HhlGmHoYRtgpvKbSPkgsTqRSnAkmuZvA+S1XfvsIDyucoBk69mQ94rIaR0d?=
 =?us-ascii?Q?Nj/V078M9mtCZcfYyE3LadTq2mcff8BIp3BC+j/Hep8g4qaq/r6hMpqJBegx?=
 =?us-ascii?Q?4UeBgrK0FJ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l8PnsJ4KdLC0E9jzlHTr9GtFWeE00ECa8KGxZ34cKezyphSQxCHb+JA5HM97?=
 =?us-ascii?Q?Lg+tJF56/Q/s5bOO57EJZ1x/APcIO12fCqnxSay016X7FDn/k8lW6aNb5kP9?=
 =?us-ascii?Q?5In8G9t+hyG7M4ywMBhqOYwoPoZgqiTng/zCwrU/J8W09PsSrI3r5kRtDyu7?=
 =?us-ascii?Q?c/z20v95eARQPJRvR9PGYXroXaPNVNe0C/1kzi6IUGSEyqS915OSinLRHvRR?=
 =?us-ascii?Q?1AtziT7tiMF2HUeZATArFAEm3pYVMPmYjAD7VhoeMsBk0aPYKeluxMZUZnFP?=
 =?us-ascii?Q?e1ohJ9gCKHywtiCzvLiQzQkrHaNS6gpxO8IN0c83ZMQ1AXk3hOKwc3vPHKAH?=
 =?us-ascii?Q?VScy0xYS0APSTy+oRjEvhtTnx5qiCKAYjGjAhKitOpV964vveYiRLpggzvs+?=
 =?us-ascii?Q?b10dLk/4GMeRZaljqmEAgzUTPX84v1jg4J2/qc7cMY2R0yZsnsBaYUYBqVE0?=
 =?us-ascii?Q?Z4A5bK0pJ+Ty5Z3N+b0xHwSLyZdcVBSg5YWDy9YgMgAnVaemg5+ovDSNX8kH?=
 =?us-ascii?Q?YL+5nlVyVSfwGhmm9maWOmB4Um9fBwEU6VAVs3Z88F0J4DakFJNCM1lWoo61?=
 =?us-ascii?Q?DH0+UaHJzJaIdWKvEKiAyo+/rdgfhA1bdhfaQZQLtlhCwTBuysXLXqoO6Fs4?=
 =?us-ascii?Q?0iQMyECHajq8VbagzB/i30NKEoEXP3ia/N3N6XQjP85KmKSK62y1NrKk/MRD?=
 =?us-ascii?Q?7AXnT62KclYepemwQ0p3Rsz4GBROOF/DIyVWpOEJdzNWaEeIHjrVbcTto1MI?=
 =?us-ascii?Q?wgCywT/ed2zgKOI6HZksibC1YoETMSieeAT7PRT4jVE1PkuNXkYvzjSP8TI/?=
 =?us-ascii?Q?OP2QsMntiKzyD6AoSskJYnDyYzwy2J8+rBoY3Q3ZadJfFQToGeb5VVLaiboH?=
 =?us-ascii?Q?mrTFJd2Rf9E1SmNX2SOFogm4ShRRsgw7ut4peQMnKPIrh1FdX5d8+suyEE/x?=
 =?us-ascii?Q?XWypceGAb3DquAlBag3ry6WFr5d0FOZQy21Bv2C7NuKluF1GrOzdZ84S4j21?=
 =?us-ascii?Q?VgVc/V6g1R/jCnDZ8zWpYv3YuMmTI/JQEkqCBEPlKgDTamBZBXuwhefceeQ+?=
 =?us-ascii?Q?T635/nUZkhJWm/gUTz4ix3+ooQBTOzxOdOJdeg7t4Kr9MfZE/o9xaRHbHNgc?=
 =?us-ascii?Q?bmDsPdO1oS4U8HQq5gMghZoHkhNzniiaNchHKKiKAomjX5LOeju4cjwClrKz?=
 =?us-ascii?Q?qYJxkPGPq/l3ZEEmKGtWK0OlikbBMclv/GhMgrpqvOyPncgWuSKc655Wh3ai?=
 =?us-ascii?Q?zLWAgHR7UTgxbM4LREvuaN5hJukAoqtq7SSZDWsjN9PL27nRdIeybzExhcYb?=
 =?us-ascii?Q?//HjBS+Anife83pDdhNIi90xGzpl+3U+SRHpAcnEPqst3zn/5Jfk4ICCeyNv?=
 =?us-ascii?Q?5XQ9ylVAoW9tE6d6YScSG8tYgxruOKOLOPkeOwNv1xZ9vnm6lQuB707q//n0?=
 =?us-ascii?Q?tAerO7NGpi89SqzsD7kEVYHQYXhim4Z/8iiU4IxUBRXh9cVU4CgExmICE7iu?=
 =?us-ascii?Q?UsmJGsANmLRaljzIMPSE/ZrClTdeZN+qq+PHiz0oasCfEs/cordDXtVKcr1L?=
 =?us-ascii?Q?7MNdXVFuXqZeYzdzPeVBinR03kD29KRSNVEAFXHPTg9bRA9LYUPD0oIPevA/?=
 =?us-ascii?Q?Uv8WTbDkd5/yuo96XSvNIdY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4827e34a-f1ab-4a1a-6165-08dcc41ef80d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 09:27:27.1005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5IQnLhWNLNqq0tOpwSNBK7jAQEWZWjCAzTnvCxw07Z6h8eXDNZhvKYa1mdRAykogcdDMSuPUbX/sOIwiqAPOq+lj26SuIzepOgjAhu5wQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7601
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
Reviewed-by: Simon Glass <sjg@chromium.org>
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
2.43.0

