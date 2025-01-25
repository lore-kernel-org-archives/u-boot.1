Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673C2C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 20:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC2D580EB5;
	Sat, 25 Jan 2025 21:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KIV3m8MU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0157880836; Sat, 25 Jan 2025 18:14:09 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FB8080EF6
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 18:14:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d3d143376dso4336994a12.3
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 09:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737825246; x=1738430046; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s1JM5IpZWgXe5YY6t1kIpU8CamxwVlQ3avQIm2xkPuA=;
 b=KIV3m8MUWqaX7VRltUNUw0iLboHL2nBvXoEbXw24DxTpxGgTaY33S/Dv+0rm5RCfSi
 cStWvK5WivotQOp6QMJhHkuT3PwqHMW+SYX0RNKmT+3iImZfh+wKlt1wviN/Q76pNRTG
 H3cRWRRlTYiS0EKRinHUJm9juXgRljNN1tDaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737825246; x=1738430046;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s1JM5IpZWgXe5YY6t1kIpU8CamxwVlQ3avQIm2xkPuA=;
 b=XXDVhdvPV7bwZsrj6oLWzhuWHsQwzDg1xG146OwUihVtdgmEBdWRgBohx2FffuK+uj
 XrP3UamMmRMGaUv7NioyJUwXty3fCRhTunOuxdvGhqYPUadsrc6s7hvxoUepsawWjeEF
 Bk9TDf70Ququ7fj24BWFMt37fqCiIza6PaH2lk3UkEwZTURvjk1WBoTqlDEFPWLehRDW
 wdOaMsiyF3U97kagLlY9+J1pMawe+GPoly7wK88dQ/dOoy+y576CLCNNrQ9nSokeJUaI
 Th8fxewdsXzACZ3sf4S6p1FGKlmNoI2v/ufoaD6oh0hhAoeq+hofF5cQNMTslYExS4nd
 oMPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9m4sOG7lOuHVf9f6RN+Y+O5OrfA/BSRYA0yMpPU2xHEBEBGUUlBoMt2z0oIvyRi1GcOcM4ec=@lists.denx.de
X-Gm-Message-State: AOJu0Ywizaid7+bkTk6gPh3Vi30q5rY90KA84JH+naXwfTsEwrbR7toB
 1DAjgP84AsgFADV3YW7SCCDmYIVUAQDhdfPMfI8L6SRcNCdRZqNw8HHpLHs5O3VLNhlIleV0dvx
 /O9xwO+Y60Vbo3Fou377nIfzMwdJWSJBTu1hZ
X-Gm-Gg: ASbGncvuPpuzyCmz/40N5RLkwN9zbIovkScaYkFN4xjodTifYHb1xjRdoQnr4e3kF57
 27olJE/VRyDu+M3/i195RLL9tY4EIfOmuRkQqAQglXa5BP9/AF+KwDrB4FLQLFUI=
X-Google-Smtp-Source: AGHT+IG686UB9HxblZhTvwqb8YZhAOfobpFxX2br+PsGu/7gl1CPVeE6ktVaAUOTC9uQZrqaSCAQF4MI/t+faIGek9Q=
X-Received: by 2002:a05:6402:3508:b0:5dc:1ec6:12bc with SMTP id
 4fb4d7f45d1cf-5dc1ec613b2mr4465253a12.28.1737825245734; Sat, 25 Jan 2025
 09:14:05 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTgFdNrRev+7n6j+NqCM+em_p-ONAc=+sztoYaP50HUivw@mail.gmail.com>
 <20250115212439.GD3476@bill-the-cat>
 <CAFLszTiSSq-+cSxVgxLJ8atAAjjxRP2AEQmXMbrf+c3FOepnFQ@mail.gmail.com>
 <20250115233157.GE3476@bill-the-cat>
 <CAFLszTga3RD95M2ujLfuXQor39sfcQrEUe3hwRKABiWx04PiZg@mail.gmail.com>
 <20250116172159.GH3476@bill-the-cat>
 <CAFLszTigN+s1T0hjJXnkE4ucYafHCtabPFHh=gCFpro2WrLnpg@mail.gmail.com>
 <CAJaLiFw3j1FTT25mNd_5Pk-UTCaNL=R2GmK0+m_VoCc7Yc2PRQ@mail.gmail.com>
 <20250118144132.GW3476@bill-the-cat>
 <CAFLszTi_5s9L9zYz-EZpdM9YVdV7TdhrnxPm9K8VeZEa0tHpag@mail.gmail.com>
 <20250123171708.GN60249@bill-the-cat>
