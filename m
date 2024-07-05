Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B84C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 15:05:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9579188621;
	Fri,  5 Jul 2024 17:05:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="h1IDw5Wh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03527889BB; Fri,  5 Jul 2024 17:05:00 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2071f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::71f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69CA78899E
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 17:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZKLQb9tehaPe/p3pun1vZXyKWnoOHwwX6b6oJCed3OqtArnOY8b/Be1Aypc46kKZJfIRHSr8xcSKqK1jgWK+vIfC96IlHC+nb90tse5sEwGLXF7ifSpOmWj4+lvHUx6Px91bMUljynXbqLuPW3rK4p+1SBLLsIXNBEQiOy82RnNGkeyTb8H+9SGVZ/o9akb7WYg4oDYGJkpXM/XaPbl3X+5cfroaW+QKT79klU3ZXqX7JHAvsbIz9FtUN7LItZS72ECAKPlqQuRcI/jJwLQpbBu7cO0ao7DLVVgcj+OO3v8AxqBe5eqbmdnCwhNeTxQdT6H0cM55YKtOiyQOqfVsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GT8EoI+vIEc70yyJap8HJ1kqpE+1AbdFGp67JV9xk2M=;
 b=g7RS3xCDP5qdxWUUEmhOTYtQb6f6Bu3bKDJcwIfRQlvxEfNF+FDtk73y7/iILT+x3z31gkUpdB4C3ycpjPrkdZA5+Uz/v5XUxCAkFJgH8VZ4kRQReCZDaKDV/qA8PJ/SMCm/6dYaSwSDq1XDo7YE/JGgRBsDal419/k3EKIUWz8YPn03UsRsUMSKsgtBHAj//99BU6MtpofGkxzryyPp1Y/t1x+BGILVCDKKkynuzbKsrmJyCjA9V+u6xz9Tg5vLCxslwPZ7s76vzlbsljlFwQz+feVfoN3wEaR6xHscuzse0zPguy0G+YfsFZ1Qm1Bz//JCDt4TTvbm+GQE/NFlgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT8EoI+vIEc70yyJap8HJ1kqpE+1AbdFGp67JV9xk2M=;
 b=h1IDw5Whx6wYNiXIi+370sGzu0gpPxEe+mDrWuowKiEJ7ey72iZYUmA4TIP5Y4w7fO3WGXdAnWzZG83xaPj/ZVWNpZJsR1YvOBm2YaRUQ9oRW00S8usTx0yN61uMK2rGgOzA+Xzumybssdwo3cFciZGMMupoVM9lgvAzIaoJ2OvwSLg9I86RX2qaESx3pdoNEmn5aqH65YJMfEsy6osmfgNcjHByruuPnSoHw/55Si9wIt4Azl3LO+t3cyXDRzhVzH24ExrZDYKyZ8b/1MO4qQK+lhbz7jsE92qK5sNqJcouswHpjcqmfICtRZLowE08Wil7lAQ6xL5x53EXXpVI+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9834.eurprd08.prod.outlook.com (2603:10a6:20b:605::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.28; Fri, 5 Jul
 2024 15:04:55 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 15:04:55 +0000
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
Subject: [PATCH v2 4/9] net/tcp: add connection info to tcp_stream structure
Date: Fri,  5 Jul 2024 19:04:26 +0400
Message-Id: <20240705150431.2274662-5-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: bf8723fd-64e0-4f7f-779b-08dc9d03d489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?++sCBWlkBL6wiw9T9OEzjn43V3iOzOl4OrPVYEU8mRiUoAefa8DK1CXQVyNm?=
 =?us-ascii?Q?bUTn5FU0XqORAG/2XO4QO5/NNbEOy2IMyOUqpvnGm5pfATULfZdaRfJR90gp?=
 =?us-ascii?Q?1nM7V3TPW8BTidbaG9uVfplIxZ3BBXmHrrBEzAhmTffnLplw52SzpMWMBLn2?=
 =?us-ascii?Q?H/KbMWtczIk92joZPoTJplrIrsHFpWXAuJuvJNLzmUy1Wz67IkL7yIrW7yk4?=
 =?us-ascii?Q?Tr0BNJol1ZAoXXeOr/qYYrmGRbImc8Wuhpw85c5Vu32JZpSewuzycjSD38MT?=
 =?us-ascii?Q?KpR+ECXUQQn3fQ6sbA/mZnJbAlbvyKXRnKc9bGPMUtgg4e9Y9v6IHa7Ad0sg?=
 =?us-ascii?Q?ajh88VEXXuJPruJPDUY+b34ObJhwSNFVOFqSEEmiQcYF6D/n6pcoU5aCuzO+?=
 =?us-ascii?Q?lq5034pbqeXvQ3jc0ViKUEGHSOeKUl134RYN3aAR9YgyI7LEyBtVCuYC6M10?=
 =?us-ascii?Q?tvdEGfqPRK5v6gq3gW+2+GEjkcwwwPoakKp+trpW0P0H2zTl9yVQkQeZ9K3d?=
 =?us-ascii?Q?Jg6QC4I0PBtiuNikyF1cmToN90LAcBuuf9HVqxQ7VxB9BhwEkOKkCRVZRccB?=
 =?us-ascii?Q?JVTqNfKDarU0M1CaEDUek5cQez/s+9/O9yAX4LgYmDuBZoiM8wlejGOpbC8/?=
 =?us-ascii?Q?xj/EjibvZ2D5G9Fnhc1Tx217pJPahfb3H7tJGtRupBZs7NGNl9WetcliptUf?=
 =?us-ascii?Q?qWFutJKbDnoTCiou2QsVC1EfOJifCgMEDi/BXe2UpmyiDkIwRdlNEN8T5blZ?=
 =?us-ascii?Q?RsjedoYg7JLijOUr08k3v+xW6LLzP6BquQ1XKef6gnZUw8k2M9WXeHioe+47?=
 =?us-ascii?Q?YiUOHcksswR7aAt2DXyGsNq5gDRYjrdKXrCDHFui3b1ki4qgZDvRFzQcUqZ6?=
 =?us-ascii?Q?4ilG/FnqFjCgLjHQLQdsl5OFg1Ligfnehhwct7d6/O+S0+eqO0862/ZoBY0J?=
 =?us-ascii?Q?4PVjiZH9Z73Xvsz9ysuzlYT0rVLo0+Uj3IubR2dPvYp8jein4TU669GZRtYR?=
 =?us-ascii?Q?SPwKPyW2Roa8ryQRTCx9HzYHK1TR5NRIHdT5hDZyz6BtYDFZDI2YD/fL8lcU?=
 =?us-ascii?Q?uKbK5/AuWsXadXl2ucdShH4WKX0Tgx+B/o6pn56H6BukToeYgiX1pXW00CgB?=
 =?us-ascii?Q?2+5HpCyUMgUusa7s6FJNr5vPsl+fFYb0f9tUkS4nGoM8FsRHvEcBF0QaQ4Hi?=
 =?us-ascii?Q?5OwnQfYPuU8KmPKKwYaE/ZdM77OG0m2IPNJK5weEs34I5lkVUstYTaXS40Km?=
 =?us-ascii?Q?o4DFDxpHzm9Eh5MBqVn6TGLGNKJ9XaEf7r/weottRBteefeWtDuVJtNrQ489?=
 =?us-ascii?Q?c7JqvFjnAQZVYboSLjd3X3XMrgKT5P5H1QFMA4Zt3lEGpadJ4BgrI61NzBBZ?=
 =?us-ascii?Q?Djc7GG2nMk4eRWWnpl0Q+Es7LkjsHb4i+QfZh0ESUmYh5ynhpvZ/EXnG/00E?=
 =?us-ascii?Q?GZTJdbJnM/4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jaBydzzr4A8KPZPVRwDdB0Xh3M1TnBK73EH2E10FckSxtlrM0SXW7LZCV1W6?=
 =?us-ascii?Q?pIf0z/hHdM0MyI6UaOvD1if0MR6wVsRmbtJ7qW7fhVxd6Oebd1DnKznZz1W7?=
 =?us-ascii?Q?tX4aFuAmI8M5FBMVuQXnIUYPKWPlm/9Pekh27RupS3ydIRIn1WkywQfneqro?=
 =?us-ascii?Q?Kbs2tGQye9huTLoJC6GTaTELMVWrP6sJYnFrKc+mBdR7dsnuiHoV4naoTlBf?=
 =?us-ascii?Q?C0nZPC2YLb2A7FqK/7ij4DXb54Gn9hnAVQG2eDicF/kQJNOA1kYO4ewGW3ne?=
 =?us-ascii?Q?BH9Nqkf870/2q7Xct2CzNjOxswEhOBcAvL5Rs257/X2spMddIkVYwwTLInFF?=
 =?us-ascii?Q?gVBZwvlvJdS64Ofa0sYSqpGnKrBWJvI1XihFijiby7dno3IW/4QhOzXfSZcg?=
 =?us-ascii?Q?10OjBux4Xh5NE15ToZdWBTl9UfhzVba90X82rgQgQxsRgaKC4gskv6RCfKhw?=
 =?us-ascii?Q?Aw2KCf08f/FyU9V/08RpYp/Ep3dEeC6SB3MdLAE+bckLqCGXORz3otLKrsn5?=
 =?us-ascii?Q?kyVPtovIw/eAXM8VGiAxyPbE53ENNqN013ChYqllolPud3fuuHTsY3XC2LxZ?=
 =?us-ascii?Q?WWvxmG5Ubk8QPt8Z0XmEYMog2KAhGYpE6/MNPsmKHzaefov5HJ140T9lJvbp?=
 =?us-ascii?Q?EYmPmhDFePljBPyXtam6u4UzlpiLUp8svagE53TF1oZsPHy0V7qHKVVQjYge?=
 =?us-ascii?Q?xG+CN1sgSjDnpf3CBrDOobbP/ZMDtx40ZlCmcraKgWt3Arm+ppbeoIEuv7P0?=
 =?us-ascii?Q?+eIJnadSaCuFCuq6YEG/Q9Jfdt+dkllT2G9VjJOAtmVY0u6Rg4uiUe5Bc3EZ?=
 =?us-ascii?Q?DrTx2pPbCEln9VWB9uziSjk1/5jEz391Abd67k1z9wApxD9zCGJzLbcqRvVd?=
 =?us-ascii?Q?OuJUY6pM3gBA9W+mwIhtLt1lkkI3COER0QJUWdiiRaOVcenzh/rT0CVSbm3R?=
 =?us-ascii?Q?/NFERTyQI8h2OTEv8ndBLWO0zX3sJ3dCc9jqiPg4RJTr0Gfl+jvcw55iw6NG?=
 =?us-ascii?Q?IjaTxWRX4iekvmz2IJwQYoI8SjeNo7BV8RIWye2N+G31LNEIABg9Sm+btpNh?=
 =?us-ascii?Q?FCB3ArkCxj6XN448IoXYi9TJa5EtmNjdSnVGTM3+qHIRbGLxDWbAagv95QKw?=
 =?us-ascii?Q?FpiKpXUgWOcgvIxPeybEuvdAeILAVoRFMHVlDFw/sfl6poj4OPef4TsI3J3Q?=
 =?us-ascii?Q?7pIG/P9b0rKbManTp/InVdHdbUW7I25f1loF1qbYxjWGKQDewvos6cgvYVdF?=
 =?us-ascii?Q?Nd1K54hhfSgSkfGjopfS4WpoKR1Lrqrnxyy3uRpqzEeYHeEsO+dhEFYt2UEl?=
 =?us-ascii?Q?JQF8GVdEdZbHvcT7OmTatX1Say2pD81fmZ990ep7V4Ud566V3oRpeGErWRVR?=
 =?us-ascii?Q?EAJkTQV5E7T7YVg6sOKz9+t3VkJbW1PV4Mr0j+5OrVQgZ4D7eBg7ZhdsEhFn?=
 =?us-ascii?Q?7mpufD6m8PZA0+hTAiqSQke4T+G+65U4WVsYmtIp6wP52Lr5LDC0d2DRM9Zm?=
 =?us-ascii?Q?uBsO6mvqzDlppJXV+5RWKkFThRx85JOQ6qqGg6lTVLV9F2SjdA9x4szHcXag?=
 =?us-ascii?Q?z8v05lNW6pklflnU09ZRFQ4r5meIM5WgN8QQgTd7UPqGxmJmrslXw7yJ3ugq?=
 =?us-ascii?Q?/DxTgpM1uG+aF68ET7ogoJE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8723fd-64e0-4f7f-779b-08dc9d03d489
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 15:04:55.7678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3eIAkJMmYKb8HZzZqS8LiwM5k2cP/4FhKF74OqsUC4yjJ1xwTzY2z7oDo691fCcN6i9fOFZs1Dh+ta0OM9G6/2pkkxIPkZp7XlEoVdDEtw=
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

Changes:
 * Avoid use net_server_ip in tcp code, use tcp_stream data instead
 * Ignore packets from other connections if connection already created.
   This prevents us from connection break caused by other tcp stream.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 include/net.h      |   5 +-
 include/net/tcp.h  |  57 +++++++++++++++++---
 net/fastboot_tcp.c |  46 ++++++++--------
 net/net.c          |  12 ++---
 net/tcp.c          | 129 ++++++++++++++++++++++++++++++++++-----------
 net/wget.c         |  52 +++++++-----------
 6 files changed, 201 insertions(+), 100 deletions(-)

diff --git a/include/net.h b/include/net.h
index ac511eab103..fe645245f0f 100644
--- a/include/net.h
+++ b/include/net.h
@@ -668,6 +668,7 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
 /**
  * net_send_tcp_packet() - Transmit TCP packet.
  * @payload_len: length of payload
+ * @dhost: Destination host
  * @dport: Destination TCP port
  * @sport: Source TCP port
  * @action: TCP action to be performed
@@ -676,8 +677,8 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
  *
  * Return: 0 on success, other value on failure
  */
-int net_send_tcp_packet(int payload_len, int dport, int sport, u8 action,
-			u32 tcp_seq_num, u32 tcp_ack_num);
+int net_send_tcp_packet(int payload_len, struct in_addr dhost, int dport,
+			int sport, u8 action, u32 tcp_seq_num, u32 tcp_ack_num);
 int net_send_udp_packet(uchar *ether, struct in_addr dest, int dport,
 			int sport, int payload_len);
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 14aee64cb1c..f224d0cae2f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -279,6 +279,9 @@ enum tcp_state {
 
 /**
  * struct tcp_stream - TCP data stream structure
+ * @rhost:		Remote host, network byte order
+ * @rport:		Remote port, host byte order
+ * @lport:		Local port, host byte order
  *
  * @state:		TCP connection state
  *
@@ -291,6 +294,10 @@ enum tcp_state {
  * @lost:		Used for SACK
  */
 struct tcp_stream {
+	struct in_addr	rhost;
+	u16		rport;
+	u16		lport;
+
 	/* TCP connection state */
 	enum tcp_state	state;
 
@@ -305,16 +312,53 @@ struct tcp_stream {
 	struct tcp_sack_v lost;
 };
 
-struct tcp_stream *tcp_stream_get(void);
+void tcp_init(void);
+
+typedef int tcp_incoming_filter(struct in_addr rhost,
+				u16 rport, u16 sport);
+
+/*
+ * This function sets user callback used to accept/drop incoming
+ * connections. Callback should:
+ *  + Check TCP stream endpoint and make connection verdict
+ *    - return non-zero value to accept connection
+ *    - return zero to drop connection
+ *
+ * WARNING: If callback is NOT defined, all incoming connections
+ *          will be dropped.
+ */
+void tcp_set_incoming_filter(tcp_incoming_filter *filter);
+
+/*
+ * tcp_stream_get -- Get or create TCP stream
+ * @is_new:	if non-zero and no stream found, then create a new one
+ * @rhost:	Remote host, network byte order
+ * @rport:	Remote port, host byte order
+ * @lport:	Local port, host byte order
+ *
+ * Returns: TCP stream structure or NULL (if not found/created)
+ */
+struct tcp_stream *tcp_stream_get(int is_new, struct in_addr rhost,
+				  u16 rport, u16 lport);
+
+/*
+ * tcp_stream_connect -- Create new TCP stream for remote connection.
+ * @rhost:	Remote host, network byte order
+ * @rport:	Remote port, host byte order
+ *
+ * Returns: TCP new stream structure or NULL (if not created).
+ *          Random local port will be used.
+ */
+struct tcp_stream *tcp_stream_connect(struct in_addr rhost, u16 rport);
+
+enum tcp_state tcp_stream_get_state(struct tcp_stream *tcp);
 
-enum tcp_state tcp_get_tcp_state(struct tcp_stream *tcp);
-void tcp_set_tcp_state(struct tcp_stream *tcp, enum tcp_state new_state);
-int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
-		       int sport, int payload_len,
+int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 		       u8 action, u32 tcp_seq_num, u32 tcp_ack_num);
 
 /**
  * rxhand_tcp() - An incoming packet handler.
+ * @tcp: TCP stream
  * @pkt: pointer to the application packet
  * @dport: destination TCP port
  * @sip: source IP address
@@ -324,8 +368,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
  * @action: TCP action (SYN, ACK, FIN, etc)
  * @len: packet length
  */
-typedef void rxhand_tcp(uchar *pkt, u16 dport,
-			struct in_addr sip, u16 sport,
+typedef void rxhand_tcp(struct tcp_stream *tcp, uchar *pkt,
 			u32 tcp_seq_num, u32 tcp_ack_num,
 			u8 action, unsigned int len);
 void tcp_set_tcp_handler(rxhand_tcp *f);
diff --git a/net/fastboot_tcp.c b/net/fastboot_tcp.c
index 2eb52ea2567..de1048e366e 100644
--- a/net/fastboot_tcp.c
+++ b/net/fastboot_tcp.c
@@ -9,14 +9,14 @@
 #include <net/fastboot_tcp.h>
 #include <net/tcp.h>
 
+#define FASTBOOT_TCP_PORT	5554
+
 static char command[FASTBOOT_COMMAND_LEN] = {0};
 static char response[FASTBOOT_RESPONSE_LEN] = {0};
 
 static const unsigned short handshake_length = 4;
 static const uchar *handshake = "FB01";
 
-static u16 curr_sport;
-static u16 curr_dport;
 static u32 curr_tcp_seq_num;
 static u32 curr_tcp_ack_num;
 static unsigned int curr_request_len;
@@ -26,34 +26,37 @@ static enum fastboot_tcp_state {
 	FASTBOOT_DISCONNECTING
 } state = FASTBOOT_CLOSED;
 
-static void fastboot_tcp_answer(u8 action, unsigned int len)
+static void fastboot_tcp_answer(struct tcp_stream *tcp, u8 action,
+				unsigned int len)
 {
 	const u32 response_seq_num = curr_tcp_ack_num;
 	const u32 response_ack_num = curr_tcp_seq_num +
 		  (curr_request_len > 0 ? curr_request_len : 1);
 
-	net_send_tcp_packet(len, htons(curr_sport), htons(curr_dport),
+	net_send_tcp_packet(len, tcp->rhost, tcp->rport, tcp->lport,
 			    action, response_seq_num, response_ack_num);
 }
 
-static void fastboot_tcp_reset(void)
+static void fastboot_tcp_reset(struct tcp_stream *tcp)
 {
-	fastboot_tcp_answer(TCP_RST, 0);
+	fastboot_tcp_answer(tcp, TCP_RST, 0);
 	state = FASTBOOT_CLOSED;
 }
 
-static void fastboot_tcp_send_packet(u8 action, const uchar *data, unsigned int len)
+static void fastboot_tcp_send_packet(struct tcp_stream *tcp, u8 action,
+				     const uchar *data, unsigned int len)
 {
 	uchar *pkt = net_get_async_tx_pkt_buf();
 
 	memset(pkt, '\0', PKTSIZE);
 	pkt += net_eth_hdr_size() + IP_TCP_HDR_SIZE + TCP_TSOPT_SIZE + 2;
 	memcpy(pkt, data, len);
-	fastboot_tcp_answer(action, len);
+	fastboot_tcp_answer(tcp, action, len);
 	memset(pkt, '\0', PKTSIZE);
 }
 
-static void fastboot_tcp_send_message(const char *message, unsigned int len)
+static void fastboot_tcp_send_message(struct tcp_stream *tcp,
+				      const char *message, unsigned int len)
 {
 	__be64 len_be = __cpu_to_be64(len);
 	uchar *pkt = net_get_async_tx_pkt_buf();
@@ -64,12 +67,11 @@ static void fastboot_tcp_send_message(const char *message, unsigned int len)
 	memcpy(pkt, &len_be, 8);
 	pkt += 8;
 	memcpy(pkt, message, len);
-	fastboot_tcp_answer(TCP_ACK | TCP_PUSH, len + 8);
+	fastboot_tcp_answer(tcp, TCP_ACK | TCP_PUSH, len + 8);
 	memset(pkt, '\0', PKTSIZE);
 }
 
-static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
-				      struct in_addr sip, u16 sport,
+static void fastboot_tcp_handler_ipv4(struct tcp_stream *tcp, uchar *pkt,
 				      u32 tcp_seq_num, u32 tcp_ack_num,
 				      u8 action, unsigned int len)
 {
@@ -78,8 +80,6 @@ static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
 	u8 tcp_fin = action & TCP_FIN;
 	u8 tcp_push = action & TCP_PUSH;
 
-	curr_sport = sport;
-	curr_dport = dport;
 	curr_tcp_seq_num = tcp_seq_num;
 	curr_tcp_ack_num = tcp_ack_num;
 	curr_request_len = len;
@@ -90,17 +90,17 @@ static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
 			if (len != handshake_length ||
 			    strlen(pkt) != handshake_length ||
 			    memcmp(pkt, handshake, handshake_length) != 0) {
-				fastboot_tcp_reset();
+				fastboot_tcp_reset(tcp);
 				break;
 			}
-			fastboot_tcp_send_packet(TCP_ACK | TCP_PUSH,
+			fastboot_tcp_send_packet(tcp, TCP_ACK | TCP_PUSH,
 						 handshake, handshake_length);
 			state = FASTBOOT_CONNECTED;
 		}
 		break;
 	case FASTBOOT_CONNECTED:
 		if (tcp_fin) {
-			fastboot_tcp_answer(TCP_FIN | TCP_ACK, 0);
+			fastboot_tcp_answer(tcp, TCP_FIN | TCP_ACK, 0);
 			state = FASTBOOT_DISCONNECTING;
 			break;
 		}
@@ -112,12 +112,12 @@ static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
 
 			// Only single packet messages are supported ATM
 			if (strlen(pkt) != command_size) {
-				fastboot_tcp_reset();
+				fastboot_tcp_reset(tcp);
 				break;
 			}
 			strlcpy(command, pkt, len + 1);
 			fastboot_command_id = fastboot_handle_command(command, response);
-			fastboot_tcp_send_message(response, strlen(response));
+			fastboot_tcp_send_message(tcp, response, strlen(response));
 			fastboot_handle_boot(fastboot_command_id,
 					     strncmp("OKAY", response, 4) == 0);
 		}
@@ -130,17 +130,21 @@ static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
 
 	memset(command, 0, FASTBOOT_COMMAND_LEN);
 	memset(response, 0, FASTBOOT_RESPONSE_LEN);
-	curr_sport = 0;
-	curr_dport = 0;
 	curr_tcp_seq_num = 0;
 	curr_tcp_ack_num = 0;
 	curr_request_len = 0;
 }
 
+static int incoming_filter(struct in_addr rhost, u16 rport, u16 lport)
+{
+	return (lport == FASTBOOT_TCP_PORT);
+}
+
 void fastboot_tcp_start_server(void)
 {
 	printf("Using %s device\n", eth_get_name());
 	printf("Listening for fastboot command on tcp %pI4\n", &net_ip);
 
+	tcp_set_incoming_filter(incoming_filter);
 	tcp_set_tcp_handler(fastboot_tcp_handler_ipv4);
 }
diff --git a/net/net.c b/net/net.c
index 8f076fa18e3..ff3018e6494 100644
--- a/net/net.c
+++ b/net/net.c
@@ -416,7 +416,7 @@ int net_init(void)
 		/* Only need to setup buffer pointers once. */
 		first_call = 0;
 		if (IS_ENABLED(CONFIG_PROT_TCP))
-			tcp_set_tcp_state(tcp_stream_get(), TCP_CLOSED);
+			tcp_init();
 	}
 
 	return net_init_loop();
@@ -901,10 +901,10 @@ int net_send_udp_packet(uchar *ether, struct in_addr dest, int dport, int sport,
 }
 
 #if defined(CONFIG_PROT_TCP)
-int net_send_tcp_packet(int payload_len, int dport, int sport, u8 action,
-			u32 tcp_seq_num, u32 tcp_ack_num)
+int net_send_tcp_packet(int payload_len, struct in_addr dhost, int dport,
+			int sport, u8 action, u32 tcp_seq_num, u32 tcp_ack_num)
 {
-	return net_send_ip_packet(net_server_ethaddr, net_server_ip, dport,
+	return net_send_ip_packet(net_server_ethaddr, dhost, dport,
 				  sport, payload_len, IPPROTO_TCP, action,
 				  tcp_seq_num, tcp_ack_num);
 }
@@ -946,12 +946,12 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
 		break;
 #if defined(CONFIG_PROT_TCP)
 	case IPPROTO_TCP:
-		tcp = tcp_stream_get();
+		tcp = tcp_stream_get(0, dest, dport, sport);
 		if (tcp == NULL)
 			return -EINVAL;
 
 		pkt_hdr_size = eth_hdr_size
-			+ tcp_set_tcp_header(tcp, pkt + eth_hdr_size, dport, sport,
+			+ tcp_set_tcp_header(tcp, pkt + eth_hdr_size,
 					     payload_len, action, tcp_seq_num,
 					     tcp_ack_num);
 		break;
diff --git a/net/tcp.c b/net/tcp.c
index 80a161838f5..efa12c9e8d3 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -27,6 +27,7 @@
 
 static int tcp_activity_count;
 static struct tcp_stream tcp_stream;
+static tcp_incoming_filter *incoming_filter;
 
 /*
  * TCP lengths are stored as a rounded up number of 32 bit words.
@@ -41,40 +42,95 @@ static struct tcp_stream tcp_stream;
 /* Current TCP RX packet handler */
 static rxhand_tcp *tcp_packet_handler;
 
+#define RANDOM_PORT_START 1024
+#define RANDOM_PORT_RANGE 0x4000
+
+/**
+ * random_port() - make port a little random (1024-17407)
+ *
+ * Return: random port number from 1024 to 17407
+ *
+ * This keeps the math somewhat trivial to compute, and seems to work with
+ * all supported protocols/clients/servers
+ */
+static unsigned int random_port(void)
+{
+	return RANDOM_PORT_START + (get_timer(0) % RANDOM_PORT_RANGE);
+}
+
 static inline s32 tcp_seq_cmp(u32 a, u32 b)
 {
 	return (s32)(a - b);
 }
 
 /**
- * tcp_get_tcp_state() - get TCP stream state
+ * tcp_stream_get_state() - get TCP stream state
  * @tcp: tcp stream
  *
  * Return: TCP stream state
  */
-enum tcp_state tcp_get_tcp_state(struct tcp_stream *tcp)
+enum tcp_state tcp_stream_get_state(struct tcp_stream *tcp)
 {
 	return tcp->state;
 }
 
 /**
- * tcp_set_tcp_state() - set TCP stream state
+ * tcp_stream_set_state() - set TCP stream state
  * @tcp: tcp stream
  * @new_state: new TCP state
  */
-void tcp_set_tcp_state(struct tcp_stream *tcp,
-		       enum tcp_state new_state)
+static void tcp_stream_set_state(struct tcp_stream *tcp,
+				 enum tcp_state new_state)
 {
 	tcp->state = new_state;
 }
 
-struct tcp_stream *tcp_stream_get(void)
+void tcp_init(void)
+{
+	incoming_filter = NULL;
+	tcp_stream.state = TCP_CLOSED;
+}
+
+void tcp_set_incoming_filter(tcp_incoming_filter *filter)
+{
+	incoming_filter = filter;
+}
+
+static struct tcp_stream *tcp_stream_add(struct in_addr rhost,
+					 u16 rport, u16 lport)
+{
+	struct tcp_stream *tcp = &tcp_stream;
+
+	if (tcp->state != TCP_CLOSED)
+		return NULL;
+
+	memset(tcp, 0, sizeof(struct tcp_stream));
+	tcp->rhost.s_addr = rhost.s_addr;
+	tcp->rport = rport;
+	tcp->lport = lport;
+	tcp->state = TCP_CLOSED;
+	tcp->lost.len = TCP_OPT_LEN_2;
+	return tcp;
+}
+
+struct tcp_stream *tcp_stream_get(int is_new, struct in_addr rhost,
+				  u16 rport, u16 lport)
 {
-	return &tcp_stream;
+	struct tcp_stream *tcp = &tcp_stream;
+
+	if ((tcp->rhost.s_addr == rhost.s_addr) &&
+	    (tcp->rport == rport) &&
+	    (tcp->lport == lport))
+		return tcp;
+
+	if (!is_new || (incoming_filter == NULL) ||
+	    !incoming_filter(rhost, rport, lport))
+		return NULL;
+
+	return tcp_stream_add(rhost, rport, lport);
 }
 
-static void dummy_handler(uchar *pkt, u16 dport,
-			  struct in_addr sip, u16 sport,
+static void dummy_handler(struct tcp_stream *tcp, uchar *pkt,
 			  u32 tcp_seq_num, u32 tcp_ack_num,
 			  u8 action, unsigned int len)
 {
@@ -223,8 +279,7 @@ void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
 	b->ip.end = TCP_O_END;
 }
 
-int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
-		       int sport, int payload_len,
+int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 		       u8 action, u32 tcp_seq_num, u32 tcp_ack_num)
 {
 	union tcp_build_pkt *b = (union tcp_build_pkt *)pkt;
@@ -244,7 +299,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
 	case TCP_SYN:
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:SYN (%pI4, %pI4, sq=%u, ak=%u)\n",
-			   &net_server_ip, &net_ip,
+			   &tcp->rhost, &net_ip,
 			   tcp_seq_num, tcp_ack_num);
 		tcp_activity_count = 0;
 		net_set_syn_options(tcp, b);
@@ -265,13 +320,13 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
 		b->ip.hdr.tcp_flags = action;
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:ACK (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
-			   &net_server_ip, &net_ip, tcp_seq_num, tcp_ack_num,
+			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num,
 			   action);
 		break;
 	case TCP_FIN:
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:FIN  (%pI4, %pI4, s=%u, a=%u)\n",
-			   &net_server_ip, &net_ip, tcp_seq_num, tcp_ack_num);
+			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
 		payload_len = 0;
 		pkt_hdr_len = IP_TCP_HDR_SIZE;
 		tcp->state = TCP_FIN_WAIT_1;
@@ -280,7 +335,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
 	case TCP_RST:
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:RST  (%pI4, %pI4, s=%u, a=%u)\n",
-			   &net_server_ip, &net_ip, tcp_seq_num, tcp_ack_num);
+			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
 		tcp->state = TCP_CLOSED;
 		break;
 	/* Notify connection closing */
@@ -291,7 +346,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
 
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:FIN ACK PSH(%pI4, %pI4, s=%u, a=%u, A=%x)\n",
-			   &net_server_ip, &net_ip,
+			   &tcp->rhost, &net_ip,
 			   tcp_seq_num, tcp_ack_num, action);
 		fallthrough;
 	default:
@@ -299,7 +354,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
 		b->ip.hdr.tcp_flags = action | TCP_PUSH | TCP_ACK;
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:dft  (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
-			   &net_server_ip, &net_ip,
+			   &tcp->rhost, &net_ip,
 			   tcp_seq_num, tcp_ack_num, action);
 	}
 
