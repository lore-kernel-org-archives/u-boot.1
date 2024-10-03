Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB81CF34C3
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 21:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F75688FDE;
	Thu,  3 Oct 2024 23:28:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hM85F/mA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2344488EBA; Thu,  3 Oct 2024 19:30:48 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB97F88B89
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 19:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e25d164854dso1083955276.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 10:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727976644; x=1728581444; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lDJVUp2Ha/0uwoXOYxPUqu1y41dnXt4PkLLbyM2ZY2M=;
 b=hM85F/mAIh5axQTnp0euBnb9x5WHeBkC1ZZAUmcVFehGgi2whXDKyZeHluKERBVr5w
 95xturltWl3BKfIZb/ZZ0wwFiiPXEpGT0SbcnJ3wtM67EvVWhXxijGWD2y7gFlxr+Uve
 pOhnvbjvNy/x2HAVl67W9Zp8UXSHq0/Bw8E9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727976644; x=1728581444;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lDJVUp2Ha/0uwoXOYxPUqu1y41dnXt4PkLLbyM2ZY2M=;
 b=qIpXKPbPH+bxgAqZJ13qhL2sf+uJgV51G4y3RQCaHNzlNrOkuguM4zts2RyOXtMSVt
 Mmp85z3HsG18CJ663t1qMNtbGQ8QSGMQGZccJUzYpDQBX+jv0UVDsaQitf+oPQ557AOw
 T5br6B9iKZTsBuiugPF05qNdZkcd5hGgGS3qQvnSidLM7QwScfFHYLKZzbBaheZILq9v
 e3AsNKNaesJinBYi4iD4q6ytNzjFa+6J+8C+tj61WA3pPqcqt1rJswsUwitnYMRGUfG2
 FCE6CkSieS4p3Mw2a3LhYc4q/CuuKPAmo7oUk3OtGMN/n338NxfMBcy+Vfm/4OUsALBm
 wM0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf3ujTfvGFKv0n+JLhLD6zA9KiJB8pci+N6FQ4Wu0Hlvsi5Wk7JOdvSsbEPWuoj3YmilL5a8w=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/9GInucOLiQj9CcsTI6HkdzBvYnRZauMwVr4HZp6gRpJORchS
 D03jOQFHFyrI+Gk3y3J7MUj4Jcmabe+dg/LM4bgUyPrQ2IomqVDgxLzfeWZOQckcZRpySLPgShH
 Zj55GxYcxxAMkywIwAB6tTl7lJDDRVkwjwUE0
X-Google-Smtp-Source: AGHT+IGc1oekaB53CJXaStrhMrk1srk13If+/p48RiEXIpNI9ftKsuIj61itY21VGoxelOTtG7hBUj+NWo1almrwtsk=
X-Received: by 2002:a25:d613:0:b0:e28:6dc6:279d with SMTP id
 3f1490d57ef6-e286dc628f2mr3649190276.41.1727976644403; Thu, 03 Oct 2024
 10:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
 <20241001122511.8832-4-ansuelsmth@gmail.com>
 <CAFLszTjB4OV-k65rhqJ9pBTmKUnnWthbDJ2Vk3eRxzBgmMeOOg@mail.gmail.com>
 <66fdd09f.050a0220.75511.cc7e@mx.google.com>
In-Reply-To: <66fdd09f.050a0220.75511.cc7e@mx.google.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Oct 2024 11:30:32 -0600
Message-ID: <CAFLszTjBy-9kwLuhBNkUR_YCe1zH=iUhUcZCmLDCRt5DVkJnrQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] led: implement LED boot API
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Alexander Gendin <agendin@matrox.com>, Yang Xiwen <forbidden405@outlook.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>, 
 Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 03 Oct 2024 23:28:32 +0200
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

Hi Christian,

On Wed, 2 Oct 2024 at 17:00, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> On Wed, Oct 02, 2024 at 04:55:42PM -0600, Simon Glass wrote:
> > On Tue, 1 Oct 2024 at 06:25, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > >
> > > Implement LED boot API to signal correct boot of the system.
> > >
> > > led_boot_on/off/blink() are introduced to turn ON, OFF and BLINK the
> > > designated boot LED.
> > >
> > > New Kconfig is introduced, CONFIG_LED_BOOT to enable the feature.
> > > This makes use of the /options/u-boot property "boot-led" to the
> > > define the boot LED.
> > > It's also introduced a new /options/u-boot property "boot-led-period"
> > > to define the default period when the LED is set to blink mode.
> >
> > BTW could you please send a schema update for this so that Linux accepts it?
> >
>
> I open a PR there [1] or should I use other way?
>
> [1] https://github.com/devicetree-org/dt-schema/pull/144

Well I see others getting merged, so yes that seems to be fine. I have
only ever used the mailing list myself.

Regards,
SImon


>
> > >
> > > If "boot-led-period" is not defined, the value of 250 (ms) is
> > > used by default.
> > >
> > > If CONFIG_LED_BLINK or CONFIG_LED_SW_BLINK is not enabled,
> > > led_boot_blink call will fallback to simple LED ON.
> > >
> > > To cache the data we repurpose the now unused led_uc_priv for storage of
> > > global LED uclass info.
> > >
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >  drivers/led/Kconfig      | 11 ++++++
> > >  drivers/led/led-uclass.c | 85 ++++++++++++++++++++++++++++++++++++++++
> > >  include/led.h            | 55 +++++++++++++++++++++++++-
> > >  3 files changed, 149 insertions(+), 2 deletions(-)
> > >
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
>
> --
>         Ansuel
