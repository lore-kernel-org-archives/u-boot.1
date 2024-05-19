Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980E4C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 18:00:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2137F881AD;
	Sun, 19 May 2024 19:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f5l4p0xF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF6E880FB; Sun, 19 May 2024 19:59:58 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 629E1881AD
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 19:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5766cd9ca1bso1014522a12.0
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 10:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716141594; x=1716746394; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kBLImWpHiYjaTDEkZaRYLFjUJf3qUktBilnLH2W6jn8=;
 b=f5l4p0xFW+aymegqXuyR5d5cp4BMHXAPnSkUnjbEJyFKIMjcRP5B2ivf3CwualryQD
 RR/8qIMihNiwY+L/y2H5WXme+AhRPNgA+ZAOj3n22h/Yc9EVOZBwTLKUJacQjA5MeeaG
 D+/QtHCu1kQfOBtyhe2cPo0jxjkeGvCTP0wcQxFDbS9okOntNjT62LxvvhzPM+HS+QuW
 zTP6wRyVvVN2OF3m5w0vhwAB+g2eU1gSJICMBFnriST+kPleX3iSEfPyK3x9vLSVJtQV
 vMd9JTezx4bVYOcj60X6svOt26uFzFUOJQBN8GzIduDkf7DgcJ+5VJmDlw6ewEK6L97u
 uWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716141594; x=1716746394;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kBLImWpHiYjaTDEkZaRYLFjUJf3qUktBilnLH2W6jn8=;
 b=nU7RklOsUWI72RiYrZyaDdw0nKgLmCrOsoS3fVlIg0rz8Ba+xwLEVpUB3YaKRHd8Ah
 ILXZtMKsY4SqTzWtgVuuc4YFdgKdWo0sg8DIbcr1xybDhcz8IkEgDOsmN3j8yzRe2AUy
 kroO897oNWjIW/7fNjQTO6/7//Bp6X4NLul+sQT6UtKnL2Nh8UuTnHOyKoiw+kJc3rAg
 1nF+g4Z3xnlA/joz+1iSfkDdM3fdA+LmxwfLuJtgoQoYg685G8zobPhofU1JU7pFniuc
 vDpVKgZ6fOpxrxib/b1TJBIrxgqjuliQU2Uc+GHHYyAU1b/wmuQBEh1xybW/pDweUCmv
 E2dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWnz5WpwQJehvW9U1ANSs0ln8Zmux/Yd/TLoQZGdCwYK0c2908rBXmSCGgL4m3uvaf/BlY1LeHsuXgE4OCjfcft096Xg==
X-Gm-Message-State: AOJu0YwEFcQZ/dJh0RpJ0ofQMHMqAmAQWDMjC9oVFEXwnrOr0y+d0Dqu
 njd3i8tohl/iuW/Ma4iJaiIsCY5BNBBt9IKquL/ZKEOOcQ6LGgkgQ0D6DFRC
X-Google-Smtp-Source: AGHT+IHOlTBTaN0mO97u+kkBmbD59jvbiKkgZZWeefGb6EQeGBXfobRns1tw1Q9c57AgZiip5RbIUg==
X-Received: by 2002:a17:906:6a0e:b0:a5a:7cfe:30e9 with SMTP id
 a640c23a62f3a-a5a7cfe31b2mr1397666966b.49.1716141593879; 
 Sun, 19 May 2024 10:59:53 -0700 (PDT)
Received: from [192.168.10.30] (77-7-142-46.pool.kielnet.net. [46.142.7.77])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b0173asm1387741466b.179.2024.05.19.10.59.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 May 2024 10:59:53 -0700 (PDT)
Message-ID: <e1d5e4e7-d86d-4dba-aeb6-2df6127fcde6@gmail.com>
Date: Sun, 19 May 2024 19:59:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] MIPS: boston: Provide default env vars
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
References: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
 <20240517-boston-v3-8-1ea7d23f4a1d@flygoat.com>
Content-Language: en-US
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
In-Reply-To: <20240517-boston-v3-8-1ea7d23f4a1d@flygoat.com>
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



On 5/17/24 20:14, Jiaxun Yang wrote:
> Provide default environment variables on image loading address
> to make the board useful.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   board/imgtec/boston/Kconfig    | 4 ++++
>   board/imgtec/boston/boston.env | 9 +++++++++
>   2 files changed, 13 insertions(+)
> 

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
