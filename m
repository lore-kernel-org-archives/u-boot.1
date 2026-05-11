Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F537CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 14:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB91783EF9;
	Mon, 11 May 2026 16:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="tWCMGYyM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9991A83A91; Mon, 11 May 2026 15:40:08 +0200 (CEST)
Received: from mxd-3-705.seznam.cz (mxd-3-705.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:705])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0A078341A
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-7994f94c68-kzzv6
 (smtpc-mxd-7994f94c68-kzzv6 [2a02:598:96:8a00::1200:705])
 id 2aefa94a71e1fd232b466514; Mon, 11 May 2026 15:39:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1778506764; bh=xuf8jiEOJTvqx0rDnaM9fanSgl0+4plWBxNsKxIWcXw=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=tWCMGYyM6Z6wNtKxiJIWT0CQYRRXJePZMjuKtopsoZemGqTkNTc7XmmjBGf42i+mF
 rRlwgl/66AtzXa3wQp1d90h9KHKQArwU/RJlCC/XL8w39gWai2Kdk25IWEB4J5G6IF
 I7ZPF3/Dg94Kr/dgL8xLNAva3Q+5i4r5RlPTRlYxEAar5AU+lt+rbpqkUOvLG4v1Az
 9GHhnM7nQeG++toxMmm7H9fmGNBr9nTc1FO4ePWiMM6CWHxD4Dt+Yg4yaAepmpxyS7
 8PgYTCmk6OuNyZgxon/YbFFtZXj0tlBBKZquuDdi/JynqkOk5xGi5GkjZMEBHkTGjx
 CYYFk38uoYemA==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-856d78d9df-ccp9l (szn-email-smtpd/2.0.72) with ESMTPA
 id b62ab91b-dacd-459e-b7ac-9ec0cc0f1042;
 Mon, 11 May 2026 15:39:09 +0200
Message-ID: <9ee63320-e219-462b-a5a8-78c8b0e8ec67@seznam.cz>
Date: Mon, 11 May 2026 15:39:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/11] qualcomm: add defconfig, env and docs for SPL on
 sdm845
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Heiko Schocher
 <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20260508-qcom_spl-v7-0-7d0e22aaaa8f@seznam.cz>
 <20260508-qcom_spl-v7-10-7d0e22aaaa8f@seznam.cz>
 <7007cacb-bfa7-4034-a669-d24481ef063d@linaro.org>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <7007cacb-bfa7-4034-a669-d24481ef063d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 11 May 2026 16:21:38 +0200
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

Hi,

On 5/11/26 15:19, Casey Connolly wrote:
> Hi Michael,
>
> On 08/05/2026 23:45, michael.srba@seznam.cz wrote:
>> From: Michael Srba <Michael.Srba@seznam.cz>
>>
>> The defconfig should in principle be board-agnostic. Environment
>> simply contains a dfu env specifying where to load u-boot proper
>> (TEXT_BASE - 64).
>>
>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> ---
>>   MAINTAINERS                   |   1 +
>>   board/qualcomm/sdm845_spl.env |   2 +
>>   configs/sdm845_spl_defconfig  | 137 ++++++++++++++++++++++++++++++++++++++++++
>>   doc/board/qualcomm/index.rst  |   1 +
>>   doc/board/qualcomm/spl.rst    |  91 ++++++++++++++++++++++++++++
>>   5 files changed, 232 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0dcc7243124..be830658cfc 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -681,6 +681,7 @@ S:	Maintained
>>   T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
>>   F:	configs/qcm6490_defconfig
>>   F:	configs/qcs9100_defconfig
>> +F:	configs/sdm845_spl_defconfig
>>   F:	drivers/*/*/pm8???-*
>>   F:	drivers/gpio/msm_gpio.c
>>   F:	drivers/mmc/msm_sdhci.c
>> diff --git a/board/qualcomm/sdm845_spl.env b/board/qualcomm/sdm845_spl.env
>> new file mode 100644
>> index 00000000000..2396d003b0c
>> --- /dev/null
>> +++ b/board/qualcomm/sdm845_spl.env
>> @@ -0,0 +1,2 @@
>> +# U-Boot proper text base - 64
>> +dfu_alt_info_ram=uboot.bin ram 0x1487FFC0 0x180000
>> diff --git a/configs/sdm845_spl_defconfig b/configs/sdm845_spl_defconfig
>> new file mode 100644
>> index 00000000000..2db63876266
>> --- /dev/null
>> +++ b/configs/sdm845_spl_defconfig
> Please name this qcom_sdm845_spl_defconfig instead, that also means you
> can remove the MAINTAINERS change here.
>
> Would it make sense to try and strip this down to only the necessary
> stuff? I understand this is more of a PoC though, maybe some of the more
> debug-oriented stuff could go in a config fragment (like
> LOG_MAX_LEVEL=9)? Then the docs can make it clear that you probably want
> the debug fragment and if it becomes more usable in the future (like
> doing DDR training) it doesn't require changing/removing a bunch of
> stuff from here.
I suppose it would be cleaner, but technically there is no negative to leaving
the logging in, other than increased binary size (which is not a problem currently,
if we start running out of SRAM we may need to reevaluate more stuff).

