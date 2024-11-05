Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A268D2B950
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 15:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0ADD8904C;
	Tue,  5 Nov 2024 16:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V9G4mJ7U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66ED2891A4; Tue,  5 Nov 2024 16:13:03 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4374891AF
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 16:13:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9a0c7abaa6so661667566b.2
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 07:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730819580; x=1731424380; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FPaNENp1NT7ji6GYdw2bAMD2O12CkF9RMju0zkH7CzA=;
 b=V9G4mJ7URd2QHgau8yTMDclw3Mf7M48xPC/U7yERz0cu22WbsLlePSJp4YtQJNpEek
 DhmCITuVnIjdr39B8mWe9k/mUzTNt5ZZhWnhErgFkVCYGTupPM59DSk7x/H7uS+q0k8F
 uQz1EvWBJgy4IxkwGxfSyQuEHNFE+CN6fJdjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730819580; x=1731424380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FPaNENp1NT7ji6GYdw2bAMD2O12CkF9RMju0zkH7CzA=;
 b=uuREZZnUtpx8yFkyzSqVjhZ25Dj4b5eJ40Areyz8cWYqKceVxnKdFJllCiPefPwMDq
 VfScDbU0Xcp1sF5Q8cKe4GQm3h4RzgqitznmjuF8sUEp5MrT3PHmwnmlvhtUyGPc0ANG
 iHVPwejlF/wF2ZjbnagsIB2+L3iQv7RRFeZjCG/1akqgeRhWaZiJCkW820tnYzSAo+f3
 osoemz1FAGdyPitF3+q6Gn7jm1XG2PJBtTrZ+9vo89LKyjqr2CY1lufSS9x3wwmBdVxO
 zvamW7sI8GrH9HIht2B+a6YJ+Atz1lBxHp1DQMHpru2m1jF9ROF4wPMChvKMQ6wmkIno
 tU2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtIQ1WA6aMOaYSH58WzFa+bslKk36yzhHmtj8coWu4euahLb/CEwS+esQXHH9NVn8jP0QYFeU=@lists.denx.de
X-Gm-Message-State: AOJu0YygohkM1em4AOqkqZz8xe1ubT1D+iHAI5AOTeE+RByS4ZexRxPD
 jflBparNaZZo8z7Gnflzf+lF+fqr8uZJNTrnTymi518e9msy1dyIJJLEeBSgBa3IQ4U13/NwEX5
 pSPHp1B5ZhrMbU11ETZ70Ky8ICGH1MsBJnrH8
X-Google-Smtp-Source: AGHT+IFswSZWfHbSsQbpuCnQyh5nRwULZGFUxA1mKczE7lGq89LFw3TitH6K66akA1xnHRt7wvY7aQWMcM7GDdfEup0=
X-Received: by 2002:a17:907:2d91:b0:a9a:80cc:c972 with SMTP id
 a640c23a62f3a-a9e655a8980mr1568893266b.27.1730819580112; Tue, 05 Nov 2024
 07:13:00 -0800 (PST)
MIME-Version: 1.0
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
 <20241001122511.8832-4-ansuelsmth@gmail.com>
 <CAFLszTjB4OV-k65rhqJ9pBTmKUnnWthbDJ2Vk3eRxzBgmMeOOg@mail.gmail.com>
 <CAFLszTh9WYnya=8YXXFEcSuVUYuhCGy-+iYFRucgMZq+-1H5UQ@mail.gmail.com>
 <67267f36.df0a0220.87602.7b89@mx.google.com>
 <CAFLszTgP5r56eCTGuG4fbga7Wj8iU97dQZmcvw4ze0UBOhRj1g@mail.gmail.com>
 <672682f5.050a0220.361a4b.7e2b@mx.google.com>
 <CAFLszTid7ZhM-mrkP4PQmSMsOp3PxJ+8tkWj292MUwpeZB7v=A@mail.gmail.com>
 <67295533.050a0220.e889.dca0@mx.google.com>
In-Reply-To: <67295533.050a0220.e889.dca0@mx.google.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Nov 2024 08:12:47 -0700
Message-ID: <CAFLszTjwqrufzc7Ujt3oOhsL5AxPa-Bbr61edrHomChtPqyEjA@mail.gmail.com>
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
X-Mailman-Approved-At: Tue, 05 Nov 2024 16:54:11 +0100
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

On Mon, 4 Nov 2024 at 16:13, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> On Sun, Nov 03, 2024 at 07:46:19AM -0700, Simon Glass wrote:
> > Hi Christian,
> >
> > On Sat, 2 Nov 2024 at 13:52, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > >
> > > On Sat, Nov 02, 2024 at 01:50:13PM -0600, Simon Glass wrote:
> > > > Hi Christian,
> > > >
> > > > On Sat, 2 Nov 2024 at 13:36, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > > >
> > > > > On Sat, Nov 02, 2024 at 01:33:10PM -0600, Simon Glass wrote:
> > > > > > Hi Christian,
> > > > > >
> > > > > > On Wed, 2 Oct 2024 at 16:55, Simon Glass <sjg@chromium.org> wrote:
> > > > > > >
> > > > > > > On Tue, 1 Oct 2024 at 06:25, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Implement LED boot API to signal correct boot of the system.
> > > > > > > >
> > > > > > > > led_boot_on/off/blink() are introduced to turn ON, OFF and BLINK the
> > > > > > > > designated boot LED.
> > > > > > > >
> > > > > > > > New Kconfig is introduced, CONFIG_LED_BOOT to enable the feature.
> > > > > > > > This makes use of the /options/u-boot property "boot-led" to the
> > > > > > > > define the boot LED.
> > > > > > > > It's also introduced a new /options/u-boot property "boot-led-period"
> > > > > > > > to define the default period when the LED is set to blink mode.
> > > > > > >
> > > > > > > BTW could you please send a schema update for this so that Linux accepts it?
> > > > > >
> > > > > > I'm just checking that you did this?
> > > > > >
> > > > >
> > > > > Yep [0]. Also tagged Rob 2 hours ago. (eh the coincidence)
> > > > >
> > > > > Tell me if I should send it with usual way with a dedicated mail. (any
> > > > > hint on the mailing-list address?)
> > > >
> > > > OK great! Yes, once it lands, please send a patch to bring it into U-Boot
> > > >
> > > > Regards,
> > > > Simon
> > > >
> > > > > [0] https://github.com/devicetree-org/dt-schema/pull/144
> > >
> > > I'm confused what kind of patch I should send to U-Boot?
> >
> > Something to add the binding to U-Boot also. See my patch at [1]
> >
> > Regards,
> > Simon
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/patch/20241103003322.626036-26-sjg@chromium.org/
>
> Ok thanks for the hint.
>
> Anyway Rob checked the patch (good news) but he request some changes
> (bad news)
>
> I created this PR [1] waiting for CI to confirm everything is ok.
>
> Would be good if you can check the changes while CI tests.

A few things:
- Better to return -ENOENT or -EINVAL if something is missing, since
we use -ENODEV in driver model to mean there is no device
- 'nodep' instead of 'node' for the parameter, so it is clear that it
is returned

Otherwise it looks good to me (with the proviso that's I'm just
looking at an emphemal github link!)

Regards,
Simon


>
> [1] https://github.com/u-boot/u-boot/pull/686
>
> --
>         Ansuel
