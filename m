Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F33E7490C
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 18:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F066687127;
	Mon,  2 Oct 2023 20:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bLmgNxYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9607080422; Mon,  2 Oct 2023 20:59:40 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C0EC871A5
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 20:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-406618d0991so929495e9.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 11:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696273177; x=1696877977; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nyM9JKST+vyUpfpIzgRhL4Ixbp+hCT1k6SYuXKqFJpc=;
 b=bLmgNxYVhpmgL4ntHglZUfZnl1fWbyY+7miM0cFAtBmm+ifffTu6Tbvgbn5cLkZFy1
 gLeQhELAdr6uyIb6jnXlFAIdaN08bBBcE8P6zRMUFimxdjftS9VvfINEE4ZJDXYunXrP
 u8TO5z5BSpkkTumlXX401c67FgGV9gvqpFG+JR2UdBtji6evyqkqymdqOaxuFnPvPjIy
 Ga0YpuKLaw5va5FkndOfcZvosSYyw9+OomN+Rx1pPEVtryGO9MGIwUpv6huMTLP5cX7i
 wJnnGrYZNe+TTsbqNnV+NOlmjSwetkdLrsLwZmtXi+KLi4SIS0qY7U+RiHEvo30My1+V
 wr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696273177; x=1696877977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nyM9JKST+vyUpfpIzgRhL4Ixbp+hCT1k6SYuXKqFJpc=;
 b=PFnT/kQmZSvYhSI+e7ApXsPZzYJscJlA8ozeFrUpsGdqTzrrAnk2Qj24gjz4v8nFaX
 vbxN43gAdou9aU5urHB9kitt6+hW5drn1MhoEjwACdGyf27IbEBzUIKjHrheagXz/vVz
 CC1iN1lya/hAju8U9gw6ZnUCUd+IUnItVHhjYBWgou5dgi7JbccH2jPpOP9aTh9G0xQ0
 q8qgM15G87+aF0Z6hHn3FXxq+cIhjpEenXkkrqqj6SQ0walVhyuM+5eUCJoaoKlmYUVG
 XMrb8w7yyLO+z1j+xz6r+Ujgyho1Xk6vp7pyUA0MWPqrRvIixTmVYupE8DSGDLbdGp3f
 O6UQ==
X-Gm-Message-State: AOJu0YznvZ4TNhKuOo5UrxNpO2fgEFhys/x76C5RfcDMSFpi5fWF8xyo
 1wMMQixYxIkEM1CXLth5Dby55yjRzMtHpA==
X-Google-Smtp-Source: AGHT+IE9bwqY+E9H6zzAKUjBzDmdEHV6838TiX9ZUPjg24f+Y4+wJ5TpA86IcviLw2x3zHW9Nip2Vw==
X-Received: by 2002:adf:edc2:0:b0:321:6be7:d1be with SMTP id
 v2-20020adfedc2000000b003216be7d1bemr10990927wro.13.1696273176717; 
 Mon, 02 Oct 2023 11:59:36 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net.
 [82.149.12.148]) by smtp.gmail.com with ESMTPSA id
 p5-20020a5d4585000000b0031ad5470f89sm28608280wrq.18.2023.10.02.11.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 11:59:35 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>, Gunjan Gupta <viraniac@gmail.com>
Cc: u-boot@lists.denx.de, Ondrej Jirman <megi@xff.cz>,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH 1/1] sunxi: dram: Fix incorrect ram size detection for
 some H6 boards
Date: Mon, 02 Oct 2023 20:59:34 +0200
Message-ID: <4834802.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <CAJAzxbVw_TZ+eJ6uh63nCp5ggZR76k5bup49TkUtZV426M3R+Q@mail.gmail.com>
References: <20231001161336.31140-1-viraniac@gmail.com>
 <20231002122626.047b4043@donnerap.manchester.arm.com>
 <CAJAzxbVw_TZ+eJ6uh63nCp5ggZR76k5bup49TkUtZV426M3R+Q@mail.gmail.com>
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

Dne ponedeljek, 02. oktober 2023 ob 14:42:40 CEST je Gunjan Gupta napisal(a):
> > >  bool mctl_mem_matches(u32 offset)
> > >  {
> > > +     dsb();
> > This looks a bit odd, do you have an explanation for that? And are you
> > sure that is really needed?
> > I understand why we need the DSB after the writel's below, but before that?
> 
> I started with Ondrej Jirman's patch from LibreELEC's tree that had a
> dsb call added
> after the first writel call. That reduced the frequency of the errors
> but didn't removed
> it completely. My reason for moving it before the writel was to make
> sure any memory
> access is completed before starting the actual logic for the test.
> That reduced the
> frequency even further, but didn't resolve the issue. I did try
> removing it leaving only
> udelay added to the code, but that brings back the issue.
> 
> > The only thing I could think of is that we are missing a barrier in
> > mctl_core_init() - which is the function called before mctl_mem_matches().
> > Can you move that dsb(); into mctl_auto_detect_dram_size(), right after
> > the mctl_core_init() call (where you add the udelay() below)? And I wonder
> > if a dmb() would already be sufficient?
> 
> Sure, I will try experimenting with it.
> 
> > I noticed recently that the clr/setbit_le32() functions don't have a barrier at all, maybe
> > that should be fixed instead?
> 
> I haven't done much of the low level programming myself. Mostly have
> done user space
> programming along with fixing minor kernel module compilation issues
> due to kernel api
> changes. So I wasn't sure what all places to debug. But if you point
> me to places with
> things to try, I surely can give time playing around testing the proposed fixes.
> 
> > > @@ -623,6 +623,8 @@ static void mctl_auto_detect_dram_size(struct dram_para *para)
> > >       para->cols = 11;
> > >       mctl_core_init(para);
> > >
> > > +     udelay(50);
> > The location of that udelay() looks a bit odd, any chance that belongs at
> > the end of mctl_channel_init() instead? And how did you come up with that
> > and the value of 50? Just pure experimentation?
> 
> Before adding the udelay, I added 7 print statements to print all the
> members of the para
> struct. That itself solved the issue along with the dsb added to the
> top of the mctl_mem_matches
> function. This is what gave me the clue that a delay is needed there.
> The value of 50 is
> indeed from pure experimentation

Oh, I found one major difference between BSP and mainline driver. Please test
patch attached below. I don't know if this path is always taken when wrong
configuration is tested or not.

Best regards,
Jernej

--- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
@@ -420,6 +420,7 @@ static bool mctl_channel_init(struct dram_para *para)
                        (struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
        struct sunxi_mctl_phy_reg * const mctl_phy =
                        (struct sunxi_mctl_phy_reg *)SUNXI_DRAM_PHY0_BASE;
+       bool ret = true;
        int i;
        u32 val;
 
@@ -537,7 +538,7 @@ static bool mctl_channel_init(struct dram_para *para)
                        debug("DRAM PHY DX%dRSR0 = %x\n", i, readl(&mctl_phy->dx[i].rsr[0]));
                debug("Error while initializing DRAM PHY!\n");
 
-               return false;
+               ret = false;
        }
 
        if (sunxi_dram_is_lpddr(para->type))
@@ -553,7 +554,7 @@ static bool mctl_channel_init(struct dram_para *para)
        writel(0x7ff, &mctl_com->maer1);
        writel(0xffff, &mctl_com->maer2);
 
-       return true;
+       return ret;
 }
 
 static void mctl_auto_detect_rank_width(struct dram_para *para)





