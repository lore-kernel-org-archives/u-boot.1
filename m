Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E87ECE57E
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDD7888E72;
	Tue, 10 Sep 2024 00:27:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="g7ZVCpvJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92FA3889F8; Tue, 10 Sep 2024 00:27:36 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 964E688A2D
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOfLXjfhfjbm1sWsGzkVQhrbTFPaQkchFU7TfdMRAxsKb6aHLG1rtG9AnX2eQQRvJAG5zutZzlgWcoei9t3LKSF5Mq0dOk/kMLQgMP6DY8Dqg03FGI+1HrZE0ctul5Fyqbjzcjm2Fhouj5C82WLwoaAw5uGE6tncYbqi6wVwapzKSuFvB0r8mIn3MSoCEsTPpsxL3Jatj0HLOAzBkOCz6JGVrAO65GoXd5i2af2iTGUJQGHtUfqKO+9lgCDcBFz2GMerbMb8vULo+gAnL5Io6PrFW+OGuSjNw1ABOVWylX1jKUag3jjAyFFBluC+BgzhD4gv8ZFYTejjWkzRlFh83Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncZFQvxP7opxbJJrEslCp0tk1KjO/3FQGrdLwv5YrIQ=;
 b=d1Zf8RaDh9crhDMtrq5GCejf5RIu8JLisAg4W3cDjQX3WyBp7tQRbVDqbPd4px6kAtcdEiZljqizztxei17Q9RZrS1WR2R3YaXoOw+OZlXpTtxndYVpGAZ9H9uvmKWemqum8JOZPmvuIaxiYvpBlO1SriSaKaRhC7LbTB1Tw98LA7eAGWcsC+ovUzHkTopJu/6CGB1tRN2ipFtoIFaxw84+neL5k+Oi0JMpwDj3HjOEzhYIcsCmfM3VCuAkEL5zCi/06HppepEmGs67KsuJw/32A/MiM4rfOP5Ddm7PRI7xEJEMqZLqWRrzzbZY74gDSKrjNOBg9cO04DrdaFpMHgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncZFQvxP7opxbJJrEslCp0tk1KjO/3FQGrdLwv5YrIQ=;
 b=g7ZVCpvJGq4KpZrYxJuNo8zYvImsa0zeVZSDt1Bym74bTjd+PTIhN+TgLieRpDs2IHMMgCWhA5uQoTinXQhrwhR7Wk80fC5HLnUE7Ylvjv2PMtiV5yigDZTwZHhBKM8v0drbajss5YSraniWbUVZdvrEzmYEb1MJnJ+js//i54FVxQNlittEtIjLM1bs45EBmeoybbGtZJ77R7+MsZhcxRERTMzGn+Etl+VRaWTj9dMoQIaMeUpeddknh/xuKYm9wKbT2fo1wXOTXRiRVlj6A9jlI9bSPfLVGLg8zHSmVtdcPDk96wXgnRPHj6PHiEcQzHqZIl3e/PCEnJ+u5ndw7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8722.eurprd08.prod.outlook.com (2603:10a6:10:3d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:27:28 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:27:28 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH v6 00/12] net: tcp: improve tcp support
