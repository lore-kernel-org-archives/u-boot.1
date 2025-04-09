Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D31C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 13:08:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A25E383767;
	Wed,  9 Apr 2025 15:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FgPLsmRa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4809D836B2; Wed,  9 Apr 2025 15:08:55 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D59DA835CD
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 15:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so1089770166b.3
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 06:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744204132; x=1744808932; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2gCiZRbEenDoOh+rlWOaLwEBadpC2JZhddW+yqG72f4=;
 b=FgPLsmRaPegNpOimws4dgCllNsUZBBJHc9lpLTHuUzEDfvhItvYaPIn1YfunrLMzk1
 yRD+LQFda3nCrglOqtJas+ErOO2GZS3wTknkgQ0/0qnSru/cShEC+EnUR2AeR9bM91/B
 RowlOybB7UJ9fCSBrM367fGobMk4yrLI2e0iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744204132; x=1744808932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2gCiZRbEenDoOh+rlWOaLwEBadpC2JZhddW+yqG72f4=;
 b=Rpd6gSdvwCVyZBZkgPAVGjZuXPkW/IgnIMagAIcQAH7VzsnjdPVUuOgORPHBNvNubj
 z1IMXzzcqWHjgB4ITS+O5bNDVPRzYbqv7doMQdOJSzPn/GMuy5PSEs5UgS5Udz/kF/cu
 CCx4o72fhrTtnBeBjX+ummckqOewnpp/GupwcWoWVPl3jDL0h7hMNQNczFrfnCNfxTvs
 4hRqnHmJa58GbNcAMGHGyGwrsybVDmVyYAzkEHIKR/EzpOcv/vOMXtqM+S2Vi8IgCl5r
 Vu/vTQN5LESrAJPULulXC//sMWAS4jV/4V/qcF/mgJcYmmlc4PMSPNeN8gwHQleK/sJP
 XNDA==
X-Gm-Message-State: AOJu0YyDhci9Z4yrMhAsga5xsMD61l8Iuyc2i/GIl+srZvcenUo6IrrO
 Lp0UtQTkC3O2UzDb2BA37rcFZoybIFn9A/mf2lcjC9CqmhccxMwn8wbxxE2qThjvN9jSOYBM7IS
 EG3Kl8KV2Xavtf3vHVZSW1MfXBGqqo4wXdS2H9bYpRwfS4MU=
X-Gm-Gg: ASbGncu7FTxA7lXTwmT9amzOCdw2q3Ay43Av3xeluB4a51DHuw3V3TQBV9Kjjv3PzIp
 DQrmIRnC8k+yirBib+S+ROGYt0xqObDUJ904LnemMGeUtdgLhE+wkzJpL1H0zG+oXO3MSX9NaRG
 Hr1insGo21cWdb6930FASK4/SImYmgsVwIwQ==
X-Google-Smtp-Source: AGHT+IFxBhnk2tohLqeW4hz49xwNBpnxM6sO9gU4dRR8VwwhFXdR12Oe3XQB0iGskt66lqf3SEuMr/pQRpWwUx9oOcc=
X-Received: by 2002:a17:907:94d0:b0:ac6:b639:5a1c with SMTP id
 a640c23a62f3a-aca9b6162eemr278801266b.22.1744204132009; Wed, 09 Apr 2025
 06:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250407105151.689453-1-sjg@chromium.org>
 <20250408221324.GA5495@bill-the-cat>
 <CAFLszTg7-yM0L8uuJyN7Jpsb1LbvOYO76cUWj+H719mfc97mMQ@mail.gmail.com>
In-Reply-To: <CAFLszTg7-yM0L8uuJyN7Jpsb1LbvOYO76cUWj+H719mfc97mMQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 9 Apr 2025 07:08:38 -0600
X-Gm-Features: ATxdqUF0nBIfL84tJ9u6aSsH6kz9G4TN0cTTirHrt5qdZU0yyONaZk9_6UScM_A
Message-ID: <CAFLszTg1tRucZRAr=y1FTe=miG_NoRV_OTVmyJMVGWHjaE1oYg@mail.gmail.com>
Subject: Re: [PATCH 0/5] patman: Separate gitutil fully
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Douglas Anderson <dianders@chromium.org>, 
 Sean Anderson <seanga2@gmail.com>
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

On Wed, 9 Apr 2025 at 07:04, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Tue, 8 Apr 2025 at 16:13, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Apr 07, 2025 at 10:51:42PM +1200, Simon Glass wrote:
> >
> > >
> > > The gitutil module uses Patman's settings module, which is not allowed
> > > as it is supposed to be a separate package. This series ties up this
> > > dependency.
> > >
> > > This series depends on these two patches being applied:
> > >
> > > https://patchwork.ozlabs.org/project/uboot/patch/20250227192735.406389-1-sjg@chromium.org/
> > > https://patchwork.ozlabs.org/project/uboot/patch/20250328130225.2607974-1-sjg@chromium.org/
> > >
> > >
> > > Simon Glass (5):
> > >   patman: Untangle settings from gitutil
> > >   patman: Pass the alias dict into gitutil.build_email_list()
> > >   patman: Pass the alias dict into gitutil.email_patches()
> > >   patman: Pass aliases to Series.MakeCcFile()
> > >   patman: Update Series.ShowActions() to pass alias
> > >
> > >  tools/patman/control.py       | 11 ++++++++---
> > >  tools/patman/func_test.py     |  8 ++++----
> > >  tools/patman/series.py        | 32 ++++++++++++++++++++++----------
> > >  tools/u_boot_pylib/gitutil.py | 34 ++++++++++++++--------------------
> > >  4 files changed, 48 insertions(+), 37 deletions(-)
> >
> > I just want to reiterate my question / request to host these outside of
> > the U-Boot sources themselves so they can be managed (both in the sense
> > of U-Boot as user and as maintainer of sources) following normal Python
> > best practices? I'd be fine even with something under
> > https://source.denx.de/u-boot/<something>/patman, etc.
>
> Yes I am working towards that. This series cleans up something missed
> in the last series.
>
> After this series there is really just 'patchstream' left, which is
> used by buildman and patman. I haven't quite come to terms with the
> idea of moving it to u_boot_pylib yet.
>
> What are the best practices you are referring to?
>
> As to location, I can keep it in my tree and just delete it from yours
> if you like.

BTW I'm working on better support for handling lots of series, as
mentioned a while back. I need to add some docs, but will send some
patches at some point in the next month.

Regards,
Simon
