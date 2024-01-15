Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB069C47422
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 17:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 201D58785C;
	Mon, 15 Jan 2024 18:34:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="tRYnruwD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 430E58784B; Mon, 15 Jan 2024 18:34:38 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3E228785C
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 18:34:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1744d49635=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40FHHfXY027685; Mon, 15 Jan 2024 18:34:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=od5etyPnHb9pw+5U/Va0ehN90qV3PFinxRrS/gcRzGU=; b=tR
 YnruwDJXx2n87magJsbTKeyqZGM9BX64ph05r2ACENWdy2eZ/VdS1nRDvNdYZ4f/
 9Egm9aOjBYe/Krb0qe/pUUMCtxvUMQ2Sx5MZvFBhQ6ntckYMP1tx6by+J3VOWfGB
 jT6GUcc2UolhaE5nhpfoRLpt9iZiQFhbXbjkN7kYt0l14JvOC2bnWL7K66krPEBM
 O2j9CXn6Pqh3sUNEmGBYmqPTGoxIQUegCHgcJomHzySwr9YAUjnCvzmSeHWUZCx/
 mSn6aeunf2XBzJVbvjeIlvvnXYofNUEUmuYc4L71jlFbNSYtuHZbulWD2mMZoYrx
 /1xzOxWt+Pe5TvP0UEHg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkmddsyk7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 18:34:27 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 20EEA10002A;
 Mon, 15 Jan 2024 18:34:26 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 075AF28C18A;
 Mon, 15 Jan 2024 18:34:26 +0100 (CET)
Received: from [10.201.20.205] (10.201.20.205) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Jan
 2024 18:34:25 +0100
Message-ID: <ce968882-f30b-4f49-85cf-c38f78bb6ff8@foss.st.com>
Date: Mon, 15 Jan 2024 18:34:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/24] Modernize U-Boot shell
Content-Language: en-US
To: Francesco Dolcini <francesco@dolcini.it>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
CC: <u-boot@lists.denx.de>, Michael Nazzareno Trimarchi
 <michael@amarulasolutions.com>, Harald Seiler <hws@denx.de>, Simon Glass
 <sjg@chromium.org>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
 <170379713946.899302.2054678070497875668.b4-ty@konsulko.com>
 <5740853.DvuYhMxLoT@pwmachine> <20240111170418.GA7220@francesco-nb>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240111170418.GA7220@francesco-nb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.205]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
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



On 1/11/24 18:04, Francesco Dolcini wrote:
> Hello Tom, Francis
> 
> On Fri, Dec 29, 2023 at 07:55:37PM +0100, Francis Laniel wrote:
>> Le jeudi 28 décembre 2023, 21:58:59 CET Tom Rini a écrit :
>>> On Fri, 22 Dec 2023 22:02:20 +0100, Francis Laniel wrote:
>>>> During 2021 summer, Sean Anderson wrote a contribution to add a new shell,
>>>> based on LIL, to U-Boot [1, 2].
>>>> While one of the goals of this contribution was to address the fact actual
>>>> U-Boot shell, which is based on Busybox hush, is old there was a
>>>> discussion
>>>> about adding a new shell versus updating the actual one [3, 4].
>>>>
>>>> So, in this series, with Harald Seiler, we updated the actual U-Boot shell
>>>> to reflect what is currently in Busybox source code.
>>>> Basically, this contribution is about taking a snapshot of Busybox
>>>> shell/hush.c file (as it exists in commit 37460f5da) and adapt it to suit
>>>> U-Boot needs.
>>>>
>>>> [...]
>>>
>>> Applied to u-boot/next, thanks!
>>
>> Thank you for the merge!
>> If there is any problem, do not hesitate to mail me and I will take care of 
>> it!
> 
> This change, specifically setting the modern hush shell as default, is
> breaking our boot script, just noticed since the current U-Boot master
> has a regression for us.
> 
> We still need to figure out the exact details, here [1] you can find the
> boot script (that has some placeholder that is replaced during build).
> 
> and the error is something like:
> 
> ```
> ## Executing script at 90280000
> Loading DeviceTree: k3-am625-verdin-nonwifi-dev.dtb
> 69025 bytes read in 11 ms (6 MiB/s)
> 82 bytes read in 9 ms (8.8 KiB/s)
> Working FDT set to 90200000
> syntax error at 'done'HUSH died!
> resetting ...
> ```
> 
> that I _assume_ comes from this line
> 
>     env set set_apply_overlays 'env set apply_overlays "for overlay_file in \\${fdt_overlays}; do echo Applying Overlay: \\${overlay_file} && ${load_cmd} \\${loadaddr} \\${overlays_prefix}\\${overlay_file} && fdt apply \\${loadaddr}; env set overlay_file; done; true"'
> 
> [1] https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-bsp/u-boot/u-boot-distro-boot/boot.cmd.in
> 
> Francesco
> 


