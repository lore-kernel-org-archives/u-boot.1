Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0947CC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 09:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FACE88979;
	Wed, 31 Jul 2024 11:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Hloo0kx5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71B3A889E0; Wed, 31 Jul 2024 11:21:47 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20702.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::702])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B71FB889D3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 11:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6rt4I1jxR+vViSG2UG+ZbAwXPSU7bx32DKVrQjklmUCSvc89N8O6LBPdB5R+m3GFJaxme9KQOAg/GPAdV9gV5ym8yVPR50S4VH/92gepIauLU6bmM8xT9+ibB+9ZTbYVb+R6lwe99LgfxzTB9+9lgHREA0PSc2MkoHyzHNrQfFApdc4yBPY7w3NM32A9OUVmfONLjLsJkbKx4a8t3M/OHPXQuMTThPphBvag3nEyzYKyS6QeSxZNcg4KGoapHyqkg2Xa/JviCLX2fkDGmVdah6nTlYAyPFQ7MG5WPykR6QHlBbbYBOREfb1YYjTCfexzyP/7bxGtljTvfh6o27fPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1h3vxyMLYGQObX5jLjBChuy6wcjq44izjcT+7AvEc4=;
 b=Jy+fRRuK2fz+PTZT1HxuCVaQP3jyWAf8BrtqOii8xDxD6Iw+NlvdSRjv0yYOMHGqX7kxPkoKGi3ZWNDVWGM6AOHjNLZicAO2nf9Xs1Z6a8O0B5tSxq6q6ig2ZRlD99Fd+vqfJHMSUp36MGLHpTmFN2hjNhWoBBePE4XJtaiyh9pv4+7M39zUnFd6sxuw30DEsfAKn6bXYWjgLHUofAMl94GRAZt404+0jiEEcS83nMijC85ggkVPNRwNI08kDdHqDQgJivAuo6DLiSs9ve7FXkrlOxObM2wgXrLBKs1MxPgpx7GG+9AFxBCWjpx97XVZc7lbJlNtqRXZ8DUnSTgwSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1h3vxyMLYGQObX5jLjBChuy6wcjq44izjcT+7AvEc4=;
 b=Hloo0kx5p2wW9nfcY42kgohA2RVpq2LcFn1bS10pDzqw0tN52BIdbj4Fn+F+Wx1XGKOJK75h05w3NDSk7+KxjVsanscxrHjap1SL2udO/nYcME47dzbDyZDV4SrQKCW9sTwKrxTduIzFffaj/aGKk6jVBx4PFHIhvuNhpSk/iIq7Gf+0zGu1slxhvjMOWi1XbboPveHZoZrY6Hw09xM2Y2g+9QYN2zHwCSELMzGiYFLoehI5mY7cnLgHU75sXWKnAxA9D0DjC37gnCIgGE7eXgA26YYKZneD69NVElbS8JcLVmvoUzVLgC6gTms6QOANmZs6/I9XVU/EkZWlpOFhtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10180.eurprd08.prod.outlook.com (2603:10a6:20b:62d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 09:21:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 09:21:43 +0000
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
Subject: [PATCH v3 7/9] net/tcp: simplify tcp header filling code
Date: Wed, 31 Jul 2024 13:21:08 +0400
Message-Id: <20240731092110.4027134-8-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 4792af62-be2d-4f48-e0e2-08dcb1423103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wiS85CA+Blc5rhcG6sAfipVZm7oCBdLBZCzmq6+5pHnF3WjO//inYEldOuie?=
 =?us-ascii?Q?NIodhHES8Y3z7Z8gCmO9OWSf7IgMpaVCN4f+9yPKOa/dW39Wzb42eXgKjw24?=
 =?us-ascii?Q?sqjeKa0TkgpiQ9FMVM73pzsQRbD78pXXt9BpfPdAQUeEW/MEMedV1LEh8DlF?=
 =?us-ascii?Q?AC91+1VsKkjLpeKT2niko3iI0e8oi/wD7qfdtxFUCFZLZq+HdnoaRMIvIH2I?=
 =?us-ascii?Q?MY80CdWzQB49+5dBSZT/rY7ubx1f64hYvpCBUldql7SHiiflLjIZKm9vmDvr?=
 =?us-ascii?Q?TFG6U4LqBf+JLR++YIf+03O3XSaUjv5KMmfCS6bu2MihAttZTrc+6NNjlbaD?=
 =?us-ascii?Q?C9pkbN6Gi/YiIGzZXHEsLX1mkZA88bVfEsTfUZr8toy33Whhw1LOm8gvhW4B?=
 =?us-ascii?Q?q5/PQu0uyYCzTinSgtVbOWNMRNRlSxYadjwMFz3ODV4N3ZvET6rCKbBrhhB2?=
 =?us-ascii?Q?8Vlda1PcVUYUA7ux3mPBf2ZDckeTPdKYemwxoVV2YhyNDz3zIeh1xyHFLwkC?=
 =?us-ascii?Q?NeDKNcxD1wj4klObP2gy59+7wNxYf8cpNCrUQiHMRLSS+ZR01BHHzD1r6vGl?=
 =?us-ascii?Q?z42oelu+EgTLd9idNveZlL59TyKb/26nCWXSGcIoG+0FVHxLD6SfbjTMwC+X?=
 =?us-ascii?Q?muRHuMzOqew+rd/8ow/ns4LhYP4JO8snEFfNy12PYZU80OHhGEJJqdT4KHV1?=
 =?us-ascii?Q?RuzfPa1vd29Qi6V2JBmHmngc7V0y/K6hvxon2o8E+51XLRLZz7vEje5Dg/WV?=
 =?us-ascii?Q?mWjQvB7h0CXrxbzQC5/XecoRPd+ossJyIIkvdhF1tUmgw08620jv0Xe81/b/?=
 =?us-ascii?Q?ip8DbAJDskk92rI8iWgaIS+X9Xu8Ara6fpkhLH3Uc8OCdsbCu4ni+c3lbLwc?=
 =?us-ascii?Q?sUDVF+Havbuhq1tBrGbEwL1z3P2lE7wIyK9DwgK2Avpbinfh0HrRF6WaO8kK?=
 =?us-ascii?Q?MJdGu/xWo3Lm7h/MHwL+FW25Q5j2SG38ptpIJFS9+/oSgShUssrgPjfgXc1j?=
 =?us-ascii?Q?37JeXNmUHOv0N5Y3B4xTeSdBf9eMrIS/vdJPqc/Nkjd/fsUMNdJvupKm+p7L?=
 =?us-ascii?Q?BdRT2utDDMMupkKfjiotdzMdCJMTEfGuecemGIYkTu6FUL+T8z5ALQN6xTUV?=
 =?us-ascii?Q?mXX7txMuZ+T5kKJ7lpmEFXS9jkuydelESMpUS5ITpy9Cv0/XGpbIwjojUk3J?=
 =?us-ascii?Q?ym9TK40Uaa0eroVDYFT6wwUKhASZVqI1rEp0QPDhwuzVk37y3w3CUjNu5IOe?=
 =?us-ascii?Q?Fb3FgMrSpW9agivlROGzPrwQN+2bJRTNQBjbUf0XNIrcuKv8FpLZuR8f0qMY?=
 =?us-ascii?Q?3+gbM542urZAKNCPdT/JhwZcYQbHGyw6KST9fYZe5SlzFpoeGLdJNdNM7IRm?=
 =?us-ascii?Q?VO1DTOViBnaNAEYuJk/rGXF+dlDZts/tx8WqVDXwkcM6F1Mw5znd5Vb3qoJ3?=
 =?us-ascii?Q?EWZQ7w5ZsYw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?upV9RLi6JWPmAMy1vKgNm0xzEpPudtlOORVpCIXJgWUEgFBdPoQVU4vU/e1u?=
 =?us-ascii?Q?U0MQHpjmhjDsxJTp3L142D07Gvbg+i5O0i7t/jHsvPNOILsbyEmQ0cjFDyd3?=
 =?us-ascii?Q?QoO4UhR3zkMyEfNN70VUYIOMguyZdDJN/Pspnwvuu+yCcAzPbunIx1ZZJoLM?=
 =?us-ascii?Q?SWEbAzXa5NxWb2Z5xuKY9n6CGwz7CNvUArgbyHHAVG9jvCWGGjU4b3HHXPxu?=
 =?us-ascii?Q?JmzSpR+NFrv30sFVK5yXTlnu5k/Wi64Egp7A7L+2j5Ahznd/0DHb3K5jwcwl?=
 =?us-ascii?Q?9KAx+g08lhsRFyRl8EnmYnXzXuwf5ASirg1FMlvQxSZdKOTr19dKW/AFTR7X?=
 =?us-ascii?Q?Q17DS0R+3YBq6u9yJt+hbDhncVx2QGWmZJGMeSqtpsyGjQN0R4Fz/muvFiCT?=
 =?us-ascii?Q?Nhff6joMaT6/LnolxO+YOD0mEcXbnQ2J0xJsy19PCD4MsJ1eEiTo3DD3li9s?=
 =?us-ascii?Q?FwnNqh6Qr8plnxRE5t8VBXAXJ1Drqmn8BTQVjY2R+Q2qH6iFu1jqm2BidKoD?=
 =?us-ascii?Q?0mekNG8fRXSlxOGdUSeOdGoF5sl/w1rvEdNEnsAYEgWA3NCakQ+N5ezR2B51?=
 =?us-ascii?Q?YfE726WCGQuuG3vCbU3SPpklFTUjCqFIaN0A2slxpnWB6ph+ivzVkDbmCROB?=
 =?us-ascii?Q?DAmBfWelBdcGTMtfjB+Hx6g/CI26LKEjqEooCAnpLOe58fE2SB2YGKck0vzw?=
 =?us-ascii?Q?Unii3GO4e+vKgqNBQkphj6q09TUw31zP/Ybp0lqhOgPo9yIEXksivsM3Ug77?=
 =?us-ascii?Q?cfUG/o5AVXdaa/1FSyJK+Bg2VsBOnXGkEvbK/pIvwkSYVvKfJSHPlsO/+FCL?=
 =?us-ascii?Q?CgZJULcQy+eZg5ebytbBkCMNZf/dn9CdhOWkSAfZRwxEq3YS3xTHoDUS0gUl?=
 =?us-ascii?Q?1tLXuLXcRcUzxI7luD+eZwSE1qJyRN9IlzsPcd3pzGE2R4+jmn1mk2fdEh3d?=
 =?us-ascii?Q?BJ1SaUZbCsb/O/m38wLlqQHBc8jh8kjedvoisyfU8ijthuhskWPpjg++IeRF?=
 =?us-ascii?Q?NLbMxTSTTD2Ox1B57UZ6Qzn96lB7KV26iygB3MVSG+kHlfvUsOCM/6AXw0Yq?=
 =?us-ascii?Q?kUyOpeHn3QOOQikdBeuEfzvjfdbgYNEMz7zxRDm8gqa5oacdRoyxLJeW6HgK?=
 =?us-ascii?Q?YPGmuqFSaQ+51TnGbFg8gJYcJDeq0GIzSlzRjGd1BQOnaWuIMBPkwa8bMep8?=
 =?us-ascii?Q?T+Mf0qr4l3XlHnyRch3COkTzsoTjDV4AQ0bWA7SKUwvCujS5wVa3JIvubIQ3?=
 =?us-ascii?Q?j+ufDKp9wqkEZL4V7anPQG3s+avGchz28IPU04QT8C69jKkgNuoD2Bx4ko70?=
 =?us-ascii?Q?zKnFxY5zcUUNALXWCc4Kk/r6OT2D+d0km3bxpnjf8VqUrgPKADwG958DuC4b?=
 =?us-ascii?Q?/Y3pTktkmXkmeDUrpj9fxTt71IaUpB9x2+d+67jVqH6JzAZn2es9D/njKiZx?=
 =?us-ascii?Q?M0BTaqiZnh5u71qUvVWXcp2qlhxrS97lzd+EG2MEXEunpHXGTnU1GcWwEVIc?=
 =?us-ascii?Q?3VX+Pcw8XPb61U8DjtKb4yRUWNvVZWsJEzSAhZ09D81QQ+ErvdY8tA+U4FIu?=
 =?us-ascii?Q?IHjBxl2dxbsSEMVUmLs/U+qwtrU676maSfIHnfkyhCB18bm+fZJV6R3Oiqun?=
 =?us-ascii?Q?4XABt/nwJ+76MXXC7r1xT/8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4792af62-be2d-4f48-e0e2-08dcb1423103
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 09:21:42.9676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRe0riBpVgiG3B7FaR1w/7kq/owgJMmju+0TFmvSkn0I5rvFEkGMNYZr+OH/DID1uRtACUyf6yn1PcJFuLeEgO4OPQV/JY1VzbD9kKcwacQ=
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

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 net/tcp.c | 70 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index 2c34556c26d..7014d5b4f43 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -527,10 +527,37 @@ void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
 	b->ip.end = TCP_O_END;
 }
 
