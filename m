Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7089CEED615
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 16:00:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F214089042;
	Thu, 12 Sep 2024 17:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D1BE89092; Thu, 12 Sep 2024 17:59:58 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 593C989032
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 17:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F41A2152B;
 Thu, 12 Sep 2024 09:00:24 -0700 (PDT)
Received: from e130802.arm.com (e130802.arm.com [10.1.38.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 634F73F66E;
 Thu, 12 Sep 2024 08:59:54 -0700 (PDT)
Date: Thu, 12 Sep 2024 16:59:45 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Simon Glass <sjg@chromium.org>, trini@konsulko.com
Cc: hugues.kambampiana@arm.com, u-boot@lists.denx.de
Subject: Re: [PATCH v4 02/23] nvmxip: Avoid probing on boot
Message-ID: <20240912155945.GA101143@e130802.arm.com>
References: <20240901222634.460873-1-sjg@chromium.org>
 <20240901222634.460873-3-sjg@chromium.org>
 <20240902161047.GC2479150@bill-the-cat>
 <CAFLszTg0-+m_hZf0n+-t+8gZz1m_ByJ=h=Ga1GkB37LL+6_7rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTg0-+m_hZf0n+-t+8gZz1m_ByJ=h=Ga1GkB37LL+6_7rg@mail.gmail.com>
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

Hi Simon, Tom,

> > > Devices should be probed when they are used, not before. Drop this
> > > boot-time probing.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  drivers/mtd/nvmxip/nvmxip-uclass.c | 7 -------
> > >  1 file changed, 7 deletions(-)
> > >
> > > diff --git a/drivers/mtd/nvmxip/nvmxip-uclass.c b/drivers/mtd/nvmxip/nvmxip-uclass.c
> > > index 58e8c3fb74b..d18bd0e3d6b 100644
> > > --- a/drivers/mtd/nvmxip/nvmxip-uclass.c
> > > +++ b/drivers/mtd/nvmxip/nvmxip-uclass.c
> > > @@ -53,14 +53,7 @@ int nvmxip_probe(struct udevice *udev)
> > >       return 0;
> > >  }
> > >
> > > -static int nvmxip_post_bind(struct udevice *udev)
> > > -{
> > > -     dev_or_flags(udev, DM_FLAG_PROBE_AFTER_BIND);
> > > -     return 0;
> > > -}
> > > -
> > >  UCLASS_DRIVER(nvmxip) = {
> > >       .name      = "nvmxip",
> > >       .id        = UCLASS_NVMXIP,
> > > -     .post_bind = nvmxip_post_bind,
> > >  };
> >
> > Once again, adding in the corstone1000 maintainers as the platform that
> > actually uses this.
> 
> Just to mention that Abdellatif was added automatically by patman for
> the first version, but if there is no reply, after v2 I tend to drop
> it back, to avoid sending too many emails.

I'm happy to stay in the loop.

> 
> Regards,
> Simon

Cheers
Abdellatif
