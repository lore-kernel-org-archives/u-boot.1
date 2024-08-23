Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AB1C5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3555B88C42;
	Fri, 23 Aug 2024 22:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="TrvM/6it";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17A2D88B23; Fri, 23 Aug 2024 22:45:39 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BB7188BD2
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5jfRSPw6EEFYT6Tzb8X4hREVGl55UIRK5qzq8tq1kbFHAC6OxAirVajb0LEy86Z7otVoHVMeOl492wt4Z5SmnkX47eq7t1yUJJg4vzo1E+yupyMFdL/V80GZ1+Wjvk7lgPawb53STjlh/Z3MyjcmI9XgQKZde6PL/QysfR0TyWjrvxe3PuEblSQ4cYw2z8ImWop6w5ydc1ewGnLjQ8v2BqqkrAvA2bEIct++daMjnDDo4fxvd+6U01FlS+nXa/bGJiy8IMfuQgRg3NRBJM3dxaGsRsyCYbZWPBgUlqtTiv/kLxRmVISNjGwXWNt3CyKZrdkdtC/69sdyb4gEXA0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvJUazOHoQsPXDqSQ4ygdMPO6cxF2XXx5JLh0nnKsZE=;
 b=ywkhu434nUFC88crJJNPep+/Ogtd4MHYRFJC03wSV2Qg0KKraTC2eWoAxlOogrmxTQ4ZXLTgZ2yfya3/JFiksWQm7BDq5V0uVvvzfQ1kNNLnHoI7h5GUtz4vCGtTTQPzb7mmMXV518L1SWFTX9lui6Yduo3UiwfPZCvTjbtV94rEqcmXrLtXWItgzKQJxhTM68DLYBFKLU6ENn6UxTEGXcU3w8MCFMiXeKJMkJLjs9on8Bq8f/keH6h8Wg5JLjFT8E4Tc1swibBWij8Z3teWE8L0Iq9H6URC546t1dlzsLpgYudwTnEAN7Wd0yWrcr/YQfJm9juJanRoyS33FhgD2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvJUazOHoQsPXDqSQ4ygdMPO6cxF2XXx5JLh0nnKsZE=;
 b=TrvM/6it9E5nbM26UeZSLFmnWY2eOISMLQxc+pikjACwZVj/wo4d7dA1haZ8JGHVdluIo6g1wnaHt+5taUHms/MIOmSKjJMoEIHnPzUelNj1/JO4F0G9kyxQk6sDqs+mqgzkDLn4KFIjhx2yI24I0yXj+VLsB1JPd+HcGIiwnoCk44KbzP7Z8MHRyyho+BJ6kzYqDqRCUiiG+PBMfciKkdsovIgM1beX5wZM+1XerTtRD1Cr43SBXYJo9F0bqoIjp/fEWMTn1t/I1piZ97bSns73nmGs30obHGltqBpyG8sNWsbUWv38WnhY9tm4xC6ewQ/WGWr+1ygwq4N1LYDOYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB11224.eurprd08.prod.outlook.com (2603:10a6:800:251::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.12; Fri, 23 Aug
 2024 20:45:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7897.010; Fri, 23 Aug 2024
 20:45:36 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v4 7/9] net/tcp: simplify tcp header filling code
