Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F71C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 18:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD24587F78;
	Tue, 12 Mar 2024 19:54:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iWgMGvaz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20F7487D8E; Tue, 12 Mar 2024 18:00:20 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA70987DB0
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 18:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.henderson@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ddc7e45c47so840905ad.1
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 10:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710262816; x=1710867616; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Uwj4LK27hKM6P1MMjoKpYGQIU5JoKrv8g6JVytA8FE=;
 b=iWgMGvazJ5tadvFgHRzoI1FntwQu8rfEpNZn6e7d5ji7KCILVvg5sh3GHOC1VpinOv
 OQq0nUMlgZSuGyXl/khr1vCc7tAi8xdzz2kDxp0KYJrufcb50iRK0OYYsBQGp2ahBY91
 BxFM8/VYpl/0AYaFSfqC+gfh/w8cKHfn5wPpjHhS6dvWD8Ax8ID8WfDWseCl8lCYYGsY
 6blKAJBDj8Z65CLkW1oOa7puEgKQWMDqlXmZ0L1eEs9lpNMq5mO8WrxTMyP9gHekXhJO
 i8CMPgoCXCdZXS/lMh+ZC9gTNDhQYKiipdzPsdtw5HkcuHU7dFC+Xg14U5C/6IwhLEM8
 rFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262816; x=1710867616;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Uwj4LK27hKM6P1MMjoKpYGQIU5JoKrv8g6JVytA8FE=;
 b=xLoCyOijhshGGB8Wb1ZzNY12TVmaMQD15SnT1XarXyVCCez4YCUPjs/M77jvQoryFr
 jBK984yw1Zu9LTLMwcujJE1NZ7cxCbtGGQViZyfj1t6sjHQM+KVEC3ed9Z5TwF8YbK8/
 f7SZzif8w9PFXawDyirk/CcY2vkH51PVU/WLZIOMVfq5h1/a5Yg7Oz9shNUDEoTQNjkJ
 ywptVZ1dRNg8YxQcp5oIbihfn4i6xyE79/i99yO//TBJUBlPCW1EFnotnfNJtFPdy9VR
 VdYtgSsXbLWFF2cKBCykZTiESUSEyCg1sL816C8uPEcSekkoNPwC7UBJkhroi8jYes8s
 bErw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWurk/Vat7RqXVH4j6h7vyBq5mNCuF/32nQOrKRN6oLfq5rB4AceeirLidwT97c1gGhcjGi0DCfMhSlCzT65gweMG90LQ==
X-Gm-Message-State: AOJu0YwJCbQkTNfppIqlonPXHWzEXZnBgKNDBcif9ie2q4u6TAT55LhR
 aTDt8c3xGy+GF3GvIddhrBPjXXltF5U+8QZQKjUYT4HbV25Zy36JA4uJQiksFgc=
X-Google-Smtp-Source: AGHT+IHiq/+6PRsh7hBJ9DaWNDgC8ezNgjOPzF63HaAlLgu4xueSzXfhV+EQWveQW+xp+CNHEU3RCw==
X-Received: by 2002:a17:902:eb89:b0:1dd:b73e:ac2e with SMTP id
 q9-20020a170902eb8900b001ddb73eac2emr881558plg.17.1710262816156; 
 Tue, 12 Mar 2024 10:00:16 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 j14-20020a170903024e00b001dd67c8e108sm6922441plh.199.2024.03.12.10.00.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 10:00:15 -0700 (PDT)
Message-ID: <1b42d645-d4cc-4c42-900f-ba94bf857d87@linaro.org>
Date: Tue, 12 Mar 2024 07:00:11 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7 v2] arm: remove redundant section alignments
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 trini@konsulko.com, cfsworks@gmail.com
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
References: <20240312140832.1968215-1-ilias.apalodimas@linaro.org>
 <20240312140832.1968215-8-ilias.apalodimas@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240312140832.1968215-8-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 12 Mar 2024 19:54:32 +0100
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

On 3/12/24 04:08, Ilias Apalodimas wrote:
> index 33f4624b561d..ccdd1966cfbc 100644
> --- a/arch/arm/cpu/armv8/u-boot.lds
> +++ b/arch/arm/cpu/armv8/u-boot.lds
> @@ -132,7 +132,7 @@ SECTIONS
> 
>   	_end = .;
> 
> -	.bss ALIGN(8): {
> +	.bss : {
>   		__bss_start = .;
>   		*(.bss*)
>   		__bss_end = .;

The code in arch/arm/lib/crt0_64.S assumes __bss_end - __bss_start is a multiple of 8. 
But that could probably be replaced by a proper call to memset fairly easily.

> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> index b6b19a4174fe..a9fcbbf22e96 100644
> --- a/arch/arm/cpu/u-boot.lds
> +++ b/arch/arm/cpu/u-boot.lds
> @@ -155,7 +155,7 @@ SECTIONS
> 
>   	__image_copy_end = .;
> 
> -	.rel.dyn ALIGN(4) : {
> +	.rel.dyn : {
>   		__rel_dyn_start = .;
>   		*(.rel*)
>   		__rel_dyn_end = .;

Because of the overlay, this affects .bss too.

The code in arch/arm/lib/crt0.S may or may not be configured to use memset.  When it 
isn't, it requires __bss_end - __bss_start to be a multiple of 4.  Why does this not 
always use memset?


r~
