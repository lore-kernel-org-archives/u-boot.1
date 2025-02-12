Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADDEC02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 16:17:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8339080C69;
	Wed, 12 Feb 2025 17:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jv7Y9Bv1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8526480C83; Wed, 12 Feb 2025 17:17:09 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8040780079
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 17:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ab7430e27b2so1330774166b.3
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 08:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739377027; x=1739981827; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wP8l6wRV14B9sc8+zS9VBEi2koPPLBZ40piCGmGJJbU=;
 b=jv7Y9Bv1W+xNQJz4wEXqIFOx5ycIcY6AuhzKFKYLl6h5nYw8xBYq7JAF2oNjTqy/C6
 TvvFJqU4la7/s9qKVtPHwyFFCWayIraEvXcZm238pNLei/xRmFIpCdtmKy3cxCCKb3bS
 Hswhxo8VwgziZPiw5XAcc6M1JdUHB6p33XSY2CU5Uedk0EpFJYnMvi3qSxlLs1XQ9xFt
 XDUbVBWtQ+0TBITACF06fUAAiwg31dTTCFP+Tcp/UYQah4tb1FrRIRC4/9uo20/xIBHY
 NgXkeKXl6xUwvneTWme9rXAM8jrZNpmPoex1GVD3zB6FQTnGZve6QFIi0n2qyX7lLVh7
 H/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739377027; x=1739981827;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wP8l6wRV14B9sc8+zS9VBEi2koPPLBZ40piCGmGJJbU=;
 b=Z5qCriW9gMZEDKZKQQFCZZHk3bjREFoqY0WWtvlYfS+f6POE9WMUAqmmt3fJHPwqpy
 HdZK660DrwA6BxUlFDzmvTNA28ETbAZqQKEnPM7+ktorsulEpPvo8cwJVe/epfEuwzwC
 NGhWNfUNyFo9NIoJME+gHPOY6rWdScbxnT5/uQwGA6ITX5maAr6+oIj/ClGHqwQgkAMf
 x13zWNGxgUXwKaqR6HBRaF1ejsAtguLa5w01VnkaVX+tL31+bwguCrJwZk+OsicCzPWC
 bjubMdWq6hzEwMGH4gosis7IqyGLzzxD2xv3Iu70UdCdurzsndpBIqqu09+SZZIJ2yoq
 gzzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWBmS1SVRqBD4CjP8XMF78sy1xlpObwqMPPhWn2U3kfoocTuZ9g5LyLIeeFS8dBZecCdHa/ZU=@lists.denx.de
X-Gm-Message-State: AOJu0YzR/Dlu7HCEFKoXfD98SuWsmt77t5uKQEg6BcOtQF2zu46EdV9c
 rn/pV7m4NIh0Y0RLXhJl8cmBaNcBaSUr4ome51RYMnDHN20Eo7F2V9llD9IiooA=
X-Gm-Gg: ASbGncs+hlv296/dcFA2Bo4M4GaOjLmyHNaDlSwx/V8M3U0EsNcQNl/Td5QnPcXkmm+
 32rWAmI7T7KOf8kCvPIPz23Ih1b59D8SiuGNb432nfPk1+3TA/zSJAcCe1l8LI6DuY0Z7g++sg3
 JiB4NrMgzTVibfAkG0R5VH1nZN+Nqpf1YMtpKuPL36BHp0+2vpHKbrXyyR3BsjbZg/u8MVF2wIA
 Qeg4Z5uBDhuDi/Y5fWlly+a+X3Xbiz+8KYmVV+tqgVfIMlmETnFghRsx9DFRo39249H26GF42/i
 2U08HYGANpaVMpNP++Xo+Ec=
X-Google-Smtp-Source: AGHT+IESWzkbRs9EbBDolIokYaBhfawlR5rYKe6bdrnQKuLerYsRw8YcXLhKMYQ8OETwbNo6if82fg==
X-Received: by 2002:a17:906:dc93:b0:ab7:63fa:e4ab with SMTP id
 a640c23a62f3a-ab7f31949e7mr390774966b.0.1739377026821; 
 Wed, 12 Feb 2025 08:17:06 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5de5f3f92ccsm8590399a12.66.2025.02.12.08.17.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 08:17:06 -0800 (PST)
Message-ID: <e931d347-c685-4a77-9adc-688b67da7070@linaro.org>
Date: Wed, 12 Feb 2025 18:17:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: ca_sflash: Remove redundant dependency
To: Tom Rini <trini@konsulko.com>, Alexander Dahl <ada@thorsis.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 John Watts <contact@jookia.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michal Simek <michal.simek@amd.com>, open list <u-boot@lists.denx.de>
References: <20250123073713.2988293-1-ada@thorsis.com>
 <20250123073713.2988293-2-ada@thorsis.com>
 <20250123143256.GH60249@bill-the-cat>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250123143256.GH60249@bill-the-cat>
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



On 1/23/25 16:32, Tom Rini wrote:
> On Thu, Jan 23, 2025 at 08:37:12AM +0100, Alexander Dahl wrote:
> 
>> This is inside of an 'if DM_SPI' block, and thus always true.
>>
>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> 
Applied to u-boot-at91/next !
Thanks
