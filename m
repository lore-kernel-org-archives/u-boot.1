Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA004E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 08:43:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADC13800D0;
	Thu,  9 Jan 2025 09:43:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yVQl2aT4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6899801F5; Thu,  9 Jan 2025 09:43:34 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 252A580017
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 09:43:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5098hKXA061461;
 Thu, 9 Jan 2025 02:43:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736412200;
 bh=ZzNihm3hDKERH9TIU3WO8DB4lqCQWLB+1jpJ3FlPx98=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=yVQl2aT4FfHuc07vKCzYyXwHdbZWsVI+gOZ1BKcV/+HpDGTNwAsxqGFnuhoFi6d2A
 HjOoZCbcjk+g5liL7qyTxx/zSPk7zpjYkwqInruySih5Z6JJG1/IqBeAQizMEOTrQY
 K9fgKS8XTp5Yvy9wOh77XrOJO7bVmtgW4Lg3e1xQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5098hKLm032211
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 Jan 2025 02:43:20 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 Jan 2025 02:43:19 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 Jan 2025 02:43:19 -0600
Received: from [10.249.135.49] ([10.249.135.49])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5098hBRL016746;
 Thu, 9 Jan 2025 02:43:12 -0600
Message-ID: <20a4ff7a-7c84-46db-bb5a-f6e03b5a3283@ti.com>
Date: Thu, 9 Jan 2025 14:13:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] configs: am68: Add configs for enabling Ethboot in
 R5SPL
To: Roger Quadros <rogerq@kernel.org>, AKASHI Takahiro
 <akashi.tkhro@gmail.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Nishanth Menon <nm@ti.com>, Hari Nagalla
 <hnagalla@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, Andreas
 Dannenberg <dannenberg@ti.com>, Simon Glass <sjg@chromium.org>, Jayesh
 Choudhary <j-choudhary@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>
CC: <srk@ti.com>, <s-vadapalli@ti.com>, <danishanwar@ti.com>,
 <u-boot@lists.denx.de>
References: <20250107093840.2211381-1-c-vankar@ti.com>
 <20250107093840.2211381-6-c-vankar@ti.com>
 <82c602bb-f823-484d-97a9-1bf6de2b4a9b@kernel.org>
Content-Language: en-US
From: "Vankar, Chintan" <c-vankar@ti.com>
In-Reply-To: <82c602bb-f823-484d-97a9-1bf6de2b4a9b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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



On 1/7/2025 8:08 PM, Roger Quadros wrote:
> 
> 
> On 07/01/2025 11:38, Chintan Vankar wrote:
>> Add configs for enabling Ethernet boot in R5SPL.
>>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>   configs/am68_sk_r5_ethboot_defconfig | 80 ++++++++++++++++++++++++++++
>>   1 file changed, 80 insertions(+)
>>   create mode 100644 configs/am68_sk_r5_ethboot_defconfig
>>
>> diff --git a/configs/am68_sk_r5_ethboot_defconfig b/configs/am68_sk_r5_ethboot_defconfig
>> new file mode 100644
>> index 00000000000..9bfbb5a3bfe
>> --- /dev/null
>> +++ b/configs/am68_sk_r5_ethboot_defconfig
>> @@ -0,0 +1,80 @@
>> +#include <configs/am68_sk_r5_defconfig>
>> +
>> +CONFIG_ARM=y
>> +CONFIG_ARCH_K3=y
>> +CONFIG_SOC_K3_J721S2=y
>> +CONFIG_TARGET_J721S2_R5_EVM=y
>> +CONFIG_DEFAULT_DEVICE_TREE="k3-am68-sk-r5-base-board"
> 
> Please don't add duplicates that are already included in configs/am68_sk_r5_defconfig
> or configs/j721s2_evm_r5_defconfig
> 

Hello Roger, These config options are required despite of they are
present in the file that is being included for buildman to work, you can
refer to Tom's comment at here:
https://lore.kernel.org/r/20240705153721.GF38804@bill-the-cat/
after which I included the same while posting config file for AM62x-SK.

