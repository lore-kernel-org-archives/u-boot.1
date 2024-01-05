Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29131C3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 08:19:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2688C8796B;
	Fri,  5 Jan 2024 09:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AaaDOoAM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D51AA8796F; Fri,  5 Jan 2024 09:19:47 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BE1887957
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 09:19:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id E7DC0B81C11;
 Fri,  5 Jan 2024 08:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A967FC433C7;
 Fri,  5 Jan 2024 08:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704442784;
 bh=/HWbYqGjikiS2Ly9L9KfV9mHeN8nkubtToGMDxHdHvU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=AaaDOoAM+GNB7SKPT0ruUfulmJRINm6keFRRd5qY1bRE7nB/EAbSMTvS8z1iEXwka
 HJeGfDMLnz7Qo/rkQY2vV2uyvnsxPXFsa73+IlKyG43RBv1j9ae3FXekr0rpV0PDjX
 HTLiW4F41FvuGAoAYBTYw0Ybpo9E1wl/ZG1DFiWTpT0bYoxobGoeTeeq6/qXStMWG3
 5CRnIBldB3w5FfSeptMGVPt+ydUMDGeWVnbJhv8HHELAU+neebVn8XXjU4mKzRi+89
 sEitEBLRwEwW1nlRXhi735SRvLdS03IIM65rgsIoYo/FwIANjfRAxoLf/OusURrIAc
 sLOfNpf41ng5A==
Message-ID: <b3ecb419-6ef1-4f44-a6c8-57e259cb06db@kernel.org>
Date: Fri, 5 Jan 2024 10:19:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/16] Introduce ICSSG Ethernet driver
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, srk@ti.com, r-gunasekaran@ti.com
References: <20231219101225.3443978-1-danishanwar@ti.com>
 <6d9456ec-a483-4721-8713-626aacdc9f81@kernel.org>
 <4ccd7db1-533a-4243-9087-7e7c2e85b917@ti.com>
 <d841b7b8-80f8-467d-afed-1170a2627724@kernel.org>
 <46c69c28-09c3-4e60-92f5-1f91d795a22a@ti.com>
 <036c3423-4205-4d9e-9779-ecd3a49f8a47@ti.com>
 <64a18d0a-294d-4e11-a867-4191e99f2437@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <64a18d0a-294d-4e11-a867-4191e99f2437@ti.com>
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



