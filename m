Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E2CC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 09:11:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24B1C87A99;
	Wed, 10 Jan 2024 10:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="CUVHeA9d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92F8C87A4B; Wed, 10 Jan 2024 10:10:51 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3464B85E44
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzkF9M36m0rch8rQ1JLVFRkud5DVsbBN/FqqqY1Rroslp67Pp/ADDE7Cf9cc+J4silzcwET2kPmd+ZqVDzjkqOdePr9+oa5yLDflbf31+cxXmWPUVcsE0309qNWQu5jXuzgrMpp6hYghQ2opLwLC17YTtOTVbb+mK5C2x4gKH3sICpWivSBYVj9qMXUVtmW/m5JUWU17Hfh0fPmGFJk9p8jSZ79ErYGAgcD6z+7w+wUvc3U4v9ngOMUAip6fqMtmXf0CYpE9D2xh1absO7emdyET0N4La+Eseto4G0iLVvtBoHbaXQBXrEoi9Rzudve0vGzJIctU2BQmySNIpIIP2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S42LaWGIAFlxh9QWibhKVkeyPm7TdXTqYss3DeIf/Js=;
 b=inY8PftX8tpm2AQ3Dju842p0e9cyYRMb4bWNJ+6o0KnwbK/7Ud1AcuL9ywttsgr+GyZyFAT0EDoQ2JSrYGCFqRTlpPmsxCSqrKR7paWGxcvKRCPjwu9D5cnCOo0yhIShCuDkt7w17pe0kn58IZaql5sL7IT5gDNCCqR9gP+EJRKoKcXTaCMvzW76KjPxzAgILGSSWI6A35xtN8gaDzN7Zx6U8Whp52gXqq1Tw0CoU9EV/w6HEK2p/6lDrcY+oZOVxfVsQ/6wA30ErUNtk62Pp3FaumFCEDcX9y9XvOWmzOAbN0U7uP3u+WE7U5VyHOeJ4nnE0ikn9ivrkcmXmazHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S42LaWGIAFlxh9QWibhKVkeyPm7TdXTqYss3DeIf/Js=;
 b=CUVHeA9dHk19zG0uQLXwOLKJd10dYZoXOiARCj7UakRDH+Ua2l82mAF5l/OIqzn0K8ONCY8JMuDGF/KFtQHtBrpYtOIsu8yCCf1w4x9ECjAhtKNxZSls5ptCmZ8A+QYmUbAqEGxt97wurkCBrKDHrmN8mTNCGuOn1YTX1BnzVvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by GV1PR08MB8641.eurprd08.prod.outlook.com (2603:10a6:150:82::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 09:10:47 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 09:10:47 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>, Bin Meng <bmeng.cn@gmail.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Roland Gaudig <roland.gaudig@weidmueller.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v3 00/11] Enable setexpr command to print cpu-list like bitmaps
