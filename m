Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6C8CEACF1
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 18:21:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5A8689282;
	Tue,  1 Oct 2024 20:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="HQIoureo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37CFF89281; Tue,  1 Oct 2024 20:21:24 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4B3589207
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 20:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6EuNODk8MCYAblolzHz13VRE2P5oin3e/rxs4akvFR567l8iCgIit/JUn+Jq3xOe4NjkYhnGIHuVGVsEIbGv3guhbZlBHBXyTpCSeZbIjOrNywLYUnMX6B8JsYsMMxL0GMJLNDudcxEfeCJM+ofkVuw5KIByZF96QAoo1YNZ6NtviIo0HgcAfsCJ4hac6t/alx8yI7lC0dunnbkhcG+vY/ZQil1dXiSFYLQMLEBghwuv1879XS4aQibOrmnUxQlwMEf69erHXsa2KOkO+y8TbMhwL2HBSCZedAYonV3uRD1gvqVawP0jdmfEOp/Qum43qOLOdZ1pTmye8WYnQ8AUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82R868Zmi0AyBMAG4qhHZLHpzeBbdCvMiOZOEegeDDE=;
 b=Fwp6QzxnJRIPpPgRmHTtTNhnBALgYLrvCPP/yKMugAisnKbX/s276I7kUlOfJD86mQGRNqfD9zcl1VoaPeDpglarwTiS5F/wdg44dM5qeiRh5DBdUPN/fMArgGY/Vi9v2C8W+TQ8fM5DsyS1SB0IUgrdxDs8wIz0i5RCG+8On3NBAPmpiGjgFKcbu+2kTWaXfrFpqCoIQ3OYPoOLLJ0N9eDMZmPdKjz4BXfJoC9Xz7lNiSnkgS6PQQE0SArcAEEioik5WzpfXUv22A+ZGHuBRlZtc29Fz3cxU9qaHunA9PKFVrH0x8VUx8KxhLliVKVH1g9FDQzp7zEtlR1MVVBXrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82R868Zmi0AyBMAG4qhHZLHpzeBbdCvMiOZOEegeDDE=;
 b=HQIoureoV84Ml5U+ZfqxZC5Eg02etBpUHvQyzpLUddVknKG2dcunP1FmhMr+nhUUysdGCwQWZv+XtJ/1F7w5tT7iirs1I7p/PhXUAmtUm8/7En3iXRhtPDgfsfOWfjSzIdI8sqy8XwKGOt5llqAltaHMgkaOX0AaJmGW7AfSK3G0ecPntcc7pW1g6sigflwbz7/21Va5QikSJqtdOUykt9dC3ZPOlyo87xtGD4bUjbe//1MkqluxlUzOpFceLyDWehT8AtrlmVvMMrBuVyb5EeNbgGpMkqOGuu20NBszqrmtc5S6rSlH+jm9RAVH3qiEp0ZcJKrWvRI9AvxW3ybBhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9188.eurprd08.prod.outlook.com (2603:10a6:102:30a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 18:21:20 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 18:21:20 +0000
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
Subject: [PATCH v9 03/13] net/tcp: put connection specific data into a
 tcp_stream structure
