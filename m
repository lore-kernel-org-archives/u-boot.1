Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B69C0218A
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 01:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D3B180812;
	Fri, 31 Jan 2025 02:26:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T5FWRW98";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 822F780F50; Fri, 31 Jan 2025 02:19:38 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09D4D80F44
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 02:19:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kikuchan98@gmail.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e3a26de697fso1818305276.3
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 17:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738286375; x=1738891175; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QoCofEUQPGscNqCUjAu7BGgefYffbWF/gutL/naA/3w=;
 b=T5FWRW98zS2n1KJ6erx1tEmuijl7QVj9viy6UzK3dfdY0B8Wbr+jQ28aX4hbwAtoBc
 oxwW9kgxE/1JRveYlsS1NU8de+Pd9hR0FuepvEdu0yVwJKo2hpjHhdfXO72m2IDGMO1K
 jmYSiUkyDKXmBw8ftVBikpM3YbCbgx2K376t7DpggABGP2sgMsLnSRqNSDiWYnCth6tp
 yv3wZVGjefRCsByZq4TUI9c+5LuZHRA57EYLPP1SmR5dpVMNkuls3j5KOB4xEPgOR49E
 lqnY5KWdDNs1Kly7A+Ttfx78N7hdSbiQgEakJa4wE0raPvbWaVTwzUg6WcQYFJqNtBSv
 b1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738286375; x=1738891175;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QoCofEUQPGscNqCUjAu7BGgefYffbWF/gutL/naA/3w=;
 b=fOX4zxyuryfxTVeQ9+DAoeHQ7lpZgBAwWGPyIgyiCh3HSBd4UrNV04+cH5F22q5/GX
 DiSe7vfFFtAIAnxMCBAkOJwnklXWZqWEHZiSo7pfSYAPJLtDQvdfjpYxVrQxCbV7eU12
 +agvFRq0KgB+yOsvQP9r7bNKa2wcvFWqwCJ4vIM8jxaREzNWAg0PRvNPqak0+Gs8L6+L
 J6Tj4Hl5K/gWWvKRhvr2sKO65yz2GRzetKqfEKDW5qzPcCJgz+6BDcgbOOq8gwvP8rMX
 g1kpvfeSpL7Zn3gEEIOmijH0qPfro6HuzhVIcTqxoz6N2XEUNZwOWBjC+ZH4HNPZXyo6
 O7Lw==
X-Gm-Message-State: AOJu0YwzGxXSjnCZN+YoPJHdvq+Scc6l548eMD8h4GqQZ1MYVRKnsSzX
 AomRA101k9bkrEmIZPTK8Znewo6soLrV9EZZa1b9ohmbtaN/nYahI6mZpPN0nmyy5GhGN9tt+su
 yMv7ENCVp1TdWWKInVDpPc+Ea2nY=
X-Gm-Gg: ASbGncuS6tlsevUktve2jCT9KlcuuaBch7o1IzkPz720o5fYVr1ZxeuviZFnjMhMtoo
 rJTBoQoKbObhi1LPWUpBhwfyWbv0L75qYBthAlRvLO4X7BB40+DqehTYC4cmm+d9wEf7Vte388u
 TQ7cwPm0GkHOA7/AddrZ25+2Awq+P4
X-Google-Smtp-Source: AGHT+IG4j973dFSbfrL7AmcjEUtni2YmHm2cS5ZH/AvpQtQ8kDX6eJ6/uwinrNLEELg1C+qWgMCJ1LwLmVxrVnz8gHQ=
X-Received: by 2002:a05:6902:15ce:b0:e53:71dc:667b with SMTP id
 3f1490d57ef6-e58a4bc4685mr7825388276.39.1738286374891; Thu, 30 Jan 2025
 17:19:34 -0800 (PST)
MIME-Version: 1.0
References: <20250107092544.1798497-1-kikuchan98@gmail.com>
 <20250129200133.GA2165390@bill-the-cat>
In-Reply-To: <20250129200133.GA2165390@bill-the-cat>
From: Hironori KIKUCHI <kikuchan98@gmail.com>
Date: Fri, 31 Jan 2025 10:19:24 +0900
X-Gm-Features: AWEUYZnp48GxwwCbTg_eQ33vXEnTN1bTtYkE0I2qybySOSsOT4e9ghslYChK4CA
Message-ID: <CAG40kxGj3fLH_guZvF3vV1fJjB+05CkKcgnS7PcPObAtBsEm3g@mail.gmail.com>
Subject: Re: [PATCH 0/2] spi: soft_spi: Add support for SPI_3WIRE
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, 
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Dominik Wernberger <dominik.wernberger@gmx.de>, 
 Custom IDEAS <vanbaren@cideas.com>, Software Engineering <wd@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 31 Jan 2025 02:26:57 +0100
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

Hello Tom,

Thank you for the feedback!

I don't know why but the issue I had has been gone now...
Maybe it was some mistake, I'm so sorry.

I'll post v2 patch, without touching `dm_spi_claim_bus`.

Regards,
kikuchan.


On Thu, Jan 30, 2025 at 5:01=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Tue, Jan 07, 2025 at 06:25:38PM +0900, Hironori KIKUCHI wrote:
>
> > Add support for SPI_3WIRE on soft_spi driver.
> >
> > Hironori KIKUCHI (2):
> >   spi: spi-uclass: Fix dm_spi_claim_bus()
> >   spi: soft_spi: Add support for SPI_3WIRE
> >
> >  drivers/spi/soft_spi.c   | 19 ++++++++++++++++---
> >  drivers/spi/spi-uclass.c |  2 +-
> >  2 files changed, 17 insertions(+), 4 deletions(-)
>
> This unfortunately breaks the existing tests:
> https://source.denx.de/u-boot/u-boot/-/jobs/1008400
>
> --
> Tom
