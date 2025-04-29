Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4E7C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 14:20:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 018C4829A1;
	Tue, 29 Apr 2025 16:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PLTfC5+Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DC638297E; Tue, 29 Apr 2025 16:20:07 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A83338272A
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 16:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e8be1c6ff8so350298a12.1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745936403; x=1746541203; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FAQ+/WqSjmMASkWwOsm1TJ9vw1iaX9dMP7qmBmODRtc=;
 b=PLTfC5+ZRUHPRHoQ8fSYcmEsAzmpzkc9YIvT5ouz9YoD/nyPoAy+D4/pzFdTojmZ9b
 xIEiQB8yR47i7JaaVFNmp7+XaKsf5ckJZSkRWhsX+AzQDIZCRe4jIfgLUGM11Liftgtr
 4w4GuUatDBBwCAfw5+ALBbAMmlvgeCOrLYQtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745936403; x=1746541203;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FAQ+/WqSjmMASkWwOsm1TJ9vw1iaX9dMP7qmBmODRtc=;
 b=I0AUwWJ5HoyOj60go696pff3SZNsCHK4PsTWXOIXuAHvtUJ2DDtRE/ppQ6dJchwDDM
 k1PdirxgRKBT1PVMksACXni+sHlFuCPiq1DafngvJ5uPgEylwm6FuL8k8oq1PKiywdFI
 aIcrFiIHm6RN9X3I7FP1+IYYqi14+9TIWrnPZ38/05u9/PdiWfVgrQAC5Z6d7k1OVvIf
 RV3Gvp7il+ddkwLHZjx0gRlDraANWpX2ADFK6PQpGrliBuGn22jURXraWCzLPsg95U6g
 fP7cl6+RspLdc9dD85n96+pNBScjrratulaCtEixoW7JE4CmcD/W/qwguZOGbROy+RAK
 UmCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZD+j7/ThtQVqd2Q+f30jw+/3DwwEYJU0ZU7JqFeVItVvt1RjSLCCfCf272Hy8L/bbL994vDY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2X8uBHsPQByZNOBIRrHBA2nCfZyNRDpdJKfMNC998ncPOBeR0
 b5YNO+bQbz4C4h52Ko3rolBRGqSVdk2eZrOSs3RccCjQzZDD2MpTOfqFXVHzLGnhPX0hz3MTLfW
 iUSUPz0b7NZ9pjw/G7ZcI0wgZuPNkJtnW7/k2xShNw9fGo9s=
X-Gm-Gg: ASbGncvbGeDBtBVI5UO6qA74wnPLC5G6tWw0B7qsTsdDnXkuRhd5K/IwTB+yQiP+3bv
 O+6wQYiAzL9yJ4HkZRNPtoOvImlp0Yh63bpGy2RhcTsZnPHYM3zppFz8NG3J5LwNkIJQsS+afMe
 ewGzB9YAUTbqGZ5EJfrc7HMnk=
X-Google-Smtp-Source: AGHT+IF0PweySaOaHsKw/cSgY9RW2JRptFS3FRJvwxmnIq9+x9Df2aQn1ROIQFsHuyY/PofzqfDpKfl2Y7fmm1pGBPg=
X-Received: by 2002:a17:907:7212:b0:acb:5f17:623d with SMTP id
 a640c23a62f3a-acec4e3a418mr373917266b.24.1745936403057; Tue, 29 Apr 2025
 07:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de>
 <20250129-wip-bootmeth-rauc-v1-1-6308e732f314@phytec.de>
 <CAFLszTinU=6v+3OyaH0pp8snYm9BgfVrU_+35x2Az7fVs_CfYw@mail.gmail.com>
 <4aef8b9ffd41d4e36550806f4688fc18dbddc500.camel@phytec.de>
 <CAFLszTjPHBw-F0EkQJnT4TOsxdYzGH5EtRBaeRCoKGxQQ_cw4g@mail.gmail.com>
 <20250424184923.GM5495@bill-the-cat>
 <CAFLszThPcJjhBVLvz=EkdeEP1K948cC=LyZhBk_Upk3iSWXCig@mail.gmail.com>
 <20250425143752.GU5495@bill-the-cat>
 <CAFLszTiYCObeLy+HPnpXSE3yQ20ZN-+hptoi_nYT4DXimjHFYA@mail.gmail.com>
 <20250425161935.GV5495@bill-the-cat>
