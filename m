Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55093CF8870
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 20:57:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC72A88DC6;
	Mon,  7 Oct 2024 22:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="i2lQbxGW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34F2D88DB1; Mon,  7 Oct 2024 22:56:13 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B25488DC1
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 22:56:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfVC9haYke6RBEE0o1jQlTHidYBrSLLT/J7HXLe0NTak0f5bmDvbiqqY9Lg48TbP3gfqCYQH1seQxuIFtrLRbV1gw3qedvxyjtlLvm9bpJcFXlzDGSbbEhmtdyKH0ldzMs1PHoK0+lZ7GEtWa1JcxCaBZG9BPo6m0bE3kZhKLMGxnjFGMHJDWwCNx7KBb5aBsTJc1p0ktyu/tqyCei9km1qSRXLOxuP6Zsx93VRLxC9ob4DdJ2ztvQ1C5vV/DKZsylO2HteZCwmWW62Mnv93sZrrzQ9Db6ZwE/gEHfhsHwnlp/RTtz7Eey7+e4oKOrR3Q8sLc0/IczDLfo+Spj7iHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvSob/8MKXYwUczEzJQec62xlkHnKmYXBuQOX1JppUc=;
 b=INTor4KE94bYhE/8WpDtRDfz7OzKb9FzA24X593hD+PjOHfb4jixms4cmIptlRKzm8A2dUbWJxxA9pF5FxKt7twMatSvTw+vO5PSUC8zpVDWz2ueF82TThxYO0wmSmv9LMpPGUiKwCENcREY5mf8P+ddYq67yZ9Gi5En16OHPA/ELJ8Z1Du5K6vjW6I4D5QJKF+qK5rt5GATSvGHFef+DcHPTucvtRSMMPPpbSG3MWmUOSUgQURjtr9yZ7KZeqrORkbYyTXYV9AcZBnHv/3ibU9u7f1rFjVkpDysX4fdOh5+JWVZaar4CBORIdEUZ3KpWXdZWuVVnf9dek+qDE3qvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvSob/8MKXYwUczEzJQec62xlkHnKmYXBuQOX1JppUc=;
 b=i2lQbxGW7EpmZgjr5bx1TOdqhEaZ38T3FK7vRSavRTiNRKnzVQ9EvcUZYPafT7G3KX88Mo6wXDwUlLz8eQvjkLlwapBbOCXUb5mOoil0MxziIwXv9v/3e2A4XEKnYkhbhAweGxiNAtUzsUnl3X9xlLi2lmqT9Ul4f8gMu4pIT8af1zzNG2L5IrdzwwrG29Xe7knnZos/ce3B8NRWRBFibfybrdHdt0jYtPKT9BC67uV3IDDNd9SRzN4/rCWDA40tW2shkJlKFFMqVKr6S1ReiGlysGkXJnpYjdd7ks94Af9ycvoHpBr51qzkv51hamZy3rHSyiQNP1dNnRXmXShbCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB7644.eurprd08.prod.outlook.com (2603:10a6:102:262::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 20:56:07 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 20:56:07 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Anand Moon <linux.amoon@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v10 08/13] net/tcp: simplify tcp header filling code
