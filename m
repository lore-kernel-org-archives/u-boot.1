Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7970CC47258
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 03:43:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D375D87CC2;
	Fri,  2 Feb 2024 04:43:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MWXjZz+O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 009DA87CC4; Fri,  2 Feb 2024 04:43:14 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D135687CB9
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 04:43:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2cf33035d1dso16357681fa.2
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 19:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706845391; x=1707450191; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1dyMuOcsjJZ9gy8yYjsHSIo5uD0fCqjVk02tVXwCwbI=;
 b=MWXjZz+O3IE1Acc5Bya3w7FsT0NFiGoYWYAqIXt3cUhDD3DgZ2wHZbjl1pWsIYNgXr
 FTU+IXYUQNJcKfOmELb1Uy0yAEZaMCWXegnr9XzkTWEAqDk2xlvzPZDRjHbUHoXBhNLU
 U7p2EScPj5s7ZsQYAKJ4/XZZb6Jxe9fgvazI5IQthcChckBeL2xeUE/WZF8nGWWzUNFA
 J8LR7fNyzUTQ8m/ccg0RmqtkQ728b0ho80XYSCEkGPpIY1YkCLP1sCFngg6iq7opSL+5
 FbN7CwjuR+rWE/FrAGTtH2MDIpQVpmbRmMEPh8PHuyz/bdvIToErsbs6mm7jIWi+8oez
 S30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706845391; x=1707450191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1dyMuOcsjJZ9gy8yYjsHSIo5uD0fCqjVk02tVXwCwbI=;
 b=Iug+qDgFvIzgaECUrmqHeSlpxtEn8/jJ+6TBeiJA12fd21HSHWW9h2KbZxIvytbywh
 ++7SlDL8Wuak9xpaEIXwV7xMvq1RpxRvbu+RpQ2M8t2RcxV6GthjA9sHBWkWqwM1l3s7
 W2BguVXgDuQOoWnVBRVpp3PugP9/Hs3YT8OrICSqS8TcPOdd2ZSNe1gI+eRzaIjQ8GBX
 d5qLEDSHAQ5cI5TZRjE/kOcRPGYv1A26HdNDr3Wd8B9G33QTkxFAiDk8a+PKTF5ZvGsF
 hCXszWfpoUAVVxq05zr2urWBnGWwqfj8/wAqHFl9ehQYaCb+hM6KAadqXrQMNTTYaxXZ
 Kjdg==
X-Gm-Message-State: AOJu0YxHKYBTGbBbAzaA4j5MhUZwxSDVGt0qel8ATxtQCQ6QZ+Y3FZBO
 8PCV0dy9esCXtGayyjCSZaZRHPDBvFo7yC50p3g3FV4NbYIfRAy5L2nDX8vHu6IsI7e6CgWh93z
 s9apT3QrHQXnamqdfl8bU1oiB6OI=
X-Google-Smtp-Source: AGHT+IGycJhHmw701FgZdeqsZZjBW8hKYHZXUPIukHZJcZjVgX7Vs9QSKi7aEUJngDUh6sY9cyvcrh7JvI6rkmKwLOc=
X-Received: by 2002:a2e:b0f7:0:b0:2d0:7fa3:3375 with SMTP id
 h23-20020a2eb0f7000000b002d07fa33375mr382050ljl.31.1706845390414; Thu, 01 Feb
 2024 19:43:10 -0800 (PST)
MIME-Version: 1.0
References: <20240131141426.34926-1-o451686892@gmail.com>
 <20240131141426.34926-2-o451686892@gmail.com>
 <CAL6CDMGrR9YQzs6iLbKmzwMWXYyX15-ngv2vBDbkW-FSfr38kA@mail.gmail.com>
In-Reply-To: <CAL6CDMGrR9YQzs6iLbKmzwMWXYyX15-ngv2vBDbkW-FSfr38kA@mail.gmail.com>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Fri, 2 Feb 2024 11:42:59 +0800
Message-ID: <CAHk0Hos6PozkGtbqZw1aDUfHJD6wTTiKW=5R9sND389wOyPa1A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] firmware: psci: Fix bind_smccc_features psci check
To: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Etienne Carriere <etienne.carriere@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
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

Hi Igor,

