Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C69C52D6F
	for <u-boot@archiver.kernel.org>; Sat, 24 Aug 2024 09:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08F9388B69;
	Sat, 24 Aug 2024 11:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="nY8u0++n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 152B788CE5; Sat, 24 Aug 2024 11:27:38 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20720.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::720])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E45B8890D
 for <u-boot@lists.denx.de>; Sat, 24 Aug 2024 11:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvqiFsbuzzTGHZuNIOcxYw8OZWZlGldkZvqkqIlDEpGrGKxTSzQPtZOE8a3KT/JYVtqbuSefluTFlVDamX/mxfX3so2xJs+JsAbRGnfJ2zhwIWok7vDauFXmVDT3YD+asoeUZssW94szb0a9Rh4T8WAAvC+tefG9APo8pwcYTjqX5U8hicPTF3gQvoAJtEmA4HyhmEO3SWHJk6i5JMHsdLYk0IPZ6LrW8bLLB4v61FpbaNRp97ZRdv2oM9VZpJ1y2Jo3g2FuBhwTGqEIKuXEfvWd0opfgnDaRkq70oU2cO2jt+mhe8SC/zX6lMIMrCKGowMSIvr90cEagzfh/YNMuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/QeAf0KtFRXHltMI5OcYo6yFh+r99RkW9Ga5GJHjiY=;
 b=vWpf3iPEyyR/ckdeGU4g60okrWTOM5o3h9tcYdm0kOtcqBp7ZKMAe/Vevak/04cm7S1EGp3kIqFcJV3YWE1Y0BWugpUj03p7ZPNMVUqw5keyhAT1cga0NDhlJH3HflqvEyGLcRSn4F0X2WCPyPcrwrEVdEGP44J8GVdqqe/Q9liRdFQ+41sxxWF1SsfLP8uXEroiD7sq8pDZbNdvLu4Q5YntjIhISL5nUDRC+5hCPfaVR/MlzGWSgHUYxmx1Qvt/92Uh4wuQ622ZnIqMA2z40MCtWCDzfQ+CoeqR57fHPrBum/S78uni/SMX2xMmnknkdj8Azova8XHQ1MXmT2khdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/QeAf0KtFRXHltMI5OcYo6yFh+r99RkW9Ga5GJHjiY=;
 b=nY8u0++nhhph95gHCLfn1KYqz12b6F+ADMqI1U8M9jlyaDbkvko/009t7b1Gnw8d7wAdMj6iAu8egdMq+Gd5cI9o+mNuQqz9okg/gdpDQeIH7QUDETYS/gtb9RUx9q8eTf3DfwPcQt76y/4Gos9LdUp2HMZBpiHr1COyjy7WQw4lbNbEugFNeG6vsnBHTgOxogBRJkv/u4nWvjFYjoQZT7w5oDEcBroWiO4sxKMZ9wqlZoxHtKn9Nqf5YXi2EHPJ/VjyMnccz3j0Okv8snvu1OJ5dfu1V+/f2R6RfX4e5nMHBvqPok/wPm+DbMlTyZtOSdd22KTX5ZXLt6vj2lh85g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS4PR08MB7601.eurprd08.prod.outlook.com (2603:10a6:20b:4ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Sat, 24 Aug
 2024 09:27:34 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7918.011; Sat, 24 Aug 2024
 09:27:34 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v5 07/11] net/tcp: simplify tcp header filling code
