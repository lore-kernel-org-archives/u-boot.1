Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3760CD637DF
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 03:37:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2347C895C1;
	Thu, 14 Nov 2024 04:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="iUnRek9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 665E7895D1; Thu, 14 Nov 2024 04:37:05 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::700])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9442E895D5
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 04:37:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khzr8LITEzh2398akHxGFImcw8xkh2CfETvbSnfaxQhVc6EjRR1H6FEtguEC/925w/y8u2MeuWloIwwuSGgeXJU6vSKBQgGIwgs0CV+is3gZNTKCiw/56m4KhP37YfJB7EQfEpsLGJBC/3Jy5unf45hFDA3WnMlJ08ghlGW/1MH+OlUEkZgJU01pAIiT9N1TicRo7neCpN/saO4snI6kImm7LIC3mLa47NVGgCTv0kDPc8trIiaIh5ljO7nR4NJTCO4RFF3bkek//8Bed74KS2gccHiqRwVtvkWcTz8/EGIbqPOwSluCqcKNYBciNfZU9P4JDb5CnGubuJ0S3mBXFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jn7S94hbnUpkelhdgoJvuqGQMKgGGNzeF+yCVO8xBmw=;
 b=lyQnq8mX9SBufSZI6j2SZbdtHbpEoKvERKIpMscy2UwEEnbQyz6vYOtD8IhJZq5y6XFbaYrHiGzfemR3Hkm0hY9wlTab6ASYk65AIEsIhg6yNZcTrwnqgiVvg+Yx14uvPJPTDhE4yPkNmGDhCfuGdPKMzWi+0jNL34EAa/sTMQ0DNnFbxEVjxYep83pJgkKTc1zhlG3BoXuO1vEZTynO6tNRapjSF1TBg/4K22RZLf5m0u+ToeDd+TKdJVxWsjgB9D5Gn0v2y4vORcK/2kQ2Yru52xwtqQ4Tzz1spK0nS1aKYFcGH6txC+5obbFL1YZ0dPoSYJC8ggsl85ScIngs4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jn7S94hbnUpkelhdgoJvuqGQMKgGGNzeF+yCVO8xBmw=;
 b=iUnRek9cBx1Wb6MtUIf+6X2IzpdUDoAaR5nzkligQcRY+fW+S9hTkBw+xp8pQIToGJxm7MvXaMunGiCQRRG/SfZazOsSBWN7lxI4O7EW+kyN0o+aYJzWk8m7Q4tgapBuRc47xvHVmXvOK+ud9pipG0ZHt+1YEIj0dGQWjgl+R+ASYmriiBiWi+f7pRy3I4bkWEbcgwIBGtrL94fEm1ZKl/FAT1UV5cfPMz+TcggNDfkYOSAAROAobyVuLOO+AZhJ1ZtWGfcR9LH5pQC1Ksqp+6wpcoJkRyCJeLGHk5g1XcZHG7/nQIhpmSE6QH4zaAudoWkIGxuUmUzvEM+DPhAWiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB10338.eurprd08.prod.outlook.com (2603:10a6:102:30d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 03:37:01 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 03:37:01 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v13 08/10] net/tcp: simplify tcp header filling code
