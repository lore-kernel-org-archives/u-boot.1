Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE011C021B2
	for <u-boot@archiver.kernel.org>; Sun, 23 Feb 2025 00:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2048E80F3F;
	Sun, 23 Feb 2025 01:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SFbw9uCx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6581680F56; Sun, 23 Feb 2025 01:01:15 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9315880540
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 01:01:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-abbd96bef64so538459566b.3
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 16:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740268871; x=1740873671; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v5z0bWhScDgEsPFrO+NRI6UXoA3sqUb0AO2Sg/3IUWY=;
 b=SFbw9uCxOCvwdH5uQAnPawb9sPLZfXXAqKN5u4tQewbwv+PXKrfLErqUverJdruXyk
 yhzvkmZ2vArHS6LDdZi61jf3zMCAwNDGMVQR8B5CObKyqL82BinFbJhJUodZalRZZZCM
 PTwJxSpvAliq/qZvdUV4/XRme56ZzCZKvtfSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740268871; x=1740873671;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v5z0bWhScDgEsPFrO+NRI6UXoA3sqUb0AO2Sg/3IUWY=;
 b=vpdxu3bVEXCriZid38pi0SMxr9nsvtM3cFR4xW+mmTFqigsHGXWuiVklyTiTL07yoW
 zisbFXpKyox6Qd2lA4HR1cz0Bfjysc5JcKt+BJPH2VXPHn4JbGQkLM7GFOKai6h9WBeV
 VlMWuf1brjeHzJsxvtVqWXTKX4HM+fFOrvsDb/HYJXDcP9qXjr5SnLZ8p821ZrcY3CDd
 0fUSMM6qKqyqEvSWjmcVafDpTizMH5mp1DV5sw7Ck8AeiYvbWasjXCkhOZb78sBPnd7p
 RBcDaQEX+i15CiD/5+UciOH5OcilcN7w4/5msODNhiu1ErU2Bi1VLfUL0JUwcEoDpReT
 h/HA==
X-Gm-Message-State: AOJu0YzTEslKHr1U+t/cGib4yNKhyGb8bWsJFKrApMYO6kJe8ZbsoQzA
 oeoxJBhj31b7LkKTPi3XTeQJHu5fmUMRsM8wRPYbTRFVM2BTAXYtnlUH4VF6IoO7AEV78fCyNOx
 8UGXSdYrltzT/qi2hpYga7srXvwNQqnVLEjpYWc9Cn/JMFeA=
X-Gm-Gg: ASbGncsSqIwdGuoJsZV0mBg1qobjP8Uhm1miDfgZbL5oun+i9SPndmdgJ1bKzGLWSGi
 GuDtg76elubhdYKL34HRn8PA2xu1WoWl90039pa9u0JeDMeHyqbiEhMwUpPOr6HmeHV+ndeCx1e
 97MoISWL3i
X-Google-Smtp-Source: AGHT+IF9LCXjuY4bb+VYe0GukjFUZglP8Uvmm1n0Zp6bcS7YGhoi7Ym2aCHrFDt5MOuNpWpKNB0uPdpvzms0gxDEGv0=
X-Received: by 2002:a17:906:a38b:b0:abc:28a5:cbe2 with SMTP id
 a640c23a62f3a-abc28a5cc58mr409818066b.55.1740268871019; Sat, 22 Feb 2025
 16:01:11 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTgnP7wGymh58coQBP=Rbui2O=ggXDT+Yu1pcgvCoLuFXw@mail.gmail.com>
 <20250220151643.GZ1233568@bill-the-cat>
 <CAFLszTiKbg2twYpJJTFb9bFya+5D2DsVPBGKXuw9pw6Y+cvUbg@mail.gmail.com>
 <20250220174005.GA1233568@bill-the-cat>
 <CAFLszTh=Mn9Hxe41KBB+8xjBBxVv=spV=g26tY+Hq6q43EM4=w@mail.gmail.com>
 <20250220204001.GC1233568@bill-the-cat>
 <CAFLszTjx1uQU+O=XrS6BBijpiSNtdR_-X_9LCjYZCSe+A0HC8g@mail.gmail.com>
 <20250221141940.GG1233568@bill-the-cat>
 <CAFLszTh=oq3z4P_tAKYETHE40yfHQOH1XHeKqmhQEAQ=PL1HUw@mail.gmail.com>
 <20250221175320.GN1233568@bill-the-cat>
 <20250221181055.GO1233568@bill-the-cat>
In-Reply-To: <20250221181055.GO1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 22 Feb 2025 17:00:59 -0700
X-Gm-Features: AWEUYZmnB7bRABt3dxaA4IurFRQiYKy7lVYbXmEl8rvcECPW99MBPAnmg8Da790
Message-ID: <CAFLszTgnj+ZFq1vEcSSKCOeYjx0NKesO8Lo3aOJ2Nm-jhuTvig@mail.gmail.com>
Subject: Re: Rate of change in the project (Was: Re: xPL Proposal)
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

(I think you chopped off too much context, so I've added it below)

On Fri, 21 Feb 2025 at 11:11, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Feb 21, 2025 at 11:53:20AM -0600, Tom Rini wrote:
> > On Fri, Feb 21, 2025 at 08:03:12AM -0700, Simon Glass wrote:
> > > Hi Tom,
> [snip]

[unsnip]
> > > > >
> > > > > Sure, but we can't even get sunxi bootstd or LED over the line. How do
> > > > > you imagine we could retire the legacy image?
> > > >
> > > > Partly by focusing on one thing and not 5 things at a time. bootstd is
> > > > stuck on reworking efi bootmanager integration, and LED is waiting for
> > > > someone to confirm that really, finally, we have all of the old use
> > > > cases supported in the new code.
> > > >
> > > > But more importantly, do we really have anyone not using u-boot.img? I
> > > > don't know.
[unsnip end]

> > > If we did one of these sorts of things at a time, we would only get
> > > 2-3 things done each year!
> >
> > A project with 4 yearly releases finishing two 2-3 big changes a year
> > sounds great to me. Rather than not finishing a dozen things?
>
> As this is a huge thread already, I'm splitting this part out.
>
> I would seriously frame slowing down and having just one big change
> being in progress at a time, until it's done, as a good thing, not a bad
> thing. We're a small community with limited bandwidth.

I can't see how that would work.

I just looked at LED[1] originally sent almost 5 months ago and the
latest version is marked 'changes requested'. I don't know of any
changes I can make. Are you hoping that [sorry forgot who it was] will
get around to digging the only affected device out of his drawer and
try to get the activity-LED going? It might take a while.

The sunxi one[2] was sent over 6 months ago and the latest version is
also marked 'changes requested'. You could apply that series with
either the bootmgr revert or the patch that drops bootmgr for sunxi.
Then Heinrich can come along with his patch on top of that.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=431000&state=*
[2] https://patchwork.ozlabs.org/project/uboot/list/?series=432628&state=*
