Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C226AC5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 539F488B82;
	Fri, 23 Aug 2024 22:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="qaF2Hqmd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C620888B9F; Fri, 23 Aug 2024 22:45:34 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2071b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::71b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10AA688B23
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:45:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3MUz/QyngeRdSa7DVGqr5rFzBEvvQjD1PBnLKcL3AapQ41LSfa+on9jyQzW4/07uQH3o1qV03YRx1SA/bPbG5tlf9y42F38+6X/zNW5Xd+h/ugW+aCnXEnvKonZUGfT2G3a1mNJjQkBDUOKeNSSTatfW/8jC1deKJ18lWTc/7Er+KzREMinwbzaMvmyZY4xGI8keWBrr4Dr+EPQxXcex//fA4EB/XtjU5h1JDXLEKDaVhY9Ngb8Ub/vL+T/jr40rendus1TGb1ErdvdS/CwHjNl7pZOA7ER8Sd9hxRnyve6Hz9pJiu4UXVYnWNVCkXWjyALlEN7WgA6hmVe+QF4Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5zUzeqIqDDcHDhIC84Xa/UhQXWeMNiy0FTMaw+olW0=;
 b=kMeYSX2aeNwHIXYg2eQ8koN927jSIXLUxE4l1f3I4X9lqP5iYHxe9bSw4bS153lW0bbThrhcnbGw+/caZF61CKlWOrXBVDjkmiXRg8KwL8rJSBB1ipeW4bRog3dzyBB55FxMEpEkiynvFOgCpIEvEzNym9vrqFRlK8CWggIEANUkGod5nb7c5rbitmesSXLq6bE+dNqGwwbI+HYsJfE5pzZsDD8PV7mamVRRwyLPMg/6kHQTjHNS7EEy81ygJuci6aBBVG/GpodT9y1luca1453p/iea6x9/jSQr3mobIUuP6zzhOakT2dfZMBsnef6Khhg+YxWk4V121HsTvAlOvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5zUzeqIqDDcHDhIC84Xa/UhQXWeMNiy0FTMaw+olW0=;
 b=qaF2HqmdFT5tBHoTYgMm4qI7k4Vy++yqYHykqUgfh2+uEay2s1giQvO6N8gh2uy6Vv2n3GI18qCx551p7+K73FY0e7fnP4Sp3DtGMbr/J71fEGaCpL6855iL/VpnDz2mkWAM4TcF+DjzLi2IgYYq9syfgrWCDRoyu6ujsmamZNSf1EYJdoTe9V6Dya0u50d3Rxfjp28cu+ty5h50B3GiC4HFWgu/0w+jMrnv+FmoCJp9PDFPzWw8x/Jt4Qdow5T2q3W/CIxSdTXKKUHhgXf4AhJeYMG0YIPB6N9DL4vWSN9HdyX4Cgb/tjENdSCsyM4dlU9IDmUYiCAql+xhJaLYig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB11224.eurprd08.prod.outlook.com (2603:10a6:800:251::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.12; Fri, 23 Aug
 2024 20:45:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7897.010; Fri, 23 Aug 2024
 20:45:27 +0000
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
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v4 0/9] net: tcp: improve tcp support
Date: Fri, 23 Aug 2024 23:45:09 +0300
Message-ID: <20240823204518.1010194-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0373.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::20) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB11224:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d371dd2-44ca-4b9b-5c91-08dcc3b484a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bqgpo/sJv9TFizfGxI/g6eD2KjMI3XCijv/i7pJeBTk3Uu6U/uvORRt6xZGm?=
 =?us-ascii?Q?FZuaYqzG0dsIK8VYpFHYnf0i3i/2LDjJi3XxOAsyBg6UX9zxvJYewIbCi/mv?=
 =?us-ascii?Q?/XmTk4Nm5jKfvp4RfbIvXkGsjcKm3WI8FmAOdEI/iygS3KcKzExFVfTs4F3z?=
 =?us-ascii?Q?95/ZWvJzjSUVP/o0wYLjktl+C4CSlJ9q55Q25+0Vwxr5V4ZXipGOO8+6hN0/?=
 =?us-ascii?Q?96XD3Z1vJR9iZfV5/13KPfMyZDX6RVIWFmyRJDVN7G1wTNY+Qy/+XX/NUKj7?=
 =?us-ascii?Q?i6/IuXkNxOqj5EZuMtOaFHTQbqPRNdn+9G7fwbbeWv/gHZh39K0IdXYkM77M?=
 =?us-ascii?Q?iqG5zhitIEuQdjC8CtjKqAoYIoPMuvA+QZLkxNf4veXatDCHPwSVWaF94Sn+?=
 =?us-ascii?Q?9Xjpjb8MkYNf/CFWQuQlUlicECGu5joOkmIIhMev3fgd+/owMBWU65+HWz5c?=
 =?us-ascii?Q?GY7XaSstN9T88vm9AAFLjvroL5jpGkli+3P53uGeRUM/Wpn5730iD9Rb2rci?=
 =?us-ascii?Q?FWk5UJJStZz5ulg8tVBF5v+8+hHrjmqb1JbzozGbrpPBJVwhuMLyncohzWaN?=
 =?us-ascii?Q?TirYFyuptaiYbEENe8rp2jHMssvkC5aN3bOOJ9PplSyaotPp03M/h4elz8g/?=
 =?us-ascii?Q?/aOVCNjJIT+gwW3dEUqHexd+2UXLGAL1bVO5SDF3kz4NJGKCXpoUaOhtDPX/?=
 =?us-ascii?Q?isK/8fv4r0PRHIObLkIU8HWTlzzg/MdLPaZZxMTrZcirlAnLhyJx8cOFmv9I?=
 =?us-ascii?Q?Z5uS1PPKtBgg1PIulETHR3Vt+gIbR90XHueE/bz9HB0wsr3Avv0BGLJAm5FN?=
 =?us-ascii?Q?NZ96NEWnZFw02JDbztP8uE2NLWQ0HGv3grw2JiXQeu9E+YbHcKP272KZmqHR?=
 =?us-ascii?Q?ysWDOfR4zFV9n1azjxzNosLQZvWcXe87SBrxngglfwoKaiBrO82prpqniP5d?=
 =?us-ascii?Q?BKDmcQ5jqkgUuWchikYuzXcE+NUhlbfN2s5QXNKHDvNZOBqesb0UwlIN+SnV?=
 =?us-ascii?Q?iawGZdlgAPo7hpH6MkNte7VA9f0v8GQE6HTYN2cOa9kxy3W0Eo1ivMGFc9CB?=
 =?us-ascii?Q?UZuKDXgVMFwbpWG6yEaL9A8DDL47+SWiRYLhO36I27HY+jsGMGlwZ5EPfKAG?=
 =?us-ascii?Q?X4qLCD1i4L/e288K7yAoOOgGZk9DEXnjKFJYD+rHLXm5rSgOqniDZYbNeSLg?=
 =?us-ascii?Q?rGBgl3j9JwLJbriLAtmkRZL1vZr6VuXctN+I6fBIiI5Gh5L+RiIMZPkbzuPw?=
 =?us-ascii?Q?BIgbku3Ia8n4OqVHNEICLyIeONL5TWbvYWrFqRAngWnDC4vRBdrdMKkDOQXI?=
 =?us-ascii?Q?pnnkXk3uQY/5TTc4s/UVdEmFw4ce4Q0tV680tsWE6mhQ4CKg1mWHlbkzCFGS?=
 =?us-ascii?Q?YyRwdzsUVR2GUFKgXEGjWgjSx8eKJTAAqpUshnbzLs7xfzJzMOPA2fgwWFRg?=
 =?us-ascii?Q?J9wda+Ln+KQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P5wjyaLvErUAgLy5OEsUyBF+qawKsmy9k9TIuDpo4McsOok8zjj8lH7ZVEKM?=
 =?us-ascii?Q?7SEgP9mVNE6EkfmjnKACFi+O1BiyaT0w5IuXPQhqOc1o6LJTTzAS72x6alE2?=
 =?us-ascii?Q?jbazB9/Q6yh+SAOSkbqd5lOseCrCoIGLLvs9T/LSVluamG/ygXREjHS8S3EG?=
 =?us-ascii?Q?XnMfnLa6R2yOvxXUo9InjpI45w8wr0FOs2Nmhx20IWkOeoAgtJE8a/GxX2nh?=
 =?us-ascii?Q?0uqssKbsF+IhAB4Ejt8RDftisXzWf6O5R6hsTSuqztdUqe0F3LXnNonXbMJn?=
 =?us-ascii?Q?MirSFRj8oK1Nq7e5vzTJSDWgPVBHFw4Qm5KGxnL13oz9B6krYEsBjlP9A5Sq?=
 =?us-ascii?Q?RFZAIPsBV80o6yYMNdY/F8MHzUhyJ1S5HNkH6H078Ea5KYIII7I1E/jDR64p?=
 =?us-ascii?Q?UutGT1vpCgeoiz54k7Yk/ZZl9ykKM7uxrFDfKcbLcQ6WSvY0PTQkU4lL8+bV?=
 =?us-ascii?Q?NJ1ZkIxSSV6bwj8PDACXE80XUeG908qhO58irXrxH3vEgZLFe4//R+wSi/+v?=
 =?us-ascii?Q?8AjLGG+UH8oNYUyPhHYU5yo4aYomM/6mZ2SbtviOlqDcVX1m1iOhgQwXwvcp?=
 =?us-ascii?Q?cmQdRtIbEKJM/sEbuvTk9ot15Ss0alN3ChYP1jSudC4LVbeKJWvxAYFJNNwD?=
 =?us-ascii?Q?zGYxAOtgKeOLEBOctOJKrrJw01gjkDsmNLGnPnHAXMq4QPge3/yaz1wnijZ1?=
 =?us-ascii?Q?6FnpJHlJ69kmVBrNvlgeH8s+L6E/Ki6Gn1dmnFPNfqPaLwEhAO6LufSrFx2q?=
 =?us-ascii?Q?lcF2mcIrqxB9mgrf/8obIN9ehrflpSP1x0OvKmzkCNUTdkSOpQ7pfq6VkTpk?=
 =?us-ascii?Q?VNAkugsnV+xdM8wxtm7758/cMfEGSZ5I5XJrSUx2zGN7aq0JmcBdmS5gO3+8?=
 =?us-ascii?Q?26Qr+kurILu2hTdf2Wi0CJ2LOqX6GPx2AfkDJzSyBuxmR5onoCkgLcM1mwb1?=
 =?us-ascii?Q?EPe+FWEB1391pEMlhFyWWDhyxvHDY1IniVI4fayixzHtyEyGATbc4HUvamS4?=
 =?us-ascii?Q?kOi0/xRiB42zd+C7lGJGNR9iLvJZ1cd+aFYFH6/A6kETn885cRqZwL6kVjkj?=
 =?us-ascii?Q?3zRZu7eSR/emmjVVU+j6/miVLQTaNWcZfHJgCtTQTY+mqUa6AvRD89TdqSPR?=
 =?us-ascii?Q?ahk+8mYLsn3oAyOIKAtvfJ8/t/cN7pdvKAstKtG8uuCd/bJ1jjA4kgviIiBH?=
 =?us-ascii?Q?MliHnn97dKz0FMPQ9DirINOdZjPEg5+sqI1tCSINQ8yirvfRpf7Jqt/P2cON?=
 =?us-ascii?Q?u5c94IR1PY6DtRgixEDEOpQI4Tlhq7qUIULr6V0RKApUSwGzNjdFpKh1QLGA?=
 =?us-ascii?Q?DwvhIylH+G1GlAV6PhvbiWua2NFFrfiuA3A6L8ydP+BmbC/xh3Ytd2kTSjoe?=
 =?us-ascii?Q?qBzlxQIRG21GGfyVai5MLSZ3d5KH1QriIePRenDjJFjHm9kdxuUw9sRz0ebC?=
 =?us-ascii?Q?qh4vSygOb7FBATBe0HBDNxhaIA/UAXABX6QEaLmEcSiJ9kLl9tr9ibUuReEF?=
 =?us-ascii?Q?GzhUZZ/nGw1lSwbfpTLQZyuzjvI9Cho1uS0sHGh9SL11K2oEErdCWtC/44r6?=
 =?us-ascii?Q?myHSWneRT6wh2UUEQcuDWevUPM/VD3Ir5SkzGEwI3fOA7iXseq72giIj2IMm?=
 =?us-ascii?Q?2v/soPyC57A2BywLO+DhZaI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d371dd2-44ca-4b9b-5c91-08dcc3b484a8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:45:26.9310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujxhPZtMyLT7kHSjboNwU1239TxTbkR1oSfQl9hjux9htGKR5ssFqNnt3ESumY+osd+fPaw1knwkFU5r9Sz4oPJW9VoUCGzURcMrB+q/Zgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11224
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

Changes v4:
 * fix bug in debug output
 * add more comments
 * codestyle fixes

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
2.43.0

