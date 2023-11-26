Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADC0C4167B
	for <u-boot@archiver.kernel.org>; Sun, 26 Nov 2023 12:55:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E43E86EE0;
	Sun, 26 Nov 2023 13:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lu+i9o8Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F6B286EE2; Sun, 26 Nov 2023 13:55:16 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E739286C33
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 13:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4083f613275so26066315e9.2
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 04:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701003312; x=1701608112; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YtcA5b6GbR7/vHA9l1lF9v9C2/MzYffk/XAE//0ZIJM=;
 b=lu+i9o8Zx5J5kkST0ZPKhbiTaGCa4Whn+S0vA4ErknXtVFuekUq3cBllXsm0pKm3J0
 mJ7hz+cfhOLBcl6TXDnuZvc/HKrkqoi28pEQ1BdkHNlDH+o1RVVT+2Kb2iUBaKfESD35
 rzv3Qs9tKr45KxospjGzCoG4TB7TEXAlB88zMf5/a+Z8i6C0gs/4kxC6L/vUUTAzCTUP
 ORg+mWg/2aADeIzRN9SWK7/sfUcL45cjSu8xH0jVKfgRbckBsyAli1xiRrRmerG/1xyt
 wMYUXptDtle8WKkOGFhPm5BvhkfE5o7bkEq1o1BCwiqK7O2Juxw5oYbTQZDWgD8fLOgs
 W5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701003312; x=1701608112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YtcA5b6GbR7/vHA9l1lF9v9C2/MzYffk/XAE//0ZIJM=;
 b=HBGI/XXR/FDyuXSpPLy2iv9iQgU8rZV3T7yoOQpTTbAEzJrcvkksoyObKuiQb+CqTZ
 T6nOSnRTVliqQjzEl7iRo9Jh6LhQsPvnnT8UUM2xekyPG4qGQtS7H3SokQeGl9Yjbosk
 3qOI8cdee7ezssnvvrvoWaFgf7DgfuhlED1jhQ2HCa5xRsro7czEkB8ALPCCNmWgZ/Ku
 1gNaly48EJwYOhc7YVMhWX6S/F/8USOkHMfM3+l4sg0H+bBeeAFQN+FgxERVvuCGNhGw
 GxQufBEG1aW/nr2urOcdb7ssULTQhqyfh4lptGnUSdFYYY+TD4kvhK1iR71+UatXRS/H
 uG7Q==
X-Gm-Message-State: AOJu0YykVaYsNOA3rLXm/xSoxcIA5JCK8Ad5uUcfShoDQJDQVNjfZg8W
 MJw8qF++lZA5i/Iygo/y6+8=
X-Google-Smtp-Source: AGHT+IHRdEnu0UinauuCnMo9zKzDcmIZJhFoyIPjscIIJl0UW3IdmpQSj2qPBGXR4kocK9gG8xhkYw==
X-Received: by 2002:a05:600c:1c81:b0:40b:3938:65fc with SMTP id
 k1-20020a05600c1c8100b0040b393865fcmr2770257wms.4.1701003312061; 
 Sun, 26 Nov 2023 04:55:12 -0800 (PST)
Received: from jernej-laptop.localnet (APN-123-253-119-gprs.simobil.net.
 [46.123.253.119]) by smtp.gmail.com with ESMTPSA id
 k24-20020a5d5258000000b00332c0aace23sm9171800wrc.105.2023.11.26.04.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Nov 2023 04:55:11 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Bob McChesney <bob@electricworry.net>,
 Andre Przywara <andre.przywara@arm.com>
Cc: electricworry <worryelectric@gmail.com>, u-boot@lists.denx.de,
 "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
 Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: Re: Adding support for Orange Pi Zero 3
