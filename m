Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CF8C47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 11:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1D1C87B8C;
	Fri, 26 Jan 2024 12:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="tfjHwte3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DE3787BBC; Fri, 26 Jan 2024 12:24:15 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E35B787B6C
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 12:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1706268252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LTaDLEJ8CT9z8b0WD4k4pEVAKquv4nJpt4nKBkqjXbg=;
 b=tfjHwte3xZifkwU3Vu9f55JosqI027a4NqJwU6UGzjzg5fuCKyolDYIKH8GVpGCBwflrpV
 5yTcLo5TTDdIBEFZIaVyqsipGQrhKfCg0tgWtuJQuZnQHZLlZj05rvQE5XjupCKVnA1fqr
 igHqXR/I2WoqQljbA7uGmkszetJOKeHSpKeHBnKH8R16mS0o12OWwmH/N1WuKS57gmqpLw
 lOKOeudQCqLtvsGpGwsxyHoKVgHKV0aCbAmjLClYPyJiroShvbamfnENuQukZJXBVDgDdT
 hwfEhrzobGo0jjNNr+/6sZmPzUDXmZ0JfhwJm0i/0r6bzA3400k0XRyAGnnlvg==
Date: Fri, 26 Jan 2024 12:24:11 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz
 <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, =?UTF-8?Q?=E6=B4=AA=E6=85=A7=E6=96=8C?=
 <hhb@rock-chips.com>, heiko@sntech.de, u-boot@lists.denx.de
Subject: Re: [PATCH 13/18] rockchip: rk3588: fix non-working SD controller if
 booting from other media
In-Reply-To: <daf26efb-888c-4903-b8b1-c6d72556fe9c@theobroma-systems.com>
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-13-1eec1c34953c@theobroma-systems.com>
 <10ebfefd-1619-4b08-b15d-ec8ca8e798f3@rock-chips.com>
 <c33d0c58-cd95-490f-9514-8d61e1e70925@theobroma-systems.com>
 <31e7cb6e-7ef1-4069-a38e-b61677a8d76e@rock-chips.com>
 <2f6e9491-9ae1-498c-b269-c0a8fbe27552@theobroma-systems.com>
 <609c74a8-80b0-48a2-ae0a-78264014accd@rock-chips.com>
 <82b8fd76-8a84-4253-93b0-bf1bde85121b@theobroma-systems.com>
 <0a9a81f47864fd566206f5e62c3df192@manjaro.org>
 <daf26efb-888c-4903-b8b1-c6d72556fe9c@theobroma-systems.com>
Message-ID: <4000d538ec88400f0ceaa9f13b6cd489@manjaro.org>
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

On 2024-01-26 12:09, Quentin Schulz wrote:
> On 1/26/24 12:04, Dragan Simic wrote:
>> On 2024-01-26 11:37, Quentin Schulz wrote:
>>> On 1/26/24 03:57, Kever Yang wrote:
>>>> On 2024/1/25 19:02, Quentin Schulz wrote:
>>>>> We don't have a dedicated CD pin for the SD card connector.
>>>>> https://www.digikey.com/en/products/detail/molex/0472192001/3044807
>>>>> is the SD card connector we use.
>>>> 
>>>> Thanks for your information, but I think you are using the wrong
>>>> microSD connector for rk3588 and maybe also for other rockchip SoCs.
>>>> Here are four microSD card connector from the web you provide, all 
>>>> of
>>>> them have card detect signal available for pcb:
>>>> https://www.digikey.com/en/product-highlight/m/molex-connector/sd-memory-card-connectors
>>> 
>>> None of those fit our requirements. We need a safe system that 
>>> doesn't
>>> break because of vibrations or shocks. Push-pull connectors are out 
>>> of
>>> question for our design. We have had issues with our Q7 devkit with
>>> push-pull connector with SD cards slightly smaller or inserted
>>> somewhat the wrong way. I can recall also countless of discussions in
>>> the early days of the Raspberry Pis where there were a lot of issues
>>> related to SD cards.
>>> 
>>> This is basically the mechanism we are using
>>> https://media.distrelec.com/Web/WebShopImages/landscape_large/4-/01/Molex-500901-0801-30161714-01.jpg
>> 
>> Please, allow me to interject...  I'm really curious why don't you
>> use eMMC chips instead of microSD cards?  I mean, if the reliability
>> is of utmost importance, I wouldn't even consider microSD cards, not
>> even the high-endurance variants.
> 
> We have both :)

Ah, I see. :)  Perhaps my question wasn't precise enough;  actually,
now I'd like to know what do you use as the primary storage for the
operating system installation -- eMMC chip or microSD cards?  Is the
eMMC chip soldered?  I'm just curious. :)

> Just to name one potential use-case, you may want to save some data on
> SD card for investigation without the need for the system to run to
> dump data from the eMMC. It's there anyway, so now my job as a SW guy
> is to support it :)

Sure, it needs to be supported, no matter what.  The microSD slot is
presumably there to be used as the secondary storage, or to perform
operating system rescue, debugging and similar operations, as needed.