@@ -309,8 +364,8 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
 	tcp->ack_edge = tcp_ack_num;
 	/* TCP Header */
 	b->ip.hdr.tcp_ack = htonl(tcp->ack_edge);
-	b->ip.hdr.tcp_src = htons(sport);
-	b->ip.hdr.tcp_dst = htons(dport);
+	b->ip.hdr.tcp_src = htons(tcp->lport);
+	b->ip.hdr.tcp_dst = htons(tcp->rport);
 	b->ip.hdr.tcp_seq = htonl(tcp_seq_num);
 
 	/*
@@ -333,10 +388,10 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
 	b->ip.hdr.tcp_xsum = 0;
 	b->ip.hdr.tcp_ugr = 0;
 
-	b->ip.hdr.tcp_xsum = tcp_set_pseudo_header(pkt, net_ip, net_server_ip,
+	b->ip.hdr.tcp_xsum = tcp_set_pseudo_header(pkt, net_ip, tcp->rhost,
 						   tcp_len, pkt_len);
 
-	net_set_ip_header((uchar *)&b->ip, net_server_ip, net_ip,
+	net_set_ip_header((uchar *)&b->ip, tcp->rhost, net_ip,
 			  pkt_len, IPPROTO_TCP);
 
 	return pkt_hdr_len;
@@ -617,19 +672,26 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 	u32 tcp_seq_num, tcp_ack_num;
 	int tcp_hdr_len, payload_len;
 	struct tcp_stream *tcp;
+	struct in_addr src;
 
 	/* Verify IP header */
 	debug_cond(DEBUG_DEV_PKT,
 		   "TCP RX in RX Sum (to=%pI4, from=%pI4, len=%d)\n",
 		   &b->ip.hdr.ip_src, &b->ip.hdr.ip_dst, pkt_len);
 
