Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC599CF044A
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 10:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05C60891C2;
	Wed,  9 Oct 2024 12:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="G3Yhokny";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAEC5891DC; Wed,  9 Oct 2024 12:51:15 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2071d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::71d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 285CE891C3
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 12:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRX1VqUB1rIunqOmglKxkD2K4KG50AWXMTBFS2IdDl+T6gsiBbMj/bqiU2S30M3+BhWyAQ7rQ0jmA1Mmsl/RJTT79wsHhYhCl4DpG4shIUfW1/ZnRxoSd0EjG3r6qT/DUAMQBvUMgflygZPs2Fu4gWzx6QHfBoSaXweeT0eoaF0dkT6PEU7V9gMzB01wD+kwSjjhwBZ6D+VXWvhTAgS9mlDLdKFuK9eaQecvEuRYf2BqY9oOQTEt/GBULY51Ts2/2WbDJyqnOMbBTvo/KsCTZ0w+bvWGiQ/akAO5MMp6wpR81z+xRHhvue+wQjYindk8Xqy4e5uHHl1wHlQ/qiA6YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1W/OM+rApXuK7t+R9S3YJe3h+F7fm++LQERW7aZmpA=;
 b=o0rTCp3rUriP8J5O/LNOGYLUl+q1HVUhVSPvmvCgi45k0yzH1eTtYxWl/tN/CY9wVId3HEHvKsXOKgEHGIj+5HyOFVfkQeeR4Arm0qd3ePEnpb9cPqubVc5YmBGX04l5LUMG65XAOjT90C4WUm/WLEJs4qYLVoehG1BzDcAieLA7SPLJv0nBLW7Ec0odXeouohu/qiOptKoyC5Kz7h6nyjmY6G4AAvJUuoXaEmtpk3pulLKOaMw48qX7g6p6deE9zd7FMJo5Bt/JGpjzm40MMqw2I6NdOaZqTwRIkmsZS+f0+T44nGc+Rh+shCzVCXFenY20XOSypmngk0odytTDgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1W/OM+rApXuK7t+R9S3YJe3h+F7fm++LQERW7aZmpA=;
 b=G3YhoknyQSieStTz6qLyt0Jo0bgsm5VgMXrUrIkCbioURHnzgB6893LiabNW+fFQUi7TSdwiQl89oRYnMCURyJ/ldIgltjU7mxCQLgVNBr9HuOsTyrqCk27vaCCT6G8pyB9to6IXVPB+cXNew+WOZvLQhawRTgkl3jki5PlK7G46D0Efc4AAejjDovL5rJ7dcI5E4Fam+fY351BrrQozruWU1ViotYr4sCqMj9tM92gHI9PqK6/ALiuqttpb1zMBLvQgDAFfqSCECyXtGmdvGhhkpb03YvV/wx4z5zKyz3OUIdhMGaJwz+7utAjt3ra/rn+jz0v3zN5Z+O8p00PQ1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GVXPR08MB10543.eurprd08.prod.outlook.com (2603:10a6:150:15b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 10:51:10 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 10:51:10 +0000
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
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v11 05/13] net/tcp: rename ack_edge and seq_init to more
 common rcv_nxt and irs
