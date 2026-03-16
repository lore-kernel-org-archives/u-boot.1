Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9962F53D9B
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 21:43:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4447C841F2;
	Mon, 16 Mar 2026 22:43:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Lv7WlGRN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46D4B841FF; Mon, 16 Mar 2026 22:43:40 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83637841DA
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 22:43:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bc56=BR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1773697416;
 bh=avp7j69Th/ILXB2Ekp0v2GhjVli4F2TFnJ84QbMhIjw=;
 b=Lv7WlGRNhNl3m9qR1cV9TZ39Ld0j12iuBLUuhkjFEwv/sg+RaXib2tTbMi+LYLxvG+3BPSWYu
 DrB2Otcirk3W+nykXnDnfl4o3fqLutKcz8TMGnc2i0z56KTm9eOUmzdYONI8KYKaknq7ICR/3ZO
 i9M5VLIri1V6RI8EzrN4wZOV4Vn4rs560rVEFnckgS2tQ9Mp/3Ng6GezGLFeztjr2Mnc1KoUH2f
 p4QOReUBEEa0vZHVKNDWByNFPP5kLu+rN2RcacX+OeG/j1iY0EClHEhRkVBpLc4f2gBWH02hd9i
 gQuY2hOXjdPxWCGK/fxkjrzxudOizhiahOcmsz9rGxuA==
X-Forward-Email-ID: 69b87985c47cbeebf997b96b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.6.50
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <822b68b9-e0a8-401f-a0b2-f4c66d1084d0@kwiboo.se>
Date: Mon, 16 Mar 2026 22:41:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: dwc2: allow usb start even if usbphy is not found
To: Marius Dinu <m95d+git@psihoexpert.ro>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20260316092639.2377-1-m95d+git@psihoexpert.ro>
 <942c0020-e43d-4d86-b8c0-ccc8f7ed2b2c@kwiboo.se> <abgd9BByMlS6khBT@GRAPHRT>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <abgd9BByMlS6khBT@GRAPHRT>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Marius,