Date: Mon,  7 Oct 2024 23:55:38 +0300
Message-ID: <20241007205543.1632499-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241007205543.1632499-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241007205543.1632499-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0394.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::22) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: afbbb24c-0387-4cc2-6e77-08dce7127738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hDohE9zAQQXzK2evNpeJzStyO5YPzy2taG2xwiacAKTg9gaSeXOhrs+fPMzU?=
 =?us-ascii?Q?Rr8FyEq7dp5jd6u8fz9ZHlAC4ESDW0UpOJ7LcYo7o0KaKDB6KSsEeVs5m4pP?=
 =?us-ascii?Q?Xb75bBJhTj3nWj5kmg8E2BUfecmdhxblBSfpEAt0bOS4QemIjmbb7O1LTZ62?=
 =?us-ascii?Q?sKGvyKjPhOBp8VgTic72/rXn84J7p0S1v94CLhiOaYq38G7M0G5VgSH5KHvQ?=
 =?us-ascii?Q?pbPmpp3+SOl8UQd+V+dI6tcsqP2B6IOICg8NiRwynhPZPiP5vUOPV1fYDU6B?=
 =?us-ascii?Q?rDJ/c2s45MBXNYsjOb6BM6d4avzQGIPwWwyU9ko9eb8NkTZTMOEnuhNeUXaD?=
 =?us-ascii?Q?bze2fMrFowkufb6teqijOZL1Ra0EFPbgQpTGdWLTHVG64Q+8LVa2FXzYv2/3?=
 =?us-ascii?Q?ITZ7LHouegz/ZTGKeZSQwAADTrHVYU/GCmlEtmXi3btuqgY0y97AaZeQFv58?=
 =?us-ascii?Q?JeqaOEf61ZYzEplTDdF5W7Z16E2lb0dg30biy8Cv+tG2UZG+s4xH8IZe+hun?=
 =?us-ascii?Q?Ms332c2k2BGuvC+T9lxDB5uD+uVdWCJxgvV5/jn/rlR5havWO4WplmesTxHo?=
 =?us-ascii?Q?lgxjyDVoiWpGFi4uC4Aw7dZIEGnDaPH875FdhIEB2tworaTw+j7+5kcxftT/?=
 =?us-ascii?Q?pIjunfmFo3DTFGI1if8XFo7A1Lgw150pJysu7fX0SschRWq5Qi/Xu1OFCDdY?=
 =?us-ascii?Q?WxyrI6HVUv6h2JWFDtvAlhyZGfCrp5tLr/oVob5wjqzoogYQBeCRLJJ2mVzS?=
 =?us-ascii?Q?sz9Ig9IQSAhD3eoaqJbYIuUa0iKDhqDfLE4lYvCWp1L7y/Yc8TzYFjadgHbx?=
 =?us-ascii?Q?GlLRzaD87THB2ayAz3e+nbN2DrEkaIKZpH2wVqWf8s6c4anyynjXtNHzoZXp?=
 =?us-ascii?Q?xjzqGhhS9qtxOI6Gqm5nXvR0Jy84LCKArtl4E8i0wN5Wkdrui0FMpj6mMiaG?=
 =?us-ascii?Q?icLUc36MAfFRKfUdwPcHy2JAmVYHY9q4At3UbnkzxIFTEUa+mfwO3DJxbIKT?=
 =?us-ascii?Q?9sz4yigXKe81G9F51lDTApIvMH4nqC+lk0gZnJgI+oO0xJ8Y43ON546eCLvO?=
 =?us-ascii?Q?i/AZHgoLUxQMojcvBTlvNdJ1J1anB4Pzxr/9fq3hIHQsIsCy0EzIQWzbHKBC?=
 =?us-ascii?Q?aqsqUF4nKEIcylm2qjWDyD+jJqP346U0auCTXF61V4383cHfmNZcDjgwzguz?=
 =?us-ascii?Q?t9lNSXz5rJGItmrU/v41E7zXIGI0ZgvoZO/kR/fGoBVn97LVSY/lFDXQLUrB?=
 =?us-ascii?Q?yTknh9ogLcvv446KjsQqKg0drHRnyLuCYHCHfWFTeYnxuYdvXq94D3LUNOSg?=
 =?us-ascii?Q?XgCAWgGeo0qmhAPhLJ6xSGEzX/qVOIc2AoaY895WFCAWMw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C+q98zcTSn05AY+VyMO4U1kJSHqeh8UKKUQ2XjDcN3M6sTrlbZAzRvpvOtVc?=
 =?us-ascii?Q?G+x7gDPcJmToKedtnsy1xBjJHhjXctsB4dszznfpIw+a7U/Wy22h5DGzNQAS?=
 =?us-ascii?Q?s8VdcxHz5WSpz9K9UFT6VcPq8ypgFXIzYzRvaJ107ja2G3dSlvvtPbamjj5e?=
 =?us-ascii?Q?0YgmI8rMFcSn+/TSR5KTDkhFDgBRdIrYXvlAsGGwUlx7Xf5SL78NGJQvx9Xh?=
 =?us-ascii?Q?FZ+NwL51xbE2zcSaV0sdpDRPb1arnhG7cO+snyYLfyZBdThxmWkUI83SYegP?=
 =?us-ascii?Q?zaIQXWbj8dWxQYCdPLRs8YstV0sgc6F8Cj0dibwBRj7pomC/f9T9Fh5ttF1o?=
 =?us-ascii?Q?W0aDxS1mtWoKGEHXf1nwtEdih6K7ZiEP0EdtUZNv3WNHmPf7d23pyZbxYPPT?=
 =?us-ascii?Q?VJlIbIDX4HgHjafNAA0sgdZOulL4rn7hpiItkWewpW8R3ZMEE8tB4TCo/VsY?=
 =?us-ascii?Q?JYSwgaPvxmzr/H36Copn45Wjt00qm8tNwBloUbdu9m25lHhDQuYlk9q0w2d6?=
 =?us-ascii?Q?V+U+CEx11Qb5WP2X7j61NvNJJ187Bn+WWZFKi9zfK22rPI7MoI9A2f9/1WRB?=
 =?us-ascii?Q?o8+KAsH9y4SmTAFrHPK/+mBn5KBw6JUCJwPlfAY/RpmRNrhdqZct+ivye0AP?=
 =?us-ascii?Q?jgws2pselN1rP+Kd5p/dK0Vmhk8fwCMOsIKJdy3RUeVEnNQCJTWYvDejnE2J?=
 =?us-ascii?Q?zR16jjV0eNmsDZ6Q4jri1wjQFtJ+jdtLUq1T7BfZKyJqxP360GJjVA9X/OCR?=
 =?us-ascii?Q?0mYO2amO1Z9ILH4BnMLJnu465SKC/3PgyE1BFwwYXSk7mClNWsWoyFNzys/r?=
 =?us-ascii?Q?8A5GT84IAypkf5RJ+IpuwYzu9rAT9hkMsDtoiQJhMzR07XDXs5uo3VhuqJk9?=
 =?us-ascii?Q?qcdnkd4qWwJ4UVe24wIcwlRuYeEqrdlNYWaGOaugDvBk/95U/EaRjf63lGC4?=
 =?us-ascii?Q?DqIJla9cxOcdyWcfPkHHwu70YmO3iY3dusN+II5UHUg30muGkogbFyg0OaN2?=
 =?us-ascii?Q?D3lugAPBiKdx1z0WzZ4cz5hmNxC44fVWeosZm1JoEByCgDoZnScLowXeicTp?=
 =?us-ascii?Q?ea08W+54JflSG5JdPA2kavtR4pNjqcSx87UsWVxaS2Z/gGOEbUUBiuH1PJK/?=
 =?us-ascii?Q?YoeAx22erdnyDd9bgimHd7AQWZsN6Hd9rR3ixxRD6q0RFmFfwgFW8MM2xWR3?=
 =?us-ascii?Q?p4P7+FVQhi+elH0ct91hdEWDKvx9EwfuwhCeb+23W4Xlmu50OZDjiz8jhVhi?=
 =?us-ascii?Q?D1bsQWr6vorM9f1o2iOGef0+eqGSEzQDq0AORLaveD+Hx3rejjzbimDW3mwv?=
 =?us-ascii?Q?2QlJ8mrzLbE77KLjolI2FJ3sJfNHfRjyHB4bxg14d6IkwjirQPIWM6HUMCKu?=
 =?us-ascii?Q?PMybWuS6enfwYOiL3Yf171Zcv9eCesDvr/DvozT99JJeOj7msWNv1MLtwbjn?=
 =?us-ascii?Q?v+S7yUkw+cNJWSM8FkBLT16Ok4lPtmHjtsIElUMfdvHSxPDjIStzs0ybwtkB?=
 =?us-ascii?Q?cpUBM7Fuuf8+yVXMsvWGPGDrwSvVRlHZIc0emoL0AYFtvhHMltlNVOYsQblx?=
 =?us-ascii?Q?QgzYD5jWcG+TcgEDOWJZ8AdrDYqmw5bbkvZxWay8dFxyinUYmLuLazHZiIuJ?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: afbbb24c-0387-4cc2-6e77-08dce7127738
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 20:56:07.6851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yR8zOLgAVt2ou7QlOQ53d6h2u2vqXpC9QgQe29Pv7gOwMFuhREFG2Dbg/Nkm5FScffpkizAnTZSn5eUSn2WDG89bxU+J4yuAFODwY1kIlYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7644
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

