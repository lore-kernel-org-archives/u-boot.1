Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9906C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 21:06:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB0168870E;
	Wed, 14 Aug 2024 23:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LG52xMD4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBAF988859; Wed, 14 Aug 2024 23:06:28 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87A958800C
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 23:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5d5e97b8a22so202759eaf.2
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 14:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723669585; x=1724274385; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=XhPJ+yHivw3J9kU7VG39Uao9OGHw8SKOyRbHNXus1Ag=;
 b=LG52xMD45hTAU37eYOB5Hlvtx/IeveGCpiG5SWuHyda3sPAcwAm/Q3sYojdQBXK5I2
 oXLXfOz9Cg3evNxSo9OU/G+59XdEd3jLtF7MafbD0RxPFSBtBzGBwlvBohyVpU3gpprc
 NV4/lMaoNvvIavN2F2u/O1ExRI8yZ0dtObD8ZBNkRx8jfWqpbsuLqCN7DkEJImkMdmSe
 1+Qpl8QULg/f2HHEaKK/eh9L4TV2yyszZvLtXaXFC9IKw2kCB9BMTqzuVamclF2QP+KB
 yMl+9GdKTX7px5TFgXz7IHKUDEpy+99OCjyo8NRghvjS/zv2/a4zRKIpjHQVepTjoKk3
 HWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723669585; x=1724274385;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XhPJ+yHivw3J9kU7VG39Uao9OGHw8SKOyRbHNXus1Ag=;
 b=Da7RurUYiJN4AmBuDNmqsUAtHRQzotepVPQOyWij9xA6w4Zee8QH4npzc83EsgBepj
 EVmvIMxQw2alw2AY1ulK506e1u1R6cLG9f0ocoNZeH3ptcdPK3nh1K4T6xlANPgp4XAn
 IivyyvMZ3TGs/ltWhrk8fZXCiCAJKEfjop5DAxGfAizJwBHVt7CLsqWgWDX84yazCjQz
 lXzFP7kIgRe/nsvIQ6ADBcYTGLrb/XCBq9f+qaI8NOLo5lyVLFK66qvfOiCCwcvHxn+r
 4Zv3GRu48rHfvjTcHxpjy7biaomFGB+MIm3mGhEm+UV0nuP8+cje5BZZy5HkialmkG37
 7djw==
X-Gm-Message-State: AOJu0YznNyhhdd2rMRHZI+eAq8ST49yJlmUKSrG9ohMEZvcg54aVIzQP
 NnTJfx0cc0uZoLLSeMqm7Qg0ho5vKipy07Mifln+kkT4+QUzGKIJ
X-Google-Smtp-Source: AGHT+IGsn5MkDo7CY8d3/MQ2270JXUtn+DzXChLnkFsr/gEtk/J/H/YINS2IIPtppGo6EuY8ap4Mnw==
X-Received: by 2002:a05:6820:228c:b0:5c6:7519:9b58 with SMTP id
 006d021491bc7-5da7c73f7bamr4751543eaf.4.1723669585186; 
 Wed, 14 Aug 2024 14:06:25 -0700 (PDT)
Received: from neuromancer. ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da8cfc5619sm15095eaf.40.2024.08.14.14.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 14:06:24 -0700 (PDT)
Message-ID: <66bd1c50.4a0a0220.192aee.024e@mx.google.com>
X-Google-Original-Message-ID: <Zr0cTyj8BCNdQrEX@neuromancer.>
Date: Wed, 14 Aug 2024 16:06:23 -0500
From: Chris Morgan <macroalpha82@gmail.com>
To: Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jernej.skrabec@gmail.com,
 neil.armstrong@linaro.org, hdegoede@redhat.com,
 andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com,
 Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 3/9] sunxi: H616: dram: LPDDR4: adjust settings
References: <20240801225519.336667-1-macroalpha82@gmail.com>
 <20240801225519.336667-4-macroalpha82@gmail.com>
 <9b7db179-1e08-4690-97f8-b040f1c19f37@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b7db179-1e08-4690-97f8-b040f1c19f37@gmail.com>
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

