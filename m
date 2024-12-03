Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC217E77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44DE8896A5;
	Wed,  4 Dec 2024 00:01:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="nHpLlkc7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4EFC89696; Wed,  4 Dec 2024 00:01:07 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20714.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::714])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD5D589671
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:01:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDotKeA+oVZknTwTtL8QJIu36+6WJ3505Av7+Ix9GsrVoM/9sJu1KsiVERGmkdUdZdkh+YMMAHo4EoiagzhyJ/46N1sPVhyIIipPowdodeJtAQCtWszZDPk0CO87MGoWafI1bAzBDmnSjtUXTEec5ho5hQ6lMEmVOBpqhQmUV7cPg4cNxt9CcEwzkjUZfNIMzDf06Bq4IO8r2d19VgLKBYidb0mQu6tWFKWFKcKNHJc4EAS34OLyfj8SC3iPu7G/272jytc7EPjL4s1KXJdyK1E4y41Wq2pkvNIfq/36e7rNB3dsxj4oOgs6pH6MVkMrc55CT7aqfPUFaFvBz8g58Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34txf8X3DEtURNTjq09Ear6d8Ro4SW5IvHcnFj4w9EQ=;
 b=dRpipOHxCFp2V3/ka+TDl+lXAPEyvTT/jVkzbqO+TPD911meOBk3eAuPt5aMGutjYEzU0bUZ5nD/rKhhccJxFEY78dt++QmdsW4BQrauDyHQCMQqpMD13/VY9Zmczpu/arIHK/g6O3qUG2jwWCjZN07wmJ5FibwfxI1SuN+wMgaImBnEib15VVvu5i81+x7E6Zq3n0FCmHWYUfU8UmpKOdZObhgkT7RfZORMH52pl6Pb9lsie5y5KhVIlA8wIPwbrUR4x1quk6BL+pQFqpgbIKqAhynDo218dfaMtLjl0Ar4kCol8ExtZBvJXwZG7S86nRBIXHbOOBwsdJWBan4QpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34txf8X3DEtURNTjq09Ear6d8Ro4SW5IvHcnFj4w9EQ=;
 b=nHpLlkc70UOLnN+2psp3HJuJZQy6nouZ2jSEKF53fqz3e12BkUCk+CoNymJkAQVGLxN+fNmjaL0gL1qZowWIkjfQJ7TkPooFMTHoqiqUU3zffk22Q1lIsZVkh0NFL/lPH728jKoaEsq0al84gCEliSCCulu6NGWxzZ0fM+/ufpgojlm3TqJjm239lFa5Sej3mhqoTO/LO+M+GIkcKaLi4xlSjaYBLAJ3H44d7ZRPqH2kFLRGQiyW+b3vEb3nDKjzMiy9eJev2NO46BslaJlhsPQ7fqG3Y+1VS0iB1KFDB1WA5bRDNz4tJx9QnYRJ9/4IjaWVQ57ltt55W+zdYcI+xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7611.eurprd08.prod.outlook.com (2603:10a6:20b:476::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 23:01:01 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 23:01:01 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v14 03/10] net/tcp: put connection specific data into a
 tcp_stream structure
