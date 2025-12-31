Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6EEEE645E
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 19:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4872383D62;
	Wed, 31 Dec 2025 20:00:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ASUUMn5Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5D2584131; Wed, 31 Dec 2025 20:00:24 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A12383D1A
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 20:00:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6575e760f06so2877295eaf.0
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 11:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767207620; x=1767812420; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/aSYc6HKTQoVL2i0a7eIydVGJ3T43HE1SbfagG92p8Q=;
 b=ASUUMn5ZXdxSpEfolAitYehdQYFUS7lymu5kLaxHW35K+AFgUb+GYlkyE4sOKZtOGm
 vBIl1J98H0iKtojeMKkYCDqvUyZoTXP63Xp1SMpOefmsR3zeeJskRdMUkyxBD4jlXAL0
 Pr/zQwadVnDvl2RCjKQEb/7scWhFely1vc7+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767207620; x=1767812420;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/aSYc6HKTQoVL2i0a7eIydVGJ3T43HE1SbfagG92p8Q=;
 b=JdICQnC8gboTEFIzVpry2NyKXrWzsiSqKRrMtQo+ITs3cuswJDqCIVUthkGTT4O/35
 rYgekVwc9wB1uDnJKtdB5rgmklsEWtEnIT54UD9/39KfHq6YKhW4byXyjok8SDioFzfP
 ruBIT5NRi9/yCuumLY7/6gH5jiIbCeUKPTmmFDZC6EhY3mhFMYgwJLaMjfnNIIZccq99
 JTD95FENNwXvOhYqWrCzoDyPZgonLgbKFIAElRUlo5AZ09HskupK8h+m/08svP0loW7X
 2JOE2DdVZi+rc7zMqJLQMEr9m9j/ThvFBOKshxt2IPCB+h1jJJVs0WhUaWh21jPPkAYW
 ZNmg==
X-Gm-Message-State: AOJu0YypViZbVqPsPm15PL2N8IT6ul7+qCsyrLCvTvf21n1MM18xrerk
 RkBse5l05cLaL8J5O70t3RTpz7VH3qk8cSCt2rXaU0YLktVxXL/VxViLV2t3LCjBATI=
X-Gm-Gg: AY/fxX6Oay28jtqqMLvtYLTr9Ua5Ch3psq9xg0zqpywgFWXqHrLawNrpbF7Yf12iyCc
 nZhCfJg8CJblv4XchJ2PG53xeoRgA3DAGcTxZTdqpszy816eImwaFiWsj0fTlU6vupydkHD4AwL
 Y7//fISFqNFjcWZo0bP/WZIasl9ceS6BCDf/Ez/cWTd6KrvvtKrBevn0AEb6ZfJSU59HhEfTFE8
 nPqX2zcSxSoiv1mvEq7Z4oSEybx+4ZYemU19JjYswmEP9825NWLtl0GvelTeF+fvdG9kQgI9pLv
 ZLwLU1Vt9EY6JCxPk5o6nY7MGKBI8OohbbtFuKFxye6HG5ePqff980/YMZhXDXncPVulgwT6Zqz
 0OvBS/Kl30gV5+rM57WdbWHb29qMB4fDZGi9fazGlJGhPGWBqxA0T+m/lQnKrloETV//fGh1gKx
 f7gWRX7Qsk0Napgb7i89uyaRikEHfxOgFLNtElbCKcjI4eNb8lwZYrUdrZfDBX5GMzeDfjahUQY
 JNvPuA+MhZyGMdjS1xO6ichJz6HaNzrfacqtQ==
X-Google-Smtp-Source: AGHT+IGT+VghxkNCahQJDvKps7eZBcJ/PLLDN0AH1+p/Q7JSC1CvWxuMAUAl5jRnpEn6B/CH5CcYHw==
X-Received: by 2002:a05:6820:8319:b0:659:9a49:8e82 with SMTP id
 006d021491bc7-65d0eb53f84mr9838736eaf.82.1767207620364; 
 Wed, 31 Dec 2025 11:00:20 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f69b9e9sm22099392eaf.12.2025.12.31.11.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 11:00:19 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>, 
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251208190635.2044082-1-afd@ti.com>
References: <20251208190635.2044082-1-afd@ti.com>
Subject: Re: [PATCH 1/4] configs: Remove default malloc length for K3 R5
 SPL
Message-Id: <176720761951.3066473.8280878361087035040.b4-ty@konsulko.com>
Date: Wed, 31 Dec 2025 13:00:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 08 Dec 2025 13:06:32 -0600, Andrew Davis wrote:

> These values are already the default, remove them from these defconfigs.
> 
> 

Applied to u-boot/next, thanks!

[1/4] configs: Remove default malloc length for K3 R5 SPL
      commit: 0082756320d713c412d6df13c0a3be9b29cf7496
[2/4] spl: Kconfig: k3: Increase malloc size after relocation for R5
      commit: d2bd9ee7de35b80092e1abaf8feb576dba25128f
[3/4] spl: Kconfig: k3: Set common default for CUSTOM_SYS_MALLOC items
      commit: 6de07498790d8af3073be3a73dff918e410cff66
[4/4] spl: Kconfig: k3: Set common default for SPL_LOAD_FIT(_ADDRESS)
      commit: dc1c7526b1cb64526601d81f70a87f57aeac1e9a
-- 
Tom