On Sat, Aug 03, 2024 at 03:29:17PM +0300, Mikhail Kalashnikov wrote:
> 
> On 02.08.2024 01:55, Chris Morgan wrote:
> > From: Jernej Skrabec <jernej.skrabec@gmail.com>
> > 
> > Adjust H616 LPDDR4 DRAM settings to be in line with vendor driver.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > Tested-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >   arch/arm/mach-sunxi/dram_sun50i_h616.c        | 35 +++++++++++++------
> >   .../dram_timings/h616_lpddr4_2133.c           |  2 +-
> >   2 files changed, 26 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> > index a20264d8b4..b6638c519e 100644
> > --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
> > +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> > @@ -293,14 +293,22 @@ static void mctl_phy_configure_odt(const struct dram_para *para)
> >   	dmb();
> >   }
> > -static bool mctl_phy_write_leveling(const struct dram_config *config)
> > +static bool mctl_phy_write_leveling(const struct dram_para *para,
> > +				    const struct dram_config *config)
> >   {
> >   	bool result = true;
> >   	u32 val;
> >   	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 0xc0, 0x80);
> > -	writel(4, SUNXI_DRAM_PHY0_BASE + 0xc);
> > -	writel(0x40, SUNXI_DRAM_PHY0_BASE + 0x10);
> > +
> > +	if (para->type == SUNXI_DRAM_TYPE_LPDDR4) {
> > +		/* MR2 value */
> > +		writel(0x1b, SUNXI_DRAM_PHY0_BASE + 0xc);
> > +		writel(0, SUNXI_DRAM_PHY0_BASE + 0x10);
> > +	} else {
> > +		writel(4, SUNXI_DRAM_PHY0_BASE + 0xc);
> > +		writel(0x40, SUNXI_DRAM_PHY0_BASE + 0x10);
> > +	}
> >   	setbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 4);
> > @@ -859,9 +867,9 @@ static void mctl_phy_ca_bit_delay_compensation(const struct dram_para *para,
> >   		}
> >   		break;
> >   	case SUNXI_DRAM_TYPE_LPDDR4:
> > -		if (para->tpr2 & 1) {
> > -			writel(val, SUNXI_DRAM_PHY0_BASE + 0x788);
> > -		} else {
> > +		writel(val, SUNXI_DRAM_PHY0_BASE + 0x788);
> > +		if (config->ranks == 2) {
> > +			val = (para->tpr10 >> 11) & 0x1e;
> >   			writel(val, SUNXI_DRAM_PHY0_BASE + 0x794);
> >   		};
> >   		break;
> > @@ -949,6 +957,8 @@ static bool mctl_phy_init(const struct dram_para *para,
> >   		break;
> >   	case SUNXI_DRAM_TYPE_LPDDR4:
> >   		val = para->tpr6 >> 24 & 0xff;
> > +		if (!val)
> > +			val = 0x33;
> 
> We don't need this as the default value from
> arch/arm/mach-sunxi/Kconfigcovers
> this case:
> 
> config DRAM_SUN50I_H616_TPR6
> hex "H616 DRAM TPR6 parameter"
> default 0x3300c080
> 
> >   		break;
> >   	case SUNXI_DRAM_TYPE_DDR4:
> >   	default:
> > @@ -1080,19 +1090,27 @@ static bool mctl_phy_init(const struct dram_para *para,
> >   		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> >   		writel(0xb04, &mctl_ctl->mrctrl1);
> > +		udelay(10);
> >   		writel(0x80000030, &mctl_ctl->mrctrl0);
> > +		udelay(10);
> >   		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> >   		writel(0xc72, &mctl_ctl->mrctrl1);
> > +		udelay(10);
> >   		writel(0x80000030, &mctl_ctl->mrctrl0);
> > +		udelay(10);
> >   		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> >   		writel(0xe09, &mctl_ctl->mrctrl1);
> > +		udelay(10);
> >   		writel(0x80000030, &mctl_ctl->mrctrl0);
> > +		udelay(10);
> >   		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> >   		writel(0x1624, &mctl_ctl->mrctrl1);
> > +		udelay(10);
> >   		writel(0x80000030, &mctl_ctl->mrctrl0);
> > +		udelay(10);
> Looks like something experimental.

Should I remove it? Sorry but I'm not super familiar with this specific
code.

> >   		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> >   		break;
> >   	case SUNXI_DRAM_TYPE_DDR4:
> > @@ -1108,7 +1126,7 @@ static bool mctl_phy_init(const struct dram_para *para,
> >   	if (para->tpr10 & TPR10_WRITE_LEVELING) {
> >   		for (i = 0; i < 5; i++)
> > -			if (mctl_phy_write_leveling(config))
> > +			if (mctl_phy_write_leveling(para, config))
> >   				break;
> >   		if (i == 5) {
> >   			debug("write leveling failed!\n");
> > @@ -1234,9 +1252,6 @@ static bool mctl_ctrl_init(const struct dram_para *para,
> >   	setbits_le32(&mctl_ctl->unk_0x3180, BIT(31) | BIT(30));
> >   	setbits_le32(&mctl_ctl->unk_0x4180, BIT(31) | BIT(30));
> > -	if (para->type == SUNXI_DRAM_TYPE_LPDDR4)
> > -		setbits_le32(&mctl_ctl->dbictl, 0x1);
> > -
> 
> I have this piece of code in the opizero3 mtd dump. This condition depends
> on tpr13. Judging by the dram_para parameters, it should be performed for
> lpddr4 (and maybe ddr4) memory. According to the opizero3 dump it should
> clear all values and set BIT(2). Don't know, why I only set BIT(0) here.
> This
> may be a bug or another spl from t507 and the first version of the driver.

What would be correct here then?

> 
> >   	setbits_le32(&mctl_ctl->rfshctl3, BIT(0));
> >   	clrbits_le32(&mctl_ctl->dfimisc, BIT(0));
> > diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
> > index e6446b9180..6f5c4acbd6 100644
> > --- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
> > +++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
> > @@ -23,7 +23,7 @@ void mctl_set_timing_params(const struct dram_para *para)
> >   	u8 trcd		= max(ns_to_t(18), 2);
> >   	u8 trc		= ns_to_t(65);
> >   	u8 txp		= max(ns_to_t(8), 2);
> > -	u8 trtp		= max(ns_to_t(8), 4);
> > +	u8 trtp		= 4;
> >   	u8 trp		= ns_to_t(21);
> >   	u8 tras		= ns_to_t(42);
> >   	u16 trefi	= ns_to_t(3904) / 32;

Thank you,
Chris
