Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF08C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 15:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5389B889BB;
	Fri,  5 Jul 2024 17:05:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="EyXHp4+0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51E75882E2; Fri,  5 Jul 2024 17:05:01 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2070b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57D71889B7
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 17:04:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsxiHjPcayeS90Voby9poH1GQfLTdtagYyENTQXrsGLY0VeHKfLWeqTQ2ET/gluQe2wg6X6EcxarsXq+tx+B0uz1yCF6oAIZk2lPVbYfLNhjNGKTirPzUVBfxs9RqTm1XdOkdvg3Jy/NqNo1UVjxss2uEXIMDonoi+kCN0lT/RD0iIKAUdNLX2fDjq6ddDpboNbecwLKQXDpHwAc0TxW2Jy/YCqGVko+sfvC2C/z0Apoz3ds3GO12R9EZv2FnNtZl8q4JqW6JKmxdcph+efKJI9/5xarX9biFCiSHuZW9CN5jwB/P/5qzJSDMd8dCuvzitwHz0A++v5KmEKJeHx4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z87m1CCws4W1CbX45YgGPLxJuULD4Mx1ARUXotMuGwk=;
 b=TEd00y3UOhe9pA6tGad8B/hbuLQT+HjuuQ5fjzKLZZ7hf5qVQ1l1fhd9G2fqTcof7FXAWJXTN5HbFbwdZ1T1MX7t2KrYi6v9JKV9G9rm0uelVcXhKDntrJhd3g2lUv/Xo8kaDI+lwE0JIOhUYXOhWnRYpURi0X7AAWRnFi5cHThRHAEc2Egg38duMgJyRJVZqLZIz/fG49Rn/xVegIv6xJjGGJBGk58rTR+G/x57HOVU2HzS5hW7c+B1C0WzLfBKVbGlLNksmXjfv9db6M2kFKTPO+GvLM5milwW3PqfuojBcQOsarDae6J5AQqJtMqzDcFHR51EFK3nZuhjj0yOWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z87m1CCws4W1CbX45YgGPLxJuULD4Mx1ARUXotMuGwk=;
 b=EyXHp4+0mWYK1AnLBu1gdX3qeCXxZgrXMK2dc2gNK7PYAfav9fTzKSyB2x1oOUNiYOlmKUiUIF+80+7hL+68tlM10kDKE7+EK/frxjp6xqoRUUzTbFv/9HUpK6FPRm1Se0APZkOgWkkindtAIs0UtBqCILr74+vHyStikccA26132KDnLz+X+74ltG3cbVcnbOEEZOvK8hiOr/jPx6ziesnVB0RXpH/AjWu9B4Cyi+lKld8ThEAd+FFIkI7aJFW8PQwyHQDFvPs1GxOOr71PI1pWGjJhPQUaonMQwMxfGWOMsb5q56duQeSNniQs8lc12BTzOzOV1D8OWo1I/RXIaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9834.eurprd08.prod.outlook.com (2603:10a6:20b:605::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.28; Fri, 5 Jul
 2024 15:04:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 15:04:58 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Marek Vasut <marex@denx.de>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 5/9] net/tcp: rename ack_edge and seq_init to more common
 rcv_nxt and irs
