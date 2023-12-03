Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECAEC4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 20:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 808AB8772E;
	Sun,  3 Dec 2023 21:42:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701636133;
	bh=u80pB+7b3P4Qz97odbDMSL99SoJkdraiT9GiK2Q68cs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WVYb3+/cKxwxyT0KxM+btMfFwO7C91ds8m9SCGpvpN1+M0DbqhrK+5dH3vuFwi5kv
	 WRZ5ypijC4ngbjGg1UNmHi4Z+w65yMLHl+mN1w34S6F2580YtolIM469vYjKnMTbFT
	 pwSlwBGAhaj9iENmw0YGwzY7DMZkelghOb/iSDONXMK/aVQPE9jQR8gXJEh3B9IcOq
	 fmwwY+57zFYAVp5VEJl0JIVgBz9OrjYOiKzJBahaJ+7xkwbaW+mFt0bQK8IEBoKgV5
	 qGMWGodKIGcIjN2W3WNMaZDhkmUVCqa/XiwnhbXwmM7M3HfRuImzul7xHkDK09w2TQ
	 AaFfmrV31XdeQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0454687538;
 Sun,  3 Dec 2023 21:42:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1701636131;
 bh=u80pB+7b3P4Qz97odbDMSL99SoJkdraiT9GiK2Q68cs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TUSE0arc/XpBNm2RtUUVCkKAinCHRog6ZKbxnUmaSiVoigTz6UFdt607lTyMZmQCH
 lMgcEFBYcD5rPQpE04GHli1aqBB2Thkkv0HkpQmV6aVAemLoRNvUS/aFFNYKE/CHnU
 orW0priFVq4o9aOrnTFqxAcS/YyK7+ZyJ5FLN2cvprmXj6KopkUyRHOmDj1ECNvwbE
 HVzzzn+ojV/+uMIzcOwxZqcOGpDH09Vw+J/lACd8g74rlaPsjewhs+tpUaJnY2KqZP
 5vc3xYxDmhsM9p16KfwVwdtgERfpuDsUed4+c+CdQrb7+uKbCsbLNODeFa2fzoS1oR
 sTAuGmEestNEQ==
Message-ID: <2fe93269-7373-46cb-95e0-383270ea67ac@denx.de>
Date: Sun, 3 Dec 2023 21:03:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common: usb-hub: Reset hub port before scanning
Content-Language: en-US
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
References: <20231110141311.512334-1-i@shantur.com>
 <a911092c-78e7-469b-abd8-2aeb9f7e28b7@denx.de>
 <CAHc5_t3ddCnKMBNbe8Cc=dZBXvxyke2p5ydU2dbt8Gt8RH43_w@mail.gmail.com>
 <14da0009-8819-4355-8a38-c9fe926ab3f7@denx.de>
 <CAHc5_t0-Mt+-9aBXnD0457YKRyJXHj3oYunq2c35ZaMbmQnqAw@mail.gmail.com>
 <3284f652-49dd-409f-9130-ad7cbce64b32@denx.de>
 <CAHc5_t3t7E+qZrv_KvNNwMDmD9+o+SX3jwv-wq-4gP3d17yBwg@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAHc5_t3t7E+qZrv_KvNNwMDmD9+o+SX3jwv-wq-4gP3d17yBwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11/24/23 01:37, Shantur Rathore wrote:
> Hi Marek,

Hi,

sorry for the late reply.

>>>>> In my case RockPro64, the power to usb ports onboard is controlled by
>>>>> a regulator.
>>>>> This regulator is enabled as part of init  as here
>>>>> https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/rk3399-rockpro64.dtsi#L177
>>>>>
>>>>> On init, the usb devices connected to the port are powered up, in my
>>>>> case AM8180 (a RTL9210 based ) NVMe to USB enclosure with UAS.
>>>>> But the usb controller is only enabled at 'usb start' and by this time
>>>>> the device is in some state that it doesn't get detected.
>>>>>
>>>>> One way to make sure the devices connected to the ports are in an
>>>>> initialising state is by issuing a port reset before scanning the
>>>>> port.
>>>>
>>>> Why not remove this regulator-always-on and let the PHY driver turn the
>>>> VBUS ON only when it is needed ?
>>>>
>>>> Wouldn't that solve the problem too AND remove unnecessarily enabled
>>>> regulator ?
>>>>
>>>> [...]
>>>
>>> Removing the regulator-always-on does make it work but there are few issues
>>>
>>> 1. regulator is used to control power to multiple ports ( USB3.0 and
>>> USB2.0 in RockPro64 ),
>>> so this could lead to all ports turning off if a phy resets / turns off power
>>
>> I vaguely recall seeing some refcounting patch for regulator subsystem,
>> would that help ?
> 
> I don't think this would be a problem for u-boot, but linux maybe.

How so ?

>>> 2. Even with regulator-always-on and without this reset port patch,
>>> linux was always
>>> able to detect the drive on the port, so there is something missing in u-boot.
>>> 3. Looking at usb hub code in Linux, I found that for USB3.0 it tries
>>> to reset the port before
>>> scanning. The comment says
>>>
>>> /* Is a USB 3.0 port in the Inactive or Compliance Mode state?
>>>    * Port warm reset is required to recover
>>>    */
>>>
>>> i. https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L5736
>>> ii. https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L2836
>>>
>>> I believe this isn't implemented in u-boot and hence explicit reset of
>>> a port fixes the issue.
>>
>> I feel this is separate issue and what needs to be fixed first is the
>> hard-wired VBus control.
> 
> I beg to differ on this, couple of reasons for this
> 
> 1. The same drive works fine without being reset on the USB2.0 ports - this
> confirms that the issue is related to USB3.0 only.

This is a separate issue from the hard-wired VBus control. I agree the 
issue does exist, I would simply like to avoid conflating the hard-wired 
VBus control with device reset.

> 2. Linux is able to detect the same drive on USB3.0 when u-boot fails - this
> confirms issue doesn't lie with regulator-always-on

See above

> 3. The links I pasted earlier mentions that in USB3.0 the ports need reset
> and this is done before the port is scanned. Adding the similar reset in u-boot
> fixes all with the same regulator-always-on. AFAIK u-boot doesn't handle
> this special USB3.0 case and maybe this is why I was finding a few posts
> around the drive not being detected in the USB3.0 port in u-boot but works in
> a USB2.0 port.

I am not disputing the need for USB 3.0 device reset, I believe there 
are two issues here -- one is the hard-wired VBus regulator -- the other 
is this USB 3.0 reset. They should both be fixed.
