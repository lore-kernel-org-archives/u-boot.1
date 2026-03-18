Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013A31077610
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 20:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D6FB83642;
	Wed, 18 Mar 2026 21:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WSyScVnK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D027807C0; Wed, 18 Mar 2026 19:46:06 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD7DD80050
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 19:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=filip.kokosinski@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43b4f48c47cso98275f8f.0
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 11:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773859563; x=1774464363; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w5l69KoVokzEULlBiO/NHuPrRFdLf4EAlVJiHKzc2gg=;
 b=WSyScVnKZVxdYToccstjkCwwL+Pw3z5xv4DIuJfZsILlsv/zEEsIdDK7idFjU7pJZF
 BmACdoeQWijzgyRUQ9l4pTLf+CX2KWUP7YBhuXfIfyoUdDMRTRGlzd7kRZQSRCppYMDS
 L5N9VFP/5ThRKEvNsQDXJYKH34lPM1V14a/xcGJnv4HIBgNedP2SOqmla8kmGjU33bjN
 2Ebfxp9kOtnPBOsEt4gOSDZKr206RL+OLaNuTy6ejRH/tM9YZEhdzE8ojUNSxjLz7XPd
 jGenFQtE8gfEIwPL6NM/dUL9NstMPfg0wIrP+oDPRaDGvDwiIWVqsuyMheNlDfnpVxlW
 juxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773859563; x=1774464363;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w5l69KoVokzEULlBiO/NHuPrRFdLf4EAlVJiHKzc2gg=;
 b=obXaHRkAHeYA/IhFj+zWIRS3qVQlzi0U6ceNIS7KqL9+wt5U9dfqfuuLNz8W4qmv1I
 m1VrhfSnL8YEMT4fkr/rsuDVVh5ztnChU2j4w/PvImQdwXQIvcKBVxEmZt1pvva8CpiF
 C76stFld/9ro6zqepvh2RL0mtOZVa6+TUTpBiW20mzJ6JIKkiLm1yvMqyLk/PEeWqDvz
 biqYgnsq0n74CR9NxxDfZAFSVXbOQS/l2k7PPyncAgBSqhGo7JBHmp4QlpdkQKGfrwR+
 l9iB6gGUQFbguiq2gOkaI+j2AWdINJUUsK7cYn5cZn/KgZtQT6mw+linp2ltfQOIwQIV
 x+vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3JMfA5Bt6tsOvPwg4baZC5t2VYU+ZPCMRjVfosMz6XXrckWhpxxBD8AoZes+rK0Kun/1S06A=@lists.denx.de
X-Gm-Message-State: AOJu0YwIqnu2qGi3Vj1aU0Nlx/GTUz8Ah+vy1dRjmy3MEKWsKDobyC0i
 MRBG7kBAf8Fx0Vpt9q+OyrKkIsr8pnuBtQ3NGwCQQSiqrGmq6rynGk0a
X-Gm-Gg: ATEYQzxotvmCkBk9jRw+U55tU96FrB3WJeoCuKNOMq+jx6RXIxQLCa3tp56CDLBWtYh
 l0V/xD4eSEVIdjlruq3XCkRUgaDCaS1Jvgi9I4bzon4+uyS8a8SqlaDYn3Wf7tdj2iUf6/nY2MD
 z6jhLtsL4bguRSVAd7Y1ZafHH08U7yKitKU1iJHwbrbxrjqKVqzkAs/naLcU/7qnZ9KYyufUBod
 iG3Dz1t75LeDQ5dqZmPOpKyT8ZrQ9fxNIoNLJ4GmiqOpDKDbowRaRlttzbuE72Y8beS4xmDkQM4
 xD9q3lX/w9yEah3D4SOeUx2VB9+NOKdvX6A/IezXmG9wJcSyZQVIyWV/nZZBZDOnA15j7eSoxnJ
 HJTe1Fp6GljObBtmVcC5he6wRoGFepLDB2h8m+WONi3B3WNmt0UpjlWRA1QTTF4ILO1lme7afNc
 4PG6mWI5HrM125r3WffnMTQpwryE3u/Gk8GuUJmsV4ARz5HDwcwuaIJr6aVaYjFJCpqLehpyLoc
 3FT
X-Received: by 2002:a05:600c:83c5:b0:480:6bef:63a0 with SMTP id
 5b1f17b1804b1-486f4456f1fmr73149575e9.21.1773859562541; 
 Wed, 18 Mar 2026 11:46:02 -0700 (PDT)
