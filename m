Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57160C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:16:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD49688528;
	Thu, 27 Jun 2024 13:16:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="0jc0mOi+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59D8287A9C; Thu, 27 Jun 2024 13:16:03 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74EF98852A
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCX6kLs73QsMUrR9DM4yGfTzGezK2oBMs78So0U1NzvBwDRPvCYelvdNyzuPz/iYZ/kYtbc+iitgJG1aHpUudqxMSWf8EQFMYGcYxSgRi+/bWx/wUgXJSfUiU83kr9t/rTSqPKiuoes/0EJtC0m18JQwomX18/ns6AgUt3o4Z7g7Jlvv/ajxd1Z1Eri2v+ieCPsLWZ+ruY/YGn9kTzV2OnvEH4swZ1ldwM1YtMVW1zC3c489p3ak9My7Pt5+EyqXDAviG0iUF3TXq7K4lQ2HnGVQcnXN5R3KLd3XgQ9/5u5DHwEZGSdYlKbqxyCDEa54vwrfFTkTaB1amL67u0Z4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIU6n2V7JTLySLkX8jVrAvvgLXChUCYNpOP3Y5kgX1s=;
 b=eD+FD4HnO3QV8r1F/D/8KtppgSrgIs6PiCnnrWeyPANq1LOTvljRKV4lXUBtxAxJlIggA5VVyGBAjB5oQixiH7e2lTEsMUVTxyJ6G8/9XKWAGdrHbTRqdwwgwSHtVQkYAN4MTg5TrvQ9Y6hTopX6XGb9RNpSQlPFXInm1tfIcIc09/Q849trvoK0+duGKNryECXyJZkKoKrrUTB0Pyy9PFx9qrXvM33M1ONtxsmTEtSLo4adQIpQtUvm3Rdlrv9Tb0GwnZtnzjPT4ozAlzFG01Ey8esoxGrmqHhghj6bpm4JDHWgF5DlWf9v6nESpT/AEejS7+dRdgaMrKj55Au97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIU6n2V7JTLySLkX8jVrAvvgLXChUCYNpOP3Y5kgX1s=;
 b=0jc0mOi+8EkdXlGZPuwqazFLTP1wgluGlsxY4Hx+k6v9uxT39M5wVLWcZOwQWloNUkRJg/ZPFpM7bX10iHti7EYIq/axLpoZqPtr6ocQp2bdBc0R3jKLcxBxfup6DNwIgjtiofWEQ1RcpY7MyxWvDOT56XD4ZaarHN2KvdZAbkNp+c4VNf2pKWWYITks0cxabnJNJIGBE3tg2u1BlrJkQbRdH0+hfcik7UbuFcQkx/ByTDEX9Cnm1mWiFQLS++8Obww1YWy2gLOUKrR+omp8cJAOFVjTkN6Dx6h68oPwFzvdEam50Ia51nKhm9dWz88nXo4S+OFFOlQ7kA7Vy+QBkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6064.eurprd08.prod.outlook.com (2603:10a6:102:e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:15:59 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:15:58 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH] net/tftp: make tftpput working with servers that do not use
 OACK
