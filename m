Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E27109C038
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 07:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FD2A81E18;
	Thu, 26 Mar 2026 08:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GsR6W4+j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B48D83CF3; Thu, 26 Mar 2026 08:42:36 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D99080517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 08:42:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkcsyWgRrww5m0+2oBZnHC8GKbhoYtUTv+5O0K54lEtV15gGIGZHwdmVuw99itnc6YEedyDu7WAlzosjXWXj0R4F7Dqke8ZWi3iUrLO8ERal9vTIhR5N1ZbDKN1I+pFclrINXUEhDxRAOmqSCPc+/QvpvrEF9tPSmackeDND2fHIlJ6i0n1ksidsPq8IfU8tXh3Z2Hs4pceODsOlvXn4d21EF97wdl4RwnVC9/hg+0Vs+aRflR+94FZ+7nQJD+kkGNEHrg03GOD5vn31HvcZnctGgG/6uVlKXoLM6j+lOvaqG3+nHfNYqdCFTKLigdDeho+KHOmZ48cAES8DkEDdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAF12c9lft8weve7PQX1se7SJd2WL1jUeiL44rtUg2Y=;
 b=fpCdYg/KYTIzFSP1SSI8HM7mom1lpD+cuU2j0EYsVbCFtFPdgrVFb57TV1NHncqB9hdzTor76tPlpCleS1Z4NitqMX0RSfPDBRQi4Z6muz0dqMLhp8nb5L0LfM1K9ke0oFP61U9BZW27ta7/5KJIF/jQt/TT2/0phQMHbaBYzuRPkhiT8N3XCeKV2I9elmzybFfX6BYrqZpf4V6WVN7w4eSBa/lt8wSGFYeCda/sHybLu28e604VwqYQ8MtEgDfz7mF7K702/iLZIwU1T5k0yj2BjgJHfxpfT6/2WqVP6CVYV4FFByjat0X2ojA9SjJOL7COqnDLx8+OPjqeYIa+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAF12c9lft8weve7PQX1se7SJd2WL1jUeiL44rtUg2Y=;
 b=GsR6W4+jzCBV2TOLGu5ibXDLeIX0ARPFom8+9kXAh0L3Ko+zF1XXJJ2YoaPOXK8j9RIB9neFVMlSlgY6w7qOfghxcS/IryKTOWFSwKwhQ9FLk0zzbMS1N7wp06HCQunpvU+SYOm5MExCJ4YBMKVwH987w47Y49fBngY7ewOw6c+n6QF4OOaBvs1KymVSgZ30WqsOKU4lQZ5ByT09sea5BAsHrLkjCElenHHAR6QuuN3e6ophVvlE2m/1LAQUAXqFE/xhw+FeV9kJ7RsUvbWokq3FD2K0qa6/z5EIZXyAZ5daIDbMRjIOaRj8rDSHKffIJU/7vxInBo3vvJuKMj5AzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10820.eurprd04.prod.outlook.com (2603:10a6:102:487::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 26 Mar
 2026 07:42:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Thu, 26 Mar 2026
 07:42:08 +0000
Date: Thu, 26 Mar 2026 15:44:44 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Teresa Remmet <t.remmet@phytec.de>, Peng Fan <peng.fan@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Marco Franchi <marcofrk@gmail.com>,
 Alifer Moraes <alifer.wsdm@gmail.com>,
 "Lukas F. Hartmann" <lukas@mntre.com>, Patrick Wildt <patrick@blueri.se>,
 Heiko Thiery <heiko.thiery@gmail.com>, Marek Vasut <marex@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, upstream@lists.phytec.de
Subject: Re: U-Boot and legacy SPL power control on modern platforms
Message-ID: <acTj7FcrX1lfaloZ@shlinux89>
References: <20260320214518.GD502704@bill-the-cat> <acPEoC0W8DJMnYfd@shlinux89>
 <20260325165231.GS502704@bill-the-cat>
 <CAFLszTjJG9Gj7Q+31sypFBRnS3g4NYT+0-t06dxQMsw8ekJMSg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjJG9Gj7Q+31sypFBRnS3g4NYT+0-t06dxQMsw8ekJMSg@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10820:EE_
X-MS-Office365-Filtering-Correlation-Id: 1966926d-2fcf-4de5-d101-08de8b0b2f05
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|7416014|376014|366016|52116014|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZSzAwBnc0pBy3vHKkIKQG2/qpPYKxtKlpJPcDgZrMA2R/FYwy7ZZ0BFh2JsnVk7mP3DQlsvVHaR0oQN2ooe0BD4bnm5c17VQTrQSxFRkwm/nP5ptmsHc8xfzrKVVnf2oXtUb9FsxmWtVaccW4J7mRG09uXvMBkJMfXL6OV0q4YVleE7xGBmWl1Kc/gmvVW2E16x+rMr7iELyliAf5AbOHdq+ROy/ipDYrejupGxZbt6OJo0RY8ELNgRH83EvHllKh04/CP16xAc+smm1eRXyk0IgdBmk1ZxoauDfD++OctfhtQFmEtd4CyCEOai2PTfZv7z9ylCxKV7/YLsOOY/HQGHSQpiGYWvJdTkCMiIiW2NULGp7TQqjRP38pIhHOIgOq2x+UvzExovyF05njmiAXhVHKCQ/q+eHspDBA61tsC9xOAbrrjTV1OSz7lsCMEVjm2sbdhTz1KUxB7oj89AOU/Z9KBTfDOmu4wTahF+HJLTJrIPA/4zbtyC82psgNBIT7c9DoOKfFg4ja/cQs/04Xj1b/PS422gJj6U/izo65hZvd/IMGD10zv0AfvnYejET0d1dNZH+Ux2Ec+Gf0n5ymkowRb5oSLEJs+XHYmN2CqJWV952frA7Nx1PSdk85kVYs7LRlQ+1jJSUwmjPEarpcet62ly3grmDxpK1g3SQDyxRcKhK9F3H7l488tdwp4+CR8GWJNoSVh0eBMW07aK4KtjkqfUt/n0opSMOxHIIvQIjek7lAjM0+oJOIdHtrXuf/oDBk7Vh2Zln7/Dr+yfAU7f5gLGYk92Kk03sZ66Jjyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(52116014)(38350700014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c2IYA9Zl6zfHulhFqYNgsEAQeuX1qcw2MWjAPuKyUJg8F0LF/0J3I9mn+Gii?=
 =?us-ascii?Q?gRAjYgbR3xpLKZhIELhp3mlE54yVObPPfbNnBROkYJ69BEdyY/RCGcTx2aqL?=
 =?us-ascii?Q?WPvKveH+zuINiG24CWuW/TpoZhzVGOWLsAuREpD61Ttk8xlviqRJ3ITa3Skf?=
 =?us-ascii?Q?P8lod2UmtzKwMJ/p+7v2Y9aRo1PoL1cqXS+O7Tk22LIztO0P3cX37IB4qiKE?=
 =?us-ascii?Q?JZiyn81SBUs17LtnWCJcCPz7UDtahMJlO22ojU0QuubQIB/qehRnw/shPLzB?=
 =?us-ascii?Q?C2oDNW2BuN6EzuoYYVbzG84t+oJEFvedzP+1Mqv48Ijnp/1dZnUYCw7igSta?=
 =?us-ascii?Q?++VbYABEAGcgY8p3OUtmPQwtoxtflCMrfCRRb2uDcBVw6/87uIKwqS7MlsN1?=
 =?us-ascii?Q?pQnV09WPPXHWqZOT7goMyfi3JZcplDQ0TAbuTgeZIT3kIYgAnGMXzDP00Lmz?=
 =?us-ascii?Q?FCkM1gV3r79nsfHJPWr1yVxJSq4HjstQm0hacy17tls/i5y/EaaJtXER1ktg?=
 =?us-ascii?Q?L1pKt6cDuXW9mYLiQ67AeY5f0bPNn+IBKqYKjZmi3HYSPNO+ezCc3TUJehXD?=
 =?us-ascii?Q?N7DknfHVFZFX6RKCUCoFSsv2UdYQnSplgHlCQhZbttPjqpyz1bA8pncC1v8z?=
 =?us-ascii?Q?zxnEotYwBBmpTR6yoJSDw2OEwinP6zuIqTzeWylBSxX2nr2vLUmHMZ8VMaql?=
 =?us-ascii?Q?HQ8s+zan+T+BIEEAN+ZmU+5MYVwC877HUfbDhkoM+LwHLePXmFkLd2fNk1rM?=
 =?us-ascii?Q?S5JllBvxfBH5tJUaV4H++xPd+wzGOlmGvmD4cb4t8zVP0r2i76CeTjbhLtQH?=
 =?us-ascii?Q?TA0cVtr7Uq9rLKwvEI6B+WLNl4679geRPAVkbexnM881dCsQiSGBQ04To4Nv?=
 =?us-ascii?Q?m1EdlKHZdQGQMlgpt/NafYMI/sx7EHGkGYS1PfRChpW87H2+ZgALM2d3gQQf?=
 =?us-ascii?Q?peyfGvFTsf6uIb6K0+cr7rmWM+9S9EK3fLomW9+y/cVQDjlCOCK83icL/kjs?=
 =?us-ascii?Q?H2PRQx4ue53FxSJjoq2sZwFYbPyDe38ZeXpGKyYlmWVidIz25gH0Bug5nr/y?=
 =?us-ascii?Q?dPMzZMsKt2ALhaIpj3HzcRnV9vIB1NvQuiCWGFRFm92J2uh4VcVVvUrlIXao?=
 =?us-ascii?Q?2DqKP7fMw02748fnUOj+YzJ8Z6ce5zG/ok9ohDqDTkxtEGj0URKr775eWZXx?=
 =?us-ascii?Q?nOB4poFGYUlK0xKk6msWdXR9FjXRRjw2itAgb2NA5S8f8X4jvEkhtRoa5mVl?=
 =?us-ascii?Q?JjGHpZL+JTXa18D6or0ns6DuXu29SN2zBcZ1K2VOHhN8BEYNN7pChMki/Ce6?=
 =?us-ascii?Q?ymQCJTYP1uPTSPTkkbdfSGWWzfjCiaepQFpFAlxqMrplXSmC4zPRugwsJri+?=
 =?us-ascii?Q?8Htk9dBMYcy5/tz1uNOi3vb8s/H1n9X2HGNiJhjEDEfpu0355u9sNONBPGJX?=
 =?us-ascii?Q?XAnzvs7IwLyWWvwxqiQJNnuEVHTdMRap3cWFSw+dJVYVdQQhlRkau6bQgzZS?=
 =?us-ascii?Q?n6WDgDGsNKskDszqmvOnxMFOefSwB4olPSYltazv7JTMOUN4oVR/u97RVuEm?=
 =?us-ascii?Q?0t22du0mH5/R3aqZ898gh03R+X5fzEv9GKsVAuD9CmGnPkZs83eTgjBKiySy?=
 =?us-ascii?Q?VfpbrhVzFqlNkGolvbkHQnQA8UICtvUKIc91QwAtE58ccXiMM/l6LhW1ieNa?=
 =?us-ascii?Q?n2XvFuX7lTftpIVzsDP0TlWKt8Kew95djbnLEkS2qnEI3QswiDvh4fnJ48M2?=
 =?us-ascii?Q?XDhVJyfS7A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1966926d-2fcf-4de5-d101-08de8b0b2f05
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:42:08.7084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JptvZTljmAlxSxI9cBfUatFVWNR9KjiCMpVoxuaAS9VL75nMj3RWc/kN63l2UjR7kZ2yd/nP0Ahm4HNUgDIDWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10820
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

Hi Simon, Tom

On Wed, Mar 25, 2026 at 11:56:25AM -0600, Simon Glass wrote:
>Hi,
>
>On Wed, 25 Mar 2026 at 10:52, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Wed, Mar 25, 2026 at 07:18:56PM +0800, Peng Fan wrote:
>> > Hi Tom,
>> >
>> > On Fri, Mar 20, 2026 at 03:45:18PM -0600, Tom Rini wrote:
>> > >Hello,
>> > >
>> > >As part of the work I've been doing on clarifying Kconfig dependencies
>> > >I've stumbled on to a number of modern boards[1] that are using the
>> > >SPL_POWER_LEGACY symbol. Can the maintainers please update these to use
>> > >DM_PMIC, DM_REGULATOR (and SPL variants) as needed so that they use the
>> > >modern architecture, or let me know what's missing here? Thanks!
>> >
>> > For i.MX8MQ, I think we may need to leave with SPL_POWER_LEGACY,
>> > the board has 256KB TCM, but u-boot-spl-ddr.bin is almost using all
>> > of them if enabling SPL_DM, other SPL_OF_CONTROL and other DM drivers.
>> >
>> > u-boot-spl.bin itself is 90KB+, but ddr firmware and hdmi.bin are packed
>> > in u-boot-spl-ddr.bin, the image is a bit large.
>>
>> Ugh. Does CONFIG_SPL_OPTIMIZE_INLINING=y win us enough space here to
>> matter? Changing CONFIG_SPL_LOGLEVEL rarely is enough of a win to
>> matter, so I don't think that'll help. Turning off CONFIG_MMC_VERBOSE
>> sometimes helps, but only a little.
>>
>> If we really can't make it all fit, then renaming some options needs to
>> be done once we remove the legacy portion from full U-Boot (of which
>> there's a much smaller number of semi-modern platforms enabling it).
>> Thanks for checking on this.
>
>It is pretty ugly, but there is of-platdata

I will give some try to see if we could save some time, whether using
of-platdata, turn off mmc verbose or else.

Thanks,
Peng

>
>Regards,
>Simon
