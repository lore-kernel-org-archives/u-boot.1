Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB05D6D237
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 15:33:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3956683E28;
	Thu, 18 Dec 2025 16:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arturia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=arturia.com header.i=@arturia.com header.b="Nc2cREB2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9379783E3A; Thu, 18 Dec 2025 16:33:51 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D99A383DEE
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 16:33:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arturia.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=victor.krawiec@arturia.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so550081f8f.3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 07:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arturia.com; s=arturia; t=1766072027; x=1766676827; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0h20yh3DyAU+o7VOngk2Ty5Vi1+kNKYJ8hnJUiYFLzw=;
 b=Nc2cREB2sxkEIq0ktfmgowjerNLnc6lgoTqA14RhTFXa2SSWHZWk6ss/TprRi/pCR1
 uj0zpT8Eu5CSPVS22tpOckpaJmtLBptHfTRY+yGFdAQx197kbb62+IZWF7gJlpKhGu92
 VwAw+R1iYYb8j6FNITrHYeoa59CmODIjIPRiU66z00+PTblUKvUDIk9pvTAvLGdORPJ1
 yto2jvf3Uho/wqzcUGWqQ6yPMpbSFtvZrZl77eKM5Hukr8VL39P5L9P+PcGjG0bi8mJ0
 cJgCWoqSgPjqgCsVEiq77dBHUmtfmbbiGtHUPuvPjdCxi8ITcm5X40kX1mcEoxvwNKBL
 X6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766072027; x=1766676827;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0h20yh3DyAU+o7VOngk2Ty5Vi1+kNKYJ8hnJUiYFLzw=;
 b=vJn9Vzw7g65YcqqNrqc0vdS8oFkDI+DeGTN04PcesLfoP3DpabjSTZtKZwAr5fHAJs
 kJO6O/QnTbb5TGHBBNqlmrWJitUjVLi3naFvn6uhwy+0Re21GunKeT4JL/1+4j3J57ID
 7f8eIdd3iv4NgfnfbUG6bSb8xT6VlvRw9QeNZbT4bbPh40joVr+Fc154TuK2zxEwRXHl
 sNMO4eOGO5WRdTYmCCQzy7IUsd05NDU4fAIaJxRCWgCU5nierBhzI8HH1F3n+oeNlqco
 LFSkxZnFHIqrICj2aq3gQ8hOTz83ZMN7MhLJGePBswL7CcDC30h88kpP9wY+3+v/asa3
 2ihA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlbeWSVkvepLm6T0YFhe9Yl4OUf+fLM4nZz1F5xlO4hc/6yYwcGO93ny9tHFII5MB4n20rqXY=@lists.denx.de
X-Gm-Message-State: AOJu0YxdkjUO6y1ULPwgCCL/BTTl2y66DHkJAgTItJYRCVc/phS+rfwN
 AFwE0heWyebqRau1WW65jFtE6ondF5EyydM0j6P8fV9bC4CUj0QIlWi+ZtW6Sctx4tk=
X-Gm-Gg: AY/fxX7XvNEJ8Igkf+aBL2T1GmJ/g2rFZSamyZmHFOWgk1q3VW6NUBYRay7e8vQ4ObM
 7OOby6yvbkKfLqg93YW0l1dfSpatWiV4WkSU4ZOIe6BTRk6smeTVd0Gv0OhZFeWiOOe/hv4YTUF
 9vhYebKVkfIW4GYovOwdiTWwUbOK9qprN1rDhYJ1Moz6Emhm+QOGOHhi5nIrEAys4VsC6FeUtun
 Y38ETMquWrmsFAZGGHz8Ka/Vwn9LuSl3IjPMehrwWpHOz04bC9p5gx30awwW19GUE4Fwm8lcPKZ
 GP4UKF7AXqGMIVfO3XhGT9LZd12QwJmED4eIJnKSfRRJGQATLLQdsn2AhgJl59poSKoftxseElO
 x0QFQRuEFE5ezglsDtriFMx2YdSyt899nh0+SW3ONLPLyBFO7olTNyOSjotRoc0yMIfm0gAJATs
 nrWslSwSUAhjzpfDCv/BQCYmd5BLH0cdnrgv6buhZMqkEB8Cruelk=
X-Google-Smtp-Source: AGHT+IEMZoDpUByGjmjHH+HcbCH0LIruSmAiBLFkvyorRRf4MBtHEicxyQHAIDyFVRsHBwakqUNmnA==
X-Received: by 2002:a05:6000:1785:b0:430:f5dc:d34a with SMTP id
 ffacd0b85a97d-430f5dcd4c2mr20516755f8f.29.1766072027136; 
 Thu, 18 Dec 2025 07:33:47 -0800 (PST)
