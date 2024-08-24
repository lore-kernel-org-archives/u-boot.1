Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58302C52D6F
	for <u-boot@archiver.kernel.org>; Sat, 24 Aug 2024 09:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91566889B4;
	Sat, 24 Aug 2024 11:27:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="DTSky91M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D51FA88B69; Sat, 24 Aug 2024 11:27:29 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::722])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B36DD888D5
 for <u-boot@lists.denx.de>; Sat, 24 Aug 2024 11:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXunXSh1hg5tYiiESBf2Ce8s8EIFGtdNckqkFVOqxAz3+c1oEbe/z7r2tiX0Zi5hMGtXaoyy9VBV2mWDhv1S1YsBjx9L8AHnSztd2KFUf2LDFauCh9JZL5fN8GPfXDmQlgA4hbo/e2UCD0nJNh9eyAuJOxiZKEqF/RTx7HCS8kRrnlZ40437WjH9wELSpyDAJcc17j+fFKgxlFome87ICBoSd7KjC0tTd4TyI43iJU+4f1WNZuX78oiaSxcnezyZwbUEt2deMOJcNfqzYz6BSWofoA6af0g9Uz5xh13GwjxQ5WH/M3pQ6gw0I9TbVDB+GjEbOqgTZOfYIVqxaqdoKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FelVlydWtPJ3JINeTrFYPpe5HwTV9/ZwlUM7L4c/dw=;
 b=H4fxmPG5g2NEsar/GEkK2AecSvJ+dR4ocBTgW+ApGcONI2J9C96v9BRFPxHTDfRUDS71/cu/dSdKzl16tJn9yQavqNBKGYsKM2HAVXhQm02fkbJqYUIX15XdikDtzS5EgY6VE4RyOgfCyylqkOCvgZQigvbpuggc3Arcuv2oz4mdDZsJzyt0mrKSs1aP13y/2hE7SC4w+WZItOeouEKSaDrG26N0h3vUwOWUpOm5fDwcBMqrjIHjiBdi4T3IQ/fGyrEBE5CSkCJbhZQkJ6/YJgUYfecfmfXDm4Yk3caN4YRYo4EybhMsmhQ/7c4oqWJGiD0JYUlXmZdzNpWb5xofTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FelVlydWtPJ3JINeTrFYPpe5HwTV9/ZwlUM7L4c/dw=;
 b=DTSky91MkByXFx/tkcgaVI2NZDrH8sEisOs46CVAhW3sQGWjg67xB3xF1+g3GTe3NeV6zm3sYl4Ax2l52ywKqq+HgzaqOQPyEDAE+jQdSkGydOv9ZrFx37DRm3FQIuXoRMw6eEAwQg+W9pKeXQnLCMiQdXVWChYjnf9paIxyaQ/e91MrjZ6iX2VWJvOhcr4L1TN9uEcw6jtM357jjKTjkH5/hmlAaKoZfscHkent49+QZRo4AnvaorXNpyEth2tu4X/KESxl7lhoSmG+wk//NxkzL4MdTXn/J/njRvp1uA/21evL0HdccFrKc4qepE4WbDnjp1SPxc4aha+kvqiwaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS4PR08MB7601.eurprd08.prod.outlook.com (2603:10a6:20b:4ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Sat, 24 Aug
 2024 09:27:25 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7918.011; Sat, 24 Aug 2024
 09:27:25 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v5 00/11] net: tcp: improve tcp support
