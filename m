Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AC1C30659
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 07:33:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1455E8859C;
	Fri, 28 Jun 2024 09:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FCb1uRz0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9E8D8859C; Fri, 28 Jun 2024 09:33:14 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACACA87E3F
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 09:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b50aeb2424so1891456d6.0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 00:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719559991; x=1720164791; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rCnD+hvbFrDRDHVeeRcpQLswoJ+OmIqxEhuOa58TPZY=;
 b=FCb1uRz0S/gAFbIkd2/C6D5Y6P/44JrOPTLGRj7GHO8s0GoqMGUF+AQtGPiKPivyeH
 ot/hFRdtjc+JQVGg4wdkBlKjjryGJZhH7y9sthL2Q0eGnKngVlQSKAVkEhdO9Mc6L/DE
 VlkxxANdY0w32YCJs+Soy2NRhHpxZC9X7ASgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719559991; x=1720164791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rCnD+hvbFrDRDHVeeRcpQLswoJ+OmIqxEhuOa58TPZY=;
 b=kYiIAjNNb2DXy7Ten9ZurEJ6fzP8fR2eubmkw30vLsDOl3FkYaIlCqyHavp2d1xSSw
 q63MaM6AFq6Rapa/ipc2wnf+MiaDvAkX1udNLZHPi5mZ9uaTbqNVgSdHXJV+MkJex/ci
 cr0Fs2SBadyAQ5ukrZFg9e6GFaJXAQ7MZZ2vuJfVXr5I5bd4LM4daUtCDlIV4ZXDGAnj
 nX9hhfgNuUUIP6IbMJeEaItZAvM+VkSQ8+oMd7SVTfUcdye1ACfy9IVlcuRDRl9z8UWd
 szcaVLxwG5fcc8oJ3UB+oJhQAx648Y+IzO9ZnNf6xyrRr1PerA6JCswQB6+hxM9zLLrN
 RrKQ==
X-Gm-Message-State: AOJu0YzDjTJ1s51G8QwS7b/wFpDYF92c0pk0pbeFKQ0VILpQF7Oi848B
 g8WJ/SK+nC45/UvjA4DMinKfwntSLqqumbY8zKgIDuqrwk9EdjUsOki4Gr1+ichZBr4fcIJvf0K
 aY8hl0VqzEAQAgNEXrs+esb0qE3B5INan4rUo1SYHX3uMpcOMlw==
X-Google-Smtp-Source: AGHT+IEdbfeTba1+/IEjbtRAUVKpgdCaghcsjkkEnswDO+BriTZdvzG1dBHkfONjSZ0ZetdVQTNQqH7NIOJ70cd6uFo=
X-Received: by 2002:a05:6214:20e2:b0:6b2:b5d9:91d6 with SMTP id
 6a1803df08f44-6b5409c4ad5mr196354056d6.18.1719559991624; Fri, 28 Jun 2024
 00:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240623203033.1566505-1-sjg@chromium.org>
 <20240623203033.1566505-14-sjg@chromium.org>
 <20240624182931.GI38804@bill-the-cat>
 <CAFLszTguTkc1m2JYb=5+yW_8uY+J0AsQZ_L0hFJHDfEXNeb0wQ@mail.gmail.com>
 <20240625141427.GO38804@bill-the-cat>
 <CAFLszTi1i+OrAyoyqRLZAuKzGTmAgNQ9Gwtn01XxVLvGmzZLcQ@mail.gmail.com>
 <20240626140752.GV38804@bill-the-cat>
 <CAFLszTj0h5w+sz796LokxgcfyRTGmHnQJ3OTDdoaoC61Ob=akw@mail.gmail.com>
 <20240627144214.GC38804@bill-the-cat>
In-Reply-To: <20240627144214.GC38804@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Jun 2024 08:33:01 +0100
Message-ID: <CAFLszTixbMxDq7TvjPzc+Xup6biMmPvLP5CVPJLp7w94e0dd4Q@mail.gmail.com>
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

On Thu, 27 Jun 2024 at 15:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jun 27, 2024 at 09:37:15AM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 26 Jun 2024 at 15:07, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Jun 26, 2024 at 09:00:41AM +0100, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 25 Jun 2024 at 15:14, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Jun 25, 2024 at 01:38:04PM +0100, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 24 Jun 2024 at 19:29, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Sun, Jun 23, 2024 at 02:30:32PM -0600, Simon Glass wrote:
> > > > > > >
> > > > > > > > Some configuration is now in variables with a CFG_ prefix. Add these to
> > > > > > > > the .cfg file so that we can see everything in one place. Sort the
> > > > > > > > options so they are easier to find and compare.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Changes in v2:
> > > > > > > > - Add new patch to update u-boot.cfg with CFG_... options
> > > > > > > >
> > > > > > > >  scripts/Makefile.autoconf | 2 +-
> > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.autoconf
> > > > > > > > index b42f9b525fe..65ff11ea508 100644
> > > > > > > > --- a/scripts/Makefile.autoconf
> > > > > > > > +++ b/scripts/Makefile.autoconf
> > > > > > > > @@ -71,7 +71,7 @@ quiet_cmd_autoconf = GEN     $@
> > > > > > > >  quiet_cmd_u_boot_cfg = CFG     $@
> > > > > > > >        cmd_u_boot_cfg = \
> > > > > > > >       $(CPP) $(c_flags) $2 -DDO_DEPS_ONLY -dM include/config.h > $@.tmp && { \
> > > > > > > > -             grep 'define CONFIG_' $@.tmp | \
> > > > > > > > +             egrep 'define (CONFIG_|CFG_)' $@.tmp | sort | \
> > > > > > > >                       sed '/define CONFIG_IS_ENABLED(/d;/define CONFIG_IF_ENABLED_INT(/d;/define CONFIG_VAL(/d;' > $@; \
> > > > > > > >               rm $@.tmp;                                              \
> > > > > > > >       } || {                                                          \
> > > > > > >
> > > > > > > I don't like this because whereas "CONFIG_" is enforced to be set only
> > > > > > > by Kconfig and so always all reliably set and found via a single header,
> > > > > > > CFG_ stuff is not.
> > > > > >
> > > > > > OK, so how are CFG_ options found? I hit this when trying to find the
> > > > > > SDRAM size on rockchip 3399 and I could not find any way of figuring
> > > > > > it out.
> > > > >
> > > > > It's just another define, there's no uniformity to it. For some of the
> > > > > SDRAM values really we need some build time way to grab some information
> > > > > out of the default device tree.
> > > >
> > > > Can you give an example of a board that could use this? I looked at
> > > > the devicetree for chromebook_kevin and don't see a memory range in
> > > > ther.
> > >
> > > OK, wow, I didn't realize /memory was optional now. But indeed, I don't
> > > see it in the dtb file. That removes that option then, sadly.
> >
> > Well, we can still require it, so long as an error is produced if the
> > property is needed but does not exist.
>
> "We" who? I don't feel like we'll have a lot of traction with linux
> kernel folks in requiring /memory to be added to the dts files on
> however many platforms don't have it today because I'm going to guess
> it's added at run time, possibly by us, with the correct size and we'd
> be asking for statically adding things half-wrong like a lot of
> platforms used to do (and in turn rely on U-Boot to correct the size).

Hmm yes of course, the firmware is supposed to add these
properties...that's how it gets in there. So we need to stick with CFG
(and perhaps the RAM-size prober) for now.

Regards,
Simon