-	b->ip.hdr.ip_src = net_server_ip;
+	/*
+	 * src IP address will be destroyed by TCP checksum verification
+	 * algorithm (see tcp_set_pseudo_header()), so remember it before
+	 * it was garbaged.
+	 */
+	src.s_addr = b->ip.hdr.ip_src.s_addr;
+
 	b->ip.hdr.ip_dst = net_ip;
 	b->ip.hdr.ip_sum = 0;
 	if (tcp_rx_xsum != compute_ip_checksum(b, IP_HDR_SIZE)) {
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP RX IP xSum Error (%pI4, =%pI4, len=%d)\n",
-			   &net_ip, &net_server_ip, pkt_len);
+			   &net_ip, &src, pkt_len);
 		return;
 	}
 
@@ -641,11 +703,14 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 						 pkt_len)) {
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP RX TCP xSum Error (%pI4, %pI4, len=%d)\n",
-			   &net_ip, &net_server_ip, tcp_len);
+			   &net_ip, &src, tcp_len);
 		return;
 	}
 
-	tcp = tcp_stream_get();
+	tcp = tcp_stream_get(b->ip.hdr.tcp_flags & TCP_SYN,
+			     src,
+			     ntohs(b->ip.hdr.tcp_src),
+			     ntohs(b->ip.hdr.tcp_dst));
 	if (tcp == NULL)
 		return;
 
