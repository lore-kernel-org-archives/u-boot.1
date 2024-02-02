Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3483FC47258
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 08:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EC36879FE;
	Fri,  2 Feb 2024 09:38:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mGyyYjZd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1AC087956; Fri,  2 Feb 2024 09:38:27 +0100 (CET)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FB85879FE
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 09:38:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7d5bbbe592dso958384241.0
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 00:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706863103; x=1707467903; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RXEGh/erDdsTtFSpQQLpenwkurAUQo7QGTMVvo1KVFU=;
 b=mGyyYjZdu9jictXdUue553MeF1onbMtEXgW5upZi1bG5VL+V/5ejFhnSu6+o+nxlLz
 PNVr5xL1ejDirtnBDGvw3uPfhYHMA6lOz7z5tglXXie8PdBkFQhP4Vvz4tM+hj2Ql8O6
 4u2BB9gw5S/gtabrFGS1tDba3psUfw9s2S+c+Y/lN7afVx58d11MnUqmU+BWWAHyN4KJ
 4kxbjXs28/UHRvPqUd55BO4X3B2CBEsR4KBmPVwCAQQ7caTIVBLv6DNo0UOEzicxZTXq
 8dr903ViA/xVcC6R8JmiWftMFoicH6fX/NE0PiDkFAEYq7/du+fy8frXnCOT6Xq4juaU
 QrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706863103; x=1707467903;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RXEGh/erDdsTtFSpQQLpenwkurAUQo7QGTMVvo1KVFU=;
 b=Zo+p9RMD/Q3ZPynpR0hPVc7u/jYoIgaz4F6hkm5//V6z7EsdLYA8YBMIN0Tmcbbi34
 SdEl5oSny6OpeLCoSnq/S2ToUQuwb3qHqpd8eQMHLIQPqDqpSAsehhzljgka3B8jU7G4
 6nv4oXPEkesifAHi3heWNYgXia37FAvhNMcYpHBvmYkLLnz0M2Rms8vH9Lc57++olFC2
 Ih7gs7+7HQTEHZE6sqn+UeAXYY3aLA4lgl3TpQKFtzoGoLF+c4G6yTdhOUIesh5uktDF
 idlUTDBabuGhbDjMrKOaUhbkj+o6ms9IcpdmTuers4/KYJdWE+lbHqjwhmtfdX+ZI1CB
 temQ==
X-Gm-Message-State: AOJu0YzfRNdowqsAGXRr+QnjSsw8OKE4fy6eCHK5EC9ntNZG2K/BsHkl
 qUWaBvZ4jG3Tlfp8PHSQR67R4s7U8CVIcVX5bMU7srY6Q7RXut9BRxdHS1vPgQvHZPvhqXehXSX
 f9u/abTvEj4jvOqoQxU8oSLeRU/tcC5TPpgtm7w==
X-Google-Smtp-Source: AGHT+IGlhSwmp7xYseWOoRCqsHFObu0TQwa9xKcPun/IBAPRrM4emc2EcJNP9VupfyQQYKSlnSOIfgSscFwnVAdTcmA=
X-Received: by 2002:a67:e9cd:0:b0:46c:fcd9:c615 with SMTP id
 q13-20020a67e9cd000000b0046cfcd9c615mr2145527vso.24.1706863103643; Fri, 02
 Feb 2024 00:38:23 -0800 (PST)
MIME-Version: 1.0
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
 <20240130-b4-qcom-common-target-v3-27-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-27-e523cbf9e556@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 2 Feb 2024 14:08:12 +0530
Message-ID: <CAFA6WYMOndY_UeLAqTAq2oZnBotESfVbRwG7MrweNwu40HtR7g@mail.gmail.com>
Subject: Re: [PATCH v3 27/36] dts: msm8916: replace with upstream DTS
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

On Tue, 30 Jan 2024 at 19:35, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Drop the U-Boot specific dragonboard410c.dts in favour of the upstream
> msm8916-sbc.dts. No additional changes are needed to this DTS for U-Boot
> support.
>
> Taken from kernel tag v6.7
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/dts/Makefile                   |    2 +-
>  arch/arm/dts/apq8016-sbc-u-boot.dtsi    |   11 +
>  arch/arm/dts/apq8016-sbc.dts            |  729 +++++++++
>  arch/arm/dts/dragonboard410c-uboot.dtsi |   44 -
>  arch/arm/dts/dragonboard410c.dts        |  221 ---
>  arch/arm/dts/msm8916.dtsi               | 2702 +++++++++++++++++++++++++++++++
>  configs/dragonboard410c_defconfig       |    2 +-
>  7 files changed, 3444 insertions(+), 267 deletions(-)
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 92a4465f5f41..4c8b29b983a4 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -628,7 +628,7 @@ dtb-$(CONFIG_TARGET_SL28) += fsl-ls1028a-kontron-sl28.dtb \
>
>  dtb-$(CONFIG_TARGET_TEN64) += fsl-ls1088a-ten64.dtb
>
> -dtb-$(CONFIG_ARCH_SNAPDRAGON) += dragonboard410c.dtb \
> +dtb-$(CONFIG_ARCH_SNAPDRAGON) += apq8016-sbc.dtb \
>         dragonboard820c.dtb \
>         sdm845-db845c.dtb \
>         sdm845-samsung-starqltechn.dtb \
> diff --git a/arch/arm/dts/apq8016-sbc-u-boot.dtsi b/arch/arm/dts/apq8016-sbc-u-boot.dtsi
> new file mode 100644
> index 000000000000..838e629a8ade
> --- /dev/null
> +++ b/arch/arm/dts/apq8016-sbc-u-boot.dtsi
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024, Linaro Ltd.
> + */
> +
> +/ {
> +       /* When running as a first-stage bootloader this isn't filled in automatically */
> +       memory@80000000 {
> +               reg = <0 0x80000000 0 0x3da00000>;
> +       };
> +};

With U-Boot booting as the first stage bootloader, we have to enable
the serial driver prior to relocation. Although we have
DM_FLAG_PRE_RELOC for clock and the serial driver, what about the
pinctrl driver required to configure UART specific pins prior to
relocation? Without following change we get broken U-Boot log without
header prints:

diff --git a/arch/arm/dts/apq8016-sbc-u-boot.dtsi
b/arch/arm/dts/apq8016-sbc-u-boot.dtsi
index 838e629a8ade..0a21732be6cb 100644
--- a/arch/arm/dts/apq8016-sbc-u-boot.dtsi
+++ b/arch/arm/dts/apq8016-sbc-u-boot.dtsi
@@ -9,3 +9,11 @@
                reg = <0 0x80000000 0 0x3da00000>;
        };
 };
+
+&tlmm {
+       bootph-all;
+
+       blsp-uart2-default-state {
+               bootph-all;
+       };
+};

Fixes broken U-Boot log:

S - Flash Throughput, 82000 KB/s  (1503304 Bytes,  18330 us)
S - DDR Frequency, 400 MHz
Core:  135 devices, 20 uclasses, devicetree: board
MMC:   mmc@7824900: 0, mmc@7864900: 1
Loading Environment from MMC... OK
In:    serial@78b0000
Out:   serial@78b0000
Err:   serial@78b0000
## Error: Can't overwrite "serial#"
## Error inserting "serial#" variable, errno=1
Net:   No ethernet found.
Hit any key to stop autoboot:  0
dragonboard410c =>

-Sumit
