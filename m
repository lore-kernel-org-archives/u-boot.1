Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C035AC02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 21:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D31AB80141;
	Sat, 18 Jan 2025 22:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QKIqU7N9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EC4E8063E; Sat, 18 Jan 2025 20:26:32 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0F9C80141
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 20:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d3d14336f0so5756885a12.3
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 11:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737228389; x=1737833189; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s0reUeDbHIIghz3WpCRwx+Jptkk1Eo38GeLoLOSDyEw=;
 b=QKIqU7N9f2PojrBGn/Gv2XjcP4/1tL1uKgQaKs0Re518fyVmbnmHRht+qutQPrNqrd
 Ylie1L29mX2Ki8RWkAGoIpTGCojaSJQEiqVRjEWstbqPYVEkSiAmRf2+85QAzKK4yyDR
 IOLBoZ3NTPXLePXvwfRTzjYlAKKRcNtaWI6iXoRe81cDDcmI0LZrUGwvi5BVmr0wYWxL
 twOcovG1/EL37Qd3VCTS8OuCZdslPw8CveG3r1T+Wh6eiORSgInAtFqNBQw/vfR4J84J
 k/2tx4gVaapscGSnes0w26k90tAX8Wn0eRHGX9IBHA2LiipiZUgqxVAuRWpWKaYqmsPr
 8Q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737228389; x=1737833189;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s0reUeDbHIIghz3WpCRwx+Jptkk1Eo38GeLoLOSDyEw=;
 b=V2LOrv//bRXc5QKaHGjP/ZHafOk4u2g+/z86ac+zlU7g271cavwfuCy6sObN7C9nQp
 oauWPPS5B92Nug80VymKpGxQRTWGtJKOFuzdGDg15ACgkGqKZSOsSxtPV1SpS1ZZqBCj
 5/yy9PRPmHPbu6I2plNBWHS6JCX5NsSTnf0dKSmYjfEA48tXCPpDWgVqpKhjO82Atk59
 ijAfLX679hBBCKGh39n1NphUdz+C9w3JfqLMcjm8/ZLRjpwZSCGCtAZsfna3qLxHI0nj
 c74+8biOTZvYJMxJWjyUwtxbVHE/hAhT8VS1wBxBTY5uFQcuM65lt6jrqhVmZjSJ4ueH
 jXZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5dZdRZyHkHOS6Vbz31Uglv5iuu07AaoO0Mq8o3l71Adk4MHpYpyVwf8DKwG0yrFzKXbLM0gE=@lists.denx.de
X-Gm-Message-State: AOJu0Yxto5uUcL4Ps0jNdnbvZd4uJUp/VXwQhVyAbFaKljDfVVpHI/Lw
 e9cPMsdrI1rXVhJkMpB96grAmkADZ+lVsITWwn2hXPEBy1lAcCLKIZe+fCpEGjRjeK8A5Y2K/2e
 UFK/Ul6c+7ReI84HVxK41ffTyObk=
X-Gm-Gg: ASbGnctOhlCThSuGdG4j33brbY1WdnkVuPnpkcNiQo13/qXQU7PmU2G3iVIIeFfVMkr
 MPXI8EGsLWebf/kjV+aD35+6uAmCqJg8EmE7nonaLHldxKDDVEf5o
X-Google-Smtp-Source: AGHT+IHOu8ihHkAFlUUMuRvGHU++sgL58np7j1uOAxcc9mL44RY9wtTmhnvRdfuXjI/K6AdRgY1vQswvYoCXc38W5sA=
X-Received: by 2002:a05:6402:278f:b0:5d9:b50e:7008 with SMTP id
 4fb4d7f45d1cf-5db7d2f8c49mr6147002a12.8.1737228388917; Sat, 18 Jan 2025
 11:26:28 -0800 (PST)
MIME-Version: 1.0
References: <20241104175110.1048449-1-sjg@chromium.org>
 <CAFLszTgFdNrRev+7n6j+NqCM+em_p-ONAc=+sztoYaP50HUivw@mail.gmail.com>
 <20250115212439.GD3476@bill-the-cat>
 <CAFLszTiSSq-+cSxVgxLJ8atAAjjxRP2AEQmXMbrf+c3FOepnFQ@mail.gmail.com>
 <20250115233157.GE3476@bill-the-cat>
 <CAFLszTga3RD95M2ujLfuXQor39sfcQrEUe3hwRKABiWx04PiZg@mail.gmail.com>
 <20250116172159.GH3476@bill-the-cat>
 <CAFLszTigN+s1T0hjJXnkE4ucYafHCtabPFHh=gCFpro2WrLnpg@mail.gmail.com>
 <CAJaLiFw3j1FTT25mNd_5Pk-UTCaNL=R2GmK0+m_VoCc7Yc2PRQ@mail.gmail.com>
 <20250118144132.GW3476@bill-the-cat>
