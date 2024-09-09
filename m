Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA55ECE589
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BFC688EA6;
	Tue, 10 Sep 2024 00:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="i9aC0CNv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7524288EAF; Tue, 10 Sep 2024 00:27:51 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB4488E9C
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRfb6NtrChJ3cWxAe0AiKbCxVCybSZQhgpG7/WlAfAokutIX+b30T8EzZxAOsKtZnZ10zinOzVIC8+ZHcIGLUOGuDvbrHLrbSar4SlqNoNcahTi3C/01XkjZu4zihMZzoTpuVH9Dsl6HcD2QKZE+2vtz32zdeOjXIGYhh3zc6ZjiBVlK38AM+owr9eNkC3QqV/84Egrw300or26iOjkOyql+XO4F5cVJbbYpXHg+s6hzN8ZEUVF0v2dc8mWgOHwZhCljxIti0wXOuDCfYM9+dmSdswb2lYxUZJC0MCDTXIqXyBMc/TuklaJ8GEP8uBmowUV3wgSUkEQDfVyFljS3iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8BESqXZghmVp0ZLPeUO5kCRgRmXLcBkEa24M3H+Pg8=;
 b=RZXSHP8cSS/IfVMY/rPr+Tp8ksZNIdnChU+z025vV6W+A1SaM9/0U1OJc7FXB2lmIsIfr1JgXY6ThZjS1fP3ZraxMI7OZir8xXTxhsolZI/1n5/rDHq5bwmE+8Nn5tPVkdUV4xkpzI8XG2Z9OdXVR5SXfTSt+6sVQoLpsIiJNU2nT1MS+bBESlwKqvqje0Rl4vPepfg7j1hF+LryS2KML4Jacr0FVGTD7eg/rZBxEmKWi6dEEAikznobMRgGd6VcsdBMDVt0c18lyQS/hvuyXH2HxtivfemF4vhcGAb0CH7Tc7YbvKgvFgoAwt+NeKUW4SoJD7l/gdZf+LueLcNGvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8BESqXZghmVp0ZLPeUO5kCRgRmXLcBkEa24M3H+Pg8=;
 b=i9aC0CNvvI9f7p6fVg/0+VI/Abec9pexT34MX1AllP39dpe2FMpEvy8/HJyZw4QjPQuGp2qUnzYcxptSYPTa5ioeqhNFcAaWjEbDKYASJNgKdaB8l9QA5oP4q0GcCqzGWRr3bxjry4Z+/bysDP6s7v5wTFyu+TwyIRSYjIGfEGjYahJM6AdDx0RQQx04bVpwATMVhUVSJHQm2ZS7CbR+oZMEm4Yrz+oeL7GlN4FMEMNbu2G9MyqgTLoFC2YwzB5Z8+01jhQ5D/N2qw9eCuPm/iQf6avXc4R84dGgGXQ3nXcXmRf31Uky9LEw7cCfR1qbbTOaibC9dNIz8Y9FJ7QJKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8722.eurprd08.prod.outlook.com (2603:10a6:10:3d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:27:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:27:43 +0000
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
Subject: [PATCH v6 10/12] net/netcat: add netcat over tcp support
Date: Tue, 10 Sep 2024 01:27:18 +0300
Message-ID: <20240909222720.2563118-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: efe12a84-e773-490d-0762-08dcd11e9f92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WB4SMNWU8DnlNFb3OR5be7SsTK7xfq7c8haVqrnmSYOPSMnQIXCj++Gg/6Oz?=
 =?us-ascii?Q?kJfOKTwAbk0J0xjflIE3VMbCVVECAghzUEQdoDpOsUslx4r81qXXAJLT/bpY?=
 =?us-ascii?Q?Rdbw8UNHszMW0zhPnIuPaqaj2czS4UhwhyW87DZYi3PkjofcKnLkWGNAV2fP?=
 =?us-ascii?Q?y7OJFNShvhb6njOjMIqreDQP0xzeCclrJU/ikplLAoltkGJfJ0tsql8Gux9S?=
 =?us-ascii?Q?E5BLSwHbozBtvWyE/4EZNPnxodVMX6fd47UGZxRuYhRYgREAAQl9o7ro4UDs?=
 =?us-ascii?Q?6mGv6ZxAg5Zp3JAKd92yQKuqY2fNMPjdXWobOy3MZLwPS7yUg4gewqvcC3rg?=
 =?us-ascii?Q?RjDP9Mr0znOlJeg4h0of+otot9Q1qG2Dan1C0uY5fRBfrnq9ybqwZikK15Wg?=
 =?us-ascii?Q?gt+ArhbxE525fBIXIdQSpsrFWmeyyTVyco37fsP1VIhOdaKsU46DV7TvcCJE?=
 =?us-ascii?Q?PUTPURGepz5TmT7gpPHbEyv5bhl8qbWeyKZ5oolS+lDKgnTBoYVYdnIgx3se?=
 =?us-ascii?Q?COWoLC6hoDIh7j093fnofDPrk7lUtnGk767c00hU5mJvRpR8COvfZ44lpme/?=
 =?us-ascii?Q?EwqzH5qMdvx/PfHh/YaVanwNuO4gb1S3B+2s3R6eTARwQ/27NOgki/Lc5tGK?=
 =?us-ascii?Q?TF3PNDBXHuc/sbWpASmrctjsF5Jmj57LOnizVuAYPGS+FxbwQt8aETS24D0K?=
 =?us-ascii?Q?bjU49Wi1b6+6wXU/A5kKHVUPCTcjbILA2nnSscxX3Groj0w2XX395sO1TZUF?=
 =?us-ascii?Q?x9YzWf055tDc45b+9Kyxau6/dSMa/FawnXfTNKBtafL0koMXvwTAKjcHt+2H?=
 =?us-ascii?Q?ZcurPB8/Cio/2QVmA/Yno1HJnPPDF4PI1ignSAZv4/8MJy65PHototl0mUzm?=
 =?us-ascii?Q?9W5YeW/rtLLSnQ26ITvs3A4ywmhyexMuxwEK7tDDt0ZwZocCzCsEtscH9jhz?=
 =?us-ascii?Q?fcT8jv2tADRzsR3gzy0/r/t6otR9YihUy4u5qeTCrbRIC/pOYmJtE1SCAat+?=
 =?us-ascii?Q?16oEZoJoD8rjdbcVyXYWQe3IF5TgqOl7gnPpBJut5yiXK95D9PNzgAEUkxbz?=
 =?us-ascii?Q?cTd7pnYH71dZlCzrvEirI/gQnT8O8ChV32m6zb52qEMsKaCupsrj1YjVQFPi?=
 =?us-ascii?Q?jMwDW+N0vi1jl92sfrIMPjkGsYyImB9g7H/2jLcXJOFt+GQiNa073JSREx8h?=
 =?us-ascii?Q?/w5caFtgfSA0++zHfkJrox2NRYX6SQclYTcrts32Ex5EYfyQp1k5yInrbbeb?=
 =?us-ascii?Q?XGRRXH97oJ7aftHBCffhEk8g4N6OM1RxxiW7rdCo8P+0foncPLcmoylxPda9?=
 =?us-ascii?Q?resy9eI11sCWgezzxwVc5UwFncC1zRwDqQoz3zESvS+9vOEpYVqCf96wCCaQ?=
 =?us-ascii?Q?M8AIaairgNAorFqdcCt30gaYz6YZ0/SZyQCn1pgxQcZBJobzAYHVzFsEb1+u?=
 =?us-ascii?Q?kJRtF7w7m8Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?buB9A3mZH18tkqgbPjsr3tI6dQKdlxpaoWJymblcclxBWPAHd/EeI87jgQkN?=
 =?us-ascii?Q?0AJ/yoTVYRgYDrwRFmeGaYiy7DowQ85uC5cOYsEUn/m1YkuIMVS2xmEQNawo?=
 =?us-ascii?Q?FPY15RghQ5p9QWmccLE8+d+QMYOW0LOlffSriklE+8WxJniBXjn2VFAr9bhg?=
 =?us-ascii?Q?5cm5PerPeJrYxkXbfj4254xPQiR+UQwMMLM9UBe2UDdZ/95xlf/1dCRO0EzR?=
 =?us-ascii?Q?nDzSfi5bReTa4mtCI9NOEnaCC2HIOtpseJMBFCebckgx/aUx/tEpqE0YR8PU?=
 =?us-ascii?Q?ZRdyKo6TdPAqvAqzLjlvP4UhoH9xW1FcGbbojfq6kq2Ql/Stxf75clpUYuhr?=
 =?us-ascii?Q?GeWGsAN+pd3qUOcVZWkCZOKEJ6DRDCTOQlBYrltjgUEOB0h3OXZ7dyqjWgcw?=
 =?us-ascii?Q?5wphSy+BikukIfHrsR+nNiLYqQ8FY1MUimm9TVHioo7i9ErHZotknz4/9FvO?=
 =?us-ascii?Q?eRNrkO+G0kSXguvnG6tquZAJEpJj0g+FFmELM0FL75GT+OYcQG6uAloX6rBm?=
 =?us-ascii?Q?aFtzPmVAQPashArtYPhw/LgM+aCyTGJ6AjTD4rG2kpjBiVkm27zjl7//KA0z?=
 =?us-ascii?Q?KacL2COdtodjlOAyYbpXYNdjnL8TMv4TQMUmyi/KtGvA1Uf0r/k9LAivK0Y+?=
 =?us-ascii?Q?B/sr5GGYGQhLMBhwppSRRCGJMd6AbRpGCuM56eqzrWcELET3LhT2J2x2lSdL?=
 =?us-ascii?Q?PH+CXAI/+QbvH2UKwFifYjtqNpxXY6HW+ihwoDfJ+HPXbkefx7wxraWwMeAk?=
 =?us-ascii?Q?X8p1ez4vbqDn7HO35ssnqtxeWLMqMFAHjRV1ZexsEyi/WfwZYgC1bCT2GEGj?=
 =?us-ascii?Q?2N/l3nvFyACNrAQOF0HN0J4vIlRMTuRWkIRacenqMXoQlsVJwaR23haaYjOP?=
 =?us-ascii?Q?ALirbtz64AE0zs4a2oPYT2GdZvIbnZ/zG/7gazJrLg4o1bLAEKMK51D0EYnR?=
 =?us-ascii?Q?pqheAMBW/pIrH4Adn0PNzhOaUzyt4+90CBscC5ulz6jd3XtWtOYJbyBP4nZL?=
 =?us-ascii?Q?WMHceisuU6KYZMNe/LF/dXIajkXTXu2U6n78qYFO8uQskKMM9uW23mJb34+Q?=
 =?us-ascii?Q?ylAeo3uDcKTdXyuKTZonOjK7IlHwvs8Eu0w+n6aw6D6ePsJ840tgrrYwT8pa?=
 =?us-ascii?Q?qhI2oGV+r4MBH7nXVzvfDu7PwAvIEd+UKBBAwFiFfDyX/mDmIaO2TMchjGK/?=
 =?us-ascii?Q?Q9V2GA1gM1Fb2w2fC1/OV9nlyFvGVF+/1zBgyAoaPAq1eXA6Gfh7Qt1Oh0TA?=
 =?us-ascii?Q?qovR3thKy5DqM52gFfj+NxCOGYwkugbF/g548tN5sc5ZoHND0hxbbGhXZ54/?=
 =?us-ascii?Q?Lc9YiWQpf2ayEC/DQXD+cf2jl1oBmhACnmgErGoSeEOcUqTM/WMGwrPdEPgk?=
 =?us-ascii?Q?DbG1hjgCXFlnUTMXxl1wOeoeqdTa7VwAbIrI+lth6rtP/TQT43Jkqy2M1eAr?=
 =?us-ascii?Q?FylsVv4F/co/8p8pgZIK1ojusK/H5LWbUBX/bXq25HzqkjrMSoritvw8PLfV?=
 =?us-ascii?Q?g1PYcskwJu1wSigyHMvhbfYK1+53lt8viyN578pPwQy9prDKTDrCFFtqsMV+?=
 =?us-ascii?Q?E6t2oG0ikOBQEO3hk1JinKjxz4XtGtMzi8IJJaTkiiEuK7F25DOD4CBtNYO0?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: efe12a84-e773-490d-0762-08dcd11e9f92
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:27:43.7508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWzqI3vZt0WoyELE+mNUgxkfSaFC9lCog9Nd+6rfPE1e17u0UFBNe9EYWXO5EeYdKca2fhmx06h1ABMCJp88HJRl7j2RfCFztDxu1D8FScs=
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

This patch adds downloading/uploading of data with netcat.
Client/server mode both supported.

How to test:
============
  netcat-openbsd=1.219-1 from debian were used for a tests

  a) Load data from remote host.
       * U-Boot listen on tcp port 3456
       * PC connects

     u-boot: netcat load ${loadaddr} 3456
     PC:     netcat -q1 ${UBOOT_IP} 3456 < image.itb

  b) Load data from remote host.
       * PC listen on tcp port 3456
       * U-Boot connects

     PC:     netcat -q1 -l -p 3456 < image.itb
     u-boot: netcat load ${loadaddr} ${PC_IP}:3456

  c) Save data to remote host
       * U-Boot listen on tcp port 3456
       * PC connects

     u-boot: netcat save ${loadaddr} ${data_size_in_hex} 3456
     PC:     netcat -w1 ${UBOOT_IP} 3456 >image.itb

  d) Save data to remote host
       * PC listen on tcp port 3456
       * U-Boot connects

     PC:     netcat -w1 -l -p 3456 >image.itb
     u-boot: netcat save ${loadaddr} ${data_size_in_hex} ${PC_IP}:3456

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig          |   7 ++
 cmd/net.c            |  34 ++++++--
 include/net.h        |   2 +-
 include/net/netcat.h |  20 +++++
 net/Makefile         |   1 +
 net/net.c            |   9 +++
 net/netcat.c         | 181 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 248 insertions(+), 6 deletions(-)
 create mode 100644 include/net/netcat.h
 create mode 100644 net/netcat.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 978f44eda42..abcd003f7f1 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2007,6 +2007,13 @@ config CMD_WGET
 	  wget is a simple command to download kernel, or other files,
 	  from a http server over TCP.
 
