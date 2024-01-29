Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77326C47258
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 02:48:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAAE2879CC;
	Mon, 29 Jan 2024 03:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P1CbHSBR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EF5087BAD; Mon, 29 Jan 2024 03:48:05 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 696AC879BD
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 03:48:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55783b7b47aso2367582a12.0
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 18:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706496483; x=1707101283; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EP9BDnUkx7JbYrjAyE4ZwFUfQkAMz3WRWSw7MYP6SYk=;
 b=P1CbHSBR6caBXK5lf1mOQrjW7xLpPDtKHo2DOkG3WWOUVdHirtVlhe8Wumcd+/UfGS
 cauCN5eolM5hRezqBaf9A37TwDtzcozawWF+wZdHXlvIKBkYza0WKGvZ7jX6DwRE9cc7
 yeCriM0IJ3x8VXQvemP9WknPusw/k8xyUHXbnekD5hKj50NAQiYHN/vE2Lu0rF9GKmoH
 80xqSYMCvFDAY1i0HXTsNs5mAMa3prWulYSMlwUQ96IN2PJKsr3C0aL3hmFsrYodABGX
 JU/hGbisuj+zh4Y6jINf5J7wfSxeSOP1dtBe2hFySWifrkCoR7ey5287L/AeEnOVYI8h
 e8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706496483; x=1707101283;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EP9BDnUkx7JbYrjAyE4ZwFUfQkAMz3WRWSw7MYP6SYk=;
 b=qTtXNFL45oB3PEIOV//Uon759Zj4pZy4dPIsBtJ3ZtltYlF4ZObxs+CQg5aZgSDM7O
 b6Lf5+Oq2rs+oiRgXNf+kMWGKHwqLDlvmxP3MzUGQN++MkE8pittxNFeSALyxHV3TzPZ
 nem91CRmo858408vXtQ4nmCb8sYUDqdEtujR4HhLrydYRYIHlCYiyh4Fyzbobw3sgk0R
 kqBXaQckravbq2oYa+TfjmLmq2pwACN0XI79+XQJ8Ul4P3V78xllQ+1AF5Y7aLeZ/P7d
 u2XEPSEyoM4SMnpmeGjeuZvJLUYQ4gUAMkCrVSqiQU7cp9A6avC6N47y5DFmpHZWC+NZ
 mMnA==
X-Gm-Message-State: AOJu0YzaNY8aBTFNRlwy/yqFIJxDCUxB9yCaym5joUD1WH77ICoIYLxb
 N8jXk3lcxNabcEWJqN/gSVcppPkJC/HSqpx93YGayG2eQ6s8sJw/NEvsqLUHYhrIuc9rgq+ZOYk
 hFh2LwSAwP1mvKMpgYEaxXqz42ak=
X-Google-Smtp-Source: AGHT+IGyFkHz9MPT9Xd4mnDe5ZiO+EXraYRlBMcfnifGvSjp9jKYOeMe8F6uZXaMQN5FHRm+1bc9bb+C+vPFT1NMjqk=
X-Received: by 2002:a05:6402:27d0:b0:55e:d8a8:ef6d with SMTP id
 c16-20020a05640227d000b0055ed8a8ef6dmr2325720ede.35.1706496482191; Sun, 28
 Jan 2024 18:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20240125140502.22400-1-o451686892@gmail.com>
 <20240125140502.22400-2-o451686892@gmail.com>
 <20240126112028.GA62785@e130802.arm.com>
In-Reply-To: <20240126112028.GA62785@e130802.arm.com>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Mon, 29 Jan 2024 10:47:51 +0800
Message-ID: <CAHk0HotF6HVcPBk4CABR=k9k7OcwJn2Z+qw6GUXJAJw+7Oi3tA@mail.gmail.com>
Subject: Re: [PATCH 1/3] firmware: psci: Fix bind_smccc_features psci check
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Etienne Carriere <etienne.carriere@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, 
 u-boot@lists.denx.de, nd@arm.com
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

Hi Abdellatif,

On Fri, Jan 26, 2024 at 7:20=E2=80=AFPM Abdellatif El Khlifi
<abdellatif.elkhlifi@arm.com> wrote:
>
> Hi Weizhao,
>
> On Thu, Jan 25, 2024 at 02:05:00PM +0000, Weizhao Ouyang wrote:
> > According to PSCI specification DEN0022F, PSCI_FEATURES is used to chec=
k
> > whether the SMCCC is implemented by discovering SMCCC_VERSION.
> >
> > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> > ---
> >  drivers/firmware/psci.c   | 2 +-
> >  include/linux/arm-smccc.h | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> > index c6b9efab41..894be8128d 100644
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
>
> I suggest we add checks on the SMCCC version like this:
>
>     if SMCCC_VERSION >=3D 1.1
>        assume SMCCC_ARCH_FEATURES is supported
>        discover arch features and bind drivers/devices
>     else
>        error

Okay, I will add it.

BR,
Weizhao

>
> For more details [1][2].
>
>
> [1]: SMC Calling Convention 1.5 (https://developer.arm.com/documentation/=
den0028/latest/)
>
> SMCCC_ARCH_FEATURES MANDATORY from SMCCC v1.1
>
> The implementation of this function can be detected by checking the SMCCC=
 version. This function is mandatory
> if SMCCC_VERSION indicates that version 1.1 or later is implemented.
>
> [2]: Linux checks SMCCC v1.1: https://elixir.bootlin.com/linux/latest/sou=
rce/drivers/firmware/psci/psci.c#L597
>
> Cheers,
> Abdellatif
