Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A2ACF044D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 10:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9A87891D8;
	Wed,  9 Oct 2024 12:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="rRXEc3fQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24002891C3; Wed,  9 Oct 2024 12:51:20 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::729])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2B70891D8
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 12:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnyuklQBcrIoL3JPf/Ejj3Ygsyj+IC5yPATdU72j79OCr3EiJoC15XCa8uMMTyCvql/LTe4bgQ9FxEJRcxtxLWz914m0ivGPO4EJw9cB2jnq4SEUT7qIX86An1JyAXsLNCkycYrYAxkiRBCP6kxER93o9gJwhmMfjmEO3Hzam65/jf0NWB+UNSob+tDDNEUtGFkftv082lTzxnrpWHpodyVdhzRcjXVVsnk2u6T68Hrzvh83hl0C8TizcYVdJURZH7HW2eb4952GG5PYF11ijhUiFawPv62r079JPW04BL5rkHnlb8hs7jX28EcVr9QTvuYVT0OoLgPB1Riai7l+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvSob/8MKXYwUczEzJQec62xlkHnKmYXBuQOX1JppUc=;
 b=I8ZiR2hvNLzV673112Sr2EGS/wFbCdVO1v8S/ZirLaIfumOQX07HrHcxKxa9qfGfVKcohGOvQ43YQDR3Oabhv5FjjWP/9ycccvKKyZ2W+91bP7snsyxUnJ/YA/wZcA6lUMSk6JCrmj4KbE77yAfB0BKuu4ZTTo7xPKoU+bBQm12tDn2Q0LTjs6xIFnEk6ttJnAjrm539PzR2pUA3TWzv0OtcXdodiNvfuJSe8/GmYaSH1XyUWJnxyttq360yUzSnR1/3LHd6yP+IjvC4fiN0wy3fCWVQeW5xevMUpVxhvkXsVM7RPxV4EndxuNcTbEzdqVDv4CCs2FlFVwzYekl0zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvSob/8MKXYwUczEzJQec62xlkHnKmYXBuQOX1JppUc=;
 b=rRXEc3fQr5EQ02aAp6f5opeqSCAazXFTxgTBVsJ1XRyvbVHaX8FqdQJTxTXqab/0ab3kHNDMmNbUEABAqrBWP17hig04MM6EiZ6JeNHEWedl+rxzGQ6G0oIKtV6+yT2t63x2JfoQVtqVUQcIvZKw3sRKpGcK7th6qaPM53qiaGbYZLnctlTe6u61NiAgPZxiS/yOkOq0z2b/7/5iMaSN2xrsCnreabX6ZexIKczHcu7lR26TlCGITlM8nXiG0aY8EEX702OZteDhI0DFuiH0svMTWOAm3sVRsAmpN3tky9XA9f5r3nNdOyWGj4RsEBp5Zj/C+LyNsYRdINp37WtDsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GVXPR08MB10543.eurprd08.prod.outlook.com (2603:10a6:150:15b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 10:51:14 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 10:51:14 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v11 08/13] net/tcp: simplify tcp header filling code
