Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE42CF8870
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 20:56:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5497288A3C;
	Mon,  7 Oct 2024 22:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="TGuAWO7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87EB988618; Mon,  7 Oct 2024 22:55:57 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 625FC88CD9
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 22:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLGMvcpjLJfsuufV8wVKGUw0QJo2GnPDk70LQ7Y++o87pXGg7RR+G1Ymwrlgtlqk+3cwKbAxQsXcBo31Yqvecoxta9nBpCi8rij6TI0eYmqAdy5v4Mi2oKICVxkUquQ5AgDH46Q7hxzppMtLK9cnePgzLu6IQoQTaXkkacf9fGy81elq1jMBs4OxZnelRBn2bJ0RBpjUMrmV6UCDwHD4dzbLbq9zMOQQLFYr9t88S4ptE6yANmcxYocG7cgvgwXq8okH2kayLiLAexxSTzf3T20UPOCixeICvpPO1Vaf5w6MwYvTPbq5DHEGdQgTX/Buv4OmsY7j5BkLovQRdwRoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0T3E07zsRhDA10/wloJsLvjS0TpnEfA/yPKnMjx+hfk=;
 b=dgzOj78m1977TiGYpwgx8FYbUlRH9n4I5aS1p+xAslwxcBmQHLSkB9ZC/69i0xH6OFCPahUS6kugThpQneCv/HnnOyaiw5lF0b6d0WK3Hc1Wg7QEO+EkRosi7hDwcIpQduNy+aFLJYrusxkeLShOl9dOyfic4PQ3lf08DZibfMDIifmA651BqeNTkHh3U/MMn40lXJMb9qSK8b4D5/iTkcF2FcIVA3cMEfsfm66FmTE1gUGk9LSxjouqJ/mpRk6UnUW1iygX6lezhHJJu4USEupDsKU8twzyVQyAQYJPEYBrFZc/hOeHrEvGVRqcig/EF++BcjnzNgzuHsHQ+LHbjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0T3E07zsRhDA10/wloJsLvjS0TpnEfA/yPKnMjx+hfk=;
 b=TGuAWO7JcboExG0o8jSU6kOPzLKMZPC5ghT5E/DZI+/uU/ZjuCGuW5Shp13zFoKKqnOlypryvPyjPhlelpWDO2PAIqixA8E/PmkB26aibYHU1sC853yJNLYuRRy6y0xKaPJ9C2MErzXVjXmatcpGd9u1+c+F7T4jQjp7L6OkztmuGPgZZBy+E7z9IKpIVq1P5N2U5BWdZPTQ5QMyYHHWTbVPsZ3m6oF4OGjvt4LqCogs6g1BH2uWyG7gpNPT1gw6l0gfI6mL1woYo4VUpnnNEcQa8Hl1lZtouO7tGeXNWMOlgHE+rM8gLxc6FpkZTHcXIdsrtYH/KnRrSYGZXavAuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9018.eurprd08.prod.outlook.com (2603:10a6:20b:5b0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 20:55:53 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 20:55:52 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Anand Moon <linux.amoon@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v10 00/13] net: tcp: improve tcp support
