Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FE3CF9C68
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 03:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B9D38839E;
	Sat, 21 Sep 2024 05:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="1bFD91xy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 663888839A; Sat, 21 Sep 2024 05:44:07 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D1BD8839E
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 05:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ww/BgsBVGDJDBvD8eoPwDAL7Va70a8kzTw7CPHLUSO7ZhTSnFyEvz73C6mx7611TE84ARqkHM9VjT+S2LzoN1BpuWtuqvNvL0SyQe9c+HsWW6qLHqep7WBdTnMeCwm0JeKBmI03d/fUTxS1auuYAz/BLNlAy8FIx5ZK7lxD4r9RZk1OHxKAfvZBvW5DipOYdghL6UPP2zho/kJOD3XADJRfhTwe0dWweZ6YmiDObt83UdR296i8oGyja9HjJDjujWufTaGaJvd+V+3RNufctUoZTyzGtjdEingROTDxybpEfBCFnkHvftqjD0iOQjaRdXcaPD3twYDMTzVE1J9m3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kXYHMocO2CKSF27iSgyVYOTpEfasNJkN4vyYtEYJ8U=;
 b=OKpiVGmZ8+VtkugsKCfHnn05dzMzh6a1IOJDPE39vQQ/FrKqPeDhnXB1OEN+sC9rVjIa2RXpsnHxn03NKI4LYXwTd+dkHEpb2RSNXvXVRKh0x7hEiad+arqkXlRzyw+MMraQ8p6SW9Ophhnq+CXLtVRyikYfCs3upthq5MO4/9+SAgq3/OX8XkPcWMZKZUsTD/EoYDAIH55EBYqCdbCtw9txh9WgwtHJZ3rxuD9fX4U1QN3Pz47tAQ+hevo7qUVGzN3k4lapAK5bMG/BVBoiPwiwZkakUUkSs5ydTgZcfRdWaV8dXz/eUVpsyTceE6iv/tPVI2EhKzRaHVnjGG0A1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kXYHMocO2CKSF27iSgyVYOTpEfasNJkN4vyYtEYJ8U=;
 b=1bFD91xyruGvTZCj4bAx0qL8MWZrOOy+nnFtnx5dJEuvp2XedMeiQ57INdLvxPVVYG8vLWN/ztzygY9ooTwWqx4LzRIXnHkP7DAtXegBEBIuXwnbxoD/wUtZGpMWfgGiaxlQhI2o35/u3p6XkFWZrmTvyIbMSU5Nv94ADbivUYIEiuIbq2lWBqrJw6AP1Ayn4tJshMoR6YykI0AZ6jtnbhpw5WgK1G6XZLYP5olEx9hWA/vmV3p5xH/vgdk1wfT986DbXI7Kqws87Pm8DIvkhuJzFgf2UQkzHJjWf1Fwm6Q99MmM4k3S8yBx/3H4Zf5lOdbib+RIEOW9JdGbMFVJOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9418.eurprd08.prod.outlook.com (2603:10a6:10:421::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Sat, 21 Sep
 2024 03:44:02 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8005.010; Sat, 21 Sep 2024
 03:44:02 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
Subject: [PATCH v7 00/13] net: tcp: improve tcp support
Date: Sat, 21 Sep 2024 06:43:40 +0300
Message-ID: <20240921034353.1298452-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00004595.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::440) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 755392b2-9b0e-479a-d7f3-08dcd9efa1f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cJlpV2iGEH3Vb/pQf/R40EWI+Np8yejlpp1xR4pywDE2MjLuQNnRr4ip+DGo?=
 =?us-ascii?Q?7RyiFsyB9AJg0SHs2zKcavESc9i5jOrWKTAMYTC2oRa/JNCxynFxEf4uFVLU?=
 =?us-ascii?Q?pHEaP2QgkV3MJGj0i6ksiXFBlV+7iDryxiH1jtRTEW/Dd0Ob7KMjovqpJ7EV?=
 =?us-ascii?Q?KaQZKudpl5KkPO15/yRCbiPHtPMjTmJiDkhb07RnUcAsGYwuGlMUsCwIrBsC?=
 =?us-ascii?Q?xYPX7ZToUevT2EUzAE68NphwhCkvFkCwDBgjvdBSaZ6RH/Z152+RpSvBF2SA?=
 =?us-ascii?Q?9dcFjChhpN3dlpc+SAPirXmOBiBfPXzrnrbQoM5RoOYqBJmDyQHGHR2VkcUz?=
 =?us-ascii?Q?ZbqNYp2ikaYB/ys45bq/a+cHV5cgJtrNbjkMThmfnQCGB5OAT6UEEG6tbPIR?=
 =?us-ascii?Q?zVcyODsy4rxk+hP1mnaiHYPMaqDw7Kz1r4g3118CKlbgWf7hhsKSSu2/MOu6?=
 =?us-ascii?Q?Wjxg1rqGbR279eHuEabaou96yP7GdG96OUReYrGX1njv0x5+zFAfGkt9Iyta?=
 =?us-ascii?Q?8afnF3X6+N32HMRQWpFdC7jpe5AsEVUNlQ/nZ7gnBFlTPQzST3XUwtzlfMeb?=
 =?us-ascii?Q?tyI1v9Dsuo2BWJhLQcSIbfufoT5Q1nP6vRG4GG4F1mBSLMAT4I6C+g2kK7jJ?=
 =?us-ascii?Q?jAaAIDgeCZKLdDVSHElYa05GWvSBk/OGW99q1oQC/RAdhdCVU3BGWr6L4IgX?=
 =?us-ascii?Q?ZawOKe9DPVkrrBzA+fBDi6qGFgnnzmCO9CSKtBV+TDFr7INgb01RsMI2SX/W?=
 =?us-ascii?Q?dlxruuBIJ3IjNXF30mzINVOudIzCYpDJvu4uyuVt8CN+Ek/WZ1+fAA60ud7G?=
 =?us-ascii?Q?Nq/fklVnywnpr7aG8z9kArpMw2GX/en/x628WjRw1QS9gwZU+izSNn1qGb2U?=
 =?us-ascii?Q?/YH6avEzQPizlqm25ZgEya/A/4UfAaLuBkMPM+R1i3XjAglqFkbHsnpKbJg2?=
 =?us-ascii?Q?/B9cJWJ52ZuHjQo1LY+t086cNiTRAM7tXPstvVBtbaAUQitDMH7t17gJHhm1?=
 =?us-ascii?Q?X5lVpAqUJsDVXwj//QNo5qZcZoEmIflncSGEyq/SWdwf64UN0Y1U3rYGwgUZ?=
 =?us-ascii?Q?JDaGVIjfnelbrTUXJDD1SpDfEFdSi1bn8vJw79IkQplfD5vRKPlBT9OcK2f4?=
 =?us-ascii?Q?+mMv2hk3r71sRZNzQCzPgNXJgxmYDl+eGQD/ndmvBUdDlWK7RuS4gj4A1m/3?=
 =?us-ascii?Q?BtuV9Nt9tHx/xyb9/70rx3k17DEAHiFtSdlUNl0t0rtQPQoon8gkyb/g74hS?=
 =?us-ascii?Q?Xd15hJIaVxESVhWGHp078p4ylj/Sqb9T+659U5uC6e6HvfL0su083TFwYyDh?=
 =?us-ascii?Q?Cq/OvgpMjhOo/ech8YzP/CEwECSA/Nkkq6iqqC6YSXN0Oq7nlnN+J4d2HOXF?=
 =?us-ascii?Q?VbkMAJc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bHOouV6hDK+0PfADEclZQssXGMvNZ3LWIo56FV8g9nmjxZ/cvETM7DCdejeW?=
 =?us-ascii?Q?FmUXjpniDGijNWCM10ZX4xwpE93P9+GvZLVTpqwf/EpXm/JJHylpPq0K42Ld?=
 =?us-ascii?Q?9Vl1iGjnrY/AS1Z543JzhNs4ZA7b7QTsFq5fIRxC0L+6QIXkXwbfv4sDw5bI?=
 =?us-ascii?Q?potB8ye037OGAbP6CL+LkXwmnhx2Pu2hkH4RQbVay+TOAZIhgc7ikdvMTcCh?=
 =?us-ascii?Q?z5c646I0kbOSgsHOkVVNxIQMdQc+jwKf8wCU0DhyKl9VV0tUUrxu+D+j44q6?=
 =?us-ascii?Q?9dswxEHlvzzMMOgPnJUatHUqxFwHOiObtQMRMTy28/frPqQuE5fVz6BX2wSM?=
 =?us-ascii?Q?Jb+N4MFS0QQFTEpSOsaYPHWNDZ5DwDRTnCuVXaHHGdPdgmCYcvA/hnPWXfDg?=
 =?us-ascii?Q?mQrNGTCU7aQ0xXUe8FvLX/4jZafTzGpa6LS/4841RPp5tvkn3aShu7CFSjVN?=
 =?us-ascii?Q?CcDzy/k68EVh9C0IOoNpi6u255B2dysKn0+SS+qHzzAKtKHXSzNs980caFy/?=
 =?us-ascii?Q?A+NMfLeqjhoKTMsLE6ppqpjCUGygVfblAM5ks/4CJRWnOzpTi8FzQLi44ug+?=
 =?us-ascii?Q?ttvAtBlUwBchFKHvC3KY7OR8ohl9hoN0l6brsWxo9XKd2lrQE+uM8aOsGz66?=
 =?us-ascii?Q?HbjDRS0dFmjsd1pv5jqRfyL2PhCxFkv0JRdhl56Lzl+bMgfxzdzOWzrywfqD?=
 =?us-ascii?Q?dBJf/68ctgX++T5v8RvuBTAv6x5fAZfxO5Bbiq8uD5juzWk1D2QwWP/fN+k7?=
 =?us-ascii?Q?FgunwuHKC6f76WlXjiFZAmSG+eHtxf1Yc0VzK7uJfx3hjTTdImqW3ayC4fKg?=
 =?us-ascii?Q?jQgzmAPNB3lhBRf6hYL0oi9y6HRrjz90UDcfYZkEcSMMQC2iAa6PxZyvjsRr?=
 =?us-ascii?Q?w8l/+ZgcLKKgDCW++3bIXhb2xfMMIhrDWgG5Qc/E6nyux4Zgsk3ElPgQ7tYV?=
 =?us-ascii?Q?GcG4wqwg9uwFIDGiPVXZWiZeo4W0Cu4QUnVyU5IRxMDgXlmZeCnL3BF5WkHa?=
 =?us-ascii?Q?nwxkSt605lURdLxCk8nsqcdEV40eIGe+ocM0lto8lbdpZcpapHH+OfPaUppu?=
 =?us-ascii?Q?lC+2NI+s5ijP/bpJVJI3043iN3Fg0b2gz3BWAva39U73+d4Z4HIcKvHOjlFd?=
 =?us-ascii?Q?HGp1wJhHsGM4o9iML8+EKbitSIxm8iwhrQ1w1+f/mjq9EtD17yAxBhcejiLO?=
 =?us-ascii?Q?46JoXHPNf4eQRjysOxg4l9BA6RjIS+TZAPYveux9KjTMmyy/6whKc5jF4SV8?=
 =?us-ascii?Q?dNFh3LlaCqwFMgPs+EDuIkehrBChWTltuAdSvddeuOIV8kb+wwFFRemrfG5u?=
 =?us-ascii?Q?QhkKujPzafj6W9Xzq1Q+dTXrQPL8VCUh8RpuuLRwFtQ+QIgTlQRqaYXyU3Uj?=
 =?us-ascii?Q?YSqCNGllEMJ+5HOQ/fmCx6tcEp98J4yagwgcTKC6mXxkPE0wHg9iXhz6oZgv?=
 =?us-ascii?Q?Y8YQ3i18fZ+wqS9iotv0q3g2sUq+EC92AHDRUDvxREvm/C6unk9ywTw1oNAJ?=
 =?us-ascii?Q?Y0SwbthraNomCZZMXeQQVzSuMdfuRhNCMwU49AYzGcjtdcWfsbmOoRLw0l/n?=
 =?us-ascii?Q?LmABWhzRvSI2PTDPSIlvDHqHkHuLmQujqoQpse5+/IUNJi2WqUeYztBTv0XK?=
 =?us-ascii?Q?NRC7GltwHnu/M3fsbnamnk4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 755392b2-9b0e-479a-d7f3-08dcd9efa1f3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 03:44:01.9680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: px24g/TM7ZgZV+XhT3WzNzBsXayZXgpeVixdrYhhUtIeLB91wy6L2fjm9aC3ft+fK211/ElmVWcRGpJueUFaVfQQuWug/FZuq5D9AG/t1eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9418
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
 * wget test generate bad tcp stream, test should fail but it passes instead

