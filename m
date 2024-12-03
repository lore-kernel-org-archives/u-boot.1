Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22601E77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF8DB89698;
	Wed,  4 Dec 2024 00:01:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="yBCM2o0c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2212896A2; Wed,  4 Dec 2024 00:01:08 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20709.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::709])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFFAC8967D
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:01:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFmd5q223KRR53LK8bTWI/ulHZvI9tZx7Hky3eLVf5HxKakVC8bsng1y1Bs5MO8Eni8sJv55ND+nln1RGWpfSey/9Kzdiy49STGxQCaDkw2B4lrWGqZ6aniUP9L1Ra3zmFD37TvQD+y2fC/Hbeuj6WL/McjwqWjEZV7UxPWUK2boyO6lCFM7n0OWkOt4ptqTrtHeSLg9w526+tLtB+uhfhCi5u+NHjhq1t72Nn0mEnulKuQNFn+NQnszZQFpslmTW9rXQQrpB9V28pEiUZCz7Iqf+S7eglYpys1eOBJUTKmxgHnHt0cM1RZboisNjFkxU62cUn35rDzugfAwsCs5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1W/OM+rApXuK7t+R9S3YJe3h+F7fm++LQERW7aZmpA=;
 b=MJeVO9pA1jid5jarPnNj/0uGGFWkMR5HqBRkp/EHzL4PEyik4NYfjDtfEhQ2YaM29YVaYy3bhrHkYukKYU9HkDUusd8Usa7hm+SciDwbvBTV3eIbF1cK5RHYRkiHxfYxJwXj7V2xN5j4hpGqbUQ4UbStOUg1sEYv+1sDrUyslUd+00w/dtLmSzACnQr44r+TCJIAu9VavGvKZC7BQkxVPLonKmTUugVYiFqr2j7qgFlcXGeA/4C0sX27WLtMQZw4J9DRMoMQQT/2DS7RmcUPuWAvKvdQ72axFgenYMLJfy3UlYR/hoPqe1ZsrnGPbKxyglMjVJt5TeyNFtUxQT7XoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1W/OM+rApXuK7t+R9S3YJe3h+F7fm++LQERW7aZmpA=;
 b=yBCM2o0cRyzA7o+UJdi1fsCW8+TMksLvY8XYbF+6Z5yqnITJnovaOQDiT0rSkzTQyDW/zGbnFYIWEYlmq9+JsvFeIVXV6Qcb6X72XH6B45A++j7trAH4gN2NGJyyMr/MyGIEZodfkWC54ya/T3bKA38kmIy0AoszT/A/mzc91QRrdlFc9TdNAXKsw2HNAo3QhbbE2zRjCtGPHjKR/wr8qsRigZ89Qzt17yKwJHDWSemjbDBOxDI5hVp98DbdU+NmJB/ig3w6V5ABluCXisABGbjcuJdgzlgqFC00bIbIun4IDw02+clH6WGPvZ1G1LAWwbzRyqrr+sRYyyyW535uFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7611.eurprd08.prod.outlook.com (2603:10a6:20b:476::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 23:01:05 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 23:01:05 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v14 05/10] net/tcp: rename ack_edge and seq_init to more
 common rcv_nxt and irs
