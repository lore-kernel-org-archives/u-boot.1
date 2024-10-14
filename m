Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AB9D1813A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 19:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9517F89155;
	Mon, 14 Oct 2024 21:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l/D5+cPY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7291A890F2; Mon, 14 Oct 2024 21:13:40 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 264188910C
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cbcc2bd7fcso30349616d6.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 12:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728933217; x=1729538017; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UxhcaiNdhkICfhGNYabqTNy0/zkV+6Yh+ZmcbCRYthg=;
 b=l/D5+cPYBChLbJyVSrfYAqfeqAIrt7zMKC9Ky8pwZ1IxdK/Ay/MDy3DLq8hdhkWV3o
 qXYpdKp2JQNuD3w4GanbLRrhi1AWE9DZzVmSbrqQanohOM8951TDzzx+gHFth7VwtzFy
 zMjjOCXvzXrUyKabaXAbWFjcoUpCs2lG4SbT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728933217; x=1729538017;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UxhcaiNdhkICfhGNYabqTNy0/zkV+6Yh+ZmcbCRYthg=;
 b=XfbmTfXA1V3jGHffR7tPJhjEwcRrEH/Q9GyJPVmWXJ6aX0hSx0Phck+Z8fm/nikYrA
 UEC3XuPbXKbHoMmUuOND7auDRAJTMcAzzNU6X8auyT5AnzlRI9LgwhEuT/VVthzJ2r+z
 aMS8vtd2YEJLX3c2BM11ugOSXXm5Tsmcyp/Lc0t7fQ/9ZlxpiT/IPGqYEZFVldTWLSyZ
 CYtUELuZ85Hv4ivKXfXfCBy6+2rjH1h/12PjdhOtuoIL4YHUnKGjccRnQZrR6OJk0kzn
 CrAMxuYndtZKFvUh9/IKfuw2HYUEaBKTGNHdVxD9ePc0EsY8m0+05dJi/RPcTjJhuqPd
 1tmA==
X-Gm-Message-State: AOJu0YwGY1LBsVtUBUo75hnLAbroQzMqo91t1eTXbpwE6s6EK7A//ZHU
 PuY+0I3XJbaXcXvqfrGjGTpK3+zX99VVnSB7ONof4A7t9+70MC0lSbJu23JDRS8NRSS4czYua6o
 U4svZfOskWh84gHMMZFBhV3oMJCpvBSQJsykmiRV6RtunqWA=
X-Google-Smtp-Source: AGHT+IGXhodwxOhLhUBekPD46/JiKrApd0G4x8e+l6BPbrfbLIwb/b8+yArJ6XyBj5L9GCm5CEQqB90vyvhIXILnA8o=
X-Received: by 2002:a05:6214:3d97:b0:6cb:ecb3:4d31 with SMTP id
 6a1803df08f44-6cbf0143967mr159252106d6.53.1728933217054; Mon, 14 Oct 2024
 12:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240815195746.749042-1-sjg@chromium.org>
 <20240815195746.749042-4-sjg@chromium.org>
 <CAFLszThRC=YvhPaiQD2bnvNFsGZZVexa3cx=NZ6PaBEdB-7Z2A@mail.gmail.com>
 <20241010190110.GV14210@bill-the-cat>
In-Reply-To: <20241010190110.GV14210@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 13:13:26 -0600
Message-ID: <CAFLszTjFeT+OKLrUT1Ck_D15nqxoJcq18LMmWFbJAwQocEvm4A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] RFC: CI: Skip building dtc for world builds
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
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

On Thu, 10 Oct 2024 at 13:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 10, 2024 at 12:50:11PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 15 Aug 2024 at 13:58, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > This is quite a significant waste of time in the world builds as dtc is
> > > built separately for each board. Skip this to speed up the builds.
> > >
> > > Unfortunately the newer dtc produces a lot of warnings, which causes CI
> > > to fail. I am not sure what we can do about this.
> >
> > What do you think about this one?
> >
> > We could install an older dtc in the container, perhaps?
>
> Is backporting applying whatever dtc flags we need to ignore problems
> that Linux isn't enforcing so difficult? That would then tell us just
> how much work it is / isn't to deal with the rest of the dts files (or
> poke maintainers to switch to OF_UPSTREAM where the issues are likely
> fixed).

That could work. Shall I give it a try and then we apply this patch if
I figure it out?

Regards,
Simon