Date: Fri,  5 Jul 2024 19:04:27 +0400
Message-Id: <20240705150431.2274662-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705150431.2274662-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240705150431.2274662-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::22) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB9834:EE_
X-MS-Office365-Filtering-Correlation-Id: a57e4088-eab3-4662-4605-08dc9d03d5db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GM1FReDZ6exb22GHSuWGugNhXOXair93Y2efW9HIM0hY2+Hvxry2dFQFKu7Q?=
 =?us-ascii?Q?JD1BQHGpHTeR7N/eDx9z+WK3zB2thrzCHc1xoqbnPJCrSHmms8PCrnr9Q4Tu?=
 =?us-ascii?Q?HMYE9bSeIsi8YqUZFLZ1WsQvePUXwm4hv5/8zKFSep6HvjSHm3WuH7Vd94E8?=
 =?us-ascii?Q?qV+KGhwhZN5qIY6scDm5HitGX4b8mK2IPQK2XfLSQvTirHL9CZxzjTS5Llhn?=
 =?us-ascii?Q?cMiB0nVD5qinqaqPAnz1Q8xkVN6/l7bFNe8j68yZtxaFqxP15kjcSVUP38DT?=
 =?us-ascii?Q?bhrY2c3BWzXXy31vvcwCEviacj/U1Nmuqh11QxtP0Fu+ocV28eY/y9q0nz4s?=
 =?us-ascii?Q?CMjhAqmOKBCuOfuWqdHTdA8aECoKGAASbQV5CkkhBZxTucOHNE3gPo+rYzQ+?=
 =?us-ascii?Q?jMXq2CzkWZ67B7x3ut87JiZsmUNAjMpOk/uYBbyaJisgTjXAhArFf2YuvTIQ?=
 =?us-ascii?Q?8S9/xkqEJ+PHc+X6ceNCUo1imqeKi/S2qjBVziM24AJIKS0HNbv9B9lmdI6s?=
 =?us-ascii?Q?4/JxGBLp1P7yo4UCLJd5BdGLqXc2zhRsNOCMXL81j1M3HyPYC/0gjL3hhdkt?=
 =?us-ascii?Q?4dpnegz0onGdMT88TvFYodoHh/mmVB7K6NRuHQ1zQDZHjnb8by2hSz6sBUh6?=
 =?us-ascii?Q?0K52+ZYJPFocv66EKJvvSRdLtU0kUp04HBqgSiFRnWEIENLmnRP72Hqz3wxd?=
 =?us-ascii?Q?7iutN637maHZ4/gFLKbOv7TmLLmwgJgCdfa/3992djU9M1cNcajS23RZ0/z0?=
 =?us-ascii?Q?MaujJ+KF+THSFMBB9kV0NE72D4Lu/ELnQZq6w6IusxpBP9gquHotbgUPJ8nd?=
 =?us-ascii?Q?T50ThbRS7qHDvgX249rtCwWXukUyrB9vEFzefi/G/lD2Cav2s0oY4UEoBqb1?=
 =?us-ascii?Q?VuyBrJxWSLDErgLioys+3MEN5cDmqudKyApZMeHa9fD0rvQc0d/l2vvMnb3E?=
 =?us-ascii?Q?nw6yeoyoxSvci1eyL0HbyChOmPT9m+TFD0cX375iJ2L4Mq2niwL0R8ALYjDv?=
 =?us-ascii?Q?adQItZ6qfhOciBMcIloiBGHsxjfwkH6tivVl/tlg/xKY2CdmqQ0ZqzcwuhPB?=
 =?us-ascii?Q?OCaWXv+ZuzLgaOlEqnKCzPr3zdJmHJJLW6UJP5kMRxaeOiSz1OiMLl+Q1jQp?=
 =?us-ascii?Q?8wi8JjZEYThEjnOZmZgEw9A8ucGXHhmGt7jVougJ4YaTcOdvz0arZ3lpT+U2?=
 =?us-ascii?Q?mHDuKydSLbzhycHkZZEkxTYlHMpjor9hY2UQIlip8XCKfN2t6w/OM+wcLmMt?=
 =?us-ascii?Q?BpqQuTXcmKc/K/X+bXT7HjbO3uj/VG8Stt8JxvdHKsl7YtczGyzk9ic/lk2o?=
 =?us-ascii?Q?MBt/jkiavI5APwsNT18Y96+lHmyu09c5gLiJPvrC8uH5PshuBU0/zmmEYvGv?=
 =?us-ascii?Q?hyaAlEdMzv58nrjDKVjprwqOFdxP07+901wwpP8Fbd4L6ypXHpNZudg4ScGR?=
 =?us-ascii?Q?bKGeF850lBA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xw+B5wrEvUvHBMsnn3K7qnDdBAdDyJIfpjFtoYpwzbKuT0Jyy3he+TDS085N?=
 =?us-ascii?Q?jL0189W6wAFmKj0hbegikPFyisbM2r+qeK4BURHcasfsEbHWcru++diSL6Qt?=
 =?us-ascii?Q?BKDJj5pHOmfMrxIf1Xp3Oh629fyVo/hrm1Ae6q335CXVxcmHV8kUjkPDMmTM?=
 =?us-ascii?Q?hHfgSRY0rWf+PHDBO5dsZZQcq9scfEnlAltfZBe9zHP0M5kCMSofxdXYwBV0?=
 =?us-ascii?Q?lKOJALmB0EZTCHKLAf/zBYdny8jpT26T463C4E6EL5XmvPGQ0I1Yg0IUXYrq?=
 =?us-ascii?Q?aUv+pYc0ijGdGBPPfmWv3Al/FNU5FI89KlBpSPPGTa8xOcgbM16kxN2bJxca?=
 =?us-ascii?Q?21W92RsLiQC61u6lI0XaTtCkAqbTGSOM/e4dSyf8SQ7By6S5NNcYqMz+L5m/?=
 =?us-ascii?Q?eO14DYcorWoYMQtgqYDRqiPFrb38qF6bL50fvLlgFQJepuyNsjeL2ExHTYlE?=
 =?us-ascii?Q?V7KB91VHjOvy7pT+HrAQ23CTQyIkx5cUXb+xfCejbV5hDpGfV4OLlgUFnuiM?=
 =?us-ascii?Q?IKjqQpo7RIXxkfCLbnS5qXkJkvto0TogzP4FcJqsSi5JiJhzA6lurfmF2asP?=
 =?us-ascii?Q?q8AuxXcrStcbuxcNgwKUgKIEVPVrg/8J/3mapgHsFKf9LN52GYXWdEwOMEiC?=
 =?us-ascii?Q?U9XfG/XUAVYyiYxl7c1JYeBMld1NznqgNIzSDDEogA0bnG9nXklFXQ5l1dFl?=
 =?us-ascii?Q?7gOr2BCmzp2TawPwxBUwBt8/Rn/EoLBlFOYrRUUwxziLVgOuMQij0DIZJ5N2?=
 =?us-ascii?Q?yCbT7bKmwHP+aH8hBaK14aCNSeKqj3evH6C0B3CrErLoRo7bXR9UwF+eFik7?=
 =?us-ascii?Q?bwR3Vlykv0ktvsxxSvXZpTBHeaVWDFgn9Fl/jx5cElWExegF6fs+LhjFchtv?=
 =?us-ascii?Q?DPeH/LJJaSlHHXJKegtS03NjWT1kwDoEWa4vuz1qrhtTyL6usg6kWuUXvsZn?=
 =?us-ascii?Q?zBPJm0/cOzSbOj2cVavb4GpNBSi6i59dT/y9iISudsWGr2wfLcT+PF8KVGkk?=
 =?us-ascii?Q?xhdNH7pCG9ilxfQEkLeGsIjKnf5CQZ/nyYvAgXIZ9+QUMDA6K2BM1xYM5fE1?=
 =?us-ascii?Q?y7KbEBoxuiihvEnAXHkL8HwVNg1JvocB579/xcWrK5ZmdwjK6mQ8FK1CQvpx?=
 =?us-ascii?Q?AOtRceUpZCPNFMjFO1I7pOHzN2EPlS1IHRacW5ADal9AsO1W+GGYafjVduph?=
 =?us-ascii?Q?aj7TxD8jmHiuy8tz7/eBpQpkn41CwleMpKkLjg0EYP0LNxAXdjhMnEAOhIEs?=
 =?us-ascii?Q?7HdPStS+PnZEhI9YO2KBAK5v6BgaC2cwA/dU/uKYs1XiUgg0405j1MN7/xRB?=
 =?us-ascii?Q?TS1JM+S67udy1+qxJDJOCplobv1ZHV0+nV3ybNXI863HYd669Ip862Nz1i+p?=
 =?us-ascii?Q?bWiktVHrINC3M7sxGUNS9zEiqMp6zX7HOoDZX2XEGpVTyt4K/MMDkE87lyB9?=
 =?us-ascii?Q?5HJ38BOB4gvDlxQOjzhd4qmF0101mFQ/Qc4W3sNG8p1HLAQxds1f9GFa4SgG?=
 =?us-ascii?Q?Ln+394g7SzwanMXml+mKeyLPYwdk9PZsyGH8Km9vjPSswj7jhrtCkQh8fiur?=
 =?us-ascii?Q?LwGMyTPCaJ/3VaYYpmbcxcL4TOttLz3MRUTwLSmPrPCgR5zgP6Ok9Y8xnWj9?=
 =?us-ascii?Q?/doinOwO2QLZvesq80QxGYY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a57e4088-eab3-4662-4605-08dc9d03d5db
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 15:04:57.9667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlh5cxGTNX7xARYUDZlfI9kIkJoF4adWLcHqEEkzrKsn7MvlaXu9RRVAU2RL9Dp/kPoVqG7ZTBa6F8+/5co4qwSl7Y9hYvefzZvwstibZsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9834
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

