Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392FEC072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 15:58:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8556A87285;
	Wed, 15 Nov 2023 16:58:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J5+jRhSi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0670B87258; Wed, 15 Nov 2023 16:58:38 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A257E871FC
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 16:58:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-db048181cd3so520587276.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 07:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700063914; x=1700668714; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BKDgetKSKloymRkLGwsI7R4Z+mcehDhqgzeExCNQDxU=;
 b=J5+jRhSiPpY24gjrTCZwonRbMXKAknORG4eANWh6WSMg3wC9u9b5rsU6FnXSKRqvX2
 FLzNdpwfNDobwm7lGjVsfShqr3jDQNN+IAl0+8qNAn5BR/lmLCr9I9Rb3Srns4TFM7ku
 BzBhkAFE8SMy5HprgRebDwDMkbTsdUSew4nXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700063914; x=1700668714;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BKDgetKSKloymRkLGwsI7R4Z+mcehDhqgzeExCNQDxU=;
 b=wOwsJ0MCnSdxbUl85zOWD566wCrpaQQ4FaramFvlNfaz46Knm1dntm4o5672QKiuu3
 Xw5UFxAGWSxTwATpGWktqk/PoXnJPUIybeWKbLcfhJUDBewSnbVyzYqs4KWt0ZNrZzij
 1k7HPcRZLjs6q9EkZmMcSsLJ2lpvAGZo4RECHYciww0VKOnVhdCYvSh54AapNFOL7/WI
 IEEY5bNr4SJr0YnsjI3SnLmASVf5XRnO8Lj+KE5F+rWUYT0QCRa8TacI8hgpxmmqovfp
 H7dymn9brCDIIdHMuEVJjw+qVyUaWyUQylCpjpp4MS+qFREYQNOCEZsy8u7u76w/Oh/O
 zMYA==
X-Gm-Message-State: AOJu0Yx2zG5Lr2lGBylKtfsoc0TuJm81HV5honWb49EA1YFGKMcm/vqe
 l+jeUb1+O1Zvvcmz56bpDidvAoVX82yyhtYxky9NBQ==
X-Google-Smtp-Source: AGHT+IF77spiEB03/SxRvVdlpiURjUnGxJJs8pPTjyRNUyMHjHcp3+vvnpDMv6Bu0HDjX+TI6OPKTBWoSyCM+c0AgY8=
X-Received: by 2002:a25:7314:0:b0:d91:b6e5:54dd with SMTP id
 o20-20020a257314000000b00d91b6e554ddmr13428008ybc.3.1700063914132; Wed, 15
 Nov 2023 07:58:34 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2hrverfcsEEahUcRkcjrnF3jr0oyds2yo0RBVMB7E01g@mail.gmail.com>
 <CAPnjgZ1-_ohZaVwMGtTDt4-W--2q0AM2KPtX9RLgAbMEhMRugw@mail.gmail.com>
 <CAHc5_t1icj6d82GH+FK8qGg3MvDkpwEicH964ULcN971_=aSKg@mail.gmail.com>
 <CAHc5_t2vLU9gHufMS_Fjv6j5+E8ksgCCLzKQ7NxTHzJsdcmsNQ@mail.gmail.com>
 <CAPnjgZ3VY_M+zd2na+N9WCxj-L2F+KKhLgykQ21FTA7GPVrKNQ@mail.gmail.com>
 <CAHc5_t1fBzzpJaQed9kcKF92ProStsutmOBW-1jmi5vWFvLM8g@mail.gmail.com>
In-Reply-To: <CAHc5_t1fBzzpJaQed9kcKF92ProStsutmOBW-1jmi5vWFvLM8g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Nov 2023 08:58:21 -0700
Message-ID: <CAPnjgZ3WNmnNv7DjMFDM9Med3yRng32N6tku4NGxbwA5DRhQgA@mail.gmail.com>
Subject: Re: bug - bootflow: grub efi crashes when bootflow selected explicitly
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Shantur,

On Wed, 15 Nov 2023 at 08:23, Shantur Rathore <i@shantur.com> wrote:
>
> Hi Simon,
>
> >
> > Is this the blue port on top of the USB-C connector?
> >
> Yes, that's correct.
> For my drive I needed -
> https://patchwork.ozlabs.org/project/uboot/patch/20231110141311.512334-1-i@shantur.com/
>
> >
> > Which version of Armbian / download link?
> >
> https://redirect.armbian.com/rockpro64/Bookworm_current
>
> > Yes it is scanning first, before reading the efi app, etc.
> >
> > I have the same hardware so may be able to dig into this.
>
> Sorry, I meant to ask if anything specific to USB.
> I see it loads efi from the network or disk and calls bootefi with the
> loaded address.
> I don't know deep boot / efi stuff, just trying to compare how it's
> loading efi differently than fatload in this case.

There is nothing special about USB in boootstd, so far as I know.

But until we figure out this bug, it is hard to be sure.

Regards,
Simon
