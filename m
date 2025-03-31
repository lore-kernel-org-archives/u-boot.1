Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE40C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 09:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6468D8129B;
	Mon, 31 Mar 2025 11:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gsqdo9Wz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 205F5812BC; Mon, 31 Mar 2025 11:21:31 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07AEB8006D
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 11:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso43855545e9.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 02:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743412888; x=1744017688; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eaiJDZwulnGsh6JhvY6W5z/nMWjCB7H8wZ8BOCZANHg=;
 b=Gsqdo9WzxJDeT88HG0DzYC4cz72HR+rOMb4Vr/n2UFWhbO8pBVifI/XEe9LxDjk+0P
 2upazDRL1MxOqWvMfUfyihGwaOx0/yddtiLIuBoa5+yjplB6z3fHP5+f/zHC/nzVZCgY
 kqTTFJZ+dJ9IysiKNzN1+PeRE2vSK2KI2oBEi0YizLSX/49MLe/v9ohzxHmZiTQ5TL4B
 d/tLuZjZJUSPqX/q0UofVsY+uh1vBP3dwyHlK3CYvn3eUySEZg4+wjGNQ1sYqJPwuANA
 dEhmXGRlAx28ENIpucAgBYGTO5GlNnNuXFEyJnXjYLHD+6WXGDmOhucnoIn5voJD6Vze
 Qmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743412888; x=1744017688;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eaiJDZwulnGsh6JhvY6W5z/nMWjCB7H8wZ8BOCZANHg=;
 b=IrKOtJiKkuQ1hoYGqsNTF1DJr9VxRh0lMCMO1qEzGJQK++u6r75MVNm/Lig3IpU12I
 32zcNtzBIt/G+ieha4p0CzW4FhREzy3nWbTxoOY/zy4dxkf5fffMbsUjdHFmAlyYVQwv
 TDnTbIKliFUrV1IJ7wrsJGJ+N+lpfv9qNgwu3/xi4wGBwv1iw5+A2gCnqDk2rMVSJJGA
 m0JmwAX2iSlf7FSXnaf2zqhqBIyQcOm4WELMiFKKMXpeqxjwgn8dWQYgcQxDiXkdn4q7
 4plxhlCh++w+U6wSpHZiseMz8nJecam+M4X47+RcB27xaO6YESad5frzIl0vR1WKrNOv
 RxVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpAlhWBMgWlcW5XOh8G54bN8R2HhUqxZkN+Dt1sUh1Gjt8tUGew8ZGmI3bZPJ5N2u3TwrQtng=@lists.denx.de
X-Gm-Message-State: AOJu0YxVV2GYLBG0E4Cq7zn+3XPSqNwJpZxY2Eg6++FDSje9QRVyzSGI
 te6PJ1QJzflo8cmaMWk7Jdmap0UfuwtcfjIrXqMu7bdrXnW5n8X8W2xZZBG1vj0=
X-Gm-Gg: ASbGncvNf5K3qJEhFfQejhhKVRHV4tV147p594x1Fue456I1AKDhaF0RgOVNESz2HM4
 QiP44m/WAE4gQbscFMcDKIE6dPiyTDRswwNCcJbadZkp3LZQNRs48JGdd/msN8s2EAxnyEIC8fU
 P14uvmYPA6laY849eKn5X4E5l6Hw5ZHoVvlP+O+2z9QtIJtAdg5iS34hf+YDcJoyV9BGTHNGznl
 1RhmykWdkX2tf9RzTUoGdzhAv72H3ozKrmeowlRPq2Psm9/oWgxt8UhU06UNGcrIIQzplWmDvis
 uKmaK6tcGp56kN9Dr1m0SV8rGcxblgISHoFEVIAa7eZAlzOrYqN35oe8AhhmV9Z/uyIbLqVjxKJ
 rdgFRA0WHSkth2nHmS6up0Va+EasoPUTWr4U=
X-Google-Smtp-Source: AGHT+IHa3LrZTuwn4oXJXJGtxhz38IHpAY47j+DKIvMmhFHRPGbREE2n65pkmcX0GZZ4jtKNdOSPdw==
X-Received: by 2002:a05:6000:4412:b0:39a:e71d:ee34 with SMTP id
 ffacd0b85a97d-39c12117ae3mr4341717f8f.37.1743412888384; 
 Mon, 31 Mar 2025 02:21:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:26ff:1b86:d0f9:9aad?
 ([2a01:e0a:3cb:7bb0:26ff:1b86:d0f9:9aad])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8835e627sm145586765e9.29.2025.03.31.02.21.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 02:21:28 -0700 (PDT)
Message-ID: <611a9c31-83e8-4a1c-9f83-bc3e23320c90@linaro.org>
Date: Mon, 31 Mar 2025 11:21:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/14] cmd: add spawn and wait commands
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>
References: <20250318104659.1114340-1-jerome.forissier@linaro.org>
 <20250318104659.1114340-13-jerome.forissier@linaro.org>
 <87msd1prd0.fsf@baylibre.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <87msd1prd0.fsf@baylibre.com>
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

Hi Mattijs,

On 3/31/25 09:54, Mattijs Korpershoek wrote:
> Hi Jerome,
> 
> Thank you for the patch.
> 
> On mar., mars 18, 2025 at 11:46, Jerome Forissier <jerome.forissier@linaro.org> wrote:
> 
> [...]
> 
>>  
>>  obj-$(CONFIG_HUSH_SELECTABLE) += cli.o
>>  
>> +obj-$(CONFIG_CMD_SPAWN) += spawn.o
>> +
>>  obj-$(CONFIG_ARM) += arm/
>>  obj-$(CONFIG_RISCV) += riscv/
>>  obj-$(CONFIG_SANDBOX) += sandbox/
>> diff --git a/cmd/spawn.c b/cmd/spawn.c
>> new file mode 100644
>> index 00000000000..f7a9f225f93
>> --- /dev/null
>> +++ b/cmd/spawn.c
>> @@ -0,0 +1,188 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (c) 2011 The Chromium OS Authors.
>> + */
> 
> Nitpick: Is this the correct copyright? For the test code in the next
> patch you used
> 
>   * Copyright 2025, Linaro Ltd.

Good catch, I'll fix it.

> Besides that:
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 
> [...]
> 
>> +

Thanks!

-- 
Jerome