The boot time difference shouldn't be significant, since the log is just in a buffer
in RAM, and it could probably even be read with dfu.

I suppose the log level being that high may be overkill for production use, so
I could see splitting out just that, but not sure what else would make sense
to move into a fragment.
>
>> @@ -0,0 +1,137 @@
>> +CONFIG_ARM=y
>> +CONFIG_SKIP_LOWLEVEL_INIT=y
>> +CONFIG_COUNTER_FREQUENCY=19200000
>> +CONFIG_POSITION_INDEPENDENT=y
>> +# CONFIG_INIT_SP_RELATIVE is not set
>> +CONFIG_ARCH_SNAPDRAGON=y
>> +CONFIG_TEXT_BASE=0x14880000
>> +CONFIG_SYS_MALLOC_LEN=0x20000
>> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x146bffff
>> +CONFIG_SPL_SYS_MALLOC_F_LEN=0x20000
>> +CONFIG_SPL_SERIAL=y
>> +CONFIG_SPL_DRIVERS_MISC=y
>> +CONFIG_SPL_STACK=0x146bffff
>> +CONFIG_SPL_TEXT_BASE=0x1483f000
>> +CONFIG_SPL_BSS_START_ADDR=0x14680000
>> +CONFIG_SPL_BSS_MAX_SIZE=0x2000
>> +CONFIG_SYS_BOOTM_LEN=0x4000000
>> +CONFIG_SYS_LOAD_ADDR=0x0
>> +CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
>> +CONFIG_BOOT0_SDM845_WORKAROUND=y
>> +CONFIG_SPL=y
>> +CONFIG_SPL_PAYLOAD="u-boot.img"
>> +CONFIG_SKIP_RELOCATE=y
>> +# CONFIG_EFI_LOADER is not set
>> +CONFIG_OF_BOARD_SETUP=y
>> +CONFIG_USE_PREBOOT=y
>> +CONFIG_CONSOLE_RECORD=y
>> +CONFIG_CONSOLE_RECORD_OUT_SIZE=0xA000
>> +CONFIG_CONSOLE_RECORD_OUT_SIZE_F=0xA000
>> +CONFIG_LOGLEVEL=9
>> +CONFIG_SYS_STDIO_DEREGISTER=y
>> +CONFIG_LOG_MAX_LEVEL=9
>> +CONFIG_SPL_LOG=y
>> +CONFIG_SPL_LOG_MAX_LEVEL=9
>> +# CONFIG_DISPLAY_CPUINFO is not set
>> +CONFIG_SPL_MAX_SIZE=0x7ffc0
>> +CONFIG_SPL_PAD_TO=0x0
>> +CONFIG_SPL_REMAKE_ELF_LDSCRIPT="arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds"
>> +CONFIG_SPL_DMA=y
>> +CONFIG_SPL_REMAKE_ELF=y
>> +CONFIG_SPL_DM_RESET=y
>> +CONFIG_SPL_POWER_DOMAIN=y
>> +CONFIG_BOOTM_NETBSD=y
>> +CONFIG_CMD_CLK=y
>> +CONFIG_CMD_DFU=y
>> +CONFIG_CMD_GPIO=y
>> +CONFIG_CMD_I2C=y
>> +CONFIG_CMD_MMC=y
>> +CONFIG_CMD_UFS=y
>> +CONFIG_CMD_CAT=y
>> +CONFIG_CMD_RNG=y
>> +CONFIG_CMD_REGULATOR=y
>> +CONFIG_CMD_LOG=y
>> +CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
>> +CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE=y
>> +CONFIG_ENV_DEFAULT_ENV_TEXT_FILE="board/qualcomm/sdm845_spl.env"
>> +CONFIG_NET_RANDOM_ETHADDR=y
>> +# CONFIG_OFNODE_MULTI_TREE is not set
>> +CONFIG_BUTTON_QCOM_PMIC=y
>> +CONFIG_CLK=y
>> +CONFIG_SPL_CLK=y
>> +CONFIG_CLK_STUB=y
>> +CONFIG_SPL_CLK_STUB=y
>> +CONFIG_CLK_QCOM_SDM845=y
>> +CONFIG_DFU_MMC=y
>> +CONFIG_DFU_RAM=y
>> +CONFIG_DFU_SCSI=y
>> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
>> +CONFIG_DMA=y
>> +CONFIG_DMA_CHANNELS=y
>> +CONFIG_USB_FUNCTION_FASTBOOT=y
>> +CONFIG_FASTBOOT_BUF_ADDR=0xdeadbeef
>> +CONFIG_MSM_GPIO=y
>> +CONFIG_QCOM_PMIC_GPIO=y
>> +CONFIG_DM_I2C=y
>> +CONFIG_SYS_I2C_QUP=y
>> +CONFIG_I2C_MUX=y
>> +CONFIG_IOMMU=y
>> +CONFIG_QCOM_HYP_SMMU=y
>> +CONFIG_MISC=y
>> +CONFIG_NVMEM=y
>> +CONFIG_I2C_EEPROM=y
>> +CONFIG_MMC_SDHCI=y
>> +CONFIG_MMC_SDHCI_ADMA=y
>> +CONFIG_MMC_SDHCI_MSM=y
>> +CONFIG_DM_ETH_PHY=y
>> +CONFIG_PHY=y
>> +CONFIG_SPL_PHY=y
>> +CONFIG_PHY_QCOM_QMP_UFS=y
>> +CONFIG_PHY_QCOM_QUSB2=y
>> +CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
>> +CONFIG_PHY_QCOM_SNPS_EUSB2=y
>> +CONFIG_PHY_QCOM_USB_HS_28NM=y
>> +CONFIG_PHY_QCOM_USB_SS=y
>> +CONFIG_PINCTRL=y
>> +CONFIG_PINCONF=y
>> +CONFIG_PINCTRL_QCOM_APQ8016=y
>> +CONFIG_PINCTRL_QCOM_APQ8096=y
>> +CONFIG_PINCTRL_QCOM_QCM2290=y
>> +CONFIG_PINCTRL_QCOM_QCS404=y
>> +CONFIG_PINCTRL_QCOM_SDM845=y
>> +CONFIG_PINCTRL_QCOM_SM6115=y
>> +CONFIG_PINCTRL_QCOM_SM8250=y
>> +CONFIG_PINCTRL_QCOM_SM8550=y
>> +CONFIG_PINCTRL_QCOM_SM8650=y
>> +CONFIG_PINCTRL_QCOM_X1E80100=y
>> +CONFIG_DM_PMIC=y
>> +CONFIG_PMIC_QCOM=y
>> +CONFIG_DM_REGULATOR=y
>> +CONFIG_DM_REGULATOR_FIXED=y
>> +CONFIG_DM_REGULATOR_QCOM_RPMH=y
>> +CONFIG_DM_RNG=y
>> +CONFIG_RNG_MSM=y
>> +CONFIG_SCSI=y
>> +CONFIG_MSM_SERIAL=y
>> +CONFIG_SOC_QCOM=y
>> +CONFIG_QCOM_COMMAND_DB=y
>> +CONFIG_QCOM_RPMH=y
>> +CONFIG_SPMI_MSM=y
>> +CONFIG_SYSINFO=y
>> +CONFIG_SYSINFO_SMBIOS=y
>> +CONFIG_SYSRESET_QCOM_PSHOLD=y
>> +CONFIG_USB=y
>> +CONFIG_USB_DWC3=y
>> +CONFIG_USB_DWC3_GENERIC=y
>> +CONFIG_SPL_USB_DWC3_GENERIC=y
>> +CONFIG_USB_GADGET=y
>> +CONFIG_USB_GADGET_VENDOR_NUM=0x0525
>> +CONFIG_USB_GADGET_PRODUCT_NUM=0xb4a4
>> +CONFIG_USB_ETHER=y
>> +CONFIG_USB_ETH_CDC=y
>> +CONFIG_SPL_DFU=y
>> +CONFIG_SPL_USB_SDP_SUPPORT=y
>> +CONFIG_UFS=y
>> +# CONFIG_SPL_USE_TINY_PRINTF is not set
>> +CONFIG_CIRCBUF=y
>> diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
>> index 3238a68e859..65e3e222f68 100644
>> --- a/doc/board/qualcomm/index.rst
>> +++ b/doc/board/qualcomm/index.rst
>> @@ -14,3 +14,4 @@ Qualcomm
>>      iq8
>>      phones
>>      rdp
>> +   spl
>> diff --git a/doc/board/qualcomm/spl.rst b/doc/board/qualcomm/spl.rst
>> new file mode 100644
>> index 00000000000..0cf18c70e4a
>> --- /dev/null
>> +++ b/doc/board/qualcomm/spl.rst
>> @@ -0,0 +1,91 @@
>> +.. SPDX-License-Identifier: GPL-2.0+
>> +.. sectionauthor:: Michael Srba <Michael.Srba@seznam.cz>
>> +
>> +===================================
>> +Booting U-Boot SPL on Qualcomm SoCs
>> +===================================
>> +
>> +Overview
>> +--------
>> +The boot process on sdm845 (and some other Qualcomm SoCs) starts with the bootrom
>> +of the Application Processor, which executes XBL_SEC, which jumps to "OEM" code
>> +in EL1. Production devices are typically "fused", with a hash of the OEM's signing
>> +key burnt into one of the "QFUSE" banks on the SoC making it impossible to run
>> +custom bootloader code. As a result U-Boot SPL is only supported on unfused
>> +("secureboot off") devices. XBL_SEC is always signed by Qualcomm, and the fuses
>> +to disable turning off signature verification for it are always burnt at the
>> +factory, so replacing XBL_SEC is impossible without using JTAG. Of course JTAG
>> +is typically disabled on devices that have secure boot enabled, or at minimum
>> +greatly neutered.
>> +
>> +U-Boot SPL for Qualcomm platforms uses a custom linker script (per SoC) to build a bootable ELF.
>> +For sdm845 (and some other platforms) this has two sections, u-boot code and an embedded
>> +xbl_sec elf (signed by Qualcomm). To boot on an unfused SoC, the elf additionally
>> +needs to have hash sections added, which can be accomplished with qtestsign.
>> +
>> +Currently, sdm845 is supported. You need a device with secure boot disabled
>> +(or with secure boot enabled if you enabled it yourself and have the private key,
>> +though for full security you'd also want to disable JTAG which will remove your ability
>> +to mess with the control flow in the bootrom (immutable) and in XBL_SEC (signed)).
>> +
>> +Building
>> +--------
>> +First, obtain an xbl_sec that includes the EL3 privilege escalation feature
>> +and place it at .output/xbl_sec.elf. You can extract it from an xbl elf.
>> +If you're unable to find one, you can also use JTAG/SWD to break at the SMC
>> +entry and use gdb to jump to the u-boot entry point in EL3.
>> +
>> +To build a bootable image, you need to use a defconfig specific to your SoC.
>> +This is because the ELF has to specify where in the address space to put u-boot SPL,
>> +and this may differ per SoC. There may be other SoC-dependent build time choices,
>> +though in principle those could be made at runtime.
>> +
>> +First run ``make sdm845_spl_defconfig``::
>> +
>> +	make CROSS_COMPILE=aarch64-suse-linux- O=.output DEVICE_TREE=qcom/sdm845-shift-axolotl sdm845_spl_defconfig
>> +
>> +Then compile u-boot and specify the dts for your board (technically nothing about the resulting
>> +SPL image should be board-specific, but there are no non-board-specific device trees in Linux)::
>> +
>> +	make CROSS_COMPILE=aarch64-suse-linux- O=.output DEVICE_TREE=qcom/sdm845-shift-axolotl
>> +
>> +Finally, use ``qtestsign`` to add the hash segments required by PBL::
>> +
>> +	qtestsign -v 5 -o .output/spl/u-boot-spl_signed.elf prog .output/spl/u-boot-spl.elf
>> +
>> +Running
>> +-------
>> +Currently, U-Boot SPL for Qualcomm platforms expects to be booted via EDL::
>> +
>> +	edl.py --loader=$PWD/.output/spl/u-boot-spl_signed.elf
>> +
>> +SPL will then launch the DFU gadget and wait for you to upload u-boot proper::
>> +
>> +	dfu-util -RD .output/u-boot.img
>> +
>> +u-boot proper will then likely crash, since SPL currently doesn't init DRAM on Qualcomm platforms
>> +and u-boot proper currently doesn't support running from SRAM. The latter should be an easy fix.
>> +
>> +Notes on memory map
>> +-------------------
>> +| There are various banks of SRAM on a Qualcomm SoC that we can use prior to DRAM init.
>> +| For example:
>> +| msm8916 - 512K L2-as-TCM (at ``0x08000000``), 16K OCIMEM (at ``0x08600000``)
>> +| msm8998 - 1M L2-as-TCM (at ``0x14000000``), 256K OCIMEM (at ``0x14680000``)
>> +| sdm845 - 1.5M BOOT_IMEM (at ``0x14800000``), 256K OCIMEM (at ``0x14680000``)
>> +
>> +There's also RPM code/data RAM and hexagon TCMs, but unless we want to boot dram-less Linux
>> +we can probably safely ignore those. On msm8916 they may come in handy though.
>> +
>> +sdm845 can also have 8M LLCC-as-TCM in theory, but this appears to be broken.
>> +L2-as-TCM is no longer present.
>> +
>> +Since a limited amount of not necessarily continuous SRAM is available, we need to manually
>> +specify where .text, .bss, the malloc pool and the stack go. The Kconfig contains reasonable
>> +defaults per SoC.
>> +
>> +On sdm845, we by default put U-Boot SPL in BOOT_IMEM, with .bss, malloc pool and the stack
>> +filling OCIMEM. We can also fit U-Boot proper in BOOT_IMEM, for dram-less DFU or peek/poke
>> +with a shell. To that end, we set ``CONFIG_TEXT_BASE`` at 512K into BOOT_IMEM, and set
>> +``CONFIG_SPL_MAX_SIZE`` to 512K - 64. We also configure dfu to load U-Boot proper
>> +to ``CONFIG_TEXT_BASE`` - 64. (64 bytes is the size of u-boot legacy header)
>>