Use the names from RFC 9293

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 include/net/tcp.h |  8 ++++----
 net/tcp.c         | 32 ++++++++++++++++----------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f224d0cae2f..0694af9d5b1 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -285,8 +285,8 @@ enum tcp_state {
  *
  * @state:		TCP connection state
  *
- * @seq_init:		Initial receive sequence number
- * @ack_edge:		Receive next
+ * @irs:		Initial receive sequence number
+ * @rcv_nxt:		Receive next
  *
  * @loc_timestamp:	Local timestamp
  * @rmt_timestamp:	Remote timestamp
@@ -301,8 +301,8 @@ struct tcp_stream {
 	/* TCP connection state */
 	enum tcp_state	state;
 
-	u32		seq_init;
-	u32		ack_edge;
+	u32		irs;
+	u32		rcv_nxt;
 
 	/* TCP option timestamp */
 	u32		loc_timestamp;
diff --git a/net/tcp.c b/net/tcp.c
index efa12c9e8d3..2a0dcc4e771 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -361,9 +361,9 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 	pkt_len	= pkt_hdr_len + payload_len;
 	tcp_len	= pkt_len - IP_HDR_SIZE;
 
-	tcp->ack_edge = tcp_ack_num;
+	tcp->rcv_nxt = tcp_ack_num;
 	/* TCP Header */
-	b->ip.hdr.tcp_ack = htonl(tcp->ack_edge);
+	b->ip.hdr.tcp_ack = htonl(tcp->rcv_nxt);
 	b->ip.hdr.tcp_src = htons(tcp->lport);
 	b->ip.hdr.tcp_dst = htons(tcp->rport);
 	b->ip.hdr.tcp_seq = htonl(tcp_seq_num);
@@ -397,10 +397,10 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 	return pkt_hdr_len;
 }
 
-static void tcp_update_ack_edge(struct tcp_stream *tcp)
+static void tcp_update_rcv_nxt(struct tcp_stream *tcp)
 {
-	if (tcp_seq_cmp(tcp->ack_edge, tcp->lost.hill[0].l) >= 0) {
-		tcp->ack_edge = tcp->lost.hill[0].r;
+	if (tcp_seq_cmp(tcp->rcv_nxt, tcp->lost.hill[0].l) >= 0) {
+		tcp->rcv_nxt = tcp->lost.hill[0].r;
 
 		memmove(&tcp->lost.hill[0], &tcp->lost.hill[1],
 			(TCP_SACK_HILLS - 1) * sizeof(struct sack_edges));
@@ -435,7 +435,7 @@ void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
 			tcp_seq_num = tcp->lost.hill[i].l;
 		}
 		if (tcp_seq_cmp(tcp->lost.hill[i].r, tcp_seq_num + len) >= 0) {
-			tcp_update_ack_edge(tcp);
+			tcp_update_rcv_nxt(tcp);
 			return;
 		}
 
@@ -464,12 +464,12 @@ void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
 			}
 		}
 
-		tcp_update_ack_edge(tcp);
+		tcp_update_rcv_nxt(tcp);
 		return;
 	}
 
 	if (i == TCP_SACK_HILLS) {
-		tcp_update_ack_edge(tcp);
+		tcp_update_rcv_nxt(tcp);
 		return;
 	}
 
