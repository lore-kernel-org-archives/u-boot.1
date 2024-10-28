Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786BBD3398E
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 14:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD9958911D;
	Mon, 28 Oct 2024 15:32:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="YKQVYMWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1453689100; Mon, 28 Oct 2024 15:32:09 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20706.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::706])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B60F3890EC
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 15:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qeogXz5O8viVJp+VjeR1SEZfcbbPm3FYsAc7+VWkn8TgkoCl4x2UJmuY/okL6tMNzcyXQXXcvoEB0LdPsdhAEqQORzvhpuMpBxndv9VeYcfH4pc3aNNhU71A9bRDWTsZt0lZF9IxSV/CqyS/LfWamIWRWR5YaGb3VvFxoiJp1PqdpBsPSDbZP2KyBte3rpC0G9rlRMd5ivwc2zvHA/3qaSbqiQIhQDz29Tx1sCxUqIyTpjkWDdoYu2FWYJ3TBjagYbRGU+Crfzw72tfXZhKSWvL/R3YvXWUYT4rbWQnaQZhdL1HyQU/lP7XKB7PG6XcPizCw0mV9INztrjvHXp+wAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62/Ol9X71yYtmZd4mikO6404dH2Sob+9cESn+PsecLY=;
 b=gYiksWeiqpLZXimDdcDnuXtAyWf22rNBz6CkdxczpWhc3qrZBxOOAC0JPR2MJV0EcTkKe1bN2bFEVWEVtR7tQMTVJRUiEMxprK7zZu5nF/nhTw2c5UGLfySzRcvNt08ZQDBnRvOwvYGbcKSnpviAqrGZJGlhPeuuOjOVMpRtgHRwfoqErkxo7us8BTQRRc26Op94lfXTc+n2pizZByo3GC0GxjawAA+DbSc2uVzUNhwMit4+kvY3rCJyMPRzDOJcVN7tPP4Xe+u4ebEYClcdM8aoWetAp9zh9+QKJ4vXf/JCOHcggQikj1aVbAfqtam+mXu2Yh9ht7Tt+zyhXG5QMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62/Ol9X71yYtmZd4mikO6404dH2Sob+9cESn+PsecLY=;
 b=YKQVYMWFqALeCE3TUDQNHrA6r59C46JKq3g6dlNXJUPjlA2hTPeEVjsL68UglpEBvZayLMlYx5sDh886rrHFd8dc74x6A1klZoGfh7Io+SR8WIEQBWkTqbUexXI7hK/HDIUZyQ2Vs9DBUUDk0NqnWpEyShqZ4sZd0fwVv5Yl1DfKWdHyytmrqHCcLDIJxd9IhvX1eGy7blNpssSgQ9biGAC/4yNDcRTa0X30S0B7mLpwW1sdQo6Z5JhuHmoHiCkJqgu+G0rsl3P90Besbd86RZzLBqiM9nfnSd+qNUU+uf4Teegkod3WvkOrCj/ryCNrkyYYUGJbP+b83O4kmCURFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7714.eurprd08.prod.outlook.com (2603:10a6:10:3be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 14:32:04 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 14:32:04 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v12 07/13] test/cmd/wget: fix the test
