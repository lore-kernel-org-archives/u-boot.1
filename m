Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C61C87FD2
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 09:16:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5A3A83AA4;
	Fri,  8 Aug 2025 11:16:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XawDAePn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84B6783ABE; Fri,  8 Aug 2025 11:16:30 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BA5883A8D
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 11:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3b782cca9a0so1113325f8f.1
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754644588; x=1755249388; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lig40jDoQpxLh+PrLSIkqnVMGrtMjpSpVplrsdkIPw8=;
 b=XawDAePntVrAHYP3PCK5w2KZ2dSfkv/3lyY6UCQOcDqlSoimTlsDhRX/bb4q0g6NAG
 4LroLldMfHxA2Pe1lT1pOmKGy9W1TbzqPs3eoX4Lljoq+iPxunoCUCVQmvAz9ApF1K1f
 GR9yoU0Mb7+IMqEhR8k5jAz77YrrImG1YAAtwoPWtOSKp46w/syTqU7uCuYduGv9RHpv
 t7HPwVEV9U9e0dUOdNiyXByQoPRWwtg3NS+W5CnCkpM5ZWE1ktFYw9SnNqZF70z+Gpzk
 tjz7Wgj2Li02SI0XVjLLADDy5sU5lb2JI0VIPmS6bl8pXw31y40JfS9qsu+toVsjflAa
 IbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754644588; x=1755249388;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Lig40jDoQpxLh+PrLSIkqnVMGrtMjpSpVplrsdkIPw8=;
 b=aEpcOU0aV8VFks6fmd1HlX9c1Ac7GsaynUYz4ttK/jYaYKyALtzdZi9y9xfQ/y9t/8
 lCrISWwAYFSKupVc4aJnMievdhNB1x38/DWOaGmSNRA8QNCL1Doe6J9tl33nEXeyZtHe
 zIg9nbRmws1Dhh/RON5ROe0bQLDFNHZz428bdaiAoN3XvQ76X1E0OFy5lbL+X4fSR6YI
 k9iMIDhlRGk30DCCN0aR1+mvJx05KUROOrQv4h7y6iK/hCXyX3mXLRPjMsdql9+MJbnM
 geAHuMSj7ruME4skkohu3bZb6JbMPrI3xfDT2yMs+EV5aBVKTfRv2HPw8W7e1EqLygYj
 KUsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv3w9TSDQ1c+qSLAt+GfLAU8OGCoYWQH4HvaJceALRTLihHi9n5M+OGBJmHr4b/1vVZrPFRyU=@lists.denx.de
X-Gm-Message-State: AOJu0YyuNDXKe9drVymbG5fVJQII61ZVI6JoGwLh4gI0DOAcjTWwxLj4
 zzwmNzqq2AB4PPx9Wov9PIrD2jAJCkIW4aHg7JWtpl2kXca0XPEbKbsj321SuHaYzuo=
X-Gm-Gg: ASbGncu4sD5aOdZXn3V+YBybrt6LXvC2vPRVFh0/xexnbfkDqMITfGOdxMWjXfydhoF
 n1eiciRI687iKnweTiOek6h+43ZL1AocqMUJpjvUKlfLGKo/tZEvy3dE7YcRmwFe+U0mitAL1gU
 49IKD19TbrHGuu6gMER2k6LdezXuqTzEEjPrHKH33/9zX44tm5yKU4b9K2eCaBGAQKa5THYMP2Z
 Em3HfSVeEra5Mpp1a+m1YmWLPZVOO/G50pn/h4OSw1L393F2HS+VT52Ad3zI9cgazt3qCH/hAJM
 N5XPxmMkxKUNMArcSo1pW5Vi6PwVMQ5V2w0rfvISkU9f1ID3XrXh7tZLYDO0QU3Icc3Ng0JddkS
 y14wuBa7kPYsYWuWQFEMPvJSohuOBFde0Yd4nd4HSHsPBuZ/alJYA6QTUbGY80yxtQWvSB/czKv
 lP4A==
X-Google-Smtp-Source: AGHT+IGbp+dl+4mG7i82zns1+xTFqtev01z96oiqf63+1l91Amk1Slr2le09uQTc8M2ogfM+yoCoSg==
X-Received: by 2002:a05:6000:381:b0:3b7:9c28:f84b with SMTP id
 ffacd0b85a97d-3b900b5050dmr1842848f8f.36.1754644587716; 
 Fri, 08 Aug 2025 02:16:27 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:e7fc:9a8d:4024:d186?
 ([2a0a:ef40:f9e:3c01:e7fc:9a8d:4024:d186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459d712c386sm211094225e9.23.2025.08.08.02.16.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 02:16:27 -0700 (PDT)
Message-ID: <f7b87c8d-63c1-461a-857c-d8e2cdc0c630@linaro.org>
Date: Fri, 8 Aug 2025 10:16:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: "Simek, Michal" <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Smatch report for Cadence PWM
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

I have the following Smatch report.

drivers/pwm/pwm-cadence-ttc.c:73 cadence_ttc_pwm_set_invert() error: 
buffer overflow 'priv->invert' 2 <= 2
drivers/pwm/pwm-cadence-ttc.c:138 cadence_ttc_pwm_set_config() error: 
buffer overflow 'priv->invert' 2 <= 2

Indeed yes, the code allows a maximum index of 2 into an array with 2 
elements, so that is out of bounds. My question is which is wrong? 
Should the array have 3 elements or should the index be limited to 1, or 
is the value being checked 1 based?

Thanks,
Andrew
