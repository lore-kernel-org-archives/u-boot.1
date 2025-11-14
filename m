Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D01CE7B02
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 12:45:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4B4A840C1;
	Fri, 14 Nov 2025 13:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hv2qL/x2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59DED840C9; Fri, 14 Nov 2025 13:45:32 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F7D8838CE
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 13:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-343ee44d89aso2635030a91.2
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 04:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763124328; x=1763729128; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yLEjnQBJOBtrXRRcqSk0b0GM5QiyYXMQEHd2NgvtBwU=;
 b=hv2qL/x2WzOzVyX3XiG/aKgCrbbSW9G7ZZeMjux19C6YKUYjhbNipKJmpYQ15f6nHM
 Q41r37EhdzfQjB9xswOJvPrUJXmLplv3QrjgF6nVjYjWMLH9+ao4QXBqyid80l3ABT9I
 iAbdM8Ifq6xkDoGG+cYE4Jw8ypT6moGq7zwG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763124328; x=1763729128;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLEjnQBJOBtrXRRcqSk0b0GM5QiyYXMQEHd2NgvtBwU=;
 b=uR1SgrwBLoBFK39bsw+X75jObdOvz8umLJa1b/feHB0pDyzBNll7MM2SOJeip9vCZ0
 OVbJyXHVZQ4ZuQXYRKZNk0EEC6JrLXHWC0Xm0HHpyyMdUuRoW070cHkNub8l4caFIORz
 4wpiCK23P0R4GDdm2wxxuYWMrQXzK28DMamgZnoa4Rqlc89hVxBIYIvOpf2cYlBJmig9
 1IoqyckXskqj9usL8JqtIv+jOuxEtOZskl25Ti6D0xA3K82OQDuVOyMZ5xJ9yUnY5eXV
 3/zApME7BpL1v7eUJgdS5fd3jyqfiONwHrWcqBMdJAAbYG4xFC0si1phrnEFtt9P0sfG
 S9MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzDx8mi4XEQEwnbW0kBrRXlebWWnDsztoYpWwgy2a0CEb1O6jstBSUZPbX5sjlQN8grU5K9JY=@lists.denx.de
X-Gm-Message-State: AOJu0YzApYK2jm9kee2X/ITb0tGisNNi6m+C3d3JT5U5N6FJuvfgeWaQ
 AQPNEFypZIrZdgHpZi0611PtB7Kr5iBNyHLo+T9KVPOEp5kjgHljmbdieToxKcqrC+XORKfWt2u
 JmpsuBT4DlJoqfBKjoeHV1K2TC24eTMxmYN0IsUU0
X-Gm-Gg: ASbGncuJc8ozJMzwa/YTvvOmBylryvleZKAZC0hwdGdhS7rd5pWph8/UuNS1R/nTtMJ
 k6O3Gk3mRawcMsJUntQQe4r8SX5YiWx9i7cMIraSIH9pGsMbgHqAUMyBlPI/XXRkmvbklG4cjvD
 rIgUdL13epEcdi8H9ALz5zIuIjxCOI9tblaXab2cJhQFx/20wLH6/V2+T3EW7ms2r5JBeoXHy/K
 6PwU+baEkcBPgotdz8Jrqvcsxq8UkTqyAHm3qPsZ2DAK16g18PbzJAhsZBDtfDDSmX45HRoEpKu
 AidkiXp/JxijQR0=
X-Google-Smtp-Source: AGHT+IE6ncYtSip9a5KuIrEomlq/Qlv6TNIlTFeT5meFh/P79S7iU0avyYJuYZeXzky/vx9JdAxJCVyhHINhxWnIsEw=
X-Received: by 2002:a17:90b:1d02:b0:32e:38b0:15f4 with SMTP id
 98e67ed59e1d1-343f9eaa47emr3467085a91.7.1763124328584; Fri, 14 Nov 2025
 04:45:28 -0800 (PST)
MIME-Version: 1.0
References: <20251105180748.115441-1-heinrich.schuchardt@canonical.com>
 <20251105192601.GT6688@bill-the-cat> <20251105193307.GU6688@bill-the-cat>
 <0a146dc8-f1bd-4a92-ab42-29909da4e7c0@canonical.com>
 <20251105230901.GV6688@bill-the-cat>
 <CAFLszTj6Hsh7omf=AQbLjOqvN=VrX=1ZQXYwaXhVJfNdqfQm_Q@mail.gmail.com>
