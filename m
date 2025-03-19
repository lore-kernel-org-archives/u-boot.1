Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B08C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 10:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF5DB810F4;
	Wed, 19 Mar 2025 11:44:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y6d9TOlQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 329BC81101; Wed, 19 Mar 2025 11:44:08 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCDE0810F2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 11:44:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3913cf69784so5636305f8f.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 03:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742381040; x=1742985840; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jMC8UL5znqQJa9bO8VpI32TmVQ3vQAxKisiTz070UPA=;
 b=y6d9TOlQU6Wt+q5bAiC2pjzwp5dROEZZmFvDUirmQxSwZkwmXycZyRSesBEABKN4gY
 tqjphbWFpvBLm26Khjb8er98lDDwz/NFB8v9yHTyu8wxEXfQidTc0BNd692MP/lid7d6
 vUFAXLka3gbYTCLeSrO3rqfwJ4k7VpeUXWyn3bpSJsvRSivuGyDn+mEPrJYVwx+uV2F9
 W04PFdkUmMm/EuMzNAFLELaxVdPe9nmPtwcu9/RY2R7RtzA1SxEcHmFNh/GhElb6ix3U
 n2AMyBJRaORgzJOpe4XIzfo/sU1w7rss/42aVo09ILUPrdj5/4NM9VPlH3UT1JAeX3Oj
 mcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742381040; x=1742985840;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jMC8UL5znqQJa9bO8VpI32TmVQ3vQAxKisiTz070UPA=;
 b=V0nI5SHLZDgcdjvhzFl3MFGYnBVqBint8u4T8J8sNToGYtGJliqAwcs3PQGYgMGREQ
 nYH88pRcWjG2nKWpipLO8zR5eCWUGs8S1b/h8yV9dB+n4gHSqJ6B0L8diegAgVeLR8lH
 zHcZXjRimQa8AYJKEYpdzsW4jTVOl1ZpmK/MkKr1OH6ZaYbpxbpvJX+nk6dB+NVcutqy
 uRhVssxAFlKI1EKhOOgfS0t9OoAxmpshzU2yfpAHdo5CIlAljoBDaiICp5+uNioOfHxH
 55qhKI1UNBJux1g0miH04q1+qgddlsafIGxkSE+H7x2i6fA+dAhVYX7MiGVoV8LAelDz
 UPXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdN6fR6GONkn1UmQbbReC6Fm/xsEJeM6obylFRWlIgV94xFAFDzA/oeWRG7RFvxYDcXRcqIZU=@lists.denx.de
X-Gm-Message-State: AOJu0YyYprk9xqbb0m9BK6BU8QcrMA/egHH1yCA93lbFnv9neMgWj/5c
 y9hSUW4inqRgTA3gX+Z1McM2mKQQx+pQ+Lm7jojqu4vUNvvhWajNhMK7Vyyxau0=
X-Gm-Gg: ASbGncuBc6pc0rzoCNW4Hy/hu7U1Pfof3UCiko3J/8nhC2RIEHLH94AYSnKf3oDm23z
 GDLdQyTNE0b/K4WJi5cY3A3maDPSHMR9rXbWC2EsYTIdwBS+XGrcdu5qTwar/fLZctrvTDdNxb6
 I/NZnXssAE3UEch6TatNB3auUKQujDG4p1UqYaIH+nmybheUC9HCKm1MF/fFoDMr2FPVylWhLYh
 y4bUB6LU5pJ1F8y67wMS6vIVLPoXpRneo8Fv3qB9v41GXPUazsvePMsTo0K9K6/nc6757LPTCLF
 nnqIgyqIDL4LjOWkj7kDx0p6RbCPRqz4iJeWa9kipV8pZityRbKj1HyW0DBqiqiawPRcuxMT/KA
 GJJDkqN+NhR+KcB9jJqtde5ED
X-Google-Smtp-Source: AGHT+IHFpjXNQc3ScGqdLCtj/9qZAr2sz4CrAS/yDPf5/0LAAFKA+SnHkpG/vyOE3WIIfwmgB9eC5Q==
X-Received: by 2002:a05:6000:400c:b0:390:fc5a:91c8 with SMTP id
 ffacd0b85a97d-39973b28597mr2595107f8f.53.1742381040086; 
 Wed, 19 Mar 2025 03:44:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6075:7d2e:e833:a01c?
 ([2a01:e0a:3cb:7bb0:6075:7d2e:e833:a01c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a5fsm20957942f8f.79.2025.03.19.03.43.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 03:43:59 -0700 (PDT)
Message-ID: <e6549ff5-b2dc-4e32-9a6b-c18ed963945a@linaro.org>
Date: Wed, 19 Mar 2025 11:43:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/14] dm: usb: move bus initialization into new static
 function usb_init_bus()
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Dragan Simic
 <dsimic@manjaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20250318104659.1114340-1-jerome.forissier@linaro.org>
 <20250318104659.1114340-11-jerome.forissier@linaro.org>
 <95cadc8b-2922-4bd2-8a0c-8ecdb5885bed@denx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <95cadc8b-2922-4bd2-8a0c-8ecdb5885bed@denx.de>
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

Hello Marek,

On 3/18/25 13:20, Marek Vasut wrote:
> On 3/18/25 11:46 AM, Jerome Forissier wrote:
>> To prepare for the introduction of threads in the USB initialization
>> sequence, move code out of usb_init() into a new helper function:
>> usb_init_bus(). No functional change.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> ---
>>   drivers/usb/host/usb-uclass.c | 88 +++++++++++++++++++----------------
>>   1 file changed, 48 insertions(+), 40 deletions(-)
>>
>> diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
>> index bfec303e7af..cc803241461 100644
>> --- a/drivers/usb/host/usb-uclass.c
>> +++ b/drivers/usb/host/usb-uclass.c
>> @@ -287,9 +287,55 @@ static int usb_probe_companion(struct udevice *bus)
>>       return 0;
>>   }
>>   +static int controllers_initialized;
> I'm afraid this won't work, you will have to track the controllers in a list somehow, because it is possible to unbind DM devices even using the 'unbind' command from U-Boot command line.
> 
> Also, why not simply track the controller state using DM in the first place?

I'll keep controllers_initialized local to usb_init() and use device_active()
in the second uclass_foreach_dev() loop.

Thanks,
-- 
Jerome 
