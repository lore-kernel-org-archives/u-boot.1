Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F3FE77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3C0F89688;
	Wed,  4 Dec 2024 00:01:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="PuyPwsW9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1A6E89550; Wed,  4 Dec 2024 00:01:05 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20721.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::721])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B491789667
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:01:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYoyrd8CFcxk4aVzVEjH6C8Tc+jHpfNFcqYMYSTjN8bXbkQ23MKLbqI9hvv/Ptcp3fPns6tu9WKl72RltixSVE9Y7D+Ez1JNZ2IgnTtcq8QIF5dUFhIxCB53lvdHraU1uKf3AHJdAHLH6Qq1zT7FxW6ltIhldCvy/5TOFZ2SIQ//RKERenM/ou8EYrpmpf9lvWOfaHIrlu1CaUVYGHaxkpbLafcM9c1H/v7upYbPhWxdE6H0GtZxvOF9YlBLSURiZV+rN/ft3496tlFbNa3i2/IlAqJdFmoL4ZeJO2c3nDbXRvSwg4Fn7YPBz7yi9Ooet4Xmua975CPH77oEouH0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=ewdpTfocG20V9gDIMEmrQVF/x4zz4BqGqjZrkZD+x0YCZqfuh69Kpapba6SgQe0jaZtZYj1+Y63Hbx0eClMxDVsWzxNWoMOIft+Pjk0dmyGzuT0SLeD0mhANk0gEXNcshGgYEoalc5mhkpWzlQuN58LTYF/HEmNddPMVMurXdE28gupSgWfrjM7hTMD31Fn0aXlH7cRFYG+XIQ7rUFPTRCYAwM9Sbz5eG5Q43S+Ir5b9nXSuH7Lux4LaKL3tw4KiHWB4ActkSSCbgObQGCsrYmZasPbgO+1mlwCvLstsIxVB+N4a2vvcdYs8cIjQ7Kg+pbQ8ccpD5EUXFHhRTkyHhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=PuyPwsW9cnTSeIWfCK95jGkjB9M0HuShAn42qyKFfzBhPKJMaxyJ4rlJjmDYwUbnp3YDgpzOMMr3Ro0G8DmOA7LyBj3R8QtLPR5GmFgRzKXX4Dj+pxC/0XELjgkVIVj7Y+uUEgedKGi10AGM5VyAOXwUyE6GMA8howNdqUiNj5025I9FT9VdVVNoaEGHBSy9zAa0+wA8/+xoshRCIuSK8zFY2lj39SWzxaKS3oGLQX1eisMI53TbOvq1hGccyfx0ROdyRUc0UPv82HSr5EhYzh03Wum4ePjDEf1Q0qGfZgvayDYZnN4sg6v8twmStA0kfdmUh8ljNFXGnS4fNeZQOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7611.eurprd08.prod.outlook.com (2603:10a6:20b:476::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 23:01:00 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 23:01:00 +0000
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
Subject: [PATCH v14 02/10] net/tcp: fix selective acknowledge
Date: Wed,  4 Dec 2024 02:00:41 +0300
Message-ID: <20241203230049.2677155-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 7677545a-524c-4d27-9774-08dd13ee5ab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PexOvYmtPB8YnwMosIid78i53z50oEv78cktvTIFx5TizcKIO+jQbaF1jhtI?=
 =?us-ascii?Q?faigu5p4ISEXt+ZhXzLHC53d4Be8korFqqYFfDs3GgIF2F3GUbtrzT1uh2WO?=
 =?us-ascii?Q?VDTjy9P75wNtqZOohHFKEvCCJdVS0Vi4roE9zW8qe1xHoMsgAF4jEWtLyTOM?=
 =?us-ascii?Q?TcZryjwEYihaWUaaSbzEIkHSXCARfp6+ZzYvBVI5wwlKTPpvE0jWiSOVNfNf?=
 =?us-ascii?Q?oQwlMEfBAZnEuT7l8F4vdXoBeQu0MpRz06u9kPeenefgwHebfmzN63AWSk4t?=
 =?us-ascii?Q?i61HtCqNcw68HR3T6EiJ5Wyg9JaLbsQpzuSkw/lZWsrikHdpHvhJl9FwXLHW?=
 =?us-ascii?Q?c5oDR6kXEjkcw5cUfJYcoZ4VfDAJFw5eH4k6jNlvsWfhp2ciSlphW2eel/06?=
 =?us-ascii?Q?aPlWUtrNvl6J6moIaiKZRvKs35LtUlRGVJDzOPDSFYr9O5o26M9QTWcFeCmf?=
 =?us-ascii?Q?9nNlKORbHs1KlPMQBX5SxlgfUOy3atNYCVMYbbmW+TapSAlueU+n6plnj7/u?=
 =?us-ascii?Q?jKkPDD4Xg8XOGrLqMwRwlX1tAMHHY+S65CmeiVHrcvACRWzFqn+vvnuc96hf?=
 =?us-ascii?Q?8AVy5XbpE1uGKT9LzH6GVzxLhYP1T7kOx0qSCQvEOZgOIyS1xcghffIsUyJs?=
 =?us-ascii?Q?EE+Ps8UZvwp0t/XWldEqVPQUvL7Z8BmCAu9IIfnAmxqf0uxr0BkDCvveI9R5?=
 =?us-ascii?Q?ongWGVmNAH1/1kPyL7YFY83KmxjDmIlpj6I2pHT+hoJeDdDxGfuGvFOdt2xB?=
 =?us-ascii?Q?SUhTA+RruEqdg1uir2G79tqWpY1Ac1vO4ppQV9C7351EJyLicvouzRj9i94o?=
 =?us-ascii?Q?iKDBYmLkS/fBEUnFmxYn8DnXFgL5IYolJsJxzng+5g/Kjo4ywBXHaZJgSdPG?=
 =?us-ascii?Q?DsI69DyoP52xDaYntORcdv3E5wTeK4BvXesmICV+XKV1uH3zFPUnJMoxoBBj?=
 =?us-ascii?Q?qvxr69caTmBnnVB9Esg72MGseufPPRw6m3xZnVWYpBsRH0t52mA0Xcwjybrf?=
 =?us-ascii?Q?HFswsZnhuVFlwkoo3+CnBfah8r43y0E6O7jSYXPDyrcdOcZzn59SeX6Sg9wf?=
 =?us-ascii?Q?UHqLN9ilLTliVUkl7YNndTmHr0hnMVIP1ZmE5VKKezDgGiLqJGOmYyMlLzsP?=
 =?us-ascii?Q?obxVvYHQsIJUOz9ONXiRdspwbVw86xq5N3512Ad2rNVYUQ4K2Wgkfgz9z8XB?=
 =?us-ascii?Q?UmCsd1yOvfKJ3mcQvbGEWyZQsq38oDAz5EoPUMUGSP0bec6OVv6oHVSv+sFy?=
 =?us-ascii?Q?a8pqbAtpPFt7QthyNjk5/TNrFdXHrgg+t/nyvZVbglBRlg1JNVkzgAuIBd/e?=
 =?us-ascii?Q?63/PXMITQUZqtNs4fVd0Rm6bBgDxlxh+yavfe6ctJ4tYAO6CiVIKlc2dMT9q?=
 =?us-ascii?Q?EddcYNztxknryu0aJPP20QRUES3SIUAEbivq6oYfMw8ExHoBfp0G0+TQnJYp?=
 =?us-ascii?Q?kFp/PgGtRdE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ZmsoFPMeQGpR5NvDXV5kSTHW9wM6Qhgn+uqGQalPcq0JVeyGqqO/YRIuD1O?=
 =?us-ascii?Q?HUF3Ggtd/l4eTBQQDXhx05IgloiiA2J64eaoSXa9xNypRmjZO2rWm4ekZIBa?=
 =?us-ascii?Q?/ABtFvTLZqsQJGMoJ4/Xu/VCFCTYgtCQ4kBDTHjQBkbmZk7j+q971ZKczwya?=
 =?us-ascii?Q?l8pKE2W8ZXs1ld6PrrgJaVX6yQlqMeNdw+XHJU6S5OFNA6OXeXyVuEYnI9dT?=
 =?us-ascii?Q?OtHx02wtqxA88Ut1t3D6pH7A/K7ZB63fZOSlcT13eA3OVsOWbIK6SvImUoM4?=
 =?us-ascii?Q?1zvsJ8TrxxL3PU6kaaVXU+Lzg4HkzXHHgsNbcYZiTMMAY/fXGrz4NqRhGXTv?=
 =?us-ascii?Q?kbwFNmwBdNq5paK2AxbLsFTNkBiw6F/0NY8ZQ1x592gSDxKHum5NV8BLMtJI?=
 =?us-ascii?Q?VGo3PanoQqvF2se2hcHS3hjxxy+Zu4fLq7jMIfHwMm83zmke82eNXIj0I2AC?=
 =?us-ascii?Q?YXur6PhP3tSobGqO64NYcsUwpYcr8Vv7Jns23bkBzAx0EONfLYgsUVxYsA8M?=
 =?us-ascii?Q?HxSaMEQR4bx8ubT5Fw6O8bLUTfPFy+UGhxvIUszXxjCtLKW7Ckidc4jbsB0T?=
 =?us-ascii?Q?m38uGn5Pj2etfHNlU1Vk86DCQFTgOSS6JbG+jWZMAPR5z9hldXBIrPZmfOjC?=
 =?us-ascii?Q?xOw2pKg7kffFs5U16TT6fa1J2OgmvCH+Fqx72zz+jSky+23Vv66eW/DKMQm3?=
 =?us-ascii?Q?JIOvi70r4f8zGRZz72wIlQ5z8TO+tTvDQIpDRqvemAEw7m42dxB3KKzMN+VT?=
 =?us-ascii?Q?nkSJT2f2mgg9CeUGQoBAnGUPcbuRRV5VuJHcpCLqYW7SlDyCN8HHZiTA0B87?=
 =?us-ascii?Q?tfB78QmqNKAhm5/xDmEh9P29yNaNNj3It8xZK/S96tzr0SKTst41fwmm4uYd?=
 =?us-ascii?Q?vSddzNGj89UedYsixeVu0GKy7lfI8WYr6w60FGfJwNJ/eqtHbnpgicGuZBSJ?=
 =?us-ascii?Q?46h97sQpKtneOxa1J6O6MQWazmOgUXgdxR2pVYJ28RjK1pcF/V9iLry0qRwK?=
 =?us-ascii?Q?5Uak9NIML64ZS/AloyCwcItFpheSoYtOf+c+Z7nu7S8On8fR84zWdQ9nuKXU?=
 =?us-ascii?Q?CRjFSr7nz9cxUI6I62r+9KdX+g/NNjJ+9SovZ9avbgdAHH7ajVWzjvT82hUb?=
 =?us-ascii?Q?5IG4VAuPHnw77D4PG6hW4BWPzQVuGAufTlIneo9Z3gUXplydeD8lfuCTJP8m?=
 =?us-ascii?Q?VsHX/Y+nGoMO4ydTPoXSwIIuJxAwtMpbsMEKpSDM9rPnqhLCwUOgNGrs26rc?=
 =?us-ascii?Q?bzdf/5qvU3NOG+R0p4dIhwTwJWnadBgs8BrJNwzk8V+YjxKHlyONcE5R/Fco?=
 =?us-ascii?Q?noEEF67p/9VjNefWJfYzfER2EsfZEb8nYoQYxdlGjUgdG4rWbs+NLmjAp+G3?=
 =?us-ascii?Q?bi1FPhUZ6ROdVYufnR2eB7oIN74FGMVtpDfsa9nIp/pQt34EFA8Vcmxo6isI?=
 =?us-ascii?Q?cOJl309U9XcUBBaHiOL12QWPtJWSHXMS8aYEGdK+JIAJTZy6wQojQi7qkgWR?=
 =?us-ascii?Q?kkpQQDsIe6j85zfXObV1vBOawXpwLv9m4QfHbPxvZDdw2ndqqWGwro8jbjH5?=
 =?us-ascii?Q?WXryknNth83q38Gtx+pgPJx5RVHXOU5Lkrjy+r3aQzPEuE2Bgi2dqdpFMcRJ?=
 =?us-ascii?Q?h/PVpFyUbtbV/AQDDHCVCkg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7677545a-524c-4d27-9774-08dd13ee5ab5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 23:01:00.2878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcuN9SBRx9OiSc8+zx37lOkHJ+vHhvZAfsCXi3ciyqoZPmsE6OzlyKxWcr34w9MJi5rTx1rN4AfsUKG36u+imuVG4feaUh1fBJz4dTNenjc=
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

