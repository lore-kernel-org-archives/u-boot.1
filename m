Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD793ECE589
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:27:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9211C88E83;
	Tue, 10 Sep 2024 00:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="EhPD52/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECD7188A2D; Tue, 10 Sep 2024 00:27:38 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5E5E889F8
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kw7Cvm6crZrbHmmQYONJLkuxGlhiGA50I7K1xTqG+vJbpImzGhGUNz01FcHK9SRM60kafdsPwnmkaD6XXDRd86ZhMELMCGHX9fHnov3AimlxG8Yokdd1muStlXoLMvGUGznlXPs4pqRPWrb0/EOl05KcaxHfyW5guWVjXXjRygNxiQ7/GnyiLGjeut9SBRCnt5TAOgmusCpJIiKia+nCLCUNH9Xvvs48+QGZe9oAg+T+OudKJoCowCkTCHsECwDD7VWLCM72w+zJJ1D+4uWp3zp5jBR6Vzzu1SmD2KUB46r5WOD+XXfSjWF+d4b5vLlaIBYHtIQBTdZhptRBoaUOoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=mN4sPuWWcIgiaz5DlxwVLAEmH7CXXpY/oeR2O27NDXUP5gg8o5crPX4R8Xnoevbi+Bn6OaNCU74j04e/4PviQ2z1aKfFQMKLuem08TEXCLBPqFkSaH8E02SlyeJ+Av4iT87IDyQXN7buyaX6EcFvz4IjGZK1Pyxw+DJ9evdxIAI9gXYu8egEC1fDkPSidDcFi1+MWt2q3pnsVTcCjwnAmNLrYETt93V6evB0EuOCUU4ebl7fqyFs3AYroixFHMZ9bpElffVInMkHoXqGiAjvHzr4Pro/e7F0p7SV+BnW0Sw+RFaAlh7xVVYJ0IgafhZophpPE/aA+VS0a2NaOIZgSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=EhPD52/sH9y7Zgu6FezF4Wu+/v6oMO7wgK14+ns5163TBi8HmQwke1Ivp2+ERyZa00dDT5Q18E/wcaijjh32udIk02U2DeoktGLAPUPItpe8JrO1TL5ms1D/85eykgM9N2IAFs/MzfhEovd9aUMYCL6N+3809bIRPMVjxce+wYmw0V13TYJsc3KZnhDuJm22d//oewO5Ze0D5Qwx67wrCniP+pOLNem72Do40wmq2Soo1q1F0pVhcf4VfFE9CG9DdsKGYsPvT1CB8DvBzIbWhWBipa+4ki47wnbslLJOM/JywYRDXiWa7BS4FosofrH9COUjZIYxOps02UAGdm+99A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8722.eurprd08.prod.outlook.com (2603:10a6:10:3d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:27:31 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:27:31 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH v6 02/12] net/tcp: fix selective acknowledge
Date: Tue, 10 Sep 2024 01:27:10 +0300
Message-ID: <20240909222720.2563118-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: c04f8b80-92c3-48da-d2b2-08dcd11e984a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lEB3jn7Vb2rXNPO1iXb2VDsSeZzzNbV+FL6sHxLqSN3tfOrRlTkRCdRNwqmM?=
 =?us-ascii?Q?BAW0fBorZ4glBuj9neiapcxqdVJ7Z9xBDcuV+QYjm/3zLdLJBp1WDi0G2HDh?=
 =?us-ascii?Q?bGO8aZVthCkYZfmnZBcizHiPCfGBltII/EajCaX9oYEEcCqXkdgtcdIM3pDT?=
 =?us-ascii?Q?8YJicEZGFcIXrc76m5YYmKYwW5E44//x4SKyXK6ahmSFjC8F72RBqz6QuZr6?=
 =?us-ascii?Q?CVQHOK0dAyd9iNf6s10tQ1fQzDXCGwwKzRp8BNX2QqCu0zGZvV81V9//mMyc?=
 =?us-ascii?Q?BDRLXEGRbEhUiGbLAJzQapyGNRz2AkQipya9dR0ncNrcFJxZ1dE/AXgI5U9D?=
 =?us-ascii?Q?FMuyKUi6E5+GWHCPiHYOvVJxAuQc0v5HJ7kotTb4McNVQpPLjZMU0RHuxtaa?=
 =?us-ascii?Q?xNVHYuLoZM8nn8PVEP1P+zQkjkUxFm2eIfuj+ZVtcYeMiCstNo/WnAHooj1o?=
 =?us-ascii?Q?p7ekKEUjWDPS0iieGiO8NdJJpTW1W//u6UUPFZgdnSXe5ZlUcGL795MQ4Fyp?=
 =?us-ascii?Q?bduWItysBuD574Pfkc3P0RQcG8NvkZxeQTcLKaNx5grEKpLP18p+QEQhL1AP?=
 =?us-ascii?Q?koy6xluR5Z9nCFzHSZz2YmYBGukblcegr/XZ+gsJpQcMiU1bPUJUXnR5sLgX?=
 =?us-ascii?Q?rQgxKYrCMpB+a920FQMaV0pub0DjbprrDHITpRC4dSDyDTfH2R69Bno5ww6z?=
 =?us-ascii?Q?p6cbrZU2d/sd0kAfq4rj7Q1ToO7Q8FQ6/yhfmn1OUt9UFeBRshU+vQkTW8Q1?=
 =?us-ascii?Q?7gwbZtrRtN1X1Im0GOBDrSh01ihxP4EKVn+qrikV3DnbCes9lN0sgQPVlpwU?=
 =?us-ascii?Q?zstFfR+sTIxPf9+9ZxPNwRxNlqiEyNDJmC21uoBWp8yuQTroHrbcz5VYftxB?=
 =?us-ascii?Q?3JLVRfKdAS8IJ+GvaC/PQNWOn0X/0gVL5z1YwkkS4LO0IQ/e/yWuzPY6ETtC?=
 =?us-ascii?Q?nOkHpNaJQ9wFsEfOJ3AQVTR6EpeqymSodKNHZFW/QGBXbCqUFNVYtfDoje8H?=
 =?us-ascii?Q?aV24vYhAzIySXom3RMFj2Hhb4AA/sITzXiGe/ha4YLJlufHIlRxhMeyGHuDv?=
 =?us-ascii?Q?kbbk6n4sMQ58j98fcZW2RI5by4eKkgFYfG/VuRnns59SDsUp7XsN2brLxD+D?=
 =?us-ascii?Q?Gmxglu0PRUl30m1v4CWj8c1n0RBMY4D2vODWFLru9VaNiYcXGcVD7IsobUYK?=
 =?us-ascii?Q?jKuoGnrTN4jUlaVmwaEePJwcjY5Vd+YUflk4c8W8OG1bnEzRg7/uTWYD9LHE?=
 =?us-ascii?Q?EdwEplxlaqjj+UauQrY1lreXvGYely5OyQRsJ9neQBUBc4hi4Q5bB8T/vJc6?=
 =?us-ascii?Q?vOOrmvyF2zOv6RfPKVCwl5qHVWO6Lzy5ogyPclK97dsXMV6U8Mcxv6a3/Npy?=
 =?us-ascii?Q?yzPeEWAdZHkUQfKF1KtZxpqoYhnSqhreB8KZKZi1f0nSP+im2CywQJ6xCUTl?=
 =?us-ascii?Q?CMDhlCh+swA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qcUBUpdXNIEnUm5KIO+DAVYr1vWoXsT3wxuxN2BD5dwMGkCWxEpjdBjmLZI7?=
 =?us-ascii?Q?LpV2CY0rjpesnLAzP2z/whlAO04wF3lm1oTxHMSMT+P+HXIU3Rvoy1/PZOoG?=
 =?us-ascii?Q?QPOZtms6Dyu3+l7WC+2RWrd2Mc9mrz8T7Ld/ZKQinTV8bffnwzcWeyAlilrM?=
 =?us-ascii?Q?PBdksU/zIfQWzWhp3ybByqMCRwEah5q/H5sLAkDi/KRjAnRNjtOAUH/RnMSj?=
 =?us-ascii?Q?9W6xsLFcRgYXWGZPynvU6Y2aeTUGAY3qKV0KRgik15XdUyidCXkjJ3QY71GW?=
 =?us-ascii?Q?9iXng7GCFO07Cb0vHcVp1Vbn6JQBlBitSIk1Fwj90J69ZhioXF0TFqmAxxLV?=
 =?us-ascii?Q?VG5YjdA7tsv3xjvdWJ6o4Maqn4Cgn5KVA9bK1uYqlPgSv8IE5hZvdFHUtQ2E?=
 =?us-ascii?Q?lDRn/0jOH3jX2tozzzlHRTVdH4wjBnzKBc36s4FrdLnqSZsmNqtWpnqEj6tP?=
 =?us-ascii?Q?r8cCiGhXwUkqkb8W8jY7W1gm6AnODzVlAusp47Lev4cteWEsu3Ns6yMuI/zt?=
 =?us-ascii?Q?icRo7igpRI5xT0FgxndszKZaEhOaUkyzxE0oKW38uaLV0JC++khBVYaRhHNA?=
 =?us-ascii?Q?7NxNRqYqZmBxr3hNgvsCN9Gf0mjW5JG16wfaNjlGZS3S9iLk7M5fD/jxlw7r?=
 =?us-ascii?Q?ebG05gC4KVoR9qq2V5vTEAAak7ZrfP54khUAl7AFM0F2YewpeWDM13SbE9ah?=
 =?us-ascii?Q?xt7Lvudu9OSElEsVofCZS7DoBMWxUbGEKWaX5BsC5CoN4rOnp3AQk4uRoQsz?=
 =?us-ascii?Q?fbDVqFRJN2J8aYbDKTDYR8ebCswxgKSRmmdXA6LqtzS4ZMyk39Ju69Yu5PyX?=
 =?us-ascii?Q?iULBhmI5YAW1xX6CdTQwmRCo6sPF513a2Ey8QJ46MuODoMY2IE1l7xEV9Knx?=
 =?us-ascii?Q?Cp2lmC9YwrVuHIhB6O0V52NbpdwTeJDJteEuznaCCEBQLXFoTwjp/VE1BI9o?=
 =?us-ascii?Q?4wT4iyKtKEqfdmB+ZeTbui89cwXMplzLrTOsACO+KF67Le827lda9mQ1wSGw?=
 =?us-ascii?Q?TfWjHWwW7VhgvEVcAGpchYkpLR8MI1IhJvS7Ay53trqHUda5fKVCehdYL+Q6?=
 =?us-ascii?Q?bFUucTfLLptUa0zR81yFZIc45yuhmT9XckuX2D1Ivm8br3D1gIRbPHzgcu3K?=
 =?us-ascii?Q?Ch8gHejaomTXTnGIxyUVv42r1iErst2NCyDO4S7q2Z8YiQx5Ol9LWl5Xzof+?=
 =?us-ascii?Q?ssqWx9gX+xiKgHC9x8x6WkT5i+WuIYXCc+3AKJFJ5AhcxmjsvEnfc/q9tyVX?=
 =?us-ascii?Q?puKT7vIVzOUxub0s5sXiuSdwq4BE91wC25k1utgd1rxog5lSWoFy1rMMjRqs?=
 =?us-ascii?Q?PQzLUpeM20hotcOKklTpFxbdJjpm82g37zOiFptmlVNYMRRyz0foG7DBFTrr?=
 =?us-ascii?Q?3BjA8T9zXAMMXCDk2hGi7mhzvRLSGbzY3NlULgVhWLXkxR1QA6ABcWdocODM?=
 =?us-ascii?Q?eqn3pEhMcDqHQ6kq7w4wRXA3rhur+9QrFQidk9UDTbP9Xpg5A6/LAkHwwgO4?=
 =?us-ascii?Q?xyw3F8FvvGQne4oYHrGoxyomJx+viN8UMkP/5tTDMVZSbGTVsSxXCsWtlrMh?=
 =?us-ascii?Q?8KbnhonOADifaz3ONuuGCp2wyuZN7V6nJuURjLvMRtQzbXwMdFjLUeT7C/dO?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c04f8b80-92c3-48da-d2b2-08dcd11e984a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:27:31.5330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZB9N2gvi0G5F1M8B0m6GtFvLG7p7kvwUk7ew2lpFl8QzKinv0CLtyljXbAS5bi/Ts15/M0yiXsvCKtH9/NQIVrksevJew01q6Ea9M+H+sI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8722
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

