Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A9DCA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 08:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B81482D21;
	Wed, 13 Aug 2025 10:02:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PG4Jpjta";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF41A82CEA; Wed, 13 Aug 2025 10:02:13 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 740DF82CEA
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 10:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-615c29fc31eso12004258a12.0
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 01:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755072131; x=1755676931; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CqDFMgBd2AUXtMuSS/AZqpgBLVfdnfQT5gkGZagdmZg=;
 b=PG4Jpjtaen0aw6DuTY+q+lFEwyhAjNfUIy6eI5+Wk60o6Qqau4Nu3/SQVQjJEV1Lra
 g0EZ9gH8Sp+44qusvj2Ej93hLqlUOVVnIWEJZ4vWDAMtLdKQ0phY68rb2HUiiMiY+L/O
 w4ITZUXuAajHxfeTclda902XvwR3JQJWCEtnXpSjBIOVIheQNWo1Wb53Ngv9wOLubsZI
 b7cNTA/HprxW3sll9ZHXda3YGpq2cLJGetX9C27/CqJF9JOcUWkMnPB/DYCjhCTwznGq
 TUuqpMsCAomOSdxgi2WwesQMpZqK6FmFsJkbwBLTu+B18knHfFkCRRh+ZRb9SfKDo37U
 8ceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755072131; x=1755676931;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CqDFMgBd2AUXtMuSS/AZqpgBLVfdnfQT5gkGZagdmZg=;
 b=Tub8JmtsCjgVup//3GukpUppnfgIv8gbA/xKh+YIMDkeRXAQog34+m64LkcpVuAbVU
 GJsEXdkbNyRIBvXduP3r8eHk4n5g4f+RblDV6rl+tN97przS84gtznWgFEaLJI60lhoe
 LqftlryGG41d5EMvt4JH3LAqW/v4jJbAHY87JFcwVq2AEt9zXvX4qDM/8X32ENHUwpIn
 J/YvkfQQ3gPvNNwSBtlc2VKq0kb8vfeQDezId30nb2GrrkK/a6jZ/2eUV5sfNEIE+iUJ
 QzurhW3RQPADCymGexi9dCgjk6j7LvmjSpM4kqbRnhpGHOUnd8612fa3/z76kAJK1fNR
 JUVQ==
X-Gm-Message-State: AOJu0YyoCC9cU+S73BfU82hrVX6n/HyxBRX/YN4om9yq//ImKf88jn7w
 3Pdqli7A3XG47oHNOESz8HlLuScF6P9Ib3RWopMT5qDmVcPjb1K1nGUjq58kZZbkQBM=
X-Gm-Gg: ASbGncvNNQGK0me1/CaMhnJ5OoCkIb8OU4h3yovnlw0Of+ddcaFYjq9rWmsYNpracUm
 Ir0qgAA27j/B9BK7N06WNmOkRCCnSMSisNsWcIXjDxQ/7YSU2H2jNTNF+0V9ZO2DnOwseRRRPvH
 KHyCE/zDiT65ervqt/gJ/p8lUtM5o6xnSQN5ZG+PdEIrDfpZx60DQdrhGscZV6lksFv6udvapke
 WRQy42qFM9PkIFpXhzCDwsdRwJx3yZMLKZ3N9FMgugvRzdRrOzmKMp+ZTSL4rAIbN4swQKa6ko8
 +tosHh+gYKf1ygfJdu2vgSZ+9Fo7nwYwr2FFt0iJzkRldgEvHF4otAUQY0/f2RxEIhrCDwn3BhB
 sstxi0dclGxHRRtGXT7mirv9wiOjnZmv5z7f3zjAaq33bpop/k+I=
X-Google-Smtp-Source: AGHT+IGWsmZjEHVcbCmRQJX++GlwNGdNxEKgpxIayTU68F9+/XQhN4LFTG3pgP/FxVLsOEdRWRSuPg==
X-Received: by 2002:a05:6402:210f:b0:618:1554:1146 with SMTP id
 4fb4d7f45d1cf-6186b75abc9mr1985426a12.7.1755072130823; 
 Wed, 13 Aug 2025 01:02:10 -0700 (PDT)
Received: from [192.168.0.33] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-617df37d061sm9320915a12.40.2025.08.13.01.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 01:02:10 -0700 (PDT)
Message-ID: <11eddcc4-25e8-4320-a597-c7e062b716a2@linaro.org>
Date: Wed, 13 Aug 2025 11:02:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] clk: at91: Fix issues found by Smatch
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250723-at91_clk-v1-0-3b28da9bf12d@linaro.org>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250723-at91_clk-v1-0-3b28da9bf12d@linaro.org>
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



On 7/23/25 17:13, Andrew Goodbody wrote:
> Unsigned variables will always fail tests that check for being negative.
> Use signed variables instead.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> Andrew Goodbody (2):
>       clk: at91: Fix testing of unsigned variable to be negative
>       clk: at91: Fix use of unsigned loop index
> 
>  drivers/clk/at91/clk-main.c   | 3 ++-
>  drivers/clk/at91/clk-master.c | 4 ++--
>  drivers/clk/at91/sckc.c       | 8 +++++---
>  3 files changed, 9 insertions(+), 6 deletions(-)
> ---
> base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
> change-id: 20250723-at91_clk-e71864ac6e7e
> 
> Best regards,

Applied to u-boot-at91/master, thanks !

