Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B103C47DDF
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 13:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C53987BDD;
	Wed, 31 Jan 2024 14:35:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TdXd/J1t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90FDA87B5D; Wed, 31 Jan 2024 14:35:29 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6994F87C39
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 14:35:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5112a04c7acso135497e87.3
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 05:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706708127; x=1707312927; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0V5eLunff8s6vSaQGm9nDM2PF+iWcFzMYn8bGwgK2o=;
 b=TdXd/J1tWq0lSG12dUJVii6Vhze1qYalmw5wYDGRopOvLlV6Itrw6TfVMwWh384C2V
 OrH110e5EtqWcmRCz3eav5RG/8lRVAaL9zhFkUVFqCLjJCC3aT/MlKl3hceRkY8He0tg
 Bo/dNp9Jf8EkpPFgspTtQMMACfMsIIR8TpEuiwZ+6fzI+SLWxWygTl9y/RITvkyGhkB1
 tjMYi55qodnuDgGkhy2GY7FO0NOjQLfX1DbPTkrWstI6isx+mgdQcJLw4DzPzww+AIwX
 od+wBPwJvsFVzb3ZEAUYA7UE4jyvWr6uvbP8I+AESftCI34ckgUZO4uAdLLCJkyY80f3
 pRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706708127; x=1707312927;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o0V5eLunff8s6vSaQGm9nDM2PF+iWcFzMYn8bGwgK2o=;
 b=hRHeAKNh19SpKIeK8x/TkaetNRtrl5VPEV1IOgNDxA7yvdjerorklfrv9eNNulRhnB
 MIPsga2i9j02AIS48VkMztauflVt7zUYyKna3H0yYu1RI2eIasTnDxRJRcFJuBWjDgcN
 6GPa8iP1PWdPRwYSWgvNpCMqCny5HeOFoX3jE2kcb4H5rANeHQFmPGkCsaCujMm9CpQ0
 /1mbhJtHesOvmGTNIA3yJHm4C9MBtjKnKDCZy9gP/BLmEHuaDz9fDjKQnhqGrbmWRnP+
 pOOuzOKFc+L/J3lZ6x8h7pMb5/sIKWzQX2mKGWEOkgUjVsT89LXb2VK1OjcqPN+mGOTM
 7yHA==
X-Gm-Message-State: AOJu0YyBLtiwtk5yGDNUXBrgW9OVYOpqnSTALn3fnQycAy1euzTcGsx3
 YNk89KojcAVlmEpK8g6qkoYw4iDyTVq8/YXU9Y4H2K4wjKyyD2JXfTrQxiS3f/IcvPj3mCZ4GZj
 4cdfRK2EsJY7geV3tLWpqbDwAbxfzj0lcrTO0Y26W
X-Google-Smtp-Source: AGHT+IGmwbo6yU/s2mGKubZ8P7dVPLoXaTjn4o4mRPlm1f31MOPf5VdWO0GA9USJA1PsVIMXM8aKWSeFvWvvQQAEtGA=
X-Received: by 2002:a05:651c:499:b0:2d0:5fd7:afb0 with SMTP id
 s25-20020a05651c049900b002d05fd7afb0mr1018114ljc.22.1706708125655; Wed, 31
 Jan 2024 05:35:25 -0800 (PST)
MIME-Version: 1.0
References: <20240131111217.30124-1-o451686892@gmail.com>
 <20240131111217.30124-2-o451686892@gmail.com>
 <73fa55e6-bf78-415c-a8ce-01405fbceb51@gmx.de>
In-Reply-To: <73fa55e6-bf78-415c-a8ce-01405fbceb51@gmx.de>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Wed, 31 Jan 2024 21:35:14 +0800
Message-ID: <CAHk0HouT-Fa7REsBs7NJkgWxKAM9ayRpehxPmrM=WZS_27gqCw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] firmware: psci: Fix bind_smccc_features psci check
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
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

On Wed, Jan 31, 2024 at 8:27=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 31.01.24 12:12, Weizhao Ouyang wrote:
> > According to PSCI specification DEN0022F, PSCI_FEATURES is used to chec=
k
> > whether the SMCCC is implemented by discovering SMCCC_VERSION.
> >
> > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> > ---
> > v2: check SMCCC_ARCH_FEATURES
> > ---
> >   drivers/firmware/psci.c   | 9 ++++++++-
> >   include/linux/arm-smccc.h | 6 ++++++
> >   2 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> > index c6b9efab41..ed701cd1e4 100644
> > --- a/drivers/firmware/psci.c
> > +++ b/drivers/firmware/psci.c
> > @@ -135,7 +135,7 @@ static int bind_smccc_features(struct udevice *dev,=
 int psci_method)
> >           PSCI_VERSION_MAJOR(psci_0_2_get_version()) =3D=3D 0)
> >               return 0;
> >
> > -     if (request_psci_features(ARM_SMCCC_ARCH_FEATURES) =3D=3D
> > +     if (request_psci_features(ARM_SMCCC_VERSION) =3D=3D
> >           PSCI_RET_NOT_SUPPORTED)
> >               return 0;
> >
> > @@ -144,6 +144,13 @@ static int bind_smccc_features(struct udevice *dev=
, int psci_method)
> >       else
> >               pdata->invoke_fn =3D smccc_invoke_smc;
> >
> > +     /*
> > +      * SMCCC_ARCH_FEATURES is MANDATORY from SMCCC v1.1, but we still=
 remain
> > +      * the invoke_fn() even the SMCCC version is v1.0.
>
> This sentence is a bit hard to understand. Did you mean,
>
> "but we keep calling invoke_fn() even if the SMCC version is v1.0" ?
>
> > +      */
> > +     if (invoke_psci_fn(ARM_SMCCC_VERSION, 0, 0, 0) < ARM_SMCCC_VERSIO=
N_1_1)
> > +             return 0;
>
>
> Why do we leave the function for
> invoke_psci_fn(ARM_SMCCC_VERSION, 0, 0, 0) =3D=3D ARM_SMCCC_VERSION_1_0
> despite the comment above?
>

Previously I was trying to leave the driver a fallback SMC call for
SMCCC v1.0, but since the arm-ffa driver not use the legacy SMC invoke
function and also we can directly call invoke_psci_fn(), so maybe we can
drop this fallback function. Will update in v3.

BR,
Weizhao

> Best regards
>
> Heinrich
>
> > +
> >       feature_cnt =3D ll_entry_count(struct arm_smccc_feature, arm_smcc=
c_feature);
> >       feature =3D ll_entry_start(struct arm_smccc_feature, arm_smccc_fe=
ature);
> >
> > diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> > index f44e9e8f93..da3d29aabe 100644
> > --- a/include/linux/arm-smccc.h
> > +++ b/include/linux/arm-smccc.h
> > @@ -55,8 +55,14 @@
> >   #define ARM_SMCCC_QUIRK_NONE                0
> >   #define ARM_SMCCC_QUIRK_QCOM_A6             1 /* Save/restore registe=
r a6 */
> >
> > +#define ARM_SMCCC_VERSION            0x80000000
> >   #define ARM_SMCCC_ARCH_FEATURES             0x80000001
> >
> > +#define ARM_SMCCC_VERSION_1_0                0x10000
> > +#define ARM_SMCCC_VERSION_1_1                0x10001
> > +#define ARM_SMCCC_VERSION_1_2                0x10002
> > +#define ARM_SMCCC_VERSION_1_3                0x10003
> > +
> >   #define ARM_SMCCC_RET_NOT_SUPPORTED ((unsigned long)-1)
> >
> >   #ifndef __ASSEMBLY__
>
