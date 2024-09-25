Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F05CF9C69
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 01:41:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F65088BC2;
	Wed, 25 Sep 2024 03:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="H2yVyY5o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67948882B7; Wed, 25 Sep 2024 03:41:17 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20711.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67CD088B31
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 03:41:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FevMLZSb0cUcJvpYrgyuPpaNTRSsfqzCCUlyuiNj3cbBtyg4PavJ31UoDxhK2QXacBWCJ7+KZeYZIvXvgwWJGXitHWN44HRhNpD0Dn+m5S7XrFYoMYr5uGYgEPVrtghFd7ok2dC8Oyja3zaAcTiwYwWcHfEAh7sMbQkhkoxWlo4P8z/tTO8sn2ugAOSJ9vxeH8Yi9tWbu7mXmbZZfqUXwX4mRbU9VVJPkCBQ4XcITS+mzlSxzov+c+wqkXU/3LBkq09lvMlgxGGxGbyDT/Wk5vvklMy2P+HBhnEr+JDhDEa4o2yfW6fBJmHfVLhWvHVLtQ8PtKFLCy/oiGhOJZ+iyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16ac6L+BmCkNoJpY4qbIR2kyFL+6X8/4oUmJJLMgNmA=;
 b=QPnEBst2QC/fsPpMC5cg9Kk9zz/Iqm79ClOO/qbq9fbDxMslS6EXZtLmWd0GX3AWRjhu6WoJmCp2F6rEMRYcGEIqnovsXc6bftM5O+R2OkDqSyJk9s2/E239ZySsVB3DU+Q3kDz0uwMNidH4lxl9kS1X/TyGlT9QbMteZg2aricN/EBxAD+yAucjv1J5HAkRpuWrnAzysRnisaZTRqUyRU7dJoYBq/QSyCG6mAUB10IHmd5l/zSdPz5HgUYhjE0Q5onxYcA4pm3R5eyt+E+4lOxJUzY5L57ryuCdwz9zrSGiBBbyI6Iaa6DfB294X833GpTUm+UVP98u2wB7bqAjMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16ac6L+BmCkNoJpY4qbIR2kyFL+6X8/4oUmJJLMgNmA=;
 b=H2yVyY5oUEIak4hAIYFUyB1uYyT0E28lQmo3sqwplqnFrb+7wV5/oJoKP46Vh/sJQN0qdtQyCc+OhhiUOQJ4OiHfS+5AcLRhYamI/mVQje8CpOAxmcJ+ul/la6e5BT/L5gMYtIMjkWCmlQLCntQFXj2G40LOYFRHwH9DQnWpZ6ROgEU0LwSIbXlcb4TjUtKDi0+n3+HQjdNl5v53p8g6TtKSQNpKSYbOICYB6foAIacoezCu+tPb3mXEDYMVJJ9wqda9UWLbf/OLSz5RKpBzx7jKHWB/5VrYrtAqDWyLoIQeH9TUhMoIQLCiCNeFQb0znH7g3N2879auWXIGQqHwUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VE1PR08MB5645.eurprd08.prod.outlook.com (2603:10a6:800:1a6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Wed, 25 Sep
 2024 01:41:08 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 01:41:07 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v8 00/13] net: tcp: improve tcp support
