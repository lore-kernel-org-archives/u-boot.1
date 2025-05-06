Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D1CC3ABBC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 07:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 441A08007D;
	Tue,  6 May 2025 09:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="O0FBSjTj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5459E82076; Tue,  6 May 2025 09:30:20 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99A2880050
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 09:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNhmWpmYgSC3SPzh9ATRghA3qMG1cfcjlKom0dH/twwU6heyoBPM3bdGNDnFrDfI5v5+16Oa026TcLOzZPNMAztFl7l7mL90sbd/J0sFsg0n2HhbJ99YXV4a3IHXEThy24a0RPdXW3fbSmSF36Hd1Lhk/5EOVi2G1k1r9HMPg1+AaCX24C+HjGCRrs9L0A6ji5AIzoh6TPGl4drZtNyl7CKmy0gjbJniMYiTpxNiUCPL5I3t41eVY8ex+ELlMnQOWnwBb3YxSO5rh3IBmCWKpzqT8Z0pIfCJMwvgQ1Msh9f1DmnnAZPQrstBdcKOXQi+98qO8p7aYmkbinRJ2aiypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRxiNGNRfI9/KOVeaYbH0lV5CzZKqSOt7XDYMWzUwRk=;
 b=gK0YWaS5Z3Eya/3kjqFhRb6DgIAv+Z8arb2iV4yoImKp5olkDsITkLeSNQiIzwSZhHnEI2j6g5q7jc4MgXdVgrM60FCkQgwIc2qBXjOL7xEtItRvxfE7sjjDIls/e95k6fdFvZbG2s4l3hf6tXeSTCpfI7lZGu8enD0aPvznFyT7e5jCcslfEtW/y2q7kie3+JVPWfRtjUpjB7QaH4Yyh3YPHed5q6tZvGEyxW/zeZfZb0WB+aSN4Hbt7sQh3Sn944fLF5F4e6k36MwNvgqwXP3A72MlnuqVa1BEHz0leVrdjOxbn26mxOrzkySifMtZqp4r2OpqtRi/vC/E0y0puw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRxiNGNRfI9/KOVeaYbH0lV5CzZKqSOt7XDYMWzUwRk=;
 b=O0FBSjTj3JDEMX+xgpEh8Apavl2IfLBwzHbUAp2ZjuGOgSdJQcrf6+MZTBJ62NNONW6o9pQhxe4x87AgifDifpdXbv+Q4ngVjDQEsVawclyTFAG37fZvkQFIfajsq4dBpfAncjcOtH/gV5J/+MCiC2q+wzMnxelGM7r3UNBYu5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ca::21)
 by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 07:30:14 +0000
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769]) by DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769%4]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 07:30:13 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Tom Rini <trini@konsulko.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>,  brunosampaioleite@gmail.com,
 u-boot@lists.denx.de,  probinson@gmail.com,  mbrugger@suse.com,
 clast@prevas.dk,  brule@prevas.dk,  pbrobinson@gmail.com
