Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8764BCDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 04:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B83328460E;
	Wed, 24 Jun 2026 06:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="iwOxeJdI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C43F184671; Wed, 24 Jun 2026 06:36:23 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E86F80287
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 06:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1782275776; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Tms2lkoWTSXQzMSPklEzXK4sk812N5XcbnvskJoj7HfGYpeDVbv1NPpC2StaKwhXHw0teFhgH6sRwLSXco4E5u2NC5ZL9Ww4Mvf14b7CNJaJyq0BZEL11HOHe+VH5PZImkx0zfU1qJ2k27hBNYPXB63L5SHm65mzuU7PzdBGnAk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782275776;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=IGIj+9B7jK9ecHn7547L0AcGcx1FgaoKPCAYTfqSdEA=; 
 b=hn/JYa5QWXmZmrFI7smiRzU5VyW3ZmjWEtB9TA+jToXmfQlo7p/y+UKT0f66SnQxD0s5NFA6KfCjZbfg5NqYgjpFZs9A/QQxMLx/lOwrdq69J4r4eFHdV6tPxRtJQl1qyzQIR9SGuIgtYIFub9ix2Npwo3VHWsFcw7mWailbQtM=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782275776; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=IGIj+9B7jK9ecHn7547L0AcGcx1FgaoKPCAYTfqSdEA=;
 b=iwOxeJdI3KJynihnFL9yb4Kkm9I3ODoHJVJRW2wPrIQmVUQPmNCc1EquG5ZP7nlf
 X0OBp/h6zzistFtUrj/0l4CUlRnJcoxFR5VZnQYClq5v3XHgkpSSF/8Ll9ARS0UC96m
 zwfvPDSfP6h5cFWJvxXrfYmgVvlRIYOTnKJh3p5Q=
Received: by mx.zohomail.com with SMTPS id 178227577225278.05734883231958;
 Tue, 23 Jun 2026 21:36:12 -0700 (PDT)
Date: Wed, 24 Jun 2026 04:35:55 +0000
From: Yao Zi <me@ziyao.cc>
To: Eric Chung <eric.chung@riscstar.com>, Yao Zi <me@ziyao.cc>
Cc: Raymond Mao <raymondmaoca@gmail.com>, u-boot@lists.denx.de,
 uboot@riscstar.com, u-boot-spacemit@groups.io,
 raymond.mao@riscstar.com, rick@andestech.com, ycliang@andestech.com,
 trini@konsulko.com, lukma@denx.de, hs@nabladev.com,
 jh80.chung@samsung.com, peng.fan@nxp.com, xypron.glpk@gmx.de,
 randolph@andestech.com, dlan@gentoo.org, junhui.liu@pigmoral.tech,
 neil.armstrong@linaro.org, quentin.schulz@cherry.de,
 samuel@sholland.org, Guodong Xu <guodong@riscstar.com>
Subject: Re: [PATCH 1/8] spacemit: k1: select boot device via config registers
Message-ID: <ajteq071XCoIDM8-@pie>
References: <20260612201901.73657-1-raymondmaoca@gmail.com>
 <20260612201901.73657-2-raymondmaoca@gmail.com>
 <aizTnMlko1Pg9pMb@pie>
 <CAH22mJxFe79308nCXOpCtgrHhvw86EXjKZz5XAKKTVnGx_MzHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH22mJxFe79308nCXOpCtgrHhvw86EXjKZz5XAKKTVnGx_MzHA@mail.gmail.com>
X-ZohoMailClient: External
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

