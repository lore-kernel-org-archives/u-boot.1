Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD6AE7718F
	for <u-boot@archiver.kernel.org>; Sat, 28 Dec 2024 10:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6870E804BA;
	Sat, 28 Dec 2024 11:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="0Q4YxplU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09E4F80540; Sat, 28 Dec 2024 11:46:58 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::717])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8BFD804BA
 for <u-boot@lists.denx.de>; Sat, 28 Dec 2024 11:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uy4TDSOmaHn8auAO+j1+AGF6i4uHhhkeXVob0mk7/CZ/aiuu6+QjPaOG6kV1jTlymqBg/P1eRkBljcagKVnjnS0WokM9tK0R2aCXvKwUbe5kx5pqP4u+i8s5DF0nttwiJ7+GDHCiR4B4PHwOHyJlPBxcJAg7fRple/7aG0BAuc3NzXfkLdXK+RnoI/ip6wFOXo7SDgq1ODFlczQKWmL3Iw+gpiBPylY+/gre5b0zl8VDNGMkrEqXRL3ZQ/ihUw6Wqmn8pxFb69talvA/GYlwI5YdeXmhMNjpzStMgBqUoyEBzR1U3KOVFUD2mpJPOwcTIDB0SGmbKAQVdHWgAT0pUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhInCEjIoYZY029OymvkiFQ0SRvAeOel5lWEc3UftDI=;
 b=DJsmYDMe6vWp8P15Ss8EBG3SUuAL4uekCDbwGTz47ScWMtTg2L8PF2EUzLWk808ahTX7+eRV1Q3LyMIGZyzmDR509IYPgU1RVznfUAtZhCNEzrWJXIbkogtU0JcrS6h202qWsw04xUleQMJRey6MMCYb4P3alYvAkcanv1lPZNluOdQeIgsg5mxjk2fURW9CEGq0HIGUnz21cX7JsdvUpvYETYDfgS5tc+WhfPO2IwcRzvV3kEUb57jBh05QKNOy9hEmzgdnKy7r1y/IYooHjoWsGosyTWkcQeM9k3zb0e+UY0DCjsgHinb5iV6z8Gf5iGPg//mi58Wjii4IurWInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhInCEjIoYZY029OymvkiFQ0SRvAeOel5lWEc3UftDI=;
 b=0Q4YxplUgA7m9/6d6WOKc2wAoqGPDxPH7ArakMzTFIIcIVraf+UCSDkHTmDFXP3kBpCjhzGBEU2o5oc+pyovyfVJKOKTVZhZ8hV9ajmEFJpxKEUwz+EUv2ATG36V/ocE84yWk9JBvKgkuo2ZcvVWrClI6E0X4/Q9HnCKXRxw6Sp5QQ2GIyMt7k9Y1zSf/qYaHyUJHzjWDWn7ny5WJyAgLkSH9rw26kDQxetS/O0+28TxORFJ5ZfoaGEPNvlrIf1vm2X1ZHd/1RcOD7CasIiF8Tb8CW5jcb20RC0Zzck3bzA472UQDngu5OSB2ctb5RU95enmiPJsjsivMzCuVPqF7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8437.eurprd08.prod.outlook.com (2603:10a6:150:c3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 10:46:45 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 10:46:45 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v16 00/11] net: tcp: improve tcp support in legacy stack
