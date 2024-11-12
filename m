Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27019D32D8F
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 10:59:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A174689175;
	Tue, 12 Nov 2024 11:59:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mnItdrHM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06ACB891B0; Tue, 12 Nov 2024 11:59:00 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C77EF8910B
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 11:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37d538fe5f2so4025638f8f.2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 02:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731409137; x=1732013937; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7GJDPNie5cvz9hz0BZ/fRpVsQJjoPYF36T5qXaaLiB4=;
 b=mnItdrHMbuqtqeCva9XoRuqOXh0KjKsPInmWjVzHKnneCAWwHXp4kmXTgSVk6eW/na
 sznUdQpMRM1S/ZgY9kylSOFH3NCi8faUROvPEyXxtixCucUSZ3sjebhjA5RY1OQB31CS
 IsCDYqJe5R/ZJt/i3SG22V8RjcFEdOTvC9nJEuIo+EcVaeibnwwckcbkVVVS/4+8tGXA
 aLc/+5TAd9FpvRPC8M5EgA1bpE9To1yTLoO7XaJsuF6r0EwYQCEFn2FvfrIkBhEsBFJW
 bvNMe93mqh5lSHWhexrO8XP5k5Q7S0O9F/tonXyzyahKsNq5gd/8R8wYoZtk9Hgi5wCA
 nAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731409137; x=1732013937;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7GJDPNie5cvz9hz0BZ/fRpVsQJjoPYF36T5qXaaLiB4=;
 b=gQwoooqGCTa6i6wltw5/v2SpMxbXH7ucDHRx5uRsu0jh275Wdg/mJNHcLAIbQcdyjC
 kYvDeHJTdV628ZU6FyPG+oq+/7/ewIVOAnSI8NLsVd16A3K1IdPIBspdgt34vkMuQnv+
 j9RjIJJDDjIPGyInk7pP7CmdHw6Qge+z2MjV4eXmFnhvXsj7cw1F5M1RTrcYPVL0CPBJ
 R7A9IhKfRNs2CtYlyIAz5yB+4Tqv8Ac1pUuPPERAucaeeXtq1GEpyOPHC/VdtMxAEVXt
 2J38XOo0Or6peZ2Fh+yzKjjbvjDPuDbML3tBLbk1jBeBUkHT6Y5h0eMAfnGVFQPcqRoX
 2N/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3+td3GZctgDEj7nNnXGODvgEM0NMj690MLg5JNupjsUhuPzeo5QT2FqqgkJykr65Yfs6vk3M=@lists.denx.de
X-Gm-Message-State: AOJu0YznPoTOuKROUayMX6qEcJvRpChA2lv4WTHKhKfxugPUyRMTN/KR
 V0rlZt0jhx9RHvstUkLvvHEkmVtrd9qY8p6tVc76wI/B5LTpdVGXHs0Ew2UJ12E=
X-Google-Smtp-Source: AGHT+IFW6kV6NlGOZFP0Q6d0v8rhZQHqe30HwGnHs5Fzmv4Mo6lv01hyWo+Vg3UnZht4p4EchnmtAg==
X-Received: by 2002:a05:6000:1549:b0:37d:3dfd:cd92 with SMTP id
 ffacd0b85a97d-381f1725562mr13590785f8f.28.1731409137230; 
 Tue, 12 Nov 2024 02:58:57 -0800 (PST)
Received: from [192.168.7.95] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed97c976sm14946102f8f.28.2024.11.12.02.58.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 02:58:56 -0800 (PST)
Message-ID: <cbc9766d-2607-4464-a6d2-1a074cf66ff1@linaro.org>
Date: Tue, 12 Nov 2024 10:58:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] net: lwip: Enable https:// support for wget
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Anton.Antonov@arm.com, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 u-boot@lists.denx.de
References: <20241110083017.367565-1-ilias.apalodimas@linaro.org>
 <20241110083017.367565-5-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241110083017.367565-5-ilias.apalodimas@linaro.org>
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



On 11/10/24 08:28, Ilias Apalodimas wrote:
> With the recent changes of lwip & mbedTLS we can now download from
> https:// urls instead of just http://.
> Adjust our wget lwip version parsing to support both URLs.
> While at it adjust the default TCP window for QEMU since https seems to
> require at least 16384
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  cmd/Kconfig      | 19 +++++++++++
>  net/lwip/Kconfig |  2 +-
>  net/lwip/wget.c  | 86 +++++++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 97 insertions(+), 10 deletions(-)
> 
Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Regards,
-- 
Jerome
