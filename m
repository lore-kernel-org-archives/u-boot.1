Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D49C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 15:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DEBE8215F;
	Wed, 30 Apr 2025 17:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nFwWbPo+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2122782B97; Wed, 30 Apr 2025 17:00:38 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBF1A8215E
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 17:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac289147833so48014266b.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746025235; x=1746630035; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MkGO7Z0BQQ/tCfCi1UzumUxGDzHudc1umE1eMuosTJE=;
 b=nFwWbPo+p+jRoxqKsCHWc09MlLSYqOZUL3QCYRwUhBUh/5fr4tHiVtihANt/NxbeyV
 aE36COAW1qOGXWE3O7CHdZcdRb6yCC80Ks/g7ZppQpd1MKVGkCc3M2r1/+Q+1221eVad
 RRDtVCw2PHVO9UJ1tlvfWOXFwWM0kiIU51gMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746025235; x=1746630035;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MkGO7Z0BQQ/tCfCi1UzumUxGDzHudc1umE1eMuosTJE=;
 b=V8mXGWKd7Hd28BDwGl6QsYGwm7B+kkw1zt3fLjHybxUVxy1zU/2DxhW099vYq91B9s
 pF+vd9TCce/ekgJtP9H5B+/NOafIv0aTSFIS47SBvqcz/UlG/U90+aQP6ioSvFEhjhhr
 3AiUlMhO4VecK87DFaVcYQGdPdOAH7/glFN57Q0AS6VTJXafACNQvPvdoQpNgJcEEMQR
 eCEhXhPiyvy4GQDsO67y5G7udzuC2UEKLXyj9G4LQ0tV7slTy715L/qj+gTeSeyiG7Yh
 12t80bog6K3ClKRBLVnuYuB7M/ODFSqV09XBl/rW5SXsIkPQTIUbiatJUMFxLgibudZg
 tN1w==
X-Gm-Message-State: AOJu0YyGqGsz43uvjV54CTOv0TJh81iF5SGo4n+wP+FR9ZpJXfMNG6Az
 O+1H2WiHdELzB1fowaTQ0CkGzs6/9Kbv8vOtwB/qdOPNRZpnQjg5r0Gb/dYsbKzLTKU0oOUYFnA
 IcZz4Lpln5SIUf0m/C/n2u5VVjM9VGwfQn6bS
X-Gm-Gg: ASbGnct94R5SkKhCCKPhZL+iCPSNO3CnFlhsnweHFhlHLUQtA39Q5gkt6pbs2FkjpFp
 jJDIWULRzNg4n0TGj8Q47C7oW/zEI2vZaa8AculUYa8+Rf18cg3g1umFmi/o+lJElbpMP4f4y9t
 0CfPOGpIEUKddEs6V1SgNCuxc=
X-Google-Smtp-Source: AGHT+IE+zAUd2UE8ud+GDVLgSX6w91/ct/CsadePLJ3dhSgaRLun2cuwwyEkTSjEUDGWEKD5Z9DUh1A3Lun0xFa7PsA=
X-Received: by 2002:a17:907:9605:b0:ace:4fcf:702b with SMTP id
 a640c23a62f3a-acee21e30d9mr307641766b.28.1746025235195; Wed, 30 Apr 2025
 08:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250429132239.251756-1-sjg@chromium.org>
 <20250429134846.GA1261075@bill-the-cat>
 <CAFLszTgrJvgWJaCXFgefJ1bObsrGfZa6AC8C6ypFRKJQTWm5ZQ@mail.gmail.com>
 <20250429145347.GG1261075@bill-the-cat>
 <CAFLszTjG4-3hjD2c4O7XaCQVheiY050rsVEh1RTyVH7QXYatTg@mail.gmail.com>
 <20250430142142.GP1261075@bill-the-cat>
In-Reply-To: <20250430142142.GP1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Apr 2025 09:00:23 -0600
X-Gm-Features: ATxdqUFSAOqn2cldmUhQxbJ9zAJz3GS1IQCHGC9GJoqgSfoZqFaQ6Fw7qLLRUYk
Message-ID: <CAFLszTi5jq0gA1GZZ6BudWA5z7TpGOS5amfPUKNXo-AGy_iXhQ@mail.gmail.com>
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

On Wed, 30 Apr 2025 at 08:21, Tom Rini <trini@konsulko.com> wrote:
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
>
> And I honestly believe it would be *less* work for you overall since
> there's countless tutorials on setting up all of the automated CI/CD
> stuff and you could just put it on public git forge and use their
> regular CI/CD flows.

It would have to be gitlab, I think. The common files in u_boot_pylib
would be a bit annoying (would need to be a fourth repo I suppose).
Yes, I could set up an automatic release instead of typing 'make
pip_release', which would be nice.

Regards,
Simon