Date: Wed,  4 Dec 2024 02:00:42 +0300
Message-ID: <20241203230049.2677155-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203230049.2677155-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241203230049.2677155-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0040.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c088f5c-2ee1-407c-887b-08dd13ee5b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NVNyBJJkJ82qvQMNuFPOzKL2y9R4Pu3OjQgss1yRXnmoc3VGPZ+PIRh1gVGd?=
 =?us-ascii?Q?iBtMMpdKgjnflPiXLjci8mFg5PxUa4zSrhSQ7UzoL4Sf8putkQpcXt8QNJYg?=
 =?us-ascii?Q?WfONC7LZ9SWMK+aAyb2kvMGHSo/VXhIO3wELG5D5n5MxaJGX9FCLeA8VVSRW?=
 =?us-ascii?Q?xyJE/5q9cXfoYYnBi01x2OQFvOBpbBZrVjzz76uJ1XzsxMplGWUk35v7It/p?=
 =?us-ascii?Q?B+sCqj7bSqqqggwO5UpuH94p4aa0OrkbZaWFJ50afXegqWak3z45x6zPld8T?=
 =?us-ascii?Q?oZKPQfN3p6tva+ioKvUZBCCpaTA7RkcYjJeMMA3LHoLSEr4JHb4IL3oNfT77?=
 =?us-ascii?Q?M5NXP6P1i9i1qW2t8zLXHcLB1GQrf1+DZvbirk7Dj+E1qu9l6NFhwh6xP8Sx?=
 =?us-ascii?Q?6jvx5czLgYJxj4YcHwe/f5onYnCn5GwEchx/EZKvNmFvlZ7psi/tsz1qVzZX?=
 =?us-ascii?Q?xuAHRBd1PRACvkmGsKglQfgKN3RD7o3TleppW2JJfP3fdcAE9A4twLI5Y5ME?=
 =?us-ascii?Q?e+fBdsp3phBNzDxWCtQGoUGkZPhkXnXObsdEtDQ0uTuEEEYqkujjnp/eXrLQ?=
 =?us-ascii?Q?4LIALLthwBj/sraHFFk3TQ7oEpe4Is73eO96uaNJPKj0YYqSaGsH70GrnGdD?=
 =?us-ascii?Q?axcovzf10oR0KeJUykdPawhtBN2GT1zI6uWq8kyzeX61RVFpYa9QcvsntvDy?=
 =?us-ascii?Q?VvHTu2V6tpPRYORdDIHLjLAc4RGhUd1kpVcJ2MW9exlrunXTaXxaorkyQMdQ?=
 =?us-ascii?Q?wmdmh0K3008WTdtu8UMosUaw02tdiRupY3mY+0befNP3eihZVex+VynlcLWN?=
 =?us-ascii?Q?iXHKnbH3JrseQMGzT28IDxMbuMB1Mpv2MtvWfvN678wfHW1/1w0E1w6lxolT?=
 =?us-ascii?Q?amHxE2jyUWpZNwQqCZDVL39nVZJdhks5B/FFK6TFDd4ljqlsF3Fnm28s1mQ3?=
 =?us-ascii?Q?rkd0pPPj5NbMJ77kNLuOqXhKBGHe2P9473RPzXGk0hh6lM31s69N5RrWtATP?=
 =?us-ascii?Q?QlgUpy7b1JYxSv5vKl0UnCdKkcLWYSqgpJUW0dDIgKUOjPuD03ETxdsuCmGP?=
 =?us-ascii?Q?MyUe9ObRk7avtgqiRkPlfwZa6gvP0zMW/heWfhl6qge7QX0k2UbQnKDBa+iq?=
 =?us-ascii?Q?P5bccZ0nLHBnjnYTvhHaCSEsZWSk+NdnBNGQWo7V479FE3R+YEqGEzNnQLnM?=
 =?us-ascii?Q?UAFaHaXTmgvLB2EPHm7PLN5OKHe6ORM50IJ/9+t6ouTkA/2wTjOk/V3mysod?=
 =?us-ascii?Q?ANeFQ//xeLlb75TgeSTJCCiHcDsuhgxchp3U+gPERatPtURzN2lRyBwE3ZW5?=
 =?us-ascii?Q?WzwVugMdvvNjhSTE0cptvWF6aM11MHMjCyrdYrn9nFq8mMh1mA6iR6caa7kn?=
 =?us-ascii?Q?2LN3ZJve9LXlAsMYWKtdD5Rcen3knNUFahyN3B5SwjCfwW5J6ka4YmFphCvv?=
 =?us-ascii?Q?Vl/Mmg+Ej4E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y/4y8U1aKFL9EtHpwvqVEhEODH2FaEDNqO/evzOqyalH36RlTCAq2o5xymtk?=
 =?us-ascii?Q?UMvpbLJxv5Ik7OlArClqaRKGapbxEv3CQYhM5naSK9h88fzITS7+5jFU7Qz1?=
 =?us-ascii?Q?RDNufgpQQYwXIkmftkllOlq96Fi+2mTBM32jZvxnRG7k62nmUeFPWZncfE4f?=
 =?us-ascii?Q?yRn8fAHAszOwJiR58nuCARiZ/HdxI6kSdr/clw+xe431uDwIhpaCUSC6d1Cb?=
 =?us-ascii?Q?jCW7OPe/9sUXwJUb0Zb60KseBFlDVpzLEhAQfamyH/AW6V7rGGI+buyjZwXQ?=
 =?us-ascii?Q?KHArmpwQIgWrVhq7Zi9/16MCcDZSCsUD+gmZYPIXnnzMYVfGSe/C+hhP7wfy?=
 =?us-ascii?Q?nG3KRcoqf5sMyO2oJ6Fi/SsrQNCm/EkO52ZMJegAxmKAcXr846ZIhTG2TduW?=
 =?us-ascii?Q?USh5WPBrR7nrrpg51GOZ2J62x40OyGwohv28XZ6S7da2cNAQwfpVfXDLIKCQ?=
 =?us-ascii?Q?EKcUjPvXVIBBOfIgVn43M9xTEQzR2EyV7892E5CqvPrQTDoO8Z/yh3aNYNvz?=
 =?us-ascii?Q?I0D3ggB55H1W/esJFYG5soQt6BAVvzd7EkR3e0cZKJHeMIaw06UR3pdTgeeP?=
 =?us-ascii?Q?My2vAvRkz7gfbZt4GPGcebxwc/c3OJR7QNJcFzr/yx824INF2vBL3ZWWPrOw?=
 =?us-ascii?Q?RTRx4h5RAzzCYiJZqTR7bsYcbqiR3bfAx1XE6+GPL3ZyVto2Ln7qLyt7ACHK?=
 =?us-ascii?Q?EP3LskB9EOc2MsCVyJuM6HviPG4XoCMgEio2e9+RWZtTxuy2W4dIQlW2uB4g?=
 =?us-ascii?Q?M8/RKPAIn1zB2R29BpxUw3KWaiHioxffXHIyrzCqM3bFkIhuMBZGdJkvaJc5?=
 =?us-ascii?Q?NSv39lmEby1Kfw/W4VhyC1DtVb8OdydsngRWgGj/GY7IOxPwWm4+6r0FVdSz?=
 =?us-ascii?Q?O70JoFyYQyk6NU+yUzHTV2tsgVYoSN1Gw4dBjbGCSKH1nlRscbGu/qjRgKQy?=
 =?us-ascii?Q?Md5VD9Nx7nyO1XFi3ZLc51ObDzGXgNt52JDyr8EET91w43Aiymf8Bg3V4ZfB?=
 =?us-ascii?Q?aIPW3KVl23Ihd2yfu+nFzId6CH5Y9kVZKI3xr8fbnwJ65OYIN0yXuNnBhERk?=
 =?us-ascii?Q?p2z1yuzfJYBKU9QxdzD/4q37sV3BA+EXch8HrgMDdAdTTKcAHEjVz3xcobGk?=
 =?us-ascii?Q?fjMsX6+1qxYXIDap/9iFpL8xFjClQHCH18t168MsRWtzv8qEnn4FjaAZCkiJ?=
 =?us-ascii?Q?iU6SvuLJ0JTYjoaQnhRRw+3ReRv56cS1IW13bnWKlOcoriTQqge81yUw3K3u?=
 =?us-ascii?Q?1uLagpPADkTOQTQzL3ci9vPrsj/1yyYk9q13QAcI8XspCCTjZ520ogUh9M6r?=
 =?us-ascii?Q?IJwAZqklhYRbG2YJmSVTxN8Lan1ZaSZOMqV7z+nRf7L5k+xvUm/WCxTHeOz8?=
 =?us-ascii?Q?depuAS9ZpBAykXUKvCFDQLk0Oe30QQtHDhmIi3oDD9dc7X9KTcgUC4AjB1VC?=
 =?us-ascii?Q?ouIJf0UXBs2M3XE41iyp3E3RiCZYBRp32y0PTGx8cTql/BUYTbDcs2dPHS1j?=
 =?us-ascii?Q?oaROLmibpy6VqU8KROZxuie3h0fP3or072XCSJGYErou+Mo8MgYSHDE71LfQ?=
 =?us-ascii?Q?Y4td4Hf/l8Qx0jQtId1gLEFVTQsONoam6zBlsBVe//fQI9/YWnQdgiFu4i6C?=
 =?us-ascii?Q?rC3HhaI4ARG0VgulPgvoQ8s=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c088f5c-2ee1-407c-887b-08dd13ee5b6a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 23:01:01.5184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJHHVosRFrNOZz7i9gmC2Rcs/cN+1Vch3jEXgc/M0E6zMM5+NqL42ztnSP09qOydeNYYMaxd6rpVg9BeKswxJhgdTpqyr39iEx7cyutDYhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7611
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

