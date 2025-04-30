Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977FAC369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 13:54:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0DF082153;
	Wed, 30 Apr 2025 15:54:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YFqGaZcA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E067281E72; Wed, 30 Apr 2025 15:54:28 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 862EC8070C
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 15:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ace333d5f7bso1197873566b.3
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 06:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746021266; x=1746626066; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bb2AtP0rl03IsctYqRhAqds4E0Ycqjd2mbSCSZUl+CA=;
 b=YFqGaZcA/YfSOlGd/L87df8xkCrwOHqiX7XZGIadnBdJcWr935Y3PUDCpAtU6WkVxN
 h6D4dM/rIBmyCqoBNtz68l56iTYFDQFdUrhm9SvqkGAxWQRWpowbxNT5THySiw13XHip
 SwoDnUKWlnX3Dw/kvZCDEgIkJixp1JO7vGdO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746021266; x=1746626066;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bb2AtP0rl03IsctYqRhAqds4E0Ycqjd2mbSCSZUl+CA=;
 b=aVOUlmvpxpyKr8zt9n6LKGOHYia3JfcgXvX1STlpw9j58XJ1g8QzTdgqe3X61Jvsy1
 1UtTVTShbzFgZdu/fVTd4EP5qRMqIHlfT86yH4nAU79xPyD1z/Ai4kIM+gjP+Wwyxm52
 vlLLhfzO9bYbQGx6+JWvfsubDDXGdsriRf5zGO96DvSJIAQ6oX8plUi1130bJ14pyjnw
 hKwpBd4t2ZjaALraAt9+THSiq69pkyCA1BFPSFWKsjp1Y2cVln5xH8KabnAnuw3cf7e1
 iukJR9dF8blqm0TD72hm1qb3iR/A2ev+tAKNfuAIBoIRGbNqfcqSOsqbP36l9uAtror8
 Xvzw==
X-Gm-Message-State: AOJu0Yw/xdA5HSsBHk3Qju0ihJDcbiB+fMFdOYVEj4t0D4Nrp/AqGW7G
 HMU99OYVThBaSjrTNq6/SmRtXnTVH4KuOgGT5oaHYqjhPms51sWBhHLjnXaDvE7lOwJCkdNIt+5
 Kl3/9CzS0SpqdhstU+5IaTlr7KuoBQZBVdlz9
X-Gm-Gg: ASbGncsHYtPS48ULdJ7V2NSyvlJV8MWYF8EqKMdnWfumGB5GYwZgo0p+JGatkxi6w32
 I6WIQ9xCvUqTHjzceZdc15oq4/VW/2u2RrDvmQzG6zR2Qn8FgVLXj0J2Xxt56CzCbNRI9FaZywP
 Wgj9TBN0pE8KwLaeX678ApV2E=
X-Google-Smtp-Source: AGHT+IHEn1V4EgpWoghi5UNU+Fs0yDXOSdH3qLEr7YwxVEye3ZUflZZVf4BjbAllmzMdkMMyhDOfkGA/UKkE4P2nUBo=
X-Received: by 2002:a17:907:3f1a:b0:ace:6882:510d with SMTP id
 a640c23a62f3a-acee21ec1a5mr276803666b.24.1746021265914; Wed, 30 Apr 2025
 06:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250429132239.251756-1-sjg@chromium.org>
 <20250429134846.GA1261075@bill-the-cat>
 <CAFLszTgrJvgWJaCXFgefJ1bObsrGfZa6AC8C6ypFRKJQTWm5ZQ@mail.gmail.com>
 <20250429145347.GG1261075@bill-the-cat>
In-Reply-To: <20250429145347.GG1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Apr 2025 07:54:11 -0600
X-Gm-Features: ATxdqUGir3-cSMeLUaWQ50WroJo_f88XK0XNKe9NCbxOTK2H5EZnoXGewrkcNoA
Message-ID: <CAFLszTjG4-3hjD2c4O7XaCQVheiY050rsVEh1RTyVH7QXYatTg@mail.gmail.com>
Subject: Re: [PATCH 00/30] patman: Move to asyncio and other updates
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Kochetkov <al.kochet@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>, 
 Douglas Anderson <dianders@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Leonard Anderweit <l.anderweit@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
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

On Tue, 29 Apr 2025 at 08:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Apr 29, 2025 at 08:35:24AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 29 Apr 2025 at 07:48, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Apr 29, 2025 at 07:21:57AM -0600, Simon Glass wrote:
> > >
> > > > This series moves patman to use asyncio instead of ThreadPoolExecutor
> > > > since it makes it easier to handle requests sent from different parts
> > > > of the code.
> > > >
> > > > It also includes some updates to bring patman in line with the other
> > > > major Python tools (buildman and binman).
> > > >
> > > > With this series, we have a better basis to add support for syncing more
> > > > data from a patchwork server.
> > > >
> > > > After this, the next step it to add a new 'patman series' subcommand, to
> > > > track and manage series workflow.
> > >
> > > This conflicts with master, please rebase this if you intend for it to
> > > be merged to mainline.
> >
> > I will take a look and see what patches my tree is missing.
> >
> > >  And to avoid confusion, while I think managing
> > > these python projects in this manner (and not AFAICT following python
> > > best practices) makes life harder for everyone else, that is not me
> > > NAK'ing taking more patches, I continue to be compromising and "Saying
> > > Yes" to things you do that I disagree with on non-arbitrary technical
> > > grounds.
> >
> > I'm open to managing them in my tree if that helps. For now it seems
> > like too much work to manage them separately, but if someone wants to
> > volunteer to help, I could do it.
>
> Again, if you won't manage them standalone as seems to be normal best
> practice,

I wonder whether that was intended to throw shade at my approach, but
if so I'll let it go.

Anyway, I don't completely understand the best-practice argument,
although I am open to it. It is extra work to set up CI, etc, but
probably not a huge amount. If I get keen one day perhaps I will take
a look. Just so many things on my plate already, as you know.

> we'll just keep them in mainline. It's up to you if they
> diverge or not, but it would be easy to avoid I would think.

Yes I can't imagine it will be difficult as there are so few patches.

Regards,
Simon
