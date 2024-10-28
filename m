Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD65BD3398C
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 14:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EEF789085;
	Mon, 28 Oct 2024 15:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="uC3EGf5l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 132E3890FC; Mon, 28 Oct 2024 15:32:07 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20721.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::721])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F11FE89080
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 15:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPIX1NHbL7wnTEJpQUzyCgiP44i0Bf6KjawbStuyzNqQyvQUgkLZBZ8kGk0DYHgfyVfVYex02ay6oaTuojNvCqpX9CmjOxCOpWP2NEm/E1+UM/0WOpOUn9zZvwpRwbLrsPYVv6YcL3HcjfES8FJBPpmmJtrFAsJMk0QSz3Mpc5MG+PBPHqJm9m0I8IoGZcHqMwUWCVdIBzEPd4hfsyoMKVQ2S1Rtyvm4i2vXe+xy7BWn9lIXVM8+SvCqYE/tzv3m92X/svRYEFAbIijNlER9y6LKDId/GL1s2wJ5nvF3t08PKWklyrWPKCfrM0lZugp3ygtQBLanyLOuOA3jKmaY9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1W/OM+rApXuK7t+R9S3YJe3h+F7fm++LQERW7aZmpA=;
 b=Lp0+lHqbfT6HyK95GTCdlfUbrhZzwOsdU+/NgjdmwWP4sv80DBTKAkEQTC2W7kwc6tZl9X8DWlVD0ueb62X1p2XSCnsX5TYqzc2jdpDt7A1MsT5T/rNSwmNPlwA7WK1SUYzIeox/oEM3Msxe66hXkRlWwmumIBIDOg8iEBU4x8kjQjSn7QuvAZEx1FscXL2pLq+1VntXLJ3j4GDDhogSvPVWw+U+MofnlVqpPeVN5qu/sg9k9ezmeET9V4j7o8T0hl3AYE3lc4lAsIwWclmG/5qqtem4jEXGmmkrvRnoihHvuY1veCdPyBNpdrLdCTYn4Tr7GFUC1rBLTDD4HN/CiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1W/OM+rApXuK7t+R9S3YJe3h+F7fm++LQERW7aZmpA=;
 b=uC3EGf5lweXZ7nsg5G3pUVQjyekaP1EaONguXT3VzgDemPx0O0iQTzuQM/qPTfcGxvC6ERkXt71sulYxNXoH53qH1502kz8dnT+vRVPHR3wvuzcgMPSkPWq4WkFF2MFkFLflT/e1fG8ak8brTbYq8MKMZa3vTj4flQ25b+5HtATS7NaaD+vx+Nx3JjPqKxUkwd9ldAgdDsV1NpZw0SGbTJaasseAVrjNjMs7VMJxyD/F8q1S7Tn852WgoqYOIloYyy4Nbclg2iQ/Pw1XnJGVnyq/JGHGCeVdRaknzWw/ge8RmQAyF6AcVYG7mS0e+LoYemGf/dBBDuv4qe2cFHhheA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7714.eurprd08.prod.outlook.com (2603:10a6:10:3be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 14:32:00 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 14:32:00 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v12 05/13] net/tcp: rename ack_edge and seq_init to more
 common rcv_nxt and irs
