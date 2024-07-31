Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0C1C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 09:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43F478897A;
	Wed, 31 Jul 2024 11:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="RVSEptrn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A0B0871C7; Wed, 31 Jul 2024 11:21:34 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::722])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A30D488977
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 11:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDrI0KiBp6OHSOAcX80znezREorohBYvv0MoNOpZz+5NH4rr/ATtQ4W8Y4MkbcmH4FKjwygkPuOvXmJKZrt+NRVnIpyKBgmmB9hnV+o93YYkjwcaUQDvICjyky1Cf0np8EOX6fn+h9MoCvLQGcdB4uR+NFlUMi7whbbs803CzQTWdWwTX4HQyJ3hteQek18ps2/rSrEVVpSJnNoC/u5zTS9P5HQv9j/llugLGXvfULg551YsWLcnruNEtbQ1kobrdrRklNMn68Xa07Ab6WjkwkIgH0tupkKTY7+OX43oI1JFBlcYExH34dtFJsyDFeEcxAJzvOkJI6EeH5XQBD046w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WaK2jVyaEnErfIi8SJF54xu95njMlVULcIKI3nHj20=;
 b=OvP+Is75YjGV0xjBENE+d/vc5VC9B7sa5RXvI9OWcC6H9biSxZT1ejKG4tHEvhBw29RP7nFvxe22QaMFjGGfnqq5Y4sg3KzcfdNkcuHkx+hAyJMAOt0Eu4icZM0PmwMsWJOo8hzC+pwPjF17VKznFg7wSjGOhXU4BRQUg3dIKR4BGpqWWaNUuPs4owjb3pj8w35Sp1N2SgNZUMr6h5KdfbXG3Fq2MEfj6yy1Mr5JyHi8064a9V4cI6LVAZ1HRq7Un8Ejisnt0ZZpQYugVWEVgnFo1m71N+s126hlfE/USk+uIZS9m8v/z1Ou1JMvY7Boo4ojbIbVk/DFOVnSNL/jKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WaK2jVyaEnErfIi8SJF54xu95njMlVULcIKI3nHj20=;
 b=RVSEptrncYVC/19PBiezmTg4Lr8YlYl8avkzHqqxLUjJLtmDZHbALu5ahTBfS2zfBY/qeN+HZv+sai/36/WUVv7fxWN0L9+rEw7btgNkyzoTgs9mVp6XAhE96UhgfbbG29JEBLW6LddLAfqAy8D2Pu1JsMpkZW1VePDBz4lCBSq3kc24tegszj30Nm4sAvrX5vUasDXJmLB+FsazgD3ly+JnXChWw7kr2M2NDfkLSFL8WH0N1hoOiqETyRlsENnPK3jdFtvQDH8EtC4zzAZKbTvaDkmn/zyZ5mTpt4tRTV/CRQEI/0UE8Z5hSxpUMxPGdc/UDIukICZktmwg7jI68w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10180.eurprd08.prod.outlook.com (2603:10a6:20b:62d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 09:21:28 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 09:21:28 +0000
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
Subject: [PATCH v3 0/9] net: tcp: improve tcp support
Date: Wed, 31 Jul 2024 13:21:01 +0400
Message-Id: <20240731092110.4027134-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10180:EE_
X-MS-Office365-Filtering-Correlation-Id: d7911f97-cac9-4160-2822-08dcb1422859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e6ufjW20q9aJy9yxFNs5h106pOcdBqYVnegt3kFcxxAkVELOlV45z3t6EUkd?=
 =?us-ascii?Q?9+9KUJZf8OqYYrkmypVbBbV6W/DVBdVVKeelmg5SMEsWXYQsNQGh0WoTwuB1?=
 =?us-ascii?Q?mWNG7yhJClO2s2EggY10WVi+W+rIRnhEEyqjQVBWHZH41bJRfYgM2We+PwKN?=
 =?us-ascii?Q?vOnIiQ0Un89wC0P36QkhrXGJifeYIrwIRT2woF5RRcZlJ2ckI6l3RzBWj32d?=
 =?us-ascii?Q?p/PUamKpMxk+FTANzprFNZ5xf45PCzNKnHRv0NLhTRHnr4HZdIPtbrcj9ZHs?=
 =?us-ascii?Q?+vY6GUFsOZJm2N99yPzbpEtszMc4kLtRRgVk+xCdzJ5xHK/UwXbjI/4+tFrh?=
 =?us-ascii?Q?doLam0qUxYeBFBViWFEHbAM13ffsU1NH4EFhKIVZyEH5+krmnJ7LI+AmLd/d?=
 =?us-ascii?Q?z/QhxrH2J8CmqCfdtE5jVrFRhQ620nGtKU/iY8sxD2RamZDjXb/LfaFuuFV8?=
 =?us-ascii?Q?1nhGQsz0S3vCH4oSlS8K8QOSTBdpJYJxxFE5zLokebsCg5xqrYAmI/Nz3chg?=
 =?us-ascii?Q?FFZybg9dzdBQPAxz/HqHwFKi0VFgTiDObFY8rAfVeZncGjvEfUONuq0KUtGw?=
 =?us-ascii?Q?FkghFieBL0wRRXRTmCpWxwcmvuPq8STTLVGnAYcPLv8He9wlc9ChYfw5EcoZ?=
 =?us-ascii?Q?ClORlGHP3jfWDzoK4is/5Vi5zjeVrjr6WtkdrcIBPCm6HqZcR4xpE0joiUOd?=
 =?us-ascii?Q?RW+EHgnaGbf7oaKRDnI8TNg0FwNMWAu/7j/pRukXEPZQ7hBd4TliF1JLN4uo?=
 =?us-ascii?Q?IW2XmmlyZFgmlYy3/6edonjHV7SgueccQ82PovtBAj1/Xa18z+KwSXY0s7Yo?=
 =?us-ascii?Q?A8OnGX7UQZF21+/CSL6HquhbjsEeqkkpBp5YtSnu7yLGMMXyQdvWxk5TplVq?=
 =?us-ascii?Q?gpdc7dA6cZR06ZBSoyQU2R2M5pneEjWbCUl5ODekny4ex2nwkn2GI9fp2xbz?=
 =?us-ascii?Q?VOgnwacditaLTIAWRIrB5LqMFJem39masPgDOMhMMASNhgqG3+ESXPPv7g/f?=
 =?us-ascii?Q?59Nr4LQIssF7RgrQzBtJTTueIQTMA5IIlpgFR/+N/0jnkyVyUBApVKkaW8ib?=
 =?us-ascii?Q?O9GTQ2AHHr/gwghTGb4hSuKFK2QooZiwqr1XHZ/+hyi/+rcFfOcfdRrdHWpR?=
 =?us-ascii?Q?l61lGXJjUiIOccQBs/c2mQjiMlZn9+K7tjeVWATIvtdX6874aJFrOIj2GNrY?=
 =?us-ascii?Q?tj542xiXYhT9MP7v5BDAoRxc0S5HlhB9OKQwRkkda5TEiidxtboKUS0Hxz5q?=
 =?us-ascii?Q?qbJ5Ha1uVfjZkHEQCHrzl/0MUDWHO5Tu0VXkri0ajcW65ReIVZMnmy5Y0ebf?=
 =?us-ascii?Q?KpFx+UcyrkGj8so2qv28oUU/QKXSqXfy5F2vuuPZRPaf7JwXsuPc7pJUidV8?=
 =?us-ascii?Q?MNvPdyho30vLkZ+QeBihJPpo3r0X2Uva82htJzLaJjIss4mTbwOoEo5/wafO?=
 =?us-ascii?Q?uufjOvjaxxE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EifhE9mppQcOH4wbHhl5TE6tVZlz+lkTDbur3vb7MGCEc9uqqJr6c50azgvh?=
 =?us-ascii?Q?jTwLi/F58Gl9SH7TPayy8xpudDX396qV5g1NSw3ztxLiMlMCEB9//SRx+91K?=
 =?us-ascii?Q?sZtfMznZ8On+5KqMogdj0Dp6IDDblPerbXmv0CHVj1g1gZ2SLzCxUk3jwqd3?=
 =?us-ascii?Q?l8UZT+mOSbPb7u4QPBJNyuvxy8xEJHB3AlGPt4tp3IBzxKFpccCxketJzsKz?=
 =?us-ascii?Q?2tENNZ9w2kDZeBz5awRCVgsM73eJ3a6eV+7mef3LfqoJLWjlIJ5Qx3sXG6FS?=
 =?us-ascii?Q?sIUrS3b3N+GuqrjWhkmFIaNOyz4F8Q1Qv6E7UU/H73tNbOUNBEJ/Rzg/b5gW?=
 =?us-ascii?Q?RUglRURGigPQPfdtbRaAEz+/pDRoDPppmBVK0E+LD6+QMQsqxsuNocQQ8tEb?=
 =?us-ascii?Q?OrZg5lVGxxhubSDQ5TS840tb+AJIryJo8NboaPUKwO4dxMq9RS78W4U/cuEV?=
 =?us-ascii?Q?+zAX0q78yLEPMfFOH6dwrx/Ez+mNA9Mec3o0ZaY3xd5+yO2v00Mow/tex9EK?=
 =?us-ascii?Q?dcnpNpJsU0Mc65bTAHzDx/YKzAn8D7CHG0gPByZVgve1jCujXlDfq3adX3Vz?=
 =?us-ascii?Q?Oni9wO+yWmlhCMz4Qb2jEu5FSrEHTNKfPJPyhNLyleXRBopAiN/eVSuza4ks?=
 =?us-ascii?Q?qJ56CMCIS7ymFPTZxxHux8qliCcjvMJQ5ezWzg27nHo4vVh2MUqzNTbTJgb0?=
 =?us-ascii?Q?uOOYIGCZjhbeuTQSpB16ljmT1MxuUr9mu2oTXj7D9RytndlNJ+QZbb4IzjFR?=
 =?us-ascii?Q?oTzGBQle0+F4nowWabxj0UEzlsZkQgb2vhJ26lGswFJmTCmpcT8xiktTmmQx?=
 =?us-ascii?Q?Ab9/QKminn5yGTw4RXR16mq83F4vxl5TCeL3AnAXRKTYSs8sohDHAXgLdXf1?=
 =?us-ascii?Q?5YgAMAfLbgXmgQDZ1Jxd+bNUg0kb1Z6ID/iLiW9h/oZ3A2ZydbvbJd/Hq83q?=
 =?us-ascii?Q?UvwKTmwSPGLhqEXu0svHMJ/Gh5ItnggRGJ+IvlHt+vQ8CvF/3rvzP7EpUDQX?=
 =?us-ascii?Q?E14ezTJjQ0A7SJ5Tu0kPbCoL1eefip2AXyETpdHHB3yKTSxixusB1GdKow7t?=
 =?us-ascii?Q?AhUXMqe2opxcz5P9jGMKf76cv8DB0tG1eyXQcclbfBanA4s/hlQA1VRjrtUZ?=
 =?us-ascii?Q?+UZT3jhmvoGoiY+L4AWC+IOEhw6/bbgdbeWIIK1n+VtifmPXxQ+Ke0NzDEW/?=
 =?us-ascii?Q?gK9KeJlh2tg01iB1QhN3//KECOzW4x1L+TAFvRdWDTNMtZIykDX1dgJgh2DS?=
 =?us-ascii?Q?Lul1iOwGkM8PboLsKZEb+Zqpg7aNIahS+DacL12iECXr+7YgynA9XPxxld4A?=
 =?us-ascii?Q?xjszkVMCL2cagCW7PccYj1N0sDrxTOaFGhaOeW6Cdcu9BeOPQCZaOdiKATvM?=
 =?us-ascii?Q?kylQIe8w7qpl6+ulK1r9YETY66yTdKjvEGWzlGclnx8Cg15ITQEsBqUChYIq?=
 =?us-ascii?Q?fncCMip48q7Ev7LXBb5F087flyF2axupJT7yvrPfmUXAEj2Idu2NHIlXBRRB?=
 =?us-ascii?Q?8lKXH5wIx5R8vlMi5pkejdnt9cphQ8g13i1igDJ4Hq4CK17aveRCjwYuSuqP?=
 =?us-ascii?Q?sbtYgj3i+6FbDnLKAiweV/CjEPhyZEdCwdzSOLsWrmBXJhySOsFwXBGvda0U?=
 =?us-ascii?Q?7m8rQYPihbPqmERHFgOR+Ic=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d7911f97-cac9-4160-2822-08dcb1422859
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 09:21:28.4504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nETl9djeJpl5tWWsoK5hiTxTvpXJMUnTJ7efY2oYTHYHwY760XC/CDbSeCpg+aiozW8e7gVHf5WwbP0qxXGyH3607qcIcJtntcu/qpy11ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10180
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
 * netcat linux client.
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