Date: Sat, 28 Dec 2024 13:46:26 +0300
Message-ID: <20241228104637.4173913-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::316) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: cda33637-d2fe-4493-ee07-08dd272cec5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s6C91lLXh3lzdhYTE+QSwhdqzlhRnqjmhbf5GmbioYkVV78qytTMf1QBa0hJ?=
 =?us-ascii?Q?0B4QWB08+L8xrNVlBuaeNiuwbz8jaC8RmHCfGWEFBgYr37+Us7cgBpcXLvU4?=
 =?us-ascii?Q?m2EPdEZ7Nypj2nyT08VRN9NVsxOd4/vyGqNqmzAjNJUvBedsZkDuWTtSnvvY?=
 =?us-ascii?Q?kwvtJy7VWNSOtyEX/n56/fq+1SUXwD7ZFB/qCjGioOi0J9xUX3B+WjP68Jm2?=
 =?us-ascii?Q?Lmf2PP46TxjaMIj4TnityCN4Kv62jhS9JQS/uqttT5Xh3i3yIucNywCzm4Ng?=
 =?us-ascii?Q?RBsYLidK+N+hOv3fWJ/PSs2A25qtKq82WuCHxtgp32xMJnr1k9zgARrgCRjc?=
 =?us-ascii?Q?l9/AT7ARGsl7sPUje/uar/I6VsdY2BS41l2IeZPdLyqTnFUhfLf0fSI1h3mX?=
 =?us-ascii?Q?v5ijp2hlpBYa0I55F4qdThmZdDURFU2aHHLWjkRc7TfoITyEgj7spwUEBy0K?=
 =?us-ascii?Q?kTpTgAs2SSCoR6HBUdlDtA64Eaf8g3XnHgItsN/0VtZhSOt1lVtrAZc/+qPl?=
 =?us-ascii?Q?xp7qSuFxOXtpg0+xkKDDkeoreebzR5atlBpFeaQWdRfkP3/ZivmNscYAYbvn?=
 =?us-ascii?Q?zywkyr/tbNGHgx9Y0PITGAY2MxfGthEH80qlN6KZv569Lpl9bud8CZZ+5hJa?=
 =?us-ascii?Q?HpePQfSirdcAmqEYyLZiM1mlyJppdxuFnWW6meURwQCedU4NdSoq8gzP0zh4?=
 =?us-ascii?Q?+lWBNMpI3c8GiiYELNKkF7CZceSKhSsP0duOyU9Z0SsnZIOhLFNh3lf/uNT2?=
 =?us-ascii?Q?m/I/3wQ8BhnaFD88Vhat8nbx+KgEbem5vtSR44UdsWqx8uoQuJdj0Q1EnfhT?=
 =?us-ascii?Q?RPg7zbizU2QRiw4yKzW3YdYKvg+V7tgbV+HRpbF7IX/EGBm9yKY/2InHgOml?=
 =?us-ascii?Q?3oz5E7R6cvErxOzDur0rJK1yGTOpAhTdy6rzj3/MHi+ca/8p0N3vBD34VgOY?=
 =?us-ascii?Q?eXx/7HFoyiV0QRZre3EIAWwp8RTtsQiI3LNKfkzBDfaATLxxZQFFd9JZZuNp?=
 =?us-ascii?Q?3GVdXTxSkG9+tbYdDDMPmmjGbtQ2A9iaXfzPVdC5zG3q2SrxBPIO4wTSvHQF?=
 =?us-ascii?Q?wXdbEmbXGLlUo/456oXTTor/uerOxQWVz5ciezVw5662yMxiJ589Xdm29pq2?=
 =?us-ascii?Q?jQCJP33R1/Nq7eFlcLxzpc8xTUPlpga4y5CxPEKpOuogsvaziOpPEX5rI29M?=
 =?us-ascii?Q?kC6cy6uR4wCNVlcsXc0FVavrNqmAAFrjBkpIDXZIgzFx3LslEeHt3JT+orvV?=
 =?us-ascii?Q?ALQXrjPPUXjsH9i2OBkIlr3poqAzInBgMtm24MLUM2PNm4/y97/2Ek0xEo0w?=
 =?us-ascii?Q?44D5YamWZTpQZNfdkQjRKUr13YtWuBM3MsprNkTk2hWT16OEWWYxAaFpGi2u?=
 =?us-ascii?Q?VpHRlb9ojP8fDDSNC2NxKUPEQlVQtWhCXZImH7ZFzZtYyplG4A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fWrkHBUb+xcynny4ldN7Udx3/TjnrKUUqOpZHMXjLC5wJtMBopTprQjXipg9?=
 =?us-ascii?Q?3TV3jgRDOnwV+iQX5MWq8FJbL2TCNbYhFHhqtJ0+loK/FFPFC4AB2U8Nj3oQ?=
 =?us-ascii?Q?MKTKBAekoi0F800GQNNwqIG3a517bEEXn6Et2SmXyvHsXX28CwcASRMWrocb?=
 =?us-ascii?Q?koluT5pOh0RBCeLoB//EpVuxAdI/yDx+IBbgR+lh2q4thxkTXvZov1NATmrs?=
 =?us-ascii?Q?jBJgbV0g2dOpHQ2m5xqybKmv69C+xD8Kwi/wKFT2NpHt20d9xlOUUDi7ph20?=
 =?us-ascii?Q?kj7qTr90L/rRzSd4YXhtqUbjI4w875vaQbPyzwNMmy0CQx4RM5ztiasT15/N?=
 =?us-ascii?Q?Su72/scaKYaY/C/TDyIPvaki5zJKGZdUZrUB+Y7UdrT4q89j2qNJ0dzAH5l4?=
 =?us-ascii?Q?OiFxHF3xThcNXDQegoXNRLbAuxeBL/DffielstwIXPYklJJw0k5Z1FAzdn6p?=
 =?us-ascii?Q?cSmUWgSswZbQA5IUJ9iutU7mJrnSlfWpK99UEaYJ2zik4dHwaYmaoN8pO8f0?=
 =?us-ascii?Q?HeZczuxbSGcFN5LV5+HSDi/KcXqlonnZowwtBG18QrM1U0qBcYBIF7bLXFbk?=
 =?us-ascii?Q?AT3hKLKLqp/3Ot3qkOPsl1m3Leh/BoHJZNwgTkpAiGddmAr5si+oMUsWYoEA?=
 =?us-ascii?Q?QEU2TcWcBLmN5FfcgFXQW4fFdNWQ73tqAJBS5H6L7KSOzQej/7wC6Q1yswkq?=
 =?us-ascii?Q?ldZT/5F6ahzW2YdAd1y4SX6lOCeMZvpc/Jr7bFxpQJ3RUzuEG+JzPixjjr1C?=
 =?us-ascii?Q?+wxbVxedEs3JEmBlflWnUf/soBPJbrzOm+K1lkEW0rUCTG5tfhjUKRkn8gQM?=
 =?us-ascii?Q?jIN/cp5kvXKBgnVJDP/Mk/QzCh9z2qBz2sRuKV0clND+jGGiHdrpMkMwbSkk?=
 =?us-ascii?Q?pIoD5WpgQ2ALkOu5Yq6CYtpdx7cE2XQYABD0kjIWxbUH9e2X1+lPuYWMdqNj?=
 =?us-ascii?Q?hwbF4PML1GmOUM6CH84iDAalo+c1S3ue0uc2vnuyCw2W1BMBgClin3A+YLwl?=
 =?us-ascii?Q?wrghQVpY9aYqcY7bk1eYmtlyS+V4E+c+2U/ebQPDk699zRmCWALk04xpqI6D?=
 =?us-ascii?Q?N0uX09aHv4/xeFOgLhBda6rOZFQjAxG890hDaAD7mD4BX3hbvouA5Xf8u521?=
 =?us-ascii?Q?AaHLAgtDP+MLg0bwYdIrU0KnA9ONkSy4b9Y+HH+c57xx7M/j2PkC0/zqj8i3?=
 =?us-ascii?Q?jAlw0ZGTj2RQorkieo/yXuMu0NK1KyaNh+HCFVybjv29Yvr5R0vr8rot5pAz?=
 =?us-ascii?Q?ihZ1GNjFt3oCCKTheFPVzyCiCx6aCsIQ6g4RG15yJ42J92J/eOGHDkUcvsKM?=
 =?us-ascii?Q?lUFXiM8ctTK2rHvJBumxgTKoPtJuO2uG3u1qqFuHJ+sAhoLLUkKVYyGlVVXS?=
 =?us-ascii?Q?s4xl8SAdlWlOKYljoQROcKbJOCZUsq+zNigqihutcf/F09WqBpjQcFo8vh1+?=
 =?us-ascii?Q?otBJqS767iXrKvlhNe+LtCV87ctDhmu/R67inwnEXvQBnn6eC7+v3ev+mP/1?=
 =?us-ascii?Q?+kml1fF2fMwMLzH4MZ+2c4Qbt68/WqhMwJWtboi9wToEGceXhIXBAytx7ZGS?=
 =?us-ascii?Q?zIr3ZloYkbGOx8cCgFjIvRQChf57lKy7gNF2c2a2Rf5DpO8Dg4H6Jkf8l/mB?=
 =?us-ascii?Q?XDcfPEZBicPjVA/wB7y9/aU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: cda33637-d2fe-4493-ee07-08dd272cec5c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 10:46:45.5932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyH3jZOe1EdzcP1XzX/EkZ7Pa6YyNybsHBw2iBt/APdKQz4hAU/0JXwEEdyTsTIPWWfy/rCs5HOjxo2tDwdX9cNsOvo+8x+5YEFhrXhpg3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8437
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
 * netcat linux client using test netcat implementation (not included
   to this patch series)
 * Firefox/Chrome/Edge using test web-server implementation (not included
   to this patch series)

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

