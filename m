Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA5EE77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 16:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 384938005B;
	Thu,  9 Jan 2025 17:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VM2lPjq0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5966D800C2; Thu,  9 Jan 2025 17:45:07 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D98A8001F
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 17:45:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1F9705C5C14;
 Thu,  9 Jan 2025 16:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02777C4CED2;
 Thu,  9 Jan 2025 16:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736441102;
 bh=gaiJZShVKkY/+x8dNTzpGQGPKxV5IgN7dBTTOY/Ck2A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VM2lPjq0mDeC/JAGU8j4me1bxzPPhTY8bSl0hGzhuVBtgkFPCrZPsR5vyhlICVKFY
 tM01YgvoVWi1V7kxs98Zlv+YvbrKNEALUimtd7ecws8m7d7pAZDQm/KPHFbCh3ZnN5
 KALf3mj5Gw2k5cv4PeVMQixjcWHdLbXAui713v9x4CN9VdjOH3ficLTBArKTbImEY1
 SsZ1l6Jzcp0E9/MjIoUBgr7o/f/y/ecuJTOBjpL7JG2SdmqQGOZOcONCPiNBr2n6hw
 WNdXOLuFxTF2Yr1OCo8Qu6lWPVqN6YR3jGVmC+JZeYgs8A7sp/LuTsOerS/8sH0ueU
 OaG72/PRYQZ9Q==
Message-ID: <b35d8b31-8de0-4735-a68b-fbdeade53682@kernel.org>
Date: Thu, 9 Jan 2025 18:44:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] configs: am68: Add configs for enabling Ethboot in
 R5SPL
To: "Vankar, Chintan" <c-vankar@ti.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Nishanth Menon <nm@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Simon Glass <sjg@chromium.org>,
 Jayesh Choudhary <j-choudhary@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Tom Rini <trini@konsulko.com>
Cc: srk@ti.com, s-vadapalli@ti.com, danishanwar@ti.com, u-boot@lists.denx.de
References: <20250107093840.2211381-1-c-vankar@ti.com>
 <20250107093840.2211381-6-c-vankar@ti.com>
 <82c602bb-f823-484d-97a9-1bf6de2b4a9b@kernel.org>
 <20a4ff7a-7c84-46db-bb5a-f6e03b5a3283@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20a4ff7a-7c84-46db-bb5a-f6e03b5a3283@ti.com>
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



On 09/01/2025 10:43, Vankar, Chintan wrote:
> 
> 
> On 1/7/2025 8:08 PM, Roger Quadros wrote:
>>
>>
>> On 07/01/2025 11:38, Chintan Vankar wrote:
>>> Add configs for enabling Ethernet boot in R5SPL.
>>>
>>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>>> ---
>>>   configs/am68_sk_r5_ethboot_defconfig | 80 ++++++++++++++++++++++++++++
>>>   1 file changed, 80 insertions(+)
>>>   create mode 100644 configs/am68_sk_r5_ethboot_defconfig
>>>
>>> diff --git a/configs/am68_sk_r5_ethboot_defconfig b/configs/am68_sk_r5_ethboot_defconfig
>>> new file mode 100644
>>> index 00000000000..9bfbb5a3bfe
>>> --- /dev/null
>>> +++ b/configs/am68_sk_r5_ethboot_defconfig
>>> @@ -0,0 +1,80 @@
>>> +#include <configs/am68_sk_r5_defconfig>
>>> +
>>> +CONFIG_ARM=y
>>> +CONFIG_ARCH_K3=y
>>> +CONFIG_SOC_K3_J721S2=y
>>> +CONFIG_TARGET_J721S2_R5_EVM=y
>>> +CONFIG_DEFAULT_DEVICE_TREE="k3-am68-sk-r5-base-board"
>>
>> Please don't add duplicates that are already included in configs/am68_sk_r5_defconfig
>> or configs/j721s2_evm_r5_defconfig
>>
> 
> Hello Roger, These config options are required despite of they are
> present in the file that is being included for buildman to work, you can
> refer to Tom's comment at here:
> https://lore.kernel.org/r/20240705153721.GF38804@bill-the-cat/
> after which I included the same while posting config file for AM62x-SK.
> 

Understood. Thanks!

