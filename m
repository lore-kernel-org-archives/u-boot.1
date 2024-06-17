Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCFAC2BA15
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 14:08:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC1C488271;
	Mon, 17 Jun 2024 16:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="XMYk9rd1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4EE68829B; Mon, 17 Jun 2024 16:08:26 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72E808819D
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 16:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-dff36345041so1368871276.3
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 07:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1718633303; x=1719238103;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NvR7TAUXxO9QqrvUsG3vxBH4wD591rX/N/4zgou3Ez8=;
 b=XMYk9rd10XGG9w0o38XP87rVl2EigFr58kJUnQeq0l4OwksU3n1gfcTMvk7FWsEtrW
 hxtQ8CmsB0F/tNgHF3QFmi9pdiv3sKo89xsPJNprqEjjLAnLv96pvg4lDPTTzLX3xFc4
 P20TLCBVPL5WncC5bIIyAygN2OFaDMXMJUgL1KeS4K/LbRUI5sGLbPYG72KBRNsneKGJ
 qZi8jSpx/W1AGU3kmvKyhbOg7ODazcGU0bOEPAm8d2go8/W5PEM0oeuRf2aLgvCfESdz
 4RpOk4JP0rNxpqI3UwazUGvsw0g331JwF22v7k8f37/n9gLH2/EuwarZjMshdztxGaf3
 wSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718633303; x=1719238103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NvR7TAUXxO9QqrvUsG3vxBH4wD591rX/N/4zgou3Ez8=;
 b=LhbPyAbzHpePnfJuf2AOqsWBM2wui5cfRv0UO4GAsbIHWgAJTcSRHLHDJ8A3sF8HDI
 BvB9xfEzSVJJprlsYqU/0Ldu8QP6CAp5+jWYL7nIjEd4kZG3gtSGlZqt8sEQLaj1l/+C
 54IEr5N28e3hpnhq6yQufLOZdg8GCQ8j8iaDjUTjEwkOUseDtpXtgRURJfzElybPFDMk
 ljIPGJ8YQy2DVXyeKZ1VzFHZrkdjBn5cbYfoCYEZqrGPOdjbJYmOoSfuFdeAx4+mVDVD
 o6AYHZK7zP69lIibuGXAQJXlZ73Mb4qVoFE+2wKp4LYEPc7FqC3c+FPVTXCyvbRUoXis
 +uSw==
X-Gm-Message-State: AOJu0Yz1AtDPVZNhSs6sY2fXTDoIJbJeKYvezE18gllwtDApiHI934Yv
 ugFtCYSHtemWHLaor/L2XHAEMfq5sYCuxbUx1Pr/nO2V0QCAKwXUac6IcaLrHnB/GtihbOe0JKV
 ej2VQz1LcR87FKWteMO40JKi6ANPTnSBRfuGeOdSTDzhHLUgYlw==
X-Google-Smtp-Source: AGHT+IFahM50sZlOM7/V6t1lkFIIBbCgTXC5oWC2FauBXpaLwfXKSIRQ8VXfwrCZ8E0PcFLyfOIDlueY0vdR8xWAuXM=
X-Received: by 2002:a25:8208:0:b0:dff:fc:a586 with SMTP id
 3f1490d57ef6-dff154d3305mr8476411276.56.1718633302873; 
 Mon, 17 Jun 2024 07:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <9c8ee7a4c7a16367438a92a4c9581bac9d968f84.1712815454.git.michal.simek@amd.com>
In-Reply-To: <9c8ee7a4c7a16367438a92a4c9581bac9d968f84.1712815454.git.michal.simek@amd.com>
From: Michal Simek <monstr@monstr.eu>
Date: Mon, 17 Jun 2024 16:08:11 +0200
Message-ID: <CAHTX3dJzPe56Oc2BnxDjJZNHymq94WjK0KBZQ4M6Unqichh2DA@mail.gmail.com>
Subject: Re: [PATCH] xilinx: Enable NVMEM framework for all platforms
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Raju Kumar Pothuraju <rajukumar.pothuraju@amd.com>,
 Simon Glass <sjg@chromium.org>, 
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