no functional changes

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 include/net/tcp.h |  37 +++++++-
 net/net.c         |  11 ++-
 net/tcp.c         | 231 +++++++++++++++++++++++-----------------------
 net/wget.c        |   3 +-
 4 files changed, 163 insertions(+), 119 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index c29d4ce24a7..14aee64cb1c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -277,9 +277,40 @@ enum tcp_state {
 	TCP_FIN_WAIT_2
 };
 
-enum tcp_state tcp_get_tcp_state(void);
-void tcp_set_tcp_state(enum tcp_state new_state);
-int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
+/**
+ * struct tcp_stream - TCP data stream structure
+ *
+ * @state:		TCP connection state
+ *
+ * @seq_init:		Initial receive sequence number
+ * @ack_edge:		Receive next
+ *
+ * @loc_timestamp:	Local timestamp
+ * @rmt_timestamp:	Remote timestamp
+ *
+ * @lost:		Used for SACK
+ */
+struct tcp_stream {
+	/* TCP connection state */
+	enum tcp_state	state;
+
+	u32		seq_init;
+	u32		ack_edge;
+
+	/* TCP option timestamp */
+	u32		loc_timestamp;
+	u32		rmt_timestamp;
+
+	/* TCP sliding window control used to request re-TX */
+	struct tcp_sack_v lost;
+};
+
+struct tcp_stream *tcp_stream_get(void);
+
+enum tcp_state tcp_get_tcp_state(struct tcp_stream *tcp);
+void tcp_set_tcp_state(struct tcp_stream *tcp, enum tcp_state new_state);
+int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
+		       int sport, int payload_len,
 		       u8 action, u32 tcp_seq_num, u32 tcp_ack_num);
 
 /**
diff --git a/net/net.c b/net/net.c
index f47e9fbe33a..d9e143f0ecc 100644
--- a/net/net.c
+++ b/net/net.c
@@ -420,7 +420,7 @@ int net_init(void)
 		/* Only need to setup buffer pointers once. */
 		first_call = 0;
 		if (IS_ENABLED(CONFIG_PROT_TCP))
-			tcp_set_tcp_state(TCP_CLOSED);
+			tcp_set_tcp_state(tcp_stream_get(), TCP_CLOSED);
 	}
 
 	return net_init_loop();
@@ -924,6 +924,9 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
 	uchar *pkt;
 	int eth_hdr_size;
 	int pkt_hdr_size;
+#if defined(CONFIG_PROT_TCP)
+	struct tcp_stream *tcp;
+#endif
 
 	/* make sure the net_tx_packet is initialized (net_init() was called) */
 	assert(net_tx_packet != NULL);
@@ -950,8 +953,12 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
 		break;
 #if defined(CONFIG_PROT_TCP)
 	case IPPROTO_TCP:
