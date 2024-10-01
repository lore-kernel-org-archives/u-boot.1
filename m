Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F21ECEACF1
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 18:23:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECA8B89297;
	Tue,  1 Oct 2024 20:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="hfqMjFkl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0428C892AB; Tue,  1 Oct 2024 20:21:32 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99DE289294
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 20:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FrOZ+clIhnSdEt97lQBCnfedufRlRlzWEY2UzSJdIS9P5l/awtz3heI6nrAay4O8aQYBoLbkmsIb7KJ24RC1Yr/Uz0YvKAzISbe8ZDqY8+LHmz0hJkDvSMpA+wDrGSNNzAQAtimSPHx0Lq6tUDXxl6rQE2gxzTcfTovOGfZxT5ZXTB0+6FKTkjaKLj/ygbUnD4sAZsZd7q1gSXCkpLlB1nvF6JTFfh7a7I3fMc7lXmpq+K4iAjfmQwXMEpcttiTavOVS11CP8YC8ru5kAKdhf1NO6ENG5Zj4Z7Zgw5hjxk1+5Uf/sEztgCRQq3jF+sCMJ6W3z4x1VTCS/wvEv0D6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUbsugg/wp6TNPRhq9DAJ9Wh9YVAw7P6tiwZVShWQpE=;
 b=sXH3oZpFls7QoJAiJ8WGrpKqntJ1kW1v6894+eSqOQssf3s1noa1OYBJKNNjISZAPshaXDbwezUukM+Emfn77gchBVrSEgtowavHahHspbFiIa41uMk6qNjWh3rQC3RqQPvcNVNo1cAl9QZIa3VhWECwHLyv2Jpdiu9RgZ/vvQxE5y1pZeiwz3+DAur4c9lt+16OrUoRHrsz5YESOj1Qv0j16fDrTm/tJ0XBHwJfnxiXt4JYQjf4uQFZUcJ+6Cr+N2AmeP3TU/yyJ60rakJ3suK2eV1XbmJkktd5mPmvm73Xu/Aj/eosUZI/8lI4z+sYW94Ih87HbPzB0SBJDOlZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUbsugg/wp6TNPRhq9DAJ9Wh9YVAw7P6tiwZVShWQpE=;
 b=hfqMjFkl8TdXP5KBrz1kI9eTWOsqtauH3XiGWxWpBZXSNBX3t5EqlOHl1B6uLDP/BMtBpi5J8b/j3A47bDEHG5KpK35kH1RrqfAdLT6+4kU6cMbczieCFL3UXZ88mdT9k+YtsWPCkJcTMPlwEbRW7szjXTqo7/VzWeRAOilFsorzwlFGCd2ir1bcXJgNPGGsPnO6r8ctP/k0NZ17yRRntMiwJo9OtAl8IZGhqHVAhrl3HRRfOLB6kp6Ky7owRIixjDgy78015Lsq+rhzhPJ+SbnatLe7Jv4IuXRQEUEFIKfjNzI4IiKwIQyMwrOsEhBK2JpEareHzwLnvNo50aZ1Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9153.eurprd08.prod.outlook.com (2603:10a6:10:414::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Tue, 1 Oct
 2024 18:21:28 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 18:21:28 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v9 09/13] net/tcp: define a fallback value for rcv_wnd size
