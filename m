Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1791FC3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:32:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5712088A11;
	Wed, 14 Aug 2024 12:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="I5hQgeR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BD8E885FA; Wed, 14 Aug 2024 12:32:18 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24D27889C3
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EG+M8XdcKuNAL6Lj6SvTGanbjjob2jbl1gjW56tPS5LZhnjxANLXXAADLax4FDJRSG8d/4VQ3/lOJIyNjIB82G9lnRCL3jvll5/FdB/mpBclJmFcuEVvx+zGRzjm5mKBCka0ewaJP+9FHq0KnQtUT+dqiS05JXzU+fGdVAUz4zIQmIcUFiuujuK9Dvy1OhdtbkEvmU84sP9VH+DkppvNLPNA0k1ZKJfS3Sz4AenbLj0zjs35hZXPJDPSBZzyirslGCtnySwab81FPmhNVF7xTRTCZ5J8vbg1dUC/ctJabgcYgZoaeJqUgUGRcMkGbiEPVqwbMvWrnbobgUcsLWPrdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BXXh/0iWR2mIkwLJSLn1ApC3gFSPJ77Lkgt+exOdvQ=;
 b=Rh9UovhFUjn1+JoSSJv9vx7WWrYt0sznqLdAPHV+t2N3frgw4iFtr0LSX0CIQSt8kf/56AJPUEKP+qL+2jEsdjIaDFd1g95q/oOTfn/kAo7r7diHEW9zEmOhGiK957ANeHZH8blE/XMZ9dj+JT0Ltp4eObyaZJ8dD9OVoVsUlsWJi7w+Oe5GqMbG9dPvOWPpiSFiDmeSE+ofRX5+S9jGLU2NWPW67E/Y0FTybMLgVOSq4U3Z/pytynE9l69qcVd1NKA8weSqCJqa9EE4IyJc69aTY1axSdMn1Dt5wtqGT/9p6Pc1vJOBxTFqOC/BaTU+fRN9PZqpg27h+zfelf21dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BXXh/0iWR2mIkwLJSLn1ApC3gFSPJ77Lkgt+exOdvQ=;
 b=I5hQgeR36z93ZNANmixFxYrL93+dZLt00D8na4PNJVm5nH7zk4Gwo80PQH90F+sERGVkz3HpMeEvwJ+u3k+eET1yck/ZIa65gjYyJD+pmLRdmBTON3WxVIHUoCanUI1YPh11PZlS5txxUfZuyvKFCy4PjHLLmXg7vPG5ARH42WqQ1TleKFS9ugFsWvxvS+U3Sah3K5OGJbJeS1BoQVgXE0jffa47+mPvxoH9eUEHGSyQXWcLupPBmLr+lBYkzg46uDhlQhV3SfoX+ur5lciJIVQWUOe8rhwIXm4jt7l9UR5kiZT1f2bqnyENE9VgJk6H6POayTt2X8KYWACkYcjDJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB6284.eurprd08.prod.outlook.com (2603:10a6:10:20e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 10:32:14 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:32:13 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v3 5/9] net/tcp: rename ack_edge and seq_init to more
 common rcv_nxt and irs
