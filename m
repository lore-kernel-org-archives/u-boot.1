Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEE8CF044D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 10:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DE22891BC;
	Wed,  9 Oct 2024 12:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="BKixuXg2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAFAC891C4; Wed,  9 Oct 2024 12:51:13 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2071d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::71d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88FCD891B3
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 12:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NajX5UxMgDnjk6gFRkm5wTaekBoJhisWCLLBMql/eIa0e+TCf4CelJgzCv2fDZBhtphaNS2EwArmmlxOkm892/Z4TbtbmhxG19CKMn6plm8N1UPQSpp93Y/5KLagCmewq8Z/9yvGuJ2Ru1G67KcXk9m6Bo0gqlbQMUsZfvu6PEFsdzIGtvc2VblyqIRPmYICDuhOIbLh5J710xFkpLiKUdrS0aBo8XMpReqgc5vXTd6XxtQ6uXDwMoxwIKKLYqsxp2C6tpNB3SWvZPFslGnhkh8s7yR3lxbnyoA0YmvIxmg1PcpN1GLfLvEanJWNHkYZbLU9wt66jD96NI2nmhSvtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=xZ14Ui0TQq/z1Yi4iyw5ajUBK/hhLguMlhiwCajkyDo8EYbXxX5adUHUbZFhQIKPZxw/lSbr9vO1frJz8x5tAmIr5kQnolqz22XNIWbhI5Y+09Cg+D9r0cAZPMwTG3cdLttYUi5E3mKtAYwEkbM9n8ClOY8poq4LgPj/JSXYu0q2lGqUP7IYuE5FYlL+Ok8SGI6G+c5pljMZ3RqJu2j+pjCIGWhD4YUAbg34w68qeaaDIDPMiFY/KS7jXf8CtZspapV/aThVpcaXwkxYSxjtiw3g1NrJbjG8iDTivqJvtlsluDQBmZntMu9ik3YuohAB1UlMP9KuUD6+fYWvxXGJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=BKixuXg2MGcEUt9SQhe/f5KF8eVWW8T/1xbDu0P62hVTI4b7+p0JwENrnmam9Ytb5dH4AvFj1uapMMMH3DzpJ37KfB2qu0nM+OTU4SQ2DH+uZIrTr1XDWx6Xki5Hgij3T1Y8SxI+wD62HM5GBKsufQFGls52mMankaPnVhvtInOM08nBkGTTDCvCGq1i6b3QSL9J/42mrpGnzXJcwl/Ftv32S767ozpQ8lpN/VuBUv2Pa+wqXtTHKuXy8HEHmRHui1ZPJ4J7Jk8tzlIb/+rvYHUnHZjq85Vn6/fGwzvIdJMri5mY35vhM6Fv9s8bk/n75wcTlu9JUCH3NPZqz2p6SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GVXPR08MB10543.eurprd08.prod.outlook.com (2603:10a6:150:15b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 10:51:07 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 10:51:05 +0000
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
Subject: [PATCH v11 02/13] net/tcp: fix selective acknowledge
Date: Wed,  9 Oct 2024 13:50:43 +0300
Message-ID: <20241009105054.1879054-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: eb0fd8e8-04ff-4f9f-80dc-08dce850465e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HSHPwTlOTX1+xnmYeTDtVnu/5TM/0Xh1a4t4ZMJiMZSMhcHTcWpY0kImcwzx?=
 =?us-ascii?Q?yTpDUrg6vIrnH+PjNndcXIzbNcdMVGvdy3mdbjJteOpcycTlf9NyP4VILc50?=
 =?us-ascii?Q?rt0T9w436LrBOJbr8uCNLGQUUZrSUAOuYgxi9ibW3U9amGKnJLMTsdnPhWCY?=
 =?us-ascii?Q?VkV/frvObuRMkBDjIaFOVbJn5/mxwUpypaKvPA3t/emDyR5L+lLvT+db59Ty?=
 =?us-ascii?Q?jtEfBvCb/9UFj0K8UgQiQZDQmibGTcdDNvD0HH0eiKTmpCNBefjNbpVINuwE?=
 =?us-ascii?Q?ZczoLF8Sm1uVtrAYpgXng6/uzZScv06e2LYRxfjx8xA9ExXf/Tk/LmmY3Nk9?=
 =?us-ascii?Q?INuimqy0/Y4eVH9ObMynjpVHP4F+iqfV9SPBuYIXsgWi9lbBNC4/b8aBuEbe?=
 =?us-ascii?Q?u5s77csNpaWUJX3I+Hg4VM8jm2wnVElf57TeVQsPHi6ZslDj04K8MmCvyAZ5?=
 =?us-ascii?Q?YSmm/fzmo5urZdINANCEYzXLqIzfouHvLuBUjZu7M4vo6veMZFpZNR7Z0rph?=
 =?us-ascii?Q?HSsfwCjEnKccuz0lVS+Xz/QOSV6qlUi8hdym3DlWAQAMa5zLs+cxOAVOjt8I?=
 =?us-ascii?Q?GmFGr6QIZGRbAdWzsPD6JOEmKA+HKeAhTCUADebr+t65vGeITtavQTgd3hIu?=
 =?us-ascii?Q?Mz8mHxiR8XS6uSdAwNmV7XoUL0JMS/pBchR/JTRCdcin2xgcTlOIim6P4UMZ?=
 =?us-ascii?Q?57WsbgT4VZbb+obHOiH9xHdN4g3+gXFVuCu8gCR35rRScwzyqwbiMma3P+hr?=
 =?us-ascii?Q?n/YUq1oXn9gk8hHEMhPLP/y7zEGuUTL9WtxM3VuB66TkU5SIK4tmkg60yrLi?=
 =?us-ascii?Q?LKHFd7rdSK+N+RHiqTUssSSTiQGx0ef+BoujYy2fbLCMdIi2TS57O11jAhbp?=
 =?us-ascii?Q?mwJMwV+njCEtJuwsZB+WxJ5SnYRoUzhGmqnwRJkCkQN5XKG1zd3Pi7plhO1f?=
 =?us-ascii?Q?Hb2zrVE91WGk/YxE0RoApl9FRb+mcmbgnZEDJo1J1dIHaQkjqaWz79RKj6Yd?=
 =?us-ascii?Q?CcfRwLLL6QUAvmdPEXYuwAmfd0e3cOiUqyFGyyLvF2tdczxSQSxFmoEFGFBO?=
 =?us-ascii?Q?ttcMVzUE2EbOMWG9A5rMQISPHc2KDxc1Bzw08pV2BqjRmefBEG1eJMjzDo/f?=
 =?us-ascii?Q?gWx0xkV5WbTl9HTDJfgJUNL7DBH35xkXqirvZj1lL56ZWOFJ7AP/qW1yT02T?=
 =?us-ascii?Q?gRmnxgazA1qPnqFUwrcGPK1sCP6QaeM0hVbKLnTncgv0d2NZGTQ49mtRfFOR?=
 =?us-ascii?Q?4Sy0q9JebUARJFU+Le/5xyZIBvdLLq9pudi2Zc4gCqIaY8o9J7k6ZceYAtQH?=
 =?us-ascii?Q?HjQly2LZuKPfMhpcenDAQHcidBCwQKKtudQ2uvS+Rae4BBQARPJRRwOQvrAm?=
 =?us-ascii?Q?CIp2b4g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dx69jJoHjKZe6Qmi11B1Bwvv6rchzvwDQgG7xwWHOaEDzqOblgdMarCLPmiG?=
 =?us-ascii?Q?ETUK2VJYNCGEoYJcw3CJvARbB/PrV7q+UwxHuwKyFKcce5QnNSyBEkLyd9gK?=
 =?us-ascii?Q?XB8eKVpaxX+ABGQt/S/4xTQqsf9dnb0lElHz1sfwOvABYvYr/LfX+YslJ/Q4?=
 =?us-ascii?Q?7Rt1lr/RP848sGkuqDOkass9GBne49KkgN/jojnS4IxkyDbzFGScx0qpmpx+?=
 =?us-ascii?Q?eaaMLmDksKRDWrsWKJHd8FSQklL7MOpfWKGs6Uytj0GNgaooKy4TeG07K027?=
 =?us-ascii?Q?Xo5YzCz2QizeFKt4OB+qiWCNq2wSMhvBjMDypEDOcRRvry6gDxwrdGUMvBo9?=
 =?us-ascii?Q?DDXlVOxbH8goTxj6MaiQXLH1xYRIW27GEz12xbDAUgrzV56eGMtx8vFfjfQ2?=
 =?us-ascii?Q?0UGCbqFhvk6o2UWIXSqu6Jvw/tvrRWRm/Q9FGoCOpeLfQdcNx91w6jlt/JhS?=
 =?us-ascii?Q?zBsTxcchQSjLkFNl48kBY5nxQIujE09R/ZXIkkKQXHhkYPV5CoIrGbWKHQAR?=
 =?us-ascii?Q?Bjh2JXD7Ggnv778DyN/xlC3iKtAEHIRbVqy/HCJwH7Te+Tn9rH8TUcHd/Vb6?=
 =?us-ascii?Q?UWBVYjb1sob27PCXxIRcyOFXgAi5PopNZ/8jmZN2F/m/CDOIa0YXfPpvXqNo?=
 =?us-ascii?Q?DH7qomFwBbKWWVvxUMmyMEaU6yKiQ08mUrAMrca6eUizkMIAw6iFCvIb2peB?=
 =?us-ascii?Q?oHsXu4wb2M2YIuFKN/eoPkkBIj8RYFAA1B9qWU2lsHFVkIj+DqcaYQ7CPU+4?=
 =?us-ascii?Q?peMvo1YrKcNZKw6h4QWR+++TIMwggkjYCPb2vjA8p1rcIJKzZec36i/oWZEe?=
 =?us-ascii?Q?wE59NAqhnBRDSWDbtGkPhwpsG+U5Ek2dFJqNRKmzS4bzc7n/1J3wYUAYiaLq?=
 =?us-ascii?Q?Mv38yL1wqfnda9AC1ll9E9Zt/6F1huHwqrT7OWoCMGu3djciCTyEdnUDJ2AG?=
 =?us-ascii?Q?b2tv9356IvYrBe+hllA1WRj50J5oMAhJhH0bJs9LiQ4/YE/n9LQOQ9DwnELh?=
 =?us-ascii?Q?JSbnQZQ3qIWwUH3/pI2lCnCLiXX6kSHcenCOdAD82uQvicFzW9mmYHUISj4t?=
 =?us-ascii?Q?LSTwDpWTVczQGOZ7k2xd0vVkwlkTSBvXaTTx08rlOhVUY+DjTHJGKUOdVdCU?=
 =?us-ascii?Q?VgL/igFwDIpFv2AQviUyZZsnkWRRL375WjRpLqWKjlZcMAmrT5snz7yvFmtH?=
 =?us-ascii?Q?OxUDAH/HO1ZXJVRQ1MBFVKXgbwfFsFSTcG4hdYIyogizktbAXXEfswoGoSQm?=
 =?us-ascii?Q?LBvtST+jYbS+9kXWoxOUCwTr/okTFE+EqBRgyt/3HKU4kFC5MC7mcw2P73eP?=
 =?us-ascii?Q?K7DaXwmZ49I4wWamwSvbIwf5WpJihJPAytIXwnuaHfKcNxBmJsieydmVK6RX?=
 =?us-ascii?Q?tbQOM/c8M8ZpsLAQchp9yq7/MLsmb/pmVb0jMFea6I36uP+BXuUSyWePbCbO?=
 =?us-ascii?Q?LiX72HGZun47Rzl883P0j7JXI2JPAWWUNTNxH+nKHMCmw9fw9VTWyCBTa8hZ?=
 =?us-ascii?Q?TQani4n1SRT38PI1RWYyvUZWuhPSMUKshGPBqJ4ZhPn1Dl98Kt8c8AVAA83X?=
 =?us-ascii?Q?Cd4SHJIi8Vxo0U0Sj893OcWFPZ95i1Q38dvOL+1B0V+3U19X6PD2L8jH4G/D?=
 =?us-ascii?Q?Uo1YV9lT0fSSSZEJhptwkUg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0fd8e8-04ff-4f9f-80dc-08dce850465e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:51:05.6782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCarSH5YCHd6jdftsRc8nSvZxtwZS7ieFKa4vuBvMmgI5qmed+EEcObXyafcdf+YIAFbOObwlUyiHOjexkjM64+KWRdevNcN6kbzvR2+zYo=
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

