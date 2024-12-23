Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC444E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 10:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F18C806DE;
	Mon, 23 Dec 2024 11:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="JYN79uJ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06BD2806E8; Mon, 23 Dec 2024 11:59:10 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 870A88069C
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 11:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWHVNGnJaK8RGT72/zdtsLAQzTWsE1hGN0izITc7uvEyXUhqacLMkRKB4fT7y4Bl7FbOQpt8i5+jo2aj4Ykjorf6yD8xSQ0EL+DYfjujT7TtLo2BNuIMuDx6kxOJa1IQ4pJIicssGUmlE1dg5iNsIt2Y5cDRrDW1qLOMs3pcNiFk4+QbIU41n0FqomnVg/H8fOnFLpwOog+fRVPBjz/VSlasYoHMVjburfLQK5EVVrBhwbyBfpaJ6moRC4eOZ9dsVFE5MAiAECKUk2r1oqbR8s4wN/mAO6oeT8At+3Cdtxtqn8onPUNHSGK/c3zadnlw5o6Vr72LIeLgVcIfMYUjuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZDw6M/8qp9MH4h6XRYZu6y54Yk3l4UyOTVoebx2o3g=;
 b=Bx1iCINepeTobufK8XFsR/DyGCOgko0o2RveCTC+nqtq5NVXTCi90CY+yX0591juo33ZX58eD0cbaHEczq0gFZW2m55JUeZ8wC0B2yvnYQherjbx9+l5f/yI2mBIYe2iEg3oLtfR4AMNQG+XSkh/TWH6xp3B5T12sVYB/ZWz5ozJzWkcFJj76eiWMuFq5MkqznyFVCAHl41Ln6juoZaSMWjc7ETsZa3Lox9da+ddc80YSYQjqxr8dh4LBOvi28gHXbOD+l+Czj+r6MQh8e6y1v3CFBb0zZt51NEpau8Hbwen5i6X5+I2HsBPGZQyCC0dk7HsHYFgNqqAKL6G0bBFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZDw6M/8qp9MH4h6XRYZu6y54Yk3l4UyOTVoebx2o3g=;
 b=JYN79uJ9fK/EXjKPdyWWRwZ2oxi4A08QNOaq/amLdJpFYjINvS/OzrMi7E6iyOk7yncACq9teWTiPAzq+HAY42lFB5Sma+03kCwfX8sEFCdqGoh47BBa5oTakv+sD+jTFEOtGhQviKIqcTbnkjGW1wBjX08J0MYDNt9svBqaRx/XcdgvkMkBfTvU+83MTt+UxRBwiBLYhlNJRASJKa6nLVj2HmTgl9zNJypRIMhQ8OVNhPfro405+3f8XHWEwJNrG/J6FQtYSSD6ejLbKEqabuDbeGuP+vnn+r1V2VNI9tyE0+njEb18vY/A/iT/6fJcPsFRy6wLzM5MOzQUyaaMsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6676.eurprd08.prod.outlook.com (2603:10a6:20b:2ff::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 10:59:01 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 10:59:01 +0000
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
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v15 00/11] net: tcp: improve tcp support in legacy stack
Date: Mon, 23 Dec 2024 13:58:41 +0300
Message-ID: <20241223105852.1074404-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: fb95dfb6-cf9c-4d1e-be8c-08dd2340ce9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HrpOIAOyZp2KKDbMXfr6pExAy48Z7yV5v6RjjkKnMIzdOpXNqpCcsbqZwSf9?=
 =?us-ascii?Q?vLh7MdGw4te+4uLHDctLnwfXjmA0AggV6MPbpJb6zgaHE1tsZ1qth0qwf3Iz?=
 =?us-ascii?Q?D8nQTfpIbZIBv4o76jKopKzEyt9ml5u6WVoO8RiVKXI2PVdb8bR8t4hOOSQb?=
 =?us-ascii?Q?zQ010t4AsoTZhu988wDxoVkzGfwPhKKz5vgIOZwd7N3CCThTV6cE5RujM7I/?=
 =?us-ascii?Q?sCert9z1qh7Fgg3hCjASUYT+d94KUc2PcMkI8igb+vMmTODtbjgWh1CWyzJa?=
 =?us-ascii?Q?jnQ5HJ6aU9rc5hOJtRRbyahc/54jEBhJPMXBoDC4wAVmmdp9SAXu08cMOYIJ?=
 =?us-ascii?Q?HEk51mf/DKhcmR0Zn5+lO6bHlS0bXU4C5YEU41BoWrsa8Og0LudLnTYXZ3a+?=
 =?us-ascii?Q?KxBr2Z9JhZ3i+jbfs9zhGJcr2xjBml2ALombWwlUbuFUAxfjfZI+X5oAgprd?=
 =?us-ascii?Q?CSARmESrRkTpJLtsIXkzq+HpP/Rdyimf1UNEmM0mtDsCQYaVGUf+XjiO94Zx?=
 =?us-ascii?Q?8pQD7dT/KfOjzGbUksqdhTQ+wwppG14lxx7Y+kmIBYYxsZndHMAsdxe096ef?=
 =?us-ascii?Q?aDvJRIlyWQxtcVkR3xnB29AJdj3jJQ014FSflZjSu6KbsGCf46tHPSzd3mTB?=
 =?us-ascii?Q?sI9F8nCHVqWIKf4WXv6C9ZcQPGTpuFSzvkmsbUAwBa/HipQ6amkL+ys/suAj?=
 =?us-ascii?Q?dac4Gz4nuf3fUnzm78lH4+tMPzcjioQpzL1M58Co1vDNru4FgnSIfj2dahMX?=
 =?us-ascii?Q?WrrHhpplrJL966zUZIYyrXDbnHR648I2vXFZcVJjCpUqE97wZCYOxR4epO74?=
 =?us-ascii?Q?Fl0m7M2xOnGEGMTkPzf60h7FrCkEAXzDWRhlaJuR2Uh4c3IC/DQZYiI9hUai?=
 =?us-ascii?Q?rR3Qy2tOKTCxuwBOorBgD/RRP9NnNyUUBOjazyeCRKEch+w94FUC32HeXnMi?=
 =?us-ascii?Q?SKElJBwZellKSVnP1AWExY3FSKG3oi4bR5GZ15OP+iOO7cIJID86mPfv8Z78?=
 =?us-ascii?Q?Jz7ly17oIuEVM7ryZsPmn5Z4YcxEvWZVH07mU/Xn1p9U1Axx12a61DAZF+IL?=
 =?us-ascii?Q?+uEyEzYAOC5ZjpxSFIuDtSfpaREyV6NNMoxDH7i1WdR8SipIOvvacvIa3RTE?=
 =?us-ascii?Q?P0PJC1eS4fupv5gmcKjPtTwp1TikZYbdKscOh54TV+sKAK86nRqd4PryI1wH?=
 =?us-ascii?Q?wh/Sc8MP5bjbP1ZICNC2kHoECfVz21guLsHvd9n5QzS5zYYYjOH2lvaV9xLP?=
 =?us-ascii?Q?ebq0kIYt6/rR+215z+WTRZU2sTMH9zirI6z+tNDQlwDMitywRoPzbqnEBrsr?=
 =?us-ascii?Q?/wCtHvisB+D3L/uf41LszUffurbIKyouL7GaKwSpLbeq1vHq/6JaootOo8ty?=
 =?us-ascii?Q?jTakBmbHdiT+F5C6YpE5eKo+D+ov18afl9/eXDD1O2kUy6HOhwuvK6ENtFlp?=
 =?us-ascii?Q?AStDjy5GtsTq/NndoN3D5wIkRda/qe2xussb7g+ex9MbiV0Rt9vQew=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?blEghy7KrW0sTXvQIiyOD93kXQkswhVI99/ZGtc8sUt52JfxAN5Y0W9yUBxc?=
 =?us-ascii?Q?UCbwbHrWzJ549skIU4ojAvnEPYwlhYOYkVCyZkoIVCGWP5fcj2bZUn0azXwo?=
 =?us-ascii?Q?8zCmBibGd3TsLJ29kIo5ZwDHOXe/qQx2ytp/V5zKW2DBBObWg22uJztLh7QI?=
 =?us-ascii?Q?fDYog2vtHLfSN9CDrbq6iSqWStfHLyQCVXj3qeevVB9/YitC3APAUDMhdhXO?=
 =?us-ascii?Q?lrd7xH+6PVnS6ToH4uoVrt5wMuz5whJ1FglhEXCfeldWa5VSrO3pz5b/EL+s?=
 =?us-ascii?Q?Co55jelx6CVZRvCTsSD3XmFLVANu7cAdsH9yX50spN96JZXxRqzcyA7ZiWD5?=
 =?us-ascii?Q?ni+bWc3EfKDkOMnB6Ngk7CtqltiqQKpjFoGAgy0Cywamj3b40WNxQ8ZZ8IQm?=
 =?us-ascii?Q?us9ZOtkSV9MaYokXwI8cHYRLbuWlAmitkQ37tucNHYWxWpIIvu3pvXjhr/Ty?=
 =?us-ascii?Q?q2BmgpvIngmVge7utcdHSk5y1vd+Q26KR4C7psy4PZtz29AbxDAXp0YutkdD?=
 =?us-ascii?Q?hS0oPyK3fTGABnPp7n6UAj6OulbIwBk0L9UNvtxDyTkwpSMCbvoY1P15W4uM?=
 =?us-ascii?Q?QCEnIqrdzxeTNi31PrJK1cFVCrGyJ1QLQVQfreQVntE2Nu5dl1BDYTu3Q7GL?=
 =?us-ascii?Q?YaBAPgMCdYUuK0Z1ppE7t8oMFqFpCbUOAHJVqvXTgOlRCx2RWVGjbqxD/iwT?=
 =?us-ascii?Q?hO1OIBiXxHC8zRk71CWG8r3LGiUz6Nhg+GA87Xii8KTp35weVsuIAFWcZ5UJ?=
 =?us-ascii?Q?2e4pJ9KrNgTQ1V4/SfWCTjnQuw+Y+mBmdQjm9RuTRDnGqzaPsc1V0mvc3A/J?=
 =?us-ascii?Q?pMvRsqGElB4IiA1/X85XoKl5XCM7JnAV2FD4iUZKrmxlpIL60Gq7a7xCecuv?=
 =?us-ascii?Q?kf45OMeAv9aYpze+QWIC1sz6Br/FA3dLJv2TbzRVOUZ5quIALJqOA+uRqinQ?=
 =?us-ascii?Q?N93+oNuTPlQVnDW5NKgIriLfm4RbOLY2j9Qqhu48CLlMbSaqmvjVYD4T3fTO?=
 =?us-ascii?Q?edVuPsygmWw4Yrn0uc8IeLvK/+1IogufRJbSBy5QeZJ3KHRunUkN2gU8HAwk?=
 =?us-ascii?Q?cLeepbGkpf/KQzr6UH86wOTTPKyqvBlpOzZI677Q4ojOryCJ8tFdQiDnsuZ0?=
 =?us-ascii?Q?WxU5qXfRciXP1om2AWAtd3wlvHXHPuopBI3IOCVj2Txhyi91oaneGcobYC+W?=
 =?us-ascii?Q?2bSl8UdLUBetqLUIe+XWZLNzoWlv+CFEMiNo+L7/Gw3HFnQB4wTHaRLrWOvM?=
 =?us-ascii?Q?RXcEaNKq5pMa31oxTcvMdCM3C95Mu1CdZZnaGdEkbY0HiapoJDd/l6gr8OX2?=
 =?us-ascii?Q?hIdskb78y/2c/D3miQz6w7YSIJxPW6Jk9kVawrspygYdyuYg5eSXwr0WwP8C?=
 =?us-ascii?Q?hti4nzKbu86eI3PZ03zo3wWtfcUcEQU+AaT+GXVT4Vab0QQDHOBgMwJ+TMvm?=
 =?us-ascii?Q?K2L/NBV02Pvt4uqQz749KJoRehUa8FS/iUkkbJSUkUiNyQ8hUrMH/G9pT1nI?=
 =?us-ascii?Q?+xJ/DZl7wPkF+4m9zCAG7Tm6EbGSIwE37E1M4alJH7HI3+JphtErXrz3h07G?=
 =?us-ascii?Q?tSvkyhnjRytefd3RWlTj3Gs1h4I3UzG1AkOCWdMWVb5/oO00Anbiz57sQDbv?=
 =?us-ascii?Q?bo91rCr+76MC28ozGLm1rgM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fb95dfb6-cf9c-4d1e-be8c-08dd2340ce9e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 10:59:01.0346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzMDcXTbMu+VFed46wpKig2BG2+0YUN0VvmitO3fQsEGyPFSpdTSFk0meKJASfn3t13X5ejOL9Vj41IY4eUJwG68gJZS7h2EG6IKUCPHnBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6676
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
 net/wget.c                     |  551 +++++---------
 test/cmd/wget.c                |   81 +-
 9 files changed, 1504 insertions(+), 937 deletions(-)

-- 
2.45.2

