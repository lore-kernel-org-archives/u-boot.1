Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421B5C54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 20:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C78A87150;
	Wed, 13 Mar 2024 21:21:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X0L4UwI+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16E1F87150; Wed, 13 Mar 2024 21:20:03 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 410DF87ECD
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 21:19:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.henderson@linaro.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e6aa5c5a6fso355115b3a.0
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 13:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710361197; x=1710965997; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w9QLI5rG1T4V0cz8vrRfBQa48gWA7KE1SrRQieF/3w8=;
 b=X0L4UwI+bKJdYvnXBoMfqZ6giWfLOVqXD4ldn8XcxHCZ3xuUl0+hiNnAkk9f5XIL6C
 0QiH7dd1WshFvcQCIbFZX658+U3ulSezPTgeMhcKUZTFIpIII74najuOvCuEx207TqKn
 ygbcmXMIA+dEDrgvNIjsaCodfoma9wHhD3Yv9GU/Gx7J6BY87CFZ7necqs24ABKgCFye
 rvfdNR2/EMxwX51XyKy4M8J9L13CpgoVr27ywU0UsoIO8HRRfLOOhZh3vY8OLBf4qATt
 yozwPPflnI2eih6DdK5K0ZOZ0C6duXMKF1EbOkEKFN6tlSX0EBj7NyXxQLhvG5AZCm9U
 HdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710361197; x=1710965997;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w9QLI5rG1T4V0cz8vrRfBQa48gWA7KE1SrRQieF/3w8=;
 b=C7I9NHJdGdWn/ICfsp7u1HRGSUTA3sH18VVP2MYW82nuj8hXOrA7JV4uB5pyYg6/KK
 YGDuuK+cYwSNN8UDA7SS3Pc6FSxO0aZlXA3wnAVqi5jyroL60i4hRPP9fdNRDwFTc3zJ
 CLrR46MDg+A/6ys0717NmYHrOWVBVN1wcM1WGcSjPcNQWGddGL3B4cxXYW3ljNk87RIC
 t7vizG+kYIEZtbKc+fs0DKjJdvZLZHK16mG+6Kix1cJMhY4fG6IL4RIn6pFex1QgAPTK
 o6Rsqo9uDu5D/hz/OGvpfVVeFCOhoX/AVNeTeaAGt62vJI+AvVybZIo9z58ZMqGn/WMe
 eyfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9fRHw3IGgBGgJJE9Jcq6YbVwZbpnd7AMbYDGKfatl1vrN1mHp9bqVq+dsDPqfNT1ZXK2yT1S8B9EJ2yBaiHKQ3vsOxg==
X-Gm-Message-State: AOJu0Yx8iXlDJCqvg3GOjpdhrMrTLVnqtjGoxJQgJHmE+gioQlm9xBYJ
 FFkUJJTq6VZIhLN/XV17SemEplTVPm0INzXac+ivBeGMmHq0nYQ0BJfShwg+u/7VisiIskXpTD/
 4
X-Google-Smtp-Source: AGHT+IGbHk7k46+0ZqO8zdLl53MoZRaHvPxtRpwvHkbqUaYj5XHPO3NuWD0pqVLSMzA6r8YEeWF3bw==
X-Received: by 2002:a05:6a20:394c:b0:1a1:4d4d:ca8d with SMTP id
 r12-20020a056a20394c00b001a14d4dca8dmr7778pzg.50.1710361197574; 
 Wed, 13 Mar 2024 13:19:57 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 c11-20020a62e80b000000b006e6aee6807dsm18473pfi.22.2024.03.13.13.19.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 13:19:57 -0700 (PDT)
Message-ID: <e1fabe14-0c0e-45f3-9d5a-1452cb9b954e@linaro.org>
Date: Wed, 13 Mar 2024 10:19:52 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] arm: clean up v7 and v8 linker scripts for
 bss_start/end
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
References: <20240313162324.2117909-1-ilias.apalodimas@linaro.org>
 <20240313162324.2117909-3-ilias.apalodimas@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240313162324.2117909-3-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 13 Mar 2024 21:21:57 +0100
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

On 3/13/24 06:23, Ilias Apalodimas wrote:
> +++ b/arch/arm/cpu/armv8/u-boot-spl.lds
> @@ -63,18 +63,11 @@ SECTIONS
>   
>   	_image_binary_end = .;
>   
> -	.bss_start (NOLOAD) : {
> -		. = ALIGN(8);
> -		KEEP(*(.__bss_start));
> -	} >.sdram
> -
> -	.bss (NOLOAD) : {
> +	.bss : {
> +		__bss_start = .;
>   		*(.bss*)
> -		 . = ALIGN(8);
> -	} >.sdram
> -
> -	.bss_end (NOLOAD) : {
> -		KEEP(*(.__bss_end));
> +		. = ALIGN(8);
> +		__bss_end = .;

Still missing the alignment on .bss, previously in .bss_start.

With that fixed,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
