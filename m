Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5382AD6A248
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 22:16:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E2678932B;
	Thu, 14 Nov 2024 23:16:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="nBagG5Vl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0FFC8969A; Thu, 14 Nov 2024 23:16:24 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 810B389328
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 23:16:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=23b5=SK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1731622573;
 bh=yrEPw33ZpJQMOTdYlP+6U0Qof5kxH7KyqMl3ehGNISs=;
 b=nBagG5VletkXkP9WV+8Kt5CPU/+UBH696+vQJUPKrpYkP2pHG3FxtPPUcGcJjUfizAJ7mr7E0
 PjULpjzSiP9+UiFlldPl89/f5iMP6r9SdgvsUl+2JiqV9Oo2Nd4S/AHOigUFgER4A3MOKNvxx4O
 HL+f9zzivDS1xCxnZ+THQMbDdqgDtYmmTfMC7J+fTTZ5m5j+V113rkH7CA9xHO8tuvgMx9ZN4nG
 ztBfMTwFRLC2GTGHAM/I1J4KB+gtNEIeTdm9lkCUGT5y0bJeoM27sIOUQmnueH3gECUvoadydPc
 fBzJkpcu//G3JesL+QsYdU2EszHTkGhLNuaTGcHmd3vQ==
Message-ID: <3c766212-2898-4ab0-be04-ecb9b213b98d@kwiboo.se>
Date: Thu, 14 Nov 2024 23:16:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: run bootdev_hunt() to find ESP
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241113195519.49150-1-heinrich.schuchardt@canonical.com>
 <80ee6e68-cfb5-4144-aa99-88e52420cba9@kwiboo.se>
 <CAM=mAOk4ZeF5wuNNmOZYwFL8Bhb64otKKnKkiGZyZZkXQywdfA@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAM=mAOk4ZeF5wuNNmOZYwFL8Bhb64otKKnKkiGZyZZkXQywdfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 673676a899fd201ad0e4d771
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

On 2024-11-14 22:08, Heinrich Schuchardt wrote:
> Jonas Karlman <jonas@kwiboo.se> schrieb am Do., 14. Nov. 2024, 21:26:
> 
>> Hi Heinrich,
>>
>> On 2024-11-13 20:55, Heinrich Schuchardt wrote:
>>> Some hard devices need specific routines to scan for block devices,
>>> e.g. NVMe (nvme scan), SCSI (scsi start).
>>>
>>> Invoke bootdev_hunt() to find all block devices.
>>>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> ---
>>>  lib/efi_loader/efi_setup.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
>>> index aa59bc7779d..8e0ff16f3eb 100644
>>> --- a/lib/efi_loader/efi_setup.c
>>> +++ b/lib/efi_loader/efi_setup.c
>>> @@ -7,6 +7,7 @@
>>>
>>>  #define LOG_CATEGORY LOGC_EFI
>>>
>>> +#include <bootdev.h>
>>>  #include <efi_loader.h>
>>>  #include <efi_variable.h>
>>>  #include <log.h>
>>> @@ -228,6 +229,13 @@ efi_status_t efi_init_obj_list(void)
>>>        * Probe block devices to find the ESP.
>>>        * efi_disks_register() must be called before efi_init_variables().
>>>        */
>>> +     if (CONFIG_IS_ENABLED(BOOTSTD)) {
>>> +             int r;
>>> +
>>> +             r = bootdev_hunt(NULL, 0);
>>> +             if (r)
>>> +                     log_debug("No boot device available\n");
>>> +     }
>>>       ret = efi_disks_register();
>>>       if (ret != EFI_SUCCESS)
>>>               goto out;
>>
>> This is causing significant slower boot when trying to boot using
>> extlinux (or script) from mmc device on Rockchip, this will cause all
>> slow devices to be initialized before a quick mmc boot, e.g. pci init,
>> usb start and dhcp due to efi_mgr being the global bootmeth.
>>
> 
> Specifically DHCP is very slow and not needed here.

It is not just DHCP, each PCIe Link Fail add minimum one second timeout,
and USB init also adds 5-10 seconds. So instead of 2-3 seconds until
"Starting kernel ..." it takes around 30+ seconds with this.

Without efi_mgr boot is quick:

  Net:   eth1: ethernet@fe010000, eth0: ethernet@fe2a0000
  Hit any key to stop autoboot:  0
  Scanning for bootflows in all bootdevs
  Seq  Method       State   Uclass    Part  Name                      Filename
  ---  -----------  ------  --------  ----  ------------------------  ----------------
  Scanning bootdev 'mmc@fe2b0000.bootdev':
    0  extlinux     ready   mmc          1  mmc@fe2b0000.bootdev.part /extlinux/extlinux.conf
  ** Booting bootflow 'mmc@fe2b0000.bootdev.part_1' with extlinux
  1:      linux
  Retrieving file: /Image.gz
  Retrieving file: /initramfs.cpio.gz
     Uncompressing Kernel Image to 0
  ## Flattened Device Tree blob at eded7d90
     Booting using the fdt blob at 0xeded7d90
  Working FDT set to eded7d90
     Loading Ramdisk to ecb3b000, end ececfd3c ... OK
     Loading Device Tree to 00000000ecb23000, end 00000000ecb3afdf ... OK
  Working FDT set to ecb23000
  
  Starting kernel ...

> 
> Maybe Simon has an idea how to filter it out. We should filter on
> UCLASS_BLK related here.
> 
> Furthermore I don't know if global bootmeths are always have to run first
> or if you could customize this.

