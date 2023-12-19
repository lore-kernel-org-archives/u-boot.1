Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80518C46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5D53871C3;
	Tue, 19 Dec 2023 17:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rBTWxWyA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 417DF87480; Tue, 19 Dec 2023 17:26:48 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21AB68700D
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40d2376db79so9062705e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703003202; x=1703608002; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jsoZBfcs+n6fUiFGkuTmOswDj115FrMNLufruw5pQLA=;
 b=rBTWxWyA1D2+C/JEQidteD9V33mE/luTxVwOg57n30lQVWC21s3dA2Ibce1hD19kDn
 ujZQziSMo6YC0D4FjwepfqFgx2unL3QxC9rqJObkJrHVIaLtP1M2+COz4IcZJxaLJDRV
 d9h0utWAiRE03CtnbxlJNkusv7Vl3SnRVS+mSHBotIL/g5bFJG7faGCnLlAqOYRllhjO
 wFMHDHdH7LOaeLKFinHVd2kM7Zv8URuO+eOvi4rumX7XMymYqrXFS0L+ZNbtGf6WyGBS
 VLhh93O4SHx/zBZ6NqvYkxbj2fkj8qLAMLZTrLTU55ICEIMiuxAOQAyobeuaQVWrEokN
 YfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703003202; x=1703608002;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jsoZBfcs+n6fUiFGkuTmOswDj115FrMNLufruw5pQLA=;
 b=EqpnTAYCxlphmMDY5JS76CthqzstwWppHbHS2s1e4KHbRjMTSbpyHH50P6SXxbvH+p
 4DEGjcH0JQPRHxnFazPhV//Nm0566edY2phBsSf84PGtKUsVffeqPjMhdJYPl69XVq8t
 ltAEua32FunnrE6mQQza+LeEo61NQdVTEJziI+GY8YQa/UhQaISdDi+c5AW+M6SZzHEy
 A9FjVzAQQckkerZf1s2+x5/04Yx3a7EbBbYCavymKMeeKXBQfEI6j8MzkMNRtffI5lpG
 R9rMmXr6zSVm2lidlnFVakH+spHgbIQI5RyM+t+tPLV7uxLRxBJPwmTxfkL95z1JP6wG
 n9ng==
X-Gm-Message-State: AOJu0YzcsyxDuk9lon7dOw/P+FdFbNDIl4BwG6+MTQE9HlOxQGhDDrNU
 r9tDEIUqEHV/Clr/v1IesfyRr1tr9RAH9qXaSGor+A==
X-Google-Smtp-Source: AGHT+IH2Bmr5i307GD0xSa1dBcW/s3LgZgCbyWRGyub6VHHuQoNaqNkEh+bix0t5NP3D9rR3nk08RQ==
X-Received: by 2002:a05:600c:1f8e:b0:40c:6138:9815 with SMTP id
 je14-20020a05600c1f8e00b0040c61389815mr5681192wmb.105.1703003202499; 
 Tue, 19 Dec 2023 08:26:42 -0800 (PST)
Received: from [192.168.1.83] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 iv13-20020a05600c548d00b0040d30af488asm305602wmb.40.2023.12.19.08.26.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 08:26:42 -0800 (PST)
Message-ID: <65d0c4d7-ba69-4cf8-ae8e-89787f2aa009@linaro.org>
Date: Tue, 19 Dec 2023 16:26:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Add SE HMBSC board support
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, lukma@denx.de,
 seanga2@gmail.com, marex@denx.de, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org
References: <20231218072428.1802969-1-sumit.garg@linaro.org>
 <CAPnjgZ2rYujD-yb=Zgz=bxe8iS3MGSdrL9KfVsDqz8R_H+FVfA@mail.gmail.com>
 <CAFA6WYOkQ6-jq2LkF=x36mdX+v3CX71zwn7VpUeczF885RBDaA@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYOkQ6-jq2LkF=x36mdX+v3CX71zwn7VpUeczF885RBDaA@mail.gmail.com>
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



On 19/12/2023 06:25, Sumit Garg wrote:
> Hi Simon,
> 
> On Mon, 18 Dec 2023 at 20:32, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Sumit,
>>
>> On Mon, 18 Dec 2023 at 00:24, Sumit Garg <sumit.garg@linaro.org> wrote:
>>>
>>> SE HMIBSC board is based on Qcom APQ8016 SoC. One of the major
>>
>> Could you please add a doc/ file for this board and explain how to
>> build it and how to run U-Boot on it?
> 
> Ah I forgot to add that since the build/boot instructions are quite
> similar to db410c. BTW, I will add that in the next spin.

