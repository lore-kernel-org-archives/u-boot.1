Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940A7C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 22:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A166387C40;
	Fri,  8 Mar 2024 23:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="V/1YntCS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90B9487CE8; Fri,  8 Mar 2024 23:49:21 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DD7F87B77
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 23:49:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A2E684113A
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 22:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709938156;
 bh=E34F9jdRhIZjQjzeHxJJK9pf+38+4UvWwbXvwIxjQCU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=V/1YntCSPL0vMGgCHdtOimTpzj6gCs9iOSWId1oTCa/WUOynT6k9lJ9OF+RLyyiq2
 NC+UGCJsNjd/johK1mfk8vWmSqiKgwtt3huQhV8ow037x1kPBg4OWPhKVeP58XK7Nb
 wUU9swqED3GM9wZGL2Iu2yPrX0o3whoostWifkvFW0O4bN9bDQYkaUNqk1Pz//NZAL
 M2n3yfiYjnBQ7UMfKU30m7r1Xd52DV7Hqi/kB8fDfwVHO6G2x9DY7RS/v/NrQHv8qT
 TCXc7Et9LUBNeq2K0i9nAnr5BoeCrsf6ES43ro98I0bPis5yf9vB88uZFq3FwI1zoO
 aFATCSZtqwIOw==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-412ae5704f7so15926955e9.1
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 14:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709938156; x=1710542956;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E34F9jdRhIZjQjzeHxJJK9pf+38+4UvWwbXvwIxjQCU=;
 b=L3xpB5HvHs7wrBFv3U2NHRuH9d/SKM+fzaOS/nWbfqmPI1NLaw0TwQMApacYlb0R80
 vv/k18T8jV6djznfwnSNfknAreHfOAfxeuA21a0ulpe21OtAlKsrWPnNsFYKdWxcR8pf
 Z1njgsfgT+tyVPl05Kf5wl4GY+LufmFrntKQnRH0DudOwPa2fq8LCcN4KUNfDPiu5qW8
 dXicg6yb6CwOXBA43A1+GhPFjstcvg5jlyVmcwHi812+ZMcH6Pg0zQSXITA7TYhzluYz
 aLBUT/ULZZlHLKF4a7/VVNxcX3EYlqwB9M/6xR+zv24K/NQSFSjGkQ16ufKjeHe+Kkvz
 EG1w==
X-Gm-Message-State: AOJu0YwWDybfXqUNUtRr8dr63bwGoGKiPu6HNlDSp5uYeuDpfu0mSgYl
 8rAHpx6b6P8lJWpTP1XMH8++Oeksiv+x7ZrdPbDfhk2L6qDQe8pH365vPlW0WAdXDl/HmqsTCZp
 GghYb8NY6Ncb5cORTBnWLW+M3RMrhA70+41vtGd/JHBLAfRun418WOcU+E5REE1Q/kdk=
X-Received: by 2002:a05:600c:19cf:b0:412:b42c:8ff1 with SMTP id
 u15-20020a05600c19cf00b00412b42c8ff1mr431906wmq.21.1709938156040; 
 Fri, 08 Mar 2024 14:49:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IES+4TcVZYgEh+CaXFA8Llm8w5P0X/9c5tx7xx1EYDUX6OE4Dsb9uQwD9slanVWE1rO/kVHDQ==
X-Received: by 2002:a05:600c:19cf:b0:412:b42c:8ff1 with SMTP id
 u15-20020a05600c19cf00b00412b42c8ff1mr431890wmq.21.1709938155547; 
 Fri, 08 Mar 2024 14:49:15 -0800 (PST)
Received: from ?IPV6:2a00:20:9:393f:9c69:8137:bdc0:ae98?
 ([2a00:20:9:393f:9c69:8137:bdc0:ae98])
 by smtp.gmail.com with ESMTPSA id
 l16-20020a5d6690000000b0033e0ed396bdsm446256wru.106.2024.03.08.14.49.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 14:49:15 -0800 (PST)
Message-ID: <fe5fc9bb-add7-4be2-b1d1-d4cf379467b3@canonical.com>
Date: Fri, 8 Mar 2024 23:49:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/5] doc: describe Milk-V Mars board
To: E Shattow <lucent@gmail.com>
Cc: u-boot@lists.denx.de, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Shiji Yang <yangshiji66@outlook.com>,
 Shengyu Qu <wiagn233@outlook.com>, Seung-Woo Kim <sw0312.kim@samsung.com>
References: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
 <20240303130122.29983-6-heinrich.schuchardt@canonical.com>
 <CANV2PTOCK--hOr_HbbjHcjYT40fVm5DD2GsfV3cZu2XFm7WX=Q@mail.gmail.com>
 <937b1f61-7412-4609-b9a5-549d7fd6a950@canonical.com>
 <CANV2PTOUip_ebfFiP5UaXBCENRdR6f2kZpPKU1p9ODbjS5gmrg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CANV2PTOUip_ebfFiP5UaXBCENRdR6f2kZpPKU1p9ODbjS5gmrg@mail.gmail.com>
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

