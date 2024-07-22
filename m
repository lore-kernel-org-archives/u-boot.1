Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92223C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 12:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01BCA88363;
	Mon, 22 Jul 2024 14:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F4a0jGGv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC7C688385; Mon, 22 Jul 2024 14:30:43 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7371988005
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 14:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70d18d4b94cso788136b3a.2
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 05:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721651440; x=1722256240; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aiRKcPtmFXgynFDyiAJXM//O8bR5yrbPdYwJRJfXJ5g=;
 b=F4a0jGGvYaX5O1jPWXiDCIQQDvXfakIfgkP7kUU24vRbf/3++eWB6BddqjyWm/VpbL
 LmTurxM3/i+Oe58wxmzvkPiq5HuxG6+Rejp+wAsTfR+nyZ1RgH6hG8g10I4l10TiUnVd
 ryx06mIX25YVi+7STQO48nam6H/bC6OZwbQGEPnSy+KYNqcZWTEnAZI+ZyQbNEVApOAI
 sFtFE1BPo3rmf1wwaF2VfaIGHhZSMoynYJI/Cl1SPRtWuEZ4TszRoJY/nE//MytwHuwK
 8VIZVrj0lSaR0ZqgiWWK5cVqmwpKaAo1Tm4Z/DwPjJnIOsA7VBf8Qcl9Qytedqnbu4/C
 hwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721651440; x=1722256240;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aiRKcPtmFXgynFDyiAJXM//O8bR5yrbPdYwJRJfXJ5g=;
 b=jHLffIlc355i3nQ+SCHu8/g/M1z9D/5ovWAhTTLo6+A+6pt7fwkQyEd2KBQkHduKsy
 iP8jJH+gXKcQdndl1T9f5uQg0xwrf8hj1/QOW0j3oThYuHrwGEK6r1QsCldVuOGE6Vku
 ikeEy1xb7nrXVFFP+sWLts4q8pZ0qAbbfb8FAEfyBERqSALH7F+2Xme708CR7qIPBPxf
 x3cDF6/VJhpVPoZ6Kqum5iJHrgxsNAo/fzi9qlM0U7Mm+umqkeHbXTGzUynXIewG8NAF
 OQdGtOBq8ZLAkNBIG+1q0zBtYdl+psA3mm34kkfIHbeBzeOeS+EVn96YK5wiThoO+CxN
 Ahiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzvbfLH4G6mWtv9g0BnQNu0SD833tm7DtP6GmMoSBnwavIsEfyuC+s4fBjTcruASxKANZxeZ9kTboBI3ieIX9eiy0W5Q==
X-Gm-Message-State: AOJu0Yz6ENxY/Mv10gQG9ox/di+yAYJC7217onE6zJIjP8EcaN0yDN3s
 deMTZVPMd2HDKmySBkRIrW/lcwXLHw9Do2eN6BXxftC85jsjllaGSlGfyDSgl1nFsTDOCMAQOVl
 MAoAZAxZqna8JmpMtiiHuKmD3TyREZh5+YIN/sA==
X-Google-Smtp-Source: AGHT+IHoiJN4OlD+xtfujiWOAkn4Fh0cK2xqz/Z/jGMkUFzCKnY3Pj36qQJHeDCFZ/GAkmhQ5//KMFYnmLu2ydTLcqk=
X-Received: by 2002:a05:6a00:194a:b0:70d:26f3:e5cb with SMTP id
 d2e1a72fcca58-70d26f3e9f5mr3021960b3a.3.1721651439867; Mon, 22 Jul 2024
 05:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-39-sughosh.ganu@linaro.org>
 <20240705195057.GP38804@bill-the-cat>
In-Reply-To: <20240705195057.GP38804@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 22 Jul 2024 15:30:03 +0300
Message-ID: <CAC_iWjJDwFLMaP=S=z_OMnnQb=q32QMEPoywxPWwjixMSbJ84Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 38/48] lib: Kconfig: add a config symbol for
 getting lmb memory map updates
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>, 
 Michal Simek <michal.simek@amd.com>
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

On Fri, 5 Jul 2024 at 22:51, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jul 04, 2024 at 01:05:34PM +0530, Sughosh Ganu wrote:
>
> > Add a Kconfig symbol to enable getting updates on any memory map
> > changes that might be done by the LMB module. This notification
> > mechanism can then be used to have a synchronous view of allocated and
> > free memory.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1:
> > * Change the description to highlight only LMB notifications.
> > * Add a separate line for dependencies.
> >
> >  lib/Kconfig | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 7eea517b3b..b422183a0f 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -74,6 +74,16 @@ config HAVE_PRIVATE_LIBGCC
> >  config LIB_UUID
> >       bool
> >
> > +config MEM_MAP_UPDATE_NOTIFY
> > +     bool "Get notified of any changes to the LMB memory map"
> > +     depends on EVENT && LMB && EFI_LOADER
> > +     default y
> > +     help
> > +       Enable this option to get notification on any changes to the
> > +       memory that is allocated or freed by the LMB module. This will
> > +       allow different modules that allocate memory or maintain a memory
> > +       map to have a synchronous view of available and allocated memory.
>
> This needs to be select'd when it's going to be used, opting out of
> making sure memory reservations are obeyed isn't a good idea.

+1 which begs the question, do we need the config option at all ?

Cheers
/Ilias
>
> --
> Tom
