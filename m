Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD78CF9C69
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 01:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDABC88C60;
	Wed, 25 Sep 2024 03:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="sBjIxXEr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03BEC88B27; Wed, 25 Sep 2024 03:41:25 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20703.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::703])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B737688B6D
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 03:41:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ll+8SvvsApVY+JDCYID+H5eHmAK5kF5topOlJHXwxXzzqxRmFK14lgoSNRXKd71H93dyEJ//Feqbk7zzA+Mi2+f9nhQFl/fqMYVyHZsVoS98Nz9IEv8CbOEJRoL8yH0Gvj9cK0paPu1u1ST3bXSVGl7Tk8tUpGWTayE6X3bdH+gE+i9So7+b5hKo6RMQmfNDCDhHGlSU3WPvflgnI/xzg+d86JWeqPP9rte2HfKXTCxRzZYUSBvbTLZ/gXBokuutJZcHqriC7eNxHElHEBFcLuY7Uw9YtdwGkXeYoNixodV/B5ZC03jy+NV0TiV+XkA9kztgVD5dtqAqlQSlIVtSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1W/OM+rApXuK7t+R9S3YJe3h+F7fm++LQERW7aZmpA=;
 b=AlQ++Wx6SwRETNknZ4fLkiWO7WfHV8s9EWncN2S5gK7T2TmDvRrWNTLetrInAA56lIFIcVvIZVWbZi+GV8o5xog8Y7OCLOnNWXqw4k4MWApz0XuQzDPIHUdlpxYW+Bq6guQOGuMMKbfayWYCSncXKIvVoUEyQpTXWMmRSSPuP303Fzxo12nh/KzhScU4t8vOMm7hnMPviFGx7tL+0xFazC4kHBrFq0Jn590m5lozGrrAOh9Gtpeg4etpEczRYz/SEjoOLGcBxw99vVIzy90KRIqio5bZyNuR1r0AGvRiNIR6ZK67WL9NXTOIqXgm8QYh7bjno7rs8UVxxxZWhJX9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1W/OM+rApXuK7t+R9S3YJe3h+F7fm++LQERW7aZmpA=;
 b=sBjIxXErOhDdlQqme4eVkthbpTWBldrsFpoWod+8mbZuoRsn4T9nPQmXOy7hKcEIfC5BL3zQYrYb4ZGKaRiTajvrMJeQjVGv+s/Sr6EcEUFT87+7We9GgRZtMd6EWiRTEyrrK+DisQoa9zPw8X1KbgfBw+A+lhrtdIt3vWYaauZsQHkuM/4k/oy9TP4xrmXQ29VfrMeuBs3D3QWMRikmURsxEOS42KJiMzzzuJ/BGV0ePOZdNIO1CBZ8eGR+92qzy61RQyWA2FmARK+qbqXPSwohiuP2c70eXM4hZV3zOUDRoCjx8e1n+sBwlARt7SY7B/CRbgfj5Wt8yMKZlS13CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VE1PR08MB5645.eurprd08.prod.outlook.com (2603:10a6:800:1a6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Wed, 25 Sep
 2024 01:41:14 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 01:41:14 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v8 05/13] net/tcp: rename ack_edge and seq_init to more common
 rcv_nxt and irs
