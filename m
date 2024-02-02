Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4126C4828D
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 02:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01B3D87C5B;
	Fri,  2 Feb 2024 03:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="c/Pjf5vA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2070C87BD1; Fri,  2 Feb 2024 03:35:29 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 857BD87C5B
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 03:35:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1706841325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mar/eM3RYzFapEDxLou61jAOiXlT4I3x5BTIOIF9xmY=;
 b=c/Pjf5vArG07iy2jauoJk4Zf/LTThTUQqzMs68weRSYQKeQ/v6EHMLgaVTxf5YFlZlPZnH
 Yz86YvKhDygoqUDL4bq4/tACLKaa5g2r+BJnrVvXXjzGh0LFf80txCTbP9INrovgFiBRJM
 EDLqUJoDxAZDAQWyAiu8gSjlyNk3nkRjLBVSm24A96O9m55TALGlghW4Pu6to9QxcXCEyU
 08lrR1b+UbwrPua4GQO+yI/4Dku6PY8Av3ZqXrUoTGSh4v+gwWa0GZtJeRnSnSZetOr6KM
 m6JRq2FltBOxKxqhGl2u8bATMegPgJk91kooRQGxtOGiWkOntaJq21lRPYwntw==
Date: Fri, 02 Feb 2024 03:35:24 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Shantur Rathore <i@shantur.com>, marex@denx.de, bmeng.cn@gmail.com,
 clamor95@gmail.com, Hector Martin <marcan@marcan.st>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3] common: usb-hub: Reset hub port before scanning
In-Reply-To: <20240202001218.63b4e9c3@minigeek.lan>
References: <20231209181057.331815-1-i@shantur.com>
 <20240130140123.445f368a@donnerap.manchester.arm.com>
 <CABEcMwWs-_ZzTdt=kRc05JwC=okA9FyvrAVK1rTLa=erTu9N3g@mail.gmail.com>
 <20240201164604.13315fa6@donnerap.manchester.arm.com>
 <CABEcMwXYw9L957wykfZ5HcC5V88hbgEDZ-E_fYL9LhG_hyxb=g@mail.gmail.com>
 <20240202001218.63b4e9c3@minigeek.lan>
Message-ID: <0f15ffcce8c15b86e5a44a3255ef265c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Andre,

