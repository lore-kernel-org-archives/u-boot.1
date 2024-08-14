Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CE4C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:33:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BB27889C5;
	Wed, 14 Aug 2024 12:32:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="xdWfuSDQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70743889D3; Wed, 14 Aug 2024 12:32:27 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86B91889DF
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A73k2nbHpevE4rWkKybMnoxQXVZ5u5s/ApIR9f3Wd8st20biwNNQt5SaZdz2+tlI1VAAoMkR3JlESt7q2Rm4nzqy4o/nuJDtt/gxqZfiqoa/dQ60G8+8QZb8WNfb2RA2maG/Lqk2HaP7DakTKm/4aCMwriAmYf9jxam24FB1V4Z1+iwNGDuItfJYjYWdiPvmAh2WRZ37powwnL0ZGVk2V/rzTagSBYho4rrJpm3s1KTe0DOdDcuAfHOOLQXc18zefOl8MKXpgPCC4UD5cJB89mK7RhTYNiYAptb4YYDUB2XzG+7ajBNCArHeXu7EMcQCMt6NMUdBgtk/lV6xS7byEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EL8MhXh41iN9EyZl2AQPPTCSXD4sTCclynNCfPtb2Yw=;
 b=uaAiD/HUfjD0Kgd8ysrMWeaODxmlfqwPtU7DU6X0pXhJR9sc672WTAP3LgVgT3zoMEyume42LIRKW5+7z9KxuiMs3KI+9c5ukACBG/hh1dn6QRwq2I7wWB/IKE9TbXvrfO/NK91+QAmmrrWIcBLkXm9VUjgMFWb6O5kuVzoWTPxApRQS12C6XIEpDZe1gCmAq4q8PJMAFpf54MdgBthtzzYLtwHeGZl2CYxAufkjtx6AnZYVad9Qu5oIg327V/jZrltvZH7IdEktOQI1MHCytxlwWDesBLsF+FTMu8SPNEKUOHjp0W6+5eOxFtiojSE6JtFRcPtdK8qZulYQlpOOiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EL8MhXh41iN9EyZl2AQPPTCSXD4sTCclynNCfPtb2Yw=;
 b=xdWfuSDQ2lcSqipXadNA3oR1PCuubc2nN+BspX3MhUN2hu2lX8B8WGNMW5UFe5fHeFGqpB5vy3VYNQN+RKokLpKpZ/2Ka1qlLPJcYuLL1U3xnX8knmb9YU0bxGNuXR57ziJY3X1Aiu8evlrZRuwhqhE6btxj1iGaHAVuH6zfdLB4JYYjE8h8J0HMItfsYmg2O15wsEQzEelNbfkDqEa1yYsPDLtBgfsGQ9BxES0DBYevDuGM4Y/23crt3uM5ErTHXCkNLg7/A2tsUbrnSisr+Yph/SyedzPkA7lPTABgwP1iGKgLH14cDlbJ5Wsc1hcS9fBKSm8Fll5DoYYIfpsRDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB8887.eurprd08.prod.outlook.com (2603:10a6:102:33b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Wed, 14 Aug
 2024 10:32:24 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:32:24 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v3 8/9] net/tcp: define a fallback value for rcv_wnd
 size
