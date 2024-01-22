Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE75C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 13:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D6D6879A3;
	Mon, 22 Jan 2024 14:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="IZpopDzJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A79087B13; Mon, 22 Jan 2024 14:46:50 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B0C387B6C
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:46:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e8d3b29f2so38458195e9.1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 05:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1705931207; x=1706536007; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uyq/pqSJVqrCjpWTu0NnTfWKSTKTn/WP1KVFttkOAmQ=;
 b=IZpopDzJDcWGD5qzI86uM4gYguIuJzIxWMn6AhATnSteAmPtvVZOS2vuVmSYlmaXEp
 sUick00NaMSxNbbEqzAtbPzfrHvd5DNipwlcxSrKAVkzwmYO6y6Cshq8YF9j0ER5lM4Z
 kXGc3NRzAY3sPyOG5BWuTd4PmscRkWqUNI2G7IAtQOcfCXz03oEUlSqPB0Rn4vYqc6/J
 zTQTIeiGSu6V3jS5lAGlnS9l0R9doek3yxUvTIdWoV3M8eh6wZMY9/PlYKs8oPuEOi9j
 uY/XYwOSQYJmRmRSxnvidnpg6Jw46lrhlMUvCfMAXuZMoBVTtnm9ggjIfsOF7ZIqKH+E
 ibxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705931207; x=1706536007;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uyq/pqSJVqrCjpWTu0NnTfWKSTKTn/WP1KVFttkOAmQ=;
 b=hbw/+4WJOmM777s9p1zlq/191FOWniV8PnhTY5Svj6quuM1rBu62Ex2xY2oFqKuOHS
 4G6hrbGzKHmhu/MUTCmYexJgbQTl8MFM9NSI5AP4amDQli49epEH4CtqFNxdUU88xGx7
 tYWXrCN6OAJb9d3CFZ1JQy7v7EPX7zMjL0teogXA0ie+zxjN8bwSAb14G11oeFzcTf+M
 quW2GxchMCKkw7RYarJwH4FPGf0MLFuQ3Pb0oT0WIeiLfQqv6R1YZJBzsrgklbcOqqxb
 nyQQF3edSVXNBWBeUK7cDg0ncl8w6XLIm1xIIZNLFcWSuZ9ImqylnQGgcNcajSCjhpV2
 TINA==
X-Gm-Message-State: AOJu0YyjKqd05KF1Zba0vB0biF0Dm7YgavBsBlBxWdpeTEGnf6XdGBT1
 2H61YXUwYrGWf1Ro+8aHxSeyXV1kLMqHsPl9SDFxJ16yiGGQTiQ9r8trRpeDebg=
X-Google-Smtp-Source: AGHT+IEU3l34DQXW/gsLNtW9//3/x/0ShcLO7TydF86hF/Fn8Gqig4I6uaUO9qfm+iH9HMvAqrO0AA==
X-Received: by 2002:a05:600c:4f42:b0:40e:b0fe:882d with SMTP id
 m2-20020a05600c4f4200b0040eb0fe882dmr236476wmq.131.1705931206848; 
 Mon, 22 Jan 2024 05:46:46 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.188])
 by smtp.gmail.com with ESMTPSA id
 k23-20020a05600c0b5700b0040e596320bfsm3883730wmr.0.2024.01.22.05.46.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 05:46:46 -0800 (PST)
Message-ID: <1f04368a-ecf8-4ad8-abf8-ede1160867bb@suse.com>
Date: Mon, 22 Jan 2024 14:46:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] rpi5: initial support
Content-Language: en-US, ca-ES, es-ES
To: "Ivan T. Ivanov" <iivanov@suse.de>, Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de
References: <20240110122908.31612-1-iivanov@suse.de>
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20240110122908.31612-1-iivanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 10/01/2024 13:29, Ivan T. Ivanov wrote:
> Hi,
> 
> These patches are slight update for patches posted earlier here[1].
> They are adding basic support for RPi5 and are based on v2 series
> from Dmitry Malkin[2].
> 
> What changed:
> 
> * Initial memory map now includes whole first 1GB of DRAM. At runtime,
>    the firmware will adjust this size depending on whether an HDMI cable
>    is plugged in or not. If there is HDMI monitor connected it will reserve
>    framebufer memory region and will add simple-framebuffer device into
>    devicetree.
> 
> * Dynamically calculate bits per pixel in video driver. This works
>    on all prevous RPi's models that I have.
> 
> * I am dropping PCIe patch for now. I made some progress on porting changes
>    from vendor Linux tree to U-Boot. Unfortunatly testing it is little bit
>    tricky. They are many devices behind PCIe, but more or less all of them
>    requires missing either "reset-controller" or "clock-controller" or
>    "pin-controller" drivers. I was able to probe "cdns,macb" device, but
>    access to ethernet PHY over MDIO bus is stucking. Then I ported
>    "raspberrypi,rp1-adc" driver from vendor Linux tree, but it requires
>    missing clock. And on top of that machine that I used for developing this
>    crashed and I lost my PCIe changes :-|. Anyway.
> 
> These patches allows me to boot current openSUSE Tumbleweed without
> modification. I can see serial console log and boot process on HDMI
> connected monitor.
> 
> I think these patches should be enough for start. Please consider for
> inclusion.
> 
> Thanks,
> Ivan
> 
> [1] https://lore.kernel.org/all/20231218210341.30073-1-iivanov@suse.de/
> [2] https://lore.kernel.org/all/CAKRNjQ0dsWozGo4n8g58m4cCEk3n=qx1R+L24WBgpo-iP1yo7A@mail.gmail.com/
> 
> Dmitry Malkin (2):
>    rpi5: add initial memory map for bcm2712
>    rpi5: Use devicetree as alternative way to read IO base addresses
> 
> Ivan T. Ivanov (4):
>    rpi5: Use devicetree to retrieve board revision
>    bcm2835: Dynamically calculate bytes per pixel parameter
>    mmc: bcmstb: Add support for bcm2712 SD controller
>    configs: rpi_arm64: enable SDHCI BCMSTB driver
> 

In the meantime I was able to test this series. So here my:
Tested-by: Matthias Brugger <mbrugger@suse.com>

>   arch/arm/mach-bcm283x/include/mach/base.h  |   5 +-
>   arch/arm/mach-bcm283x/include/mach/mbox.h  |   3 +-
>   arch/arm/mach-bcm283x/include/mach/sdhci.h |   3 +-
>   arch/arm/mach-bcm283x/include/mach/timer.h |   3 +-
>   arch/arm/mach-bcm283x/include/mach/wdog.h  |   3 +-
>   arch/arm/mach-bcm283x/init.c               |  74 ++++++++-
>   board/raspberrypi/rpi/rpi.c                |  22 ++-
>   configs/rpi_arm64_defconfig                |   1 +
>   drivers/mmc/bcmstb_sdhci.c                 | 173 ++++++++++++++++++++-
>   drivers/video/bcm2835.c                    |  18 ++-
>   10 files changed, 282 insertions(+), 23 deletions(-)
> 
