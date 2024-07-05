Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D0CC30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 05:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A113A884FC;
	Fri,  5 Jul 2024 07:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JP/Byji4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16DB1885F6; Fri,  5 Jul 2024 07:32:42 +0200 (CEST)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB4F883AF
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 07:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-48ffdfae096so26616137.0
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 22:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720157558; x=1720762358; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ck2R5r7bNhyg+9EjMp8Fbb9LVBBSJaz15qtBLDPiYuw=;
 b=JP/Byji4tdcFHsXecEezMqPW08Zc718DMv2z94J+vob2pOyELrq77ncxIIs73ULUlA
 akaJmOnKJE4NKthxfhc+gpUX570xgaB8xnN8LaqWj23Ookybc9ZAHdwe8YazTT3lgiU5
 xYQq14zb9HYCuZkzknw747dBky7HXRy+o29vsPUQZCreB5F0n2HZgzBWlCVk5bZeqLKd
 v/1VoGzacvQDEI1gtSXknWZUFMH8/16p73DDwODK5B69fiR186ja/+z9t7Hw0vb2JFVu
 HfpYISecyiBAtSjUs3uj+GEbxiUyzpiDHRbvNoQhk57LZpk/FeWJzU+zsF1gkS2qF8au
 jR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720157558; x=1720762358;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ck2R5r7bNhyg+9EjMp8Fbb9LVBBSJaz15qtBLDPiYuw=;
 b=SFtAqYddDSYzBt0Hwish4O8CyZI/Tz78wgyY09gUxLYWEnr2GNoLmXZ4wqLSMPYdUb
 ao2CchVB5YUCfqyVvZVjvhefT+3Bpywed1nfa9GlHjIunMEkl2OTN6n0EJM2wcfZHtxT
 V7oRZ1j3Y2lHYBVLAul3DUzkkvqzQrey1hMAeCvG4qIrCtfj2CrXAnI0I7EzjAKbJYVz
 XctfIjeUZD/8RkwvJEvHFfbWY5G/FBHaqnKQyOx6lFas4nRBfHbvPIydbIuJPtHkmXfI
 oSmF6CidPlffX8Ne5Q6C3qVfEL4AT40VuZhQuJ2j1a0dELb4JiZIBkAGn54QPXPYYLDu
 Wv+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuMs9qGYv1anfuGPb0yi5EHEFFE+7vvJdkrEq1QsL0mlrv71hQ4vxEttQ4kYshyNUY+GBj0MtVpq8PazoFGNQfiwXsXA==
X-Gm-Message-State: AOJu0YyGpFG/B0MtZEOBBPpVMsonMRYciWDfHXCKyKF7IQBGgbvyiQhx
 LBP6YAFRJpGqW+r1iWvRVBdmEP3xmtTA9f5qyDPBym+SRhBN94PdF+BLTy8sWLAeSoiIshtIMIK
 NDYZOILf1G+v6TEWFpavfBau4mynKBmS3GLEVHdg1f49RRq3U2OM=
X-Google-Smtp-Source: AGHT+IEzOmJVzgAUpRJwiUtwoiL1buSvJLIIHKM52PldUpj5A2YwGQ/1AX3KG84DCbZaE1hXEnN8Fnj0mnNIAQDoMZI=
X-Received: by 2002:a67:ea8e:0:b0:48f:a749:56d9 with SMTP id
 ada2fe7eead31-48fee6c39ddmr3180953137.5.1720157558626; Thu, 04 Jul 2024
 22:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240704-tsd-rk3588-nvme-v1-0-fb9e8dde9570@cherry.de>
In-Reply-To: <20240704-tsd-rk3588-nvme-v1-0-fb9e8dde9570@cherry.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 5 Jul 2024 11:02:27 +0530
Message-ID: <CAFA6WYPSxKbxO5itbNFBPPk+Qz=DxY1DUUpv0hruQaPqdB926g@mail.gmail.com>
Subject: Re: [PATCH 0/3] rockchip: enable PCIe/NVMe support for Theobroma
 RK3588 devices
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Klaus Goger <klaus.goger@cherry.de>, Heiko Stuebner <heiko.stuebner@cherry.de>,
 u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Stuebner <heiko@sntech.de>
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

Hi Quentin,

On Thu, 4 Jul 2024 at 18:23, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> Jaguar has an M.2 M-KEY slot for NVMes and Tiger exposes the signals to
> the Q7 connector which is then routed on the Haikou devkit's `PCI
> Express` connector. With the help of a PCIe to NVMe adapter, NVMes can
> be used on Tiger Haikou as well.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Heiko Stuebner (1):
>       arm64: dts: rockchip: add PCIe3 support on rk3588-jaguar
>

Feels really nice to see subtree cherry picking in action here.

> Quentin Schulz (2):
>       rockchip: jaguar-rk3588: add PCIe M.2 M-KEY NVMe support
>       rockchip: tiger-rk3588: add PCIe support
>
>  configs/jaguar-rk3588_defconfig                   |  5 ++
>  configs/tiger-rk3588_defconfig                    |  4 ++
>  dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts | 59 +++++++++++++++++++++++
>  3 files changed, 68 insertions(+)

FWIW, for the series:

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> ---
> base-commit: 0f073e022ddc5070e5df1d053e4bdc1874fbcc0f
> change-id: 20240704-tsd-rk3588-nvme-aa133c24cb9e
>
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
>