Date: Wed,  9 Oct 2024 13:50:49 +0300
Message-ID: <20241009105054.1879054-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241009105054.1879054-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241009105054.1879054-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0081.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GVXPR08MB10543:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf498da-4bd3-43b2-25dd-08dce8504bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YCnzJQsWeQP2Q6t6cWL+gK/BL3WzdrhGNKoxnqlyxSADcEiZYviZ2F/uInEA?=
 =?us-ascii?Q?ZPs9OyizEwekDeYjm35QjNeBJl9JOhEZD3hAkTa935QNEV/lLNQnVMexnnD0?=
 =?us-ascii?Q?ioXnOwDNKlxh0bkQCS33Z4DN9F8TyjrdMITe/PpgSRBSc7sIIWldQfSW4T6/?=
 =?us-ascii?Q?r2J0X80kRz5/+lcuQ8CBiFmLSUk5uHtM5wPupwOYu3LL9KWlwPxMrJv5y/2+?=
 =?us-ascii?Q?FJUYVk9gSB51/VFnLfXGyXH2Ags35/lqC/mXSnh4i/j+3wXBYqyfcURIoIf/?=
 =?us-ascii?Q?QyhZ0QEn2QhLU10OZy9ryPfwmSmJ3nIWCd/j0981o+VeqcyNdnmpMKYFSojF?=
 =?us-ascii?Q?DQRmSM8M+b3WUHORs8Y0vl0jl03Z6Mf2hj1ozGXvgJZt+DuUdm6FVDg8jaqt?=
 =?us-ascii?Q?ccBv8oUaFmy6/H7OGbkPZDCbKUfj/4XtqcZAXGUkOtxcugRoxjGxedZkZzsq?=
 =?us-ascii?Q?f1xBfufMkPDVScHplXFbXd5pA/T7NcWc0rVVUtzuy/DxmUQ7WZo9AY2vrn9g?=
 =?us-ascii?Q?y8NvDS4rWuSLW8W++IPHfm2xdTgP7rrK02oIRyTcZ//aGAEoi7+RR+FrrBk3?=
 =?us-ascii?Q?N2QK64C1q0wIKYorqjC9HTybElUcuTmAYp5UEWYq1TQz26gmkWsuGFAQlM/8?=
 =?us-ascii?Q?35FrAI5c1Ry6Fa+KrUa8+UxGy+gqMLIoa/WibsQYFiM7al7u3t0aBN7XuiXw?=
 =?us-ascii?Q?YTgRPAtAqC/pV4RilxFaMOaFkrMVftbFOqaYlkm+zeouNsOic7NfvfRdutr1?=
 =?us-ascii?Q?O6QRLncVDIHGTFJadwSCslJQYeXh3ZUftEv6E1mKl3SJT6tl9MyUx+QrBXup?=
 =?us-ascii?Q?HxT1f5g8wO9YtKYyB0LAl3ldvbsxEiYufdrGKmQE01TI8tmyzR1OirEh6JSu?=
 =?us-ascii?Q?9N8liovDO8pClNSRtkGNse7/sDV9XsVeYZv8hWNzA9nfDR6ZWqeek8/tFxCR?=
 =?us-ascii?Q?Z0br1RYKza3sfgs74FfDOwGoUdBpbiIHEMCSZV6a7dCfduKzcOb7+ZhLKeJl?=
 =?us-ascii?Q?UYv2Tib6Brln0rUiyyaYeW//3prTFQ8tLhZJD5DSuZwPeGVdcNIDD0DIftdx?=
 =?us-ascii?Q?+hCixU6rh2CY7IEVUADETEJt0AN2/jeeCoYu0nOQa/mj1UQtKjHz6y1Gw7EJ?=
 =?us-ascii?Q?2HHeZsCib7a7xPtVJFPwzf7IT0BR4dDCoJLuvYhhwLY54Fzr579f2M/thj9S?=
 =?us-ascii?Q?o1/E0kjrSBHf5jWWVhmpjTl/ksOdL4U320z4vjLjiVewCxMZgF9KCmUMO0Av?=
 =?us-ascii?Q?mP0xot2REfd3JtrlXYEvaDMnQi4HMxDAl6A99OShlGoDdc/HZSM7OHmdJ/AB?=
 =?us-ascii?Q?Z8OSx88cOZKJhlPRa0M1OsTzdlajYC14oUdBIR4dMtKmug=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9BfWXOkDxQExtrXhoQygSTBoI9VhKs/MXdoWSTYjQeUfJUBeSTM+gZHrO7I/?=
 =?us-ascii?Q?dB9oTFhQqs1U0rW8klc8uT+d3T/kJWspEjw87t/Rz4LqiSx33wPv2vfxTfer?=
 =?us-ascii?Q?wW5vDPhc13PJdzHbsLuQm5rcPFwEkzYHECtVznKxjVMWPW/3HeQBCt7IjcGS?=
 =?us-ascii?Q?NSs2YWkc4Jpn8EvzoBT9b0wpy9dFOO3yRtvLxkHpgE4R8OStWiP00ky7Cbtn?=
 =?us-ascii?Q?3lX/z5zGFgiK9laUSE2vcidosvSrGWT69ZEaIsbL7K9P7JPP4gBAzn1TQ3od?=
 =?us-ascii?Q?XIetPze1UQspLNTqG0cumMwU5rsga+dwC7tW48FmA6dFCJkrpKwOPFDX754a?=
 =?us-ascii?Q?iFhdrOIFaLHiQmlrZKMcEOFLufcGpkXtTIAK+ZGes8s+fGkC/RTyDK2gHYrH?=
 =?us-ascii?Q?5kQBsMeZV9XDd1xTfvS3h44Mmx4Tzb6Ox3NY6AxWQUalm5IHcpe4cx9xfQGV?=
 =?us-ascii?Q?A/DRwvYA/RFOq8CtiR3BH0l5RwzlhZJDwNv+Q6rb0PURDD91a/z8Ih4IW9bE?=
 =?us-ascii?Q?XdyGF3axU5YkB3y/M4kzhSxxu/6Fehnk57lxOTMdBIgNHb61I4KFWDXRvyA2?=
 =?us-ascii?Q?+08gG8nAJn5YCXsAnCs6NZtee8SmzN4QX/8jpmwuVIZKqeUOHtHp+ssJNKkq?=
 =?us-ascii?Q?iPr06mleA7fgfwSwSk61qyEtY8Voe1rhTbLIMH/QZtj9V7fCJdCWgo/4gHO0?=
 =?us-ascii?Q?tobJOythvTL7xCHf35/JlO91l/3GP+cmpDMUrS9XYx/YN1RP0iJt9Y8ekAPF?=
 =?us-ascii?Q?0kZ1ci0EZzugL0Na1VfDWVM4ZKpw/G5WjxyA866tjUf7oGGtVzm8NmpJhf2e?=
 =?us-ascii?Q?Ly3YfSeHpliDzlNDOfNbIELSdePoBJyFutAw/ZcgKRxNdE6knw7AKoxFxgg8?=
 =?us-ascii?Q?ktJCsnLr7nylVcSbvLjLY9nUxcHesxXOMv8007sLl8EfdULTcMb9sr3GI3TU?=
 =?us-ascii?Q?VlnC3LuR5QjR0mKBQTsmW9/+QM/sPkJ2LvJk6xHWSLxH7F/qCVaP3diiMMD8?=
 =?us-ascii?Q?sBhkENd7pBI2ywaTQrHQxJQyTqsqbkcHe/4/hj1jfiZeyRUzXVvYyg1CB/d/?=
 =?us-ascii?Q?KrF3uBct4RNdtmKZwUYVq2IgAqX3oSPgfZVCc496DpByOf3B2QU2TTjHEJ8K?=
 =?us-ascii?Q?7EqYJErRr3fNmL5nq+LuqcZHQkmfCK7R1fI9CLxRfKXDtHrgW/ISZSZJsdAf?=
 =?us-ascii?Q?xCQJUhlL+EBHCuIftvUbnYQYd4Le5T5+uyijjfBOPYxMEss+AvIHmQ4rVASh?=
 =?us-ascii?Q?lMlMlSDS1/6ZtUTaZBsJaqRskVbBij6F5Boia5yeT/OfUYXXfKXWvh/UQJbu?=
 =?us-ascii?Q?jD2bKyt5GtVtQb/E9AVPWUUpVtKdWjvzc+NPxG2f6PHgxgLxRAJowt7iSi4w?=
 =?us-ascii?Q?pwFB9/DIBg3YPeuqGUfthO5xBscMLC7Bj7E8kBxJIiVpJc0HPfIGQLscVgAo?=
 =?us-ascii?Q?UvEToXpowkgtDlGVVqCQ/huHwwMPam3dYiSZzeG82HTr8+E3BGxuiBxuzZHG?=
 =?us-ascii?Q?smLaKwMjGwYn1W4GPatyRJL8lW0j4ZVG6QSWdIjGjOLPpKAMGarDLqNsyoYx?=
 =?us-ascii?Q?z9GhzqMpJfozBzWFCzsixLHH1rbWRhVUQRouaF/j/h6fyLZ8Qr+g79aiY/jW?=
 =?us-ascii?Q?Q8v5ovo4AphTJJpLbrD00N8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf498da-4bd3-43b2-25dd-08dce8504bb8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:51:14.6506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqlgFhx3ENiZ4WSvE99/iXKx/1fqHOpY6H7RDdfpteqhWhZF+sMOotghnuExnpmELja58p+GCNfyzipytIoQVU197/5bDiSPcBoIqaa9eM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10543
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
index 6bb68a04c5d..2a95c44b141 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -543,10 +543,33 @@ void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
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
@@ -556,55 +579,32 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
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

