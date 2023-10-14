Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6C8CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 05:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B52286BCD;
	Sun, 15 Oct 2023 07:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hCv+Ok2g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA27F86AB9; Sun, 15 Oct 2023 07:58:49 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7FBB86529
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 07:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=eb25=F5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: References: Cc:
 To: From: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1697349395;
 bh=NX2eB1ewAUjF+iupLwKRZf3zQXKfn1E2+uTRzRzhLLs=;
 b=hCv+Ok2gxYTnMIKe3p/yq9bk6ZfZ2YC7aFuMfSsGrXVIfctLnxDOhV6M/RVke7j5D3NkrIYL4
 ZqqMkfMC0mftolgoF7oSypN0qBbychwh4J1jI1oIQQzV6yYYLWNvj8G/ADAGc2JwlGOZpI0/A0Z
 QmXRO8GVdRDAUKpGl4AkNLJxSUxDv+SWjgAx68EKGmh67TEoCMp/RJr5z5XQ5IZcJSjXM9plz+6
 wmcMv5D3+g3lXzzs5lDOkworQuZcQaYOjvnGX7sCwGLupIGZcmywHvMJhvDmP4Od+KcPMgJsTaY
 bgNHTUoBd9f2bl0NMgqyAQZyj7NwfAC5NapcVjwQMlVQ==
Message-ID: <0b4315a9-849a-1b50-d622-1a47be602e3f@kwiboo.se>
Date: Sat, 14 Oct 2023 21:22:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/5] board: rockchip: Add Pine64 Quartz64-A Board
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
To: Christopher Obbard <chris.obbard@collabora.com>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, u-boot@lists.denx.de
References: <20230723145504.2967971-1-jonas@kwiboo.se>
 <20230723145504.2967971-2-jonas@kwiboo.se>
 <1e3634df-593c-506d-5254-332c44ca7c4d@kwiboo.se>
 <9ba7a208113eed26c61d3373f1659b866c1f8c85.camel@collabora.com>
 <c6acb79a-aa4c-f6e0-648e-7890e75ff714@kwiboo.se>
 <bf74c779670c2dc249278b5a52620d7fcebafe98.camel@collabora.com>
 <36a3377463cc2a167534574a096cb5097ea7c242.camel@collabora.com>
 <3b496548-04be-a2b2-5b98-6925b96933f0@kwiboo.se>
In-Reply-To: <3b496548-04be-a2b2-5b98-6925b96933f0@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 652aea919661519a6e34b5f2
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

