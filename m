Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE273C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 04:33:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D2F980517;
	Mon, 20 Jul 2026 06:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=iro.umontreal.ca
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FB1A84AA5; Sun, 19 Jul 2026 23:24:13 +0200 (CEST)
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7C0384AA5
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 23:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=iro.umontreal.ca
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=gcbu-u-boot-users@m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
 (envelope-from <gcbu-u-boot-users@m.gmane-mx.org>)
 id 1wlYza-0003N8-7B
 for u-boot@lists.denx.de; Sun, 19 Jul 2026 23:24:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: u-boot@lists.denx.de
From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: [PATCH 0/9] video: rockchip: VOP2 and HDMI output for RK3568
Date: Sun, 19 Jul 2026 17:24:01 -0400
Message-ID: <jwvv7aasn6w.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
References: <cover.1784424101.git.daniel@makrotopia.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:vnfrUT0dyZtRHO4e4ES3SizxJ1o=
In-Reply-To: <cover.1784424101.git.daniel@makrotopia.org> (message from Daniel
 Golle <daniel@makrotopia.org> on Sun, 19 Jul 2026 02:58:43 +0100)
X-Mailman-Approved-At: Mon, 20 Jul 2026 06:33:25 +0200
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

Daniel Golle [2026-07-19 02:58:43] wrote:
> U-Boot has no video output support for the RK3568/RK3566 family: the
> VOP2 display controller found in these SoCs (and newer Rockchip parts)
> is unsupported, so boards cannot show a boot menu, the UEFI console or
> any other firmware user interface on a locally attached display, while
> the vendor firmware and the Linux kernel have long been able to drive
> it.

Indeed, and this is a PITA for some boards.  Thank you for working
on it.
I just tried your patch set on an Odroid-M1 by applying the patches in
sequence, and then adding the following to it:

    % git diff origin/master configs/odroid-m1-rk3568_defconfig  
    diff --git a/configs/odroid-m1-rk3568_defconfig b/configs/odroid-m1-rk3568_defconfig
    index b00985b0405..00f47245529 100644
    --- a/configs/odroid-m1-rk3568_defconfig
    +++ b/configs/odroid-m1-rk3568_defconfig
    @@ -70,6 +70,7 @@ CONFIG_DWC_ETH_QOS_ROCKCHIP=y
     CONFIG_PHY_REALTEK=y
     CONFIG_NVME_PCI=y
     CONFIG_PCIE_DW_ROCKCHIP=y
    +#CONFIG_PHY_ROCKCHIP_INNO_HDMI=y
     CONFIG_PHY_ROCKCHIP_INNO_USB2=y
     CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
     CONFIG_SPL_PINCTRL=y
    @@ -92,5 +93,13 @@ CONFIG_USB_OHCI_HCD=y
     CONFIG_USB_OHCI_GENERIC=y
     CONFIG_USB_DWC3=y
     CONFIG_USB_DWC3_GENERIC=y
    +CONFIG_USB_KEYBOARD=y
     CONFIG_FS_CRAMFS=y
    +CONFIG_VIDEO=y
    +CONFIG_DISPLAY=y
    +CONFIG_VIDEO_ROCKCHIP=y
    +CONFIG_DISPLAY_ROCKCHIP_HDMI=y
    +#CONFIG_VIDEO_DT_SIMPLEFB=y
    +#CONFIG_VIDEO_BRIDGE=y
    +#CONFIG_VIDEO_REMOVE=y
     CONFIG_ERRNO_STR=y
    % 

But I still can't see anything on my display (and hitting any key on
the USB keyboard did not elicit any response, the timer kept going).
The serial-port output is appended (tho I cut out the DDR
initialization part).

Any idea what might be the problem?


=== Stefan


U-Boot SPL 2026.07-00012-gec560345eabb (Jul 19 2026 - 20:09:19 +0000)
Trying to boot from MMC2
## Checking hash(es) for config config-1 ... OK
## Checking hash(es) for Image atf-1 ... sha256+ OK
## Checking hash(es) for Image u-boot ... sha256+ OK
## Checking hash(es) for Image fdt-1 ... sha256+ OK
## Checking hash(es) for Image atf-2 ... sha256+ OK
## Checking hash(es) for Image atf-3 ... sha256+ OK
## Checking hash(es) for Image atf-4 ... sha256+ OK
## Checking hash(es) for Image atf-5 ... sha256+ OK
## Checking hash(es) for Image atf-6 ... sha256+ OK
INFO:    Preloader serial: 2
NOTICE:  BL31: v2.3():v2.3-645-g8cea6ab0b:cl, fwver: v1.44
NOTICE:  BL31: Built : 16:36:43, Sep 19 2023
INFO:    GICv3 without legacy support detected.
INFO:    ARM GICv3 driver initialized in EL3
INFO:    pmu v1 is valid 220114
INFO:    l3 cache partition cfg-0
INFO:    dfs DDR fsp_param[0].freq_mhz= 1560MHz
INFO:    dfs DDR fsp_param[1].freq_mhz= 324MHz
INFO:    dfs DDR fsp_param[2].freq_mhz= 528MHz
INFO:    dfs DDR fsp_param[3].freq_mhz= 780MHz
INFO:    Using opteed sec cpu_context!
INFO:    boot cpu mask: 0
INFO:    BL31: Initializing runtime services
WARNING: No OPTEE provided by BL2 boot loader, Booting device without OPTEE initialization. SMC`s destined for OPTEE will return SMC_UNK
ERROR:   Error initializing runtime service opteed_fast
INFO:    BL31: Preparing for EL3 exit to normal world
INFO:    Entry point address = 0x800000
INFO:    SPSR = 0x3c9
 
 
U-Boot 2026.07-00012-gec560345eabb (Jul 19 2026 - 20:09:19 +0000)
 
Model: Hardkernel ODROID-M1
SoC:   RK3568B2
DRAM:  4 GiB
PMIC:  RK809 (on=0x40, off=0x00)
Core:  629 devices, 35 uclasses, devicetree: separate
MMC:   mmc@fe2b0000: 1, mmc@fe310000: 0
Loading Environment from nowhere... OK
In:    serial
Out:   serial
Err:   serial
Model: Hardkernel ODROID-M1
SoC:   RK3568B2
Net:   eth0: ethernet@fe2a0000
 
Hit any key to stop autoboot: 0

