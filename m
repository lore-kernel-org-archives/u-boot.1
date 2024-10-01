Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B17CEACEE
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 18:22:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71F24892AB;
	Tue,  1 Oct 2024 20:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="U6UVuKIB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 692D7892A0; Tue,  1 Oct 2024 20:21:30 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::72e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 530B38927F
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 20:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ot4FCCYKu7iEDDd6mB3351et7BRJSkz4yDCcM9F3sbOiptICGi9yHClRwgudCGiemAfCvk0b0f/YrssrvDjSk1KJIFwrUplcWrvQWZXmlsZjC2crg1JrmHPg/QmYZdGNJzlNjwyU1h3BE1bx+uPZmLs3Uq5lqD85/9oasE1Glcvj6841Jdyz0dLTl0n6tzWXJUdZsXKftF5bgV1FDv1F7+j1tyyfRx67ZxxWBr2wuyneB6nQnlAhqC0wdQvTcCtK+Y3BrgxS4/CYPcxcrlZRS56jWvKzlDTGFVpUL4yME20D/VBYwvCcwHyJ7XBCXQLM9qf+2UTiRGO1cQJF4O+q1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvSob/8MKXYwUczEzJQec62xlkHnKmYXBuQOX1JppUc=;
 b=o/JDMQWxzvtDkTQybDXMlizSEi17p5E60B/UdCX+DLw4o3WxRYid3tuVu4eVya5uzkgeY4PU7AcGtWKnXmr7coDey4SJ+ziJJ8d5nV3W4yZ+82CS8g8Ra9x3Gk/Yc5S6zjZ1SZ27ovjZtQek7KajWopadKMgL00d1hgDlg6jwnALNesGtpqxN8o0ZfYVRNUOZ6m+db8EhGR+SOM2CtZR0u7wDRYc3zkZ/1r3rMx/uKhj6tcFhaaCU6WkgXjsVl8G8pAvbkHyoRycNcBVvIJZofjgPtpip/CYW3NFxfybla53FFvyaiiKXLWRprhRkIHwNOlIL9fg03vtwuWWLXsTSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvSob/8MKXYwUczEzJQec62xlkHnKmYXBuQOX1JppUc=;
 b=U6UVuKIBllBdULUyrYMmrfBuxnT08TyA8q+aNiarzTZyxiklt7tKwFwLfQgbVkWo5jkFGVDHcoZ86+n4mCRckKg+2DCy9cst/0onmP1IVCN17emYayVZSOQI7ohy9JUYsEqU1HWsGGw4NLST0i8K4kZd3Zl6iqnGE81iIWIQR96MuhtVW21rPG5YWSU4f00yY9Id5b+Mpd+U0VgzS67hG3P7id/Ua95iixINhatilFTpS4cR9uY+PLcjZF1ndvrekIUCazej2ZAuWMWfVCVkgdNZ580m4XW7s4ugXRWKu4Ya/s6EaHYvVHCzSd93RJ38KIDYjIF270PP/RXtpVUBAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9153.eurprd08.prod.outlook.com (2603:10a6:10:414::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Tue, 1 Oct
 2024 18:21:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 18:21:27 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v9 08/13] net/tcp: simplify tcp header filling code
