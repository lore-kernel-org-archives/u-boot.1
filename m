Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE4EC36005
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 00:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F6D381B5B;
	Tue, 25 Mar 2025 01:35:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Onx9nSiH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4CF880EEF; Mon, 24 Mar 2025 21:01:36 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C9BB805D7
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 21:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arturkow2000@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac34257295dso998419766b.2
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 13:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742846493; x=1743451293; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2oxl4SJQVG/W9oX9k2Br/v8kLACRAlPJY/L12t6MY/g=;
 b=Onx9nSiHTVmqsWfIOfsXiwZii/ZOGRHm5mwGqFYNtkcQRH/xjgVOHzs5qtf3Pf2LuS
 R5o+C4Ltf8N/H34/e6QkEhw58NE0gVkC5zEjhr606I6RR0t3q6LiAHQTrClihoRsmsFv
 Sbr8Vn8Opc0ZCUlSQBxnX64FIkrmZZi+gjysWAq/P9x5asPlSyRWJWdWXRm59eCa3tZV
 mmGQJWmosH3U0Z8vn++TkPSOAZw58qE4uj7Y5SPEaZsA9NUjeaagjKMFLP5qhg/jBcU4
 g0bxew/rZAxtpLZvzLsllBybisLncZ9rSjZ7bQt2BAYFsN/jDOKMWD3ZRbLTkNoOeKWx
 K4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742846493; x=1743451293;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2oxl4SJQVG/W9oX9k2Br/v8kLACRAlPJY/L12t6MY/g=;
 b=X5vxBnt2V9IimSALV6KSfmf1CZl0UKRVcQ9IEuXPxEfEjTsGahQnfxed/eTtCzdboJ
 3mfRztfVFdtWo033MCAf8qsLsvY/vyyWP+e5YBTLWv4GhqRIn6BcSzuGgdI92RoOBrBw
 kRnc/ucmMw2PU1XIjyn3niAQza8SCNOylnOk90LLTCGfciapAvie+EImFgb0oMQekSvd
 BtcZgHLyQVSuhY330sDEgFqqK15cXjfQRoeXT+9YSDJAMb52jGBZfTWNVIxKbxWuhhhw
 WkELKQGx271OGoPoX5vYeToWu9oRDB+ApMD78y0zWbaeLirOfZQPf+mKWPmH12/bFFGq
 s9gQ==
X-Gm-Message-State: AOJu0Yy0cK9FZuZEyFsMFeMaV1XxY5QhHLHLdh8sz5ADCzMg4UdBat5K
 lGgGwDftopO01PzCWqrmpBfNOiIZExM9wHhmu4v4oGz2gdQvxM41
X-Gm-Gg: ASbGncsA7GJ7mPXBsM2GeVJheAlJ33Mhznyg0gFs7XqOSXByEjjOEXNV21i3ywv7ipw
 bi638EeL7LOyduttIyYx8UJzhulzPISYtr+KZbCbJXxvcf9id4K5qj627sV1gnt3+5g2Wd5jIxM
 5HmbBCRpUafp/ZpqaRqy0PivOsL2q2JNobVHpNxaQVWOoxyHS4mF4hajNlkVeAnumBkgw/CQMgg
 YWjn0HvNISsqZb+xRYvIR9vj0aO7XubhtAni6lmYNSSi4oxyFtf+XE06shlBhGjmc+RzTLdyXaf
 Rm88djsljYXZ4SHd7nDqJE9yWkFPPhVr/7QmV2rnKDg60EyFf8nWobqN3l0vCWAscETsGqiHQQh
 5ckmeUXvxhw57/N41eiidpfRUhGKHx7Y=
X-Google-Smtp-Source: AGHT+IGbZDGZETUJB2nUhua2okIWRohLX0EHAbpvxurTD9s4GgUylFldAxauW/m42xSGTaHHznGDvg==
X-Received: by 2002:a17:907:86a1:b0:ac3:b372:6d02 with SMTP id
 a640c23a62f3a-ac3f2268a6fmr1244291466b.19.1742846492461; 
 Mon, 24 Mar 2025 13:01:32 -0700 (PDT)
