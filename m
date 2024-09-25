Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9980FCF9C71
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 01:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 620EE88B13;
	Wed, 25 Sep 2024 03:41:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="rlAYS/IY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5F0B88BF2; Wed, 25 Sep 2024 03:41:19 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20711.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A88C88B4B
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 03:41:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HF8eeKHQRNZp7QIWKlTl6umZ0pWcdyY++RKOuo5P6vbvziCVlxy1eyi7ZiaLx2cLJ9Mkbz5wIB7Ww3kqXhsihlBuxqLU2W2NuwQ6LGP3Z3D/vd7qRwE0xcHnWV3hRt3RsqLALyY4Ijg3MZVi3wcwOgHJJfydpUJF5eUOGju2JGwYdDKIwmT/W/6OI3eotAiNQVRNTF+j5BVSvU5zS4HUvfExQRQFHbAaJAjmC9R3q7BgHQPWaxGGZ9H4dOHwM7s9l1kScSWo/VGbAVYwpNwWmOD117nX4e1ka3IY2ndULC+nSrLtIc52/QST1D8HUsGjFmfxVugs1W5anhs8dv+tlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=Jyf/P9F2jOOrzXWUvIraAqUm/AjDckR+FCUbmvjPJf1Xo7A+1dEiFJuXn/7ud3Rvob3gE0a9xX7ItLCs9g4CR6VWi28q35OC3fO4ZVX88McojhUlvkXmndwpUCEb+ET/NN9RBM+/c/k6+4ZKmZCP3EfKiKPEN8FjfSyx4MsNdXlTY3PDedD+0ghAXTr8BkxMld2F8ECSW7IBxvyToek9OQVeo/r9fWicGXCpa2b2r0o9qWI0WiV0j/M5qbgequ6qEPqi8dfdedEZcW4dvQgkGXpRZ20JEjBBeHqNPgJIRdA595dIeNweOX5DpPcNk+4Wu846xeZ0CtPNEt6o0wMLQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=rlAYS/IY0B2x7avrW0to2lBg4WGG+u7AT/rMRvamxiAM492c+Uz6UWltmId5+ily4gIS6gCbxMaNsHJYiks1u2wrzJ371FULbHfRIzKLC9Yf4SzLMdwkjix+Z9/aJbKQOLrAhHN6pwOXm5rDSRgq0gKNpzBqgwhWTMCDSziqL6rYnKICDLVp6fvCFjrVMO42qIM8vwTsalsXDGNdQSB1eg1coJGRqGVlMHiUVN3m57yxEXBhAquxJ+WStHvi/WRMz7Fd15uWGdiJmV06zI5/xE1VzKTSbnTx1NAqcLp7LMCPzKYP2pqipjsO3MkyhG++lpW9sLka5O9HVTjVuMY4eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VE1PR08MB5645.eurprd08.prod.outlook.com (2603:10a6:800:1a6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Wed, 25 Sep
 2024 01:41:10 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 01:41:10 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v8 02/13] net/tcp: fix selective acknowledge
