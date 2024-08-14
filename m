Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20005C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:33:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8DB988A05;
	Wed, 14 Aug 2024 12:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="mGlOCClS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFD5A88A03; Wed, 14 Aug 2024 12:32:23 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBBB6885FA
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:32:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBpM6vWZUzy1ZnsvDW0oOi3qLG9Re7QtxKXH3VozBWNbpIqnKp2XWmFBlzX+5lk8G2yb6PPG5cS7EjN+6UFacz4dKx7fkVa9nypIS8pE2WdoIR0MYon6nmTgFQe1g8z4zIAPlidB2LwoEeqRCFgsHp1v/KqY67acq8EXHU/gnyTJvfMN+Jahuwx5EMNuwoZUf4p2lSIAyHBdKq9yCya6iJPMABb3F+VYoaqiUh9OgGtG2YWLycpk/ItS5dVl/HdM9y9KetzO4yPSmH0LILk19VOv4HvzfAkHnwBNh8CuKTgHLXFOH2bpbX1nxBnpI1b1DY8Fci7Wdr/04OwhRUuTDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1h3vxyMLYGQObX5jLjBChuy6wcjq44izjcT+7AvEc4=;
 b=CwhySsTF52HYo3634yktaZvQ2YnU7pa9V1hsslE9m2o3ZTXC4UV+cKJqspvb8GyaG80JIVK8Nl3gco8HW2bPGmdMTVzaK0kOTmev+H+2Ngh6F0fc7qjqRO8Q0MIWbkvkTkP6UGcQFiCJqX3fJrQQXZHps+6PKs7BhiScWf+9zwqEcfvbWuQ2BedK7rarud/ml/DUNCq4vQLjo09t/azTMwdqNf0CkhLjiVhPE1gyP3oqtc5MSLw7MNpOEePjQYJCN3NakKUELOc74So4tTu3KZF7HWZdyVcAikPE/Ns+j3tAEGwJ/J342bhzhHwwTBjfrpDAuBtntyiK/EkOPJqB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1h3vxyMLYGQObX5jLjBChuy6wcjq44izjcT+7AvEc4=;
 b=mGlOCClS+UF4fJzk8SG+srLaYVqYgi725EDV+PBoLVual2EN/JIGydw6KK9GfIAMo7smhsldo5oHDutGvSDF9uNHRMzCTL5nerHlw957uuJfH3FYj3rOnIr8diK1RHLjqM+SzZgY5uS2doVOS/E76CSuacIJSUcMOo4uHupj1pkB28S661SjD0Ev6kPvxuDhmoLwUryHqA34N7XnZ1zPTDDo7MrDgibKyXU5cT+iQJPhCNGR/VFcJwas3zPUAKYHiY58zwcjECtiHZCptoxwFwfymuFy2vbkNZR5dfodq3jqckiwkb9/5yJykiJ2Im8izoTCiKHMo1Ot4c+i4ljNtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB6284.eurprd08.prod.outlook.com (2603:10a6:10:20e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 10:32:20 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:32:20 +0000
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
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v3 7/9] net/tcp: simplify tcp header filling code
Date: Wed, 14 Aug 2024 14:31:43 +0400
Message-Id: <20240814103145.1347645-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0030.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: b787555e-88c0-45a9-b29f-08dcbc4c60ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?06RlIpZWfV61moEoXWuJC8nhgHoPj2dKaRpEKmSeJURquHjj0/W7EllYPmwe?=
 =?us-ascii?Q?GrMeFLU9R64GTty1ZlZyedBn4EhhDopbnLENAxP9JlqebKftqx3W+H69gtps?=
 =?us-ascii?Q?ZuRxtJorN/igTFJ3vQxIN1mbPPe4BK2q8s8FO28vJahIVNGGovFzHoVcswi+?=
 =?us-ascii?Q?aUCUgCPnsQUjeELjYk4MC4LLeZC7NO1RjjnAcz4mDqoiuAvmWdTqtTAovEZN?=
 =?us-ascii?Q?HsYGItQzcLFguYg6P1knvWFYA5ws0p9H1pW8CBURQkg0fEps/cgrpegLil0a?=
 =?us-ascii?Q?Y9e0lD9ENYGy2wK0ZxKGP29v1yKVSeoAPYm9WzH4ZF9nHl1z/n2aWT8urn/D?=
 =?us-ascii?Q?54oxzUx88RSrNYyn7TOnDUPg4TJM8OP7R9owLwfkvtU3EdZiUmsLht9dw8oa?=
 =?us-ascii?Q?IaTkt338Y9b8eeIr80P7bRlG3z09d/l5wMVP+LbYvhCyYlq2ZLZpGf6U4EWZ?=
 =?us-ascii?Q?k08YuOjDy5SnZJmuPI4tRtlbzs+wj4aCiYSNTBBwz8fX7tzchEqlkMfMikxV?=
 =?us-ascii?Q?ZQ1Gu6I0eIxCgHW22IubNKsXkvY2XeFrxI4Ca5zFnImV4F9b2yLXhCeBdDtV?=
 =?us-ascii?Q?llNiiwLvyYac4tguoN6phkoqWBdEZ1WOcRWQkvhIcH+/al4LD1N3wP7k5OAI?=
 =?us-ascii?Q?8bYJKWmKSrQ/nHyVy/FEQTGGfAQTYzS1o7kSoDqUBtZvrn8mk0y9Eqc/zoaC?=
 =?us-ascii?Q?1gRgvtZQTcm69bZ0Y1HPtoC6pLgaDArzSvvoHY11R6eCuT13PgGJFUWNEkSB?=
 =?us-ascii?Q?f4REDgLxvh8y6r0Q36colQQk9cs3ZMvxO8JUODOprkkXZn+pgk2Z2Za5H5jH?=
 =?us-ascii?Q?w/4fBigRJI8SQrsn9BjIKwhoOTh+71kRfdv6uAj5cm7AA5xb1aSe4b1RbPpB?=
 =?us-ascii?Q?Hl9XFqahCNP1r1mgNrS8/CADE/KQRICcKRBVg/bunuQuhjR2k6I9bQ8a00/3?=
 =?us-ascii?Q?rQcwb72qBPQ+gwLxNoA+suWmUQXq5ACk+jr/ZYC3cmPPp5N+uPO6F4Z1ziBl?=
 =?us-ascii?Q?JHeKW2zJ4d6JTQM3RvSbzAkCKLnRi2e9BSHV8ArMRUBKMnr4NcsJ8HeyTLzm?=
 =?us-ascii?Q?DfeC94hd5wZOE0X7SkqO2q9ULCcnNUDjE+so61N06AnY7kt9RKzp9uOzrDe5?=
 =?us-ascii?Q?JptyKUWWuOoEjdcf9a4gDQlvLVKTY4Ha8lRQVEGo/f/LuP61BELqL/A/pB/5?=
 =?us-ascii?Q?vWQvzD+Rd1yNkDWPs/r04sy1DAkNrlRkmT1QA9SAE3W7cXnoSbuJD1vx8n5Q?=
 =?us-ascii?Q?7cTZ34chsA0lFiYjbgB+eL9c48uU8MFfTVv8iXnWVSOjgqFHoqUsmx2d6arN?=
 =?us-ascii?Q?hgGxRxIJRFEmx8hUUKWfFPRIasGuUXYu/xOyX8s/CnMpDyIbXXzXybssIABm?=
 =?us-ascii?Q?jfqHswiBeI1oVvOBmUmJyL0yxbEgxcvUZX2x1k4IdLWuA4Ox2dGQM+EkCwlf?=
 =?us-ascii?Q?l8Vn7f1/nME=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tu+u/eHNOT6DfXTp5JoBn1J6epY6D8siaAGmEeJxT2oPscindiB0R6cTz64V?=
 =?us-ascii?Q?M2+mXJHDNORUhNW2aZ12rCqVjk9+gA2DZEEE+ljkTIofxVe2G//obCH+NfVA?=
 =?us-ascii?Q?KRD7mWkwMl396IZCNWZ6MmurThHoJzmuf+w+Q/CE88iKi8NR/imYD0C7rvds?=
 =?us-ascii?Q?DfGBr5O/weobZQL522lrHRMZwN0cjJqvACW3QYwz9uPsFW8Zye343hhIIm0z?=
 =?us-ascii?Q?UNxjpOxU0N1KOPeUnv8gnaLIeEQ3/ZDGPwobay5NRjd5Wgxcl65VKSs9CW+A?=
 =?us-ascii?Q?amuDLrPLV36JQ1Xi4cXegeEzcbaSIcqR0OcMa9KSwJXmfIhFHBDpK/e5d6XE?=
 =?us-ascii?Q?o6BCPNcJqgEJD73qFlgII0/knocGEYaDUE81WFdt4BBplN7eF0x7DqPYqMdH?=
 =?us-ascii?Q?60hukXLfvQ4xDWthM+dfHXtpTc2eiIj1z4a61NZYg0fwHUwcyUW6Jjy/3oTv?=
 =?us-ascii?Q?ocvYovjpQEuOE0UR+jGidg2034HBgG2HEWDiURiBfnfLWo8ZhXhlGgsuRiuM?=
 =?us-ascii?Q?Dhd/GSRUVBmpsj7Il8Qcp3c1BZ1slrP+yJxNNhkN4W1QPDJ+DP+4NNlYr87k?=
 =?us-ascii?Q?HPCjnwvmU4LT9CSiVeywMJCIBFrXtqE6rODSkVb/OaKd2kNDNgH5Wlg+WXck?=
 =?us-ascii?Q?sAzXswk1uvp+wbwmnJySadjNLErgPYakevxbhNJ4GgrRBx1XVpv2Cs3Un9ET?=
 =?us-ascii?Q?MeUWNgHia/a/m9YkaopW6l4OBQVogY4RYE5l0LlutLl57sr14kpsSg4uxjvS?=
 =?us-ascii?Q?dcyUL1JQbKBo8TD/dpzGWjzvlGX4vtntySjlHn9zokTUUi1OpiNwLd7IHjTP?=
 =?us-ascii?Q?maYlTDdq5XruyZDU3aWVfH+RyMrLFk0Q/K9FtFL8Ka68xlJ3I+2GHtjZwzGo?=
 =?us-ascii?Q?BwSRV27WtHCnGQhCpnneAzW/u67mqQPiuBdP0RcIc/Z1F1rqehesdkMMZYyx?=
 =?us-ascii?Q?GSVUVo0d/NGJH44p/FsuQCFtcS+T79X6yg31MMqQbfs3ivRb1sWLQE21J7h7?=
 =?us-ascii?Q?iaov64V5aL5/eljTDBS7OXTCbZuu9Qr2UiN0Dg/Mgx2lx4eBzCwVSW8f3hUy?=
 =?us-ascii?Q?phUK0hEyKN9G1d7JthlEJIgKszJxMjkm1AvlmoELeyWlauOsXJ9aqlGrv4sX?=
 =?us-ascii?Q?XWJWPPR2I1uv/sWAYG6N2Gn3ZxNtRjehpBfwW9DRBMCOEVwYfnK9AjFgxxKU?=
 =?us-ascii?Q?DHSob0uGrNNfwihCDwXwm9HcJYFosfAk2iYUo30esL9hrbjOnrsKf8K59oEe?=
 =?us-ascii?Q?7OQfgottjRA0PwCDKfZtwDypt8pT68rb4LG6welDKgG/DVsojlEnB+AD8M4W?=
 =?us-ascii?Q?tL1UtoumHEPa5/oOrw5udbJ60CaQ0qISLvnJJSAlkSnyTxgFdQGq1oZWEzeJ?=
 =?us-ascii?Q?+qq7aRa7y4O9BmxYEmh3DjoBBF4jKf8fygmkzer5MRUoxaQiNfqNziQu0LnY?=
 =?us-ascii?Q?7YijWQS5ddJZN67Pxq7rsS3RvJLWw/diAw9fBPLp9shocgMHp78JHImAQwZc?=
 =?us-ascii?Q?9Fch0uvE98008nq2sy8UdpdQ1a/6fp5crzOhnYPOvWVBKhIJ5RMTn075I1ep?=
 =?us-ascii?Q?ZIW5JIqpOpRNcZzrKDAkhEyXFqBoJeUsMB9tUDnCOFNxPnFJqqc3SaUCLBq7?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b787555e-88c0-45a9-b29f-08dcbc4c60ac
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:32:20.7003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4gS0yqgc0reTDV70xPhRq04goqRjui+V8Ryhz39p4Et4JA3gQElKbM1eui6GTG4rOeOFQp3Uq8eQ5jngyAmxjcG33u8RpLDz2RK8k688Zc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6284
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

