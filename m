Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636D8C021BB
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 18:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7FAF805C3;
	Mon, 24 Feb 2025 19:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="Hge0q6iY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF681807B1; Mon, 24 Feb 2025 19:48:50 +0100 (CET)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D25780079
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 19:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j.ne@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 52A9A240027
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 19:48:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1740422928; bh=JoVv/IGaTIM7NhrfHB/nyN09KiEcGU/G/NY8fNLotYU=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:From;
 b=Hge0q6iYtsLW4DXwt4G2UP1nUuN0JWQeIkpFTHSFSTj+9MQ6l4c4StauRfAvuUSRa
 bc//KurjW4ggwcSfXebREomBGuvF6yVOsb2LMtM2l9z/Iw5kQcLdCUIOarYiSPzrNX
 L+Hks5AYUC0K0Ej5JDeuka0tsDqxC9pJxIm1u0BVifarzWhm8U4ryjpyNRri4GVlAU
 URH9FR1qURhr8VCRmbLijpm/1XHzHN39vEkrN5iaNJJEdH0Uz58edstmXfh0c4OQoD
 sedRbqR/aHugUVyg0a2lgU7pMPnsFRTnVkB8vqiW65H6NrohRwUy+9Jr89EibHGb00
 1WODjw8AIqdTg==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4Z1qWg43xPz6v00;
 Mon, 24 Feb 2025 19:48:47 +0100 (CET)
Date: Mon, 24 Feb 2025 18:48:47 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Simon Glass <sjg@chromium.org>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, mario.six@gdsys.cc
Subject: PowerPC MPC83XX timer issues (Re: [PATCH] common: board_r:
 Initialize interrupts before watchdog)
Message-ID: <Z7y_D3soW9Kcd0eu@probook>
References: <20250218-init-v1-1-a1c5bf9e8fb0@posteo.net>
 <CAFLszTgKD0YQaCYyeHFxqj55YRQzvo2_yqkcjnZ6uy3dG_rEGg@mail.gmail.com>
 <Z7oeYIn1iMOG107U@probook>
 <CAFLszThOJnJ1n7UvPGZ40BNSP8_P8qvxQ9xzjzSAL3ourO3cPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLszThOJnJ1n7UvPGZ40BNSP8_P8qvxQ9xzjzSAL3ourO3cPA@mail.gmail.com>
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

On Mon, Feb 24, 2025 at 10:54:05AM -0700, Simon Glass wrote:
> Hi J,
> 
> On Sat, 22 Feb 2025 at 11:58, J. Neuschäfer <j.ne@posteo.net> wrote:
> >
> > (CC'ing Mario Six regarding MPC83xx timer driver in U-Boot)
> >
> > On Thu, Feb 20, 2025 at 06:49:58AM -0700, Simon Glass wrote:
> > > Hi J,
> > >
> > > On Tue, 18 Feb 2025 at 08:55, J. Neuschäfer via B4 Relay
> > > <devnull+j.ne.posteo.net@kernel.org> wrote:
> > > >
> > > > From: "J. Neuschäfer" <j.ne@posteo.net>
> > > >
> > > > On some platforms, initializing the watchdog driver enables a timer
> > > > interrupt. This of course requires the interrupt handlers to be
> > > > properly initialized, otherwise U-Boot may crash or run the timer
> > > > interrupt handler of a previous bootloader stage.
> > > >
> > > > To account for such systems, always initialize interrupts
> > > > (arch_initr_trap) before the watchdog (initr_watchdog).
> > > >
> > > > This problem was observed on a PowerPC MPC83xx board.
> > > >
> > > > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > > > ---
> > > > NOTE: This approach seems safe and fine to me, but an argument could be
> > > >       made that this should be fixed in the platform-specific drivers
> > > >       instead.  Please let me know what you think.
> > > >
> > > >
> > > > Rough stack trace (not sure if it should be part of the commit message):
> > > >
> > > >   initr_watchdog                (drivers/watchdog/wdt-uclass.c)
> > > >     device_probe(wdt@200)
> > > >       device_probe(timer)
> > > >         mpc8xxx_wdt_start       (drivers/watchdog/mpc8xxx_wdt.c)
> > > >           set_msr(get_msr() | MSR_EE);
> > > >
> > > >   arch_initr_trap               (arch/powerpc/lib/traps.c)
> > > >     trap_init                   (arch/powerpc/cpu/mpc83xx/start.S)
> > > > ---
> > > >  common/board_r.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/common/board_r.c b/common/board_r.c
> > > > index 179259b00de81f7ba9802fc5288e7c2b6e6f381a..f711cd237ae76d80ca2413017bfe131656f44180 100644
> > > > --- a/common/board_r.c
> > > > +++ b/common/board_r.c
> > > > @@ -652,11 +652,11 @@ static init_fnc_t init_sequence_r[] = {
> > > >         serial_initialize,
> > > >         initr_announce,
> > > >         dm_announce,
> > > > +       arch_initr_trap,
> > > >  #if CONFIG_IS_ENABLED(WDT)
> > > >         initr_watchdog,
> > > >  #endif
> > > >         INIT_FUNC_WATCHDOG_RESET
> > > > -       arch_initr_trap,
> > > >  #if defined(CONFIG_BOARD_EARLY_INIT_R)
> > > >         board_early_init_r,
> > > >  #endif
> > > >
> > > > ---
> > > > base-commit: 064556910e61044f1295162ceaad600582b66cda
> > > > change-id: 20250218-init-dab1fc72abd2
> > > >
> > > > Best regards,
> > > > --
> > > > J. Neuschäfer <j.ne@posteo.net>
> > > >
> > > >
> > >
> > > The driver model way of doing this would be that your UCLASS_WDT
> > > driver calls uclass_first_device(UCLASS_IRQ) to make sure interrupts
> > > are ready.
> >
> > This sounds good in principle, but would require some reworking of the
> > MPC83xx interrupt infrastructure, because it currently doesn't declare a
> > UCLASS_IRQ driver.
> >
> > > The arch_initr_trap thing should probably not be used in new code.
> > > Also, we have interrupt_init() which sounds like it is similar?
> >
> > This isn't really *new* code, the MPC83xx platform support has been in
> > U-Boot for a long time (I am touching it now due to a newly to be added
> > board, though).
> >
> > I see various functions called interrupt_init(), one of them in
> > mpc83xx_timer.c (i.e. relevant to my problems):
> >
> >   /*
> >    * TODO(mario.six@gdsys.cc): This should really be done by timer_init, and the
> >    * interrupt init should go into a interrupt driver.
> >    */
> >   int interrupt_init(void)
> >   { ... }
> >
> > it seems someone has stumbled on this oddity before.
> >
> > Another version of interrupt_init is in arch/powerpc/lib/interrupts.c.
> > Fortunately, as I just found out, my PowerPC MPC8314E board works fine
> > with the generic timer/interrupt support in arch/powerpc, with
> > CONFIG_TIMER=n. In other words, the problem is localized to
> > CONFIG_MPC83XX_TIMER.
> 
> Thanks for all the info. So do you think you could clean this up in PowerPC?

At the current moment, I'll rather use the the generic (non-MPC83xx)
timer/irq support, for two reasons: 1. it works, and  2. I'm not
familiar enough with U-Boot architecture and internals to come up with
with a fix, without further research.


Best regards,
J. Neuschäfer