Date: Mon, 28 Oct 2024 17:31:37 +0300
Message-ID: <20241028143143.1807305-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0101.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::27) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aac3544-a00f-4eeb-8592-08dcf75d4a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5yfvLmqdD/LqjcPi/w/SWEszNpgIO6KOrN6/sIC8LX0W44BeVUk19pIaWd8y?=
 =?us-ascii?Q?94gWBussbR3ry9dbfvLL+kTUZ5F85ZWPO2FGFVAFDoPAKw69RnuAl2bFkM7x?=
 =?us-ascii?Q?TDHDhEpEr9D9BVZVaHe5PUGeHyOyJ69V0mOtOnmtVNxduJYRaIht3ipmf6SF?=
 =?us-ascii?Q?N/wfs3I2ooxGaCOc7dEeVXdo0LGCxlSJHk+J58o5RVv0PVO6DgbinAyxO+oy?=
 =?us-ascii?Q?MthltR/RtZULIRdofHiL5IAb4FtXTt9DXvhvE1tNOEOmO77B9Kzosm94SHQ2?=
 =?us-ascii?Q?xSnzfoXUZTnykWUrJDsFtVMw3A3WAjLXRfXqjgDpf+ftxtTqCWXxwmk/etva?=
 =?us-ascii?Q?qnyFldqS25ENBSFEtL9euf3wLCeXNnvIAsgtKM9x2utEybEWY1hlkgLRMZVA?=
 =?us-ascii?Q?9W1DmTcOk4ZtruDzMBUOyyUt2E5LQg5yjvbkPZXe/O8/nCUyJOvYm/aP1Fge?=
 =?us-ascii?Q?XGaPiuLE1OIIyOrZ7iP5OOY+GkXBtFlHUPhwDVBO9S/w9aFJcIXoAV/QpIDZ?=
 =?us-ascii?Q?UIPX5KJRBFkfhwt2hnhn+Vh7YZlX8xcXi21RfFJDjQOEka0U9fD9r08oG0FP?=
 =?us-ascii?Q?K4HO+dMwwLS2QINWqLo3f2JMcqTBSLADKfXg0t9i0X1YzM874G5G7iPt73Is?=
 =?us-ascii?Q?tHL7EYPgofXLwtGMeITpL03z87dpHo9B/U231C6DDoAzZciw8fCFv1P4uRsR?=
 =?us-ascii?Q?qipU1g3b9fLZvkDzBDb3NeuN5lYtUWaiu/50aq1V8yRk5JrurUU+Xzh0Mstt?=
 =?us-ascii?Q?+lSlvlw1GCfb6vw8c+fBv4yimbG0Qdkzgy8gRxrCxHyDaysLL8daHXJkQ3k6?=
 =?us-ascii?Q?jCumRXlKuEHwzl00YRI7ti2kgu1EdaTEiOx1QQXPKLaam3VjVHxa9lCfhyse?=
 =?us-ascii?Q?6QlX6/L0IFvXwvOLmxaXYOiEPrQZFx0UKkzmC3l8yUQyuAquhrJ+soF/6zSx?=
 =?us-ascii?Q?bf6Xvskm7YnR8GbZZLldenmx+QS9RWO9a4NY54Y30xNtpXjComoh9XSbh2wj?=
 =?us-ascii?Q?zBQ4/jS8BIYt9j9ldU/i1pXkMBO8IE5zMLS1PU2sfWp5xmDmGGkaJKSbuA69?=
 =?us-ascii?Q?oIrOgo7pt/PJq4aymwKov4w+GaP2sY/k2AH7TugxJOxIyPoRSGsU0eqSDgaB?=
 =?us-ascii?Q?9Rfol+oSDaIQ/+sEMUR2/Q1i48AEsbM1Rjb1r78JUoV0Ty7hnnJgR+wwSRDz?=
 =?us-ascii?Q?n2h49+WjnpD7ra6RjPIo0/C9PBTY8wQy1ICTwsjRkyBxR16M0mrqWFs7CtDu?=
 =?us-ascii?Q?rqD4fE6jTJaNnns/G7FHDkTynXG5mVgOQZMXixGgs//8Hc7Tv4UVbseWOAET?=
 =?us-ascii?Q?h+WaydaKbXeZYAeC6M7yhwzUTvAg+mfsAINXaAiogcom9zqNCJ4ua8KtI/R9?=
 =?us-ascii?Q?AGqNk3cREt7xr7q+WKjNYnuOb9AE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I9lzG5QcOEfu45cTiXX2P9bamZG2GJnKpi8R8ztGRup1yW+hI43o3QzyvKm3?=
 =?us-ascii?Q?XpNUkZekWJF3Ki48H90Luv7JreAt35jvyZgXY22GOJcDh4Xgrn0CvjDTwOGL?=
 =?us-ascii?Q?CVUNAjwvbjXMUaYYajgA7WLorfylYUnLYZ35mv0MC11uuj+F0/z115tMhN35?=
 =?us-ascii?Q?NiIOiWhzFhdbM+z5n87x9QXgyEJsMZhuwJlP3coQd25u2RP+CY8RV/Zr++oV?=
 =?us-ascii?Q?nsVXJcyl/5jPgE3qup3Is5h+HvPmYVWAgU0qOuLIJc80hSMsn7c625Gn37o3?=
 =?us-ascii?Q?KmMO+x6jhQG4t+jm8TNWdjUofR/ooHxlVkVpEeWWdTa6VjYP5KA5RGUvJ2D9?=
 =?us-ascii?Q?Rb3VgMgJs+XZb4kerLuuiWcy9/8/gYrwK+SgU3ZovGAfqKgqDWS7P6Y5y6tU?=
 =?us-ascii?Q?IeaRN/t8HXrDgy2iNhcaKAg/19RPBHQKyS1HG24EBJwYFJ8pdiCHDfh9KFfK?=
 =?us-ascii?Q?cOYPPkYSVK84FohcB0SWUfaGotQsO9LAyvo3iExmkK41JySxgp92Y5S9tBGc?=
 =?us-ascii?Q?CUywB+dOKLr6VlUhtyJlHZUxCX6bqnDqkv2g/e+IDD13SloybyKQyyHIQE+C?=
 =?us-ascii?Q?KvT5YAonxr9tAwyQpU1AbmHPT3YTS0FNPTByLpM3nEoUYVuFampbvKSdXUIH?=
 =?us-ascii?Q?CTS7/hwnaRzRPAPbrQaOp4BCud4xwcxUpLkPPG7PF5pnn0q69coTMLfDcyVE?=
 =?us-ascii?Q?49phAToADAssLWLBYRFqaitr4J3ZmzufPZaBqP13XtznWjVhgFEL6kRYdjBR?=
 =?us-ascii?Q?ic735tlKU+bB1tGVZHDRNriUDoqtLk4OPx2/hpLMuTwPqppwDhSv1tGzjsep?=
 =?us-ascii?Q?7sWpF9cxApXPYsDnJ/v2KTxNP1ItCV5xd/xb+/FKztLCtb+jIQreY0RVu5Wr?=
 =?us-ascii?Q?pzV+tLvGrgt/bLS8FIyuVyWL66odfmqvjmQxFzCQ0d0XKjUxNUT8yj1fSaaA?=
 =?us-ascii?Q?9UqAdq8Z7wgHspC4VDLLv3hIEklrnRBF+RSwP8IJtbTl/2dW8dyJXIAHrdEZ?=
 =?us-ascii?Q?qk7TfesDxMI8qSetki741RMFVlIcXmPLLlB4uK4pHYjdnSdNfzoLIy1jV7C5?=
 =?us-ascii?Q?OUGRiTK698acehyw8IpDu7t1KN6lPH6fDijNe4tVyDtcl/0ol6TWm3ObXhrf?=
 =?us-ascii?Q?MKeNWWZlIGcbGWzy0KuCcRSWA33Du2LDRrXsFGBStZMCRZH/ekHjXesKGRCr?=
 =?us-ascii?Q?F7fUfQViJ4DOqrB+tqYZ0xZ4z6w++8qtMQd0yWVRb7rEJtwPfwKQNXVKetZy?=
 =?us-ascii?Q?7NH9wkuiyt8u/5D93SruFU/F6dD/8inJ1FAcaF/3MtDfIHTPUaukrAtB9Cze?=
 =?us-ascii?Q?M2uYT/+GHmCVQ1kLjlhPAOKo2mrJR63FhFCcAQEXT8tMo8NhHGcXfzvtQc/c?=
 =?us-ascii?Q?O0vKX+bqnswR5oy72Lhlqj9Mfr6AzzUVfeReh6Xve27q4ngeg3TeKaOTar5C?=
 =?us-ascii?Q?/kWkCKGzsl7f4aiV/LDi1L1txPAy/YgqaZP9PyiG21iZTCnNG/CwujKaKjt6?=
 =?us-ascii?Q?iY8ilbhuVTJHQpFq+aY54v35G0ZErNmueMEgAFoycnb4R3trEOeKmdZcAMYY?=
 =?us-ascii?Q?nfXP6ClHTW8pNnndivrlF4nF5n6xCJ2GI19iL/XlbiMfUTU8Qr8+SB3e2tMf?=
 =?us-ascii?Q?ThCgeqQa/rQ4nRE0gXGKH6Y=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aac3544-a00f-4eeb-8592-08dcf75d4a50
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:32:04.6456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUjEQD3rVEa31oaD5knvTLeprHvZWDM+bLdO6qjLrwb0XcHi1621brQiLi1z+EMaCNeIa7/0A9CErFW10aaD67txwXPINohgWYGxQrsxRYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7714
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

