Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457A4C52D1F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 09:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07835889B4;
	Wed, 31 Jul 2024 11:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="oDnK3JAa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 496568839A; Wed, 31 Jul 2024 11:21:44 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20730.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::730])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05C63889B8
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 11:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqWHK6R4X9+m82QYTQ02sNSkZGeJeAQKyChZJt61ozqrvg+2RqCbFVeeVjZfPdqlpala0XGqyGxBf89DKbgTMyYbsyRcHbNqFVDwcvCxmMOuzVIv5oZ1G3PpVd/ojlBLfJc4V7bT8B00Yrws1FUVY2tzyE+C2UATg9uucHAN5PrlEhAABq4eG2C81/qrJEJd9pwwup/idUcEQsf2Cunpx4orL41Zb4TQypOXb4SrTByo+L60G/DDPnswrbrpTvkIRjY2Rq7FAxh7CSJEszVyKfr4uPuQ/4vwCkVtwdp2+Bn0qK9/8X7KF9HCD7kp5GdnDkcKGxUILTGeoXdi0cdPUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BXXh/0iWR2mIkwLJSLn1ApC3gFSPJ77Lkgt+exOdvQ=;
 b=kscIdiXaAOFg0tlhR0my1A/9PqsGRmU+aK0niOiFYlXZ5jBpY0swZq+y/n4+y0ul7eaaTLEvzNpPyLZ0QqhtpyY3ibC6DORAIHvwlCWIgPNDColTJdonYIHsGrBhNwBvpTiPoVCpWihxQzitKSIXYeiSP5yXMimvMI9hggATD8iCzWCsuOPj7mdHso8tUTTjXCQOuHHy8jksFCI9R5aYJo03zhAul7EjSmCSiwhZy3YavAUiBQ4rh9+baCb41Msdwj26fdrO8DXQyvR1hX0xXXg1nR6aCqBuW1MEHHIawFBfdDAh9hDVTPcKHWFJIhAgwht6NznL+kYLrCRENF+JjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BXXh/0iWR2mIkwLJSLn1ApC3gFSPJ77Lkgt+exOdvQ=;
 b=oDnK3JAaK650sk33p5es8yYTH+d30otnwXtoef1BVALwRvcozaAnuYzO8WF8HNbHIwxPN7yeeJWPe0eEzYp0W06JlaF7fF62XDnP2BURU1efFm1WAhr9CD7GAQGCGBS/F1IoDp9Tqj97LYhxNtoPcUFEX8YMonpkKuA2ad+6B3iMPFc4trB1mTbC82861TLqemMwUnQitFqIC68Qj0M/jcB8GpS1X90qv+U+/g9x1uPrbOUoUwyQKBbnOWGO0Eem2z7RFdP0VfkJrfi3Tcz6YtmPzly6g6c4o7RzgLWwq/t63oG1zbu/Vmz3q0vfYLAqHzdkk40i/ddEXK1sL+mQ7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10180.eurprd08.prod.outlook.com (2603:10a6:20b:62d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 09:21:38 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 09:21:38 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 5/9] net/tcp: rename ack_edge and seq_init to more common
 rcv_nxt and irs
