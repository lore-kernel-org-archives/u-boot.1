Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0677C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 07:50:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3042A81F66;
	Wed,  7 May 2025 09:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PCjSAxHz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 643878007D; Wed,  7 May 2025 09:49:58 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F2988211F
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 09:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac2af2f15d1so904994766b.1
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 00:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746604196; x=1747208996; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yMnPgmtQPdOlR1bsY25tDqIACgfE+etSaZwgRMfR8n4=;
 b=PCjSAxHz7eWJ/dOpZdY6GqiQRvJcp2d1QFXab34mTMkcX+zUTiXetUjfoINLR8dTei
 y9mdwn57zJ0CoONNK9TKSZe416VQs3sihenfJNCYF4YSWE4ltVhZglvPjTcuK2jnX9WY
 U1/8tGwCmCFKcd+sYK7fBYKB0XnuW7M123MQKIa2u3B+fWQNCNaL8istjNHFDZr/XPsx
 Lswvc7pt1WlXbXojRQYpGXYvq1A/w44Y8BZvZ7dltfR/0ELXCdgsRxjcR5X4DDmkoCY0
 taqvVERp/VvEwgccZD65wRWmJDi75jooWcMukj2ryaSZa9CQkxPc/O6FghNr8dQbs7NB
 F53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746604196; x=1747208996;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yMnPgmtQPdOlR1bsY25tDqIACgfE+etSaZwgRMfR8n4=;
 b=haiaobFdXY4jrq49EX707fScAyqx6/wgmRFU6bgp8DEjWpZEfnbO96ct6Wgvu/LYZP
 Iahizcp0Plq69cbXd0JIEhsk4bvpAJM7hmGQy0soEQLikCnpraNbXrFeD6MAKvAfVJ6I
 fOlJ7oSUE2kHQRifU+UtGHPrB2v7E0QCt544/XXQZdw/mBUDrXjvWl1sJbxDrKMUdb0P
 MXk/ujuoxqSIR2NrmdAgaTI6N2drysoC6fpXWQ0hD/MfIOcoM59W+59wRYtkHw6wUkJh
 3ToG+nFtBPDjA4GGSKlzqecL/u/jLp1FLs/Es2MMx2UvUupJ+yobtkASSELs/T4/SDoI
 4Zcw==
X-Gm-Message-State: AOJu0YwrD7GioxdWSXmVtAOAgLgeKSR93LJcMIk7X78dd7xHczMlu/S3
 J05ibTDE1RIU0Xuop80sGkes60nGclmG9wP+EFjIC+MVh/qoMxotKLSpNBEZg/1ex7XszXAzJwK
 c
X-Gm-Gg: ASbGnctWUdPM5IaIPupIqyL0x/WCvChU2eSSYuvoNd4mypJCFr1djbro1IwnwVbR26W
 4rIfLjz4VGafU7KYk9NbbWj9I4sEc1WUOl4aK3DCbfZHzIJxnCbWscgzUS+f6iEBmlXE2br2+MC
 RSqDwnydrBZHrrWYAKiARSiyHjbyZ40rmc7KYqnx/AAzd3+3sLKSPmUr1VOAOHw86+tM5aX+nDC
 nSx+2dwGT3EZcigXhykdmUpjOsofLTfYB5MHvAyNvnTqAoMgk/n3BCyJqVp6A/ckwP5yYeRrI4/
 1SLkaiY/D3x1z26QMXtvJMAcepRjy55XCMDwcOMW3sNjV9ZV
X-Google-Smtp-Source: AGHT+IEJpCMJeeHGi/mgwOjcOhagvo+CHV+RuSxraxaOqsG5FhbMttq98+ifCMwIBZkt+z5lG/BBsQ==
X-Received: by 2002:a17:907:94cb:b0:ace:c59c:1b00 with SMTP id
 a640c23a62f3a-ad1e8b9c96emr154596066b.5.1746604195961; 
 Wed, 07 May 2025 00:49:55 -0700 (PDT)
Received: from [192.168.0.32] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1894c01f2sm847885366b.119.2025.05.07.00.49.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 00:49:55 -0700 (PDT)
Message-ID: <31db15a2-045f-4c21-b487-ee36e670f12b@linaro.org>
Date: Wed, 7 May 2025 10:49:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] watchdog: at91sam9_wdt driver enhancement
To: Zixun LI <admin@hifiphile.com>
References: <20250428-wdt-v4-0-bb7d1c7c051a@hifiphile.com>
 <1be04cd1-5de6-4cc4-96cf-9c90b9a76df1@linaro.org>
 <CA+GyqeacBi3+ekgqgbq-D1W-1FY=gwMO9zQjk8SFmiSF3P=-6g@mail.gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
Cc: open list <u-boot@lists.denx.de>
In-Reply-To: <CA+GyqeacBi3+ekgqgbq-D1W-1FY=gwMO9zQjk8SFmiSF3P=-6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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



On 5/6/25 16:02, Zixun LI wrote:
> Hi Eugen,
> 
> On Tue, May 6, 2025 at 1:20 PM Eugen Hristev <eugen.hristev@linaro.org> wrote:
>>
>> Since you sent the patches apparently there were some changes in the
>> tree, and now smartweb_defconfig fails.
>> Could you please check and maybe resend ?
>> I was ready to apply these but hit this issue.
>>
>> Thanks,
>> Eugen
>>
> 
> Should I rebase it to any branch ? I've pulled the master 4d3b5c6 but
> haven't met the compile issue with smartweb_defconfig.
> 
> Regards,
> Zixun

I apologize, it was a mistake on my side. It works fine

Applied to u-boot-at91/next , thanks !

Eugen
