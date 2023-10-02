Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83DDE7490C
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 18:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F74F864A7;
	Mon,  2 Oct 2023 20:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OcFA1kpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F09AA8694A; Mon,  2 Oct 2023 20:50:53 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F5F88634D
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 20:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4065dea9a33so803155e9.3
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 11:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696272651; x=1696877451; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MOxPXAsS0onSJ6vz3d3M0XQ4Kr8LKcpTafakt1gdbds=;
 b=OcFA1kpg8wt1gL27hTYJjM2n+HGptoOXMpCZrDr6ZRzB6wUYKDpZ7iywdGo2feh5bW
 lK/yjwIyY/rZ1rLWebdpxuDSe9nYRjIJgPbKELKKOTlq6cM6IDdhwlpKPIuA8qBv/kY2
 5PFIZjKHS8TSgM8DDkvS8emzqGYLDy4pxc/nCwYL2hepEQfYO01l2fZK++5YLoZgh6ao
 Ji2bqETCy6+vK3yd2ZiSCBHkACuqik8o8WTHEaDrg0+SNUXFf01d9L0btRFCW84ITxUu
 B+WinsAf4bsWPJ8K74T40Oiyz1TueIFR3WbaUJvlGs4u21HB/1zA68o9ynryUFhZXstt
 DV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696272651; x=1696877451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MOxPXAsS0onSJ6vz3d3M0XQ4Kr8LKcpTafakt1gdbds=;
 b=pet/JZaHW38uOz1Gq/a388A6f9pe+0dVcfef5sNk62DXCgpbSPwULHG57CREdGeDnt
 D0pIp5guscqHx9D3yqAyvFVAfoDJqPEgBPUTs0zOjkg/xztSo6wfUMdtpWbbLyqehcjo
 ZYGQSi3HJcfDGY7d4bT/Fca/SF/jrJ0BKnHotpKKfMgm3syvAPxZHsnaxnnOVzSCG0t7
 biJDzUyFBBUOKLdJMSoHVO6axcWcCHn3bfVuqZCyuB65r6aXmDKUVzYjgOxwMKeONnI3
 VFrmLaV3FtIx5BNSK8n5AiuR9TlL65HIh+CVR80oYN4GMJnFMZBehFMD6JK9g0Q35RIR
 YJLg==
X-Gm-Message-State: AOJu0YyHSeMYF6eXeBCtDzlHBDymsZ+2hI/X4FoL/77dxsEDCu+f2v1r
 uLKR8SFQlEUyLW0uMk9d1c0=
X-Google-Smtp-Source: AGHT+IHUNvXcUvMQvxgHDkXbbB6hePaR1SnU1PoHcQvQ7rQr80f7jsIySO+zCvjB1eke3Ewm2mirwQ==
X-Received: by 2002:a1c:7204:0:b0:405:2e28:4878 with SMTP id
 n4-20020a1c7204000000b004052e284878mr10304549wmc.30.1696272651132; 
 Mon, 02 Oct 2023 11:50:51 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net.
 [82.149.12.148]) by smtp.gmail.com with ESMTPSA id
 s16-20020a05600c045000b0040536dcec17sm7803995wmb.27.2023.10.02.11.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 11:50:50 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Gunjan Gupta <viraniac@gmail.com>, Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Ondrej Jirman <megi@xff.cz>,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH 1/1] sunxi: dram: Fix incorrect ram size detection for
 some H6 boards
Date: Mon, 02 Oct 2023 20:50:49 +0200
Message-ID: <4862495.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20231002122626.047b4043@donnerap.manchester.arm.com>
References: <20231001161336.31140-1-viraniac@gmail.com>
 <20231001161336.31140-2-viraniac@gmail.com>
 <20231002122626.047b4043@donnerap.manchester.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

