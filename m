Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE2ECE7AF1
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 09:06:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99B00888C8;
	Fri,  6 Sep 2024 11:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZIhKKK4i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E976888966; Fri,  6 Sep 2024 11:05:58 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFF0688440
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 11:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-58ef19aa69dso1882490a12.3
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 02:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725613556; x=1726218356; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yryLcSJrIOG/NbbIIhdF8IQx9SjEz9EZ++xeZVKduO0=;
 b=ZIhKKK4in9dwsU+xZr4TdGLaVD3qUUL10/lL0UPbunzh/efB353I3Ss4L6Gg5pRubk
 VbPkp2/pPrbX8RQ9Ew9YoKxFW+OqR8Hoaoab+rVzjyzvnS9RK+XeD9vu9dSSmqKgsUFw
 ruLlxbIpoRC/HWo5NQ5baPbqWfD4peULSm1a9bhwGkMICHcQp8y5kYVWpw+NThF6C+jv
 VCtciDeS4OyLgr6QXDcVSlVd5a4wzKIKTGHtXPUP5qdfrj+Cs60bK6Rp58ZQqU0u+qmn
 8EXV6Gr0Wu/kw6YEwSCRxAPKzzKxJmt2VZGdBKBu58TAfMAQ7VEBUzKeFFPh9PskAyyr
 aYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725613556; x=1726218356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yryLcSJrIOG/NbbIIhdF8IQx9SjEz9EZ++xeZVKduO0=;
 b=JNxVYRZEv5WNTpSH3UHya1yn3pucymTTPpEzQK9KYVGIQUCG+yCMAssvbLE+RirFn4
 GCL2dIBeE5sDH009o8GXyQ9Ru7PGWQbq8d/Ob8YQYPWxfmYmPQ7rEwjMR3tK4VrePoht
 rPwDBHax1qecpwN4NyiXrPEnUHc9M0rjwMG0yOH+y7nYaJPT0lX3LBKfEJTpr6fK6X/u
 hLG/kLQ8aT7FMWjEIEQCxqlTZ9ZfADtB60bY6o0+MIit+ZVSYRB9FSuxzDzS/2a6k0ax
 BCjj4S2vevKdfh/wQe0UG0BnFvcfmTZ6zfrKRRbskszzGdHxgOJgOJ43VfCG4L6cf8fl
 D5SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYoqFq41UwyuozbbijM04T2RwYncWCzP9QnU+RuXd8zpeXq5Tdy4hmbQY4Yqkp4Lm6v6XnDeM=@lists.denx.de
X-Gm-Message-State: AOJu0YzBuMTH/8/qMaP1wrxEveLDrmlAAlRHYT71IBfDlXEnR0Hj3MmB
 ZQ+PGOuKRzlgcQb4PxgmMVvnftGpYjsT1oe2r8LIhgnENzbNIMa2r4wvXNx1um9tSEk/mWq86Ji
 1Z1FdBxvTjWZOTT6wJAYrN0j7wZE=
X-Google-Smtp-Source: AGHT+IFwxWNIlejPPtuMkTwhBLr0NzmeuCX0mGO2/F007Ux2tUapJx0yJKi6YtVnu7WOQnI3ZlrjiIdcfrULsroWgFA=
X-Received: by 2002:a05:6402:34c6:b0:5be:e01c:6b5f with SMTP id
 4fb4d7f45d1cf-5c3dc7c71f8mr1044441a12.33.1725613555614; Fri, 06 Sep 2024
 02:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <CAFLszTiRy3dkrTVnkV-H=CcCxJH6W5=RBM9tokOiSN-AVXGywA@mail.gmail.com>
 <CALeDE9PqT54MH0riLFng3ONi=rtEa53LsxRgYcV1ENX=ikuV0A@mail.gmail.com>
 <CAFLszThd7LoiOv6XjWe8hP1QWO5VZF_RSeXNSxqif=-BO1BkfA@mail.gmail.com>
