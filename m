Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FBBC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 21:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44480876D3;
	Mon, 15 Apr 2024 23:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PwT3MBNm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 201AF875B9; Mon, 15 Apr 2024 23:49:57 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B57B87073
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 23:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4167fce0a41so25905775e9.0
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 14:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713217794; x=1713822594; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=17Hka02/D6unEqUvDCK1CtzaYVnp8NrK6oFYeijc4y4=;
 b=PwT3MBNmxWqfviCF0g1/aY/qSN9uXxoh+Oi0eKoNQ+04JIMuILUcKqzMlN6lppbpUY
 kDTJv12EvYABncQGR8Wtj/SvG89cgW0tv6IOSg/C+56Ow+W5iEeUO5DSuL7CGwYUlXTU
 L/rdkW2ykrGGMd5e0hS2OHPzf9d5+Yc/RSeQTbzdmRbuO/ZFpTRtZ8FOblWseKys9oZD
 dHji0lO7dSIno0AC22hG8kUVshAgcYNouzjeDDlXXaQ4A6LJXiqA7Qigt+x4Ep/9woye
 W/yGUi/bTh3MhISDIqHJTsP2uw0tl8eSR5bDJt8Uh1H9yTMRvCbut405NIK2iKJcMVvJ
 1H1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713217794; x=1713822594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=17Hka02/D6unEqUvDCK1CtzaYVnp8NrK6oFYeijc4y4=;
 b=ODuRwhysKyyWrUJuqLYMkw4wPjS4FS/9dfHRarLbtMQXKDc6wWZ8m2NEAG/teghQWL
 aw5FiEpIYQn8NFDHr8ea9kKyZZS3WFzOvtsWTYoO1XOOYUpqTVfXewO8+4Kge/YuAv7K
 JGmAybIUfdJL9LNZrWWxX0yaUalNZQIuYdlzqkDkiJdPgTXpGhlx/3lbBjDRS6q5nbl5
 gH8VPtEg5LF+yICQi4svV1AXB9KCVOgQ9S02h2oeqcPk+XYhtkcxYy22BfXZrcFr/+D1
 iiBaSVuA+adkwtCI/cNGSAIoDK/3u2hv/scNi+ets53tygGGQMICiZrh5Hk7ge0n4mXN
 CHOA==
X-Gm-Message-State: AOJu0YzJbU3L6oIEyPvFzpyomGwB6AURs/0c9yW6X2cA4KTmdOssbwvJ
 tmCvul5+vBMCJap8Oajshj7ubx2ugG8dN+eeB/nF0Micz75tXm5S
X-Google-Smtp-Source: AGHT+IH244cDYG4NSAVB4r/xSKt6Y+FK5MaK+4J2cpw33WJwDAqmLRTQcd0c9GgQfmwxtgkf5krXIw==
X-Received: by 2002:a05:600c:3b02:b0:417:d99f:1fef with SMTP id
 m2-20020a05600c3b0200b00417d99f1fefmr673899wms.3.1713217794420; 
 Mon, 15 Apr 2024 14:49:54 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 ay8-20020a05600c1e0800b004181c91d1dcsm11624909wmb.18.2024.04.15.14.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 14:49:54 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: dazen@189.cn, Mikhail Kalashnikov <iuncuim@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, jagan@amarulasolutions.com, trini@konsulko.com
Subject: Re: [PATCH] DRAM_SUN50I_H616_TRIM_SIZE
Date: Mon, 15 Apr 2024 23:49:53 +0200
Message-ID: <4338523.ejJDZkT8p0@jernej-laptop>
In-Reply-To: <20240415012245.75ccaa5b@minigeek.lan>
References: <20240413134352.46495-1-dazen@189.cn>
 <20240415012245.75ccaa5b@minigeek.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