Dne ponedeljek, 02. oktober 2023 ob 13:26:26 CEST je Andre Przywara napisal(a):
> On Sun,  1 Oct 2023 21:43:32 +0530
> Gunjan Gupta <viraniac@gmail.com> wrote:
> 
> (fixing Jernej's email) 
> 
> Hi Gunjan,
> 
> thanks for sending a patch!
>  
> > On some H6 boards like Orange Pi 3 LTS, some times U-Boot fails to detect
> > ram size correctly. Instead of 2GB thats available, it detects 4GB of ram
> > and then SPL just hangs there making board not to boot further.
> > 
> > On debugging, I found that the rows value were being determined correctly,
> > but columns were sometimes off by one value. I found that adding some
> > delay after the mctl_core_init call along with making use of dsb in the
> > start of the mctl_mem_matches solves the issue.
> > 
> > Signed-off-by: Gunjan Gupta <viraniac@gmail.com>
> > ---
> > 
> >  arch/arm/mach-sunxi/dram_helpers.c   | 1 +
> >  arch/arm/mach-sunxi/dram_sun50i_h6.c | 2 ++
> >  2 files changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm/mach-sunxi/dram_helpers.c b/arch/arm/mach-sunxi/dram_helpers.c
> > index cdf2750f1c..5758c58e07 100644
> > --- a/arch/arm/mach-sunxi/dram_helpers.c
> > +++ b/arch/arm/mach-sunxi/dram_helpers.c
> > @@ -32,6 +32,7 @@ void mctl_await_completion(u32 *reg, u32 mask, u32 val)
> >  #ifndef CONFIG_MACH_SUNIV
> >  bool mctl_mem_matches(u32 offset)
> >  {
> > +	dsb();
> 
> This looks a bit odd, do you have an explanation for that? And are you
> sure that is really needed?
> I understand why we need the DSB after the writel's below, but before that?
> The only thing I could think of is that we are missing a barrier in
> mctl_core_init() - which is the function called before mctl_mem_matches().
> Can you move that dsb(); into mctl_auto_detect_dram_size(), right after
> the mctl_core_init() call (where you add the udelay() below)? And I wonder
> if a dmb() would already be sufficient? I noticed recently that the
> clr/setbit_le32() functions don't have a barrier at all, maybe that should
> be fixed instead?

Looking at original BSP DRAM code, there is no data barriers that I can find.
Cache shouldn't be a thing before DRAM is initialized, right? Conversely,
I suggest adding memory barriers before each udelay(), as it is there for a
reason.

> 
> >  	/* Try to write different values to RAM at two addresses */
> >  	writel(0, CFG_SYS_SDRAM_BASE);
> >  	writel(0xaa55aa55, (ulong)CFG_SYS_SDRAM_BASE + offset);
> > diff --git a/arch/arm/mach-sunxi/dram_sun50i_h6.c b/arch/arm/mach-sunxi/dram_sun50i_h6.c
> > index bff2e42513..a031a845f5 100644
> > --- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
> > +++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
> > @@ -623,6 +623,8 @@ static void mctl_auto_detect_dram_size(struct dram_para *para)
> >  	para->cols = 11;
> >  	mctl_core_init(para);
> >  
> > +	udelay(50);
> 
> The location of that udelay() looks a bit odd, any chance that belongs at
> the end of mctl_channel_init() instead? And how did you come up with that
> and the value of 50? Just pure experimentation? I think the original BSP
> DRAM code has plenty of delay calls, so we might have missed this one
> here, but I would love to see some explanation here.

I checked original driver and we have *almost* all delays. There are two
missing. Both in mctl_phy_pir_init(). One before mctl_await_completion() and
another after it. Both are 1 us long.

Maybe that solves it (in combination with data barriers)?

Best regards,
Jernej

> 
> Cheers,
> Andre
> 
> >  	for (para->cols = 8; para->cols < 11; para->cols++) {
> >  		/* 8 bits per byte and 16/32 bit width */
> >  		if (mctl_mem_matches(1 << (para->cols + 1 +
> 
> 




