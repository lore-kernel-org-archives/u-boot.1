Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED53C5478C
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 22:02:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76C8187EE0;
	Sat,  2 Mar 2024 23:02:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xw2s0+FD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B580C87EE7; Sat,  2 Mar 2024 23:02:49 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67D8D87D97
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 23:02:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33e12bcf6adso974205f8f.1
 for <u-boot@lists.denx.de>; Sat, 02 Mar 2024 14:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709416967; x=1710021767; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RhSgUzi/HSzJT2BDf58iZeFu0zkWVHHqYbXNSrkdQqw=;
 b=Xw2s0+FDGXRJ6c5W6N6mMC6FhE5cwInJ/Yg5B4tjesBtkX1enLkjW8rXu5vbtlIfH5
 f70iY+jH+Y3KBj/KNSYgylTQ5s6akSQXZz5XjPN8WSBN0IJoNDRPxHXrp0EyaI3I8s84
 GdbUlwDhANA7s1K2hBxCeL3d+FzK+KzCe2u8KFp7u4aZYzNpDFlyAyxoQl1X37V4NJpx
 gFIkAt8Mj6gq9S/DDtVEGa2Pg8KjgKI892oz2cmGPTg+pUjHPkH3P3e8f5PZm7enJ7gj
 vS5SrXTAQSc3mm7OXaafQhIAcMA1APJuZwjYUEtbR2F+ReUO52KU2I+2S4iYmQB4q9X4
 /qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709416967; x=1710021767;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RhSgUzi/HSzJT2BDf58iZeFu0zkWVHHqYbXNSrkdQqw=;
 b=dOKdN1ECaGWJaz7PJoe6i4r1idWohPRBMjuGF+AOuQ5DukxY07GMz2ayB+flJHUiEo
 iUjPxPA787lJtt4oW3LtoBCqN+n4iBHzu1DrqT2kqd5rV0jPAdbSwKe7e63O5uqyDrV2
 YUWouxmHgWdFPxbPjIs0FRpbUy5o9WRXFXzGXdW2uxYr0jPYm6opDuj2qdsF7MPjEdwz
 vfsr6npXg2Y4D6bNGBjQpyyEIDiQUNuUgHrM607nE3f8CJLphahMcx3JgT+miJcR61Rz
 OrOUE8HlrFJx8V+6BHPlQAAUFC7tKhZPI1TUNH0q+54JfKtFD5iz5KbbU/IqBGUc2htD
 W09A==
X-Gm-Message-State: AOJu0YwweBiquDk65UXJwzDLuuaiVBJR+4M7MY2TALzIiH0B+azUbUlK
 K3yIBx82fZI30cnmyMas7eid+0XOTDFIfRVd6rxUOgtrBO9A0uHi1a6DL69PQgiJ2T1qV72zFj+
 NvyqLt9pdoTzCU8UNOumLGIiklnE=
X-Google-Smtp-Source: AGHT+IEJi3MGl5xKoX+BQULnWCcPcII/+FACtLuVdj2O3wWkvX2n1uEAxkqNmwq8Ln0oXSIzV0Xkn7TSDq3NbS2JyGs=
X-Received: by 2002:a05:600c:1c8a:b0:412:a0a3:cea with SMTP id
 k10-20020a05600c1c8a00b00412a0a30ceamr4294023wms.1.1709416966609; Sat, 02 Mar
 2024 14:02:46 -0800 (PST)
MIME-Version: 1.0
References: <20240214183444.493629-1-igor.opaniuk@gmail.com>
 <CAByghJY_Eyf6s=V+5Hjo1gVxkzCPieABkk_NpFK5HM_K=SE_+g@mail.gmail.com>
 <CAC_iWjJv-v0pu9cZza0WghJ-rPJdD8Lmng_ms7d17a=K4nSzjw@mail.gmail.com>
In-Reply-To: <CAC_iWjJv-v0pu9cZza0WghJ-rPJdD8Lmng_ms7d17a=K4nSzjw@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Sat, 2 Mar 2024 23:02:34 +0100
Message-ID: <CAByghJaTbGGOvcQghGKUuQKSnrLrKR0-X-833yAmo7fmETn_sw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] TEE: minor cleanup
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

Hello Ilias,

On Fri, Mar 1, 2024 at 10:41=E2=80=AFAM Ilias Apalodimas <
ilias.apalodimas@linaro.org> wrote:

> Hi Igor,
>
> On Thu, 29 Feb 2024 at 21:11, Igor Opaniuk <igor.opaniuk@gmail.com> wrote=
:
> >
> > Hi Ilias,
> >
> > On Wed, Feb 14, 2024 at 7:34=E2=80=AFPM Igor Opaniuk <igor.opaniuk@foun=
dries.io>
> wrote:
> >>
> >> - Address some spelling errors and typos
> >> - Support CMD_OPTEE_RPMB for SANDBOX configurations and add python tes=
ts
> >> - Remove common.h inclusion for drivers/tee
>
> CI fails on
> https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/19780
> Can you have a look?
>
I've fixed and sent v2, thanks!


>
> Thanks
> /Ilias
> >>
> >> Igor Opaniuk (5):
> >>   tee: optee: fix description in Kconfig
> >>   tee: sandbox: fix spelling errors
> >>   cmd: optee_rpmb: build cmd for sandbox
> >>   test: py: add optee_rpmb tests
> >>   tee: remove common.h inclusion
> >>
> >>  cmd/Kconfig                        |  4 +++-
> >>  drivers/tee/broadcom/chimp_optee.c |  2 +-
> >>  drivers/tee/optee/Kconfig          |  2 +-
> >>  drivers/tee/optee/core.c           |  1 -
> >>  drivers/tee/optee/i2c.c            |  1 -
> >>  drivers/tee/optee/rpmb.c           |  1 -
> >>  drivers/tee/optee/supplicant.c     |  2 +-
> >>  drivers/tee/sandbox.c              | 10 +++++-----
> >>  drivers/tee/tee-uclass.c           |  1 -
> >>  test/py/tests/test_optee_rpmb.py   | 20 ++++++++++++++++++++
> >>  10 files changed, 31 insertions(+), 13 deletions(-)
> >>  create mode 100644 test/py/tests/test_optee_rpmb.py
> >>
> >> --
> >> 2.34.1
> >>
> >
> > Are there currently any comments/objections that can prevent these
> cosmetic
> > changes from being applied? If there are - just let me know, thanks
> >
> > Regards,
> > Igor
> >
> > --
> > Best regards - Atentamente - Meilleures salutations
> >
> > Igor Opaniuk
> >
> > mailto: igor.opaniuk@gmail.com
> > skype: igor.opanyuk
> > http://ua.linkedin.com/in/iopaniuk
>


--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
http://ua.linkedin.com/in/iopaniuk