Date: Wed, 25 Sep 2024 04:40:50 +0300
Message-ID: <20240925014058.1679074-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925014058.1679074-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240925014058.1679074-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VE1PR08MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca16cd7-a343-4c87-cb5e-08dcdd032455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|366016|376014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Rwe/q0y4+mhKE2eESkNokrZKWRsYXm+xMBIp/QgR2Nod8+EMvLlMBH5xvAc7?=
 =?us-ascii?Q?W2VB0Q93jJ+yJEWZQYqtlkfXmO48GK8F00XRKG710D0PsKGeS1H6IFxfO9X9?=
 =?us-ascii?Q?qZ2NXLR4Yn3bWmknrb3KSLXXnSUO5A9THSS4tkBVTsv06kxtGxPPo0ukSIdi?=
 =?us-ascii?Q?yjLK+NVeo2D10UqKdmTKLXZOlynLctB23X9r7Y2PcKiERNGUQHvMWRl0ynUD?=
 =?us-ascii?Q?Vi31URo3W+6OTfXo1gdeGVf8Yh7QRA8IEG5RavDsxXu+wgQaOKdtO22XvxS8?=
 =?us-ascii?Q?HcI9McqA34Lx+anGcz+6nQgAJ3MINFb3P5ZYc7Q90Pkw8LN1zSBLeCqaYuiJ?=
 =?us-ascii?Q?Eu7NKjfdF7XHZzIEAagI9CElvtk7jEChqYpVWqMW/FHFg97zfaRuvD6LpeyE?=
 =?us-ascii?Q?VVHBxfLvEkjjBKpTiV9blS9vtW3YyUaeiils++dr/KyKZY0TEk+oqk6YVtmY?=
 =?us-ascii?Q?zwyz93CFR3yoMKtoCxZ1rOa0KGiHGF+1PKG0mL7N4UabHLZmCgXXe64b4BlE?=
 =?us-ascii?Q?cE8hS+W1Y2fg1rOXdpiLNzSSVOJJckaOTi+iTbWvCClrL5YswMugKY7fJ3EU?=
 =?us-ascii?Q?VgaipvQn7N0BIz5Xt774w4FrmKatwibrJrsVGVqqp6vYgbGynlfKOlsAwOq2?=
 =?us-ascii?Q?tFB6Q23UHNJbgbjcdGsfeHc0F1pGair2zZl5Jt4le7zne1+DLkO2zeCqRx1b?=
 =?us-ascii?Q?iTgC2qHJJnGQEk3gFK6UEHVTu6dfaMxGwhaPMtUDgxIN5HdDWKp+ndOSQ9jU?=
 =?us-ascii?Q?DYup+mAWJDLVUhY748Ly/ifQX24iCWl4Iw/sL3NIh22phfMgVR0/abpWG03q?=
 =?us-ascii?Q?ZeouDzGisnTioVSYfInA3mL2Q9cpkFF7jVySXmUteqezerHwca1zmeD3l6hI?=
 =?us-ascii?Q?pktQUhvIibKXtl6feu34OhDD5aT/078PjeYcEg2YodFPsa1IBX1UJpJiCOtZ?=
 =?us-ascii?Q?ChH7cSZjOjHXwE5qwx0R+s01S3AS20HEi9ECv/S1EViGzPT1Nn/+a/HjGR0D?=
 =?us-ascii?Q?w33kktNuIyA0sqQvQkLG2KrFDv7kdZEr9eVZJokLTDpkHR6wmSHUkO/fFrY4?=
 =?us-ascii?Q?bDk2BGTheQOsgJTNZ6R8b/I+wK5gANYZxYyaIgDb7tRpeu/6L8F9hKPH6AQN?=
 =?us-ascii?Q?Uf5ae5Ivmj1QxbtkWqpsXxEWr8qs7kwUejHj8CzBi+dRZyGNWOP3XsCZ35Q7?=
 =?us-ascii?Q?ibgiHuO6+8r6MH5QxXiwnbAalfTx87cH8sBm9UtLYUdloW3AxnBfXBLxQuPo?=
 =?us-ascii?Q?QNNx3rvtBIehWI5rcEW5Mh9iBEAXL5bMGaKHl4mkb0RGLU0F8qpRpb0N0DOZ?=
 =?us-ascii?Q?GptJ2+sRoa4x0QBY8kQdFpnDXu3oXtJit769GmyIvOZFW21YBA2y43dKxIdc?=
 =?us-ascii?Q?tR8dTGYrHtgfp7IA8+G/HBv1XlUvoXQVvEY46dzRPCFq4sgddsdiN1GpvRfr?=
 =?us-ascii?Q?PAFJZGIDRY4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?neXMvsutY4KEzrrFXQYpjAovDK9gEyuAe0B1nKZPzNxR60uDO98W2NVe/rzK?=
 =?us-ascii?Q?ag2N+M0QD2X8Q3l97igpkqByCnvbvtOCanOU1h+xDA7Yoi7dyQEZ1u0/Iq3u?=
 =?us-ascii?Q?7f4LvIiHfjkaQcFngaYK7uweTD32cJA/PvvLlCUWAnY1592XBeuQT6+k1NcE?=
 =?us-ascii?Q?yVy2Eq/tmKSYbxNugfJSO8NQ861s+xoTn5nYjR4po2K6J2DZwwdDZklA98Rc?=
 =?us-ascii?Q?yU+ao5omcTQJfTg+b4AJmWCMIMBP6dos06wnSdu2ivWV/cfuSTkhArVoYp8y?=
 =?us-ascii?Q?a5M2xHThcGfZ6Rg07UmAJDktF0xgU0F4jD3bASOtTG88ec8Y8X36NuXFI/5L?=
 =?us-ascii?Q?xzkjC5q3PodvTiVq4p6zHeGvq4A9119ueQMa/aG2UMEB5OpNqDjbZCxaXlLZ?=
 =?us-ascii?Q?TfBAxY59VmYgQgwcoT0NffCmUbQmruxJiqmAOuzbk4SmwdJnw+fjDg+7k4kS?=
 =?us-ascii?Q?y4XB+0YQ1c3gsttacaPhb6f9NxP1JIZN7o+eDU3PJkvNb9wbkJEAR2Z2pMe+?=
 =?us-ascii?Q?9lOP59ryEj5y66fzFMPVM0H263AnD+eSGZ2rF5jCc1nn29vQutKyYjqpxJ31?=
 =?us-ascii?Q?ovTpThwMxU0q4CUCJgNwDRUT0gXYPI8cC6x7r489MwOaH6IfDtP4dz1qAb3M?=
 =?us-ascii?Q?LFxwXWKa0R966Ahdfpvlk17iaoTsclsyryt9fbywT7f2AxqNdSbmUgK4C+J6?=
 =?us-ascii?Q?wvJ98eqorCbiB9Qkp64ChgNeUcYKvEcbRQNfex+/wZSPjyX5yVCQChIPn2wu?=
 =?us-ascii?Q?5cI+Mux9BSf6t9uQFgiCU1dlFqwgOXcbZNqT682B4Im4jMJ1f9edXHReDVpw?=
 =?us-ascii?Q?53HJjOVDGdM/HlW3G4mlkxzjrn5KY5FHqlV+D0no8rb0Xrivk3cGMySM5Lff?=
 =?us-ascii?Q?mIaAhn2g6Rc+1Mfo81Edpy0ZZd8GHopJ1OXMb7vk3jKPE6tTNEyVMt3KhNGq?=
 =?us-ascii?Q?bIJKOUWIuw6HWEiF4DwAZs5XhuNF7kScDZqcd0XOP+qSr5Ejcnq8OceoynSA?=
 =?us-ascii?Q?T4GqelGdAH+qehPCHiDEinnm6NU7YPRq0JD2gBBpD8ZTkMo/6k+S+E9TLynP?=
 =?us-ascii?Q?0KVnx5Murzl3wUGzoAN8ZJp0F6E7u9tWfJH/BoUe3I5ibLZifsGWKHi8v4bL?=
 =?us-ascii?Q?UONYSPWWEWLpUoFnCFdY4o08FkOQYFLkhUKfjI7jOe2EpeZzcX94y3Qnp06T?=
 =?us-ascii?Q?FDyA44QKV6zb1lS9clxinuvBBY44OqfPg9yxQUQnvxTy2go3B2/c/VVPwuNd?=
 =?us-ascii?Q?s9XZJoIrJQxMKknoP5z0h7tZbnH0+pG24/zNf70GMCr5CfFbz1Epk+spaj6N?=
 =?us-ascii?Q?W6CicCh/yeiI/ivu7Fn8IiMqjI3jgvXUl4oiVYME8LJXgTC4tTn9ftu6Yrfm?=
 =?us-ascii?Q?uFswu5CVkTm+kVGfWmor/Ejs5JvFueXboGo6SmkHVythf22sg262ANu7wFEX?=
 =?us-ascii?Q?42pTCC7wHHOYjZ7+MEGD102MCmyzU9pdnshdwXw1ngZlJy0ZOLlBmSvJdXHu?=
 =?us-ascii?Q?TOd5BAFnXciC0lk1k915pJ39XoQe/HpkxcqOsyVRIPa4RNJAKqOcVYQEj/tV?=
 =?us-ascii?Q?b2L22b0TLlT6/e+lAYU/l3GXPe5XY4KqxE+g+Mc1IOQ4iyNPDZ4f8EXYSCcF?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca16cd7-a343-4c87-cb5e-08dcdd032455
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 01:41:14.5188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BZklaiD4TFMPHybHQAK30y19mDi1nRhUi60I7cm0y6Z+NxIVw/Zf40+0uwH5zWG/gxtelm2uMU2V79dNENj1e+JfCqUdy66qhOo4Snbty4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5645
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