>>> +CONFIG_SPL_GPIO=y
>>> +CONFIG_SPL_BOARD_INIT=y
>>> +CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
>>> +CONFIG_SPL_DMA=y
>>> +CONFIG_SPL_ENV_SUPPORT=y
>>> +CONFIG_SPL_ETH=y
>>> +CONFIG_SPL_I2C=y
>>> +CONFIG_SPL_NET=y
>>> +CONFIG_SPL_NET_VCI_STRING="AM68 U-Boot R5 SPL"
>>> +CONFIG_CMD_DHCP=y
>>> +CONFIG_SPL_SYSCON=y
>>> +CONFIG_DMA_CHANNELS=y
>>> +CONFIG_TI_K3_NAVSS_UDMA=y
>>> +CONFIG_DM_I2C=y
>>> +CONFIG_PHY_TI_DP83867=y
>>> +CONFIG_TI_AM65_CPSW_NUSS=y
>>> +CONFIG_SPI=n
>>> +CONFIG_SPL_SPI=n
>>> +CONFIG_DM_SPI=n
>>> +CONFIG_SPL_DM_SPI=n
>>> +CONFIG_SPL_SYS_MALLOC=y
>>> +CONFIG_SPI_MEM=n
>>> +CONFIG_CMD_FAT=n
>>> +CONFIG_FS_FAT=n
>>> +CONFIG_SPL_FS_FAT=n
>>> +CONFIG_MMC_SDHCI=n
>>> +CONFIG_MTD=n
>>> +CONFIG_CMD_FAT=n
>>
>> Please explain in commit log why you are setting many of the
>> options to "n". Is it due to memory limitation?
>>
> 
> Yes, that is because of memory limitation, we have faced the same
> limitation while working with AM62x Ethernet boot.
> 
>>> +CONFIG_SYS_RELOC_GD_ENV_ADD=y
>>> +CONFIG_SPL_DM_SPI_FLASH=n
>>> +CONFIG_SPL_HAS_CUSTOM_MALLOC_START=n
>>> +CONFIG_HUSH_PARSER=n
>>> +CONFIG_CMD_DFU=n
>>> +CONFIG_CMD_GPT=n
>>> +CONFIG_SPL_YMODEM_SUPPORT=n
>>> +CONFIG_ARCH_FIXUP_FDT_MEMORY=n
>>> +CONFIG_SPL_ENV_IS_NOWHERE=y
>>> +CONFIG_DM_EVENT=y
>>> +CONFIG_INPUT=n
>>> +CONFIG_ESM_K3=y
>>> +CONFIG_SPL_LOAD_BLOCK=y
>>> +CONFIG_DFU=n
>>> +CONFIG_SPL_DFU=n
>>> +CONFIG_TI_I2C_BOARD_DETECT=y
>>> +CONFIG_K3_EARLY_CONS=n
>>> +CONFIG_K3_QOS=n
>>> +CONFIG_USE_BOOTCOMMAND=n
>>> +CONFIG_SPL_MTD=n
>>> +CONFIG_SPL_NAND_SPI_SUPPORT=n
>>> +CONFIG_BOOTDEV_ETH=y
>>> +CONFIG_USB=n
>>> +CONFIG_FS_LOADER=n
>>> +CONFIG_SPL_FS_LOADER=n
>>> +CONFIG_SPL_DM_SPI=y
>>> +CONFIG_PINCTRL_GENERIC=n
>>> +CONFIG_PINMUX=n
>>> +CONFIG_SPL_PINCTRL_GENERIC=n
>>> +CONFIG_SPL_PINMUX=n
>>> +CONFIG_DM_REGULATOR=n
>>> +CONFIG_TI_SCI_POWER_DOMAIN=n
>>> +CONFIG_CMD_REMOTEPROC=y
>>> +CONFIG_SYSRESET=n
>>> +CONFIG_LAST_STAGE_INIT=y
>>> +CONFIG_OF_UPSTREAM=n
>>
>> Why no OF_UPSTREAM?
>>
> 
> Device tree files are not in-sync with upstream linux for AM68, getting
> compile time errors for the same, that's the reason I have disabled this
> config option.

I suggest to do a sync and not disable CONFIG_OF_UPSTREAM.

> 
>>> +CONFIG_K3_DM_FW=y
>>> +CONFIG_SPL_SPI_LOAD=n
>>> +CONFIG_SPL_DM_SPI=n
>>> +CONFIG_NOR_SUPPORT=n
>>> +CONFIG_SPL_NOR_SUPPORT=n
>>> +CONFIG_SPL_DM_SPI=n
>>> +CONFIG_SYS_MALLOC_CLEAR_ON_INIT=n
>>> +CONFIG_SPL_SYS_MALLOC_CLEAR_ON_INIT=n
>>> +CONFIG_BOOTDEV_ETH=n
>>

-- 
cheers,
-roger