Date: Wed, 31 Jul 2024 13:21:06 +0400
Message-Id: <20240731092110.4027134-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731092110.4027134-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731092110.4027134-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10180:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9fc872-a0e0-48af-bcd2-08dcb1422e90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z+xjduLsg8AtssQhQImEkG+kcvuAXmgNBiNdGxjKlLzdDlta53xPAg+BX1/i?=
 =?us-ascii?Q?kYHy9dkt08nnMqxwpBh/HsunvbsmyMaetT4GVu8u1k5+2CWT79ce82HGEegN?=
 =?us-ascii?Q?BRMfdVmi7d6rWjyBBOLpJpEG09JI8iSXS48EJKolmVCQ5KG3fzkdV5EkxZRo?=
 =?us-ascii?Q?HePYCEN2LVPwblXzC/wJbKwudNu/MlFHkqfHVdVOi5YjJbC89f3egViQImeC?=
 =?us-ascii?Q?uHesL1Nlm2eN8uL2KykfWoMuv5HSAgjUkaeuR6zf2/bq6+bJ8fkUibJKQg7/?=
 =?us-ascii?Q?MH6sOahqf0TCJRI93LgADbsBKTWg1v4ANs3jpn8I7KylUEXp56cdRuX+p3r/?=
 =?us-ascii?Q?eb1Gm1lkEb3SXXK6hDlgnV5aAFRUQ0gq0qlMVXoDXHtK++hKNj7qSDflWIwU?=
 =?us-ascii?Q?sTOkniPHshMPKkQVYCsvNIzQ6Mt6VllZATgqIcc5okgyGdgx+Z6jwNt8j+iX?=
 =?us-ascii?Q?3fCwWuflayBCfS2O66A+aP0eI4Yw5ipVk5dZ2WSbMU0UEk4H0ZLEJyMzDAaT?=
 =?us-ascii?Q?FCv/IOI/spY0sPoYT2+ziev/Bfz7OF2LzpMQUBeQQfRIs54uxX0q69A3jzm8?=
 =?us-ascii?Q?NhcgyhEunL1ov1uKEj9Lr27zy2YwcEfD0nnnHoWpEhPBHFY6Js/IKF/OBDgV?=
 =?us-ascii?Q?xd486KOzPGNCRGin5jwOpzFH+MPfiDIulQRB8EjE+2sHtECaslkEtOID5pp6?=
 =?us-ascii?Q?okmUVDaHPrfg8sSAzIeqhrMdncpvjcDd0I2pp6RahRfk46PcL5JoBv5oWRAT?=
 =?us-ascii?Q?LLUDTcl1v1uuak3dANxotQA8JTXO83chPOIBsIAkrfeXFsX5rHxc6M/maI8j?=
 =?us-ascii?Q?Hmit/yb4ZUrvN7G/f5iXYr6+28O96cd2zHpQPjI1WlhV5OidnIaKgWWlvvt+?=
 =?us-ascii?Q?EZuN0SruMxwYY+IiRZN7aG0bWFnAOKjNpvb96rNgo2Hu1MMIiYegrHVwTZzG?=
 =?us-ascii?Q?2HCTqvRwFih5aJlYl0AiO0jnSJHq1+WF/V6qUG7Cy65ngkN9DwE6zKDWo1i/?=
 =?us-ascii?Q?M9xhuOul+BVDGb8JcQ7vo9ogpZHSg2Ct2p3UfpqEWkBjOrSIsU29sWqCT0Nu?=
 =?us-ascii?Q?PklOlDNGVjeL7v1WKTceqsIc1fUg+AGzM9ZfMYoATv0XEpZhXlyzEnFSVtBQ?=
 =?us-ascii?Q?+VvT3JaBI7b6DjReG4VL550iqV8GJ8WGNpQCPKHj19rtHVMbOpAqICsMOZBA?=
 =?us-ascii?Q?spD8+zAlvFUq72aU50Z671laSzM3u/hT6wGpuiYHSQehreUVyFNUJ2RWXo1f?=
 =?us-ascii?Q?y36sD499InVrV7bQ24XjoQLErRpTHeK9ztluo8XXcxLjGU2rlXJ35wHBjjuZ?=
 =?us-ascii?Q?ZtMuU6Vs/1iJ5mvn+ZVwVVpNErk0fLaCFeC/YBnYqaNHAuEUfxKLn9b5h3l5?=
 =?us-ascii?Q?FNcyXMUOyL1ajyx9VgFpWt47Zcw36siu5Rp2pOcNCeyvomNISxzdJXDLW+ab?=
 =?us-ascii?Q?q7x45i/eKc0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bewt5tojlu2d2sLm7XXbd+1QgIMA2LRkApf3Mw0wzyAhfMBsZSiEciivquPg?=
 =?us-ascii?Q?mOio/f38RZ/2E1qsGoKAe2mJucT8zZ7YuP7yZZ1uUUE1f6vVQ6FroS8KqciZ?=
 =?us-ascii?Q?HqZu6GCLo+nmCYNuBORmZIaqwjJx01GbwlZ/u7MCkERMGquqW+kHBQH86qLx?=
 =?us-ascii?Q?ASYt2AeQB1LGaDEHltk1fzMQnSRTP5Pf8pgZoQWzk1fpg5BjjDuEsWmYSZAZ?=
 =?us-ascii?Q?ZMijstXxXX17A2DpDt4gAG+XInGB7UbxvEHXA5Fic/SeUEqPPAgF8dmdc92L?=
 =?us-ascii?Q?zkp0omP+RG0pdTNFvemNUKVkFM1xk1FiAb6wlC1QXcWnC6EY7XHGCFBixyyA?=
 =?us-ascii?Q?PjHSvmXSpHumRG6GaEUqQyINTjj2wsS0+7Qynds80qOlAXJk5qiyc/cbkSwi?=
 =?us-ascii?Q?GYD3lpLDPxfHSGpcTeltdZqxxze2aLeTFO9I2+zY922sRyg7PgzkO8M8CYWC?=
 =?us-ascii?Q?bxzNPWjdSbgoouafjOaKrDlMZFeVHF9upfKjGvzDCFWusLJP/+potklCzvLt?=
 =?us-ascii?Q?e6tNVpBnAS9fh7DbKtqsIu1/Pc12NvTV4TpwsOZlKdjUzhTiejltjAG4AEat?=
 =?us-ascii?Q?f8kyQb9eDHQBG7rS7vpBO9o72PR5KGVWO4tIU9GzIdH3ajio2P2rQ+zfS4HP?=
 =?us-ascii?Q?r6GdUJn4eAPpyOBFWMTW+rmGivli2tYBf7XjybpPtCfZr+Dc77lxLX0REbOq?=
 =?us-ascii?Q?S1NgqpgMSd4S6noJ8Qx8e66UGzKVCq9h4cTNhF6B/SalbiFE2TzUbjZZq6Gj?=
 =?us-ascii?Q?iV3ig8Xu84TV0li8WfhHVATa3FJWPMKJfrq7EvV6PJNSYUWt369ckQPu5G66?=
 =?us-ascii?Q?egzndsz/tHiMSAt4g1CuAyuNDAXG2hbxv1FflAucV6C/sbZC7Mm5ybHM7z0Y?=
 =?us-ascii?Q?6LQQ1koVwIv4SDcI30+JBAnIUbUF7U59+u6QYIPvgd/2MDMvhf32b+zPXp9r?=
 =?us-ascii?Q?6qpRVMYhvo+nXpfHoQneBK1G//kz13B4Kf6S3gp5j62vM/q1rM8CnO1vK1ao?=
 =?us-ascii?Q?Lv/ZzwzSP6DWs/fMC32QKfyp5mf+J3IesDUQiJwly6/wiqViuwKdIMvRtznB?=
 =?us-ascii?Q?4h33nXWmyrMdgpFT38XVOPd6Te3A05BebjLjMxU0OHKysRO7YG3yF0GVmzqp?=
 =?us-ascii?Q?gcgGQ9TVkjCmU0emqH4UMhojNJ3dIvelPRMu0FrmM4ZID5+X8Z6Sp1W5CtEE?=
 =?us-ascii?Q?1jJaZXGMfP4CzVfcZAtuVt8TCst5KnMXO98+tpXlkr1eeDd7i1UYvMk9EZ86?=
 =?us-ascii?Q?MHgM2QoP37L+FK/2mQWtlc6dhL3gZ85p8EY2VhAgMEUDw81eLVZb6lSNmiuB?=
 =?us-ascii?Q?MoBtYTVaohFalZC6AB+VZyP3ar4zx5GMKsxIHZgnJOJEt9nz34hgLQxc4zv2?=
 =?us-ascii?Q?VDjRfmgrm4Gb+wmt5oMTalhAcr4aAXglFbfMKM6iWJ18CDzcL0j50iPvy1dk?=
 =?us-ascii?Q?9qJvDPbn3xCIgSyaEIv7Uu0UnyVnozLdfp7+ulYvCWZj8KGMv1ACv2QbwM/a?=
 =?us-ascii?Q?3BI1VrUSKrYRkv/FzrOy+zmNaLzIZGzLTKWENv4UJFgeSiIJ4KDTgHDFxCG3?=
 =?us-ascii?Q?WFRDs6P5FA1VqfoFBni9qZ/RTvhA8+ayA0UjRtxnlUofFpVkzR3aOkclK5mu?=
 =?us-ascii?Q?iKko5NEMzZeiI8AW7a6zwDM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9fc872-a0e0-48af-bcd2-08dcb1422e90
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 09:21:38.8505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLNk8SU2AdggBozKtWJN3ijO0hFiWRlMy/2H5/K8MBXKKadh73q2Iu0ZV4BZn3duTip0c2mYBzXlTtr/aT9FQa5dWylMIizgSrVFEzQgKqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10180
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
index 9acf9f3ccb2..96d499a42ed 100644
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
2.39.2

