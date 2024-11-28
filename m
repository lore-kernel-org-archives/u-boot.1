Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78857D69104
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 12:45:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAB508962C;
	Thu, 28 Nov 2024 13:45:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fbzQbSHO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4BF38932F; Thu, 28 Nov 2024 13:45:14 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4678B8962C
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 13:45:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 83E74A41394;
 Thu, 28 Nov 2024 12:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33152C4CED3;
 Thu, 28 Nov 2024 12:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732797911;
 bh=GAjqKmTF6CS9HJZ+JsuFHl0dAA3u959B7FoOO0UVmTE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fbzQbSHOeJtUVEOYtHkNYIuScxfZwlhw+hKAro11hqENcWvevrbe3Y10As4KvhvSn
 Nd70H5ymLbn+nGdVSeig7qFEVDJmq4G4t8HSW3kQfI6i4J0pDyA+Y1hknM1YMkLHe2
 fYjy5WkSKGVpaYqtcj8AGxOU6feoRMnth6keLDzXnUMBvF+qQh2lHBC5buLhown7UW
 TrRiToTNOLH4TROnNjCHcKFHD51OfHz/pEfOyhdRcZUZBuj3LPpTBftrYSC/mExxpw
 36+GL83/lLvsTpH94vooaRmsr+18qEJDOVHEJo1d9RXanpp55dF5MUwb60WiA6b490
 Oa7kd9ABXirdg==
Message-ID: <ea2bb69c-280a-4ab2-85ef-cd0d9e6e3f76@kernel.org>
Date: Thu, 28 Nov 2024 14:45:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] AM62A DWC3: Add support for USB DFU boot in OTG mode
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 trini@konsulko.com, marex@denx.de, hnagalla@ti.com,
 mkorpershoek@baylibre.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, jan.kiszka@siemens.com, jonas@kwiboo.se,
 j-humphreys@ti.com, nm@ti.com, devarsht@ti.com, ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20241126120322.1760862-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241126120322.1760862-1-s-vadapalli@ti.com>
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



On 26/11/2024 14:03, Siddharth Vadapalli wrote:
> Hello,
> 
> This series adds support for USB DFU boot on TI's AM62A SoC which has
> two instances of DWC3 USB Controllers namely USB0 and USB1. The USB0
> instance of the USB Controller supports USB DFU boot:
> ROM => tiboot3.bin => tispl.bin => u-boot.img
> 
> USB DFU Boot requires the USB Controller to be configured for Gadget
> mode of operation. Since the USB0 instance of the DWC3 USB Controller
> supports both Host and Gadget modes of operation via the Type-C interface
> on the AM62A7-SK board, the device-tree specifies the "dr_mode" as "OTG".
> However, there is currently no support for dynamically switching the "mode"
> from Host to Gadget and vice-versa with the help of a state-machine.
> The OTG mode is treated as a separate mode in itself rather than being
> treated as an intermediate stage before assuming the Host/Gadget mode.
> Due to this, USB DFU boot via the Type-C interface doesn't work as the
> USB Controller hasn't been appropriately configured for Device/Gadget
> mode of operation. One option is to change the device-tree to specify
> "dr_mode" as "peripheral" and force the controller to assume the Device
> role. This will imply that the U-Boot device-tree for AM62A diverges
> from its Linux counterpart. Therefore, with the intent of keeping the
> device-tree uniform across Linux and U-Boot, and at the same time, in
> order to enable USB DFU boot in "OTG" mode with the DWC3 Controller,
> the first patch in this series sets the "mode" on the basis of the
> caller function, rather than using the "dr_mode" property in the
> device-tree. There are only two callers of "dwc3_generic_probe()",
> each of which clearly specify the expected mode of configuration.
> This will enable both Host and Device mode of operation based on the
> command executed by the user, thereby truly supporting "OTG"
> functionality when the USB Controller supports it.

We don't really support OTG state machine. All you are supporting is
user initiated role change.

> 
> The second patch in this series adds USB DFU environment for AM62A,
> enabling USB DFU Boot and USB DFU flash on AM62A.
> 
> In addition to the patches in this series, the following device-tree
> changes will be required to test USB DFU on AM62A (bootph-all property
> to be added to ensure that USB Controller is present at all stages
> for DFU Boot):
> https://gist.github.com/Siddharth-Vadapalli-at-TI/53ba02cb0ff4a09c47e920d08247065f
> The above device-tree changes will be made to the Linux device-tree,
> which shall ensure that the same shall be a part of U-Boot device-tree
> eventually.
> 
> The USB DFU config fragments for AM62x have been used for enabling
> USB DFU boot on AM62a as follows:
> R5  => am62ax_evm_r5_defconfig + am62x_r5_usbdfu.config
> A53 => am62ax_evm_a53_defconfig + am62x_a53_usbdfu.config
> 
> Logs validating USB DFU boot with this series:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/daa71da1b0e478a51afea42605fb2d2c
> 
> Series is based on commit
> 3073246d1be Prepare v2025.01-rc3
> of the master branch of U-Boot.
> 
> Regards,
> Siddharth.
> 
> Siddharth Vadapalli (2):
>   usb: dwc3-generic: set "mode" based on caller of dwc3_generic_probe()
>   board: ti: am62ax: env: include environment for DFU
> 
>  board/ti/am62ax/am62ax.env      | 1 +
>  drivers/usb/dwc3/dwc3-generic.c | 9 +++++----
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 

-- 
cheers,
-roger

