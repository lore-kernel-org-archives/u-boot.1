Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2420AC5472C
	for <u-boot@archiver.kernel.org>; Sat, 24 Aug 2024 09:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DC5B88C47;
	Sat, 24 Aug 2024 11:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="X6kM6vbs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DB0088C10; Sat, 24 Aug 2024 11:27:32 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::727])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E776F888FD
 for <u-boot@lists.denx.de>; Sat, 24 Aug 2024 11:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYAuII0KO+oSY280OMHEY+PsChYmnOU88ruYl3MX9Q2+pe86siit5vi4v59pTemFtXSI9dV0WzsTXIV25h0EQ9hnxWaI+31Ws3esDe4007ImAjGVZxcAhTWNjcJ5ufxsD3riI+ka5zuFwTQ2OcgY6wHfSJkUKr6MEKP3KdGUPmmhsx+NEOhx4H7A98+VK8TdVKhxDdwe/cjUH4awXGonNs3IWgzRpMvuzE60qJTSrKb3eB1JLTDJee/Vkplz0ikVTjvqdKPWX+ZljKWTM8JkgTTc+lOQvBdu6uL42pZsPKad4Wnojo+SCwMXgxXJiwSehCwD30j0/YV+Aqkg7tEDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hahBnFJbV0odlIPukazF5oQypFtjvGWCc6V4kSoQSX0=;
 b=rRetZs1x4KVQIQ54O4WS19jIf/qJEoUaHcGRrrn/cHBiz2zsosNS+gXeztChBnprzZvXuld+3XB2BxQRpBUT4wE06BKB0q6aIJvwknPEI/Q1hoqcyhKrhSZVx0Mz50rf7ihJMq2VLuCU0KkZ1xgYrQQZaO+B4EYG2QVQmMpFrvJJM6KI3k/keFSns2e80q1+y749ibrt7PWLdzcKwLUbDUGOZXmpRNps8fyHSvzaBgR1LnIq5F23sxf1bZbBXtmdJ2H+dzQUAO76CiUpAbE4caaYuIGS+fyZ6xdpWYa87WFtk8Jokx8tj4h4fe8U02ywEI99Q6ZRFQbrz4yI5mCltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hahBnFJbV0odlIPukazF5oQypFtjvGWCc6V4kSoQSX0=;
 b=X6kM6vbsTB1GKbV1Sbnda7iRec0gQgo5St8eHzPDtc1JYMggBsbbQFogIR/dNpXhVDF1lATvHv/Z7qE3wG23Rp5m3fYGQ9PTSkUjOPRsvl5njWOMyIgUDgUJ10fDzbAq/LXXQAcFW0oLF7RSOlBp1Nur9IeWSXVkQmfC09alq+4vkPe7XaHLZbnXnaXwXQwgj2x/rLjEeD8r5+CSapwlZ/F+MoSKRBEXT0d0+uB2TAcFiufy98SiouDW8Tz3m8vqu684OwjztD13WDipGtTNg6/0JGrKr0BgjdKiI6DsSNtFCPPGJJ2vk9RiIs43mhVgfiSy8Uh6p2JRND/0/G40XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS4PR08MB7601.eurprd08.prod.outlook.com (2603:10a6:20b:4ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Sat, 24 Aug
 2024 09:27:28 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7918.011; Sat, 24 Aug 2024
 09:27:28 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v5 02/11] net/tcp: fix selective acknowledge
