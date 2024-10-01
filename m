Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153B4CEACF1
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 18:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC0AF8928B;
	Tue,  1 Oct 2024 20:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="qLF4CI5I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11E348927C; Tue,  1 Oct 2024 20:21:27 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20709.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C0BC89274
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 20:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cs5zCh2hZ1c4EoVoe0tOs4+Bq5O3SzDvEHH+iRVECHVy+8WmpujnpkcgEyTRwzS9o7YCGGrLBe8F+M/ojB83nX4N4YdajAcBBPGkAMoBNXtmA5/jD26aLS1GLSj+Up2An2LulCl2O9Hx8FYkwQeh08fdd1fsegV0Ysxsb3dbGgBpeGNV3iua4z4xn349Sy9D7AJcS0s86slOtJLxDonDl4c1zu/rgnLgLFfWFhMv8IcjTmjwulFF38ZO8YaQmewNiZRpgfbUFzZYguU3C+ZzviqGxUyGUMurIoQU2Bmdn1b7xw95otc3tPc7Xgob2HVfG5VjexLJHu9OUgeWyc31oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1W/OM+rApXuK7t+R9S3YJe3h+F7fm++LQERW7aZmpA=;
 b=vT+plSTyIImOV87UITkyBNHulDLUIOuJ5WLJXi8j+lJwP1lnPYPI+w+mLpx77TTaI9vLaDVxqljKy1sWLowyaJjGDmnuv6/dAfmV4pSzhm4cFLiz4CwfxuM4PaJX2cthqH5iBglsAPUvJv37mSJ1aKYQ+M4CfmCIP8AUJxfjaYVlfBormt28FoPPWBgbbXEXMcBGrdy+E2W1Q/RrZuXcM24Aorct0UmkJX9XzHXB6jg6OdEvZ+u5XXvE16SzEnMgvt7iWb7jIgoAWY3vgyCyMbfq30kEdeoIL6MLW0ZDef8zwiP6Q+mChxAK48cnKGhGUMUdHGMz7O2kXbULwfs2GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1W/OM+rApXuK7t+R9S3YJe3h+F7fm++LQERW7aZmpA=;
 b=qLF4CI5I5l1pqGqYKS0ORKa8mlyrz5s6fcnQ3Vn2SBtnBBr/pgjs1RviAuiIxpKnNgWzIxKIhY20Zx5OOjrXAJIQw6JxBF2uARwFzettNQps5ESVie3zPcAX/OAsNprkgupSS3Br5nCePCH5OkQPn9VyN0UF0orlXakj6Odav3PjxR6iNrp2ZZVXJsiuUksagFJhwuYVi/77fcU+1c1OaYhlJyB02cricwcSINwCf15l3ESVZ3CTsQK0puX6B114IcMmGXJ5ywtg1e7pJ5eVttObaXSdBBNAwLtRyoP2A69FUEBH3/w3ThmHdFuW4E50tmm6VlgCnwqXz//IrPYZSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9153.eurprd08.prod.outlook.com (2603:10a6:10:414::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Tue, 1 Oct
 2024 18:21:22 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 18:21:22 +0000
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
Subject: [PATCH v9 05/13] net/tcp: rename ack_edge and seq_init to more common
 rcv_nxt and irs