In-Reply-To: <20250118144132.GW3476@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Sat, 18 Jan 2025 11:26:17 -0800
X-Gm-Features: AbW1kvbuxbjmNQxzT8XkGHZcFVbuEK7X1OlBphXt7ykaBemWAoq753t6qizJHkg
Message-ID: <CAJaLiFzSHwzSU=74o6OV4FakCMi4xeg=fU=v4G17FAY_QCUTsQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] bootstd: Support recording images
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Emil Kronborg <emil.kronborg@protonmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Ion Agorria <ion@agorria.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, 
 Moritz Fischer <moritzf@google.com>, Nam Cao <namcao@linutronix.de>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sean Anderson <seanga2@gmail.com>, Sean Edmond <seanedmond@microsoft.com>, 
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Tim Harvey <tharvey@gateworks.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 18 Jan 2025 22:04:37 +0100
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

On Sat, Jan 18, 2025 at 6:41=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Fri, Jan 17, 2025 at 09:49:43PM -0800, Tony Dinh wrote:
> > On Fri, Jan 17, 2025 at 8:32=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Tom,
> > >
> > > On Thu, 16 Jan 2025 at 10:22, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Jan 16, 2025 at 08:52:38AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 15 Jan 2025 at 16:32, Tom Rini <trini@konsulko.com> wrote=
:
> > > > [snip]
> > > > > > I'm referring to the whole bootmeth/bootflow/etc thing. Is this=
 going to
> > > > > > be put to use by anyone / anywhere on PowerPC? M68K? MIPS? 32bi=
t ARM is
> > > > > > a harder question there, which is also where this particular ov=
erflow
> > > > > > was.
> > > > >
> > > > > I'm still not sure what you are saying. Are you wanting to disabl=
e
> > > > > bootstd by default / go back to distro scripts / force everyone t=
o use
> > > > > EFI_LOADER / ?
> > > >
> > > > Yes, I'm asking where it's appropriate to enable this new functiona=
lity
> > > > by default.  It certainly should be enabled on arm64 (there's new
> > > > designs) and riscv (there's new designs). It still ought to be enab=
led
> > > > on arm32 because we otherwise lack a easy way to say "new" arm32 (s=
ay
> > > > i.MX7) and not "old" arm32 (say i.MX23). What is the point of enabl=
ing
> > > > this on PowerPC for example? The active users there are (generally)
> > > > supporting legacy hardware and I have no idea how much they want to
> > > > change their boot process, once bootstd supports flash for example.
> > > > There's similar questions for everything else under arch/ as well.
> > >
> > > To me this is in fact two different questions.
> > >
> > > 1. For PowerPC, m68k, MIPS, I suppose we can just disable BOOTSTD and=
 wait for them to go away, if you are saying that they are behind on migrat=
ions will never catch up
>
> On what migrations? A board that has a boot command is not some legacy
> non-migrated case. That's a valid regular use case.
>
> But yes, I'm suggesting we should put some default y if ... logic around
> BOOTSTD.
>
> > > 2. As to the default, I believe BOOTSTD should be on by default, if w=
e intend to remove the distro scripts and support things that are not EFI
>
>
> In case you missed it, EFI_LOADER is default for some ARM32, ARM64, X86,
> RISC-V and sandbox. None of those are cases where I'm suggesting BOOTSTD
> shouldn't be default.
>
> > I'd agree with Simon on 2. Boards that have never been upgraded to
> > distro boot or standard boot usually have an internal envs script in
> > include/configs/xxx.h that boots the board the legacy way. Even if
> > bootstd is enabled by default, it won't hurt those.
>
> It hurts them because of the strong likelyhood that they do have
> practical image size limitations (before they would then be leaking in
> to U-Boot environment or some other part of flash).

Yes, indeed. The image size growth would be a problem.

Thanks,
Tony

>
> --
> Tom
