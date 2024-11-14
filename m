Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91539D637DC
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 03:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AED23895C5;
	Thu, 14 Nov 2024 04:37:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="G9HqUh8r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD391895B9; Thu, 14 Nov 2024 04:37:00 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20723.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::723])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C106E89584
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 04:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuJz3zHnNcO0h4vn7QVN9unAxALcfZFiNpTRlR4MPVFeEqn7hXqwuR4yNgp/9RQctxQliCXdru1P4C6it4aqk3B368PB9iAoWKuu5HrKdOxyqcaLye2SJG2UoMOiMZKXLYKMhFuISd8+9HrdDhn8THygu1gP6Aa1u39idjXljT/qll05WoiCHyhjEAAYdZXhqiofcyCpOFiENX4Mkmfdr5ZslzpHP8AKHPZicF6+nNTeJiMq+TQNypWlzUFu2wKPxVcjVcCVCzXQx+uifagKj5nVwSaLPCXQ2zS3dy1wwtV/NmIyeT+m4KbI9w1EvWv79nYcQ74BliD0v167yQQvyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1W/OM+rApXuK7t+R9S3YJe3h+F7fm++LQERW7aZmpA=;
 b=hwje30klXYf7ogQ7+EpcuEqjDsju0Gv8mq/+RszOV4/b6j8jPbJO8s706q0XdFWvEHGHzuNjR0Ym7XXy/UVr9aIfY/szZhx8FeKDNqwvZshFG4dKYm0FZDLW+aAuunESYY/raX4Yq/4hXbn9imQvOTwVTgWl/fg0FblmUB2SDC3sDbLkEKR6QvEzg3giinJeWabVRD7KL6llOXlV13yxVATN55KyxWXN0TZRvcuQ5D3Jmf5QCUZBihZxoI68D36cUEvII/3k+1DwvfdAD/U5yuI+P3LEBgUDV/49XPDohAoN/+Z/H/PaD6j6hfovfo4kYqF93X6OCVzL9qSVtUZ4/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1W/OM+rApXuK7t+R9S3YJe3h+F7fm++LQERW7aZmpA=;
 b=G9HqUh8rjhd32XKYp+qlxtBeQ16z4q0m3DcFOtJogOQIa6qzdBkmqS8h/NgAa63pRq3A1CeoOZjo48MSBx0w6mkfbylpdPSfoqbOB/YMzP9TzjnGko17Ur+TcVDb+hnjzlid/3/8JNGL2FQMWCM41l2WjG6FaeTo6dXfOGpZt/eV4O4fnce/WvKKD2Ivo8MWi4IiEDuR/etMAWy3FIh8gwC89UsfU+NYfiigX2YzJiwf/K7A4OATy/8BlLAtfBVEv5+dDqd+soy4K+bIxVXgwjKTqRYohVQbr7IPNocrb7B3VPLRi63DGMhVgrjOMxIh6iP0Zzg6E8EImhdgEauKcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB10338.eurprd08.prod.outlook.com (2603:10a6:102:30d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 03:36:57 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 03:36:57 +0000
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
Subject: [PATCH v13 05/10] net/tcp: rename ack_edge and seq_init to more
 common rcv_nxt and irs
Date: Thu, 14 Nov 2024 06:36:38 +0300
Message-ID: <20241114033643.623355-6-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: e1ac0e79-614c-4e28-30ec-08dd045d9749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WwefIqnKfR85D5FZrMSd0q6ivUBoccWpz/qb/fqbxcubwDd7vIA2WSyy4VNH?=
 =?us-ascii?Q?WJSGuFwxtcoKAhRi/jQdprl38v9WyyeTJh5jImsduS0moSYLkETgZWiiA7I3?=
 =?us-ascii?Q?RArr9jt7YgQP5Ye0Sy+ALyAMfzZ/IfWpE2jOQ+nXGYtXYk58UX6jIV86vpdf?=
 =?us-ascii?Q?7lt2fGOdQUaY6hrmSlbwuNgtm3nUPclWDm6pRUPbneO4I4iDYvSVESJmvkUB?=
 =?us-ascii?Q?Alj6idNoJIcqnYFGq/gGSxYYKF59gclnFwBrkTIzWbqPEJq9H03bSuHTr5va?=
 =?us-ascii?Q?PwKsnb6g0EzSF/qGnuw48meIvgvH19xo4RbPcis2dzve7s4kdo8hBCdF4QnR?=
 =?us-ascii?Q?DB4B/TZ/dMS/2bxgVFuCTJsAnPHzljMKl7ZArjg6TeQO/oszVzbrwyVS6lwh?=
 =?us-ascii?Q?jCclm3iWTVwWIljKhLh2+1Zo9zCGvCvWZxYcXUrClMk5vrDBrinr1MVyi6TF?=
 =?us-ascii?Q?0lofVDXuBConOJWbM2voihTwnHYyb9zSHWkJSwCeWN/IEXd6AprQQiNDycer?=
 =?us-ascii?Q?leev1GOcIYeefBCIiXFTBnWoxLfuPDwQulVqeMfsHuZ7K+VSmqhHNWthzakv?=
 =?us-ascii?Q?pSEeDxV40c4/5ek53azAjS/LR4O9GVCaMrW3No7JPRrnZB5H8DaJK1FqOqyx?=
 =?us-ascii?Q?IHjDMZ9TXU4ncSDtZm90U9s81Ywb1YPnXOHm8o4sLNWlg4xRru/mfrpZl0Fg?=
 =?us-ascii?Q?07wLR85CAPNB5eQftlrgMliBhwOqsuh5zstx/QhEergrVmecS84sdrxrGwD2?=
 =?us-ascii?Q?enL+X2OvbFPkaJfDQQbjkztjFH9JY3Cp7I+J2N9L8PS7qqKOdwWBAHHku6hF?=
 =?us-ascii?Q?jET8LylFstzLOSMEaItFQJzXpgsUSiujubcpCu5d/1f7D53vV97K6RPMMWQI?=
 =?us-ascii?Q?jhQRuJ2y5IABLm7YRgYEWFw245wXP6kDS1Ws33CQEfAbPTzCDJjdxKYjJkEo?=
 =?us-ascii?Q?f0TEP0JBZe/mXRZ5cyAhctKGDVd5L0Bvd0XBgiZYc3XZEvQYhtGlBOhL4yHm?=
 =?us-ascii?Q?hPXe5YTroQC58O5Em77Rr44+sSwrI2tPeFjIYGB3B+fRBisrSslZNY93AvkH?=
 =?us-ascii?Q?8+pg8uXVAlkMq0EZEYrZV4wWxTo+ZY5uW2cDo4qaxeQ2Gotfl5adXxKu/E0g?=
 =?us-ascii?Q?0StbeDD9qgZ2hancFh6Ku8HXf6j+wjD1UlY7TsvrrqDkaMdJR5nnu3LClElT?=
 =?us-ascii?Q?8GToLWaZRGBO04FcSsHCGkMrwlHemjXBWfBNcYYleIasbAPRb15SJ5a6YSuQ?=
 =?us-ascii?Q?ism9bXbQhJqSds8mRJdiFSh9LGP/aaeJZlblLHyWzVkVyYoHEGGeSupyQ12o?=
 =?us-ascii?Q?o/rfMqgpDbjOO91WE0V2EF+pKje4W2HuHQYRnE9RPLW9fwx4nyXQNua5GE35?=
 =?us-ascii?Q?beWhdJkfpHGUOvPaRpda7zq82JnY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T2Ss6iAU65P1k4Pvh2XcQMhYrgg8qRgnqvFneoCTCevIwf7Ev52Q2n/3EOGI?=
 =?us-ascii?Q?LzmVx8Ggpn/Mb3CDQcfk2Fl1OkpqPEI80ZZGKHY4slnHziru0HmQkhpYp/gM?=
 =?us-ascii?Q?g1xUR7fXgZQJ5DrttlhlT0W9UqILpZ8fezqcU0o9wttbEvCedgyTva3T85FT?=
 =?us-ascii?Q?FgTfIrxPQPWWN2Wvu3v0FoZQWXEB/bQc35NV7GCTgwvnfE/xwLONmIFoGHqj?=
 =?us-ascii?Q?mq9jRsELJA0NE/atQJeTsJS1wo+diE+D/GGPRuGErB8QN2ag1tVGfZrrGCdF?=
 =?us-ascii?Q?AERUDqFjUidRzwUMVABFt2BOhcl+ySQioaW1Q04ZTn+WkzlMAnwv8+oLsvoP?=
 =?us-ascii?Q?3VraDRjgjIZR+N1Cby7UGlniG/iUN2CKWNn75ZB+FqfzKL1UuumF5EHpQ38l?=
 =?us-ascii?Q?6FktzHj35yNeje19SoW4LO/mJ47rLLvC/x66lnUX2g8L/ZoSMdsoM7zDo46C?=
 =?us-ascii?Q?rBiATV6TJ0xLLUxvDPl+jYLyy9ZtUEXgSv02i8ywHSyt6+H+xRrBJrbd6bR2?=
 =?us-ascii?Q?AqoMXgRafQJp4svAtDFPnkVmQ1DYKMiOPg7VzVoOQgk7hVUgPYlUWAtoansk?=
 =?us-ascii?Q?n5LtsjZ8OqQm7Gh26oF011gA5/lALws5TPMzY9zfphTiXleNxvTnRXxR/1Kb?=
 =?us-ascii?Q?OqP3BFFXwscUEifcg95/CSDIjCB8fV3imJMcyfycsbBX1DGeQsQefimjj4GF?=
 =?us-ascii?Q?uPYjGTQrrBWHH2fkRjEZHpFuZx7nmTi2+53fHmwsMEkm8zeC+OGH6aS1fw12?=
 =?us-ascii?Q?MHnjSl7BJ7pQRKM4QkEfxxtxuLeoYExMlsCXPjZhOxbAMRjIJ8ix5Xd+xqEV?=
 =?us-ascii?Q?LJqQgdm4Hr56g21gGQbfO3UDLLyOtujMjxChjAMOE3DoNG0FRma1hPuvE5V5?=
 =?us-ascii?Q?pXaV8JlFEwMUoYFzNbqlTCLg3CO837tthGnLh49H6wd965gKay+S5C35lb8T?=
 =?us-ascii?Q?XneGNMjgbs+gSg2IJUk6NSzx/swjTjkDSZ+NtXN7RNVvTlPjhGB0n7iopyFN?=
 =?us-ascii?Q?W1RMLqPOkINR46uXOOJ4FSLJ67u8DnWPMTgn0AidFMNLdckuK9quAjMMCo+p?=
 =?us-ascii?Q?VuqOUi2ysLij/FCWonvfCKFleHhnqO5YqyuBCqyp/dhfBnozSJq8KHlZ7Nsx?=
 =?us-ascii?Q?ikDDTUNd/rxfzcNoooC8fq9GspbiU26agiZkcqu54tBa/TJnO6in50RippoX?=
 =?us-ascii?Q?DLzWPW8RRYlqY7jiXvVNMDeSlHXs4Xb/JEL6Ky039OigSh97JuzNdHfLaHSS?=
 =?us-ascii?Q?fB0PhTBelfdEKtkHgNWdUlFS3Cf/hfJEw/x6JSzSREJCY6woCfJE/uUbtVuI?=
 =?us-ascii?Q?6m3BpVot5JVrxkmi5nDWEVXPaaDKn2VNedNDycD1bWGOR32WBWPaYioVtUrR?=
 =?us-ascii?Q?sIfwk+zZ5tIxIj6c30cfXdnFHnHxMP+pC1INicfeYmzQlp2mOeTMZRhj4bhN?=
 =?us-ascii?Q?rtGDnz0WBJRMtq3fxmSpgN9ADp+AKprdZk49DtlJkumnz2thtScWlVWvsGoy?=
 =?us-ascii?Q?C9XPsLsgKc0sRfSbdtAQ1v5uUHzkSEnOrG8wp9tgT+mXf/ET5poU1Orw2jhO?=
 =?us-ascii?Q?j+kCkRferU52KOmzQ0XRW4FYdHadvOFm7rf1ImqKq+VTIo0KWmUztw02fcxd?=
 =?us-ascii?Q?zAfEeDHrXpFG69acIQj4sF0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ac0e79-614c-4e28-30ec-08dd045d9749
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 03:36:57.4640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJXmM6dQFepvBtvZ0XPRiEFSAz6qysneq9UISXVuCt5Ik0LE/jDapmg1Fy4MxyYla0H1c6hhX+93YYYewvhXcTUzgbnXVl6a+EIs9N49Svg=
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

