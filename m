Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED017C25B47
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 21:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5E7B879BB;
	Tue, 24 Oct 2023 23:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vv5FByBz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A313A879BE; Tue, 24 Oct 2023 23:40:09 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6404879A3
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 23:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-540c54944c4so451161a12.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 14:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698183607; x=1698788407; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VUVnc8ibhuTUmtAWJBr4LI09rvGOKHf1xvSi3LT0Vpw=;
 b=Vv5FByBzx0PaeZzBrPi4GRG7Po40W3wpVAoOPNKHWwhESslwq1lu9HkhZgbXbpP1fy
 QVaytDzr7HX1ltgMy5fElv5yZaJGbJbf2HMGPfPqBKfS+pR+AIgUlAj5BNe5+LO9/Lkz
 9fabOAmmRG5KCr5+QwPO3/LmicWXrNyzBpF9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698183607; x=1698788407;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VUVnc8ibhuTUmtAWJBr4LI09rvGOKHf1xvSi3LT0Vpw=;
 b=qJ02efkH4HZ/QxuQ2sv7WyQQtxYamMJL5xiebkdW8YeXLQEk0NfPGv/wVntWAmgNF4
 hKZorXHvFp5+zvmoqEwJTCfH55Ezf1OuiPlK7oA00+yYxBhL7G9j2TFUUMl+FgL6bqxi
 EJCgZ4Ty52lcVwhVa4U6tCs5Z8ooP+vXiglzjDcf3wa47PKL/76IriNMZ7fdo8QuFjWx
 sJVm08EfEuSLlIp3soM95Nugme4fvtvpa67EQNtnVzZIZi6hUl0qoyKVz7qAGytIviOY
 2IgH0GskVEN81XO8r3KgqnDdGdRiGO8SFn3OybYt69HKw4ZxidGub25emrDNwGJ7iG/J
 MHUg==
X-Gm-Message-State: AOJu0Yyhj/5sNaihbvJ3lLKuohNsRebwf1cMUa8XVYSTWYAQoszfGPbi
 yeKEt6pA0gZBSa5CVIrQ1C9QgOpFPcAdVi6dtOYHKQ==
X-Google-Smtp-Source: AGHT+IG2KpfiUP2vyFuAE4jjG2Opx7BixNsY/Nh0L+zKlRT+n2oC5XavoUX89kNr/6PCtdRkk0FLpM2WUolKFT/lUxg=
X-Received: by 2002:a05:6402:2314:b0:530:ec02:babd with SMTP id
 l20-20020a056402231400b00530ec02babdmr13502845eda.9.1698183607001; Tue, 24
 Oct 2023 14:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231019150105.714407-24-trini@konsulko.com>
 <20231020215302.3511807-1-trini@konsulko.com>
 <20231020215302.3511807-2-trini@konsulko.com>
 <CAPnjgZ2jgfJ4GXR+2qt5Qi=MOc=kubLrMLgYBGuO_trinUHnag@mail.gmail.com>
 <20231021183438.GB53397@bill-the-cat>
 <CAPnjgZ2bKVTwEKcjeawootxXr-+iEmiowtctA52-=v07p+xBUQ@mail.gmail.com>
 <20231023133728.GH496310@bill-the-cat>
 <CAPnjgZ06w+uaSZr6PWo6NFoWfxiNuu-bar4e3zn+bVL-4wPvUQ@mail.gmail.com>
 <20231023172757.GV496310@bill-the-cat>
 <CAPnjgZ3G8T3ZjRNMdu=Jr_1OgijgQXNARQwAMQUFNy7ng4_zqw@mail.gmail.com>
 <20231024180738.GF496310@bill-the-cat>
In-Reply-To: <20231024180738.GF496310@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 24 Oct 2023 14:39:49 -0700
Message-ID: <CAPnjgZ1FruS29HdQZutZptRRdTggUWoCf972h2w2mhma47awww@mail.gmail.com>
Subject: Re: [v4.1 2/2] CI, pytest: Add a test for sandbox without LTO
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Tue, 24 Oct 2023 at 11:07, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 24, 2023 at 11:02:06AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 23 Oct 2023 at 10:28, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 23, 2023 at 10:13:52AM -0700, Simon Glass wrote:
> > >
> > > [snip]
> > > > BTW buildman supports -L which disabled LTO using the NO_LTO=1 option
> > >
> > > I worry about putting sandbox-specific flags in buildman.  Outside of
> > > sandbox, targets that enable LTO require LTO, just like any other CONFIG
> > > option.
> >
> > Some problems with LTO and why I don't normally develop with it enabled:
> >
> > - build time
> > - code moves around all over the place so it is hard to compare size growth
> >
> > At least for my IDE flow, I use -L in most cases. Yes there are some
> > boards which won't fit without LTO, but I don't see them much.
> >
> > So this is mostly a dev convenience / productivity tool.
>
> Yes, it does take longer to link.  And yes, a more complex optimization
> does make some size tracking harder to understand (since growth or
> shrinkage allows for different optimizations to be made around it). But
> everything in configs/ that enables LTO needs LTO.

I thought we were planning to enable it for all of ARM, though?
Clearly most of those boards don't *need* it.

Regards,
Simon
