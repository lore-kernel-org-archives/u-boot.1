Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5977DCF9C69
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 01:43:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6D6988CC2;
	Wed, 25 Sep 2024 03:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="YKLu8fai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEC4688CA0; Wed, 25 Sep 2024 03:41:27 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE93D88A29
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 03:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfzLRCZTpNGFbri5i4E664jLNLEVj6iVFboPDuA59hZTjDoAgG1MEUaNVbgm/0DsN2F3GnNC4T95SbPMHGlwPZ+WP/Bp/64rU6DLJWxZ0e0XPwsEbwK+naz6nN4KHnEdha2z1+RHG3EDKjaD5UixPEPjpAHWJLzTlbeOWJq3guwvs0Ub01veOHhFFY7FOS6c3YnXqXXmOhvGN64LVRi0FQ/c76bMxCHNPpI6uP3CgFOHTBx/EpjCLWMKyM0TsZ4CtVOLQXt0sTNtjRKnjti7TiQtfUrPfsiySFEmoao4FUIYrpviMqQEVUPxKoekI8Lk9u3S/ekWzirvqABR7/SM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmKb7frzAa+6bs4kmVYScuMVAUHW8BFbDBS+T/AqG3Q=;
 b=BSXOyVmupmPzvPV9XGJu7Hnn9k+21LUJeC/ZXkuML441FbAOQmikt2meRiiXi3AXaOW7CRpBXv2B+jycvO/p3YAQfID/3nLJZaxVpu2I/hirub509Okwl2N+PxzMUMVLwfdEroE4jqWoJS1NIvCH1825KZuc64XPtq0AVrZDM3bOLqSBgVb8gpvvejN+l6W/tEnZFFK0SJpJHKENComoBLi0kZt2xx+ms6wm8hF7tUVeQdQKo2cPEHqLkDFhsPNKFZEOQ46PaU7NGkdki+SjVc2mcc9217160TlHQaWPh8+CpxMRx0L4GINP3KMY+kXEZZ96Phw0PH5wSHpjEwzwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmKb7frzAa+6bs4kmVYScuMVAUHW8BFbDBS+T/AqG3Q=;
 b=YKLu8faicnQO5zTheOzh1yp6k1133dqfi11hPL3YmyqPGA9d+7yar20VxYDmp2hBLuuFAvKolEcS/LEWKudHiP7C1YSuZyJbkGgsdW9SbchwhNgUUpFlX0JeXbYEeOyZxzb65Z4yM0POiElPVCyKqALZ03djnZnGjygEucUhfn7B23GeukEZ5aGRzEjWzsZN/K67D2yHHxR8S93EVPC7vHrfufaS5K50lmf9IBkyGQ92qsAlIORv+mTlUI50GtbRX7jQZQ9CisD0tF7ZcgNT+m8hxUrpaIz46ndCyVwNrDEUBPsJyBsH7MBqiHsjQINA0Ygrs/mkBEmewg+C9rHgiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VE1PR08MB5645.eurprd08.prod.outlook.com (2603:10a6:800:1a6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Wed, 25 Sep
 2024 01:41:18 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 01:41:18 +0000
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
Subject: [PATCH v8 08/13] net/tcp: simplify tcp header filling code
Date: Wed, 25 Sep 2024 04:40:53 +0300
Message-ID: <20240925014058.1679074-9-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 2b2efa30-3b11-4fb4-f0e7-08dcdd0326bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|366016|376014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cW9XWTVlVJWvBKZtE3h5RFE0JnSiv3odhjNP+AbgJUJc60G96UWbhliBBWZs?=
 =?us-ascii?Q?1VXYqnBqnXPaZU5QbsQkA3guv+fJPrOQw9uphJKL+jeeKHvQK94KkE1OGY4z?=
 =?us-ascii?Q?5AB0bnwt0hxY15KFs8Go9YT3wvuNuYEDHB/AucUlVN6drdfUYFLaWJiP6wX/?=
 =?us-ascii?Q?s9W6ruESArouI1s2JDeCw4WMaho7TEbXtN18ZqnwRCx8s2v3ZWGWukdoycrX?=
 =?us-ascii?Q?N2apzP0dBnPRmY7s3murYhjVpGv17TvLd6RxxHNANPUtou315tpXTyYq/tkY?=
 =?us-ascii?Q?ID6ALCp97aQdTVvHJ6YfIre1VOaZx9LdFfV9AChCYAGv0d/gKmfp4GhDPk3e?=
 =?us-ascii?Q?mZSEDoNWCWXu5h3ZPtXf7RU4WHYB7dQa7Gj/uvCFVmCkXsT+ZaRPZ1sg5uCj?=
 =?us-ascii?Q?JdPRXxTtYOBaw9hwZmuLYNhzvQs9IYal9aLeZp671uGD/ejX1BrhanVLeOgX?=
 =?us-ascii?Q?MdX0FfcslkMx4BynS5vKmJETSO3A3KX1A6f80nrwdu6ZZQgdHk1BumehZVr6?=
 =?us-ascii?Q?noDqr0JQW/Ybg4dquwWMQZgxTRdK2qu2XqE4NEh6X0GsS9fAqSY4HuSRTcOt?=
 =?us-ascii?Q?xW/gAYhle1AVj7WGHtqAmflYawBvVM4hvJ62hUOo58u5adWtPUtw/+rnStF0?=
 =?us-ascii?Q?TRlkBZ/S6nQ8cSuavBhnrY6+17O5ozyiG/1Z0uPw2QTgZQ+LIhimQsoHsqch?=
 =?us-ascii?Q?s3eE5AAzxB1044tSjIT0YLW+LmPrm6cjwIKIz9cMEdOt102S+DZ+YxvzoqRs?=
 =?us-ascii?Q?Z7gFKajfojkZ1/zN4nLsWDS6KKuJ6s5Y8CMa4ZZPzxEnuOHjsRjCc0x+ALx2?=
 =?us-ascii?Q?No9iFAPUzY6fCK6FAOvKt7Po4TPDANdpeH+3vRnjVIR3KtyAphWGJF4nkO5W?=
 =?us-ascii?Q?b9/yZ1jrZZrZB36Don/YpcgFMJSE3THVX718z0Yjq/8BB5tE8QUqQUGoK1hN?=
 =?us-ascii?Q?n35p81wWM8z/wDuNmWlS49SCb73TNKoI25tMQaNcjT4xiBoUmVbZM/IihQgU?=
 =?us-ascii?Q?TI+IPZr2K8HEQSQyHoKg1WXjnQQqVimoJ7DlG6fSJ0YUp7J5/jTHqK6/ZkJ7?=
 =?us-ascii?Q?yHbpT4GRf2YQ0QUX3tlPOk9/61cCrdg7D3m+b915N5Vuj3R23C6qzKO1+pAa?=
 =?us-ascii?Q?VDUthrraXqRcC/PPpzAHMi7DO9byUuh8TBdwfxPIrhtZUpbgXX36X4ODESSW?=
 =?us-ascii?Q?/D+TC/aQbosifUv+qwhjFfYPDkiIzhD7n2ofahU7lpQjoiFaJ007/68jyEsE?=
 =?us-ascii?Q?cGzo+SBrvmt7nQnMZND60b+K18aqEFslQdaz116/JPGmCmvz1rMf9znhVwH8?=
 =?us-ascii?Q?pE1H8atKTQZ8ttGCvLX0aEvuMMvQ76Np/K+WbzPBYsHHXBIs8gZ/VE1JUQXN?=
 =?us-ascii?Q?qBAP1x/GUSMMgAbNn1SMl3yoKqCt8IjU3ChBtQqqYuXoQWfTsg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qgKQphKECW54iyhXl+lz/nE7EIPCzf7r6fmcL9LH0BPMpAA9vwOfQi9Ezal7?=
 =?us-ascii?Q?E6HiIsZgxbSZOGM+JNlj4dIKdjEuh3WoMzO4Ex7Fm0jVKcOteTh3ORmX7Z8V?=
 =?us-ascii?Q?yyNXV7NdJMl4dkgUxsaHlD7dpb2eRO0F6YGC/H67Y7GGgwFjNbQTph9kby85?=
 =?us-ascii?Q?JFNjKiS73fspp7RSZbM6TPBKrqof/2WMq75I+bk7ujyf2hL3S0fqb8uMyffS?=
 =?us-ascii?Q?hsiBCTRaDyt3eMbOU73V6SrJybAqyg2p1y6ylvG+9w9PkLygpZiCzc+s60k+?=
 =?us-ascii?Q?r/XgzsM1zShsPpwnngpF/uQCfDPdHKA3aciIBk64/xRPFsWw36cCSu0hSHM/?=
 =?us-ascii?Q?v9vnXCVFOaFYS/L9yZX9cA/FWaEa2iBG1jEIaqRDUKUTv5hnLgw4AIgR9Svl?=
 =?us-ascii?Q?vWFMOLgUZxCzST9XhqvMomtNr8lNwIghS7mZLp8VWoQwQz1YOIdH6gdsWQfs?=
 =?us-ascii?Q?JJ5AObNVfD6RpdzLB/4pMk/uu++euSzGdo+LwxduRirD5/vvTOPQLB9wf8Kw?=
 =?us-ascii?Q?N4BipSEEy0/DYEhVwytF2oy8noQH5oDUe8NiJWdR2pbGdIQvd56Du03sYQDf?=
 =?us-ascii?Q?VsDu3UPns13L9R7xsAaOVqM7eqTpJcDme28lBOnhFZ23kpn0F5LepspTBxwr?=
 =?us-ascii?Q?M4bTkT/yiH14rW6iQVx1FqBmGR5LEJJzYi1Aj037LX211mMNLtHFAcvFn6wT?=
 =?us-ascii?Q?Ee8BuUWPYkTpH3HWo+mJeUwNH9EUFdz1qxUecy4sBLduZukRdWmiQWwlPl3p?=
 =?us-ascii?Q?GZSa5jthpR/nZhYH9Fu0efkQDPp2idL/D2aEfuhQzKDV9GDtP3ubyx01uQgC?=
 =?us-ascii?Q?p3SnwmtcBPmBsroJv4e6q0FISVfNQQWGyT5EHBKU0h+8SpouQlyJhIJffNhn?=
 =?us-ascii?Q?tnAUUFzPwznZmosWBdH5otd45Yvn6wGpmnKaV5+69+KidWsemLvrcRGz0nDE?=
 =?us-ascii?Q?wO41+mkDR/s9+6APVHY/SffaZpu7nX/zlfd6gq4StvElcUZ9+D2emzAo5rYg?=
 =?us-ascii?Q?YSDRty+X4RoQnYDoQPRIbdgMZKESLbardBduXg11oEccJlgNH6bpopg7sKe5?=
 =?us-ascii?Q?EL9ar/FHo03bbzFoDhdLDIuWfsKPYHmgnhqixdScft/uUuSlucAqsvJ2jLpb?=
 =?us-ascii?Q?IpeEEemkunr1xeR0xFDIx9e8jvxg5Hwytm8bMVr60f/zmEkzLDEjDQgJieRY?=
 =?us-ascii?Q?6gnsS1lGR6LvgEpVuOtemlTf7R/1FO244lCJxUxKEQ/rc41uTVfp+GwRgujn?=
 =?us-ascii?Q?yHUehGg8x5h4y9e3iMvM2fLeT+HYI0ktJQzYC15XBBhgwLsZVM2j9j9Fh4RA?=
 =?us-ascii?Q?f+6YxahMfH0GGyRdKz84j1UPlbeR4qlzB4gIt6+1MmX+iO5rgnZjTOc1jwAT?=
 =?us-ascii?Q?785sZ7CZy329JQyn+BJPw751d2Rdxba/xdabwJpaEIrvSyK040zgLwus1vID?=
 =?us-ascii?Q?vv96qywjemvWfA3LlE6vz29UgjNMydIwnv5apDFywRa0MuuzCfyUKSkFRqVY?=
 =?us-ascii?Q?qCNvsInQ5yOSSdi/c3fhp/YP/WUj9cCAZ3rdYTd3xT/IZYqUvugH+iCC27BT?=
 =?us-ascii?Q?vymiyTxieLmiecYZ06dHEKVzIZJzVqpprovgko4sebwuekLeZ5Mf249xJdig?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2efa30-3b11-4fb4-f0e7-08dcdd0326bd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 01:41:18.5507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5N+n1yuJ+nRxDjBtgMjAn0zfeAavbAN1lmGbe9G6gU9MTooam6qlnLMVmzXgooy8bw4AEmyI7J9Dyp8/Zogo4B/ITJTDY9gU5WDfkB+9Qco=
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

This patch:
 * remove useless code,
 * use a special function for pretty printing of tcp flags,
 * simplify the code

The behavior should not be changed.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 net/tcp.c | 66 +++++++++++++++++++++++++++----------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index 57d6acf2dc5..149670e77f9 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -542,10 +542,33 @@ void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
 	b->ip.end = TCP_O_END;
 }
 
+const char *tcpflags_to_str(char tcpflags, char *buf, int size)
+{
+	int i;
+	static const struct {
+		int		bit;
+		const char	*name;
+	} desc[] = {{TCP_RST, "RST"}, {TCP_SYN, "SYN"}, {TCP_PUSH, "PSH"},
+		    {TCP_FIN, "FIN"}, {TCP_ACK, "ACK"}};
+
+	*buf = '\0';
+	for (i = 0; i < ARRAY_SIZE(desc); i++) {
+		if (!(tcpflags & desc[i].bit))
+			continue;
+
+		if (*buf)
+			strlcat(buf, ",", size);
+		strlcat(buf, desc[i].name, size);
+	}
+
+	return buf;
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
@@ -555,55 +578,32 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
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
2.45.2