In-Reply-To: <20250123171708.GN60249@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 25 Jan 2025 10:13:54 -0700
X-Gm-Features: AWEUYZlf2q7KOY6__u3Rsa7aUC3FSyfrGC7nf_Ef5Dtt-FpRNXK7VutyA-jZ-So
Message-ID: <CAFLszTjNLDbhOiE-_f7igzMkz3db_0YtwGN4t04tf9SsAbCeMQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] bootstd: Support recording images
To: Tom Rini <trini@konsulko.com>
Cc: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
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
X-Mailman-Approved-At: Sat, 25 Jan 2025 21:04:21 +0100
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

On Thu, 23 Jan 2025 at 10:17, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jan 23, 2025 at 07:38:04AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 18 Jan 2025 at 07:41, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Jan 17, 2025 at 09:49:43PM -0800, Tony Dinh wrote:
> > > > On Fri, Jan 17, 2025 at 8:32=E2=80=AFPM Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > >
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 16 Jan 2025 at 10:22, Tom Rini <trini@konsulko.com> wrote=
:
> > > > > >
> > > > > > On Thu, Jan 16, 2025 at 08:52:38AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Wed, 15 Jan 2025 at 16:32, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > [snip]
> > > > > > > > I'm referring to the whole bootmeth/bootflow/etc thing. Is =
this going to
> > > > > > > > be put to use by anyone / anywhere on PowerPC? M68K? MIPS? =
32bit ARM is
> > > > > > > > a harder question there, which is also where this particula=
r overflow
> > > > > > > > was.
> > > > > > >
> > > > > > > I'm still not sure what you are saying. Are you wanting to di=
sable
> > > > > > > bootstd by default / go back to distro scripts / force everyo=
ne to use
> > > > > > > EFI_LOADER / ?
> > > > > >
> > > > > > Yes, I'm asking where it's appropriate to enable this new funct=
ionality
> > > > > > by default.  It certainly should be enabled on arm64 (there's n=
ew
> > > > > > designs) and riscv (there's new designs). It still ought to be =
enabled
> > > > > > on arm32 because we otherwise lack a easy way to say "new" arm3=
2 (say
> > > > > > i.MX7) and not "old" arm32 (say i.MX23). What is the point of e=
nabling
> > > > > > this on PowerPC for example? The active users there are (genera=
lly)
> > > > > > supporting legacy hardware and I have no idea how much they wan=
t to
> > > > > > change their boot process, once bootstd supports flash for exam=
ple.
> > > > > > There's similar questions for everything else under arch/ as we=
ll.
> > > > >
> > > > > To me this is in fact two different questions.
> > > > >
> > > > > 1. For PowerPC, m68k, MIPS, I suppose we can just disable BOOTSTD=
 and wait for them to go away, if you are saying that they are behind on mi=
grations will never catch up
> > >
> > > On what migrations? A board that has a boot command is not some legac=
y
> > > non-migrated case. That's a valid regular use case.
> >
> > I'm referring to a board that uses distro scripts.
>
> OK. Just FYI, "distro scripts" weren't a thing outside of ARM (and maybe
> RISC-V, and just turris_1x_sdcard on PPC?).

OK. If those boards don't boot distros then I suppose it doesn't
matter what they do. It would still be nice to get rid of/reduce the
scripts, but we shouldn't require it.

So where are we with bootstd migration?

Regards,
Simon
