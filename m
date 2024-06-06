Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD646C27C55
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7FAB881DB;
	Thu,  6 Jun 2024 18:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j27Ew9m2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B6B588216; Thu,  6 Jun 2024 18:21:45 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3525F881A1
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 18:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-35dcd34a69bso1150742f8f.3
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 09:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717690902; x=1718295702; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y40V8IkEGDWdZGt6HiyCq2babx+CWUnaukkkHI/y6s4=;
 b=j27Ew9m2eYZ8+8OVpi/6Gs8/ny2wWJ1jexsn3ygBJV/5jZTFf5quheRUYzvJk0FYh4
 gKWK5TKSzxMLyOwp6H6z+bItNOkYV6oAoT0BpOj5tv5tMAmVxbbfxNsDJQonlxrTTMFG
 1I4h/y/ZST3OxWL15gtFoPPzGbolKMbG1yikO8ShbgadNmAqmMq+u64wdh0KNxpdBY3V
 HM/NqiX57PHj5iSSOWFAcSVKdjtOInfltPvpUdKd7xfZ3Iua6bcZvU6fB3fb2s7GUu23
 B4ziUiJWgPtzKZk4S7ojEG6Cntpxa7CD70Zs/bUEj0Ju15xJ+/sICL6c39o1XVxHI2zy
 jQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717690902; x=1718295702;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y40V8IkEGDWdZGt6HiyCq2babx+CWUnaukkkHI/y6s4=;
 b=WstUh1BAHwDGQK7WefayuJC+WGm/nvPGmUj3NQBVh4dBeGNln4uHf7ldl2eiMZZt7t
 FXjHYaKGRlm+NTMplf8R2zf7djBpz4VW5fj+Y+tBZrLvFghvxUyUhltPUq0TjdDMtedG
 zSOsAHMIq53+oyfUVY27ra3tYx6qTndynkOxTcKIyZhmsc1N4TBhdyZfAE7Vq6oOCpnQ
 n1Jr3sPkABDBr3MiZSx+2CyZeFzTQq7zkHMASfwozNd1V9lzY4nH47tbHZSe2cXH7U/S
 +hp8brKi7DSaRPvHERKBetRpCUMbpXMyXX4xS4YEnnYvcC5vUL3ccsSz4HK8I5Jjblsf
 9Jhw==
X-Gm-Message-State: AOJu0YxB+aSdmEkSXs48JsRjzx9EoXkcOxAw0/pp1kwAeTWogXjBKw1H
 5e7fILx6EJtmOS86ON+FgnCxiOTvm2OmhCDG6vf0eiT1nMnB52KG6qcpG1sWymk=
X-Google-Smtp-Source: AGHT+IET23M6Kfz22eJFOKrfmy8x8oOU2e84dJezoHcraXNuDWVc5+jzplGDYxNNj3bycJ9tRBqBkw==
X-Received: by 2002:a5d:6d05:0:b0:35d:be9a:3276 with SMTP id
 ffacd0b85a97d-35efed4e30cmr106714f8f.18.1717690902598; 
 Thu, 06 Jun 2024 09:21:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9?
 ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d69917sm1955650f8f.62.2024.06.06.09.21.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 09:21:42 -0700 (PDT)
Message-ID: <daca61ca-f111-4509-bad9-c4c5e3cbc068@linaro.org>
Date: Thu, 6 Jun 2024 18:21:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] net-lwip: add dns command
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>
References: <cover.1717680809.git.jerome.forissier@linaro.org>
 <a81309b7d6f3a5bbccc7a5ad45b11f071a3f50b1.1717680809.git.jerome.forissier@linaro.org>
 <CAC_iWjJCGv+CCLQ5R8jH8248Pe-mAEihdd_YbUr_Eq2J4iTjMg@mail.gmail.com>
 <590d8389-defe-4297-91f3-f5dcfef5595d@linaro.org>
 <CAC_iWjJJr_mb6=0Yp_FpZN8cK2s_wx9ZpGYHc7n4UtWxJrqhjQ@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjJJr_mb6=0Yp_FpZN8cK2s_wx9ZpGYHc7n4UtWxJrqhjQ@mail.gmail.com>
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



On 6/6/24 18:02, Ilias Apalodimas wrote:
> [...]
> 
>>>> +
>>>> +       if (!ipaddr) {
>>>> +               printf("DNS: host not found\n");
>>>> +               host_ipaddr.addr = 0;
>>>> +               return;
>>>> +       }
>>>> +
>>>> +       if (var)
>>>> +               env_set(var, ipstr);
>>>
>>> Do we need this? Won't this set <dns_name> == ipaddr?
>>
>> No, the syntax of the dns command is: 'dns hostname [env_var]' so one can
>> pretty much give any variable name to receive the IP address.
>>
>>> If we do not need it repurpose the void *arg and get rid of the global 'done'
>>
>> I could probably use a struct to get rid of the globals. Let me see what I can do.
> 
> Yea just pass a struct with char* and a bool * and you should be fine

Done in v4.

Thanks,
-- 
Jerome
