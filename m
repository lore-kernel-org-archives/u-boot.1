Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E291C04FFE
	for <u-boot@archiver.kernel.org>; Sat, 11 May 2024 17:44:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CA3287EF6;
	Sat, 11 May 2024 19:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mwh99waX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5173987EFA; Sat, 11 May 2024 19:44:31 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61D5F87ED0
 for <u-boot@lists.denx.de>; Sat, 11 May 2024 19:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=knaerzche@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4200ee47de7so4704505e9.2
 for <u-boot@lists.denx.de>; Sat, 11 May 2024 10:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715449469; x=1716054269; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=48ijD1Zuqw2S1kSAcwzCjlTndZp/pwp+rOiwCfGdg38=;
 b=Mwh99waXrVPljrqM3Pe2t8Rw3hEyV9yAdFEfjaaYaDQiqK+oc+P/lPK5ZYXgab0k6g
 5pmVZB4dUWLQxPFuIoPCNc0GuvQh0+cdThQ5HSIht3VRc0ZDPGxlF0ys12/jxg7vEyxe
 oixRCw87KdxArAMaBfkvfV20SleNBc7rMwRErh70iiijv8YTjIA+xAvJKhiiKrqYsPib
 yC8YkxjEZWBHzvXYyrTHhPhOOCElxnOsLqp6VeGyomJzeDQxKiIL8BY/0+WMkRKL0lIH
 80/CIle3HKHbwRYv/tmKfgYXqLRVyX4yJddKup4zYSE2OspikHJ6OSm2K/FIZZyNQ3f0
 ZYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715449469; x=1716054269;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=48ijD1Zuqw2S1kSAcwzCjlTndZp/pwp+rOiwCfGdg38=;
 b=EUQQ3YyCTacnOiZwf1fwBt264/Vw6Sy6rQmEbr02TrGXgfOaEOEVs4Zjk1KMPOvFxK
 /RWBQjYoJ/w0jj/Ay4BU65SGNFQ9vzHaXXldbb1mQmmLw5o1FICmDHOwf9wWGSKw5Xsw
 NeDDSRj50y1/i1eymR7Ql2txBZ0Y5nkrrnYrjmRLh3Ys7BUwtgWZLFCCxzDp1Xh0vsEq
 sJjIMcTrosd6lFWAND76aK8d9hJvrci1D8rudHmbyEKEdm+vH9MZ/Njpg42xSZJ6slR/
 zzgAo4iAZeo0fsfcxQMHpyPHa1CGfhXw7umq7OmwrXDJUyXvcoF3/eGRP6NSlIbdESOl
 HCkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUsUptzKIddmfa309qKqkS24Jrggp8RYRGQRKK4WwGAbq86iy2E0nVIygFCKxheDm1WCxijeHgAgSRx3IDapMRasqkfw==
X-Gm-Message-State: AOJu0YwcapPz0js2AGSrnLTeSWCSWfeDCwcPcWJY5P2BOzx0OnBilov3
 IuNB6wEFgOzLN9+WFDkXx9OpxM9Tp6+vVArIZd257xNNMhuZdq8=
X-Google-Smtp-Source: AGHT+IGXTeFnYHn2hKDBLB30g7S1hv6n7eLbxeAwRUTjaFFKxcRfv0prM8TylVjjzw2O69V/QCp7ow==
X-Received: by 2002:a05:600c:3b97:b0:418:5ed2:5aa6 with SMTP id
 5b1f17b1804b1-41feac63341mr46442005e9.31.1715449468548; 
 Sat, 11 May 2024 10:44:28 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:9c06:c412:fe39:28ff?
 ([2a02:810b:f40:4600:9c06:c412:fe39:28ff])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42012276231sm7686875e9.26.2024.05.11.10.44.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 May 2024 10:44:28 -0700 (PDT)
Message-ID: <0e701fd8-b2c6-4ac4-9427-d984032470d1@gmail.com>
Date: Sat, 11 May 2024 19:44:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] rockchip: Add gpio request() ops and drop PCIe
 reset-gpios workaround
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, u-boot@lists.denx.de
References: <20240511112821.1156519-1-jonas@kwiboo.se>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20240511112821.1156519-1-jonas@kwiboo.se>
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

Hi Jonas,

Am 11.05.24 um 13:28 schrieb Jonas Karlman:
> This series add gpio request() and pinctrl gpio_request_enable() ops so
> that a gpio requested pin automatically use gpio pinmux and U-Boot
> behaves more similar to Linux kernel.

I'm not sure that's a good idea.
While linux does it the same way, we really shouldn't expect every 
software/os/ … which uses DT (now or in future) to implicitly switch the 
pin function when using a pin as gpio. So the real fix would probably be 
to add the the correct pinctrl settings to the upstream DT of those 
boards and sync it later on (not sure those if those SoCs already using 
OF_UPSTREAM) and leave the -u-boot.dtsi-"hack" alone for now.

Alex
> 
> With the gpio and pinctrl ops implemented this series also remove a PCIe
> reset-gpios related device lock-up workaround from board u-boot.dtsi.
> 
> PX30, RK3066, RK3188, RK356x and RK3588 are the only SoCs that currently
> define gpio-ranges props and is affected by this series.
> 
> A follow up series adding support for the pinmux status cmd will also
> add gpio-ranges props for remaining RK SoCs.
> 
> Jonas Karlman (4):
>    pinctrl: rockchip: Add gpio_request_enable() ops
>    gpio: rockchip: Add request() ops
>    rockchip: rk3568-rock-3a: Drop PCIe reset-gpios workaround
>    rockchip: rk3568-radxa-e25: Drop PCIe reset-gpios workaround
> 
>   arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi     | 12 -------
>   arch/arm/dts/rk3568-rock-3a-u-boot.dtsi       | 12 -------
>   drivers/gpio/rk_gpio.c                        | 10 ++++++
>   .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 31 +++++++++++++++++++
>   4 files changed, 41 insertions(+), 24 deletions(-)
> 

