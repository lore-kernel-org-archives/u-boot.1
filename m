Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B57EC54798
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 19:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A01DB880FC;
	Thu, 29 Feb 2024 20:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qmz9eVQf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEAA6880FD; Thu, 29 Feb 2024 20:25:24 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED119880F5
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 20:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-563d56ee65cso2139005a12.2
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 11:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709234722; x=1709839522; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SPbaaOfDW8z1tHHZbd2XvDq2HKCjnXFky8dUmPaA3eM=;
 b=Qmz9eVQfK4BL8rx7m42/7/bpplrMGfkICWLMxGfAVWRMMe3C1+CetMkk6A2ksmKG/O
 p97OykpdhvLngxV0NWYvq4FqY8j0OmZAYvfbrdgCnqqMLZSR54StDyJyIKPCLB5CD3kf
 e8JgTWHfFPSTsu3zj+tq5Nvu/RBnxN7NufyqLA5psJIPS+0f/DIrlg1T/xyqxv4n64yP
 Ob4ceKnBP3KC+taNNKKnnTa6loJkkU12tSBUFESSv9PkMUn8ZnIYaZYHAd++1KXiW5LY
 28E/Pfbi4f6UP9g5mgq+jOtU1xi+aSAikbmaUKXiT/iyG5DBJkR1IPwAU1DhESjIXf33
 pfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709234722; x=1709839522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SPbaaOfDW8z1tHHZbd2XvDq2HKCjnXFky8dUmPaA3eM=;
 b=nSY3CYBnhw6ZWPZNr6ZygCSiay9UHYAM4FYElMC/+QXN87l1FmHFwhJt1oF1jeZX+V
 oVFAf7SUapyfshUpvUHsV6dp7BsNvnVcvL3UPa0CLVzsqa1Wy1gwKWwFvYzL4ZmThKFr
 0298E/r157h7fGsuWdt1F9KrbRZ0Bk9FUmRF+8ehvUIjeJNLvRDAPW6eJosFCRZ53ukS
 3VXpMu6Rp1p2jJbb5I4XRmL1eCZ6nhD7xYM9F64Q2SCg1awfyzTvzXyVdQj+QUKAky+x
 iJL+EOLIbSmlTd3MlPyR3NyWokSR3XxjG1jGokL+z7zNtDrWTOHmUVsBsc6IqS4dq0Sf
 owCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUS+8z4T7r/wByV7GFzCrfyFCfoEQ4zT0wg1mB7yIz/2hQ5DNFfA3IhO6CxBu8b0LP0WLJfNJzK4EvsUq6Wf0Vrwh9+g==
X-Gm-Message-State: AOJu0Yw+uquUEq/u7YUdjnkkqJMvTlMArh/VwOgxPcUIMkroWZzGEPCa
 0jpxfc6rr/YP11RLGAyvsvIB332TgiDkPtJ0r3psP7bIowdrrNH67oOAVt0ACZGIW8rn3sNr9+5
 mChg/TK/Zp6hbtsIzz4u0o2oYbig=
X-Google-Smtp-Source: AGHT+IFtzW3NGgVb3PQVwzMjkrlPDMWAw9SAVKu08WhjyP/ar+oWXxCejGbsb8CAhXonB2ACEiwrKu5vX5hjALF5yO0=
X-Received: by 2002:a05:6402:901:b0:565:c34f:df4e with SMTP id
 g1-20020a056402090100b00565c34fdf4emr2336818edz.29.1709234722147; Thu, 29 Feb
 2024 11:25:22 -0800 (PST)
MIME-Version: 1.0
References: <20240214183444.493629-1-igor.opaniuk@gmail.com>
 <CAByghJY_Eyf6s=V+5Hjo1gVxkzCPieABkk_NpFK5HM_K=SE_+g@mail.gmail.com>
In-Reply-To: <CAByghJY_Eyf6s=V+5Hjo1gVxkzCPieABkk_NpFK5HM_K=SE_+g@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 29 Feb 2024 19:25:10 +0000
Message-ID: <CALeDE9NND+LY8MsqPEMXvDDsZwDsyC5Gu+7imPZ6H+XjO1ndyQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] TEE: minor cleanup
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
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

On Thu, 29 Feb 2024 at 19:11, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
>
> Hi Ilias,
>
> On Wed, Feb 14, 2024 at 7:34=E2=80=AFPM Igor Opaniuk <igor.opaniuk@foundr=
ies.io>
> wrote:
>
> > - Address some spelling errors and typos
> > - Support CMD_OPTEE_RPMB for SANDBOX configurations and add python test=
s
> > - Remove common.h inclusion for drivers/tee
> >
> > Igor Opaniuk (5):
> >   tee: optee: fix description in Kconfig
> >   tee: sandbox: fix spelling errors
> >   cmd: optee_rpmb: build cmd for sandbox
> >   test: py: add optee_rpmb tests
> >   tee: remove common.h inclusion
> >
> >  cmd/Kconfig                        |  4 +++-
> >  drivers/tee/broadcom/chimp_optee.c |  2 +-
> >  drivers/tee/optee/Kconfig          |  2 +-
> >  drivers/tee/optee/core.c           |  1 -
> >  drivers/tee/optee/i2c.c            |  1 -
> >  drivers/tee/optee/rpmb.c           |  1 -
> >  drivers/tee/optee/supplicant.c     |  2 +-
> >  drivers/tee/sandbox.c              | 10 +++++-----
> >  drivers/tee/tee-uclass.c           |  1 -
> >  test/py/tests/test_optee_rpmb.py   | 20 ++++++++++++++++++++
> >  10 files changed, 31 insertions(+), 13 deletions(-)
> >  create mode 100644 test/py/tests/test_optee_rpmb.py
> >
> > --
> > 2.34.1
> >
> >
> Are there currently any comments/objections that can prevent these cosmet=
ic
> changes from being applied? If there are - just let me know, thanks

Probably awaiting the next dev cycle, we're post RC3 now so it's
mostly fixes landing ATM.
