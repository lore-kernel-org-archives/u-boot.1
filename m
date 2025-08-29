Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A021BC8303F
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 07:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EE1483487;
	Fri, 29 Aug 2025 09:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="A4ErykxG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC05B834AD; Fri, 29 Aug 2025 09:44:24 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DA5783447
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 09:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 012DC3F7CB
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 07:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1756453461;
 bh=eZHQuOT+sYMZRKb5h0uUkNdDD/E2a4J8FmdwMhbM7XI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=A4ErykxGODInfugDEJrm9xTD/iY/ykZbIkUWMDwvW2HzKUZeWnLS+hqxOLcT23N+u
 3GoMr9b7YmeEvwOHs5nT7yF70m4ty7CIGZYdJJF823BVT3BkvP8WXaMiSOe/vnzs0J
 GeUWLDL5aY0TZUCGCxTKMNyAZHPOsOyGytTSv5NxHv6SH8YDUH1EqTAvxZQeNF1FLV
 eTceJditZ1B4rkjVsxdMZJaa2GmqxVIs09nLjzK13A1wAyW2a2oXpEodGRfHuNhYag
 FKaMC3C0VIuUgMmofG4oB/FEGpRR51nD7WJZs80wPvBWmRlwnBduFaplgBKsksHLEV
 pJT3h0jT19sMg==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b7d497abbso6958045e9.0
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 00:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756453455; x=1757058255;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eZHQuOT+sYMZRKb5h0uUkNdDD/E2a4J8FmdwMhbM7XI=;
 b=Vucc6hfy3dt7M13Yf8VRmH+zI3oR+Q80neWq9UOOy5/+3wR0+pUL7VRiVupsL2a2Wl
 E9niDXJV8oc0taQh2/hbgR42uQbY/KR+UOF9A+aJDIzx23obWE4O1LvS++oHe4lWl5xY
 EfLuvZCafd2lp1aaWrQq61kBssn9UmIvoZ9/R1qQlF8DqwM9qrlw+W+wW5WDX1ZPZQm+
 cPZ2uSK1kGBVZ1KiagobVD3nzLRuji2zna6ovU6k5sCxNBSbQB7t79a8ZWQWtf0m+f0s
 QQ/4RfypJ01+fUW0MCzzIl4XNMgWhDSjK3uBi8UKADw21lajFCIKGrqqKKZBk1zMSV8L
 iCOw==
X-Gm-Message-State: AOJu0YyVshmR2UZtxzVZvw9mlIPD1MMQyURMyiQUSnfkpDvXYVRgQ/jg
 9uq6F2Ukuak2Oodz9OfoJ7vjEzHXDyYBC7EWPMvLEBCyq7UaSQknUg0sAU+i4G8/ceJDZtkGaU/
 BnqRTuE1a3AvVqkCmM88UYEfLR7m4I3+7ceKD8GkNWfd4pKgRYnKlnQCX5S4SLwi1Lllws7I=
X-Gm-Gg: ASbGncuytyRV6sxgBn0cLXHWk0BLbl5u6ycuMSpKa/zIuM152aKWBdHRGMEVWeJkGP4
 G2hIoxHg+zUTyGdftnDBMTS/uJdWjf54OyZg9D5DZ5nS1i0D7NIBznVJFU0MmUpFfdlBw135UVi
 HnC1hjbTY9kVioXaGYKV7JRDlMdSz7ijacXSGMW7r8wNO0JQrTGlGw+eYBFrW85+fYHEZpDX5E5
 Z0o1rzbGjQQ9Cdkz8qfyjMKijzDziDmiDFaJhPJ2S5WSZKxjDZtH3VNCg+0Atgyk6WIXJeKlnPG
 L8XolQ+pVFqEk9mjeuzOdNARJUfJ/Qau/XQYHJO8furBFQoE95xIQ+WA/gAjv9f0gOM/DTjPQtH
 H2MUU6bGwz9xpLBeR6mkFSVcbORXS
X-Received: by 2002:a05:600c:4f09:b0:45b:6163:c031 with SMTP id
 5b1f17b1804b1-45b627826c3mr166550065e9.24.1756453455418; 
 Fri, 29 Aug 2025 00:44:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZhD1GT3QhuccWcV1uFRc9zP7Zk8HUOv7rSQewDQjxi/bLLV8lFMpZtp4Z/TlTya3PZUdDuw==