On 3/16/2026 4:12 PM, Marius Dinu wrote:
> On Mon, 2026-03-16 11.04.13 ++0100, Jonas Karlman wrote:
>> Hi Marius,
>>
>> On 3/16/2026 10:26 AM, Marius Dinu wrote:
>>> RK3288 uses rockchip_usb2_phy, but that driver doesn't register iself
>>> as a usbphy driver and "usb start" fails with this error:
>>>
>>>   drivers/usb/host/dwc2.c:1254- dwc2_setup_phy() dwc2_usb usb@ff580000:
>>>   Failed to get USB PHY: -19.
>>>
>>> Until a proper fix is made for rockchip_usb2_phy, this patch allows
>>> usb start to continue even if usbphy is not found.
>>>
>>> Tested on Asus TinkerBoard.
>>
>> I am not seeing this issue on my TinkerBoard, what U-Boot version are
>> you testing and have you made any config changes compared to
>> tinker-rk3288_defconfig?
> 
> I'm using the github master branch pulled today + lots and lots of changes
> in config. I didn't make a diff, but I expect it to be very very far from
> tinker-rk3288_defconfig.
> 
>>
>>   => usb start
>>   starting USB...
>>   USB DWC2
>>   USB DWC2
>>   Bus usb@ff540000: 2 USB Device(s) found
>>   Bus usb@ff580000: 1 USB Device(s) found
>>          scanning usb for storage devices... 0 Storage Device(s) found
>>
>>   => dm tree -e usb
>>    Class     Seq    Probed  Driver                Name
>>   -----------------------------------------------------------
>>    usb           0  [ + ]   dwc2_usb              usb@ff540000
>>    usb_hub       0  [ + ]   usb_hub               `-- usb_hub
>>    usb_hub       1  [ + ]   usb_hub                   `-- usb_hub
>>    usb           1  [ + ]   dwc2_usb              usb@ff580000
>>    usb_hub       2  [ + ]   usb_hub               `-- usb_hub
>>
>> Have something changed recently that broke this?
> 
> Yes! but not exactly recently...
> It broke since commit e17a4bf198510693967644c331ab621fc41ea8b5.
> Here's a log on my system without my proposed fix. This is a log that I
> saved while I was investigating the failed USB, about a year ago, I think.
> But I checked and it still fails with today's git master, I just don't have
> the time to enable all the debug options again. It's still ret -19 error.

I did a new runtime test on a Tinker Board R2.0 using master with
tinker-rk3288_defconfig and I am not able to reproduce any issue. Maybe
your config changes introduce a condition that causes an issue? Please
share your savedefconfig.

> 
>   => usb start
>   starting USB...
>   drivers/core/ofnode.c:540-    ofnode_read_prop() ofnode_read_prop: assigned-clock-rates: <not found>
>   drivers/core/of_access.c:556-   of_read_u32_index() of_read_u32_index: #clock-cells: 0x1 (1)
>   drivers/core/of_access.c:556-   of_read_u32_index() of_read_u32_index: #clock-cells: 0x1 (1)
>   drivers/core/uclass.c:546-uclass_get_device_by_ofnode() Looking for clock-controller@ff760000
>   drivers/core/uclass.c:397-uclass_find_device_by_ofnode() Looking for clock-controller@ff760000
>   drivers/core/uclass.c:406-uclass_find_device_by_ofnode()       - checking oscillator
>   drivers/core/uclass.c:406-uclass_find_device_by_ofnode()       - checking clock-controller@ff760000
>   drivers/core/uclass.c:416-uclass_find_device_by_ofnode()    - result for clock-controller@ff760000: clock-controller@ff760000 (ret=0)
>   drivers/core/uclass.c:549-uclass_get_device_by_ofnode()    - result for clock-controller@ff760000: clock-controller@ff760000 (ret=0)
>   drivers/core/ofnode.c:417-ofnode_read_u32_index() ofnode_read_u32_index: vbus-supply: of_read_u32_index: vbus-supply: (not found)
>   drivers/core/of_access.c:556-   of_read_u32_index() of_read_u32_index: #phy-cells: 0x0 (0)
>   drivers/core/uclass.c:546-uclass_get_device_by_ofnode() Looking for usb-phy@334
>   drivers/core/uclass.c:397-uclass_find_device_by_ofnode() Looking for usb-phy@334
>   drivers/core/uclass.c:416-uclass_find_device_by_ofnode()    - result for usb-phy@334: (none) (ret=-19)
>   drivers/core/uclass.c:549-uclass_get_device_by_ofnode()    - result for usb-phy@334: (none) (ret=-19)
>   drivers/core/uclass.c:546-uclass_get_device_by_ofnode() Looking for usbphy
>   drivers/core/uclass.c:397-uclass_find_device_by_ofnode() Looking for usbphy
>   drivers/core/uclass.c:416-uclass_find_device_by_ofnode()    - result for usbphy: (none) (ret=-19)
>   drivers/core/uclass.c:549-uclass_get_device_by_ofnode()    - result for usbphy: (none) (ret=-19)
>   Bus usb@ff500000: Port not available.
> and it repeats for usb@ff540000 and usb@ff580000.
> 
> There is no usbphy or usb-phy detected/bound in log when u-boot walks the
> devicetree nodes, but the device tree has "usbphy" node
> compatible="rockchip,rk3288-usb-phy" with 3 sub-nodes: usb-phy@320,
> usb-phy@334, usb-phy@348.
> Driver with that compatible string: rockchip_usb2_phy.c.
> CONFIG_ROCKCHIP_USB2_PHY is enabled, but "dm compat" lists only these:
> 
>   rockchip_usb2phy      rockchip,rk3308-usb2phy
>                         rockchip,rk3328-usb2phy
>                         rockchip,rk3399-usb2phy
>                         rockchip,rk3528-usb2phy
>                         rockchip,rk3568-usb2phy
>                         rockchip,rk3576-usb2phy
>                         rockchip,rk3588-usb2phy
> 
> Those compat strings come from phy-rockchip-inno-usb2.c. (I also had that
> enabled while debugging.) There are no compat strings from
> rockchip_usb2_phy.c.
> 
> It's because phy-rockchip-inno-usb2.c has this:
> 
>   U_BOOT_DRIVER(rockchip_usb2phy){
>     .name = rockchip_usb2phy"
> 
> while rockchip_usb2_phy.c does not. So the usb driver finds no compatible
> phy driver loaded and fails. Before the commit, it would load anyway.
> 
> I didn't use any AI in this investigation!
> 
> Here is a log with my patch:
>   => usb start
>   starting USB...
>   drivers/core/ofnode.c:525-    ofnode_read_bool() ofnode_read_bool: disable-over-current: false
>   drivers/core/ofnode.c:525-    ofnode_read_bool() ofnode_read_bool: hnp-srp-disable: false
>   drivers/core/ofnode.c:540-    ofnode_read_prop() ofnode_read_prop: assigned-clock-rates: <not found>
>   drivers/core/of_access.c:556-   of_read_u32_index() of_read_u32_index: #clock-cells: 0x1 (1)
>   drivers/core/of_access.c:556-   of_read_u32_index() of_read_u32_index: #clock-cells: 0x1 (1)
>   drivers/core/uclass.c:546-uclass_get_device_by_ofnode() Looking for clock-controller@ff760000
>   drivers/core/uclass.c:397-uclass_find_device_by_ofnode() Looking for clock-controller@ff760000
>   drivers/core/uclass.c:406-uclass_find_device_by_ofnode()       - checking oscillator
>   drivers/core/uclass.c:406-uclass_find_device_by_ofnode()       - checking clock-controller@ff760000
>   drivers/core/uclass.c:416-uclass_find_device_by_ofnode()    - result for clock-controller@ff760000: clock-controller@ff760000 (ret=0)
>   drivers/core/uclass.c:549-uclass_get_device_by_ofnode()    - result for clock-controller@ff760000: clock-controller@ff760000 (ret=0)
>   drivers/core/of_access.c:556-   of_read_u32_index() of_read_u32_index: #phy-cells: 0x0 (0)
>   drivers/core/uclass.c:546-uclass_get_device_by_ofnode() Looking for usb-phy@348
>   drivers/core/uclass.c:397-uclass_find_device_by_ofnode() Looking for usb-phy@348
>   drivers/core/uclass.c:416-uclass_find_device_by_ofnode()    - result for usb-phy@348: (none) (ret=-19)
>   drivers/core/uclass.c:549-uclass_get_device_by_ofnode()    - result for usb-phy@348: (none) (ret=-19)
>   drivers/core/uclass.c:546-uclass_get_device_by_ofnode() Looking for usbphy
>   drivers/core/uclass.c:397-uclass_find_device_by_ofnode() Looking for usbphy
>   drivers/core/uclass.c:416-uclass_find_device_by_ofnode()    - result for usbphy: (none) (ret=-19)
>   drivers/core/uclass.c:549-uclass_get_device_by_ofnode()    - result for usbphy: (none) (ret=-19)
>   drivers/usb/host/dwc2.c:1254-      dwc2_setup_phy() dwc2_usb usb@ff540000: Failed to get USB PHY: -19.
>   drivers/usb/host/dwc2.c:1332-      dwc2_usb_probe() dwc2_usb usb@ff540000: Failed to setup PHY: -19. Continuing anyway...
>   drivers/usb/host/dwc2.c:1061-          dwc2_reset() dwc2_usb usb@ff540000: Can't get reset: -2
>   drivers/usb/host/dwc2.c:1095-    dwc2_init_common() dwc2_usb usb@ff540000: Core Release: 3.10a
>   drivers/core/ofnode.c:540-    ofnode_read_prop() ofnode_read_prop: dr_mode: host
>   drivers/usb/common/dwc2_core.c:67-  dwc2_flush_tx_fifo() Flush Tx FIFO 16
>   drivers/usb/common/dwc2_core.c:102-  dwc2_flush_rx_fifo() Flush Rx FIFO
>   drivers/core/ofnode.c:417-ofnode_read_u32_index() ofnode_read_u32_index: vbus-supply: of_read_u32_index: vbus-supply: (not found)
>   USB DWC2
>   drivers/core/ofnode.c:417-ofnode_read_u32_index() ofnode_read_u32_index: companion: of_read_u32_index: companion: (not found)
>   drivers/core/ofnode.c:525-    ofnode_read_bool() ofnode_read_bool: disable-over-current: false
>   drivers/core/ofnode.c:525-    ofnode_read_bool() ofnode_read_bool: hnp-srp-disable: false
>   drivers/core/ofnode.c:540-    ofnode_read_prop() ofnode_read_prop: assigned-clock-rates: <not found>
>   drivers/core/of_access.c:556-   of_read_u32_index() of_read_u32_index: #clock-cells: 0x1 (1)
>   drivers/core/of_access.c:556-   of_read_u32_index() of_read_u32_index: #clock-cells: 0x1 (1)
>   drivers/core/uclass.c:546-uclass_get_device_by_ofnode() Looking for clock-controller@ff760000
>   drivers/core/uclass.c:397-uclass_find_device_by_ofnode() Looking for clock-controller@ff760000
>   drivers/core/uclass.c:406-uclass_find_device_by_ofnode()       - checking oscillator
>   drivers/core/uclass.c:406-uclass_find_device_by_ofnode()       - checking clock-controller@ff760000
>   drivers/core/uclass.c:416-uclass_find_device_by_ofnode()    - result for clock-controller@ff760000: clock-controller@ff760000 (ret=0)
>   drivers/core/uclass.c:549-uclass_get_device_by_ofnode()    - result for clock-controller@ff760000: clock-controller@ff760000 (ret=0)
>   drivers/core/of_access.c:556-   of_read_u32_index() of_read_u32_index: #phy-cells: 0x0 (0)
>   drivers/core/uclass.c:546-uclass_get_device_by_ofnode() Looking for usb-phy@320
>   drivers/core/uclass.c:397-uclass_find_device_by_ofnode() Looking for usb-phy@320
>   drivers/core/uclass.c:416-uclass_find_device_by_ofnode()    - result for usb-phy@320: (none) (ret=-19)
>   drivers/core/uclass.c:549-uclass_get_device_by_ofnode()    - result for usb-phy@320: (none) (ret=-19)
>   drivers/core/uclass.c:546-uclass_get_device_by_ofnode() Looking for usbphy
>   drivers/core/uclass.c:397-uclass_find_device_by_ofnode() Looking for usbphy
>   drivers/core/uclass.c:416-uclass_find_device_by_ofnode()    - result for usbphy: (none) (ret=-19)
>   drivers/core/uclass.c:549-uclass_get_device_by_ofnode()    - result for usbphy: (none) (ret=-19)
>   drivers/usb/host/dwc2.c:1254-      dwc2_setup_phy() dwc2_usb usb@ff580000: Failed to get USB PHY: -19.
>   drivers/usb/host/dwc2.c:1332-      dwc2_usb_probe() dwc2_usb usb@ff580000: Failed to setup PHY: -19. Continuing anyway...
>   drivers/usb/host/dwc2.c:1061-          dwc2_reset() dwc2_usb usb@ff580000: Can't get reset: -2
>   drivers/usb/host/dwc2.c:1095-    dwc2_init_common() dwc2_usb usb@ff580000: Core Release: 3.10a
>   drivers/core/ofnode.c:540-    ofnode_read_prop() ofnode_read_prop: dr_mode: otg
>   drivers/usb/common/dwc2_core.c:67-  dwc2_flush_tx_fifo() Flush Tx FIFO 16
>   drivers/usb/common/dwc2_core.c:102-  dwc2_flush_rx_fifo() Flush Rx FIFO
>   drivers/usb/host/dwc2.c:230-dwc_otg_core_host_init() dwc2_usb usb@ff580000: dwc_otg_core_host_init: Timeout!
>   drivers/usb/host/dwc2.c:230-dwc_otg_core_host_init() dwc2_usb usb@ff580000: dwc_otg_core_host_init: Timeout!
>   drivers/usb/host/dwc2.c:230-dwc_otg_core_host_init() dwc2_usb usb@ff580000: dwc_otg_core_host_init: Timeout!
>   drivers/usb/host/dwc2.c:230-dwc_otg_core_host_init() dwc2_usb usb@ff580000: dwc_otg_core_host_init: Timeout!
>   drivers/usb/host/dwc2.c:230-dwc_otg_core_host_init() dwc2_usb usb@ff580000: dwc_otg_core_host_init: Timeout!
>   drivers/usb/host/dwc2.c:230-dwc_otg_core_host_init() dwc2_usb usb@ff580000: dwc_otg_core_host_init: Timeout!
>   drivers/usb/host/dwc2.c:230-dwc_otg_core_host_init() dwc2_usb usb@ff580000: dwc_otg_core_host_init: Timeout!
>   drivers/usb/host/dwc2.c:230-dwc_otg_core_host_init() dwc2_usb usb@ff580000: dwc_otg_core_host_init: Timeout!
> CONFIG_USB_GADGET is not enabled in my config.
>   drivers/core/ofnode.c:417-ofnode_read_u32_index() ofnode_read_u32_index: vbus-supply: of_read_u32_index: vbus-supply: (not found)
>   USB DWC2
>   drivers/core/ofnode.c:417-ofnode_read_u32_index() ofnode_read_u32_index: companion: of_read_u32_index: companion: (not found)
>   drivers/core/ofnode.c:417-ofnode_read_u32_index() ofnode_read_u32_index: usb,device-class: of_read_u32_index: usb,device-class: (not found)
>   drivers/core/ofnode.c:417-ofnode_read_u32_index() ofnode_read_u32_index: usb,interface-class: of_read_u32_index: usb,interface-class: (not found)
>   drivers/core/device.c:185-  device_bind_common() Bound device usb_hub to usb@ff540000
>   drivers/core/ofnode.c:540-    ofnode_read_prop() ofnode_read_prop: assigned-clock-rates: <not found>
>   drivers/core/device.c:185-  device_bind_common() Bound device usb_hub to usb_hub
>   drivers/core/device.c:185-  device_bind_common() Bound device usb_mass_storage to usb_hub
>   drivers/core/device.c:185-  device_bind_common() Bound device usb_mass_storage.lun0 to usb_mass_storage
> long delay here
>   drivers/core/device.c:185-  device_bind_common() Bound device usb_mass_storage.lun0.bootdev to usb_mass_storage
> even longer delay here
>   drivers/core/ofnode.c:417-ofnode_read_u32_index() ofnode_read_u32_index: usb,device-class: of_read_u32_index: usb,device-class: (not found)
>   drivers/core/ofnode.c:417-ofnode_read_u32_index() ofnode_read_u32_index: usb,interface-class: of_read_u32_index: usb,interface-class: (not found)
>   drivers/core/device.c:185-  device_bind_common() Bound device usb_hub to usb@ff580000
>   drivers/core/ofnode.c:540-    ofnode_read_prop() ofnode_read_prop: assigned-clock-rates: <not found>
>   Bus usb@ff540000: 3 USB Device(s) found
>   Bus usb@ff580000: 1 USB Device(s) found
>          scanning usb for storage devices... 1 Storage Device(s) found
> 
> Takes 30s to complete, but it works!
> IIRC, that how much it took before the commit that broke it.

I have re-run some tests with different Kconfig options related to
GADGET and DWC2 and are not able to reproduce your issue.

As mentioned above, please share your config changes compared to tinker
defconfig, maybe you have some Kconfig option enabled that make DWC2
work differently?


  U-Boot SPL 2026.04-rc4-00007-g010855c5005e (Mar 16 2026 - 21:33:53 +0000)
  Trying to boot from RAM
  ## Checking hash(es) for config conf-1 ... OK
  ## Checking hash(es) for Image firmware-1 ... crc32+ OK
  ## Checking hash(es) for Image fdt-1 ... crc32+ OK
  spl_perform_arch_fixups: could not map BootROM boot device to ofpath
  
  
  U-Boot 2026.04-rc4-00007-g010855c5005e (Mar 16 2026 - 21:33:53 +0000)
  
  SoC: Rockchip rk3288
  Reset cause: POR
  Model: Rockchip RK3288 Asus Tinker Board
  DRAM:  2 GiB
  PMIC:  RK808
  Core:  221 devices, 27 uclasses, devicetree: separate
  MMC:   mmc@ff0c0000: 1, mmc@ff0d0000: 2
  Loading Environment from MMC... Card did not respond to voltage select! : -110
  *** Warning - No block device, using default environment
  
  In:    serial,usbkbd
  Out:   serial,vidconsole
  Err:   serial,vidconsole
  Net:   eth0: ethernet@ff290000
  
  Hit any key to stop autoboot: 0
  => usb start
  starting USB...
  USB DWC2
  USB DWC2
  Bus usb@ff540000: 2 USB Device(s) found
  Bus usb@ff580000: 1 USB Device(s) found
         scanning usb for storage devices... 0 Storage Device(s) found
  => usb tree
  USB device tree:
    1  Hub (480 Mb/s, 0mA)
    |   U-Boot Root Hub
    |
    +-2  Hub (480 Mb/s, 100mA)
          USB2.0 Hub
  
    1  Hub (480 Mb/s, 0mA)
        U-Boot Root Hub
  
  => dm tree -e usb
   Class     Seq    Probed  Driver                Name
  -----------------------------------------------------------
   usb           0  [ + ]   dwc2_usb              usb@ff540000
   usb_hub       0  [ + ]   usb_hub               `-- usb_hub
   usb_hub       1  [ + ]   usb_hub                   `-- usb_hub
   usb           1  [ + ]   dwc2_usb              usb@ff580000
   usb_hub       2  [ + ]   usb_hub               `-- usb_hub
   pinconfig   130  [   ]   pinconfig             usb
   pinconfig   131  [   ]   pinconfig             |-- host-vbus-drv
   pinconfig   132  [   ]   pinconfig             `-- pwr-3g
  =>

Regards,
Jonas

> 
> Marius
> 
> PS: There is a duplicate of this email sent from the wrong address. Sorry.
> 
>>
>> Anyway if something needs fixing it is probably rockchip_usb2_phy.
>>
>> Regards,
>> Jonas
>>
>>>
>>> Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>
>>> ---
>>>  drivers/usb/host/dwc2.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
>>> index 16f21fa9083..74d71f23d88 100644
>>> --- a/drivers/usb/host/dwc2.c
>>> +++ b/drivers/usb/host/dwc2.c
>>> @@ -1329,7 +1329,7 @@ static int dwc2_usb_probe(struct udevice *dev)
>>>  
>>>  	ret = dwc2_setup_phy(dev);
>>>  	if (ret)
>>> -		return ret;
>>> +		dev_dbg(dev, "Failed to setup PHY: %d. Continuing anyway...\n", ret);
>>>  
>>>  	return dwc2_init_common(dev, priv);
>>>  }
>>> @@ -1345,8 +1345,7 @@ static int dwc2_usb_remove(struct udevice *dev)
>>>  
>>>  	ret = dwc2_shutdown_phy(dev);
>>>  	if (ret) {
>>> -		dev_dbg(dev, "Failed to shutdown USB PHY: %d.\n", ret);
>>> -		return ret;
>>> +		dev_dbg(dev, "Failed to shutdown USB PHY: %d. Continuing anyway...\n", ret);
>>>  	}
>>>  
>>>  	dwc2_uninit_common(priv->regs);
>>
> 

