Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC29D6EBF7
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 10:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE5BB89293;
	Fri, 29 Nov 2024 11:35:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j+xk8nR1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12BFB892A1; Fri, 29 Nov 2024 11:35:36 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAA8E8928C
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 11:35:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434a2033562so15558875e9.1
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 02:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732876533; x=1733481333; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tNZZ78U8zz+RBxTFGavWAPvKBajiAS/sZfmF9zj+TqU=;
 b=j+xk8nR1vxdnuNTXQh8uGcOgwvqag1Qq65cM6tQfByiXDOFfK7I3+Mfef96r2reWz+
 7wf2hExDMXSAATLMU+K5YOQSyurzCvY2RzjC9e0/yGRBR5mK8WFCX4MR5+Q5uNWK1Ixo
 gheN47HTe18Ul0jcHheNPKw3Y98NJnCpFA5VHRztJYkQuQwnmcK3dGnsTF3ESgJBK6ni
 /Sib83r+sQ++6OaUITIf9sjgxbKXRuIYEXCaq+mYXN0/T2aV25fUxtDpF4GWGsAZjf9h
 PK1yMAH2rEBaoVLMNM6PkyzSrqNJXoApkC7ZXmMCzYYHkzV6cjUSy9UwYDz/xPaC90nQ
 3KJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732876533; x=1733481333;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tNZZ78U8zz+RBxTFGavWAPvKBajiAS/sZfmF9zj+TqU=;
 b=nGOvhWQUtbY/WM828HoAJrJIBb+1uUcqs9QOsIxI7EkfnQxvhEJe4sthxd5Zec1wMO
 QPEa1i7d+Hzv+hvgffNi/nl+eElgpezv3mV04w7UNuZxaRNi01fZx+Lno6y8YdATC5qZ
 4MK2N9ur/IouEaUTsMZBVounBGYp1H1xo7tZpLcaX+GvznyZIOo3u2B5Sqz2hN8Z3/VA
 iZnV3RHZOhYNvnnxUBFVq7dnk8OGxVl0P2qLVSIOc4mfwiV4Dgwnea+xq1/S4I4i6zg1
 6WoNpVpPdl8ke8gIyXoFbbSEhjcMOilqwuuOTPR0/+HnLzI2juq2hGVzoi8Wf37GbjK+
 wlKg==
X-Gm-Message-State: AOJu0Yx88mSp+evGvTUlZJ42L3OrJgT8T9iqMOKlM0IH8I7DTCY4qXDz
 SbT359wkDEir7U1r1W62xz7pldR+k92HGUUQOg3rwbmEVZuUoWt18CkcJswJJVl/koOoQ8ktKr9
 bLro=
X-Gm-Gg: ASbGncsY6XdBf0ROQ8FOMvbPdBKxQzniiGPQLyEXhf01CcwUHp9ZjXIJw5ZfOS8wmk6
 h+CWUmUu6+0LNNcrNyafGogLQj82XGz/e8Tc9Lqz0u5E8SXCxhH/V5yF2cgA85vjDuY2FERgEiD
 wl7Q4B55OIJlXqBGY63HG4S2xvbl8B53ttZk4M6QC86EerB00MYZWjIwc60/P9fybuDHO2Sv/kB
 N5TXY34eiUlm4am/dbCoquBn+jZd2HBxBpzZ4z8FDEC21kIDSn4NIjtS1kPS8Xev4VvZdwVZv5N
 1OStkZlBYLvi3m3QuFcHFl+TuSw=
