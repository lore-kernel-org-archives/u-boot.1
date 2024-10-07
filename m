Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EC1CF887C
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 20:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45F3788D9C;
	Mon,  7 Oct 2024 22:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="jqCbuxaq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0749B88D9A; Mon,  7 Oct 2024 22:56:06 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::729])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6612E88D25
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 22:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QE5rdlbw32dnIhMGJYxb7ko3In6yICO3tvEM9WRkw2CdTfNBJeSMzD2d8/KwLGO2LbfZC0U6ZdvMJ6jRng/YTj1OXrbrpA7vZRNyeHgv9BYcLRHeUmKt3mGdrL8sjgez9stMtveoZhXYYJq1Dd5HyVK99wO1gHQYTxZS5d4H9vftiJ9dYc3cWQ4xtMJa/kz3ed4buxb9+9aINtcbXC6KpdaD1lFzCrF3vB7iO5gj7Vo0s2kF1nwCCvW8E4mNw3EBAlLqwT3dualjuzMWUsetfegl7hlDVCWxDG+M3lbaAfMUqgNvxx6byQgtKAOKEUPQguOk/WxnTahdwUaJKQy7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1W/OM+rApXuK7t+R9S3YJe3h+F7fm++LQERW7aZmpA=;
 b=rNcnofNnzLn0mhmXWRkz+LwUv/oT+9Q/cuWnhmrfJVNfyYtK2MBCDTrU3RLvWGL1NYIIYJQfW8ciJRzqbiOohJSP23b+XYTjdnfah1ESDJeAUezzxLkYn57vRZOgHoiTFfzfuC64AiTFNooW7mqn5KfgB/TntXmTlU33CQHWO9ikbfW/GJ0nPSXSK4MqcBG8SdcovKyv/uOyKvw7UPKlzs3LNJoviL1TC39pq7bmd7zgiV13238hld1zXbngvtlSO308FAmAG5TjO0SSG7SKuwuPy03RioZ4zM9QbAF+NP4fdfO6TkHydbaS2Hdv2tBwn/gtBNjjqe0Kpm1WnNNabw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1W/OM+rApXuK7t+R9S3YJe3h+F7fm++LQERW7aZmpA=;
 b=jqCbuxaqUhO697TiQeIRqu2/5Quv+qZw+K4zI7aMK9VaAUIjq1dD09AQ4/275NG/jfgY3fycuzLPRNDWMV9xezS2bh++3TJl0qNl3I8a9c65M+I5q5CJ16Y/kf8GO5ZBewzTYOoZlSNsE28SoTFBWYR5IdCBINooBd0gjMaHUYDKApFfTf5e6Pu4zCe8G0DvQxxDItZmb5HM9WQ2tZbs1X3G2El5JyHl6A6PkCYauIzJsp4x/fyddlzt0uc0gJ9ASDj/rFKSeUhziitctve2l1/8+qTCccjjP8qtEFq/GxnQXd2IoW26arqYD3sn4sEDbngZ5hIPQoq0n6gKjr/QLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB7644.eurprd08.prod.outlook.com (2603:10a6:102:262::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 20:56:02 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 20:56:02 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Anand Moon <linux.amoon@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v10 05/13] net/tcp: rename ack_edge and seq_init to more
 common rcv_nxt and irs