Date: Tue,  1 Oct 2024 21:20:59 +0300
Message-ID: <20241001182107.907828-6-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f96a9d-8217-437e-871b-08dce245da7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EAABgBup1iPC79eEkbub6D31No/TVGAY0HSuQkKVXWoUrG33QWlWD/qsgZG6?=
 =?us-ascii?Q?h0DP3gDHZhITHkVrzizQy4fURI8HNJEPTR/Uojwy/C2bGiVOTuxGL416060W?=
 =?us-ascii?Q?P+zMbxQ33vheW6yxhUakxJpM884nMp2F7MrkJoA+163Z9eIu/R1jN4U2n17b?=
 =?us-ascii?Q?xhXpJ8CTtR+wE4jhvFekMU4xRmmavwiO2JU+0v7LhIJgIzNGXGniahGNqgoc?=
 =?us-ascii?Q?pXGWqIhi1mfjFUbbsn31eNJQh3Y5i0bDO+xCEu6vUf3O6DChbtPoURGdVGNt?=
 =?us-ascii?Q?jQl7xkfo3T182Uufq5MHpS/TWFfCCfZCk59VWTc1uTk6xX0wPCg2RFeThQwU?=
 =?us-ascii?Q?UOpdJdO2oLESAy/tuKjqLItWXMr9xSIlsxeSFLAdzdClj/UkCR3PstJ4BeKI?=
 =?us-ascii?Q?QNU7jer3l+ums3P2nzLpXEnMrj/nC9uFrWdbMkY+rX8e0mlqZfVbtrRMELsE?=
 =?us-ascii?Q?DUuzsuLhmrSvG18Osd1baMppgAYYBRLIa9mKPoHf1wDzqIWcs/aVlehC/Gn2?=
 =?us-ascii?Q?MaWOFWn4lkxrsni6BULfW0BD+foXEbozcVETN51tX9CFAYPgttbjo/haW8VP?=
 =?us-ascii?Q?XZW9UJgGIw8uk02LEGFhkIjraYjZ9qh8e6PVc7pfQQ23DJSOZqunVL0xxDhS?=
 =?us-ascii?Q?dBnJkEGneUKrfRBZVvY3xc+xs3At59zPDNBBog4dYKwyu3ZMfhGuycBeANRA?=
 =?us-ascii?Q?dEgmcQcxKsjPkWIbHi2vHk1+ymDGvg2bzoXPJKgVBWb9VDf+lBwej6Ri28mH?=
 =?us-ascii?Q?XIrrAq4oyBSuaDp8UuYEoWpCOljwEX45tm6D9bBlOVUbDvqfn+IrWbPbqqTz?=
 =?us-ascii?Q?46UkAWrDMu8kdqyMFiSP1fKHHjkE5NNf4//sImgQEC4Syf2pbZZgI/RCi+JO?=
 =?us-ascii?Q?/8+jnsL5r7rSpiSXgjv8A6MgLuL6ZH9a/2ZgIKmR8VJ26PDbp+u0Gi8VPf5q?=
 =?us-ascii?Q?HRXxXMjQ4qB/CPAO9P4W7v29NSpdtRn+ydPLUMMGbZQ+rDIrc9CXzvmSPBxx?=
 =?us-ascii?Q?QMuMU2bgZnKIs3dh+gFt5tOV7zNNmNQj1aSZIW0ljOMEBF0mL1+jYrn4Rsvw?=
 =?us-ascii?Q?7fuZJ3rf8uWByXw+0KmYtQEwDfSxXqNmsBQ3iqHMUBBfe1lRjrhsPOVYNW4t?=
 =?us-ascii?Q?qw3WV9kE1Es5I0pib1vD2Lo+3dQttMjTdkOPn1A780hkfIioSvb+NmKUke+G?=
 =?us-ascii?Q?JYhO/8wi/yLuCRhslk0qPC0bFoRpOFl84nLAP6DAisvWV53gcfFXP0MIj+lC?=
 =?us-ascii?Q?+e2tP6u8lcUDhzeG/Uu5CbbTUQxYrv/CAL54XiYqzz3AuCC8tTriuwIcj+yf?=
 =?us-ascii?Q?LqYg6eFumaeDLcaMQ+uWgXWgQbtDIVevok6gyeq6N5f4BsApaD7SWpEZ+u1U?=
 =?us-ascii?Q?E2ucijUKsDFjf3iWkVOs9jHAjbIje8D6MwLETwsNqND6g4LgG6ZxodkzsOIS?=
 =?us-ascii?Q?/vm/GqE9QVg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tAL/fen2Yiel3G92ZWlEGT8SXVKNohi0Lker/sBTo0WsFJdmiW5VmwGzWjcm?=
 =?us-ascii?Q?4OaxVfSuHkSN7IezBw6Mp2POtxvasDqkV3gch7sTnE/WgINTAnCkWMX5h/iV?=
 =?us-ascii?Q?gUigBFRsxWZUaa0RRKkLFJi5MOKcap4Ym4+aFGqkRrVdcBJwp9WL7QKCA5we?=
 =?us-ascii?Q?HB9dzWq3sWwF99lqzpTeoK5e11Z/ec5WH1W0w6DA7qE8op4FsED3e/tSfUbr?=
 =?us-ascii?Q?qWbVQi6LvKS4Lp5VCB5uC9NevQoGMQsbX9D//JaO3klaGUAypd/cZHKE4rVW?=
 =?us-ascii?Q?HwKj50A8mFBU2b1u9rejIaRI0UHeM2JAIWHqVMSlB5Iit+I7pMaR/BWTZGgA?=
 =?us-ascii?Q?TxUtiHBkKgxyJdm/OQqUSoLoLjypVuOUQt/it/FdGOCItYdOeALLrFOcTQzV?=
 =?us-ascii?Q?Ot82cUXKmCuKWZALdrSZ0ueMKNjSI0X7g9ngc+66l0LJgPFpigkxKQ/knUqe?=
 =?us-ascii?Q?2Ypujoxy6z49NzjF9ixsuiiC8+ZrZOpEU/rQwrwxU+bYHlczzX7sJZM0mMPk?=
 =?us-ascii?Q?PIeankEmMHcmiD2CUgA97wSpfVVfwTVP3tN5GKVNtXs7x43kZfki0WqqqrH7?=
 =?us-ascii?Q?obqqPkVGKyW8OQq+mg50vNYLy0K/560gQCrcbOBGc8yiWevLASOklepIETpy?=
 =?us-ascii?Q?fpceY/H/2gT3c5sDnbHba2ufXnrIbRvS+PWGLcf7zWTGVsXZy6DlGXEtksHS?=
 =?us-ascii?Q?dO2vnWLXuQVIs88pKqe1hxPl8ybSEdKLcTCtPg2YXlarGuBPahaNvllQBygJ?=
 =?us-ascii?Q?wpxyqLDwsd+K3g1zcxiLD+6c3BcQofYiGUGSJ1zwGyosvtFqnLcuY43obyQc?=
 =?us-ascii?Q?qL2+fd/ep7hQbw1SghEB5vh2TjJTd1npEMe4AAGp4enBh/q+LJWJnlV0pe3o?=
 =?us-ascii?Q?09qBlo1bDGA6hrbkhW4XbZk9ddl3gSNK/19rEiAZJaMn0Fd2riMynObW//kG?=
 =?us-ascii?Q?xmCwKCvh/l8KNBJL1drJOoKVtcvM7UK+GrIZudONS9AXKI5MUTrU/mWdNRXG?=
 =?us-ascii?Q?00zh1JuGojHW9yuj6vrAJFOqMeQ7/96Rv4kAunP1bbtLcxOfMiUhzZWhyTp1?=
 =?us-ascii?Q?P86cnahOJrnwmgVmvVFux6YbldfOTu7emGGDhuEdU2E7MTt7rVyce1dJ/yaI?=
 =?us-ascii?Q?GsXfyBFZxaHzDx8trX1/Pd1rJ77Oliz9uvc0+NvEk2KNrVEG+YhBhomZ7XNS?=
 =?us-ascii?Q?suxRzZb9QEbg4ecD8ujnUEDuerL1H+UmhRnnChsTHHQs7vLvC3nnfkbiX3mX?=
 =?us-ascii?Q?ifbrCZCQfZCIuXpCdjkc5JeciaK20QAeNX4MxJtLwT6Qk6ME4w6FsbhRvnQR?=
 =?us-ascii?Q?BpvqluqJ5P9Gp+V8F2sdWrBLa1zE1dkrVRm4ZhDd17ekSuLQTpLqtW7MKutP?=
 =?us-ascii?Q?I/xMTxzD375iU2ndWjCvsWqblYvt5hlx2BRLSWzOVySbVur0+gRBmzEeNZjz?=
 =?us-ascii?Q?agrBD5GMSzblEUFQGh31TggDQXv2wndFBXQ0EaZeqYNbbg2G+rovDV0UudjG?=
 =?us-ascii?Q?9yKV86zWab+LkXeNsSs5oYFYuvWVoWSI3Th2TIvXzg1eO+grRXM8QDzdtoor?=
 =?us-ascii?Q?YFCkzDEBOcBb93WLR+FZ7voCJ0feY3sFLj5XaEi468gn2fjF6c1ph6jZVq+v?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f96a9d-8217-437e-871b-08dce245da7b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:21:22.7337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r99iguLjBU/oO3MRdD1n9E21rQzEAhLjQ61xgqv3wv7aiDKr8FfZisr4Zj1RUfve95MeMHqXtLiK5wNjf/6W9Rj8PR2lcxbz8j9HtQEcRuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9153
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
2.45.2

