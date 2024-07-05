Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969D2C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 15:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C114A882FA;
	Fri,  5 Jul 2024 17:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="QWbjY87e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3458988855; Fri,  5 Jul 2024 17:04:46 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42002882FA
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 17:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMRcvZKrbHV6KbJqm+bODJmdfsaLRMjWXKYMK57TF4ONPJRTa6K4v7NVxY/k18l+/ugZub/YC+jS9ooIMMmFzq8cm8n50qgiXX3J386YiQ0+FTwxX8OmUnM0G62VMJjhsx3huZxvDXGelnZRYNKWn3vD1sJQOchyaYSVS8AdrGFSH9c0jlloQefqm6WhLZhd444shnl2A9cYdtxngtiLpAhDAApMxAHtFTDEA6VBQlX13rg/Q8X6uHqxB9faE0Nl+pAi9t4K/9ikYccW2AxkODfdt+eu3IAA1BcK1njS2v5/0zHA+g90bnZXtHqz2aP++g6Cj9qmX63GTSSmoZZzGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEyx/dDBRa3ODVEGQP7f/To1YK7GOZu3p0R1Sbe9gl0=;
 b=jCpmau3QpZegCOCwQe9+iz44CHF7m3qHiWYz69LokCvzygw5XlXOkRFdAkglQN6zuTVOL/b096Enxpjna8+8A7dzSzda87rqBs7q3wNO1pzVhP0Prs9tygu2aRMVwd9joTi234NGtV7fQJo1SKXMUONIBZmEDeCsVRn8FGUcYLxiV3Bnl5savRH6DvQx6yZxX3DROMP+Uw6bv1KgkVg8u9cBBVLMUvNwYR3r9KnB26k7dLWdIH6UnWhQx/Q8rQ5qkTbiXELwQmjLaZRDesJe5WIidQ+0Kt2JdUrABIyiNGYIscLts5B0vxnVQbWDZ86BvJN3Fe7zcrEvasTrYQVIew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEyx/dDBRa3ODVEGQP7f/To1YK7GOZu3p0R1Sbe9gl0=;
 b=QWbjY87eVlvjp+md7coour3kEDEB/LmdLsaQPeefNWPkf2U9p7NfjFhZpHQymUXqwjLVwuKbqoCJZf25B/zTb4BT8iVT8pfU9unbqPlNWkKuL949/e5unH6nG7ps61oxyXrwDuqMYYgPG0lZELhseP7+qQnNG7aJSgvWCR4PKOxEc2PMHObvE8AgkBSlGv2V1iw9+KBG8aIGTKsSNmdv5MreBvsfNKd3ltfC2eHBTDK0GZ9G7peq5QCQEMdI3BBnd30LeCdumk0bBYHIgH9jkadZLywTZ41y6oeA05gKYrXJRB+LTl3sN3/TST9ODmGW6LA+93ui86LDthh94fxM6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB9808.eurprd08.prod.outlook.com (2603:10a6:102:2ea::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Fri, 5 Jul
 2024 15:04:42 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 15:04:41 +0000
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
Subject: [PATCH v2 0/8] net: tcp: improve tcp support
Date: Fri,  5 Jul 2024 19:04:22 +0400
Message-Id: <20240705150431.2274662-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::22) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB9808:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b50ab39-f3dd-4300-cd8c-08dc9d03cc31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|52116014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NyMALzKoP8qPrBWk54viw0AoYsAOTk9oZsgAqoOcwK6C6gWlTS8Tz6wsdFXs?=
 =?us-ascii?Q?zzeJlcatHs94kS85l+hQE1YowCx7kIOiqJj1ydBKfeIlAbJtMUX8yH/GNdEz?=
 =?us-ascii?Q?R2QFowXP0Te5mQJMEJYoat9K6luifuatlmcKfr2jMRMNabz/IZk1Vt487wxm?=
 =?us-ascii?Q?/vaYc9PF0RQfujgCIJH1V5Aa9ok6AwYXAFviaxfFvDAE5Xf0KFjy5mOcqqmu?=
 =?us-ascii?Q?J8z643nc6OJYb8TrypX8RV2lrieDR1iD6vLNMpo+J97oP8OLnU1yeuyrSEXd?=
 =?us-ascii?Q?1yL85kMa2dpPJMaAdax5YZeSbnZeRpmlu2faagdwNkMzVhYMYFNFvJyyoVG3?=
 =?us-ascii?Q?9Ia0fA7DkQGJ+hFSoVqDXVfoM154x06UCegPgzUq8NigEOyzmpoiji3DwDQX?=
 =?us-ascii?Q?EJE+SmY8gGpreH5i9rDX+ZSM1BbER0fuCCvGdj6w1YuzGPvj/0JjZOgPhozm?=
 =?us-ascii?Q?yYmNF06NO1wKzzlwLbAS+yzB76ezVM1OzBml4yGFnCTt8D5AdzZgb7wQad24?=
 =?us-ascii?Q?t0r4lae0yQHF3hkgtEcYZsdIu0QP0azQ14B2cNIDPuDC3P/Ydj9AjM/sXTpB?=
 =?us-ascii?Q?1IdbpPZgP0ghw8UF4POZdahXh/ZWOz5Gl18YUUxW7edYBZw5fXDgfbjma9tY?=
 =?us-ascii?Q?HxZ+F0CmPfiH6sQLOSalaRGGm62QV8Sv4d6IsPTeUf87VHyiVmqeG6fKT6z5?=
 =?us-ascii?Q?PrR1xTy1BpBY8bagN2dij0tGffLqds6SUMWGxnl7rLblPMwkh0MAoOYg9UqM?=
 =?us-ascii?Q?eIXkC+UpCyDaIbi9OEYF4FWsQG+kBDB17nhwc4kp7/PqxKNZHCXoQZ9I6TON?=
 =?us-ascii?Q?GIitVRJem7nhp7hmfUWf9Brln5PFavHhRrcNIPO8nqp1bOvOp9hD4pRjOh20?=
 =?us-ascii?Q?BUvWml7ZpCvPm5+DyZV2a58n9//Ddwyy8iAbDpS09dzABsMqWXztb3sRCg6J?=
 =?us-ascii?Q?YDSdSikIzurwelbEhFLh106ueYAymWSmS0e+KwNiJamXIbC1QVter+S3eBGL?=
 =?us-ascii?Q?NhFKRWz96gTNo2sjBbQdJPc0/yE9k2XumucDfttnk4mbyYoAyAkzOE2W5OI5?=
 =?us-ascii?Q?XBVXrhVjQaYwrCIDyFPX3Din+mAoNo8sJlpAUKFKPzmTtB/dS5NzP7qyl/oD?=
 =?us-ascii?Q?4nraVyMCMCQ4ZIpoZVydZjk7i/fnEZHwaVtsCovdKTAJjtA8o+zPHatd8VOr?=
 =?us-ascii?Q?HqCzvDGleodZcgLpzA16A7UrkOervxXfu4Et/30uWwyqzrVYkbcrOebhBlEs?=
 =?us-ascii?Q?6O+M07QzUeXplzbTYyiOlUYJnq8wPzvftH9SOH/GJzsf4tgeBG6i0kEcP+Dw?=
 =?us-ascii?Q?o0v45IEl1rqZICjBH4MNP8z98jRknhGajI2LffCoX7a1Y1WRt1gdRa6rGftr?=
 =?us-ascii?Q?z9iClDXsnOVqWkmigYYfB1yYFBReupgIMnVU36b6KAI/yo7OBjAs8X4SkkF+?=
 =?us-ascii?Q?ihzO35ZlxHg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?laNntyoNDkrOzT4KbekaP6BR1GWJrbt8McX50fF+WDI82NAkCanLc43Y4D6o?=
 =?us-ascii?Q?a3gvjpZPNLD6BaSvjwu2bsQfU60B1uixQyiu8WpDGEXdBU9Bjjhz5XblNqhe?=
 =?us-ascii?Q?J33jRJ510CFLAgKTvkyJonvQvsgdTEPuCT7sflEahfqr7C9in+6Mm+ofdTIy?=
 =?us-ascii?Q?kGh8Sb0vmHignbbXv64EijvAafTUUhdTfe/W40F1TBezE6Kq50SRHW3oluCF?=
 =?us-ascii?Q?2SYGm3Bq4OoQ0N9WQz3Io80bysK+S6N4mMn+NIG1HBL6xDaK7wE1FIF46CnC?=
 =?us-ascii?Q?CYrVJuPlZ2RfmMgY+e6CtEx7p/LIYTKYXSxKskY9Zjs+fj9gkbAqhCPlWJI8?=
 =?us-ascii?Q?fyEA07eRP63emLXtZa5cWBrVihWxYzKXOHwWEoX1iUGF3Ord6zH2p+Kfqil+?=
 =?us-ascii?Q?a4nspq3JvEPYmPd9YtJF+g/CSwzqLppUksm8jPQ+GxSjxgc2WEGw4vWiPFDT?=
 =?us-ascii?Q?ZpLR/JbEsiAfKWK+iROPYCPMs1p+xXCTjAeDqsTJXWntpsUl8PYiUSpbZlJA?=
 =?us-ascii?Q?cMn/n9QPcVBBwNYtG376m/Rtpoua7IR7KhIkSTvAoNoPHV3eVx4/G0Dd2tG9?=
 =?us-ascii?Q?2/xELx9+Rw1c+tlamA+icN7ux6m+0Y4Wfi9DDrDOp4GAXl2+B13m8p2Kf+Dy?=
 =?us-ascii?Q?JbwQgB/j7BrsMSCWVf+BF0jYItA9qDGj/ceoe+T+dXYn6RaDxKeYVFFaq5Cn?=
 =?us-ascii?Q?sVTMW7e7kzG6+UuYbTG+1Tk5PQxcagWYCsxwtbpAKYZHj7lCf2aQal9HC8MQ?=
 =?us-ascii?Q?SRgnngKGBUurhAZLq33EpMrdMTNeNp4IoStJwOmijXrLjhzlUoKo5neMu05f?=
 =?us-ascii?Q?Tmz98eoHUvF27uNBrrS7CNqppI20h9julWmet/Z0mNF2Jh1UnQTk2Nk2Yri2?=
 =?us-ascii?Q?aemHiACif80e/BntLsrg3lC0nnXv6dKYXpErvm4HzAFDktvEyfdqyzlIVYX2?=
 =?us-ascii?Q?YMFWREborXiBqXuOdiWhnjiynLBdxJKLd5FamYIxgZSY58+tj/jHftBH6keM?=
 =?us-ascii?Q?ErZU+RxrK9CPNhiMYiIMLDN7Q+aeU7t4gMtxrFyEG5Rk+qP8ays/SZsizf/Q?=
 =?us-ascii?Q?w0FnthC8hnZbR4576npbWwnEBTvMG+J9yM3bXwfIFJTFNMgvXCjfOFcdQftU?=
 =?us-ascii?Q?RF45kUAddMTs8M/LtCKDysUvx+SaEFjMe9SV/wocpkJM9TPlkY1Fug54Ky/M?=
 =?us-ascii?Q?rpc3grF1kkSCroMU1fGb5xerHclRczwuEFKz2n3tSIs5LszQBL8r/vOp1FCM?=
 =?us-ascii?Q?F2XJpfbCHUvOwKh+9PeA+Hv7yGDuhq7SMvqvufoft7RnUvPfk1BtwqSAwGXd?=
 =?us-ascii?Q?PJ3t69cgzF7eSv+wxgegzJZCyg6FcFjovQgrMi7GkkYEahcrQhCjGycIWt1P?=
 =?us-ascii?Q?Vy56U3Nvc2CDwXnty4HYN0GKWyI0pWN6WbeiUpzBjJ1PhuR5CaP+3KAuKZkk?=
 =?us-ascii?Q?kuW2X+xU8Ft7HrBD2UJhdpa2tKPysZ+4Y3NMwLYumaSqUp/tg0azKfkziHHU?=
 =?us-ascii?Q?qYX2NSvKj4tzV7pyr4Qru+MDU0ioumUUvVunFPTmMk1TWQxraebSMLD+dWRo?=
 =?us-ascii?Q?1recxdFcDXGIH+ToLsakr02R+Y8sfYz0RqOL1n7lak4YSx+Pq+dnSzQPig7U?=
 =?us-ascii?Q?yxqdAvSTUNPzc1oKIFUKe+k=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b50ab39-f3dd-4300-cd8c-08dc9d03cc31
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 15:04:41.8099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgrWRQl7zfiKQ9ZD/eCgbg0NUq/mq5mkv1eYeZvqpk3AYpon5MLDixJJ8e9nsLez9obE1e7VhDpGwbCSAbdLcopGrV6V/B5hBMdlQkf2Shs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9808
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