On 3/8/24 22:48, E Shattow wrote:
> Yes this reference to GPIO high/low states is clearer to understand. 
> Have you tested the DIP switch functionality to confirm?; It is not 
> shown in the MilkV documentation or outdated schematics and I don't have 
> a Mars to test. I did find function descriptions from what is likely 
> cut-and-paste of VisionFive2 board reference.
> 
> Ref: 
> https://github.com/milkv-mars/mars-files/blob/main/Mars_hardware_schematics/Mars_V1.11_20230821.pdf <https://github.com/milkv-mars/mars-files/blob/main/Mars_hardware_schematics/Mars_V1.11_20230821.pdf> Sheet 7 of 22 JH7110 GPIOs
> There is a schematic for SW2 (bootloader button?) that lists an inset table:
> * - GPIO_1
>    - GPIO_0
>    - Boot
> * - 0
>    - 0
>    - Flash
> * - 0
>    - 1
>    - SD
> * - 1
>    - 0
>    - eMMC
> * - 1
>    - 1
>    - UART
> 
> That circuit on SW2 appears to pull high both RGPIO_1 and RGPIO_0 with 
> transistors. Again, no DIP switch as this is an earlier revision.
> 
> Ref: 
> https://doc-en.rvspace.org/VisionFive2/Developer_Guide/JH7110_Boot_UG.pdf <https://doc-en.rvspace.org/VisionFive2/Developer_Guide/JH7110_Boot_UG.pdf>  page 9 table 1-4:
> RGPIO1=0x0 RGPIO0=0x0 Boot Source: Quad SPI NOR flash memory, Read SPL 
> from Sector 0.
> RGPIO1=0x1 RGPIO0=0x1 Boot Source: UART0, (description of UART Xmodem 
> function).
> 
> Following in the same document on page 13 figure 2-1 Boot Flow:
> JH7110supportsthefollowingbootdevices.
> QSPIFlash(ForSPL + OpenSBI + 
> U-Boot)+NVMe/SDCard/eMMC(ForKernel+FileSystemandlater)
> Note: 
> System will detect in sequence whether it can boot from the following 
> device sequence: NVMe > SD > eMMC.
> For example,if the boot program is found on the SD, eMMC will be ignored.

The GPIOs select from where U-Boot SPL is loaded. Currently U-Boot SPL 
loads main U-Boot from the same device. But you could change it to scan 
multiple devices for main U-Boot.

Once you have successfully loaded main U-Boot, main U-Boot will scan the 
different boot devices. This includes NVME, eMMC, SD, USB, Network.

Currently upstream U-Boot development is moving from hard coded 
sequences in board files to configurable boot sequences.

> 
> Again in this document Figure 4-2 on page 17 is a visual listing of the 
> DIP switch positions for QSPI, SDIO, eMMC, and UART boot modes, of the 
> VisionFive2 board.

These are just the same switches as on the Milk-V.

> 
> The only consistent physical interface over VisionFive2, Mars, Star64, 
> Mars CM all is RGPIO1=L RGPIO0=L SPI and RGPIO1=H RGPIO1=H UART; either 
> by DIP switch or pushbutton attached circuit. So, I question our 
> assumptions about what the actual behavior is for RGPIO1=H RGPIO0=L 
> pairing and RGPIO1=L RGPIO0=H, and in what circumstance would there be 
> followed a device sequence as suggested by the JH7110 reference. Why 
> does the StarFive documentation list a JH7110 boot device sequence if 
> there is also these H+L or L+H pairings to choose the device?

As said the device sequence including NVMe is not realized by the code 
loading U-Boot SPL. It is realized in main U-Boot.

Best regards

Heinrich

> 
> On Thu, Mar 7, 2024 at 6:37 PM Heinrich Schuchardt 
> <heinrich.schuchardt@canonical.com 
> <mailto:heinrich.schuchardt@canonical.com>> wrote:
> 
>     On 3/8/24 00:20, E Shattow wrote:
>      >
>      > On Sun, Mar 3, 2024 at 5:02 AM Heinrich Schuchardt
>      > <heinrich.schuchardt@canonical.com
>     <mailto:heinrich.schuchardt@canonical.com>
>      > <mailto:heinrich.schuchardt@canonical.com
>     <mailto:heinrich.schuchardt@canonical.com>>> wrote:
>      > ...
>      >
>      >     +The board provides the DIP switches MSEL[1:0] to select the boot
>      >     device out of
>      >     +SPI flash, eMMC, SD-card, UART. To select booting from
>     SD-card set
>      >     the DIP
>      >     +switches MSEL[1:0] to 10.
>      >
>      >
>      > This does not match the [Milk-V Mars vendor
>      >
>     documentation](https://milkv.io/docs/mars/getting-started/bootloader
>     <https://milkv.io/docs/mars/getting-started/bootloader>
>      > <https://milkv.io/docs/mars/getting-started/bootloader
>     <https://milkv.io/docs/mars/getting-started/bootloader>>). Maybe you
>     have
>      > a different board revision?
> 
>     Thank you for reviewing.
> 
>     My board revision is V1.21 according to the silk screen.
> 
>     The Milk-V Mars has DIP switches for the boot selection as shown in
>     https://gist.github.com/xypron/e28f95b1ed6911aeb9699ba63ae1a885
>     <https://gist.github.com/xypron/e28f95b1ed6911aeb9699ba63ae1a885>
> 
>     If you look at the photo
>     https://milkv.io/assets/images/mars-icon-04-e8814f18158a0e9d4387f4fa330693f1.webp <https://milkv.io/assets/images/mars-icon-04-e8814f18158a0e9d4387f4fa330693f1.webp>
>     in the https://milkv.io/mars <https://milkv.io/mars> page, it also
>     shows DIP switches (in the
>     SPI-Flash position) on a rev 1.2 board.
> 
>     Did you see a board without DIP switches being sold?
> 
>     The silk screen markings on the board and the switch don't match.
>     The same confusion exists on the VisionFive2.
> 
>     So maybe I should better write in a table:
> 
>     SPI-Flash:
>     GPIO0=L
>     GPIO1=L
> 
>     SD-Card:
>     GPIO0=H
>     GPIO1=L
> 
>     eMMC:
>     GPIO0=L
>     GPIO1=H
> 
>     UART:
>     GPIO0=H
>     GPIO1=H
> 
>     Best regards
> 
>     Heinrich
> 

