Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52503C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 13:41:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9D01877A1;
	Wed, 20 Dec 2023 14:41:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CVds0yIP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25B0E877A1; Wed, 20 Dec 2023 14:41:35 +0100 (CET)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CA3B877B0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 14:41:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7cb66aa0a62so723609241.3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703079690; x=1703684490; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=md9E5mLeLouK9uKNB5ejrZhS4Rb0/93xO0dOsJEslD8=;
 b=CVds0yIPcrkEFuAnf7A9IDFnFIQKbvTA02dhpLsUDIwr/whG0q/I6iWnJuJ8fHXeHc
 PxjlnD2iOzJLbzQFejP0WMxmYN58+UxSPLAt55RwnjXFgPOHVH7AyC1NSiQcvhJsK3cG
 5N1Qtu7sz5deJxw07wdvEaTat8BymUS3e2ZK4tzR4etOQU5FpKGTJIJOSC4XRKEXNYnl
 s5ZKbX5cBReRubj7x9aa3envlBYzHwc/XrBv6IAXCax/5udWtGPFHepLhifJ953vHb43
 3tBkjRPAYua1QnkHZO0lkxvU+ZeocVPbEaERJ0QS50NdBx3VHcaB8qnlaRF1QjpNBMuC
 MmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703079690; x=1703684490;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=md9E5mLeLouK9uKNB5ejrZhS4Rb0/93xO0dOsJEslD8=;
 b=OdqRQTs0sRfhoLgmf6rQrK7GJzTBFtXgk7c6mfVkFXO7E7tG4j/NGEkywDNkBOEsY+
 PXK7x7koZd9C8YKIP877a+v0CeaG5OwehXBxXq/iN0IDB88K2TVZHdb6JU9KqnBizdEC
 mfwbXCDehxJkokAeH0Tp2mMzV6gdqytwtF7APAIpbk6vwT3oLFnVGhSH10EkL+/LArnD
 3Hp0yVVOTKreCbRGdBvgsly5dBuU1WGUXsoHqWcOBKELHx49oXKF4I6+RfhF1SrwJoCi
 X6sfxbzsZdh+7mNXVMIYEYon082KMUKdAe+WOGo7kNcDsHqF71+vx0+xmAuTJ/Cbjwq4
 b35g==
X-Gm-Message-State: AOJu0YzkJHNqtXwB7UIl9Rbi8RtdNY7t86Q1nJJtbz/aFtOohTHDsc7h
 kKN0TW0iyZ2BkRjyH7b3Z9U8OVqG+NC2+HT/HpDsGA==
X-Google-Smtp-Source: AGHT+IEy92Cix0RhwuYgeQFCIK0/I83rJ3PsorFTJiaytY3V7u5B7P3PCPZQh3dx3PjO+pdHeCIX9A3y6F4B4JjNOsA=
X-Received: by 2002:a05:6102:5586:b0:466:afed:f2d2 with SMTP id
 dc6-20020a056102558600b00466afedf2d2mr1484922vsb.16.1703079690347; Wed, 20
 Dec 2023 05:41:30 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-4-sumit.garg@linaro.org>
 <CAPnjgZ0h5u8TS=SwAkSgAmbmJiTFriqY8Le++pfS=Yp7R+yabQ@mail.gmail.com>
 <CAFA6WYOYV=Aob+x10XfpagiDoDC1AhiwvT=mc3cQfr4VGj1kxQ@mail.gmail.com>
 <20231220132903.GL2513409@bill-the-cat>
In-Reply-To: <20231220132903.GL2513409@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Dec 2023 19:11:19 +0530
Message-ID: <CAFA6WYNS9yksD+e7ZJo46cnPufuviN6js5=yCK4SXN_qLrFgBA@mail.gmail.com>
Subject: Re: [PATCH 3/8] scripts/Makefile.lib: Statically define *-u-boot.dtsi
 files location
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 20 Dec 2023 at 18:59, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Dec 20, 2023 at 05:00:20PM +0530, Sumit Garg wrote:
> > On Wed, 20 Dec 2023 at 10:17, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Thu, 14 Dec 2023 at 06:52, Sumit Garg <sumit.garg@linaro.org> wrote:
> > > >
> > > > Allow u-boot to build DTB from a different directory tree such that
> > > > *-u-boot.dtsi files can be included from a common location. Currently
> > > > that location is arch/$(ARCH)/dts/, so statically define that common
> > > > location.
> > > >
> > > > This is needed for platform owners to start building DTB files from
> > > > devicetree-rebasing directory but still being able to include
> > > > *-u-boot.dtsi files.
> > > >
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >  scripts/Makefile.lib | 25 ++++++++++++++-----------
> > > >  1 file changed, 14 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > > index 27b9437027c..4a002b0e0ca 100644
> > > > --- a/scripts/Makefile.lib
> > > > +++ b/scripts/Makefile.lib
> > > > @@ -159,18 +159,20 @@ cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE)     \
> > > >  ld_flags       = $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
> > > >
> > > >  # Try these files in order to find the U-Boot-specific .dtsi include file
> > > > -u_boot_dtsi_options = $(strip $(wildcard $(dir $<)$(basename $(notdir $<))-u-boot.dtsi) \
> > > > -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
> > > > -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
> > > > -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
> > > > -       $(wildcard $(dir $<)u-boot.dtsi))
> > > > +UBOOT_DTSI_LOC = $(srctree)/arch/$(ARCH)/dts/
> > >
> > > How about lower case since it is internal. Also we know it is U-Boot,
> > > so perhap  ?
> >
> > Although I just named it after *-u-boot.dtsi, I am fine with dtsi_loc
> > too. So I will use that instead.
>
> I was going to say lets use "uboot_dtsi_loc" so it's both clear what the
> variable does and for future re-syncs.

Okay that makes further sense. I will use it if I don't see any
objection from Simon.

-Sumit

>
> --
> Tom