On 2023-10-14 20:58, Jonas Karlman wrote:
> Hi Christopher,
> 
> On 2023-10-12 13:46, Christopher Obbard wrote:
>> Hi Jonas,
>>
>> On Thu, 2023-10-12 at 10:51 +0100, Christopher Obbard wrote:
>>> Hi Jonas,
>>>
>>> Sorry for the late response, I've been meaning to test this for a while but not got around to it.
>>>
>>> On Thu, 2023-08-17 at 23:56 +0000, Jonas Karlman wrote:
>>>> Hi Christopher,
>>>>
>>>> On 2023-08-08 16:25, Christopher Obbard wrote:
>>>>> Hi Jonas,
>>>>>
>>>>> On Sun, 2023-07-23 at 15:04 +0000, Jonas Karlman wrote:
>>>>>> On 2023-07-23 16:55, Jonas Karlman wrote:
>>>>>>> The Pine64 Quartz64 Model A is a single-board computer based on the
>>>>>>> Rockchip RK3566 SoC. The board features USB3, SATA, PCIe, HDMI, USB2.0,
>>>>>>> CSI, DSI, eDP, eMMC, SD, and an e-paper parallel port, as well as a
>>>>>>> 20 pin GPIO header.
>>>>>>>
>>>>>>> Features tested on a Quartz64-A 8GB v2.0 2021-04-27:
>>>>>>> - SD-card boot
>>>>>>> - eMMC boot
>>>>>>> - PCIe/NVMe/AHCI
>>>>>>> - USB host
>>>>>>>
>>>>>>> Device tree is imported from linux v6.4.
>>>>>>>
>>>>>>> Co-developed-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
>>>>>>> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
>>>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>>>>> ---
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>> Boot log with ROCKCHIP_TPL=rk3566_ddr_1056MHz_v1.17.bin and
>>>>>> BL31=rk3568_bl31_v1.43.elf:
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>> U-Boot 2023.07 (Jul 23 2023 - 12:42:18 +0000)
>>>>>>
>>>>>> Model: Pine64 RK3566 Quartz64-A Board
>>>>>> DRAM:  8 GiB (effective 7.7 GiB)
>>>>>> PMIC:  RK8170 (on=0x10, off=0x00)
>>>>>> Core:  321 devices, 27 uclasses, devicetree: separate
>>>>>> MMC:   rockchip_sdhci_probe clk set rate fail!
>>>>>> mmc@fe2b0000: 1, mmc@fe2c0000: 2, mmc@fe310000: 0
>>>>>> Loading Environment from nowhere... OK
>>>>>> In:    serial@fe660000
>>>>>> Out:   serial@fe660000
>>>>>> Err:   serial@fe660000
>>>>>> Model: Pine64 RK3566 Quartz64-A Board
>>>>>> Net:   No ethernet found.
>>>>>>
>>>>>> Hit any key to stop autoboot:  0
>>>>>> =>
>>>>>
>>>>>
>>>>> I just tried booting U-Boot v2023.10-rc2 with ROCKCHIP_TPL=rk3566_ddr_1056MHz_v1.17.bin and BL31=rk3568_bl31_v1.43.elf, on my Quartz64-A but it fails during
>>>>> loading of some parts. I removed the output of the RK TPL from my logs as there were no errors.
>>>>
>>>> Try with latest rk3566_ddr_1056MHz_v1.18.bin and see if that makes any
>>>> difference.
>>>
>>> No difference.
>>>
>>> I've also checked, there is no other maskrom bootable media such as SPI flash connected to the board.
>>>
>>>>
>>>>> This is when booting from eMMC.
>>>>
>>>> Does it boot with SD-card or other eMMC modules?
>>>
>>> Booting from SD card (without eMMC connected), everything works fine.
>>>
>>>>
>>>
>>>>> I also tried building your branch from https://github.com/Kwiboo/u-boot-rockchip/tree/rk3568-2023.10 
>>>>
>>>> Please try with a GitHub actions built u-boot-rockchip.bin based on my
>>>> rk3568-2023.07.02 branch at
>>>> https://github.com/Kwiboo/u-boot-build/actions/runs/5777761235
>>>
>>> With that exact artifact, flashed with:
>>>
>>>> rkdeveloptool db rk356x_spl_loader_v1.18.113.bin
>>>> rkdeveloptool ef
>>>> rkdeveloptool wl 64 u-boot-rockchip.bin
>>>> rkdeveloptool rd
>>>
>>> it fails to boot with with:
>>>
>>>> DDR V1.18 f366f69a7d typ 23/07/17-15:48:58
>>>> ln
>>>> LP4/4x derate en, other dram:1x trefi
>>>> SRX
>>>> ddrconfig:7
>>>> LPDDR4X, 324MHz
>>>> BW=32 Col=10 Bk=8 CS0 Row=17 CS1 Row=17 CS=2 Die BW=8 Size=8192MB
>>>>
>>>> change to: 324MHz
>>>> clk skew:0x60
>>>>
>>>> change to: 528MHz
>>>> clk skew:0x58
>>>>
>>>> change to: 780MHz
>>>> clk skew:0x58
>>>>
>>>> change to: 1056MHz(final freq)
>>>> clk skew:0x32
>>>> out
>>>>
>>>> U-Boot SPL 2023.07.02-g09919887 (Aug 06 2023 - 16:59:31 +0000)
>>>> Trying to boot from MMC1
>>>> spl: mmc init failed with error: -70
>>>> Trying to boot from MMC2
>>>> Card did not respond to voltage select! : -110
>>>> spl: mmc init failed with error: -95
>>>> Trying to boot from MMC1
>>>> mmc fail to send stop cmd
>>>> mmc_load_image_raw_sector: mmc block read error
>>>> SPL: failed to boot from all boot devices
>>>> ### ERROR ### Please RESET the board ###
>>>
>>> I also tried a second eMMC, but it also failed to boot with the same "mmc block read error" message.
>>
>>
>> I tried with your latest branch https://github.com/Kwiboo/u-boot-rockchip/commits/rk3568-2023.10
>>
>> and this time a different error message, loading from the eMMC appears to get a bit further:
>>
>>> U-Boot SPL 2023.10-00054-gef68159087 (Oct 12 2023 - 12:14:22 +0100)
>>> Trying to boot from MMC1
>>> ## Checking hash(es) for config config-1 ... OK
>>> ## Checking hash(es) for Image atf-1 ... sha256+ OK
>>> spl_load_simple_fit: can't load image loadables index 0 (ret = -5)
>>> mmc_load_image_raw_sector: mmc block read error
>>> Trying to boot from MMC2
>>> Card did not respond to voltage select! : -110
>>> spl: mmc init failed with error: -95
>>> Trying to boot from MMC1
>>> mmc_load_image_raw_sector: mmc block read error
>>> SPL: failed to boot from all boot devices
>>> ### ERROR ### Please RESET the board ###
>>
>> So this is pointing to an issue reading from the MMC...
>>
>> I found https://lists.denx.de/pipermail/u-boot/2023-April/514315.html (which is applied to your branch) and added the following to defconfig:
>>
>> CONFIG_MMC_SDHCI_SDMA=y
>> +# CONFIG_SPL_MMC_SDHCI_SDMA is not set
>>
>> but this seemed to make the loading less reliable:
>>
>>> U-Boot SPL 2023.10-00054-gef68159087-dirty (Oct 12 2023 - 12:23:10 +0100)
>>> Trying to boot from MMC1
>>> ## Checking hash(es) for config config-1 ... OK
>>> mmc fail to send stop cmd
>>> mmc_load_image_raw_sector: mmc block read error
>>> Trying to boot from MMC2
>>> Card did not respond to voltage select! : -110
>>> spl: mmc init failed with error: -95
>>> Trying to boot from MMC1
>>> mmc_load_image_raw_sector: mmc block read error
>>> SPL: failed to boot from all boot devices
>>> ### ERROR ### Please RESET the board ###
>>
>>
> 
> Thanks for testing different combinations.
> 
> I did find an issue with emmc write using ddr52 and hs400 modes on
> rk3568. On rk3588 emmc write only worked reliable after hs200 mode had
> been used.
> 
> Please try the changes from following commit, or my rk35xx-2024.01
> work-in-progress branch:
> 
> WIP: rockchip: rk35xx: improve emmc write
> https://github.com/Kwiboo/u-boot-rockchip/commit/aa6156179bb2034e8ba26753e05285e276327d78
> 
> Most rk356x boards currently default to ddr52 mode, and possible emmc
> read is also affected with similar issue as emmc write.
> 
> I have also discovered a strange issue on an Amlogic soc related to
> U-Boot mmc commands and gcc optimization, please see following patch:
> https://patchwork.ozlabs.org/patch/1839392/

