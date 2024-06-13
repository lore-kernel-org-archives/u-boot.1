Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0B9C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 15:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 724098887D;
	Thu, 13 Jun 2024 17:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T9vnKrBt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0048B8892A; Thu, 13 Jun 2024 17:22:30 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0BEB888E8
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 17:22:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-62a087c3a92so11964357b3.2
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 08:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718292146; x=1718896946; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=REbDl4gRT7XbujsR8jMfpv61LmC5OdirqFUqzs79AUY=;
 b=T9vnKrBtqpDbOn5eNTA2vIkV87x+ngDPO2vPFfjbVHOc3DaVs90e/9ENuYkbVZJoWZ
 qu/pdLfHSFz7/RgVadOq+VXc5xfvkaJQWXYkhpyVJ9u57mfroPvcl3yQ8YEs44WtZrlx
 glOGB6781jP+2CI1GiNKPSUCX4lNwcQC9F/Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718292146; x=1718896946;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=REbDl4gRT7XbujsR8jMfpv61LmC5OdirqFUqzs79AUY=;
 b=bIF6gQnmLBZxmvw497tNyTp2T4pXj2s45ih44S9Rvp4DKBfT75KjirRRrv9Np+LMTa
 0hj2CP5sBmz57nRpZNSEB/8hfB0eYV4+v0m6apupNSfFpNBoNhum0t1vRE03RXZEi/za
 aUQD9y5Gnt2q53W2/OWdCFOseIHS/16bVpvEKEWvEJPSMfBRdNu+iDr31+c8rmQqz+/7
 BZSENnKATI7z8jPG4wMO4HDUcHxo7WRiEIGVyt67kZFRxWRXJsXeA2B6f6BF9lf45+eB
 weeZitepDDkHyadiAWvLqJMKTWFvhhKJouI1qjeRsv5igVHq1L8BNloXYMgOv0qYijZX
 AWLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnsMjCOcv+bgqJ45jlKP+YnKAlRyxUKqBFOFs9FGLvDgCevqQgl58BXdj9lnd4RAfAJdkyTP0pARs9SFGj855Q8La2Dg==
X-Gm-Message-State: AOJu0YxwN/VLcfsCLxZ8YzKjPos7kIoZMW92sHtw0avri5AFvelAskYD
 cUUEZpqy6UgayusdQa/yDxyT1kNzCuVN3+DYyysYwVDwQV1dhB3vN0u+oe4iNBTQ377ggwG/1bV
 btdWHSumzd27pEU0445l4eZqmSc6Hh4ogAUZm
X-Google-Smtp-Source: AGHT+IE0OK2ohdOA+NoS65J6r6Jid6lp4uHpEsC6IBUuGTJY53UmpiIT+zxPAVy1zAUOj9TwzT9U4yGSjxxD4X70ipo=
X-Received: by 2002:a0d:ea91:0:b0:62d:45:4098 with SMTP id
 00721157ae682-62fbb410118mr49098107b3.26.1718292145784; 
 Thu, 13 Jun 2024 08:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-5-sughosh.ganu@linaro.org>
 <CAFLszTjQW72_Z8Dx4g1mVx5Y=wq9xeXYVBffxLUto6sDp6CMbw@mail.gmail.com>
 <20240611210145.GM68077@bill-the-cat>
 <CAFLszTjd4Sf=_um7QbkpbLAO9=2=vX_LkHv6br=9FPAPFhbH5Q@mail.gmail.com>
 <20240611225554.GO68077@bill-the-cat>
 <CAFLszTi1ZR+qeEuEbGUE2Fv3h1ahX3S_2ySBPQjgkfruiW8Xtw@mail.gmail.com>
 <20240612172244.GG68077@bill-the-cat>
 <CAFLszThj1wmF4zOLDjSjHX1cg8RfiHMGgpbRccJ-VJu2dtihNw@mail.gmail.com>
 <20240612214001.GI68077@bill-the-cat>
In-Reply-To: <20240612214001.GI68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Jun 2024 09:22:15 -0600
Message-ID: <CAFLszTiZSu+aN53kAPd2GXosXv09Ams+jFDi2xGU0wh+faO=dg@mail.gmail.com>
Subject: Re: [RFC PATCH 04/31] lmb: remove local instances of the lmb
 structure variable
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>
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

On Wed, 12 Jun 2024 at 15:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jun 12, 2024 at 02:24:25PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 12 Jun 2024 at 11:22, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Jun 11, 2024 at 08:41:39PM -0600, Simon Glass wrote:
> > >
> > > [snip]
> > > > Also IMO there is only really one LMB list today. We create it at the
> > > > start of bootm and then it is done when we boot. The file-loading
> > > > stuff is what makes all this confusing...and with bootstd that is
> > > > under control as well.
> > > >
> > > > At lot of this effort seems to be about dealing with random scripts
> > > > which load things. We want to make sure we complain if something
> > > > overlaps. But we should be making the bootstd case work nicely and
> > > > doing things within that framework. Also EFI sort-of has its own
> > > > thing, which it is very-much in control of.
> > > >
> > > > Overall I think this is a bit more subtle that just combining allocators.
> > >
> > > I think this gets to the main misunderstanding. The problem isn't
> > > handling bootstd, or EFI boot, or even assorted scripts. Those are all
> > > cases where things are otherwise (sufficiently) well-defined. The
> > > problem is "security" and that a "carefully crafted payload" could do
> > > something malicious. That's why we have to do all of this stuff sooner
> > > rather than later in our boot process.
> >
> > That's the first I have heard of this, actually, but a bit more detail
> > would help. How does the payload get loaded? I'm just not sure about
> > the overall goals. It seems that everyone else is already familiar -
> > can someone please take the time to point me to the details?
>
> Well, the short version I believe of the first CVE we got (and so
> started abusing LMB) was along the lines of "load an image near where
> the U-Boot stack is, smash things for fun and exploits".

OK. I am surprised that LMB does not catch that. It is supposed to add
the stack and various other things right at the start before loading
any file. So even if it clears the LMB each time, it should not be
able to do that. Having said this, the code may be buggy as I don't
think we have tests for U-Boot's overall functional behaviour in these
situations.

Regards,
Simon
