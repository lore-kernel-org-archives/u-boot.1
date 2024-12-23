Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C09AE7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 11:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DBA18070D;
	Mon, 23 Dec 2024 11:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="gmQaqx4T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C49E8072F; Mon, 23 Dec 2024 11:59:16 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D418806E5
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 11:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxB/825SSVrQngVmmb3DYjNSbWyA6In3mlVkEVq5YzxhWJIeoUXYaceVi8ruiT+807+GcBuCtT2A4QaBP05WBhJ0ukMUv8h/oPNYt8fYGd01M4CvWWQ58hblbB+1ydl55qVDUR2OSnrz95Eh54Oi3GFxqlmM2xn3rNDoE15yFPfHlNFmydSF/pKtLu7jET9Mc3Ixo4tRJLx/0uh67MeCREUbWCFTvm4VtxJcDEP1PwJfCdY6RQG7B6wrfdBJ+/iFsPxDsKu42gdKODF8GNnOdkA9IBeVMbMdu2Zwq2Dc2V4U9g4D6dw09oGkJCscpnEj3T4p5CpG3FR2tP4Om/hNQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7i18DeIyH/sjCeXiGcuZ+OJ4i4PcQpShwSI8Y3eQS4=;
 b=fw0Q6LYgQIgPdsn/ciyzCyXeWzAsdEOWdsmhM9ICDcfPTZSM9QebnbM9X7T0xe4BEtccUMpUlbvoZs6M6NnBORQNxdwgLTx4UgC+xa1FE/5jcunu1DBVsMtSEgJryAj0tHJUlqfANt4N7oo/Qdp2hrF2Bjp2ADdQrMFNQevSBqfdWwgO+y6fqRE4mTXSfP6zox35H/Xf1wMjeZlhal5KpbIfPFtdRPEY79/Mz2gKw2qwot5FTI2spnkNyyAKIQmHqUMJO/3Qc4fWCIfklCU70Ct9FNmLMQvHHRVIQdH3YEeNZmL/FXXvDRcHvxsui2pvjCkTJLWCTjULHjHCePk+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7i18DeIyH/sjCeXiGcuZ+OJ4i4PcQpShwSI8Y3eQS4=;
 b=gmQaqx4TTR9JLEgXPmN4Oxb4SPN9JwnMYr3/5eUZX3NJss1E+5Bgb2HzWW0x6yTNPfv7kCJq8GcJRczpV65k7YoHcUZ7TUPF9qa1VxNxWbM7kiZXs5DAy7QKCzrQDSVD+VCsWpdfZZxfjeSz8Hj0rl6EfQP9PbdyWLcbmAEGZ0Dzwf5WDt6xgaHWhwCAwjkcxfZ/pghkqjY4+l0FxLjszZQjZn/0X/nHhgv964uFAEDOwj/GLL4a+cfi613Bd15KuFNrs6JASU2rcHpZFIV95qYy3cMEvw04Sx+bbx9c4Jh+5Tm+1zhHZkPjeijmd7WZmEAIseynsJ5Gv1/fnRDcDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6676.eurprd08.prod.outlook.com (2603:10a6:20b:2ff::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 10:59:09 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 10:59:09 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v15 07/11] test/cmd/wget: fix the test