This series of patches greatly improve TCP support.

The benefits:
 * a lot of bug was fixed
 * tcp cliens becomes smaller/simpler
 * fix data uploading (now it's possible to transmit a huge
   array of data from the board to external server)
 * data downloading/uploading with netcat over tcp was added

Mikhail Kshevetskiy (9):
  net/tcp: fix TCP options processing
  net/tcp: fix selective acknowledge
  net/tcp: put connection specific data into a tcp_stream structure
  net/tcp: add connection info to tcp_stream structure
  net/tcp: rename ack_edge and seq_init to more common rcv_nxt and irs
  net/tcp: improve tcp framework, use better state machine
  net/tcp: simplify tcp header filling code
  net/tcp: define a fallback value for rcv_wnd size
  net/netcat: add netcat over tcp support

 cmd/Kconfig          |    7 +
 cmd/net.c            |   34 +-
 include/net.h        |    7 +-
 include/net/netcat.h |   20 +
 include/net/tcp.h    |  227 +++++++-
 include/net/wget.h   |    8 -
 net/Makefile         |    1 +
 net/fastboot_tcp.c   |  190 +++----
 net/net.c            |   30 +-
 net/netcat.c         |  159 ++++++
 net/tcp.c            | 1253 +++++++++++++++++++++++++++++-------------
 net/wget.c           |  479 +++++-----------
 12 files changed, 1538 insertions(+), 877 deletions(-)
 create mode 100644 include/net/netcat.h
 create mode 100644 net/netcat.c

-- 
2.39.2

