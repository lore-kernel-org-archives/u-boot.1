Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E877C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 22:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69A97889CB;
	Thu, 25 Jul 2024 00:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oX1lngOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E17F6889AF; Thu, 25 Jul 2024 00:17:45 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12A7388959
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 00:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5c661e75ff6so187417eaf.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 15:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721859462; x=1722464262; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o6TkR1NjHJ+Jhp4WATeqXgDUk0yRqnHNNXJWHJKqZAw=;
 b=oX1lngOv5rAiJz3AXpPVrguyr6w7/IeSx2t5Lvc7qI7HcQdfMeRNp3WiSeDq6YH7AV
 AQIdU+3E/Y+p1+AafhgVYXm+8gSxxehCtD9p+IUTN2YRK0B2bArk6VpUgoMw0CXEbJMP
 NTSDroWWe22gpy96+g9nl/W/QAXLIv5Le6Fic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721859462; x=1722464262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o6TkR1NjHJ+Jhp4WATeqXgDUk0yRqnHNNXJWHJKqZAw=;
 b=h59DtTs/+ZMctO7JEpZO9T1eXORKiRQQX6SvE4EbNcXDyVaafpB/ykfxZK+to8N/MY
 xq7fIOAHVtUmGxgM4YfaMHtAurN4cvEWU7YRpJVzK8dqeJJyX6S6WR+AMTJ+JPH2frvc
 MCQ004EpNHBqhBexd0/9TsFbtkLPnk3uAPwZx0DFNEfWNvy1h1/nJqxznBMiQl7dOWHo
 XV9WcR6QI437mQKXsxRMm0WaqWGYQ5PUzYJecSPqpK7u/ED8cWq7+I8F7VmUXDq+qg/O
 ulRQQvLJNsrzKN+3EC310gH1TyE3JJQN308ZrS0EGGCKK44ZbJhbxXgF0ZpcSYPFITYj
 74vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP1Ad1YdgGP8KkIgljQMTgNSNLmuBogN8afV9KmxnGDT8s8FNbTNsPnD1En/ovMRyRKx88/wTTeXL8ecxYrhKmAvPThA==
X-Gm-Message-State: AOJu0YxmvcDAWSsbnZC4aW4KBwjD8vtDBY/XPpIxwr/ovW6WSsbLqR2v
 szbARz0cMzzCk1WM3XZfDWJqqfQIiemmyQbAaOsaWGh2we0Rl6OCPN/Yscja+wyzOSR7b/VNgcn
 dRNAYwQqyIXwk51dIzuEX4lZNV8eqsmMs4VObTelKP72zOIE=
X-Google-Smtp-Source: AGHT+IHnocK1snptltGd3ooBJqQ9hQIqCsK9oJ+s/ZF3yVGK9JZzcQ1lLIhFVdyUF+I45P98Uk0A8E8Ew57Pb2VNK3s=
X-Received: by 2002:a05:6358:6486:b0:1a6:769e:4753 with SMTP id
 e5c5f4694b2df-1acfb96a667mr18061355d.19.1721859461774; Wed, 24 Jul 2024
 15:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240723015555.GE989285@bill-the-cat>
 <trinity-430de174-6a75-482c-b8dd-fde586286c63-1721742246830@3c-app-gmx-bap35>
 <CAFLszTgt90Xne03OH4Z53T77j=ehqUJmK0OAXPNAPS7qm=4__g@mail.gmail.com>
 <trinity-d8537898-e5c7-4ec3-8477-843b24fddf2a-1721841047587@3c-app-gmx-bs37>
In-Reply-To: <trinity-d8537898-e5c7-4ec3-8477-843b24fddf2a-1721841047587@3c-app-gmx-bs37>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 24 Jul 2024 16:17:31 -0600
Message-ID: <CAFLszThGWXmkvHuzKeYKrxpLU=vP7=_=0ZZijhDagJ1X82OaDQ@mail.gmail.com>
Subject: Re: Re: [ANN] U-Boot v2024.10-rc1 released
To: Frank Wunderlich <frank-w@public-files.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
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

Hi Frank,

On Wed, 24 Jul 2024 at 11:10, Frank Wunderlich <frank-w@public-files.de> wrote:
>
> Hi
>
> > Gesendet: Mittwoch, 24. Juli 2024 um 16:37 Uhr
> > Von: "Simon Glass" <sjg@chromium.org>
> > An: "Frank Wunderlich" <frank-w@public-files.de>
> > Cc: "Tom Rini" <trini@konsulko.com>, u-boot@lists.denx.de, u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
> > Betreff: Re: [ANN] U-Boot v2024.10-rc1 released
> >
> > Hi,
> >
> > On Tue, 23 Jul 2024 at 07:44, Frank Wunderlich <frank-w@public-files.de> wrote:
> > >
> > > Hi,
> > >
> > > i notice build-error because of CONFIG_TOOLS_MKEFICAPSULE is set automaticly and does not find an include
> > >
> > > https://github.com/frank-w/u-boot/actions/runs/10059612312/job/27805232284
> > >
> > > tools/mkeficapsule.c:20:10: fatal error: gnutls/gnutls.h: No such file or directory
> > >    20 | #include <gnutls/gnutls.h>
> > >       |          ^~~~~~~~~~~~~~~~~
> > >
> > > solved it temporary by adding CONFIG_TOOLS_MKEFICAPSULE=n to my configs/mt7622_bpi-r64_defconfig
> > >
> > > commit: https://github.com/frank-w/u-boot/commit/2640a8881d3c6a232575f46b0f2b8a0217b6d639
> > > fixed pipeline: https://github.com/frank-w/u-boot/actions/runs/10059965071
> > >
> > > breaking commit seems to be
> > >
> > > b7a625b1ce49 tools: Build mkeficapsule tool by default if EFI_LOADER is set
> > >
> > > i have EFI_LOADER set to y,but it is unclear where the header-file should be...i do not find any gnutls.h in my tree
> >
> > We should really build all tools always, where possible.
>
> why require more depencies for tools which are most likely not used by users...in my case i do not need the mkeficapsule ;)
>
> the gnutls error i get only in pipeline...maybe on my host i have the required lib somewhere in the common includes of gcc crosscompiler.
>
> on my laptop i get a different error but also on mkeficapsule tool
>
> tools/mkeficapsule.c:18:10: fatal error: uuid/uuid.h: No such file or directory
>    18 | #include <uuid/uuid.h>
>       |          ^~~~~~~~~~~~~
>
> i guess this can be installed with "apt-get install uuid-dev" but why should i fix the depency if i do not need the tool?

Because it is confusing for packagers to deal with adding special
config options in order to build all the tools. So we try to build
them all, always.

Regards,
Simon