X-Google-Smtp-Source: AGHT+IHUe/g+7JgI/N8QWN6JnNd951nU2pV1QgSF1xmxxG34+Eh84jM257pdAwlAkKeydfWr8eAKCg==
X-Received: by 2002:a05:600c:5101:b0:434:9dfe:20e6 with SMTP id
 5b1f17b1804b1-434a9df71c6mr89078875e9.23.1732876533237; 
 Fri, 29 Nov 2024 02:35:33 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:f16:2001:b150:7c3f:abc:d9eb?
 ([2a0a:ef40:f16:2001:b150:7c3f:abc:d9eb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385deeb6acdsm1351285f8f.81.2024.11.29.02.35.32
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 02:35:32 -0800 (PST)
Message-ID: <85619442-4c18-4cec-8176-d7239e023474@linaro.org>
Date: Fri, 29 Nov 2024 10:35:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Environment: Change reporting "nowhere" as "magic hat" to
 user
To: u-boot@lists.denx.de
References: <20241128151233.1962926-1-alicja.michalska@9elements.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20241128151233.1962926-1-alicja.michalska@9elements.com>
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

On 28/11/2024 15:12, Alicja Michalska wrote:
> Make string more user-friendly

I disagree. I can make a guess as to what 'Loading Environment from 
nowhere' means. To me it suggests that it has not found anywhere 
additional to load an environment from. It is a bit awkwardly phrased 
but it can be understood and it at least sticks to reality.
As for 'Loading Environment from a magic hat' - I have no idea what that 
is trying to convey and that lack of meaning is not, IMO, user-friendly.

Andrew

> Signed-off-by: Alicja Michalska <alicja.michalska@9elements.com>
> ---
>   doc/arch/sandbox/sandbox.rst       | 2 +-
>   doc/board/emulation/qemu-x86.rst   | 2 +-
>   doc/board/sophgo/milkv_duo.rst     | 2 +-
>   doc/board/starfive/visionfive2.rst | 2 +-
>   doc/develop/uefi/u-boot_on_efi.rst | 2 +-
>   env/nowhere.c                      | 2 +-
>   test/py/tests/test_env.py          | 4 ++--
>   7 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
> index a8b0d7f039..d88f05285e 100644
> --- a/doc/arch/sandbox/sandbox.rst
> +++ b/doc/arch/sandbox/sandbox.rst
> @@ -469,7 +469,7 @@ Here is an example trace::
>      Address in environment is	02:00:11:22:33:44
>      Core:  103 devices, 51 uclasses, devicetree: board
>      MMC:
> -   Loading Environment from nowhere... OK
> +   Loading Environment from a magic hat... OK
>      In:    serial,cros-ec-keyb,usbkbd
>      Out:   serial,vidconsole
>      Err:   serial,vidconsole
> diff --git a/doc/board/emulation/qemu-x86.rst b/doc/board/emulation/qemu-x86.rst
> index c604e42990..06e9dcd999 100644
> --- a/doc/board/emulation/qemu-x86.rst
> +++ b/doc/board/emulation/qemu-x86.rst
> @@ -142,7 +142,7 @@ The output will be something like this::
>      CPU:   QEMU Virtual CPU version 2.5+
>      DRAM:  8 GiB
>      Core:  20 devices, 13 uclasses, devicetree: separate
> -   Loading Environment from nowhere... OK
> +   Loading Environment from a magic hat... OK
>      Model: QEMU x86 (I440FX)
>      Net:   e1000: 52:54:00:12:34:56
>             eth0: e1000#0
> diff --git a/doc/board/sophgo/milkv_duo.rst b/doc/board/sophgo/milkv_duo.rst
> index cb2ed1ad98..243468bf10 100644
> --- a/doc/board/sophgo/milkv_duo.rst
> +++ b/doc/board/sophgo/milkv_duo.rst
> @@ -53,7 +53,7 @@ Sample boot log from Milk-V Duo board
>   
>      DRAM:  63.3 MiB
>      Core:  10 devices, 8 uclasses, devicetree: separate
> -   Loading Environment from nowhere... OK
> +   Loading Environment from a magic hat... OK
>      In:    serial@4140000
>      Out:   serial@4140000
>      Err:   serial@4140000
> diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
> index 2c68df3ce4..7a926dc021 100644
> --- a/doc/board/starfive/visionfive2.rst
> +++ b/doc/board/starfive/visionfive2.rst
> @@ -209,7 +209,7 @@ Sample boot log from StarFive VisionFive2 board
>   	DRAM:  8 GiB
>   	Core:  107 devices, 18 uclasses, devicetree: separate
>   	MMC:   mmc@16010000: 0, mmc@16020000: 1
> -	Loading Environment from nowhere... OK
> +	Loading Environment from a magic hat... OK
>   	In:    serial@10000000
>   	Out:   serial@10000000
>   	Err:   serial@10000000
> diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boot_on_efi.rst
> index 245b4af1fa..dbc2b74c6e 100644
> --- a/doc/develop/uefi/u-boot_on_efi.rst
> +++ b/doc/develop/uefi/u-boot_on_efi.rst
> @@ -230,7 +230,7 @@ This shows running with serial enabled (see `include/configs/efi-x86_app.h`)::
>      DRAM:  32 MiB
>       0: efi_media_0  PciRoot(0x0)/Pci(0x3,0x0)/Sata(0x0,0xFFFF,0x0)
>       1: <partition>  PciRoot(0x0)/Pci(0x3,0x0)/Sata(0x0,0xFFFF,0x0)/HD(1,GPT,0FFD5E61-3B0C-4326-8049-BDCDC910AF72,0x800,0xB000)
> -   Loading Environment from nowhere... OK
> +   Loading Environment from a magic hat... OK
>      Model: EFI x86 Application
>      Hit any key to stop autoboot:  0
>   
> diff --git a/env/nowhere.c b/env/nowhere.c
> index 6b9b6e2fe0..63fc4647f6 100644
> --- a/env/nowhere.c
> +++ b/env/nowhere.c
> @@ -45,5 +45,5 @@ U_BOOT_ENV_LOCATION(nowhere) = {
>   	.location	= ENVL_NOWHERE,
>   	.init		= env_nowhere_init,
>   	.load		= env_nowhere_load,
> -	ENV_NAME("nowhere")
> +	ENV_NAME("a magic hat")
>   };
> diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
> index 4471db7d9c..3cd06c5c90 100644
> --- a/test/py/tests/test_env.py
> +++ b/test/py/tests/test_env.py
> @@ -527,10 +527,10 @@ def test_env_ext4(state_test_env):
>   
>           # restore env location: NOWHERE (prio 0 in sandbox)
>           response = c.run_command('env select nowhere')
> -        assert 'Select Environment on nowhere: OK' in response
> +        assert 'Select Environment from a magic hat: OK' in response
>   
>           response = c.run_command('env load')
> -        assert 'Loading Environment from nowhere... OK' in response
> +        assert 'Loading Environment from a magic hat... OK' in response
>   
>           response = c.run_command('env info')
>           assert 'env_valid = invalid' in response

