Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A0FE7716F
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 22:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 993E389410;
	Wed,  4 Dec 2024 23:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZuQ029oH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2BF48935F; Wed,  4 Dec 2024 23:16:27 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C89CB89410
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 23:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B4D97A41384;
 Wed,  4 Dec 2024 22:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A72C4CECD;
 Wed,  4 Dec 2024 22:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733350583;
 bh=qcUPn9awIsluguI5b4a0vXOpcH489RjNP5p0wxHqGvQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZuQ029oHGNiRs+lCt0vhW2xY1lHB0IOwbeue27f13oImXnqzSuildGFt7kDsDtFza
 9X9Rpa78iW4CvjDc+Z/8D8vkC9E+QdzLkiShn1ykrgwwgKA3pjTQEPm0ngXAETf7Bo
 +SN+ZQDhotshbDKP3IPE1V/lLicx3KCPJfHV/2OJtBsk7Xydjq+JqSHLfUkLlhZ9yb
 g/QDDaU2ZA6792MPeCH3JjjttbaKzF0sU0vF1oU6bLPiwJ2ZNXovAleaD1+f4cIg7i
 fKA1pQSimxsiCJg3PpuFdxoxr0gi0SqgrxPa1q6iTVkfY+EWNcw+KWmq52ZfcohuNd
 lXvVyh0ytcs9A==
Message-ID: <62a6efb5-4837-482b-987b-7758a943ba7a@kernel.org>
Date: Thu, 5 Dec 2024 00:16:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] usb: dwc3-generic: set "mode" based on caller of
 dwc3_generic_probe()
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: vigneshr@ti.com, bb@ti.com, trini@konsulko.com, marex@denx.de,
 hnagalla@ti.com, mkorpershoek@baylibre.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, jan.kiszka@siemens.com, j-humphreys@ti.com,
 nm@ti.com, u-boot@lists.denx.de, srk@ti.com
References: <20241203093748.138260-2-s-vadapalli@ti.com>
 <9254b268-2336-48ca-91de-9da34a93b467@kernel.org>
 <6hohujytkznjcemgu2cjhk2x5pxw7euwzojbt6ktji2yp6zft2@i77rsmzwfgj5>
 <5bd5c98c-530b-4f05-9fbc-e2d867be920a@kernel.org>
 <dj32jyfvxsds6wsax4tk7kw75zfiutggd5gfbwpklym7gifjih@awk6aerfjwl2>
 <6b4cb5ed-3d19-4fb2-aba7-90f0a0f4f4f0@kernel.org>
 <4cgkdnpdn7j5tnfwvvskm3ltiqfnp5lx5gc5hwcrsljpg4bdin@hpkkswe4dej6>
 <9a69d8ae-221b-4d46-9b4c-7df0bd6fc0af@kernel.org>
 <ftdjegd5mctcn3ndvgrl4apyxkzms7hxivxlyjcrk4qrmvsx7r@og3t7eyyhmkt>
 <97c32006-1607-45f8-a51b-a67892742f55@kernel.org>
 <qf4urghmxyaxjzeurgtsiry625ibwcdspqx3v6fyfg6cek2cgo@txc6qzsw34pg>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <qf4urghmxyaxjzeurgtsiry625ibwcdspqx3v6fyfg6cek2cgo@txc6qzsw34pg>
Content-Type: text/plain; charset=UTF-8
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



