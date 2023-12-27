Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164D6C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 06:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18170876A6;
	Wed, 27 Dec 2023 07:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gbhoHpoc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F86876C8; Wed, 27 Dec 2023 07:56:52 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 169D58761B
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 07:56:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BR6ub5o070614;
 Wed, 27 Dec 2023 00:56:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703660197;
 bh=kcpRpqfV4mP5XrLZLKM8lQFcXp0wlds6qFdUhypO/N4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=gbhoHpocL/W1MdznZaA0cA1JGuSMVBcvknIupYqh5+bd4O0CxbBjVNIgKIu9Ok7WZ
 CRBHFdssvQJKxuxlDjAF0+W3EnVVrQNJS3TH/Rn4sAyoVbTVEkvZRx3Bt+lwR8WRTn
 d/okKfadqlSy+uibKe1T1ztVp71pFQBU2PAs3PkU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BR6ubf5014047
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Dec 2023 00:56:37 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Dec 2023 00:56:36 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Dec 2023 00:56:36 -0600
Received: from [10.24.69.31] (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BR6uUGn003919;
 Wed, 27 Dec 2023 00:56:31 -0600
Message-ID: <46c69c28-09c3-4e60-92f5-1f91d795a22a@ti.com>
Date: Wed, 27 Dec 2023 12:26:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/16] Introduce ICSSG Ethernet driver
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20231219101225.3443978-1-danishanwar@ti.com>
 <6d9456ec-a483-4721-8713-626aacdc9f81@kernel.org>
 <4ccd7db1-533a-4243-9087-7e7c2e85b917@ti.com>
 <d841b7b8-80f8-467d-afed-1170a2627724@kernel.org>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <d841b7b8-80f8-467d-afed-1170a2627724@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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