Date: Wed,  4 Dec 2024 02:00:44 +0300
Message-ID: <20241203230049.2677155-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203230049.2677155-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241203230049.2677155-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0040.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef8eda0-334f-432c-1771-08dd13ee5cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PODc+qXwjVrh2Ft26oPwIWVsdd1vefn5gpgmhVFOwsCsCTwRzqdEuMRgiPMA?=
 =?us-ascii?Q?HENW9BuyGkAwJeO5MGEnk6N5ietlagADsw5ViXQ9i21XPROn8YQAX+vMvwyn?=
 =?us-ascii?Q?OEZoSuq1RijrqnRjGcPrTg9Rlc+D0iYcm7oHW+CHNekqZW0jUX0xQZmj66ry?=
 =?us-ascii?Q?rlBxAylmQaLNOgVGF+uCxdQ/qHjci9OQocsix2ZnGUliVoOwIkTMaP12ogq2?=
 =?us-ascii?Q?N2OsKMNAVi0ZNw1Lgj/WhdcG4xCv3autHOBRRMnWXvuNPBGMYM1GJrTZ+qKa?=
 =?us-ascii?Q?ZElVX5dr+97TTPaLuRjZSJK7kkWGBFOErXIRCYMIt3+pUKbw95089LwNOeDZ?=
 =?us-ascii?Q?XpepDqLlBbVYjJ/grc1GkevUIqT41trGYzbGrBljtkaY7EAD0O+MQR39pWsF?=
 =?us-ascii?Q?b20vwHz8P7Ucop4f0y4NDqu57l48Yw7HiWXRLnpSfXusWDKRvXV2l0TRcrub?=
 =?us-ascii?Q?jmzSi3zZcoWnleNij5Zn7EFJIzePv2X9arGBwytE1nxSrfy4EFLfI+c2DJ0H?=
 =?us-ascii?Q?cpC6g5Qgo0OVR5l0dKBt6fpXj3oWMDkn7OfALUHhZOUTORVkgoqwkt+GtetM?=
 =?us-ascii?Q?A+3GDGBJ75NxU+U/6y8gXjJTYu8G/rCjTlpwK5y3BXh5sV5wzZirruqEHFKb?=
 =?us-ascii?Q?NcoydO0lXpOjEl0Ob/9AKpLJmsvEF7pV5nmnIm1nbj/EXtmChpfdRvVF1eyM?=
 =?us-ascii?Q?6o4X7HavhhFZua4rcYxPRuHTrjNlFbUrmmSctz6g3J6dcYVDv+N0YSse0nev?=
 =?us-ascii?Q?z57n6k6dN4tmKZnMRjc2XciFkMGbNhsMrN4kYwpxihw7AWOwKsFxozKdO+lI?=
 =?us-ascii?Q?BdcP3U8U+uHhUA3OpKe9fKRFVhs81D5MBJuHvvSXh11sDG9nRS7LSDR2n/qU?=
 =?us-ascii?Q?A0DdgpxR88YZSk2UXVtdBTIFWwnnnca3UclvLo9GrXkpL37iiPiSosHMUDhx?=
 =?us-ascii?Q?aK81vB22O3ssw6m6M8HwSQHC8xXPbWNmI97DmwakhnN3sRoMZKPysreHKvPS?=
 =?us-ascii?Q?6xygt+BiBW6HmUJ2wCOajoltQ4ZJFefO/qOkCydnglqHxq7A1M96go5lebSn?=
 =?us-ascii?Q?Dt6PJAdXvDshO4LU3hKPlFVRz071m64JXXwzioz8wtGJw6iFsHO+T1w0MPkp?=
 =?us-ascii?Q?gYu+Nyb2OKgOzkmFHP8sLW+pzEXYpeTi2A23fGdJxu0cQBdfhaEoDvwBrnVY?=
 =?us-ascii?Q?h71zVRywvY28R1xhhL+CL55pgBOf2UN1LdXHB0xHB0v9y8t8z5nrnDqjusbt?=
 =?us-ascii?Q?DI3dd6c5PTfZcgGoZmv1gn9abOM63Cu8jXviJPitDIxcpvUd7spw4Dtyswmo?=
 =?us-ascii?Q?3007XKEnUx2T81I3veURW3aT84eKe3PfdG9y8ZWkZLyPKIjDBAByGmilCZsF?=
 =?us-ascii?Q?aJKUz3XsR7jDTmackNLwrffmDMTd0+4L/dfDaCcey4e3J2jeTXlnL1cMc/7z?=
 =?us-ascii?Q?THw0DYCZmJY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ffLlNxSzX3i9VTteUt25+rzceeBzPG4tnaT6TU6LmPgueFCMhs9xQV7nXmjD?=
 =?us-ascii?Q?qf9jQavUXIqIfwjPHOGJGvzG3IrMS3nZ9S5yBFcYJ2MjE42TJtKVoTuQ9SSv?=
 =?us-ascii?Q?kWMZdqTWRmsYu+WuFqqR7lOIn1BpX+uQphhjEUva4xRcOyPfWGZ/TcFYrvSu?=
 =?us-ascii?Q?Q5JKMsR5Z3fi72EcMlDtz95J3kjfjuxZujAZMR4giKRIhPsr7rt22h+6GAyZ?=
 =?us-ascii?Q?FOpbPx24iPw+INFpr1H0v5DDt93ZphZejfzEOy8Sg8kYWgGHMQjyU3qsPDN4?=
 =?us-ascii?Q?+fX0z1cKPvO1DF8S8maXfvJJOXfs5yuL+/47oEeWgRbbL2AVR6vn73nYDzO1?=
 =?us-ascii?Q?Dme8a/PYNli8VKum/cRfhjQP6hQsAsCx/WJCefuSEz/jutkeNGGs2e/JzfUn?=
 =?us-ascii?Q?0jUg9c1VyFmizXvbfacR2IAZrJciIgHeYGaoWYG5hfTX0kzpw9QDPlJ19NiK?=
 =?us-ascii?Q?uos3psGMK/omyIhz/OcmIeqp+eJSrrAndW4P4gA+xojMMwVNjTaLiYJZ9078?=
 =?us-ascii?Q?o6cvOdayBL0HVGuqnGPYPDjiW9I3SM21wWB6gX+w4ne9dTzRFa6sJcIi1XKO?=
 =?us-ascii?Q?1gyO+jZuR/0j+QDMBlr0y5Gvc7T4WyTpdDKdVPBPTr7X3PiDcTLueEe3UhkP?=
 =?us-ascii?Q?01HWeFPYoMwfN4v3su3HLesYR5PD8c4pWb86QqEuBZt9k0pTeXdZqNlYLx6Z?=
 =?us-ascii?Q?7yoCZrJFuuPprrBUXt7bIv6Z8O5LeZax+F5mIQSWxykqnLVYbvWQeL76P/ZV?=
 =?us-ascii?Q?3j0YeuLG9W5hxK9m3q8p4kdRikonTuKdRuMmnxwnIWMF7vyDH01A5MBUH/uJ?=
 =?us-ascii?Q?PpoiOEJQ+UATtPQ+NQZnbQLGEwEHFUILMScr0WlLwQbaqTTGVNzVfyUHZcXV?=
 =?us-ascii?Q?dmnFV8OKinHbwlTC0Kq+JF34ViwkCagjNYBJDUnsbHnvLHheJSE/Z8QTrViO?=
 =?us-ascii?Q?OYNEXKzSqRwEtnNe+CqwpccmlvaOiIRkqGUrFaYB/nZlmeNUxjrbq04aPeYM?=
 =?us-ascii?Q?l1tSR9+3tJiZ+AC4Er5P0pVr9CqDGA0OZGCMB7rnoW8UL1oZTdueTW7N2JKl?=
 =?us-ascii?Q?AxxAF11NV2r1BisDUyOdA1Ef/DmYHg7BktgU8sVgdKb4AiWDHwmzLRnR/wso?=
 =?us-ascii?Q?I9ATd6AfBtmbhAaZ+FuGX386KtgFB/8taiuUkVSROa6qayAfHR8JVwwOBE1I?=
 =?us-ascii?Q?evaoou/hXxPQ2dy7tNbwFaZHnCPg4VnOFOkt87D+CL0zYlRHJYRFtB2P+b/2?=
 =?us-ascii?Q?G5kwuYRGe68dZ+seaZpnIjzI2FPScjVnbY4wRmVnTZGjk7rezye9X58Q3pnl?=
 =?us-ascii?Q?1ScUMH5+VQ1gz3ei9grsKRYqx2Byh0fYuXijvH7FwTX3BhDHGKUADNYN2G1l?=
 =?us-ascii?Q?eUKAXPIT6Yef0U/p5Sm0X2YhAh/UL9y/buzqZWUqpNuogStk/X5efe/DoJLm?=
 =?us-ascii?Q?RR5MoTzN/5ODaepZ58wcae+wOY6PdVCSgcxJOtNhIDZQkrgACG7rpNkKl7sS?=
 =?us-ascii?Q?pn/SUxfJ7FtiWk4je1HZt0t08GN0MciOjBLz0mEoA20t2NnJIvxSKHDu9nHv?=
 =?us-ascii?Q?mcsd8BDaRWBIykPdX5loIZFip2qiXO/CmQ3PZG05JlaP3KjrI16t425E1bx2?=
 =?us-ascii?Q?jtpr0mIlUsgs0/wknLjdX0o=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef8eda0-334f-432c-1771-08dd13ee5cde
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 23:01:03.9441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/AWdv0UouOKFMYm1/D768DqMCc1aL7iU4QS9g5tpuH/PxYsM0w06vp1vFvdYqNOSI1cIJ0Qa/mhOvu2tWqepA1a+MNXr8OjHJPFQ6yYM/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7611
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