This series of patches fixes all of the above issuess.

The benefits:
 * A lot of bug was fixed
 * Better and more reliable TCP state machine
 * Tcp cliens becomes smaller/simpler
 * Data uploading was fixed (now it's possible to transmit a huge amount of
   data from the board to remote host)
 * Netcat over tcp was implemented. Netcat supports data downloading/uploading
   from/to remote host in client/server mode.
 * An example web-server implementation. This code can be used as a base
   for web-based firmware uploading used by some vendors.

Modification was verified with
 * firmware downloading via u-boot wget command
 * fastboot over tcp
 * netcat linux client
 * Firefox/Chrome/Edge using example web-server implementation

Changes v2:
 * cover letter was added
 * some patches were removed

Changes v3:
 * better cover letter

Changes v4:
 * fix bug in debug output
 * add more comments
 * codestyle fixes

Changes v5:
 * old patches were ocasionally sent with v4
 * add back web-server patches
 * fix bug in debug output
 * add more comments
 * codestyle fixes

Changes v6:
 * fix the wget test
 * improve description of "simplify tcp header filling code" patch

Changes v7:
 * fix include ordering
 * improve option descriptions
 * fix a lot of extra brackets and comparisons against NULL / 0
 * add empty lines before final returns
 * fixed a bug with zero size httpd uploads