Date: Wed, 25 Sep 2024 04:40:45 +0300
Message-ID: <20240925014058.1679074-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VE1PR08MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: d0bf2f1b-f20b-4c4d-73d5-08dcdd032008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|366016|376014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B5tv4xrnn/d5+umjfFVirwhm+09NJ/fe7SkBgYlVwlUeABE9n/5JSQA+Py/s?=
 =?us-ascii?Q?KTdf/rq+ywbDzJ8+liC8uknoyd3ZnsX5z8VWaoYcbvwcfJi23oYUfea8WUzw?=
 =?us-ascii?Q?hWkmQWlmXMUI9Kct6/dmxpDgmo74wC51rxIUsS2Vrg/q39cv1NinPIVEe/AS?=
 =?us-ascii?Q?/rYPpwaZ587BwHjAAM1PBDgDe4/CuTk7metMsHqLpSFoJJDIxx6ZEhOavKdm?=
 =?us-ascii?Q?KKDr2queR79WAn3jT1IUPIYOk+QxyhIHtU2PdQYr+Qp+8MtGRqtMBZvITcah?=
 =?us-ascii?Q?lswXN84q9/XBLir13R9KdZPN9SouVP69SzwVwtvd0C6Qvl/GMh4jMsDuTlkX?=
 =?us-ascii?Q?FNj6sxxsqwb4wZZ07EVBeH5AAqIP+VM7VxWypOEN1ktSh4lRBOD0E/ZFFe5e?=
 =?us-ascii?Q?U0+fKhhRJg2nZDS3mIPIyIGyUeJ/Ay2CfmgzGMOP9oD/abrRM+IgKXW/kt94?=
 =?us-ascii?Q?ik83oGogeJ0+huR5Zfb4kguv6PyHPgKREZPDub2Wt6pn3B7hFMMDUl3Ij/mY?=
 =?us-ascii?Q?9V8sUVRCCKZtwkbjK5xxaywoeWAYBhGMNp+J5tlyth5noS63RInW1rdypxoy?=
 =?us-ascii?Q?otmnESj1ToUiZvBUneyOuLA3q2COmfupNPgvC33p+d/hDrd17nwmTeJVczk6?=
 =?us-ascii?Q?yHQMHFTAXxzIHgAYQxDrgYJ0i/zxKRXYW+Qrc8Y1sCrhDESh6kcn7D9Lyl07?=
 =?us-ascii?Q?uXhr4B6DKdjSt55iBuTGAlO5JgDL2fk1aq9MMh266cQfHJBsvkCZrO6yCjSF?=
 =?us-ascii?Q?+R5W8sAZJKgkpEsrXAR9PSKOA4ORvMtJsilxYzpAcl5ujuiZHePxt2Yppx/r?=
 =?us-ascii?Q?TE8Naz+GE+35rd9pklbsdRzd4EdtiArEy48oQjhvPijYJ5WIkaaZNRsRvhwy?=
 =?us-ascii?Q?ZVm7xlRxNh1c6PUmQsZEYDqWKTJvtvLXixtYWY7VnBbyoNizXhokuHzCM0p0?=
 =?us-ascii?Q?TdAqGyC+5OXs+3bPLWzJ5g6tlIDNdY3TyMTpTH1AwurFtUoIubfJ9daR8evg?=
 =?us-ascii?Q?5J0jXRv6rFvCd6vikzjhwXzWNDC08NNnFIyIBcmHYnkC7UkjEfnqt/g7k698?=
 =?us-ascii?Q?kfiqKwnu6SF9P+o9B7WTOJE5oZodpmX0udoA80KSDC2m9xjSZ5YQ/NElRCz3?=
 =?us-ascii?Q?HFO/aklbNkZkYX7/xvYniwtI0eEivg2ZzrO9KdyFkBvLjviCmT0b10Icryms?=
 =?us-ascii?Q?LNvL6zOQW1B0KYr+mEJBxkrVuXWH9ZU//0gAJb20Jhorsbnl/k00H7i1z/Tb?=
 =?us-ascii?Q?qG+g/ubZIe1dlY6YAotOSjG62qg+xEdO9XArfmQRYAzBiZElKp9PQplEfn++?=
 =?us-ascii?Q?zGeGt1qs2E/LCRu46fXKwniYN6xvh2h8dTYbUl8q+TLB2mrRoyZoaawdwz5g?=
 =?us-ascii?Q?J0Vhj/EBP9YvoNCi0o0H7SThSuh91DrcuMc99NR9EUtDJY+bLR2IfIyuxV7S?=
 =?us-ascii?Q?PEa2dmpDCBw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lxas3c8GaBB11gypLER6TcWz3HSL7BN9MhIt3+CDuuIWxPQRi9OZ//MrMXes?=
 =?us-ascii?Q?FPA6HFjPWdGocPb2WVEtQywlOYW0W9esYs9ANvNkm0wzqZzXGWor4Rm3W0FB?=
 =?us-ascii?Q?ksDDqj0Wnl7D5NfVcBXNPZbAYMsSSqy2ub+FNphJtCV4YwOvjGaKVd6/Z9jb?=
 =?us-ascii?Q?EH5MdEqt9I9iKF0PQZWphvDeZwbbOAYHn8nYjoirnd7iBsOxJkQ7nJtloCvr?=
 =?us-ascii?Q?Aq8oNtr/Ohs/MZFdTGNkfVnvaXqQYUgdM5nV0wJPu9j+fftYdwbqqh6OqJOO?=
 =?us-ascii?Q?H+EWFJT6YFyvCMNgzOcQjpK1jTsh3OhWZ/j4HpmGVtxP7N25mc5kcEddsUyB?=
 =?us-ascii?Q?91EAVPKMvqHM6uyQTBXyznNg27l1xmIeY0pOrz8FQG19wVNj7TsD/uTRmpIh?=
 =?us-ascii?Q?M3twbBsIaKsghcrMZnO40c1u5fgze+YfdNMFCMvnVmQunSt0qxiWwEe0MUal?=
 =?us-ascii?Q?Jjm2Nez2Nj6uxnJMvOY7pLBOid2/l9SMjsUWwL48VCikRHRdLXIUKwAuEitQ?=
 =?us-ascii?Q?AFHuPAgFO3FaMsirWuRjstZeVTv4sfI53a+aafr1VbxNVidEeXQdSseKdD4B?=
 =?us-ascii?Q?4dHEwMtmYJEXBTXQcp57J6udqT/5WlfbBDz2KZMlm58JkVU7PPDDtPt46S6J?=
 =?us-ascii?Q?1Lq+VjXdiQ/uqAXfeAlm1dbKQQGSK+5aM+6Mm4OHCm+XtL2M3USU/JLNRpkg?=
 =?us-ascii?Q?1k2S0UXG/AED3sbFGtXF8bh0783tG+UPgKYjCffV/ScUZxHlJmeAgQHM+Yzh?=
 =?us-ascii?Q?BHRPA+sdgKPcPP/ROzHsedGIuhSDjX8Kc1f8Dupfv+KFLw3ajYSUxliEL1L3?=
 =?us-ascii?Q?X8L7SkTMzTMzt2Scydm4+VCqQ3seQ3yZT7ma+HOLBgl/S+C0+SQeu0RhT3AI?=
 =?us-ascii?Q?xoOcjHimnDNIQIWmdGnm1iU48eh/7VGAsitlIXY5iHP4lVePvanML32noUhP?=
 =?us-ascii?Q?ldwX2mA4uLSWiTIgxt5wlihI1YYui6PmP0HfCS/pLi5HxRANt7OpHTdEMxtR?=
 =?us-ascii?Q?O76rrqJBleTC7ylSz4pViEnYqKBPh7+VNwYEgr1bIgX0teI/Usbe23U7uaML?=
 =?us-ascii?Q?veh4v0s9Dy9ooOtxzZeYtYONPqgl6HGT6Z0Bs8x7gO4ecm5dBdSNSbob7Bmy?=
 =?us-ascii?Q?z+yYXScr16Shfj0gvTg1YVoFkM3XW0ZakoPVVCFvIHCZKgbDFyfjvSuP5Ijx?=
 =?us-ascii?Q?mLEOSbtrOU2d8azgYN9hdN9E7ElJkgaYr3jr3jbQNEq3wvrnIk7PtraKff1y?=
 =?us-ascii?Q?Y2zfUEw/nBP+8AFlO5CUrWQEc/ILmGA/NNWd8i3U+JY9oi8tqyhp7BUBAxJZ?=
 =?us-ascii?Q?r5K5i6s5RkDGRgxx6torY7LChfPZEk+WU+hoL0DCxWSVx/G/z2FTsB+UaMMU?=
 =?us-ascii?Q?ajWPqe2IMrDB9q16TdMjnVjAbElruoO+8a/yqeOHHKSgLIpS4/rmeBzQu2Im?=
 =?us-ascii?Q?AxMmoGvgEgUUxRBbqHtx1wkFuGu0rnbfFRuQdQZ0/16I4AAQgmmCCYQit+sV?=
 =?us-ascii?Q?LVpkXev0d5aFXBQf22/xDtNYuE4CbyjxLYrr9FTAAVlcMflIP58R4V2lDaXB?=
 =?us-ascii?Q?vBIReEczuHzyHpEs3AhGVVqvIkhNmBiINsvmr9QizdCz7vdakESJB0KCTA+L?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d0bf2f1b-f20b-4c4d-73d5-08dcdd032008
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 01:41:07.3363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5rqTaw4Harnh+eb70pEr2IIXpaOyoDyQSW9yqRyN53TjQ4GuO5uDF54a9tyyVlXjKLd7QMtLgYTJtsJHnEUt463srgX01U3DRprjiFyp3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5645
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
 include/net/tcp.h              |  250 ++++++-
 include/net/wget.h             |    8 -
 net/Kconfig                    |   14 +
 net/Makefile                   |    3 +
 net/fastboot_tcp.c             |  193 +++--
 net/httpd-upload.c             |  170 +++++
 net/httpd.c                    |  735 +++++++++++++++++++
 net/net.c                      |   60 +-
 net/netcat.c                   |  194 +++++
 net/tcp.c                      | 1264 ++++++++++++++++++++++----------
 net/wget.c                     |  481 ++++--------
 test/cmd/wget.c                |   45 +-
 19 files changed, 2723 insertions(+), 898 deletions(-)
 create mode 100644 include/net/httpd-upload.h
 create mode 100644 include/net/httpd.h
 create mode 100644 include/net/netcat.h
 create mode 100644 net/httpd-upload.c
 create mode 100644 net/httpd.c
 create mode 100644 net/netcat.c

-- 
2.45.2

