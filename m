Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E61C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 15:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ADFB8899F;
	Fri,  5 Jul 2024 17:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="cx91X/0u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4814882E2; Fri,  5 Jul 2024 17:04:53 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20719.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::719])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 794A8889B4
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 17:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQhr8PA+KsGsp/fV7TJR2ua0HCsY03Y8xOHX7dyUZ1uog5Y5cknPxGnuE1O7CZMzk7opeSr02BOgagjbxy8JKbhkA1J53zQvcWR/q+AlYE57x4Aqgp/efZZ87c93a/W7KJHw4XmGQQ4YamjB1oO60KSWKoWyLMDNxc03FDAW51qLSalQp3op3KpQdnh17gkOwpxHuIgm0AEpAIeYQd1lSweW+vyOrO9QIP4klWW73iF3iyb0IF3FmkZIR8LZnU9jCPZo6qMh1vgHbN1zjj3kwFksQjzErwuOp2q8h6IRYfGjzC9qwXxySt3x1Ve9bUoMKg+UUTPgRW7IkGnW4Z+7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ug5KDLlyVfhPewo53tuXcn2gSpK+rsNDwf/FJufonA=;
 b=PiGZcavgy4wU/jlvnPOfkIoSe1h6y9BeAzpzfwPCwpGlTKTeBTEAOz/dvueziwDcj5DxffCTSVDBqbiQV2tqpn9E5L1ii45/QHhrSHHZqqJaechBpx1YHJwfuIBtgnL3MVB5y/r+BiTxesfcQDSi9AmtgtlaH3XVNp6u3i30UhIWxNDYeJ1zF2RpW5Ltt1zAB7qnEOBvUXnPYtcMKyNbFdONu0pXwphD9tTqSM1AWkUYkeqFktSIwmTf/S5M7hPE2/RGKgotXjY4He0P8tWPgEyfU7VXoBBOiAfYpmbyZhz7ZboXxcL3qKcCbfLyEM2LTUMvp/J/83GiHj/hk33TxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ug5KDLlyVfhPewo53tuXcn2gSpK+rsNDwf/FJufonA=;
 b=cx91X/0urMfTzFJcNJavsUDWOON1r7QXJLMJRW73lJEiHIdta0Z4NDjGOCRAV7jpDg37jVSZk6+D0j5ehiLc29a7HFdLzbTH9hhUcyt6zitncy2MBitoKaONltxdN9x399GGjRCJgxGLBJdNuBc/ldV+fKGTIi2N0qb6gIaQzrYiQEInoSDM/vRzW1JZjbezeaaG3smdKpUaY4UcfLPumC6W9fvLpqhJ1V9BAXnZZhGtUQQfG66H+qRlgIIJrW5Rqn1Bir318guLiT4bC6vkhMhnAc2L8M9P3iRSwUVfkKvjqaQIaa1s81lH+eZZo6w535swm3Vduhh2hScsGXa0AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9834.eurprd08.prod.outlook.com (2603:10a6:20b:605::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.28; Fri, 5 Jul
 2024 15:04:49 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 15:04:49 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Marek Vasut <marex@denx.de>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 2/9] net/tcp: fix selective acknowledge
