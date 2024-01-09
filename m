Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B26C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 09:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AF3F87873;
	Tue,  9 Jan 2024 10:50:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gykCkmF6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A85BC87876; Tue,  9 Jan 2024 10:50:15 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83DC18773F
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 10:50:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4099o3no001767;
 Tue, 9 Jan 2024 03:50:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704793803;
 bh=BQVfLFwRUpK+7Yo3oN0sf5La4csFJRo+q47d3hzdILg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=gykCkmF6SN5NdXmvOvv1GZ3veXbwqKBa+rhIx5Q+nM1TCnqikE5BYa+1YazatiNoP
 xuaU/rVmLclGf9XzViINKsF4SR9A6CrYC9vYuNy1NW6yyIAZ8LwfUKjqNn8romFlnF
 Uw1KZVdwzJGJxSLxOLpebyvPOPCm6E8D5PFqd58E=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4099o3Yh019948
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Jan 2024 03:50:03 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 03:50:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 03:50:02 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4099nvhU044807;
 Tue, 9 Jan 2024 03:49:58 -0600
Message-ID: <bc6bddb4-6569-4e66-b1ab-15d027d3958b@ti.com>
Date: Tue, 9 Jan 2024 15:19:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/16] Introduce ICSSG Ethernet driver
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, "Anwar, Md Danish" <a0501179@ti.com>,
 Andrew Davis <afd@ti.com>, Maxime Ripard <mripard@kernel.org>, Siddharth
 Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20231219101225.3443978-1-danishanwar@ti.com>
 <6d9456ec-a483-4721-8713-626aacdc9f81@kernel.org>
 <4ccd7db1-533a-4243-9087-7e7c2e85b917@ti.com>
 <d841b7b8-80f8-467d-afed-1170a2627724@kernel.org>
 <46c69c28-09c3-4e60-92f5-1f91d795a22a@ti.com>
 <036c3423-4205-4d9e-9779-ecd3a49f8a47@ti.com>
 <64a18d0a-294d-4e11-a867-4191e99f2437@ti.com>
 <b3ecb419-6ef1-4f44-a6c8-57e259cb06db@kernel.org>
 <0151a34a-7426-4072-a442-39625d236010@ti.com>
 <0b912565-d34e-4fbd-88c4-1750fe8d3d96@kernel.org>
 <9897ea67-9e38-4026-a0a2-ccac08eb420c@ti.com>
 <4721f3b9-f823-47f3-b4f3-ed40002af31b@kernel.org>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <4721f3b9-f823-47f3-b4f3-ed40002af31b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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