On 2024-02-02 01:12, Andre Przywara wrote:
> On Thu, 1 Feb 2024 18:35:28 +0000 Shantur Rathore <i@shantur.com> 
> wrote:
>> On Thu, Feb 1, 2024 at 4:46 PM Andre Przywara <andre.przywara@arm.com> 
>> wrote:
>> > On Thu, 1 Feb 2024 09:39:54 +0000 Shantur Rathore <i@shantur.com> wrote:
>> > > On Tue, Jan 30, 2024 at 2:01 PM Andre Przywara <andre.przywara@arm.com> wrote:
>> > > > On Sat,  9 Dec 2023 18:10:56 +0000 Shantur Rathore <i@shantur.com> wrote:
>> > > > > Currently when a hub is turned on, all the ports are powered on.
>> > > > > This works well for hubs which have individual power control.
>> > > > >
>> > > > > For the hubs without individual power control this has no effect.
>> > > > > Mostly in these scenarios the hub port is powered before the USB
>> > > > > controller is enabled, this can lead to some devices in unexpected
>> > > > > state.
>> > > > >
>> > > > > With this patch, we explicitly reset the port while powering up hub
>> > > > > This resets the port for hubs without port power control and has
>> > > > > no effect on hubs with port power control as the port is still off.
>> > > > >
>> > > > > Before this patch AMicro AM8180 based NVME to USB adapter won't be
>> > > > > detected as a USB3.0 Mass Storage device but with this it works as
>> > > > > expected.
>> > > > >
>> > > > > Tested working after this patch:
>> > > > > 1. AMicro AM8180 based NVME to USB Adapter
>> > > > > 2. Kingston DataTraveler 3.0
>> > > > > 3. GenesysLogic USB3.0 Hub
>> > > > >
>> > > > > The drives were tested while connected directly and via the hub.
>> > > >
>> > > > so this broke USB operation on some Allwinner boards. The ports still
>> > > > enumerate correctly, but no devices are detected. With mainline
>> > > > (containing this patch), and a USB stick connected:
>> > > > starting USB...
>> > > > Bus usb@5200000: USB EHCI 1.00
>> > > > Bus usb@5200400: USB OHCI 1.0
>> > > > scanning bus usb@5200000 for devices... 1 USB Device(s) found
>> > > > scanning bus usb@5200400 for devices... 1 USB Device(s) found
>> > > >        scanning usb for storage devices... 0 Storage Device(s) found
>> > > >
>> > > > With this patch here reverted:
>> > > > starting USB...
>> > > > Bus usb@5200000: USB EHCI 1.00
>> > > > Bus usb@5200400: USB OHCI 1.0
>> > > > scanning bus usb@5200000 for devices... 2 USB Device(s) found
>> > > > scanning bus usb@5200400 for devices... 1 USB Device(s) found
>> > > >        scanning usb for storage devices... 1 Storage Device(s) found
>> > > >
>> > > > I have no clue why this happens, there is no discrete hub anywhere in this
>> > > > setup, so I guess the code runs for the root hub here?
>> > > > I am attaching a log with DEBUG enabled for common/usb_hub.c, for both
>> > > > cases.
>> > > >
>> > > > Any clues, debug suggestions, or even a fix are warmly welcome.
>> > > >
>> > >
>> > > Which USB disk are you using? Is it a USB 2.0 disk ?
>> > > Can you try with any other USB disk to confirm?
>> >
>> > Yes, this was some USB 2.0 memory stick, on an USB 2.0 port.
>> > Most sunxi boards only have USB 2.0, but there is one SoC with USB 3.0, I
>> > will try some combinations later tonight.
>> 
>> That would be awesome.
>> We need to test
>> 
>> USB 3.0 and 2.0 ports with USB 3.0 and 2.0 drives.
> 
> So I had some mixed and apparently inconsistent results:
> - On the Pine-H64 (H6 SoC with USB 3.0 + USB 2.0) it worked with
>   mainline, but only after I applied some pending sunxi USB PHY
>   regulator patches. This is an unrelated issue, those patches
>   are needed to enable USB 3.0 support on that board (shared regulator
>   conflict).
>   I tested a USB 2.0 and a USB 3.0 drive in both kind of slots, with
>   and without the patch.
> - On the OrangePi Zero 3 (H616 SoC with USB 2.0 only), the USB 3.0
>   drive would not work with mainline. A USB 2.0 drive was fine.
>   Applying your patch below fixed that problem, now both drives worked.

Let me interject, please...

Huh, this (mih)behavior with the tested OrangePi Zero 3 is really
strange.  As we know, a USB 3.0 drive plugged into a USB 2.0 port
should behave just like a USB 2.0 drive, using the separate set
of pins inside the connector.

If possible, performing some additional testing with another USB
3.0 drive would be quite interesting.  Could it be that something
is wrong with the USB 2.0 receptacle on your OrangePi Zero 3,
mechanically or electrically?

> - On the OrangePi Zero (H3 with USB 2.0 only), it worked with and
>   without the patch below, with both the USB 2.0 and USB 3.0 drive.
> - On the BananaPi M64 (A64 with USB 2.0 only and an onboard USB 2.0
>   hub) it also worked in all cases: with and without the patch, USB 2.0
>   and USB 3.0 drive.
> 
> So the good news is: with the patch below it worked in all cases, with
> all drives in all slots, on all boards. With current mainline some
> drives don't work at least on the board with the H616 SoC.
> 
> I cannot really say if that makes sense, and the results above maybe
> more per board than per SoC (different VBUS supply), but would
> pragmatically tend to use the patch, feel free to add my Tested-by:
> when sending:
> 
> Tested-by: Andre Przywara <andre.przywara@arm.com>
> 
> Just one tiny thing:
> 
>> Once you have tested it, can you please try the patch below
>> 
>>         debug("enabling power on all ports\n");
>>         for (i = 0; i < dev->maxchild; i++) {
>> -               usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
>> -               debug("Reset : port %d returns %lX\n", i + 1, 
>> dev->status);
>> +               if (usb_hub_is_superspeed(hub)) {
> 
> this must be: usb_hub_is_superspeed(dev)
> 
> So many thanks for that patch, that seem to have fixed it for me - even
> though I don't understand why. But then again I only have superficial
> USB knowledge.
> 
>> +                       usb_set_port_feature(dev, i + 1, 
>> USB_PORT_FEAT_RESET);
>> +                       debug("Reset : port %d returns %lX\n", i + 1,
>> dev->status);
>> +               }
>>                 usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_POWER);
>>                 debug("PowerOn : port %d returns %lX\n", i + 1, 
>> dev->status);
>>         }
