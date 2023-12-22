Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F47EC46CD4
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 16:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B729786FF7;
	Fri, 22 Dec 2023 17:13:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WyYWA348";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 450CC86A81; Fri, 22 Dec 2023 17:13:54 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51AB0870EA
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 17:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40d4aabc620so2628775e9.2
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 08:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703261631; x=1703866431; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XZT75YvkAVNph9qdacyHg2jWficc5+rUJD2OsYBof8E=;
 b=WyYWA348gwTM1XhmMwx4Itnmw8LSjmB9EcsG+3jFanmx58cF4ugdcatkiQNsJrxTEZ
 YKYXyh190v9IborVrJ7OWA7cTFtEa6zzAgTHF+tQ2IgQIDGry92d4pjS1/8VDAxR5ihp
 fjEYp40Cm5qCqu4R6gGVFWTAFUZfWV2xWZaLGU/J9L1kxHjn2E43pu4aX3pJIcK7olyE
 oGmNvSYjfaG0xZEVpa4s/yHztp5Sz9elEMVYcF42Q6V7+Vr7yZeVc78WjlB+pErKCN0u
 qykD0O7AFJ11KzU+/EVTb2xFLQCgAo4E/KfM8JNCxSSA74Iraa0Mu9zqjfXvsYxHwcPH
 H82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703261631; x=1703866431;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XZT75YvkAVNph9qdacyHg2jWficc5+rUJD2OsYBof8E=;
 b=ftvpQkKeWnpP4Ez1ElFL2kjg+rP6sA+NFnBQaoyxIKDTe7Oq1oHAFXuCubQg6KBsQN
 oVMgtmEJJetl6CWDBzTzH40BYDcRCBggFM7d0q82sWRfA6NceC9WHljkaCvS6VAd+zOB
 FgOFm/tF2XqA+GzlgABavGP+tLkU7KXK0Is7pWY7pOHIJ2/wnKvlhp+pTCrL4H3BSGhW
 V7t/fgkHGXx+NmW+R2h1hU8lK7FQNQzXC2cGV8rXQpVP0XBZ6JTHLrwTPve9J+zWh1zr
 Hp5SAph2ulgX5fXnB7dJ8La8oKFKQEC1q3yryA2U+vsGbkrAnPuUTSW4bwtNVZU5TkuN
 5CAw==
X-Gm-Message-State: AOJu0Yw9ptQdm+QMAWHRpzCh537CN/AfuJGYzjVI4ba/r6jVEJjuJvr3
 kq18++VdY88Na7DQvrt3fqD4SkHuxLbGcg==
X-Google-Smtp-Source: AGHT+IH4QRcTJ8W+gV85zw/gY7sje42pHE+gwHNq1MJGMeTQcMyLK8pKnd/C9TjKVw5mi2IJYOXZkQ==
X-Received: by 2002:a05:600c:3587:b0:40c:38e2:8e2f with SMTP id
 p7-20020a05600c358700b0040c38e28e2fmr933190wmq.29.1703261631289; 
 Fri, 22 Dec 2023 08:13:51 -0800 (PST)
Received: from [192.168.1.83] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 n33-20020a05600c502100b004030e8ff964sm15401586wmr.34.2023.12.22.08.13.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Dec 2023 08:13:50 -0800 (PST)
Message-ID: <e45ca070-82fc-4e5b-a7e9-eb44e956b98f@linaro.org>
Date: Fri, 22 Dec 2023 16:13:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/32] board: dragonboard410c: upstream DT compat
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski
 <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-12-b6dd9704219e@linaro.org>
 <CAFA6WYMvb230qm95QLPW4iNOXPk0fhxDCP-OFN1FWLCsx9P2yA@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYMvb230qm95QLPW4iNOXPk0fhxDCP-OFN1FWLCsx9P2yA@mail.gmail.com>
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

Hi Sumit,

[...]
>> -       if (init == USB_INIT_HOST) {
>> -               /* Start USB Hub */
>> -               dm_gpio_set_dir_flags(&hub_reset,
>> -                                     GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
>> -               mdelay(100);
>> -               /* Switch usb to host connectors */
>> -               dm_gpio_set_dir_flags(&usb_sel,
>> -                                     GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
>> -               mdelay(100);
>> -       } else { /* Device */
>> -               /* Disable hub */
>> -               dm_gpio_set_dir_flags(&hub_reset, GPIOD_IS_OUT);
>> -               /* Switch back to device connector */
>> -               dm_gpio_set_dir_flags(&usb_sel, GPIOD_IS_OUT);
>> +       /* Select "default" or "device" pinctrl */
>> +       switch (init) {
>> +       case USB_INIT_HOST:
>> +               pinctrl_select_state(usb, "default");
>> +               break;
>> +       case USB_INIT_DEVICE:
>> +               pinctrl_select_state(usb, "device");
>> +               break;
>> +       default:
>> +               debug("Unknown usb_init_type %d\n", init);
>> +               break;
> 
> Can this pinctrl configuration move to the corresponding USB driver instead?

Possibly, this is definitely something where DT is currently lacking,
similar discussions in Linux resulted in the USB onboard_hub driver, it
would be nice to add support for that U-Boot at some point.

I don't think putting the pinctrl code directly into the USB driver is
the right way to go, as it definitely wouldn't be accepted in upstream
DT bindings.
> 
> -Sumit
> 
-- 
// Caleb (they/them)
