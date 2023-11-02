Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795D0C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 08:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3645875ED;
	Thu,  2 Nov 2023 09:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hl2Rm8wk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64C47875E5; Thu,  2 Nov 2023 09:17:24 +0100 (CET)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C165875ED
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 09:17:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7b9bd9f8bfaso260414241.0
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 01:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698913037; x=1699517837; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AxaSgPOiJEQ5pgTwHOIklrp64M63hPjmSo6sDtbzWBc=;
 b=hl2Rm8wkof02VYdyOJLNkYqjEtdJxvO+7srSpw5KgwO2lkjdHG3b8zsDeRqvIR2/xA
 Qt0t5AmAkRV58oMafnWbK05tZbGNsh/ikUo7wSt6mLsRcdlsPbab4kwT5imEgiFmR2HD
 8ZlMVFmw4xoIWvk6+ni40vkv++hSVwJ3kFORHXHYEOSxdqONrJY61SguU5RNAKh+neOk
 ga21gmpzRMNJB37FxtwiImCBySvQjhN/s8hPW9kDnXRZ8ebzQR7lh0hJ3AhISXc1PLHp
 pZunLnsc8PVwl5SQrAe583QPRFRLbzHV3FoYw+GNamwt/4D0ieLvo5S3SEjwfQHZwn5K
 3ypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698913037; x=1699517837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AxaSgPOiJEQ5pgTwHOIklrp64M63hPjmSo6sDtbzWBc=;
 b=EOsgXcdC84ccXNmVdRB9n0ZRItkjihdV9MNlZZ0swL61XzboIrloNYd8EotxYL62EM
 MnyHBnyicRiQSlHmouJ9KJA6f4dvTFWFMx28JMgyfoAqe1VjZZXBdtQWIa6jcw7j2elg
 Zda4AwRYzYPx1QpxwvmI4lxDbTaL/G48YmTpC7+3fJe8mRMQsKmRd8PvErB6KhITZyEk
 +QH4N/I36zsIqzKWLuLLR+wKpYpDwA2M0YS7hI4zdGa/1ZkEk656EzD7H1YX9/YbHi/v
 O6Uy20wDjzxUW4+h5STxc/JZtHUlYsBc1MA/1q3wCj+wBwfQ0bPs61ifnZRZPEWS/2ob
 m+nA==
X-Gm-Message-State: AOJu0YyhKnmet9sviZL6qn69e6EEu9fmVXVifktaqrXHWahb2oZkmwwT
 +8PujAzLsr2uyvs9kh5rwaGicWf9qvBPugpS49sDcWmnzYbzfn5gY/U=
X-Google-Smtp-Source: AGHT+IGcXOrSuuB+6txaW17QIzCi4tV247RQcym1a1T3QwdGk9XRKLQLE17dTwt/uLsIWTAXQ691uq3xZj+R8+6MMj8=
X-Received: by 2002:a67:e006:0:b0:452:f119:20f with SMTP id
 c6-20020a67e006000000b00452f119020fmr17572955vsl.8.1698913036997; Thu, 02 Nov
 2023 01:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-b4-qcom-clk-v2-0-6572bc2be690@linaro.org>
 <20231024-b4-qcom-clk-v2-5-6572bc2be690@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v2-5-6572bc2be690@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 2 Nov 2023 13:47:05 +0530
Message-ID: <CAFA6WYNrTR_mvbEKDoN9S1ytYH5JeLd_qm68FepLakdGCvMzYA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] clk/qcom: use function pointers for enable and
 set_rate
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, u-boot@lists.denx.de
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

