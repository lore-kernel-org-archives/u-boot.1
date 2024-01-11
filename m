Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F674C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 13:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66FF487AEC;
	Thu, 11 Jan 2024 14:13:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DR/mH4re";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61B6587AEC; Thu, 11 Jan 2024 14:13:32 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E061380844
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 14:13:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-556c3f0d6c5so6267949a12.2
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 05:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1704978809; x=1705583609;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=StLbeN3ZNFYXrfv0KmdxRESMl1bFe0bZXV5OijdvzgU=;
 b=DR/mH4re33gyR5VBzYTmVsqXeAPqLDzjizaVSAwrW0/NAqSTtyExGUwc0+t/Xr11Ch
 lOkfpoCAyhzYv6/KkrsrLv4pRceFVKjayMNRLeZLCSa6EH12LQUnm/ban4pHxpOk88MD
 IWegWMs65cBcsn1rEMi1Cy1aqFUNjoeECoFjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704978809; x=1705583609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=StLbeN3ZNFYXrfv0KmdxRESMl1bFe0bZXV5OijdvzgU=;
 b=HgmhhdhbAslJwNpYiGKoPp4IqIRDjuOPlpTqyRkN4UhzlC2UiDbHudP6wyAvy1crRb
 QTjiaWvZWy7vqCrwwiVygsL+HKWu1CJydjGwfymKAnGA98Era8udtD5nYSifemq/f07M
 D8ZQUp7gTMWuEjEVFnXU5kw+5V5WhajvjU5DH5C0q83Bfd6UfR8DUS0g91yShhusOr77
 giUR1NGQU3KB8ujPnCbPzreHeJMi78TQnG6TUhuAdeVdP/qpfk69D19ZGi/erLUsYdGs
 /CHXmXz70Wlbrje4NwTA1yEvLZ2hs2pa6kBqbO170q1KeUnhWb08TLOj/Urr6HMEx880
 V/Bg==
X-Gm-Message-State: AOJu0YyCmw2v9U//Ifz5FM10R0jqMOBTuNr5dG6F0K7e9HweRbwOBfbF
 zB2WD1eZq4Kaa6ideMbp9hRhO9XYpEi9LJm6/mmaaHJY03aQ5Q==
X-Google-Smtp-Source: AGHT+IFog6169FTxJ9E8T0TZiTUsl8qyGv2X7CLsBJQWHlmUIE4WMKz+B97lde4xwnsroFpYPwYe5x6c+Uh8CuCdsNs=
X-Received: by 2002:a05:6402:326:b0:553:83ca:60c5 with SMTP id
 q6-20020a056402032600b0055383ca60c5mr408150edw.3.1704978809313; Thu, 11 Jan
 2024 05:13:29 -0800 (PST)
MIME-Version: 1.0
References: <20231211114600.4414-1-rogerq@kernel.org>
 <5d79b1c8-4dc8-44d3-bfe7-4514f41c7102@kernel.org>
In-Reply-To: <5d79b1c8-4dc8-44d3-bfe7-4514f41c7102@kernel.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 11 Jan 2024 14:13:16 +0100
Message-ID: <CAOf5uwn6Q24OcrwHBEbSJhvkX2MV46ea+EZa7yOBDN6WZrw5Dw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mtd: nand: omap_gpmc: Fix NAND for AM335x
To: Roger Quadros <rogerq@kernel.org>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heiko Schocher <hs@denx.de>, 
 "Leto, Enrico" <enrico.leto@siemens.com>, Tom Rini <trini@konsulko.com>, 
 "Bajjuri, Praneeth" <praneeth@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh R <vigneshr@ti.com>, U-Boot-Denx <u-boot@lists.denx.de>
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

Hi

Il gio 11 gen 2024, 14:06 Roger Quadros <rogerq@kernel.org> ha scritto:

> Hi,
>
> On 11/12/2023 13:45, Roger Quadros wrote:
> > Hi,
> >
> > These patches fix NAND and ELM for AM335x and related legacy platforms
> > that use HW BCH and ELM modules.
> >
> > All CI tests pass: https://github.com/u-boot/u-boot/pull/453
> >
> > Changelog:
> >
> > v2:
> > - added __maybe_unused to omap_calculate_ecc_bch. fixes CI tests
> > - Added Tested-by Tags
> > - Explained about omap_elm single sector support in commit log
> >
> > cheers,
> > -roger
> >
> > Roger Quadros (2):
> >   mtd: nand: omap_gpmc: Fix NAND in SPL for AM335x
> >   mtd: rawnand: omap_elm: Fix elm_init definition
> >
> >  drivers/mtd/nand/raw/omap_elm.c  |  4 +-
> >  drivers/mtd/nand/raw/omap_elm.h  |  6 --
> >  drivers/mtd/nand/raw/omap_gpmc.c | 95 ++++++++++----------------------
> >  3 files changed, 31 insertions(+), 74 deletions(-)
> >
> >
> > base-commit: 2f0282922b2c458eea7f85c500a948a587437b63
>
> If no objections can this be Acked and picked up please?
> Without these NAND is broken on some TI platforms.
>


We will queue them and send over the weekend

Michael

>
>
>
> Thanks!
>
> --
> cheers,
> -roger
>