Date: Tue,  1 Oct 2024 21:20:57 +0300
Message-ID: <20241001182107.907828-4-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 5eb149ef-1150-4ad7-6ded-08dce245d8d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JkHxnnpKQxq5mFJfEE/k+NL5GRYRQCAN0d4CYcN2FyFrdSgSczshN5cSuWRd?=
 =?us-ascii?Q?uNFRIYF0S9aP00uqDeq1syfduWzhAsVNXFINHOpn5M5KYivhrOJfpX8S9Srr?=
 =?us-ascii?Q?CemxaaQbTq8w4hkDxZ59BR35PDCEcGGMCucrtGtYxXkVgi80D1ZknkBJXEA8?=
 =?us-ascii?Q?XWmdGjdtzDEUuDjZpeH/UxXj51ldaVLAFemx8IUGoNg0/YEzQNVX68vXDUd4?=
 =?us-ascii?Q?3lhlcFzTJn6zV9UXTtyGpp5WHnzXP1mRq0lRKzgcdF4dOwz23SreO1hwuInQ?=
 =?us-ascii?Q?1h2Lbnt+v4hmmXuCswQTeX6xeaV26nZhoN4uYTWIudDCKRivnKfdGc7BVBrG?=
 =?us-ascii?Q?kRfdur8vFLXmFub3DonLZgX59Jb6Tvh/nViMD+/7jH2XlyMFsBrNF7xH7JyU?=
 =?us-ascii?Q?JUuV6ZzXqcyXSOlYJi9xNq4yauC0sTndNPjltUjClwoycIap7BOZ9UjLhiWC?=
 =?us-ascii?Q?Ay7QvLsY60cP1Cl/pl2LRz3dmEpLD7AoegsTTG8lV60GBYmlbjNh8V+JU5Rl?=
 =?us-ascii?Q?AmDT4I+Njj1kaNCWQp1FMJ16Cfic3wP5hr8f81gEz6AEtzB1GA/XPYDgrw7x?=
 =?us-ascii?Q?gTxh9JRnnUh/baCweFHOX/PPr9DVX7ppcHl7PhZuPI2Uchg9MMxVPUDO5nNL?=
 =?us-ascii?Q?loo9jbPWmu6JIzFr9PNgFdQg5iJsPyXyfxcBX/S16XL9EE66ky02TX4YtiNY?=
 =?us-ascii?Q?zpOZHTq/Iwt9A44iWfd63glekPTzBbO+h+PCnNMqHZq8Kqe8mBGadCU9oixa?=
 =?us-ascii?Q?NR+gmK8eijSV7UZOV9kN7gp5X+NZ0D+wJ1inEEWtQZSFAJOPXIYSIx9sYMmd?=
 =?us-ascii?Q?yhfPGnBwOIfdVcWE6xhwq/vTEDDQ/VrMaUqLoGuGOAmtbfZ8TpUAvEVMWuQr?=
 =?us-ascii?Q?fGgrb+bci+axk4UXJohI+SflFFkVqjpL4YV6KdyxG9+MevoWj4del+wsUJUg?=
 =?us-ascii?Q?j6oxCa7otMnUTv85MUpeRnXRy4zSrEP8Ktpov1JvEKITpQa6HaEmsZYMVfhj?=
 =?us-ascii?Q?Rrtj3ZKqKmC1PS5B6SUt4229T7jxUwhdJ+Txt/4YcvLK3jZetM7CodsYIuzM?=
 =?us-ascii?Q?bPslZjncaZa/9IrZ69zxSJ+gtzwuwA0POn8iLDQEb8hrE3i4xhlthgGV53Ow?=
 =?us-ascii?Q?XMv5lYUCqCy2TDWQbVU6eeanyv8fc00HaX+xSEcGAsa/LitvC2tqSlIFjkf7?=
 =?us-ascii?Q?ok1rkQ4URMujNQRu9UQ27N2kgL7oLTA3+7x8kNYCDTEhkuyQJbITCfRfNJqM?=
 =?us-ascii?Q?+qT0pmnxJ7TlHXUQhIwdDrp/ym6T+hTkQTYabJK0Ibj6N03lAw3tGdAUzmT3?=
 =?us-ascii?Q?+E/bVzimPn1AC362GUZOB0vVBpcYfz0ibN7s0u/f2stuXg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2/fUcdZQ3ryamRIFM3Iy2GZ7NnPz6CWAXNEXVk7tQ9hWDz1Oj5LPhsu4bZgq?=
 =?us-ascii?Q?OUi9/roK14Zrvg3G8sLZ77zg2agL0OboE4Fsxwy6FhO9pQerfuBOheVqSCbT?=
 =?us-ascii?Q?p93mhIKwpLgF4hUH4n3jG0Jjzc/uiIgmsdyVyBwp/Bi/HOGT1CB1CQs6qiWq?=
 =?us-ascii?Q?/n9+neIE6cu7Nm2RQx4i8uMIM/wQBINnUcsJmMm3YlRl7eqAiQfPKG8eMUpz?=
 =?us-ascii?Q?mRS4Z3U7wHXhGL0m8KiqJTAVrrc5OWbHN+Rc/yLFpsy2/qfN/DU+uOvHtI15?=
 =?us-ascii?Q?WmM7mBCpfArAWIJgA6i58BwK1OphLUBXR+R/gBy7MnJ45cmD4raD6yHVm0dO?=
 =?us-ascii?Q?P/IDxcUqFtKTbGML9ivBnCc6io1AhafWHvM/nb5FaN7/lJzWMuP98IWnvrBF?=
 =?us-ascii?Q?r6mkg9g1cDMPiRh4IG6bNpNWHZEtodLTGgU7UX80HEY84hqvAdpgMDtV48e0?=
 =?us-ascii?Q?ZDOU7NDkUbkqJQQ5wR11FhU/JG21wQHk3RdQyRJrR7b6e/qiUs9/J5gnOYg9?=
 =?us-ascii?Q?r9pkUhZ2DdxT+9uP1W6C9I659OgS3a+ffW/1Wp5keU0dh48zQBWbaoqSDfd8?=
 =?us-ascii?Q?xD1lVR5bxqpdcqvYuD8u0UJ+a+Ga3OTBJxkP4QQONhOEyRKjpRjcMfAkokop?=
 =?us-ascii?Q?ULcH5tzU51PQU8k/aUg5nhrpOgtxYiWIm6cJ5hX0EsjCxajLiq5Bl23t/LyV?=
 =?us-ascii?Q?8LctKUs6gY080TD4h1jVZGkfBzKWc3c5D75XAnKQ5/H/MxcfgRbCE2cd32O5?=
 =?us-ascii?Q?IEyHvEslnrMI0doFfkHBEme4xFwuUllg1EwbzNIpUegJcSqDEhGoU8br+fBW?=
 =?us-ascii?Q?AoC4lAhC98XxVW1Kof2lo3V/0dZceDMPdsJM1AeknQY8Jr/kZvi6ConP+eAW?=
 =?us-ascii?Q?RZ6n0n4jyt0VTFcXS5rB1mJpwZHlxCcpoe6kJY+59e43FQKrXeRxJpMhqhKL?=
 =?us-ascii?Q?0m+LbENDtMZoZ1D86Deqb7am0ZmTCyhroq6CXIXD+revxkM/HYx4A4mCXTYm?=
 =?us-ascii?Q?JbBAK1GjbxrjJsllHCkW8WV1EnaryEcnBk6OoXTYmo0cVqbbdbkZah2zeEd8?=
 =?us-ascii?Q?uNt8BcLYK32oLzECE3zbkXe6osYQuVz8ZYtfEghhms4JBT8Ak0yYU1zBW/CD?=
 =?us-ascii?Q?ZTGb/TvoZ+HgkGNKJTJu9RINi9FJ0RIeuqzmH8yUTn6hQVv/NTOu7O9YJaWd?=
 =?us-ascii?Q?fJWTKWUpUoFh9OOeT2ZfLBxaDq3mj8N5nQPpoXoqQlPIKJd8zlav9Xc8mWmc?=
 =?us-ascii?Q?hNVsXu4F49h53dSAC48oaxLnZL1LC1P2IuCjyfSEHhoYHMDuCjSMhmpsyHoJ?=
 =?us-ascii?Q?YUvmayjxwmVBPcWJGilrIR0N5ef6KgjMf1a5b9jfFFxh8drjDmyXLMnm/CG4?=
 =?us-ascii?Q?voeJz4H0+5LDCiZvqKNecqJJSfEOSUdgldk/vpyEKlMl/LSUvk9z5W5bYVwe?=
 =?us-ascii?Q?Pne/2G2c53cCP4orKXvfus5U94V9xoK85fUiH5CgWmw3aupzD3J/xzh4usNC?=
 =?us-ascii?Q?BTvsKsZSMhG4JIQh5V9r6foOb68Y2cTiLZUe+OIlFE/ZG824pP7hyUnhcOQx?=
 =?us-ascii?Q?rECsKG4Ipv63ItPnr8ji+tkrLgxQZcOHBpDLbQ4N+hF764gzFv3xiMftDGVA?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb149ef-1150-4ad7-6ded-08dce245d8d0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:21:19.9624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HS413pJXMXW+0gdhEfMsWayBB0NHYwGaSBWIhty6oHT+CTMPx2IzLUPnNmM0TKqC2qI6m7fsGQ4abnqiPe4MtrdzmonQT2F/wXEWBJ2I4b8=
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