Hi all

I observed a similar issue with STM32MP157c-DK2 board.
Since commit 78912cfde281 ("cmd: Set modern hush as default shell") U-Boot crashes :


U-Boot 2024.01-00486-g697758e7c81-dirty (Jan 15 2024 - 18:23:52 +0100)

CPU: STM32MP157CAC Rev.B
Model: STMicroelectronics STM32MP157C-DK2 Discovery Board
Board: stm32mp1 in trusted mode (st,stm32mp157c-dk2)
Board: MB1272 Var2.0 Rev.C-01
DRAM:  512 MiB
Clocks:
- MPU : 650 MHz
- MCU : 208.878 MHz
- AXI : 266.500 MHz
- PER : 24 MHz
- DDR : 533 MHz
optee optee: OP-TEE: revision 4.0 (e92de4ca)
I/TC: Reserved shared memory is disabled
I/TC: Dynamic shared memory is enabled
I/TC: Normal World virtualization support is disabled
I/TC: Asynchronous notifications are disabled
Core:  311 devices, 40 uclasses, devicetree: board
WDT:   Started watchdog@5a002000 with servicing every 1000ms (32s timeout)
NAND:  0 MiB
MMC:   STM32 SD/MMC: 0
Loading Environment from MMC... OK
In:    No input devices available!
Out:   No output devices available!
Err:   No error devices available!
Net:   eth0: ethernet@5800a000
Hit any key to stop autoboot:  0 
Boot over mmc0!
switch to partitions #0, OK
mmc0 is current device
Scanning mmc 0:8...
data abort
pc : [<ddb3f77a>]          lr : [<ddb44c95>]
reloc pc : [<c012777a>]    lr : [<c012cc95>]
sp : dbafc848  ip : ddbfc578     fp : ddbedf18
r10: 00000000  r9 : dbb15e70     r8 : 00000000
r7 : dbb5bf98  r6 : dbb5de10     r5 : dbb5bf98  r4 : ddbeda78
r3 : dbb5dc08  r2 : 000033f8     r1 : 00000071  r0 : ddbede00
Flags: nzcv  IRQs off  FIQs off  Mode SVC_32 (T)
Code: 3138 1c48 f854 0030 (eb04) 05c1 
Resetting CPU ...


It crashes in blkcache_fill() , i didn't investigate deeply into this issue yet, but i can reproduce this issue
by stopping autoboot by pressing a key and running a environment command as shown below :

U-Boot 2024.01-00486-g697758e7c81-dirty (Jan 15 2024 - 18:23:52 +0100)

CPU: STM32MP157CAC Rev.B
Model: STMicroelectronics STM32MP157C-DK2 Discovery Board
Board: stm32mp1 in trusted mode (st,stm32mp157c-dk2)
Board: MB1272 Var2.0 Rev.C-01
DRAM:  512 MiB
Clocks:
- MPU : 650 MHz
- MCU : 208.878 MHz
- AXI : 266.500 MHz
- PER : 24 MHz
- DDR : 533 MHz
optee optee: OP-TEE: revision 4.0 (e92de4ca)
I/TC: Reserved shared memory is disabled
I/TC: Dynamic shared memory is enabled
I/TC: Normal World virtualization support is disabled
I/TC: Asynchronous notifications are disabled
Core:  311 devices, 40 uclasses, devicetree: board
WDT:   Started watchdog@5a002000 with servicing every 1000ms (32s timeout)
NAND:  0 MiB
MMC:   STM32 SD/MMC: 0
Loading Environment from MMC... OK
In:    No input devices available!
Out:   No output devices available!
Err:   No error devices available!
Net:   eth0: ethernet@5800a000
Hit any key to stop autoboot:  0 
STM32MP> 
STM32MP> 


Then i run "printenv" :

