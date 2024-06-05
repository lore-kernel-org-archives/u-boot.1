Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D289C25B78
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 01:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9DAA88223;
	Wed,  5 Jun 2024 03:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bm1CAXWk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 740AB88193; Wed,  5 Jun 2024 03:44:24 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2E5C88252
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 03:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1717551860; x=1718156660; i=xypron.glpk@gmx.de;
 bh=2yz5/DhXCx0knn/4iWSMipMZHQcJK8lK106uaNcOpiA=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=bm1CAXWkTEeUzt/OWjiUQ73TwzCXe9cepFjzJfGopxMEGQLoGT3zIHNGh9NDQedo
 R6wn8IjFyYV8zXOxm+ge1xsUvFJW1CSdeB/LAkoVqW+fKOYFVgTyLV5MUZn9AKyTO
 Xl8ZrTOeucBSHluyOa7o5TCRpF7TMWyouegfxO8AMbdh8MJGdeN6L7Gd9dUOEFTEb
 Ahg3AgMqHy0sloZoh8H2gptB5AYZzesAvdP8HrhTLxXDsIUv4JhAgiLWiJvAw1nJE
 GQ8oAAOmXr9Q5roZfq68SXP6WPhXtjlsPE7GgpYbmZVeakPzzxYhczy/iPSnq8vrl
 MkBK0NJPqNhfptRm4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([109.42.178.114]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1Obh-1sbsbv2mkN-011j2k; Wed, 05
 Jun 2024 03:44:20 +0200
Date: Wed, 05 Jun 2024 03:44:19 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] efi_loader: select BLK not depends on BLK
User-Agent: K-9 Mail for Android
In-Reply-To: <20240605013742.576403-1-trini@konsulko.com>
References: <20240605013742.576403-1-trini@konsulko.com>
Message-ID: <9ABE0585-36EB-4285-B9C5-6D3F2DCE0AFB@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pwYRBeH0wB6rKFGaBwC9UHYve4hJtwLp9NpTX9jwj7TqaEKkotX
 Vm6QTZQlH4NR3Y2XoimZmKbNmG6IkHqVYhc0U2FwNVV5+2tnFxN9A90MOSfDJtsI8vxkkkc
 NIcPjoFXTicr2D4UgnGvIqSbqCx152sSk59R2C8Sc+ZzbqnOL5G91toUAfax0YRTP58JQDx
 sBOcMHK/PobGdQJmPh+Pg==
UI-OutboundReport: notjunk:1;M01:P0:5uJ1CwEiAc8=;O0Ef6tC7DUy90Our9HIFlGzvsOt
 JbYYt6p29KzWI41R2yT0uTiAhwwzT4iZO4MBYrYxlVG1c5sjCs3Sr1Kve6i/SWlGy9X1nwGmR
 RyvSyPdo5G/LcKTmhx6SsoYMwjiY1KyQa5M7Adp/vHLYy3p/1kvBMw0bD7l+BMci/uP0GyC5k
 C6OokuAWg3WJHY3YhH4wSQaxUQElOdehchn7GLtMQgaRgm4T+P9AJAJD/3CSOvSHMY6zo2ygj
 F+eWJJ9eHo0dRuo5a51GDGcwfpUXmeuCYC3rfKCI/+WujH3HDbZuTThF50laLPxgBBVS7c0aJ
 fKVlBNQQGfp3SL9O4c6rSTecssPal6/IvFM4h7Oi4QayoDkcSFpbNKcGxpgNw7/acuzUgv3lA
 24+I2cDuASek1obnnHsVBB4KblPChaV8ow2Ip1qkd7wShrC/3sweL6Fw7XC9Dlh5arVQ53kib
 yWdcByngFvb++SdxTOSmbcWlW6EA7ok3nJHhstZ1TtuCSJ2PwGIW9WmCpdkMX9KbDcYbPY+2Y
 HB7CcB3amktp0tDZbqJ/+MNinxS0GDh/tAXL3Q0q2GOIOpQNusC8CdGMWI5D47qFrijX3eubS
 IcPY7JclPvjfBxkHrxFA5cyLG5IYvcKKdajlWR/sfvaiYQ3gb3SSxmOLmLRr4ba9ZHhJx8exN
 saW8aKV27xsmN2r8HJZ/oHtFIEkBsRPH725Bpu1W4QhTWCAIG7nVYLvxNtgV3rPx9Qx9HHqi7
 D0Z0b8b3MSZLDPV2QIjqsX6lhH63Yq/K7TEAeyMkhPirny48Oxb8lnnz3+BCv9JIe2XOJat0R
 WoRIEuiKxRdIUV/7/DbetEJXPuSCqMqrcSJCP6nRzstE4=
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



