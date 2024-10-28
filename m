Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536AAD3398E
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 14:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3C4D8912E;
	Mon, 28 Oct 2024 15:32:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="bBGYoBIA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 256138910E; Mon, 28 Oct 2024 15:32:13 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20708.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::708])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1749089080
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 15:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7wnYSyo+T1aM4B91DbGKN236YJ7+eX8g4a3sFQi1Rfou069krxPa5NYErdFx/tMWaTuxJ/ypfcZ6N998YBFst3aCz44fO40/fDVDEyvIE/7TDXq78GHrv5Dbx+SD2lKRtXgzlIJCLl1KR6Xj6FA5EBLv6BxQmyTS/78kbE5IzSve2u0c8Bz69p8hfmfQSTQmuZm9+RDWRq4YaYDJA37blv3tFMuDGEjTK8GolPdezuc8qI2T3c50llhcapqt4r7aDeQ1Xrd3UToZyal/S/JC133YjAHojsWsBfXQjXPFQMon9B8MMp7Y5kgNHifow4VCDc6vHr2fjNuUX1pyEXfXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jn7S94hbnUpkelhdgoJvuqGQMKgGGNzeF+yCVO8xBmw=;
 b=chNsem4wLSS1zwU6G/CJjP1HPkLTT2FXzFrh86qyYlJr8U50QFdfXymt8TNAjbCfcQUsVI1e31uVwwn5N2kADv+uAex799GvBbaOZG8D9+YMoCGKNWww05pJYLucvAo0UloSkPM3vOJbRUoty6yXaM/W7QJorKKHJ9+6Gkqv5PPRPORzTkp9H2uFuuyCtVCizwxrqLziJ5bpfolRJ+xTrcqD6v7GKqTXOFjAnPCTYihrr2I4Uoh89a0RO3vApHLyebTtin/8Y/ki4aJ2YX95W+rIhIrqCc/vdYhqp8pQuz/SZn4HMCt3Iw24ftGJdPMknQp6nJdgySFk0QUb3DB2KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jn7S94hbnUpkelhdgoJvuqGQMKgGGNzeF+yCVO8xBmw=;
 b=bBGYoBIAtzJA1u8DIU3mVgZrXuIk+01Phal67/rpK+dqxM8LKQzABrkuljjtuhTTNNahBA+P5xmnbSYSqANlqgdpt2duOhf4ZYkBSRPZTOH1RWlO4SXaX5kG4MPlq/Ei1LqZqgdp6Jo3+00JUEcokh3ZPJI1kZYaZENaNinzJN7eaFWDB4Md5/7znR7b07DYJyJBCJFhThRK3u9d/fJeinwI+SsrLiDv+gUADVbC8Gp0u99Wy1yHpWMroUWiCA92a3n4h8LTJkkNPbvkouGC7BD3KjFZ+Bc0p0Qnqsc28FyjglF6kB9wDfD3hn9itwaWEGK52Gfvt1H6u/dBx/43vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7714.eurprd08.prod.outlook.com (2603:10a6:10:3be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 14:32:09 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 14:32:09 +0000
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
Subject: [PATCH v12 08/13] net/tcp: simplify tcp header filling code
Date: Mon, 28 Oct 2024 17:31:38 +0300
Message-ID: <20241028143143.1807305-9-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 09317b5d-d30b-4965-1b6e-08dcf75d4d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TP2nVI1OEuw7Aten3X+TMTwch1wNWkhbJZZXsXBozAadQAbm4PRbQx7Tu7kJ?=
 =?us-ascii?Q?oaAye/XXBU8n4iHiPcbNvcIWQ+iZQ/FB74ZvE8JUhUsefl8pcdsLgwu99cyh?=
 =?us-ascii?Q?0xo9OR5R31sIv2XRf/boHrztUicvZFwy0uQFk/RLBdyZOcEjuPg2IZUw+Ll8?=
 =?us-ascii?Q?CEvkCCVCxkXIqpDjNUw9dJ9Sx+w3S35yapSLlcUFmYqFxOBsYVPnfBsYNW7C?=
 =?us-ascii?Q?qcHJUbbHa+GCj18w80fxDFmca6xG/7rcrKjPvPcNcO/UK/UDimcocTVSBQAs?=
 =?us-ascii?Q?h6v4aJ8bGsEUSPdu6vtLKPMgt7df4J5yLEStlaRLeW4oyeYD7CeF/cRQHoLA?=
 =?us-ascii?Q?TRo0INX6QMHQVQQetdHJ9sJyxN4ntQLtuPewggSny+nNAV0rnZijjhOkO8jg?=
 =?us-ascii?Q?MyoXV2oCSuOZ8S7Sdofj+0yO5c3RVebUlDjfVHXcT3ayMxkyss5WfjJFdRre?=
 =?us-ascii?Q?y2/cG9FJAYY15oAszI7amjGq/Rc/PgWs589ATst2ho56FYGjXIv9xhGSL5sA?=
 =?us-ascii?Q?5hLzhrmpgs1j31VODe4IkC/K1iiWsqs8e6XR+J+XtqJaTfW/G7tgC+hLxIgT?=
 =?us-ascii?Q?QKNNV6BhJ1HEVYuz0hk5bj5LRfEJWuOk3ZchhRZu+coIj9rh2ACQF+BGdDdj?=
 =?us-ascii?Q?34alwll+0Lk9s3WRUKOsLXVEVsIYUzKz3vim4zWFrAo2fNEctapynS1+RRpe?=
 =?us-ascii?Q?rw6czBm4wl7rXtRNi3vPLV7yhV4RRknK2634XjqvTd3qubztB0YhguUkEobb?=
 =?us-ascii?Q?LR5k8KXy/CWcVR6OEl0vnzd16va7zwDdFGGQrSvFsxeQ813i4puOhEU30ccK?=
 =?us-ascii?Q?58YU0fTMoOsQ58Zd3VHg8eXbNPSUmUoviiOpEyU4fXKcwYgHTSceHlPVXjg8?=
 =?us-ascii?Q?MwceLh6EiGQs4uxO5xDXX48vy5FhgyPvTdbHzjVVrTy+ELydz/4WPwbtmKVU?=
 =?us-ascii?Q?hZpB0hZgxlG+Uy9CpuruDOXjinTxDUrvDzb6CtwsT8Bsir1UrCoJx4fduKfL?=
 =?us-ascii?Q?0OUU6ip7umLg0Q/9JPmPqTjydcDpgiKtj1G3+QsicWmmgmMMsIHhZ0agjE9L?=
 =?us-ascii?Q?c9aHONkLSGD6xTbpfW7mu/b423TVnya/PZXcezsrSK1J0l/Yt1tER+HVdil+?=
 =?us-ascii?Q?jqSMCCuQSumNp3C04kGgZaj3b9Mm4tEvfuKDhvfAn0Cf1Ild8bu11uq9vKaa?=
 =?us-ascii?Q?ZSPhFaEqhX4n2F7QJV3+pCya9SIOa3AXYakZXNT7XWVfWjRlVqzKcin+3hlx?=
 =?us-ascii?Q?zyXB2ujGI6rlL3UqyzKyvhgWaaS5uVYUaTntbRTHC8h0hjFlSMsCl2fH9piu?=
 =?us-ascii?Q?JlGJ/f2xQ+hIueNDPJodEqKm+u4p8uom9ZmAfcvXZGhDrcPIR5oHyqbLjjff?=
 =?us-ascii?Q?mrc28kqMinlvcRGqRG1S8pNjss/M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aUQOFQQLi3PkSau3z57Z1qK79oO1fgRamtAbhvyVYZfW07LQk+zp6QdbLanZ?=
 =?us-ascii?Q?CWkuX1rDjHC39nr6CvlVdNLIw0zDZysrGz9kiiAhoR21hvMksAemHTL4mlPk?=
 =?us-ascii?Q?90EeVJ+hPDUf5cGS5uyAnA5Ug13pQYBjfxftcQDqsrb6PH22dAwSENK561ZD?=
 =?us-ascii?Q?mTIfo0+yn3RW27TxGdmcQpYo1oTVAG+GRgIEwZ5Zm2TXyelXpw1/XsM2Bq0O?=
 =?us-ascii?Q?FE7Gsz7McmLg1oE+FmyIimRonuyPpHUMqnxLjDKK9eFgbjSbqB/j2AtdsX68?=
 =?us-ascii?Q?C2E2pl/rHy50bmb4QCcbD0Di4Zbq0WSmBRI07mXqyXfKsSUcfr0gOWPudxzl?=
 =?us-ascii?Q?aus7S7aT6sHsjVOVd5nOLWk0N7hSD/lfuLFzVYyQoa/4qtBO0mUrFcrPlWy6?=
 =?us-ascii?Q?Nl2pSSJ8hBSbMfo//Fb9jtiDJ99lzUObSySE1Gw+SQkZVVslLHtRP9raVBw3?=
 =?us-ascii?Q?OhYz/YP4KixOMuPWpY1Rj1XfcKSJcCsmcECCTVubiyrth6bLCJFTNaEXRkNI?=
 =?us-ascii?Q?DBqjyu090t0RCyskx2jpzJT7TsHQSU5U2KoYiSbWr8uin2VnVaV9fQa8GTqU?=
 =?us-ascii?Q?k15Rfz3km/5+e5E9+owH74EZpejKRivAUxBsIVR7f4fneZxlAMG8zsRh5WIB?=
 =?us-ascii?Q?eMjBUhy9dm1IT8xac9PeGylydaGqGDaYPutBH5w4nswkYXKDwCTpGNv04gCO?=
 =?us-ascii?Q?uJ/Soq3n1moM4M1Y2HhlJEWwXTCC3n33vSb2nVeDeTsyQOsszmaNgl0CgUx5?=
 =?us-ascii?Q?OSXqHgdr3z93JK32aSDXFCBI6ePdRkL5LK/6ByC7Xmjagz2VN6z6Q3QeVT4o?=
 =?us-ascii?Q?H4YciV1/dC2lqp2KMBJuOcmC7IQyj/N7ozn26QoQfUF/QfzvBYyRlVjD1hwW?=
 =?us-ascii?Q?WTKNNTirpso6O2MumTlJvzS4MMn1xB5Z6UIgrvISNN9xu0+ER8GVACGssrCb?=
 =?us-ascii?Q?FfDTozKfkzOJ6a2NG5kY0tJhgZ0GE7FeAa43JUi8/LhNXaZkb+NEeT2YEPba?=
 =?us-ascii?Q?hdd0yHieVbeX03N/thnDBafQGxblozvvp9BjMeIVmlhDXjhgJnVQd8wXrm4V?=
 =?us-ascii?Q?m3GoQv4M85PIG3as2gQ80J5Z8TnoJjcSe0oJW+val2WDT0PTKRaxkSWO5ohI?=
 =?us-ascii?Q?IS+vwjmMPedSuUgdxNPXYjoYq6BJVQSKVzi7vm3EpJycjvBtTpH1wCda7kuH?=
 =?us-ascii?Q?8MB1+twtl4qd/EoWXzufZN0t/rm7IJ2ul0fb2bFMRs65CfGQ6qgbWQAlC2ET?=
 =?us-ascii?Q?kMKcj12ivdXzkDqzWAwVO3svstFWiFAvzpiOLQCwFaeEfVZetSqx9RLzchBk?=
 =?us-ascii?Q?tumx8yboIfh0wTGezMeCzsHxvDT8LryOtzjqUcAWU33OJkJfN0cjrOSen4Hp?=
 =?us-ascii?Q?b5DSwGZWbMvV5opfMqDqEYqEAszo0RxuXVNTy7Lo20g+jbi2qz0X4fIOVml+?=
 =?us-ascii?Q?AzxEklc2RmScqCHc4DMO3sd8vRFhGKsJZ3Gie6fHfBEZzEFZn8urSxVI05cj?=
 =?us-ascii?Q?pk4OwczbBSZeUu/nTZ6WsdHGI4aCLfdiGIL37sTOReOiSk2An3rgokgu4YD+?=
 =?us-ascii?Q?raRtnjwKH24ukW/3omuC7mnIdG1uSe5pWIi/eqVrk8GhvqfcmU0/g4FzzckE?=
 =?us-ascii?Q?9jk3D9PKwcIIn/a1A1iEcSU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 09317b5d-d30b-4965-1b6e-08dcf75d4d90
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:32:09.1269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsYuE6UMo9SkTkvLolN7Jw90g7ElpElMLs6NKpSNENGKrv4MTmoCGY+Q/T/sbNMSSzYj5poSVqO8BeMFvpRYqukhAtFdtOnNm9j1TjUXuAA=
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

This patch:
 * remove useless code,
 * use a special function for pretty printing of tcp flags,
 * simplify the code

The behavior should not be changed.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 66 +++++++++++++++++++++++++++----------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index 5a4ade01c77..153f5183b25 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -563,10 +563,33 @@ void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
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
@@ -576,55 +599,32 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
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

