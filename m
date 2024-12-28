Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F23E77188
	for <u-boot@archiver.kernel.org>; Sat, 28 Dec 2024 10:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8A0180570;
	Sat, 28 Dec 2024 11:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="TMOpFf6x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0129280570; Sat, 28 Dec 2024 11:47:07 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20704.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::704])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9BA5805C1
 for <u-boot@lists.denx.de>; Sat, 28 Dec 2024 11:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CA9+Vw6WM0hGVyzm1h/4Md3cgBlID19bhlqczpCWMRH9h0ODS029kWr+WJHpyqsBSoZ/fNei3EGs2cCUxVWd7kM/a1TRCR+f5vTrfnUxXpNc6fOd5pPSLY89Z8E02Vw2ILXdPwz6k8VDnVI1ITDIRh05DIA2l1IeybSiyObyL1byfNZ3rE7RwCqVW8VbOwkptx3fe3IHIi7lSyg3TM5JFPyAD5GGFALrGJ33jvkxdh/qi+yD0LKZ7aS0oH4IGimtHaF4yOFFDQs2gu3A41pcMYvhzQlbJN+qUqMXGuambMeNII8SVJnSnW7kykxl1IP4ZVus1Ypv4N7RujYWegvN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1MaKzlSt3o3EYIDtIEJdZnCiJ0Ug71F5Hd9Pb74H0A=;
 b=kI0c4Fp6LeOOx8gsU/0tuQQKohMhdsjleMd9g+MKyd7vBUeHjE9imxokuyx37bw4ls4PujhuG378AqaoDuBMOXdqPG/ybh5agODcOeXJShFyXr5ycHq+umc/2cdnYKj6R/ephbrbuAK2UC07m067PUSjL309vdNrluGHEBfARQ+FHx/R5vAZyKo3Urgq9vStzHrG3xret5+53qN04JYlKJ9wynkp3pLVToMQ4xho+QbIY++jNMiI/QCjYg8FobgYycaA2RLq0MAwX3XTQjGcFk+tzFck/TQgm88/IMaWGcBIgY9a6hYd5tpsRlVqmp/5bNsUoBQ1aLyFuslppQQjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1MaKzlSt3o3EYIDtIEJdZnCiJ0Ug71F5Hd9Pb74H0A=;
 b=TMOpFf6xqn3nY4mkR865RlyJfefgye+sgxJJBr++2Ow7kLET2R4wTCt/sXo3HdlRlZkm8DP9vAHqVTN/RhVE4kslq3xA0bbCkR/AYTq5syfctXwDEX4jCeHDJ6Xd9DwglSIG7APyDPFuftFhn+UFP1PE4X1e/h5ZLzAISu1mjuWRzxhRKtLdg1eYZkPIrKayPF/UcAokzwKCiT9kJZs6AVJylk3VPBA76/bCSYsjDvyCEOIfHW8B5FiVE0MDDYeV5hpvlOaevtumjpE4UJqL+ApD7q6MooSWfZcnlXxPbbQaRMlvjpUVl+0d9SFaliSRLtIjc1hIrjYROuG2I148Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8437.eurprd08.prod.outlook.com (2603:10a6:150:c3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 10:46:57 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 10:46:57 +0000
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
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v16 09/11] net/tcp: simplify tcp header filling code
Date: Sat, 28 Dec 2024 13:46:35 +0300
Message-ID: <20241228104637.4173913-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241228104637.4173913-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241228104637.4173913-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::316) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e1328d-a6f9-40ed-edef-08dd272cf332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A9R2GK67HlGx28S4Y+FzgIPAyPu8jsjv95ilC2Et7d+22R79TU7x8boUI/E1?=
 =?us-ascii?Q?RUEcoKkdmjZiNwUEG0FgtHTzPQ3WhK4Yr39rF0gQJabidkmjbsjA1HQbjLRQ?=
 =?us-ascii?Q?Vt8bcPNNvzasreS8eqyt67Z9m5qVufloHz7w80FRtOQLqJFEk1sgkCyW9Goe?=
 =?us-ascii?Q?9Ca0nXuMqVcvcBAZUxqo6tdYfoaS4J829Z1Ig/tMcc1lPN3QlDVR84oBRo46?=
 =?us-ascii?Q?d8XTr9+v+K+wyQUl7QSpWbbTtvo16AbkA1DkBoQxq6E/s/N1B3zOngsW6X3Z?=
 =?us-ascii?Q?nlLHHknTet9a7BJhapli4ngqkhrhMJAMhrhwUxL06ojZH1/CyKNIgh6qyVX3?=
 =?us-ascii?Q?RZT9qvsWvya30pW30kkLpdTxwKg95o6F/lC72aLU8BeDP3tPjSeyH56ZzFTh?=
 =?us-ascii?Q?+MAax1Adwic0/YEqT4YAPu3kYmItsLXhjispLy7zi1igbz+Ryx6KsGgaeaMi?=
 =?us-ascii?Q?nSTq/VWoIgJcHB91hC9yISRSJHY1Ipvydv+Zyj5iXz/lcxkz33lZqARIwqMq?=
 =?us-ascii?Q?TejJPfEqTyulvscsnwVWndjOaGsInVqSVteMqzJDmo29vQy/SyX4dTggKFkZ?=
 =?us-ascii?Q?bn9ijYckxELt2s3iaO8q2bjND/7kmOW9lmBJXB7K7egW8gZ1FL2jNK2/+K2T?=
 =?us-ascii?Q?VBjvnBDDc7GQJ2T+fEAXbNHW+uoGtcK3s2G9ex/IYVOVDf8c+jFTVVXgFy0L?=
 =?us-ascii?Q?In6fyqCa7e1q0gcrAPp+/iNgf/08KM1Mwv3/13lV2u5rn/+JQn3RXSSoCg+6?=
 =?us-ascii?Q?x8yKxhuXvdaGOYuDbMcw+dGP12upV87aQZ54xcDGaSBjJql0mdYxN4MK/D0x?=
 =?us-ascii?Q?WKLhOw+vPiVb54N1xSMJy/1ZRIp3rGpkiiUvjimym3XV0sEgwnaEJmaYq8/V?=
 =?us-ascii?Q?HdzDobSjBw1GGWdirDn3IO7xjF1wJW98gvQbb7Wq+59VYJGVJubqknC3wiDt?=
 =?us-ascii?Q?eccbEW/iL3CeuXOiZDIgmI9nrB7O/zpNXsrm3x0H8mN6h2BbzzNPd+NTHLR7?=
 =?us-ascii?Q?9GHRbJzhJotVtt870GX4QgkPWw+gyAo90s97fAHofowd2FFC1KVpFjegYYD3?=
 =?us-ascii?Q?RI97pZWL7WFyzxMixrJ4MlauLH470xcx0ATPp8XaMOx7VImefsjBfsJ8L8ft?=
 =?us-ascii?Q?Y6T2vbwNbxRjfgkkH1fU1F9GU/gsEd7eatflG/Ky+csthID6pQluNtVrRKtn?=
 =?us-ascii?Q?+Yxex49wJ2SZPKmONa8xsrUCCYc8yyJxwDokV1ssn9TgUU1zTcmtFRE0Vyi3?=
 =?us-ascii?Q?6qnFUdeWomZTECbuGb/vBr1sMPw5aEPzb70mSC/ehjZXjWJLbLYHXKmS17XV?=
 =?us-ascii?Q?dIIlATZ9YZAn+LXYrBnkf+vxwwGkoeVOvZq8dFKEjAmnWvIdOcHPpMXmNRcl?=
 =?us-ascii?Q?Xt/HlnS6SigQnipgxB8x0RChPaQeOb1dBhJQk57RHm8jAIJqwf/Xvvcte+tQ?=
 =?us-ascii?Q?Y3xax9sx9nkop+AqVhASBy0pQAsxif8R?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aNO7o/JlR+iaBmbQlbXPcFZIVlCtn3vDCaL8maFzMLrsdA8CRXgJKR1p21ZE?=
 =?us-ascii?Q?b6ZOWVHQ0PoSU+wkvRdhHM+jL5pU+qI/nS4zIzPaalvtzhvNAuGuiTq1Y9Zu?=
 =?us-ascii?Q?aWel7a+sCXvnLaOTJ0eKvEaWnZ6/Vqq9PwMLfaNNaFA0PHKXKZZyATGgozLx?=
 =?us-ascii?Q?cI8F28YxCewx5DhEqzhxMTNzqAdrV0Iaw0sM+KimOa2rz4eIUEY/zX0dBtjF?=
 =?us-ascii?Q?3DAORvQWbOU9m29qn5jFxclHIisqJ8Kwf3yHVPiLNG/dFzOy1vGb9lcUVerc?=
 =?us-ascii?Q?fyV5y05q4g6B3cl9R/KKXWZs6Q3wo4fYIw4hALCIKCSvbRnQkE7V0J7XMcMY?=
 =?us-ascii?Q?6wZ2jOjtWbjMp/BBwdQKna0byzj7RxQp3aJBJVaL086Sd8MIGk+2iFCHNWKc?=
 =?us-ascii?Q?VHn7Ff/nLUJbnOCk8R8YR9kUTwKJeOgxRMS5woz6KPFBm7jzJ59nl2FyneFK?=
 =?us-ascii?Q?ofT8nfs+/HUXY1FkQthFxrh6I4os8mnhXktQwhCpLTANrFxJuvqT1QQgnrsZ?=
 =?us-ascii?Q?mKTQpe/9yr4ytQ8krD7S2lP6X//GHSTiIrpjMPj3rZtBXre8KyesjTGUhi3J?=
 =?us-ascii?Q?U4nf8bU5AN6EcND5jYB50Bn71ATxX6ohujqFWa9h7TvgWPDpu6T03U8WNYoR?=
 =?us-ascii?Q?AemDI3ww739Zsq2YlkEPXPuU37PmSMWdV3t/pfhn05rz34l87RAxOyeXMK78?=
 =?us-ascii?Q?4Gb5gd+wfdHZo0LgIt3A/hFbHgHSMDTnr7tuTh38xuoryZth6Y9/ohA35/Mc?=
 =?us-ascii?Q?yK+YDN9PI5vmlu6vGka0UsAu2jmLHWSvzdXo0rwLiWrgW6JEWj3P1vS4Q56w?=
 =?us-ascii?Q?0GIOdE3SDV+ardeLFCgYB8mkU2IHb/AFD6f8OCbR9STpkhrGtkKaDvHtyRfC?=
 =?us-ascii?Q?Y4hc8Em/IPezL/oj2AEIR1SbZ4TfyaOq9S140YeFtdH/W89Q40qccb4nxoUm?=
 =?us-ascii?Q?yvRa3HMxPOjY/Hw+48YesDcFJ8nJjVW2jcDK8xH/zWhUmtht8G3TSuefqd1P?=
 =?us-ascii?Q?kBflMo8qMPFM1QrCcB0duik1Pow5gXL4PNxFg18+6eukP6bXbhW35ARfmWjx?=
 =?us-ascii?Q?zH3Gi4JrT5SwInEa4Us6M+5Q1ag54U4u/IHQ2WvyK6hKry6w5EaTe1Ksnz6U?=
 =?us-ascii?Q?aduG+omThWgsmNv2+nazJ6OwRx3Uyt840JaXcHoYLsyVlqK5wwGuLcaoenYr?=
 =?us-ascii?Q?sQp/Fd9ylnwbVwo7nUbl50+miPSqCoPl69XUhTGII4UyXHOkDJRsj7VtLXzW?=
 =?us-ascii?Q?Tce18i4KnioiMeCvaRSxLxYD1F66gNRWnssJYmgNud//+7dqZs6MQflCV+Yt?=
 =?us-ascii?Q?kfKEVMPxPfVfvr5ltfNUETRf4WkI2jw0CteG86OZSh7w2lEKATwd0v7G5FNt?=
 =?us-ascii?Q?rbpPiGfUZDOCT/p5WThC/LsaYb3v5Lb8x3Xf/vFOKNMdgXCvtnvsVdecoXul?=
 =?us-ascii?Q?AQUpt/bQe/hb/lmm4yM82PMa9I3+BqL4qdJuap6DuIiTDvu0WFaLpyRfkD6w?=
 =?us-ascii?Q?FT8pO8JDn7w74WdHBIkakft6bvf6WSNQxmMibJ0SLmjjQDnayz6qmCfrBpig?=
 =?us-ascii?Q?C5z0gjF3tVVxAFiwqTHVqD0/HCRwUr8+lpkiXk1S0Kf1sIQny5RqLC5mQ4OS?=
 =?us-ascii?Q?fnU80MfzESjQ07Jdh7cS0C8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e1328d-a6f9-40ed-edef-08dd272cf332
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 10:46:57.0507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDBiNT/g7KuTIjQKvER8GNRfDkRlvVQYBlhGR5m8CVh1uOeuSntlTtjDxoiaZluQZ4H+jJi7RBbWOlF2Ae7MtAqLBxvMWQzpOvbCE5lPdKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8437
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

