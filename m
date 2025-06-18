Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A721C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 07:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2443782D39;
	Wed, 18 Jun 2025 09:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KW2W3wWv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D973D82D32; Wed, 18 Jun 2025 09:32:24 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBE1182BCD
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so83276665e9.1
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 00:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750231942; x=1750836742; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kW26l/7KquKsa5rYq5flON8aeeLiIsOuXKqoMqfvORw=;
 b=KW2W3wWvNk3Dv6oE4qNQ9x36T/HZRfbLzstB1/93uthPk9fk/aydDo/h46P3l+ylja
 wifgBAaZ9sum2Yu3VR8O2/+SiJvj7Beqbr+EZ4CYNMZ8GJdTpyJcE9kwz+7efieh5eOS
 NRGmM7IbThh0S9DIYkEAE1vsN4UixvwPBDictIIQ2Hnh+moMZsrYYmdyFqryU8TdC+Yz
 HoUzEtQv5YY1i6bfZnMiPinHnzIC5MqRtKbpsUZ6Hvw9VZvtnpR8xp8H0aDSYLIJMHgO
 iZNLEvGVjMCJvC1Se5YvcFnRz6gWeczlIRrmbGFy3ND8vci5YkLRt4cU0mAPK4mZKuq4
 xSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750231942; x=1750836742;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kW26l/7KquKsa5rYq5flON8aeeLiIsOuXKqoMqfvORw=;
 b=qQYPlF7jLRJTkYizAqD5McrOgD85kcYBAFqJwnBuVV54tRsdDtOhVXCjf9RMzgZ7rp
 GAqnn0e/7CxYh5RZFEVyVJUXHpyxkgykRxatCfY0wGBsEz9XpjXRSgL2/8jI2N3CSZL1
 toZR41PLt0ITN3LGTYhzPaTKEp5SKjy24OuWhCdNHA7O83wQ5e/16W24RxO4WZHZMsyy
 QvRic+K2MeL8BpbtN/Dk/zZc41vTI9Sl2Kjv5o8uK8sBWP7ANkn12oPqoXJHCMGhg/QN
 14tiEEb+RKqlBdYdRyIoUy54MJUJanCIEde9nufB6Uy8KCRG6XgCGa7Y6AFttsBUj3rd
 rE4Q==
X-Gm-Message-State: AOJu0YxKjycJXQukHs0NJrgIU6EOUQibxm6VNgvqXdBf0Uy27uf+TPNi
 XIy+RLasy508A3Y+iYr6PGm0GJA8atibTH0oHlis5LzNisWEZ2O8+G/kwU+Cpn3ld7s=
X-Gm-Gg: ASbGncuvWeWq21YqBCIqf5mQAomzJ8TjeapYZPGSJhEL7a5emYNaaJpl8ew9HEuG5vG
 fHyOsO3e8EZP9s8vlMzxD5WQQhli9J7vX/dyjg+972uJTI/wiXUL7zKGhS4lYb84VNPn/sk1H9D
 AJoUz2TsYCPA7M/mmVJn3H47Q3r9THVKTAY3Hn7IkxjUitaKKu5TpDIJAvhv3Z9IxBxMueG/8+I
 K5+EccH/gzJycYhNrRP+ZP0IJAa/0gr+pAEGc/Svw9QhD4pXD7ucaIe/oftVa6gwZmc4KI2g0Dy
 6W8oGGb5WNry4aamC52ozi/x+OrnhhI58NZEfREIe6diRyHoq0fscMLGOHdBjzoGEinJQfRg4Cg
 J2dowdqL8mnRY3CxynjT6xKn5y/oGlFXNIu7Bqv191w==
X-Google-Smtp-Source: AGHT+IGF8Q+Nu7+Lscc1fu6yG/YmPRl4k90ihTzSjSqhE0yHuxXJSbUvHhdOmIIsIIPXOEXKFBBIkg==
X-Received: by 2002:a05:600c:4e54:b0:450:d37c:9fc8 with SMTP id
 5b1f17b1804b1-4533caa5a8bmr170205735e9.13.1750231942346; 
 Wed, 18 Jun 2025 00:32:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c389:6814:1493:2ed5?
 ([2a01:e0a:3cb:7bb0:c389:6814:1493:2ed5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e224888sm201357085e9.1.2025.06.18.00.32.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 00:32:22 -0700 (PDT)
Message-ID: <a1a2fe6a-5ebf-47da-99f3-57c994eafbd4@linaro.org>
Date: Wed, 18 Jun 2025 09:32:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] doc: add doc/cmd/sntp.rst and remove
 doc/README.SNTP
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Harsha Vardhan V M <h-vm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Maxim Moskalets <maximmosk4@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Wang Jie <dave.wang@rock-chips.com>
References: <20250617100720.2544758-1-jerome.forissier@linaro.org>
 <20250617100720.2544758-13-jerome.forissier@linaro.org>
 <20250617224256.GP1382132@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250617224256.GP1382132@bill-the-cat>
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



On 6/18/25 00:42, Tom Rini wrote:
> On Tue, Jun 17, 2025 at 12:04:02PM +0200, Jerome Forissier wrote:
> 
>> Add a proper documentation file for the cntp command in RST format and
> 
> sntp :)
> 
>> drop doc/README.SNTP. The documentation now includes the NET_LWIP
>> specificities.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> - Create a new RST file and delete doc/README.SNTP
> 
> Thanks for doing this. I see a small problem:
> 
> [snip]
>> diff --git a/doc/usage/cmd/sntp.rst b/doc/usage/cmd/sntp.rst
>> new file mode 100644
>> index 00000000000..eab7c664728
>> --- /dev/null
>> +++ b/doc/usage/cmd/sntp.rst
>> @@ -0,0 +1,72 @@
>> +.. SPDX-License-Identifier: GPL-2.0+:
>> +
>> +.. index::
>> +   single: wget (command)
>> +
>> +wget command
>> +============
> 
> This isn't wget but I assume you started from that file.

Yeah I really should improve my proofreading ;-) thanks

-- 
Jerome