On 04/12/2024 17:00, Siddharth Vadapalli wrote:
> On Wed, Dec 04, 2024 at 04:36:53PM +0200, Roger Quadros wrote:
>>
>>
>> On 04/12/2024 15:37, Siddharth Vadapalli wrote:
>>> On Wed, Dec 04, 2024 at 02:34:56PM +0200, Roger Quadros wrote:
>>>>
>>>>
>>>> On 04/12/2024 12:05, Siddharth Vadapalli wrote:
>>>
>>> [...]
>>>
>>>>> Why not do what this patch does? What is the issue with the current
>>>>> patch (apart from the checks, which I could retain as well if others
>>>>> wish so)? The caller clearly mentions the expected role, so why not use
>>>>> that?
>>>>
>>>> Because the patch is more complicated than it needs to be, now that we know:
>>>> 1) generic_host_probe() will only be called when dr_mode is "host",
>>>> 2) generic_peripheral_probe() will only be called when dr_mode is "peripheral"
>>>> or "otg".
>>>>
>>>> The problem case is generic_peripheral_probe() being called with when
>>>> dr_mode is "otg".
>>>
>>> We can also be sure that generic_periperhal_probe() expects dr_mode to
>>> be "peripheral" only and not "otg". So why not fix it at the root, which
>>
>> generic_peripheral_probe() expects nothing from dr_mode.
>> It just expects the USB controller to work in peripheral mode.
> 
> Yes. So configuring the USB controller for peripheral mode of operation
> should be fine, in which case, irrespective of what "dr_mode" says,
> using "peripheral" should enable the desired functionality.
> 
>>
>> dr_mode is just a reflection of platform/device-tree dr_mode. Let's keep it
>> that way and not abuse dr_mode to "peripheral" when it is actually "otg".
> 
> I am not asking to change what the device-tree has. I am asking the need
> to use "otg" as specified in the device-tree when in U-Boot, we cannot
> switch between Host and Peripheral dynamically using "otg". At the end
> of the day, there is no "generic_otg_probe()" which could enable such
> functionality. So I fail to understand why configuring the controller
> for "peripheral" mode as requested by "generic_peripheral_probe()" is
> equivalent to abusing the device-tree.
> 
>>
>>> is what this patch does? Independent of the issue, is the following a
>>> valid use-case?
>>>
>>> generic_peripheral_probe() with plat->dr_mode = "otg" and hence
>>> generic_probe() using "otg" rather than "peripheral"
>>
>> It is a valid use case. The Platform says that the port is "otg"
>> i.e. (plat->dr_mode ="otg")
>> and the user says he wants to use it as peripheral
>> i.e. (by invoking generic_peripheral_probe())
>> Don't you see this as valid.
> 
> Does peripheral mode work when user sets "otg" in the device-tree?
> Clearly it doesn't and hence this patch. Linux supports "otg" mode in
> the sense that we can switch between "host" and "peripheral". U-Boot on
> the other hand cannot even enable "peripheral" functionality when
> dr_mode is "otg" in the device-tree, let alone switching roles.
> 
>>
>>> as is the case now. Is this resulting in something functional for other
>>> users of the USB Designware Controller? If the user requests "peripheral"
>>> mode of operation, will "otg" meet the user's requirement? If yes, I have
>>> no further objections. Irrespective of this, if you believe that the fix
>>> should be in the core as you indicated below, please feel free to post
>>> the patch.
>>
>> Let's look at this from the other way around.
>> Why do you not agree that the fix should be in core.c and abusing dr_mode
>> is the correct way to go?
> 
> Isn't "otg" meant to convey that the role isn't fixed and can be
> switched? So how is hard-coding it to "peripheral", not considered as
> abusing the core? I don't intend to argue any further. I probably
> shouldn't have looked at other discussions on the mailing list regarding
> hard-coding "otg" as "peripheral" being incorrect. I should have simply
> posted the PRTCAPDIR fix in the core, instead of trying to come up with
> an acceptable fix. It is only because I felt that it didn't seem acceptable
> that I spent time finding out this inconsistency in "dwc3_generic_probe"
> where configuring the controller for "otg" mode as indicated by
> plat->dr_mode when the caller is "generic_peripheral_probe()" is somehow
> supposed to work in U-Boot where there is no OTG state machine.
> 
> If the fix in the core is the right way to go, please post the patch. I
> only wanted to make USB DFU boot functional on AM62A and didn't want to
> end up in an argument while doing so.

Sorry if you took this as an argument. I was only weighing in if there were
better alternatives.
If we have to go with your solution then your v1 series is better
than v2. I will give my Reviewed-by: there.

-- 
cheers,
-roger

