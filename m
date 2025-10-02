Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8561ACAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 07:50:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1EDF828A2;
	Thu,  2 Oct 2025 09:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SUQi+d4t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E6C88328F; Thu,  2 Oct 2025 09:50:18 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 423E280107
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 09:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso460458f8f.1
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 00:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759391415; x=1759996215; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/4FG0jSd4Bvff1SqsOwjzYnV6C1P763FMgRTGrwpluA=;
 b=SUQi+d4tsuJoxepuqBvbM744gPQAOErUtpm++eZeG3HmAx/XTXuJzxreUhWoV9+cdO
 WYUP7qZtArb9ve8zPDkg6WZ6n7juyU2rrGC41RAyNG2gebY0x/RBBndbQih+YR0O1MJR
 SCfhUoUeNHZnLC89ZBTqGlmBP7+CS1wAUH7u6/OCdIEfKNI03SwtrWpyx7Hql7P7YUkx
 TkbN2xBr4uM0rcTJCLOUVdERuLKZUXxjexNQ3nwj5n/kUL8Z3dOghFg/6pEQWC1nreq9
 Xy3rA8fAn5WX4Cy0uw9MSQgaASAGvVBdRJVgq3fYuPcMmX1pkCeoWbZ8IMigbQq/c27K
 HUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759391415; x=1759996215;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/4FG0jSd4Bvff1SqsOwjzYnV6C1P763FMgRTGrwpluA=;
 b=sRLR/pb/fUKUvN+0cvvSFkKJ8++IbpKhdsjnTBz2x0DmqfLvM3gtIDyEHCEMpXzuTF
 UJGr4mn2OqdrlxH+1NI4Gj28C4tlgPUWUr34XLcJUbV4iC1RJHyQltT2b5Q7qKX1CLNL
 cY4DOfzbyUsxdFKrnT/T5tFSqNvkWVwCJ4wDukB6UWWpb2O6QVxi+Re77s/89SkxDdl5
 oshbPlbBrqul1VuctNrshDDBzl3uXqFpVNDbg9EuVP/o4+1URgaCype4rDs4TokdAjs1
 jrHb1s/cK1l+KQaWr7ikp0Bgleh84e9NA2VHjjXRb1wdbY5yMnqXLLxdfsr0gk3eExlM
 arbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJVPU1xNb/PojiCyFHm/g5eZ2dq1YOOdaxIMudJAmJDl+t7hsBXEqklAy5ZNzy7fuHf32YbFM=@lists.denx.de
X-Gm-Message-State: AOJu0YwuMSUBQlAX4OuNwxnQL+t9xKLlCB2CzmJUMT8GoN4T7AXmdQ80
 jPAv3RbsK0S8hNATj/I5sC3ylDv+TrP+gAOrnpC4p2ff8pb9Xw21vV/RUyAQgT4WL+1AzcggWH3
 oB0Hf
X-Gm-Gg: ASbGncueyLO3QRlNaKt5fI4TjWE8rE8YfOptmRnjMcxXdYjjB652HlOnCNDtKnaOuKn
 03xwUmCFeySeOqBUb8jglNkx0KhYfwxeQtSCxQabPa9AfPE791K0SGp4cbmiazxkRsrgKFW+5s3
 AAXMTVzq3TOjPrf8qSPrMoDx4TLA+g5xoQDBzND/U+HcACWk/P9sj0eNuyctNk7CK3RKdh5/kmj
 lVCcvrDE3/DXlVr95WJrxGF3SaN4H+ZsZEtMVJ0YmZJZaaTlwB6gABse/GxaUZhh/XEJJpeydE9
 gQkKRnJ1Hms0xxlYD7ezt8v3DZ0jyKfkxma9HIUhEx9di9GrVek1artco9+utcJZXP749Ry5bCD
 LJNSh43k7agfwZmoxI2alGsI6dTyjgNm+AsReaXmzvfrHUPh7LIGBXY+bId8uwAs/JN3cWNB4fk
 46JsVqnNgXTBsaJLet9u4oabIBoUvYVw==
X-Google-Smtp-Source: AGHT+IEIwtAqKIeEwanH8eVSkAz0IZ1KlFRorP1nFBHFYKJ3tggYAbCmzO4P1PIf+U9P4hfPeCgQoA==
X-Received: by 2002:a05:6000:2f83:b0:401:2cbf:ccad with SMTP id
 ffacd0b85a97d-4255d2bb07dmr1659797f8f.17.1759391415528; 
 Thu, 02 Oct 2025 00:50:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:d850:984f:2c63:c813?
 ([2a01:e0a:3cb:7bb0:d850:984f:2c63:c813])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6917a731sm24073015e9.3.2025.10.02.00.50.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 00:50:15 -0700 (PDT)
Message-ID: <7f5fe6aa-40ce-4883-9cee-7527cae16e0c@linaro.org>
Date: Thu, 2 Oct 2025 09:50:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uthreads: Make use of CONFIG_IS_ENABLED consistently
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251001203050.2828452-1-trini@konsulko.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251001203050.2828452-1-trini@konsulko.com>
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

On 10/1/25 22:30, Tom Rini wrote:
> We do not yet support UTHREADS in xPL phases. However, we have the need
> to dummy out certain functions so that xPL can build when full U-Boot
> has UTHREADS enabled. Update the few places that need to use
> CONFIG_IS_ENABLED so that we have the correct dummy in xPL.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  include/uthread.h | 4 ++--
>  lib/Makefile      | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
