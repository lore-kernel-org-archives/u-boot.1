Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC038CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 12:23:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1A5B83D2E;
	Fri,  7 Nov 2025 13:23:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L/9L5dFg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7554483D3D; Fri,  7 Nov 2025 13:23:19 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 801AF83D18
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 13:23:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-64034284521so1127116a12.1
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 04:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762518197; x=1763122997; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1MiXDavF4Ll8BaTZVXl3o4Jxbv2YT3S1s4Xq5/XTmRQ=;
 b=L/9L5dFg0IbJUp6fUGTZ2nNvqk32LLUtvZqDAXnlr8MRadvpHdMFZbNIt16XcONOtJ
 YQHcszkGLg9kx/fr3GTPUYFh/XJ2bI+Ebt7cSymCAq3/UxITJts4b+Fhpkj6CXEDU7L0
 gCPWnvsymQ7OnioH45s2SvjW2oOLD2HstZ0k8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762518197; x=1763122997;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1MiXDavF4Ll8BaTZVXl3o4Jxbv2YT3S1s4Xq5/XTmRQ=;
 b=vCo3nANz/vG0cN1fEZC5BoZgQ2nbo8w4S0Pkqkqxzxlp1ODqLz+Ae84nlT2TWTrpt6
 V2jwvjr8vvf9xeO+0uT3F1acPgm5Y50CH+PPmIyBZyBUvBMZjXMQnjV6IzN2cQFSdEWw
 /u+LnZcSZt/ixDOAOPt/cG3NdKzkJj8wqDW/NDLfm+ToC6XfmhSw/4/CPPbWGE82uItb
 1IBr4/k+e6T2uRg0TzqxkihwEkB28tvx5ZYD8BKurwHtSYoKSeIjK7h1GcHIOdBqhZRb
 fo215K38UgkEjccJssFzeAU6lqpqF7t/ga/q8Deg29LvvxeADzcHELJtvQ2ovW6zKuMc
 IOVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRyv+PIRNYKeaGJ6GRgUDVVi0CNxXNSC6HWMDF93W4072feHvO6FxKVkJpyeZl0EyRcgZZBuk=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0O0uDZTkCXaSQG/V4/qI5UbtpL36XyxE9Gyu2/VvIPb+hpjeh
 nIxLod3Kwb7Z/sMiRk/mnC6teFKroE2YIYfKPwUHe0mDnmAwcbhD9gmMju5ltJZ3avIKK2DirjM
 QTly2AvLLvBiy1JHnaZH6bej3MDYRiCMhxvfdDUrv
X-Gm-Gg: ASbGncsC5A/dJlsphYxLIlu1M6XQj7wN6yaoL4QqD+VyWbO1zw6FlAAWmHODu6g16U5
 1KK8m+tRVFSDkBrI/c9W+sHRyTkxYuptIBTxloHiFG78IawWuXjAvkIFllxFimYTsSKKw5H2bWf
 qP6kJKHKMqTHugCqiBtHcDo75FeYUGnMOzy39cMgFBJcdwGyS1/Wfs42zclTWoZlQcnrflGqUKU
 d7tSQCWurmxP+aOYGDXy1aRT3iKTdHuWyCRVwdfGGTD8BtnRudkWDujvfEC
X-Google-Smtp-Source: AGHT+IF4my2olkzLwsOcJsylORDICY0+mzr8LtkOflCiL/H2CZSDx7nd+48Xp5B12UH1lQWeKWeoVxUcC2Ba0jT/3E0=
X-Received: by 2002:a17:907:3e97:b0:b45:60ad:daf9 with SMTP id
 a640c23a62f3a-b72c093368bmr327724166b.3.1762518196898; Fri, 07 Nov 2025
 04:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20251106153009.887102-1-bmeng.cn@gmail.com>
 <CAEUhbmXBUaWAx0iiQtpp1AKJ13-Nxv46__Z=9Ck5JP+HP+7j9Q@mail.gmail.com>
In-Reply-To: <CAEUhbmXBUaWAx0iiQtpp1AKJ13-Nxv46__Z=9Ck5JP+HP+7j9Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Nov 2025 13:23:03 +0100
X-Gm-Features: AWmQ_bllVZBW6hEPtJ2ApeUZzbvqW01M2wwM6WJZEmBmQl-V2VCRQth-3n32yMs
Message-ID: <CAFLszTjGNKV+kXiTB5KMOvcimSSOkqJkPKsspcxyX9Gho+05gA@mail.gmail.com>
Subject: Re: [PATCH 1/2] qemu: arm: Rename QEMU arm* defconfig files
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
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
 Sam Protsenko <semen.protsenko@linaro.org>,
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

Hi Bin,

On Thu, 6 Nov 2025 at 16:45, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Thu, Nov 6, 2025 at 11:30=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> wro=
te:
> >
> > Other QEMU defconfig files use a hyphen between "qemu" and the
> > architecture name, but ARM uses an underscore. Rename the ARM
> > defconfigs for consistency.
> >
> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > ---
> >
> >  MAINTAINERS                                                 | 2 +-
> >  arch/arm/dts/qemu-arm.dts                                   | 2 +-
> >  arch/arm/dts/qemu-arm64.dts                                 | 2 +-
> >  board/emulation/qemu-arm/MAINTAINERS                        | 2 +-
> >  ...{qemu_arm64_acpi_defconfig =3D> qemu-arm64_acpi_defconfig} | 2 +-
> >  configs/{qemu_arm64_defconfig =3D> qemu-arm64_defconfig}      | 0
> >  ...{qemu_arm64_lwip_defconfig =3D> qemu-arm64_lwip_defconfig} | 2 +-
> >  configs/{qemu_arm_defconfig =3D> qemu-arm_defconfig}          | 0
> >  doc/board/emulation/qemu-arm.rst                            | 6 +++---
> >  doc/develop/driver-model/virtio.rst                         | 6 +++---
> >  doc/develop/uefi/uefi.rst                                   | 2 +-
> >  tools/docker/Dockerfile                                     | 4 ++--
> >  12 files changed, 15 insertions(+), 15 deletions(-)
> >  rename configs/{qemu_arm64_acpi_defconfig =3D> qemu-arm64_acpi_defconf=
ig} (54%)
> >  rename configs/{qemu_arm64_defconfig =3D> qemu-arm64_defconfig} (100%)
> >  rename configs/{qemu_arm64_lwip_defconfig =3D> qemu-arm64_lwip_defconf=
ig} (80%)
> >  rename configs/{qemu_arm_defconfig =3D> qemu-arm_defconfig} (100%)
> >
>
> Oops, I forgot the CI yml files changes. Will do in the next version.

Welcome back!

I have wanted this change for ages :-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