Date: Mon, 23 Dec 2024 13:58:48 +0300
Message-ID: <20241223105852.1074404-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241223105852.1074404-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241223105852.1074404-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 96138354-f60b-4d52-1270-08dd2340d3bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SdLGsftbdk/gbOsgPDOE2YMGykJuehU8pkmOR8hGcpeqPJkVxXDWGGLLEn2g?=
 =?us-ascii?Q?qabDaLhIP1i5EbS4AGc4TmPkLpRI04LhGqbUwBRLR+6tPja0v0WejAUGW6YX?=
 =?us-ascii?Q?7V7YQq34jNoCL0SsuGdscLXvAFvmt3eHzxLEfy47oGBshetzUOdl1CyEShRa?=
 =?us-ascii?Q?xGU41d8dpBskaF/yb04npXM+Z+7MNjq6uAPa6poltgqZtq9FXgzwj21PmU1j?=
 =?us-ascii?Q?8aVcQrtwq/AlnU/Oy22CtX3ZmiOMtqT9+rllDR3PZL/TTu6L7DgT1DCm4FsM?=
 =?us-ascii?Q?lZWJaIi7Mn3VvrlCLSqpj+HKcZAUz+6LL31dTaCdKupH6o6TQaonb6JC4F6k?=
 =?us-ascii?Q?a3zpJ113Djs7HA/DKGTrnPqTfubcVHb1ljPcqrZbAuBR31SveRkICz35kmwc?=
 =?us-ascii?Q?QziCJeUVsh6i200BeaGAJnMAFO3y2QxJYd9pduv8bDkSRfWYl6MKt8ha97oh?=
 =?us-ascii?Q?VpQYKcUdbr+141M1WRRlXdjLrX4hr8h1uDzehCsU9YASnl3iybnTSRgcE25c?=
 =?us-ascii?Q?jNEQVh1EX0wsScd2kHZuLSvFcaW3ZbOXEaACDMnQcPLQ7hbOxjoECKNdbimb?=
 =?us-ascii?Q?2iJAZfwL+UiMgKj1pQxmAGEL9whpKWGK7yS0wJyWimmwfnLeKufUnWJGs5Q8?=
 =?us-ascii?Q?ymQVJnIALDR07qN078G4IU5kop1q2DT30wBBH66plRlZxRbuQ0QwzZjpwgct?=
 =?us-ascii?Q?bX26yMiu7XxuP4iXmm3rEOd84C5LCsGCUtAM1Ylkk10Pk/aLOJMPSOb1gDGb?=
 =?us-ascii?Q?Yd6ApiOr6uXZKxqZnMha3lqY/Xh0ci5kUeIArgWgoXzw6GicWAz8F7wN8uxL?=
 =?us-ascii?Q?bE/Acta5AqBM0lplIMWzxU69Wi701nz/CURCULDMa1f5v84keU8soZWOiOqZ?=
 =?us-ascii?Q?/YxJ6XGnCp/iVosk4/pFAthGeM5a42vJY/V392Ay7phrBgmGkox+zkzMBGUY?=
 =?us-ascii?Q?//WAqslZBeNBgZqxZQt2U+4I8dQP8HdbRR3eJUWRXOJ6vJd6pklX+bVTTnaE?=
 =?us-ascii?Q?9JODv44k7WqhRxpcLrZlQ8ISTs7650+TIpr8zM61XT7+v7vVetQOVHdxw3m5?=
 =?us-ascii?Q?YKXubc6V6J6CQQNHWBbIHs+/+o06RXH4u2/L8rIHSA6jLuGpP8+pyg2dZ60J?=
 =?us-ascii?Q?6cxNCqQZSuZUV3FGcA9LyEe+I0pxFXvklMmkO7m4/mJN5D4pwygdw8nmNkC9?=
 =?us-ascii?Q?/GepWcOZWV4nEDcjgunyNAKb9/7NfAsuRd/+jEW9angD+I/bEJ/NrbcF0f8r?=
 =?us-ascii?Q?ztv2h8zngLZaKzpOzwGMwrS/69M/gz+2ZerKKe/oxc/1fuE9XlmozPk3dmR9?=
 =?us-ascii?Q?4QGVZ79AzGyrXDmYKd8Rg8D/E6QhJtTrm3AJwL92nhnIKdhqAje26yHoYALF?=
 =?us-ascii?Q?9DDDGPGKhmFsHc53ualYnMnZjJuVllr0hRe9+3NFPQTIz2DKK1ecy5g1KB6v?=
 =?us-ascii?Q?LgFIq6LT1+WYM9ReFs+Q/BK8LK5CB3FXU0OQqYD9kUysV5UTkHnR3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5J6o/4JsEGnOoQZW2uDZYgiEe1M2beCvGqd+hbCfwwgxrz6Xicf6Dysza9jO?=
 =?us-ascii?Q?XYvfJHGzvy6YezF+IoDeb/TRhJpQP8u1PHQXYim8B+9GI+duPMYcHtgraf3m?=
 =?us-ascii?Q?v3uqlupPCT4Ul08JcqKUrG/C88BYxhhEu6prHP1jDF+6IUy325SnNuND//2J?=
 =?us-ascii?Q?FqWfbpa2GH7pfyCmyyizPK2fUz/S7e+4o37cgIsdjMiX5VUVxlzrS5cYIi4z?=
 =?us-ascii?Q?KW3gHMNg9ZE0J6UGWjKkMEKKrh0OeeJcbXY6qIoPXIVcMySAGsIZlr77s5cT?=
 =?us-ascii?Q?HFw0OhdRwm7cjqUmr36rqMDiYOAQI+YEyYRnP2g9vo8DAaV7tMnLieLztdTE?=
 =?us-ascii?Q?M8WorfDp4NDXDtwnQba1vlIgm+faC6pUW6eG1XDExCXY8JJ+Y8XN3Rbu6j0N?=
 =?us-ascii?Q?3b0zGFYLvwNXQJZMbu3W0cd5qV9FYAnlcjfYlNOGkS9/v5I1/TuQz6l39C1C?=
 =?us-ascii?Q?ofoGyX3Nss4EpQhiDGLy9DzF3gwvhUBvKyH8bcdFXZyfJ4M42ytkhe6TN4Gw?=
 =?us-ascii?Q?k1RR5db/N6MzH/91cv4HgfnwqjH7I6WZhTZGsy/O92Gf4ExFm7rbD5P3OZlP?=
 =?us-ascii?Q?CO8MmuNjzJCPn27eedVX1VK+6e94kTKkJjz20wfc0uwzAFnZW8SupFA9LRm6?=
 =?us-ascii?Q?kPZLpMG52zKe8ta77DCqb9DGu1uFR9ubhRlNM5wU+JrC6y96uTmkNkNnxfPt?=
 =?us-ascii?Q?09qeqdRLmSC9oszk1bmT88YMRs240hVQm8tohKGLQMB0z0tZcppQlTXuubOi?=
 =?us-ascii?Q?qUY+6dIgQi84QehwZOc3I1uZX/R7YpHf28Y5mcuKcUBUL85mVP2uPBPDw1MG?=
 =?us-ascii?Q?o3a7VnCq1HNbtC8Syl1h2+JPrAr5kkuO/q3rHlwP4IrB/Ms/KaLD/NyRpUWX?=
 =?us-ascii?Q?DgKR9vzpaxAZU9dc2wJgyv2J/LTcxxqHMKj7HUf5mfc5IAG1XM5EmZTOgyw2?=
 =?us-ascii?Q?Z/EZOA+0I0XnCaAyiyI2afQ1v+P7fTp40ftvaYcfwSD4KqJXQQuu/lc0xb0l?=
 =?us-ascii?Q?RM27sC+Xrg+mGUqAjwpTIlQ8BFFUuPcbKX3PrRW6/l/MvjB/IHeh52rsIbTE?=
 =?us-ascii?Q?D8SC6yqliwL8wbQZWflVudtgUCQhegd1HN+c4CSgYxBzl+5V3B8D5o6Dgc80?=
 =?us-ascii?Q?3Z5szR1+5jqIRrXtVoHf3V6woh3qYuWC4NNyU0YVI4gZzURif6HngqB0z7fw?=
 =?us-ascii?Q?hgCEhZwI1CSzLtBPnMDf7Sbf2uK6175clbrLkBHu8V1rCiJfWdz/oXTQShtO?=
 =?us-ascii?Q?aS2PXKF0piXUk/Y/fVwPCAH13rTiX/5mO4XedpIJ7QcBXfUokinlMzsaTNq/?=
 =?us-ascii?Q?68FapDGpeiFTxtDYB71p7/+OTedAcOyKtz4zEKQtFJwSXuK4aLH+ioFU5cuU?=
 =?us-ascii?Q?QZxS/NKJrIWyHmzRPhxmVynonaT6UqIjl15qlD/5xM2JDabAfkc8+3HtTiI3?=
 =?us-ascii?Q?MDsTlLEJbDLR54YoP4XOFIQO2i98iFIJlfOcL3oDF8KRb3Gjed97P82dJqYo?=
 =?us-ascii?Q?jcDLPqOS5K5fUy7/9T1iQE6PAVZVrT8n9nF8e58GUpL2E07t9yh0Ii/6rr++?=
 =?us-ascii?Q?l5jJE0ifadyCVPE/YdexSET+GuEbOaBEgrSyIugKyXKpV2uncRMw1q2yfxh/?=
 =?us-ascii?Q?0SK6Viz8d/GgcL7sQ6W2A0w=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 96138354-f60b-4d52-1270-08dd2340d3bd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 10:59:09.5229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1WCJCA3QuRJVvhpneq0qMgemawWJwZvmmUUrLSLAasblNDSO4psTeAB10dp1dWEe0TofgHAkjVj5bjjvx84tfPHE5iU9gocQlZ8QG0OaHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6676
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