X-Received: by 2002:a05:600c:4f09:b0:45b:6163:c031 with SMTP id
 5b1f17b1804b1-45b627826c3mr166549685e9.24.1756453454864; 
 Fri, 29 Aug 2025 00:44:14 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:88f7:ae8f:dfdc:303a:75d?
 ([2a02:3035:6e0:88f7:ae8f:dfdc:303a:75d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b73cf86f4sm86112155e9.6.2025.08.29.00.44.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 00:44:14 -0700 (PDT)
Message-ID: <7c0bdef3-69df-4536-bddf-e2912ce71eed@canonical.com>
Date: Fri, 29 Aug 2025 09:44:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 04/10] eeprom: starfive: Correct
 get_pcb_revision_from_eeprom()
To: Hal Feng <hal.feng@starfivetech.com>
Cc: u-boot@lists.denx.de, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 E Shattow <e@freeshell.de>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-5-hal.feng@starfivetech.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250829060931.79940-5-hal.feng@starfivetech.com>
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

On 29.08.25 08:09, Hal Feng wrote:
> pcb_revision is stored in the pcb_revision field of ATOM4. Correct it.
> Move the function description to the header file.
> Remove the function calls in board/starfive/visionfive2/.
> 
> Fixes: aea1bd95b61e ("eeprom: starfive: Enable ID EEPROM configuration")
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>   arch/riscv/include/asm/arch-jh7110/eeprom.h   |  5 +++++
>   board/starfive/visionfive2/spl.c              | 18 ++++++-----------
>   .../visionfive2/starfive_visionfive2.c        | 20 ++++++-------------
>   .../visionfive2/visionfive2-i2c-eeprom.c      | 11 ++--------
>   4 files changed, 19 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/arch-jh7110/eeprom.h b/arch/riscv/include/asm/arch-jh7110/eeprom.h
> index 6d0a0ba0c4a..025f1d32c49 100644
> --- a/arch/riscv/include/asm/arch-jh7110/eeprom.h
> +++ b/arch/riscv/include/asm/arch-jh7110/eeprom.h
> @@ -9,6 +9,11 @@
>   
>   #include <linux/types.h>
>   
> +/**
> + * get_pcb_revision_from_eeprom() - get the PCB revision
> + *
> + * @return: the PCB revision or 0xFF on error.
> + */
>   u8 get_pcb_revision_from_eeprom(void);
>   
>   /**
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
> index 3dfa931b655..901e7b58f36 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -126,19 +126,13 @@ int board_fit_config_name_match(const char *name)
>   		    !strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
>   		return 0;
>   	} else if (!strcmp(name, "starfive/jh7110-starfive-visionfive-2-v1.2a") &&
> -		    !strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
> -		switch (get_pcb_revision_from_eeprom()) {
> -		case 'a':
> -		case 'A':
> -			return 0;
> -		}
> +		   (!strncmp(get_product_id_from_eeprom(), "VF7110A", 7) ||
> +		    !strncmp(get_product_id_from_eeprom(), "VF7110a", 7))) {
> +		return 0;
>   	} else if (!strcmp(name, "starfive/jh7110-starfive-visionfive-2-v1.3b") &&
> -		    !strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
> -		switch (get_pcb_revision_from_eeprom()) {
> -		case 'b':
> -		case 'B':
> -			return 0;
> -		}
> +		   (!strncmp(get_product_id_from_eeprom(), "VF7110B", 7) ||
> +		    !strncmp(get_product_id_from_eeprom(), "VF7110b", 7))) {
> +		return 0;
>   	}
>   
>   	return -EINVAL;
> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
> index bfbb11a2ee7..f38433e94ac 100644
> --- a/board/starfive/visionfive2/starfive_visionfive2.c
> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> @@ -59,20 +59,12 @@ static void set_fdtfile(void)
>   		fdtfile = "starfive/jh7110-milkv-mars.dtb";
>   	} else if (!strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
>   		fdtfile = "starfive/jh7110-pine64-star64.dtb";
> -	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
> -		switch (get_pcb_revision_from_eeprom()) {
> -		case 'a':
> -		case 'A':
> -			fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
> -			break;
> -		case 'b':
> -		case 'B':
> -			fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
> -			break;
> -		default:
> -			log_err("Unknown revision\n");
> -			return;
> -		}
> +	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110A", 7) ||
> +		   !strncmp(get_product_id_from_eeprom(), "VF7110a", 7)) {

Where boards both with 'a' and 'b' ever shipped?
I have only seen 'A' and 'B' in pbuf.eeprom.atom1.data.pstr[6].

The change looks technically correct.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> +		fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
> +	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110B", 7) ||
> +		   !strncmp(get_product_id_from_eeprom(), "VF7110b", 7)) {
> +		fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
>   	} else {
>   		log_err("Unknown product\n");
>   		return;
> diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> index 3866d07f9d4..43b8af4fc59 100644
> --- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> +++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> @@ -535,19 +535,12 @@ int mac_read_from_eeprom(void)
>   	return 0;
>   }
>   
> -/**
> - * get_pcb_revision_from_eeprom - get the PCB revision
> - *
> - * 1.2A return 'A'/'a', 1.3B return 'B'/'b',other values are illegal
> - */
>   u8 get_pcb_revision_from_eeprom(void)
>   {
> -	u8 pv = 0xFF;
> -
>   	if (read_eeprom())
> -		return pv;
> +		return 0xFF;
>   
> -	return pbuf.eeprom.atom1.data.pstr[6];
> +	return pbuf.eeprom.atom4.data.pcb_revision;
>   }
>   
>   u8 get_ddr_size_from_eeprom(void)