Date: Sat, 24 Aug 2024 12:27:12 +0300
Message-ID: <20240824092716.1042696-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240824092716.1042696-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240824092716.1042696-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0011.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::7)
 To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS4PR08MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 8baddce0-d50e-4d47-975c-08dcc41efcae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FASmzdr0Lk0/iC9hmGjeytBKilqLIt0inZuVX/mWFjxKksCf0guBmrGi+GRW?=
 =?us-ascii?Q?PMtLdsjbEetxYDAhJ77Z/f2r6EqZfw1XBD6Kr8AiNVDB33txR9Ma9pGxLKM/?=
 =?us-ascii?Q?LRJyvrZn1d8lEMypgDjC52YOD2j+UNZ3eUX/643aBxBDTA9rbcK2PZdBpr+c?=
 =?us-ascii?Q?2FoxLPcPJ42JUwYsuzTLF0TmXoZkoVQFdmFJufjNt0VMD2iob1NapMOnubvh?=
 =?us-ascii?Q?MDU20atNLNiJauOUWPx0+T8w1ZXgR6ZO1JqJbpVQK0pKLJ+QqaBW6W5bE73Y?=
 =?us-ascii?Q?9RhKQ5ejW4YRI31WCawRHFbTTzkTQLVfSL9jarrPNgVs9FYVStHE7XvP8Fn7?=
 =?us-ascii?Q?YkKnMr48VWZctswstjG22vnY67Jjy5m5lCcbRIj9FKkvDpviNjCfJaSVqAPT?=
 =?us-ascii?Q?JuLbkZnFmN3lgGZD25sxCbjREvfkQbvqvh/NQsd98imcBObUWhvOyX+cMXyJ?=
 =?us-ascii?Q?/qqJdvKfjpTpQJQkAdXW7TtwSLryyEOrebxBSk3i/1DpPd8rNU8vMK4NNpIC?=
 =?us-ascii?Q?91OaCeJYDmLGk/Q1FJbl6iPmjNFTo2h2H3dzmbP3lhPOMsB6Gh5zCzRxj9OL?=
 =?us-ascii?Q?95N5AoerKCbFHm1wrPOP4GbopgCNXarIpUdticKN8bX2ZK8fBLs3UAwKqKrs?=
 =?us-ascii?Q?UTG8RwmSqlCr5Bv7yiKUg7uH1oqlrbGwd/oBdkXcEy5ER0mOpCLhpSYQwx5a?=
 =?us-ascii?Q?xHHYK01N2wg//XUTT+uKDllY/RYwYlfvykAHbRecbpWeyOxlEBCpvP2y22e4?=
 =?us-ascii?Q?8KUWhAQL3q7RVyG0bWq55S/vk5yT4/i3JZKzzTmPPmC/TJ9FqgtyNsbJECC6?=
 =?us-ascii?Q?zC2//5jFzS9QDa1tkr6ko33rjhlsG06qd14zxG7gezFLUjjvLfOQ34wG08Qb?=
 =?us-ascii?Q?R6xyI1Wrer+N0t8wEsTjN67P7laTICkIDimEbfRP5pIeLHdjWhlt82h7ks2l?=
 =?us-ascii?Q?wiAUslyG1MAbsRB7ehqaAgR7rvdkuHGEeICGRK1vKm0YwA4lLEjvCq9oRK7H?=
 =?us-ascii?Q?hef5I61O9oDQDLD5HiPKXB0wyLCzGpf66KurrqWfYJ5BAi/lU1+lP1ID7dFP?=
 =?us-ascii?Q?1NfY1o4d/c84EWv/E2u05ozDkfLi+7gDK+z/0vqTuj1Go0P5HEPtNEiA+sgI?=
 =?us-ascii?Q?rQd47oKbFy4y4LX1KccSbENihWdO+ciXA0jzjgSs1Eqq1SHbGhnPpvzJE2/m?=
 =?us-ascii?Q?6pPR2ktC9C4C00XwrwNetOW7S8PpcqcPgGOGNLGmtJsFmBqL7eQa62GyPvk1?=
 =?us-ascii?Q?lYwb3w3feTJ73fSY+wLL12iv6fe7v7o1dceO3Ya5sUnfYuhqZeZjygQ1YzIM?=
 =?us-ascii?Q?613La68XPjd+Jbhwk1LgSl2aR9hBD1up6YpO36CkowFca9PPT/QWlClkTxvD?=
 =?us-ascii?Q?/reg85koFTRiYho7vLgUg5deKYnQTvAkI5mPPexT4FaJyjShPok+7vG6kDUb?=
 =?us-ascii?Q?mB0FEWBOeBM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bQcEBtFR3hZRCBzkvGgfB35WMzqb7QEBL3V63SwdK1vhDPZnCZRNqBMOg2ca?=
 =?us-ascii?Q?Odz8XxzVjnYKbyXJEzfqZihdQL3BlSygfGVOkhOmoh4PVo9RsiqdhmKd9Gno?=
 =?us-ascii?Q?nGa7oQGr25fhN3nu/u6RIQGMM/t4F0qFS7qUB4ZEKYpdXqCednMXmJ0Tq6Pu?=
 =?us-ascii?Q?YrMEAlCOZFBF5ZPxMdIgvlkyUN7sPUtqXnQq5T+/hgrzuzY28UuPDpU5Ifo7?=
 =?us-ascii?Q?gu13GyXsIJcevmc/NdhlYYs1W8vpiTwCmHjOogjaC3lw23cHHGgNvrr6Aaol?=
 =?us-ascii?Q?Va2w6/6VV7LRvJvAuHQO1z2xMYDYud72kG6VdRvakfCa9kbjwUfAAp9M0vOR?=
 =?us-ascii?Q?RMNOGxPIgfHrbEQgkCGEuwvL8jgQrpLqCO390x2GtF16vnZ7kWVcM6rzmguu?=
 =?us-ascii?Q?QCBqNN92E2Yeqx3lyBWQZw0vOswahfoMdevBH7hxYBmj4NDuXykWWx433BBF?=
 =?us-ascii?Q?bgkMu8xbTJqPeoaZ4WL5OZXd7t4CX7YanjRy+yMbLxhG84o++Hs5hih6JGMk?=
 =?us-ascii?Q?nlFu33EvriqLaLCaD+evATgcnShZsK58OPHXGCgOsJcLACOqiP9okupIpq14?=
 =?us-ascii?Q?4toH19MVwvcLy6JSR/Od7UwFYfPnMQ8wR54dlZ84AFRLdU18e0Hh2ea2fUiC?=
 =?us-ascii?Q?ctQ5B/PhyoGZ23IID+dWhnryKxeTQfIAb/QbAIT+AkNa52BblMcLIbRarGIt?=
 =?us-ascii?Q?/3ynACKiiu4kStBT/VWNv1VeZrg5hx7hI5GP3jmYILt+W/v+8eyqEYV7f7nN?=
 =?us-ascii?Q?Nd/PGYdvHeR5TUe84Zcstn8XJni/cIf1JXp3dA6FaHCzEXF1l2BdTF6DDRdn?=
 =?us-ascii?Q?YqqDmTIqWZyldDpotjnjMYqiICwclPLI4FE3yASgGJmkO857YTDNKMlmdacT?=
 =?us-ascii?Q?bpomujZRX0OMLiJ7DnbfIQtzwu6we0tXdvoK3kycYrn0hSh6mobPQ1XRfSkV?=
 =?us-ascii?Q?UYJaRKq9ddTOoCDwM6Su1pz7xYIjfTx8VPqR4WdHAu/bSaZQPojhskCp9c0u?=
 =?us-ascii?Q?vJvdtwj/P6XGU43GwklQmUocsktCPOT5J9UVCzwQh6gIfoMZTxcVI8e/kV5o?=
 =?us-ascii?Q?WbKXhkPPAuhXwjxBtKNPzf+6oMQXvhtLYjaBJFeH6omAqvLgZbXXurITRTXk?=
 =?us-ascii?Q?FnsXifWHAQB0OTx0b1WrDTUsLeyhq6AUB7hMT5is8O+kBbJB393gbq7ErnpG?=
 =?us-ascii?Q?a3RLTMe9w2hJMLgU1Xoct467KqQv90ghzQGeIVVbPmwGVTKpDGJIS3Dm7cGd?=
 =?us-ascii?Q?1iEvJmhOr7yWhK5pg03U1SzCziOWzNLhMVpUJeA801du+dETgZEnHPpmm/wJ?=
 =?us-ascii?Q?j17rqdVVd1Um7b8rAJLpjn8ENUB+0xJh33gtSeEHc5HlymdKmWjGYyhNLbeq?=
 =?us-ascii?Q?G6b4a8Q7PoKqrcwZhE680Mk0aPXnij16XOBz1CW4JrU0qIB84J/4jfT0TW1z?=
 =?us-ascii?Q?XP6f35sHpuLNE8z9iDvGqR8k4+7kWyr2LEWyUCZrwJytaAOoav46a1MbDTyc?=
 =?us-ascii?Q?uj7jK9REBjMhKs+TmT4MA4HXfvubxRq+AV4sRRlkPU63tCcHinHD5FVE4S7m?=
 =?us-ascii?Q?UP0D0FglmqONlJV2+J2M7iwibUh3dKXfvqwvIjxRKgctLBq2bpkkAFxeJDf6?=
 =?us-ascii?Q?/DJdpHpc53yjR9Y3nC8KGUo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8baddce0-d50e-4d47-975c-08dcc41efcae
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 09:27:34.8482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGv9NsF0JkandX/2xe4A/p7GwrpbcpHqCjX81vag3OgZV23ITiRDLN4E0wwPJneVdvpqaFECmYUEs5ptNWVzvh2SLjmUN9rG7ajLuBhf4Bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7601
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
 net/tcp.c | 74 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 33 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index 37dda6f84f9..0778c153aca 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -535,10 +535,41 @@ void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
 	b->ip.end = TCP_O_END;
 }
 
+const char *tcpflags_to_str(char tcpflags, char *buf, int size)
+{
+	int i, len;
+	char *orig = buf;
+	const struct {
+		int		bit;
+		const char	*name;
+	} desc[] = {{TCP_RST, "RST"}, {TCP_SYN, "SYN"}, {TCP_PUSH, "PSH"},
+		    {TCP_FIN, "FIN"}, {TCP_ACK, "ACK"}, {0, NULL}};
+
+	*orig = '\0';
+	for (i = 0; desc[i].name; i++) {
+		if (!(tcpflags & desc[i].bit))
+			continue;
+
+		len = strlen(desc[i].name);
+		if (size <= len + 1)
+			break;
+		if (buf != orig) {
+			*buf++ = ',';
+			size--;
+		}
+
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
@@ -548,55 +579,32 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
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

