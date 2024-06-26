Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DD1C30653
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 08:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E9D1884F1;
	Wed, 26 Jun 2024 10:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DTHs99V2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EAD4884EA; Wed, 26 Jun 2024 10:00:59 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A6E0884F6
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 10:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-711b1512aeaso4988528a12.3
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 01:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719388856; x=1719993656; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WGltA4EiuESfZLm6sDeUq58UaU4h2wxQP+yxiYuX6vg=;
 b=DTHs99V25jQ0/a4B6O+8EXPHO2xlI4ZT+XXT+eb2gEIXMXgAdM1PSewo3Unrm1D/o/
 LwjB9fWi671M3kmlpna3gMM9DSjsW5aMXzHxEBzPY87R9N5ChShhD3pg5OCR1/K9LNfy
 JTYNcLO1oOxS7vcvNHBq7GdCsE2G+9a8Hz4lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719388856; x=1719993656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WGltA4EiuESfZLm6sDeUq58UaU4h2wxQP+yxiYuX6vg=;
 b=Nsy3hNiS7lleLxWvzwJ5/DMAVi958H84tVTii/XExXW76s9ny0xFvczhxYfskiRQjb
 F2tkL4QwVw48IHFZDbgx7sltHj8SfXsfHodyNhE+cLwUfC2LMPy3cDK1EClVtnaYNqxs
 Ur7f0ZQg8bkR+vO4py9VED2jnyK7F4WwgCvPOZ/mMG90hxK1pwILfqi54pEjn7751Zw7
 4kV3jFzdEgjuOdO2nQV8n5LNucMLPFkFKuJK7NR0l3Dsw/ywl8jNJZjdcJkA/vUbAZT2
 Ix+Yh1KWpSz1Bzz2EzCKbPUvyTzIIIhm3FvF96URX7iEkIyd+ejdemXvzHGqI/sexVpA
 NPXg==
X-Gm-Message-State: AOJu0Ywp/ZreRqyPketcW8a3lL9zhRafvaEcQr4JgaMo5Cm/SAoUpx79
 A9lsP0cOC1UY57py9Zr8U79ciWVu8pc6bejODcT41QkAGCGzaqjwCnIYeWcvouJQlXRacmXTKWi
 M/ZqHyDOOPuQfeNFAaxGpJfunTTP9svqTeBz2C5alFvSuEmfG4A==
X-Google-Smtp-Source: AGHT+IHtLY5M6nBD1y5s4dJQoTlh+KahPR578jKQqK3so6tYPUNNOqKLeHmuRdP7YSRpmZRGVLG6vTGoLOYC+P8QGjE=
X-Received: by 2002:a17:90b:4b50:b0:2c8:a8e:8eff with SMTP id
 98e67ed59e1d1-2c85819b635mr9270963a91.1.1719388855701; Wed, 26 Jun 2024
 01:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240623203033.1566505-1-sjg@chromium.org>
 <20240623203033.1566505-14-sjg@chromium.org>
 <20240624182931.GI38804@bill-the-cat>
 <CAFLszTguTkc1m2JYb=5+yW_8uY+J0AsQZ_L0hFJHDfEXNeb0wQ@mail.gmail.com>
 <20240625141427.GO38804@bill-the-cat>
In-Reply-To: <20240625141427.GO38804@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 26 Jun 2024 09:00:41 +0100
Message-ID: <CAFLszTi1i+OrAyoyqRLZAuKzGTmAgNQ9Gwtn01XxVLvGmzZLcQ@mail.gmail.com>
Subject: Re: [PATCH 13/14] Update u-boot.cfg to include CFG also
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Tue, 25 Jun 2024 at 15:14, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jun 25, 2024 at 01:38:04PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 24 Jun 2024 at 19:29, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Jun 23, 2024 at 02:30:32PM -0600, Simon Glass wrote:
> > >
> > > > Some configuration is now in variables with a CFG_ prefix. Add these to
> > > > the .cfg file so that we can see everything in one place. Sort the
> > > > options so they are easier to find and compare.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - Add new patch to update u-boot.cfg with CFG_... options
> > > >
> > > >  scripts/Makefile.autoconf | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.autoconf
> > > > index b42f9b525fe..65ff11ea508 100644
> > > > --- a/scripts/Makefile.autoconf
> > > > +++ b/scripts/Makefile.autoconf
> > > > @@ -71,7 +71,7 @@ quiet_cmd_autoconf = GEN     $@
> > > >  quiet_cmd_u_boot_cfg = CFG     $@
> > > >        cmd_u_boot_cfg = \
> > > >       $(CPP) $(c_flags) $2 -DDO_DEPS_ONLY -dM include/config.h > $@.tmp && { \
> > > > -             grep 'define CONFIG_' $@.tmp | \
> > > > +             egrep 'define (CONFIG_|CFG_)' $@.tmp | sort | \
> > > >                       sed '/define CONFIG_IS_ENABLED(/d;/define CONFIG_IF_ENABLED_INT(/d;/define CONFIG_VAL(/d;' > $@; \
> > > >               rm $@.tmp;                                              \
> > > >       } || {                                                          \
> > >
> > > I don't like this because whereas "CONFIG_" is enforced to be set only
> > > by Kconfig and so always all reliably set and found via a single header,
> > > CFG_ stuff is not.
> >
> > OK, so how are CFG_ options found? I hit this when trying to find the
> > SDRAM size on rockchip 3399 and I could not find any way of figuring
> > it out.
>
> It's just another define, there's no uniformity to it. For some of the
> SDRAM values really we need some build time way to grab some information
> out of the default device tree.

Can you give an example of a board that could use this? I looked at
the devicetree for chromebook_kevin and don't see a memory range in
ther.

Regards,
Simon
