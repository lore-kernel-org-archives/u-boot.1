Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD72C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 13:40:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0287481703;
	Tue,  1 Apr 2025 15:40:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f6s/uwe2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF78182051; Tue,  1 Apr 2025 15:40:18 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD7ED80584
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 15:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-391342fc1f6so4950919f8f.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743514816; x=1744119616; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bIoI6hYm1ihSARP5h7ryTKPt6zJe1HlMyPHZleBipoI=;
 b=f6s/uwe2iHeRUAmDARo9T5dEyqvZO23wdK8EQNfamoIjVDrhoSWfz6H0fgUZDSgJoM
 3Teg6pVUv53K3acI/U1XDmkQ025I5Ef9L60mmiNnEvf7P7VipOlwCRH1QGlWD/M9GCMY
 aGGe+oHhSJMteBOL67ejnkEec2h8CC6f79yJeXh+yc3c0ki4hLZCiVj3s1KsblxlvBY+
 C2nMyw6knsb2tKtBFcLZeedw+qe78H/uzKarr6HK1l/bebcpUCl0LES+efwAbwUNPlwu
 tmeQTF6NEwoYl+Y9+9gBgvGQdiHUMXiDGvSzzkvRCJIwclzdDJ4KH9IRdRCitm+IqsRm
 Eu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743514816; x=1744119616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bIoI6hYm1ihSARP5h7ryTKPt6zJe1HlMyPHZleBipoI=;
 b=W4Aj/iYiKqKTNaKkFqTzyoIEFKE8EzwqiCSGT3cYcv8Ooha4Rir9ShIhVU34t8Yt6Z
 2YqMF5L092SWZ4/gk5BdHDKgiyW/UFjJrM1f9So1d37yUoSNPjmdy8eeRVpKMq9v80JS
 bRhZbKwxjFKFCKE0uGcPC1zXRcYinm0nbfJSdTvctfoOrIexLyHQyAXEbH2t8hPRv1Fh
 rb6mxpZRMWahfUTaNZG6nYVWymTo8T4PpoH43ALGAN+ar/fZjNpXrg65IHWC3aErRiH3
 ao0aPAlk8x6j59SxZ/Bj8y7xhRsy0ndb7wBP9Vn2muvs2nAywzJp10IsyPGdvgbcE8gg
 JH+g==
X-Gm-Message-State: AOJu0YxtU/lssJfopaBIjCtP1Q0InBk2N8T47F2Kw4o2XAb9L4hcP9YG
 HM1rap5CAhr9N/qPFzK8fZIAnj/N6nuZjqWp4HXUUttcICqq4DGdnfNEz1lshBUtXoDoqUqc/eS
 FLY09erhDpfCQCgkvlRImIty5V0Y=
X-Gm-Gg: ASbGncvx+aZV6K4pvMCTeWYW3qmn42mtHAPvu/Z4z0AyJsG5aeoTbL3TtBg2fWZdz6O
 aHk2L6WaqJ8QBTEftbScIsoF07kwt5Zhho9Lh1aiNVNcEkEKEfI68iE7avPpytGhNeEKTuxTYhG
 FfIqIGAk4GZQVfdsErYKpm5AGzEUVpLvIaVOtJQA==
X-Google-Smtp-Source: AGHT+IEczerd1Qn3GFRjkWdDaBTtxRIGi0XZmh1KdATrTGHgd3DCwjH2O2UQ1O0E95fqXeEustTgpPXCxrLr/UcHAFE=
X-Received: by 2002:a05:6000:250f:b0:39c:1f10:d294 with SMTP id
 ffacd0b85a97d-39c1f10d4e4mr4844068f8f.26.1743514816029; Tue, 01 Apr 2025
 06:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250330192656.1280403-1-arturkow2000@gmail.com>
 <20250330212638.v2.2.I04194142897633b6272f2f235daed4f3a0b8939b@changeid>
 <CAPVz0n2qCOx6dF7DnwEdnptw1hmvbR7ky70zB6ESM7pqeEuVdw@mail.gmail.com>
 <bae6ce3f-df88-4ddf-b1cc-dcb14bb54ea0@gmail.com>
