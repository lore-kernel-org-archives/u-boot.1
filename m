Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8850ACFA466
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 10:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C3C083BF1;
	Mon, 24 Nov 2025 11:18:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yMxp6DNO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 115FC83D77; Mon, 24 Nov 2025 11:18:54 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A72E83BEF
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 11:18:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4775ae5684fso19120935e9.1
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 02:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763979531; x=1764584331;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sbMHdwGnvaKbiSo/k5VnGYcWFQYBw1+Z4stdpSOLkYg=;
 b=yMxp6DNOUAxwHZbS96uDgGmQjlbGNY0hSRiRY0kdVkMpDIJ+IWWXhXGRsJyVRtRtYt
 piihYyVS0jyJ42BKrwxOY5UcZxxMOVwHqk3wsu5rgaSGzGfL1Z9r0ll+2Lref5zzY2N7
 oN77QDkwVKJVSpSxLaNDLrnsRsTwWb+yCCGYHXjZHTK+EoSBClWAfpSmQAmZoYqBaEga
 XIeJR6OY4juhnq5EezVvdgW6vEZEQUu+JQBsQnIFxsXNscKTb7Ff+Ne3V2m1iIw6q/1F
 tvufMCUBcZrugsKYBiLqBBl0NNYpkUyZUhS85ndbGgEQDcPwkfZNleFFhJ77UqpW+9bH
 0F+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763979531; x=1764584331;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sbMHdwGnvaKbiSo/k5VnGYcWFQYBw1+Z4stdpSOLkYg=;
 b=ROSxDHjVq4QkfTvXY6HidlIG40g7wABq9kOW1ezQkVxL5zsk5x1du/yL/zOSizQBUr
 E83vTqKlazO7E0j62uFWDMi7vDcrVB+cs3dp8z6WQkuPSc4Wsv3fDu/56Q0x5IJGAJDr
 SjjCUJSrt3TZJaAmqEgm4YlD5eMUa+vfiRxvIJud4D13H1fDHD30homYIYEU17VckmEX
 XN6ddoJhb2wmLnOxr4319R1xQ8T+YcH54pzNVavTTStLNn7301lxih9EIuhPXmca+AHs
 7bmw9deCCqPS7uzk/KwN8d9od8Aaw6ykXB30ukcpep+PNBUF/brROedXzMSFQ+5ibOxr
 pCUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIgajfqoBwR204Qjei6+3N1e54PwKEOchmAEjir0nu73tf1Y3h4SKvv0NTtN4ZixlEl1+aWow=@lists.denx.de
X-Gm-Message-State: AOJu0YzjXtK446mmuTImsrarkvPddjyfUIT/Y2HzkoA0w7nu3/a0xFol
 4vgpfRp14yJhTziICUiA23W/NF9X8rOwdjsx+h7dh+75qbNVBiaUX4bOBJlEbnLl4o4=
X-Gm-Gg: ASbGncuJOlGsCSzhVXqlb6VEZCz97ctbIanuSxaSsXgcYd/SdWweS58Uon4sng+1FJn
 hrBDuVZJY1Kyh6mZDONt/EkZfzxXDZyP1oh8xf6+Ux4oNMB60eRMJd2coRJgwrMFZ/MzDnw8Skd
 ys1xqYuEQ2RmbJ82cgc6y/vbHBdNjGGfN1/bXceR8/LI1OtzzW/PEc21u/ZH9G31iG3VlqllENW
 /W7EIxSuH+DTQUIDg7BppjWe1foIFEQ599w1ccKyjsMzR+m0jaZO8Nvzp9xSo1TBOuUxb1lp0zl
 s4vswuT/ZEPGD61tv+rhyOZ40qVysVZxayXcIAaKa3lkGOiXbdvrJz9WVwwC/C2B2cHgLhlO2cY
 j1hm2QP/hQoyHc67D4vgKG9b5g3olHImZgFhLg2GlNhz0zbe2MRjzMbHC0PJBVymoE1YWuQIusG
 mHamlUnP3aN2ojw1Gf1dqvZdbYB4r3sN8ry67VKTCaqQTgvQigicdkx7a6Jg==
X-Google-Smtp-Source: AGHT+IH8UhXrIVSTIWFedrN/clPpZWL52oMweNfvNdYf3eNw+9nGSWIFgtWys2ydPPDnepCordAbuQ==
X-Received: by 2002:a05:600c:3ba3:b0:477:aed0:f403 with SMTP id
 5b1f17b1804b1-477c110d91dmr98872225e9.8.1763979531299; 
 Mon, 24 Nov 2025 02:18:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e50:3860:d26c:ecfc:3035:7758?
 ([2a01:e0a:e50:3860:d26c:ecfc:3035:7758])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf226bf7sm197575395e9.11.2025.11.24.02.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 02:18:50 -0800 (PST)
Message-ID: <4fedf15e-703f-44de-a5c7-8a945b4ce543@baylibre.com>
Date: Mon, 24 Nov 2025 11:18:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] boot: android: Add sandbox memory mapping support
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 Nicolas Belin <nbelin@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>,
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Maxime Fournier <mfournier@baylibre.com>, Eddie Kovsky <ekovsky@redhat.com>
References: <20251114-bootconfig-v3-0-a28b813dba90@baylibre.com>
 <20251114-bootconfig-v3-2-a28b813dba90@baylibre.com>
 <CAFLszTijms9CB_C1sb+A1LZqKigsQChiBu=vnkDTKtiwbOotmg@mail.gmail.com>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <CAFLszTijms9CB_C1sb+A1LZqKigsQChiBu=vnkDTKtiwbOotmg@mail.gmail.com>
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

Hi,

Le 19/11/2025 à 14:17, Simon Glass a écrit :
> On Fri, 14 Nov 2025 at 08:28, Guillaume La Roque (TI.com)
> <glaroque@baylibre.com> wrote:
>> Use map_to_sysmem() to convert header pointers to physical addresses
>> in parse_hdr functions, and add proper map_sysmem()/unmap_sysmem()
>> calls in android_image_get_data() for sandbox compatibility.
>>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
>> ---
>>   boot/image-android.c | 41 ++++++++++++++++++++++++++++-------------
>>   1 file changed, 28 insertions(+), 13 deletions(-)
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> It is sometimes easier to do this in the caller and have the function
> just take a pointer.

agree if it's ok for you i can work a global rework of function link to 
android boot image parsin to simplify it after this series.



Regards,

Guillaume