no functional changes

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
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
index 1e0b7c85624..1bbf0556cef 100644
--- a/net/net.c
+++ b/net/net.c
@@ -419,7 +419,7 @@ int net_init(void)
 		/* Only need to setup buffer pointers once. */
 		first_call = 0;
 		if (IS_ENABLED(CONFIG_PROT_TCP))
-			tcp_set_tcp_state(TCP_CLOSED);
+			tcp_set_tcp_state(tcp_stream_get(), TCP_CLOSED);
 	}
 
 	return net_init_loop();
@@ -920,6 +920,9 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
 	uchar *pkt;
 	int eth_hdr_size;
 	int pkt_hdr_size;
+#if defined(CONFIG_PROT_TCP)
+	struct tcp_stream *tcp;
+#endif
 
 	/* make sure the net_tx_packet is initialized (net_init() was called) */
 	assert(net_tx_packet != NULL);
@@ -946,8 +949,12 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
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
index b4251e0f293..99ffa90c494 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -321,7 +321,8 @@ static void wget_handler(uchar *pkt, u16 dport,
 			 u32 tcp_seq_num, u32 tcp_ack_num,
 			 u8 action, unsigned int len)
 {
-	enum tcp_state wget_tcp_state = tcp_get_tcp_state();
+	struct tcp_stream *tcp = tcp_stream_get();
+	enum tcp_state wget_tcp_state = tcp_get_tcp_state(tcp);
 
 	net_set_timeout_handler(wget_timeout, wget_timeout_handler);
 	packets++;
-- 
2.45.2