Date: Mon,  7 Oct 2024 23:55:30 +0300
Message-ID: <20241007205543.1632499-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0394.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::22) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf05039-26bd-4bc5-154c-08dce7126e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|52116014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2I1REYlLD5PYj3jW2znMbsdNxui6MUFon/gao6g0CKn2+y36HoKnQs6l2nWY?=
 =?us-ascii?Q?HZIlwhASUQ+0aLakK6RT6DFQmvB2IsSIsQIaLBOpFO+5LcXGekgL6Kc59LeC?=
 =?us-ascii?Q?a/xmd8m/QaP1ZXHSB84kSU6TxjLnkT1dgGkiXpS5aCMAA6UrQtwN7+RL/Z3o?=
 =?us-ascii?Q?mJzkTL/aO1b+nwJ3wY34say3sSWrx4x78UGsnkv1QiqzurYhOwTsx5Tzb7lb?=
 =?us-ascii?Q?tdkKa6XBqEajW3ADNnR98pbyCogocLZOFhP0yE7tWqc+kgE9hB7cH1T3xKlW?=
 =?us-ascii?Q?ClxccdOGHZ4uQIwEy8YbHQzG8KQKm1zgpP6+chGCDvxhr7uFqL38lEel+RUS?=
 =?us-ascii?Q?b5SMDeoZQGOtCkoVb+/ljbstr4coKKsnDkzUN4kqy9WkkkxphQNJIcTxqduN?=
 =?us-ascii?Q?hPZsXGNNvXyiaR3s5vV2dbV/63xfGCmavZHA6OO+izlKhPs1UllogeKK5BhO?=
 =?us-ascii?Q?0FQ4uT15jgXf4ooWbh28RS23gWzjENDuStsSdmexlxoD1ZD9d/GSuM2it+SL?=
 =?us-ascii?Q?z187Ns5J0o7RUuqVWH+KZgCyCbfvrREVG11Ij7m7ij+rEL3IRg7lF7vOMroW?=
 =?us-ascii?Q?ZDVZxcVJTTKuq5fDd0F0iiHn3BYh3dpAbOYoc3hNknIL0GhSvyUgQZ203FKa?=
 =?us-ascii?Q?p0RJ5m8c2Z98puTFP9GvePOY1aNF6d1Pa4TokiWG/GgBax4tfrzP1rQ+9y4R?=
 =?us-ascii?Q?tbhs9Lcy1F79bf01DuNv5QK2iGdVNGz/JK4OKTiw6xnJV5cDOFiOkfdPh+Ld?=
 =?us-ascii?Q?CAIPlbTnBt/Ia2yDenVpHLoTXmBE9SoNJj+/OkCf+WAhxklGOjDpxOY7pE94?=
 =?us-ascii?Q?HVhMlELV1U6CXsqMQnmAZBeV7R/SM0zsGvAEoJAfInA/sRAP40sCgGq5RBau?=
 =?us-ascii?Q?8LXyqUPUlit4VItnt+8GgD9kvms3CZhX7Nw89j0RcjReZUsNrHplcDIV9X0e?=
 =?us-ascii?Q?Ru8tTBYQ7wNos4x14dtR1fZpEEav57j9waVRW7ARIyKdodl6qXGzJ6yoyEZW?=
 =?us-ascii?Q?rmoNXnulyA4fmCt9SGwoKTh7jB2Z4nk50IBgAwVHtlMqecz2np1V1YNdlJIC?=
 =?us-ascii?Q?0WJvud1V63dN2aRniy2s3IFBHpuSFksthv4MfC2wsO1hBNfRD/wKcLxQoETL?=
 =?us-ascii?Q?u7EDAAhc3qG6Jgw1OdqNgwk8PatpGfo8MPTyAm96u3d8QfN2CEcTasuBB9oy?=
 =?us-ascii?Q?7X+QrQdaplC9eBJLdMkSBq5d91h/0UN1xyRNmyMkrPiq2qcn5yL1PGLC+Zpx?=
 =?us-ascii?Q?Kwhr3tjO3st1dGZYmv5254ptuZrx4FGmPS3zZgLTfat/l1BDclXQtcNkyLcC?=
 =?us-ascii?Q?S65BQfpcnDs/JRLCtNvm/WSJG38ge8uTz8MIAT9TxCxzUHwq6GySXuxh1c2u?=
 =?us-ascii?Q?YHXFxFU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IWDlDggYOTbBG5Ietu512fRITyfPh/omHUEPnh+iB4OjCpMgR3uuOE7ViSFn?=
 =?us-ascii?Q?9FCeUJspYs0VbbUTxROg/i/YUFE/gMuFNS470grHrbcgJJ89hZyrc7BdK8Jf?=
 =?us-ascii?Q?7+x/yaSsqSS57zvuFgloo4ug4LMKL4+JCmyQ5kyGVNU88zXi9gqOvAUwF6qG?=
 =?us-ascii?Q?Ac1z1954L/OUDjsnnw2Gy6fos9ALjjUdnBSiO2UfYmOnp6NKLEg6uZEjXBdz?=
 =?us-ascii?Q?7VDhaUaI0MBmSm6Rfzr/SqVzZIbeXNITYQZKH/EnQvIELCt0Mpu5hK0kJpMX?=
 =?us-ascii?Q?fwzRAfVfBqu81j3+q9Tpnl9+i6uqLp9qA4t0Q/db1hT83tw2rvcUu77EBBM3?=
 =?us-ascii?Q?Hb06bQ/+RjfD3U+sIQXADe0NpvwI7YykQBnsMnoF+/hNKwj0oWGelZ2RqyTa?=
 =?us-ascii?Q?w+D5lqmhOaHUGZGjgeFmJ/9HEhlN20X03plqkrU7NByeB2d95ZgMpgNA3p4A?=
 =?us-ascii?Q?qtLJB+jW7Mg9jsQk8dx02D5J837+Z4fEU2Um0oIoInpLzbYwOB+cCzwPZ1e9?=
 =?us-ascii?Q?2lKoVHSCSbatp3BMGzuieNrkKqM6EFyNMbv56QAZRY5boPcHEU6Jb6pyYYP7?=
 =?us-ascii?Q?h8GD7g64REIsCHbgvpt0N7dBVoKfHBWxljficlQeOR3R+0ZKST/c2/tP6eH3?=
 =?us-ascii?Q?mEMO6K6cSb/PZOkSTBbGwMpbamd/lqrCxi8MIftip8g/GYdQjTIbRE6W0VuB?=
 =?us-ascii?Q?ywJypSu0KNs1BIwLmPPomQXI2bLqc6SM3RwG74t3dHPKDQuDcc2iks5eYrlO?=
 =?us-ascii?Q?cjFItxZYGuqfx9cIOiWp2HMNVKrv0R+r9XMiszY6dnBzAF1NwTT85gjh4kXM?=
 =?us-ascii?Q?KGeobpHNoJtJRN4/xdkJiU+miDK9CcmN4WD7vEZK6TbFokeR5jG8p6iQcbOF?=
 =?us-ascii?Q?9A2B450SAFX+sPjCL2SLpBA8juRBTqPgYMvYX9KMiayQHRtrrCcGD3Xq88WM?=
 =?us-ascii?Q?w2YjoUj7ZwVh2yhUVRdgdfaQE3QJGPlXEXqANf6IxuuwbSWg9L5bp33xWICm?=
 =?us-ascii?Q?HZTe/kTkad+goVBw9WUUjij1MzpQ6BIQ41vN6r31uUlFY06ibV0LPiTFBnoz?=
 =?us-ascii?Q?7OjzpIoYnG9uXaJsW3EnF1K1A8hxUcVuhfueMPyvOvgFuk9l9zniD0tT775T?=
 =?us-ascii?Q?brKp4cxLRKMAClkkMFwi4QxEkRdc/CFdzasIgln6MXwsKTxZr65uwsaz+DGT?=
 =?us-ascii?Q?8703bYUjD91ONKJYdzusUTmO46W5PFWFk8wRbDB3CwONS53euS8LUXTbwfof?=
 =?us-ascii?Q?RLzf75ol9If6BmLb+m1BiH7y/K3PTCjJFty1Uky9xAUM5jx2o5VCNzeG+K8l?=
 =?us-ascii?Q?Ei9kt+KPyDnidSKbHDBMT81xEt8RP0FtNzeOiz313PuhlDb+l1WP69Om5tRe?=
 =?us-ascii?Q?Rwi8clWJwO+dDCNlWczHbSrhwSgrwT2IoRWzXEjfx9wLhtXCVHTwTqy6pP5U?=
 =?us-ascii?Q?rgnFfw5zRc/bL8xXcdp5Xy6Ak0S/sOrLAkuObciHDEtIomIXMrRUU8zB3e8y?=
 =?us-ascii?Q?e5FMBA9gw6GGi4Enl/wLNtc2X978dRTBlWSROmoOB+HMl7Z4+4zH22Eaio/8?=
 =?us-ascii?Q?oII15+e72zdxREmLPhdQlZOLMbOnuId20wPbm9EDocKa8B+CSE7GU3uMIvy7?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf05039-26bd-4bc5-154c-08dce7126e5f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 20:55:52.8567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4Yv0y/l8yTOYl5i04PmMlBGLm6Sn/2FQ/S7CkYBhBPwePvTCk2LzuYc/dwbA1kQsfcaxUHmoVq6pU4dou6D4Wkoi9BcijBRYfkg0XnTKsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9018
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