Changes:
 * update to new tcp stack
 * fix zero values for ISS and IRS issue (see RFC 9293)

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/sandbox/include/asm/eth.h |  4 +++
 test/cmd/wget.c                | 58 ++++++++++++++++------------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/sandbox/include/asm/eth.h b/arch/sandbox/include/asm/eth.h
index f042a5f3b92..083a7371a3f 100644
--- a/arch/sandbox/include/asm/eth.h
+++ b/arch/sandbox/include/asm/eth.h
@@ -77,6 +77,8 @@ typedef int sandbox_eth_tx_hand_f(struct udevice *dev, void *pkt,
  * fake_host_hwaddr - MAC address of mocked machine
  * fake_host_ipaddr - IP address of mocked machine
  * disabled - Will not respond
+ * irs - tcp initial receive sequence
+ * iss - tcp initial send sequence
  * recv_packet_buffer - buffers of the packet returned as received
  * recv_packet_length - lengths of the packet returned as received
  * recv_packets - number of packets returned
@@ -87,6 +89,8 @@ struct eth_sandbox_priv {
 	uchar fake_host_hwaddr[ARP_HLEN];
 	struct in_addr fake_host_ipaddr;
 	bool disabled;
+	u32 irs;
+	u32 iss;
 	uchar * recv_packet_buffer[PKTBUFSRX];
 	int recv_packet_length[PKTBUFSRX];
 	int recv_packets;
diff --git a/test/cmd/wget.c b/test/cmd/wget.c
index 7570c065a10..d51650d5854 100644
--- a/test/cmd/wget.c
+++ b/test/cmd/wget.c
@@ -25,8 +25,7 @@
 
 #define SHIFT_TO_TCPHDRLEN_FIELD(x) ((x) << 4)
 #define LEN_B_TO_DW(x) ((x) >> 2)
-
-int net_set_ack_options(union tcp_build_pkt *b);
+#define GET_TCP_HDR_LEN_IN_BYTES(x) ((x) >> 2)
 
 static int sb_arp_handler(struct udevice *dev, void *packet,
 			  unsigned int len)
@@ -64,12 +63,14 @@ static int sb_syn_handler(struct udevice *dev, void *packet,
 	eth_send = (void *)priv->recv_packet_buffer[priv->recv_packets];
 	memcpy(eth_send->et_dest, eth->et_src, ARP_HLEN);
 	memcpy(eth_send->et_src, priv->fake_host_hwaddr, ARP_HLEN);
+	priv->irs = ntohl(tcp->tcp_seq);
+	priv->iss = ~priv->irs; /* just to differ from irs */
 	eth_send->et_protlen = htons(PROT_IP);
 	tcp_send = (void *)eth_send + ETHER_HDR_SIZE;
 	tcp_send->tcp_src = tcp->tcp_dst;
 	tcp_send->tcp_dst = tcp->tcp_src;
-	tcp_send->tcp_seq = htonl(0);
-	tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + 1);
+	tcp_send->tcp_seq = htonl(priv->iss);
+	tcp_send->tcp_ack = htonl(priv->irs + 1);
 	tcp_send->tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(LEN_B_TO_DW(TCP_HDR_SIZE));
 	tcp_send->tcp_flags = TCP_SYN | TCP_ACK;
 	tcp_send->tcp_win = htons(PKTBUFSRX * TCP_MSS >> TCP_SCALE);
@@ -104,13 +105,11 @@ static int sb_ack_handler(struct udevice *dev, void *packet,
 	void *data;
 	int pkt_len;
 	int payload_len = 0;
+	u32 tcp_seq, tcp_ack;
+	int tcp_data_len;
 	const char *payload1 = "HTTP/1.1 200 OK\r\n"
 		"Content-Length: 30\r\n\r\n\r\n"
 		"<html><body>Hi</body></html>\r\n";
-	union tcp_build_pkt *b = (union tcp_build_pkt *)tcp;
-	const int recv_payload_len = len - net_set_ack_options(b) - IP_HDR_SIZE - ETHER_HDR_SIZE;
-	static int next_seq;
-	const int bottom_payload_len = 10;
 
 	/* Don't allow the buffer to overrun */
 	if (priv->recv_packets >= PKTBUFSRX)
@@ -125,35 +124,32 @@ static int sb_ack_handler(struct udevice *dev, void *packet,
 	tcp_send->tcp_dst = tcp->tcp_src;
 	data = (void *)tcp_send + IP_TCP_HDR_SIZE;
 
-	if (ntohl(tcp->tcp_seq) == 1 && ntohl(tcp->tcp_ack) == 1 && recv_payload_len == 0) {
-		// ignore ACK for three-way handshaking
-		return 0;
-	} else if (ntohl(tcp->tcp_seq) == 1 && ntohl(tcp->tcp_ack) == 1) {
-		// recv HTTP request message and reply top half data
-		tcp_send->tcp_seq = htonl(ntohl(tcp->tcp_ack));
-		tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + recv_payload_len);
+	tcp_seq = ntohl(tcp->tcp_seq) - priv->irs;
+	tcp_ack = ntohl(tcp->tcp_ack) - priv->iss;
+	tcp_data_len = len - ETHER_HDR_SIZE - IP_HDR_SIZE - GET_TCP_HDR_LEN_IN_BYTES(tcp->tcp_hlen);
 
-		payload_len = strlen(payload1) - bottom_payload_len;
-		memcpy(data, payload1, payload_len);
-		tcp_send->tcp_flags = TCP_ACK;
+	if (tcp->tcp_flags & TCP_FIN)
+		tcp_data_len++;
 
-		next_seq = ntohl(tcp_send->tcp_seq) + payload_len;
-	} else if (ntohl(tcp->tcp_ack) == next_seq) {
-		// reply bottom half data
-		const int top_payload_len = strlen(payload1) - bottom_payload_len;
+	tcp_send->tcp_seq = htonl(ntohl(tcp->tcp_ack));
+	tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + tcp_data_len);
 
-		tcp_send->tcp_seq = htonl(next_seq);
-		tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + recv_payload_len);
+	if (tcp_seq == 1 && tcp_ack == 1) {
+		if (tcp_data_len == 0) {
+			/* no data, wait for GET request */
+			return -1;
+		}
 
-		payload_len = bottom_payload_len;
-		memcpy(data, payload1 + top_payload_len, payload_len);
+		/* reply to GET request */
+		payload_len = strlen(payload1);
+		memcpy(data, payload1, payload_len);
 		tcp_send->tcp_flags = TCP_ACK;
-	} else {
-		// close connection
-		tcp_send->tcp_seq = htonl(ntohl(tcp->tcp_ack));
-		tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + 1);
+	} else if (tcp_ack == 1 + strlen(payload1)) {
 		payload_len = 0;
 		tcp_send->tcp_flags = TCP_ACK | TCP_FIN;
+	} else if (tcp_ack == 2 + strlen(payload1)) {
+		payload_len = 0;
+		tcp_send->tcp_flags = TCP_ACK;
 	}
 
 	tcp_send->tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(LEN_B_TO_DW(TCP_HDR_SIZE));
@@ -217,7 +213,7 @@ static int net_test_wget(struct unit_test_state *uts)
 	env_set("ethrotate", "no");
 	env_set("loadaddr", "0x20000");
 	ut_assertok(run_command("wget ${loadaddr} 1.1.2.2:/index.html", 0));
-	ut_assert_nextline("HTTP/1.1 200 OK");
+	ut_assert_nextline_empty();
 	ut_assert_nextline("Packets received 5, Transfer Successful");
 	ut_assert_nextline("Bytes transferred = 32 (20 hex)");
 
-- 
2.45.2

