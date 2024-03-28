Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB664CD11DD
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 22:38:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F9698820C;
	Thu, 28 Mar 2024 23:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="NS4M4I5T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E59AB88207; Thu, 28 Mar 2024 22:59:05 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d10c::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3192B880E8
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 22:59:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBNUrf8opwvQaJk+U+Z8renA/VNuAiD1UprHNgRzu3dAZkNX8IGU8lwbGgtxf6q2ZBhpas7BG8InuTx5Sk9yXy4QQxOE7w92NTdt6HdMWIfafGo5a0aoP4rBc/RRGItctB2g3NUs/HfuX5kkEGzr36G6len12WCvP3B6t/O1xGrRMTPGL/j13w47rxwwgL8MyEtRMhMQZo1eMzOcsXcU3W412shrScDbtwgYSKWke6KrNQq+6kPvNoJfr3fcn26vw6xZXIFS5uZ6PMqt0T8LlWyxl2cR0H9gCz6qB7x+8ghW9zrS/o+3AhA7C+vQ6vtxGJj4hy4MdIB5eScjGDBwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pN6e2QcudZyu4cBD/yGtWGr+OyzQQcl/q8lLYAsiT10=;
 b=HryydlTxdlQjsFlyMbEvKryxftILxBmLzgxlQnd6sFCQp1NYXQ4O9Y37uGoKPpm8vZMwEEK5sG+5vznfX6YPJs4pDgXX8JQcPSQAD3GMYx1VTW9vySYUI2OUUDlOPFUJ2W7aiCOCjqRBsiDZu+K8nox75mydLmHwqlT2Q9RxAdYNMkdLyF0M2Muo7DEV2dCelSJ8N/A/QX3OGxwz7+Xywn6WNPo6F7sSBU0aFZXfcvmXUEJZ7alLljmn95h2AjdgbNyM9ZrDPNlWHvWTsH2IG4dBQkrqWSjZjQgvScd6LuQQq9+Fh4WPiVn83u94PmSB/tKt+EW6Hndm9Fa7K3GGVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN6e2QcudZyu4cBD/yGtWGr+OyzQQcl/q8lLYAsiT10=;
 b=NS4M4I5T/4ThSvSFLOvncWTYVqiU2xo2vYFR+NRvuaeVinRq/ys+hgtylaG2hHyT8f70E6UdvfEy9hgM9Gjvv+tE4fp3Lh5BC9ZHa6DwFLwAfbX2kjhVnMfMZilJlpYEBvXpbKivFMWIPXUSeQz9BgOzUT4VGe+WclWytXv219W4vq/G7fk0rf7UZlzxHBf0QqMTq6ZHw6woh086997G8MWtemxB+MXFXysFAo7QFW9lNa3pRAbLhRW9Bx+psih4cqtH/RHjmkOeXHGp3I7ZQMPiN+bbPwD8oWpsJxlxWs1sxa0kRsvBBKA5Dcv3cFg2NmBoUSCr0x+b3rdDFAZ78w==
Received: from DM4PR05MB9229.namprd05.prod.outlook.com (2603:10b6:8:88::20) by
 CY5PR05MB9144.namprd05.prod.outlook.com (2603:10b6:930:34::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.38; Thu, 28 Mar 2024 21:58:57 +0000
Received: from DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::148f:6016:501b:93f4]) by DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::148f:6016:501b:93f4%3]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 21:58:57 +0000
Date: Thu, 28 Mar 2024 16:58:53 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 xypron.glpk@gmx.de, cym@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, jonas@kwiboo.se
Subject: Re: [PATCH 1/2] rockchip: rk3588: Add support for ATAG parsing
Message-ID: <DM4PR05MB92294A5E8F160BF82B4E46EFA53B2@DM4PR05MB9229.namprd05.prod.outlook.com>
References: <20240326204944.1572667-1-macroalpha82@gmail.com>
 <20240326204944.1572667-2-macroalpha82@gmail.com>
 <fe9eef97-5814-4d25-8357-60873d565aff@rock-chips.com>
 <DM4PR05MB9229EA8B503F50C94DDA5212A5342@DM4PR05MB9229.namprd05.prod.outlook.com>
 <9541747b-b05c-4bb2-bf73-d720659905d2@collabora.com>
 <DM4PR05MB92298DB9B7803B3E0ABC0137A5342@DM4PR05MB9229.namprd05.prod.outlook.com>
 <20240328200209.GE3442575@bill-the-cat>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240328200209.GE3442575@bill-the-cat>
X-TMN: [aPgI6Nzlj+TbnzVIBO8fWoUq4vVBC0y/]
X-ClientProxiedBy: SN7P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::17) To DM4PR05MB9229.namprd05.prod.outlook.com
 (2603:10b6:8:88::20)
