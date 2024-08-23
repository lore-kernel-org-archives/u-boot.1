Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A405EC5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE70E88BB2;
	Fri, 23 Aug 2024 22:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="MQIr4hLQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E47C188B47; Fri, 23 Aug 2024 22:45:34 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2071b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::71b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35B2688B5D
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:45:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjNYq8Ole5+Slkqjlz9wMlbMkfC9zBDn4d7y51y3dIn8xb0+l30MjQr+/bsx9rebjY/oMXrXJDzeSrxFeBnd6lGah/5cBsn/2rIwcIzOloUwuHil3vAhkPlqYUgc+xHetF2v0QpClN26IA/SGlYhtaUuorhIYiMHW7xoy1aLvLliEhq2eLEFUthXpg/daPprEqzn8BhR+VaSamNww84qtRrLwwHM7pnJ8ANwZhSIFmLN115OpGhDgo7EC1OklYDitsNHdtfL8e+5au/vzo5vpaQ2F7e6hoyd+LMPdis7ZKESkGODzG89+Wl6iRrQ9WhDOJmr5CugcyYpLgxbwp+ZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hahBnFJbV0odlIPukazF5oQypFtjvGWCc6V4kSoQSX0=;
 b=yvBov8bGmblQi4OVjtiJuQPGxV/R6QGJ6iYcWgAVPHKVFMgJzEu8AJi3PZV6hrz/+iFvNxhN+wD6zBxBQ/Z+TR9HmZHu+4qTp2vAI01NuhWz9OD+LFzER/xqfC6zXun54HgH0NIU/ALOdPT0C570sMHiVZit2E+EWSimxyAUFWED2GgPKUZazEib61PmtQ9i3j4u9iN4GqV4y8BfLsNI6AcsRfEB7H285oS7e/bfP0yaQgePsgKcjkEylK2DBLQQ6A1UDeolZcVmNHa/eRcEOzkGDRsXbuvbkseLRdyWlNpy+7U+o6uxrgflZoK1kuv3V/k0K7J+/JpemUgCDsoImg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hahBnFJbV0odlIPukazF5oQypFtjvGWCc6V4kSoQSX0=;
 b=MQIr4hLQpMFU9EhMP2NHb9eOUUT0Z5PwqLOErutN09SvSxAvr6/Gvq9QhWlFMwFnHdEoyU3i/mTxmfOQnLMFwilWIbvdKiwMmPiK/RMDNG+Wr1IUUFl6A1Uu29JOjxr2S2DqN1XJEwaQbx1/3PqajK35eNUJoqneuL8hw9b4mQSbe/4WcF2rUKXAhwiDpHYZln+bEDuXc7TH6KPlbRc22ulbBgB4gbvflUvyO0U//+0QweK834t1GKWlA99OswivPQZH5DIgHDAssOunRUfaUB72wMbCMd/RGZS1va8iUAOhptcPzmH299F4so2zZkq3gJ3MYHcwctowXALefjJ6Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB11224.eurprd08.prod.outlook.com (2603:10a6:800:251::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.12; Fri, 23 Aug
 2024 20:45:29 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7897.010; Fri, 23 Aug 2024
 20:45:29 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v4 2/9] net/tcp: fix selective acknowledge