Date: Wed, 14 Aug 2024 14:31:44 +0400
Message-Id: <20240814103145.1347645-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0030.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4fe1eb-d37b-44fe-2ea8-08dcbc4c6291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: WtDzxfd706usQDqmBJsJx8M9f4mPh1Di3HGW/ZBB3+RAsOn8BsNRAj2wWeYrq5E/JvacvQhE7iD+OiHJEXUaurk2fsUwOE9QwgKtfK6K2pwBs7zZ8MrJbIBs5AxDclun/sJopQkZCibpYedG/HW1B5Tl+vcLpRV+iLZKNQFCUrx8f3gTX1y5+qkKX+QKHoMO1O2nkBGvZouEiEfb2inIVcobjIwmU6skPlz8Tou+2AdHTRY+Pzn2AUrZ5M15oL2GEzXGcd+iHpuRaiG2f7swG0BsmoEG+p0C3PllfvmndsDFpmRxd403b1RRf1dYG1wnXorVttaFBjHcwdYNUiiNR18vDrUR0A+6Ucccn2pqKxrBVkZG4hw2BUL7rUIR4SIbVlHHT8aCbeqTjP2FFJCP8PgPB/u+vke5lWYXhKx8B/KAcSm+KNDIqQOj81wz3Q9QQdUmLLpNxaBLCU52tUAS67MlGZpEnEaF6sF3G3ucCqAaCWBQZAqgtEDFI6kzgA+r5eKwsB5DlLnOp7niRKC+y2G7+syrUga9D+MQzazP2Yn8lW++SNNTv1vapn/Jg6nE04dD4PyzCCCioqR48V8XEfrDRrDIFclVY8dtwJfzbYEoFHPG9vj+VJb2N2RAMb7XsNrU65uwEhO9s9yEABr7CkSJzzd3tGk/JUGnwrzxe5vOIVC353D8wYx4uE4gx8EhVHzNGYYY8D+jaP1lexrKHC9n5B3t5KbmpI/07uzsm2k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qo84yKpIztMNhAYk0Zd55cT+zMtrErjLT2Y3Mmya1pD9DSOgm4wd/vVV/bBY?=
 =?us-ascii?Q?vV11p9tmbDr6VMK6w0kp1teOAuHwEYgH8vCbLVzXbNM4iERwrdnTywNp5S2i?=
 =?us-ascii?Q?aMPqSOEcMFHTSZExcFSNHHSlSEhIUHoGaHYbU0qGlVGQt8PQCcJaXlvDxUTs?=
 =?us-ascii?Q?cw2gMPVqBS/3RAKgQXACKHlWZHS2/9iZeEIff8rwJ3TDIN4AYlrh6YSwyB3y?=
 =?us-ascii?Q?lOy9SaWZloIh6cj5tpBTqhhqowI5zn2+Q26pPUS/7q8WvJEDUOG9YhqCf2o1?=
 =?us-ascii?Q?Oh86z6ng44Mvv/0Jp5O31K/AN/1uXs/5k0idolCjFNphu7yH1vzVIdhsiYEb?=
 =?us-ascii?Q?VNQVqMggfUPfA0xOSRb8g+J6zzPipzg4tJmh6dw5+V0Gtqg0V8XJne57fvi7?=
 =?us-ascii?Q?cy3Vm4N8/UjVlxLBLplI/6182HmE7wjk/YZwLygApib5+V1GH2l//cm2Y+Py?=
 =?us-ascii?Q?7PMewMhn/QQxOYEmbVUvh2IhxO36DDG9A7lZAby/p07HMT2KfEBklVAIeIMu?=
 =?us-ascii?Q?sSzWyLoeHT0m3fDm2YQBMfv+V9Sx/ANqx+B8Mevrg9a2hP5OvpJ1b4ZbHMbl?=
 =?us-ascii?Q?GasCg613tfEufiNcy5sNPLHiu/4KoKkQ+wIjUuh4Dr8szsMihhN4I0Qele/0?=
 =?us-ascii?Q?UNcG8UwOXmFmDlBdujw+C3Zasvobeeg9Ry3x9ciElWOFcVxMH9NWo3dn4YVe?=
 =?us-ascii?Q?MRQ9cdsQG9FJnXenP0vy06Jw8VWkj1BG3vOP0ZAfuzjdUyCQMg2dCIslv657?=
 =?us-ascii?Q?i8gRKUtB5NwNLI+uO10IyqrtiaPlPWb+sk6kgf105QrgxGQLi35godbj09Pw?=
 =?us-ascii?Q?glMtSsdxR6nTjnufaP0ZHtTwqIs+Uy97WXJZf7Cq/psM+IC5plqpWspfNNhg?=
 =?us-ascii?Q?pGGj7iczgYSXjHJmywRLB+E+OegYsROYM8R155FpPxxVX6e9/qvxn0UXjJ3W?=
 =?us-ascii?Q?SA0Dodro2pW0eBcHnv15ER4kNSE+llDND11h0n9Fm2zWT1Xhwiwzcmgxxu31?=
 =?us-ascii?Q?xg4OX0DJmMW3O5RNL1NUTeX4FDH0vDm/xwU5/WxPLffbbFWr9Imc3cPZgpOG?=
 =?us-ascii?Q?I44uMvYNDUpUEpjOq7bkErQW4BBqAsCuNEEMZRMYyjWFtpiUW5Z1oMETAx6k?=
 =?us-ascii?Q?8912bGRF6XeohAfJbI09AXQYtHORcPUlSRNL4ADLJkrFOpOUipEU/kfAB5hN?=
 =?us-ascii?Q?0XA6mpwa1mV/PQtu99PQr9QozrpZh1STvo2U1FxtAOHAbTIIzBveeIPlSa/w?=
 =?us-ascii?Q?fb4oPbAm/At5COODYsjWoVrK/Kiegh8qxHZ8wqdAGL5ZTfMCcpXvf0nkxWRM?=
 =?us-ascii?Q?8brnQYbfTr5I9YXu/fPFjwagYdbpkEyiFYq79FdMdWHIZMvaZ4aK220+N/z1?=
 =?us-ascii?Q?tnbU/T8QDSbyI9UoLAPftshE3XG6+r7V6Y+wutr9ZxNG25wUj8Szil8Ad7SR?=
 =?us-ascii?Q?KXNnL7UcplDXWwW5EBVHZXI7cKmnoin/gldc2N9HaQJInoQa/x9CtTYXARnq?=
 =?us-ascii?Q?GglIEi8ZdMBl2tKLlxQb5rd8JkpYllM3DXOqkeaGkcyDni/kHOd8k40e8ZYj?=
 =?us-ascii?Q?/CaIDJtSR6OYIVChGlBoEKD06A/+6eGF8oVhdmjR2ZGRZXWlf0beOBdAPIhg?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4fe1eb-d37b-44fe-2ea8-08dcbc4c6291
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:32:23.9006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFHHo4bk2GK96BnOuM2lt1czFguk39+eSQ8hlHqCr53DWxRI6FXpZ7JWRm07/QzHD2jmI7TOuAvUdMHIzzFiqPDlbSDv4+JNvkaGAtbBkac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8887
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

Some driver implements it's own network packet pool, so PKTBUFSRX is zero.
This results in zero-size TCP receive window, so data transfer doesn't
work. Avod it by setting a reasonable fallback value.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 net/tcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tcp.c b/net/tcp.c
index 7014d5b4f43..f0889d72d44 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -28,7 +28,11 @@
 #define TCP_SEND_TIMEOUT	2000UL
 #define TCP_RX_INACTIVE_TIMEOUT	30000UL
 #define TCP_START_SEQ_INC	2153	/* just large prime number */
-#define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#if PKTBUFSRX != 0
+  #define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#else
+  #define TCP_RCV_WND_SIZE	(4 * TCP_MSS)
+#endif
 
 #define TCP_PACKET_OK		0
 #define TCP_PACKET_DROP		1
-- 
2.39.2