Dne ponedeljek, 15. april 2024 ob 02:22:45 GMT +2 je Andre Przywara napisal(a):
> On Sat, 13 Apr 2024 21:43:52 +0800
> dazen@189.cn wrote:
> 
> Hi,
> 
> thanks for sending a patch!
> 
> > From: lalakii <dazen@189.cn>
> > 
> > Add "DRAM_SUN50I_H616_TRIM_SIZE" option for 1.5gb board.
> > 
> > Signed-off-by: lalakii <dazen@189.cn>
> > ---
> >  arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h |  1 +
> >  arch/arm/mach-sunxi/Kconfig                        |  7 +++++++
> >  arch/arm/mach-sunxi/dram_sun50i_h616.c             | 11 ++++++++++-
> >  3 files changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
> > index a8fdda124a..2d2526fead 100644
> > --- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
> > +++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
> > @@ -166,6 +166,7 @@ struct dram_config {
> >  	u8 rows;
> >  	u8 ranks;
> >  	u8 bus_full_width;
> > +	bool trim_size;
> >  };
> >  
> >  static inline int ns_to_t(int nanoseconds)
> > diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> > index fe89aec6b9..255a498557 100644
> > --- a/arch/arm/mach-sunxi/Kconfig
> > +++ b/arch/arm/mach-sunxi/Kconfig
> > @@ -108,6 +108,13 @@ config DRAM_SUN50I_H616_TPR12
> >  	default 0x0
> >  	help
> >  	  TPR12 value from vendor DRAM settings.
> > +
> > +config DRAM_SUN50I_H616_TRIM_SIZE
> > +        bool "H616 DRAM trim size"
> > +        help
> > +          Due to unknown issue, some H616 based boards may need to trim
> 
> Well, it's not really an unknown issue, is it? The problem seems to be
> that the auto detection code cannot deal with the topology of the 1.5GB
> DRAM chips.
> 
> The general problem with this approach is that it would need to be
> enabled at build time, which means the generated image will always trim
> the DRAM size, and would not be universal for each board anymore.
> 
> So we need something to auto-detect this situation. Can you describe
> the failure mode, without this patch? Does the DRAM init code hang or
> give up already, or does this all pass, and then later on the board
> hangs or crashes when we try access the missing DRAM area?
> Maybe a small test access beyond 1.5GB would be able to check for this
> particular case?

Vendor DRAM check for 1.5 GB is pretty simple. First, it's checked if 2 GB
of RAM is detected. If so, 3 different patterns are written to 0x70000000,
0xa0000000 and 0x80000000 (in that order). Then, pattern from 0xa0000000 is
read. If it doesn't match to pattern written to this location, 1.5 GB is
assumed.

Best regards,
Jernej

> 
> Cheers,
> Andre
> 
> 
> > +          size a bit.
> > +
> >  endif
> >  
> >  config SUN6I_PRCM
> > diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> > index 37c139e0ee..4598d60a57 100644
> > --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
> > +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> > @@ -1349,8 +1349,15 @@ static unsigned long mctl_calc_size(const struct dram_config *config)
> >  {
> >  	u8 width = config->bus_full_width ? 4 : 2;
> >  
> > +	unsigned long size;
> > +
> > +	size = (1ULL << (config->cols + config->rows + 3)) * width * config->ranks;
> > +
> > +	if (config->trim_size)
> > +		size = (size * 3) / (width == 4 ? 4 : 8);
> > +
> >  	/* 8 banks */
> > -	return (1ULL << (config->cols + config->rows + 3)) * width * config->ranks;
> > +	return size;
> >  }
> >  
> >  static const struct dram_para para = {
> > @@ -1379,6 +1386,8 @@ unsigned long sunxi_dram_init(void)
> >  	struct sunxi_prcm_reg *const prcm =
> >  		(struct sunxi_prcm_reg *)SUNXI_PRCM_BASE;
> >  	struct dram_config config;
> > +	if (IS_ENABLED(CONFIG_DRAM_SUN50I_H616_TRIM_SIZE))
> > +		config.trim_size = true;
> >  	unsigned long size;
> >  
> >  	setbits_le32(&prcm->res_cal_ctrl, BIT(8));
> 
> 




