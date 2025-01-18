Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47F7C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 05:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01A3A8063E;
	Sat, 18 Jan 2025 06:59:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UMiN8QtQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D37D580657; Sat, 18 Jan 2025 05:32:45 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B78818036F
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 05:32:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aaeecbb7309so520072666b.0
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 20:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737174763; x=1737779563; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pYBhe4Asx1j4ql64T/IqHjJC2hyU+ACjkqCnMiiCIOg=;
 b=UMiN8QtQe3YnznZV+zoUoy3BbJX/C1YLNWSyRMofV9QNmFwmC+/gGyIpOAypaj0DMf
 JIUWBHnxy39nGYhmtf5onIyS7+eGWS3rpKkXyXlGRiugl2DK1oFyFbKxUmXIE1KjL4w5
 TCQpwnCu8A2CoMaIne4PtVt7Nu1wGMGxiyJhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737174763; x=1737779563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pYBhe4Asx1j4ql64T/IqHjJC2hyU+ACjkqCnMiiCIOg=;
 b=tCM6uMZdsDIjzLL1xxBF8mPZjS8PvefEsmHAB7oHAjWkY3ymFUMIJPgEfu/be7UgST
 /bRCfFlA8KxR8p0GTZS+KMxQX6JedKkc+7BxbVHKpYpQwBIwbKy0TrP3+sniPCJVPBMr
 /xeWnk8NBhzfqRZR55clsdmXu7pj3v2zfEb8o0abuxxDYQcx8rEZ3uon3mR7fDChy0J9
 rXmUBVG4clhz0VtuPbT49RsZ9ovPK3/sPr3heUX/tfFL/g/8ORxPtZS4577fOqGs0vmX
 XAM07H1QKlcGyVoEytF/eJ7axEneJlD/r/67AY2Bx+fpmqY5EH24FRTVkf5LyydlcVqX
 nxXQ==
X-Gm-Message-State: AOJu0Ywk1NB6OunqvYyyhgYbeN8eIKRkVa/1MVMkG9ywm6O69sXNGeri
 kFpi6aD1eINdwp0MiJG8eSx1Dci7qHzA3ejeaUc9ANU2Ao6LoJPVXdQ83c/BUmlz7fsYbnv3ogr
 zmA8iBdHEqABsNNCtDwPbd5M+9LaEK163T6D3
X-Gm-Gg: ASbGncuOFPYjq8YC5h7udICIKiPiJR6UPNKUwmH2uuuQgTMHAAv1pKO8qzQ5W446gFW
 Dqqi15ZolISBerPb9tMxwC/vJhCF/3Wj8AocqZFMxzBsGmfZhLAC13VVNNVu11q/BnjNe0yn3hS
 kFB7ujsW53
X-Google-Smtp-Source: AGHT+IGV530ikGs/T+QXXdaPugnj0iqSd8pwYwXAqz468FO0ZOeaVY+ygQv4stLWtWqIi/b3kRpdoMDN9N+jIFpAaLU=
X-Received: by 2002:a17:907:7205:b0:ab3:88a0:b71d with SMTP id
 a640c23a62f3a-ab38b2e734fmr559214566b.34.1737174763218; Fri, 17 Jan 2025
 20:32:43 -0800 (PST)
MIME-Version: 1.0
References: <20241104175110.1048449-1-sjg@chromium.org>
 <CAFLszTgFdNrRev+7n6j+NqCM+em_p-ONAc=+sztoYaP50HUivw@mail.gmail.com>
 <20250115212439.GD3476@bill-the-cat>
 <CAFLszTiSSq-+cSxVgxLJ8atAAjjxRP2AEQmXMbrf+c3FOepnFQ@mail.gmail.com>
 <20250115233157.GE3476@bill-the-cat>
 <CAFLszTga3RD95M2ujLfuXQor39sfcQrEUe3hwRKABiWx04PiZg@mail.gmail.com>
 <20250116172159.GH3476@bill-the-cat>
In-Reply-To: <20250116172159.GH3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jan 2025 20:32:31 -0800
X-Gm-Features: AbW1kvZOLmk-O_kMoaWbKQvaJDJlGIXZZPzCzj6oC7xsCV9Jg8CqmqlzdFIbIbY
Message-ID: <CAFLszTigN+s1T0hjJXnkE4ucYafHCtabPFHh=gCFpro2WrLnpg@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] bootstd: Support recording images
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Dragan Simic <dsimic@manjaro.org>, 
 Emil Kronborg <emil.kronborg@protonmail.com>, 
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
 Tim Harvey <tharvey@gateworks.com>, Tony Dinh <mibodhi@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailman-Approved-At: Sat, 18 Jan 2025 06:59:38 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, 16 Jan 2025 at 10:22, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jan 16, 2025 at 08:52:38AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 15 Jan 2025 at 16:32, Tom Rini <trini@konsulko.com> wrote:
> [snip]
> > > I'm referring to the whole bootmeth/bootflow/etc thing. Is this going
to
> > > be put to use by anyone / anywhere on PowerPC? M68K? MIPS? 32bit ARM
is
> > > a harder question there, which is also where this particular overflow
> > > was.
> >
> > I'm still not sure what you are saying. Are you wanting to disable
> > bootstd by default / go back to distro scripts / force everyone to use
> > EFI_LOADER / ?
>
> Yes, I'm asking where it's appropriate to enable this new functionality
> by default.  It certainly should be enabled on arm64 (there's new
> designs) and riscv (there's new designs). It still ought to be enabled
> on arm32 because we otherwise lack a easy way to say "new" arm32 (say
> i.MX7) and not "old" arm32 (say i.MX23). What is the point of enabling
> this on PowerPC for example? The active users there are (generally)
> supporting legacy hardware and I have no idea how much they want to
> change their boot process, once bootstd supports flash for example.
> There's similar questions for everything else under arch/ as well.

To me this is in fact two different questions.

1. For PowerPC, m68k, MIPS, I suppose we can just disable BOOTSTD and wait
for them to go away, if you are saying that they are behind on migrations
will never catch up

2. As to the default, I believe BOOTSTD should be on by default, if we
intend to remove the distro scripts and support things that are not EFI

Regards,
Simon
