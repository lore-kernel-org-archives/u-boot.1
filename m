Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24988CA0FF2
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 13:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 750C688BE1;
	Fri, 30 Aug 2024 15:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o+e+Wsqk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D16588C09; Fri, 30 Aug 2024 14:18:08 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E888388B55
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 14:18:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-374b9761eecso171352f8f.2
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 05:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725020285; x=1725625085; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LIybKjA5GJlvqcPErCY/klyDulg/A7vSXQm5yrPnzlc=;
 b=o+e+WsqkFQKNfG3E3L+KtpTuH1zUo3ALvB4NqH+JdE6jseIZZCYDmxeNvErkzV4u0r
 Cfh5b8dGheOJ0XL/ZeUEhuflIn66X/ZGxJ2jKbnXkq1yNVfgmyp8/pgvoTW6gjP0oxvk
 oW2QSZimU+t0pMsULYdTGEp2ioa+D4Yy/wZECMdxhGjnEJlZP9t4GZU7HjurIaEKbsLO
 a+5kLM3wuaB/J8G73WOyzZ+GhGfMJW5aXeptqmNSgKP5HacQQWKvcM3MtcZO0gyoNtgg
 bdq09S86sLVS25K3anZ9YJQKGHLPKOi2ESadtV9CxQAm8CSLOVFY7G+uSyx/P/runY/8
 OyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725020285; x=1725625085;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LIybKjA5GJlvqcPErCY/klyDulg/A7vSXQm5yrPnzlc=;
 b=wmD/TRNGWvU2mEIIjWUDAQm8nYcJy5J2BuUtgoWDJZ82496WFi9OhGAWx4NavPQ4zT
 n/1WvSbcFczsKbpq6yt8SLf52yCcP2VPWN5AU+ZSYgKaTnvpW3Zzd8dGYe3p0sWP9PGh
 dE9C6F/KagM57Teg+ehrJwARKrGwLI3zp+trjHahZVi9oC8QXzXFwwCHgSgI350NX4Ls
 t2zqZR8829UJuwSTjNtGbvBJmqlbNOKNI5w2uvoxrtclgz1+CIqkmToa5WGZNaWVk4ql
 xMEqUl1VeIeo29Y1q7bjfg2Aj+XeGQoJktqhTBUvWMB6yT/Rv4WZUsTxSnJBW0t9bRHD
 V9Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlJsKNzt/ou/B+Uislw6YD/9Jc7xhVdrYqFf2q7stOPjX8cccq7/AYZ5u8iZmSsnTRc/Yiitw=@lists.denx.de
X-Gm-Message-State: AOJu0YzaTEU+mj8kPWgTa8PRn/Z1Qwaw/ldamOHaC2V/Hskf8I3B6AJQ
 M7lkEbF4vgsOf/YUYKclfUrqj4LVPWwYAiIBeJWI0O0DP7oE2amUByg8YrOxV7Q=
X-Google-Smtp-Source: AGHT+IE6wK5DMo3VFMYzjJH8224IXynParx0Hs4y8H0SZHv8CTP6E9Ob70e1zP5dSbKtJVllrrY2mw==
X-Received: by 2002:a5d:65d1:0:b0:371:8c75:a085 with SMTP id
 ffacd0b85a97d-3749b588137mr3696824f8f.58.1725020285230; 
 Fri, 30 Aug 2024 05:18:05 -0700 (PDT)
Received: from [192.168.1.17] (host-80-47-105-51.as13285.net. [80.47.105.51])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ee99d6dsm3918341f8f.48.2024.08.30.05.18.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Aug 2024 05:18:04 -0700 (PDT)
Message-ID: <58cd740a-da83-4ce2-91de-5fc228977e75@linaro.org>
Date: Fri, 30 Aug 2024 13:18:02 +0100
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 00/19] vbe: Series part E
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>, Devarsh Thakkar <devarsht@ti.com>,
 Eddie James <eajames@linux.ibm.com>, Gary Bisson <bisson.gary@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>, Kever Yang
 <kever.yang@rock-chips.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nam Cao <namcao@linutronix.de>, Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
References: <20240829145802.1827952-1-sjg@chromium.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240829145802.1827952-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 30 Aug 2024 15:31:35 +0200
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

Hi Simon,

On 29/08/2024 15:57, Simon Glass wrote:
> 
> This includes various patches towards implementing the VBE abrec
> bootmeth in U-Boot. It mostly focuses on SPL tweaks and adjusting what
> fatures are available in VPL.

It would be helpful if you could include some context as to what VBE is, 
how this series fits in to previous ones, etc... If this is part of some 
overarching changes then having some common background justification / 
context which is copy-pasted to all the relevant patch series would make 
sense imo.

Thanks and regards,
> 
> 
> Simon Glass (19):
>    image: Add a prototype for fit_image_get_phase()
>    serial: ns16550: Allow clocks to be missing
>    boot: Allow FIT to fall back from best-match option
>    bootstd: Avoid sprintf() in SPL when creating bootdevs
>    boot: Respect the load_op in fit_image_load()
>    malloc: Show amount of used space when memory runs out
>    malloc: Provide a simple malloc for VPL
>    Support setting a maximum size for the VPL image
>    spl: Report a loader failure
>    spl: Allow serial to be disabled in any XPL phase
>    spl: Support a relocated stack in any XPL phase
>    spl: Drop use of uintptr_t
>    spl: Drop a duplicate variable in boot_from_devices()
>    spl: Add some more debugging to load_simple_fit()
>    spl: lib: Allow for decompression in any SPL build
>    boot: Allow use of FIT in TPL and VPL
>    lib: Allow crc8 in TPL and VPL
>    boot: Imply CRC8 with VBE
>    hash: Plumb crc8 into the hash functions
> 
>   boot/Kconfig                  | 71 ++++++++++++++++++++++++++++++++++-
>   boot/Makefile                 |  4 +-
>   boot/bootdev-uclass.c         | 10 ++++-
>   boot/image-fit.c              | 29 ++++++++------
>   common/hash.c                 |  8 ++++
>   common/malloc_simple.c        |  3 +-
>   common/spl/Kconfig.vpl        | 17 +++++++++
>   common/spl/spl.c              | 15 +++++---
>   common/spl/spl_atf.c          | 36 +++++++++---------
>   common/spl/spl_fit.c          | 12 +++++-
>   common/spl/spl_legacy.c       |  8 ++--
>   configs/sandbox_vpl_defconfig |  3 +-
>   drivers/serial/ns16550.c      |  2 +-
>   include/image.h               | 16 +++++++-
>   include/spl.h                 | 28 +++++++-------
>   include/u-boot/crc.h          |  3 ++
>   lib/Kconfig                   | 53 ++++++++++++++++++++++++++
>   lib/Makefile                  |  8 ++--
>   lib/crc8.c                    |  6 +++
>   19 files changed, 263 insertions(+), 69 deletions(-)
> 

-- 
// Caleb (they/them)
