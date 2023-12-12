Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984FFC4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 08:53:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31AB6877DB;
	Tue, 12 Dec 2023 09:53:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="ZXMFaRSq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A25C87754; Tue, 12 Dec 2023 09:53:12 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F116F877CA
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 09:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jz3upDzy+vEYwQlHfcIdjL1/ChCa3Y0IOEZcxFkXGJ4tExP9JOomQhQ4iO8jKHWtMH7kfviBXUrziYPY9ZrxbyjmTfOTwAxLM8KGlWitoMtRV+xLePgfwGm9fJsi/imhIuVbMLEsx19Q/AT3uFiLSL5Jpt3DNXuJJs5poCdJaIvX+e//BeeImIyvbrb8Vr/GG+KC0qc/YHpfM9b53tepQ78DAGIi6j0OwelKThW+48DblhzyUcijHdkPqKR4XJusXgj2Ft88XdBjz4mGvODOlojqMnqU0FQfPLbQxtcRI98pTBf2xSdZvvTLvO/SwQ2YNfhYt0CcQ/v+ZFIYckG0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8cqmA8DSV4svkkJK3ZSlaMfw4UCEQDaoZZToZ6Y6oM=;
 b=F12DyFVMZPgOihoXnSgJPdP7rGZx/sYfq4wddN27sdL1TwZRt/DOKHChWkHpVgvwWEiHkKFpJNOWnTS/Gr5TURlkO8c1rf2iLZgBGRtEDj8yD+lpi9ws2RPq+M6Ts7Xzg0f/5vHTLIrYj6RRj2mW0xWZosuoMNqke1DIuFTQW/yPqdZoMg4UNK91TCNGZCSVEppC4L+aciGw8kF4fAZL8Z5fOQ+6q7icYtTtbwkLkmgVXWo7K4gjcYuaUXPJiZ0vFRCED1bJPCLgk5kDVUKYdRC0rXyr0xTHC+iZc+KC4g57Gj8LiciV+hv0sjW/qA0npCFO4Vdhz2bPMbu62ZOs8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8cqmA8DSV4svkkJK3ZSlaMfw4UCEQDaoZZToZ6Y6oM=;
 b=ZXMFaRSqjdEq/USlbIzL1UpklOLzt+Y0x+UabufQQ5BfC6Ghjvk4Oh59GxDpgPUf22ZPEbTLyDrSguySlPicV8Y2NyUzp08xxChH7h8zcXaRoGSnApDaBUM8Lzlc4n1UiSfi4IUsDOwSyKTFUnY6ElSM+vXMhZHqZ9TcCLsfCek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM9PR08MB5940.eurprd08.prod.outlook.com (2603:10a6:20b:281::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 08:53:07 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6%5]) with mapi id 15.20.7025.022; Tue, 12 Dec 2023
 08:53:07 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>, Bin Meng <bmeng.cn@gmail.com>,
 Roland Gaudig <roland.gaudig@weidmueller.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [PATCH v2 0/6] Enable setexpr command to print cpu-list like bitmaps