Subject: Re: [PATCH 0/2] Add rpi5 specific defconfig
In-Reply-To: <20250505212816.GP5430@bill-the-cat> (Tom Rini's message of "Mon, 
 5 May 2025 15:28:16 -0600")
References: <20250502113556.134731-1-brunosampaioleite@gmail.com>
 <20250502144031.GT1261075@bill-the-cat> <87frhj5r32.fsf@prevas.dk>
 <20250505134843.GK1261075@bill-the-cat>
 <87zffq95f7.fsf@bloch.sibelius.xs4all.nl>
 <20250505212816.GP5430@bill-the-cat>
Date: Tue, 06 May 2025 09:30:11 +0200
Message-ID: <878qna5h8c.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0016.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::29) To DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8248:EE_|PAXPR10MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a5bf9c-dc58-43fb-b3fd-08dd8c6fd745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XsPdDkWncKnG69EF6w6yDVA3T4Xpn1mgusmVzTqdqdcUvqtfDbItKgOUFTmD?=
 =?us-ascii?Q?mDqeJFJAc4Hnp+Gf+URDbsmoHoCdssLJpuTPc9XNhhSQgVZLqiE9oSI8+qvV?=
 =?us-ascii?Q?e1TbRAXDQwD05xClgz1fs92WMVjYbbz6jgCEq5qzVk9jwZBDNhFiCKwOtftd?=
 =?us-ascii?Q?1tFNgOhK0mWEQoMG3ICpbhlsQk2rCcWNM/xJooOoFNAH9tKQz2TPe+2pMqNT?=
 =?us-ascii?Q?8Ryq6mF2p0763sJEOlVsuQkAgB+7yNIjpwBeUiLkZPOLNe3/CIqTyZGIXLok?=
 =?us-ascii?Q?nc6sfe7S+aZJZu0s5Zv0kcgbZTeP1vjf8V1n3d6RmW93PcQ25We84CbbofTm?=
 =?us-ascii?Q?iTteJkpw7mLRjNdoSyLH9Z1/4UabTCdngeMEYfJOC6sTOQVfuwfS+5fEYGrf?=
 =?us-ascii?Q?dd64ssx/5SFG7u5P8ixMcaSJJJSKgMnoYqoBbRAyouQDXGYSNR3EhBWBZs77?=
 =?us-ascii?Q?9Mf0XtbQgaalT8bZj4QHovHKNybi1JPJvvRJtC5RoplcvheSQjQpynmfG+AU?=
 =?us-ascii?Q?12fQ0+EJhVHgZ5Y6xfTc+hr3PlMydQDIleh5DAGcSXO5ETR2e38Tgb2mVRBF?=
 =?us-ascii?Q?sCz7rfGAj7QhcJnXkrJuf7fWsz+EjaHapXWCY8maapeoT2Is4XTpAOuGsaXt?=
 =?us-ascii?Q?BsjgW8/661pblk9nbaP2axgo4GB9ljR3V/ZwmAmGkqXzUiRZteivfE7s9VPD?=
 =?us-ascii?Q?plAbpS9aSa7toa26iZMvHzeE6TCl0GZWKNeR/qPQNzyFUCFuNXXy6JOe7DWb?=
 =?us-ascii?Q?X838+TAFANZ70Th4TfKqcBgajrrv/ML7tb9UhGvj82qiXiqvLtUQbI7Qcl6C?=
 =?us-ascii?Q?9/fzE50HbeQcG9UvnBgQfDjQllUReEOO81XV85suFwZQEdUnDfzAzM4SuGez?=
 =?us-ascii?Q?HWLBzL9Sovuy2CJjpxw/7OM5OflARC7rJrqLSNiXqzsp6p+obQQgtjUdiuHi?=
 =?us-ascii?Q?vTJdkkSREQ6wrkcey0Ig46LQc6s2tskycnEgjyU5Lsc2YEYIeN+rVy52JPMH?=
 =?us-ascii?Q?g2cY/bAN+4HNfm6rFKfiQU1/Sn5Yk22BE44t+PN0cht1tlHl4D0riih7jaH4?=
 =?us-ascii?Q?iNHa1/ESjWRbAbuDGHo5f9JdkVYbNXcTIBwpwtKzl2kZs8VQagNzTO3XyMpR?=
 =?us-ascii?Q?EvkzXZnQKBX090DyvyvGmEi0hHaUEp0jS+/fl9c6beVf6uKKATFOhH90en7q?=
 =?us-ascii?Q?07nU6PBP1nzYd8Z5CAiojFMMZSzkWt2/Hl0OagXWUEKUkVMZ65OmSSzsu4Z0?=
 =?us-ascii?Q?S0pU6wjczOL4Pdf61BZcwXS/Isr18kMq8wDJNyX4XEPEtpBvvncHCRiL6Ksu?=
 =?us-ascii?Q?zPIga2MfVKa04J2zK558ECmw55f4HC8G1PyYEcGNqYQRbVXmVJwA4Bdqo5ze?=
 =?us-ascii?Q?VCqEqmu/hMv1srWO/FWqIUWixRTvEQtwrvggM3jviJyM/EhH0/26GLqqz4ID?=
 =?us-ascii?Q?N4J/SfZ9sBQIbcBRXHqOqGtg4oUm02A7j4Iq87pd8bm9nVFalNubzQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xYHg1956KOH+JtdkXpAe8us6EI0BDmTUt2KJgc50s+uVhzmj4M1WPdw36Coc?=
 =?us-ascii?Q?GKipA+Q0/qTMKCuC0s7C41jUbauPf0WcnWD+EMvDtf1BqhSLuQhAG4m4ZkJK?=
 =?us-ascii?Q?hNOM4OntUTkL3dkEA5i6qSFdR/ZrRmLdlLtSmDZdlwlhtW0IEQ5iSypXZdgd?=
 =?us-ascii?Q?UW/HG3gnNVE0M01rGND02S5vr7f27GbzhnM/JYqm1Qplcy4n8xB/VpBq7B6H?=
 =?us-ascii?Q?9nAj/ReNv9S8BxE4O2D3Ta+Bg+DQKaHNqLwyhqjGmid5qLs8NTJXYg2iOdko?=
 =?us-ascii?Q?c7uVJiDD9y4l/m4tepegnArnHq5hb0fPcQsxEA1uFPSH5VpFBwek7hZlLC81?=
 =?us-ascii?Q?9z7kqhMmvLHt71APQj+uHeYDOKs69+0kihFPIewAVpf2GCoALgpsefMsCMfO?=
 =?us-ascii?Q?cgwsakgYTKVGrLK2a03aNXMMJzq+b65qxQXFHI6cMa6pQOYsFYLc7kOCUJ1S?=
 =?us-ascii?Q?JZfzEDEYyTYWc7cBY5Ykw1L80EZlLyf1l25ydJxT2wRa16q3+6ENT0N1jcJC?=
 =?us-ascii?Q?rHXp2Ky4oH2ZendtYNJFi1nd5fXlrIG75p3y/Fr9FW9j2DuSWFkLBMyDa9y6?=
 =?us-ascii?Q?3/ImWk1VOwN89TxzhBYLSlKfNKo5TBlPybOy8c3aVMPUizKfNxuD9O/REbKT?=
 =?us-ascii?Q?3godrIAeroR4E/D1cNxVTFwWN9XUhNAwWm67j9GD6NlU1InLfeYA7q1+Wdi+?=
 =?us-ascii?Q?Fw1qxELFLucFWSiksRPFtis608Jfbh6S6A2FyddGAhFeHo0emmhr0gtG1F/Y?=
 =?us-ascii?Q?3QhoArfjiwoAeRBxI5pqjOrW7RP8bbvFqq+IFObJqrfLbRWb6QmsHJMsRC4n?=
 =?us-ascii?Q?AA6qauUSKT0N1ZbGKULJ6DfiRecUZQEbrIZbZWaJzjNn26Mma/sGcwDtxSMg?=
 =?us-ascii?Q?p8GmHDL8ymX9LM6ynHpcMZLQg7HS/+MPvrF337hPCTzIwQSh3iays/O70+X4?=
 =?us-ascii?Q?RUzedZt1ODfpWzBgfyxVDq3du8R0T1AHcPg0rSquhDeRaJwRpKaDUfd20tEU?=
 =?us-ascii?Q?9hXFK9J0B2TtxprGqaWOziBcxyPGhUrgFATbBxv8Xv9s0d0glDg2wHOMCxJp?=
 =?us-ascii?Q?9R6DnH/CnLIkb/YvaD0OO5XgomYOoxdJb6GnBHHosThVO77hI0MWgtXbyFL+?=
 =?us-ascii?Q?KdJJm8tYTSaAeOEYAXxUpqjx4CsZhC4HKdGtGWCwlVIQ+cbHglAm3cSyuocu?=
 =?us-ascii?Q?FxU96WMFxfUaaqybXc93We5YmMUA46f/qctIoqEsc3Wmr++qQGw3mJ7/IVDE?=
 =?us-ascii?Q?MCIPL0VIFNEpoIIY/WRgjA82opppuMFChiTOIoT3OygnrZ6SqK9lZ+/s6MiD?=
 =?us-ascii?Q?bPAVXNyDKFBjPZEIn1N5e/Y8nYx9WwL4ya9yys/ALiH97WcBgSpYMhejg4Gt?=
 =?us-ascii?Q?y3TY8M6zag0QsXttDrmo67ElfjKVDLbrnye7a1JJPfldW9VzRGkqY+z/D+iQ?=
 =?us-ascii?Q?5q1wG9RVdimZ5H1O9J/F93kTGhcCVvreiuqt+cKTpqK3E1+JvAvjG2R984Br?=
 =?us-ascii?Q?692cIm9NRomi0QktcAnQ7nKmlf1t+T81ooMGQbSTr4G/rSagCZnmoutH7P7s?=
 =?us-ascii?Q?lDBK0Qybx9FRdsDK37qk3XFPkxwIxw1D3w907ZuSb9UrsPzV3grdaL/X0xxq?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a5bf9c-dc58-43fb-b3fd-08dd8c6fd745
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 07:30:13.9036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dEmE397FdX1AggCZRbW4prSQ+3/O57n0sfLBwGGV/n/diMUFmUkerTo9ZA8oUQMH3mu0VDZN8CTlQYQfurJrFZMtD5Y/7n5pITTd6hfdWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5712
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