In-Reply-To: <CAFLszTj6Hsh7omf=AQbLjOqvN=VrX=1ZQXYwaXhVJfNdqfQm_Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Nov 2025 05:44:42 -0700
X-Gm-Features: AWmQ_bljOte7gER44REFq5epOL1vd1bmwu4VsQPkNQBEyFLwLSf-bWiPRjZkQUU
Message-ID: <CAFLszTjiNBMbJG=DWER+DPQTJNe-SsdzxFP_76=iyyGhNVkrCA@mail.gmail.com>
Subject: Re: [PATCH] test: do not write to 0x0 except on sandbox
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
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

uHi,

On Fri, 7 Nov 2025 at 05:23, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Heinrich,
>
> On Thu, 6 Nov 2025 at 00:09, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Nov 05, 2025 at 11:57:25PM +0100, Heinrich Schuchardt wrote:
> > > On 11/5/25 20:33, Tom Rini wrote:
> > > > On Wed, Nov 05, 2025 at 01:26:01PM -0600, Tom Rini wrote:
> > > > > On Wed, Nov 05, 2025 at 07:07:47PM +0100, Heinrich Schuchardt wrote:
> > > > > > ARM and RISC-V do not have memory at 0x0.
> > > > > > On X86 interrupt vectors are stored at 0x0.
> > > > > >
> > > > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > > > > ---
> > > > > >   test/cmd/fdt.c      | 4 ++++
> > > > > >   test/common/print.c | 8 ++++++--
> > > > > >   2 files changed, 10 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
> > > > > > index 96a8488e172..6b07999c88f 100644
> > > > > > --- a/test/cmd/fdt.c
> > > > > > +++ b/test/cmd/fdt.c
> > > > > > @@ -269,6 +269,10 @@ static int fdt_test_move(struct unit_test_state *uts)
> > > > > >         uint32_t ts;
> > > > > >         void *buf;
> > > > > > +       /* This test requires low writable memory */
> > > > > > +       if (!IS_ENABLED(CONFIG_SANDBOX))
> > > > > > +               return -EAGAIN;
> > > > > > +
> > > > > >         /* Original source DT */
> > > > > >         ut_assertok(make_test_fdt(uts, fdt, size, &addr));
> > > > > >         ts = fdt_totalsize(fdt);
> > > > >
> > > > > In one of those "what is even going on?" moments, just out of context we
> > > > > set newaddr to 0x10000 and then "fdt move addr newaddr ts". Loooking at
> > > > > my logs for am62x_beagleplay_a53 where memory is not at 0x0, this test
> > > > > is currently running and passing. I'm going to fire the platform up and
> > > > > poke now.
> > > > >
> > > > > > diff --git a/test/common/print.c b/test/common/print.c
> > > > > > index 76ee851fe6a..389d6bf4069 100644
> > > > > > --- a/test/common/print.c
> > > > > > +++ b/test/common/print.c
> > > > >
> > > > > These tests are also running and passing on am62x_beagleplay_a53 I see
> > > > > in that same log.
> > > >
> > > > I'm poking TI folks about this in that it seems like memory is really at
> > > > 0x0 here.
> > > >
> > > > But with respect to this patch, NAK, we need to figure out how to change
> > > > these tests to run elsewhere rather than disable them on all of the
> > > > platforms they currently run on.
> > > >
> > >
> > > These tests that are not passing on qemu-riscv64_smode_acpi because of
> > > illegal memory accesses.
> > >
> > > Unfortunately Simon has written a lot of tests with the sandbox in mind. I
> > > agree that it is preferable to make tests more generic.
>
> So long as we actually want to run them on the target, then maybe. But
> what failure are you expecting to find? Compiler bugs? Mostly these
> tests are a waste of time on QEMU.

I never really heard back on this one, so I suppose my point is made?
Should we set as policy of running core tests only on sandbox?

>
> > >
> > > test/cmd/fdt.c also has issues.
> >
> > Perhaps lmb could be used to ask for a new address to use and then free
> > it?
>
> Eek.

Regards,
Simon
