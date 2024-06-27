Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EEFC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 08:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32CC088590;
	Thu, 27 Jun 2024 10:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TtCo0X5g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC3E98852E; Thu, 27 Jun 2024 10:37:29 +0200 (CEST)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 896B087FA7
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-80fc8226765so388647241.3
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 01:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719477446; x=1720082246; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EADRlUlTY6XwFMw89mlj904nKzGe7Vl11a/M0ko6vGQ=;
 b=TtCo0X5gdoFMo38z6tsaL0r9QVuQq/A+Wv40G2ms0O1pQWM2H9tX8obFVYKFf96Xj0
 OTJ+ALJG3G2AA2UVwKgyITHVteX49rgE0lKpYf2Cc/F3J1WFnFuhw67xEOXEaDdZe1gZ
 w0l7Mhw82YYl3dUYITDj3ydTkKkz9QEjx1SY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719477446; x=1720082246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EADRlUlTY6XwFMw89mlj904nKzGe7Vl11a/M0ko6vGQ=;
 b=m+LFShzyNt8CUH71b24E79swUol9kOB2mDGOT7IUrcjQcvhDsaUqXAgYXeXtPpVtLq
 5WhCnccoSn3tJ8e5iJx5H/9rAO/KcM8SQUryVP/JQECmpNUirN7JUMMKCuh/CWTwSa0O
 2ZhewFOuzGj0uu+i3NIzM0ds4kk4HsG4SNYmbTa9LGK7XP0PTFn29P15T6rZl4xqY2w/
 6DPKjRhhlrvG+RZmp2A1lHalDWKBnS42afZnMD+Z8BaeSmMkYK2U+b0+hzx4tobmOpJV
 tlLEqNzNL/TA8ovDJB5MvhcDBU3iWG1Usfw7mynyDovo17wVxEMWf23jfJbYBxd8Jp7i
 +MOA==
X-Gm-Message-State: AOJu0YzQDD5q6iED6afTL4HkoGZeIjmLIpXKGjLieUDPlBA+tCiOZ5tj
 XTJwpiT5CF43FnIqkvipk0wPwWNZNm9xMD+AtJNhaRZOmsmEktIFR1y1jSteXx3OIMSgYP7rmnZ
 WoFjZy5SjyeAHAgaEy9+NVC8pc8JoTPg90K4vA0W5GSoR9pI=
X-Google-Smtp-Source: AGHT+IG4eR967zvVWtKxO0QPBguw7FZ5czOqIr5DOLob9qgxINZmclpkpGUeF3oiWtRGXwhx1JVd+OKwdY0LD3hf+As=
X-Received: by 2002:a67:fd16:0:b0:48f:692c:5b9c with SMTP id
 ada2fe7eead31-48f692c5cf9mr9153582137.3.1719477446386; Thu, 27 Jun 2024
 01:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240623203033.1566505-1-sjg@chromium.org>
 <20240623203033.1566505-14-sjg@chromium.org>
 <20240624182931.GI38804@bill-the-cat>
 <CAFLszTguTkc1m2JYb=5+yW_8uY+J0AsQZ_L0hFJHDfEXNeb0wQ@mail.gmail.com>
 <20240625141427.GO38804@bill-the-cat>
 <CAFLszTi1i+OrAyoyqRLZAuKzGTmAgNQ9Gwtn01XxVLvGmzZLcQ@mail.gmail.com>
 <20240626140752.GV38804@bill-the-cat>
In-Reply-To: <20240626140752.GV38804@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 09:37:15 +0100
Message-ID: <CAFLszTj0h5w+sz796LokxgcfyRTGmHnQJ3OTDdoaoC61Ob=akw@mail.gmail.com>
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

On Wed, 26 Jun 2024 at 15:07, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jun 26, 2024 at 09:00:41AM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 25 Jun 2024 at 15:14, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Jun 25, 2024 at 01:38:04PM +0100, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 24 Jun 2024 at 19:29, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sun, Jun 23, 2024 at 02:30:32PM -0600, Simon Glass wrote:
> > > > >
> > > > > > Some configuration is now in variables with a CFG_ prefix. Add these to
> > > > > > the .cfg file so that we can see everything in one place. Sort the
> > > > > > options so they are easier to find and compare.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Add new patch to update u-boot.cfg with CFG_... options
> > > > > >
> > > > > >  scripts/Makefile.autoconf | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.autoconf
> > > > > > index b42f9b525fe..65ff11ea508 100644
> > > > > > --- a/scripts/Makefile.autoconf
> > > > > > +++ b/scripts/Makefile.autoconf
> > > > > > @@ -71,7 +71,7 @@ quiet_cmd_autoconf = GEN     $@
> > > > > >  quiet_cmd_u_boot_cfg = CFG     $@
> > > > > >        cmd_u_boot_cfg = \
> > > > > >       $(CPP) $(c_flags) $2 -DDO_DEPS_ONLY -dM include/config.h > $@.tmp && { \
> > > > > > -             grep 'define CONFIG_' $@.tmp | \
> > > > > > +             egrep 'define (CONFIG_|CFG_)' $@.tmp | sort | \
> > > > > >                       sed '/define CONFIG_IS_ENABLED(/d;/define CONFIG_IF_ENABLED_INT(/d;/define CONFIG_VAL(/d;' > $@; \
> > > > > >               rm $@.tmp;                                              \
> > > > > >       } || {                                                          \
> > > > >
> > > > > I don't like this because whereas "CONFIG_" is enforced to be set only
> > > > > by Kconfig and so always all reliably set and found via a single header,
> > > > > CFG_ stuff is not.
> > > >
> > > > OK, so how are CFG_ options found? I hit this when trying to find the
> > > > SDRAM size on rockchip 3399 and I could not find any way of figuring
> > > > it out.
> > >
> > > It's just another define, there's no uniformity to it. For some of the
> > > SDRAM values really we need some build time way to grab some information
> > > out of the default device tree.
> >
> > Can you give an example of a board that could use this? I looked at
> > the devicetree for chromebook_kevin and don't see a memory range in
> > ther.
>
> OK, wow, I didn't realize /memory was optional now. But indeed, I don't
> see it in the dtb file. That removes that option then, sadly.

Well, we can still require it, so long as an error is produced if the
property is needed but does not exist.

Regards,
Simon