On Mon, May 05 2025, Tom Rini <trini@konsulko.com> wrote:

> On Mon, May 05, 2025 at 10:19:24PM +0200, Mark Kettenis wrote:
>> > Date: Mon, 5 May 2025 07:48:43 -0600
>> > From: Tom Rini <trini@konsulko.com>
>> > 
>> > On Mon, May 05, 2025 at 11:45:05AM +0200, Rasmus Villemoes wrote:
>> > > On Fri, May 02 2025, Tom Rini <trini@konsulko.com> wrote:
>> > > 
>> > > > On Fri, May 02, 2025 at 01:34:33PM +0200, Bruno Leite wrote:
>> > > >
>> > > >> From: Bruno Leite <brule@prevas.dk>
>> > > >> 
>> > > >> 
>> > > >> Currently rpi5 uses a generic rpi_arm64_defconfig file that builds rpi4
>> > > >> devicetree. Add a defconfig that is specific to the rpi5 building the
>> > > >> now available upstream dts for that board. The defconfig makes use of
>> > > >> defconfig including that is now available and only changes the DTS
>> > > >> related config.
>> > > >> 
>> > > >> It is also necessary to add a more specific u-boot.dtsi to rpi5, since
>> > > >> due to the ARCH_BCM283X config it will try to build the
>> > > >> bcm283x-u-boot.dtsi and break.
>> > > >
>> > > > My question is, can we not adjust rpi_arm64_defconfig to be generic
>> > > > enough and not have a problem on Pi 5 due to the default device tree?
>> > > 
>> > > Not really.
>> > > 
>> > > What we want is to have CONFIG_DEFAULT_DEVICE_TREE to point at the
>> > > rpi5's .dts file, because we really want to build that and not some
>> > > "random" dts file that doesn't have anything to do with the hardware. I
>> > > know that kinda works for the setups where the .dtb built in U-Boot is
>> > > not used for anything, but in our case, we really do want to use the
>> > > .dtb from the U-Boot build - we inject various U-Boot specific stuff via
>> > > the EXTRA_DTSI mechanism, e.g. public key for kernel verification.
>> > > 
>> > > And due to CONFIG_SYS_SOC being bcm283x, and bcm283x-u-boot.dtsi
>> > > referencing nodes that simply don't exist when building
>> > > bcm2712-rpi-5-b.dts, the build breaks.
>> > > 
>> > > Perhaps the real problem is CONFIG_SYS_SOC being bcm283x for rpi5? I
>> > > don't really know why rpi4 is both bcm2711 and bcm2835 and what the
>> > > difference is, but rpi5 only seems to include a bcm2712.dtsi which does
>> > > not include further dtsi files.
>> > > 
>> > > If rpi5 has nothing to do with bcm283x, then perhaps a better approach
>> > > is to ensure that CONFIG_SYS_SOC is bcm2712 when building for
>> > > rpi5. Something like adding a CONFIG_TARGET_RPI_5 choice and adding a
>> > > 'default "bcm2712" if TARGET_RPI_5' ?
>> > 
>> > OK, so I guess my next question is, is rpi_arm64 useful enough in the
>> > end for Pi 3 and Pi 4? I would have expected that it doesn't matter what
>> > tree we build in to U-Boot as we would be using the one passed to us by
>> > the prior stage firmware, and then update that at run-time as needed.
>> 
>> Works well enough for us on OpenBSD.  And it would be nice if
>> rpi_arm64 would work for the Pi 5 as well.
>
> But that gets back to my first question. Can we correct the code such
> that we do whatever is required at run time, as the previous stage will
> have assembled and passed a correct device tree already?