Date: Sat, 24 Aug 2024 12:27:07 +0300
Message-ID: <20240824092716.1042696-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240824092716.1042696-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240824092716.1042696-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0011.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::7)
 To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS4PR08MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f62a81-e394-4bbb-0b43-08dcc41ef8cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n27oCOaaaAzZRiXPRxXVENnEOyeZ7fzLnoOV05vzStvQK+cuOiQr1gFuEhYb?=
 =?us-ascii?Q?BOWhb/Okx1SjdoE6/qa7X6gGb4ei95S754TOYBx/nO8NWdFSfqz5SaroI5hG?=
 =?us-ascii?Q?K7JjLrdg816t5kJFq9jEdtkhAR0pTvrO7X+O/3pTjIgCpMPLLERriUP+SojL?=
 =?us-ascii?Q?pmKCeSslchCRleYON6CSwTqzi3tKsO4xKdmyzQ+xc6z2C1IODkwTLKsHJ837?=
 =?us-ascii?Q?YU+yhYlwp2zi1+DOL7rFXRLFvlboj7au3wkEokHNSy+x5FpTuWVGFCx59XgN?=
 =?us-ascii?Q?Nz5jrFsz/7kqgGL9PT7734HjOPw3cm/QQcz1eCkRmN/EgG0xMWchhCvnVQct?=
 =?us-ascii?Q?1eVQt5pQNHX2ddMiirTTiNe6qLz5TxbYh/wDaFMyNouqd7zPfVSn1ePCmKsx?=
 =?us-ascii?Q?exAm4l7aML1QQAgVU3AmtEXpsakhV7v1Yl5QSH2SMQMghHFmIljyMVIqZae1?=
 =?us-ascii?Q?Zmg5Haco0KZhssDpSzpeuWVUY4bn6vQ01PwJO/jkCfnveLjswPj4ui6tN9ML?=
 =?us-ascii?Q?oRI+hPGpBjqvVAowBdSrDVdNgi8RxVZvTUpaCHWOC2PimleqFmCw8UTjqHtj?=
 =?us-ascii?Q?/N6wcKDHJkfX87pNFzJqZQTq4v8L06uuUZDRkEz5VBq3AXbIvHH1y2d8H3bj?=
 =?us-ascii?Q?gynAyqVrNACgMmLBiUnpwxAE4njyftDx/WaeHegGccJ74Ik2XYCH5F45mFy+?=
 =?us-ascii?Q?4to3K8RQPGVf5WCAZJcgkxPLj0iZEiB2Nc6Me7XZNCGudsqo8Mj+E1rXVCkn?=
 =?us-ascii?Q?kIuaSebQ2lD2WzMZHVkfG7/ftXDUKH4Gq1A0zpG5tBs0qRJzLd0edndjg4Oj?=
 =?us-ascii?Q?yYGGvj1YnL4CfIMQ9HfGvLfvcBHe/J3Ju53qO1+W3OskimkaYQDVxf1rPV6s?=
 =?us-ascii?Q?pfXYtMOYS4pU0PtoxGAizll46ZOwbW+6+frGKAAn+8KD1M8mbq6w6TC4R9KZ?=
 =?us-ascii?Q?wkmBa9NMsDBS+ObNcbMkeq+S+Mg4MVpdhYZpUwmIqHgyqRKS7QPinmJOCaBr?=
 =?us-ascii?Q?/N0OE1YNtdtQig6ITeMXRrkCsgc67xBd9SyySYcly0IxGWRtDFsj9tfb+lMq?=
 =?us-ascii?Q?LBbjLKi0U0weUw3sK7MSoiQtAPwV1XMF4Ewe1lEqb3F5bbsGLsnCCVWyGLrF?=
 =?us-ascii?Q?3SjV604HgGZv1F/mb7h8O0PvWmJPYc7EFFz2scl3IDvOuk0u5jZSmrwcRxxz?=
 =?us-ascii?Q?7W0VTIUwQ6rfMgGfGYjB2789hs7zUNgmPWVuXe5vWXboItc5OkhdgOmqhFii?=
 =?us-ascii?Q?ydcZTUzPCFjPIJ/MOZJVlfwXj6/DXK595BG9y4cJZS0/Ka4umcnfUwJB4Y0R?=
 =?us-ascii?Q?QfYzVNjqUFcNCnnzp7oZY/9+S2ideAxGyaMjNqJ2gG29F4lEmmRgaVOx8v3b?=
 =?us-ascii?Q?lcIsAdBdMEudG22HZTi3FBcP9tFbO1Yxw3i4EOt15vkXGlh4U52JyxZxc7EB?=
 =?us-ascii?Q?oAqAZYEoubU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YLxk4z65DgJdAZFJdxhFzdD+fh8iulifdfUfZlPGLRFN2WSgASAB4MxokGas?=
 =?us-ascii?Q?AMPy92ydJliLIjANCvmzCrNGOOiMDx1TV/MLIBeb+EWjl1OlWmS8Ql+GUfIt?=
 =?us-ascii?Q?Dne05hJg/sb+0c6DIaZM2GhcVyP4xTCe7hBDrcSArJaHXxmvh8YuQ9Z3IEdB?=
 =?us-ascii?Q?84ByqsxbRpC83Z8M6i01JMKxL3bLx9yOJKB82oHgjjQ1TVUwsU/5Hgu8naHM?=
 =?us-ascii?Q?MavG5WCRFDrmR+Umpg/FLJv85bSdS0rBFq5aCQbqBseI4f9D046Yxrf0DMl8?=
 =?us-ascii?Q?89k9lo7RmGIQ/IcmV94zUGhbfH/wA1pD4Wg0ebOo59aMOArHW1WjXCQ4poJQ?=
 =?us-ascii?Q?a7xyf5XZqSCAo4410kfIybQEOH88iH4Dsv3TE54WwDIEviq6+ca2L/IDbnZK?=
 =?us-ascii?Q?plmGE1RS03CgC//XnGzKSTRusCGOvHcMK69pWv3ACnxXROXzZrt26AwO8y/E?=
 =?us-ascii?Q?s2a4JuZYGNs6ygPWhpUuGbBeF/W6h9K9AllaEmi7G0HHwvEaKlB0NeunotBx?=
 =?us-ascii?Q?eKQv6hUynf334aZd9WbJALZmz4euoFo7Rn28JWHE53PLuPKucGWQ/JVTv/kA?=
 =?us-ascii?Q?HP7l7qDar9k4YolwFh+qylScNC/TYPfhuqSudfC6WzxRoBxoahdzhJ7zOyP2?=
 =?us-ascii?Q?FZkngVp+Z71LPExFCN81ysUdKDiNXH8p5lcQa2dsRIHIT3Pdh9XdQjjPxNYQ?=
 =?us-ascii?Q?2lNjrdZSdbJQmvGWqAkhATt4/fNOhmTDkeYNHIW+/qmy5sIKpo2cKPW0qNb6?=
 =?us-ascii?Q?f/BOwsAtxZaLyXnfawC0PvoV8CNenVVvfMGbeWaDme94Nqt9pC1yQHo6K0jk?=
 =?us-ascii?Q?Jjg4Hre0aYPjZJvRUalE+9m0BjonWSc5kmVnrPXD+M+i7fRXtS5NOVNfRXOl?=
 =?us-ascii?Q?ECpW4jsfr7ncux/aoucWJvxQnNYcsGULnWBBqXjmv4CVxUdvedpJK9qSq+1L?=
 =?us-ascii?Q?4ugLR/K3njq2TaiExcJ0cES80A7dLzPJzzSaHSo1zlnkHy0STIzdtLUWhW3A?=
 =?us-ascii?Q?k/FxB9jJjv/8pJpMJ/kjfHNRIr3UzPFxFVJflE/t6VddLAjeh0lEiKC/vfOX?=
 =?us-ascii?Q?dl5YTbLrXPk940QacQm1W+LbSJtOdTUayLQAydo7kICmCJWRbzTnN4TXFvou?=
 =?us-ascii?Q?GiHCG12CLsjW9tw8km7IDjHWJ+GxhpGQfWlYD7T0RK0sWccyHB6mRbgE793A?=
 =?us-ascii?Q?EPm6wLmSbnLdqdKxrWCbcRT+0QCi87rr6IUVnOpLHCS6mZkxWwK1O0jfxm2Q?=
 =?us-ascii?Q?sgf+QcVZr86QLW2B0J8IHrI0WjgGMc+7L4KDxjU7uXkFeeEbdQClN4+HDILc?=
 =?us-ascii?Q?JU1uOMwLSC4hsQSDz7LRf2tMIRE4GA8ua1DNgwLNvScF6kYZBS6Curecchhb?=
 =?us-ascii?Q?vKQcn0JLoWcpiCnkD3cUlXqWifVtj9m3yNugGfo1+9nFNN8QvaFL7YRjgXle?=
 =?us-ascii?Q?OVTwRA8xsW+9QQy0Red6uVAvAkFKZ8SRa/mEhy+myKTHdL73HppV2mFQPKQj?=
 =?us-ascii?Q?iJX77sUTTIQmkeqirR34u9/Mep0ax3rqUEyKaphO2DcPc1auQ0OWassRKjST?=
 =?us-ascii?Q?nP2MAsRnYnagWfIVnqxkmNYUJmO3Mx5OX74/65vxklQmbUtL/7rKaN4SDJBO?=
 =?us-ascii?Q?kDWIMmLUwAdHWCN4G+QkSy4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f62a81-e394-4bbb-0b43-08dcc41ef8cc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 09:27:28.3316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvjhvk/leC9VaVr4koy/WOvyYdib8kGEURVSGRmlbYQszNzWlN+e1DfLUrIdGy0jI74/rZyixUabLOBR+P0sX3tkynAYJFIQTYQNm0FmUGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7601
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
2.43.0

