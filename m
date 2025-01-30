Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEA9C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 13:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C8BD820B0;
	Thu, 30 Jan 2025 14:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qr3ijE+s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49751820E8; Thu, 30 Jan 2025 14:39:23 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1361181F69
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 14:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so5716945e9.3
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 05:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738244360; x=1738849160; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AMTMjSyf7ALHAxEtycWRV1z5jMeGTiytluWdibXWYwc=;
 b=qr3ijE+slFJgc366iWttN6WccBe/QBiPxcril5ERebRgnl8jdKENEGTDT7w/Thk5//
 1SLnWS5CLh3oOnIiZv+2E0YQ8ZsjMZf0rjVeAvCdOxBEQHYREXPljdVBmX/fxCyr1vS+
 CnC51qKKCRp70qdK0r/4+s4tmUMDQNBnsSfR2gDpFL6uyHVvjvNhILi6aVRYL9jNFXq5
 qsdwOPnc+iDjdH/DA0FW5u2goAE/yu2gx0yKFvS0BXA+gKfmfpncHMLdthDnDVu4lLgg
 yAvGzA++ml/KlD6qigJsOsYnIRcz8tL7tilwPkRxX8F50zg6nBiXnCYhR2Yu0rcNZEvM
 yNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738244360; x=1738849160;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMTMjSyf7ALHAxEtycWRV1z5jMeGTiytluWdibXWYwc=;
 b=Des+U6VmzSprm+dITXq6rDJ82TIJQ5b7rn9JPgW8ydmYvJ9/12DZY5YrdBzddXpVBl
 lgGXEmPdzpyAmi0NzUd572c5Tb0K7C+R/uv40/kyLqHpF9b1kbF7QzF6X4688wKyNDDF
 zgK/Y2Z91NKYhiiWJFQvAcfS63KjnYd+0HtgYF+88KFQgNkFYJrjJeC950Jbff/wCa9u
 sTm/pMZ2Lb99xt3I++m+/VUKV3GunoffK6jFuvicB7zfc9mfWmms49mFuljSVSlLlhY7
 2ff778wSF6D3aMznhn9YF8tFAq8fN6dxPtPl5Cu9YDHfDI8S1+kdqczI74IdJ5XKZbSl
 xJBw==
X-Gm-Message-State: AOJu0YzxZmCDrMKx2yhwIScNm3RJPSWHRM8io2uWpjTlR0yWqqT7rmqq
 DKHk52B3vvbLPh57eSC4Lh0hIXTl2YYwpyHPlYm+y0qDc2TYTTYMZNvGizsOAhc=
X-Gm-Gg: ASbGncuSi5scCrYyr2saTVeQWc2d8D+3Xlq+y1G3be4wbJbdab40Hid6q9AkL+6F92t
 bGyetexCHut02f6iCV/Kqgz9N+8RRw3hsrNgd+6jO4c+ruBEGhf369IJeLMFwn+zy6ojkFJLEcS
 aHLrGS2zv4lDluom3qLMNM3WVSWLIXxWoirxEck0cwg36fUe2FmsR/EDihox97Cgj+BQo5ncCru
 pQy8ggPI0V52SgaMika9cPvfWumje4hLDNzFDjWRsPcdz60GPAK2NZQsYHQn8EEmnmp0yrDbt3T
 m6Gnc3N0Udf4tq9v/B8Bs/tZbItAUOr/4HWQuwzUFEf2HQ==
X-Google-Smtp-Source: AGHT+IFZC71B9512IvPlxcBbLsfVAHPlfJl1kUH56r2j25C17yiThTcmlrbgYZWzx46woI4zUz+v0w==
X-Received: by 2002:a05:600c:468e:b0:434:e8cf:6390 with SMTP id
 5b1f17b1804b1-438dc3a3e9amr62931025e9.6.1738244360383; 
 Thu, 30 Jan 2025 05:39:20 -0800 (PST)
