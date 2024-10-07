Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2098CF8870
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 20:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E9D588D9A;
	Mon,  7 Oct 2024 22:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Tx+qSSMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 324E388DC1; Mon,  7 Oct 2024 22:56:09 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20725.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::725])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3357C88D47
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 22:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAtHv0S/lu7CDdXuYt343VWq+sNoCCvv8XmpT3Y/FyXHrdOygfOIYb/CBXKScMd/ZEdPoEtw1ulPMfWPiRDDNPbnw8l1ZQ6vhJA4KTVx4o00QSfDjy1M6IJ8sOTnD2H5eENqk10GQXvIG+a1h+Z67UiLXCD/4BJqct60xoGOR64usdDUx+aWphgoQY31N+jyfo82p01QlUazo0dUF376p4jEm7sWt+mI+iygwhID2yKmdsK0XKKTr8fQPom98BL9suDrfXa2m5x3uu74V6FICO2xLEedi7SEQ4NPDEsqfmRSSQdaMPVfRmP7ZStmaEye7gcq72WgkYAffRi1PeSNsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62/Ol9X71yYtmZd4mikO6404dH2Sob+9cESn+PsecLY=;
 b=DjLPPwD4xYj+mKa7SYI0u72MdbGXFnctIJDsLBR1ETJKKqIyheeDTu1kM9ON0xvUCy0SW98m9DWK1Cvclf8AiMmCW5kurz12ZibS6tQIZLydquxgND8qnlRsaC8EftyyaxaZXtCJR/omBB1bnmjbccbAFCcRVtzmo6gNgwWudm68CZr5oaAFfLB0sHYyy/Wf5cR/lKnDtslbNnsc1m8bwp/1Xq3Gg8HWjgxUosX+bWXZKwp6S+EsFRgBULhVWI1scPYuEfReW5QANcJEwCoGAfjfWN956UEKeU1JbZ+UY9PP+CCamm6ZLQg2823emBwo5dqrwFJW+3VchsBEoD8mGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62/Ol9X71yYtmZd4mikO6404dH2Sob+9cESn+PsecLY=;
 b=Tx+qSSMZ11Uk+r/oKTHQyz9BNh6i32kowfKLrLNmr1Y8a3xkR28MI6I4ztJwa2BPo+hSgpvuwIuBtDnYAtVgii2DkZ+9vKbIVp+pCfACkYE5hQYnWWXBfNxMUODScuPwqsSfJZheyL9RYjSQrQ5A9g1LPMqYAiR3Awg6iOXxFjGqH0Ok5XIMfDRiXDzb1WRzhVPUnJ5+7T9080L9fyN8k45FqAUevUKSifpN2NN8bUkYvMGdL65wK6xlFPj0BW2lgitg63Ubj15e9AvZB+fdAHlSVO+XvqtVQkJ4X93VLnIFW2ubmbcpTxwYKmUWvlOt079F0UChF4S4iHZYf99WDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB7644.eurprd08.prod.outlook.com (2603:10a6:102:262::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 20:56:06 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 20:56:05 +0000
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
Subject: [PATCH v10 07/13] test/cmd/wget: fix the test
Date: Mon,  7 Oct 2024 23:55:37 +0300
Message-ID: <20241007205543.1632499-8-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 7c2dfb91-d313-461c-d948-08dce7127626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?anxWJRuytfkLVkTWufZTqwEOwVgn2/kRP6qorJDxZlRIaDBPaJQP7oy8JGyO?=
 =?us-ascii?Q?1y+s3fD5n0VL9ffnO3mza9XZfiLInpELSHc1++prrPnESEOWvmk40TP4dxXu?=
 =?us-ascii?Q?pyg8B3Bns0jsY0uD3QDyC9tdmfHd8JyTmFfhT1wZiOhXUddbI5V/k+VFgvvl?=
 =?us-ascii?Q?yeJ06EcOEqxW9jcyO8pFpV3P0rdINPpgNpggncMV+YRUcajJninuHHtXR6XW?=
 =?us-ascii?Q?4fOJkNdMZBZ6EISBAkPOvIw+o5EiFzWZovDzSIpI0PQjzL5fn+IDMBA24lTL?=
 =?us-ascii?Q?L5chvt3Au5oZT0ODh05T4++fO8/O0zhKGRA/vpUqxpexXPENWXLxZrNhsvgO?=
 =?us-ascii?Q?+upIJ63N6lbXIauHyWhktugQZMzGmMRtuMu0MjXenbtaJihne78tud0MOCOg?=
 =?us-ascii?Q?WzLNlkqrgqwIg8C8dFKxVhGPBNsTXqQBTBWnuKFCDdJiQy1MWANyN3dxHf3J?=
 =?us-ascii?Q?4M0hEb2bHYtgfaVdxB92uKreZpzC3jwmaPtU8uLZYbiNTIVzdGMO7X7Uhe7W?=
 =?us-ascii?Q?qKc8J8eTRhHVCa8aJcnYs9OhfGu51nPggOZ3mlN1B6e94CTi0K4ZX/Rl/sBJ?=
 =?us-ascii?Q?IFgDJ9/+Fb6XMSkIfI245wW4Q8erb41YbNnWTCkz+VpRZHL6r6JlHyvZpiMl?=
 =?us-ascii?Q?DXeK8Y7iH+yUMJq0830KEE+TikJietb9cKtAljklZpzL+cHlWq02aZA//GgL?=
 =?us-ascii?Q?QyPo/xL2z5yquXYLT6tomZFSueZ2UsSTpmszKpiUZEDSqTbc3+CQCICp3ayI?=
 =?us-ascii?Q?uk9zYC2kHjmunE6zPPTkGyrfp2aplBbgtCK6iCFHLNUSHwhlcxSA8SMQmryv?=
 =?us-ascii?Q?rhMrWEBZoDnG9DdAoKdrTU6zfXaJon3FMhycQuhxACfYxFJHwiJdP7cpzwfH?=
 =?us-ascii?Q?wfCK/YAiZDVuZO6QDudo9LNI7IVx8Md2U2vDTEu4TMG2RTMP4Ay/9yVTmnwB?=
 =?us-ascii?Q?IMaCoUI7ABLKQQjY0iI8q0qYVYPDoETcyohT9mKgfrZ3SYqZImb0/Bek+nuT?=
 =?us-ascii?Q?hf2duXJxta95uyXObUoIotzRgw5FSWfyoSLUIi9SVzxkH/+syqsotrUULmJ6?=
 =?us-ascii?Q?jFOQEdxYx4sQdUwAy65pSlnJWqofSDEGQp0+Q2xeme6Btv4pmRCRMomyEOlv?=
 =?us-ascii?Q?gbb5kkqpOnlmDh1xSBSPEqtUKvBW+y9sjH6Zp24/bQlok0zwJc2DQPIlUtWB?=
 =?us-ascii?Q?g4SCgrK8FYvodiWWIHHkblLTKrYSB+xN9IU3DXiswDu3FGTu10rtOy0B1yVr?=
 =?us-ascii?Q?fXKozBI64bIVXLBFePf9qTKBXWgqU/LfANRu/Bd7rHzOfr801PRZEu2IZ3es?=
 =?us-ascii?Q?HvJZIcy9xpSM07Bqs5GwzrY2SAxw6Hm5qOBQIzHkedpkCSY2kXB7oJ36cswT?=
 =?us-ascii?Q?SzC6LVU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jurciEJPffgImWY71rqD+4nzoHHao7jCC2g0EbFZMl1XNHO9lFno+vsxUHI/?=
 =?us-ascii?Q?cE7hFH5V23Jtyzjz9esfCpHDlKjFTIOY3jsqt6GvS89yS/Pl7BpsOvfx7AWx?=
 =?us-ascii?Q?m7ajfuzKnpubMZfbS1Z1nsu/9cNaQ++BrZhZXKxGOXBqLjgKltbsUj+FPkVE?=
 =?us-ascii?Q?WV8muJLDaigbNvC+FeislW5paYdqlCmKbhbLdPa230j2JkTYlv0lJ2HkMIcF?=
 =?us-ascii?Q?aRFxcIZIplJTGT3oSoK5ranYtyusKkKq2bPZb/YMbDqFQjX91oG8c2J8kc0p?=
 =?us-ascii?Q?dSVFr5thUK9xL4dK/U9pOKIkduWbKvgQ7kbkYbZhyNSjldO8dh9kl8u0DFEB?=
 =?us-ascii?Q?zbOtft9Fc0v1Jdid23d3oM7VZvRpeV+h+VFNkh1oXgx/jWUbk545Jq3v0uUq?=
 =?us-ascii?Q?/DlqMFe6ars/f5mVaU+ZMapP4T912aiCUt5Cvv6aY+Ex3LO1zzG+d8AgxAIb?=
 =?us-ascii?Q?M6BITPwSAdkjBeJ0Wte85mlUgvd5jXPPWAt5ezI6gvK7JsVmLFNv39t4b5e7?=
 =?us-ascii?Q?yvHV3OcstVZvbZkqjvYN1VMQXElgf2k8gP+juD8qLUWBhqCGj+BGUuq1RjM6?=
 =?us-ascii?Q?dMJz81dmLZmLEfo1IyP2XMn7P8npfxeJnYBJQvQVJsHwR6PdPMAriSCLr727?=
 =?us-ascii?Q?YjbvylF6PmOL3GlwGwz/TOuLBDfETcmsygqVNatZePQU4Lzj3DZT+3vJDkm6?=
 =?us-ascii?Q?ak9nOvFQeHjWay7A6/3Jkjhpry7LQbVCxFKquMZZKMcPeFbaGA3+L1z8XwNC?=
 =?us-ascii?Q?aiTwd19xC6umqpZ9Evo11aZkCgiFojLajiAsiIPAry9t++JxC6sqDsTQ3EtN?=
 =?us-ascii?Q?N0GJvxoJCrTEaMesIkmD8NR5XbLKv14d/MjV84xo9YHxH18vt+DvShMf0Fmm?=
 =?us-ascii?Q?NGSmeaoqGRB00b22eKZpCZKpqMutOBRCW2jsIlOsh5Bn4+f0T8lFHfq35v1E?=
 =?us-ascii?Q?uNJVNBR34ZYJOlflzfZX/2eEIDWM7MHbRliji4Ybpowkf0CDVYla0sTZjMkL?=
 =?us-ascii?Q?ImbGG9U2iFgNMWr/zmeNka10UpOKYymU4GPDeexnCtizU/lXS7zEGGBaOG7H?=
 =?us-ascii?Q?m65DNam4x0DyUurE+Tll1+n5ByQouJVlTEvHfYjmWEn7RN4FTrXktimFrYaI?=
 =?us-ascii?Q?amLp6D2t1aYqfGRIl4G9YFMFzHxXfPQ2JbldwGEuz3zYAGtpufAplQ7q+/bw?=
 =?us-ascii?Q?PFzlohfvJCixdRxdHMcMTNyvngX+LiIoqwC0apyp1pytimLpIPdl6RfCIM6T?=
 =?us-ascii?Q?lWqwY5zSJ6Wv8uv3g0HnR/n0vVndQKVbqFj5GeeCAGqjzR14dC68HD1aqb0t?=
 =?us-ascii?Q?Vw+ZswTQb7fEwfxNuTT/4LBmRqr/96xlkakZo+suuV42BSMWOBUgW3BNMQd7?=
 =?us-ascii?Q?/HS6j9t277XbYrm+FX5G8sxFE3Yjr5cpJ8TKWqbMI9uRSxAWgSUXpp+y2x7t?=
 =?us-ascii?Q?vQg5+9RV2ujxJA84EVJK43TXKo2KeBcVoVXdS+uQX3Y+8vEJNzSsyz+Q49Io?=
 =?us-ascii?Q?NOSfoON3Ywlfn3cek3F0JO2+pRmzCjopautnQlr4Efc7NJTXRfhdEeLt877J?=
 =?us-ascii?Q?7rR+zOKdF71iifN3C0D7jd91Fvgc5QkKCgMBGnlHNuSJ/08ciGpHFa9rhbW4?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2dfb91-d313-461c-d948-08dce7127626
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 20:56:05.8782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: we5kyAhqMhNrnS9MA1vLxpAvKbPvpDJJvBM/t11ga8ik+91CkGAoNGHkhCVhinISXXSH27P1djzFWii2gUeA7G1DMoCg/Nj9XOMYe/c379c=
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

Changes:
 * update to new tcp stack
 * fix zero values for ISS and IRS issue (see RFC 9293)

Previously this patch also fix incorrect values for tcp_ack & tcp_seq,
but the issue was fixed in
 * dbb6b5a: sandbox: fix wget test failure after fixing wget issue

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/sandbox/include/asm/eth.h |  4 +++
 test/cmd/wget.c                | 58 ++++++++++++++++------------------
 2 files changed, 32 insertions(+), 30 deletions(-)

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
index fe26fee54c9..a90ca4fad8c 100644
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
+	    tcp_data_len++;
 
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
@@ -214,6 +210,8 @@ static int net_test_wget(struct unit_test_state *uts)
 	env_set("loadaddr", "0x20000");
 	ut_assertok(run_command("wget ${loadaddr} 1.1.2.2:/index.html", 0));
 	ut_assert_nextline("HTTP/1.1 200 OK");
+	ut_assert_nextline("Content-Length: 30");
+	ut_assert_nextline("");
 	ut_assert_nextline("Packets received 5, Transfer Successful");
 	ut_assert_nextline("Bytes transferred = 32 (20 hex)");
 
-- 
2.45.2