On Thu, Feb 1, 2024 at 10:36=E2=80=AFPM Igor Opaniuk <igor.opaniuk@foundrie=
s.io> wrote:
>
> Hello Weizhao,
>
> On Wed, Jan 31, 2024 at 3:15=E2=80=AFPM Weizhao Ouyang <o451686892@gmail.=
com> wrote:
> >
> > According to PSCI specification DEN0022F, PSCI_FEATURES is used to chec=
k
> > whether the SMCCC is implemented by discovering SMCCC_VERSION.
> >
> Could you please add more details to your commit message or as a comment
> explaining what exact steps should be done for a full discovery sequence =
of Arm
> Architecture Service functions, so people don't need to search for
> that information explicitly?
>
> For instance:
> Step 1: Determine if SMCCC_VERSION is implemented
> - Use firmware data, device tree PSCI node, or ACPI FADT PSCI flag, to
> determine whether a
> PSCI implementation is present.
> - Use PSCI_VERSION to learn whether PSCI_FEATURES is provided. PSCI_FEATU=
RES is
> mandatory from version 1.0 of PSCI
> Step 2. etc.
>
> I would just pull that info from the latest SMC Calling Convention versio=
n 1.5,
> from 9 Appendix B: Discovery of Arm Architecture Service functions.
>
> Thank you!
> > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> > ---
> > v3: remove fallback smc call
> > v2: check SMCCC_ARCH_FEATURES
> > ---
> >  drivers/firmware/psci.c   | 5 ++++-
> >  include/linux/arm-smccc.h | 6 ++++++
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> > index c6b9efab41..03544d76ed 100644
> > --- a/drivers/firmware/psci.c
> > +++ b/drivers/firmware/psci.c
> > @@ -135,10 +135,13 @@ static int bind_smccc_features(struct udevice *de=
v, int psci_method)
> >             PSCI_VERSION_MAJOR(psci_0_2_get_version()) =3D=3D 0)
> >                 return 0;
> >
> > -       if (request_psci_features(ARM_SMCCC_ARCH_FEATURES) =3D=3D
> > +       if (request_psci_features(ARM_SMCCC_VERSION) =3D=3D
> >             PSCI_RET_NOT_SUPPORTED)
> >                 return 0;
> >
> > +       if (invoke_psci_fn(ARM_SMCCC_VERSION, 0, 0, 0) < ARM_SMCCC_VERS=
ION_1_1)
> > +               return 0;
> > +
> IMO, to fully comply with SMC Calling Convention version 1.5
> we should also check for SMCCC_ARCH_WORKAROUND_1:
>
> From 9 Appendix B: Discovery of Arm Architecture Service functions,
> Step 2: Determine if Arm Architecture Service function is implemented
> - Use SMCCC_VERSION to learn whether the calling convention complies
> to version 1.1 or above.
> - Use SMCCC_ARCH_FEATURES to query whether the Arm Architecture
> Service function is implemented
> on this system <--- we lack of this step

Thanks for your review. The 9 Appendix B describes an approach to
discovery the maximize ability without causing unsafe behavior on
existing platforms. Regarding the second step, it is just using
SMCCC_ARCH_WORKAROUND_1 as an example to test SMCCC_ARCH_FEATURES.

For the U-Boot case, we can revisit this from two perspectives:
1. SMCCC_ARCH_FEATURES is MANDATORY from SMCCC v1.1.
2. SMCCC_VERSION is OPTIONAL for SMCCC v1.0, so we should consider a
safe behavior.
3. U-Boot is using CONFIG_ARM_SMCCC_FEATURES to probe and bind SMCCC
service driver if this driver is reported as supported.
4. U-Boot SMCCC service driver can embed its discovery process in
is_supported() callback.

So now we can choose the following approach in U-Boot:
- Use firmware data (check "arm,psci-1.0") to determine whether a PSCI
implementation is present.
- Use PSCI_VERSION (psci_0_2_get_version() major version >=3D 0) to learn
whether PSCI_FEATURES is provided.
- Use PSCI_FEATURES with the SMCCC_VERSION Function Identifier as a
parameter to determine that SMCCC_VERSION is implemented.
- Use SMCCC_VERSION to learn whether the calling convention complies to
version 1.1 or above.
- Trying to probe and bind SMCCC service driver.

BR,
Weizhao

>
> >         if (psci_method =3D=3D PSCI_METHOD_HVC)
> >                 pdata->invoke_fn =3D smccc_invoke_hvc;
> >         else
> > diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> > index f44e9e8f93..da3d29aabe 100644
> > --- a/include/linux/arm-smccc.h
> > +++ b/include/linux/arm-smccc.h
> > @@ -55,8 +55,14 @@
> >  #define ARM_SMCCC_QUIRK_NONE           0
> >  #define ARM_SMCCC_QUIRK_QCOM_A6                1 /* Save/restore regis=
ter a6 */
> >
> > +#define ARM_SMCCC_VERSION              0x80000000
> >  #define ARM_SMCCC_ARCH_FEATURES                0x80000001
> >
> > +#define ARM_SMCCC_VERSION_1_0          0x10000
> > +#define ARM_SMCCC_VERSION_1_1          0x10001
> > +#define ARM_SMCCC_VERSION_1_2          0x10002
> > +#define ARM_SMCCC_VERSION_1_3          0x10003
> > +
> >  #define ARM_SMCCC_RET_NOT_SUPPORTED    ((unsigned long)-1)
> >
> >  #ifndef __ASSEMBLY__
> > --
> > 2.39.2
> >
>
>
> --
> Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations
>
> Igor Opaniuk
> Senior Software Engineer, Embedded & Security
> E: igor.opaniuk@foundries.io
> W: www.foundries.io