Date: Wed, 14 Aug 2024 14:31:41 +0400
Message-Id: <20240814103145.1347645-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0030.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c69248a-0510-49f3-f05c-08dcbc4c5c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nxBeYt2IqRQC7prrP3g8akAfEOE5hB2IeSsC16XKlLDYk/0/GsXsicbD3QZJ?=
 =?us-ascii?Q?+mk3V1G6uCrqIAQD2oQHp+Q8kx+dWtRSAPFXxxi5rBDhoAfE/Ww4BYotBH2l?=
 =?us-ascii?Q?rgQKQHYjVpOl0+U2RcDC+8DuaElv5YYzz9OQIU7H+3Y+d0Le511NofAE5cuX?=
 =?us-ascii?Q?AgJOR+Dc2NrcEz2TXKvXtSFGJuP/7Ny4Cww53CHRd56Tb6/cBtbqNDVes8sD?=
 =?us-ascii?Q?zR1NghRh81voEUffbTxQpj+mAbJUXzZHfICt8vy+b+hrSOM4HgBu9gx+Xe6z?=
 =?us-ascii?Q?egAPKSJEF3D7+Em5wJK53vuoVNnTunpDriguRInt3KNpi9bHiLWcS15+Qx1q?=
 =?us-ascii?Q?mw4N4q9neNYDUSDb2K0ptCAGMVTMKaZ7KOZUiw+YxNqvSPfEV5zEJLBnKXlC?=
 =?us-ascii?Q?JtAv7/QJtlguRMiubId73OMr9dvJgIctoATrxPTQHv9cQuGEICaNmnxPutRn?=
 =?us-ascii?Q?jbTAmCCb/ohauMyD9gcXss5hH/uurX+GcLcduQc9Ubgmu+slzVTnQqnTeSae?=
 =?us-ascii?Q?wAs92v8RaSOG+zw0uVpGWwNwvv/B1OuvHbzxWVvikCSE6XUTyUIOTJDoQh1/?=
 =?us-ascii?Q?ohaTzZStgZL54O96DdRfoLgVHlVRqyyb5j30pJCgA+sSR+yvooqL+S47XI5/?=
 =?us-ascii?Q?WS9JwcTyaMXjT7HWbVz1QlDCRftPQ1lbM7xq62UFPO1o8DN7qhp3InJe/v2T?=
 =?us-ascii?Q?Lha5SwE+Q+9P0ZEmKbG8wUzRg3Jb6RNlbQoiNa3lKcjDShgGa64YWy7fmPnr?=
 =?us-ascii?Q?bjALUctctsV7w2KrHtKEPiC9eYnwC3M5qXMLQnyHcz8NaXytF8NVSssdxtlh?=
 =?us-ascii?Q?+3EymLvJ8QwgZ1y5Bwk4B25u1s4IyiOnqtvppFHSNqR7MUxoaDHPeS9jI8PI?=
 =?us-ascii?Q?5H7OLIESMeEOZLXC8UPE0IxvrjQpGRMgAiOxSqmYW5Kju/srI059RFAL/2Bf?=
 =?us-ascii?Q?NKT1Txz8exWA7pgvkUxguPvUbe3IqiiJbzzoY8JXqQ6JbUhtMwC7LnicKTvf?=
 =?us-ascii?Q?EKhjymHrSvwKBTyBPa/u0zt6nNQ/ay4QaEnU0mL7hdn/NOFR/ZbUKFr+ErGh?=
 =?us-ascii?Q?vxOyTWYixMNDS03let4NdwCkSINBwdz+gsutG3waG0Gqlg5FtyW0Q87XXsLB?=
 =?us-ascii?Q?1vEGM47ziW3tIFYV4OYgHMrDhwKRmRrejvxoIU0QccLdysMVL1wClHlTdtAd?=
 =?us-ascii?Q?okRg67DNFJFT6OLzDvreH8uKKBk1eyu2AMhiirT3dYA3yuqPdDJ2dA/8LWf9?=
 =?us-ascii?Q?gTGu9ou17oaWYVxj98lr6EPMVZ+dTHuSmjdfi6maDFIukmlLC+6JXyaedXB9?=
 =?us-ascii?Q?SfvltNhu8a98qrkV43FSydGIIAgwyF4qZM81wPy9Jzlf91N1MVfgruYMJf8S?=
 =?us-ascii?Q?fVRxFQsaVOlWjAzs7Xw+b6Katds9iT+Z4BK8yvtpaaCU+olwJV1Dwx8UjkAv?=
 =?us-ascii?Q?EjWn83i9Dvc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hnnBapYM1jA6+wO8PHa5nnBXigMPdCCO3WFtFHffoguunYmxV1hqKoWbprwj?=
 =?us-ascii?Q?ALaHNoc4f9VKVbUdFzjoRjRHAJVy+ZGziPPt9PZNhhg629/79dPdCEbJgFpI?=
 =?us-ascii?Q?1jtpGDwD3YTp59qwl8VSWcONs7fXDNoF+VS7c6HxOe6hVndDV5RwDUdhhtRd?=
 =?us-ascii?Q?qH1MH20Uo7TKCvYjc35m3eEhRYljQekXnyMkEAt39nTNRbykI8Pg/f6RT8Kz?=
 =?us-ascii?Q?nj3yJNUQLGq684rkNqGJv20o9lV5DpeRr2jylAQyJloOUy5SUFsx550W7MHC?=
 =?us-ascii?Q?dtsj8xteSE/98EALyWojdD5yfEClzcrZvbmNCjZImWx6vSKxAjVsjVjQRPEd?=
 =?us-ascii?Q?n+Hldyg5pdxL7w+nfGMbHTcArB9DtHikROKwtXEmwHH7UnjeW3sf6eK+aA4Q?=
 =?us-ascii?Q?oMXTvVMaCI79qlnNWJZgbWTevw1vbKmQ7FPtBsgM9MprHDcMj83pa0hFz9L8?=
 =?us-ascii?Q?7mNJvRS3OjKO+KykDNu+W0wThShtpugQo4KcqleJdBH8JTQFRrsSPJtwp/cs?=
 =?us-ascii?Q?yiHwPcnzI3V3nevNAF1tsPT4ZHXj95C0qokbuiQykZe2sqrzGcUlcdJH8UXa?=
 =?us-ascii?Q?v5cTzPCZgHO2uFxKIRic02VvWn9ZZwzlcIcaZVVEcePGBeif7oy+/fiTCuFJ?=
 =?us-ascii?Q?0H/WYshaIEFaik218ge83NtrsT4B6YyL2vYxSlkbo+mZWRKYUgfzWXzEChQN?=
 =?us-ascii?Q?eYXgDd0vvW2MmVu75n6lqx9HhH4lfULFs9aaCZrQPurI3sD9DNFGikfSKBa7?=
 =?us-ascii?Q?nJ7cEjHU4yYXLEUWe8sIETY4TRy3MVWDH9bBuDGhpP302gx8N+Umk2xAqwD4?=
 =?us-ascii?Q?WG40sdbqeJfTFCCtAjDXoCZ8aCsg0hTKt0oNMeBc63XRoeH9JIfxDEb2zctm?=
 =?us-ascii?Q?r8YzlhkHHNzC650pig+WPfee9TFZOefGdcDIBawJgP4U6+ov7jHUYiyQpHUg?=
 =?us-ascii?Q?O7t+Zw4j6FLxasGAwqFG0yuyUyYp3rIiyQhIFRiUWG678Yj7bzkecVi0lrgX?=
 =?us-ascii?Q?3b2o+qUwus1ZgJ867oJ9h0T71UzksyoJID1lt0zhfnE1WnPzy5/s4pHp+0eU?=
 =?us-ascii?Q?wKtoECFhmI90c6A74swlWqez4c4V7RlBy3VPgpFjjWDKGCd5F2o8TOsnQy4o?=
 =?us-ascii?Q?VUSquVdbWSwLLVsWrMlIBuRN8bSuHyw4E5I83vG8uQdZP+1cprznq6ns9l72?=
 =?us-ascii?Q?GUiReyGS3xo87lJsDlZ0zoRt/w6O9xi5V2uutdnqLzJIouFMdvyQQZ7zUvj+?=
 =?us-ascii?Q?OWe7lGVYe9Wh8BCH22McCK6xN2i7c+HGr0gwrZK2KYOyMj6zkXuHWfiUwlva?=
 =?us-ascii?Q?Hrfp4t6j5nWnhBVZRJe5LCiIzTZziWcEy+hcJJC5qpb1mIi2Svqezj0uOUYX?=
 =?us-ascii?Q?owkgh3LA0X6d2glofPiJUv1yn1SCczwK51BEGr8/fTtyUmM6UNxIrrSSLDkd?=
 =?us-ascii?Q?6XuJhKmuhDEDE+x12oeRGWRr7NyRCZf8oSpuIezKcJ6lpjCYqeDIIBWxYU+N?=
 =?us-ascii?Q?p35wXoXu0ONprxo1UfRuOKCdDWIKiBbrygsp50wKumXZ2YrjlVpxVoewWud+?=
 =?us-ascii?Q?azJinOXUz+LYO62opJZgxueS0G/XC87WnkrDAZelg9Pher569E/C19aIFLBK?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c69248a-0510-49f3-f05c-08dcbc4c5c96
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:32:13.8621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSeTeUh9pYGH0goPWInLq5BlhvaCV2PvMAJkjNJt6AZHYTcRTsVmVB62B9b5jQX4ylN6e1CGPdgpFnGd6r+QDmQwyYA8+yNY8sgoqbw58a0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6284
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
index 9acf9f3ccb2..96d499a42ed 100644
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
2.39.2

