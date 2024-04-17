Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C67C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 08:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFE6D88414;
	Wed, 17 Apr 2024 10:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="L/x3nN6o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D4D88842B; Wed, 17 Apr 2024 10:22:54 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 130B887F2A
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 10:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 59FEC412F8
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 08:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713342170;
 bh=ftv9qw4kFUdmcvTXsRHECTyRxd3D5PNB1mSAQFYNaLE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=L/x3nN6oIbOhc3M1rXq4fJcDjqchIXFEn0+9CpTJ+7JI6AahzvmMZgm4uncFFhGHm
 aKEriNVrJJrgEMiq+2vzu2TiCHIdN+gQHrxsgvc+Q6t3fkzzZn8SuTkWk0+sIDtHij
 /ZpMjxA4fV+qj7Nu56/tEOhVw/XCSdc9kvFalwDxFAy8c/mAAjl6pW9V5+hYKdKbg6
 6DsbN1BZ91bJhaXoWthbdF0+pPaiFaKgQY+mX0FfVyH4mUZRsDclGMIGbWMJsC/XMN
 uRUfBoOAY2dDQkEZ2oMM8ZZIwMHLTS8zBy8PlRxAqNM2UYjBdegqeexcmn5j7oh/Uv
 r/v+wpnaV1H2Q==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-417bf71efb4so2891175e9.0
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 01:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713342170; x=1713946970;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ftv9qw4kFUdmcvTXsRHECTyRxd3D5PNB1mSAQFYNaLE=;
 b=FArV+5zwiE0ZMH4Ge3QjDCFZGrKLoOwNiKmeq/vgfsxtLL7LzcEvkBbipaMslfLlQq
 ywNk0kf00AdfplhYU3r82z8xMAfclHrXpT3lL/KwqLeRSLbfn5OePNrdDF48LvYw1yoK
 4FDlMETUyEW8I3yGH+oocJosxMqqIhgj03SwNZjjUnEpm5B693HeGJlk2zlMnrsuabok
 qsSK9StqvGuAoI87laa8ovNw6Fb5UAFdp3Hzj1uJecrzBCAft1fQFVbBKVkVkeOdpuDv
 qr0nLoW08fkLYJvOZiYs/B8X2f1KFqrQUCROD1vht3lh6ZPYcMNvHW3Nkek5TWLd8TJw
 9K8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUAAXB38PTWob9BASid57oO4+JkbF8YXU0ZXT30d+yfRjLI5HpKnLE5J9LiD7vY2CAXcNrtm978gbQLFw6+5SyiZBmdQ==
X-Gm-Message-State: AOJu0Yy6jnV87SprHicD+aRM7rDGgwYDKS3f4sqzC9i4hHg1SpI+dyP4
 0xypJ14gcxbf2LsnqzHYcVh3gnBK3GGxorXBsqwl+2j5KtZdaOzaOut5dS9DffuR1b+0K+HflFU
 FZMAN/dFuXbDNTuAzT7v5SUSx69yEBz/aLzVijH27lVbolCMsASaATv7TZoyQ6dLdwKFRpEOo2R
 I=
X-Received: by 2002:a05:600c:4ed2:b0:418:91ae:befc with SMTP id
 g18-20020a05600c4ed200b0041891aebefcmr1514259wmq.0.1713342169783; 
 Wed, 17 Apr 2024 01:22:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0CqWygXr/aHW8PQA7ReVpEX1oJJudx7X2DCatHq3iCNG7WYgH89MqUK4EL8Z/0bY0tQV/lQ==
X-Received: by 2002:a05:600c:4ed2:b0:418:91ae:befc with SMTP id
 g18-20020a05600c4ed200b0041891aebefcmr1514241wmq.0.1713342169372; 
 Wed, 17 Apr 2024 01:22:49 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 fk5-20020a05600c0cc500b00417e01ce03bsm1819901wmb.17.2024.04.17.01.22.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 01:22:48 -0700 (PDT)
Message-ID: <73cea290-b42d-468c-8525-c285fcc7810f@canonical.com>
Date: Wed, 17 Apr 2024 10:22:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] configs: visionfive2: enable SPL_YMODEM_SUPPORT
To: E Shattow <lucent@gmail.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Shengyu Qu <wiagn233@outlook.com>,
 Shiji Yang <yangshiji66@outlook.com>, Seung-Woo Kim
 <sw0312.kim@samsung.com>, u-boot@lists.denx.de
References: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
 <20240415115035.46199-5-heinrich.schuchardt@canonical.com>
 <CANV2PTNLVMQQYugK4HB3Yv6WXmrbXBLB0FswKPHqq47OkX-DFQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CANV2PTNLVMQQYugK4HB3Yv6WXmrbXBLB0FswKPHqq47OkX-DFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 17.04.24 03:41, E Shattow wrote:
> Successful in use w/ 'tio' serial tool and Adafruit CP2102N Friend
> adapter on Mars CM Lite board in DFRobot mini router carrier.
> 
> While SPL and u-boot.itb payload are sourced via UART the environment
> variables are from the environment variable storage as-is. This makes
> sense in the use case for development but may have side-effects in the
> case of U-Boot as a JH7110 recovery tool. There is now 'env default -f
> -a' which does not purge non-default variables and retains the
> non-default variables when migrating from vendor firmware. Consider to
> also build for U-Boot the commands that can aid in cleaning the stored
> environment variable state CONFIG_CMD_ERASEENV=y and in-memory state
> CONFIG_CMD_NVEDIT_LOAD=y. With these it can be done easily with: 'env
> erase; env load; env save'.

Thank you for testing.

After erasing there is no need to save the environment. If there is no 
environment on flash, the default will be loaded anyway:

   *** Warning - bad CRC, using default environment

Instead of 'env erase' you could use 'sf erase 0xf0000 0x1000' which is 
already available. As adding CONFIG_CMD_ERASEENV=y is not necessary in 
the scope of this patch series I would prefer leaving it to future 
discussion.

Best regards

Heinrich

> 
> On Mon, Apr 15, 2024 at 4:51 AM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> We can use U-Boot for recovering JH7110 based boards via UART
>> if CONFIG_SPL_YMODEM_SUPPORT=y.
>>
>> * Send u-boot-spl.normal.out via XMODEM.
>> * Send u-boot.itb via YMODEM.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   configs/starfive_visionfive2_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
>> index fa80d489f5e..e2d83c62b28 100644
>> --- a/configs/starfive_visionfive2_defconfig
>> +++ b/configs/starfive_visionfive2_defconfig
>> @@ -62,6 +62,7 @@ CONFIG_SPL_I2C=y
>>   CONFIG_SPL_DM_SPI_FLASH=y
>>   CONFIG_SPL_DM_RESET=y
>>   CONFIG_SPL_SPI_LOAD=y
>> +CONFIG_SPL_YMODEM_SUPPORT=y
>>   CONFIG_SYS_PROMPT="StarFive # "
>>   CONFIG_CMD_EEPROM=y
>>   CONFIG_SYS_EEPROM_SIZE=512
>> --
>> 2.43.0
>>
> 
> Tested-by: E Shattow <lucent@gmail.com>

