Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F8FD11195
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 22:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF70B88FB5;
	Sun,  3 Nov 2024 23:51:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZSD8l2sG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31E9789121; Sun,  3 Nov 2024 15:46:34 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3D108862E
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 15:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a99e3b3a411so684679466b.0
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 06:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730645191; x=1731249991; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BcFbo8teWNG8QknAeQkZ3ygVnAQiiNZU426vNfGoaKc=;
 b=ZSD8l2sGUfjWHn3QnzGr+euq//a8iRpyho6S/I8xXiPZh3uL+Ucjt+0QuGUQ9DL0Gw
 WOfYvFdOHGjZrKnFK5fcqDIzHCd81XXN0QVz/NjP/SIYW79QQ5dd2TD9CY4Sou6Dwh15
 VNENmi3JYMZet6cILufC6/d7gMp4HvOgisPqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730645191; x=1731249991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BcFbo8teWNG8QknAeQkZ3ygVnAQiiNZU426vNfGoaKc=;
 b=R1kxrTrMqbw87am/hiN02g7G3DM2evRiaV5B4TdFiYi2+iF24WzYTD+LydfuZS7LNL
 9HKvbEcReBO9LGl74MdYgqj3eEQjd47XYpIXOgRfyGyeK556CLkawSM0o3VgypK6cEgQ
 N8C4q4i5zYSmwipigPV5CBxnA42Prc/a3wgnvLKDaDFqH1dM+Zh+BDsZvMQ8mRwe/tO/
 DZ8z/fYeOY0QfqulMcUyBbSE4L5nWrB8UMUdxHNQYLB0chO8lJ6Ktp39qwkbJYmkM2gk
 cgnFGyiZWez2ki4EZzL1uRqwFMNCiXh00hL6IyckqRAKD1QQxMgPnUKq5ByJT4PMiDWx
 Amiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1zALpaqVUsbcX54Pf5lB8m8h7y7xmKtNULkNwaDvN1cc6demLPW9RLNs+7X7UzEahAbY/pho=@lists.denx.de
X-Gm-Message-State: AOJu0YwFOa9OpJYlS2W85Kj7Aiw+Bo74F0OQGY0Gj01UW4SiH8iRAZXf
 7sNGHCbda0mljhIcJHMLkvvHfeG7h9v8kGpveDPSi01Xk2q+DxmViiU4uGDjnpq57fI64XWWROL
 9p0YWfbXRZalTV/Wb+V1xX5fanhhtP+jJeDAK
X-Google-Smtp-Source: AGHT+IFULOHkFf9MnweuFJrpaiIFRP3l8Hcb8nAZt/3mbD+Ra+L6wk0IZRSAaNUtRON12goRya4KysI+SPeoqVpXcH8=
X-Received: by 2002:a17:907:9446:b0:a99:f209:cea3 with SMTP id
 a640c23a62f3a-a9e55a4f2b9mr1204385766b.11.1730645191244; Sun, 03 Nov 2024
 06:46:31 -0800 (PST)
MIME-Version: 1.0
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
 <20241001122511.8832-4-ansuelsmth@gmail.com>
 <CAFLszTjB4OV-k65rhqJ9pBTmKUnnWthbDJ2Vk3eRxzBgmMeOOg@mail.gmail.com>
 <CAFLszTh9WYnya=8YXXFEcSuVUYuhCGy-+iYFRucgMZq+-1H5UQ@mail.gmail.com>
 <67267f36.df0a0220.87602.7b89@mx.google.com>
 <CAFLszTgP5r56eCTGuG4fbga7Wj8iU97dQZmcvw4ze0UBOhRj1g@mail.gmail.com>
 <672682f5.050a0220.361a4b.7e2b@mx.google.com>
In-Reply-To: <672682f5.050a0220.361a4b.7e2b@mx.google.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 3 Nov 2024 07:46:19 -0700
Message-ID: <CAFLszTid7ZhM-mrkP4PQmSMsOp3PxJ+8tkWj292MUwpeZB7v=A@mail.gmail.com>
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
X-Mailman-Approved-At: Sun, 03 Nov 2024 23:51:06 +0100
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

On Sat, 2 Nov 2024 at 13:52, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> On Sat, Nov 02, 2024 at 01:50:13PM -0600, Simon Glass wrote:
> > Hi Christian,
> >
> > On Sat, 2 Nov 2024 at 13:36, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > >
> > > On Sat, Nov 02, 2024 at 01:33:10PM -0600, Simon Glass wrote:
> > > > Hi Christian,
> > > >
> > > > On Wed, 2 Oct 2024 at 16:55, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > On Tue, 1 Oct 2024 at 06:25, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > > > >
> > > > > > Implement LED boot API to signal correct boot of the system.
> > > > > >
> > > > > > led_boot_on/off/blink() are introduced to turn ON, OFF and BLINK the
> > > > > > designated boot LED.
> > > > > >
> > > > > > New Kconfig is introduced, CONFIG_LED_BOOT to enable the feature.
> > > > > > This makes use of the /options/u-boot property "boot-led" to the
> > > > > > define the boot LED.
> > > > > > It's also introduced a new /options/u-boot property "boot-led-period"
> > > > > > to define the default period when the LED is set to blink mode.
> > > > >
> > > > > BTW could you please send a schema update for this so that Linux accepts it?
> > > >
> > > > I'm just checking that you did this?
> > > >
> > >
> > > Yep [0]. Also tagged Rob 2 hours ago. (eh the coincidence)
> > >
> > > Tell me if I should send it with usual way with a dedicated mail. (any
> > > hint on the mailing-list address?)
> >
> > OK great! Yes, once it lands, please send a patch to bring it into U-Boot
> >
> > Regards,
> > Simon
> >
> > > [0] https://github.com/devicetree-org/dt-schema/pull/144
>
> I'm confused what kind of patch I should send to U-Boot?

Something to add the binding to U-Boot also. See my patch at [1]

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20241103003322.626036-26-sjg@chromium.org/
