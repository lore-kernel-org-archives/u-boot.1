Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D8AC52D1F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 09:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B20E68897F;
	Wed, 31 Jul 2024 11:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="V6XcIXgd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C177871C7; Wed, 31 Jul 2024 11:21:38 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20702.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::702])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 713D488998
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 11:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JD1AW2zgismqsYicPjghwd2ofEULwrZrkt7zO2r4hmx1KTsOrTMYFnR+4wNLsAhD/jwUZCMGg9LRk1VGwBkWIny9vZlPePJ9a+da/N9n/N+W5U9foPaKG5teAG+zxtKEQOICDMhXCH8ZIR61IN8WjyX0N5EnwglvWZ9eEcf8Ux39vfSrtw5jvW6P+LOESYSTsYHLVro5T/7CwV3oNiZJeagCW0AAxzCDENxur7LGkXQgAGL1/2TeTSzJT7Lv1FbbzQLJHzJK90G6ShjMbnnVf5qjwSIC7b0pDqaviQ7timk9wH70mRQ+aHYsm7a/NFfqASOjtqX1ddkh/eEGkW4gMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaHOLg157m/z9PpyW7nMAzrqOgDQGNnaZE3WYxpeOjk=;
 b=Bwj4Qhl5mj9ra2hXPWe9TTfA+/Dd9VUTnXbI3AjlpUVe88txi3KhzFvmk3RXpsofeTlpTl/gBLk1hhjWhj9AQj/34G+cCC6HjyfKfyw5qsDNcPMkM4zpEe5ZO9mQiQdPNep53rJEz4zht3yizcNez2VDR6u9oVWiRV36JiDLGzWMt/VHlCb8cegEnNrOGnpgICa8Oz6HfQBtyeh0pv0H4zBpiBiDRUOvrKX0A2Wf7ux1YaNshmstLroHA6Ejfe1Kn8Ew1mLdR0QobU7BmWeXoHC46BwkqqrQDiRhUlVspCgE/LeyaLN0uDkvLFskvZ210a+jViKN2DPxQD4eLAqyZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaHOLg157m/z9PpyW7nMAzrqOgDQGNnaZE3WYxpeOjk=;
 b=V6XcIXgdtaoWpwqtyzIonmJu0/XG/WlCbAcKLbSB/r8UlGN6NPz68PW190RD+ZymRtd4drLoJXATH2PSD5xSD9kQ6S9imZ3ROruHvdNB8S8+OIkLc3Ly+PMnz+7QXmLzSaki/sDZ6rIB15vr2jWMQWsAueldLUEKrM8FRdDM8n+QtekMYHCInE7ILhWL9BxF4JMrrtl+dF3czzDrb7cad8N/JXrK6bYHHZmCCZF0BB2y9y9ikUxmz1WFjjQc2lnIrSfQuAkr3+MRgL2IYwLjqj4HVc0tREFWM9sVcMP9zPoekXbz9i2+sXgZ3c6lh0/cx+h8cxPBfWl4e0qPOgy+5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10180.eurprd08.prod.outlook.com (2603:10a6:20b:62d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 09:21:32 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 09:21:32 +0000
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
Subject: [PATCH v3 2/9] net/tcp: fix selective acknowledge
Date: Wed, 31 Jul 2024 13:21:03 +0400
Message-Id: <20240731092110.4027134-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: a63b42e6-ccaf-42a7-e882-08dcb1422ad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o/9ckQB8slq8rPii9A31Jq1IZDkqCmMTjwF52Fr2FtzAfjLDha+QMy2npfH/?=
 =?us-ascii?Q?emFzBrDrQOqd3p9a2M6TzCGvOuGFkhaz1pCVNDa9L+Sr7Kk5fhCIccwq+BQ0?=
 =?us-ascii?Q?tkr2UbnToXEhvl+4evZTyBe+rvU1bToz9gfEqV9Lu8Hco7yBzaM6j43blCF8?=
 =?us-ascii?Q?QQva2QYCFe7X6bPOBObxliLj1xtX+gw9+/eVPpcLGcfcX8haZJKWzWjAxdn7?=
 =?us-ascii?Q?i2BpRiWzeyHdhzHs8JRE/Z3mAU/vTH1AZYBazG/ILi+8s5GDRHSZVxupyLlT?=
 =?us-ascii?Q?vH7cSmHpG6PRlFOb3uk31mkuoJc+aHrVdC9Kn8Ev7UjOno6WWi41pHpT05Ma?=
 =?us-ascii?Q?qjarB4pOSp2c/vqZUzsFfZKMs6Vagd4xrJ02FqA8Z84rIP2Y2HqTO4rZ/xUK?=
 =?us-ascii?Q?QNPeKLHbhMnXFMO9HAV+8MfE7jBT+5dCCLzjGoWRTbfkNdyMn2IBVmEuIv7o?=
 =?us-ascii?Q?DYI6ZBixnUwNNhGjyNzIuZHf27xIiB68n9UcJ4OPQa30yp0FkTK4AA8VKjbp?=
 =?us-ascii?Q?REYJhaj/rhg971DFWOC1DASYKQ5Wfbb4LSLhL8vyU3hWHDvxseiTdUInC46v?=
 =?us-ascii?Q?6jLjGlTw7Dlj+fpJXGjiBPw5fmKOqrJFGiaYoh+k6TCh+eCWAcnyo7CypOuX?=
 =?us-ascii?Q?B3jMUBJM+x34Ta7eHyOYG3b/6Ij32MiCpABfk8eIspNUHgz+J9LE/FJnYtLV?=
 =?us-ascii?Q?oXBP2BakCKE+JFHMlrgH0u4JzEXTB5XENe5VMhbzR2y5wBXTcHeAjgrSTGJi?=
 =?us-ascii?Q?koi4XwuL5otYqFSsezU23Dv1TPNKCRE7F2HKoHGZLrhdy3zXaVGkm/2bDCSF?=
 =?us-ascii?Q?02E8+08w8VpFkleJd946Rt7HnN3Mi4MSf9Bz8yUP7QxcT77Hs60QHeOVDiii?=
 =?us-ascii?Q?ykszF4oUTwoLU8zQiymi2BG9TrBwaxgN6vytEV1UID48zSdVidBBtCYOvJh8?=
 =?us-ascii?Q?rGy8H7mKMcCHFPk5r/Ag8XePMe8mddH8KH1EtJTgGPi0gU34rfcY/X+Pt2sx?=
 =?us-ascii?Q?Q3JvFxbMfHXN3XHSfE5PsAa8TXAYEfVk/WUdwQLQEY0+j1r4V0QbXMMsf4tH?=
 =?us-ascii?Q?WyeYsTQ+dfbP6bzLvNbTgenA3UL5oc4r8OH4m/kixrTdxf1xf09gQ4/BNi3Y?=
 =?us-ascii?Q?4XCcrJZSj3OtrPvXhaXa9e3+wMtwRqIeqQJRY2nht2DqQQfRabaOoBJwY3r5?=
 =?us-ascii?Q?VUQa0/KofkFI3gg7nodjzA0frN4yH9/whNz10HDfoHuNJjNAiMq/1zhiA/C6?=
 =?us-ascii?Q?BVxDA+AyJhpD1zyN+7PU8vBgyC/gTsGCVCAewvwu2r+2NTn+TK67tDHRx2qW?=
 =?us-ascii?Q?s1KQNs6S4tVrZ+jUO9hqlKZVNFzq5MT8MCh7JSpJwY/Bw16HI1EPEC9hwV8+?=
 =?us-ascii?Q?HEgPqLi9/M/fo2Krfx/horLUeGMazOWUPC7YG3l03Cd5iDgbM4YCY5UuHO7a?=
 =?us-ascii?Q?7Ee8fRwYnp4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F9pvQbxnk9UGiOn8c8cxJKRivGuAeLXeB1g41/o8v7FD8/qs4pzt/sSvjyU+?=
 =?us-ascii?Q?jTh3oSoa3JGRc72SkoxDhczpx7TQy2WYyGlCFCONczIKpVC7ILIX4XNuzinR?=
 =?us-ascii?Q?Zy89XMQT5AmH3Xnp/CDRQS3pA9/98nL+8Pp69fjpWqa9QvFNeFLtfzoFJENd?=
 =?us-ascii?Q?TDYLvU69dczBoafWwySmXor1BWONC4hbo91VYSHtigD7ufeEzaxNfRMlI+xx?=
 =?us-ascii?Q?exHXRihVFVeSJZ8vc8jMHmtDUaXbjbiaJVOsZ5rURqvb9PY7hauzBCjYODsU?=
 =?us-ascii?Q?Q5jhiho8Bsc1lFm69PmtiZhJaKLOfxDJ5ugnGbQHzQbW9AVRCv9vQ58YDVCB?=
 =?us-ascii?Q?548nEThW6QXZJyAAES+hS89Btmlkw5BdO45SZXY7DgOGgvHX+Yfprc8FKCPG?=
 =?us-ascii?Q?lin1HyN4Hpp9Arm8mUVC/+nDGXqySTfzpI5fSUYGXI1vaI07F4N/zF0mnuny?=
 =?us-ascii?Q?H2Sd6PNS9X5Vn6gslDixBxWLMpYlKdJXz7NdO0dUcAReozAVEV+C5N3Sck+w?=
 =?us-ascii?Q?bXb4AP/S6DrHdIBsdOvaoLc3CfVXNBtaiG+Bug8hVQT1oNNMHopthbTH/i7d?=
 =?us-ascii?Q?tYbFnSsfQT6jjBOgNmYY7K7KVy979IBxKnDumnWkudEot0LbeWzSfJ3LWolq?=
 =?us-ascii?Q?N5rwuchG0UpfL/bcYIIU0NDWLOe2F4yTR761zRd7mICZpn0vZi4hes/zKvrF?=
 =?us-ascii?Q?Kt5F5A2yMPCvEzODaFsmuDIM+oF7xYRlLRrTd7LezFCk2ZxeWJVw12+0FgkW?=
 =?us-ascii?Q?0qcC4YHk17eo20whdFGthU6TfTqrPeHv90pMGyD7pSME6KWdpk0NPOm/95SV?=
 =?us-ascii?Q?sQBw8TwF5ufoh1aWBhlIWRPJFkqLZhNNTvvks3dCyRjbSgcSMNkzxdY4Pgg3?=
 =?us-ascii?Q?qQL9PfSvN/Wm7s1QAWXu9ub7Si6jiJM7RTEok1b2Z9x0kFptcPtOh6jp6kVf?=
 =?us-ascii?Q?kEsto3f82s2f0zwrXsfji0Ayq362XIy0EUwFoC+r2wSkcNpHAlNtXLDLqviP?=
 =?us-ascii?Q?s2yBgpMCAn+Zd39f8/PrfhXkjpffD131bINKsYsTsplQTU7JwwaOuLhM1M3K?=
 =?us-ascii?Q?kTZ0IIj+0U8Ffb0bfmHuUcqeRQGs5hx6FACeaLRRmsLlD5Qze9dZM0+F14av?=
 =?us-ascii?Q?P86Wb9BmFQN497W+hC2J9w/Zim41NUvMrhMWjNpXBikhSnc2A9WOCpQY+5ub?=
 =?us-ascii?Q?WuoGErAtl8mveCWJ01HBJ/BLlt7q7nPsvK8U7q+uqLajpBD9n2kuDP/+mqJk?=
 =?us-ascii?Q?uj2sfvfG8R1ZM0RSs85wIiQc/LjCZ1IimPusmnPj9M56rtsh8qJ4FmdRC1j7?=
 =?us-ascii?Q?a0jG/f5gKbWwVHGGhvwI/j9UyKk7MkP/KfeWNzhg4wGc9rnJed+3vBoyepEs?=
 =?us-ascii?Q?kWNT6TJxpz+yDALyWOMKzZxYWMQRa6XTK+Tku6Zg4J/IlC05beeVO9AoLI/4?=
 =?us-ascii?Q?du88/MsCHB84HisUkemzhkik9+Hfo/XHPXbSFWmlM4G56pxh1F2wl5RUFV9u?=
 =?us-ascii?Q?A3hrnUkJ4S2K3wYqhXY6mLgeK54UV+64NYVD6GvlyFWa271+hugr85dtlypR?=
 =?us-ascii?Q?2zCdwoRDr6g/0La4xoSbJHZsqfQTqT2YMnCEc95eNrqkUtkfcWSSLq0k+nqI?=
 =?us-ascii?Q?dxPsUJ6mqLE75R8tcztTncs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a63b42e6-ccaf-42a7-e882-08dcb1422ad0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 09:21:32.5665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ay55Ipn45PMiBruL89OnOCePgU81cS6e3YN6U3VKCRmyClnOTRCIxY0L4aQfXeeuv9IpodcPhpCxq7zNpwMepwqql7LYOsreQfUvosfchbY=
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

Current code assume that all (except last) packets are of the same size.
This is definitely wrong. Replace SACK code with a new one, that does
not rely on this assumption. Also this code uses less memory.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
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
2.39.2

