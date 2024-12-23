Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76A0E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 10:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D217806F5;
	Mon, 23 Dec 2024 11:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="jTz58xlS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42FBF806F5; Mon, 23 Dec 2024 11:59:14 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22F9480703
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 11:59:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1Lou0grlJXn+y0zgWYQciGIT5aZBzZSRHkBY/Vwo+HpmpAV/FeN4N397d0kGahhUiyIbkfwO3AJx+TFq0GIy1wGHQE/++Gl/PPrU8OPd5EO1y5acRMYx48KFN7fYTp1pP/zanFhmmmc2OtK8Qs6RSFA88oTDaZcHDI49Z5FtSsCN3RzjRP5hddrauz7Hiwl83gm+EM6sg8DHnmVYu0fjkhBat6NshwY2Dh8gpo4kcwcgLEGTHc4qKxJNllY1vsTAW4aQS9GJmSxNnFsps9c5Q+FEo3+h2mOZK+gHQZDm4L4FTtxtTZ1sa0m5679yOj+Bgp8b+rw1esuanqsqWBKjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCiuhRH9rEnOz06Gx1j3XBkMGWrTEPLH1CgsvrOiQVg=;
 b=bNrB3RTb3sliwc+2BlJFH/pe1miMC4A64jFmwGCTK32Xfjv+OQ2qKVGaRtzIEtmLi+bgGFUV2TkNB9YqfB50uUH+yFL+SgwQT82sZlP8cLdgG04RFwTFULy3sRULRS/4WI70Mr5akbUwE10WsYDBpozUb1u/QoMsELDpBwxadwushCvlEzsleKfWyOTWd6CXWR6d8F0Y2sYY1Cox+xcu1Anvj6P1jB3bjehi8csLOMvQ/gjXimJmoVsmdcCy44YtjBfwkfd52BGMTTDvvZR7yzjyRupqHZAvdUvuUA990aI8SRbnrOlUnO8Bt+Sq3Zz7Ha4vaoKk6EHvU0+0fsVoig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCiuhRH9rEnOz06Gx1j3XBkMGWrTEPLH1CgsvrOiQVg=;
 b=jTz58xlSw4XzQTEDzsg20vnOC2J83VHtyO4cheEg3O51bCoyETn/n3lANnu6nEQAIcSOOt1OT1sBaPGNqmTlbMm9JbERBv1k4w3tgOPv80iDPDV5G9enfj1a/CZsBqBYeYK6HSDzv5ynQ9Ee9nZkuQNK8PmIngYUddLk3RfxDA09smd0F8DLqsjm5lmXFIjW1y2Mpe687GDf/xlrk6LZYLdZx4Jtre9wlLztzpQ1qVa8Djv3W7lq7YagCmXrCAFEXPUh5OyRZ4pLf1xYD0m8OSWrTXwjZfgiNJCerQsQinxGbJP9ATz+FzIVv06TtfrhcSXmogS3ExdFD1Pb5rgOIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6676.eurprd08.prod.outlook.com (2603:10a6:20b:2ff::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 10:59:07 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 10:59:07 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v15 05/11] net/tcp: rename ack_edge and seq_init to more
 common rcv_nxt and irs
