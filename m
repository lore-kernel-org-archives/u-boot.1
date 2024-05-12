Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA353C25B4F
	for <u-boot@archiver.kernel.org>; Sun, 12 May 2024 19:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9AE387F69;
	Sun, 12 May 2024 21:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UM/m+67e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D1D8881A0; Sun, 12 May 2024 21:49:25 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76DC987E74
 for <u-boot@lists.denx.de>; Sun, 12 May 2024 21:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=knaerzche@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3504ad82a64so2071803f8f.3
 for <u-boot@lists.denx.de>; Sun, 12 May 2024 12:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715543363; x=1716148163; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RR37U3H9o0QJfqHPqHpbk3D2Ri1f0Ym6VbW+gWgmMXU=;
 b=UM/m+67e0aYI5b83Hpl9BrDL4BTGyRX6ZGvBYSykldL/uy5KHpxu2EfA34/J0YIZcD
 96O68sESexR1aB2ZGqMkwZ0308nhGHBpNIMWrB6zJg/YV2siOzPaYeqkr4EqtgcmmCxy
 tPLZCNknR2aSWA41SDjs58exHG5eCXqjXq5I/cPQv35pXCwnhIj2I/qnJVctmjDSEt4n
 zf390dcfqNbaumSl7T059eHbjIJjmCRBqiUyMYgn3ThQWTiZ7yX9hlp7Ohx3XZcn75xo
 AZhT1SyoODepqL8A/x3NIRCvx6pi9qzZKF0tuBbC5oVuCZkz30tnB0V64S47Qc4omsOJ
 IEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715543363; x=1716148163;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RR37U3H9o0QJfqHPqHpbk3D2Ri1f0Ym6VbW+gWgmMXU=;
 b=SLjYqxTo1rdpmdurkmRnPrqWFNyTkPAgE8O7jOhFlINfi9+TOGO8HKI+3S6F8WrGa1
 FACyrFRcmAofSmmxssUDR4vkAqxxXyN5LoFulDmlScU5xN2lOdo0Jt7ybiEgCYx376W4
 ND7aYuOry5eG9GWsi87UPeLo4XQ/GSzwe7eV21rsg7qlUQ+GPaswWiRyvGmGJY3+cbX/
 H6SdGu/f8KdoPTY+2Z8VfS9T/TNNv3trAUAyieAKiTor9QHqsAMIHoi1zVjKVv3gPeHJ
 fCR/B8AApzbZ811XaKC48doviLnaZT+jESoeiZJYoMDbs9X4lRIYLk4m0OLGqaV11NMT
 ULzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW31xzn6VOJXAiBVzesf04M00YsQgR7gDQyrHzESTunDbdS0LM8B7OhWtdveDnlTJtXqAHh9HrjTNDJiCP40I3VOXJK5g==
X-Gm-Message-State: AOJu0Yx7W0Oqe+LPKGu4kYOUL46nlyqfcpuhIumrhb0qR2GNC98ncF0H
 IIB5eUecY6+UBH71LipTqk+N67M9LPNFhk1+2rbMgI5lwcDnCV2Bw4aA