Received: from [192.168.32.21] (226.142.197.77.rev.sfr.net. [77.197.142.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43244934cd4sm5518226f8f.7.2025.12.18.07.33.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 07:33:46 -0800 (PST)
Message-ID: <edd2a55a-8e72-442b-916c-cc07c44df561@arturia.com>
Date: Thu, 18 Dec 2025 16:33:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Rockchip RK3399 SOC is very slow
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <0d8cb0a2-5581-4885-b7bc-34402a4ec3c8@arturia.com>
 <f5007ce0-e5b7-403a-8f1a-8c6f69239235@cherry.de>
Content-Language: en-US
From: Victor Krawiec <victor.krawiec@arturia.com>
In-Reply-To: <f5007ce0-e5b7-403a-8f1a-8c6f69239235@cherry.de>
Content-Type: text/plain; charset=UTF-8
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

Hello Quentin,

Thanks for your answer.

On 12/17/25 18:02, Quentin Schulz wrote: 
> Is Rockchip's fork actually running at a different frequency? I will bet that not.

Thanks to the code you pointed to me in clk_rk3399.c I was able to check in Rockchip's fork. They are using 816MHz. So it is a bit faster but it does not explain such a difference.

> We default to 600MHz for both the LITTLE and big clusters on RK3399 as far as I remember. I believe it's because it's the default frequency of the cores and so, if we have booted into U-Boot it means the power is stable enough and at the proper clock frequency. Can't confirm, it was a long time ago I looked at that. c.f. drivers/clk/rockchip/clk_rk3399.c rk3399_configure_cpu_l and rk3399_configure_cpu_b and specifically PLL_DIVISORS in apll_b_600_cfg and apll_l_600_cfg. One of the issues we have is that this driver is the same for all variants of RK3399 and they don't all have the same OPPs (OP1, RK3399K, RK3399T, ...) except for the default which has worked nicely until now it seems.
> 
> The issue is that you need to configure the regulator for the LITTLE and/or big clusters to what is required for the higher frequency to work reliably. We don't have cpufreq support in U-Boot so it'll essentially be stuck to one OPP at this time. If for some reason you're running at that OPP for a long time and you don't have appropriate cooling, we also do not have thermal devfreq for the CPU which means it won't slow down to not burn itself. Therefore, only the HW thermal limit will kill the CPU (usually around 115°C if I remember correctly). When you change the frequency of a clock used by other devices, you need to make sure the other ones aren't modified in a way it breaks other devices (which is something the clock subsystem hopefully should be doing for you, but I don't know if it's as advanced as in the Linux kernel).
 
I was afraid messing with CPU frequency would be too complicated and risky. Thanks for confirming this.

> If you want something fast, you can also look into falcon boot, which skips U-Boot proper entirely and loads a FIT from SPL with the Linux kernel (you also need TF-A in it). I haven't done this as it limits what you can do with the board and we're selling SoM with BSP, not final products so we don't know how it'll be used, better have something casting a wider net and have less to support customers.

I will definitely look into this. I knew about falcon boot but I did not use it because one of my goal was also to display a splashcreen. We make music instruments so having direct feedback on the screen at power up is nice. But anyway since the splashcreen appears after 7 seconds using U-Boot proper I might try falcon and display the splashscreen in Linux.

> You can check also if you have enabled everything that makes your devices go fast enough. If you're using eMMC, does it support HS200/HS400/HS400-ES? If yes, did you enable support in U-Boot for it? In the Device Tree? Same for SD card with SDR-104, etc...

I am using eMMC with HS400-ES. "mmc info" displays the correct settings but I will double check the configuration.

> On RK3399 Puma, with master, it takes slightly more than 5 seconds to jump into the kernel by loading everything from SD card (so, typically slower than eMMC), see the log at the end of the mail. I have not optimized the defconfig for speed right now. Note that I'm using baudrate 115200 which is much slower than Rockchip's typical default of 1500000, so it probably is at least a few hundreds of ms faster with that baudrate.

I could probably reduce the boot time with some optimisation. I already saved few hundreads of milliseconds removing CONFIG_NET.
But 5 seconds is still 3 seconds more than the vendor fork. I really wonder how to explain such a difference, since the CPU frequency is not entirely to blame. And on the vendor fork I'm not optimizing anything.

> You can see from the logs that BL31 takes 1.5 seconds to jump back to U-Boot proper... that's something you need to optimize in TF-A directly. I guess you can disable bootflow/distroboot and avoid a bunch of device probing and configuration.
> 
> You can disable what you don't need and optimize away. We have CONFIG_BOOTSTAGE + CONFIG_CMD_BOOSTAGE that may help you figuring out what is taking the most time I believe?
> 
> There are easier steps to take than go play with higher CPU OPPs right now I think, so start with that or identify places where we can improve?

Thanks a lot for all the leads. I'll keep you updated on the results.

Best,
Victor
