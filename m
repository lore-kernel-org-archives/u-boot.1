Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A89CD68BE4
	for <u-boot@archiver.kernel.org>; Sat, 16 Nov 2024 07:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B084E89667;
	Sat, 16 Nov 2024 08:15:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KkOQsqDv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F38689667; Sat, 16 Nov 2024 08:15:51 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99DF2891B1
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 08:15:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731741334; x=1732346134; i=xypron.glpk@gmx.de;
 bh=Hx62fqkq+Dp7EVF812OUMdIt4aNRYDV6PejGsz13QS8=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=KkOQsqDvyHVCeTPC9e+o0h2YC36hanzupu/5IrkbG6iuVKY76k0oggwAt0bf0Axs
 JPGCMMhiWc/gOA5ohymDwKlbQgEPfEHMZy6qHERP1zgGSGkV7kDR/MYXSQYt7iIXs
 xd3ViVqaSpvbINUVgV2C+P68Jycx9UKwBk9u6GZOtiTRJ/fOefHMfLjI51T73KG0a
 fLfyLp0l7nfWjjH2p43wLa9kGDa1mCurnrOhJQsnSJwNyYTum9+rPcWR/kj30+QNv
 dMkORlUmmm1bD/+hpPbPHHyx9rpvQYkt1nMiR92A+iaYFMPKV0JZYC6hY77nLIZf3
 tajwITUGNWa/f4bKqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof57-1tWTtP0V57-00pqBI; Sat, 16
 Nov 2024 08:15:34 +0100
Date: Sat, 16 Nov 2024 08:15:33 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Padmarao Begari <padmarao.begari@amd.com>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH] xilinx: Introduce MINI configuration
User-Agent: Thunderbird for Android
In-Reply-To: <81d086ccf96f9d601eb4b56a2a88d8bb2dacd48e.1731677784.git.michal.simek@amd.com>
References: <81d086ccf96f9d601eb4b56a2a88d8bb2dacd48e.1731677784.git.michal.simek@amd.com>
Message-ID: <D0E9CD29-C949-4D1E-A532-B4527460C079@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jtZcGNR4ir6Ps+b2CBfHQe0xJ7OeG/d/XKa002bGfYiSICaVOXM
 rMER5n6Y9A157eQILjBGQgCqjfq44TwNvuBgKI4hpUb5j6b7s6KHJznz049gs3cahnzOtMR
 vAus5pvSZE+5neCXL4zW0dsiCheKqHC2OXzpljwWc33K++JX89M6LUyndc0qXRjjdslfes9
 /DgV3+UYrqjfAb3s/Kl6Q==
UI-OutboundReport: notjunk:1;M01:P0:lAZ5E5iACp4=;rZRgBPzcRlayuLOSIGdsG0FuQYh
 rgZlPq7jDKMRDYvyIt9dlrBcc6gQ2wBxTihfLb0bkv1DHa0BBZTCqaAlze+wpVBiVLueWr5hL
 mjZWEa4ewclFEQdku0CU7+75FoIAddcR60FXTaMjSzCxxoY65B6SCGGi7JrKgb8731dnS0g4W
 1CwUGeoE3FCGqn4kJVo+qbKQLpEDRQrmg+NxJdYq0ebMSHpBjRPnYrJhPn3R1iOTYvL3JVVNj
 wWAEcm87EoDm08yzI094DejdVe07ot2g8wIlP+Vvdpo6+jDMghlegdKlZ3gDO+N01YawzMBZg
 mpodUEQznvFE8Vh1dTLVwJdFrREGFxDvREyCrxpKB6ShFVOYOqFoVCx1L7GvRWgv2UfneMLYB
 WJuirNxNWkAvaYWpV5TiSiB5nlqE+PbGsoikWiL1cTJ8DExKPj/0ltPO4fTFMB7Xw3+wOlA+0
 XiNjRoR17e18wgXeszbPwWDnjjZoODqttURegn/+X4JGssOU55UNbst9UNzyJ+FeOCBkvOdya
 oldPPIIHfH1MoPvafFBu7iXtNjjtwBLd9ih34L/0maDVnihS7J9VLGSMBX3gnw8Jw3ke/17V1
 WaeM29hNdqnk8tmow3YQ2IrGtqqgLJ2soI4CUK5HZgwFZTdiAfvJwoElCsu5okiPezUDQGx3Q
 7Aglc+k0bj+B8Kj9+hT3L+UmLoc3DPiWtYTYoQi9xqqzQ5u0o/i2VBOp8im2foOYLQHp/OfE1
 1z7YX3v3l3ZPAXg0onF3IBa4q3pVlGsscSZqMNAf3KC3ZzIK5HslfQ4zT+d1W1/VV5u3aPdIl
 KeAIZ3rPPrVwpsSrWoRZpafdCur1Qtq63IZCRLI3N3WiTyPWpwznFhMWljkh8BhXZF9JgaoW1
 xSppHPCh2aVH5ztL/AntFQSovE/CkB+/j6ASPDzM4Nmbk9Gs51HDBo1AC
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