Date: Tue, 10 Sep 2024 01:27:08 +0300
Message-ID: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: 580aa39b-2f06-47cf-2d92-08dcd11e9663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wI6atsHQkHLWIOXZ1Q/YujDnOBk9Bch32KEHjLa4NNloY36q7Z+BcYJE/sAL?=
 =?us-ascii?Q?HF18OKGgRzAwhyChEtSwAPJg0BQ/DvURPnvlsetDOMCMv8/BOEj5Ycr2DtsL?=
 =?us-ascii?Q?+8jCc9e2IeWbe8e8K1T3iDS5Io1xPvjApjXCfxe1MqJ8r85RMmrynfPX8ezo?=
 =?us-ascii?Q?A7YKgWjpN1kpl4hsuPJJSIH1pTZ/NzcFXJxdHTAxI8gn6+P6usDPh7A8+P4w?=
 =?us-ascii?Q?ldfbQDzNTQ9u9un+g9fftCf3cu3U35leVIxQfby+gy6cvqrSmMNaLbB2mMFX?=
 =?us-ascii?Q?Mvn6vgL9GVYrJZq5D9BNw5BRWcmZKKrWAyDd2yj/9IJG8hlhuDulQ0xBdu7J?=
 =?us-ascii?Q?f8/UtbBpJcgVhulV419Bx3SEy5xXj+6UbySOhqFZxCmR8lquZK10zjuM2gmc?=
 =?us-ascii?Q?ZnjrJwpXwM8eyaZkh7OXiTTRos25CIe9YBkq8jnY3jxePXq4ouXEVm3QOTie?=
 =?us-ascii?Q?xIsJph30QTOY0Lw6FEZjMq4+Ptveyk5zvOXUzss1xcmJuH3A9EPNTAhaWPzW?=
 =?us-ascii?Q?zcrMTNjBgDhSLQDtl+iQ26zBIfh6g3iHy3YwLm856sGPoNXNCUF6++9ZupyU?=
 =?us-ascii?Q?Ez/VzSJ7uzTlIPvcv1MscSlsTXX5kIcv9El5AHbRHKxdFR9E7PZTG1EchCo0?=
 =?us-ascii?Q?iEZ8a4ELFChiU9HoX+0cjBRE9AwiiGOX2+FL3bDZiIR2zclh5GlMwYdhprRL?=
 =?us-ascii?Q?wYsY5l7fqxowJSapcj5wbifSAfYfdS5iDgSfYiRE2sXl/WDFhD3UiuKrF7F8?=
 =?us-ascii?Q?9EOeym36nrLDUWG942hG4/WgY9akSA4/2oWUs6L9pa5NKwUvNT9fXG1iD71G?=
 =?us-ascii?Q?rxSYn+z8QJeVWAA5MFvcXRt8rqE89llbp8M6EGcgmB31f8t10HW9Go0j4aDs?=
 =?us-ascii?Q?xASSk1xl5glQlvk1RTS9gmF55Uj+ia0QZafjum7QGAhFCOwrcIvugwpdukSc?=
 =?us-ascii?Q?qqM6WokMRMV9n5nnanQbM7jV1wm6Jywk8G2iZN+md37fZHi+N/a3iR9D3BGU?=
 =?us-ascii?Q?CYyoQvS+UPwHCsPl0Bc050EUjPOf2nZLufNZo29cHJXO1Mx6HwGk7DIUHqRD?=
 =?us-ascii?Q?clEcUcwoD8gZngL/3tfdGtaaI6FNnxy2Qw4pW6D+dzpSKPQK22cQnn5O3u/W?=
 =?us-ascii?Q?W1vDbLGUHJIaVLN7a0DmlCxrWUOfR/mCm3OfjtGbhXJiIvnUBZ+u5bI2TlT6?=
 =?us-ascii?Q?m6UllEXvq0RZwozvuMSALCd9E5UwT0oAcC+bpf4xbEQNrK3OgrY8yqNzNR24?=
 =?us-ascii?Q?pIqiwpM1lt6H53nEzzCBTMVXmG6KdYGFV0igpTax4aXFVEh5AbXPcn2zi8L/?=
 =?us-ascii?Q?Kj78+pzKm3+Qf1Rs7HMifoULm+Byk8tcmnxvIE+Mfzd/+fAtsnaj/fCfFpMA?=
 =?us-ascii?Q?ace/RKgUIDBTTMYNtSNhweNTI9U/aPBNwryS5e9V0NZNkpVqVF1aAROSLffY?=
 =?us-ascii?Q?aEDi3csn8s8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ABkSLEGsBVWOv5rYYNrPbcM2F/ytGt7gZjyi4exzwlyYtFaVMNW4XMBU/fVr?=
 =?us-ascii?Q?rQAFdoTamod9q8NwtSKYvSLJZd5WRd7+Nz6UUqFz1Ybqf0TUna5anSYaYHS4?=
 =?us-ascii?Q?Wn8DBYKAvAw1TgHZbAQjbz6DJV/yERK9NBgWER6US+lUneV1jwSJb1fGnUJw?=
 =?us-ascii?Q?w2VB/CcwpIVQOzkhjVwFZSKILkIFOOqVbwzsXBHfVd8j2S8CTIiWTWwUeyiD?=
 =?us-ascii?Q?8D2VwJkOunFtPLs2DSYzTHIAt+XUVaqz+oZjvLgPNTxreOv0g7UvPffyo2jZ?=
 =?us-ascii?Q?rV428u77mKzWBigCM87n8I0xIM/ONYgRdu6T7CVBGFHEGhK21hujiKh8CHHR?=
 =?us-ascii?Q?YhcTrZCRisZ+2rb/URW4AVoqBKQdLmOf3VctCBbBNnMlgANlt6SSGU1NcNVe?=
 =?us-ascii?Q?s4WVht8cPhgGO3tC8Qzl6n05qpqZx4y97hocKnXZyZK+kRRtd9qU74Y9Jjp8?=
 =?us-ascii?Q?828i9ANn7J8n/J+yPuy9dCrxwvTt7GD92bImzngO0XbEHTCox+7mSBCw5G6H?=
 =?us-ascii?Q?8Mpgs7nELOTs5QM7G28TZoaZvFdCp4B2abF1S0Vl/7zoJL9eVTsHYbBOSOFR?=
 =?us-ascii?Q?aX6p5G0ghLa7Ju2fWSPOssBA2/3jeEuaqbtpqR8H4QnuAz1CgD5PCrIixWUk?=
 =?us-ascii?Q?oQLWnL53FLIp4JbZUyN3KwLSJYd/2L3yUCuL5fjRssh46q8ac8Do+PZN+2X0?=
 =?us-ascii?Q?L7jfOGuiW7wldeqvt2ru9L3xYe9uyMt2LEC6q05L6JYYci7iu6nWq1EgitUA?=
 =?us-ascii?Q?mlxS19qNMMWxM9W/HaK+yfVLBsFSIxpSjNp33ypn2xfhyOO7KFF03CHnUX0o?=
 =?us-ascii?Q?VxUBKx4zhb/+oVCk5CZ8ldpwif2XlzrOaMdxFJZl1V9Gyyg6xM6yQ8Yv8WFj?=
 =?us-ascii?Q?hBftmb7/agScVUDnGgfx9/LZkoOwpONHczAYBpl+oBGESDBwRSUHDnfDfVJB?=
 =?us-ascii?Q?JSzC754jbZ6ZvsQnoCz2JYSQFpY4PxyRXiJozSVtQdz66bUb+zHRs+4jYFKy?=
 =?us-ascii?Q?1Uc6wRZbc0l+CCdZR/ls3GpKm7OAt6vla/xSSb+71atOfE0pfeIaTxCBFEnj?=
 =?us-ascii?Q?uu8Sp6RVL3oKL5NgyeuQzlihlSA08f05PMJCDA903MD4LIxl7Nt2aN30WYf2?=
 =?us-ascii?Q?MBI/5Zld+xBlX3rqBwm9pPGTFNyQMDbHik7J7TduwGETcvXgRY6/96aaSmNs?=
 =?us-ascii?Q?t76ZkzccxnX8Zvv2MoVr72EB2LH6YUm8X+rSZZwSkrZZc3cgJzoEoLtjgdtv?=
 =?us-ascii?Q?rZiQUpmPg3mU2MjA1ozdQ+e/q4h73YxjvchE1yWTunKKrwpBHlP1JTc+iTu5?=
 =?us-ascii?Q?aqmoCuUEmPHnVuaKwNkfhX6wUW4/SjddUTqcy6WIXWX33McX9xQI2AmHJdNj?=
 =?us-ascii?Q?UxA8lM7EPe1MD/6+h5lTVlkdSnISwHs3c9Of9GxEKIml0PV4s0K0yFcWEfyq?=
 =?us-ascii?Q?+B+kC2pwVAobPF/WX0rn/nWoJrBjFJ/Hio2jVDS8D5+vlBFjfZtLDy0qnndO?=
 =?us-ascii?Q?dSybxAW4DXOZhrPJvh9uua9IFecpwhzwfrtuh2f1EQv2u2iKxBYlbPEkYbEB?=
 =?us-ascii?Q?2XnVK8n84dknpEj/DZCuNRa0p/x/jrlIDIGgnFCWJRlJbw67U6e4IiqHKgRf?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 580aa39b-2f06-47cf-2d92-08dcd11e9663
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:27:28.3346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0Kb+VC619f39fDrwUAd8BRs5J3pezrIDzfV6Zj4USIfRAn4JkA0vL0j1PUpaL62JJqu1wiHgCyTKJ1hbJZbGD6TkclUETjbN31WLMj5YyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8722
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
 * wget generate bad tcp stream, test should fail but it passes instead

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