Date: Wed,  9 Oct 2024 13:50:46 +0300
Message-ID: <20241009105054.1879054-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241009105054.1879054-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241009105054.1879054-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0081.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GVXPR08MB10543:EE_
X-MS-Office365-Filtering-Correlation-Id: 2026f7d7-8844-465a-f99a-08dce85048fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1ZepTBqQEvt448BLN/LYNyuHGQX6O/aXwYbqSAeGRtzH28N7LGOkn9pDsEBh?=
 =?us-ascii?Q?wkXGxGXynO7Kq0X1xLY+IoDLOn0PuJi4m+6nqkxVv0BryhT2JlLnIu4W/qiL?=
 =?us-ascii?Q?RBVfSXuNVo7shBMKCyf3A6U7rEfIVVRuEVfwbFjGIvMp8b2cNPzTH6jG1UXl?=
 =?us-ascii?Q?hSQaxstYAE1p4svJ0XstcU7TdQ49KfcTI4oPrEmbkuoMXAaqaIg3kPDXxNPG?=
 =?us-ascii?Q?GgLtz55uqxQG2L00deiAp6kILqI5k+4UayHT/m9/Iuh6JI3AslMix3tU2N0u?=
 =?us-ascii?Q?1fAQrZ3sQRcSGWKI/b1p/oO75jk9z4hEsYSQU6Kuh+2s5aicDlfM11qqZ+93?=
 =?us-ascii?Q?nf+p3cxqEe8tl2SxIjsivtBVDbCZnoYWqQVJmqF4ktsw19PJ42iCrIdSPVRG?=
 =?us-ascii?Q?j4xgdhKyxCkBusi5O1cvTSArhjYjo5NRzVzzNyZjnMAevUrFPWetuJC3ZSWD?=
 =?us-ascii?Q?PMGNuQ4niTYKYqEZOqH4xTOIk+tihdoHmuxeaZgcpKwndGLmbaWIcKNsl1Ze?=
 =?us-ascii?Q?beOinKTlG40ldPTjWUV/zfbl8rfpciYbnh/rK9ED0lD+DYwOjzU2RMq8rBkM?=
 =?us-ascii?Q?9d5H4kEzCneV8W019I5omOhHZAB1/D3sx4ujbwIfjuw6r1yMPsHUJqBE054X?=
 =?us-ascii?Q?vn+vxxJ/7ZF5itad4yivWOXN63otABmmlbqrdqypZcANlx2IzDeBXgu/cEmP?=
 =?us-ascii?Q?mnSYA6tvRAFB2+3JM/kldIObpnM1TpHveRZy72yDXsmv0ujF3SLdGe0627J/?=
 =?us-ascii?Q?aIThtZLE2lVUcXPh9MODq9OdRjjgJb9BcO5OwEImcFSZEsEjRDhAlLpETEvN?=
 =?us-ascii?Q?NUrW2in3cjY8SuRMLcZO00xDvvib9QzhEANmu5FI2Za+6ZFU8n/CSPk5bQae?=
 =?us-ascii?Q?WIqRJhjOWTifwoqIC6g+pm03txbQiqdZjYiWMWiOea9b73h+R59qF8mvA1FZ?=
 =?us-ascii?Q?TXZ57ZYf2UqYmFbb9l22fZFycKqaQRHapWd5/zziJK1iXRGKL0WRTnOFyUuc?=
 =?us-ascii?Q?huXwBlbOM4tGrzLEF1T97AT3yFrG915oZKAerBflSNjq7KfqNBkYofxR66z7?=
 =?us-ascii?Q?c7Rd5L8CPzx3xWOT7mJaASknlFd4lvAQlCHczy3g7WuP72hFl0f0cdxI9ueF?=
 =?us-ascii?Q?CJFcNXexOZH/O9y2WB7+n4+zLfSL9R//zFDIL29etLNnQL505bMi4MWP55wp?=
 =?us-ascii?Q?tj/9jduHKI8fK2XCJcr7e4rbDV1mAzg5yd3/st0wh0LNDkLi9Wo4VpLA4imv?=
 =?us-ascii?Q?TQa3gWGAAJgylaZyTjIcGz1koXWImUGjBhAqDXT0aeR5vFRhnlrz9feJ3WOw?=
 =?us-ascii?Q?QubsWK6+a+b/X21x/SW/pqvUAg4SC7Ewlk3AXKMy3jR7IQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QAdGqQrZ640XkwTqTB95MfK6jUp7+E7guqA3JqIBksELk5xVepSoqnz7Wntv?=
 =?us-ascii?Q?H5gvhB1TPi0LG9tEuyiKpp+qVUp05Gb2rEuHDY8iPGQupq6lQFJlAN7kJnl/?=
 =?us-ascii?Q?5JBdNndgNvoOd/lI2sDIE7MxzARabsjXJzGitFKmxMlXh+YKhkuVuMYukTDy?=
 =?us-ascii?Q?8LqEovqCIgcRGYyBUcSDdir2WlhmYYUFD74Chr94bvRbUj37RnP+Wio+GecC?=
 =?us-ascii?Q?UQK/tlZP6vDb+0fa++b3GA7pKvJcmZfl1hPWm2m65G4GbJwE7Atk5e1qGxt4?=
 =?us-ascii?Q?EOkHO1fFebtyzBOveYZtNKWNBv68xZcQKvZRxdlxV791/iKgPQ3Fq7SjRQVV?=
 =?us-ascii?Q?ABwzotoFeAUIsQiJ6vaJXMfH1x3yq+TcNMsuSS3vJLkQAxXKIZGXuB0PTwlH?=
 =?us-ascii?Q?0F9EkPNYAN/KneLlhffTC7jZP5zSCGOQ6Mzh0nU3/XjyC606kTA0uqa+RDuR?=
 =?us-ascii?Q?AgdRw7U3UZmS948qp+vQpc6O4YLHWLAUIWFpcxbxfCVpQmuLNJjxfL7t4IGJ?=
 =?us-ascii?Q?qdhUnYsM1NP2+tNNS7GbU57YW+9JuDObnSfyb35Jn3+/ryBSaCs5NRghq4XU?=
 =?us-ascii?Q?VF8SAh5nFVGX3AWK4AaDfPHIEDYVP4rJUwUxfPD0HHLhVvUd9pFRFNunt0W5?=
 =?us-ascii?Q?iEdoRzL6YusN1/tsDUAhJAvbxSpKFkYKcXgHLAysU9hJOs4Opzx2EKT7kuZA?=
 =?us-ascii?Q?RnQbaj8S5cJI1R5Ezf7puptWGQoQQqVq5MKJ3m5mWFPloXO9Ff86JS47PRaV?=
 =?us-ascii?Q?IVaUB6Z8F03rq5a4CAkHd6NwUE5IC/sGR5qHCklKW3DtMKC5veVi0+1uEHkB?=
 =?us-ascii?Q?4vj1dWDCEArURFN8V6Pmz7DCWUmlKezIpGMUDZnHEEL3jXPeqsrUSueWjsvG?=
 =?us-ascii?Q?GfjOcyzoPKNF4m6rlgQuFpdyBh88PuivSmhgWZ5nmiPLOt4CT6StHm+2/NF1?=
 =?us-ascii?Q?VgkowOzK2kxaVL8FdkNHLuA3N0zx4bRY4GH29WV3rle9cGfe2xWiSxjoxsDg?=
 =?us-ascii?Q?9cnd6TNDDgs/zw5IkQDo9X3ZiTTOxWl1XHMK5Syo7Yvbze/wvk+2cqoUq2ph?=
 =?us-ascii?Q?lwszoFUsH+2OWiHxlwBeDMeaVsbzG23IRMehlEOMOB0YtlIQnEdZ+VRdLwVn?=
 =?us-ascii?Q?9RJA5RWGAcgKxAlE0c0s1qUYtr9/Dl93S5lHUUrKwcK+e6qod8FZB1LG34Yk?=
 =?us-ascii?Q?ArSpIcDtAJW4xiTg2UgK0BIQA3TSEcANZeBg6W/DV+hL+//0h+o5bEzJzAFt?=
 =?us-ascii?Q?fG3L9RaMBAtaIUDfCjrlqQvvuv/ZAC/VPgvM/WDgZtQX7Cu+zC/a8u7f0dF+?=
 =?us-ascii?Q?2DxkqeqHyP4u091HiiIK93whmpyP3JrJg+ipXulkRQY2y5vH2MfLM5YNYplj?=
 =?us-ascii?Q?rxRsUpQBCkwkJq5ifJs2q98fDfqstHsKnVju57E+nrDx7/5WdE1WYP8HcKc5?=
 =?us-ascii?Q?Zb6wWOXVq/BMO1ALXPspz6HBd/nVtSpIQLLNIDwT9Uz6AjXN/gaoJiVtL9oO?=
 =?us-ascii?Q?inToinIkQ00GgYeFtCh/dkq1YSlcWZGUFYh/GFzma9eaMsZDigMuyXQXMrFi?=
 =?us-ascii?Q?/NgD8seKDUL2sDI21wqHW+T5JM5f6ZSJGujxtN2I5F15H1IGhdcYef/kd2IO?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2026f7d7-8844-465a-f99a-08dce85048fa
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:51:10.0660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10r5BlKqZiVOUU8Jb2hRr4VZNTNVGfgZhm6PgUSz4VQ74Hb8sk1rNvM9qEEMBf7Hqwu2oGyzyVszwvwYw52Oh+H/05yvj1Nrqd901KWUlzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10543
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

