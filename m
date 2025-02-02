Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC38C0218F
	for <u-boot@archiver.kernel.org>; Sun,  2 Feb 2025 12:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0F2880077;
	Sun,  2 Feb 2025 13:01:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="F1SGqWCQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16B3380079; Sun,  2 Feb 2025 13:01:07 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C9608006D
 for <u-boot@lists.denx.de>; Sun,  2 Feb 2025 13:01:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5B9243F220
 for <u-boot@lists.denx.de>; Sun,  2 Feb 2025 12:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738497663;
 bh=ioFK3zbNu2KCDKRwrhxwOAzUXFyIdFr14WEcPKuse3A=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=F1SGqWCQgVtzyZav327OU0DHlrWPRxe1rUWDrsXW+e2zAchX3GRNJNDB9F6GD993c
 V6qSjAtKXDz24ccP4ig8yvnnfZ0UcrLUXpFirjaaNkGd4vK4QZptBR7jVzK8hs7eS0
 C/nwXt6Bsh20y5g6j4HsPo22tDy0mtkl7oaag10/8BCo/TEKtshn/3Z34I8GezePm5
 dVJCX1LCN2s5Wg3hJ6D0qjYWvB2ysMrsRHD5FdsBDyScZmTat3HJBdpKIpiFpetoWE
 Bo7CpFCYRH55Pq1I+ZuhFJ8qGd+RW+LKeUgHt54/SHOP/KF19+EteG4VZZsW39swql
 PJOd8uq83Mshg==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4359206e1e4so29685535e9.2
 for <u-boot@lists.denx.de>; Sun, 02 Feb 2025 04:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738497663; x=1739102463;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ioFK3zbNu2KCDKRwrhxwOAzUXFyIdFr14WEcPKuse3A=;
 b=Lk+AzNPyZfmBEF9BP580vWmRGeNKcyQTmUAedxVfAGxBqVdqF0Apns3/Zxd8rf8WZk
 I+D0Fst4UviFjYew84+dUqnki4lxzQatSbUrN6b3atsbJnPimiliHg6zPEA7tBZsta0l
 xWW5jQ1YbEI40sJT4dY0yO20b2jOm6ucopY+FPiMrW2S+y8Nka/bIU1uUa3fsuhKEqq0
 SJ3bBHBaH3amiFgx+hPp/aVnprD91Y8DvnNq9zJ8COShN5/izn68DPefP9V5+2D3DcjE
 /wqLBj3PTJtxfC7FL9cowi9YWQHfGrwurP2/KtvMWYx7oAEM9y+357y9Y4ocok0kCJ/M
 7BgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOGKOplqmaVhpC/ln9KRnMzyJEXlL5b3HJA+YZALq+j0otAQ0FTFu8Yw1vsj+oAoISTGVKwEU=@lists.denx.de
X-Gm-Message-State: AOJu0YwAnPVK6erm1tFc7uw9uoufyUIKd9OWXpC5VomJVlVoTnXz3fxw
 hMAXCLiDVB6YbgMyMRCaTiFFQucSxL2Szk+NJF694MMDBr0nKnXfkWFn7CfHcuupxv7ruRRCza1
 N9VitnltagsNU6FvtwO7Ri+jufAeC78T95p5I6qiPpSL18NYaCJzcaX4XAWa5o+0u8FA=
X-Gm-Gg: ASbGncuDjswaIR/TUxFUSBQ7VgdEo4h2fNY5QQP10tfIAI0LH89Txbcmsj7nM+gtwyF
 dzYIW9f/o3dbgjq1u5LvsPewYKzv1eZb6NJln75riUjJ3LajAw90EH6WKQcMpxmnUlMbocvd2t6
 iIAWqtvNu6kaa5MSIpxfKVBIWw7HBeGZC+0Vlc8IIfu1PM/C3vTs1j30m93xe0dPobFaajCVpB6
 CzUf3ng5Ucvc0ZETXOslbVy6suyjlGeMsLUmnUnUjhHO4XcB2vH398xX0BIMeV4nNIcrgO3Y8R2
 d2nmKs71PScJgkUaGxZPe1fQ0jcwIpmE0IzDKPWNM2Xhe4k9BubI4c9aXw5EE50fn8VN+Bl8V0m
 LgQ==
X-Received: by 2002:a05:600c:4d26:b0:434:f131:1e71 with SMTP id
 5b1f17b1804b1-438e01febebmr167037155e9.8.1738497662765; 
 Sun, 02 Feb 2025 04:01:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsJZUwKT/in2c4EkKGh7dfLQlX6QEA+VQuHM2z2g46LUqSTfBBcjtiQpp9EsYmFpaibiG3fg==
X-Received: by 2002:a05:600c:4d26:b0:434:f131:1e71 with SMTP id
 5b1f17b1804b1-438e01febebmr167037005e9.8.1738497662407; 
 Sun, 02 Feb 2025 04:01:02 -0800 (PST)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc27130sm152893135e9.16.2025.02.02.04.01.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Feb 2025 04:01:01 -0800 (PST)
Message-ID: <81b96e0f-0721-4488-b379-b09bb0f436a8@canonical.com>
Date: Sun, 2 Feb 2025 13:01:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cmd/setexpr: support concatenation of direct
 strings
To: Tom Rini <trini@konsulko.com>
Cc: Massimiliano Minella <massimiliano.minella@se.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
References: <20250105104614.7916-1-heinrich.schuchardt@canonical.com>
 <20250120205232.GE3476@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250120205232.GE3476@bill-the-cat>
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

On 1/20/25 21:52, Tom Rini wrote:
> On Sun, Jan 05, 2025 at 11:46:14AM +0100, Heinrich Schuchardt wrote:
> 
>> The setexpr.s command allows to concatenate two strings.
>>
>> According to the description in doc/usage/cmd/setexpr.rst the parameters
>> value1 and value2 can be either direct values or pointers to a
>> memory location holding the values.
>>
>> Unfortunately `setexpr.s <value1> + <value2>` fails if any of the values
>> is a direct value. $? is set to false.
>>
>> * Add support for direct values in setexpr.s.
>> * Correct the unit test for "setexpr.s fred 0".
>> * Add a new unit test for "setexpr.s fred '1' + '3'" giving '13'.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
> This causes ut_setexpr_setexpr_test_str to fail.
> 

Hello Tom,

I am not able to reproduce this problem in Gitlab.
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/24424

Please, provide a link to the failure.

Best regards

Heinrich