Date: Sun, 26 Nov 2023 13:55:10 +0100
Message-ID: <5729464.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20231126123351.7275f4c7@slackpad.lan>
References: <CABZPTZSQHhcVuqLmg6nEiKBfF4p+R+y5sDCGaa19qztSEs54BA@mail.gmail.com>
 <ZWMs0z6ED1ukmRGU@BOB1> <20231126123351.7275f4c7@slackpad.lan>
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

Dne nedelja, 26. november 2023 ob 13:33:51 CET je Andre Przywara napisal(a):
> On Sun, 26 Nov 2023 11:32:35 +0000
> Bob McChesney <bob@electricworry.net> wrote:
> 
> Hi Bob,
> 
> thanks for the reply!
> 
> CC:ing Jernej for the THS SRAM issue and the HDMI support mentioned
> below.
> 
> > On Thu, Nov 23, 2023 at 03:17:09PM +0000, Andre Przywara wrote:
> > > On Sat, 4 Nov 2023 19:17:44 +0000
> > > electricworry <worryelectric@gmail.com> wrote:
> > > 
> > > Hi,
> > >   
> > > > I would like to contribute improvements u-boot to enable support for
> > > > the Orange Pi Zero 3 board. I have already gained a good understanding
> > > > of the project and the standards for changes, and so I have made
> > > > modifications and tested them on my board.  
> > > 
> > > thanks for your interest and for reaching out!
> > > 
> > > I will answer your questions below, but for this particular topic there
> > > are already support patches on the list (sorry for the disappointment!):
> > > https://lore.kernel.org/u-boot/20231114013106.31336-1-andre.przywara@arm.com/  
> > 
> > That's good. I'm happy that more experienced people have been working on
> > this. It's been a good learning experience nevertheless.
> > 
> > > Can you please apply those patches on top of mainline U-Boot and test
> > > them? Then reply to patch 3/3 above with a Tested-by: line, stating your
> > > name and email address?
> > > Having independent reports of that working would make me more confident in
> > > merging the series.  
> > 
> > I'm happy to do that and will be able to do it shortly. In this case
> > would I be applying the patches on top of the next branch?
> 
> The normal master branch would be safer. I don't typically work on the
> next branch, and there might be changes in there which subtly break
> sunxi.
>  
> > > As a general advice: try to reach out early, to avoid working in parallel
> > > on something, and also to avoid working in the wrong direction.
> > > There is the #linux-sunxi IRC channel on the OFTC IRC network[1] (you can
> > > join via any browser), also there is a mailing list for Allwinner related
> > > upstream work: linux-sunxi@lists.linux.dev [2]
> > > Another resource is our wiki: https://linux-sunxi.org
> > > 
> > > [1] https://www.oftc.net/WebChat/
> > >     https://oftc.irclog.whitequark.org/linux-sunxi
> > > [2] https://subspace.kernel.org/lists.linux.dev.html  
> > 
> > Thank you. I wasn't aware of this community and have been working alone.
> > It will be more productive to work and discuss with others so I'll join
> > that mailing list too.
> 
> Yeah, the IRC chat is the most responsive and most helpful, I find, so
> try to join that.
> 
> > 
> > > > Before submitting patches for review I've got a few questions I'd like
> > > > to discuss.
> > > > 
> > > > The board is an Allwinner H618. From what I can gather this is just an
> > > > H616 with minor changes. The changes are so minor that I've been able
> > > > to implement the support as changes to the existing files for H616.  
> > > 
> > > Just curious, what changes did you find in particular? So far we know
> > > about the increased L2 cache, which is irrelevant from a software support
> > > perspective, and the change of base address and layout of the CPUX_CFG
> > > block, which is already covered by:
> > > https://source.denx.de/u-boot/u-boot/-/commit/0a137ac5015933bf38ea2700abe70602ef63bbdd
> > > Did you find anything else?  
> > 
> > I am not what anyone could call a hardware expert so I've just been
> > working by diffing the codebase from the vendor against u-boot mainline.
> 
> Most of us are indeed curious software developers, and we typically do
> a mixture of looking at vendor code, checking manuals, and doing live
> experiments to figure things out.
> 
> > Changes that I've created patches for include their full dtb, the LPDDR4
> > support, the AXP313A power, and - perhaps incorrectly - zeroing a
> > register so that the thermal driver in the kernel works properly and
> > doesn't get false high temperature readings.
> 
> Ah, glad I am not the only one seeing this!
> I strangely haven't seen this all the time, but I indeed now need to do
> a "mw.l 0x3000000 0x7ffeffff" in U-Boot, otherwise I see the kernel
> screaming about +200C temperatures.
> 
> > I say "perhaps incorrectly"
> > because I feel like the kernel driver should be doing that work itself
> > and the comment in the vendor u-boot code suggests it's a hack: "The
> > bit[16] of register reg[0x03000000] must be zero for the THS driver to
> > work properly in the kernel. The BSP u-boot is putting the whole
> > register to zero so we are doing the same."
> 
> Very good, you are exactly on the same path as I am! I have a patch for
> the THS driver that tries to clear the bit, via using the regmap
> exported by syscon, but I need to test this further (was my plan for
> today). I think this was somehow not working properly the last time I
> checked.
> Another approach was trying to claim an SRAM region - as this is what
> this register does for the video engine (VE). I figured that apparently
> just bit 0 switches the SRAM to the VE, and flipping all 31 bits might
> be some anachronism from the olden A10 days.
> So we might claim that bit 16 switches the SRAM for THS, but then I am
> not sure it really has something to do with SRAM, or if it's just
> another Allwinner special of "oh, we have an unused bit in this
> register" ;-)
> We will see what the list has to say about this.
> 
> > > Out of interest, how did you do this? Disassembled the vendor boot0?
> > > Dumping DRAM registers? We discussed and tested the LPDDR4 support already
> > > a while ago, and support for that was merged recently:
> > > https://source.denx.de/u-boot/u-boot/-/commit/4b02f0120a4bb2a5d7081aef8cef6a4ca57e9db2  
> > 
> > As above, I didn't do anything clever like probe hardware or
> > disassemble binaries; it was just a brute force loop of cherry-picking,
> > compiling and testing. And also doing it in a way that fitted the
> > incumbent style and practices of mainline. e.g. making use of configs
> > like CONFIG_DRAM_SUN50I_H616_DX_ODT for the board family rathern than
> > having board specific ifdefs. The work done is available if anyone wants
> > to see it, and I'd be happy to have it critiqued. Looking at the patches
> > proposed here I'm happy to see that we've come to the same conclusion on
> > some things (such as the above config) and others we diverge on, but as
> > I can see from the discussion in linux-sunxi the feeling is that some of
> > these difference don't matter.
> > 
> > > Hope that helps!
> > > 
> > > Cheers,
> > > Andre  
> > 
> > Thanks for all of that good advice. It's immensely appreciated. I'll
> > keep this as a guide for contibuting patches in the future.
> > 
> > Now that there's a working u-boot for the board - I've got two to choose
> > from now :) - I'm going to be concentrating on trying to get the Mali
> > graphics working as it's a requirement for my project. I've got a
> > working kernel (6.1.31 with patches) but I can also see that work's been
> > underway to bring the support to 6.7. I tested 6.7-rc2 today and can't
> > get any output at all on the console after u-boot starts the kernel.
> 
> Yeah, that's because we don't have any video (HDMI) output support
> (something completely unrelated to Mali, which is just a 3D renderer!)
> yet in mainline. Jernej was sitting on *some* patches for a while, but
> didn't have the time to upstream them, and IIUC there is something odd
> to fix first before it's mainline ready.
> There are some rough bits in here, and in other repos floating around:
> https://github.com/jernejsk/linux-1/commits/h616-hdmi-v2

That one is old. Most recent development is in
https://github.com/jernejsk/linux-1/commits/h616-var

However, note that there is quite a lot of work to do before it could
be mainlined.

Best regards,
Jernej




