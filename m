Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B15C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ED8488481;
	Mon, 22 Jul 2024 20:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KVb+Ikn9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14BA588481; Mon, 22 Jul 2024 20:17:24 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49E1988453
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 20:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-66a1842b452so28455677b3.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 11:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721672239; x=1722277039; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lLUoTJCDiOsFx40jhTkwEM0bimseEJMyziLA2JTICgE=;
 b=KVb+Ikn9VCvCv64bYrEVi9++DfIq22xrHCnq2F2t9ScMB/KU63qcGP4qPFHoX5541g
 Yv+6+41AGB/ry5mNFfEyH4FbHzMwI+v/jpGGr+iVwZqZrv+UmnFozPEDUtLFL2tlaNu9
 FLDBolYlZnDgscWVVyjJsuQi3FFWq/eeCS/WwDmUJx1bROhDBzQ3yuAdFEQpxxpwpu5N
 d6hc+l1vxc+uosSfH3fHe+Ey3STL24YUHS4ZD76W45WRGATFmpesQOpa8ajs+ragDJzM
 HtZcbLnskYdS1oNiRELN1qyL+WHiJSsT6jKv+gUUvd5BYNYIYS26JEj2BXZY3LUYoIRZ
 1mQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721672239; x=1722277039;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lLUoTJCDiOsFx40jhTkwEM0bimseEJMyziLA2JTICgE=;
 b=akcbrCwOq/yZHGJ22CyV/t+xqvaYhCJ44jm7Ov6uh7KmWBQ50fpZo1xsgzp507O7P1
 WTyyrlEwKbVzgf/eGTQa5B3Uw4wiS74lvrsSZOVn41D5FeN8c+O6Lb/V1kPEKmCT4sY1
 +UmAU24Yxr+FwIgShcfYDEIP3lW9ujHXg5QzK0+cq31wuigAQ1X/I09P8lk6OuKZgiqD
 4qMxWeN5DWZtOMwvtoN1YpunYR6UKhevQFBt/MpkeSR1CxeqpwpcabeoqS796vKQAoJK
 81soCI0arGmIYiGu2lnGTJFz826NelyAimZGw5vJC2/2/Zx7+2KBfcSlAXWsq37oSXJ1
 2rPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/skdlNxVGsUpU2uhKR2GpTkEkVhtx5tiqBuU7lPbMBcJ5AC+EWr0hm8GH84ckIlwMOVFjZGaY8ZbY1/Wrq5QbTbpVMg==
X-Gm-Message-State: AOJu0Yx6tHrY7ZCJg91r79zAuVgdcJUOLYERqoNH8DwhTs7RCaMihDDT
 Hujf0KNUjgwBqimI9a27rJRGD6/9j10LSqnRX/pRBARkV5/vYlFLPvK027D4daJSEh5uQtl4Ekr
 GLw6LfFT4ii17W1gNdCNSh8FYn0mYoUabIKgTQg==
X-Google-Smtp-Source: AGHT+IHIaNZOM81tCmQSyhi1mOM5tdjgCP1Yf4nDPwvX0bVY4zovJAg7HYu9fLl3N19PUwfHrwSiHhQiEYGNwfZVpMQ=
X-Received: by 2002:a05:690c:97:b0:64a:bd29:c5d8 with SMTP id
 00721157ae682-66a682cee57mr105697897b3.2.1721672239066; Mon, 22 Jul 2024
 11:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240716031709.24943-1-semen.protsenko@linaro.org>
In-Reply-To: <20240716031709.24943-1-semen.protsenko@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 22 Jul 2024 13:17:08 -0500
Message-ID: <CAPLW+4mAqpgWwiX4fvZFjWMWPtY9Mx11b9oPghzfpFoD8FU98A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] arm: exynos: Enable TRNG for E850-96 board
To: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Anand Moon <linux.amoon@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Minkyu,

Can you please take a look at this series? And also my MMC series [1]
has been pending for a while now, if it's ok with you -- can you
please apply it?

Thanks!

[1] https://lists.denx.de/pipermail/u-boot/2024-July/559602.html

On Mon, Jul 15, 2024 at 10:17=E2=80=AFPM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> This series enables True Random Number Generator (TRNG) for E850-96
> board. Here is a short breakdown of features implemented in this series:
>
>   1. Load LDFW (Loadable Firmware) on E850-96 board. It's needed to make
>      TRNG SMC commands functional. To do so, add the default eMMC
>      partition table and implement reading and applying LDFW in
>      board_init().
>   2. Add Exynos TRNG driver
>   3. Enable Exynos TRNG driver on E850-96 board. It requires SSS clocks
>      to be enabled, so add those clocks as well.
>
> With this series it's possible to generate random numbers in U-Boot
> (e.g. using 'rng' command). The main reason for RNG enablement on
> E850-96 board -- it's needed for EFI_RNG_PROTOCOL and kaslr, so it's one
> of the requirements to enable EFI boot support on E850-96 board, which
> in turn is needed (among other things) for EBBR spec and SystemReady IR
> certification. With this series it's also possible to use TRNG in Linux
> kernel (which was recently added, see [1] for details), as Linux kernel
> Exynos TRNG driver also relies on LDFW firmware to be loaded in the
> bootloader.
>
> Changes in v2:
>   - Addressed comments for [PATCH 4/5] rng: Add Exynos TRNG driver
>
> [1] https://lore.kernel.org/all/20240618003743.2975-1-semen.protsenko@lin=
aro.org/T/#me6ba1762a254ca438a9715f011d32820babfe2d8
>
> Sam Protsenko (5):
>   board: samsung: e850-96: Add default partitions
>   board: samsung: e850-96: Load LDFW firmware on board init
>   clk: exynos: Add SSS clocks for Exynos850
>   rng: Add Exynos TRNG driver
>   arm: exynos: Enable TRNG on E850-96 board
>
>  arch/arm/dts/exynos850-e850-96-u-boot.dtsi |  11 +
>  arch/arm/mach-exynos/Kconfig               |   2 +
>  board/samsung/e850-96/Makefile             |   4 +-
>  board/samsung/e850-96/e850-96.c            |   6 +-
>  board/samsung/e850-96/e850-96.env          |  26 ++
>  board/samsung/e850-96/fw.c                 | 131 ++++++++++
>  board/samsung/e850-96/fw.h                 |  12 +
>  configs/e850-96_defconfig                  |   1 +
>  drivers/clk/exynos/clk-exynos850.c         |  10 +
>  drivers/rng/Kconfig                        |  13 +
>  drivers/rng/Makefile                       |   1 +
>  drivers/rng/exynos-trng.c                  | 291 +++++++++++++++++++++
>  12 files changed, 504 insertions(+), 4 deletions(-)
>  create mode 100644 board/samsung/e850-96/e850-96.env
>  create mode 100644 board/samsung/e850-96/fw.c
>  create mode 100644 board/samsung/e850-96/fw.h
>  create mode 100644 drivers/rng/exynos-trng.c
>
> --
> 2.39.2
>
