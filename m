Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FE3D637DF
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 03:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40E95895CC;
	Thu, 14 Nov 2024 04:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="E6X4eN+4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD3B2895B4; Thu, 14 Nov 2024 04:36:58 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::71c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D9DA895B4
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 04:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQFniSssAULN0FcOjoF6hvvPpfV22qpN2KulKo4EDqDj4k9/+GB2XUDJIaytpS0Sve4UTQTfUbv6n8oTR/PgHN1YoCySEW2osrCKEhPJJbGkG6Hw4mystZdrAo70nIcUiXxi+VQJouV9Q+RhXn4fc+EBHsLF6YCMgNJbChipXH7A2KHmVVLor4QQERsX6Qumto6T+TnqOsFEiIaTdpe6KMRVVdrlTFhR3AjfancXK3jeEEtTG+r9MvzVRUEtdv9gEiJ2i+6BDc7R53WtKvPUSTI7QdImpHff9b5+/upBudLI0DBHG2WuDqTjgJVviigjTnwc+fKiifWr6FI/FOcHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=W8t6G2lj4JvzjnNbT+lhcMAb49n18+FWcetG4B0zeSOj/ELIrYW481eWr6XltS6+NAw9k+Vge63zpPbd2Cww+IAHOyQ0xJEK3OYjiBRzDXnY/s/r3XQeIBpHllTAxXzSqmYq2tVsso98Kpqx6766Et1zKS9w3oH22B6oONZoRdcmAcnxlMjQJu0TUmfF34aFdZg9T9DuNf+765uQ2z6u7ksnZyvWOFgJIB/WsmcnwlCjtCALwPSvcgYs3MpEwFUqjBvPPOY315jVeJgtV0PClu4eAqkNeKDf8LnxkG+MfNYhm4kR2XwrU1M4WUFRrLMEbbYu8RZ8evs6HXFrIVvo/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=E6X4eN+4vUQtdczsYj7mptyGoZ85LackMIsjI5bjlqro4AmEEOJA4lqNqZgPmai57HFLUaXYrAHRJh+4cqR2/zGVQ3BxNqllHR5JH38qseRKd7txDlG2LlPbeYjuWHkee2UF18DIG1jSpYtwT8Q50FHPDaHko0/0HYX92uYDX3jS/YLhOuHPRLGwGlYNbrUKejEtN3CKOFvM83iYQl58OPmqjs+/rTeFRmB5RlFIvBJoO0GJutmwLIPqw7EjPmORt+unM0/kbacnjvqBqm0Lx9RGV47zpqhmIeCNg2EWSZLBK6Y//2UdfmCi/8qXy31Q4+6myOmFniVl3GbHygA9aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB10338.eurprd08.prod.outlook.com (2603:10a6:102:30d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 03:36:54 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 03:36:54 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v13 02/10] net/tcp: fix selective acknowledge
Date: Thu, 14 Nov 2024 06:36:35 +0300
Message-ID: <20241114033643.623355-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114033643.623355-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241114033643.623355-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB10338:EE_
X-MS-Office365-Filtering-Correlation-Id: c14f7147-5eac-4eaa-a47b-08dd045d952d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?epIx4PMe/y5DD8vZwq/bkaXAIqM/bMAn1Vy28pI0gLVXCpznyhyKlu/ximur?=
 =?us-ascii?Q?Y+URvebVwdsICPib4gd0vvLXfq1F3D4QrU8gRmgh2HAEulspAslU8oySBrT8?=
 =?us-ascii?Q?g5c7C9qaSIRBCcWd/xO5Z1ExAbv4NCctrAxHlMaLddsbPvjzhmEynv2rD64l?=
 =?us-ascii?Q?WHOBUtm+muy9Nvvs4H2mzPkPh4gtXGHTgwA8hXUg0mjdZdI1IE2fOIrOMD+k?=
 =?us-ascii?Q?DE8tZT9nAonKO4LQlgXG249vZvYP1QDXiDifZVO4a21TQPsKyicYRSEJ/jwX?=
 =?us-ascii?Q?tniwv7n3crDirSrneMqm1IubEMeyzjakadQY0Xc/FPdVRAXmwISR+VZlNy2K?=
 =?us-ascii?Q?mlgSmuoce6AUr+K7qs1NLYlbOTjryl/K1bNkkbBoV5OzwTH82X3WxTe873Qh?=
 =?us-ascii?Q?HF7/OsfyaT6pM3EwNZQ5MjCskmDPHh2LHEszsKwZngrIu2EXx9W024/hdS08?=
 =?us-ascii?Q?qhWDprs8YNut3WTiuxZzoKcLFrL4n16+u+2cxKUGpsSmo0cOIYRWwIk9v+uS?=
 =?us-ascii?Q?eSrsK+CnKZX/bCLeOOl+VPJsOMIMQ1wEg+bb+fawGx2VMniyvodgmWaJN9et?=
 =?us-ascii?Q?utzHPJK8bvE+YprzR/s9e5UytPXMxxhARE69Sl2A1i30xjmpfCU/ihQQzxRb?=
 =?us-ascii?Q?CxZiUq9imN3HUZRa/5Y/Xh/2grtnkPNuLQ5Xri/hIkN99UDi7x7XSlsKo68+?=
 =?us-ascii?Q?OfsACeA1JQr9jFEO6FyJ7P5vOWdV1jxYRoaF9WvEu/PDwTIF7RMkpNjkYGuy?=
 =?us-ascii?Q?qWrSmiHGReVi64l/opXedDdhBr/YNQlGt8Uls+jOpqMg5HXJTW1SEJ8R0bIR?=
 =?us-ascii?Q?n0+KNJgLn7bn2L32CuiGNGrwlnKl5dMzYxoBam+5pfON/4F2S5qaYv9XYL2c?=
 =?us-ascii?Q?/CmBSjya6OQ++zxbcRnBaBWvm8nM5CmzFMrW+W3VNX2i/nc4yH8K1IIGqDRN?=
 =?us-ascii?Q?zf1wK5DweNs6L9FMCrgzfwuGlzjZ0ZOaxUAeoHJT0iWi9/NqWlf3dkPaNOeY?=
 =?us-ascii?Q?gE9t8sj4WeLJQhnsjNgW12oyIEGhbmMDD9ZqSxOCTDZ+1FiceRLVMU80bkHX?=
 =?us-ascii?Q?QV4a7dGKT96+Q/03rEnET220jlrtvSwJg7F81lkDPaSePvKD1Gpwempx4LnK?=
 =?us-ascii?Q?b8Tx9ZI/uZl19Rb9DDcVfRHZziaqf+gJu6jbIkowryxQdgISv7rCUJujp18w?=
 =?us-ascii?Q?TKJGz5xH0quAALtn43ElfZW43Spg8YHZWSa8/PqD0yNs3N+iDg+axYTg6hbq?=
 =?us-ascii?Q?utSVHzreBL/nA7pKf+8w4HuK/cxN3bC5m0cYzB+B2e3ZgBq8SBGnLqdIXoYz?=
 =?us-ascii?Q?L0W0Pb/gfKQU87oGstvxYBcNChM32aVk6BsnpwdQW3ujR1tTtD0IxhuCVClo?=
 =?us-ascii?Q?hAyishiJeDevKSw/Bcyzg7uM0OQx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?diN7WKc+xrIuwuNXltXaBejUAQ9LCDKFMCndFYytoUqiSrJYvOWUbEVDUt42?=
 =?us-ascii?Q?klRrH4qc+bVKPAP+Ui3rOubqmtJYhCLgAmwvyNjX0B78TGE14GFk7+owFBHr?=
 =?us-ascii?Q?YWNz9efMffmcDGASEeQ8sCSohnlnOIKWwZZz9ruTVuR3U6GpjGcZs/aJE9T8?=
 =?us-ascii?Q?cBq6wvuRsLDhsdp54YCTZlT1WsrH7m+qmY8zoxKRVEfhJ/dybClhvlYZGPtL?=
 =?us-ascii?Q?s2D4VNloWljoXE0Dd1UyOzyA7GSdUqqg1YmHcqO1pToqtwoXekz8dgiWj7La?=
 =?us-ascii?Q?hHKH5/F6rILXIDGyELzT+MsG9uLsHycew3gVBF1By2p5nJFhc4Vuus4dpGZA?=
 =?us-ascii?Q?ii6zI6yiJcnARx6Nw4gPva0Smez5hosmtgibn91VQnv6NIkPBFJx9hVr/ja6?=
 =?us-ascii?Q?Qeyn8k49Tyif0bVS40WFFblCJs7ZpUyTZ85hndpy2keSXc49rIhEE2Bg7cJY?=
 =?us-ascii?Q?OL4KhQHimbxMzeucIghEVrVxyViY4lBmE4BDxaS7x+9bWmQ+a8fjsFudh/ga?=
 =?us-ascii?Q?k4g9KxbCLddI+ohEL3SlJO8Nqf8eygIziENVCqHCI/g5miz1Kw5m4YBQHxy2?=
 =?us-ascii?Q?CepM/TgkSyvnSgyk2q6EX/PQ1aMxouyqbT6CJEtCkQb2XrpJ4Lpx79uR2lmp?=
 =?us-ascii?Q?1xwlltF31XqJkLcvX9Xh01ymc5OgTZMRaBK6G3YCmH+UpGeEsAkVK91gn2vR?=
 =?us-ascii?Q?RYBhOC2Y+k1D9lmptZHxVFgLU8MmUtDtR31xFMHus5GJUb74H3w/SRg+gVNh?=
 =?us-ascii?Q?YYHLxEtD0kgmfo0qkF/YZnrGHLLXTupXEsjPLzN0OUtVxiu7+JBtZEpfp09s?=
 =?us-ascii?Q?/xPj4JzDszoUS2n5nFjokBvK3ZUSUKLDPlenCcX+DsdamFqoh1ZQgGd+7AZq?=
 =?us-ascii?Q?UDDi9iRYMt0AUKbAsiGtpfUMkcfLgBiTfT86cRY6MhikHKHtINMEJt1qI+/D?=
 =?us-ascii?Q?fnz3MdlJDMvD3GbUkLdtBfXWhIeLnw9VRsLKi7BgPwFl2nIz3Wm9YBswczPu?=
 =?us-ascii?Q?zIQ5OGY+PSG9U+UTB23pMn1dXsPFtb9Ndy1/TQ9lbHJKDK0mrL05nQ8dBXei?=
 =?us-ascii?Q?Uswacr5WFj9L3ysFJkXXKyXHNFYziwq472oPyvp/YxshdPsYV4O0aXe+WdaO?=
 =?us-ascii?Q?C7YWA/gTjSHvgxHlIoDxLiTAN1Kl5UPnHlh2f3N5/KZ6mhv+4puipO18k83W?=
 =?us-ascii?Q?5JB7LxOwep4x5zVqciemZwWhZgJJKpliZ3ksBDPiLkzPJonaCpxTh8PW+w/L?=
 =?us-ascii?Q?ehzb8IS9ycDgFgfY/45XKJtQHAIhZ6a67/KXV+Ea4/Xx52+k1ZAkqGTCCNhS?=
 =?us-ascii?Q?T2QE7fvjZssbs/gPmwJc5OfLSj8x52+tB9k6vsyZud9Z5SZT2qN/OSk5q4Wg?=
 =?us-ascii?Q?RRF1kbtZmH7YMrvpEwPS1KG6NuHW+Ipy0az5Lherv0ly+SsZzQHpetLlilEe?=
 =?us-ascii?Q?eHr81LEGAlTFZQAzkI8Kw3oGHlkUIAb1N0Ynf5dP5XR+ftuy1UrNyX1uA8vC?=
 =?us-ascii?Q?zar8F9Qhh6M6+UILa7alYK9VuHHGjU87mDrV1FtFWV9yAxKE4aqggLp8CI1Q?=
 =?us-ascii?Q?yhZu5m+YyN98WEK9audDpz/x6u+KRnYfs3+o2QHTETUhPLRbCLzV/wdTvzFl?=
 =?us-ascii?Q?0TUh0tbSXFhK1rSi16QRyh8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c14f7147-5eac-4eaa-a47b-08dd045d952d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 03:36:53.9103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: us2t5F7/uo5mQik2n/M5+D9218EFXYUKlqSTvOCSJMMT15HNlKVsAQgxD9sqc0S94lZ7x0UeqOx+irQpIJ9Cl1QAFdXcwz9nZtzT0SBdyes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB10338
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

