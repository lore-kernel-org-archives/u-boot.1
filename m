Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6C1C5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 21:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DDF986FEF;
	Thu, 23 Nov 2023 22:07:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700773653;
	bh=5U8ixYdiWSXmTgz4QcyYzKQKlo1hIKgXMA9YdYqg3O4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cCSS0grG2vsdqtRYnHJ66zVsJChVv+CTyt6iEw8MQNc4S70U/wduNcVByVChKUBUd
	 sun8aQyhv5q0oB9seCFTPnFywYVTLF7HqaWsg4/eNwJQ0Fos2C+oSGq0qA0xJY72lU
	 PQPzp2TPgaQ+fJ9m+RhkQ+iFS/sDECxlWdsisDPLrpSKvUejhIS7mAs5qyxR4BHuvx
	 zqbu3M8YE5ypmk/ZtH4cK66HBcoPlYA1wDYBD1e0iBhslQpC/HSdA+MZj1/revAVyl
	 COFJabzlb7bdPXFQjsFnq7qyfA4j93pfq0atsxVbaeRL8FKt0/j91qyOe8QYIPOTSF
	 rtcgnYQ1JVSaw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E452A86E88;
 Thu, 23 Nov 2023 22:07:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700773652;
 bh=5U8ixYdiWSXmTgz4QcyYzKQKlo1hIKgXMA9YdYqg3O4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=S+HGycryfFoA72c+oq+RWNRm/2nUULLbCQsf5avdl4mCFyP7K8Wo8YEXOYfIFiNwZ
 Jqsd1BWTTek2bpBCX3zFPzpb1Mf1eXIEpLvfwJyRFoHUtlJDzGfJGihzjcWtYZro6T
 7GvVAKu9/WZTT60sPSwBYmmIZPIfYA4wXdUIoy58hgSl3/rdo9ThPYVJyrIWRBROXe
 vwSesdcWsU1P9EDlH9tBkRmtJ1l28X/g54y0GTtvmGUDNUxJ1iAOZLMZsbEOLTVzTN
 R2bdf+l+yjUA+uvt/Osp6rfkYJSpEZ48xLoScHuKOgoCiyCgyh5SL8ivSiuPsL09hD
 nRkSmXH8CTXEw==
Message-ID: <3284f652-49dd-409f-9130-ad7cbce64b32@denx.de>
Date: Thu, 23 Nov 2023 13:04:59 +0100
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
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAHc5_t0-Mt+-9aBXnD0457YKRyJXHj3oYunq2c35ZaMbmQnqAw@mail.gmail.com>
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

On 11/23/23 12:24, Shantur Rathore wrote:
> Hi Marek,
> 
> On Thu, Nov 23, 2023 at 12:06 AM Marek Vasut <marex@denx.de> wrote:
>>
>> On 11/20/23 00:03, Shantur Rathore wrote:
>>> Hi Marek,
>>
>> Hi,
>>
>>> On Sun, Nov 19, 2023 at 8:53 PM Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> On 11/10/23 15:13, Shantur Rathore wrote:
>>>>> Currently when a hub is turned on, all the ports are powered on.
>>>>> This works well for hubs which have individual power control.
>>>>>
>>>>> For the hubs without individual power control this has no effect.
>>>>
>>>> OK
>>>>
>>>>> Mostly in these scenarios the hub port is powered before the USB
>>>>> controller is enabled, this can lead to some devices in unexpected
>>>>> state.
>>>>
>>>> This ^ part needs clarification.
>>>>
>>>> Which devices are in incorrect state, the ones connected to the hub
>>>> downstream facing ports ?
>>>>
>>>
>>> In my case RockPro64, the power to usb ports onboard is controlled by
>>> a regulator.
>>> This regulator is enabled as part of init  as here
>>> https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/rk3399-rockpro64.dtsi#L177
>>>
>>> On init, the usb devices connected to the port are powered up, in my
>>> case AM8180 (a RTL9210 based ) NVMe to USB enclosure with UAS.
>>> But the usb controller is only enabled at 'usb start' and by this time
>>> the device is in some state that it doesn't get detected.
>>>
>>> One way to make sure the devices connected to the ports are in an
>>> initialising state is by issuing a port reset before scanning the
>>> port.
>>
>> Why not remove this regulator-always-on and let the PHY driver turn the
>> VBUS ON only when it is needed ?
>>
>> Wouldn't that solve the problem too AND remove unnecessarily enabled
>> regulator ?
>>
>> [...]
> 
> Removing the regulator-always-on does make it work but there are few issues
> 
> 1. regulator is used to control power to multiple ports ( USB3.0 and
> USB2.0 in RockPro64 ),
> so this could lead to all ports turning off if a phy resets / turns off power

I vaguely recall seeing some refcounting patch for regulator subsystem, 
would that help ?

> 2. Even with regulator-always-on and without this reset port patch,
> linux was always
> able to detect the drive on the port, so there is something missing in u-boot.
> 3. Looking at usb hub code in Linux, I found that for USB3.0 it tries
> to reset the port before
> scanning. The comment says
> 
> /* Is a USB 3.0 port in the Inactive or Compliance Mode state?
>   * Port warm reset is required to recover
>   */
> 
> i. https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L5736
> ii. https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L2836
> 
> I believe this isn't implemented in u-boot and hence explicit reset of
> a port fixes the issue.

I feel this is separate issue and what needs to be fixed first is the 
hard-wired VBus control.
