Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797D4C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 07:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA50C82CD5;
	Tue,  8 Apr 2025 09:55:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mciZG3to";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D865282CAE; Tue,  8 Apr 2025 09:55:42 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF5DC82F42
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 09:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso35071815e9.0
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 00:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744098939; x=1744703739; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GSacoZvxtUxjrRGK0158x9vVixlU2SfeTcvojj6Ttzc=;
 b=mciZG3toYkdZhvK14n1ct3kVBHk0x3L70lzC3YEwDIa8gFGla61mC21njvJhAh8EeI
 KgOotY/YGTc43SlYS5seS9wXOVYeXtuIENmh9FMIaal165b7EU6xqGqeSK1CrXIHA8M/
 KqJwShY3SSku1wdhYiL6/F0H2EIdS4/pEIsaSf8tMyW2WFDH2+9fym929uIM6lAltlKU
 EDerW0IousuxKAyY3FOEy08YpR+hYrOA3RQRVH3P5tCclq5QwfhU0riBxa1CHMJE13Uw
 Ujb1yK78ESiGn3RzETbRksz32FvqCR3EY/8rL4iZm5r5QRvKP35jPnmIZxjAppkDws20
 Pbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744098939; x=1744703739;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GSacoZvxtUxjrRGK0158x9vVixlU2SfeTcvojj6Ttzc=;
 b=OQxEElcgMLo73AZV/1ndhu4UfOFVf9JiWy12GK4/b3YOR8LswbwyJ//JcvH1FaAD+e
 y9td5bLi4wj6LxWCZJG1fLZAxZoVCP++3NdD3JHKjdYY4tUJg6IZfPn22yJJtUDGT7OA
 K9A5oTTz/1MVYy6lsVPW3NuzzzcWq4XNBOJNJ/T6bM4FcBOiFzUWqZ1s67UrBSq5sngc
 dXyurx4b8VHhie5WHnCW0y7ibM9aGc7XKE6xtC7Ep8540Z0wkKghIB9o8mL3DJfcE6kG
 iVAItZQ/a8gVCEsE9zIkyh489PH2Yi6WRmlvSinciLhruqJbC1T0qV5zd5rP00MdNQKl
 rXCA==
X-Gm-Message-State: AOJu0YzzSNDx8O0tuOt4FCnoRTxEc6+31e72Mza7rtuyra4RkL9ijsLY
 4r2prdK38xZulqbR9BqbZuXJbweSzUawF7XGLAbNfDvCpz8ZF2938mQxvgIwqvw=
X-Gm-Gg: ASbGncuwumv8/O3inOpKdGVqw2QstH1iJC3HBA4GtSIBG/4qAqKjh6830nTKHvS9h5z
 rSqPQMgb2Ljwj+cb/vdQkS2UfgCQgUVflzYJHr51m3woXBYu1HnBpOLDEN4IvT/cK4C1TJpOyCs
 jZuq2B5yTOdesL706mmHXbIM6SH0f4LULhbFQXqs4HeIWLiHflCbR3FQf23OuTLFR8rIeJgvV7Q
 lL9dIvEp4PP4tIOHvD7MkvUspa7fcLNMe16ND5cx8w35vBEj+BsUzb82E9MFZ2EE1r7oTKBZ+L/
 74pcXIFa5W0CRF6KilVUpUU+crZ6VWaIaidm8dBG7MolxapKkU6G
X-Google-Smtp-Source: AGHT+IH1OPbz7wjxcX+0exc7VtagMZmrNqTgejLR7trW663bbPOEdpE02Yfimw5IW9Fydh86q/1hKg==
X-Received: by 2002:a05:600c:470d:b0:43d:47e:3205 with SMTP id
 5b1f17b1804b1-43ecf85f23bmr109440515e9.11.1744098939246; 
 Tue, 08 Apr 2025 00:55:39 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b0d06sm158276605e9.35.2025.04.08.00.55.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 00:55:38 -0700 (PDT)
Message-ID: <3fb6b076-4918-438b-ac2c-9a3320d2216a@linaro.org>
Date: Tue, 8 Apr 2025 10:55:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] board: atmel: sama5d2_wlsom1_ek: Fix spurious
 serial output
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, Fabio Estevam <festevam@denx.de>
References: <20250404113919.3860489-1-festevam@gmail.com>
 <d046117c-2a69-490e-8093-3d0f3499514d@linaro.org>
 <CAOMZO5Bq5tECSLVsz8pC7zJx4rr0bjmjyHMsvgaJUOEkqYF1Ug@mail.gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <CAOMZO5Bq5tECSLVsz8pC7zJx4rr0bjmjyHMsvgaJUOEkqYF1Ug@mail.gmail.com>
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



On 4/8/25 02:52, Fabio Estevam wrote:
> On Mon, Apr 7, 2025 at 3:39 AM Eugen Hristev <eugen.hristev@linaro.org> wrote:
> 
>> I am not convinced.
>> The purpose of this early UART would be to get output *before* the DM
>> code would enable clocks, pins, etc, for exactly that purpose, early
>> debug output.
>> So to remove all this and make the initialization rely on the SPL DM
>> code would defeat the purpose.
> 
> Ok, but if we have CONFIG_DEBUG_UART enabled, shouldn't we then
> disable CONFIG_SPL_SERIAL?
> 
> The change below fixes the serial garbage shown in SPL:
> 
> --- a/configs/sama5d27_wlsom1_ek_mmc_defconfig
> +++ b/configs/sama5d27_wlsom1_ek_mmc_defconfig
> @@ -16,7 +16,6 @@ CONFIG_OF_LIBFDT_OVERLAY=y
>  CONFIG_DM_RESET=y
>  CONFIG_SYS_MONITOR_LEN=524288
>  CONFIG_SPL_MMC=y
> -CONFIG_SPL_SERIAL=y
>  CONFIG_SPL_DRIVERS_MISC=y
>  CONFIG_SPL_STACK=0x218000
>  CONFIG_SPL_TEXT_BASE=0x200000
> 
> I suspect CONFIG_DEBUG_UART and CONFIG_SPL_SERIAL conflict with each other.

If they conflict, it means one of them is wrongly configured, since it's
the same hardware serial used for both.
So my feeling is that there is a wrong clock config in one of the
serials that causes the bad characters. Wrong clock config because it
appears to have a wrong computed divider to get to the desired baud.
So , disabling one of them is not really fixing the problem.

> 
> Is the change above acceptable? If not, what would you suggest?

