Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C946BC197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 14:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47BF186FA7;
	Fri, 17 Nov 2023 15:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="xFDj/1MK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B79C86FF7; Fri, 17 Nov 2023 15:27:19 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1456686FA7
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 15:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.naour@smile.fr
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32fb190bf9bso1960539f8f.1
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 06:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1700231229; x=1700836029;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kvcd1+sIdHMeL1k2mZq5OVdttHFBT5I6RPylMKqk6WM=;
 b=xFDj/1MKYMbbICf/4d7cTbheTwYiSCyfNKU12gdAamiZZBAtT2o7Wc2bP+iZPzdh3T
 IaecysFvx8mgUdahMy9L4T+FezjMwvSQC521+3LqdnuGrKi5tnbMbAzbOj5yNnzY40Ik
 043FLXNbMqNRRzLsiUM5TFIp7LKWLrLXSe8SthWwOVq7Nq1ocIXAqo69OHg7Afp4194S
 Ln9vVRkmFQ0xDDB+CFZf4hMrbriyyQJlCKhCQGGJhuZy//5J6dbuFTz6xEZ104FE//eY
 tkbL5mxaWZexctVIxqwyYSF6hb6FdGDJvcBtVMpf3gHvfIoAhi57CsyYwGs6rvYnlLSS
 Jh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700231229; x=1700836029;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kvcd1+sIdHMeL1k2mZq5OVdttHFBT5I6RPylMKqk6WM=;
 b=Thp8to/88lvUJMOfmdRn069g4idLd1wcAWaVMsvla0xr7owS9qeHoKPYXkrUA8u5Mu
 Ug7vRMge7gaDJ16MmULMirvCZk6GG4lVDmEiZuRpI/P917+kDsIrQi1YifDxqJLm250R
 Yn8rCnObaKcUCP6bObTaVAujFXhm/y3zJFvjf4a6tRbAR8brcHdRo8Vwh0VlUX3SBzdh
 OVmf1barYvPho4OzrHWPWLz7d/RnczfRq9ct5vHZgQTC6yvghXM6hW5VMY09yhJ//fXJ
 P5U72pMk1gbo57p5rgPzxXPRp68BlUhPw8yI+OBcIO14/oBN+Sz0scBBfewwVWPKeHCY
 sTdg==
X-Gm-Message-State: AOJu0YxS4gZV3rxEAy+C3ghvQe57rIYHQL7c1S45OIHiJCchAdxl7vO0
 QL49/1s9VPk3Q2dXUhUEgd+qzw==
X-Google-Smtp-Source: AGHT+IELFUfVb8zGHTWRtmmI+Uwp4l8QwTW176qgKiTm0NS2/1TPjsb5OzzwKyqbQNmp1GvE0UiGyA==
X-Received: by 2002:adf:ffc3:0:b0:32f:952f:c51c with SMTP id
 x3-20020adfffc3000000b0032f952fc51cmr3701524wrs.18.1700231229389; 
 Fri, 17 Nov 2023 06:27:09 -0800 (PST)
Received: from ?IPV6:2a01:cb05:945b:7e00:9bdc:6887:23a2:4f31?
 (2a01cb05945b7e009bdc688723a24f31.ipv6.abo.wanadoo.fr.
 [2a01:cb05:945b:7e00:9bdc:6887:23a2:4f31])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a5d45c8000000b003142e438e8csm2465602wrs.26.2023.11.17.06.27.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 06:27:08 -0800 (PST)
Message-ID: <e65bb379-d4e4-4c05-9855-b69443886ebd@smile.fr>
Date: Fri, 17 Nov 2023 15:27:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] board: ti: Add j721e_beagleboneai64_* config
 fragments and env file