+		tcp = tcp_stream_get();
+		if (tcp == NULL)
+			return -EINVAL;
+
 		pkt_hdr_size = eth_hdr_size
-			+ tcp_set_tcp_header(pkt + eth_hdr_size, dport, sport,
+			+ tcp_set_tcp_header(tcp, pkt + eth_hdr_size, dport, sport,
 					     payload_len, action, tcp_seq_num,
 					     tcp_ack_num);
 		break;
diff --git a/net/tcp.c b/net/tcp.c
index 724536cb352..6646f171b83 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -24,19 +24,8 @@
 #include <net.h>
 #include <net/tcp.h>
 
-/*
- * TCP sliding window  control used by us to request re-TX
- */
-static struct tcp_sack_v tcp_lost;
-
-/* TCP option timestamp */
-static u32 loc_timestamp;
-static u32 rmt_timestamp;
-
-static u32 tcp_seq_init;
-static u32 tcp_ack_edge;
-
 static int tcp_activity_count;
+static struct tcp_stream tcp_stream;
 
 /*
  * TCP lengths are stored as a rounded up number of 32 bit words.
@@ -48,9 +37,6 @@ static int tcp_activity_count;
 #define SHIFT_TO_TCPHDRLEN_FIELD(x) ((x) << 4)
 #define GET_TCP_HDR_LEN_IN_BYTES(x) ((x) >> 2)
 
-/* TCP connection state */
-static enum tcp_state current_tcp_state;
-
 /* Current TCP RX packet handler */
 static rxhand_tcp *tcp_packet_handler;
 
@@ -60,22 +46,30 @@ static inline s32 tcp_seq_cmp(u32 a, u32 b)
 }
 
 /**
- * tcp_get_tcp_state() - get current TCP state
+ * tcp_get_tcp_state() - get TCP stream state
+ * @tcp: tcp stream
  *
- * Return: Current TCP state
+ * Return: TCP stream state
  */
-enum tcp_state tcp_get_tcp_state(void)
+enum tcp_state tcp_get_tcp_state(struct tcp_stream *tcp)
 {
-	return current_tcp_state;
+	return tcp->state;
 }
 
 /**
- * tcp_set_tcp_state() - set current TCP state
+ * tcp_set_tcp_state() - set TCP stream state
+ * @tcp: tcp stream
  * @new_state: new TCP state
  */
