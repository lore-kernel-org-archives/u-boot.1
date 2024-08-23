Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A41C5321E
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 21:57:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 588B2889D0;
	Fri, 23 Aug 2024 23:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="elHIN6LU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBB4588B23; Fri, 23 Aug 2024 22:47:35 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A03D788B36
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6bf7a2035d9so32471426d6.1
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 13:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724446051; x=1725050851; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FDAdFBJ7wSGpFlyT7ZSxSlgKctSQJcHKYh+yRjEkv9Y=;
 b=elHIN6LUIqavT4GdGU/CsqVpNOQAjcIT7w0qL9r5L4Ma4OL6fJjkZnYZjbTfKcyCUN
 q9MTJ7iWtqSIUNIxGT33x7nmU5d9hBJQLekycDLfyeUdLsFbHK1gbIiEpToQxA6UP++D
 aJt0lrAGnL/YzFf9QjIEwA2Xh5vlEpp8fJN2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724446051; x=1725050851;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FDAdFBJ7wSGpFlyT7ZSxSlgKctSQJcHKYh+yRjEkv9Y=;
 b=SSHl3uHoxZvJZPSbKHg/V4so1Y3DyQ5FUAJrOT9zVHgAP5ZR/1fXITVfuy+nCEOHPd
 ikUx8ccyJEeYZJHmDF/aFT64/MOf6RdFVWoEiRvyg+ulEaIK+oNjMC6rPy0iUezvhjRH
 25DqHnzSsGIGqws0I9F6myKq7LBOgiuIGPZLzQi9fUQYRF1WIsfZERnuQJIz1BrTWoB+
 6ZGAlv6QmnJYrn9+7qrc5bYWiWmu3F64BOJLe3d+W5ZYM8vAEBRVo7mrfmPKCvigwW1c
 DjIud64+HWfqR8u31QFrw8sCxn5oviEHTay4PVeiY7F9/bziuwsRpDAwnItQ3AwxdnpD
 heYg==
X-Gm-Message-State: AOJu0YwyfGHezgSb0myJ29bukI1x6X1N1BxqU2pQFKXQ1CeojR372xiX
 3VB4qKXj1sCYnySFWjrZidDKbvZt37DXkqCIOMq74Zc+VUHTS93lqJtluhnlZby1t04SdJp7Vip
 mLHCqfgTS00wEJZGqzdvAru7WbLPt6Bcvdr9e
X-Google-Smtp-Source: AGHT+IGXvbHeqLFRYmpCLBri2xuQktWzZKlb0JDg6puWt3MAIy7lUqOLWwGcBYv/6r2UC1SqJhAFmnPOCWSe/VmBuJ4=
X-Received: by 2002:a05:6214:5293:b0:6bf:54fc:3d69 with SMTP id
 6a1803df08f44-6c160c667d2mr138117846d6.12.1724446051423; Fri, 23 Aug 2024
 13:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240807205032.3745680-1-sjg@chromium.org>
 <20240812165952.7d0da18d@donnerap.manchester.arm.com>
 <CAFLszThv2wHzV6FStwb3qfrR+Qq82kdp7qynWC4=xsw5m-JVxg@mail.gmail.com>
 <20240813133516.20c04cea@donnerap.manchester.arm.com>
In-Reply-To: <20240813133516.20c04cea@donnerap.manchester.arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Aug 2024 14:47:20 -0600
Message-ID: <CAFLszTj=NV1Fd5DoOeQH60eMYf=qgM9NRPmOhmd5W-kenyDjag@mail.gmail.com>
Subject: Re: [PATCH 0/6] bootstd: sunxi: Migrate to standard boot
To: Andre Przywara <andre.przywara@arm.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>, 
 Eddie James <eajames@linux.ibm.com>, Hans de Goede <hdegoede@redhat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Janne Grunau <j@jannau.net>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, 
 Maksim Kiselev <bigunclemax@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Mikhail Kalashnikov <iuncuim@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sam Edwards <cfsworks@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 23 Aug 2024 23:57:01 +0200
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

Hi Andre,

On Tue, 13 Aug 2024 at 06:35, Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Tue, 13 Aug 2024 06:17:17 -0600
> Simon Glass <sjg@chromium.org> wrote:
>
> Hi Simon,
>
> I had a bit deeper look yesterday.

Thanks for digging into this.

>
> > Hi Andre,
> >
> > On Mon, 12 Aug 2024 at 10:00, Andre Przywara <andre.przywara@arm.com> wrote:
> > >
> > > On Wed,  7 Aug 2024 14:50:26 -0600
> > > Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hey Simon,
> > >
> > > > This series attempts to migrate all sunxi boards to use standard boot,
> > > > along with a text environment.
> > >
> > > Ah, many thanks for that! I figured that we need a bootmeth for FEL, but
> > > never got around to have a closer look.
> > > On a coarse glance, this looks roughly OK, and doing a super quick boot
> > > test on one board, it seems to still work(TM), though the priority of the
> > > FEL boot is not right?
> >
> > Does it need to be the top priority, perhaps?
>
> Yes, please. It should only trigger when you a) do FEL booting and b)
> upload a boot script via FEL, in which case you surely want to execute
> that before anything else. From what I see the global EFI bootmeth is first
> in the list, but I couldn't find an easy way to fix this in the source
> file. Would that go through a platform specific bootmeths env variable?

We can just rename the bootmeth to be before the EFI mgr one.

>
> > > And I guess ditching the old kernel support might be a bit controversial.
> > > I think this is about the vendor kernels, which some people still rely on?
> >
> > OK, perhaps it is. It might be a little tricky to handle it, but I
> > suspect another bootmeth might be enough.
>
> Well, I had a look, and it looks like CONFIG_OLD_SUNXI_KERNEL_COMPAT
> covers multiple things:
> - it sets up some clocks slightly differently
> - it enters the kernel (stays?) in secure mode
> - it provides a custom boot script
>
> I think the latter can be replaced quite easily with something custom, and
> I guess it's the only one biting you? So I am OK with that going, but I
> think we should keep the first two features (and thus the Kconfig symbol).

Yes the script is the only issue and actually it doesn't affect
standard boot. So I can just convert it. I was just hoping to remove
some old code!

>
>
> Another thing I discovered: we lose USB support with patch 3/6. The reason
> is that USB support is enabled by having DISTRO_DEFAULTS. Just replacing
> that with BOOTSTD_DEFAULTS didn't work, though, I get a (ridiculous) splat
> about a circular Kconfig dependency. My hunch is that's something else not
> right in Kconfig, but I need to have a closer look.

Oh yes that is nasty. The problem goes back to BLK being selected by
various things, while BOOTSTD depends on it. I eventually found a
solution so will include that in v2.

Regards,
Simon