Date: Fri, 23 Aug 2024 23:45:16 +0300
Message-ID: <20240823204518.1010194-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823204518.1010194-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240823204518.1010194-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0373.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::20) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB11224:EE_
X-MS-Office365-Filtering-Correlation-Id: 7535667a-c693-4792-558d-08dcc3b48a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E1/DsQv4Pve+9iJKooWnQ6/qjn9V9JxympA8fOVcFCwkB4iIOisGZx9jI87d?=
 =?us-ascii?Q?Z17Jp+aLyc75uOr2rU3s4/Ir+BSi4VC2FG7Wl38IYu1ve3zNhvMQeYHjSy+f?=
 =?us-ascii?Q?TltGWc6wbpzuXdfDZvIKFRRgkhloY9EKGkMJrTS3S1gB9OxZjI+vsdwZvRm/?=
 =?us-ascii?Q?B752y1Iax90tkF/wOeP5QFz8n3LUOlLbUInxKTE2/scY0njcEhMTl9Ocdd6a?=
 =?us-ascii?Q?HN15ahZnHHJItxoMFLh6nIpigk/KA41MNDZ2qdZjFlimXa7QeO2k7qfeJoYq?=
 =?us-ascii?Q?Hs1Mo4qMjoceimfv0twc4bEdjvruSEgUp80JYAKOn/D8A7Ku/36ePvimJggn?=
 =?us-ascii?Q?ctGq9SFSeMOVARakD1JthJeFEKEVijroCTVOvwa9Isip4djmXgFANZqPLhfJ?=
 =?us-ascii?Q?1KyhdWFbhVedT+P9QGNun5vFggmyP0JJCuy5zOXbWVpYw3Y3oCW0ZLu2yOup?=
 =?us-ascii?Q?09WXzY+nJsZb7py/Gc5fN2fKM+Dv1GXlrcsnx2gxpIrYWEo3ZK5HVTsh6hK+?=
 =?us-ascii?Q?xPMDlLIUdozDEmS8S6zn14HfGKUWl7ivDBXkIPt6aep2DmuznEGC4z4TcR6d?=
 =?us-ascii?Q?n2p5uxoSA9F9AultkDqr+FNMpcd3Pyj+fUqZGdTMv+7T6e2a1B9L46ZtalaW?=
 =?us-ascii?Q?NtYKs6mh2JeQQFmiVmqNaDpGjKZ5pm+Hlcuj7EjpOhcWAasC7Rj7PvO8YIxh?=
 =?us-ascii?Q?Bzqz4T+/LAWLhX6640wHcLnRqfA6tDnVkIUJT7jXFb0DykL5LUzFIzZkvy/w?=
 =?us-ascii?Q?VTfdUhmoFLUncWCTg0MO0ZYvgo366YLaj7DvbP8/j36GNQPcbqJeJ1JSIeIF?=
 =?us-ascii?Q?abJvzf1bqnyJQZsz0KNsyeJqy8d6M2HPdDY73rEUnDafyd7VDR0DpXfwabnG?=
 =?us-ascii?Q?4Mkn+AzSUo5l+ruXxZxamEbv5u878tcMCHzNLBxy4pIKIRy9DwkQmUVzSgFd?=
 =?us-ascii?Q?8ziMea/kCxhtTNOOifUhCb+DszWVtOMVP7QwkAUNk5fE34oToQE166+ltZL6?=
 =?us-ascii?Q?JsDdmRAhxvrDGxutF1+co0YNKF7H3rF/9LhepG9In0f90I14YXbtPQpSt2PG?=
 =?us-ascii?Q?GY1ggMM91vQL73i3Dh58i4x46hG+7onKkGWi/smWD2cb1o/uJid242qC5MLu?=
 =?us-ascii?Q?u89eOlehWHm1JDMD0JEqRGGd0mSWi8gvjnBdr/wssZtV6GM5Lt/vqxa0McK0?=
 =?us-ascii?Q?ivy8rANrTpCqhFO9UrTqWV/BYRSlw4l2eYrTcrrvavw1d710USbsn6jyugDz?=
 =?us-ascii?Q?vrIf+D1udgqYhAX+5g6nCr9Pm+SxCcKmqhn3tolmPlcKVxGWOee6FNCK6GFh?=
 =?us-ascii?Q?qVev6mCHfCA1HtdOusMVLdu8HsQc75FLThBoNG5ptrayiQLT+QZu74S6Ce14?=
 =?us-ascii?Q?FaOaZmDl020ab8ClC+8uJMPuLXS3G7bwczd9Qf8LsKDla5yn7UP6ggGaaD7S?=
 =?us-ascii?Q?8J6RlUnU36k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0csyJ9MeymHwhnZkgnn4cemOSrw8enaBq5ap2VLv+ZWcierdWde5M3IPRFdm?=
 =?us-ascii?Q?oGV/P6CrucvLYi1Irhf14d+lT1nGiOwvopsYNhWBqW4hfb7N+o+RDcDsqTan?=
 =?us-ascii?Q?hiEqZYNfOP5jlt50xGRwImDVAon3ESjNT67S1TaNxyqJ3N123D6YRwjq/JKw?=
 =?us-ascii?Q?HJ1M9Jub1JYoQJB6VBtCrEdwi5vYMutu9CnKh6c5fuzvtWRSUUQzZ9SkoduE?=
 =?us-ascii?Q?7r8ZEuv9h1j6rzIhAKy6faQ0S43kDffQlWw5Iy0Wq4IDzKYG32NBEvv1xNJu?=
 =?us-ascii?Q?qq1Cf/XlqInNM7JhQywOKhYSfQdXCiks4N/p+nNKPWC3ZOpuwV6Vr0/wXpuD?=
 =?us-ascii?Q?1XTShP3Nr9Uvhmh8KVG8pezFmNRvQdOYFJ+20i8Kk94fEd9fmvOKDEoM/MJb?=
 =?us-ascii?Q?sJq0FkLL2Tix1YemxsFxzNMcTwzYTftre4mwTq8kAJCPr8V0JM/weF+UOnYk?=
 =?us-ascii?Q?SpaMx03N4moc9NpNE3UI0hE40Ft1wP8MJ9XNdDmNv5dcCuEwTvj4jp6/lZDM?=
 =?us-ascii?Q?v3p6+/7YoEW5KgNlaEJ4nAzFzsluIfmjB7s5C0DrWI2Xo+zexwBTx/2TE0fA?=
 =?us-ascii?Q?l2UnDqIfbfO05OHyGTqcv4dnwQjVWHH51GNMW/kwXgVOM8oqK1P7IrtDA0Ws?=
 =?us-ascii?Q?AqA3Eqm+3A9fj9UYiomsEacob97oxVwxdwsf/gv+aynVz5ddYfwPFk9cQ1lA?=
 =?us-ascii?Q?YypVd3C/0dcpCt5zrAYSjZx8oSPC+bEVhuGS2CgEeo0/HfIqitg1xysQWbkv?=
 =?us-ascii?Q?IKG9EIOBilqrRq+tEs5of2r8hpnYLZq08lU+2Hoa1jbojVbBEMLYrXp0gpHS?=
 =?us-ascii?Q?X6G4RdSBUvJQ3VxYK/pyxpVDBSBxEU77n5UngHOB7FDx6ycBHWRLu04LqFJm?=
 =?us-ascii?Q?TFGbBuQ+3689utiKtqkCBQF8cI9ZXI99oIdwxSbfHTakXvkBswfSzxTqOMWV?=
 =?us-ascii?Q?7YBDXPm2mRqARM58umUATxHn00UkYkkJ/DilRePIX1iAl07D+kzRmdyWNE16?=
 =?us-ascii?Q?7fd6jAo6K/hLploSWZ7zTt67SAdbrbbpZsZpCigdfuyenkYahTYd/nEPKGmw?=
 =?us-ascii?Q?2cQ1oiIGX0dXYspLRF0BjB0WuMg1nH4AuAY8s9kcxkaLAZ9VF4bWHi7m7OeR?=
 =?us-ascii?Q?klt8YUXap1KHy4Gkocmw/ThbesUJrrr1axqWE1BQGVM6XVnsfj6EzsrbF5jW?=
 =?us-ascii?Q?U0e1QHlOvucQPf38veEVpJk4fg6CUzu42D+5eSdnJdqmsL4yOfN2PGW/wbde?=
 =?us-ascii?Q?dFQTbsX8OT1ZT6U/gtyfPOzflDmKTIwrWWlaonNStvpfLJe+1Mnez0DH9jo5?=
 =?us-ascii?Q?qxWsyMvDZnstok3a2u4D5p3Rdim4picWLVGBMvn+Zy/JT76X/Yu59Thxci0i?=
 =?us-ascii?Q?YwzXuKP2rBZtfg2y+y1Qjt8AagPi4sAq6MuMFcnRcY7zfkGBKTzq0VwlltYM?=
 =?us-ascii?Q?HcdESTb9OaSUEXkI/ggpIZuCpzVBS1MGTWXGcdJKIJLUA+B/wSYnHkyZpUt5?=
 =?us-ascii?Q?2744cTR7Mof7r1fKRqV1vkzTK2u6PvNjHfuY28/G6bplRBIBMLpMO7yj2pqm?=
 =?us-ascii?Q?XWWs+BZMRp7HEh9AdnpHfrxVM/1E1Mc1Dh09Tv5uentJ9ItRRfTY3B9PFBP0?=
 =?us-ascii?Q?snHEgKlW9N1DZ1MqmNHFp/c=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7535667a-c693-4792-558d-08dcc3b48a19
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:45:35.9408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHm9R/CF4QuYm7fwbsejSaJRTvNqqr9t3sjjiK6liBCGXc78YWU0yDJeRlO/pt18xHZ/7ys8msG4VO2EbFVQF0L3Tt7VwDGUqvpvVDm4OMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11224
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
Reviewed-by: Simon Glass <sjg@chromium.org>
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
2.43.0

