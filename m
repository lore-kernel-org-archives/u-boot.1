Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C5FC02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 15:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0557980711;
	Thu, 23 Jan 2025 16:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="REX0A1Bp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB96806DC; Thu, 23 Jan 2025 15:38:23 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C341380137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:38:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5dbfab8a2b0so1914894a12.3
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 06:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737643101; x=1738247901; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/PLHW92M0rGjweYxTe6OD09YC0/dDc6ATydc7iK2EPI=;
 b=REX0A1BpKTME6BqpJFQqD1iDFJKMMP5iN0uDt1hB/BtsNQbliF1TCw38dlJWlWmWyO
 vdVTLYyuhzOjBepcQelUHDTtet7xvXDPl8TOU9+GY9K9DoN6TwEDZ4oJQjSB+SWwTnIk
 gtvgLmnhOriYNOmIQmo/poVYjCKRA5K4FyQEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737643101; x=1738247901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/PLHW92M0rGjweYxTe6OD09YC0/dDc6ATydc7iK2EPI=;
 b=mef8n248P/7H7SHXGqDsJ894Kzhnq6u3LQZp34oHfCiexgKiJQE/n6LLOrscC4inu1
 SrDqGmHVmNFlaq9BZWQiyy7FECkqMIxI76C58GOJt/wMPrB56gX5Etw5o86+WKi5MfTu
 Y4lmEqQMZrkjuItg648adeh82jgHGTHllR9l25cUeX8cx8HaIS8fweS5qyZFt2V6xVhX
 fP/z/aiNEzgexd2fxYaT19AUdVScA8mAOgsMQ6SVN0fPuxzChXfzP+zCleGBStDJwFS4
 DaUU3VRdkdSKNCHhfrlCuEcSoOULLKl2crgWU95iBn25x1JqBL9GqWTVwwB4EiyHNuEY
 EZ0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4jBItOtyA5c872REVYuHUx67joLO/dGQjSw3EGx1ohTyIGjTbx6JfMVsGFm/UcVouNhusTxA=@lists.denx.de
X-Gm-Message-State: AOJu0YyxLVcMA2qS+3nUA8FYFQzbqrxee7OId9zqeqs1vx4STr0ru3qH
 UDPfFxfK9vSe8b69ew6CFIfpqSDBRdbQCt6YxHB+JmEijzm6AX0BVLaVfrTi4gYyrgCoBulSqr/
 AYJPVJh0uDFlW7ae3iS3J9f06AO/SeTxNBPxO
X-Gm-Gg: ASbGncsZ1Vbz2Kx2Ng/79FLJOy+4RgakjbOfdVEuAMQ6nP55tZbBipBS+TiAAn++Ibn
 +tbMhE68KYv55OcoiKTtPPi9qt+SozY4cWn3E5qZk6g45x/ftxLlTl9f6OhVKIB4=
X-Google-Smtp-Source: AGHT+IGN2GXIQEXcRPBPA40L70Rp+zUf9xAk88HrLUkeqk9Pwf2sewSDnCK75UDFQsY+XoUp0tZ40L0W+KUppegoUX4=
X-Received: by 2002:a17:907:969f:b0:aae:c159:9e10 with SMTP id
 a640c23a62f3a-ab38b43bc13mr2522297966b.42.1737643101172; Thu, 23 Jan 2025
 06:38:21 -0800 (PST)
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
From: Simon Glass <sjg@chromium.org>
Date: Thu, 23 Jan 2025 07:38:04 -0700
X-Gm-Features: AbW1kvZyW10iLfzivojW8cG81YAZI06FNqSdAGsChRuwKEkkHyk7Ev1qs507HgM
Message-ID: <CAFLszTi_5s9L9zYz-EZpdM9YVdV7TdhrnxPm9K8VeZEa0tHpag@mail.gmail.com>
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
X-Mailman-Approved-At: Thu, 23 Jan 2025 16:31:28 +0100
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

On Sat, 18 Jan 2025 at 07:41, Tom Rini <trini@konsulko.com> wrote:
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

I'm referring to a board that uses distro scripts.

>
> But yes, I'm suggesting we should put some default y if ... logic around
> BOOTSTD.

OK

>
> > > 2. As to the default, I believe BOOTSTD should be on by default, if w=
e intend to remove the distro scripts and support things that are not EFI
>
>
> In case you missed it, EFI_LOADER is default for some ARM32, ARM64, X86,
> RISC-V and sandbox. None of those are cases where I'm suggesting BOOTSTD
> shouldn't be default.

OK

>
> > I'd agree with Simon on 2. Boards that have never been upgraded to
> > distro boot or standard boot usually have an internal envs script in
> > include/configs/xxx.h that boots the board the legacy way. Even if
> > bootstd is enabled by default, it won't hurt those.
>
> It hurts them because of the strong likelyhood that they do have
> practical image size limitations (before they would then be leaking in
> to U-Boot environment or some other part of flash).

OK

Regards,
Simon