Received: from [192.168.1.21] (83.25.184.223.ipv4.supernova.orange.pl.
 [83.25.184.223]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8aacc73sm10448725e9.0.2026.03.18.11.46.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 11:46:02 -0700 (PDT)
Message-ID: <af790887-96b5-4839-aeb5-6bf6d1d4cf22@gmail.com>
Date: Wed, 18 Mar 2026 19:46:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rpi: Update the naming for bcm2712 SoC RevD naming
To: Peter Robinson <pbrobinson@gmail.com>,
 Matthias Brugger <mbrugger@suse.com>, u-boot@lists.denx.de
References: <20260313170839.2720191-1-pbrobinson@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>
In-Reply-To: <20260313170839.2720191-1-pbrobinson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Mar 2026 21:11:58 +0100
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

Hi Peter!

I've taken a look at this, and unfortunately - with fdtfile set to
broadcom/bcm2712-d-rpi-5-b.dtb the kernel panics on pinctrl-related symbols:

[    0.236580] SError Interrupt on CPU2, code 0x00000000be000011 -- SError
[    0.236586] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Tainted: G   M       
        6.12.47 #1-NixOS
[    0.236590] Tainted: [M]=MACHINE_CHECK
[    0.236591] Hardware name: Raspberry Pi 5 Model B Rev 1.1 (DT)
[    0.236592] pstate: 804000c9 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[    0.236595] pc : bcm2712_pull_config_set+0x78/0x120
[    0.236602] lr : bcm2712_pinconf_set+0x6c/0xe0
[    0.236605] sp : ffffc00080033ae0
[    0.236606] x29: ffffc00080033ae0 x28: 0000000000000000 x27: 
0000000000000000
[    0.236609] x26: 0000000000000000 x25: ffffd06fcffb1060 x24: 
ffff800104c62a98
[    0.236611] x23: 0000000000000018 x22: 0000000000000000 x21: 
0000000000000122
[    0.236613] x20: 0000000000000000 x19: ffff800104ced480 x18: 
ffffffffffffffff
[    0.236616] x17: 00000000105916e2 x16: 00000000acf0c9e7 x15: 
ffff800101736948
[    0.236618] x14: ffffc000800337e0 x13: ffff80010173694a x12: 
3030306330356437
[    0.236620] x11: 0000000000000040 x10: ffff800104d13c20 x9 : 
ffffd06fcebb4ffc
[    0.236622] x8 : ffff8001024024a8 x7 : 0000000000000000 x6 : 
0000000000000000
[    0.236624] x5 : ffff800102402480 x4 : 0000000000000001 x3 : 
0000000000000018
[    0.236626] x2 : 0000000000000024 x1 : 0000000000000000 x0 : 
0000000000000000
[    0.236628] Kernel panic - not syncing: Asynchronous SError Interrupt


The `bcm2712d0-rpi-5-b.dts` from downstream kernel seems to change the 
pinctrl
node compat to "brcm,bcm2712d0-pinctrl"[1], which then in turn causes the
pinctrl driver to use a different register layout[2]. There are also 
other more
minor differences between these two dtses.

I haven't had the time to do more thorough digging, but I've managed to 
get my
setup working using the following overlay:

     /dts-v1/;
     /plugin/;

     / {
         compatible = "brcm,bcm2712";

         fragment@0 {
             target = <&pinctrl>;
             __overlay__ {
                   compatible = "brcm,bcm2712d0-pinctrl";
               reg = <0x7d504100 0x20>;
             };
         };

         fragment@1 {
             target = <&pinctrl_aon>;
             __overlay__ {
                 compatible = "brcm,bcm2712d0-aon-pinctrl";
               reg = <0x7d510700 0x1c>;
             };
         };

         fragment@2 {
             target = <&uart10>;
             __overlay__ {
               interrupts = <0x0 120 0x4>; /* <GIC_SPI 120 
IRQ_TYPE_LEVEL_HIGH> /*
             };
         };
     };

1: 
https://github.com/raspberrypi/linux/blob/rpi-6.12.y/arch/arm64/boot/dts/broadcom/bcm2712d0-rpi-5-b.dts#L80
2: 
https://github.com/raspberrypi/linux/blob/rpi-6.12.y/drivers/pinctrl/bcm/pinctrl-bcm2712.c#L390

Best
FK
