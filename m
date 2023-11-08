Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D99C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 12:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49AB58752D;
	Wed,  8 Nov 2023 13:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iXDP6G8G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E53478754B; Wed,  8 Nov 2023 13:24:39 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77D7A87068
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 13:24:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50797cf5b69so8986227e87.2
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 04:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699446276; x=1700051076; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IPfXFF5sz1qgm0/+Gnhq7MW3lbb+uJ0t9Xgck0AxGEk=;
 b=iXDP6G8G3XxbeUE+7hP8zBjFVTZy3mbr0iNjtpVV+7dNB577yoN8zwUFlJlRmmoXoz
 gUoNMhNuZTMLXetOijJfrmRtRt6LOlXI/fAHHwGa5y0ayN4W3MtGGLi9p+2lSJSXFmHg
 7UW2Y6OCDxqenTPBb+4AKOvDtSRP2w2hFF8MTzSXMekVJ2hcQnOCHKr3Q2QPinbPKNC2
 BoLg46KVUpVAsVRHKtuELc1VMaijodGoVHqtvUKYGBJzaZm7YlE8KviBxCkmKRqbyFKn
 YBAeem8QtuvUZ9ttQq07n1qDGE6XnxMUOgzHmFcoaqGqOgzMqwAOF1ne9joPssE3qrOb
 ZP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699446277; x=1700051077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IPfXFF5sz1qgm0/+Gnhq7MW3lbb+uJ0t9Xgck0AxGEk=;
 b=ZW0LtoarE9h4194+qId4+sH974E1dkQMdr5Dfj80IlJ23M3UmlgIwdRNtDRjPiBOOc
 Xk07iWvB4kCTBFJ2INrbHuXDo9Lu5ginHEapoMeE/qUlZN9eodlEuSpsQNopYUNM8VDE
 vXe4prp//M/ucVrf0esMpC5EJdPvBZkHY7yQ0ZE4DQlpRTCs4AokAMpQVXhOrUjMgJaz
 eB9h659+LMU0WQPWKMvRVg9KBo3wIjiLZAJRNxNcWwFbqxvo8ISYU520r9hBU/7ISEpq
 STh/ikidBk2FvjpG9UbADsAdTifxSCzrezeljUyTpoop6bTb3mXFJJTUcftYeg5Eao2s
 F8lg==
X-Gm-Message-State: AOJu0YyWvgzxFTQuYGqpdzLZeV56s98hyoSTVkJzXwcD9f6yUnL6wQ3K
 JZdf+S9aD28Cj7/B3yvz785DMMXkvcsk1y6P8+OOfNCJ
X-Google-Smtp-Source: AGHT+IHYNvhuwfMrpJhz4Ff9flbnkvFed2iITGldhIN2fgDSNnd2NtEmPb/oL97jfntQ341Vti4fYsJGnTsPScQrKP4=
X-Received: by 2002:a05:6512:3046:b0:503:385c:4319 with SMTP id
 b6-20020a056512304600b00503385c4319mr1512357lfb.19.1699446276403; Wed, 08 Nov
 2023 04:24:36 -0800 (PST)
MIME-Version: 1.0
References: <20231024002159.74477-1-seanedmond@linux.microsoft.com>
 <20231024002159.74477-2-seanedmond@linux.microsoft.com>
 <9a42da8f-2d82-4470-82bd-ef872e72810a@gmx.de>
 <2ed00b42-66f9-4cca-a1a0-ee594840f0d1@linux.microsoft.com>
 <30e83c4b-32be-4e85-aee8-e8b87224a487@gmx.de>
 <b058f5a6-52e2-4e0c-a193-30e884b2463a@linux.microsoft.com>
 <20231108002342.GE6601@bill-the-cat>
In-Reply-To: <20231108002342.GE6601@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 8 Nov 2023 12:24:24 +0000
Message-ID: <CALeDE9NBpwUXcuURx-JKsRNS4C+6OBTz8Nfi76kRY_3ZSays7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] net: Get pxe config file from dhcp option 209
To: Tom Rini <trini@konsulko.com>
Cc: Sean Edmond <seanedmond@linux.microsoft.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, joe.hershberger@ni.com,
 rfried.dev@gmail.com, 
 sjg@chromium.org, ilias.apalodimas@linaro.org, u-boot@lists.denx.de
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

