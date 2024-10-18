Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1090D3DEA2
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 17:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77FCA88DF3;
	Fri, 18 Oct 2024 19:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K4aHdhTt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2322588E51; Fri, 18 Oct 2024 19:21:08 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F22BD88DF8
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 19:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b1418058bbso164016885a.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 10:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729272063; x=1729876863; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O5ZuM3vJPDiWRzo7KCdH08YhdJyTCjCpzcxHwOmphOE=;
 b=K4aHdhTtWHSR51LDcZMAVOvuuuHgrjhjzX2AYrjrlawUjjJOMQ1PovTysNJT6UOZBI
 88vTkP9ETJI4FCY5jk0tPtfXBp8KmH1kiyr/YYXwTQdikQBBiFk63mM7RP6RVjW6g/Bm
 ygu8UCgAzFXlQCe42e9lKncHPopsOBnOUE62c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729272063; x=1729876863;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O5ZuM3vJPDiWRzo7KCdH08YhdJyTCjCpzcxHwOmphOE=;
 b=Siew+qfRIqrYdRTqBjVFHurIg53saCpjDrpD7sWxfFMikr/8pSCn5gmtHFxlO6MdZx
 1/mygAQG+CdVvpi8s4Hc4nXZYj1YY0tgI91OT9LYRtBxmyu87Xi2U+p0DjU1sBa1uFYd
 mG698EkoWu1Cnl4bmgJMb0v04rGl2z7GeCwOF3GP3xM5pOpUDaZaqqQoVsX86XrkDHJR
 462kAGOh7RaAKxjmzv59SKARrS3Z54XRxLB+Xi8PWT8Tm0qT+j59n9gbNEtxxyhFtLip
 xqo38jCMjR+0bux0PHqXRR+bcIB7wo8C4gDAf8tpLhYdRGAF071bF8qCaSzM0OKOfhkP
 EOmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPgcecPoMDrQu4cflIjXusEg9f6MEvcI0EyhrYCkzPdXle4XTMw+RTGD8TjC9p3YQfa6JCw5o=@lists.denx.de
X-Gm-Message-State: AOJu0YwBKSm3GenkZfHSQDDA59xaDq7q9pfQdGlydY7jX7bzE16Zh8VX
 SbB2wYeX5u3qVIpAs2MKI9+9J89Y4oVDtR0MCm1LZsF3yg5IULXhcVqm9sreAeitXWj4dHtOjFb
 zspKvN3EkGJU085PEEujV1d6d5VWrdwvGC23v
X-Google-Smtp-Source: AGHT+IHNMOydzsf06ZNsUCLz+9e/ddDduJM/6tooksXy2tLMBekA9h+aZ4mLihT5FCYUUbB2nukRYZMloH33vV1/MBc=
X-Received: by 2002:a05:6214:4981:b0:6cc:51f:6c31 with SMTP id
 6a1803df08f44-6cde14c6c38mr43136086d6.5.1729272062904; Fri, 18 Oct 2024
 10:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241017232413.724808-1-sjg@chromium.org>
 <20241017232413.724808-24-sjg@chromium.org>
 <0B48F871-BDD8-4810-ADA3-4F6C4E403B0C@gmx.de>
 <CAFLszTjF-kg5E+sV+CkFjStmS2YyJiPa59zOWWZxd2J5yOwftA@mail.gmail.com>
 <20241018163303.GZ4959@bill-the-cat>
In-Reply-To: <20241018163303.GZ4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 11:20:52 -0600
Message-ID: <CAFLszTi2+2si4bq-iZK5fncnUnBHVLnpp6kqJAGFyK5Lis9OZg@mail.gmail.com>
Subject: Re: [PATCH 23/34] bootstd: Maintain a list of images
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nam Cao <namcao@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Shantur Rathore <i@shantur.com>
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

On Fri, 18 Oct 2024 at 10:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 18, 2024 at 09:01:03AM -0600, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Thu, 17 Oct 2024 at 22:07, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > >
> > >
> > > Am 18. Oktober 2024 01:24:02 MESZ schrieb Simon Glass <sjg@chromium.org>:
> > > >We want to keep track of images which are loaded, or those which could
> > > >perhaps be loaded. This will make it easier to manage memory allocation,
> > > >as well as permit removal of the EFI set_efi_bootdev() hack.
> >
> > I'll change this 'hack' to 'feature'.
> >
> > >
> > > Please, keep in mind that files can be loaded manually, e.g. via the dhcp, the wget, and the loady commands. These are outside bootflows.
> >
> > Yes, this series is only going to help if bootstd is used. For ad-hoc
> > use, EFI will need to rely on the above feature, at least until
> > someone can think of another solution.
>
> Perhaps I need to try and be clearer here than I might have been in the
> past. The consensus among off the shelf free software operating systems
> is "just give me an EFI interface". This simplifies things on their end
> if regardless of architecture it's the same interface. This means that
> in U-Boot we need to treat EFI as one of the primary interfaces. Not a
> novelty. Not a "some people might use". It is a frequent and commonly
> used feature.

Yes, EFI is everywhere and growing. All the more reason to tidy up
this piece. I would like to see bootmgr use this new API, for example.

But how does this comment affect this patch?

Regards,
Simon