Date: Wed, 25 Sep 2024 04:40:47 +0300
Message-ID: <20240925014058.1679074-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925014058.1679074-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240925014058.1679074-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VE1PR08MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b60698-45ea-45ca-52b4-08dcdd0321d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|366016|376014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8VKyQexKf0oxwy1qr7+78YAmQrxhkZn0agR67n5xcN0dzKBBFg0y04OcJt7d?=
 =?us-ascii?Q?6sE/LBnJNOoZF18kGhq2n+WIHvx1Ch7Yu4rvO7JDFoSXTYK9EG6Eil6fRZwA?=
 =?us-ascii?Q?NtrGI0lspdgUfBjM27+RuiKopxfIdedo2mnDDqzGiNUNntMMbIHAfr79yUco?=
 =?us-ascii?Q?PBGqSvt0Aw13alIdFemY2Q4LJSqgDGkuaf1Z8yRJ0tk0UaomiVRuxBVR2saf?=
 =?us-ascii?Q?Rv0prHQuTEW/wKwz/CNBNBOx1uQpNHfjsI2LK7EKd6CO5X4zkoT3AO60SNrO?=
 =?us-ascii?Q?SwxHAizlr65OotWigkA79mUvI72LOea4r/PBbRnIXquaZhHjFXgxcowlLCjt?=
 =?us-ascii?Q?1HOXLz5dw/P7IjcT4VCEoRdfi8mNoaL17WbE5rS84HQbkb6BhhsGm8Z+/O3t?=
 =?us-ascii?Q?neMQlg6n7oIz+U1KhXhTnFJTD0o9mrtoK+hgF67FvxVkmevnB0QnKd8B6vhb?=
 =?us-ascii?Q?xRuEA1nq/yCq8X6HtKeMKL9iec2KvotwqdcR3BrllaGfCNlqmPzcsXPpRbAz?=
 =?us-ascii?Q?KdrLygcYhbaGB4Gx55eJmZx07mhqobYzLNQiq7mIIGERubtEsa+snGArYW8Z?=
 =?us-ascii?Q?N2b5ZsTlTlpGqSttwph+/rJT6aaqo1zQrh/x41tAtP3HnJbAR2Q47cdlXeZ+?=
 =?us-ascii?Q?eb6TDTZP1u5pyJKj65jl+/LNiR/8g/Mmo4g011Wy0m1pCdgQGX3y4vJYWxsa?=
 =?us-ascii?Q?Q5F7qBLRfGgo/Js8Tk6hO7i8d1IpSfm/Kyzu/wNwUoahRGsezAzUpB0VxXvv?=
 =?us-ascii?Q?OdRignjjC9FHS3xVjsShYnbC887H8dyE0f58LDGjt7DSkmok4NSAi13HCkeJ?=
 =?us-ascii?Q?32oXqwyF6scG6deZAiv70zs4kNNCI5EJTIxQZEkstkiDmFyXtOOhQIz95/Jz?=
 =?us-ascii?Q?6vCWyFouNSj/uyHJrvZ8A8cYpsMUrOa7Oz+hPvrMqety/4Bb03P/QeuOtlQi?=
 =?us-ascii?Q?LukYm4EmEhCrpGOR9NiJ0R+TfwkJZuCukj0LXrQQGlsYwazOm+gm7rpFs7ln?=
 =?us-ascii?Q?syvX7e9Wpzx0XsA688OLudoJAIazsv0FFU8wDhUQXM3DtjSRLbQmmvsxAn52?=
 =?us-ascii?Q?ubLIpBSa0nN5jtyxagCPD3Sc9ksP9H+RuYaK6JFNjRb7ws9/4U+vAn1a9UFA?=
 =?us-ascii?Q?KHScGCQKx1t/zbnvXj3QMyQZNKj0iLgJBqcYa1Id37Satv4p7TVP+jDSH4ma?=
 =?us-ascii?Q?JHCDoqf/GDR8bnXNTIbjjprO+hsx/Rkr0BHjK+BkoyIpYqzydDaS2CZc0WiB?=
 =?us-ascii?Q?XXx5JjsRHKxjEzdhAi8RsTWvm3j2Mcc7TWapkg/a4ncdjlasGh0IhHJmCEtj?=
 =?us-ascii?Q?n5Mf52u7Oq+mVvgtdmyh1qv6nmoTs8mE8fm1E73mu/ABoCYs9l1n8efgVHJ2?=
 =?us-ascii?Q?Db5MD8WrEqz4tbz9CaeEKhr950hLjNSsCUgQXpt2NrPq+YcSCf2VZPYEMKQo?=
 =?us-ascii?Q?0byDhmfXCrc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W44zeTrAMJYid/lIOZXtb/zVHy+b/IZyLrRAdOJX+JVpzqifZzAmvX0QogMB?=
 =?us-ascii?Q?wiRXmTkwEM5hgrdHu0G70pmIQMXC4ksr8AYsZYAAH5Hz8p+VWbJe6cX1h9yo?=
 =?us-ascii?Q?PDkHjqJnrfOoVlWsSKtp+qk3Yep+erAF7y4S9g+dNoYzhjbWy4Tz/oImRMa8?=
 =?us-ascii?Q?pEt4LqltIVweZyjUMba6OODDY45aVOCMD8fiTr2sxOp5RejhJriwUPG4qvqc?=
 =?us-ascii?Q?FaFnP6xA7DfIqwM/u9wiZRlUnrjxcA14qwEiXJsr/LWYUOMBljveC+C2K5IZ?=
 =?us-ascii?Q?hUgR/nkceKgShQwf40KE694DAf53OUAcZZMJ8CSDJlH70r30ujIcQE386mf6?=
 =?us-ascii?Q?3TOBjSmtmUXt6AAQREYm6h6dYqUOcW3fMawhRnHPUxJfJ5jwvRUOkRsLog0M?=
 =?us-ascii?Q?FzqC/SHqQZPQp1sZHXIt503CqMSUpZZ/QnvVIEma7Wf8euhIhlmdTmzFv2WK?=
 =?us-ascii?Q?lLQdirT8UOuUyBLT7VnuxqWrm9Qbu2kGPEK3uXyIXHiBemiL8Yl1n4p1sQbE?=
 =?us-ascii?Q?tw0I3fL0d1yDBn1LU/eR3ElfhwU0QerAnkpRLzgLMMdS4tYLsti4INEVa62U?=
 =?us-ascii?Q?fwecliR2LRQKNsuXiu30axN9hcNdVZy4UfodJvt09FRuxOu3+icMxi4QUkYK?=
 =?us-ascii?Q?NvL9kihpjQ2BsYFx9EoYDQBRXPce0j0iJsLLxpnjuThxBNnCsivJ2di2/1eO?=
 =?us-ascii?Q?/Nktd8JZl9Iq4FzSe28PWNjGcXrFWuJQjYI3LL9SQ+uSpvUk2cItECNNtP3p?=
 =?us-ascii?Q?zZcRg6imUplNxQ3QTb2K9LOEAIR7KTqd2KyeleskPEl75xlsAJhhpYtd3cbV?=
 =?us-ascii?Q?I2m2R//DaysPFG/XdP2QqCuJGjDjHB76wV0j6QfMxigoq7T2WKp3eyetXCXL?=
 =?us-ascii?Q?4V0lO9gvWLBUF77RQZmA9Al8iFFnUiLqvY4luFMUcsMvT5y48xq8PsHqylCO?=
 =?us-ascii?Q?J0BjLLi56OhZmGtP7IdEsxHVd6/n26dGhYiXBaO7HCjk8KBXvEBrBB3wYESX?=
 =?us-ascii?Q?Fxj7VO8toaesna7rYl+GRiKdDcBVWzib/sIvmz7l6GFk0BvGu9UYayWlc/wR?=
 =?us-ascii?Q?juDDTAkJsnumZMJallqF0WdyudH/c9BVh0+gz+GfDZzapn0or7vwuXr2BlOW?=
 =?us-ascii?Q?JJhMmYbel67KnRJz+H+j+jj0hHiuqqrsL/PF1Z1mPpYZ7MiO43XwFPQO0F/u?=
 =?us-ascii?Q?LaOt5v3z2R7/HATbz3u9lhJyusI30IExCYdgW9FWQUs4B2K+DjHWy196YF1q?=
 =?us-ascii?Q?bCI9hfp48quf/NXdkx0wRjZsa6pTRRsYdvC5Na/C1f3No9Tl17DTleWcmbaD?=
 =?us-ascii?Q?xsmjSuO2HEYp8ZSujwY8oImn9IMtxle1P/12Lc8u8SVTer87j7dYQvR54Poe?=
 =?us-ascii?Q?L1dinWcJOfWIbf8+TW+YL/0tn/NMpNDTP8Hb2X4wUr750M78y4st2qjPWMF+?=
 =?us-ascii?Q?/+PvQsx1KjBT3lKshcnqKIkoUHWeIok9l7v+tfMigCV7qyc9ErpMNWZqYMa2?=
 =?us-ascii?Q?QLkhCI0F4OuN3XmUvfE4bm54S8Xu/ixN3RWImmE4PgYq96is1bUqhV1zCcA6?=
 =?us-ascii?Q?Z1wX4yrzvEWYHe8c7ehAS1frMAwzl54Fkmsj3h+iT1L3TdiRC2gxRKGIaHam?=
 =?us-ascii?Q?bfvt+l/U28w73sUHLRVBZFU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b60698-45ea-45ca-52b4-08dcdd0321d7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 01:41:10.3336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8UzvvAIKAVpuyyIiPdjLLr6AkSLqM/xyIWbJmx/5cLgV5NYZtGo4lYL3rnYzEHI0PjGMSlmHkSP7fSDbDefQpezaDY7a6ymgUqVb9VNoUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5645
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