Am 5=2E Juni 2024 03:37:40 MESZ schrieb Tom Rini <trini@konsulko=2Ecom>:
>The BLK symbol is used both for "we have a block device subsystem
>enabled" and "we need to utilize the block device library functions"=2E I=
n
>the case of efi_loader, it is the case of "we need to utilize the block
>device library", so select rather than depends on it=2E In turn, also
>disable EFI_LOADER on platforms which did not have it on previously due
>to a lack of block devices=2E They can enable it themselves if desired=2E
>
>Signed-off-by: Tom Rini <trini@konsulko=2Ecom>
>---
>Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

Acked-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>


>---
> configs/cortina_presidio-asic-base_defconfig     | 1 +
> configs/cortina_presidio-asic-pnand_defconfig    | 1 +
> configs/crs305-1g-4s-bit_defconfig               | 1 +
> configs/crs305-1g-4s_defconfig                   | 1 +
> configs/crs326-24g-2s-bit_defconfig              | 1 +
> configs/crs326-24g-2s_defconfig                  | 1 +
> configs/crs328-4c-20s-4s-bit_defconfig           | 1 +
> configs/crs328-4c-20s-4s_defconfig               | 1 +
> configs/gxp_defconfig                            | 1 +
> configs/maxbcm_defconfig                         | 1 +
> configs/mt7981_rfb_defconfig                     | 1 +
> configs/mt7986_rfb_defconfig                     | 1 +
> configs/mx6memcal_defconfig                      | 1 +
> configs/pg_wcom_expu1_defconfig                  | 1 +
> configs/pg_wcom_expu1_update_defconfig           | 1 +
> configs/pg_wcom_seli8_defconfig                  | 1 +
> configs/pg_wcom_seli8_update_defconfig           | 1 +
> configs/r8a77970_eagle_defconfig                 | 1 +
> configs/smdkc100_defconfig                       | 1 +
> configs/socfpga_is1_defconfig                    | 1 +
> configs/stm32mp25_defconfig                      | 1 +
> configs/thunderx_88xx_defconfig                  | 1 +
> configs/xilinx_versal_mini_defconfig             | 1 +
> configs/xilinx_versal_mini_ospi_defconfig        | 1 +
> configs/xilinx_versal_mini_qspi_defconfig        | 1 +
> configs/xilinx_versal_net_mini_defconfig         | 1 +
> configs/xilinx_versal_net_mini_ospi_defconfig    | 1 +
> configs/xilinx_versal_net_mini_qspi_defconfig    | 1 +
> configs/xilinx_zynqmp_mini_defconfig             | 1 +
> configs/xilinx_zynqmp_mini_nand_defconfig        | 1 +
> configs/xilinx_zynqmp_mini_nand_single_defconfig | 1 +
> configs/xilinx_zynqmp_mini_qspi_defconfig        | 1 +
> configs/zynq_cse_nand_defconfig                  | 1 +
> configs/zynq_cse_nor_defconfig                   | 1 +
> configs/zynq_cse_qspi_defconfig                  | 1 +
> lib/efi_loader/Kconfig                           | 2 +-
> 36 files changed, 36 insertions(+), 1 deletion(-)
>
>diff --git a/configs/cortina_presidio-asic-base_defconfig b/configs/corti=
na_presidio-asic-base_defconfig
>index 8f20f6515606=2E=2Eeb5743da64db 100644
>--- a/configs/cortina_presidio-asic-base_defconfig
>+++ b/configs/cortina_presidio-asic-base_defconfig
>@@ -38,3 +38,4 @@ CONFIG_DM_SERIAL=3Dy
> CONFIG_CORTINA_UART=3Dy
> CONFIG_WDT=3Dy
> CONFIG_WDT_CORTINA=3Dy
>+# CONFIG_EFI_LOADER is not set
>diff --git a/configs/cortina_presidio-asic-pnand_defconfig b/configs/cort=
ina_presidio-asic-pnand_defconfig
>index 94dc3e1e2e8e=2E=2Ec7367d4d91cc 100644
>--- a/configs/cortina_presidio-asic-pnand_defconfig
>+++ b/configs/cortina_presidio-asic-pnand_defconfig
>@@ -43,3 +43,4 @@ CONFIG_DM_SERIAL=3Dy
> CONFIG_CORTINA_UART=3Dy
> CONFIG_WDT=3Dy
> CONFIG_WDT_CORTINA=3Dy
>+# CONFIG_EFI_LOADER is not set
>diff --git a/configs/crs305-1g-4s-bit_defconfig b/configs/crs305-1g-4s-bi=
t_defconfig
>index a8f17570ecaa=2E=2Ec3d4594b75f7 100644
>--- a/configs/crs305-1g-4s-bit_defconfig
>+++ b/configs/crs305-1g-4s-bit_defconfig
>@@ -47,3 +47,4 @@ CONFIG_SPI_FLASH_MTD=3Dy
> CONFIG_PCI_MVEBU=3Dy
> CONFIG_SYS_NS16550=3Dy
> CONFIG_KIRKWOOD_SPI=3Dy
>+# CONFIG_EFI_LOADER is not set
>diff --git a/configs/crs305-1g-4s_defconfig b/configs/crs305-1g-4s_defcon=
fig
>index c66d291eb926=2E=2E1919e8c7794d 100644
>--- a/configs/crs305-1g-4s_defconfig
>+++ b/configs/crs305-1g-4s_defconfig
>@@ -48,3 +48,4 @@ CONFIG_SPI_FLASH_MTD=3Dy
> CONFIG_PCI_MVEBU=3Dy
> CONFIG_SYS_NS16550=3Dy
> CONFIG_KIRKWOOD_SPI=3Dy
>+# CONFIG_EFI_LOADER is not set
>diff --git a/configs/crs326-24g-2s-bit_defconfig b/configs/crs326-24g-2s-=
bit_defconfig
>index b754dac45ec3=2E=2Ea584c26eb90f 100644
>--- a/configs/crs326-24g-2s-bit_defconfig
>+++ b/configs/crs326-24g-2s-bit_defconfig
>@@ -47,3 +47,4 @@ CONFIG_SPI_FLASH_MTD=3Dy
> CONFIG_PCI_MVEBU=3Dy
> CONFIG_SYS_NS16550=3Dy
> CONFIG_KIRKWOOD_SPI=3Dy
>+# CONFIG_EFI_LOADER is not set
>diff --git a/configs/crs326-24g-2s_defconfig b/configs/crs326-24g-2s_defc=
onfig
>index 870127d38720=2E=2E43f7455afbf6 100644
>--- a/configs/crs326-24g-2s_defconfig
>+++ b/configs/crs326-24g-2s_defconfig
>@@ -47,3 +47,4 @@ CONFIG_SPI_FLASH_MTD=3Dy
> CONFIG_PCI_MVEBU=3Dy
> CONFIG_SYS_NS16550=3Dy
> CONFIG_KIRKWOOD_SPI=3Dy
>+# CONFIG_EFI_LOADER is not set
>diff --git a/configs/crs328-4c-20s-4s-bit_defconfig b/configs/crs328-4c-2=
0s-4s-bit_defconfig
>index 2373775dc5a9=2E=2E7bf671643a90 100644
>--- a/configs/crs328-4c-20s-4s-bit_defconfig
>+++ b/configs/crs328-4c-20s-4s-bit_defconfig
>@@ -47,3 +47,4 @@ CONFIG_SPI_FLASH_MTD=3Dy
> CONFIG_PCI_MVEBU=3Dy
> CONFIG_SYS_NS16550=3Dy
> CONFIG_KIRKWOOD_SPI=3Dy
>+# CONFIG_EFI_LOADER is not set
>diff --git a/configs/crs328-4c-20s-4s_defconfig b/configs/crs328-4c-20s-4=
s_defconfig
>index 9bac12217a03=2E=2E2f50bdaf1e7d 100644
>--- a/configs/crs328-4c-20s-4s_defconfig
>+++ b/configs/crs328-4c-20s-4s_defconfig
>@@ -47,3 +47,4 @@ CONFIG_SPI_FLASH_MTD=3Dy
> CONFIG_PCI_MVEBU=3Dy
> CONFIG_SYS_NS16550=3Dy
> CONFIG_KIRKWOOD_SPI=3Dy
>+# CONFIG_EFI_LOADER is not set
>diff --git a/configs/gxp_defconfig b/configs/gxp_defconfig
>index 00a9211fb052=2E=2Ed37749bd5e31 100644
>--- a/configs/gxp_defconfig
>+++ b/configs/gxp_defconfig
>@@ -59,3 +59,4 @@ CONFIG_TIMER=3Dy
> CONFIG_GXP_TIMER=3Dy
> # CONFIG_RANDOM_UUID is not set
> CONFIG_SHA512=3Dy
>+# CONFIG_EFI_LOADER is not set
>diff --git a/configs/maxbcm_defconfig b/configs/maxbcm_defconfig
>index 9906099e8c56=2E=2E5424259ca445 100644
>--- a/configs/maxbcm_defconfig
>+++ b/configs/maxbcm_defconfig
>@@ -62,3 +62,4 @@ CONFIG_SPL_DEBUG_UART_BASE=3D0xd0012000
> CONFIG_DEBUG_UART_SHIFT=3D2
> CONFIG_SYS_NS16550=3Dy
> CONFIG_KIRKWOOD_SPI=3Dy
>+# CONFIG_EFI_LOADER is not set
>diff --git a/configs/mt7981_rfb_defconfig b/configs/mt7981_rfb_defconfig
>index 817e4b3e119d=2E=2E3989c79d2b11 100644
>--- a/configs/mt7981_rfb_defconfig
>+++ b/configs/mt7981_rfb_defconfig
>@@ -64,4 +64,5 @@ CONFIG_SPI=3Dy
> CONFIG_DM_SPI=3Dy
> CONFIG_MTK_SPIM=3Dy
> CONFIG_HEXDUMP=3Dy
>+# CONFIG_EFI_LOADER is not set
> CONFIG_LMB_MAX_REGIONS=3D64
>diff --git a/configs/mt7986_rfb_defconfig b/configs/mt7986_rfb_defconfig
>index 35227ebd3406=2E=2E4d0cc85d0e57 100644
>--- a/configs/mt7986_rfb_defconfig
>+++ b/configs/mt7986_rfb_defconfig
>@@ -64,4 +64,5 @@ CONFIG_SPI=3Dy
> CONFIG_DM_SPI=3Dy
> CONFIG_MTK_SPIM=3Dy
> CONFIG_HEXDUMP=3Dy
>+# CONFIG_EFI_LOADER is not set
> CONFIG_LMB_MAX_REGIONS=3D64
>diff --git a/configs/mx6memcal_defconfig b/configs/mx6memcal_defconfig
>index 7f11e6f5d451=2E=2E4c8a5960d38a 100644
>--- a/configs/mx6memcal_defconfig
>+++ b/configs/mx6memcal_defconfig
>@@ -44,3 +44,4 @@ CONFIG_BOUNCE_BUFFER=3Dy
> CONFIG_FSL_USDHC=3Dy
> CONFIG_MXC_UART=3Dy
> CONFIG_OF_LIBFDT=3Dy
>+# CONFIG_EFI_LOADER is not set
>diff --git a/configs/pg_wcom_expu1_defconfig b/configs/pg_wcom_expu1_defc=
onfig
>index 2be9e242b589=2E=2E61513c9e2ec9 100644
>--- a/configs/pg_wcom_expu1_defconfig
>+++ b/configs/pg_wcom_expu1_defconfig
>@@ -104,5 +104,6 @@ CONFIG_SPECIFY_CONSOLE_INDEX=3Dy
> CONFIG_DM_SERIAL=3Dy
> CONFIG_SYS_NS16550=3Dy
> CONFIG_LZO=3Dy
>+# CONFIG_EFI_LOADER is not set
> CONFIG_POST=3Dy
> CONFIG_HUSH_OLD_PARSER=3Dy
>diff --git a/configs/pg_wcom_expu1_update_defconfig b/configs/pg_wcom_exp=
u1_update_defconfig
>index 9245a56adea0=2E=2Eec0f975ae365 100644
>--- a/configs/pg_wcom_expu1_update_defconfig
>+++ b/configs/pg_wcom_expu1_update_defconfig
>@@ -102,5 +102,6 @@ CONFIG_SPECIFY_CONSOLE_INDEX=3Dy
> CONFIG_DM_SERIAL=3Dy
> CONFIG_SYS_NS16550=3Dy
> CONFIG_LZO=3Dy
>+# CONFIG_EFI_LOADER is not set
> CONFIG_POST=3Dy
> CONFIG_HUSH_OLD_PARSER=3Dy
>diff --git a/configs/pg_wcom_seli8_defconfig b/configs/pg_wcom_seli8_defc=
onfig
>index 033dd82b28ec=2E=2E82923d32ca69 100644
>--- a/configs/pg_wcom_seli8_defconfig
>+++ b/configs/pg_wcom_seli8_defconfig
>@@ -104,5 +104,6 @@ CONFIG_SPECIFY_CONSOLE_INDEX=3Dy
> CONFIG_DM_SERIAL=3Dy
> CONFIG_SYS_NS16550=3Dy
> CONFIG_LZO=3Dy
>+# CONFIG_EFI_LOADER is not set
> CONFIG_POST=3Dy
> CONFIG_HUSH_OLD_PARSER=3Dy
>diff --git a/configs/pg_wcom_seli8_update_defconfig b/configs/pg_wcom_sel=
i8_update_defconfig
>index 4d34ef6d680e=2E=2E41931e247688 100644
>--- a/configs/pg_wcom_seli8_update_defconfig
>+++ b/configs/pg_wcom_seli8_update_defconfig
>@@ -102,5 +102,6 @@ CONFIG_SPECIFY_CONSOLE_INDEX=3Dy
> CONFIG_DM_SERIAL=3Dy
> CONFIG_SYS_NS16550=3Dy
> CONFIG_LZO=3Dy
>+# CONFIG_EFI_LOADER is not set
> CONFIG_POST=3Dy
> CONFIG_HUSH_OLD_PARSER=3Dy
>diff --git a/configs/r8a77970_eagle_defconfig b/configs/r8a77970_eagle_de=
fconfig
>index 09ea1c54f137=2E=2E1dbbb2e26095 100644
>--- a/configs/r8a77970_eagle_defconfig
>+++ b/configs/r8a77970_eagle_defconfig
>@@ -80,3 +80,4 @@ CONFIG_DM_SPI=3Dy
> CONFIG_RENESAS_RPC_SPI=3Dy
> CONFIG_TEE=3Dy
> CONFIG_OPTEE=3Dy
>+# CONFIG_EFI_LOADER is not set
>diff --git a/configs/smdkc100_defconfig b/configs/smdkc100_defconfig
>index 54a037904594=2E=2E256190ddabfc 100644
>--- a/configs/smdkc100_defconfig
>+++ b/configs/smdkc100_defconfig
>@@ -39,3 +39,4 @@ CONFIG_ENV_IS_IN_ONENAND=3Dy
> CONFIG_MTD=3Dy
> CONFIG_SAMSUNG_ONENAND=3Dy
> CONFIG_SMC911X=3Dy
>+# CONFIG_EFI_LOADER is not set
>diff --git a/configs/socfpga_is1_defconfig b/configs/socfpga_is1_defconfi=
g
>index f0a364a562b8=2E=2E0fff9080d417 100644
>--- a/configs/socfpga_is1_defconfig
>+++ b/configs/socfpga_is1_defconfig
>@@ -68,3 +68,4 @@ CONFIG_SPI=3Dy
> CONFIG_CADENCE_QSPI=3Dy
> # CONFIG_SPL_WDT is not set
> CONFIG_SYS_TIMER_COUNTS_DOWN=3Dy
>+# CONFIG_EFI_LOADER is not set
>diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
>index 9fbd7eb15755=2E=2E87038cc773ab 100644
>--- a/configs/stm32mp25_defconfig
>+++ b/configs/stm32mp25_defconfig
>@@ -48,6 +48,7 @@ CONFIG_WDT=3Dy
> CONFIG_WDT_STM32MP=3Dy
> CONFIG_WDT_ARM_SMC=3Dy
> CONFIG_ERRNO_STR=3Dy
>+# CONFIG_EFI_LOADER is not set
> # CONFIG_LMB_USE_MAX_REGIONS is not set
> CONFIG_LMB_MEMORY_REGIONS=3D2
> CONFIG_LMB_RESERVED_REGIONS=3D32
>diff --git a/configs/thunderx_88xx_defconfig b/configs/thunderx_88xx_defc=
onfig
>index 247e32d8e378=2E=2Eb754cc01cc81 100644
>--- a/configs/thunderx_88xx_defconfig
>+++ b/configs/thunderx_88xx_defconfig
>@@ -36,3 +36,4 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> # CONFIG_MMC is not set
> CONFIG_DM_SERIAL=3Dy
> CONFIG_DEBUG_UART_SKIP_INIT=3Dy
>+# CONFIG_EFI_LOADER is not set
>diff --git a/configs/xilinx_versal_mini_defconfig b/configs/xilinx_versal=
_mini_defconfig
>index 9d3924cc9cbc=2E=2Eb97bf5e60a94 100644
>--- a/configs/xilinx_versal_mini_defconfig
>+++ b/configs/xilinx_versal_mini_defconfig
>@@ -62,4 +62,5 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> # CONFIG_MMC is not set
> CONFIG_ARM_DCC=3Dy
> # CONFIG_GZIP is not set
>+# CONFIG_EFI_LOADER is not set
> # CONFIG_LMB is not set
>diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_v=
ersal_mini_ospi_defconfig
>index 7a110350c2cd=2E=2E8f1625976032 100644
>--- a/configs/xilinx_versal_mini_ospi_defconfig
>+++ b/configs/xilinx_versal_mini_ospi_defconfig
>@@ -72,4 +72,5 @@ CONFIG_CADENCE_QSPI=3Dy
> CONFIG_HAS_CQSPI_REF_CLK=3Dy
> CONFIG_CQSPI_REF_CLK=3D200000000
> CONFIG_CADENCE_OSPI_VERSAL=3Dy
>+# CONFIG_EFI_LOADER is not set
> # CONFIG_LMB is not set
>diff --git a/configs/xilinx_versal_mini_qspi_defconfig b/configs/xilinx_v=
ersal_mini_qspi_defconfig
>index 58945a1cac9c=2E=2E8fbde1c7d3ca 100644
>--- a/configs/xilinx_versal_mini_qspi_defconfig
>+++ b/configs/xilinx_versal_mini_qspi_defconfig
>@@ -76,4 +76,5 @@ CONFIG_ARM_DCC=3Dy
> CONFIG_SPI=3Dy
> CONFIG_DM_SPI=3Dy
> CONFIG_ZYNQMP_GQSPI=3Dy
>+# CONFIG_EFI_LOADER is not set
> # CONFIG_LMB is not set
>diff --git a/configs/xilinx_versal_net_mini_defconfig b/configs/xilinx_ve=
rsal_net_mini_defconfig
>index 7dac1ec54eb4=2E=2Ed6ebd0804637 100644
>--- a/configs/xilinx_versal_net_mini_defconfig
>+++ b/configs/xilinx_versal_net_mini_defconfig
>@@ -71,4 +71,5 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> CONFIG_ARM_DCC=3Dy
> CONFIG_PL01X_SERIAL=3Dy
> # CONFIG_GZIP is not set
>+# CONFIG_EFI_LOADER is not set
> # CONFIG_LMB is not set
>diff --git a/configs/xilinx_versal_net_mini_ospi_defconfig b/configs/xili=
nx_versal_net_mini_ospi_defconfig
>index d78c9f805990=2E=2E872a4a55952f 100644
>--- a/configs/xilinx_versal_net_mini_ospi_defconfig
>+++ b/configs/xilinx_versal_net_mini_ospi_defconfig
>@@ -70,4 +70,5 @@ CONFIG_CADENCE_QSPI=3Dy
> CONFIG_HAS_CQSPI_REF_CLK=3Dy
> CONFIG_CQSPI_REF_CLK=3D200000000
> CONFIG_CADENCE_OSPI_VERSAL=3Dy
>+# CONFIG_EFI_LOADER is not set
> # CONFIG_LMB is not set
>diff --git a/configs/xilinx_versal_net_mini_qspi_defconfig b/configs/xili=
nx_versal_net_mini_qspi_defconfig
>index b0567f857a3a=2E=2E00319e061020 100644
>--- a/configs/xilinx_versal_net_mini_qspi_defconfig
>+++ b/configs/xilinx_versal_net_mini_qspi_defconfig
>@@ -74,4 +74,5 @@ CONFIG_ARM_DCC=3Dy
> CONFIG_SPI=3Dy
> CONFIG_DM_SPI=3Dy
> CONFIG_ZYNQMP_GQSPI=3Dy
>+# CONFIG_EFI_LOADER is not set
> # CONFIG_LMB is not set
>diff --git a/configs/xilinx_zynqmp_mini_defconfig b/configs/xilinx_zynqmp=
_mini_defconfig
>index 7fdd2eee5552=2E=2E4b45074efc48 100644
>--- a/configs/xilinx_zynqmp_mini_defconfig
>+++ b/configs/xilinx_zynqmp_mini_defconfig
>@@ -60,4 +60,5 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> CONFIG_ARM_DCC=3Dy
> CONFIG_PANIC_HANG=3Dy
> # CONFIG_GZIP is not set
>+# CONFIG_EFI_LOADER is not set
> # CONFIG_LMB is not set
>diff --git a/configs/xilinx_zynqmp_mini_nand_defconfig b/configs/xilinx_z=
ynqmp_mini_nand_defconfig
>index d2e920fc5732=2E=2Eb4719536be16 100644
>--- a/configs/xilinx_zynqmp_mini_nand_defconfig
>+++ b/configs/xilinx_zynqmp_mini_nand_defconfig
>@@ -60,4 +60,5 @@ CONFIG_SYS_NAND_MAX_CHIPS=3D2
> CONFIG_ARM_DCC=3Dy
> CONFIG_PANIC_HANG=3Dy
> # CONFIG_GZIP is not set
>+# CONFIG_EFI_LOADER is not set
> # CONFIG_LMB is not set
>diff --git a/configs/xilinx_zynqmp_mini_nand_single_defconfig b/configs/x=
ilinx_zynqmp_mini_nand_single_defconfig
>index 31f647357f75=2E=2E7ede17654dd0 100644
>--- a/configs/xilinx_zynqmp_mini_nand_single_defconfig
>+++ b/configs/xilinx_zynqmp_mini_nand_single_defconfig
>@@ -59,4 +59,5 @@ CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> CONFIG_ARM_DCC=3Dy
> CONFIG_PANIC_HANG=3Dy
> # CONFIG_GZIP is not set
>+# CONFIG_EFI_LOADER is not set
> # CONFIG_LMB is not set
>diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_z=
ynqmp_mini_qspi_defconfig
>index 957ae07b80ef=2E=2E0d79ecece71a 100644
>--- a/configs/xilinx_zynqmp_mini_qspi_defconfig
>+++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
>@@ -92,4 +92,5 @@ CONFIG_SPI=3Dy
> CONFIG_ZYNQMP_GQSPI=3Dy
> CONFIG_PANIC_HANG=3Dy
> # CONFIG_GZIP is not set
>+# CONFIG_EFI_LOADER is not set
> # CONFIG_LMB is not set
>diff --git a/configs/zynq_cse_nand_defconfig b/configs/zynq_cse_nand_defc=
onfig
>index 48473d784439=2E=2E750ea0db2b22 100644
>--- a/configs/zynq_cse_nand_defconfig
>+++ b/configs/zynq_cse_nand_defconfig
>@@ -79,4 +79,5 @@ CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> CONFIG_ARM_DCC=3Dy
> CONFIG_SYS_TIMER_COUNTS_DOWN=3Dy
> # CONFIG_GZIP is not set
>+# CONFIG_EFI_LOADER is not set
> # CONFIG_LMB is not set
>diff --git a/configs/zynq_cse_nor_defconfig b/configs/zynq_cse_nor_defcon=
fig
>index 9f2b738d9d13=2E=2E3155fe0b3783 100644
>--- a/configs/zynq_cse_nor_defconfig
>+++ b/configs/zynq_cse_nor_defconfig
>@@ -83,4 +83,5 @@ CONFIG_SYS_FLASH_QUIET_TEST=3Dy
> CONFIG_ARM_DCC=3Dy
> CONFIG_SYS_TIMER_COUNTS_DOWN=3Dy
> # CONFIG_GZIP is not set
>+# CONFIG_EFI_LOADER is not set
> # CONFIG_LMB is not set
>diff --git a/configs/zynq_cse_qspi_defconfig b/configs/zynq_cse_qspi_defc=
onfig
>index 5b861bdde180=2E=2Ef2e1aa6d3abf 100644
>--- a/configs/zynq_cse_qspi_defconfig
>+++ b/configs/zynq_cse_qspi_defconfig
>@@ -93,4 +93,5 @@ CONFIG_ARM_DCC=3Dy
> CONFIG_ZYNQ_QSPI=3Dy
> CONFIG_SYS_TIMER_COUNTS_DOWN=3Dy
> # CONFIG_GZIP is not set
>+# CONFIG_EFI_LOADER is not set
> # CONFIG_LMB is not set
>diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>index 430bb7f0f7dc=2E=2Eee71f417147a 100644
>--- a/lib/efi_loader/Kconfig
>+++ b/lib/efi_loader/Kconfig
>@@ -10,9 +10,9 @@ config EFI_LOADER
> 	depends on !EFI_STUB || !X86_64 || EFI_STUB_64BIT
> 	# We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
> 	depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
>-	depends on BLK
> 	depends on !EFI_APP
> 	default y if !ARM || SYS_CPU =3D armv7 || SYS_CPU =3D armv8
>+	select BLK
> 	select CHARSET
> 	# We need to send DM events, dynamically, in the EFI block driver
> 	select DM_EVENT
