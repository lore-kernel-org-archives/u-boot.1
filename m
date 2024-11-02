Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17333E67816
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 01:40:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E52F8906A;
	Sun,  3 Nov 2024 02:40:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hsLbwd7k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 543F189066; Sat,  2 Nov 2024 20:50:29 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A687890B9
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:50:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5cacb76e924so3826383a12.0
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730577026; x=1731181826; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T8jP8aIOVQNsjT+YpunsUWxsYPUfZl/FTEy0omAp9m8=;
 b=hsLbwd7koASeDEEI72ME65uiqSNJ4d4rbiILK8CnrlJ8UY5d4nAtf1hg6KuyLzThmi
 Ya22ib67ecc+StWzq9/RahecRE2hcJ5wdBwIF1g+B3P6JErS8Don9e2J12jj3AXdr97S
 HkXQv0DOkicv2UVVQqp4osQjMVcOcDg+1ybAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730577026; x=1731181826;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T8jP8aIOVQNsjT+YpunsUWxsYPUfZl/FTEy0omAp9m8=;
 b=Kloj93qw2/dwtiUzjR5IlHVBd5D7cG+ur9NBn7OoqvOfRYMFeN8lrfXgXCjMTIG5Vw
 F972zbQDiLp0tg9DT0WFNkQkKHFQzF0CAnOUHmO+dWNmy3Hk/yyEK9F22zND9bFrwJi6
 sSpywHeH39E5bglUzVR3XZdY+hRX3XCkqokHCmP63giIJCE2d7gEvDsUl3WVlvLkVtZA
 8+PpCUEb5yg7TVx9cF6Z/r9qYJ/lc7OSz5yZAdqFww5OihxxhjEP8AvxySoL+TzwhqF2
 Ydzj5NuQF9b90U130MXNXnnq7fKJ60NmAOTOyF+hGewglS5Ed83pMT8cyNHbBv1w4BcF
 EqiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaM1FqyNmlxqPw8/6TEqguULV9v8wEbs1mMuld3c5N9Zf1Psv58hJTbigVwAt71/xna/CSX4M=@lists.denx.de
X-Gm-Message-State: AOJu0YxjuVJ5pkIwF+jWby5objg5JSssEEmlF1cdMLiEGFAfD/TKEIxZ
 w3P9XWajKxAMbeszIWWwoi1PEhn+SWu8OnevMr9D2YFrS5thPDAsKTOXsSEFH9WlUfNueavcWHm
 oETBEWI75fZQ5iNhvXq5KnfrOU3FRK2FdP4s4
X-Google-Smtp-Source: AGHT+IERN/qwC/62YiH6GqTXvqsctGZAY3t8ziurO4TAOVUG+VaXARhQpGpnv2AWTZ7A3g+GQQLmBl0wFB/MtohQFgI=
X-Received: by 2002:a17:907:2d91:b0:a9a:80cc:c972 with SMTP id
 a640c23a62f3a-a9e655a8980mr692509666b.27.1730577025470; Sat, 02 Nov 2024
 12:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
 <20241001122511.8832-4-ansuelsmth@gmail.com>
 <CAFLszTjB4OV-k65rhqJ9pBTmKUnnWthbDJ2Vk3eRxzBgmMeOOg@mail.gmail.com>
 <CAFLszTh9WYnya=8YXXFEcSuVUYuhCGy-+iYFRucgMZq+-1H5UQ@mail.gmail.com>
 <67267f36.df0a0220.87602.7b89@mx.google.com>
In-Reply-To: <67267f36.df0a0220.87602.7b89@mx.google.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Nov 2024 13:50:13 -0600
Message-ID: <CAFLszTgP5r56eCTGuG4fbga7Wj8iU97dQZmcvw4ze0UBOhRj1g@mail.gmail.com>
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
X-Mailman-Approved-At: Sun, 03 Nov 2024 02:40:26 +0100
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

On Sat, 2 Nov 2024 at 13:36, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> On Sat, Nov 02, 2024 at 01:33:10PM -0600, Simon Glass wrote:
> > Hi Christian,
> >
> > On Wed, 2 Oct 2024 at 16:55, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > On Tue, 1 Oct 2024 at 06:25, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > >
> > > > Implement LED boot API to signal correct boot of the system.
> > > >
> > > > led_boot_on/off/blink() are introduced to turn ON, OFF and BLINK the
> > > > designated boot LED.
> > > >
> > > > New Kconfig is introduced, CONFIG_LED_BOOT to enable the feature.
> > > > This makes use of the /options/u-boot property "boot-led" to the
> > > > define the boot LED.
> > > > It's also introduced a new /options/u-boot property "boot-led-period"
> > > > to define the default period when the LED is set to blink mode.
> > >
> > > BTW could you please send a schema update for this so that Linux accepts it?
> >
> > I'm just checking that you did this?
> >
>
> Yep [0]. Also tagged Rob 2 hours ago. (eh the coincidence)
>
> Tell me if I should send it with usual way with a dedicated mail. (any
> hint on the mailing-list address?)

OK great! Yes, once it lands, please send a patch to bring it into U-Boot

Regards,
Simon

> [0] https://github.com/devicetree-org/dt-schema/pull/144