This patch:
 * remove useless code,
 * use a special function for pretty printing of tcp flags,
 * simplify the code

The behavior should not be changed.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 66 +++++++++++++++++++++++++++----------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index 6bb68a04c5d..2a95c44b141 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -543,10 +543,33 @@ void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
 	b->ip.end = TCP_O_END;
 }
 
+const char *tcpflags_to_str(char tcpflags, char *buf, int size)
+{
+	int i;
+	static const struct {
+		int		bit;
+		const char	*name;
+	} desc[] = {{TCP_RST, "RST"}, {TCP_SYN, "SYN"}, {TCP_PUSH, "PSH"},
+		    {TCP_FIN, "FIN"}, {TCP_ACK, "ACK"}};
+
+	*buf = '\0';
+	for (i = 0; i < ARRAY_SIZE(desc); i++) {
+		if (!(tcpflags & desc[i].bit))
+			continue;
+
+		if (*buf)
+			strlcat(buf, ",", size);
+		strlcat(buf, desc[i].name, size);
+	}
+
+	return buf;
+}
+
 int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 		       u8 action, u32 tcp_seq_num, u32 tcp_ack_num)
 {
 	union tcp_build_pkt *b = (union tcp_build_pkt *)pkt;
+	char buf[24];
 	int pkt_hdr_len;
 	int pkt_len;
 	int tcp_len;
@@ -556,55 +579,32 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 	 *         4 bits reserved options
 	 */
 	b->ip.hdr.tcp_flags = action;
-	pkt_hdr_len = IP_TCP_HDR_SIZE;
 	b->ip.hdr.tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(LEN_B_TO_DW(TCP_HDR_SIZE));
 
 	switch (action) {
 	case TCP_SYN:
 		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:SYN (%pI4, %pI4, sq=%u, ak=%u)\n",
-			   &tcp->rhost, &net_ip,
-			   tcp_seq_num, tcp_ack_num);
+			   "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
+			   tcpflags_to_str(action, buf, sizeof(buf)),
+			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
 		net_set_syn_options(tcp, b);
 		pkt_hdr_len = IP_TCP_O_SIZE;
 		break;
-	case TCP_SYN | TCP_ACK:
-	case TCP_ACK:
-		pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
-		b->ip.hdr.tcp_flags = action;
-		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:ACK (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
-			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num,
-			   action);
-		break;
-	case TCP_FIN:
-		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:FIN  (%pI4, %pI4, s=%u, a=%u)\n",
-			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
-		payload_len = 0;
-		pkt_hdr_len = IP_TCP_HDR_SIZE;
-		break;
 	case TCP_RST | TCP_ACK:
 	case TCP_RST:
 		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:RST  (%pI4, %pI4, s=%u, a=%u)\n",
+			   "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
+			   tcpflags_to_str(action, buf, sizeof(buf)),
 			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
+		pkt_hdr_len = IP_TCP_HDR_SIZE;
 		break;
-	/* Notify connection closing */
-	case (TCP_FIN | TCP_ACK):
-	case (TCP_FIN | TCP_ACK | TCP_PUSH):
-		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:FIN ACK PSH(%pI4, %pI4, s=%u, a=%u, A=%x)\n",
-			   &tcp->rhost, &net_ip,
-			   tcp_seq_num, tcp_ack_num, action);
-		fallthrough;
 	default:
 		pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
-		b->ip.hdr.tcp_flags = action | TCP_PUSH | TCP_ACK;
 		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:dft  (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
-			   &tcp->rhost, &net_ip,
-			   tcp_seq_num, tcp_ack_num, action);
+			   "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
+			   tcpflags_to_str(action, buf, sizeof(buf)),
+			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
+		break;
 	}
 
 	pkt_len	= pkt_hdr_len + payload_len;
-- 
2.45.2

