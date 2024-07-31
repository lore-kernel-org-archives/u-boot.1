Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009F7C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 09:22:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B0DB889DA;
	Wed, 31 Jul 2024 11:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="MVD6aOww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05FAA889D4; Wed, 31 Jul 2024 11:21:41 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90B6A889A8
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 11:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3VeaK1gtWu+Wc5nX3Cv82WAwHmLC1xj+L74Xde75ulqGQye/SbGuxuAc/RAixgowibkHM1Cq1r6SqqEdiCoOlGBukvUzlNozT1F6GzOK+kvQ/dOmsR0Kx65AJKj/2YFdVGrAZvFfxjcXFggCD5BWFYmmabEbScdpu2ou30W8JROHwVpHCCApnF0baviYZl2/McOc8w8uQ2a39T3qpDQRlIge2QY9OHIVTN66eInZPyB4le8kGMWoys1et2F4lVcoSD5l6dJqICxDd8H9e39ZNpxq5ah0LUI4x5aBvzx4u9gkDew3HHp++ioy8teL/b1HDRt12QlQwzgIVYWAo5YJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdk5HzlBwO/qGkFvpGywFHaQqYZ31i4xmXZQv1+v89Y=;
 b=EJmBctGUWVnAIxbVoiNziUIsg4LLrG9impQPHFWORIe6PpfzmBF+Q7egt4c8RF0/y/wIklSPC2wh2j+HcdQXHfh6WsRKInjpWgwi0EUVBQvVo0OQYyi3AzpGe2NhEsWdE0eidP4UuRstfTASx8virexPh1/uh628C/2exJYKXuTO5RhoW8xZOM0hWLV1tKXiGnJNXSr3gpc4CGkvQlSblLshSf/l4RWEWZe/dPt4/vWTfk4kupwqdVaS4PTzs1jjgfmu0+lMnitiRW9Bse696RMsOD3lKQiA9hiVKECSeH0g4zOHFE7XOrLDNoYVaMzKf8bXJp5pCT7BXEL0UlmlKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdk5HzlBwO/qGkFvpGywFHaQqYZ31i4xmXZQv1+v89Y=;
 b=MVD6aOwwbSRZLvJS97pqcLM2Ga2YSZAFvPLk4xywR/+5JHkWbNU4A8yQl70B9lt9ThJ+m3AvDgFXhU3XWNqordg2kjwjsIe/Cyk1UN94dJtULBMp5y+n0r0EKt6BuLv0Tj8EMVZcyDGC6jVeiuATIV8E2osI67CdFZ+Fer1tciYISoHRxfZ4Orfi8K3+vADGOQnJ4Al0ZnixoLqPxIXhQ9pBq0XwBN8aQI59OZBr9+gVu7wX7j4SykmmbBicON8Aij83fxq2EuKvg7NlEJFmRPS+me5hWeKYAcbXRnnCyUyTByQZzkLIlE131xlOMR4A9nwtO0+3Aks5vLa6CB9AtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10180.eurprd08.prod.outlook.com (2603:10a6:20b:62d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 09:21:34 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 09:21:34 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 3/9] net/tcp: put connection specific data into a
 tcp_stream structure