Date: Thu, 27 Jun 2024 14:15:51 +0300
Message-ID: <20240627111551.99128-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0055.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::22) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c2ff2d-369e-4eca-e6ee-08dc969a8536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ld+cNDKGQeOBv843Qchs/SCgUzmWFleH83j+zgZhufeFTMaoDaFGuK8WvFBZ?=
 =?us-ascii?Q?G6u/u2wyfwHhJECK9AJ3Gf9Gz6aKJKyTwBCoHgh8lm7XKvydIuWebNHVElzf?=
 =?us-ascii?Q?k/IarFJxaqzrM4+s8sRzjrFu13exCYmFueo7WA2eUP6lt1Duwkn+6OjhcfAL?=
 =?us-ascii?Q?/hBOcd3QxxHj74lEj2eWrFl7lJcMpXeFyHULQg974dplmMaHg2MuV8LfFgzp?=
 =?us-ascii?Q?+UKfIXL8W88lTB3/2PrJhCh57CpqrSfqI1She2p65A9PcvJKhgcrm2TcbG+b?=
 =?us-ascii?Q?TqmSUI0d29kSdwsDe4Tu7yp5aURJFg7XkFZcg1JtX5OXvPvVCaOdPsgDr6NA?=
 =?us-ascii?Q?MdSHIs9NvBmtaJH0gROnOdLur+jaCXPprYfv2FTVfXYZO1clf4R7ukfsK9BH?=
 =?us-ascii?Q?N9qy6ldfLNpnYP0JaCb2J3CjaqVHBCZLJs7RAHLs4Exzgs5zNBnoBgSO+Z8f?=
 =?us-ascii?Q?05tcOYu7WR1YojHibm93xeNUEXvBRnAFb+91C5dsPxcrkrrYM5/BssBS5HR7?=
 =?us-ascii?Q?8iHSBVFXkBa8o5W6fb19zlS37m2rImHdyX2A1ITTiowHK/ycWa2Sxxb209zy?=
 =?us-ascii?Q?Ev7/ldD4caOR+7M5N9uYYjljQV+nJDI0Eu79KRgvumY6lrcxsL9u+cq4ZZ0L?=
 =?us-ascii?Q?vDRU202dDYFNWKfDc1Ch5ewxBno1pNDsdsTJgdRfgR7Sw+wnC12buewk1f7l?=
 =?us-ascii?Q?m6bhWJVYXYWB0pLs7uTE6hPnZSKsa5wNSSRvCzPdBR2ikErhO19pYXi9MDp5?=
 =?us-ascii?Q?XFI2+ZvXy1uCAIvqdBM/iFdL6FM0LEfRmWoGLrz14TDy3jPY5G3Oqx0xlfeC?=
 =?us-ascii?Q?H66vHHpiJW+HFR6StZACKAz2WgVA06Kiq0fctKojrWnJK1GODs/VS5Qjbhy/?=
 =?us-ascii?Q?LYJwyjhRV9P0wpr+mjpyMc67brCXnHIG9XftVajIRB4e38/2kuWNyzdOuCEK?=
 =?us-ascii?Q?CgSL7QMNw8mJNuokptS7bZbRqRp8+5H+QlKCFx7pZczymneBVXPB4KS3+99O?=
 =?us-ascii?Q?pQOQeRBTRr0FcRiimwTEFsmfcU+kI7Blu2GGzJQUkmz+b3Gboe9Lb4bv9wlk?=
 =?us-ascii?Q?lqOSy2JCV72f/EQoITDOR0zq4xoyOuAtcCNAvgBE+599q9FnY0kUMw80qFnC?=
 =?us-ascii?Q?2aY0yomN6IsCjWZr0IiIqN7d2GtXgtFGiNThwL5UsV5w7rLAXA41SI42qoUt?=
 =?us-ascii?Q?CI+EzqmJzTJ0yY0xdaQuGVRGHcbbKjKRGRW2Xpcwl/+U7gZpeYLmJwDML4QE?=
 =?us-ascii?Q?xKQqapciY0UW8XY57tzrMqNUWNRRZAIpul70zcnJqDfHAEGPypmqJZoIXgVz?=
 =?us-ascii?Q?l5GhYHswXNc5tw3yPeEdqy3JgqzvaKUXVQsAuUmnfJHVJfDHVE2Z77rJK3gU?=
 =?us-ascii?Q?cpd/TYMRmkfHUkZ7J4oxHjUwVmo/Sbh24JdvlXgiPu8wfd9LjQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KQdnU+oZDwjEVe8ODVGf6pHAzp29TMVVCG7uYOxLLxFv2k8DixsBncdKymdw?=
 =?us-ascii?Q?ByshnJ/cuPFqCQ4wO9oZ8hpjubc+WDgkWXwjtz//o9MiuQglFtIkzHuJHjn8?=
 =?us-ascii?Q?scHxhv6Gyvl1agEN7QTOSNlqjSt7rm7vqxua85BgaeYiLns4rmgHJqEONjLy?=
 =?us-ascii?Q?1CDm0ctejlKwBX6zQfhuEG23JMLbt+0YYkGTOaY4onCvpUdSyucBLU2dix8/?=
 =?us-ascii?Q?xqtnf6D0nzjWYq+w5PVIwkx0gCD+/OInozyjyxWpzWwl1WYzrYEVKXFOM9a8?=
 =?us-ascii?Q?1UqZ3FJnIR45gXU913XFS5OVvPH7YaGoZSsksyvp7IHTnkI3gKvzcf58X2Xd?=
 =?us-ascii?Q?di4BvCMPdQBnBgZzPJbyy4pmG2XY1SLyrZ7qAllLBhducOkjrWHMubYdJxm7?=
 =?us-ascii?Q?GE6tVgeC52u/BAXlfJ9VaDqnYoOMud4Iipox846BIapWlpy1IgEM686a2u5u?=
 =?us-ascii?Q?uO2UvMH1Dm0YGWiNBMXMW9o7JOkV8K4k6bNSfgosBMmqfwwoexIm5jAYFwAK?=
 =?us-ascii?Q?iN03WM6udFnzlSoRKN2SBt4zt7BWwKtzhspXLYZ3SiFadqno8xuSLtnYy8dd?=
 =?us-ascii?Q?RkOqgRfDXl06NF5CIkWt5Hnc3fujXm6wqQkwoMkWwO7iwn/cnsH3iBKx4tIV?=
 =?us-ascii?Q?RsfNxHJhxwV99RPeWUj6MNUlckVpZZolPkVh3NqwHqJ8PxLawgUU9KKb8HSe?=
 =?us-ascii?Q?jFEagU9pN8DnO+clD7By81NYvc+tPF3XSLNEMS7UAGiNLUOZnDa7GFamjq+D?=
 =?us-ascii?Q?55BrgPzFaYgsPTHgtqd8oiKQgOWCxHxPVqf7MddQ35F788nkrteiWgqXRQAw?=
 =?us-ascii?Q?+p2jd5YcZdgEiRrhCiGrHknKa35/tEGKYdc79ETI/RnLSnq0q3ReHoZ7xGH/?=
 =?us-ascii?Q?3hv6uwdjMbXdJNoKbpvGBeA+ADNxpPqgIgvSy9Zx21ugmTi28+2SlN7Hzaga?=
 =?us-ascii?Q?RHqBU1d/ENTw/3hK3BmsssBas3iLDMs35ugvn5VbnBmlPabGwh11kdNMGZxk?=
 =?us-ascii?Q?gIJdZ7ioOL8X0BASairrztDVFyrzmWlcRRYXEqH1FhFBKT6IJEKxnzWs32kO?=
 =?us-ascii?Q?XVRNu+/kSkmzn8ZwUCmgL2Pjm2wtiB7atvtG2pWlOboXSrn2AAKP7sN/E+3a?=
 =?us-ascii?Q?Bl/IW5pTXiSArPnnbv+By07mEzUo6+Vu2pqmUlk0rPWVIcYD04VLeJnEggLW?=
 =?us-ascii?Q?G9j8YpsjJKk1XuGyhwvxbyiit0//FuWiQg928EDreOJeo/yAl9w82kVCHnun?=
 =?us-ascii?Q?jYvnUwiAOJTxFke4VPRzHlLgzyC5VxgrAtRF1pJbivaqZg64UePAvGwvNTR0?=
 =?us-ascii?Q?UnUtjT70DKyqWVNk1qKDCBQQDNrGIhEB2LraG2fvNlkn+gRbKFwXcYzndsHP?=
 =?us-ascii?Q?nr1p8BRCP28B/PSSqyJ7x5IYpCDUGDgMb+4Za+pyNVkK1j5IyrpGBhO+Xy5a?=
 =?us-ascii?Q?dVDkMmOtXyRdWjd7ZT7/aZor8nM6l7tvK2cPV8oO5IdByMpx35Vh2wY908JA?=
 =?us-ascii?Q?za0fhC/jmTfEuUNa+B/189960ZY76DnbrQGK2YL7vinlFx0X80CkuT73kUvi?=
 =?us-ascii?Q?0VkbmzRRWn0nqAPw6fv/0sigztFAPE4aJp4nvX/Apku5Lle6jZQJKXYwul+w?=
 =?us-ascii?Q?I56UJDCj8nNr5GJeh0DIINE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c2ff2d-369e-4eca-e6ee-08dc969a8536
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:15:58.5418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXvu5BpTZfPplmgEBZ156M2O4dOV/Vx2JypDGQcA/SpmHjrvr9s3uTzvKsYkU3w0UlTb096j2e6yeEb9q8ik0u2BHWNzoyuCRxZfrMWX6b0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6064
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

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 net/tftp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/tftp.c b/net/tftp.c
index 2e335413492..2534dec1c9f 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -494,8 +494,15 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 				tftp_prev_block = tftp_cur_block;
 				tftp_cur_block = (unsigned short)(block + 1);
 				update_block_number();
-				if (ack_ok)
+				if (ack_ok) {
+					if (block == 0 &&
+					    tftp_state == STATE_SEND_WRQ){
+						/* connection's first ACK */
+						tftp_state = STATE_DATA;
+						tftp_remote_port = src;
+					}
 					tftp_send(); /* Send next data block */
+				}
 			}
 		}
 #endif
-- 
2.43.0

