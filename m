Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE52DC3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EC81889D0;
	Wed, 14 Aug 2024 12:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="NEInQ3Zn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA35E8899D; Wed, 14 Aug 2024 12:32:04 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9C0A889A1
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qd1/ilTuBhoQIsK3wKcqLlgx8UDCgearqsfyKEY+PA0CCbrqRizxeBi12zhkVABad8SfxiOsU+atbN1douvJn2wySz40MXIleueckup2O2tD52svVBWam+tNXPklnLZPgbL7etN3RWK58r8h6XW5RMXH/h86Gt43fC90iqye1SqYj1x1JnCnZgYOH1Eq/6wH9aMbi0A2WEMXgbFUYDkroIg3QVsvO6DR8ZIx3xgwvgEYtTA+3M0gQ2wmYmAd85/GmBqFmRzbTfAY6Ij9WZlcviv4KpOCjl6jYMUHRuAtqzATAC01j5DcTWYG83efPKyvG0u9F8xM83skO8zPqRD7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGrrzTvxJ90JZYCIPegkeOA98J84mZXCLkG0vCVxoKA=;
 b=CzG7aQz8R8SdF/RtW9oofu0B28Oel0J2x9vYiR9tVUVu0dL9y/qjP18x1ABqgr1g6XZle2KK407w8726CfItMc9h6eTlQCAQWqpsNq5HRF9tMHZvKJSo52u1thGFfAm2x90KxBO5f6MYjbXG3PEp6L+2Ats7nTa2zteJJLpE3Qmfk4GxCVUS/6YWPFC5TKoNIr8pyoqeMEJt0kyihgCsJnSWx/5cUTEcKKfhMeHQsuU6ibnnS3mgZis+Nu1Q4+mT2pKh3FSYmhRTUe3PFC2y9CmoYvvqxa3CDq8OtBxxZjFl7/1gXGNDwClPpXeJ1qKvf8OiFJUn/mX5T1mGBltedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGrrzTvxJ90JZYCIPegkeOA98J84mZXCLkG0vCVxoKA=;
 b=NEInQ3Zn4m0MRQ6ZTiuyDJGYHH6J/j2FGjrfiKR1cibfenVf5X8tAyaIxD0UqH0ZZ8Ku/9BDlDTBEeIJXELXs6fv+Dux9atYwBJcrihk73nVish3D+69ZWrvrkB2RFsoHXGAojFllhrG19X6ghyqpHjMFS0KWvCQeaO/AmFT4hRp2PYdCPVC4xWRS08D6fbStM27XdQrPZ1sk4FbPRMyPMxGgdQaExjQIXMaN6YvuxuqGbvvpDQjVojtda4zd3wC3OCwoaOfqHF+ecLv4MNhX+legYXTIj2JGxJXa7e6xwGz4VU83aXoWPdwq52E4HSieJ0RjOcooqnM0U+hHpMBcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB9441.eurprd08.prod.outlook.com (2603:10a6:10:457::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 10:31:57 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:31:57 +0000
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
Subject: [RESEND PATCH v3 0/9] net: tcp: improve tcp support
Date: Wed, 14 Aug 2024 14:31:36 +0400
Message-Id: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0030.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f374d2-3164-4b94-1bf1-08dcbc4c5283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WRpxdKGJgMPc+rWMI4jOe3U7WnU6S8CIA3iufd3XRHBGjyXIJBmtp5fQ428J?=
 =?us-ascii?Q?s5gQrdKWPIbxYyC4hEAvudbM+oTdHRqQzMZ9kal5LhV4x9Gse7h962a9+5bg?=
 =?us-ascii?Q?WRKVUqgS0jeyIIBOnEx3zxpeiEdlGMHD3/kAP0KeZ7jabcxVQdGci6RisxSS?=
 =?us-ascii?Q?6xC1yeoH6bA5odInwfRpncEXA7bt9Bs5oKgkOCRJupEDEoYWc4y2zJC40GJ4?=
 =?us-ascii?Q?Ukb9v87WEiSfuK7az6VZZg2A+v1Y3kEntPShOETrwwz5oVKVKQgoV1RIGGkk?=
 =?us-ascii?Q?+uOr6kpibfY69qio6avIgv1N1GL/T7HUQ24xVibtvmfriBsEc05l2v3+j3C7?=
 =?us-ascii?Q?A9HoxYUGoXYPNgQjaYGumeIgfYNnbFXh0Y3e23xjgdmYBqUxFM6geTJeXnak?=
 =?us-ascii?Q?CyxEcE14Cqrd+StvAsy8B7c0/6hPWvPjP4WuINhoZjx8duwyf2gd5tftXY++?=
 =?us-ascii?Q?n23PTTzyQgWSb9Bvb8xStJw4mLZ4BhDWn/Ep63DzNiuDGppTRLlBLr2wOjIg?=
 =?us-ascii?Q?ZdTtBFH7GWS8fYbzD0zGr5//vxOt0Qc9RNOh6C3Tp4LvLNsGEbYBTArY3YdO?=
 =?us-ascii?Q?axtxApQdVkQUjJTWa6ayZYoQ9qiyaDPrtyvnwzjYs3rNGA5yUwcYKiKgdAuY?=
 =?us-ascii?Q?2NqxXfO4nhiGWY5t3D7GjfiBp9r83zKUfjtn74ByrAdQ35p870S0lthw82qI?=
 =?us-ascii?Q?OvfYvnPBTa7s+rLJuEq6XIXABzBiiNBA+zZRe/ww6ugKQU9NqRcAJZnZ6qI5?=
 =?us-ascii?Q?jj8PDqivmrdkvxe0IqpazMdgTP15fUFGcRwuOYeT5xKxz+5DGESbPWaLg/Lg?=
 =?us-ascii?Q?xOcNutrJmxMYctY3TGB1vEzvgCROA0mt1QgdlAaRwjqa0bx/iVcESa1F0r/G?=
 =?us-ascii?Q?CbOGrR1UP2wEhoGg2+e6VQ8CyQG9Lp7uORNy6wCXRJQylbbBLXLEskCrz6pm?=
 =?us-ascii?Q?XVIOBG0P6ED0TQ3tVhthG6nl1B7nAjWXX7Oc4Epde36HOxsZLZ4vonyZ3D/Z?=
 =?us-ascii?Q?54QrFLmfnhGGZXuIE53/gBzEkFoLhwzxDxO62ECkAy0NL/JQhvOwPzv6lZ+P?=
 =?us-ascii?Q?+sKEXZ32hyoUwBSd+4Ho/6izzuSL2r+5dGqh/RV62pqj3kr26Dp102DGpy6o?=
 =?us-ascii?Q?05/Asr7FBGFz7kZCv4RQ4hbqKHM+UxejKK00qP4sysgLLwW1eOGhASusdNRC?=
 =?us-ascii?Q?KmG/QvbSVUn/Lwe9nF6S2rCBgjsTQ/LRdUnjJhBsj5L+CSqti5T+Hxeet1H+?=
 =?us-ascii?Q?s/7va1/IMuxV3l94tpIvT11DWCDrBdFev1iVkDY0yzVMvNdNFzzF5TPcDGH3?=
 =?us-ascii?Q?8ItzYoyuppmnlYPVXk7AM0+FyM+L2Y37q0HxkpYItq500T31HymORBEHdI2U?=
 =?us-ascii?Q?y0KXV7e0HU2r3i6u30mlPdNzEvoSUtT90YQeZalmO1zA78D1vNTeWSKsEeCB?=
 =?us-ascii?Q?GdZiGkGRbb4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i8BUr6p8HLQvGntuE0FJVFeyJfDHfaoju+fxVFRC+FHlYSYs3zB9TtWVrKtu?=
 =?us-ascii?Q?pbyr9z3DpGTGp4i5Jer7usOqzdftj04EtFXTB1DQEp3Yi4SFxVFLHgr6Gt5d?=
 =?us-ascii?Q?0m5c0R7Mr70MbXBrX9ebpyyk9pkXmeiUItBGN0XSJzv/s/nmTQa+70v7BG5S?=
 =?us-ascii?Q?sYjJ6SUJBQigfsICqLc1uionz5Pw52dzfRf2Fb+uFrs2nrfLbxedyExwz5Hl?=
 =?us-ascii?Q?qOI8xPkPD9x3f/zdu19c2dCihG35k8skdDzYgLWUslQUXFkAwcYOA5T+z/x+?=
 =?us-ascii?Q?m2YJizOYYb9Mfbe9gHlVP8FZax5gZqasqXm4C8VQJbi9oWNwWZ0XRqNFoGxC?=
 =?us-ascii?Q?gvxy3oRAssMuIrEA7UpvFjnEeEzEwhTSW9SMek6NQ2G5nKCvyxopNZmRdV3j?=
 =?us-ascii?Q?VeUe1d0xwwJy2P6TAY8/NunkanB2BbTHJR0Rm6JQnS/953cPpcqU93pXWsMq?=
 =?us-ascii?Q?4uajyI1+KWJP4+8ezWgHI+8P1T8LJ+E6/AhetKG+rBJvswVyZrwjjK6vukQ1?=
 =?us-ascii?Q?vX4tqRYOQZxkHN/mCmaK7egSjEXulfFkt7bON6w2i3BLElqxFjQIoVq7LYr2?=
 =?us-ascii?Q?G79Dzriy3ohsxzNtWgV1wHuz8SBLn2AUB0LTSxgNazaevWY0EZo3uJr5eNSL?=
 =?us-ascii?Q?dE7wYNR8MWzSuCMmbmcs26aN8Q+iieTJ9+Rwq3XQ1fiNzfNfiuJR1IicJm68?=
 =?us-ascii?Q?CwXEyIaSZ48gLCoge3CjYgfMtVkJ7Su4IWU3WoJ7+G2FUUA9Ws+/DQtdezy8?=
 =?us-ascii?Q?AOFMbN9gPh5w2kZaFkPyffVHZAWdSRRGy2XJEcm2z/465KPbHLk+hG/ZaDmY?=
 =?us-ascii?Q?3WOX5BKIYgN/YNtBvsZXdfKd6YGn1N0Pn8TBhcqYXUwzgsjhQyv4WURyTdzv?=
 =?us-ascii?Q?wzOv6rswDe8CYJ+Ld9YDrRRUB51gTpX6vkEr/j4mGcXPj1/eyOm8ahWGgjC/?=
 =?us-ascii?Q?aqJDsPlMd4B/w3nD+fYhYYADqjjrneqRvJMYw+97YVF7BxQ+nNTF/widyaHG?=
 =?us-ascii?Q?6lRxnOgnOi5XhTFY5D5yAOBZ4yM73fPgtORbZ/tupX8DZHLluSOuMOzez65j?=
 =?us-ascii?Q?4daJG0t99DPDV2w9A3vmh6P+14O0DnFDY9IGd9fdUL2gMTzsQmcmzGNWssw/?=
 =?us-ascii?Q?OWCY4sFlyqotM4EF5GGwjeGg/37PiknaKUNi2gn1l9O/wx0Anf41qSZl6HF/?=
 =?us-ascii?Q?dMpEcqCsIATH2zeA6Gsi7ZVQKDoHGJ/fAjg6uII8ch1KRndR9JxYk5nciYUV?=
 =?us-ascii?Q?Iycg/oQErVB4mwRvKOOGrOXAYttjqvGMNWMbWoNLXTc3NWeyDO+X5Foq+69u?=
 =?us-ascii?Q?XRXLNoxl9KI+eIRmymkpwaPJbJz03+C9XPzhjZdIGsq9edakhVmGweHY3rNI?=
 =?us-ascii?Q?a63GG/A4af+yv4u2KtLCpAT9t9ZwRw6GtRxD7b/O+xagk860l62O3SazNwvk?=
 =?us-ascii?Q?GQUzuLoX8ptzRXOWgtRYMh/tivB52krZ26vqs31q65LK7fholJdrdHyQR6eI?=
 =?us-ascii?Q?/a2Bet+wrANe/Z4sbiOmmsEhxV1JaaFsl8aDW29i/LUO6FEVjfGyBLT1tfWz?=
 =?us-ascii?Q?KFJTobPa24C+wd3v30mfbua9/pgqcXbnng5PQIeQXOT1k0eWn5aeEId1i/je?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f374d2-3164-4b94-1bf1-08dcbc4c5283
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:31:56.9474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JM85/oywrztk7Y+OjP3vhMd5Ti7fV3n8Zi8NKSycqPty6IXBnIm+QJXt+K+4/YY8zsZ2rNwfkE6pEQz6W6ADHyj/Mvwpis2pZJn9D8NRvIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9441
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

U-Boot support of LWIP is not ready for a moment, but we already have
some kind of tcp support. Unfrotunately this support is really bad.

Some of the known issues:
 * tcp packet from other connection can break a current one
 * tcp send sequence always starts from zero
 * bad tcp options processing
 * strange assumptions on packet size for selectiv acknowledge
 * tcp interface assumes one of the two scenarios:
     - data downloading from remote host to a board
     - request-response exchange with a small packets
   so it's not possible to upload large amount of data from the
   board to remote host.

This series of patches fixes all of the above issuess.

The benefits:
 * A lot of bug was fixed
 * Better and more reliable TCP state machine
 * Tcp cliens becomes smaller/simpler
 * Data uploading was fixed (now it's possible to transmit a huge amount of
   data from the board to remote host)
 * Netcat over tcp was implemented. Netcat supports data downloading/uploading
   from/to remote host in client/server mode.

On the base of this changes a HTTPD/1.1 server for firmware upgrade was
implemented (not included in this patch series).

Modification was verified with
 * firmware downloading via u-boot wget command
 * fastboot over tcp
 * netcat linux client
 * Firefox/Chrome/Edge during web-based firmware upgrade

Changes v2:
 * cover letter was added
 * some patches were removed

Changes v3:
 * better cover letter

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

