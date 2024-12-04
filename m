Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138E3E7716E
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 14:37:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 323B08943E;
	Wed,  4 Dec 2024 15:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZYQ9DI/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3173B8936B; Wed,  4 Dec 2024 15:37:04 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 191158943E
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 15:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B30225C6147;
 Wed,  4 Dec 2024 14:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DFEC4CECD;
 Wed,  4 Dec 2024 14:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733323019;
 bh=7y0krhgtpmy1Og8JBFqDNd6Rlbn1zacHJjqxcFmz3AQ=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=ZYQ9DI/8bQDHHNuHjVB06+v0pW+qMYvtdCSbTUwfd7pE7EBxEAaQWKJbFM+I39KhG
 D+VX7wBc3agAKChVhLLvuSkI5R2PQu/zbshUpl5KP3XW0EUmrQySq9wV1zB+YqiQXY
 X4JWO4IuIDcVcDEfvtm0pHCFqDc2xrAnaMSEAlf2mcnxF7cqviMeExwU8E5P6I2IAe
 Jae8W+j2p6Ic6FabFkDIfOP5cv6Nln/RyQlweihyXCiIyy+g6jP58C1afwTi8Lqzc+
 hcOHL4KH5ffvGa9TPGd+FXoeyLRMzSgEc5hJQnikMqv4/uzEuvmS4sU+4U5DkktA7d
 R9EbmAxtVn5Nw==
Message-ID: <97c32006-1607-45f8-a51b-a67892742f55@kernel.org>
Date: Wed, 4 Dec 2024 16:36:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH v2 1/2] usb: dwc3-generic: set "mode" based on caller of
 dwc3_generic_probe()
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: vigneshr@ti.com, bb@ti.com, trini@konsulko.com, marex@denx.de,
 hnagalla@ti.com, mkorpershoek@baylibre.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, jan.kiszka@siemens.com, j-humphreys@ti.com,
 nm@ti.com, u-boot@lists.denx.de, srk@ti.com
References: <20241203093748.138260-1-s-vadapalli@ti.com>
 <20241203093748.138260-2-s-vadapalli@ti.com>
 <9254b268-2336-48ca-91de-9da34a93b467@kernel.org>
 <6hohujytkznjcemgu2cjhk2x5pxw7euwzojbt6ktji2yp6zft2@i77rsmzwfgj5>
 <5bd5c98c-530b-4f05-9fbc-e2d867be920a@kernel.org>
 <dj32jyfvxsds6wsax4tk7kw75zfiutggd5gfbwpklym7gifjih@awk6aerfjwl2>
 <6b4cb5ed-3d19-4fb2-aba7-90f0a0f4f4f0@kernel.org>
 <4cgkdnpdn7j5tnfwvvskm3ltiqfnp5lx5gc5hwcrsljpg4bdin@hpkkswe4dej6>
 <9a69d8ae-221b-4d46-9b4c-7df0bd6fc0af@kernel.org>
 <ftdjegd5mctcn3ndvgrl4apyxkzms7hxivxlyjcrk4qrmvsx7r@og3t7eyyhmkt>
Content-Language: en-US
In-Reply-To: <ftdjegd5mctcn3ndvgrl4apyxkzms7hxivxlyjcrk4qrmvsx7r@og3t7eyyhmkt>
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



On 04/12/2024 15:37, Siddharth Vadapalli wrote:
> On Wed, Dec 04, 2024 at 02:34:56PM +0200, Roger Quadros wrote:
>>
>>
>> On 04/12/2024 12:05, Siddharth Vadapalli wrote:
> 
> [...]
> 
>>> Why not do what this patch does? What is the issue with the current
>>> patch (apart from the checks, which I could retain as well if others
>>> wish so)? The caller clearly mentions the expected role, so why not use
>>> that?
>>
>> Because the patch is more complicated than it needs to be, now that we know:
>> 1) generic_host_probe() will only be called when dr_mode is "host",
>> 2) generic_peripheral_probe() will only be called when dr_mode is "peripheral"
>> or "otg".
>>
>> The problem case is generic_peripheral_probe() being called with when
>> dr_mode is "otg".
> 
> We can also be sure that generic_periperhal_probe() expects dr_mode to
> be "peripheral" only and not "otg". So why not fix it at the root, which

generic_peripheral_probe() expects nothing from dr_mode.
It just expects the USB controller to work in peripheral mode.

dr_mode is just a reflection of platform/device-tree dr_mode. Let's keep it
that way and not abuse dr_mode to "peripheral" when it is actually "otg".

> is what this patch does? Independent of the issue, is the following a
> valid use-case?
> 
> generic_peripheral_probe() with plat->dr_mode = "otg" and hence
> generic_probe() using "otg" rather than "peripheral"

It is a valid use case. The Platform says that the port is "otg"
i.e. (plat->dr_mode ="otg")
and the user says he wants to use it as peripheral
i.e. (by invoking generic_peripheral_probe())
Don't you see this as valid.

> as is the case now. Is this resulting in something functional for other
> users of the USB Designware Controller? If the user requests "peripheral"
> mode of operation, will "otg" meet the user's requirement? If yes, I have
> no further objections. Irrespective of this, if you believe that the fix
> should be in the core as you indicated below, please feel free to post
> the patch.

Let's look at this from the other way around.
Why do you not agree that the fix should be in core.c and abusing dr_mode
is the correct way to go?

> 
>>
>> Another alternative could be to override dr_mode to "peripheral" if
>> it was "otg" in dwc3_generic_probe before calling dwc3_init() but
>> I don't prefer that as we are loosing platform information here
>> and it will have to be reverted when dual-role support is added in core.c.
>>
>> So better to deal with this in core.c and add a note why we are doing it.
>>
> 
> [...]
> 
> Regards,
> Siddharth.

-- 
cheers,
-roger