X-Google-Smtp-Source: AGHT+IF0bcuwss8J/aeNQ/y8Hz5qW9k/OSIXEVwJraxvmY7G177zKNojnj59Pd6BzIlqzcOU8QP2cA==
X-Received: by 2002:adf:f746:0:b0:34d:a9d0:5638 with SMTP id
 ffacd0b85a97d-3504a737cf6mr5297183f8f.37.1715543362680; 
 Sun, 12 May 2024 12:49:22 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:7247:7294:2ac1:67c9?
 ([2a02:810b:f40:4600:7247:7294:2ac1:67c9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b8a7907sm9416202f8f.63.2024.05.12.12.49.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 May 2024 12:49:22 -0700 (PDT)
Message-ID: <1b3b8c24-a3d9-4c36-a72f-45baee63f385@gmail.com>
Date: Sun, 12 May 2024 21:49:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] rockchip: Add gpio request() ops and drop PCIe
 reset-gpios workaround
To: Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Johan Jonker <jbx6244@gmail.com>, u-boot@lists.denx.de
References: <20240511112821.1156519-1-jonas@kwiboo.se>
 <0e701fd8-b2c6-4ac4-9427-d984032470d1@gmail.com>
 <6853e5ac-271f-4d19-b8fb-a2746b834b24@kwiboo.se>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <6853e5ac-271f-4d19-b8fb-a2746b834b24@kwiboo.se>
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


Am 11.05.24 um 20:47 schrieb Jonas Karlman:
> Hi Alex,
>
> On 2024-05-11 19:44, Alex Bee wrote:
>> Hi Jonas,
>>
>> Am 11.05.24 um 13:28 schrieb Jonas Karlman:
>>> This series add gpio request() and pinctrl gpio_request_enable() ops so
>>> that a gpio requested pin automatically use gpio pinmux and U-Boot
>>> behaves more similar to Linux kernel.
>> I'm not sure that's a good idea.
>> While linux does it the same way, we really shouldn't expect every
>> software/os/ … which uses DT (now or in future) to implicitly switch the
>> pin function when using a pin as gpio. So the real fix would probably be
>> to add the the correct pinctrl settings to the upstream DT of those
>> boards and sync it later on (not sure those if those SoCs already using
>> OF_UPSTREAM) and leave the -u-boot.dtsi-"hack" alone for now.
> I fully agree that the pinctrl for the problematic boards should be
> corrected in upstream DT, but that is a separate issue and should not
> block adding support for the request()/gpio_request_enable() ops.
>
> While the pcie reset-gpios full board freeze that was my driving factor
> to fully implement the gpio request() ops it is not the only use case,
> using the gpio cmd on a pin that use a non-gpio pinmux is another.
>
> Or do you see any technical issue with having the gpio request() ops
> implemented and having it ensure gpio pinmux is used on a gpio requested
> pin? Similar to how gpio/pinctrl is behaving in Linux and on some other
> platforms in U-Boot?
No, no general ("technical") issue with adding a .request hook to the gpio
driver. But now you are now moving the original workaround to an even more
invisible place which does things implicitly. Maybe just don't remove the
pinctrl from the boards u-boot-dtsi's - just replace it with

&pcie30x2m1_pins {
     rockchip,pins =
              <2 RK_PD4 4 &pcfg_pull_none>,
              <2 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>,
              <2 RK_PD5 4 &pcfg_pull_none>;
};

Even if it would (now) work without. It, at least, documents that there are
things left to do for the upstream DT.

What you were saying in reply to Mark's email is not completely true: Not
all pins are initialized with gpio func as default. It actually depends on
the pin which function the bootrom sets initially. In case of RK356x's
GPIO2_PD6 (the pin in question) it's BT656_D6M0 (func2), for instance. So,
in fact, you are changing it's function when implicitly setting it's func
to gpio (func0).

Alex

>
> Regards,
> Jonas
>
>> Alex
>>> With the gpio and pinctrl ops implemented this series also remove a PCIe
>>> reset-gpios related device lock-up workaround from board u-boot.dtsi.
>>>
>>> PX30, RK3066, RK3188, RK356x and RK3588 are the only SoCs that currently
>>> define gpio-ranges props and is affected by this series.
>>>
>>> A follow up series adding support for the pinmux status cmd will also
>>> add gpio-ranges props for remaining RK SoCs.
>>>
>>> Jonas Karlman (4):
>>>     pinctrl: rockchip: Add gpio_request_enable() ops
>>>     gpio: rockchip: Add request() ops
>>>     rockchip: rk3568-rock-3a: Drop PCIe reset-gpios workaround
>>>     rockchip: rk3568-radxa-e25: Drop PCIe reset-gpios workaround
>>>
>>>    arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi     | 12 -------
>>>    arch/arm/dts/rk3568-rock-3a-u-boot.dtsi       | 12 -------
>>>    drivers/gpio/rk_gpio.c                        | 10 ++++++
>>>    .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 31 +++++++++++++++++++
>>>    4 files changed, 41 insertions(+), 24 deletions(-)
>>>
