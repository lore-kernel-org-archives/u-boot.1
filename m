Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8D8CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 10:30:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C10A583045;
	Tue, 30 Sep 2025 12:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="EI8kuIA/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 686DA828A2; Tue, 30 Sep 2025 12:30:13 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62CD7828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 12:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-578ecc56235so5243092e87.0
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 03:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1759228210; x=1759833010; darn=lists.denx.de; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=whSrWp9QyjAwQ0Y3Qwq2nyJpc3d+Pe/w9BjlufGMgOc=;
 b=EI8kuIA/JK0e1nuh42rpBBpqngyId05650exIMnn2pLrD90JbaRbjMxzJWnzQBb6uA
 AKSpNUndefY64TzbSBE1s/hG11HSntkPmmFDyihK6qt6jwedjkOQ/vnLtM7wfGJ8GGpe
 9ygfwjTQ6uHBFTap8CnnignprRWxctrl/xbf/F2GE+6ukazWNl664B3y94s7tfYJba52
 wvTPHHBqEuYJYVUcrv3KPyJV5/mXhWFXt6+1u9KJSFYJZLyjI8CERVl4qsBdC8Ba1aEs
 gu+pfBpFtbQyrGv/c2H4l6IPTjHQPDDWpFVlADZMNGWdjM2WnlQeJWdW6PV6YKyjE5ws
 x5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759228210; x=1759833010;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=whSrWp9QyjAwQ0Y3Qwq2nyJpc3d+Pe/w9BjlufGMgOc=;
 b=hlYHeGCUGFKoNDMxS0k9uYMf8PwL2dyRYY4cRWybEWWgv+5X8uEXydNK+ZXZdkaVuY
 oNW+QjbdllrJCZZcw3qMj3NrlTXEFiykyt4weJDLJVISngYb+prSkEu8qcP0Zuj2u58Y
 9D0WsRyZmItNvg8KUeKlih57y8F0jBRnfEuz2byZ6V7iuA6mj0GsFD0oAgmmDkxHou+m
 +3BTJryZvVcCOmWSNJ551NNlfxhFoMQHHXKJljq+/P6597W5SZ+t7AkEakqQt9vovnYb
 Cl0mGSe5tabbU53cludf/5T43xj447R3O05JJZ6Nk9wrwx7ZIfbMwSS5FnrlUzGq5xFi
 qEsw==
X-Gm-Message-State: AOJu0YyUetjBxd2a3uBaMy62MTGLFD+Ma+sInDg6Lw8h82iYi2j7NN+z
 eSYAC7YAGbXMyjXVwRcB3bfiKoDzlpIni8qBKMx7jn89aDfi5NSpQG1d7WnEhAaKZjGIdM/6ETS
 wHu7knkj9kpmfnQSB4veQY5hda2Sq9MllgAHT
X-Gm-Gg: ASbGncs89O+ryNQVbDjeULrCMmbHqdkLzWe/wOok9AuTrfP1v7DXsl0e9/6D5tmSrM/
 9asKT3vq/Xf7dBEdidGz8aCLMKjocIYEyQkx00JiX4aFYQ94PR0j7twT7oyqT+Q7WBfDfbXfqCi
 325jojqUBNzFGVTe/6pFUouzS736cC0THWHLwFEjXMPnbSVRhee4XMFyHtZ1NMXwCigk6db/5Tc
 bwZHtT9/5P1tADK7Whz2px9ZNpdSXhQzwUnhD8F15s=
X-Google-Smtp-Source: AGHT+IGqX16gM5qo2KDZbpgStHO9j3JEdFBn29a4IRIt6nl2KgXqTYlasBPeIfiB4NMD7i3TihPeb/Fed4k0CYA6l58=
X-Received: by 2002:a05:6512:b89:b0:57d:ffa4:56ff with SMTP id
 2adb3069b0e04-582d14f0a6cmr6241429e87.22.1759228209628; Tue, 30 Sep 2025
 03:30:09 -0700 (PDT)
MIME-Version: 1.0
From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Tue, 30 Sep 2025 12:29:56 +0200
X-Gm-Features: AS18NWCVpb4y3cj0YC868yjFVRYuClHPaSrZqcCNiamXTRVwkefCDKSerf3mBHw
Message-ID: <CAGm1_ktFBBuogJjpO4mXZSv3ZvJxmgpVqgV=A8uRhc5RcALpJw@mail.gmail.com>
Subject: activity-led usage
To: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi all,

I added the following LED definition to the am335x-baltos.dts:

        leds {
                pinctrl-names = "default";
                pinctrl-0 = <&user_leds>;

                compatible = "gpio-leds";

                led-power {
                        label = "led-red";
                        gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
                        default-state = "on";
                };
        };
        user_leds: user-leds-pins {
                pinctrl-single,pins = <
                        AM33XX_PADCONF(AM335X_PIN_MII1_COL,
PIN_OUTPUT_PULLDOWN, MUX_MODE7)     /* mii1_col.gpio3_0 PWR LED */
                >;
        };

The gpio-leds driver is working and I can toggle the led-red via the
led command.

Then, I created an am335x-baltos-u-boot.dtsi file with the following content:

/ {
    config {
        u-boot,activity-led = "led-red";
    };
};

I have also tried "led-power" instead of "led-red".

In my final DTS files I have the following nodes:

        leds {
                pinctrl-names = "default";
                pinctrl-0 = <0x56>;
                compatible = "gpio-leds";

                led-power {
                        label = "led-red";
                        gpios = <0x57 0x00 0x01>;
                        default-state = "on";
                };
        };

        config {
                u-boot,activity-led = "led-red";
        };

U-Boot cannot find the activity-led node.
ofnode_options_get_by_phandle("activity-led", &led_node); returns -22,
because ofnode_path("/options/u-boot") fails.

When driver debug is enabled, I also see the following messages:

bind node config
Device 'config' has no compatible string

My am335x-baltos-u-boot.dtsi code is similar to what I could find in
arch/arm/dts for the boot-led usage.

Where should I debug further?

Best regards,
Yegor
