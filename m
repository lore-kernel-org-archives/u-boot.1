Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A82C27C53
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 12:33:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4E2588313;
	Wed,  5 Jun 2024 14:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SS/Z8Hlv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CF2388286; Wed,  5 Jun 2024 14:33:40 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BCEC88313
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 14:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a68c2915d99so231242266b.2
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 05:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717590816; x=1718195616; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wF13AKABjyucdHcOfkQEggCMyK2tDFWHpxZE3PaesXw=;
 b=SS/Z8Hlvvzh9/CycdbrKq7tFKlPdm6M9cfjyeYQEhBvsWNbMXblAX7vvu88EZlOW7d
 AqsrdhMVw/IUGUdGVyAhFhv9A9SS7CL1k26zjOjGANjBIp4gZ6BzGLDTjckJep7trxyj
 AdYeXdimkoPzUpeYapZ0ccYTsOXXFF7B8VdGNuyorB1LpWcNmzObU7doTfU63cIiDvcU
 OZCISA4GtVQjGmM77jmwWcVoVceGJn/cc5Oxe0EyYmKt8zjK+CJU4XsUKzCKjlmv2Tjj
 km2POYVP5qLSJPnqHBmo3Czux0xIkEdelqau/zZcxldVerYNKFighbq0tbs2xvegX+PR
 Dlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717590816; x=1718195616;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wF13AKABjyucdHcOfkQEggCMyK2tDFWHpxZE3PaesXw=;
 b=bXN0Ch4PCDmbCJZYfedTkIAiwiUZKrv5jErrzghrSVRrSXE6CpMLjGLhB15y3nvj3E
 zptMOfZisD02bFt2XG2NsBbnjQDuQeKfg4tBsIVA1BBI/tNF7BzqOzwICxL6azIKyNJI
 FUELFau2VXSe5UbfniaeuC88U/gVizc4y3mKELRgiXegKddXGVWcPfp2cT5KkYTf5ql5
 nVLMFCcjthbPpgkMGCHDAt6UsMhCfSaPK4ZaRWW8n8GHg18LvZ/EMaPt5RF6AkHq859A
 ZVlPPx3aXfFKNfWxwYqvd5SNa96G/QBBIazty7C+ElDqnmwjBjvuf0fBx9Tpm48ZnEnj
 v+PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOEsTZ/Tpl3cTkSq9MheyBNUC6i7UZHZXpbmQeTn/ZYZgeTEg98LYtqjYpe722yfcyZfLYjLlatKyzR1Y8yJZI0ftDRg==
X-Gm-Message-State: AOJu0YwRICr69NAzG05AjIgA6JPaVy/D6yX9ZupXlHSg21PvUMvU0ba2
 N6cc3YsC9C6P0xeszMvvsbfJ4yPrHPIxXcwfKcvSkvYc/0qMrxxGunKX6QQj9LvD5a9VU9kXmp6
 1EHvmkg==
X-Google-Smtp-Source: AGHT+IEnCnPZWTNj4ORh9/Mo8gNKXih+icWK+4Ulfg2zPvb2cPgVOya76WaOet+GYRH9PfoWj2uukQ==
X-Received: by 2002:a17:906:ae8d:b0:a69:1a11:d396 with SMTP id
 a640c23a62f3a-a69a0000b9fmr150015566b.71.1717590816414; 
 Wed, 05 Jun 2024 05:33:36 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8090? ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68ab7c72b6sm649333666b.50.2024.06.05.05.33.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 05:33:35 -0700 (PDT)
Message-ID: <0361e6b1-b0cc-453b-968e-999d1913a3db@linaro.org>
Date: Wed, 5 Jun 2024 14:33:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] mach-snapdragon: implement capsule update support
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org>
 <20240603-b4-qcom-capsule-updates-v3-4-fe2e083289ec@linaro.org>
 <CAFA6WYNa2zQoHqqaGYxQ=x=3jdw=rKMVRjXLCB65HG6CxNQAwQ@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYNa2zQoHqqaGYxQ=x=3jdw=rKMVRjXLCB65HG6CxNQAwQ@mail.gmail.com>
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
>> +/**
>> + * qcom_configure_capsule_updates() - Configure the DFU string for capsule updates
>> + *
>> + * U-Boot is flashed to the boot partition on Qualcomm boards. In most cases there
>> + * are two boot partitions, boot_a and boot_b. As we don't currently support doing
>> + * full A/B updates, we only support updating the currently active boot partition.
>> + *
>> + * So we need to find the current slot suffix and the associated boot partition.
>> + * We do this by looking for the boot partition that has the 'active' flag set
>> + * in the GPT partition vendor attribute bits.
>> + */
>> +void qcom_configure_capsule_updates(void)
>> +{
>> +       struct blk_desc *desc;
>> +       int ret = 0, partnum = -1, devnum;
>> +       static char dfu_string[32] = { 0 };
>> +       char name[32]; /* GPT partition name */
>> +       char *partname = "boot";
>> +       struct udevice *dev = NULL;
>> +
>> +       /*
>> +        * There is currently no good way to check how U-Boot is booting, but we have
>> +        * a few hueristics, like here checking if our DTB has a kaslr-seed specified
>> +        * will tell us if we were chainloaded by another bootloader.
>> +        * FIXME: we should do this check once and use some proper API to expose the data.
> 
> If U-Boot is built with LINUX_KERNEL_IMAGE_HEADER enabled then we
> should know that U-Boot is built as a replacement of Linux kernel and
> hence chainloaded. Isn't that what you need here?

Not necessarily, you can build with LINUX_KERNEL_IMAGE_HEADER and then 
pack U-Boot into XBL or flash it to hyp and it will still run (the 
kernel header is specifically written to behave like a nop slide). So we 
can't rely on this.
> 
> -Sumit
> 

Kind regards,

-- 
// Caleb (they/them)