Content-Language: fr, en-US
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sinthu Raja <sinthu.raja@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Reid Tonking <reidt@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, u-boot@lists.denx.de
References: <20231103003805.2420005-1-nm@ti.com>
 <20231103003805.2420005-15-nm@ti.com>
 <f0f4b6af-9831-4231-8316-1e0b0dd2dab2@ti.com>
 <20231103190629.flhz4cr5wyjyym2g@remix>
 <ee1eec62-c7ca-450c-959f-f83d5b71f8ca@ti.com>
From: Romain Naour <romain.naour@smile.fr>
In-Reply-To: <ee1eec62-c7ca-450c-959f-f83d5b71f8ca@ti.com>
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

Hello Andrew, All,

Le 03/11/2023 à 20:20, Andrew Davis a écrit :
> On 11/3/23 2:06 PM, Nishanth Menon wrote:
>> On 13:51-20231103, Andrew Davis wrote:
>>> On 11/2/23 7:38 PM, Nishanth Menon wrote:
>>>> Add defconfig fragments for J721E based BeagleBone AI-64 and
>>>> corresponding customized environment.
>>>>
>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>> ---
>>>>    board/ti/j721e/beagleboneai64.env        | 19 ++++++++
>>>>    board/ti/j721e/beagleboneai64_a72.config | 55 ++++++++++++++++++++++++
>>>>    board/ti/j721e/beagleboneai64_r5.config  | 19 ++++++++
>>>
>>> Beagle boards are not TI boards, add the board support to board/beagle/
>>
>> Huh, why bring in commercials and organization changes here? am335x
>> and am62 are under the TI umbrella.
>>
> 
> The SoCs used are yes, the boards are not, we only make our EVM/SK
> line of boards in house.
> 
> We did AM335x wrong, in board/ti/am335x/board.c we tried to support
> like 11 different boards in one file. And while it might have made adding
> our own extra EVMs easier, it only made things less clear for folks trying
> to add their own AM335x based boards[0].
> 
> We don't integrate support for any other board partner like this. Our
> friends over at Toradex or Phytec are currently upstreaming boards based
> on K3 SoCs and in doing so have shown us some areas we can improve.
> 
> We focus on these little short-cuts to make adding our EVMs (or boards
> that look like our EVMs) easy. But that only leads to extra work and
> code duplication for external boards.
> 
> If something is actually common to the SoC then lets move it to
> arch/arm/mach-k3/j721e. Tricks like board-variants.c only hide the
> issue and doesn't help folks wanting to add their boards based on our
> SoCs to their board/<vendor>/ directory.

I'm starting a new custom board bring-up based on a j721e SoC (without any SOM)
and adding a now board variant from the u-boot provided in the TI SDK (based on
2023.04) is far from easy for the reasons mentioned above (extra work and code
duplication for external boards).

Also the build break for j7200/j721e SoC as soon as CONFIG_TARGET_J721E_A72_EVM
and CONFIG_TARGET_J7200_A72_EVM are undefined:

https://source.denx.de/u-boot/u-boot/-/blob/v2023.10/arch/arm/mach-k3/arm64-mmu.c?ref_type=tags#L71

I always wonder if I should work on top of EVMs board or create a new
board/<vendor>/ directory for customer boards.

Best regards,
Romain

> 
> Andrew
> 
> [0] See "Software Design" https://jaycarlson.net/embedded-linux/#am335x
> 
>> $ git grep beagle board/|cut -d ':' -f1|sort -u
>> board/ti/am335x/board.c
>> board/ti/am335x/board.h
>> board/ti/am57xx/board.c
>> board/ti/am62x/beagleplay_a53.config
>> board/ti/am62x/beagleplay_r5.config
>> board/ti/am62x/MAINTAINERS
>> board/ti/beagle/beagle.c
>> board/ti/beagle/Kconfig
>> board/ti/beagle/led.c
>> board/ti/beagle/MAINTAINERS
>> board/ti/beagle/Makefile
>> board/ti/j721e/beagleboneai64_a72.config
>> board/ti/j721e/beagleboneai64_r5.config
>> board/ti/j721e/MAINTAINERS
>> board/timll/devkit8000/README
>>