-void tcp_set_tcp_state(enum tcp_state new_state)
+void tcp_set_tcp_state(struct tcp_stream *tcp,
+		       enum tcp_state new_state)
 {
-	current_tcp_state = new_state;
+	tcp->state = new_state;
+}
+
+struct tcp_stream *tcp_stream_get(void)
+{
+	return &tcp_stream;
 }
 
 static void dummy_handler(uchar *pkt, u16 dport,
@@ -138,29 +132,30 @@ u16 tcp_set_pseudo_header(uchar *pkt, struct in_addr src, struct in_addr dest,
 
 /**
  * net_set_ack_options() - set TCP options in acknowledge packets
+ * @tcp: tcp stream
  * @b: the packet
  *
  * Return: TCP header length
  */
-int net_set_ack_options(union tcp_build_pkt *b)
+int net_set_ack_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
 {
 	b->sack.hdr.tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(LEN_B_TO_DW(TCP_HDR_SIZE));
 
 	b->sack.t_opt.kind = TCP_O_TS;
 	b->sack.t_opt.len = TCP_OPT_LEN_A;
-	b->sack.t_opt.t_snd = htons(loc_timestamp);
-	b->sack.t_opt.t_rcv = rmt_timestamp;
+	b->sack.t_opt.t_snd = htons(tcp->loc_timestamp);
+	b->sack.t_opt.t_rcv = tcp->rmt_timestamp;
 	b->sack.sack_v.kind = TCP_1_NOP;
 	b->sack.sack_v.len = 0;
 
 	if (IS_ENABLED(CONFIG_PROT_TCP_SACK)) {
-		if (tcp_lost.len > TCP_OPT_LEN_2) {
+		if (tcp->lost.len > TCP_OPT_LEN_2) {
 			debug_cond(DEBUG_DEV_PKT, "TCP ack opt lost.len %x\n",
-				   tcp_lost.len);
-			b->sack.sack_v.len = tcp_lost.len;
+				   tcp->lost.len);
+			b->sack.sack_v.len = tcp->lost.len;
 			b->sack.sack_v.kind = TCP_V_SACK;
-			b->sack.sack_v.hill[0].l = htonl(tcp_lost.hill[0].l);
-			b->sack.sack_v.hill[0].r = htonl(tcp_lost.hill[0].r);
+			b->sack.sack_v.hill[0].l = htonl(tcp->lost.hill[0].l);
+			b->sack.sack_v.hill[0].r = htonl(tcp->lost.hill[0].r);
 
 			/*
 			 * These SACK structures are initialized with NOPs to
@@ -168,17 +163,17 @@ int net_set_ack_options(union tcp_build_pkt *b)
 			 * SACK structures used for both header padding and
 			 * internally.
 			 */
-			b->sack.sack_v.hill[1].l = htonl(tcp_lost.hill[1].l);
-			b->sack.sack_v.hill[1].r = htonl(tcp_lost.hill[1].r);
-			b->sack.sack_v.hill[2].l = htonl(tcp_lost.hill[2].l);
-			b->sack.sack_v.hill[2].r = htonl(tcp_lost.hill[2].r);
+			b->sack.sack_v.hill[1].l = htonl(tcp->lost.hill[1].l);
+			b->sack.sack_v.hill[1].r = htonl(tcp->lost.hill[1].r);
+			b->sack.sack_v.hill[2].l = htonl(tcp->lost.hill[2].l);
+			b->sack.sack_v.hill[2].r = htonl(tcp->lost.hill[2].r);
 			b->sack.sack_v.hill[3].l = TCP_O_NOP;
 			b->sack.sack_v.hill[3].r = TCP_O_NOP;
 		}
 
 		b->sack.hdr.tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(ROUND_TCPHDR_LEN(TCP_HDR_SIZE +
 										 TCP_TSOPT_SIZE +
-										 tcp_lost.len));
+										 tcp->lost.len));
 	} else {
 		b->sack.sack_v.kind = 0;
 		b->sack.hdr.tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(ROUND_TCPHDR_LEN(TCP_HDR_SIZE +
@@ -194,13 +189,14 @@ int net_set_ack_options(union tcp_build_pkt *b)
 }
 
 /**
- * net_set_ack_options() - set TCP options in SYN packets
+ * net_set_syn_options() - set TCP options in SYN packets
+ * @tcp: tcp stream
  * @b: the packet
  */
-void net_set_syn_options(union tcp_build_pkt *b)
+void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
 {
 	if (IS_ENABLED(CONFIG_PROT_TCP_SACK))
-		tcp_lost.len = 0;
+		tcp->lost.len = 0;
 
 	b->ip.hdr.tcp_hlen = 0xa0;
 
@@ -219,14 +215,15 @@ void net_set_syn_options(union tcp_build_pkt *b)
 	}
 	b->ip.t_opt.kind = TCP_O_TS;
 	b->ip.t_opt.len = TCP_OPT_LEN_A;
-	loc_timestamp = get_ticks();
-	rmt_timestamp = 0;
+	tcp->loc_timestamp = get_ticks();
+	tcp->rmt_timestamp = 0;
 	b->ip.t_opt.t_snd = 0;
 	b->ip.t_opt.t_rcv = 0;
 	b->ip.end = TCP_O_END;
 }
 
-int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
+int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
+		       int sport, int payload_len,
 		       u8 action, u32 tcp_seq_num, u32 tcp_ack_num)
 {
 	union tcp_build_pkt *b = (union tcp_build_pkt *)pkt;
@@ -249,21 +246,21 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 			   &net_server_ip, &net_ip,
 			   tcp_seq_num, tcp_ack_num);
 		tcp_activity_count = 0;
-		net_set_syn_options(b);
+		net_set_syn_options(tcp, b);
 		tcp_seq_num = 0;
 		tcp_ack_num = 0;
 		pkt_hdr_len = IP_TCP_O_SIZE;
-		if (current_tcp_state == TCP_SYN_SENT) {  /* Too many SYNs */
+		if (tcp->state == TCP_SYN_SENT) {  /* Too many SYNs */
 			action = TCP_FIN;
-			current_tcp_state = TCP_FIN_WAIT_1;
+			tcp->state = TCP_FIN_WAIT_1;
 		} else {
-			tcp_lost.len = TCP_OPT_LEN_2;
-			current_tcp_state = TCP_SYN_SENT;
+			tcp->lost.len = TCP_OPT_LEN_2;
+			tcp->state = TCP_SYN_SENT;
 		}
 		break;
 	case TCP_SYN | TCP_ACK:
 	case TCP_ACK:
-		pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(b);
+		pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
 		b->ip.hdr.tcp_flags = action;
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:ACK (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
@@ -276,20 +273,20 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 			   &net_server_ip, &net_ip, tcp_seq_num, tcp_ack_num);
 		payload_len = 0;
 		pkt_hdr_len = IP_TCP_HDR_SIZE;
-		current_tcp_state = TCP_FIN_WAIT_1;
+		tcp->state = TCP_FIN_WAIT_1;
 		break;
 	case TCP_RST | TCP_ACK:
 	case TCP_RST:
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:RST  (%pI4, %pI4, s=%u, a=%u)\n",
 			   &net_server_ip, &net_ip, tcp_seq_num, tcp_ack_num);
-		current_tcp_state = TCP_CLOSED;
+		tcp->state = TCP_CLOSED;
 		break;
 	/* Notify connection closing */
 	case (TCP_FIN | TCP_ACK):
 	case (TCP_FIN | TCP_ACK | TCP_PUSH):
-		if (current_tcp_state == TCP_CLOSE_WAIT)
-			current_tcp_state = TCP_CLOSING;
+		if (tcp->state == TCP_CLOSE_WAIT)
+			tcp->state = TCP_CLOSING;
 
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:FIN ACK PSH(%pI4, %pI4, s=%u, a=%u, A=%x)\n",
@@ -297,7 +294,7 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 			   tcp_seq_num, tcp_ack_num, action);
 		fallthrough;
 	default:
