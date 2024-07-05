Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D647BC30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 15:06:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F3A4889CB;
	Fri,  5 Jul 2024 17:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="jYkv76/k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26DA2889B8; Fri,  5 Jul 2024 17:05:08 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20718.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::718])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F77A889C0
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 17:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+EIV1OpzFrJH8vM8Su6I3ssMXyA9Eb0wzObW603EZPs5vEgB7y32FXPvunw4Pi0sDowt69D3cjB79xikmnkXQPbC6HeLiBR2wm1/ytngh4y4WXyeOryfApD4/kKu2qfiyyjkV+35rK01wuYzAmOFOGbUSJ54VxSnpGEu7J4pxduy8tKqJgcVWTqgCSbJp+mz4iWpH2l9lAl0c4JTFoxXJCRutaix9UFUSXnAqY50X7OmCh6U4gjrNNkjKrfO63JuVoDLq+7FV3r4FNuHbZLZzpOwaALk1HhGgxehjvQ9CTylYtoRkBr9pduFDA7KkImkAKlYfL35MubkvRyUNR9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BChunB6Vhwydf4fAebK4IgFvTTfYVm5DLFXWjQtNW94=;
 b=GKoqPyDS+Zn3GFtcqpk9QG3J3nuZEl/k/kI6yVLCuZ422UwKhJQHuTxHNY8pSUBx467lvn1V5NC0EptNfhqHlCzXKLudaIO/2/Z746TdpTJa8A2AvRnYEMfPkDgRU8v8wiVrHKX1x0Mjaj3pnL4PGJo8JqkYbPzOrYFu9VlG4QOO7qWdDxCGIaIxdEf8yP3rwfPetInksGRdvP37ap4tJg+fYUucl2WgmdWkIEymETf1zv6rV85HH424ujegVmZiBkjG8fgHg2RDVxQpYqq0+KoxWQTLEGm/OWf6ITEixoWzvipU+neksA+X7bnnXEbQPpVAs2IviE9NEKWdcPABrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BChunB6Vhwydf4fAebK4IgFvTTfYVm5DLFXWjQtNW94=;
 b=jYkv76/kYabwqqpWNVxB58Y6KVlBKSN//UXyKCXA4jKV1STWY4AAC2062sNrKx2F+96jsDHVzWNlF966bQ/F+RVLMA/TJsE1YQSq5uViw1KE4aPxe2ahDVTmMSLdKjoe7o8rP37jS/MMR0ulezsQ3KdJEv++R/wbkN/mF39WXiRi+1PoF3c/fhDzgDo0J1weybYbzJZ9aGrZXlCAes3vXQdBJM4guwv29ZwtT1j6v6NNku6jXEq0tKeCs0Og25Tp1ixl2MxZqSDVVMjwPF8LNk1apxoKNbesdv9bxBYz/NkZwMFwRun6TjcvYB+I79f6jVc6CuLCKbaGxMe3Mthx2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9834.eurprd08.prod.outlook.com (2603:10a6:20b:605::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.28; Fri, 5 Jul
 2024 15:05:03 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 15:05:03 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Marek Vasut <marex@denx.de>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 7/9] net/tcp: simplify tcp header filling code
