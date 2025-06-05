Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5874C5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 08:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECA928091A;
	Thu,  5 Jun 2025 10:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zwBtRxVy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24FE881FEE; Thu,  5 Jun 2025 10:12:08 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EFE281E25
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 10:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45024721cbdso5467325e9.2
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 01:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749111125; x=1749715925; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GvLVsUaF7nBPuc/gPvJzboIi5CIm9vkThd/tXjw/R+E=;
 b=zwBtRxVyH+/7lbIY+bmbYa/z4LhZ2ei+AdYl92Tr37DZNH5pHk3024llSwUEcHqgem
 /D7Dn/5aqFya39IUIB3eu9ZgwuC+fDrEcjvyKBVzyCQ9/iUZ1p3xH5daNfRHewgc6wVP
 0f1YY59078kEVW+LMk2zG2JY8T4TCfR+H7pqBaBG54IaHlnDDMSrtNQnESrXSZzzQZNM
 YsgEpxhOWoWCMDW8UuyRo5n/irPicSMfbDW4NUb7EgXibrQPUY9O4x6LdspwgHXc1lc4
 mQwcRTrCv0iWBbwOkvhFeggpkhbrAdzphMiwEtfG/wS2hziK2J3v50Lb8RcSGPDzr0Mk
 d/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749111125; x=1749715925;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GvLVsUaF7nBPuc/gPvJzboIi5CIm9vkThd/tXjw/R+E=;
 b=ERr2mH8rl/ZJhirQ2HiYD1mBvqfNvQlMO9krFdalZMoL/XzOz4J2/+wCCX6dIAY1BZ
 znfpJLm55O3bulBcu/LaRxibfB5R1MWW3ivMWqJlY0WyJTyvRhWDCGHb5WKfg5CX55r9
 qF/OE9B9EquhcWqYTqohrA0WRDYHCKJrpvYOWttzUtcjdZP/ZmdBkwUn7VaqzOoxbbbn
 06bXFfjeO5hXUquUPc41Gq9SCu38Lh2UmizrvlrLbMPZQxIy1woB41AebfRjwi71SXeR
 RRfHghK1r7wXkSNUg7WyPrCRpxu+t2jrSqmIH6dRFK3/OZ+o4TobCm0taTXcQ2B8qwpY
 aljw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2MSavfx7spv1WeS2tIB0yFfbozCWFegNpwRZhxgPiSNYSBizIRUdefQWB6FwzQ5VmXqLMFH4=@lists.denx.de
X-Gm-Message-State: AOJu0YzBZsayrnvroOVyHZhzR+wpNhDAf93NVLtCsiGBVkk7jw0dqxUz
 ek/JkC+Q6xa9kA06cjISpu9jiJMdtHFLgqa4/tZO8FuwhNgDrtQw1LObdRYDEO1ohkoESwCTRjv
 4FsHS
X-Gm-Gg: ASbGncsQy8g6HjUxHxxuDCpVZGLv5AdPlaHXNEF9jqYmavAzjaQFO7UVYKq4t7+Sec6
 ecqD2ta1h4jSwW5zpTnYBP4eONHcada/6q+gbsuTsMNQuvF5M4VVPXxmZRAa7jbCFtSWBasawZL
 0yMDBtyYrDchEG0rIh78WJq7JN75+ZnMyc3zXCE6JObIbWhva4SnBISYMt5RREnNhovyfRSGqfV
 P/5u7ODIQ4ZTyqrT1seTednEJe5+f1+7wpy9dwtf8qsFQ9YBvHDzWkWeYydV7v+W3Ot3T8jiEpI
 QdFI5ZX2345twJL2AxoBPcMmHz92yzWGL8gBfC9FmiOD+f+0xY2XwGXUkHqItYd2k8D2NfUsQJS
 IH0qv4w7xYVkTOmdurCGlPkW9xKl+8tuQQxHv17+1Fg==
X-Google-Smtp-Source: AGHT+IGpFa4tOSPMdc15l+Im84k5Lf700jGrlHDl5ZP7S3IY8BqjbV0MFFPe2b0KMNQIfRjnmbpdFQ==
X-Received: by 2002:a05:600c:4f47:b0:43c:efed:733e with SMTP id
 5b1f17b1804b1-451f0a7c52emr57623945e9.14.1749111125574; 
 Thu, 05 Jun 2025 01:12:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:37f7:19bf:f6b3:6381?
 ([2a01:e0a:3cb:7bb0:37f7:19bf:f6b3:6381])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451fb2213f1sm9827985e9.32.2025.06.05.01.12.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 01:12:05 -0700 (PDT)
Message-ID: <bc826ef7-2691-4223-9512-dfa1b3a23113@linaro.org>
Date: Thu, 5 Jun 2025 10:12:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sandbox: solve undefined reference to pthread_kill
 symbol
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>
References: <20250604154814.1856244-1-raymond.mao@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250604154814.1856244-1-raymond.mao@linaro.org>
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



On 6/4/25 17:48, Raymond Mao wrote:
> This patch is to solve the sandbox building error:
> $ make O=build-sandbox -s sandbox_defconfig
> $ make O=build-sandbox -s -j2
> /usr/bin/ld: /tmp/u-boot.27rzOu.ltrans58.ltrans.o: undefined reference to symbol 'pthread_kill@@GLIBC_2.2.5'
> /usr/bin/ld: /lib/x86_64-linux-gnu/libpthread.so.0: error adding symbols: DSO missing from command line
> collect2: error: ld returned 1 exit status
> [...]
> 
> Fixes: b989f9ed9fe1 ("test: lib: add initjmp() test")
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2:
> - update fixes tag in commit message.
> 
>  arch/sandbox/config.mk | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sandbox/config.mk b/arch/sandbox/config.mk
> index dd9b7473fa9..9a61e803a57 100644
> --- a/arch/sandbox/config.mk
> +++ b/arch/sandbox/config.mk
> @@ -3,7 +3,7 @@
>  
>  PLATFORM_CPPFLAGS += -D__SANDBOX__ -U_FORTIFY_SOURCE
>  PLATFORM_CPPFLAGS += -fPIC -ffunction-sections -fdata-sections
> -PLATFORM_LIBS += -lrt
> +PLATFORM_LIBS += -lrt -lpthread
>  SDL_CONFIG ?= sdl2-config
>  
>  # Define this to avoid linking with SDL, which requires SDL libraries

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