-		pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(b);
+		pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
 		b->ip.hdr.tcp_flags = action | TCP_PUSH | TCP_ACK;
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:dft  (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
@@ -308,9 +305,9 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 	pkt_len	= pkt_hdr_len + payload_len;
 	tcp_len	= pkt_len - IP_HDR_SIZE;
 
-	tcp_ack_edge = tcp_ack_num;
+	tcp->ack_edge = tcp_ack_num;
 	/* TCP Header */
-	b->ip.hdr.tcp_ack = htonl(tcp_ack_edge);
+	b->ip.hdr.tcp_ack = htonl(tcp->ack_edge);
 	b->ip.hdr.tcp_src = htons(sport);
 	b->ip.hdr.tcp_dst = htons(dport);
 	b->ip.hdr.tcp_seq = htonl(tcp_seq_num);
@@ -344,78 +341,79 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 	return pkt_hdr_len;
 }
 
-static void tcp_update_ack_edge(void)
+static void tcp_update_ack_edge(struct tcp_stream *tcp)
 {
-	if (tcp_seq_cmp(tcp_ack_edge, tcp_lost.hill[0].l) >= 0) {
-		tcp_ack_edge = tcp_lost.hill[0].r;
+	if (tcp_seq_cmp(tcp->ack_edge, tcp->lost.hill[0].l) >= 0) {
+		tcp->ack_edge = tcp->lost.hill[0].r;
 
-		memmove(&tcp_lost.hill[0], &tcp_lost.hill[1],
+		memmove(&tcp->lost.hill[0], &tcp->lost.hill[1],
 			(TCP_SACK_HILLS - 1) * sizeof(struct sack_edges));
 
-		tcp_lost.len -= TCP_OPT_LEN_8;
-		tcp_lost.hill[TCP_SACK_HILLS - 1].l = TCP_O_NOP;
-		tcp_lost.hill[TCP_SACK_HILLS - 1].r = TCP_O_NOP;
+		tcp->lost.len -= TCP_OPT_LEN_8;
+		tcp->lost.hill[TCP_SACK_HILLS - 1].l = TCP_O_NOP;
+		tcp->lost.hill[TCP_SACK_HILLS - 1].r = TCP_O_NOP;
 	}
 }
 
 /**
  * tcp_hole() - Selective Acknowledgment (Essential for fast stream transfer)
+ * @tcp: tcp stream
  * @tcp_seq_num: TCP sequence start number
  * @len: the length of sequence numbers
  */
-void tcp_hole(u32 tcp_seq_num, u32 len)
+void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
 {
 	int i, j, cnt, cnt_move;
 
-	cnt = (tcp_lost.len - TCP_OPT_LEN_2) / TCP_OPT_LEN_8;
+	cnt = (tcp->lost.len - TCP_OPT_LEN_2) / TCP_OPT_LEN_8;
 	for (i = 0; i < cnt; i++) {
-		if (tcp_seq_cmp(tcp_lost.hill[i].r, tcp_seq_num) < 0)
+		if (tcp_seq_cmp(tcp->lost.hill[i].r, tcp_seq_num) < 0)
 			continue;
-		if (tcp_seq_cmp(tcp_lost.hill[i].l, tcp_seq_num + len) > 0)
+		if (tcp_seq_cmp(tcp->lost.hill[i].l, tcp_seq_num + len) > 0)
 			break;
 
-		if (tcp_seq_cmp(tcp_lost.hill[i].l, tcp_seq_num) > 0)
-			tcp_lost.hill[i].l = tcp_seq_num;
-		if (tcp_seq_cmp(tcp_lost.hill[i].l, tcp_seq_num) < 0) {
-			len += tcp_seq_num - tcp_lost.hill[i].l;
-			tcp_seq_num = tcp_lost.hill[i].l;
+		if (tcp_seq_cmp(tcp->lost.hill[i].l, tcp_seq_num) > 0)
+			tcp->lost.hill[i].l = tcp_seq_num;
+		if (tcp_seq_cmp(tcp->lost.hill[i].l, tcp_seq_num) < 0) {
+			len += tcp_seq_num - tcp->lost.hill[i].l;
+			tcp_seq_num = tcp->lost.hill[i].l;
 		}
-		if (tcp_seq_cmp(tcp_lost.hill[i].r, tcp_seq_num + len) >= 0) {
-			tcp_update_ack_edge();
+		if (tcp_seq_cmp(tcp->lost.hill[i].r, tcp_seq_num + len) >= 0) {
+			tcp_update_ack_edge(tcp);
 			return;
 		}
 
 		/* check overlapping with next hills */
 		cnt_move = 0;
-		tcp_lost.hill[i].r = tcp_seq_num + len;
+		tcp->lost.hill[i].r = tcp_seq_num + len;
 		for (j = i + 1; j < cnt; j++) {
-			if (tcp_seq_cmp(tcp_lost.hill[j].l, tcp_lost.hill[i].r) > 0)
+			if (tcp_seq_cmp(tcp->lost.hill[j].l, tcp->lost.hill[i].r) > 0)
 				break;
 
-			tcp_lost.hill[i].r = tcp_lost.hill[j].r;
+			tcp->lost.hill[i].r = tcp->lost.hill[j].r;
 			cnt_move++;
 		}
 
 		if (cnt_move > 0) {
 			if (cnt > i + cnt_move + 1)
-				memmove(&tcp_lost.hill[i + 1],
-					&tcp_lost.hill[i + cnt_move + 1],
+				memmove(&tcp->lost.hill[i + 1],
+					&tcp->lost.hill[i + cnt_move + 1],
 					cnt_move * sizeof(struct sack_edges));
 
 			cnt -= cnt_move;
-			tcp_lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
+			tcp->lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
 			for (j = cnt; j < TCP_SACK_HILLS; j++) {
-				tcp_lost.hill[j].l = TCP_O_NOP;
-				tcp_lost.hill[j].r = TCP_O_NOP;
+				tcp->lost.hill[j].l = TCP_O_NOP;
+				tcp->lost.hill[j].r = TCP_O_NOP;
 			}
 		}
 
-		tcp_update_ack_edge();
+		tcp_update_ack_edge(tcp);
 		return;
 	}
 
 	if (i == TCP_SACK_HILLS) {
-		tcp_update_ack_edge();
+		tcp_update_ack_edge(tcp);
 		return;
 	}
 
@@ -428,23 +426,24 @@ void tcp_hole(u32 tcp_seq_num, u32 len)
 	}
 
 	if (cnt_move > 0)
-		memmove(&tcp_lost.hill[i + 1],
-			&tcp_lost.hill[i],
+		memmove(&tcp->lost.hill[i + 1],
+			&tcp->lost.hill[i],
 			cnt_move * sizeof(struct sack_edges));
 
-	tcp_lost.hill[i].l = tcp_seq_num;
-	tcp_lost.hill[i].r = tcp_seq_num + len;
-	tcp_lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
+	tcp->lost.hill[i].l = tcp_seq_num;
+	tcp->lost.hill[i].r = tcp_seq_num + len;
+	tcp->lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
 
-	tcp_update_ack_edge();
+	tcp_update_ack_edge(tcp);
 };
 
 /**
  * tcp_parse_options() - parsing TCP options
+ * @tcp: tcp stream
  * @o: pointer to the option field.
  * @o_len: length of the option field.
  */
-void tcp_parse_options(uchar *o, int o_len)
+void tcp_parse_options(struct tcp_stream *tcp, uchar *o, int o_len)
 {
 	struct tcp_t_opt  *tsopt;
 	uchar *p = o;
@@ -467,7 +466,7 @@ void tcp_parse_options(uchar *o, int o_len)
 			break;
 		case TCP_O_TS:
 			tsopt = (struct tcp_t_opt *)p;
-			rmt_timestamp = tsopt->t_snd;
+			tcp->rmt_timestamp = tsopt->t_snd;
 			break;
 		}
 
@@ -479,7 +478,8 @@ void tcp_parse_options(uchar *o, int o_len)
 	}
 }
 
-static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
+static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
+			    u32 tcp_seq_num, int payload_len)
 {
 	u8 tcp_fin = tcp_flags & TCP_FIN;
 	u8 tcp_syn = tcp_flags & TCP_SYN;
@@ -500,21 +500,21 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 	debug_cond(DEBUG_INT_STATE, "TCP STATE ENTRY %x\n", action);
 	if (tcp_rst) {
 		action = TCP_DATA;
-		current_tcp_state = TCP_CLOSED;
+		tcp->state = TCP_CLOSED;
 		net_set_state(NETLOOP_FAIL);
 		debug_cond(DEBUG_INT_STATE, "TCP Reset %x\n", tcp_flags);
 		return TCP_RST;
 	}
 
-	switch  (current_tcp_state) {
+	switch  (tcp->state) {
 	case TCP_CLOSED:
 		debug_cond(DEBUG_INT_STATE, "TCP CLOSED %x\n", tcp_flags);
 		if (tcp_syn) {
 			action = TCP_SYN | TCP_ACK;
-			tcp_seq_init = tcp_seq_num;
-			tcp_ack_edge = tcp_seq_num + 1;
-			tcp_lost.len = TCP_OPT_LEN_2;
-			current_tcp_state = TCP_SYN_RECEIVED;
+			tcp->seq_init = tcp_seq_num;
+			tcp->ack_edge = tcp_seq_num + 1;
+			tcp->lost.len = TCP_OPT_LEN_2;
+			tcp->state = TCP_SYN_RECEIVED;
 		} else if (tcp_ack || tcp_fin) {
 			action = TCP_DATA;
 		}
@@ -525,12 +525,12 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 			   tcp_flags, tcp_seq_num);
 		if (tcp_fin) {
 			action = action | TCP_PUSH;
-			current_tcp_state = TCP_CLOSE_WAIT;
+			tcp->state = TCP_CLOSE_WAIT;
 		} else if (tcp_ack || (tcp_syn && tcp_ack)) {
 			action |= TCP_ACK;
-			tcp_seq_init = tcp_seq_num;
-			tcp_ack_edge = tcp_seq_num + 1;
-			current_tcp_state = TCP_ESTABLISHED;
+			tcp->seq_init = tcp_seq_num;
+			tcp->ack_edge = tcp_seq_num + 1;
+			tcp->state = TCP_ESTABLISHED;
 
 			if (tcp_syn && tcp_ack)
 				action |= TCP_PUSH;
@@ -541,15 +541,15 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 	case TCP_ESTABLISHED:
 		debug_cond(DEBUG_INT_STATE, "TCP_ESTABLISHED %x\n", tcp_flags);
 		if (payload_len > 0) {
-			tcp_hole(tcp_seq_num, payload_len);
+			tcp_hole(tcp, tcp_seq_num, payload_len);
 			tcp_fin = TCP_DATA;  /* cause standalone FIN */
 		}
 
 		if ((tcp_fin) &&
 		    (!IS_ENABLED(CONFIG_PROT_TCP_SACK) ||
-		     tcp_lost.len <= TCP_OPT_LEN_2)) {
+		     tcp->lost.len <= TCP_OPT_LEN_2)) {
 			action = action | TCP_FIN | TCP_PUSH | TCP_ACK;
-			current_tcp_state = TCP_CLOSE_WAIT;
+			tcp->state = TCP_CLOSE_WAIT;
 		} else if (tcp_ack) {
 			action = TCP_DATA;
 		}
@@ -567,7 +567,7 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 		debug_cond(DEBUG_INT_STATE, "TCP_FIN_WAIT_2 (%x)\n", tcp_flags);
 		if (tcp_ack) {
 			action = TCP_PUSH | TCP_ACK;
-			current_tcp_state = TCP_CLOSED;
+			tcp->state = TCP_CLOSED;
 			puts("\n");
 		} else if (tcp_syn) {
 			action = TCP_DATA;
@@ -578,20 +578,20 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 	case TCP_FIN_WAIT_1:
 		debug_cond(DEBUG_INT_STATE, "TCP_FIN_WAIT_1 (%x)\n", tcp_flags);
 		if (tcp_fin) {
-			tcp_ack_edge++;
+			tcp->ack_edge++;
 			action = TCP_ACK | TCP_FIN;
-			current_tcp_state = TCP_FIN_WAIT_2;
+			tcp->state = TCP_FIN_WAIT_2;
 		}
 		if (tcp_syn)
 			action = TCP_RST;
 		if (tcp_ack)
-			current_tcp_state = TCP_CLOSED;
+			tcp->state = TCP_CLOSED;
 		break;
 	case TCP_CLOSING:
 		debug_cond(DEBUG_INT_STATE, "TCP_CLOSING (%x)\n", tcp_flags);
 		if (tcp_ack) {
 			action = TCP_PUSH;
-			current_tcp_state = TCP_CLOSED;
+			tcp->state = TCP_CLOSED;
 			puts("\n");
 		} else if (tcp_syn) {
 			action = TCP_RST;
@@ -615,6 +615,7 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 	u8  tcp_action = TCP_DATA;
 	u32 tcp_seq_num, tcp_ack_num;
 	int tcp_hdr_len, payload_len;
+	struct tcp_stream *tcp;
 
 	/* Verify IP header */
 	debug_cond(DEBUG_DEV_PKT,
@@ -643,11 +644,15 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 		return;
 	}
 
+	tcp = tcp_stream_get();
+	if (tcp == NULL)
+		return;
+
 	tcp_hdr_len = GET_TCP_HDR_LEN_IN_BYTES(b->ip.hdr.tcp_hlen);
 	payload_len = tcp_len - tcp_hdr_len;
 
 	if (tcp_hdr_len > TCP_HDR_SIZE)
-		tcp_parse_options((uchar *)b + IP_TCP_HDR_SIZE,
+		tcp_parse_options(tcp, (uchar *)b + IP_TCP_HDR_SIZE,
 				  tcp_hdr_len - TCP_HDR_SIZE);
 	/*
 	 * Incoming sequence and ack numbers are server's view of the numbers.
@@ -657,7 +662,7 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 	tcp_ack_num = ntohl(b->ip.hdr.tcp_ack);
 
 	/* Packets are not ordered. Send to app as received. */
-	tcp_action = tcp_state_machine(b->ip.hdr.tcp_flags,
+	tcp_action = tcp_state_machine(tcp, b->ip.hdr.tcp_flags,
 				       tcp_seq_num, payload_len);
 
 	tcp_activity_count++;
@@ -678,7 +683,7 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 	} else if (tcp_action != TCP_DATA) {
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Action (action=%x,Seq=%u,Ack=%u,Pay=%d)\n",
-			   tcp_action, tcp_ack_num, tcp_ack_edge, payload_len);
+			   tcp_action, tcp_ack_num, tcp->ack_edge, payload_len);
 
 		/*
 		 * Warning: Incoming Ack & Seq sequence numbers are transposed
@@ -687,6 +692,6 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 		net_send_tcp_packet(0, ntohs(b->ip.hdr.tcp_src),
 				    ntohs(b->ip.hdr.tcp_dst),
 				    (tcp_action & (~TCP_PUSH)),
-				    tcp_ack_num, tcp_ack_edge);
+				    tcp_ack_num, tcp->ack_edge);
 	}
 }
diff --git a/net/wget.c b/net/wget.c
index 361817ace65..07992613c91 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -304,7 +304,8 @@ static void wget_handler(uchar *pkt, u16 dport,
 			 u32 tcp_seq_num, u32 tcp_ack_num,
 			 u8 action, unsigned int len)
 {
-	enum tcp_state wget_tcp_state = tcp_get_tcp_state();
+	struct tcp_stream *tcp = tcp_stream_get();
+	enum tcp_state wget_tcp_state = tcp_get_tcp_state(tcp);
 
 	net_set_timeout_handler(wget_timeout, wget_timeout_handler);
 	packets++;
-- 
2.45.2