@@ -677,9 +742,9 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 			   "TCP Notify (action=%x, Seq=%u,Ack=%u,Pay%d)\n",
 			   tcp_action, tcp_seq_num, tcp_ack_num, payload_len);
 
-		(*tcp_packet_handler) ((uchar *)b + pkt_len - payload_len, b->ip.hdr.tcp_dst,
-				       b->ip.hdr.ip_src, b->ip.hdr.tcp_src, tcp_seq_num,
-				       tcp_ack_num, tcp_action, payload_len);
+		(*tcp_packet_handler) (tcp, (uchar *)b + pkt_len - payload_len,
+				       tcp_seq_num, tcp_ack_num, tcp_action,
+				       payload_len);
 
 	} else if (tcp_action != TCP_DATA) {
 		debug_cond(DEBUG_DEV_PKT,
@@ -690,9 +755,13 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 		 * Warning: Incoming Ack & Seq sequence numbers are transposed
 		 * here to outgoing Seq & Ack sequence numbers
 		 */
-		net_send_tcp_packet(0, ntohs(b->ip.hdr.tcp_src),
-				    ntohs(b->ip.hdr.tcp_dst),
+		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport,
 				    (tcp_action & (~TCP_PUSH)),
 				    tcp_ack_num, tcp->ack_edge);
 	}
 }