Date: Sat, 24 Aug 2024 12:27:05 +0300
Message-ID: <20240824092716.1042696-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0011.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::7)
 To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS4PR08MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc3975f-8409-43cd-3ccb-08dcc41ef6ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j+69ROWFMdXxqhVlr6i4RFfabiHZlruXfkn87WhE7yBy0Hctzj03igCUMu7Q?=
 =?us-ascii?Q?7wZLZtzj6qnGZjalL0vljLICNn24OHDxOpNkC8r8v9QfRidrjD8Xsh8ooBTi?=
 =?us-ascii?Q?NIsyvS+DNR1i80GqfK3bkQDfVeTmjwuBB3GF+aWy4+oP3X0DjG9vyWx0xNSy?=
 =?us-ascii?Q?ruJAgreFRE9GKeAms5FZOccyJHtBxQ/4jJnZxbFmp/675EtGBTQv+B6sJW/H?=
 =?us-ascii?Q?dipxL7erGmqX/P0qAqt5umu4m6uuTW7TfTxBPkD8L4ff9RUUsFlYuAd1/6KK?=
 =?us-ascii?Q?kMyyWkKb2060lKdPZZ5c6hP3y66WrVipMMy4V88DeflnqHY4YD76jsE7yE/U?=
 =?us-ascii?Q?c+Ca+piFzuehmz45yMmD8ND/z+rE/YSFvFGBRl8SWZVHTVQu57a1VhnbN6Ln?=
 =?us-ascii?Q?Mt3Nyxi/OLsUb+EIic3QyyrbkhrA2AN9pwQYjCWf0RNFIyspDwNvwy6TL+bb?=
 =?us-ascii?Q?Ksh2LTihrSrpJMEqiq+LS21C9XfxG9+kIOAX4CE3FN8tJdc3SHAVmCdzZKM5?=
 =?us-ascii?Q?/b4ZK6N3KwHqS/4qw7Drqj5bkm1PVcSsiVtKGZ60f3Vnr2OxcYd28ypfFSkH?=
 =?us-ascii?Q?stkgmPsqJ5YTcxpvFInwORa92eeAuCJsSFDAcegLB5vVTnJE5C6nypPOKWGs?=
 =?us-ascii?Q?zAb+fIoYA1uuyFDSYSPm2xxtqEr4LW1Oj8PQQWeG4lxVfgSuMiwms+zfxzGk?=
 =?us-ascii?Q?JVstQWvoHvFgDs7lhS5J/OHFuehietvhhMkL9d7BDNKrBcmUMzm48ExeAN8F?=
 =?us-ascii?Q?Di0WiBPN14Jv6WgYnFzAdoVr8pWP9cQ6bgQXI8nJbD035XE3iMBdOT4G/MLR?=
 =?us-ascii?Q?Bqggw08AkvInhprBNcjJu4tUqOSstujygU5mr0eeIsgHKi8nYhPcXYnBmsha?=
 =?us-ascii?Q?iErDL50lZzioqw9dBMgrj8IGfBEs8tquEs2MBXe7hJz6guyS6EXD29blntC6?=
 =?us-ascii?Q?gdZlh4CkHrp+T5MpmXBKb8WQvFmiizInWurapbPyvsqJ5Zn7mp+St2NygQLC?=
 =?us-ascii?Q?MhZsb7RWiQHUa3p024MeDHNKJG7ueKk5exfllOsaLGiXMXCsJQRwlaWQYF0s?=
 =?us-ascii?Q?j73tazY+ri2fuGrPTzfPqFBXXPHzk7IBh5PWlMVW4LU3wMC9SGvPLmg9SOkL?=
 =?us-ascii?Q?3y3bsaPAKX3G1sTEk87g5Hb0KuPHmrypYc3iekFGVvQg/9wMvhkX9twBCvUP?=
 =?us-ascii?Q?HE4r6U0gaj32MSKkiJRNLb56VR2MrsYrvANA6Wz8kjCflktFaICp5C1giq1C?=
 =?us-ascii?Q?L2QXXa0zNUuZ+fn/03mMCh5Zd0CGNyR88f7/9aqSdOHnd/zkU+0QOnRNyrbL?=
 =?us-ascii?Q?uwlUgvKRUAGRV61yeDboObGBayCxpQU9kNyiOn+z7/O6XkccEuhd202ST6bZ?=
 =?us-ascii?Q?2PBJKnxUsYCCKslF64gDvzIGz0hQixHKQ8ZmWhg+A5rdGDMin+pZ5BHac6MF?=
 =?us-ascii?Q?hCvaVsU8sTY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4tT6p8j5ujqN2KLmhXwEKKm2PsYANpV+12qOFYMKeCpT2AZaiXBnReSr6Kdq?=
 =?us-ascii?Q?EcNX07DUnYWHt0u7V+AWiL27bzF5KIrg82CFRqACRk1a0MgKZ9eITft4Km9b?=
 =?us-ascii?Q?F2o1nrug9Vqx7fIwI6IkL5oXKAVNfGRlhl6JlqhF1Jo5EAN3LpFzspDVpmdk?=
 =?us-ascii?Q?wjXC3js1BpBY9OCq4jqHuO/fxDkzkPqch3Oi1dL7O7bU5m/6gnq1E8meOOq5?=
 =?us-ascii?Q?c9+D8gvZPTpAMNDivbiyF5uMGwasY/x2Q7Xz9sM+ExtwyIS72NUiwrmXkxY8?=
 =?us-ascii?Q?tzfmpNkmJnvYfeJde8YwhyarXW9qjxepS1dM2KYgtEJ8ZY5GTKF3aBL/yfdz?=
 =?us-ascii?Q?vo0d4scGS5JCnPyMrvRYyKnBXSULzpFBUsSz25Pk+RD/qFfJLPixn8/bKWm1?=
 =?us-ascii?Q?J4WcrM6Sfypiqc7wrasA6x8ZQSyClPcgOUZ6fGDXkxTUOelQqaBOmUaneLiz?=
 =?us-ascii?Q?m8Ux5kfhkmYjbX6kLH9ehhxfNEo5fAT65USL7jiAvrCIC8esqvNjw41bN6QI?=
 =?us-ascii?Q?SIYXWUhSmtlpVBkKru4GWong+wi0nqJHyzFvK3oizLZtOIvuyoslhYM8j8Zm?=
 =?us-ascii?Q?t6T7J7x3lToU+KnE1PxBSqa9reKrdHrt3gneNYjTcsELdGtvs4Li90Z+RkOe?=
 =?us-ascii?Q?qtMRj1AiB1niDeZ4C19mC43DVdqLRqo862iadYqDNgfG+LikOXdV2IsSAXBr?=
 =?us-ascii?Q?4BRmgZfz1508hoAmqeTeuSM1U0Kw+w2As2DQBMXDGF8ICB3AhGJdzl2lyoZe?=
 =?us-ascii?Q?KPOOU0bDyGO7II5YnVDuMuuQP9agi8CgvnO/pHiY6g7+UkLGSGWavNLvv4CA?=
 =?us-ascii?Q?tKWptwQYdmHCxQWO2b0akQ9whZ+SrRgzslpj8HKAlDsKXL61sv8J0OHDCFVj?=
 =?us-ascii?Q?d/HTSl9bnp4YOK3UVbnEHe2vX9M2BAstfVTE0SoXEkpjLNnYNw0Gb51Crfzd?=
 =?us-ascii?Q?DAz07RsAyw/RbMeVpIWY4tccxPYpZHXh85pJfY57G1oQflBHAD/NDvRjXKf6?=
 =?us-ascii?Q?89uqTuTJ5Hkb3gkEOC7W6n8DuoSr9MBhRlsT9apzwSxiDQv29CF53C3x49G5?=
 =?us-ascii?Q?/aF+F5t92wVq2K33FIHGODvF0Ie2MVnf08KC3GPxVhroTlp86TZ9LlY9Zukg?=
 =?us-ascii?Q?08CAtO6Cvjp/gIYjYQwabIH7dH6bQ9eJvq+zdVvzLo5s6cI0dnwDvV4Bveaa?=
 =?us-ascii?Q?VRA4dR4hGIx+NDzAgdL75RwfECVRSEx6pOW3iJ1l09K5R+ULkhqc3vgZiG1l?=
 =?us-ascii?Q?uymyXIiUDGLfJEha7xHYpMjE2j+fAAZSW1klr6HU5qliafV9h919oBw6M9wW?=
 =?us-ascii?Q?RooLwg9nz7Ib/fyFdHEzasDwVaDhpEWfbKUDY0cjuk7gDc5nqwfqXEtLgOYe?=
 =?us-ascii?Q?9ts9qjYfTfRA1XvHSM+p0tLPiY9AAohpzNBU7kAFg825rGItwBPlQSDUfQwn?=
 =?us-ascii?Q?/SS86/yA2oQ3lLrh0igwbF4y2Cx8w9nX0/cU1M7j1Yu0AyOidpV6XCLgcYLF?=
 =?us-ascii?Q?IEUzUsiW13IeaAC7YacWKZuA2Kj5GvNz30iNy0CJi12mJ9TelzvW+4gb2one?=
 =?us-ascii?Q?Cjdkr2tLoioTn/t4Vj/Yqqlom9j97Oaap+XOQZfWKWtDR8IZ9jUocmQt6RWs?=
 =?us-ascii?Q?HzcK1swuSQ/chFKT6WiqSyg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc3975f-8409-43cd-3ccb-08dcc41ef6ce
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 09:27:25.0961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJtzjYUTb8MgxS5SHXF3bwQ9dbR/xb5hIg7O8sdWIT5IFWlheRuOcWFoRzPOo24DDfIzxSwVJSoFosw/ZR5Cw+Z5l0BvdJ+ufVmvkmFrXXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7601
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


Mikhail Kshevetskiy (11):
  net/tcp: fix TCP options processing
  net/tcp: fix selective acknowledge
  net/tcp: put connection specific data into a tcp_stream structure
  net/tcp: add connection info to tcp_stream structure
  net/tcp: rename ack_edge and seq_init to more common rcv_nxt and irs
  net/tcp: improve tcp framework, use better state machine
  net/tcp: simplify tcp header filling code
  net/tcp: define a fallback value for rcv_wnd size
  net/netcat: add netcat over tcp support
  net/httpd: add httpd common code
  net/httpd-upload: an example web-server implementation for file
    uploading

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
 21 files changed, 2582 insertions(+), 874 deletions(-)
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
2.43.0