Date: Tue, 12 Dec 2023 09:52:30 +0100
Message-Id: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::6) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM9PR08MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: d9190b3c-4a0e-4b96-0553-08dbfaefc281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pk9+GzsuPYKXz+9hDwg1IEsrUkYKQ6U9ASfdovBZ08lNCXmZbD+QBoE4J/uv6VgIkTBfT1vp3RjV9P+JOUfzzyAuLKQ7uuNeGkHRwNFK1aYtV8c1e1Ddn/3TMVYRbAYhBjVbaJcIsP+ZYO85XbUysT79sFglwHBsfcDV01qhukvSDr5GLhhIq691eXcvadk50s0CA+Q99iG2VFWC3+0Blqn4Vd4VDmuWRYbMbl3lZk9iRa9YgdQCH6TSPg35s6v/mkMoFF9bONvmxrF8f3vOS+NsWgauONAUosh/79bJOKRYF4140toxpVAhhPtO3LPnRkEvdFKf3cBGNcd4xqY+ByiJS6iCvdG6ulzpgOZDd5o6zcHC1cN7LGuCwzMOOKsFRUNZuNl0ZK3a5DdyihU2lDScj85880zBtyofu3Pz99Na7NiKgjLkU9zsj7eh1jnjO3L86blq7peQauHRacWS0H3OwV5OBNE44oG1iihXIcBRHRio0Cx5jaYCApWy3bhsIIE6kxETSvmaIkl+FN6eTY3Fs/Vg25gqZmznP/ztLj4eEnTf3+BL0CFUrmIcom/odbj1D5rE+Fl3JFuoKLPBaqdo2chgaLsS6R/Rt05iqCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(52116002)(6506007)(6512007)(2616005)(1076003)(9686003)(5660300002)(4326008)(8676002)(41300700001)(6486002)(2906002)(6666004)(8936002)(316002)(966005)(478600001)(6916009)(66476007)(66556008)(66946007)(38100700002)(36756003)(86362001)(54906003)(38350700005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h5aigibI08i+EpUDhtFf7iyojL6xW+kqq8U2z52tQynJGbrsZpoqIuD5eCci?=
 =?us-ascii?Q?oeqrSR09zpYAA+/VUh6aj+R9rY2SdHeL9u8+8OfqtgtUw+bmn0TmTBE5uHUV?=
 =?us-ascii?Q?LV0qIPFnw0t66igC1KI/4fzpQ4ObgJBPu+gfYTjLYwkPNZ6P5opNsU+i5WZO?=
 =?us-ascii?Q?KHbreV2V7xLNBqfkW3kxxXjpjlB3d+GOYluMfIuxAr+LZkUsVX2ospkrRZfc?=
 =?us-ascii?Q?iyy6YxHKkyG6VGdQHkvm+N4aiy8Tw+zoBhbeOTNTuwJ+Qz4MmDZFdniOrYnb?=
 =?us-ascii?Q?GSadbjTxxnf0FU0Tcm6rb/TMJ3+87KylA19I7W0tLHEYpxPp20++Y0RQChl5?=
 =?us-ascii?Q?yRiWp/m1xR10OGuM5yScwUhGYKPoL7EAJYcx/6fd3oSdjd8pnfRj7h3Rp7bG?=
 =?us-ascii?Q?vg6RpsrX8GbaMzAt4JbGXCTs3C5NGyROqnpT++vJkzP3SvK8M5e60gWNeb52?=
 =?us-ascii?Q?WrAfr7yzMoTk/IO2ZppQQdcu8FJk+EYLwQs+wl8Gwwp6cbkj+S6OrACpUx6G?=
 =?us-ascii?Q?3FjQOpFgEP46QHgE6ohykc7m29mBM3zH+HmpAHTYoS7KC3ByRMY9sAp57f4x?=
 =?us-ascii?Q?9cZzw1EA5N3DHUgyPEJL+JibStrVyeuTvZIRag/Vz/ZdNAOr2Wa+egW2bW9k?=
 =?us-ascii?Q?+DN66tMuhy5DH7EacK1ow2h40563HkIMW7lNH0kvkz23GiHIyLBYg2xBQ9XQ?=
 =?us-ascii?Q?d/Xa40lKxZyemuef0MWf0l/cwkZ28Y5jGngPQ8UVUApLafClG0K3zrRGIsNH?=
 =?us-ascii?Q?ibISkjcqg1WK7QLeBf/dDFdKBCecbuuWIEpE1LWplrkHlLTQz8MOiKnV7y++?=
 =?us-ascii?Q?vobJtAiN59+jVlpqPzjoTTjl+ynOi1djtl5HegAEEBbBFRJfTDpDfNsWV7fD?=
 =?us-ascii?Q?0YqbC4rFN9GEyToVem/NtIexiubN1lM9/iNe+mz8kzPEPIaNEHgMaKg9YSE3?=
 =?us-ascii?Q?XNpZh3TvEjf18914q7x73cCO8awcW0CZDObxqeLxol8cDc0pIi5aA7tpK04t?=
 =?us-ascii?Q?VG1V61hFq+9TiOh2RRezfECuwBXpxbiW8AfWVvmQUttjaUe/lcDNsDQHMcfZ?=
 =?us-ascii?Q?90PEfFA6RhDfqOTRgCuwqdTB8kW9SDS0JJBodHyyiR97sk5BfbvHc7bVZzdY?=
 =?us-ascii?Q?m7Dq+PUgiwxGhvSAtpy8r7uyZwGJiNR6PGJCoN/tGy4RGLwDzmc1KWMAy02M?=
 =?us-ascii?Q?qSsH9wdc1oZiGYNHdzrFulVw93/rE3kvkNnVPYg31Fk1vIOeCQAZOrvv+oNN?=
 =?us-ascii?Q?kTMl36jLNWFzS0VC59vpmgFFZ3uQHgXd3X4JCvZTesvD/6jtzGNDzUDHht7n?=
 =?us-ascii?Q?HK/CrGSVoCeGbeZMTtWLm4h1F/6FNnXICR1ig/MYlp1faNF1++qQaDfmlHHn?=
 =?us-ascii?Q?nmlyVfOp5eFkB3fKPAMecxoWzbN8+m2rv2NKDSVIjci8JB4XmIVErOB6NmfF?=
 =?us-ascii?Q?1PZ8uOi+poOaVIffduHYi5IK9RujWugUCrPb0NUJQHVfr+ZEVOtURKS3gSzC?=
 =?us-ascii?Q?YsqYUxMxKElsri1yvyDtRqoJegr654kPnvN+J993XT+CXDQ15pa9zfxLqUS4?=
 =?us-ascii?Q?hYf7qrbeCLCyQ5JTR9mlE3k222nCM1ClBGSmuKKssNk5N6D6Yz2o8IU7RGyR?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9190b3c-4a0e-4b96-0553-08dbfaefc281
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:53:07.1758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JUI4XeXduwWy8gg4xoJ1en9hbU7GcbwXdW1m6v/2fKjZWJnIq+etCNAu5gxxjyHCU5/B6jY//rsocodEGlDTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5940
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

setexpr isolcpu_bootarg=%32pbl $myCPUisolation
&& env set bootargs "$isolcpu_bootarg"
&& bootm

[1] https://www.kernel.org/doc/Documentation/printk-formats.txt
[2] https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html


Changes in v2:
- Add bitmap format specifier to documentation

Lukas Funke (6):
  sandbox: add generic find_next_zero_bit implementation
  linux: bitmap.h: add 'for_each_set_bitrange' iteration macro
  test: cmd: setexptr: Add tests for bitmap string format
  doc: printf() codes: Add bitmap format specifier
  lib: vsprintf: enable '%*pb[l]' format specifier
  cmd: printf: forward '%p' format string specifier

 arch/sandbox/include/asm/bitops.h | 16 ++++++-
 cmd/printf.c                      | 29 ++++++++++++
 doc/develop/printf.rst            |  6 +++
 include/linux/bitmap.h            |  7 +++
 lib/vsprintf.c                    | 75 +++++++++++++++++++++++++++++++
 test/cmd/setexpr.c                |  9 ++++
 6 files changed, 140 insertions(+), 2 deletions(-)

-- 
2.30.2

