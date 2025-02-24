Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D90C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 17:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C6F6805C3;
	Mon, 24 Feb 2025 18:54:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aPS+MlzE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 614A680977; Mon, 24 Feb 2025 18:54:21 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AA8380079
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 18:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-abbac134a19so726645566b.0
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 09:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740419658; x=1741024458; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5BUf5UsPBvT2acL+EPCQPkeBPqc4bjegX9ZfNPgC5eg=;
 b=aPS+MlzEuvf4iVt9tq3wIFZW8G/kISelEPeSB56Hw3eN5QNlwx7a4CV4GGcxZoK8J7
 INYFii8UZQcTreqwW+Nwe6vCq8AUhXfVzSmm+Ka75nXrE6AU8CwCJvLKHujTZv7Ag0YV
 8MJfyQbJkX2sohWAGq+EJvhEs/35xLs9SSJ4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740419658; x=1741024458;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5BUf5UsPBvT2acL+EPCQPkeBPqc4bjegX9ZfNPgC5eg=;
 b=QlNUhx5cbNTv0UDGyRj/t4Otg1nMdH/ZZLyr9aQoN92nEHkRj1TYPnB4oWYhtzq4e1
 eTNVe/f0DZxiuSo46IwszkAtgLVzmJ8HoiWTv9DcSmV4+lHZZ6lB3Pg10y8vZjUCeg9i
 mejiFR5/yezfqk0CeDx3/O90Rd0cYHzUs+7viC0lPOxeS7NvnobEYwjWPJSlk3XLRAcm
 ZxlptrewcJ5XibMnHUYIGY+PfBDBmhgYjLmH7wynFjugG05sG1AQ6i5GiScpRqh/oBSm
 0TfNYOO+2I5mNdU+nESFc3fsF/5vaIUbL1GPq4WS/TE2c4xkRq9SjOdCt9QlhIOqiCoO
 Up/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp0q5SyJMGMbuLoA2XeUlwlFpyQs6fS+K+j2x3El3mS6unYWc6X+Muym9S02CbH9H6Ae/b5HA=@lists.denx.de
X-Gm-Message-State: AOJu0YxFy4Oc9UetaTKlOhVWSmOyXfIT1hj+r66fLYxCWyfKC5Ovt56Z
 2NpYZfoszj8lwG4eQSPyjn1ewm9PM4x1WMPcY7olHo/celCp5fYP3HC7/UCtyZ3+wUU4N/SZCRs
 gGTXn0pKpHfuaH2BkAgkH7Mc+0NxIA4335QKz
X-Gm-Gg: ASbGncs9YBneT0zHtHqyL0Z72bc5yr7z6jOdyuolyn36pEPRq7sn430Pk44XOsUsNdD
 8C7uwgI6xIpQ5Ifz5lYTN6L/0Ir9O2odx8V6jYN9BIPMGg3r4obGcsrI1ESeel+MZno/FI3qmA1
 TtOfZA3t8l
X-Google-Smtp-Source: AGHT+IGHzBkmTiuyGJR99YsAdjhqLjcph2wGCHa/m8O2BygwLXYxwXtsGOlMp20UngTl72yGuhzIORpe+2AUhAxYFho=
X-Received: by 2002:a17:907:781:b0:ab7:e47c:b54a with SMTP id
 a640c23a62f3a-abed1017a07mr11251366b.37.1740419657032; Mon, 24 Feb 2025
 09:54:17 -0800 (PST)
MIME-Version: 1.0
References: <20250218-init-v1-1-a1c5bf9e8fb0@posteo.net>
 <CAFLszTgKD0YQaCYyeHFxqj55YRQzvo2_yqkcjnZ6uy3dG_rEGg@mail.gmail.com>
 <Z7oeYIn1iMOG107U@probook>
In-Reply-To: <Z7oeYIn1iMOG107U@probook>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 24 Feb 2025 10:54:05 -0700
X-Gm-Features: AWEUYZliA7EXdHr7M3QcfIpQHnDb94mHBnG-1W6OKsHTk5zOw6eWlfB5Vi2DDI0
Message-ID: <CAFLszThOJnJ1n7UvPGZ40BNSP8_P8qvxQ9xzjzSAL3ourO3cPA@mail.gmail.com>
Subject: Re: [PATCH] common: board_r: Initialize interrupts before watchdog
To: =?UTF-8?B?Si4gTmV1c2Now6RmZXI=?= <j.ne@posteo.net>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, mario.six@gdsys.cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi J,

