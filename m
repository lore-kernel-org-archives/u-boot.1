Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29761C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 09:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA409889CE;
	Wed, 31 Jul 2024 11:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="1bDJys8+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E06CB889CB; Wed, 31 Jul 2024 11:21:51 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::729])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75843889CE
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 11:21:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnSEQ5i8+D7VZ1o2RsbahbDHmG/igETEStnwtw0efJc5skHALi/kzIj6fZCyDglk6lxjdnqTIGcz3tZMNfJgXQLwLoxKT19CljvXRchyRj/D0373EW6ZMZ/94hMsLtjxjbXa9Yw6aUuE1t/HIp31M1L1OiOudDZL4jDN9duU5qew72wHtnxqkh4uQD3W/3+FrF8jCfOXjToUtNOjhccHtAdVb5wtxJezn/6nX7UITEQhCr+iHbnvNjyfVy7rsy+XuTaO8ln6LDUScGfIJZbIr2dlUaH05FjrMmxruY1C9rgDharEy+XA25sUumKoMdCzE2shG7cDnCDpmPWxXb278Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EL8MhXh41iN9EyZl2AQPPTCSXD4sTCclynNCfPtb2Yw=;
 b=JCFw7CigLyWkXD8Lhsm1TnFzDh6fWF9kJPZYKMPqLiKeZheq+xFT63hHVV0+CviQboq2xUX/SMKmSsg6ukVKxdFzpZHTMK/nvUXIXPGKiGQPYz/e1wUChZe5Ruvj2LAmzuSla+rBfmIuA6tde7kyue8WfYsmAM0l642pa4kEtnMYei4zit8J1pAmXR94XQZhDFeS8vJw7WJemtmNrSdi4JMFfr4SFT1qvf4DQ8SNo7TQQj9/B9RPq3i3j7DvbzJstnmPQ8ghy6oYOZw6mC7RGbGRzalTKY7pfptiO60tONCepu0zKYu/ekOKxGZ0MzKOZqu+tD4ksLb5DoGzq6rSLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EL8MhXh41iN9EyZl2AQPPTCSXD4sTCclynNCfPtb2Yw=;
 b=1bDJys8+RmsfchQbSK4LMLQ5gZAI9ZvX4mJ+qzQYD5W6aJ6YBpJYdF4yXO4lkqxywHJJoScoRa0vT6FlDftapW8oDE9y3APqOiTR2OLy8lEEm/witY4O3R9c2ZqdLNIvAgMsGnF9KSqIswBghJ+Ky/dfM+GFaDSo0FDNIoTb3vFxqFAu58BoSJD7gNZBGTAUMW5XfpIuTO4yQ3DRDN3B+VhPmKXRmJWTjIkN6dbPutfEk8LIgL3wgfm7u7DrtxHrncu1GHcQLeyRZE1ABRNRpIC13QtB8D2zqd/wJKR9glYEi2pGEXA2R/y8uff1MM2LYcVNiLvRQGiCyzndb+3x4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7515.eurprd08.prod.outlook.com (2603:10a6:20b:482::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 09:21:45 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 09:21:45 +0000
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
Subject: [PATCH v3 8/9] net/tcp: define a fallback value for rcv_wnd size
Date: Wed, 31 Jul 2024 13:21:09 +0400
Message-Id: <20240731092110.4027134-9-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 075d165a-32ba-4eb0-46e0-08dcb142323d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|52116014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SL0bFiFGpTI5CmwI3Pi/TvNLOdMLJ5C6IOdXiw/ILjoZoVQhZ1bemBspLbMn?=
 =?us-ascii?Q?i3b5DYK5QWVehfjIJWh/hR38DXPm7z3ybR1CAli7expqDEQLPSNu3LP6q3ww?=
 =?us-ascii?Q?XEY694kF8JIGqP3iI/zaVOTOqZEx7PjoUozDxCxNcGX/QhFUzgNF5pPuFUGv?=
 =?us-ascii?Q?ULLCAa0VlbThXJOIt8E7SlkBHwnOhZOhCIjw9ox2VC+YFaVkMyp7Ben1Vh3F?=
 =?us-ascii?Q?eApmDWyOSyg4m7bAyYxdplHm4r5SMN/5grv34m+GNiJ3sfL/5WN9IUSvcz1c?=
 =?us-ascii?Q?d1vlibE/FsuZYERilNqceip2uZPIErqUd2enMDsvg4JbrQdldP5AzwI66BI5?=
 =?us-ascii?Q?7KgeJdesZUfQZauUR/lhbT9FHYpT30sKW4kA5SFfTtS6OhN2jxNmm8k83sme?=
 =?us-ascii?Q?jbsA8VJCcDSQ3hLSyt1+Fzc+v72FeFob03dNfdDFrzZg7TC1CswlkaGOo1C1?=
 =?us-ascii?Q?fVOZSzfHEB9Y4T87EBH1AU6aziiyCMHJUkAD9sDaZQ/udmW7wywQ0X9O/IjA?=
 =?us-ascii?Q?XD3a0AVfwTdSoe6rjRfzxzjRr1H171SmT6QpD/W9lAMo7BEIguvVsMXFBKXl?=
 =?us-ascii?Q?UvkaMuciRyT72RuYwhHLPpJl0T+T8LGxEyEER5W4CwIOCN+id7xyFAJdIWIW?=
 =?us-ascii?Q?xqgA6aSXofx2RFPf1C1J2FYEJJa8F3qzORteLB4/25viI9BAB7+1SR0jWHln?=
 =?us-ascii?Q?K5Qy/cuSy9OSOB5d3doTBiLe26dBRRT86mnKGKXGvganQkDeDgo8Nv10SQtI?=
 =?us-ascii?Q?UxvMNFxIlqEji7Smyei614Dg/TVlPVFIpZwu4FJ7xp7F6PPbOfigjUCWmF7c?=
 =?us-ascii?Q?2NZoVV0IQMKMriSZyQHl7IB7soP01ETY5gH23uWl0EsxypBLOXJMTK12QB/8?=
 =?us-ascii?Q?ZJiig3tDNIOb2WRSw7k0tuXtf5150suQ5e7/2Gi4MIY5lTv2gx+D48zmg4TS?=
 =?us-ascii?Q?YK4KR0w1HhSVIS/o4N/FnakYjyHSu71Y951JBHnS47w0lgTRIow8un6maVnL?=
 =?us-ascii?Q?7qppZnX9c61s9Or5GMA2j5psjxUfOg69Z5cXIrW9EAILAHa3BsFSsHZ0B2MO?=
 =?us-ascii?Q?sggraS3HWSA4TPYNn5wjSurvZkqg4o30//XqS5XgObTeQB7u/kYezmtpnmdI?=
 =?us-ascii?Q?c7U486yx94Ob/5W5z8bKrVs5bif9ccJY3RFLIfBiF4pMAkDiRHUAvY8NI6XP?=
 =?us-ascii?Q?1Yo3aQAzze4md9wPF1I3hhukIqAVSgrie1TAcXSiJ8XaOZOhhK7LJgHrV/Ga?=
 =?us-ascii?Q?SqQFTIt1MGBCZHttjVGmMcsV9DAOsWxFNSYckdu/LoFl957lwoDjAZ5XNMVB?=
 =?us-ascii?Q?VNQRhEQuVRWq9rJSV8hzPKknqjvD5eqfvdKjlU0X+geQ8CUCcVnPw7Nyudcv?=
 =?us-ascii?Q?Qu7q/PHsjYfsXmCVBOyQ6c6kOhsbKbsWp5J4iKtC5WX+cSO09RWEmFGFhpkj?=
 =?us-ascii?Q?x0mnzA5u+V8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/J9md8i3zp6HnDqQDtB0RtGrW8cLLcb2Ndj4ydf5bLP4zzN53FGFpDQawwpW?=
 =?us-ascii?Q?mcUQG6OkFR2zoCYDESRVDxJ34uTz4YDtSwze4YCMmsPn2nK3/aalBPqgaCfc?=
 =?us-ascii?Q?Pi7baM8lSL5rlp5Ga2da8TcFfLECXmk+HMRhLRp9n/UaL9Tk7FNFw+1aNv2A?=
 =?us-ascii?Q?Nf57T/ErkuWrnkZDZnvde2VmRkPODlPgjRSTMIpf5XEJw9sFRkMMNqU+dfll?=
 =?us-ascii?Q?DoTYZ0kvKIE/qhCmXSkDWGaCl8zpWCPONp2IKh9PhtCPfXWJOGVQB7L9gcyT?=
 =?us-ascii?Q?zUbLRtYd9sT0Hlm91B7Ykd5gEP+G5tcebJulPfCoVM2iUZHhGZ0PrYdfuCDG?=
 =?us-ascii?Q?LY4dXJWYWwlHnXNbLalLPipvOa7NYm2zYiegIKuEGAw1ZKRdO3pUlpsJ6t+g?=
 =?us-ascii?Q?hmLSZWnH221JAHbZhXDE2xGEYq8tl3tbtJysaGvolBOsTj709SVhiJ+HbKIG?=
 =?us-ascii?Q?Q8IMqECVOg81HXyw+pINEzt7Irf9JFjJp/WHLRv3p+ZLFFuCNd4AqAKlZms8?=
 =?us-ascii?Q?LGU47h+uipcBcb+VWLoQ5Rf0iE6eMGYTfc2A+1FS6aJDzsl2qkHi/Ud1M6Ak?=
 =?us-ascii?Q?ES9lLz2aHwhE8HJ2uA1TzvuwtPprWtMF6WLEZMwgfd8W1QozOfZU5DmJfAzC?=
 =?us-ascii?Q?nz4QT0fy6OpS0Li4BeC95LFS1WvjFneuIUW7PLzgLv3c4zbTTCm8YNV1HYjN?=
 =?us-ascii?Q?r85J40XUHSTVETPsh2ptN01MNQkalGjFDYViSvvZtku+LVukrR48Otk+vih/?=
 =?us-ascii?Q?7HLkR0vXJyjyw2MC4Ua3NvqPz+uyE38d2nKXdkdYTWNk8NN35tMgsmi5wurn?=
 =?us-ascii?Q?6MiufulwQGuYs1mdh6HEgf2l/+8YTiBOH9n2G/lh6gSOIYb4JBbaqpd+YgIr?=
 =?us-ascii?Q?pV6SIMgfYnE0/u+y7r269MIK2K5chHQPa31ukH1KgqN2Hf/YFI8ROrV0cgyz?=
 =?us-ascii?Q?02p6fKmR1sGjEpPUizVNj1+VrjlVBZcP3Bd80U50YOkr8hp90K9d8WzfPII2?=
 =?us-ascii?Q?M5SJ7ZOK2WIYXG4gCuGzcxUjaQZSgoCUaIA5SIrO21Bs8nMvfgo8UX558pTA?=
 =?us-ascii?Q?TS89EXQhn43xK4m9u9CRuvILT5870vvq7DpbCtvM6uwqLOhZRPXrl4N5jN7q?=
 =?us-ascii?Q?8rEwAJKzGQ8FdhpKXI6LiDigRIAKm2Fz86TKbjNW0WywAGn105ZxhbpX2YCT?=
 =?us-ascii?Q?3VcCIOXssrCW/hEAIPmwlleCNKarSKm2wgQzRXjoNZCz55VhfCj6rhk84En/?=
 =?us-ascii?Q?HfMmRe51LgpJK2Y64H9dcfi3Il8KEVIAlAx5PT6nad6e5BEP6PuQBjTddfBP?=
 =?us-ascii?Q?R7cYJSIfYfP8jN30ZQi5n/DNBg9FzjTaMi1B5ok50jXh2qV6ZnjkrjJs9eY/?=
 =?us-ascii?Q?VYQ5i2pdh9E2pQ66JhSoau5IVq1lOSviOFJ8ZwTpc90hbPEG2iXY1RZaC8M3?=
 =?us-ascii?Q?HlZWfYZRD6h5ibI54MPT/CEsUo8gVvP287NW+bcyG1ThHpNvudg6QMlhEfMB?=
 =?us-ascii?Q?IWLtZDKlOT/uFdSic4gKO6xKx09ygJSdXVVuJU2yYE3NBbqFOOUIIfgkkrCP?=
 =?us-ascii?Q?dyB/SwmQpral65svZ5H0Gq31GOlY/7m5t6VIJ2j40hY/2fYqEfuuxUP7LHal?=
 =?us-ascii?Q?Juaxn0T+OBkDW0EMHZMVjUg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 075d165a-32ba-4eb0-46e0-08dcb142323d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 09:21:45.0196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOz66++2fVIjv3n9Vh3TopqdxMHYatXvypb4meYCeA1EPlHUqqp5ThB/2vaQ5ueQr5iRdMtAFMXM7mr5jlV5zEWkCL6X2C+ZgoK6J9ui2m4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7515
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

