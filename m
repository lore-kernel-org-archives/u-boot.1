Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EC9E7718D
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 10:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C888080704;
	Mon, 23 Dec 2024 11:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="W8H8j5bQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A5AF8070C; Mon, 23 Dec 2024 11:59:12 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DD1C806DC
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 11:59:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hR8iCQKSmjKh5DUTFWzIDYP6A/fK74bIgo0uAJJ5LFMvHZ5ZUycMT6fOrJpfH7xvFFx0RetWuoqj/oMvY5LqEyafWVuHLaBU4yM9vMits0bAdaw7fplzBO9DQn1Ua2Rqxlwk2xvvg7EIeKtq0j2tpHeS/+kR5WhD1RO5ZU/EriCHqsDnXx5QpVdaCoa3/6oonj/wmG9K2Z3Yh4Jz6izJUnDFZlcPmqReGtnGaxO0hTy2KbqEeIO6f+tymyA1MgpSNM+qWWL6b2+EVf7RudE5bvY7HKh6a1dxULFdqhV36bU+fmloy6DV3kRG0Xa8Yzy5L1OcWhRENs+rFpF2sDMNnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=uCvuI4p3OJq67lX5744ZqzjnId1ayjqhP/iDJ3laUIEsc0sAvfF3C7uExUgYE1e1lYUMJUxmQy6GUygXo6zUccMsm0qxGZItPSJyljhCGBfPjot+13DoLiTTOj3mfTJUPrNU+dPv0s6xuon8J29A3bWmdvQOIzmZkZHwZrG0L1i4OX9ANKDKC5tppPzO/P7BKXjbpqf7B4EXeQNIHpJw0OvERZwxIIrvepOeDqoxc6USYW7Z1oIkKD4karsDdgK86UtQkQB3oXi835smbkWVLeQDHRfTynQqqUjXqP5BKrLeoJoVmbKrotQMdoXMNsSyljqbSDFR1dvWy2aRO5ocig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=W8H8j5bQPtSGojVaRyq20NlOAMOT7XzPvHwSmxcW7DSSEb80m+3grCGILq+3+CJpbNxxxEokkjweZdTztjBFsqJm/m7ihi6Dg5oKfa8IYNSP0/NsUmA3t+lMtcyPeudnH8Fwc+v4c5H26r7qROSCDhIOVDk8jDtiisjcixFBJZ/r5LNp1nOAQLxeSjbJXf4IOkAMTRI5pbABnK2xwSejQg447pZqHeUClAt51HGkgOjCpcmL0zaGwGdqKiWCrQF8ufuJJXuqE+qkZBtEge0t4tab1BRnfoQLj6H0485NzUt7nIX/C/8wzP5gurti3P6zKFZ73xtbiXnJcujWOTye5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6676.eurprd08.prod.outlook.com (2603:10a6:20b:2ff::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 10:59:03 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 10:59:03 +0000
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
Subject: [PATCH v15 02/11] net/tcp: fix selective acknowledge
Date: Mon, 23 Dec 2024 13:58:43 +0300
Message-ID: <20241223105852.1074404-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: ebbd8a4f-4748-4515-a879-08dd2340d028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o1yvz/LkozACGIgIkbjAwlJnakYcVdPnJ8WL08U4T+O1Z92uEgR1t0NHdzF5?=
 =?us-ascii?Q?+P8N3KS916loR7jQjo4WIf1l0Op2/uBh9lSTqdd4ryh0ximIB6R9N7qzD+n5?=
 =?us-ascii?Q?36rvsetFL6kEiOsTyFL++pRx8DXWtEkPwQ8E9kui0vWsNT/Z6fbz5BReo1US?=
 =?us-ascii?Q?bYnhyeVP7ApdNsXE39NOvQPZ266V7HlF4bWZTQjkAVGC0v+1aOMqKz/ZeKjC?=
 =?us-ascii?Q?9mBAZAQMQ6ENc/r2xJI5nUKJWVfxWdDeFuI3Po0Nu5XiQL1dSARG13xeyLMj?=
 =?us-ascii?Q?PGucA8YFv9RhFnMJ07x2ysEgGE/jp3CZRKsveACGEb0pr1ViEaVlxf6luVdO?=
 =?us-ascii?Q?M9ppJAmZNt98z/F1+1ghJxIIfGkLcyOzOWrFjJIM8e8QdT+e9zf8BsKNMBiT?=
 =?us-ascii?Q?tPd76U7xqG9ouDzVv5LJpOtZ0YIiJh1DZqb+lYlmFT/9/ifaiBBOPrfXdV1I?=
 =?us-ascii?Q?LLJM3318T+ezUIh5JHzzOYJYfkMcNCTUYjaKQxt92fk9CyyXeY6Nt1NQELfS?=
 =?us-ascii?Q?ji9o8fZvD6Q/7E+42apDXx26ugtXXWO7ep2jt2++Qgs8u8TGMaA4nWiJ+3cO?=
 =?us-ascii?Q?SBl6KFQrSjzE5gT7ulkI+wBYf2W2RDVx3bmTfHDc7NEthOcfe7BA33up3mfM?=
 =?us-ascii?Q?oxZdSN4EmHRq/y4QUVbvYI3sznMbJyC+yUtlQFoeTsyuhJxbtUf2xIibxVOH?=
 =?us-ascii?Q?Jf4nfgBdGAJtQ9KkPbaOZq3e3wjLI78KpMG+8CfYe0VF5C90EHiJZn3SnK8M?=
 =?us-ascii?Q?772x8Ib767fonZ8/Fm2n58xx/6CfkFdhTHIjMUwUoxdprA9kg0EWAM8c/1uE?=
 =?us-ascii?Q?Bav4jLgXsogCdRmIk5VCcAr8XEl6k8T/lKqe2i8t256BbA3LBF80fn40VUx6?=
 =?us-ascii?Q?4uzSHpDsQTEVZccKevPVfCZtpJPsGZWV1fcRFWkWYSxfAqxJ4EnPhg16cjpI?=
 =?us-ascii?Q?7wDSxYMv+DIHyTTHboP8YnTlvbYBSdNqd5dR7jB7M5UWNOHIjjXgs7qbwF4d?=
 =?us-ascii?Q?GCSzL3Y5r++mpjMTgkxTFqnwjy4O/smw2H1oKaFoWYXWor9Ug2KKMOGnCBb9?=
 =?us-ascii?Q?GunXECpglYEhHhql4pkJ9IOLpJmovjJX3PVHK97nn7moLRCWuzTV0hFpXDCO?=
 =?us-ascii?Q?LEnoxqdt2GB1nJZe09jHz8l4To/N/zVB4OoxrntA4dXnZIrPOq5DZ5u38tQo?=
 =?us-ascii?Q?qVfgpiURKuvpSwzugIlD0BqCYXBJmj5zoKAwVdz1WEEzvk+4b62MAf9fJH2j?=
 =?us-ascii?Q?WCdUSYXvFebf3mxdve85IaxLNXlYSsDuWkbrj+5AFrhalC9P2vG2fduyxgTp?=
 =?us-ascii?Q?baVV+/vWmNUD+fZJGpvIakEhw5RX1Ue6s8IQax7seXWH+jKyTyHO2Z6937dm?=
 =?us-ascii?Q?h+CmtJ3t3n39UShxfwl3ovaDwMM6Y1S/e8B7xgqiCO850d3YX4yIAOY8XblC?=
 =?us-ascii?Q?HDV3gjrO/EOdYNWT7rKCYXWRY/wCf74W25rV5GaXy0QWEOKYe0BJgg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B3Smb0SjjwXELZb8eWPZ4wm5/w3fEIL8rTxYH5Kpd08lGLhpX5DUWxuHqRVW?=
 =?us-ascii?Q?eHjgSOc/wvwoqdPl/JXkj95qEt8fc7TThcBuGYXpX9iKiHRfwkaqMpDOLN07?=
 =?us-ascii?Q?JHjuLB94G4HN/5CGKyVCVaHZYmODa3xGPHYVBUBzN4dkwMnfsbZtT2d5V7Yn?=
 =?us-ascii?Q?u1gKbvH+qD9EBsr/FF62FoLfja9lMsTf4Z799x0PyxygJxH/20sy4rerSobY?=
 =?us-ascii?Q?WvGtoJOdDNw7GJKuFgw5d5CB9Nlc79hfWZ3zXtVGnQhDvoINYZYdZOpcwfM7?=
 =?us-ascii?Q?jku9gZC3D3dLwcILOMy3L1rWe6NXcIHfLX1mfjyIVTXaZhBvuEE/HOHtwpVH?=
 =?us-ascii?Q?IhM21OFLOj7pvcJeONSjvPLQXY5VazS497813iGhLQw0Oyr/Ve5GaYaU2yI4?=
 =?us-ascii?Q?x8r2kgQbppf58n4ptqFb5q9c4EvPs+poJh+5bRmDoN28doKE3KZAdpax87OO?=
 =?us-ascii?Q?mWpGha/JI81wGgI+9E4sP9DupJu4mzz4PeJumuN6YkjKaS12Yee72ey8+gxk?=
 =?us-ascii?Q?9jwILB1uSEwUDJmHzxnFXndKqv4rpai2V44CAibbgwBgG5NdWWu8wipEst0b?=
 =?us-ascii?Q?Hy1erHpYsVZOPqTzXMKbgmKWh9WAdRYGTSQWItVz8byvpOBoawdDSW3tBMfG?=
 =?us-ascii?Q?pSly4EhfIXib1sCgkXcoFko865brw+VVdMrZfA+woRnkgdjVTxdE8aQa//zA?=
 =?us-ascii?Q?AOHCv4PJgHIMOvIeJuG0qgz1ctF/fPCxlbEyXc79jCxS+rGz751VFOtT0vZj?=
 =?us-ascii?Q?wkxgdvyex9213122DoCxs0ew5hKBReHZa0cgKdQiVinUJ3E4dhdCGR7lPN3h?=
 =?us-ascii?Q?3zA1a8mk4zwgcUggxsZ7aPYiFBGIwoc5+4CYmBaNkE1Y9/lIMm3LlxlS0eBj?=
 =?us-ascii?Q?6pYBF057i+B7y2t1dbIxkBEZFdHP4EYAQlC/dXopfIz2fVAgeNLqwnS9+Ip5?=
 =?us-ascii?Q?/U3dxTm+qD24rR28NsZxRnJ6NWGCT86ytwt88OAjuFwOPxACw/pLan/fCzRN?=
 =?us-ascii?Q?BDQyPSOUnMNbkR8TIbndC5NjrxJhK8oa1pOBk31LBreCxhfQqg7z/KBmGxLv?=
 =?us-ascii?Q?N7lDWMsDUrFGZAe8S+FdUjK8des8KBeLBpoo2sKJlJVbSMbkWxMcU8NOqQkb?=
 =?us-ascii?Q?/COjw7vOSCGJRfE3HIDEGpswNAcu3lKvvrkz5KvjnozdVRpUF+1RRiAQsd3W?=
 =?us-ascii?Q?+qBe5/j2Zmzs3NIF4gOpuAupGVpsWUcyD9hVsdwT6mrjgekYFmTb42kY8Jni?=
 =?us-ascii?Q?jL9THRFhco7FjG+dbHVgGMMlq5wq61C7XEPT5ezo/owvsIO1UUn/q//6MExb?=
 =?us-ascii?Q?SRL83cYyZPkJQXU/JtndIXYKTquUZvWg0dI6c79GZTkhJpvmHFqfQwRTCCVf?=
 =?us-ascii?Q?6nUcd20+4XA0IYaGxqHNva1c1iaiNVtOC6aNghgX7Bl2luHqRGOabHDOnzUm?=
 =?us-ascii?Q?Ol5as6dGchMwftCiUpbXa+0Nk1BPc+sT72Y2p93p2n7oan/moKrlM9kQdWTr?=
 =?us-ascii?Q?AI/rFJpH6ZbZEJyZOSgCVaSzuwaoz6lx1ICKzzHsDBlGsVq8kYj6RiAumH+n?=
 =?us-ascii?Q?9f9/DUbWdJpwBHomVXyYwEXvZWtxvclpF3N3VS9cQBlA/e63QanN/D2xvTVC?=
 =?us-ascii?Q?DrQkI3f1hk5bZNYs7RohGxE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbd8a4f-4748-4515-a879-08dd2340d028
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 10:59:03.4921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmpHmXyN7gAUaWXJBTnqtDqFScf1GCBiBydKxpm/Z91GcKVMj2TjfG5U+QNJ/TQd+PGkGVktvveWphzr/CPTKg/92GuNTkIglTZF68M6KUo=
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

Current code assume that all (except last) packets are of the same size.
This is definitely wrong. Replace SACK code with a new one, that does
not rely on this assumption. Also this code uses less memory.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 200 +++++++++++++++++++++++-------------------------------
 1 file changed, 86 insertions(+), 114 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index 3e3118de450..724536cb352 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -38,21 +38,6 @@ static u32 tcp_ack_edge;
 
 static int tcp_activity_count;
 
-/*
- * Search for TCP_SACK and review the comments before the code section
- * TCP_SACK is the number of packets at the front of the stream
- */
-
-enum pkt_state {PKT, NOPKT};
-struct sack_r {
-	struct sack_edges se;
-	enum pkt_state st;
-};
-
-static struct sack_r edge_a[TCP_SACK];
-static unsigned int sack_idx;
-static unsigned int prev_len;
-
 /*
  * TCP lengths are stored as a rounded up number of 32 bit words.
  * Add 3 to length round up, rounded, then divided into the
@@ -69,6 +54,11 @@ static enum tcp_state current_tcp_state;
 /* Current TCP RX packet handler */
 static rxhand_tcp *tcp_packet_handler;
 
+static inline s32 tcp_seq_cmp(u32 a, u32 b)
+{
+	return (s32)(a - b);
+}
+
 /**
  * tcp_get_tcp_state() - get current TCP state
  *
@@ -267,6 +257,7 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 			action = TCP_FIN;
 			current_tcp_state = TCP_FIN_WAIT_1;
 		} else {
+			tcp_lost.len = TCP_OPT_LEN_2;
 			current_tcp_state = TCP_SYN_SENT;
 		}
 		break;
@@ -353,6 +344,20 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 	return pkt_hdr_len;
 }
 
+static void tcp_update_ack_edge(void)
+{
+	if (tcp_seq_cmp(tcp_ack_edge, tcp_lost.hill[0].l) >= 0) {
+		tcp_ack_edge = tcp_lost.hill[0].r;
+
+		memmove(&tcp_lost.hill[0], &tcp_lost.hill[1],
+			(TCP_SACK_HILLS - 1) * sizeof(struct sack_edges));
+
+		tcp_lost.len -= TCP_OPT_LEN_8;
+		tcp_lost.hill[TCP_SACK_HILLS - 1].l = TCP_O_NOP;
+		tcp_lost.hill[TCP_SACK_HILLS - 1].r = TCP_O_NOP;
+	}
+}
+
 /**
  * tcp_hole() - Selective Acknowledgment (Essential for fast stream transfer)
  * @tcp_seq_num: TCP sequence start number
@@ -360,106 +365,79 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
  */
 void tcp_hole(u32 tcp_seq_num, u32 len)
 {
-	u32 idx_sack, sack_in;
-	u32 sack_end = TCP_SACK - 1;
-	u32 hill = 0;
-	enum pkt_state expect = PKT;
-	u32 seq = tcp_seq_num - tcp_seq_init;
-	u32 hol_l = tcp_ack_edge - tcp_seq_init;
-	u32 hol_r = 0;
-
-	/* Place new seq number in correct place in receive array */
-	if (prev_len == 0)
-		prev_len = len;
-
-	idx_sack = sack_idx + ((tcp_seq_num - tcp_ack_edge) / prev_len);
-	if (idx_sack < TCP_SACK) {
-		edge_a[idx_sack].se.l = tcp_seq_num;
-		edge_a[idx_sack].se.r = tcp_seq_num + len;
-		edge_a[idx_sack].st = PKT;
+	int i, j, cnt, cnt_move;
 
-		/*
-		 * The fin (last) packet is not the same length as data
-		 * packets, and if it's length is recorded and used for
-		 *  array index calculation, calculation breaks.
-		 */
-		if (prev_len < len)
-			prev_len = len;
-	}
+	cnt = (tcp_lost.len - TCP_OPT_LEN_2) / TCP_OPT_LEN_8;
+	for (i = 0; i < cnt; i++) {
+		if (tcp_seq_cmp(tcp_lost.hill[i].r, tcp_seq_num) < 0)
+			continue;
+		if (tcp_seq_cmp(tcp_lost.hill[i].l, tcp_seq_num + len) > 0)
+			break;
 
-	debug_cond(DEBUG_DEV_PKT,
-		   "TCP 1 seq %d, edg %d, len %d, sack_idx %d, sack_end %d\n",
-		    seq, hol_l, len, sack_idx, sack_end);
+		if (tcp_seq_cmp(tcp_lost.hill[i].l, tcp_seq_num) > 0)
+			tcp_lost.hill[i].l = tcp_seq_num;
+		if (tcp_seq_cmp(tcp_lost.hill[i].l, tcp_seq_num) < 0) {
+			len += tcp_seq_num - tcp_lost.hill[i].l;
+			tcp_seq_num = tcp_lost.hill[i].l;
+		}
+		if (tcp_seq_cmp(tcp_lost.hill[i].r, tcp_seq_num + len) >= 0) {
+			tcp_update_ack_edge();
+			return;
+		}
 
-	/* Right edge of contiguous stream, is the left edge of first hill */
-	hol_l = tcp_seq_num - tcp_seq_init;
-	hol_r = hol_l + len;
+		/* check overlapping with next hills */
+		cnt_move = 0;
+		tcp_lost.hill[i].r = tcp_seq_num + len;
+		for (j = i + 1; j < cnt; j++) {
+			if (tcp_seq_cmp(tcp_lost.hill[j].l, tcp_lost.hill[i].r) > 0)
+				break;
 
-	if (IS_ENABLED(CONFIG_PROT_TCP_SACK))
-		tcp_lost.len = TCP_OPT_LEN_2;
+			tcp_lost.hill[i].r = tcp_lost.hill[j].r;
+			cnt_move++;
+		}
 
-	debug_cond(DEBUG_DEV_PKT,
-		   "TCP 1 in %d, seq %d, pkt_l %d, pkt_r %d, sack_idx %d, sack_end %d\n",
-		   idx_sack, seq, hol_l, hol_r, sack_idx, sack_end);
-
-	for (sack_in = sack_idx; sack_in < sack_end && hill < TCP_SACK_HILLS;
-	     sack_in++)  {
-		switch (expect) {
-		case NOPKT:
-			switch (edge_a[sack_in].st) {
-			case NOPKT:
-				debug_cond(DEBUG_INT_STATE, "N");
-				break;
-			case PKT:
-				debug_cond(DEBUG_INT_STATE, "n");
-				if (IS_ENABLED(CONFIG_PROT_TCP_SACK)) {
-					tcp_lost.hill[hill].l =
-						edge_a[sack_in].se.l;
-					tcp_lost.hill[hill].r =
-						edge_a[sack_in].se.r;
-				}
-				expect = PKT;
-				break;
-			}
-			break;
-		case PKT:
-			switch (edge_a[sack_in].st) {
-			case NOPKT:
-				debug_cond(DEBUG_INT_STATE, "p");
-				if (sack_in > sack_idx &&
-				    hill < TCP_SACK_HILLS) {
-					hill++;
-					if (IS_ENABLED(CONFIG_PROT_TCP_SACK))
-						tcp_lost.len += TCP_OPT_LEN_8;
-				}
-				expect = NOPKT;
-				break;
-			case PKT:
-				debug_cond(DEBUG_INT_STATE, "P");
-
-				if (tcp_ack_edge == edge_a[sack_in].se.l) {
-					tcp_ack_edge = edge_a[sack_in].se.r;
-					edge_a[sack_in].st = NOPKT;
-					sack_idx++;
-				} else {
-					if (IS_ENABLED(CONFIG_PROT_TCP_SACK) &&
-					    hill < TCP_SACK_HILLS)
-						tcp_lost.hill[hill].r =
-							edge_a[sack_in].se.r;
-				if (IS_ENABLED(CONFIG_PROT_TCP_SACK) &&
-				    sack_in == sack_end - 1)
-					tcp_lost.hill[hill].r =
-						edge_a[sack_in].se.r;
-				}
-				break;
+		if (cnt_move > 0) {
+			if (cnt > i + cnt_move + 1)
+				memmove(&tcp_lost.hill[i + 1],
+					&tcp_lost.hill[i + cnt_move + 1],
+					cnt_move * sizeof(struct sack_edges));
+
+			cnt -= cnt_move;
+			tcp_lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
+			for (j = cnt; j < TCP_SACK_HILLS; j++) {
+				tcp_lost.hill[j].l = TCP_O_NOP;
+				tcp_lost.hill[j].r = TCP_O_NOP;
 			}
-			break;
 		}
+
+		tcp_update_ack_edge();
+		return;
 	}
-	debug_cond(DEBUG_INT_STATE, "\n");
-	if (!IS_ENABLED(CONFIG_PROT_TCP_SACK) || tcp_lost.len <= TCP_OPT_LEN_2)
-		sack_idx = 0;
-}
+
+	if (i == TCP_SACK_HILLS) {
+		tcp_update_ack_edge();
+		return;
+	}
+
+	if (cnt < TCP_SACK_HILLS) {
+		cnt_move = cnt - i;
+		cnt++;
+	} else {
+		cnt = TCP_SACK_HILLS;
+		cnt_move = TCP_SACK_HILLS - i;
+	}
+
+	if (cnt_move > 0)
+		memmove(&tcp_lost.hill[i + 1],
+			&tcp_lost.hill[i],
+			cnt_move * sizeof(struct sack_edges));
+
+	tcp_lost.hill[i].l = tcp_seq_num;
+	tcp_lost.hill[i].r = tcp_seq_num + len;
+	tcp_lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
+
+	tcp_update_ack_edge();
+};
 
 /**
  * tcp_parse_options() - parsing TCP options
@@ -509,7 +487,6 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 	u8 tcp_push = tcp_flags & TCP_PUSH;
 	u8 tcp_ack = tcp_flags & TCP_ACK;
 	u8 action = TCP_DATA;
-	int i;
 
 	/*
 	 * tcp_flags are examined to determine TX action in a given state
@@ -536,6 +513,7 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 			action = TCP_SYN | TCP_ACK;
 			tcp_seq_init = tcp_seq_num;
 			tcp_ack_edge = tcp_seq_num + 1;
+			tcp_lost.len = TCP_OPT_LEN_2;
 			current_tcp_state = TCP_SYN_RECEIVED;
 		} else if (tcp_ack || tcp_fin) {
 			action = TCP_DATA;
@@ -552,13 +530,7 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 			action |= TCP_ACK;
 			tcp_seq_init = tcp_seq_num;
 			tcp_ack_edge = tcp_seq_num + 1;
-			sack_idx = 0;
-			edge_a[sack_idx].se.l = tcp_ack_edge;
-			edge_a[sack_idx].se.r = tcp_ack_edge;
-			prev_len = 0;
 			current_tcp_state = TCP_ESTABLISHED;
-			for (i = 0; i < TCP_SACK; i++)
-				edge_a[i].st = NOPKT;
 
 			if (tcp_syn && tcp_ack)
 				action |= TCP_PUSH;
-- 
2.45.2

