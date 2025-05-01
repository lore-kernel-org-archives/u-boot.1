Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B93C3ABA9
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 07:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D61098059D;
	Thu,  1 May 2025 09:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a1xEP593";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A870F8059D; Thu,  1 May 2025 09:50:54 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88C5F8056A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 09:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e6f4b3ebe5so1291427a12.0
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 00:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746085852; x=1746690652; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YdC8+b2wS/cXBE25/uJECi5PHqSx1oDC9ZJ4XtCGlVY=;
 b=a1xEP593ixjuc4h6I9r2Bjkiqg++OE7fxVsmmRjAsNGUlA2lOoeToK3dt2cSrZKLSp
 J1NShv115OIp615W7nuveU/9FLRpVhMOs3ES0RLppasvypw/H1h7Y3DTFz+FIMy5iAI/
 q+Md7rWOvZVku4Fr5w3W0deKdi/8wYZyGbwTY14Fv13tZBbKJOQucBjOieVVO4FMORne
 QlxVS0gU41MUoAiBdaT8p41NslAGy8+T+eACM8gW3PVNcHrvi7BuYFuRq1WF2zoYfJRY
 myehcqN8maj6AnKzAEAUfW1LLeErjTqdoxEmomKEiZ5mrkNlwbmyOdqa/tglxMwo7vAC
 6kyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746085852; x=1746690652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YdC8+b2wS/cXBE25/uJECi5PHqSx1oDC9ZJ4XtCGlVY=;
 b=Pthpb/3SULxClWkAI7BgK7U+piv/yDAOHfav9u+u9kX1WAHRjzcW1mQEY/5SV7xYWI
 EJTXprJMX7gQtDRKKZLyXNhZJt6G9nhHqnu2YZBleluKa3W2L9hChmVn240CQ2qmkEvm
 it3v4RjTTRBxJ+sNv1rjqtBVAf4ljQcSVX1ZKLghKuh/rvMfWCUSxb/0mvs/IKGWr4tX
 VtCb9wluCsWrCo0QH1rgaLpg5Gtk2oNT7uTG/NEZ0GsVM4/U0eodcmDIcETYs7isD+qZ
 b3VWALQfkTb3wAguEMeCY8lEs1SFqAPNra8Kh+JldcXbr6gLlADtFfCsZF20DLzxfy9P
 eptA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn1bUneEWvXZx3IhKYb+3EDQNpUuonx4uatqdHTs0Paj9Bvxs0JO0K4QYrCAJso+novyukVwE=@lists.denx.de
X-Gm-Message-State: AOJu0YxOwUH6u77KF9KO2fdPm/EGG/gqXnM4dyXkmub/9TJMG9UViLA5
 +m9uA6g0l/eDz0j8PJ+w6FSgKjVppgKOaMfqBD3Yt1JcqioIetLgsz8aVVus5wm3SY0DrBWXdqA
 QqUX3gVHcPKhTHlSOda76p7jYnno=
X-Gm-Gg: ASbGncu9jvkz9/QqPxcz0dMnZNnmpzI9dyp4ju3h59O8m58Fby2lZJyzjl4Bygv41Y/
 k3JqM42SCWV0AOlxEfqk8uIiKBWNZx6fkCAMJkP4Pzg1PonayFSCLD22SotdmkKATWI4qmZ+k6d
 a13Eu9M8ReA5GR9xch1byzrWk=
X-Google-Smtp-Source: AGHT+IH7TlcpZtXvO32/jiNifobsjgxg44DOPTQaY16X7wfcd964zAitc6y90h4zG9LAUFq3W5YWE1ry62GhIzHBIEU=
X-Received: by 2002:a05:6402:5186:b0:5f8:cf3c:8af6 with SMTP id
 4fb4d7f45d1cf-5f9124eb41dmr1586691a12.9.1746085851652; Thu, 01 May 2025
 00:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250429132239.251756-1-sjg@chromium.org>
 <20250429134846.GA1261075@bill-the-cat>
 <CAFLszTgrJvgWJaCXFgefJ1bObsrGfZa6AC8C6ypFRKJQTWm5ZQ@mail.gmail.com>
 <20250429145347.GG1261075@bill-the-cat>
 <CAFLszTjG4-3hjD2c4O7XaCQVheiY050rsVEh1RTyVH7QXYatTg@mail.gmail.com>
 <20250430142142.GP1261075@bill-the-cat>