X-Microsoft-Original-Message-ID: <ZgXoHfq8FbhNvByN@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR05MB9229:EE_|CY5PR05MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 018d1115-993e-42aa-d81d-08dc4f724429
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RBJns/tB2J3/JX/8I5axLg2N4Trcc90yo8QHY6wYirNaRGzJ6zf9t5v3MaHY0g7JfJ5vIdIusTGoLBtvbuT0YDiY4RW3N2y882wcIO0D8T3/GtmjCAwe7qRqUnRsG8uiIeY8azSJeX5SlprZrmfnhmxj0bk1viXWQU9ZQujVhnLZq+G3w+Dw8/wTmv1Hny0kXSbnTOQegf5qVfZD3vPkop6oZ6Vy6N7EN64ZFgH8lbDfyBFeB1VkjtmEN4G5ZT5umGVDB95q1U/hwvSV9l0DSUSbLASdbyfELA89FFiLtYXvnIzSvKUnKZWU6kSKDgk8EXyjY0frrkD7BktqmjZuo3ISszvx1DgHHqk9GAaN+4ScXFKhDp1VgW0TmQpDuiXEObnOBRGbwoafoOyL5NwZvHtNaDGDzLKggjECY/8/vApWgVFHREOfC1x9OphmsdXk7XCKzTVaLmXEPy3mV4cXRAfM4kLxOX8bAX2SfKHVodFMtaeYWbVM6epdVhi8JUZp4urI0akW2SB27zhleW9VaEFtFepQk/6xLhsW+fYE5zrMaDIoPJ1YLjGkqCZOnP9s
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?4sBO4E08Oi3CeaI0bYG3oaSm4sdakD2v5VVlac5LvQdh+YeOEWhuQWkWvV?=
 =?iso-8859-1?Q?qdk7gj5gP3UDu/dTf4IaW8akEH7i0v3ctoLUIcOtaqp+PSFEyVf2F1W+W1?=
 =?iso-8859-1?Q?6tT3/wIy91huq7Ci9wwV/3WHLJnAG1vkA/g2e74mZpTzB9AHlkq+C6LI6p?=
 =?iso-8859-1?Q?P+ro09VJrNGbNiJTPyC9tqicb4VuX2EzfZt5IrGcg4kXQMj0ly9mBc88gH?=
 =?iso-8859-1?Q?USNFsCMOJHckXZLNPqqo3f/7X5Nt9vkgGheKV+iO9sAOmW5dSq0qiUjhjV?=
 =?iso-8859-1?Q?8zWh3C6J6vu1ef7x1X0eFZkHIsWuZK5ZcsBoSN8uSVBzNyqGJ9CyjlVmD/?=
 =?iso-8859-1?Q?24u1km6ObZ1XfaUpbtL8Ed5T6wVQGXth00fRueJCF3ZBSPLBycvLSyQUXV?=
 =?iso-8859-1?Q?GKN+IXcnpD0t8hL2QhkuKUpakJJdwepT/IZ7ZfQ4+QhCBhvdI9wNdskRyg?=
 =?iso-8859-1?Q?EDbsfKy9dUO+9CytIik9NrslDLP7bTLtG486QhKOciOdc+AgGxhQ+gQ/1G?=
 =?iso-8859-1?Q?L1FWUIFMyK03tGGc+EX8V3sTBSvHf+4kBMk3cCyYoaI+11stEV96tYOUgl?=
 =?iso-8859-1?Q?6FICTZ9G5VoruOheaQTAnZWczkGt0s8bJ9ts7komiteQH8eAmkm1jAT1r2?=
 =?iso-8859-1?Q?BuQpFR6IMifwyXkAPShdh0aIiX16SBEx6W2gTTR4N8p2UliBJMp8enXGVY?=
 =?iso-8859-1?Q?q8f1+jPjBqMElXUCQi2Mfclx4nF+bWBYN7jt1O7Pd2KROwv/i7i93Cx6aV?=
 =?iso-8859-1?Q?gxHz2+GZMyMAhGZq8n/8pTXL4q/R/E01ogudDAK1yn4y2T4bxMFP+I7TMm?=
 =?iso-8859-1?Q?EUDoDncmZzkkbJ2yU0zQWExVL33lqOAQi74myWdxVq9LRLOP7mPrl3k6sI?=
 =?iso-8859-1?Q?z8q3c11YBIImOhVKjVGpF3th/4R1mrWsYEPyVnLX3E+2dc58Nxd/4qWycY?=
 =?iso-8859-1?Q?Pouu+PAaNVLwZBIVYDi4wXDAmNO7pRqvmhQqBmNjYU6pChna/3eBg950DG?=
 =?iso-8859-1?Q?/vRh/o+iStRFbJFxvwKWVRxO63cQ+1CbqVSk+oq22aZo4Rl42H4reTqhRO?=
 =?iso-8859-1?Q?bUb9HSk4rX/9DdHIOVijR6rXmNy/JBHFcBslki1269TrMHSdh2RCou5tvf?=
 =?iso-8859-1?Q?VI25yXyAEIpfNmNKIq9H9J8DMwJcRMg+ZTzk2bC9PiKPajMubHQj5tKzJ3?=
 =?iso-8859-1?Q?3zKcmqbXhjFYvY65eTxpYz99qVMCb4NeSLFMRAN7pDOyf8/LrsIy5pDCrr?=
 =?iso-8859-1?Q?AWRG0qCSHE5C9Vpwxg/RH8k2A/A6im+5eW6uXppQc=3D?=
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 018d1115-993e-42aa-d81d-08dc4f724429
X-MS-Exchange-CrossTenant-AuthSource: DM4PR05MB9229.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 21:58:57.1785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR05MB9144
X-Mailman-Approved-At: Thu, 28 Mar 2024 23:37:58 +0100
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

