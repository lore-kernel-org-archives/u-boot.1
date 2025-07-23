Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8665BC83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 11:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A86D683429;
	Wed, 23 Jul 2025 13:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7795F8349B; Wed, 23 Jul 2025 13:10:07 +0200 (CEST)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EDCF83439
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 13:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [116.232.48.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 290EA341436;
 Wed, 23 Jul 2025 11:09:59 +0000 (UTC)
Date: Wed, 23 Jul 2025 19:09:48 +0800
From: Yixun Lan <dlan@gentoo.org>
To: ZHANG Yuntian <yt@radxa.com>, Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>,
 Paul Kocialkowski <paulk@sys-base.io>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 20/20] sunxi: A523: add defconfigs for three boards
Message-ID: <20250723110948-GYA737651@gentoo>
References: <20250717235455.32528-1-andre.przywara@arm.com>
 <20250717235455.32528-21-andre.przywara@arm.com>
 <FB02908DDA84032E+c84dace3-80fc-466b-9fd5-aeba22192ed2@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FB02908DDA84032E+c84dace3-80fc-466b-9fd5-aeba22192ed2@radxa.com>
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

Hi Andre, Yuntian,

On 17:18 Mon 21 Jul     , ZHANG Yuntian wrote:
> Hi Andre,
> 
> On 7/18/25 07:54, Andre Przywara wrote:
> > So far developers seem to use three popular boards:
> > - Avaota A1: dev board with USB 3.0, dual Ethernet, small display
> > - X96QPro+: TV box with Gigabit Ethernet, USB 3.0, eMMC
> > - Radxa A5E: small dev board with USB3/M.2 2230 (muxed), dual Ethernet
> > 
> > Add the defconfig files for those boards, containing the DRAM parameters
> > and the usual Kconfig options.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >   board/sunxi/MAINTAINERS         | 15 +++++++++++++++
> >   configs/avaota-a1_defconfig     | 31 +++++++++++++++++++++++++++++++
> >   configs/radxa-a5e_defconfig     | 30 ++++++++++++++++++++++++++++++
> 
> Can we name this radxa-cubie-a5e_defconfig? We will have a few more 
> Allwinner offerings under the Cubie family.
> 

while I personally do not have strong preference, adding 'cubie' is
slightly better, it will help people to better search the product
, also to match up the silk name of the PCB board..

to be honest, I don't mind to have a long name for the config, so
even radxa-cubie-a5e-a527_defconfig is ok for me (which similar to 
the style of radxa-zero-3-rk3566_defconfig)

-- 
Yixun Lan (dlan)