> > > > > > Allow dhcp server pass pxe config file full path by using option 209
> > > > > >
> > > > > > Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> > > > > > ---
> > > > > >   cmd/Kconfig |  4 ++++
> > > > > >   cmd/pxe.c   | 10 ++++++++++
> > > > > >   net/bootp.c | 21 +++++++++++++++++++++
> > > > > >   3 files changed, 35 insertions(+)
> > > > > >
> > > > > > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > > > > > index 5bc0a92d57..adbb1a6187 100644
> > > > > > --- a/cmd/Kconfig
> > > > > > +++ b/cmd/Kconfig
> > > > > > @@ -1826,6 +1826,10 @@ config BOOTP_PXE_CLIENTARCH
> > > > > >       default 0x15 if ARM
> > > > > >       default 0x0 if X86
> > > > > >
> > > > > > +config BOOTP_PXE_DHCP_OPTION
> > > > > > +    bool "Request & store 'pxe_configfile' from BOOTP/DHCP server"
> > > > > > +    depends on BOOTP_PXE
> > > > >
> > > > > Why should this be disabled by default?
> > > > >
> > > > > Do we really want a separate config variable?
> > > > >
> > > > I expect most won't use this option to get the file path (they'll use
> > > > the default paths as per the PXE specification).  It makes more sense
> > > > for me to keep it optional, like many of the other options?
> > >
> > > RFC 5701 seems to require this option. Hence we should make it default
> > > yes. Boards that have a build size issue can opt out.
> >
> > The PXELINUX specification
> > (https://wiki.syslinux.org/wiki/index.php?title=PXELINUX) doesn't state that
> > option 209 is required. In the abense of option 209, PXELINUX will try the
> > following default configuration files (this example is provided on the wiki
> > link):
> >  /mybootdir/pxelinux.cfg/b8945908-d6a6-41a9-611d-74a6ab80b83d
> >  /mybootdir/pxelinux.cfg/01-88-99-aa-bb-cc-dd
> >  /mybootdir/pxelinux.cfg/C0A8025B
> >  /mybootdir/pxelinux.cfg/C0A8025
> >  /mybootdir/pxelinux.cfg/C0A802
> >  /mybootdir/pxelinux.cfg/C0A80
> >  /mybootdir/pxelinux.cfg/C0A8
> >  /mybootdir/pxelinux.cfg/C0A
> >  /mybootdir/pxelinux.cfg/C0
> >  /mybootdir/pxelinux.cfg/C
> >  /mybootdir/pxelinux.cfg/default
> >
> > If 209 is requested/provided it tries the provided "config file" before the
> > default paths.  RFC 5071 should be seen as an extension for PXELINUX (not a
> > requirement).  RFC 5071 only states "The Config File Option MUST be supplied
> > by the DHCP server if it appears on the Parameter Request List".
>
> We also want to be careful about overall size growth on common options,
> even if someone can opt-out. Those are usually last-ditch stop-gaps and
> it's better to make sure we really need functionality X/Y/Z by default,
> for everyone. Especially with all of the work going on to make HTTP(s)
> based network installs a viable option, how much more do we want to
> change the PXE case, for everyone. I'm personally somewhat looking for
> the use case to be well defined for a "this must be default". Network
> provisioning is a thing, yes, but for whom/what, and in turn how broadly
> do we need this to be in the vast majority of our boards (since it would
> come in via BOOT*DEFAULTS or DISTRO_DEFAULTS).

If PXE is being enabled I think it's useful in that it means the PXE
client can be largely stateless because it can all be provided by
central netowork configs as opposed to either hard wiring it into
firmware or someone having to manually set them. This is likely also
useful from the PoV less reasons to have a shell if it can be dealt
with in code.

From the PoV of defaults, with or without HTTP boot, I suspect it
probably makes sense to review whether PXE as a whole is enabled by
default. That said a number of silicon vendors are actually actively
removing PXE from their reference FW in favour of HTTP Boot due to
security and a number of other reasons (easier for firewalls,
caching/CDN, edge use cases outside of the data centre).

Peter