Date: Tue,  1 Oct 2024 21:21:03 +0300
Message-ID: <20241001182107.907828-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001182107.907828-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241001182107.907828-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE7.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::311) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f11b8c5-0dd5-423b-2f75-08dce245ddd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dDLyw7g4rSMnlIc5dO4d2x1IvF5OMx1cssMgr3RpZB6PMEYdqb4zUNSoY9C4?=
 =?us-ascii?Q?Hlpmv9eYzBEqsPy2gOhIMUTNXeTG7IHT5N2/VlXVRp5YYGi5j4YtlodNOv/O?=
 =?us-ascii?Q?PTJEpqYxuU2sI+PLx/wTpZDe1DGNMlFhFXjToX1wFvsQxM3459W2k9y0YQHT?=
 =?us-ascii?Q?LeI4ZsFzWwlsvYiKo6SJiOF2YqaF03vHnDpwcgfvc2D3NGR+L3azNd7OTUZO?=
 =?us-ascii?Q?uat7Svo9xNSeeZ/gr3rFSpxJkQ6O7DCWgK94kqB/+O2K8e5tsIG/8gKCxQkB?=
 =?us-ascii?Q?tTJDeHtVHlqXunmbN7C3iK1JZccAjQSFQqTH51xJQHMZJzBJrCAak1EDp1Qu?=
 =?us-ascii?Q?OVQuUUrAEe6pAqKQmC3lIVRZNdSOh8QsyAfYxIhe85Zl3NsTraHKOcs3Rmj7?=
 =?us-ascii?Q?XsviiCEtWjBWyLQr/5x3Vog9q0VUkGZEmByuCf4VtKZhaXfBy0T+X/jFXFIe?=
 =?us-ascii?Q?dEg+eFaNsEYIb6nDhmsavke5+5fVk/9s56ZgBqx6av3Zx1Yz0TX/hxOytt/M?=
 =?us-ascii?Q?vg915ZfUj3oDlxnOmgXReEhizpmLudDxDf2KPcRbnYvqCnba/K5NS1sl9rMJ?=
 =?us-ascii?Q?hhhT1F/jpfTzIsO8sqB5AuVkngFGghN4JVzNxicZPC+X7EhgPVRZTz9vASbG?=
 =?us-ascii?Q?ybWxZxBEYMlN0Z910yKmql8j1Ve37A47KDEb/qvYZ63IY+Oc0daPjGi1eQPE?=
 =?us-ascii?Q?wTKfQ6tUyFy5Ugwd3pVlg0IQf0FXlLz7uraktLOCF6+mi9EplqD6PSMMcj2M?=
 =?us-ascii?Q?4RbjuBRfAHGzRGwunmwKnn6Vp8iompmOzsrsVNU5cD9ojQB+eYV+HhnT2VBZ?=
 =?us-ascii?Q?Iq+4t8PMXQxeY68GAPo6VDC9WZPHTNte4RJvcODoI9BGbA05pZ7Ym7CeQZcX?=
 =?us-ascii?Q?OFokCR1Du7MN1zYvwZ0gaVpB1ZUJrIWTlS/kPadY5Br5B276/B8Ubmqg999r?=
 =?us-ascii?Q?3b2r0591yltIK/EePs90fdyopflOd6SZ7ZsuDdhSTKWJBl43Zh/IByhGWg4n?=
 =?us-ascii?Q?ejripDmiq+MrRSn2cxOJYL0qZvmawxXYhFUKhRcZHe+j1ZXzqK3E33zB/EMv?=
 =?us-ascii?Q?C6lsJAkOdD8kKDPpY/cQBZ/rzv9T5kK2jqE26p+i6Dg4Jyof1Sq2uOuq/tHj?=
 =?us-ascii?Q?YOlvvYu3J8GUCExTENS8kR0mvnDphrqmf8PiaqQj4NxspX3/RMZS6+zub4iu?=
 =?us-ascii?Q?Ks8bybl94nI0JOlqQPd+iPP/BhzfiRFtc3SIYWlm4jViehNBsKM12OS6l02S?=
 =?us-ascii?Q?NFi3w0TKTKsKNSqlQgt9p/HT6dx3xnruZ/aLcFmwx9Tzvm5vYZaUy8x4T3uD?=
 =?us-ascii?Q?Hgf/xHsNfOcGSZ9aM3JVT2AN4Ja0BiOBjHNT9h/19zyVsHiH3syN/xE447Hw?=
 =?us-ascii?Q?EASvWftuuh495PIR56mUVoLvFush9KW8ETCilU6uKSffChuCv9CI0zIiuiTE?=
 =?us-ascii?Q?TTVR50fOJY4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ESoI1PeaBhHKyLTXshzVMf9jzUE/hLoFJ0R4yZ5pdZSWwXd/aDGIh5UmAAJ?=
 =?us-ascii?Q?rcVoeqD/4V5+iSwQ7v/h7mcEbx3InemosdXfKnwclNpXQd8TMI7u4RssjjhF?=
 =?us-ascii?Q?bhNa4tJ9ued94a8lWwqm5W2LoZVy/ENlVjs+DpYLpOxIX16ks9kY8+Un/Jqa?=
 =?us-ascii?Q?PI1dU9vZP2ePHJ3m4pQjTIMKdDg/PM2Z8+YtgSWp5EauisG0yPTsEKiUJ2IT?=
 =?us-ascii?Q?M51Hes/bJp0T3/WDs/W8bUfbw9cBPKklJLwAPXk2qXFHq7qvU9kVT60VBSxy?=
 =?us-ascii?Q?bn0rNseA5FBwtsGinELL6Ydb9UpUrliyIvTjCWmpNbo58spBjDBVIFHqliTb?=
 =?us-ascii?Q?W5jw3xD08JMaNUL2JUI+HjZg8kbNZHtttdLdRFyuRAhaj24lzaxREL2h2JSF?=
 =?us-ascii?Q?pKgn8dteYzfCctwB/GLjG/gmeTotDl6PQnNCVDmBW8W7Fxjdu3nCpC9CFIOX?=
 =?us-ascii?Q?rY+Hi81Ds/qSBwp7kIhyb+WzgwEMcU1PIZEzaN0AMNES/W9VJy9oV5gIrlRe?=
 =?us-ascii?Q?JnPS8yROG78OFSo9Sp0B17sVPIi2suxTYzwjALfeg+ByEYNHBFdm+eNe7BI1?=
 =?us-ascii?Q?SfhottYCj2SYpXz8VOvxeAEI1kroQl7OFrBm3mwIJknNKxdgRAjoQWMSnBsB?=
 =?us-ascii?Q?d+gbIbMk0mHvDTSBhRBie/NFuKF+fHqOME6v4PR9YHaNK7B17cAE+U0d39iw?=
 =?us-ascii?Q?p2IK+UMp4xG2vq0eM0i1Awhtv/1eFzwC4zb6wfi1E8V8e+LtYOEYAHGHWpwy?=
 =?us-ascii?Q?i8UrjScs7ouVricAZWeUD675bOTQx/oDKlhFb/oLI7lUWxA8c0/CHuDGr0dv?=
 =?us-ascii?Q?upH/xlaa0hvXodVV5CX0x7KbAexM5Ej+2YnB6OW1tKa3xaMggnYS5jBzc68H?=
 =?us-ascii?Q?ycysKaqX34Ihjte+O48vbSLIx/pMUym6CjAEVjpywmgcEqkpLqnIq5L3K+Qt?=
 =?us-ascii?Q?Tk4m/tMWNq5aVOQYtLeuOli+sIJ9kiuqedxfpFlIgA3WzgS0jNzF5oBSmiL/?=
 =?us-ascii?Q?5nrdhZL3l//4tjbmbKxFvDF+y8mVgGxTwFZ9drtnX6eev64wkU/DTHqCZXxm?=
 =?us-ascii?Q?RgcGzgFL9QmXL7UmePJzNMTuafZLZs+cNE8VmbQ49rt0J6yFib3V4Fs7zlsD?=
 =?us-ascii?Q?KVWxQDmwkk8rmKt/q9RvQkZSylGoY75PekTjRKqCcM34rv5pg50IXFNURh3W?=
 =?us-ascii?Q?JYv/iMKF551Da9vyFEEknnsVrVuG/uzKINmYOEojHpgu+IHbDSyW1vPfnTmj?=
 =?us-ascii?Q?tRtbz0eF/VkOV6drIv+zOcEi/heQKCPWTTNFUJOx2bznxNHzB5wibQABjp44?=
 =?us-ascii?Q?8EYMg42Bd6lb9H6Hs6/2GWaJozYEEPGwzI6FUBcE4T9ju0qoP5eF2/iTvUBQ?=
 =?us-ascii?Q?tYCZa0SzkUNxCKBrvHAJ1/qgdSclitC2wRO+mzl2taApmc9VE7P4lwDHLVcR?=
 =?us-ascii?Q?NxvRmG+FASZCfSGSTH9rOGkyiXhrDYNy1Sy59knr/y7wAYqilR25dzhGQ/rM?=
 =?us-ascii?Q?82es17Ej1CHbMqdSRwi0nsw7/LcmJT+U69Hv6FMniCmdeQqETLaLd0DEk9y6?=
 =?us-ascii?Q?Z1koDqxpeqjW/JgIgKK6cKVdCG272P+SAFEas+TRhT/YSQN83N21KxpGBwQ8?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f11b8c5-0dd5-423b-2f75-08dce245ddd2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:21:28.3319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGMLo6Q9i8ynWvR9LxULClBhJEuc9SRckPzG9M03J2s/MwDoSZOYp7um6k7HzEgI/kEWmeDOUkxxD4YWnGWQbP4SUr/Xduvmnk13fXtX74Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9153
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
work. Avoid it by setting a reasonable fallback value.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tcp.c b/net/tcp.c
index 2a95c44b141..b950d2b7727 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -36,7 +36,11 @@
 #define TCP_SEND_RETRY		3
 #define TCP_SEND_TIMEOUT	2000UL
 #define TCP_RX_INACTIVE_TIMEOUT	30000UL
-#define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#if PKTBUFSRX != 0
+  #define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#else
+  #define TCP_RCV_WND_SIZE	(4 * TCP_MSS)
+#endif
 
 #define TCP_PACKET_OK		0
 #define TCP_PACKET_DROP		1
-- 
2.45.2

