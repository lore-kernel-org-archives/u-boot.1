Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90774ECE57E
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B223488E89;
	Tue, 10 Sep 2024 00:27:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="JXuQ+ga9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 439A188E3E; Tue, 10 Sep 2024 00:27:45 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20712.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::712])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B92E88E92
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRJYstILXp045uTM9jXJZIqeHgldQTnOy48WA7Me4JrXzEiFE9UfrtkPA2o80AfxoEX65JD0YLHvLOEcs4Sx+qdU7F5nfGp1Gq5kd3Ge94psob3gcKk8jkleprBWex5vN2IHXrUwfv74LSlkApT7ZNGYl8kR5elSwzzdoU3ImqIKCyBdXbL9u1GDNS7KU1KGowLeJ5YnDBCBituLK9lI0cvnN65eaEqnK0K+sp7mH2PsDeNKcqGd2BowL147pLMXVgSTgc+2a+gvbZrONYGcwRM2IyaFw/ddjp86kCBV7MSIkahVdYD9FP/rfoYK3I+Rv35MfDwlH1fW1fJQCFfPpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1W/OM+rApXuK7t+R9S3YJe3h+F7fm++LQERW7aZmpA=;
 b=YNEZ4Lq6BoJnyHu85r+CMemo9Q5hE1jGlkopI8dvx9T8yTbAHTePRAgGjVkdFIBecyPG3Qqw+xvMU5L6RO27A4lZIf5qhTHtpxDy1fR+XKVIKJlKymriTBWbNapS84iDnUT0EGNi0O6xXNGsqQgXUClpHAlSPJB/d6pdFpOPZacmLuX4xjiJyusiO1wai9W0Xwi8jkH3DDnG6o7b0RUagxgH1PpdDbwwYtjU3kpRCktkm45WeMs28s2OXnpYpmBjgNdSpjiHYQ7SnBIsyOFON9tFxIjZXnPo0SZtwKyu1xHQFaJfI6UXf37L9lfG+NgnUmxcZZKm0wQrwZAklS6NYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1W/OM+rApXuK7t+R9S3YJe3h+F7fm++LQERW7aZmpA=;
 b=JXuQ+ga9yarl/wMk6higelDrTnQeN5SvnOsvy8aJ5yOgIVsTNNSMQ16NW+J6vugA34E25fihCZWCMR/b2jdwTj4ore2dFgXS2+hg23+gIdEXjJ+VOd9zLzLm2MTmr8psdDGnBmekTwgC3CoouGgdR4si6Ua6otH5HUvf+6cVEZCq9OVDG3io3LTc/3d/TUrQDWTYzhICwRuBHP9/UZ96ggOvIKYTPiF2ICZtDzj7I1a7NMU+XsYgKbTgMn3egRA/ma/aIcwOnDiGdAp8Yz7TGHqFS+eki8pj6Zi0LUWvRUKNg+uUuPS+cz5FxOHFYBeX+HGvLVLKwzV5fufue6tfOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8722.eurprd08.prod.outlook.com (2603:10a6:10:3d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:27:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:27:36 +0000
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
Subject: [PATCH v6 05/12] net/tcp: rename ack_edge and seq_init to more common
 rcv_nxt and irs
Date: Tue, 10 Sep 2024 01:27:13 +0300
Message-ID: <20240909222720.2563118-6-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: deb1e817-680f-4371-9236-08dcd11e9af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vqZnitte78m3Tjj97RHuOxZuZODKyaH03xu4EoRxwdpWsJnolq9KD4gyim02?=
 =?us-ascii?Q?ik4nXm6V3s1zreCCFWVkfiHmhdq+1ooiebBxFW9i9zMlVkGeGQ5M/pQvK+tc?=
 =?us-ascii?Q?rfmdme5sMHO0AdDEF4pQLZUgdgr/zEx5lEZr2nvLH+VhzqZOXJEDQWKj+Tr4?=
 =?us-ascii?Q?fswzyHx9dEc5kfhC2p02ekKvbgAPWBMEUhcokQhopw0dd/MACg6Jj924fpZ7?=
 =?us-ascii?Q?kTuzIokkRVvBxAxx9rRNvtOeLghIflPJgFk0NQxyk8UnHoYyenwnAU84MdrV?=
 =?us-ascii?Q?8PkQu2pd/uvkwfj2T3Ncjo9rhcdoleV3WrGQSnj/HtARg4EzJFKWfAMLfk8s?=
 =?us-ascii?Q?J4ZLEfzzlylWkuL0KV2tQrLiP6+XuyGldKSVk1798nny/vUsXQdGOXkrZsZd?=
 =?us-ascii?Q?QgAOWJlwQXlGG1EkjPQZoBRM2ZwFOegSWXOh+TFDizkpv7ivRTcuB/pGkw+j?=
 =?us-ascii?Q?TNPp9QyM+1mnBtZv5i7mEyzGoc28Tai7n2KiMHGRZzYf6zpgKbzmqudxBSIO?=
 =?us-ascii?Q?MsxLeHsq03WvdP34ergJwNdlDsLHIR5NtRhvlgHdqWKWQkcVz2l/TTGmFjBb?=
 =?us-ascii?Q?GJSBge1GMit+pE2mvM3BYj/dCe1QcNh3FLTR/AQ18Mj/cgyVf5bBvfpoRyo7?=
 =?us-ascii?Q?S27BjadyWoWoNOErkLDKC3It7wleMmaKqFssdsAW5PwCWyyY6nl0Uq/GcX+O?=
 =?us-ascii?Q?j3XMB6P4UoS+eTgbCWTlDxWvMYI224uD/L37/rTZy0Rnvdl0ZykwG6agOaB4?=
 =?us-ascii?Q?Ju81xw/d1CXx0FNBXnt4rXrBNZYF3SWT2ktRjt31GbkLptU3liMAruvKdCiB?=
 =?us-ascii?Q?no+DUnlUYeDjMQgoAMUduzoGuZU/koMN8rECNuk/ug7fvSNhuwHsXhFKmlBt?=
 =?us-ascii?Q?T5JcILLauCOhnVCw958QJzGnnqtzpcf6qHKEHJEiKI01p3sC+rEG7/ZZJqwK?=
 =?us-ascii?Q?MHfEYGx/H3C/+V1EBXy+HFgR6/7krNqI8AtV4Aeee7wfTHelZwPZZmdRtOy3?=
 =?us-ascii?Q?jmm328APPVvJU7UoV/GyLF9UU5Eyxu5TPKu09RwKhrw0OK7eHHcHWBASaVRG?=
 =?us-ascii?Q?Cv01DFZsIaj8ZCXrA04P4OIs1iIp1B08d6nb9FXQf/aDQuNUIx/2tyJCcF2h?=
 =?us-ascii?Q?S8XlRvhRvkU9PQM/YyFJAUpg1Ap+/9ooL6i0XTapBRv4UCKeQWxkhTqjl1wW?=
 =?us-ascii?Q?7KfcjoDMPPtGuj862aweVjmYTnOQ08EwN01gWEV98yO+EkVkGvv5fGU8ntot?=
 =?us-ascii?Q?Lp1gq7UWG0SRAuWsduQAo4GyqBPh3PNNdUanW1MtlsRWgxotjU/p606H8x0l?=
 =?us-ascii?Q?Sw0Jlhgwql3qxcr0FoydxQsySGlrNco/XMt/8as3xKafbU0+m1G73vafE6uH?=
 =?us-ascii?Q?fxB3owMx/oiBl5sk7/ZSvvQcarKtGXghN3WAX48bsg/9GiUETPwPzi+M5aTT?=
 =?us-ascii?Q?xfevGXD0h4Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Hz+XybUe4eQmeeL5yL+k5lNk43vyNaw/3jvUifeqikhGLdf9EbRbfNYpU9L?=
 =?us-ascii?Q?raXJm7EVhnZXpmS4V8XlykzHRcQLZ95mNtDutYAuoIJkhOGnSDPap+u5ESdr?=
 =?us-ascii?Q?1sqz6BrIffNvQJFEK5wszw0RBWxRjnrOm8H0sWJK84wgRZXtnYUNGN73akhs?=
 =?us-ascii?Q?jtfBzoy2ct/xL6WUNlSHKS4apT1aiVd7blgm0GP5LBKe8wTi4qaKTK6R0Mqx?=
 =?us-ascii?Q?3xBEcSxC+gDkTZz5LM9mvQsygaYVNNtKga/ZATSG/Pcr06Zfg9OaPWYr+5LQ?=
 =?us-ascii?Q?7g8D/fIt5S1xuWgLa5wgP5oecIaZNh7IDZNO/wYen5xo0ID0B76tIuyK6bpw?=
 =?us-ascii?Q?1KG03fOV8SEh22ELQOH44kutZdlpEhugq/u4FB+M6/nAKhcp6oQRCA7fRPdv?=
 =?us-ascii?Q?LCul2zouPWSKSLtfpZ8Ay81VUhSL5/VjZmOrg8IIyDpqY9Pp338ZCJGVeobW?=
 =?us-ascii?Q?tYrIAcgO75wAdkKtuBvdUAjYAKsdI0pPaoln/MDUmeJ4zTeYkQk8V/zNytA+?=
 =?us-ascii?Q?BtOm3y7Pt45E78xs5RW9re7ZnQ7W0ubraS79V92bG12fpWS4TBsBI2N0rxB+?=
 =?us-ascii?Q?z6J9i7MuwP2XGSLGXxU8pX0osHObN0IxWU1aFgsXErI8pDZV339qD/Dtsvka?=
 =?us-ascii?Q?h0GjwNWrfOwD/C9m0+CF1AsOHXTXKLgICihDXi60yQtnfOpRr1OZx1gMV1mI?=
 =?us-ascii?Q?acmveXg5HbbbVMfp6JHt+T5fLXnrnv/87CgG+9k02u37v0lvtomtHKKnE3+9?=
 =?us-ascii?Q?+UHVFLJMhUb7Zof94cZgCj7oQOXDYB6ksl+LqVux/XKTm6WsHmt8WGQh0KrX?=
 =?us-ascii?Q?syfdDH48tP2pOqyCA1JG7m2vt726H8/hK1nXMtRkmYEZGc16yO66LOVh332q?=
 =?us-ascii?Q?yWO9DtGnk7Khwnw0hNdtc5HoXk0Cnoy9sb1ZCdh3gqKepOzdsWS+nm78yiHV?=
 =?us-ascii?Q?eqhkM9Exy6KZ45zjWzczISAEDd6IMAkwMaTywTN4nNVTLTKbC2nJzhOdlB0+?=
 =?us-ascii?Q?+5B2xgHZH4IkiS5JlSaSaQB5tw0F74DETZSPW9kY/zSktIhxyo1mA881ZMA5?=
 =?us-ascii?Q?gSYQrd7gb+M3R8rGbgF/AghYc/IFw6po/LQWdpnwkNL7RgFyiyqSL8Si5419?=
 =?us-ascii?Q?3sYA2njFUH5BOFCaqHGc/fFSXSVfajMHmYNqQhdWFEMBlvfF19mHAs8AKOEU?=
 =?us-ascii?Q?wN3ffAYYb28kjQKb27tfwNtvlzpXqu1VoxWml6nDA4lA6YMOihhnWgx139mn?=
 =?us-ascii?Q?YepaoXVsJ/+aKjc/TkrkxCcS6X7xG30ajPwwi4NT2PEUKTfYbkKfg1RyM2BX?=
 =?us-ascii?Q?GPyaT4rRWyll1tm4QiR7WsyQOecy2fUSWhzMo9NIW9PPp8I2vH8dHA/VmNGq?=
 =?us-ascii?Q?OS3AMKRCx/gJM4g9FeX9NHt5wzyfg9U4YnuXSE7V/FqQb835LnDyJ9m1Pk9P?=
 =?us-ascii?Q?KA1dtdry0AXgoHEM43JVEct/qcSkqzHyhjL1QMBlE2vOXrMh1DQ+drsDlGrD?=
 =?us-ascii?Q?DMZY30+VOy2uMjW07IVGokFM9Eq/+k6/Dh7qMu12iUx748uJyV7vOa6ZeOTm?=
 =?us-ascii?Q?Les+LUh6p3IiXMjvmATb+Cu9z7er5XkeG0H/C0cBjfWvhZxNSBqB1Owevt7Q?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: deb1e817-680f-4371-9236-08dcd11e9af3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:27:35.9956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBQCMkfoQCUMr+Sn6rGAdoOj0bfSejzcN71VZwAgbf1CalsJp0mM7oFw0N9MZofINWMGDcbv5FesqqSVDU34A02y38ydb1QBPM5ALp+Le3E=
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