On 03/01/2024 12:27, MD Danish Anwar wrote:
> 
> 
> On 02/01/24 7:26 pm, Andrew Davis wrote:
>> On 12/27/23 12:56 AM, MD Danish Anwar wrote:
>>>
>>>
>>> On 22/12/23 6:13 pm, Roger Quadros wrote:
>>>>
>>>> On 22/12/2023 12:26, MD Danish Anwar wrote:
>>>>> Hi Roger,
>>>>>
>>>>> On 20/12/23 3:29 pm, Roger Quadros wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 19/12/2023 12:11, MD Danish Anwar wrote:
>>>>>>> Introduce ICSSG PRUETH support in uboot. The ICSSG driver is used
>>>>>>> in TI
>>>>>>> AM654 SR2.0.
>>>>>>>
>>>>>>> The ICSSG PRU Sub-system runs on EMAC firmware. This series
>>>>>>> Introduces
>>>>>>> support for ICSSG driver in uboot. This series also adds the driver's
>>>>>>> dependencies.
>>>>>>>
>>>>>>> The ICSSG2 node is added in device tree overlay so that it remains in
>>>>>>> sync with linux kernel.
>>>>>>>
>>>>>>> The series introduces device tree and config changes and AM65x
>>>>>>> to enable ICSSG driver. The series also enables
>>>>>>> SPL_LOAD_FIT_APPLY_OVERLAY
>>>>>>> for AM65x in order to load overlay over spl.
>>>>>>>
>>>>>>> This series has been tested on AM65x SR2.0, and the ICSSG
>>>>>>> interface is
>>>>>>> able to ping / dhcp and boot kernel using tftp in uboot.
>>>>>>>
>>>>>>> To use ICSSG2 ethernet, the ICSSG firmware needs to be loaded to
>>>>>>> PRU RPROC
>>>>>>> cores and RPROC cores need to be booted with the firmware. This
>>>>>>> step is
>>>>>>> done inside driver in kernel as kernel supports APIs like
>>>>>>> rproc_set_firmware() and rproc_fw_boot(). But as u-boot doesn't
>>>>>>> have these
>>>>>>> APIs, the same needs to be done via u-boot cmds.
>>>>>>>
>>>>>>> To make sure icssg-eth works we need to do below steps.
>>>>>>>
>>>>>>> 1. Initialize rproc cores i.e. rproc_init()
>>>>>>> 2. Load $firmware_file from partition '1:2' (root) on device (mmc
>>>>>>> in this
>>>>>>>     example)
>>>>>>> 3. Load the firmware file to rproc cores passing. i.e. rproc_load()
>>>>>>>     taking rproc_id, loadaddr and file size as arguments.
>>>>>>> 4. Start rproc cores. i.e. rproc_start() taking rproc_id as arguments
>>>>>>>
>>>>>>> The above steps are done by running the below commands at u-boot
>>>>>>> prompt.
>>>>>>>
>>>>>>> => setenv start_icssg2 'rproc start 14; rproc start 15; rproc
>>>>>>> start 16; rproc start 17; rproc start 18; rproc start 19'
>>>>>>> => setenv stop_icssg2 'rproc stop 14; rproc stop 15; rproc stop
>>>>>>> 16; rproc stop 17; rproc stop 18; rproc stop 19'
>>>>>>> => setenv firmware_dir '/lib/firmware/ti-pruss'
>>>>>>> => setenv get_firmware_mmc 'load mmc ${bootpart} ${loadaddr}
>>>>>>> ${firmware_dir}/${firmware_file}'
>>>>>>>
>>>>>>> => setenv init_icssg2 'setenv ethact icssg2-eth; setenv autoload
>>>>>>> no; rproc init; setenv loadaddr 0x80000000; \
>>>>>>>      setenv firmware_file am65x-sr2-pru0-prueth-fw.elf; run
>>>>>>> get_firmware_mmc;  rproc load 14 0x80000000 ${filesize}; \
>>>>>>>      setenv loadaddr 0x89000000; setenv firmware_file
>>>>>>> am65x-sr2-rtu0-prueth-fw.elf; run get_firmware_mmc; rproc load 15
>>>>>>> 0x89000000 ${filesize}; \
>>>>>>>      setenv loadaddr 0x90000000; setenv firmware_file
>>>>>>> am65x-sr2-txpru0-prueth-fw.elf; run get_firmware_mmc; rproc load
>>>>>>> 16 0x90000000 ${filesize}; \
>>>>>>>      setenv loadaddr 0x80000000; setenv firmware_file
>>>>>>> am65x-sr2-pru1-prueth-fw.elf; run get_firmware_mmc; rproc load 17
>>>>>>> 0x80000000 ${filesize}; \
>>>>>>>      setenv loadaddr 0x89000000; setenv firmware_file
>>>>>>> am65x-sr2-rtu1-prueth-fw.elf; run get_firmware_mmc; rproc load 18
>>>>>>> 0x89000000 ${filesize}; \
>>>>>>>      setenv loadaddr 0x90000000; setenv firmware_file
>>>>>>> am65x-sr2-txpru1-prueth-fw.elf; run get_firmware_mmc; rproc load
>>>>>>> 19 0x90000000 ${filesize}; \
>>>>>>>      run start_icssg2;'
>>>>>>
>>>>>> A whole bunch of commands are required to get ethernet functional.
>>>>>> This is not at all user friendly and will be a maintenance nightmare.
>>>>>> What worries me is tracking the 6 different rproc cores and the 6
>>>>>> different firmware files to start 1 ethernet device.
>>>>>> This will get even more interesting when we have to deal with
>>>>>> different ICSSG instances on different boards.
>>>>>>
>>>>>> What is preventing the driver from starting the rproc cores it
>>>>>> needs so user doesn't need to care about it?
>>>>>> All the necessary information is in the Device tree. At least this
>>>>>> is how it is done on Linux.
>>>>>>
>>>>>
>>>>> I tried removing the need for these commands and implementing them
>>>>> inside the driver only. I am able to load the firmware from driver
>>>>> using
>>>>> the fs_loader API request_firmware_into_buf(). It requires changes to
>>>>> dt. A DT node called fs-loader needs to be added also CONFIG_FS_LOADER
>>>>> needs to enabled. In the DT node we need to specify the storage media
>>>>> that we are using i.e. mmc, ospi, usb. It's upto user to modify the
>>>>> storage media, the driver will take the media from DT and try to laod
>>>>> firmware from their.
>>>>>
>>>>> For loading firmwares to rproc cores, rproc_load() API is needed. Now
>>>>> this API takes rproc_id, loadaddr and firmware_size as arguments.
>>>>> loadaddr is fixed for all three pru cores. firmware_size is obtained
>>>>> from request_firmware_into_buf() but I couldn't find a way to get the
>>>>> rproc_id. For now based on the ICSSG instance and slice number I am
>>>>> figuring out the rproc_id and passing it to rproc_load() and
>>>>> rproc_start() APIs. Please let me know if you have any other / better
>>>>> way of finding rproc_id.
>>>>>
>>>>> Below is the entire diff to remove these commands and move their
>>>>> functionality to driver. Please have a look and let me know if this
>>>>> is ok.
>>>>>
>>>>
>>>> Good to see you got something working so quickly.
>>>> It has some rough edges but nothing that is blocking.
>>>>
>>>>>
>>>>> Save New Duplicate & Edit Just Text Twitter
>>>>> diff --git a/arch/arm/dts/k3-am654-base-board.dts
>>>>> b/arch/arm/dts/k3-am654-base-board.dts
>>>>> index cfbcebfa37..c8da72e49c 100644
>>>>> --- a/arch/arm/dts/k3-am654-base-board.dts
>>>>> +++ b/arch/arm/dts/k3-am654-base-board.dts
>>>>> @@ -16,6 +16,13 @@
>>>>>       chosen {
>>>>>           stdout-path = "serial2:115200n8";
>>>>>           bootargs = "earlycon=ns16550a,mmio32,0x02800000";
>>>>> +        firmware-loader = <&fs_loader0>;
>>>>> +    };
>>>>> +
>>>>> +    fs_loader0: fs-loader {
>>>>> +        bootph-all;
>>>>> +        compatible = "u-boot,fs-loader";
>>>>> +        phandlepart = <&sdhci1 2>;
>>>>>       };
>>>>
>>>> This is has 2 issues
>>>> 1) It will not be accepted in Kernel DT. Maybe it could be done in
>>>> -u-boot.dtsi file.
>>>
>>> Sure. I'll move this to k3-am654-base-board-u-boot.dtsi
>>>
>>>> 2) You cannot assume boot medium is always sdhci1 2
>>>>
>>>
>>> Yes. It's upto user to provide the boot medium and boot partition for
>>> loading firmware. By default the firmware is loacated in root partion of
>>> shdci1 on am65x so I am adding this as default. But user can easily
>>> modify this to any other medium / partition needed.
>>>
>>
>> Users should not have to modify DT to pick a boot medium/partition.
>> What would you do for complex cases or non block devices like eth/uart
> 
I agree with Andrew here.