@@ -490,7 +490,7 @@ void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
 	tcp->lost.hill[i].r = tcp_seq_num + len;
 	tcp->lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
 
-	tcp_update_ack_edge(tcp);
+	tcp_update_rcv_nxt(tcp);
 };
 
 /**
@@ -567,8 +567,8 @@ static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
 		debug_cond(DEBUG_INT_STATE, "TCP CLOSED %x\n", tcp_flags);
 		if (tcp_syn) {
 			action = TCP_SYN | TCP_ACK;
-			tcp->seq_init = tcp_seq_num;
-			tcp->ack_edge = tcp_seq_num + 1;
+			tcp->irs = tcp_seq_num;
+			tcp->rcv_nxt = tcp_seq_num + 1;
 			tcp->lost.len = TCP_OPT_LEN_2;
 			tcp->state = TCP_SYN_RECEIVED;
 		} else if (tcp_ack || tcp_fin) {
@@ -584,8 +584,8 @@ static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
 			tcp->state = TCP_CLOSE_WAIT;
 		} else if (tcp_ack || (tcp_syn && tcp_ack)) {
 			action |= TCP_ACK;
-			tcp->seq_init = tcp_seq_num;
-			tcp->ack_edge = tcp_seq_num + 1;
+			tcp->irs = tcp_seq_num;
+			tcp->rcv_nxt = tcp_seq_num + 1;
 			tcp->state = TCP_ESTABLISHED;
 
 			if (tcp_syn && tcp_ack)
@@ -634,7 +634,7 @@ static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
 	case TCP_FIN_WAIT_1:
 		debug_cond(DEBUG_INT_STATE, "TCP_FIN_WAIT_1 (%x)\n", tcp_flags);
 		if (tcp_fin) {
-			tcp->ack_edge++;
+			tcp->rcv_nxt++;
 			action = TCP_ACK | TCP_FIN;
 			tcp->state = TCP_FIN_WAIT_2;
 		}
@@ -749,7 +749,7 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 	} else if (tcp_action != TCP_DATA) {
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Action (action=%x,Seq=%u,Ack=%u,Pay=%d)\n",
-			   tcp_action, tcp_ack_num, tcp->ack_edge, payload_len);
+			   tcp_action, tcp_ack_num, tcp->rcv_nxt, payload_len);
 
 		/*
 		 * Warning: Incoming Ack & Seq sequence numbers are transposed
@@ -757,7 +757,7 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 		 */
 		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport,
 				    (tcp_action & (~TCP_PUSH)),
-				    tcp_ack_num, tcp->ack_edge);
+				    tcp_ack_num, tcp->rcv_nxt);
 	}
 }
 
-- 
2.39.2