Date: Wed, 31 Jul 2024 13:21:04 +0400
Message-Id: <20240731092110.4027134-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731092110.4027134-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731092110.4027134-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10180:EE_
X-MS-Office365-Filtering-Correlation-Id: eb388bfe-57ba-47d6-dc7a-08dcb1422c07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rOEQ8wzfw42yKk7tN5hUZAOXphJZuRg68AjFqbhJSszeCicZx94IOQyCWGSy?=
 =?us-ascii?Q?7X0z/iNWC+XLME04xBzcoO4z4Zxsy2KDA4Sy6MGVwM/5YV1++BoePijIoLiO?=
 =?us-ascii?Q?HXPFnvd0MOBocmfdQ46Hy4JDpoZsEJ+rR29iUMqmXVFo3tMRge+MiG+bLK+Z?=
 =?us-ascii?Q?sE0uQQHYPEIz+cYs2WJuxT10hbcgLIGI8PPlGxFyxfkjfjFIbgQkOjlSm8ym?=
 =?us-ascii?Q?oWWiR1cNLfxcyirEtDQDkgLwkBIjDB/xRV6tdfbiBStwBPUGqV5udKMVzVHI?=
 =?us-ascii?Q?6Qp/tvuVzSLWLKE4umDOv7yf27M3KZ8xp9YgIBNqk2+XImyERmKReK5FkG/c?=
 =?us-ascii?Q?zIAZ9z3tNBrveZqz2y0eVqdWUMSnCU4dGMRiCQbd/ZStxDffJVL8IWsCqaOT?=
 =?us-ascii?Q?kJmxRaSBQkoFpRFO4R0EgH7evK6eAhNQIcbmiO0Ofxv/XRenKzHh1kvf1mud?=
 =?us-ascii?Q?UPr820tbyuvzTXf9gAP49waorKIaAWbNrUcKHXWpZeRYnMlDmaYqpmLLLkyA?=
 =?us-ascii?Q?uECbUI6+O5/NfCqtuY32slzSde9pJ+lchv9FvvbD1CfcVn6iuSZGw7E7zgAt?=
 =?us-ascii?Q?XFhnM0LXYrvHTQOBvqsMEI+k447MbPOHPEDM5gYXh0zG3GB1VvrCvbHNaxhB?=
 =?us-ascii?Q?moUW4PlObt0d+FrYzE3T8/BhGsVBYXVUblWxORYNWUiNFpWKjfTKPcEdlLTj?=
 =?us-ascii?Q?G0qZh3jwDXbxqzZ5CMARprtswenQ5g+tvHgeXsmNrS375uuvN06FxlsdpSBK?=
 =?us-ascii?Q?AYjgCZJCmjEMN2Q1usteaw/a2vHJO09GpsHmpxSnNhLfT2xcfDDNq2V2P5oW?=
 =?us-ascii?Q?IyJ6uUW3uZUj+LHDWDSrRLqmUiOutCOhknHaCmtbhHf0u9d+uz1uOuqZkUAB?=
 =?us-ascii?Q?k0k1kaP36jHfOyHLY+k7zPNdPDWsFdJWT1njhXedvLeLnEeh2XiBD2fcBL7M?=
 =?us-ascii?Q?Rq1jqggjsI4CJOhlUyIXs2wc0yWo5pCnws4dQ9xbi64DYd6AhUlgg//NRdjb?=
 =?us-ascii?Q?YVWtSgDQZzvPaHg9KCyIBXgaGjm8P/WPHwFDUDI7Vf67GinsEUjYVl9zf+EN?=
 =?us-ascii?Q?cGvVzJkSMhv3NAxRpgciJ/n2heIG3MXugpkQLOkGEv+GkXHBF7OWU/D/bgzl?=
 =?us-ascii?Q?Ru2rfHb9aff9xQok3zO8iyI4x4dL2QYLh9ZHSpxAQeXwpTStNY7ft4SK+pCO?=
 =?us-ascii?Q?ISyVUjq7soj53utqaRxG/bpR7g4NzzhyW8WQzdA1tgApwWe+8kjNOT1eEs+s?=
 =?us-ascii?Q?JpMcCeSNjXdekQwsf+Z+GilhCvoQ38qBjfSTbz7a7nEx1yBK3vxpu4AdP63m?=
 =?us-ascii?Q?6FdPuN1MQDxVP3LBBrS5I3GBuDy3AUulSC0IFlUq0rjWfEg09Pbtz96lTI1l?=
 =?us-ascii?Q?PqPYl/RTP4njqt6clsRdn9xD1qJhrw887J+/AF+nv9jeJuS7vR4daIIqdgPd?=
 =?us-ascii?Q?YQ4m4GA7pZo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gGmQPEgS4AGeRwJJmJgEB3gRfxDXweknHBn4BJojhu3W+dKvQI+s6i4xFHg/?=
 =?us-ascii?Q?82GeKy5M2kzIcDLlPClGsBTYTELbYiMgHv3lq5Enkm2slMYayLm0EnSu75AT?=
 =?us-ascii?Q?EODztghsZzd2lfrXKqT/GphDEbsFW0AlBpVCU1O35lPw0PMjLaSIONeUeM6+?=
 =?us-ascii?Q?Os4NXC3wY7qgU7ROa00DaqhkL3x3Lu6xjnpy3moX+2GhiV2uQBQi6bsGWYR6?=
 =?us-ascii?Q?z7whtzLcTdjNrGXst+j6cnFrH2dyDDVbfrlPUA2QRH3qtR8hVdA5OP43GgAf?=
 =?us-ascii?Q?oQbKppSOIWwv3DrRGZbp8thjAo4zJhz2ElJX8Y8E9oZlXNnRGDOIIgrVmp5Q?=
 =?us-ascii?Q?x9ZWPOXjasDbrq6OKsoegW4UpIQED5Lq3RgQZPPCCk9zUVlZPjOQQRBsUS5E?=
 =?us-ascii?Q?2q9mucYF2ERdTkNj70AU4Vnyckx3VW0hlWPvwbAabL1qjKCLLolpGFOZmvBy?=
 =?us-ascii?Q?GBSr6ub94wYiOIpRZ7XRkCtm35UAf6Qfm+o+f0aXRezJGUx9WFqfkq9ckMxE?=
 =?us-ascii?Q?Qb/8vhJuVxUhCOvVLpXfER65RiwIHdky9yD1aoEbnPUBeEbdxQaiRNZ0ofWK?=
 =?us-ascii?Q?sKujUM+AIkICG9G+OdwSttmRZVCaQ8RGz6lWxIcNp6T8PJaB9cKtIzdsH+V1?=
 =?us-ascii?Q?N9+evSqJoml3vhuhnVd9O7aQhbxFbSLJUDCgxE45hUrExbDvo9GiD7TfHQuo?=
 =?us-ascii?Q?tyPxFgmaDQU3p4BSDRLDFdloU3ZojBalF96oXFnUBk4dzuF8cxv6rP74LQOc?=
 =?us-ascii?Q?2SfraCKfEKBqyrYbZ1daB2qNagIE7kJ01UC3YXsN1NKENMVYFyZXaN8erkYE?=
 =?us-ascii?Q?hAg+Bd5SgsENKjzll8ZUOvEnLv57WOvCdSf7vnV+LyC7G2b4KVX/ow6ckkpv?=
 =?us-ascii?Q?ut0KQaQtljLJCH/IqI5frIAtFSm5rygl1AuSjatKc7nWN7tMCHEqoM1/vzUS?=
 =?us-ascii?Q?T1dYxik/V1B2tlQEJxVUN1GX6LXZej9f5KpDQKRwCppM+POnj7wEbOyapfrx?=
 =?us-ascii?Q?fFlJj9IUPMhSLkitflI85BN0acaaO8+pzaANu6zfVbwwgaeLCkMQFg07oxML?=
 =?us-ascii?Q?Fz8AGUootCIhjyVIiXUy2UPi9zqUE6SyZcX9gwnVcwDqfh7iceCuzflIAmfn?=
 =?us-ascii?Q?74wvCv7Ha8bjDOnoK0OzrlFJ0e+SUKvjgewMGiwL1Fc3Hk6Tg0KDyQCpttNk?=
 =?us-ascii?Q?1Z4acrkbpWZtqpIdewauZ6EVj+n0N0xgSlcdqb/V908BkvzMaSTeekMS/qeE?=
 =?us-ascii?Q?45pYCPOQQnti/Q8Aw6Fi1DFYcHXcFgrIqLZMLPxUT+tRqwbu4O131qDpCVBQ?=
 =?us-ascii?Q?a2I99v/QyUOYRgCo8xGbfZOoM8UNHWdhC9g6SCkLJvOZa7bWHnf4zlH8Zmzp?=
 =?us-ascii?Q?66YMaMOwDrvSAc1jEE0+XToH5iCk/PrLTzAgDjpfRzDFvtrMPRsXQ8QYUq5x?=
 =?us-ascii?Q?vVjGAzg2Em+yED0GV9+4HfoBAp6iUKskIffbunU8EfkCQyxuQUGOSNbrEAgZ?=
 =?us-ascii?Q?hhYGdseNhREjon8flW49KgbSRQzKbg+mNvk6pxOxvPlEfFqemx3vXLKUG3K1?=
 =?us-ascii?Q?ApzcoPs0W1ZMu8gN+69dVqGa7FpNPJNc7geygk/JhQfMhk7GCdlngfXJHptz?=
 =?us-ascii?Q?95OPE4eVfeUlx0vnxdAn8QQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: eb388bfe-57ba-47d6-dc7a-08dcb1422c07
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 09:21:34.6253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPqVTKLRfpi330aJuugl6Zu/jobbhu6ES2sh4e9Wl4/6K48JnXqntHlekuLInUkO8bFfgpE1S8rXRkQn3u+GZnVfrqzMbzD8htXoTt7NOtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10180
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

