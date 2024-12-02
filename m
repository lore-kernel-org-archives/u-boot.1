Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC64D4979F
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 05:42:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C1F789137;
	Mon,  2 Dec 2024 06:42:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="V4C9xTqN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7B4489385; Mon,  2 Dec 2024 06:42:28 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80E1889119
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 06:42:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B25gFJZ1669028
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 1 Dec 2024 23:42:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733118135;
 bh=s8LKowxECFCiVEHizEvAkVeU1OtzYp9UgjRazQbBP3o=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=V4C9xTqNygesWDghVa0uzISRyN66FUQP5BK56DaqxMqjRdAAyOCcG+jiPVNYl883q
 PRx2WxFkbqEtKXKKzfW38MjFi9DI/lgxbMTzzzBuzzPMnC/c789OTnxGua2KEIfG98
 0D2Xy993s5YazaaU2rKM5pPyzySOmxcNbgWRmPuQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B25gFfs016055
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 1 Dec 2024 23:42:15 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Dec 2024 23:42:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Dec 2024 23:42:14 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B25gCw1111694;
 Sun, 1 Dec 2024 23:42:13 -0600
Date: Mon, 2 Dec 2024 11:12:11 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, 
 <trini@konsulko.com>, <marex@denx.de>, <hnagalla@ti.com>,
 <mkorpershoek@baylibre.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <jan.kiszka@siemens.com>,
 <jonas@kwiboo.se>, <j-humphreys@ti.com>, <nm@ti.com>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>,
 <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH 1/2] usb: dwc3-generic: set "mode" based on caller of
 dwc3_generic_probe()
Message-ID: <i7kcsazysfv5brn5bzgh5yypgr7hl2qndd5aqdrgbkb6ztmvxo@qwuxqa7vm2nt>
References: <20241126120322.1760862-1-s-vadapalli@ti.com>
 <20241126120322.1760862-2-s-vadapalli@ti.com>
 <f4c4cb82-0e8c-49a1-aff0-2c539f15047d@kernel.org>
 <252751ec-2000-43bd-a9e3-fc0b53362baf@ti.com>
 <84c24040-5311-469f-8ba7-470280604245@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <84c24040-5311-469f-8ba7-470280604245@kernel.org>
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

On Fri, Nov 29, 2024 at 02:28:36PM +0200, Roger Quadros wrote:
> 
> 
> On 28/11/2024 19:20, Siddharth Vadapalli wrote:

[...]

> > USB DFU boot utilizes this driver when the "dr_mode" is set to "otg" in
> > the device-tree for AM62A. This driver is invoked both for the host and
> > device commands corresponding to USB. I came up with this patch while
> > trying to enable USB DFU boot on AM62A with "dr_mode" as "otg" in the
> > device-tree. Additionally, USB DFU boot works on AM62A with the change
> > made by this patch and it doesn't work without this change. I have
> > traced the call sequence to see that the driver is probed and have come
> > up with the change performed in this patch on the basis of this observation.
> > 
> 
> Although the glue driver portion of the dwc3-generic driver is not used by AM62
> it still uses the generic_probe() portion via
> U_BOOT_DRIVER(dwc3_generic_host) and U_BOOT_DRIVER(dwc3_generic_peripheral)
> 
> here is the dm tree output on am62-sk after executing "usb start" command.
> 
> 
>  simple_bus    5  [ + ]   dwc3-am62             |   |-- dwc3-usb@f900000
>  usb_gadget    0  [   ]   dwc3-generic-periphe  |   |   |-- usb@31000000
>  usb           0  [ + ]   xhci-dwc3             |   |   `-- usb@31000000
>  usb_hub       0  [ + ]   usb_hub               |   |       `-- usb_hub
>  simple_bus    6  [ + ]   dwc3-am62             |   |-- dwc3-usb@f910000
>  usb           1  [   ]   dwc3-generic-host     |   |   |-- usb@31100000
>  usb           1  [ + ]   xhci-dwc3             |   |   `-- usb@31100000
>  usb_hub       1  [ + ]   usb_hub               |   |       `-- usb_hub
> 
> what is strange is that even though usb@31000000 is configured as
> "peripheral" (in k3-am625-sk-u-boot.dtsi), xhci-dwc3 and usb_hub drivers
> are still initialized for it.

CONFIG_OF_UPSTREAM is enabled in am62x_evm_a53_defconfig. So dr_mode
might be "otg" as specified in:
dts/upstream/src/arm64/ti/k3-am62-main.dtsi
I'm not sure about this however. Additionally, this series isn't required
for AM62. DFU Boot works on AM62 without this series as well. This series
is required for AM62A.

[...]

> > I didn't test the case where both are used. I validated that peripheral
> > mode works across various stages of boot with "otg" mode via USB DFU
> > boot. This isn't the case without this patch.
> > 
> > If we forget the reason that this patch is introduced and take a moment
> > to analyze the existing code prior to this patch, we see that:
> > 1. Both dwc3_generic_peripheral_probe() and dwc3_generic_host_probe()
> > invoke dwc3_generic_probe().
> > 2. dwc3_generic_probe() sets the role based on the role specified in the/
> > device-tree and not what the caller wants the role to be.
> > This seems to be strange to me considering that dwc3_generic_probe()
> > simply proceeds to configure without comparing the role supported by the
> > platform with the role requested by the caller.
> > 
> > So even if we entirely forget the "otg" fix being attempted by this
> > patch, the same patch is fixing something else i.e. ensuring that
> > dwc3_generic_probe() does what the caller wants it to do by using the
> > role that the caller expects. Isn't it incorrect that the existing code
> > might end up with:
> > a) Caller being dwc3_generic_host_probe() with dr_mode being set to
> > "peripheral" within dwc3_generic_probe() based on the device-tree and
> > proceeding to configure the controller
> 
> Maye this is the reason why host controller is initialized for peripheral
> only port in the dm tree output I listed above. This needs to be fixed.

Sure, I will post a patch to do the following:
If dr_mode specified in device-tree is "host" then return -EINVAL within
dwc3_generic_probe() if the caller is "dwc3_generic_peripheral_probe()".
Similarly, if dr_mode specified in the device-tree is "peripheral" then
return -EINVAL within dwc3_generic_probe() if the caller is
"dwc3_generic_host_probe()". When dr_mode is specified as "otg" in the
device-tree, then configure the mode based on the caller of
dwc3_generic_probe().

Please let me know if the above implementation is acceptable.

> > b) Caller being dwc3_generic_peripheral_probe() with dr_mode being set
> > to "host" within dwc3_generic_probe() based on the device-tree and
> > proceeding to configure the controller.
> 
> This too needs to be fixed.
> 
> > Shouldn't this inconsistency be fixed? This patch fixes that by setting
> > dr_mode to what the caller expects. However, based on your suggestion, I
> > agree that there should have been a check within dwc3_generic_probe() to
> > ensure that the platform supports what the caller is requesting. I will
> > update this patch by adding the check.
> 
> Apart from the platform supported mode check when not "otg", if platform
> supports "otg" we need to check and prevent role setting if hardware is
> not in the correct state based on connected USB cable.
> i.e. if host mode cable is used then prevent it from running as a peripheral.
> if peripheral mode cable is used then prevent it from running as a host.
> (based on ID status?)

Yes, I agree that using the ID status to determine the role is accurate.
At the same time, I think that in addition to this, if the user runs a
command corresponding to "peripheral" mode of operation with the ID
status indicating "host", then it will be better to take this
inconsistency into account and error out rather than simply proceeding
to configure on the basis of the ID status. If you have any feedback,
kindly let me know.

Regards,
Siddharth.