Date: Fri,  5 Jul 2024 19:04:24 +0400
Message-Id: <20240705150431.2274662-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705150431.2274662-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240705150431.2274662-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::22) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB9834:EE_
X-MS-Office365-Filtering-Correlation-Id: 36db0741-88c3-4752-7c48-08dc9d03d0a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Iyr+k96BO17jpZgQq3L/r5LhZq1AjCnVMEzrNTzm+xd/0Sb3JDHwlKZgZ2+L?=
 =?us-ascii?Q?ay96t6MEtBMYUMv1Mz7L4vq9CLQDESeKYplz+uiNsVHIKvBSNKie8gIr9c5i?=
 =?us-ascii?Q?kCKdPWR3cqe42Jb39t34cZfaECldJrSoyRoTyE0vCEvyBY9Kca8JM/n1Sy5U?=
 =?us-ascii?Q?vXoULTWNQnRPqmTnAFGW1HCPnWNjvvwsdF3trOwLImLb8icP4ScRDe02p5tg?=
 =?us-ascii?Q?WqDsISl5N8Ze7aNmHjcSYfob5NHzUmhDenrgfu7c5zUrEClIy1ltKJ5YbUJZ?=
 =?us-ascii?Q?UqPORIZwme35ka7sf/iq3uuXIZO8LhQ7iTAq+jUt6oebeXljh6Cs7fFqpbn4?=
 =?us-ascii?Q?IBNggRJK211NSnDpbPVEO1FfigWdS7HIMshjWpfoLBSZqXmTUZYZ6x9I8rNH?=
 =?us-ascii?Q?vibLs2hWAdG7FuRz5Hmz8WwIZWImmdbLc3jYct+oJfQYdrvVmvTu4s9FJMkV?=
 =?us-ascii?Q?wvUhojr5Wb9wtbHahoLq7JGkLBhJdXrj0fMCqx5EBsVi2VDwS6GrU2sD94kX?=
 =?us-ascii?Q?rupOY+YjTORndgBFRA1L70dzEsdN7JZDUpvL8NMzTRepnlpimFbEOc+yBrKI?=
 =?us-ascii?Q?4+vpfKrt/eiCmqhxUGahFO3vhlBxZr1UHtPpBAAqYrdaVDIhmvzwz3NjmLEM?=
 =?us-ascii?Q?C9xaW2f8Kij5eOhDyWw2E4e8sFcHiDON4KqJDTUByzzLk5XlFL2bNPa3r4xt?=
 =?us-ascii?Q?WvDbtauCn9tH6Bh/N7cL9eEm7VFfNwepb5B8g0zxWOM2bBz7DuJTor09u3x2?=
 =?us-ascii?Q?gib8Oh7NCKuhwrA0B0DwZLmQwGHSlGY3ByBTRhOUdNFsW+jtE5vzGsvdY0ux?=
 =?us-ascii?Q?eELS7ubv8O187BHT+HNDRB7kv/MibhVwLpLEOk4+0jIL7p7I92DU6i901VOW?=
 =?us-ascii?Q?j8v4qs3JR0tfkIXcBZ3yx4TM/omLadflcSvNI0Lb5PY3EMM1WQaXrBZLWQFw?=
 =?us-ascii?Q?0wzozBWa6CbTrSuPzthNSRcV8XNNcItceacRjNzmYJ68AX4/ZgZngnnhn2K2?=
 =?us-ascii?Q?Ad8pTLS4+XFGDscH0PiEin6x/I1Jk9Chh4LRM0yVzg4lKfPRd0hmbot6jD4V?=
 =?us-ascii?Q?rURUWIcFqm3u3bQBbYBAzRUaurlmkwQwwYT5258Fqo5xlcFZxJpAkNNMsXrm?=
 =?us-ascii?Q?0mcuUbgTyDv1ss1zbSz5tygMmoVNWMkbV8FEOB/p1Ijp2yBkPtd+qXMmVPRH?=
 =?us-ascii?Q?CuK/Wn0O4cEY199MCpNC6KBJ2c6yKwhD1Vi4UR5BJnSKhUWab9Yo68+5w5hv?=
 =?us-ascii?Q?lAY8rSkQ/IZ47qRpRy1CWthcD1hr3WcwFtzxbnWiUzOm+NNfrt0tvvs6FEbJ?=
 =?us-ascii?Q?DJUywN7N9CotX79/KZnOMkbacbbBpSP+FyoS/zm2BIOOxQFSNplAXpeZE0zb?=
 =?us-ascii?Q?+Xa7Hn/69+xRu4qVMlDISEMLYDQFUxfmtF6Vn0cp69IQPnnX6U3NdYaIa0EL?=
 =?us-ascii?Q?zX0EBLYl3kQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V6YjJKGk2RCWTEPUcvxPxZL1em6ksAln0sp0AaHPldMhAfLJiRJw7zjhVKfs?=
 =?us-ascii?Q?XWJtZ3EyqCzLA/WJxXcW89OndS6005MrCsD/PULbrj5WZxOhSrlNO7aKXHgn?=
 =?us-ascii?Q?zW2PRGs1nPU1UxUf5/mJNtALGeM/3VlWaFNusSdkr6uKwlO4f+Wb0nOoLQw8?=
 =?us-ascii?Q?m1y6ElI3gRzTdhmN3nhBSctr1zCS+vQlIp2Q9DqWFzbRe9VZmSSAs68Z96lF?=
 =?us-ascii?Q?NtK0e9VLTNBghUriOtsdlioLVwMXzEhBhZw4AUgQA8gk6kwW5lpi//7XCAZk?=
 =?us-ascii?Q?iIIPqssS+Ec/Zbz+hQNhToYvaGqfxqrQpRZ0LoCiNxokwSLxn0vHgBueIgK0?=
 =?us-ascii?Q?Vjr78riAsgbmBJM6i0NDbj8RBOYrpjVF8CXUy/JD5JIT3BbMeqJEskuK4ozZ?=
 =?us-ascii?Q?QHTsvTgGnUqSOZd3cPhVseImTTiEjHNcdNLX/PJSoi+iZV3slmIwjIRUwY4I?=
 =?us-ascii?Q?Q0LipzPA9P5Gdp0jv6boEeaUFAe5G6MQt0A+qsXIcozPBLGIAtAzuMCu5W/3?=
 =?us-ascii?Q?VfEc/smJ69CL1yKsoONgRkbry9FUt2zBVpc0Y2EU7Uf5bFwOcpvXz0B+N5Xi?=
 =?us-ascii?Q?g3MFfmQohLo5A9Wy9GkpGFlg5hmxf7cWKfOOeXbgrI3ZbVIAeDbZo5Hd2sB1?=
 =?us-ascii?Q?CRduLgRxL6+UpSQsFVnxrkY/acDDU0MMTi0aybEIWZnpwSLs3vBjpPP9Zerw?=
 =?us-ascii?Q?fodwsnsoTItyP/ycAcJb02dxuWdcEqSnuUNkjWBSMQ1yPE8kx4/V2HqxRmd8?=
 =?us-ascii?Q?RnqQgNBQeSn6wxkBitWRcMXrO2tuZOtqMvl7TnRtiRxqtyjqJj9Ey3twESFq?=
 =?us-ascii?Q?CENEqs5djNXpmCGie5JVImVTkolCPSGkVnDgqC9klYRbDvfWhfkq67GIC6Th?=
 =?us-ascii?Q?4SzQAUHn0VPIlViMy6lRqLo2H/ihEXX8YYX6V/mThP510NRBYk0RQsCuw9S0?=
 =?us-ascii?Q?uj16ptJgKLnEwpkz1bT8tIRQIZs1xAR8SPFTNCcdEVpJLzgsmhRNpOwQPCyv?=
 =?us-ascii?Q?sS3WDffGsuHroZfLoV2gSqE8S8/TB5BW2Tx49B0r9B/RxCLmhQSMgoxZptYq?=
 =?us-ascii?Q?AEFILSV1D1R3Fvbby3Iph2LGsVXZJvamZScmVlf2gWPhcktfrkBqxmNlmzCv?=
 =?us-ascii?Q?Od88WUjXNYOg+/QVcFfmOlwGraFLbLLcM+PsHcDcFfrOvYK8Xfp9h2Mb3FeP?=
 =?us-ascii?Q?iPZcpXQW+N7th0hsVSSjZbO4B18FadTfMYynd57WJFPUzofQ7k1f6IyhR8xZ?=
 =?us-ascii?Q?24fPpbBoRB1OqlZPW9RXBYuLcvAt2KhwVtXhaHnbOXHKDHGrp90CuK1gBUdW?=
 =?us-ascii?Q?EPUypxNA/5kdmm5TQUpmSvhXFvluGeUsOG97TM7bzx+QgndhMrpCqdGXRwZQ?=
 =?us-ascii?Q?36bdZguu0nhOQHm5az7aiPP+SP5gDx9LtnRm2Ll+5+EO65qpjs+5Fjb3vpq2?=
 =?us-ascii?Q?d63m2KAd0QS4aWYhZTNL0+YjQfxmHOIIgsMl2H4GCG+ec1ITN1w4FBq96+/y?=
 =?us-ascii?Q?cgvH0CC+5pMUYlopzpQyHuVO71SDjMK+hUb+aLlhotkYBLXeVG8JgH9ZACqo?=
 =?us-ascii?Q?Ddj6loO8QPCTsCyvv6cD68gt7rgV85rMHf8UiJ6gZp6w7rOQ8G32c/wZpojM?=
 =?us-ascii?Q?UnYnAT4QCUGTqaoLPhpZ50c=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 36db0741-88c3-4752-7c48-08dc9d03d0a4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 15:04:49.2203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sw5owfPE0TlQQQDGqgIU3swkCtaAcoTfxRdrJA8Pmk35OxdVBfiadXfx58RWQtJ8Dh817B7aut3oyw1ftR/9curJCi54willWDsZJJoTSV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9834
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
index c9bcd364ee3..228e1e4872c 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -39,21 +39,6 @@ static u32 tcp_ack_edge;
 
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
@@ -70,6 +55,11 @@ static enum tcp_state current_tcp_state;
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
@@ -268,6 +258,7 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 			action = TCP_FIN;
 			current_tcp_state = TCP_FIN_WAIT_1;
 		} else {
+			tcp_lost.len = TCP_OPT_LEN_2;
 			current_tcp_state = TCP_SYN_SENT;
 		}
 		break;
@@ -354,6 +345,20 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
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
@@ -361,106 +366,79 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
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
@@ -510,7 +488,6 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 	u8 tcp_push = tcp_flags & TCP_PUSH;
 	u8 tcp_ack = tcp_flags & TCP_ACK;
 	u8 action = TCP_DATA;
-	int i;
 
 	/*
 	 * tcp_flags are examined to determine TX action in a given state
@@ -537,6 +514,7 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 			action = TCP_SYN | TCP_ACK;
 			tcp_seq_init = tcp_seq_num;
 			tcp_ack_edge = tcp_seq_num + 1;
+			tcp_lost.len = TCP_OPT_LEN_2;
 			current_tcp_state = TCP_SYN_RECEIVED;
 		} else if (tcp_ack || tcp_fin) {
 			action = TCP_DATA;
@@ -553,13 +531,7 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
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