Date: Mon, 28 Oct 2024 17:31:35 +0300
Message-ID: <20241028143143.1807305-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0101.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::27) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 197591af-180d-469b-801b-08dcf75d4862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nnTTzue1VMKJ+K17vwwIEIQB0mh+B7wl8VZSDIgf5Mebjv6VZg/fS7bnhO9l?=
 =?us-ascii?Q?vBha1bWkjYRrhnOvvMxLuwenboyG0IioQjyBlUjcQnTi2FoCEJT7HtPE/wFn?=
 =?us-ascii?Q?kik4SsCwdO7Jfq3xgiEYC6XuFOLs9ipSqkWlUblqMmT4viLAoOAHuu1Jljf9?=
 =?us-ascii?Q?F8imJylnt0OO8zOTn+FkxZih+yk7ivTccAcUb3v17kKMTE44szc6ThketUHm?=
 =?us-ascii?Q?s/hVyNcy8ln8kp3qs6IrpFWJGeq88iPDJnyA3+n/xxWSpI7sjX/TdkJOSjF9?=
 =?us-ascii?Q?JPPcOw5BwVYeCuVI34iKVlSczOR8pTa7I1Krr59C/cX2GhkSnLkk6YU/M1YB?=
 =?us-ascii?Q?H3T9BVuZ9/jmLZHQVY3+vv7hrxfBwkpTmH5kiS9NTDuVRHzaOvQdussFFS+t?=
 =?us-ascii?Q?NVwThYK1WFk91r9aC+SLn/7RK7/GYdJMi8FPapj8yegBbI8RRQ5FzR208Z+W?=
 =?us-ascii?Q?9jcgm5WunwzHI+1PwFQY01SSx1PnrmnKgijRJ26iQ6yyRJL9jTYBwLHrv8J+?=
 =?us-ascii?Q?vUNqBiJqugZV0D4vtrybGGkraOIpLG8cuWM1gVJFXUSSyg3/iO2i6rJs5QYT?=
 =?us-ascii?Q?8SpO5aVPkXuPVJV41kFSD65kD+aPQZzVLZi739rTKHyhRd0zHClJ4rDHddrX?=
 =?us-ascii?Q?2gyJSRdiwhlEr4HZ031Lv4iSETyGi92xR3O5/g2ynoIx/eGHih4BmMmH5lMh?=
 =?us-ascii?Q?0MOu8arK7LwZRkFS0Bo0Gte97VmZw8YGkdnU1B4MXJVXBXoyvbdLYDkUE9gH?=
 =?us-ascii?Q?qVSvA8HSQKfH3qebrrToCRFM5Rbw7wSNbPTuYDEOmydjNoB98Zm8kcvzkkPJ?=
 =?us-ascii?Q?nsfszB02+yGUnOAhz85uGyFM4TXxwi78Wpxc9bUb5I6H8ZOFMVBGJFPgvi6Z?=
 =?us-ascii?Q?lsI7qtRweXgxjs/0+EfpBCRf+mVbOj0hBQf0gJ0SYqSbbdAuhVsyV+DRbeVb?=
 =?us-ascii?Q?7GllXC8Z21WvIkp6qpNTM3D1WsaON5GPj8mflh58Pn8k+zsETbIPJIQ/OBOL?=
 =?us-ascii?Q?0HC4FnVjj6nAVbnUHNoKxJQXjr1TX3aCoc2b4uuQNAxLOCao1NCJHxOMF6LC?=
 =?us-ascii?Q?26+7JGz6/EdU67eFbWaF4pOXgf0EvCtkGmY/ZVzuSVPjJn6z37jCgwoZRFme?=
 =?us-ascii?Q?CK7Hy8TFfBr/qRm6Bm60WjxvBu+mQJIWDjZbtYHWfahXoo2725GAHwIP77aB?=
 =?us-ascii?Q?speeFJvDSdHiuy08hKBQhO9iS+VosJwzRglAyBmDTzQAiIUM8oZaRwnjMk2f?=
 =?us-ascii?Q?Dawp1Gp9U/BY+2k8bqArGyHwRQVFplAzrKSXLATujsNWpIT7p+o5QCqLmd38?=
 =?us-ascii?Q?94o4cJfFbpLIu1FR2V+flMCsYfHK/PX7DUv/Mc/wp4spqg13PAouj7tucRTb?=
 =?us-ascii?Q?/iooLp/5ZQ5U7raAe1KBxXeZxb9O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?52cJvBMBedSo0ZxG5F45sV4po39E6kRANw081oPWidNJWdEcSkz3FXLkJFJi?=
 =?us-ascii?Q?JuYzTJvMLhVUF3YUD1cg5bSn4Sy+wdjfOAGf4foEVdAyydcUmmn2Z4xQ3i5j?=
 =?us-ascii?Q?9P2cME9OG5z+WqfnYlSgijCzrFCTtyccdB6Svk86TcU0jphPYT1vSxZCGIyy?=
 =?us-ascii?Q?zztsdSfCEJRlhIMG9z0n7b35VP9NhX5pSywpoe45EvzO9jtbiO1gR1L6aYbF?=
 =?us-ascii?Q?lyPsQ+K6ImRdMZO1GbIYfEllFllUYGrPoB0BWYjBPll/ugoqQWT0Mxe+uSdc?=
 =?us-ascii?Q?770vBwS+VgayBNcGsOwpzkrF2Zk23/cWQ1mrA9OVy6cEWiZIZEGSAk4t2p8i?=
 =?us-ascii?Q?QBDplY1miLuqAWJ42kPHp4Yh5r8SmhkkCW9XQfEBhqk0o09RzCiYWPapSQ+P?=
 =?us-ascii?Q?RHTlyKJrpSukGcJR6Y/7RAw8hX4A8ooXubgpn4LnzmeT014KGqARvfdItABl?=
 =?us-ascii?Q?REEExkY1PYCVOW1hBpc4YZSoGf/IfeXfT1xQukXxegVo/RxcqSnR4IpHXfp5?=
 =?us-ascii?Q?KMW+5i97s1qUB+YhTkNjudvs1SQ3+hR8AfKJ80BVtYWhFdL1xbALVGq9lcCt?=
 =?us-ascii?Q?JCea0SUPx6Ka6waF3wn3yu0s0u54+SyYTQ0r1+1miFB1pXr4H9wE0F6wKZdk?=
 =?us-ascii?Q?KqWLZcegEBRaBGa+Yr4bo9RW3UkiCDFBBVHd3gWjSOhozToBfR3B1j0GmFoE?=
 =?us-ascii?Q?UHgPo3UqXnT5e1LwxKUk+DA29f+CKL4zVtqo8xSlI36V9bpRn7hak8IKtlEl?=
 =?us-ascii?Q?0S8jrw8w7YihA8JDvT++yOCL57KenYtk7hKWx5xy3tXeEUFxMHP9S1/prKqz?=
 =?us-ascii?Q?VCpRW2S9RDK9tQ7kMRXVNDdG1ikL0haeQFA1UhPh8U0IIQ5bHsmnfp8TsQBT?=
 =?us-ascii?Q?hZMO7OTBDAn8PTPtk/LBy0r2Hpea/pwDgDh7nh9PaYuBOTo6/Okuk7rojBgh?=
 =?us-ascii?Q?M+d2DY4mc5tEyKGcMJwvuDgrVHz9Efk89ReVHgN7nugDqbdfiXubqV4BUPas?=
 =?us-ascii?Q?z2qZsO5QvpqmOmMWtKG4ERKb8IWZhSuog5o5YI5hldkG5OCJmHwCy06PMqe3?=
 =?us-ascii?Q?w6VgBX/SBupKilYnuTMi4bjXj2QGQmw04FTMwysNUU/hAndwUGOtvmqr3KOa?=
 =?us-ascii?Q?Si5o8jwZFC2BWSh9X2XtYCJz2VdWKCJ+/qNPAzrv2n4KqrstJM/1TUhSjOzD?=
 =?us-ascii?Q?XSoIc6FQ4NmNr8frnuUKXd7In53GJHpQcsXndpcYNQpbr+vMOqWmH7+y+HvJ?=
 =?us-ascii?Q?16Pc9Xxp3n0ZhtVr/0BLOXQ0pxBO+2aRVc/kDvHIDNQaGIEak5Xq7WTKbOZw?=
 =?us-ascii?Q?+D+GG7ucj4kkzgffyPCUltEGBaguDAtjaY4X7qH6KunVORX6nv2GzKyK+S3j?=
 =?us-ascii?Q?jMF05cf23XjhwwNxj9doIwBut2qWzFpu9X64ek01f9CvbYh41BhlbDkJzxKN?=
 =?us-ascii?Q?amBg9LBN+Lu49YVkP5L+aCw88yNZq8UANlYquJg1sY+ksgfrC7/BhfD6gHVe?=
 =?us-ascii?Q?jNBMSpUsYgIkuB4aRhPdfdbFRzwdH+ODL9wq3Qz/RBiCdnJTyVDUkARG2/HH?=
 =?us-ascii?Q?gH8xGqKZfZ+4Sgi6tpk8JoBrrsmmSMZod5UCQ+M2I0xEwX8T+MB8NfOY2bbU?=
 =?us-ascii?Q?oecKedsfyx8LV+5Ro8f4Pzs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 197591af-180d-469b-801b-08dcf75d4862
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:31:59.9890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpXbiZcwtvPMpilsumzQczsAnOG1oQTS+YYWgADqjtu4XF9BXMo/0/w861FURfUMZkE2yqouuaENuStMQ0k9/bRvj9zr/lVWhin4fjGPeiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7714
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