Date: Fri, 23 Aug 2024 23:45:11 +0300
Message-ID: <20240823204518.1010194-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823204518.1010194-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240823204518.1010194-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0373.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::20) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB11224:EE_
X-MS-Office365-Filtering-Correlation-Id: a9235e9d-a15b-4260-2976-08dcc3b48642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OMCRj5qZnRoGaFBm+QNvV6nlNuyCBW+ourwJfvT39XseLxFVuDT/7VupQMeu?=
 =?us-ascii?Q?qVX+KUV7AvYxD9jU1+tAYfcq5h0EuaCQcRcuwOCBGGrXccf2u9VNAwE8M5nA?=
 =?us-ascii?Q?htjRh1JPBneWpt/0x8pWVKgiMg9c6TmaCIFoBaPIy3kkgG5Eti0GR2Z5UKy5?=
 =?us-ascii?Q?R896U4p10GMFN+sCka+i/Xz8bt9h/yyXo6FX1QQRzUMB2Oi3J7Z3T/ddENib?=
 =?us-ascii?Q?mO7QaFUsBhEHXdVDufXauvgzZtKwjBn3apQX+6h5RkYwB7TXoBf0BKALu0tQ?=
 =?us-ascii?Q?bLgMDOmkK3vpd4W1MmTBZi/ruyv9awhJvJlEi1NxJqFuGB4ZyYXoB4hyuVbk?=
 =?us-ascii?Q?nxgraFEApnQNzjEKbRN0rTOpAl0UOYaxJcu7Xsc/OgUf5hUZBdQAg6D8ZlB6?=
 =?us-ascii?Q?lkEZ/YdyYnY1ouiBq2VVm72AyBB98wO6LwWbC1U1oUjLRLxwzxOs/J4uGVNO?=
 =?us-ascii?Q?dPxOINZSpS1+4Rbq7kf07FPGASnByLS2XXT/nIfy/uA27Av/2qo4oeZnl0Jw?=
 =?us-ascii?Q?/K0bRfcDSjU9a4si2CQA0znHnzuaUwxdKzUQqzZ5D9LsIT32lILDvx7YCWqr?=
 =?us-ascii?Q?aG8qFIuK6t15Kso56ggwTV8jtMnDMYO4FIixvhpiMO5r6TMgL8yqToI+Smq6?=
 =?us-ascii?Q?umRNCIrZ9y09YOphT66l+OEzBG3d7WvXzVI+UdeVuKSNUxg/g4Z9cKuXwuxY?=
 =?us-ascii?Q?HIgeRbI5sODIHXutkEvPbz/CR+A7TDnxM7aNdij+6ZKRORg8xTtzMsVXrDUF?=
 =?us-ascii?Q?NgXz3RHtBkctIs8U2M9TS6aNI5X6qi3N+s2BoANuldwqvXvqNmSkT9BS5kex?=
 =?us-ascii?Q?X18HknqiErHAVvAy2JVCWyi/xatJNissNZZ+V+uNr+CRA40inEAwECHwIu1c?=
 =?us-ascii?Q?voBVitec36AUoAD6q+bmdVPN2HYFy8AYEQiIZfmxfGY6lBB2MacLHftbJqhb?=
 =?us-ascii?Q?/LlZmJrSarskwFzUKkIcKwwjaIRUX8q5oaVm++uELoT84Og3We8KtcQc/qzn?=
 =?us-ascii?Q?Sk/c/CGUmoAB1meVai79O01fGr2TdFbSX2q7cnB95OSbd84yWPRKRkX/2Q5I?=
 =?us-ascii?Q?1oGqiDMEslk4C0P1zy2drSGtMlZrJ8HC6MgoRXYMGETOMUwY+C2D1M/F7S60?=
 =?us-ascii?Q?0WgNhkQ1tEwo93/hldm7a0V8aLRFUtHYGwNDlIBEMJaT6VpK3Fn/1yUD4+4M?=
 =?us-ascii?Q?zEc3+CfqyWFxSFJNtizC2G7o2zS4WZaD90LjmLyxe1QI6q/Cfk6QmDmPpcvd?=
 =?us-ascii?Q?uS1Vbxw6ZVObeX9jH93iXaT0Td89GdV1RLWswmZDipKmRdrSXzFX5B2o3OrA?=
 =?us-ascii?Q?P9raABqO+5WSUgDfzOBEHU6dn8tpZlc5kThyHcaPuy7eDqpDZUYzDS1lEX0U?=
 =?us-ascii?Q?9CDhqEGyZ5PqIQWncZabTYDtP5ZJY8+5Xop1RP4mSVXJKw2zz3ev+RkNXFRS?=
 =?us-ascii?Q?sLutbCsX4X0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sq/T129edWeSVxVEYdkqXiNzFyy7iky18Fv4pLTqDB9x2tSWEPj1VShlaD6v?=
 =?us-ascii?Q?sMwbrYASxbWVGKIhMgnFIVCShZgDqJ3BIU80m7OA05vhnIRzvE27YiJUN9ly?=
 =?us-ascii?Q?enU/GWVUvraacdNgdy0cycZDUIoqS+ZwIh3LmxU4YnmdRuW21SEXEdlI4CTh?=
 =?us-ascii?Q?gyLC7DTJeLkVac8Xzdtl4wZXzeH9MFFnD/AGZDSEb0ya2q+0jk88hqz4t2j4?=
 =?us-ascii?Q?On0dccdV6sMSxwhBhZiN+o8xhRM8UeQvsnYfKU4tkOUqkU2pw+2bCTrWZKyy?=
 =?us-ascii?Q?VTDFPp/5tZP427GkvrIT5cHYAWlJs2l1Dgtowyo+8xgE7eheywU7jRI7S9zv?=
 =?us-ascii?Q?eV2mh8o92KznU9ialUEJ2mjWZlF02AqcUO60tdj/VodP5EeDeyrgDT+AHlCk?=
 =?us-ascii?Q?HjTBZiL9ohybpIxsWJx3NkmBV6itpJor/CZ/KvW3fqTKrHPWMnbSt5SXw8Dm?=
 =?us-ascii?Q?ekqPYT0AX/VAqbW4C7r/XrIWb8F+w+aWUMhK7jE7NQE0JUN02qfnNFTzCXiK?=
 =?us-ascii?Q?Gd3qWbS0OA6mwLr6VvTjSMyk+PeBAcp4VJzweCyhQHEQz+aQ4WTGTf3XIJYS?=
 =?us-ascii?Q?E2wkUKLEXqjIo3sl1iJpBaI1uQeRWCjJScjyaya5VdWzcAoXuYQTGr7perNw?=
 =?us-ascii?Q?Un760WX6P1vp16igbhCCv1B36l7UbF/88fwSl5omBE+b6T15/s2GebCeJAEc?=
 =?us-ascii?Q?mvBS1ARhgizgboCpw9cu0wjoeIzqWP5PUUmuzAdExYGxvx+HcF3NrsSAUp86?=
 =?us-ascii?Q?ACpz9YRP6+czeJS+x/b8ej6pDj7fmJyKmca6K0fi1MNx0UnWAZneY0JE6W6q?=
 =?us-ascii?Q?GMoRLJSOuyokER3IX5MTZ65jlo1NmXf7vUJqmom+lmXDtgnpVDK7IjwsQN/I?=
 =?us-ascii?Q?1iUlGCVC8KdWFwFLaHvxxsARUdC1Eb4yuarCXWX49KoGydj/7r3xgv3RBFbN?=
 =?us-ascii?Q?Pr9YVMQoOpY1jWQ4T42yR0VnxAxW5xFde3cjsbYD7hb+avpdlyp5PvDTU/yn?=
 =?us-ascii?Q?SdFlmiAPYPqyD2pubhEd4bn9bpXxHBcZK7TLb+mgVXnLiFVGXMbBNk5rNfa6?=
 =?us-ascii?Q?dcGG1g6OtLlayJbSLg2hNx/9vE2XcgIPhxKDvx1S23tyb1aZcgk9FfxOi4Yl?=
 =?us-ascii?Q?+Bv0oEl9iPOk4/MPaFIUBbETJPCVNe7EbS3GneXbywjEsip+Q6dF2jdjC8Ri?=
 =?us-ascii?Q?ApbrBxnRgzbPr5M60lCqBk0sQ4ivj0n78sw+mLtQI1s69+FbfhuslyjEsWZo?=
 =?us-ascii?Q?F5dsLmiw0itxZ4td/jkho9T7LZg+dEzelqTeoV6QFgqDOlpfA3DDS1xRA96K?=
 =?us-ascii?Q?pMyKafvXsjxClquF+36rZXVhy41cArCkvJRhYty+ot6n7ALw6LJALY4/Ci6q?=
 =?us-ascii?Q?1N7jDS/j0re0qBIArjgR3DHNNkEqeT4od9AgWysucpVzMwkZCQk7yenHnHPJ?=
 =?us-ascii?Q?I7qIzqX+sKtBta3ldaNQBy28m3hODSmdbVOwMzR0chGifKzpsGCdkxP0GzBl?=
 =?us-ascii?Q?YqW6hvTYvwlrccogQ0D0osQZE6/ORlHCXPXuITFQpBD3axc3RTpFGwcMdbjL?=
 =?us-ascii?Q?WWqnSeIu+eafbU8kGBHQ0nQrJaZnmbLWF9HRDzN0D36+aoXnZ1WALegB4cSF?=
 =?us-ascii?Q?59TDAcJTZyWbQD+tEHRprtI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a9235e9d-a15b-4260-2976-08dcc3b48642
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:45:29.5383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00jmhKW6g9B2VAUJZ9xdnhmq1nifWNgb0K/ri98vmIPws91BgmSuybEg3qS+F5u/exJ8lGknIDyPqqhyQitPZHlnrux4UEMLcrskNs7G9u0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11224
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
2.43.0