Received: from hera (ppp176092181030.access.hol.gr. [176.92.181.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc80e61sm60281895e9.34.2025.01.30.05.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 05:39:19 -0800 (PST)
Date: Thu, 30 Jan 2025 15:39:17 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Srinivas Goud <srinivas.goud@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH] xilinx: Enable MBEDTLS/LWIP/WGET and WGET_HTTPS
Message-ID: <Z5uBBfKtYhRK-qfl@hera>
References: <cb05adaf0758c2c4f1361f8665169897493638e7.1738164681.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb05adaf0758c2c4f1361f8665169897493638e7.1738164681.git.michal.simek@amd.com>
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

On Wed, Jan 29, 2025 at 04:31:25PM +0100, Michal Simek wrote:
> Enable lwip and https on our platforms to be able to use it in a boot.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  configs/amd_versal2_virt_defconfig       | 11 ++++-------
>  configs/microblaze-generic_defconfig     |  8 ++++----
>  configs/xilinx_versal_net_virt_defconfig | 10 +++-------
>  configs/xilinx_versal_virt_defconfig     | 10 +++-------
>  configs/xilinx_zynq_virt_defconfig       |  7 ++-----
>  configs/xilinx_zynqmp_kria_defconfig     | 15 +++------------
>  configs/xilinx_zynqmp_virt_defconfig     | 17 +++--------------
>  7 files changed, 22 insertions(+), 56 deletions(-)
>
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index 57a6a06df7cd..8bee002777a5 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -17,6 +17,7 @@ CONFIG_DEBUG_UART=y
>  CONFIG_SYS_MEMTEST_START=0x00000000
>  CONFIG_SYS_MEMTEST_END=0x00001000
>  CONFIG_REMAKE_ELF=y
> +CONFIG_EFI_HTTP_BOOT=y
>  CONFIG_FIT=y
>  CONFIG_FIT_VERBOSE=y
>  CONFIG_DISTRO_DEFAULTS=y
> @@ -47,10 +48,7 @@ CONFIG_CMD_SF_TEST=y
>  CONFIG_CMD_SPI=y
>  CONFIG_CMD_UFS=y
>  CONFIG_CMD_USB=y
> -CONFIG_BOOTP_MAY_FAIL=y
> -CONFIG_BOOTP_BOOTFILESIZE=y
> -CONFIG_CMD_TFTPPUT=y
> -CONFIG_CMD_NFS=y
> +CONFIG_WGET_HTTPS=y
>  CONFIG_CMD_CACHE=y
>  CONFIG_CMD_EFIDEBUG=y
>  CONFIG_CMD_TIME=y
> @@ -70,9 +68,7 @@ CONFIG_DTB_RESELECT=y
>  CONFIG_MULTI_DTB_FIT=y
>  CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_NETCONSOLE=y
> -CONFIG_IP_DEFRAG=y
> -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
> +CONFIG_NET_LWIP=y
>  CONFIG_NET_RANDOM_ETHADDR=y
>  CONFIG_TFTP_BLOCKSIZE=4096
>  CONFIG_SIMPLE_PM_BUS=y
> @@ -155,6 +151,7 @@ CONFIG_UFS_AMD_VERSAL2=y
>  CONFIG_VIRTIO_MMIO=y
>  CONFIG_VIRTIO_NET=y
>  CONFIG_VIRTIO_BLK=y
> +CONFIG_MBEDTLS_LIB=y
>  CONFIG_TPM=y
>  # CONFIG_OPTEE_LIB is not set
>  CONFIG_TOOLS_MKFWUMDATA=y
> diff --git a/configs/microblaze-generic_defconfig b/configs/microblaze-generic_defconfig
> index 87756cb26df5..6075c6a2beed 100644
> --- a/configs/microblaze-generic_defconfig
> +++ b/configs/microblaze-generic_defconfig
> @@ -46,16 +46,15 @@ CONFIG_CMD_MEMINFO=y
>  CONFIG_CMD_MEMINFO_MAP=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_SAVES=y
> -CONFIG_BOOTP_BOOTFILESIZE=y
> -CONFIG_CMD_TFTPPUT=y
> +CONFIG_CMD_WGET=y
> +CONFIG_WGET_HTTPS=y
>  CONFIG_CMD_CACHE=y
>  CONFIG_SPL_OF_CONTROL=y
>  CONFIG_OF_EMBED=y
>  CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>  CONFIG_USE_HOSTNAME=y
>  CONFIG_HOSTNAME="microblaze-generic"
> -CONFIG_NETCONSOLE=y
> -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
> +CONFIG_NET_LWIP=y
>  CONFIG_NET_RANDOM_ETHADDR=y
>  CONFIG_SPL_DM=y
>  CONFIG_XILINX_GPIO=y
> @@ -99,3 +98,4 @@ CONFIG_SYSRESET_GPIO=y
>  CONFIG_SYSRESET_MICROBLAZE=y
>  CONFIG_WDT=y
>  CONFIG_XILINX_TB_WATCHDOG=y
> +CONFIG_MBEDTLS_LIB=y
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index 081ad424a9aa..5ef5fd44fd37 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -46,10 +46,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
>  CONFIG_CMD_MTD=y
>  CONFIG_CMD_SF_TEST=y
>  CONFIG_CMD_USB=y
> -CONFIG_BOOTP_MAY_FAIL=y
> -CONFIG_BOOTP_BOOTFILESIZE=y
> -CONFIG_CMD_TFTPPUT=y
> -CONFIG_CMD_NFS=y
> +CONFIG_WGET_HTTPS=y
>  CONFIG_CMD_CACHE=y
>  CONFIG_CMD_EFIDEBUG=y
>  CONFIG_CMD_TIME=y
> @@ -71,9 +68,7 @@ CONFIG_ENV_IS_IN_FAT=y
>  CONFIG_ENV_IS_IN_SPI_FLASH=y
>  CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_NETCONSOLE=y
> -CONFIG_IP_DEFRAG=y
> -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
> +CONFIG_NET_LWIP=y
>  CONFIG_NET_RANDOM_ETHADDR=y
>  CONFIG_TFTP_BLOCKSIZE=4096
>  CONFIG_SIMPLE_PM_BUS=y
> @@ -155,4 +150,5 @@ CONFIG_USB_FUNCTION_THOR=y
>  CONFIG_VIRTIO_MMIO=y
>  CONFIG_VIRTIO_NET=y
>  CONFIG_VIRTIO_BLK=y
> +CONFIG_MBEDTLS_LIB=y
>  CONFIG_TPM=y
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index 70e73ac7ad45..f228eef7c959 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -52,10 +52,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
>  CONFIG_CMD_MTD=y
>  CONFIG_CMD_SF_TEST=y
>  CONFIG_CMD_USB=y
> -CONFIG_BOOTP_MAY_FAIL=y
> -CONFIG_BOOTP_BOOTFILESIZE=y
> -CONFIG_CMD_TFTPPUT=y
> -CONFIG_CMD_NFS=y
> +CONFIG_WGET_HTTPS=y
>  CONFIG_CMD_CACHE=y
>  CONFIG_CMD_EFIDEBUG=y
>  CONFIG_CMD_TIME=y
> @@ -75,9 +72,7 @@ CONFIG_ENV_IS_IN_FAT=y
>  CONFIG_ENV_IS_IN_SPI_FLASH=y
>  CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_NETCONSOLE=y
> -CONFIG_IP_DEFRAG=y
> -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
> +CONFIG_NET_LWIP=y
>  CONFIG_NET_RANDOM_ETHADDR=y
>  CONFIG_TFTP_BLOCKSIZE=4096
>  CONFIG_SIMPLE_PM_BUS=y
> @@ -170,5 +165,6 @@ CONFIG_USB_FUNCTION_THOR=y
>  CONFIG_VIRTIO_MMIO=y
>  CONFIG_VIRTIO_NET=y
>  CONFIG_VIRTIO_BLK=y
> +CONFIG_MBEDTLS_LIB=y
>  CONFIG_TPM=y
>  CONFIG_TOOLS_MKFWUMDATA=y
> diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
> index c2422c5b4dcf..fdf8bb361294 100644
> --- a/configs/xilinx_zynq_virt_defconfig
> +++ b/configs/xilinx_zynq_virt_defconfig
> @@ -73,9 +73,6 @@ CONFIG_CMD_MTD=y
>  CONFIG_CMD_NAND_LOCK_UNLOCK=y
>  CONFIG_CMD_SF_TEST=y
>  CONFIG_CMD_USB=y
> -CONFIG_BOOTP_MAY_FAIL=y
> -CONFIG_CMD_TFTPPUT=y
> -CONFIG_CMD_NFS=y
>  CONFIG_CMD_CACHE=y
>  CONFIG_CMD_EFIDEBUG=y
>  CONFIG_CMD_TIME=y
> @@ -94,8 +91,7 @@ CONFIG_ENV_IS_IN_NAND=y
>  CONFIG_ENV_IS_IN_SPI_FLASH=y
>  CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_NETCONSOLE=y
> -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
> +CONFIG_NET_LWIP=y
>  CONFIG_NET_RANDOM_ETHADDR=y
>  CONFIG_SPL_DM_SEQ_ALIAS=y
>  CONFIG_SIMPLE_PM_BUS=y
> @@ -160,4 +156,5 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x0300
>  CONFIG_CI_UDC=y
>  CONFIG_USB_GADGET_DOWNLOAD=y
>  CONFIG_SYS_TIMER_COUNTS_DOWN=y
> +CONFIG_MBEDTLS_LIB=y
>  CONFIG_SPL_GZIP=y
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> index 2258b59e3edd..1e8ec90ff533 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -84,11 +84,7 @@ CONFIG_CMD_SDRAM=y
>  CONFIG_CMD_SF_TEST=y
>  CONFIG_CMD_SPI=y
>  CONFIG_CMD_USB=y
> -CONFIG_CMD_USB_MASS_STORAGE=y
> -CONFIG_BOOTP_MAY_FAIL=y
> -CONFIG_BOOTP_BOOTFILESIZE=y
> -CONFIG_CMD_TFTPPUT=y
> -CONFIG_CMD_NFS=y
> +CONFIG_WGET_HTTPS=y
>  CONFIG_CMD_BMP=y
>  CONFIG_CMD_CACHE=y
>  CONFIG_CMD_EFIDEBUG=y
> @@ -120,8 +116,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
>  CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>  CONFIG_ENV_FAT_DEVICE_AND_PART=":auto"
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_NETCONSOLE=y
> -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
> +CONFIG_NET_LWIP=y
>  CONFIG_NET_RANDOM_ETHADDR=y
>  CONFIG_SPL_DM_SEQ_ALIAS=y
>  CONFIG_SIMPLE_PM_BUS=y
> @@ -131,7 +126,6 @@ CONFIG_SATA_CEVA=y
>  CONFIG_BUTTON=y
>  CONFIG_BUTTON_GPIO=y
>  CONFIG_CLK_ZYNQMP=y
> -CONFIG_DFU_TFTP=y
>  CONFIG_DFU_TIMEOUT=y
>  CONFIG_DFU_MMC=y
>  CONFIG_DFU_MTD=y
> @@ -140,10 +134,6 @@ CONFIG_DFU_SF=y
>  CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
>  CONFIG_DMA=y
>  CONFIG_XILINX_DPDMA=y
> -CONFIG_USB_FUNCTION_FASTBOOT=y
> -CONFIG_FASTBOOT_FLASH=y
> -CONFIG_FASTBOOT_FLASH_MMC_DEV=0
> -CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>  CONFIG_ARM_FFA_TRANSPORT=y
>  CONFIG_FPGA_XILINX=y
>  CONFIG_FPGA_ZYNQMPPL=y
> @@ -231,6 +221,7 @@ CONFIG_VIRTIO_BLK=y
>  # CONFIG_BINMAN_FDT is not set
>  CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-som.dtb"
>  CONFIG_PANIC_HANG=y
> +CONFIG_MBEDTLS_LIB=y
>  CONFIG_TPM=y
>  CONFIG_SPL_GZIP=y
>  CONFIG_TOOLS_MKFWUMDATA=y
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index c0721b65fd48..036268c79f77 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -59,8 +59,6 @@ CONFIG_SPL_ATF=y
>  CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>  CONFIG_CMD_SMBIOS=y
>  CONFIG_CMD_BOOTMENU=y
> -CONFIG_CMD_THOR_DOWNLOAD=y
> -CONFIG_THOR_RESET_OFF=y
>  CONFIG_CMD_GREPENV=y
>  CONFIG_CMD_NVEDIT_EFI=y
>  CONFIG_CMD_MEMINFO=y
> @@ -86,11 +84,7 @@ CONFIG_CMD_SDRAM=y
>  CONFIG_CMD_SF_TEST=y
>  CONFIG_CMD_SPI=y
>  CONFIG_CMD_USB=y
> -CONFIG_CMD_USB_MASS_STORAGE=y
> -CONFIG_BOOTP_MAY_FAIL=y
> -CONFIG_BOOTP_BOOTFILESIZE=y
> -CONFIG_CMD_TFTPPUT=y
> -CONFIG_CMD_NFS=y
> +CONFIG_WGET_HTTPS=y
>  CONFIG_CMD_BMP=y
>  CONFIG_CMD_CACHE=y
>  CONFIG_CMD_EFIDEBUG=y
> @@ -121,8 +115,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
>  CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>  CONFIG_ENV_FAT_DEVICE_AND_PART=":auto"
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_NETCONSOLE=y
> -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
> +CONFIG_NET_LWIP=y
>  CONFIG_NET_RANDOM_ETHADDR=y
>  CONFIG_SPL_DM_SEQ_ALIAS=y
>  CONFIG_SIMPLE_PM_BUS=y
> @@ -132,7 +125,6 @@ CONFIG_SATA_CEVA=y
>  CONFIG_BUTTON=y
>  CONFIG_BUTTON_GPIO=y
>  CONFIG_CLK_ZYNQMP=y
> -CONFIG_DFU_TFTP=y
>  CONFIG_DFU_TIMEOUT=y
>  CONFIG_DFU_MMC=y
>  CONFIG_DFU_MTD=y
> @@ -140,10 +132,6 @@ CONFIG_DFU_NAND=y
>  CONFIG_DFU_RAM=y
>  CONFIG_DFU_SF=y
>  CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
> -CONFIG_USB_FUNCTION_FASTBOOT=y
> -CONFIG_FASTBOOT_FLASH=y
> -CONFIG_FASTBOOT_FLASH_MMC_DEV=0
> -CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>  CONFIG_ARM_FFA_TRANSPORT=y
>  CONFIG_FPGA_XILINX=y
>  CONFIG_FPGA_ZYNQMPPL=y
> @@ -247,6 +235,7 @@ CONFIG_VIRTIO_BLK=y
>  # CONFIG_BINMAN_FDT is not set
>  CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman.dtb"
>  CONFIG_PANIC_HANG=y
> +CONFIG_MBEDTLS_LIB=y
>  CONFIG_TPM=y
>  CONFIG_SPL_GZIP=y
>  CONFIG_TOOLS_MKFWUMDATA=y
> --
> 2.43.0
>

Thanks this helps!
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

