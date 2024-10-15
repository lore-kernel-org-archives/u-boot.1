Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76B0CFC263
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 04:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F654892F5;
	Tue, 15 Oct 2024 06:12:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ge9OtVBF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22958892ED; Tue, 15 Oct 2024 06:12:57 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B228589292
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e6d988ecfso991869b3a.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728965569; x=1729570369; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6/qWvY3zsbniUXgAq7VkqYdwt+zpCX8P4lzbMyCQ2yw=;
 b=ge9OtVBFpCrDKeKu3utm1XebzonA+z7wYYvfLgPzGfy2Fg86DjxyzGiiG/+TJz+idj
 tq3kK87Korn1W7skCc4lQxquuttZGd2Rs8xdwHNeGW/ExsUt3qfOYgRi0fV4H+uHtY2q
 2BiGu4m8FAdwcLS+LDteez/KH6ojBxOIdPbUkJx9mdQbkfWVML4/6gw476hZvjLU2zAN
 jDCwpsQcgY2zLjyb0iVZG3y/CcNvU92cv5tCDk50A1cPFgEPXv0+cXg7VarjGUsX7Gb0
 Fk77UXQ20S02M7YCm1n/m7eTWekh0a+l0Sba36jmDUbBq1wV4gqycKRzvjsyteQTIAa2
 8QDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728965569; x=1729570369;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6/qWvY3zsbniUXgAq7VkqYdwt+zpCX8P4lzbMyCQ2yw=;
 b=gSAyrog11/x5KqA/v9ivNW4CZfec3Zfj0kuMV4FosTLcmmlKovEqpxsTeOSM/0akt7
 nSkI/Bf88t3fAgf9TKz7qUuUMkrNHbeFsvLa2Vh0Q3EZk3nl4KIUKTNHPiUcbO8XgKFv
 X/gsHK82vRMUbKivgY8h0/Q92b6YfHSsmlhYfaeH2eYaCJqFQVI2uOkgo2oFXbS9RvwU
 39Domkuy4ST2iVW0XM0znxHqwkqEsBpxeV8jWY4aXQLdcJe/tcot50MYmPwIQ3U6PERy
 XAPde3Wsw0Pxn4LQ1fIjNyAGkSxKzzpzq0Hqm6D9rz0iOacb4wPcBGHaF5S4fpdqF34P
 qFog==
X-Gm-Message-State: AOJu0YzuCW8pu+hjYCY9Dw+qlSgNXp8GNReCO9betNHUPM0+l0EcZdYh
 FkPEURYvhx0oFaY0QJ7gCb5YrjnklkZl+jeClerDEj0lz7N1W1to
X-Google-Smtp-Source: AGHT+IEDFe1L4ZacOiElP7FCwTXE/ZElDF3mhNOJvBfUW9dvoDObXaWXLV8Ih6NiUghbCE3BXe4S4g==
X-Received: by 2002:a05:6a20:cfa9:b0:1d2:e458:4063 with SMTP id
 adf61e73a8af0-1d8bcfb26cbmr19563002637.33.1728965569125; 
 Mon, 14 Oct 2024 21:12:49 -0700 (PDT)
Received: from [192.168.241.151] (sp49-98-220-86.msd.spmode.ne.jp.
 [49.98.220.86]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e77370a83sm353586b3a.5.2024.10.14.21.12.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 21:12:48 -0700 (PDT)
Message-ID: <6e914339-3590-4898-a151-9091dc7fdf68@gmail.com>
Date: Tue, 15 Oct 2024 13:12:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [2nd RESEND PATCH v2 0/6] mtd: Make sure UBIFS does not do
 multi-pass page programming on flashes that don't support it
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1727399650.git.Takahiro.Kuwano@infineon.com>
 <20241010173236.GA3699035@bill-the-cat>
Content-Language: en-US
From: Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <20241010173236.GA3699035@bill-the-cat>
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

Hello Tom,

On 10/11/2024 2:32 AM, Tom Rini wrote:
> On Fri, Sep 27, 2024 at 10:18:05AM +0900, tkuw584924@gmail.com wrote:
> 
>> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>
>> Resent after modifying commit message in #5 (mention Linux commit first)
>> and collecting A-b tags.
>>
>> This series is equivalent to the one for Linux MTD submitted by
>> Pratyush Yadav.
>>
>> https://patchwork.ozlabs.org/project/linux-mtd/list/?series=217759&state=*
>>
>> Changes in v2:
>>   - Fix an issue in setting macronix_octal_fixups
>>   - Rework fixup hooks
> 
> Sorry, can you please rebase this on top of current master? With some
> other related backlogged patches now applied this doesn't apply cleanly.
> Thanks.
> 
I have sent v3 based on current master.

Thanks!
Takahiro