Date: Fri,  5 Jul 2024 19:04:29 +0400
Message-Id: <20240705150431.2274662-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705150431.2274662-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240705150431.2274662-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::22) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB9834:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c980efc-a2ee-4b6b-cb98-08dc9d03d8d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YQMlZgD1bOD0MtaCq7H+2RMy2gWFNNmqBlRf8vf/sV1duKPt6FAfVLXC32+K?=
 =?us-ascii?Q?y/64Dc2v5MV6O27uIsDEviAIHT3NtznctDuwiJ6Vxb4avwF+ovbj4keK9ZFM?=
 =?us-ascii?Q?ntby4cS6CPcecBAF0WqWCldAx0n3ne6RQ17C04TZ090Zo+EBkg51hPfpWQMK?=
 =?us-ascii?Q?ep7b2+dqxMObuRuspNs2YRdnaGoeIe/CM2cAatdNZJiVdM/leHACdFQ5+007?=
 =?us-ascii?Q?hEYipRoFnFRyn7Vq3KcX858n1MlGKQZZEPZSHASiQdtTZVTydRW9LVQPUmmE?=
 =?us-ascii?Q?578GxOa8C18dSpC0g+tgJ6hfDKv/WKcov7RrzPNwinOv4yEwg70ZPmSgjPtI?=
 =?us-ascii?Q?2NEXUlyrKq+JYlT/THjfoD1mhHo/MvEJLDmFM/OHhTa/QqxoArhpsMwP05YX?=
 =?us-ascii?Q?JfN/OMRdnmoED3yI5uDDaX1JDBw9XWxC6OGerneNmQPlQ9BZcqCF0U7E6Jvl?=
 =?us-ascii?Q?c4gfJKyH1BJdAIhuxGLLvZ8p09PYIgrvFHUvNQukHuA10YluwoLu5Di0fUGF?=
 =?us-ascii?Q?gJrJLbzB/DEtM6U81xykuG/TnU0Ww+B5oMVi5xuDU7qIDnWIRGQ17uf66kTb?=
 =?us-ascii?Q?2UMmD8okU5CAlXaktlcT/aojFePIIVnJkuvr7utfgO1CfB5tkm77a/69RPL4?=
 =?us-ascii?Q?CiZBp4qV22k1K+oh2UWsQ9vEr2JaeRXGPeWTJWrSyM0SfXmAVO1xSVZbPaul?=
 =?us-ascii?Q?Vnx4abHjKKloVzxOChsCcvgzUrcOAElUZG541SI8d/ZstZKgPodQPrZTxeDL?=
 =?us-ascii?Q?cSP3sQBkk+eJ35VmIMCHAl+B7fpHzI196pJLlTmjq5ZilT1P/fonPsD7iw6m?=
 =?us-ascii?Q?92UFFL6gLFpCYKPoL67ns67P8WNQ8FQlCpgtP9pGZ4wBQwYo/RE79G8GyW/Z?=
 =?us-ascii?Q?m3i7HG30Y8y2BNLkSD3r6OubSpRV33ZnNfgg1Nt3BSGH83JcgwUWb4HHs+ZJ?=
 =?us-ascii?Q?faqVELqYFI7tEZle4LU+NM5DLd63m2fd0SV9MCJT5rcj8ka4Grhs68eh34PC?=
 =?us-ascii?Q?nZ0qxRy9JYdGmFAo9U15wbB8vmCthGBYnfbinoe9fio3TJrF3zUpqvh/bLI2?=
 =?us-ascii?Q?0bW56x9ciFqCYQx4GVkwlEsFbkWZD4JxmMEqV9+8nq36VlkNJOaPS8F73UA2?=
 =?us-ascii?Q?qJ3sxMrXydiNhFrlalvL7K0i8TGAkUaF655TnAN8D4DWJHDcvtRStgiOjdQT?=
 =?us-ascii?Q?QGhO/iZoEC9HzDUhFrdM9ihELlLa/prsiPBD5RfrljPx0S/aB6PoaqJLnoUc?=
 =?us-ascii?Q?+KhPik1bKUj0k38nWtLK49LTuAcHylJuHcytnRdRBJ7RzsLRO4Ezfs3YNDkD?=
 =?us-ascii?Q?dUmVOSom4qGCwGy1jh0Bnn1gsl9m1JFguFWgJtR30Suh461fQYEv3xbomJli?=
 =?us-ascii?Q?XznG/k6mbWEZsZssWEwsGNfuoBIH9BbePrX7ghlCw5c239mEUhieAk25BL/b?=
 =?us-ascii?Q?1oPTeFa4ntQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gfeSLwuQHiAweHx/HKhTNydKKXNdv8k98cTL1k9dPt40UzoNewpe7HCDdvPT?=
 =?us-ascii?Q?C4ECon99wQzyffcUs/7g4wzIk4vQNJhwA6QtRnI7YdAuiv0fkQKC5SlVREC9?=
 =?us-ascii?Q?ik4RdDb9ymIf7V5QCJevMK9oi587HuWWfDt8EakfgcrNZ0D6dFhwABUd94CL?=
 =?us-ascii?Q?QRClKx7sdV4Ku7R3MgeVNAza7KzzUHzX0+NllNvRoKQoXBr6kAL38ljrFb0Z?=
 =?us-ascii?Q?riIHv3n1GaPDxUhIeM70kq9GFiV6iNtXn2D415LcfBYdx+sTwN/Ck+0jmvrM?=
 =?us-ascii?Q?gyB5x8k4x2IBbu9z0O4fo9O3ARpHXKk/BI+hvtyX8xyLsTO1EBXofSe44dQ1?=
 =?us-ascii?Q?It6rZg/ZmoOLzyhgrqgMvy3XIHB1BeF+F6X73w+Ng/qV78S16Gx2P0YavFac?=
 =?us-ascii?Q?VlRK7HEfWDnm3yTEVyfrgGNGTZ7KsrId2RWD8XG45jd+ZCekPyDypBx8ezM5?=
 =?us-ascii?Q?NjLYB6jRR1N+OGrDeiJe2ScpGcCbl9ZIocuToYqTuORn1zJQ1RhWQgCipZUp?=
 =?us-ascii?Q?qY4Giplkfsa3jgD0BlZi2XezX/mSSdWTMKKmR6bHXn1yP2SuVysu7tTuXfX4?=
 =?us-ascii?Q?hE9waz11dEFc2z9BH7I6Zbj9sRh/8o5PNuaK/jP354Czr/x0vhVpadZTcYoD?=
 =?us-ascii?Q?zZjdx1Qt7mICXpd6l2b2krugtNAalGIAXXPzxfx/ouA4fSyDx04i5kVa3jgC?=
 =?us-ascii?Q?5yH7TRhk5CGl4kYaO9eezdSrs3ywypvYMR00SnT1bHcax7TulIcU7UjektDe?=
 =?us-ascii?Q?xgOaczmjS9uUvf2ByDhxq4Vq2DIsu0k90TUBOQG2ReGDQpLNxoG+0wrhkXgJ?=
 =?us-ascii?Q?NWo3M9Y76UwkGJUr7uixwm83HDghaesizHf5LnHUXWbpE0tc3lUwtasnZuFo?=
 =?us-ascii?Q?Uu8ymRBr9KiQCHD+3fbR7mUHhgTQTdBwgwNbUBhwPRFHJpavkdRVzXdv8Lu7?=
 =?us-ascii?Q?qtTxxEcZNh8Sfcrggmk0ld06ClCkzTCHAfSHXYl1kSEckE8WT2wPiLA+hL5L?=
 =?us-ascii?Q?+4nQsM6nTtBfQM1nS5vigj7nwJp+WgLd/h0P6OvPcVZiUQK+FUrNA1z5KCv/?=
 =?us-ascii?Q?fkZSYTxOJe6PXrxr77zeY3Wz1CuE/yF87uyhCuqtiL8eaG4ynvLqa/Wwe/Ev?=
 =?us-ascii?Q?meOhBYj6ixletl1uPOQ7BvfIVixmvphn/Ltm7lzcWYHwkSiDulTZyEW+iN2E?=
 =?us-ascii?Q?KytuUgZ9RHlSOVrQuxcKqAYLIxPJThqvWdE3+y1aWKrQWmCJPnBT+UpuwYSR?=
 =?us-ascii?Q?vKm/8YWq6pAisDjBpw5nx83Cx6YKPlHlYqrMOEcTlxEXlDwh4BC842OKCX4s?=
 =?us-ascii?Q?O7fMlA34G3/d7lYiE9VoYzADaQrs0C4S43aPAg+hzMoZqSQ+CowPdm36tHN3?=
 =?us-ascii?Q?cveDEunowcwv9NntfZzn37PfwLOVeySoksPRdCEz8MtElOknCeVq+Jxvhbhf?=
 =?us-ascii?Q?N6Hu5IqtJ8glq5Vd4AgshKnPYfI6dRNCajJR6z4pRzN0gMYZL1spmF95P9ub?=
 =?us-ascii?Q?J5HXNJ6u8DsRVUgQuFQRAPpdsYgT4ZCyC4KHQIzbHpwOi6Ajaey5kuiCW2mq?=
 =?us-ascii?Q?1wwxDYXzxJ295A09/WjR5BQhpN1vLSn5bzyyAt+gv1fXZ4ajvKQyC+X+Q8Ae?=
 =?us-ascii?Q?1rDrN0lqopkXkNcjmbP49NE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c980efc-a2ee-4b6b-cb98-08dc9d03d8d9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 15:05:02.9866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/qSo/nsbsNYHWxbqcKOTgxI5VSHOeDrEohlNhmjhxkeyTA+JsHckrCt/LHzbmUpgUCtMtMPZxdvEHvTHOVeipE/vqjCe5R5K7uCjzc8EO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9834
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
index a5689a892b2..9fb80f9c2a8 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -528,10 +528,37 @@ void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
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
@@ -541,55 +568,32 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
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