I think this is sort-of asking the wrong question. The problem is not
about what dtb the prior stage hands us or what to do at run-time. [*]

The problem is to have a defconfig that will compile
bcm2712-rpi-5-b.dts, as part of the U-Boot build. As I said, it's quite
likely that rpi5 isn't at all a part of the 'menu "Broadcom BCM283X
family"', and it's the CONFIG_SYS_SOC="bcm283x" that prevents
bcm2712-rpi-5-b.dts from being compiled (because the bcm283x-u-boot.dtsi
doesn't apply to that .dts). Bruno's patches achieve that by adding a
more-specific -u-boot.dtsi file (it doesn't seem that we need any of the
bootph-all settings from the bcm283x.dtsi file), and adding a defconfig
file that is based on arm64, but just changes the dt settings.

Those who simply ignore what .dtbs are part of the U-Boot build and use
blobs coming from elsewhere can probably use rpi_arm64_defconfig as-is
for rpi5.

Rasmus

[*] That's mostly a solved packaging problem outside the scope of
U-Boot itself: Just put whatever .dtb one wishes the prior stage to pass
to U-Boot along with u-boot.bin in the FAT filesystem, and put

kernel=u-boot.bin
device_tree=u-boot.dtb

in config.txt (sure, there might be drivers that need updating to take
different compatibles or whatnot into account).