Posted link to wrong patch, I meant the following patch:

[RFC] mmc: Remove alignment hole for cmdidx in struct mmc_cmd
https://patchwork.ozlabs.org/patch/1841495/

Regards,
Jonas

> 
> Please try with CONFIG_MMC_TRACE=y to see what commands fails on your
> device.
> 
> If above patches does not work also try with following options applied:
> 
> CONFIG_MMC_HS200_SUPPORT=y
> CONFIG_SPL_MMC_HS200_SUPPORT=y
> 
> Use of HS200 seem to be the most reliable option on rk35xx based on my
> limited testing.
> 
>> ...
>>
>>>>
>>>> What happens if you write u-boot-rockchip.bin to eMMC module usinga USB adapter:
>>>>
>>>>   dd if=u-boot-rockchip.bin of=/dev/<device> bs=32k seek=1 conv=fsync
>>>>
>>>> or using U-Boot cmd when booted from a SD-card?
>>>>
>>>>   # Read u-boot-rockchip.bin from first partition of a SD card
>>>>   load mmc 1:1 10000000 u-boot-rockchip.bin
>>>>
>>>>   # Change to eMMC
>>>>   mmc dev 0
>>>>
>>>>   # Write 10 MiB (0x5000 blocks) at sector 64 (0x40)
>>>>   mmc write $fileaddr 40 5000
>>>>
>>>> Does that make any difference?
>>>
>>> I don't think I have an eMMC writer for Pine64 eMMCs, I will try to get hold of one this week.
>>
>> I have two USB writers. Anyway, the first boot, it fails with:
>>
>>> U-Boot SPL 2023.10-00054-gef68159087 (Oct 12 2023 - 12:30:14 +0100)
>>> Trying to boot from MMC1
>>> ## Checking hash(es) for config config-1 ... OK
>>> ## Checking hash(es) for Image atf-1 ... sha256+ OK
>>> ## Checking hash(es) for Image u-boot ... sha256+ OK
>>> <hang>
>>
>>
>> Then again after a reset:
>>
>>> U-Boot SPL 2023.10-00054-gef68159087 (Oct 12 2023 - 12:30:14 +0100)
>>> Trying to boot from MMC1
>>> mmc fail to send stop cmd
>>> mmc_load_image_raw_sector: mmc block read error
>>> Trying to boot from MMC2
>>> Card did not respond to voltage select! : -110
>>> spl: mmc init failed with error: -95
>>> Trying to boot from MMC1
>>> mmc_load_image_raw_sector: mmc block read error
>>> SPL: failed to boot from all boot devices
>>> ### ERROR ### Please RESET the board ###
>>
>>
>>
>>
>>> But it fails to write to the eMMC with:
>>>
>>>> => load mmc 1:2 10000000 u-boot-rockchip.bin
>>>> 9510400 bytes read in 791 ms (11.5 MiB/s)
>>>>
>>>> => mmc dev 0
>>>> switch to partitions #0, OK
>>>> mmc0(part 0) is current device
>>>>
>>>>
>>>> => mmc write $fileaddr 40 5000
>>>> MMC write: dev # 0, block # 64, count 20480 ... mmc write failed
>>>> 0 blocks written: ERROR
>>>>
>>>> => mmc info
>>>> Device: mmc@fe310000
>>>> Manufacturer ID: 45
>>>> OEM: 0
>>>> Name: DF4016 
>>>> Bus Speed: 52000000
>>>> Mode: MMC DDR52 (52MHz)
>>>> Rd Block Len: 512
>>>> MMC version 5.1
>>>> High Capacity: Yes
>>>> Capacity: 14.7 GiB
>>>> Bus Width: 8-bit DDR
>>>> Erase Group Size: 512 KiB
>>>> HC WP Group Size: 8 MiB
>>>> User Capacity: 14.7 GiB WRREL
>>>> Boot Capacity: 4 MiB ENH
>>>> RPMB Capacity: 4 MiB ENH
>>>
>>> I think this points to some issue with the mmc driver in U-Boot, or possibly some issue with my board. But I find that hard to believe because the Rockchip usbloader seems to write to the eMMC just
>>> fine ?
> 
> Probably related to sdhci driver and rx/tx tap and/or delay num etc.
> 
>>>
>>>>
>>>>>
>>>>> Boot log (v2023.10-rc2):
>>>>>
>>>>> U-Boot SPL 2023.10-rc2 (Aug 08 2023 - 14:02:34 +0100)
>>>>> rockchip_sdhci_probe clk set rate fail!
>>>>> Trying to boot from MMC1
>>>>> spl: mmc init failed with error: -110
>>>>> Trying to boot from MMC2
>>>>> Card did not respond to voltage select! : -110
>>>>> spl: mmc init failed with error: -95
>>>>> Trying to boot from MMC1
>>>>
>>>> Strange that second try of eMMC (MMC1) gets little bit longer.
>>>>
>>>>> ## Checking hash(es) for config config-1 ... OK
>>>>> ## Checking hash(es) for Image atf-1 ... sha256+ OK
>>>>> spl_load_simple_fit: can't load image loadables index 0 (ret = -5)
>>>>> mmc_load_image_raw_sector: mmc block read error
>>>>> SPL: failed to boot from all boot devices
>>>>> ### ERROR ### Please RESET the board ###
>>>>>
>>>>>
>>>>> Boot log (your branch):
>>>>>
>>>>> U-Boot SPL 2023.10-rc1-00368-g16cb31d427 (Aug 08 2023 - 15:17:35 +0100)
>>>>> Trying to boot from MMC1
>>>>> spl: mmc init failed with error: -70
>>>>> Trying to boot from MMC2
>>>>> Card did not respond to voltage select! : -110
>>>>> spl: mmc init failed with error: -95
>>>>> Trying to boot from MMC1
>>>>> ## Checking hash(es) for config config-1 ... OK
>>>>> mmc_load_image_raw_sector: mmc block read error
>>>>> SPL: failed to boot from all boot devices
>>>>> ### ERROR ### Please RESET the board ###
>>>>
>>>> I have not been able to reproduce this kind of issue on any of my two
>>>> Quartz64-A boards, tested with different eMMC modules.
>>>>
>>>> Does your eMMC module have some compatibility issue?
>>>> Do you have any more details on the eMMC module you have tested with?
>>>
>>> I have two eMMCs, one from FORESEE which came with a Pine64 and one marked SanDisk (which I posted the mmc info for above).
> 
> My eMMC modules is also FORESEE or SanDisk, from Pine64, Radxa and Hardkernel.
> 
>>>
>>> My hardware is marked Quartz64-RK3399-V2.0 2021-04-27
>>> Maybe there is some difference with your board?
> 
> Should match my board, I have the hw revision where SATA port is removed.
> (boards with/without SATA have same version silk on the board)
> 
>>>
>>> I will also try an image with vendor u-boot as a next step.
>>
>> I tried latest Armbian (which seems to use ) from https://github.com/armbian/build/releases/ and flashed the eMMC with the USB writer. It ended up booting to Linux, which proves that the hardware I
>> have is most likey in a good working order ;-)!
> 
> Hopefully the issue is related to the peephole2 optimization issue or
> the use of a not fully supported ddr52 mode.
> 
> Regards,
> Jonas
> 
>>
>>
>>> U-Boot SPL 2022.10-rc4-armbian (Feb 11 2023 - 22:25:16 +0000)
>>> saradc@fe720000: Can't update Vdd. Error: -38saradc@fe720000: Can't update Vss. Error: -38can't get vref-supply: -38
>>> rockchip_dnl_key_pressed: adc_channel_single_shot fail!
>>> Trying to boot from MMC2
>>> INFO:    Preloader serial: 2
>>> NOTICE:  BL31: v2.3():v2.3-152-g4e725b15f:cl
>>> NOTICE:  BL31: Built : 10:51:13, Jul 15 2021
>>> INFO:    GICv3 without legacy support detected.
>>> INFO:    ARM GICv3 driver initialized in EL3
>>> INFO:    pmu v1 is valid
>>> INFO:    dfs DDR fsp_param[0].freq_mhz= 1560MHz
>>> INFO:    dfs DDR fsp_param[1].freq_mhz= 324MHz
>>> INFO:    dfs DDR fsp_param[2].freq_mhz= 528MHz
>>> INFO:    dfs DDR fsp_param[3].freq_mhz= 780MHz
>>> INFO:    Using opteed sec cpu_context!
>>> INFO:    boot cpu mask: 0
>>> INFO:    BL31: Initializing runtime services
>>> WARNING: No OPTEE provided by BL2 boot loader, Booting device without OPTEE initialization. SMC`s destined for OPTEE will return SMC_UNK
>>> ERROR:   Error initializing runtime service opteed_fast
>>> INFO:    BL31: Preparing for EL3 exit to normal world
>>> INFO:    Entry point address = 0xa00000
>>> INFO:    SPSR = 0x3c9
>>>
>>>
>>> U-Boot 2022.10-rc4-armbian (Feb 11 2023 - 22:25:16 +0000)
>>>
>>> Model: Pine64 RK3566 Quartz64-A Board
>>> DRAM:  2 GiB
>>> PMIC:  RK8170 (on=0x10, off=0x00)
>>> Core:  266 devices, 21 uclasses, devicetree: separate
>>> MMC:   mmc@fe2b0000: 1, mmc@fe310000: 0
>>> Loading Environment from nowhere... OK
>>> In:    serial@fe660000
>>> Out:   serial@fe660000
>>> Err:   serial@fe660000
>>> Model: Pine64 RK3566 Quartz64-A Board
>>> can't get vref-supply: -2
>>> rockchip_dnl_key_pressed: adc_channel_single_shot fail!
>>> Net:   No ethernet found.
>>> Hit any key to stop autoboot:  0 
>>> starting USB...
>>> Bus usb@fcc00000: Port not available.
>>> Bus usb@fd000000: Port not available.
>>> Bus usb@fd800000: USB EHCI 1.00
>>> Bus usb@fd840000: USB OHCI 1.0
>>> Bus usb@fd880000: USB EHCI 1.00
>>> Bus usb@fd8c0000: USB OHCI 1.0
>>> scanning bus usb@fd800000 for devices... 1 USB Device(s) found
>>> scanning bus usb@fd840000 for devices... ERROR:  USB-error: DEVICENOTRESPONDING: Device did not respond to token (IN) or did
>>> not provide a handshake (OUT) (5)
>>> ERROR: USB-error: DEVICENOTRESPONDING: Device did not respond to token (IN) or did
>>> not provide a handshake (OUT) (5)
>>> unable to get device descriptor (error=-1)
>>> 1 USB Device(s) found
>>> scanning bus usb@fd880000 for devices... 1 USB Device(s) found
>>> scanning bus usb@fd8c0000 for devices... 1 USB Device(s) found
>>>        scanning usb for storage devices... 0 Storage Device(s) found
>>>
>>> Device 0: unknown device
>>> Card did not respond to voltage select! : -110
>>> switch to partitions #0, OK
>>> mmc0(part 0) is current device
>>> Scanning mmc 0:1...
>>> Found /boot/extlinux/extlinux.conf
>>> Retrieving file: /boot/extlinux/extlinux.conf
>>> 1:	Armbian
>>> Retrieving file: /boot/uInitrd
>>> Retrieving file: /boot/Image
>>> append: root=UUID=7f9c9970-93ba-46ca-9f03-f3241712ead8 console=ttyS02,1500000 console=tty0 rw no_console_suspend consoleblank=0 fsck.fix=yes fsck.repair=yes net.ifnames=0 splash plymouth.ignore-
>>> serial-consoles
>>> Retrieving file: /boot/dtb/rockchip/rk3566-quartz64-a.dtb
>>> Moving Image from 0x2080000 to 0x2200000, end=3de0000
>>> ## Loading init Ramdisk from Legacy Image at 0a200000 ...
>>>    Image Name:   uInitrd
>>>    Image Type:   AArch64 Linux RAMDisk Image (gzip compressed)
>>>    Data Size:    34402446 Bytes = 32.8 MiB
>>>    Load Address: 00000000
>>>    Entry Point:  00000000
>>>    Verifying Checksum ... OK
>>> ## Flattened Device Tree blob at 0a100000
>>>    Booting using the fdt blob at 0xa100000
>>>    Loading Ramdisk to 7be16000, end 7dee508e ... OK
>>>    Loading Device Tree to 000000007bdf7000, end 000000007be158e2 ... OK
>>>
>>> Starting kernel ...
>>>
>>> efi_free_pool: illegal free 0x000000007cee7040
>>> efi_free_pool: illegal free 0x000000007cee4040
>>> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x412fd050]
>>> [    0.000000] Linux version 6.2.0-rc6-media (root@d00a59921686) (aarch64-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture 8.3-2019.03 (arm-rel-8.36)) 8.3.0, GNU ld (GNU Toolchain for the
>>> A-profile Architecture 8.3-2019.03 (arm-rel-8.36)) 2.32.0.20190321) #trunk.0252 SMP PREEMPT_DYNAMIC Sat Feb 11 22:41:21 UTC 2023
>>> [    0.000000] Machine model: Pine64 RK3566 Quartz64-A Board
>>>
>>
>>
>>
>>
>> Thanks!
>>
>> Chris
> 

