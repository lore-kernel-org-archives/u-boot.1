Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643FAC61D99
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 00:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8C72875BE;
	Thu, 23 Nov 2023 01:06:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700697972;
	bh=3JNDPi+LC4yeyxiKMoD2tVNLWMQ4iaj6ALf/fjDMcEA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iYl99iV6tLedFoqecjEqhO6PA9rdaskiwh4Tj/L8QoEC89yDtjcV8Qj76/em6N0iB
	 bZwnoJKpq8u1wv3WJ6sv5jRVW56UwY/BokdP/JeRvg6D+ZkAc/1j1e4YMJXLtiCF6U
	 Y77SgVQLIUUJq09fb95pPVPwoILkaR6gD9TsCAmvmS/AkI4rHm2DEvl47+ZulRtN9H
	 aJUUGtJkaovzcImEJ+D0WIFG9WVuImpmz165903dZX+XT+CwICLwq+sGj7HFpsXXZa
	 fBQvCQ4RrSuqFjjDgM0PjMvZTfGdHv5xm4IY+PShaxwzEjJqTgD7sNiuiFtkPAAm2Q
	 W9HJbCvz6c0+w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D3628870BC;
 Thu, 23 Nov 2023 01:06:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700697970;
 bh=3JNDPi+LC4yeyxiKMoD2tVNLWMQ4iaj6ALf/fjDMcEA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=wKT4Tw77tD4Lkp+MBkm4wdKrCrcKuOBGal9l4NXW6fmalFPITU/INZs3Usn8G8ug4
 OS7ft/XlJ3oArIzYnSlF5db0mL+Gazm1hy9ur608lAPTG6Sq6PQPADC5HIPjfr3lUp
 6SDkTeDQbajvEYe+EhMMG8K69mEMZty+8TQzQ5MIAzvCRrEo0jN+Yqr51nWxtvDR9P
 MxehjWVG3GVQmVSz6UydQmmp5naOshS1gtURXyszdssu8W1AgymQnfbMFwBgl46s6o
 zsCPDuG5fbvhMGROnoiUgesQIr+FfRmU8GFmeYwOjGD555cQ9TPcde2hMkpmB8AhfA
 ALLzz+i5/kqAQ==
Message-ID: <14da0009-8819-4355-8a38-c9fe926ab3f7@denx.de>
Date: Thu, 23 Nov 2023 01:06:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common: usb-hub: Reset hub port before scanning
Content-Language: en-US
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>
References: <20231110141311.512334-1-i@shantur.com>
 <a911092c-78e7-469b-abd8-2aeb9f7e28b7@denx.de>
 <CAHc5_t3ddCnKMBNbe8Cc=dZBXvxyke2p5ydU2dbt8Gt8RH43_w@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAHc5_t3ddCnKMBNbe8Cc=dZBXvxyke2p5ydU2dbt8Gt8RH43_w@mail.gmail.com>
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

On 11/20/23 00:03, Shantur Rathore wrote:
> Hi Marek,

Hi,

> On Sun, Nov 19, 2023 at 8:53 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 11/10/23 15:13, Shantur Rathore wrote:
>>> Currently when a hub is turned on, all the ports are powered on.
>>> This works well for hubs which have individual power control.
>>>
>>> For the hubs without individual power control this has no effect.
>>
>> OK
>>
>>> Mostly in these scenarios the hub port is powered before the USB
>>> controller is enabled, this can lead to some devices in unexpected
>>> state.
>>
>> This ^ part needs clarification.
>>
>> Which devices are in incorrect state, the ones connected to the hub
>> downstream facing ports ?
>>
> 
> In my case RockPro64, the power to usb ports onboard is controlled by
> a regulator.
> This regulator is enabled as part of init  as here
> https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/rk3399-rockpro64.dtsi#L177
> 
> On init, the usb devices connected to the port are powered up, in my
> case AM8180 (a RTL9210 based ) NVMe to USB enclosure with UAS.
> But the usb controller is only enabled at 'usb start' and by this time
> the device is in some state that it doesn't get detected.
> 
> One way to make sure the devices connected to the ports are in an
> initialising state is by issuing a port reset before scanning the
> port.

Why not remove this regulator-always-on and let the PHY driver turn the 
VBUS ON only when it is needed ?

Wouldn't that solve the problem too AND remove unnecessarily enabled 
regulator ?

[...]