In-Reply-To: <CAFLszThd7LoiOv6XjWe8hP1QWO5VZF_RSeXNSxqif=-BO1BkfA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 6 Sep 2024 10:05:44 +0100
Message-ID: <CALeDE9PeZ9eJA1rQ5vaW_BYscL4ywJKKpi_kV3mDoU9rjSaf_Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/28] Integrate MbedTLS v3.6 LTS with U-Boot
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sumit Garg <sumit.garg@linaro.org>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

On Fri, 6 Sept 2024 at 01:44, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Wed, 4 Sept 2024 at 06:48, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > Hi Simon,
> >
> > > I wonder if we could leave out the SHA stuff? The algorithms are
> >
> > One of the big advantages of the mbedtls when it comes to all things
> > security is that it's seen a wide audit of it's code which for a lot
> > of usecases is very useful from a security PoV, I'm not sure the
> > amount of audit the U-Boot in project code has had, I'm sure there has
> > been but I've not seen anything published.
>
> Definitely the hash routines and signing have been audited, in fact
> there was at least one bug that came out of it, although not in the
> hash routines themselves, which are solid.
>
> >
> > > stable and this would seem to avoid much of the size growth, and all
> > > the pain of trying to integrate another yet another hashing layer (we
> > > already have normal, progressive and h/w acceleration, plus
> >
> > What's the difference between the first two?
>
> Normal hashes the whole lot at once. Progressive does things a chunk
> at a time, to be watchdog-friendly. If CPUs are fast enough (and
> watchdogs lax enough), perhaps we don't need that code?
>
> >
> > > UCLASS_HASH which h/w acceleration should use but that migration never
> >
> > How hard would it be for UCLASS_HASH to use the mbed hashing underneath?
>
> I really don't see the point as there is nothing wrong with U-Boot's
> hashing, so far as I know. Half the patches in this series would
> likely not be necessary?
>
> But there is a hash_sw driver for UCLASS_HASH, which results in using
> software hashing, if hardware acceleration is not available.
>
> >
> > > happened). I struggle to see any benefit in replacing U-Boot's very
> > > solid hashing infra with something else, particularly as this series
> >
> > I would need to look at the HW support in both U-Boot and mbedtls but
> > given wider use of mbedtls I bet adding HW support there that U-Boot
> > could utilise may be more apertising to most HW vendors as it means
> > they only have to write one set of code and have it used much more
> > widely.
>
> I'm really not sure that mbedtls has wider use than U-Boot :-)

It's used extensively in RTOSes such as zephyr, micropython, FreeRTOS
just to name a few places I'm aware of.

> Yes, anything is possible in software, but I worry we might create
> Frankenstein's monster. U-Boot's acceleration stuff works fine and has
> a proper drive model. For example, with ast2500 it automatically does
> the right thing with the "aspeed,ast2600-hace" (compatible) node.
>
> >
> > > adds yet another. Better to invest the time to refactor it. I asked
> > > about this before and was told that it would happen 'later'. Let's
> > > just not change it at all, then it is more likely someone will sort it
> >
> > What, like the HW support in UCLASS_HASH? Things clearly don't work like that.
>
> Well, the big challenge here was the difficulty of avoiding *any* size
> growth, when I wrote common/hash.c - perhaps with the large features
> going in, this might be less important.
>
> >
> > > Also, if MbedTLS is wanting to be a general library for TLS (I assume
> > > transport-local security, not thread-local storage) perhaps it might
> > > consider changing to non-Windows newlines, or perhaps even kernel code
> > > style?
> >
> > I think the newlines might be a possible ask, they are generally
> > receptive to change (they relicensed it to be a dual license
> > compatible with U-Boot when asked), I don't think forcing a separate
> > to the kernel project to a kernel code style is a fair request.
>
> OK. So long as I don't have to change the code... but with this series
> there is an increase in the code debt in common/hash.c which I'm
> really not keen on, sorry.
>
> Regards,
> Simon
