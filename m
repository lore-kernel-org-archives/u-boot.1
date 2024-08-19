Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C528EC5320E
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 11:56:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2179D88B66;
	Mon, 19 Aug 2024 13:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wkh7Zn+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2EFF88C14; Mon, 19 Aug 2024 13:56:21 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D942F88993
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 13:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5bef4d9e7f8so1392787a12.2
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 04:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724068579; x=1724673379; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2R1/SqF6JyBDH8RazKQ6ZSgTqH0OSHPa3gbFSRVyUr8=;
 b=Wkh7Zn+M+S6pfgEsmgg7jGKNR3DfP+20oEAY97YecPRPydQYn5Avb+XyJhl/vfylZA
 6C4nuV7rMAbTNf5lHy4Cf8UycDYKi3Nks+JDfUOZsVyks0gdG+zxaa8RPan7L2/xc9Ac
 P/J2RCBqfKmDrNXs+WU5z+oiLEw8G1dl+tO6aFCCeV/37MQaeawjztxGX7lmDDEmWzao
 WK97Us9HQrAvPfeB9sR0AlNhg8tktLMdrkgD6Bdc0Ucv4oOUwP3U9BqLs9zruZL/Swja
 wNI9MnExCsyH69VaOF9TnrJTmFD25k3gypmdbdAZGFNMbh4TNdU8NF+iL8ayeBRwvcxD
 YZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724068579; x=1724673379;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2R1/SqF6JyBDH8RazKQ6ZSgTqH0OSHPa3gbFSRVyUr8=;
 b=pyfRrPdnSjYDvWa7jH+y8FKEEqkXq0IOJy3jfzujUyruZixU3h1oFlFCQ6kT4tm6Bu
 WW4zLIYmIZaGw9JJF59kqPU1AmooEWENNrNgjR05bTQDdChQH9gcaMUrhlwqirVSUr8B
 In43spdnrRyabL4NrOan1JY5rhEM4IsDDPDFcBls5fAbUh4IT9bvf8SZVV1Ecork4UTN
 eDcex3P2AjYP7icIMnxCqtbVI9erfdcU2Jzimws60dpH4Zdz2UCVfY0qgJUWTmSwc5Zc
 YZ3H9TOg95Xis/rLuvYJ4hhLQNLjABw31xuS87+5uZRVq0RYWPT7Zocm+DwEz8UJnOmY
 CKag==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2rv45aIcBKhtXnK+qsaTt2QTmI/7F7iTAuDRmJ+0yC6FcLaBbz8TW7h7XYQ34FqsXNAiFxqz8x7m5L8TXQUIhtfsXHw==
X-Gm-Message-State: AOJu0YwdqdhBOoBKwlI1ckr2BSTz/nfvFMe9jqnIgUXDiwqZS5IH/Hi6
 tl7xymXb4ZssxlC6gGnzGmrHAn5aPXSUC+bNlN7iBxGYi3Fkqs75UeOhMglk9Wg=
X-Google-Smtp-Source: AGHT+IHjOvIEydrRBl90R7DJyXx/NAFCDxtDg76qM0ffIommMyXvnhYXSSKJwQ5TCf0aC9oJCiAmIw==
X-Received: by 2002:a05:6402:5111:b0:5be:db15:b3a9 with SMTP id
 4fb4d7f45d1cf-5bedb15b5c8mr4580568a12.23.1724068579095; 
 Mon, 19 Aug 2024 04:56:19 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::676e? ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebbde5a83sm5553250a12.36.2024.08.19.04.56.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 04:56:18 -0700 (PDT)
Message-ID: <b692118e-7a53-438d-afa6-7109d4d61167@linaro.org>
Date: Mon, 19 Aug 2024 13:56:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] SMBIOS improvements
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen
 <tuomas.tynkkynen@iki.fi>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Alexander Gendin <agendin@matrox.com>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240816154658.1866186-1-raymond.mao@linaro.org>
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

Hi Raymond,

I haven't managed to root cause it yet, but this series seems to make 
the RB3 Gen 2 Qualcomm board hang during relocation.

How early post-relocation does any code here get called?

On 16/08/2024 17:46, Raymond Mao wrote:
> Motivations for changes:
> Current SMBIOS library and command-line tool is not fully matching with
> the requirements:
> 1. Missing support for other mandatory types (#7, #9, #16, #17, #19).
> 2. Only a few platforms support SMBIOS node from the device tree.
> 3. Values of some fields are hardcoded in the library other than fetching
>     from the device hardware.
> 4. Embedded data with dynamic length is not supported (E.g. Contained
>     Object Handles in Type #2 and Contained Elements in Type #3)
> 
> Changes:
> 1. Refactor the SMBIOS library and command-line tool to better align with
>     the SMBIOS spec.
> 2. Create an arch-specific driver for all aarch64-based platforms to fetch
>     SMBIOS private data from the device hardware.
> 3. Create a sysinfo driver to poppulate platform SMBIOS private data.
> 4. Put device tree SMBIOS node as a fallback solution when SMBIOS data is
>     missing from sysinfo driver.
> 5. Add support for Type #7 (Cache Information) and link its handles to
>     Type #4.
> 
> Once this patch is acceptted, subsequent patch sets will add other missing
> types (#9, #16, #17, #19).
> 
> Raymond Mao (10):
>    sysinfo: Add sysinfo API for accessing data area
>    sysinfo: Add sysinfo driver and data structure for SMBIOS
>    smbios: Refactor SMBIOS library
>    smbios: ignore the non-existence of platform sysinfo detect
>    armv8: Add arch-specific sysinfo driver
>    sysinfo: Add sysinfo driver for SMBIOS type 7
>    smbios: Add support to SMBIOS type 7
>    armv8: Add sysinfo driver for cache information
>    configs: Enable sysinfo for QEMU Arm64
>    tests: update smbios pytest
> 
>   arch/arm/cpu/armv8/Makefile      |   5 +
>   arch/arm/cpu/armv8/sysinfo.c     | 391 ++++++++++++++++++++++++++
>   cmd/smbios.c                     | 350 ++++++++++++++++++++++-
>   configs/qemu_arm64_defconfig     |   2 +
>   drivers/misc/Kconfig             |   2 +-
>   drivers/sysinfo/Makefile         |   1 +
>   drivers/sysinfo/smbios_plat.c    | 442 +++++++++++++++++++++++++++++
>   drivers/sysinfo/smbios_plat.h    | 131 +++++++++
>   drivers/sysinfo/sysinfo-uclass.c |  20 ++
>   include/smbios.h                 | 240 ++++++++++++++--
>   include/sysinfo.h                | 124 ++++++++-
>   lib/Makefile                     |   2 +
>   lib/smbios.c                     | 461 ++++++++++++++++++++++++++-----
>   test/py/tests/test_smbios.py     |   2 +-
>   14 files changed, 2058 insertions(+), 115 deletions(-)
>   create mode 100644 arch/arm/cpu/armv8/sysinfo.c
>   create mode 100644 drivers/sysinfo/smbios_plat.c
>   create mode 100644 drivers/sysinfo/smbios_plat.h
> 

-- 
// Caleb (they/them)
