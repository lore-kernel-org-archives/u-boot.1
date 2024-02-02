Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29909C4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 21:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B92C87E50;
	Fri,  2 Feb 2024 22:19:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="ERp2b/3Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A62E87E51; Fri,  2 Feb 2024 22:19:09 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECD4287E23
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 22:19:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2cf328885b4so31499521fa.3
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 13:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1706908746; x=1707513546; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gSdON60VaWpTOCxIFx+KP4pT/cxk5W9+zo/sY2J1YtM=;
 b=ERp2b/3YDDtLcvpqgARjAVwtyYmRlJu2fFNuxnlgT6Rmz7SPmXn88YGi/9maWhwvmB
 eHKtrJoqxNGokF2OBgtzKsNV1PRGhpWRoWVV3rhkEC3RC7C77r6A7xhtj7SecE8E14IT
 BlpAblVGTP4IGOs8dyQNgsxS4cZtZW2zhzJE/A8wD2KYkPtQsSnSDpf4OOv4y13g/P1o
 /nqhCA2inEH8U5d4WAUcWd+lT9qVpwmdp75/LYWeq2xVjNmtmfzncwLW4IuWzmKBy91V
 2qd9gPQXKu2sPyaFdjYiJX8QlhRvmTrCVdi9urSsCBdVvHZ97K/Dso9UL7/SZiGuEGso
 lkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706908746; x=1707513546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gSdON60VaWpTOCxIFx+KP4pT/cxk5W9+zo/sY2J1YtM=;
 b=hZB61yFrRKBfmUAb2HGk4hz25s9ghFlSTJoLs+IfldFSdZ5Sdi3clT/XCPVQGQ0JgO
 0J66fbi/Mf+u+61q0Hspr0y3E94Qhd1EEPwd142KZvQHsQ8hpasuwEnBx42mRsGhkj/w
 KNO3r65AdT4eBGjQBtnnRhFmSTkT+ku+qRUDD9ZuRcEMeHEpAeBMU0uhOLeuHzXzdpbJ
 w0LMI4BNEfKSTwwBe+tqWQe2tLeVHinLD7jLfuPpS/2cUxLFW+A6VcGgD5j6Ug22S/XH
 LlQRSHQ4fSzUqb+knGLgJOoIU6zCfyUBIrsDKANqLbJpzZ5uZeDSw5eqdA8iqwlMcV05
 tyaA==
X-Gm-Message-State: AOJu0Yy4WexZKJtyLM4qAT7m4xpNSjTqFMxQC1QXsEKkAP1ZZYtreP8l
 fJu3z6Nxt4pMXjTkqy+ZsqqeGh+G6e+nLlhex6Acm+dIKLPAEH9uqNECcm138yZh1YX76tXg4rj
 Q4bkdQFYNanzWJ9q99f2BwYki1TBLLb1AUYAk2OAU+kXIYuUjrQ7z2g==
X-Google-Smtp-Source: AGHT+IHQmofH82x1aj7GQGmhOmJbXWtRrBzQjR8/m8h5vhYgUVQEszX4PCmyirVr034+ui0ZtkEeeRMixtgYEn0G8Rk=
X-Received: by 2002:a05:651c:1242:b0:2cf:4e53:7c38 with SMTP id
 h2-20020a05651c124200b002cf4e537c38mr5922222ljh.22.1706908745975; Fri, 02 Feb
 2024 13:19:05 -0800 (PST)
MIME-Version: 1.0
References: <20240131141426.34926-1-o451686892@gmail.com>
 <20240131141426.34926-2-o451686892@gmail.com>
 <CAL6CDMGrR9YQzs6iLbKmzwMWXYyX15-ngv2vBDbkW-FSfr38kA@mail.gmail.com>
 <CAHk0Hos6PozkGtbqZw1aDUfHJD6wTTiKW=5R9sND389wOyPa1A@mail.gmail.com>
In-Reply-To: <CAHk0Hos6PozkGtbqZw1aDUfHJD6wTTiKW=5R9sND389wOyPa1A@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Fri, 2 Feb 2024 22:18:54 +0100
Message-ID: <CAL6CDMG3KT2aTdR2b34ebc+EQKC4CC-f1YG7YQaNzHmNS7HpyA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] firmware: psci: Fix bind_smccc_features psci check
To: Weizhao Ouyang <o451686892@gmail.com>
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

Hello Weizhao,