On 22/12/23 6:13 pm, Roger Quadros wrote:
> 
> On 22/12/2023 12:26, MD Danish Anwar wrote:
>> Hi Roger,
>>
>> On 20/12/23 3:29 pm, Roger Quadros wrote:
>>> Hi,
>>>
>>> On 19/12/2023 12:11, MD Danish Anwar wrote:
>>>> Introduce ICSSG PRUETH support in uboot. The ICSSG driver is used in TI
>>>> AM654 SR2.0.
>>>>
>>>> The ICSSG PRU Sub-system runs on EMAC firmware. This series Introduces
>>>> support for ICSSG driver in uboot. This series also adds the driver's
>>>> dependencies.
>>>>
>>>> The ICSSG2 node is added in device tree overlay so that it remains in
>>>> sync with linux kernel.
>>>>
>>>> The series introduces device tree and config changes and AM65x
>>>> to enable ICSSG driver. The series also enables SPL_LOAD_FIT_APPLY_OVERLAY
>>>> for AM65x in order to load overlay over spl.
>>>>
>>>> This series has been tested on AM65x SR2.0, and the ICSSG interface is
>>>> able to ping / dhcp and boot kernel using tftp in uboot.
>>>>
>>>> To use ICSSG2 ethernet, the ICSSG firmware needs to be loaded to PRU RPROC
>>>> cores and RPROC cores need to be booted with the firmware. This step is
>>>> done inside driver in kernel as kernel supports APIs like
>>>> rproc_set_firmware() and rproc_fw_boot(). But as u-boot doesn't have these
>>>> APIs, the same needs to be done via u-boot cmds.
>>>>
>>>> To make sure icssg-eth works we need to do below steps.
>>>>
>>>> 1. Initialize rproc cores i.e. rproc_init()
>>>> 2. Load $firmware_file from partition '1:2' (root) on device (mmc in this
>>>>    example)
>>>> 3. Load the firmware file to rproc cores passing. i.e. rproc_load()
>>>>    taking rproc_id, loadaddr and file size as arguments.
>>>> 4. Start rproc cores. i.e. rproc_start() taking rproc_id as arguments
>>>>
>>>> The above steps are done by running the below commands at u-boot prompt.
>>>>
>>>> => setenv start_icssg2 'rproc start 14; rproc start 15; rproc start 16; rproc start 17; rproc start 18; rproc start 19'
>>>> => setenv stop_icssg2 'rproc stop 14; rproc stop 15; rproc stop 16; rproc stop 17; rproc stop 18; rproc stop 19'
>>>> => setenv firmware_dir '/lib/firmware/ti-pruss'
>>>> => setenv get_firmware_mmc 'load mmc ${bootpart} ${loadaddr} ${firmware_dir}/${firmware_file}'
>>>>
>>>> => setenv init_icssg2 'setenv ethact icssg2-eth; setenv autoload no; rproc init; setenv loadaddr 0x80000000; \
>>>>     setenv firmware_file am65x-sr2-pru0-prueth-fw.elf; run get_firmware_mmc;  rproc load 14 0x80000000 ${filesize}; \
>>>>     setenv loadaddr 0x89000000; setenv firmware_file am65x-sr2-rtu0-prueth-fw.elf; run get_firmware_mmc; rproc load 15 0x89000000 ${filesize}; \
>>>>     setenv loadaddr 0x90000000; setenv firmware_file am65x-sr2-txpru0-prueth-fw.elf; run get_firmware_mmc; rproc load 16 0x90000000 ${filesize}; \
>>>>     setenv loadaddr 0x80000000; setenv firmware_file am65x-sr2-pru1-prueth-fw.elf; run get_firmware_mmc; rproc load 17 0x80000000 ${filesize}; \
>>>>     setenv loadaddr 0x89000000; setenv firmware_file am65x-sr2-rtu1-prueth-fw.elf; run get_firmware_mmc; rproc load 18 0x89000000 ${filesize}; \
>>>>     setenv loadaddr 0x90000000; setenv firmware_file am65x-sr2-txpru1-prueth-fw.elf; run get_firmware_mmc; rproc load 19 0x90000000 ${filesize}; \
>>>>     run start_icssg2;'
>>>
>>> A whole bunch of commands are required to get ethernet functional.
>>> This is not at all user friendly and will be a maintenance nightmare.
>>> What worries me is tracking the 6 different rproc cores and the 6 different firmware files to start 1 ethernet device.
>>> This will get even more interesting when we have to deal with different ICSSG instances on different boards.
>>>
>>> What is preventing the driver from starting the rproc cores it needs so user doesn't need to care about it?
>>> All the necessary information is in the Device tree. At least this is how it is done on Linux.
>>>
>>
>> I tried removing the need for these commands and implementing them
>> inside the driver only. I am able to load the firmware from driver using
>> the fs_loader API request_firmware_into_buf(). It requires changes to
>> dt. A DT node called fs-loader needs to be added also CONFIG_FS_LOADER
>> needs to enabled. In the DT node we need to specify the storage media
>> that we are using i.e. mmc, ospi, usb. It's upto user to modify the
>> storage media, the driver will take the media from DT and try to laod
>> firmware from their.
>>
>> For loading firmwares to rproc cores, rproc_load() API is needed. Now
>> this API takes rproc_id, loadaddr and firmware_size as arguments.
>> loadaddr is fixed for all three pru cores. firmware_size is obtained
>> from request_firmware_into_buf() but I couldn't find a way to get the
>> rproc_id. For now based on the ICSSG instance and slice number I am
>> figuring out the rproc_id and passing it to rproc_load() and
>> rproc_start() APIs. Please let me know if you have any other / better
>> way of finding rproc_id.
>>
>> Below is the entire diff to remove these commands and move their
>> functionality to driver. Please have a look and let me know if this is ok.
>>
> 
> Good to see you got something working so quickly.
> It has some rough edges but nothing that is blocking.
> 
>>
>> Save New Duplicate & Edit Just Text Twitter
>> diff --git a/arch/arm/dts/k3-am654-base-board.dts
>> b/arch/arm/dts/k3-am654-base-board.dts
>> index cfbcebfa37..c8da72e49c 100644
>> --- a/arch/arm/dts/k3-am654-base-board.dts
>> +++ b/arch/arm/dts/k3-am654-base-board.dts
>> @@ -16,6 +16,13 @@
>>  	chosen {
>>  		stdout-path = "serial2:115200n8";
>>  		bootargs = "earlycon=ns16550a,mmio32,0x02800000";
>> +		firmware-loader = <&fs_loader0>;
>> +	};
>> +
>> +	fs_loader0: fs-loader {
>> +		bootph-all;
>> +		compatible = "u-boot,fs-loader";
>> +		phandlepart = <&sdhci1 2>;
>>  	};
> 
> This is has 2 issues
> 1) It will not be accepted in Kernel DT. Maybe it could be done in -u-boot.dtsi file.

Sure. I'll move this to k3-am654-base-board-u-boot.dtsi

> 2) You cannot assume boot medium is always sdhci1 2
> 

Yes. It's upto user to provide the boot medium and boot partition for
loading firmware. By default the firmware is loacated in root partion of
shdci1 on am65x so I am adding this as default. But user can easily
modify this to any other medium / partition needed.