On 09/01/24 2:56 pm, Roger Quadros wrote:
> 
> 
> On 08/01/2024 12:25, MD Danish Anwar wrote:
>> On 08/01/24 3:00 pm, Roger Quadros wrote:
>>>
>>>
>>> On 05/01/2024 12:15, Anwar, Md Danish wrote:
>>>>
>>>>
>>>> On 1/5/2024 1:49 PM, Roger Quadros wrote:
>>>>>
>>>>>
>>>>> On 03/01/2024 12:27, MD Danish Anwar wrote:
>>>>>>
>>>>>>
>>>>>> On 02/01/24 7:26 pm, Andrew Davis wrote:
>>>>>>> On 12/27/23 12:56 AM, MD Danish Anwar wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 22/12/23 6:13 pm, Roger Quadros wrote:
>>>>>>>>>
>>>>>>>>> On 22/12/2023 12:26, MD Danish Anwar wrote:
>>>>>>>>>> Hi Roger,
>>>>>>>>>>
>>>>>>>>>> On 20/12/23 3:29 pm, Roger Quadros wrote:
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> On 19/12/2023 12:11, MD Danish Anwar wrote:
>>>>>>>>>>>> Introduce ICSSG PRUETH support in uboot. The ICSSG driver is used
>>>>>>>>>>>> in TI
>>>>>>>>>>>> AM654 SR2.0.
>>>>>>>>>>>>
>>>>>>>>>>>> The ICSSG PRU Sub-system runs on EMAC firmware. This series
>>>>>>>>>>>> Introduces
>>>>>>>>>>>> support for ICSSG driver in uboot. This series also adds the driver's
>>>>>>>>>>>> dependencies.
>>>>>>>>>>>>
>>>>>>>>>>>> The ICSSG2 node is added in device tree overlay so that it remains in
>>>>>>>>>>>> sync with linux kernel.
>>>>>>>>>>>>
>>>>>>>>>>>> The series introduces device tree and config changes and AM65x
>>>>>>>>>>>> to enable ICSSG driver. The series also enables
>>>>>>>>>>>> SPL_LOAD_FIT_APPLY_OVERLAY
>>>>>>>>>>>> for AM65x in order to load overlay over spl.
>>>>>>>>>>>>
>>>>>>>>>>>> This series has been tested on AM65x SR2.0, and the ICSSG
>>>>>>>>>>>> interface is
>>>>>>>>>>>> able to ping / dhcp and boot kernel using tftp in uboot.
>>>>>>>>>>>>
>>>>>>>>>>>> To use ICSSG2 ethernet, the ICSSG firmware needs to be loaded to
>>>>>>>>>>>> PRU RPROC
>>>>>>>>>>>> cores and RPROC cores need to be booted with the firmware. This
>>>>>>>>>>>> step is
>>>>>>>>>>>> done inside driver in kernel as kernel supports APIs like
>>>>>>>>>>>> rproc_set_firmware() and rproc_fw_boot(). But as u-boot doesn't
>>>>>>>>>>>> have these
>>>>>>>>>>>> APIs, the same needs to be done via u-boot cmds.
>>>>>>>>>>>>
>>>>>>>>>>>> To make sure icssg-eth works we need to do below steps.
>>>>>>>>>>>>
>>>>>>>>>>>> 1. Initialize rproc cores i.e. rproc_init()
>>>>>>>>>>>> 2. Load $firmware_file from partition '1:2' (root) on device (mmc
>>>>>>>>>>>> in this
>>>>>>>>>>>>     example)
>>>>>>>>>>>> 3. Load the firmware file to rproc cores passing. i.e. rproc_load()
>>>>>>>>>>>>     taking rproc_id, loadaddr and file size as arguments.
>>>>>>>>>>>> 4. Start rproc cores. i.e. rproc_start() taking rproc_id as arguments
>>>>>>>>>>>>
>>>>>>>>>>>> The above steps are done by running the below commands at u-boot
>>>>>>>>>>>> prompt.
>>>>>>>>>>>>
>>>>>>>>>>>> => setenv start_icssg2 'rproc start 14; rproc start 15; rproc
>>>>>>>>>>>> start 16; rproc start 17; rproc start 18; rproc start 19'
>>>>>>>>>>>> => setenv stop_icssg2 'rproc stop 14; rproc stop 15; rproc stop
>>>>>>>>>>>> 16; rproc stop 17; rproc stop 18; rproc stop 19'
>>>>>>>>>>>> => setenv firmware_dir '/lib/firmware/ti-pruss'
>>>>>>>>>>>> => setenv get_firmware_mmc 'load mmc ${bootpart} ${loadaddr}
>>>>>>>>>>>> ${firmware_dir}/${firmware_file}'
>>>>>>>>>>>>
>>>>>>>>>>>> => setenv init_icssg2 'setenv ethact icssg2-eth; setenv autoload
>>>>>>>>>>>> no; rproc init; setenv loadaddr 0x80000000; \
>>>>>>>>>>>>      setenv firmware_file am65x-sr2-pru0-prueth-fw.elf; run
>>>>>>>>>>>> get_firmware_mmc;  rproc load 14 0x80000000 ${filesize}; \
>>>>>>>>>>>>      setenv loadaddr 0x89000000; setenv firmware_file
>>>>>>>>>>>> am65x-sr2-rtu0-prueth-fw.elf; run get_firmware_mmc; rproc load 15
>>>>>>>>>>>> 0x89000000 ${filesize}; \
>>>>>>>>>>>>      setenv loadaddr 0x90000000; setenv firmware_file
>>>>>>>>>>>> am65x-sr2-txpru0-prueth-fw.elf; run get_firmware_mmc; rproc load
>>>>>>>>>>>> 16 0x90000000 ${filesize}; \
>>>>>>>>>>>>      setenv loadaddr 0x80000000; setenv firmware_file
>>>>>>>>>>>> am65x-sr2-pru1-prueth-fw.elf; run get_firmware_mmc; rproc load 17
>>>>>>>>>>>> 0x80000000 ${filesize}; \
>>>>>>>>>>>>      setenv loadaddr 0x89000000; setenv firmware_file
>>>>>>>>>>>> am65x-sr2-rtu1-prueth-fw.elf; run get_firmware_mmc; rproc load 18
>>>>>>>>>>>> 0x89000000 ${filesize}; \
>>>>>>>>>>>>      setenv loadaddr 0x90000000; setenv firmware_file
>>>>>>>>>>>> am65x-sr2-txpru1-prueth-fw.elf; run get_firmware_mmc; rproc load
>>>>>>>>>>>> 19 0x90000000 ${filesize}; \
>>>>>>>>>>>>      run start_icssg2;'
>>>>>>>>>>>
>>>>>>>>>>> A whole bunch of commands are required to get ethernet functional.
>>>>>>>>>>> This is not at all user friendly and will be a maintenance nightmare.
>>>>>>>>>>> What worries me is tracking the 6 different rproc cores and the 6
>>>>>>>>>>> different firmware files to start 1 ethernet device.
>>>>>>>>>>> This will get even more interesting when we have to deal with
>>>>>>>>>>> different ICSSG instances on different boards.
>>>>>>>>>>>
>>>>>>>>>>> What is preventing the driver from starting the rproc cores it
>>>>>>>>>>> needs so user doesn't need to care about it?
>>>>>>>>>>> All the necessary information is in the Device tree. At least this
>>>>>>>>>>> is how it is done on Linux.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I tried removing the need for these commands and implementing them
>>>>>>>>>> inside the driver only. I am able to load the firmware from driver
>>>>>>>>>> using
>>>>>>>>>> the fs_loader API request_firmware_into_buf(). It requires changes to
>>>>>>>>>> dt. A DT node called fs-loader needs to be added also CONFIG_FS_LOADER
>>>>>>>>>> needs to enabled. In the DT node we need to specify the storage media
>>>>>>>>>> that we are using i.e. mmc, ospi, usb. It's upto user to modify the
>>>>>>>>>> storage media, the driver will take the media from DT and try to laod
>>>>>>>>>> firmware from their.
>>>>>>>>>>
>>>>>>>>>> For loading firmwares to rproc cores, rproc_load() API is needed. Now
>>>>>>>>>> this API takes rproc_id, loadaddr and firmware_size as arguments.
>>>>>>>>>> loadaddr is fixed for all three pru cores. firmware_size is obtained
>>>>>>>>>> from request_firmware_into_buf() but I couldn't find a way to get the
>>>>>>>>>> rproc_id. For now based on the ICSSG instance and slice number I am
>>>>>>>>>> figuring out the rproc_id and passing it to rproc_load() and
>>>>>>>>>> rproc_start() APIs. Please let me know if you have any other / better
>>>>>>>>>> way of finding rproc_id.
>>>>>>>>>>
>>>>>>>>>> Below is the entire diff to remove these commands and move their
>>>>>>>>>> functionality to driver. Please have a look and let me know if this
>>>>>>>>>> is ok.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Good to see you got something working so quickly.
>>>>>>>>> It has some rough edges but nothing that is blocking.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Save New Duplicate & Edit Just Text Twitter
>>>>>>>>>> diff --git a/arch/arm/dts/k3-am654-base-board.dts
>>>>>>>>>> b/arch/arm/dts/k3-am654-base-board.dts
>>>>>>>>>> index cfbcebfa37..c8da72e49c 100644
>>>>>>>>>> --- a/arch/arm/dts/k3-am654-base-board.dts
>>>>>>>>>> +++ b/arch/arm/dts/k3-am654-base-board.dts
>>>>>>>>>> @@ -16,6 +16,13 @@
>>>>>>>>>>       chosen {
>>>>>>>>>>           stdout-path = "serial2:115200n8";
>>>>>>>>>>           bootargs = "earlycon=ns16550a,mmio32,0x02800000";
>>>>>>>>>> +        firmware-loader = <&fs_loader0>;
>>>>>>>>>> +    };
>>>>>>>>>> +
>>>>>>>>>> +    fs_loader0: fs-loader {
>>>>>>>>>> +        bootph-all;
>>>>>>>>>> +        compatible = "u-boot,fs-loader";
>>>>>>>>>> +        phandlepart = <&sdhci1 2>;
>>>>>>>>>>       };
>>>>>>>>>
>>>>>>>>> This is has 2 issues
>>>>>>>>> 1) It will not be accepted in Kernel DT. Maybe it could be done in
>>>>>>>>> -u-boot.dtsi file.
>>>>>>>>
>>>>>>>> Sure. I'll move this to k3-am654-base-board-u-boot.dtsi
>>>>>>>>
>>>>>>>>> 2) You cannot assume boot medium is always sdhci1 2
>>>>>>>>>
>>>>>>>>
>>>>>>>> Yes. It's upto user to provide the boot medium and boot partition for
>>>>>>>> loading firmware. By default the firmware is loacated in root partion of
>>>>>>>> shdci1 on am65x so I am adding this as default. But user can easily
>>>>>>>> modify this to any other medium / partition needed.
>>>>>>>>
>>>>>>>
>>>>>>> Users should not have to modify DT to pick a boot medium/partition.
>>>>>>> What would you do for complex cases or non block devices like eth/uart
>>>>>>
>>>>> I agree with Andrew here.
>>>>>
>>>>>> In order to load firmware files from driver, we need to add the node for
>>>>>> fs-loader. The fs-loader has a phandlepart property which takes the boot
>>>>>> medium and the partition as input. Based on the medium and partition it
>>>>>> looks for the requested file and loads it to a given address. I am not
>>>>>> sure if there is any other way to load firmware from driver without
>>>>>> using the fs-loader.
>>>>>>
>>>>>>
>>>>>>> booting? This is one reason kernel moved firmware loading to
>>>>>>> userspace. The equivalant in U-Boot is the shell and scripts. Your
>>>>>>> original command based loading was the correct solution IMHO.
>>>>>>
>>>>>> I intended to go ahead with command base approach only but as Roger
>>>>>> pointed out the command based approach is not very user friendly.
>>>>>>
>>>>>> We need to align on what should be the correct approach for loading
>>>>>> firmware.
>>>>>>
>>>>>> Roger, can you please chime in here.
>>>>>
>>>>> My intention was to make it user friendly so he does not have to
>>>>> deal with 6 different Rproc IDs that can change between
>>>>> platforms. The solution also has to be seamless between different
>>>>> boot mediums. I think we can assume that the firmware will come from the
>>>>> same medium that the platform was booted.
>>>>>
>>>>
>>>> Yes and the with changes done by me using ICSSG port seems much easier
>>>> and user friendly. Just doing `dhcp` at u-boot prompt is enough to use
>>>> ICSSG port so the driver changes effectively makes the usage for user
>>>> friendly. But only way I have found to load the firmware files is to use
>>>> fs-loader that requires the boot medium and boot partition. I am not
>>>> sure how can I re-use the the boot medium used for booting u-boot images.
>>>>
>>>> Also in SD card, u-boot images are located in /boot partition where as
>>>> firmware is located inside /root partition. So we'll need to specify the
>>>> partition.
>>>>
>>>> Currently I don't have any way to load the firmware files from driver
>>>> without using below DT change
>>>>
>>>> fs_loader0: fs-loader {
>>>>         bootph-all;
>>>>         compatible = "u-boot,fs-loader";
>>>>         phandlepart = <&sdhci1 2>;
>>>> };
>>>>
>>>
>>> Fromdoc/develop/driver-model/fs_firmware_loader.rst
>>>
>>> "Firmware loader driver is also designed to support U-Boot environment
>>> variables, so all these data from FDT can be overwritten
>>> through the U-Boot environment variable during run time.
>>>
>>> For examples:
>>>
>>> storage_interface:
>>>   Storage interface, it can be "mmc", "usb", "sata" or "ubi".
>>> fw_dev_part:
>>>   Block device number and its partition, it can be "0:1".
>>> fw_ubi_mtdpart:
>>>   UBI device mtd partition, it can be "UBI".
>>> fw_ubi_volume:
>>>   UBI volume, it can be "ubi0".
>>>
>>> When above environment variables are set, environment values would be
>>> used instead of data from FDT.
>>> The benefit of this design allows user to change storage attribute data
>>> at run time through U-Boot console and saving the setting as default
>>> environment values in the storage for the next power cycle, so no
>>> compilation is required for both driver and FDT."
>>>
>>> So looks like we should provide this in environment variables instead of DT?
>>>
>>
>> Thanks Roger for digging this up. I tried setting the below environment
>> values and it works.
>>
>> 	storage_interface=mmc
>> 	fw_dev_part=1:2
>>
>> No need to add the fs-loader node in DT. We can directly set the env
>> values and fs_loader will use them to load file. I will drop the DT
>> change for fs-loader. I think this env approach is same as running the
>> load command at u-boot (the initial approach). I think any medium that
>> could be used using load command, can be used here by setting
>> appropriate env values.
>>
>> Roger, Should I add the below code to include/env/ti/ti_common.env or
>> board/ti/am65x/am65x.env so that we don't need to set these variables
>> manually everytime we try to use ICSSG Ethernet and by default these
>> variables will be set to mmc and 1:2. User can definately modify these
>> at u-boot prompt and set appropriate values before running `dhcp`.
>>
>> diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
>> index f0f89a2287..0861d3be34 100644
>> --- a/include/env/ti/ti_common.env
>> +++ b/include/env/ti/ti_common.env
>> @@ -35,3 +35,8 @@ bootcmd_ti_mmc=
>>         else;
>>                 run get_kern_${boot}; run get_fdt_${boot}; run
>> get_overlay_${boot}; run run_kern;
>>         fi;
>> +
>> +#if CONFIG_TI_ICSSG_PRUETH
>> +storage_interface=mmc
> 
> "storage_interface" is vague. It should be updated to fw_storage_interface in fs-loader driver
> and environment. It could fallback to storage_interface to not break existing implementations.
> 

