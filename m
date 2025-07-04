Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD2BC83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 12:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1082F82F03;
	Fri,  4 Jul 2025 14:02:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vAg7cNe8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9054882F14; Fri,  4 Jul 2025 14:02:21 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FAAE82A76
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 14:02:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ae3b336e936so168527166b.3
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 05:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751630539; x=1752235339; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dZDdeSjqyLuscfYNu3VDDbHM/VLPAI2uu7F9LJm6YJg=;
 b=vAg7cNe8gRXVdI+uqvfubnFE8EW3fu1bMoQlu4fkeENh8+sTK3fkR9TWMfhNsUOvP+
 jzLnnUMMO9xt1ZbhTEYR1tSbh7zcntmfg34bjM9yTdWDHr6rWONLBXCtpoUm1AEF8f0J
 XmmwS/KRGge3YA4YPOcx0py0knsZOB4XYgv9o5TP3Y/t4/vOgoEpR9h5nRNn+x1vfyDu
 zqsXZRcj4GUftLgi2g6s1U1l5Obf5D0DEATWCnic4NS6kCY30mymE9HgzhjpJGTYKItJ
 gnk2C0iZLFtE0NnL3AteM7d+w222jL3BQ9KRoBa8oHnJuWtI1VLBKqNAw8b5uuL4Zxov
 t4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751630539; x=1752235339;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dZDdeSjqyLuscfYNu3VDDbHM/VLPAI2uu7F9LJm6YJg=;
 b=Hc42clCwoiQJTXCzmGxK/8A2Bvs5WQuJ31pqV3xP7zOMoZZX+MBPSjLr1Olj7ZXtvj
 qPXiJA2sY9q10ChqyctLRJ9iBPv83aSU0tAz1JEo3yansa0S1cjuWHNxJzkHCZ5202cR
 KJ4hLa3Eq2TjjBbNxcZab5jE9GuzoF24qnm8zl0IEEbD4bh2896jFWyjk9bW8MXZLrPM
 Jvr9g+XuWjlj3gyy8K0IToEm2RPbJ9biLp4KeN8HbQwD5/Evqk8wE4HZ+w6hQ5ocGcyv
 P/MMkQ1u0hedglYEbie4VySy1zxWFrxkbVo9nFHt5F1yjTKvACGdmco+1OrXHALhFIev
 2rtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOn3I1HtZF47INJ4t6e9qNAUlZ4mNUv/KkNsOzgq7GiNLJyBB59TyEUJCwNsZA0yClipHSE3s=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6MNxHTXUihpNwfeLsWIhWEk3vloIEePvS+pe3jMg9k6fJLEzx
 We4H3PPqAFVX9mwpEFVtwMbRAGL/y80WASRl3CIPCtMeGMR4NeiNTqqiyLUkvuA3HAY=
X-Gm-Gg: ASbGncvvkp3pKlUq30x+V48mKX+42uiepBs16/KlaDm0JosGDSg5Hgc3VuoqInUiaiN
 te5+N8H1aRq3UpYOI9C5bvpFlzzTxUG9ByL8tqmWWzkn/37Om5xCWSWCdsv5UzzUfcUvYlIzrbj
 Q6sXvBiTjllB7hgktqo+QrqQDTqHrulw1FLiHLFEWOcCyYlYfzHliqQkXvPElPlX5Y/1q99rS+Z
 2PLGhEm+sArWfAx3jT26R4NWs+/BEBUyUGhqp1e2ms5EHUyWt0+vEUytFeTjL+aY02bZkIBhVvM
 RKPdIUaBKMWNcFtfxdUuOyrnd44M1V82NKQgooXvleFjQc4L5es++V/jsNNtI55pkP4Q32ZM4cV
 ChYXnRoANLtHDmHlERznGNTTKxiuzVgKlnoUHZSRpRA==
X-Google-Smtp-Source: AGHT+IFDhDWIzenQhVOyNmR5YETY1+2V4pMJxon1swqZX9i8BaddtRcPJXavLQHLa5zAaKEb1OLCcg==
X-Received: by 2002:a17:907:8693:b0:ade:316e:bfc with SMTP id
 a640c23a62f3a-ae3fe5bddffmr158561166b.21.1751630538806; 
 Fri, 04 Jul 2025 05:02:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:713c:93e8:d764:c0f8?
 ([2a01:e0a:3cb:7bb0:713c:93e8:d764:c0f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6ac36c7sm164503866b.91.2025.07.04.05.02.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 05:02:17 -0700 (PDT)
Message-ID: <96cd2cac-2ba2-40fe-b54e-21a37e69c19b@linaro.org>
Date: Fri, 4 Jul 2025 14:02:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] Static initcalls
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Otavio Salvador <otavio@ossystems.com.br>, dl-uboot-imx <uboot-imx@nxp.com>
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
 <CAOMZO5Dhs2GRgvjDCBbwsxxZadsVCrpXaWm4qToYfpak+CAKuw@mail.gmail.com>
 <CAOMZO5Bjxx5tjj75Bo8A4WJWBnV3Q8h1UHK45_xZgOavig0C9w@mail.gmail.com>
 <0b7fcdb0-0d18-41ef-8607-cf060ce3d058@linaro.org>
 <CAOMZO5CXyVyoDEUhFbtaHxi=QDp2uqn1U5ccBq6W8uoEipeVxA@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAOMZO5CXyVyoDEUhFbtaHxi=QDp2uqn1U5ccBq6W8uoEipeVxA@mail.gmail.com>
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



On 7/4/25 13:37, Fabio Estevam wrote:
> Hi Jerome,
> 
> On Fri, Jul 4, 2025 at 5:33 AM Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> 
>> Have you tried the master branch recently? Hopefully commit 410d59095a9f
>> ("arm: kirkwood: fix freeze on boot") should fix the issue.
> 
> Yes, I'm using top-of-tree U-Boot, and this commit is present.
> 
> Unfortunately, it does not help.

OK. Then I suggest adding a debug traces to the INITCALL() macro to see
how far the init goes.

Thanks,
-- 
Jerome
