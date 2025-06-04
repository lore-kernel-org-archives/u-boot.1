Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3FCC5B549
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 15:37:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC3B8801BE;
	Wed,  4 Jun 2025 17:37:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AhFouwNL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86EDE803DF; Wed,  4 Jun 2025 17:37:30 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6C20800D7
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 17:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-234d2d914bcso49458885ad.0
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 08:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749051446; x=1749656246; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ToxRC3vNEZk3I2I/zcyiwQhQdoU3V7SXGWdY7hnYeQQ=;
 b=AhFouwNLaMLuW4XmppU+D4DiA/85k3YuJvELiWKJQGfJaM/ZigWa3lOM+JR4oAFoz9
 EXukznPWp2Lvi5oNM4tnVKiGibTlP4MZDsklgyB8BZN1Z0GfYkeQ7jSTu/U4zVY3fqfz
 1kmTfgCuLslzKyT4vvEbVR6zyY5vt4zXMQ4KlXzfkoZu/9nP2Jrv6NKyFO2+NrIqhMM1
 frs+kk8DZlGYE29vEexztn25WixTatYFk9dYixsHbrZmT+lBBoPKn5kWpp97jmkY1Vml
 5vd4hTXg3P/uQHLfC1UrMYEVi6RQocMvBCfQbsRviKdw2e72KXHvyslE2mOrQpLlcSsJ
 LvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749051446; x=1749656246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ToxRC3vNEZk3I2I/zcyiwQhQdoU3V7SXGWdY7hnYeQQ=;
 b=TlqmijsLiJhkf4gMPjUcixqtduvE2PfBDQzUAnuWTNnv6UeR+WQhWtlwHZtBvQ5iOU
 I7RxlksTFF/tScaMUKTv+e01yTDEg3EJ1ygA0DBWho+sYz5aPe5Y3NKK3OxgsCaggymj
 UybU+xq9QwiguV0sH1/KHPODbrdbAonZIcfnk+h2usdswcftaNk2YjBdAOsfp1q/kTcH
 sRX8y0tEqSafQG6nx0U9oRvrghFTbRyl1m+w3VED/Yd/YRkizQ2qKofcUMdsZT+OGkjh
 M1eFjWy1p+qaa/MG5KSImSa/ex9dKsTBfTTBQLyrNgkzTDAeZ3STB9FITO0rIk8Hxz57
 hsyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtVD7VXSrvOVFS602jRDeWFCVVQ9YY9MWKvHv0OAZnWqV8eabYUWCEtk+ZMbkjHXPFmkWGOnE=@lists.denx.de
X-Gm-Message-State: AOJu0YymfE8LcZeWMk15lvRLF9pbdSgD1lrmDM+H0ZRxybB/l1ljvioF
 xZlgUYmEISLlshZockdeNkMfU2iYmXW86UglpDYX+uykbnMbYJk6yNDhdAObspzycO+YU7yu6Pv
 JV+uksIBL44nNRNrFuk2LVgloZWbQgRaSXsxxHpipTw==
X-Gm-Gg: ASbGncuNj7PwkekQQfp4qXNxPqtduQOi4KVXLRqn1kGdvHEs8ou2xkd0ykiWz3LzA1/
 sBsfBzFYrKYdZUXUjiLHA91IsnWGaBkzF1c0KMjVU2q/dZgXDuzXnxne5NSlThDpUCmieiw0eG9
 AOJrpOm176X+H/ML3PG1d1CRgdA0PNhzAYW13uaYFL47qm
X-Google-Smtp-Source: AGHT+IEDsVIbrSkt7vb2sImRJv/ZbwjdZx7yjXkLPvFZSW4XK+4Z5aS2CYT6KE7/M+FST+9a9lsO7KqroaOcEGCYG5g=
X-Received: by 2002:a17:903:230b:b0:233:f3df:513d with SMTP id
 d9443c01a7336-235e1504f1amr51578935ad.35.1749051446113; Wed, 04 Jun 2025
 08:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250603151401.1709532-1-raymond.mao@linaro.org>
 <20250603154748.GG1382132@bill-the-cat>
 <CAEfUkU+7BaEcmQ1NL2TSMLpHYQt1DhPLKZPtkB_Fd6u_Oq4qEA@mail.gmail.com>
 <20250603192345.GL1382132@bill-the-cat>
 <CAEfUkULmB2PckAKf+euT8Mj3ehirw-TjmNT20-+AfVy6SpRB=Q@mail.gmail.com>
 <DADNW2131HYB.V2UGC24FOJJO@ti.com> <20250604135612.GN1382132@bill-the-cat>
