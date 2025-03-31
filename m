Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92906C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 09:39:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABAC08171B;
	Mon, 31 Mar 2025 11:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q/ng8hdV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F505817C4; Mon, 31 Mar 2025 11:39:47 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBEC7812BC
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 11:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso43048545e9.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 02:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743413984; x=1744018784;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zBRpZ6lfqYLSVmRjjvix5xW3fuQPQR05MoCZLEEtk3Y=;
 b=Q/ng8hdVx7mV6am5bJgeigW6qMJBcYapqY4Xe1PA5N4Em/gnJ9++v4KtxcyP+Qbe6X
 YxsHwDvfxtAZw1dw0YbWCKp0Z5G7udkRaUbE9JTOre4jHUWG5LELwWJ7ewaXeYOPhjNy
 kdam5oV2HEeA8XPMoQ/3QLEl3TyOxLroQ3jW9M0Pbp5TPU59q/coNc2MzN6Ob3SdsWso
 8BBWmZ049mwxxzzU5bOA3hivdfq9qT4Snjfdmh04T906f2UiryqS8xm1/7u4dZIf64tp
 18gL6Y/z1tRk8U2P92DQ1UY2e8ky/X84Nk/bZISyr3/dj7vs/M16AbeRL5kM1dqer0pI
 cHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743413984; x=1744018784;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zBRpZ6lfqYLSVmRjjvix5xW3fuQPQR05MoCZLEEtk3Y=;
 b=jyrBZQJgOKru3kfVaElhooeT0/vY5c/iP7TLdiFI3F2fP5X/J7rsE72KBI6qrjG94R
 IMge3aVViPxkHNdp/+iPchxYqn/gpu/luq82cV1R7P/QyGvu1YZmiwtfDz57j2lurCW5
 jhJgrMbYtSLvmLiuUPg0Ff0o5S2IREsGUqc8SNLRa8SmW9+XfSmPMIaR0KIzlxYfeRcg
 Rvh+k3bLs0+BmC2V/QgqdTYzCDUoxyR63+et/wMi9fQ8lFSpyofIu44hjtpb0TdtgZ/P
 GSGmsQzOKEaNdtOdLtPO55kqgr9Yl4NP2wBVNMYw+n38lHdWpUleqVMYhvPQhjnAg1TF
 JY9w==
X-Gm-Message-State: AOJu0YxhdeeScfiYw+VJBT+B8Hede1dynZQaOHtN1H6V1CXHllmEVUvr
 NFW6ceXFbbIfyDIgwFp4PNWcmsmKHlDKNzV8CulaGrFmTc63/Y6ddqsjMFccfy0=
X-Gm-Gg: ASbGncun6ZbCJA2p1dtG73/xxnJBxPxiVxlPc1bb+dLkNgKjKI09TG5tXBs84nryOvA
 kMfb9lsx8IvvwwhnrNBE/wOznXAhD371UO5O5f8GVSgevgWhnorkOPOgGWjE5DmVGcceby71MeB
 zEgGhVSQ6x0wKf8ugZ2I392N/R7loNvAD3jIXnvmO6vp3NApgZYDKVtvIt/wEjgY/vgQUB/uESR
 pYKEh2d4bcHeV6J7zn2VpH5S2vUmcQd+wnW3j7h+ZX2fxVe9XBWpyUwXna54rGr6GPgSRGnYL89
 pzlJ/UZKTnKODOTh/zRqio8MDVEZmeH5HBGNrVqMnNaaDVeI2URJjej7SGwGCAxywp+Yz1caa05
 QS3VD5Rp93gBE5mjTig==
X-Google-Smtp-Source: AGHT+IHLtwGehHUNpXU0uN4/0ui1Cdj2WgLcGE6o8pq//3h3YvLGsq8oRZv2527t61k9h0Lcidt+4g==
X-Received: by 2002:a05:6000:40cf:b0:399:728f:4673 with SMTP id
 ffacd0b85a97d-39c120e16eemr5596551f8f.33.1743413984182; 
 Mon, 31 Mar 2025 02:39:44 -0700 (PDT)
Received: from localhost (lfbn-tou-1-752-68.w86-250.abo.wanadoo.fr.
 [86.250.199.68]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a4346sm10960836f8f.95.2025.03.31.02.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 02:39:43 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Zixun LI
 <admin@hifiphile.com>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] usb: gadget: atmel: Add SAM9X60 support
In-Reply-To: <777fde90-8f9d-485f-ae92-6add019bb47a@linaro.org>
References: <20250322205625.1330306-1-admin@hifiphile.com>
 <68c868ea-33eb-4239-9598-f3d80943a959@linaro.org>
 <875xjppo2c.fsf@baylibre.com>
 <777fde90-8f9d-485f-ae92-6add019bb47a@linaro.org>
Date: Mon, 31 Mar 2025 11:39:43 +0200
Message-ID: <8734etpmhs.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Eugen,

On lun., mars 31, 2025 at 12:26, Eugen Hristev <eugen.hristev@linaro.org> wrote:

> On 3/31/25 12:05, Mattijs Korpershoek wrote:
>> Hi Eugen, Zixun,
>> 
>> On lun., mars 24, 2025 at 11:23, Eugen Hristev <eugen.hristev@linaro.org> wrote:
>> 
>>> On 3/22/25 22:56, Zixun LI wrote:
>>>> Add compatible "microchip,sam9x60-udc" and device tree binding.
>>>> Compared to SAM9X5 the only difference is the DPRAM memory from the
>>>> USB High Speed Device Port (UDPHS) hardware block was increased,
>>>> so we can reuse the same endpoint data.
>>>>
>>>> Tested on SAM9X60-Curiosity board with nfs and ums commands.
>>>
>>> Why no patch to enable it on the board as well then ?
>> 
>> Looking at configs/at91sam9x5ek_mmc_defconfig, I don't see
>> CMD_USB_MASS_STORAGE=y in there as well.
>> 
>> Could you elaborate on why you'd want this to be enabled as part of the
>> driver series?
>> 
>> On one hand, users has more built-in commands available and it eases the
>> testing. On the other hand, some users might not be interested in having
>> this by default. Enabling it via menuconfig is quite easy.
>
> What I meant is have the node in the board DT (gadget@500000).
> That cannot be enabled in the menuconfig.
> The Gadget or the Host should be described in the DT as it's a
> description of the board, if the board supports both Gadget and Host ,
> both should be in the DT.
>
> If there is a hardware limitation, or something that allows only one of
> these to work at the same time, this should be detailed, and have both
> nodes anyway, with one of them Disabled, possibly two different DTs with
> either of the nodes enabled/disabled.

I see. Sorry I misunderstood your point initially.
I agree with you: we should enable usb0 in
arch/arm/dts/at91-sam9x60_curiosity.dts as part of this series.

Thanks for the clarification!

>
>> 
>>>
>>>>
>>>> Signed-off-by: Zixun LI <admin@hifiphile.com>
>>>> ---

[...]