Am 15=2E November 2024 14:36:32 MEZ schrieb Michal Simek <michal=2Esimek@am=
d=2Ecom>:
>There is no common symbol which mini configurations are using and recent
>get_mem_top() changes adding 1=2E3kB without having a way to remove it=2E
>That's why introduce new symbol which can be used for removing features
>which are not requested by these configurations=2E
>
>Signed-off-by: Michal Simek <michal=2Esimek@amd=2Ecom>
>---
>
>Based on:
>https://lore=2Ekernel=2Eorg/r/20241025172724=2E195093-3-sughosh=2Eganu@li=
naro=2Eorg
>---
> board/xilinx/Kconfig                             | 9 +++++++++
> board/xilinx/common/board=2Ec                      | 4 ++++
> configs/amd_versal2_mini_defconfig               | 1 +
> configs/amd_versal2_mini_emmc_defconfig          | 1 +
> configs/amd_versal2_mini_ospi_defconfig          | 1 +
> configs/amd_versal2_mini_qspi_defconfig          | 1 +
> configs/xilinx_versal_mini_defconfig             | 1 +
> configs/xilinx_versal_mini_emmc0_defconfig       | 1 +
> configs/xilinx_versal_mini_emmc1_defconfig       | 1 +
> configs/xilinx_versal_mini_ospi_defconfig        | 1 +
> configs/xilinx_versal_mini_qspi_defconfig        | 1 +
> configs/xilinx_versal_net_mini_defconfig         | 1 +
> configs/xilinx_versal_net_mini_emmc_defconfig    | 1 +
> configs/xilinx_versal_net_mini_ospi_defconfig    | 1 +
> configs/xilinx_versal_net_mini_qspi_defconfig    | 1 +
> configs/xilinx_zynqmp_mini_defconfig             | 1 +
> configs/xilinx_zynqmp_mini_emmc0_defconfig       | 1 +
> configs/xilinx_zynqmp_mini_emmc1_defconfig       | 1 +
> configs/xilinx_zynqmp_mini_nand_defconfig        | 1 +
> configs/xilinx_zynqmp_mini_nand_single_defconfig | 1 +
> configs/xilinx_zynqmp_mini_qspi_defconfig        | 1 +
> 21 files changed, 32 insertions(+)
>
>diff --git a/board/xilinx/Kconfig b/board/xilinx/Kconfig
>index 0ff8440e6e06=2E=2Ea7da97dbae8c 100644
>--- a/board/xilinx/Kconfig
>+++ b/board/xilinx/Kconfig
>@@ -40,6 +40,15 @@ config XILINX_PS_INIT_FILE
>=20
> endif
>=20
>+config MINI

Should this be called XILINX_MINI, as it is Xilinx specific?

Best regards

Heinrich


