Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE78AEEB572
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 13:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B868786844;
	Sat,  9 Sep 2023 15:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kDybCcV+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DF41869CD; Sat,  9 Sep 2023 15:27:42 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71700803AE
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 15:27:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=twoerner@gmail.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-41512bfdcfbso6413721cf.3
 for <u-boot@lists.denx.de>; Sat, 09 Sep 2023 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694266058; x=1694870858; darn=lists.denx.de;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwBC2uitJzCuK1t+9I8urlGkM2g+6KHw7KDtD1igGmw=;
 b=kDybCcV+6Aml8z5VT3+Foxlk5GEIAUvRdxNK0FuH9GlJnq90gl7TOYojIUhFk8KayX
 anL9+Ss3wcbX9FvP67ehhTVPn4A42nmZuRo+B6mjitmTUK8Bb8HZu59u84ZCu6VfOe41
 g8HqkxLkytrcveukLHhByOCnRZiTyduGyftEWYRC0Plr0ePTgQ/KP5pIGfmnVnNgPWWw
 XDAVK63jJlX3gtQsJfYNKTuebcCbnHpjNlLvCfOX8DpVhg3K/aocAaNBNB3TULt96Obu
 PfvcHbN3NyxE0yEUY7wbUtGEGAT9qjE4sVADSpEYPh+UmnfXkXRD/jRkQ5yuTNFGbc5o
 +MIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694266058; x=1694870858;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MwBC2uitJzCuK1t+9I8urlGkM2g+6KHw7KDtD1igGmw=;
 b=gaMmGrtcMyYV2sNIPAieLYyYdCYVL/3ZCN71HYcevLYrVrYULuj+IaHC3y2zsRpyJm
 QXFFIWRiD2jPPjQJ2xY79CToTvfVv2NEz7vRVByIH1J78cdLudyZrFGnq7eSa0K8FOES
 qBuFRiGdHdBRek6+q11UWuCYbP5r4eFmoV21NtXpgs8GXwbgxxCAlwgVyQRMxKj69Yxd
 RJV9y1wbwYIExCKHlaxom58nyl3cTjdCRK3WvesWsRJD4gugdAQQfKrZPz3jkvRWqt1f
 2IONp7cRVLq6lbJGNod2VvRLwMxzwxViWZmJCOzoeUjRB3vAe49eLlF4zwp66BYWzY3Q
 D3uQ==
X-Gm-Message-State: AOJu0YySx9mdX0Jbt2UAAyLvn3tuxvJTIa6uU3fIlpZY5AZ6UWdAtiXm
 /+oAyXSBS7JKzYGoTYESe4qdoOBErAw=
X-Google-Smtp-Source: AGHT+IHxWcOX73nm0jzM4zX0T8jcO/ToeQB0chsTY9BBNZgVfpt+QXf7YkIz82/oOSVhprPPg/jMWw==
X-Received: by 2002:ac8:4e8b:0:b0:412:1c47:773b with SMTP id
 11-20020ac84e8b000000b004121c47773bmr6591410qtp.63.1694266057926; 
 Sat, 09 Sep 2023 06:27:37 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
 by smtp.gmail.com with ESMTPSA id
 j13-20020ac806cd000000b0040fd47985e6sm1320196qth.97.2023.09.09.06.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 06:27:36 -0700 (PDT)
Date: Sat, 9 Sep 2023 09:27:34 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Nishanth Menon <nm@ti.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Pierre Lebleu <pierre.lebleu@pile-engineering.com>,
 Andrew Davis <afd@ti.com>
Subject: Re: [PATCH] ARM: dts: am335x-pocketbeagle: choose tick-timer
Message-ID: <20230909132734.GA9887@localhost>
References: <20230830152553.15465-1-twoerner@gmail.com>
 <20230908173617.7c2xto3n4hqltnf2@ferris>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230908173617.7c2xto3n4hqltnf2@ferris>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Fri 2023-09-08 @ 12:36:17 PM, Nishanth Menon wrote:
