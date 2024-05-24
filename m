Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A393FC25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 05:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF758881F6;
	Fri, 24 May 2024 07:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oQCTna1X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 384A288624; Fri, 24 May 2024 07:04:26 +0200 (CEST)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCEEE881F6
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 07:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-80324bcb9ebso615261241.0
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 22:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716527063; x=1717131863; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v3tJyhRA7Wq2r2RyW/OhTOU8Vp47DA8vFq1CpbB+78Q=;
 b=oQCTna1XTjfUrbD4YrGg+GO5zje1Gz4EICOTEilSCgmX0/fHE3aP2xp7VdBnMiuYsi
 yIT18ELA8EbMsVe7leXQGm45ZIseXP1aHzHcexMJwX+l3DvVqkpUUsSsG/IEx0bARuCr
 2RraJADWIVcMUUwy30+gI4ts+QDx5jSYAwac4Rk6gHPK5cJjiFzW5EzG/W/+DPDHl5Ow
 YvN255UvKx5NvSGqzmEZIMbQJGnTYGxQRf/++YaouDXbyOd+iTwjq3Ahzds/1ZoZ3C0P
 ijee51ngegHn1HFWVJX2fDDy5vqf8bDhEgGs84Pybgqf4O59s0HDoNJx6H0V1uljk7IF
 zsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716527063; x=1717131863;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v3tJyhRA7Wq2r2RyW/OhTOU8Vp47DA8vFq1CpbB+78Q=;
 b=QNp3rkeY2fZ9YmA6zKKa5+aJSYhGztpuHwPzJv0DO6ZZH0/QGB/dBIvHU38zJREjyD
 AMu5dd9kcpRv+q1Y43sk2QuuJG9bmiCrsbUieRTzI0pptwFAo9XCrrS4DiNkUmtNwTa5
 Sr6u4HwFoIclmMgtOnQEsFypsX/m4QnneXqjF84RbOlWPglCVWqpiL6o8Wk4UEeMAzi2
 2czsOcYkGE6N8pJN+7N3IC7Pa2cy6XIYOT0sYzlZUMxMnTx8v+L1hJVANnJJeHQgqUpV
 04PDFckrxcxtu0of4DniqazEEiagTof5bryhiNxkVWC35NAa/OmpwlN9Mw9dJ+MMrmzF
 dasg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVllH9QoGLWRH/EL6vR8cha/P27hn/DNSjUyA/GRS4CGPmJUPvfZ8H616+XCeB8mlyyElCCMC29sIVOflnYKH0Z48hoTA==
X-Gm-Message-State: AOJu0YzNvkzDztg//mmrwh8OgfoCMh+chw40ALOMNdhSQ9qS7nyGBWHV
 bWO6haGQtij4PI8YQ74vYDZEsEKq0pb+8CYCnprR29MAFWLhWzjKYIA2Pg2BpRI74PKhwBeUXPd
 bu/p1ha5o/hE5BBKHtiVXBh5jdc/33HJwaicSDA==
X-Google-Smtp-Source: AGHT+IGC/3ul3M8NfIHNCcxmeg+VCF8qlws7usLTroFIKiG00+h0a/xahSVfcu7L0fzNwW4tUDt6G8r/pDuyZJPRNuQ=
X-Received: by 2002:a05:6102:4c4b:b0:48a:370c:dea8 with SMTP id
 ada2fe7eead31-48a3851f0b3mr1449871137.9.1716527062690; Thu, 23 May 2024
 22:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240523173815.63628-1-robert.marko@sartura.hr>
 <20240523173815.63628-2-robert.marko@sartura.hr>
In-Reply-To: <20240523173815.63628-2-robert.marko@sartura.hr>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 24 May 2024 10:34:11 +0530
Message-ID: <CAFA6WYMvu99gXxdtPc5kv4FZw=u5vX5oeRCyXdpQQbau3Xytgg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: clock: qcom: ipq4019: drop downstream
 file
To: Robert Marko <robert.marko@sartura.hr>
Cc: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org, 
 lukma@denx.de, seanga2@gmail.com, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 j.beck@linefinity.com
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