+const char *tcpflags_to_str(char tcpflags, char *buf, int size)
+{
+	int i = 0, len;
+	char *orig = buf;
+	const struct {
+		int		bit;
+		const char	*name;
+	} desc[] = {{TCP_RST, "RST"}, {TCP_SYN, "SYN"}, {TCP_PUSH, "PSH"},
+		    {TCP_FIN, "FIN"}, {TCP_ACK, "ACK"}, {0, NULL}};
+
+	*orig = '\0';
+	while (desc[i].name != NULL) {
+		len = strlen(desc[i].name);
+		if (size <= len + 1)
+			break;
+		if (buf != orig) {
+			*buf++ = ',';
+			size--;
+		}
+		strcpy(buf, desc[i].name);
+		buf += len;
+		size -= len;
+	}
+	return orig;
+}
+
 int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 		       u8 action, u32 tcp_seq_num, u32 tcp_ack_num)
 {
 	union tcp_build_pkt *b = (union tcp_build_pkt *)pkt;
+	char buf[24];
 	int pkt_hdr_len;
 	int pkt_len;
 	int tcp_len;
@@ -540,55 +567,32 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 	 *         4 bits reserved options
 	 */
 	b->ip.hdr.tcp_flags = action;
-	pkt_hdr_len = IP_TCP_HDR_SIZE;
 	b->ip.hdr.tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(LEN_B_TO_DW(TCP_HDR_SIZE));
 
 	switch (action) {
 	case TCP_SYN:
 		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:SYN (%pI4, %pI4, sq=%u, ak=%u)\n",
-			   &tcp->rhost, &net_ip,
-			   tcp_seq_num, tcp_ack_num);
+			   "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
+			   tcpflags_to_str(action, buf, sizeof(buf)),
+			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
 		net_set_syn_options(tcp, b);
 		pkt_hdr_len = IP_TCP_O_SIZE;
 		break;
-	case TCP_SYN | TCP_ACK:
-	case TCP_ACK:
-		pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
-		b->ip.hdr.tcp_flags = action;
-		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:ACK (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
-			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num,
-			   action);
-		break;
-	case TCP_FIN:
-		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:FIN  (%pI4, %pI4, s=%u, a=%u)\n",
-			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
-		payload_len = 0;
-		pkt_hdr_len = IP_TCP_HDR_SIZE;
-		break;
 	case TCP_RST | TCP_ACK:
 	case TCP_RST:
 		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:RST  (%pI4, %pI4, s=%u, a=%u)\n",
+			   "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
+			   tcpflags_to_str(action, buf, sizeof(buf)),
 			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
+		pkt_hdr_len = IP_TCP_HDR_SIZE;
 		break;
-	/* Notify connection closing */
-	case (TCP_FIN | TCP_ACK):
-	case (TCP_FIN | TCP_ACK | TCP_PUSH):
-		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:FIN ACK PSH(%pI4, %pI4, s=%u, a=%u, A=%x)\n",
-			   &tcp->rhost, &net_ip,
-			   tcp_seq_num, tcp_ack_num, action);
-		fallthrough;
 	default:
 		pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
-		b->ip.hdr.tcp_flags = action | TCP_PUSH | TCP_ACK;
 		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:dft  (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
-			   &tcp->rhost, &net_ip,
-			   tcp_seq_num, tcp_ack_num, action);
+			   "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
+			   tcpflags_to_str(action, buf, sizeof(buf)),
+			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
+		break;
 	}
 
 	pkt_len	= pkt_hdr_len + payload_len;
-- 
2.39.2

