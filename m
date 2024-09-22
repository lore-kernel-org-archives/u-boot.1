Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D78CF9C64
	for <u-boot@archiver.kernel.org>; Sun, 22 Sep 2024 13:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99D2288C0F;
	Sun, 22 Sep 2024 15:42:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OwDrMksF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F301E88C10; Sun, 22 Sep 2024 15:42:44 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A12F88B58
 for <u-boot@lists.denx.de>; Sun, 22 Sep 2024 15:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c5bca6603aso475069a12.1
 for <u-boot@lists.denx.de>; Sun, 22 Sep 2024 06:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727012562; x=1727617362; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jovu5pQtAUeV723A9hIYuYDITCjG6fwu+CvbOOH0Btk=;
 b=OwDrMksFBtCqQWfqQYw3AEfg/8A7gFaixaSpUFsjCQC2MQjyRv/7e+R2gs8m8+rUK/
 PoH2HPDmS2r3wkGx2pzF8n3UgpyERtDU6cHNcLk/SX830Tcl6LiqPe1DzhsjYm2aU3D6
 Fkhcur6EQr6Q2mqZFQlps/sbU8v5ETu4WmIEbdNbMFdWMAzwjWp8q1fZ4N4S1cnYueE4
 YTRtQ0+vhMR6h3gAMa2O3DLvZWOdKkvMj6X079dX4l0C1rd0+QFbTT+JPScXQx7Dh7Pq
 mxmECtTh/OoS66L/Kmk6VTm+O0VYTvK4+RoZyXApTZIVGDs61ck2mQoDcNl0lPmPEJFn
 TOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727012562; x=1727617362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jovu5pQtAUeV723A9hIYuYDITCjG6fwu+CvbOOH0Btk=;
 b=wyYCDMPNijtHjYX+ZU75gOg0nJw92Z6UBdnN8EaLRu95CmOkTW8d+El+u4jbSyjnPw
 eRxQ9YW+bLYestRQxsNgPk/llb+8dKi5xRdSTTpO/VX1EQ9BM4ile8vlsusgeLpmb9J5
 pwKeshRFB2LUAxpUaHxSO8vGT4yB2B4jyCsXpoGcem4+OAC2u2e5H1A3xy1KEJK0D0Uf
 doom+rmiCSKJBVOswcCsutGFREskV6qC9qvW95IL4CPeL0Mq3ew0YCjrIggY+8ja5ddW
 4gV7OmUr2Uk0GNVGcgX92NZ1kTAa53DTQDLkMap86t8e6Xrk9VY+atRmdDyOLu/qxIMR
 +nlw==
X-Gm-Message-State: AOJu0YxfPQsvFVQylClUNz4CIAUPEfof9bFsqQtnUcJhpfF/jeJ+aelN
 roZf3yNwKyx3XeNiiezg5Cbq7HrqOtdZjqp5679LcgFc2Fz/q/E47QMgab2l96MTLuTnZTzaCAK
 h38nvaZ6ND45ib/GGb1y3Xe0tLTo=
X-Google-Smtp-Source: AGHT+IF4voQtPl3s0Eb6PmBu9UaxMPjI0wM5LpALRDVVtlr+XlFgMnnVenNfyFfRaraFqa3m3ugWL3YxW7bbRcynGXY=
X-Received: by 2002:a05:6402:5483:b0:5be:eb19:ee56 with SMTP id
 4fb4d7f45d1cf-5c464dea205mr7196964a12.24.1727012562302; Sun, 22 Sep 2024
 06:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240919140022.511067-1-macroalpha82@gmail.com>
In-Reply-To: <20240919140022.511067-1-macroalpha82@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 22 Sep 2024 14:43:11 +0100
Message-ID: <CALeDE9Oz==j74RngXeHsCp5FWsGO14hP2RSbnFLB=a2bz6h1tw@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] Anbernic RGxx3 Bootloader Fixes
To: Chris Morgan <macroalpha82@gmail.com>
Cc: u-boot@lists.denx.de, jonas@kwiboo.se, trini@konsulko.com, 
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org, 
 dsimic@manjaro.org, quentin.schulz@cherry.de, 
 Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Chris,

> Update the Anbernic RGxx3 "device" to use upstream device-trees,
> add logic to detect a different vdd_cpu regulator, and implement a
> fix to allow the panel auto-detection to run when using mainline
> A-TF.
>
> Note that *Linux* still cannot use mainline A-TF because of the missing
> SCMI clock and reset functionality, but this patch series at least
> ensures that this board can boot once Linux is ready.

Have you got a link to this upstream in the kernel lists? Is there
patches posted? I think I have seen a similar issue when playing with
mainline TF-A the other day on the Quartz64.

Peter

> Chris Morgan (4):
>   board: rockchip: Convert Anbernic RGxx3 to OF_UPSTREAM
>   board: rockchip: Add vdd_cpu reg fixup for RGXX3 Series
>   board: rockchip: Remove ARM SCMI Support from RGxx3
>   board: rockchip: Enable PD_VO before driver access
>
>  .../dts/rk3566-anbernic-rg353p-u-boot.dtsi    |  34 ++
>  .../arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi |  52 ---
>  arch/arm/dts/rk3566-anbernic-rgxx3.dts        |  28 --
>  arch/arm/mach-rockchip/rk3568/rk3568.c        |   6 +
>  board/anbernic/rgxx3_rk3566/MAINTAINERS       |   4 +-
>  board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c    | 359 +++++++++++++++---
>  configs/anbernic-rgxx3-rk3566_defconfig       |  12 +-
>  7 files changed, 347 insertions(+), 148 deletions(-)
>  create mode 100644 arch/arm/dts/rk3566-anbernic-rg353p-u-boot.dtsi
>  delete mode 100644 arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
>  delete mode 100644 arch/arm/dts/rk3566-anbernic-rgxx3.dts
>
> --
> 2.34.1
>
