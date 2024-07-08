Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07C8C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 10:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 025B8884F9;
	Mon,  8 Jul 2024 12:43:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dZlWy2Rh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA189886D7; Mon,  8 Jul 2024 12:43:10 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C058C88370
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 12:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52ea2ce7abaso4898122e87.0
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 03:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720435388; x=1721040188; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XyRdlq6oRrK0VM7RU+8pSBpB5t2TOK9NKlSSpagR9hg=;
 b=dZlWy2RhOscpv2SbfsyWnaQewxkQ+8WkMLybLEskwA04WBa7d8cA2AKhpgv/2Thq5q
 m0UuJnWMuMXcjp6WG99SlpLdhCzs3pjlUH+3bG0rGYkX6+msFBgKd32YmEpowOnXySLn
 ZPS2t7o+izFOL+T1nCnImf2MPr1jGHRLrnLa6b+94spimK8m1fSIPUPFblKvj7CEkK+R
 S0KKQuBBVFx4g/YxytSLER7n4pBJhOYTbnbJdawAso79Pvbpjm4ppH/6iEuYoIn4j3Wz
 qiLZiuXt1YUG9/u1/7UZeKRMtkCpV8DrEigW7R3dD8sh8RnbFG/iu0ngfuzsKqWA1wEV
 8GUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720435388; x=1721040188;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XyRdlq6oRrK0VM7RU+8pSBpB5t2TOK9NKlSSpagR9hg=;
 b=AOjttf4MFBP48Vbbt4DpmX4KO9NadRWrUKFp2a95TF7r2bwGC5K7IXmsQBhuFl3d+1
 45gHoG+Q5R/zp/tDXdXlRZwwdh53YRKvJYY64TIVfS4PrVFmAW1JsQmVipKqEYHAx/En
 frtP2S7ZRgXapLmoQQqK9pVaoY6WamgImZAC5l2FukUGUVqmbymOFRapSXsWhdKCUi5U
 GHEOdJ9s0esKZpaN/h8qIORyYDIkUk4yE9L2O4i0rGrwcW5y+SMnG0JhG38rFv4aUUE9
 A3oAKZXhaZWmH8hZxe79cXE4ih18B7SiiYpQzbPR7XTh026KuUkDk3nbbaZp6WWKfFxN
 +5LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWZZh/JGOEVuY+BVhDFhgGp7qLjV65TFGP7Zo17dpwezAp7UeELcc2368O6h5+Ig2QPs+ppYi1vSqCtKkzAhFFP4O0zw==
X-Gm-Message-State: AOJu0YwnCRodx68T665Q2CSTqexCWW4yTEmk0NURV4whrgs+1684rxrH
 epjPnPKgW0v846BLSYSrAInQHtY7yU1JW8cdI/ESf2few2pRcCS6Xh8hkDqu/ns=
X-Google-Smtp-Source: AGHT+IHfEeE6QdmIbqmYhhFioLu7vvEImHMuAdnu3a/sz4qHFG2tI/zyz5Lq41FE2OQ+ZOqxgfa9Bg==
X-Received: by 2002:ac2:4ec9:0:b0:52e:9c66:5fc6 with SMTP id
 2adb3069b0e04-52ea063b04amr8198659e87.34.1720435387982; 
 Mon, 08 Jul 2024 03:43:07 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::18f8? ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58e2f7c0e00sm5225812a12.6.2024.07.08.03.43.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 03:43:07 -0700 (PDT)
Message-ID: <b18f0af5-c066-467f-81f6-11ce8a181ae3@linaro.org>
Date: Mon, 8 Jul 2024 12:43:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] soc: qcom: rpmh and cmd-db drivers
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240617-b4-qcom-rpmh-v1-0-bd2336923e0a@linaro.org>
 <20240617-b4-qcom-rpmh-v1-2-bd2336923e0a@linaro.org>
 <CAFA6WYM9hPFpb9F=nYSe-UkFbGMuUuJBiBfMiUzrSowSxvOUNQ@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYM9hPFpb9F=nYSe-UkFbGMuUuJBiBfMiUzrSowSxvOUNQ@mail.gmail.com>
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

Hi Sumit,

Sorry for the late response.

In general, I'd rather keep this port closer to the Linux original, so 
that future cherry-picking of new features and fixes is easier. This is 
quite standard practice in U-Boot (and why the compatibility macro's are 
included in the first place).

Otherwise, we end up with our own quite different implementation, with 
the higher maintenance burden that comes with it.

This port doesn't do a perfect job at keeping close to upstream, but 
still I don't think we should stray further without a good justification.

Kind regards,

>> +EXPORT_SYMBOL(cmd_db_read_addr);
> 
> Export symbols aren't required in U-Boot here and other instances in this patch.

...

>> +       /*
>> +        * Wait until we read back the same value.  Use a counter rather than
>> +        * ktime for timeout since this may be called after timekeeping stops.
>> +        */
>> +       for (i = 0; i < USEC_PER_SEC; i++) {
>> +               if (readl(addr) == data)
>> +                       return;
>> +               udelay(1);
>> +       }
> 
> Can we rather use readx_poll_sleep_timeout() here instead?

...
>> +       for (i = 0; i < 5 * USEC_PER_SEC; i++) {
>> +               if (readl(tcs_reg_addr(drv, reg, tcs_id)) & BIT(tcs_id))
>> +                       break;
>> +               udelay(1);
>> +       }
> 
> Can we rather use readx_poll_sleep_timeout() here instead?

...

>> +
>> +       spin_lock_irqsave(&drv->lock, flags);
> 
> Locks aren't needed in U-Boot, can be dropped here and other places.
> 

...

>> +
>> +       spin_lock_init(&drv->lock);
>> +       init_waitqueue_head(&drv->tcs_wait);
> 
> Similarly waitqueue should be dropped too.
> 
> -Sumit

-- 
// Caleb (they/them)