Date: Mon,  7 Oct 2024 23:55:35 +0300
Message-ID: <20241007205543.1632499-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241007205543.1632499-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241007205543.1632499-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0394.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::22) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a86c4e-1fb4-4bdb-407a-08dce71273ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PKu+3jubG0Lr4VFkNMhSrlbo8d9oUc+vZ/ArOvKsGxU3G8kRR9KeSBgqFmkg?=
 =?us-ascii?Q?11NPB3y2Ml+4wHR83dScHi9OUV0QiOdQB5cHyEJvczbKv8Azk8+5PQuYhgsO?=
 =?us-ascii?Q?6zpAFVMHbg4WKn6aWfX2ESEDHEEqSK4KWHwXPn0XhcADMQm+Bd/DYB6YObbj?=
 =?us-ascii?Q?xpFREFhzRJ3k1fhgnI85DyHM1gyh2j4VA9+elZiCSn5epPl5SDSSPdDyXhmf?=
 =?us-ascii?Q?DoSeQBBz8LaGm9NEVCQPw24PoVaOuC+3rJCIRp9busSbHYmfQhA2qJuVMzye?=
 =?us-ascii?Q?lA7CYer0lLe+eClLBKGvOAPT0XXy71MntlJvmlzL6zJ047dKwk1Th2XMvxYO?=
 =?us-ascii?Q?s/Cm1N1l9CSPfg5eVbPQRhp7/Ufxhz4C8kHQuFtYhLK346pIrBAyKf81F2od?=
 =?us-ascii?Q?Imqn5WrqqbtwE/j+4Y7+pHZhSn9UgfhVXNdSILVi5QCmF9FD5lSkXx2bSpE/?=
 =?us-ascii?Q?BICEByAckpe/fAHmXP+7woVeLGmCygfRmhpAbD1oq3rgkF9n3o79qn3zENk8?=
 =?us-ascii?Q?gwTzf3NaMEir3Qw7YE4nhvCJi8+fGyofQSt28z/fwBBvXo5LHraZu3TslF2v?=
 =?us-ascii?Q?7qr7IcyS7cKXFA1BLF7VzOiUor0aS6iBvH+Ehu4iaUBCOz6g0RuIjgjOQ/ul?=
 =?us-ascii?Q?xvFWUnw7MdJXn7oXUxMn3/hthva3459wyTXIm1rsjR2ji2RMXgFv/C0lFLj1?=
 =?us-ascii?Q?6yNP6uRt+dFzKZ5B2n/U/+0dZR6oW/tUt1VJSfntEQmnHKZAfO+XgmShY6PU?=
 =?us-ascii?Q?asoc8xzZL4ix0Q/Kn7eparm9hWs3ou5LLc2ClI0tYlva5NqE6I89R0wHkYfj?=
 =?us-ascii?Q?TZiPjkjnNArLp9dQL2fahf88y7YXp9sspiHLej335WSk5h5TPE1yklh5FEO9?=
 =?us-ascii?Q?UtXqJsBZuKLUvGECVXchVjdEX0qj1Gyj+MmunPSqwB7W7vhGmXOQFPM68xzQ?=
 =?us-ascii?Q?32yfLa2Eu6ZkTGX/wialCD3AUKgHSesywoNXX8Po10d0cfZcIoS9oI47wyyp?=
 =?us-ascii?Q?eRDgOSn+0Ew+I7EAvuzRG9xiVoC2pP3/yi6kh9h1ZuqwetG6l0yOTBGk0bYd?=
 =?us-ascii?Q?FItGIohbVDBHc1bv1qhX0OmeyLvB2qiJnQFv/UtoF0aqCzfzOehfkVAQ6S3e?=
 =?us-ascii?Q?Sc7bDem4w3fMvGOTd3DkuTAQe0Tg+emScz5CnDK2GcJb6pUBbOuhoHVI/sOs?=
 =?us-ascii?Q?iYLXWsY4xeweDI+sUAC3Aq5T0a9nZUfGY5ZXcpf/vux0VMBhh6/YLqddMtU8?=
 =?us-ascii?Q?ywKhVBZ/9UysMQUSjo/Uw0eLVmcLAwgsnuibnmJotrIvkivYmcYpg8MHlE+i?=
 =?us-ascii?Q?bJef9x2sVGqYsZ/3T5kl/yg1ZsNo/dAbSrnsXD8NsuWYRA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DPa4I6XiNaeOqqX5hbn/IclQlyg4lmV3QiXmERHLOX8XQG1RwLtst/9asVLM?=
 =?us-ascii?Q?ush3ocCYnv2dPHfB0TzErWfYrz096SvRMjKdcbOe5W06KijKHVx4+1XieLDw?=
 =?us-ascii?Q?o2C0MX7WfwHiceiaKxg6m6hyMd1bILSlkV1wY26Wq66TfvbF+NILIJFy414s?=
 =?us-ascii?Q?E3rn5BpbI6s6EUy6Hm1Ayqlw/W7iczSwQxSjUJf9dDjILBSJ3N7TPma/HFLJ?=
 =?us-ascii?Q?wI9LvgsRBddvJ1G7Ww6cr7TxhPM0eUn1g82PGXtRrsfdoqZ9R57AjurWN5Dd?=
 =?us-ascii?Q?XVZtFzGdaLVWUiVm1latXBr+5KGCwXV9/a7lJsLPvA/O4+maVPDf1eQiUZZY?=
 =?us-ascii?Q?Nn/d+4ZU1ptx+6GaOE7z0hsozapOjsW0qByyYh4O5xAqCHW0kIC/u+wngon1?=
 =?us-ascii?Q?0fRPb4E1gxAYikqMXa6tQHxhcA9p6SIEaFnAIWHT7vNrB1/r/Dtq65MEIB69?=
 =?us-ascii?Q?03EY123ENpXw1VO+ATHNi+f2RYJ8Guugj8jfFIyPgk1AS4c4Ch5AiG3yiIW2?=
 =?us-ascii?Q?8rdojgHI1voio9j12KAJEEvZ1JCtp7iGEkUSi6/virbCHPvNYpDZicjeWcvy?=
 =?us-ascii?Q?o9A8ya8+W9FoYu/5CvG8uMa0oTXn3d2aI9IATwzQhmy4nrXSmNtU6NotjTlS?=
 =?us-ascii?Q?GniLfKSezkeuFXFION5RDpsCeNM1GCC12exRAdjZW/7rzn/gyKczzw/36Lb1?=
 =?us-ascii?Q?3D/iMWA/nJ2Ta/YGhztBAWege2fsgxtYWmZ/6FBYDLyj9f4I7buU0LP33zUG?=
 =?us-ascii?Q?MDcXc0urAtsVyiltz5Zd9Ax23l6nHrcU0LPUwNtZaI8uCwvdgeuw++oy7BQP?=
 =?us-ascii?Q?iFbqEL1Vh0DL5nMEpx4UINkL9j691rMAWdTckYAPW5fAP1FuBvwnLPi+saKe?=
 =?us-ascii?Q?F8ROw4Mw4uz7M0K+WSh+KkXL7rmIsL+Aj3hloxZzVfjmM/eKo0onyvhKgNSN?=
 =?us-ascii?Q?7SfmAgEXHnbXkaG1ztm1dqP8dhw0st2jHzkrw8CBro1eVHEDZBTn1YZ9M8I5?=
 =?us-ascii?Q?gv3r9RG3W+6lA+lhxKwfn9pOmBklSAyee50CZokk/3YzzSaCFadeHWrgb5eL?=
 =?us-ascii?Q?HfqGMiz9pX3ndeFfd+a2MNWUuBZK4Z23sq/liGI1DzOzHTv7mqAjM6xMWOCt?=
 =?us-ascii?Q?gISUrGU/jlqTOp2/PQu5A2gFEHQWfkGSN8M09xViFiaebVTkX+PSb3NHrMev?=
 =?us-ascii?Q?E+6xXqtSokfzNAItF71k/0K6y3+ifx2DsUwhbAHQhmbMtV6bEp7hPoO1gxtG?=
 =?us-ascii?Q?8ghmQQrZtUZOXwKSKcQE8F7RtYc8TIIwNDWoyCG692llqG8dXerzX8AAWfra?=
 =?us-ascii?Q?w+BDAUH17ygq8uOOY9v2NLDWqahNsILE445JNW8o6vQso8jXSuZxgOhWAaRc?=
 =?us-ascii?Q?vHG7PQFBNLnHBZl3c5GIcIKkpR+U0gTWkjc79/lZa4oWnDCTWFV1hJoen/gU?=
 =?us-ascii?Q?Ku5TriVeGpUrWAqPyZ57dKMz/HuoSBylQWdXlfNniE3Wfc+qihzc+pp+vr5W?=
 =?us-ascii?Q?uLJXLfnCuqH/mL49CNGojqNuMx2s3Zs51DLAZzM7SvH8niit+XRUCLuhgTK/?=
 =?us-ascii?Q?tOEqw8NAT3fGSBIFP77U3Ld/KbpixzhZ5/uTl+IeiliBjXC+qEoRIs8VEoHU?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a86c4e-1fb4-4bdb-407a-08dce71273ef
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 20:56:02.1523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVOFoHgCD+qNs21fgyAt7ksxBcTorFU+UtP5n3p7/E5dpwwFfWsmc/icXYRtMoIgsDBLFZnQA/uaMeARpg+aRo7+c91aHboF/+nsYKAMIu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7644
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