Changes v15:
 * Rebase on top of next branch (5947cd76acd)
 * Add support of HTTP HEAD request to wget command. Thus it should
   work the same way as original wget from the next branch.
   Seems this is needed for efi http booting.
 * Parse HTTP status line in wget the same way as implemented in
   original wget from the next branch. Seems this is needed for
   efi http booting.
 * Fix bogus server response with an actual response from the
   HTTP server in test/cmd/wget. This makes a test more correct
   and beautifull.
 * Some debug messages were improved
 * Minor patches clenup

Changes v16:
 * rebase on top of next branch (5cfbf8c3644)
 * improve error handling in wget

WARNING: The v16 patch series does NOT fix lib/efi_selftest/efi_selftest_http.c
issue. It looks like the efi_selftest_http test is wrong by itself. The
following issues were detected during efi_selftest_http test study:
 * The test should fail with HTTP status code 404 because:
     * nowday most web-servers requires the presence of "HOST:" request header
     * wget does not support sending "HOST:" request header
     * web-server of "http://example.com/" site does NOT provide "default server"
       configuration, so it answer 404 on any request without "HOST:" header.
 * The test states that:
     * test send HTTP HEAD request to a server,
     * then test send HTTP GET request to a server,
     * reads the actual bytes sent by the server and compare it with
       the value from "Contents-Length:" responce header of the HEAD request
   But actually it
     * does not send HTTP HEAD request, only a single HTTP GET request
       is performed
     * the test reads the responce twice from the same request. It looks
       very suspictiuos

Mikhail Kshevetskiy (11):
  net/tcp: fix TCP options processing
  net/tcp: fix selective acknowledge
  net/tcp: put connection specific data into a tcp_stream structure
  net/tcp: add connection info to tcp_stream structure
  net/tcp: rename ack_edge and seq_init to more common rcv_nxt and irs
  net/tcp: improve tcp framework, use better state machine
  test/cmd/wget: fix the test
  test/cmd/wget: replace bogus response with an actual response from the
    HTTP server
  net/tcp: simplify tcp header filling code
  net/tcp: define a fallback value for rcv_wnd size
  net/net: fix include ordering

 arch/sandbox/include/asm/eth.h |    4 +
 include/net-legacy.h           |    5 +-
 include/net/tcp.h              |  257 ++++++-
 include/net/wget.h             |    8 -
 net/fastboot_tcp.c             |  193 ++---
 net/net.c                      |   45 +-
 net/tcp.c                      | 1297 ++++++++++++++++++++++----------
 net/wget.c                     |  558 +++++---------
 test/cmd/wget.c                |   81 +-
 9 files changed, 1508 insertions(+), 940 deletions(-)

-- 
2.45.2

