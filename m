Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA4CC25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 21:55:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ADA888210;
	Wed, 29 May 2024 23:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="II6sfceD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C91987E62; Wed, 29 May 2024 23:55:30 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97D1388652
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 23:55:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4202ca70270so2990595e9.3
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 14:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717019728; x=1717624528; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CGlSnVWzLskKnPco0TgFnEzSwCRXIHy5AArOzS4Nk1M=;
 b=II6sfceD7GtHd+guyfZvnECvrcs+FjOz2LcgyUN/A4bGUSOvJ2SXbXEBvGCgBPBF3T
 /HC5MoELytQMFm16nnhAw+yZfMD+9nA6xLL6PVnoVONyGGcWDJkbgMRsNmuEz4jLTMXE
 cjPCOhqVER4AkdATkm1Gp0F9dWIsKfIwPGB8nS0slYWOQH4MJXNwYc9m74EHQKeg2RW8
 bC6PT3Mn4b5T0Yiz9NgNztIXnZG5ospttqrQLQxJ2CcjsS/X0zaZ01nQm71fkdJ4VFK6
 s97yqhxxPO8zmfOub+TSNh7oL8ZKijXE2GRAyvzaNW4oOx1gomJDpcSulXDFc2tY8Djz
 9iTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717019728; x=1717624528;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CGlSnVWzLskKnPco0TgFnEzSwCRXIHy5AArOzS4Nk1M=;
 b=vitAKBtSk2EvI2uLpFz5HFjbDqmHn8BoJmTlqvwScE1Tqbv/Dq7xnJCt/vmCbFkZnC
 JfdgkkyOaRa20JdFH5c9j0dLj4GF9l4SXMjkgyjIayz08jo+rkYxp+Oq0zHZNDQxs0UX
 SLnap0ZCwaW3e/Kv2mhWpdcqVDYDWiudiLz7LQ6Z4B0YY5iUIpd39Mp3Y7xub19slbij
 SPn+su2bsb9vfm8ermNhYDtBqzzBf/7vm5HIQDtfR8MriRRwczodzdHdmw/6AmJ4TmL0
 +zi4yboQEzeaKKYHuSBUxJlJ3c+R6i/y4NUTUPlpdHwAQ2GDKHUdIfEAznqu1w4O6fsz
 6TEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPQ3Xu8Lz9f9WS8woe7ha4vECjSM51nukDtJF4ggzPqEa35YiaejNd2ARk9lG/wnVT64oIGTjh8mqOzwv6c87IvnC36Q==
X-Gm-Message-State: AOJu0YwKLGeh/j7Vbr9EvF+HKG1s80mg9N58SXrgcPTV43PuTReActUg
 E/dod2TVgxnXtrlj2DGLMSb9hQDYf2KcJVOEH6JZ9kQoErC+rg5bZJrKGq1WFQA=
X-Google-Smtp-Source: AGHT+IE8Wx3xG+Xrf/lw3/m00due7mH8hsN0ULVbuE0ki3r6g6ECUCpECBwerDVsETAp9GZ2cItp/A==
X-Received: by 2002:a05:600c:5102:b0:421:212c:c963 with SMTP id
 5b1f17b1804b1-4212781a4d6mr4192755e9.20.1717019728011; 
 Wed, 29 May 2024 14:55:28 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8bb3? ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6590d02e53sm72776166b.119.2024.05.29.14.55.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 14:55:27 -0700 (PDT)
Message-ID: <f5b6c004-81df-4fab-85cf-764a29d8285a@linaro.org>
Date: Wed, 29 May 2024 23:55:26 +0200
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
 <b10fbb50-18fb-4483-a90a-22ec11db94d1@linaro.org>
 <CAFLszTiMjvPk7m9h9RAEPfxtL5B1sY-Y7-VbCEgbjEhL+jat_A@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTiMjvPk7m9h9RAEPfxtL5B1sY-Y7-VbCEgbjEhL+jat_A@mail.gmail.com>
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



On 29/05/2024 21:49, Simon Glass wrote:
> Hi Caleb,
> 
> On Wed, 29 May 2024 at 13:04, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>>
>>>
>>> How about using the compatible string, instead of a GUID? Is that possible?
>>
>> Could you elaborate?
> 
> Well, the compatible string (in the root node) is how we normally
> decide which DT to use and which machine we are targeting. So I am
> wondering if we can somehow use that, rather than producing a GUID
> from it?

No, we can't. The GUIDs are required as part of the EFI FMP spec. We 
currently hardcode these GUIDs per-board (meaning if a vendor productize 
some board they need to make source modifications to replace the GUIDs). 
This series generates those GUIDs deterministically at runtime so we 
don't need to maintain a big list.
> 
> Regards,
> Simon

-- 
// Caleb (they/them)