>>
>>  	memory@80000000 {
>> diff --git a/configs/am65x_evm_a53_defconfig
>> b/configs/am65x_evm_a53_defconfig
>> index 2755d7082f..c53e938abb 100644
>> --- a/configs/am65x_evm_a53_defconfig
>> +++ b/configs/am65x_evm_a53_defconfig
>> @@ -112,6 +112,7 @@ CONFIG_DM_I2C_GPIO=y
>>  CONFIG_SYS_I2C_OMAP24XX=y
>>  CONFIG_DM_MAILBOX=y
>>  CONFIG_K3_SEC_PROXY=y
>> +CONFIG_FS_LOADER=y
>>  CONFIG_SUPPORT_EMMC_BOOT=y
>>  CONFIG_MMC_IO_VOLTAGE=y
>>  CONFIG_MMC_UHS_SUPPORT=y
>> diff --git a/configs/am65x_evm_r5_defconfig b/configs/am65x_evm_r5_defconfig
>> index b2f1e721b3..2d19935a41 100644
>> --- a/configs/am65x_evm_r5_defconfig
>> +++ b/configs/am65x_evm_r5_defconfig
>> @@ -98,6 +98,7 @@ CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
>>  CONFIG_SYS_I2C_OMAP24XX=y
>>  CONFIG_DM_MAILBOX=y
>>  CONFIG_K3_SEC_PROXY=y
>> +CONFIG_FS_LOADER=y
>>  CONFIG_K3_AVS0=y
>>  CONFIG_SUPPORT_EMMC_BOOT=y
>>  CONFIG_MMC_HS200_SUPPORT=y
>> diff --git a/drivers/net/ti/icssg_prueth.c b/drivers/net/ti/icssg_prueth.c
>> index 40ad827e49..1c4edeb7b7 100644
>> --- a/drivers/net/ti/icssg_prueth.c
>> +++ b/drivers/net/ti/icssg_prueth.c
>> @@ -227,6 +227,10 @@ static int prueth_start(struct udevice *dev)
>>  	void *config;
>>  	int ret, i;
>>
>> +	ret = icssg_start_pru_cores(dev);
>> +	if (ret)
>> +		return ret;
>> +
>>  	/* To differentiate channels for SLICE0 vs SLICE1 */
>>  	snprintf(chn_name, sizeof(chn_name), "tx%d-0", priv->slice);
>>
>> @@ -355,9 +359,11 @@ static void prueth_stop(struct udevice *dev)
>>  	phy_shutdown(priv->phydev);
>>
>>  	dma_disable(&priv->dma_tx);
>> -	dma_free(&priv->dma_tx);
>> -
>>  	dma_disable(&priv->dma_rx);
>> +
>> +	icssg_stop_pru_cores(dev);
>> +
>> +	dma_free(&priv->dma_tx);
>>  	dma_free(&priv->dma_rx);
>>  }
>>
>> @@ -434,6 +440,181 @@ static const struct soc_attr k3_mdio_soc_data[] = {
>>  	{ /* sentinel */ },
>>  };
>>
>> +struct icssg_firmware_load_address {
>> +	u32 pru;
>> +	u32 rtu;
>> +	u32 txpru;
>> +};
>> +
>> +struct icssg_firmwares {
>> +	char *pru;
>> +	char *rtu;
>> +	char *txpru;
>> +};
>> +
>> +static struct icssg_firmwares icssg_emac_firmwares[] = {
>> +	{
>> +		.pru = "/lib/firmware/ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
>> +		.rtu = "/lib/firmware/ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
>> +		.txpru = "/lib/firmware/ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
>> +	},
>> +	{
>> +		.pru = "/lib/firmware/ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
>> +		.rtu = "/lib/firmware/ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
>> +		.txpru = "/lib/firmware/ti-pruss/am65x-sr2-txpru1-prueth-fw.elf",
>> +	}
>> +};
> 
> This information is contained in the DT.
> 
> 		firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
> 				"ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
> 				"ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
> 				"ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
> 				"ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
> 				"ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
> 

Yes it is. But the linux driver uses the firmware strcuture inside
driver only. The firmware-name property is not being used. The firmware
names for all applicable SoCs (AM65x and AM64x) is same so instead of
reading it from DT, the driver hardcodes the firmware names in linux. I
think the thought here was to use firmware-name property from DT when
different firmwares are needed for different SoCs. I am just following
the same here in uboot as well.

> You will need to introduce a rproc_set_firmware() API so clients can
> set their own firmware names.
> 

Sure. I will add an element 'fw_name' in struct dm_rproc_uclass_pdata
and set this fw_name to the firmware name requested by client using
rproc_set_firmware().

The client drivers can call rproc_set_firmware(dev, firmware_name) to
set the firmware name.

>> +
>> +int load_firmware(char *name_fw, u32 *loadaddr)
>> +{
>> +	struct udevice *fsdev;
>> +	int size = 0;
>> +
>> +	if (!IS_ENABLED(CONFIG_FS_LOADER))
>> +		return -EINVAL;
>> +
>> +	if (!*loadaddr)
>> +		return -EINVAL;
>> +
>> +	if (!get_fs_loader(&fsdev))
>> +		size = request_firmware_into_buf(fsdev, name_fw, (void *)*loadaddr,
>> 40524, 0);
>> +
>> +	return size;
>> +}
> 
> On Linux rproc_boot() does both loading the firmware and starting the rproc
> as that is farely generic.
> You should introduce rproc_boot() API so loading is taken care of at rproc driver.
> All you need to do is call rproc_set_firmware() before rproc_boot().
> 

