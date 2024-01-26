Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056C0C47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 19:42:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6576887B84;
	Fri, 26 Jan 2024 20:42:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="oHwm+X64";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E93987B84; Fri, 26 Jan 2024 20:42:57 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7E588716D
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 20:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1706298174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=htpPMSZVHp9Lg/QnepriQCHgjL+6wFmGRYC6Bh89Xdk=;
 b=oHwm+X64Fakcf575QCWZCp8/6avrliVgfpnmMxbd91JuLHG3hjlrxWfxa6I38HJCsZ3gob
 DX+WGbkNhCr/yg8KbPq/hDeNuvordzkIWKdD0AgPQas6mnUF2VT9QUeBGvyQ7Ct/sWivZx
 5P1Ldrt+KVnJQO25y5sxXYUAATD1JRbVmbV0WT2KRsqvvTJb3U0ZPKHyXELacPmJR7VNLl
 CpldjRlKL/WNufqCyVHovzJk4sqDVC7szi7n2aFXXAGltns+OhMXJj73KMpGmayYEJbCVV
 D3l4WO9zN+2At7dtCa3NDonU2Lgjx2/te3YNmeQvUiW0FtXCfy9X59aM/3PdTA==
Date: Fri, 26 Jan 2024 20:42:51 +0100
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
In-Reply-To: <0e3cc574-23bc-4a0d-9f1b-421e5bce77b7@theobroma-systems.com>
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
 <4000d538ec88400f0ceaa9f13b6cd489@manjaro.org>
 <31404375-a811-459c-b9d6-87333550954a@theobroma-systems.com>
 <cd2927612a52bf88b7a2b2c937ccd62f@manjaro.org>
 <0e3cc574-23bc-4a0d-9f1b-421e5bce77b7@theobroma-systems.com>
Message-ID: <6812d339240107c1af5bbedd30c5dc61@manjaro.org>
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

On 2024-01-26 14:46, Quentin Schulz wrote:
> On 1/26/24 12:33, Dragan Simic wrote:
>> On 2024-01-26 12:29, Quentin Schulz wrote:
>>> On 1/26/24 12:24, Dragan Simic wrote:
>>>> On 2024-01-26 12:09, Quentin Schulz wrote:
>>>>> On 1/26/24 12:04, Dragan Simic wrote:
>>>>>> On 2024-01-26 11:37, Quentin Schulz wrote:
>>>>>>> On 1/26/24 03:57, Kever Yang wrote:
>>>>>>>> On 2024/1/25 19:02, Quentin Schulz wrote:
>>>>>>>>> We don't have a dedicated CD pin for the SD card connector.
>>>>>>>>> https://www.digikey.com/en/products/detail/molex/0472192001/3044807
>>>>>>>>> is the SD card connector we use.
>>>>>>>> 
>>>>>>>> Thanks for your information, but I think you are using the wrong
>>>>>>>> microSD connector for rk3588 and maybe also for other rockchip 
>>>>>>>> SoCs.
>>>>>>>> Here are four microSD card connector from the web you provide, 
>>>>>>>> all
>>>>>>>> of
>>>>>>>> them have card detect signal available for pcb:
>>>>>>>> https://www.digikey.com/en/product-highlight/m/molex-connector/sd-memory-card-connectors
>>>>>>> 
>>>>>>> None of those fit our requirements. We need a safe system that
>>>>>>> doesn't
>>>>>>> break because of vibrations or shocks. Push-pull connectors are 
>>>>>>> out
>>>>>>> of
>>>>>>> question for our design. We have had issues with our Q7 devkit 
>>>>>>> with
>>>>>>> push-pull connector with SD cards slightly smaller or inserted
>>>>>>> somewhat the wrong way. I can recall also countless of 
>>>>>>> discussions in
>>>>>>> the early days of the Raspberry Pis where there were a lot of 
>>>>>>> issues
>>>>>>> related to SD cards.
>>>>>>> 
>>>>>>> This is basically the mechanism we are using
>>>>>>> https://media.distrelec.com/Web/WebShopImages/landscape_large/4-/01/Molex-500901-0801-30161714-01.jpg
>>>>>> 
>>>>>> Please, allow me to interject...  I'm really curious why don't you
>>>>>> use eMMC chips instead of microSD cards?  I mean, if the 
>>>>>> reliability
>>>>>> is of utmost importance, I wouldn't even consider microSD cards, 
>>>>>> not
>>>>>> even the high-endurance variants.
>>>>> 
>>>>> We have both :)
>>>> 
>>>> Ah, I see. :)  Perhaps my question wasn't precise enough;  actually,
>>>> now I'd like to know what do you use as the primary storage for the
>>>> operating system installation -- eMMC chip or microSD cards?  Is the
>>>> eMMC chip soldered?  I'm just curious. :)
>>>> 
>>> Soldered eMMC is the primary (expected) storage. If both eMMC and SD
>>> card are inserted and properly flashed, it'll boot from eMMC except 
>>> if
>>> the BIOS button is pressed, in which case SD card will be selected
>>> instead. If SD card is missing/improperly flashed, it'll boot into 
>>> USB
>>> flashing mode (rkdeveloptool/rockusb) if the BIOS button is pressed
>>> (similar to when no storage media is properly flashed).
>> 
>> Thanks for the clarification.  Just one more question, please:  is the
>> BIOS button handled in software (i.e. in U-Boot), or does it disable 
>> the
>> eMMC chip by shorting its clock or a data line to ground?
> 
> None of those options :)
> 
> On RK3588, the boot media selection and order is done via the channel
> 0 of the SARADC. So a specific voltage is provided to boot from eMMC
> or from SD card.

Ah, it's nice to see that RK3588 feature actually used.  Thanks for
the clarification!