In-Reply-To: <20250430142142.GP1261075@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 1 May 2025 08:50:39 +0100
X-Gm-Features: ATxdqUEbQIlIA3BtVxbIQ6L3St1vlS85rrZGQvAGNgLTLd2_YBdVhm-eXjdfDpo
Message-ID: <CALeDE9ML13DyV31BHuG1V9Z8w-uJT1Qu-idbAWq+XF=a0yjmBw@mail.gmail.com>
Subject: Re: [PATCH 00/30] patman: Move to asyncio and other updates
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
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

On Wed, 30 Apr 2025 at 15:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Apr 30, 2025 at 07:54:11AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 29 Apr 2025 at 08:53, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Apr 29, 2025 at 08:35:24AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 29 Apr 2025 at 07:48, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Apr 29, 2025 at 07:21:57AM -0600, Simon Glass wrote:
> > > > >
> > > > > > This series moves patman to use asyncio instead of ThreadPoolExecutor
> > > > > > since it makes it easier to handle requests sent from different parts
> > > > > > of the code.
> > > > > >
> > > > > > It also includes some updates to bring patman in line with the other
> > > > > > major Python tools (buildman and binman).
> > > > > >
> > > > > > With this series, we have a better basis to add support for syncing more
> > > > > > data from a patchwork server.
> > > > > >
> > > > > > After this, the next step it to add a new 'patman series' subcommand, to
> > > > > > track and manage series workflow.
> > > > >
> > > > > This conflicts with master, please rebase this if you intend for it to
> > > > > be merged to mainline.
> > > >
> > > > I will take a look and see what patches my tree is missing.
> > > >
> > > > >  And to avoid confusion, while I think managing
> > > > > these python projects in this manner (and not AFAICT following python
> > > > > best practices) makes life harder for everyone else, that is not me
> > > > > NAK'ing taking more patches, I continue to be compromising and "Saying
> > > > > Yes" to things you do that I disagree with on non-arbitrary technical
> > > > > grounds.
> > > >
> > > > I'm open to managing them in my tree if that helps. For now it seems
> > > > like too much work to manage them separately, but if someone wants to
> > > > volunteer to help, I could do it.
> > >
> > > Again, if you won't manage them standalone as seems to be normal best
> > > practice,
> >
> > I wonder whether that was intended to throw shade at my approach, but
> > if so I'll let it go.
> >
> > Anyway, I don't completely understand the best-practice argument,
> > although I am open to it. It is extra work to set up CI, etc, but
> > probably not a huge amount. If I get keen one day perhaps I will take
> > a look. Just so many things on my plate already, as you know.
>
> I'm the one who approved putting all of these tools in the main
> repository initially. And I've griped in public more than once about
> Python (not, you, Python) being less than ideal at times due to seeingly
> ever-shifting best practices. I however make the "Python best practices"
> argument because if we want to attract more developers to help with a
> thing, we need to develop the thing following language specific best
> practices.

I believe having the tools in their own repos outside of the U-Boot
repo makes sense for many reasons. A few that come to mind:
1) Tools like patman are generally useful tools on their own outside of U-Boot
2) they're more easily consumable for non U-Boot stuff
3) they're more easily discoverable
4) if they're python they're easier to push to pypi and hence
installable via pip (see also option 3)
5) easier to maintain, releasable independently, easier to deal with CVEs etc
6) build a community independent of U-Boot (see option 3)

> And I honestly believe it would be *less* work for you overall since
> there's countless tutorials on setting up all of the automated CI/CD
> stuff and you could just put it on public git forge and use their
> regular CI/CD flows.

Especially for python projects where things like github actions and
the like enable things like automated publishing on tagging etc, you
can get automated vulnerability scanning etc and most of the CI setup
is a one off task.