Date: Thu, 14 Nov 2024 06:36:41 +0300
Message-ID: <20241114033643.623355-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114033643.623355-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241114033643.623355-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB10338:EE_
X-MS-Office365-Filtering-Correlation-Id: 07bdddba-6735-49b7-8617-08dd045d996d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n3KVA/tyk/IvA/ZPZAb+Aoe+fVHSrAw3FwB8U6b9ypdL7zJCobRlGMEoTU6R?=
 =?us-ascii?Q?adYMcYx37SX0/92wk5hNFSiAOtMh5/95ZJq0AcRMREZi9bbFndnPyzCE5lgY?=
 =?us-ascii?Q?wAwgC3JLXBQzdiHyTx5KE1WZEGrFGNpIptdDZKO0bW6FuT2wpwreh7Tn6R+5?=
 =?us-ascii?Q?IMYf10CgmGLdEFXfO90fbVkmMVi9AgqGLqu0FHn41QLntWrUgFlAW+5sOrma?=
 =?us-ascii?Q?QoBB8Cgu1BEWjFyU/WGNKMm1e7oqHgJDck5p/Pd4nJfUPWZ0rLoqaba/EnWj?=
 =?us-ascii?Q?KEnwwTTKPvDhiAoDqR2cWkkwNmAWlDd6G08U3ibszHFnNMPniHnYsANoqZUq?=
 =?us-ascii?Q?xDBZih0vujSyhVob/4f8v6W50AMLEm+C+Dpdyb28nFoXK/8iCv7jF6/Pqm9n?=
 =?us-ascii?Q?bZNch3ekFpqE4OwZU7U6njfU0vCHqMAP3ovVahc0VeOqbLIlQQ83+hVvueWA?=
 =?us-ascii?Q?4cUBgsHE6Nv7eNTG238a3VABx5AJnbmaMj5e/EWAWrTy8vSAernvVSeQVMIz?=
 =?us-ascii?Q?5OvcnMfUWILOMbA71rPveB0lOrFni7rw0/vY+JUkyGed/bU25DlyQ99eKJUS?=
 =?us-ascii?Q?Uc4YOcRvHFeT0O552bzUl7cavSmKS3aC2Em00acRBPICEbtlpVLavSeufQaH?=
 =?us-ascii?Q?FJ/HXxyPaAH4lV6hy8bdvJja9vKWMfRohCRlAH6RRN2uQuUQIgUjJ9RTVpd5?=
 =?us-ascii?Q?gBs7cJn8IMUO/L5BZqCZiUBIRCr8NcIppLCK9DqaU1FkuInjSqg0LGhiHUlR?=
 =?us-ascii?Q?ckznjRnHc2Xa0Zt99EhlUGYiqVOhfIKXakd1oyxiYPnAWGIB/p/LhY68ZqmM?=
 =?us-ascii?Q?Jdu8I89UUNNOzDQHoUpUORClSM0b/ufRALsEPxEcMiuXDYGANvO7CgNegTjL?=
 =?us-ascii?Q?WUdK/VOYV5crC668hQL0ybV23hwBcIblXE54ZlGY1mjIyCe0X6mYBNKW4YUg?=
 =?us-ascii?Q?j14ZBVVWa/AcAjcqv7ALcKRrOaveL9ir4jC1rO2VKw15DuSakurxnhpppxVq?=
 =?us-ascii?Q?pahrG96bDa0SnRncCyizIntdYuQ7xPzyhp/MHEo3fIgx47kqVQ2aD0XzNzBG?=
 =?us-ascii?Q?Cb6dEtkx2AwU9SPRNg7SwhgyvsPYWU80XdXjpuWhmZh3eQghB61aB2r1vdT0?=
 =?us-ascii?Q?AxbgYukWWu+9tlt8colt3J4gAl5gtmD6+1QKXM6D773yxTaOo3EWHUyx2uFP?=
 =?us-ascii?Q?1jpZVKS5G36TthJHR4/OB/e7DFpWbvH9avtrw1CchVDoLkP2u84+zm46TNRI?=
 =?us-ascii?Q?zGlL0jjw9wO7GMlj+eIK0BMUj73TZCLJJvU5lz48TBp+pQtOUOyxGzMi4zZd?=
 =?us-ascii?Q?YPXUGobSLVBzigYJaQ270hzE+DCQXuIsLlKh6OUHrq1rlUtLA3vXag7vKuuY?=
 =?us-ascii?Q?hyGxXAZWDHJUO3ojA2BNwkpJEhZg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BshrFE6up4Z3EZis1SOVtl9T31A2ybsT/i8N5bqG3s1B0FuMiJ7tm17EVBmV?=
 =?us-ascii?Q?MkZLG2VJ7aTcz+eiVj7rN5ZeW7OO+KHJaR29qti8KFiaBExeCSmOuq1h3ys2?=
 =?us-ascii?Q?1bJmgMARUD40PkfEk66sltL72fZ7zNJFTRy+ttGkqcXPmAgPfPKncF1OGIx0?=
 =?us-ascii?Q?YCD3NwmB0jYvkagf+DVtdPmrxY2sUoF+gFzGWEj7RDluDYpBUyykz6bQKfVu?=
 =?us-ascii?Q?Hw2u8WsOCOMoqG62cuBF7i5C2vjmgXTLV5hmQPb+RG8hZBRBjYYlbmnvOhCh?=
 =?us-ascii?Q?I7wwdb37eVD0IkqjXl8mgKwulLCUyNOiYSgqYF4YWzUj2XNYu2MyWtDS86Vf?=
 =?us-ascii?Q?IFAhG+nIWA2OIhOacm34Cuysunry7Rzl5sZEcCEGFqrFLGmTcOxRGkwOTWj9?=
 =?us-ascii?Q?yN6QyZawm2Tp8NDB3l8PIfJrrMcjM2PAcWTUJftIfFho7bbIjejtYfoOXy3X?=
 =?us-ascii?Q?xpGmL058lUZH/MYSSqcZdJkMdLyUKl+9VYdoIMK8DxRwQO6UPttVYO+saZAH?=
 =?us-ascii?Q?BgxJPgxaNm6MjMPiNRIP40X1hAJBp8nflQmGurbF97/Rjw/oUzzR3tmbKV9v?=
 =?us-ascii?Q?JYN90yssiBGwldzirdp/M+2/s08JDgh05W4tulFxX58bao9juTixxpVDL0Gw?=
 =?us-ascii?Q?63GBMcoxkuF7Ahte7KMCCABLF+TCXPHEp8lGH4TpSt33jFyqh1h7BnMJl+qp?=
 =?us-ascii?Q?/rOBR3v7WX4v63F3B/l5a34MYw+iS3mcGP4vrjpxF4jpcceygfibhxiuSjux?=
 =?us-ascii?Q?oss1LLawsehyFny4MYoYiOlCvpA6JUgFlIdMzGsPfW5aNUXMrlHF0VnkEXbh?=
 =?us-ascii?Q?u1D5iF/ENNOAEBpVOckKmpeRCqytHEyeR8dhTvjHD0FgWBTH9qI5hRV6mCdi?=
 =?us-ascii?Q?8aEkXyZlMaw6CNMA0O2Oh2Dq6TSaGAIqXMalIvVwNJ9szC0Ll9JFzvT8cB4s?=
 =?us-ascii?Q?ydTsTS4ZvIE3/CDDeiLse5UbEMBrxCJNBaywtm39BoSz+5TC7hCMpAg1UG8n?=
 =?us-ascii?Q?+6v5zmZRy4vfbZAm5qlZg74kgxy8SReeMImmZPEWXCAHXiiRJBUKHHiS+htd?=
 =?us-ascii?Q?M+ahvZu6Ihby5pG5mT6+xaIcLLnnlvwWgTCMHiNDquvNrgi1XweWfxQgkENR?=
 =?us-ascii?Q?Q/UbRnjqpleRBYvCfaNKsc702NLv5pXP6TJC0a0VSvRIWrK06Ikm2w/lRvoH?=
 =?us-ascii?Q?tlss0q14lPeb99zw0GoHkLLcXMCn4GeaV88d9r0/K5bmwfiHktME3x3eB43H?=
 =?us-ascii?Q?YMhBfn+UgfkAdfCCXDm1UhfVuDgZY+P88PD3lioz7miJu6eoaY9VXfuzyYIM?=
 =?us-ascii?Q?Gprz8V9+p27RfAAssWwxhkSNVWEyPza7olzU97kEsoO1LcteTCbQoYQkY3c+?=
 =?us-ascii?Q?LN8mOmormdFhin0nSUJdUSKvgUegnJu4/h0Cr6Z0TUegtOGWTxRMQk6bb4qi?=
 =?us-ascii?Q?DLj+la9ucbaCK42bSN/DC+gztt0bqFaJeZaTzR/2cfHbNQxHQWZjG+pBP5N7?=
 =?us-ascii?Q?W4f4C7xTfKMkGTxEYV/cOCwUvRC8PC9vWilfcSh13rQbAiW6XCGyxd1a1uHf?=
 =?us-ascii?Q?u/P2UQ1RNWo0hs26kPBxNvnpronMTWo5effNFKzC1SdWCgLK0g1r0GRO7hwP?=
 =?us-ascii?Q?7Dj4Lp6Jrz56WG6a5/IJovo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bdddba-6735-49b7-8617-08dd045d996d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 03:37:01.0731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSJ+FgxSdwX6aOElWme6SlQFRSmvW9u1+Y1JfFgdqlISOiNyZfSV0F8S0pcawrilkMBi9QYKqsNMiRwJJaN85m8NsJllCvuI1/qpFpUEewM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB10338
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