On Tue, 31 Oct 2023 at 03:54, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Currently, it isn't possible to build clock drivers for more than one
> platform due to how the msm_enable() and msm_set_rate() callbacks are
> implemented.
>
> Extend qcom_clk_data to include function pointers for these and convert
> all platforms to use them.
>
> Previously, clock drivers relied on include/configs/<board.h> to include the
> board specific sysmap header, however as most of the header contents are clock
> driver related, import the contents directly into each clock driver and
> remove the header. The only exception here is the dragonboard820c board file
> which includes some pinctrl macros, those are also inlined.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  .../mach-snapdragon/include/mach/sysmap-apq8016.h  | 39 ----------
>  .../mach-snapdragon/include/mach/sysmap-apq8096.h  | 37 ---------
>  .../mach-snapdragon/include/mach/sysmap-qcs404.h   | 88 ----------------------
>  .../mach-snapdragon/include/mach/sysmap-sdm845.h   | 45 -----------
>  board/qualcomm/dragonboard820c/dragonboard820c.c   |  6 +-
>  drivers/clk/qcom/clock-apq8016.c                   | 37 +++++++--
>  drivers/clk/qcom/clock-apq8096.c                   | 33 ++++++--
>  drivers/clk/qcom/clock-ipq4019.c                   | 10 ++-
>  drivers/clk/qcom/clock-qcom.c                      | 17 +++--
>  drivers/clk/qcom/clock-qcom.h                      |  5 ++
>  drivers/clk/qcom/clock-qcs404.c                    | 85 ++++++++++++++++++++-
>  drivers/clk/qcom/clock-sdm845.c                    | 22 +++++-
>  include/configs/dragonboard410c.h                  |  1 -
>  include/configs/dragonboard820c.h                  |  1 -
>  include/configs/dragonboard845c.h                  |  1 -
>  include/configs/qcs404-evb.h                       |  1 -
>  16 files changed, 185 insertions(+), 243 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/mach-snapdragon/include/mach/sysmap-apq8016.h b/arch/arm/mach-snapdragon/include/mach/sysmap-apq8016.h
> deleted file mode 100644
> index d9a3b1af986d..000000000000
> --- a/arch/arm/mach-snapdragon/include/mach/sysmap-apq8016.h
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Qualcomm APQ8916 sysmap
> - *
> - * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
> - */
> -#ifndef _MACH_SYSMAP_APQ8016_H
> -#define _MACH_SYSMAP_APQ8016_H
> -
> -#define GICD_BASE                      (0x0b000000)
> -#define GICC_BASE                      (0x0b002000)
> -
> -/* Clocks: (from CLK_CTL_BASE)  */
> -#define GPLL0_STATUS                   (0x2101C)
> -#define APCS_GPLL_ENA_VOTE             (0x45000)
> -#define APCS_CLOCK_BRANCH_ENA_VOTE (0x45004)
> -
> -#define SDCC_BCR(n)                    ((n * 0x1000) + 0x41000)
> -#define SDCC_CMD_RCGR(n)               ((n * 0x1000) + 0x41004)
> -#define SDCC_CFG_RCGR(n)               ((n * 0x1000) + 0x41008)
> -#define SDCC_M(n)                      ((n * 0x1000) + 0x4100C)
> -#define SDCC_N(n)                      ((n * 0x1000) + 0x41010)
> -#define SDCC_D(n)                      ((n * 0x1000) + 0x41014)
> -#define SDCC_APPS_CBCR(n)              ((n * 0x1000) + 0x41018)
> -#define SDCC_AHB_CBCR(n)               ((n * 0x1000) + 0x4101C)
> -
> -/* BLSP1 AHB clock (root clock for BLSP) */
> -#define BLSP1_AHB_CBCR                 0x1008
> -
> -/* Uart clock control registers */
> -#define BLSP1_UART2_BCR                        (0x3028)
> -#define BLSP1_UART2_APPS_CBCR          (0x302C)
> -#define BLSP1_UART2_APPS_CMD_RCGR      (0x3034)
> -#define BLSP1_UART2_APPS_CFG_RCGR      (0x3038)
> -#define BLSP1_UART2_APPS_M             (0x303C)
> -#define BLSP1_UART2_APPS_N             (0x3040)
> -#define BLSP1_UART2_APPS_D             (0x3044)
> -
> -#endif
> diff --git a/arch/arm/mach-snapdragon/include/mach/sysmap-apq8096.h b/arch/arm/mach-snapdragon/include/mach/sysmap-apq8096.h
> deleted file mode 100644
> index 36a902bd9290..000000000000
> --- a/arch/arm/mach-snapdragon/include/mach/sysmap-apq8096.h
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Qualcomm APQ8096 sysmap
> - *
> - * (C) Copyright 2017 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> - */
> -#ifndef _MACH_SYSMAP_APQ8096_H
> -#define _MACH_SYSMAP_APQ8096_H
> -
> -#define TLMM_BASE_ADDR                 (0x1010000)
> -
> -/* Strength (sdc1) */
> -#define SDC1_HDRV_PULL_CTL_REG         (TLMM_BASE_ADDR + 0x0012D000)
> -
> -/* Clocks: (from CLK_CTL_BASE)  */
> -#define GPLL0_STATUS                   (0x0000)
> -#define APCS_GPLL_ENA_VOTE             (0x52000)
> -#define APCS_CLOCK_BRANCH_ENA_VOTE     (0x52004)
> -
> -#define SDCC2_BCR                      (0x14000) /* block reset */
> -#define SDCC2_APPS_CBCR                        (0x14004) /* branch control */
> -#define SDCC2_AHB_CBCR                 (0x14008)
> -#define SDCC2_CMD_RCGR                 (0x14010)
> -#define SDCC2_CFG_RCGR                 (0x14014)
> -#define SDCC2_M                                (0x14018)
> -#define SDCC2_N                                (0x1401C)
> -#define SDCC2_D                                (0x14020)
> -
> -#define BLSP2_AHB_CBCR                 (0x25004)
> -#define BLSP2_UART2_APPS_CBCR          (0x29004)
> -#define BLSP2_UART2_APPS_CMD_RCGR      (0x2900C)
> -#define BLSP2_UART2_APPS_CFG_RCGR      (0x29010)
> -#define BLSP2_UART2_APPS_M             (0x29014)
> -#define BLSP2_UART2_APPS_N             (0x29018)
> -#define BLSP2_UART2_APPS_D             (0x2901C)
> -
> -#endif
> diff --git a/arch/arm/mach-snapdragon/include/mach/sysmap-qcs404.h b/arch/arm/mach-snapdragon/include/mach/sysmap-qcs404.h
> deleted file mode 100644
> index 5768fb13775c..000000000000
> --- a/arch/arm/mach-snapdragon/include/mach/sysmap-qcs404.h
> +++ /dev/null
> @@ -1,88 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Qualcomm QCS404 sysmap
> - *
> - * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
> - */
> -#ifndef _MACH_SYSMAP_QCS404_H
> -#define _MACH_SYSMAP_QCS404_H
> -
> -#define GICD_BASE                      (0x0b000000)
> -#define GICC_BASE                      (0x0b002000)
> -
> -/* Clocks: (from CLK_CTL_BASE)  */
> -#define GPLL0_STATUS                   (0x21000)
> -#define GPLL1_STATUS                   (0x20000)
> -#define APCS_GPLL_ENA_VOTE             (0x45000)
> -#define APCS_CLOCK_BRANCH_ENA_VOTE     (0x45004)
> -
> -/* BLSP1 AHB clock (root clock for BLSP) */
> -#define BLSP1_AHB_CBCR                 0x1008
> -
> -/* Uart clock control registers */
> -#define BLSP1_UART2_BCR                        (0x3028)
> -#define BLSP1_UART2_APPS_CBCR          (0x302C)
> -#define BLSP1_UART2_APPS_CMD_RCGR      (0x3034)
> -#define BLSP1_UART2_APPS_CFG_RCGR      (0x3038)
> -#define BLSP1_UART2_APPS_M             (0x303C)
> -#define BLSP1_UART2_APPS_N             (0x3040)
> -#define BLSP1_UART2_APPS_D             (0x3044)
> -
> -/* I2C controller clock control registerss */
> -#define BLSP1_QUP0_I2C_APPS_CBCR       (0x6028)
> -#define BLSP1_QUP0_I2C_APPS_CMD_RCGR   (0x602C)
> -#define BLSP1_QUP0_I2C_APPS_CFG_RCGR   (0x6030)
> -#define BLSP1_QUP1_I2C_APPS_CBCR       (0x2008)
> -#define BLSP1_QUP1_I2C_APPS_CMD_RCGR   (0x200C)
> -#define BLSP1_QUP1_I2C_APPS_CFG_RCGR   (0x2010)
> -#define BLSP1_QUP2_I2C_APPS_CBCR       (0x3010)
> -#define BLSP1_QUP2_I2C_APPS_CMD_RCGR   (0x3000)
> -#define BLSP1_QUP2_I2C_APPS_CFG_RCGR   (0x3004)
> -#define BLSP1_QUP3_I2C_APPS_CBCR       (0x4020)
> -#define BLSP1_QUP3_I2C_APPS_CMD_RCGR   (0x4000)
> -#define BLSP1_QUP3_I2C_APPS_CFG_RCGR   (0x4004)
> -#define BLSP1_QUP4_I2C_APPS_CBCR       (0x5020)
> -#define BLSP1_QUP4_I2C_APPS_CMD_RCGR   (0x5000)
> -#define BLSP1_QUP4_I2C_APPS_CFG_RCGR   (0x5004)
> -
> -/* SD controller clock control registers */
> -#define SDCC_BCR(n)                    (((n) * 0x1000) + 0x41000)
> -#define SDCC_CMD_RCGR(n)               (((n) * 0x1000) + 0x41004)
> -#define SDCC_CFG_RCGR(n)               (((n) * 0x1000) + 0x41008)
> -#define SDCC_M(n)                      (((n) * 0x1000) + 0x4100C)
> -#define SDCC_N(n)                      (((n) * 0x1000) + 0x41010)
> -#define SDCC_D(n)                      (((n) * 0x1000) + 0x41014)
> -#define SDCC_APPS_CBCR(n)              (((n) * 0x1000) + 0x41018)
> -#define SDCC_AHB_CBCR(n)               (((n) * 0x1000) + 0x4101C)
> -
> -/* USB-3.0 controller clock control registers */
> -#define SYS_NOC_USB3_CBCR              (0x26014)
> -#define USB30_BCR                      (0x39000)
> -#define USB3PHY_BCR                    (0x39008)
> -#define USB30_MASTER_CBCR              (0x3900C)
> -#define USB30_SLEEP_CBCR               (0x39010)
> -#define USB30_MOCK_UTMI_CBCR           (0x39014)
> -#define USB30_MOCK_UTMI_CMD_RCGR       (0x3901C)
> -#define USB30_MOCK_UTMI_CFG_RCGR       (0x39020)
> -#define USB30_MASTER_CMD_RCGR          (0x39028)
> -#define USB30_MASTER_CFG_RCGR          (0x3902C)
> -#define USB30_MASTER_M                 (0x39030)
> -#define USB30_MASTER_N                 (0x39034)
> -#define USB30_MASTER_D                 (0x39038)
> -#define USB2A_PHY_SLEEP_CBCR           (0x4102C)
> -#define USB_HS_PHY_CFG_AHB_CBCR                (0x41030)
> -
> -/* ETH controller clock control registers */
> -#define ETH_PTP_CBCR                   (0x4e004)
> -#define ETH_RGMII_CBCR                 (0x4e008)
> -#define ETH_SLAVE_AHB_CBCR             (0x4e00c)
> -#define ETH_AXI_CBCR                   (0x4e010)
> -#define EMAC_PTP_CMD_RCGR              (0x4e014)
> -#define EMAC_PTP_CFG_RCGR              (0x4e018)
> -#define EMAC_CMD_RCGR                  (0x4e01c)
> -#define EMAC_CFG_RCGR                  (0x4e020)
> -#define EMAC_M                         (0x4e024)
> -#define EMAC_N                         (0x4e028)
> -#define EMAC_D                         (0x4e02c)
> -
> -#endif
> diff --git a/arch/arm/mach-snapdragon/include/mach/sysmap-sdm845.h b/arch/arm/mach-snapdragon/include/mach/sysmap-sdm845.h
> deleted file mode 100644
> index a0010d71594e..000000000000
> --- a/arch/arm/mach-snapdragon/include/mach/sysmap-sdm845.h
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Qualcomm SDM845 sysmap
> - *
> - * (C) Copyright 2021 Dzmitry Sankouski <dsankouski@gmail.com>
> - */
> -#ifndef _MACH_SYSMAP_SDM845_H
> -#define _MACH_SYSMAP_SDM845_H
> -
> -#define TLMM_BASE_ADDR                 (0x1010000)
> -
> -/* Strength (sdc1) */
> -#define SDC1_HDRV_PULL_CTL_REG         (TLMM_BASE_ADDR + 0x0012D000)
> -
> -/* Clocks: (from CLK_CTL_BASE)  */
> -#define GPLL0_STATUS                   (0x0000)
> -#define APCS_GPLL_ENA_VOTE             (0x52000)
> -#define APCS_CLOCK_BRANCH_ENA_VOTE     (0x52004)
> -
> -#define SDCC2_BCR                      (0x14000) /* block reset */
> -#define SDCC2_APPS_CBCR                        (0x14004) /* branch control */
> -#define SDCC2_AHB_CBCR                 (0x14008)
> -#define SDCC2_CMD_RCGR                 (0x1400c)
> -#define SDCC2_CFG_RCGR                 (0x14010)
> -#define SDCC2_M                                (0x14014)
> -#define SDCC2_N                                (0x14018)
> -#define SDCC2_D                                (0x1401C)
> -
> -#define RCG2_CFG_REG                   0x4
> -#define M_REG                  0x8
> -#define N_REG                  0xc
> -#define D_REG                  0x10
> -
> -#define SE9_AHB_CBCR                   (0x25004)
> -#define SE9_UART_APPS_CBCR             (0x29004)
> -#define SE9_UART_APPS_CMD_RCGR (0x18148)
> -#define SE9_UART_APPS_CFG_RCGR (0x1814C)
> -#define SE9_UART_APPS_M                (0x18150)
> -#define SE9_UART_APPS_N                (0x18154)
> -#define SE9_UART_APPS_D                (0x18158)
> -
> -#define USB30_SEC_GDSCR                (0x10004)
> -#define USB30_PRIM_GDSCR       (0xf004)
> -
> -#endif
> diff --git a/board/qualcomm/dragonboard820c/dragonboard820c.c b/board/qualcomm/dragonboard820c/dragonboard820c.c
> index f9cc762a25cd..6785bf58e949 100644
> --- a/board/qualcomm/dragonboard820c/dragonboard820c.c
> +++ b/board/qualcomm/dragonboard820c/dragonboard820c.c
> @@ -7,7 +7,6 @@
>
>  #include <cpu_func.h>
>  #include <init.h>
> -#include <asm/arch/sysmap-apq8096.h>
>  #include <env.h>
>  #include <asm/cache.h>
>  #include <asm/global_data.h>
> @@ -20,6 +19,11 @@
>  #include <asm/psci.h>
>  #include <asm/gpio.h>
>
> +#define TLMM_BASE_ADDR                  (0x1010000)
> +
> +/* Strength (sdc1) */
> +#define SDC1_HDRV_PULL_CTL_REG          (TLMM_BASE_ADDR + 0x0012D000)
> +
>  DECLARE_GLOBAL_DATA_PTR;
>
>  int dram_init(void)
> diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
> index 3bddbd275906..3f44252c453e 100644
> --- a/drivers/clk/qcom/clock-apq8016.c
> +++ b/drivers/clk/qcom/clock-apq8016.c
> @@ -16,6 +16,32 @@
>
>  #include "clock-qcom.h"
>
> +/* Clocks: (from CLK_CTL_BASE)  */
> +#define GPLL0_STATUS                   (0x2101C)
> +#define APCS_GPLL_ENA_VOTE             (0x45000)
> +#define APCS_CLOCK_BRANCH_ENA_VOTE (0x45004)
> +
> +#define SDCC_BCR(n)                    ((n * 0x1000) + 0x41000)
> +#define SDCC_CMD_RCGR(n)               ((n * 0x1000) + 0x41004)
> +#define SDCC_CFG_RCGR(n)               ((n * 0x1000) + 0x41008)
> +#define SDCC_M(n)                      ((n * 0x1000) + 0x4100C)
> +#define SDCC_N(n)                      ((n * 0x1000) + 0x41010)
> +#define SDCC_D(n)                      ((n * 0x1000) + 0x41014)
> +#define SDCC_APPS_CBCR(n)              ((n * 0x1000) + 0x41018)
> +#define SDCC_AHB_CBCR(n)               ((n * 0x1000) + 0x4101C)
> +
> +/* BLSP1 AHB clock (root clock for BLSP) */
> +#define BLSP1_AHB_CBCR                 0x1008
> +
> +/* Uart clock control registers */
> +#define BLSP1_UART2_BCR                        (0x3028)
> +#define BLSP1_UART2_APPS_CBCR          (0x302C)
> +#define BLSP1_UART2_APPS_CMD_RCGR      (0x3034)
> +#define BLSP1_UART2_APPS_CFG_RCGR      (0x3038)
> +#define BLSP1_UART2_APPS_M             (0x303C)
> +#define BLSP1_UART2_APPS_N             (0x3040)
> +#define BLSP1_UART2_APPS_D             (0x3044)
> +
>  /* GPLL0 clock control registers */
>  #define GPLL0_STATUS_ACTIVE BIT(17)
>
> @@ -94,7 +120,7 @@ static int clk_init_uart(struct msm_clk_priv *priv)
>         return 0;
>  }
>
> -ulong msm_set_rate(struct clk *clk, ulong rate)
> +static ulong apq8016_clk_set_rate(struct clk *clk, ulong rate)
>  {
>         struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>
> @@ -113,15 +139,14 @@ ulong msm_set_rate(struct clk *clk, ulong rate)
>         }
>  }
>
> -int msm_enable(struct clk *clk)
> -{
> -       return 0;
> -}
> +static struct msm_clk_data apq8016_clk_data = {
> +       .set_rate = apq8016_clk_set_rate,
> +};
>
>  static const struct udevice_id gcc_apq8016_of_match[] = {
>         {
>                 .compatible = "qcom,gcc-apq8016",
> -               /* TODO: add reset map */
> +               .data = (ulong)&apq8016_clk_data,
>         },
>         { }
>  };
> diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
> index 64b8cdf4c54b..75633a7c2af8 100644
> --- a/drivers/clk/qcom/clock-apq8096.c
> +++ b/drivers/clk/qcom/clock-apq8096.c
> @@ -16,6 +16,28 @@
>
>  #include "clock-qcom.h"
>
> +/* Clocks: (from CLK_CTL_BASE)  */
> +#define GPLL0_STATUS                   (0x0000)
> +#define APCS_GPLL_ENA_VOTE             (0x52000)
> +#define APCS_CLOCK_BRANCH_ENA_VOTE     (0x52004)
> +
> +#define SDCC2_BCR                      (0x14000) /* block reset */
> +#define SDCC2_APPS_CBCR                        (0x14004) /* branch control */
> +#define SDCC2_AHB_CBCR                 (0x14008)
> +#define SDCC2_CMD_RCGR                 (0x14010)
> +#define SDCC2_CFG_RCGR                 (0x14014)
> +#define SDCC2_M                                (0x14018)
> +#define SDCC2_N                                (0x1401C)
> +#define SDCC2_D                                (0x14020)
> +
> +#define BLSP2_AHB_CBCR                 (0x25004)
> +#define BLSP2_UART2_APPS_CBCR          (0x29004)
> +#define BLSP2_UART2_APPS_CMD_RCGR      (0x2900C)
> +#define BLSP2_UART2_APPS_CFG_RCGR      (0x29010)
> +#define BLSP2_UART2_APPS_M             (0x29014)
> +#define BLSP2_UART2_APPS_N             (0x29018)
> +#define BLSP2_UART2_APPS_D             (0x2901C)
> +
>  /* GPLL0 clock control registers */
>  #define GPLL0_STATUS_ACTIVE            BIT(30)
>  #define APCS_GPLL_ENA_VOTE_GPLL0       BIT(0)
> @@ -80,7 +102,7 @@ static int clk_init_uart(struct msm_clk_priv *priv)
>         return 0;
>  }
>
> -ulong msm_set_rate(struct clk *clk, ulong rate)
> +static ulong apq8096_clk_set_rate(struct clk *clk, ulong rate)
>  {
>         struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>
> @@ -95,15 +117,14 @@ ulong msm_set_rate(struct clk *clk, ulong rate)
>         }
>  }
>
> -int msm_enable(struct clk *clk)
> -{
> -       return 0;
> -}
> +static struct msm_clk_data apq8096_clk_data = {
> +       .set_rate = apq8096_clk_set_rate,
> +};
>
>  static const struct udevice_id gcc_apq8096_of_match[] = {
>         {
>                 .compatible = "qcom,gcc-apq8096",
> -               /* TODO: add reset map */
> +               .data = (ulong)&apq8096_clk_data,
>         },
>         { }
>  };
> diff --git a/drivers/clk/qcom/clock-ipq4019.c b/drivers/clk/qcom/clock-ipq4019.c
> index db869f874219..d693776d339d 100644
> --- a/drivers/clk/qcom/clock-ipq4019.c
> +++ b/drivers/clk/qcom/clock-ipq4019.c
> @@ -16,7 +16,7 @@
>
>  #include "clock-qcom.h"
>
> -ulong msm_set_rate(struct clk *clk, ulong rate)
> +static ulong ipq4019_clk_set_rate(struct clk *clk, ulong rate)
>  {
>         switch (clk->id) {
>         case GCC_BLSP1_UART1_APPS_CLK: /*UART1*/
> @@ -27,7 +27,7 @@ ulong msm_set_rate(struct clk *clk, ulong rate)
>         }
>  }
>
> -int msm_enable(struct clk *clk)
> +static int ipq4019_clk_enable(struct clk *clk)
>  {
>         switch (clk->id) {
>         case GCC_BLSP1_QUP1_SPI_APPS_CLK: /*SPI1*/
> @@ -123,7 +123,9 @@ static const struct qcom_reset_map gcc_ipq4019_resets[] = {
>         [GCC_SPDM_BCR] = {0x25000, 0},
>  };
>
> -static struct msm_clk_data ipq4019_data = {
> +static struct msm_clk_data ipq4019_clk_data = {
> +       .enable = ipq4019_clk_enable,
> +       .set_rate = ipq4019_clk_set_rate,
>         .resets = gcc_ipq4019_resets,
>         .num_resets = ARRAY_SIZE(gcc_ipq4019_resets),
>  };
> @@ -131,7 +133,7 @@ static struct msm_clk_data ipq4019_data = {
>  static const struct udevice_id gcc_ipq4019_of_match[] = {
>         {
>                 .compatible = "qcom,gcc-ipq4019",
> -               .data = (ulong)&ipq4019_data,
> +               .data = (ulong)&ipq4019_clk_data,
>         },
>         { }
>  };
> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index a661837e4e11..77bcaacd1583 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -28,9 +28,6 @@
>  #define CBCR_BRANCH_ENABLE_BIT  BIT(0)
>  #define CBCR_BRANCH_OFF_BIT     BIT(31)
>
> -extern ulong msm_set_rate(struct clk *clk, ulong rate);
> -extern int msm_enable(struct clk *clk);
> -
>  /* Enable clock controlled by CBC soft macro */
>  void clk_enable_cbc(phys_addr_t cbcr)
>  {
> @@ -160,12 +157,22 @@ static int msm_clk_probe(struct udevice *dev)
>
>  static ulong msm_clk_set_rate(struct clk *clk, ulong rate)
>  {
> -       return msm_set_rate(clk, rate);
> +       struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(clk->dev);
> +
> +       if (data->set_rate)
> +               return data->set_rate(clk, rate);
> +
> +       return 0;
>  }
>
>  static int msm_clk_enable(struct clk *clk)
>  {
> -       return msm_enable(clk);
> +       struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(clk->dev);
> +
> +       if (data->enable)
> +               return data->enable(clk);
> +
> +       return 0;
>  }
>
>  static struct clk_ops msm_clk_ops = {
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index 6d399db987b6..86f9ff6eb2f6 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -49,11 +49,16 @@ struct qcom_reset_map {
>         u8 bit;
>  };
>
> +struct clk;
> +
>  struct msm_clk_data {
>         const struct qcom_reset_map     *resets;
>         unsigned long                   num_resets;
>         const struct gate_clk           *clks;
>         unsigned long                   num_clks;
> +
> +       int (*enable)(struct clk *clk);
> +       unsigned long (*set_rate)(struct clk *clk, unsigned long rate);
>  };
>
>  struct msm_clk_priv {
> diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
> index 10ac3609be42..9ad580b50fc8 100644
> --- a/drivers/clk/qcom/clock-qcs404.c
> +++ b/drivers/clk/qcom/clock-qcs404.c
> @@ -15,6 +15,81 @@
>
>  #include "clock-qcom.h"
>
> +/* Clocks: (from CLK_CTL_BASE)  */
> +#define GPLL0_STATUS                   (0x21000)
> +#define GPLL1_STATUS                   (0x20000)
> +#define APCS_GPLL_ENA_VOTE             (0x45000)
> +#define APCS_CLOCK_BRANCH_ENA_VOTE     (0x45004)
> +
> +/* BLSP1 AHB clock (root clock for BLSP) */
> +#define BLSP1_AHB_CBCR                 0x1008
> +
> +/* Uart clock control registers */
> +#define BLSP1_UART2_BCR                        (0x3028)
> +#define BLSP1_UART2_APPS_CBCR          (0x302C)
> +#define BLSP1_UART2_APPS_CMD_RCGR      (0x3034)
> +#define BLSP1_UART2_APPS_CFG_RCGR      (0x3038)
> +#define BLSP1_UART2_APPS_M             (0x303C)
> +#define BLSP1_UART2_APPS_N             (0x3040)
> +#define BLSP1_UART2_APPS_D             (0x3044)
> +
> +/* I2C controller clock control registerss */
> +#define BLSP1_QUP0_I2C_APPS_CBCR       (0x6028)
> +#define BLSP1_QUP0_I2C_APPS_CMD_RCGR   (0x602C)
> +#define BLSP1_QUP0_I2C_APPS_CFG_RCGR   (0x6030)
> +#define BLSP1_QUP1_I2C_APPS_CBCR       (0x2008)
> +#define BLSP1_QUP1_I2C_APPS_CMD_RCGR   (0x200C)
> +#define BLSP1_QUP1_I2C_APPS_CFG_RCGR   (0x2010)
> +#define BLSP1_QUP2_I2C_APPS_CBCR       (0x3010)
> +#define BLSP1_QUP2_I2C_APPS_CMD_RCGR   (0x3000)
> +#define BLSP1_QUP2_I2C_APPS_CFG_RCGR   (0x3004)
> +#define BLSP1_QUP3_I2C_APPS_CBCR       (0x4020)
> +#define BLSP1_QUP3_I2C_APPS_CMD_RCGR   (0x4000)
> +#define BLSP1_QUP3_I2C_APPS_CFG_RCGR   (0x4004)
> +#define BLSP1_QUP4_I2C_APPS_CBCR       (0x5020)
> +#define BLSP1_QUP4_I2C_APPS_CMD_RCGR   (0x5000)
> +#define BLSP1_QUP4_I2C_APPS_CFG_RCGR   (0x5004)
> +
> +/* SD controller clock control registers */
> +#define SDCC_BCR(n)                    (((n) * 0x1000) + 0x41000)
> +#define SDCC_CMD_RCGR(n)               (((n) * 0x1000) + 0x41004)
> +#define SDCC_CFG_RCGR(n)               (((n) * 0x1000) + 0x41008)
> +#define SDCC_M(n)                      (((n) * 0x1000) + 0x4100C)
> +#define SDCC_N(n)                      (((n) * 0x1000) + 0x41010)
> +#define SDCC_D(n)                      (((n) * 0x1000) + 0x41014)
> +#define SDCC_APPS_CBCR(n)              (((n) * 0x1000) + 0x41018)
> +#define SDCC_AHB_CBCR(n)               (((n) * 0x1000) + 0x4101C)
> +
> +/* USB-3.0 controller clock control registers */
> +#define SYS_NOC_USB3_CBCR              (0x26014)
> +#define USB30_BCR                      (0x39000)
> +#define USB3PHY_BCR                    (0x39008)
> +#define USB30_MASTER_CBCR              (0x3900C)
> +#define USB30_SLEEP_CBCR               (0x39010)
> +#define USB30_MOCK_UTMI_CBCR           (0x39014)
> +#define USB30_MOCK_UTMI_CMD_RCGR       (0x3901C)
> +#define USB30_MOCK_UTMI_CFG_RCGR       (0x39020)
> +#define USB30_MASTER_CMD_RCGR          (0x39028)
> +#define USB30_MASTER_CFG_RCGR          (0x3902C)
> +#define USB30_MASTER_M                 (0x39030)
> +#define USB30_MASTER_N                 (0x39034)
> +#define USB30_MASTER_D                 (0x39038)
> +#define USB2A_PHY_SLEEP_CBCR           (0x4102C)
> +#define USB_HS_PHY_CFG_AHB_CBCR                (0x41030)
> +
> +/* ETH controller clock control registers */
> +#define ETH_PTP_CBCR                   (0x4e004)
> +#define ETH_RGMII_CBCR                 (0x4e008)
> +#define ETH_SLAVE_AHB_CBCR             (0x4e00c)
> +#define ETH_AXI_CBCR                   (0x4e010)
> +#define EMAC_PTP_CMD_RCGR              (0x4e014)
> +#define EMAC_PTP_CFG_RCGR              (0x4e018)
> +#define EMAC_CMD_RCGR                  (0x4e01c)
> +#define EMAC_CFG_RCGR                  (0x4e020)
> +#define EMAC_M                         (0x4e024)
> +#define EMAC_N                         (0x4e028)
> +#define EMAC_D                         (0x4e02c)
> +
>
>  /* GPLL0 clock control registers */
>  #define GPLL0_STATUS_ACTIVE BIT(31)
> @@ -112,7 +187,7 @@ static const struct bcr_regs blsp1_qup4_i2c_apps_regs = {
>         /* mnd_width = 0 */
>  };
>
> -ulong msm_set_rate(struct clk *clk, ulong rate)
> +static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
>  {
>         struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>
> @@ -157,7 +232,7 @@ ulong msm_set_rate(struct clk *clk, ulong rate)
>         return 0;
>  }
>
> -int msm_enable(struct clk *clk)
> +static int qcs404_clk_enable(struct clk *clk)
>  {
>         struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>
> @@ -263,15 +338,17 @@ static const struct qcom_reset_map qcs404_gcc_resets[] = {
>         [GCC_WDSP_RESTART] = {0x19000},
>  };
>
> -static const struct msm_clk_data qcs404_gcc_data = {
> +static const struct msm_clk_data qcs404_clk_gcc_data = {
>         .resets = qcs404_gcc_resets,
>         .num_resets = ARRAY_SIZE(qcs404_gcc_resets),
> +       .enable = qcs404_clk_enable,
> +       .set_rate = qcs404_clk_set_rate,
>  };
>
>  static const struct udevice_id gcc_qcs404_of_match[] = {
>         {
>                 .compatible = "qcom,gcc-qcs404",
> -               .data = (ulong)&qcs404_gcc_data
> +               .data = (ulong)&qcs404_clk_gcc_data
>         },
>         { }
>  };
> diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
> index 57124e2a661a..02bdc403b41d 100644
> --- a/drivers/clk/qcom/clock-sdm845.c
> +++ b/drivers/clk/qcom/clock-sdm845.c
> @@ -19,6 +19,17 @@
>
>  #include "clock-qcom.h"
>
> +#define SE9_AHB_CBCR           0x25004
> +#define SE9_UART_APPS_CBCR     0x29004
> +#define SE9_UART_APPS_CMD_RCGR 0x18148
> +#define SE9_UART_APPS_CFG_RCGR 0x1814C
> +#define SE9_UART_APPS_M                0x18150
> +#define SE9_UART_APPS_N                0x18154
> +#define SE9_UART_APPS_D                0x18158
> +
> +#define USB30_SEC_GDSCR                0x10004
> +#define USB30_PRIM_GDSCR       0xf004
> +
>  #define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
>
>  struct freq_tbl {
> @@ -72,7 +83,7 @@ const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate)
>         return f - 1;
>  }
>
> -ulong msm_set_rate(struct clk *clk, ulong rate)
> +static ulong sdm845_clk_set_rate(struct clk *clk, ulong rate)
>  {
>         struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>         const struct freq_tbl *freq;
> @@ -148,7 +159,7 @@ static const struct gate_clk sdm845_clks[] = {
>         GATE_CLK(GCC_USB_PHY_CFG_AHB2PHY_CLK,           0x6a004, 0x00000001),
>  };
>
> -int msm_enable(struct clk *clk)
> +static int sdm845_clk_enable(struct clk *clk)
>  {
>         struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>
> @@ -179,17 +190,20 @@ static const struct qcom_reset_map sdm845_gcc_resets[] = {
>         [GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
>  };
>
> -static const struct msm_clk_data qcs404_gcc_data = {
> +static struct msm_clk_data sdm845_clk_data = {
>         .resets = sdm845_gcc_resets,
>         .num_resets = ARRAY_SIZE(sdm845_gcc_resets),
>         .clks = sdm845_clks,
>         .num_clks = ARRAY_SIZE(sdm845_clks),
> +
> +       .enable = sdm845_clk_enable,
> +       .set_rate = sdm845_clk_set_rate,
>  };
>
>  static const struct udevice_id gcc_sdm845_of_match[] = {
>         {
>                 .compatible = "qcom,gcc-sdm845",
> -               .data = (ulong)&qcs404_gcc_data,
> +               .data = (ulong)&sdm845_clk_data,
>         },
>         { }
>  };
> diff --git a/include/configs/dragonboard410c.h b/include/configs/dragonboard410c.h
> index 73aec348458a..00102cd5c4f5 100644
> --- a/include/configs/dragonboard410c.h
> +++ b/include/configs/dragonboard410c.h
> @@ -9,7 +9,6 @@
>  #define __CONFIGS_DRAGONBOARD410C_H
>
>  #include <linux/sizes.h>
> -#include <asm/arch/sysmap-apq8016.h>
>
>  /* Build new ELF image from u-boot.bin (U-Boot + appended DTB) */
>
> diff --git a/include/configs/dragonboard820c.h b/include/configs/dragonboard820c.h
> index 499708371113..c6d9182ccc9d 100644
> --- a/include/configs/dragonboard820c.h
> +++ b/include/configs/dragonboard820c.h
> @@ -9,7 +9,6 @@
>  #define __CONFIGS_DRAGONBOARD820C_H
>
>  #include <linux/sizes.h>
> -#include <asm/arch/sysmap-apq8096.h>
>
>  /* Physical Memory Map */
>
> diff --git a/include/configs/dragonboard845c.h b/include/configs/dragonboard845c.h
> index c1e590fae2a5..14a8a2ca049e 100644
> --- a/include/configs/dragonboard845c.h
> +++ b/include/configs/dragonboard845c.h
> @@ -9,7 +9,6 @@
>  #define __CONFIGS_SDM845_H
>
>  #include <linux/sizes.h>
> -#include <asm/arch/sysmap-sdm845.h>
>
>  #define CFG_SYS_BAUDRATE_TABLE { 115200, 230400, 460800, 921600 }
>
> diff --git a/include/configs/qcs404-evb.h b/include/configs/qcs404-evb.h
> index 8ea59aa21ca6..9501d43665e9 100644
> --- a/include/configs/qcs404-evb.h
> +++ b/include/configs/qcs404-evb.h
> @@ -9,7 +9,6 @@
>  #define __CONFIGS_QCS404EVB_H
>
>  #include <linux/sizes.h>
> -#include <asm/arch/sysmap-qcs404.h>
>
>  #define CFG_SYS_BAUDRATE_TABLE { 115200, 230400, 460800, 921600 }
>
>
> --
> 2.42.0
>