On Wed, Jun 24, 2026 at 08:46:40AM +0800, Eric Chung wrote:
> On Sat, Jun 13, 2026 at 11:51 AM 'Yao Zi' via uboot <uboot@riscstar.com> wrote:
> >
> > On Fri, Jun 12, 2026 at 04:18:54PM -0400, Raymond Mao wrote:
> > > From: Guodong Xu <guodong@riscstar.com>
> > >
> > > Add logic to determine the current boot device by reading the
> > > SoC's configuration registers, rather than using a hardcoded
> > > default.
> > >
> > > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > > Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> > > ---
> > >  board/spacemit/k1/spl.c | 77 ++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 76 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
> > > index 0db362130e4..d5e87d79fa2 100644
> > > --- a/board/spacemit/k1/spl.c
> > > +++ b/board/spacemit/k1/spl.c
> >
> > ...
> > > +             switch (sel) {
> > > +             case BOOT_STRAP_MODE_EMMC:
> > > +                     mode = BOOT_MODE_EMMC;
> > > +                     break;
> > > +             case BOOT_STRAP_MODE_NAND:
> > > +                     mode = BOOT_MODE_NAND;
> > > +                     break;
> > > +             case BOOT_STRAP_MODE_SPI:
> > > +                     mode = BOOT_MODE_SPI;
> > > +                     break;
> > > +             case BOOT_STRAP_MODE_SD:
> > > +             default:
> > > +                     mode = BOOT_MODE_SD;
> > > +                     break;
> > > +             }
> > > +     }
> > > +     /* TODO:
> > > +      *   The current upstream DTS file only contains the eMMC node. When
> > > +      *   the SD node is added via an overlay, the eMMC device ends up as
> > > +      *   MMC1 in SPL.
> >
> > Why not fix this with an extra alias in the overlay dt?
> >
> 
> That approach doesn't really help — with the alias, mmc0 and mmc1 get
> swapped, which ultimately breaks ABI consistency.

Sorry I didn't read you correctly, I'm not sure which you are trying to
keep consistency with.

I did a check in Linux next-20260623, and the aliases for bananapi-f3
look like,

        aliases {
		ethernet0 = &eth0;
		ethernet1 = &eth1;
		serial0 = &uart0;
		spi3 = &spi3;
		i2c2 = &i2c2;
		i2c8 = &i2c8;
		mmc0 = &emmc;
		mmc1 = &sdhci0;
	};

and for musepi-pro,

	aliases {
		ethernet0 = &eth0;
		serial0 = &uart0;
		i2c2 = &i2c2;
		i2c8 = &i2c8;
		mmc0 = &emmc;
		mmc1 = &sdhci0;
	};

So both of them assign emmc to mmc0 and sdhci0 (SD) to mmc1.

As a summary of the situation,

- Linux before SD card support is merged: emmc becomes mmc0 (without
  other hotpluggable devices present), no SD card
- Linux after SD card support is merged: emmc becomes mmc0, SD becomes
  mmc1

But PATCH 3 in the series assigns SD to mmc0 and emmc to MMC1, this
instead looks like an ABI breakage, and would go away as long as you
change the aliases? At the same time the comment here could be dropped.

> The hack on MMC1 only affects its role in SPL and doesn't impact the
> ABI in the devicetree. It's just a workaround. Eventually, both the
> overlay and the hack will be removed once the upstream DTS is robust
> enough.
> 
> 
> > > +      *   However, the SD device should be the first device (MMC1).
> > > +      *   This sequence needs to be corrected once the SD node is merged
> > > +      *   into the upstream U-Boot DTS file.
> > > +      */
> > > +     switch (mode) {
> > > +     case BOOT_MODE_EMMC:
> > > +             ret = BOOT_DEVICE_MMC1;
> > > +             break;
> > > +     case BOOT_MODE_NAND:
> > > +             ret = BOOT_DEVICE_NAND;
> > > +             break;
> > > +     case BOOT_MODE_SPI:
> > > +             ret = BOOT_DEVICE_SPI;
> > > +             break;
> > > +     case BOOT_MODE_USB:
> > > +             ret = BOOT_DEVICE_USB;
> > > +             break;
> > > +     case BOOT_MODE_SD:
> > > +             ret = BOOT_DEVICE_MMC2;
> > > +             break;
> > > +     default:
> > > +             ret = BOOT_DEVICE_MMC1;
> > > +             break;
> > > +     }
> > > +     return ret;
> > >  }
> > >
> > >  void spl_board_init(void)
> > > --
> > > 2.25.1
> > >
> >
> > Regards,
> > Yao Zi

Regards,
Yao Zi
