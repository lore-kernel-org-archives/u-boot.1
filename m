Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154F5CF8840
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 18:53:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE60B88D03;
	Fri,  4 Oct 2024 20:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GAa03Ppi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03EEE8870D; Fri,  4 Oct 2024 16:22:09 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 420F888915
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 16:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cc43454d5so17641975e9.3
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728051720; x=1728656520; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BT2fDxlfKtq79s2uvM1oPQTkZ4VF2aBEt2N7ea5HRM8=;
 b=GAa03PpiNphXriKxJ/3l8MrH+woZ/eAhx5/pSxUoEUR7gSk0urjJUTSLtYtuSBJ1hJ
 qJQngcMwkLRORWShrfuF9DzFaEFub1r+g99SGwKtjWsa6+spGcc0T9n29Tkd99nMtztk
 r1Y2vJkHbkMc1CdU8DNu9eUV6fJRdBjo+z7jnjqrzYNbBu2spOYSDSmYSdMKPRmwxMCz
 gsEAa4TqdqiERLnjAoqqdVC0hlF1fjCtYRxRjoeS5rK3mFR/jcXMHsedXROw2uSqDVOY
 2XrrhnzPCHschqAxdCm4v0FqBdjmUlELSTBS0c6E06hvt0Ml58hGp0En6vZx1KHxt5wy
 ZPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728051720; x=1728656520;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BT2fDxlfKtq79s2uvM1oPQTkZ4VF2aBEt2N7ea5HRM8=;
 b=BZApqFovfp63tXejtmnE2KQsLAKN2D/bV6xOtlrbjh+frmnO2CPA85n8vqekauGSlZ
 keFkrXBvPCMVNrBpTss/ih/dWZuLghUXeL4vrndQyLq7aXJlzmKhPbrkk/m4u+SQVhG0
 c8R9kHNC4RFUFpB0jb/Ct+ELgfmIjvKBL8kyzcxNNTaoSBhwSjxry4acbAvD0vtteogL
 L9dDXx1ia4QjhtzZ1RcDGnv7X9rNbJwJ5tCVo74bTpDcghxsNGOvO+u+uPABEl3t55il
 +x8eft+zVMsxK59PK0ypZ3g4LPOMp72CyiXTtVKB2yBeldtImgOTF9dcBFraGRtzsAay
 +lCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfcEuumGdzhNjwYxSWN8NQnCRIW3JniTLT9heEDjNXQDdcwD9G4eArUnvH0u5HrE6rl2kkqWs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0C6B6YdX+acQnGjGmgOwVeFYrN5Gl8FGef5wPziHYceWadoyB
 oKEJjsk25SXedpdDb/iJXd5GlfMPxWVbMJ+EbYKTfulr210f9REDg8hWZsIxWuo=
X-Google-Smtp-Source: AGHT+IEwzuVaIsCZelePed9jnXGf9BW7lpZIOJm8GXwreeRsLg34oZCQE4HqwWFfJ6VEMzih0Yjwsw==
X-Received: by 2002:a05:600c:1d1d:b0:424:ad14:6b79 with SMTP id
 5b1f17b1804b1-42f85ab3554mr19987725e9.8.1728051719011; 
 Fri, 04 Oct 2024 07:21:59 -0700 (PDT)
Received: from [192.168.2.2] ([82.195.86.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d082d1a4asm3340316f8f.92.2024.10.04.07.21.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 07:21:57 -0700 (PDT)
Message-ID: <7f606196-6474-443c-99cc-58b4e818173c@linaro.org>
Date: Fri, 4 Oct 2024 16:21:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL] Please pull qcom/qcom-next
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20241004141954.265158-1-caleb.connolly@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241004141954.265158-1-caleb.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 04 Oct 2024 20:53:00 +0200
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

Hi Tom,

Sorry, accidentally ran request-pull against master. Please disregard

On 04/10/2024 16:17, Caleb Connolly wrote:
> Hi Tom,
> 
> Various improvements and fixes for Qualcomm
> 
> * Initial UFS PHY driver
> * Support for SM8150 (clock and pinctrl)
> * Allow writing configuration to PMIC GPIOs again
> * Support for configuring "special" pins (e.g. UFS reset or sdhc pins)
> * Support for "clk dump" command to decode various clocks.
> 
> CI: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/22527
> ---
> The following changes since commit 9cfe0cab3bf135a505e1e163ca442a4e4064d58e:
> 
>    Prepare v2024.10-rc6 (2024-09-30 16:47:28 -0600)
> 
> are available in the Git repository at:
> 
>    git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git qcom-next
> 
> for you to fetch changes up to 04584089e12e34aa91ef06aeb91b1550facb0312:
> 
>    clk/qcom: sm8250: add debug data (2024-10-04 14:57:04 +0200)
> 
> ----------------------------------------------------------------
> Alexander Kochetkov (1):
>        Makefile: pass external DTB provided by make variable EXT_DTB to binman
> 
> Anatolij Gustschin (10):
>        board: shc: convert to DM_I2C
>        board: chiliboard: convert to DM_I2C
>        board: cm-t43: convert to DM_I2C
>        board: igep003x: convert to DM_I2C
>        board: sl50: convert to DM_I2C
>        board: rut: convert to DM_I2C
>        board: novena: convert to DM_I2C
>        board: vf610twr: convert to DM_I2C
>        board: cm_fx6: convert to DM_I2C
>        board: vining_2000: convert to DM_I2C
> 
> Andrejs Cainikovs (4):
>        board: apalis-imx8: add reset code
>        apalis-imx8: enable i.MX specific BOOTAUX
>        colibri-imx8x: enable i.MX specific BOOTAUX
>        colibri-imx8x: enable i.MX specific SNVS configuration
> 
> Andrew Davis (1):
>        arm: dts: keystone: Move to OF_UPSTREAM
> 
> Arseniy Krasnov (3):
>        mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
>        mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
>        mtd: rawnand: meson: read/write access for boot ROM pages
> 
> Arturo Buzarra (1):
>        rtc: rv3028: add support to manage VDD regulator
> 
> Bastien Curutchet (1):
>        spi: davinci: Drop the preload of TX buffer before read/writes operations
> 
> Benjamin Hahn (2):
>        configs: phycore-imx8mp_defconfig: Enable SPI NOR flash support
>        board: phytec: phycore_imx8mp: Add mtd spi partitions
> 
> Bhupesh Sharma (2):
>        phy: qcom: Import QMP phy related header files from Linux
>        phy: qcom: Add QMP UFS PHY driver
> 
> Billy Tsai (1):
>        gpio: Add G7 Aspeed gpio controller driver
> 
> Caleb Connolly (35):
>        mmc: msm_sdhci: program core_vendor_spec
>        mach-snapdragon: refactor board_fdt_blob_setup()
>        mach-snapdragon: parse memory ourselves
>        mach-snapdragon: set serial number
>        mach-snapdragon: allocate fastboot buffer dynamically
>        mach-snapdragon: populate fallback FDT
>        mach-snapdragon: set loadaddr
>        armv8: mmu: add a way to map additional regions
>        soc: qcom: cmd-db: use strncmp() instead of memcmp()
>        soc: qcom: cmd-db: map cmd-db region
>        qcom_defconfig: bump CONFIG_NR_DRAM_BANKS
>        clk/qcom: add initial clock driver for sc7280
>        dts: qcs6490-rb3gen2-u-boot: add override dtsi
>        dts: qcs6490-rb3gen2-u-boot: USB host mode
>        iommu: qcom-smmu: add sc7280-smmu-500 compatible
>        qcom_defconfig: enable SC7280 clocks
>        configs: add qcm6490_defconfig
>        doc: board/qualcomm: document rb3gen2 building/flashing
>        board/qualcomm: add debug config fragments for some SoCs
>        efi: define struct efi_guid
>        lib: uuid: add UUID v5 support
>        efi: add a helper to generate dynamic UUIDs
>        doc: uefi: document dynamic UUID generation
>        sandbox: switch to dynamic UUIDs
>        lib: uuid: supporting building as part of host tools
>        include: export uuid.h
>        tools: mkeficapsule: use u-boot UUID library
>        tools: mkeficapsule: support generating dynamic GUIDs
>        test: lib/uuid: add unit tests for dynamic UUIDs
>        test: lib/uuid: add tests for UUID version/variant bits
>        Revert "gpio: qcom_pmic: add a quirk to skip GPIO configuration"
>        clk/qcom: implement clk dump
>        clk/qcom: sdm845: add dump data
>        clk/qcom: sm6115: add debug data
>        clk/qcom: sm8250: add debug data
> 
> Chia-Wei Wang (9):
>        riscv: Make A ISA extension selectable
>        riscv: Make stack size shift configurable
>        riscv: u-boot-spl.lds: Remove _image_binary_end alignment
>        riscv: Add AST2700 SoC initial platform support
>        timer: Add AST2700 IBEX timer support
>        board: ibex_ast2700: Add FMC header support
>        ram: ast2700: Add DRAM controller initialization
>        configs: ibex-ast2700: Enable DRAM and timer driver
>        drivers/crypto: aspeed: Add Caliptra SHA ACC support
> 
> Chintan Vankar (3):
>        common: spl: spl: Init DRAM size in R5/A53 SPL
>        soc: ti: k3-navss-ringacc: Fix reconfiguration of qmode API
>        arm64: dts: ti: k3-am62x-sk-common: Add bootph-all property in phy_gmii_sel node
> 
> Christian Marangi (56):
>        clk: mediatek: mt7623: fix broken peri_cgs clk with XTAL parents
>        clk: mediatek: mt7623: split clk tree to dedicated topckgen and apmixed
>        clk: mediatek: mt7623: define id_offs_map and import clk ID from upstream
>        clk: mediatek: mt7623: remap apmixedsys clock ID
>        clk: mediatek: mt7623: remap peri clock ID and add MUX
>        clk: mediatek: mt7981: add missing clock for infra_ipcie_pipe
>        clk: mediatek: mt7981: fix typo for infra_i2c0_ck
>        clk: mediatek: mt7981: fix wrong mux width for pwm2 and pwm1 clock
>        clk: mediatek: mt7981: fix wrong clock definition for spi2
>        clk: mediatek: mt7981: add missing clock for spi1 node
>        clk: mediatek: mt7981: swap wrong clock-names for spi nodes
>        clk: mediatek: mt7981: fix wrong parent for TOP_FAUD clock
>        clk: mediatek: mt7981: fix wrong parent list for INFRA_PWM1_SEL mux
>        clk: mediatek: mt7981: implement sgmii0/1 clock
>        clk: mediatek: mt7981: drop 1/1 spurious factor
>        clk: mediatek: mt7981: replace infracfg ID with upstream linux
>        clk: mediatek: mt7981: fix support for pwm3 clock
>        clk: mediatek: mt7981: convert to unified infracfg gates + muxes
>        clk: mediatek: mt7981: rename CK to CLK
>        clk: mediatek: mt7988: rename CB_CKSQ_40M to TOP_XTAL
>        clk: mediatek: mt7988: rename TOP_DA_SELM_XTAL_SEL to TOP_DA_SEL
>        clk: mediatek: mt7988: rename TOP_CK_NPU_SEL_CM_TOPS_SEL to TOP_NPU_SEL
>        clk: mediatek: mt7988: move INFRA_PCIE_PERI_26M_CK_Px clock at top
>        clk: mediatek: mt7988: fix wrong parent for INFRA_PCIE_PERI_26M_CK_P2
>        clk: mediatek: mt7988: drop 1/1 infracfg spurious factor
>        clk: mediatek: mt7988: rename TOPCKGEN factor clock to upstream naming
>        clk: mediatek: mt7988: reorder TOPCKGEN factor ID
>        clk: mediatek: mt7988: drop 1/1 spurious factor for topckgen
>        clk: mediatek: mt7988: comment out infracfg clk not defined
>        clk: mediatek: mt7988: replace clock ID with upstream linux
>        clk: mediatek: mt7988: convert to unified infracfg gates + muxes
>        clk: mediatek: mt7988: rename CK to CLK
>        clk: mediatek: mt7986: fix wrong shift for PCIe clocks
>        clk: mediatek: mt7986: rename CB_CKSQ_40M to TOP_XTAL
>        clk: mediatek: mt7986: rename 66M_MCK to SYSAXI_D2
>        clk: mediatek: mt7986: fix wrong parent for INFRA_ADC_26M_CK
>        clk: mediatek: mt7986: drop 1/1 infracfg spurious factor
>        clk: mediatek: mt7986: add missing entry for IPCIE_PIPE_CK infra gate
>        clk: mediatek: mt7986: fix typo for infra_i2c0_ck
>        clk: mediatek: mt7986: rename TOPCKGEN factor clock to upstream naming
>        clk: mediatek: mt7986: reorder TOPCKGEN factor ID
>        clk: mediatek: mt7986: drop 1/1 spurious factor for topckgen
>        clk: mediatek: mt7986: comment out CK_TOP_A_TUNER as not used
>        clk: mediatek: mt7986: move INFRA_TRNG_CK to the bottom of the list
>        clk: mediatek: mt7986: replace infracfg ID with upstream linux
>        clk: mediatek: mt7986: convert to unified infracfg gates + muxes
>        clk: mediatek: mt7986: rename CK to CLK
>        clk: mediatek: mt7622: fix broken peri_cgs clk with XTAL parents
>        clk: mediatek: mt7622: rename AUDIO_AWB3 to AUDIO_AWB2
>        clk: mediatek: mt7622: move INFRA_TRNG to the bottom
>        clk: mediatek: mt7622: add missing clock define for MAIN_CORE_EN
>        clk: mediatek: mt7622: add missing clock MUX1_SEL
>        clk: mediatek: mt7622: add missing clock PERI_UART4_PD
>        clk: mediatek: mt7622: add missing clock PERIBUS_SEL clock
>        clk: mediatek: mt7622: add missing A1/2SYS clock ID
>        pci: mediatek: add support for upstream split PCIe node
> 
> Daniel Palmer (1):
>        spl: spl_load: fix comparison between negative error code and unsigned size
> 
> Daniel Schultz (12):
>        include: env: phytec: k3_mmc: Rename variables
>        include: env: phytec: Add raucinit to k3_mmc environment
>        include: net: phytec: Add K3 network boot logic
>        include: env: phytec: Add K3 boot logic for OSPI/QSPI flashes
>        board: phytec: phycore_am62x: Add Network/SPI Boot
>        board: phytec: phycore_am64x: Add Network/SPI Boot
>        configs: phycore_am62x_a53_defconfig: Make BOOTCMD generic
>        configs: phycore_am64x_a53_defconfig: Make BOOTCMD generic
>        configs: phycore_am62x_a53_defconfig: Merge am62x_a53_usbdfu.config
>        configs: Add phycore_am62x_r5_usbdfu_defconfig
>        configs: phycore_am62x_a53_defconfig: Fix CONFIG_ENV_SIZE
>        configs: phycore_am62x_*_defconfig: Set PHYTEC as Manufacturer
> 
> Dario Binacchi (2):
>        bootm: adjust the print format
>        cmd: booti: adjust the print format
> 
> Derald D. Woods (1):
>        omap3: omap3evm: Migrate to OF_UPSTREAM
> 
> Fabio Estevam (14):
>        tqma6: Remove non-DM board code
>        tqma6_mba6: Remove unused defines
>        tqma6_mba6: Remove UART board code
>        gw_ventana: Remove unneeded comments
>        mx6: Expand bmode to support ecspi3 boot
>        mx6slevk: Convert to watchdog driver model
>        mx6slevk: Fix the boot device number
>        mx6slevk: Keep a single defconfig
>        mx6slevk: Convert to OF_UPSTREAM
>        imx: Remove CFG_MXC_USB_FLAGS
>        usb: ehci-mx5: Add a default for CFG_MXC_USB_PORTSC
>        mx5: Remove CFG_MXC_USB_PORT
>        imx: Remove CFG_MXC_USB_PORTSC
>        imx6q-lxr: Add board support
> 
> Francis Laniel (1):
>        cli: modern_hush: Add upstream commits up to 13 July 2024
> 
> Franco Venturi (1):
>        mmc: fix signed vs unsigned compare in read check in _spl_load()
> 
> Frank Li (1):
>        imx9: soc: imx9: soc: Align UID endianness with ROM
> 
> Gaskell, Oliver (1):
>        dm: core: Make SPL_DM_SEQ_ALIAS select SPL_STRTO
> 
> Guillaume La Roque (1):
>        board: ti: am62x_evm: Add android bootflow
> 
> Heinrich Schuchardt (4):
>        ata: dwc_ahsata: create boot device
>        ata: sata_rescan must scan for block devices
>        mmc: consider cd-gpios in Synopsys DesignWare driver
>        cmd: simplify CONFIG_CMD_USB_MASS_STORAGE dependencies
> 
> Hiago De Franco (2):
>        tools/scripts/Kconfig: Update references from kconfig-language.txt to rst
>        fs: Fix SPL build if SPL_FS_LOADER is enabled and FS_LOADER is disabled
> 
> Ilias Apalodimas (4):
>        efi_loader: shorten efi_bootmgr_release_uridp_resource()
>        efi_loader: rename efi_bootmgr_image_return_notify
>        efi_loader: return the correct error in efi_bootmgr_release_uridp()
>        Kconfig: clean up the efi configuration status
> 
> Ion Agorria (1):
>        test: hush: dollar: fix bugous behavior
> 
> Jacky Bai (1):
>        imx9: soc: Mask the wdog reset in src by default on i.mx9
> 
> Jacky Chou (5):
>        net: ftgmac100: Fixed the cache coherency issues of rx memory
>        net: ftgmac100: Fixed NC-SI PHY device cannot get
>        net: ftgmac100: Modify desc. size to cache line
>        net: ftgmac100: Add Aspeed AST2700 support
>        driver: net: Add Aspeed AST2700 MDIO support
> 
> Jerome Forissier (17):
>        net: guard call to tftp_start() with IS_ENABLED(CONFIG_CMD_TFTPBOOT)
>        spl: ram: hide SPL_RAM_SUPPORT
>        buildman/toolchain.py: do not set CROSS_COMPILE for sandbox
>        flash: prefix error codes with FL_
>        at91: rename mem_init() to at91_mem_init()
>        arm: omap2: add missing #include <netdev.h>
>        net: fm: call dtsec_init_phy() only when it is defined
>        net: wget: removed unused function wget_success()
>        net: phy: ncsi: depend on NET
>        net: ftgmac100: depend on NET
>        net: wget: allow EFI boot
>        net: fec_mxc_init(): do not ignore return status of fec_open()
>        test/py: net_boot: fix comment
>        test/py: test_efi_loader: add missing dependency on cmd_tftpboot
>        test/py: test_efi_loader: add HTTP (wget) test for the EFI loader
>        common: update: UPDATE_COMMON implies CMD_TFTPBOOT
>        cmd: pxe: CMD_PXE implies CMD_TFTPBOOT
> 
> JianfengA.Zhu@sony.com (1):
>        lib: elf: Fix bootelf -p crash issue
> 
> Jim Liu (5):
>        gpio: npcm: Add SGPIO support for Nuvoton NPCM SoCs
>        timer: npcm: Change counter source
>        arm: dts: nuvoton: add dts support for npcm845 yosemite4
>        board: arbel: correct the dram bank size
>        configs: arbel_evb: change env offset and boot address
> 
> Joakim Tjernlund (1):
>        Add mkimage secp521r1 ECDSA curve support
> 
> John Keeping (1):
>        regulator: fixed: fix regulator-fixed-clock
> 
> John Vicky Vykuntapu (1):
>        xilinx: zynqmp: Add bootmenu support
> 
> Jonas Karlman (6):
>        dm: core: fdtaddr: Avoid multiple calls to fdt_parent_offset()
>        dm: core: ofnode: Avoid multiple calls to ofnode_get_parent()
>        dm: core: regmap: Avoid multiple calls to ofnode_get_parent()
>        bootstage: Fix unstash of records from SPL
>        power: regulator: Do not call set_suspend_value with -ENODATA
>        power: regulator: Consistently return -ENOSYS when ops is unimplemented
> 
> Jonathan Humphreys (5):
>        arch: arm: dts: k3-j784s4-r5-evm: Add missing fss range
>        arch: arm: dts: k3-am69-r5-sk: Add missing fss range
>        arch: arm: dts: k3-j7200-r5-evm: Add missing fss range
>        arch: arm: dts: k3-j721e-r5-evm: Add missing fss range
>        arch: arm: dts: k3-j721e-r5-sk: Add missing fss range
> 
> Julius Lehmann (3):
>        clk: qcom: add driver for SM8150 SoC
>        pinctrl: qcom: add driver for SM8150 SoC
>        config: qcom: add sm8150 to qcom_defconfig
> 
> Keerthy (1):
>        power: regulator: tps6287x: Add driver for TPS6287x step down convertors
> 
> Kishon Vijay Abraham I (6):
>        firmware: ti_sci: Add No-OP for "RX_FL_CFG"
>        soc: ti: k3-navss-ringacc: Initialize base address of ring cfg registers
>        dma: ti: k3-udma: Add support for native configuration of chan/flow
>        arm: mach-k3: am62x: am625_init: Probe AM65 CPSW NUSS
>        configs: am62: Add configs for enabling ETHBOOT in R5SPL
>        configs: am62: Enable configs required for Ethboot
> 
> Kongyang Liu (4):
>        dt-bindings: clk: import header for clock controller of sophgo CV1800B
>        clk: sophgo: cv1800b: Add clock controller driver for cv1800b SoC
>        configs: milkv_duo: Enable clock controller
>        riscv: dts: sophgo: Replace device clocks with real clocks.
> 
> Kuan Lim Lee (1):
>        mmc: sdhci-cadence: Add support for Cadence sdmmc v6
> 
> Love Kumar (2):
>        test/py: spi: Add tests for SPI flash device
>        test/py: spi: Set the expected error message
> 
> Lukasz Majewski (1):
>        config: Add 'update_bootimg' command to update flash.bin on Phytec's imx8mm
> 
> MD Danish Anwar (1):
>        remoteproc: uclass: Modify uc_pdata->name to use combination of device name and device's parent name
> 
> Marek Vasut (16):
>        ARM: imx: Use USB SDPS as fallback option on Data Modul i.MX8M Plus eDM SBC
>        ARM: imx: Enable cat and xxd commands on Data Modul i.MX8M Mini/Plus eDM SBC
>        ARM: imx: Make PLL settings configurable at board level
>        ARM: imx: Wrap i.MX config options in MACH_IMX
>        phy: Extend generic_setup_phy() with PHY mode and submode
>        phy: rcar: Split init and set_mode operations
>        phy: test: Implement sandbox PHY .set_mode and DM test
>        ARM: imx: Enable MMU and dcache very early on i.MX8M
>        mmc: Hide mmc speed command under mmc command
>        cmd: osd: Depend on OSD
>        mmc: Poll CD in case cyclic framework is enabled
>        arm64: dts: imx8m: Always name the generated fitImage u-boot.itb
>        power: regulator: Trigger probe of regulators which are always-on or boot-on
>        power: regulator: Convert regulators_enable_boot_on/off() to regulator_post_probe
>        power: regulator: Drop regulator_unset()
>        power: regulator: Drop regulators_enable_boot_on/off()
> 
> Mathieu Othacehe (1):
>        imx: ele_ahab: Add HUK derivation support
> 
> Mattijs Korpershoek (3):
>        bootstd: android: Add U-Boot version to cmdline
>        board: beagle: beagleplay: Add android bootflow support
>        board: ti: am62px: Add android bootflow support
> 
> Maxim Moskalets (1):
>        lib: move phdr increment to for loop heading
> 
> Michael Polyntsov (1):
>        spi: soft_spi: Parse cs-gpios only if num-chipselects is not <0>
> 
> Michal Simek (14):
>        xilinx: Enable SIMPLE_PM_BUS
>        arm64: zynqmp: Add missing vc7_xin fixed clock to sc-vpk180-revA
>        net: gem: Remove undocumented is-internal-pcspma dt flag
>        arm64: zynqmp: Define only one revision in zcu106-rev1.0
>        arm64: zynqmp: Fix status property for m-a2197 boards
>        arm64: zynqmp: Align gpio hogs with dt-schema
>        xilinx: Fix axi and mmc node names in mini configuration
>        arm64: zynqmp: Fix gpio-line-name size for m-a2197 platforms
>        arm64: zynqmp: Fix comment style around gpio line-names
>        arm64: zynqmp: fix i2c mux bus description for m-a2197 platforms
>        arm64: zynqmp: Align mini-qspi DT with dt-schema
>        arm64: zynqmp: Define phy-mode in zcu1275-revB
>        arm64: zynqmp: Use generic spi@ name in zcu111-revA
>        arm64: zynqmp: Rename ina226-vccint-io-bram-ps nodes
> 
> Mikhail Kshevetskiy (2):
>        spi: soft_spi: fix miso gpio property name
>        cmd: led: fix led command usage for the LED_SW_BLINK enabled case
> 
> Miquel Raynal (1):
>        pwm: imx: Don't drop the enable bit once set
> 
> Neil Armstrong (5):
>        mach-snapdragon: use 1MiB for get_page_table_size()
>        soc: qcom: rpmh-rsc: add back __tcs_set_trigger() for SM8550/SM8650
>        regulator: qcom-rpmh-regulator: add support for PM8550 & related regulators
>        gpio: msm: add support for special pins
>        pinctr: qcom: sm8250: add special pins pins configuration data
> 
> Oliver Gaskell (20):
>        arm: dts: Support SC573-EZKIT
>        arm: dts: Support SC584-EZKIT
>        arm: dts: Support SC589-MINI
>        arm: dts: Support SC589-EZKIT
>        arm: dts: Support SC594-SOM-EZKIT
>        arm: dts: Support SC594-SOM-EZLITE
>        arm: dts: Support SC598-SOM-EZKIT
>        arm: dts: Support SC598-SOM-EZLITE
>        dt-bindings: arm: Add SC5xx Series binding
>        dt-bindings: clock: Add SC5xx clock tree bindings
>        dt-bindings: timer: Add SC5xx Timer bindings
>        arm: mach-sc5xx: clean up Kconfig
>        arm: SC598-SOM-EZKIT initial support
>        arm: SC598-SOM-EZLITE initial support
>        arm: SC594-SOM-EZKIT initial support
>        arm: SC594-SOM-EZLITE initial support
>        arm: SC584-EZKIT initial support
>        arm: SC589-EZKIT initial support
>        arm: SC589-MINI initial support
>        arm: SC573-EZKIT initial support
> 
> Padmarao Begari (2):
>        mmc: zynq_sdhci: Remove device_is_compatible() function
>        board: xilinx: Remove conditional check for Microblaze
> 
> Paul Kocialkowski (15):
>        omap3: Define common SPL text base in Kconfig instead of defconfigs
>        omap3: Define common init stack pointer address in Kconfig
>        am33xx: Unify init stack pointer address across boards
>        am33xx: Define common init stack pointer address in Kconfig
>        am43xx: Define common init stack pointer address in Kconfig
>        dra7xx: Unify init stack pointer address across boards
>        dra7xx: Define common init stack pointer address in Kconfig
>        omap3: Define maximum U-Boot size in Kconfig instead of defconfigs
>        omap3: Define maximum SPL size in Kconfig instead of defconfigs
>        omap3: Define DRAM banks number in Kconfig instead of defconfigs
>        dra7xx: Remove explicit DRAM banks number from defconfigs
>        omap3: sniper: Streamline defconfig
>        omap: Use spl_soc_init instead of spl_board_init
>        am33xx: Use regular spl_board_init instead of am33xx_spl_board_init
>        omap3: sniper: Convert to device-tree control and DM I2C
> 
> Peng Fan (13):
>        imx9: soc: wait ssar when power on power domain
>        imx9: soc: Change FSB directly access to fuse API
>        imx9: soc: Print ELE information
>        imx8m: soc: Drop disable_pmu_cpu_nodes
>        imx: Generalize disable_cpu_nodes
>        imx9: soc: Disable cpu1 for variants that only has one A55 core
>        imx: Generalize fixup_thermal_trips
>        imx9: trdc: cleanup code
>        imx9: trdc: introduce trdc_mbc_blk_num
>        imx93_evk: spl: update pmic settings
>        imx93_evk: Remove CONFIG_IMX9_LOW_DRIVE_MODE and ld defconfig
>        imx93_evk: add back Low drive mode ddr timing file
>        net: fec_mxc: Fix clk_ref rate on iMX93
> 
> Philip Oberfichtner (5):
>        x86: provide mb() macro
>        net: dwc_eth_qos: Fix header to be self-contained
>        net: dwc_eth_qos: Adapt probe() for PCI devices
>        net: dwc_eth_qos: Implement bind() for PCI devices
>        net: dwc_eth_qos: Add glue driver for Intel MAC
> 
> Prasad Kummari (5):
>        xilinx: versal-net: fix no previous prototype for function warning.
>        arm64: zynqmp: Add u-boot command to boot into recovery image
>        kbuild: cherry-pick kbuild fdtoverlay changes from linux
>        arm64: zynqmp: Remove overlays and add new dtb entries for ZynqMP
>        cmd: sf: prevent overwriting the reserved memory
> 
> Primoz Fiser (1):
>        imx: imx9: Set correct critical temperature
> 
> Rasmus Villemoes (5):
>        treewide: drop redundant "type string" for SYS_SOC and friends
>        dfu: define a callback function for the dfu_alt_info environment variable
>        env: mmc: refactor mmc_offset_try_partition()
>        env: mmc: do not return an offset before the start of the partition
>        env: mmc: rework mmc_env_partition_by_guid() to work with two separate partitions
> 
> Ravi Minnikanti (1):
>        env: remove vars that are not in default env
> 
> Richard Weinberger (14):
>        ext4: Improve feature checking
>        bootstage: Fix out-of-bounds read in reloc_bootstage()
>        x86: Fix ptrdiff_t for x86_64
>        dlmalloc: Fix integer overflow in request2size()
>        dlmalloc: Fix integer overflow in sbrk()
>        dlmalloc: Make sure allocation size is within malloc area
>        squashfs: Fix integer overflow in sqfs_resolve_symlink()
>        squashfs: Fix integer overflow in sqfs_inode_size()
>        squashfs: Check sqfs_find_inode() return value
>        squashfs: Fix stack overflow while symlink resolving
>        squashfs: Fix heap corruption in sqfs_search_dir()
>        ext4: Fix integer overflow in ext4fs_read_symlink()
>        compiler: Ensure __builtin_*_overflow() support
>        ext4: Fix zalloc()
> 
> Rogerio Guerra Borin (1):
>        configs: verdin-imx8m[mp]: set CONFIG_SPL_LOAD_FIT_ADDRESS
> 
> Sam Protsenko (38):
>        mmc: dw_mmc: Remove unused version field from struct dwmci_host
>        mmc: dw_mmc: Move struct idmac to dw_mmc.c
>        mmc: dw_mmc: Extract waiting for data busy into a separate routine
>        mmc: dw_mmc: Extract FIFO init into a separate routine
>        mmc: dw_mmc: Extract divider update to a separate function
>        mmc: dw_mmc: Extract FIFO data transfer into a separate routine
>        mmc: dw_mmc: Extract DMA transfer handling code into a separate routine
>        mmc: dw_mmc: Extract setting the DMA descriptor into a separate routine
>        mmc: dw_mmc: Improve 32-bit IDMAC descriptor namings
>        mmc: dw_mmc: Add support for 64-bit IDMAC
>        mmc: dw_mmc: Replace fifoth_val property with fifo-depth
>        mmc: dw_mmc: Fix kernel-doc comments in dwmmc.h
>        mmc: dw_mmc: Improve coding style
>        arm: dts: exynos: Add upstream DW MMC properties to all Exynos dts
>        dt-bindings: exynos: Update bindings doc for DW MMC controller
>        arm: exynos: Add header guard for dwmmc.h
>        mmc: exynos_dw_mmc: Fix obtaining the base address of controller
>        mmc: exynos_dw_mmc: Fix getting private data in exynos_dwmci_board_init()
>        mmc: exynos_dw_mmc: Don't call pinmux functions on ARM64 chips
>        mmc: exynos_dw_mmc: Obtain and use CIU clock via CCF API
>        mmc: exynos_dw_mmc: Use .of_to_plat for device tree parsing
>        mmc: exynos_dw_mmc: Convert to use livetree API
>        mmc: exynos_dw_mmc: Read upstream SDR timing properties
>        mmc: exynos_dw_mmc: Abstract CLKSEL register
>        mmc: exynos_dw_mmc: Refactor fixed CIU clock divider
>        mmc: exynos_dw_mmc: Read common bus-width property
>        mmc: exynos_dw_mmc: Read common clock-frequency property
>        mmc: exynos_dw_mmc: Move quirks from struct dwmci_host to chip data
>        mmc: exynos_dw_mmc: Read and use DDR timing when available
>        mmc: exynos_dw_mmc: Set requested freq in get_mmc_clk() callback
>        mmc: exynos_dw_mmc: Add support for ARM64 Exynos chips
>        mmc: exynos_dw_mmc: Pull all init code into probe function
>        mmc: exynos_dw_mmc: Don't call dwmci_setup_cfg() after add_dwmci()
>        mmc: exynos_dw_mmc: Use dev->name as driver's displayed name
>        mmc: exynos_dw_mmc: Improve coding style
>        arm: dts: exynos: Remove outdated DW MMC properties in all Exynos dts
>        configs: e850-96: Enable MMC
>        doc: samsung: Mention enabled eMMC in E850-96 board doc
> 
> Sean Anderson (4):
>        pinmux: generic: Use ENOENT instead of ENOSYS
>        sandbox: Fix pinmux warnings with non-test devicetrees
>        zynqmp: Disable secure access for boot devices
>        arm: zynqmp: Enable non-invasive CCI-400 PMU debug
> 
> Siddharth Vadapalli (1):
>        arm: dts: k3-am625-r5-sk: Enable DM services for main_pktdma
> 
> Simon Glass (173):
>        malloc: Support testing with realloc()
>        lib: Handle a special case with str_to_list()
>        alist: Add support for an allocated pointer list
>        sandbox: Use const in os_jump_to_file()
>        sandbox: Fix a comment in os_find_u_boot()
>        test: Move some SPL-loading test-code into sandbox common
>        fdt: Don't overwrite bloblist devicetree
>        sandbox: fdt: Avoid overwriting an existing fdt
>        sandbox: Return error code from read/write/seek
>        sandbox: Add ELF file to VPL u-boot.img
>        sandbox: Set up global_data earlier
>        upl: Add support for reading a upl handoff
>        upl: Add support for writing a upl handoff
>        upl: Add basic tests
>        upl: Add a command
>        upl: Add support for Universal Payload in SPL
>        spl: Set SPL_FIT_FOUND for full FIT also
>        spl: Plumb in the Universal Payload handoff
>        upl: Plumb in universal payload to the init process
>        sandbox_vpl: Enable Universal Payload
>        upl: Add initial documentation
>        sandbox: Add a flag to enable UPL
>        sandbox: Add an SPL loader for UPL
>        upl: Add an end-to-end test
>        i2c: Remove board_i2c_init()
>        i2c: Remove IC2_xxx enum
>        i2c: Remove CFG_I2C_MULTI_BUS
>        mips: malta: Drop CMD_DATE
>        armv8: ls2085a: Drop CMD_DATE
>        mx28 / mx51: Drop CMD_DATE
>        MPC837XERDB: ethernut5: work_92105: Drop CMD_DATE
>        rtc: Drop CFG_SYS_RTC_BUS_NUM
>        date: Drop the legacy I2C code
>        fsl: mxc: Drop legacy I2c
>        i2c: Drop reference to SYS_I2C_INIT_BOARD
>        octeon: Drop OCTEON_I2C_FDT dead code
>        i2c: Remove I2C_SET_BUS()
>        i2c: Remove I2C_GET_BUS()
>        i2c: Drop CFG_SYS_MAX_I2C_BUS
>        i2c: Drop i2c_get_bus_num_fdt() and i2c_reset_port_fdt()
>        i2c: Remove CFG_SYS_I2C_MAX_HOPS
>        i2c: Remove CFG_SYS_I2C_DIRECT_BUS
>        mmc: Use logging instead of printf()
>        mmc: Use logging instead of pr_err()
>        rockchip: Move the default timer init to a common file
>        log: Avoid including function names by default
>        spl: Correct use of CMD_BOOTI and CMD_BOOTZ
>        spl: mmc: Drop checks for CONFIG_SPL_LIBCOMMON_SUPPORT
>        spl: mmc: Try to clean up raw-mode options
>        spl: Remove some #ifdefs in spl_parse_image_header()
>        spl: mmc: Handle error codes consistently
>        spl: Use unified inline functions for spl_load_info
>        spl: Remove remaining #ifdef in spl_parse_image_header()
>        spl: mmc: Adjust args of spl_mmc_find_device()
>        spl: Create a function to init spl_load_info
>        blk: Correct comment for blk_get_devnum_by_uclass_idname()
>        global_data: Move pci_clk to m68k and powerpc
>        x86: Drop use of global_data fb_base
>        video: Add a function to obtain the framebuffer address
>        video: mxc: Avoid setting global_data fb_base
>        global_data: Convert have_console into a flag
>        global_data: Remove pci_ram_top
>        global_data: Drop global_data hose
>        global_data: Drop pci_bootdelay
>        global_data: Use less space for environment fields
>        board_f: Add a new struct to hold pre-relocation info
>        board_f: Move fdt_size to board
>        board_f: Move new_bootstage to boardf
>        video: mxs: Avoid setting global_data fb_base
>        board_f: Move new_bloblist to boardf
>        arm: friendlyarm: Avoid accessing global_data fb_base
>        global_data: Drop spl_handoff
>        arm: ronetix: Avoid accessing global_data fb_base
>        global_data: Collect common fields at the top
>        zynqmp: Avoid setting the framebuffer address
>        global_data: Reduce the size of bus_clk and mem_clk
>        video: Avoid setting global_data fb_base from SPL handoff
>        global_data: Reduce the size of mon_len
>        video: Avoid setting global_data fb_base in video setup
>        global_data: log: Reorder and shrink fields
>        global_data: Drop fb_base
>        global_data: Reduce size of early-malloc vars
>        global_data: Move baud_rate field lower
>        global_data: Move env_addr field higher
>        global_data: Put phys_addr fields near the top
>        global_data: Move ulong fields together
>        global_data: Move pointer members together
>        global_data: Remove jump table in SPL
>        global_data: Remove environment members if not used
>        doc: Move generic-board documentation into rst
>        doc: Add some guidelines about global data
>        buildman: Make test_process_limit handle time.monotonic()
>        test: Fail when an empty line is expected but not present
>        test: Rename unit-test flags
>        test: Drop the blank line before test macros
>        test: Rename UTF_CONSOLE_REC to UTF_CONSOLE
>        mmc: Drop the blank line before accesses
>        test: Update NAND test to avoid extra macros
>        test: bloblist: Use UTF_CONSOLE in tests
>        test: boot: Use UTF_CONSOLE in tests
>        test: fdt: Check internal-function return values
>        test: fdt: Move common code into the setup functions
>        test: hush: Use UTF_CONSOLE in tests
>        test: cmd: Use UTF_CONSOLE in tests
>        test: log: Use UTF_CONSOLE in tests
>        test: cmd: Drop unnecessary console_record_reset_enable()
>        test: Use UTF_CONSOLE in remaining tests
>        doc: Add a few notes about how to use console checking
>        test: dm: Use UTF_CONSOLE in tests
>        test: Tidy up checking for console end
>        Revert "bootdev: avoid infinite probe loop"
>        bootstd: Make bootdev_next_prio() continue after failure
>        buildman: Support building within a Python venv
>        efi_loader: Use puts() in cout so that console recording works
>        efi_loader: Put back copyright message
>        nvmxip: Drop the message on probe
>        nvmxip: Avoid probing on boot
>        test/py: Fix some pylint warnings in test_ut.py
>        scripts: Update pylint.base
>        bootstd: Create a function to reset USB
>        usb: Drop old non-DM code
>        log: Add a new log category for the console
>        usb: Add DEV_FLAGS_DM to stdio for USB keyboard
>        dm: usb: Deal with USB keyboard persisting across tests
>        test: mbr: Adjust test to use lower-case hex
>        test: mbr: Adjust test to drop 0x
>        sandbox: Change the range used for memory-mapping tags
>        sandbox: Update cpu to use logging
>        sandbox: Unmap old tags
>        sandbox: Add some debugging to pci_io
>        sandbox: Implement reference counting for address mapping
>        mmc: Use map_sysmem() with buffers in the mmc command
>        read: Tidy up use of map_sysmem() in the read command
>        cmd: Fix memory-mapping in cmp command
>        test: mbr: Unmap the buffers after use
>        test: mbr: Use a constant for the block size
>        test: mbr: Use RAM for the buffers
>        test: mbr: Drop a duplicate test
>        buildman: Retry the build for current source
>        buildman: Allow skipping the dtc build
>        binman: Fix up test coverage for mkeficapsule
>        binman: Correct the comment for fdtgrep
>        binman: Tidy up comments for Entry.GetEntryArgsOrProps()
>        binman: Tidy up comments and pylint warnings in fit
>        binman: Avoid setting the image_pos attribute directly
>        binman: Update fdt-list-dir to use the provided directory
>        binman: fit: Avoid assuming that a FIT member is a section
>        binman: fit: Set the image_pos attributes only once
>        binman: fit: Refine handling of devicetrees for OF_UPSTREAM
>        binman: Adjust naming for reading symbols
>        binman: Add minor improvements to symbol-writing
>        binman: Provide a way to set the symbol base address
>        binman: Unwind the end-at-4gb special-case a little
>        binman: Allow image_pos to be None when writing symbols
>        binman: Make a start on an iMX8 test
>        sandbox: Add missing header file
>        bootstd: Add stub for bootdev_setup_for_sibling_blk()
>        gzip: Correct function comment for gunzip()
>        fdtdec: Support separate BSS for all XPL builds
>        tiny-printf: Correct return values
>        tpl: Support numbered aliases in device tree
>        ram: Support driver model in VPL
>        serial: Support debug UART in TPL
>        armv8: Support not having separate BSS
>        arm: cache: Drop a stale comment
>        arm: Fix up a stale comment in sections.c
>        mmc: Support driver model in TPL
>        mmc: Add more debugging for SPL
>        mmc: Log the error when init fails
>        mmc: rockchip: Log some error returns
>        mmc: rockchip: Allow clocks to be missing
>        rockchip: mmc: Fix a missing colon and newline
>        rockchip: Provided SPL control over efuse presence
> 
> Stanley Chu (1):
>        pinctrl: npcm8xx: clear all gpio events
> 
> Sughosh Ganu (36):
>        list: use list_count_nodes() to count list entries
>        alist: add a helper to check if the list is full
>        lmb: remove the unused lmb_is_reserved() function
>        lmb: staticize __lmb_alloc_base()
>        lmb: use the BIT macro for lmb flags
>        lmb: make LMB memory map persistent and global
>        lmb: allow for resizing lmb regions
>        lmb: remove config symbols used for lmb region count
>        lmb: config: add lmb config symbols for SPL
>        lmb: allow lmb module to be used in SPL
>        lmb: introduce a function to add memory to the lmb memory map
>        lmb: reserve common areas during board init
>        lmb: remove the lmb_init_and_reserve() function
>        lmb: remove lmb_init_and_reserve_range() function
>        lmb: bootm: remove superfluous lmb stub functions
>        lmb: init: initialise the lmb data structures during board init
>        ppc: lmb: move arch specific lmb reservations to arch_misc_init()
>        lmb: do away with arch_lmb_reserve()
>        lmb: remove the unused board_lmb_reserve() function
>        sandbox: move the TCG event log to the start of ram memory
>        spl: call spl_board_init() at the end of the spl init sequence
>        spl: sandbox: initialise the ram banksize in spl
>        sandbox: spl: enable lmb config for SPL
>        sandbox: iommu: remove lmb allocation in the driver
>        zynq: lmb: do not add to lmb map before relocation
>        stm32mp: allow calling optee_get_reserved_memory() from U-Boot
>        stm32mp: compute ram_top based on the optee base address
>        lmb: add logic to print lmb flag strings
>        fwu: v2: try reading both copies of metadata
>        fwu: v1: do a version check for the metadata
>        fwu: check all images for transitioning out of Trial State
>        fwu: add dependency checks for selecting FWU metadata version
>        fwu: do not allow capsule processing on exceeding Trial Counter threshold
>        fwu: print a message if empty capsule checks fail
>        tftp: rework the logic to validate the load address
>        wget: rework the logic to validate the load address
> 
> Tim Harvey (4):
>        mmc: use an enumerated type to represent PARTITION_CONFIG fields
>        mmc: allow use of hardware partition names for mmc partconf
>        venice: show emmc boot hardware partition
>        configs: venice: enable DM_RNG
> 
> Tom Rini (58):
>        Merge patch series "omap configuration cleanups"
>        Merge patch series "alist: Implement a pointer list / array of structs"
>        Merge tag 'i2cupdates-for-v2024-10-next' of https://source.denx.de/u-boot/custodians/u-boot-i2c into next
>        Merge patch series "Universal Payload initial series"
>        Merge tag 'i2c-dm-updates-for-v2024-10-next' of https://source.denx.de/u-boot/custodians/u-boot-i2c into next
>        Merge patch series "clk: mediatek: mt7623: clk migration for OF_UPSTREAM"
>        Merge patch series "clk: mediatek: mt7981: clk migration for OF_UPSTREAM"
>        Merge patch series "clk: mediatek: mt7988: clk migration for OF_UPSTREAM"
>        Merge patch series "clk: mediatek: mt7986: clk migration for OF_UPSTREAM"
>        Merge patch series "clk: mediatek: mt7622: clk migration for OF_UPSTREAM"
>        Merge tag 'v2024.10-rc3' into next
>        Merge tag 'u-boot-dfu-next-20240820' of https://source.denx.de/u-boot/custodians/u-boot-dfu into next
>        Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-samsung into next
>        Merge tag 'u-boot-imx-next-20240823' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next
>        Merge patch series "spl: mmc: Some tweaks for SPL, particularly with MMC"
>        test/overlay: Make this depend on SANDBOX
>        test/boot: Make BOOTSTD tests depend on UT_BOOTSTD
>        test/cmd: Move wget test to under a sandbox guard
>        Merge patch series "test/overlay: Make this depend on SANDBOX"
>        Merge patch series "global_data: Reduce size of struct global_data"
>        Merge patch series "Tidy up console recording in tests"
>        Merge patch series "arch: arm: dts: ti: Add missing fss range"
>        Merge patch series "bootstd: Try again to resolve infinite-loop bug"
>        Merge patch series "dm: core: Avoid multiple calls to fdt_parent_offset()"
>        Merge patch series "Add support for Ethernet Boot on SK-AM62"
>        Merge tag 'v2024.10-rc4' into next
>        Merge tag 'u-boot-amlogic-next-20240902' of https://source.denx.de/u-boot/custodians/u-boot-amlogic into next
>        Merge tag 'u-boot-imx-next-20240902' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next
>        Merge patch series "net: dwc_eth_qos: Add glue driver for Intel MAC"
>        Merge patch series "Make LMB memory map global and persistent"
>        Merge patch series "provide names for emmc hardware partitions"
>        Merge branch 'qcom-next' of https://gitlab.denx.de/u-boot/custodians/u-boot-snapdragon into next
>        Merge branch 'next' of https://source.denx.de/u-boot/custodians/u-boot-usb into next
>        arm: Remove ethernut5 board
>        Merge patch series "phycore-am62/4: Add more boot sources"
>        Merge tag 'u-boot-imx-next-20240911' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next
>        Merge branch 'next' of https://source.denx.de/u-boot/custodians/u-boot-riscv into next
>        Merge tag 'efi-next-20241024' of https://source.denx.de/u-boot/custodians/u-boot-efi into next
>        Merge patch series "Bump new hush commits and fix old hush test behavior"
>        Merge tag 'v2024.10-rc5' into next
>        Merge patch series "Arm: npcm: modify npcm8xx boot setting"
>        Merge patch series "Fix various bugs"
>        Merge tag 'fwu-next-19092024' of https://source.denx.de/u-boot/custodians/u-boot-tpm into next
>        Merge tag 'u-boot-imx-next-20240919' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next
>        Merge patch series "lmb: rework logic to validate load address for network commands"
>        Merge tag 'xilinx-for-v2025.01-rc1' of https://source.denx.de/u-boot/custodians/u-boot-microblaze into next
>        test/py/tests/test_bootstage.py: Combine stash/unstash tests
>        Merge patch series "Miscellaneous fixes"
>        Merge tag 'u-boot-imx-next-20240925' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next
>        Merge tag 'dm-next-26sep24' of https://source.denx.de/u-boot/custodians/u-boot-dm into next
>        Merge tag 'v2024.10-rc6' into next
>        Merge patch series "env: mmc: fix use of two separate partitions with proper type GUID"
>        Squashed 'dts/upstream/' changes from 20e0f0897ea2..3347eecf3408
>        Subtree merge tag 'v6.11-dts' of dts repo [1] into dts/upstream
>        Merge patch series "Add Android 14 bootflow support for AM62X and AM62P board"
>        Merge patch series "arm: Initial support for Analog Devices SC5xx boards"
>        Merge patch series "vbe: Series part D"
>        Merge tag 'u-boot-dfu-next-20241003' of https://source.denx.de/u-boot/custodians/u-boot-dfu into next
> 
> Tomas Paukrt (3):
>        lib: crypto: fix ASYMMETRIC_KEY_TYPE dependency
>        gpio: mxc_gpio: fix reading state of GPIO pins in output mode
>        cmd: mmc: Allow using partition name in mmc erase command
> 
> Vaishnav Achath (1):
>        board: ti: j722s: Update Resource Management configs
> 
> Venkatesh Yadav Abbarapu (2):
>        mmc: Change the frequency to MMC_HS_52 when selecting hs400
>        mtd: spi-nor: scale up timeout for full-chip erase
> 
> Vignesh Raghavendra (2):
>        mtd: nand: raw: omap_gpmc: Check return value of gpmc_nand_init
>        soc: ti: k3-navss-ringacc: Fix reset ring API
> 
> Vitaliy Vasylskyy (1):
>        usb: gadget: usbhs: Add Renesas USBHS device driver
> 
> Wadim Egorov (1):
>        configs: phycore_am64x_a53_defconfig: Enable CONFIG_OF_BOARD_SETUP
> 
> Yashwanth Varakala (2):
>        board: phytec: phycore_imx8mp: Add mcore support
>        configs: phycore-imx8mp_defconfig: Enabled bootaux command
> 
> Yasuharu Shibata (2):
>        sandbox: Enable wget command
>        sandbox: fix wget test failure after fixing wget issue
> 
> Ye Li (8):
>        imx9: soc: Configure TRDC for M33 TCM access
>        imx9: soc: Print UID in big endian format for EL2GO
>        imx9: soc: Change second Ethernet MAC fuse layout
>        imx9: soc: Add function to get target voltage mode
>        imx9: clock: Update clock init function and sequence
>        imx9: Add 233Mhz DDR PLL frequency
>        imx93: Add Low performance parts 9302/9301 support
>        net: fec_mxc: Skip recv packet process when fec is halted
> 
> Zixun LI (10):
>        usb: gadget: atmel: Sort includes
>        usb: gadget: atmel: Replace printf() and pr_err() by log_err()
>        usb: gadget: atmel: Fix typo in usb gadget driver register and unregister
>        usb: gadget: atmel: Move usba_udc_pdata() with other static functions
>        usb: gadget: atmel: Rename atmel_usba_start()/_stop() to usba_udc_enable()/_disable()
>        usb: gadget: atmel: Add attach/detach support
>        usb: gadget: atmel: Add DM_USB_GADGET support
>        usb: gadget: udc: Fix duplicate uclass name
>        dm: core: Show device sequence instead in dm_dump_tree()
>        cmd: bind: Use device sequence instead for driver bind/unbind
> 
>   Kconfig                                            |   17 +-
>   MAINTAINERS                                        |   21 +
>   Makefile                                           |   16 +-
>   README                                             |   27 +-
>   arch/arc/lib/cache.c                               |   14 -
>   arch/arm/Kconfig                                   |   16 +-
>   arch/arm/cpu/arm926ejs/mxs/spl_boot.c              |    2 +-
>   arch/arm/cpu/armv8/cache_v8.c                      |   25 +
>   arch/arm/cpu/armv8/u-boot-spl.lds                  |   12 +
>   arch/arm/dts/Makefile                              |  101 +-
>   arch/arm/dts/at91sam9xe.dtsi                       |   60 -
>   arch/arm/dts/ethernut5.dts                         |   96 -
>   arch/arm/dts/exynos4210-origen.dts                 |    3 +-
>   arch/arm/dts/exynos4210-trats.dts                  |    6 +-
>   arch/arm/dts/exynos4210-universal_c210.dts         |    6 +-
>   arch/arm/dts/exynos4412-odroid.dts                 |   15 +-
>   arch/arm/dts/exynos4412-trats2.dts                 |   20 +-
>   arch/arm/dts/exynos5250-arndale.dts                |   10 +-
>   arch/arm/dts/exynos5250-smdk5250.dts               |   13 +-
>   arch/arm/dts/exynos5250-snow.dts                   |   13 +-
>   arch/arm/dts/exynos5250-spring.dts                 |    7 +-
>   arch/arm/dts/exynos5420-smdk5420.dts               |   13 +-
>   arch/arm/dts/exynos5422-odroidxu3.dts              |    4 +-
>   arch/arm/dts/exynos54xx.dtsi                       |   13 +-
>   arch/arm/dts/imx6q-lxr.dts                         |   87 +
>   arch/arm/dts/imx6q-phytec-pfla02.dtsi              |   17 +
>   arch/arm/dts/imx6qdl-mba6-u-boot.dtsi              |   16 +
>   arch/arm/dts/imx6qdl-phytec-pfla02.dtsi            |  467 ++
>   arch/arm/dts/imx6sl-evk.dts                        |  658 --
>   arch/arm/dts/imx6sl-pinfunc.h                      | 1073 ---
>   arch/arm/dts/imx6sl.dtsi                           | 1005 ---
>   arch/arm/dts/imx8mm-u-boot.dtsi                    |    1 +
>   arch/arm/dts/imx8mn-u-boot.dtsi                    |    1 +
>   arch/arm/dts/imx8mp-u-boot.dtsi                    |    1 +
>   arch/arm/dts/imx8mq-u-boot.dtsi                    |    1 +
>   arch/arm/dts/k3-am625-r5-sk.dts                    |    5 +
>   arch/arm/dts/k3-am69-r5-sk.dts                     |    6 +
>   arch/arm/dts/k3-j7200-r5-common-proc-board.dts     |    6 +
>   arch/arm/dts/k3-j721e-r5-common-proc-board.dts     |    6 +
>   arch/arm/dts/k3-j721e-r5-sk.dts                    |    6 +
>   arch/arm/dts/k3-j784s4-r5-evm.dts                  |    6 +
>   arch/arm/dts/keystone-clocks.dtsi                  |  411 --
>   arch/arm/dts/keystone-k2e-clocks.dtsi              |   74 -
>   arch/arm/dts/keystone-k2e-evm-u-boot.dtsi          |   14 +-
>   arch/arm/dts/keystone-k2e-evm.dts                  |  152 -
>   arch/arm/dts/keystone-k2e-netcp.dtsi               |  203 -
>   arch/arm/dts/keystone-k2e.dtsi                     |  144 -
>   arch/arm/dts/keystone-k2g-evm-u-boot.dtsi          |   20 +-
>   arch/arm/dts/keystone-k2g-evm.dts                  |  148 -
>   arch/arm/dts/keystone-k2g-generic-u-boot.dtsi      |   18 -
>   arch/arm/dts/keystone-k2g-generic.dts              |   27 -
>   arch/arm/dts/keystone-k2g-ice-u-boot.dtsi          |   15 +-
>   arch/arm/dts/keystone-k2g-ice.dts                  |  118 -
>   arch/arm/dts/keystone-k2g-netcp.dtsi               |  149 -
>   arch/arm/dts/keystone-k2g.dtsi                     |  258 -
>   arch/arm/dts/keystone-k2hk-clocks.dtsi             |  422 --
>   arch/arm/dts/keystone-k2hk-evm-u-boot.dtsi         |   26 +-
>   arch/arm/dts/keystone-k2hk-evm.dts                 |  180 -
>   arch/arm/dts/keystone-k2hk-netcp.dtsi              |  207 -
>   arch/arm/dts/keystone-k2hk.dtsi                    |  111 -
>   arch/arm/dts/keystone-k2l-clocks.dtsi              |  263 -
>   arch/arm/dts/keystone-k2l-evm-u-boot.dtsi          |   28 +-
>   arch/arm/dts/keystone-k2l-evm.dts                  |  129 -
>   arch/arm/dts/keystone-k2l-netcp.dtsi               |  187 -
>   arch/arm/dts/keystone-k2l.dtsi                     |  105 -
>   arch/arm/dts/keystone.dtsi                         |  330 -
>   arch/arm/dts/mt7981.dtsi                           |  124 +-
>   arch/arm/dts/mt7986.dtsi                           |   95 +-
>   arch/arm/dts/mt7988.dtsi                           |   93 +-
>   arch/arm/dts/nuvoton-npcm845-yosemite4-pincfg.dtsi |  168 +
>   arch/arm/dts/nuvoton-npcm845-yosemite4.dts         |  233 +
>   arch/arm/dts/omap3-evm-37xx.dts                    |  107 -
>   arch/arm/dts/omap3-evm-common.dtsi                 |  198 -
>   arch/arm/dts/omap3-evm-processor-common.dtsi       |  224 -
>   arch/arm/dts/omap3-evm.dts                         |   86 -
>   arch/arm/dts/omap3-panel-sharp-ls037v7dw01.dtsi    |   73 -
>   arch/arm/dts/omap3-sniper-u-boot.dtsi              |   16 +
>   arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi           |   28 +
>   arch/arm/dts/sc573-ezkit.dts                       |   13 +
>   arch/arm/dts/sc57x.dtsi                            |   21 +
>   arch/arm/dts/sc584-ezkit.dts                       |   13 +
>   arch/arm/dts/sc589-ezkit.dts                       |   13 +
>   arch/arm/dts/sc589-mini.dts                        |   13 +
>   arch/arm/dts/sc58x.dtsi                            |   23 +
>   arch/arm/dts/sc594-som-ezkit.dts                   |   13 +
>   arch/arm/dts/sc594-som-ezlite.dts                  |   13 +
>   arch/arm/dts/sc594-som.dtsi                        |   19 +
>   arch/arm/dts/sc598-som-ezkit.dts                   |   13 +
>   arch/arm/dts/sc598-som-ezlite.dts                  |   13 +
>   arch/arm/dts/sc598-som.dtsi                        |   31 +
>   arch/arm/dts/sc5xx.dtsi                            |   54 +
>   arch/arm/dts/versal-mini-emmc0.dts                 |    2 +-
>   arch/arm/dts/versal-mini-emmc1.dts                 |    2 +-
>   arch/arm/dts/versal-mini-ospi.dtsi                 |    2 +-
>   arch/arm/dts/versal-mini-qspi.dtsi                 |    2 +-
>   arch/arm/dts/zynq-cse-nand.dts                     |    2 +-
>   arch/arm/dts/zynq-cse-nor.dts                      |    2 +-
>   arch/arm/dts/zynq-cse-qspi.dtsi                    |    2 +-
>   arch/arm/dts/zynqmp-dlc21-revA.dts                 |    3 +-
>   arch/arm/dts/zynqmp-e-a2197-00-revA.dts            |    1 -
>   arch/arm/dts/zynqmp-g-a2197-00-revA.dts            |    3 +-
>   arch/arm/dts/zynqmp-m-a2197-01-revA.dts            |   16 +-
>   arch/arm/dts/zynqmp-m-a2197-02-revA.dts            |   16 +-
>   arch/arm/dts/zynqmp-m-a2197-03-revA.dts            |   16 +-
>   arch/arm/dts/zynqmp-mini-emmc0.dts                 |    4 +-
>   arch/arm/dts/zynqmp-mini-emmc1.dts                 |    4 +-
>   arch/arm/dts/zynqmp-mini-nand.dts                  |    2 +-
>   arch/arm/dts/zynqmp-mini-qspi.dts                  |   16 +-
>   .../dts/zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso  |    8 +-
>   .../dts/zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso  |    8 +-
>   .../dts/zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso  |    8 +-
>   .../dts/zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso  |    8 +-
>   .../dts/zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso  |    8 +-
>   arch/arm/dts/zynqmp-p-a2197-00-revA.dts            |   11 +-
>   arch/arm/dts/zynqmp-sc-revB.dts                    |    2 +-
>   arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso     |    8 +-
>   arch/arm/dts/zynqmp-sc-vpk180-revA.dtso            |    6 +
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dtso             |    1 -
>   arch/arm/dts/zynqmp-sck-kr-g-revB.dtso             |    1 -
>   arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts         |    1 -
>   arch/arm/dts/zynqmp-vpk120-revA.dts                |    1 -
>   arch/arm/dts/zynqmp-zcu106-rev1.0.dts              |    2 +-
>   arch/arm/dts/zynqmp-zcu111-revA.dts                |    2 +-
>   arch/arm/dts/zynqmp-zcu1275-revB.dts               |    1 +
>   arch/arm/dts/zynqmp-zcu208-revA.dts                |    4 +-
>   arch/arm/dts/zynqmp-zcu216-revA.dts                |    4 +-
>   arch/arm/dts/zynqmp-zcu670-revA.dts                |    2 +-
>   arch/arm/dts/zynqmp-zcu670-revB.dts                |    2 +-
>   arch/arm/include/asm/arch-am33xx/sys_proto.h       |    1 -
>   arch/arm/include/asm/arch-imx/cpu.h                |    2 +
>   arch/arm/include/asm/arch-imx9/clock.h             |    3 +-
>   arch/arm/include/asm/arch-imx9/imx-regs.h          |   10 +
>   arch/arm/include/asm/arch-imx9/sys_proto.h         |   11 +
>   arch/arm/include/asm/arch-rockchip/timer.h         |    3 +
>   arch/arm/include/asm/mach-imx/ele_api.h            |    2 +
>   arch/arm/include/asm/mach-imx/sys_proto.h          |    8 +-
>   arch/arm/include/asm/system.h                      |   10 +
>   arch/arm/lib/bdinfo.c                              |    2 +-
>   arch/arm/lib/cache.c                               |    2 -
>   arch/arm/lib/sections.c                            |    2 +-
>   arch/arm/lib/stack.c                               |   14 -
>   arch/arm/mach-apple/board.c                        |   17 +-
>   arch/arm/mach-at91/Kconfig                         |   24 -
>   arch/arm/mach-at91/arm926ejs/Makefile              |    2 -
>   arch/arm/mach-at91/arm926ejs/eflash.c              |  255 -
>   arch/arm/mach-at91/include/mach/at91_common.h      |    2 +-
>   arch/arm/mach-at91/include/mach/at91_dbu.h         |   37 -
>   arch/arm/mach-at91/include/mach/at91_eefc.h        |   47 -
>   arch/arm/mach-at91/include/mach/at91sam9260.h      |   12 +-
>   arch/arm/mach-at91/include/mach/hardware.h         |    3 +-
>   arch/arm/mach-at91/spl_at91.c                      |    2 +-
>   arch/arm/mach-at91/spl_atmel.c                     |    2 +-
>   arch/arm/mach-exynos/include/mach/dwmmc.h          |   40 +-
>   arch/arm/mach-exynos/spl_boot.c                    |    2 +-
>   arch/arm/mach-imx/Kconfig                          |    4 +
>   arch/arm/mach-imx/Makefile                         |    6 +
>   arch/arm/mach-imx/ele_ahab.c                       |   31 +
>   arch/arm/mach-imx/fdt.c                            |  129 +
>   arch/arm/mach-imx/image-container.c                |   10 +-
>   arch/arm/mach-imx/imx8m/clock_imx8mm.c             |   11 +-
>   arch/arm/mach-imx/imx8m/soc.c                      |  228 +-
>   arch/arm/mach-imx/imx9/Kconfig                     |    6 +-
>   arch/arm/mach-imx/imx9/clock.c                     |   40 +-
>   arch/arm/mach-imx/imx9/soc.c                       |  258 +-
>   arch/arm/mach-imx/imx9/trdc.c                      |  175 +-
>   arch/arm/mach-imx/mx6/Kconfig                      |   12 +
>   arch/arm/mach-imx/mx6/soc.c                        |    4 +
>   arch/arm/mach-imx/spl_imx_romapi.c                 |   27 +-
>   arch/arm/mach-k3/am62x/am625_init.c                |    9 +
>   arch/arm/mach-k3/common.c                          |    2 +-
>   arch/arm/mach-k3/r5/sysfw-loader.c                 |    2 +-
>   arch/arm/mach-octeontx/Kconfig                     |    1 -
>   arch/arm/mach-octeontx2/Kconfig                    |    1 -
>   arch/arm/mach-omap2/am33xx/board.c                 |    8 -
>   arch/arm/mach-omap2/boot-common.c                  |    5 +-
>   arch/arm/mach-omap2/omap3/emac.c                   |    1 +
>   arch/arm/mach-rockchip/Makefile                    |    4 +-
>   arch/arm/mach-rockchip/board.c                     |   10 +-
>   arch/arm/mach-rockchip/spl.c                       |   28 +-
>   arch/arm/mach-rockchip/spl_common.c                |   36 +
>   arch/arm/mach-rockchip/tpl.c                       |   30 +-
>   arch/arm/mach-sc5xx/Kconfig                        |  145 +-
>   arch/arm/mach-sc5xx/Makefile                       |    4 +
>   arch/arm/mach-sc5xx/sc57x-spl.c                    |   26 +
>   arch/arm/mach-sc5xx/sc58x-spl.c                    |   26 +
>   arch/arm/mach-sc5xx/sc59x-spl.c                    |   26 +
>   arch/arm/mach-sc5xx/sc59x_64-spl.c                 |   26 +
>   arch/arm/mach-sc5xx/sc59x_64.c                     |   25 +
>   arch/arm/mach-sc5xx/soc.c                          |   36 +
>   arch/arm/mach-snapdragon/board.c                   |  218 +-
>   arch/arm/mach-stm32mp/dram_init.c                  |   33 +-
>   arch/arm/mach-stm32mp/include/mach/stm32mp.h       |   11 +
>   arch/arm/mach-stm32mp/stm32mp1/cpu.c               |    7 +-
>   arch/arm/mach-stm32mp/stm32mp1/spl.c               |   17 +-
>   arch/arm/mach-sunxi/board.c                        |    2 +-
>   arch/arm/mach-sunxi/spl_spi_sunxi.c                |    3 +-
>   arch/arm/mach-tegra/board2.c                       |    7 -
>   arch/arm/mach-tegra/cboot.c                        |    4 -
>   arch/arm/mach-zynqmp/include/mach/hardware.h       |   11 +-
>   arch/arm/mach-zynqmp/zynqmp.c                      |   26 +
>   arch/m68k/cpu/mcf5445x/cpu.c                       |    2 +-
>   arch/m68k/include/asm/global_data.h                |    2 +
>   arch/m68k/lib/bdinfo.c                             |    2 +-
>   arch/m68k/lib/bootm.c                              |   20 +-
>   arch/microblaze/lib/bootm.c                        |   14 -
>   arch/mips/lib/bootm.c                              |   22 +-
>   arch/mips/mach-ath79/ar934x/clk.c                  |    4 +-
>   arch/mips/mach-octeon/Kconfig                      |    1 -
>   arch/mips/mach-octeon/cpu.c                        |    2 +-
>   arch/mips/mach-octeon/octeon_fdt.c                 |    7 -
>   arch/nios2/lib/bootm.c                             |   13 -
>   arch/powerpc/cpu/mpc83xx/pci.c                     |    4 +-
>   arch/powerpc/cpu/mpc83xx/speed.c                   |    2 +-
>   arch/powerpc/cpu/mpc85xx/cpu_init.c                |   16 -
>   arch/powerpc/cpu/mpc85xx/mp.c                      |    4 +-
>   arch/powerpc/include/asm/global_data.h             |    2 +
>   arch/powerpc/include/asm/mp.h                      |    4 +-
>   arch/powerpc/lib/Makefile                          |    1 +
>   arch/powerpc/lib/bootm.c                           |   55 +-
>   arch/powerpc/lib/misc.c                            |   62 +
>   arch/riscv/Kconfig                                 |   12 +-
>   arch/riscv/cpu/ast2700/Kconfig                     |    6 +
>   arch/riscv/cpu/ast2700/Makefile                    |    1 +
>   arch/riscv/cpu/ast2700/cpu.c                       |   23 +
>   arch/riscv/cpu/u-boot-spl.lds                      |    2 -
>   arch/riscv/dts/Makefile                            |    1 +
>   arch/riscv/dts/ast2700-ibex.dts                    |   22 +
>   arch/riscv/dts/ast2700-u-boot.dtsi                 |   40 +
>   arch/riscv/dts/ast2700.dtsi                        |   76 +
>   arch/riscv/dts/cv18xx.dtsi                         |   40 +-
>   arch/riscv/include/asm/arch-ast2700/fmc_hdr.h      |   52 +
>   arch/riscv/include/asm/arch-ast2700/scu.h          |  145 +
>   arch/riscv/include/asm/arch-ast2700/sdram.h        |  137 +
>   arch/riscv/include/asm/arch-ast2700/sli.h          |   82 +
>   arch/riscv/lib/bootm.c                             |   13 -
>   arch/sandbox/cpu/cpu.c                             |   40 +-
>   arch/sandbox/cpu/os.c                              |   30 +-
>   arch/sandbox/cpu/spl.c                             |  132 +-
>   arch/sandbox/cpu/start.c                           |   18 +-
>   arch/sandbox/cpu/state.c                           |    9 +-
>   arch/sandbox/dts/sandbox.dtsi                      |   14 +-
>   arch/sandbox/dts/test.dts                          |    2 +-
>   arch/sandbox/include/asm/sections.h                |    1 +
>   arch/sandbox/include/asm/spl.h                     |   15 +
>   arch/sandbox/include/asm/state.h                   |    4 +
>   arch/sandbox/include/asm/test.h                    |    4 +
>   arch/sandbox/lib/pci_io.c                          |    9 +-
>   arch/sh/lib/bootm.c                                |   13 -
>   arch/x86/cpu/i386/cpu.c                            |    8 -
>   arch/x86/cpu/intel_common/cpu_from_spl.c           |    4 +-
>   arch/x86/cpu/ivybridge/cpu.c                       |    5 -
>   arch/x86/cpu/mp_init.c                             |   10 +-
>   arch/x86/include/asm/cpu.h                         |    5 -
>   arch/x86/include/asm/io.h                          |    1 +
>   arch/x86/include/asm/posix_types.h                 |    3 +-
>   arch/x86/lib/bootm.c                               |   18 -
>   arch/x86/lib/fsp/fsp_graphics.c                    |    1 -
>   arch/x86/lib/fsp2/fsp_dram.c                       |    4 +-
>   arch/xtensa/Kconfig                                |    1 -
>   arch/xtensa/lib/bootm.c                            |   13 -
>   board/BuR/brppt1/board.c                           |    2 +-
>   board/BuR/brsmarc1/board.c                         |    2 +-
>   board/BuR/brxre1/board.c                           |    2 +-
>   board/Marvell/octeon_ebb7304/Kconfig               |    2 -
>   board/Marvell/octeon_nic23/Kconfig                 |    2 -
>   board/Marvell/octeontx/Kconfig                     |    2 -
>   board/Marvell/octeontx2/Kconfig                    |    2 -
>   board/Marvell/octeontx2_cn913x/board.c             |    5 -
>   board/adi/sc573-ezkit/Kconfig                      |  116 +
>   board/adi/sc573-ezkit/sc573-ezkit.env              |   13 +
>   board/adi/sc584-ezkit/Kconfig                      |  116 +
>   board/adi/sc584-ezkit/sc584-ezkit.env              |   13 +
>   board/adi/sc589-ezkit/Kconfig                      |  116 +
>   board/adi/sc589-ezkit/sc589-ezkit.env              |   13 +
>   board/adi/sc589-mini/Kconfig                       |  116 +
>   board/adi/sc589-mini/sc589-mini.env                |   13 +
>   board/adi/sc594-som-ezkit/Kconfig                  |  133 +
>   board/adi/sc594-som-ezkit/sc594-som-ezkit.env      |   13 +
>   board/adi/sc594-som-ezlite/Kconfig                 |  133 +
>   board/adi/sc594-som-ezlite/sc594-som-ezlite.env    |   13 +
>   board/adi/sc598-som-ezkit/Kconfig                  |  100 +
>   board/adi/sc598-som-ezkit/sc598-som-ezkit.env      |   13 +
>   board/adi/sc598-som-ezlite/Kconfig                 |  100 +
>   board/adi/sc598-som-ezlite/sc598-som-ezlite.env    |   13 +
>   .../advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c  |    4 +-
>   board/amlogic/odroid-go-ultra/odroid-go-ultra.c    |    2 -
>   board/aspeed/ibex_ast2700/Kconfig                  |   21 +
>   board/aspeed/ibex_ast2700/MAINTAINERS              |    7 +
>   board/aspeed/ibex_ast2700/Makefile                 |    3 +
>   board/aspeed/ibex_ast2700/fmc_hdr.c                |   64 +
>   board/aspeed/ibex_ast2700/ibex_ast2700.c           |   85 +
>   board/aspeed/ibex_ast2700/sli.c                    |   72 +
>   board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c    |    2 +-
>   board/atmel/at91sam9n12ek/at91sam9n12ek.c          |    2 +-
>   board/atmel/at91sam9x5ek/at91sam9x5ek.c            |    2 +-
>   board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c    |    2 +-
>   .../atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c  |    2 +-
>   board/atmel/sama5d2_icp/sama5d2_icp.c              |    2 +-
>   board/atmel/sama5d2_xplained/sama5d2_xplained.c    |    2 +-
>   board/atmel/sama5d3_xplained/sama5d3_xplained.c    |    2 +-
>   board/atmel/sama5d3xek/sama5d3xek.c                |    2 +-
>   board/atmel/sama5d4_xplained/sama5d4_xplained.c    |    2 +-
>   board/atmel/sama5d4ek/sama5d4ek.c                  |    2 +-
>   board/beagle/beagleplay/beagleplay.env             |   30 +
>   board/bosch/guardian/board.c                       |    2 +-
>   board/bosch/shc/board.c                            |   24 +-
>   board/cadence/xtfpga/Kconfig                       |    2 -
>   board/cavium/thunderx/Kconfig                      |    3 -
>   board/cobra5272/flash.c                            |   28 +-
>   board/compulab/cm_fx6/cm_fx6.c                     |    3 +-
>   board/compulab/cm_t43/cm_t43.c                     |    2 -
>   board/compulab/common/Makefile                     |    8 +-
>   board/compulab/common/eeprom.c                     |   14 +-
>   board/compulab/common/eeprom.h                     |    2 +-
>   board/comvetia/lxr2/Kconfig                        |   12 +
>   board/comvetia/lxr2/MAINTAINERS                    |    6 +
>   board/comvetia/lxr2/Makefile                       |    3 +
>   board/comvetia/lxr2/lxr2.c                         |  388 ++
>   board/comvetia/lxr2/lxr2.env                       |   34 +
>   board/conclusive/kstr-sama5d27/kstr-sama5d27.c     |    2 +-
>   board/data_modul/imx8mp_edm_sbc/spl.c              |    5 +-
>   board/dhelectronics/dh_imx6/dh_imx6.c              |    2 -
>   board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c  |    2 -
>   board/dhelectronics/dh_stm32mp1/board.c            |    2 -
>   board/eets/pdu001/board.c                          |    6 +-
>   board/egnite/ethernut5/Kconfig                     |   12 -
>   board/egnite/ethernut5/MAINTAINERS                 |    6 -
>   board/egnite/ethernut5/Makefile                    |   10 -
>   board/egnite/ethernut5/ethernut5.c                 |  198 -
>   board/egnite/ethernut5/ethernut5_pwrman.c          |  323 -
>   board/egnite/ethernut5/ethernut5_pwrman.h          |   51 -
>   board/engicam/stm32mp1/stm32mp1.c                  |    3 -
>   board/freescale/imx93_evk/Makefile                 |    6 +-
>   board/freescale/imx93_evk/lpddr4x_timing_1866mts.c | 1995 ++++++
>   board/freescale/imx93_evk/lpddr4x_timing_ld.c      | 1496 -----
>   board/freescale/imx93_evk/spl.c                    |   55 +-
>   board/freescale/imxrt1020-evk/Kconfig              |    3 -
>   board/freescale/imxrt1050-evk/Kconfig              |    3 -
>   board/freescale/imxrt1170-evk/Kconfig              |    3 -
>   board/freescale/ls2080ardb/eth_ls2080rdb.c         |    2 +-
>   board/freescale/m5253demo/flash.c                  |    6 +-
>   board/friendlyarm/nanopi2/board.c                  |    9 +-
>   board/gardena/smart-gateway-at91sam/spl.c          |    2 +-
>   board/gardena/smart-gateway-mt7688/board.c         |    2 +-
>   board/gateworks/venice/spl.c                       |   20 +-
>   board/gateworks/venice/venice.c                    |   22 +-
>   board/google/veyron/veyron.c                       |    4 -
>   board/grinn/chiliboard/board.c                     |    2 +-
>   board/kontron/sl-mx6ul/Kconfig                     |    2 -
>   board/kontron/sl-mx8mm/Kconfig                     |    2 -
>   board/kosagi/novena/novena.c                       |   10 +-
>   board/kosagi/novena/video.c                        |  140 +-
>   board/lg/sniper/sniper.c                           |   29 +-
>   board/nuvoton/arbel_evb/arbel_evb.c                |    8 +-
>   board/phytec/phycore_am62x/MAINTAINERS             |    1 +
>   board/phytec/phycore_am62x/phycore_am62x.env       |    8 +
>   board/phytec/phycore_am64x/phycore_am64x.env       |    8 +
>   board/phytec/phycore_imx8mp/phycore-imx8mp.c       |   34 +
>   board/phytec/phycore_imx8mp/phycore_imx8mp.env     |    9 +-
>   board/phytec/phycore_imx93/spl.c                   |    2 +-
>   board/purism/librem5/librem5.c                     |    4 +-
>   board/qualcomm/debug-sdm845.config                 |    5 +
>   board/qualcomm/debug-sm6115.config                 |    5 +
>   board/qualcomm/debug-sm8250.config                 |    5 +
>   board/ronetix/pm9263/pm9263.c                      |    6 +-
>   board/samsung/common/exynos5-dt.c                  |    4 -
>   board/sandbox/sandbox.c                            |   16 -
>   board/sielaff/imx6dl-sielaff/Kconfig               |    2 -
>   board/siemens/common/board_am335x.c                |    2 +-
>   board/siemens/corvus/board.c                       |    2 +-
>   board/siemens/smartweb/smartweb.c                  |    2 +-
>   board/siemens/taurus/taurus.c                      |    2 +-
>   board/socrates/socrates.c                          |    2 +-
>   board/softing/vining_2000/vining_2000.c            |   25 -
>   board/st/stih410-b2260/Kconfig                     |    3 -
>   board/st/stm32f429-discovery/Kconfig               |    3 -
>   board/st/stm32f429-evaluation/Kconfig              |    3 -
>   board/st/stm32f469-discovery/Kconfig               |    3 -
>   board/st/stm32f746-disco/Kconfig                   |    3 -
>   board/st/stm32h743-disco/Kconfig                   |    3 -
>   board/st/stm32h743-eval/Kconfig                    |    3 -
>   board/st/stm32h750-art-pi/Kconfig                  |    3 -
>   board/st/stm32mp1/stm32mp1.c                       |    2 -
>   board/storopack/smegw01/smegw01.c                  |    4 +-
>   board/sysam/amcore/Kconfig                         |    3 -
>   board/tcl/sl50/board.c                             |    2 +-
>   board/ti/am62px/am62px.env                         |    5 +
>   board/ti/am62x/MAINTAINERS                         |    2 +
>   board/ti/am62x/am62x.env                           |    5 +
>   board/ti/j722s/rm-cfg.yaml                         |   50 +-
>   board/ti/j722s/tifs-rm-cfg.yaml                    |   28 +-
>   board/toradex/apalis-imx8/apalis-imx8.c            |    8 +
>   board/tq/tqma6/tqma6.c                             |  126 -
>   board/tq/tqma6/tqma6_mba6.c                        |   35 -
>   board/vscom/baltos/board.c                         |    2 +-
>   board/xilinx/common/board.c                        |   72 +-
>   board/xilinx/versal-net/board.c                    |    5 +-
>   board/xilinx/zynqmp/zynqmp.c                       |    8 +
>   board/xilinx/zynqmp/zynqmp_kria.env                |   12 +-
>   boot/Kconfig                                       |   72 +
>   boot/Makefile                                      |    4 +
>   boot/bootdev-uclass.c                              |   23 +-
>   boot/bootm.c                                       |   40 +-
>   boot/bootm_os.c                                    |    5 +-
>   boot/bootmeth_android.c                            |   13 +-
>   boot/image-board.c                                 |   36 +-
>   boot/image-fdt.c                                   |   35 +-
>   boot/image-fit.c                                   |    3 +
>   boot/scene.c                                       |    8 +-
>   boot/upl_common.c                                  |   60 +
>   boot/upl_common.h                                  |   24 +
>   boot/upl_read.c                                    |  588 ++
>   boot/upl_write.c                                   |  622 ++
>   cmd/Kconfig                                        |   32 +-
>   cmd/Makefile                                       |    1 +
>   cmd/bdinfo.c                                       |    7 +-
>   cmd/bind.c                                         |   46 +-
>   cmd/booti.c                                        |    4 +-
>   cmd/bootz.c                                        |    2 +-
>   cmd/date.c                                         |   32 -
>   cmd/efi.c                                          |    2 +-
>   cmd/efi_common.c                                   |    2 +-
>   cmd/elf.c                                          |    2 +-
>   cmd/flash.c                                        |    2 +-
>   cmd/gpt.c                                          |    2 +-
>   cmd/i2c.c                                          |   23 -
>   cmd/led.c                                          |    2 +-
>   cmd/load.c                                         |    7 +-
>   cmd/mem.c                                          |   26 +-
>   cmd/mmc.c                                          |   71 +-
>   cmd/mvebu/bubt.c                                   |    4 +-
>   cmd/nvedit_efi.c                                   |    2 +-
>   cmd/read.c                                         |   10 +-
>   cmd/sb.c                                           |    6 +-
>   cmd/sf.c                                           |    8 +
>   cmd/upl.c                                          |  118 +
>   cmd/usb.c                                          |   20 -
>   cmd/x86/hob.c                                      |    2 +-
>   common/Kconfig                                     |    1 +
>   common/board_f.c                                   |   84 +-
>   common/board_r.c                                   |   14 +-
>   common/bootstage.c                                 |    8 +-
>   common/cli_hush_modern.c                           |    2 +-
>   common/cli_hush_upstream.c                         |  150 +-
>   common/console.c                                   |   55 +-
>   common/dlmalloc.c                                  |   23 +-
>   common/flash.c                                     |   46 +-
>   common/hwconfig.c                                  |    8 +-
>   common/init/handoff.c                              |   12 +
>   common/log.c                                       |    1 +
>   common/log_console.c                               |    4 +-
>   common/log_syslog.c                                |    2 +-
>   common/malloc_simple.c                             |    4 +-
>   common/spl/Kconfig                                 |   81 +-
>   common/spl/Makefile                                |    2 +
>   common/spl/spl.c                                   |   55 +-
>   common/spl/spl_blk_fs.c                            |    9 +-
>   common/spl/spl_ext.c                               |    3 +-
>   common/spl/spl_fat.c                               |   10 +-
>   common/spl/spl_fit.c                               |    9 +
>   common/spl/spl_mmc.c                               |  175 +-
>   common/spl/spl_nand.c                              |    4 +-
>   common/spl/spl_net.c                               |    3 +-
>   common/spl/spl_nor.c                               |    6 +-
>   common/spl/spl_ram.c                               |    3 +-
>   common/spl/spl_semihosting.c                       |    4 +-
>   common/spl/spl_spi.c                               |    4 +-
>   common/spl/spl_upl.c                               |  172 +
>   common/spl/spl_ymodem.c                            |    4 +-
>   common/usb_kbd.c                                   |   74 +-
>   configs/MPC837XERDB_defconfig                      |    1 -
>   configs/a3y17lte_defconfig                         |    1 -
>   configs/a5y17lte_defconfig                         |    1 -
>   configs/a7y17lte_defconfig                         |    1 -
>   configs/am335x_baltos_defconfig                    |    3 +-
>   configs/am335x_evm_defconfig                       |    2 -
>   configs/am335x_evm_spiboot_defconfig               |    2 -
>   configs/am335x_guardian_defconfig                  |    5 +-
>   configs/am335x_hs_evm_defconfig                    |    2 -
>   configs/am335x_hs_evm_uart_defconfig               |    2 -
>   configs/am335x_igep003x_defconfig                  |    4 +-
>   configs/am335x_pdu001_defconfig                    |    5 +-
>   configs/am335x_shc_defconfig                       |    7 +-
>   configs/am335x_shc_ict_defconfig                   |    7 +-
>   configs/am335x_shc_netboot_defconfig               |    7 +-
>   configs/am335x_shc_sdboot_defconfig                |    7 +-
>   configs/am335x_sl50_defconfig                      |    5 +-
>   configs/am3517_evm_defconfig                       |    8 +-
>   configs/am43xx_evm_defconfig                       |    2 -
>   configs/am43xx_evm_qspiboot_defconfig              |    2 -
>   configs/am43xx_evm_rtconly_defconfig               |    2 -
>   configs/am43xx_evm_usbhost_boot_defconfig          |    2 -
>   configs/am43xx_hs_evm_defconfig                    |    2 -
>   configs/am43xx_hs_evm_qspi_defconfig               |    2 -
>   configs/am57xx_evm_defconfig                       |    3 -
>   configs/am57xx_hs_evm_defconfig                    |    3 -
>   configs/am57xx_hs_evm_usb_defconfig                |    3 -
>   configs/am62ax_evm_a53_defconfig                   |    1 +
>   configs/am62ax_evm_r5_defconfig                    |    1 +
>   configs/am62px_evm_a53_defconfig                   |    1 +
>   configs/am62px_evm_r5_defconfig                    |    1 +
>   configs/am62x_a53_android.config                   |   21 +
>   configs/am62x_beagleplay_a53_defconfig             |    1 +
>   configs/am62x_beagleplay_r5_defconfig              |    1 +
>   configs/am62x_evm_a53_defconfig                    |    1 +
>   configs/am62x_evm_a53_ethboot_defconfig            |   17 +
>   configs/am62x_evm_r5_defconfig                     |    1 +
>   configs/am62x_evm_r5_ethboot_defconfig             |   25 +
>   configs/am64x_evm_a53_defconfig                    |    1 +
>   configs/am64x_evm_r5_defconfig                     |    1 +
>   configs/am65x_evm_a53_defconfig                    |    1 +
>   configs/am65x_evm_r5_defconfig                     |    1 +
>   configs/amd_versal2_virt_defconfig                 |    1 +
>   configs/apalis-imx8_defconfig                      |    1 +
>   configs/apple_m1_defconfig                         |    1 -
>   configs/arbel_evb_defconfig                        |    4 +-
>   configs/brppt1_mmc_defconfig                       |    3 +-
>   configs/brppt2_defconfig                           |    2 +-
>   configs/brsmarc1_defconfig                         |    5 +-
>   configs/brxre1_defconfig                           |    3 +-
>   configs/cgtqmx8_defconfig                          |    1 +
>   configs/chiliboard_defconfig                       |    5 +-
>   configs/chromebit_mickey_defconfig                 |    2 +-
>   configs/chromebook_jerry_defconfig                 |    2 +-
>   configs/chromebook_minnie_defconfig                |    2 +-
>   configs/chromebook_speedy_defconfig                |    2 +-
>   configs/ci20_mmc_defconfig                         |    1 +
>   configs/cm_fx6_defconfig                           |    2 +-
>   configs/cm_t43_defconfig                           |    5 +-
>   configs/colibri-imx8x_defconfig                    |    2 +
>   configs/da850evm_defconfig                         |    2 +-
>   configs/da850evm_nand_defconfig                    |    2 +-
>   configs/deneb_defconfig                            |    1 +
>   configs/devkit8000_defconfig                       |    6 -
>   configs/display5_defconfig                         |    2 +-
>   configs/display5_factory_defconfig                 |    2 +-
>   configs/dra7xx_evm_defconfig                       |    3 -
>   configs/dra7xx_hs_evm_defconfig                    |    3 -
>   configs/dra7xx_hs_evm_usb_defconfig                |    3 -
>   configs/draco-etamin_defconfig                     |    2 -
>   configs/draco-rastaban_defconfig                   |    4 +-
>   configs/draco-thuban_defconfig                     |    4 +-
>   configs/e850-96_defconfig                          |   10 +-
>   configs/ethernut5_defconfig                        |   88 -
>   configs/gardena-smart-gateway-at91sam_defconfig    |    2 +-
>   configs/giedi_defconfig                            |    1 +
>   configs/ibex-ast2700_defconfig                     |   94 +
>   configs/igep00x0_defconfig                         |    6 -
>   configs/imx28_xea_defconfig                        |    1 +
>   configs/imx28_xea_sb_defconfig                     |    1 +
>   configs/imx6q_logic_defconfig                      |    2 +-
>   configs/imx8mm-cl-iot-gate-optee_defconfig         |    1 +
>   configs/imx8mm-cl-iot-gate_defconfig               |    1 +
>   configs/imx8mm-icore-mx8mm-ctouch2_defconfig       |    1 +
>   configs/imx8mm-icore-mx8mm-edimm2.2_defconfig      |    1 +
>   configs/imx8mm-mx8menlo_defconfig                  |    1 +
>   configs/imx8mm-phygate-tauri-l_defconfig           |    1 +
>   configs/imx8mm_beacon_defconfig                    |    1 +
>   configs/imx8mm_beacon_fspi_defconfig               |    1 +
>   configs/imx8mm_data_modul_edm_sbc_defconfig        |    3 +
>   configs/imx8mm_evk_defconfig                       |    1 +
>   configs/imx8mm_evk_fspi_defconfig                  |    1 +
>   configs/imx8mm_phg_defconfig                       |    1 +
>   configs/imx8mm_venice_defconfig                    |    2 +-
>   configs/imx8mn_beacon_2g_defconfig                 |    1 +
>   configs/imx8mn_beacon_defconfig                    |    1 +
>   configs/imx8mn_beacon_fspi_defconfig               |    1 +
>   configs/imx8mn_bsh_smm_s2_defconfig                |    1 +
>   configs/imx8mn_bsh_smm_s2pro_defconfig             |    1 +
>   configs/imx8mn_ddr4_evk_defconfig                  |    1 +
>   configs/imx8mn_evk_defconfig                       |    1 +
>   configs/imx8mn_var_som_defconfig                   |    1 +
>   configs/imx8mn_venice_defconfig                    |    2 +-
>   configs/imx8mp-icore-mx8mp-edimm2.2_defconfig      |    1 +
>   configs/imx8mp_beacon_defconfig                    |    1 +
>   configs/imx8mp_data_modul_edm_sbc_defconfig        |    3 +
>   configs/imx8mp_debix_model_a_defconfig             |    1 +
>   configs/imx8mp_dhcom_pdk2_defconfig                |    1 +
>   configs/imx8mp_dhcom_pdk3_defconfig                |    1 +
>   configs/imx8mp_evk_defconfig                       |    1 +
>   configs/imx8mp_rsb3720a1_4G_defconfig              |    2 +
>   configs/imx8mp_rsb3720a1_6G_defconfig              |    1 +
>   configs/imx8mp_venice_defconfig                    |    2 +-
>   configs/imx8mq_cm_defconfig                        |    1 +
>   configs/imx8mq_evk_defconfig                       |    1 +
>   configs/imx8mq_phanbell_defconfig                  |    1 +
>   configs/imx8mq_reform2_defconfig                   |    1 +
>   configs/imx8qm_mek_defconfig                       |    1 +
>   configs/imx8qxp_mek_defconfig                      |    1 +
>   configs/imx8ulp_evk_defconfig                      |    1 +
>   configs/imx93-phyboard-segin_defconfig             |    1 +
>   configs/imx93_11x11_evk_defconfig                  |    1 +
>   configs/imx93_11x11_evk_ld_defconfig               |  126 -
>   configs/imx93_var_som_defconfig                    |    1 +
>   configs/imxrt1020-evk_defconfig                    |    1 +
>   configs/imxrt1050-evk_defconfig                    |    1 +
>   configs/imxrt1050-evk_fspi_defconfig               |    1 +
>   configs/imxrt1170-evk_defconfig                    |    1 +
>   configs/iot2050_defconfig                          |    1 +
>   configs/j7200_evm_a72_defconfig                    |    1 +
>   configs/j7200_evm_r5_defconfig                     |    1 +
>   configs/j721e_beagleboneai64_a72_defconfig         |    1 +
>   configs/j721e_beagleboneai64_r5_defconfig          |    1 +
>   configs/j721e_evm_a72_defconfig                    |    1 +
>   configs/j721e_evm_r5_defconfig                     |    1 +
>   configs/j721s2_evm_a72_defconfig                   |    1 +
>   configs/j721s2_evm_r5_defconfig                    |    1 +
>   configs/j722s_evm_a53_defconfig                    |    1 +
>   configs/j722s_evm_r5_defconfig                     |    1 +
>   configs/j784s4_evm_a72_defconfig                   |    1 +
>   configs/j784s4_evm_r5_defconfig                    |    1 +
>   configs/k2e_evm_defconfig                          |    3 +-
>   configs/k2e_hs_evm_defconfig                       |    3 +-
>   configs/k2g_evm_defconfig                          |    5 +-
>   configs/k2g_hs_evm_defconfig                       |    5 +-
>   configs/k2hk_evm_defconfig                         |    3 +-
>   configs/k2hk_hs_evm_defconfig                      |    3 +-
>   configs/k2l_evm_defconfig                          |    3 +-
>   configs/k2l_hs_evm_defconfig                       |    3 +-
>   configs/kontron-sl-mx8mm_defconfig                 |    1 +
>   configs/kontron_pitx_imx8m_defconfig               |    1 +
>   configs/kontron_sl28_defconfig                     |    1 +
>   configs/librem5_defconfig                          |    1 +
>   configs/ls1021aiot_sdcard_defconfig                |    1 +
>   configs/ls1021aqds_nand_defconfig                  |    1 +
>   configs/ls1021aqds_sdcard_ifc_defconfig            |    1 +
>   configs/ls1021aqds_sdcard_qspi_defconfig           |    1 +
>   configs/ls1021atsn_sdcard_defconfig                |    1 +
>   .../ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig    |    1 +
>   configs/ls1021atwr_sdcard_ifc_defconfig            |    1 +
>   configs/ls1021atwr_sdcard_qspi_defconfig           |    1 +
>   configs/ls2080aqds_nand_defconfig                  |    1 -
>   configs/ls2080aqds_qspi_defconfig                  |    1 -
>   configs/ls2080ardb_nand_defconfig                  |    1 -
>   configs/lxr2_defconfig                             |  118 +
>   configs/malta64_defconfig                          |    1 -
>   configs/malta64el_defconfig                        |    1 -
>   configs/malta_defconfig                            |    1 -
>   configs/maltael_defconfig                          |    1 -
>   configs/milkv_duo_defconfig                        |    3 +-
>   configs/msc_sm2s_imx8mp_defconfig                  |    1 +
>   configs/mt7981_emmc_rfb_defconfig                  |    1 -
>   configs/mt7981_rfb_defconfig                       |    1 -
>   configs/mt7981_sd_rfb_defconfig                    |    1 -
>   configs/mt7986_rfb_defconfig                       |    1 -
>   configs/mt7986a_bpir3_emmc_defconfig               |    1 -
>   configs/mt7986a_bpir3_sd_defconfig                 |    1 -
>   configs/mt7988_rfb_defconfig                       |    1 -
>   configs/mt7988_sd_rfb_defconfig                    |    1 -
>   configs/mx28evk_defconfig                          |    1 -
>   configs/mx51evk_defconfig                          |    1 -
>   configs/mx6slevk_defconfig                         |    7 +-
>   configs/mx6slevk_spinor_defconfig                  |   71 -
>   configs/mx6slevk_spl_defconfig                     |   88 -
>   configs/novena_defconfig                           |    2 +-
>   configs/omap35_logic_defconfig                     |    8 +-
>   configs/omap35_logic_somlv_defconfig               |    8 +-
>   configs/omap3_evm_defconfig                        |   11 +-
>   configs/omap3_logic_defconfig                      |    8 +-
>   configs/omap3_logic_somlv_defconfig                |    8 +-
>   configs/pcm051_rev3_defconfig                      |    2 -
>   configs/phycore-am335x-r2-regor_defconfig          |    2 -
>   configs/phycore-am335x-r2-wega_defconfig           |    2 -
>   configs/phycore-imx8mm_defconfig                   |    1 +
>   configs/phycore-imx8mp_defconfig                   |   26 +
>   configs/phycore_am62x_a53_defconfig                |    9 +-
>   configs/phycore_am62x_r5_defconfig                 |    1 +
>   configs/phycore_am62x_r5_usbdfu_defconfig          |    9 +
>   configs/phycore_am64x_a53_defconfig                |    4 +-
>   configs/phycore_am64x_r5_defconfig                 |    1 +
>   configs/pico-imx8mq_defconfig                      |    1 +
>   configs/pxm2_defconfig                             |    2 -
>   configs/qcm6490_defconfig                          |   21 +
>   configs/qcom_defconfig                             |    5 +-
>   configs/rut_defconfig                              |    4 +-
>   configs/sama5d27_wlsom1_ek_mmc_defconfig           |    2 +-
>   configs/sama5d27_wlsom1_ek_qspiflash_defconfig     |    2 +-
>   configs/sama5d2_icp_mmc_defconfig                  |    2 +-
>   configs/sandbox_defconfig                          |    2 +
>   configs/sandbox_noinst_defconfig                   |    3 +
>   configs/sandbox_spl_defconfig                      |    3 +-
>   configs/sandbox_vpl_defconfig                      |    4 +
>   configs/sniper_defconfig                           |   36 +-
>   configs/socfpga_secu1_defconfig                    |    2 +-
>   configs/stm32mp13_defconfig                        |    3 -
>   configs/stm32mp15_basic_defconfig                  |    3 -
>   configs/stm32mp15_defconfig                        |    3 -
>   configs/stm32mp15_trusted_defconfig                |    3 -
>   configs/stm32mp25_defconfig                        |    3 -
>   configs/th1520_lpi4a_defconfig                     |    1 -
>   configs/verdin-am62_a53_defconfig                  |    1 +
>   configs/verdin-am62_r5_defconfig                   |    1 +
>   configs/verdin-imx8mm_defconfig                    |    2 +
>   configs/verdin-imx8mp_defconfig                    |    2 +
>   configs/vf610twr_defconfig                         |    2 +-
>   configs/vf610twr_nand_defconfig                    |    2 +-
>   configs/vining_2000_defconfig                      |    2 +-
>   configs/work_92105_defconfig                       |    1 -
>   configs/xilinx_versal_net_virt_defconfig           |    1 +
>   configs/xilinx_versal_virt_defconfig               |    1 +
>   configs/xilinx_zynq_virt_defconfig                 |    2 +
>   configs/xilinx_zynqmp_kria_defconfig               |    1 +
>   configs/xilinx_zynqmp_virt_defconfig               |    1 +
>   disk/part_efi.c                                    |    2 +-
>   doc/I2C_Edge_Conditions                            |   10 +-
>   doc/arch/sandbox/sandbox.rst                       |   25 +-
>   doc/board/aspeed/ibex-ast2700.rst                  |   26 +
>   doc/board/aspeed/index.rst                         |    9 +
>   doc/board/atmel/at91ek.rst                         |    4 +-
>   doc/board/index.rst                                |    1 +
>   doc/board/qualcomm/index.rst                       |    1 +
>   doc/board/qualcomm/rb3gen2.rst                     |   53 +
>   doc/board/samsung/e850-96.rst                      |    5 +-
>   doc/board/ti/am62x_sk.rst                          |   14 +
>   doc/develop/commands.rst                           |    9 +-
>   doc/develop/global_data.rst                        |   25 +
>   .../historical/generic_board.rst}                  |   17 +-
>   doc/develop/historical/index.rst                   |   12 +
>   doc/develop/index.rst                              |    8 +
>   doc/develop/tests_writing.rst                      |   18 +-
>   doc/develop/uefi/uefi.rst                          |   27 +
>   doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml    |   46 +
>   .../clock/adi,sc5xx-clocks.yaml                    |  112 +
>   doc/device-tree-bindings/exynos/dwmmc.txt          |   46 +-
>   doc/device-tree-bindings/spi/soft-spi.txt          |    5 +-
>   .../timer/adi,sc5xx-gptimer.yaml                   |   42 +
>   doc/mkeficapsule.1                                 |   23 +
>   doc/usage/cmd/bind.rst                             |   12 +-
>   doc/usage/cmd/dm.rst                               |    7 +-
>   doc/usage/cmd/env.rst                              |    4 +-
>   doc/usage/cmd/mmc.rst                              |    6 +-
>   doc/usage/cmd/unbind.rst                           |   14 +-
>   doc/usage/cmd/upl.rst                              |  186 +
>   doc/usage/cmd/ut.rst                               |    2 +-
>   doc/usage/index.rst                                |    2 +
>   doc/usage/upl.rst                                  |   46 +
>   drivers/ata/dwc_ahsata.c                           |    7 +-
>   drivers/ata/sata.c                                 |   44 +-
>   drivers/block/Kconfig                              |    2 +-
>   drivers/block/sandbox.c                            |    4 +-
>   drivers/bootcount/Kconfig                          |    1 -
>   drivers/clk/Kconfig                                |    1 +
>   drivers/clk/Makefile                               |    1 +
>   drivers/clk/mediatek/clk-mt7622.c                  |  104 +-
>   drivers/clk/mediatek/clk-mt7623.c                  |  326 +-
>   drivers/clk/mediatek/clk-mt7981.c                  |  735 ++-
>   drivers/clk/mediatek/clk-mt7986.c                  |  660 +-
>   drivers/clk/mediatek/clk-mt7988.c                  | 1099 ++--
>   drivers/clk/mpc83xx_clk.c                          |    2 +-
>   drivers/clk/qcom/Kconfig                           |   17 +
>   drivers/clk/qcom/Makefile                          |    2 +
>   drivers/clk/qcom/clock-qcom.c                      |  119 +
>   drivers/clk/qcom/clock-qcom.h                      |    7 +
>   drivers/clk/qcom/clock-sc7280.c                    |  132 +
>   drivers/clk/qcom/clock-sdm845.c                    |   93 +
>   drivers/clk/qcom/clock-sm6115.c                    |   63 +
>   drivers/clk/qcom/clock-sm8150.c                    |  319 +
>   drivers/clk/qcom/clock-sm8250.c                    |  115 +
>   drivers/clk/rockchip/clk_rk3399.c                  |    3 +-
>   drivers/clk/sophgo/Kconfig                         |   14 +
>   drivers/clk/sophgo/Makefile                        |    6 +
>   drivers/clk/sophgo/clk-common.h                    |   74 +
>   drivers/clk/sophgo/clk-cv1800b.c                   |  754 +++
>   drivers/clk/sophgo/clk-cv1800b.h                   |  123 +
>   drivers/clk/sophgo/clk-ip.c                        |  594 ++
>   drivers/clk/sophgo/clk-ip.h                        |  288 +
>   drivers/clk/sophgo/clk-pll.c                       |  275 +
>   drivers/clk/sophgo/clk-pll.h                       |   74 +
>   drivers/core/Kconfig                               |    9 +
>   drivers/core/dump.c                                |    4 +-
>   drivers/core/fdtaddr.c                             |   24 +-
>   drivers/core/ofnode.c                              |    5 +-
>   drivers/core/regmap.c                              |   14 +-
>   drivers/cpu/imx8_cpu.c                             |    4 +
>   drivers/crypto/aspeed/Kconfig                      |   10 +
>   drivers/crypto/aspeed/Makefile                     |    1 +
>   drivers/crypto/aspeed/cptra_sha.c                  |  258 +
>   drivers/ddr/fsl/main.c                             |    3 +-
>   drivers/ddr/imx/phy/ddrphy_utils.c                 |    4 +
>   drivers/dfu/dfu.c                                  |   16 +
>   drivers/dfu/dfu_mmc.c                              |    3 +-
>   drivers/dma/ti/k3-udma.c                           |    6 +
>   drivers/firmware/arm-ffa/arm-ffa-uclass.c          |    2 +-
>   drivers/firmware/ti_sci.c                          |    8 +-
>   drivers/gpio/Kconfig                               |   16 +
>   drivers/gpio/Makefile                              |    2 +
>   drivers/gpio/gpio-aspeed-g7.c                      |  151 +
>   drivers/gpio/msm_gpio.c                            |  101 +-
>   drivers/gpio/mxc_gpio.c                            |   10 +-
>   drivers/gpio/npcm_sgpio.c                          |  291 +
>   drivers/gpio/qcom_pmic_gpio.c                      |   27 +-
>   drivers/i2c/i2c_core.c                             |  141 -
>   drivers/i2c/mxc_i2c.c                              |    1 +
>   drivers/i2c/soft_i2c.c                             |   11 -
>   drivers/iommu/apple_dart.c                         |    8 +-
>   drivers/iommu/qcom-hyp-smmu.c                      |    1 +
>   drivers/iommu/sandbox_iommu.c                      |   35 +-
>   drivers/misc/Makefile                              |    2 +-
>   drivers/misc/imx_ele/ele_api.c                     |   77 +
>   drivers/mmc/Kconfig                                |   11 +
>   drivers/mmc/Makefile                               |    1 +
>   drivers/mmc/ca_dw_mmc.c                            |    2 +-
>   drivers/mmc/dw_mmc.c                               |  563 +-
>   drivers/mmc/exynos_dw_mmc.c                        |  359 +-
>   drivers/mmc/ftsdc010_mci.h                         |    1 -
>   drivers/mmc/hi6220_dw_mmc.c                        |    7 +-
>   drivers/mmc/mmc.c                                  |  114 +-
>   drivers/mmc/msm_sdhci.c                            |   11 +
>   drivers/mmc/nexell_dw_mmc.c                        |    5 +-
>   drivers/mmc/rockchip_dw_mmc.c                      |   15 +-
>   drivers/mmc/rockchip_sdhci.c                       |   11 +-
>   drivers/mmc/s5p_sdhci.c                            |    2 +-
>   drivers/mmc/sdhci-cadence.c                        |   63 +-
>   drivers/mmc/sdhci-cadence.h                        |   69 +
>   drivers/mmc/sdhci-cadence6.c                       |  293 +
>   drivers/mmc/sdhci.c                                |   52 +-
>   drivers/mmc/snps_dw_mmc.c                          |   15 +-
>   drivers/mmc/socfpga_dw_mmc.c                       |    4 +-
>   drivers/mmc/zynq_sdhci.c                           |   39 +-
>   drivers/mtd/altera_qspi.c                          |    4 +-
>   drivers/mtd/cfi_flash.c                            |   36 +-
>   drivers/mtd/nand/raw/meson_nand.c                  |   84 +-
>   drivers/mtd/nand/raw/nand_base.c                   |    3 +
>   drivers/mtd/nand/raw/omap_gpmc.c                   |    5 +-
>   drivers/mtd/nvmxip/nvmxip-uclass.c                 |   10 +-
>   drivers/mtd/spi/spi-nor-core.c                     |   31 +-
>   drivers/mtd/ubi/fastmap.c                          |    8 +-
>   drivers/net/Kconfig                                |    8 +
>   drivers/net/Makefile                               |    1 +
>   drivers/net/aspeed_mdio.c                          |    1 +
>   drivers/net/dwc_eth_qos.c                          |   83 +-
>   drivers/net/dwc_eth_qos.h                          |    8 +-
>   drivers/net/dwc_eth_qos_imx.c                      |    6 +
>   drivers/net/dwc_eth_qos_intel.c                    |  449 ++
>   drivers/net/dwc_eth_qos_intel.h                    |   57 +
>   drivers/net/dwc_eth_qos_qcom.c                     |    6 +
>   drivers/net/dwc_eth_qos_rockchip.c                 |    6 +
>   drivers/net/dwc_eth_qos_starfive.c                 |    6 +
>   drivers/net/dwc_eth_qos_stm32.c                    |    6 +
>   drivers/net/fec_mxc.c                              |   13 +-
>   drivers/net/fm/eth.c                               |    6 +-
>   drivers/net/ftgmac100.c                            |   89 +-
>   drivers/net/ftgmac100.h                            |   17 +-
>   drivers/net/phy/Kconfig                            |    1 +
>   drivers/net/zynq_gem.c                             |    9 +-
>   drivers/pci/pcie_mediatek.c                        |  127 +-
>   drivers/phy/phy-rcar-gen3.c                        |   90 +-
>   drivers/phy/phy-uclass.c                           |   13 +-
>   drivers/phy/qcom/Kconfig                           |    6 +
>   drivers/phy/qcom/Makefile                          |    1 +
>   drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v2.h         |   25 +
>   drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v3.h         |   21 +
>   drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v4.h         |   31 +
>   drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v5.h         |   32 +
>   drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v6.h         |   38 +
>   drivers/phy/qcom/phy-qcom-qmp-pcs-v2.h             |   43 +
>   drivers/phy/qcom/phy-qcom-qmp-pcs-v3.h             |  145 +
>   drivers/phy/qcom/phy-qcom-qmp-pcs-v4.h             |  135 +
>   drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v3.h     |  111 +
>   drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v4.h     |  123 +
>   drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v6.h     |   89 +
>   drivers/phy/qcom/phy-qcom-qmp-qserdes-com.h        |  140 +
>   drivers/phy/qcom/phy-qcom-qmp-qserdes-pll.h        |   69 +
>   .../phy/qcom/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |   52 +
>   drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v3.h    |   68 +
>   drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v4.h    |  233 +
>   drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx.h       |  205 +
>   drivers/phy/qcom/phy-qcom-qmp-ufs.c                | 1116 ++++
>   drivers/phy/qcom/phy-qcom-qmp.h                    |  115 +
>   drivers/phy/sandbox-phy.c                          |   13 +
>   drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c          |   18 +
>   drivers/pinctrl/pinctrl-generic.c                  |   26 +-
>   drivers/pinctrl/pinctrl-sandbox.c                  |    4 +-
>   drivers/pinctrl/qcom/Kconfig                       |    8 +
>   drivers/pinctrl/qcom/Makefile                      |    1 +
>   drivers/pinctrl/qcom/pinctrl-sm8150.c              |  156 +
>   drivers/pinctrl/qcom/pinctrl-sm8250.c              |   42 +-
>   drivers/power/power_i2c.c                          |    5 -
>   drivers/power/regulator/Kconfig                    |   18 +
>   drivers/power/regulator/Makefile                   |    1 +
>   drivers/power/regulator/fixed.c                    |   21 +-
>   drivers/power/regulator/qcom-rpmh-regulator.c      |  136 +
>   drivers/power/regulator/regulator-uclass.c         |  121 +-
>   drivers/power/regulator/tps6287x_regulator.c       |  172 +
>   drivers/pwm/pwm-imx.c                              |    5 +-
>   drivers/ram/Kconfig                                |    9 +
>   drivers/ram/Makefile                               |    2 +-
>   drivers/ram/aspeed/Kconfig                         |   27 +-
>   drivers/ram/aspeed/Makefile                        |    1 +
>   .../dwc_ddrphy_phyinit_ddr4-3200-nodimm-train2D.c  | 2700 ++++++++
>   .../dwc_ddrphy_phyinit_ddr5-3200-nodimm-train2D.c  | 6930 ++++++++++++++++++++
>   drivers/ram/aspeed/sdram_ast2700.c                 | 1036 +++
>   drivers/remoteproc/rproc-uclass.c                  |   16 +-
>   drivers/rtc/rv3028.c                               |   32 +
>   drivers/serial/Kconfig                             |    7 +
>   drivers/soc/qcom/cmd-db.c                          |   11 +-
>   drivers/soc/qcom/rpmh-rsc.c                        |   43 +
>   drivers/soc/ti/k3-navss-ringacc-u-boot.c           |   11 +-
>   drivers/soc/ti/k3-navss-ringacc.c                  |   17 +-
>   drivers/spi/davinci_spi.c                          |    9 -
>   drivers/spi/soft_spi.c                             |   24 +-
>   drivers/timer/Kconfig                              |    6 +
>   drivers/timer/Makefile                             |    1 +
>   drivers/timer/ast_ibex_timer.c                     |   45 +
>   drivers/timer/npcm-timer.c                         |   82 +-
>   drivers/usb/Kconfig                                |    3 +-
>   drivers/usb/emul/sandbox_flash.c                   |    2 +-
>   drivers/usb/gadget/Kconfig                         |   11 +-
>   drivers/usb/gadget/Makefile                        |    1 +
>   drivers/usb/gadget/atmel_usba_udc.c                |  306 +-
>   drivers/usb/gadget/atmel_usba_udc.h                |    3 +
>   drivers/usb/gadget/f_sdp.c                         |    8 +-
>   drivers/usb/gadget/rcar/Makefile                   |    8 +
>   drivers/usb/gadget/rcar/common.c                   |  478 ++
>   drivers/usb/gadget/rcar/common.h                   |  328 +
>   drivers/usb/gadget/rcar/fifo.c                     | 1067 +++
>   drivers/usb/gadget/rcar/fifo.h                     |  114 +
>   drivers/usb/gadget/rcar/mod.c                      |  345 +
>   drivers/usb/gadget/rcar/mod.h                      |  161 +
>   drivers/usb/gadget/rcar/mod_gadget.c               | 1136 ++++
>   drivers/usb/gadget/rcar/pipe.c                     |  849 +++
>   drivers/usb/gadget/rcar/pipe.h                     |  114 +
>   drivers/usb/gadget/rcar/renesas_usb.h              |  125 +
>   drivers/usb/gadget/udc/udc-uclass.c                |    2 +-
>   drivers/usb/host/ehci-generic.c                    |    2 +-
>   drivers/usb/host/ehci-msm.c                        |    2 +-
>   drivers/usb/host/ehci-mx5.c                        |    4 +
>   drivers/usb/host/ehci-mx6.c                        |    2 +-
>   drivers/usb/host/ehci-pci.c                        |    2 +-
>   drivers/usb/host/ohci-generic.c                    |    2 +-
>   drivers/usb/host/ohci-lpc32xx.c                    |    4 -
>   drivers/video/imx/mxc_ipuv3_fb.c                   |    2 -
>   drivers/video/mxsfb.c                              |    1 -
>   drivers/video/video-uclass.c                       |   16 +-
>   drivers/video/zynqmp/zynqmp_dpsub.c                |    3 +-
>   dts/upstream/Bindings/arm/airoha.yaml              |    4 +
>   dts/upstream/Bindings/arm/amlogic.yaml             |   10 +
>   dts/upstream/Bindings/arm/amlogic/analog-top.txt   |   20 -
>   dts/upstream/Bindings/arm/amlogic/assist.txt       |   17 -
>   dts/upstream/Bindings/arm/amlogic/bootrom.txt      |   17 -
>   dts/upstream/Bindings/arm/amlogic/pmu.txt          |   18 -
>   .../Bindings/arm/arm,coresight-dummy-sink.yaml     |    2 +-
>   .../Bindings/arm/arm,coresight-dummy-source.yaml   |    2 +-
>   .../Bindings/arm/arm,juno-fpga-apb-regs.yaml       |   61 +
>   dts/upstream/Bindings/arm/atmel-sysregs.txt        |   29 -
>   dts/upstream/Bindings/arm/axis.txt                 |   16 -
>   dts/upstream/Bindings/arm/bcm/bcm2835.yaml         |    6 +
>   .../Bindings/arm/cpu-enable-method/al,alpine-smp   |   10 -
>   dts/upstream/Bindings/arm/cpus.yaml                |    6 +
>   .../Bindings/arm/freescale/fsl,imx7ulp-sim.yaml    |    4 +-
>   .../arm/freescale/fsl,vf610-mscm-cpucfg.txt        |   14 -
>   dts/upstream/Bindings/arm/fsl.yaml                 |   32 +-
>   dts/upstream/Bindings/arm/keystone/ti,sci.yaml     |    2 +-
>   .../Bindings/arm/marvell/armada-7k-8k.yaml         |   18 +
>   dts/upstream/Bindings/arm/marvell/marvell,dove.txt |   15 -
>   dts/upstream/Bindings/arm/mediatek.yaml            |   24 +
>   dts/upstream/Bindings/arm/pmu.yaml                 |    6 +
>   dts/upstream/Bindings/arm/qcom.yaml                |   27 +
>   dts/upstream/Bindings/arm/rockchip.yaml            |   42 +
>   dts/upstream/Bindings/arm/rtsm-dcscb.txt           |   19 -
>   dts/upstream/Bindings/arm/spear-misc.txt           |    9 -
>   dts/upstream/Bindings/arm/stm32/stm32.yaml         |    6 +
>   dts/upstream/Bindings/arm/sunxi.yaml               |   16 +-
>   dts/upstream/Bindings/arm/ti/k3.yaml               |    6 +
>   dts/upstream/Bindings/ata/ahci-fsl-qoriq.txt       |   21 -
>   dts/upstream/Bindings/ata/fsl,ahci.yaml            |   64 +
>   dts/upstream/Bindings/ata/rockchip,dwc-ahci.yaml   |    3 +
>   dts/upstream/Bindings/cache/qcom,llcc.yaml         |   57 +-
>   .../cache/starfive,jh8100-starlink-cache.yaml      |   66 +
>   dts/upstream/Bindings/clock/airoha,en7523-scu.yaml |   25 +-
>   .../clock/amlogic,a1-peripherals-clkc.yaml         |    9 +-
>   .../Bindings/clock/amlogic,a1-pll-clkc.yaml        |    9 +-
>   .../Bindings/clock/amlogic,axg-audio-clkc.txt      |   59 -
>   .../Bindings/clock/amlogic,axg-audio-clkc.yaml     |  201 +
>   .../clock/amlogic,c3-peripherals-clkc.yaml         |  120 +
>   .../Bindings/clock/amlogic,c3-pll-clkc.yaml        |   59 +
>   .../Bindings/clock/fsl,qoriq-clock-legacy.yaml     |   84 +
>   dts/upstream/Bindings/clock/fsl,qoriq-clock.yaml   |  207 +
>   dts/upstream/Bindings/clock/imx6q-clock.yaml       |    3 +-
>   dts/upstream/Bindings/clock/imx6sl-clock.yaml      |    3 +-
>   dts/upstream/Bindings/clock/imx6sll-clock.yaml     |    3 +-
>   dts/upstream/Bindings/clock/imx6sx-clock.yaml      |    3 +-
>   dts/upstream/Bindings/clock/imx6ul-clock.yaml      |    3 +-
>   dts/upstream/Bindings/clock/imx7d-clock.yaml       |    1 -
>   dts/upstream/Bindings/clock/imx8m-clock.yaml       |    3 +-
>   .../Bindings/clock/mediatek,mt7622-pciesys.yaml    |   10 +-
>   .../Bindings/clock/mediatek,mt8188-sys-clock.yaml  |    3 +
>   dts/upstream/Bindings/clock/milbeaut-clock.yaml    |   29 +-
>   .../Bindings/clock/qcom,dispcc-sc8280xp.yaml       |   20 +-
>   .../Bindings/clock/qcom,dispcc-sm6350.yaml         |   22 +-
>   .../Bindings/clock/qcom,dispcc-sm8x50.yaml         |   46 +-
>   dts/upstream/Bindings/clock/qcom,gcc-apq8064.yaml  |    3 +-
>   dts/upstream/Bindings/clock/qcom,gcc-apq8084.yaml  |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-ipq4019.yaml  |    3 +-
>   dts/upstream/Bindings/clock/qcom,gcc-ipq6018.yaml  |    3 +-
>   dts/upstream/Bindings/clock/qcom,gcc-ipq8064.yaml  |    3 +-
>   dts/upstream/Bindings/clock/qcom,gcc-ipq8074.yaml  |    1 +
>   .../{qcom,gcc-other.yaml => qcom,gcc-mdm9607.yaml} |    4 +-
>   dts/upstream/Bindings/clock/qcom,gcc-mdm9615.yaml  |   50 +
>   dts/upstream/Bindings/clock/qcom,gcc-msm8660.yaml  |    3 +-
>   dts/upstream/Bindings/clock/qcom,gcc-msm8909.yaml  |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-msm8916.yaml  |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-msm8953.yaml  |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-msm8974.yaml  |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-msm8976.yaml  |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-msm8994.yaml  |    3 +-
>   dts/upstream/Bindings/clock/qcom,gcc-msm8996.yaml  |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-msm8998.yaml  |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-qcm2290.yaml  |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-qcs404.yaml   |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-sc7180.yaml   |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-sc7280.yaml   |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-sc8180x.yaml  |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-sc8280xp.yaml |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-sdm660.yaml   |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-sdm845.yaml   |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-sdx55.yaml    |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-sdx65.yaml    |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-sm6115.yaml   |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-sm6125.yaml   |    3 +-
>   dts/upstream/Bindings/clock/qcom,gcc-sm6350.yaml   |    3 +-
>   dts/upstream/Bindings/clock/qcom,gcc-sm8150.yaml   |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-sm8250.yaml   |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-sm8350.yaml   |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc-sm8450.yaml   |    1 +
>   dts/upstream/Bindings/clock/qcom,gcc.yaml          |    1 -
>   dts/upstream/Bindings/clock/qcom,gpucc-sdm660.yaml |   20 +-
>   dts/upstream/Bindings/clock/qcom,gpucc.yaml        |   20 +-
>   dts/upstream/Bindings/clock/qcom,ipq5018-gcc.yaml  |    3 +-
>   dts/upstream/Bindings/clock/qcom,ipq5332-gcc.yaml  |    3 +-
>   dts/upstream/Bindings/clock/qcom,ipq9574-gcc.yaml  |    6 +-
>   .../Bindings/clock/qcom,msm8998-gpucc.yaml         |   20 +-
>   dts/upstream/Bindings/clock/qcom,qca8k-nsscc.yaml  |   86 +
>   .../Bindings/clock/qcom,qcm2290-dispcc.yaml        |   20 +-
>   .../Bindings/clock/qcom,qcm2290-gpucc.yaml         |   77 +
>   dts/upstream/Bindings/clock/qcom,qdu1000-gcc.yaml  |    1 +
>   dts/upstream/Bindings/clock/qcom,sa8775p-gcc.yaml  |    1 +
>   .../Bindings/clock/qcom,sc7180-dispcc.yaml         |   20 +-
>   .../Bindings/clock/qcom,sc7280-dispcc.yaml         |   20 +-
>   .../Bindings/clock/qcom,sdm845-dispcc.yaml         |   20 +-
>   dts/upstream/Bindings/clock/qcom,sdx75-gcc.yaml    |    1 +
>   dts/upstream/Bindings/clock/qcom,sm4450-gcc.yaml   |    1 +
>   .../Bindings/clock/qcom,sm6115-dispcc.yaml         |   20 +-
>   dts/upstream/Bindings/clock/qcom,sm6115-gpucc.yaml |    2 +-
>   dts/upstream/Bindings/clock/qcom,sm6125-gpucc.yaml |    2 +-
>   dts/upstream/Bindings/clock/qcom,sm6350-camcc.yaml |    2 +-
>   .../Bindings/clock/qcom,sm6375-dispcc.yaml         |    2 +-
>   dts/upstream/Bindings/clock/qcom,sm6375-gcc.yaml   |    3 +-
>   dts/upstream/Bindings/clock/qcom,sm6375-gpucc.yaml |    2 +-
>   dts/upstream/Bindings/clock/qcom,sm7150-camcc.yaml |   60 +
>   .../Bindings/clock/qcom,sm7150-dispcc.yaml         |   75 +
>   dts/upstream/Bindings/clock/qcom,sm7150-gcc.yaml   |    1 +
>   .../Bindings/clock/qcom,sm7150-videocc.yaml        |   58 +
>   .../Bindings/clock/qcom,sm8350-videocc.yaml        |    2 +-
>   dts/upstream/Bindings/clock/qcom,sm8450-camcc.yaml |    7 +-
>   .../Bindings/clock/qcom,sm8450-dispcc.yaml         |   20 +-
>   dts/upstream/Bindings/clock/qcom,sm8450-gpucc.yaml |   22 +-
>   .../Bindings/clock/qcom,sm8450-videocc.yaml        |   26 +-
>   .../Bindings/clock/qcom,sm8550-dispcc.yaml         |   20 +-
>   dts/upstream/Bindings/clock/qcom,sm8550-gcc.yaml   |    1 +
>   dts/upstream/Bindings/clock/qcom,sm8650-gcc.yaml   |    1 +
>   dts/upstream/Bindings/clock/qcom,videocc.yaml      |   36 +-
>   dts/upstream/Bindings/clock/qcom,x1e80100-gcc.yaml |    1 +
>   dts/upstream/Bindings/clock/qoriq-clock.txt        |  212 -
>   dts/upstream/Bindings/clock/renesas,rzg2l-cpg.yaml |    2 +-
>   .../Bindings/clock/sophgo,sg2042-clkgen.yaml       |   61 +
>   dts/upstream/Bindings/clock/sophgo,sg2042-pll.yaml |   53 +
>   .../Bindings/clock/sophgo,sg2042-rpgate.yaml       |   49 +
>   dts/upstream/Bindings/clock/sprd,sc9860-clk.txt    |   63 -
>   dts/upstream/Bindings/clock/sprd,sc9860-clk.yaml   |  159 +
>   dts/upstream/Bindings/clock/stericsson,abx500.txt  |   20 -
>   .../Bindings/clock/thead,th1520-clk-ap.yaml        |   53 +
>   dts/upstream/Bindings/clock/ti,sci-clk.yaml        |    2 +-
>   .../Bindings/clock/ti-keystone-pllctrl.txt         |   20 -
>   dts/upstream/Bindings/counter/ti-eqep.yaml         |   27 +-
>   .../Bindings/crypto/allwinner,sun8i-ce.yaml        |    2 +
>   .../Bindings/display/amlogic,meson-dw-hdmi.yaml    |    5 +
>   .../Bindings/display/bridge/synopsys,dw-hdmi.yaml  |   13 +
>   .../Bindings/display/bridge/toshiba,tc358767.yaml  |    2 +-
>   .../Bindings/display/imx/fsl,imx6-hdmi.yaml        |    8 -
>   .../Bindings/display/mediatek/mediatek,aal.yaml    |    1 +
>   .../Bindings/display/mediatek/mediatek,ccorr.yaml  |    3 +
>   .../Bindings/display/mediatek/mediatek,color.yaml  |    1 +
>   .../Bindings/display/mediatek/mediatek,dither.yaml |    1 +
>   .../Bindings/display/mediatek/mediatek,dpi.yaml    |    4 +
>   .../Bindings/display/mediatek/mediatek,dsi.yaml    |    1 +
>   .../Bindings/display/mediatek/mediatek,gamma.yaml  |    1 +
>   .../Bindings/display/mediatek/mediatek,ovl.yaml    |    1 +
>   .../Bindings/display/mediatek/mediatek,rdma.yaml   |    1 +
>   .../Bindings/display/msm/dsi-controller-main.yaml  |   19 +
>   .../Bindings/display/msm/dsi-phy-28nm.yaml         |    1 +
>   dts/upstream/Bindings/display/msm/gmu.yaml         |    4 +
>   dts/upstream/Bindings/display/msm/gpu.yaml         |   27 +-
>   dts/upstream/Bindings/display/msm/qcom,mdp5.yaml   |    1 +
>   dts/upstream/Bindings/display/msm/qcom,mdss.yaml   |    1 +
>   .../Bindings/display/msm/qcom,sm6375-mdss.yaml     |    2 +-
>   .../Bindings/display/msm/qcom,sm7150-dpu.yaml      |  143 +
>   .../Bindings/display/msm/qcom,sm7150-mdss.yaml     |  458 ++
>   .../display/panel/anbernic,rg35xx-plus-panel.yaml  |   67 +
>   .../display/panel/asus,z00t-tm5p5-nt35596.yaml     |    2 +-
>   .../Bindings/display/panel/boe,tv101wum-nl6.yaml   |    2 -
>   .../Bindings/display/panel/himax,hx83102.yaml      |   77 +
>   .../Bindings/display/panel/ilitek,ili9806e.yaml    |   63 +
>   .../Bindings/display/panel/jadard,jd9365da-h3.yaml |    1 +
>   .../Bindings/display/panel/lg,sw43408.yaml         |    4 +-
>   .../Bindings/display/panel/panel-edp-legacy.yaml   |  117 +
>   .../Bindings/display/panel/panel-mipi-dbi-spi.yaml |   30 +
>   .../Bindings/display/panel/panel-simple-dsi.yaml   |    2 +
>   .../panel/panel-simple-lvds-dual-ports.yaml        |    6 +
>   .../Bindings/display/panel/panel-simple.yaml       |   60 +-
>   .../Bindings/display/panel/raydium,rm69380.yaml    |    5 +-
>   .../Bindings/display/panel/samsung,atna33xc20.yaml |  104 +
>   .../Bindings/display/panel/sharp,ld-d5116z01b.yaml |   30 -
>   .../Bindings/display/panel/sony,td4353-jdi.yaml    |    2 +-
>   .../display/rockchip/rockchip,dw-hdmi.yaml         |    8 -
>   .../display/rockchip/rockchip,dw-mipi-dsi.yaml     |    2 +
>   .../Bindings/display/st,stm32mp25-lvds.yaml        |  119 +
>   dts/upstream/Bindings/dma/fsl,imx-dma.yaml         |   56 +
>   dts/upstream/Bindings/dma/fsl-imx-dma.txt          |   50 -
>   dts/upstream/Bindings/dma/fsl-qdma.txt             |   58 -
>   dts/upstream/Bindings/dma/fsl-qdma.yaml            |  132 +
>   dts/upstream/Bindings/dma/qcom,gpi.yaml            |    1 +
>   dts/upstream/Bindings/dma/sprd,sc9860-dma.yaml     |   92 +
>   dts/upstream/Bindings/dma/sprd-dma.txt             |   44 -
>   .../Bindings/dma/{ => stm32}/st,stm32-dma.yaml     |    4 +-
>   dts/upstream/Bindings/dma/stm32/st,stm32-dma3.yaml |  135 +
>   .../Bindings/dma/{ => stm32}/st,stm32-dmamux.yaml  |    4 +-
>   .../Bindings/dma/{ => stm32}/st,stm32-mdma.yaml    |    4 +-
>   dts/upstream/Bindings/eeprom/at24.yaml             |   18 +-
>   dts/upstream/Bindings/eeprom/at25.yaml             |    1 +
>   dts/upstream/Bindings/firmware/arm,scmi.yaml       |   16 +-
>   .../Bindings/firmware/cznic,turris-omnia-mcu.yaml  |   86 +
>   .../Bindings/firmware/nxp,imx95-scmi-pinctrl.yaml  |   53 +
>   dts/upstream/Bindings/firmware/qcom,scm.yaml       |   15 +
>   .../Bindings/fsi/aspeed,ast2600-fsi-master.yaml    |  121 +
>   dts/upstream/Bindings/fsi/fsi-controller.yaml      |   66 +
>   dts/upstream/Bindings/fsi/fsi-master-aspeed.txt    |   36 -
>   dts/upstream/Bindings/fsi/ibm,fsi2spi.yaml         |   36 +-
>   dts/upstream/Bindings/fsi/ibm,i2cr-fsi-master.yaml |    5 +-
>   .../Bindings/fsi/ibm,p9-fsi-controller.yaml        |   45 +
>   dts/upstream/Bindings/fsi/ibm,p9-occ.txt           |   16 -
>   dts/upstream/Bindings/fsi/ibm,p9-occ.yaml          |   40 +
>   dts/upstream/Bindings/fsi/ibm,p9-sbefifo.yaml      |   46 +
>   dts/upstream/Bindings/fsi/ibm,p9-scom.yaml         |   37 +
>   dts/upstream/Bindings/fuse/renesas,rcar-efuse.yaml |   55 +
>   dts/upstream/Bindings/fuse/renesas,rcar-otp.yaml   |   38 +
>   dts/upstream/Bindings/gpio/aspeed,sgpio.yaml       |   10 +
>   .../Bindings/gpio/atmel,at91rm9200-gpio.yaml       |   81 +
>   dts/upstream/Bindings/gpio/fsl,qoriq-gpio.yaml     |   87 +
>   dts/upstream/Bindings/gpio/fsl-imx-gpio.yaml       |    4 +-
>   dts/upstream/Bindings/gpio/gpio-mpc8xxx.txt        |   53 -
>   dts/upstream/Bindings/gpio/gpio-mxs.yaml           |    1 -
>   dts/upstream/Bindings/gpio/gpio-pca95xx.yaml       |    1 +
>   dts/upstream/Bindings/gpio/gpio-vf610.yaml         |    4 +
>   dts/upstream/Bindings/gpio/gpio-zevio.txt          |   16 -
>   dts/upstream/Bindings/gpio/gpio_atmel.txt          |   31 -
>   dts/upstream/Bindings/gpio/lsi,zevio-gpio.yaml     |   43 +
>   dts/upstream/Bindings/gpu/arm,mali-bifrost.yaml    |    5 +-
>   dts/upstream/Bindings/hwmon/g762.txt               |   47 -
>   dts/upstream/Bindings/hwmon/gmt,g762.yaml          |   95 +
>   dts/upstream/Bindings/hwmon/maxim,max6639.yaml     |   92 +
>   dts/upstream/Bindings/hwmon/ti,ina2xx.yaml         |    9 +
>   dts/upstream/Bindings/hwmon/ti,tmp108.yaml         |   12 +
>   dts/upstream/Bindings/i2c/amlogic,meson6-i2c.yaml  |    3 +
>   dts/upstream/Bindings/i2c/atmel,at91sam-i2c.yaml   |   10 +-
>   dts/upstream/Bindings/i2c/brcm,brcmstb-i2c.yaml    |   28 +-
>   dts/upstream/Bindings/i2c/i2c-demux-pinctrl.yaml   |  106 +-
>   dts/upstream/Bindings/i2c/i2c-fsi.txt              |   40 -
>   dts/upstream/Bindings/i2c/i2c-imx-lpi2c.yaml       |    4 +-
>   dts/upstream/Bindings/i2c/i2c-lpc2k.txt            |   33 -
>   dts/upstream/Bindings/i2c/i2c-mux-gpio.yaml        |    3 +
>   dts/upstream/Bindings/i2c/ibm,i2c-fsi.yaml         |   76 +
>   dts/upstream/Bindings/i2c/nvidia,tegra20-i2c.yaml  |    6 -
>   dts/upstream/Bindings/i2c/nxp,lpc1788-i2c.yaml     |   54 +
>   dts/upstream/Bindings/i2c/qcom,i2c-cci.yaml        |   20 +
>   dts/upstream/Bindings/i2c/renesas,iic-emev2.yaml   |   14 +-
>   dts/upstream/Bindings/i2c/renesas,rcar-i2c.yaml    |   20 +-
>   dts/upstream/Bindings/i2c/renesas,riic.yaml        |   34 +-
>   dts/upstream/Bindings/i2c/renesas,rmobile-iic.yaml |   24 +-
>   dts/upstream/Bindings/i2c/samsung,s3c2410-i2c.yaml |    6 -
>   dts/upstream/Bindings/i2c/snps,designware-i2c.yaml |    4 +
>   dts/upstream/Bindings/i2c/st,stm32-i2c.yaml        |   66 +-
>   dts/upstream/Bindings/i2c/ti,omap4-i2c.yaml        |   64 +-
>   dts/upstream/Bindings/i3c/i3c.yaml                 |    5 +-
>   dts/upstream/Bindings/i3c/snps,dw-i3c-master.yaml  |   11 +-
>   dts/upstream/Bindings/iio/adc/adc.yaml             |   30 +
>   dts/upstream/Bindings/iio/adc/adi,ad7173.yaml      |  194 +-
>   dts/upstream/Bindings/iio/adc/adi,ad7192.yaml      |   94 +
>   dts/upstream/Bindings/iio/adc/adi,ad7380.yaml      |  148 +
>   dts/upstream/Bindings/iio/adc/adi,ad7606.yaml      |    5 +-
>   .../Bindings/iio/adc/amlogic,meson-saradc.yaml     |    3 +
>   .../Bindings/iio/adc/mediatek,mt6359-auxadc.yaml   |   33 +
>   .../Bindings/iio/adc/st,stm32-dfsdm-adc.yaml       |    4 +
>   dts/upstream/Bindings/iio/adc/ti,ads1015.yaml      |    1 +
>   dts/upstream/Bindings/iio/adc/ti,ads1119.yaml      |  155 +
>   .../Bindings/iio/chemical/sciosense,ens160.yaml    |   70 +
>   dts/upstream/Bindings/iio/dac/adi,ad3552r.yaml     |   43 +-
>   .../Bindings/iio/frequency/adi,adf4350.yaml        |    6 +
>   dts/upstream/Bindings/iio/imu/adi,adis16475.yaml   |   31 +
>   dts/upstream/Bindings/iio/imu/adi,adis16480.yaml   |    6 +
>   dts/upstream/Bindings/iio/imu/bosch,bmi160.yaml    |    6 +-
>   .../Bindings/iio/light/vishay,veml6075.yaml        |    9 +-
>   .../Bindings/iio/magnetometer/fsl,mag3110.yaml     |    2 +-
>   dts/upstream/Bindings/iio/st,st-sensors.yaml       |    1 +
>   dts/upstream/Bindings/incomplete-devices.yaml      |  137 +
>   .../input/allwinner,sun4i-a10-lradc-keys.yaml      |    4 +-
>   dts/upstream/Bindings/input/cirrus,cs40l50.yaml    |   68 +
>   dts/upstream/Bindings/input/ti,nspire-keypad.txt   |   60 -
>   dts/upstream/Bindings/input/ti,nspire-keypad.yaml  |   74 +
>   .../Bindings/input/touchscreen/ads7846.txt         |    1 +
>   .../Bindings/input/touchscreen/edt-ft5x06.yaml     |    2 +
>   .../Bindings/input/touchscreen/eeti,exc3000.yaml   |   12 +-
>   .../Bindings/input/touchscreen/ektf2127.txt        |   25 -
>   .../Bindings/input/touchscreen/elan,ektf2127.yaml  |   58 +
>   .../Bindings/input/touchscreen/himax,hx83112b.yaml |    1 +
>   .../input/touchscreen/imagis,ist3038c.yaml         |    1 +
>   .../Bindings/interconnect/mediatek,mt8183-emi.yaml |   51 +
>   .../Bindings/interconnect/qcom,msm8953.yaml        |  101 +
>   .../Bindings/interconnect/qcom,msm8998-bwmon.yaml  |    3 +-
>   .../Bindings/interconnect/qcom,sc7280-rpmh.yaml    |   55 +-
>   .../Bindings/interconnect/qcom,sc8280xp-rpmh.yaml  |    2 +-
>   .../Bindings/interconnect/qcom,sm8450-rpmh.yaml    |    2 +-
>   .../interrupt-controller/fsl,irqsteer.yaml         |   23 +-
>   .../interrupt-controller/fsl,ls-extirq.yaml        |    1 -
>   .../Bindings/interrupt-controller/fsl,ls-msi.yaml  |   79 +
>   .../interrupt-controller/fsl,ls-scfg-msi.txt       |   30 -
>   .../marvell,armada-370-xp-mpic.txt                 |   38 -
>   .../interrupt-controller/marvell,mpic.yaml         |   63 +
>   .../microchip,lan966x-oic.yaml                     |   55 +
>   .../Bindings/interrupt-controller/qcom,pdc.yaml    |    1 +
>   .../interrupt-controller/realtek,rtl-intc.yaml     |   20 +-
>   .../interrupt-controller/renesas,rzg2l-irqc.yaml   |   17 +-
>   .../interrupt-controller/riscv,cpu-intc.txt        |   52 -
>   .../interrupt-controller/riscv,cpu-intc.yaml       |   73 +
>   .../Bindings/iommu/allwinner,sun50i-h6-iommu.yaml  |    7 +-
>   dts/upstream/Bindings/iommu/arm,smmu.yaml          |    6 +-
>   dts/upstream/Bindings/iommu/msm,iommu-v0.txt       |   64 -
>   .../Bindings/iommu/qcom,apq8064-iommu.yaml         |   78 +
>   dts/upstream/Bindings/iommu/qcom,iommu.yaml        |    3 +-
>   .../Bindings/leds/backlight/ti,lm3509.yaml         |  136 +
>   dts/upstream/Bindings/leds/leds-lp55xx.yaml        |   11 +
>   dts/upstream/Bindings/leds/silergy,sy7802.yaml     |  100 +
>   .../Bindings/mailbox/mediatek,gce-props.yaml       |   52 +
>   dts/upstream/Bindings/mailbox/qcom,cpucp-mbox.yaml |   49 +
>   .../Bindings/media/i2c/galaxycore,gc05a2.yaml      |  112 +
>   .../Bindings/media/i2c/galaxycore,gc08a3.yaml      |  112 +
>   .../Bindings/media/i2c/maxim,max96714.yaml         |  174 +
>   .../Bindings/media/i2c/maxim,max96717.yaml         |  157 +
>   .../media/i2c/{imx258.yaml => sony,imx258.yaml}    |   11 +-
>   dts/upstream/Bindings/media/i2c/sony,imx283.yaml   |  107 +
>   .../Bindings/media/img,e5010-jpeg-enc.yaml         |   75 +
>   .../Bindings/media/mediatek,mdp3-rdma.yaml         |    1 +
>   .../Bindings/media/mediatek,mt7622-cir.yaml        |   55 +
>   dts/upstream/Bindings/media/mtk-cir.txt            |   28 -
>   .../Bindings/media/qcom,msm8996-venus.yaml         |    4 +-
>   .../Bindings/media/raspberrypi,pispbe.yaml         |   63 +
>   dts/upstream/Bindings/media/rc.yaml                |    1 +
>   dts/upstream/Bindings/media/renesas,rzg2l-cru.yaml |   35 +-
>   .../Bindings/media/renesas,rzg2l-csi2.yaml         |    1 +
>   dts/upstream/Bindings/media/rockchip-rga.yaml      |    1 +
>   .../Bindings/memory-controllers/fsl/fsl,ifc.yaml   |    2 +-
>   .../Bindings/memory-controllers/fsl/mmdc.yaml      |    4 +-
>   dts/upstream/Bindings/mfd/marvell,88pm886-a1.yaml  |   76 +
>   .../Bindings/mfd/mediatek,mt8195-scpsys.yaml       |    2 +
>   dts/upstream/Bindings/mfd/mfd.txt                  |   15 +-
>   dts/upstream/Bindings/mfd/qcom,pm8008.yaml         |  162 +-
>   dts/upstream/Bindings/mfd/qcom,spmi-pmic.yaml      |    2 +
>   dts/upstream/Bindings/mfd/rockchip,rk809.yaml      |  288 -
>   dts/upstream/Bindings/mfd/rockchip,rk817.yaml      |   70 +-
>   dts/upstream/Bindings/mfd/rohm,bd96801-pmic.yaml   |  173 +
>   dts/upstream/Bindings/mfd/syscon-common.yaml       |   71 +
>   dts/upstream/Bindings/mfd/syscon.yaml              |  278 +-
>   dts/upstream/Bindings/mfd/ti,twl.yaml              |  167 +-
>   dts/upstream/Bindings/mips/brcm/soc.yaml           |   24 +
>   dts/upstream/Bindings/mips/mobileye.yaml           |    5 +
>   dts/upstream/Bindings/mips/mscc.txt                |   17 -
>   dts/upstream/Bindings/mips/realtek-rtl.yaml        |    4 +
>   dts/upstream/Bindings/misc/fsl,qoriq-mc.txt        |  196 -
>   dts/upstream/Bindings/misc/fsl,qoriq-mc.yaml       |  187 +
>   .../Bindings/misc/qemu,vcpu-stall-detector.yaml    |    6 +
>   .../Bindings/mmc/amlogic,meson-gx-mmc.yaml         |    3 +
>   dts/upstream/Bindings/mmc/brcm,sdhci-brcmstb.yaml  |    1 +
>   dts/upstream/Bindings/mmc/fsl,esdhc.yaml           |  105 +
>   dts/upstream/Bindings/mmc/fsl-esdhc.txt            |   52 -
>   dts/upstream/Bindings/mmc/mmc-spi-slot.yaml        |   16 +-
>   dts/upstream/Bindings/mmc/sdhci-msm.yaml           |    1 +
>   dts/upstream/Bindings/mmc/sdhci-sprd.txt           |   67 -
>   dts/upstream/Bindings/mmc/sprd,sdhci-r11.yaml      |  112 +
>   dts/upstream/Bindings/mtd/amlogic,meson-nand.yaml  |   18 +
>   dts/upstream/Bindings/mtd/atmel-nand.txt           |    9 -
>   dts/upstream/Bindings/mtd/gpmi-nand.yaml           |   22 +
>   dts/upstream/Bindings/mtd/qcom,nandc.yaml          |   38 +-
>   dts/upstream/Bindings/net/airoha,en7581-eth.yaml   |  143 +
>   dts/upstream/Bindings/net/arc_emac.txt             |   46 -
>   .../net/bluetooth/mediatek,mt7622-bluetooth.yaml   |   51 +
>   .../Bindings/net/bluetooth/nxp,88w8987-bt.yaml     |    4 +
>   .../Bindings/net/bluetooth/qualcomm-bluetooth.yaml |   35 +-
>   dts/upstream/Bindings/net/can/xilinx,can.yaml      |    2 +-
>   dts/upstream/Bindings/net/cdns,macb.yaml           |    1 +
>   dts/upstream/Bindings/net/dsa/lantiq,gswip.yaml    |  202 +
>   dts/upstream/Bindings/net/dsa/lantiq-gswip.txt     |  146 -
>   dts/upstream/Bindings/net/dsa/mediatek,mt7530.yaml |    6 +-
>   dts/upstream/Bindings/net/dsa/vitesse,vsc73xx.txt  |  129 -
>   dts/upstream/Bindings/net/dsa/vitesse,vsc73xx.yaml |  162 +
>   dts/upstream/Bindings/net/ethernet-controller.yaml |    1 +
>   dts/upstream/Bindings/net/ethernet-phy.yaml        |    8 +
>   dts/upstream/Bindings/net/fsl,enetc-ierb.yaml      |   38 +
>   dts/upstream/Bindings/net/fsl,enetc-mdio.yaml      |   57 +
>   dts/upstream/Bindings/net/fsl,enetc.yaml           |   66 +
>   dts/upstream/Bindings/net/fsl,fman-mdio.yaml       |  123 +
>   dts/upstream/Bindings/net/fsl,fman-muram.yaml      |   40 +
>   dts/upstream/Bindings/net/fsl,fman-port.yaml       |   75 +
>   dts/upstream/Bindings/net/fsl,fman.yaml            |  210 +
>   dts/upstream/Bindings/net/fsl,qoriq-mc-dpmac.yaml  |    4 +
>   dts/upstream/Bindings/net/fsl-enetc.txt            |  119 -
>   dts/upstream/Bindings/net/fsl-fman.txt             |  548 --
>   dts/upstream/Bindings/net/fsl-tsec-phy.txt         |    2 +-
>   dts/upstream/Bindings/net/hisilicon-hip04-net.txt  |   10 -
>   dts/upstream/Bindings/net/mediatek,net.yaml        |   28 +-
>   dts/upstream/Bindings/net/mediatek-bluetooth.txt   |   36 -
>   dts/upstream/Bindings/net/mscc,miim.yaml           |   10 +
>   dts/upstream/Bindings/net/nxp,tja11xx.yaml         |   62 +-
>   dts/upstream/Bindings/net/pcs/snps,dw-xpcs.yaml    |  136 +
>   dts/upstream/Bindings/net/realtek,rtl82xx.yaml     |   40 +-
>   dts/upstream/Bindings/net/snps,dwmac.yaml          |  148 +-
>   dts/upstream/Bindings/net/stm32-dwmac.yaml         |   49 +-
>   dts/upstream/Bindings/net/ti,icss-iep.yaml         |    9 +
>   dts/upstream/Bindings/net/ti,icssg-prueth.yaml     |    9 +
>   .../Bindings/net/wireless/qcom,ath10k.yaml         |    5 +
>   .../Bindings/net/wireless/qcom,ath11k-pci.yaml     |   46 +
>   .../Bindings/net/wireless/qcom,ath11k.yaml         |    9 -
>   .../Bindings/net/wireless/qcom,ath12k.yaml         |   99 +
>   dts/upstream/Bindings/net/xlnx,gmii-to-rgmii.yaml  |    5 +
>   .../Bindings/nvmem/amlogic,meson-gxbb-efuse.yaml   |    3 +
>   dts/upstream/Bindings/nvmem/imx-iim.yaml           |    4 +-
>   dts/upstream/Bindings/nvmem/imx-ocotp.yaml         |    4 +-
>   dts/upstream/Bindings/nvmem/mediatek,efuse.yaml    |    2 +
>   dts/upstream/Bindings/nvmem/mxs-ocotp.yaml         |    4 +-
>   dts/upstream/Bindings/nvmem/xlnx,zynqmp-nvmem.yaml |    2 +-
>   dts/upstream/Bindings/pci/host-generic-pci.yaml    |    6 +
>   .../Bindings/pci/mediatek,mt7621-pcie.yaml         |   29 +
>   dts/upstream/Bindings/pci/microchip,pcie-host.yaml |   55 +-
>   .../Bindings/pci/plda,xpressrich3-axi-common.yaml  |   75 +
>   dts/upstream/Bindings/pci/qcom,pcie-ep.yaml        |   64 +-
>   dts/upstream/Bindings/pci/qcom,pcie-sm8450.yaml    |    4 +
>   dts/upstream/Bindings/pci/qcom,pcie-x1e80100.yaml  |    3 +-
>   .../Bindings/pci/rockchip-dw-pcie-common.yaml      |  126 +
>   dts/upstream/Bindings/pci/rockchip-dw-pcie-ep.yaml |   95 +
>   dts/upstream/Bindings/pci/rockchip-dw-pcie.yaml    |   93 +-
>   dts/upstream/Bindings/pci/snps,dw-pcie-ep.yaml     |   13 +-
>   .../Bindings/pci/starfive,jh7110-pcie.yaml         |  120 +
>   dts/upstream/Bindings/pci/xilinx-versal-cpm.yaml   |    2 +-
>   dts/upstream/Bindings/perf/fsl-imx-ddr.yaml        |    3 +
>   .../Bindings/phy/airoha,en7581-pcie-phy.yaml       |   69 +
>   .../Bindings/phy/amlogic,g12a-usb2-phy.yaml        |    3 +
>   dts/upstream/Bindings/phy/fsl,imx8qm-hsio.yaml     |  164 +
>   .../phy/marvell,armada-cp110-utmi-phy.yaml         |    6 +
>   .../Bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml    |    2 +
>   .../Bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |    7 +-
>   .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        |    5 +-
>   dts/upstream/Bindings/phy/qcom,usb-hs-phy.yaml     |    2 +
>   .../Bindings/phy/rockchip,rk3399-emmc-phy.yaml     |   64 +
>   dts/upstream/Bindings/phy/rockchip-emmc-phy.txt    |   43 -
>   .../Bindings/phy/samsung,usb3-drd-phy.yaml         |   77 +-
>   .../Bindings/phy/starfive,jh7110-dphy-tx.yaml      |   68 +
>   .../Bindings/pinctrl/aspeed,ast2400-pinctrl.yaml   |  169 +-
>   .../Bindings/pinctrl/aspeed,ast2500-pinctrl.yaml   |  188 +-
>   .../Bindings/pinctrl/aspeed,ast2600-pinctrl.yaml   |  514 +-
>   ...sl,imx93-pinctrl.yaml => fsl,imx9-pinctrl.yaml} |    8 +-
>   .../Bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml   |  178 +
>   .../Bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml  |   22 +-
>   dts/upstream/Bindings/pinctrl/pinctrl-single.yaml  |   17 +-
>   .../Bindings/pinctrl/qcom,mdm9607-tlmm.yaml        |    2 +-
>   dts/upstream/Bindings/pinctrl/qcom,pmic-gpio.yaml  |    2 +
>   .../pinctrl/qcom,sm4250-lpass-lpi-pinctrl.yaml     |  118 +
>   .../Bindings/pinctrl/qcom,sm6350-tlmm.yaml         |    2 +-
>   .../Bindings/pinctrl/qcom,sm6375-tlmm.yaml         |    2 +-
>   .../Bindings/pinctrl/renesas,rzg2l-pinctrl.yaml    |   52 +-
>   .../Bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml      |  349 +-
>   .../Bindings/platform/lenovo,yoga-c630-ec.yaml     |   83 +
>   .../Bindings/power/amlogic,meson-sec-pwrc.yaml     |    2 +
>   .../Bindings/power/supply/maxim,max17201.yaml      |   58 +
>   dts/upstream/Bindings/ptp/fsl,ptp.yaml             |  144 +
>   dts/upstream/Bindings/ptp/ptp-qoriq.txt            |   87 -
>   dts/upstream/Bindings/pwm/adi,axi-pwmgen.yaml      |   48 +
>   dts/upstream/Bindings/pwm/atmel,at91sam-pwm.yaml   |    4 +-
>   dts/upstream/Bindings/pwm/fsl,vf610-ftm-pwm.yaml   |   92 +
>   dts/upstream/Bindings/pwm/imx-pwm.yaml             |    1 -
>   dts/upstream/Bindings/pwm/imx-tpm-pwm.yaml         |    4 +-
>   dts/upstream/Bindings/pwm/mxs-pwm.yaml             |    1 -
>   dts/upstream/Bindings/pwm/pwm-fsl-ftm.txt          |   55 -
>   dts/upstream/Bindings/pwm/pwm-gpio.yaml            |   46 +
>   dts/upstream/Bindings/pwm/pwm.yaml                 |    6 +-
>   .../mediatek,mt6873-dvfsrc-regulator.yaml          |   43 +
>   .../Bindings/regulator/mt6315-regulator.yaml       |    6 +-
>   .../Bindings/regulator/nxp,pca9450-regulator.yaml  |    1 -
>   .../Bindings/regulator/qcom,qca6390-pmu.yaml       |  185 +
>   .../Bindings/regulator/richtek,rtq2208.yaml        |   11 +-
>   .../Bindings/regulator/rohm,bd96801-regulator.yaml |   63 +
>   .../Bindings/regulator/sprd,sc2731-regulator.txt   |   43 -
>   .../Bindings/regulator/sprd,sc2731-regulator.yaml  |   67 +
>   .../Bindings/regulator/st,stm32mp1-pwr-reg.yaml    |    7 +-
>   dts/upstream/Bindings/regulator/ti,tps65132.yaml   |    3 +
>   dts/upstream/Bindings/regulator/twl-regulator.txt  |   80 -
>   .../Bindings/remoteproc/fsl,imx-rproc.yaml         |   15 +
>   .../Bindings/remoteproc/qcom,rpm-proc.yaml         |    2 +-
>   .../Bindings/remoteproc/qcom,sa8775p-pas.yaml      |  160 +
>   .../Bindings/remoteproc/ti,k3-dsp-rproc.yaml       |   89 +-
>   .../Bindings/reset/nuvoton,ma35d1-reset.yaml       |    3 +-
>   .../Bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml  |   10 +
>   dts/upstream/Bindings/reset/ti,sci-reset.yaml      |    2 +-
>   dts/upstream/Bindings/riscv/cpus.yaml              |   22 +-
>   dts/upstream/Bindings/riscv/extensions.yaml        |  132 +
>   dts/upstream/Bindings/riscv/microchip.yaml         |    1 +
>   dts/upstream/Bindings/riscv/starfive.yaml          |    1 +
>   dts/upstream/Bindings/rng/amlogic,meson-rng.yaml   |    3 +
>   .../Bindings/rng/samsung,exynos5250-trng.yaml      |   40 +-
>   dts/upstream/Bindings/rtc/fsl,ls-ftm-alarm.yaml    |   73 +
>   dts/upstream/Bindings/rtc/rtc-fsl-ftm-alarm.txt    |   36 -
>   dts/upstream/Bindings/rtc/st,stm32-rtc.yaml        |    5 +-
>   dts/upstream/Bindings/serial/mediatek,uart.yaml    |    1 +
>   dts/upstream/Bindings/serial/mrvl,pxa-ssp.txt      |   64 -
>   dts/upstream/Bindings/serial/nxp,sc16is7xx.yaml    |    5 +
>   dts/upstream/Bindings/serial/renesas,scif.yaml     |  136 +-
>   dts/upstream/Bindings/serial/snps-dw-apb-uart.yaml |   18 +-
>   dts/upstream/Bindings/serial/via,vt8500-uart.yaml  |   46 +
>   dts/upstream/Bindings/serial/vt8500-uart.txt       |   27 -
>   dts/upstream/Bindings/soc/fsl/bman-portals.txt     |   56 -
>   dts/upstream/Bindings/soc/fsl/bman.txt             |  137 -
>   .../Bindings/soc/fsl/cpm_qe/fsl,qe-firmware.yaml   |   48 +
>   .../Bindings/soc/fsl/cpm_qe/fsl,qe-ic.yaml         |   47 +
>   .../Bindings/soc/fsl/cpm_qe/fsl,qe-muram.yaml      |   71 +
>   .../Bindings/soc/fsl/cpm_qe/fsl,qe-si.yaml         |   40 +
>   .../Bindings/soc/fsl/cpm_qe/fsl,qe-siram.yaml      |   39 +
>   dts/upstream/Bindings/soc/fsl/cpm_qe/fsl,qe.yaml   |  148 +
>   dts/upstream/Bindings/soc/fsl/cpm_qe/qe.txt        |  178 -
>   dts/upstream/Bindings/soc/fsl/fsl,bman-portal.yaml |   52 +
>   dts/upstream/Bindings/soc/fsl/fsl,bman.yaml        |   83 +
>   .../Bindings/soc/fsl/fsl,layerscape-dcfg.yaml      |    1 -
>   .../Bindings/soc/fsl/fsl,layerscape-scfg.yaml      |    1 -
>   .../Bindings/soc/fsl/fsl,ls1028a-reset.yaml        |   56 +
>   dts/upstream/Bindings/soc/fsl/fsl,qman-fqd.yaml    |   69 +
>   dts/upstream/Bindings/soc/fsl/fsl,qman-portal.yaml |  110 +
>   dts/upstream/Bindings/soc/fsl/fsl,qman.yaml        |   93 +
>   dts/upstream/Bindings/soc/fsl/qman-portals.txt     |  134 -
>   dts/upstream/Bindings/soc/fsl/qman.txt             |  187 -
>   .../hisilicon/hisilicon,hi3660-usb3-otg-bc.yaml    |   46 +
>   .../Bindings/soc/intel/intel,lgm-syscon.yaml       |   57 +
>   .../Bindings/soc/mediatek/mediatek,mutex.yaml      |    1 +
>   .../soc/microchip/microchip,sparx5-cpu-syscon.yaml |   49 +
>   .../Bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  |  374 ++
>   dts/upstream/Bindings/soc/qcom/qcom,aoss-qmp.yaml  |    1 +
>   .../Bindings/soc/qcom/qcom,rpm-master-stats.yaml   |    2 +-
>   dts/upstream/Bindings/soc/qcom/qcom,smp2p.yaml     |    3 +-
>   dts/upstream/Bindings/soc/qcom/qcom,smsm.yaml      |   30 +-
>   dts/upstream/Bindings/soc/rockchip/grf.yaml        |   26 +-
>   .../Bindings/soc/sprd/sprd,sc9863a-glbregs.yaml    |   55 +
>   dts/upstream/Bindings/soc/sti/st,sti-syscon.yaml   |    9 +
>   dts/upstream/Bindings/soc/ti/sci-pm-domain.yaml    |    2 +-
>   .../Bindings/soc/ti/ti,am654-serdes-ctrl.yaml      |   42 +
>   .../ti}/ti,j721e-system-controller.yaml            |    4 +-
>   dts/upstream/Bindings/sound/ak4104.txt             |   25 -
>   dts/upstream/Bindings/sound/ak4554.txt             |   11 -
>   .../Bindings/sound/amlogic,g12a-tohdmitx.txt       |   58 -
>   .../Bindings/sound/amlogic,g12a-tohdmitx.yaml      |   54 +
>   .../Bindings/sound/amlogic,gx-sound-card.yaml      |    1 -
>   .../Bindings/sound/asahi-kasei,ak4104.yaml         |   49 +
>   .../sound/{ak4375.yaml => asahi-kasei,ak4375.yaml} |    2 +-
>   .../Bindings/sound/asahi-kasei,ak4554.yaml         |   27 +
>   .../sound/{ak4613.yaml => asahi-kasei,ak4613.yaml} |    2 +-
>   .../Bindings/sound/asahi-kasei,ak4619.yaml         |   62 +
>   .../sound/{ak4642.yaml => asahi-kasei,ak4642.yaml} |    2 +-
>   dts/upstream/Bindings/sound/audio-graph-card2.yaml |    5 +
>   dts/upstream/Bindings/sound/audio-graph-port.yaml  |    9 +
>   dts/upstream/Bindings/sound/cirrus,cs4270.yaml     |   59 +
>   dts/upstream/Bindings/sound/cirrus,cs42xx8.yaml    |   81 +
>   dts/upstream/Bindings/sound/cirrus,cs530x.yaml     |   85 +
>   dts/upstream/Bindings/sound/cs4270.txt             |   21 -
>   dts/upstream/Bindings/sound/cs42xx8.txt            |   34 -
>   dts/upstream/Bindings/sound/everest,es7134.txt     |   15 -
>   dts/upstream/Bindings/sound/everest,es71x4.yaml    |   62 +
>   dts/upstream/Bindings/sound/everest,es7241.txt     |   28 -
>   dts/upstream/Bindings/sound/everest,es7241.yaml    |   67 +
>   dts/upstream/Bindings/sound/everest,es8316.yaml    |    7 +-
>   .../Bindings/sound/fsl,imx-audio-spdif.yaml        |   66 -
>   dts/upstream/Bindings/sound/fsl,mqs.yaml           |    2 +
>   dts/upstream/Bindings/sound/fsl,qmc-audio.yaml     |   41 +-
>   dts/upstream/Bindings/sound/fsl,rpmsg.yaml         |    1 +
>   .../sound/{sgtl5000.yaml => fsl,sgtl5000.yaml}     |    2 +-
>   dts/upstream/Bindings/sound/fsl,xcvr.yaml          |   43 +-
>   dts/upstream/Bindings/sound/fsl-asoc-card.yaml     |   53 +-
>   .../{linux,spdif-dit.yaml => linux,spdif.yaml}     |    8 +-
>   dts/upstream/Bindings/sound/maxim,max98088.txt     |   23 -
>   dts/upstream/Bindings/sound/maxim,max98088.yaml    |   47 +
>   .../sound/{zl38060.yaml => mscc,zl38060.yaml}      |    2 +-
>   dts/upstream/Bindings/sound/nuvoton,nau8824.yaml   |    8 +
>   dts/upstream/Bindings/sound/nxp,lpc3220-i2s.yaml   |   73 +
>   dts/upstream/Bindings/sound/omap-mcpdm.txt         |   30 -
>   dts/upstream/Bindings/sound/pcm512x.txt            |    2 +-
>   dts/upstream/Bindings/sound/qcom,apq8096.txt       |  128 -
>   .../sound/qcom,msm8916-wcd-digital-codec.yaml      |   55 +
>   .../Bindings/sound/qcom,msm8916-wcd-digital.txt    |   20 -
>   dts/upstream/Bindings/sound/qcom,sm8250.yaml       |    1 +
>   dts/upstream/Bindings/sound/qcom,wcd934x.yaml      |    3 +-
>   dts/upstream/Bindings/sound/qcom,wcd937x-sdw.yaml  |   91 +
>   dts/upstream/Bindings/sound/qcom,wcd937x.yaml      |   82 +
>   dts/upstream/Bindings/sound/qcom,wcd938x.yaml      |    3 +-
>   dts/upstream/Bindings/sound/qcom,wcd939x.yaml      |    4 +-
>   dts/upstream/Bindings/sound/qcom,wsa883x.yaml      |    8 +
>   dts/upstream/Bindings/sound/qcom,wsa8840.yaml      |    8 +
>   .../sound/{rt1019.yaml => realtek,rt1019.yaml}     |    2 +-
>   dts/upstream/Bindings/sound/realtek,rt5514.yaml    |   70 +
>   dts/upstream/Bindings/sound/realtek,rt5631.yaml    |   67 +
>   dts/upstream/Bindings/sound/realtek,rt5645.yaml    |  131 +
>   dts/upstream/Bindings/sound/realtek,rt5659.yaml    |  129 +
>   dts/upstream/Bindings/sound/realtek,rt5677.yaml    |  135 +
>   dts/upstream/Bindings/sound/rt5514.txt             |   37 -
>   dts/upstream/Bindings/sound/rt5631.txt             |   48 -
>   dts/upstream/Bindings/sound/rt5645.txt             |   82 -
>   dts/upstream/Bindings/sound/rt5659.txt             |   89 -
>   dts/upstream/Bindings/sound/rt5677.txt             |   78 -
>   .../Bindings/sound/samsung,midas-audio.yaml        |   33 +
>   dts/upstream/Bindings/sound/simple-audio-mux.yaml  |    6 +
>   dts/upstream/Bindings/sound/spdif-receiver.txt     |   10 -
>   dts/upstream/Bindings/sound/tas571x.txt            |   49 -
>   dts/upstream/Bindings/sound/ti,omap4-mcpdm.yaml    |   73 +
>   .../sound/{tas2562.yaml => ti,tas2562.yaml}        |    2 +-
>   .../sound/{tas2770.yaml => ti,tas2770.yaml}        |    2 +-
>   .../sound/{tas27xx.yaml => ti,tas27xx.yaml}        |    2 +-
>   dts/upstream/Bindings/sound/ti,tas57xx.yaml        |  133 +
>   .../sound/{tas5805m.yaml => ti,tas5805m.yaml}      |    2 +-
>   dts/upstream/Bindings/sound/ti,tlv320adc3xxx.yaml  |   32 +-
>   .../{tlv320adcx140.yaml => ti,tlv320adcx140.yaml}  |    2 +-
>   .../sound/{wm8750.yaml => wlf,wm8750.yaml}         |    2 +-
>   dts/upstream/Bindings/sound/wlf,wm8782.yaml        |   47 +
>   dts/upstream/Bindings/sound/wlf,wm8804.yaml        |   58 +
>   dts/upstream/Bindings/sound/wm8782.txt             |   24 -
>   dts/upstream/Bindings/sound/wm8804.txt             |   25 -
>   dts/upstream/Bindings/spi/amlogic,a1-spifc.yaml    |    3 +
>   .../Bindings/spi/atmel,at91rm9200-spi.yaml         |    8 +-
>   dts/upstream/Bindings/spi/brcm,bcm2835-spi.txt     |   23 -
>   dts/upstream/Bindings/spi/brcm,bcm2835-spi.yaml    |   50 +
>   .../Bindings/spi/fsl,dspi-peripheral-props.yaml    |   30 +
>   dts/upstream/Bindings/spi/fsl,dspi.yaml            |  116 +
>   dts/upstream/Bindings/spi/ibm,spi-fsi.yaml         |   55 +
>   dts/upstream/Bindings/spi/marvell,mmp2-ssp.yaml    |   35 +-
>   dts/upstream/Bindings/spi/microchip,mpfs-spi.yaml  |   29 +-
>   dts/upstream/Bindings/spi/snps,dw-apb-ssi.yaml     |    4 +
>   dts/upstream/Bindings/spi/spi-cadence.yaml         |    7 +
>   dts/upstream/Bindings/spi/spi-fsl-dspi.txt         |   65 -
>   dts/upstream/Bindings/spi/spi-fsl-lpspi.yaml       |    4 +-
>   .../Bindings/spi/spi-peripheral-props.yaml         |    1 +
>   dts/upstream/Bindings/spi/st,stm32-spi.yaml        |    2 +-
>   .../sram/allwinner,sun4i-a10-system-control.yaml   |   28 +
>   dts/upstream/Bindings/sram/qcom,imem.yaml          |    1 +
>   .../Bindings/thermal/allwinner,sun8i-a83t-ths.yaml |    6 +-
>   dts/upstream/Bindings/thermal/amlogic,thermal.yaml |   22 +-
>   .../Bindings/thermal/brcm,avs-ro-thermal.yaml      |   22 +-
>   dts/upstream/Bindings/thermal/brcm,avs-tmon.yaml   |   17 +-
>   .../Bindings/thermal/brcm,bcm2835-thermal.yaml     |    1 -
>   dts/upstream/Bindings/thermal/fsl,scu-thermal.yaml |    1 -
>   .../Bindings/thermal/generic-adc-thermal.yaml      |    5 +-
>   .../Bindings/thermal/hisilicon,tsensor.yaml        |   57 +
>   .../Bindings/thermal/hisilicon-thermal.txt         |   32 -
>   dts/upstream/Bindings/thermal/imx-thermal.yaml     |    1 -
>   dts/upstream/Bindings/thermal/imx8mm-thermal.yaml  |    9 +-
>   .../Bindings/thermal/loongson,ls2k-thermal.yaml    |    1 -
>   .../Bindings/thermal/mediatek,lvts-thermal.yaml    |    1 -
>   .../Bindings/thermal/nvidia,tegra124-soctherm.yaml |    1 -
>   .../thermal/nvidia,tegra186-bpmp-thermal.yaml      |   12 +-
>   .../Bindings/thermal/nvidia,tegra30-tsensor.yaml   |    9 +-
>   .../Bindings/thermal/qcom,spmi-temp-alarm.yaml     |    1 -
>   .../Bindings/thermal/qcom-spmi-adc-tm-hc.yaml      |    8 +-
>   .../Bindings/thermal/qcom-spmi-adc-tm5.yaml        |    8 +-
>   dts/upstream/Bindings/thermal/qcom-tsens.yaml      |   97 +-
>   dts/upstream/Bindings/thermal/qoriq-thermal.yaml   |    9 +-
>   .../Bindings/thermal/rcar-gen3-thermal.yaml        |   69 +-
>   dts/upstream/Bindings/thermal/rcar-thermal.yaml    |   60 +-
>   .../Bindings/thermal/rockchip-thermal.yaml         |    5 +-
>   dts/upstream/Bindings/thermal/rzg2l-thermal.yaml   |   41 +-
>   .../Bindings/thermal/samsung,exynos-thermal.yaml   |    3 +-
>   .../thermal/socionext,uniphier-thermal.yaml        |    5 +-
>   dts/upstream/Bindings/thermal/sprd-thermal.yaml    |   47 +-
>   .../Bindings/thermal/st,stm32-thermal.yaml         |    5 +-
>   dts/upstream/Bindings/thermal/thermal-zones.yaml   |    6 +-
>   .../Bindings/thermal/ti,am654-thermal.yaml         |   15 +-
>   .../Bindings/thermal/ti,j72xx-thermal.yaml         |    5 +-
>   .../Bindings/timer/realtek,otto-timer.yaml         |   63 +
>   dts/upstream/Bindings/timer/renesas,tmu.yaml       |   13 +
>   dts/upstream/Bindings/timer/sifive,clint.yaml      |    1 +
>   dts/upstream/Bindings/timer/sprd,sc9860-timer.yaml |   68 +
>   .../Bindings/timer/spreadtrum,sprd-timer.txt       |   20 -
>   dts/upstream/Bindings/trivial-devices.yaml         |   16 +-
>   dts/upstream/Bindings/ufs/qcom,ufs.yaml            |   12 +-
>   dts/upstream/Bindings/usb/cdns,usb3.yaml           |   15 +-
>   dts/upstream/Bindings/usb/dwc2.yaml                |    2 +-
>   dts/upstream/Bindings/usb/fsl,usb2.yaml            |   95 +
>   dts/upstream/Bindings/usb/fsl-usb.txt              |   81 -
>   dts/upstream/Bindings/usb/genesys,gl850g.yaml      |   60 +-
>   dts/upstream/Bindings/usb/gpio-sbu-mux.yaml        |    8 +-
>   dts/upstream/Bindings/usb/microchip,mpfs-musb.yaml |    7 +
>   dts/upstream/Bindings/usb/microchip,usb2514.yaml   |   10 +-
>   dts/upstream/Bindings/usb/qcom,dwc3.yaml           |   29 +
>   dts/upstream/Bindings/vendor-prefixes.yaml         |   20 +
>   .../Bindings/watchdog/amlogic,meson-gxbb-wdt.yaml  |    1 +
>   .../Bindings/watchdog/dlg,da9062-watchdog.yaml     |    2 +-
>   dts/upstream/Bindings/watchdog/fsl-imx-wdt.yaml    |    4 +-
>   .../Bindings/watchdog/fsl-imx7ulp-wdt.yaml         |    4 +-
>   dts/upstream/Bindings/watchdog/img,pdc-wdt.yaml    |   55 +
>   dts/upstream/Bindings/watchdog/imgpdc-wdt.txt      |   19 -
>   dts/upstream/Bindings/watchdog/renesas,wdt.yaml    |    1 +
>   dts/upstream/include/dt-bindings/arm/qcom,ids.h    |    2 +
>   .../clock/amlogic,a1-peripherals-clkc.h            |    1 +
>   .../dt-bindings/clock/amlogic,a1-pll-clkc.h        |    1 +
>   .../clock/amlogic,c3-peripherals-clkc.h            |  212 +
>   .../dt-bindings/clock/amlogic,c3-pll-clkc.h        |   40 +
>   .../dt-bindings/clock/amlogic,c3-scmi-clkc.h       |   27 +
>   .../include/dt-bindings/clock/qcom,ipq9574-gcc.h   |    4 +
>   .../include/dt-bindings/clock/qcom,qca8k-nsscc.h   |  101 +
>   .../include/dt-bindings/clock/qcom,qcm2290-gpucc.h |   32 +
>   .../include/dt-bindings/clock/qcom,sm7150-camcc.h  |  113 +
>   .../include/dt-bindings/clock/qcom,sm7150-dispcc.h |   59 +
>   .../dt-bindings/clock/qcom,sm7150-videocc.h        |   28 +
>   .../include/dt-bindings/clock/qcom,sm8650-camcc.h  |  195 +
>   .../dt-bindings/clock/qcom,sm8650-videocc.h        |   23 +
>   .../include/dt-bindings/clock/r8a7779-clock.h      |    1 -
>   .../include/dt-bindings/clock/r8a7790-clock.h      |  158 -
>   .../include/dt-bindings/clock/r8a7791-clock.h      |  161 -
>   .../include/dt-bindings/clock/r8a7792-clock.h      |   98 -
>   .../include/dt-bindings/clock/r8a7793-clock.h      |  159 -
>   .../include/dt-bindings/clock/r8a7794-clock.h      |  137 -
>   .../include/dt-bindings/clock/rk3128-cru.h         |    4 +-
>   .../include/dt-bindings/clock/rk3188-cru-common.h  |    2 -
>   .../dt-bindings/clock/sophgo,sg2042-clkgen.h       |  111 +
>   .../include/dt-bindings/clock/sophgo,sg2042-pll.h  |   14 +
>   .../dt-bindings/clock/sophgo,sg2042-rpgate.h       |   58 +
>   .../include/dt-bindings/clock/sun50i-h616-ccu.h    |    1 +
>   .../dt-bindings/clock/thead,th1520-clk-ap.h        |   96 +
>   dts/upstream/include/dt-bindings/i3c/i3c.h         |   16 +
>   .../dt-bindings/iio/adc/mediatek,mt6357-auxadc.h   |   21 +
>   .../dt-bindings/iio/adc/mediatek,mt6358-auxadc.h   |   22 +
>   .../dt-bindings/iio/adc/mediatek,mt6359-auxadc.h   |   22 +
>   .../include/dt-bindings/input/cros-ec-keyboard.h   |  104 +
>   .../dt-bindings/interconnect/mediatek,mt8183.h     |   23 +
>   .../dt-bindings/interconnect/mediatek,mt8195.h     |   44 +
>   .../dt-bindings/interconnect/qcom,ipq9574.h        |   59 +
>   .../dt-bindings/interconnect/qcom,msm8953.h        |   93 +
>   dts/upstream/include/dt-bindings/mfd/qcom-pm8008.h |   19 -
>   dts/upstream/include/dt-bindings/mfd/st,stpmic1.h  |    2 +-
>   .../include/dt-bindings/power/amlogic,a4-pwrc.h    |   21 +
>   .../include/dt-bindings/power/amlogic,a5-pwrc.h    |   21 +
>   .../dt-bindings/regulator/st,stm32mp25-regulator.h |   48 +
>   .../dt-bindings/reset/airoha,en7581-reset.h        |   66 +
>   .../include/dt-bindings/reset/qcom,qca8k-nsscc.h   |   76 +
>   .../include/dt-bindings/reset/sun50i-h616-ccu.h    |    1 +
>   .../include/dt-bindings/sound/audio-graph.h        |   26 +
>   .../dt-bindings/thermal/mediatek,lvts-thermal.h    |   12 +-
>   .../src/arm/arm/arm-realview-eb-bbrevd.dtsi        |    2 +-
>   dts/upstream/src/arm/arm/arm-realview-eb.dtsi      |   48 +-
>   dts/upstream/src/arm/arm/arm-realview-pb1176.dts   |   38 +-
>   dts/upstream/src/arm/arm/arm-realview-pb11mp.dts   |   48 +-
>   dts/upstream/src/arm/arm/arm-realview-pbx.dtsi     |   48 +-
>   dts/upstream/src/arm/arm/integratorap-im-pd1.dts   |    4 +-
>   dts/upstream/src/arm/arm/integratorap.dts          |   14 +-
>   dts/upstream/src/arm/arm/integratorcp.dts          |   14 +-
>   dts/upstream/src/arm/arm/mps2.dtsi                 |   48 +-
>   dts/upstream/src/arm/arm/versatile-ab.dts          |    8 +-
>   dts/upstream/src/arm/arm/vexpress-v2m-rs1.dtsi     |    8 +-
>   dts/upstream/src/arm/arm/vexpress-v2m.dtsi         |   16 +-
>   dts/upstream/src/arm/arm/vexpress-v2p-ca15-tc1.dts |   14 +-
>   dts/upstream/src/arm/arm/vexpress-v2p-ca15_a7.dts  |   22 +-
>   dts/upstream/src/arm/arm/vexpress-v2p-ca5s.dts     |   12 +-
>   dts/upstream/src/arm/arm/vexpress-v2p-ca9.dts      |   18 +-
>   dts/upstream/src/arm/aspeed/aspeed-g4.dtsi         |   28 +-
>   dts/upstream/src/arm/aspeed/aspeed-g5.dtsi         |   28 +-
>   dts/upstream/src/arm/aspeed/aspeed-g6.dtsi         |   32 +-
>   dts/upstream/src/arm/cirrus/ep7211-edb7211.dts     |    2 +-
>   .../arm/intel/ixp/intel-ixp42x-linksys-nslu2.dts   |   11 +-
>   dts/upstream/src/arm/marvell/armada-370-xp.dtsi    |    1 -
>   dts/upstream/src/arm/marvell/armada-375.dtsi       |    1 -
>   .../src/arm/marvell/armada-385-atl-x530.dts        |   13 +-
>   .../src/arm/marvell/armada-385-turris-omnia.dts    |   35 +-
>   dts/upstream/src/arm/marvell/armada-38x.dtsi       |    1 -
>   dts/upstream/src/arm/marvell/armada-39x.dtsi       |    1 -
>   .../src/arm/marvell/kirkwood-blackarmor-nas220.dts |    6 +-
>   dts/upstream/src/arm/marvell/kirkwood-c200-v1.dts  |    8 +-
>   dts/upstream/src/arm/marvell/kirkwood-cloudbox.dts |    8 +-
>   dts/upstream/src/arm/marvell/kirkwood-d2net.dts    |    2 +-
>   dts/upstream/src/arm/marvell/kirkwood-dir665.dts   |   22 +-
>   dts/upstream/src/arm/marvell/kirkwood-dns320.dts   |   10 +-
>   dts/upstream/src/arm/marvell/kirkwood-dns325.dts   |   10 +-
>   dts/upstream/src/arm/marvell/kirkwood-dnskw.dtsi   |    8 +-
>   dts/upstream/src/arm/marvell/kirkwood-dockstar.dts |    4 +-
>   .../src/arm/marvell/kirkwood-dreamplug.dts         |    6 +-
>   .../src/arm/marvell/kirkwood-goflexnet.dts         |   20 +-
>   .../arm/marvell/kirkwood-guruplug-server-plus.dts  |    8 +-
>   dts/upstream/src/arm/marvell/kirkwood-ib62x0.dts   |   12 +-
>   dts/upstream/src/arm/marvell/kirkwood-iconnect.dts |   20 +-
>   .../src/arm/marvell/kirkwood-iomega_ix2_200.dts    |   16 +-
>   dts/upstream/src/arm/marvell/kirkwood-l-50.dts     |   20 +-
>   dts/upstream/src/arm/marvell/kirkwood-laplug.dts   |    6 +-
>   .../src/arm/marvell/kirkwood-linkstation.dtsi      |    2 -
>   .../src/arm/marvell/kirkwood-linksys-viper.dts     |   10 +-
>   dts/upstream/src/arm/marvell/kirkwood-lsxl.dtsi    |   18 +-
>   dts/upstream/src/arm/marvell/kirkwood-mplcec4.dts  |   12 +-
>   .../src/arm/marvell/kirkwood-mv88f6281gtw-ge.dts   |   12 +-
>   dts/upstream/src/arm/marvell/kirkwood-netxbig.dtsi |    8 +-
>   .../src/arm/marvell/kirkwood-ns2-common.dtsi       |    6 +-
>   dts/upstream/src/arm/marvell/kirkwood-ns2lite.dts  |    2 +-
>   dts/upstream/src/arm/marvell/kirkwood-nsa310.dts   |   20 +-
>   dts/upstream/src/arm/marvell/kirkwood-nsa310a.dts  |   18 +-
>   dts/upstream/src/arm/marvell/kirkwood-nsa310s.dts  |    8 +-
>   dts/upstream/src/arm/marvell/kirkwood-nsa320.dts   |   18 +-
>   dts/upstream/src/arm/marvell/kirkwood-nsa325.dts   |   18 +-
>   .../src/arm/marvell/kirkwood-nsa3x0-common.dtsi    |    8 +-
>   .../src/arm/marvell/kirkwood-openblocks_a6.dts     |    4 +-
>   .../src/arm/marvell/kirkwood-openblocks_a7.dts     |    2 -
>   dts/upstream/src/arm/marvell/kirkwood-pogo_e02.dts |    4 +-
>   .../src/arm/marvell/kirkwood-pogoplug-series-4.dts |    8 +-
>   .../src/arm/marvell/kirkwood-sheevaplug-esata.dts  |    2 +-
>   .../src/arm/marvell/kirkwood-sheevaplug.dts        |    4 +-
>   .../src/arm/marvell/kirkwood-synology.dtsi         |   58 +-
>   dts/upstream/src/arm/marvell/kirkwood-t5325.dts    |    4 +-
>   .../src/arm/marvell/kirkwood-ts219-6281.dts        |    6 +-
>   .../src/arm/marvell/kirkwood-ts219-6282.dts        |    6 +-
>   dts/upstream/src/arm/marvell/kirkwood-ts419.dtsi   |    6 +-
>   .../arm/marvell/mvebu-linkstation-gpio-simple.dtsi |    2 -
>   .../src/arm/marvell/orion5x-lacie-d2-network.dts   |    9 +-
>   .../orion5x-lacie-ethernet-disk-mini-v2.dts        |    7 +-
>   .../src/arm/marvell/orion5x-linkstation-lschl.dts  |    4 +-
>   dts/upstream/src/arm/marvell/orion5x-lswsgl.dts    |   25 +-
>   .../marvell/orion5x-maxtor-shared-storage-2.dts    |    7 +-
>   .../src/arm/marvell/orion5x-netgear-wnr854t.dts    |    2 +-
>   .../src/arm/marvell/orion5x-rd88f5182-nas.dts      |    2 +-
>   dts/upstream/src/arm/mediatek/mt2701-evb.dts       |    2 +-
>   dts/upstream/src/arm/mediatek/mt7623.dtsi          |   18 +-
>   dts/upstream/src/arm/nspire/nspire-classic.dtsi    |    2 +-
>   dts/upstream/src/arm/nspire/nspire-cx.dts          |    2 +-
>   dts/upstream/src/arm/nspire/nspire.dtsi            |    5 +-
>   .../src/arm/nuvoton/nuvoton-npcm730-kudo.dts       |   22 +-
>   .../arm/nuvoton/nuvoton-npcm750-runbmc-olympus.dts |   22 +-
>   dts/upstream/src/arm/nxp/imx/e60k02.dtsi           |    4 +
>   dts/upstream/src/arm/nxp/imx/imx51-apf51dev.dts    |    4 +-
>   dts/upstream/src/arm/nxp/imx/imx51-babbage.dts     |    2 +-
>   dts/upstream/src/arm/nxp/imx/imx51-ts4800.dts      |    4 +-
>   dts/upstream/src/arm/nxp/imx/imx53-m53evk.dts      |    4 +-
>   dts/upstream/src/arm/nxp/imx/imx53-m53menlo.dts    |    1 +
>   dts/upstream/src/arm/nxp/imx/imx53-tx53-x03x.dts   |   14 +-
>   dts/upstream/src/arm/nxp/imx/imx53-tx53-x13x.dts   |    6 +-
>   .../src/arm/nxp/imx/imx6dl-aristainetos2_4.dts     |    5 +-
>   .../src/arm/nxp/imx/imx6dl-aristainetos_4.dts      |    4 +-
>   .../src/arm/nxp/imx/imx6dl-aristainetos_7.dts      |    4 +-
>   .../src/arm/nxp/imx/imx6dl-kontron-samx6i-ads2.dts |   12 +
>   .../src/arm/nxp/imx/imx6dl-kontron-samx6i.dtsi     |    2 +-
>   .../src/arm/nxp/imx/imx6dl-yapp43-common.dtsi      |   12 +-
>   .../src/arm/nxp/imx/imx6q-kontron-samx6i-ads2.dts  |   12 +
>   .../src/arm/nxp/imx/imx6q-kontron-samx6i.dtsi      |   25 +-
>   dts/upstream/src/arm/nxp/imx/imx6qdl-gw52xx.dtsi   |    2 +-
>   dts/upstream/src/arm/nxp/imx/imx6qdl-gw53xx.dtsi   |    2 +-
>   dts/upstream/src/arm/nxp/imx/imx6qdl-gw54xx.dtsi   |    2 +-
>   dts/upstream/src/arm/nxp/imx/imx6qdl-gw560x.dtsi   |    2 +-
>   dts/upstream/src/arm/nxp/imx/imx6qdl-gw5903.dtsi   |    2 +-
>   dts/upstream/src/arm/nxp/imx/imx6qdl-gw5904.dtsi   |    2 +-
>   .../arm/nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi   |  148 +
>   .../src/arm/nxp/imx/imx6qdl-kontron-samx6i.dtsi    |   58 +-
>   dts/upstream/src/arm/nxp/imx/imx6qdl-mba6a.dtsi    |   12 +-
>   dts/upstream/src/arm/nxp/imx/imx6qdl-mba6b.dtsi    |   12 +-
>   .../src/arm/nxp/imx/imx6qdl-sabreauto.dtsi         |    2 +-
>   dts/upstream/src/arm/nxp/imx/imx6qdl-tx6-lcd.dtsi  |   21 +-
>   dts/upstream/src/arm/nxp/imx/imx6qdl-tx6-lvds.dtsi |   20 +-
>   dts/upstream/src/arm/nxp/imx/imx6ul-tx6ul.dtsi     |   14 +-
>   dts/upstream/src/arm/nxp/mxs/imx28-tx28.dts        |    6 -
>   .../src/arm/qcom/msm8226-motorola-falcon.dts       |   53 +
>   .../arm/qcom/qcom-apq8026-samsung-milletwifi.dts   |  573 ++
>   dts/upstream/src/arm/qcom/qcom-apq8064.dtsi        |    7 +-
>   dts/upstream/src/arm/qcom/qcom-apq8084.dtsi        |    2 +-
>   dts/upstream/src/arm/qcom/qcom-ipq4019.dtsi        |    1 -
>   dts/upstream/src/arm/qcom/qcom-ipq8064.dtsi        |    3 +-
>   dts/upstream/src/arm/qcom/qcom-mdm9615.dtsi        |    1 -
>   .../arm/qcom/qcom-msm8226-microsoft-common.dtsi    |    4 +
>   .../src/arm/qcom/qcom-msm8226-samsung-ms013g.dts   |  386 ++
>   dts/upstream/src/arm/qcom/qcom-msm8226.dtsi        |    4 +-
>   dts/upstream/src/arm/qcom/qcom-msm8660.dtsi        |    1 -
>   .../arm/qcom/qcom-msm8926-motorola-peregrine.dts   |  123 +-
>   dts/upstream/src/arm/qcom/qcom-msm8960.dtsi        |    5 +-
>   .../qcom/qcom-msm8974-lge-nexus5-hammerhead.dts    |    6 +-
>   .../src/arm/qcom/qcom-msm8974-samsung-hlte.dts     |  401 ++
>   dts/upstream/src/arm/qcom/qcom-msm8974.dtsi        |   28 +-
>   .../src/arm/qcom/qcom-msm8974pro-htc-m8.dts        |  353 +
>   .../qcom-msm8974pro-sony-xperia-shinano-aries.dts  |   44 +
>   ...qcom-msm8974pro-sony-xperia-shinano-common.dtsi |    2 +
>   dts/upstream/src/arm/renesas/r8a73a4.dtsi          |    1 +
>   dts/upstream/src/arm/renesas/r8a7742.dtsi          |    1 +
>   dts/upstream/src/arm/renesas/r8a7743.dtsi          |    1 +
>   dts/upstream/src/arm/renesas/r8a7744.dtsi          |    1 +
>   dts/upstream/src/arm/renesas/r8a7745.dtsi          |    1 +
>   dts/upstream/src/arm/renesas/r8a77470.dtsi         |    1 +
>   dts/upstream/src/arm/renesas/r8a7790.dtsi          |    1 +
>   dts/upstream/src/arm/renesas/r8a7791.dtsi          |    1 +
>   dts/upstream/src/arm/renesas/r8a7792.dtsi          |    1 +
>   dts/upstream/src/arm/renesas/r8a7793.dtsi          |    1 +
>   dts/upstream/src/arm/renesas/r8a7794.dtsi          |    1 +
>   dts/upstream/src/arm/renesas/r9a06g032.dtsi        |   19 +
>   dts/upstream/src/arm/rockchip/rk3036.dtsi          |    1 +
>   dts/upstream/src/arm/rockchip/rk3066a-mk808.dts    |    8 +
>   dts/upstream/src/arm/rockchip/rk3066a.dtsi         |   20 +-
>   dts/upstream/src/arm/rockchip/rk3128.dtsi          |  128 +
>   dts/upstream/src/arm/rockchip/rk3xxx.dtsi          |    7 +-
>   .../src/arm/rockchip/rv1126-edgeble-neu2-io.dts    |    3 +-
>   dts/upstream/src/arm/st/stih407-family.dtsi        |    6 +-
>   dts/upstream/src/arm/st/stih410.dtsi               |    1 +
>   dts/upstream/src/arm/st/stih418.dtsi               |   42 +-
>   dts/upstream/src/arm/st/stm32f429.dtsi             |    1 +
>   dts/upstream/src/arm/st/stm32mp13-pinctrl.dtsi     |  697 ++
>   dts/upstream/src/arm/st/stm32mp131.dtsi            |   38 +
>   dts/upstream/src/arm/st/stm32mp133.dtsi            |   31 +
>   .../src/arm/st/stm32mp135f-dhcor-dhsbc.dts         |  377 ++
>   dts/upstream/src/arm/st/stm32mp135f-dk.dts         |  128 +
>   dts/upstream/src/arm/st/stm32mp13xx-dhcor-som.dtsi |  308 +
>   dts/upstream/src/arm/st/stm32mp151.dtsi            |    1 +
>   dts/upstream/src/arm/st/stm32mp157a-dk1-scmi.dts   |    5 +
>   dts/upstream/src/arm/st/stm32mp157c-dk2-scmi.dts   |    5 +
>   dts/upstream/src/arm/st/stm32mp157c-ed1-scmi.dts   |    5 +
>   dts/upstream/src/arm/st/stm32mp157c-ev1-scmi.dts   |    5 +
>   .../src/arm/st/stm32mp157c-osd32mp1-red.dts        |   13 -
>   dts/upstream/src/arm/st/stm32mp15xc-lxa-tac.dtsi   |   13 -
>   dts/upstream/src/arm/st/stm32mp15xx-osd32.dtsi     |   13 +
>   dts/upstream/src/arm/ti/davinci/da850-evm.dts      |    2 +-
>   dts/upstream/src/arm/ti/omap/am335x-guardian.dts   |    2 +-
>   dts/upstream/src/arm/ti/omap/am335x-pdu001.dts     |    2 +-
>   dts/upstream/src/arm/ti/omap/am335x-pepper.dts     |    2 +-
>   .../src/arm/ti/omap/am5729-beagleboneai.dts        |    1 -
>   dts/upstream/src/arm/ti/omap/omap3-n900.dts        |    2 +-
>   dts/upstream/src/arm/vt8500/vt8500-bv07.dts        |    2 +-
>   dts/upstream/src/arm/vt8500/vt8500.dtsi            |    2 +-
>   dts/upstream/src/arm/vt8500/wm8505-ref.dts         |    2 +-
>   dts/upstream/src/arm/vt8500/wm8505.dtsi            |    2 +-
>   dts/upstream/src/arm/vt8500/wm8650-mid.dts         |    2 +-
>   dts/upstream/src/arm/vt8500/wm8650.dtsi            |    2 +-
>   dts/upstream/src/arm/vt8500/wm8750.dtsi            |    4 +-
>   dts/upstream/src/arm/vt8500/wm8850-w70v2.dts       |    2 +-
>   dts/upstream/src/arm/vt8500/wm8850.dtsi            |    4 +-
>   dts/upstream/src/arm64/airoha/en7581-evb.dts       |   26 +
>   dts/upstream/src/arm64/airoha/en7581.dtsi          |  154 +
>   .../src/arm64/allwinner/sun50i-a64-pine64-lts.dts  |    2 +-
>   .../src/arm64/allwinner/sun50i-a64-pine64-plus.dts |    2 +-
>   .../src/arm64/allwinner/sun50i-a64-pine64.dts      |    2 +-
>   .../src/arm64/allwinner/sun50i-a64-pinebook.dts    |    2 +-
>   .../allwinner/sun50i-a64-pinetab-early-adopter.dts |    2 +-
>   .../src/arm64/allwinner/sun50i-a64-pinetab.dts     |    2 +-
>   .../allwinner/sun50i-a64-sopine-baseboard.dts      |    2 +-
>   dts/upstream/src/arm64/allwinner/sun50i-a64.dtsi   |   37 +-
>   .../arm64/allwinner/sun50i-h6-pine-h64-model-b.dts |    2 +-
>   .../src/arm64/allwinner/sun50i-h6-pine-h64.dts     |    2 +-
>   dts/upstream/src/arm64/allwinner/sun50i-h6.dtsi    |   37 +
>   .../src/arm64/allwinner/sun50i-h616-cpu-opp.dtsi   |   25 +-
>   dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi  |   77 +
>   .../allwinner/sun50i-h700-anbernic-rg35xx-2024.dts |    4 +-
>   .../allwinner/sun50i-h700-anbernic-rg35xx-h.dts    |   79 +
>   .../src/arm64/altera/socfpga_stratix10.dtsi        |   10 +
>   .../src/arm64/altera/socfpga_stratix10_socdk.dts   |    2 -
>   .../arm64/altera/socfpga_stratix10_socdk_nand.dts  |    2 -
>   dts/upstream/src/arm64/amlogic/amlogic-a4.dtsi     |   10 +
>   dts/upstream/src/arm64/amlogic/amlogic-c3.dtsi     |    3 +-
>   dts/upstream/src/arm64/amlogic/meson-a1-ad402.dts  |   45 +
>   dts/upstream/src/arm64/amlogic/meson-a1.dtsi       |   16 +-
>   dts/upstream/src/arm64/amlogic/meson-axg.dtsi      |   24 +-
>   .../src/arm64/amlogic/meson-g12-common.dtsi        |  438 +-
>   dts/upstream/src/arm64/amlogic/meson-g12.dtsi      |    4 +
>   dts/upstream/src/arm64/amlogic/meson-g12a-u200.dts |    2 +-
>   .../src/arm64/amlogic/meson-g12b-bananapi.dtsi     |   14 -
>   .../src/arm64/amlogic/meson-g12b-dreambox-one.dts  |   17 +
>   .../src/arm64/amlogic/meson-g12b-dreambox-two.dts  |   20 +
>   .../src/arm64/amlogic/meson-g12b-dreambox.dtsi     |  154 +
>   .../src/arm64/amlogic/meson-g12b-odroid-n2.dtsi    |   36 +-
>   .../src/arm64/amlogic/meson-g12b-radxa-zero2.dts   |   24 +
>   .../src/arm64/amlogic/meson-gxbb-odroidc2.dts      |    2 +-
>   dts/upstream/src/arm64/amlogic/meson-gxbb.dtsi     |   10 +-
>   .../src/arm64/amlogic/meson-gxl-s905x-vero4k.dts   |  199 +
>   dts/upstream/src/arm64/amlogic/meson-gxl.dtsi      |   10 +-
>   .../src/arm64/amlogic/meson-gxlx-s905l-p271.dts    |   51 +
>   dts/upstream/src/arm64/amlogic/meson-s4.dtsi       |  199 +
>   dts/upstream/src/arm64/amlogic/meson-sm1.dtsi      |   44 +-
>   dts/upstream/src/arm64/apm/apm-merlin.dts          |    2 +-
>   dts/upstream/src/arm64/apm/apm-mustang.dts         |    2 +-
>   dts/upstream/src/arm64/arm/corstone1000-fvp.dts    |    2 +-
>   dts/upstream/src/arm64/arm/corstone1000.dtsi       |    6 +-
>   dts/upstream/src/arm64/arm/foundation-v8.dtsi      |    6 +-
>   dts/upstream/src/arm64/arm/fvp-base-revc.dts       |    1 +
>   dts/upstream/src/arm64/arm/juno-base.dtsi          |    1 -
>   dts/upstream/src/arm64/arm/juno-clocks.dtsi        |   10 +-
>   dts/upstream/src/arm64/arm/juno-motherboard.dtsi   |   13 +-
>   .../src/arm64/arm/rtsm_ve-motherboard.dtsi         |   10 +-
>   .../src/arm64/arm/vexpress-v2f-1xv7-ca53x2.dts     |    6 +-
>   dts/upstream/src/arm64/exynos/exynos850.dtsi       |    8 +
>   .../src/arm64/exynos/google/gs101-oriole.dts       |    9 +-
>   dts/upstream/src/arm64/exynos/google/gs101.dtsi    |   22 +-
>   dts/upstream/src/arm64/freescale/fsl-ls1012a.dtsi  |   79 +-
>   .../src/arm64/freescale/fsl-ls1028a-rdb.dts        |   31 +
>   dts/upstream/src/arm64/freescale/fsl-ls1028a.dtsi  |   55 +-
>   .../src/arm64/freescale/fsl-ls1043a-qds.dts        |    2 +-
>   .../src/arm64/freescale/fsl-ls1043a-rdb.dts        |   20 +-
>   dts/upstream/src/arm64/freescale/fsl-ls1043a.dtsi  |  138 +-
>   .../src/arm64/freescale/fsl-ls1046a-qds.dts        |    2 +-
>   dts/upstream/src/arm64/freescale/fsl-ls1046a.dtsi  |   49 +-
>   .../src/arm64/freescale/fsl-ls1088a-qds.dts        |    2 +-
>   dts/upstream/src/arm64/freescale/fsl-ls1088a.dtsi  |   72 +-
>   dts/upstream/src/arm64/freescale/fsl-ls2080a.dtsi  |    2 +-
>   dts/upstream/src/arm64/freescale/fsl-ls2088a.dtsi  |    2 +-
>   .../src/arm64/freescale/fsl-ls208xa-qds.dtsi       |    2 +-
>   .../src/arm64/freescale/fsl-ls208xa-rdb.dtsi       |    2 +-
>   dts/upstream/src/arm64/freescale/fsl-ls208xa.dtsi  |  186 +-
>   dts/upstream/src/arm64/freescale/fsl-lx2160a.dtsi  |   56 +-
>   .../src/arm64/freescale/imx8-ss-audio.dtsi         |    1 -
>   dts/upstream/src/arm64/freescale/imx8-ss-cm41.dtsi |   68 +
>   dts/upstream/src/arm64/freescale/imx8-ss-conn.dtsi |   69 +
>   dts/upstream/src/arm64/freescale/imx8dxl-evk.dts   |  277 +
>   .../src/arm64/freescale/imx8dxl-ss-adma.dtsi       |   78 +
>   .../src/arm64/freescale/imx8dxl-ss-conn.dtsi       |   11 +
>   dts/upstream/src/arm64/freescale/imx8mm-evk.dtsi   |    2 +-
>   .../src/arm64/freescale/imx8mm-iot-gateway.dts     |  218 +
>   .../imx8mm-phygate-tauri-l-rs232-rs232.dtso        |   72 +
>   .../imx8mm-phygate-tauri-l-rs232-rs485.dtso        |   76 +
>   .../imx8mm-phygate-tauri-l-rs232-rts-cts.dtso      |   41 +
>   .../src/arm64/freescale/imx8mm-phygate-tauri-l.dts |   10 +
>   .../src/arm64/freescale/imx8mm-tqma8mqml.dtsi      |    8 +-
>   .../src/arm64/freescale/imx8mm-ucm-som.dtsi        |  679 ++
>   .../src/arm64/freescale/imx8mm-venice-gw700x.dtsi  |   20 +
>   .../src/arm64/freescale/imx8mm-venice-gw7901.dts   |    2 -
>   .../src/arm64/freescale/imx8mm-venice-gw7902.dts   |    2 -
>   .../src/arm64/freescale/imx8mm-venice-gw7903.dts   |    2 -
>   .../src/arm64/freescale/imx8mm-venice-gw7904.dts   |    2 -
>   .../src/arm64/freescale/imx8mm-verdin.dtsi         |   20 +-
>   .../src/arm64/freescale/imx8mn-tqma8mqnl.dtsi      |    8 +-
>   .../src/arm64/freescale/imx8mn-venice-gw7902.dts   |    2 -
>   .../src/arm64/freescale/imx8mp-beacon-kit.dts      |   24 +-
>   .../src/arm64/freescale/imx8mp-beacon-som.dtsi     |    2 -
>   .../src/arm64/freescale/imx8mp-debix-model-a.dts   |   47 +
>   .../src/arm64/freescale/imx8mp-dhcom-pdk2.dts      |   39 +
>   .../src/arm64/freescale/imx8mp-dhcom-pdk3.dts      |   39 +
>   .../src/arm64/freescale/imx8mp-dhcom-som.dtsi      |   13 +-
>   .../arm64/freescale/imx8mp-evk-mx8-dlvds-lcd1.dtso |   77 +
>   dts/upstream/src/arm64/freescale/imx8mp-evk.dts    |   91 +-
>   .../src/arm64/freescale/imx8mp-msc-sm2s-ep1.dts    |   27 +
>   .../freescale/imx8mp-tqma8mpql-mba8mp-ras314.dts   |  906 +++
>   .../arm64/freescale/imx8mp-tqma8mpql-mba8mpxl.dts  |    5 -
>   .../src/arm64/freescale/imx8mp-tqma8mpql.dtsi      |    8 +-
>   .../src/arm64/freescale/imx8mp-venice-gw702x.dtsi  |   20 +
>   .../src/arm64/freescale/imx8mp-venice-gw74xx.dts   |   24 +
>   .../src/arm64/freescale/imx8mp-verdin-dahlia.dtsi  |   37 +
>   .../src/arm64/freescale/imx8mp-verdin-dev.dtsi     |   37 +
>   .../src/arm64/freescale/imx8mp-verdin-mallow.dtsi  |   37 +
>   .../src/arm64/freescale/imx8mp-verdin-nonwifi.dtsi |    3 +-
>   .../src/arm64/freescale/imx8mp-verdin-wifi.dtsi    |    3 +-
>   .../src/arm64/freescale/imx8mp-verdin-yavia.dtsi   |   37 +
>   .../src/arm64/freescale/imx8mp-verdin.dtsi         |   18 +-
>   dts/upstream/src/arm64/freescale/imx8mp.dtsi       |  120 +-
>   .../src/arm64/freescale/imx8mq-librem5.dtsi        |    2 -
>   .../src/arm64/freescale/imx8mq-tqma8mq.dtsi        |    8 +-
>   dts/upstream/src/arm64/freescale/imx8qm-mek.dts    |  344 +
>   .../src/arm64/freescale/imx8qm-ss-audio.dtsi       |  473 ++
>   dts/upstream/src/arm64/freescale/imx8qm.dtsi       |  103 +
>   dts/upstream/src/arm64/freescale/imx8qxp-mek.dts   |    1 +
>   .../src/arm64/freescale/imx93-11x11-evk.dts        |  309 +-
>   dts/upstream/src/arm64/freescale/imx93-9x9-qsb.dts |  492 ++
>   .../arm64/freescale/imx93-tqma9352-mba93xxca.dts   |   73 +-
>   .../arm64/freescale/imx93-tqma9352-mba93xxla.dts   |   63 +-
>   .../src/arm64/freescale/imx93-tqma9352.dtsi        |    9 +-
>   dts/upstream/src/arm64/freescale/imx93.dtsi        |    2 +-
>   .../src/arm64/freescale/imx95-19x19-evk.dts        |  289 +
>   dts/upstream/src/arm64/freescale/imx95-clock.h     |  187 +
>   dts/upstream/src/arm64/freescale/imx95-pinfunc.h   |  865 +++
>   dts/upstream/src/arm64/freescale/imx95-power.h     |   47 +
>   dts/upstream/src/arm64/freescale/imx95.dtsi        | 1192 ++++
>   .../src/arm64/freescale/qoriq-fman3-0-10g-0.dtsi   |    2 +-
>   .../src/arm64/freescale/qoriq-fman3-0-10g-1.dtsi   |    2 +-
>   .../src/arm64/freescale/qoriq-fman3-0-1g-0.dtsi    |    2 +-
>   .../src/arm64/freescale/qoriq-fman3-0-1g-1.dtsi    |    2 +-
>   .../src/arm64/freescale/qoriq-fman3-0-1g-2.dtsi    |    2 +-
>   .../src/arm64/freescale/qoriq-fman3-0-1g-3.dtsi    |    2 +-
>   .../src/arm64/freescale/qoriq-fman3-0-1g-4.dtsi    |    2 +-
>   .../src/arm64/freescale/qoriq-fman3-0-1g-5.dtsi    |    2 +-
>   .../src/arm64/freescale/qoriq-fman3-0.dtsi         |    4 +-
>   dts/upstream/src/arm64/freescale/tqma8xx.dtsi      |    8 +-
>   dts/upstream/src/arm64/hisilicon/hi3660.dtsi       |    2 +-
>   .../src/arm64/intel/socfpga_agilex_socdk.dts       |    2 -
>   dts/upstream/src/arm64/intel/socfpga_n5x_socdk.dts |    2 -
>   .../src/arm64/marvell/armada-3720-gl-mv1000.dts    |    8 +-
>   dts/upstream/src/arm64/marvell/cn9130-cf-base.dts  |  178 +
>   dts/upstream/src/arm64/marvell/cn9130-cf-pro.dts   |  375 ++
>   dts/upstream/src/arm64/marvell/cn9130-cf.dtsi      |  197 +
>   dts/upstream/src/arm64/marvell/cn9130-sr-som.dtsi  |  160 +
>   .../src/arm64/marvell/cn9131-cf-solidwan.dts       |  637 ++
>   dts/upstream/src/arm64/marvell/cn9132-clearfog.dts |  673 ++
>   dts/upstream/src/arm64/marvell/cn9132-sr-cex7.dtsi |  712 ++
>   dts/upstream/src/arm64/mediatek/mt2712-evb.dts     |    4 +-
>   .../src/arm64/mediatek/mt6795-sony-xperia-m5.dts   |    8 +-
>   .../src/arm64/mediatek/mt7622-bananapi-bpi-r64.dts |    8 +-
>   dts/upstream/src/arm64/mediatek/mt7622-rfb1.dts    |    4 +-
>   .../src/arm64/mediatek/mt7981b-cudy-wr3000-v1.dts  |   74 +
>   .../src/arm64/mediatek/mt7981b-openwrt-one.dts     |   15 +
>   dts/upstream/src/arm64/mediatek/mt7981b.dtsi       |   78 +-
>   .../mediatek/mt7986a-bananapi-bpi-r3-emmc.dtso     |   28 +-
>   .../mediatek/mt7986a-bananapi-bpi-r3-mini.dts      |  493 ++
>   .../mediatek/mt7986a-bananapi-bpi-r3-nand.dtso     |   66 +-
>   .../mediatek/mt7986a-bananapi-bpi-r3-nor.dtso      |   78 +-
>   .../arm64/mediatek/mt7986a-bananapi-bpi-r3-sd.dtso |   16 +-
>   dts/upstream/src/arm64/mediatek/mt7988a.dtsi       |   90 +-
>   .../src/arm64/mediatek/mt8173-elm-hana.dtsi        |    9 +
>   dts/upstream/src/arm64/mediatek/mt8173-elm.dtsi    |    6 -
>   dts/upstream/src/arm64/mediatek/mt8173-evb.dts     |   12 +-
>   dts/upstream/src/arm64/mediatek/mt8183-evb.dts     |    6 -
>   .../arm64/mediatek/mt8183-kukui-audio-da7219.dtsi  |    2 +-
>   .../arm64/mediatek/mt8183-kukui-jacuzzi-cozmo.dts  |    1 +
>   .../mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts  |    1 +
>   .../mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts  |    1 +
>   .../mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts  |    1 +
>   .../mt8183-kukui-jacuzzi-fennel14-sku2.dts         |    1 +
>   .../mediatek/mt8183-kukui-jacuzzi-fennel14.dts     |    1 +
>   .../arm64/mediatek/mt8183-kukui-jacuzzi-kappa.dts  |    1 +
>   .../arm64/mediatek/mt8183-kukui-jacuzzi-kenzo.dts  |    1 +
>   .../mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts  |    2 +-
>   .../mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts  |    2 +-
>   .../arm64/mediatek/mt8183-kukui-jacuzzi-pico6.dts  |   14 +-
>   .../mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts  |    1 +
>   .../mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts  |    1 +
>   .../src/arm64/mediatek/mt8183-kukui-jacuzzi.dtsi   |   25 +-
>   .../arm64/mediatek/mt8183-kukui-kodama-sku32.dts   |    1 +
>   dts/upstream/src/arm64/mediatek/mt8183-kukui.dtsi  |   18 +-
>   dts/upstream/src/arm64/mediatek/mt8183-pumpkin.dts |   10 +-
>   dts/upstream/src/arm64/mediatek/mt8183.dtsi        |  136 +-
>   .../mediatek/mt8186-corsola-voltorb-sku589824.dts  |   13 +
>   .../mediatek/mt8186-corsola-voltorb-sku589825.dts  |   25 +
>   .../src/arm64/mediatek/mt8186-corsola-voltorb.dtsi |  103 +
>   .../src/arm64/mediatek/mt8186-corsola.dtsi         |   42 +-
>   dts/upstream/src/arm64/mediatek/mt8188.dtsi        |  480 ++
>   .../arm64/mediatek/mt8192-asurada-hayato-r1.dts    |    1 +
>   .../mediatek/mt8192-asurada-hayato-r5-sku2.dts     |    1 +
>   .../arm64/mediatek/mt8192-asurada-spherion-r0.dts  |    1 +
>   .../arm64/mediatek/mt8192-asurada-spherion-r4.dts  |    1 +
>   .../src/arm64/mediatek/mt8192-asurada.dtsi         |    1 +
>   dts/upstream/src/arm64/mediatek/mt8192.dtsi        |    2 +-
>   .../src/arm64/mediatek/mt8195-cherry-dojo-r1.dts   |  114 +
>   dts/upstream/src/arm64/mediatek/mt8195-cherry.dtsi |   50 +
>   dts/upstream/src/arm64/mediatek/mt8195-demo.dts    |   26 +-
>   dts/upstream/src/arm64/mediatek/mt8195-evb.dts     |    4 +-
>   dts/upstream/src/arm64/mediatek/mt8195.dtsi        |    2 +-
>   dts/upstream/src/arm64/mediatek/mt8365-evk.dts     |    4 +-
>   dts/upstream/src/arm64/mediatek/mt8365.dtsi        |    3 +-
>   .../src/arm64/mediatek/mt8390-genio-700-evk.dts    |  880 +++
>   .../src/arm64/mediatek/mt8395-genio-1200-evk.dts   |   34 +-
>   .../mediatek/mt8395-kontron-3-5-sbc-i1200.dts      | 1127 ++++
>   .../src/arm64/mediatek/mt8395-radxa-nio-12l.dts    |   88 +-
>   .../src/arm64/microchip/sparx5_pcb134_board.dtsi   |  372 +-
>   .../src/arm64/microchip/sparx5_pcb135_board.dtsi   |   95 +-
>   .../nvidia/tegra234-p3768-0000+p3767-0000.dts      |   77 +-
>   .../nvidia/tegra234-p3768-0000+p3767-0005.dts      |   31 +-
>   ...68-0000.dtsi => tegra234-p3768-0000+p3767.dtsi} |   28 +-
>   .../src/arm64/qcom/apq8016-schneider-hmibsc.dts    |  491 ++
>   .../arm64/qcom/ipq5018-tplink-archer-ax55-v1.dts   |  128 +
>   dts/upstream/src/arm64/qcom/ipq5018.dtsi           |    1 -
>   dts/upstream/src/arm64/qcom/ipq5332.dtsi           |    5 +-
>   dts/upstream/src/arm64/qcom/ipq6018.dtsi           |   28 +-
>   dts/upstream/src/arm64/qcom/ipq8074.dtsi           |   16 +-
>   dts/upstream/src/arm64/qcom/ipq9574.dtsi           |   39 +-
>   .../src/arm64/qcom/msm8216-samsung-fortuna3g.dts   |   14 +
>   .../src/arm64/qcom/msm8916-acer-a1-724.dts         |   26 +
>   .../src/arm64/qcom/msm8916-gplus-fl8005a.dts       |   47 +
>   dts/upstream/src/arm64/qcom/msm8916-lg-c50.dts     |  140 +
>   dts/upstream/src/arm64/qcom/msm8916-lg-m216.dts    |  251 +
>   .../src/arm64/qcom/msm8916-motorola-common.dtsi    |  161 +
>   .../src/arm64/qcom/msm8916-motorola-harpia.dts     |  147 +
>   .../src/arm64/qcom/msm8916-motorola-osprey.dts     |  105 +
>   .../src/arm64/qcom/msm8916-motorola-surnia.dts     |   83 +
>   .../arm64/qcom/msm8916-samsung-a2015-common.dtsi   |   53 +-
>   .../src/arm64/qcom/msm8916-samsung-a3u-eur.dts     |    6 +
>   .../src/arm64/qcom/msm8916-samsung-a5u-eur.dts     |    6 +
>   dts/upstream/src/arm64/qcom/msm8916-samsung-e5.dts |    6 +
>   dts/upstream/src/arm64/qcom/msm8916-samsung-e7.dts |    7 +
>   .../arm64/qcom/msm8916-samsung-fortuna-common.dtsi |  197 +
>   .../arm64/qcom/msm8916-samsung-gprimeltecan.dts    |   70 +
>   .../src/arm64/qcom/msm8916-samsung-grandmax.dts    |    6 +
>   .../arm64/qcom/msm8916-samsung-grandprimelte.dts   |   14 +
>   .../arm64/qcom/msm8916-samsung-rossa-common.dtsi   |   18 +
>   .../src/arm64/qcom/msm8916-samsung-rossa.dts       |    6 +
>   dts/upstream/src/arm64/qcom/msm8916.dtsi           |   18 +-
>   dts/upstream/src/arm64/qcom/msm8939-samsung-a7.dts |   56 +-
>   dts/upstream/src/arm64/qcom/msm8939.dtsi           |   16 +-
>   .../src/arm64/qcom/msm8953-motorola-potter.dts     |    1 +
>   .../src/arm64/qcom/msm8953-xiaomi-daisy.dts        |    1 +
>   .../src/arm64/qcom/msm8953-xiaomi-mido.dts         |    1 +
>   .../src/arm64/qcom/msm8953-xiaomi-tissot.dts       |    1 +
>   .../src/arm64/qcom/msm8953-xiaomi-vince.dts        |    1 +
>   dts/upstream/src/arm64/qcom/msm8953.dtsi           |   30 +-
>   dts/upstream/src/arm64/qcom/msm8956.dtsi           |    4 +-
>   dts/upstream/src/arm64/qcom/msm8976.dtsi           |  579 +-
>   dts/upstream/src/arm64/qcom/msm8994.dtsi           |   14 +-
>   .../src/arm64/qcom/msm8996-xiaomi-common.dtsi      |    1 -
>   dts/upstream/src/arm64/qcom/msm8996.dtsi           |  104 +-
>   dts/upstream/src/arm64/qcom/msm8998.dtsi           |   70 +-
>   dts/upstream/src/arm64/qcom/pm6125.dtsi            |    1 -
>   dts/upstream/src/arm64/qcom/pm6150.dtsi            |    8 +-
>   dts/upstream/src/arm64/qcom/pm6150l.dtsi           |    3 -
>   dts/upstream/src/arm64/qcom/pm6350.dtsi            |    1 -
>   dts/upstream/src/arm64/qcom/pm660.dtsi             |   26 +-
>   dts/upstream/src/arm64/qcom/pm660l.dtsi            |    1 -
>   dts/upstream/src/arm64/qcom/pm7250b.dtsi           |   47 +-
>   dts/upstream/src/arm64/qcom/pm7325.dtsi            |    2 +-
>   dts/upstream/src/arm64/qcom/pm7550ba.dtsi          |    1 -
>   dts/upstream/src/arm64/qcom/pm8010.dtsi            |    2 -
>   dts/upstream/src/arm64/qcom/pm8150.dtsi            |    1 -
>   dts/upstream/src/arm64/qcom/pm8150b.dtsi           |    1 -
>   dts/upstream/src/arm64/qcom/pm8150l.dtsi           |    1 -
>   dts/upstream/src/arm64/qcom/pm8350.dtsi            |    2 +-
>   dts/upstream/src/arm64/qcom/pm8350b.dtsi           |    2 +-
>   dts/upstream/src/arm64/qcom/pm8350c.dtsi           |    2 +-
>   dts/upstream/src/arm64/qcom/pm8450.dtsi            |    1 -
>   dts/upstream/src/arm64/qcom/pm8550.dtsi            |    1 -
>   dts/upstream/src/arm64/qcom/pm8550b.dtsi           |    1 -
>   dts/upstream/src/arm64/qcom/pm8550ve.dtsi          |    1 -
>   dts/upstream/src/arm64/qcom/pm8550vs.dtsi          |    4 -
>   dts/upstream/src/arm64/qcom/pm8916.dtsi            |   31 +-
>   dts/upstream/src/arm64/qcom/pm8953.dtsi            |    3 -
>   dts/upstream/src/arm64/qcom/pm8994.dtsi            |    1 -
>   dts/upstream/src/arm64/qcom/pm8998.dtsi            |    1 -
>   dts/upstream/src/arm64/qcom/pmi632.dtsi            |    7 +-
>   dts/upstream/src/arm64/qcom/pmi8950.dtsi           |    8 +
>   dts/upstream/src/arm64/qcom/pmm8155au_1.dtsi       |    1 -
>   dts/upstream/src/arm64/qcom/pmm8155au_2.dtsi       |    1 -
>   dts/upstream/src/arm64/qcom/pmr735a.dtsi           |    2 +-
>   dts/upstream/src/arm64/qcom/pmr735b.dtsi           |    2 +-
>   dts/upstream/src/arm64/qcom/pmr735d_a.dtsi         |    1 -
>   dts/upstream/src/arm64/qcom/pmr735d_b.dtsi         |    1 -
>   dts/upstream/src/arm64/qcom/pms405.dtsi            |    1 -
>   dts/upstream/src/arm64/qcom/pmx75.dtsi             |    1 -
>   dts/upstream/src/arm64/qcom/qcm2290.dtsi           |  184 +-
>   .../src/arm64/qcom/qcm6490-fairphone-fp5.dts       |  157 +-
>   dts/upstream/src/arm64/qcom/qcm6490-idp.dts        |    2 +-
>   .../src/arm64/qcom/qcm6490-shift-otter.dts         |  961 +++
>   dts/upstream/src/arm64/qcom/qcs404.dtsi            |   20 +-
>   dts/upstream/src/arm64/qcom/qcs6490-rb3gen2.dts    |  111 +-
>   .../src/arm64/qcom/qcs8550-aim300-aiot.dts         |  315 +
>   dts/upstream/src/arm64/qcom/qcs8550-aim300.dtsi    |  405 ++
>   dts/upstream/src/arm64/qcom/qcs8550.dtsi           |  162 +
>   dts/upstream/src/arm64/qcom/qdu1000-idp.dts        |   23 +
>   dts/upstream/src/arm64/qcom/qdu1000.dtsi           |  137 +
>   dts/upstream/src/arm64/qcom/qrb2210-rb1.dts        |   21 +-
>   dts/upstream/src/arm64/qcom/qrb4210-rb2.dts        |   17 +-
>   dts/upstream/src/arm64/qcom/qrb5165-rb5.dts        |  122 +-
>   dts/upstream/src/arm64/qcom/qru1000-idp.dts        |   23 +
>   dts/upstream/src/arm64/qcom/sa8155p.dtsi           |    4 +
>   dts/upstream/src/arm64/qcom/sa8775p-pmics.dtsi     |    8 +-
>   dts/upstream/src/arm64/qcom/sa8775p-ride-r3.dts    |   47 +
>   dts/upstream/src/arm64/qcom/sa8775p-ride.dts       |  836 +--
>   dts/upstream/src/arm64/qcom/sa8775p-ride.dtsi      |  814 +++
>   dts/upstream/src/arm64/qcom/sa8775p.dtsi           | 1144 +++-
>   .../src/arm64/qcom/sc7180-trogdor-clamshell.dtsi   |    9 +
>   .../src/arm64/qcom/sc7180-trogdor-coachz.dtsi      |    6 +-
>   .../src/arm64/qcom/sc7180-trogdor-detachable.dtsi  |   13 +
>   .../src/arm64/qcom/sc7180-trogdor-homestar.dtsi    |   10 +-
>   .../src/arm64/qcom/sc7180-trogdor-kingoftown.dts   |    2 +-
>   .../src/arm64/qcom/sc7180-trogdor-lazor-r1-kb.dts  |    2 +-
>   .../src/arm64/qcom/sc7180-trogdor-lazor-r1-lte.dts |    2 +-
>   .../src/arm64/qcom/sc7180-trogdor-lazor-r10-kb.dts |    2 +-
>   .../arm64/qcom/sc7180-trogdor-lazor-r10-lte.dts    |    2 +-
>   .../src/arm64/qcom/sc7180-trogdor-lazor-r3-kb.dts  |    2 +-
>   .../src/arm64/qcom/sc7180-trogdor-lazor-r3-lte.dts |    2 +-
>   .../src/arm64/qcom/sc7180-trogdor-lazor-r9-kb.dts  |    2 +-
>   .../src/arm64/qcom/sc7180-trogdor-lazor-r9-lte.dts |    2 +-
>   .../src/arm64/qcom/sc7180-trogdor-lazor.dtsi       |    3 +-
>   .../src/arm64/qcom/sc7180-trogdor-pazquel.dtsi     |    5 +-
>   .../src/arm64/qcom/sc7180-trogdor-pompom.dtsi      |    6 +-
>   .../arm64/qcom/sc7180-trogdor-quackingstick.dtsi   |   15 +-
>   dts/upstream/src/arm64/qcom/sc7180-trogdor-r1.dts  |    3 +-
>   .../src/arm64/qcom/sc7180-trogdor-wormdingler.dtsi |    6 +-
>   dts/upstream/src/arm64/qcom/sc7180-trogdor.dtsi    |    8 +-
>   dts/upstream/src/arm64/qcom/sc7180.dtsi            |   29 +-
>   dts/upstream/src/arm64/qcom/sc7280-idp.dtsi        |    1 -
>   dts/upstream/src/arm64/qcom/sc7280-qcard.dtsi      |    1 -
>   dts/upstream/src/arm64/qcom/sc7280.dtsi            |  226 +-
>   .../src/arm64/qcom/sc8180x-lenovo-flex-5g.dts      |   16 +-
>   dts/upstream/src/arm64/qcom/sc8180x-pmics.dtsi     |    2 -
>   dts/upstream/src/arm64/qcom/sc8180x-primus.dts     |   20 +-
>   dts/upstream/src/arm64/qcom/sc8180x.dtsi           |  252 +-
>   dts/upstream/src/arm64/qcom/sc8280xp-crd.dts       |   20 +-
>   .../arm64/qcom/sc8280xp-lenovo-thinkpad-x13s.dts   |  145 +-
>   dts/upstream/src/arm64/qcom/sc8280xp-pmics.dtsi    |    4 +-
>   dts/upstream/src/arm64/qcom/sc8280xp.dtsi          |   82 +-
>   .../src/arm64/qcom/sda660-inforce-ifc6560.dts      |   15 +
>   .../src/arm64/qcom/sdm450-lenovo-tbx605f.dts       |  276 +
>   .../src/arm64/qcom/sdm450-motorola-ali.dts         |    1 +
>   dts/upstream/src/arm64/qcom/sdm630.dtsi            |   30 +-
>   .../src/arm64/qcom/sdm632-fairphone-fp3.dts        |    4 +
>   .../src/arm64/qcom/sdm632-motorola-ocean.dts       |    1 +
>   dts/upstream/src/arm64/qcom/sdm670.dtsi            |   18 +
>   dts/upstream/src/arm64/qcom/sdm845-mtp.dts         |   12 -
>   dts/upstream/src/arm64/qcom/sdm845.dtsi            |  179 +-
>   .../src/arm64/qcom/sdm850-lenovo-yoga-c630.dts     |   77 +
>   dts/upstream/src/arm64/qcom/sdx75-idp.dts          |   45 +
>   dts/upstream/src/arm64/qcom/sdx75.dtsi             |  583 +-
>   .../src/arm64/qcom/sm4250-oneplus-billie2.dts      |    1 +
>   dts/upstream/src/arm64/qcom/sm4450.dtsi            |   48 +-
>   dts/upstream/src/arm64/qcom/sm6115-fxtec-pro1x.dts |    1 +
>   dts/upstream/src/arm64/qcom/sm6115.dtsi            |   45 +-
>   .../src/arm64/qcom/sm6115p-lenovo-j606f.dts        |    1 +
>   .../arm64/qcom/sm6125-sony-xperia-seine-pdx201.dts |    8 -
>   .../src/arm64/qcom/sm6125-xiaomi-laurel-sprout.dts |    6 -
>   dts/upstream/src/arm64/qcom/sm6125.dtsi            |    8 +-
>   .../arm64/qcom/sm6350-sony-xperia-lena-pdx213.dts  |    3 +-
>   dts/upstream/src/arm64/qcom/sm6350.dtsi            |  148 +-
>   .../qcom/sm6375-sony-xperia-murray-pdx225.dts      |    2 +-
>   dts/upstream/src/arm64/qcom/sm6375.dtsi            |   78 -
>   .../src/arm64/qcom/sm7225-fairphone-fp4.dts        |  417 +-
>   dts/upstream/src/arm64/qcom/sm8150-hdk.dts         |   17 +-
>   dts/upstream/src/arm64/qcom/sm8150.dtsi            |   74 +-
>   dts/upstream/src/arm64/qcom/sm8250-mtp.dts         |   14 -
>   .../src/arm64/qcom/sm8250-sony-xperia-edo.dtsi     |    2 +-
>   .../src/arm64/qcom/sm8250-xiaomi-elish-common.dtsi |    8 +-
>   dts/upstream/src/arm64/qcom/sm8250.dtsi            |   83 +-
>   dts/upstream/src/arm64/qcom/sm8350-hdk.dts         |   27 +-
>   dts/upstream/src/arm64/qcom/sm8350.dtsi            |   82 +-
>   dts/upstream/src/arm64/qcom/sm8450-hdk.dts         |   43 +-
>   .../src/arm64/qcom/sm8450-sony-xperia-nagara.dtsi  |    2 +-
>   dts/upstream/src/arm64/qcom/sm8450.dtsi            |  245 +-
>   dts/upstream/src/arm64/qcom/sm8550-hdk.dts         |   26 +-
>   dts/upstream/src/arm64/qcom/sm8550-mtp.dts         |   26 +-
>   dts/upstream/src/arm64/qcom/sm8550-qrd.dts         |  134 +-
>   dts/upstream/src/arm64/qcom/sm8550-samsung-q5q.dts |  593 ++
>   .../arm64/qcom/sm8550-sony-xperia-yodo-pdx234.dts  |   14 -
>   dts/upstream/src/arm64/qcom/sm8550.dtsi            |  335 +-
>   .../src/arm64/qcom/sm8650-hdk-display-card.dtso    |  141 +
>   dts/upstream/src/arm64/qcom/sm8650-hdk.dts         | 1355 ++++
>   dts/upstream/src/arm64/qcom/sm8650-mtp.dts         |   34 +-
>   dts/upstream/src/arm64/qcom/sm8650-qrd.dts         |  128 +-
>   dts/upstream/src/arm64/qcom/sm8650.dtsi            |  327 +-
>   .../src/arm64/qcom/x1e80100-asus-vivobook-s15.dts  |  652 ++
>   dts/upstream/src/arm64/qcom/x1e80100-crd.dts       |  256 +-
>   .../src/arm64/qcom/x1e80100-lenovo-yoga-slim7x.dts |  967 +++
>   dts/upstream/src/arm64/qcom/x1e80100-pmics.dtsi    |  482 ++
>   dts/upstream/src/arm64/qcom/x1e80100-qcp.dts       |  395 +-
>   dts/upstream/src/arm64/qcom/x1e80100.dtsi          | 1851 +++++-
>   dts/upstream/src/arm64/renesas/condor-common.dtsi  |    6 +
>   dts/upstream/src/arm64/renesas/r8a774a1.dtsi       |    1 +
>   dts/upstream/src/arm64/renesas/r8a774b1.dtsi       |    1 +
>   dts/upstream/src/arm64/renesas/r8a774c0.dtsi       |    1 +
>   dts/upstream/src/arm64/renesas/r8a774e1.dtsi       |    1 +
>   dts/upstream/src/arm64/renesas/r8a77951.dtsi       |    1 +
>   dts/upstream/src/arm64/renesas/r8a77960.dtsi       |    1 +
>   dts/upstream/src/arm64/renesas/r8a77961.dtsi       |    1 +
>   dts/upstream/src/arm64/renesas/r8a77965.dtsi       |    1 +
>   dts/upstream/src/arm64/renesas/r8a77970.dtsi       |    1 +
>   dts/upstream/src/arm64/renesas/r8a77980-condor.dts |    8 -
>   dts/upstream/src/arm64/renesas/r8a77980.dtsi       |    1 +
>   dts/upstream/src/arm64/renesas/r8a77990.dtsi       |    1 +
>   dts/upstream/src/arm64/renesas/r8a77995.dtsi       |    1 +
>   dts/upstream/src/arm64/renesas/r8a779a0.dtsi       |    5 +-
>   .../src/arm64/renesas/r8a779f0-spider-cpu.dtsi     |    6 +
>   dts/upstream/src/arm64/renesas/r8a779f0.dtsi       |    5 +-
>   dts/upstream/src/arm64/renesas/r8a779f4-s4sk.dts   |    6 +
>   .../r8a779g0-white-hawk-ard-audio-da7212.dtso      |    4 -
>   dts/upstream/src/arm64/renesas/r8a779g0.dtsi       |   28 +-
>   .../arm64/renesas/r8a779h0-gray-hawk-single.dts    |    4 +
>   dts/upstream/src/arm64/renesas/r8a779h0.dtsi       |  737 ++-
>   dts/upstream/src/arm64/renesas/r9a07g043.dtsi      |    4 +-
>   dts/upstream/src/arm64/renesas/r9a07g043u.dtsi     |    5 +-
>   dts/upstream/src/arm64/renesas/r9a07g044.dtsi      |    9 +-
>   dts/upstream/src/arm64/renesas/r9a07g054.dtsi      |    9 +-
>   dts/upstream/src/arm64/renesas/r9a08g045.dtsi      |   11 +-
>   dts/upstream/src/arm64/renesas/r9a09g011.dtsi      |    7 +-
>   .../src/arm64/renesas/rz-smarc-common.dtsi         |   11 +-
>   .../src/arm64/renesas/white-hawk-cpu-common.dtsi   |   29 +-
>   .../src/arm64/renesas/white-hawk-ethernet.dtsi     |  103 +
>   .../src/arm64/rockchip/rk3328-rock-pi-e.dts        |    2 +-
>   dts/upstream/src/arm64/rockchip/rk3328-rock64.dts  |    2 +
>   dts/upstream/src/arm64/rockchip/rk3328.dtsi        |    4 +-
>   dts/upstream/src/arm64/rockchip/rk3368-lba3368.dts |  659 ++
>   .../src/arm64/rockchip/rk3399-pinephone-pro.dts    |   74 +
>   dts/upstream/src/arm64/rockchip/rk3399-puma.dtsi   |   36 +-
>   dts/upstream/src/arm64/rockchip/rk3399pro.dtsi     |   22 -
>   .../src/arm64/rockchip/rk3566-pinenote.dtsi        |    1 +
>   .../src/arm64/rockchip/rk3566-quartz64-a.dts       |    1 +
>   .../src/arm64/rockchip/rk3566-quartz64-b.dts       |    1 +
>   dts/upstream/src/arm64/rockchip/rk3566-roc-pc.dts  |    2 +-
>   .../src/arm64/rockchip/rk3566-soquartz.dtsi        |    1 +
>   .../src/arm64/rockchip/rk3568-evb1-v10.dts         |    2 +-
>   .../src/arm64/rockchip/rk3568-fastrhino-r66s.dts   |    4 +
>   .../src/arm64/rockchip/rk3568-fastrhino-r66s.dtsi  |   48 +-
>   .../src/arm64/rockchip/rk3568-fastrhino-r68s.dts   |   16 +-
>   dts/upstream/src/arm64/rockchip/rk3568-rock-3a.dts |    4 -
>   dts/upstream/src/arm64/rockchip/rk356x.dtsi        |   20 +-
>   .../src/arm64/rockchip/rk3588-armsom-sige7.dts     |    4 +
>   dts/upstream/src/arm64/rockchip/rk3588-base.dtsi   |   60 +-
>   .../rockchip/rk3588-edgeble-neu6a-common.dtsi      |    4 +
>   .../src/arm64/rockchip/rk3588-evb1-v10.dts         |   16 +
>   dts/upstream/src/arm64/rockchip/rk3588-extra.dtsi  |   35 +
>   .../src/arm64/rockchip/rk3588-ok3588-c.dts         |   10 +-
>   dts/upstream/src/arm64/rockchip/rk3588-opp.dtsi    |  190 +
>   .../src/arm64/rockchip/rk3588-quartzpro64.dts      |   12 +
>   .../src/arm64/rockchip/rk3588-rock-5b-pcie-ep.dtso |   25 +
>   .../arm64/rockchip/rk3588-rock-5b-pcie-srns.dtso   |   16 +
>   dts/upstream/src/arm64/rockchip/rk3588-rock-5b.dts |   57 +-
>   .../src/arm64/rockchip/rk3588-toybrick-x0.dts      |    4 +
>   .../src/arm64/rockchip/rk3588-turing-rk1.dtsi      |    7 +-
>   dts/upstream/src/arm64/rockchip/rk3588.dtsi        |    1 +
>   dts/upstream/src/arm64/rockchip/rk3588j.dtsi       |  141 +
>   .../src/arm64/rockchip/rk3588s-rock-5a.dts         |   17 +
>   dts/upstream/src/arm64/rockchip/rk3588s.dtsi       |    1 +
>   dts/upstream/src/arm64/sprd/ums512.dtsi            |   14 +-
>   dts/upstream/src/arm64/sprd/ums9620.dtsi           |   14 +-
>   dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi   |  100 +
>   dts/upstream/src/arm64/st/stm32mp251.dtsi          |  246 +-
>   dts/upstream/src/arm64/st/stm32mp253.dtsi          |   64 +
>   dts/upstream/src/arm64/st/stm32mp257f-ev1.dts      |   77 +-
>   dts/upstream/src/arm64/ti/k3-am62-lp-sk-nand.dtso  |  116 +
>   dts/upstream/src/arm64/ti/k3-am62-lp-sk.dts        |    4 +
>   dts/upstream/src/arm64/ti/k3-am62-main.dtsi        |   39 +-
>   .../src/arm64/ti/k3-am62-verdin-dahlia.dtsi        |   22 -
>   dts/upstream/src/arm64/ti/k3-am62-verdin-dev.dtsi  |    4 +-
>   dts/upstream/src/arm64/ti/k3-am62-verdin.dtsi      |   10 -
>   dts/upstream/src/arm64/ti/k3-am62-wakeup.dtsi      |    5 +
>   dts/upstream/src/arm64/ti/k3-am62.dtsi             |    2 +
>   dts/upstream/src/arm64/ti/k3-am625-beagleplay.dts  |    2 -
>   .../ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso     |   20 +
>   .../src/arm64/ti/k3-am625-phyboard-lyra-rdk.dts    |  467 +-
>   dts/upstream/src/arm64/ti/k3-am62a-main.dtsi       |   32 +-
>   .../src/arm64/ti/k3-am62a-phycore-som.dtsi         |  330 +
>   dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi     |   11 +-
>   .../src/arm64/ti/k3-am62a7-phyboard-lyra-rdk.dts   |   18 +
>   dts/upstream/src/arm64/ti/k3-am62a7-sk.dts         |   11 +-
>   .../src/arm64/ti/k3-am62p-j722s-common-main.dtsi   | 1062 +++
>   ...62p-mcu.dtsi => k3-am62p-j722s-common-mcu.dtsi} |   13 +-
>   ...mal.dtsi => k3-am62p-j722s-common-thermal.dtsi} |    0
>   ...keup.dtsi => k3-am62p-j722s-common-wakeup.dtsi} |    8 +-
>   dts/upstream/src/arm64/ti/k3-am62p-main.dtsi       | 1088 +--
>   dts/upstream/src/arm64/ti/k3-am62p.dtsi            |    9 +-
>   dts/upstream/src/arm64/ti/k3-am62p5-sk.dts         |   20 +-
>   .../src/arm64/ti/k3-am62x-phyboard-lyra.dtsi       |  475 ++
>   dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi  |   32 +-
>   dts/upstream/src/arm64/ti/k3-am64-main.dtsi        |   24 +
>   dts/upstream/src/arm64/ti/k3-am64-phycore-som.dtsi |   46 +-
>   .../ti/k3-am64-tqma64xxl-mbax4xxl-sdcard.dtso      |    4 +-
>   .../arm64/ti/k3-am64-tqma64xxl-mbax4xxl-wlan.dtso  |    4 +-
>   .../arm64/ti/k3-am642-evm-icssg1-dualemac-mii.dtso |  101 +
>   dts/upstream/src/arm64/ti/k3-am642-evm-nand.dtso   |  148 +
>   dts/upstream/src/arm64/ti/k3-am642-evm.dts         |   15 +
>   .../src/arm64/ti/k3-am642-hummingboard-t.dts       |    1 -
>   .../ti/k3-am642-phyboard-electra-pcie-usb2.dtso    |   87 +
>   .../src/arm64/ti/k3-am642-phyboard-electra-rdk.dts |   12 -
>   dts/upstream/src/arm64/ti/k3-am642-sk.dts          |   12 +
>   .../src/arm64/ti/k3-am642-tqma64xxl-mbax4xxl.dts   |    4 +-
>   dts/upstream/src/arm64/ti/k3-am642-tqma64xxl.dtsi  |    4 +-
>   .../src/arm64/ti/k3-am65-iot2050-common-pg1.dtsi   |   12 +
>   dts/upstream/src/arm64/ti/k3-am65-main.dtsi        |   36 +
>   dts/upstream/src/arm64/ti/k3-am65-mcu.dtsi         |   12 +-
>   dts/upstream/src/arm64/ti/k3-am654-base-board.dts  |    1 +
>   .../src/arm64/ti/k3-am68-sk-base-board.dts         |   76 +
>   dts/upstream/src/arm64/ti/k3-am68-sk-som.dtsi      |   86 +-
>   dts/upstream/src/arm64/ti/k3-am69-sk.dts           |   87 +-
>   .../arm64/ti/k3-am6xx-phycore-disable-eth-phy.dtso |   19 +
>   .../src/arm64/ti/k3-am6xx-phycore-disable-rtc.dtso |   15 +
>   .../arm64/ti/k3-am6xx-phycore-disable-spi-nor.dtso |   15 +
>   .../src/arm64/ti/k3-am6xx-phycore-qspi-nor.dtso    |   15 +
>   dts/upstream/src/arm64/ti/k3-j7200-mcu-wakeup.dtsi |   14 +-
>   dts/upstream/src/arm64/ti/k3-j7200-som-p0.dtsi     |    5 +-
>   .../k3-j721e-common-proc-board-infotainment.dtso   |  164 +
>   dts/upstream/src/arm64/ti/k3-j721e-mcu-wakeup.dtsi |   12 +-
>   dts/upstream/src/arm64/ti/k3-j721e-sk.dts          |  117 +
>   dts/upstream/src/arm64/ti/k3-j721e-som-p0.dtsi     |    1 +
>   .../src/arm64/ti/k3-j721s2-mcu-wakeup.dtsi         |   12 +-
>   dts/upstream/src/arm64/ti/k3-j721s2-som-p0.dtsi    |    5 +-
>   dts/upstream/src/arm64/ti/k3-j722s-evm.dts         |  182 +
>   dts/upstream/src/arm64/ti/k3-j722s-main.dtsi       |  218 +
>   dts/upstream/src/arm64/ti/k3-j722s.dtsi            |  165 +-
>   .../src/arm64/ti/k3-j784s4-evm-pcie0-pcie1-ep.dtso |   79 +
>   .../arm64/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso |  147 +
>   .../arm64/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso  |   81 +
>   dts/upstream/src/arm64/ti/k3-j784s4-evm.dts        |  374 +-
>   dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi      |  527 ++
>   .../src/arm64/ti/k3-j784s4-mcu-wakeup.dtsi         |   14 +-
>   dts/upstream/src/arm64/ti/k3-j784s4.dtsi           |   10 +-
>   dts/upstream/src/arm64/ti/k3-pinctrl.h             |    3 +
>   dts/upstream/src/arm64/ti/k3-serdes.h              |    8 +
>   dts/upstream/src/arm64/xilinx/zynqmp-clk-ccf.dtsi  |   16 +
>   .../src/arm64/xilinx/zynqmp-sck-kv-g-revA.dtso     |   19 +-
>   .../src/arm64/xilinx/zynqmp-sck-kv-g-revB.dtso     |   41 +-
>   .../src/arm64/xilinx/zynqmp-sm-k26-revA.dts        |   19 +-
>   .../src/arm64/xilinx/zynqmp-smk-k26-revA.dts       |    8 +-
>   .../src/arm64/xilinx/zynqmp-zcu102-rev1.0.dts      |    8 +
>   dts/upstream/src/arm64/xilinx/zynqmp.dtsi          |  184 +-
>   .../src/mips/loongson/loongson64-2k1000.dtsi       |  102 +-
>   .../src/mips/loongson/loongson64g_4core_ls7a.dts   |    1 +
>   .../{eyeq5-fixed-clocks.dtsi => eyeq5-clocks.dtsi} |   54 +-
>   dts/upstream/src/mips/mobileye/eyeq5-pins.dtsi     |  125 +
>   dts/upstream/src/mips/mobileye/eyeq5.dtsi          |   22 +-
>   dts/upstream/src/mips/mobileye/eyeq6h-epm6.dts     |   22 +
>   .../src/mips/mobileye/eyeq6h-fixed-clocks.dtsi     |   52 +
>   dts/upstream/src/mips/mobileye/eyeq6h-pins.dtsi    |   88 +
>   dts/upstream/src/mips/mobileye/eyeq6h.dtsi         |   98 +
>   .../realtek/cameo-rtl9302c-2x-rtl8224-2xge.dts     |   73 +
>   dts/upstream/src/mips/realtek/rtl838x.dtsi         |    1 +
>   dts/upstream/src/mips/realtek/rtl83xx.dtsi         |    4 +-
>   dts/upstream/src/mips/realtek/rtl930x.dtsi         |   79 +
>   dts/upstream/src/powerpc/acadia.dts                |  224 -
>   dts/upstream/src/powerpc/haleakala.dts             |  281 -
>   dts/upstream/src/powerpc/hotfoot.dts               |  296 -
>   dts/upstream/src/powerpc/kilauea.dts               |  407 --
>   dts/upstream/src/powerpc/klondike.dts              |  212 -
>   dts/upstream/src/powerpc/makalu.dts                |  353 -
>   dts/upstream/src/powerpc/obs600.dts                |  314 -
>   .../allwinner/sun20i-d1-clockworkpi-v3.14.dts      |  252 +
>   .../riscv/allwinner/sun20i-d1-devterm-v3.14.dts    |   36 +
>   .../src/riscv/allwinner/sunxi-d1s-t113.dtsi        |   11 +
>   .../riscv/microchip/mpfs-beaglev-fire-fabric.dtsi  |   82 +
>   .../src/riscv/microchip/mpfs-beaglev-fire.dts      |  223 +
>   .../src/riscv/sophgo/sg2042-milkv-pioneer.dts      |   12 +
>   dts/upstream/src/riscv/sophgo/sg2042.dtsi          |   55 +-
>   dts/upstream/src/riscv/starfive/jh7110-common.dtsi |   75 +-
>   .../src/riscv/starfive/jh7110-milkv-mars.dts       |    7 +
>   .../src/riscv/starfive/jh7110-pine64-star64.dts    |   65 +
>   .../starfive/jh7110-starfive-visionfive-2.dtsi     |    8 +
>   dts/upstream/src/riscv/starfive/jh7110.dtsi        |  116 +-
>   dts/upstream/src/riscv/thead/th1520.dtsi           |   81 +
>   env/common.c                                       |   10 +-
>   env/mmc.c                                          |   95 +-
>   env/sf.c                                           |    2 +-
>   fs/Makefile                                        |    2 +-
>   fs/btrfs/btrfs.c                                   |    2 +-
>   fs/btrfs/compat.h                                  |    2 +-
>   fs/btrfs/disk-io.c                                 |    2 +-
>   fs/ext4/ext4_common.c                              |   21 +-
>   fs/ext4/ext4_common.h                              |    5 +-
>   fs/ext4/ext4_write.c                               |   12 +-
>   fs/ext4/ext4fs.c                                   |    2 +-
>   fs/fs.c                                            |   10 +-
>   fs/sandbox/sandboxfs.c                             |    6 +-
>   fs/squashfs/sqfs.c                                 |  110 +-
>   fs/squashfs/sqfs_inode.c                           |    9 +-
>   fs/yaffs2/yaffs_guts.c                             |    5 +-
>   include/alist.h                                    |  239 +
>   include/asm-generic/global_data.h                  |  382 +-
>   include/blk.h                                      |    4 +-
>   include/board_f.h                                  |   35 +
>   include/bootdev.h                                  |    8 +
>   include/bootstage.h                                |    4 +-
>   include/configs/apalis_imx6.h                      |    5 -
>   include/configs/arbel.h                            |    2 +-
>   include/configs/aristainetos2.h                    |    4 -
>   include/configs/at91sam9260ek.h                    |    6 +-
>   include/configs/brppt2.h                           |    3 -
>   include/configs/cl-som-imx7.h                      |    4 -
>   include/configs/cm_fx6.h                           |    4 -
>   include/configs/colibri-imx6ull.h                  |    5 -
>   include/configs/colibri_imx6.h                     |    5 -
>   include/configs/colibri_imx7.h                     |    5 -
>   include/configs/dart_6ul.h                         |    4 -
>   include/configs/dh_imx6.h                          |    4 -
>   include/configs/display5.h                         |    1 -
>   include/configs/embestmx6boards.h                  |    4 -
>   include/configs/ethernut5.h                        |   91 -
>   include/configs/ge_b1x5v2.h                        |    4 -
>   include/configs/gw_ventana.h                       |   35 +-
>   include/configs/ibex_ast2700.h                     |   12 +
>   include/configs/imx6_logic.h                       |    6 -
>   include/configs/imx6dl-mamoj.h                     |    4 -
>   include/configs/imx6q-bosch-acc.h                  |    2 -
>   include/configs/imx7-cm.h                          |    3 -
>   include/configs/imx8mm-cl-iot-gate.h               |    3 -
>   include/configs/kontron-sl-mx6ul.h                 |    5 -
>   include/configs/kontron-sl-mx8mm.h                 |    5 -
>   include/configs/kp_imx53.h                         |    1 -
>   include/configs/kp_imx6q_tpc.h                     |    6 -
>   include/configs/liteboard.h                        |    6 -
>   include/configs/ls1028aqds.h                       |    1 -
>   include/configs/ls1028ardb.h                       |    2 -
>   include/configs/ls1046afrwy.h                      |    1 -
>   include/configs/lx2160aqds.h                       |    3 -
>   include/configs/lx2160ardb.h                       |    3 -
>   include/configs/lx2162aqds.h                       |    3 -
>   include/configs/lxr2.h                             |   23 +
>   include/configs/m53menlo.h                         |    4 -
>   include/configs/meerkat96.h                        |    3 -
>   include/configs/mx51evk.h                          |    1 -
>   include/configs/mx53cx9020.h                       |    2 -
>   include/configs/mx53loco.h                         |    2 -
>   include/configs/mx53ppd.h                          |    2 -
>   include/configs/mx6cuboxi.h                        |    3 -
>   include/configs/mx6memcal.h                        |    1 -
>   include/configs/mx6sabreauto.h                     |    4 -
>   include/configs/mx6sabresd.h                       |    6 -
>   include/configs/mx6slevk.h                         |   10 +-
>   include/configs/mx6sllevk.h                        |    5 -
>   include/configs/mx6sxsabreauto.h                   |    5 -
>   include/configs/mx6sxsabresd.h                     |    5 -
>   include/configs/mx6ul_14x14_evk.h                  |    6 -
>   include/configs/mx7dsabresd.h                      |    3 -
>   include/configs/mx7ulp_com.h                       |    1 -
>   include/configs/mys_6ulx.h                         |    4 -
>   include/configs/nitrogen6x.h                       |    4 -
>   include/configs/novena.h                           |    6 -
>   include/configs/npi_imx6ull.h                      |    4 -
>   include/configs/o4-imx6ull-nano.h                  |    4 -
>   include/configs/opos6uldev.h                       |    6 -
>   include/configs/pcl063.h                           |    4 -
>   include/configs/pcl063_ull.h                       |    4 -
>   include/configs/phycore_imx8mm.h                   |    8 +
>   include/configs/pico-imx6.h                        |    4 -
>   include/configs/pico-imx6ul.h                      |    4 -
>   include/configs/pico-imx7d.h                       |    4 -
>   include/configs/sc573-ezkit.h                      |   18 +
>   include/configs/sc584-ezkit.h                      |   18 +
>   include/configs/sc589.h                            |   19 +
>   include/configs/sc594-som.h                        |   19 +
>   include/configs/sc598-som.h                        |   23 +
>   include/configs/sniper.h                           |   14 -
>   include/configs/somlabs_visionsom_6ull.h           |    6 -
>   include/configs/tbs2910.h                          |    5 -
>   include/configs/tqma6.h                            |    8 +-
>   include/configs/tqma6_wru4.h                       |    1 -
>   include/configs/usbarmory.h                        |    2 -
>   include/configs/verdin-imx8mm.h                    |    3 -
>   include/configs/vining_2000.h                      |    2 -
>   include/configs/wandboard.h                        |    4 -
>   include/configs/warp7.h                            |    1 -
>   include/configs/xpress.h                           |    4 -
>   include/console.h                                  |   10 +-
>   include/dfu.h                                      |    1 +
>   include/dm/test.h                                  |    2 +-
>   include/dt-bindings/clock/mt7622-clk.h             |   68 +-
>   include/dt-bindings/clock/mt7623-clk.h             |  818 +--
>   include/dt-bindings/clock/mt7981-clk.h             |  429 +-
>   include/dt-bindings/clock/mt7986-clk.h             |  359 +-
>   include/dt-bindings/clock/mt7988-clk.h             |  545 +-
>   include/dt-bindings/clock/sophgo,cv1800.h          |  176 +
>   include/dt-bindings/pinctrl/sandbox-pinmux.h       |    1 +
>   include/dwmmc.h                                    |  240 +-
>   include/efi.h                                      |    2 +-
>   include/env/phytec/k3_mmc.env                      |   16 +-
>   include/env/phytec/k3_net.env                      |   22 +
>   include/env/phytec/k3_spi.env                      |   18 +
>   include/env/ti/android.env                         |   31 +
>   include/env_callback.h                             |    7 +
>   include/env_default.h                              |    3 -
>   include/env_internal.h                             |    1 +
>   include/ext4fs.h                                   |   53 +-
>   include/flash.h                                    |   20 +-
>   include/fwu.h                                      |   13 +-
>   include/generic-phy.h                              |    8 +-
>   include/gzip.h                                     |    6 +-
>   include/handoff.h                                  |    7 +
>   include/i2c.h                                      |  107 -
>   include/image.h                                    |   28 +-
>   include/linux/compiler_types.h                     |    7 +
>   include/linux/mtd/rawnand.h                        |    5 +
>   include/linux/usb/atmel_usba_udc.h                 |    2 +
>   include/lmb.h                                      |  146 +-
>   include/log.h                                      |   18 +-
>   include/mmc.h                                      |   29 +
>   include/os.h                                       |    6 +-
>   include/part.h                                     |    2 +-
>   include/pci_ids.h                                  |    9 +
>   include/power/pca9450.h                            |    2 +
>   include/power/regulator.h                          |   37 -
>   include/rkmtd.h                                    |    2 +-
>   include/sandbox_efi_capsule.h                      |    6 +-
>   include/spl.h                                      |   78 +-
>   include/spl_load.h                                 |    6 +-
>   include/test/log.h                                 |    5 +-
>   include/test/spl.h                                 |    2 +-
>   include/test/suites.h                              |    1 +
>   include/test/test.h                                |   32 +-
>   include/test/ut.h                                  |    2 +-
>   include/u-boot/ecdsa.h                             |    1 +
>   include/{ => u-boot}/uuid.h                        |   21 +-
>   include/upl.h                                      |  382 ++
>   include/usb.h                                      |   20 +-
>   include/video.h                                    |   11 +
>   lib/Kconfig                                        |   48 +-
>   lib/Makefile                                       |    3 +-
>   lib/acpi/acpi_dp.c                                 |    2 +-
>   lib/acpi/acpigen.c                                 |    2 +-
>   lib/alist.c                                        |  158 +
>   lib/asm-offsets.c                                  |    2 +
>   lib/crypto/Kconfig                                 |    2 +-
>   lib/ecdsa/ecdsa-libcrypto.c                        |    2 +-
>   lib/efi/Kconfig                                    |    5 +
>   lib/efi/efi_app.c                                  |    2 +-
>   lib/efi_loader/Kconfig                             |  217 +-
>   lib/efi_loader/efi_bootmgr.c                       |   28 +-
>   lib/efi_loader/efi_capsule.c                       |   12 +-
>   lib/efi_loader/efi_console.c                       |    2 +-
>   lib/efi_loader/efi_device_path.c                   |    2 +-
>   lib/efi_loader/efi_dt_fixup.c                      |    2 +-
>   lib/efi_loader/efi_firmware.c                      |   55 +-
>   lib/efi_loader/efi_helper.c                        |    2 +-
>   lib/efi_loader/efi_variable.c                      |    2 +-
>   lib/efi_loader/helloworld.c                        |    3 +
>   lib/elf.c                                          |   14 +-
>   lib/fdtdec.c                                       |    3 +-
>   lib/fwu_updates/Kconfig                            |    1 +
>   lib/fwu_updates/fwu.c                              |   31 +-
>   lib/fwu_updates/fwu_mtd.c                          |    7 +-
>   lib/fwu_updates/fwu_v1.c                           |   18 +-
>   lib/fwu_updates/fwu_v2.c                           |   81 +-
>   lib/lmb.c                                          |  699 +-
>   lib/strto.c                                        |    4 +-
>   lib/tiny-printf.c                                  |   15 +-
>   lib/uuid.c                                         |  103 +-
>   lib/vsprintf.c                                     |    2 +-
>   net/bootp.c                                        |    2 +-
>   net/net.c                                          |   23 +-
>   net/tftp.c                                         |   36 +-
>   net/wget.c                                         |   59 +-
>   scripts/Kbuild.include                             |    4 +
>   scripts/Makefile.build                             |    1 +
>   scripts/Makefile.lib                               |   27 +
>   scripts/kconfig/symbol.c                           |    2 +-
>   .../tests/err_recursive_dep/expected_stderr        |   14 +-
>   scripts/pylint.base                                |  462 +-
>   test/bloblist.c                                    |   14 +-
>   test/boot/Makefile                                 |    7 +-
>   test/boot/bootdev.c                                |   68 +-
>   test/boot/bootflow.c                               |   65 +-
>   test/boot/bootmeth.c                               |   14 +-
>   test/boot/bootstd_common.c                         |    6 +
>   test/boot/bootstd_common.h                         |    8 +
>   test/boot/cedit.c                                  |   13 +-
>   test/boot/expo.c                                   |   19 +-
>   test/boot/upl.c                                    |  437 ++
>   test/boot/vbe_fixup.c                              |    4 +-
>   test/boot/vbe_simple.c                             |    2 +-
>   test/cmd/Makefile                                  |    2 +-
>   test/cmd/addrmap.c                                 |    3 +-
>   test/cmd/armffa.c                                  |    3 +-
>   test/cmd/bdinfo.c                                  |   66 +-
>   test/cmd/exit.c                                    |   39 +-
>   test/cmd/fdt.c                                     |  544 +-
>   test/cmd/font.c                                    |   13 +-
>   test/cmd/history.c                                 |    2 +-
>   test/cmd/loadm.c                                   |    6 +-
>   test/cmd/mbr.c                                     |  194 +-
>   test/cmd/mem_search.c                              |   31 +-
>   test/cmd/pci_mps.c                                 |    3 +-
>   test/cmd/pinmux.c                                  |   15 +-
>   test/cmd/pwm.c                                     |    7 +-
>   test/cmd/rw.c                                      |    5 +-
>   test/cmd/seama.c                                   |    9 +-
>   test/cmd/setexpr.c                                 |   24 +-
>   test/cmd/temperature.c                             |    5 +-
>   test/cmd/test_echo.c                               |    8 +-
>   test/cmd/test_pause.c                              |    9 +-
>   test/cmd/wget.c                                    |   49 +-
>   test/cmd_ut.c                                      |    3 +
>   test/common/cread.c                                |    4 +-
>   test/common/event.c                                |    2 +-
>   test/common/test_autoboot.c                        |    4 +-
>   test/dm/acpi.c                                     |   39 +-
>   test/dm/acpi_dp.c                                  |    4 +-
>   test/dm/acpigen.c                                  |   21 +-
>   test/dm/adc.c                                      |   16 +-
>   test/dm/audio.c                                    |    2 +-
>   test/dm/axi.c                                      |    9 +-
>   test/dm/blk.c                                      |   16 +-
>   test/dm/blkmap.c                                   |    4 +-
>   test/dm/bootcount.c                                |   10 +-
>   test/dm/bus.c                                      |   26 +-
>   test/dm/button.c                                   |   12 +-
>   test/dm/cache.c                                    |    2 +-
>   test/dm/clk.c                                      |    7 +-
>   test/dm/clk_ccf.c                                  |    3 +-
>   test/dm/core.c                                     |   47 +-
>   test/dm/cpu.c                                      |    3 +-
>   test/dm/cros_ec.c                                  |   18 +-
>   test/dm/cros_ec_pwm.c                              |    2 +-
>   test/dm/devres.c                                   |   12 +-
>   test/dm/dma.c                                      |    6 +-
>   test/dm/dsa.c                                      |    6 +-
>   test/dm/dsi_host.c                                 |    3 +-
>   test/dm/ecdsa.c                                    |    2 +-
>   test/dm/efi_media.c                                |    2 +-
>   test/dm/eth.c                                      |   24 +-
>   test/dm/extcon.c                                   |    3 +-
>   test/dm/fastboot.c                                 |    2 +-
>   test/dm/fdtdec.c                                   |    4 +-
>   test/dm/ffa.c                                      |    6 +-
>   test/dm/firmware.c                                 |    2 +-
>   test/dm/fpga.c                                     |    3 +-
>   test/dm/fwu_mdata.c                                |    4 +-
>   test/dm/gpio.c                                     |   32 +-
>   test/dm/host.c                                     |    8 +-
>   test/dm/hwspinlock.c                               |    3 +-
>   test/dm/i2c.c                                      |   19 +-
>   test/dm/i2s.c                                      |    2 +-
>   test/dm/iommu.c                                    |    8 +-
>   test/dm/irq.c                                      |   10 +-
>   test/dm/led.c                                      |   12 +-
>   test/dm/mailbox.c                                  |    2 +-
>   test/dm/mdio.c                                     |    3 +-
>   test/dm/mdio_mux.c                                 |    3 +-
>   test/dm/memory.c                                   |    3 +-
>   test/dm/misc.c                                     |    3 +-
>   test/dm/mmc.c                                      |    4 +-
>   test/dm/mux-cmd.c                                  |    6 +-
>   test/dm/mux-emul.c                                 |    4 +-
>   test/dm/mux-mmio.c                                 |    4 +-
>   test/dm/nand.c                                     |   45 +-
>   test/dm/nop.c                                      |    3 +-
>   test/dm/nvmxip.c                                   |    3 +-
>   test/dm/of_platdata.c                              |   16 +-
>   test/dm/ofnode.c                                   |  106 +-
>   test/dm/ofread.c                                   |    2 +-
>   test/dm/osd.c                                      |    6 +-
>   test/dm/p2sb.c                                     |    2 +-
>   test/dm/panel.c                                    |    4 +-
>   test/dm/part.c                                     |    6 +-
>   test/dm/pch.c                                      |    4 +-
>   test/dm/pci.c                                      |   31 +-
>   test/dm/pci_ep.c                                   |    3 +-
>   test/dm/phy.c                                      |   25 +-
>   test/dm/phys2bus.c                                 |    2 +-
>   test/dm/pinmux.c                                   |    6 +-
>   test/dm/pmc.c                                      |    2 +-
>   test/dm/pmic.c                                     |   13 +-
>   test/dm/power-domain.c                             |    2 +-
>   test/dm/pwm.c                                      |    2 +-
>   test/dm/qfw.c                                      |    6 +-
>   test/dm/ram.c                                      |    2 +-
>   test/dm/read.c                                     |    2 +-
>   test/dm/reboot-mode.c                              |    6 +-
>   test/dm/regmap.c                                   |   18 +-
>   test/dm/regulator.c                                |   24 +-
>   test/dm/remoteproc.c                               |    4 +-
>   test/dm/reset.c                                    |   11 +-
>   test/dm/rkmtd.c                                    |    6 +-
>   test/dm/rng.c                                      |    6 +-
>   test/dm/rtc.c                                      |   18 +-
>   test/dm/scmi.c                                     |   17 +-
>   test/dm/scsi.c                                     |    2 +-
>   test/dm/serial.c                                   |    3 +-
>   test/dm/sf.c                                       |    4 +-
>   test/dm/simple-bus.c                               |    2 +-
>   test/dm/simple-pm-bus.c                            |    2 +-
>   test/dm/sm.c                                       |    3 +-
>   test/dm/smem.c                                     |    2 +-
>   test/dm/soc.c                                      |    3 +-
>   test/dm/sound.c                                    |    4 +-
>   test/dm/spi.c                                      |    6 +-
>   test/dm/spmi.c                                     |    6 +-
>   test/dm/syscon-reset.c                             |    2 +-
>   test/dm/syscon.c                                   |    6 +-
>   test/dm/sysinfo-gpio.c                             |    2 +-
>   test/dm/sysinfo.c                                  |    3 +-
>   test/dm/sysreset.c                                 |    8 +-
>   test/dm/tag.c                                      |    4 -
>   test/dm/tee.c                                      |    3 +-
>   test/dm/test-fdt.c                                 |   58 +-
>   test/dm/timer.c                                    |    4 +-
>   test/dm/tpm.c                                      |    8 +-
>   test/dm/usb.c                                      |   12 +-
>   test/dm/video.c                                    |   42 +-
>   test/dm/virtio.c                                   |    2 +-
>   test/dm/virtio_device.c                            |    8 +-
>   test/dm/virtio_rng.c                               |    2 +-
>   test/dm/wdt.c                                      |    8 +-
>   test/env/cmd_ut_env.c                              |   27 +
>   test/env/hashtable.c                               |    2 -
>   test/hush/dollar.c                                 |   41 +-
>   test/hush/loop.c                                   |   11 +-
>   test/image/spl_load.c                              |    4 +-
>   test/image/spl_load_os.c                           |   54 +-
>   test/lib/Makefile                                  |    1 +
>   test/lib/alist.c                                   |  242 +
>   test/lib/asn1.c                                    |    3 -
>   test/lib/efi_device_path.c                         |    1 -
>   test/lib/efi_image_region.c                        |    2 -
>   test/lib/hexdump.c                                 |    3 -
>   test/lib/lmb.c                                     |  543 +-
>   test/lib/rsa.c                                     |    2 -
>   test/lib/sscanf.c                                  |    1 -
>   test/lib/string.c                                  |    3 -
>   test/lib/test_aes.c                                |    1 -
>   test/lib/test_crc8.c                               |    1 -
>   test/lib/test_crypt.c                              |    1 -
>   test/lib/test_errno_str.c                          |    1 -
>   test/lib/test_print.c                              |   16 +-
>   test/lib/uuid.c                                    |  125 +-
>   test/log/cont_test.c                               |    7 +-
>   test/log/log_filter.c                              |    7 +-
>   test/log/log_test.c                                |   63 +-
>   test/log/nolog_ndebug.c                            |    3 +-
>   test/log/nolog_test.c                              |   24 +-
>   test/log/pr_cont_test.c                            |    3 +-
>   test/overlay/Kconfig                               |    2 +-
>   test/print_ut.c                                    |   21 +-
>   test/py/tests/test_bootstage.py                    |    9 +-
>   .../test_efi_capsule/test_capsule_firmware_fit.py  |    2 +-
>   .../test_efi_capsule/test_capsule_firmware_raw.py  |    8 +-
>   .../test_capsule_firmware_signed_fit.py            |    2 +-
>   .../test_capsule_firmware_signed_raw.py            |    4 +-
>   test/py/tests/test_efi_capsule/version.dtso        |    6 +-
>   test/py/tests/test_efi_loader.py                   |   62 +-
>   test/py/tests/test_net_boot.py                     |    2 +-
>   test/py/tests/test_spi.py                          |  696 ++
>   test/py/tests/test_upl.py                          |   38 +
>   test/py/tests/test_ut.py                           |   94 +-
>   test/str_ut.c                                      |    4 +-
>   test/test-main.c                                   |   78 +-
>   test/ut.c                                          |    8 +-
>   tools/Makefile                                     |    8 +-
>   tools/binman/binman.rst                            |   19 +-
>   tools/binman/btool/fdtgrep.py                      |    3 +-
>   tools/binman/elf.py                                |   14 +-
>   tools/binman/elf_test.py                           |    4 +-
>   tools/binman/entry.py                              |   25 +-
>   tools/binman/etype/atf_fip.py                      |    2 +-
>   tools/binman/etype/blob_phase.py                   |    5 +
>   tools/binman/etype/cbfs.py                         |    2 +-
>   tools/binman/etype/efi_capsule.py                  |    4 +-
>   tools/binman/etype/fit.py                          |  116 +-
>   tools/binman/etype/nxp_imx8mimage.py               |    3 +-
>   tools/binman/etype/section.py                      |   31 +-
>   tools/binman/ftest.py                              |  154 +-
>   tools/binman/image.py                              |   21 +-
>   tools/binman/image_test.py                         |    8 +-
>   tools/binman/test/336_symbols_base.dts             |   23 +
>   tools/binman/test/337_symbols_base_expand.dts      |   24 +
>   tools/binman/test/338_symbols_comp.dts             |   26 +
>   tools/binman/test/339_nxp_imx8.dts                 |   17 +
>   tools/buildman/bsettings.py                        |    3 +
>   tools/buildman/builder.py                          |   27 +-
>   tools/buildman/builderthread.py                    |   12 +-
>   tools/buildman/buildman.rst                        |    3 +
>   tools/buildman/cmdline.py                          |    2 +
>   tools/buildman/control.py                          |    3 +-
>   tools/buildman/kconfiglib.py                       |   10 +-
>   tools/buildman/test.py                             |  162 +
>   tools/buildman/toolchain.py                        |   37 +-
>   tools/eficapsule.h                                 |    2 +-
>   tools/image-sig-host.c                             |    7 +
>   tools/mkeficapsule.c                               |  208 +-
>   2839 files changed, 117653 insertions(+), 37640 deletions(-)
>   delete mode 100644 arch/arm/dts/at91sam9xe.dtsi
>   delete mode 100644 arch/arm/dts/ethernut5.dts
>   create mode 100644 arch/arm/dts/imx6q-lxr.dts
>   create mode 100644 arch/arm/dts/imx6q-phytec-pfla02.dtsi
>   create mode 100644 arch/arm/dts/imx6qdl-phytec-pfla02.dtsi
>   delete mode 100644 arch/arm/dts/imx6sl-evk.dts
>   delete mode 100644 arch/arm/dts/imx6sl-pinfunc.h
>   delete mode 100644 arch/arm/dts/imx6sl.dtsi
>   delete mode 100644 arch/arm/dts/keystone-clocks.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2e-clocks.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2e-evm.dts
>   delete mode 100644 arch/arm/dts/keystone-k2e-netcp.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2e.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2g-evm.dts
>   delete mode 100644 arch/arm/dts/keystone-k2g-generic-u-boot.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2g-generic.dts
>   delete mode 100644 arch/arm/dts/keystone-k2g-ice.dts
>   delete mode 100644 arch/arm/dts/keystone-k2g-netcp.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2g.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2hk-clocks.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2hk-evm.dts
>   delete mode 100644 arch/arm/dts/keystone-k2hk-netcp.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2hk.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2l-clocks.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2l-evm.dts
>   delete mode 100644 arch/arm/dts/keystone-k2l-netcp.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2l.dtsi
>   delete mode 100644 arch/arm/dts/keystone.dtsi
>   create mode 100644 arch/arm/dts/nuvoton-npcm845-yosemite4-pincfg.dtsi
>   create mode 100644 arch/arm/dts/nuvoton-npcm845-yosemite4.dts
>   delete mode 100644 arch/arm/dts/omap3-evm-37xx.dts
>   delete mode 100644 arch/arm/dts/omap3-evm-common.dtsi
>   delete mode 100644 arch/arm/dts/omap3-evm-processor-common.dtsi
>   delete mode 100644 arch/arm/dts/omap3-evm.dts
>   delete mode 100644 arch/arm/dts/omap3-panel-sharp-ls037v7dw01.dtsi
>   create mode 100644 arch/arm/dts/omap3-sniper-u-boot.dtsi
>   create mode 100644 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
>   create mode 100644 arch/arm/dts/sc573-ezkit.dts
>   create mode 100644 arch/arm/dts/sc57x.dtsi
>   create mode 100644 arch/arm/dts/sc584-ezkit.dts
>   create mode 100644 arch/arm/dts/sc589-ezkit.dts
>   create mode 100644 arch/arm/dts/sc589-mini.dts
>   create mode 100644 arch/arm/dts/sc58x.dtsi
>   create mode 100644 arch/arm/dts/sc594-som-ezkit.dts
>   create mode 100644 arch/arm/dts/sc594-som-ezlite.dts
>   create mode 100644 arch/arm/dts/sc594-som.dtsi
>   create mode 100644 arch/arm/dts/sc598-som-ezkit.dts
>   create mode 100644 arch/arm/dts/sc598-som-ezlite.dts
>   create mode 100644 arch/arm/dts/sc598-som.dtsi
>   create mode 100644 arch/arm/dts/sc5xx.dtsi
>   delete mode 100644 arch/arm/mach-at91/arm926ejs/eflash.c
>   delete mode 100644 arch/arm/mach-at91/include/mach/at91_dbu.h
>   delete mode 100644 arch/arm/mach-at91/include/mach/at91_eefc.h
>   create mode 100644 arch/arm/mach-imx/fdt.c
>   create mode 100644 arch/arm/mach-rockchip/spl_common.c
>   create mode 100644 arch/arm/mach-sc5xx/sc57x-spl.c
>   create mode 100644 arch/arm/mach-sc5xx/sc58x-spl.c
>   create mode 100644 arch/arm/mach-sc5xx/sc59x-spl.c
>   create mode 100644 arch/arm/mach-sc5xx/sc59x_64-spl.c
>   create mode 100644 arch/arm/mach-stm32mp/include/mach/stm32mp.h
>   create mode 100644 arch/powerpc/lib/misc.c
>   create mode 100644 arch/riscv/cpu/ast2700/Kconfig
>   create mode 100644 arch/riscv/cpu/ast2700/Makefile
>   create mode 100644 arch/riscv/cpu/ast2700/cpu.c
>   create mode 100644 arch/riscv/dts/ast2700-ibex.dts
>   create mode 100644 arch/riscv/dts/ast2700-u-boot.dtsi
>   create mode 100644 arch/riscv/dts/ast2700.dtsi
>   create mode 100644 arch/riscv/include/asm/arch-ast2700/fmc_hdr.h
>   create mode 100644 arch/riscv/include/asm/arch-ast2700/scu.h
>   create mode 100644 arch/riscv/include/asm/arch-ast2700/sdram.h
>   create mode 100644 arch/riscv/include/asm/arch-ast2700/sli.h
>   create mode 100644 board/adi/sc573-ezkit/Kconfig
>   create mode 100644 board/adi/sc573-ezkit/sc573-ezkit.env
>   create mode 100644 board/adi/sc584-ezkit/Kconfig
>   create mode 100644 board/adi/sc584-ezkit/sc584-ezkit.env
>   create mode 100644 board/adi/sc589-ezkit/Kconfig
>   create mode 100644 board/adi/sc589-ezkit/sc589-ezkit.env
>   create mode 100644 board/adi/sc589-mini/Kconfig
>   create mode 100644 board/adi/sc589-mini/sc589-mini.env
>   create mode 100644 board/adi/sc594-som-ezkit/Kconfig
>   create mode 100644 board/adi/sc594-som-ezkit/sc594-som-ezkit.env
>   create mode 100644 board/adi/sc594-som-ezlite/Kconfig
>   create mode 100644 board/adi/sc594-som-ezlite/sc594-som-ezlite.env
>   create mode 100644 board/adi/sc598-som-ezkit/Kconfig
>   create mode 100644 board/adi/sc598-som-ezkit/sc598-som-ezkit.env
>   create mode 100644 board/adi/sc598-som-ezlite/Kconfig
>   create mode 100644 board/adi/sc598-som-ezlite/sc598-som-ezlite.env
>   create mode 100644 board/aspeed/ibex_ast2700/Kconfig
>   create mode 100644 board/aspeed/ibex_ast2700/MAINTAINERS
>   create mode 100644 board/aspeed/ibex_ast2700/Makefile
>   create mode 100644 board/aspeed/ibex_ast2700/fmc_hdr.c
>   create mode 100644 board/aspeed/ibex_ast2700/ibex_ast2700.c
>   create mode 100644 board/aspeed/ibex_ast2700/sli.c
>   create mode 100644 board/comvetia/lxr2/Kconfig
>   create mode 100644 board/comvetia/lxr2/MAINTAINERS
>   create mode 100644 board/comvetia/lxr2/Makefile
>   create mode 100644 board/comvetia/lxr2/lxr2.c
>   create mode 100644 board/comvetia/lxr2/lxr2.env
>   delete mode 100644 board/egnite/ethernut5/Kconfig
>   delete mode 100644 board/egnite/ethernut5/MAINTAINERS
>   delete mode 100644 board/egnite/ethernut5/Makefile
>   delete mode 100644 board/egnite/ethernut5/ethernut5.c
>   delete mode 100644 board/egnite/ethernut5/ethernut5_pwrman.c
>   delete mode 100644 board/egnite/ethernut5/ethernut5_pwrman.h
>   create mode 100644 board/freescale/imx93_evk/lpddr4x_timing_1866mts.c
>   delete mode 100644 board/freescale/imx93_evk/lpddr4x_timing_ld.c
>   create mode 100644 board/qualcomm/debug-sdm845.config
>   create mode 100644 board/qualcomm/debug-sm6115.config
>   create mode 100644 board/qualcomm/debug-sm8250.config
>   create mode 100644 boot/upl_common.c
>   create mode 100644 boot/upl_common.h
>   create mode 100644 boot/upl_read.c
>   create mode 100644 boot/upl_write.c
>   create mode 100644 cmd/upl.c
>   create mode 100644 common/spl/spl_upl.c
>   create mode 100644 configs/am62x_a53_android.config
>   create mode 100644 configs/am62x_evm_a53_ethboot_defconfig
>   create mode 100644 configs/am62x_evm_r5_ethboot_defconfig
>   delete mode 100644 configs/ethernut5_defconfig
>   create mode 100644 configs/ibex-ast2700_defconfig
>   delete mode 100644 configs/imx93_11x11_evk_ld_defconfig
>   create mode 100644 configs/lxr2_defconfig
>   delete mode 100644 configs/mx6slevk_spinor_defconfig
>   delete mode 100644 configs/mx6slevk_spl_defconfig
>   create mode 100644 configs/phycore_am62x_r5_usbdfu_defconfig
>   create mode 100644 configs/qcm6490_defconfig
>   create mode 100644 doc/board/aspeed/ibex-ast2700.rst
>   create mode 100644 doc/board/aspeed/index.rst
>   create mode 100644 doc/board/qualcomm/rb3gen2.rst
>   rename doc/{README.generic-board => develop/historical/generic_board.rst} (96%)
>   create mode 100644 doc/develop/historical/index.rst
>   create mode 100644 doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
>   create mode 100644 doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml
>   create mode 100644 doc/device-tree-bindings/timer/adi,sc5xx-gptimer.yaml
>   create mode 100644 doc/usage/cmd/upl.rst
>   create mode 100644 doc/usage/upl.rst
>   create mode 100644 drivers/clk/qcom/clock-sc7280.c
>   create mode 100644 drivers/clk/qcom/clock-sm8150.c
>   create mode 100644 drivers/clk/sophgo/Kconfig
>   create mode 100644 drivers/clk/sophgo/Makefile
>   create mode 100644 drivers/clk/sophgo/clk-common.h
>   create mode 100644 drivers/clk/sophgo/clk-cv1800b.c
>   create mode 100644 drivers/clk/sophgo/clk-cv1800b.h
>   create mode 100644 drivers/clk/sophgo/clk-ip.c
>   create mode 100644 drivers/clk/sophgo/clk-ip.h
>   create mode 100644 drivers/clk/sophgo/clk-pll.c
>   create mode 100644 drivers/clk/sophgo/clk-pll.h
>   create mode 100644 drivers/crypto/aspeed/cptra_sha.c
>   create mode 100644 drivers/gpio/gpio-aspeed-g7.c
>   create mode 100644 drivers/gpio/npcm_sgpio.c
>   create mode 100644 drivers/mmc/sdhci-cadence.h
>   create mode 100644 drivers/mmc/sdhci-cadence6.c
>   create mode 100644 drivers/net/dwc_eth_qos_intel.c
>   create mode 100644 drivers/net/dwc_eth_qos_intel.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v2.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v3.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v4.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v5.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v6.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-v2.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-v3.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-v4.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v3.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v4.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v6.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-com.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-pll.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v3.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v4.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-ufs.c
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp.h
>   create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8150.c
>   create mode 100644 drivers/power/regulator/tps6287x_regulator.c
>   create mode 100644 drivers/ram/aspeed/dwc_ddrphy_phyinit_ddr4-3200-nodimm-train2D.c
>   create mode 100644 drivers/ram/aspeed/dwc_ddrphy_phyinit_ddr5-3200-nodimm-train2D.c
>   create mode 100644 drivers/ram/aspeed/sdram_ast2700.c
>   create mode 100644 drivers/timer/ast_ibex_timer.c
>   create mode 100644 drivers/usb/gadget/rcar/Makefile
>   create mode 100644 drivers/usb/gadget/rcar/common.c
>   create mode 100644 drivers/usb/gadget/rcar/common.h
>   create mode 100644 drivers/usb/gadget/rcar/fifo.c
>   create mode 100644 drivers/usb/gadget/rcar/fifo.h
>   create mode 100644 drivers/usb/gadget/rcar/mod.c
>   create mode 100644 drivers/usb/gadget/rcar/mod.h
>   create mode 100644 drivers/usb/gadget/rcar/mod_gadget.c
>   create mode 100644 drivers/usb/gadget/rcar/pipe.c
>   create mode 100644 drivers/usb/gadget/rcar/pipe.h
>   create mode 100644 drivers/usb/gadget/rcar/renesas_usb.h
>   delete mode 100644 dts/upstream/Bindings/arm/amlogic/analog-top.txt
>   delete mode 100644 dts/upstream/Bindings/arm/amlogic/assist.txt
>   delete mode 100644 dts/upstream/Bindings/arm/amlogic/bootrom.txt
>   delete mode 100644 dts/upstream/Bindings/arm/amlogic/pmu.txt
>   create mode 100644 dts/upstream/Bindings/arm/arm,juno-fpga-apb-regs.yaml
>   delete mode 100644 dts/upstream/Bindings/arm/freescale/fsl,vf610-mscm-cpucfg.txt
>   delete mode 100644 dts/upstream/Bindings/arm/rtsm-dcscb.txt
>   delete mode 100644 dts/upstream/Bindings/arm/spear-misc.txt
>   delete mode 100644 dts/upstream/Bindings/ata/ahci-fsl-qoriq.txt
>   create mode 100644 dts/upstream/Bindings/ata/fsl,ahci.yaml
>   create mode 100644 dts/upstream/Bindings/cache/starfive,jh8100-starlink-cache.yaml
>   delete mode 100644 dts/upstream/Bindings/clock/amlogic,axg-audio-clkc.txt
>   create mode 100644 dts/upstream/Bindings/clock/amlogic,axg-audio-clkc.yaml
>   create mode 100644 dts/upstream/Bindings/clock/amlogic,c3-peripherals-clkc.yaml
>   create mode 100644 dts/upstream/Bindings/clock/amlogic,c3-pll-clkc.yaml
>   create mode 100644 dts/upstream/Bindings/clock/fsl,qoriq-clock-legacy.yaml
>   create mode 100644 dts/upstream/Bindings/clock/fsl,qoriq-clock.yaml
>   rename dts/upstream/Bindings/clock/{qcom,gcc-other.yaml => qcom,gcc-mdm9607.yaml} (87%)
>   create mode 100644 dts/upstream/Bindings/clock/qcom,gcc-mdm9615.yaml
>   create mode 100644 dts/upstream/Bindings/clock/qcom,qca8k-nsscc.yaml
>   create mode 100644 dts/upstream/Bindings/clock/qcom,qcm2290-gpucc.yaml
>   create mode 100644 dts/upstream/Bindings/clock/qcom,sm7150-camcc.yaml
>   create mode 100644 dts/upstream/Bindings/clock/qcom,sm7150-dispcc.yaml
>   create mode 100644 dts/upstream/Bindings/clock/qcom,sm7150-videocc.yaml
>   delete mode 100644 dts/upstream/Bindings/clock/qoriq-clock.txt
>   create mode 100644 dts/upstream/Bindings/clock/sophgo,sg2042-clkgen.yaml
>   create mode 100644 dts/upstream/Bindings/clock/sophgo,sg2042-pll.yaml
>   create mode 100644 dts/upstream/Bindings/clock/sophgo,sg2042-rpgate.yaml
>   delete mode 100644 dts/upstream/Bindings/clock/sprd,sc9860-clk.txt
>   create mode 100644 dts/upstream/Bindings/clock/sprd,sc9860-clk.yaml
>   delete mode 100644 dts/upstream/Bindings/clock/stericsson,abx500.txt
>   create mode 100644 dts/upstream/Bindings/clock/thead,th1520-clk-ap.yaml
>   delete mode 100644 dts/upstream/Bindings/clock/ti-keystone-pllctrl.txt
>   create mode 100644 dts/upstream/Bindings/display/msm/qcom,sm7150-dpu.yaml
>   create mode 100644 dts/upstream/Bindings/display/msm/qcom,sm7150-mdss.yaml
>   create mode 100644 dts/upstream/Bindings/display/panel/anbernic,rg35xx-plus-panel.yaml
>   create mode 100644 dts/upstream/Bindings/display/panel/himax,hx83102.yaml
>   create mode 100644 dts/upstream/Bindings/display/panel/ilitek,ili9806e.yaml
>   create mode 100644 dts/upstream/Bindings/display/panel/panel-edp-legacy.yaml
>   create mode 100644 dts/upstream/Bindings/display/panel/samsung,atna33xc20.yaml
>   delete mode 100644 dts/upstream/Bindings/display/panel/sharp,ld-d5116z01b.yaml
>   create mode 100644 dts/upstream/Bindings/display/st,stm32mp25-lvds.yaml
>   create mode 100644 dts/upstream/Bindings/dma/fsl,imx-dma.yaml
>   delete mode 100644 dts/upstream/Bindings/dma/fsl-imx-dma.txt
>   delete mode 100644 dts/upstream/Bindings/dma/fsl-qdma.txt
>   create mode 100644 dts/upstream/Bindings/dma/fsl-qdma.yaml
>   create mode 100644 dts/upstream/Bindings/dma/sprd,sc9860-dma.yaml
>   delete mode 100644 dts/upstream/Bindings/dma/sprd-dma.txt
>   rename dts/upstream/Bindings/dma/{ => stm32}/st,stm32-dma.yaml (97%)
>   create mode 100644 dts/upstream/Bindings/dma/stm32/st,stm32-dma3.yaml
>   rename dts/upstream/Bindings/dma/{ => stm32}/st,stm32-dmamux.yaml (90%)
>   rename dts/upstream/Bindings/dma/{ => stm32}/st,stm32-mdma.yaml (96%)
>   create mode 100644 dts/upstream/Bindings/firmware/cznic,turris-omnia-mcu.yaml
>   create mode 100644 dts/upstream/Bindings/firmware/nxp,imx95-scmi-pinctrl.yaml
>   create mode 100644 dts/upstream/Bindings/fsi/aspeed,ast2600-fsi-master.yaml
>   create mode 100644 dts/upstream/Bindings/fsi/fsi-controller.yaml
>   delete mode 100644 dts/upstream/Bindings/fsi/fsi-master-aspeed.txt
>   create mode 100644 dts/upstream/Bindings/fsi/ibm,p9-fsi-controller.yaml
>   delete mode 100644 dts/upstream/Bindings/fsi/ibm,p9-occ.txt
>   create mode 100644 dts/upstream/Bindings/fsi/ibm,p9-occ.yaml
>   create mode 100644 dts/upstream/Bindings/fsi/ibm,p9-sbefifo.yaml
>   create mode 100644 dts/upstream/Bindings/fsi/ibm,p9-scom.yaml
>   create mode 100644 dts/upstream/Bindings/fuse/renesas,rcar-efuse.yaml
>   create mode 100644 dts/upstream/Bindings/fuse/renesas,rcar-otp.yaml
>   create mode 100644 dts/upstream/Bindings/gpio/atmel,at91rm9200-gpio.yaml
>   create mode 100644 dts/upstream/Bindings/gpio/fsl,qoriq-gpio.yaml
>   delete mode 100644 dts/upstream/Bindings/gpio/gpio-mpc8xxx.txt
>   delete mode 100644 dts/upstream/Bindings/gpio/gpio-zevio.txt
>   delete mode 100644 dts/upstream/Bindings/gpio/gpio_atmel.txt
>   create mode 100644 dts/upstream/Bindings/gpio/lsi,zevio-gpio.yaml
>   delete mode 100644 dts/upstream/Bindings/hwmon/g762.txt
>   create mode 100644 dts/upstream/Bindings/hwmon/gmt,g762.yaml
>   create mode 100644 dts/upstream/Bindings/hwmon/maxim,max6639.yaml
>   delete mode 100644 dts/upstream/Bindings/i2c/i2c-fsi.txt
>   delete mode 100644 dts/upstream/Bindings/i2c/i2c-lpc2k.txt
>   create mode 100644 dts/upstream/Bindings/i2c/ibm,i2c-fsi.yaml
>   create mode 100644 dts/upstream/Bindings/i2c/nxp,lpc1788-i2c.yaml
>   create mode 100644 dts/upstream/Bindings/iio/adc/adi,ad7380.yaml
>   create mode 100644 dts/upstream/Bindings/iio/adc/mediatek,mt6359-auxadc.yaml
>   create mode 100644 dts/upstream/Bindings/iio/adc/ti,ads1119.yaml
>   create mode 100644 dts/upstream/Bindings/iio/chemical/sciosense,ens160.yaml
>   create mode 100644 dts/upstream/Bindings/incomplete-devices.yaml
>   create mode 100644 dts/upstream/Bindings/input/cirrus,cs40l50.yaml
>   delete mode 100644 dts/upstream/Bindings/input/ti,nspire-keypad.txt
>   create mode 100644 dts/upstream/Bindings/input/ti,nspire-keypad.yaml
>   delete mode 100644 dts/upstream/Bindings/input/touchscreen/ektf2127.txt
>   create mode 100644 dts/upstream/Bindings/input/touchscreen/elan,ektf2127.yaml
>   create mode 100644 dts/upstream/Bindings/interconnect/mediatek,mt8183-emi.yaml
>   create mode 100644 dts/upstream/Bindings/interconnect/qcom,msm8953.yaml
>   create mode 100644 dts/upstream/Bindings/interrupt-controller/fsl,ls-msi.yaml
>   delete mode 100644 dts/upstream/Bindings/interrupt-controller/fsl,ls-scfg-msi.txt
>   delete mode 100644 dts/upstream/Bindings/interrupt-controller/marvell,armada-370-xp-mpic.txt
>   create mode 100644 dts/upstream/Bindings/interrupt-controller/marvell,mpic.yaml
>   create mode 100644 dts/upstream/Bindings/interrupt-controller/microchip,lan966x-oic.yaml
>   delete mode 100644 dts/upstream/Bindings/interrupt-controller/riscv,cpu-intc.txt
>   create mode 100644 dts/upstream/Bindings/interrupt-controller/riscv,cpu-intc.yaml
>   delete mode 100644 dts/upstream/Bindings/iommu/msm,iommu-v0.txt
>   create mode 100644 dts/upstream/Bindings/iommu/qcom,apq8064-iommu.yaml
>   create mode 100644 dts/upstream/Bindings/leds/backlight/ti,lm3509.yaml
>   create mode 100644 dts/upstream/Bindings/leds/silergy,sy7802.yaml
>   create mode 100644 dts/upstream/Bindings/mailbox/mediatek,gce-props.yaml
>   create mode 100644 dts/upstream/Bindings/mailbox/qcom,cpucp-mbox.yaml
>   create mode 100644 dts/upstream/Bindings/media/i2c/galaxycore,gc05a2.yaml
>   create mode 100644 dts/upstream/Bindings/media/i2c/galaxycore,gc08a3.yaml
>   create mode 100644 dts/upstream/Bindings/media/i2c/maxim,max96714.yaml
>   create mode 100644 dts/upstream/Bindings/media/i2c/maxim,max96717.yaml
>   rename dts/upstream/Bindings/media/i2c/{imx258.yaml => sony,imx258.yaml} (88%)
>   create mode 100644 dts/upstream/Bindings/media/i2c/sony,imx283.yaml
>   create mode 100644 dts/upstream/Bindings/media/img,e5010-jpeg-enc.yaml
>   create mode 100644 dts/upstream/Bindings/media/mediatek,mt7622-cir.yaml
>   delete mode 100644 dts/upstream/Bindings/media/mtk-cir.txt
>   create mode 100644 dts/upstream/Bindings/media/raspberrypi,pispbe.yaml
>   create mode 100644 dts/upstream/Bindings/mfd/marvell,88pm886-a1.yaml
>   delete mode 100644 dts/upstream/Bindings/mfd/rockchip,rk809.yaml
>   create mode 100644 dts/upstream/Bindings/mfd/rohm,bd96801-pmic.yaml
>   create mode 100644 dts/upstream/Bindings/mfd/syscon-common.yaml
>   delete mode 100644 dts/upstream/Bindings/misc/fsl,qoriq-mc.txt
>   create mode 100644 dts/upstream/Bindings/misc/fsl,qoriq-mc.yaml
>   create mode 100644 dts/upstream/Bindings/mmc/fsl,esdhc.yaml
>   delete mode 100644 dts/upstream/Bindings/mmc/fsl-esdhc.txt
>   delete mode 100644 dts/upstream/Bindings/mmc/sdhci-sprd.txt
>   create mode 100644 dts/upstream/Bindings/mmc/sprd,sdhci-r11.yaml
>   create mode 100644 dts/upstream/Bindings/net/airoha,en7581-eth.yaml
>   delete mode 100644 dts/upstream/Bindings/net/arc_emac.txt
>   create mode 100644 dts/upstream/Bindings/net/bluetooth/mediatek,mt7622-bluetooth.yaml
>   create mode 100644 dts/upstream/Bindings/net/dsa/lantiq,gswip.yaml
>   delete mode 100644 dts/upstream/Bindings/net/dsa/lantiq-gswip.txt
>   delete mode 100644 dts/upstream/Bindings/net/dsa/vitesse,vsc73xx.txt
>   create mode 100644 dts/upstream/Bindings/net/dsa/vitesse,vsc73xx.yaml
>   create mode 100644 dts/upstream/Bindings/net/fsl,enetc-ierb.yaml
>   create mode 100644 dts/upstream/Bindings/net/fsl,enetc-mdio.yaml
>   create mode 100644 dts/upstream/Bindings/net/fsl,enetc.yaml
>   create mode 100644 dts/upstream/Bindings/net/fsl,fman-mdio.yaml
>   create mode 100644 dts/upstream/Bindings/net/fsl,fman-muram.yaml
>   create mode 100644 dts/upstream/Bindings/net/fsl,fman-port.yaml
>   create mode 100644 dts/upstream/Bindings/net/fsl,fman.yaml
>   delete mode 100644 dts/upstream/Bindings/net/fsl-enetc.txt
>   delete mode 100644 dts/upstream/Bindings/net/fsl-fman.txt
>   create mode 100644 dts/upstream/Bindings/net/pcs/snps,dw-xpcs.yaml
>   create mode 100644 dts/upstream/Bindings/net/wireless/qcom,ath12k.yaml
>   create mode 100644 dts/upstream/Bindings/pci/plda,xpressrich3-axi-common.yaml
>   create mode 100644 dts/upstream/Bindings/pci/rockchip-dw-pcie-common.yaml
>   create mode 100644 dts/upstream/Bindings/pci/rockchip-dw-pcie-ep.yaml
>   create mode 100644 dts/upstream/Bindings/pci/starfive,jh7110-pcie.yaml
>   create mode 100644 dts/upstream/Bindings/phy/airoha,en7581-pcie-phy.yaml
>   create mode 100644 dts/upstream/Bindings/phy/fsl,imx8qm-hsio.yaml
>   create mode 100644 dts/upstream/Bindings/phy/rockchip,rk3399-emmc-phy.yaml
>   delete mode 100644 dts/upstream/Bindings/phy/rockchip-emmc-phy.txt
>   create mode 100644 dts/upstream/Bindings/phy/starfive,jh7110-dphy-tx.yaml
>   rename dts/upstream/Bindings/pinctrl/{fsl,imx93-pinctrl.yaml => fsl,imx9-pinctrl.yaml} (93%)
>   create mode 100644 dts/upstream/Bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
>   create mode 100644 dts/upstream/Bindings/pinctrl/qcom,sm4250-lpass-lpi-pinctrl.yaml
>   create mode 100644 dts/upstream/Bindings/platform/lenovo,yoga-c630-ec.yaml
>   create mode 100644 dts/upstream/Bindings/power/supply/maxim,max17201.yaml
>   create mode 100644 dts/upstream/Bindings/ptp/fsl,ptp.yaml
>   delete mode 100644 dts/upstream/Bindings/ptp/ptp-qoriq.txt
>   create mode 100644 dts/upstream/Bindings/pwm/adi,axi-pwmgen.yaml
>   create mode 100644 dts/upstream/Bindings/pwm/fsl,vf610-ftm-pwm.yaml
>   delete mode 100644 dts/upstream/Bindings/pwm/pwm-fsl-ftm.txt
>   create mode 100644 dts/upstream/Bindings/pwm/pwm-gpio.yaml
>   create mode 100644 dts/upstream/Bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
>   create mode 100644 dts/upstream/Bindings/regulator/qcom,qca6390-pmu.yaml
>   create mode 100644 dts/upstream/Bindings/regulator/rohm,bd96801-regulator.yaml
>   delete mode 100644 dts/upstream/Bindings/regulator/sprd,sc2731-regulator.txt
>   create mode 100644 dts/upstream/Bindings/regulator/sprd,sc2731-regulator.yaml
>   delete mode 100644 dts/upstream/Bindings/regulator/twl-regulator.txt
>   create mode 100644 dts/upstream/Bindings/remoteproc/qcom,sa8775p-pas.yaml
>   create mode 100644 dts/upstream/Bindings/rtc/fsl,ls-ftm-alarm.yaml
>   delete mode 100644 dts/upstream/Bindings/rtc/rtc-fsl-ftm-alarm.txt
>   delete mode 100644 dts/upstream/Bindings/serial/mrvl,pxa-ssp.txt
>   create mode 100644 dts/upstream/Bindings/serial/via,vt8500-uart.yaml
>   delete mode 100644 dts/upstream/Bindings/serial/vt8500-uart.txt
>   delete mode 100644 dts/upstream/Bindings/soc/fsl/bman-portals.txt
>   delete mode 100644 dts/upstream/Bindings/soc/fsl/bman.txt
>   create mode 100644 dts/upstream/Bindings/soc/fsl/cpm_qe/fsl,qe-firmware.yaml
>   create mode 100644 dts/upstream/Bindings/soc/fsl/cpm_qe/fsl,qe-ic.yaml
>   create mode 100644 dts/upstream/Bindings/soc/fsl/cpm_qe/fsl,qe-muram.yaml
>   create mode 100644 dts/upstream/Bindings/soc/fsl/cpm_qe/fsl,qe-si.yaml
>   create mode 100644 dts/upstream/Bindings/soc/fsl/cpm_qe/fsl,qe-siram.yaml
>   create mode 100644 dts/upstream/Bindings/soc/fsl/cpm_qe/fsl,qe.yaml
>   delete mode 100644 dts/upstream/Bindings/soc/fsl/cpm_qe/qe.txt
>   create mode 100644 dts/upstream/Bindings/soc/fsl/fsl,bman-portal.yaml
>   create mode 100644 dts/upstream/Bindings/soc/fsl/fsl,bman.yaml
>   create mode 100644 dts/upstream/Bindings/soc/fsl/fsl,ls1028a-reset.yaml
>   create mode 100644 dts/upstream/Bindings/soc/fsl/fsl,qman-fqd.yaml
>   create mode 100644 dts/upstream/Bindings/soc/fsl/fsl,qman-portal.yaml
>   create mode 100644 dts/upstream/Bindings/soc/fsl/fsl,qman.yaml
>   delete mode 100644 dts/upstream/Bindings/soc/fsl/qman-portals.txt
>   delete mode 100644 dts/upstream/Bindings/soc/fsl/qman.txt
>   create mode 100644 dts/upstream/Bindings/soc/hisilicon/hisilicon,hi3660-usb3-otg-bc.yaml
>   create mode 100644 dts/upstream/Bindings/soc/intel/intel,lgm-syscon.yaml
>   create mode 100644 dts/upstream/Bindings/soc/microchip/microchip,sparx5-cpu-syscon.yaml
>   create mode 100644 dts/upstream/Bindings/soc/mobileye/mobileye,eyeq5-olb.yaml
>   create mode 100644 dts/upstream/Bindings/soc/sprd/sprd,sc9863a-glbregs.yaml
>   create mode 100644 dts/upstream/Bindings/soc/ti/ti,am654-serdes-ctrl.yaml
>   rename dts/upstream/Bindings/{mfd => soc/ti}/ti,j721e-system-controller.yaml (96%)
>   delete mode 100644 dts/upstream/Bindings/sound/ak4104.txt
>   delete mode 100644 dts/upstream/Bindings/sound/ak4554.txt
>   delete mode 100644 dts/upstream/Bindings/sound/amlogic,g12a-tohdmitx.txt
>   create mode 100644 dts/upstream/Bindings/sound/amlogic,g12a-tohdmitx.yaml
>   create mode 100644 dts/upstream/Bindings/sound/asahi-kasei,ak4104.yaml
>   rename dts/upstream/Bindings/sound/{ak4375.yaml => asahi-kasei,ak4375.yaml} (94%)
>   create mode 100644 dts/upstream/Bindings/sound/asahi-kasei,ak4554.yaml
>   rename dts/upstream/Bindings/sound/{ak4613.yaml => asahi-kasei,ak4613.yaml} (94%)
>   create mode 100644 dts/upstream/Bindings/sound/asahi-kasei,ak4619.yaml
>   rename dts/upstream/Bindings/sound/{ak4642.yaml => asahi-kasei,ak4642.yaml} (94%)
>   create mode 100644 dts/upstream/Bindings/sound/cirrus,cs4270.yaml
>   create mode 100644 dts/upstream/Bindings/sound/cirrus,cs42xx8.yaml
>   create mode 100644 dts/upstream/Bindings/sound/cirrus,cs530x.yaml
>   delete mode 100644 dts/upstream/Bindings/sound/cs4270.txt
>   delete mode 100644 dts/upstream/Bindings/sound/cs42xx8.txt
>   delete mode 100644 dts/upstream/Bindings/sound/everest,es7134.txt
>   create mode 100644 dts/upstream/Bindings/sound/everest,es71x4.yaml
>   delete mode 100644 dts/upstream/Bindings/sound/everest,es7241.txt
>   create mode 100644 dts/upstream/Bindings/sound/everest,es7241.yaml
>   delete mode 100644 dts/upstream/Bindings/sound/fsl,imx-audio-spdif.yaml
>   rename dts/upstream/Bindings/sound/{sgtl5000.yaml => fsl,sgtl5000.yaml} (97%)
>   rename dts/upstream/Bindings/sound/{linux,spdif-dit.yaml => linux,spdif.yaml} (75%)
>   delete mode 100644 dts/upstream/Bindings/sound/maxim,max98088.txt
>   create mode 100644 dts/upstream/Bindings/sound/maxim,max98088.yaml
>   rename dts/upstream/Bindings/sound/{zl38060.yaml => mscc,zl38060.yaml} (96%)
>   create mode 100644 dts/upstream/Bindings/sound/nxp,lpc3220-i2s.yaml
>   delete mode 100644 dts/upstream/Bindings/sound/omap-mcpdm.txt
>   delete mode 100644 dts/upstream/Bindings/sound/qcom,apq8096.txt
>   create mode 100644 dts/upstream/Bindings/sound/qcom,msm8916-wcd-digital-codec.yaml
>   delete mode 100644 dts/upstream/Bindings/sound/qcom,msm8916-wcd-digital.txt
>   create mode 100644 dts/upstream/Bindings/sound/qcom,wcd937x-sdw.yaml
>   create mode 100644 dts/upstream/Bindings/sound/qcom,wcd937x.yaml
>   rename dts/upstream/Bindings/sound/{rt1019.yaml => realtek,rt1019.yaml} (90%)
>   create mode 100644 dts/upstream/Bindings/sound/realtek,rt5514.yaml
>   create mode 100644 dts/upstream/Bindings/sound/realtek,rt5631.yaml
>   create mode 100644 dts/upstream/Bindings/sound/realtek,rt5645.yaml
>   create mode 100644 dts/upstream/Bindings/sound/realtek,rt5659.yaml
>   create mode 100644 dts/upstream/Bindings/sound/realtek,rt5677.yaml
>   delete mode 100644 dts/upstream/Bindings/sound/rt5514.txt
>   delete mode 100644 dts/upstream/Bindings/sound/rt5631.txt
>   delete mode 100644 dts/upstream/Bindings/sound/rt5645.txt
>   delete mode 100644 dts/upstream/Bindings/sound/rt5659.txt
>   delete mode 100644 dts/upstream/Bindings/sound/rt5677.txt
>   delete mode 100644 dts/upstream/Bindings/sound/spdif-receiver.txt
>   delete mode 100644 dts/upstream/Bindings/sound/tas571x.txt
>   create mode 100644 dts/upstream/Bindings/sound/ti,omap4-mcpdm.yaml
>   rename dts/upstream/Bindings/sound/{tas2562.yaml => ti,tas2562.yaml} (97%)
>   rename dts/upstream/Bindings/sound/{tas2770.yaml => ti,tas2770.yaml} (97%)
>   rename dts/upstream/Bindings/sound/{tas27xx.yaml => ti,tas27xx.yaml} (97%)
>   create mode 100644 dts/upstream/Bindings/sound/ti,tas57xx.yaml
>   rename dts/upstream/Bindings/sound/{tas5805m.yaml => ti,tas5805m.yaml} (95%)
>   rename dts/upstream/Bindings/sound/{tlv320adcx140.yaml => ti,tlv320adcx140.yaml} (99%)
>   rename dts/upstream/Bindings/sound/{wm8750.yaml => wlf,wm8750.yaml} (92%)
>   create mode 100644 dts/upstream/Bindings/sound/wlf,wm8782.yaml
>   create mode 100644 dts/upstream/Bindings/sound/wlf,wm8804.yaml
>   delete mode 100644 dts/upstream/Bindings/sound/wm8782.txt
>   delete mode 100644 dts/upstream/Bindings/sound/wm8804.txt
>   delete mode 100644 dts/upstream/Bindings/spi/brcm,bcm2835-spi.txt
>   create mode 100644 dts/upstream/Bindings/spi/brcm,bcm2835-spi.yaml
>   create mode 100644 dts/upstream/Bindings/spi/fsl,dspi-peripheral-props.yaml
>   create mode 100644 dts/upstream/Bindings/spi/fsl,dspi.yaml
>   create mode 100644 dts/upstream/Bindings/spi/ibm,spi-fsi.yaml
>   delete mode 100644 dts/upstream/Bindings/spi/spi-fsl-dspi.txt
>   create mode 100644 dts/upstream/Bindings/thermal/hisilicon,tsensor.yaml
>   delete mode 100644 dts/upstream/Bindings/thermal/hisilicon-thermal.txt
>   create mode 100644 dts/upstream/Bindings/timer/realtek,otto-timer.yaml
>   create mode 100644 dts/upstream/Bindings/timer/sprd,sc9860-timer.yaml
>   delete mode 100644 dts/upstream/Bindings/timer/spreadtrum,sprd-timer.txt
>   create mode 100644 dts/upstream/Bindings/usb/fsl,usb2.yaml
>   delete mode 100644 dts/upstream/Bindings/usb/fsl-usb.txt
>   create mode 100644 dts/upstream/Bindings/watchdog/img,pdc-wdt.yaml
>   delete mode 100644 dts/upstream/Bindings/watchdog/imgpdc-wdt.txt
>   create mode 100644 dts/upstream/include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h
>   create mode 100644 dts/upstream/include/dt-bindings/clock/amlogic,c3-pll-clkc.h
>   create mode 100644 dts/upstream/include/dt-bindings/clock/amlogic,c3-scmi-clkc.h
>   create mode 100644 dts/upstream/include/dt-bindings/clock/qcom,qca8k-nsscc.h
>   create mode 100644 dts/upstream/include/dt-bindings/clock/qcom,qcm2290-gpucc.h
>   create mode 100644 dts/upstream/include/dt-bindings/clock/qcom,sm7150-camcc.h
>   create mode 100644 dts/upstream/include/dt-bindings/clock/qcom,sm7150-dispcc.h
>   create mode 100644 dts/upstream/include/dt-bindings/clock/qcom,sm7150-videocc.h
>   create mode 100644 dts/upstream/include/dt-bindings/clock/qcom,sm8650-camcc.h
>   create mode 100644 dts/upstream/include/dt-bindings/clock/qcom,sm8650-videocc.h
>   delete mode 100644 dts/upstream/include/dt-bindings/clock/r8a7790-clock.h
>   delete mode 100644 dts/upstream/include/dt-bindings/clock/r8a7791-clock.h
>   delete mode 100644 dts/upstream/include/dt-bindings/clock/r8a7792-clock.h
>   delete mode 100644 dts/upstream/include/dt-bindings/clock/r8a7793-clock.h
>   delete mode 100644 dts/upstream/include/dt-bindings/clock/r8a7794-clock.h
>   create mode 100644 dts/upstream/include/dt-bindings/clock/sophgo,sg2042-clkgen.h
>   create mode 100644 dts/upstream/include/dt-bindings/clock/sophgo,sg2042-pll.h
>   create mode 100644 dts/upstream/include/dt-bindings/clock/sophgo,sg2042-rpgate.h
>   create mode 100644 dts/upstream/include/dt-bindings/clock/thead,th1520-clk-ap.h
>   create mode 100644 dts/upstream/include/dt-bindings/i3c/i3c.h
>   create mode 100644 dts/upstream/include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h
>   create mode 100644 dts/upstream/include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h
>   create mode 100644 dts/upstream/include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h
>   create mode 100644 dts/upstream/include/dt-bindings/interconnect/mediatek,mt8183.h
>   create mode 100644 dts/upstream/include/dt-bindings/interconnect/mediatek,mt8195.h
>   create mode 100644 dts/upstream/include/dt-bindings/interconnect/qcom,ipq9574.h
>   create mode 100644 dts/upstream/include/dt-bindings/interconnect/qcom,msm8953.h
>   delete mode 100644 dts/upstream/include/dt-bindings/mfd/qcom-pm8008.h
>   create mode 100644 dts/upstream/include/dt-bindings/power/amlogic,a4-pwrc.h
>   create mode 100644 dts/upstream/include/dt-bindings/power/amlogic,a5-pwrc.h
>   create mode 100644 dts/upstream/include/dt-bindings/regulator/st,stm32mp25-regulator.h
>   create mode 100644 dts/upstream/include/dt-bindings/reset/airoha,en7581-reset.h
>   create mode 100644 dts/upstream/include/dt-bindings/reset/qcom,qca8k-nsscc.h
>   create mode 100644 dts/upstream/include/dt-bindings/sound/audio-graph.h
>   create mode 100644 dts/upstream/src/arm/nxp/imx/imx6dl-kontron-samx6i-ads2.dts
>   create mode 100644 dts/upstream/src/arm/nxp/imx/imx6q-kontron-samx6i-ads2.dts
>   create mode 100644 dts/upstream/src/arm/nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi
>   create mode 100644 dts/upstream/src/arm/qcom/qcom-apq8026-samsung-milletwifi.dts
>   create mode 100644 dts/upstream/src/arm/qcom/qcom-msm8226-samsung-ms013g.dts
>   create mode 100644 dts/upstream/src/arm/qcom/qcom-msm8974-samsung-hlte.dts
>   create mode 100644 dts/upstream/src/arm/qcom/qcom-msm8974pro-htc-m8.dts
>   create mode 100644 dts/upstream/src/arm/qcom/qcom-msm8974pro-sony-xperia-shinano-aries.dts
>   create mode 100644 dts/upstream/src/arm/st/stm32mp135f-dhcor-dhsbc.dts
>   create mode 100644 dts/upstream/src/arm/st/stm32mp13xx-dhcor-som.dtsi
>   create mode 100644 dts/upstream/src/arm64/airoha/en7581-evb.dts
>   create mode 100644 dts/upstream/src/arm64/airoha/en7581.dtsi
>   create mode 100644 dts/upstream/src/arm64/amlogic/meson-g12b-dreambox-one.dts
>   create mode 100644 dts/upstream/src/arm64/amlogic/meson-g12b-dreambox-two.dts
>   create mode 100644 dts/upstream/src/arm64/amlogic/meson-g12b-dreambox.dtsi
>   create mode 100644 dts/upstream/src/arm64/amlogic/meson-gxl-s905x-vero4k.dts
>   create mode 100644 dts/upstream/src/arm64/amlogic/meson-gxlx-s905l-p271.dts
>   create mode 100644 dts/upstream/src/arm64/freescale/imx8-ss-cm41.dtsi
>   create mode 100644 dts/upstream/src/arm64/freescale/imx8mm-iot-gateway.dts
>   create mode 100644 dts/upstream/src/arm64/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso
>   create mode 100644 dts/upstream/src/arm64/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso
>   create mode 100644 dts/upstream/src/arm64/freescale/imx8mm-phygate-tauri-l-rs232-rts-cts.dtso
>   create mode 100644 dts/upstream/src/arm64/freescale/imx8mm-ucm-som.dtsi
>   create mode 100644 dts/upstream/src/arm64/freescale/imx8mp-evk-mx8-dlvds-lcd1.dtso
>   create mode 100644 dts/upstream/src/arm64/freescale/imx8mp-tqma8mpql-mba8mp-ras314.dts
>   create mode 100644 dts/upstream/src/arm64/freescale/imx8qm-ss-audio.dtsi
>   create mode 100644 dts/upstream/src/arm64/freescale/imx93-9x9-qsb.dts
>   create mode 100644 dts/upstream/src/arm64/freescale/imx95-19x19-evk.dts
>   create mode 100644 dts/upstream/src/arm64/freescale/imx95-clock.h
>   create mode 100644 dts/upstream/src/arm64/freescale/imx95-pinfunc.h
>   create mode 100644 dts/upstream/src/arm64/freescale/imx95-power.h
>   create mode 100644 dts/upstream/src/arm64/freescale/imx95.dtsi
>   create mode 100644 dts/upstream/src/arm64/marvell/cn9130-cf-base.dts
>   create mode 100644 dts/upstream/src/arm64/marvell/cn9130-cf-pro.dts
>   create mode 100644 dts/upstream/src/arm64/marvell/cn9130-cf.dtsi
>   create mode 100644 dts/upstream/src/arm64/marvell/cn9130-sr-som.dtsi
>   create mode 100644 dts/upstream/src/arm64/marvell/cn9131-cf-solidwan.dts
>   create mode 100644 dts/upstream/src/arm64/marvell/cn9132-clearfog.dts
>   create mode 100644 dts/upstream/src/arm64/marvell/cn9132-sr-cex7.dtsi
>   create mode 100644 dts/upstream/src/arm64/mediatek/mt7981b-cudy-wr3000-v1.dts
>   create mode 100644 dts/upstream/src/arm64/mediatek/mt7981b-openwrt-one.dts
>   create mode 100644 dts/upstream/src/arm64/mediatek/mt7986a-bananapi-bpi-r3-mini.dts
>   create mode 100644 dts/upstream/src/arm64/mediatek/mt8186-corsola-voltorb-sku589824.dts
>   create mode 100644 dts/upstream/src/arm64/mediatek/mt8186-corsola-voltorb-sku589825.dts
>   create mode 100644 dts/upstream/src/arm64/mediatek/mt8186-corsola-voltorb.dtsi
>   create mode 100644 dts/upstream/src/arm64/mediatek/mt8195-cherry-dojo-r1.dts
>   create mode 100644 dts/upstream/src/arm64/mediatek/mt8390-genio-700-evk.dts
>   create mode 100644 dts/upstream/src/arm64/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
>   rename dts/upstream/src/arm64/nvidia/{tegra234-p3768-0000.dtsi => tegra234-p3768-0000+p3767.dtsi} (90%)
>   create mode 100644 dts/upstream/src/arm64/qcom/apq8016-schneider-hmibsc.dts
>   create mode 100644 dts/upstream/src/arm64/qcom/ipq5018-tplink-archer-ax55-v1.dts
>   create mode 100644 dts/upstream/src/arm64/qcom/msm8916-lg-c50.dts
>   create mode 100644 dts/upstream/src/arm64/qcom/msm8916-lg-m216.dts
>   create mode 100644 dts/upstream/src/arm64/qcom/msm8916-motorola-common.dtsi
>   create mode 100644 dts/upstream/src/arm64/qcom/msm8916-motorola-harpia.dts
>   create mode 100644 dts/upstream/src/arm64/qcom/msm8916-motorola-osprey.dts
>   create mode 100644 dts/upstream/src/arm64/qcom/msm8916-motorola-surnia.dts
>   create mode 100644 dts/upstream/src/arm64/qcom/qcm6490-shift-otter.dts
>   create mode 100644 dts/upstream/src/arm64/qcom/qcs8550-aim300-aiot.dts
>   create mode 100644 dts/upstream/src/arm64/qcom/qcs8550-aim300.dtsi
>   create mode 100644 dts/upstream/src/arm64/qcom/qcs8550.dtsi
>   create mode 100644 dts/upstream/src/arm64/qcom/sa8775p-ride-r3.dts
>   create mode 100644 dts/upstream/src/arm64/qcom/sa8775p-ride.dtsi
>   create mode 100644 dts/upstream/src/arm64/qcom/sc7180-trogdor-clamshell.dtsi
>   create mode 100644 dts/upstream/src/arm64/qcom/sc7180-trogdor-detachable.dtsi
>   create mode 100644 dts/upstream/src/arm64/qcom/sdm450-lenovo-tbx605f.dts
>   create mode 100644 dts/upstream/src/arm64/qcom/sm8550-samsung-q5q.dts
>   create mode 100644 dts/upstream/src/arm64/qcom/sm8650-hdk-display-card.dtso
>   create mode 100644 dts/upstream/src/arm64/qcom/sm8650-hdk.dts
>   create mode 100644 dts/upstream/src/arm64/qcom/x1e80100-asus-vivobook-s15.dts
>   create mode 100644 dts/upstream/src/arm64/qcom/x1e80100-lenovo-yoga-slim7x.dts
>   create mode 100644 dts/upstream/src/arm64/rockchip/rk3368-lba3368.dts
>   delete mode 100644 dts/upstream/src/arm64/rockchip/rk3399pro.dtsi
>   create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-opp.dtsi
>   create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-rock-5b-pcie-ep.dtso
>   create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-rock-5b-pcie-srns.dtso
>   create mode 100644 dts/upstream/src/arm64/ti/k3-am62-lp-sk-nand.dtso
>   create mode 100644 dts/upstream/src/arm64/ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso
>   create mode 100644 dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi
>   create mode 100644 dts/upstream/src/arm64/ti/k3-am62a7-phyboard-lyra-rdk.dts
>   create mode 100644 dts/upstream/src/arm64/ti/k3-am62p-j722s-common-main.dtsi
>   rename dts/upstream/src/arm64/ti/{k3-am62p-mcu.dtsi => k3-am62p-j722s-common-mcu.dtsi} (93%)
>   rename dts/upstream/src/arm64/ti/{k3-am62p-thermal.dtsi => k3-am62p-j722s-common-thermal.dtsi} (100%)
>   rename dts/upstream/src/arm64/ti/{k3-am62p-wakeup.dtsi => k3-am62p-j722s-common-wakeup.dtsi} (93%)
>   create mode 100644 dts/upstream/src/arm64/ti/k3-am62x-phyboard-lyra.dtsi
>   create mode 100644 dts/upstream/src/arm64/ti/k3-am642-evm-icssg1-dualemac-mii.dtso
>   create mode 100644 dts/upstream/src/arm64/ti/k3-am642-evm-nand.dtso
>   create mode 100644 dts/upstream/src/arm64/ti/k3-am642-phyboard-electra-pcie-usb2.dtso
>   create mode 100644 dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-eth-phy.dtso
>   create mode 100644 dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-rtc.dtso
>   create mode 100644 dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-spi-nor.dtso
>   create mode 100644 dts/upstream/src/arm64/ti/k3-am6xx-phycore-qspi-nor.dtso
>   create mode 100644 dts/upstream/src/arm64/ti/k3-j721e-common-proc-board-infotainment.dtso
>   create mode 100644 dts/upstream/src/arm64/ti/k3-j722s-main.dtsi
>   create mode 100644 dts/upstream/src/arm64/ti/k3-j784s4-evm-pcie0-pcie1-ep.dtso
>   create mode 100644 dts/upstream/src/arm64/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso
>   create mode 100644 dts/upstream/src/arm64/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso
>   rename dts/upstream/src/mips/mobileye/{eyeq5-fixed-clocks.dtsi => eyeq5-clocks.dtsi} (88%)
>   create mode 100644 dts/upstream/src/mips/mobileye/eyeq5-pins.dtsi
>   create mode 100644 dts/upstream/src/mips/mobileye/eyeq6h-epm6.dts
>   create mode 100644 dts/upstream/src/mips/mobileye/eyeq6h-fixed-clocks.dtsi
>   create mode 100644 dts/upstream/src/mips/mobileye/eyeq6h-pins.dtsi
>   create mode 100644 dts/upstream/src/mips/mobileye/eyeq6h.dtsi
>   create mode 100644 dts/upstream/src/mips/realtek/cameo-rtl9302c-2x-rtl8224-2xge.dts
>   create mode 100644 dts/upstream/src/mips/realtek/rtl930x.dtsi
>   delete mode 100644 dts/upstream/src/powerpc/acadia.dts
>   delete mode 100644 dts/upstream/src/powerpc/haleakala.dts
>   delete mode 100644 dts/upstream/src/powerpc/hotfoot.dts
>   delete mode 100644 dts/upstream/src/powerpc/kilauea.dts
>   delete mode 100644 dts/upstream/src/powerpc/klondike.dts
>   delete mode 100644 dts/upstream/src/powerpc/makalu.dts
>   delete mode 100644 dts/upstream/src/powerpc/obs600.dts
>   create mode 100644 dts/upstream/src/riscv/allwinner/sun20i-d1-clockworkpi-v3.14.dts
>   create mode 100644 dts/upstream/src/riscv/allwinner/sun20i-d1-devterm-v3.14.dts
>   create mode 100644 dts/upstream/src/riscv/microchip/mpfs-beaglev-fire-fabric.dtsi
>   create mode 100644 dts/upstream/src/riscv/microchip/mpfs-beaglev-fire.dts
>   create mode 100644 dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dts
>   create mode 100644 include/alist.h
>   create mode 100644 include/board_f.h
>   delete mode 100644 include/configs/ethernut5.h
>   create mode 100644 include/configs/ibex_ast2700.h
>   create mode 100644 include/configs/lxr2.h
>   create mode 100644 include/configs/sc573-ezkit.h
>   create mode 100644 include/configs/sc584-ezkit.h
>   create mode 100644 include/configs/sc589.h
>   create mode 100644 include/configs/sc594-som.h
>   create mode 100644 include/configs/sc598-som.h
>   create mode 100644 include/dt-bindings/clock/sophgo,cv1800.h
>   create mode 100644 include/env/phytec/k3_net.env
>   create mode 100644 include/env/phytec/k3_spi.env
>   create mode 100644 include/env/ti/android.env
>   rename include/{ => u-boot}/uuid.h (90%)
>   create mode 100644 include/upl.h
>   create mode 100644 lib/alist.c
>   create mode 100644 test/boot/upl.c
>   create mode 100644 test/lib/alist.c
>   create mode 100644 test/py/tests/test_spi.py
>   create mode 100644 test/py/tests/test_upl.py
>   create mode 100644 tools/binman/test/336_symbols_base.dts
>   create mode 100644 tools/binman/test/337_symbols_base_expand.dts
>   create mode 100644 tools/binman/test/338_symbols_comp.dts
>   create mode 100644 tools/binman/test/339_nxp_imx8.dts

-- 
// Caleb (they/them)

