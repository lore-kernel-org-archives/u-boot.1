Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D7CC3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 12:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F6EF81F7E;
	Mon,  5 May 2025 14:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yuYc/div";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD99F820E1; Mon,  5 May 2025 14:37:27 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF7CF80BAE
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 14:37:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-acb415dd8faso653518166b.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 05:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746448645; x=1747053445; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o5y85UUEzpfWuGZ6hMocNV7YC40HW9BYp2NQJ3xPLj8=;
 b=yuYc/div7XRxzoBrLHS6CuRW6e0uoenQxofEqOqzrUhm4cL19q1GO83mDNqPaN135V
 OnaZPSQ/MQ4nKElRmMTkt1q+eaT/spMPkVpLaw3rpqU/ysMBN95btRU4ekVAcAmzPsDL
 egMX1wKzNr4lTNnNjbc4ROFzQ3AlIfS5cXQafc3/xlmsAwNq9kn2/hPhQinzwt5xR28c
 k+kAPuW2vT7P2ZyHRn9d8g3oqgiNl5ck8ezy+XZ68YaT4HlV0LR0478uw07o+VbY0iEh
 +CX5EmrPwcEYnheI6S555NkTdAXqQHpporqj0a+Wpk2RUdaAyWUvs28tojiK8v3siht8
 RLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746448645; x=1747053445;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o5y85UUEzpfWuGZ6hMocNV7YC40HW9BYp2NQJ3xPLj8=;
 b=ZqKVzmQepzihhn8L/J8/wGT7UZHptvPHTnxV1O+9IdWDFi1n8TPj23Taay5Clzr7XQ
 aC8lllGNwz3OqRSXM0MqIhRdIqYAqdPMym0AYNlZFrbs1zOH2Ar1wE9WP/nlkyveke1A
 MYaNB1a8m8Bgk4QHhtfgtrpsO8/iKYDEYY4R+3kp3gh7wWknMIg9ixA11R3RSlld4BOa
 Tb+ZOFoBkw5F5G8LFjWBOacwWVzzh7R4l0PouIa0IGG5RCZ9vqJNyOljGK3A6stDRyqT
 +u63CqJo8Pop2glj7m6+HtvUEb5IF5VqRKl+BelTWmrVwva5nctRtV7IrICxEkQj8Erq
 9JOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu1z7azlZ5bMks+j8JWkI4YRreCFctF0D4f11zfznKL1LMa70kZSgu9z2AhQAR8EcYjUbhFcY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2O/Mi/64hQtjxo3q/R0CLpU1cFuFVKIB711DrKpmznASzxlTj
 w3b6JK735F7F407Ma0+hM1racGoHQCyUykxfmMc3bLMwVDNX4WWnAwJYJf3gob4=
X-Gm-Gg: ASbGncvbJWhB/r4XM3w6ypNVdDBRezkq+Yltatbs1tUrRHPtc9XFmB/9JdmBhmRZLNL
 ywUX+A24GqhrMSNCgqaMgGeV+agnTjp9NggTr+rwzS8Qkfd6vGz9pLVTHt5DRzyEdMYSFRpzjgd
 4cVkvKlcAlOa24ysTxPfLPKnDn/aaBpK1P5r0SIgVFfW+EOEshkXDxuENfcoXA9d/xlrsm/WK1w
 t87NJB8Clv4l+SITGCf6MB36u4r6VF4UXOAfvwD19MDnXhGTq1FSAHZCc+VH4qXdBSKRngjDtt3
 sbIXY24x/o60XQIKERaWQJY0NZDpNhBykpwqtN92/IAu/6Aan3D3jR9Hg7cvC2eA+/AMUoPnilX
 JVCy39g1x6ECT9/7tIcRB
X-Google-Smtp-Source: AGHT+IG5T7yPcHcZTHq9Zv5rkjKbaapWCucmtnz85xzkTKZAobr2VTgnz9LLqJhF4hc4iTmPzmZXtg==
X-Received: by 2002:a17:906:6a29:b0:acb:1908:6873 with SMTP id
 a640c23a62f3a-ad1a4b1acecmr666442666b.48.1746448644994; 
 Mon, 05 May 2025 05:37:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:b8df:70b2:49d6:1b94?
 ([2a01:e0a:3cb:7bb0:b8df:70b2:49d6:1b94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891a311bsm493625166b.54.2025.05.05.05.37.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 05:37:24 -0700 (PDT)
Message-ID: <397fc31f-a182-4218-9752-9bbd161223fc@linaro.org>
Date: Mon, 5 May 2025 14:37:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/22] elf: Only use network environment-variables if
 net enabled
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Daniel Palmer <daniel@0x0f.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
 <20250501010456.3930701-18-sjg@chromium.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250501010456.3930701-18-sjg@chromium.org>
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



On 5/1/25 03:04, Simon Glass wrote:
> If there is no network support it doesn't make sense to try to read
> these variables. Add a condition to handle this.
> 
> This is needed so that env_get_ip() is not called when it is no-longer
> a static inline, but included in net/ code.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  cmd/elf.c | 41 ++++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 19 deletions(-)
[...]

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
