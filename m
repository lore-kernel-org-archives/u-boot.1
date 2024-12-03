Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0009E77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A6BE89667;
	Wed,  4 Dec 2024 00:01:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="JTKMdAWJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1719989677; Wed,  4 Dec 2024 00:01:05 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20725.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::725])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92B9589534
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:01:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAlhJ3sLdyMVdCFdT0fsbFe5vRjxEUwB+pR9b/+391DEZJMJ9ZoLQyE8z+7TSSSpMpq88PWFsyOhv+H0ImnvXpmoadZMlE9xt+brFfpZ/NE7cgmuP2uNGCab9NPNrA/iK0YaQDBZ7OrrsX+diSdslUHaFUfOI3KCgpKx2o9j5QJiLToIGcVZQiJ2/Sjp2YOUiSpARtw8fn86XHDWjYvMZOIsNJSE9OUYMFaSoMmlxeGz12Gn5ERTSxJNhDMO97MGnSZMfAtFIIBe4M1hKFdwKgQ4wnHuSjNmGRdPeY63WPnvY/pskmBl7wl1zOl5ryxAdqFzP4MVigrKWWJnE4LwVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSUxk0YuqDprSP+YAsWFk62DVgjqOuxjostObQZhAJI=;
 b=Y0qRiuTAwYtBcA7sfTpTlg8T4vlCIbBt/mPrfDy6fES9NMSMfIk48raakpkxxOK4Y7EX09YRxrT4kk+KRpgJF8NEn56veOB2KCcqWWZ7UsmOfwpo8eo0pqUgL2P129XphRYUUwKFICBRHzXqRvlHmbFwS9CotokszQRPa1QvhcLGvemgXaFqeQuaPa3whFzYs7pCo5uKmt/cAHyq48/o7l9NjVA7l91LtBV+7MwQdkkNEhuKeyz4bR5lb80sHQj/Ybp7VxtKO+zesjBdp6+NBm1RjQsqgHA6qxsjlZ+bz1j4uU5R2hYAWpy61ITyGecMc3WUkuJVaSvwJ0hiTwWRgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSUxk0YuqDprSP+YAsWFk62DVgjqOuxjostObQZhAJI=;
 b=JTKMdAWJ7bMpwJ7u5Ki+crZU+26KmjzGWWo7i33+yIIrTkNjq9fY6Gfml0G2I3TXgyXwBXU/wl08FloA3Lo5kHcF8TUliQLKWVy0H4vl5xY4AAd7J685XKc/71gfznW48oH3n0ni0IprYDsXf7gpcBbAtyVr9GPB4zvwOOc6Epmo5+hC9Tjhz0hemOhdtLigkH+264GvRv9IBG6AxwCLpYwL3Jeq3B0rnW/zlqYyb6FXmufSobvECzWIhQdikyWXiT7M+mzRyxBqzXr29gBvDw0plX99WqJEx96n/+9FOV9sgd9aQXeXrvoAPowSrlqAQudA7DeAbWHO9ENW4D0yTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7611.eurprd08.prod.outlook.com (2603:10a6:20b:476::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 23:00:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 23:00:57 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v14 00/10] net: tcp: improve tcp support in legacy stack
