Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739F6C5472C
	for <u-boot@archiver.kernel.org>; Sat, 24 Aug 2024 09:28:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CF2288CD7;
	Sat, 24 Aug 2024 11:27:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="X3kjxoA0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E67E08890D; Sat, 24 Aug 2024 11:27:35 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::72c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CDFF88C5D
 for <u-boot@lists.denx.de>; Sat, 24 Aug 2024 11:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQwq0VaSQpGtMrZKlC0kSUGAB/mYPGB3WYhCpE1h9JsFTBGvspNM44KZqfD8SGFuGN6nHRNfO94DB9oqLYLr5Of2PG1SMKl4DeEapaD2yW2NmHn3ZiYzizug1+lDlSfEPAclXaw1xDtubslp7lor1U8fXlGpmKGfG27sm65IgJSdwqw//5tYJgLJeZOL9x4IMakXImeXhHXhHk+Ttjb0iq8GsyICocPT/7yQrVL9VDBqRCclG6M9AqCqSPMq5ezz6ga+0FLkz4b9fES26ged9lesmv/4ObJd3SKde/TY0yhJCwUbxvzWeO8+HwXzYpZ11nAUcpHbDEuGRJiz1vPWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q00IswGxbCQx+1nod7QJu/ZY0jy4fSWCrsbK9hkN5WQ=;
 b=Rj/rruqKyNDaMD3EFd/oaBP2y/LS9UfTz57jnmHHpZKikvfCX6EN0gRCgwj6N+q0PH/gU6tOZwSpsa6kaH6mjS9Nyez7x7Bnm91aeZUkOCU3Hd4P2GGjmvYPjtm0UmaLznoukzNczIHdvT647m0yDiXKiudQLl1f2xymzH9NhV9zx7ufeRYLDrf55rZsuPG/yw2wvjO1636iBz1U85ZTKZPNML+iZP+QV7sgZhOKkx7/KxPUtPpbBmN48RsWZacqKaqU6KHOkPgbUk5nb0G8DyMTqEzYCKnGpVOgFqj+WkdUuzQ9JnM7+pmm6QuOnEQLXe/gAeX+qFZy4ThRAj0S9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q00IswGxbCQx+1nod7QJu/ZY0jy4fSWCrsbK9hkN5WQ=;
 b=X3kjxoA0AWau5Nfn+L0JGS8A7TQYkvl9nhTTnTbobOm3iO1NLvy1hNTEGg1SfqmJdMWTBUX1TjAJomLQj9avxhQsJonoS0E2CHioG9pYgVNv1BhCDhSigjtZt2McwnoN5XHsA3DMmfp5jtC1lsHGVN/p07xf4nZky0870BUv+xzdKz5acngZYX7FQtwx7apaFVmiM09zkEH8Kncl5xrzw3OY3DiamWUjVU1aZKKmsWqnu7NGRYH8f15tm0+kiCHtD8CeoLnd0XYNbWTJOVs0bwxNjuTEpfHm8wi1J5i6+MI2sXQvp29UUg79z9HrjZkzjssXi2aeYag3nbUrz+Eyew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS4PR08MB7601.eurprd08.prod.outlook.com (2603:10a6:20b:4ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Sat, 24 Aug
 2024 09:27:32 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7918.011; Sat, 24 Aug 2024
 09:27:32 +0000
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
Subject: [PATCH v5 05/11] net/tcp: rename ack_edge and seq_init to more common
 rcv_nxt and irs
Date: Sat, 24 Aug 2024 12:27:10 +0300
Message-ID: <20240824092716.1042696-6-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 1e90aff2-fe42-4c37-17d8-08dcc41efb25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7TthzctXCXjjgsyWeDk+lQEXK320nmtfHfNWX8h6JtYLJpgVGomOlzjfKXYn?=
 =?us-ascii?Q?AVDELMWlYaZBdeXcfJ9pCQyGhsI21eXQHA4Aw0Ph5oeCyPo7dseFF+/8NJB4?=
 =?us-ascii?Q?n1j5h13hWZoAIKSwhcBvO1BkOkceP0IOD7XUumtSfcaYT2ZT3u/xnoCl1ZCl?=
 =?us-ascii?Q?v7PBr+xHkf8+QAe5KDu/IrJs5uJXe5u6sUdO7SzIQCc5xTK2jCW4py5aCQaG?=
 =?us-ascii?Q?jVNYMgUA9++d2aaRCm1qjJ3EzqL+HyMUPx9lb/TyQN7G0OV/3s6EqBTswr5M?=
 =?us-ascii?Q?h3/19fzwO8rqDvm4Bn6mjVC4CmC7OQI5jw/p7MsT3z/ea7lXzjfOGwM2bYgN?=
 =?us-ascii?Q?2S31kn9N0/ePIjAq+xIR7zLUhi73BnqxKcV+q7h/jEuqa2OWM1fh+sa7QRAS?=
 =?us-ascii?Q?D6ZOppASO9bVew48/AzxluScIU7EcihJdUFyx0M83wBAv4k+UEt6W1l7xskA?=
 =?us-ascii?Q?LgNm/tP8eb1tbHT1RrCaBJ/AyaiGv41US+dcoKSjnNbrciXAAWWBC+ZPugoq?=
 =?us-ascii?Q?pu/Hb6xl0gjAyZTtZ0jFhYJtRGZTZdgpGWlEZmYHqEElOwfgay1N5nnsh5IF?=
 =?us-ascii?Q?8Zf/sgospwMqRascwI+0x1+wipZb5gHSK4Yo1OVIqfi65HQ+7vbxPFCeyPqd?=
 =?us-ascii?Q?41gOQlRrQMIczyLQPqT0AdSBEtSoQc3ju9nRNY352ox0XQUID6yI28VBHOsT?=
 =?us-ascii?Q?5A8gRhI68CPHIacNJN1pn40hTtL5AujqSBOvgUZyGVB7X6lj88ew/H7j/DGh?=
 =?us-ascii?Q?A4Uyb4Y1U8mKXQrqIckIwv3ElpfgIdEsiwbuJobjZle14C2ijokc5M49U15n?=
 =?us-ascii?Q?kFsGhigxo+a8EoUPq+sdZ6YPS2ejEB4ovBOPw8PYeVGytB1M23s6ql5ZkGhh?=
 =?us-ascii?Q?CTQWF4dLwqqJ+uCfCqpXrWoQ4/BkpKbpp8su+YyVdWTv0/u5dok6RUr0p0FZ?=
 =?us-ascii?Q?4r57QJ3SU6QnJUbbFpHqVo0NERmh/pMRqsEY4oCxLSgim35zkC5CKb/z1MKE?=
 =?us-ascii?Q?qgEps2stiOtiNKhMY0ROIdXa2rW8QbGTfAjYeFLtkzWzczGQorjKpJ/i5+YD?=
 =?us-ascii?Q?hvatODf0gSswfp+EpncAwl2o89jS/x48bkJCmgipWSWshXd400OLkBoKWrjb?=
 =?us-ascii?Q?Apyzi+DwVY4YAhJawNQXqdRePkjjZ0oRM5AV54/4JXJcubQesUS+az2ey4yE?=
 =?us-ascii?Q?faAOYr0IC9VwubtL/FUSQah2q9/p6yj/XW1F8Qj4tAbXE1A3qY/MjppvQAIS?=
 =?us-ascii?Q?lh2xay0Y+85KU28s9RN5mdefm82f4OggibYIjstk5DzqanZ+OU+z0bEn6uRJ?=
 =?us-ascii?Q?DCmBKA8fWaFYrkGQl6a7tVTNjyqE9TlpHxRGMpBvsJWggMQETAQAiWGvFbkq?=
 =?us-ascii?Q?TRiiVUDJTdT5DjXPN56IxH3xNGtOLJCcmD3pGSkzt1YaheuExaN+wyx8dRL7?=
 =?us-ascii?Q?aYp848dZVvo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y4TnyDeTkkjfjdETTPkqbGi9YiyIRcC83MNkOMhDkk3GYDEIK2cfdconW7vL?=
 =?us-ascii?Q?+P1GYdGIx8yRLcW5LPybNtuKknSUGU8OgIiC7ZovDa6uVxGLsZhs4Aogc5T9?=
 =?us-ascii?Q?kHEmUxK6a9lDErZa3uVTYo/oD2eCu/GYT0rty+r5/QX7UeYxIb/LS1qZNLWB?=
 =?us-ascii?Q?fqZlq9wCKV72yTy/UYABERMpyHr6oSKQLYYL7k9MFxEJzn8gNfkdKzoVTuLs?=
 =?us-ascii?Q?rpaxyoCHYX4R7PbGL3R31y9ZS2rtrwC1YxCOXNhR9ic5j0+iRqieplvPABk0?=
 =?us-ascii?Q?9JvYwhARJ5a7R5QnyOKlfXKIyuhjXNrWz0P0M2P1cpdVSsbG6REYT7rOZbE7?=
 =?us-ascii?Q?0lUm4VtutW8JJGsicCjWZmIjFrpYMXJ5aIQ0aC4Ratvn2YemLofIRMbttxQr?=
 =?us-ascii?Q?BPyneaPRf0/noxVDRQP/09tdONcBkjbnHXOWO5RdGqLMxJrrqqypXymao/1A?=
 =?us-ascii?Q?PKl20mYFwomzFJC0YKiJWX4kCagPiP8YnPBCUc0/BtQfk01wpxwF7f/4O02E?=
 =?us-ascii?Q?/0/y0J77pxrfOZBc9LyIHzC/PAVmXOMGnvsgwLx05eMY+Yu9hyRgZlfYG0uu?=
 =?us-ascii?Q?MaS+AiGq8anb1TCaU4IaKp9TLGV83QrbM3i0w1zK5KN/ixFR3C2mxtYZdVzb?=
 =?us-ascii?Q?pbTG15U5QxEeoMnDr3SLuLWK7Lak0sdJzDuMMV8qZ535ZP01rI8yE/wVyIVC?=
 =?us-ascii?Q?5MCbfMG/OrSk2eC2QuSjt83GUvJsrrx/09PT41HyE+HR+kHMh6ZdZCvezVpg?=
 =?us-ascii?Q?zs+juKFFxaTixuBWESsVtLftvR3IQ+0a0NbiQBvAKJqXxukW4HPYcqzNpb1l?=
 =?us-ascii?Q?Rm4duf5r9myzJsaS6lb/gBvOqF6EHiVpzjFV5HqqfU54aIpLVaZzrxbq0aU2?=
 =?us-ascii?Q?yA0mP0x8YqeRZK2v7XWwJXYIgd1973JHU6433yM6TjPcZ4AvE5zhAQL+PdgZ?=
 =?us-ascii?Q?afbo+wBhV8SvYMBqOPD5T2N+IjsI+aN1qMA5dUUpBJ2j9mOZUeAUmEAf2WED?=
 =?us-ascii?Q?KEn4YABtXGm0gWibg9Mv6oNYirQTF5+wFa8MMSaLRR0Svv647M+5/09emHq2?=
 =?us-ascii?Q?A2Y/FiL8bo+Sk34BvAtP4RrdZuB7xnokb40JX+YlB8xFpHum2VoQQR5eB2Vw?=
 =?us-ascii?Q?WjzvQ2ssM9+yruETPb8sECA9gB180vS18Bgw+HuwBLy8hq9lEfoC3HRCF4l8?=
 =?us-ascii?Q?kGQ0VYIYL4+Lh4pzkF8YLKI0SXZ8LzmAK/sxyb7s/DKhZ1IJxSrM3znpElVe?=
 =?us-ascii?Q?weFYVKat10KnKNOwUNL0UjrkpnhPTnG28ft4DaBmH24uzpWT4RVDc/e/WSsy?=
 =?us-ascii?Q?8fcHouJ8chiVlcLLYZjaX/t2f5Hse7OVhu0jDk+YFK+8hQAyaCxuZhwHJuio?=
 =?us-ascii?Q?mGcKgFli7Kq6/3v2dG/0DWA+LyfPd/J/llqGMoR46pJv22sQtuvzF2r5rQ7A?=
 =?us-ascii?Q?BThEEBIW2QKM/ImeSQXntU3d3CAsTxSSHu2DxtgaQkln+df518MykEP/OQi0?=
 =?us-ascii?Q?JTHBGy1QgWJl7hhE/kGhzfKNfTe7GEUbYXPTyH0RNM0o+NUqtB8liCaQRiqH?=
 =?us-ascii?Q?5A1ynDjZVOSFzZCgLB26N9MdTV3ybKu6/2BxXvOEjL3OZAxyasUS5tnN4i7M?=
 =?us-ascii?Q?IipsLbMkD8P/xdZlm7aWJMw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e90aff2-fe42-4c37-17d8-08dcc41efb25
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 09:27:32.2811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wK7M0MLubTP8S7wIyKO/rHGUz19Vy81SsxcjdFbl8RhhoV/TYb6a26sJ3H0+Yr9sqZbko+Ixbwtg3raHmucsT1xxpmiMuSJl57a6u8bHi8=
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

Use the names from RFC 9293

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 include/net/tcp.h |  8 ++++----
 net/tcp.c         | 32 ++++++++++++++++----------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f224d0cae2f..0694af9d5b1 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -285,8 +285,8 @@ enum tcp_state {
  *
  * @state:		TCP connection state
  *
- * @seq_init:		Initial receive sequence number
- * @ack_edge:		Receive next
+ * @irs:		Initial receive sequence number
+ * @rcv_nxt:		Receive next
  *
  * @loc_timestamp:	Local timestamp
  * @rmt_timestamp:	Remote timestamp
@@ -301,8 +301,8 @@ struct tcp_stream {
 	/* TCP connection state */
 	enum tcp_state	state;
 
-	u32		seq_init;
-	u32		ack_edge;
+	u32		irs;
+	u32		rcv_nxt;
 
 	/* TCP option timestamp */
 	u32		loc_timestamp;
diff --git a/net/tcp.c b/net/tcp.c
index 0c32c5d7c92..7e445eaffd6 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -360,9 +360,9 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 	pkt_len	= pkt_hdr_len + payload_len;
 	tcp_len	= pkt_len - IP_HDR_SIZE;
 
-	tcp->ack_edge = tcp_ack_num;
+	tcp->rcv_nxt = tcp_ack_num;
 	/* TCP Header */
-	b->ip.hdr.tcp_ack = htonl(tcp->ack_edge);
+	b->ip.hdr.tcp_ack = htonl(tcp->rcv_nxt);
 	b->ip.hdr.tcp_src = htons(tcp->lport);
 	b->ip.hdr.tcp_dst = htons(tcp->rport);
 	b->ip.hdr.tcp_seq = htonl(tcp_seq_num);
@@ -396,10 +396,10 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 	return pkt_hdr_len;
 }
 
-static void tcp_update_ack_edge(struct tcp_stream *tcp)
+static void tcp_update_rcv_nxt(struct tcp_stream *tcp)
 {
-	if (tcp_seq_cmp(tcp->ack_edge, tcp->lost.hill[0].l) >= 0) {
-		tcp->ack_edge = tcp->lost.hill[0].r;
+	if (tcp_seq_cmp(tcp->rcv_nxt, tcp->lost.hill[0].l) >= 0) {
+		tcp->rcv_nxt = tcp->lost.hill[0].r;
 
 		memmove(&tcp->lost.hill[0], &tcp->lost.hill[1],
 			(TCP_SACK_HILLS - 1) * sizeof(struct sack_edges));
@@ -434,7 +434,7 @@ void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
 			tcp_seq_num = tcp->lost.hill[i].l;
 		}
 		if (tcp_seq_cmp(tcp->lost.hill[i].r, tcp_seq_num + len) >= 0) {
-			tcp_update_ack_edge(tcp);
+			tcp_update_rcv_nxt(tcp);
 			return;
 		}
 
@@ -463,12 +463,12 @@ void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
 			}
 		}
 
-		tcp_update_ack_edge(tcp);
+		tcp_update_rcv_nxt(tcp);
 		return;
 	}
 
 	if (i == TCP_SACK_HILLS) {
-		tcp_update_ack_edge(tcp);
+		tcp_update_rcv_nxt(tcp);
 		return;
 	}
 
@@ -489,7 +489,7 @@ void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
 	tcp->lost.hill[i].r = tcp_seq_num + len;
 	tcp->lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
 
-	tcp_update_ack_edge(tcp);
+	tcp_update_rcv_nxt(tcp);
 };
 
 /**
@@ -566,8 +566,8 @@ static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
 		debug_cond(DEBUG_INT_STATE, "TCP CLOSED %x\n", tcp_flags);
 		if (tcp_syn) {
 			action = TCP_SYN | TCP_ACK;
-			tcp->seq_init = tcp_seq_num;
-			tcp->ack_edge = tcp_seq_num + 1;
+			tcp->irs = tcp_seq_num;
+			tcp->rcv_nxt = tcp_seq_num + 1;
 			tcp->lost.len = TCP_OPT_LEN_2;
 			tcp->state = TCP_SYN_RECEIVED;
 		} else if (tcp_ack || tcp_fin) {
@@ -583,8 +583,8 @@ static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
 			tcp->state = TCP_CLOSE_WAIT;
 		} else if (tcp_ack || (tcp_syn && tcp_ack)) {
 			action |= TCP_ACK;
-			tcp->seq_init = tcp_seq_num;
-			tcp->ack_edge = tcp_seq_num + 1;
+			tcp->irs = tcp_seq_num;
+			tcp->rcv_nxt = tcp_seq_num + 1;
 			tcp->state = TCP_ESTABLISHED;
 
 			if (tcp_syn && tcp_ack)
@@ -633,7 +633,7 @@ static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
 	case TCP_FIN_WAIT_1:
 		debug_cond(DEBUG_INT_STATE, "TCP_FIN_WAIT_1 (%x)\n", tcp_flags);
 		if (tcp_fin) {
-			tcp->ack_edge++;
+			tcp->rcv_nxt++;
 			action = TCP_ACK | TCP_FIN;
 			tcp->state = TCP_FIN_WAIT_2;
 		}
@@ -748,7 +748,7 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 	} else if (tcp_action != TCP_DATA) {
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Action (action=%x,Seq=%u,Ack=%u,Pay=%d)\n",
-			   tcp_action, tcp_ack_num, tcp->ack_edge, payload_len);
+			   tcp_action, tcp_ack_num, tcp->rcv_nxt, payload_len);
 
 		/*
 		 * Warning: Incoming Ack & Seq sequence numbers are transposed
@@ -756,7 +756,7 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 		 */
 		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport,
 				    (tcp_action & (~TCP_PUSH)),
-				    tcp_ack_num, tcp->ack_edge);
+				    tcp_ack_num, tcp->rcv_nxt);
 	}
 }
 
-- 
2.43.0