Mikhail Kshevetskiy (12):
  net/tcp: fix TCP options processing
  net/tcp: fix selective acknowledge
  net/tcp: put connection specific data into a tcp_stream structure
  net/tcp: add connection info to tcp_stream structure
  net/tcp: rename ack_edge and seq_init to more common rcv_nxt and irs
  net/tcp: improve tcp framework, use better state machine
  test/cmd/wget: fix the test
  net/tcp: simplify tcp header filling code
  net/tcp: define a fallback value for rcv_wnd size
  net/netcat: add netcat over tcp support
  net/httpd: add httpd common code
  net/httpd-upload: an example web-server implementation for file
    uploading

 arch/sandbox/include/asm/eth.h  |    4 +
 cmd/Kconfig                     |   21 +
 cmd/net.c                       |   54 +-
 include/net.h                   |    7 +-
 include/net/httpd-upload.h      |   12 +
 include/net/httpd.h             |   64 ++
 include/net/netcat.h            |   20 +
 include/net/tcp.h               |  235 +++++-
 include/net/wget.h              |    8 -
 net/Kconfig                     |   14 +
 net/Makefile                    |   21 +
 net/fastboot_tcp.c              |  190 ++---
 net/httpd-upload.c              |  123 +++
 net/httpd.c                     |  692 +++++++++++++++++
 net/httpd_upload/error_400.html |    9 +
 net/httpd_upload/error_404.html |   10 +
 net/httpd_upload/index.html     |   14 +
 net/httpd_upload/upload_ok.html |    7 +
 net/net.c                       |   36 +-
 net/netcat.c                    |  181 +++++
 net/tcp.c                       | 1259 ++++++++++++++++++++++---------
 net/wget.c                      |  479 ++++--------
 test/cmd/wget.c                 |   45 +-
 23 files changed, 2618 insertions(+), 887 deletions(-)
 create mode 100644 include/net/httpd-upload.h
 create mode 100644 include/net/httpd.h
 create mode 100644 include/net/netcat.h
 create mode 100644 net/httpd-upload.c
 create mode 100644 net/httpd.c
 create mode 100644 net/httpd_upload/error_400.html
 create mode 100644 net/httpd_upload/error_404.html
 create mode 100644 net/httpd_upload/index.html
 create mode 100644 net/httpd_upload/upload_ok.html
 create mode 100644 net/netcat.c

-- 
2.45.2

