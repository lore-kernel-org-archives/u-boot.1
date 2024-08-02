Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6815C52D6F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 15:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 365E488B80;
	Fri,  2 Aug 2024 17:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LG1BCtc3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CE3588BB4; Fri,  2 Aug 2024 17:04:39 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2148988B22
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 17:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3daf0e73a5bso5434596b6e.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 08:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722611076; x=1723215876; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=4wr3zAk5fhLx5Q6lEcEAv+F5CVjsIUuiddTnX6LD5eA=;
 b=LG1BCtc3SflANtuO/bAyMoRli8PSqJhv413nDNpbr3jT+A2JEUfbKpCR3ix3ytdrmv
 iFZ6MayGInRIU2zykR0cl2GTPIfnAtuT/CxIAvaY3h8ILNcMeUqTSVJBndujXEoFOq67
 QYtOMzV7+fAA90Ofd3Si/FYclW0r96xzvXOwHQNYLeKKAC9ZcoI4P14YnkEmLTLLqU4h
 bN1CVMvCYg6yWfxgbdcu5NGZ8/yYeEwQ1tmIrDmR1hPSYVXM4Oq6t788XRazF8A18Seb
 FLqqlyfPsF+jmOq+Drjhe1wLUfQ7sReTUqUYK6/n57YQ+EgH+pJKOweawDKVLxpIp937
 JMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722611076; x=1723215876;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4wr3zAk5fhLx5Q6lEcEAv+F5CVjsIUuiddTnX6LD5eA=;
 b=BKjfLOzTJgNbtz9OD0cYqGmpSsvUD/USKH1yiOW7sGq70KiBfzvgoVe2qdMkfYztxr
 B6RheejEOTeiuC9lK71TsXyPHaaivcCA9dkj5KpZrL0TFM7Y/j6HOXJP9Xw39M2S7FaT
 sspMMUTPZxINARfu6XJaHraEJzFQTRdjLFOxhhhpUIMrSWTYJKeB9fkq2fWhvNoq1LWu
 wQFTzeOlGT0qzfzwdISmE/InuWpAi0u1RhsQA9aqMWgvzcFrSckzduygr+UoOGAcONfX
 Bxgz3lZkJJy8c7ialelowQc301CvT0I2Kran0DJ0d9XawbioEc+a90A2Zb4IcLt5jdO9
 EJCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzXmsB047V1EfZ9fz8tbc6Ew6M66d8tP34ASMml7PF5tFvYzwZ4yIHdjQaVMQREfaCzTh5sFAwz25iv0l64rQ5UNS65g==
X-Gm-Message-State: AOJu0Yz4bMEK2k8PGebzlN/f8QW/Y+F/QBVJjlBzsDTlY+8DhnGF3NoG
 pGm+IdRPb7P+J+HKb1SA1NsKvqEEoq1zQmnjFUxXNtxbjkxu5OtO
X-Google-Smtp-Source: AGHT+IHUHAn8SA8HUQPAPDCNPGn2Bzf5+bYBoI/TIdBuZGKx2BKgq0MdLv4kfAd6si17RsGHrMt8qw==
X-Received: by 2002:a05:6808:2014:b0:3d9:e22a:8fb8 with SMTP id
 5614622812f47-3db55818184mr5126020b6e.26.1722611075685; 
 Fri, 02 Aug 2024 08:04:35 -0700 (PDT)
Received: from neuromancer. ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db5637117csm431705b6e.23.2024.08.02.08.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 08:04:35 -0700 (PDT)
Message-ID: <66acf583.050a0220.3cb48d.242d@mx.google.com>
X-Google-Original-Message-ID: <Zqz1glvIw+SPNhe1@neuromancer.>
Date: Fri, 2 Aug 2024 10:04:34 -0500
From: Chris Morgan <macroalpha82@gmail.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de,
 sjg@chromium.org, jernej.skrabec@gmail.com,
 neil.armstrong@linaro.org, hdegoede@redhat.com,
 jagan@amarulasolutions.com, trini@konsulko.com, ryan@testtoast.com,
 Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 9/9] sunxi: Add support for Anbernic RG35XX-2024