Changes v8:
 * [tcp] add function to restart rx inactivity timeout. This may help
        in the cases where remote peer waits for u-boot data, but u-boot
        is busy with long executing action
 * [httpd] add function returning underlying tcp stream from request id.
        This (with the above change) allows avoid connection break
        for the long processing post requests.

Changes v9:
 * rebase all changes on top of origin/next
 * update test/cmd/wget patch description (bad tcp ack/seq issue was already
   fixed in origin/next)
 * tcp: add rx/tx packet counters to a tcp_stream structure
 * wget: use tcp rx packet counter instead of own one
 * netcat: use tcp rx/tx packet counters instead of own one

Changes v10:
 * netcat: fix bug appeared after rx/tx packet counter addition
 * rebased on top of v2024.10

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
 include/net/httpd.h            |   71 ++
 include/net/netcat.h           |   20 +
 include/net/tcp.h              |  254 ++++++-
 include/net/wget.h             |    8 -
 net/Kconfig                    |   14 +
 net/Makefile                   |    3 +
 net/fastboot_tcp.c             |  193 +++--
 net/httpd-upload.c             |  170 +++++
 net/httpd.c                    |  735 ++++++++++++++++++
 net/net.c                      |   60 +-
 net/netcat.c                   |  191 +++++
 net/tcp.c                      | 1266 ++++++++++++++++++++++----------
 net/wget.c                     |  476 ++++--------
 test/cmd/wget.c                |   58 +-
 19 files changed, 2723 insertions(+), 909 deletions(-)
 create mode 100644 include/net/httpd-upload.h
 create mode 100644 include/net/httpd.h
 create mode 100644 include/net/netcat.h
 create mode 100644 net/httpd-upload.c
 create mode 100644 net/httpd.c
 create mode 100644 net/netcat.c

-- 
2.45.2