Date: Tue,  1 Oct 2024 21:21:02 +0300
Message-ID: <20241001182107.907828-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001182107.907828-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241001182107.907828-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE7.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::311) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 563dd821-297b-48fb-0ce2-08dce245dd02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C8A0frz1syiObVHF8aAwrune0dUDOQoMqTDhJFK6L2gtP2HXk2sEI2gQCGnI?=
 =?us-ascii?Q?y6jKB6KFHvm9qPPPtF3yo8bOPLF0b8B3Y7y1pN03gL73NBPSgmBBCBbjafpI?=
 =?us-ascii?Q?b8bdHl5qp9aDgTlxzb9/iFDNl69UUQuqSR5VGb2JtQkorxbe+yJnse10yBOX?=
 =?us-ascii?Q?62DI6J3zEcIZE1LekGYU+/fzPKawAGnHfsS830lUrYWCZY4SCr4XZFjCPVKm?=
 =?us-ascii?Q?9t2vpEet3GPk2l/a/GmCNr3OnYP5TKCQf/k5b3G+A7+fVeXjNxUBBdw2QzqF?=
 =?us-ascii?Q?HPOk1KfPAU9M9koubXAEdzyA2h73uSedaD0iA8+Up0knlhX5TVUKfAF2fmo8?=
 =?us-ascii?Q?9d24z2ad7Vhx1nCqsQ9gbbeomnVzJCMRCUVF0Qc1eVuCU5ms4EJFmHwyVRaw?=
 =?us-ascii?Q?sMwKDiGBkwYdSAQ04V1R+Aq0Q31JvblS0rvjcHVrxpE2UpR15M/QUWykkOra?=
 =?us-ascii?Q?WzQJS/4hLsP2124Znw16iHZioulwo8I4JAHxiYhBfQiJG2SMTQTGXV/IMYpK?=
 =?us-ascii?Q?+JwsIHt6iwNQDyZ6CcFoxT9Ql/X4Kcdl3eMFRwG6Xcydwk9WsqplUjtfGmxp?=
 =?us-ascii?Q?6iVy9OpYawEXbUOfRF6dpOk3B3z3VCEd7rYO5UeNIrtxBU6tVF/lDuSzqb6E?=
 =?us-ascii?Q?UCgWEjzyONf8zDKgDD1Xy9kPY7PSURZC3IFrl/2VkVYFcxCG3MRIEpUfpvOl?=
 =?us-ascii?Q?fGvZFHL9etY0nG8tXg8ETr6K2YLnalNzjrUXdyW8DRKunxD1NRWs/MmI5FCF?=
 =?us-ascii?Q?hVXwFi3QEWHmnhd2fLxkH+GyZb8+AyRsAKMywzZVg1SwgTftLVge2jkcQZaB?=
 =?us-ascii?Q?/jtuUXjdr2xEUhqMiMvtppMXvxssb4i3TiF2ZrxylZ3ol6DwS7u5kandqyhd?=
 =?us-ascii?Q?qvaitJVum/o9lozUcg0GYlAaZuKoVl6XQl6u3ZpUwp1PXs1Ifclg1Z9Filb6?=
 =?us-ascii?Q?PXs8yfw5IdmlzMMc7AkveeW5S1N87DRZCg2WaN1DQx4tgV8+qlMDTorg28Om?=
 =?us-ascii?Q?2C7jvlQ818Nf2IADO3Zn9BGQLxFt4qli9FdJH4kS2k3pXRYCwkAI91qasfpi?=
 =?us-ascii?Q?iWXv1umhZqcvLzaJAjGDKqz2kmTDnIEebcWDQvgzIbZZLKO3cvkzrYN/icHg?=
 =?us-ascii?Q?2SXwVXdjxO+dzeyohqko4YVWjLUJL+NeIVYCzkzUVhbSPdBT6O5VC8F2MP19?=
 =?us-ascii?Q?HO9dKfqMZXp08T0R6XeWyt6Dp+/6Jv9PnGMDPro9scRqltxyp18u0nEDCntQ?=
 =?us-ascii?Q?IPVxaihhJzMd5lO26/MM82V2d9hQz0XzVNUbcUYl0Icv8BYfaPFypiTjesSa?=
 =?us-ascii?Q?RUyezi0y9T5AlYs4eKgoVSg6mBj0c8YSQ9DmGV+U6B9OJksB5Vsx0fXLrTdK?=
 =?us-ascii?Q?p+he/6syqkd3vEWUbCgpRDdMJlETgeY0cQJ5KUu7hhzxKUY8og=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T1PG9taUp+pL5Mwt//rN3+87bBihl7+SPOxePWExUNrWTbAiV5HxvSubM/Ey?=
 =?us-ascii?Q?RW8XZlOOodSu2zWNla3FSguVUXa69X5PETVF7hobhgxRdUxNEofje87iBh+e?=
 =?us-ascii?Q?DNKfq9dkk9gSXwo09AzIsTqI2neFuMYfr0u1vxJkDDfu35a0Jlrx0ZCZ+8W6?=
 =?us-ascii?Q?yBeT9SQnQgUcD14HaEAej5QQ++1HsyaatnydXMWbnUBwd32BxS3eoM6qnRbP?=
 =?us-ascii?Q?1Lm/boM43ZX2ebkO1l/mpsUpDBYyPSrQP7TjyOLctdjqaFPsTn1Jd6JDxeH1?=
 =?us-ascii?Q?vlpiJ9jUWdRH7pvxLhl8CQqjj81PQuan/E9svxyj8N2HA4kKsldgn+5nAxA2?=
 =?us-ascii?Q?89K2yjPyqqGETN6oTH2nepkzajztGdnfywzf4rDnxVbEua1CiKekaVXuSdiQ?=
 =?us-ascii?Q?i8/+rJKNQWOdOeuKgMmIe8H+I5wQmh32LIo3CDOzAihzZ5UoCpP7vmOiJ7Sr?=
 =?us-ascii?Q?ionxlxN+Mqri0+zYuvKIqHOheLZ3ioqSjDueXnYyu+EuFJ0pK4RM1Y5ZNZ2b?=
 =?us-ascii?Q?6oMtIS/W8JYSywRxjm08ZCnTFuW6XJerJ3q0RN12D7rOMMsGVJBRBvWTgn3e?=
 =?us-ascii?Q?xhA3YzaE7uT9iGXjvl66VDvwjXqAmUCSPStu4NpiYMDdcO1wxkEyZV40C8re?=
 =?us-ascii?Q?b++Xfd+wd1KGxJRae13r/pQxexft9cbljVaCW/KqKbOVsV1oIJ9tAvBMHdo6?=
 =?us-ascii?Q?K9h1QPPhJiB5ueWHspOJ5sXm2cM+bFxYxDR5sBhLzwkEBeyHPpss+IKAUTpT?=
 =?us-ascii?Q?Xvueny1QCd4MSKJpC7c4qGbvOGdnPtmYmS6fi4NYZkVknxSOcVXLALdB+t6j?=
 =?us-ascii?Q?oPoBNolXgzjCyO1KALkPTNAtFmhan6XWs9VcrJVXoNkNeFpTv0qpnQLo3Fz5?=
 =?us-ascii?Q?z5yiffDBRsBdta1BYPppbtMr76zIoMvG74zBjzrq1yJFNSbQWtWM7V4LRhNb?=
 =?us-ascii?Q?fHxzH2h0H9Sh+xUlW/PSXW4jg5HWdcy9p0Vc0YiJd92OGXOXVXr4bTomKTnh?=
 =?us-ascii?Q?wavAbuEXF1+9PekdPznmQ/ZHvnMMoLzip9nZt3InfyFaxRKvV2107i+8AEz2?=
 =?us-ascii?Q?gE3j5u9qdhr6Bqbsjpe8rqbByv0YWGazECB6TzjOy+AapX3ElU/+10tYPayr?=
 =?us-ascii?Q?rvGoHnVP1ukSXDCjdMid3Ez2xQgyGrwhGrX48dFxozjQ5HH7hGD1O3d6jp64?=
 =?us-ascii?Q?NZ6H6CPbniwfr24byMuqNvS9bA224V1yjthKPqH5cLjvAn4v3CxU4if7x9BN?=
 =?us-ascii?Q?HTzG3kwhB3DLYLWtdFoj09f5u2RN1kHRJfi8YoIfpI3sTqHFDnQy6pG9aHS4?=
 =?us-ascii?Q?Eh4q1gROGas0JlRXpvl8EWW4siZJBtP5gybYFi+kRY3nbnDqB7Q0DFZyS0ho?=
 =?us-ascii?Q?cXvFwN86NjgiQ+wYQDd6+Cdbfp1spDEz/yuwMsdbuvSsyvTlH0Lvqosh9JaV?=
 =?us-ascii?Q?ZvYB866xY3KPmCA2BQV8mfmTW1Oc0PpnALc8a2B0jrFRMlDD6gicoUKIYGMS?=
 =?us-ascii?Q?lUj9/AoMdWTub6e2MmZOmDpyL7yLtUanHBXh0/twKS5uB1XvsVRDMxSbGRzh?=
 =?us-ascii?Q?5RGdh60iUQfuHjHP9g71zaRJYKJ2WikP6+f9sc2GHx1vW618xITXzvei28Cc?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 563dd821-297b-48fb-0ce2-08dce245dd02
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:21:26.9723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tL/dmH3sSTfPdwXrCsFfwBhsJobWK175UadsdnvcFIxDYpKpqRe9f/q9rhSyJc+h07ZYTQiw7GdxGPHLpMiIylW3NnZ3CqVfzVWOADue7ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9153
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

