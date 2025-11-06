Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FE4CCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 15:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8A3383B9B;
	Thu,  6 Nov 2025 16:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EHJT8UP8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC68D83BAD; Thu,  6 Nov 2025 16:45:46 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0E3383B85
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 16:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-787be077127so5987977b3.2
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 07:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762443943; x=1763048743; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohSIC2wtG1ktnmBrn5hTDGGXf61gelJ5FNqb++HGzTg=;
 b=EHJT8UP8XNYZ25BuGo8o//m1G+MCQo4XCXCOTxozv36/sj/fo2xoJJlRPr49n2EnlR
 jcTTa2ly1WFxIdVdNcDfuP9R3ABp1fx/dbVquij5gV0cjmcm8E9SB22lUK97iPI9XmqN
 0lSgLeixQk5CmZvRcy75pDdAiYe02aOKEnLRvXCImodwQX2XGoi00+J+ogQ0OAm5ApQo
 CVq2iJAoFMZHsW5XRFaPTp14KEYpeuPOgTLB4PT9JD5bwdGxm4JrbkoNp2zez77NriWF
 e4yQdA6vNOZ9LNNCUlkzTJaiLFilMA32yrlQm8QDbAD4X8CAfNJAyYXXYcnWLv+TMuzR
 SWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762443943; x=1763048743;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ohSIC2wtG1ktnmBrn5hTDGGXf61gelJ5FNqb++HGzTg=;
 b=fE6sfcjQQtOztEHvgbP6ZNdWHljU6YSIEt7wAfdMiD3K5tzO5aA7W4xSkntzNrc9Jy
 gRTbZZ/oaVNuu6ZcU/lm/Hdht5A/Gts5X2tGcffDAultzj8wBpsEDzQDRWFf5KADyvSp
 44Njh2iSbMCaixnUfBamZhOuqX2qcAzkpozFT3VwhcFFR6BYXI1xeWooZQYGJcGPLUUY
 F6jS7d+zU7zsj0bfkjAYhUO97N5L8EoiRfVnK4+pZF+qzwe/MEBve1wMXiSOnkw98RWP
 drDFNICq6Mux3cXG89Ri8ls2L04Rc0AuyaOokN7qM/kg9jWKsrlAbKJM48WG8KPYrTc5
 wd0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyQQVS44IMC3X7B+OjBB6plIKQ3WMbsja02ASo7sK/UobZ3c1CghjCWTvvcesGRVa2+pvDPls=@lists.denx.de
X-Gm-Message-State: AOJu0YyeHUHKHeq9AKv2ZbVl+SJRBkKFbABjrPo1A2ZuvIgq2AQMXWLZ
 0JDkq2EjyjYA/N7JoDjJs50CLx6qcmczUecmRtFiuZpdPGiEicXJATEMUgkPFyb0GgCHAOVvkU/
 cL93vUGxvJsJ7PKOIYE2viUoR/MW3/Qs=
X-Gm-Gg: ASbGncuxoCr0abmn2E/nG/ckvIvqCbwnzmVo0ypejqw5uMdOxrpnzV/+6mpoyaO3N3v
 TsFEWkRRo8p8XL3JlAb6MUTX4nDSSxEQoxEwPCChIG1W1beIPQbd6tGzRoX+58U8ppISWs36p/S
 3tq5Uh2A/rxViD0FP8xVm5Lw4ee7pHewQm3GaSfoVLbwmMaS7ZMkdKgk95hVJW2eRj/4idNouKh
 wr+mZYVWh53I1hGN9u6ACd0Nsg6tQF6X7qaEQWFFRfaAYBY2PBZq4Im/g/lC1bX+i33PaU=
X-Google-Smtp-Source: AGHT+IH8Y+ERe7rh3xL2Ro2vuv4rvk7WnaJj0Xa6is0xCJ1en0eZWKf0PyQVzdSpp3CrD96qnANnQbRvGsPCz8ChIKY=
X-Received: by 2002:a05:690c:fca:b0:734:f858:b1e7 with SMTP id
 00721157ae682-786a4117febmr78648127b3.27.1762443943369; Thu, 06 Nov 2025
 07:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20251106153009.887102-1-bmeng.cn@gmail.com>
In-Reply-To: <20251106153009.887102-1-bmeng.cn@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 6 Nov 2025 23:45:32 +0800
X-Gm-Features: AWmQ_bmJiE07bGTJ4BPsKpqhlqNfUnmICi3Xu_f7A2brywJcVclTU4WbAq7PgF8
Message-ID: <CAEUhbmXBUaWAx0iiQtpp1AKJ13-Nxv46__Z=9Ck5JP+HP+7j9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] qemu: arm: Rename QEMU arm* defconfig files
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Greg Malysa <malysagreg@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
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

On Thu, Nov 6, 2025 at 11:30=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> wrote=
:
>
> Other QEMU defconfig files use a hyphen between "qemu" and the
> architecture name, but ARM uses an underscore. Rename the ARM
> defconfigs for consistency.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
>  MAINTAINERS                                                 | 2 +-
>  arch/arm/dts/qemu-arm.dts                                   | 2 +-
>  arch/arm/dts/qemu-arm64.dts                                 | 2 +-
>  board/emulation/qemu-arm/MAINTAINERS                        | 2 +-
>  ...{qemu_arm64_acpi_defconfig =3D> qemu-arm64_acpi_defconfig} | 2 +-
>  configs/{qemu_arm64_defconfig =3D> qemu-arm64_defconfig}      | 0
>  ...{qemu_arm64_lwip_defconfig =3D> qemu-arm64_lwip_defconfig} | 2 +-
>  configs/{qemu_arm_defconfig =3D> qemu-arm_defconfig}          | 0
>  doc/board/emulation/qemu-arm.rst                            | 6 +++---
>  doc/develop/driver-model/virtio.rst                         | 6 +++---
>  doc/develop/uefi/uefi.rst                                   | 2 +-
>  tools/docker/Dockerfile                                     | 4 ++--
>  12 files changed, 15 insertions(+), 15 deletions(-)
>  rename configs/{qemu_arm64_acpi_defconfig =3D> qemu-arm64_acpi_defconfig=
} (54%)
>  rename configs/{qemu_arm64_defconfig =3D> qemu-arm64_defconfig} (100%)
>  rename configs/{qemu_arm64_lwip_defconfig =3D> qemu-arm64_lwip_defconfig=
} (80%)
>  rename configs/{qemu_arm_defconfig =3D> qemu-arm_defconfig} (100%)
>

Oops, I forgot the CI yml files changes. Will do in the next version.

Regards,
Bin
