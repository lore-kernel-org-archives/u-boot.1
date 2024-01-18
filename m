Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEB3C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 15:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4A2C87B75;
	Thu, 18 Jan 2024 16:06:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K1ELEArC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0226887B79; Thu, 18 Jan 2024 16:06:35 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C31B1878D3
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 16:06:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6ddf05b1922so5681936a34.2
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 07:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590391; x=1706195191; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+jCcD5HrVwEIa0hvvD3FzyG7BkziW0A1f2lyMQSv1EQ=;
 b=K1ELEArC8LYqILe0KchSOeX6A6sS6YVHOQkak56qVurpM/TQwXeKp2DoLibAynhLy3
 Z/mSWB2Yq9eGh4toSenVU20T6vXrmOjpX2cCzxHkLv+ut257KHbKNhtLAvU7MmiE8AYw
 tB1RG2ajGNltYvNk1xwo9xUIAwr0uz8hh/86AI3NoNvh7axTdE+VWzQXt6BoiGrwiWHg
 g6iRetPsCezlGmGGrPMDKW/4+sK+0Q5bpkqXEq3om4WTSDxCUcPAzunvO4JveHoUQ+pl
 /eS6+88RD1PJvKg3LHsQqe36cc8K84oXMy+l1zQrii4A1PUjR8m68YHgwUiatODf6x9F
 YmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590391; x=1706195191;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+jCcD5HrVwEIa0hvvD3FzyG7BkziW0A1f2lyMQSv1EQ=;
 b=wUsfamUwSbi6DkxHpc7NiUzCm4N6HC5diFjbia64pMTHHiuwB06+Sa8IShdZ3/VNds
 E0qjK6AzZDRvl2KuvlrU40n1sbrKfGehwXpGriXmsLWEwzcQ4qPMQXAkG/mz6zkyGZbW
 AHiW+fAcd4biNAgN60ZHsK5SA5YWGG+RA3e/aEhxXKuQgRdJY2MItE0dIvFrVZMIPM5e
 jK7XPyi56RcOjAvy/Ur2xc6aQa9Iy2WSrSmnKMi6A7Sg7UtMhsoYSQjMxSWuwwf8phUH
 7clFjaABRqiiP+sp5lqDKatYfXogxt+Xxtsuuu8ZzZ767SgqIUwJPtSUrxVc5D9l0Dal
 +Dsg==
X-Gm-Message-State: AOJu0YydCG1BpYuG+mtFZ08O6MjLStYbvoutDPYnRQrWK1dONij4irWj
 w8QxJpkrgncYiBhohHfAW/SljGts2AbECHWCJWToRtaqu+W+HZym
X-Google-Smtp-Source: AGHT+IFj9VwcHFhXLzpaK939sNgdVb3IX2nf8xzbzkqsSvJoe/OOgeUxTVs6wTpRLKZ/pe0J5GFGLA==
X-Received: by 2002:a05:6830:3a90:b0:6e0:d0bf:543b with SMTP id
 dj16-20020a0568303a9000b006e0d0bf543bmr920505otb.67.1705590391323; 
 Thu, 18 Jan 2024 07:06:31 -0800 (PST)
Received: from neuromancer. ([75.28.21.198]) by smtp.gmail.com with ESMTPSA id
 m16-20020a9d7ad0000000b006dbb193a98esm248378otn.80.2024.01.18.07.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:06:31 -0800 (PST)
Message-ID: <65a93e77.9d0a0220.46f34.1553@mx.google.com>
X-Google-Original-Message-ID: <Zak+dSk6xDTKp79L@neuromancer.>
Date: Thu, 18 Jan 2024 09:06:29 -0600
From: Chris Morgan <macroalpha82@gmail.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, andre.przywara@arm.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, jagan@edgeble.ai, jonas@kwiboo.se,
 Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V4 3/7] rockchip: boot_mode: Allow
 rockchip_dnl_key_pressed() in SPL
References: <20240102154654.191055-1-macroalpha82@gmail.com>
 <20240102154654.191055-4-macroalpha82@gmail.com>
 <9aae0791-84a5-42b4-b76d-2a89040b23d0@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9aae0791-84a5-42b4-b76d-2a89040b23d0@rock-chips.com>
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