STM32MP> printenv 
arch=arm
autoload=0
baudrate=115200
board=stm32mp1
board_id=0x1272
board_name=stm32mp157c-dk2
board_rev=0x000c
boot_a_script=load ${devtype} ${devnum}:${distro_bootpart} ${scriptaddr} ${prefix}${script}; source ${scriptaddr}
boot_auth=0
boot_device=mmc
boot_efi_binary=load ${devtype} ${devnum}:${distro_bootpart} ${kernel_addr_r} efi/boot/bootarm.efi; if fdt addr -q ${fdt_addr_r}; then bootefi ${kernel_addr_r} ${fdt_i
boot_efi_bootmgr=if fdt addr -q ${fdt_addr_r}; then bootefi bootmgr ${fdt_addr_r};else bootefi bootmgr;fi
boot_extlinux=sysboot ${devtype} ${devnum}:${distro_bootpart} any ${scriptaddr} ${prefix}${boot_syslinux_conf}
boot_instance=0
boot_net_usb_start=true
boot_part=1
boot_prefixes=/ /boot/
boot_script_dhcp=boot.scr.uimg
boot_scripts=boot.scr.uimg boot.scr
boot_syslinux_conf=extlinux/extlinux.conf
boot_targets=mmc1 ubifs0 mmc0 mmc2 usb0 pxe 
bootcmd=run bootcmd_stm32mp
bootcmd_mmc0=devnum=0; run mmc_boot
bootcmd_mmc1=devnum=1; run mmc_boot
bootcmd_mmc2=devnum=2; run mmc_boot
bootcmd_pxe=run boot_net_usb_start; dhcp; if pxe get; then pxe boot; fi
bootcmd_stm32mp=echo "Boot over ${boot_device}${boot_instance}!";if test ${boot_device} = serial || test ${boot_device} = usb;then stm32prog ${boot_device} ${boot_ins;
bootcmd_ubifs0=bootubipart=UBI; bootubivol=boot; bootubioff=; run ubifs_boot
bootcmd_usb0=devnum=0; run usb_boot
bootdelay=1
console=ttySTM0
cpu=armv7
distro_bootcmd=for target in ${boot_targets}; do run bootcmd_${target}; done
efi_dtb_prefixes=/ /dtb/ /dtb/current/
env_check=if env info -p -d -q; then env save; fi
ethaddr=00:80:e1:42:48:f9
fdt_addr_r=0xc4000000
fdtcontroladdr=dbafd730
fdtfile=stm32mp157c-dk2.dtb
fdtoverlay_addr_r=0xc4300000
kernel_addr_r=0xc2000000
load_efi_dtb=load ${devtype} ${devnum}:${distro_bootpart} ${fdt_addr_r} ${prefix}${efi_fdtfile}
loadaddr=0xc2000000
mmc_boot=if mmc dev ${devnum}; then devtype=mmc; run scan_dev_for_boot_part; fi
pxefile_addr_r=0xc4200000
ramdisk_addr_r=0xc4400000
scan_dev_for_boot=echo Scanning ${devtype} ${devnum}:${distro_bootpart}...; for prefix in ${boot_prefixes}; do run scan_dev_for_extlinux; run scan_dev_for_scripts; do;
scan_dev_for_boot_part=part list ${devtype} ${devnum} -bootable devplist; env exists devplist || setenv devplist 1; for distro_bootpart in ${devplist}; do if fstype $t
scan_dev_for_efi=setenv efi_fdtfile ${fdtfile}; if test -z "${fdtfile}" -a -n "${soc}"; then setenv efi_fdtfile ${soc}-${board}${boardver}.dtb; fi; for prefix in ${efe
scan_dev_for_extlinux=if test -e ${devtype} ${devnum}:${distro_bootpart} ${prefix}${boot_syslinux_conf}; then echo Found ${prefix}${boot_syslinux_conf}; run boot_extli
scan_dev_for_scripts=for script in ${boot_scripts}; do if test -e ${devtype} ${devnum}:${distro_bootpart} ${prefix}${script}; then echo Found U-Boot script ${prefix}$e
scriptaddr=0xc4100000
serial#=003700433338511634383330
serverip=192.168.1.1
soc=stm32mp
soc_pkg=AC
soc_rev=B
soc_type=157C
splashimage=0xc2000000
splashpos=m,m
ubifs_boot=if ubi part ${bootubipart} ${bootubioff} && ubifsmount ubi0:${bootubivol}; then devtype=ubi; devnum=ubi0; bootfstype=ubifs; distro_bootpart=${bootubivol}; i
usb_boot=usb start; if usb dev ${devnum}; then devtype=usb; run scan_dev_for_boot_part; fi
usb_pgood_delay=2000
vendor=st

Environment size: 4321/8187 bytes


and after i execute "run bootcmd_mmc0"

STM32MP> run bootcmd_mmc0
switch to partitions #0, OK
mmc0 is current device
Scanning mmc 0:8...
data abort
pc : [<ddb3f7a4>]          lr : [<ddb44c95>]
reloc pc : [<c01277a4>]    lr : [<c012cc95>]
sp : dbafcad8  ip : ddbfc578     fp : ddbedf18
r10: 00000000  r9 : dbb15e70     r8 : 00000000
r7 : dbb5f700  r6 : dbb615b8     r5 : dbb5f700  r4 : ddbeda78
r3 : dbb613b0  r2 : 00005c50     r1 : 0000002e  r0 : 00005c51
Flags: Nzcv  IRQs off  FIQs off  Mode SVC_32 (T)
Code: 315b e7e9 2954 d802 (0b11) 316e 
Resetting CPU ...

resetting ...


Thanks
Patrice


