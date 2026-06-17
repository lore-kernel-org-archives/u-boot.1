Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D11CD98F0
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 12:30:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACA0F846B0;
	Wed, 17 Jun 2026 14:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="cGWQGxON";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B69ED848EB; Wed, 17 Jun 2026 10:19:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5933A848D8
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eballetb@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781684362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=liO0tyEiQq9PdqRr1Cdn6SWK0qs7SMr4HDItsYFR+KM=;
 b=cGWQGxON/t9mxWL/EFiNucglnhf8HpzsLEAw1XdhvLGph5jeTA4RcTnrYYt1OLO27z/Ex0
 nwFNk+PnV6Iefl5dCKFiuKKiCEGTyTaBuwMza87Pfm1cwWXEiofdMdyGLTyAcqrzV3ypV7
 EJjGgcGtXwADghxpTqyhWI59AslzeQA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-uAEBhISPNbWslWYi4vzq_A-1; Wed, 17 Jun 2026 04:19:21 -0400
X-MC-Unique: uAEBhISPNbWslWYi4vzq_A-1
X-Mimecast-MFC-AGG-ID: uAEBhISPNbWslWYi4vzq_A_1781684360
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7d38b23d6cfso9808537b3.2
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 01:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781684360; x=1782289160;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=liO0tyEiQq9PdqRr1Cdn6SWK0qs7SMr4HDItsYFR+KM=;
 b=a++G+YLsmAPtsqwLpk+Aq7SBD6iC/nJmkCIX3MX2igVFPB9R1Msiyp+ljKAcVBLuZr
 hdNkfAOhE1JUF9k9efR0b0l01XM8JL68miYiIh0xE6w0wm39cMmzG42UW/9hdzrYw+tC
 pPJgL80FDXKeirfzwQClpKtQ7RDVCWfTGyUT3wX745XMcZKuTug2KwyrhpWdMDup9MUs
 xkgO74RxKjbaz2bcGkX920bVAtavl9aTi8GjYsWy60hvFpWT5wWjjp6jpM4wuJurBrfJ
 h1rlV9giecgA0UbmnBMBbeEWZTqmS5v0N7IjFhC1H8l63KLfXzqa9f5BENXft26mWFEy
 Inog==
X-Forwarded-Encrypted: i=1;
 AFNElJ8cdbmdI55iCsGK2mdDHE4WuwMWxYq4Bx8MJEGCnVmUmdVVDNVCuCF5AtCTfynBkCIazD4DcHI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5ua0tt02lCSZII5kxWmjjFPjVJGdZIbP+kNhROV3O1xLjRuji
 pIauXKyk+4e4SrYqXyxSLuxb69578bp571gBPMh3EcOaRS/4qRsj9If/gse0V6RHEEHB3iSXBwU
 emZhLm6t5+Ew19rc5dUj5uO/kK+jo1QkxJVOCnwssz7XrJxHFge0vYP6FrBsbF4/qx/nA5YiOWI
 1cd3t3PXdt0BLSIV2lcIySjxkMMo5cLQ==
X-Gm-Gg: AfdE7clrtkfs/vUF2JYUutZrJOfdvB3UseWMKpZqMQAzDiLaRP8ZqOiIASzirRQ68pj
 oD7TCoWV+/HqXg/XBQIIwJR9gd8HNrU56nRbnRQmyhFSLWp2Ko6CaEQiyjsDORurz0+YBFKdBch
 GgR6z7wXoT0wpXkJP0c2eP2Qe9Ld4kXHwvpj1XIDESMCHPmwmaFYyG4DhdLg9Gc/Mn
X-Received: by 2002:a05:690e:408b:b0:660:376b:5437 with SMTP id
 956f58d0204a3-662cbc2c7f3mr1353967d50.7.1781684360284; 
 Wed, 17 Jun 2026 01:19:20 -0700 (PDT)
X-Received: by 2002:a05:690e:408b:b0:660:376b:5437 with SMTP id
 956f58d0204a3-662cbc2c7f3mr1353954d50.7.1781684359765; Wed, 17 Jun 2026
 01:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260429180247.83091-1-ekovsky@redhat.com>
 <482dbc09-e78e-42e7-9915-bdc105652494@cherry.de>
 <ag-EpjuQlre9QmYN@daedalus> <8d7ff3b6-abb9-4441-8491-99c538ea5f2d@cherry.de>
 <CALE0LRtVVwJpmaLn6=95BihVZA3pWPAwM1t7zENSsKdaxzWk8g@mail.gmail.com>
 <eca33072-97bf-49fc-890a-a51b7fdc4d62@cherry.de>
In-Reply-To: <eca33072-97bf-49fc-890a-a51b7fdc4d62@cherry.de>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Wed, 17 Jun 2026 10:19:06 +0200
X-Gm-Features: AVVi8CcysWgRT-oYESnGzwdcaZQPzjUjoUsnmAgrmXCSjm3DQs_QLXmrPtIyBtY
Message-ID: <CALE0LRvobvMnm=P4qqcNjzWPhRjtYLO4sbHP4UHOKLTdUoaryA@mail.gmail.com>
Subject: Re: [PATCH v4] Add support for OpenSSL Provider API
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Eddie Kovsky <ekovsky@redhat.com>, Tom Rini <trini@konsulko.com>, 
 Tobias Olausson <tobias@eub.se>, Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 a.fatoum@pengutronix.de, 
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.denx.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Xngweq0U36dTaU9HkozJDZq4HjdaJonePeaQuwc9Pjk_1781684360
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 17 Jun 2026 14:30:10 +0200
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

