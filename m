Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AD3C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 08:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCA8B83678;
	Thu, 24 Jul 2025 10:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qI6uuBDy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D597483692; Thu, 24 Jul 2025 10:56:09 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C288B83666
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 10:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-60867565fb5so1307060a12.3
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 01:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753347367; x=1753952167; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3BvKZpbbg0p5wvmuIFYf3a2Yn4OfIx/qUhwJcciN/M4=;
 b=qI6uuBDyDFhrmPJUpX2a2AVtyQ/mcoyKEa5/0NocQkMzEdhxrxq+YhjDp2wiGQpCcK
 2OTJQNClcPxpvofRvOstqs5QWZBcOyj8ihJBhsER0dCh2vFyIGARBFkNt1hBKlwb+kMc
 w/Og6lUb0lvKL+wgRmrcLCPL33mKQIbey9rrtxKEG5gMk0jerkBgwDGCFuyp/X9ne1IH
 4HoMYZfeUo0iPcDc/c8UbXvdgcHh3HvqElWTIerfnTMTkySuYCAcZnBCfiZPp5/vERfL
 teYX4uInUuHR8nQvToSAePxEl5oaUiG+W7DqUOYDUHWJMSE6JHTq4gCYCBpIqHGgZYJN
 8HHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753347367; x=1753952167;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3BvKZpbbg0p5wvmuIFYf3a2Yn4OfIx/qUhwJcciN/M4=;
 b=SkkavzhLBrDTn/ETA8KICEqEyZdBXEyXUOlEjpzaA6NYtEiBBLBEGChPpU1jDycMTc
 Lu8uUb9ssaSCNnC8ebeRuu1ut+o+H6nBLVIYiOHs0SCRgHJ4nRlYkf0Gn4Yr9uZwPdyM
 JoPsNq2tdlBfgOOx32KJievASCLN2+7SV9okqmB5nWiXnThaKM5p1Botp9ophAwUqF3V
 1hWafMn8Uh/CG42u0PFKrkaycd9MBhYQjUfd7TyqVEXsjG1LiKsLufuTLDTiJXx+oEE4
 pHv8J+hVGmkoZc2P/DxGe4rfDanw98E6nOXNEwNoz7km0HJ3PU6q8NByaxslZE7nsv43
 BiGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVri4OabMv3DtwKK5ZG7PvUe4mHxL1oCj+Pp00rN5p39fwU1Yw3Cbz+oA1kqpEM0LuueuSLrL4=@lists.denx.de
X-Gm-Message-State: AOJu0YxBgswLLKoPo72czz92OQz/fVCEjTqrRKUyBiiisW1LUTOh8rE1
 nDGjVET+yb86BD4zLRxaSi6kEFoW1AiBJPCQdJl0Bt8Hsi6ERAM0le9RjTkG1rKRWyQ=
X-Gm-Gg: ASbGncvivntHT+smSwX4Vx/Mt11XszAEhy2AuWuM+lbVzgXzveEhMuXZcWhHRppxuye
 8It7cq/zTs2taxhNYUyi+yq2wdQSfcdBUBUu8gQNAgqOR01JwFgQbtEQgimvFXerpzVhWxNG9kb
 xQ3i2zDQsxoCvevFr1DcD3IZw/l+EVRa0JDSHGvpbKlrpZjf7zloRGE39xOqds1vXrRSpMyleqp
 bAMkK2N8G4OPuhSdIW6a3oIAu4LPMTTUPzqdOnfkSv6e7a6vaB5XKS0OOfyTsXS1y3rU4IuVnAs
 YzVou4+1BmDxCv2TZAeiBfgMZmjAg69PyGStBwjCCzccUTXD/P+5rQWkoTe/cWtmmGp1ClmNRZ2
 dkMCKqqYjKgOWE/6Ntk11Fnv40T6+A9r86wClBwZgCkRyCHohktk/smdi3ln2QhxwzsgNjLqDVN
 Y0xA==
X-Google-Smtp-Source: AGHT+IE9GhJBsETnWSnyGFUHLQKLdRyaDN/ayYIguMqVn/O6svZFMgiosNVOlXXkR++8k7BoRssuaQ==
X-Received: by 2002:a05:6402:280b:b0:607:ec18:9410 with SMTP id
 4fb4d7f45d1cf-6149b409efemr6354676a12.3.1753347367063; 
 Thu, 24 Jul 2025 01:56:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:494d:b001:252e:8716?
 ([2a01:e0a:3cb:7bb0:494d:b001:252e:8716])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-614cd31df62sm584256a12.57.2025.07.24.01.56.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 01:56:06 -0700 (PDT)
Message-ID: <ab9334cb-9479-4542-a571-2e7b41f31f07@linaro.org>
Date: Thu, 24 Jul 2025 10:56:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] binman: bintool: run 'apt update -y' on first
 invocation of apt_install()
To: Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot mailing list <u-boot@lists.denx.de>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Leonard Anderweit <l.anderweit@phytec.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250724083433.57867-1-jerome.forissier@linaro.org>
 <20250724083433.57867-3-jerome.forissier@linaro.org>
 <30423767-dfdb-48ea-b708-e6a21c75cbcf@cherry.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <30423767-dfdb-48ea-b708-e6a21c75cbcf@cherry.de>
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

Hi Quentin,

On 7/24/25 10:48, Quentin Schulz wrote:
> Hi Jerome,
> 
> On 7/24/25 10:34 AM, Jerome Forissier wrote:
>> 'apt update -y' may be required to make sure that the list of packages
> 
> The previous patch in this series is swapping apt with apt-get and now we add apt back, can't we use apt-get update here as well?

Indeed, that would make more sense ;) although 'apt update' doesn't
produce any warning. I will update the patch.

> 
> Cheers,
> Quentin

Thanks,
-- 
Jerome