Date: Mon, 23 Dec 2024 13:58:46 +0300
Message-ID: <20241223105852.1074404-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241223105852.1074404-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241223105852.1074404-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9927a4-fd9d-4bec-1401-08dd2340d249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6OACrJZ6w+jnn0ft6B7b5JvVaFsmKyq+uYKT4MzUqifmrSwpRK5EzKKJXjiV?=
 =?us-ascii?Q?FuuiBZ0cfaWLt7jBxrRC2JKjLeigZAsOFpuwAlwAm5g+8ABlbcdMB+phTBce?=
 =?us-ascii?Q?wFHkUX7/hvhUiu+KVZUKgmw6DDq0u4PXctk8kXe2U4AdDxZRaU3QVVZqE/XP?=
 =?us-ascii?Q?bJ74IT2uN8tv6OgtifTb2sw+fq8wi+8QxP6pDTBtLF00zKJMhtYM8jZ8723C?=
 =?us-ascii?Q?4VH/owVnkKAiaCLGcQDPBGWAmvvgXT1SW7SZexvRrr406UQf/Hjslp30YSxi?=
 =?us-ascii?Q?1ZaKyihYDCRZApp4pYTnDZ53gOQnip6OGiRoEZCQdkubGo0RNWpuMUEnIo1b?=
 =?us-ascii?Q?0fV5yURMEAPAvFjEwrWSN845wl/z0nuMGiFI/NHdNt6bbs7/eA/m05HKsom7?=
 =?us-ascii?Q?u7n6YXVXEZArCUT1XoBj+sqYB9DjmIjpYLCwN1vohTvTv9aeSq3qKNrFq9VC?=
 =?us-ascii?Q?5OVXeU/PV5RRJ5BzHf+FUgbhIcybU0ToBo4hP15AcwNPTgzGbj8q0R+DpRoz?=
 =?us-ascii?Q?sUyUvB+gjPTWG2MNwIU0MWSwsmSsi3Y3+xluOqwxYt3Dzbm1XF2vJU67Vgms?=
 =?us-ascii?Q?yA+7GwGzm2P7xxrVJZit60RZ8uHCFLFuL+oNBShq057kWi3Jj9MihxhChAG3?=
 =?us-ascii?Q?iB+e6hgcyPkQKVMF98WMNDH+SEdlJPKXbj85PRoyZ2zVCC0HaKe/ICBgmAWd?=
 =?us-ascii?Q?MYQ9DeiUIJoYSLNigHtqLf7i4lQxUlLRrLOxVMo0va8UBV4mdWsO0JUFTgGC?=
 =?us-ascii?Q?4MOyuiP5uRT0kRlmLEctJze1i4ey0AlTYH8kFBr0FzyLTzw8kRBhFDhRhuM+?=
 =?us-ascii?Q?qkcZkUIYMk+2CPLEjpUCvpdeY3jdUk8XVbq0NP8HIiKoSC8a614kWlP3v2Vo?=
 =?us-ascii?Q?x0eiIApgeYhiZ9LpECiht2MWmoZSBE/1ixVeBCC/+pqlAz+wc3/5tqQILLDs?=
 =?us-ascii?Q?7m7lnGp+zH58yLca0CBsV06lfkVDgFtob8Tt0+Zu57+eMo/W4cHVm6xZPfUc?=
 =?us-ascii?Q?7v26krrokx4HOCqFZK9DbvaTlC+RMyy6KusZ3rcPZ1drfFj1nRzFz0WLXUpK?=
 =?us-ascii?Q?ZsXmhH3yxy5oc+VENrKju3he7z7IQwv6SPGiCb1KhR7MlopyceEXN8c45CEI?=
 =?us-ascii?Q?h1Rv4h87Nbttz9C7f00cJY4tALVBn9mYufq78MbZEhm/DIJtgaYKasxx1tZh?=
 =?us-ascii?Q?94AATPTJiLquIVaA2DBSb1VVCle1OfZQkewYBFm66p8/yGXP90oPNYEHeNik?=
 =?us-ascii?Q?afgsMNJmaO+HkibjKClhacEz2+BiZD0CwcQ/GncFoHzkM5mB71ytG6rSn9ki?=
 =?us-ascii?Q?8zKoIeMIFuUNTrb3LWeIn1AyWoMXD54zWG5+SoowHFD9KbVMS59GzvatDHo4?=
 =?us-ascii?Q?q1BXvR+Y+Jn0EwhgkRIHF2QW6Iwqpt4MqBGm4h53pWebxd20tnwg0chhIrzH?=
 =?us-ascii?Q?TCByB9idQdC38obzYz287gxqrJvtoBp6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uzuvwFNj0x8pCFcT8400q7TPkd518hhUtTxdiWoyybJ7Rlrq8SaVldJ6XCqB?=
 =?us-ascii?Q?xStCIGCUleQMAyMl8fdSgiznVXZYfcvbrAF5hVmoP5kdI34jHGfgHCWH+UKk?=
 =?us-ascii?Q?/1kaUCbNfyJ9g3xJ0sYpmAZxYcwIMGOyVzvWZkNkJ6zfjB3oTti6+b063GVx?=
 =?us-ascii?Q?IgUeci5Vmocx2RLFgD52qu8x4tL059E/j5ZM7T7y0KznRYLDGmKHeQX45Ztb?=
 =?us-ascii?Q?0dQhjjPwDKZsE5Ch/yvs+1pRD4h1GoUT1gkq4nKgLSDiv9aY+rU0iozYXYdI?=
 =?us-ascii?Q?RUPksgP3qF0/odXeJraRC6BvBK+nkXGL6y+XidpBwVfRr/7UHDI4RoEIJpMq?=
 =?us-ascii?Q?j0cl5OFkeEN26PVNAH4c3oIAM+RyjLLt2T1V3mw0l36ufaaGgoCe3nNneHml?=
 =?us-ascii?Q?kDEnNW8oxJ6F6u/9aedKpo9dVz3obv74LTVQ4ZmnArH7H8ty0b7pp8T/PPX7?=
 =?us-ascii?Q?i+xbpXCn+q2z4pQk8oQxNm0wupwXCTX4PNsw4QwWpmMZN2EKRGhYI3pWqxGp?=
 =?us-ascii?Q?+JJx9aJnEmCtJcjuEfSKxeK0xcZa4vpUenbiJuAyzQLJjSwAVd/Tv9SNVYd+?=
 =?us-ascii?Q?PUVCkdcjKIvR62t7qtcWhhNlKx7w147t8v+YF9X6uN24h31jl8KZLer03oxQ?=
 =?us-ascii?Q?99DVj2rY8a3eqNG+0knzJCGwy4G9E+quigNIg77nBVonmb0gy+1rC8VFKU0J?=
 =?us-ascii?Q?25A/0iC2KMgSp+8O1UiLayX1FBTorGjt2V7+1ygLpZq/TtyCVBQX5oKGXcyY?=
 =?us-ascii?Q?btucq9AdY7EjC7VUwZN6mENzSDY2XHyGndtogCgDLAMV9ol5bOL6gcfNtE03?=
 =?us-ascii?Q?Mp3SmHVii+mREAKMRlE7X12acV4G7OcAdFnulBMCttvXbUbMfu/JnKSXoXzT?=
 =?us-ascii?Q?oU4L4EbYf2v5bPHe3gL/3fvPS6GOoM0x9MpGfbqppTgISxl3fxJdC5QdMR/k?=
 =?us-ascii?Q?vMDWPe744DcsLz0/iZxBMYsA/xCqcfPIjALOFRR588UMtcsNhFMDEcpj3obi?=
 =?us-ascii?Q?Y/ZuNNNKyZ9vQtQp2hwDnINySvc0waP80xBGCUrXeUkW7MmchdQL0xzEOlNj?=
 =?us-ascii?Q?SzkHP1kXOTDWkfGF60h9+6Cen0rnszbhf8EdhDJYkdLMAin8SikDkDiNsBzc?=
 =?us-ascii?Q?1ttEPZGjXt0sFS9f5ruFN5MJq6KVrhnny9RMYoxffgY85lcefTldfEJSN6mr?=
 =?us-ascii?Q?E5inqAknk+9+2xVuh5Y4hvn8GdwArERbQFBATlMwsEO40XQc718v8fr2JKyd?=
 =?us-ascii?Q?OzKVrWWHibmYHpLsNa6y3IS0YL7vUm5/1xo7fsKxE0IDhuJD6porDdn3V5HJ?=
 =?us-ascii?Q?/n4yJ1t1AerAhOe1ikJE6MKm4ab7JVkqBLmocIEc4vszluU8w3vx2FoFZxTk?=
 =?us-ascii?Q?xULf+u6Hr0yO4K+c5MA/lKQ00iYj6m5Sru0cBJOsakxYv8GIEm2CkkCyodqC?=
 =?us-ascii?Q?crhBGmOooj3GdZ6nY4PhrDnpoCRv9h0XGyQCXmUbQ3lo9RKW27xXL+un/Dxl?=
 =?us-ascii?Q?lZAL2GDNVtzEyPu1elOpgjkUEPiZR/5sTdOaLrab/SGyBqsnELYFMyfq7SGI?=
 =?us-ascii?Q?mIinte+Sn5TOvdUxJW4dBiPVl0oYIoh0xzMG8BotU7UXOEBm2E2gWLZZL2u4?=
 =?us-ascii?Q?J2vHa0pnMmbvuhl7J4bCRoA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9927a4-fd9d-4bec-1401-08dd2340d249
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 10:59:07.0926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oK/7yQ37KvdKI4NIf/rLrl+0H3ZEObum1x9kRuGVkX0jVu4zy1MBBoHF2sHaMbwa+Qr/KRDwY+wY9aBwJ73jx8VbF+m0i+E7bUqizwn2et8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6676
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
index db708f0a2a5..7c713a5ca56 100644
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

