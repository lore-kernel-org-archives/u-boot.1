Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8540CF887C
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 20:56:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7041C88D7E;
	Mon,  7 Oct 2024 22:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="J2qn+tFz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63D2088D25; Mon,  7 Oct 2024 22:56:02 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::70d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10BFD88D29
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 22:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H29v/vYRGwsTLg/ypRW2CR3IprunACmfMfm5qEhHJI2ZYmr2o9Z8iGcmr3hNZ7vvlYPBiksyx7DA2Nh+BQD56uCNrsxYKk75eqs4dY6/HaBISQyE/nzCxGySkpKuCMA3nANnPjoCqpPMnfrzXEN0ava7ZYa/rhXCRzcHwpZE5BsJ4hgOKCfjO8dSabrz5yWdDpf/BAWYgInTQSXcO54QevF2Yme3aUo8Ukpzoud3LUaTEg5tQTCvpDsISEio++3en/09GRjFTmpVK3N39OH4LiPx0ID9+O9qnljKhRoxHT5Fjh+gf5HmOvIjwCHmB0EYj1wfyBX17gDSMaC8Fcae0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82R868Zmi0AyBMAG4qhHZLHpzeBbdCvMiOZOEegeDDE=;
 b=nIi9cgzAdbU24AyFqqob7IslZ7179h2CDSdDF4M1OT+sLWHBthkkddSUYALsWjWfSKP4YJkp+YKj+XJgCjinY5hpbiTuQhE6PCV5sPdJ7jzfCMZqMJUIhlnTt2r8cF0KND4+4msw9mY5gpOZQKZpWpISaN1tbn41ejUWs1W5LVhQrvFIi2Yh9PWRxIrg1f2xXm7FI9hI2C9YchS8T9LTZ+Qq2XuvvRK8JPIUUnooRybZOcrECAnlyhixy6DmP/i/wJhikdVVMSYqlCygqMrlHLn6GzkwzZDpXvxEdsP7RimUowSEI/tABWGdKVEvsIqsHKmjDJlambTWQ9GmpSNSoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82R868Zmi0AyBMAG4qhHZLHpzeBbdCvMiOZOEegeDDE=;
 b=J2qn+tFzRab7erlYaog+k/Q/0g7VCy8ebTjtjJE6pByvN7vVS2hgfHBYVZ1ey1gzpI9IbyPwS4ejbHJIexFf06PuhXsMApqq5eDVUuLnZ0m00WftwtUPD28GmGfSRH9sNKf/UwJIFRIFeUBbE2VL7J6qsMe2B6iIQgZysFMfqUf9Q9wGRTF/ps+GvMN2fAxjJwujK9ZVCsZHDwBoy3B8kFz+s2OWEHvAy3WmxGuiYIRyXTqzfvXWfK3KEgRJuoRsKtlouSZ8QGj+FtetAjvglKKmTYnInxBYnzwWycUS9UaMpRL5GHT/nbcXxeHQA5WPgaDDozUoARaVK4DoYOaBOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB7644.eurprd08.prod.outlook.com (2603:10a6:102:262::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 20:55:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 20:55:58 +0000
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
Subject: [PATCH v10 03/13] net/tcp: put connection specific data into a
 tcp_stream structure
Date: Mon,  7 Oct 2024 23:55:33 +0300
Message-ID: <20241007205543.1632499-4-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 0e088fa8-7493-4e0b-1465-08dce71271b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?65JYjiq0o4SiAORiI5MEm0/L6d4DYlj/c4wO8n/n378S9RnZEtV0KyoRmxyX?=
 =?us-ascii?Q?6awf7IWTwSPRB9mzk6HMLSjp6IFeMKpE0dTOCMtDAnaFzv5y7qBAXZxrVmHM?=
 =?us-ascii?Q?9wWAv8uWjMpGwtfsyZQn7gwMRFUdX1dYtseytpuxT9b6+HZQHI+Nst7uHTaR?=
 =?us-ascii?Q?BMOhTI2dHFa7bF9vm3HrEvlq0tV4Hk28StxqL6guqsUdOklMAT3RFDOqBNSQ?=
 =?us-ascii?Q?QxpzsHbVTZ5PNNklzD459RNE2+N1PLN3QHz5wGDqgzYF8TEkt0tflEadTYKJ?=
 =?us-ascii?Q?iNsUb4LgFDXUdn1kweT2lKXRYLqq0Hr1sAfcOuu9g65mHk9MZtGK/F31UaoQ?=
 =?us-ascii?Q?ZMBYx4V7ZY+1SQtPuYpOy2Z91F7hffSTL5N2vjtp/gskSFBDqDuUmDSM5q1Y?=
 =?us-ascii?Q?9TD/ZZVKnwhuVG27t+0DW7fXqwsOhtbv61qLW68xaPr2xEIJnrAE7tqJb7rf?=
 =?us-ascii?Q?6jmFF8YPU2cNOh3MhYAkiss+ykGz5kCa7lV3mxK++TXA1L3CDhBp2hdhWEYA?=
 =?us-ascii?Q?DoBu5z0XaKjKzPo7X2pD9wCR6zFBczTILB7Rou2XLSoSehHdZT4QTl6CPCnJ?=
 =?us-ascii?Q?snnapdglgHnMoT4pGGs1W79I9YU19pySkDYxz7rifRTq9Boao9WM1Vr5j3Pd?=
 =?us-ascii?Q?StD+5K0JLEMBITLI4zbSPZHmODJR/MoZLgobm9aZ/uArYyxuKH9Qb7n03dou?=
 =?us-ascii?Q?L6aWRBwVeVDtwFi6+FHFijgs63PJBBIQuFCI6dkj3Q5+BDLu+35w9Y7gwAy1?=
 =?us-ascii?Q?sCCnht+JJOJzLTnzJ/XcATRM5NHd/bVgk1QUmtU00cne/1k+SW4ylteTtvLC?=
 =?us-ascii?Q?Xwc0d9jqc5m9hM2hWoosaiWUcUelfzYFTZMN8ru3MQNde+vTK8tev5s8xpX9?=
 =?us-ascii?Q?XHxDEKu5gpRBb4pK9rumogHA7XLJHFTGNX/vtStchgNsxHvLUX8DRdK25Q0W?=
 =?us-ascii?Q?qF7vw6PIkmEFYnARHIGQ7XDFR+FqTsFkK++e0Avf3xf8vIXG7NYAeLzXBXz4?=
 =?us-ascii?Q?NbBMnLteKPVlr0AsiX6Z1WAWAtMsCFRjCpZGE4TC9PzM7t84nCSqZg+v4RZI?=
 =?us-ascii?Q?mzif7IgwiG6lAt6GO0Ct22Z400FYxxHf4/wsrW1MAaRb/hToqFj3ZyEIEWH7?=
 =?us-ascii?Q?TW/M/vKOoRN78avriKavQIzjtsYk0yiQb5moVGGViJN6vTATgZ3M+v3Kn0PS?=
 =?us-ascii?Q?hVMXbO2EUEmCt3YXrUOsFUM7QizPLjgnSkoUbnKfUL3j4tEwNmyjufsawQN2?=
 =?us-ascii?Q?FD+KK77Eh5ncA7bawGO4T+j2aevBP/2tZL/Nqski5zwalHf/rMIKTxT/g7R4?=
 =?us-ascii?Q?bG9OTL8Pc47Eyuu/gdm8ap4tgbBK838HYEVM0HLXaDdQ/A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w5WmqSo/mwxC1a0Jl4pRdtPlBFV5rFnYZiGqjOs46qFLwjucsz8y/8uAEePg?=
 =?us-ascii?Q?Z5Ho7hjR2S+9UlrG5v3Hk/MzV0JT2zLxM3ncgfeLORNGq6gkt4iUwSfRO6aA?=
 =?us-ascii?Q?AT++EmBcmlvmmUaoFoLwBPfzR1oSW1/FwOKL4vJMcMVYGC61ypcDNId3xK8e?=
 =?us-ascii?Q?+mcA6/Gw6TbHbnBuOE3P3thpU9r1iHm9XOeAVlKnJXTTUU3VNptmIVIqpmAz?=
 =?us-ascii?Q?+MxOwkm94P3ALx2VTy2LvJ7iOC9vputIL6wH8Tl+4OOSJ2nIoUgbbc6kkfdB?=
 =?us-ascii?Q?kWOoVgNlEqLzu2IgfK4+UquHwiMMFhl6xtvx7jHaRX+LLf5SPYydORoe/ll1?=
 =?us-ascii?Q?Ckxe3v5+dLkoLoFLVxqVYfVB8LUE+RevF+07RdrIMNgRVag8pzUrTnJTBbbu?=
 =?us-ascii?Q?RResETJk7S4nauTUnqonrhDJlrgiVEHtdZuA5W1J6fwuwVAkEhW+3wN2CFtg?=
 =?us-ascii?Q?8RlThvoa104US/Jgdrn4DQKiweetH3cXBKpBmKl2QptK3SFxhD9D9viN2evz?=
 =?us-ascii?Q?XZI7pRZP40rNKVcAeHbfKAUSvSvsFqlDui48EKKu6sHRDKuUUPqYex3yCKYX?=
 =?us-ascii?Q?bApuvvtcy5ytjD/lXu1kt3Q8Vq2TYIG5xso7GXxpk6pa1Qpd3Y8f4F+26DvP?=
 =?us-ascii?Q?dgYj31/rjVgiZF/g+er8VGCBxv29D3bTFqE00mUh4o0VfNwNuBp6S3zec/k+?=
 =?us-ascii?Q?PpI/teosT+/SUFDk4lp1FCdfNFrYqaqzLxT4fhki1dMjfdv6yj7jnWkX0niR?=
 =?us-ascii?Q?D8FkbxsAIOcu3mErmINb+9jiXGwH2+QgLTvKykSFp8xHZfThJQsoabTISj2F?=
 =?us-ascii?Q?2t8yhrqgqTJgDKPFIh+RXyoo+21AyboABpsn0ooOzia4iNgOrFRGP7MR623/?=
 =?us-ascii?Q?SfusvOOomaECCH3kKQpeZQ7+I6WKvfYLsD1pHG0PuZ3ODKRglshqB6JNSarE?=
 =?us-ascii?Q?erNs8ECUbk06iUGhzdo4AtjhauD/oRMqBbQHf8pNlniY4n4ZFHxo/EpWBf2J?=
 =?us-ascii?Q?QWFx0XJZ+CP9v96BeCOHm+fIVkAEUG0sco5dvgREF/BOaNHOiVpywZ4NcFzA?=
 =?us-ascii?Q?V84BNRcZMivYNe5uDl2xCkutgXNRo3iDsLVNiZzmpgMAt7RRGgXbRx1nmdTv?=
 =?us-ascii?Q?oq+YvIE+Ry51kAksJwDo+LAE/rY+MtvQz9svHphyMHffjHUHTCtaKn58J9g9?=
 =?us-ascii?Q?/0ts+LBUnHsOsI3xj4l7T6GeC4UQBGdMZNGi43Njp92gvnPq1WvDvwRUtItu?=
 =?us-ascii?Q?Ej9e/glKjT/RUWUK3s9JzFucT4BUF3tcofqu9lNk0uqbn1oh0oXkVCVSMa5f?=
 =?us-ascii?Q?4aGOwaKqUF4Zs5d6cnt9pl3Yca8GGXLINOCeSQdMD2EZ2fUAQBMwxLF1FsNv?=
 =?us-ascii?Q?D27K4pjZL/3S6thb/tuKaCV/MWEi+Dipj184In69F+h5I1LM0U0JrwcGM5dr?=
 =?us-ascii?Q?zFItgA4Pz5Q9hp8H7/OHZVqAWUdDPk0EWps3vnGUfSlW46B8oHwYvXvvgqhS?=
 =?us-ascii?Q?M9l6K5YR0uWipVaFvfHR1uVipr+2gVhqlCnlWKc/YItPRxkwhKZ3q+90pHtz?=
 =?us-ascii?Q?9S8oc4BaC6NGiJdCdb25x2psBohpEXJFeMygFNLQorycXHUg1IVAAARHAYNA?=
 =?us-ascii?Q?+A1MiwywYko2l36ApejJVUM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e088fa8-7493-4e0b-1465-08dce71271b7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 20:55:58.5032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vs8mfXN8aW/V6OkYRH2yrIdttf8chDTKGHhIWtgk9GzeSwKZxLuycNVkbs5tnkjiPM5oZFz069QD27Ggk1o1xWE9BwxTlq52slozZh1xT5Y=
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

