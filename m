Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA1ED3398C
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 14:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39067890CE;
	Mon, 28 Oct 2024 15:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="sIAdlGYu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B63F0890FD; Mon, 28 Oct 2024 15:32:03 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20711.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE8D2890C4
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 15:31:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySWKPN2k7vxZPxDBfoscXp0an/JGT8mJKKwCa/b5lwtFnJ4EoGs4FB6URUC3swXD3S74Ge5MfGXUVFtw+ozAH45XNgMw+6gPs/WQ7iacESnRGZ065sUGKmV60ANFeb5V6yzEtf8l/5PoHb8ZYY/iS9wUyu33hkJwRqBD9HSE3yt4i4Oav2soQN1fIqUToQM+Cicp8CAVyeaOB+AfBg69gtSECDy+4SBHg21am+UR9JEwp7AjaRcQ+B9HXvAMTY6soO/18nkgTP48OrIUKV+mrnkXP4aegd8tcYYdJ0Qq8iXZxiQKjK/ZAu8Rkr6/uAugy/vI7FmD7/vppwtGo1DCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=fMzc4hZ8Czq19yIGj4ndRL3gTO2A34I6cF557rjDmXWWNhaq5e930QwqjIdW+xvee+Ardb2/3yKFw4pbpaocy+xvl3fF/kl2Kr9uSArNaLsAFSILB833VTkP+GacozPqPhERMk+mvYCdjlxsB1F9lH9SL2jYoIFy1xUBMCXaAmEnDmdQSxz+EFjcMeXnqvnk98LZpGHnl7a5X7Barvba1RigKd75fKvRjovi6jquW0yXkgTGE9V2eG8ytfh61zhZQmASlF8h+hHgMsDi87Ku7a8C9lgAX/bZR6JE/utYS0I6V5YF/exaKc3g9HFrnpcj6G1UYiub5/p6etuRJm3Uig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=sIAdlGYu4ppjwIyZhezXipglNFzRii0NHaWcPQ3En6nZTl48GmSQWVmQGIKAMUv43LYzGdMETrJnhCBmCNuj8mRzSnwvw43Jgy5ALm7BgQ2sJeGHrtxDkWln1bF5QTCKhWcVj4gECP01Dh1Zp4PDiBfOjNfh+sgy/RWa4YACFlhBMPhLsOIZgO2PMnGMlxEhqtPhUYJKiMycdIGrL2ixHnEELygBHsccGOifMBr5cbLYDsSluPgcZKZGRVjHHTe6gB3WyZ2AORXudE4ztSQYu202nUEWZOJQK1WDFZ6sNlDlF5GLgC75oKrrt81UhSH0QzRLtQzDw0LMTXK5hqfInw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7714.eurprd08.prod.outlook.com (2603:10a6:10:3be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 14:31:55 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 14:31:55 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v12 02/13] net/tcp: fix selective acknowledge
Date: Mon, 28 Oct 2024 17:31:32 +0300
Message-ID: <20241028143143.1807305-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0101.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::27) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1b226a-a761-49ce-c305-08dcf75d458c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dg1CA1xqPpQMof4otVZfInX04sdJD3DXwSBPxMsp6oKT8Kzrk6GsxkZqYWh5?=
 =?us-ascii?Q?Qdqr+LtN6jHgf26AktQYMyl+57UvL0cqkD/BuhAohw6XsBpzWMd1QBCKERSN?=
 =?us-ascii?Q?Gk6nYolJ+/n1dtXfK8+r0J0z82i2kd/wwlpxAWh2TmPz6TCQHaHSUTwOPgGl?=
 =?us-ascii?Q?Urugqz2Qxd5cfs0AXEaOmjkAPNhCkecBEveQe5wGZPJojW5Szi97Y5/EHhRy?=
 =?us-ascii?Q?ZAmbxmXbsmrbInW6gFWQ1VTabzdO4vsgirnR0VWyOvuZ9zKu74a9n6FBFzjW?=
 =?us-ascii?Q?IifqKwQEArsHKVx0xlH5LgEVAXJBbwpCE9J08f8lLIZknWOTXQ5QrWIMDTmI?=
 =?us-ascii?Q?rJ//igY/WdiKHkadQhTij8ohck0uLe/XxKkwreqjEpH2fCuzhzdh2WDCe5TE?=
 =?us-ascii?Q?Foq9bWQHZMpMCD17nhS5hUbJjUhYgHuclEfSvA75sqZ5yYgzikzpJuHpCTAx?=
 =?us-ascii?Q?ojcaXAF2a9cxWqKgHKFFVDiumyHjIPkXpZSf9W6C/wCZBc3j0NJUWvT0P+CM?=
 =?us-ascii?Q?23Czsfjs5DTEEjFKwfgE15qw3zi2jT2fBwfZbyXYCnZRKJxN2L3MYJJfrJbH?=
 =?us-ascii?Q?Xvb85UoUx2dk6r7zyLZRXjms1I/Jy4iyPmYfnV2ocZqUQ59FtoeD5lQiI4l1?=
 =?us-ascii?Q?j8G4f9cHr4hRDg5lU8g2p7GlbQ2p2ntgQ08MPi7iCU17iSaiERvPFh3TMmbV?=
 =?us-ascii?Q?Msn0K32aVm85wAo1Ft3rb7qw+NTwtnXETTL6iRuPz2AYpkj7Qgy24OjDd0Jr?=
 =?us-ascii?Q?XGRdm55PK49odtjFWl5HaBkEeFFnNXqoR3XrJZwlHfxe8Fylaf/ApjEUXlkh?=
 =?us-ascii?Q?01vqwuBn4g9YPLZF94OYRy4R8grRXgwORBRqeodfWRXrsR0RVjdWv/PqYanQ?=
 =?us-ascii?Q?aWfoL7iWIRrZuMp2QGOnpCKjv/W0xPMjZbXho4wrmCVpa3P0An/jpt1Cik1I?=
 =?us-ascii?Q?pvm3eMQHTXfDKk9lt9jYd2q8ADsczxV6gXa/Xy1A21bsQlx1D/ag4Bh6WzIM?=
 =?us-ascii?Q?TiF9z8tagzfioWL8D0leGvQ1uTN4aSfAYMRlvDLW8gH2Rvz6AxlrlQYsVMEs?=
 =?us-ascii?Q?qDC/74iIi0zE8JBP90a7iMM3sLJ8ugViQNA/ux5+MAruzIIaoM53ALw4SU3k?=
 =?us-ascii?Q?VM/ka3L8W5OmcWIiE+I6vmp5pIEby0Mc3uP8489HuQ0ebhSBA83zGb7N6gco?=
 =?us-ascii?Q?mVVN8038es+/3ZPMnxJG/OPZLGsdjumt7KPvbg2bP51Jrqr3YSSvZv1VWQVk?=
 =?us-ascii?Q?t6fRlDnNiFlfM/60JG9SxwLNtO9rTg1JTbhJ82SKrpj/UUjIz6Uk3J6ttuPb?=
 =?us-ascii?Q?6g9GGHzOoRkDSVu5TSsrN+w6QiQiXmGz5U4CumugrtB19lV/+VStCxhTWjmc?=
 =?us-ascii?Q?dhZesAWJ+rgy6ovJ1z9XaIXrP0Pk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EVf5g64gPj1Hdzt8tw/C3hjs9mneOs+KuYkB15cKwLPu5+Vc4nFnViVVkwzn?=
 =?us-ascii?Q?SDk0syAKFx+C3mO8/sKdJDURG+TBwbbAYWyb5lYF53gDfD0oWgFPnFrGVv0d?=
 =?us-ascii?Q?MLHgXjZpIaPTVuw31cylCkHI2BOCOzN9nDKv84YGvHXKSOoymKOk+G3EKfwP?=
 =?us-ascii?Q?VEF8B1uwh+unbNxJPFl2lAc+rrrMBe1G3VvNFG4OkRF0zW1jauwJiRJl6Fgj?=
 =?us-ascii?Q?CZvK+loKUHtsijO35Kg3WvSmMPSx9homeVWBD0ooD+4J+zfQFQ9qCXKuc8FL?=
 =?us-ascii?Q?X6CWwqOqmTVQ9JeH4gMPrYKxJgyaU59ph7eM/0a+KEAWyGLEg0z24c00LC7L?=
 =?us-ascii?Q?BYWPNYaiCpP7EAKDgj5lLE8bYKLjMg1tClMPMTlHpWRH+DOl8oiFtcVcilpS?=
 =?us-ascii?Q?u3Z+bxpkreA+RtH9+zrcBKJL/8EnhBPnme7NDEGdg5Gd7mbAWimdupbK0lEH?=
 =?us-ascii?Q?uCSiPGhA8zVu+XbPCZOO3S7m8TZAoQijvQeYI7iPmbWtBpXvNKBxaQNYFnyD?=
 =?us-ascii?Q?0fCPrsZ9L8Gp5XmSqHc6y/JTwKqk3riOgERlPox8fr0qZ/A9JMZovdCGbUG3?=
 =?us-ascii?Q?wDjSrnqPQ8Dko4NT/JNwhj54L2hbuMtbaWzJqjfr/ddpWChJ5EkyNI4UltSD?=
 =?us-ascii?Q?tjThwWkK+22Mu2rsxlm8lVESfFDu5j7xp55kse1M1DBnNkwiZd1GsQr/gDKp?=
 =?us-ascii?Q?rBobVYrzVhTsIFtKjA0LmfC+VtKHUK3yPDxhHyCzss/NW2CcGHA0enRxqClh?=
 =?us-ascii?Q?dY9oEQzou4q8xTsYwDo51EFH3lDSfkxFpmSa//W5gvi8lSZxOgrdW6f7ogbg?=
 =?us-ascii?Q?Ls+jXWgxcP/FncZNROu+Y+aJi/6FZeK21zOXlAWcJfe2kLP7aU5QVawEnRCT?=
 =?us-ascii?Q?saXZp0r/MzUN0ZyU2GsOYi7rWRP4wRYM7edbLnrXB2JGBpwd59Sf8I8UA+1K?=
 =?us-ascii?Q?d00pt0owpWqDkhMoFuR0wZ8OSct0TcukM4jmiancfjt+WecGrHV4TmbqTwzi?=
 =?us-ascii?Q?AGPsiBvDzyU0ReKjCKF6VT5ZKdAxePBJojSke+2gLapr1WWMXVAANTIHfWdQ?=
 =?us-ascii?Q?ZcxdelVLTf7GWK75k5B1IQeKlTmQtRY/3KvtDNbry7BEOXS5csgOCCeJ+ZAi?=
 =?us-ascii?Q?YvBtrhs/sJ2NWb23aFuLBFE9eBZ7YDahb2++PATnwh5xqajE9T/nrmbXczch?=
 =?us-ascii?Q?WC666+5tf5SK8uJTXvNtDuDLdDq4spsCNiOfEEg6lhsSyfOVMXXcPRdUlZfR?=
 =?us-ascii?Q?cxCc3vJH0/bA2gYqdSkoazleOhZoTDCUsY3WQURIW/dFen5yDdVgf9r7AR4E?=
 =?us-ascii?Q?w788XaeQP94SsCjstHdolnmqw/QrQ6eQXAXKcs6cBwJgCeXVsILhcRZOYEGQ?=
 =?us-ascii?Q?stw81eh2XYKe0COyytdzw4c4ri/MEzq6GwM70I7rtXbL5puuLDpbrzZtXNrY?=
 =?us-ascii?Q?iVTPn5hTVoMllR5wTiyKpvVxi++hBYiOVNS+arW9CEqzsS1HdfvSh/kPqPxG?=
 =?us-ascii?Q?L6lcsJXaHZ2yo3zVK1TgMNcluulmz5VIlep03wqUWM+W0TObJm2UMyfZPDDe?=
 =?us-ascii?Q?4oFMc46d4xfOrSMuA9j5zXhwsW+5k0lerouemIpP7NVV9rZUycyJvzA739fh?=
 =?us-ascii?Q?ChddBWlk75l4SorrqNeNq8E=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1b226a-a761-49ce-c305-08dcf75d458c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:31:55.2114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqmVs+NmPLmfdLyNRrTOSLKi+4/ZdN7jbarspyPvU08rAIbqEhQSF7go0d/TsE/xtLdjqJCipfsepJDk52YgPri8i8wi0r6MdO3bfV9qEos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7714
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