The commit c627cfc14c08 ("bootstd: Allow scanning for global bootmeths
separately") changed to always prefer global bootmeths even if the
ordering is different, see default order below.

  => bootmeth list
  Order  Seq  Name                Description
  -----  ---  ------------------  ------------------
      0    0  extlinux            Extlinux boot from a block device
      1    1  script              Script boot from a block device
   glob    2  efi_mgr             EFI bootmgr flow
      3    3  efi                 EFI boot from an .efi file
      4    4  pxe                 PXE boot from a network device
   glob    5  vbe_simple          VBE simple
  -----  ---  ------------------  ------------------
  (6 bootmeths)

The only way to not have efi_mgr as first option is with a custom
bootmeths env var where it is excluded or fully disable EFI_BOOTMGR.

This patch bring other existing issues to surface, e.g.:
- BOOTP broadcast is send even when 2x Ethernet PHY auto negotiation
  timeout (no cable connected).
- PCI controller is probed multiple times, and with a failed probe
  (Link Fail) it gets re-probed multiple times adding multiple timeouts
  for each pci controller, maybe not failing probe at Link Fail could
  mitigate part of the repeated pci controller probe.

On this device, ROCK 3B, there is 2x Ethernet and 2x PCIe controllers
that help add to the added boot delay with this patch.

Regards,
Jonas

> 
> Best regards
> 
> Heinrich
> 
> 
> 
>> With this patch applied:
>>
>>   U-Boot 2025.01-rc2 (Nov 14 2024 - 20:09:17 +0000)
>>
>>   Model: Radxa ROCK 3B
>>   SoC:   RK3568J
>>   DRAM:  8 GiB (effective 7.7 GiB)
>>   PMIC:  RK809 (on=0x40, off=0x00)
>>   Core:  341 devices, 33 uclasses, devicetree: separate
>>   MMC:   mmc@fe000000: 2, mmc@fe2b0000: 1, mmc@fe310000: 0
>>   Loading Environment from nowhere... OK
>>   In:    serial@fe660000
>>   Out:   serial@fe660000
>>   Err:   serial@fe660000
>>   Net:   eth1: ethernet@fe010000, eth0: ethernet@fe2a0000
>>   Hit any key to stop autoboot:  0
>>   Scanning for bootflows in all bootdevs
>>   Seq  Method       State   Uclass    Part  Name
>> Filename
>>   ---  -----------  ------  --------  ----  ------------------------
>> ----------------
>>   Scanning global bootmeth 'efi_mgr':
>>   pcie_dw_rockchip pcie@fe260000: PCIe-0 Link Fail
>>   pcie_dw_rockchip pcie@fe280000: PCIe-1 Link Fail
>>   ethernet@fe2a0000 Waiting for PHY auto negotiation to complete.........
>> TIMEOUT !
>>   phy_startup() failed: -110
>>   FAILED: -110
>>   ethernet@fe010000 Waiting for PHY auto negotiation to complete.........
>> TIMEOUT !
>>   phy_startup() failed: -110
>>   FAILED: -110
>>   BOOTP broadcast 1
>>   BOOTP broadcast 2
>>   BOOTP broadcast 3
>>   BOOTP broadcast 4
>>   BOOTP broadcast 5
>>   BOOTP broadcast 6
>>   BOOTP broadcast 7
>>   BOOTP broadcast 8
>>   BOOTP broadcast 9
>>   BOOTP broadcast 10
>>   BOOTP broadcast 11
>>   BOOTP broadcast 12
>>   BOOTP broadcast 13
>>   BOOTP broadcast 14
>>   BOOTP broadcast 15
>>   BOOTP broadcast 16
>>   BOOTP broadcast 17
>>
>>   Retry time exceeded; starting again
>>   pcie_dw_rockchip pcie@fe260000: PCIe-0 Link Fail
>>   pcie_dw_rockchip pcie@fe280000: PCIe-1 Link Fail
>>   pcie_dw_rockchip pcie@fe260000: PCIe-0 Link Fail
>>   pcie_dw_rockchip pcie@fe280000: PCIe-1 Link Fail
>>   scanning bus for devices...
>>   Bus usb@fd000000: Register 2000140 NbrPorts 2
>>   Starting the controller
>>   USB XHCI 1.10
>>   Bus usb@fd800000: USB EHCI 1.00
>>   scanning bus usb@fd000000 for devices... 1 USB Device(s) found
>>   scanning bus usb@fd800000 for devices... 2 USB Device(s) found
>>   No boot device available
>>   Card did not respond to voltage select! : -110
>>   Cannot persist EFI variables without system partition
>>     0  efi_mgr      ready   (none)       0  <NULL>
>>   ** Booting bootflow '<NULL>' with efi_mgr
>>   Loading Boot0000 'mmc 1' failed
>>   Loading Boot0001 'mmc 0' failed
>>   EFI boot manager: Cannot load any image
>>   Boot failed (err=-14)
>>   Scanning bootdev 'mmc@fe2b0000.bootdev':
>>     1  extlinux     ready   mmc          1  mmc@fe2b0000.bootdev.part
>> /extlinux/extlinux.conf
>>   ** Booting bootflow 'mmc@fe2b0000.bootdev.part_1' with extlinux
>>   1:      linux
>>   Retrieving file: /Image.gz
>>   Retrieving file: /initramfs.cpio.gz
>>      Uncompressing Kernel Image to 0
>>   ## Flattened Device Tree blob at eded3690
>>      Booting using the fdt blob at 0xeded3690
>>   Working FDT set to eded3690
>>      Loading Ramdisk to ecb0d000, end ecea1d3c ... OK
>>      Loading Device Tree to 00000000ecaf5000, end 00000000ecb0c6d7 ... OK
>>   Working FDT set to ecaf5000
>>
>>   Starting kernel ...
>>
>> I guess we can always disable efi_mgr on Rockchip, similar to sunxi, to
>> restore pre stdboot behavior.
>>
>> Regards,
>> Jonas
>>
>>
> 