Received: from [192.168.0.15] (89-64-21-122.dynamic.chello.pl. [89.64.21.122])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3ef869f9fsm740394866b.10.2025.03.24.13.01.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 13:01:32 -0700 (PDT)
Message-ID: <af1c79f6-cfd1-45d2-8382-f68ad84276ea@gmail.com>
Date: Mon, 24 Mar 2025 21:01:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Support UART over MicroSD slot on Transformer T20
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de, Francesco Dolcini <francesco.dolcini@toradex.com>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stephen Warren <swarren@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>, Tom Warren <twarren@nvidia.com>
References: <20250318083103.63250-1-arturkow2000@gmail.com>
 <CAPVz0n3JF78RQYbckMcwN6JZC+adUG+oHNzof7Wkxd+EqeBkJA@mail.gmail.com>
Content-Language: pl
From: Artur Kowalski <arturkow2000@gmail.com>
In-Reply-To: <CAPVz0n3JF78RQYbckMcwN6JZC+adUG+oHNzof7Wkxd+EqeBkJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Mar 2025 01:35:45 +0100
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

Hello

Thanks for quick response. I know UARTD is the dedicated UART for 
debugging on TF101, but exposing UART over microSD
is a handy trick useful for development. As I'm doing development on 
this tablet (bringing U-Boot's UEFI support and latest
Linux), and also still using the device on old OS I'd like to avoid 
disassembling and reassembling it over and over again.
Others too may find the feature useful e. g. to avoid having to solder 
which requires specialized equipment, skills and
is potentially dangerous for the board. Also, there already seems to be 
support for that on Sunxi platforms through
CONFIG_UART0_PORT_F.

Apart from pinmux changes, would it be acceptable to include an option 
to allow switching UARTA mux to
SDB/SDD (currently this has to be selected from board's Kconfig file). 
Doing so would allow to enable UART
over microSD without patching U-Boot's source without changing any 
existing configuration. Then I would
keep DTS overlays and config changes local.

Also, today, after running U-Boot with debug enabled, I discovered some 
failed assertions in pinmux code probably
caused by my changes, I will get that fixed before sending v2.

Best regards
Artur Kowalski

W dniu 18.03.2025 o 09:54, Svyatoslav Ryhel pisze:
> вт, 18 бер. 2025 р. о 10:31 Artur Kowalski <arturkow2000@gmail.com> пише:
>>
>> The first patch in the series brings general pinmux support for exposing
>> UART over SDB/SDD pins on T20. The following patches bring support
>> Transformer T20 allowing to enable UART over uSD by setting
>>
>> CONFIG_TEGRA_ENABLE_UARTA=y
>> CONFIG_DEVICE_TREE_INCLUDES="tegra20-asus-transformer-uart-usd.dtsi"
>>
>> Similarily, support for UART over uSD could be brought to Ventana which
>> has uSD on the same pins as TF101, and other Ventana-based boards.
>>
> Hey there, thank you for looking into U-Boot for Tegra. If something I
> will say hurts or offends you, I am sorry it was not intentional.
>
> Anyway, apart funcmux changes, all other changes you propose are
> redundant. Asus dedicated uart for logging and console is UARTD any
> other uart configuration must not be added since it will disrupt
> existing configuration. If you need uart and cannot resolve an issue
> without it you can always solder to uart-d or locally mux sd to uart
> console fix your issue and remove it. Uart is not intended way to
> interact with Asus TF101 and doesn't need to be exposed, panel and
> fastboot console are and can be used to resolve most of issues.
>
> Best regards,
> Svyatoslav R.
>
>> Artur Kowalski (4):
>>    tegra: add funcmux for exposing UART over uSD slot on Tegra 20
>>    tegra: respect CONFIG_TEGRA_ENABLE_UART* options on Transformer T20
>>    ARM: tegra: expose UART-A over uSD on Transformer T20
>>    board: asus: transformer: add DTSI file for enabling UART over uSD
>>      slot
>>
>>   .../tegra20-asus-transformer-uart-usd.dtsi    | 31 +++++++++++++++++++
>>   arch/arm/include/asm/arch-tegra20/funcmux.h   |  1 +
>>   arch/arm/mach-tegra/board.c                   |  4 ++-
>>   arch/arm/mach-tegra/tegra20/Kconfig           |  4 +++
>>   drivers/pinctrl/tegra/funcmux-tegra20.c       |  9 +++++-
>>   include/configs/transformer-t20.h             | 10 ++++++
>>   6 files changed, 57 insertions(+), 2 deletions(-)
>>   create mode 100644 arch/arm/dts/tegra20-asus-transformer-uart-usd.dtsi
>>
>> --
>> 2.48.1
>>
