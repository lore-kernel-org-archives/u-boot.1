Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBA3C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:00:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17745886D5;
	Tue, 11 Jun 2024 23:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JUQwr55Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21A788871E; Tue, 11 Jun 2024 23:00:04 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA49888714
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:00:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ead2c6b50bso66045431fa.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 14:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718139601; x=1718744401; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JRVGUDEZ+PDOuvDDEY+uCE8xggAEE/SPFKYE2vXu3CI=;
 b=JUQwr55ZUtzbglsYhVaXxPx9ZsuX9QPZnw9D2v2qiBs8DA3gvZkahJMMN1c5LCYR8t
 vvRg3Y3jEiwcuvf6rPOKz0Otv+835RaDnY49gvoEU2JLRXuSsWMEgpToqGGDI+k3c/Oh
 fk6XwWw+SJhCR4HBOWjGwur2Vd+aexrjb7Gj6Xb7KRDRLz2Sa0Z4ZDbXLi8Uf0Zaj9MF
 T/tsR30xldlYy8qur0utk5g1kx3gCNLCEqkb2gcOwdfS0oHlic7DH/En2SNHzUufeOkP
 iKRBNCvKYZmT3UgEZxa3a0KF/nDEsqqQMwu12Ph58i9OU2P6hRU30jrGPBQ6t0i9pIzx
 Zn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718139601; x=1718744401;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JRVGUDEZ+PDOuvDDEY+uCE8xggAEE/SPFKYE2vXu3CI=;
 b=t27SHrxXa3fACZe3LS2eviyoUF27OHgA3XoXwQAu4vIc7MrZBoe3u9ESikXa2zhsUD
 f8bC2jA5pQqsRs+rJtGoteIPOM+F0txEoRV5Io7KWEa9IAfOcClqNsI2p44eiZejgtRx
 xbNcqle3PF3hzMcdJOJ4Z251hCXOmLBEwGSLaj8L3HRZ5QbiExejXp32wRzTIf86spQO
 1Xr7jfbnm5l/nut3KcMqetREtUqKubI9mo8Sass3/pJ1K4WtMy3JLIvMFstRqXax/DC2
 cjuoQjuiBGQVvVqLxWSLK0mM6d5zuVfM3yqcyJWGc8x8Ar7fRLB2TCMB2575zmmlFeht
 b+dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwXuqHl6LeYN9jWaOvsHvX7c8/1BCkX3scOP5/49Abv4JdpWqytWpnYMUUNlBmqvZqnVnhh2mFQIG3q4sxyX9y8LYRRg==
X-Gm-Message-State: AOJu0YwkXASKx0BRMVQQDNGRnQGaiydzipZo4RpQ7OPnAc0Z4Z70/Uf2
 uilO7adxhLfECWBa92TrxdWwci2wVU383hwoKYxrTuWkMNNUpsoJ
X-Google-Smtp-Source: AGHT+IHAHYK6sTzuHmbwYf1XiVVvBP3+c3tFx8g/B2Ay+21AVveFKCC6drpvJI+FUEhqsbIDMJ6oLA==
X-Received: by 2002:a2e:8705:0:b0:2ea:f719:317b with SMTP id
 38308e7fff4ca-2eaf7287c04mr67435591fa.3.1718139600645; 
 Tue, 11 Jun 2024 14:00:00 -0700 (PDT)
Received: from [192.168.1.6] (109-252-15-116.nat.spd-mgts.ru. [109.252.15.116])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ebe62669d1sm11941111fa.69.2024.06.11.13.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jun 2024 14:00:00 -0700 (PDT)
Message-ID: <c81b58cb-5304-4b33-adbb-590cd530afd4@gmail.com>
Date: Tue, 11 Jun 2024 23:59:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cmd: move ELF load and boot to lib/elf.c
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Maxim.Moskalets@kaspersky.com, quentin.schulz@theobroma-systems.com,
 sjg@chromium.org, u-boot@lists.denx.de
References: <20240605184334.13973-1-Maxim.Moskalets@kaspersky.com>
 <b95386ab-ec35-4912-934d-c3b611953b55@gmx.de>
 <20240606142136.GY68077@bill-the-cat>
Content-Language: en-US
From: "Maxim M. Moskalets" <maximmosk4@gmail.com>
In-Reply-To: <20240606142136.GY68077@bill-the-cat>
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

On 06.06.2024 17:21, Tom Rini wrote:
> On Thu, Jun 06, 2024 at 09:02:43AM +0200, Heinrich Schuchardt wrote:
>> On 6/5/24 20:43, Maxim Moskalets wrote:
>>> From: Maxim Moskalets <maximmosk4@gmail.com>
>>>
>>> Loading and running the ELF image is the responsibility of the
>>> library and should not be associated with the command line interface.
>>>
>>> It is also required to run ELF images from FIT with the bootm command
>>> so as not to depend on the command line interface.
>>>
>>> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
>> In future versions please, include a change log separated from the
>> commit message by ---, e.g.
>>
>> ---
>> v6:
>> 	foo changed to bar
>> v5:
>> 	xxx removed
>> ---
>>
>> Best regards
>>
>> Heinrich
> Do you have any other feedback, Heinrich?
>
I will take these comments into account in future patches.
Are there any other comments?

Best regards

Maxim