no functional changes

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 include/net/tcp.h |  37 +++++++-
 net/net.c         |  11 ++-
 net/tcp.c         | 231 +++++++++++++++++++++++-----------------------
 net/wget.c        |   3 +-
 4 files changed, 163 insertions(+), 119 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index c29d4ce24a7..14aee64cb1c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -277,9 +277,40 @@ enum tcp_state {
 	TCP_FIN_WAIT_2
 };
 
-enum tcp_state tcp_get_tcp_state(void);
-void tcp_set_tcp_state(enum tcp_state new_state);
-int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
+/**
+ * struct tcp_stream - TCP data stream structure
+ *
+ * @state:		TCP connection state
+ *
+ * @seq_init:		Initial receive sequence number
+ * @ack_edge:		Receive next
+ *
+ * @loc_timestamp:	Local timestamp
+ * @rmt_timestamp:	Remote timestamp
+ *
+ * @lost:		Used for SACK
+ */
+struct tcp_stream {
+	/* TCP connection state */
+	enum tcp_state	state;
+
+	u32		seq_init;
+	u32		ack_edge;
+
+	/* TCP option timestamp */
+	u32		loc_timestamp;
+	u32		rmt_timestamp;
+
+	/* TCP sliding window control used to request re-TX */
+	struct tcp_sack_v lost;
+};
+
+struct tcp_stream *tcp_stream_get(void);
+
+enum tcp_state tcp_get_tcp_state(struct tcp_stream *tcp);
+void tcp_set_tcp_state(struct tcp_stream *tcp, enum tcp_state new_state);
+int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
+		       int sport, int payload_len,
 		       u8 action, u32 tcp_seq_num, u32 tcp_ack_num);
 
 /**
diff --git a/net/net.c b/net/net.c
index d9bc9df643f..6c5ee7e0925 100644
--- a/net/net.c
+++ b/net/net.c
@@ -414,7 +414,7 @@ int net_init(void)
 		/* Only need to setup buffer pointers once. */
 		first_call = 0;
 		if (IS_ENABLED(CONFIG_PROT_TCP))
-			tcp_set_tcp_state(TCP_CLOSED);
+			tcp_set_tcp_state(tcp_stream_get(), TCP_CLOSED);
 	}
 
 	return net_init_loop();
@@ -915,6 +915,9 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
 	uchar *pkt;
 	int eth_hdr_size;
 	int pkt_hdr_size;
+#if defined(CONFIG_PROT_TCP)
+	struct tcp_stream *tcp;
+#endif
 
 	/* make sure the net_tx_packet is initialized (net_init() was called) */
 	assert(net_tx_packet != NULL);
@@ -941,8 +944,12 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
 		break;
 #if defined(CONFIG_PROT_TCP)
 	case IPPROTO_TCP:
+		tcp = tcp_stream_get();
+		if (tcp == NULL)
+			return -EINVAL;
+
 		pkt_hdr_size = eth_hdr_size
-			+ tcp_set_tcp_header(pkt + eth_hdr_size, dport, sport,
+			+ tcp_set_tcp_header(tcp, pkt + eth_hdr_size, dport, sport,
 					     payload_len, action, tcp_seq_num,
 					     tcp_ack_num);
 		break;
diff --git a/net/tcp.c b/net/tcp.c
index 724536cb352..6646f171b83 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -24,19 +24,8 @@
 #include <net.h>
 #include <net/tcp.h>
 
-/*
- * TCP sliding window  control used by us to request re-TX
- */
-static struct tcp_sack_v tcp_lost;
-
-/* TCP option timestamp */
-static u32 loc_timestamp;
-static u32 rmt_timestamp;
-
-static u32 tcp_seq_init;
-static u32 tcp_ack_edge;
-
 static int tcp_activity_count;
+static struct tcp_stream tcp_stream;
 
 /*
  * TCP lengths are stored as a rounded up number of 32 bit words.
@@ -48,9 +37,6 @@ static int tcp_activity_count;
 #define SHIFT_TO_TCPHDRLEN_FIELD(x) ((x) << 4)
 #define GET_TCP_HDR_LEN_IN_BYTES(x) ((x) >> 2)
 
-/* TCP connection state */
-static enum tcp_state current_tcp_state;
-
 /* Current TCP RX packet handler */
 static rxhand_tcp *tcp_packet_handler;
 
@@ -60,22 +46,30 @@ static inline s32 tcp_seq_cmp(u32 a, u32 b)
 }
 
 /**
- * tcp_get_tcp_state() - get current TCP state
+ * tcp_get_tcp_state() - get TCP stream state
+ * @tcp: tcp stream
  *
- * Return: Current TCP state
+ * Return: TCP stream state
  */
-enum tcp_state tcp_get_tcp_state(void)
+enum tcp_state tcp_get_tcp_state(struct tcp_stream *tcp)
 {
-	return current_tcp_state;
+	return tcp->state;
 }
 
 /**
- * tcp_set_tcp_state() - set current TCP state
+ * tcp_set_tcp_state() - set TCP stream state
+ * @tcp: tcp stream
  * @new_state: new TCP state
  */
