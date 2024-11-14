Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB58D6A221
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 20:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89E7E89293;
	Thu, 14 Nov 2024 21:26:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hPAcI7a9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13726892CD; Thu, 14 Nov 2024 21:26:12 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CBCD8926A
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 21:26:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=23b5=SK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1731615960;
 bh=MtQbXIkzVebpiSxMv6GKkuwNrYF9ctXMgOFGDvCUl0U=;
 b=hPAcI7a93ukMe0+H7Pk6FV3d8EP/AcqmnmZpCR5fX3IvoctHxBpaNWIyPjD9k8wUgO+Y7KNMQ
 3MIw816TdJKv4Zr07MH7kbFTgY3eBKnzCef0rX36A9Xx7ZJA1fUoB4Y7T+CbPKQXvCPAw1cLxr8
 w+phmUjmZInYY/G5AVYWflXWIvxQQJ1AM033NjKe4MEqnIkPATr94XNjSWfoErPmptLKIwfLFev
 F8i5lobaHJnImFOX7Dghsh5pS17tlq4IxbotU94mjgnr84QXncaHPKLtWTweMVz0/vfebpY1376
 9Siog248oSrAO+HgVGHjaBr3z05zMJ/wQwJXnNOr+Hog==
Message-ID: <80ee6e68-cfb5-4144-aa99-88e52420cba9@kwiboo.se>
Date: Thu, 14 Nov 2024 21:25:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: run bootdev_hunt() to find ESP
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20241113195519.49150-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241113195519.49150-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 67365cd499fd201ad0e4b448
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

Hi Heinrich,

On 2024-11-13 20:55, Heinrich Schuchardt wrote:
> Some hard devices need specific routines to scan for block devices,
> e.g. NVMe (nvme scan), SCSI (scsi start).
> 
> Invoke bootdev_hunt() to find all block devices.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_setup.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index aa59bc7779d..8e0ff16f3eb 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -7,6 +7,7 @@
>  
>  #define LOG_CATEGORY LOGC_EFI
>  
> +#include <bootdev.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
>  #include <log.h>
> @@ -228,6 +229,13 @@ efi_status_t efi_init_obj_list(void)
>  	 * Probe block devices to find the ESP.
>  	 * efi_disks_register() must be called before efi_init_variables().
>  	 */
> +	if (CONFIG_IS_ENABLED(BOOTSTD)) {
> +		int r;
> +
> +		r = bootdev_hunt(NULL, 0);
> +		if (r)
> +			log_debug("No boot device available\n");
> +	}
>  	ret = efi_disks_register();
>  	if (ret != EFI_SUCCESS)
>  		goto out;

This is causing significant slower boot when trying to boot using
extlinux (or script) from mmc device on Rockchip, this will cause all
slow devices to be initialized before a quick mmc boot, e.g. pci init,
usb start and dhcp due to efi_mgr being the global bootmeth.

With this patch applied:

  U-Boot 2025.01-rc2 (Nov 14 2024 - 20:09:17 +0000)
  
  Model: Radxa ROCK 3B
  SoC:   RK3568J
  DRAM:  8 GiB (effective 7.7 GiB)
  PMIC:  RK809 (on=0x40, off=0x00)
  Core:  341 devices, 33 uclasses, devicetree: separate
  MMC:   mmc@fe000000: 2, mmc@fe2b0000: 1, mmc@fe310000: 0
  Loading Environment from nowhere... OK
  In:    serial@fe660000
  Out:   serial@fe660000
  Err:   serial@fe660000
  Net:   eth1: ethernet@fe010000, eth0: ethernet@fe2a0000
  Hit any key to stop autoboot:  0
  Scanning for bootflows in all bootdevs
  Seq  Method       State   Uclass    Part  Name                      Filename
  ---  -----------  ------  --------  ----  ------------------------  ----------------
  Scanning global bootmeth 'efi_mgr':
  pcie_dw_rockchip pcie@fe260000: PCIe-0 Link Fail
  pcie_dw_rockchip pcie@fe280000: PCIe-1 Link Fail
  ethernet@fe2a0000 Waiting for PHY auto negotiation to complete......... TIMEOUT !
  phy_startup() failed: -110
  FAILED: -110
  ethernet@fe010000 Waiting for PHY auto negotiation to complete......... TIMEOUT !
  phy_startup() failed: -110
  FAILED: -110
  BOOTP broadcast 1
  BOOTP broadcast 2
  BOOTP broadcast 3
  BOOTP broadcast 4
  BOOTP broadcast 5
  BOOTP broadcast 6
  BOOTP broadcast 7
  BOOTP broadcast 8
  BOOTP broadcast 9
  BOOTP broadcast 10
  BOOTP broadcast 11
  BOOTP broadcast 12
  BOOTP broadcast 13
  BOOTP broadcast 14
  BOOTP broadcast 15
  BOOTP broadcast 16
  BOOTP broadcast 17
  
  Retry time exceeded; starting again
  pcie_dw_rockchip pcie@fe260000: PCIe-0 Link Fail
  pcie_dw_rockchip pcie@fe280000: PCIe-1 Link Fail
  pcie_dw_rockchip pcie@fe260000: PCIe-0 Link Fail
  pcie_dw_rockchip pcie@fe280000: PCIe-1 Link Fail
  scanning bus for devices...
  Bus usb@fd000000: Register 2000140 NbrPorts 2
  Starting the controller
  USB XHCI 1.10
  Bus usb@fd800000: USB EHCI 1.00
  scanning bus usb@fd000000 for devices... 1 USB Device(s) found
  scanning bus usb@fd800000 for devices... 2 USB Device(s) found
  No boot device available
  Card did not respond to voltage select! : -110
  Cannot persist EFI variables without system partition
    0  efi_mgr      ready   (none)       0  <NULL>
  ** Booting bootflow '<NULL>' with efi_mgr
  Loading Boot0000 'mmc 1' failed
  Loading Boot0001 'mmc 0' failed
  EFI boot manager: Cannot load any image
  Boot failed (err=-14)
  Scanning bootdev 'mmc@fe2b0000.bootdev':
    1  extlinux     ready   mmc          1  mmc@fe2b0000.bootdev.part /extlinux/extlinux.conf
  ** Booting bootflow 'mmc@fe2b0000.bootdev.part_1' with extlinux
  1:      linux
  Retrieving file: /Image.gz
  Retrieving file: /initramfs.cpio.gz
     Uncompressing Kernel Image to 0
  ## Flattened Device Tree blob at eded3690
     Booting using the fdt blob at 0xeded3690
  Working FDT set to eded3690
     Loading Ramdisk to ecb0d000, end ecea1d3c ... OK
     Loading Device Tree to 00000000ecaf5000, end 00000000ecb0c6d7 ... OK
  Working FDT set to ecaf5000
  
  Starting kernel ...

I guess we can always disable efi_mgr on Rockchip, similar to sunxi, to
restore pre stdboot behavior.

Regards,
Jonas

