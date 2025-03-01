Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F15C021B8
	for <u-boot@archiver.kernel.org>; Sat,  1 Mar 2025 07:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 990FA80FE1;
	Sat,  1 Mar 2025 08:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PxpijSYs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85BA9810ED; Sat,  1 Mar 2025 08:11:04 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE4D7805D7
 for <u-boot@lists.denx.de>; Sat,  1 Mar 2025 08:11:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5217Axm22320066
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 1 Mar 2025 01:10:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740813059;
 bh=zL4hORioPAB6YRZ7PMfTulTev9YqZBa7/5BNVDenGmA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=PxpijSYsYDpALxtbxEadsEXnQhs8jVQfJpfYUF8SKovwXviNczeULgwlzVmowSXTL
 VDQzV9lzZmaMWrbLiriwZTJW6jSMHjDCS0xSYXIZoUFAEJ8vXcar0byHImdNBg0ZX3
 zFIbs1T8ydF362pnRMJOcB976HT1by1lMyk/sLSs=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5217AxZP075701
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 1 Mar 2025 01:10:59 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 1
 Mar 2025 01:10:58 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 1 Mar 2025 01:10:58 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5217AvOe063801;
 Sat, 1 Mar 2025 01:10:58 -0600
Date: Sat, 1 Mar 2025 12:40:57 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Javier Tia <javier.tia@linaro.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <u-boot@lists.denx.de>, Jonathan
 Humphreys <j-humphreys@ti.com>, <srk@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, <trini@konsulko.com>
Subject: Re: [PATCH 0/2] Enable USB MSC Boot for AM62, AM62A and AM62P
Message-ID: <20250301071057.blt6i3zrflzrb67s@uda0492258>
References: <20250226103504.1841697-1-s-vadapalli@ti.com>
 <bf08cb63-6df2-40aa-a542-f62244f58dfd@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bf08cb63-6df2-40aa-a542-f62244f58dfd@app.fastmail.com>
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

On Fri, Feb 28, 2025 at 10:11:53AM -0600, Javier Tia wrote:
> Hi Siddharth,

Hello Javier,

> 
> On Wed, Feb 26, 2025, at 4:35 AM, Siddharth Vadapalli wrote:
> > Hello,
> >
> > This series adds config fragment for enabling USB MSC boot and USB
> > Storage devices which are applicable to AM62, AM62A and AM62P SoCs.
> >
> > Series is based on commit
> > 8dd7186ca7 Merge patch series "Remove "saveenv" functionality from am57xx evms"
> > of the next branch of U-Boot.
> >
> > Series has been tested on AM62A7-SK, AM625-SK and AM62P5-SK for USB MSC
> > boot where the bootloaders were generated in the following manner:
> > 1. AM62A7-SK (AM62A SoC):
> > - tiboot3.bin
> > 	=> am62ax_evm_r5_defconfig + am62x_r5_usbmsc.config
> > - tispl.bin and u-boot.img
> > 	=> am62ax_evm_a53_defconfig + am62x_a53_usbmsc.config
> > 2. AM625-SK (AM62 SoC):
> > - tiboot3.bin
> > 	=> am62x_evm_r5_defconfig + am62x_r5_usbmsc.config
> > - tispl.bin and u-boot.img
> > 	=> am62x_evm_a53_defconfig + am62x_a53_usbmsc.config
> > 3. AM62P5-SK (AM62P SoC):
> > - tiboot3.bin
> > 	=> am62px_evm_r5_defconfig + am62x_r5_usbmsc.config
> > - tispl.bin and u-boot.img
> > 	=> am62px_evm_a53_defconfig + am62x_a53_usbmsc.config
> >
> > The images were flashed to a USB Flash Drive and were connected to the
> > Type-C interface on each of the boards which supports USB MSC Boot.
> 
> I have access to a TI board. I want to test the USB boot.
> 
> Are there any special requirements around the flash image?
> 
> Would it be sufficient to flash the WIC image generated by the Arago project?

Yes, flashing the WIC Image from the Arago project to generate the /boot
partition followed by replacing the bootloaders there with the ones
built using the usbmsc.config config fragment shoudl work.

> 
> Could I use the same U-Boot images with these configs to boot from UART and SD card? I meant, if these configs will create conflicts with other boot modes.

The functionality associated with the configs disabled in the respective
config fragments for r5 and a53 will be lost, namely:
r5_usbmsc.config => SD Boot will not work but UART Boot should still
work since the config corresponding to it hasn't been disabled.
a53_usbmsc.config => Both SD Boot and UART Boot will work.

If your use-case requires SD Boot in addition to USB MSC Boot at the R5
SPL stage, you could try disabling a different config in the platform's
base r5_defconfig and enable SD configs in its place.

Regards,
Siddharth.