On Thu, Mar 28, 2024 at 04:02:09PM -0400, Tom Rini wrote:
> On Wed, Mar 27, 2024 at 10:03:11AM -0500, Chris Morgan wrote:
> > On Wed, Mar 27, 2024 at 04:21:49PM +0200, Eugen Hristev wrote:
> > > On 3/27/24 15:32, Chris Morgan wrote:
> > > > On Wed, Mar 27, 2024 at 06:32:06PM +0800, Kever Yang wrote:
> > > >> Hi Chris,
> > > >>
> > > >>     The ATAGS is used for passing parameter from bootloader to kernel at
> > > >> first, which has been replaced by DTB now for ARM platform.
> > > >>
> > > >>     And Rockchip using ATAGs for passing parameter like dram memory
> > > >> size/board uart in different boot process like DRAM init binary/ TPL/SPL to
> > > >> U-Boot since 2018.
> > > >>
> > > >>     And almost at the same time, Simon add bloblist for mainline U-Boot
> > > >> which for similar purpose.
> > > >>
> > > >>     So I'm not sure if this ATAGS should be accept in mainline U-Boot or
> > > >> not, even for rockchip platform only seems some kind of regression for this
> > > >> feature support.
> > > >>
> > > >>
> > > >> Hi Simon and Tom,
> > > >>
> > > >>      Could you help to give some suggestion for this?
> > > >>
> > > > 
> > > > I really meant to do this as an "RFC", so I apologize in advance for
> > > > possibly causing more work in treating this as a full-fledged patch.
> > > > 
> > > > The problem I'm trying to solve is that I've got 2 boards, a Rock 5B
> > > > as well as an Indiedroid Nova both with 16GB of RAM. I noticed that
> > > > without the memory holes the Rock 5B defined in my Indiedroid it would
> > > > also fail to boot. I've got 2 other boards as well with less than 16GB
> > > > of RAM which seem to work fine without any holes (a 4GB Indiedroid Nova
> > > > prototype and a GameForce Ace with 12GB of RAM).
> > > 
> > > Hi,
> > > 
> > > When I initially added these holes in the memory, I tried to ask Rockchip what are
> > > the holes for. I didn't get any answer, however the patches to reserve the holes
> > > were accepted.
> > > If we could get more information about why the holes are there, if that area is
> > > specific to something, or that it's fixed in a per-SoC basis, we could reserve it
> > > by hardcoding in the Linux DT, without the need for ATAGs.
> > > Without real information, we cannot be sure that for other variants of the SoC or
> > > some other bootrom configuration, the holes will not change/move.
> > > 
> > > Eugen
> > 
> > It's not *just* about the holes, but also making sure we use the full
> > extent of the RAM. For example on my 4GB Indiedroid Nova the existing
> > logic ignores about 256MB of RAM that's otherwise present. When we
> > use the existing code the RAM map reported by Linux is as follows:
> > 
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000000200000-0x00000000efffffff]
> > 
> > Whereas when we do ATAGS parsing to set the banks we get the following:
> > 
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000000200000-0x00000000efffffff]
> > [    0.000000]   node   0: [mem 0x00000001f0000000-0x00000001ffffffff]
> > 
> > So basically the issue is two-fold... one we need to create the memory
> > holes when necessary, and two the current method of defining memory
> > banks leaves some RAM unallocated. Parsing the ATAGS does both of these,
> > I'm just curious if it's the RIGHT way or there's something else I'm
> > missing...
> 
> It's unfortunate that all of this is in the wild, from the Rockchip
> side. The best answer is that the platform should be passing all of this
> along via bloblist. I would hope that future platforms will do that. For
> now yes, I guess we need to constrain this ATAG parsing to rockchip as
> much as we can and use it.

Any thought/benefit of trying to force the ATAGS into a bloblist after the
fact (instead of expecting it to be passed that way)?  Otherwise yes I'll
work on simplified ATAGS parsing for the memory info and constrain it to
the rk3588 specific board code/wrap it around ROCKCHIP_TPL present.

Thank you,
Chris

> 
> -- 
> Tom


