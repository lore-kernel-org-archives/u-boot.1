Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D76CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 12:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B56383CB1;
	Fri,  7 Nov 2025 13:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jvRNEb4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F111683D71; Fri,  7 Nov 2025 13:23:35 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A89E83BA1
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 13:23:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-63bdfd73e6eso1098178a12.0
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 04:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762518213; x=1763123013; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ptzjFLJ9iffct2uAVq6bpvImI2sKl2ckP4GlHIcQmJw=;
 b=jvRNEb4Fl8kmxEHoNMddGYj3UJMgf9TYgc23m8wRf4rMOpmArkFdG3RwJqjj2ozmhc
 lDVX7vUmAN6OT2w+c8VXSK2ZTWQjETxlbM6pr92/OcVZSdfry37inwXntMuApn8o4cID
 EHCHuZqxy2CY+ZLj8GuKNgCDCMs2X+PyAjpl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762518213; x=1763123013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptzjFLJ9iffct2uAVq6bpvImI2sKl2ckP4GlHIcQmJw=;
 b=BZbGO06Qy7UhgBBjqtkgEUuo09YZHoeYLWYbN7P7PQFUy/1eIlzqZFniqcx3OyySdo
 rfHOVF/YbE/rTMQkFnop9Zhvd1KPNwzWwEMM7kNvI0T2Nyvvq1Ir6evgyDF6gfWI9hno
 32BILlF2ugiYTfCV+g2hKQH/8QYMn82NFv0F+bWGhTkuz/Kb3yjsP7VkjbDtnZG27Rru
 DDrMk2N5eJCV7+WcGpW6zhdi2kPYoUDMwEklVHroNv1E1f6le9/jXp8wLixRf73THwDR
 w1NiItMNcYvRHX6XwQCN3S7WArcasOpzmZ5USxUn+ixQCp7h0++kKqgAriJsGA4r66ZQ
 5ejQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQK/zMorXdR89Sz2CNBgskEExEp+FP5s09wz/wkgkqmPQhfwIfFVqraisysEQ5i5Q2yZkACYo=@lists.denx.de
X-Gm-Message-State: AOJu0YxLMTQiebr3l2twRpfJJ6Uc3jzkfaqPmoPtnvUu32jQaDi1xVzd
 PHkpxhhTp3ckQRuTJNAXv9jR4wjDxb6O7amhGEUJDPcEN3y7AnpTww69vUP+RGrukGjCgn5VLo4
 fkQm+PGT/1STtEaPG62zT2UlzV4nV3NuECz90iUUG
X-Gm-Gg: ASbGncv2cXJFomQARJstrwh3JZhgsl+1oWac4JqHY4k/b0iwYUq+RwvMxpbpMnTBtRP
 sbw0BVxITueYRS+BeFyH11tMuUbMFu43gjNa0u34VKUAoq4ymiVvyN14AAyky9QYH9GO8DO8W5E
 6zusp/YKvfuxuRYzPmNm7nDb++aMOCk2FhB9+mVgVxTSEowL4K4uGxCftJPau+bJ6YbB40+mn6A
 xbir1KqG70BGVE2G3UZLXY5tJ8If7l8b0U73AHHqM7kXItzQ1j2aOlX9HN4+YG+0uIa3nI=
X-Google-Smtp-Source: AGHT+IHHomu1PeyFgvCHuGVZxcDTHO40eEGx0WyEVfP2nnbdw3txWqBhR5t4lqgabreGMbHsJD1hkdEufJl7mN30Ebg=
X-Received: by 2002:a17:907:7205:b0:b71:60a3:a8b9 with SMTP id
 a640c23a62f3a-b72d0af76c9mr166696566b.29.1762518213487; Fri, 07 Nov 2025
 04:23:33 -0800 (PST)
MIME-Version: 1.0
References: <20251105180748.115441-1-heinrich.schuchardt@canonical.com>
 <20251105192601.GT6688@bill-the-cat> <20251105193307.GU6688@bill-the-cat>
 <0a146dc8-f1bd-4a92-ab42-29909da4e7c0@canonical.com>
 <20251105230901.GV6688@bill-the-cat>
In-Reply-To: <20251105230901.GV6688@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Nov 2025 13:23:21 +0100
X-Gm-Features: AWmQ_bk38IKEdCflYWZRVrtVcRbIR0RpT06wzFjl3jxlgYE_enCLGHLB1ATuTQ0
Message-ID: <CAFLszTj6Hsh7omf=AQbLjOqvN=VrX=1ZQXYwaXhVJfNdqfQm_Q@mail.gmail.com>
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

Hi Heinrich,

On Thu, 6 Nov 2025 at 00:09, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Nov 05, 2025 at 11:57:25PM +0100, Heinrich Schuchardt wrote:
> > On 11/5/25 20:33, Tom Rini wrote:
> > > On Wed, Nov 05, 2025 at 01:26:01PM -0600, Tom Rini wrote:
> > > > On Wed, Nov 05, 2025 at 07:07:47PM +0100, Heinrich Schuchardt wrote:
> > > > > ARM and RISC-V do not have memory at 0x0.
> > > > > On X86 interrupt vectors are stored at 0x0.
> > > > >
> > > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > > > ---
> > > > >   test/cmd/fdt.c      | 4 ++++
> > > > >   test/common/print.c | 8 ++++++--
> > > > >   2 files changed, 10 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
> > > > > index 96a8488e172..6b07999c88f 100644
> > > > > --- a/test/cmd/fdt.c
> > > > > +++ b/test/cmd/fdt.c
> > > > > @@ -269,6 +269,10 @@ static int fdt_test_move(struct unit_test_state *uts)
> > > > >         uint32_t ts;
> > > > >         void *buf;
> > > > > +       /* This test requires low writable memory */
> > > > > +       if (!IS_ENABLED(CONFIG_SANDBOX))
> > > > > +               return -EAGAIN;
> > > > > +
> > > > >         /* Original source DT */
> > > > >         ut_assertok(make_test_fdt(uts, fdt, size, &addr));
> > > > >         ts = fdt_totalsize(fdt);
> > > >
> > > > In one of those "what is even going on?" moments, just out of context we
> > > > set newaddr to 0x10000 and then "fdt move addr newaddr ts". Loooking at
> > > > my logs for am62x_beagleplay_a53 where memory is not at 0x0, this test
> > > > is currently running and passing. I'm going to fire the platform up and
> > > > poke now.
> > > >
> > > > > diff --git a/test/common/print.c b/test/common/print.c
> > > > > index 76ee851fe6a..389d6bf4069 100644
> > > > > --- a/test/common/print.c
> > > > > +++ b/test/common/print.c
> > > >
> > > > These tests are also running and passing on am62x_beagleplay_a53 I see
> > > > in that same log.
> > >
> > > I'm poking TI folks about this in that it seems like memory is really at
> > > 0x0 here.
> > >
> > > But with respect to this patch, NAK, we need to figure out how to change
> > > these tests to run elsewhere rather than disable them on all of the
> > > platforms they currently run on.
> > >
> >
> > These tests that are not passing on qemu-riscv64_smode_acpi because of
> > illegal memory accesses.
> >
> > Unfortunately Simon has written a lot of tests with the sandbox in mind. I
> > agree that it is preferable to make tests more generic.

So long as we actually want to run them on the target, then maybe. But
what failure are you expecting to find? Compiler bugs? Mostly these
tests are a waste of time on QEMU.

> >
> > test/cmd/fdt.c also has issues.
>
> Perhaps lmb could be used to ask for a new address to use and then free
> it?

Eek.

Regards,
Simon
