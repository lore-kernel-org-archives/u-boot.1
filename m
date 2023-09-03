Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE742C83F2D
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 08:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B21098144A;
	Sun,  3 Sep 2023 10:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rkfJRNjK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BACD486411; Sun,  3 Sep 2023 10:36:18 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C348D80DF7
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 10:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52a0856b4fdso530851a12.1
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 01:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693730175; x=1694334975; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+G5QYVL3+hvY85o0CjD5TRSPpqGwNv93hSonhwNSf5I=;
 b=rkfJRNjKB9PQHc+o+iqLY496bL21NgvQuKP+O5KPg7n/iuwnfrkooIlRyZUFMiNS3o
 JSQFLNQ2vOKhNAYMsobR5c7o5dsRCBCeK1+nMFCbV0PwzTBDau/LhN2nwW2NChcoyTnN
 BOkiCVy16wYNl/Ez0wzgrrYzHXbAo9MPxzklPsR+/b2UfMux5u/Gnlqb2zDzrmg4cLWh
 OXRDOah+juzp7SIW6Dufe3gFZ3WhRs5ZEFWLXxP3JetX/IwaiYSkQNwRCsTN11Ouqq34
 N0Y1zSUJl2l9mBTvuFLu7yxxxmCe7Y9HpjNqdVzZQJDFeLZnv4+oTvPd+rNczfI48OUv
 besA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693730175; x=1694334975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+G5QYVL3+hvY85o0CjD5TRSPpqGwNv93hSonhwNSf5I=;
 b=BTwMEbTYHpY/ap/ZmDj96xZ5sgAzQgvVHq/zvvSo/N2+ivkjLlBoR6+ROcKhwJ9Y98
 B5fqASUy90t5zT2mmAqC1pno+xjAREm62iZFTSjIYKuhWlrbpOtxJVq5Yw0VW+F7+pPx
 yIuIJSYpqL5pj0K96RgQQvpSJEg+pe99SfurSOUQa1LB1efqY1l0uNVW4sY3eXa31YS5
 KQXTceJLgryLbYlNX+P34bkADd7XQ7jVa93Gbjmb44iTP+iKHhynLkns89zgVwka1FKZ
 Z7E1eopKlqNIk3U4ugl8rk8oXFbtbZpg4f3IjxuS0fARaUo2f2k5C7pXY8EtgZIah5mD
 CgEQ==
X-Gm-Message-State: AOJu0YxMgEY35rB4qPqI/thR1bc6wm+ng50VxOUvmq1WxIHbtEWx31HU
 zyswtJMtbV/njf84z8vwawI=
X-Google-Smtp-Source: AGHT+IH+VivfYye3tgvwlrfTXOrsiTXiDLwIqPfgx63wLrZNHGzDAYMxISM3yA2sBiT09wbzkKIutA==
X-Received: by 2002:a17:906:cc18:b0:9a2:24c8:4d82 with SMTP id
 ml24-20020a170906cc1800b009a224c84d82mr5001428ejb.64.1693730175129; 
 Sun, 03 Sep 2023 01:36:15 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 i27-20020a1709063c5b00b009a1fd22257fsm4456499ejg.207.2023.09.03.01.36.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Sep 2023 01:36:14 -0700 (PDT)
Message-ID: <56b4c1d1-e86c-722c-c9fa-87082cae8307@gmail.com>
Date: Sun, 3 Sep 2023 10:36:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] doc: rockchip: Update and complete info about RK3308
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@edgeble.ai>, FUKAUMI Naoki <naoki@radxa.com>
References: <20230902163212.343746-1-massimo.pegorer+oss@gmail.com>
Content-Language: en-US
From: Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20230902163212.343746-1-massimo.pegorer+oss@gmail.com>
Content-Type: text/plain; charset=UTF-8
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



On 9/2/23 18:32, Massimo Pegorer wrote:
> Update documentation about build steps for RK3308, using an external
> TPL. Add RK3308 case to rST document. Add ROCK Pi S in the list of
> supported boards.
> 
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>  doc/README.rockchip             |  4 ++--
>  doc/board/rockchip/rockchip.rst | 10 ++++++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/README.rockchip b/doc/README.rockchip
> index 52b5140eca..cfbd858c3b 100644
> --- a/doc/README.rockchip
> +++ b/doc/README.rockchip
> @@ -38,16 +38,16 @@ Building
>      (or you can use another cross compiler if you prefer)
>  

>  2. To build RK3308 board:
> +
>     - Get the rkbin
>       => git clone https://github.com/rockchip-linux/rkbin.git
>  
>     - Compile U-Boot
>       => cd /path/to/u-boot
>       => export BL31=/path/to/rkbin/bin/rk33/rk3308_bl31_v2.22.elf
> +     => export ROCKCHIP_TPL=/path/to/rkbin/bin/rk33/rk3308_ddr_589MHz_uart2_m0_v1.26.bin
>       => make roc-cc-rk3308_defconfig
>       => make CROSS_COMPILE=aarch64-linux-gnu- all
> -     => ./tools/mkimage -n rk3308 -T rksd -d /path/to/rkbin/bin/rk33/rk3308_ddr_589MHz_uart2_m0_v1.26.bin idbloader.img
> -     => cat spl/u-boot-spl.bin  >> idbloader.img
>  

Hi Massimo,

The text in this document should moved to doc/board/rockchip.
This paragraph above is therefor redundant, so it can be removed I think.

Johan

>  3. To build RK3399 board:
>  
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index de9fe8e642..b38c3d3136 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -53,6 +53,7 @@ List of mainline supported Rockchip boards:
>       - Google Speedy (chromebook_speedy)
>       - Amarula Vyasa-RK3288 (vyasa-rk3288)
>  * rk3308
> +     - Radxa ROCK Pi S (rock-pi-s-rk3308)
>       - Rockchip Evb-RK3308 (evb-rk3308)
>       - Roc-cc-RK3308 (roc-cc-rk3308)
>  * rk3326
> @@ -172,6 +173,15 @@ To build rk3288 boards:
>          make evb-rk3288_defconfig
>          make CROSS_COMPILE=arm-linux-gnueabihf-
>  
> +To build rk3308 boards:
> +
> +.. code-block:: bash
> +
> +        export BL31=../rkbin/bin/rk33/rk3308_bl31_vX.YZ.elf
> +        export ROCKCHIP_TPL=../rkbin/bin/rk33/rk3308_ddr_589MHz_uart0_m0_vX.YZ.bin
> +        make evb-rk3308_defconfig
> +        make CROSS_COMPILE=aarch64-linux-gnu-
> +
>  To build rk3328 boards:
>  
>  .. code-block:: bash
