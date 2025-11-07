Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3625ACCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 10:49:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B912983CB9;
	Fri,  7 Nov 2025 11:49:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M9oBBmSi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB99B83CEE; Fri,  7 Nov 2025 11:49:04 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86A1483CB8
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 11:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b72cbc24637so87160166b.0
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 02:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762512542; x=1763117342; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U2rHFYdVqDnk0UVyxY9gl3t+cerOHLpWhVj2vpj1dX4=;
 b=M9oBBmSio13f+6QuabGxuJ05Xmmu5xbQS3nER6PRcd7sZPKH0BovHmgjFR7vUZeXcX
 +rq/lHEeKBsWrFaN0nGtEP1wEZbtgqItbDtiEr4zLnOG98LpsfZ8nG6Ms6hfIkkFD96z
 GriFK2nlJ/fydWy89SQYkBuFRpl7/EVVaajLIINqVHoVJ0XYAg0KXGDYylloVkvoMByw
 C7vStbL5IR5w2TwswrU0ZOInU6Iwnnno5ey2Q2d47RNT6gQ97nEgUscfqir64HJVdke5
 Lc1XoQcHOAOQ+E5XSx2xczvfVGZ5xz9nYAb1rz+2969xwPJgXTF53Z5aHc8f3J3Z7U5e
 vg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762512542; x=1763117342;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U2rHFYdVqDnk0UVyxY9gl3t+cerOHLpWhVj2vpj1dX4=;
 b=h8wAxB8mRYHuFjUCLX/tx99aZLd+txLu+AVAx7k82RuF0iqT9YG2VnpWJSF8821bBY
 oxwuVCchjkygFmeXBvQJVzSMGNyqEVHX6t5gnabILp5Kgk3EotZT16p6OZalgXSWX4Zq
 rUcXQAtVBS4QRMjKaBine/2qc+g4ybHsdqzO7Tk03afECgaG7apOCNqYdTJliCps6J6D
 hAxWABC5CQuqfTdfQqrhFOinJNwC6Mfooymkbzgs+3QQAVmttWo01u9+0FdubtmKwCZs
 knZ7wt0EgB1Qy6KkrYF0SSL7KTa8G6qhYvlPazwnJF44DNm+N1kjc8UgwT045SkDHHxW
 8Fcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXREdPgFM6ry/jKReIJK06geh8aQj0cxzyhYuvJrgCrs8BYOVDl4oiyyVK3NaAVxH0jlyeL8to=@lists.denx.de
X-Gm-Message-State: AOJu0YzySyU4Mzq5i5pa3c1o7U18btOSi1GfzDXwla8t+y9RiPY1jYMf
 SANdH3EkDWItCZW9g/rbAeO2HCYW15QBfRBekwafbvYegEMhUzWYoeEwH4XTlqFKrjnS8FhU0LD
 zzMzCnkafbQ==
X-Gm-Gg: ASbGncs1a9f6m88RUked1ZeZ+HwFjUeokSLAbLGL1q9/+j7YUoB2aM9ChbjdQgnoj8Q
 f6uniN3F+BMYXNWQ4QcyzuB5bjSkoA+WeeNqniA9ah2GFoGNzEf4eVmF6ioAXjlhuzKvH/0Xbc7
 SZk/uI2S74xZNfq4/zVwYiacG2flBz3Kve6H6Ni6jCephlrXS9xMbZTqehkWqUxYfQo0scb/7yh
 NzGGqQ0z6JiCt5gzMc78dWFPVvUE6OHZ6fOoMcO6Z4KFfaW7se/GaZ/bWDHsg9lCx1sWHZX+KFO
 ZS/mRIuVCXYzM4YJRAG8XV0DShywJKCBTgjWTctUNmwsEAqSqwWbxHBcLmmtX9+6wpeBVaTcKDC
 BBWVAZY3o9pZj+/cKXmmRg4uWIKEq2KRbmViBL3zdcES0MrA3iUJ66OUaGZhzCZmJgM0Nc8ncd8
 ZepNt7rtcTPz5Buo0GOgwI
X-Google-Smtp-Source: AGHT+IEl1PzjOIIrhf+VK7NfbunB8CJWBTxxWrMAAh5QIB4cpGIwkR2b1zsJhdjOKBJVYlvS4M5Q8Q==
X-Received: by 2002:a17:907:1c10:b0:b6d:5fc8:4a93 with SMTP id
 a640c23a62f3a-b72c090e481mr284275466b.36.1762512540138; 
 Fri, 07 Nov 2025 02:49:00 -0800 (PST)
Received: from [172.20.148.34] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bfa11295sm208109366b.67.2025.11.07.02.48.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Nov 2025 02:48:59 -0800 (PST)
Message-ID: <633cfe2f-633a-4641-84e7-a6e08359b48f@linaro.org>
Date: Fri, 7 Nov 2025 12:48:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mtd: rawnand: atmel: Fix ECC error on SAM9
To: Zixun LI <admin@hifiphile.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Alexander Dahl <ada@thorsis.com>
References: <20251106-pmecc-v1-0-a1f3cf430be9@hifiphile.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20251106-pmecc-v1-0-a1f3cf430be9@hifiphile.com>
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



On 11/6/25 13:12, Zixun LI wrote:
> PMECC setup time config was lost in the porting, this patchset backports the
> fix from Linux.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
> Zixun LI (2):
>       mtd: rawnand: atmel: set pmecc data setup time
>       mtd: rawnand: atmel: Remove timing from atmel_pmecc struct
> 
>  drivers/mtd/nand/raw/atmel/pmecc.c | 6 +++++-
>  drivers/mtd/nand/raw/atmel/pmecc.h | 1 -
>  2 files changed, 5 insertions(+), 2 deletions(-)
> ---
> base-commit: 1c250e444ad3b15315ee8b0fcb3fc3acc26449e2
> change-id: 20251106-pmecc-a3841c81c782
> 
> Best regards,


Hi Zixun,

Can you please detail "Fix ECC error", what is the error? you are not
explaining about it.

Eugen
