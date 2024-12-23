Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038B5E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 11:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9392680705;
	Mon, 23 Dec 2024 11:59:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="knhZuhCT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D31148070B; Mon, 23 Dec 2024 11:59:19 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCDD28072F
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 11:59:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBEO09nT1T5n+7nb4AfX4W6vnwTn86a4vpCj5/yfxzIsbGBIMNO99a4GU/qDAZPbR7Ge8hDvEFo28JcEHkE4U8vLg3h1z3ZVoJ8u8GAQ/W3Qtrv3xOtoW2685LxVt8m6sJKsYjhAe+4XMhY1aQbcJaxlI4J4myT93XBkZvPRBtNGpfYMpKzut2k/N7SH0W0URa9rHJTgvhj7zsWX+x+SPjYAhRfsqwm2r1zGxbyi6ujGn8NQNQ6csWobUxxzJ5Bg1NhFmBdm4d7EsbnGTRVZoWh1wMDSyL0b43Df1K49dTJhNpiDrI2Zt2oDH6LOcnHGuNs8x/GiYF5q85z0itReSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1MaKzlSt3o3EYIDtIEJdZnCiJ0Ug71F5Hd9Pb74H0A=;
 b=yRih+xvImeDDe7tkcpZ/6MlEdL5snlKxTml25R3t3eIZrSHDTQhcMlFnCIrYyxjqORX96bJTb/FbxBMR69mmYA88KTmaIgC8o6y0h6CpsEDIgMn3bplNKoPigeQqKrY1njxsPtSruWgT7oQIOgoZBsvwFH1Z3ubTogFiydU4QX9zGXuvZupczECOqu+mmwptMG3xqRFyvCNyXTqGsYQA4J9nPyUolS9O6Hhlg9n65wurB93ctoy+CHvvvaJgPlA5MnekVU1r+4/HugYRUHEYgHGWZO4OzVEploZxhranE/JcG/X9ZoxKQpUmbt7hyhtZiO85cEDvlO3w6+KgwJutbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1MaKzlSt3o3EYIDtIEJdZnCiJ0Ug71F5Hd9Pb74H0A=;
 b=knhZuhCTQZUWPQfjT7r4ixxd0OauS96I33z2RAD0Lc1AfcVtivKi2vECVoQgZmyIRpQXq0a7m3mIR8FZHZpVRhQTNfER5Zooa+bpBZ3IrYmW6OLJxK9WRRHDuHY5cR4T0zkn/kMCm6fMMRffYnRtHGF1G852NKsZK0M4ztkp1rZ4kjOAuFOrE3otSh5l2LLyY61HyOYfgcHFtHiEPNVNay7yI40Sn3H8scC4aJggkHy3OSdJViDE/2uC5V5ms3o5VzmTdoIF2XlRTojcUfAfR04sk0JF3Y6zSQ1HZAFew3gbG9V2/BJUsoS+V3wleb2vf+BscLaviJ7K7c9pl91yfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6676.eurprd08.prod.outlook.com (2603:10a6:20b:2ff::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 10:59:12 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 10:59:11 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v15 09/11] net/tcp: simplify tcp header filling code
