Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6B7C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 00:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 447468789B;
	Tue,  5 Dec 2023 01:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EHb95bFI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43C3987885; Tue,  5 Dec 2023 01:53:01 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1629B87897
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 01:52:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5d400779f16so30284467b3.0
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 16:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701737576; x=1702342376; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UqOM0tLRdatnZ1JwXKXX1JNZ213nU7YHgvwN7kUNZFk=;
 b=EHb95bFIYCuPJ+Q/j2pfQxSAxuKRAprDgxb5btYquA+bVdF4FBeQWMLFGJV3FadTdk
 Nw69XivD0S1SEN1yhWMhn0cTHkmUDzTZEHYaA+l9Mw3utIV3Asif27FxKxXu2fu7feMY
 z/SD2+NblSErS9I6wCxcrG99Re7siwQYRETTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701737576; x=1702342376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UqOM0tLRdatnZ1JwXKXX1JNZ213nU7YHgvwN7kUNZFk=;
 b=pzQasjZYYv8dD44Z4c0hIkzo3tuonc84rUE5G3o55XRbOzr/4jLU2ADc6aV3VitR4C
 L2XTGsXt6xVa161B3uq7gwjsKL19h0WZKzwOKjwTGYJAzJpsQbEpnadkFtuiBAynDYF+
 8f1IguWNspuYk3RJfzspirT04QAmStPh7eK+wklsnf6XJ7A25fXdVgGM4RXGwB1pUpD3
 x9gYku1wbIJSr2Y0JhJ/BZuTPTpDfbwXCrN45HPvEa1LwxB294ghuneVGcVW21JOKqkX
 9FfoDlcQ72/dYDBr8x7eq07ka+7Un202mMjQ94Rl1EZjYu8hngQU9HPptfMPNbsOEf2L
 MalA==
X-Gm-Message-State: AOJu0YwWj74BMmzVezcwjjVIfot3JlO+dZVDKdWM9wQCAUPtkH22i9eg
 YV9ttSOyqKKuITITzrWDOIqbSUMTrd6q1SBkv25d7Q==
X-Google-Smtp-Source: AGHT+IGpZK5JNBxxzVsnqiBg7Aqf/yGkGO7fdx3gZTJIXlQpKhnv5MWS0TnrycfBJ30tj+1/on9KQLNYOmMABlNSF4k=
X-Received: by 2002:a0d:d8c8:0:b0:5d7:f34a:28e3 with SMTP id
 a191-20020a0dd8c8000000b005d7f34a28e3mr540363ywe.7.1701737575577; Mon, 04 Dec
 2023 16:52:55 -0800 (PST)
MIME-Version: 1.0
References: <CAPnjgZ2Os+zLWnwc03AZc69p3FCiUuJ4thncvMy8wrOeEh52_A@mail.gmail.com>
 <CAC_iWj+fZMNFkDBOLNYKh1c9oRPrg5WQrFv6nVA9NmtFcAtz2g@mail.gmail.com>
In-Reply-To: <CAC_iWj+fZMNFkDBOLNYKh1c9oRPrg5WQrFv6nVA9NmtFcAtz2g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Dec 2023 17:52:13 -0700
Message-ID: <CAPnjgZ0Dbcox7Gjkkt69jKgBQcBLPk4yC=Yctu=Xjmj20gF8OQ@mail.gmail.com>
Subject: Re: EFI memory allocation
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
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

Hi Ilias,

On Mon, 4 Dec 2023 at 05:05, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon
>
> On Sun, 3 Dec 2023 at 19:44, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Heinrich, Ilias,
> >
> > I had a bit of a look at how memory is allocated in EFI.
> >
> > I see that efi_memory_init() is called quite early in U-Boot. It
> > sometimes allocates memory for a bounce buffer, placing it somewhere
> > in memory. How do we know that that memory is free and not being used
> > by U-Boot?
> >
> > To answer my own question, it excludes U-Boot's malloc() region from
> > the map, so that it cannot overwrite that.
> >
> > But then, what if we use lmb and start loading images into memory.
> > Won't that conflict with EFI?
>
> Yes, Heinrich tried to fix parts of this with commit 06d514d77c37 and

OK, that looks very odd to me.

> we have a 'todo' in the efi subsystem for a few years now [0]
> Michal (+cc'ed) has also pinged me for similar issues in the past.
>
> >
> > I also see that efi_allocate_pages() is called to allocate memory in
> > the EFI code. But this just grabs memory from 'anywhere'...it doesn't
> > respect the U-Boot malloc region.
> >
> > It seems to me that most of the memory allocation in EFI should be
> > done using malloc(). Of course the boot services need to
> > efi_allocate_pages(), etc., but I am not sure that the internal tables
> > should be skipping malloc()?
> >
> > What do you think?
>
> I think that LMB, EFI and the whole memory reservations is a bit of a
> mess. Tom and I discussed this a bit in the past but I'll start
> working on it.
> It needs fixing, but without looking at the code first, I can't
> provide any useful feedback
>
> [0] https://source.denx.de/u-boot/custodians/u-boot-efi/-/issues/2

OK I mad a comment there. We should figure out a design before going ahead.

Regards,
Simon
