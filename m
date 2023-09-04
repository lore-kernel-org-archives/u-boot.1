Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55547C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:45:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E1CE86932;
	Mon,  4 Sep 2023 16:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PNBf88r5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5FB586915; Mon,  4 Sep 2023 16:43:34 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3227D86A3A
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-52c88a03f99so1925307a12.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838611; x=1694443411; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2crUV0xEHHLo7ADALLmew/OjMjOuFQKdryA82sv8yDI=;
 b=PNBf88r52fRCh4TZ3Zph6NPVgLPIq8sLGlfKTq+uw2QHNGMeynMZ5avJ/un0Hy4YNO
 GCdlXCHw8R32NB/V41+8bW19nZNGm1GpWJ9YBXiNluGxGXmQjoG15S1xNOxcsdhP0SJy
 qfQ4Z3yelOi6kn6gHpN/85BjIk7PiS+joEmlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838611; x=1694443411;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2crUV0xEHHLo7ADALLmew/OjMjOuFQKdryA82sv8yDI=;
 b=BrMjd9Oar+xx5OCuYZXPh2oUF2JLlsRvnE/YbK6dm6S8I7EUoTpxYFTpwCgmlJsvMJ
 B1liJmMbOuAObeXwtCu4ZF6ETpQI+Yxe+DVoO3Q7iBW3tOM3ZZmiRuTAeI6Q2SOdbI+2
 RKEeoMuzFNhRCXApPld6nlMkbbGJ1Z+7nQErjoQwRVBpsSMbAzvGLw0ZomzHglyhpG0k
 KhK3RjDBQ542sl7YaH6HPYPdP3aj+prxWSF+U7flKLxKMF+dgNr9QH9tqalf+p7kGpal
 98rQ56kKBSGEugjMoaRxOXs9Jd6Tp8m0neaZSmQ+GwJEnqC1wHjBwuzFXmgxeJXKO8hU
 0Pow==
X-Gm-Message-State: AOJu0YxVC36NE3GTPR9/WavDZxN2OClxCf3mMLQwG9j2luGkStTMXVIs
 HM3AqbXsDETh1He5BOrnpykIAEaY+UPAa4lion09cngAgXH0xHPjsI0=
X-Google-Smtp-Source: AGHT+IENMDzJ8OCUP5IQTU2MUwqhXXoEIuemZLhGHVoc9gQ9rtUf3mhxv85fc0PGVd1GfZPf+wMLOLMs/JQ7THrBraU=
X-Received: by 2002:aa7:cf90:0:b0:525:734a:bf30 with SMTP id
 z16-20020aa7cf90000000b00525734abf30mr7583488edx.36.1693838610541; Mon, 04
 Sep 2023 07:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230831035319.2316665-1-sjg@chromium.org>
 <20230831035319.2316665-20-sjg@chromium.org>
 <20230831140149.GR3101304@bill-the-cat>
In-Reply-To: <20230831140149.GR3101304@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Sep 2023 08:43:12 -0600
Message-ID: <CAPnjgZ1qH4oPq23=+DpEBz3o-t=2454yCmzJOJLdF_mCJ38QNQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/19] boot: Join ARCH_FIXUP_FDT_MEMORY with related
 options
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 31 Aug 2023 at 08:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Aug 30, 2023 at 09:53:13PM -0600, Simon Glass wrote:
> > Move this to be with the other devicetree-fixup options.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  boot/Kconfig | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index 023446130282..257f4cc085e1 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -693,14 +693,6 @@ config SUPPORT_RAW_INITRD
> >         address of the initrd must be augmented by it's size, in the following
> >         format: "<initrd address>:<initrd size>".
> >
> > -config ARCH_FIXUP_FDT_MEMORY
> > -     bool "Enable arch_fixup_memory_banks() call"
> > -     default y
> > -     help
> > -       Enable FDT memory map syncup before OS boot. This feature can be
> > -       used for booting OS with different memory setup where the part of
> > -       the memory location should be used for different purpose.
> > -
> >  config CHROMEOS
> >       bool "Support booting Chrome OS"
> >       help
> > @@ -1492,6 +1484,14 @@ config FDT_SIMPLEFB
> >         the presence of the simple frame buffer with associated reserved
> >         memory
> >
> > +config ARCH_FIXUP_FDT_MEMORY
> > +     bool "Enable arch_fixup_memory_banks() call"
> > +     default y
> > +     help
> > +       Enable FDT memory map syncup before OS boot. This feature can be
> > +       used for booting OS with different memory setup where the part of
> > +       the memory location should be used for different purpose.
> > +
> >  endmenu
> >
> >  endif # OF_LIBFDT
>
> It seems like fixups are mixed in with other changes in this menu when
> we should probably keep the fixups lumped together at least.

From what I can tell all of the things I am putting in this menu
relate to DT fixups. The naming is a bit odd though, on some of them.

Regards,
Simon
