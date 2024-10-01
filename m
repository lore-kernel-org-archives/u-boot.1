Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4637CEACEE
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 18:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21E2E8927E;
	Tue,  1 Oct 2024 20:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="OdDESt+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D3758927B; Tue,  1 Oct 2024 20:21:23 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2072e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::72e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C9358926F
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 20:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyS8XbOEkjINVDACZNvJk0CLL48zM2LxluoKqdfdDB7CZ7M4ke4/4WFjm3BLGx2EakAmoKJh02En5mSVDzYMlvxtz5baU11OBzMaedObTEm5/oA9rApqCiwqzEIZOIhYQRv6q7ULwz6N48fSQSrmIZOy2PA2RFAayKPlnzTyv+Dzj9k7O/mYSq/YnGhmkuXp+f8iZUHTLr3VeGfMj/fRDdnqa1jhoZrAP1WOrzIRbHSfGSWMA9Aedbh5NdcOEoa/bO+hlaMC9NDIaObffCYmzuI3E7g+sgP3P6EFhxE7Bx/whf8CFai/et4jGN2CZbwsp0OOW1YrQfsZIRvAPdUJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=xSMI2ZiDCd6xzU75s7nDiKgMcQdOr1k/FftO6pdEQWZLd5Gq0aWX/kR3nhkOXi+pFP0cxZMgF8qqHalQomG1JDU2R3JBO+DBD45PjcD4vfj+6g1LlrAPhyAu8c1elIJU0oyOaM2TdfynC4DBEwt67xsy4kbz9oFvH4x+rhIwj/WXnLtdUQncJ5Hb+rn95zgRSjiKu4uR9E3sq7tjDxs2i3gt208xa7myvj/IytZ6a21uEJkPXQ/Scd9657TUfRhK++1An1gK5UzuTVbDrrG44/JDchspfKT7ui3hz6EY01h+2M6b7MpqyzZu2VbY67Uj9V2WMQkwmG3Ca5FmjaDM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=OdDESt+zK7EVsQAKT1e/bADwMLXW0hlhNJfwMjcQZ4SPZiJ2hZX16nMtf0sPbbwoU58fpdkjqVU+GZLw2ypiYbWyBU4aIc8pb+bF+XVOSHm/li/2ryIBPg50+sHI4epLkG+trtYfDylwRR+WOtgD6F6pgOufjIeH8gUuRyM7U4plA9tsUx7TNEok3FyKZ0tTIX5rcvkxyrVHqc6ZJ72BDbrKyfjQKmVXOUOn5YPQpK822Eb0cB2agjdwDEYFa8rcQmisGOKpaiTcJItVTza7fun9GFB6LTOu2ZuGnZQVUlthvJKVsuQ9kVqWdrZfcTY+dI7UT23Qyw1/F8wQ4kqAsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9188.eurprd08.prod.outlook.com (2603:10a6:102:30a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 18:21:18 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 18:21:18 +0000
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
Subject: [PATCH v9 02/13] net/tcp: fix selective acknowledge
Date: Tue,  1 Oct 2024 21:20:56 +0300
Message-ID: <20241001182107.907828-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: b47f892a-2df3-4650-3578-08dce245d7fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9zmYa2xHAgmVlZsZCXpjewvOyr+6gygm1JmAHbgfH4jr95r0aCRBDex090IZ?=
 =?us-ascii?Q?ysAlihgtr2HN2kpWBicuAVQA/bqjAUgA1E/VKL1qB+aN+cUFn3OkJFygPH/W?=
 =?us-ascii?Q?PQGzBb8zgq8Q13bhxatKxC6AHrYlQk5PXOllKylrcXyOlnZIJxHQkMFAyObf?=
 =?us-ascii?Q?H3Ut7U81SbL/mOWozibjafFpD98JuKZ1LfUT28NEk5vSDq6lrSdx+O7tv1gi?=
 =?us-ascii?Q?AvhUNyArXgam/CoMPxu5K+qdTsGwgxocpUGIdmaYkwFLVWq2XbD8YYwM3Yhb?=
 =?us-ascii?Q?WT2FWDjnZmZKn+Ys+r7rcwXr40+Oom5oJhmTAerV8g65soDEGjrQB6yxEuJq?=
 =?us-ascii?Q?lTMDM/X1DP3c8S/R6fx9qCp9ZQ+yBE6s1WPS0+hMtuBPz6zzKKyIETFjeM0n?=
 =?us-ascii?Q?ljn3kTA9DfAZpW90S4Q5TpZ2fIsHaQyg9jwUd2XlNCsV7uqrOEObgXT3NSjK?=
 =?us-ascii?Q?gtQ01xCoCJF2NCLfxLcw3EA0fVL3jwCayZ6rXWnb8uw6cE2p7uB0/hwZk8f+?=
 =?us-ascii?Q?LiD1ug5bwjle40PoneRwggd0cTPjONdYGoEVa/1p4E0XISPpvIXF6Xqb/yU6?=
 =?us-ascii?Q?fSPrANCc4IM2DkLZg1yytLSl2vc2y5wKxj59p7DGW3nkep65pLDO4LK2Hcu6?=
 =?us-ascii?Q?skPl0gZ3jcWMet/xh5l2C5K3AotRBLy6VhClzL1Gmka4y+yKlGRDHY6v/jWz?=
 =?us-ascii?Q?40ReM10MAeTpaWTujYD8y2E1mvqMFeqLFpOla3Nu9p3vn4uFBJ5WuXZSrzeO?=
 =?us-ascii?Q?6jBpTAdm0zWvDauQuBbLPFrNHZpSTVwXr2+2OfDdYC8FNjdkJpOex8bf4m5a?=
 =?us-ascii?Q?TAatmxHCHEZLv+bBCtiNkYjXUxmdfgKYpsd4nPYAZNvoXFj0OpdRPqPEHjX2?=
 =?us-ascii?Q?+gvOiPDuYU5MpbrwQdcCr7JaeCHgwZCBJDCyhh8KUOaJAzevtDRrNSH40s5i?=
 =?us-ascii?Q?G/dHbkWYso+VIOMcWEYIxVyVXydf7obccT1KGZ25R6pa6wupIDNCtapyKK+j?=
 =?us-ascii?Q?uz1vhCL0cFbGO99R95JOzm763vwOPzSIrsdUKZV0FEVqqvaIXH/6tgkyFv/p?=
 =?us-ascii?Q?hGLTHl+GDKCkJeoeEbK/38dDvc7/BKSf/fO0eGuMwYOIhgxxKcCMOcj6jdfp?=
 =?us-ascii?Q?UlfU/N3rzuwUP7ZdNq8MDN7lbSmd7E0dW+QSY1tzOSAycKLandTQRrRLKUJP?=
 =?us-ascii?Q?SHKOol+E7oEyUXuFFtocatHMihwFnFarBbb9QqDmwyPm6TlGfG+Y8Do1/Qb4?=
 =?us-ascii?Q?kpSHkbKfp7i/LF13FVZ7xEs7Pp0fa2Kh1MvqGRfiF8pepM1DRyOY3C9buGZj?=
 =?us-ascii?Q?BIGlJNUYzwn5sJTBZfcc1NtIks59ONnKmAPI8VG/Kki0r7UeE4rJddwfWXzq?=
 =?us-ascii?Q?ko3+acw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J3Zoxzh/CMQ0yiaNhKVvIlWOHYrIdRUZYcPJJGuh5hlqvphD28dnwaH2uHo7?=
 =?us-ascii?Q?kprhyKVpZXRK2x1NLfTs4HFMRabgSj539itDvy1b3MFXFmH76PuM+P7rzByR?=
 =?us-ascii?Q?5xbWck63SWpghOG1TIOUt63oizUkngoobfCgvYGrzx7kqcltqPkv7c2VW3p7?=
 =?us-ascii?Q?BKAArecjIKlDMuBRyFZ8R9LtQly8FpMqgNQ0MRbTiYhAJSgYu69ryAsuWja6?=
 =?us-ascii?Q?SX/jKb7vgL79/U/bUXU9YPqmiurW3M2FUp6uEsxRK5NzGwGMrAHw/qZu7+5m?=
 =?us-ascii?Q?YtgOrCMP339MBLy9/QfMXvzRKFJ4+zHKkK9M6lYfxt9mvuLSSNLOp75eE9ma?=
 =?us-ascii?Q?cIUdRw6308V4OtYouTtnXxMvPN1SemlycxbTKfCknXbprFSjT1JwtDY8ZNRg?=
 =?us-ascii?Q?t+AE7Qvas38gU4GAWO4caTrgvcI8125qEs5V0XuDAeyKG0o69MzwG7LjlqvD?=
 =?us-ascii?Q?S4X2LrHo7X/PpPGqbH6SiLAoeNE16uHL4gTRIgYd8CX6ZeNO2gUfFMai6UmP?=
 =?us-ascii?Q?ipIGLSaRYe5gK1B31rzmBVJSwhOK0F+LWeFw0S+lWhFo2zZhnUK/mglj6iif?=
 =?us-ascii?Q?kjqF/QCplBvdFkpWRT/JdpOCr9UHW2DsX2wlxx5Tjr7Pusldn3eEHS25+kZT?=
 =?us-ascii?Q?dASGTrDCP1Z3maciZVYMtxVQzM6EVozPwBAiEBTBzDLuMFJOrGFAIIoZFbdp?=
 =?us-ascii?Q?XMBVYhkTWIVSGUgclCTzsPE4qqk2Qi4BIEK1yzVP97f8q2OkpRp3plSk6OOB?=
 =?us-ascii?Q?cXzoJx2W3PQZ4PKQaZ4PZ/t/Ni1GTbLh4q2y+dPYbSOkmh7dzxIhWx8Wf9uL?=
 =?us-ascii?Q?QWa7qg6SGqc0Rl1Ym9SNg9f+woUCkAoSaWKsXhAjwQHBP0EuFCa2PCO6hqNz?=
 =?us-ascii?Q?teqL/KP4WjbXTntsbYDfTtZKtcBSVwJGdgnNn6OHfkBRRPHRpS2Fw3uw6S5j?=
 =?us-ascii?Q?bgqVAfYcV+mo+QhM1VK1c5RiKa7qsbcAGlTs4mSVDOamJIHUjAsP3l4xFBXr?=
 =?us-ascii?Q?toHN/fiQMbzqPvzv+sIj37a6rCg46ecTWIrnS4mfeQah9G9tfe7icD2ZKzbe?=
 =?us-ascii?Q?c8DUtKBQRGmp7167OmxGQZvl0TNycdbazjW9KgUExN1jXZlwCX7ARkRqpd9H?=
 =?us-ascii?Q?bVIxb9al0bO0cRDq66UG1PXyZgw4uaPlm/5h2NWfqRMTOX0OrPf1TbSKjRK2?=
 =?us-ascii?Q?dZmRq7OD/N0Z7nl/1l0La8XzU5K4I4nEfQ2T2hlq69NK8YDv37TLA6IUDreP?=
 =?us-ascii?Q?FuBwBUoouGcfBjQhqubojSeqOneFO7nuyfO5Eu+ojoFGSTxpRPAXPSiqteRX?=
 =?us-ascii?Q?lHCCdULueqVanTKgz/oa1dFPG1razRF/z/lixkKQsEHMYw6x3sdyHxCRBqoz?=
 =?us-ascii?Q?sp3VvpPVB/L2BIwozsnFJElJzNjkDqZp0hfv4fxblH/Erc402NuAT75iM3ou?=
 =?us-ascii?Q?Qpj2Tu9DhWMc1STyWUcHJc0YGu4vGWR0jdLSIhct3o5Zbr6fApOQW6cfgoV1?=
 =?us-ascii?Q?RRe4vGb9rWbjgb8FzQ6JcLvgl2d9BdUBnMS3siIhSvZTA6PtoVc2PcmHbUJ0?=
 =?us-ascii?Q?iCVE9N4UPPjJ0ji/x1Ufg+oKJfjWMYS2UotuvuHdwqBMUwoMpoAU9gGCFBwA?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b47f892a-2df3-4650-3578-08dce245d7fc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:21:18.5432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /J8QW93zNdjgmtKOEBYsy5FOFdI5ltve7+47JB5d2MBsZtdlGZ6zyZs3ZqKd3o3LXRMrHUvJYF1n/qwFXhx//HXtCDxnt9/fi9hcbGBjhvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9188
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

