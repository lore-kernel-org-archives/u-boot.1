Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7DFE7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 17:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1954D801A0;
	Fri, 13 Dec 2024 18:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PeKaiKbI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76ACB801F5; Fri, 13 Dec 2024 15:32:55 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E2C88012C
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 15:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa66e4d1d5aso288458566b.2
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 06:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734100373; x=1734705173; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dYkb901V6oVbUbM3wT1AZtJTVYQGPyW5u+K/QgkC5kQ=;
 b=PeKaiKbIZbER7BjN7pfvFd8SpMJvgrdLlUSmlW/RRtczDmiW2POMy35GBvVZ0BYTPQ
 WvbuaU5sqjXQ7IiyrjFEsCWogMbENwvCx5Hyfa4+f7HYiTSawAAmbyvsKBpMDCqOv+0g
 tHruhKqbOKGVduENr5MQLNF/FiOgd8n1IF6b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734100373; x=1734705173;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dYkb901V6oVbUbM3wT1AZtJTVYQGPyW5u+K/QgkC5kQ=;
 b=V7KHbkDx9B2zOdxqpwH3yeALsRnFPyyPLQAwDwO8Dq4COp3VumloPMEdDtdvrfHJyJ
 ubtxVGWf5vz/bwBJwCDFB5VD2J8WQvUsxOGEhA+DsehbsXmi0eXeBXu9giH02YoQzXKl
 F5NJd1GtwZFQpT2mbq63om1llnPfa0mF/hER3y2bXJ8LX1+7Vp1Z1ygDQ1sbzC4dL870
 P9WsSic/hedPSz9m41dfn0cPlsWyCWIpskr6LU+82Vf4Ahk6P3rgpYHqP2dUbjBdKeiE
 XNueoW39yW4zqxfvfNQAb3pM9+O1Q1G1NJa06yUHZSNJmk1K3nJbNxEAyPgpmRHMjodm
 PR9g==
X-Gm-Message-State: AOJu0YymjpTVtXpBM/CdSjSTSvG2ebDBtat5SC6818LcLRqrYffrfMiE
 cktJg2of0EYQlKRFoANFZfiE6+ZzbPzK3/yql24Q84ePQx88gsHfM3UEDy6S0nnX9tM9/17ZYA4
 WVeUXIi7Ly+3jzGNJUpj/T2GQd2rY9DtkBsM7
X-Gm-Gg: ASbGnculEQ1GtMyHbEdw3WNw1UN3lI3MOCW3CPvobs0Adjj+TqlzDUmzs+IqP7wcrHQ
 lZVmWhXlgl95sn7LLm9XI5Fwm94OZgn6Q7+2B7Hg=
X-Google-Smtp-Source: AGHT+IGFw0iACBYldYQFjif5mKfOSyqA1oYK6Pibqs7jcKvspFjQ+Kqw58afzsQBAmjv0IFXrQxpxx1yRnysZyrYY1U=
X-Received: by 2002:a17:907:7e95:b0:aa6:7d82:540a with SMTP id
 a640c23a62f3a-aab77ee9b4dmr303769366b.61.1734100372704; Fri, 13 Dec 2024
 06:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20241207172412.1124558-1-sjg@chromium.org>
 <173405231528.1635625.10928592597091154587.b4-ty@konsulko.com>
 <20241213030940.GO1505244@bill-the-cat>
 <CAFLszTj2av9Cj4x5k7wYcxEZXNQt6O=0_5oXUKMSw4RGbnDAfg@mail.gmail.com>
 <20241213140510.GS1505244@bill-the-cat>
In-Reply-To: <20241213140510.GS1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Dec 2024 07:32:41 -0700
Message-ID: <CAFLszTjNZmxzrEmDqACgo7sdg4NHr9o49fJN6G9p1LqW14o1WQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] vbe: Series part E
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anand Moon <linux.amoon@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Devarsh Thakkar <devarsht@ti.com>, 
 Dragan Simic <dsimic@manjaro.org>, Gary Bisson <bisson.gary@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Julien Masson <jmasson@baylibre.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Nam Cao <namcao@linutronix.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Tim Harvey <tharvey@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 13 Dec 2024 18:47:00 +0100
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

On Fri, 13 Dec 2024 at 07:05, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Dec 12, 2024 at 08:24:06PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 12 Dec 2024 at 20:09, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Dec 12, 2024 at 07:11:55PM -0600, Tom Rini wrote:
> > > > On Sat, 07 Dec 2024 10:23:53 -0700, Simon Glass wrote:
> > > >
> > > > > This includes various patches towards implementing the VBE abrec
> > > > > bootmeth in U-Boot. It mostly focuses on SPL tweaks and adjusting what
> > > > > fatures are available in VPL.
> > > > >
> > > > > Changes in v3:
> > > > > - Add new patch to avoid size growth in spl_mmc_find_device() debug
> > > > > - Use strlcpy() instead of strncpy()
> > > > > - Rebase to master
> > > > >
> > > > > [...]
> > > >
> > > > Applied to u-boot/next, thanks!
> > >
> > > And, ugh, I missed that CI was failing for real. This causes
> > > rcar3_salvator-x to fail to link due to size growth, so I'm reverting
> > > this for now, sorry. I thought the CI failure I saw was due to something
> > > else at the time.
> >
> > Hmm, sorry about that...it passed CI when I sent it!
> >
> > The growth is quite alarming and I am not sure how to make sense of
> > it. Here is the last patch:
> >
> > 21: hash: Plumb crc8 into the hash functions
> >    aarch64:  +   rcar3_salvator-x
> >    aarch64: (for 1/1 boards) all +2109.0 bss -48.0 data +56.0 rodata
> > +5.0 text +2096.0
> >             rcar3_salvator-x: all +2109 bss -48 data +56 rodata +5 text +2096
> >                u-boot: add: 1/0, grow: 1/0 bytes: 136/0 (136)
> >                  function                                   old     new   delta
> >                  crc8_wd_buf                                  -      80     +80
> >                  hash_algo                                  280     336     +56
> >
> > So perhaps apply all but the final patch? Then I can sort out things from there.
>
> I tried that before going off for the night without remembering that the
> problem is:
> +(rcar3_salvator-x) u-boot.img exceeds file size limit:
> +(rcar3_salvator-x)   limit:  0x100000 bytes
> +(rcar3_salvator-x)   actual: 0x100392 bytes
> +(rcar3_salvator-x)   excess: 0x392 bytes
>
> So no, just the last patch alone is not enough. You need to sync up with
> Marek about what can/can't be disabled on the platform (or more likely
> really, r-car gen3 platforms overall0.

I don't really like the size growth and I think it might be better to
put my hash addition behind a Kconfig. While these boards are
inconvenient, they do keep us honest, on code size.

Regards,
Simon