Mikhail Kshevetskiy (13):
  net/tcp: fix TCP options processing
  net/tcp: fix selective acknowledge
  net/tcp: put connection specific data into a tcp_stream structure
  net/tcp: add connection info to tcp_stream structure
  net/tcp: rename ack_edge and seq_init to more common rcv_nxt and irs
  net/tcp: improve tcp framework, use better state machine
  test/cmd/wget: fix the test
  net/tcp: simplify tcp header filling code
  net/tcp: define a fallback value for rcv_wnd size
  net/net: fix include ordering
  net/netcat: add netcat over tcp support
  net/httpd: add httpd common code
  net/httpd-upload: an example web-server implementation for file
    uploading

 arch/sandbox/include/asm/eth.h |    4 +
 cmd/Kconfig                    |   35 +
 cmd/net.c                      |   55 +-
 include/net.h                  |    7 +-
 include/net/httpd-upload.h     |   12 +
 include/net/httpd.h            |   64 ++
 include/net/netcat.h           |   20 +
 include/net/tcp.h              |  235 +++++-
 include/net/wget.h             |    8 -
 net/Kconfig                    |   14 +
 net/Makefile                   |    3 +
 net/fastboot_tcp.c             |  193 +++--
 net/httpd-upload.c             |  170 +++++
 net/httpd.c                    |  730 ++++++++++++++++++
 net/net.c                      |   60 +-
 net/netcat.c                   |  194 +++++
 net/tcp.c                      | 1259 ++++++++++++++++++++++----------
 net/wget.c                     |  481 ++++--------
 test/cmd/wget.c                |   45 +-
 19 files changed, 2691 insertions(+), 898 deletions(-)
 create mode 100644 include/net/httpd-upload.h
 create mode 100644 include/net/httpd.h
 create mode 100644 include/net/netcat.h
 create mode 100644 net/httpd-upload.c
 create mode 100644 net/httpd.c
 create mode 100644 net/netcat.c

-- 
2.45.2

