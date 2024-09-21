Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61D2CF9C6E
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 03:44:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B44A8891B;
	Sat, 21 Sep 2024 05:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Cjn6HlsM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B42388581; Sat, 21 Sep 2024 05:44:09 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5308E8863E
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 05:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKiK73hP2nLIDi5S5cz7QnHgSydm5UJJg7mnC/YpZDrgJ6UmkAJyxd1TDEA0JztjisoWTqh8balVOJ/jTFmgf/Ry4iX1MMhDpsmPbbhqTxbdfzmgwNGwMUSVVzdHj+fOpPflK5BClizqz/CjKDiU6x+qdLhv4zuJmNiCyOTkCHsvGlKEkngrRqWovoPb3ddWeJRVeSEzWugqCQgS7mmmnz3h5rH7QVcxurRIiA5F1SD4KKiGzixtvX2K7YW4Cyu+yNLiBV5ac1+wzQfAhD6Qz90Wc4rbA8F+0YO4eSiwYVuORLDFuyiPhLYUitLu1NXJmk7iMajd5Acrk7lAUGSK3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=gHxFb9IpHPuFGGCFMB2gDOZb7i+bvulPPzj/SOEvT8Vve1OiNot5O9lLBebI2wS3zAGhSwGr0SrQlKTHHwZ16hdcTRAZMTDnDjxyr0fSpTg/c1NwpiGsKaXRQOXthirHj/6RqJU4k9NLzm5S6But+/mRyPeveuB1TpKyAK/WWufv7MMW71KmaV3D9gEif/00W2oh+iFBt/kgX+Hg8QvuQoq3cjqcOtWyX1JX82HU7VjmIzbAfk/eDj05qLst50zRfoTmkuoSrb0ZVIHZ3iSEUEOO8SNWswPoiS5i8iBmJYwHb8W1z3UpvxKu9IiGrB2tkmmbFr5hfFoOZy7vKCkT4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=Cjn6HlsM1K1Xu0i3Vw3w91cvewV+eD4t9y7KyB8wKODq1P/GHu2QTZN0kDSBRgTwldYpiXu0c7Y6xuojEkvLqTz59EO3XNmDUm9OsxdNNoigIEvY82xR9SalbdOsOT1QVPSPuXDxisoSIvGmm1u7XfcC/QenIBtVR9jCXR4F/b7sLmT/z/O8QDkSw9W0P0Zuj5uFBQm9+PxNTwJ4XjoMWePE7zPrbCrD7iwEeuFA29hgDZqboHA9U2d3BybvVMnuLtHSbIWp7eO5moA0Gyuce2nQLa5nCltyAWYvoZQvZZVxVOUc8q6OCpuBjWzQj/pN17kjzS0veAvg43EmETSECQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9418.eurprd08.prod.outlook.com (2603:10a6:10:421::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Sat, 21 Sep
 2024 03:44:05 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8005.010; Sat, 21 Sep 2024
 03:44:04 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
Subject: [PATCH v7 02/13] net/tcp: fix selective acknowledge
Date: Sat, 21 Sep 2024 06:43:42 +0300
Message-ID: <20240921034353.1298452-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240921034353.1298452-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240921034353.1298452-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00004595.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::440) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: caf43a9e-3c1f-4af8-754e-08dcd9efa3bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cZgz2Zue+rwvMee8nFE1E33lPz99IhneAjz9Jg+zwBRB6UyBwIBsh+BUykEP?=
 =?us-ascii?Q?8V/KB1FNqvDquFtnJd/Kk9Lrx8Kmn6TvCvwKkTDyhHC/A3Qjw8dOCOfED1qu?=
 =?us-ascii?Q?4juAsp+hgDNWVLdy6SP6KZHko89iWvfpqLnRfZOCo0CkGvvuhjakGbeIJMz5?=
 =?us-ascii?Q?jKDlgd8Q7np09F1NbkkMMa+tHufw25ydpZvOYN4SD1KbIWK5fmyintK9yzQ4?=
 =?us-ascii?Q?/zi5azxc9AvGekeyo+vfXcWVZOpYJjkGqAMrRI8dKWB9Q7LSql6oWttT1TN2?=
 =?us-ascii?Q?LBff+NOirEjYmV6Gae7ftKxwM60JsgB+4vcfG+OlG6+ddVj5XFjXuXgZpVpY?=
 =?us-ascii?Q?Z4ljfpOXXx/jfXDecY82eLvh3M+r1GDS4mCbmi0a2yOGU90/HyIraqfWrKPE?=
 =?us-ascii?Q?WRQk3e/vslHkeB6Xt3p2BAA8xb4pHwmUhtJVyCi22bjA0VArxVDuY9gOSZcm?=
 =?us-ascii?Q?d9l9aJ2LEjPe02u6Q79DpoPV6y2AGo8QcfcMO8DAex9874hSqPuQFGhfnB+3?=
 =?us-ascii?Q?dpsU5Az7jhBWdPHcXjdPsrePh6HSEPvc8fDtUo/9265zaq88+4TsHFtcGjX6?=
 =?us-ascii?Q?HtnM6wBr6M17C5pgmUwm968pcRPTyW0tpM2Vnb4g4ASTxpSE/g0l/BfvObyL?=
 =?us-ascii?Q?f+JoPiW/UhYc5czeBpJgOVJXDaKg8QcjyU8pgiccAJkNG7zjosl3nnGSmr8A?=
 =?us-ascii?Q?mU1T+u2CPVlF//o5ZV2fauaAnJLa2SIogDwRyILAIpxifebY5LmTqw53jGEY?=
 =?us-ascii?Q?dyFlGsMMjospn6e3XK9nliJZIG5vdOfpBkbW/UD/7Yio1qA5ma+fPktVVRgz?=
 =?us-ascii?Q?Vm3WL6pgeLBiJiOaFWSy9zY/SYxU5y4jgd6fhwjBHNjQKBkofpe4O+qf2bXE?=
 =?us-ascii?Q?PnPOSqWcrfr2j3Wo4xCdj/sn+JtW6tKo6JJkr5XDNNBr3IrmmGjl52ZiP5c/?=
 =?us-ascii?Q?8UhBnMj+8BaMNp40VJv3C+oEOQ1q3LMl0FCQpJKtTFucbFRsjKgPjtrV6H3G?=
 =?us-ascii?Q?aI6H978ySYEV/oxGjhH3m/NIzUrIxATIZVSJ0gUhtZAIJ+cdVzCfRa7Ze/oz?=
 =?us-ascii?Q?1z/EKgIoYXgoJ5GG225miA3f6XS4vwOKm/UVdh6F3CE24qK+bY2pygrz08ru?=
 =?us-ascii?Q?sXmhLZM97Rv6EGkj0yJreVk2AFHLrAAYukurOLkKwz/WN/Dep11m82QsnK5n?=
 =?us-ascii?Q?naSt9SADfuUdot2zcSq0G4M36jIPizKdCaSYrCdY1dCSYSAvWBOsJP35wY+i?=
 =?us-ascii?Q?8b+a3U6jHMw6PJZOp7nq1BmBla5JX3tMc1ISXhXUbYjVAU+FuK8mGjO4fjd/?=
 =?us-ascii?Q?jgflBG+810I/pmKDHLULmFxxd+eZo81CdlGM9q37eGB7mk6PEtwnke9+zYd5?=
 =?us-ascii?Q?uGbwdN4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yi9A+osCzQfKAoGTlZxq4qUILXj07cUNmsfqfPHo+sNThNlnL49Xl+AgF/my?=
 =?us-ascii?Q?rANTJCBJKWFqtmRevp52OEDhD6OQgMxHrg9xI28BuEAbZ6jR6BMtvZ/l6ZRs?=
 =?us-ascii?Q?cTsWUgXAuVLqqDtb8p0BxhlXmmxHTY/YzM36FOVY70IHdzzKopdBYIALJofH?=
 =?us-ascii?Q?oVlm4pGH9UJoEO0TZf9awrWxgyhe3ugi063UcrG3jPglo9MBDJq8hS6zYSga?=
 =?us-ascii?Q?a93GYtG4nvMKGtGo/Hyzambh2QRsq45Y6C4zYSAsAVJ8qTpNx0FxpnpCxp6K?=
 =?us-ascii?Q?Rt/ALr+TW2pmam1Nw0b2reQSKuSjdl1YUbltTFB0nQtaMO8diD0odHnF23uL?=
 =?us-ascii?Q?EcEybJzKoJnuMrVs3Fm3tKeiV2FtsTjX1gFgqAtowpJTtTxoUTdQn8tZzyvX?=
 =?us-ascii?Q?5tAkTgjtYb4zAo7rukewshrYlweobg8a0jpcu9Ub/nULSG1smXhXiW8vkYaR?=
 =?us-ascii?Q?YdeU8gWzpuhI4QxJGnp04kCQaTj+pu+hknfwgPJdXt2jCITrpoJr+0KfbWWZ?=
 =?us-ascii?Q?/cjBmumld8rCZosuIsjTfih+YQbWY5xmK//fSKgh7jctJiA04FTfPNB2QYQx?=
 =?us-ascii?Q?Dk0m0rlSGo1iwdE1aWBWnY95V8jJEEGqxaQeoSiFX7hIY4Nlo/PRHKfT537M?=
 =?us-ascii?Q?LT6o1hEqR5tlO4vuAmZ4xo1fQyDbiMKyTYzHcKq4afu6Xd0jdElRlNPCQv41?=
 =?us-ascii?Q?aMPn52lPZdIdt8Qm7PoVtcx5fK8mYqSTRwvTvs8LCl1VsG+R2yBuLAhIDZh7?=
 =?us-ascii?Q?ss8H2GY/Bx0mD8kp9JudsoTZSyUHQEmYA6RD88Wv/n7WFpskn1VNl6/82usg?=
 =?us-ascii?Q?UrmD0ixnta2xaKaeIFlDZ3X6MgPT7z/xHIWo6nC9cVpIsB7HB/e5GXTet/si?=
 =?us-ascii?Q?SYPaf4vD0lOsH7HP84SfD0m9fnDTj8FEP36t9Ge0Uz2MXQiytiaiSoa3wP7B?=
 =?us-ascii?Q?oNNViuVT2EAdoAvolhUk8kBiAJdBKW+CEZFe+SgWUzhoahqL1fqMg77DqHQr?=
 =?us-ascii?Q?RcBGBETogzUnTCVE5cuf1F9BQydeEqm8C91Go8usfiywJUcyBevS/8j9DKjL?=
 =?us-ascii?Q?G0HUYd8ezdLnhrV3bl646C/IuFgkjhs6d9ISCnMeqZoBXzpmAWfEswqqokAU?=
 =?us-ascii?Q?a36CfrN87q7s9wIuZHb5wxEBr0+uHEHkAbkrzUJbT0VXCphwdBg5SKVRvN9h?=
 =?us-ascii?Q?JbS8B3UTk9ow5dGMPWPSDGgZ4AoK3VtFjptg+DfdMWAKj0ii5H4sj/Zeu3mA?=
 =?us-ascii?Q?FUnCwoZS4QzWDtvYGo2FR4Fl2jJjTCQAA/cfqHIZPPSdW/HkO6khdp6WX+TL?=
 =?us-ascii?Q?zo5Liw5eaody81/4tU+vdEM977lh3Xyj7mf1tC0iXIe/Be7qybNJ2foPsf17?=
 =?us-ascii?Q?26mrRTAt2wkX/nEs/c3BzvXFx16f60u7nunM/mykbDkO082tZ+2DWCbt40Qk?=
 =?us-ascii?Q?9SSMvR8GBvCHVCBvQLorJ1LxDDUHjGu8GcYat6Oz+XaZWA7ykncHlnED3aMX?=
 =?us-ascii?Q?1pRyeoK598xGVjbrqHEiiMDPvfFQPvfQFoHSjIoJ6RTJghGS+HRp1M7dVhkA?=
 =?us-ascii?Q?7RKhYlOK2L+oydEXo4ikM2OyrpvPH2i1noxkKNQ8aJcIuLyFOTbKUSa10eYR?=
 =?us-ascii?Q?u73xI63m50V6/XMSCMmxQpQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: caf43a9e-3c1f-4af8-754e-08dcd9efa3bf
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 03:44:04.8848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llB7Ind0IuwzzR2JwOQtnVHAqScMeAZsORdEHEUlCLoDmW6ZdkHnJwIxHZJOuu4cxyUFG1+7n8GhtPxVr+zHa6KjRXK6HRZBS/38nUIIQhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9418
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