-void tcp_set_tcp_state(enum tcp_state new_state)
+void tcp_set_tcp_state(struct tcp_stream *tcp,
+		       enum tcp_state new_state)
 {
-	current_tcp_state = new_state;
+	tcp->state = new_state;
+}
+
+struct tcp_stream *tcp_stream_get(void)
+{
+	return &tcp_stream;
 }
 
 static void dummy_handler(uchar *pkt, u16 dport,
@@ -138,29 +132,30 @@ u16 tcp_set_pseudo_header(uchar *pkt, struct in_addr src, struct in_addr dest,
 
 /**
  * net_set_ack_options() - set TCP options in acknowledge packets
+ * @tcp: tcp stream
  * @b: the packet
  *
  * Return: TCP header length
  */
-int net_set_ack_options(union tcp_build_pkt *b)
+int net_set_ack_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
 {
 	b->sack.hdr.tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(LEN_B_TO_DW(TCP_HDR_SIZE));
 
 	b->sack.t_opt.kind = TCP_O_TS;
 	b->sack.t_opt.len = TCP_OPT_LEN_A;
-	b->sack.t_opt.t_snd = htons(loc_timestamp);
-	b->sack.t_opt.t_rcv = rmt_timestamp;
+	b->sack.t_opt.t_snd = htons(tcp->loc_timestamp);
+	b->sack.t_opt.t_rcv = tcp->rmt_timestamp;
 	b->sack.sack_v.kind = TCP_1_NOP;
 	b->sack.sack_v.len = 0;
 
 	if (IS_ENABLED(CONFIG_PROT_TCP_SACK)) {
-		if (tcp_lost.len > TCP_OPT_LEN_2) {
+		if (tcp->lost.len > TCP_OPT_LEN_2) {
 			debug_cond(DEBUG_DEV_PKT, "TCP ack opt lost.len %x\n",
-				   tcp_lost.len);
-			b->sack.sack_v.len = tcp_lost.len;
+				   tcp->lost.len);
+			b->sack.sack_v.len = tcp->lost.len;
 			b->sack.sack_v.kind = TCP_V_SACK;
-			b->sack.sack_v.hill[0].l = htonl(tcp_lost.hill[0].l);
-			b->sack.sack_v.hill[0].r = htonl(tcp_lost.hill[0].r);
+			b->sack.sack_v.hill[0].l = htonl(tcp->lost.hill[0].l);
+			b->sack.sack_v.hill[0].r = htonl(tcp->lost.hill[0].r);
 
 			/*
 			 * These SACK structures are initialized with NOPs to
@@ -168,17 +163,17 @@ int net_set_ack_options(union tcp_build_pkt *b)
 			 * SACK structures used for both header padding and
 			 * internally.
 			 */
-			b->sack.sack_v.hill[1].l = htonl(tcp_lost.hill[1].l);
-			b->sack.sack_v.hill[1].r = htonl(tcp_lost.hill[1].r);
-			b->sack.sack_v.hill[2].l = htonl(tcp_lost.hill[2].l);
-			b->sack.sack_v.hill[2].r = htonl(tcp_lost.hill[2].r);
+			b->sack.sack_v.hill[1].l = htonl(tcp->lost.hill[1].l);
+			b->sack.sack_v.hill[1].r = htonl(tcp->lost.hill[1].r);
+			b->sack.sack_v.hill[2].l = htonl(tcp->lost.hill[2].l);
+			b->sack.sack_v.hill[2].r = htonl(tcp->lost.hill[2].r);
 			b->sack.sack_v.hill[3].l = TCP_O_NOP;
 			b->sack.sack_v.hill[3].r = TCP_O_NOP;
 		}
 
 		b->sack.hdr.tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(ROUND_TCPHDR_LEN(TCP_HDR_SIZE +
 										 TCP_TSOPT_SIZE +
-										 tcp_lost.len));
+										 tcp->lost.len));
 	} else {
 		b->sack.sack_v.kind = 0;
 		b->sack.hdr.tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(ROUND_TCPHDR_LEN(TCP_HDR_SIZE +
@@ -194,13 +189,14 @@ int net_set_ack_options(union tcp_build_pkt *b)
 }
 
 /**
- * net_set_ack_options() - set TCP options in SYN packets
+ * net_set_syn_options() - set TCP options in SYN packets
+ * @tcp: tcp stream
  * @b: the packet
  */
-void net_set_syn_options(union tcp_build_pkt *b)
+void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
 {
 	if (IS_ENABLED(CONFIG_PROT_TCP_SACK))
-		tcp_lost.len = 0;
+		tcp->lost.len = 0;
 
 	b->ip.hdr.tcp_hlen = 0xa0;
 
@@ -219,14 +215,15 @@ void net_set_syn_options(union tcp_build_pkt *b)
 	}
 	b->ip.t_opt.kind = TCP_O_TS;
 	b->ip.t_opt.len = TCP_OPT_LEN_A;
-	loc_timestamp = get_ticks();
-	rmt_timestamp = 0;
+	tcp->loc_timestamp = get_ticks();
+	tcp->rmt_timestamp = 0;
 	b->ip.t_opt.t_snd = 0;
 	b->ip.t_opt.t_rcv = 0;
 	b->ip.end = TCP_O_END;
 }
 
-int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
+int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
+		       int sport, int payload_len,
 		       u8 action, u32 tcp_seq_num, u32 tcp_ack_num)
 {
 	union tcp_build_pkt *b = (union tcp_build_pkt *)pkt;
@@ -249,21 +246,21 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 			   &net_server_ip, &net_ip,
 			   tcp_seq_num, tcp_ack_num);
 		tcp_activity_count = 0;
-		net_set_syn_options(b);
+		net_set_syn_options(tcp, b);
 		tcp_seq_num = 0;
 		tcp_ack_num = 0;
 		pkt_hdr_len = IP_TCP_O_SIZE;
-		if (current_tcp_state == TCP_SYN_SENT) {  /* Too many SYNs */
+		if (tcp->state == TCP_SYN_SENT) {  /* Too many SYNs */
 			action = TCP_FIN;
-			current_tcp_state = TCP_FIN_WAIT_1;
+			tcp->state = TCP_FIN_WAIT_1;
 		} else {
-			tcp_lost.len = TCP_OPT_LEN_2;
-			current_tcp_state = TCP_SYN_SENT;
+			tcp->lost.len = TCP_OPT_LEN_2;
+			tcp->state = TCP_SYN_SENT;
 		}
 		break;
 	case TCP_SYN | TCP_ACK:
 	case TCP_ACK:
-		pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(b);
+		pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
 		b->ip.hdr.tcp_flags = action;
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:ACK (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
@@ -276,20 +273,20 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 			   &net_server_ip, &net_ip, tcp_seq_num, tcp_ack_num);
 		payload_len = 0;
 		pkt_hdr_len = IP_TCP_HDR_SIZE;
-		current_tcp_state = TCP_FIN_WAIT_1;
+		tcp->state = TCP_FIN_WAIT_1;
 		break;
 	case TCP_RST | TCP_ACK:
 	case TCP_RST:
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:RST  (%pI4, %pI4, s=%u, a=%u)\n",
 			   &net_server_ip, &net_ip, tcp_seq_num, tcp_ack_num);
-		current_tcp_state = TCP_CLOSED;
+		tcp->state = TCP_CLOSED;
 		break;
 	/* Notify connection closing */
 	case (TCP_FIN | TCP_ACK):
 	case (TCP_FIN | TCP_ACK | TCP_PUSH):
-		if (current_tcp_state == TCP_CLOSE_WAIT)
-			current_tcp_state = TCP_CLOSING;
+		if (tcp->state == TCP_CLOSE_WAIT)
+			tcp->state = TCP_CLOSING;
 
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:FIN ACK PSH(%pI4, %pI4, s=%u, a=%u, A=%x)\n",
@@ -297,7 +294,7 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 			   tcp_seq_num, tcp_ack_num, action);
 		fallthrough;
 	default:
-		pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(b);
+		pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
 		b->ip.hdr.tcp_flags = action | TCP_PUSH | TCP_ACK;
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:dft  (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
@@ -308,9 +305,9 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 	pkt_len	= pkt_hdr_len + payload_len;
 	tcp_len	= pkt_len - IP_HDR_SIZE;
 
-	tcp_ack_edge = tcp_ack_num;
+	tcp->ack_edge = tcp_ack_num;
 	/* TCP Header */
-	b->ip.hdr.tcp_ack = htonl(tcp_ack_edge);
+	b->ip.hdr.tcp_ack = htonl(tcp->ack_edge);
 	b->ip.hdr.tcp_src = htons(sport);
 	b->ip.hdr.tcp_dst = htons(dport);
 	b->ip.hdr.tcp_seq = htonl(tcp_seq_num);
@@ -344,78 +341,79 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 	return pkt_hdr_len;
 }
 
-static void tcp_update_ack_edge(void)
+static void tcp_update_ack_edge(struct tcp_stream *tcp)
 {
-	if (tcp_seq_cmp(tcp_ack_edge, tcp_lost.hill[0].l) >= 0) {
-		tcp_ack_edge = tcp_lost.hill[0].r;
+	if (tcp_seq_cmp(tcp->ack_edge, tcp->lost.hill[0].l) >= 0) {
+		tcp->ack_edge = tcp->lost.hill[0].r;
 
-		memmove(&tcp_lost.hill[0], &tcp_lost.hill[1],
+		memmove(&tcp->lost.hill[0], &tcp->lost.hill[1],
 			(TCP_SACK_HILLS - 1) * sizeof(struct sack_edges));
 
-		tcp_lost.len -= TCP_OPT_LEN_8;
-		tcp_lost.hill[TCP_SACK_HILLS - 1].l = TCP_O_NOP;
-		tcp_lost.hill[TCP_SACK_HILLS - 1].r = TCP_O_NOP;
+		tcp->lost.len -= TCP_OPT_LEN_8;
+		tcp->lost.hill[TCP_SACK_HILLS - 1].l = TCP_O_NOP;
+		tcp->lost.hill[TCP_SACK_HILLS - 1].r = TCP_O_NOP;
 	}
 }
 
 /**
  * tcp_hole() - Selective Acknowledgment (Essential for fast stream transfer)
+ * @tcp: tcp stream
  * @tcp_seq_num: TCP sequence start number
  * @len: the length of sequence numbers
  */
-void tcp_hole(u32 tcp_seq_num, u32 len)
+void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
 {
 	int i, j, cnt, cnt_move;
 
-	cnt = (tcp_lost.len - TCP_OPT_LEN_2) / TCP_OPT_LEN_8;
+	cnt = (tcp->lost.len - TCP_OPT_LEN_2) / TCP_OPT_LEN_8;
 	for (i = 0; i < cnt; i++) {
-		if (tcp_seq_cmp(tcp_lost.hill[i].r, tcp_seq_num) < 0)
+		if (tcp_seq_cmp(tcp->lost.hill[i].r, tcp_seq_num) < 0)
 			continue;
-		if (tcp_seq_cmp(tcp_lost.hill[i].l, tcp_seq_num + len) > 0)
+		if (tcp_seq_cmp(tcp->lost.hill[i].l, tcp_seq_num + len) > 0)
 			break;
 
-		if (tcp_seq_cmp(tcp_lost.hill[i].l, tcp_seq_num) > 0)
-			tcp_lost.hill[i].l = tcp_seq_num;
-		if (tcp_seq_cmp(tcp_lost.hill[i].l, tcp_seq_num) < 0) {
-			len += tcp_seq_num - tcp_lost.hill[i].l;
-			tcp_seq_num = tcp_lost.hill[i].l;
+		if (tcp_seq_cmp(tcp->lost.hill[i].l, tcp_seq_num) > 0)
+			tcp->lost.hill[i].l = tcp_seq_num;
+		if (tcp_seq_cmp(tcp->lost.hill[i].l, tcp_seq_num) < 0) {
+			len += tcp_seq_num - tcp->lost.hill[i].l;
+			tcp_seq_num = tcp->lost.hill[i].l;
 		}
-		if (tcp_seq_cmp(tcp_lost.hill[i].r, tcp_seq_num + len) >= 0) {
-			tcp_update_ack_edge();
+		if (tcp_seq_cmp(tcp->lost.hill[i].r, tcp_seq_num + len) >= 0) {
+			tcp_update_ack_edge(tcp);
 			return;
 		}
 
 		/* check overlapping with next hills */
 		cnt_move = 0;
-		tcp_lost.hill[i].r = tcp_seq_num + len;
+		tcp->lost.hill[i].r = tcp_seq_num + len;
 		for (j = i + 1; j < cnt; j++) {
-			if (tcp_seq_cmp(tcp_lost.hill[j].l, tcp_lost.hill[i].r) > 0)
+			if (tcp_seq_cmp(tcp->lost.hill[j].l, tcp->lost.hill[i].r) > 0)
 				break;
 
-			tcp_lost.hill[i].r = tcp_lost.hill[j].r;
+			tcp->lost.hill[i].r = tcp->lost.hill[j].r;
 			cnt_move++;
 		}
 
 		if (cnt_move > 0) {
 			if (cnt > i + cnt_move + 1)
-				memmove(&tcp_lost.hill[i + 1],
-					&tcp_lost.hill[i + cnt_move + 1],
+				memmove(&tcp->lost.hill[i + 1],
+					&tcp->lost.hill[i + cnt_move + 1],
 					cnt_move * sizeof(struct sack_edges));
 
 			cnt -= cnt_move;
-			tcp_lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
+			tcp->lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
 			for (j = cnt; j < TCP_SACK_HILLS; j++) {
-				tcp_lost.hill[j].l = TCP_O_NOP;
-				tcp_lost.hill[j].r = TCP_O_NOP;
+				tcp->lost.hill[j].l = TCP_O_NOP;
+				tcp->lost.hill[j].r = TCP_O_NOP;
 			}
 		}
 
-		tcp_update_ack_edge();
+		tcp_update_ack_edge(tcp);
 		return;
 	}
 
 	if (i == TCP_SACK_HILLS) {
-		tcp_update_ack_edge();
+		tcp_update_ack_edge(tcp);
 		return;
 	}
 
@@ -428,23 +426,24 @@ void tcp_hole(u32 tcp_seq_num, u32 len)
 	}
 
 	if (cnt_move > 0)
-		memmove(&tcp_lost.hill[i + 1],
-			&tcp_lost.hill[i],
+		memmove(&tcp->lost.hill[i + 1],
+			&tcp->lost.hill[i],
 			cnt_move * sizeof(struct sack_edges));
 
-	tcp_lost.hill[i].l = tcp_seq_num;
-	tcp_lost.hill[i].r = tcp_seq_num + len;
-	tcp_lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
+	tcp->lost.hill[i].l = tcp_seq_num;
+	tcp->lost.hill[i].r = tcp_seq_num + len;
+	tcp->lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
 
-	tcp_update_ack_edge();
+	tcp_update_ack_edge(tcp);
 };
 
 /**
  * tcp_parse_options() - parsing TCP options
+ * @tcp: tcp stream
  * @o: pointer to the option field.
  * @o_len: length of the option field.
  */
-void tcp_parse_options(uchar *o, int o_len)
+void tcp_parse_options(struct tcp_stream *tcp, uchar *o, int o_len)
 {
 	struct tcp_t_opt  *tsopt;
 	uchar *p = o;
@@ -467,7 +466,7 @@ void tcp_parse_options(uchar *o, int o_len)
 			break;
 		case TCP_O_TS:
 			tsopt = (struct tcp_t_opt *)p;
-			rmt_timestamp = tsopt->t_snd;
+			tcp->rmt_timestamp = tsopt->t_snd;
 			break;
 		}
 
@@ -479,7 +478,8 @@ void tcp_parse_options(uchar *o, int o_len)
 	}
 }
 
-static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
+static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
+			    u32 tcp_seq_num, int payload_len)
 {
 	u8 tcp_fin = tcp_flags & TCP_FIN;
 	u8 tcp_syn = tcp_flags & TCP_SYN;
@@ -500,21 +500,21 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 	debug_cond(DEBUG_INT_STATE, "TCP STATE ENTRY %x\n", action);
 	if (tcp_rst) {
 		action = TCP_DATA;
-		current_tcp_state = TCP_CLOSED;
+		tcp->state = TCP_CLOSED;
 		net_set_state(NETLOOP_FAIL);
 		debug_cond(DEBUG_INT_STATE, "TCP Reset %x\n", tcp_flags);
 		return TCP_RST;
 	}
 
-	switch  (current_tcp_state) {
+	switch  (tcp->state) {
 	case TCP_CLOSED:
 		debug_cond(DEBUG_INT_STATE, "TCP CLOSED %x\n", tcp_flags);
 		if (tcp_syn) {
 			action = TCP_SYN | TCP_ACK;
-			tcp_seq_init = tcp_seq_num;
-			tcp_ack_edge = tcp_seq_num + 1;
-			tcp_lost.len = TCP_OPT_LEN_2;
-			current_tcp_state = TCP_SYN_RECEIVED;
+			tcp->seq_init = tcp_seq_num;
+			tcp->ack_edge = tcp_seq_num + 1;
+			tcp->lost.len = TCP_OPT_LEN_2;
+			tcp->state = TCP_SYN_RECEIVED;
 		} else if (tcp_ack || tcp_fin) {
 			action = TCP_DATA;
 		}
@@ -525,12 +525,12 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 			   tcp_flags, tcp_seq_num);
 		if (tcp_fin) {
 			action = action | TCP_PUSH;
-			current_tcp_state = TCP_CLOSE_WAIT;
+			tcp->state = TCP_CLOSE_WAIT;
 		} else if (tcp_ack || (tcp_syn && tcp_ack)) {
 			action |= TCP_ACK;
-			tcp_seq_init = tcp_seq_num;
-			tcp_ack_edge = tcp_seq_num + 1;
-			current_tcp_state = TCP_ESTABLISHED;
+			tcp->seq_init = tcp_seq_num;
+			tcp->ack_edge = tcp_seq_num + 1;
+			tcp->state = TCP_ESTABLISHED;
 
 			if (tcp_syn && tcp_ack)
 				action |= TCP_PUSH;
@@ -541,15 +541,15 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 	case TCP_ESTABLISHED:
 		debug_cond(DEBUG_INT_STATE, "TCP_ESTABLISHED %x\n", tcp_flags);
 		if (payload_len > 0) {
-			tcp_hole(tcp_seq_num, payload_len);
+			tcp_hole(tcp, tcp_seq_num, payload_len);
 			tcp_fin = TCP_DATA;  /* cause standalone FIN */
 		}
 
 		if ((tcp_fin) &&
 		    (!IS_ENABLED(CONFIG_PROT_TCP_SACK) ||
-		     tcp_lost.len <= TCP_OPT_LEN_2)) {
+		     tcp->lost.len <= TCP_OPT_LEN_2)) {
 			action = action | TCP_FIN | TCP_PUSH | TCP_ACK;
-			current_tcp_state = TCP_CLOSE_WAIT;
+			tcp->state = TCP_CLOSE_WAIT;
 		} else if (tcp_ack) {
 			action = TCP_DATA;
 		}
@@ -567,7 +567,7 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 		debug_cond(DEBUG_INT_STATE, "TCP_FIN_WAIT_2 (%x)\n", tcp_flags);
 		if (tcp_ack) {
 			action = TCP_PUSH | TCP_ACK;
-			current_tcp_state = TCP_CLOSED;
+			tcp->state = TCP_CLOSED;
 			puts("\n");
 		} else if (tcp_syn) {
 			action = TCP_DATA;
@@ -578,20 +578,20 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 	case TCP_FIN_WAIT_1:
 		debug_cond(DEBUG_INT_STATE, "TCP_FIN_WAIT_1 (%x)\n", tcp_flags);
 		if (tcp_fin) {
-			tcp_ack_edge++;
+			tcp->ack_edge++;
 			action = TCP_ACK | TCP_FIN;
-			current_tcp_state = TCP_FIN_WAIT_2;
+			tcp->state = TCP_FIN_WAIT_2;
 		}
 		if (tcp_syn)
 			action = TCP_RST;
 		if (tcp_ack)
-			current_tcp_state = TCP_CLOSED;
+			tcp->state = TCP_CLOSED;
 		break;
 	case TCP_CLOSING:
 		debug_cond(DEBUG_INT_STATE, "TCP_CLOSING (%x)\n", tcp_flags);
 		if (tcp_ack) {
 			action = TCP_PUSH;
-			current_tcp_state = TCP_CLOSED;
+			tcp->state = TCP_CLOSED;
 			puts("\n");
 		} else if (tcp_syn) {
 			action = TCP_RST;
@@ -615,6 +615,7 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 	u8  tcp_action = TCP_DATA;
 	u32 tcp_seq_num, tcp_ack_num;
 	int tcp_hdr_len, payload_len;
+	struct tcp_stream *tcp;
 
 	/* Verify IP header */
 	debug_cond(DEBUG_DEV_PKT,
@@ -643,11 +644,15 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 		return;
 	}
 
+	tcp = tcp_stream_get();
+	if (tcp == NULL)
+		return;
+
 	tcp_hdr_len = GET_TCP_HDR_LEN_IN_BYTES(b->ip.hdr.tcp_hlen);
 	payload_len = tcp_len - tcp_hdr_len;
 
 	if (tcp_hdr_len > TCP_HDR_SIZE)
-		tcp_parse_options((uchar *)b + IP_TCP_HDR_SIZE,
+		tcp_parse_options(tcp, (uchar *)b + IP_TCP_HDR_SIZE,
 				  tcp_hdr_len - TCP_HDR_SIZE);
 	/*
 	 * Incoming sequence and ack numbers are server's view of the numbers.
@@ -657,7 +662,7 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 	tcp_ack_num = ntohl(b->ip.hdr.tcp_ack);
 
 	/* Packets are not ordered. Send to app as received. */
-	tcp_action = tcp_state_machine(b->ip.hdr.tcp_flags,
+	tcp_action = tcp_state_machine(tcp, b->ip.hdr.tcp_flags,
 				       tcp_seq_num, payload_len);
 
 	tcp_activity_count++;
@@ -678,7 +683,7 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 	} else if (tcp_action != TCP_DATA) {
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Action (action=%x,Seq=%u,Ack=%u,Pay=%d)\n",
-			   tcp_action, tcp_ack_num, tcp_ack_edge, payload_len);
+			   tcp_action, tcp_ack_num, tcp->ack_edge, payload_len);
 
 		/*
 		 * Warning: Incoming Ack & Seq sequence numbers are transposed
@@ -687,6 +692,6 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 		net_send_tcp_packet(0, ntohs(b->ip.hdr.tcp_src),
 				    ntohs(b->ip.hdr.tcp_dst),
 				    (tcp_action & (~TCP_PUSH)),
-				    tcp_ack_num, tcp_ack_edge);
+				    tcp_ack_num, tcp->ack_edge);
 	}
 }
diff --git a/net/wget.c b/net/wget.c
index f1dd7abeff6..c0a80597bfe 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -356,7 +356,8 @@ static void wget_handler(uchar *pkt, u16 dport,
 			 u32 tcp_seq_num, u32 tcp_ack_num,
 			 u8 action, unsigned int len)
 {
-	enum tcp_state wget_tcp_state = tcp_get_tcp_state();
+	struct tcp_stream *tcp = tcp_stream_get();
+	enum tcp_state wget_tcp_state = tcp_get_tcp_state(tcp);
 
 	net_set_timeout_handler(wget_timeout, wget_timeout_handler);
 	packets++;
-- 
2.39.2

