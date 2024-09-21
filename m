Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229BBCF9C6E
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 03:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4B2A88AE8;
	Sat, 21 Sep 2024 05:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="jT9HudSh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 828C3889AA; Sat, 21 Sep 2024 05:44:14 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 808788863E
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 05:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+mCtN9IrNL2nX5BWA8fjd1sbDMDr7hi73JU32idAMcdR95aMgd9fKrTDhzA96QPXZSOteZkQGUnbbrOyYQAOcRGGTtmzSeaWSXh1XdMrY4ztlm00uTRnFRnDOeYNwkH6l2ckszzQOLWWQUbFwHgBapxS/EvrRbOfjJmtBbDb80RR8HE7WDb5fRo0C/rNkTAHNMsGnIiIIIHZO2pQSyR1Bs67bfBKp5mW8tHMfOZ5z/8AmxEH9DshhOjh3cFU/qphE8yczqw/zPPQnqTzXuQFCMhQ+TrsBAPAb0kO+mFxUj1XJgTbEMeR63B1WZXVm22vlbaHh2/z8hCqgxpoZHXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1W/OM+rApXuK7t+R9S3YJe3h+F7fm++LQERW7aZmpA=;
 b=edFn3VJaSwPviA9g/GKxxGxOA46a3J0CLuSEUvbf75J4FJgFzuT8YAyiey9gLcsIpr4l0FKZhh5D2IRbGSiGBXazt2xGQQBWED4toLTtUg27e9ZUAbsgvHdc/l7xaclm1Lqu+FE0xOSpOR/MhZCsNHcvZYFGW6uAJiiYVV7PFsfEp/+UWTDX1dPGApJui8Sg4eglxwb5xnzp1Pt3n/QqVLDSxpoHef+hxyg5HhTSutsFZY9JhPZRhI9GJHejAVQRRFVrctbKopoWVHMfcCDkfISKfZ54/2p+TI/byGrQYkZIKELWJvmf4EdYAapWS31q1/DQqh7cePUzNwFxdT3JIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1W/OM+rApXuK7t+R9S3YJe3h+F7fm++LQERW7aZmpA=;
 b=jT9HudShzBfHuCcGYrP3rW5bEHGbTAz/nAiReXxKFMKldvtVIoC7d0nLrDTi/BI5c6DbOgKnGe5+ndtT52a9xRD9w9Ei9r846hwL6MkmtpaGnk9PAQVzWYg+dQySzVxbWVDEkrcBAowULGh+tNi+uLsie+Qe0djN+CA/NOQW+L6EPIamc7bCm4yw7j4r25S2prYBhxWC8XnTINe88k7dNCQ8Fj7JtRzlfrYD7tqXjETJLbsz0VLZMxBfddZaiL4aiwbIaHLIrt6k9ADnAZILHlBBwmX1Z0M5riNzeTZixkdJu4eKLd5BsLvdrxE62uVTA6cUPnQbKHfrUETUB2HNxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9418.eurprd08.prod.outlook.com (2603:10a6:10:421::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Sat, 21 Sep
 2024 03:44:09 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8005.010; Sat, 21 Sep 2024
 03:44:09 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
Subject: [PATCH v7 05/13] net/tcp: rename ack_edge and seq_init to more common
 rcv_nxt and irs
Date: Sat, 21 Sep 2024 06:43:45 +0300
Message-ID: <20240921034353.1298452-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240921034353.1298452-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240921034353.1298452-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00004595.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::440) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0dc4ef-4598-4697-f441-08dcd9efa646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AldNpYfWwJty35uigZeCiTuRJ5C3FIkjQvLVCFO1Kj0p1soHyvNBjBx25NBp?=
 =?us-ascii?Q?SGszMpQoRaZpOLK19vILwKAhmYNYwJsgCwzganwu9Xls5cXecvtimsUshM4E?=
 =?us-ascii?Q?bpshrw5VVv0RTdCCKNa5w7LBO8m8h2fABIPJ8bRyjmyLeTOyLvQj9NFfRYFs?=
 =?us-ascii?Q?Cng8MKSRGwHtx3Wrj9c6uaSAla2ML8T7iH/ctOxlJdb4/KgMcyo/ZxT78U1y?=
 =?us-ascii?Q?PFvMSyJaL/voZ42D7ZyY/9aJ+Dgu0RWQyYLMc9+MMWmYdiRaAOv5r/nh/dYe?=
 =?us-ascii?Q?/OGRtOqqcZCMLEgh1vHp36Et3X0q8sf01DgV6k0bWItSyDPhj+wP1sBOJ/rY?=
 =?us-ascii?Q?uZmANVgnm70nX60WgVJDTpv1NnFrMCGmg33ze6e7ZeXlFYJO3Q3vzvuGJe/F?=
 =?us-ascii?Q?MyJ4XRlQvGGGJw7VJsybtVYb3FdA//305jjgeZ6BHTQx7nBARlpplajh1Bzk?=
 =?us-ascii?Q?PiPvFcVkSJOvb8tYLClRcUp+ETOSVnrFZEnEGQtpaubX53qH1C3rr7Rti1dg?=
 =?us-ascii?Q?pAwjYyekNnxhEKTnJiClnNzI9QV8uaU5lZ+HytbTUkbB0vVmc8hMy2vZT7+4?=
 =?us-ascii?Q?VacFoY7XSYd736IwtFJHljZtfsBLmZMjjvvU+COtG0uHFTfoXAmcmpg/d6k9?=
 =?us-ascii?Q?tDMQ9IdeKjREWQBTigQFRbu4elGFgp/HJl2iPXIg5qbqtWquJQqxxc7ZX42e?=
 =?us-ascii?Q?iPDiRvaSUfv0YabIlIqedctR6GfpBEMKrOlCRPa8lKAEsEPnV8pOvUK8vo5v?=
 =?us-ascii?Q?nVyI29ozao+1A5DUbdLg6GsYJIIDF458JmFbB82w+ovnA1zsU+fvbnFog76M?=
 =?us-ascii?Q?6zoNGa/4jwuCFjbwPwx5EHaqyiY1dD1aPVL7gKjoNKPclxJchR5AtwTy/wHe?=
 =?us-ascii?Q?si2sgsE0+mItAYOhB7QDcgBSpLvioPAlm46Aq+BxWeyubvE9b0ljI2i1XZi2?=
 =?us-ascii?Q?iNC3t/jscWA8RhEmTBXiMJiQjc2Cg7PjBx33hngI+UoQypUTBaXQfVKbQEsJ?=
 =?us-ascii?Q?pxHbzlyP+VaubWXfxvh7YrTl5XWmZkVL9Tmjb59Jda5lV/AW7SAgjLv/o9gq?=
 =?us-ascii?Q?aBvzWabMzGSalTJ6i4pJAIKWIZncXnYAPhNfewDD2kkwzryaAJeObV/GRa2A?=
 =?us-ascii?Q?a3n6npOKiEu2pNft4OFxPY2lgL1bGKS/Q3LBIaaLjVgQCgP5rvX+AIrrI9by?=
 =?us-ascii?Q?5eLxY7QK8T70BaNn4bQKTGeZRBopttPIXvivq2fqcAKEclOcHDzcJqOKEiOB?=
 =?us-ascii?Q?cn0yxg35/CoPNT93unyI3hR8EYo2XUyqX+qwPQHsGBjn5pSqKTTW6man8jKB?=
 =?us-ascii?Q?EH817mFF/2VA//byBcuiv7lWzZGdP+5/WBqhu4UST76ldg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PUlwgQ1EV2peo4J4zmDSn5eLJVyYOt/hsfqRoFr2pfp1zV218e8yNhTQH+yv?=
 =?us-ascii?Q?DegaKZteYhLKTn5ZFkQJAdnJHi4/hTeblgudJ87PTGiN5NVWg/8mUFWCvMMm?=
 =?us-ascii?Q?6EjtCWnkU7l14O1iipYNUwr14QfsoZUs1yr6G+qzEfU7rRQHTZ/u2Pm6L10C?=
 =?us-ascii?Q?xmTJoVq5bK795SIDofio57hIKAq6D1JUnvd9f4MO4ySj/P9FCvzAcG0rIAEW?=
 =?us-ascii?Q?ooyyFckN16wz3RZwG9NHiJGNLAQmGUAfpbCzjK5xn6tnWoZ+vfXGZc8t585F?=
 =?us-ascii?Q?xYss9Ug7dk3qQr0VRIBJTR/1uT3DHzotNh+pc2NwnlkmN2O8ScQi+L2oERzR?=
 =?us-ascii?Q?a7xKm7fnZ1pzL1tGl65Vtq4k/1TEapFcnPL185EuC9Xyskyv/yRbUUle/9K+?=
 =?us-ascii?Q?S29tNRP9HC+W0zBy3PYEZN2fkad/t9VXv44kG+GOLjx04pc9LnHccDQgBGTz?=
 =?us-ascii?Q?MpQ9SzdeyW3adubzExX0rson8xsIUdSr2qyaB3DgDIL2ZnCdNOPLNLa1ujV2?=
 =?us-ascii?Q?P3apzmUIoOf8BzZwmAz56a32eBG8Bo+29V4EyXbRTzewzhX18c53fCdhJI2K?=
 =?us-ascii?Q?anl08qlhUxzREIOTcRfEzt4jHqtQtY7r6sA5FDmqOXKTR/G9utG3W6QYTddw?=
 =?us-ascii?Q?W/aFOm71jL9L84Z6NRVWGHVKc0Y7jxR4u7WRMY3rNmbAIs/p2+pFxtqt0v1C?=
 =?us-ascii?Q?gXfCAEzwufi+CoUFtAjKSHaWY8+ljo74XZ57wk3GNT1YnWXKHopF9LLh4Z2X?=
 =?us-ascii?Q?qo0lpS4sVP0KzhZiHLRLnyLoH5aQp1SOVPdh35vUitC7ChcSfeawSFZUxjWn?=
 =?us-ascii?Q?w1ZrCpzqcGTuMQRdWjXi+S7moZnM+mFgr/Sv/10YdLo+nYksWnZO++kOTKhO?=
 =?us-ascii?Q?Dgl6Tx5KdV7O1lqfu3DUD5QUpFn1r1YwqQMLUG0080ENgEF7+fc06feJga+/?=
 =?us-ascii?Q?pJo/o+fhpPeugXqVv9ujnk18FU8UII9vkf9FcBNYGu/cmbAyBcMwDlwiXdpW?=
 =?us-ascii?Q?NtGel3mAIPRDyWG1QR3KB9Ef1UHSijsu4/KFC+YzcmwgO76AbSlyqfz+rR0n?=
 =?us-ascii?Q?+vOBshnV/Deq8TvVQ3ybNSy5vgeczgDalKRM49xjz7fgwUK9ZuHwmcXevZwP?=
 =?us-ascii?Q?oo7fhWNgbZ+IyqEn+R7uceu+muSExEL3uvha7uKscQbOJxFWcqE/kczb+1dQ?=
 =?us-ascii?Q?hymlznY5woZ+PPLIa/2Z9L3+K6v6hQxHmsMQ3RCtALJJC4zNYKufMvS5cHZE?=
 =?us-ascii?Q?NzBGElX+DP1cJJ8lxCoqQa0MO1ra2Yrg048WI+Ifo7d4vUWHNPvrPQV3S3V4?=
 =?us-ascii?Q?k5UggJ1EixCM71/0XgmXg1bvK8A7AAf181LgkyhCKRV3gdrvtWyjd5ZvjjlE?=
 =?us-ascii?Q?SBjZF/h8hYxph0HQrbCJeYl2xQ5eWg1SHYyyHpIf2MQZxQZCZg/xGlgNLAfQ?=
 =?us-ascii?Q?6jldl0uPTZRKHGMIYYpQIoZTNoIDSx/DLMedhYxkJMRBvQ0mXI/Mm211qQNa?=
 =?us-ascii?Q?tC1XTRXLq78KZS5Do7j3zkDiTgbljODQy5GqwX1KVJHU5Ii49bcyfK/h/09B?=
 =?us-ascii?Q?dBXdxV3nb4OxIe5ogut9dYnvaDkQjgjHZVy9wG/k+hN+P9Umonth78KjABgi?=
 =?us-ascii?Q?HjrPR4ey25F/9S1aYJHnzd8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0dc4ef-4598-4697-f441-08dcd9efa646
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 03:44:09.1211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcAmHuC6BFyIUEYo9iDwa/mC+AtuZ3vtm0rnc4dnZmuubvs1MTfhSW3SRbWQqM8Dyw2wL4hxZHcR6k7V9m6gq6SF48YF0SGJQ+i+nEX+qcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9418
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
Reviewed-by: Simon Glass <sjg@chromium.org>
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
index 0c32c5d7c92..7e445eaffd6 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -360,9 +360,9 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
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
@@ -396,10 +396,10 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
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
@@ -434,7 +434,7 @@ void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
 			tcp_seq_num = tcp->lost.hill[i].l;
 		}
 		if (tcp_seq_cmp(tcp->lost.hill[i].r, tcp_seq_num + len) >= 0) {
-			tcp_update_ack_edge(tcp);
+			tcp_update_rcv_nxt(tcp);
 			return;
 		}
 