On Sat, 22 Feb 2025 at 11:58, J. Neusch=C3=A4fer <j.ne@posteo.net> wrote:
>
> (CC'ing Mario Six regarding MPC83xx timer driver in U-Boot)
>
> On Thu, Feb 20, 2025 at 06:49:58AM -0700, Simon Glass wrote:
> > Hi J,
> >
> > On Tue, 18 Feb 2025 at 08:55, J. Neusch=C3=A4fer via B4 Relay
> > <devnull+j.ne.posteo.net@kernel.org> wrote:
> > >
> > > From: "J. Neusch=C3=A4fer" <j.ne@posteo.net>
> > >
> > > On some platforms, initializing the watchdog driver enables a timer
> > > interrupt. This of course requires the interrupt handlers to be
> > > properly initialized, otherwise U-Boot may crash or run the timer
> > > interrupt handler of a previous bootloader stage.
> > >
> > > To account for such systems, always initialize interrupts
> > > (arch_initr_trap) before the watchdog (initr_watchdog).
> > >
> > > This problem was observed on a PowerPC MPC83xx board.
> > >
> > > Signed-off-by: J. Neusch=C3=A4fer <j.ne@posteo.net>
> > > ---
> > > NOTE: This approach seems safe and fine to me, but an argument could =
be
> > >       made that this should be fixed in the platform-specific drivers
> > >       instead.  Please let me know what you think.
> > >
> > >
> > > Rough stack trace (not sure if it should be part of the commit messag=
e):
> > >
> > >   initr_watchdog                (drivers/watchdog/wdt-uclass.c)
> > >     device_probe(wdt@200)
> > >       device_probe(timer)
> > >         mpc8xxx_wdt_start       (drivers/watchdog/mpc8xxx_wdt.c)
> > >           set_msr(get_msr() | MSR_EE);
> > >
> > >   arch_initr_trap               (arch/powerpc/lib/traps.c)
> > >     trap_init                   (arch/powerpc/cpu/mpc83xx/start.S)
> > > ---
> > >  common/board_r.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/common/board_r.c b/common/board_r.c
> > > index 179259b00de81f7ba9802fc5288e7c2b6e6f381a..f711cd237ae76d80ca241=
3017bfe131656f44180 100644
> > > --- a/common/board_r.c
> > > +++ b/common/board_r.c
> > > @@ -652,11 +652,11 @@ static init_fnc_t init_sequence_r[] =3D {
> > >         serial_initialize,
> > >         initr_announce,
> > >         dm_announce,
> > > +       arch_initr_trap,
> > >  #if CONFIG_IS_ENABLED(WDT)
> > >         initr_watchdog,
> > >  #endif
> > >         INIT_FUNC_WATCHDOG_RESET
> > > -       arch_initr_trap,
> > >  #if defined(CONFIG_BOARD_EARLY_INIT_R)
> > >         board_early_init_r,
> > >  #endif
> > >
> > > ---
> > > base-commit: 064556910e61044f1295162ceaad600582b66cda
> > > change-id: 20250218-init-dab1fc72abd2
> > >
> > > Best regards,
> > > --
> > > J. Neusch=C3=A4fer <j.ne@posteo.net>
> > >
> > >
> >
> > The driver model way of doing this would be that your UCLASS_WDT
> > driver calls uclass_first_device(UCLASS_IRQ) to make sure interrupts
> > are ready.
>
> This sounds good in principle, but would require some reworking of the
> MPC83xx interrupt infrastructure, because it currently doesn't declare a
> UCLASS_IRQ driver.
>
> > The arch_initr_trap thing should probably not be used in new code.
> > Also, we have interrupt_init() which sounds like it is similar?
>
> This isn't really *new* code, the MPC83xx platform support has been in
> U-Boot for a long time (I am touching it now due to a newly to be added
> board, though).
>
> I see various functions called interrupt_init(), one of them in
> mpc83xx_timer.c (i.e. relevant to my problems):
>
>   /*
>    * TODO(mario.six@gdsys.cc): This should really be done by timer_init, =
and the
>    * interrupt init should go into a interrupt driver.
>    */
>   int interrupt_init(void)
>   { ... }
>
> it seems someone has stumbled on this oddity before.
>
> Another version of interrupt_init is in arch/powerpc/lib/interrupts.c.
> Fortunately, as I just found out, my PowerPC MPC8314E board works fine
> with the generic timer/interrupt support in arch/powerpc, with
> CONFIG_TIMER=3Dn. In other words, the problem is localized to
> CONFIG_MPC83XX_TIMER.

Thanks for all the info. So do you think you could clean this up in PowerPC=
?

Regards,
Simon