Date: Wed,  4 Dec 2024 02:00:39 +0300
Message-ID: <20241203230049.2677155-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0040.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e2f691-ebf1-4b05-2750-08dd13ee5921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mv6nvhaj8XvjLXSXHQTluqTuHw04v5ojEdXao1wNt4BlYTGNLByBQfDTY3TD?=
 =?us-ascii?Q?w76y77+wtE5u7XdO0VPUtyiv//EEr/gvS+hoA4UBne77tHrqEtchDz5pC/nT?=
 =?us-ascii?Q?uEnYpLNB4L28i63bts9kUvYJavNcf1Qm7CKVCr1nlRFwdS1exaAYhEojaw0K?=
 =?us-ascii?Q?i4pcTas2I81gCp8XBhlLgDrJyoGSoY+GBm7qoykzCS7Hg48zw2c7jv0le8zF?=
 =?us-ascii?Q?pgUmhDRhk2uZvNecC58zn10CeVOxf/o3xG8GpRDGO7ybr2wXhGR70Sy0OSK+?=
 =?us-ascii?Q?mBBIXq3LUSZ/rcFiLtnp+FglAi1X2dt9geI+//NvfkBOHAy5T/p6Arg7vz9L?=
 =?us-ascii?Q?iS+E5OeQLlQxdVaXg7xfU/ZTug2XTTeqjlub3LwAYnftHo9BmCG6ge9ZbulJ?=
 =?us-ascii?Q?H80G5TZ2/vwj21iSB57UrE0aicCjyKiRcKP2FrF3dJNLOwBOOHo5TWIbsFHG?=
 =?us-ascii?Q?V9S5gOQDETfPdYGbla05jURry9HjDjioxa+nhij+zarGcsUoazUb+D82ieXz?=
 =?us-ascii?Q?ian6IOWCChjZFre5jY7LklFnLRlCCIElcMVdoSZZLZ2IrniOmrvDqgItXYj/?=
 =?us-ascii?Q?mZ6yqDSpk/o8i+ITHzv7bwNVaGv0vBOKhh66SPL3DUir1TDJhsh0rELMowdm?=
 =?us-ascii?Q?dP+n05AwYM07wNzB4qDTI+g87lEIEwA+OvBbodG+xD6rWO5hUxp8OxTBJ2ue?=
 =?us-ascii?Q?gbnuzGY4G3Xhv/et+ou7wZzG5W/5Ho+xFTqM6JS5pC1a5nbaYv+dxKdmqm7J?=
 =?us-ascii?Q?LKzRwzBxDMxtWfurMjXSLKS94Krxw+7781jcTPWj9fv4bVy5Nz4uqTwJoMHN?=
 =?us-ascii?Q?7vE828oAg09w8RdetePQmoJTj9dzSDr29Mth+0bRcju0pQJUzng/e+ekVmDH?=
 =?us-ascii?Q?NGph63Pmh9RlII7FkfsMjD250YzdGTcmluqjr+nl1UZC0hQu0gclpXk2SiMB?=
 =?us-ascii?Q?aiAV3kRioILNnbngDMpoSHS7nNqVSiuI8cEiiYjEYr/DslUqjsIu3+CHIeXS?=
 =?us-ascii?Q?qm1eF74/KpWhkjdLiVfXB5XqvbrZVyED/1FGKMq+qFtm5sz7z+kwhTMalEb+?=
 =?us-ascii?Q?jzzX+am5p5IWAZ1rp1mNwUiZr/HbEEjZ+8jxbWyQ5fZUZVK/F0R5f5MmFIAf?=
 =?us-ascii?Q?F9Pv99ViLZGi0ufaB0ilLl/29QTW9k56LJC1CmisxUKMI1UxHn7/3iijtKKw?=
 =?us-ascii?Q?RDfoKx2yVZlqj2ty22gAKINu9epS6M+ZtyP726hjgj64lLQsw1mKTRE0+sJj?=
 =?us-ascii?Q?/xRX83lcYxsP686TWJrGUUlnWyzHYAzvNE1aLf6gWI0Squ+U0omI71eGqZin?=
 =?us-ascii?Q?cZh5YQH+7jLH+ax8ywnx/gyWrzrPDcH/GGggSNuDtfjfTBuDX8pKcnonZZO2?=
 =?us-ascii?Q?yBut++XeXhnzafEzjMAYXWL+TltpjuyBYgEdNwwROhotskF1Nnjl2gdHhg1Z?=
 =?us-ascii?Q?H3ymObvZOhw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BKTqA84g1nmkR/yj8R9XlZ5QzUDpWo1UDJtYuSwnYPSa9RYJnJI9PTLyz2Ut?=
 =?us-ascii?Q?ZzltQIA4hcoz8UmjjByBqxv3/H52UseXwoyK7j/dUAGU+25nyvOfwVkHwELI?=
 =?us-ascii?Q?icqc55AuL+4xZ88Zj2t1P/NMGFWDDyLfMwCPwNStaDf8aNjZgzgDSLE3JTfd?=
 =?us-ascii?Q?ckyq2sh96atXFTczdp1hxtqz0smmT+RMHRmkB6ddZbRspdwpb51bRQ20D+ge?=
 =?us-ascii?Q?0XG6aEXTQdDadGSxNqhfIKn4Oq4Y+/IygYSrVOnQ53GaiQKSXd0K6Nh/SI1D?=
 =?us-ascii?Q?SHIR6IgBplAARc6mKqlqsrEkcXLvS2+zBvvoRiDq69GrILc4saOVsdfNTMEg?=
 =?us-ascii?Q?Vk8broS2QVEBen3ciSZ5kxoKhBf3pUSlIH0sPmHx9DMC6TU58xdwf2AHk/21?=
 =?us-ascii?Q?m3sIaP86Qaxwc7+KVGAJW1Sb6ABNJnoZEt4lv/3lDRcFOkaWZ45q3AtTxqm2?=
 =?us-ascii?Q?BtGZdOq5RBhc/5d/VhtG/ldjNUL077JHhUWhsrN38jPuBDg8lLv2xdDwNGGD?=
 =?us-ascii?Q?ii4kMbpvd9ShG3t4g88fo6prgXzKRPupaP7P4GkPwf9KiZI+Ufy9Sx91t39T?=
 =?us-ascii?Q?CCS8hqFcYQr3QOrx1+vOmBNXNMwesZOCxAXFiFcFjHIPx6IQRHQFjxPTmb1m?=
 =?us-ascii?Q?Um2egglT2Gvdde75vXouZk39srkpMiUNKM132bL2doeDgWahJ63e9bwj3Nqg?=
 =?us-ascii?Q?RL+inj727vhBVcmZ7HSoBz7mYjpz6Z5YUGFC0QJ93aFzq/xcjMLN28d9//5I?=
 =?us-ascii?Q?xvLiWs0P0Zs6prYODGfTUHXhhRa6GDh8mkWPRAfSdv08XpbCm5Pybhk/m+Uh?=
 =?us-ascii?Q?h8obKj4Pf7QWRraOw2s/bZzfRP0oF1ZJOnizCewh1PWOXG6UV+zy843YKT/+?=
 =?us-ascii?Q?REfUgMS2C9Uv7t18asPRBsSwBBtJxCyrkSTD/K9N6gyCtmkEFXiBlBr5Y4o5?=
 =?us-ascii?Q?trSBsw3QYUEUgWjAMJN633frdXRy/EAOeQv8BCVFRatLXnIAhQ1mpqpLjzTt?=
 =?us-ascii?Q?dAJEXYC0yKn3UGoI+BVQB/RCK/uPziI35H/nbCbn5N8AlyHaJyyP/N4aABE0?=
 =?us-ascii?Q?VVwVTzgqRBGGiWnP8S/eBUwXS+q8wf/qvaULr45OJlY4lrVA0q5QN4+LuKkv?=
 =?us-ascii?Q?JtaK3uhX4vPEnzIcPqnVX1fPR9qkA0+W/2qt0WF2vbL0syLKIUpmN17Bc38r?=
 =?us-ascii?Q?KiUZYQ8uFR2jJLVBcPZ6K2ElND5sWTxvMs1U3chI5lr9iV1GTQJZZomu31St?=
 =?us-ascii?Q?FRpMaKdDLO3tFPmmi9CXNqrum2TgN2iMS5+k45nzvrJz9FHiWeP3v4eQT/VA?=
 =?us-ascii?Q?FkeUtdabtlhN6zPe39+ktVzOJu1DfT9CJ+JCrSfMOQkIJluVCePX3+3q1DfY?=
 =?us-ascii?Q?QzlKObbXT6ENqmtFbMjPuskYMcrEU9jbXoE1/2dydhsNdbKSV+W3sZu8R54D?=
 =?us-ascii?Q?NT7lyto0xL77d9oGG5VkOAOiHKLeGlTL4kydT09yBnyV0T4iYu+08pFjT30t?=
 =?us-ascii?Q?bKzpUZLMk2dT8+BTY50pBB4dSux0bk7yx9Gy9XIWCs9EeV8Z6IFzOq8lPVus?=
 =?us-ascii?Q?4B77WEh7+1vk+MyHWtt/eQ1Ukazx4wK8l1FWm29W3ehS+jdWeRIkdsJhV7ju?=
 =?us-ascii?Q?TKnkW30uFQfC9Jnye+aS1oU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e2f691-ebf1-4b05-2750-08dd13ee5921
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 23:00:57.8415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mA3ELaMXsNJp/AIgNuz1JjsrqY4oWbcQaFIeMMEv5mznVNH1VGMP2Yu8j1QEiPw7JzCmjhlapPsfaN/zRdaqH2ajA4rZd4ZwrhzODLg07tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7611
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