Current code assume that all (except last) packets are of the same size.
This is definitely wrong. Replace SACK code with a new one, that does
not rely on this assumption. Also this code uses less memory.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 200 +++++++++++++++++++++++-------------------------------
 1 file changed, 86 insertions(+), 114 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index 3e3118de450..724536cb352 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -38,21 +38,6 @@ static u32 tcp_ack_edge;
 
 static int tcp_activity_count;
 
-/*
- * Search for TCP_SACK and review the comments before the code section
- * TCP_SACK is the number of packets at the front of the stream
- */
-
-enum pkt_state {PKT, NOPKT};
-struct sack_r {
-	struct sack_edges se;
-	enum pkt_state st;
-};
-
-static struct sack_r edge_a[TCP_SACK];
-static unsigned int sack_idx;
-static unsigned int prev_len;
-
 /*
  * TCP lengths are stored as a rounded up number of 32 bit words.
  * Add 3 to length round up, rounded, then divided into the
@@ -69,6 +54,11 @@ static enum tcp_state current_tcp_state;
 /* Current TCP RX packet handler */
 static rxhand_tcp *tcp_packet_handler;
 
+static inline s32 tcp_seq_cmp(u32 a, u32 b)
+{
+	return (s32)(a - b);
+}
+
 /**
  * tcp_get_tcp_state() - get current TCP state
  *
@@ -267,6 +257,7 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 			action = TCP_FIN;
 			current_tcp_state = TCP_FIN_WAIT_1;
 		} else {
+			tcp_lost.len = TCP_OPT_LEN_2;
 			current_tcp_state = TCP_SYN_SENT;
 		}
 		break;
@@ -353,6 +344,20 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 	return pkt_hdr_len;
 }
 
+static void tcp_update_ack_edge(void)
+{
+	if (tcp_seq_cmp(tcp_ack_edge, tcp_lost.hill[0].l) >= 0) {
+		tcp_ack_edge = tcp_lost.hill[0].r;
+
+		memmove(&tcp_lost.hill[0], &tcp_lost.hill[1],
+			(TCP_SACK_HILLS - 1) * sizeof(struct sack_edges));
+
+		tcp_lost.len -= TCP_OPT_LEN_8;
+		tcp_lost.hill[TCP_SACK_HILLS - 1].l = TCP_O_NOP;
+		tcp_lost.hill[TCP_SACK_HILLS - 1].r = TCP_O_NOP;
+	}
+}
+
 /**
  * tcp_hole() - Selective Acknowledgment (Essential for fast stream transfer)
  * @tcp_seq_num: TCP sequence start number
@@ -360,106 +365,79 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
  */
 void tcp_hole(u32 tcp_seq_num, u32 len)
 {
-	u32 idx_sack, sack_in;
-	u32 sack_end = TCP_SACK - 1;
-	u32 hill = 0;
-	enum pkt_state expect = PKT;
-	u32 seq = tcp_seq_num - tcp_seq_init;
-	u32 hol_l = tcp_ack_edge - tcp_seq_init;
-	u32 hol_r = 0;
-
-	/* Place new seq number in correct place in receive array */
-	if (prev_len == 0)
-		prev_len = len;
-
-	idx_sack = sack_idx + ((tcp_seq_num - tcp_ack_edge) / prev_len);
-	if (idx_sack < TCP_SACK) {
-		edge_a[idx_sack].se.l = tcp_seq_num;
-		edge_a[idx_sack].se.r = tcp_seq_num + len;
-		edge_a[idx_sack].st = PKT;
+	int i, j, cnt, cnt_move;
 
-		/*
-		 * The fin (last) packet is not the same length as data
-		 * packets, and if it's length is recorded and used for
-		 *  array index calculation, calculation breaks.
-		 */
-		if (prev_len < len)
-			prev_len = len;
-	}
+	cnt = (tcp_lost.len - TCP_OPT_LEN_2) / TCP_OPT_LEN_8;
+	for (i = 0; i < cnt; i++) {
+		if (tcp_seq_cmp(tcp_lost.hill[i].r, tcp_seq_num) < 0)
+			continue;
+		if (tcp_seq_cmp(tcp_lost.hill[i].l, tcp_seq_num + len) > 0)
+			break;
 
-	debug_cond(DEBUG_DEV_PKT,
-		   "TCP 1 seq %d, edg %d, len %d, sack_idx %d, sack_end %d\n",
-		    seq, hol_l, len, sack_idx, sack_end);
+		if (tcp_seq_cmp(tcp_lost.hill[i].l, tcp_seq_num) > 0)
+			tcp_lost.hill[i].l = tcp_seq_num;
+		if (tcp_seq_cmp(tcp_lost.hill[i].l, tcp_seq_num) < 0) {
+			len += tcp_seq_num - tcp_lost.hill[i].l;
+			tcp_seq_num = tcp_lost.hill[i].l;
+		}
+		if (tcp_seq_cmp(tcp_lost.hill[i].r, tcp_seq_num + len) >= 0) {
+			tcp_update_ack_edge();
+			return;
+		}
 
-	/* Right edge of contiguous stream, is the left edge of first hill */
-	hol_l = tcp_seq_num - tcp_seq_init;
-	hol_r = hol_l + len;
+		/* check overlapping with next hills */
+		cnt_move = 0;
+		tcp_lost.hill[i].r = tcp_seq_num + len;
+		for (j = i + 1; j < cnt; j++) {
+			if (tcp_seq_cmp(tcp_lost.hill[j].l, tcp_lost.hill[i].r) > 0)
+				break;
 
-	if (IS_ENABLED(CONFIG_PROT_TCP_SACK))
-		tcp_lost.len = TCP_OPT_LEN_2;
+			tcp_lost.hill[i].r = tcp_lost.hill[j].r;
+			cnt_move++;
+		}
 
-	debug_cond(DEBUG_DEV_PKT,
-		   "TCP 1 in %d, seq %d, pkt_l %d, pkt_r %d, sack_idx %d, sack_end %d\n",
-		   idx_sack, seq, hol_l, hol_r, sack_idx, sack_end);
-
-	for (sack_in = sack_idx; sack_in < sack_end && hill < TCP_SACK_HILLS;
-	     sack_in++)  {
-		switch (expect) {
-		case NOPKT:
-			switch (edge_a[sack_in].st) {
-			case NOPKT:
-				debug_cond(DEBUG_INT_STATE, "N");
-				break;
-			case PKT:
-				debug_cond(DEBUG_INT_STATE, "n");
-				if (IS_ENABLED(CONFIG_PROT_TCP_SACK)) {
-					tcp_lost.hill[hill].l =
-						edge_a[sack_in].se.l;
-					tcp_lost.hill[hill].r =
-						edge_a[sack_in].se.r;
-				}
-				expect = PKT;
-				break;
-			}
-			break;
-		case PKT:
-			switch (edge_a[sack_in].st) {
-			case NOPKT:
-				debug_cond(DEBUG_INT_STATE, "p");
-				if (sack_in > sack_idx &&
-				    hill < TCP_SACK_HILLS) {
-					hill++;
-					if (IS_ENABLED(CONFIG_PROT_TCP_SACK))
-						tcp_lost.len += TCP_OPT_LEN_8;
-				}
-				expect = NOPKT;
-				break;
-			case PKT:
-				debug_cond(DEBUG_INT_STATE, "P");
-
-				if (tcp_ack_edge == edge_a[sack_in].se.l) {
-					tcp_ack_edge = edge_a[sack_in].se.r;
-					edge_a[sack_in].st = NOPKT;
-					sack_idx++;
-				} else {
-					if (IS_ENABLED(CONFIG_PROT_TCP_SACK) &&
-					    hill < TCP_SACK_HILLS)
-						tcp_lost.hill[hill].r =
-							edge_a[sack_in].se.r;
-				if (IS_ENABLED(CONFIG_PROT_TCP_SACK) &&
-				    sack_in == sack_end - 1)
-					tcp_lost.hill[hill].r =
-						edge_a[sack_in].se.r;
-				}
-				break;
+		if (cnt_move > 0) {
+			if (cnt > i + cnt_move + 1)
+				memmove(&tcp_lost.hill[i + 1],
+					&tcp_lost.hill[i + cnt_move + 1],
+					cnt_move * sizeof(struct sack_edges));
+
+			cnt -= cnt_move;
+			tcp_lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
+			for (j = cnt; j < TCP_SACK_HILLS; j++) {
+				tcp_lost.hill[j].l = TCP_O_NOP;
+				tcp_lost.hill[j].r = TCP_O_NOP;
 			}
-			break;
 		}
+
+		tcp_update_ack_edge();
+		return;
 	}
-	debug_cond(DEBUG_INT_STATE, "\n");
-	if (!IS_ENABLED(CONFIG_PROT_TCP_SACK) || tcp_lost.len <= TCP_OPT_LEN_2)
-		sack_idx = 0;
-}
+
+	if (i == TCP_SACK_HILLS) {
+		tcp_update_ack_edge();
+		return;
+	}
+
+	if (cnt < TCP_SACK_HILLS) {
+		cnt_move = cnt - i;
+		cnt++;
+	} else {
+		cnt = TCP_SACK_HILLS;
+		cnt_move = TCP_SACK_HILLS - i;
+	}
+
+	if (cnt_move > 0)
+		memmove(&tcp_lost.hill[i + 1],
+			&tcp_lost.hill[i],
+			cnt_move * sizeof(struct sack_edges));
+
+	tcp_lost.hill[i].l = tcp_seq_num;
+	tcp_lost.hill[i].r = tcp_seq_num + len;
+	tcp_lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
+
+	tcp_update_ack_edge();
+};
 
 /**
  * tcp_parse_options() - parsing TCP options
@@ -509,7 +487,6 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 	u8 tcp_push = tcp_flags & TCP_PUSH;
 	u8 tcp_ack = tcp_flags & TCP_ACK;
 	u8 action = TCP_DATA;
-	int i;
 
 	/*
 	 * tcp_flags are examined to determine TX action in a given state
@@ -536,6 +513,7 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 			action = TCP_SYN | TCP_ACK;
 			tcp_seq_init = tcp_seq_num;
 			tcp_ack_edge = tcp_seq_num + 1;
+			tcp_lost.len = TCP_OPT_LEN_2;
 			current_tcp_state = TCP_SYN_RECEIVED;
 		} else if (tcp_ack || tcp_fin) {
 			action = TCP_DATA;
@@ -552,13 +530,7 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 			action |= TCP_ACK;
 			tcp_seq_init = tcp_seq_num;
 			tcp_ack_edge = tcp_seq_num + 1;
-			sack_idx = 0;
-			edge_a[sack_idx].se.l = tcp_ack_edge;
-			edge_a[sack_idx].se.r = tcp_ack_edge;
-			prev_len = 0;
 			current_tcp_state = TCP_ESTABLISHED;
-			for (i = 0; i < TCP_SACK; i++)
-				edge_a[i].st = NOPKT;
 
 			if (tcp_syn && tcp_ack)
 				action |= TCP_PUSH;
-- 
2.45.2

