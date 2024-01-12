Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F412C4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 10:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6813D879B0;
	Fri, 12 Jan 2024 11:55:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A5nj7gFz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D31D879B2; Fri, 12 Jan 2024 11:55:24 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB1E78793B
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 11:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B357761C27;
 Fri, 12 Jan 2024 10:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69D0C43390;
 Fri, 12 Jan 2024 10:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705056920;
 bh=Pl6wx1wQDx8ua7aJ9xI0suJDcPRYNuNrfedncsCpJnc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=A5nj7gFzWkHXh3xMDWCdkJSo8XN1LI0RstOREfkAItwNeGiStkEpoXL9fmyRU+ZbZ
 U7eYCb/c9rgjGOJ3b0yrXUzit/ThRSFa6UUfr3deiW19lvYwGBwQ0xzXhM3ybxyUzQ
 v/CooYKecgxFlYWljK03563vrLLmsYUXA8prms/Zfm5t0jEfBGS5e2y7FIoW7/tzPD
 Lj3m7By1/fFNilQ9FjNu2A7yW4BY4CVLvKp7PNTdgZ3CP+QCS8hQ83C/DE76IPCCoI
 g8l5LUQaL54aMZ/W8h7opBp/dqFJ5F77cuF3yjdBPTpxuL6vorUhatxFujbXnKiCzf
 SgEg9QP8Fu/dg==
Message-ID: <8e4f2030-81fe-4af2-af8f-1919aca66d3f@kernel.org>
Date: Fri, 12 Jan 2024 12:55:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] configs: am62x_evm_*: Enable USB and DFU support
Content-Language: en-US
To: Sjoerd Simons <sjoerd@collabora.com>, u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-6-sjoerd@collabora.com>
 <57e0d59d-ea1d-4396-ae63-2440e0c89eb9@kernel.org>
 <2cd97e2cd89597760eb8c1567be37f78445e1978.camel@collabora.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <2cd97e2cd89597760eb8c1567be37f78445e1978.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 12/01/2024 12:44, Sjoerd Simons wrote:
> On Fri, 2024-01-12 at 11:58 +0200, Roger Quadros wrote:
>> Hi Sjoerd,
>>
>> On 12/01/2024 10:52, Sjoerd Simons wrote:
>>> Enable USB host as well as USB gadget and DFU support for a53; For
>>> the
>>> r5 due to the smaller available size create a config fragment for
>>> DFU
>>> supports which disables support for persistent storage to free up
>>> space
>>> for USB support
>>>
>>> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
>>>
>>> ---
>>>
>>> Changes in v4:
>>> - Move R5 dfu config to a config fragment rather then a full
>>> defconfig
>>> - Don't enable XHCI for the R5 SPL, unneeded
>>>
>>> Changes in v3:
>>> - Run savedefconfig to adjust to more recent u-boot
>>>
>>> Changes in v2:
>>> - Create a seperate defconfig for R5
>>>
>>>  configs/am62x_evm_a53_defconfig | 30
>>> ++++++++++++++++++++++++++++++
>>>  configs/am62x_r5_usbdfu.config  | 28 ++++++++++++++++++++++++++++
>>>  2 files changed, 58 insertions(+)
>>>  create mode 100644 configs/am62x_r5_usbdfu.config
>>>
>>> diff --git a/configs/am62x_evm_a53_defconfig
>>> b/configs/am62x_evm_a53_defconfig
>>> index aa96c1b3125..f335eb11e63 100644
>>> --- a/configs/am62x_evm_a53_defconfig
>>> +++ b/configs/am62x_evm_a53_defconfig
>>> @@ -1,5 +1,6 @@
>>>  CONFIG_ARM=y
>>>  CONFIG_ARCH_K3=y
>>> +CONFIG_SYS_MALLOC_LEN=0x2000000
>>>  CONFIG_SYS_MALLOC_F_LEN=0x8000
>>>  CONFIG_SPL_LIBCOMMON_SUPPORT=y
>>>  CONFIG_SPL_LIBGENERIC_SUPPORT=y
>>> @@ -41,16 +42,23 @@ CONFIG_SPL_SYS_MALLOC_SIMPLE=y
>>>  CONFIG_SPL_STACK_R=y
>>>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
>>>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
>>> +CONFIG_SPL_ENV_SUPPORT=y
>>>  CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
>>>  CONFIG_SPL_DM_MAILBOX=y
>>>  CONFIG_SPL_DM_SPI_FLASH=y
>>>  CONFIG_SPL_POWER_DOMAIN=y
>>> +CONFIG_SPL_RAM_SUPPORT=y
>>> +CONFIG_SPL_RAM_DEVICE=y
>>>  # CONFIG_SPL_SPI_FLASH_TINY is not set
>>>  CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
>>>  CONFIG_SPL_SPI_LOAD=y
>>>  CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
>>> +CONFIG_SPL_USB_GADGET=y
>>> +CONFIG_SPL_DFU=y
>>>  CONFIG_SPL_YMODEM_SUPPORT=y
>>> +CONFIG_CMD_DFU=y
>>>  CONFIG_CMD_MMC=y
>>> +CONFIG_CMD_USB=y
>>>  CONFIG_OF_CONTROL=y
>>>  CONFIG_SPL_OF_CONTROL=y
>>>  CONFIG_MULTI_DTB_FIT=y
>>> @@ -61,10 +69,17 @@ CONFIG_SPL_DM=y
>>>  CONFIG_SPL_DM_SEQ_ALIAS=y
>>>  CONFIG_REGMAP=y
>>>  CONFIG_SPL_REGMAP=y
>>> +CONFIG_SYSCON=y
>>> +CONFIG_SPL_SYSCON=y
>>>  CONFIG_SPL_OF_TRANSLATE=y
>>>  CONFIG_CLK=y
>>>  CONFIG_SPL_CLK=y
>>>  CONFIG_CLK_TI_SCI=y
>>> +CONFIG_DFU_MMC=y
>>> +CONFIG_DFU_RAM=y
>>> +CONFIG_DFU_SF=y
>>> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
>>> +CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
>>>  CONFIG_DMA_CHANNELS=y
>>>  CONFIG_TI_K3_NAVSS_UDMA=y
>>>  CONFIG_TI_SCI_PROTOCOL=y
>>> @@ -103,4 +118,19 @@ CONFIG_CADENCE_QSPI=y
>>>  CONFIG_SYSRESET=y
>>>  CONFIG_SPL_SYSRESET=y
>>>  CONFIG_SYSRESET_TI_SCI=y
>>> +CONFIG_USB=y
>>> +CONFIG_DM_USB_GADGET=y
>>> +CONFIG_SPL_DM_USB_GADGET=y
>>> +CONFIG_USB_XHCI_HCD=y
>>> +CONFIG_USB_XHCI_DWC3=y
>>> +CONFIG_USB_DWC3=y
>>> +CONFIG_USB_DWC3_GENERIC=y
>>> +CONFIG_SPL_USB_DWC3_GENERIC=y
>>> +CONFIG_SPL_USB_DWC3_AM62=y
>>> +CONFIG_USB_DWC3_AM62=y
>>> +CONFIG_USB_GADGET=y
>>> +CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
>>> +CONFIG_USB_GADGET_VENDOR_NUM=0x0451
>>> +CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
>>> +CONFIG_USB_GADGET_DOWNLOAD=y
>>>  CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>>> diff --git a/configs/am62x_r5_usbdfu.config
>>> b/configs/am62x_r5_usbdfu.config
>>> new file mode 100644
>>> index 00000000000..772bb2ab935
>>> --- /dev/null
>>> +++ b/configs/am62x_r5_usbdfu.config
>>> @@ -0,0 +1,28 @@
>>> +CONFIG_SPL_ENV_SUPPORT=y
>>> +CONFIG_SYSCON=y
>>> +CONFIG_SPL_SYSCON=y
>>> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
>>> +CONFIG_MISC=y
>>> +CONFIG_USB=y
>>> +CONFIG_DM_USB_GADGET=y
>>> +CONFIG_SPL_DM_USB_GADGET=y
>>> +CONFIG_USB_DWC3=y
>>> +CONFIG_USB_DWC3_GENERIC=y
>>> +CONFIG_SPL_USB_DWC3_GENERIC=y
>>> +CONFIG_SPL_USB_DWC3_AM62=y
>>> +CONFIG_USB_GADGET=y
>>> +CONFIG_SPL_USB_GADGET=y
>>> +CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
>>> +CONFIG_USB_GADGET_VENDOR_NUM=0x0451
>>> +CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
>>> +CONFIG_USB_GADGET_DOWNLOAD=y
>>> +CONFIG_SPL_DFU=y
>>
>> Why do we need USB DFU support at R5 SPL stage?
>> What is the use case?
> 
> So we can load the A53 SPL over DFU ? There is no way to get a full DFU
> bootchain without the R5 also taking part 
> 
> 
Got it. I should have read the documentation in patch 7 before asking. ;)

-- 
cheers,
-roger