Current code assume that all (except last) packets are of the same size.
This is definitely wrong. Replace SACK code with a new one, that does
not rely on this assumption. Also this code uses less memory.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 200 +++++++++++++++++++++++-------------------------------
 1 file changed, 86 insertions(+), 114 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index 3e3118de450..724536cb352 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -38,21 +38,6 @@ static u32 tcp_ack_edge;
 
 static int tcp_activity_count;
 
-/*
- * Search for TCP_SACK and review the comments before the code section
- * TCP_SACK is the number of packets at the front of the stream
- */
-
-enum pkt_state {PKT, NOPKT};
-struct sack_r {
-	struct sack_edges se;
-	enum pkt_state st;
-};
-
-static struct sack_r edge_a[TCP_SACK];
-static unsigned int sack_idx;
-static unsigned int prev_len;
-
 /*
  * TCP lengths are stored as a rounded up number of 32 bit words.
  * Add 3 to length round up, rounded, then divided into the
@@ -69,6 +54,11 @@ static enum tcp_state current_tcp_state;
 /* Current TCP RX packet handler */
 static rxhand_tcp *tcp_packet_handler;
 
+static inline s32 tcp_seq_cmp(u32 a, u32 b)
+{
+	return (s32)(a - b);
+}
+
 /**
  * tcp_get_tcp_state() - get current TCP state
  *
@@ -267,6 +257,7 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 			action = TCP_FIN;
 			current_tcp_state = TCP_FIN_WAIT_1;
 		} else {
+			tcp_lost.len = TCP_OPT_LEN_2;
 			current_tcp_state = TCP_SYN_SENT;
 		}
 		break;
@@ -353,6 +344,20 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 	return pkt_hdr_len;
 }
 
+static void tcp_update_ack_edge(void)
+{
+	if (tcp_seq_cmp(tcp_ack_edge, tcp_lost.hill[0].l) >= 0) {
+		tcp_ack_edge = tcp_lost.hill[0].r;
+
+		memmove(&tcp_lost.hill[0], &tcp_lost.hill[1],
+			(TCP_SACK_HILLS - 1) * sizeof(struct sack_edges));
+
+		tcp_lost.len -= TCP_OPT_LEN_8;
+		tcp_lost.hill[TCP_SACK_HILLS - 1].l = TCP_O_NOP;
+		tcp_lost.hill[TCP_SACK_HILLS - 1].r = TCP_O_NOP;
+	}
+}
+
 /**
  * tcp_hole() - Selective Acknowledgment (Essential for fast stream transfer)
  * @tcp_seq_num: TCP sequence start number
@@ -360,106 +365,79 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
  */
 void tcp_hole(u32 tcp_seq_num, u32 len)
 {
-	u32 idx_sack, sack_in;
-	u32 sack_end = TCP_SACK - 1;
-	u32 hill = 0;
-	enum pkt_state expect = PKT;
-	u32 seq = tcp_seq_num - tcp_seq_init;
-	u32 hol_l = tcp_ack_edge - tcp_seq_init;
-	u32 hol_r = 0;
-
-	/* Place new seq number in correct place in receive array */
-	if (prev_len == 0)
-		prev_len = len;
-
-	idx_sack = sack_idx + ((tcp_seq_num - tcp_ack_edge) / prev_len);
-	if (idx_sack < TCP_SACK) {
-		edge_a[idx_sack].se.l = tcp_seq_num;
-		edge_a[idx_sack].se.r = tcp_seq_num + len;
-		edge_a[idx_sack].st = PKT;
+	int i, j, cnt, cnt_move;
 
-		/*
-		 * The fin (last) packet is not the same length as data
-		 * packets, and if it's length is recorded and used for
-		 *  array index calculation, calculation breaks.
-		 */
-		if (prev_len < len)
-			prev_len = len;
-	}
+	cnt = (tcp_lost.len - TCP_OPT_LEN_2) / TCP_OPT_LEN_8;
+	for (i = 0; i < cnt; i++) {
+		if (tcp_seq_cmp(tcp_lost.hill[i].r, tcp_seq_num) < 0)
+			continue;
+		if (tcp_seq_cmp(tcp_lost.hill[i].l, tcp_seq_num + len) > 0)
+			break;
 
-	debug_cond(DEBUG_DEV_PKT,
-		   "TCP 1 seq %d, edg %d, len %d, sack_idx %d, sack_end %d\n",
-		    seq, hol_l, len, sack_idx, sack_end);
+		if (tcp_seq_cmp(tcp_lost.hill[i].l, tcp_seq_num) > 0)
+			tcp_lost.hill[i].l = tcp_seq_num;
+		if (tcp_seq_cmp(tcp_lost.hill[i].l, tcp_seq_num) < 0) {
+			len += tcp_seq_num - tcp_lost.hill[i].l;
+			tcp_seq_num = tcp_lost.hill[i].l;
+		}
+		if (tcp_seq_cmp(tcp_lost.hill[i].r, tcp_seq_num + len) >= 0) {
+			tcp_update_ack_edge();
+			return;
+		}
 
-	/* Right edge of contiguous stream, is the left edge of first hill */
-	hol_l = tcp_seq_num - tcp_seq_init;
-	hol_r = hol_l + len;
+		/* check overlapping with next hills */
+		cnt_move = 0;
+		tcp_lost.hill[i].r = tcp_seq_num + len;
+		for (j = i + 1; j < cnt; j++) {
+			if (tcp_seq_cmp(tcp_lost.hill[j].l, tcp_lost.hill[i].r) > 0)
+				break;
 
-	if (IS_ENABLED(CONFIG_PROT_TCP_SACK))
-		tcp_lost.len = TCP_OPT_LEN_2;
+			tcp_lost.hill[i].r = tcp_lost.hill[j].r;
+			cnt_move++;
+		}
 
-	debug_cond(DEBUG_DEV_PKT,
-		   "TCP 1 in %d, seq %d, pkt_l %d, pkt_r %d, sack_idx %d, sack_end %d\n",
-		   idx_sack, seq, hol_l, hol_r, sack_idx, sack_end);
-
-	for (sack_in = sack_idx; sack_in < sack_end && hill < TCP_SACK_HILLS;
-	     sack_in++)  {
-		switch (expect) {
-		case NOPKT:
-			switch (edge_a[sack_in].st) {
-			case NOPKT:
-				debug_cond(DEBUG_INT_STATE, "N");
-				break;
-			case PKT:
-				debug_cond(DEBUG_INT_STATE, "n");
-				if (IS_ENABLED(CONFIG_PROT_TCP_SACK)) {
-					tcp_lost.hill[hill].l =
-						edge_a[sack_in].se.l;
-					tcp_lost.hill[hill].r =
-						edge_a[sack_in].se.r;
-				}
-				expect = PKT;
-				break;
-			}
-			break;
-		case PKT:
-			switch (edge_a[sack_in].st) {
-			case NOPKT:
-				debug_cond(DEBUG_INT_STATE, "p");
-				if (sack_in > sack_idx &&
-				    hill < TCP_SACK_HILLS) {
-					hill++;
-					if (IS_ENABLED(CONFIG_PROT_TCP_SACK))
-						tcp_lost.len += TCP_OPT_LEN_8;
-				}
-				expect = NOPKT;
-				break;
-			case PKT:
-				debug_cond(DEBUG_INT_STATE, "P");
-
-				if (tcp_ack_edge == edge_a[sack_in].se.l) {
-					tcp_ack_edge = edge_a[sack_in].se.r;
-					edge_a[sack_in].st = NOPKT;
-					sack_idx++;
-				} else {
-					if (IS_ENABLED(CONFIG_PROT_TCP_SACK) &&
-					    hill < TCP_SACK_HILLS)
-						tcp_lost.hill[hill].r =
-							edge_a[sack_in].se.r;
-				if (IS_ENABLED(CONFIG_PROT_TCP_SACK) &&
-				    sack_in == sack_end - 1)
-					tcp_lost.hill[hill].r =
-						edge_a[sack_in].se.r;
-				}
-				break;
+		if (cnt_move > 0) {
+			if (cnt > i + cnt_move + 1)
+				memmove(&tcp_lost.hill[i + 1],
+					&tcp_lost.hill[i + cnt_move + 1],
+					cnt_move * sizeof(struct sack_edges));
+
+			cnt -= cnt_move;
+			tcp_lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
+			for (j = cnt; j < TCP_SACK_HILLS; j++) {
+				tcp_lost.hill[j].l = TCP_O_NOP;
+				tcp_lost.hill[j].r = TCP_O_NOP;
 			}
-			break;
 		}
+
+		tcp_update_ack_edge();
+		return;
 	}
-	debug_cond(DEBUG_INT_STATE, "\n");
-	if (!IS_ENABLED(CONFIG_PROT_TCP_SACK) || tcp_lost.len <= TCP_OPT_LEN_2)
-		sack_idx = 0;
-}
+
+	if (i == TCP_SACK_HILLS) {
+		tcp_update_ack_edge();
+		return;
+	}
+
+	if (cnt < TCP_SACK_HILLS) {
+		cnt_move = cnt - i;
+		cnt++;
+	} else {
+		cnt = TCP_SACK_HILLS;
+		cnt_move = TCP_SACK_HILLS - i;
+	}
+
+	if (cnt_move > 0)
+		memmove(&tcp_lost.hill[i + 1],
+			&tcp_lost.hill[i],
+			cnt_move * sizeof(struct sack_edges));
+
+	tcp_lost.hill[i].l = tcp_seq_num;
+	tcp_lost.hill[i].r = tcp_seq_num + len;
+	tcp_lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
+
+	tcp_update_ack_edge();
+};
 
 /**
  * tcp_parse_options() - parsing TCP options
@@ -509,7 +487,6 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 	u8 tcp_push = tcp_flags & TCP_PUSH;
 	u8 tcp_ack = tcp_flags & TCP_ACK;
 	u8 action = TCP_DATA;
-	int i;
 
 	/*
 	 * tcp_flags are examined to determine TX action in a given state
@@ -536,6 +513,7 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 			action = TCP_SYN | TCP_ACK;
 			tcp_seq_init = tcp_seq_num;
 			tcp_ack_edge = tcp_seq_num + 1;
+			tcp_lost.len = TCP_OPT_LEN_2;
 			current_tcp_state = TCP_SYN_RECEIVED;
 		} else if (tcp_ack || tcp_fin) {
 			action = TCP_DATA;
@@ -552,13 +530,7 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 			action |= TCP_ACK;
 			tcp_seq_init = tcp_seq_num;
 			tcp_ack_edge = tcp_seq_num + 1;
-			sack_idx = 0;
-			edge_a[sack_idx].se.l = tcp_ack_edge;
-			edge_a[sack_idx].se.r = tcp_ack_edge;
-			prev_len = 0;
 			current_tcp_state = TCP_ESTABLISHED;
-			for (i = 0; i < TCP_SACK; i++)
-				edge_a[i].st = NOPKT;
 
 			if (tcp_syn && tcp_ack)
 				action |= TCP_PUSH;
-- 
2.45.2