+
+struct tcp_stream *tcp_stream_connect(struct in_addr rhost, u16 rport)
+{
+	return tcp_stream_add(rhost, rport, random_port());
+}
diff --git a/net/wget.c b/net/wget.c
index 1c0f97a6cc0..327fe3cfbce 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -28,9 +28,8 @@ static const char http_eom[] = "\r\n\r\n";
 static const char http_ok[] = "200";
 static const char content_len[] = "Content-Length";
 static const char linefeed[] = "\r\n";
-static struct in_addr web_server_ip;
-static int our_port;
 static int wget_timeout_count;
+struct tcp_stream *tcp;
 
 struct pkt_qd {
 	uchar *pkt;
@@ -138,22 +137,19 @@ static void wget_send_stored(void)
 	int len = retry_len;
 	unsigned int tcp_ack_num = retry_tcp_seq_num + (len == 0 ? 1 : len);
 	unsigned int tcp_seq_num = retry_tcp_ack_num;
-	unsigned int server_port;
 	uchar *ptr, *offset;
 
-	server_port = env_get_ulong("httpdstp", 10, SERVER_PORT) & 0xffff;
-
 	switch (current_wget_state) {
 	case WGET_CLOSED:
 		debug_cond(DEBUG_WGET, "wget: send SYN\n");
 		current_wget_state = WGET_CONNECTING;
-		net_send_tcp_packet(0, server_port, our_port, action,
+		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport, action,
 				    tcp_seq_num, tcp_ack_num);
 		packets = 0;
 		break;
 	case WGET_CONNECTING:
 		pkt_q_idx = 0;
-		net_send_tcp_packet(0, server_port, our_port, action,
+		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport, action,
 				    tcp_seq_num, tcp_ack_num);
 
 		ptr = net_tx_packet + net_eth_hdr_size() +
@@ -168,14 +164,14 @@ static void wget_send_stored(void)
 
 		memcpy(offset, &bootfile3, strlen(bootfile3));
 		offset += strlen(bootfile3);
-		net_send_tcp_packet((offset - ptr), server_port, our_port,
+		net_send_tcp_packet((offset - ptr), tcp->rhost, tcp->rport, tcp->lport,
 				    TCP_PUSH, tcp_seq_num, tcp_ack_num);
 		current_wget_state = WGET_CONNECTED;
 		break;
 	case WGET_CONNECTED:
 	case WGET_TRANSFERRING:
 	case WGET_TRANSFERRED:
-		net_send_tcp_packet(0, server_port, our_port, action,
+		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport, action,
 				    tcp_seq_num, tcp_ack_num);
 		break;
 	}
@@ -340,10 +336,8 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
 
 /**
  * wget_handler() - TCP handler of wget
+ * @tcp: TCP stream
  * @pkt: pointer to the application packet
- * @dport: destination TCP port
- * @sip: source IP address
- * @sport: source TCP port
  * @tcp_seq_num: TCP sequential number
  * @tcp_ack_num: TCP acknowledgment number
  * @action: TCP action (SYN, ACK, FIN, etc)
@@ -352,13 +346,11 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
  * In the "application push" invocation, the TCP header with all
  * its information is pointed to by the packet pointer.
  */
-static void wget_handler(uchar *pkt, u16 dport,
-			 struct in_addr sip, u16 sport,
+static void wget_handler(struct tcp_stream *tcp, uchar *pkt,
 			 u32 tcp_seq_num, u32 tcp_ack_num,
 			 u8 action, unsigned int len)
 {
-	struct tcp_stream *tcp = tcp_stream_get();
-	enum tcp_state wget_tcp_state = tcp_get_tcp_state(tcp);
+	enum tcp_state wget_tcp_state = tcp_stream_get_state(tcp);
 
 	net_set_timeout_handler(wget_timeout, wget_timeout_handler);
 	packets++;
@@ -442,26 +434,13 @@ static void wget_handler(uchar *pkt, u16 dport,
 	}
 }
 
-#define RANDOM_PORT_START 1024
-#define RANDOM_PORT_RANGE 0x4000
-
-/**
- * random_port() - make port a little random (1024-17407)
- *
- * Return: random port number from 1024 to 17407
- *
- * This keeps the math somewhat trivial to compute, and seems to work with
- * all supported protocols/clients/servers
- */
-static unsigned int random_port(void)
-{
-	return RANDOM_PORT_START + (get_timer(0) % RANDOM_PORT_RANGE);
-}
-
 #define BLOCKSIZE 512
 
 void wget_start(void)
 {
+	struct in_addr web_server_ip;
+	unsigned int server_port;
+
 	image_url = strchr(net_boot_file_name, ':');
 	if (image_url > 0) {
 		web_server_ip = string_to_ip(net_boot_file_name);
@@ -514,8 +493,6 @@ void wget_start(void)
 	wget_timeout_count = 0;
 	current_wget_state = WGET_CLOSED;
 
-	our_port = random_port();
-
 	/*
 	 * Zero out server ether to force arp resolution in case
 	 * the server ip for the previous u-boot command, for example dns
@@ -524,6 +501,13 @@ void wget_start(void)
 
 	memset(net_server_ethaddr, 0, 6);
 
+	server_port = env_get_ulong("httpdstp", 10, SERVER_PORT) & 0xffff;
+	tcp = tcp_stream_connect(web_server_ip, server_port);
+	if (tcp == NULL) {
+		net_set_state(NETLOOP_FAIL);
+		return;
+	}
+
 	wget_send(TCP_SYN, 0, 0, 0);
 }
 
-- 
2.39.2

