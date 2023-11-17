Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668C3C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 16:52:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C12FB86FB8;
	Fri, 17 Nov 2023 17:52:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=poczta.fm header.i=@poczta.fm header.b="lgvyCaRI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 777388749F; Fri, 17 Nov 2023 15:03:46 +0100 (CET)
Received: from smtpo26.interia.pl (smtpo26.interia.pl [217.74.67.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72CC68744B
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 15:03:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=poczta.fm
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sst@poczta.fm
Received: from nr200 (ipv4-80-68-225-159.net.internetunion.pl [80.68.225.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
 (No client certificate requested)
 by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
 Fri, 17 Nov 2023 15:03:40 +0100 (CET)
Date: Fri, 17 Nov 2023 15:03:39 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 John Clark <inindev@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/4] rockchip: rk3588: Fix boot from SPI flash
Message-ID: <ZVdyu2vjW0LrW6Jf@nr200>
References: <20231112102705.1180714-1-jonas@kwiboo.se>
 <20231112102705.1180714-2-jonas@kwiboo.se>
 <561f7d8a-bf46-4ba7-a353-b5d3dfab95b0@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <561f7d8a-bf46-4ba7-a353-b5d3dfab95b0@theobroma-systems.com>
X-IPL-Priority-Group: 0-0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
 t=1700229822; bh=auvfGFPundameoL/vQ57L5skCkg/2jtT0uRW27LbmQQ=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
 b=lgvyCaRIPc6mhExt3AAdhAoc5kGXL9Gh1N8+m2HqlIjUJ7YJDzjSOzGRSNYkyagsF
 YoYN9gQdWx/AYdBwUXCDF6/T6j60JP1LN53DxMT/uNAiVUeRdEjV9k0k7zmWv9kAPC
 hs5uO/9pY4Hi3bqmdXMNDuJzzn7k/ZTWTU0c7hkM=
X-Mailman-Approved-At: Fri, 17 Nov 2023 17:52:24 +0100
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

On lis 14, 2023 15:06, Quentin Schulz wrote:
> Hi Jonas,

Hi Quentin

> On 11/12/23 11:26, Jonas Karlman wrote:
> > The commit fd6e425be243 ("rockchip: rk3588-rock-5b: Enable boot from SPI
> > NOR flash") added a new BROM_BOOTSOURCE_SPINOR_RK3588 with value 6.
> > 
> > At the time the reason for this new bootsource id value 6 was unknown.
> > 
> > We now know that the BootRom on RK3588 use different bootsource id
> > values depending on the iomux used by the flash spi controller, and not
> > by the type of spi nor or spi nand flash used.
> > 
> > Add the following defines and use them for RK3588 boot_devices.
> > 
> > - BROM_BOOTSOURCE_FSPI_M0 = 3
> > - BROM_BOOTSOURCE_FSPI_M1 = 4
> > - BROM_BOOTSOURCE_FSPI_M2 = 6
> > 
> > Fixes: fd6e425be243 ("rockchip: rk3588-rock-5b: Enable boot from SPI NOR flash")
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > ---
> >   arch/arm/include/asm/arch-rockchip/bootrom.h | 4 +++-
> >   arch/arm/mach-rockchip/rk3588/rk3588.c       | 5 +++--
> >   2 files changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/include/asm/arch-rockchip/bootrom.h
> > index 7dab18fbc3fb..f78337397d63 100644
> > --- a/arch/arm/include/asm/arch-rockchip/bootrom.h
> > +++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
> > @@ -47,8 +47,10 @@ enum {
> >   	BROM_BOOTSOURCE_EMMC = 2,
> >   	BROM_BOOTSOURCE_SPINOR = 3,
> >   	BROM_BOOTSOURCE_SPINAND = 4,
> > +	BROM_BOOTSOURCE_FSPI_M0 = 3,
> > +	BROM_BOOTSOURCE_FSPI_M1 = 4,
> 
> I'm a bit wary of two pairs of enums sharing the same value, especially when
> we want to use them as offset in a static definition of an array.
> 
> Should we #ifdef it (meh) for RK3588?
> Should we add a suffix like before for identifying RK3588-specific options?
> 
> At the very least explicit that those are RK3588-specific in a comment for
> both conflicts (the ones that apply to everything except RK3588 to say to
> use only for !RK3588, and the ones that apply to RK3588 only)?

Can you say why it is so important to know that given enum is specific to given CPU here in the
header file? I think that the enums in the bootrom.h should be as generic as possible.

By using the possible enums in a static array, "solves" the problem of assigning the boot source to
specific CPU. There is not need to make such grouping in the bootrom.h.

-- 
Slawomir Stepien
