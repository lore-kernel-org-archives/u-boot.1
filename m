Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114FCC52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19B94889E1;
	Wed, 14 Aug 2024 12:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="0Xjcdb0d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEA0C889B4; Wed, 14 Aug 2024 12:32:07 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20703.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::703])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA355889A1
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtnQiKJFgj8lvcwLjfXDQ/Yvyl3D7PdcloRg8/6ieX9M3PqITEQRPK7/Z8zkbQeAjDnwtYJS7LB3AC9SJslRtnpaeabv/yi46JzXzkvHhDm8GW8pQbOeR1WHcMdCo6pe+0Me62O0L4khmEEtQAMRTmKytxS7VrPSWgEFuCDTBTlYMwANGWBGOcfN3huxaW7chpg9qXNl7RqrAEL8YhTBzYHTeZGtnL0qvAEyOha5O3n/etDWEeAVz+1FTQSHQ6ofUKi2J/4jU6NxEFXy4GH7CKh4DW7FLM8W9mqAExt2VYe3OMWBwpWSp1LS1OEW8jxg7PF++BUQkhZ0q/u7XCrx6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaHOLg157m/z9PpyW7nMAzrqOgDQGNnaZE3WYxpeOjk=;
 b=FeIHmYkcmuRQhYt1CidoWRrsx7B+8tgwL5PwlcmHEwpxrsWXIdWKx27EciNkFRfopHSgYBDVbYa1XtqvA4Zyz5Kun+xZvN3rJRAFzx1cT+V1elVUElAxwszfVEdVWSs9q3p9cJiXkvHRmKfsicM3wf+Zzvh8uSH7HJ8CMU/bZHGu8Dujp+1b90nu25DaqJtS4du7JaR421ANuG/2RtX5MfnT/QQu9hFBz1AYR2dDUtBhsJnyo75rf70PHlurXS9jQcNc+PtHZ6oY0kZ1BnWnVSrxyAXjvUWVt894r3LJ/bbKQWUEd52e0FDWfRY9SL2Cn1fWAIqbkrBy4XarOhfm5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaHOLg157m/z9PpyW7nMAzrqOgDQGNnaZE3WYxpeOjk=;
 b=0Xjcdb0d5uDb+FqjA2ILQ3Eelhq9nFsk5e77TDmAktoh7+iMJBNYr6vIbxZvB8WBp1swJHVsH5htaS1FW8hAfdlpaS8SiIhn0jhxZgcore3euymk/IFlRXWjZ9kPvusK3/76VsLa6Jbe2xTv5NC+X6bq443E9yJStIzfmMudlWQvBGSxTdwDHcjwKe+DqryoN/AxXAEQ2MfBHCRlHbKUK5eMaUJ92r/sDzOlLEkyj8nhltZ6VfJSjvbWmlJzfs+wkcv1v0Zh6+wZ8aP+xK/STryIhS5jnT0FzPgRW+adqKar5xbq7hbBas4QewqzM4DTrAZsda10zfixzWEAhQHlPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB8887.eurprd08.prod.outlook.com (2603:10a6:102:33b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Wed, 14 Aug
 2024 10:32:04 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:32:04 +0000
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
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v3 2/9] net/tcp: fix selective acknowledge
Date: Wed, 14 Aug 2024 14:31:38 +0400
Message-Id: <20240814103145.1347645-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0030.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c453865-5888-4424-ec1b-08dcbc4c56d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: LD32Q9CTP0MRWo8rqIMnKGoQYdXKqWkatV91NEWyYvcjOj0+9WdNGw+3J7yek4PAqq41z164a8a08LLMcUxyh2aAOBx5+/qbrILJ7LxfG25hJ3UR2R9lT/0h9hEsJtqOPM3OymsWw2rqhTcVoa5yAmSVg919gPYBp9Ws6by05OJdJV3gvG5X/95DQekS0YfqZDENRPokoPLAOr9ZIrIAoxyC0Mt4PPYx+f9x6fyIe0WAiUOSRNBQUTOxNnMNwtu7R+sWH3YGRxg8Mv5gM5JxhUB42dJ7o5fDKwth1AJkaEIIWKzRJccc5zF3W1DDxr8XaIxSeaxX3gl0ZE1uKf7SnRUpe1obsdx5//YBnEKyWLe8jHoPqc9Xr8zM9fN5ZJkE2C6bYyYHJjJfuARLnxR++OAW3JXILTuPpsHN9HFeE0aovMNW3+nPm9xTaC6gZIj3cFM0qTa6U6PJWGAob3iRBIYRPPpU5qsRWOywTOzLXU5BvFLI86ORrwDt4FWYriwiVh+HFt6+2uGh6XXx6CfBYNzMJm7F1aCungfHmTbRf6HkZaMvXY6BqMz0NQZlCKD3N9wPrL2ZCgmLoBFMi+8ASZAvf7UtwHLot/uryDPqUIFk12AB4PIz6aeH37NUwIi04uagKJl/YuLt8fdLjDvASxUYeGaNoiz5K8ui/i0pPJyHudw8V/6MHmw5YXIhR1dM0/nUadZMcTh4PFa/snNtHemncjQuflFOlxkFNi4M/kE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?utsH3AzGcn9Dw2IZtUkzOs9FhNf5RskRYZI/MZ1trn+MkGTixEAU26m3VulA?=
 =?us-ascii?Q?jegl36gi88DzKEj73VekcLWrhhdUcwaTV4PXZZUfhahFmi4iJ9Y3C0VKasJp?=
 =?us-ascii?Q?yV3AgeoZ6uSjzebWGj3KCSHV37afRuMbOz5SMvVUWb9QmAiGujL1UjXZaycm?=
 =?us-ascii?Q?e24ISHUHK2dzhE0c4RfWOfeN2iLLp+1vwNAlKHY02B488nmLHvvYKN3ZcmFq?=
 =?us-ascii?Q?BSWU6cfWmnsVhtIELbR2JJlmrx4CjhKbNbuAmMtgB2Z/IroIcBI5bm/u13h6?=
 =?us-ascii?Q?Q7spikGLX58cy3vAi9SKqiIVHQk2PIj9N+5sMVzezHyEA/e5t55EoG1yP4wC?=
 =?us-ascii?Q?EldreVmPIFwXYMLOPr0VIFEHs+XmnTStjmuMxj5FeDbgp9TK2bwers5FB0PQ?=
 =?us-ascii?Q?ST8cuN1tzbxTRyV/1+3v9NnON9TOUN5JOqw9NnkCL86LJ+NBs91OViX08GmU?=
 =?us-ascii?Q?DfHZc1vyJzjlNb8kFp5Il8DTZilTkdrWp9nLeNfHXUflGtULqk0xSqGKJpF1?=
 =?us-ascii?Q?GpGPwmAmOol6zjuDXgvzF4iP/06qHxx7hHMOSFmPf7JCtO/pwu2O34aB1Ubl?=
 =?us-ascii?Q?bzil8YNvLGYhX4AwuWiG3KgfNIuxVfjjp1f2Hp/ygkV/uioQI8lQavWS2EJi?=
 =?us-ascii?Q?u69xlSy5itK8Sc0Ztz/N7IunsidyxyCpmRJsD84jbR7vL5C+WcKIinH0mC5H?=
 =?us-ascii?Q?VzJwNWrTnjnuAAjmERxI+dYnTWsX6MPnEM/8V7kpzQ1qNPTPVnSG1mS/zNDL?=
 =?us-ascii?Q?x72DXzTwsOoz8DxNaET6jwYWUEGO1nyWys2zUEssw9VWKi9xENEpao3mo3n3?=
 =?us-ascii?Q?As4ogIVyKpeMONrg6j+xWHHW9OQvoCDOZUkeljavqbrHMHrHWw3kf0RmpevP?=
 =?us-ascii?Q?U2812OXXN4qDHv6Dzp77nJK0IBL4lagRqPIq8OxtVZ25zv9cRsGEouqhf9Kg?=
 =?us-ascii?Q?1zrA3WMRjJWv87eFzrtdDB8Bm5tiSWeWDJe2nzotsetJPoIBNXt2Ancx1EYw?=
 =?us-ascii?Q?teIgPBUXGEk7kBbmxHWLkGA3ksAhAdJZkPRgTDrRvIaKiG2J0yNXmOKTO2ay?=
 =?us-ascii?Q?KAFwtBhQ+q/n9dv5kW1CC7Uvs5vr5FmeSRyh464ZiNqncL/VHaqVLoFh8qm1?=
 =?us-ascii?Q?HkuoSjCNOOYjw9bHMjg57pderw31OWg5PpE2JGJLxKL7yQzY3A76yXguGZB2?=
 =?us-ascii?Q?J/VzVAOSJLTJijXnVVCo6V8x+gDvr1/JohNHmCi9VMzP/TEYFGIdePy/Pfs0?=
 =?us-ascii?Q?RHthkoYiVSbL4gd164rcbxw1d0kkoOmid1+noJiCFLlLyKUP8S6+UhxKSWkj?=
 =?us-ascii?Q?XETSww1PMq4CCXfjH2i+AM40HdBDmQxSeikqnFjx8nBliWN0/wYIs8FczfO6?=
 =?us-ascii?Q?qFwSA3wUUrW3kBftpnS/0+qwGdHdIBut7vHJ8qbAAkgmpFBUPWaYSrhHFL0M?=
 =?us-ascii?Q?sY2wt/RXLTkurM4yX4Z7yzWb0j9BwKxpoAnu5nAoBNoLLv5gVfXgdPXEIouc?=
 =?us-ascii?Q?HFzdzq0uTfY+BaYIa5W2F4EIoNBAzuVYqVfmK0x00uvufkxHAGm2QuSPKCgQ?=
 =?us-ascii?Q?K3Nj7wpjFTryo2LjTolHlP7YduwrHp6xY01rGU0HHvNnzm6fFSpq9JnjNDrU?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c453865-5888-4424-ec1b-08dcbc4c56d9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:32:04.3726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/hIHvmbTSkDM83+Msqt7Z6W67ML7r9Fl+IrLilJ6/WkUpHURTnpgTGWR9lcPxletqje35CL6c1BCQbrWm8HAiWtcKyfF3wufPUsR244nbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8887
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
2.39.2