References: <20240801225519.336667-1-macroalpha82@gmail.com>
 <20240801225519.336667-10-macroalpha82@gmail.com>
 <CAFA6WYP7fnswZ4BHtqd+nKT7MZeBrKgocQf-WpJ7-HqjBOaFvQ@mail.gmail.com>
 <20240802105719.0dab15cb@donnerap.manchester.arm.com>
 <CAFA6WYMqYx-sEYTKcNPDbqYii_67YVUq1xnKKRjH+F7FjOMacw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYMqYx-sEYTKcNPDbqYii_67YVUq1xnKKRjH+F7FjOMacw@mail.gmail.com>
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

On Fri, Aug 02, 2024 at 04:08:39PM +0530, Sumit Garg wrote:
> Hi Andre,
> 
> On Fri, 2 Aug 2024 at 15:27, Andre Przywara <andre.przywara@arm.com> wrote:
> >
> > On Fri, 2 Aug 2024 12:24:56 +0530
> > Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Sumit,
> >
> > > Hi Chris,
> > >
> > > On Fri, 2 Aug 2024 at 04:29, Chris Morgan <macroalpha82@gmail.com> wrote:
> > > >
> > > > From: Chris Morgan <macromorgan@hotmail.com>
> > > >
> > > > The Anbernic RG35XX series of devices are based around an Allwinner
> > > > H700 SoC with 1GB of RAM, 2 SD cards, and multiple input buttons.
> > > >
> > > > This bootloader has been tested on the Anbernic RG35XX-2024 and
> > > > RG35XX-H, but should be suitable for the entire lineup of H700 based
> > > > devices.
> > > >
> > > > A future series of updates will add board selection logic to identify
> > > > and load the correct device tree automatically, and will switch to
> > > > utilizing a mainline device tree.
> > >
> > > I can already see the upstream DT subtree containing DTS for this board as:
> > >
> > > ./dts/upstream/src/arm64/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
> > >
> > > Are there any major differences that won't allow you to switch to
> > > OF_UPSTREAM for this board?
> >
> > In this case there are no differences between the DT in the kernel repo
> > and what we put in U-Boot. The main reason for me holding back the switch
> > to OF_UPSTREAM for the H616 was indeed the rather slow update cadence,
> > which somewhat slows down upstreaming of new boards like this. Doing this
> > separately gives us a bit more control and freedom to take DT patches
> > early, for instance when they appear in some Linux -rc1, or even before
> > that (linux-next).
> > I explained my position in more detail here:
> > https://lore.kernel.org/u-boot/191A0F66-E2AE-4D1B-ACBE-E411E135BB61@arm.com/
> >
> 
> I can see the reasoning, thanks.
> 
> > I think Tom partly convinced me that regular updates together with
> > cherry-picking should solve most of those problems, so I will probably do
> > the switch for the next cycle.
> >
> 
> Glad to hear that. Cherry-picking has been working really well for
> Rockchip platforms [1] [2] [3] as the changes appear in Linux -rc1.
> Also, it pretty much avoids maintainers to review the DT changes
> unless there are some bits added via *-u-boot.dtsi.
> 
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=417233
> [2] https://patchwork.ozlabs.org/project/uboot/list/?series=417377
> [3] https://patchwork.ozlabs.org/project/uboot/list/?series=417353
> 
> -Sumit

The specific differences between this and the upstream tree is that the
upstream tree is missing the switch from rsb to i2c for the PMIC. That
said, if we can cherry pick the change (it was just accepted and should
end up in 6.12) that would work and I can start from the get-go with an
upstream tree. There may be other differences, but they are ultimately
superficial for U-Boot. I'll still make this for the RK35XX-2024 only
for now, because I need to finish some stuff in the detection logic.

Thank you.
Chris