>+	bool "Mini configuration"
>+	depends on ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL=
2
>+	help
>+	  This option disables features which are not needed for Mini U-Boot
>+	  configurations=2E Mini U-Boot is running in EL3 mostly on size contra=
ined
>+	  systems=2E It's purpose is to program non volatile memories or runnin=
g
>+	  initial memory tests=2E
>+
> config XILINX_OF_BOARD_DTB_ADDR
> 	hex "Default DTB pickup address"
> 	default 0x1000 if ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2
>diff --git a/board/xilinx/common/board=2Ec b/board/xilinx/common/board=2E=
c
>index e14ed2cff00a=2E=2E9b90ce5998b9 100644
>--- a/board/xilinx/common/board=2Ec
>+++ b/board/xilinx/common/board=2Ec
>@@ -678,6 +678,8 @@ int ft_board_setup(void *blob, struct bd_info *bd)
> }
> #endif
>=20
>+#ifndef CONFIG_MINI
>+
> #ifndef MMU_SECTION_SIZE
> #define MMU_SECTION_SIZE        (1 * 1024 * 1024)
> #endif
>@@ -701,3 +703,5 @@ phys_addr_t board_get_usable_ram_top(phys_size_t tota=
l_size)
>=20
> 	return reg + size;
> }
>+
>+#endif
>diff --git a/configs/amd_versal2_mini_defconfig b/configs/amd_versal2_min=
i_defconfig
>index ea22541bfbaf=2E=2E3bcdc53771b2 100644
>--- a/configs/amd_versal2_mini_defconfig
>+++ b/configs/amd_versal2_mini_defconfig
>@@ -15,6 +15,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"amd-versal2-mini"
> CONFIG_SYS_LOAD_ADDR=3D0xBBF80000
> CONFIG_DEBUG_UART_BASE=3D0xf1920000
> CONFIG_DEBUG_UART_CLOCK=3D100000000
>+CONFIG_MINI=3Dy
> CONFIG_SYS_MEM_RSVD_FOR_MMU=3Dy
> # CONFIG_PSCI_RESET is not set
> CONFIG_DEBUG_UART=3Dy
>diff --git a/configs/amd_versal2_mini_emmc_defconfig b/configs/amd_versal=
2_mini_emmc_defconfig
>index 6d4b261606f1=2E=2E17b26080ebf5 100644
>--- a/configs/amd_versal2_mini_emmc_defconfig
>+++ b/configs/amd_versal2_mini_emmc_defconfig
>@@ -12,6 +12,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"amd-versal2-mini"
> CONFIG_SYS_LOAD_ADDR=3D0x8000000
> CONFIG_DEBUG_UART_BASE=3D0xf1920000
> CONFIG_DEBUG_UART_CLOCK=3D100000000
>+CONFIG_MINI=3Dy
> # CONFIG_PSCI_RESET is not set
> CONFIG_DEBUG_UART=3Dy
> # CONFIG_EXPERT is not set
>diff --git a/configs/amd_versal2_mini_ospi_defconfig b/configs/amd_versal=
2_mini_ospi_defconfig
>index 71bd66778380=2E=2Ea3aab8519407 100644
>--- a/configs/amd_versal2_mini_ospi_defconfig
>+++ b/configs/amd_versal2_mini_ospi_defconfig
>@@ -15,6 +15,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"amd-versal2-mini"
> CONFIG_SYS_LOAD_ADDR=3D0xBBF80000
> CONFIG_DEBUG_UART_BASE=3D0xf1920000
> CONFIG_DEBUG_UART_CLOCK=3D100000000
>+CONFIG_MINI=3Dy
> CONFIG_SYS_MEM_RSVD_FOR_MMU=3Dy
> # CONFIG_PSCI_RESET is not set
> CONFIG_DEBUG_UART=3Dy
>diff --git a/configs/amd_versal2_mini_qspi_defconfig b/configs/amd_versal=
2_mini_qspi_defconfig
>index ee87d452e428=2E=2E972290d95a2a 100644
>--- a/configs/amd_versal2_mini_qspi_defconfig
>+++ b/configs/amd_versal2_mini_qspi_defconfig
>@@ -15,6 +15,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"amd-versal2-mini"
> CONFIG_SYS_LOAD_ADDR=3D0xBBF80000
> CONFIG_DEBUG_UART_BASE=3D0xf1920000
> CONFIG_DEBUG_UART_CLOCK=3D100000000
>+CONFIG_MINI=3Dy
> CONFIG_SYS_MEM_RSVD_FOR_MMU=3Dy
> # CONFIG_PSCI_RESET is not set
> CONFIG_DEBUG_UART=3Dy
>diff --git a/configs/xilinx_versal_mini_defconfig b/configs/xilinx_versal=
_mini_defconfig
>index 7388a7873861=2E=2E0c85eb8c3e4e 100644
>--- a/configs/xilinx_versal_mini_defconfig
>+++ b/configs/xilinx_versal_mini_defconfig
>@@ -12,6 +12,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0xfffe0000
> CONFIG_ENV_SIZE=3D0x80
> CONFIG_DEFAULT_DEVICE_TREE=3D"versal-mini"
> CONFIG_SYS_LOAD_ADDR=3D0x8000000
>+CONFIG_MINI=3Dy
> CONFIG_SYS_MEM_RSVD_FOR_MMU=3Dy
> # CONFIG_PSCI_RESET is not set
> CONFIG_SYS_MEMTEST_START=3D0x00000000
>diff --git a/configs/xilinx_versal_mini_emmc0_defconfig b/configs/xilinx_=
versal_mini_emmc0_defconfig
>index a36e40dfbb31=2E=2E20cccbcb4db1 100644
>--- a/configs/xilinx_versal_mini_emmc0_defconfig
>+++ b/configs/xilinx_versal_mini_emmc0_defconfig
>@@ -12,6 +12,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x10000
> CONFIG_ENV_SIZE=3D0x80
> CONFIG_DEFAULT_DEVICE_TREE=3D"versal-mini-emmc0"
> CONFIG_SYS_LOAD_ADDR=3D0x8000000
>+CONFIG_MINI=3Dy
> # CONFIG_PSCI_RESET is not set
> # CONFIG_EXPERT is not set
> CONFIG_REMAKE_ELF=3Dy
>diff --git a/configs/xilinx_versal_mini_emmc1_defconfig b/configs/xilinx_=
versal_mini_emmc1_defconfig
>index 3ae2115212aa=2E=2Eaf26aab92e30 100644
>--- a/configs/xilinx_versal_mini_emmc1_defconfig
>+++ b/configs/xilinx_versal_mini_emmc1_defconfig
>@@ -12,6 +12,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x10000
> CONFIG_ENV_SIZE=3D0x80
> CONFIG_DEFAULT_DEVICE_TREE=3D"versal-mini-emmc1"
> CONFIG_SYS_LOAD_ADDR=3D0x8000000
>+CONFIG_MINI=3Dy
> # CONFIG_PSCI_RESET is not set
> # CONFIG_EXPERT is not set
> CONFIG_REMAKE_ELF=3Dy
>diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_v=
ersal_mini_ospi_defconfig
>index d0ea2b6aebd9=2E=2Ea4c884e0e3d5 100644
>--- a/configs/xilinx_versal_mini_ospi_defconfig
>+++ b/configs/xilinx_versal_mini_ospi_defconfig
>@@ -13,6 +13,7 @@ CONFIG_ENV_SIZE=3D0x80
> # CONFIG_DM_GPIO is not set
> CONFIG_DEFAULT_DEVICE_TREE=3D"versal-mini-ospi-single"
> CONFIG_SYS_LOAD_ADDR=3D0x8000000
>+CONFIG_MINI=3Dy
> CONFIG_SYS_MEM_RSVD_FOR_MMU=3Dy
> CONFIG_VERSAL_NO_DDR=3Dy
> # CONFIG_PSCI_RESET is not set
>diff --git a/configs/xilinx_versal_mini_qspi_defconfig b/configs/xilinx_v=
ersal_mini_qspi_defconfig
>index ef6eec075d06=2E=2Ea5a992ded99a 100644
>--- a/configs/xilinx_versal_mini_qspi_defconfig
>+++ b/configs/xilinx_versal_mini_qspi_defconfig
>@@ -11,6 +11,7 @@ CONFIG_SF_DEFAULT_SPEED=3D30000000
> CONFIG_ENV_SIZE=3D0x80
> CONFIG_DEFAULT_DEVICE_TREE=3D"versal-mini-qspi-single"
> CONFIG_SYS_LOAD_ADDR=3D0x8000000
>+CONFIG_MINI=3Dy
> CONFIG_SYS_MEM_RSVD_FOR_MMU=3Dy
> CONFIG_VERSAL_NO_DDR=3Dy
> # CONFIG_PSCI_RESET is not set
>diff --git a/configs/xilinx_versal_net_mini_defconfig b/configs/xilinx_ve=
rsal_net_mini_defconfig
>index 1640dfaff9ed=2E=2E6251420aa1d5 100644
>--- a/configs/xilinx_versal_net_mini_defconfig
>+++ b/configs/xilinx_versal_net_mini_defconfig
>@@ -14,6 +14,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0xBBF10000
> CONFIG_ENV_SIZE=3D0x80
> CONFIG_DEFAULT_DEVICE_TREE=3D"versal-net-mini"
> CONFIG_SYS_LOAD_ADDR=3D0xBBF00000
>+CONFIG_MINI=3Dy
> CONFIG_SYS_MEM_RSVD_FOR_MMU=3Dy
> # CONFIG_PSCI_RESET is not set
> CONFIG_SYS_MEMTEST_START=3D0x00000000
>diff --git a/configs/xilinx_versal_net_mini_emmc_defconfig b/configs/xili=
nx_versal_net_mini_emmc_defconfig
>index 4c6159a4df17=2E=2E869ac9723293 100644
>--- a/configs/xilinx_versal_net_mini_emmc_defconfig
>+++ b/configs/xilinx_versal_net_mini_emmc_defconfig
>@@ -10,6 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x10000
> CONFIG_ENV_SIZE=3D0x80
> CONFIG_DEFAULT_DEVICE_TREE=3D"versal-net-mini-emmc"
> CONFIG_SYS_LOAD_ADDR=3D0x8000000
>+CONFIG_MINI=3Dy
> # CONFIG_PSCI_RESET is not set
> # CONFIG_EXPERT is not set
> CONFIG_REMAKE_ELF=3Dy
>diff --git a/configs/xilinx_versal_net_mini_ospi_defconfig b/configs/xili=
nx_versal_net_mini_ospi_defconfig
>index 071eeb8197b8=2E=2E9f1509f5e3d5 100644
>--- a/configs/xilinx_versal_net_mini_ospi_defconfig
>+++ b/configs/xilinx_versal_net_mini_ospi_defconfig
>@@ -13,6 +13,7 @@ CONFIG_ENV_SIZE=3D0x80
> # CONFIG_DM_GPIO is not set
> CONFIG_DEFAULT_DEVICE_TREE=3D"versal-net-mini-ospi-single"
> CONFIG_SYS_LOAD_ADDR=3D0xBBF80000
>+CONFIG_MINI=3Dy
> CONFIG_SYS_MEM_RSVD_FOR_MMU=3Dy
> # CONFIG_PSCI_RESET is not set
> CONFIG_LTO=3Dy
>diff --git a/configs/xilinx_versal_net_mini_qspi_defconfig b/configs/xili=
nx_versal_net_mini_qspi_defconfig
>index 227c45df28c3=2E=2Ec0e5423a22fd 100644
>--- a/configs/xilinx_versal_net_mini_qspi_defconfig
>+++ b/configs/xilinx_versal_net_mini_qspi_defconfig
>@@ -11,6 +11,7 @@ CONFIG_SF_DEFAULT_SPEED=3D30000000
> CONFIG_ENV_SIZE=3D0x80
> CONFIG_DEFAULT_DEVICE_TREE=3D"versal-net-mini-qspi-single"
> CONFIG_SYS_LOAD_ADDR=3D0xBBF80000
>+CONFIG_MINI=3Dy
> CONFIG_SYS_MEM_RSVD_FOR_MMU=3Dy
> # CONFIG_PSCI_RESET is not set
> CONFIG_LTO=3Dy
>diff --git a/configs/xilinx_zynqmp_mini_defconfig b/configs/xilinx_zynqmp=
_mini_defconfig
>index 7aab69c9e46b=2E=2E6942a145125c 100644
>--- a/configs/xilinx_zynqmp_mini_defconfig
>+++ b/configs/xilinx_zynqmp_mini_defconfig
>@@ -9,6 +9,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0xfffe0000
> CONFIG_ENV_SIZE=3D0x80
> CONFIG_DEFAULT_DEVICE_TREE=3D"zynqmp-mini"
> CONFIG_SYS_LOAD_ADDR=3D0x8000000
>+CONFIG_MINI=3Dy
> CONFIG_SYS_MEM_RSVD_FOR_MMU=3Dy
> CONFIG_SYS_MEMTEST_START=3D0x00000000
> CONFIG_SYS_MEMTEST_END=3D0x00001000
>diff --git a/configs/xilinx_zynqmp_mini_emmc0_defconfig b/configs/xilinx_=
zynqmp_mini_emmc0_defconfig
>index c56b1e830d67=2E=2Eeb44bde29088 100644
>--- a/configs/xilinx_zynqmp_mini_emmc0_defconfig
>+++ b/configs/xilinx_zynqmp_mini_emmc0_defconfig
>@@ -15,6 +15,7 @@ CONFIG_SPL_SYS_MALLOC_F_LEN=3D0x600
> CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> CONFIG_SYS_LOAD_ADDR=3D0x8000000
> CONFIG_SPL=3Dy
>+CONFIG_MINI=3Dy
> CONFIG_REMAKE_ELF=3Dy
> # CONFIG_MP is not set
> # CONFIG_EFI_LOADER is not set
>diff --git a/configs/xilinx_zynqmp_mini_emmc1_defconfig b/configs/xilinx_=
zynqmp_mini_emmc1_defconfig
>index a8dbf0056da3=2E=2E4ebc3a4e1361 100644
>--- a/configs/xilinx_zynqmp_mini_emmc1_defconfig
>+++ b/configs/xilinx_zynqmp_mini_emmc1_defconfig
>@@ -15,6 +15,7 @@ CONFIG_SPL_SYS_MALLOC_F_LEN=3D0x600
> CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> CONFIG_SYS_LOAD_ADDR=3D0x8000000
> CONFIG_SPL=3Dy
>+CONFIG_MINI=3Dy
> CONFIG_REMAKE_ELF=3Dy
> # CONFIG_MP is not set
> # CONFIG_EFI_LOADER is not set
>diff --git a/configs/xilinx_zynqmp_mini_nand_defconfig b/configs/xilinx_z=
ynqmp_mini_nand_defconfig
>index ba8f02c5b11d=2E=2Eab446a201105 100644
>--- a/configs/xilinx_zynqmp_mini_nand_defconfig
>+++ b/configs/xilinx_zynqmp_mini_nand_defconfig
>@@ -10,6 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x40000
> CONFIG_ENV_SIZE=3D0x80
> CONFIG_DEFAULT_DEVICE_TREE=3D"zynqmp-mini-nand"
> CONFIG_SYS_LOAD_ADDR=3D0x8000000
>+CONFIG_MINI=3Dy
> CONFIG_REMAKE_ELF=3Dy
> # CONFIG_MP is not set
> # CONFIG_EFI_LOADER is not set
>diff --git a/configs/xilinx_zynqmp_mini_nand_single_defconfig b/configs/x=
ilinx_zynqmp_mini_nand_single_defconfig
>index a8a0055f2e5b=2E=2Ec1919c577895 100644
>--- a/configs/xilinx_zynqmp_mini_nand_single_defconfig
>+++ b/configs/xilinx_zynqmp_mini_nand_single_defconfig
>@@ -10,6 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x40000
> CONFIG_ENV_SIZE=3D0x80
> CONFIG_DEFAULT_DEVICE_TREE=3D"zynqmp-mini-nand"
> CONFIG_SYS_LOAD_ADDR=3D0x8000000
>+CONFIG_MINI=3Dy
> CONFIG_REMAKE_ELF=3Dy
> # CONFIG_MP is not set
> # CONFIG_EFI_LOADER is not set
>diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_z=
ynqmp_mini_qspi_defconfig
>index c08b10c6944f=2E=2E17b527b0189e 100644
>--- a/configs/xilinx_zynqmp_mini_qspi_defconfig
>+++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
>@@ -15,6 +15,7 @@ CONFIG_SYS_LOAD_ADDR=3D0x8000000
> CONFIG_SPL=3Dy
> # CONFIG_SPL_FS_FAT is not set
> # CONFIG_SPL_LIBDISK_SUPPORT is not set
>+CONFIG_MINI=3Dy
> CONFIG_SYS_MEM_RSVD_FOR_MMU=3Dy
> CONFIG_ZYNQMP_NO_DDR=3Dy
> # CONFIG_PSCI_RESET is not set

