Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53375C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 10:42:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6FCA87EED;
	Fri,  8 Mar 2024 11:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="tSsWfKTz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E3308801E; Fri,  8 Mar 2024 11:42:53 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A9F787DDD
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 11:42:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1763=KO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1709894555;
 bh=T8ue9Nc3xigtAOErwl4GKHHmlviOQpLdTJRXbICfdro=;
 b=tSsWfKTzyhYm+yhy97HgEF2FaIwX24IQ6EEGxWdALNEg4Rr89GZ3R6qZlBKGi/uTyZv9t5a88
 f7RDcmbJTh5zDuPo+ZwDU1Fe/pnvfDgyWlO2HopU9KZBkGXdXdO1mCZCWoR2vMV3cMtC/oV9UIP
 os+vs6BUEjIEA8bv45gdEv09DJvuRyNroDE6GfejJQqb2jYJ+7vthM+83NHfVAFc5vk9WMbKUQT
 QWN7l/nOlLamx8pESPDAISaxsphd6WMc7e+bngmq0NLcNGBWuZDKFlEbyVzYfL4wg6UtJopM5cK
 mHHVT+uyQSVqa7LO1SZ6cnidjztTU6vat5cILxKF1ngQ==
Message-ID: <79d3a0e0-ba71-441c-8466-7397c755d863@kwiboo.se>
Date: Fri, 8 Mar 2024 11:42:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] rockchip: Update the default USB Product ID value
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
References: <20240226230822.2430391-1-jonas@kwiboo.se>
 <20240226230822.2430391-2-jonas@kwiboo.se>
 <f1f0abb8-7786-4c56-8e55-772a59bbab82@rock-chips.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <f1f0abb8-7786-4c56-8e55-772a59bbab82@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65eaeb968d33672eeb73206a
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

Hi Kever,

On 2024-03-08 10:22, Kever Yang wrote:
> Hi Jonas,
> 
>      Thanks for your patch.
> 
> On 2024/2/27 07:08, Jonas Karlman wrote:
>> RK3036 is using the USB product id normally used by RK3066B, and RK3328
>> is using the product id normally used by RK3368.
>>
>> Fix this and update the default USB_GADGET_PRODUCT_NUM Kconfig option
>> for remaining supported Rockchip SoCs to match the product id used in
>> Mask ROM mode. Also remove a reference to the unknown ROCKCHIP_RK3229
>> symbol.
> 
> RK3229 belongs to RK322X which is reuse with RK3228.
> 
> Note that this ID is used for rockusb gadget, if work as mass storage, 
> it should use other
> 
> ID, or else it will confuse the driver in host side, eg. the Windows 
> driver may not able to
> 
> recognize the device if using two different gadget type with the same ID.

Patch 3 in this series will change to use 0x0010 product id when ums
mode is enabled and fall back to use the USB_GADGET_PRODUCT_NUM for any
other gadget mode.

The ROCKCHIP_RK3229 symbol is not defined or used anywhere U-Boot so the
change in this patch to remove it from the condition should have no
impact. If RK3229 need a special product id separate from 0x320b used by
ROCKCHIP_RK322X, it can be defined in the defconfig for such board.

I tested this on Windows with rockusb and ums on RK3308, RK3328, RK3399
RK356x and RK3588 boards, switching between ums and rockusb should work
as intended, rockusb driver was used in rockusb mode and in ums mode the
device would show up as a disk.

  => rockusb 0 mmc 1
  => ums 0 mmc 1

I think all product id below is correct, but I have not been able to
runtime validate for other SoCs then the ones listed above.

Regards,
Jonas

> 
> 
> Thanks,
> - Kever
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   drivers/usb/gadget/Kconfig | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
>> index c72a8047635c..4621a6fd5e64 100644
>> --- a/drivers/usb/gadget/Kconfig
>> +++ b/drivers/usb/gadget/Kconfig
>> @@ -70,12 +70,21 @@ config USB_GADGET_PRODUCT_NUM
>>   	hex "Product ID of the USB device"
>>   	default 0x701a if ARCH_TEGRA
>>   	default 0x1010 if ARCH_SUNXI
>> -	default 0x310a if ROCKCHIP_RK3036
>> +	default 0x110a if ROCKCHIP_RV1108
>> +	default 0x110b if ROCKCHIP_RV1126
>>   	default 0x300a if ROCKCHIP_RK3066
>> +	default 0x301a if ROCKCHIP_RK3036
>> +	default 0x310b if ROCKCHIP_RK3188
>>   	default 0x310c if ROCKCHIP_RK3128
>> -	default 0x320a if ROCKCHIP_RK3229 || ROCKCHIP_RK3288
>> -	default 0x330a if ROCKCHIP_RK3328
>> +	default 0x320a if ROCKCHIP_RK3288
>> +	default 0x320b if ROCKCHIP_RK322X
>> +	default 0x320c if ROCKCHIP_RK3328
>> +	default 0x330a if ROCKCHIP_RK3368
>>   	default 0x330c if ROCKCHIP_RK3399
>> +	default 0x330d if ROCKCHIP_PX30
>> +	default 0x330e if ROCKCHIP_RK3308
>> +	default 0x350a if ROCKCHIP_RK3568
>> +	default 0x350b if ROCKCHIP_RK3588
>>   	default 0x0
>>   	help
>>   	  Product ID of the USB device emulated, reported to the host device.