On Thu, 23 May 2024 at 23:08, Robert Marko <robert.marko@sartura.hr> wrote:
>
> IPQ4019 clock dt-bindings are available in Linux upstream, and we can just
> use those instead of carrying a downstream file that matches the upstream one
> anyway.
>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
> Changes in v2:
> * Drop the downstream dt-bindings header as it matches the upstream Linux one
>
>  include/dt-bindings/clock/qcom,gcc-ipq4019.h | 169 -------------------
>  1 file changed, 169 deletions(-)
>  delete mode 100644 include/dt-bindings/clock/qcom,gcc-ipq4019.h
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/include/dt-bindings/clock/qcom,gcc-ipq4019.h b/include/dt-bindings/clock/qcom,gcc-ipq4019.h
> deleted file mode 100644
> index 7e8a7be6dc..0000000000
> --- a/include/dt-bindings/clock/qcom,gcc-ipq4019.h
> +++ /dev/null
> @@ -1,169 +0,0 @@
> -/* Copyright (c) 2015 The Linux Foundation. All rights reserved.
> - *
> - * Permission to use, copy, modify, and/or distribute this software for any
> - * purpose with or without fee is hereby granted, provided that the above
> - * copyright notice and this permission notice appear in all copies.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
> - * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
> - * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
> - * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
> - * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> - * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
> - * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> - *
> - */
> -#ifndef __QCOM_CLK_IPQ4019_H__
> -#define __QCOM_CLK_IPQ4019_H__
> -
> -#define GCC_DUMMY_CLK                                  0
> -#define AUDIO_CLK_SRC                                  1
> -#define BLSP1_QUP1_I2C_APPS_CLK_SRC                    2
> -#define BLSP1_QUP1_SPI_APPS_CLK_SRC                    3
> -#define BLSP1_QUP2_I2C_APPS_CLK_SRC                    4
> -#define BLSP1_QUP2_SPI_APPS_CLK_SRC                    5
> -#define BLSP1_UART1_APPS_CLK_SRC                       6
> -#define BLSP1_UART2_APPS_CLK_SRC                       7
> -#define GCC_USB3_MOCK_UTMI_CLK_SRC                     8
> -#define GCC_APPS_CLK_SRC                               9
> -#define GCC_APPS_AHB_CLK_SRC                           10
> -#define GP1_CLK_SRC                                    11
> -#define GP2_CLK_SRC                                    12
> -#define GP3_CLK_SRC                                    13
> -#define SDCC1_APPS_CLK_SRC                             14
> -#define FEPHY_125M_DLY_CLK_SRC                         15
> -#define WCSS2G_CLK_SRC                                 16
> -#define WCSS5G_CLK_SRC                                 17
> -#define GCC_APSS_AHB_CLK                               18
> -#define GCC_AUDIO_AHB_CLK                              19
> -#define GCC_AUDIO_PWM_CLK                              20
> -#define GCC_BLSP1_AHB_CLK                              21
> -#define GCC_BLSP1_QUP1_I2C_APPS_CLK                    22
> -#define GCC_BLSP1_QUP1_SPI_APPS_CLK                    23
> -#define GCC_BLSP1_QUP2_I2C_APPS_CLK                    24
> -#define GCC_BLSP1_QUP2_SPI_APPS_CLK                    25
> -#define GCC_BLSP1_UART1_APPS_CLK                       26
> -#define GCC_BLSP1_UART2_APPS_CLK                       27
> -#define GCC_DCD_XO_CLK                                 28
> -#define GCC_GP1_CLK                                    29
> -#define GCC_GP2_CLK                                    30
> -#define GCC_GP3_CLK                                    31
> -#define GCC_BOOT_ROM_AHB_CLK                           32
> -#define GCC_CRYPTO_AHB_CLK                             33
> -#define GCC_CRYPTO_AXI_CLK                             34
> -#define GCC_CRYPTO_CLK                                 35
> -#define GCC_ESS_CLK                                    36
> -#define GCC_IMEM_AXI_CLK                               37
> -#define GCC_IMEM_CFG_AHB_CLK                           38
> -#define GCC_PCIE_AHB_CLK                               39
> -#define GCC_PCIE_AXI_M_CLK                             40
> -#define GCC_PCIE_AXI_S_CLK                             41
> -#define GCC_PCNOC_AHB_CLK                              42
> -#define GCC_PRNG_AHB_CLK                               43
> -#define GCC_QPIC_AHB_CLK                               44
> -#define GCC_QPIC_CLK                                   45
> -#define GCC_SDCC1_AHB_CLK                              46
> -#define GCC_SDCC1_APPS_CLK                             47
> -#define GCC_SNOC_PCNOC_AHB_CLK                         48
> -#define GCC_SYS_NOC_125M_CLK                           49
> -#define GCC_SYS_NOC_AXI_CLK                            50
> -#define GCC_TCSR_AHB_CLK                               51
> -#define GCC_TLMM_AHB_CLK                               52
> -#define GCC_USB2_MASTER_CLK                            53
> -#define GCC_USB2_SLEEP_CLK                             54
> -#define GCC_USB2_MOCK_UTMI_CLK                         55
> -#define GCC_USB3_MASTER_CLK                            56
> -#define GCC_USB3_SLEEP_CLK                             57
> -#define GCC_USB3_MOCK_UTMI_CLK                         58
> -#define GCC_WCSS2G_CLK                                 59
> -#define GCC_WCSS2G_REF_CLK                             60
> -#define GCC_WCSS2G_RTC_CLK                             61
> -#define GCC_WCSS5G_CLK                                 62
> -#define GCC_WCSS5G_REF_CLK                             63
> -#define GCC_WCSS5G_RTC_CLK                             64
> -#define GCC_APSS_DDRPLL_VCO                            65
> -#define GCC_SDCC_PLLDIV_CLK                            66
> -#define GCC_FEPLL_VCO                                  67
> -#define GCC_FEPLL125_CLK                               68
> -#define GCC_FEPLL125DLY_CLK                            69
> -#define GCC_FEPLL200_CLK                               70
> -#define GCC_FEPLL500_CLK                               71
> -#define GCC_FEPLL_WCSS2G_CLK                           72
> -#define GCC_FEPLL_WCSS5G_CLK                           73
> -#define GCC_APSS_CPU_PLLDIV_CLK                                74
> -#define GCC_PCNOC_AHB_CLK_SRC                          75
> -
> -#define WIFI0_CPU_INIT_RESET                           0
> -#define WIFI0_RADIO_SRIF_RESET                         1
> -#define WIFI0_RADIO_WARM_RESET                         2
> -#define WIFI0_RADIO_COLD_RESET                         3
> -#define WIFI0_CORE_WARM_RESET                          4
> -#define WIFI0_CORE_COLD_RESET                          5
> -#define WIFI1_CPU_INIT_RESET                           6
> -#define WIFI1_RADIO_SRIF_RESET                         7
> -#define WIFI1_RADIO_WARM_RESET                         8
> -#define WIFI1_RADIO_COLD_RESET                         9
> -#define WIFI1_CORE_WARM_RESET                          10
> -#define WIFI1_CORE_COLD_RESET                          11
> -#define USB3_UNIPHY_PHY_ARES                           12
> -#define USB3_HSPHY_POR_ARES                            13
> -#define USB3_HSPHY_S_ARES                              14
> -#define USB2_HSPHY_POR_ARES                            15
> -#define USB2_HSPHY_S_ARES                              16
> -#define PCIE_PHY_AHB_ARES                              17
> -#define PCIE_AHB_ARES                                  18
> -#define PCIE_PWR_ARES                                  19
> -#define PCIE_PIPE_STICKY_ARES                          20
> -#define PCIE_AXI_M_STICKY_ARES                         21
> -#define PCIE_PHY_ARES                                  22
> -#define PCIE_PARF_XPU_ARES                             23
> -#define PCIE_AXI_S_XPU_ARES                            24
> -#define PCIE_AXI_M_VMIDMT_ARES                         25
> -#define PCIE_PIPE_ARES                                 26
> -#define PCIE_AXI_S_ARES                                        27
> -#define PCIE_AXI_M_ARES                                        28
> -#define ESS_RESET                                      29
> -#define GCC_BLSP1_BCR                                  30
> -#define GCC_BLSP1_QUP1_BCR                             31
> -#define GCC_BLSP1_UART1_BCR                            32
> -#define GCC_BLSP1_QUP2_BCR                             33
> -#define GCC_BLSP1_UART2_BCR                            34
> -#define GCC_BIMC_BCR                                   35
> -#define GCC_TLMM_BCR                                   36
> -#define GCC_IMEM_BCR                                   37
> -#define GCC_ESS_BCR                                    38
> -#define GCC_PRNG_BCR                                   39
> -#define GCC_BOOT_ROM_BCR                               40
> -#define GCC_CRYPTO_BCR                                 41
> -#define GCC_SDCC1_BCR                                  42
> -#define GCC_SEC_CTRL_BCR                               43
> -#define GCC_AUDIO_BCR                                  44
> -#define GCC_QPIC_BCR                                   45
> -#define GCC_PCIE_BCR                                   46
> -#define GCC_USB2_BCR                                   47
> -#define GCC_USB2_PHY_BCR                               48
> -#define GCC_USB3_BCR                                   49
> -#define GCC_USB3_PHY_BCR                               50
> -#define GCC_SYSTEM_NOC_BCR                             51
> -#define GCC_PCNOC_BCR                                  52
> -#define GCC_DCD_BCR                                    53
> -#define GCC_SNOC_BUS_TIMEOUT0_BCR                      54
> -#define GCC_SNOC_BUS_TIMEOUT1_BCR                      55
> -#define GCC_SNOC_BUS_TIMEOUT2_BCR                      56
> -#define GCC_SNOC_BUS_TIMEOUT3_BCR                      57
> -#define GCC_PCNOC_BUS_TIMEOUT0_BCR                     58
> -#define GCC_PCNOC_BUS_TIMEOUT1_BCR                     59
> -#define GCC_PCNOC_BUS_TIMEOUT2_BCR                     60
> -#define GCC_PCNOC_BUS_TIMEOUT3_BCR                     61
> -#define GCC_PCNOC_BUS_TIMEOUT4_BCR                     62
> -#define GCC_PCNOC_BUS_TIMEOUT5_BCR                     63
> -#define GCC_PCNOC_BUS_TIMEOUT6_BCR                     64
> -#define GCC_PCNOC_BUS_TIMEOUT7_BCR                     65
> -#define GCC_PCNOC_BUS_TIMEOUT8_BCR                     66
> -#define GCC_PCNOC_BUS_TIMEOUT9_BCR                     67
> -#define GCC_TCSR_BCR                                   68
> -#define GCC_QDSS_BCR                                   69
> -#define GCC_MPM_BCR                                    70
> -#define GCC_SPDM_BCR                                   71
> -
> -#endif
> --
> 2.45.1
>
