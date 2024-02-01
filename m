Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AD4C4828D
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 14:36:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4D1B87C76;
	Thu,  1 Feb 2024 15:36:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="PkoqWmk1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D305287C9E; Thu,  1 Feb 2024 15:36:30 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBD9C87C66
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 15:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-510218c4a0eso2000447e87.1
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 06:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1706798188; x=1707402988; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08L9iU6l2d0oQPEG46aYtc1bhnX/nVuQTSQZH0IX9oo=;
 b=PkoqWmk19tg6O4XePzcYNG7oZYCPiLJq0mDqAoXKSQPdY2qPuZ73ArwLHGe4bOXDeH
 rdDPphkhGzRhaYm2mgbqmWUW7LsxVjtUq3BPLWZfjhcr8Z/fnp6TxrOSJVA1O3VgQdBK
 SRDoWaGXvh1XUDdhUKBcxY9nSCgA75t+VY6/bxhvePaOnjx4wBJHfOvlNrnDnjNk12s5
 3xbU6tuEYTjrpEMk3seGBrNmT3CPehLanz6Q3HtA68mSj28Uo+I7M33LkMv4d9EvVfDp
 cUHOEwE4427VLlAyO53I8Gz85GjJEuNxTTQ3y9nrGjfpohTBWsPuOKjm8GHp1y/rbfCJ
 Q44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706798188; x=1707402988;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=08L9iU6l2d0oQPEG46aYtc1bhnX/nVuQTSQZH0IX9oo=;
 b=hwyv2XyhVOA5iDpk7lMth7aWX7i05e1S6g+5lVG8TVoalj0XvH4oOE/GzsNabSpO+J
 Pas9WkHTzQJSDJtIFpzjwoXPYIuEGi3R4xtNWCM58rPmDr8HrcHEUTWXzmHAKC1rKPGL
 lRC0C6IJHpZ4XdvAzW5QEEYst1OF3s9Zia6n5q/4DhF2mhmDt7RlHHmon3L/7N12mCFT
 jGGXE8pkVht91yX2Jyz0e802yDtKIrPub8WUjR+YsFVm4dE9SkBoYNUrszYtAkH7ij5T
 jKrGrIbUB3d2yRaWg3+Y16NvfULUL32xL631qOJgcra2vjI1Sq3gZgfVo15A5jgaLONL
 4qZQ==
X-Gm-Message-State: AOJu0YxLN4vcpHi+3Sp+z8doMeGlGdaQYGWNttNea1OD9TvIp0uXlaDJ
 FQvB0yz94VZxouZm4WM5dGxp8LKkg2MDx9lq9BcVw1TOFgs7vyF2y3iJA//mTa0wUg+RpR9QOw6
 17XCz65PVrfi6yJi8d+TXOGxDHSOQQ4aIqmLAWw==
X-Google-Smtp-Source: AGHT+IHioHzDwc/cDlueszMfUSQc/7QUbU5jfViE/OLFzxrqChOmpWqW8ZYMUWEdJdnuIww0yGcKWOoCBFfT+ao5isk=
X-Received: by 2002:a05:6512:3134:b0:510:24dc:aa8f with SMTP id
 p20-20020a056512313400b0051024dcaa8fmr1009202lfd.14.1706798188043; Thu, 01
 Feb 2024 06:36:28 -0800 (PST)
MIME-Version: 1.0
References: <20240131141426.34926-1-o451686892@gmail.com>
 <20240131141426.34926-2-o451686892@gmail.com>
In-Reply-To: <20240131141426.34926-2-o451686892@gmail.com>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Thu, 1 Feb 2024 15:36:16 +0100
Message-ID: <CAL6CDMGrR9YQzs6iLbKmzwMWXYyX15-ngv2vBDbkW-FSfr38kA@mail.gmail.com>
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

On Wed, Jan 31, 2024 at 3:15=E2=80=AFPM Weizhao Ouyang <o451686892@gmail.co=
m> wrote:
>
> According to PSCI specification DEN0022F, PSCI_FEATURES is used to check
> whether the SMCCC is implemented by discovering SMCCC_VERSION.
>
Could you please add more details to your commit message or as a comment
explaining what exact steps should be done for a full discovery sequence of=
 Arm
Architecture Service functions, so people don't need to search for
that information explicitly?

For instance:
Step 1: Determine if SMCCC_VERSION is implemented
- Use firmware data, device tree PSCI node, or ACPI FADT PSCI flag, to
determine whether a
PSCI implementation is present.
- Use PSCI_VERSION to learn whether PSCI_FEATURES is provided. PSCI_FEATURE=
S is
mandatory from version 1.0 of PSCI
Step 2. etc.

I would just pull that info from the latest SMC Calling Convention version =
1.5,
from 9 Appendix B: Discovery of Arm Architecture Service functions.

Thank you!
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
> v3: remove fallback smc call
> v2: check SMCCC_ARCH_FEATURES
> ---
>  drivers/firmware/psci.c   | 5 ++++-
>  include/linux/arm-smccc.h | 6 ++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index c6b9efab41..03544d76ed 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -135,10 +135,13 @@ static int bind_smccc_features(struct udevice *dev,=
 int psci_method)
>             PSCI_VERSION_MAJOR(psci_0_2_get_version()) =3D=3D 0)
>                 return 0;
>
> -       if (request_psci_features(ARM_SMCCC_ARCH_FEATURES) =3D=3D
> +       if (request_psci_features(ARM_SMCCC_VERSION) =3D=3D
>             PSCI_RET_NOT_SUPPORTED)
>                 return 0;
>
> +       if (invoke_psci_fn(ARM_SMCCC_VERSION, 0, 0, 0) < ARM_SMCCC_VERSIO=
N_1_1)
> +               return 0;
> +
IMO, to fully comply with SMC Calling Convention version 1.5
we should also check for SMCCC_ARCH_WORKAROUND_1:

From 9 Appendix B: Discovery of Arm Architecture Service functions,
Step 2: Determine if Arm Architecture Service function is implemented
- Use SMCCC_VERSION to learn whether the calling convention complies
to version 1.1 or above.
- Use SMCCC_ARCH_FEATURES to query whether the Arm Architecture
Service function is implemented
on this system <--- we lack of this step

>         if (psci_method =3D=3D PSCI_METHOD_HVC)
>                 pdata->invoke_fn =3D smccc_invoke_hvc;
>         else
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index f44e9e8f93..da3d29aabe 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -55,8 +55,14 @@
>  #define ARM_SMCCC_QUIRK_NONE           0
>  #define ARM_SMCCC_QUIRK_QCOM_A6                1 /* Save/restore registe=
r a6 */
>
> +#define ARM_SMCCC_VERSION              0x80000000
>  #define ARM_SMCCC_ARCH_FEATURES                0x80000001
>
> +#define ARM_SMCCC_VERSION_1_0          0x10000
> +#define ARM_SMCCC_VERSION_1_1          0x10001
> +#define ARM_SMCCC_VERSION_1_2          0x10002
> +#define ARM_SMCCC_VERSION_1_3          0x10003
> +
>  #define ARM_SMCCC_RET_NOT_SUPPORTED    ((unsigned long)-1)
>
>  #ifndef __ASSEMBLY__
> --
> 2.39.2
>


--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