=C4=8Dt 11. 4. 2024 v 8:04 odes=C3=ADlatel Michal Simek <michal.simek@amd.c=
om> napsal:
>
> Boards which have for example MAC address in eeprom but not in Xilinx
> format (legacy or FRU) could reference it via nvmem cells.
> For example:
>
> &gem0 {
>         nvmem-cells =3D <&mac>;
>         nvmem-cell-names =3D "mac-address";
> };
>
> &eeprom {
>         #address-cells =3D <1>;
>         #size-cells =3D <1>;
>         mac: mac-address@f0 {
>                 reg =3D <0xf0 6>;
>         };
> };
>
> For getting it work above DT changes are required but also CONFIG_NVMEM
> should be enabled. That's why enable it by default in generic defconfigs
> to be able to use it directly by changing DT only.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  configs/xilinx_versal_net_virt_defconfig | 1 +
>  configs/xilinx_versal_virt_defconfig     | 1 +
>  configs/xilinx_zynq_virt_defconfig       | 1 +
>  configs/xilinx_zynqmp_virt_defconfig     | 1 +
>  4 files changed, 4 insertions(+)
>
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_ve=
rsal_net_virt_defconfig
> index 40c6a29a16e3..d9e2e050ceb6 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -80,6 +80,7 @@ CONFIG_I2C_MUX_PCA954x=3Dy
>  CONFIG_DM_MAILBOX=3Dy
>  CONFIG_ZYNQMP_IPI=3Dy
>  CONFIG_MISC=3Dy
> +CONFIG_NVMEM=3Dy
>  CONFIG_I2C_EEPROM=3Dy
>  CONFIG_SUPPORT_EMMC_BOOT=3Dy
>  CONFIG_MMC_IO_VOLTAGE=3Dy
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal=
_virt_defconfig
> index c9b8a6de0133..95a671db363e 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -83,6 +83,7 @@ CONFIG_I2C_MUX_PCA954x=3Dy
>  CONFIG_DM_MAILBOX=3Dy
>  CONFIG_ZYNQMP_IPI=3Dy
>  CONFIG_MISC=3Dy
> +CONFIG_NVMEM=3Dy
>  CONFIG_I2C_EEPROM=3Dy
>  CONFIG_SUPPORT_EMMC_BOOT=3Dy
>  CONFIG_MMC_IO_VOLTAGE=3Dy
> diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_vir=
t_defconfig
> index 708cfe96b63b..e025256dc561 100644
> --- a/configs/xilinx_zynq_virt_defconfig
> +++ b/configs/xilinx_zynq_virt_defconfig
> @@ -107,6 +107,7 @@ CONFIG_I2C_MUX_PCA954x=3Dy
>  CONFIG_LED=3Dy
>  CONFIG_LED_GPIO=3Dy
>  CONFIG_MISC=3Dy
> +CONFIG_NVMEM=3Dy
>  CONFIG_I2C_EEPROM=3Dy
>  CONFIG_MMC_SDHCI=3Dy
>  CONFIG_MMC_SDHCI_ZYNQ=3Dy
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp=
_virt_defconfig
> index 18931cffbbd6..296adf066b10 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -147,6 +147,7 @@ CONFIG_I2C_MUX_PCA954x=3Dy
>  CONFIG_LED=3Dy
>  CONFIG_LED_GPIO=3Dy
>  CONFIG_MISC=3Dy
> +CONFIG_NVMEM=3Dy
>  CONFIG_I2C_EEPROM=3Dy
>  CONFIG_SUPPORT_EMMC_BOOT=3Dy
>  CONFIG_MMC_IO_VOLTAGE=3Dy
> --
> 2.44.0
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