+config CMD_NETCAT
+	bool "netcat"
+	select PROT_TCP
+	help
+	  netcat is a simple command to load/store kernel, or other files,
+	  using netcat like manner over TCP.
+
 config CMD_MII
 	bool "mii"
 	imply CMD_MDIO
diff --git a/cmd/net.c b/cmd/net.c
index 53ce2bc5d0c..364139ec5b9 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -206,6 +206,28 @@ U_BOOT_CMD(
 );
 #endif
 
+#if defined(CONFIG_CMD_NETCAT)
+static int do_netcat(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	if (argc < 2)
+		return 1;
+
+	if (!strcmp(argv[1], "load"))
+		return netboot_common(NETCAT_LOAD, cmdtp, argc - 1, argv + 1);
+	else if (!strcmp(argv[1], "save"))
+		return netboot_common(NETCAT_SAVE, cmdtp, argc - 1, argv + 1);
+	else
+		return 1;
+}
+
+U_BOOT_CMD(
+	netcat,   5,      1,      do_netcat,
+	"load/store data via tcp netcat utility",
+	"load [loadAddress] [[hostIPaddr:]port]\n"
+	"save Address Size [[hostIPaddr:]port]\n"
+);
+#endif
+
 static void netboot_update_env(void)
 {
 	char tmp[46];
@@ -323,16 +345,17 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 
 	switch (argc) {
 	case 1:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
 			return 1;
-
 		/* refresh bootfile name from env */
 		copy_filename(net_boot_file_name, env_get("bootfile"),
 			      sizeof(net_boot_file_name));
 		break;
 
 	case 2:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
 			return 1;
 		/*
 		 * Only one arg - accept two forms:
@@ -354,7 +377,8 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		break;
 
 	case 3:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE)) {
 			if (parse_addr_size(argv))
 				return 1;
 		} else {
@@ -365,7 +389,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		}
 		break;
 
-#ifdef CONFIG_CMD_TFTPPUT
+#if defined(CONFIG_CMD_TFTPPUT) || defined(CONFIG_CMD_NETCAT)
 	case 4:
 		if (parse_addr_size(argv))
 			return 1;
diff --git a/include/net.h b/include/net.h
index b0ce13e0a9d..0af6493788a 100644
--- a/include/net.h
+++ b/include/net.h
@@ -515,7 +515,7 @@ extern int		net_restart_wrap;	/* Tried all network devices */
 enum proto_t {
 	BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
 	NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
-	WOL, UDP, NCSI, WGET, RS
+	WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_SAVE, RS
 };
 
 extern char	net_boot_file_name[1024];/* Boot File name */
diff --git a/include/net/netcat.h b/include/net/netcat.h
new file mode 100644
index 00000000000..d8e09aaaa55
--- /dev/null
+++ b/include/net/netcat.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: BSD-2-Clause
+ *
+ * netcat include file
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+#ifndef __NET_NETCAT_TCP_H__
+#define __NET_NETCAT_TCP_H__
+
+/**
+ * netcat_load_start() - begin netcat in loading mode
+ */
+void netcat_load_start(void);
+
+/**
+ * netcat_save_start() - begin netcat in data saving mode
+ */
+void netcat_save_start(void);
+
+#endif /* __NET_NETCAT_TCP_H__ */
diff --git a/net/Makefile b/net/Makefile
index 64ab7ec740a..dac7b4859fb 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_CMD_WOL)  += wol.o
 obj-$(CONFIG_PROT_UDP) += udp.o
 obj-$(CONFIG_PROT_TCP) += tcp.o
 obj-$(CONFIG_CMD_WGET) += wget.o
+obj-$(CONFIG_CMD_NETCAT) += netcat.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
diff --git a/net/net.c b/net/net.c
index 86182cc504e..d81604a57ce 100644
--- a/net/net.c
+++ b/net/net.c
@@ -108,6 +108,7 @@
 #include <test/test.h>
 #include <net/tcp.h>
 #include <net/wget.h>
+#include <net/netcat.h>
 #include "arp.h"
 #include "bootp.h"
 #include "cdp.h"
@@ -564,6 +565,14 @@ restart:
 			wget_start();
 			break;
 #endif
+#if defined(CONFIG_CMD_NETCAT)
+		case NETCAT_LOAD:
+			netcat_load_start();
+			break;
+		case NETCAT_SAVE:
+			netcat_save_start();
+			break;
+#endif
 #if defined(CONFIG_CMD_CDP)
 		case CDP:
 			cdp_start();
diff --git a/net/netcat.c b/net/netcat.c
new file mode 100644
index 00000000000..633afe5c60b
--- /dev/null
+++ b/net/netcat.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * netcat support driver
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <command.h>
+#include <display_options.h>
+#include <env.h>
+#include <image.h>
+#include <mapmem.h>
+#include <net.h>
+#include <net/tcp.h>
+#include <net/netcat.h>
+
+#define HASHES_PER_LINE		65
+
+static struct in_addr		server_ip;
+static u16			server_port;
+static u16			local_port;
+static int			listen;
+static int			reading;
+static unsigned int		packets;
+static enum net_loop_state	netcat_loop_state;
+
+static void show_block_marker(void)
+{
+	if ((packets % 10) == 0)
+		putc('#');
+	else if (((packets + 1) % (10 * HASHES_PER_LINE)) == 0)
+		puts("\n");
+}
+
+static void tcp_stream_on_closed(struct tcp_stream *tcp)
+{
+	if (tcp->status != TCP_ERR_OK)
+		netcat_loop_state = NETLOOP_FAIL;
+
+	/*
+	 * The status line will be shown after the download/upload
+	 * progress (see show_block_marker() function). This progress
+	 * generally have no final "\n", so jump to new line before
+	 * output the status
+	 */
+	if (netcat_loop_state != NETLOOP_SUCCESS)
+		printf("\nnetcat: Transfer Fail, TCP status - %d\n", tcp->status);
+	else
+		printf("\nPackets %s %d, Transfer Successful\n",
+		       reading ? "received" : "transmitted", packets);
+	net_set_state(netcat_loop_state);
+}
+
+static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
+{
+	net_boot_file_size = rx_bytes;
+	show_block_marker();
+}
+
+static void tcp_stream_on_snd_una_update(struct tcp_stream *tcp, u32 tx_bytes)
+{
+	show_block_marker();
+	if (tx_bytes == image_save_size)
+		tcp_stream_close(tcp);
+}
+
+static void tcp_stream_on_established(struct tcp_stream *tcp)
+{
+	netcat_loop_state = NETLOOP_SUCCESS;
+}
+
+static u32 tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, u32 len)
+{
+	void *ptr;
+
+	packets++;
+	ptr = map_sysmem(image_load_addr + rx_offs, len);
+	memcpy(ptr, buf, len);
+	unmap_sysmem(ptr);
+	return len;
+}
+
+static u32 tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, u32 maxlen)
+{
+	void *ptr;
+
+	if (tx_offs + maxlen > image_save_size)
+		maxlen = image_save_size - tx_offs;
+	if (maxlen == 0)
+		return 0;
+
+	packets++;
+	ptr = map_sysmem(image_save_addr + tx_offs, maxlen);
+	memcpy(buf, ptr, maxlen);
+	unmap_sysmem(ptr);
+	return maxlen;
+}
+
+/*
+ * This function will be called on new connections (incoming or outgoing)
+ * It MUST:
+ *   -- setup required tcp_stream callbacks (if connection will be accepted)
+ *   -- return a connection verdict:
+ *        0: discard connection
+ *        1: accept connection
+ */
+static int tcp_stream_on_create(struct tcp_stream *tcp)
+{
+	if (listen) {
+		/*
+		 * We are listening for incoming connections.
+		 * Accept connections to netcat listen port only.
+		 */
+		if (tcp->lport != local_port)
+			return 0;
+	} else {
+		/*
+		 * We are connecting to remote host.
+		 * Check remote IP:port to make sure that this is our connection
+		 */
+		if ((tcp->rhost.s_addr != server_ip.s_addr) ||
+		    (tcp->rport != server_port))
+			return 0;
+	}
+
+	netcat_loop_state = NETLOOP_FAIL;
+	net_boot_file_size = 0;
+	packets = 0;
+
+	tcp->on_closed = tcp_stream_on_closed;
+	tcp->on_established = tcp_stream_on_established;
+	if (reading) {
+		tcp->on_rcv_nxt_update = tcp_stream_on_rcv_nxt_update;
+		tcp->rx = tcp_stream_rx;
+	} else {
+		tcp->on_snd_una_update = tcp_stream_on_snd_una_update;
+		tcp->tx = tcp_stream_tx;
+	}
+	return 1;
+}
+
+static void netcat_start(void)
+{
+	struct tcp_stream *tcp;
+
+	memset(net_server_ethaddr, 0, 6);
+	tcp_stream_set_on_create_handler(tcp_stream_on_create);
+
+	if (strchr(net_boot_file_name, ':') == NULL) {
+		listen = 1;
+		printf("Listening on port %s...\n", net_boot_file_name);
+
+		local_port = dectoul(net_boot_file_name, NULL);
+	} else {
+		listen = 0;
+		printf("Connecting to %s...\n", net_boot_file_name);
+
+		server_ip = string_to_ip(net_boot_file_name);
+		server_port = dectoul(strchr(net_boot_file_name, ':') + 1, NULL);
+
+		tcp = tcp_stream_connect(server_ip, server_port);
+		if (tcp == NULL) {
+			printf("No free tcp streams\n");
+			net_set_state(NETLOOP_FAIL);
+			return;
+		}
+		tcp_stream_put(tcp);
+	}
+}
+
+void netcat_load_start(void)
+{
+	reading = 1;
+	return netcat_start();
+}
+
+void netcat_save_start(void)
+{
+	reading = 0;
+	return netcat_start();
+}
-- 
2.45.2

