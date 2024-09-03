Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115CECD342A
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 08:04:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AEFA88AB1;
	Tue,  3 Sep 2024 10:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TzvGR8p+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C51088C40; Tue,  3 Sep 2024 10:04:56 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E419F886A3
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 10:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3F0A65C5755;
 Tue,  3 Sep 2024 08:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7181AC4CEC5;
 Tue,  3 Sep 2024 08:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725350692;
 bh=w6SOgSw+eI2lwG2oosmllYzSYwMKC5orNjA0/0uVEHU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TzvGR8p+PRrVxI6DVDMN4U9tTSmma0zaR0vVo517pHa7iv11I5ACxlYhmfpsbasff
 /P5KSxGyT0rk8pGe6NQv+w+0PYPnmkgHSQi0v5hh54rYzFLhVL1d2LjmzvCzYjMjZd
 CZ6zdKS4ul3pjNHvK4sKp5ZI9MU1A1oskRDicerlaXF9Z+ew+no6ZoMxde20YTjt93
 rYbc/HFGz/nXxoTsn+K4t1p5+hmDlKekiLbhWSlGJv/bVxGGFXmQdzGpp0W4Y0j+xn
 M3ZpPxXXsZH7p9DeLptEYY8kBttquY4EF50g3mMuCuZffU5/j9FjdSFmHVsnoR5kNb
 hDJnwDmYM9QQg==
Date: Tue, 3 Sep 2024 10:04:48 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, u-boot@lists.denx.de
Subject: Re: [PATCH u-boot-marvell 2/3] arm: mvebu: turris_omnia: Use the
 i2c_eeprom misc driver for EEPROM reading in U-Boot proper
Message-ID: <auikzq2r2eprb5u4hh4m6jgqsb3mzz3gznxcp6soldhu474r33@zryqeni47zju>
References: <20240829080849.20276-1-kabel@kernel.org>
 <20240829080849.20276-3-kabel@kernel.org>
 <acfd0636-8132-4fa7-91e6-af78a6fdbeec@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acfd0636-8132-4fa7-91e6-af78a6fdbeec@denx.de>
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

On Tue, Sep 03, 2024 at 08:57:24AM +0200, Stefan Roese wrote:
> On 8/29/24 10:08, Marek Behún wrote:
> > Use the i2c_eeprom miscellaneous driver for reading Turris Omnia EEPROM
> > in U-Boot proper. Keep using dm_i2c_read() in SPL build, since adding
> > the i2c_eeprom driver to SPL build increases the image by 1.5 KiB.
> > 
> > Signed-off-by: Marek Behún <kabel@kernel.org>
> > ---
> >   arch/arm/mach-mvebu/Kconfig              | 1 +
> >   board/CZ.NIC/turris_omnia/turris_omnia.c | 9 +++++++--
> >   configs/turris_omnia_defconfig           | 1 -
> >   3 files changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> > index 4a8328760eb..c1a1a333e6c 100644
> > --- a/arch/arm/mach-mvebu/Kconfig
> > +++ b/arch/arm/mach-mvebu/Kconfig
> > @@ -149,6 +149,7 @@ config TARGET_TURRIS_OMNIA
> >   	select SPL_SYS_MALLOC_SIMPLE
> >   	select SYS_I2C_MVTWSI
> >   	select ATSHA204A
> > +	select I2C_EEPROM
> >   	select ARMADA_38X_SUPPORT_OLD_DDR3_TRAINING
> >   config TARGET_TURRIS_MOX
> > diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
> > index 392df53a6d8..46f20f05c05 100644
> > --- a/board/CZ.NIC/turris_omnia/turris_omnia.c
> > +++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
> > @@ -23,6 +23,7 @@
> >   #include <dt-bindings/gpio/gpio.h>
> >   #include <fdt_support.h>
> >   #include <hexdump.h>
> > +#include <i2c_eeprom.h>
> >   #include <time.h>
> >   #include <turris-omnia-mcu-interface.h>
> >   #include <linux/bitops.h>
> > @@ -473,9 +474,13 @@ static bool omnia_read_eeprom(struct omnia_eeprom *oep)
> >   	if (!eeprom)
> >   		return false;
> > -	ret = dm_i2c_read(eeprom, 0, (void *)oep, sizeof(*oep));
> > +	if (IS_ENABLED(CONFIG_SPL_BUILD))
> > +		ret = dm_i2c_read(eeprom, 0, (void *)oep, sizeof(*oep));
> > +	else
> > +		ret = i2c_eeprom_read(eeprom, 0, (void *)oep, sizeof(*oep));
> 
> So whats the advantage using i2c_eeprom_read() here in U-Boot proper?
> The only thing that stands out to me is that the code get more complex
> because of the SPL/non-SPL distinction.

The reasons are as follows:
- it's "more correct" semantically

- the i2c_eeprom driver was already enabled for U-Boot proper in
  defconfig (with this commit selected by the board), because of the
  `eeprom` commmand, so I thought "why not use it?"
  (looking at the code now, it goes
     i2c_eeprom_read()
       dereference of i2c_eeprom_ops->read method
       i2c_eeprom_std_read()
         dm_i2c_read()
   so the complication is trivial, IMO)

- the following commit adds code that writes the eeprom, and this cannot
  be done with simple dm_i2c_write(), because each eeprom page has to be
  written by another transaction, which is what i2c_eeprom_write()
  does.

  So I knew that I was going to add i2c_eeprom_write(), and I thought
  that it would seem weird writing with i2c_eeprom_write() but reading
  with dm_i2c_read().

Marek