On Fri, Feb 2, 2024 at 4:43=E2=80=AFAM Weizhao Ouyang <o451686892@gmail.com=
> wrote:
>
> Hi Igor,
>
> On Thu, Feb 1, 2024 at 10:36=E2=80=AFPM Igor Opaniuk <igor.opaniuk@foundr=
ies.io> wrote:
> >
> > Hello Weizhao,
> >
> > On Wed, Jan 31, 2024 at 3:15=E2=80=AFPM Weizhao Ouyang <o451686892@gmai=
l.com> wrote:
> > >
> > > According to PSCI specification DEN0022F, PSCI_FEATURES is used to ch=
eck
> > > whether the SMCCC is implemented by discovering SMCCC_VERSION.
> > >
> > Could you please add more details to your commit message or as a commen=
t
> > explaining what exact steps should be done for a full discovery sequenc=
e of Arm
> > Architecture Service functions, so people don't need to search for
> > that information explicitly?
> >
> > For instance:
> > Step 1: Determine if SMCCC_VERSION is implemented
> > - Use firmware data, device tree PSCI node, or ACPI FADT PSCI flag, to
> > determine whether a
> > PSCI implementation is present.
> > - Use PSCI_VERSION to learn whether PSCI_FEATURES is provided. PSCI_FEA=
TURES is
> > mandatory from version 1.0 of PSCI
> > Step 2. etc.
> >
> > I would just pull that info from the latest SMC Calling Convention vers=
ion 1.5,
> > from 9 Appendix B: Discovery of Arm Architecture Service functions.
> >
> > Thank you!
> > > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> > > ---
> > > v3: remove fallback smc call
> > > v2: check SMCCC_ARCH_FEATURES
> > > ---
> > >  drivers/firmware/psci.c   | 5 ++++-
> > >  include/linux/arm-smccc.h | 6 ++++++
> > >  2 files changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> > > index c6b9efab41..03544d76ed 100644
> > > --- a/drivers/firmware/psci.c
> > > +++ b/drivers/firmware/psci.c
> > > @@ -135,10 +135,13 @@ static int bind_smccc_features(struct udevice *=
dev, int psci_method)
> > >             PSCI_VERSION_MAJOR(psci_0_2_get_version()) =3D=3D 0)
> > >                 return 0;
> > >
> > > -       if (request_psci_features(ARM_SMCCC_ARCH_FEATURES) =3D=3D
> > > +       if (request_psci_features(ARM_SMCCC_VERSION) =3D=3D
> > >             PSCI_RET_NOT_SUPPORTED)
> > >                 return 0;
> > >
> > > +       if (invoke_psci_fn(ARM_SMCCC_VERSION, 0, 0, 0) < ARM_SMCCC_VE=
RSION_1_1)
> > > +               return 0;
> > > +
> > IMO, to fully comply with SMC Calling Convention version 1.5
> > we should also check for SMCCC_ARCH_WORKAROUND_1:
> >
> > From 9 Appendix B: Discovery of Arm Architecture Service functions,
> > Step 2: Determine if Arm Architecture Service function is implemented
> > - Use SMCCC_VERSION to learn whether the calling convention complies
> > to version 1.1 or above.
> > - Use SMCCC_ARCH_FEATURES to query whether the Arm Architecture
> > Service function is implemented
> > on this system <--- we lack of this step
>
> Thanks for your review. The 9 Appendix B describes an approach to
> discovery the maximize ability without causing unsafe behavior on
> existing platforms. Regarding the second step, it is just using
> SMCCC_ARCH_WORKAROUND_1 as an example to test SMCCC_ARCH_FEATURES.
>
> For the U-Boot case, we can revisit this from two perspectives:
> 1. SMCCC_ARCH_FEATURES is MANDATORY from SMCCC v1.1.
> 2. SMCCC_VERSION is OPTIONAL for SMCCC v1.0, so we should consider a
> safe behavior.
> 3. U-Boot is using CONFIG_ARM_SMCCC_FEATURES to probe and bind SMCCC
> service driver if this driver is reported as supported.
> 4. U-Boot SMCCC service driver can embed its discovery process in
> is_supported() callback.
>
> So now we can choose the following approach in U-Boot:
> - Use firmware data (check "arm,psci-1.0") to determine whether a PSCI
> implementation is present.
> - Use PSCI_VERSION (psci_0_2_get_version() major version >=3D 0) to learn
> whether PSCI_FEATURES is provided.
> - Use PSCI_FEATURES with the SMCCC_VERSION Function Identifier as a
> parameter to determine that SMCCC_VERSION is implemented.
> - Use SMCCC_VERSION to learn whether the calling convention complies to
> version 1.1 or above.
> - Trying to probe and bind SMCCC service driver.

Thanks for the detailed explanation!
Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>

>
> BR,
> Weizhao
>
> >
> > >         if (psci_method =3D=3D PSCI_METHOD_HVC)
> > >                 pdata->invoke_fn =3D smccc_invoke_hvc;
> > >         else
> > > diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> > > index f44e9e8f93..da3d29aabe 100644
> > > --- a/include/linux/arm-smccc.h
> > > +++ b/include/linux/arm-smccc.h
> > > @@ -55,8 +55,14 @@
> > >  #define ARM_SMCCC_QUIRK_NONE           0
> > >  #define ARM_SMCCC_QUIRK_QCOM_A6                1 /* Save/restore reg=
ister a6 */
> > >
> > > +#define ARM_SMCCC_VERSION              0x80000000
> > >  #define ARM_SMCCC_ARCH_FEATURES                0x80000001
> > >
> > > +#define ARM_SMCCC_VERSION_1_0          0x10000
> > > +#define ARM_SMCCC_VERSION_1_1          0x10001
> > > +#define ARM_SMCCC_VERSION_1_2          0x10002
> > > +#define ARM_SMCCC_VERSION_1_3          0x10003
> > > +
> > >  #define ARM_SMCCC_RET_NOT_SUPPORTED    ((unsigned long)-1)
> > >
> > >  #ifndef __ASSEMBLY__
> > > --
> > > 2.39.2
> > >
> >
> >
> > --
> > Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations
> >
> > Igor Opaniuk
> > Senior Software Engineer, Embedded & Security
> > E: igor.opaniuk@foundries.io
> > W: www.foundries.io



--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