Hi Quentin,

On Tue, Jun 16, 2026 at 6:43=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Enric,
>
> Thanks for chiming in.
>
> On 6/4/26 8:22 AM, Enric Balletbo i Serra wrote:
> > Hi Quentin and Eddie,
> >
> > On Fri, May 22, 2026 at 4:38=E2=80=AFPM Quentin Schulz <quentin.schulz@=
cherry.de> wrote:
> >>
> >> Hi Eddie,
> >>
> >> On 5/22/26 12:29 AM, Eddie Kovsky wrote:
> >>> On 05/12/26, Quentin Schulz wrote:
> >>>> Hi Eddie,
> >>>>
> >>>> On 4/29/26 8:02 PM, Eddie Kovsky wrote:
> [...]
> > My understanding is that to fix the Fedora build issues without
> > breaking existing workflows, Eddie just needs to adjust the control
> > flow for v4 like you suggested:
> >
> > If the user explicitly commands an engine via -N, prioritize the
> > legacy engine path=E2=80=94guarding the engine headers and blocks with =
#ifndef
> > OPENSSL_NO_ENGINE instead of a blanket OpenSSL version check.
> >
> > If no engine flag is passed, route seamlessly into the new Provider API=
 backend.
>
> Fix the build issue by checking whether OpenSSL engines are supported
> (and no, a version check is not enough for OpenSSL 3.x (it is for
> OpenSSL 4.x though)). If they are, keep the same logic as today. If they
> aren't, fail hard when an engine is requested, otherwise keep the same
> logic as today. Make use of #ifdef to guard code that cannot compile
> when engine support is disabled and you should be good to go. This will
> still fail unit tests because we are testing and building a dummy engine
> regardless of support. But last time I checked (years ago), many
> unrelated unit tests are also failing on Fedora, so it wouldn't be a
> deal breaker for me (and I have some "interesting" ideas on how to
> handle this in a later commit).
>

This makes perfect sense to me. Since you already have a provider
series in your local queue, pivoting v4 to strictly implement these
compile-guards looks like the best path forward. I also appreciate the
clarification regarding the unit tests, knowing that the expected
dummy engine test failures block the patch, as they did before.

> Also, please do not use USE_PKCS11_PROVIDER when it has nothing to do
> with PKCS11 provider. I understand this was imported from the kernel,
> but they do only support PKCS11 as far as I could tell, so it makes
> sense for them.
>

I agree now that I have a bit more knowledge.

> I honestly don't want to see the Provider/Store API being used only for
> loading simple keys. It already works without the provider API and isn't
> deprecated as far as I know? Let someone who's interested (my employer
> is, therefore I have to be :) ) in supporting OpenSSL providers do the
> work of implementing support for OpenSSL providers, with unit tests,
> backward compatibility with engines through the OpenSSL provider API, etc=
...
>

Agreed if protecting backward compatibility for OpenSSL 1.x
distributions are critical, and we definitely shouldn't break those
existing legacy engine setups.

> For PKCS11, we have some interesting logic for the OpenSSL engine, and I
> think we may want something similar for the OpenSSL provider.
>
> Note that OpenSSL 1.x is still used in some distros (Bullseye, Slackware
> 15, AlmaLinux/RockyLinux 8 according to pkgs.org) so I think it's still
> premature to entirely remove OpenSSL engine support (and OpenSSL 1.x
> doesn't have the provider API).
>
> >
> > This fixes the compilation bottleneck on some distros, completely
> > preserves legacy engine setups, and allows real providers URI
> > string-mangling issue to be handled as clean, independent follow-up
> > patches.
> >
>
> We need proper unit tests for supporting OpenSSL providers (and not only
> a local key using the Provider/Store API). I'll repeat it once more, I
> have local WIP (but tested) patches for OpenSSL provider support, so I
> don't think it makes sense for someone to redo the work. The fact this
> was started back in November 2025 and it hasn't been really pushed hard
> since kinda hinted at this not being a big issue for RH (or they keep
> their stuff downstream and upstream can take the time it'll take), hence
> why I was waiting for Eddie to answer/send a new version (I've also been
> swamped at work for a few weeks, which should end soon hopefully, so it
> also worked out for me to wait on Eddie).
>

Knowing that, there is no reason to duplicate your efforts. Please cc
me when you send it upstream, as I'm interested.

> > Does it makes sense?
> >
>
> Somewhat. I still don't understand the obsession with the Provider API
> when the issue (as I understand it) is "I cannot compile OpenSSL engine
> support and I don't need it".
>

To clarify the "obsession" point, which I think is an unfortunate
take, my impression was that this wasn't just about throwing a quick,
blind hack at a Fedora compiler error. The build failure was simply
the trigger.

Eddie put significant effort into researching the modern OpenSSL 3.x
API, studying how to phase out legacy, deprecated components, looking
at the U-Boot's testing infrastructure, and trying to proactively
modernize U-Boot's backend based on established upstream kernel
patterns.

I agree, now, and this is the beauty of discussions, that the kernel
approach is not enough due to its narrow scope. U-Boot=E2=80=99s edge cases
make a full API migration heavier than expected. However, trying to
actively clean up technical debt is a valuable goal, and
characterizing it as a mere obsession with a build error can be quite
discouraging for new contributors putting in real work to improve the
codebase.

That said, if Eddie is willing to do so, keeping that patch focused
strictly on the #ifndef compile-guards looks like the right approach
to me too, and it leaves the runway entirely clear for your provider
migration patches later.

Cheers,
Enric

> Cheers,
> Quentin
>