@@ -463,12 +463,12 @@ void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
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
 
@@ -489,7 +489,7 @@ void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
 	tcp->lost.hill[i].r = tcp_seq_num + len;
 	tcp->lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
 
-	tcp_update_ack_edge(tcp);
+	tcp_update_rcv_nxt(tcp);
 };
 
 /**
@@ -566,8 +566,8 @@ static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
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
@@ -583,8 +583,8 @@ static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
 			tcp->state = TCP_CLOSE_WAIT;
 		} else if (tcp_ack || (tcp_syn && tcp_ack)) {
 			action |= TCP_ACK;
-			tcp->seq_init = tcp_seq_num;
-			tcp->ack_edge = tcp_seq_num + 1;
+			tcp->irs = tcp_seq_num;
+			tcp->rcv_nxt = tcp_seq_num + 1;
 			tcp->state = TCP_ESTABLISHED;
 
 			if (tcp_syn && tcp_ack)
@@ -633,7 +633,7 @@ static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
 	case TCP_FIN_WAIT_1:
 		debug_cond(DEBUG_INT_STATE, "TCP_FIN_WAIT_1 (%x)\n", tcp_flags);
 		if (tcp_fin) {
-			tcp->ack_edge++;
+			tcp->rcv_nxt++;
 			action = TCP_ACK | TCP_FIN;
 			tcp->state = TCP_FIN_WAIT_2;
 		}
@@ -748,7 +748,7 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 	} else if (tcp_action != TCP_DATA) {
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Action (action=%x,Seq=%u,Ack=%u,Pay=%d)\n",
-			   tcp_action, tcp_ack_num, tcp->ack_edge, payload_len);
+			   tcp_action, tcp_ack_num, tcp->rcv_nxt, payload_len);
 
 		/*
 		 * Warning: Incoming Ack & Seq sequence numbers are transposed
@@ -756,7 +756,7 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 		 */
 		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport,
 				    (tcp_action & (~TCP_PUSH)),
-				    tcp_ack_num, tcp->ack_edge);
+				    tcp_ack_num, tcp->rcv_nxt);
 	}
 }
 
-- 
2.45.2