Sure. I'll introduce rproc_boot() which will load the firmware to a
buffer and then load the firmware / buffer to rproc core usinig rproc_load.

For allocating memory for reading firmware we need to provide the size
of memory required as well. So rproc_boot will take two arguments.
1. dev (rproc device)
2. size (Maximum memory required to read firmware)

>> +
>> +static int icssg_get_instance(struct udevice *dev)
>> +{
>> +	if (!strcmp(dev->name, "icssg2-eth"))
>> +		return 2;
>> +	else if (!strcmp(dev->name, "icssg1-eth"))
>> +		return 1;
>> +	else if (!strcmp(dev->name, "icssg0-eth"))
>> +		return 0;
>> +
>> +	dev_err(dev, "Invalid icssg instance\n");
>> +	return -EINVAL;
>> +}
>> +
>> +static int icssg_get_pru_core_number(struct udevice *dev, int slice)
>> +{
>> +	int instance, num_r5_cores;
>> +
>> +	instance = icssg_get_instance(dev);
>> +	if (instance < 0)
>> +		return instance;
>> +
>> +	if (IS_ENABLED(CONFIG_REMOTEPROC_TI_K3_R5F))
>> +		num_r5_cores = 2;
>> +
>> +	return num_r5_cores +
>> +	       instance * PRU_TYPE_MAX * PRUETH_NUM_MACS +
>> +	       slice * PRU_TYPE_MAX;
> 
> All this doesn't look right. What we need is the rproc device
> that matches the PRU/RTU rprocs that we are interested in.
> 
> The DT already has this information
> 
> 		ti,prus = <&pru2_0>, <&rtu2_0>, <&tx_pru2_0>,
> 			<&pru2_1>, <&rtu2_1>, <&tx_pru2_1>;
> 
> 
> All the current rproc APIs use the below to get rproc device from ID
> ret = uclass_get_device_by_seq(UCLASS_REMOTEPROC, id, &dev);
> 
> You just need to introduce APIs that takes rproc device directly as argument.
> 
> In your driver you can call uclass_get_device_by_phandle_id() to get the
> rproc device from the rproc phandle?

Sure. I'll do that. Based on the icssg slice first I will get the
phandle for prus.

Index will be 0,1,2 for slice 0 and 3,4,5 for slice 1.

ofnode_read_u32_index(dev_ofnode(dev), "ti,prus", index, &phandle);

Then for each phandle I can call uclass_get_device_by_phandle_id() and
get the rproc device.

> 
> 
>> +}
>> +
>> +int icssg_start_pru_cores(struct udevice *dev)
>> +{
>> +	struct prueth *prueth = dev_get_priv(dev);
>> +	struct icssg_firmwares *firmwares;
>> +	u32 pru_fw_loadaddr = 0x80000000;
>> +	u32 rtu_fw_loadaddr = 0x89000000;
>> +	u32 txpru_fw_loadaddr = 0x90000000;
> 
> Please avoid hardcoding. You can use malloc to get a temporary buffer area?
> 
> Why do you need 3 different addresses?
> Once you do a rproc_load isn't the buffer already copied to rproc's memory
> so you can discard it or use it for the other rprocs?
> 

Sure I'll use malloc to get temporary buffer. Only thing is that to get
temporary buffer I will need to provide size as well.

void *addr = malloc(fw_size);

User needs to provide this fw_size to rproc_boot(). In my case the max
size the firmware can have is 64KB so I will be passing 64K as size to
rproc driver.

>> +	int slice, ret, core_id;
>> +
>> +	firmwares = icssg_emac_firmwares;
>> +	slice = prueth->slice;
>> +
>> +	core_id = icssg_get_pru_core_number(dev, slice);
>> +	if (core_id < 0)
>> +		return core_id;
>> +
>> +	/* Initialize all rproc cores */
>> +	rproc_init();
>> +
>> +	/* Loading PRU firmware to PRU core */
>> +	ret = load_firmware(firmwares[slice].pru, &pru_fw_loadaddr);
> 
> On Linux, loading the firmware is the responsibility of the rproc driver.
> Shouldn't it be the same in u-boot?
> 

Sure I'll move this to rproc driver.

>> +
>> +	if (ret < 0) {
>> +		dev_err(dev, "Unable to load_firmware %s at addr 0x%x err %d\n",
>> +			firmwares[slice].pru, pru_fw_loadaddr, ret);
>> +		return ret;
>> +	}
>> +
>> +	dev_info(dev, "Loaded FW %s successfully at addr 0x%x Size = %d Bytes\n",
>> +		firmwares[slice].pru, pru_fw_loadaddr, ret);
> 
> dev_dbg() here an at all dev_info().
> 
>> +	rproc_load(core_id + PRU_TYPE_PRU, pru_fw_loadaddr, ret);
>> +
>> +	/* Loading RTU firmware to RTU core */
>> +	ret = load_firmware(firmwares[slice].rtu, &rtu_fw_loadaddr);
>> +
>> +	if (ret < 0) {
>> +		dev_err(dev, "Unable to load_firmware %s at addr 0x%x err %d\n",
>> +			firmwares[slice].rtu, rtu_fw_loadaddr, ret);
>> +		return ret;
>> +	}
>> +
>> +	dev_info(dev, "Loaded FW %s successfully at addr 0x%x Size = %d Bytes\n",
>> +		firmwares[slice].rtu, rtu_fw_loadaddr, ret);
>> +	rproc_load(core_id + PRU_TYPE_RTU, rtu_fw_loadaddr, ret);
>> +
>> +	/* Loading TX_PRU firmware to TX_PRU core */
>> +	ret = load_firmware(firmwares[slice].txpru, &txpru_fw_loadaddr);
>> +
>> +	if (ret < 0) {
>> +		dev_err(dev, "Unable to load_firmware %s at addr 0x%x err %d\n",
>> +			firmwares[slice].txpru, txpru_fw_loadaddr, ret);
>> +		return ret;
>> +	}
>> +
>> +	dev_info(dev, "Loaded FW %s successfully at addr 0x%x Size = %d Bytes\n",
>> +		firmwares[slice].txpru, txpru_fw_loadaddr, ret);
>> +	rproc_load(core_id + PRU_TYPE_TX_PRU, txpru_fw_loadaddr, ret);
>> +
>> +	ret = rproc_start(core_id + PRU_TYPE_PRU);
>> +	if (ret) {
>> +		dev_err(dev, "failed to start PRU%d: %d\n", slice, ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = rproc_start(core_id + PRU_TYPE_RTU);
>> +	if (ret) {
>> +		dev_err(dev, "failed to start RTU%d: %d\n", slice, ret);
>> +		goto halt_pru;
>> +	}
>> +
>> +	ret = rproc_start(core_id + PRU_TYPE_TX_PRU);
>> +	if (ret) {
>> +		dev_err(dev, "failed to start TX_PRU%d: %d\n", slice, ret);
>> +		goto halt_rtu;
>> +	}
>> +
>> +	return 0;
>> +
>> +halt_rtu:
>> +	rproc_stop(core_id + PRU_TYPE_RTU);
>> +
>> +halt_pru:
>> +	rproc_stop(PRU_TYPE_PRU);
>> +	return ret;
>> +}
>> +
>> +int icssg_stop_pru_cores(struct udevice *dev)
>> +{
>> +	struct prueth *prueth = dev_get_priv(dev);
>> +	int slice, core_id;
>> +
>> +	slice = prueth->slice;
>> +
>> +	core_id = icssg_get_pru_core_number(dev, slice);
>> +	if (core_id < 0)
>> +		return core_id;
>> +
>> +	rproc_stop(core_id + PRU_TYPE_PRU);
>> +	rproc_stop(core_id + PRU_TYPE_RTU);
>> +	rproc_stop(core_id + PRU_TYPE_TX_PRU);
>> +
>> +	return 0;
>> +}
>> +
>>  static int prueth_probe(struct udevice *dev)
>>  {
>>  	ofnode eth_ports_node, eth0_node, eth1_node, eth_node;
>> diff --git a/include/linux/pruss_driver.h b/include/linux/pruss_driver.h
>> index 25272e850e..f17fe8bf58 100644
>> --- a/include/linux/pruss_driver.h
>> +++ b/include/linux/pruss_driver.h
>> @@ -114,6 +114,21 @@ enum pru_ctable_idx {
>>  	PRU_C31,
>>  };
>>
>> +/**
>> + * enum pru_type - PRU core type identifier
>> + *
>> + * @PRU_TYPE_PRU: Programmable Real-time Unit
>> + * @PRU_TYPE_RTU: Auxiliary Programmable Real-Time Unit
>> + * @PRU_TYPE_TX_PRU: Transmit Programmable Real-Time Unit
>> + * @PRU_TYPE_MAX: just keep this one at the end
>> + */
>> +enum pru_type {
>> +	PRU_TYPE_PRU,
>> +	PRU_TYPE_RTU,
>> +	PRU_TYPE_TX_PRU,
>> +	PRU_TYPE_MAX,
>> +};
>> +
>>  /**
>>   * enum pruss_mem - PRUSS memory range identifiers
>>   */
>>
>> with this diff, user don't need to run any extra commands at u-boot.
>> Once u-boot prompt is reached, just running ping / dhcp will suffice.
>>
> Great!
> 
> <snip>
> 

I have addressed all the above comments and made the changes needed.
below is the diff. Please have a look at it and let me know if it looks OK.

diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
index 11d83927ac..0b2b72b2c5 100644
--- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
@@ -6,6 +6,18 @@
 #include "k3-am654-r5-base-board-u-boot.dtsi"
 #include "k3-am65x-binman.dtsi"

+/ {
+	chosen {
+		firmware-loader = <&fs_loader0>;
+	};
+
+	fs_loader0: fs-loader {
+		bootph-all;
+		compatible = "u-boot,fs-loader";
+		phandlepart = <&sdhci1 2>;
+	};
+};
+
 &pru0_0 {
 	remoteproc-name = "pru0_0";
 };
diff --git a/configs/am65x_evm_a53_defconfig
b/configs/am65x_evm_a53_defconfig
index 2755d7082f..c53e938abb 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -112,6 +112,7 @@ CONFIG_DM_I2C_GPIO=y
 CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
+CONFIG_FS_LOADER=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
diff --git a/configs/am65x_evm_r5_defconfig b/configs/am65x_evm_r5_defconfig
index b2f1e721b3..2d19935a41 100644
--- a/configs/am65x_evm_r5_defconfig
+++ b/configs/am65x_evm_r5_defconfig
@@ -98,6 +98,7 @@ CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
+CONFIG_FS_LOADER=y
 CONFIG_K3_AVS0=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_HS200_SUPPORT=y
diff --git a/drivers/net/ti/icssg_prueth.c b/drivers/net/ti/icssg_prueth.c
index 40ad827e49..a2e3595956 100644
--- a/drivers/net/ti/icssg_prueth.c
+++ b/drivers/net/ti/icssg_prueth.c
@@ -62,6 +62,9 @@
 /* Management packet type */
 #define PRUETH_PKT_TYPE_CMD		0x10

+/* Number of PRU Cores per Slice */
+#define ICSSG_NUM_PRU_CORES		3
+
 static int icssg_phy_init(struct udevice *dev)
 {
 	struct prueth *priv = dev_get_priv(dev);
@@ -218,6 +221,116 @@ static int icssg_update_link(struct prueth *priv)
 	return phy->link;
 }

+struct icssg_firmwares {
+	char *pru;
+	char *rtu;
+	char *txpru;
+};
+
+static struct icssg_firmwares icssg_emac_firmwares[] = {
+	{
+		.pru = "/lib/firmware/ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
+		.rtu = "/lib/firmware/ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
+		.txpru = "/lib/firmware/ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
+	},
+	{
+		.pru = "/lib/firmware/ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
+		.rtu = "/lib/firmware/ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
+		.txpru = "/lib/firmware/ti-pruss/am65x-sr2-txpru1-prueth-fw.elf",
+	}
+};
+
+static int icssg_start_pru_cores(struct udevice *dev)
+{
+	struct prueth *prueth = dev_get_priv(dev);
+	struct icssg_firmwares *firmwares;
+	struct udevice *rproc_dev = NULL;
+	int ret, slice;
+	u32 phandle;
+	u8 index;
+
+	slice = prueth->slice;
+	index = slice * ICSSG_NUM_PRU_CORES;
+	firmwares = icssg_emac_firmwares;
+
+	ofnode_read_u32_index(dev_ofnode(dev), "ti,prus", index, &phandle);
+	ret = uclass_get_device_by_phandle_id(UCLASS_REMOTEPROC, phandle,
&rproc_dev);
+	if (ret) {
+		dev_err(dev, "Unknown remote processor with phandle '0x%x'
requested(%d)\n",
+		       phandle, ret);
+		return ret;
+	}
+
+	prueth->pru_core_id = dev_seq(rproc_dev);
+	ret = rproc_set_firmware(rproc_dev, firmwares[slice].pru);
+	if (ret)
+		return ret;
+
+	ret = rproc_boot(rproc_dev, SZ_64K);
+	if (ret) {
+		dev_err(dev, "failed to boot PRU%d: %d\n", slice, ret);
+		return -EINVAL;
+	}
+
+	ofnode_read_u32_index(dev_ofnode(dev), "ti,prus", index + 1, &phandle);
+	ret = uclass_get_device_by_phandle_id(UCLASS_REMOTEPROC, phandle,
&rproc_dev);
+	if (ret) {
+		dev_err(dev, "Unknown remote processor with phandle '0x%x'
requested(%d)\n",
+		       phandle, ret);
+		goto halt_pru;
+	}
+
+	prueth->rtu_core_id = dev_seq(rproc_dev);
+	ret = rproc_set_firmware(rproc_dev, firmwares[slice].rtu);
+	if (ret)
+		goto halt_pru;
+
+	ret = rproc_boot(rproc_dev, SZ_64K);
+	if (ret) {
+		dev_err(dev, "failed to boot RTU%d: %d\n", slice, ret);
+		goto halt_pru;
+	}
+
+	ofnode_read_u32_index(dev_ofnode(dev), "ti,prus", index + 2, &phandle);
+	ret = uclass_get_device_by_phandle_id(UCLASS_REMOTEPROC, phandle,
&rproc_dev);
+	if (ret) {
+		dev_err(dev, "Unknown remote processor with phandle '0x%x'
requested(%d)\n",
+		       phandle, ret);
+		goto halt_rtu;
+	}
+
+	prueth->txpru_core_id = dev_seq(rproc_dev);
+	ret = rproc_set_firmware(rproc_dev, firmwares[slice].txpru);
+	if (ret)
+		goto halt_rtu;
+
+	ret = rproc_boot(rproc_dev, SZ_64K);
+	if (ret) {
+		dev_err(dev, "failed to boot TXPRU%d: %d\n", slice, ret);
+		goto halt_rtu;
+	}
+
+	return 0;
+
+halt_rtu:
+	rproc_stop(prueth->rtu_core_id);
+
+halt_pru:
+	rproc_stop(prueth->pru_core_id);
+	return ret;
+}
+
+static int icssg_stop_pru_cores(struct udevice *dev)
+{
+	struct prueth *prueth = dev_get_priv(dev);
+
+	rproc_stop(prueth->pru_core_id);
+	rproc_stop(prueth->rtu_core_id);
+	rproc_stop(prueth->txpru_core_id);
+
+	return 0;
+}
+
 static int prueth_start(struct udevice *dev)
 {
 	struct ti_udma_drv_chan_cfg_data *dma_rx_cfg_data;
@@ -227,6 +340,10 @@ static int prueth_start(struct udevice *dev)
 	void *config;
 	int ret, i;

+	ret = icssg_start_pru_cores(dev);
+	if (ret)
+		return ret;
+
 	/* To differentiate channels for SLICE0 vs SLICE1 */
 	snprintf(chn_name, sizeof(chn_name), "tx%d-0", priv->slice);

@@ -355,9 +472,11 @@ static void prueth_stop(struct udevice *dev)
 	phy_shutdown(priv->phydev);

 	dma_disable(&priv->dma_tx);
-	dma_free(&priv->dma_tx);
-
 	dma_disable(&priv->dma_rx);
+
+	icssg_stop_pru_cores(dev);
+
+	dma_free(&priv->dma_tx);
 	dma_free(&priv->dma_rx);
 }

diff --git a/drivers/net/ti/icssg_prueth.h b/drivers/net/ti/icssg_prueth.h
index e41ed16a05..c92660401b 100644
--- a/drivers/net/ti/icssg_prueth.h
+++ b/drivers/net/ti/icssg_prueth.h
@@ -69,6 +69,9 @@ struct prueth {
 	int			speed;
 	int			duplex;
 	u8			icssg_hwcmdseq;
+	u8 			pru_core_id;
+	u8 			rtu_core_id;
+	u8 			txpru_core_id;
 };

 /* config helpers */
diff --git a/drivers/remoteproc/rproc-uclass.c
b/drivers/remoteproc/rproc-uclass.c
index 28b362c887..a085c44eaa 100644
--- a/drivers/remoteproc/rproc-uclass.c
+++ b/drivers/remoteproc/rproc-uclass.c
@@ -13,6 +13,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <virtio_ring.h>
+#include <fs_loader.h>
 #include <remoteproc.h>
 #include <asm/io.h>
 #include <dm/device-internal.h>
@@ -961,3 +962,90 @@ unsigned long rproc_parse_resource_table(struct
udevice *dev, struct rproc *cfg)

 	return 1;
 }
+
+int rproc_set_firmware(struct udevice *rproc_dev, const char *fw_name)
+{
+	struct dm_rproc_uclass_pdata *uc_pdata;
+	int len;
+	char *p;
+
+	if (!rproc_dev || !fw_name)
+		return -EINVAL;
+
+	uc_pdata = dev_get_uclass_plat(rproc_dev);
+
+	len = strcspn(fw_name, "\n");
+	if (!len) {
+		debug("can't provide empty string for firmware name\n");
+		return -EINVAL;
+	}
+
+	p = strndup(fw_name, len);
+	if (!p)
+		return -ENOMEM;
+
+	uc_pdata->fw_name = p;
+
+	return 0;
+}
+
+int rproc_boot(struct udevice *rproc_dev, size_t fw_size)
+{
+	struct dm_rproc_uclass_pdata *uc_pdata;
+	struct udevice *fs_loader;
+	void *addr = malloc(fw_size);
+	int core_id, ret = 0;
+	char *firmware;
+	ulong rproc_addr;
+
+	if (!rproc_dev)
+		return -EINVAL;
+
+	if (!addr)
+		return -ENOMEM;
+
+	uc_pdata = dev_get_uclass_plat(rproc_dev);
+	core_id = dev_seq(rproc_dev);
+	firmware = uc_pdata->fw_name;
+
+	if (!firmware) {
+		debug("No firmware set for rproc core %d\n", core_id);
+		return -EINVAL;
+	}
+
+	/* Initialize all rproc cores */
+	rproc_init();
+
+	/* Loading firmware to a given address */
+	ret = get_fs_loader(&fs_loader);
+	if (ret) {
+		debug("could not get fs loader: %d\n", ret);
+		return ret;
+	}
+
+	ret = request_firmware_into_buf(fs_loader, firmware, addr, fw_size, 0);
+	if (ret < 0) {
+		debug("could not request %s: %d\n", firmware, ret);
+		return ret;
+	}
+
+	rproc_addr = (ulong)addr;
+
+	debug("Loaded %s to 0x%08lX size = %d Bytes\n",
+		uc_pdata->fw_name, rproc_addr, ret);
+
+	ret = rproc_load(core_id, rproc_addr, ret);
+	if (ret) {
+		debug("failed to load %s to rproc core %d from addr 0x%08lX err %d\n",
+		       uc_pdata->fw_name, core_id, rproc_addr, ret);
+		return ret;
+	}
+
+	ret = rproc_start(core_id);
+	if (ret) {
+		debug("failed to start rproc core %d\n", core_id);
+		return ret;
+	}
+
+	return ret;
+}
diff --git a/include/remoteproc.h b/include/remoteproc.h
index a11dc8a9b6..65b0ff7477 100644
--- a/include/remoteproc.h
+++ b/include/remoteproc.h
@@ -402,6 +402,7 @@ enum rproc_mem_type {
  * @name: Platform-specific way of naming the Remote proc
  * @mem_type: one of 'enum rproc_mem_type'
  * @driver_plat_data: driver specific platform data that may be needed.
+ * @fw_name: firmware name
  *
  * This can be accessed with dev_get_uclass_plat() for any
UCLASS_REMOTEPROC
  * device.
@@ -411,6 +412,7 @@ struct dm_rproc_uclass_pdata {
 	const char *name;
 	enum rproc_mem_type mem_type;
 	void *driver_plat_data;
+	char *fw_name;
 };

 /**
@@ -704,6 +706,35 @@ unsigned long rproc_parse_resource_table(struct
udevice *dev,
 struct resource_table *rproc_find_resource_table(struct udevice *dev,
 						 unsigned int addr,
 						 int *tablesz);
+/**
+ * rproc_set_firmware() - assign a new firmware
+ * @rproc_dev: device for wich new firmware is being assigned
+ * @fw_name: new firmware name to be assigned
+ *
+ * This function allows remoteproc drivers or clients to configure a custom
+ * firmware name. The function does not trigger a remote processor boot,
+ * only sets the firmware name used for a subsequent boot.
+ *
+ * This function sets the fw_name field in uclass pdata of the Remote proc
+ *
+ * Return: 0 on success or a negative value upon failure
+ */
+int rproc_set_firmware(struct udevice *rproc_dev, const char *fw_name);
+
+/**
+ * rproc_boot() - boot a remote processor
+ * @rproc_dev: rproc device to boot
+ * @fw_size: Size of the memory to allocate for firmeware
+ *
+ * Boot a remote processor (i.e. load its firmware, power it on, ...).
+ *
+ * This function first loads the firmware set in the uclass pdata of Remote
+ * processor to a buffer and then loads firmware to the remote processor
+ * using rproc_load().
+ *
+ * Return: 0 on success, and an appropriate error value otherwise
+ */
+int rproc_boot(struct udevice *rproc_dev, size_t fw_size);
 #else
 static inline int rproc_init(void) { return -ENOSYS; }
 static inline int rproc_dev_init(int id) { return -ENOSYS; }
@@ -743,6 +774,10 @@ static inline int rproc_elf_load_rsc_table(struct
udevice *dev, ulong fw_addr,
 					   ulong fw_size, ulong *rsc_addr,
 					   ulong *rsc_size)
 { return -ENOSYS; }
+static inline int rproc_set_firmware(struct udevice *rproc_dev, const
char *fw_name)
+{ return -ENOSYS; }
+static inline int rproc_boot(struct udevice *rproc_dev, size_t fw_size)
+{ return -ENOSYS; }
 #endif

 #endif	/* _RPROC_H_ */


-- 
Thanks and Regards,
Danish
