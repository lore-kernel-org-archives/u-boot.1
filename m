Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBB8D111A8
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 15:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C64683A5B;
	Thu, 27 Nov 2025 16:52:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="U0FJV4B3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8E6984409; Thu, 27 Nov 2025 16:52:53 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85063839DD
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 16:52:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2349640F1E
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 15:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1764258768;
 bh=7YwSquvmhmm6ufwqm2v8LP2/Ib5+ORpnGFBYFfFEi6Y=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=U0FJV4B3vspookixfZSfCyw3NC7OnK3QSMs/zDRZbiLO/8v1UqeiDaQe0qtEavLla
 BtjWCpXQK9I4oOLtmYASnf01p5ZnTQ6M6PSmgZrQxnj1ed3+MHIAwlFK/J2boJJbwo
 EPWe4+8siTbQWR4FROAkKA0xG83PTnmOPP2IQWOj5WQf/KPHk766RjaKetAOwcFatv
 L9ZsNrgs1tL5eEQVYGzqV6VYwULtkdf1OQViGn42Y5AKJx6qktEQGz809eWkfPviks
 sMnRtOB80DrkoWK3ntDCqWUsf30p/3YpabnoPGtSzAGQt3VyN5p+Vg5Z5rSY0YVfn7
 egQEHKzejclEw9Bmu4tdwISHElMjqj6Vee1pkWM78df2Dak5a3QXiCI8XKX4J88lFc
 P+ndR8AUPqjkf12Dp88fnUB/I5311KMJhKbVV+8HrZm/KLBxIGaleId6v/vqMF3OVh
 BQ28W4HL1dU7jgwiencZvFTIK9ku+XPRWh6YTVi55OaFT2SA+SkLbsCnzZCvFr6ffO
 rMR4vK/Nx4ThBl8p/RsCBk4x4PR4x/UctqLPrMJF1aMgV14yLm5CXo2ZybMGP7pcYI
 4PlMMe7SowxWYkObzwzvyfWtRIkqZ2iYc1ECAkJOnjsqilP9vZ0ngULWKRYspapV/R
 3++Moc/jZdJIyPAdLtKZ/xDQ=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779d8fd4ecso5285145e9.1
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 07:52:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764258766; x=1764863566;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7YwSquvmhmm6ufwqm2v8LP2/Ib5+ORpnGFBYFfFEi6Y=;
 b=ByUmwrLEY6VymECgCIs5xW1A+fz6J8/jEMA6z6XZOit6ZRGQ5GBJgWecdDgdP2owya
 16u/vt6z6MYHEPOTuL+GlWxxgQDXxX0mjj6kAH9NQUvwh+YRa/akbbJWL6t6qf4SNlnD
 ZXD4j4RrcIZIOHCU7CNLlECl8+5tV2/DBtIsDcgj3V/VKcL3koGo1mVc0FC9wwzkJ5iM
 WSiLDgt0+KMjuZszJWFC1snOpA1vn85EAsAJ7KJo8oB89jb/HsahyUPunRPnrDwukNVh
 WTeIB+Yc53PHKKvKOk2mRnzeYXxexlwykpXJsnO27Z4AWoVN5jpzpBWd9eJpYRGkLfbg
 1Azw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuX4iTGZIWbRIX1lQk2C1/X4Cbe4jzOus6870xt3ri4IbJiXpH1uO+2ubnyGzVhepCGQtNfeM=@lists.denx.de
X-Gm-Message-State: AOJu0YxFF5VTWMu3I5n7hQOaASiY+bF/h7eYOYMiziwH7yUahv4OXirO
 jKFGF2kcWCTAack6U2Wpx2mv+lhOYMHN2EIZchF7br7/WgVdFcl8LXK/kiPGzBZSWruUjVwWI8p
 0AObvd+yasoUOL0UD3i0SopaQwlhRw6LbEkURZkSvD57OWqF6Z9TyzlhBl39+Bse0eH3Nwcg=
