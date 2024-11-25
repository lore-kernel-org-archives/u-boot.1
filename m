Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A739D3B7F0
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 08:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BD7F88F48;
	Mon, 25 Nov 2024 09:32:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="aXVk6lcB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B92C89577; Mon, 25 Nov 2024 09:32:42 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3027A88EF5
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 904353F0DE
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 08:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732523559;
 bh=j4kQhipfvrzl6OQgB5ZLytvy8jA/07wmnTWvULyNvoM=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=aXVk6lcBoKcsu/y0KxylRmS21Gg2WHuaJeq5nByx/X4y+LdRa2n71lAIgn6ZbQQXE
 oHN4PoJJxK8FishCe3KKNaZSyEG2fM7nB4Q77fyx4sBJ3yunsdJn0cHKc/WkZnt63v
 4G0Qa941QM9vZX6tPtMsiHynMfdqIft/CJWMRymZttjsutAmhf3PqzZ9zTyQ8FfUlf
 EPiaO1LN/D1sREiDysgd7EEI9NA2j/xs+GaqIFjtJG8S+C/zKHwwCQSm2y/aJBGVl0
 w3kwaQke4GZ3v/WyAKOFaX83VptfFXcFwpe5P6KWAToj0Vf4JJ+WxXwBLV40I1+ljl
 J9l96y85dtMjw==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-434a104896cso2712315e9.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 00:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732523559; x=1733128359;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j4kQhipfvrzl6OQgB5ZLytvy8jA/07wmnTWvULyNvoM=;
 b=KvbWJggn0vd07QuxRGLpLK4OsVazcbNP0yZE9TBRY8gCiPEQ3hceZTNIm36v4Xoiv1
 5yVaJ79Ggi6hM/iibnR3oPr+0FcL8+M6dLh43SyKqg9KYj7gzY6YK+ScWjyw6Fm731hl
 8tt9p+Ov6CrkPshoEJ7S/2xbm/s0coihkfn4gn8oaLIkvjMybFcClVwFHIwSDx+1PNAk
 0q/ofaPOhbHaGMx0trUhS80TOgy2hZPfa9Ua3rSg1zKbUqKbizEitVw/VRvBw59sMIe0
 l/LkEoLCTMLYrpH3aW4VPSjMFV+d78tk+leJI/Ux9acARNtSvcbKwI6VvdryVo+dfVX4
 m3Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1Tu+xs7Xgt8IRaQaQHMvprhrVI/864FldORAEQ+evhh6lVusVXRctnfMlfuAySrSubreI1/8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9i5L0VpLtK+dvM6kfJYkpDaoUBNsfmm9Rut7eLKs/Ddh2fdtO
 DhfdDdrUeR4fH82WZyPQxJmz49CHnMrSnAJ5DkD9ETgFqnCwIs0Nr6Ts9CIXUJvubZJFs+1BzxN
 t6BqEN20wqYTKxqU3OEct3aIk7hYEXpWttWvcUnJse9hACoMYGLNPbPWTA8Hr8PubfPA=
X-Gm-Gg: ASbGncuUFY/UUhkdnI2eFQq5Q1zoc7qm2jQpJEIKWbrHWWhbv6KrwoysezjFmETa8tB
 Zm39M8cn8onZs6y74OEx+xv+sMBT+qbGL8cuf/7jHjuXn9xAi7rOc+YoqCfN840kUdIMmR0gTt1
 05yLlOIUyiUAMaeHh9c9sSyEkC3N6mcA+gSJxWKU73okwrjBSxx5NG52M3HWhEphtbVdBmtq69+
 B3DLHb8nB5HErRQCsc0qbV1g3pEmmrLcngDLgyQt5dFZDSedUy/Sz798+r2RQptGyjQmriReyL+
 Izy4LLi5u69BgWsPvGS4MtLESoCskKaZZmikiVhvuO+oYA==
X-Received: by 2002:a05:6000:400b:b0:382:5030:7b94 with SMTP id
 ffacd0b85a97d-38260b57df8mr10276053f8f.13.1732523559194; 
 Mon, 25 Nov 2024 00:32:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwuWVWSmafGL+KOFY0SNwOZ5X80dEzf98sVYUmkBfaqCZ/3QlQ2CQPKreVpBlFRuYpnsRDmQ==
X-Received: by 2002:a05:6000:400b:b0:382:5030:7b94 with SMTP id
 ffacd0b85a97d-38260b57df8mr10276031f8f.13.1732523558774; 
 Mon, 25 Nov 2024 00:32:38 -0800 (PST)
Received: from [192.168.123.30] (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd04ef5sm9642035f8f.111.2024.11.25.00.32.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 00:32:38 -0800 (PST)
Message-ID: <b5c8c6dd-fe41-47d8-b95c-9963eac67c88@canonical.com>
Date: Mon, 25 Nov 2024 09:32:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/14] net: wget: let wget_with_dns work with dns
 disabled
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org
References: <20241125005814.236669-1-adrianox@gmail.com>
 <20241125005814.236669-2-adrianox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20241125005814.236669-2-adrianox@gmail.com>
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

On 11/25/24 01:58, Adriano Cordova wrote:
> This was marked as TODO in the code:
>   - Enable use of wget_with_dns even if CMD_DNS is disabled if
>     the given uri has the ip address for the http server.
>   - Move the check for CMD_DNS inside wget_with_dns.
>   - Rename wget_with_dns to wget_do_request
> 
> Signed-off-by: Adriano Cordova<adrianox@gmail.com>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