In-Reply-To: <20250604135612.GN1382132@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 4 Jun 2025 11:37:13 -0400
X-Gm-Features: AX0GCFuu0LqRKB29JfvltvrPsBfKZ97g2EAOMixP-a5vmSAjfiqzGp1tGL4YtQQ
Message-ID: <CAEfUkU+XmX-3A0Q2obkyBW9m6pfD7JuOJGq1D7vHTvha-RHuGw@mail.gmail.com>
Subject: Re: [PATCH] sandbox: solve undefined reference to pthread_kill symbol
To: Tom Rini <trini@konsulko.com>
Cc: Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>, 
 Prasad Kummari <prasad.kummari@amd.com>
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

On Wed, 4 Jun 2025 at 09:56, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jun 04, 2025 at 03:33:31PM +0530, Anshul Dalal wrote:
> > Hi Raymond,
> >
> > On Wed Jun 4, 2025 at 2:30 AM IST, Raymond Mao wrote:
> > > Hi Tom,
> > >
> > > On Tue, 3 Jun 2025 at 15:23, Tom Rini <trini@konsulko.com> wrote:
> > >>
> > >> On Tue, Jun 03, 2025 at 02:00:23PM -0400, Raymond Mao wrote:
> > >> > Hi Tom,
> > >> >
> > >> > On Tue, 3 Jun 2025 at 11:47, Tom Rini <trini@konsulko.com> wrote:
> > >> > >
> > >> > > On Tue, Jun 03, 2025 at 08:13:58AM -0700, Raymond Mao wrote:
> > >> > >
> > >> > > > This patch is to solve the sandbox building error:
> > >> > > > $ make O=build-sandbox -s sandbox_defconfig
> > >> > > > $ make O=build-sandbox -s -j2
> > >> > > > /usr/bin/ld: /tmp/u-boot.27rzOu.ltrans58.ltrans.o: undefined reference to symbol 'pthread_kill@@GLIBC_2.2.5'
> > >> > > > /usr/bin/ld: /lib/x86_64-linux-gnu/libpthread.so.0: error adding symbols: DSO missing from command line
> > >> > > > collect2: error: ld returned 1 exit status
> > >> > > > [...]
> > >> > > >
> > >> > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > >> > > > ---
> > >> > > >  arch/sandbox/config.mk | 2 +-
> > >> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >> > >
> > >> > > OK, but how do you get this failure to start with? What host?
> > >> > It failed when I started any sandbox unit test like:
> > >> > ./test/py/test.py --bd sandbox --build -k <any_test>
> > >> > My local host: Ubuntu v20.04, x86_64
> > >>
> > >> We don't see that normally, is there something odd about your compilers?
> > >> This is the kind of thing which should be failing everywhere, but isn't.
> > >> Thanks.
> > >>
> > > This failure occured in my host since v2025.07-rc1, but with the same
> > > host, same setup and same instructions it worked fine in v2025.04-rc5.
> > > Seems that some impacts were introduced during v2025.04-rc5 ~
> > > v2025.07-rc1, which might be worth investigating.
> > >
> >
> > I am unable to reproduce the issue on gcc 15.1.1 and glibc 2.41. I think
> > the issue is likely on your host end.  What compiler and libc are you
> > using for the build?
>
> This feels like if it's generic, CI should be blowing up too, even if
> it's Ubuntu 22.04 not 20.04 these days. Please bisect down to the
> failure, since you have known good/bad commits and 'git bisect run' can
> use the test case you have.
>

By running 'git bisect run' I got this:
b989f9ed9fe13be2cb168d2d45c235f011104f38 is the first bad commit

Regards,
Raymond


> --
> Tom
