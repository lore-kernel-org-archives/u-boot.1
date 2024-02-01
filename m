Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC13C47DDF
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 11:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7ABC878C9;
	Thu,  1 Feb 2024 12:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1706786028;
	bh=0C5tUpbGTpzhUeNeo3sVsnINmdT97KhqW2WT8dPSbvI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y2w1DjWUj5Yk+qPAU2JmXztBabY1WKZ2Hypwpm9kfCWP/VuioJvch1Pf1s2l1EA5e
	 Id3s8/wSltzxYsgPwBeP9kXqij2PPU/5126umSeh8e8jOYc3AGs/sv6w7QOrSYQRe5
	 2lLfmzzZ+9rJ5NUOeevaIyzttJY8iwE9c7omlbCgin+o+TK0i6wc1h6hkFJR69kez1
	 RKhbOtPb/TdMgJkHFRajJsrXUwoctE37PmHKNjw4Nd6EWGLY3ccM1At9sUvHrgophF
	 SZVf58OBdUeaZxZYlyASrtUOtftBoU8NnH0scpspgt07F6iCsp2LeWStc2j5a1OvDR
	 nYvDUn5WYmFPQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F14A38746C;
 Thu,  1 Feb 2024 12:13:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1706786026;
 bh=0C5tUpbGTpzhUeNeo3sVsnINmdT97KhqW2WT8dPSbvI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TfTLp9GIDqBps0ebAs6lrc+jX5yG5OQrkTuf05ulfMm5XPG5FxeLRGQc+gTb8NI3s
 ua/JUWqCcY3zCwGkksawKW/7KcCTj20QfZUe5vR5KmcWbQvebp87mUa7Lu9TEofZBF
 F2SpACSkb3Q0E7L8t1SIhqpKh/SHXXTB8pbCf9N8UVZWuyIUiGvFd9JYxZknFKIkzC
 fs+6PcxPRkalEK1KTfHO8NFJ+1oOoNA61qJ9Mp91O/pBmDBlL5vHp31F+b5sqJ3HvU
 7Xtybk2zdOwDEqVJWZazC/d4AoSsSt1EQkXTWm4MzmPg8BWVUeVUuKzZBdoap1bF67
 HXd62Ef5ljHTw==
Message-ID: <3f508431-c4bd-4885-b3b9-f281b6a653e1@denx.de>
Date: Thu, 1 Feb 2024 12:13:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] common: usb-hub: Reset hub port before scanning
To: Shantur Rathore <i@shantur.com>, Andre Przywara <andre.przywara@arm.com>
Cc: bmeng.cn@gmail.com, clamor95@gmail.com, Hector Martin <marcan@marcan.st>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20231209181057.331815-1-i@shantur.com>
 <20240130140123.445f368a@donnerap.manchester.arm.com>
 <CABEcMwWs-_ZzTdt=kRc05JwC=okA9FyvrAVK1rTLa=erTu9N3g@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CABEcMwWs-_ZzTdt=kRc05JwC=okA9FyvrAVK1rTLa=erTu9N3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/1/24 10:39, Shantur Rathore wrote:
> Hi Andre,
> 
> On Tue, Jan 30, 2024 at 2:01 PM Andre Przywara <andre.przywara@arm.com> wrote:
>>
>> On Sat,  9 Dec 2023 18:10:56 +0000
>> Shantur Rathore <i@shantur.com> wrote:
>>
>> Hi,
>>
>>> Currently when a hub is turned on, all the ports are powered on.
>>> This works well for hubs which have individual power control.
>>>
>>> For the hubs without individual power control this has no effect.
>>> Mostly in these scenarios the hub port is powered before the USB
>>> controller is enabled, this can lead to some devices in unexpected
>>> state.
>>>
>>> With this patch, we explicitly reset the port while powering up hub
>>> This resets the port for hubs without port power control and has
>>> no effect on hubs with port power control as the port is still off.
>>>
>>> Before this patch AMicro AM8180 based NVME to USB adapter won't be
>>> detected as a USB3.0 Mass Storage device but with this it works as
>>> expected.
>>>
>>> Tested working after this patch:
>>> 1. AMicro AM8180 based NVME to USB Adapter
>>> 2. Kingston DataTraveler 3.0
>>> 3. GenesysLogic USB3.0 Hub
>>>
>>> The drives were tested while connected directly and via the hub.
>>
>> so this broke USB operation on some Allwinner boards. The ports still
>> enumerate correctly, but no devices are detected. With mainline
>> (containing this patch), and a USB stick connected:
>> starting USB...
>> Bus usb@5200000: USB EHCI 1.00
>> Bus usb@5200400: USB OHCI 1.0
>> scanning bus usb@5200000 for devices... 1 USB Device(s) found
>> scanning bus usb@5200400 for devices... 1 USB Device(s) found
>>         scanning usb for storage devices... 0 Storage Device(s) found
>>
>> With this patch here reverted:
>> starting USB...
>> Bus usb@5200000: USB EHCI 1.00
>> Bus usb@5200400: USB OHCI 1.0
>> scanning bus usb@5200000 for devices... 2 USB Device(s) found
>> scanning bus usb@5200400 for devices... 1 USB Device(s) found
>>         scanning usb for storage devices... 1 Storage Device(s) found
>>
>> I have no clue why this happens, there is no discrete hub anywhere in this
>> setup, so I guess the code runs for the root hub here?
>> I am attaching a log with DEBUG enabled for common/usb_hub.c, for both
>> cases.
>>
>> Any clues, debug suggestions, or even a fix are warmly welcome.
>>
> 
> Which USB disk are you using? Is it a USB 2.0 disk ?
> Can you try with any other USB disk to confirm?

I don't think this is device specific, see the logs. Hardware from Andre 
worked before this patch, does not work after this patch. There seem to 
be no connection event with this patch.