Date: Wed, 10 Jan 2024 10:10:26 +0100
Message-Id: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::11) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|GV1PR08MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: deca497f-fdf0-4625-76c1-08dc11bc0848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5R7nZXYRdLxpa+cnpak0zBYCuDNvL/nO450EvBjlLC/JUjWHHnaqNBIgaI0zPEaukZz5cA1xTW+/ILeBrvyinVz7ooGn6gZthI/QGOGitHkAhv7jfD+lO263Ycqz1IkDX1pyarFyD0kCzT9laXy/TWYlR+pLcWYpdtRtb3uF8hMSnoJ93ayin7kEHfz4jGd+CbEsAPGI8kS6edC8L1YNNXWcJtWeI6bEciohFqenf2yvmkzHHat04CsrLW/Eby86n6mXvsxW7wrCob/lM9DN85+0atiOTa/IqL2osBd6vBR9I+feOHi0edD8nhGu5exFpFW0LKYxGV+0VNjwE+t57KFlcJlCxjeoaoaki4SRnJCeIkM+vIr0s47jQfkmxWw4sXuDfs00QX8Ge2PxnZQCkyEpKj34XNm09shjY6A3clsJDOjjKyOuDBgEvSsfmcDiLUj7TthfYtAWJw0Ep1ReTurxi6AWDI/rYQyuxohZWpDByN1EwcxwA3KtIPlTF6opwAprPEqLyHeRq/7/c85Odw4zlPbDb59umtuwkZEouuMrTAIZtzyttqYpYq375omUvJd8hYG8VoXmP+HbbBJ/JxvLF+9o1k7YLa/vimQ5O4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(86362001)(26005)(1076003)(2616005)(6666004)(478600001)(6506007)(9686003)(6512007)(52116002)(966005)(83380400001)(5660300002)(7416002)(4326008)(2906002)(41300700001)(6486002)(8676002)(8936002)(6916009)(66556008)(66946007)(66476007)(54906003)(316002)(38100700002)(38350700005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MqErtgE3oRBP/PZHHaUYIsm5Al4nN1Qn4QXccaOT2qQhm/NgxH434QaZVCWI?=
 =?us-ascii?Q?/2mz6zYBXWZ5RHQHMstoZ2AEOnXP7v1mhp/jW9OhKRSPMrUnuerm+idVtaP5?=
 =?us-ascii?Q?lhduyXuTCJVMUhJVTAar2lHlTJbQpSglklvWBw+cOgkcs/gId+J7WdygfLcf?=
 =?us-ascii?Q?1RFx0KutReo+Mf4kTDwW88qELjgLVkZRIGiyAinEtcbWNUDo/vvOFnVKxPkR?=
 =?us-ascii?Q?nX/VkWowlno0slaWFX2Ip9/OG/IcSkK4MqR6QH0+1Azj8alY6iC5XXiILCPI?=
 =?us-ascii?Q?CaVUEJHVuJ/EyMrDwHqGc52BytmHxewkIWQ/dpEA43QV5oI4TIR2iPKNyfcR?=
 =?us-ascii?Q?B25026BAcUQS+86SOnNSCeDs3QkbVAlem8/1UmxTG/9gv9yf15JDW/0KUjmR?=
 =?us-ascii?Q?S3IvlXO+2h3wsyDmEcXfVL1xutfSRWZnZip+Qm+uvyLVl4cWxDL/k3JL86ka?=
 =?us-ascii?Q?QK36q6vSUMk1wavoHvQ+Gv/+sfFNaU5SgkME4tucKqZWxeG/rRd4+nUGiisR?=
 =?us-ascii?Q?H/umNkkAuTKQfuQwJqxGs2ISs3uiT8af0VqUTzUBHqLrY8iNqmXKDS5Dlkxs?=
 =?us-ascii?Q?4U/sQWW8sDIF+KZo0Y7fQ1mjYO95EH6yRQWrqzUt3DZlBkoYG5WYKtyO8MJl?=
 =?us-ascii?Q?S4r2cxRGFpMAnAEZ+KPbYNK4CbU4f4Fzdx2APPBkN3TArZ0SdGT39UooNsVt?=
 =?us-ascii?Q?ZfMpV8JO9qGdCEUJu72HHN1ZQ44EJmY2KlruDzbxjg+e9EsCPh2PrXMk29g7?=
 =?us-ascii?Q?vgr3khUMOthSvKdQmE4qW+ZhEEsZ9YU16r0hya/WJjB1tdvCJI14EUqqp6EJ?=
 =?us-ascii?Q?TOPGTdZsy2T1do8NyGFv+vFhVaTzUtXDA32fYPDvPhIJsrzOFWIcokHSpqH7?=
 =?us-ascii?Q?T9th+Ulx81mKZVyvncBMu1758fYqpubL/THqHFOHLHDTq0Moy72A/2cM7cGI?=
 =?us-ascii?Q?fq/WdyTWX1l0U7a8u0JYgSalrIWYkI8TashW/5m+pESAibPYH3kR14JdIhpN?=
 =?us-ascii?Q?pJzJke6soHhr1F4CwD6DtWBmadlwIDmfyxc9944kYcyEHKOA5lEU6pbrA0LA?=
 =?us-ascii?Q?HTW9vojE8PLC1Zwea61TQgpxUYZ5EBL5hBj2wi8f2CtL7wXZgLyPQOzmHkW7?=
 =?us-ascii?Q?BSkqCexB3iL2XSPqLNPbkSK4Hp6wP8OGwn7T2XgZFChURmnS5ljSCT6I1X6Y?=
 =?us-ascii?Q?R2juhXqjD1orPx3miaLV6e4fG/rNl0oTocXNTGNwLS19mNuKZD6Ibjsc99v+?=
 =?us-ascii?Q?gXsoY3HUf1DIe5njjHN7zTd9XUFcyFYsQ0IHE23jWAQ2VtjKEGLvzi+HVz4c?=
 =?us-ascii?Q?HKfbUwNahJpDSfIgQtjAKdgZHgfrfucXLlH6aKRAfYayPzj7c2xIjPUPwZcs?=
 =?us-ascii?Q?DSxh4YTOAQ6jmFlmCXK/FABCizKqkssittTTO+P/J/damM9MrxSwUqgo5hbQ?=
 =?us-ascii?Q?kQ2oH2VaPyHJIE1H3ON9kTvAkqm3kWuTe0jnIBEnPSlWm7oa4k9jfyiNpd4h?=
 =?us-ascii?Q?gXlu3cae9MDNAuZcPR4V3nqZKEL07yrV3ohCbY6yCSZEgc4mn3YmTJkSTl3q?=
 =?us-ascii?Q?LgZDdxalfDymuiR9PoGbO+vP0QtDyZAd5RfLm9Vz0Zu7lpN/ZdWIN+hvzxsw?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deca497f-fdf0-4625-76c1-08dc11bc0848
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:10:47.1755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIvZ87j6VBaY61wFoysHTdLrl+3hiZxxtfsRUGqolvo2AwQfBr7d0cGeSu4xApaRbRcQU+6ED+mFMjbc04LIQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8641
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

From: Lukas Funke <lukas.funke@weidmueller.com>


This series enables the 'setexpr' command to print "cpu list"-like
bitmaps based on the printk format specifier [1].

One use-case is to pass cpu list [2] based kernel parameter like
'isolcpu', 'nohz_full', irq affinity or RCU related CPU parameter to
the kernel via a separate firmware variable without exposing the
'bootargs' variable to directly.

Example:

=> env set value 0xdeadbeef
=> setexpr a fmt isolcpus=%32pbl $value
=> echo $a
isolcpus=0-3,5-7,9-13,15-16,18-19,21,23,25-28,30-31

[1] https://www.kernel.org/doc/Documentation/printk-formats.txt
[2] https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html


Changes in v3:
- Use generic find_next_zero_bit() from arch/arm/include/asm/bitops.h
- Redirect sandbox ffz() implementation to generic __ffs() impl
- Remove '%bp' from documentation
- Give an example output in the documentation
- Remove bitmap_string() conversion function since the same function
  can be achieved using other format specifier
- Dereference pointer argument (i.e. *value) in the
  'setexpr name fmt <format> value' case. This is currently only
  supported in the 'setexptr <name> [*]<value>' and
  'setexptr <name> [*]<value> <op> [*]<value2>' case

Changes in v2:
- Add bitmap format specifier to documentation

Lukas Funke (11):
  sandbox: add generic find_next_zero_bit implementation
  linux: bitmap.h: add 'for_each_set_bitrange' iteration macro
  test: cmd: setexpr: Add tests for bitmap string format
  doc: printf() codes: Add bitmap format specifier
  cmd: printf: Correctly handle field width
  lib: Add hextobarray() function
  lib: vsprintf: enable '%pbl' format specifier
  setexpr: rename 'get_arg()' to 'setexpr_get_arg()'
  setexpr: Promote 'setexpr_get_arg()' to a public function
  setexptr: Extend setexpr_get_arg() to handle pointer to memory
  cmd: printf: forward '%p' format string specifier

 arch/sandbox/include/asm/bitops.h | 60 +++++++++++++++++++------------
 cmd/printf.c                      | 53 ++++++++++++++++++++++++++-
 cmd/setexpr.c                     | 48 +++++++++++++++----------
 doc/develop/printf.rst            |  4 +++
 include/command.h                 | 27 ++++++++++++++
 include/linux/bitmap.h            |  7 ++++
 include/vsprintf.h                |  7 ++++
 lib/strto.c                       | 35 ++++++++++++++++++
 lib/vsprintf.c                    | 42 ++++++++++++++++++++++
 test/cmd/setexpr.c                | 22 ++++++++++++
 10 files changed, 263 insertions(+), 42 deletions(-)

-- 
2.30.2