> In order to load firmware files from driver, we need to add the node for
> fs-loader. The fs-loader has a phandlepart property which takes the boot
> medium and the partition as input. Based on the medium and partition it
> looks for the requested file and loads it to a given address. I am not
> sure if there is any other way to load firmware from driver without
> using the fs-loader.
> 
> 
>> booting? This is one reason kernel moved firmware loading to
>> userspace. The equivalant in U-Boot is the shell and scripts. Your
>> original command based loading was the correct solution IMHO.
> 
> I intended to go ahead with command base approach only but as Roger
> pointed out the command based approach is not very user friendly.
> 
> We need to align on what should be the correct approach for loading
> firmware.
> 
> Roger, can you please chime in here.

My intention was to make it user friendly so he does not have to
deal with 6 different Rproc IDs that can change between
platforms. The solution also has to be seamless between different
boot mediums. I think we can assume that the firmware will come from the
same medium that the platform was booted.

> 
>>
>> If we want to try to hide some of that then we need a way to
>> run a user provided script from the environement to handle
>> the general cases for firmware loading.

Assuming we go with the "script provided in environment: route,
how do we deal with the Rproc IDs? I'm not sure if they are constant
and can probably change based on which Rproc is registered first.
So there needs to be some way to make sure user can reference
the correct Rproc.

>>
>> Andrew

<snip>

-- 
cheers,
-roger
