Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5ECE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 10:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6164D8027E;
	Wed, 18 Dec 2024 11:15:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kw05g/Pn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F6F880288; Wed, 18 Dec 2024 11:15:01 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1774E80269
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 11:14:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BIAEkMv4107307
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 04:14:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734516886;
 bh=AxrQOZ1S7OLQbMjpCz1H7OuMiJc91USYDhyEVA9naRk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=kw05g/PnOwj0lEMqrnjAbJXbL1P1sDPtnoCevrDUJTbv4mLo1KQrS05m/bxyxLhN7
 PhvWyLPfyFkZHxeb1yF21bPn1wr9VwnCP1b7lsBTF5iGBSGL8Y6YIOkiY8wFL1vc/y
 AIti/jrM1YSdbbbMo5vz90G2LMu5ad+2imM/4nh4=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BIAEk7m027292
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 18 Dec 2024 04:14:46 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 04:14:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 04:14:45 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BIAEijF109344;
 Wed, 18 Dec 2024 04:14:45 -0600
Date: Wed, 18 Dec 2024 15:44:43 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, 
 <trini@konsulko.com>, <lukma@denx.de>, <n-francis@ti.com>,
 <afd@ti.com>, <glaroque@baylibre.com>, <sjoerd@collabora.com>,
 <martyn.welch@collabora.com>, <rasmus.villemoes@prevas.dk>,
 <caleb.connolly@linaro.org>, <j-humphreys@ti.com>, <rogerq@kernel.org>,
 <nm@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH 2/4] board: ti: am62px: env: include environment for DFU
 Boot
Message-ID: <g7pupq6leeait24a4uqf3toncr5knxl2ffjvxtqesp4uymacdq@c3vsv5ee5mdt>
References: <20241217131658.2920799-1-s-vadapalli@ti.com>
 <20241217131658.2920799-3-s-vadapalli@ti.com>
 <87y10dwbxr.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y10dwbxr.fsf@baylibre.com>
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

On Wed, Dec 18, 2024 at 10:57:36AM +0100, Mattijs Korpershoek wrote:

Hello Mattijs,

> Hi Siddharth,
> 
> Thank you for the patch.
> 
> On mar., déc. 17, 2024 at 18:46, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
> 
> > Include the TI K3 DFU environment to support DFU Boot and DFU Flash.
> > Also add "usb" to the list of "boot_targets".
> >
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> >  board/ti/am62px/am62px.env | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/board/ti/am62px/am62px.env b/board/ti/am62px/am62px.env
> > index 7ef54079aa8..e0838196e3a 100644
> > --- a/board/ti/am62px/am62px.env
> > +++ b/board/ti/am62px/am62px.env
> > @@ -1,5 +1,6 @@
> >  #include <env/ti/ti_common.env>
> >  #include <env/ti/mmc.env>
> > +#include <env/ti/k3_dfu.env>
> >
> >  name_kern=Image
> >  console=ttyS2,115200n8
> > @@ -7,7 +8,7 @@ args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
> >  	${mtdparts}
> >  run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
> >
> > -boot_targets=mmc1 mmc0 pxe dhcp
> > +boot_targets=mmc1 mmc0 usb pxe dhcp
> >  boot=mmc
> >  mmcdev=1
> >  bootpart=1:2
> > @@ -17,4 +18,4 @@ rd_spec=-
> >  #if CONFIG_BOOTMETH_ANDROID
> >  #include <env/ti/android.env>
> >  adtb_idx=3
> > -#endif
> > \ No newline at end of file
> > +#endif
> 
> This change seems un-related, is it needed?

My editor automatically adds a newline, thereby fixing the warning/error
regarding the absence of a newline. I assume that a newline is expected.
Please let me know if you want me to undo this in the v2 series.

> 
> Also, looking at Martyn's/Sjoerd's series, I see a couple of things
> missing:
> 1. Documentation. now that am62px is compatible with the
>    am62x_r5_usbdfu.config fragment, we need to document this in the board
>    docs. See: commit def64b493748 ("doc: board: Add document for DFU boot on am62x SoCs")

I planned on documenting it once this series got merged. The reason
behind it is that I was unsure if the device-tree patch in this series
will be accepted or will be asked to be enabled via the Linux DT Sync
process. In the latter case, documenting this feature will be incorrect
in the event of a partial merge (i.e. the documentation patch gets
merged but the device-tree patch doesn't).

> 
> 2. Including configs/am62x_a53_usbdfu.config in configs/am62px_evm_a53_defconfig.
>    This is how it's done for am62x, see:
>    commit dfc2dff5a844 ("configs: am62x_evm_*: Enable USB and DFU support")
> 
> Note that If we don't do 2), we cannot use USB gadget from a U-Boot that
> has been booted over DFU:
> 
>     => fastboot usb 0
>     No USB device found
>     USB init failed: -19
>     => usb list
>     USB is stopped. Please issue 'usb start' first.
>     => usb start
>     starting USB...
>     No USB controllers found
>     =>
> 
> For 2, this diff fixes it:
> 
> diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_defconfig
> index 9635beb1b27e..81f433c997b5 100644
> --- a/configs/am62px_evm_a53_defconfig
> +++ b/configs/am62px_evm_a53_defconfig
> @@ -183,3 +183,4 @@ CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>  CONFIG_EFI_SET_TIME=y
>  
>  #include <configs/k3_efi_capsule.config>
> +#include <configs/am62x_a53_usbdfu.config>
> 
> In my opinion, 2) is a valid use case:
> 1. On a blank board, we boot the bootloaders over DFU
> 2. Once U-Boot is started, we start fastboot to flash all images to eMMC.
> 
> Could this be added for v2, please?

Sure, I will include it in the v2 series. Thank you for reviewing this
patch and sharing feedback.

Regards,
Siddharth.