>> +CONFIG_SPL_GPIO=y
>> +CONFIG_SPL_BOARD_INIT=y
>> +CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
>> +CONFIG_SPL_DMA=y
>> +CONFIG_SPL_ENV_SUPPORT=y
>> +CONFIG_SPL_ETH=y
>> +CONFIG_SPL_I2C=y
>> +CONFIG_SPL_NET=y
>> +CONFIG_SPL_NET_VCI_STRING="AM68 U-Boot R5 SPL"
>> +CONFIG_CMD_DHCP=y
>> +CONFIG_SPL_SYSCON=y
>> +CONFIG_DMA_CHANNELS=y
>> +CONFIG_TI_K3_NAVSS_UDMA=y
>> +CONFIG_DM_I2C=y
>> +CONFIG_PHY_TI_DP83867=y
>> +CONFIG_TI_AM65_CPSW_NUSS=y
>> +CONFIG_SPI=n
>> +CONFIG_SPL_SPI=n
>> +CONFIG_DM_SPI=n
>> +CONFIG_SPL_DM_SPI=n
>> +CONFIG_SPL_SYS_MALLOC=y
>> +CONFIG_SPI_MEM=n
>> +CONFIG_CMD_FAT=n
>> +CONFIG_FS_FAT=n
>> +CONFIG_SPL_FS_FAT=n
>> +CONFIG_MMC_SDHCI=n
>> +CONFIG_MTD=n
>> +CONFIG_CMD_FAT=n
> 
> Please explain in commit log why you are setting many of the
> options to "n". Is it due to memory limitation?
> 

Yes, that is because of memory limitation, we have faced the same
limitation while working with AM62x Ethernet boot.

>> +CONFIG_SYS_RELOC_GD_ENV_ADD=y
>> +CONFIG_SPL_DM_SPI_FLASH=n
>> +CONFIG_SPL_HAS_CUSTOM_MALLOC_START=n
>> +CONFIG_HUSH_PARSER=n
>> +CONFIG_CMD_DFU=n
>> +CONFIG_CMD_GPT=n
>> +CONFIG_SPL_YMODEM_SUPPORT=n
>> +CONFIG_ARCH_FIXUP_FDT_MEMORY=n
>> +CONFIG_SPL_ENV_IS_NOWHERE=y
>> +CONFIG_DM_EVENT=y
>> +CONFIG_INPUT=n
>> +CONFIG_ESM_K3=y
>> +CONFIG_SPL_LOAD_BLOCK=y
>> +CONFIG_DFU=n
>> +CONFIG_SPL_DFU=n
>> +CONFIG_TI_I2C_BOARD_DETECT=y
>> +CONFIG_K3_EARLY_CONS=n
>> +CONFIG_K3_QOS=n
>> +CONFIG_USE_BOOTCOMMAND=n
>> +CONFIG_SPL_MTD=n
>> +CONFIG_SPL_NAND_SPI_SUPPORT=n
>> +CONFIG_BOOTDEV_ETH=y
>> +CONFIG_USB=n
>> +CONFIG_FS_LOADER=n
>> +CONFIG_SPL_FS_LOADER=n
>> +CONFIG_SPL_DM_SPI=y
>> +CONFIG_PINCTRL_GENERIC=n
>> +CONFIG_PINMUX=n
>> +CONFIG_SPL_PINCTRL_GENERIC=n
>> +CONFIG_SPL_PINMUX=n
>> +CONFIG_DM_REGULATOR=n
>> +CONFIG_TI_SCI_POWER_DOMAIN=n
>> +CONFIG_CMD_REMOTEPROC=y
>> +CONFIG_SYSRESET=n
>> +CONFIG_LAST_STAGE_INIT=y
>> +CONFIG_OF_UPSTREAM=n
> 
> Why no OF_UPSTREAM?
> 

Device tree files are not in-sync with upstream linux for AM68, getting
compile time errors for the same, that's the reason I have disabled this
config option.

>> +CONFIG_K3_DM_FW=y
>> +CONFIG_SPL_SPI_LOAD=n
>> +CONFIG_SPL_DM_SPI=n
>> +CONFIG_NOR_SUPPORT=n
>> +CONFIG_SPL_NOR_SUPPORT=n
>> +CONFIG_SPL_DM_SPI=n
>> +CONFIG_SYS_MALLOC_CLEAR_ON_INIT=n
>> +CONFIG_SPL_SYS_MALLOC_CLEAR_ON_INIT=n
>> +CONFIG_BOOTDEV_ETH=n
> 