> On 11:25-20230830, Trevor Woerner wrote:
> > Commit 4b2be78ab66c ("time: Fix get_ticks being non-monotonic")
> > requires '/chosen/tick-timer' in device-tree. Otherwise we get:
> > 
> > 	U-Boot 2023.07.02 (Jul 11 2023 - 15:20:44 +0000)
> > 
> > 	CPU  : AM335X-GP rev 2.1
> > 	Model: TI AM335x PocketBeagle
> > 	DRAM:  512 MiB
> > 	Core:  154 devices, 16 uclasses, devicetree: separate
> > 	Could not initialize timer (err -19)
> > 
> > 	resetting ...
> > 
> > Suggested-by: Pierre Lebleu <pierre.lebleu@pile-engineering.com>
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >  arch/arm/dts/am335x-pocketbeagle.dts | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/dts/am335x-pocketbeagle.dts b/arch/arm/dts/am335x-pocketbeagle.dts
> > index b379e3a5570d..02e3aac56064 100644
> > --- a/arch/arm/dts/am335x-pocketbeagle.dts
> > +++ b/arch/arm/dts/am335x-pocketbeagle.dts
> > @@ -15,6 +15,7 @@
> >  
> >  	chosen {
> >  		stdout-path = &uart0;
> > +		tick-timer = &timer2;
> >  	};
> >  
> >  	leds {
> > -- 
> > 2.41.0.327.gaa9166bcc0ba
> > 
> 
> Does enabling CONFIG_SYS_ARCH_TIMER solve this?

Enabling CONFIG_SYS_ARCH_TIMER causes the following compile error:

	| arm-oe-linux-gnueabi-ld.bfd: arch/arm/cpu/armv7/arch_timer.o: in function `timer_init':
	| /z/build-master/pocketbeagle/build/tmp-glibc/work/pocketbeagle-oe-linux-gnueabi/u-boot/2023.07.02/git/arch/arm/cpu/armv7/arch_timer.c:29: multiple definition of `timer_init'; arch/arm/mach-omap2/timer.o:/z/build-master/pocketbeagle/build/tmp-glibc/work/pocketbeagle-oe-linux-gnueabi/u-boot/2023.07.02/git/arch/arm/mach-omap2/timer.c:44: first defined here
	| arm-oe-linux-gnueabi-ld.bfd: arch/arm/cpu/armv7/arch_timer.o: in function `get_ticks':
	| /z/build-master/pocketbeagle/build/tmp-glibc/work/pocketbeagle-oe-linux-gnueabi/u-boot/2023.07.02/git/arch/arm/cpu/armv7/arch_timer.c:44: multiple definition of `get_ticks'; arch/arm/mach-omap2/timer.o:/z/build-master/pocketbeagle/build/tmp-glibc/work/pocketbeagle-oe-linux-gnueabi/u-boot/2023.07.02/git/arch/arm/mach-omap2/timer.c:97: first defined here
	| arm-oe-linux-gnueabi-ld.bfd: arch/arm/cpu/armv7/arch_timer.o: in function `get_tbclk':
	| /z/build-master/pocketbeagle/build/tmp-glibc/work/pocketbeagle-oe-linux-gnueabi/u-boot/2023.07.02/git/arch/arm/cpu/armv7/arch_timer.c:63: multiple definition of `get_tbclk'; arch/arm/mach-omap2/timer.o:/z/build-master/pocketbeagle/build/tmp-glibc/work/pocketbeagle-oe-linux-gnueabi/u-boot/2023.07.02/git/arch/arm/mach-omap2/timer.c:108: first defined here

Without CONFIG_SYS_ARCH_TIMER, the functions timer_init(), get_ticks(), and
get_tbclk() are defined in arch/arm/mach-omap2/timer.c. When
CONFIG_SYS_ARCH_TIMER is defined, it also pulls in the file
arch/arm/cpu/armv7/arch_timer.c.

There is a config option, CONFIG_TIMER, that controls the inclusion of
arch/arm/mach-omap2/timer.c, but it is unconditional during SPL:

	arch/arm/mach-omap2/Makefile
	...
	 12 ifeq ($(CONFIG_TIMER),)
	 13 obj-y   += timer.o
	 14 else
	 15 ifdef CONFIG_SPL_BUILD
	 16 obj-y   += timer.o
	 17 endif
	 18 endif
	...

So whether CONFIG_TIMER is defined or not, a compile error will result if
CONFIG_SYS_ARCH_TIMER is also defined.

Getting the code to compile with CONFIG_SYS_ARCH_TIMER would require a deeper
reworking of the configuration/Make logic in order to swap out the functions
in arch/arm/mach-omap2/timer.c for the ones in
arch/arm/cpu/armv7/arch_timer.c. The definitions of those functions in both
those locations are quite different, so even after getting the build to work
there's no guarantee the arch functions would work.

Best regards,
	Trevor