Probably just referencing that document or making the language generic
would be good.

Sumit, could you rebase this series on my generic board support? [1] in
it's current form this series conflicts, and includes some of the major
anti-patterns I'm trying to move away from in mach-snapdragon.

You should not have to introduce a new CONFIG_TARGET_XYZ variable, and
from what I can tell you shouldn't even need to add the board/schneider
directory at all, you can just set the following in your defconfig:

CONFIG_SYS_BOARD="dragonboard410c"
CONFIG_SYS_CONFIG_NAME="hmibsc"

This will use the db410c board code (which yours is just a copy/paste of
from what I can tell) and your custom include/configs/hmibsc.h header.

The addresses set in your environment file should be allocated
automatically at runtime too (see the ("mach-snapdragon: dynamic load
addresses") patch).

You should also switch to an upstream board DTS based on my series, and
drop the "-uboot.dtsi" file.

[1]:
https://lore.kernel.org/u-boot/20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org/

Kind regards,

> 
> -Sumit
> 
>>
>>> difference from db410c is serial port where HMIBSC board uses UART1 as
>>> the debug console with an RS232 port, patch #1 - #3 adds corresponding
>>> driver support.
>>>
>>> Patch #4 adds main HMIBSC board specific bits, features:
>>> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
>>> - 2GiB RAM
>>> - 64GiB eMMC, SD slot
>>> - WiFi and Bluetooth
>>> - 2x Host, 1x Device USB port
>>> - HDMI
>>> - Discrete TPM2 chip over SPI
>>>
>>> Patch #5 - #7 enables specific board features like RAUC support,
>>> environment protection and USB networking support.
>>>
>>> This patch series is based on top of Qcom maintainer tree [1] + the latest
>>> PMIC patch-set [2]. Feedback is very much welcome.
>>>
>>> [1] https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/u-boot-qcom-next?ref_type=heads
>>> [2] https://patchwork.ozlabs.org/project/uboot/list/?series=385322
>>>
>>> Sumit Garg (7):
>>>   clk: apq8016: Add support for UART1 clocks
>>>   serial_msm: Add support for RS232 GPIOs
>>>   serial_msm: Enable RS232 flow control
>>>   board: Add SE HMIBSC board support
>>>   hmibsc: Enable RAUC support
>>>   hmibsc: enable U-Boot Environment variables protection
>>>   hmibsc: Enable LAN75XX USB ethernet driver
>>>
>>>  arch/arm/dts/Makefile              |   1 +
>>>  arch/arm/dts/hmibsc-uboot.dtsi     |  43 +++++++
>>>  arch/arm/dts/hmibsc.dts            | 188 +++++++++++++++++++++++++++++
>>>  arch/arm/mach-snapdragon/Kconfig   |  18 +++
>>>  arch/arm/mach-snapdragon/Makefile  |   1 +
>>>  board/schneider/hmibsc/Kconfig     |  15 +++
>>>  board/schneider/hmibsc/MAINTAINERS |   6 +
>>>  board/schneider/hmibsc/Makefile    |   5 +
>>>  board/schneider/hmibsc/hmibsc.c    | 179 +++++++++++++++++++++++++++
>>>  board/schneider/hmibsc/hmibsc.env  |  11 ++
>>>  configs/hmibsc_defconfig           |  79 ++++++++++++
>>>  drivers/clk/qcom/clock-apq8016.c   |  44 ++++++-
>>>  drivers/serial/serial_msm.c        |  23 +++-
>>>  drivers/usb/host/Kconfig           |   1 +
>>>  include/configs/hmibsc.h           |  59 +++++++++
>>>  15 files changed, 665 insertions(+), 8 deletions(-)
>>>  create mode 100644 arch/arm/dts/hmibsc-uboot.dtsi
>>>  create mode 100644 arch/arm/dts/hmibsc.dts
>>>  create mode 100644 board/schneider/hmibsc/Kconfig
>>>  create mode 100644 board/schneider/hmibsc/MAINTAINERS
>>>  create mode 100644 board/schneider/hmibsc/Makefile
>>>  create mode 100644 board/schneider/hmibsc/hmibsc.c
>>>  create mode 100644 board/schneider/hmibsc/hmibsc.env
>>>  create mode 100644 configs/hmibsc_defconfig
>>>  create mode 100644 include/configs/hmibsc.h
>>>
>>> --
>>> 2.34.1
>>>
>>
>> Regards,
>> Simon

-- 
// Caleb (they/them)