Date: Mon, 23 Dec 2024 13:58:50 +0300
Message-ID: <20241223105852.1074404-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241223105852.1074404-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241223105852.1074404-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: b72396cc-d696-48b3-b8fa-08dd2340d525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XhujaChcfi1r8qtfFm0mokMEfmhv8hUZ83FSEGd1lVf4HRZnSZr1nFlMEZTH?=
 =?us-ascii?Q?ii6oi+FP5vgqjqy43gFqEoACOAx2yEg3R3QaScc6ah+glzra+E7Gg2ueSKuG?=
 =?us-ascii?Q?P9kEXVdrTe0GmeWXT1jrNi45SmEi0vEV3ULJLpi3WXPVTb6vp+MmjtDKyG0U?=
 =?us-ascii?Q?SYJgH5pul+JpxjGgQfLnyiSCy6UStuMhY60lPeggCGDqwc7xZNFJckbgINTR?=
 =?us-ascii?Q?TOblmL5XHvBS+fryBPJFdUVhSJihjDyYi5ow2US8K8UI+Wu8rtxk/OZhoNB3?=
 =?us-ascii?Q?hFbNyt5mTn9rntewHrnowEBaP3oAf7dcCa/oFoWREPeR8HkWKTDwIV6Vz9uN?=
 =?us-ascii?Q?8+WHjy6p6b77/d5O8Slg4/A7zNqPq2GNvKJElBZpajGeb9tI1CsZunFS3s2Q?=
 =?us-ascii?Q?pO5idtP9uIBEfp53MeEMtBpa/qGLqPDJi+8MyARu1jpv1JsudA0nyCW/eUdw?=
 =?us-ascii?Q?MzBb7uxFPu0epGzmNQ3zSGU2DojBauijVED0jPQHEG4empkqUJwn/ljZWEBD?=
 =?us-ascii?Q?aYCmaNyNfDnCGdrnaLB3WZ8MaFPjlgNBiLcqVASpjLJlQiGiqLw5jwHF7H4M?=
 =?us-ascii?Q?IfAENpDKxMAmuXKrGDjO8FIVQASM7/49YvA9x9cntSDLLp7g1FhV/uZ5Uv9j?=
 =?us-ascii?Q?xG9Jf/LR6YQkjUuSvxItgn7gBiuRzyHqWouFxEwwVTEsaZ/wdG2MRtCrph9K?=
 =?us-ascii?Q?l9RIa5/CYsBei3oxzhi8wRkZb8MGI00EuwBZBH1E/zQilRdUHvU9BaMYn+9b?=
 =?us-ascii?Q?rtTtpaDdi+a9nbv6YTeakIEQpNS2/DkXjv9mkFdfaYrG1F/gFVw54A6kC4EC?=
 =?us-ascii?Q?WkIcX+wY49prdNkGwyIespgUZHRlBIgKWujve+fT0zHeS8uDKwxt+wk6P0Mr?=
 =?us-ascii?Q?ZWtYN88RTMUtV+VMGzWPjVqID5kuq2/hBIeXIz69TXN1xkpsOUoINUf4te5a?=
 =?us-ascii?Q?G++IELjNDawOfLbmWyfmiXyOfd0wIeMmMRKpbcg7ccBftaTHApTRJL5YjCy6?=
 =?us-ascii?Q?DS/Yv+dY+Cqf9ugH9CMqgZHl54KADISpqht1DLLEF5i++KXudKy1EINGRLhi?=
 =?us-ascii?Q?Yf/D2fIw8tNMHfPY0S4tnyyghcL9PgC3zNSw/14qSYgeXcs14W4S7qxK2nmt?=
 =?us-ascii?Q?VU580fQ5YFd7nhB7Kp7lXnHx9fs1JHkdlrLuZczxv6uk2SSjt0x+37p7GrGR?=
 =?us-ascii?Q?KqQD+lZkmfw4rI4+6+1e6M0qWAp1Ul1KTgFckL57mrABbImXUDapJ3HWsjQl?=
 =?us-ascii?Q?Fd7DiR/0vRC9+7MrFH2v6/z+lz4EqtF1k+W9TyBIbv/Yc4H1hWd6qqZMF5VC?=
 =?us-ascii?Q?r4Ty0svyT2Ei6PoqsrEtRGJo6cjDE5djxXswI02ZEI5ujL7u185rnDHXcnNA?=
 =?us-ascii?Q?8sc8uEwM9CLL+rSaq5zxX+qjRiekF3aLLg2Wb2Tnu4TW2KB6TtTsZlHpdeoW?=
 =?us-ascii?Q?4Zbz+H3Wunkl4wKNico6SKWF7yorfXut?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YTNsg81Ih9f4U0lnZnalPBVXgz5vZdfc0I5hSvJYkKBYZ36ioKyEPLlVryvK?=
 =?us-ascii?Q?8trTGwEqWqbO11Vlks09IxzF25W324goKzE61uN6H7sKBpJulUI8/nrhxU1J?=
 =?us-ascii?Q?BVsYy+0JopW5RK4/gdVBv8gDcopaJVZ1JrBq+qM7nFBFYkwXRvW44weic6ZL?=
 =?us-ascii?Q?lHvOUxEZv37TDblPm3LnF5Cb3bfxOCM+3KWLszAYvDp2UIbqPUasZ1ZcWoVg?=
 =?us-ascii?Q?HL2zLwJbFZouXxtGVP405GiWy0K7xregjd5JMNxBtG1yMLut4kBDAQ5c2iKr?=
 =?us-ascii?Q?8DBBWRC/bpjVS4Hckr8dNL8k3BHXBq2JnIYwukNaHY7zHLt5XlNq7VMurB3B?=
 =?us-ascii?Q?2YCvfXdgLl69ISLdKNARv20g5KMcMp0LbMRzOO/E7ZU5nWfRBr49+ThlchvR?=
 =?us-ascii?Q?2meSFmAoAjs8eVy0OKhwYEsfIZTRKHqZzN2Qslh5wve4y6MuFRpVtTO6wsDg?=
 =?us-ascii?Q?rS3854riSoOUy/+buEe69ot2GGsajlypYWkdskIJbLFRCgjpTZylXaO61kBL?=
 =?us-ascii?Q?jf1UyuShkDH6azjsLoJzRdI8u6wIoj707cO6yDrHauET6QXPfTW8p0+SsOgk?=
 =?us-ascii?Q?wF9ceYj2gtTWmlfG3ot4RSsqxDNUcoHj0SSysCdguv7cXzSKt0dDI9LYs3zC?=
 =?us-ascii?Q?LQEb+xfJpN7rcFFh00v78Khvo05iHcGfCBQtqqJ6j/DFJVELU6jA3CiUQB2j?=
 =?us-ascii?Q?ZVGH8CnvNXK8T3/L9QDfUvEv1axExLVWC5PyY+9KIS7wXZBSNWSHkmOEKyKs?=
 =?us-ascii?Q?wwC9/7a9AF0M7aJqtO5XBdRRFnOFxVuKtXjsWBgEaRwMuY/XAGxu6i88nVQz?=
 =?us-ascii?Q?j39kBlW43dZbOiSqHJXQmg9gfl4y70DeCff1FWg7E8k5IxWe6MYjJ7CHUDFR?=
 =?us-ascii?Q?hmNzs1/yEheczIkKLLBOb2hfQk+UfMKW3WXCTjM1uPy83tfBLK4RV0urzO3g?=
 =?us-ascii?Q?hKgnDljhsY4ni9FkUVT8K28dZNxKtOPO0YTmwphISOCd2lKQkKfqboJNKb0B?=
 =?us-ascii?Q?28aNA6uG8PBy5VrNEFwzWDEvRC1+l++JyJbeecDpeMLYhQHsqX6rm5nZ4G5e?=
 =?us-ascii?Q?L0LYOPF99XQtlMUFdLtgKJT6NLgwYqjyBhnFndPTuJ5yA03cLTPG6Obhx4h2?=
 =?us-ascii?Q?Xmkp7Y3swlQgOvwpz1xVIocXL+XnJFFo0zHSApjcYJtTmH1t4CdLa43XfmD+?=
 =?us-ascii?Q?wY0ap+xdehfWeVKe3CDrscczNiCQDEvtD/G4FyWOwy3zi9asHoTZcXzBAWN6?=
 =?us-ascii?Q?bmWszK6JAVyRlK7WzCZ2ez6Gt7IA+8XrHrQaUPvIwTjqwscBZH02/oIN8JY7?=
 =?us-ascii?Q?xpPzsOe5gKsh1kU5JdimJ5eDiHH4ahfw0hWObguY1av4wkSyrH0P6O82Gz/Y?=
 =?us-ascii?Q?CtAFMONP+9T8CCTZMaYxRvlTkSfY6i4OoASK/ut0uOOv5FgD1usOnnqVxset?=
 =?us-ascii?Q?UAuC9Aob+BBfYp9NC/SyfypCdqkpcKeSRxfWJ+8ard67CmIpHiLdGf5O1G8L?=
 =?us-ascii?Q?1smr5+rbRZ90k4fpqIILFbP4tyYhqF1fW9+c+prpdEOBp5MBQlIhN1ePgyI8?=
 =?us-ascii?Q?B2EadJvZgvEYmZNo+z5gEYzG4W8n0jxInGFdOmdwhINchmZiYgKqM3askNou?=
 =?us-ascii?Q?wUMOx4e3B2hZHJx62hN8AZU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b72396cc-d696-48b3-b8fa-08dd2340d525
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 10:59:11.8888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muZeO3s/+oX6Wi2Iup8vX/0X5b6uu01DQpBP1oIAKftAN0k7EekSyzgKgUTO5Gvb2GDefs/17CzcQnRmKUVZexMP9TSyeyGHRl8wqS8nbss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6676
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
index a2941951834..2600f74b265 100644
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