In-Reply-To: <bae6ce3f-df88-4ddf-b1cc-dcb14bb54ea0@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 1 Apr 2025 16:40:04 +0300
X-Gm-Features: AQ5f1JrKRtTOeXFoXHtl3y6tRp6-xZVyKzfDTgl9d3FasKFG-Qg2g5KtWniUYo0
Message-ID: <CAPVz0n2cKSsZNLe9+j3q_5VNzye3iAPT3932vdT76J+753VpxA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] tegra: respect CONFIG_TEGRA_ENABLE_UART* options
 on Transformer T20
To: Artur Kowalski <arturkow2000@gmail.com>
Cc: u-boot@lists.denx.de, Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Simon Glass <sjg@chromium.org>, Stephen Warren <swarren@nvidia.com>,
 Tom Rini <trini@konsulko.com>, Tom Warren <twarren@nvidia.com>
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

=D0=B2=D1=82, 1 =D0=BA=D0=B2=D1=96=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:30=
 Artur Kowalski <arturkow2000@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
>
> W dniu 31.03.2025 o 07:48, Svyatoslav Ryhel pisze:
> > =D0=BD=D0=B4, 30 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 22:27 =
Artur Kowalski <arturkow2000@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >> If debug UART is set to anything other than UARTD, U-Boot's SPL hangs
> >> trying to communicate with UARTD which clock won't be ungated. With th=
is
> >> patch it is possible to boot with UARTA enabled.
> >>
> >> Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
> >> ---
> >>
> >> (no changes since v1)
> >>
> >>   include/configs/transformer-t20.h | 10 ++++++++++
> >>   1 file changed, 10 insertions(+)
> >>
> >> diff --git a/include/configs/transformer-t20.h b/include/configs/trans=
former-t20.h
> >> index 6a3d9b24036..d3a98cc5a70 100644
> >> --- a/include/configs/transformer-t20.h
> >> +++ b/include/configs/transformer-t20.h
> >> @@ -16,7 +16,17 @@
> >>   #define CFG_TEGRA_BOARD_STRING         "ASUS Transformer"
> >>
> >>   /* Board-specific serial config */
> >> +#if defined(CONFIG_TEGRA_ENABLE_UARTA)
> >> +#define CFG_SYS_NS16550_COM1           NV_PA_APB_UARTA_BASE
> >> +#elif defined(CONFIG_TEGRA_ENABLE_UARTB)
> >> +#define CFG_SYS_NS16550_COM1           NV_PA_APB_UARTB_BASE
> >> +#elif defined(CONFIG_TEGRA_ENABLE_UARTC)
> >> +#define CFG_SYS_NS16550_COM1           NV_PA_APB_UARCD_BASE
> >> +#elif defined(CONFIG_TEGRA_ENABLE_UARTD)
> >>   #define CFG_SYS_NS16550_COM1           NV_PA_APB_UARTD_BASE
> >> +#elif defined(CONFIG_TEGRA_ENABLE_UARTE)
> >> +#define CFG_SYS_NS16550_COM1           NV_PA_APB_UARTE_BASE
> >> +#endif
> >>
> > Here you are actually hitting much much deeper thing. You are applying
> > fix to the result, not the cause. Adjustment should be done in the
> > tegra board itself with amending all existing tegra boards. As a
> > maintainer I cannot insist on you doing this unless you willingly
> > agree. You have time to answer till 02.03.25 and if no answer I will
> > apply patch on my own to custodian tegra/staging branch.
> I'd like to do it but unfortunately I won't have enought time this week.

Thanks for responding. Don't worry, I was planning to remove
per-device headers anyway so I will include you into patchset which
should address the root of this issue you are facing.

> >>   #include "tegra-common-post.h"
> >>
> >> --
> >> 2.48.1
> >>