Sure. But changing "storage_interface" to "fw_storage_interface" in  the
fs-loader driver will also require changing the variable name in all the
users drivers (e.g. arch/arm/mach-k3/common.c)

>> +fw_dev_part=1:2
>> +#endif
>>
> 
> I think it should go in the respective <board>.env file as not all TI platforms
> have the same boot/firmware partition.
> so I would put it in board/ti/am65x/am65x.env
> 

Sure, I'll keep it in board/ti/am65x/am65x.env.

Andrew, Can you please confirm if you are okay with this approach. I
will post v2 soon, once you confirm.

>>
>>>>>>
>>>>>>>
>>>>>>> If we want to try to hide some of that then we need a way to
>>>>>>> run a user provided script from the environement to handle
>>>>>>> the general cases for firmware loading.
>>>>>
>>>>> Assuming we go with the "script provided in environment: route,
>>>>> how do we deal with the Rproc IDs? I'm not sure if they are constant
>>>>> and can probably change based on which Rproc is registered first.
>>>>> So there needs to be some way to make sure user can reference
>>>>> the correct Rproc.
>>>>>
>>>>
>>>> The Rproc IDs aren't constant. I think the IDs depend on the sequence of
>>>> init. The only way to know the IDs of different Rprocs is to run `rproc
>>>> init` and then `rproc list`. Mostly on AM65x I have seen Rporc ID 0 and
>>>> 1 to be of r5 rprocs and from 2 to 19 of differnet PRUs (Total 18, 6 per
>>>> ICSSG instance). If r5 is not enabled, the sequence changes. Similarly
>>>> if some other rproc is enabled sequence will change.
>>>>
>>>> The script should be able to read the list and determine which rproc
>>>> needs to be loaded based on the port we want to use. I am not sure how
>>>> to do this during u-boot.
>>>>
>>>
>>> rproc list gives an output in the following format.
>>>
>>> => rproc list
>>> 0 - Name:'r5f@41000000' type:'internal memory mapped' supports: load start stop reset
>>> 1 - Name:'r5f@41400000' type:'internal memory mapped' supports: load start stop reset
>>> 2 - Name:'r5f@5c00000' type:'internal memory mapped' supports: load start stop reset
>>> 3 - Name:'r5f@5d00000' type:'internal memory mapped' supports: load start stop reset
>>> 4 - Name:'r5f@5e00000' type:'internal memory mapped' supports: load start stop reset
>>> 5 - Name:'r5f@5f00000' type:'internal memory mapped' supports: load start stop reset
>>> 6 - Name:'dsp@4d80800000' type:'internal memory mapped' supports: load start stop reset
>>> 7 - Name:'dsp@4d81800000' type:'internal memory mapped' supports: load start stop reset
>>> 8 - Name:'dsp@64800000' type:'internal memory mapped' supports: load start stop reset
>>>
>>> How can the script know which rproc to start for a specific Ethernet interface?
>>>
>>
>> I am not sure. For ICSSGx port-y, we need to start pru_x_y, rtu_x_y,
>> tx_pru_x_y. The script could search for these core names and start the
>> core number corresponding to these names in the result of `rproc list`.
>>
>> I think it will not be needed now as we can modify the envs to select
>> different mediums, instead of hardcoding DT.
>>
> 
> OK.
> 

-- 
Thanks and Regards,
Danish
