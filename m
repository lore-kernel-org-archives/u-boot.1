Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A0CCA0EFA
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 07:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C45DC83071;
	Tue, 26 Aug 2025 09:41:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z0i6MKqW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E4D3830A0; Tue, 26 Aug 2025 09:41:34 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AE0E828A2
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 09:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3c51f015a1cso2517367f8f.1
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756194091; x=1756798891; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BiYpvrsu5Y0Jv44EkQpR9NSyCmvMHcdWA8sP2JXBfsI=;
 b=z0i6MKqWX5qr6A+AKYb0bTX5D2f/KljNfTOMXLtoQUxHNkH6beyyUc9NRspEI1ATau
 s1MBlxDIYowLwJBH7/Q0ARyUuh1FUvhbX5cAixDSljGtwmFiQKhtNSMcS2nrwawSysXa
 N6n6G+6EOulncIDT8YHyPTpzearOnqsuWCs+/f3sdQgPZ91oO+PzkFxtCMgWL0eoQFN1
 eKhFMWCVcrCIKz9dm6hAfV3O0BmnEok+XiER4XlffIqOWCL7Lgyg4RIlWNrzJuowWdWF
 mH2Dnya1SDAZonnr/LFyeHMxGzSCQch3nJIFb3umHf46Ki3oH9TEwNJ5dCIi7C0BdsbL
 sBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756194091; x=1756798891;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BiYpvrsu5Y0Jv44EkQpR9NSyCmvMHcdWA8sP2JXBfsI=;
 b=D90IURNa6N53SJkz2GQ1vnNwBV5n7KurkGaKplbzvMnLpQ3PA4CPdmxO+my+9sJf3S
 at6umkw4H7x4/6RIxq+KcvnftqDhpinw4jl+3MYykh3dkzBVifGCB1R6VpzhgOlil9SL
 /6F9s7RcOryUt03Az2yZKs7x9P/DeaZDkK7+JSXy2kBoqs7pl3shiGQWHygZDSCrsWvA
 FHrFfEx+KhA+SxWp20ikeUymhV71XIV0pJ4m9Yv9aaRrXGNRz0CxI4Y+bN6vnw8qXHvK
 VPAiWsS2j24zg+qCEcUtciu/1syli7yjHAjLOdx6xzzbjeNHZzJcZZk43lKGKH9v1f8s
 RpOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5JpBoNnjM79IKqKJaSDIysFKUozmTwhiO6kTbP5sV4MPJQ4yJtoc8AD8Iv4MmNWlrbaBfXtQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxS3q8wVf76m/43ctwzh5RjkO7YL+nxToban1lKEbJAlNjdUlLb
 778SSbWjlVRzVEBmhwPppECEkUCD39cud3b4ke4Zlu10SVXc6JaR5cTZJWKcZd9bevU=
X-Gm-Gg: ASbGncuRho2f7a3tgHWgZohnIxNgI7DYs+XPnkdR4KIyykkVq1AZYiJ8XxLytKbAeYR
 wedHOjCeMzH5WMo22ldXdfYLnXj/O7cnuZIVlPbjdSbOjYCIntcX1QYJgK1Srym0rQScwGBoU9C
 v6fmYy5xjtzWHfWH9arViZHeOrfI/wQo6CTZYYzf5X9nNB9yOyqfIj20ksjj+hoDLvKQLrIrcf9
 2F70TK+m86sbWjKj9/CZ3ZHqUHd+HbhEs77WPcVJwrhhX9bA8i3Nx8wNlH5GeWZD9g55r3x2vaE
 7ZQJUD5bEF8DrLdt6qDYL13CeZbBWDdqg53MdYPaBZOPAssZw1iLFUlHIxG24mmMHd9QHM8hPGw
 Z27bldStQf3eXcedm14hRIwSx0mHhwQ==
X-Google-Smtp-Source: AGHT+IHMUUrPYuU2qJhYXJ4TVWV0VtrdkA4oOd1XGgl+65uWDhHNBlBG4RqJsEPF+F3AB5o2yFMR8w==
X-Received: by 2002:a5d:5f4b:0:b0:3c3:5406:12ac with SMTP id
 ffacd0b85a97d-3c5dcff709bmr10889086f8f.60.1756194091536; 
 Tue, 26 Aug 2025 00:41:31 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f89b54sm14868173f8f.65.2025.08.26.00.41.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Aug 2025 00:41:31 -0700 (PDT)
Message-ID: <2e40fdd9-2cee-4538-ae62-68449e526a9e@linaro.org>
Date: Tue, 26 Aug 2025 10:41:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: sama7d65_curiosity: Resync with savedefconfig
From: Eugen Hristev <eugen.hristev@linaro.org>
To: Mihai Sain <mihai.sain@microchip.com>, ryan.wanner@microchip.com,
 trini@konsulko.com, Romain.Sioen@microchip.com,
 marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de
References: <20250811073033.5173-1-mihai.sain@microchip.com>
 <2d968b86-b45e-4d72-9f65-7696cdd0f617@linaro.org>
Content-Language: en-US
In-Reply-To: <2d968b86-b45e-4d72-9f65-7696cdd0f617@linaro.org>
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



On 8/15/25 10:21, Eugen Hristev wrote:
> 
> 
> On 8/11/25 10:30, Mihai Sain wrote:
>> Perform a clean up of the initial defconfig file,
>> and resync with savedefconfig.
>>
>> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
>> ---
>>
> 
> Applied to u-boot-at91/master, thanks !

Hello Mihai,

While merging this into the main tree, I saw someone already resynced
the config with savedefconfig.
Hence your patch only changes 2 lines:

@@ -49,6 +49,7 @@ CONFIG_CMD_HASH=y
 CONFIG_HASH_VERIFY=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
+CONFIG_PARTITION_UUIDS=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
@@ -88,4 +89,4 @@ CONFIG_SYSRESET=y
 CONFIG_SYSRESET_AT91=y
 CONFIG_TIMER=y
 CONFIG_MCHP_PIT64B_TIMER=y
+CONFIG_FAT_RENAME=y

Are this still relevant, do you want me to merge it like this, or do you
want to have a look and resend a patch that would just add two new configs ?

Eugen