In-Reply-To: <20250425161935.GV5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Apr 2025 08:19:51 -0600
X-Gm-Features: ATxdqUFOZVmkIhtubsN-Nwzzb0XRx6fKv2I5uLQ8WVKtYb6qFq_aZGOeXdDHiaw
Message-ID: <CAFLszTgRxa=Tb4ZRHappaDqTB39ERpDgf57Lwgev28p7f_ZPdg@mail.gmail.com>
Subject: Re: [PATCH 1/2] bootstd: Add implementation for bootmeth rauc
To: Tom Rini <trini@konsulko.com>
Cc: Martin Schwan <M.Schwan@phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
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

On Fri, 25 Apr 2025 at 10:19, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Apr 25, 2025 at 09:03:17AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 25 Apr 2025 at 08:37, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Apr 25, 2025 at 08:35:52AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 24 Apr 2025 at 12:49, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Apr 24, 2025 at 12:31:38PM -0600, Simon Glass wrote:
> > > > > > Hi Martin,
> > > > > >
> > > > > > On Thu, 24 Apr 2025 at 06:43, Martin Schwan <M.Schwan@phytec.de> wrote:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > thanks for the review and sorry for my delayed reply.
> > > > > > >
> > > > > > > On Mon, 2025-04-14 at 05:32 -0600, Simon Glass wrote:
> > > > > > > > Hi Martin,
> > > > > > > >
> > > > > > > > On Wed, 29 Jan 2025 at 07:25, Martin Schwan <m.schwan@phytec.de>
> > > > > > > > wrote:
> > > > > > > > >
> > > > > > > > > Add a bootmeth driver which supports booting A/B system with RAUC
> > > > > > > > > as
> > > > > > > > > their update client.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Martin Schwan <m.schwan@phytec.de>
> > > > > > > > > ---
> > > > > > > > >  boot/Kconfig         |  11 ++
> > > > > > > > >  boot/Makefile        |   1 +
> > > > > > > > >  boot/bootmeth_rauc.c | 408
> > > > > > > > > +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > > > > > >  3 files changed, 420 insertions(+)
> > > > > > > >
> > > > > > > > This looks fine to me. Just some nits below.
> > > > > > > >
> > > > > >
> > > > > > [..]
> > > > > >
> > > > > > > > > +
> > > > > > > > > +       partitions = env_get("rauc_partitions");
> > > > > > > > > +       if (!partitions)
> > > > > > > > > +               return log_msg_ret("env", -ENOENT);
> > > > > > > > > +       partitions_list = str_to_list(partitions);
> > > > > > > > > +
> > > > > > > > > +       slots = env_get("rauc_slots");
> > > > > > > > > +       if (!slots)
> > > > > > > > > +               return log_msg_ret("env", -ENOENT);
> > > > > > > > > +       slots_list = str_to_list(slots);
> > > > > > > > > +
> > > > > > > > > +       boot_order = env_get("BOOT_ORDER");
> > > > > > > >
> > > > > > > > Environment variables should be in lower case.
> > > > > > >
> > > > > > > Unfortunately, we are bound to the naming RAUC uses for these
> > > > > > > environment variables, which is upper case. See
> > > > > > > https://rauc.readthedocs.io/en/latest/integration.html#set-up-u-boot-boot-script-for-rauc
> > > > > >
> > > > > > Can't you change it, since you are introducing new support here?
> > > > > >
> > > > > > If not, then you could perhaps set the env variables to lowercase when
> > > > > > you find uppercase variables? I suppose that would require updating
> > > > > > the client to do the same thing too?
> > > > > >
> > > > > > It would be very confusing for a user to have upper-case variables for
> > > > > > some things.
> > > > >
> > > > > Simon, this is an unreasonable request. This is how RAUC has been
> > > > > working and deployed for years and years. It would be a nightmare trying
> > > > > to handle migration of existing deployments for an aesthetic change.
> > > >
> > > > Yes, I figured. Perhaps it could support lower case in future? This is
> > > > the first I have seen on RAUC in U-Boot, although I do see this file
> > > > which has both lower and upper case:
> > > >
> > > > include/env/phytec/rauc.env
> > >
> > > I don't think there's any need to complicate RAUC support here (nor
> > > in the future Mender nor swupdate nor any other long standing OTA
> > > mechanism that might be more easily integrated via bootstd than
> > > environment patching).
> >
> > Let's see what the author says. I assume that U-Boot has its own code
> > in RAUC so it might not be too bad.
>
> I mean, sure? But "should" is not "must" and I have zero desire to
> make supporting existing use cases harder. That will make migration to
> bootstd less attractive, not more. We don't want people to decide that
> can't upstream platform X or feature Y because they've already developed
> and deployed it using capitals or camel case in their environment.

Yes, agreed.

Regards,
Simon
