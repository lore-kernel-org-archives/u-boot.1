Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B595C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 17:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EFC787FE7;
	Mon,  4 Mar 2024 18:46:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IC+81/7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6000388007; Mon,  4 Mar 2024 18:46:19 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 212A786F6E
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 18:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412bcca7c56so4157195e9.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 09:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709574376; x=1710179176; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XqaX9TRoTXLZmg1W/ytQYcCq6uL8Oy0vbwdW02KNBhU=;
 b=IC+81/7KBHNiYmq+0QPUA2hMgVrZHWeRllNbgjJSrvtkXcJuulKvADmZlQYqESiq1x
 XbGYCfWFmT2mTanbGZh37yCXGCe6MH+lArF6vi3z02+eiB4poeNfo6LcOwJ5yf4O1sNl
 EenXpsD1h3TyZAniZMj3lB16YRTHguOSyL2iUlQ8mkBYhFy0f2gfURAPzg92TtF0v7uo
 J9hwH8Sydxo4EfoQ7XlJlebZTYhU7WoeJFYFJ21QHIm1texobT0AUkehIHfyKnh0sT4d
 VvjuYET5bZZi/4byYHDJqo9gAtCLc7f8eTsI+SWMQIsni43jO3Atqg4QA+FvzGwRQZex
 4aCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709574376; x=1710179176;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XqaX9TRoTXLZmg1W/ytQYcCq6uL8Oy0vbwdW02KNBhU=;
 b=Dr5c4IrQolb6osaD1LrlE4Cao8C2Upb/WLm7xsbz5x5gryVyRJC5FbbNgOogqFI2bB
 50mxC/VbVVj01SX8A10PlbWK+/aTINuMKhZTwDjdyXZu1C93kzGIdSlibcBZ0mxySODQ
 esDlVC2GmeHSCB4i2CBuIsXacSbgf6wRlw6hpozMd5DgyuwLUnfCIdov7kaCynguxKQE
 NjGRQ9Uukiqdrb78xagxFMujD6C024J13Lp6Wl1DOTuR53smAl1x4WdtiH68hWFdPk7d
 i8tmDhxXeVZkLHEpM/tZwFRRwvRhy8ejt+wECe6Ujsi9J6aTdCNqHCE0YDUNq/YiPHDu
 JlQQ==
X-Gm-Message-State: AOJu0Yxpj35Q3bw+5V8IAfO6k9v9qten5cUu3UWc6Tk17+nisOw7jod4
 fTUM++nwavpp5HTbTgLlR68Y2letDwmkyv4gf/8UgDyH6Lo4wIucB7vchGpAYIGS6mZ9qtBdbYV
 C7kPBMPvkcslwUa44KqG7m8FL9pE=
X-Google-Smtp-Source: AGHT+IFqy85FxY7urdoZi8z5Gd47sLsZxcmbQJhjd/HDEAz3iJNu99l8ahwxw9+ghluNUhFpd7FkTbsF1mFMqgIdlrk=
X-Received: by 2002:a05:600c:3b25:b0:412:b2af:2632 with SMTP id
 m37-20020a05600c3b2500b00412b2af2632mr8205193wms.0.1709574376371; Mon, 04 Mar
 2024 09:46:16 -0800 (PST)
MIME-Version: 1.0
References: <20240302220108.720637-1-igor.opaniuk@gmail.com>
 <CAC_iWjK+f-ZBKT=Mf6629HxV=NCgoZ_taRMFhGK04aA1Xw-BCA@mail.gmail.com>
In-Reply-To: <CAC_iWjK+f-ZBKT=Mf6629HxV=NCgoZ_taRMFhGK04aA1Xw-BCA@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 4 Mar 2024 18:46:04 +0100
Message-ID: <CAByghJaUhhpL4n53k_1=qaa+en_8i1y5J361TsCE1fhNJKxeFQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] TEE: minor cleanup
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>, 
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Roger Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Ilias,

On Mon, Mar 4, 2024 at 12:16=E2=80=AFPM Ilias Apalodimas <
ilias.apalodimas@linaro.org> wrote:

> Hi Igor,
>
> On Sun, 3 Mar 2024 at 00:01, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
> >
> >
> > - Address some spelling errors and typos
> > - Support CMD_OPTEE_RPMB for SANDBOX configurations and add python test=
s
> > - Remove common.h inclusion for drivers/tee
> >
> > Changes in v2:
> > - Fixed chimp_optee.c:37:9: error: implicit declaration of function
> 'memset'
> > - Applied R-b and T-b tags
>
> https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/19808
> this seems to have a few failures
>
> Cheers
> /Ilias
> >
> > Igor Opaniuk (5):
> >   tee: optee: fix description in Kconfig
> >   tee: sandbox: fix spelling errors
> >   cmd: optee_rpmb: build cmd for sandbox
> >   test: py: add optee_rpmb tests
> >   tee: remove common.h inclusion
> >
> >  cmd/Kconfig                        |  4 +++-
> >  drivers/tee/broadcom/chimp_optee.c |  3 ++-
> >  drivers/tee/optee/Kconfig          |  2 +-
> >  drivers/tee/optee/core.c           |  1 -
> >  drivers/tee/optee/i2c.c            |  1 -
> >  drivers/tee/optee/rpmb.c           |  1 -
> >  drivers/tee/optee/supplicant.c     |  2 +-
> >  drivers/tee/sandbox.c              | 10 +++++-----
> >  drivers/tee/tee-uclass.c           |  1 -
> >  test/py/tests/test_optee_rpmb.py   | 20 ++++++++++++++++++++
> >  10 files changed, 32 insertions(+), 13 deletions(-)
> >  create mode 100644 test/py/tests/test_optee_rpmb.py
> >
> > --
> > 2.34.1
> >
>

I've sent v3.

CI build with python tests passing successfully:
https://dev.azure.com/igoropaniuk/u-boot/_build/results?buildId=3D28&view=
=3Dresults

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
http://ua.linkedin.com/in/iopaniuk
