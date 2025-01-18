Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C3EC02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 05:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DB9480756;
	Sat, 18 Jan 2025 06:59:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j6WTasC+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA89C8070C; Sat, 18 Jan 2025 06:50:12 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A74980077
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 06:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3e9a88793so4682927a12.1
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 21:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737179410; x=1737784210; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aff9km3zIkIMhb4MW4tO/IOx1TMp5fPG1CdwAISjCOo=;
 b=j6WTasC+iofuJu8jg5PUQ7N/0SBQvssVUFVUKwtCvli1MVwp0dSyUlsQrgk1n97w7o
 t0pVGtZoyTqlypDFk7j16qk3eJATYyNSBHxYV4wtlaJPZ5842DFzUm8WIqj60+eKk/34
 PPa2rrZCHERLOzEGJq/aBt9GlEwUNwAJHZM/waJl8+HqtFh3EjDRum1BRGwjdftZ6Ma1
 O5B9LagvecY1TBxsPbz7R7vC0ofLGN5w0/Fkt3IU8Uk1fls1gblDVAVlONde64xgHbl6
 FRp/HB14LUa991IdGTmLve4UcYfe9nEedYheAi9MFZ2RSMXILH2klu09yqKZvpTTh611
 OrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737179410; x=1737784210;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aff9km3zIkIMhb4MW4tO/IOx1TMp5fPG1CdwAISjCOo=;
 b=qjSckEIU3SPfvuq6KqFAsk2ooDfPhOTDyLlaE1jej4ZHSErgmcPVO3HB3azAIFaSP0
 kZfwiKbxkvkdYGt6ZA79bEIHRbN8kaMQfc+8gP5o8820N+DGsxPBht0OiT9yhAnnTrCs
 B3EcOJZDrSDJ67xeCC7RYJJVXfXzGHI22w8hor5Qw2Enl3Hq2lnbFkMAKmWPz30AesiZ
 SXbRrKidFltOb/fhi2e6oXweAl7mCSVDnI60AdJJdNVHtrDU3tPIQ8Gj1u2+BmRqPZsN
 0Pkhfub89E/fjKmtBdvV0ssO2rwRZsOZoyq+k6abKQnagvnF6Q3mKjKHfl/VzoA2O+FZ
 a9zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn4yk5voPQJw5x4OIiFJFCROf5F/bWxYZJTwcC+HSbRrPqIgPmHV+OIQ8ihO0fRNLJuiB6p4Q=@lists.denx.de
X-Gm-Message-State: AOJu0YxCNmn9RPU37XmocbnFCU8o8l1/g6jDCw+2ShhvQH2xdcUz9eVU
 h+3pI1VGw4i+sXrsYwbdcJni8u30ZaGsFZWPq7f/0wDPKXuW6XEtksgXdNZwuhrsplfpyWJSL4n
 R5PR5rz5gqCisfaeRmgoUQc3IT74=
X-Gm-Gg: ASbGncuDmaR4WHNn0zf7Los2xajznZrJLIWmIsRe7qgn25hp1oDkMIzo7odNXfBeexu
 sbcWiF+ZpCYsdAq2Qq1gh3hNiyydJ4IlA3y13WWfX9UXSZTjuTT1b
X-Google-Smtp-Source: AGHT+IFzVb8gWTPfpa4cmauPDw/Lb7ACbZPk5W13P6V/LUAOqWwXxmX4Jv9P/AZt9zZjH6e/xwazI8xm9YLJi91bpGM=
X-Received: by 2002:a05:6402:34d5:b0:5d0:e50b:899e with SMTP id
 4fb4d7f45d1cf-5db7d2ec628mr4310856a12.4.1737179408233; Fri, 17 Jan 2025
 21:50:08 -0800 (PST)
MIME-Version: 1.0
References: <20241104175110.1048449-1-sjg@chromium.org>
 <CAFLszTgFdNrRev+7n6j+NqCM+em_p-ONAc=+sztoYaP50HUivw@mail.gmail.com>
 <20250115212439.GD3476@bill-the-cat>
 <CAFLszTiSSq-+cSxVgxLJ8atAAjjxRP2AEQmXMbrf+c3FOepnFQ@mail.gmail.com>
 <20250115233157.GE3476@bill-the-cat>
 <CAFLszTga3RD95M2ujLfuXQor39sfcQrEUe3hwRKABiWx04PiZg@mail.gmail.com>
 <20250116172159.GH3476@bill-the-cat>
 <CAFLszTigN+s1T0hjJXnkE4ucYafHCtabPFHh=gCFpro2WrLnpg@mail.gmail.com>
In-Reply-To: <CAFLszTigN+s1T0hjJXnkE4ucYafHCtabPFHh=gCFpro2WrLnpg@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 17 Jan 2025 21:49:43 -0800
X-Gm-Features: AbW1kvbvpySfQbtsRDolurGcbvKg5osavNmLf8vNThi1ENdva3Yb6vbH8IEeKus
Message-ID: <CAJaLiFw3j1FTT25mNd_5Pk-UTCaNL=R2GmK0+m_VoCc7Yc2PRQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] bootstd: Support recording images
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
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
X-Mailman-Approved-At: Sat, 18 Jan 2025 06:59:38 +0100
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

On Fri, Jan 17, 2025 at 8:32=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Tom,
>
> On Thu, 16 Jan 2025 at 10:22, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jan 16, 2025 at 08:52:38AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 15 Jan 2025 at 16:32, Tom Rini <trini@konsulko.com> wrote:
> > [snip]
> > > > I'm referring to the whole bootmeth/bootflow/etc thing. Is this goi=
ng to
> > > > be put to use by anyone / anywhere on PowerPC? M68K? MIPS? 32bit AR=
M is
> > > > a harder question there, which is also where this particular overfl=
ow
> > > > was.
> > >
> > > I'm still not sure what you are saying. Are you wanting to disable
> > > bootstd by default / go back to distro scripts / force everyone to us=
e
> > > EFI_LOADER / ?
> >
> > Yes, I'm asking where it's appropriate to enable this new functionality
> > by default.  It certainly should be enabled on arm64 (there's new
> > designs) and riscv (there's new designs). It still ought to be enabled
> > on arm32 because we otherwise lack a easy way to say "new" arm32 (say
> > i.MX7) and not "old" arm32 (say i.MX23). What is the point of enabling
> > this on PowerPC for example? The active users there are (generally)
> > supporting legacy hardware and I have no idea how much they want to
> > change their boot process, once bootstd supports flash for example.
> > There's similar questions for everything else under arch/ as well.
>
> To me this is in fact two different questions.
>
> 1. For PowerPC, m68k, MIPS, I suppose we can just disable BOOTSTD and wai=
t for them to go away, if you are saying that they are behind on migrations=
 will never catch up
>
> 2. As to the default, I believe BOOTSTD should be on by default, if we in=
tend to remove the distro scripts and support things that are not EFI

I'd agree with Simon on 2. Boards that have never been upgraded to
distro boot or standard boot usually have an internal envs script in
include/configs/xxx.h that boots the board the legacy way. Even if
bootstd is enabled by default, it won't hurt those.

All the best ,
Tony

>
> Regards,
> Simon
