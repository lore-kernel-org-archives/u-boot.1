Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65473D3B9A4
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 15:39:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECD2D89C76;
	Tue, 26 Nov 2024 16:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dy/y6Jw1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C38D189C76; Tue, 26 Nov 2024 16:39:21 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC18489CA3
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 16:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa53a971480so422694966b.1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732635557; x=1733240357; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=57jP3v0lNjLt1OH9Y7KwOwbnZWbOlG0WCepiukWb0I0=;
 b=dy/y6Jw1ZYu94nKvlDiK4Jh1rAZwMZ1EFhBfOiJYeBVY+OoN2OPawtJhW9uBxzlkKz
 +53zHQ7WjtGP1O4oYuLpzplyGPVY9oqMKKu2aZsp6UpsJ0eCZB6+fHV4GbzmoHgxDsek
 z6/yCF83exC1mk516+B7Xxvcse1LoAgy8iMrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732635557; x=1733240357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=57jP3v0lNjLt1OH9Y7KwOwbnZWbOlG0WCepiukWb0I0=;
 b=qwFH6LsKdZYmOAl8zsXu76/I4GwDw38xkoMVtbDCady+AkIp+oz4aqgldnnZx7WPmD
 sQLgivlICtiRLDSaAKSZCq38UX49bEdwVIawIEa1Xqvg9OP/mcX5Kk6CKseI0SZn4WPF
 g+SpoQoFzlz/MTRnxQVQEhq5CGwSi7jl0rShaMWkpYwWAzhZOPupZrC+EREP5pJQw8fO
 CCrA0tsjVy3b89d/JOJSNS3CeHXlelwfQgnYwoJNba70DvQGKoHQKxG5G7J+OLZWYTok
 KYnaaOL3AzzTSGP1rbyC8XRAQyikSaxxdGIYcn4mj0QBmlz8xuweELwn56P3m9Zip36+
 nq+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNTyRofZHfEHRZWOz/SRsI5OCuY3l69KEVQZHd7qLkMeQ1k7mBHrKANMSJ2DwkYSEnfZ8p4CI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy04HYtmraUDidA8oOuIOsp1UD5beICOxAndWj318eoZ3osW+rT
 lmjOuhOaKy7BuzAmdln2UUpWXCt75bht/13nwC2raK5xMLYBb4LrLiKYvdpbPtDIUj2ZRryFCrv
 jEbtvtqDXvPlEk5efsC8hvQEY+aKIEK1lG6fi
X-Gm-Gg: ASbGncusk3m7HJyOVUPGdnLTriv11UL7vClTmgVwhlQKPqxa8fpwrJKX2eFmuutAuK4
 /q8EW2/5gZnjqB6OzMBpTYCMpfw+wY50=
X-Google-Smtp-Source: AGHT+IEZhJgtwSrAXJPAdgOHGrR2ZvbdZqrdSqABZKxOmMWS2ySWEyQGA5pUek+6bXkihKw96IFSrlD1OcnCgsq6acM=
X-Received: by 2002:a17:906:1bb1:b0:aa5:4d26:8e52 with SMTP id
 a640c23a62f3a-aa54d268e73mr762408366b.47.1732635557174; Tue, 26 Nov 2024
 07:39:17 -0800 (PST)
MIME-Version: 1.0
References: <20241125204456.1525752-1-sjg@chromium.org>
 <a6ba9ebe-9d52-4b2d-bb62-02c4f0ea86fb@gmx.de>
In-Reply-To: <a6ba9ebe-9d52-4b2d-bb62-02c4f0ea86fb@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Nov 2024 08:39:05 -0700
Message-ID: <CAFLszThf3aSwi1yhaQP9Ns7wTNjKH8XicAqUU6vy5gej5GP+CQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] efi: Tidy up confusion between pointers and
 addresses
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Janne Grunau <j@jannau.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Moritz Fischer <moritzf@google.com>, 
 Patrick Wildt <pwildt@google.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Tue, 26 Nov 2024 at 02:10, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 25.11.24 21:44, Simon Glass wrote:
> > The EFI-loader implementation converts things back and forth between
> > addresses and pointers, with not much consistency in how this is done.
> >
> > Within most of U-Boot a pointer is a void * and an address is a ulong
>
> No. It is phys_addr_t that was introduced to handle the sandbox's
> virtual addresses.
>
> And we should keep this sandbox stuff out of the EFI code. They are only
> needed for the command line interface.

No. My statement is correct and long predates sandbox. U-Boot has
always used ulong. Using an address is generally much easier than a
pointer, so I believe this design decision was (and remains) a good
one. I certainly would not support changing it. The phys_addr_t type
has nothing to do with sandbox.

>
> >
> > This convention is very helpful, since it is obvious in common code as
> > to whether you need to call map_sysmem() and friends, or not.
> >
> > As part of cleaning up the EFI memory-management, I found it almost
> > impossible to know in some cases whether something is an address or a
> > pointer. I decided to give up on that and come back to it when this is
> > resolved.
> >
> > This series starts applying the normal ulong/void * convention to the
> > EFI_loader code, so making things easier to follow.
>
> According to the C specification size of long may be different to the
> size of void *. uintptr_t is the type that is guaranteed to match the
> size of void *.
>
> There is no benefit in spreading the ulong abuse any further.

U-Boot specifically uses compilers where ulong can hold a pointer.
Same with Linux.

Regards,
Simon
