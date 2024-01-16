Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B791C4707B
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 00:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1AD1876F6;
	Tue, 16 Jan 2024 01:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705365956;
	bh=JsErq0t6sdnjvwg9Wbhx/wgkE9jwTsh8Tqk7Ol8X7rY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OEEI28MPj8z8AgmbpjeTyKjfElbDpNMOyharqsWqtfuFG6xZgxVSLTum5S0503KUD
	 MIsdoVMhafZViD4OnjPV7dSBXB98TDr/NAuGGyvcjPNqGWXWM8Oy2Wc/MX8Z69/hgy
	 FwasVV524h4wxDHDwq3u4ngiWAvogjRskLPWlW/DZOgJL41mldzr+4u95lOjI/38UI
	 2N61CoyiCN9F7bvw0gJmHaa8m3xsAcH2Su4NniUwcn7egVKyCvuHpVV572DJ3CQLQz
	 atVMrEJ5pzymX5gglFDxpD//0F6kEamSuPkwkAoekGU9jsvl+XNcn5OBEA5dnPhTOJ
	 3bY2rxrd4zveg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2730F8701D;
 Tue, 16 Jan 2024 01:45:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1705365955;
 bh=JsErq0t6sdnjvwg9Wbhx/wgkE9jwTsh8Tqk7Ol8X7rY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nOlVrjucwjgY+XtDqSpkUv++01Sh9hPMKG7575aJ2xINRBbSVUEMjohushhG6GvLM
 JuGCyn/odFUuf+1Qpv9CjioACnPr/o63EFTXwUXTwhCdRFY1V16Merp9pSkv/h2wAf
 X1KIx4k0ts8d8dnzgShauY8fmG4Y2uqxw54mF5Og78bhQJ3+KBF/MWw/87vpE/5bbS
 vcO/+5uVBrvpJ1eQzbWWPZ7egm12WNtnnQxOr7cdRM6btOTmLjCq3dPJaoJC/Oc+nY
 RqfPvLR4OEIcxpRocqqL3DswGBx3D11JV3cu9wZ3D9pEi8WbNXwhf+qYHsC9bNLYMT
 96fcOnlCNSW3g==
Message-ID: <0b0659ab-8361-481b-b863-0b4db0db53b5@denx.de>
Date: Tue, 16 Jan 2024 01:45:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] common: usb-hub: Reset hub port before scanning
Content-Language: en-US
To: Shantur Rathore <i@shantur.com>
Cc: bmeng.cn@gmail.com, clamor95@gmail.com, Hector Martin <marcan@marcan.st>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20231209181057.331815-1-i@shantur.com>
 <CABEcMwWzt=z=3XNWq5iAKmmnB+UsjTzp4_OUs3V8bNuc_i5zMw@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CABEcMwWzt=z=3XNWq5iAKmmnB+UsjTzp4_OUs3V8bNuc_i5zMw@mail.gmail.com>
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

On 1/8/24 23:11, Shantur Rathore wrote:
> Hi Marex,
> 
> On Sat, Dec 9, 2023 at 6:12 PM Shantur Rathore <i@shantur.com> wrote:
>>
>> Currently when a hub is turned on, all the ports are powered on.
>> This works well for hubs which have individual power control.
>>
>> For the hubs without individual power control this has no effect.
>> Mostly in these scenarios the hub port is powered before the USB
>> controller is enabled, this can lead to some devices in unexpected
>> state.
>>
>> With this patch, we explicitly reset the port while powering up hub
>> This resets the port for hubs without port power control and has
>> no effect on hubs with port power control as the port is still off.
>>
>> Before this patch AMicro AM8180 based NVME to USB adapter won't be
>> detected as a USB3.0 Mass Storage device but with this it works as
>> expected.
>>
>> Tested working after this patch:
>> 1. AMicro AM8180 based NVME to USB Adapter
>> 2. Kingston DataTraveler 3.0
>> 3. GenesysLogic USB3.0 Hub
>>
>> The drives were tested while connected directly and via the hub.
>>
>> Signed-off-by: Shantur Rathore <i@shantur.com>
>>
>> ---
>>
>> Changes in v3:
>> - Split up patches as seperate series
>>
>> Changes in v2:
>> - As requested, added fix for regulator-always-on in RockPro64
>>
>>   common/usb_hub.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/common/usb_hub.c b/common/usb_hub.c
>> index 70279f301d..3fb7e14d10 100644
>> --- a/common/usb_hub.c
>> +++ b/common/usb_hub.c
>> @@ -174,8 +174,10 @@ static void usb_hub_power_on(struct usb_hub_device *hub)
>>
>>          debug("enabling power on all ports\n");
>>          for (i = 0; i < dev->maxchild; i++) {
>> +               usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
>> +               debug("Reset : port %d returns %lX\n", i + 1, dev->status);
>>                  usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_POWER);
>> -               debug("port %d returns %lX\n", i + 1, dev->status);
>> +               debug("PowerOn : port %d returns %lX\n", i + 1, dev->status);
>>          }
>>
>>   #ifdef CONFIG_SANDBOX
>> --
>> 2.40.1
>>
> 
> Do you think it is the right time to get this in early so it can be
> tested for a longer time before the next release ?

Yes, I think so, sorry for the delay.

I asked Tom to pick it directly and provided RB .