On Thu, Jan 18, 2024 at 03:20:52PM +0800, Kever Yang wrote:
> Hi Chris,
> 
> On 2024/1/2 23:46, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Update the rockchip_dnl_key_pressed() so that it can run in
> > SPL. Also change the ADC channel to a define that can be
> > overridden by a board specific option.
> 
> I should ask this earlier.
> 
> Why you have to enable the download key in SPL?
> 
> This works for a long time in U-Boot proper, both mainline and downstream
> vendor U-Boot,
> 
> no one is detect this download key in SPL.
> 
> In theory the SPL can implement all the feature which is available in U-Boot
> proper,
> 
> but it would be better to make the SPL focus on the job it should be done
> and keep as small as possible.
> 

I wanted this code to run as soon as possible in the event of a bad
write. I have some devices which lack a way to bypass the eMMC in the
boot path; the fear is that if an SPL stage is written with a good
header but a bad payload (or if the A-TF does something wrong) the
device will become unbootable. If we can't do it this way for
all Rockchip boards that's fine, but I REALLY want to at least do
it this way for the Powkiddy X55 board and the Anbernic RGxx3 board.

While I have you, I have a related question I hope you can help with.
Is there any way to utilize the boot partitions of an eMMC device? I
don't know if the BROM of an RK3568 or RK3588 is capable, but I'd love
to have the SPL and U-Boot stages written to the eMMC boot partitions
instead of the user partition if I can.

Thank you.

> 
> Thanks,
> 
> - Kever
> 
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >   arch/arm/mach-rockchip/Makefile    |  4 ++--
> >   arch/arm/mach-rockchip/boot_mode.c | 11 ++++++++++-
> >   2 files changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> > index 1dc92066bb..ff089ae949 100644
> > --- a/arch/arm/mach-rockchip/Makefile
> > +++ b/arch/arm/mach-rockchip/Makefile
> > @@ -15,13 +15,13 @@ obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
> >   obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
> > -ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
> > -
> >   # Always include boot_mode.o, as we bypass it (i.e. turn it off)
> >   # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This way,
> >   # we can have the preprocessor correctly recognise both 0x0 and 0
> >   # meaning "turn it off".
> >   obj-y += boot_mode.o
> > +
> > +ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
> >   obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
> >   obj-$(CONFIG_MISC_INIT_R) += misc.o
> >   endif
> > diff --git a/arch/arm/mach-rockchip/boot_mode.c b/arch/arm/mach-rockchip/boot_mode.c
> > index eb8f65ae4e..d2308768be 100644
> > --- a/arch/arm/mach-rockchip/boot_mode.c
> > +++ b/arch/arm/mach-rockchip/boot_mode.c
> > @@ -38,6 +38,10 @@ void set_back_to_bootrom_dnl_flag(void)
> >   #define KEY_DOWN_MIN_VAL	0
> >   #define KEY_DOWN_MAX_VAL	30
> > +#ifndef RK_DNL_ADC_CHAN
> > +#define RK_DNL_ADC_CHAN		1
> > +#endif
> > +
> >   __weak int rockchip_dnl_key_pressed(void)
> >   {
> >   	unsigned int val;
> > @@ -52,7 +56,8 @@ __weak int rockchip_dnl_key_pressed(void)
> >   	ret = -ENODEV;
> >   	uclass_foreach_dev(dev, uc) {
> >   		if (!strncmp(dev->name, "saradc", 6)) {
> > -			ret = adc_channel_single_shot(dev->name, 1, &val);
> > +			ret = adc_channel_single_shot(dev->name,
> > +						      RK_DNL_ADC_CHAN, &val);
> >   			break;
> >   		}
> >   	}
> > @@ -73,11 +78,13 @@ __weak int rockchip_dnl_key_pressed(void)
> >   void rockchip_dnl_mode_check(void)
> >   {
> > +#if CONFIG_IS_ENABLED(ADC)
> >   	if (rockchip_dnl_key_pressed()) {
> >   		printf("download key pressed, entering download mode...");
> >   		set_back_to_bootrom_dnl_flag();
> >   		do_reset(NULL, 0, 0, NULL);
> >   	}
> > +#endif
> >   }
> >   int setup_boot_mode(void)
> > @@ -90,6 +97,7 @@ int setup_boot_mode(void)
> >   	boot_mode = readl(reg);
> >   	debug("%s: boot mode 0x%08x\n", __func__, boot_mode);
> > +#if !defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD)
> >   	/* Clear boot mode */
> >   	writel(BOOT_NORMAL, reg);
> > @@ -103,6 +111,7 @@ int setup_boot_mode(void)
> >   		env_set("preboot", "setenv preboot; ums mmc 0");
> >   		break;
> >   	}
> > +#endif
> >   	return 0;
> >   }
