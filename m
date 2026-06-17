Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87F7CD98E2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 10:12:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C89184894;
	Wed, 17 Jun 2026 12:12:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l8VkhQDU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B520848A2; Wed, 17 Jun 2026 12:12:45 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCCC7846B0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 12:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 910DB600AA;
 Wed, 17 Jun 2026 10:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1431F00AC4;
 Wed, 17 Jun 2026 10:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781691161;
 bh=xGFF2U5gJKMPCOi9kMWmVAvwRJnRwJrkzfwMlYITZIU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=l8VkhQDUfMZVpt9sN6ZBI810MklPrrEakP2wGBm8r7WPIgJ7jk1RsrZ11a+g9fTI4
 0jqc5kjHPvoaZNeF6/7970z+NHVTvIYImnv5l38JDVRIDKEgWo1y/EBcXAo3HPthom
 6UIpeNBdeL+VjCpzjoEv90HZ/0GVCn/2bpYaNeNgkoRga3ytpi430ho3X06gh3ANkx
 J3FdtRvDXuBH6+6GmoSNLuL5ayxNFR96fsJjN8ZLRB1HsZ1Cj6d10RebPnP15ng0rk
 SU6BX+MubZx/d3pYyPz1O6DefW3UKSPFr/6s/Q1t8XYvFFmrcA/mYFgWD7RUCyV4aT
 ps/0EqcbUM/nA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, u-boot@lists.denx.de, Stephan Gerhold
 <stephan.gerhold@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>, Patrice Chotard
 <patrice.chotard@foss.st.com>
Subject: Re: [PATCH] usb: gadget: dwc2: reset endpoint enabled state on reinit
In-Reply-To: <87cxxph6d1.fsf@kernel.org>
References: <20260616-ums_fix-v1-1-f1f6c903b3fc@foss.st.com>
 <87cxxph6d1.fsf@kernel.org>
Date: Wed, 17 Jun 2026 12:12:38 +0200
Message-ID: <87a4sth3vt.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Wed, Jun 17, 2026 at 11:19, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:

> Hi Patrice,
>
> Thank you for the patch and for finding this bug.
>
> On Tue, Jun 16, 2026 at 14:57, Patrice Chotard <patrice.chotard@foss.st.com> wrote:
>
>> Issue found with STM32MP157C-DK2 board, first usage of "ums 0 mmc 0"
>> is working, but second execution doesn't. The mass storage is not visible
>> from host side.
>>
>> Since commit 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag
>> in struct usb_ep"), usb_ep_enable() returns early when ep->enabled is
>> already set.
>>
>> The DWC2 UDC driver reinitializes its endpoint software state in
>> udc_reinit(), including descriptor, stopped state and request queues, but
>> it leaves the generic usb_ep.enabled flag untouched. After stopping UMS
>> once, endpoints can therefore still look enabled to the gadget core even
>> though the DWC2 endpoint state has been reset.
>>
>> On the next "ums 0 mmc 0" run, usb_ep_enable() skips the controller
>> enable callback, so the host no longer sees a usable USB mass-storage
>> device.
>>
>> Clear ep->ep.enabled together with the rest of the DWC2 endpoint state so
>> each new gadget run programs the hardware endpoints again.
>>
>> Tested on STM32MP157c-dk2 board.
>>
>> Fixes: 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag in struct usb_ep")
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>
> I give this some testing and I have curious results.
>
> With commit a7830e87555a ("Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh"),
>
> I reproduce this on VIM3 (using configs/khadas-vim3_android_defconfig)
> with:
> """
> U-Boot 2026.07-rc4-00061-ga7830e87555a (Jun 17 2026 - 11:07:46 +0200) khadas-vim3
>
> Model: Khadas VIM3
> SoC:   Amlogic Meson G12B (A311D) Revision 29:b (10:2)
> DRAM:  2 GiB (total 3.8 GiB)
> Core:  408 devices, 37 uclasses, devicetree: separate
> MMC:   mmc@ffe03000: 0, mmc@ffe05000: 1, mmc@ffe07000: 2
> Loading Environment from MMC... Reading from MMC(2)... OK
> In:    usbkbd,serial
> Out:   vidconsole,serial
> Err:   vidconsole,serial
> Net:   eth0: ethernet@ff3f0000
>
> Hit any key to stop autoboot: 0
> => ums 0 mmc 2
> UMS: LUN 0, dev mmc 2, hwpart 0, sector 0x0, count 0x3a3e000
> -crq->brequest:0x0
> \
> CTRL+C - Operation aborted
> =>
> """
>
> On host (before interrupting UMS):
> $ lsblk /dev/sda
> NAME MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
> sda    8:0    1 29.1G  0 disk
>
> Then we restart UMS:
> """
> => ums 0 mmc 2
> UMS: LUN 0, dev mmc 2, hwpart 0, sector 0x0, count 0x3a3e000
> \crq->brequest:0x0
> """
>
> On host:
>  $ lsblk /dev/sda
> lsblk: /dev/sda: not a block device
>
> I can also confirm that your patch solves the issue for me with UMS.
>
> However, using fastboot (which also binds to the gadget driver, I can't
> reproduce this issue):
>
> """
> U-Boot 2026.07-rc4-00061-ga7830e87555a (Jun 17 2026 - 11:15:24 +0200) khadas-vim3
>
> Model: Khadas VIM3
> SoC:   Amlogic Meson G12B (A311D) Revision 29:b (10:2)
> DRAM:  2 GiB (total 3.8 GiB)
> Core:  408 devices, 37 uclasses, devicetree: separate
> MMC:   mmc@ffe03000: 0, mmc@ffe05000: 1, mmc@ffe07000: 2
> Loading Environment from MMC... Reading from MMC(2)... OK
> In:    usbkbd,serial
> Out:   vidconsole,serial
> Err:   vidconsole,serial
> Net:   eth0: ethernet@ff3f0000
>
> On host (before interrupting UMS):
> Hit any key to stop autoboot: 0
> => fastboot usb 0
> crq->brequest:0x0
> """
>
> On host:
> $ fastboot devices
> C8631470D063     Android Fastboot
>
> Then: interrupt with CTRL+C and re-run:
> """
> => fastboot usb 0
> crq->brequest:0x0
> """
>
> On host:
> $ fastboot devices
> C8631470D063     Android Fastboot
>
> This makes be believe that the current patch might not be the right
> approach. Could we investigate why it works for fastboot but not for
> UMS?
>
> Maybe the commands have a different teardown mechanism.

Some debugging pointed me out to the following patch that's in linux:
https://lore.kernel.org/r/1635365407-31337-3-git-send-email-quic_wcheng@quicinc.com

I've applied that locally and to me it fixes the issue with UMS.

I'll send it to the list.

>
>> ---
>>  drivers/usb/gadget/dwc2_udc_otg.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
>> index e475b14b9ac..5752bf3ca70 100644
>> --- a/drivers/usb/gadget/dwc2_udc_otg.c
>> +++ b/drivers/usb/gadget/dwc2_udc_otg.c
>> @@ -209,6 +209,7 @@ static void udc_reinit(struct dwc2_udc *dev)
>>
>>  		ep->desc = 0;
>>  		ep->stopped = 0;
>> +		ep->ep.enabled = false;
>>  		INIT_LIST_HEAD(&ep->queue);
>>  		ep->pio_irqs = 0;
>>  	}
>>
>> ---
>> base-commit: badd97fe24dfb73b2728c26b433cabe315a27971
>> change-id: 20260616-ums_fix-fad8736154b6
>>
>> Best regards,
>> --
>> Patrice Chotard <patrice.chotard@foss.st.com>