X-Gm-Gg: ASbGncubUgQpAPLqf4P2CQ6fMbEbBw9Ofc21ARtVgDxK98jStBwejb4qfGhGjCxFPu1
 TbzYBzSDogYRBuXF+kGc4SzR3F3GbPmW5dKnFkikm6nF/FJmid8XCtvGwHydnseamz+JQ0whp1x
 6ZcybXR2+9w4hAvYrP9yYhOSg9P6dtEuHH9B6J9zbyHV7Ep54dguOjybuuM0ZZsukg7NvYZnjwx
 M60z+Kp2IJCMbSVCx/6hF1lfefBGgbj/keViKaGpXA96nQE3wpu/0C/aH+g7Ry5hPeGKcJmeEfz
 cTwm4bKjXVtaYc7wIOCON3ZiUeOPEZMJYOFTqIVrAg7bjU00FuZah1NpsrTkFswdFFq5U/xAOwf
 nLLOrCwmXLR/HafIT//wsxpGCXps7jYBYGNK8cnvj9dQVnrmvd6JR7GZYE7dgYH53bq9rg+GlNg
 ZA
X-Received: by 2002:a05:600c:6d52:b0:475:dadd:c474 with SMTP id
 5b1f17b1804b1-477b9ee479dmr174427735e9.10.1764258766365; 
 Thu, 27 Nov 2025 07:52:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhvJmXv4OEoT29/EJo9o8QGCSRXDm1sI+3moy9VScmLoc1+QzReBPmK7lGblaQxdCtRpMOwA==
X-Received: by 2002:a05:600c:6d52:b0:475:dadd:c474 with SMTP id
 5b1f17b1804b1-477b9ee479dmr174427525e9.10.1764258765965; 
 Thu, 27 Nov 2025 07:52:45 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:95a4:4529:9906:9f64:f864?
 ([2a02:3035:6e0:95a4:4529:9906:9f64:f864])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47913870b38sm8453535e9.15.2025.11.27.07.52.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Nov 2025 07:52:45 -0800 (PST)
Message-ID: <87d6ce91-b2c5-4e96-8103-31df9802786c@canonical.com>
Date: Thu, 27 Nov 2025 16:52:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Fix audio-supply for ROCK Pi 4
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 knaerzche@gmail.com, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Quentin Schulz
 <quentin.schulz@cherry.de>, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>, Jagan Teki <jagan@amarulasolutions.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20251027005220.22298-1-naoki@radxa.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251027005220.22298-1-naoki@radxa.com>
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

On 10/27/25 01:52, FUKAUMI Naoki wrote:
> This reverts commit 8240e87f16d17 ("arm64: dts: rockchip: fix
> audio-supply for Rock Pi 4").
> 
> Fix the APIO5_VDD power supply to vcc_3v0 as per the schematics[1][2]
> [3][4][5].
> 
> This fixes the SPI-NOR flash probe failure when the blue LED is on[6],
> and the garbled serial console output on Linux.
> 
> The ES8316 headphone and microphone are confirmed to work correctly
> after this fix.
> 
> [1] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/4a/ROCK_4A_V1.52_SCH.pdf p.14
> [2] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/4ap/radxa_rock_4ap_v1730_schematic.pdf p.14
> [3] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/4b/ROCK_4B_v1.52_SCH.pdf p.14
> [4] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/4bp/radxa_rock_4bp_v1730_schematic.pdf p.14
> [5] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/ROCK-4-SE-V1.53-SCH.pdf p.14
> 
> [6]
> => led blue:status off
> => sf probe
> SF: Detected w25q128 with page size 256 Bytes, erase size 4 KiB, total 16 MiB
> => led blue:status on
> => sf probe
> jedec_spi_nor flash@0: unrecognized JEDEC id bytes: ff, ff, ff
> Failed to initialize SPI flash at 1:0 (error -2)
> 
> Fixes: 7ebfd4f6b52a6 ("arm64: dts: rockchip: add LED for ROCK Pi 4A/B/C/A+/B+")
> Fixes: 8240e87f16d17 ("arm64: dts: rockchip: fix audio-supply for Rock Pi 4")
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> index 046dbe3290178..fda7ea87e4efc 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> @@ -516,7 +516,7 @@ &i2s2 {
>   };
>   
>   &io_domains {
> -	audio-supply = <&vcca1v8_codec>;
> +	audio-supply = <&vcc_3v0>;
>   	bt656-supply = <&vcc_3v0>;
>   	gpio1830-supply = <&vcc_3v0>;
>   	sdmmc-supply = <&vcc_sdio>;


U-Boot uses the same device-tree as Linux. I applied the change in 
U-Boot and it fixes the following problems in U-Boot for me:

* The serial console is not usable after the supply voltages are set.
* Early initialization of the video output fails.

Tested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