Legacy TCP stack is bad. Here are some of the known issues:
 * tcp packet from other connection can break a current one
 * tcp send sequence always starts from zero
 * bad tcp options processing
 * strange assumptions on packet size for selective acknowledge
 * tcp interface assumes one of the two scenarios:
     - data downloading from remote host to a board
     - request-response exchange with a small packets
   so it's not possible to upload large amount of data from the
   board to remote host.
 * wget test generate bad tcp stream, test should fail but it passes instead

This series of patches fixes all of the above issues.

The benefits:
 * A lot of bug was fixed
 * Better and more reliable TCP state machine
 * Tcp clients becomes smaller/simpler
 * Data uploading was fixed (now it's possible to transmit a huge amount of
   data from the board to remote host)

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
 * code style fixes

Changes v5:
 * old patches were occasionally sent with v4
 * add back web-server patches
 * fix bug in debug output
 * add more comments
 * code style fixes

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

Changes v11:
 * fix spelling in cover letter

Changes v12:
 * rebase on top of master branch (3df6145db0e)
 * slightly change tcp->rx() & tcp->tx() callback declarations, this
   allow us to terminate a connection if something goes wrong in rx/tx paths.
 * set net_boot_file_size variable in httpd_upload
 * set filesize env variable to a proper value netcat and httpd_upload

Changes v13:
 * rebase on top of master branch (8573ea41058)
 * remove netcat support
 * remove example httpd server implementation

Changes v14:
 * fix issues found by github CI

Mikhail Kshevetskiy (10):
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

 arch/sandbox/include/asm/eth.h |    4 +
 include/net-legacy.h           |    5 +-
 include/net/tcp.h              |  258 ++++++-
 include/net/wget.h             |    8 -
 net/fastboot_tcp.c             |  193 ++---
 net/net.c                      |   45 +-
 net/tcp.c                      | 1297 ++++++++++++++++++++++----------
 net/wget.c                     |  465 ++++--------
 test/cmd/wget.c                |   58 +-
 9 files changed, 1444 insertions(+), 889 deletions(-)

-- 
2.45.2

