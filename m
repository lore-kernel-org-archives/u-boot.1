Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9641C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 19:04:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A63D8860D;
	Wed, 29 May 2024 21:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kSSDgLyi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7E0488658; Wed, 29 May 2024 21:04:03 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F397F88652
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 21:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a635a74e0deso131566b.0
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 12:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717009441; x=1717614241; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/Os4+frbVCkY9GCBSTlAcrgNPIOcknJcWyYNFEVco10=;
 b=kSSDgLyiHlwcp7Z7Dat3BhZhyLOo/zBVvMc8sW5UF8IOwfJTyizKSiXO0TbyUqRAol
 RueZVHKmvispJAOzY+yre21fm22Q6nNC4VZKPHT5pVwXgoI8XJatJM2naT+3+Hkdt2NU
 qz8bnCq6iw2N5gm8hJtsmARMOf+/ShZevXCTqqgchR3fEVFI1x/JMbSZjrQEbm3gEgGP
 O2MaLDp+KPY0MTe7zyqoa1R7SnqHF3JzASz2qGBMqlbS6tR+7EnsQxrfcm7kkqkwSl8e
 9BGkxgXGW1ckemC+cIRez64uvDS6BRi0wQhkg22Y13MAk8GwFM/VKyoIi92xsJzbse7t
 YZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717009441; x=1717614241;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Os4+frbVCkY9GCBSTlAcrgNPIOcknJcWyYNFEVco10=;
 b=C7dEXax4iovq/xVFJmUZ68HK1tvOh9Z9fEy+DocSAUFcwohaVnHoORdLSYS2aUuD/4
 XrgWDnkD480XolykrU3F9Lrs1cYfbRiPrkJxRQHm8V5atzi736McissG+sj2q3vjZ/tO
 YWpOF6EHI2Y4ZkS6FQkAu10ToIQk3Ctot9gyXoqqcBKU8bK8W8a0d5xidCAHp60fy/o8
 x3VDtN9J5yGw9rrfzb3GY1/beduqiifzlQEY1pMP1ZZh4Ifts7wdmC4pwVYg6gK0nDdv
 kKGECZLacGS1O4bH9aHImrYMu37cM9Tm6zu9OjaEP1MvjMJ0b7V+k0kQbIeKR+qSL3Oy
 CI5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg/yQGc9OvXGYHmv1fr85PYVQu7M2KZNUV1YhgyaVpQuZ0HywFRvi0Fp5rT8sQrgCkg9MYt0ADmD5IjWTUF4C2GuPS6A==
X-Gm-Message-State: AOJu0YwHEaDSR+VAVzHQUSkFuMt9xH4P+GYnhlLk6Fl9C9b0JLGRWyWu
 ThfDOKeY0vboFGZJL/IXKODL8eTgEyxCUIUZinAUgtqLjhp1WFBu/qqHVONJ1jYKMbOrufFogUx
 Y7Q4y0w==
X-Google-Smtp-Source: AGHT+IHlGiDUzkgOUvT2QHbwKgiaYNcvhcRiHsvr0BGSL9lmNtnYZd3o/hojWMrMTe4N3Klvx+kdJQ==
X-Received: by 2002:a17:907:1382:b0:a63:5421:85b0 with SMTP id
 a640c23a62f3a-a65e9215827mr4942766b.75.1717009441335; 
 Wed, 29 May 2024 12:04:01 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8bb3? ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6331c86c76sm235398366b.44.2024.05.29.12.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 12:04:01 -0700 (PDT)
Message-ID: <b10fbb50-18fb-4483-a90a-22ec11db94d1@linaro.org>
Date: Wed, 29 May 2024 21:03:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] efi: CapsuleUpdate: support for dynamic UUIDs
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
 <CAFLszTj8vfZVW+0YPqcg6ST3MndW=mFJkOz3dJXuFb=P1HP3kw@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTj8vfZVW+0YPqcg6ST3MndW=mFJkOz3dJXuFb=P1HP3kw@mail.gmail.com>
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


> 
> How about using the compatible string, instead of a GUID? Is that possible?

Could you elaborate?
> 
> Regards,
> Simon

-- 
// Caleb (they/them)
