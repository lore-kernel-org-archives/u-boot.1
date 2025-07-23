Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B35FC83F34
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 14:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD39E834E1;
	Wed, 23 Jul 2025 16:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAFAB83523; Wed, 23 Jul 2025 16:20:03 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 62BC0833D0
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 16:20:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78D8722C7;
 Wed, 23 Jul 2025 07:19:54 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FADE3F6A8;
 Wed, 23 Jul 2025 07:19:59 -0700 (PDT)
Date: Wed, 23 Jul 2025 15:19:56 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: ZHANG Yuntian <yt@radxa.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, Paul Kocialkowski
 <paulk@sys-base.io>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 20/20] sunxi: A523: add defconfigs for three boards
Message-ID: <20250723151956.4468eeb1@donnerap.manchester.arm.com>
In-Reply-To: <20250723110948-GYA737651@gentoo>
References: <20250717235455.32528-1-andre.przywara@arm.com>
 <20250717235455.32528-21-andre.przywara@arm.com>
 <FB02908DDA84032E+c84dace3-80fc-466b-9fd5-aeba22192ed2@radxa.com>
 <20250723110948-GYA737651@gentoo>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 23 Jul 2025 19:09:48 +0800
Yixun Lan <dlan@gentoo.org> wrote:

> Hi Andre, Yuntian,
> 
> On 17:18 Mon 21 Jul     , ZHANG Yuntian wrote:
> > Hi Andre,
> > 
> > On 7/18/25 07:54, Andre Przywara wrote:  
> > > So far developers seem to use three popular boards:
> > > - Avaota A1: dev board with USB 3.0, dual Ethernet, small display
> > > - X96QPro+: TV box with Gigabit Ethernet, USB 3.0, eMMC
> > > - Radxa A5E: small dev board with USB3/M.2 2230 (muxed), dual Ethernet
> > > 
> > > Add the defconfig files for those boards, containing the DRAM parameters
> > > and the usual Kconfig options.
> > > 
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > >   board/sunxi/MAINTAINERS         | 15 +++++++++++++++
> > >   configs/avaota-a1_defconfig     | 31 +++++++++++++++++++++++++++++++
> > >   configs/radxa-a5e_defconfig     | 30 ++++++++++++++++++++++++++++++  
> > 
> > Can we name this radxa-cubie-a5e_defconfig? We will have a few more 
> > Allwinner offerings under the Cubie family.
> >   
> 
> while I personally do not have strong preference, adding 'cubie' is
> slightly better, it will help people to better search the product
> , also to match up the silk name of the PCB board..
> 
> to be honest, I don't mind to have a long name for the config, so
> even radxa-cubie-a5e-a527_defconfig is ok for me (which similar to 
> the style of radxa-zero-3-rk3566_defconfig)

I will just go with radxa-cubie-a5e_defconfig.

Thanks,
Andre

