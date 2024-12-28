Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2E7E77188
	for <u-boot@archiver.kernel.org>; Sat, 28 Dec 2024 10:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1042C80511;
	Sat, 28 Dec 2024 11:46:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="SC+8TpVi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03038804E7; Sat, 28 Dec 2024 11:46:56 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::717])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C79F080431
 for <u-boot@lists.denx.de>; Sat, 28 Dec 2024 11:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArUI3TcHifb8INNMt8Phc6/lvtG6yCSzBWEDU2dVV1PRFQgiDYX7V7E82zeomumJoivYnj6BaqnWsSv2OXnoxJDAu9tI+LwQc72PZMFYLZfpJRM2OavI8uvrR45+fPCC0ZMD6/AHFIpz521t3hxq1B0hpr+Bd+hUTEu8yw02U5WhDjHyBEdeesmVJLVrgCBtYz3uLiIGSwVMoni7grbMh3npQPc6MXNoqNMCuqkmbBqqwEFbb3djoHSLMiiRBRmM/uIyEuRJRQkgqhjEzt68PljukifkTv+cBp3BsMOmSARFvOkmQaDqrnMrbOan5OWI0ouwS0czbWrDiByzP5VaEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=tFvbmZmi0dCYqXJHgx6Xn9oU93sxRkDTO/0vjKNxzIfaRgyvi/RlU3u9F1UYZ6IXeeeRpCi6bqRR1hv+P9bMx5hQTYvcj6F3QQIB4Csv3hzmqs0neEIJNthHtljZBWX0kdpKuOxQkbjOAqBmITw420jXOiykPgB29Sd43NjiWnn1Zyimp8mB7AGAKEwmtrcFFxDlHmNGfOZ8TpSuMo4KHGj1EReW0IuVHMABIiDcYmxUHc5TVdf2LlBOBa1DxogLD488T3atN7VoUWQIuiauVRI92XlEY5JW7Zq/58Sby2hLx17WBA1Y+mcrLNDBVJ8HYMqDoMM+O5c3AtUZrbyLLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=SC+8TpVipffbyvugqKcsid9Q5vVoyOyEeRQHqqkAPINV/IPUuBHuJebyGWGtyRY1Vg4Z02HhJ6vuAvxOg3f5gHNOB2ZI4vsQBEusfCavX+JT8IJVBOmQjZd5mmeI206+NylKnEwGPfG1TsnDuMKdkxJEf2SKhdVZLDdrd7pgLfQ04sJ2IxbsfpuLiy5lUo9f6MTx3hoG3APdc9fuEb/H4SkWoE987dPyllQu5D5va2GBZ1cGO8xIPFHmPc3HXbcjOrjGqaRtBaDtGsBX9GOuEqNyX2wyKQK/yBJEgUJnYQbry40yhGVlnkE8EGdbJPumy0umv1EwFGroisIXCPXsPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8437.eurprd08.prod.outlook.com (2603:10a6:150:c3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 10:46:48 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 10:46:48 +0000
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
Subject: [PATCH v16 02/11] net/tcp: fix selective acknowledge
Date: Sat, 28 Dec 2024 13:46:28 +0300
Message-ID: <20241228104637.4173913-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 71e6516e-8980-4ca5-d484-08dd272cede2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?60PJ1Yy7nCvY7Gah7DJ5a2OOQMR7Z28QWsGjk6QbDRS67fx8xOaCyATizjlZ?=
 =?us-ascii?Q?jAEFcV3j7F0FVa0QytBNXsUhUTgfDuqcCYmyXgiavpZoAo1xjkdHdffSJplZ?=
 =?us-ascii?Q?nXop4ZaTSf1bEAH2XQLepA893G0BumnjrsWAxmsoI+BjK/o/NhVfzxLGIHyJ?=
 =?us-ascii?Q?ErPkUqGLyIrWb0cKLukSH1ehosROWeks9CVdvqevdXgfQAvoN2Noy+qagFE+?=
 =?us-ascii?Q?oJemBm8WNC2ZjE42HyN15gTvxxIQT9Gq8+6Axc8HI5KHL6/NUrUDihGx8ajK?=
 =?us-ascii?Q?betzJgVUGW+ADKDOW9TEyqsmymDZkwHKIpD0J1yvpR3UQXWUqyAWW91XTew1?=
 =?us-ascii?Q?Z81E3BvUJPbK56obAcKXDiUAuDQb7KWksQgZ/Y9IEtwhTdiXtjRqDzKUnwqt?=
 =?us-ascii?Q?PktFqVzw4M1OVxfz297Y98aNcnF4ePRyuTWJcpIQzoaQSfsAZzzF+48dZDEg?=
 =?us-ascii?Q?umGqdrRoz/rJ24XNj1S9Kgw3j0gMGriqx7obL9Yw2pGP9Z+IMU6nOROyahOi?=
 =?us-ascii?Q?XPJY0sr+He62op2gayMiVxZgLMcDo3E0UvkiTXi6gVg+fxICEZVWD4PRjcTm?=
 =?us-ascii?Q?iFXDTryyOfaqW73ezXwequ51ZEvbtfm3oUsPUcYKGwyD+Xo9Oquaun53TKk9?=
 =?us-ascii?Q?a39CPY+xDNA/bDgVsVOANNyjxkQFTzrt2be0mIHo5VpNltJVa/UUl/kZ2ipU?=
 =?us-ascii?Q?rNXzFa8egvbljBqjZ571qUB2TVAcGpyUu19OzgxhbNGarB6z7g57u5ZykgXh?=
 =?us-ascii?Q?nTfwsZwZuKSGW6ejxjav3N8uABLqJ8rAtuCZH9kgah3n7EvbCjWdYZyslYXt?=
 =?us-ascii?Q?qkrK1OnTEExPaw5hNmmNCiki6P798JmSmnTreU8xzdZA9wRMdcFYYgYw0Bb8?=
 =?us-ascii?Q?UpSGY2nmJVGJXqFKRTpiw5v16mbz6vu6A0Sw5DMgQ0R0U0W0q7pDKRhIne5v?=
 =?us-ascii?Q?6bo14/hfKuvhNyQae3ekFChjZoIJnQkpzu/MbPnOET4GRB4P3ULPM6oOq6jn?=
 =?us-ascii?Q?ujNdcy3umkHkS/c3KJ674T7hFlgiQyyDGamuwcaSaFbIHyXGvw5dgVpFCdq/?=
 =?us-ascii?Q?RaEFmaNp/FKcBFZeLsIIS1UFqzrKqP/rGR//MMGyurIo4EG4Ns16+VqsrIdX?=
 =?us-ascii?Q?HI/GPd+lIbFbpvX1l/5L8aPq7GSOk2XyAULqTEfEYlWsEha0V2IJB+q/Gzrr?=
 =?us-ascii?Q?2lPwmcWEYy8OF8N7NAgrQwrmrS5YZTGLznTCG5r3L4FBNhqRvANUgShN17aR?=
 =?us-ascii?Q?z4PWawwkmI0zdK47dQtiQIziqaetkhU0IRIXoCrx+45BYBEHtW6Y3+sZ5go3?=
 =?us-ascii?Q?nARAvO00TZqnT6JwGdNCUHsfQjidguaGNx30EjqZOEXklWTYq+Jt8W2tZrOW?=
 =?us-ascii?Q?eJdHCjNMgbzoMrpRBH0ECqC5zbfs0RpUzOFQDPwjXSx7OaWH8pqcxi0t56VM?=
 =?us-ascii?Q?+ONem9Kh9YfQnAauq6XZyXb5JDGp7ie0o8IsjNmMmdnSNFD87iGVrw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RLf+zAlNn+uWyEkm6GCaRNgHC4Y8Ve4qY5KmDQUPunNPXyylshWgZTIMbV6W?=
 =?us-ascii?Q?ooYEXqwkjdDOJ2Uo9tmnrhUlVCAudyP6sRSlY9jwrLaU2FpwT/vmmRDIjMTb?=
 =?us-ascii?Q?+4O10YMQwbj0Mdze/n96qk9CoERuGC9Ly8mImEtkv463rZHQBKz97IjFuFOa?=
 =?us-ascii?Q?ptcesZyyfA35j1kgP1YCISOZAzqS/1Ged8/VIPsxzRktMRSEHsoOAfdEKZ+C?=
 =?us-ascii?Q?Yjx+uISOSRDtgS03l8YX3SQokYBMh4j954QUuH1tg+ZsqXh20CxLx4DMG3O4?=
 =?us-ascii?Q?5qb9PqS/SBWvD8OIFPSW/Rq3A8rI54KFoYfevabt2674PxtKU5b6eyJA5M9S?=
 =?us-ascii?Q?XtTaGf+GDpzgi0QWf3gfRh2GmlUl+wEPn4x25RrV0zEfEtcWPWNkDsgJVb2F?=
 =?us-ascii?Q?cokYu8Cf57LssLFXyoOuVEXEc3aLDuN2DiaAoU4Q1z4Jz+5n6udlNbCi3YWs?=
 =?us-ascii?Q?eGf2oDURL4vG7Lzb3AhykyVM173wuLlQpe905SunWE3jFDyfX598Squ4lHUx?=
 =?us-ascii?Q?ePoHfnNjltAfX+n3VG18NrxBRCGUpU27ns9ZsXq06JypYx1/ct3pZGUiQr0L?=
 =?us-ascii?Q?GKH+ir+4YVB3WgO0Sma9NkolgYOKi9N+WBSP9DkK0/6ij4U/Y2Z0vhjvRn/x?=
 =?us-ascii?Q?afhf2BLBLYT3ACmmfea5PQGdkMFi/EuSBvX1M1VD1TVovFpueh4PVp2gMm81?=
 =?us-ascii?Q?lbfWG7IpN533G7pI3wkvaxM+BR0/h24UC1O8GNUFl0rFBpyFn7rKl48C6kYL?=
 =?us-ascii?Q?IDX70KUx0BvEPg6XpEe4TXubGMFauyxSGignecgl4LYbXJQrdIH2wf/TWLx3?=
 =?us-ascii?Q?zX1uCSY8aA7+zz055R3q+cLGj5jLYtulW1WNv3Yx+oe8O1OfvSBlAUadtjQe?=
 =?us-ascii?Q?G4jGpU0uyirvoW0rG1XPLufKmBif39lAeEg4yob5A2NlK3fQiaKWMlaT4hzv?=
 =?us-ascii?Q?1Ml6/a/tn2bwtarZavOSxzjNLPZVlyA5uvEt3WwGzfcmOIrXN6GgTqUXTCPK?=
 =?us-ascii?Q?5L4iPrGbOEYqk+i5rwXZk81ZVwfkl4pbyTor7NyHoJ8VLnM994NfBH7X0SXI?=
 =?us-ascii?Q?H56D+IfPXwnD9gVIPTdujqvEcQvRSJu6qnDJH6mjVu+juClTXrN5PocqhlWQ?=
 =?us-ascii?Q?pg7moxvcDM2PmBxCCvR2wO0UBuhplxOaHhsD1YK2EVaZtdZGloG/qizgNcF4?=
 =?us-ascii?Q?5EVIsZ3e02NqymbxnNkfIOJ8904zHxYgi4q0RB4d5vqvvegOFHJK4ahuwJta?=
 =?us-ascii?Q?gfvhEUvD8Su1Ui1nnPASPAZh8/mVjjQ1TcN1G+fIQ6kbtnODIcXM+2p0x6AK?=
 =?us-ascii?Q?QONLTuwRyOWen5KrRnjbPInpd/9Uwwc6Qv0g12+tJzdRkyPPZF6kkD4bfJhv?=
 =?us-ascii?Q?kaZjxndq0/vVV6YrToB2R7CVNDYlF2C3UbDB19WA8oqLoyQhevVkliPR35R1?=
 =?us-ascii?Q?+FfXkzY0UGoxawoPEf07NwMqRFJeHUWylsnnNWONcSurrvhvxxMIS5083KMe?=
 =?us-ascii?Q?+FdNkmJPmJFCAIfe2MDk2yP/nGK1Rwf4UFcTH2+r5tPJ14UrGbqfRul/CxTb?=
 =?us-ascii?Q?LKZSsIKWmVKxMAqKQA8ykg0oUXIMCHKCAm1BiDRRmZuC6tMNw5E9hMJ5UNlG?=
 =?us-ascii?Q?81i51mRpIOTAetQ3XLRk0X4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e6516e-8980-4ca5-d484-08dd272cede2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 10:46:48.1491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ty/Km0qc5H6ZQM1ZTKa05QAxCmv3zxMOsmT4GoNef09aeR88jX06HbuBVGGVFTNBCWxo9lkAtpS7ipbS5rv12CriQDwJiC1+vM5ig+ugJMU=
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

